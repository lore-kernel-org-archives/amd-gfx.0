Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 442C4C19F4E
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Apr 2024 19:59:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3F7AB11A865;
	Thu, 25 Apr 2024 19:59:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="JMgz+pJI";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2073.outbound.protection.outlook.com [40.107.223.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1BD2C11A862
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Apr 2024 19:59:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LFZYC6EKjaaaImGDkD1GdjrkTpoi2SGgR0hxMlulM/B/SceeTf2oDmekYlPXYuXlamdZ231Zim9d+FlFhSySurie3kVX5+Q5Yep23g2Ht3LBVlAoEPSFTWysofTnKRaJnwtyBePcg8RXAmqt41u1z/RJt9eyAXIhMDAwA22wGw3lF3mjOdyFHePK8Jbq2zDf2mCKqE6/piOZYtqxBLSZP+XAov3zP5gmzPMaMCd6ucOO6quzjtDvV4i71IWscBM/SU1yK9iT0MYjUGMtEzawnLtHCzOJQXMj+4aD73qdw3CAybwrlsJh+LQ7b8Yw/UiT6Buxb4Ckm0XQG+KwYtxFyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WQ4yP1HZ74vFB2TFWTQdEDswYocqtOzCgUBIyDGbnY0=;
 b=IoPJnTQ1iO+phkHaIjJRQjtwpE07k8pmX4HevDLcN/ZnGcjG8K7V6yBqF/PXCMK9dqX5a8UksSIONeIsZYUdO/n4dRlL9SGwIKAadFcZ3+CwmiIejoj73TML+5ZEQ4XFZl3J+n5LlquTayiKeAHoBLk+49SKJ8ZFrIkdmMDsT5R6OZhU3etx2CVIWI9I/wrNF9WnPehSZacCMOu5IORgZ6JXXXDYUBu95gW3TVTYIJV49mxyomItr7Vdq3bBWKA3MX19BnUBkK3lY5GVYoZQ+DdgsetXCcAwB9LncrbGnD3krFCeMAdimoHzltOFLVdIF5EUF6vqjoh+geDWeiyLYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WQ4yP1HZ74vFB2TFWTQdEDswYocqtOzCgUBIyDGbnY0=;
 b=JMgz+pJIPMBCy7ggxM9Z6bNJClRF5/y8h4ffn5CMoVBkmzr6MJIco1jw30Sb8TB9H4Ci1AhwecaspPStdyGQmGQlL8dl6zVK8AIYriluoaYGCM8h7Y3jAWDdhakLf0dXv6is+6z9l1nYgqTvZZTm4qte3itxvrGUITZdb5uhvsM=
Received: from CH2PR05CA0069.namprd05.prod.outlook.com (2603:10b6:610:38::46)
 by DS7PR12MB6119.namprd12.prod.outlook.com (2603:10b6:8:99::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7472.44; Thu, 25 Apr 2024 19:59:11 +0000
Received: from DS3PEPF0000C37B.namprd04.prod.outlook.com
 (2603:10b6:610:38:cafe::36) by CH2PR05CA0069.outlook.office365.com
 (2603:10b6:610:38::46) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.10 via Frontend
 Transport; Thu, 25 Apr 2024 19:59:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF0000C37B.mail.protection.outlook.com (10.167.23.5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.19 via Frontend Transport; Thu, 25 Apr 2024 19:59:10 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 25 Apr
 2024 14:59:09 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Likun Gao <Likun.Gao@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>,
 "Alex Deucher" <alexander.deucher@amd.com>
Subject: [PATCH 5/5] drm/amdgpu/discovery: Add gmc v12_0 ip block
Date: Thu, 25 Apr 2024 15:58:49 -0400
Message-ID: <20240425195849.2787543-5-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240425195849.2787543-1-alexander.deucher@amd.com>
References: <20240425195849.2787543-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37B:EE_|DS7PR12MB6119:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a15faa3-0bcc-4cdb-f369-08dc65622cab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?T+F/Qbz67xER2SRFC15UgprIz/YMEPEqvinhTYevdUtRnmKmAWyEfRZQJmt3?=
 =?us-ascii?Q?ByOmLf/l53nud980dkBh4VjoR52B7LWSGr62W+HvAFQXe2gHFSfaoHieCcXB?=
 =?us-ascii?Q?nvt1txwsXXO7OT4b0Yhy2YIOYKMWF5LEvf9wpvC9t0ozZTXFe41MF8Oxke3b?=
 =?us-ascii?Q?w96CtAjgThkCAIqF7bNx/w4ex348yRvq3petZa/YzZhBpd46sYjRs/kyzvDz?=
 =?us-ascii?Q?GgYAyITblHMkvfCdG1tg9SJs98KapdJmZfkm9WGcZadxmJmEgHhH9qquDm0f?=
 =?us-ascii?Q?iWOnB61gskf2sBaUea0RgO4jogtUmN9tv9zSqzBDUfKJ/A7nvYumK7dSjnLB?=
 =?us-ascii?Q?HqBVVl9eHsHZAeytsOF2J19B2uEke53fCt8wpxS36nlqDuOp4hHGVtk8AD6v?=
 =?us-ascii?Q?Fi23p2MnhG+D4LExcn9XAI7QAJtqEWSyvgPKF/U3Nap5WzOXGTi7BcKfW5Lt?=
 =?us-ascii?Q?AEl35Sq+Qe0BNkovAp5vQGN45Wko4UFlbFANM7AM3rPOkN4YNn3yZYbtpcU+?=
 =?us-ascii?Q?GMrCEwrVkABWZlqByuCJIUvEdxuVvvERZEZhaluo1Kbcq7PmhcKiMJWb4mYQ?=
 =?us-ascii?Q?xjAwMuBRLrL0wUexIlkm0AoNy3YnGUnT03YDPPs4L4LWXrt5DsLZU97todej?=
 =?us-ascii?Q?k38vO8FPhUZbjlBF0E81Y5pjRWLKrjDnwV0jVG3YJg5g/AtNlBbNt3wYEJk4?=
 =?us-ascii?Q?ENnaWsqni3fo+ihutPHV3vHKfKXZN5C0oSKXtFSxaqRcI287yj1aDMjtgJRi?=
 =?us-ascii?Q?68q2ZyEwo4TfCL8p1DCE/kl5fBb72GmP7ZiZLpRLKamaL3IGoOMeIkVbe8Bp?=
 =?us-ascii?Q?HPdHOtcNN2yRMqs2dAwNPv7W3Z8sZj8dEoW4n/9pD8lekX0FNdKl0II1qjRW?=
 =?us-ascii?Q?7B4CNxXL5cpK8waIvPaAwu3JdDuVqWs/FrLR96RjhzyvFesdPIv1tSpl5URD?=
 =?us-ascii?Q?9dbnGC9K7Go+x8Gatv27+BPtu771Gk7PRjDgRTfzuow0uc2tfWCiz85oVlRC?=
 =?us-ascii?Q?d0SNL9Ku5iSVvJwEFs901y6hPWRvPeVBldHKQcFpNhxfCRYULyO1U0eUYAdv?=
 =?us-ascii?Q?p5Dl4a5R+Q/cOH7C+kOGK4xIUdtdkRPFjUYV5oUPqhbMzpV9ULuFnKWWzq7/?=
 =?us-ascii?Q?370z1v/kXsSaarUxznB4gTRhHhFthE7V0Vr71+jJBxp6Mccg/GtYNJAt+Y06?=
 =?us-ascii?Q?+jlcHqo1RJ9m4MjXC9/JrzQ4KbwrCRg1yxyD7I6dJoChqOwiBDiFPAqcpp7M?=
 =?us-ascii?Q?xSIexreptR30+arvitjp/xl0bWBHytFj0sppA9TafHpVKJi7jL9jBjZfZ+V5?=
 =?us-ascii?Q?JhXvcy/1yIwz9EJNhKGrym0zvOidMfAGwrLfjDZuNywO4lc3jSQvfxmSXoYA?=
 =?us-ascii?Q?ycHJq5E=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(82310400014)(1800799015)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2024 19:59:10.9653 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a15faa3-0bcc-4cdb-f369-08dc65622cab
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF0000C37B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6119
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

From: Likun Gao <Likun.Gao@amd.com>

Add gmc v12_0 ip block.

v2: Squash in updates (Alex)

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 79b43e4bf7c8..98d6915e955e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -55,6 +55,7 @@
 #include "smuio_v9_0.h"
 #include "gmc_v10_0.h"
 #include "gmc_v11_0.h"
+#include "gmc_v12_0.h"
 #include "gfxhub_v2_0.h"
 #include "mmhub_v2_0.h"
 #include "nbio_v2_3.h"
@@ -1753,6 +1754,10 @@ static int amdgpu_discovery_set_gmc_ip_blocks(struct amdgpu_device *adev)
 	case IP_VERSION(11, 5, 1):
 		amdgpu_device_ip_block_add(adev, &gmc_v11_0_ip_block);
 		break;
+	case IP_VERSION(12, 0, 0):
+	case IP_VERSION(12, 0, 1):
+		amdgpu_device_ip_block_add(adev, &gmc_v12_0_ip_block);
+		break;
 	default:
 		dev_err(adev->dev, "Failed to add gmc ip block(GC_HWIP:0x%x)\n",
 			amdgpu_ip_version(adev, GC_HWIP, 0));
-- 
2.44.0

