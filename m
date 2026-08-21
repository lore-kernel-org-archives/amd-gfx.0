Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1D89C5DF7D
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Aug 2026 03:44:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1B27310E251;
	Fri, 21 Aug 2026 03:44:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ayCejfLG";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011016.outbound.protection.outlook.com [52.101.57.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 163F710E251
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Aug 2026 03:44:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KVPuRQTC3r8NIg9hqvpj1dQVDYYcFN8LBUn8NjGZxZ7TnpF0GSBh9U2zDBObLFCxMo0vL+N/AfpZzkx4eGe//05zTQK6s+ZW9jxqtVcp7MZzJ8X5nNjdkiu5eKl6h65zqRlCgTZ8RZDLR1U1isZcgGvepzbQln5vlVT31JHQJ2GAi33ceuLe1oJtNGHI0LXD0ncWuO7ksFHaGUvSYzgMPrnvxLjlxrMcUxevXcWWE21abtKLIwVpx7d31GwstfWHDpzP8UqCSNGL8J+7NY/qjycbAB7Ht9cyPMfiucj7PpygnQQAD3u3Rk+unvGlOZaUPVGqttuj0ndfrKbQlK1low==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sY2Qm7yUyDrEhbfHB8NUiK5txvq6+839dbBsSLWO/24=;
 b=qMgj7+FRleX5XMA7UYixwPhXAUmRyU47d/xCbQQeKn5K6jJnY7kH4C54tnOcrT10ulQsguRr4nuNiBnuuiGr6/mN3x/1CwplrE937arDZj0nOI0zZaDCiQTVcnUw+V1Y0TuEqIJKV/13W9L/wEDNcWEKsZsnXV2mNS6wmjiu65af92wMyqRkesHy/j6c8qd9OxcQGtKdcfQ4KHoWWu+TbJAn7Lny/6H6xcQkrWLngG6mRMiSL03B7LityGl0eKTIwU0NTxliYhCPoCPoAkbVCJ9ObEM8VAesBC3VFK9c4q2QvNQIaKHzQ0orM9mxgJXow8vWYqIxTnLlHkX9wmPpiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sY2Qm7yUyDrEhbfHB8NUiK5txvq6+839dbBsSLWO/24=;
 b=ayCejfLGd3wXoMAoyB/CGuyfVR42M9yzB6QjTftFXt0QY71CAxyfrxJC1TmNxG+QesW7RJ64eq9eJ4ODjdPanB9pqn2+F3CvnTv8OBJT4Aj2aLn3sW44Vc5B+nqV3nZEbaVL/e3dqRk5oaUWg9KikGDZH7RiyMvFQqLP8zaIgTs=
Received: from SJ0PR05CA0055.namprd05.prod.outlook.com (2603:10b6:a03:33f::30)
 by CYYPR12MB8655.namprd12.prod.outlook.com (2603:10b6:930:c4::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.10; Fri, 21 Aug
 2026 03:44:24 +0000
Received: from SJ1PEPF00002311.namprd03.prod.outlook.com
 (2603:10b6:a03:33f:cafe::3d) by SJ0PR05CA0055.outlook.office365.com
 (2603:10b6:a03:33f::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.3 via Frontend Transport; Fri, 21
 Aug 2026 03:44:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00002311.mail.protection.outlook.com (10.167.242.165) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Fri, 21 Aug 2026 03:44:24 +0000
Received: from liuxiang-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 20 Aug
 2026 22:44:21 -0500
From: Xiang Liu <xiang.liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Tao.Zhou1@amd.com>, <Stanley.Yang@amd.com>,
 <YiPeng.Chai@amd.com>, Xiang Liu <xiang.liu@amd.com>
Subject: [PATCH] drm/amd/ras: keep the established socket id layout on older
 parts
Date: Fri, 21 Aug 2026 11:43:58 +0800
Message-ID: <20260821034358.1487515-1-xiang.liu@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002311:EE_|CYYPR12MB8655:EE_
X-MS-Office365-Filtering-Correlation-Id: a7477b75-8dae-4b9d-a763-08deff367e14
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700016|23010399003|82310400026|56012099006|6133799003|10067099003|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info: jcWugNUxqtdRH0LYSRD0dkswaQ8pyVh/TBNgAMV/8Qvo/X7UfAC1NRwMn+R5Ce70P5W94bhYFHxCVrvIBaNgDQPOtSRGKbo+QqntjtCcMsaGyYCDiUkLR7j7A1X/w5eGRyj/5w725+jfdnHKpbLA0upkbOVErGa3d5Chy8UVtcM+CDE1CGwwmD/zcdMT+F021Gf05I8C2hM9wN9duvHNchzhxQ0O/2pDV0Npj3I79tefPCkER0bbMPd1P7AlDPZ8aTd/b+O8ewMm3DmC/9yNxa3jNA3huhjsq2KES4aOF4WXTenQvb0uxwd5pX17eJq+aK1CLGRmzdjV1ErmaLxRkZpTLiGxVntO2b8eJ0eJq3/khQOue26+ENTvVO9CkSFBDMUS9lWx44JTSeu/JH1btv77oS8oWrV2R9p4CZF1+byMH0zMU5mDomRacgkOMHr68GBppwfr+0C3ScgBHkuxo+8MWwLwcKK3xQs2THvynNbtAfGRW3zTN7GHFgG5eKl8M0mkjGinNHpyjqtrkCuBpm0zL1l8n0Tg7QGpraHGIrpIRLf6hrMNpcRyPegYGo1QJ366deqOW1YmXfDZpO0fs+cfyyLmmzILqtF3Si44sRSlP8mgyTvy8c7usH13LPo9zzAbzYW4P8ieFOam8fY/w6J6pA7xMHBBw5+xxJXCPPJHDU6ueXrzSQvVgFuBxiuf6QcQW6iyaTBraAheZFRR/g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700016)(23010399003)(82310400026)(56012099006)(6133799003)(10067099003)(11063799006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 57a6AZdI8ywr0Ex2PLUB//pE61cLzNNW6vx33+afeALd2N7yyA9DIyF2PDIFGEWUdogpn9Y2gqqeiiv/YjXT8sUjTCIJhIJR6h5QtYG484fHkFwPdJb+qC6Qzzuhlh/f4spYwu/9F2oINikdqfcEPo4n8UKVakD3d4c343guqUKLI16V/tVBQI4jP0Q/CitqSy2kbn477zxEkwQMHndzKXXbGxADAakk4SAnZgD/Q/ETJts0F3vmOgh/bZr9ZpoRwrkiPnds1lvBO5XzCs3umk3x11b1P8UvSxBEJ+3gextaWtbizNEdftgB/9MsYHl8yCAEEbhynPTaDHa4HjWj+UWjwRaflKKTEUNmqNACuiOrGnTG7hJ+GGbJH5psM8pBxmSHFjrRf68F9uWh7W2DmPEdABWy3o2LJowdC7C1es8xfqCcn/fnnGN/j2COA0t5
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 03:44:24.0441 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a7477b75-8dae-4b9d-a763-08deff367e14
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002311.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8655
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The socket id is exported through the ras "features" sysfs node in
bits[31:29] of a 32 bit mask, but the RAS capability mask is 64 bit and
reports it in bits[62:60]. Tools parsing the node into a 32 bit variable
read block capability bits instead, which are identical across a hive,
so XGMI injection resolves every WAFL sub block to the first device and
the RAS TA rejects it with RAS_TA_STATUS__ERROR_PCS_STATE_HANG.

Keep building the 32 bit layout from the same capability mask on parts
released before the 64 bit one, and stop assigning the multi bit
adev->ras_enabled to the single bit en field.

Fixes: 6ae383bdf282 ("drm/amdgpu: Support obtaining ras capabilities")
Signed-off-by: Xiang Liu <xiang.liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index d168e5d54d87..34de9daa6124 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -5065,16 +5065,27 @@ uint64_t amdgpu_uniras_get_ras_caps(struct amdgpu_device *adev)
 	struct ras_cmd_get_ras_cap_req req = {0};
 	struct ras_cmd_get_ras_cap_rsp rsp = {0};
 	union ras_feature feature = {0};
+	u32 socket_id = 0;
 
 	if (amdgpu_ras_mgr_handle_ras_cmd(adev, RAS_CMD__GET_RAS_CAP,
 			&req, sizeof(struct ras_cmd_get_ras_cap_req),
 			&rsp, sizeof(struct ras_cmd_get_ras_cap_rsp)))
 		return 0;
 
-	feature.block_mask = rsp.ras_block_mask;
-	feature.en = adev->ras_enabled;
 	if (adev->smuio.funcs && adev->smuio.funcs->get_socket_id)
-		feature.tag = adev->smuio.funcs->get_socket_id(adev);
+		socket_id = adev->smuio.funcs->get_socket_id(adev);
+
+	/* The wide layout spends bits[55:0] on block bits and so relocates the
+	 * socket id. Older parts have to keep the 32 bit one every tool in the
+	 * field parses today, socket id in bits[31:29] included.
+	 */
+	if (amdgpu_ip_version(adev, GC_HWIP, 0) < IP_VERSION(12, 1, 0))
+		return AMDGPU_RAS_GET_FEATURES(lower_32_bits(rsp.ras_block_mask)) |
+		       (socket_id << AMDGPU_RAS_FEATURES_SOCKETID_SHIFT);
+
+	feature.block_mask = rsp.ras_block_mask;
+	feature.en = !!adev->ras_enabled;
+	feature.tag = socket_id;
 
 	return feature.value;
 }
-- 
2.34.1

