Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF19CC3DA64
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Jul 2024 15:01:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 75E9F10E872;
	Thu, 25 Jul 2024 15:01:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="krQ0JGAl";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2046.outbound.protection.outlook.com [40.107.236.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B8F1610E850
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Jul 2024 15:01:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=paNKMMn2sPI0hv0BC24YGrb9uhi3RMzMG6kEz0tmIzCt7K/BryPClHFQ7+PXOwarZ6jU+ASReO2y8h8PK6AVW+wTLy/z7elrJp61WyDEYD730nGG1JtoFkq+JUEgeB4Zc1t7p9PMqnvYx34KMb/YeBbRzW8xfAgB6laeIIQO2pTdVNVjgvWV534bGOtKY4xBfoeN/KBhDoEOQehW+RUGchj/TlzYHhepRejGqaI+raS/v+yH6FgpwZLaFqj9v/yzceyhT3OOhTXgzIh971ocuBeOaMjZQwFxleji2GkWZOvOh9ocnhZ1pjAo2guGnVetRzNnuvgKnTADvuZAQGVUwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eg9alPOwD/uKPCeEQQpU5VCQw0t+6qhTqXPvLC3SPj4=;
 b=dpCtcbX3NKqpqzbG6mq0J65JyAlNZBprOWpJWP+GlSDwjDGzUB9qx4GX6QyPzndu3J/T581q8Njs0+PJO5YHJlbkSC7bPfTu4fvbZP3P4/dQBmqonLc+UTJSKvkVY3/gOWN3L1YhNunRU6axXRP18mWYizDTwqBn5kECiZAKBcaqZSeLBQBCMRPIbaUZkScYtddpKKFdTJvuKTPRP7tvhtGyxCtMw1/XDeD+/6grODi0kJkvcGr81qFp/jOFgrhxiSzDTpoffJa50tIeeW6EiT1zwd+n9qmE53KtDOpocaBWosoZgsVS6PMbJnCsk4yYddoUcOBDoBZzeH//cyaSxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eg9alPOwD/uKPCeEQQpU5VCQw0t+6qhTqXPvLC3SPj4=;
 b=krQ0JGAlfz/LX6JoUEJ0OCFHlj2iXPaaZc1Qx9DOyO5EFkwsRUcxhNh765Ss4Au1YDHccADc+4uiByrhoxSdSDm/yrfTqUhiXc5aA6sX7DTs14N09BiM1bS5XeFbx10HTg/+7JVSy3MlPbRFCSRwPvLJsdzuoKhqL809jB1WGrU=
Received: from PH7P220CA0035.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32b::30)
 by PH8PR12MB7109.namprd12.prod.outlook.com (2603:10b6:510:22f::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.19; Thu, 25 Jul
 2024 15:01:25 +0000
Received: from CY4PEPF0000E9CD.namprd03.prod.outlook.com
 (2603:10b6:510:32b:cafe::81) by PH7P220CA0035.outlook.office365.com
 (2603:10b6:510:32b::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.28 via Frontend
 Transport; Thu, 25 Jul 2024 15:01:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9CD.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Thu, 25 Jul 2024 15:01:24 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 25 Jul
 2024 10:01:20 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 23/53] drm/amdgpu/gfx9.4.3: add ring reset callback
Date: Thu, 25 Jul 2024 11:00:25 -0400
Message-ID: <20240725150055.1991893-24-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240725150055.1991893-1-alexander.deucher@amd.com>
References: <20240725150055.1991893-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9CD:EE_|PH8PR12MB7109:EE_
X-MS-Office365-Filtering-Correlation-Id: ef195115-4b58-4fae-3269-08dcacbaa6f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?GqQJrbH4D3Xz+SmIf8IBGDXB4yESIWNKIgqqUzZZlIv2ttc/vCZmCw7QCq34?=
 =?us-ascii?Q?cRlwKdeDMKqN1ImIcx7+GynZKnLVSgcCsYi3o4ZTS0xpeDiElHdKhw+hbSG3?=
 =?us-ascii?Q?KEm3yOPVB5seNHmQsHRYvRI0FWFr9l7yOewb0k1tuvr073JnrUibh5+YW2mA?=
 =?us-ascii?Q?y39q59T++pO25Gn8myS5aSQ5fvrcFglcHZfnH1LNEIOF0xFBv8qHNHuHbD2N?=
 =?us-ascii?Q?LtFy/cqUqvSEapp1offcghJFPs8gbM67vAH0LOWndZ4l3zyueXomhl94l16S?=
 =?us-ascii?Q?b+K4sOHya2/bjGIfUH+9XWCKOyG2IoCE8jWc/WLatinHbZouLpJWssrCbPMf?=
 =?us-ascii?Q?nLPru6XCjVPApWTDNlImWHZQLEL9dgqB0J4/S2OO/pZydt/tep47KVMQSBej?=
 =?us-ascii?Q?lChB9MV9pfmOsiEn9S7XuIM0MP+KyGhNSB5584ZR6MRRHLawNfCuObqMZvwC?=
 =?us-ascii?Q?wft2RUBZXloNknDtoFjoGemxkxw488hqKBRnynCE0UgWT3tvCSSLQHm20RsA?=
 =?us-ascii?Q?4BHZbRTPkqu46j6FKyxXkhtD5j/nd56KmYg7q2f+53pMDeTD+ieSHOYCB7Ou?=
 =?us-ascii?Q?8Ywv2YdwneuayxHxLCvC/QlP4AtBFIy2Y+IqfRDMdca6a8+XXuxZShFhQuNQ?=
 =?us-ascii?Q?UZamidn0OZj0xJ7kvP4O/61XYEffBvUYw0W2mMqlZwmnqHdiWWifpYk8awxl?=
 =?us-ascii?Q?hSlsdh+cXVEabnhxeUsCfs1dSUp7XibORIQqXme4Rt3HR19O9h2I+xYQSAQa?=
 =?us-ascii?Q?ejHx2GUFNNN3YMoSgLpyIa56v0pT9U8Pxe6kcdAo3OD30r9X8qnuImYJ1WMf?=
 =?us-ascii?Q?Y2DTcYmzgb2TYSObO9Yx8TbbjdtlSzhfBWYo0GgNS8hoz84bRTYH6QKxkFYu?=
 =?us-ascii?Q?TuaV3E5C5m/PiDWjEbw0EVjmaIcPVtNBK0mdTKewdXIzOAnOVcKNId0qK5Ra?=
 =?us-ascii?Q?15JkJEQPY7RcKw2dEbUCWZvSdIfbHve8GDpiOj61BVglJks3+cEKdoEuNIIk?=
 =?us-ascii?Q?ygofE7Q+AjRFDnYCV9hg9F12oscVt8X6Htufmle+WxZhAmInTsXxK5PMgn1c?=
 =?us-ascii?Q?9wwiGmW9DwYesv6hf+KE/TkJKejHKShA/RpybfXzanwScy3rbeo1Bn7pjK3I?=
 =?us-ascii?Q?2CEjatxWCad5a+2y83llmm9TumgetelG1BjiJVVTo6Ow/IN89qFKFqiuA1U/?=
 =?us-ascii?Q?OzT0uoP8YaLopgqyuhFuB6pgB+zHFJCQGB7nVhHposNYuNmezgGCggo8f3EW?=
 =?us-ascii?Q?oONRCfknAbp1A1SyDtw8Gy+N0dcrB0VuyHB9M7XKrKnVr/V08SzkKYh5WlkF?=
 =?us-ascii?Q?+uXQ3f2Nca777K7QuOcCAzBekzFBdlgORzEeGFew94C+5RBT/1o2AhhEAxnk?=
 =?us-ascii?Q?t0tcGbL0jckdRmtTF3bY64c3gsQTxV60hBkNkJE+LyobaFfq7SR6EhBMlhW7?=
 =?us-ascii?Q?iGuq6Ag+6HszIEw8FJ/y45T9V5KEUJ4p?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2024 15:01:24.4164 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ef195115-4b58-4fae-3269-08dcacbaa6f8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9CD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7109
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

Add ring reset callback for compute.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 38 +++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index 98fe6c40da64..6cf90ebdbad1 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -3263,6 +3263,43 @@ static void gfx_v9_4_3_emit_wave_limit(struct amdgpu_ring *ring, bool enable)
 	}
 }
 
+static int gfx_v9_4_3_reset_kcq(struct amdgpu_ring *ring,
+				unsigned int vmid)
+{
+	struct amdgpu_device *adev = ring->adev;
+	struct amdgpu_kiq *kiq = &adev->gfx.kiq[ring->xcc_id];
+	struct amdgpu_ring *kiq_ring = &kiq->ring;
+	unsigned long flags;
+	int r;
+
+	if (!kiq->pmf || !kiq->pmf->kiq_unmap_queues)
+		return -EINVAL;
+
+	spin_lock_irqsave(&kiq->ring_lock, flags);
+
+	if (amdgpu_ring_alloc(kiq_ring, kiq->pmf->unmap_queues_size)) {
+		spin_unlock_irqrestore(&kiq->ring_lock, flags);
+		return -ENOMEM;
+	}
+
+	kiq->pmf->kiq_unmap_queues(kiq_ring, ring, RESET_QUEUES,
+				   0, 0);
+	amdgpu_ring_commit(kiq_ring);
+
+	spin_unlock_irqrestore(&kiq->ring_lock, flags);
+
+	r = amdgpu_ring_test_ring(kiq_ring);
+	if (r)
+		return r;
+
+	/* reset the ring */
+	ring->wptr = 0;
+	*ring->wptr_cpu_addr = 0;
+	amdgpu_ring_clear_ring(ring);
+
+	return amdgpu_ring_test_ring(ring);
+}
+
 enum amdgpu_gfx_cp_ras_mem_id {
 	AMDGPU_GFX_CP_MEM1 = 1,
 	AMDGPU_GFX_CP_MEM2,
@@ -4235,6 +4272,7 @@ static const struct amdgpu_ring_funcs gfx_v9_4_3_ring_funcs_compute = {
 	.soft_recovery = gfx_v9_4_3_ring_soft_recovery,
 	.emit_mem_sync = gfx_v9_4_3_emit_mem_sync,
 	.emit_wave_limit = gfx_v9_4_3_emit_wave_limit,
+	.reset = gfx_v9_4_3_reset_kcq,
 };
 
 static const struct amdgpu_ring_funcs gfx_v9_4_3_ring_funcs_kiq = {
-- 
2.45.2

