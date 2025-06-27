Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 166C2C83000
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Jun 2025 03:40:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7EE6510E94D;
	Fri, 27 Jun 2025 03:40:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XChndpxd";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2058.outbound.protection.outlook.com [40.107.223.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9643410E945
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Jun 2025 03:40:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EXnLlyI4LuxpQJu1Umnre+U4dFa+eFrbDeBTpHTtGsc0pTSKP07QTBu7VtOPCjcFzWU/+IoVdr3rIkebIt3dLG6oHa3AXqzslx1ZumTzL/kHaEnnDAZYnpqRrJH2+8w1JL8Rz8Povib8L6L5A1Md3wE+TjLxLrOsd0hBhCjwtMy8GEHHOX9mL7zwAMEm6SSQUMZdB48eEv9BWf7ehKjPt8Qtb4fiRUbp4XLu59F5O4nsNDDQrZnajdCBdeK7mpAP0oEy/YcifTgtfCN4LOtU96ksr5PyYy6DdOOIEUiqaGOoe2+Dds6VowxmH9LOBYVpYXzLBzLF0zLaabzz+m1nIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=46E8nH9sWDvXFo/ZSzwpwdIYcye14AJ8ItNoitZ42MI=;
 b=ufLpRPmukjukC8ZN1lHhWHMxDoaGLpP2QBNlVJAURT4tDURTEHLbuYqAJ/6djZ16rY2hDyOi8FOczYKo7LixmgXC1n6WhvaQxeK72MsIOHSOanV2rIcvB328vtWRir9/Uwj4tc/qe30XpU6CKWH7l3e1Bew1ijIK8nAm7nhUP55WdsmSHfeDAmqa5Yckp+3RNRFxPBS1yvy9EDuu8FR+ZHZ+riKSlewmnEJvY4KWt9+C21VugahdiLY4O+cyi+MllbovzyKX5Q8HtPuPt3J2WWVYXGFbLrtnLz4FcbmEXV7oy23HNY1L3DOlsv6DPMXQ2IcvuNYZoXnlxuuZVlrMug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=46E8nH9sWDvXFo/ZSzwpwdIYcye14AJ8ItNoitZ42MI=;
 b=XChndpxdnQJGshnW/F2Q2FluhhP/7V9xGZAVkJs64Yu4Og3uJ4WKcxtAK3jHD0QPaSnEvrnobsl1qWUnAAoIBlzKCl/GMdpOzNxxj1erekLDKC3FDXUUnEQOVywX6Nky9FyCniu1a3BffkOUt6oRnb9cguvHYhIZ+XNq+u94duw=
Received: from BL1PR13CA0188.namprd13.prod.outlook.com (2603:10b6:208:2be::13)
 by DM6PR12MB4234.namprd12.prod.outlook.com (2603:10b6:5:213::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.28; Fri, 27 Jun
 2025 03:40:40 +0000
Received: from BL6PEPF0001AB59.namprd02.prod.outlook.com
 (2603:10b6:208:2be:cafe::2a) by BL1PR13CA0188.outlook.office365.com
 (2603:10b6:208:2be::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.6 via Frontend Transport; Fri,
 27 Jun 2025 03:40:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB59.mail.protection.outlook.com (10.167.241.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8880.14 via Frontend Transport; Fri, 27 Jun 2025 03:40:39 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 26 Jun
 2025 22:40:37 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <sasundar@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>, Sathishkumar S
 <sathishkumar.sundararaju@amd.com>
Subject: [PATCH 27/33] drm/amdgpu/vcn4.0.3: re-emit unprocessed state on ring
 reset
Date: Thu, 26 Jun 2025 23:39:56 -0400
Message-ID: <20250627034002.5590-28-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250627034002.5590-1-alexander.deucher@amd.com>
References: <20250627034002.5590-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB59:EE_|DM6PR12MB4234:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a62ae5d-26bd-4c55-90e9-08ddb52c62ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?hFpr3lzTc61Ohwspi3Qiu4nmqxWpWd7wZYqmJ6QcUutWYiNmhxn5jZ0749Z2?=
 =?us-ascii?Q?FzMErMaVB58gZr/ucJOJoTLXzZ1PE+40HG/yGRPzjnpfjiEoGlW9L+ArG0NY?=
 =?us-ascii?Q?lxsJG6HsLqjvE6+FFASY8B1x1oz1TtZQ6uNCesitaMnei9gE5ixUJutTbMFI?=
 =?us-ascii?Q?CSwg2rYkshoo/kQUpRUBoDQxIi9wQFoVDXwKPPIQ3YU5BUM7dO0RniUC8isG?=
 =?us-ascii?Q?6xmrVKsmhfGnWiRhE9iCi2AvWIQOk3Ze6f3JEc+td+I4fXLHSo5/UBgpoGm9?=
 =?us-ascii?Q?VVrVx/yB/LdyXWrvkX1Kw8Vb9+fNvRGbOBAaCsaBUcNLg2al3a7Pjfi7ytKZ?=
 =?us-ascii?Q?plt3KqemduAjLznS1E4z81kWlJv7BCeQ5o0RtRph+vP7mmekrGX/eGbm7RB4?=
 =?us-ascii?Q?Vv9GGcPdgIe/da/6ipDRES31Dr26I3a92XffmR5Sn/HN+v9gl0Yy8YKcsl8V?=
 =?us-ascii?Q?Qkt3qOgE3ZhKMPTKODaTkwflXknc2c1CCICozGX6Ngsrz4xJEix5QQKZ+EK1?=
 =?us-ascii?Q?tl5hrBauRl0GYBDp/CJGfl4W3hCL2fMCDCNkvvHBnf2u5N/nLYoBSsMRxgOx?=
 =?us-ascii?Q?Zz+cUopKD0PhX8hbPEnn0+5fHqRA1AK6Dw5NKE7fNJpdlAIl7Zgi7xwLLWDk?=
 =?us-ascii?Q?dhOC3vsh6d4MnMM3ABaCBb+78S+PW2CSHee961hm+JCwD94ciIWnJ0jbEArS?=
 =?us-ascii?Q?jxaQ1S6QQpl+NKAFdxNQQ1gEzQJdikqPlIga5m1c9cMhRPadrukFjCdIMXZj?=
 =?us-ascii?Q?Zzio+p0biSfY5pp5L5YjgGSqDod2PI1j6kkE66eIGCnJbWU0rMeMtJsCaD8C?=
 =?us-ascii?Q?06elLrpmNInmlK6yMeLdzVZGQGStNHedcy789M3EQ29YRwtj+Mybd5y5INlm?=
 =?us-ascii?Q?xJi9rROnRj36lDp8mxMfWn8i27rX1+494GSgjhdV29FMbNWup3vNt7Mx2bfI?=
 =?us-ascii?Q?UF+oLViTZvyOROE8sDtW1cJ7gBO1WjsWXHxEIAx4sAlvTwQasU4iUdUzReXK?=
 =?us-ascii?Q?IVTFMxgYprc2ka2SFcJyG+SizP3VGluLTX6IfzTQWAaHfyo9z09UTuGzqd0B?=
 =?us-ascii?Q?r3jHzCN0e2QIWs67VH4SKHHR1W2VQEVoK3UFOru/7yyqJBYYjiwvU/H+Zb4B?=
 =?us-ascii?Q?qIot4ewZeXEBTqmVA0P1KXu4TnB5chF3jZYZ3FzQWCxYZj+yvLQqwyTvziUp?=
 =?us-ascii?Q?GlGyCPoF9pEKrbfDJaMGx3g7UYIhzm2CS+ajkpOb0yqRyR8JreI/cu7cO0m7?=
 =?us-ascii?Q?j06IclqTneY80rmqlHQCj88gnznTCs1WgWZTfAQb/lfZIzxsOGZi3JuwT4oc?=
 =?us-ascii?Q?CzrDq91+Kmbb4HXVCb8rTr3H7WHoP16e2zYQFuER/LoD1U9lzwOKmaI2j5JN?=
 =?us-ascii?Q?6lDTNROJ5v60lU9fGDkSTEq3SbqseJRrA5cyflK7HGRKa+OCPyLBqo8IgIG1?=
 =?us-ascii?Q?ON6heFhuw9GakxaV8nZ3m/ALzeK87qzVl2u7gsvSAnUDrLqWrPcn27pymA7E?=
 =?us-ascii?Q?sYlLFewXpgFIy63NwTg73LALHag5imUw/vG1?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2025 03:40:39.9074 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a62ae5d-26bd-4c55-90e9-08ddb52c62ef
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB59.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4234
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

Reviewed-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
index d8fd32c1e38ec..3bda19b92cde7 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
@@ -1609,7 +1609,7 @@ static int vcn_v4_0_3_ring_reset(struct amdgpu_ring *ring,
 	if (!(adev->vcn.supported_reset & AMDGPU_RESET_TYPE_PER_QUEUE))
 		return -EOPNOTSUPP;
 
-	drm_sched_wqueue_stop(&ring->sched);
+	amdgpu_ring_reset_helper_begin(ring, timedout_fence);
 
 	vcn_inst = GET_INST(VCN, ring->me);
 	r = amdgpu_dpm_reset_vcn(adev, 1 << vcn_inst);
@@ -1624,12 +1624,8 @@ static int vcn_v4_0_3_ring_reset(struct amdgpu_ring *ring,
 		adev->vcn.caps |= AMDGPU_VCN_CAPS(RRMT_ENABLED);
 	vcn_v4_0_3_hw_init_inst(vinst);
 	vcn_v4_0_3_start_dpg_mode(vinst, adev->vcn.inst[ring->me].indirect_sram);
-	r = amdgpu_ring_test_helper(ring);
-	if (r)
-		return r;
-	amdgpu_fence_driver_force_completion(ring);
-	drm_sched_wqueue_start(&ring->sched);
-	return 0;
+
+	return amdgpu_ring_reset_helper_end(ring, timedout_fence);
 }
 
 static const struct amdgpu_ring_funcs vcn_v4_0_3_unified_ring_vm_funcs = {
-- 
2.50.0

