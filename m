Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCA95C021A0
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Feb 2025 11:30:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4836E10E863;
	Wed, 12 Feb 2025 11:30:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="se1g3DIJ";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2043.outbound.protection.outlook.com [40.107.243.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 463B910E863
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Feb 2025 11:30:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M8oxIJbSSrT5saUuuYAkhcT2OgXNacFZtgmTwMwcBW4Wt8tXz/MNeHrep+3OcGl7nD1JZhA72geK0xuwz+IrgECUhwqSdO/229gl6JYZt/GxyRgFEPpgNZXfifMj4T2+Z/GLKY7x711czkzDB86uXSURKHBgScwPtJsBB38rMBIlf9PHQeKs0v2K+TSKtOgIth76EUXgPYIQbsZGKaL6DIm1X2Cwi0Xbig1TjXZeIMA29kbvBqgAsQvqLI2DKGpfKriuDBXW3ZOTcO41QShmoDu4FwdVYkI5y/AJQS6AlYjeFifO6y0EPnFI+i9CNr9WEs+XjAOUvmjJbn5dxSvoGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Uu+6FrSYoDKzuCPkAW7briAi4pfTJKlTDLcXZaAD7Aw=;
 b=ZmHtK0SBd475+7sH2JXVHh2MxAi0lo9AXnVlHIfMSV18/W6FfVTcyEiJ8rZMdsDXdQ3CV/8uml7t3D84U21Uc2XHgNeXUxhIpxr/N0CWvpfLcL5z3oySPZTXL1J4BbtK53pLAIpJE6f/3DAPWrmL2e0aLhVZLGzK2sCtHRYeJ3cpBvHXVwjbsCcAHREOcL0J2Xt5K1qJEcGNiImoPCyKTCAyTwXhGLWHjM9As//aYp4bplxOEU/42gsffz2AXWeUKH2WXhXXPSAsvbruaXMsaebNZy4R9haiISZTnav1I6/f7iYqIsipwlgTNWKV23bVh4od8wyk51vjrQFix6WQyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uu+6FrSYoDKzuCPkAW7briAi4pfTJKlTDLcXZaAD7Aw=;
 b=se1g3DIJBB4PkRB7gtF7K+o1AAhzw6Ey3o+YxvSAYYIUCjQxSzwPWytIcLk9elrSke+OP5VEFT0izcfQIPu4DAs4V0DrpTolGiRR6BWZ4Q3d4/oyMJwy1uBnvGPDbWv+UfoCQtvm93Bo2HN2z9Inh3KBF82a00YEGVj1u163zy8=
Received: from CH0PR13CA0007.namprd13.prod.outlook.com (2603:10b6:610:b1::12)
 by SA1PR12MB8987.namprd12.prod.outlook.com (2603:10b6:806:386::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.18; Wed, 12 Feb
 2025 11:30:13 +0000
Received: from CH2PEPF0000009D.namprd02.prod.outlook.com
 (2603:10b6:610:b1:cafe::70) by CH0PR13CA0007.outlook.office365.com
 (2603:10b6:610:b1::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8377.7 via Frontend Transport; Wed,
 12 Feb 2025 11:30:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF0000009D.mail.protection.outlook.com (10.167.244.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8445.10 via Frontend Transport; Wed, 12 Feb 2025 11:30:13 +0000
Received: from lm-srdc-pc1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 12 Feb
 2025 05:30:11 -0600
From: Le Ma <le.ma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <hawking.zhang@amd.com>, <lijo.lazar@amd.com>, <christian.koenig@amd.com>, 
 Le Ma <le.ma@amd.com>
Subject: [PATCH 1/1] drm/amdgpu: fix the memleak caused by fence not released
Date: Wed, 12 Feb 2025 19:30:01 +0800
Message-ID: <20250212113001.2286084-1-le.ma@amd.com>
X-Mailer: git-send-email 2.43.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009D:EE_|SA1PR12MB8987:EE_
X-MS-Office365-Filtering-Correlation-Id: b7098f83-084c-495a-90d2-08dd4b589daf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?se9yUBcCNgrbgoyvMrhmS4QsMqX4j22gwmlfAKR73m+o9jbz6aICsq9qdTkB?=
 =?us-ascii?Q?KFyKAy3Wmlhn+DNKTK28UZ81vednUrQCEScTU6SbHmDASDsQdZyuqf2hPx67?=
 =?us-ascii?Q?IMxFzBfHm5BDtI2pJ9DLefI3ERnYohSvselbCNTq7i76+pOxO1VqbuX5jVVJ?=
 =?us-ascii?Q?FXG8N+lA9FX89OPLkggI0bRqVQ4AKZ9NlVJ9/xzypZ7RD9LOoWJG13o3ZThb?=
 =?us-ascii?Q?EA6bjuiBwXWfOwp9Fmi9AQk3SY+Jy6MOwHHFhwUB+tzDKcq1pu/x2B2qQo76?=
 =?us-ascii?Q?7t96qFZ8oVcrmkq90VqJeijfaF8RGuI3GbCcPNc2Z8h/kZSwUguPXNitmT2k?=
 =?us-ascii?Q?WHJbcEQg7Y9mQzB+wfQlDDw5rxyxS2tdKDtcWKuVIdhxjX2T9kDLA5lMLCaz?=
 =?us-ascii?Q?bmLNh6JGyJjJUK8oDox5NSzeOYTi8DCiZoTv9ivIRjur6AMrKgWJuJxzPR3r?=
 =?us-ascii?Q?uXro/7Yo74GtxSitnPawrUNlppkNzgPHNbVYqafsubnrNbkyvOUVeRPdoIqd?=
 =?us-ascii?Q?/kDj3B68Ld5Ke693FLmQVSvQURCH2wuoawbduF3X2WY0DsfuqSZ6KlCzdwXi?=
 =?us-ascii?Q?SIWhl7+D/5wqBJdkORkd9JTpPOBuj1w9JAM8HM+AN5niID0k87cLAFW3Rd1F?=
 =?us-ascii?Q?UFuGzw8eQeTHt34r8XLF3rqhej3jMAXwEBp+1f8sqkVme7I0V73t/vFtbIYc?=
 =?us-ascii?Q?u4jCua7b3F0bg6uRBYpmyLxJ9nQExSQ9oxrMGSDIY6AUsm7rsO7nK+FhSuCa?=
 =?us-ascii?Q?hczd7jJi0U0TtuUSJgviNWdDxlLCvnvLVNomvTcPIl8nWgdiZKY92vxO/0Ie?=
 =?us-ascii?Q?iBJGfPlK9mgzW1hgYRrMHX3w7+MtKCQOmWiM7RNMCk7B+Uxz0YkHfP8WMI9L?=
 =?us-ascii?Q?NX2WgYst4GWIsXOqk3zU28WbzAnJJBP2E79oxNV/l7OshthwvcXaF/yPr0mK?=
 =?us-ascii?Q?lT01kbv5AvmS3LTdEYtR8DXL1TUzc9GZwhL/gDmXDgYf2utCGVMT5ZFqP7Ub?=
 =?us-ascii?Q?yAUAvSf40xTIUiVXr7Ax81j0gw71g1OzoaY5GFO85jJo8tPzsyMf1nMZ14Q3?=
 =?us-ascii?Q?y6EvbcfzADDMV52zlzcHWwZcMNz6rSPyRB7FjUmk6XKd0H4oN2tlw6gaDW0N?=
 =?us-ascii?Q?tLyP1+wI2H7mIWM15+4Di/TSp/qw8LNurszCtEFvQb+PQEvF5fd74N2FaYfN?=
 =?us-ascii?Q?EOWbk0hQgH+cyuS3ma7Wf+oAuPKI2rqvEPp5W3613J0diSpETXSI3AixX7Fo?=
 =?us-ascii?Q?D/xOggoAAVWuUW60Gd4QWhb5qVJrHtBMrijmBcZz/cnODZSBKpcg9oso69gO?=
 =?us-ascii?Q?A2wv26TqKmTb8iX9rTokc/jzhFi+AwezEVeZl1Cu1+VT1N0J0yVwUQM9yWcE?=
 =?us-ascii?Q?88XsnWFkujbgp/J9I9puRs3IFHkkYkRLZx8KOeUW9W7Ra/YGkCNYI4Yh+qL4?=
 =?us-ascii?Q?/Y4EAUvhRhe+ndlbL4yhgE0Q5vBsAtMOvEaML1rd7xgdWIDYo/P53J9kDyqg?=
 =?us-ascii?Q?D5+FZ8jZ0dCois8=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2025 11:30:13.0431 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b7098f83-084c-495a-90d2-08dd4b589daf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000009D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8987
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

On systems with CONFIG_SLUB_DEBUG enabled, the memleak like below
will show up explicitly during driver unloading if created bo without
drm_timeline object before.

    BUG drm_sched_fence (Tainted: G           OE     ): Objects remaining in drm_sched_fence on __kmem_cache_shutdown()
    -----------------------------------------------------------------------------
    Call Trace:
    <TASK>
    dump_stack_lvl+0x4c/0x70
    dump_stack+0x14/0x20
    slab_err+0xb0/0xf0
    ? srso_alias_return_thunk+0x5/0xfbef5
    ? flush_work+0x12/0x20
    ? srso_alias_return_thunk+0x5/0xfbef5
    __kmem_cache_shutdown+0x163/0x2e0
    kmem_cache_destroy+0x61/0x170
    drm_sched_fence_slab_fini+0x19/0x900

Thus call dma_fence_put properly to avoid the memleak.

Signed-off-by: Le Ma <le.ma@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
index 8b67aae6c2fe..ad3c5fdf6970 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
@@ -125,8 +125,11 @@ amdgpu_gem_update_bo_mapping(struct drm_file *filp,
 	struct amdgpu_vm *vm = &fpriv->vm;
 	struct dma_fence *last_update;
 
-	if (!syncobj)
+	if (!syncobj) {
+		dma_fence_wait(fence, false);
+		dma_fence_put(fence);
 		return;
+	}
 
 	/* Find the last update fence */
 	switch (operation) {
-- 
2.43.2

