Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EEEEC2BA18
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Jun 2024 09:50:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9D31F10E326;
	Mon, 17 Jun 2024 09:50:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pKVHDobd";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2065.outbound.protection.outlook.com [40.107.223.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1782410E326
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 Jun 2024 09:50:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aSu7u/ofgbFwdeB+NNvqekmpoUDgUgdxP7JA+4BvC7z3deQJsxisz9uN9nBF5fIwLUU/jA6d4JiK7V+inzI+MzkqwxoZw0eo9cRrcMwxbQ3EgS1hWiAUUS7zpjb9cqKtW3HI8ILyMAfeIFca9mTmE5AmSNwN5KW3+n/IFVISuCIqIt5m965TxLHwx2mGjm/a9LcXuYHU5QpAsVh6U5AohVrrjp6T8Hvt3z35JnWHtV5acXyLbFLmofOc8Mmm2Pnk0H4ExabFv6NjfXAhlBnmgI9zBd1Z1C9Kq6nVW17BCIGw8vV19grW0mjL/M/XMZup/4s2559HFFcDX7nsG86htw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XB2SjE8yrFAjPbyndRjESXrWMXft0RzRzO8qNkrj+Vk=;
 b=TGmuXV/xqf30MLnriwDUEIMzGZnWl60HYkvlOvTpmWs6cRI4osEdgI6tVMyxVnmelFtwHTa3eIgoBc8IdpVCcPfd37+olSpmmyA12qYJRf5fbXEFLdTnHDiUDULr7IljRHhzOcXPRvKS9zWnzMD5pISCc0T9dE0aDPpt9oBsks/LHzgQhZc0/xXFBY17VF2g446j2D9afxtCQ4R54G9T2xsDmwcjg+h7NDoM5A7Qz0T/fAwcHDlzgePNK7X/iM19dKyqB4UlkAZnTeqMTiBxTymPk9V7DzdXNJJZzAAsLRanqScLDJ7q/9e9BS0QSksn2xqLpZfcdwr0Miq+/HOwfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XB2SjE8yrFAjPbyndRjESXrWMXft0RzRzO8qNkrj+Vk=;
 b=pKVHDobdbif3GSBNqj3M1bnXrUpfvLFY4vwL11MzXJgB2R9T7EWszBBGYrMZJZolYNSmpSH6x91oEcR4kOkd13d8nnaOEkmVItjBRv+AuihC+qwkkrymY3MXZkl3oRzxbv+6Yh+yAnfNb/OD2+VWTsQZaqCL0n9ZrexcE1qzVrw=
Received: from SJ0PR05CA0127.namprd05.prod.outlook.com (2603:10b6:a03:33d::12)
 by CY5PR12MB6371.namprd12.prod.outlook.com (2603:10b6:930:f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Mon, 17 Jun
 2024 09:49:57 +0000
Received: from SJ1PEPF00002320.namprd03.prod.outlook.com
 (2603:10b6:a03:33d:cafe::fa) by SJ0PR05CA0127.outlook.office365.com
 (2603:10b6:a03:33d::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30 via Frontend
 Transport; Mon, 17 Jun 2024 09:49:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SJ1PEPF00002320.mail.protection.outlook.com (10.167.242.86) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Mon, 17 Jun 2024 09:49:57 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 17 Jun
 2024 04:49:56 -0500
Received: from jane-sm-stand.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Mon, 17 Jun 2024 04:49:54 -0500
From: Jane Jian <Jane.Jian@amd.com>
To: <Lijo.Lazar@amd.com>, <Haijun.Chang@amd.com>, <Victor.Zhao@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Jane Jian <Jane.Jian@amd.com>
Subject: [PATCH] drm/amdgpu: normalize registers as local xcc to read/write
 under sriov
Date: Mon, 17 Jun 2024 17:49:54 +0800
Message-ID: <20240617094954.243360-1-Jane.Jian@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: Jane.Jian@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002320:EE_|CY5PR12MB6371:EE_
X-MS-Office365-Filtering-Correlation-Id: 95beca43-1429-4a0a-e2f8-08dc8eb2d8d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230037|36860700010|376011|1800799021|82310400023; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?uOnCPRSMQrOdcafNL6H4XfztEPmwDarqpGD3meNvd1jRdqYRJLOC2ehs6dkW?=
 =?us-ascii?Q?nKeA8aU8mH+pet2JPIwnHtRoMsa3BNuz37V1H1S8nmT/lilWml2k7ESXzAms?=
 =?us-ascii?Q?Iej6d4txUa013PEOINv9/iD3VDAj/AfyvVRoYuiSgtDFx/3wKpHlNwdMp7jb?=
 =?us-ascii?Q?52mPI/uN3rZblJOO/zIjpLPe1LwgS5PpeqvXfbpk1Gtjnc/cuG3Ubxec91dV?=
 =?us-ascii?Q?tgPKNedeCJ8G//NQxIPJ1QWWSbEb1xpOgCS0DAvKRR/a8p541HgG2uEOu8vf?=
 =?us-ascii?Q?YnAGx2rL8xxJ6Ot/hqN2rzOu1F1CMV9rvT0MLICmPA4wsqEIFK5zdcqAF7IS?=
 =?us-ascii?Q?JyCp5ko8tr1iQn49hzslorzdZafXTQFO/PcH03VLmYo2x6ROR8asCLiT/NS3?=
 =?us-ascii?Q?EMbTlV0XuWiZTiTp8vvEwQtww9WWAz3ODCDDViNF/SJD1FbF0yH2jQWyV1Jv?=
 =?us-ascii?Q?u3r5vIUKyaoIuKPUg/Toj1nz5WmgXqVPcseZtk8Rg4Cfn3iFJxzm1fvFRgF3?=
 =?us-ascii?Q?AkFsKoU+QkYlKYhyQvkXrOn9nnvNlP4rdRrHxcMj3gswJKt+JLuWINAv85+t?=
 =?us-ascii?Q?IdyCuti/9hjVfNOM9MD2P9amNQifbPnOP03MWAMriXKF1FFmLKU7msL3+csd?=
 =?us-ascii?Q?ZDmk9giTCoAX7bp6QylIkQZqpPtPXwgTkiPzTyVSnA47vOHr0p1V+4BXJNJA?=
 =?us-ascii?Q?BmG9Z3ITWJhMiz1JUl2DyE1E6LihQcSNau5ZpCn711CHng/GNic40M+8eHOC?=
 =?us-ascii?Q?b/BqRHmHswKjw0BGZlyCM1yegw5C5z2nx0n5SRgkQKQ3acd/z2IDgy/3qijD?=
 =?us-ascii?Q?twmDkjIgRZeNeST0pOVXgDCQpGhM9DsaiFfK4EXyXtCz8wlcLSUtS7YQBlkR?=
 =?us-ascii?Q?YKR2B9UWOrgJFJu+XBJjfn8AVKIk8KfXpltpMtp2h/B6sfXDIIPStSvFMofQ?=
 =?us-ascii?Q?FxAOgXXqaFRdDcO309z2QTdQ/ISAVxf1xPFnY/eKPfaNtHmy8ZMWwAzmXUod?=
 =?us-ascii?Q?GGkik/CnhEeaZ+4IlJ9GYEMNneVoePRXaugcPklLfVW1YQSh6fodXy7qQx2V?=
 =?us-ascii?Q?kjhnj5+t1bUOP116Ma3bmWRVAOxmBQE8Y6JARo6OCgD//8r1wW8yUcCNuJcj?=
 =?us-ascii?Q?wQhi2A8V4MlzgVM1ama+ORa6adVh4blZ2/Dwre74CKd4G3+14M2NK38PE0uL?=
 =?us-ascii?Q?EKpz6pO0UO2NVQj16vaEq8txzm4MBjtPUGLvwXAaq2Qs4qgsEkjATsU3kgEX?=
 =?us-ascii?Q?Q4+pwSiTfLvHcRUaS0l4H1gxy8VtOt4VwXgH3WBIwC11DYqqHjC91kBk6pmt?=
 =?us-ascii?Q?5lBAAbpedUh1noQUeZS9Bpn5Kd6qpT48J8kOZ9DnzlojYxMFoKHxm2+AiPhL?=
 =?us-ascii?Q?JUMYpu8z5XfaTyD4xrZZl/81IH7JlTt8Ix1qmrhrcFGqKIMqfg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230037)(36860700010)(376011)(1800799021)(82310400023); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2024 09:49:57.1842 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 95beca43-1429-4a0a-e2f8-08dc8eb2d8d9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002320.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6371
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

[WHY]
sriov has the higher bit violation when flushing tlb

[HOW]
normalize the registers to keep lower 16-bit(dword aligned) to aviod higher bit violation
RLCG will mask xcd out and always assume it's accessing its own xcd

also fix the typo in sriov_w/rreg:
for KIQ case, use xcc with xcc_id to read and write

Signed-off-by: Jane Jian <Jane.Jian@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c  | 12 ++++++++++--
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c     |  9 +++++++--
 drivers/gpu/drm/amd/amdgpu/soc15_common.h |  2 ++
 3 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
index 63f2286858c4..d43652a38484 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -1075,6 +1075,10 @@ void amdgpu_sriov_wreg(struct amdgpu_device *adev,
 	if (amdgpu_device_skip_hw_access(adev))
 		return;
 
+	/* Select lower 16 bits to write in local xcc */
+	if ((hwip == GC_HWIP) && !(acc_flags & AMDGPU_REGS_NO_KIQ))
+		offset = NORMALIZE_XCC_REG_OFFSET(offset);
+
 	if (!amdgpu_sriov_runtime(adev) &&
 		amdgpu_virt_get_rlcg_reg_access_flag(adev, acc_flags, hwip, true, &rlcg_flag)) {
 		amdgpu_virt_rlcg_reg_rw(adev, offset, value, rlcg_flag, xcc_id);
@@ -1084,7 +1088,7 @@ void amdgpu_sriov_wreg(struct amdgpu_device *adev,
 	if (acc_flags & AMDGPU_REGS_NO_KIQ)
 		WREG32_NO_KIQ(offset, value);
 	else
-		WREG32(offset, value);
+		WREG32_XCC(offset, value, xcc_id);
 }
 
 u32 amdgpu_sriov_rreg(struct amdgpu_device *adev,
@@ -1095,6 +1099,10 @@ u32 amdgpu_sriov_rreg(struct amdgpu_device *adev,
 	if (amdgpu_device_skip_hw_access(adev))
 		return 0;
 
+	/* Select lower 16 bits to read in local xcc */
+	if ((hwip == GC_HWIP) && !(acc_flags & AMDGPU_REGS_NO_KIQ))
+		offset = NORMALIZE_XCC_REG_OFFSET(offset);
+
 	if (!amdgpu_sriov_runtime(adev) &&
 		amdgpu_virt_get_rlcg_reg_access_flag(adev, acc_flags, hwip, false, &rlcg_flag))
 		return amdgpu_virt_rlcg_reg_rw(adev, offset, 0, rlcg_flag, xcc_id);
@@ -1102,7 +1110,7 @@ u32 amdgpu_sriov_rreg(struct amdgpu_device *adev,
 	if (acc_flags & AMDGPU_REGS_NO_KIQ)
 		return RREG32_NO_KIQ(offset);
 	else
-		return RREG32(offset);
+		return RREG32_XCC(offset, xcc_id);
 }
 
 bool amdgpu_sriov_xnack_support(struct amdgpu_device *adev)
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 88b4644f8e96..e6c2fcf452d3 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -853,8 +853,13 @@ static void gmc_v9_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
 	 */
 	if (adev->gfx.kiq[inst].ring.sched.ready &&
 	    (amdgpu_sriov_runtime(adev) || !amdgpu_sriov_vf(adev))) {
-		uint32_t req = hub->vm_inv_eng0_req + hub->eng_distance * eng;
-		uint32_t ack = hub->vm_inv_eng0_ack + hub->eng_distance * eng;
+
+		/* Select lower 16 bits to write in local xcc */
+		if (AMDGPU_IS_GFXHUB(vmhub))
+		{
+			req = NORMALIZE_XCC_REG_OFFSET(req);
+			ack = NORMALIZE_XCC_REG_OFFSET(ack);
+		}
 
 		amdgpu_gmc_fw_reg_write_reg_wait(adev, req, ack, inv_req,
 						 1 << vmid, inst);
diff --git a/drivers/gpu/drm/amd/amdgpu/soc15_common.h b/drivers/gpu/drm/amd/amdgpu/soc15_common.h
index 242b24f73c17..9ddf68e7d06e 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15_common.h
+++ b/drivers/gpu/drm/amd/amdgpu/soc15_common.h
@@ -210,4 +210,6 @@
 #define WREG64_MCA(ext, mca_base, idx, val) \
 	WREG64_PCIE_EXT(adev->asic_funcs->encode_ext_smn_addressing(ext) + mca_base + (idx * 8), val)
 
+#define NORMALIZE_XCC_REG_OFFSET(offset) (offset & 0xffff)
+
 #endif
-- 
2.34.1

