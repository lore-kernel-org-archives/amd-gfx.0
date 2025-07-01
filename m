Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49203C8303F
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Jul 2025 18:45:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9D09110E619;
	Tue,  1 Jul 2025 18:45:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="m97EcFWj";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2045.outbound.protection.outlook.com [40.107.95.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D5C2D10E627
 for <amd-gfx@lists.freedesktop.org>; Tue,  1 Jul 2025 18:45:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hhyN/1Cm9zqcthaM1aCUW1UqQt727AipGBPiDfK1Rvh2SBtNGVoZoZ6mF8jX3Qs1irhRF/qIW0lBOszA1DIJVTxnhL0aU1Ednqi4iJSrAw/UuYxUPCJFvedzG4xDpvGvwQETsi8pyTsmeR0WP343o4DCqdOEtvqtwgcyzHnIIZPHclOJFxgrdJ6lJLZlO2v0fO1fPdGtXKFEbwsr5Wh9ABsfMmpZjRmmm8rQN25nnLnLLqvEgWn69tuHdOVV44Z1Mux+I4kZoVfCwfA64SiFZrPKcKQJKy424JXiTE0NI762wC81vLN0cWyCMuYP3EMreX1VRjrYmpPEE/WO0un7aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=URXW3ZXd55OADsseurvjbHl878aLkZfiLhOaEwsOo5U=;
 b=a7yWRlY3UJwk9ju4tvyOoNt/cR5qFBJZyF1bInNwBSL/sBHdAsgnL6Ef3L9CPJ/LZnYmaBp17TU5PrFZAz0uKO9ITdv6/0Ow37GdkoR+Xw79jE3I7eOS5ddxdT6dgh80CQ5cy/WxV13Rf/+pA4r/+/tQrYQF86bp35LDMxDNgC/+ZHHBniR+HAas627QYe5sNhMqVvLtr3X8CqFjgXy8rde+sEmF7tFI/wtfaB3+VO50if9JiWThtQ78F0MWB9Y/mRF7s/UsAuzPs5uItjIQVYVFFT4omiqxiCgLdKVOiPO7ivckiS4qBk8N9ZENHensj4QP3sgR6nDyuK9NESSilw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=URXW3ZXd55OADsseurvjbHl878aLkZfiLhOaEwsOo5U=;
 b=m97EcFWjsMIgK0BbrmbseCiRKNZVMDI0jPmAaZ1QH9qgreCQezYKLqsaCpHnzC0EDXwgr6CsPqmiggH9khx+G5bGZYzNaRbUDN2QyPA5vVbp/WHefVTyRSHLGBxkf5avN0NTZByPwMEDtZstPA/mi8JOjsZAYB7Ojns9kt65QQo=
Received: from SJ0PR03CA0141.namprd03.prod.outlook.com (2603:10b6:a03:33c::26)
 by BL3PR12MB6473.namprd12.prod.outlook.com (2603:10b6:208:3b9::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.23; Tue, 1 Jul
 2025 18:45:12 +0000
Received: from SJ1PEPF00002312.namprd03.prod.outlook.com
 (2603:10b6:a03:33c:cafe::b7) by SJ0PR03CA0141.outlook.office365.com
 (2603:10b6:a03:33c::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.31 via Frontend Transport; Tue,
 1 Jul 2025 18:45:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00002312.mail.protection.outlook.com (10.167.242.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8901.15 via Frontend Transport; Tue, 1 Jul 2025 18:45:12 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 1 Jul
 2025 13:45:10 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <sasundar@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 10/28] drm/amdgpu/sdma5.2: re-emit unprocessed state on ring
 reset
Date: Tue, 1 Jul 2025 14:44:33 -0400
Message-ID: <20250701184451.11868-11-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250701184451.11868-1-alexander.deucher@amd.com>
References: <20250701184451.11868-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002312:EE_|BL3PR12MB6473:EE_
X-MS-Office365-Filtering-Correlation-Id: 921bc125-d2d0-4e16-d03e-08ddb8cf696f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?6YdDNEsDbWWPLZ9Ja+ucjafPvYRpcOr/X/LNQr8jIy40XDJZpKE6K/weiHc0?=
 =?us-ascii?Q?mQE71blumNm7/0VeJtW+qA9LdyZyfxHrlXmpRsOexX7XUGX6GlIGzS1Bf0dm?=
 =?us-ascii?Q?/ryNVj1pdeFWiXeClhMTVgdrfVHbV+IkyITa/xt6D9VqzQtyKFYYRziIWHse?=
 =?us-ascii?Q?zi4VPNQFHfugGeOgPN3R776WzjfIYkMLppcUtPZY5H3CSoT0pz+SLU/VA97c?=
 =?us-ascii?Q?as/hhMxxd4xvBoGhZDsfmoEASCbz6/7Dn5ITvJnYgVAkzlyrm1Mi+3Jlz9/E?=
 =?us-ascii?Q?1TYXm/JkM2aumgOZeUWK2qZqlcn5OHZuaddprf9ANz9rjM7Kge3hFuB/DNzp?=
 =?us-ascii?Q?1jzPYA+UZvF6+GYht94B5LIPimJehYLVWIgCZgKIuF/1hFiOwAPYPENZOWqB?=
 =?us-ascii?Q?Zrp7vd9r6l9XYG52jSnMfBdruy46V2XDUrqNIu9BZKgN1JLgYUGFO+G53lO1?=
 =?us-ascii?Q?mR8AVSMjAJ7j5Jan0dBynXxb4pVMjNhv2c24GW4odKChAcziZ4zsN64UPTb4?=
 =?us-ascii?Q?5yZBGgffxmESc5cJLVHu10YS1PRJwgy0ldpHNhPL+IoiB3FEB8EWlTYkBL2J?=
 =?us-ascii?Q?75i+n3OqGP72I5RfqoQdQAHuOU3+D+Pw+fMytxwWWrgh1LyMHuVfm3OavLQx?=
 =?us-ascii?Q?ie6tC5wtbxxaPio0OjwQxqkRZsL72dIJZf+hkUeGlJxW6bSIEpQ0OTrkOQ8c?=
 =?us-ascii?Q?z9sue1XTrMYxU//kYK7IKVuqn5oUC/CoBxojU4SKV/Dy8Bpdsm4znAY3X9ig?=
 =?us-ascii?Q?JUOM+OLCF53StZUz5ddSykHM7A09WjFIpvVmFLcEnNcMtoUhmqpjl2NgTR3w?=
 =?us-ascii?Q?PgoZYi+bs1uinb0rqu9+DtVHtId/H1XV6PiPMQCxYiMho1QxZqsWgXA79uWw?=
 =?us-ascii?Q?b3B9sU5/4jyZTGzOEfes0K9Dk/Pjan8PBq62/oj5M9K2aSUAPdkHvvCrNweI?=
 =?us-ascii?Q?USCCoTEKVj6NFRZDGQ+Xgr4RnGmcYo/8YldTGs92/UQ2uAYflIUHbP1MEvD8?=
 =?us-ascii?Q?Zf8K+/S1HZPVAsJhGEJ4oTyQH06yyWGZqajbeBg+JtXSXCmRqlwPUd5LZO+7?=
 =?us-ascii?Q?vC2ap1OxNt2sBpshtoCBH30TeXwL1eiqQrcGPp+goiCdpvdiOjKAI4D6vfzx?=
 =?us-ascii?Q?1m7G2qDS3QteGaLgJx77CO3Yfm+EKaBjBVWJ71afMSYj7z+zzj7nic+KnYWT?=
 =?us-ascii?Q?4yMo1NUIxp2xLTuR2EugYGurN7nhPuhPGHr4w05jOgn8OKeQZ6o9mhJZ9NZV?=
 =?us-ascii?Q?16xuvZURugnDglVvtNliOWtXoYWfjVLJTttcpwU8Ej5N2qo5qBwiVzeyv+7q?=
 =?us-ascii?Q?fgj9SW2EZP2+Drdipa8d1DZxEyyfAjrwwDFb6sMgaJy8xGBvvaPuvavsoaOQ?=
 =?us-ascii?Q?hwziPwHiH9NfTz//1Fl/djDYjp5MlLPjVjgaTcNsqvwLc2DctDMSuCzPSyVL?=
 =?us-ascii?Q?EVJ1xdYBtOS6Qq+NjjTSDJL7tagDA3xVNceVs+cIEtFunh3mcD+jJyay9Ge/?=
 =?us-ascii?Q?l2ygGcI5q67vNck4W0K/SewiBzvCik65dGlp?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2025 18:45:12.2067 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 921bc125-d2d0-4e16-d03e-08ddb8cf696f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002312.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6473
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

Re-emit the unprocessed state after resetting the queue.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
index 6843c2c3d71f5..5547d0d948672 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
@@ -1457,14 +1457,25 @@ static int sdma_v5_2_reset_queue(struct amdgpu_ring *ring,
 				 struct amdgpu_fence *timedout_fence)
 {
 	struct amdgpu_device *adev = ring->adev;
-	u32 inst_id = ring->me;
 	int r;
 
+	if (amdgpu_sriov_vf(adev))
+		return -EINVAL;
+
+	if (ring->me >= adev->sdma.num_instances) {
+		DRM_ERROR("sdma instance not found\n");
+		return -EINVAL;
+	}
+
+	amdgpu_ring_reset_helper_begin(ring, timedout_fence);
+
 	amdgpu_amdkfd_suspend(adev, true);
-	r = amdgpu_sdma_reset_engine(adev, inst_id, false);
+	r = amdgpu_sdma_reset_engine(adev, ring->me, true);
 	amdgpu_amdkfd_resume(adev, true);
+	if (r)
+		return r;
 
-	return r;
+	return amdgpu_ring_reset_helper_end(ring, timedout_fence);
 }
 
 static int sdma_v5_2_stop_queue(struct amdgpu_ring *ring)
-- 
2.50.0

