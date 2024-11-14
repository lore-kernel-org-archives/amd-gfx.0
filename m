Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45B3AD68B29
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Nov 2024 14:38:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F3A1A10E33D;
	Thu, 14 Nov 2024 14:38:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="q8HfyA/P";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D898510E33D
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Nov 2024 14:38:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GXreD4CBcyyCUJ6ZdrcOJf8MhQOW33YdIMdPM/bH/i9QMGQWDFxY3tjTUHKvEedL60NkG96Bn2zDxosoVgPSvk3klnX+6d9rhzE4shVQayb8QbezyBTEVkdEZ4x/gUHpbnpxPyizsOP8SgbwE0MY73WstWEWdVKeXRdZu6tZ2hy38xSu6EntUxxSsqX+S8+dO3D02Axlkhl2LZY9uTpGhhR5wCuXDJV7XICfIfrV6V8SytS9celuStt78BG6RxQChXcRc+dLDRs2EQStDxgfOUl747GcT6dozGqFtjZSCnrEjwz7xo80mtveTkkaMJpAcJwvJI736GTLK7MzoXiJgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qHzS+xlZTUVmrriBMlxTTLLLN3n70vFmt4OLqY1gKOI=;
 b=rAyWoFsKI1vWPXmFuOHircrwfsEw86dBfDJNbwA4IyeUMFGB4qtlh0rx6gBZ4Mq9wQlwAMunqoL7T6ovdHvD5KRWtQce6CE4wuWraR+eDVE7SOARZZFA+uPdfW3SNfx2hhG8xhFO5SXEEEA+3yq88jCLeMkDeihbjEyhoXpj2u6vIwCGhEBpAW5NCLosjcKc2If1XjYVQqhTEvtv5h3uiJUxIpi/yRajvFQw5gTBXZeUvyy2hrz8p8NFw7LOJJT6ERqoWGG6abU2LWbaJ5RpbYy/4u8B0ERJVEhHVfNw90vhLayRk+kbz+yyJdmp/l5bFRKKnhUzF/Jk8su9ld1ccQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qHzS+xlZTUVmrriBMlxTTLLLN3n70vFmt4OLqY1gKOI=;
 b=q8HfyA/Pk0dGHJpoQp7ITpCvdke3yTig6tnr13P5bv9M5UW36BOfh+JJEvh+Snm7GD/YvUacSnXu3/2yTR9tFC+8vWvHZNEBaRx1eFgBInv9VZnJGPzXkl+z8PcvlK8P17PX/E4UlEyhiuOeb4Tc1LOgLOXZ0ErAYFbEkHZ+k1o=
Received: from CH0P221CA0019.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:11c::8)
 by CH3PR12MB9171.namprd12.prod.outlook.com (2603:10b6:610:1a2::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28; Thu, 14 Nov
 2024 14:38:05 +0000
Received: from CH1PEPF0000AD7B.namprd04.prod.outlook.com
 (2603:10b6:610:11c:cafe::3d) by CH0P221CA0019.outlook.office365.com
 (2603:10b6:610:11c::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17 via Frontend
 Transport; Thu, 14 Nov 2024 14:38:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD7B.mail.protection.outlook.com (10.167.244.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Thu, 14 Nov 2024 14:38:05 +0000
Received: from mkmmarleung05.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 14 Nov
 2024 08:38:02 -0600
From: Zaeem Mohamed <zaeem.mohamed@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Melissa Wen <mwen@igalia.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>
Subject: [PATCH] SWDEV-476969 - dm/amdgpu: Fail dm_atomic_check if cursor
 overlay is required at MAX_SURFACES
Date: Thu, 14 Nov 2024 09:37:41 -0500
Message-ID: <20241114143741.627128-1-zaeem.mohamed@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7B:EE_|CH3PR12MB9171:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f1d5634-67ee-4945-e6e8-08dd04b9f343
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?nfPxepU3qzUDo7dvuimg7dACW/L4W5T/tzoV0ZfUWbDN/aqT2PkAT33580me?=
 =?us-ascii?Q?0muDc5eExe47329aDYKYhbhLXJ6guwziAQdXWY/hkSZhV9kNRaZfiWmVpjkb?=
 =?us-ascii?Q?A6YjKrfNWzNBYpIYwgRn8WZTFI71KXXUNDfQfziql/nj/vLbl2pk4T8DQgSh?=
 =?us-ascii?Q?DLA0UPDPAUdeSV6wWMeiGaDAM//HvLt3J6vHxCgMTvKSDLFZxQDmijHr/h7y?=
 =?us-ascii?Q?tPb66DpZPzA1rPh1ehRrQcAWeSvFcGdY8go3iyBXSncsWiBC9EDkiWoltMMq?=
 =?us-ascii?Q?39LgWiJZUIbf69XcLtQoD5gNZs2FS/wRgAikTqrwnkCUAF20f9HOeFgn5qeY?=
 =?us-ascii?Q?R/h8JSYQeFHxvPhzi3w0ZKLJoanGr84iU80tp6R3G38fRD3ybhhbo7VTNNjT?=
 =?us-ascii?Q?DFtB2qnZL/TonBOhBGiTLPd9iETo+v8IblVCqptDOeGUBLi4/tj7q9Qcgnzb?=
 =?us-ascii?Q?I+4pLvyP4U2R9fADGHBdzqEN9cjJF6xLsBRvroqr4BpO7vVm9PDe+uXumpJW?=
 =?us-ascii?Q?+sbuZDewElOoMXneLfsmsBW64nCdNJsh2qPct0aKNtJN0tPydBiwSfquSou3?=
 =?us-ascii?Q?KOEI9eCnbDEqjZV5IBHyOQsbqdxhzgBg3K363gXmMtcisjyiL3HMiTn6b3P9?=
 =?us-ascii?Q?Oi5u3fTKcJHMFStvQIOxw85UYQonMkxpy/ZqaJCWBl5N2IQMJiQKXg8FqdrO?=
 =?us-ascii?Q?yTHVKvWnmolS5URtW1SIPwLcx8SX9tNQvDravDqhR0J/b0QG5GlXyep7pd5I?=
 =?us-ascii?Q?OKSCNhUTDCtRdQ1HSvtS5fahjxbDb++vOdUdTP0Rc1YqUAosXpkkTErHgdoY?=
 =?us-ascii?Q?bZLxgDQITiGtszV04IAsgQgNZ1lx6uQwdN052urcJqD8dhAQWRbnPJQPeyMm?=
 =?us-ascii?Q?jzdfDRLeCpU8JiJHp64yhoSLTnDy8l9x0D6whkLiQlcBLMekdU+4EruPcWCE?=
 =?us-ascii?Q?qNZ28dvNU/80GrVWAb7dokCjCzQbjIrf16fTdblB3Oq7CW5I678hMyB1YvqF?=
 =?us-ascii?Q?H2FFsBY4K1oQGdZymBmQToBP7bfZ44Q5vMbSkKhfyYr9MAxNEk+PzB1p8gXo?=
 =?us-ascii?Q?AbuZ3MbEOVjZdsgkokgJwZ2fsVhDkwqQfNhnowhsXYX3IxtZKDohOZmFHToP?=
 =?us-ascii?Q?shvbPmRz6sWGjOzKkwZ6RESokGWlu5cAw1mvuFuYmeCeI76YOeFCrI3IX343?=
 =?us-ascii?Q?ibtiy+2tq1pM2hBD1bUWqyPKT3UM8SFQ41RSTQ5FZRF+lxPGl4czhjFNCXj7?=
 =?us-ascii?Q?0b+IhSbLIjmgRLgw332CYGWv+3NuikR0kGhDZymZ0IDHsX5pJgr3YBkOMls7?=
 =?us-ascii?Q?4nnjpjgt8YTDFBy5ryoqETFJGCD3c9t3vztovpC/FwF0/G2RMsZJGCaj8Prl?=
 =?us-ascii?Q?k6vWUjzqjiRdxTz0LdilSihHRqUfOh/M3Qq3l/RZvtKTkrXbqg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2024 14:38:05.2471 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f1d5634-67ee-4945-e6e8-08dd04b9f343
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD7B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9171
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

[why]
Prevent index-out-of-bounds due to requiring cursor overlay when
plane_count is MAX_SURFACES.

[how]
Bounds check on plane_count when requiring overlay cursor.

Co-developed-by: Melissa Wen <mwen@igalia.com>
Signed-off-by: Zaeem Mohamed <zaeem.mohamed@amd.com>
---
 amdgpu_dm/amdgpu_dm.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/amdgpu_dm/amdgpu_dm.c b/amdgpu_dm/amdgpu_dm.c
index 97e0a1bbba..964497c613 100644
--- a/amdgpu_dm/amdgpu_dm.c
+++ b/amdgpu_dm/amdgpu_dm.c
@@ -11821,8 +11821,16 @@ static int amdgpu_dm_atomic_check(struct drm_device *dev,
 
 		/* Overlay cusor not subject to native cursor restrictions */
 		dm_new_crtc_state = to_dm_crtc_state(new_crtc_state);
-		if (dm_new_crtc_state->cursor_mode == DM_CURSOR_OVERLAY_MODE)
+		if (dm_new_crtc_state->cursor_mode == DM_CURSOR_OVERLAY_MODE) {
+			if (dc->current_state->stream_status->plane_count > MAX_SURFACES) {
+				drm_dbg_driver(crtc->dev,
+				       "Can't enable cursor plane with %d planes\n", MAX_SURFACES);
+				ret = -EINVAL;
+				goto fail;
+			}
+
 			continue;
+		}
 
 		/* Check if rotation or scaling is enabled on DCN401 */
 		if ((drm_plane_mask(crtc->cursor) & new_crtc_state->plane_mask) &&
-- 
2.34.1

