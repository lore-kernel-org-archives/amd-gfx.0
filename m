Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E619DE9A04B
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Feb 2026 19:34:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 772C310E30C;
	Wed, 18 Feb 2026 19:34:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="FH5SUaw3";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012037.outbound.protection.outlook.com
 [40.93.195.37])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2F85810E302
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Feb 2026 19:34:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MXrFPY6D+XQefbkVwg1DBOHtH0adqqbjOFUqUOSm3D3GFCw5jcN009bkzLHJRlAA4LAePgdy8jyUHOpARe6fy9hZ0M5eNcTCMtYogIk6hJcDYxXje4T7xxUDjVdnBCnlApdjYAcfi7qhSftYVmJph3D8cmO47NBChq5rDjPkqTESTG5nQ/pOtiYol7fidZsTXIXnK0BXMvhS7H3JQn+qwUdSMqwAroyElmPFQHPrcvZJAmBDeo2bm1uMHpdPlGkG1hXjoeqmK+dBwbus2UOLRAZEYWVWys+d5z959kdEIoJcoC+wkB4h+x1qBsAmmwW2KGJbZeO4vhrKhqYnc62n8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1ZTD0RvVvnN1yvG7FMKgm1+Ej3dqXvivESvlwtLtFFs=;
 b=ATf+WP7oDGoyjfRF3aTn/3GyecKhz3E6yYenu/CjBDQg0ATD6ZN2nDkHW1/9J9dS5cKVYJ+DHvzJLa5JjRhDkYU2dNZHcfQJHaoxlCTTyGdLru7XK/mGiO+vbUbuSdtx6LmHUn77RJfvmAlWYFwUy16sBrYwO1NUTMeEKuNStzw81NmyVqpj9Hxi0OnWcBFhpeSZT9tA73eFZzqlDZoxdHz0HUBbSDn4cIqyjJHlqi06QpjXWBFqLAgamC6memVSNzRfKaCd09jVOXRYa15hQtbrPuDN1gYUz1c4eEBrs1BA2eljU8tqGI0VNicOrUn49jOC/UvC34xHaBhcyDQf/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1ZTD0RvVvnN1yvG7FMKgm1+Ej3dqXvivESvlwtLtFFs=;
 b=FH5SUaw37ZSm7vDn4vdOKZI5B3eOORwKOpaI0/JgnulZHPp960DJ7N6gxBZxGcxxL1JPo6DUbA7USs+/DQ4Loe8qATeTvZfYdY5TVJsBueSq00WImtQoSII2hH58nh3C2KbX4yFypzTJ9RFPLXsPOKWB1aPKQeqBqv6dMTY1Di8=
Received: from BN9PR03CA0350.namprd03.prod.outlook.com (2603:10b6:408:f6::25)
 by DS7PR12MB5768.namprd12.prod.outlook.com (2603:10b6:8:77::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.13; Wed, 18 Feb
 2026 19:34:24 +0000
Received: from BN1PEPF0000468D.namprd05.prod.outlook.com
 (2603:10b6:408:f6:cafe::27) by BN9PR03CA0350.outlook.office365.com
 (2603:10b6:408:f6::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.14 via Frontend Transport; Wed,
 18 Feb 2026 19:34:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF0000468D.mail.protection.outlook.com (10.167.243.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Wed, 18 Feb 2026 19:34:23 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 18 Feb
 2026 13:34:23 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 18 Feb
 2026 11:34:23 -0800
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 18 Feb 2026 13:34:23 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 2/6] drm/amdgpu/gfx8: align mqd settings with KFD
Date: Wed, 18 Feb 2026 14:34:12 -0500
Message-ID: <20260218193416.1474441-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260218193416.1474441-1-alexander.deucher@amd.com>
References: <20260218193416.1474441-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468D:EE_|DS7PR12MB5768:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a173281-2f91-441a-c5ad-08de6f24b884
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?bLxYWwkG0mCEFakqCxWibkEuXb3sD5RxsjaW6L9UJSe7ZlIKFqfCxEO+EhtE?=
 =?us-ascii?Q?veGgdGr1eeY0xP4rWUJ+H64HH4BLhigrvOSu5TIY2Q8Pi9w+hIn6oEqMbCHx?=
 =?us-ascii?Q?7hObkP5h87t36i/4/eSs42XmjUvtOqyEqCb6Uy1/z9rhYYaU9yeDSB7O12G7?=
 =?us-ascii?Q?psDCrSI64t/hL1M9jWlv9GTBcgWpJ8PVu74VtaAgBIY/StDzRnDhpB5Sdc33?=
 =?us-ascii?Q?+kmWT6RQ/7l34dVyfD0soNhMt548SdT/cdjqMyyo4IMTZmaAobWeXiP5mx1u?=
 =?us-ascii?Q?pFqJSgfB3ZVXLZ88dKzyPWkEGltrXWINg5MSqKSjnMfE4n/94wJLPg6MK1aa?=
 =?us-ascii?Q?+ILlB4b+L9GQv8J3bLa/txKL5JZ7JvDG1ztKtWpIaJ5FW9x0QoKhH+gSUMRo?=
 =?us-ascii?Q?ai4dWjEISPdGeLQsqcP0WUmsYGWPmIAyaQkZzu1Syz85YZi0Hczjz8CZU7SG?=
 =?us-ascii?Q?tUjieDyvaYNg54RUC11KyBfu9KuLvdTqTH9F9kqq64x/rOiPGtKUV1/Zen6u?=
 =?us-ascii?Q?/FyQRC+JyLGowlKpdYK7zm1llcCiQw24Y8Ni5nWE5dMdZxSTsH7N7zZGzCr5?=
 =?us-ascii?Q?5034/X2L9TK1m1av3tQ7PMnXIwXkAwAwnDIwEeLQvCKadF9r4+XyanaakDMe?=
 =?us-ascii?Q?34Svug5+YPwyitjnFFl09+yhfNbKVCiHKgLa3nkWsUaaVJoRxbSyy6Dlcvr2?=
 =?us-ascii?Q?jdtnVu9MIsvj6yw5qiiitXl7MwGINjBmTQG1v3cEQC/FuBvKh8jzlJ42911r?=
 =?us-ascii?Q?7MOqCxqHFdF7HJ8wXn64uZ8pq/BdJ47qUXphkBZ+j+B8CREgd31Mgs24OkXz?=
 =?us-ascii?Q?DbJfpYQywV8kdvtX/QjIY3k9qJUtjK7v50PtIsgdvHiqYW9K/1YOKSPVblVH?=
 =?us-ascii?Q?W/CwrmNPPfC9z/tvE1Cpbaru7XAC1WOXRvE/MJ0U7Jf7E7FkQ07g+9tPXIVm?=
 =?us-ascii?Q?xeKzLqYZWhmMTgxJYxCPq1OUHSwfr6aSgotkKNbQ8u0h1aeCWvre61TRUfVU?=
 =?us-ascii?Q?sZs0f/zKJXlIeHwMKGyr7aXVWiWtX+AcDql3o/ca2iLjZ+jhaw7zfhwCiosR?=
 =?us-ascii?Q?ICBUAb2Jc7ywCz4tMlI6o/rphTYpuge28pinW1Ap0zzliPpZ3sLQbAB96+jP?=
 =?us-ascii?Q?XL+9H279SYsFwZ22ipgFsJC8BoRszv+cm0dUqXVac0L0nXzlM4Ow37N72mBM?=
 =?us-ascii?Q?sSyAvpdXDB7sIJo7OhK+CbWnvfGzpHWqRmk+mdrSxKkan5E0g6Mfg2kzFLrP?=
 =?us-ascii?Q?h00lw0Rrd4InLn5TjvmGVlEeKWGKbvlla3JukYiMZiA7tNGDMB5i5C3KAK4L?=
 =?us-ascii?Q?PVR9+skVVLPYwOozGFmS3civ0I8y8gpFB/0cUNJfEwq8HBDn0KCXhoubHb/Q?=
 =?us-ascii?Q?9xf2kRHsn6KUv9ikawLU/4wNOd8gGUekZqVZcb4Jb6kovsY4kFR3jwmGsPqB?=
 =?us-ascii?Q?vipJJ0HpUuwRn3UHm8/c3rHv4zpcO9qmmoABrNdhRv1ERzwp7+fMojGDdXy/?=
 =?us-ascii?Q?k80NtmpBDjEkphXhK/bGdmEqxGR1+wFxaaJ1DkhUSepRVJol7tiqlZLt3HRU?=
 =?us-ascii?Q?+haGYQT5k752Br9Kn+9WZr2HoeKaKRbbnrMQwnLpOlkKS0OkmsSpXDb9peOO?=
 =?us-ascii?Q?SRBkrsy5Km+JOcUkV4ssB0FQTw7BTKVWA8ZE1Z6VhBycFlZlyzU69CvDh3Nz?=
 =?us-ascii?Q?qDkMiw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: cfBOOL+W79l++pEkM+kG8STC/caaz17HI4xfdXXtOZuqwgq9ryXyXpTzVQLYnT0bZwcJfBDSFfiJorkIhQPGDvqLKCqsz+vvyU2aCSM9qC/4Yy/nItu8wiBSEMAS6CaCBV5MkNp3lZy25FNCl26+R7SGwBMDi7+chIajxz/LA3CcrKWZMeZQ2xy0LdEHfeABUcX9xhzEdz5HHHIKdJS4ltG8Ihw9J83cKP1HKs9slXAqNLdGtrbQqA89AmEg7KxqhfQDTTCd30F80Xc9KwQM9Cn1Nie/UzpNzYQohG9Zi2lGVlZf49+TOjyXaGGoTyQh5iu0Od3KkHuWudZgES8/Z/tIm0EV6Kcqn5qPa138vNWja5VndHKZ6/AMCz4kG192YjftH+/TtaKzCMBi1TzO6/FPlKc3Zd0MkXOjyiq1Ypbj2c37jkdTN789lr5XfB/a
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2026 19:34:23.7974 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a173281-2f91-441a-c5ad-08de6f24b884
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF0000468D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5768
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

Make sure to set the quantum bits in the compute MQD
for better fairness across queues of the same priority.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
index a6b4c8f41dc11..130196859ff3f 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
@@ -4532,7 +4532,11 @@ static int gfx_v8_0_mqd_init(struct amdgpu_ring *ring)
 
 	/* set static priority for a queue/ring */
 	gfx_v8_0_mqd_set_priority(ring, mqd);
-	mqd->cp_hqd_quantum = RREG32(mmCP_HQD_QUANTUM);
+	tmp = RREG32(mmCP_HQD_QUANTUM);
+	tmp = REG_SET_FIELD(tmp, CP_HQD_QUANTUM, QUANTUM_EN, 1);
+	tmp = REG_SET_FIELD(tmp, CP_HQD_QUANTUM, QUANTUM_SCALE, 1);
+	tmp = REG_SET_FIELD(tmp, CP_HQD_QUANTUM, QUANTUM_DURATION, 10);
+	mqd->cp_hqd_quantum = tmp;
 
 	/* map_queues packet doesn't need activate the queue,
 	 * so only kiq need set this field.
-- 
2.53.0

