Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01830D2E014
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Oct 2024 04:54:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A2E0110E72A;
	Wed, 23 Oct 2024 04:54:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3InQZxgu";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DD9A510E71F
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Oct 2024 04:54:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fYkLZ7tQvH/5JjaTWHjWy+4HeWdSR0kv/aSuJwaOe+4NcdJtQrA9haYgDDWugwozgTqxVi7KR3ESdcMGavMqPErf30wrgXs+H9eR3NEcAOG5Y+xV4H6qZsmv+ODE8wkYxG+6f4Tbt7w318UNhpXmXnZDjm8WMKctSlcSemfcrntji3UTKiRvaNV6bRj39q//SkGyh0Y3A4NLfnf7OVTRZvxmOhNAsPQ7rLrwWs/Jx0LSFXp2RFhxlZu/aZ6/daHaH+jly+d3oWfPY4W7zgxfLBQ5VmY1k7zXJN7SRsSmdDDrtdYwKOOvEKE4H8YN/uzrU6u08eFLVjqNmsM6zJ6eIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Njaei/IIr2v0Vn4Ijggdn9IJEGQ45nGYZ9fsYv79HSY=;
 b=Q6zA9SPbLC9HIZhP+NsuLv+WG5qCPdaX6B3uqx2naOohWJAbqWo6/hMgniUCXeTBi9L/I32+0kgl4cCY4fqS0XmA9D1q8iwcweUUE8weOIHYxVljLaC/LRPdFE18+Z6Cu75uEunAa0L/+6yRBHxwlg6UY8f/QaUYlsEGjGJ1dkazaVyrM9bhtX8GkT7d8NgtTPbRo8W/6yc9vOeO2Gg8DQAR/KAKEFEf49cQt+LB7ZqMvM7ZHHdg1NvscmiBM5F+xDlP5yyn8esCK9TW7FmcQAVPtpug+FTBSLB6rqLcvE1poTeZtn6+Pecf/jiej7SB+7BUJxS8LUxvXFp/kj9aNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Njaei/IIr2v0Vn4Ijggdn9IJEGQ45nGYZ9fsYv79HSY=;
 b=3InQZxguM7FsxLTArIoqJFdg+A8yFLHp1UBDHyYQZzaB3gnO6sU0dKIP1Bnfi3o2G7SuB15E6X+enmIq86vGbXIfYDMY0q8HXXalaSnmXj7GLqWOg13f2LHzQGyK8E24c+qkCA9Owkiw5cGstVXrXgO6yGlMnbAkFhJF0Yl1dDE=
Received: from PH8PR02CA0003.namprd02.prod.outlook.com (2603:10b6:510:2d0::29)
 by MW5PR12MB5682.namprd12.prod.outlook.com (2603:10b6:303:19f::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.29; Wed, 23 Oct
 2024 04:54:14 +0000
Received: from CY4PEPF0000EDD7.namprd03.prod.outlook.com
 (2603:10b6:510:2d0:cafe::7d) by PH8PR02CA0003.outlook.office365.com
 (2603:10b6:510:2d0::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.24 via Frontend
 Transport; Wed, 23 Oct 2024 04:54:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD7.mail.protection.outlook.com (10.167.241.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8093.14 via Frontend Transport; Wed, 23 Oct 2024 04:54:13 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 22 Oct
 2024 23:54:12 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 22 Oct
 2024 23:54:12 -0500
Received: from tom-r5.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 22 Oct 2024 23:54:03 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Hamza Mahfooz
 <hamza.mahfooz@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>, "Roman
 Li" <roman.li@amd.com>, Wayne Lin <wayne.lin@amd.com>, Tom Chung
 <chiahsuan.chung@amd.com>, Fangzhi Zuo <jerry.zuo@amd.com>, Zaeem Mohamed
 <zaeem.mohamed@amd.com>, Solomon Chiu <solomon.chiu@amd.com>, Daniel Wheeler
 <daniel.wheeler@amd.com>, Fangzhi Zuo <Jerry.Zuo@amd.com>
Subject: [PATCH 05/16] drm/amd/display: Reduce HPD Detection Interval for IPS
Date: Wed, 23 Oct 2024 12:53:25 +0800
Message-ID: <20241023045336.1557443-6-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241023045336.1557443-1-chiahsuan.chung@amd.com>
References: <20241023045336.1557443-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: chiahsuan.chung@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD7:EE_|MW5PR12MB5682:EE_
X-MS-Office365-Filtering-Correlation-Id: d2d0c896-bee1-40de-243e-08dcf31ebdb5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?qFIEXdr//5XLA0RuegIbngHMCzkjU1Q64tUAyltU/7eRjctITH1NxYNKGDlv?=
 =?us-ascii?Q?ED1OXqIq+1NEe3/fz8mmEAd/8LGBOgotD7DsNWrSqnhgYTiV2mbogQQB3WAP?=
 =?us-ascii?Q?IwpfIN8Be2O+GowMMLUBI5pkT9eT4GMfLmdWAG6mJnzSTpgStgSvYKqofJff?=
 =?us-ascii?Q?RLN+2VARGP/SCSOwrCvb8VPRCz/iKE5u7dh/rP3Qr1l5iwZEnzJunfXfAoqQ?=
 =?us-ascii?Q?ASiIoPI1SGqHp6c4PEoB8vajSrPei6i0n7GYySo27Cj1y2wwiyTq4z/tpPv2?=
 =?us-ascii?Q?eFWj3o/n8xVKcCP/jfkBo0g1onn5rKS+AugAz+45jkETmFmMTcaTzD6BmBR3?=
 =?us-ascii?Q?kM6f1CCdBfnuhFVxMt1Js2EhDVOCjj2TjrfKWhqOuBp3j/GY9Lj6a4s8RHmN?=
 =?us-ascii?Q?C4vxM3BlEnKoFeVgTl5Ivz1iJINqJj/r6R6zkxYLrAtOFNjwfH0k9vDjg6Vj?=
 =?us-ascii?Q?NA++xYreXPEZ+HIjsnwUd8j6RQJrs2eqRJxLiWmpY8dsTxCBr8T9kzWEYxwU?=
 =?us-ascii?Q?Ox+6RQQJrCDqCHFxPkILfo78upsGYGpVoKAfH6OZnpBniTmNlwnNmjsJ+feh?=
 =?us-ascii?Q?oR85UdbDE1BgvHs+s0dPDmla1WPnGe/vPWSaWbuYvIL9LF0JGGjmTK9MalZS?=
 =?us-ascii?Q?relQLRsrNMnGxG9v0S9+KZGjEBjrZl1dfqoxxmkoiDHo5Vm5pBrAhxMv/28c?=
 =?us-ascii?Q?FcqOSwB/6BQgv1V4KVrstvkUs3gTKrfsEv2nk7SXzS6gG7Y1m0QdOiwhomfy?=
 =?us-ascii?Q?hSTEdbyX9ELkmIJoS3h8u4/4wydYmdDiE086Bw1e7J/RB9pwujbUFdDwO3Yz?=
 =?us-ascii?Q?1rv14481pJ/vcsbQ8zEs12A/tJEH6iwD21Kk7Gs7BrRvgiWUJf7o7uYBxm/e?=
 =?us-ascii?Q?ot/shbffDWBdXToEcNKNVKxApN4bLBfYx8TwJwjADBMqoUEf+WdlfJP9EYsF?=
 =?us-ascii?Q?zwpLnAB7fe+vp7OeFj40fOwbnza67vijTfzYGO2YdQtXPGMpPZ0tJzXLgcIu?=
 =?us-ascii?Q?faR3I+PmPHQzun8nAGYlqjgPtYG+P7gfl860bxVf0Im648DR7iuwBtzGoLrr?=
 =?us-ascii?Q?InR57ZcTDt2DmLfviEOHCZdLNT0TGwaBjlrh5g1Mto8SwZfG+2KehE2EyV7K?=
 =?us-ascii?Q?JIHwAhtYWjGr1LkxTz+QIfCSL9FPYaH0pUObtti3Fx9GRyh/HkCzOP6Dn/4Z?=
 =?us-ascii?Q?V3DEmd2YSMDKoEjsLaohy9t3tZaseAwMQPae4Q6+vbdNd1HxLPsLFZE5QzVO?=
 =?us-ascii?Q?tndrvu0MtjUNyYrKy3xGr5/neSyNzhA3jUdjEwgCYk26nNNskHG7ww8oUnwS?=
 =?us-ascii?Q?LRe4V6FvWOvyHulHh6nXU7MGMqiogbhYciSL8QbgnRYsYl+2glJoBuNowH/V?=
 =?us-ascii?Q?c7zMNQl4XRRVJwY9FQK3uak5FHn56DUNkifB2i6n2q8RFbCKYQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2024 04:54:13.5382 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d2d0c896-bee1-40de-243e-08dcf31ebdb5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5682
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

From: Fangzhi Zuo <Jerry.Zuo@amd.com>

Fix DP Compliance test 4.2.1.3, 4.2.2.8, 4.3.1.12, 4.3.1.13
when IPS enabled.

Original HPD detection interval is set to 5s which violates DP
compliance.
Reduce the interval parameter, such that link training can be
finished within 5 seconds.

Fixes: afca033f10d3 ("drm/amd/display: Add periodic detection for IPS")

Reviewed-by: Roman Li <roman.li@amd.com>
Signed-off-by: Fangzhi Zuo <Jerry.Zuo@amd.com>
Signed-off-by: Tom Chung <chiahsuan.chung@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
index ffa4d3965b4b..171099a3ea05 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
@@ -35,7 +35,7 @@
 #include "amdgpu_dm_trace.h"
 #include "amdgpu_dm_debugfs.h"
 
-#define HPD_DETECTION_PERIOD_uS 5000000
+#define HPD_DETECTION_PERIOD_uS 2000000
 #define HPD_DETECTION_TIME_uS 100000
 
 void amdgpu_dm_crtc_handle_vblank(struct amdgpu_crtc *acrtc)
-- 
2.34.1

