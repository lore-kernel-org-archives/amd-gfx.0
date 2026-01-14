Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACF56D38FED
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Jan 2026 16:53:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4959710E670;
	Wed, 14 Jan 2026 16:53:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="T7EnIgru";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012055.outbound.protection.outlook.com
 [40.93.195.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1CFCB10E661
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Jan 2026 16:53:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lsdcQvZ499dYXA2lv/esIBErVRuRMavLQZxON+7TLFO8zzOZTY/CN1i+06ouJ04lsE2/7b/Z0yxPaTa3POm5gYBBqgISZr6ID2MwK4/gE91PdV5Ki+45mbopVsw1SQjB+yUaaHvQJyGhhxuPEAlc6XR+9vC5hkKdlXHa2GJY42SgrU++Qf0LGCEQTFKdMUElY928GluuB0jWiPIA4TjkO8Nl+4xt9o8pVtaRbP0wKEc5TtBe/GsZrZy8+8W/HTmdwoWxfW6tp4bWwvG5ts3UU/l1wFumymCjNBUamPI+uTh874ygRO4fkw6D9MQ6eqKehNoFkNxPrTFapQIdMll95Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3X4+jFaGZMFve3DlAczezF+oWf7/jHf3AOqGH0mKAuU=;
 b=D0jFp6QpESNOOqemwFRcPNl8y/jZ1hB+2whgbnY/eDfnx6S3CqYEghc0Rrle66XX9n5FZhYsU3Xy14BpQ+Xv1hRRcjjAL8ltM4LMD7fSAl/b+e6chLpcHRQHaVPtgSTgUbOT8W4R+cOIxor65gaKbXP0AyB7JhrKIcx8EUZUi3fro/uermuXrsGYPuBQ9ENtroHYU9vQZ+lV/n0AJ2ZtOhKa9PXFVI7slE6GGRE1HDwW/B85EBaaJYOL/VERdo+bNech9+Djzgc0AZoE/umygvrK3KPUKee8JNF2VXvh4EkpwhnKu3QAQncMcdlaysZ6anpFdn6DcMKyV/2BqkN8PQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3X4+jFaGZMFve3DlAczezF+oWf7/jHf3AOqGH0mKAuU=;
 b=T7EnIgru8vUuT6W0IABjUalKR3d46EdLStvJz56PAA3+3feQNULOtklU6Ta+/ACYgip6H//HVu1zTNhzYqe5wlnGHPdBIKMKb07DpBmxGRyN10rFYeYCNofPvCIZYH5PGnGJR0ULv53SmHF0qu5xVHjSflShRbL2n5l2fARk084=
Received: from SJ0PR13CA0223.namprd13.prod.outlook.com (2603:10b6:a03:2c1::18)
 by SJ5PPF000ACABD1.namprd12.prod.outlook.com
 (2603:10b6:a0f:fc02::984) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Wed, 14 Jan
 2026 16:53:10 +0000
Received: from CO1PEPF000075F1.namprd03.prod.outlook.com
 (2603:10b6:a03:2c1:cafe::63) by SJ0PR13CA0223.outlook.office365.com
 (2603:10b6:a03:2c1::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.5 via Frontend Transport; Wed,
 14 Jan 2026 16:53:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CO1PEPF000075F1.mail.protection.outlook.com (10.167.249.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Wed, 14 Jan 2026 16:53:10 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Wed, 14 Jan
 2026 10:47:54 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 14 Jan
 2026 10:47:54 -0600
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 14 Jan 2026 10:47:54 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 39/42] drm/amdgpu: add an all_instance_rings_reset ring flag
Date: Wed, 14 Jan 2026 11:47:24 -0500
Message-ID: <20260114164727.15367-40-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260114164727.15367-1-alexander.deucher@amd.com>
References: <20260114164727.15367-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: alexander.deucher@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075F1:EE_|SJ5PPF000ACABD1:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c88d65f-8e4f-4e8a-5442-08de538d663e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?VCqAR1Qv8DQqU9NRnrp9wHofNwsS3YLjy8SiuHnDjLVsHWVAOofLLOotCU1i?=
 =?us-ascii?Q?Wr2TlcqRjVFRvF7IBJNu+UyFBwOkIeFODdf8VlIgRppj4563c9E2tPVSzIKl?=
 =?us-ascii?Q?iyAcKWWd0Twpm8NNypzsOAfd+IvtgUwTohWk7U2mP9aULeHd8WpV53FYsfqz?=
 =?us-ascii?Q?u+n1tJtvfJQi2DDCkAcRZG6XPL5UNiOetsxVixH++UFP/7oDP+TcEvOzjF1H?=
 =?us-ascii?Q?IGTGaJdIiB4Am0UyXzjLQAH7FWQnk4RjadnlumNcV/YOaburxQjhAKVTsTmf?=
 =?us-ascii?Q?HEg/U9B03MQXUHE1qCgSdC9nHXXz5R9SL9NYZZmOxOfjgqRRIfusTnnAyr89?=
 =?us-ascii?Q?mozaXLfX+nWowQXSWTE202oDZW7TCJ7F/tI/O5ROE/SGb+VO5l6KCJJypKnb?=
 =?us-ascii?Q?t3OfTmgbJvCjH+WI5BqYkLNUoDEupze2D+p7Lk/zMA0ar9rIWC435Wks7/dt?=
 =?us-ascii?Q?Azzhd/5obDE0JRRHgIFm6hogJTKThuwzY9RnGXWmUJjhH80tDnpZx3+IHoSX?=
 =?us-ascii?Q?sgd+m8Sbk2NpVmoIahqXqDTyGzzYBtf3C0TzJZj2arkXFxH/2vyrO45y96eC?=
 =?us-ascii?Q?Gm5DPdzvzvgcilB6cRqA88YkwO4fyTB13zotaSgxx88s/EyD3MSV9nwd7L9h?=
 =?us-ascii?Q?2bqQrv7Zx29r1AyFJz+cIBuMKTmN0vfC1D/ND6cuki4Pqg7LXcpD6ZU6Eq9K?=
 =?us-ascii?Q?X9JtxX5/wYpMUwdYIIr/fPaibR/pOUSadYDYgybggbZO09k7DfjOyzVqIfF7?=
 =?us-ascii?Q?+NGXDgqW0IcXnIryOLRz4bNFsYQzCwMprDuNvyRItVg/GqvxYquZZbNkvWtn?=
 =?us-ascii?Q?JMPURp5FljlrIAu7Bwvfib3sCchUjl303+IOSfUKlde1CORJWUx4XgDr1ToV?=
 =?us-ascii?Q?hEHm14WUNK/Bdl31ip7XEpcLxgZNLrL0D1iGLkoIZaPmHoj52Nq33dsZq1xI?=
 =?us-ascii?Q?fVcqJMYzCG54iFRfsta8EBH8evLQhAT7Iq+h+ts/XKX35p59WB+tIqeiphJw?=
 =?us-ascii?Q?1jyocjS6j+d4KctCUdd9rpC4rdxXwFb2+IjHO3JerbraKszpVeuWiG2gU3Au?=
 =?us-ascii?Q?OThLAnBQl/De0Y35bGcQW5J7Wx5a9v/nIiQO1KaUBJUE/vb2BJaM+Lekp8Fi?=
 =?us-ascii?Q?E86YM4Gq6W+6WblwgxN4GgF4HvHgqYKSH48zg7UhFRBD9J/0sADYZhkgwy1Q?=
 =?us-ascii?Q?M0GHN1qFpAkhdR5lXGv2TIYmC5s3adXKugCFCvGV12a76GKbZO7Jzge6Ope4?=
 =?us-ascii?Q?N+ULfIZNYi6XxX1GGTCO2/ul688wUDJk9egwAw42iBPs5x7PiHbN9/uHRgG0?=
 =?us-ascii?Q?5g7ritjP1ls3brN7fw84YK9oqCvQSrz/rTHu6za7Qieop2rrqeC+JcZBbRcs?=
 =?us-ascii?Q?/weoqz4XS2EDnQxWY9iv5sHSo1ltQegu+NMnMWZwV/rs8f9YrIfnIL0NKb35?=
 =?us-ascii?Q?c+sdlrzaAfI3nZYXR0xc7PjVCQ6Ft5BFg63dU1il5DTnxlYbW14/aKjzEoAk?=
 =?us-ascii?Q?iz12Q87IV3VywOOxfY0Cyk700wNDiyQycTMRHnrvE5njnjzne4jsaHbq06o+?=
 =?us-ascii?Q?E+VH4g2wQQnYnrdQImCxdIWgK5f3DDgTllugHhHgR1IHXGJkwaHZWIHvDrb1?=
 =?us-ascii?Q?WM4JzOEwShs9litrXD96K+SXYlCBKsjBs7SE9c8WCGd2AB9+0p1+p0WONq+1?=
 =?us-ascii?Q?1znm6g=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2026 16:53:10.2715 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c88d65f-8e4f-4e8a-5442-08de538d663e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000075F1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF000ACABD1
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

Some IPs only support instance reset.  If there are multiple
rings on the instance, they will all be reset.  Add a flag
to handle note this case.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h | 1 +
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c | 2 ++
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c    | 2 ++
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c    | 2 ++
 4 files changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
index 8aab82af2e0e0..63272425a12f6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
@@ -388,6 +388,7 @@ struct amdgpu_ring {
 	u32			doorbell_index;
 	bool			use_doorbell;
 	bool			use_pollmem;
+	bool			all_instance_rings_reset;
 	unsigned		wptr_offs;
 	u64			wptr_gpu_addr;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
index 86b800e2b4329..e508703d24d33 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
@@ -1469,6 +1469,7 @@ static int sdma_v4_4_2_sw_init(struct amdgpu_ip_block *ip_block)
 		ring = &adev->sdma.instance[i].ring;
 		ring->ring_obj = NULL;
 		ring->use_doorbell = true;
+		ring->all_instance_rings_reset = true;
 		aid_id = adev->sdma.instance[i].aid_id;
 
 		DRM_DEBUG("SDMA %d use_doorbell being set to: [%s]\n", i,
@@ -1490,6 +1491,7 @@ static int sdma_v4_4_2_sw_init(struct amdgpu_ip_block *ip_block)
 			ring = &adev->sdma.instance[i].page;
 			ring->ring_obj = NULL;
 			ring->use_doorbell = true;
+			ring->all_instance_rings_reset = true;
 
 			/* doorbell index of page queue is assigned right after
 			 * gfx queue on the same instance
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
index cebee453871c1..694eaa61c4b6b 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
@@ -334,6 +334,7 @@ static int vcn_v2_5_sw_init(struct amdgpu_ip_block *ip_block)
 
 		ring = &adev->vcn.inst[j].ring_dec;
 		ring->use_doorbell = true;
+		ring->all_instance_rings_reset = true;
 
 		ring->doorbell_index = (adev->doorbell_index.vcn.vcn_ring0_1 << 1) +
 				(amdgpu_sriov_vf(adev) ? 2*j : 8*j);
@@ -354,6 +355,7 @@ static int vcn_v2_5_sw_init(struct amdgpu_ip_block *ip_block)
 
 			ring = &adev->vcn.inst[j].ring_enc[i];
 			ring->use_doorbell = true;
+			ring->all_instance_rings_reset = true;
 
 			ring->doorbell_index = (adev->doorbell_index.vcn.vcn_ring0_1 << 1) +
 					(amdgpu_sriov_vf(adev) ? (1 + i + 2*j) : (2 + i + 8*j));
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
index 02d5c5af65f23..cda3154692b35 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
@@ -234,6 +234,7 @@ static int vcn_v3_0_sw_init(struct amdgpu_ip_block *ip_block)
 
 		ring = &adev->vcn.inst[i].ring_dec;
 		ring->use_doorbell = true;
+		ring->all_instance_rings_reset = true;
 		if (amdgpu_sriov_vf(adev)) {
 			ring->doorbell_index = vcn_doorbell_index + i * (adev->vcn.inst[i].num_enc_rings + 1);
 		} else {
@@ -258,6 +259,7 @@ static int vcn_v3_0_sw_init(struct amdgpu_ip_block *ip_block)
 
 			ring = &adev->vcn.inst[i].ring_enc[j];
 			ring->use_doorbell = true;
+			ring->all_instance_rings_reset = true;
 			if (amdgpu_sriov_vf(adev)) {
 				ring->doorbell_index = vcn_doorbell_index + i * (adev->vcn.inst[i].num_enc_rings + 1) + 1 + j;
 			} else {
-- 
2.52.0

