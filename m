Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 094DCC3DA4A
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Aug 2024 21:55:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AF69410E101;
	Thu, 22 Aug 2024 21:55:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rv/Wkm5y";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2070.outbound.protection.outlook.com [40.107.96.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2DF2810E101
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Aug 2024 21:55:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ivnx6CmJoTOuhxuIpOF4/YGnSdtKkCq/J+xmnRRvLek9tY2gialb3meIjZ51Eebx0xbghrmOLIdLY9KOX+PSNovCYSmJc9HArfBsflIApc7M+60AVNo014MT9Jz/uRhxTHjnBDLfwhmbD72PpFSRmxIrwPo/aQm/pGH7v200GzxLyrEd+hAcgC8FSVxyc95UApRQJzrQd+gW5WJUqYMl9E4xOCMdkMkTy0SpE730VNRb5Q+Vkn4p06PfpYVqUDsw6UPdxkwclGS5f592imHaMqkLx2vOogg9aKChN0rwaH8rxLGDm8OORCfsdTTb0mR6O54Oumn1ZGQY+3KtilzN3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mys8sOalZ1RyHRG00woAK88hOtVY6uQfg5gOQr1nap0=;
 b=cFzfoZ6d/4IqknVf4gEDhDonbuJIildLlUg8GBGEt/rUIM9m+qWSdyy7HvMYqOPngp6mNVq9BfqviAf6285l01GyNxVKcY79wWgeqHlU/5tw/+5LjNUoyHLQ0lwFo8EddrzrjAdvedS3CIKCiQ41znTomfGQwBOQvYDle+EGgaUkUKzHkW//JHHyQWYLSGmmb6IXi55C6mgr3gsSOpX3//nBpnQLYOBQAI1QCRf1YBPZLLEGgojJHjRd2lqfMS/0qv4/6U7Bzv3uFClFf/NUrR/PmU0WiDq4KzYN8Y9qTVbr3g6/cESprJhTYXyhzp+cZZb75eMogs7dZhtIaStKfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mys8sOalZ1RyHRG00woAK88hOtVY6uQfg5gOQr1nap0=;
 b=rv/Wkm5yiKI4R0XlejZt3Amfg1wgouEYI7KN70Gs2VGSjgVRTTAeLhgn05wlm8WW1CXwLMF9P5stsRAakXKEnUmhOCB23rhaP/unH/fXbydiyfEKFfbhfpFRRhod/ATqI1pIuUtBwuOH481TN/1jvRlscCBLOdEtTdwXg/h57g8=
Received: from MN2PR19CA0044.namprd19.prod.outlook.com (2603:10b6:208:19b::21)
 by PH7PR12MB9224.namprd12.prod.outlook.com (2603:10b6:510:2e7::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.19; Thu, 22 Aug
 2024 21:55:29 +0000
Received: from BN2PEPF00004FBA.namprd04.prod.outlook.com
 (2603:10b6:208:19b:cafe::1a) by MN2PR19CA0044.outlook.office365.com
 (2603:10b6:208:19b::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.20 via Frontend
 Transport; Thu, 22 Aug 2024 21:55:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF00004FBA.mail.protection.outlook.com (10.167.243.180) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7897.11 via Frontend Transport; Thu, 22 Aug 2024 21:55:28 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 22 Aug
 2024 16:55:27 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu/smu13.0.7: print index for profiles
Date: Thu, 22 Aug 2024 17:55:13 -0400
Message-ID: <20240822215513.8637-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.46.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBA:EE_|PH7PR12MB9224:EE_
X-MS-Office365-Filtering-Correlation-Id: 7204d72f-5083-4fc6-71cc-08dcc2f522c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?+HHQzraxfwQeGEJefPx+79/zDSMiuTUOc1CdbQC61q1pweuKAk4oLVAo6n2V?=
 =?us-ascii?Q?ucwin7+9jJOBPJh15YLLLcj9C/4K/OaiOmz/YOfwSJhExaBT92eT0z/VChj4?=
 =?us-ascii?Q?cunok6w55UPfXHCGdqwqY/J24asYiVeyg4x/J3xHL2qG8y4EuM+amRpK5IhV?=
 =?us-ascii?Q?QZU5iAwVf04wQ/O68S+2IFYx8i6svVmvgwVCXJbvDHTXwUP228lgjIbLLLXR?=
 =?us-ascii?Q?erB88549vLUQFTfiKhQvcUeN8K9RkUcyiuEIvaoJjpMU4tnUs+IR2sosUQhJ?=
 =?us-ascii?Q?4Uh1nYFhda8h0lWagROxIWaY4ux9hon7TJAZhnx9NgWtroTzZtL/HzhEdfrD?=
 =?us-ascii?Q?M+gHVTwNSMYqL0Vq6Qi91UnngLZ8bqUlY9xWe5DwwpvVljgRcZa9V5z1qb3V?=
 =?us-ascii?Q?lOH/4UrHV7hqfqAEuzNOgK0DcgCV2rLs+1ny5aTOHpC6LU7bKSYC0rNby4yz?=
 =?us-ascii?Q?LyvdmGAwasISzOasLT5OjUIMILODY+6mogTrlq9WyQ8nKMsWNT+qEoWuZVVQ?=
 =?us-ascii?Q?zbtv7+2Hb7EGWTx9TJ2jfqn3qz5O/A05uy33cctnfDKmWPztMPZJEvW7wH4c?=
 =?us-ascii?Q?psaSqpZ2egVJoFZzNIW8F8/ouryz14BAimMCXa+lgg7ZqGVlKHOi69LQLD8j?=
 =?us-ascii?Q?59cru7pqN5JaqbmhdMCgrtTOVdC95eTc65e7iG4PrlS1c+YPMiVeZCP0+2Jn?=
 =?us-ascii?Q?Rjc5cVnCkNAk0EIXjRj5ARpHMeXOAmZ+r+cnwvCqd6P1soBSXEwToEviMZbA?=
 =?us-ascii?Q?rqu+BqP1EKBPfsRCV0DFUV10O5zC06hqbYjAvvvuNyRwFe8RbPh2LnU6sjRS?=
 =?us-ascii?Q?JPrxOIBjWaqoJG2Q8mIq2Bi+oFz1iT0VCmy++AO7dZ5TnqgcOzKLNm8cuFnQ?=
 =?us-ascii?Q?n2Sm3iO524WGLQz1P0M/Endx7Ah2jUnYqa68JKFYg3K/IFst2JPdqizmaHWc?=
 =?us-ascii?Q?PNk1An4mh8SJOkZwIs+PFclUVVeyS2HRMZ5aFlekXInA36HDC2WUJR5FAW/K?=
 =?us-ascii?Q?XGssLt2HpWkVToef7/0828M6hAhseoTtFIrbyMnVVjmCpFdeWCnEEvTnJfbN?=
 =?us-ascii?Q?AEDDBl89FEpLUEDYE3c19JpA+pFElUeom//PTwrVna5R3gvKQqQCNddw3Srs?=
 =?us-ascii?Q?m5aC5gCpTxlzMlF5WQQ5/C2dNUBhHeCc22NVXjF0GGb0ZMx3efA3QnStDbUD?=
 =?us-ascii?Q?3FW+HZc+pB2HqPl+Lz0r0HIby31bsu80JYbBuP6rRSBmQJLUgOIy4ouvuWU1?=
 =?us-ascii?Q?+EutRbaIeJdp8K7j6d5eba6+00AWLwWT9Ad7qbpnjrIvIYL8f3QnomoX2yAq?=
 =?us-ascii?Q?aktczg/hnAPT0HfZdo+7+8Evu0jK+Kk65Ine2Tax5qpXjVhfQT5CLwCzsWy4?=
 =?us-ascii?Q?Uu53P63vZWfybw+EdXh5AHRtoNswC5G1HgdI5WvFnI8tJGqiLA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2024 21:55:28.4931 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7204d72f-5083-4fc6-71cc-08dcc2f522c2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF00004FBA.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9224
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

Print the index for the profiles.

Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3543
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
index a7d0231727e8..7bc95c404377 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
@@ -2378,7 +2378,7 @@ static int smu_v13_0_7_get_power_profile_mode(struct smu_context *smu, char *buf
 
 	size += sysfs_emit_at(buf, size, "                              ");
 	for (i = 0; i <= PP_SMC_POWER_PROFILE_WINDOW3D; i++)
-		size += sysfs_emit_at(buf, size, "%-14s%s", amdgpu_pp_profile_name[i],
+		size += sysfs_emit_at(buf, size, "%d %-14s%s", i, amdgpu_pp_profile_name[i],
 			(i == smu->power_profile_mode) ? "* " : "  ");
 
 	size += sysfs_emit_at(buf, size, "\n");
@@ -2408,7 +2408,7 @@ static int smu_v13_0_7_get_power_profile_mode(struct smu_context *smu, char *buf
 do {													\
 	size += sysfs_emit_at(buf, size, "%-30s", #field);						\
 	for (j = 0; j <= PP_SMC_POWER_PROFILE_WINDOW3D; j++)						\
-		size += sysfs_emit_at(buf, size, "%-16d", activity_monitor_external[j].DpmActivityMonitorCoeffInt.field);		\
+		size += sysfs_emit_at(buf, size, "%-18d", activity_monitor_external[j].DpmActivityMonitorCoeffInt.field);		\
 	size += sysfs_emit_at(buf, size, "\n");								\
 } while (0)
 
-- 
2.46.0

