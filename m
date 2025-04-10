Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BBE4C3601E
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Apr 2025 11:30:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B5A5110E36A;
	Thu, 10 Apr 2025 11:30:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0RVuKNSN";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2059.outbound.protection.outlook.com [40.107.212.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1EAEB10E36A
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Apr 2025 11:30:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M2RcozTAFj7X8gItyNmPrwpapiFp6UHr8gF08Gv1wk8Gp3nZs2uP/P4jo+DksD2QSB3Rnm7tgiRvjqOmKPyB2LQ4ipy3bfVaLBXpuz3maRexykHjlfFgE+6bu/r7kiqd3NYkdSz6ni08zEjCeWhYTpI0cOzEzkxxHsyMkaKoo/qEYU7ozxEJWKpqKYpMuYgptZmGraZgcDyq6XFFLm3gqPhGq7CoipSB2CdnmfWrd+JaPuN1T325VIpwYRWoEavRc1crut1Ygg+dCJLMfeItLsL+Ie2HSdFYBshP2l2HwNYnqL1rFvNSImTMB7CFVWcvUR7ZK+wXkahtqqE1M9auQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IDJTEFDw9jBLU5yEvJGd//3+KvrRTEVV47YfBa53oBE=;
 b=KvIsFc3Qz7U44JRsbM1lnymT8tHNMZw1PEm1ber5IY055dxUmU+peyDHuQ4O4i41lo9UXm42E6lQ0iF/Q+6NI6irZ0H94UeTH8U92CXFLR3w2uzyhWogVcNeKS1qqhazwF6NQwPL3ICOv+f2kiklWzTelODVs4JujANWFNybUSvuckzkOM1qwNWfpbfKjHx8F/kWCR24xqKQtd3OKQV8FyfmKJphXeJmk9sj773Qcbc2eBvQRiiW2UTNxq745hD2rKrTBVOE5Pn4Sq0cxxY5avIkD8mpQ1Be7iChyC+Gq5FO7hj9CRznf5x2LA3ZB77b1ITv+Pue18O0Fa7gL2iNIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IDJTEFDw9jBLU5yEvJGd//3+KvrRTEVV47YfBa53oBE=;
 b=0RVuKNSNOHPUej5qiBKwWHDBok6ouM1+Z+l8VA45WzfieSe/QpaoxUJNkPAgfIlZasWzX3FivDW9oaA+0nNI8pC4moG7M2gPV+RPKRNm6mdw63WXnIERzI1lnPOeOAc2YRbs5vgp8VQmMhJ8279aUa5xN6EvkpupIxCH/MhzqWQ=
Received: from MW4PR03CA0306.namprd03.prod.outlook.com (2603:10b6:303:dd::11)
 by SA1PR12MB7125.namprd12.prod.outlook.com (2603:10b6:806:29f::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.24; Thu, 10 Apr
 2025 11:30:12 +0000
Received: from MWH0EPF000989E5.namprd02.prod.outlook.com
 (2603:10b6:303:dd:cafe::81) by MW4PR03CA0306.outlook.office365.com
 (2603:10b6:303:dd::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8606.37 via Frontend Transport; Thu,
 10 Apr 2025 11:30:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989E5.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8632.13 via Frontend Transport; Thu, 10 Apr 2025 11:30:11 +0000
Received: from rtg-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 10 Apr 2025 06:30:06 -0500
From: Arvind Yadav <Arvind.Yadav@amd.com>
To: <Christian.Koenig@amd.com>, <alexander.deucher@amd.com>,
 <sunil.khatri@amd.com>, <shashank.sharma@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Arvind Yadav <Arvind.Yadav@amd.com>,
 Christian Koenig <christian.koenig@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: Add fw minimum version check for usermode
 queue
Date: Thu, 10 Apr 2025 16:59:17 +0530
Message-ID: <20250410112917.13725-2-Arvind.Yadav@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250410112917.13725-1-Arvind.Yadav@amd.com>
References: <20250410112917.13725-1-Arvind.Yadav@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E5:EE_|SA1PR12MB7125:EE_
X-MS-Office365-Filtering-Correlation-Id: c2106582-2d65-493c-797d-08dd78230e1f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?PUpMnUNWVkU6pyyTTFUcFCy+d8TdwmTU2GrKJC/0pYYbuQ8D/hq9hrZc7pq/?=
 =?us-ascii?Q?Gne6wXJCct1jJVfoF40aat7MUfuWQpT5y2zA3V/zvZi20u9XIcNsGFMBGM5j?=
 =?us-ascii?Q?R5ywA1PrDH3lj7+qHAmcM7Fljf/RAOvsgR0lKLn7KqWRoLR1bTh4KCadXF78?=
 =?us-ascii?Q?aItCE+IYmgZ746AkgGGrr9ydFqxSpE5WE3zjwrFFgNwj2Q/l955AxgAVL1uN?=
 =?us-ascii?Q?T0FtbPbvq23SRA5M8UcKPOAEYilm9+CWDVPuwLiTsIVxOA/eNZ4Ns2EYardD?=
 =?us-ascii?Q?tMPkEjQwotBJEAUfhaikKDFmkpKMYOOL4GnLV/XXX0NjdCyJq8gUBeRz352E?=
 =?us-ascii?Q?6Z4/oJmwrEXfZHQkA5AGnHhZlKQ6L5OUxiwE3+qWbuooUg7sFcu+Eu1jTPNE?=
 =?us-ascii?Q?xPA7A/OnGnJW7ECSo+qv3e5MhbTuPoU2o71m30RiHMHgj/lhBNgPlN3wYWNL?=
 =?us-ascii?Q?mUQrB1q1GLHDs5BbsYDaWEQQMsmRlWmbsNiI8FQ5183rrvKxMnTUdR1HjmaU?=
 =?us-ascii?Q?bOaLt9+R9kmZcMoY/ANWG/spd3AkrVeRyqd1pnbE/zPJa7vp3DMt0+c0gJZi?=
 =?us-ascii?Q?vftrZQOQ6ISRiysbAXAZOODKEWaDRHsNtU2LGbPqD5eKrNDfJiP9FaPFcZk3?=
 =?us-ascii?Q?j/Tc61wuqftkT37rwpPyVhmf24iDRpLG9E7phrce88wjpp94cKWFunujms8m?=
 =?us-ascii?Q?kWE/wpb+NkW1A32mCz8KQOhLP2CYDzwTN2CKcbFzPHQ4ikufjNDIepQRkzQa?=
 =?us-ascii?Q?CMd1zKcAgT+YlJ3pQszaYuXuQoGC/j2dG2dX/4P8B2uIm4okVx9ia+TZ+sTv?=
 =?us-ascii?Q?wqfz2wavBGVEGVd/gtAVC2OnEZSDmXtH52ExOuy0ucyRev4AeRGfkRgSk6Ob?=
 =?us-ascii?Q?fqJ2pZPDwD8bV0NpU4NpCkb6SAw2XXAwIEu3T8/1Ey8+V9mziEA7YXxpc+Ga?=
 =?us-ascii?Q?f5kgFWTrl8XqalSUyWyIgtn/86kSE6k4Hdyts8FF0qkaKYSz7HCBNJkHewco?=
 =?us-ascii?Q?BgdfyCTHIZZwoSJijYJsAK4HvHwUcTrGo8h/kJc0wc4bjRPVOLK5W2Kd1Cme?=
 =?us-ascii?Q?YEG4khSyKV99E9/PoknJdVbscfj/4w6BPIsNzvgOzg4lyshSITBpBYQ3rO4v?=
 =?us-ascii?Q?pFtc2oK6h5IdZ9JfbIa2aLZQJU+GU1iApXE5yqQA5bUCYfNDRx88bIiwoo0N?=
 =?us-ascii?Q?ym8oIlyx/x57ADiLQLwG/SWEi+qG8WLEtz35WEnsQUf5KDzXEwnIbo6FTJR6?=
 =?us-ascii?Q?0IILURko53LYsjOaDvww5gcrVNI0HVmEXKnC8x9RMnGA9jEaXfVIjZidjd14?=
 =?us-ascii?Q?Nnvcrai3cCj1OkFLjF+UFs0u6IgPWyJogVRyMw88addyrvCohfUMpSW4VdJk?=
 =?us-ascii?Q?rG64Ytu30Q1TxAMnN7COtrtakhRYu+wCv7hg4o9UE6adKjEbxv8DouHT4DVd?=
 =?us-ascii?Q?BgU3Tpc7uUsQa1Xl677urfcc178cofjHqgmvNp1iu9ZExAMTZxJa2Ge8uX/K?=
 =?us-ascii?Q?J8mO91GCj/jsVZM=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2025 11:30:11.1673 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c2106582-2d65-493c-797d-08dd78230e1f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989E5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7125
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

This patch is load usermode queue based on FW support for gfx12.
CP Ucode FW Vesion: [PFP = 2840, ME = 2780, MEC = 2600, MES = 123]

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian Koenig <christian.koenig@amd.com>
Cc: Shashank Sharma <shashank.sharma@amd.com>
Cc: Sunil Khatri <sunil.khatri@amd.com>
Signed-off-by: Arvind Yadav <Arvind.Yadav@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index 3d87e445270e..c31c96fc13f0 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -69,6 +69,10 @@
 #define regCP_HQD_PERSISTENT_STATE_DEFAULT                                        0x0be05501
 #define regCP_HQD_IB_CONTROL_DEFAULT                                              0x00300000
 
+#define GFX12_ME_FW_MIN_VERSION							0x00000adc
+#define GFX12_PFP_FW_MIN_VERSION						0x00000b18
+#define GFX12_MEC_FW_MIN_VERSION						0x00000bea
+#define GFX12_MES_FW_MIN_VERSION						0x0000007b
 
 MODULE_FIRMWARE("amdgpu/gc_12_0_0_pfp.bin");
 MODULE_FIRMWARE("amdgpu/gc_12_0_0_me.bin");
@@ -1383,6 +1387,15 @@ static void gfx_v12_0_alloc_ip_dump(struct amdgpu_device *adev)
 	}
 }
 
+static bool gfx_v12_0_is_userq_supported(struct amdgpu_device *adev)
+{
+	return (adev->gfx.me_fw_version >= GFX12_ME_FW_MIN_VERSION &&
+		adev->gfx.pfp_fw_version >= GFX12_PFP_FW_MIN_VERSION &&
+		adev->gfx.mec_fw_version >= GFX12_MEC_FW_MIN_VERSION &&
+		adev->mes.fw_version[0] >= GFX12_MES_FW_MIN_VERSION);
+}
+
+
 static int gfx_v12_0_sw_init(struct amdgpu_ip_block *ip_block)
 {
 	int i, j, k, r, ring_id = 0;
@@ -1418,7 +1431,7 @@ static int gfx_v12_0_sw_init(struct amdgpu_ip_block *ip_block)
 	case IP_VERSION(12, 0, 1):
 #ifdef CONFIG_DRM_AMDGPU_NAVI3X_USERQ
 		/* add firmware version checks here */
-		if (0) {
+		if (gfx_v12_0_is_userq_supported(adev)) {
 			adev->userq_funcs[AMDGPU_HW_IP_GFX] = &userq_mes_funcs;
 			adev->userq_funcs[AMDGPU_HW_IP_COMPUTE] = &userq_mes_funcs;
 		}
-- 
2.34.1

