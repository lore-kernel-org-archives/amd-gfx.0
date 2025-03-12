Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C86EBC28B2E
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Mar 2025 18:58:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E514410E7B0;
	Wed, 12 Mar 2025 18:57:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="YLTbVaPj";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2065.outbound.protection.outlook.com [40.107.243.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E6F5E10E333
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Mar 2025 18:57:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=juAWJ4GFpKc3sDfeqC7pSpAhb2TNAArs8iy7Ay/Rehc2pETp5iVfMjMD3A1COAzA5ZlVyx7ke4lMORspspxiDuO9ARuavIRGHvXc6y55GrGoFmpgJvQcNQV1XSus6E4lS6Vvo70Y+X7t+qdA/6kLUYq1snTRCIbtpfrDcRLpeof36Rq7J2MCsu/Y9Z0Vh7pdP2eUsiBubyasZtSVWoSogI7qvR/nwLJJ8TRmf4Gvjf8cbuTeuCCdO/FSnsX2f+3PimwQwYcTTzebgZNzEB37ah/8XncZyRlexc96EGzLc7xr/xHQwrSHvs8cg2ZQ85SxrcSArPnEmJFFb3aF2F/MWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p+4znT6orinGyNDxnLfRxsY41IB6XUfdLP1dYb7kozU=;
 b=MfQP5Vd7LTpk/SB5E9B+BTS0rDDe/FRCbmVRBlCBKtkeJGrByCe23UxJyr3abn3VwlYY6ZCDdQIgfImaz9JKSI2BSovyo9ZN/T9UwwFfm8RshoNcWFwQ9f4QnudV0A4bBp091heB2GKxqTfn9xZcsmSF/t8aTzRYvhQiQL6rL+cnWVWLKJZwOiRHhPPw6/SHhhGpuSP0JlRnRY9md99vgCvJDJ/FolhTJAxuHV9LLRvDj5MLkgK+DGUKsFaQCka13S7WkCyTNI3JsMpOPGgWLzQHRIEamJj380uisGf3NKwIAC4NEhDTFWdwmNzsHKx/9ZdgfTvSmdenYdV0YVwtxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p+4znT6orinGyNDxnLfRxsY41IB6XUfdLP1dYb7kozU=;
 b=YLTbVaPjBSUhA8EowvarYxVrk0rbAc9OXSsV537FQ8X68PUnKrOX4/h/oGgcvm3v8brZS73p7p1fX9kYjXIWVQBCujBs+V560HU1jh3nijuQYmMtPr1duJKk44hea5vnZohiARqQia/A5HcEmvKykOLlwQ0CeNdUhVlblbo/LKg=
Received: from DS7PR03CA0235.namprd03.prod.outlook.com (2603:10b6:5:3ba::30)
 by SA3PR12MB7952.namprd12.prod.outlook.com (2603:10b6:806:316::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.28; Wed, 12 Mar
 2025 18:57:54 +0000
Received: from CH3PEPF00000013.namprd21.prod.outlook.com
 (2603:10b6:5:3ba:cafe::1e) by DS7PR03CA0235.outlook.office365.com
 (2603:10b6:5:3ba::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.27 via Frontend Transport; Wed,
 12 Mar 2025 18:57:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH3PEPF00000013.mail.protection.outlook.com (10.167.244.118) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8558.0 via Frontend Transport; Wed, 12 Mar 2025 18:57:53 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 12 Mar
 2025 13:57:50 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, Sunil Khatri
 <sunil.khatri@amd.com>
Subject: [PATCH 11/11] drm/amdgpu/sdma7: add support for disable_kq
Date: Wed, 12 Mar 2025 14:57:31 -0400
Message-ID: <20250312185731.211350-12-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250312185731.211350-1-alexander.deucher@amd.com>
References: <20250312185731.211350-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000013:EE_|SA3PR12MB7952:EE_
X-MS-Office365-Filtering-Correlation-Id: f4df04e3-942c-4ab4-8eb4-08dd6197cb81
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?+R9YFDV8NhiZ6mv46yTLhKvLZSqZy5i0Hw9NTr9FCP3yLI+P0l2U1T2xlj4t?=
 =?us-ascii?Q?mWEOla8CeLtCLTvtHv69J0xAWZSd1O22Ft3D765doZ6j5ZZAY7Egii5gIQh9?=
 =?us-ascii?Q?d9P1kkH1UXhHMGW2IEtLQCqjyNFIoWnQymYnHf26z8pE0590lU2RojQxKJx3?=
 =?us-ascii?Q?f9CSy68MbLXHzohiSX5PCTb1pf9mDptA5uzQB+FPxTdv9GqM5H/r97J8n9Lj?=
 =?us-ascii?Q?w3Nb7hKoI+sBP0GfI7HSNnkT4+yGpUHiuiIhhfSlAg9jCA0R3PHAZ2rL1VD2?=
 =?us-ascii?Q?L2jrNSxJhfnKLV6j94KrnDmARe/479VL5107RU8A7DLQDPPCraaDtEcW6p+/?=
 =?us-ascii?Q?m6hrC765MNSt2xBXlcj3VVWCymtZ328UkGaw83mHfuRCHAIB8BWvzVA0y5xf?=
 =?us-ascii?Q?Dx4TdpQdg2SOc1uuLLPClS+HiWS01xez9pWGhTdLmutidJHLuH9RdQnaqMco?=
 =?us-ascii?Q?9r9L78pmkRAqby5EE/wMPkOzcoUol6eF7buBxHS1KW7w+V7nly5WRpizezzY?=
 =?us-ascii?Q?uV6EZdPvbGNY7lVn66Zt0LTwX4v26UrfQm4cD/DG8mCIdRAn1uNF/l5suKPk?=
 =?us-ascii?Q?Q/E2Y1Sixs6PwDK+6joNB6fDtqIPbfxnEupg+wNur8neNcXJZFOsGdDLTugH?=
 =?us-ascii?Q?10bYGeKT/wZim3tbOxWk5yCF2berlQ9ptR/dENRKzI1t3EgRNJiCxUm/BTb+?=
 =?us-ascii?Q?mUudMf8SHsb1JbHbSNTDQKgDc87+E0N+A1CWSnlsgBnEri3SunGeOS+7SRkG?=
 =?us-ascii?Q?rpeNHKX0fgYPfjm2TOU4gjLhViSEMTm/KU1GzxGis17CvYyRSebOmT5qm1GL?=
 =?us-ascii?Q?b0LLbgYgWtwTY38SvwLnam4lxnr8uEcnzZVpsb/4svKmvUZCXyGLsVzyr/Ml?=
 =?us-ascii?Q?I3udIKKc+Eb0GFg9lDMTltHN2eHfITuTACUjXfC/bmjIGAun65jl+wfBauZ5?=
 =?us-ascii?Q?KtnP/mRmKG3EHO91+rNAwpjNjgJa3af/KIuBSa/48oFKYuSg+phmYeeyE4GV?=
 =?us-ascii?Q?vL72j5kWJ06mz8PqqpwLGOJPRPLDvY941q8oNvC+DPBWIAKCNbx+N0iVMHi+?=
 =?us-ascii?Q?dNr8/jzYR7VB/w7iC5rztXLKJdFEmcLaVRGxlultBqAKTvGSd88aOea01CB/?=
 =?us-ascii?Q?4PFk/1eIZCywaZauYDSD5AC1D5UyoLTtWH0aQRFpygnmGaJTRixBAE75tjXc?=
 =?us-ascii?Q?jN/yr4Ks3d+616fSnM1PIuiasuf4Iq6fx/TheuYVqTUl1vlHoXKMvWm7Jocb?=
 =?us-ascii?Q?TOnoPzqOmxIEoyarIp6vbY6Qp554tcmdrgccMZEqQwKFJ3dv6Z5pOs2ldcwI?=
 =?us-ascii?Q?MxBmMqgcxff+COKoevEqiCD67qZ0dIyS45l6VmoKs0b/ZpE9/+sBWZSxA87l?=
 =?us-ascii?Q?jTFjwFVNcsxG6Ex9EKR4pVrSEGcdOQwZ70HoDyNBbR7VEB0W9pXRFx0xjsQ0?=
 =?us-ascii?Q?1z61HUvP70o7iMF3mP2umvk659MUPo9OfK005lgAx/kGSDHe/VArkA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2025 18:57:53.8074 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f4df04e3-942c-4ab4-8eb4-08dd6197cb81
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000013.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7952
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

When the parameter is set, disable user submissions
to kernel queues.

Reviewed-by: Sunil Khatri <sunil.khatri@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
index 92a79296708ae..40d45f738c0a8 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
@@ -1316,6 +1316,9 @@ static int sdma_v7_0_early_init(struct amdgpu_ip_block *ip_block)
 	struct amdgpu_device *adev = ip_block->adev;
 	int r;
 
+	if (amdgpu_disable_kq == 1)
+		adev->sdma.no_user_submission = true;
+
 	r = amdgpu_sdma_init_microcode(adev, 0, true);
 	if (r) {
 		DRM_ERROR("Failed to init sdma firmware!\n");
@@ -1351,6 +1354,7 @@ static int sdma_v7_0_sw_init(struct amdgpu_ip_block *ip_block)
 		ring->ring_obj = NULL;
 		ring->use_doorbell = true;
 		ring->me = i;
+		ring->no_user_submission = adev->sdma.no_user_submission;
 
 		DRM_DEBUG("SDMA %d use_doorbell being set to: [%s]\n", i,
 				ring->use_doorbell?"true":"false");
-- 
2.48.1

