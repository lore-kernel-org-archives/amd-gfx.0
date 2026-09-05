Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19B46C624DB
	for <amd-gfx@archiver.kernel.org>; Sat,  5 Sep 2026 10:06:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 62DFB10E26A;
	Sat,  5 Sep 2026 10:06:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="cUZQHSW6";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011070.outbound.protection.outlook.com [40.107.208.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D583E10E5D7
 for <amd-gfx@lists.freedesktop.org>; Sat,  5 Sep 2026 10:06:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eUOaxxdJF0VPCcHBFNSubUgH6Vq7pWPLNUZCsZu+SOWwSkCz6CCmMmBmEfl70kCop9+MK/BtwS4gjY2ViUpTtpl21t+xD3P78Wxj+pDmM4ea9pmnddVAIQckz4K3RnuvQnUyngGF0yLsy7FF0A1d6V7Mg3Ya4kr4crGhdyHk7TFbdfSYAj0r5pykRgFuFmE4OzoQPUKz/ICwtZjqfncEPnBQVqrnTZYVJ4r/PTtElZJg3jsLTNyU4NbivQyXglSLimTVmk3jLYaJ7iFM7WTf9G+WwAd9zGA0cLIbQvSCIU4BJV/2f2geonSWrA+1E3hGmjXA2hk0CZWHjkiZTp+2zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ykkg7ydHy/aFiJdQ9nduFzclQekFHwWYGURL8K3X53w=;
 b=A8SBYCoPS1tXTXMWnSPVvBF9yPCgRtqoLZThVLJApHs3VBsn0hu6mIoG36CQl3knE+UxnUZFOlWhBRAom55az9MyoDpokqedpnGmB4G1oU89kaE7ate4lLy/0rhdN4QrPlp2Xc+ArM9vRzkAuiBOrvQEMmZj3YDZN7xhgJwMGdJWyyFJUz5BXii1Avs6TEuJZnBXxig1G6uI5x6/kplyLewl3digx9bHyAhZ9aLK1Mx9o0LQaKKs3S+qxrCK+LrUCpddrg9/OBDA2UOj8j2IbaJFu4nBTWJsMIkF2kagUP2pVoB1aEhNm6fi3o0r8iQmlxCOwVw0gchtF126yMBE6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ykkg7ydHy/aFiJdQ9nduFzclQekFHwWYGURL8K3X53w=;
 b=cUZQHSW6T/KoBUhy1jCD3dwh7ZdmFpTfpybiptlf+zgKNl0qqMECi3UnmeKD4zrret7uNZR4YaoCJs+rq3c7YHvKciZ4rCkYF9VgfDV5mZA6E1GNvpUQacClK8pB3B1QC5Qe7zdAWzLk2CmyMsH3UwZPkpoUfM/R1e8khXpgsOw=
Received: from DS1PR02CA0027.namprd02.prod.outlook.com (2603:10b6:8:44a::7) by
 MN0PR12MB6149.namprd12.prod.outlook.com (2603:10b6:208:3c7::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Sat, 5 Sep
 2026 10:06:06 +0000
Received: from DS3PEPF000099DD.namprd04.prod.outlook.com
 (2603:10b6:8:44a:cafe::a9) by DS1PR02CA0027.outlook.office365.com
 (2603:10b6:8:44a::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.14 via Frontend Transport; Sat, 5
 Sep 2026 10:06:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 DS3PEPF000099DD.mail.protection.outlook.com (10.167.17.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Sat, 5 Sep 2026 10:06:06 +0000
Received: from hawzhang-System-Product-Master.amd.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Sat, 5 Sep 2026 05:06:05 -0500
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, Likun Gao <Likun.Gao@amd.com>
CC: Hawking Zhang <Hawking.Zhang@amd.com>
Subject: [PATCH 03/13] drm/amdgpu: Use common doorbell helpers in nbio v6_3_2
Date: Sat, 5 Sep 2026 18:05:28 +0800
Message-ID: <20260905100538.12877-4-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20260905100538.12877-1-Hawking.Zhang@amd.com>
References: <20260905100538.12877-1-Hawking.Zhang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb08.amd.com
 (10.181.42.217)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DD:EE_|MN0PR12MB6149:EE_
X-MS-Office365-Filtering-Correlation-Id: 1887f7ac-4ed5-4f36-d919-08df0b354d3b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|36860700016|1800799024|82310400026|11063799006|10067099003|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info: Hll41sclsz3olROeCdqengSAEJ2HjZtq7GF7tnmrg7GyW/mPKn2SQ6uihj1pNE9MPGV+0oLE6IBXuOZPJAtlS6c/quMXbOTKS0f+hgu5RdBlW2QZAukYxzhIA04romzOeXbP7UHEwCyCHnFBN9+vtaUavW3DtpJdFDVlS2CqjOUIlJKlJUxAyaC85RT/Jjij4ajGdEO7PFZzfK6buLk625bVGnzniHBHhnCDPBN/6Zh8E9VC6Q7Ckexcc9WEgMFyziduF8aBi+OqB6kw6ZzwEvuGEau/5Vf/8YNBGRgcxQdI7JlWcJrOZSWiFddKbh2C51FFZYqxTw0fe+o4cjBLwlpzASvezVZDfjTzqOjqYLRm1aAgR1qq9Bcoe+kfu5rSaP3o+/5DqtlSnCxO5j3WROoLTGnLajmHyKRkykLt0Guzj6qtylV5dBa8xdoC5+IpaqlDNNiuOzQvvpKtr+jB+AgXfbjn6fQftsCKTnox5CVpn58ZzQvUTtYnbHG1CaZxg8xWHqKor0PClNxNYeFiAgi8FsqRg+M84VtDpUtULAVxPP6dXyCpwHNuqZEESfADgFbXECWWNW/KENwqtOYXZv+4He77mZ3EWYQzdeT6Yn/cBmmeLDC03Kw7nMGSTmvCs79yj6PhUGJSHS7fu1jzidvfrAXmM1Pfi89VnSgrbJ0oY/Vx9vyt6BzjMKSNt4bFg6HTvg1CJu7w/qJdr51qkg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(36860700016)(1800799024)(82310400026)(11063799006)(10067099003)(22082099003)(18002099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: vwGUTtV89yBTPw4Kny0NsXk+WHkK14KbQsdZOkQDTB0usGn9d8uwEyT7cRSxkPU5VL02KbjljA7yhEIt/8cQbETr5Y+KT+ziYcLFrGUrL9a9WJjOeE3i+4l0ngckV8ZxqLBS8gSEIDzItVgmuosUparNMOR5U3eJisJrrPJiGTA8LY/EP918Am9FM12cr5znvTQ3s4GRaGBy4+f/pTcsesirFsH7TlfK0p0RNYBP0VxC+yXdQjKnKGoXyYLlWKYiuFZhpqUKycYzw4M9o2UO7zck9o7YWIJPMO5/XJ6pw56jtNOvcnYhNOm95TfuE0NSVwvuQc8bxuBtnH+SHtP6uEOBskyw0ewzp0Uvw9SLZ2T9kLoZxXPs1SniN/u6ZJFeOhvQxTDgiJ0KOZQP4T3Qm2CiVNcsKkGC6VjX+4N25mM0hJiUNyLo71Yj0Iti4B0t
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2026 10:06:06.6330 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1887f7ac-4ed5-4f36-d919-08df0b354d3b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099DD.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6149
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

Build doorbell_entry_ctrl and doorbell_entry_ctrl1
values through the common field helper while retaining
the existing nbio callback interface and preserving
nbio v6_3_2 client routing values.

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Likun Gao <Likun.Gao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nbio_v6_3_2.c | 224 +++++++++--------------
 1 file changed, 85 insertions(+), 139 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v6_3_2.c b/drivers/gpu/drm/amd/amdgpu/nbio_v6_3_2.c
index 4f5a5f310905..75477951353d 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v6_3_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v6_3_2.c
@@ -261,52 +261,44 @@ static void nbio_v6_3_2_ih_control(struct amdgpu_device *adev)
 static void nbio_v6_3_2_ih_doorbell_range(struct amdgpu_device *adev,
 					  bool use_doorbell, int doorbell_index)
 {
-	u32 ih_doorbell_range = 0;
-	u32 ih_doorbell_range1 = 0;
-
-	if (use_doorbell) {
-		ih_doorbell_range = REG_SET_FIELD(ih_doorbell_range,
-						  GDC_S2A0_S2A_DOORBELL_ENTRY_1_CTRL,
-						  S2A_DOORBELL_PORT1_ENABLE,
-						  0x1);
-		ih_doorbell_range = REG_SET_FIELD(ih_doorbell_range,
-						  GDC_S2A0_S2A_DOORBELL_ENTRY_1_CTRL,
-						  S2A_DOORBELL_PORT1_AWID,
-						  0x0);
-		ih_doorbell_range = REG_SET_FIELD(ih_doorbell_range,
-						  GDC_S2A0_S2A_DOORBELL_ENTRY_1_CTRL,
-						  S2A_DOORBELL_PORT1_RANGE_OFFSET,
-						  doorbell_index);
-		ih_doorbell_range = REG_SET_FIELD(ih_doorbell_range,
-						  GDC_S2A0_S2A_DOORBELL_ENTRY_1_CTRL,
-						  S2A_DOORBELL_PORT1_RANGE_SIZE,
-						  8);
-		ih_doorbell_range = REG_SET_FIELD(ih_doorbell_range,
-						  GDC_S2A0_S2A_DOORBELL_ENTRY_1_CTRL,
-						  S2A_DOORBELL_PORT1_AWADDR_31_28_VALUE,
-						  0x0);
-		ih_doorbell_range1 = REG_SET_FIELD(ih_doorbell_range1,
-						   GDC_S2A0_S2A_DOORBELL_ENTRY_1_CTRL1,
-						   S2A_DOORBELL_PORT1_TARGET_PORT_TYPE,
-						   0x3);
-		ih_doorbell_range1 = REG_SET_FIELD(ih_doorbell_range1,
-						   GDC_S2A0_S2A_DOORBELL_ENTRY_1_CTRL1,
-						   S2A_DOORBELL_PORT1_TARGET_DIEID,
-						   0x0);
-		ih_doorbell_range1 = REG_SET_FIELD(ih_doorbell_range1,
-						   GDC_S2A0_S2A_DOORBELL_ENTRY_1_CTRL1,
-						   S2A_DOORBELL_PORT1_TARGET_PORT_ID,
-						   0x0);
+	const struct amdgpu_nbio_doorbell_fields fields = {
+		.enable = true,
+		.range_offset = doorbell_index,
+		.range_size = 8,
+		.target_port_type = 0x3,
+	};
+	u32 ctrl, ctrl1;
+
+	if (!use_doorbell) {
+		amdgpu_nbio_program_doorbell_entry(adev,
+			AMDGPU_NBIO_DOORBELL_CLIENT_IH, 0, NULL, NULL);
+		return;
 	}
 
-	WREG32_SOC15(NBIO, 0, regGDC_S2A0_S2A_DOORBELL_ENTRY_1_CTRL, ih_doorbell_range);
-	WREG32_SOC15(NBIO, 0, regGDC_S2A0_S2A_DOORBELL_ENTRY_1_CTRL1, ih_doorbell_range1);
+	if (WARN_ON_ONCE(amdgpu_nbio_build_doorbell_entry(
+				adev, &fields, &ctrl, &ctrl1)))
+		return;
+
+	amdgpu_nbio_program_doorbell_entry(adev,
+		AMDGPU_NBIO_DOORBELL_CLIENT_IH, 0, &ctrl, &ctrl1);
 }
 
 static void nbio_v6_3_2_gc_doorbell_init(struct amdgpu_device *adev)
 {
-	WREG32_SOC15(NBIO, 0, regGDC_S2A0_S2A_DOORBELL_ENTRY_0_CTRL, 0x30000007);
-	WREG32_SOC15(NBIO, 0, regGDC_S2A0_S2A_DOORBELL_ENTRY_0_CTRL1, 0x3);
+	const struct amdgpu_nbio_doorbell_fields fields = {
+		.enable = true,
+		.awid = 0x3,
+		.awaddr_31_28 = 0x3,
+		.target_port_type = 0x3,
+	};
+	u32 ctrl, ctrl1;
+
+	if (WARN_ON_ONCE(amdgpu_nbio_build_doorbell_entry(
+				adev, &fields, &ctrl, &ctrl1)))
+		return;
+
+	amdgpu_nbio_program_doorbell_entry(adev,
+		AMDGPU_NBIO_DOORBELL_CLIENT_CP, 0, &ctrl, &ctrl1);
 }
 
 static void nbio_v6_3_2_sdma_doorbell_range(struct amdgpu_device *adev,
@@ -314,114 +306,68 @@ static void nbio_v6_3_2_sdma_doorbell_range(struct amdgpu_device *adev,
 					    int doorbell_index,
 					    int doorbell_size)
 {
-	if (instance == 0) {
-		u32 doorbell_range = 0;
-		u32 doorbell_range1 = 0;
-
-		if (use_doorbell) {
-			doorbell_range = REG_SET_FIELD(doorbell_range,
-						       GDC_S2A0_S2A_DOORBELL_ENTRY_6_CTRL,
-						       S2A_DOORBELL_PORT6_ENABLE,
-						       0x1);
-			doorbell_range = REG_SET_FIELD(doorbell_range,
-						       GDC_S2A0_S2A_DOORBELL_ENTRY_6_CTRL,
-						       S2A_DOORBELL_PORT6_AWID,
-						       0xe);
-			doorbell_range = REG_SET_FIELD(doorbell_range,
-						       GDC_S2A0_S2A_DOORBELL_ENTRY_6_CTRL,
-						       S2A_DOORBELL_PORT6_RANGE_OFFSET,
-						       doorbell_index);
-			doorbell_range = REG_SET_FIELD(doorbell_range,
-						       GDC_S2A0_S2A_DOORBELL_ENTRY_6_CTRL,
-						       S2A_DOORBELL_PORT6_RANGE_SIZE,
-						       doorbell_size);
-			doorbell_range = REG_SET_FIELD(doorbell_range,
-						       GDC_S2A0_S2A_DOORBELL_ENTRY_6_CTRL,
-						       S2A_DOORBELL_PORT6_AWADDR_31_28_VALUE,
-						       0xe);
-			doorbell_range1 = REG_SET_FIELD(doorbell_range1,
-						        GDC_S2A0_S2A_DOORBELL_ENTRY_6_CTRL1,
-						        S2A_DOORBELL_PORT6_TARGET_PORT_TYPE,
-						        0x3);
-			doorbell_range1 = REG_SET_FIELD(doorbell_range1,
-						        GDC_S2A0_S2A_DOORBELL_ENTRY_6_CTRL1,
-						        S2A_DOORBELL_PORT6_TARGET_DIEID,
-						        0x0);
-			doorbell_range1 = REG_SET_FIELD(doorbell_range1,
-						        GDC_S2A0_S2A_DOORBELL_ENTRY_6_CTRL1,
-						        S2A_DOORBELL_PORT6_TARGET_PORT_ID,
-						        0x0);
-		}
-
-		WREG32_SOC15(NBIO, 0, regGDC_S2A0_S2A_DOORBELL_ENTRY_6_CTRL, doorbell_range);
-		WREG32_SOC15(NBIO, 0, regGDC_S2A0_S2A_DOORBELL_ENTRY_6_CTRL1, doorbell_range1);
+	const struct amdgpu_nbio_doorbell_fields fields = {
+		.enable = true,
+		.awid = 0xe,
+		.range_offset = doorbell_index,
+		.range_size = doorbell_size,
+		.awaddr_31_28 = 0xe,
+		.target_port_type = 0x3,
+	};
+	u32 ctrl, ctrl1;
+
+	if (instance != 0)
+		return;
+
+	if (!use_doorbell) {
+		amdgpu_nbio_program_doorbell_entry(adev,
+			AMDGPU_NBIO_DOORBELL_CLIENT_SDMA, instance,
+			NULL, NULL);
+		return;
 	}
+
+	if (WARN_ON_ONCE(amdgpu_nbio_build_doorbell_entry(
+				adev, &fields, &ctrl, &ctrl1)))
+		return;
+
+	amdgpu_nbio_program_doorbell_entry(adev,
+		AMDGPU_NBIO_DOORBELL_CLIENT_SDMA, instance, &ctrl, &ctrl1);
 }
 
 static void nbio_v6_3_2_vcn_doorbell_range(struct amdgpu_device *adev,
 					   bool use_doorbell, int doorbell_index,
 					   int instance)
 {
-	u32 doorbell_range = 0;
-	u32 doorbell_range1 = 0;
-
-	if (use_doorbell) {
-		doorbell_range = REG_SET_FIELD(doorbell_range,
-					       GDC_S2A0_S2A_DOORBELL_ENTRY_2_CTRL,
-					       S2A_DOORBELL_PORT2_ENABLE,
-					       0x1);
-		doorbell_range = REG_SET_FIELD(doorbell_range,
-					       GDC_S2A0_S2A_DOORBELL_ENTRY_2_CTRL,
-					       S2A_DOORBELL_PORT2_AWID,
-					       (instance % adev->vcn.num_inst_per_aid) ? 0x7 : 0x4);
-		doorbell_range = REG_SET_FIELD(doorbell_range,
-					       GDC_S2A0_S2A_DOORBELL_ENTRY_2_CTRL,
-					       S2A_DOORBELL_PORT2_RANGE_OFFSET,
-					       doorbell_index);
-		doorbell_range = REG_SET_FIELD(doorbell_range,
-					       GDC_S2A0_S2A_DOORBELL_ENTRY_2_CTRL,
-					       S2A_DOORBELL_PORT2_RANGE_SIZE,
-					       11);
-		doorbell_range = REG_SET_FIELD(doorbell_range,
-					       GDC_S2A0_S2A_DOORBELL_ENTRY_2_CTRL,
-					       S2A_DOORBELL_PORT2_AWADDR_31_28_VALUE,
-					       (instance % adev->vcn.num_inst_per_aid) ? 0x7 : 0x4);
-		doorbell_range1 = REG_SET_FIELD(doorbell_range1,
-						GDC_S2A0_S2A_DOORBELL_ENTRY_2_CTRL1,
-					        S2A_DOORBELL_PORT2_TARGET_PORT_TYPE,
-					        0x3);
-		doorbell_range1 = REG_SET_FIELD(doorbell_range1,
-						GDC_S2A0_S2A_DOORBELL_ENTRY_2_CTRL1,
-					        S2A_DOORBELL_PORT2_TARGET_DIEID,
-					        (instance / adev->vcn.num_inst_per_aid) ? 0x3 : 0x0);
-		doorbell_range1 = REG_SET_FIELD(doorbell_range1,
-						GDC_S2A0_S2A_DOORBELL_ENTRY_2_CTRL1,
-					        S2A_DOORBELL_PORT2_TARGET_PORT_ID,
-					        0x0);
+	static const u8 vcn_component[] = { 0x4, 0x7, 0x4, 0x7 };
+	static const u8 vcn_target_die[] = { 0, 0, 3, 3 };
+	struct amdgpu_nbio_doorbell_fields fields = {
+		.enable = true,
+		.range_offset = doorbell_index,
+		.range_size = 11,
+		.target_port_type = 0x3,
+	};
+	u32 ctrl, ctrl1;
+
+	if (WARN_ON_ONCE((unsigned int)instance >=
+			 ARRAY_SIZE(vcn_component)))
+		return;
+
+	if (!use_doorbell) {
+		amdgpu_nbio_program_doorbell_entry(adev,
+			AMDGPU_NBIO_DOORBELL_CLIENT_VCN, instance,
+			NULL, NULL);
+		return;
 	}
 
-	switch (instance) {
-	case 0:
-		WREG32_SOC15(NBIO, 0, regGDC_S2A0_S2A_DOORBELL_ENTRY_2_CTRL, doorbell_range);
-		WREG32_SOC15(NBIO, 0, regGDC_S2A0_S2A_DOORBELL_ENTRY_2_CTRL1, doorbell_range1);
-		break;
-	case 1:
-		WREG32_SOC15(NBIO, 0, regGDC_S2A0_S2A_DOORBELL_ENTRY_3_CTRL, doorbell_range);
-		WREG32_SOC15(NBIO, 0, regGDC_S2A0_S2A_DOORBELL_ENTRY_3_CTRL1, doorbell_range1);
-		break;
-	case 2:
-		WREG32_SOC15(NBIO, 0, regGDC_S2A0_S2A_DOORBELL_ENTRY_4_CTRL, doorbell_range);
-		WREG32_SOC15(NBIO, 0, regGDC_S2A0_S2A_DOORBELL_ENTRY_4_CTRL1, doorbell_range1);
-		break;
-	case 3:
-		WREG32_SOC15(NBIO, 0, regGDC_S2A0_S2A_DOORBELL_ENTRY_5_CTRL, doorbell_range);
-		WREG32_SOC15(NBIO, 0, regGDC_S2A0_S2A_DOORBELL_ENTRY_5_CTRL1, doorbell_range1);
-		break;
-	default:
-		dev_err(adev->dev,
-			"amdgpu: invalid vcn instance set when program doorbell range\n");
-		break;
-	}
+	fields.awid = vcn_component[instance];
+	fields.awaddr_31_28 = fields.awid;
+	fields.target_die_id = vcn_target_die[instance];
+	if (WARN_ON_ONCE(amdgpu_nbio_build_doorbell_entry(
+				adev, &fields, &ctrl, &ctrl1)))
+		return;
+
+	amdgpu_nbio_program_doorbell_entry(adev,
+		AMDGPU_NBIO_DOORBELL_CLIENT_VCN, instance, &ctrl, &ctrl1);
 }
 
 static int nbio_v6_3_2_get_compute_partition_mode(struct amdgpu_device *adev)
-- 
2.17.1

