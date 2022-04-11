Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FBE0C433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Apr 2022 11:08:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0C03F10E277;
	Mon, 11 Apr 2022 11:08:58 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2079.outbound.protection.outlook.com [40.107.96.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1FAA710E277
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Apr 2022 11:08:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dlLeD1RCDOEuZIa5kRvUhQ26vkBCYc8d2kcttT886Q0d5y+yXr4QQTTpjVT1l/bcmB2S3DC/8pIHsUbM9CJeB/bqJeYA5Rf9VELkvbRaHBVJudAE3y7XzXKTeFVubfAh14P3PVpMVGVLGqbw7vEmcYxOhWhyN0oU7+f/U032CToeI5hFXaznW7fBpSJTul2WsLx0Yjsw0HmFjCjD1wtJO/rF94Rcj10LKEI+xB28nMTOh5SEG6830Q0RnMbAAlkkTSydHVpUffYHAqonJObHD20zUNnRSkf+8rcMVDp6tllDdNtCn7SgtUN/jzmlSG+dy4fICa3W8KvRpG1J9yVWNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CiY1W+v1W52mJfDYd3lWPLljgw65EkU8oe6SZpkvPhA=;
 b=EAsF0fS9ehCn3U72e8uY8DL+RK/4/P23NRGLpAPfDskjwcZiEdb+JVBHKoZHybPyK/nZxQwIbmeEIDI9vn4icJpPGas3qv1a0Z4KV7aqqNd2NUSiaRHxpmD/KkDvvxhERDaZxUqa07bTI4AzjQ2j/KrbY/aYT2UZnGXE+spF0yOUWSRDezh5SqYJmZ0alj2pw/nvpqcqF0H1xXLH7oN3lY14o186BLcQDs3o9NlcS4N/7Z1dow0F/W8KLUo5J9KUh7kpOHd5u0B+cJS4YbsVcnGblN/To/pDyfS202dos+C8CzCLIsI/IpHr16vu9LwkypZuNQyIpAzTCFvNTzY4Tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CiY1W+v1W52mJfDYd3lWPLljgw65EkU8oe6SZpkvPhA=;
 b=1rFH1M7V+FQ8xH1cWQfernkJq4jR8QuV8nPi/Fa9hZm39FbtKZrm917cgzbDO7MxjHDJFWnio/m4cn99gvqXDdyfomnJwx6xesnSyvUAw2GBTUwXXrf5EKFxxr1OfsskLMq3ACQC3tozdG6DS9XZdQvJ4hxMdZIdJkoGnEFa9xA=
Received: from BN9P222CA0014.NAMP222.PROD.OUTLOOK.COM (2603:10b6:408:10c::19)
 by PH0PR12MB5679.namprd12.prod.outlook.com (2603:10b6:510:14f::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Mon, 11 Apr
 2022 11:08:55 +0000
Received: from BN8NAM11FT032.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10c:cafe::f7) by BN9P222CA0014.outlook.office365.com
 (2603:10b6:408:10c::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.22 via Frontend
 Transport; Mon, 11 Apr 2022 11:08:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT032.mail.protection.outlook.com (10.13.177.88) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5144.20 via Frontend Transport; Mon, 11 Apr 2022 11:08:54 +0000
Received: from taozhou1u2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 11 Apr
 2022 06:08:52 -0500
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <lijo.lazar@amd.com>,
 <Mohammadzafar.Ziya@amd.com>, <hawking.zhang@amd.com>,
 <stanley.yang@amd.com>, <yipeng.chai@amd.com>
Subject: [PATCH 3/3] drm/amdgpu: add RAS poison consumption handler
Date: Mon, 11 Apr 2022 19:08:25 +0800
Message-ID: <20220411110825.18808-3-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220411110825.18808-1-tao.zhou1@amd.com>
References: <20220411110825.18808-1-tao.zhou1@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d30750f7-6a91-4624-8982-08da1babaac8
X-MS-TrafficTypeDiagnostic: PH0PR12MB5679:EE_
X-Microsoft-Antispam-PRVS: <PH0PR12MB56794069BDA9CE8FD9C103BDB0EA9@PH0PR12MB5679.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oCmpYtKibhHKIrHXQJl3t8VNue35bP6dXyBbPR7NV3ZP4CSmfhCPe3gYCwYJ+LkTJUXaqj7RNCDLXBg2ZR0gJTfsdxAwo0BWQw1r8JLBmCunkSb6OktDZh6vjWtEfUbk7UrSVVy429VUCR4isOr4DQO+JxwLo49H0WMf7bPAOQnuzHrDgIzeIAcaa82SBCUrzwOMr5BOFFlBu9N935KDwGCK2FS4hKQgD5iPRw3BxIa1Xri/J/c6mfmUDLskCEmvU5qkEbLUUiHHj2mPZ9vRnmJh1IP5KFn1weAZ2OcL/NcdVEiuCpOSAutBWFEetXBSzd5ytOYOVJfiI2azyvhtPLU6LSAYsCPaijnhWvUSmGWHvwe8tK9T1wh8mrg5ArXKXvbWdIhcbxjwZTL7ZIvckDc3jwL7ABMZ8wdRqmN4ylLlOjL7v78KGYBN+3M4l1SxaCp7780DpdD38RGnMJbGxsi8nBYMj+ch4BG9FPsv4Ulk3iVWnuKfd7M+U/nsavPZFDwm7uoaEzGpdJ5+ixwpWFLU2jAIVEMW/YMBNqq0jWGlpwB+4YJtZgInUpxvJqPfqMMGyYRC76twdstQdpntgz42lePTBph1gh9O3GrQecu5lTFFVXL3xCpAh7AcOQOL0E7DWO5x+lrwSWhuIbq5/bDIQysUbhKpRRo8uoVYG/MICstpTcc1xwZJmu2ZlGMsgdNz5y4BVnlCABR5YDIMeg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(2616005)(5660300002)(356005)(110136005)(6636002)(6666004)(2906002)(508600001)(316002)(40460700003)(7696005)(1076003)(426003)(26005)(186003)(336012)(82310400005)(36756003)(70206006)(4326008)(8676002)(70586007)(47076005)(36860700001)(8936002)(83380400001)(81166007)(86362001)(16526019)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2022 11:08:54.4348 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d30750f7-6a91-4624-8982-08da1babaac8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT032.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5679
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Cc: Tao Zhou <tao.zhou1@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add support for common RAS posion consumption handler.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 39 ++++++++++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h |  1 +
 2 files changed, 39 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 863bc282292d..92ce898d50bc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -1515,6 +1515,38 @@ static int amdgpu_ras_fs_fini(struct amdgpu_device *adev)
 /* ras fs end */
 
 /* ih begin */
+/* poison consumption handler */
+static void ras_interrupt_handler_poison(struct ras_manager *obj,
+				struct amdgpu_iv_entry *entry)
+{
+	bool poison_stat = true, need_reset = true;
+	struct amdgpu_device *adev = obj->adev;
+	struct ras_err_data err_data = {0, 0, 0, NULL};
+	struct amdgpu_ras_block_object *block_obj =
+		amdgpu_ras_get_ras_block(adev, obj->head.block, 0);
+
+	if (!adev->gmc.xgmi.connected_to_cpu)
+		amdgpu_umc_poison_handler(adev, &err_data, false);
+
+	if (block_obj && block_obj->hw_ops) {
+		if (block_obj->hw_ops->query_poison_status) {
+			poison_stat = block_obj->hw_ops->query_poison_status(adev);
+			if (!poison_stat)
+				dev_info(adev->dev, "No RAS poison status in %s poison IH.\n",
+						block_obj->ras_comm.name);
+		}
+
+		if (poison_stat && block_obj->hw_ops->handle_poison_consumption) {
+			poison_stat = block_obj->hw_ops->handle_poison_consumption(adev);
+			need_reset = poison_stat;
+		}
+	}
+
+	/* gpu reset is fallback for all failed cases */
+	if (need_reset)
+		amdgpu_ras_reset_gpu(adev);
+}
+
 static void ras_interrupt_handler_non_poison(struct ras_manager *obj,
 				struct amdgpu_iv_entry *entry)
 {
@@ -1563,8 +1595,13 @@ static void amdgpu_ras_interrupt_handler(struct ras_manager *obj)
 		data->rptr = (data->aligned_element_size +
 				data->rptr) % data->ring_size;
 
-		ras_interrupt_handler_non_poison(obj, &entry);
+		if (data->flag & (1 << AMDGPU_RAS_IH_POISON_CONSUMPTION))
+			ras_interrupt_handler_poison(obj, &entry);
+		else
+			ras_interrupt_handler_non_poison(obj, &entry);
 	}
+
+	data->flag &= ~(1 << AMDGPU_RAS_IH_POISON_CONSUMPTION);
 }
 
 static void amdgpu_ras_interrupt_process_handler(struct work_struct *work)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
index 380f4c3020c7..562e94954650 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
@@ -516,6 +516,7 @@ struct amdgpu_ras_block_hw_ops {
 	void (*reset_ras_error_count)(struct amdgpu_device *adev);
 	void (*reset_ras_error_status)(struct amdgpu_device *adev);
 	bool (*query_poison_status)(struct amdgpu_device *adev);
+	bool (*handle_poison_consumption)(struct amdgpu_device *adev);
 };
 
 /* work flow
-- 
2.35.1

