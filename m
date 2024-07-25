Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB227C52D54
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Jul 2024 15:01:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3D74D10E86D;
	Thu, 25 Jul 2024 15:01:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vGkdm+SG";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2054.outbound.protection.outlook.com [40.107.92.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 98C7D10E869
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Jul 2024 15:01:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i01Yycr2YfYBMUtYGiaNxZJqrnPl3zwYpG/u4M5ZmPY9QS/tuw2FfWpXK9x2EwGOit3zvk3Dbu6DR8MJIC745D2iGavpRkV9vtWBdsBVcwsW/s95Zl4kXKIKjk3DfNRUExoMmg76gB8CZ6m+cDMcVsMC1fv5UXjgHCzrpx/qwM65E1I4+8wmwGmjRULWR7bIBI1R647K11gzIDhCZylwMHAEPgs80TvxrWCJfrKhZnBs5pZBLRcMXgNcyii7lpB8V17SORsE+zkNxCM/E/Ka+vlXwPhqHvaOYeDc0nr1bFiv6sqpTl7PfXZ1CA5Wgtd6aTnZht5ipS1RfbU7kwQupw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=12ejZLDOEDu4TVIejiWdfAgVTKple7lhKfUg4lzmkqQ=;
 b=dUziol8wZHX9Y6GkxodqQilhfSuejlzJMTrSUsPpiaBDzHHdZjhlJbWSj4R10c1e8QsMcE9/cF16JSl9A9vk6fs5v8RJdxwlU3TvaylRayISHUgc5rAL2/C9sB+S6du55qHhmrNZUamP21BaWh1AoLMgLzne/2dUtTeyt6IdQuiYU/zvxThuLhMSCoFEz/ktnqhydkhuZjfbEcTsigFmhwe8xuKYbd53b5/Zp4qWG17g+JMOszQ0yUyf1qwUM+YKpsp5x+KJRGU2+V5QspV0k7dsFXvNHtv15fynL5PhYzK2iOs01ZE/c8ysT7FmvpRBvmIR9HgS/GGsh4Atx06qoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=12ejZLDOEDu4TVIejiWdfAgVTKple7lhKfUg4lzmkqQ=;
 b=vGkdm+SG7wz0ATKkioqZuMzGbjDPQf7kbrasQq7gh9scLmqzrmECTTK46O0PKMXDkKnwvn7uc47A+Z0lvu1wTYQkIeiwvDvaogV9Z6rCVIcl/ArfRrTVnuRChhiO+FKl9l1yQkCulotRK+wP+Vwkwd6f734O01DL7ZOA446uY2I=
Received: from CYZPR10CA0009.namprd10.prod.outlook.com (2603:10b6:930:8a::13)
 by PH0PR12MB7011.namprd12.prod.outlook.com (2603:10b6:510:21c::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.35; Thu, 25 Jul
 2024 15:01:36 +0000
Received: from CY4PEPF0000E9D4.namprd03.prod.outlook.com
 (2603:10b6:930:8a:cafe::b3) by CYZPR10CA0009.outlook.office365.com
 (2603:10b6:930:8a::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.29 via Frontend
 Transport; Thu, 25 Jul 2024 15:01:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D4.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Thu, 25 Jul 2024 15:01:36 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 25 Jul
 2024 10:01:32 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 46/53] drm/amdgpu/gfx10: use proper rlc safe mode helpers
Date: Thu, 25 Jul 2024 11:00:48 -0400
Message-ID: <20240725150055.1991893-47-alexander.deucher@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D4:EE_|PH0PR12MB7011:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ae4b226-713a-4a53-1bb1-08dcacbaadeb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?die2+YSPi6nB1I1DgXZ4qN5HGC8dYdvZEcpxKzw0Yv0kiNgisvejCB6ZbLFl?=
 =?us-ascii?Q?og6k7Pp//G+4/1g2KYaPfOtVayfjjptRY9bDXwouCWNC1o1Wc/DZePdnGKGy?=
 =?us-ascii?Q?dWqiKpB63MB1lr+gtmpLm8Ny6IZ82b9I3pZ5LLzGIVYXavxTJAqlivhwJwcw?=
 =?us-ascii?Q?e+FcCfTgKOg9yKHmpB4bLxEhBDFHi9JzXFe2bHYYCzpTiMJ7jMPlFjsEStHn?=
 =?us-ascii?Q?KGiID7JE49fbNe9DpByai0rcKeL5KrgHHb1TCAjd7NI+0SSen0dLDLaPEny7?=
 =?us-ascii?Q?MpIXRUU1SbbiBlIktKYp17djEebcQ5RBlER3gSltrvYh3rmBJ0UaTiKVMP6+?=
 =?us-ascii?Q?XhGksI0Tzm3vnizCHeUgDK6SGx3Ty3v3l5ieqdMmgVNRWXLOZ1c7myGWdOPU?=
 =?us-ascii?Q?QrKwe94KNwXaRfucwpfT6gUUU66/fnsoPJ6xqoWFqSpISo5AS9ZQXNEfSWCb?=
 =?us-ascii?Q?030VWFXIp+Itb7lgWYXpzRtkz/fgSjFfby4aS1b79YAqogi+J6AI4OGffOrB?=
 =?us-ascii?Q?zg/Mc0NAi2Y5zMRQ7FWQE7H0QsOElNJ9ccpVFaRk/o5gTumr0c5itJPg+xH6?=
 =?us-ascii?Q?hBnaCQ9XdWqQmhxDb8Dvq2fK8n5s1CGOXhSN0kRtZbzOftHGPBHcsbnL9aMC?=
 =?us-ascii?Q?b6L2/ZrLF8K1KsfAHnSJfHIsH3nTS/lRA4YGZxHso1sPgyGu2XoLQQuR/vvH?=
 =?us-ascii?Q?36D6MSqwmdfeJAh6lMFgmT0iiSVpBLqw507HxrjhoOdGFIzu0AoEsHpBiOOv?=
 =?us-ascii?Q?Ey/SmBmhn3zH37HT1FTZTVzoozE8utuqre4D/h6I/q6cGDgKzzrFQWZXpDna?=
 =?us-ascii?Q?kOBJjETaUXBmn6FrJgTkgZd4wbYJWptp5HJ9ysyPq+YIsXwMudJgJPGb1edx?=
 =?us-ascii?Q?8iJC4mEb0PifjCNbnSpzEzDpRM+3oWtYEPjrZ8O+SpJpOxqrb0LyzKeWF2SW?=
 =?us-ascii?Q?f6DhmovRzaJv8zfuLahWOtrm5WhyoirvxZ8DtlS1LFCnZoqzwAa/9ENUjM4V?=
 =?us-ascii?Q?M3/MCTk0Az0pPL2tyzY95z3mcYxvtzcHHjnBCXxTmzHsz6W+CXtOaGzJTNFY?=
 =?us-ascii?Q?pj0hp0xzh0+w/ZqhU5EZkmui46deqv9azPXeVE81TKNnNGEfNTzPEcUrCQUh?=
 =?us-ascii?Q?LzDTS9GxPBwA0jHBkbX40VdeR4rohoRt9uTcLAXit65YNFbN0eeIwmLqBnKc?=
 =?us-ascii?Q?/gPQ7wD+U/ZaWtBHjrNiyiMVMy2IBrp401ZwUr3MKLC9cI4xDOiJOP3P3LXG?=
 =?us-ascii?Q?eDFCUCjEK/QFSVKwZyCTRpjbQOYRkELZJ+Z/2R5Ma/q8xsCpw0+6QN1lMm69?=
 =?us-ascii?Q?teoIXPvgKdQbclN+PsTN4DW2ClC2tsoCMwAogz1AtbOnNgW2WLxqWORNfbTh?=
 =?us-ascii?Q?1oNvsDUEYsK90Kipas/MgrMe0L0Om4VCzuiUajUHeG8FuMzKhVgirjL5CRqD?=
 =?us-ascii?Q?ssiq83zt5td5jQwBpmNFpB7FD8SxZZnb?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2024 15:01:36.0591 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ae4b226-713a-4a53-1bb1-08dcacbaadeb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7011
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

Rather than open coding it for the queue reset.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index dc4bd17b4789..da0d3c8e00b8 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -9553,7 +9553,7 @@ static int gfx_v10_0_reset_kcq(struct amdgpu_ring *ring,
 		return r;
 
 	/* make sure dequeue is complete*/
-	gfx_v10_0_set_safe_mode(adev, 0);
+	amdgpu_gfx_rlc_enter_safe_mode(adev, 0);
 	mutex_lock(&adev->srbm_mutex);
 	nv_grbm_select(adev, ring->me, ring->pipe, ring->queue, 0);
 	for (i = 0; i < adev->usec_timeout; i++) {
@@ -9565,7 +9565,7 @@ static int gfx_v10_0_reset_kcq(struct amdgpu_ring *ring,
 		r = -ETIMEDOUT;
 	nv_grbm_select(adev, 0, 0, 0, 0);
 	mutex_unlock(&adev->srbm_mutex);
-	gfx_v10_0_unset_safe_mode(adev, 0);
+	amdgpu_gfx_rlc_exit_safe_mode(adev, 0);
 	if (r) {
 		dev_err(adev->dev, "fail to wait on hqd deactive\n");
 		return r;
-- 
2.45.2

