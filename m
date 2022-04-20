Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D1EEC433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Apr 2022 11:30:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E46E510F23B;
	Wed, 20 Apr 2022 11:30:32 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2063.outbound.protection.outlook.com [40.107.223.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0694E10F23E
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Apr 2022 11:30:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jxCANWksRnh2NbbNiO0fTargvPMvw1j17J+gkWfZaH2snkmlQVoV0w2UrDk2y326Z9L7tzvDdZnJQJfB7y52VCLxAC+XkiSqUpCjYNjImLAsXCBjEiaqW1Vjj97EGhalNCNyv5hdsChViMhgi+qYkQHi0ye51m5OUGQhlmzQ0BGSj9X6RBaxwBvZa7KxrQRsBcMBRt69bTCbFj/3JWgcJiMX4yRVvwbl4dl0VRIoYENo6hfElrJpEL/YKezjR9eEGMTxAnq6ommm5CPwbiVlEnGSsr19s0aGKDAD2xWDj64kLGA4qZyyQ6YySZ/1g91S6x4RL0NZ18/NCgW1EdbYEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mb9YKdjvHvLRzKaJLDpuYm1dOq51oHIwotzFgtI8r88=;
 b=bxVyDmVM4F6kNX+jO8yaisjk6s7X+7ijBGBnZP6RxUpMUjdKwFeRUoKyg3oG9YiLd7M3NZkdpYw8kuNe7x/efFBd+r0lZDqbqqkE55onRi63mfexPb5E8kgfxAcVWm3xNGO/Q/2+PqYIZKwhu7QypDumyX1KFfBLsvrJewhQLHslQrdTdydz7hO69j/fbBx8aFdmxMiHxO/kKkvXfrHZcLFFuvYHzCsQG5zYWmcqCFv6YCR9UTxVc+HlxktPH5eksf7NlWitX/SBTz08c2Ci+bDu8rHdacNCuDC2IhHG1/j/zD9Y7PIO+4r1Ud0NhNClByA6tIBfGh9zKkwPcoi7uQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mb9YKdjvHvLRzKaJLDpuYm1dOq51oHIwotzFgtI8r88=;
 b=Fn7+KXI3o/JHrajdS84I3M6EMd0Zkhj+OYBC2Yv/e9Lf34VVIj5NUYByj/xxvEka8Yc166f7OLyiwkv0gkzesafNSDAu9ZfNIpaQTQVpeWMesrLyqqzjqIQ/7gE0J/p166IEjzUGtOwZe4TJkxDkqJPE1TrOveDG181M9z9cRWc=
Received: from BN9PR03CA0102.namprd03.prod.outlook.com (2603:10b6:408:fd::17)
 by CH2PR12MB3941.namprd12.prod.outlook.com (2603:10b6:610:28::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.13; Wed, 20 Apr
 2022 11:30:28 +0000
Received: from BN8NAM11FT025.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fd:cafe::e4) by BN9PR03CA0102.outlook.office365.com
 (2603:10b6:408:fd::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20 via Frontend
 Transport; Wed, 20 Apr 2022 11:30:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT025.mail.protection.outlook.com (10.13.177.136) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5186.14 via Frontend Transport; Wed, 20 Apr 2022 11:30:28 +0000
Received: from taozhou1u2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 20 Apr
 2022 06:30:25 -0500
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <hawking.zhang@amd.com>,
 <stanley.yang@amd.com>, <Lijo.Lazar@amd.com>, <Mohammadzafar.Ziya@amd.com>,
 <YiPeng.Chai@amd.com>
Subject: [PATCH 2/3] drm/amdgpu: add RAS poison consumption handler (v2)
Date: Wed, 20 Apr 2022 19:30:08 +0800
Message-ID: <20220420113009.8062-2-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220420113009.8062-1-tao.zhou1@amd.com>
References: <20220420113009.8062-1-tao.zhou1@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f754c954-fcd6-4077-b355-08da22c12b92
X-MS-TrafficTypeDiagnostic: CH2PR12MB3941:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB39410503969054B625FB0AD7B0F59@CH2PR12MB3941.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OtPZvCQ/2VOMDIt8AK8JVLSmrzeK+Dn7m0rk6COKwtQ6wwck4AKA4flDOZTxuBpgympBstpwdJocqKhzE3LPwZFuQAHVPcbd/5jSCRhU+t6Hzi6PDTxaMsQX+xWXbVk17r9h9XFZc4+1d8k++CI/fQxDMPfmvuE/ewptebNtACQND9Akthpw70ZrepRQlG5nvVPwbUuxr7Yo+cJrC1tHKjznu6qWMdcFtkVS4pIpS1+mz3dO5D4XK8Rvuhd8GwaTxYgcDX5F9ilFbvZA12zRtvFhDIfzraSO4b3TJ4tQiDpzO3mtC8K5t4OCXNmam5RHwnAT+32q522A4NQrHT1Ved6qgkV4Gw3OCg7fY4f3wgEKE11RtyOx+1yrxJ5pQiNr2ta73sTS89f689Pm/u+mwupxW4DEFoas6acgctiIoHbX3vW4wl6lgDvwiOX8CF0Ev7piNl5DAbtaEDGAoaYnIttOcISXKZBK+RrrKRRgKGH4V2bZgHeYuOLNvjl9yIFQMzkVj8PkeyYYLLLtx4U1bhzGR57qDv3BK9OiDVEgHvqYebnM65NShp3nwaCmqvPATJi2DzQUvSzFGrt6KpmHpB1CwtI5+X4dI+8d+o0yZZNXbP/MGH0Zzz6NZzHyBatceuT+Xt9rnFuJVbn777SFMN5UN+GVblRgOSObXu7etFK9yrUM/SYH+eZKbj9brk9wUNrZ9Mu25+R48OUZ2P7r4g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(70586007)(316002)(6636002)(356005)(426003)(8936002)(336012)(86362001)(8676002)(5660300002)(110136005)(36756003)(40460700003)(47076005)(70206006)(4326008)(6666004)(508600001)(2616005)(16526019)(83380400001)(7696005)(2906002)(186003)(36860700001)(26005)(81166007)(1076003)(82310400005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2022 11:30:28.0944 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f754c954-fcd6-4077-b355-08da22c12b92
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT025.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3941
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

v2: remove callback function for poison consumption.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 34 +++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h |  1 +
 2 files changed, 35 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 22477f76913a..ad3b8560b2ca 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -1515,6 +1515,38 @@ static int amdgpu_ras_fs_fini(struct amdgpu_device *adev)
 /* ras fs end */
 
 /* ih begin */
+static void amdgpu_ras_interrupt_poison_consumption_handler(struct ras_manager *obj,
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
+	/* both query_poison_status and handle_poison_consumption are optional */
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
 static void amdgpu_ras_interrupt_poison_creation_handler(struct ras_manager *obj,
 				struct amdgpu_iv_entry *entry)
 {
@@ -1567,6 +1599,8 @@ static void amdgpu_ras_interrupt_handler(struct ras_manager *obj)
 		if (amdgpu_ras_is_poison_mode_supported(obj->adev)) {
 			if (obj->head.block == AMDGPU_RAS_BLOCK__UMC)
 				amdgpu_ras_interrupt_poison_creation_handler(obj, &entry);
+			else
+				amdgpu_ras_interrupt_poison_consumption_handler(obj, &entry);
 		} else {
 			if (obj->head.block == AMDGPU_RAS_BLOCK__UMC)
 				amdgpu_ras_interrupt_umc_handler(obj, &entry);
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

