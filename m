Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5CC2C44507
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Jul 2026 15:42:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 77D4010EE0E;
	Tue,  7 Jul 2026 15:42:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="s8ZuZeKz";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013056.outbound.protection.outlook.com
 [40.93.196.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 77B1E10EE2C
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Jul 2026 15:42:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YyddrB3WXPQILTQh0zKIK7HN36dUYbcoHF2XEoMSB8GN0d/8QkIbea+k/DcEmnoAThgJd6JX16XWiqIHpsFo59iJu9dX24Pa+ELYVCxBv95ZpyQrpHG66bU/JgetHX8xkrV/UzxzyqGQlw4SAobLjnxQf8JBP0XPmaBIVhlD74UpdnKxzkTjiGer2ju9iqCg7f5wSincWTV0hwFtw9c31CpF/SJJrg0g0zbr2b5LeBHw93gi1niCAbzELHgis8Ubz2p7oe3qk/XaF3Ifa5h8vAE8QCbFWjG2qxXwCz77r47QF1fsQUyg1Y0RllWSSKNKVHqTvSbis/jscLOzJHe2sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dPTUhv8NBUucT67wd6oiQERmnMVX6Oxm4mSeoWkjG0o=;
 b=LN3Ib4ubF+MgjOCPxmxr2nvzDkoNpdVkWLc6xOCQN+7tdgwilVUI/CjSmy2gJlV9yLwlqHdkNEaTucWbBrHcsYGDJnUBZD0y3PXmd0fGq9EMz9w867PbZlPqeF2WXJyWkwwhJx1rbX4Fe9rXCeJ7cDLYBiXFaLoUT4Wf3mWssHWXPq59nQWpanfWpjXKn8trKKO4ohA7E8uWlR8typd1kbdEbec+mKteFevEy8OjKJWG88zfaVbKu4qyR+jCpCt97T0pJQ34cJL7hp33QAaPud1BV2eVjqCREJ1pm7CNnvYTMvkHeNaBwwETAZHrfh0WYs92RpGSjEz2fiee8LS35A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dPTUhv8NBUucT67wd6oiQERmnMVX6Oxm4mSeoWkjG0o=;
 b=s8ZuZeKzNdbzJOqIsOT3GFMaPP6URIrtuDiEo4KKhMcgmQREA41XusDnMmm7UFBUfIoluoN7dt/AebAKsBMc/I79/yQLZUSqKurX7Sa6YbVQD9FgeeA24gzHTeW65N9a6aV3HE4ZvDBGFR5cJdy9cxTrHgMl81ltppE1pbAceQE=
Received: from BN8PR04CA0061.namprd04.prod.outlook.com (2603:10b6:408:d4::35)
 by SAVPR12MB999145.namprd12.prod.outlook.com (2603:10b6:806:4e5::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Tue, 7 Jul 2026
 15:42:25 +0000
Received: from BL02EPF0001A106.namprd05.prod.outlook.com
 (2603:10b6:408:d4:cafe::7a) by BN8PR04CA0061.outlook.office365.com
 (2603:10b6:408:d4::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.9 via Frontend Transport; Tue, 7
 Jul 2026 15:42:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A106.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Tue, 7 Jul 2026 15:42:25 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 7 Jul
 2026 10:42:24 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Tue, 7 Jul 2026 10:42:23 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 16/30] drm/amdgpu/mes12: drop all BUG()s
Date: Tue, 7 Jul 2026 11:41:49 -0400
Message-ID: <20260707154203.2603209-16-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260707154203.2603209-1-alexander.deucher@amd.com>
References: <20260707154203.2603209-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A106:EE_|SAVPR12MB999145:EE_
X-MS-Office365-Filtering-Correlation-Id: 070568c2-2985-4ea2-d5ea-08dedc3e57e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700016|23010399003|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: V4HwfwfYiiEnUafZP44gnyR5mlozGYNdaXNulXEe3aoc8z9ovE5bVqQi6Xr7vhYiya3KGewAv86Ru1dbkCYWdRMCV7EPz+p/OApaoJVfA5HLCqqwXPjWp/6AILL30jXYuxNDAIVu1Z5eB06AY60jkb1rDMOkkjx2SQ7lU7iUXM5ur7NOJY0xXu8WHPE2tgT5DWn4mR9LQM6THkYnyOLuvUKx12IkVFlL0qWA5dC8lTxxQ7L0DC8CuNpQJh6Fi599HwYfLwuqUbLOteUR3O1fwAmoxSU3e1VOX69II3Ez9AHfPXuBlTnwRfKe5Kzcv0K4dtjb0iFHrQqVvFP54TQZI7SPIM/u1Ip9ZGUgQGafc/ZVSOFnB8RtOxsXNT9tkfpdvRDpZY//l4IAKtGANS/NDt91wsNl/X3yri75ECsLnoYLcjR5Wk9p6D8Wh+S1nnoO6HfkaTIIR5TVeRjh0ogVE8au+khcizg+jivh48jAk39umlgjtscEoSbgR4NAGMuDO6/lKhUfipSbpSPhBoSACrM51nd/8jUAzhMx41LqV+cnaXLOUAFVK8GnwNngZlD9/Orl+NFI5XC6FYsCB25cHEuKoQtYD6vT4KDrlz8DlwAOEC02ZCXKFcXrqLUmDBeD2xmA5CekSSyjcMaQZfmOsAgIdS5tD1Ay4dkw+xvfWCipkxSrb4+v1ibj4FseHAFqslJT4NVKdzZbjdM17vdgkA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700016)(23010399003)(18002099003)(22082099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 2RidDeMeEzcci3OD/t0657b6kddiaXpYxyd+ExI1BKktkxT1QFxKhGJZM1V5Ga0S1wGKViHzeB1y3Ig3RQVbas1YOWlv+wVIMx87aSw/wimJ3nHOoWoZLew1UBSF4Dj11SRjPdLMoLAF2paQrBMEl7GHLoLoE4xnQpKoTCR3uCKstsK2p2LyURa3ig1rwtvQGYmrsndpfzBPktQYwYKRzSq5TO+TS2uGGDk10auyhST6cJzlT39P+ccFQdkd+LK8aRDDjkDdtLiUCDzeB2GTv/xQh1zQ38Ha5x7qIoL32u/EeuhviYfspnEpcPgntIXr608aJqLub/RsSORln0U8exp+luCvikkddcFG5IgCnuv5GnVIiDU+wOg9zElb8eZVe22ZsuF73jr3Rie20D+S16tzt3o8nMG1HOVJR6EOFih8M6nJCChlV3WpsFUsz4RR
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2026 15:42:25.3385 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 070568c2-2985-4ea2-d5ea-08dedc3e57e3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A106.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SAVPR12MB999145
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

There's no need to crash the kernel for these cases.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v12_0.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
index 04465804c2544..322743b257702 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
@@ -59,7 +59,7 @@ static void mes_v12_0_ring_set_wptr(struct amdgpu_ring *ring)
 			     ring->wptr);
 		WDOORBELL64(ring->doorbell_index, ring->wptr);
 	} else {
-		BUG();
+		dev_warn(adev->dev, "mes_v12_0_ring_set_wptr() requires doorbell!\n");
 	}
 }
 
@@ -70,12 +70,15 @@ static u64 mes_v12_0_ring_get_rptr(struct amdgpu_ring *ring)
 
 static u64 mes_v12_0_ring_get_wptr(struct amdgpu_ring *ring)
 {
+	struct amdgpu_device *adev = ring->adev;
 	u64 wptr;
 
-	if (ring->use_doorbell)
+	if (ring->use_doorbell) {
 		wptr = atomic64_read((atomic64_t *)ring->wptr_cpu_addr);
-	else
-		BUG();
+	} else {
+		dev_warn(adev->dev, "mes_v12_0_ring_get_wptr() requires doorbell!\n");
+		wptr = 0;
+	}
 	return wptr;
 }
 
@@ -279,7 +282,7 @@ static int convert_to_mes_queue_type(int queue_type)
 	else if (queue_type == AMDGPU_RING_TYPE_MES)
 		return MES_QUEUE_TYPE_SCHQ;
 	else
-		BUG();
+		WARN(1, "Invalid queue type %d\n", queue_type);
 	return -1;
 }
 
-- 
2.55.0

