Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E954CCCFA04
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Nov 2025 07:31:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9277B10E52E;
	Tue,  4 Nov 2025 07:31:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3KIT8RCU";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010049.outbound.protection.outlook.com [52.101.46.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 16A1410E52E
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Nov 2025 07:31:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=reIhTroNhgZRiahqcjj7sJMH241NX+WbSK3kkNfOnTACGu3YHLg1ftNQYV3P4J6r/R+6bXIfGBD6BwYukJrCDEpm9784Xm5AwPdE4L8f0eeL5EzTcRCCO5/bKJVlP5UqAk+d0p34NUofi8yjetbu6Hl+/XrO3F6lyX/NYFZ/Yj1EGMuTN3/8OCE31TxVNHm9mds10xNk8CsksmjLFQ8viKWp51CzEj1HiK6Q3tP/wTF4smU9ZO183j1BcJ6vn1AzodfWG/rQt6rZzuE4cW7tmVq25Indfh37PmojPHVszZZz3J8fkgDwCA2iiPt1yWe2ujBcRRytkWh9Qb1oECFn+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Du1P08CHwiDGiQUA4k/f1q+yCsuHBSNaUsJRKiG/QdY=;
 b=SUmFAmEi/r5bRHbkqbDja4BNsImfewjZHRhGgDnuvPB8xthSAKFvtjqxAaeiByRXV8T/j8M+n7b/6Nk0W+qR4ovfumikjehLJdaCgLbnf+gsxCkv/H0GEHn4+38YgqDS/Uz+vNZ2MQMmtOHpZgwRrOLBatPIqugeJS7MJ5/jf2HwiCiYejJjOQuEFf7YNDZ3G6kGSNLxBV3tbqKtnB+AxuOKvTstE/FESzWxYG4bHCVpuabEQZ0xEaLMQvLlMhbuKTjgwlYOuGTjRFuDVUw/m5GmEaJB3XXTRFmGae/3qNSGfHaDcTsaNo1eWsLrHC8YReP1cyF0WDkwQZOjtEGvWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Du1P08CHwiDGiQUA4k/f1q+yCsuHBSNaUsJRKiG/QdY=;
 b=3KIT8RCU2eNu7bh4A0xJGJ3ttI/1Q7W6N5Bq1822nD0+ZmZsT+316YXTjJgmrZd1V7qYABppojpPdkCy+Dc9NS+a06NGjGvJhzN2/5i3ekaeZ1xlQzKswOERicYWfx5uNOGWPoQGRRFJ/7Om92LMfL3RGFp3B0RG8bbkdJGZVVo=
Received: from SJ0PR05CA0127.namprd05.prod.outlook.com (2603:10b6:a03:33d::12)
 by SN7PR12MB8004.namprd12.prod.outlook.com (2603:10b6:806:341::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Tue, 4 Nov
 2025 07:31:28 +0000
Received: from SJ5PEPF00000207.namprd05.prod.outlook.com
 (2603:10b6:a03:33d:cafe::77) by SJ0PR05CA0127.outlook.office365.com
 (2603:10b6:a03:33d::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.7 via Frontend Transport; Tue, 4
 Nov 2025 07:31:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ5PEPF00000207.mail.protection.outlook.com (10.167.244.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Tue, 4 Nov 2025 07:31:27 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Mon, 3 Nov
 2025 23:31:27 -0800
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 4 Nov
 2025 01:31:26 -0600
Received: from banff-cyxtera-s81-2.ctr.dcgpu (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17
 via Frontend Transport; Mon, 3 Nov 2025 23:31:26 -0800
From: Samuel Zhang <guoqing.zhang@amd.com>
To: <lijo.lazar@amd.com>
CC: <victor.zhao@amd.com>, <haijun.chang@amd.com>, <Qing.Ma@amd.com>,
 <Owen.Zhang2@amd.com>, <amd-gfx@lists.freedesktop.org>, Samuel Zhang
 <guoqing.zhang@amd.com>
Subject: [PATCH v4] drm/amdgpu: fix gpu page fault after hibernation on PF
 passthrough
Date: Tue, 4 Nov 2025 07:31:02 +0000
Message-ID: <20251104073102.257287-1-guoqing.zhang@amd.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: guoqing.zhang@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000207:EE_|SN7PR12MB8004:EE_
X-MS-Office365-Filtering-Correlation-Id: e58c8fe0-8e8f-4bb0-698c-08de1b742aad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?9aNIEEVjEeA7H2IjB23aP7xal0FgZM45HpvXBKxrSz2ZUaSTiG/VcI7gibzw?=
 =?us-ascii?Q?HoUABMX1zJETQ6JtPAZf3uiwy+e3GHAPL3gbRh2uz1lOgjlEx745a024u8Tp?=
 =?us-ascii?Q?fEpiguowCr3OzF+N5zZwIYlIf48obc5bU2n6twgk7TrCpZybwFHm9Qs1aYEz?=
 =?us-ascii?Q?1FS1L9pkxVWeLVGmobRuFCo17YlhT+40rFdQRmGWB33q11tPNoWNw9HaEnwS?=
 =?us-ascii?Q?E7ClmMB1f1OWlsUNP/kBYLzaxx7zEfmBctBNLiJRXMvOJr/AwNEwx7k+ADno?=
 =?us-ascii?Q?FCVXomKA2RmAmbCz/OwiYxZiA4nEOqE7hb6g2bf+pb/32JdlbHz74r/LN/T2?=
 =?us-ascii?Q?MAKBvJqio1eFT++45pSyLJJAM0m/p2Lj/I+KsoMazn+TbJ36QOJRDAY7QWdt?=
 =?us-ascii?Q?V7KE9F6O5bXRrtwKmYDVYSa+TSxAvEMMwoqK8GM4Ohh2xuhI6uFpwrY8H9bx?=
 =?us-ascii?Q?47THTQt/nxeKFf+XtbkkUBoNhoi95YYCVI3kfgrSmV/BNIK3romuGA+EYsW9?=
 =?us-ascii?Q?ou0QgxPJLU8lSKLyYIXsosjQdmzdJe7PrcH171BUOHKYNeJAewu/V0C6Mgs3?=
 =?us-ascii?Q?os0i++lVNfmoO2HFqPshXWxeOj+TMZ29eXl13Wfsz+yvYEwbfdHPdGgsMyfw?=
 =?us-ascii?Q?Ltxyntw41WUepTGnDTI05OefyLmvx2sYRgAmabW0A3mHdjknF1FRgU6DsAxz?=
 =?us-ascii?Q?B01HAZ5AAdX7xXFgkQ4eZ3JOd57+qoe4FZG6vj72rTrzA5SIlo+ywrzcGMDW?=
 =?us-ascii?Q?kN47AzZkVm/UTfsP6A1JX6+Sk+kQlBROFfW9Ac2Mem/BR3TNpwHrniA9PaJv?=
 =?us-ascii?Q?bWwVqYX6aa68M4WZlTFJtwtz2Ai0pRmmMFsk3ocmlwlUfMCs5FT5gwmaso+J?=
 =?us-ascii?Q?+5afKwm1um27xilVHCOgLXbz783VzNO7IS0jp40VCQ1TXyP0SqwlZIM4EORF?=
 =?us-ascii?Q?vzkw1Zojcy2pYiRFVg9A++D2rd8+xdaFblZLRBM4gS94zfhE+u2rZaah7cO5?=
 =?us-ascii?Q?ldKofBVEpwbKAvllDoLYBXV4BFMiyvXi4m1fMfjUKdxkguamOAcCfTCBeE6R?=
 =?us-ascii?Q?6wzP2Ns+YxgvKMF39TbjZUBAoqKToUv5HyFzAhYWL1jGKWAhFTV4f2W0mwV9?=
 =?us-ascii?Q?Iu690WgMS4r7GS++ND7H7SLtPP43AKrxs/QnthvgQtlKJhoG5Yy1YpOX0Fa5?=
 =?us-ascii?Q?sC+4Mi91uY6O9tinURSb3vLPYIaiFFfAdIIgHJxrVE8FxLOVl1cZTL/wG2EU?=
 =?us-ascii?Q?DDE+F8PeguYp5UMm8wEe9rXCWWH9hHPHkSpttszOkbO29FP3Wh9k38TEOdsw?=
 =?us-ascii?Q?qp4X3F7XUXHMo8K7JqJTvCUn05lurpjMsH6IP+p+cvfki7ZAEjNlcZF9G6rL?=
 =?us-ascii?Q?UJhsjpq8xGeHVynfWFHYPyymzV0l9wWpay24K8IKI7KL2/hM7pJyIDPyKb1K?=
 =?us-ascii?Q?7QY3uOdUWW+VOhnbesoqEaaGnHWzbGg8NNJlYeuc+SbLtbmY4OiFg+P3Oz9O?=
 =?us-ascii?Q?YzVWguJW5hOXn/iQqCnE9jZLnB2j8FPOAe1LivhlKXO9XiZpRBYBCx1y9EPd?=
 =?us-ascii?Q?UJEKPmK+tqO6oVkOh4Q=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2025 07:31:27.8011 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e58c8fe0-8e8f-4bb0-698c-08de1b742aad
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF00000207.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8004
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

On PF passthrough environment, after hibernate and then resume, coralgemm
will cause gpu page fault.

Mode1 reset happens during hibernate, but partition mode is not restored
on resume, register mmCP_HYP_XCP_CTL and mmCP_PSP_XCP_CTL is not right
after resume. When CP access the MQD BO, wrong stride size is used,
this will cause out of bound access on the MQD BO, resulting page fault.

The fix is to ensure gfx_v9_4_3_switch_compute_partition() is called
when resume from a hibernation.
KFD resume is called separately during a reset recovery or resume from
suspend sequence. Hence it's not required to be called as part of
partition switch.

v2: switch to use amdgpu_xcp_restore_partition_mode().
v3: use in_suspend to replace in_s4.
v4: refined commit message and remove comment

Signed-off-by: Samuel Zhang <guoqing.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c | 3 ++-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c    | 4 +++-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c b/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
index 811124ff88a8..f9e2edf5260b 100644
--- a/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
+++ b/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
@@ -407,7 +407,8 @@ static int aqua_vanjaram_switch_partition_mode(struct amdgpu_xcp_mgr *xcp_mgr,
 		return -EINVAL;
 	}
 
-	if (adev->kfd.init_complete && !amdgpu_in_reset(adev))
+	if (adev->kfd.init_complete && !amdgpu_in_reset(adev) &&
+		!adev->in_suspend)
 		flags |= AMDGPU_XCP_OPS_KFD;
 
 	if (flags & AMDGPU_XCP_OPS_KFD) {
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index c4c551ef6b87..cbb74ffc4792 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -2291,7 +2291,9 @@ static int gfx_v9_4_3_cp_resume(struct amdgpu_device *adev)
 		r = amdgpu_xcp_init(adev->xcp_mgr, num_xcp, mode);
 
 	} else {
-		if (amdgpu_xcp_query_partition_mode(adev->xcp_mgr,
+		if (adev->in_suspend)
+			amdgpu_xcp_restore_partition_mode(adev->xcp_mgr);
+		else if (amdgpu_xcp_query_partition_mode(adev->xcp_mgr,
 						    AMDGPU_XCP_FL_NONE) ==
 		    AMDGPU_UNKNOWN_COMPUTE_PARTITION_MODE)
 			r = amdgpu_xcp_switch_partition_mode(
-- 
2.27.0

