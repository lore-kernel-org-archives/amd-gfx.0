Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C352BC25B74
	for <amd-gfx@archiver.kernel.org>; Thu, 16 May 2024 19:27:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E6C7810EDC9;
	Thu, 16 May 2024 19:27:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bAosjqtX";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2053.outbound.protection.outlook.com [40.107.220.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1BAA410EDCB
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 May 2024 19:27:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KiexjEinRgjDXNaPIOTpsaEvY/sAYrnqizRijN+SR/+Oke1Mq0xL11zS5P0MUpUMIVTD1n8liv6IcQK8JulBKCrEMmDFj32tWva9qxqLExu6WkbZKoqILJYkknL7lMVkAW55UEsrm+5D/YwuEzRXX+lcHhfV3vvMkST0COzkS4oD5Dv9UDLs5e0R++CMHvzY/+wuG7gD2VlXJ11+1g2dz1ohQSAc0WL8V8ivHhE+t/nA51veJbt9K61N578/I7FSAYn9bTvsvapN3HWIj6njR+yH1VldG4yqd3AUrbnjRUSiaWY0zOxJ+EtBO37+388rECdyiXqTtNlbRQ5Fye92GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jLPy+w3RSsYJTRbez2zTY6dCu4zpG3BmOy3xL+/aM+U=;
 b=H9bULnO8tnI98deIPmXkIfTZS1vOKomSflkPi49XRDGGNTtToPK48vPob3F18tOF5t0HqbxVtGvKkYqvW9IbAfHTPd5PzAAnAGmjKnhHONClcr8QeTWbCiVguPKS9X9gTvNlO4aK6CFdkXI7oImDD6MIWSa50bWp2kGqXBSAcGWndVTVopkgP4CLYmNjmeoU45X8Zjrlv5XxbVV+OndwdPSMyu6lcFdDNNPwmQ1xfS2mblfHqM3Qgt6IT200jBYaxQvaj9oIgOXXMmrjcRpP2wIAalEdpImimZz3A4xeVBdVkcaL9KMMESdCFri/tk0shWyB9ryxy04BqXtAxQot6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jLPy+w3RSsYJTRbez2zTY6dCu4zpG3BmOy3xL+/aM+U=;
 b=bAosjqtXX5rw1iN9WM4vXGK2i81fG4HAzlR1qpp+Ktq36+z4k7VjZ555Z25KFohnUb8b8ktUj0HtBI13amhmlprdFuW+WdnMg2NFfj1PIiTYzXbjXbnZmhVJSaKmR3wK68ARqklaCu82IBa1u7auCP/n/NRxI0T1ag/96KNWIu4=
Received: from MN2PR07CA0014.namprd07.prod.outlook.com (2603:10b6:208:1a0::24)
 by DS7PR12MB6359.namprd12.prod.outlook.com (2603:10b6:8:94::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.27; Thu, 16 May
 2024 19:27:21 +0000
Received: from BN2PEPF000044A6.namprd04.prod.outlook.com
 (2603:10b6:208:1a0:cafe::ad) by MN2PR07CA0014.outlook.office365.com
 (2603:10b6:208:1a0::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.27 via Frontend
 Transport; Thu, 16 May 2024 19:27:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044A6.mail.protection.outlook.com (10.167.243.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7587.21 via Frontend Transport; Thu, 16 May 2024 19:27:21 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 16 May
 2024 14:27:15 -0500
Received: from roman-vdev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Thu, 16 May 2024 14:27:09 -0500
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, Roman Li <Roman.Li@amd.com>
Subject: [PATCH 23/24] drm/amd/display: Fix POWERPC_64 compilation
Date: Thu, 16 May 2024 15:26:46 -0400
Message-ID: <20240516192647.1522729-24-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240516192647.1522729-1-Roman.Li@amd.com>
References: <20240516192647.1522729-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: Roman.Li@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A6:EE_|DS7PR12MB6359:EE_
X-MS-Office365-Filtering-Correlation-Id: bcae7cac-e1f0-4631-d455-08dc75de34f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|1800799015|82310400017|36860700004|376005; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Mec/NIyofoTI6lgRb4zeseujVb/8XmdPwsfYmmsIIc/mMqRmfym6/PWKG/Vl?=
 =?us-ascii?Q?3ONZQjTUbeUVK24occ/OzhpzLLM2Vm/Eh2MGIJpBLpehahhJyKXKH3auowp8?=
 =?us-ascii?Q?YO4dIhChOA652o//7tQBx4uUugEK2MjPvNynKf9ORnRtMAB0O2LgvlJ/mLwF?=
 =?us-ascii?Q?En/Ccs9ey3owRLvyO4SiRqg44myvegyJfUGn3NiFY7vKKqdKFFs/McRqu8oz?=
 =?us-ascii?Q?/lmURMNnFYJCLoVvoS8apdJHNuGR37L4LthE+3tR+36k78ZRHkcrEoPS9Zzt?=
 =?us-ascii?Q?aNhkT+iVCnYBM82v0AewxEVKebeG+l60VRDtJ76bYBdtOUG50SDbM8APA2JJ?=
 =?us-ascii?Q?fOFy2GjnyLDnWUuVUBwV+6dkDALmUS3UlUJ3RsNzUt9z6fzHTDRlBwpuCx8L?=
 =?us-ascii?Q?v/ZofUPgpxmQhbE51K7bB7IyGKWYnR8FUBYMx+XcEw9UUcp2XAQQKPN+tRwv?=
 =?us-ascii?Q?xfFx5mxelcx1Gzz2zkZGprRMMCXHNKHBJBj6kCeFCPrywO/HbCUQza5M4mQY?=
 =?us-ascii?Q?5W82R4pgd6KDqaAQjd5Gf3wfzv7oaNU/Wl85jeuoovt+wm8bXjzIhuLuMx0/?=
 =?us-ascii?Q?9oA0YI7DzZWi5sqUlZjV+0ykhdExyEjxFU33Yur0rs4CQdhwC6u+Os2L/xRX?=
 =?us-ascii?Q?UJ229/TNvOI8YMFWSd0enSueXPaANpOcrsic1dPAYIHCJ89KvmCE+JSjD5VC?=
 =?us-ascii?Q?sucmDYhuJiZhzQZ+7vyrui+oQSDvdDz+/PK+D2HDG9VC3h0BGL+5ZiGQZ4P7?=
 =?us-ascii?Q?pG/20T7/WuDnrM6qzN4jNfbSaVYL+IKRc/U1XhwvSjR7vDSrEzvwO4xfKWkD?=
 =?us-ascii?Q?C1rg3XRymM5paEbp0DxFrLYzH/yOh0WaLOfhMRYCZWxDNJUSUiOvI4ANUIP+?=
 =?us-ascii?Q?6R3x2zKcUzqpQQ2bOEygLhdEm/W3qc/VcouKygxM+JyrJuFbqUz2g1EiYexa?=
 =?us-ascii?Q?qj1u7uaFsYXxsDQe/KFLNPPz6zVxv6TOGzgUDRbV5NONdP7u2pDPpa4NxfGp?=
 =?us-ascii?Q?FJY2KcUdyrycaqhBQ7VHs6NL+8DwQizF3P6LXYC2huT/a90GB9U5G6nzlbxF?=
 =?us-ascii?Q?usZlREjxF00gZrNyLQRDBQy9EvqdwJs72G1x72bA/cWDF/209G1GeZX/FFmH?=
 =?us-ascii?Q?aBnNRCUmmOq5GZjLfH3WP6MqBjb3r4vRYkzA+YnuDKM4xTE80yMyfvPBraRh?=
 =?us-ascii?Q?t80P82RgvGWolABUO700Sy37Xv/P2ok1z/Upol+iNbf9vJEr3RQLTL9sZsJ0?=
 =?us-ascii?Q?pc+P7t9Ob74QG95ffxpH7CNKHtmcBsApWTMx3BpnV4MkVVWMgRM06oZlgDJT?=
 =?us-ascii?Q?p4KMUqUHmrJgzrKkB84ljA8RkUoNM1pYTJqkKCVWyRfBIVHnyVkKqVry6gyi?=
 =?us-ascii?Q?opyYtB2rtUIzMDTRHqcm4RCvxUKW?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(82310400017)(36860700004)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2024 19:27:21.1039 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bcae7cac-e1f0-4631-d455-08dc75de34f3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A6.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6359
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

From: Roman Li <Roman.Li@amd.com>

[Why]
Compilation errors while compiling without CONFIG_DRM_AMD_DC_FP:
"undefined reference to `dc_bandwidth_in_kbps_from_timing'"

[How]
Fix Makefile to move dsc files out of DC_FP guard.

Fixes: 50253f5d9ff4 ("drm/amd/display: Add misc DC changes for DCN401")
Signed-off-by: Roman Li <Roman.Li@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dsc/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dsc/Makefile b/drivers/gpu/drm/amd/display/dc/dsc/Makefile
index 66ea5f104019..94883c4e4c61 100644
--- a/drivers/gpu/drm/amd/display/dc/dsc/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dsc/Makefile
@@ -29,6 +29,7 @@ DSC_DCN401 += dcn401_dsc.o
 
 AMD_DISPLAY_FILES += $(addprefix $(AMDDALPATH)/dc/dsc/dcn401/,$(DSC_DCN401))
 
+endif
 
 DSC = dc_dsc.o rc_calc.o rc_calc_dpi.o
 
@@ -36,4 +37,3 @@ AMD_DAL_DSC = $(addprefix $(AMDDALPATH)/dc/dsc/,$(DSC))
 
 AMD_DISPLAY_FILES += $(AMD_DAL_DSC)
 
-endif
-- 
2.34.1

