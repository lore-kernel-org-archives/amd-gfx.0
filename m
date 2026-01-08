Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7108BD1D46A
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Jan 2026 14:49:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0311510E77E;
	Thu,  8 Jan 2026 14:49:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="GbnBe/8W";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012023.outbound.protection.outlook.com
 [40.93.195.23])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 52AE310E77A
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Jan 2026 14:49:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wjzMXaad45RmDElR+0cOodie6XeAPKfNniLi92RCf1cD3u0w4rYTD683cLejVrOijS/Uljw+wm+YTCbcBSD/2zhmfJW/xI3g8NxI1MkTbq0qfRsXO9dCWU4vVS0gNIKhUoA84hsC0PVBXOO54OlW/awnOo26JlgAKoug+/HjZY3DrZpz5/Jso/03WOfVaTGDdUJ68wbbb/CV1aD3oZy30ISkCjTngNy40t/QI9MWwOiKB8sP5R6nkuacqLUE+GcR0Ke2QGlXw6Tf8qJckkY0GkGk9HYGemh0Yd0dy+4B7pL9MegIxAbnf0GmYBgPCibs0Yy4pAAq4IPgb8eQPnfJ0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3X4+jFaGZMFve3DlAczezF+oWf7/jHf3AOqGH0mKAuU=;
 b=k/j4DUWAridBBMImyE/MEk0bzX/IMcSHqIFHisq9EJRAILZJTzafuHaxyssAisHq2QqBURX36vIExqnw/9e+sJBfSO6WiCY1UQBeLDhDibpQD5vaF7+0LTrmWPhRYMSJ8kSmoXUFg6ZnbiuycpU8s9X1nNQEP0jaXn7JkLUjQrG3ZIUGIcOhh/dqLoORMdntw9JeLqWLptUoTaWaj5YAy5veV+c/PrYL1wt2jqMMMfZwrzduxuP+1UTxH0aoOie3BltE+hHwh8L71AK5WvodVZttMoKALkOvykIAwg9+WPsvCx7GmnwQRVYeAJ6ddI7q/sk92vQZ+GMbuZHtdvP12A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3X4+jFaGZMFve3DlAczezF+oWf7/jHf3AOqGH0mKAuU=;
 b=GbnBe/8WabQ00uJKwfwfbQJL9mZqEwRGqiL5t4wQklc/JqcXduDUUELyH4kL4ucDY6uEQlqhBrzbSToeAAIB53bAi8IDrt5rBeHb+OF5i3xBTS4+aykMmG/DHuNze2MDPE98TREd3RoKVXBWXb2gfypF0Ue2m5WO2QmEl6GhU3M=
Received: from BL0PR02CA0125.namprd02.prod.outlook.com (2603:10b6:208:35::30)
 by DS0PR12MB7947.namprd12.prod.outlook.com (2603:10b6:8:150::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.4; Thu, 8 Jan
 2026 14:49:17 +0000
Received: from MN1PEPF0000ECDA.namprd02.prod.outlook.com
 (2603:10b6:208:35:cafe::a4) by BL0PR02CA0125.outlook.office365.com
 (2603:10b6:208:35::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9478.5 via Frontend Transport; Thu, 8
 Jan 2026 14:49:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000ECDA.mail.protection.outlook.com (10.167.242.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Thu, 8 Jan 2026 14:49:17 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Thu, 8 Jan
 2026 08:49:08 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 8 Jan
 2026 08:49:08 -0600
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Thu, 8 Jan 2026 08:49:07 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 40/42] drm/amdgpu: add an all_instance_rings_reset ring flag
Date: Thu, 8 Jan 2026 09:48:41 -0500
Message-ID: <20260108144843.493816-41-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260108144843.493816-1-alexander.deucher@amd.com>
References: <20260108144843.493816-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: alexander.deucher@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECDA:EE_|DS0PR12MB7947:EE_
X-MS-Office365-Filtering-Correlation-Id: b65e25ed-74e8-4e83-1bd5-08de4ec51969
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?rbAw43E18QeLVqTxqZtETnt0VK41kIq1/BDhgTysHyWMDyQKQqBR0pd06sSA?=
 =?us-ascii?Q?pt0Kr9mdT75CuZNRqiZVJihqaZNLFKHP0gOyoJXH8K5N8DPUJs6oJGCfuMaf?=
 =?us-ascii?Q?Qs1cDhyalbI9K8eKDJMbxMAxG3UIxiWR7+PCsQnjYzA0qsN/hiT1BoWgbRk1?=
 =?us-ascii?Q?otxlFQbHqSJGbQMNDsUoWXwuWpIS2fV0y+xEG+nz9Wr9NeCyfKXnirTZf96i?=
 =?us-ascii?Q?UeOE62zHkHJZr23eyFcmpM1dZnMj+zbVPsy3UfZ05ke+RkhrdXm6hrY+BOdK?=
 =?us-ascii?Q?JeVlj6UtvL+x+ySWFYg9RhD5CXn4eUDv+jsC/HIVU9aPGxHT9BG2S62OO9mN?=
 =?us-ascii?Q?LqGyUM5w659sYpKqwWSFp6gR325HBLNtBpVoBR2d8o9XXBxS8T1BX6RXCt6Z?=
 =?us-ascii?Q?nktHyfB1RHB+ZE4c1+pUveOuCT1cRp9U/y+8w5fdU+dSMRZC+xO8En+HoTeD?=
 =?us-ascii?Q?yWXYc7SEpKTRfSTdPMd1SQA4ti3U8eIsksEaAUkcXuU9LkJaNjQOhdL9OBhJ?=
 =?us-ascii?Q?/lgrcwviByVVl0Q5ft+rexi4lHao0g7wDqZTVIwoW7koP/1dNLMzQh1eNdNI?=
 =?us-ascii?Q?rbBUDhqLyFHjivEXD5Glm5X9pLQz8tBipM9fbg+mC4n9U5a3f7E9LxIEXU2H?=
 =?us-ascii?Q?bErdCeuifHOONgyTa3lEGdPeUSRgUtgRgKxAJTTu3z9JCfhtIs7HOrS6wxWy?=
 =?us-ascii?Q?46vGze/0l0VJVsKGwizUaabDzNLHXTE/mwdX5t9kxEPIQhfRrIWDNIr7zF4Q?=
 =?us-ascii?Q?xcT79h5/dK/JHqy6nlzvkYi8FFscKWo1uAfmAy91/JqiOFD1/NJLVWXVxhPw?=
 =?us-ascii?Q?FqW/TS/07dUT4yrQurcFWISe8vc+OwcSjNqRWqg+OMu9QR8nCJHig+oiqO5w?=
 =?us-ascii?Q?BGM8smP4rU9q2YCYJmB0mDGKdOTQok5/D1y5ZtAj5tBtRuF2V1lD+M3bog4o?=
 =?us-ascii?Q?f5NZgjM2njwF2Ncu1jv2/E6HcYIgFbA6QMlrIB/8lUdbeCC5E72f6pnr/6DO?=
 =?us-ascii?Q?iU1f/2YgfdyH6RE/RlkwkVjEUIRC5tZ7f5MrtvjJx13FvUAM9rrsXCMrjn35?=
 =?us-ascii?Q?XBDC0Tmym+krCI5QjG0sAgnMobnWKsw+i6Tso1sIdQ+wWCssSoapkR3ldlbF?=
 =?us-ascii?Q?79tRGkzii+XTfgpL+BW13/JRyX8ZsVn3gIpgahWJpuDi4gYb7JhDBZ0xPUN+?=
 =?us-ascii?Q?2Y566Ts5aB8mC4XGzv+j7WiX8v1cfAX6o5L4S2vm8PaPDvdcDQiR01tTnw+B?=
 =?us-ascii?Q?0vwnZA0gpdy4kO2WfJjmDdcgcrBlfXgMvz/SUVY0xMoEGXlRWiVlY2EIqf6a?=
 =?us-ascii?Q?ZwRUwikIO+GE6sC9VpEBt/F07TRU7jhE5ZRQcKlqzRRLytBfGiPg7RrwbQ0O?=
 =?us-ascii?Q?jfbI6a1wrk9TM4j2/g44CN2D/JZ7T4wB021ve0Vbi3UunokE3tVOia2T8vDD?=
 =?us-ascii?Q?upKmMZtEDxJ6NeI7OHqqhnQCiiheFiii0HRV0GGgRc8IDWbCGtYsLEikvGtd?=
 =?us-ascii?Q?yie/LGuIzL5qvDTr+FM4cfPigj/rTME0Hafooxk/zF3PaMVK9OW/Xe+ZJYQY?=
 =?us-ascii?Q?uDL6EOrXGETmUttZKVs=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2026 14:49:17.4594 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b65e25ed-74e8-4e83-1bd5-08de4ec51969
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECDA.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7947
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

