Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 841EFC433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Apr 2022 03:53:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 026F210F0F0;
	Wed, 20 Apr 2022 03:53:37 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2049.outbound.protection.outlook.com [40.107.102.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AB21310F0D7
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Apr 2022 03:53:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I20iFlUwD6AQY8Q3Tue/gj3Iqp++Ns38QypzZT5i9qUH3MNvDlkDbRk3XhtGMb41Z/FQ9au/qoMYLuUBylZX7xxvouK1X8eDBEfQ4A2muFzueHrJuiOfafkpHL79XD7HiBEYc0OkHwxohpcGHTB4MOwsRjIEKN2p/ytWtfF6mWRR2VmKgFAvirashDNY08MEaiYJ7nSaVBYtujSTGxvZ+0HIjjb1w6TKAiyJzicoHXt0KbwKe/+ae5YqHJGq9WLbAUQXZ6gBMOSOkngD5MbNZSpTolij93TkAQ0MUooZjAZsTgef51K+ajbn5dxZ2XZk/v42AsQ2lIZ3stmRQ7VzmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xuGunxej8KVPXhnl63jLgAXgLUOMbMPHnlgtlMM6KV8=;
 b=JAe5FiaHXodOO8EN4pyrCg+PXNKBTUpYadMPEK9Bm9bAKGHXCy3rvJklwzRQ3/8Zt05kzFVOoUTCMmuTM6FvzsbtGlB0tlB3fukgtk02fg2EHyqfQt+sgV0mXaTyo6UyMOW9ZBIOSCRC7HxIJep92Xf4jRnql3hxktyrWpOheOzUcDunJ4o1B10m1JQqVm3D8vnd6yel4t1DWAyy/kKB+nQSitGn205TzrNumyUKlQ+QuxdE7meR9jGmnSmO8foDc6cRayskXf0dNNGxfGS/Vonp/zRYAMoyYQlBSHIDUUIR2GtFUIAIhR8eVG5qemL2sbG/IyGrjollPzuTD7UMYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xuGunxej8KVPXhnl63jLgAXgLUOMbMPHnlgtlMM6KV8=;
 b=BuZspUsg9+FRGbdBMREFemTi6j9FiRED+o/q4t64LRcBn0G8YDipB0i0LVXOjnAqE7kCq76rjRQd702pbYJxpJBb/foSvNHuBxwTMfas3d7+4ZuajpwR+96nTA4ZOSVqbfiK8dozWpsje0PThCM2A7rWkBApRYEwsDZOpCWiGQc=
Received: from DM6PR02CA0077.namprd02.prod.outlook.com (2603:10b6:5:1f4::18)
 by DM6PR12MB3483.namprd12.prod.outlook.com (2603:10b6:5:11f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Wed, 20 Apr
 2022 03:53:34 +0000
Received: from DM6NAM11FT067.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1f4:cafe::b0) by DM6PR02CA0077.outlook.office365.com
 (2603:10b6:5:1f4::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14 via Frontend
 Transport; Wed, 20 Apr 2022 03:53:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT067.mail.protection.outlook.com (10.13.172.76) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5186.14 via Frontend Transport; Wed, 20 Apr 2022 03:53:33 +0000
Received: from taozhou1u2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 19 Apr
 2022 22:53:29 -0500
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <hawking.zhang@amd.com>,
 <stanley.yang@amd.com>, <Lijo.Lazar@amd.com>, <Mohammadzafar.Ziya@amd.com>,
 <YiPeng.Chai@amd.com>
Subject: [PATCH 2/3] drm/amdgpu: add RAS poison consumption handler
Date: Wed, 20 Apr 2022 11:53:16 +0800
Message-ID: <20220420035317.4008-2-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220420035317.4008-1-tao.zhou1@amd.com>
References: <20220420035317.4008-1-tao.zhou1@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cbfdfa6c-b0d1-4947-30da-08da2281573f
X-MS-TrafficTypeDiagnostic: DM6PR12MB3483:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB34831D95887B31BC02453F2DB0F59@DM6PR12MB3483.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2IHvj2Qi0aDKmhoxdL9k7VfWppklo9b0iDk7xuvgn7c+92zb0RpSN3HJPEj66Ior8KIYgtx7Ow7n2dquioOO+P0irbGXFKel+mKdkRdm2K1et4kmDSoyJ9FkND2Po37pcPpRxI2FT0aitkqVQFBVUWTxiMT5SRuiQSA19QFsd+oGO7wXGy0uAUKyo4pFFswnZo4LQrgQHYmMAEEFUGJ2l7SK3q67A4XuKH15aPyzvP8EnslNLUXBfERyeN1QXTZ/gZV2peroceEUPOQO+fWKlZBzpnCDXiJ3FBhia9SR3ZFSdAjMz68sVYOZrp5RMWOo1DjervdNul3WAW8CKYaEFZ9D1NWLWlaNGOUH1jINtKFVmKLCbHYIDKxotXjXZElkqJ3cP+UcHrsEUql6etJpxS/RXVo/HY3Urofw/uv5y1uC1DbrI0O3LU8QP+4Az0cT4/LgMnHP8tDqAyeNSjTwYND0TRkcVii9hKrEnG7XkEvsneBi/2Ux/EIIVMz60Z5pP2yn/ib5TKiP5vKA7cVY9giSxB9SQMe7qq73NW50UsiV2k6uSfzJH1430SWvOjA3nOPGK/goaUluQbQ8vvsrlwgeJN4uWKkTPqCuSKeyNXd61KxOegrfkBPZYt3gozv8ahT3qtyvE98tngeNmGO9iHgXToUhooa0c14R7nlosgRPcNmh/tPWtj5BMO5EBPftG3DQxLLM1Rkf9TD4xWxrX4+hubHvJjluWVZQNIlaVPtoa+FTlOK31baBFKlvcVw4
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(82310400005)(26005)(2616005)(426003)(186003)(1076003)(4326008)(16526019)(6666004)(83380400001)(36860700001)(40460700003)(47076005)(2906002)(8676002)(7696005)(336012)(356005)(5660300002)(86362001)(36756003)(316002)(8936002)(508600001)(6636002)(70206006)(70586007)(81166007)(110136005)(36900700001)(309714004);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2022 03:53:33.5293 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cbfdfa6c-b0d1-4947-30da-08da2281573f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT067.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3483
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

Add support for general RAS poison consumption handler.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 43 ++++++++++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h |  1 +
 2 files changed, 43 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 2d066cff70ea..4bd3c25be809 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -1515,6 +1515,44 @@ static int amdgpu_ras_fs_fini(struct amdgpu_device *adev)
 /* ras fs end */
 
 /* ih begin */
+static void ras_interrupt_poison_consumption_handler(struct ras_manager *obj,
+				struct amdgpu_iv_entry *entry)
+{
+	bool poison_stat = true, need_reset = true;
+	struct amdgpu_device *adev = obj->adev;
+	struct ras_err_data err_data = {0, 0, 0, NULL};
+	struct ras_ih_data *data = &obj->ih_data;
+	struct amdgpu_ras_block_object *block_obj =
+		amdgpu_ras_get_ras_block(adev, obj->head.block, 0);
+
+	if (!adev->gmc.xgmi.connected_to_cpu)
+		amdgpu_umc_poison_handler(adev, &err_data, false);
+
+	/* Two ways for RAS block's poison consumption implementation:
+	 * 1. define IH callback, or
+	 * 2. implement query and consumption interfaces.
+	 */
+	if (data->cb) {
+		need_reset = !!data->cb(obj->adev, &err_data, entry);
+	} else if (block_obj && block_obj->hw_ops) {
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
 static void ras_interrupt_poison_creation_handler(struct ras_manager *obj,
 				struct amdgpu_iv_entry *entry)
 {
@@ -1563,7 +1601,10 @@ static void amdgpu_ras_interrupt_handler(struct ras_manager *obj)
 		data->rptr = (data->aligned_element_size +
 				data->rptr) % data->ring_size;
 
-		ras_interrupt_poison_creation_handler(obj, &entry);
+		if (obj->head.block == AMDGPU_RAS_BLOCK__UMC)
+			ras_interrupt_poison_creation_handler(obj, &entry);
+		else
+			ras_interrupt_poison_consumption_handler(obj, &entry);
 	}
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
index 606df8869b89..c4b61785ab5c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
@@ -509,6 +509,7 @@ struct amdgpu_ras_block_hw_ops {
 	void (*reset_ras_error_count)(struct amdgpu_device *adev);
 	void (*reset_ras_error_status)(struct amdgpu_device *adev);
 	bool (*query_poison_status)(struct amdgpu_device *adev);
+	bool (*handle_poison_consumption)(struct amdgpu_device *adev);
 };
 
 /* work flow
-- 
2.35.1

