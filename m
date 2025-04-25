Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C30B2C369D3
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Apr 2025 03:35:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6155C10E319;
	Fri, 25 Apr 2025 03:35:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZTk1sVh5";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2076.outbound.protection.outlook.com [40.107.102.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 056CD10E319
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Apr 2025 03:35:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YFslGn91DdxDdG07lGVOglCjVK6TGU7uOyBTdMukfr63muyJtnTBxSGV6Tp26yGn7Wp8f6yNvu8J9tGDXAKXugZVsiRySQ1qCqACQwQRLPGZHyLlVGvbpjFPdxxTBWcOOOJP4zUu55sofhIWx5yusdixHwTA5qYCESftNKR9PW3tFYO/dBhwqUXKarnOtY407HzruDKY8ahDsSkxjpNW+t44RTKxb+rCLOwxL4yMXPmzY5nWA2vompY7AKVWLtwaoIvgUATDXHAYkvKy8lg0fYlB9fN1mUrkcoIKP/BmYHMe+uz48GQJHnsVPQl+9tKEz923tnpotpU82swVfjXKnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CRVRLYWaoN0gko8trlIsFFP1IHbLx8vqusGVuCGKWHs=;
 b=ewle3m6c6t+NidWml8XXB5lde+cM3G2rcCPy39+mepaoyHRjzUFrvWbx6UaETQw6ks4IbcwYnaQy/Bh3p1Reug/6zDJOH5h95Dt6Fh03U/uhxKMs2N+asR77VenLHAJUqLO4uUw7iYP8MlV03heHUV0/P66snKnTF5fRHSwy3Ot3O5c388H77tUYyraHKO4uUv5g/g/M+2Qo+nCZnd66+FoXiLsJrMkPpzDmGiVsx5MjOMcPaSuQOQ8M2L5Ou56CUoxSYfKxurBzgY8+b9gJyd5iuuJ2d4VqaFCoaAOyxbc4oSLnd4qru9btEDA4aZ5xu3US+YWGbael8HotQHVX7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CRVRLYWaoN0gko8trlIsFFP1IHbLx8vqusGVuCGKWHs=;
 b=ZTk1sVh5gdT67vCczfaVaPqkhkeX7U880NRKCGcm7OjnBVG9ECzf7gBv5vMNSK6zmMSDLqm26aUbI2ZvG4qPaa/jk9mdL/CntrLK29Me1jexfs80Wh4M6p0b7yzNuYpRIOUWdgeNc4rroVcUaJu9K8jfuUN1a8djdv6bGISrP34=
Received: from SN7PR04CA0009.namprd04.prod.outlook.com (2603:10b6:806:f2::14)
 by MN2PR12MB4454.namprd12.prod.outlook.com (2603:10b6:208:26c::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.26; Fri, 25 Apr
 2025 03:35:29 +0000
Received: from SN1PEPF0002529E.namprd05.prod.outlook.com
 (2603:10b6:806:f2:cafe::8f) by SN7PR04CA0009.outlook.office365.com
 (2603:10b6:806:f2::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.35 via Frontend Transport; Fri,
 25 Apr 2025 03:35:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002529E.mail.protection.outlook.com (10.167.242.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Fri, 25 Apr 2025 03:35:29 +0000
Received: from shane-u20.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 24 Apr
 2025 22:35:26 -0500
From: Shane Xiao <shane.xiao@amd.com>
To: <amd-gfx@lists.freedesktop.org>, Felix Kuehling <Felix.Kuehling@amd.com>, 
 <christian.koenig@amd.com>, Philip Yang <Philip.Yang@amd.com>
CC: Shane Xiao <shane.xiao@amd.com>
Subject: [PATCH 1/2] drm/amdgpu: Add debug bit for userptr usage
Date: Fri, 25 Apr 2025 11:35:12 +0800
Message-ID: <20250425033513.1535517-1-shane.xiao@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529E:EE_|MN2PR12MB4454:EE_
X-MS-Office365-Filtering-Correlation-Id: e763abad-569a-4d6c-1461-08dd83aa3998
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?QhirjqMUE8AAHIhLsZBTdI+678O+E6HDaY19biv3An34xHlUAmNCtA8IxeeO?=
 =?us-ascii?Q?ueWqFLS6z1reTa2DiFnuokycY+55NpBeNiYd5B+JDvyyse0vt2U5xU0UkKkE?=
 =?us-ascii?Q?T7Loi8SXfA/a/Il6UBpdl1Uod/X5kvg5YXs3hoQH++eSfYF0nlZvI+WfT/+e?=
 =?us-ascii?Q?scIm6fc9DDi+nwOkY2R3DwkEie+0L3wgvFBhTlEzUlw8gvxKXewaINEJZZbG?=
 =?us-ascii?Q?etoAZ1htGQsF/bfwD7I4aK/j1+JXlHdxUwmTAaSPyryKv4aPKr4cVk/AHAbC?=
 =?us-ascii?Q?EgBD7IMS7R9/d/GHFcfH+/K2nR1bCZTj7otiqrR1OLI7AViKbi1MvqCYzSoI?=
 =?us-ascii?Q?pLr2bzGH08D/p7LBogiVHFj2ANutZaiiWjZeY98JX5ktTb8lWsx29H/jLzy0?=
 =?us-ascii?Q?Ia88/wSMitFiyRHNaZPF0xVBTj0s2D7IvgXXh2To1ZSkHzUAkcG7NTvx+BxJ?=
 =?us-ascii?Q?HphpxK359wVNBGs27PeJBupyus5Dd5j2oQr+WZpOVwpwTueMgf+9CGWF3jLu?=
 =?us-ascii?Q?QxRvuep/7mAIHY3XXYITttfn87pNk61q0ntIiMy7XTfeUqYV4pTwxpRQ19yW?=
 =?us-ascii?Q?lm7mmqADwiJnStpu9wlvTdHlpLp2qzHroBxY38nV50N+ZrJyiEd/kex8/qUJ?=
 =?us-ascii?Q?rLuup2Zd2bbBRJtPM5ViS42Ji36HDLbEMQbqsNksM4RPYFaywxcrNGxuAh+1?=
 =?us-ascii?Q?db9H+b7n4lDOzG27j+O+U6fGRzvX8KzKkT006+vs2F/VP1yh9dvTa1LFz+gN?=
 =?us-ascii?Q?lRtTzSIasVxgqGk5IamRufdUngVobVNZyCkKWmR4nSYWdLN9vGEg97gWsRKM?=
 =?us-ascii?Q?UgcTuVJv77wCBefFNUHbetHjBA7esjBaMh4mct84GZ8uDfHp75PVb5Ve3ukP?=
 =?us-ascii?Q?NdBpCnI+QrBS8hmXRqLAwFLYvhfjKx/NuND8jve/izFf5FRrh1Yc3VWb3nTI?=
 =?us-ascii?Q?IF4mp9g8hBa89f+jrjBnda8BzVDcukNAb1cAAwXoDwu/ajh++MoEv0rERh/v?=
 =?us-ascii?Q?iDRq25Shto5s1cptAXgwtla6JghZ65qf9is5vx+uFaE/WpWFHVefWb3uzFJY?=
 =?us-ascii?Q?HORCwn6uS0CrKZ3YMQIRPfNRuAsN3c4inRyntPTibEin+bOZimfTMp0pbH/v?=
 =?us-ascii?Q?g3TVO+I82OvWsI9Bjiz3gdU9kMjfxzrjAv2B4TDpzMA8WJLit4AI0FKi/COQ?=
 =?us-ascii?Q?Qxg1m7l2NUiJFh9B9VBnlz/vF9gErGACIz18jJ5lVuGAogJVVBJWBYxtN5AB?=
 =?us-ascii?Q?H9Rn73i4EOL8OFMxRXlWJXcwNrFmouCZ3VKq04fvinSz8nUP/FmLjLeY4HJ2?=
 =?us-ascii?Q?xjCtiRk/rsLqZKQ4d7Qj+OQ/kZzbQyeeuPIt7aArhNwg5RPthRwwIsIEUHDO?=
 =?us-ascii?Q?XJAf2cRpxRYjX9SRGvilu7yf3mw9Gtla57sKe9eHEwtJ2112H2wORgyIWnyQ?=
 =?us-ascii?Q?Fu6q3Wfm9bF0R92oqfNIsgjybd39awy7kVj/Tyf1CWRuKgp7JVmkD3W/uPow?=
 =?us-ascii?Q?EdP8ONuLEy/69gZSc+sExCe9Cs9Oywn9r3HO?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2025 03:35:29.0112 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e763abad-569a-4d6c-1461-08dd83aa3998
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002529E.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4454
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

In VM debug mode, it is desirable to notify the application
to correct the freeing sequence by unmapping the memory before
destroying the userptr in the old userptr path. Add a bitmask
to decide whether to send gpu vm fault to the applition.

Signed-off-by: Shane Xiao <shane.xiao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h     | 1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 5 +++++
 2 files changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index cc26cf1bd843..6a4c75124ad3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1230,6 +1230,7 @@ struct amdgpu_device {
 	bool                            debug_enable_ras_aca;
 	bool                            debug_exp_resets;
 	bool                            debug_disable_gpu_ring_reset;
+	bool                            debug_vm_userptr;
 
 	/* Protection for the following isolation structure */
 	struct mutex                    enforce_isolation_mutex;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index b9a1ef343c79..0ea3693a94de 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -143,6 +143,7 @@ enum AMDGPU_DEBUG_MASK {
 	AMDGPU_DEBUG_ENABLE_EXP_RESETS = BIT(5),
 	AMDGPU_DEBUG_DISABLE_GPU_RING_RESET = BIT(6),
 	AMDGPU_DEBUG_SMU_POOL = BIT(7),
+	AMDGPU_DEBUG_VM_USERPTR = BIT(8),
 };
 
 unsigned int amdgpu_vram_limit = UINT_MAX;
@@ -2272,6 +2273,10 @@ static void amdgpu_init_debug_options(struct amdgpu_device *adev)
 		pr_info("debug: use vram for smu pool\n");
 		adev->pm.smu_debug_mask |= SMU_DEBUG_POOL_USE_VRAM;
 	}
+	if (amdgpu_debug_mask & AMDGPU_DEBUG_VM_USERPTR) {
+		pr_info("debug: VM mode debug for userptr is enabled\n");
+		adev->debug_vm_userptr = true;
+	}
 }
 
 static unsigned long amdgpu_fix_asic_type(struct pci_dev *pdev, unsigned long flags)
-- 
2.25.1

