Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CA71CA5FCB
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Oct 2026 14:03:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 36D3410F6C2;
	Thu,  1 Oct 2026 14:03:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="CvyJBd6h";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012056.outbound.protection.outlook.com [52.101.53.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 39A9110F6C2
 for <amd-gfx@lists.freedesktop.org>; Thu,  1 Oct 2026 14:03:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dyYifm70NtLO4Srvt3Q9QFtBHm6UCeYYkg5r1PUjDyqQtFKp0Qijyv1zaCNPDVZ10jrhE702MGFhcQUQ2PRjhzzp0HicalTFVrZ5KegRrTZf3EbbXTZj9HKSSOKbk10rmE6qegC6QUfu9R46LzN0jl3FpPv6fFxntF2ecjG8kpgbcm2mh1VnjiT6kqHdnSdSkY11Zt5/AV51/KY3rAf4XjXLQ8rwPsHHJLteYyM52/9L91r2qQ6PbfppUjEdY/e4MJnULJqRU1DuO5JiuohZNa/TEfUx2pvpN4FI8sFJHNE3EZA8J1v4a8HOoUTqaAnArtPdyfXWTzuIn4eOawNlYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2QmmbIGaTjF1DjzHNcTPxquTmeHmM7lqJnR3ucmMZyU=;
 b=Bx0+MhA4cZGKTGLta7EYflEBBNBVUtRQV2Zs2I/qnS1/xclpCApVybHMHs+u+fWa7vjyG/hidbk/53lOV/ODXp65SP4B+8ljRLtmyka89wVtEbyRI9iq6XEPN344S6VFDmV+/Ur/xb4a+Qv0CtUz0QumT47U/kgKjTnkHO40A++xoJDePNiGPwuvhm6PN/h6VwVtPejL7FYdHm8pvbYnSyFDDpO5icHieMbBZviff/AOYJ1rtgChV+0Rl+abg44LOuRuHJ3OWif0MYL1hH4p5adjiXJ53OCi7pZenCUl1YTQ1nQBZytGKZ8H7JbNp4GQNnnhHnsKT+cQ4adH8cNnPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2QmmbIGaTjF1DjzHNcTPxquTmeHmM7lqJnR3ucmMZyU=;
 b=CvyJBd6hwEujOktTeh750kzHsYeun8MjtkAUoaaALMnRHpfVScQe7NxMhqsI/lzkuf96JmeMfxjP0Ev7nXW0o+ZpZfJCRtiBzz1/r7gm1A/gAAuPd+FUcV+E9yDKRVO9K6y/bIV/cAavaaqB1RBAluSsR7bpxG/XK55vfNDIsMQ=
Received: from PH0P220CA0002.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:d3::14)
 by BN3PR12MB9571.namprd12.prod.outlook.com (2603:10b6:408:2ca::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.18; Thu, 1 Oct
 2026 14:03:19 +0000
Received: from BY1PEPF000264B6.namprd02.prod.outlook.com
 (2603:10b6:510:d3:cafe::aa) by PH0P220CA0002.outlook.office365.com
 (2603:10b6:510:d3::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.17 via Frontend Transport; Thu, 1
 Oct 2026 14:03:18 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BY1PEPF000264B6.mail.protection.outlook.com (10.167.242.123) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Thu, 1 Oct 2026 14:03:18 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 1 Oct
 2026 09:03:17 -0500
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Felix.Kuehling@amd.com>,
 <Harish.Kasiviswanathan@amd.com>, <Mukul.Joshi@amd.com>
CC: Philip Yang <Philip.Yang@amd.com>
Subject: [PATCH v2 1/3] drm/amdgpu: Enable remote TLB shootdown
Date: Thu, 1 Oct 2026 09:54:04 -0400
Message-ID: <20261001135406.4049406-1-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF000264B6:EE_|BN3PR12MB9571:EE_
X-MS-Office365-Filtering-Correlation-Id: 0cade836-5316-4f45-f0bc-08df1fc4bee1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700016|376014|23010399003|10067099003|56012099006|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info: brHc/yeYcIB0kXB3lDbC0lqGQRcLfzgpoUSUzj8DMUW9V16IrEgHiu3Rw5Gib6mWuHauxRmmbnA1lezHjwbX+aF3/3mkzBaA15djHcafi43Q1AguXfOF1tDQHWnJ3hYfLyKk7S94kEBBvBO2EJYaJ9w7AsKUsSpGjZiDJyxuGjzoDt8jS9fEaRdAqbAZXjgxpigJ1tqOkGpdaKB0qshdup5xFfYW2sDApUFeiCwva+rLe75w2wX4SrePFGaJikMxLNOisqC0cmCv9nSW6aeZ4XeaA6dLe/fuacf0u/NS0Ym/EKpUShQzHSKCMCOWyoWz53zatFEUwhV9NqlP73+u7zKitC0931qsOC9nwZgu33UhYKa1xNiuL6dJJlfnWUI87vCP9OFd6HDSXee/IflDjXsrV0eqOXxHbIh/DuemyLjtcd/f8bckSQ9SZnVKTIjX+lPjPidWMG8XfgDQ4DdBnXUw80RAijjd1SfjC/8RvvTTlPkFD9vKXxPvGMO2mUX/GejsvY1Cmssjzs5T6nL4sInkJfYUDDw0us9skJXt8DhKUeUzY0FDXmKAS0WRth6YJNbwixFgkywYK1zacKaLSgocwleoHBSobUNq3H/56H9j5mbQTLx0QNTo6Uk/K8yEo1zJdxTxphujfkK5dshylIUft2WRVS7HhhZ0/aaqGJg4d/wDibU7XKiOFPKyG4oh
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(23010399003)(10067099003)(56012099006)(11063799006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: lxE7YEnWS0Q9La+a/lQB9wj2DBfiPP5dL0aulkIKJRZwpnmifqG3gURLJTbeZDw4xJmh577L8IZEJNxpnPvmXHFRdqikuJC1rNog2p+28Efip+xMnjdgRj1iIoycOuOQ2wkTWyqPcNL/ZGo6UNqKO2TGSW/ATXtdMSit8qxMlGx1BVYgZS/xnYVQWhcNXSTyNO6Y0YfzRfbiC/v1HWfSM2cnlQzx45sypOgqq96GBldI8/nXWewxoRmOIJ2o/+LB5n8d2Km69mVNY3jU3dE22G3yK9uqnM0EKrnOMOGyf1VC9jS+A7/lr2bWJ9YNKzMdw/TAS3RCvOIjuPaElt6RS3PJtKgJsYHkgb5zEH4+Nk7XHZv2HtMCRzK+3iC4oAOTDm602pdt903+9MEgw5sT7zVlwTVMKY4W2IXjMWfoaKCR5lxI3bULVCqkGnlQ8w+e
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 14:03:18.5432 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cade836-5316-4f45-f0bc-08df1fc4bee1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BY1PEPF000264B6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN3PR12MB9571
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

FW remote TLB shootdown support is ready now. Remove the early-return stub
so the command is actually sent to the peer GPU.

This requires nHT firmware version >= 1.2.E.1 (IFWI >= BRP0660).

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
index 1cbf1b5e1631..3b3339c5be08 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
@@ -6072,9 +6072,8 @@ static int amdgpu_ualink_remote_shootdown(struct amdgpu_device *adev,
 	struct amdgpu_ualink_ring *ring;
 	int r;
 
-	dev_dbg(adev->dev, "skip remote shootdown to remote_accel_id %u\n",
+	dev_dbg(adev->dev, "send remote shootdown to remote_accel_id %u\n",
 		remote_accel_id);
-	return 0;
 
 	peer = &remote->peer[remote_accel_id];
 	ring = &peer->shootdown;
-- 
2.50.1

