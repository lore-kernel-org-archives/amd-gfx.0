Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3C41C52D7C
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Aug 2024 17:00:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6D84010E13B;
	Thu, 15 Aug 2024 17:00:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nr1Elake";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2058.outbound.protection.outlook.com [40.107.212.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4605910E13B
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Aug 2024 17:00:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KtPr3vnN6NyiODlKVyqhdUnKsZ4YUlt7sEhGp5zjM+SmSIn7jmmUo1LRqEXu24iA64ZjbY8FVhtjDbMgrHd0OZsaP62uOlsvM8VP0cAlVvvfH/kDrDY2AG8fl7trukwqUhyUBLBXiUJGAF0SVc9n+jUAf/MxCT0Fy3bREJOh8yHXFFFh5LiYuEbPQYUQaqyjzCKjrYQgF4DCjf0ZHsimE6umEaj85vqY6NY8WiD9wqcDmwHDk83mgXA4kn03Ix7uJBvCj9YK5Ah2I8gK3IZ7GKjvxc+B6sopGqN9+BFxB0FSWkhatcznlaGCcDQVdTBO5s/jdmXB4E/C0xxBI5sgiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mIHt4oYjqUlaQliBuGpFiovzdr1Eb/vgkspCQHbWT74=;
 b=y8807kbUeiy4Juk1ZV1PCXDAumkd+eUC0TomK9bzcDnmcA+VVGx2gBGFIeEsS6EXU/+ZCcqFU5gSzTwMzZu+qQEe5tdzmVXxh1gaQJkC3KO5dszA06Qta3HqlbgXTyC8+Su8xXWvAnYlZpjfLHrPEXoios6FuOKRJunD2yVVaGwSqFCigtBNdLQILTI1j2bzqhxMRL6U7rgWsOjME3Nb3lYlogIu4l+QSPxYsXXCs717cBgFByVto9lkxNFsvAldL5FaqCe9pkgirpU73G7q/qSF33sYDeGcZXio69VeCZvcWH9C93S9ypO/o0wp90LFlpFKz9Q36k9lk+sdzKRk3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mIHt4oYjqUlaQliBuGpFiovzdr1Eb/vgkspCQHbWT74=;
 b=nr1ElakeG9J5zuN7JigbE7dGJEeDBeISDRtlSO9CGgnpwY+QYnWBI3C8BoG9M8qLboJ5nAdllTf9t5OLaTHkeNh8yQnd/RI5Um7E0HzpiGxUu29E/StFGR60PHlPwm9T9DMt8A/c0uro03JpZmT0y5lr7SlgzVJIbrA0Jeyo7X0=
Received: from SA0PR11CA0096.namprd11.prod.outlook.com (2603:10b6:806:d1::11)
 by IA1PR12MB6532.namprd12.prod.outlook.com (2603:10b6:208:3a3::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.23; Thu, 15 Aug
 2024 17:00:47 +0000
Received: from SA2PEPF00001507.namprd04.prod.outlook.com
 (2603:10b6:806:d1:cafe::1e) by SA0PR11CA0096.outlook.office365.com
 (2603:10b6:806:d1::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.33 via Frontend
 Transport; Thu, 15 Aug 2024 17:00:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00001507.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7849.8 via Frontend Transport; Thu, 15 Aug 2024 17:00:47 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 15 Aug
 2024 12:00:44 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 2/2] drm/amdgpu/gfx12: return early in preempt_ib()
Date: Thu, 15 Aug 2024 13:00:30 -0400
Message-ID: <20240815170030.2582607-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240815170030.2582607-1-alexander.deucher@amd.com>
References: <20240815170030.2582607-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001507:EE_|IA1PR12MB6532:EE_
X-MS-Office365-Filtering-Correlation-Id: d224e29e-3f98-4785-b9a9-08dcbd4bceec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?mrS1xaog+c/ZN98s2LO/z2XatLP9xv1yDMkWVNM/ZvCHCpoSE7Td/Q6p4Jy9?=
 =?us-ascii?Q?/6B5VRa0JkSAH/FX+v3HJXtJNTqvVAG6NC9RMYEIOhHE3Rt2qKUOGKjkqrbj?=
 =?us-ascii?Q?bBxzW1/z6F6SctU50nZNGUxLiQocI8nEsaGitT/WvVpg3Qd3aJt66oqf7buO?=
 =?us-ascii?Q?cjfuzcwOjtp73AWbbS1c3+FfKC4HDaCCgft7hsEEem4Njh1ZrGZcDpfZFPM5?=
 =?us-ascii?Q?RoES9tCMM30uhkYaC39cZGTHwFQyaQattIDDL7hx8OQweI10ShxjbKmIcBx3?=
 =?us-ascii?Q?JuRTgPOI8MhEkWbN2TNafLmmRgWarYyhNg5QdEHUEvdEfHtGN+vdDYSj5QWn?=
 =?us-ascii?Q?TwMN1D8dPT2/i1mbGotJhpSlPvKZ6qeAaj0ABpGEk9kAM2UYPI9JPEXcpUDi?=
 =?us-ascii?Q?M2rclfWW4z0RoBUk6fURHAN9fttMGgu5MMPoBRvaQs5F909Psnr7dafLP+Xy?=
 =?us-ascii?Q?M4I9t5+Ktcm5wsOnJLdhFh1jfA7atPp2zdbIjpRXyTpmcUpspRcAFXP1zlJD?=
 =?us-ascii?Q?HZiDmgUv7wP3QkSJJjVV/wdoGRF91Axh97c354nF4eyvRt/6F037oW0XjoPK?=
 =?us-ascii?Q?3baFJkwvlJ+ktzLelvkPL1r+aj2SO+ZpM4Q99KRsxOa5LtaAqP607R+sf0rm?=
 =?us-ascii?Q?o5UJZI+KmXEyGytREoMPO6CDvU2Ql3lkBfAYKktZuCXIvbm9lCf6vcWABbUL?=
 =?us-ascii?Q?YKOyvDYDDAYYu+jlWErITQORv1vAtzWMSAp8oUZ7u6rw57AtXFy60Wu98Mzb?=
 =?us-ascii?Q?yIQFhj2Gp8Vxh3yBkxuxl/ZN86F5+CmuuWEvqIFFPoC5zx1PT12Nu/3mmzNY?=
 =?us-ascii?Q?GjNO3o4iPwPPdMU8K9vWYyZEc40As5PjadxqpNWLcOYqyPkpMdP4WZUrRqRZ?=
 =?us-ascii?Q?6UP7TZCOKh8PTvcWWIA6UN0POVKsDbcfPjCECD2RdQZsiEtKzHvj4hVe6OPk?=
 =?us-ascii?Q?bQ5v7GJiHHRSzZJqscz20HpKKqAHrNkXLOouf0jgOESKYDl5E/f0J5VOE9nq?=
 =?us-ascii?Q?mOxULD49TPhTT8xpu3uCA2aV/7pJicQb8zIuFHD9KVULoEn5CTgm976/5J6h?=
 =?us-ascii?Q?FjFAIIhmOc1b7kAG85B18IlYH7hqcAM+KgNrZfMVtZX+UZmJcIlD4m2pPRP3?=
 =?us-ascii?Q?kdW41TuDiGA2GzeIuCHb20mt/EyuQACSWkRu+8Lp3xdK2KQ0NzV668FI5mBo?=
 =?us-ascii?Q?sNvGluLo7u2v/CrbGyRfOam13m+Xz4tSfDz9BYP3/YKQ1sbQpvLZQBMjXRyC?=
 =?us-ascii?Q?QbG57WHeecWewQ15XcNHFiYu6SOwSNdedGXISxxB1DqIQ1Z3UMOQQX/il3By?=
 =?us-ascii?Q?OnJ3P698FAqjocj+JcQWyhn2/pmJenu2zCZSMus/kN3YSGptayekovcQhVgg?=
 =?us-ascii?Q?gonj2RbffjxIOiY+ii2oxT6OvzRniPfCGu+/3vPdMWT0Ufe/zCzfX4u4Vm8o?=
 =?us-ascii?Q?wVmXTLxMEn7+eiTIWFLk2JdOgGtBocJG?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2024 17:00:47.0803 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d224e29e-3f98-4785-b9a9-08dcbd4bceec
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001507.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6532
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

When MES is enabled KIQ is not available.  Return an error
when someone uses the debugfs preempt test interface in
that case.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index f14e27f86e0e..070546c8dd59 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -4501,6 +4501,9 @@ static int gfx_v12_0_ring_preempt_ib(struct amdgpu_ring *ring)
 	struct amdgpu_ring *kiq_ring = &kiq->ring;
 	unsigned long flags;
 
+	if (adev->enable_mes)
+		return -EINVAL;
+
 	if (!kiq->pmf || !kiq->pmf->kiq_unmap_queues)
 		return -EINVAL;
 
-- 
2.46.0

