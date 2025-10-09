Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C043ACCD18A
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Oct 2025 18:50:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C5A2210EAE4;
	Thu,  9 Oct 2025 18:50:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="KmM0KJPk";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013002.outbound.protection.outlook.com
 [40.107.201.2])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4B33510EAE0
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Oct 2025 18:50:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dCFwU+STHobRukyMYoBiZMj4cFZPaePsTRlsf1acwSrDkroKg0Xah96vt5Yc8yEbNS+iuDUtElMkV64tHzxFrXl2X5+yUsLqg+l6S4SfiXkUd9+vFfMtEhOK1O4/gGssgl/JxWE295AD8WiuwdmdmItlg7bWcpj3HO2OsLnwAREhE3T80VRseKrxI7k7jKuFW6Cn0e98cOhjbKzqJvNNiETwauzd16d8RjpDS5LVPXHTx+wPltsQBDDI8qaqjVqtPKcbt3VohEmW0foi6LH6lXmR+kfmHOHctv8q89BXSer4cAuk7JXQQc80tm1cV5HOujy9ZgDl7BJfN0E5xBgmbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nu600GxZytaOEH2mpPRJuRd83gmG8v38wJgE3EOig1A=;
 b=ZLerHOb6EWDgG0THY/cT3a82PQixscP/dyM8vlxi/T+RhP12q/TiRuGa2ef5GeErqOWEk+EemqBHWAh0UpEBxjwids06qCH8KjwrXI0/DngO5CTtjm4t0cjc0qlKYjXJNsA6ja8vk00Ha0rWleYS0Gx45TP/YbrXqgHSUB5kb3wywfDokIbBu2AO3CzObjE9KOOQ/0pAka1BwFUTTm8kdcp9Vn1QK4gDOS9/dZUEbqGqgFZSI/9KwK50TYEKxhFY60jeqMprM75nliSo1TqWnvwuqC/T0mWDETWbpHr1VheEf4TDi4ptfaq11vj+wUj+m7jcNIjDXOroywRU2zZnHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nu600GxZytaOEH2mpPRJuRd83gmG8v38wJgE3EOig1A=;
 b=KmM0KJPkpD1csJC621STwG16NrfMCfBImtwD5kB6UjSZl7LxKNoSBJ4+neV/lrZhZk3guxrxDKUnkrWZQDTxCPYzKUpMmUYuw8pwhCGXHHNDDVa6NMcMd8qZ/rMtD6bPWOG1lnNmJ9nBMRvcq8OePOW5T316NeJKLKnfeOUZsoU=
Received: from MN2PR01CA0017.prod.exchangelabs.com (2603:10b6:208:10c::30) by
 MN0PR12MB6174.namprd12.prod.outlook.com (2603:10b6:208:3c5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Thu, 9 Oct
 2025 18:49:58 +0000
Received: from BL6PEPF0001AB4E.namprd04.prod.outlook.com
 (2603:10b6:208:10c:cafe::a4) by MN2PR01CA0017.outlook.office365.com
 (2603:10b6:208:10c::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9182.20 via Frontend Transport; Thu,
 9 Oct 2025 18:48:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB4E.mail.protection.outlook.com (10.167.242.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9203.9 via Frontend Transport; Thu, 9 Oct 2025 18:49:58 +0000
Received: from jonathan-KFD.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 9 Oct
 2025 11:49:54 -0700
From: Jonathan Kim <jonathan.kim@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexdeucher@gmail.com>, <Alexander.Deucher@amd.com>,
 <Shaoyun.Liu@amd.com>, <Harish.Kasiviswanathan@amd.com>, <Amber.Lin@amd.com>, 
 Jonathan Kim <jonathan.kim@amd.com>
Subject: [PATCH 6/6] drm/amdgpu: update remove after reset flag for MES remove
 queue
Date: Thu, 9 Oct 2025 14:49:29 -0400
Message-ID: <20251009184929.1038298-7-jonathan.kim@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251009184929.1038298-1-jonathan.kim@amd.com>
References: <20251009184929.1038298-1-jonathan.kim@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4E:EE_|MN0PR12MB6174:EE_
X-MS-Office365-Filtering-Correlation-Id: 8abec2b7-31bb-4b77-824f-08de0764a554
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ZQEKtRAigmOgv+IW1hPP6xhx1un1g8+DLZKY2m/Vx25xf15Y1ydqIAXoYtO+?=
 =?us-ascii?Q?wBT9NzYEk+ESdGPLW14rVLbb+p8Uzi6w/YEKf3NKFIfN6XPaIPT30wJA9/LW?=
 =?us-ascii?Q?UOvRRnTphEPXaklyob7rzviBFS5ObvXrYl5Ltww14eD8PXseDyxL1Kya+OAI?=
 =?us-ascii?Q?gb+zPrOt1y59xBgf9CwQxBtKYCGbF2RncqMilEQVj6ySP7FrZb5Rj1YVub+J?=
 =?us-ascii?Q?0HWHxbEE8RZJAhRhIgzivDvlLszjl3m0EdByYwyiF8zc/orGwuuG4TJPDpOn?=
 =?us-ascii?Q?iT+xfrpcS0K+jHEjqR2ZtnlTRQuDMddxu7KPuxlnzm/DrMk7wRRCuZqN8yp0?=
 =?us-ascii?Q?bdcoQBzl6YmpT6ayRfIvkCJ/AXjGmtmz06KSeAm6mYF8XoHF0U3DWkFClMMF?=
 =?us-ascii?Q?j0LLQX0NbkIAZs9IcwiGIklD4IEZTqzl6h3DB5+Dpgbd1hpdz5WKteX09v/H?=
 =?us-ascii?Q?exolaWGei2BNckxsbDhJkp8G1ARwvThyiPZ4QHhcTj0M2krWDlSprYCH77UP?=
 =?us-ascii?Q?oaufjoFHAypRwehse2tFM9u9fQ1PCDFyZnx0fz6YmWOX4bLWUxH7t8QddPXb?=
 =?us-ascii?Q?SW5VjZq40q0YFw0QxdYa5SnFECfWvEX6PVA3ILvO3z6Li7NWuFUJivchjKNG?=
 =?us-ascii?Q?3bdf8A8gzRvIs64E3eiT8248MbDe9LrB2QNSYrLplzpZsHRCTaej4Ul31p9/?=
 =?us-ascii?Q?gaWUk2uScLNr8ez7TpXRjfedkedbt+1DbToQAV0baBFdmjxDAJ1TuqG2Jsoc?=
 =?us-ascii?Q?vwQzXa4Pm1irhkPPZKTl4oE35BmFM3YSeMYx22GKj+BJOuFMaBcUVil/eSmX?=
 =?us-ascii?Q?dGuwJcMGbOKwmALo5etuS95oZJVDgZxu/7d21qm3NY2thu5lAdjGKypprAcZ?=
 =?us-ascii?Q?BLUCaGe1aoHSaCrmsvxE+y9s2UZItAJuQeCTqoSs4wZx/xW6GKKTNkulOB3R?=
 =?us-ascii?Q?UlVzcnUUQ0z8lFK4NxTJzhR5m2CH/ofZku0c8an3bfxxEO4PGiafNeZBmn7D?=
 =?us-ascii?Q?JfaP0z39Zf9cM7q+ovr+vcTDzKa6o0y/KmuslyELstGoLvh1z3GXMEt3061t?=
 =?us-ascii?Q?8NeKx1m39ZUvxMhw4GAtcx0VWe7HXhYoiKI0VfWxq7UFAIIO6XXWRkPzu6ym?=
 =?us-ascii?Q?e7WGejoRpVR/ldQzTh55Zv4JZD4as/bX+9mf1qzUpiHeUEy1DdxMD8r/UV40?=
 =?us-ascii?Q?juQTkEtS9X9Qwp+N1J4EFY7Wh+Pb8pr87DIaLdv2kieQe5ZF/GyzENy5tBcS?=
 =?us-ascii?Q?3k7LYrdjjnhQ/LVanV2IliaSFbMm5GNf0OOiHygW7ol8+AcXSvbc96zRXVcT?=
 =?us-ascii?Q?m8vyTg5DusQOWsv2LXpounvr+3pf5/U0NcGbAZQT+AqX1H3QQaBlFkq/Bw29?=
 =?us-ascii?Q?G5yxKBUIaClP2xx8uLCqgPHyw2JZAjx6OZLD+k4kYQopSkJwZCpHxzuvtsuQ?=
 =?us-ascii?Q?xXL2ddImr7Av3adGlZUySd9aQ2fC7GHwDQy9k42mbo5MLJSgohb/4nzOtoeP?=
 =?us-ascii?Q?JkRRiodGk74xwScrA7f0MlZ6yJu3HaBc6pjIDWu6zlaE39NFqba6K62QGM2P?=
 =?us-ascii?Q?nSuGT3H9xcI9ZF/B5ds=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2025 18:49:58.4657 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8abec2b7-31bb-4b77-824f-08de0764a554
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB4E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6174
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

Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h       | 1 +
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c        | 1 +
 drivers/gpu/drm/amd/amdgpu/mes_v12_0.c        | 1 +
 drivers/gpu/drm/amd/include/mes_v11_api_def.h | 3 ++-
 drivers/gpu/drm/amd/include/mes_v12_api_def.h | 3 ++-
 5 files changed, 7 insertions(+), 2 deletions(-)

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
index da575bb1377f..d2a34b4d1797 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -378,6 +378,7 @@ static int mes_v11_0_remove_hw_queue(struct amdgpu_mes *mes,
 
 	mes_remove_queue_pkt.doorbell_offset = input->doorbell_offset;
 	mes_remove_queue_pkt.gang_context_addr = input->gang_context_addr;
+	mes_remove_queue_pkt.remove_queue_after_reset = input->remove_queue_after_reset;
 
 	return mes_v11_0_submit_pkt_and_poll_completion(mes,
 			&mes_remove_queue_pkt, sizeof(mes_remove_queue_pkt),
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
index 79dd2261ad04..0d580d1b5794 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
@@ -365,6 +365,7 @@ static int mes_v12_0_remove_hw_queue(struct amdgpu_mes *mes,
 
 	mes_remove_queue_pkt.doorbell_offset = input->doorbell_offset;
 	mes_remove_queue_pkt.gang_context_addr = input->gang_context_addr;
+	mes_remove_queue_pkt.remove_queue_after_reset = input->remove_queue_after_reset;
 
 	return mes_v12_0_submit_pkt_and_poll_completion(mes,
 			AMDGPU_MES_SCHED_PIPE,
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

