Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77604CCF9EB
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Oct 2025 01:17:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E62B910E045;
	Thu, 30 Oct 2025 01:17:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="NvzZhzQq";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010060.outbound.protection.outlook.com
 [40.93.198.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5EC2110E045
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Oct 2025 01:17:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pIVzGKKO/BqQatzLQKqYT05fQ/vEabUn4N/PkOin5/eXBlgdzunjSdd/mF2GLyAR7XKNfnWgbUic+0Lr6FTUiQJY97jdL8aamhOXQIq8p6YgjcbUXs/I2dGXerAWL9Xu1irpUENnAxX/rpwCCh5mHvtZ6I2zdyueX7tvRVgGE+sGbotebMFH28Wph327gvCrorI4gUlJVUxgte7iWxGErKyxdRF2goNwYAvgYUOoTu0j/Wd1VzXPDGhFHt8hrP1X9+4xddfarc/YKCgI/ekz7pqbYb/6+5L3U8BRFNGyHJ4077XAOwiGoK1RP+OrWzsVSmXrlWRXSCVvs79pKOTPLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G6RquQ8Sb8uoiYFPQw7cWxAPQJ8oDc7jq3lSLD9L48o=;
 b=kI6iGrgDgzqU+DhnAj1qn24TScLQI8xcnP0oFUl2yP6DL5ez3Z3wPrWyIB6ipv3GvIxT4FjcGOuzM0ZmCWAHgiUP4mFwm9Z2kWJmYnXiaI7Ig+ppWYRNfJYVlJWoixQmfHBh7bIrkI8nXFSotPRxLGQ1Skk647M57lOcYrl6mim+ECx/yc8TquZIXE3D0wapgdOJCdj2wgRab5lkGI/l9G/rGLzd2A3LCNPP7GLhSPsaxnz3SkG56eFgZdmb13sznwM6q2m1bmgPcclHSnjCmqHFmkaHV6Lhnr7udlGsz1EO3M1RN6XvpiPDEvGayRVRnPOG7N1sKUZG3Q7E9qUbGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G6RquQ8Sb8uoiYFPQw7cWxAPQJ8oDc7jq3lSLD9L48o=;
 b=NvzZhzQqEXKWyUs5UVEGV0w7OKvD38dPTLITxpTfnRgiiJ9G7gULcoL10B9qGcQsxIzsWniWMjE+BcwYnMGJbP8FpVWi97prGjWLsv80zjfR5WTzoFvvnucPgTj0ABWrAK74vdpbo9QwjCT8K0yRYnV/TZKgqJAVn+kUi8eYE3c=
Received: from BYAPR08CA0047.namprd08.prod.outlook.com (2603:10b6:a03:117::24)
 by CH3PR12MB9430.namprd12.prod.outlook.com (2603:10b6:610:1cd::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.14; Thu, 30 Oct
 2025 01:17:11 +0000
Received: from SJ1PEPF000023D4.namprd21.prod.outlook.com
 (2603:10b6:a03:117:cafe::dc) by BYAPR08CA0047.outlook.office365.com
 (2603:10b6:a03:117::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.14 via Frontend Transport; Thu,
 30 Oct 2025 01:17:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000023D4.mail.protection.outlook.com (10.167.244.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.0 via Frontend Transport; Thu, 30 Oct 2025 01:17:10 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 29 Oct
 2025 18:17:01 -0700
From: Yang Wang <kevinyang.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <hawking.zhang@amd.com>, <alexander.deucher@amd.com>
Subject: [PATCH] drm/amd/pm: adjust the visibility of pp_table sysfs node
Date: Thu, 30 Oct 2025 09:16:51 +0800
Message-ID: <20251030011651.1433120-1-kevinyang.wang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D4:EE_|CH3PR12MB9430:EE_
X-MS-Office365-Filtering-Correlation-Id: 107b3622-c5a2-45bb-53dc-08de17520cde
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?gYeR503Tl5GN+z08JcVvQn0FEfjtOHeVbIhne9Qz+ZnWyprKqmwG0Pyt+eZl?=
 =?us-ascii?Q?saBhQ9C/+dkO4pxVn4LOmSmvh7qcqoxYuNxzs6A+v7dUGzmgzvsi4KkPsZSk?=
 =?us-ascii?Q?kABN2KPBWyounD7ssQAjsv2jwtaw/+iysAksRMhP4PKLpqXpaVTQf5vK7CD+?=
 =?us-ascii?Q?ji/xUbTqqLYFd8SPRUEFfcM955glLUYKVMOvf3kOWS+uJXrO6GvLlogLaEA7?=
 =?us-ascii?Q?5bemAZNvcexS0SWE/YGZi56wNX7txrDWUZ7ys+f3STsVggT/XPFH+gd3oCi5?=
 =?us-ascii?Q?0wBQAgQ2BjWQuNh6YSDgoaQUWXMK3hY5b39utnMsgMKwGudK9lAuSMuvGfur?=
 =?us-ascii?Q?Oq6O4Is8NjATptIkwKYK46VPR0gOfmpV4mg96HiwITeBHt6qFVFogO6LkezW?=
 =?us-ascii?Q?wpmsdoFdE9xkzfoz3uHSbmXq9t5X8vxJ3G3Z/zmTExYTZ04IwX1VWb+D8Nct?=
 =?us-ascii?Q?UY8NQDVGllllnLRtwCyLjUVSHsvTX3kVOeihO/weLGTFm7vFBchkbJkkDLPF?=
 =?us-ascii?Q?eZ/JwYH2zzk/FVsebtxbsHPfoT5WhF6eu0BINcofywFEgi0Y+gn5zKk/AZiL?=
 =?us-ascii?Q?CyuNfXFWPsKWLOghIJoNkZ1O/rCqL9QQD4E7wgKSEEn1T7IzwWjeMHxrOEkQ?=
 =?us-ascii?Q?lBh1IkVbY1t7VHdAdnKXNH73A+50+0ujZDzSO/HG12wJa54pxSYZsTG4kghK?=
 =?us-ascii?Q?1E3u998x9qIAmtN8Mjbn5HTXAxwt5OIkDzh9Te2rsIlSY58pghWYFKVHnINw?=
 =?us-ascii?Q?7S5lZCGmwofGvHBuV0W8k71w7ikJm1K/7upcRx2GEFAyqRAozQ+ZCnhPb3jz?=
 =?us-ascii?Q?XTR65fjGsbc3j5wfEVQaGOp4yooxKfVC4yhlKNni5G7aykpclJtVN+gWORXu?=
 =?us-ascii?Q?uRAdnrO9Quql/0iQIMjXcf1Agjb/ubpLBSR/9zIlFDAW6Y9cfCUNXkBmFQz5?=
 =?us-ascii?Q?QLswVlLftp6qOmSqEom8Yhe+le1JYGHZQfJzAJ2RlOdX9ZXAq2BxKtkAXM+D?=
 =?us-ascii?Q?9lGYgevelPH/iJndt8tbaXk8WL1Gmop9OoYYQ3Xg2WU02INtSwXjc75RMd4v?=
 =?us-ascii?Q?HkAfWCVuCQrf9lMgdrKZrbt6dcz45ALFi42FuzzE3l2zR3NXUNdq1MRLv7Ll?=
 =?us-ascii?Q?D0LbldBjH6g8npRR/Fu9WGX9yBX7jhsMX6pBXOiqskr7tBry2KQMlizgHJf3?=
 =?us-ascii?Q?arcEdhSi8CDZXkK3W8XrHTd4xkPTc7uZE3YsiwwDZGbLwzr8Jfh/6ELHePlC?=
 =?us-ascii?Q?JHP8QoCi8zxYOWzH6wv7tI8sf8fHUmIuoowlVpQkHobocyfnDH2Vo2E+EUAu?=
 =?us-ascii?Q?u3SmMVa2PX/OeDYsPVJ51h51GYjuTniJvGjtT2txmPXK5cp+QuxgxCgqVh84?=
 =?us-ascii?Q?ZBY/6esrhSzeXKDMrCzb4bZHk5ljC2PsbjaqpQTSPvW1KQp5947RdEadt5ga?=
 =?us-ascii?Q?lJVQRwsLAjPaK8Ct0p8aIpdDKuOgePLKvrQspWxsu+sjrB10O7y6S8az2CxT?=
 =?us-ascii?Q?5w0jI4aizbagEyLru1zbKdq7iHJT1SjsNyJjGcqdPA98rHZ64PJYJvWH4SDH?=
 =?us-ascii?Q?Npih4NTjAOwIpjH0kl0=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2025 01:17:10.2479 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 107b3622-c5a2-45bb-53dc-08de17520cde
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023D4.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9430
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

- make pp_table invisible on VF mode (only valid on BM)
- make pp_table invisible on Mi* chips (Not supported)
- make pp_table invisible if scpm feature is enabled.

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index c83d69994380..3a14e0ff38ae 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -2507,7 +2507,7 @@ static struct amdgpu_device_attr amdgpu_device_attrs[] = {
 	AMDGPU_DEVICE_ATTR_RO(pp_num_states,				ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
 	AMDGPU_DEVICE_ATTR_RO(pp_cur_state,				ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
 	AMDGPU_DEVICE_ATTR_RW(pp_force_state,				ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
-	AMDGPU_DEVICE_ATTR_RW(pp_table,					ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
+	AMDGPU_DEVICE_ATTR_RW(pp_table,					ATTR_FLAG_BASIC),
 	AMDGPU_DEVICE_ATTR_RW(pp_dpm_sclk,				ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF,
 			      .attr_update = pp_dpm_clk_default_attr_update),
 	AMDGPU_DEVICE_ATTR_RW(pp_dpm_mclk,				ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF,
@@ -2639,6 +2639,21 @@ static int default_attr_update(struct amdgpu_device *adev, struct amdgpu_device_
 		if (amdgpu_dpm_get_apu_thermal_limit(adev, &limit) ==
 		    -EOPNOTSUPP)
 			*states = ATTR_STATE_UNSUPPORTED;
+	} else if (DEVICE_ATTR_IS(pp_table)) {
+		switch (gc_ver) {
+		case IP_VERSION(9, 4, 3):
+		case IP_VERSION(9, 4, 4):
+		case IP_VERSION(9, 5, 0):
+			/* No PPTable support on Mi* chips */
+			*states = ATTR_STATE_UNSUPPORTED;
+			break;
+		default:
+			if (adev->scpm_enabled)
+				*states = ATTR_STATE_UNSUPPORTED;
+			else
+				*states = ATTR_STATE_SUPPORTED;
+			break;
+		}
 	}
 
 	switch (gc_ver) {
-- 
2.34.1

