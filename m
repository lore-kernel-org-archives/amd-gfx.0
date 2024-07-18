Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61EC8C3DA63
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Jul 2024 14:08:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4E50510E91C;
	Thu, 18 Jul 2024 14:08:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="FQ7LMJbO";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2048.outbound.protection.outlook.com [40.107.237.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9FA3410E904
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Jul 2024 14:08:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FqJDh3XCOHpmiDnmK7CFUfW5OMWk4aHRZaue81K1CQXCwbacw9shCMNBrRx/ycc9rvBC0gJ5OzViL61kKYQKBbXyaces+9vA09j6PHCS9d3ch1AjuK4pbRH0ojcwaDxw5lGLANkBSC6gUiy0hmsu+S9brNmG+I3Kpr2agOuUR/xzk2Lf9g7h8uC/D2AHPU+VH0uu0k6JkD9y1iheyuAKO/c7IR2CZPnyoTE+QWBhVPVmmKMiXjCbJ5Kpm3N1MC2XdKEJ53C4reVHnwWl3tckUf1zo6Z4O53kGzHdM02m2+UM44Nyr0hP2IXurQxS7MBI8Lsv0PHqoavtULVjSWXTYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7Y6/w7bSspfZ+rElKotvIzVqPJK8A1a/8A43dr2pwEw=;
 b=u93aFmJTUchjDXxM3BSMdPf7f/TJdf1O69+al8yZsx0G/N9+M333QZilNKLLkXTyi/IrlW8UvumSkzjExhZyYLPMnjs4BUYSQEcsiUdGMga2sAilOreC/jEBvHeZG0wgJ/66OmGxQccrl6IJehpuDwydW+r0nH4Iybo4Pser5VqiRPOggZh0kNRHca1J2e0juHkbrJQBWRZf9q+81nKjuSfpTRm8l20IhxpEm3+r9i3Tl7UibgkYVQ2rmauk2bKZc9Vf/frfQLAl4xj+dHXnPcln8+I6U/Hb4BDGbG0/Udv/RcM64KMsjJAqkYeq/vpB41LV/xkNc2rAvmBzt9z1Nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Y6/w7bSspfZ+rElKotvIzVqPJK8A1a/8A43dr2pwEw=;
 b=FQ7LMJbO6nlkzPs8FmVEbP+3BsUjKrGSolC/RrNFBBCFQjyvotDAzWK1r6xTyu5IVslkDJmMnxY56uuo489stRUJkc5Q1+BuOv4cYUY9v6EJ4cITHqOOI2qj7DyTXpWaNlrQPjPoI4XHlzkULesA/DPQVy2vp374tel6v+TR8xc=
Received: from BL0PR02CA0005.namprd02.prod.outlook.com (2603:10b6:207:3c::18)
 by MW4PR12MB6950.namprd12.prod.outlook.com (2603:10b6:303:207::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.17; Thu, 18 Jul
 2024 14:08:07 +0000
Received: from BL02EPF0001A104.namprd05.prod.outlook.com
 (2603:10b6:207:3c:cafe::66) by BL0PR02CA0005.outlook.office365.com
 (2603:10b6:207:3c::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.14 via Frontend
 Transport; Thu, 18 Jul 2024 14:08:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A104.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Thu, 18 Jul 2024 14:08:07 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 18 Jul
 2024 09:08:04 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Jiadong Zhu <Jiadong.Zhu@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 26/34] drm/amdgpu/gfx: add a new kiq_pm4_funcs callback for
 reset_hw_queue
Date: Thu, 18 Jul 2024 10:07:25 -0400
Message-ID: <20240718140733.1731004-27-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240718140733.1731004-1-alexander.deucher@amd.com>
References: <20240718140733.1731004-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A104:EE_|MW4PR12MB6950:EE_
X-MS-Office365-Filtering-Correlation-Id: 34ea7ae3-2556-4b3b-d531-08dca7330c64
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?VS6NiPubmmwyAlSKnhykWD/Mjr2O8pXk1So9ejMiTR5z/exKZdZ6atjzqvWn?=
 =?us-ascii?Q?QetdM3sFqEaacFFQhWFJkVE1EFAfyJ7BHrCYCBCX61Y3mXEgMgT6JcHApwKm?=
 =?us-ascii?Q?Osr3D0GFN5ETYWgSKU4nTaXtUyJoTrWKpPUXUIIof+6YDLG0l36v7njQw/o7?=
 =?us-ascii?Q?qjtsSaIxoj2LqHU6um2dCAHatuVxjgTo3DXMdm9kUEI3CIJoihLHPmeMTDdZ?=
 =?us-ascii?Q?1jVgXPURNsX/Ucd1wWzp8L+i3/9EJoVkqhYmNy/lXkrqFUT/aWeSmzlf7T+D?=
 =?us-ascii?Q?/QDyyua3G6EshgNuzCYmW/P8G+Jl4iWaeLe9UxUMzzrrZenEayHBfkRVTkb9?=
 =?us-ascii?Q?3NfdkVJzXae4XuDXtp23cbTNhfdVnrtWYuhMO2kqQBghwJ72e80DeIH8VYOI?=
 =?us-ascii?Q?kPhKtWJCDt5qS1obQsKxsrbwDzVihXDE1nau21phUzXg6xTc4v/VPu4M/WRk?=
 =?us-ascii?Q?dEdVPyYHu3314NH/09yNG5NujrdTA5jjOZHjZcvIaQoBXG2Ejahx4BgYL8Xx?=
 =?us-ascii?Q?lqSfXT67THaujOC89uesHLYeDKSgnmFXx3qYJnU1gz7QXlu112rrjSfaloZq?=
 =?us-ascii?Q?AxBTn2OrzAOb9bO8NWzGDU0AH9vhcxntDpTSBa+QEP7T7wfv5JVKG6YM6xCM?=
 =?us-ascii?Q?6HPVS74pXq3+qu6m64FDGWy+c8/dT3W/4ZEmg+hQOwgiHR71hvc+3UCZAjYr?=
 =?us-ascii?Q?BFhpaBKM8uw9c8kGpfrLuDtiat6sGvI2DwaqFXR1Y/4g1aoDBhsXAMCf03oX?=
 =?us-ascii?Q?B5J2gA46lrQ1/WG1z5AkA7CEOgwP1szxHCV/CNhy75QkcId/pap6R4rPUAFm?=
 =?us-ascii?Q?PBI+BTt7Vdv7LYQI5ewyYIrJG2yuYEHjnDbbQA1sPU9lfdYakixe/E8PBdTw?=
 =?us-ascii?Q?ih7KPkf9gSE5hxnt4Z4oD8nAIygrZpw9/NBhayafItnyGMBBcMukKk5yOqgL?=
 =?us-ascii?Q?E3iPQaJO2m1AgrRFzzSS5yRakPs8O2+5gCiimenFkOhjMuKMslgAY75n7QFz?=
 =?us-ascii?Q?YI3FIwjzN5sLA4TaVxDatgQdxe3eueMx2r/nWi0Nwklj/XctvagKg7uC7m3T?=
 =?us-ascii?Q?S8e1jhcNrWx62Bm2VtTB62oE6nUrsQ+ycUv+R/fJBPBkz1TfcU7JQlQoq4dT?=
 =?us-ascii?Q?/PfB51FduI9pS1yjCcumAt+J3d/oXPfrRe2JIyrJJ9eFWxoj4DLubozbZE/E?=
 =?us-ascii?Q?E/rCLtcbNIc+TaaFG+j1quq3epkhTtNYgFWIL5+RPpq+nW9tSXzGoC3Jj87O?=
 =?us-ascii?Q?Cnxy8e4H/5TPpDEml3cVRXsZTymT6r8fcWzq0eye8gmiXQqpJG+MCunhPQrd?=
 =?us-ascii?Q?5rx99YsTogsByuQBl3vWjjZ2zmHIX8vuTrMPeUz1gEW9xnOanPlJ2lk8Iquo?=
 =?us-ascii?Q?oD3n4pjzum3DwMnU+DFsdUOXZTvsVkFnVx/f1slIuCOHHG8tWs6D8G+UO4jx?=
 =?us-ascii?Q?gmhI0wIFcy2wTi/3E7svgRH74ENavsd/?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2024 14:08:07.2092 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 34ea7ae3-2556-4b3b-d531-08dca7330c64
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A104.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6950
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

From: Jiadong Zhu <Jiadong.Zhu@amd.com>

Add reset_hw_queue in kiq_pm4_funcs callbacks.

Signed-off-by: Jiadong Zhu <Jiadong.Zhu@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
index 86d3fa7eef90..6fe77e483bb7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
@@ -138,6 +138,10 @@ struct kiq_pm4_funcs {
 	void (*kiq_invalidate_tlbs)(struct amdgpu_ring *kiq_ring,
 				uint16_t pasid, uint32_t flush_type,
 				bool all_hub);
+	void (*kiq_reset_hw_queue)(struct amdgpu_ring *kiq_ring,
+				   uint32_t queue_type, uint32_t me_id,
+				   uint32_t pipe_id, uint32_t queue_id,
+				   uint32_t xcc_id, uint32_t vmid);
 	/* Packet sizes */
 	int set_resources_size;
 	int map_queues_size;
-- 
2.45.2

