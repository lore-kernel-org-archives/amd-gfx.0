Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6A1ECCA476
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Oct 2025 16:33:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 900A410EC57;
	Fri, 10 Oct 2025 16:33:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XeaEMJZA";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010070.outbound.protection.outlook.com [52.101.85.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BEFD810EC57
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Oct 2025 16:33:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OuPaGvJwuLOI1xwqIdmvwZg0vKyD2R0+yz+orrqhHMworzF39TH4sRmR5CmHh9yFSOoiXdAltN5ASIq9qpX6w/peanZfaN8BNe3DBh8XjJ2egecxbpTa6h2K1oD7oVUpKHmlgN/fSH9bNrctEe9w80y2tTYgvlPH2RLtmJ506aXgWS+tGZ/P8eVjjE9Lp4Ls9e+9LJzuuzHuQsoFHKo0qJfyt7IQhe2EBmLwJfQ9wjO5HDOWluIYTYBk0DHSAbUyiPgxsvJlBst/+1A2B6N484hMWXq02x3/tQ77crV0ai9vSK+P49czHIlzfivBxniQNoT5UV7kyU+9NLKICx3/fQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zwtVd2YMD3Yup4CgX0a5+Jbp4MFIBI8VrDVRhK5QRi4=;
 b=X8/ORmMOn5+Eo+2YtRbX6vuCW4n/4g5D2cc1MdIDjgcxAdgU4OAkYmZnLCjp9Zp4wgckd4cqejESnoXTi9goERRs93GeBzXBjOlEnMhL16FuhmqUpnFGA11DigVHlypKotQZb+g1oYGzocdr+2KuOWMQhsnFZCPd9HCzE8ktARPJqVRYROZFq6krvQUAm8PXuIucU3ElD+1c0XdXUSQR9YxutIMnKpRlFgXqnlVU9kcIuis4WCeh0Vmep717Cdwp2d2edGrDZDXjh50fQuRNce/ocrSeJZuzDwwf0RMKn8qAfnQHtfxbIVDiW+M3IoXfPyzIBU3itLouKdwWMMgE1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zwtVd2YMD3Yup4CgX0a5+Jbp4MFIBI8VrDVRhK5QRi4=;
 b=XeaEMJZAZXNWNn57K8R+Qv8UsyKdO9NLeajKT5qkE9+bXCdnEsSdXoMoReBMrf5cJBJ7ijm1aYJfq8fJX72SUCxeQuFN6Zh0yrfdiBbE2Cx9mJDtz3E2YI7eyRKFdpC/vQKVsNJFJytOnw54NWHTMg+yqmZVg4p2xhxtCjeoBBw=
Received: from BN9PR03CA0497.namprd03.prod.outlook.com (2603:10b6:408:130::22)
 by DS0PR12MB6438.namprd12.prod.outlook.com (2603:10b6:8:ca::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Fri, 10 Oct
 2025 16:33:37 +0000
Received: from BL02EPF0001A0F9.namprd03.prod.outlook.com
 (2603:10b6:408:130:cafe::26) by BN9PR03CA0497.outlook.office365.com
 (2603:10b6:408:130::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9203.9 via Frontend Transport; Fri,
 10 Oct 2025 16:33:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A0F9.mail.protection.outlook.com (10.167.242.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.7 via Frontend Transport; Fri, 10 Oct 2025 16:33:37 +0000
Received: from jonathan-KFD.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 10 Oct
 2025 09:33:35 -0700
From: Jonathan Kim <jonathan.kim@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <alexdeucher@gmail.com>, Jonathan Kim
 <jonathan.kim@amd.com>
Subject: [PATCH 3/3] drm/amdgpu: update remove after reset flag for MES remove
 queue
Date: Fri, 10 Oct 2025 12:33:14 -0400
Message-ID: <20251010163314.1105768-3-jonathan.kim@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251010163314.1105768-1-jonathan.kim@amd.com>
References: <20251010163314.1105768-1-jonathan.kim@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0F9:EE_|DS0PR12MB6438:EE_
X-MS-Office365-Filtering-Correlation-Id: 0bf2efa8-9023-482d-d6b4-08de081ac36e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?bfvPLdzdxAK/MQ4FhFXtqZjdNz841rw5HapOfOi6mELvmzKPITPfv4J1X47m?=
 =?us-ascii?Q?2oGppEE0auHsFSYqlftyrb7sYS8tl0ZKNVJrV20bqSZQxZBqSn1Ohwx4WZ+Z?=
 =?us-ascii?Q?f8hXnlSzcmGKxlPUSHjFq6+BBaGv+e/3IRkIyq8kKb7KamJs/QaGS6Lvru4W?=
 =?us-ascii?Q?wammQHRGVyRF82Uin7GF+GSOF8rVYPqkW0PebLROHXtDfALMy5Ht5gkWf8Ll?=
 =?us-ascii?Q?dSyHJDtGVAwMqEOeqij85bryJk/lm1OvtIZtb4rq5aK0g6PT4lPrm92z+jTY?=
 =?us-ascii?Q?7sZ/Xejs2t0RIQ0RzY5WmkOuQQJW7MfWXoXhsHEOHHvJHp0b3O74GbBbbqTz?=
 =?us-ascii?Q?/84CHUEtddo/eL6lwWNiPMDyVdwnXu0GP2wl+x8PLVVYLcCHUc9uE4v89TO2?=
 =?us-ascii?Q?Htsq4xTjwWRU+uDsUZZC9WQX0DZOWyowAtHoxZDBrO8AZ4SShLaH0KsjgsA6?=
 =?us-ascii?Q?xQK+pBO5NG3fVW9nZL/tSV5jpcCUZ9zSUhX2dh9ewnJzibQhkCiRhzVzVPVx?=
 =?us-ascii?Q?a1PJVPYaFDqigAZKciffWUvyDNmsgPRuEIvx2HvgTvQKcdDQhTWRxCtcSWeV?=
 =?us-ascii?Q?QV0GGdrWMx/bfqvS/cTZTYypS/tWhc1Xan5jxTK+qE3VQexE/vxMXO5ctAjI?=
 =?us-ascii?Q?BQ+Cnq2C5G+CtlYgp8j8xlYOhQseaU6L/I2y2djECDrCKj+vkv/Q7eesGeE9?=
 =?us-ascii?Q?gD+c/DV+hyW13U1JLTEe90ApEA0ABiC4H/65oP4KUyLeBHvnfFetVxOz/+hn?=
 =?us-ascii?Q?03xTHrX91Lvw9C75e8i3OgXgecQ4y96FrJ/IrgMiY+cIgTo22ZXuP0aAEXfp?=
 =?us-ascii?Q?E3ym0E4mncjKHu/+xY+qJAGv/htNot6jNiQt1o5d3sMygBi5ywwlNOqF7RCK?=
 =?us-ascii?Q?nVZubOTygc+FR2UuU+WVYASEfHrv1aH2A62HMCvv8lpiUJS4+kwTLXmcfI7B?=
 =?us-ascii?Q?66R2XeVt7Tyr0M3+ROJmoHVuuGZ5+2VeFuZ1KydRLDaZuyWdewdrl4LZN/NO?=
 =?us-ascii?Q?BlcntoY+0J17LorhBBoXa51PbX2LlYhGJ4xs+jnCM0o4KUFa5FRqBy1X8u9X?=
 =?us-ascii?Q?4oo7aARjyxO92MCHZ6b0IDdvPj4zafUe6DM2erAYQypE5yZ9oeAkgOIbOMm9?=
 =?us-ascii?Q?26/EpXY/Uw404H2UMhVBIH/f1lqSALWt+AsOUxP4QifHuPbzYu6AYQHeL1d6?=
 =?us-ascii?Q?9qFMkXLCO3Zj3oJK8rYCRa2bsGTcpxGqsyVZVvJpmBQ/DRrPWrtR8Bi6c1Pu?=
 =?us-ascii?Q?iXawRLrhUziOrJt41NS0+Xw+Os8bDAFFFTMdOSkCuHR+eKKQjj66SbHpyoE+?=
 =?us-ascii?Q?qJz7OCpedba0MI+jsSxhcML2jhSCitcpIOPN9bghIYHXnNiH1IMpnmmmuq0H?=
 =?us-ascii?Q?F9EYxS2crr/GzJML2mDXGePIPOaf0Er5p4Ro9J3WcXqMERawdDFpvSWAfL0n?=
 =?us-ascii?Q?Axofz+HTPGCwqUb9d2SYuEd8pG0BpYZ08c7/gFkdzGNu1ruBKf8T/o39u0yG?=
 =?us-ascii?Q?dXp2d1WVkxsVcnkEiTWe5wQvVpgAnXFU/iiToXaFk2u/PcP3x9eh7RcHNFuf?=
 =?us-ascii?Q?7SLfkgN+c+JKUiOiYIg=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2025 16:33:37.3734 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bf2efa8-9023-482d-d6b4-08de081ac36e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0F9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6438
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

Remove queue after reset flag is required to remove a queue that has
been successfully reset to clean up the MES' internal state.

v2: add mes fw version checks when setting the bit

Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h       | 1 +
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c        | 4 ++++
 drivers/gpu/drm/amd/amdgpu/mes_v12_0.c        | 4 ++++
 drivers/gpu/drm/amd/include/mes_v11_api_def.h | 3 ++-
 drivers/gpu/drm/amd/include/mes_v12_api_def.h | 3 ++-
 5 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
index 97c137c90f97..9c27a68cb82f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
@@ -239,6 +239,7 @@ struct mes_add_queue_input {
 struct mes_remove_queue_input {
 	uint32_t	doorbell_offset;
 	uint64_t	gang_context_addr;
+	bool		remove_queue_after_reset;
 };
 
 struct mes_map_legacy_queue_input {
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
index da575bb1377f..3a52754b5cad 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -369,6 +369,7 @@ static int mes_v11_0_remove_hw_queue(struct amdgpu_mes *mes,
 				     struct mes_remove_queue_input *input)
 {
 	union MESAPI__REMOVE_QUEUE mes_remove_queue_pkt;
+	uint32_t mes_rev = mes->sched_version & AMDGPU_MES_VERSION_MASK;
 
 	memset(&mes_remove_queue_pkt, 0, sizeof(mes_remove_queue_pkt));
 
@@ -379,6 +380,9 @@ static int mes_v11_0_remove_hw_queue(struct amdgpu_mes *mes,
 	mes_remove_queue_pkt.doorbell_offset = input->doorbell_offset;
 	mes_remove_queue_pkt.gang_context_addr = input->gang_context_addr;
 
+	if (mes_rev >= 0x60)
+		mes_remove_queue_pkt.remove_queue_after_reset = input->remove_queue_after_reset;
+
 	return mes_v11_0_submit_pkt_and_poll_completion(mes,
 			&mes_remove_queue_pkt, sizeof(mes_remove_queue_pkt),
 			offsetof(union MESAPI__REMOVE_QUEUE, api_status));
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
index 7f3512d9de07..744e95d3984a 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
@@ -361,6 +361,7 @@ static int mes_v12_0_remove_hw_queue(struct amdgpu_mes *mes,
 				     struct mes_remove_queue_input *input)
 {
 	union MESAPI__REMOVE_QUEUE mes_remove_queue_pkt;
+	uint32_t mes_rev = mes->sched_version & AMDGPU_MES_VERSION_MASK;
 
 	memset(&mes_remove_queue_pkt, 0, sizeof(mes_remove_queue_pkt));
 
@@ -371,6 +372,9 @@ static int mes_v12_0_remove_hw_queue(struct amdgpu_mes *mes,
 	mes_remove_queue_pkt.doorbell_offset = input->doorbell_offset;
 	mes_remove_queue_pkt.gang_context_addr = input->gang_context_addr;
 
+	if (mes_rev >= 0x5a)
+		mes_remove_queue_pkt.remove_queue_after_reset = input->remove_queue_after_reset;
+
 	return mes_v12_0_submit_pkt_and_poll_completion(mes,
 			AMDGPU_MES_SCHED_PIPE,
 			&mes_remove_queue_pkt, sizeof(mes_remove_queue_pkt),
diff --git a/drivers/gpu/drm/amd/include/mes_v11_api_def.h b/drivers/gpu/drm/amd/include/mes_v11_api_def.h
index ab1cfc92dbeb..f9629d42ada2 100644
--- a/drivers/gpu/drm/amd/include/mes_v11_api_def.h
+++ b/drivers/gpu/drm/amd/include/mes_v11_api_def.h
@@ -345,7 +345,8 @@ union MESAPI__REMOVE_QUEUE {
 			uint32_t unmap_kiq_utility_queue  : 1;
 			uint32_t preempt_legacy_gfx_queue : 1;
 			uint32_t unmap_legacy_queue       : 1;
-			uint32_t reserved                 : 28;
+			uint32_t remove_queue_after_reset : 1;
+			uint32_t reserved                 : 27;
 		};
 		struct MES_API_STATUS	    api_status;
 
diff --git a/drivers/gpu/drm/amd/include/mes_v12_api_def.h b/drivers/gpu/drm/amd/include/mes_v12_api_def.h
index 69611c7e30e3..2f12cba4eb66 100644
--- a/drivers/gpu/drm/amd/include/mes_v12_api_def.h
+++ b/drivers/gpu/drm/amd/include/mes_v12_api_def.h
@@ -399,7 +399,8 @@ union MESAPI__REMOVE_QUEUE {
 			uint32_t unmap_kiq_utility_queue  : 1;
 			uint32_t preempt_legacy_gfx_queue : 1;
 			uint32_t unmap_legacy_queue	  : 1;
-			uint32_t reserved		  : 28;
+			uint32_t remove_queue_after_reset : 1;
+			uint32_t reserved		  : 27;
 		};
 		struct MES_API_STATUS		api_status;
 
-- 
2.34.1

