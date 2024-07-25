Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78172C52CDC
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Jul 2024 15:01:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9748210E854;
	Thu, 25 Jul 2024 15:01:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="PQrQCA+3";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2043.outbound.protection.outlook.com [40.107.94.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C326E10E865
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Jul 2024 15:01:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IJRoKWbeVaUVeWN/MnkmQeMaObSeTALpjUwLCko4eByoFq7bHMJC/sS6F5zjlp4euY40H9U0xxgMKybH0ewQFSMUOW3/5DxvQ0FPxc20gHxytPNMcQOmORdalQ5accHkU/ub8kCXzJlDqDG2dVEWKQ2qPTKHKfSaZltEtbTVLTNBeMpzCLM9y2V9AkjGpkZE68/MRc6ZRhiL+jB5p8tRlQ3P0X5xHvcf/AmuOg7m89BWG0slj0V5/LTCcmwXqIhz3Hvh7yEhwFOzC3rD36gB6zb6vOUm+zKHFnctNsayrFJJQMrgtHkq4sLHASyp5sEQija4ZnyYwAPAw/oZdTSr3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R3iFdKI0ZhI2Dw60hV03iOK0mGICSujcViknX35Y5PM=;
 b=Fg4z+ZtPSjtAEbu4LQVhwh5hCeFTQIhk45bGe/AeNT+L9MG9EXRgHtEcz04nCU0uZzerMAW2paBfQNzQiWL0l23q9p5725A/vvKi34gaOAUzHDzSROyx54ySIcbXcTGusD1mrxu94AwkyEFg6+m2G9WsgAT2MlQmG/4YjjiiWfJtoFI9fqzwBKR+1TFcq8q+JI2JGKy5J23+mwt8Ck9D+96uWiY4w36yciCWiPoNN4WVz3IqB8V9Hr73QhizMperq5qoYpQEgSLz8qreVlpmGxAMdnCIm5IVkb9LvMjqlV2aZTXG+E1QxrT3k0mdUqEXFNzv/XDHEZrEcsec5uNmHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R3iFdKI0ZhI2Dw60hV03iOK0mGICSujcViknX35Y5PM=;
 b=PQrQCA+3Fi5RK4hePJl+AorpzwUaDgw3Wy8MTLcdegOiZ79x6WC84fT37JHjMjQvlgHt/rSf0ZPlFemJwgp384Z8YpL50SijsvETk+LAXCrIWT0cG8UapyJ6fcR1K4iXO7TwVwCBNINXO9n5KbxumCibspMDTl0aE+x8EziU5YY=
Received: from SJ0PR05CA0014.namprd05.prod.outlook.com (2603:10b6:a03:33b::19)
 by DS0PR12MB7970.namprd12.prod.outlook.com (2603:10b6:8:149::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.29; Thu, 25 Jul
 2024 15:01:20 +0000
Received: from CY4PEPF0000E9D3.namprd03.prod.outlook.com
 (2603:10b6:a03:33b:cafe::b4) by SJ0PR05CA0014.outlook.office365.com
 (2603:10b6:a03:33b::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.20 via Frontend
 Transport; Thu, 25 Jul 2024 15:01:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D3.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Thu, 25 Jul 2024 15:01:19 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 25 Jul
 2024 10:01:15 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 14/53] drm/amdgpu/gfx11: rename gfx_v11_0_gfx_init_queue()
Date: Thu, 25 Jul 2024 11:00:16 -0400
Message-ID: <20240725150055.1991893-15-alexander.deucher@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D3:EE_|DS0PR12MB7970:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c43a1b8-5a9d-45aa-02fe-08dcacbaa45a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?45v5y/zfJ/Y2nvBo4jknvFYpCWomLFJFUBxC0xeKZanr9GO+UaOo+fVuR2c7?=
 =?us-ascii?Q?BOzkpHUtyJ5NjQOrr9RzNFGypgWOpFaiXJDm5tFtIn7Kgi0PkKl8ysNkAs0P?=
 =?us-ascii?Q?qyMI+dxZMp5HlIQy9PqKW6jwrigj7/ObMBTSO7Kn+d7oQfbu3Zcg7hQLuZnj?=
 =?us-ascii?Q?nJsKnB6tWCAgBk/A05TlfeBxXWMpkEErDKrn1L2qzLWSKxHwhZttC95eyn9F?=
 =?us-ascii?Q?4Hat6el8DSL0q1SEe5cOd2pyZ+kNvTvebGX7iI7e5m7Q+EcsXGl6qEeQNrwR?=
 =?us-ascii?Q?vuuzjF9/91YawtDjunL5a1BBNp5bY5rmQTx/q6sV40y+azGXfDA9AxKsOEDF?=
 =?us-ascii?Q?u7OZO1rCqM7B9Tr0qSFlJKERxJkuWQbQdTLHt+wRT5xXiPfV/WkmDbQCOIFo?=
 =?us-ascii?Q?1R1wwqKAKTFSZnpolQ2O2sfp5do98bvhYNPBmDBWBTCT+NeqqGhodsbUk9LE?=
 =?us-ascii?Q?1rh+TDfKenHMpFpC38OwJCE0jtbWIeZCNopKf4VpBqGfaumjmvZ/C0rxwaB+?=
 =?us-ascii?Q?+CLvKV2Da97G59CAnP4kyW6lZ4JIXgXdrANS94CpFu9ACvz/zLqDmULlddtA?=
 =?us-ascii?Q?nCX3+UOsCpcGPkLyp9dt/9lZEslW7hv1/TnoZUbIs0fES7n+k+3G2wH3jxdi?=
 =?us-ascii?Q?UCECcPNRpXzynCSTMQfLjyk1cQ+q/M1rDyDWWsMcj2rpVVmx4DdzoGacXgWs?=
 =?us-ascii?Q?A5UNDdilVB9NCcDVWUMQQpXYRdbTTuqo0tz1rnYhb2GFcL/idaJx+n2rX2bp?=
 =?us-ascii?Q?Xn1OrqsogNTCnbTIVbezj3aklshQai3HVFvmqAqDP6JS84bvoTLti+DxrHne?=
 =?us-ascii?Q?UDlvBkrLcjwN50C8sHlefJI3LUo8C9tLiXQESBcYtTXp34kBYExsG5HKt398?=
 =?us-ascii?Q?wbyg3i3AqRF0+LQZS8IoDJSxT845iRrnrwYWac372ZwQ3EOzgui3u5WYfsnv?=
 =?us-ascii?Q?rp21PvAznrlAfZm1jyCcjFW8tJMy28yAXIiz7Wf7y83wT+VKc69UxPAqwmcA?=
 =?us-ascii?Q?VOt9hHX5qvyzYBd6gXUOJWcrxImN/Yzai8nE44448NEI/cTZ9ueEjV7Jn9RX?=
 =?us-ascii?Q?h7JyHUA1jvJ8ZbIJWcGV2FoCYg7s8+ypMUCx7t4aKYnSp0rSC75ASS+7I1Pc?=
 =?us-ascii?Q?OZSoxFKL9SSH3ZTNEhRElbM/O2007rrtZIoAamr3T/aFw7nPb169kHSRQJjB?=
 =?us-ascii?Q?R9ert9fNIl/jbZzRBsXaMd3KO+ubXvXc3k/4diVk/u23KJxU7jPlEeTcA0Et?=
 =?us-ascii?Q?JeIQ2rWIHG96x1jLWIt7prqPvBmCMd3E381obmedjRb0U7QdH4KbkBBhJa3a?=
 =?us-ascii?Q?Fm2wCgdDgcht7q6qU1WKUMGvAgv2VFqmWAYgsahW3Gpa810AOipCXUI/4ymk?=
 =?us-ascii?Q?UF7dJtw8IrhqcB683uENhVNT8uJVr4fmRIYfgb4LcHmB4BXYuVjxKaaWWkum?=
 =?us-ascii?Q?o3pWP7vkkkuulUwi3lrIfwyVmo31fR48?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2024 15:01:19.9618 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c43a1b8-5a9d-45aa-02fe-08dcacbaa45a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7970
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

Rename to gfx_v11_0_kgq_init_queue() to better align with
the other naming in the file.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index d1c369972371..71e158f1efda 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -3966,7 +3966,7 @@ static int gfx_v11_0_gfx_mqd_init(struct amdgpu_device *adev, void *m,
 	return 0;
 }
 
-static int gfx_v11_0_gfx_init_queue(struct amdgpu_ring *ring, bool reset)
+static int gfx_v11_0_kgq_init_queue(struct amdgpu_ring *ring, bool reset)
 {
 	struct amdgpu_device *adev = ring->adev;
 	struct v11_gfx_mqd *mqd = ring->mqd_ptr;
@@ -4008,7 +4008,7 @@ static int gfx_v11_0_cp_async_gfx_ring_resume(struct amdgpu_device *adev)
 
 		r = amdgpu_bo_kmap(ring->mqd_obj, (void **)&ring->mqd_ptr);
 		if (!r) {
-			r = gfx_v11_0_gfx_init_queue(ring, false);
+			r = gfx_v11_0_kgq_init_queue(ring, false);
 			amdgpu_bo_kunmap(ring->mqd_obj);
 			ring->mqd_ptr = NULL;
 		}
@@ -6536,7 +6536,7 @@ static int gfx_v11_0_reset_kgq(struct amdgpu_ring *ring, unsigned int vmid)
 	}
 	r = amdgpu_bo_kmap(ring->mqd_obj, (void **)&ring->mqd_ptr);
 	if (!r) {
-		r = gfx_v11_0_gfx_init_queue(ring, true);
+		r = gfx_v11_0_kgq_init_queue(ring, true);
 		amdgpu_bo_kunmap(ring->mqd_obj);
 		ring->mqd_ptr = NULL;
 	}
-- 
2.45.2

