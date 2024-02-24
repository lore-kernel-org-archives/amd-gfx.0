Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13919C5478C
	for <amd-gfx@archiver.kernel.org>; Sat, 24 Feb 2024 06:39:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E0CA110E14B;
	Sat, 24 Feb 2024 06:39:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="EYvS435S";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2068.outbound.protection.outlook.com [40.107.220.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D95EC10E14B
 for <amd-gfx@lists.freedesktop.org>; Sat, 24 Feb 2024 06:39:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iAQ+jZJfCw4D8ISiQoWSLOFYuLIP0IQ98yx24d2/CSo6u7z93kv8jZfdutfWwIDAKWt/9LLBzws5iLo/4QtdQ65/PjnnUeg4taOtejaACtlH+XMwO+Au6mQsdi8AHLKWDm63c8pd/Vy8PVCUiRpZl26xiolKZgADWY3mr0s1GCNV6hP6JmcxR6tiT+w3bppp7ZpFvQBfpIqPZ/9UImvEnsQ/LUZxUWRP4twF6y7pSoojtYsTNI0+qzpZ+HXuFBbUP/iE1jLL33XiQjOjrsD343Sv6ZhHvbxwNX0acvkosKFXhMCB62WbSW4mG7RDSx/kYChvRvpSz+cISEbIaySNvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EyYSvqCrHvk+BQNIFjEv9fZL0lf+Vmw8++B7Syu2jXI=;
 b=Ukrx5TcTo23FOHOKiMvvLB7GaX+VBwJwW9Mewj2j7b6g9Fk9I8YJMNqKMsIw2wf8ABV9Ud8qVr2mdm9QiLFrMCtTrTW+IfJdwR4tfHkb/FvxAoUID/jYQB8Gv89lfDPq7bulGt5sozplvT4KDsr8WUJYiaEPB65rU/NO70OSEhuhocgwEjMBQnB+19WI7CrwjR/feXgxJpalz/Gu6YSF9D3HjBS91PklHb6TH8aRk39X8evyGTUfFZZ6J+FADc0BWSa28JfUQ5iB3MRuDDtsk7lrIBde1x3S58WbbUoqwCfItvvMiYJ7c85Dvs5TT9V7Ux4Cdl6N5gpPFEq/eToXFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EyYSvqCrHvk+BQNIFjEv9fZL0lf+Vmw8++B7Syu2jXI=;
 b=EYvS435SY8U/HmsCxMCFd6KcoolW01+47X+pHKp5Ho1L/gBckxTVYoNgkDo2hIag9/AXD9G/mSnZw7KGmofa9lJnV5KALuB0Bw4HhH2x350tEaHOrCbbgY5OIkim+7WEIRG2pjxHUThhr0LQuiTPXr5yODmtRtURonHKkFDy3Ho=
Received: from DS7PR07CA0010.namprd07.prod.outlook.com (2603:10b6:5:3af::29)
 by SN7PR12MB7853.namprd12.prod.outlook.com (2603:10b6:806:348::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.24; Sat, 24 Feb
 2024 06:39:04 +0000
Received: from DS3PEPF000099DA.namprd04.prod.outlook.com
 (2603:10b6:5:3af:cafe::7f) by DS7PR07CA0010.outlook.office365.com
 (2603:10b6:5:3af::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.47 via Frontend
 Transport; Sat, 24 Feb 2024 06:39:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099DA.mail.protection.outlook.com (10.167.17.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Sat, 24 Feb 2024 06:39:04 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sat, 24 Feb 2024 00:39:02 -0600
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, Jammy Zhou <Jammy.Zhou@amd.com>
Subject: [PATCH] drm/amdgpu: Fix missing break in ATOM_ARG_IMM Case of
 atom_get_src_int()
Date: Sat, 24 Feb 2024 12:08:47 +0530
Message-ID: <20240224063847.1512027-2-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240224063847.1512027-1-srinivasan.shanmugam@amd.com>
References: <20240224063847.1512027-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DA:EE_|SN7PR12MB7853:EE_
X-MS-Office365-Filtering-Correlation-Id: 2bdcc75a-ec35-4d8d-3864-08dc35034b42
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ruzt+WsEHbW/J0V5rOs+YY5DmPKXrXwD+I2qCnEhpM+90aNAPZNiIjOT40H8qXUSzhb+pOJ/Ys2AY77FSTtUXadSH/4B0IDofcGpyYME7gQjbkMLW9FDiyffPrFhPQ/kZUY1fHQ9aJ2G2ga16e8RnVQnKJRx8lZeTmtCrdnM43m+ervm8h6wQaxoHw9FsupxcUKne2hUuXwK4Obe/Be+uY4SjjciCI+GRCmWI3C7MdVV3/cEQx1QH/mVXOMr4lDt+hUUxQUJ0+6N+lwZ8nOh/7CVxgnQuOMIxDEJ6fLgwdRtUFV4OyWlmx9XIocc41GjIjGDx8cISm7LCWpXPBHbYPEgGBL7yR5/a7J/DK4ALWgzNj++ny11Wo4zQEweAycYem/xEHvBwvXM99/Mfo/w0Tv7CIvoNM+rh0LeqStR0LLg4oLb5XefdU5X4fLoldqCJtJpiVWA8rtUfZImJNSaozUa4T3P4iNUG9rsJbHZ3WHO8bshMtW6pBgVmP5yN6LMGZqspDfujfDoXxo9Itq81EZO8yf515YXdTHK/6fUxIAo9L3SSCvArj1h4QiqTkd6tiakNihq+lIcaiLe48C0u9rnqsh34hYiu7Yy6bP1sFwSQNPr83HU11K+2QvelAd1DhGsatLxa7Q7edF+CmLSLvfUZo5235txwVMIoeKZqpg=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(40470700004)(46966006); DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2024 06:39:04.2635 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bdcc75a-ec35-4d8d-3864-08dc35034b42
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099DA.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7853
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

Missing break statement in the ATOM_ARG_IMM case of a switch statement,
adds the missing break statement, ensuring that the program's control
flow is as intended.

Fixes the below:
drivers/gpu/drm/amd/amdgpu/atom.c:323 atom_get_src_int() warn: ignoring unreachable code.

Fixes: d38ceaf99ed0 ("drm/amdgpu: add core driver (v4)")
Cc: Jammy Zhou <Jammy.Zhou@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/atom.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/atom.c b/drivers/gpu/drm/amd/amdgpu/atom.c
index b888613f653f..72362df352f6 100644
--- a/drivers/gpu/drm/amd/amdgpu/atom.c
+++ b/drivers/gpu/drm/amd/amdgpu/atom.c
@@ -320,7 +320,7 @@ static uint32_t atom_get_src_int(atom_exec_context *ctx, uint8_t attr,
 				DEBUG("IMM 0x%02X\n", val);
 			return val;
 		}
-		return 0;
+		break;
 	case ATOM_ARG_PLL:
 		idx = U8(*ptr);
 		(*ptr)++;
-- 
2.34.1

