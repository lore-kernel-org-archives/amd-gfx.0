Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19259C52D71
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Aug 2024 18:03:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 934E210E084;
	Tue,  6 Aug 2024 18:03:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="30vHcNIt";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2043.outbound.protection.outlook.com [40.107.96.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C652C10E084
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 Aug 2024 18:03:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S8tRQWjssocZyaIiFXCP8Vqfe9VXiespdYdACcD0PBiyPze85e6J8QNeU57ISJqM0PfTNLufG5i+7XMFrqYmJllBj0EUMpNr2KKxsVgA/cZSMrvvSdwGOtL5q0hioUPz9e2RwVNyd+y2rgqE0QkK2OnGnFji89J4lbINKRpnq2jvf8wa8wEVjbezdw3z2MzJhOGzM76KbA8sEkcD/zZtYMCSvm+AkuqI7VzuCA6VdqEpT8WnEVQ8LT9Wo4uilqTVvQHSfHxx4FAo3IFVPEs1f1m16nR2RFZSYrkcWCJ3nmv6tNy4DItgItmfbZoBvMxgYmrFA5Ia0/ZjjYAsOWg7aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=30LlHMLaGNNUylcL5T7lBMC25cRSh51MeBU3bEO3RV8=;
 b=eJPEyJ9SpMeJKGORPI0sx8tcyhH3vphWd4F7+czAsthsJM4dNShtHosGOO8jHOBhS7w/mgz1RI/WzE9Ivvk+JOnSAex2hnLhTZMxWWzDpx0mu76z+9fuXNDYDZiY3D5Kv6pKwvUNfS5rCjRlTMsC3jShnW9s5Hj6b/AJJsdbQ5PFdVMPwOGfNqQSIdJj/+5jjgca9KDbIMzYk/+hhJ7Ty3CqhNzVeGoQ9/rSuQ7QcYittp6O6CujyiBvBhy1w7os2BVIxy91FMKNXMtS9O8ekh3PZmqoaRPIRu3W7tEP8Cm2bbkPAF4SJRPD1t4KKblEmGIQ/PV/Riw6zR2wD993zA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=30LlHMLaGNNUylcL5T7lBMC25cRSh51MeBU3bEO3RV8=;
 b=30vHcNItrMMNe2m4yLw5Wzth6lYpbdPHrvjkSggd8wN0en9RnPQBZUhXXcrj7eWo+cNRx63v7yYRpJKqdsrQfjZkzAFMz3oDx/TaUNSN3ClQ0kPLl0vvC2vefk/QJd5jKahJ6TZPGnFYncdL7RkL8SYUvCnSrNd4wnC9Qh6Mt3Q=
Received: from MN0P222CA0027.NAMP222.PROD.OUTLOOK.COM (2603:10b6:208:531::35)
 by LV3PR12MB9266.namprd12.prod.outlook.com (2603:10b6:408:21b::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.27; Tue, 6 Aug
 2024 18:03:22 +0000
Received: from BN3PEPF0000B372.namprd21.prod.outlook.com
 (2603:10b6:208:531:cafe::4a) by MN0P222CA0027.outlook.office365.com
 (2603:10b6:208:531::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.13 via Frontend
 Transport; Tue, 6 Aug 2024 18:03:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B372.mail.protection.outlook.com (10.167.243.169) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7875.2 via Frontend Transport; Tue, 6 Aug 2024 18:03:22 +0000
Received: from yinjiyao-test0.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 6 Aug
 2024 13:03:21 -0500
From: yinjiyao <yinjie.yao@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Christian.Koenig@amd.com>
CC: <alexander.deucher@amd.com>, <leo.liu@amd.com>, <ruijing.dong@amd.com>,
 <yinjie.yao@amd.com>
Subject: [PATCH] drm/amdgpu: Update kmd_fw_shared for VCN5
Date: Tue, 6 Aug 2024 14:02:55 -0400
Message-ID: <20240806180255.196821-1-yinjie.yao@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B372:EE_|LV3PR12MB9266:EE_
X-MS-Office365-Filtering-Correlation-Id: e33ff2a4-ec7e-42ca-1965-08dcb6420f52
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013|43062017; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?nB7aIbm/XTDqmC+fE3XBWNgHkzrFPP/yl+DhP5ccQNC0n600ODc8ilmo+lJp?=
 =?us-ascii?Q?kmJ0dljIYEuHMVzJa5W5gyd+H0mqz2F6GBEYA/QWSYm3nAu+Ztcab34RERro?=
 =?us-ascii?Q?EGbS0ZlhzHIJccdHTEzasFNi8ZsV5ml43bUyAYwcHjFofJeR+A+1ikgWQn4r?=
 =?us-ascii?Q?oB+LGPtq15IBYpyOrAA2BXMFauqjJgHVCH81PebvFUrcf+clGQbm/dxuiJD/?=
 =?us-ascii?Q?2AghUk2JLfg0Cvf5Dt1OU8S2PGMVJP5EwNoR+vc0Bxa44J65qg7tBHM6+3ON?=
 =?us-ascii?Q?L7RIKk7Fot3KSSuBdT9O9hgw0zQF+1eTXLdNcW2XRd2Y4T6Vv2AlRshUxeE7?=
 =?us-ascii?Q?jxi/JWPqX8xFyDOXR29KB6gt+k9mWFErEH49snbqBcLCEWTvjdiz4/ze5kBo?=
 =?us-ascii?Q?h96ahKcsb0Ki6lki6dTFl0fAw78CDOC0QylhOzsTOs6lAMsFqo+GMHhOYt4R?=
 =?us-ascii?Q?55lME2aEb6hfBpy9wOwB+d4Mr6dQpCXbBNxsvJx+OO149FD73PG1kTMz3qEQ?=
 =?us-ascii?Q?NHZwzxzeusyX9DAhrXxsPZl+gkL4syrl2VxU/e4lZ+NFGLryomwxCqr3s75x?=
 =?us-ascii?Q?15dZPrrCJQYu+YVaeJiDsMp/xNu1NDOCCR9IB7bHR5PVphqfdS0suLKdfJtR?=
 =?us-ascii?Q?+2iNuCwNfpbyC3jINdFu50GcgA2nSrUagGdEIwX5P+dePo2hXuhHFJhYI2Bf?=
 =?us-ascii?Q?5X9Bg3nOEq/9eYnTSx1/UlcQf/5+QMLPNgxDZaZaeJCh9+ApyrqaRxxvEgts?=
 =?us-ascii?Q?ZfPBAoN+B30kDnyDXR3B93wpZ+9uv8nWm/ZDQPsyC5LD8yEF4rbaIQqkBe+A?=
 =?us-ascii?Q?JASL1qTW4qy9FPUU/2w+Cj1emUs9p3e/OafISPxxP9BzGUrc1QbxCaM03zVs?=
 =?us-ascii?Q?0g8nRnjUIeC1ukVUWj/tHLjDhAYveMVXEHqK9gMCvGXhfsv8D+Xmq44VinLW?=
 =?us-ascii?Q?KLTSIxFp6AIXMjZE4v8n9FLE3WtMLYBMeRPxhBHHbhTH9k3sdFIkDOB4RyXk?=
 =?us-ascii?Q?gPkmHjXrvliqg20TiflRiaVI1sX3lA14PqjIctuHFjGlWl5ZmzH0b86HQGFv?=
 =?us-ascii?Q?okPK1OhTic9x55MHHkEFdktLa4a8SVvXSWZySs+mOHcd7g5gUgMBtb5N8QI8?=
 =?us-ascii?Q?Rztgh6DOdLs+vpMIOf3yI5Am3BjYGDBGYhFhqOp/Q1V/Q6VRg/67R47Xv7kB?=
 =?us-ascii?Q?JnS4r4IvWQCfGoz2yV6k/gVhZNbCuP6sbKRH9kLqiol33NNwNauPg1VsrmEn?=
 =?us-ascii?Q?oDLwnyKJu0s+YIUTYEK805QTxLiFgjsUR1/DTbFBXVDqdf18QsFYwtdsL3gi?=
 =?us-ascii?Q?+MR2KNtL0dXrm0JFp+5pGszl4zMM6CmbcZ4qvaOyd/NK3AlEepS28o9e3QxV?=
 =?us-ascii?Q?8bv62VNoG2L66TRW0wDTA+S9DbgyyOwkP3LFd0WpjtsdD1BrLOZRwy+1ZhR3?=
 =?us-ascii?Q?s1WdSmeV8c8gDXDjfLliBHh1opD7JYgYTSpl3KwyakXS1c9lpno+2A=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013)(43062017);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2024 18:03:22.0122 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e33ff2a4-ec7e-42ca-1965-08dcb6420f52
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B372.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9266
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

kmd_fw_shared changed in VCN5

Signed-off-by: Yinjie Yao <yinjie.yao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
index f127eccf59d7..2a1f3dbb14d3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
@@ -464,8 +464,11 @@ struct amdgpu_vcn5_fw_shared {
 	struct amdgpu_fw_shared_unified_queue_struct sq;
 	uint8_t pad1[8];
 	struct amdgpu_fw_shared_fw_logging fw_log;
+	uint8_t pad2[20];
 	struct amdgpu_fw_shared_rb_setup rb_setup;
-	uint8_t pad2[4];
+	struct amdgpu_fw_shared_smu_interface_info smu_dpm_interface;
+	struct amdgpu_fw_shared_drm_key_wa drm_key_wa;
+	uint8_t pad3[9];
 };
 
 #define VCN_BLOCK_ENCODE_DISABLE_MASK 0x80
-- 
2.34.1

