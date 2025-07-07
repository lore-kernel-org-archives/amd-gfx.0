Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02ADCC83F0A
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Jul 2025 19:04:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7DC3D10E539;
	Mon,  7 Jul 2025 19:04:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="oPDp/QD4";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2079.outbound.protection.outlook.com [40.107.100.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1586910E536
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Jul 2025 19:04:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iGf7w1KPnFRNTFe/okw6dxFz+HGgmaO56GaCxY33D1V05+7IzQf2FyXSUn1EcN2Ooaof0v3aixkf3GwmIDi8jkC27YYr5bjVjKtpprusI39ZcLYFuXr3x6wZpBFypvHCwxDZt/u2gk0iP1u8+uKuO8t29eljzdJ5+6BCh/uDEmI4OdkC2z9yh7/HR55FKEgjBpss17XwQfPPj1obdVMpF34u929MWWCq4oUbzRdle0tQltVVeTvy+xUAGqxmiI1a+dd2YP6VCqqA92bnzgqiXyU7kJNwYSmaOAqVetVjTq7Mo5BUdKA+duk3gsyeis2g6r9ttgPNUwTPK9aSqY2SBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kJcM+iffO4yA4CeFmAkL9avhgHeSixcg4vk3BdfcT8Y=;
 b=PQ9yRz+7WeWVtLO/6VRwaca1Wzew8DeoRTy3MCLeq9H/ZWKoxp+7i8eS8LCTUB97sjF8VKSagmW0H5tOr59+UXHO1+lrdNlNwQ1jTTz9CWTnxrBoCJqgZ22GxL+J2BJskmX7yeRvVOngBQNJoOEihJWhkKn4USq3Kc1DpJ90HtSzINZmgqkINLVetIdbTE7ZVMkSxNQqhkJYjzE8i6LG2ZPS0DKA8FxFw7MrvhgVyPuUBNSH3/7wcq9BUhZT0kzQe4nReHY0A88HtKDpm8ls1jmC4UsjQPwdp8Fp8W7vMzovux+hssOuGjm2kDO7gX0PGyxnym6K7zEtbChOnBgllw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kJcM+iffO4yA4CeFmAkL9avhgHeSixcg4vk3BdfcT8Y=;
 b=oPDp/QD4vo0bqY0XU3HavHhDe05DNwLxipodn9oCoSWScxD0w7bxp4VzMydchb0t/cSUOu04k9rS8I9JjZ7VxxT5CPFaRmW0jhEiD6HJp2YSaeGS+9WljCAsBfLN66N/v219npk37T/sXad4COP3XqACWeuVFY1VNOI5IvbJgIQ=
Received: from DM6PR11CA0035.namprd11.prod.outlook.com (2603:10b6:5:190::48)
 by IA1PR12MB7664.namprd12.prod.outlook.com (2603:10b6:208:423::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.23; Mon, 7 Jul
 2025 19:04:25 +0000
Received: from CY4PEPF0000EE34.namprd05.prod.outlook.com
 (2603:10b6:5:190:cafe::84) by DM6PR11CA0035.outlook.office365.com
 (2603:10b6:5:190::48) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.27 via Frontend Transport; Mon,
 7 Jul 2025 19:04:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE34.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8901.15 via Frontend Transport; Mon, 7 Jul 2025 19:04:25 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 7 Jul
 2025 14:04:21 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <sasundar@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>, Sathishkumar S
 <sathishkumar.sundararaju@amd.com>
Subject: [PATCH 22/36] drm/amdgpu/jpeg2.5: re-emit unprocessed state on ring
 reset
Date: Mon, 7 Jul 2025 15:03:41 -0400
Message-ID: <20250707190355.837891-23-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250707190355.837891-1-alexander.deucher@amd.com>
References: <20250707190355.837891-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE34:EE_|IA1PR12MB7664:EE_
X-MS-Office365-Filtering-Correlation-Id: a2192eed-fd96-4374-1505-08ddbd891723
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Mxkmnv1bhqfdslJ0mg48dGqb5pz24HvR/rNjJIgyDYINv4pNNIVmG0vr4laG?=
 =?us-ascii?Q?ETUFO2K67ZPMEbM7dC5g1PZIvytRLlzV5nuORREEDFUFkB6gpD5Zo0+YU7LC?=
 =?us-ascii?Q?N9i5vsezlrSjy00BLzOZtc+mKQoCm6qVWb+HRhAiEObqjF69TZ6uD7C/vz2k?=
 =?us-ascii?Q?w+FVEamGkm7ZbE5vd1UT7LCgn2qttm2PIJCd/wlPoYNCFWGFmjCUOOr6lASV?=
 =?us-ascii?Q?t6jxGyIZNRpIsMyr1r6UIduzk7WzhblTC40vGGMACR9RCWt1i7algoppvcdX?=
 =?us-ascii?Q?xc9+mwtEqwxPge++7i0WpVCcGN5/k3XYg8bT0RabHJcU3uQc/8pGjrxRexI3?=
 =?us-ascii?Q?TaAEe4+Y+BAVo2qugjjR/6x1w0jPeH3czdTwDJ9ZtIyqjdcWV92/AE0yv0X/?=
 =?us-ascii?Q?tRTOf9g5v2m+ayAuYD4SaRLXmLRNTWhJP5B4NxC5NCqopCpYEroHa8PQjHvT?=
 =?us-ascii?Q?ciBMp0P4IAlrXKNql4OXE6XgJY4C35D5LQwZY4KiK5kdmPqpY1lGyeaztqXK?=
 =?us-ascii?Q?aDQgGCajnyUkLyRDyeLsNxunThFSxEKjkmuoa6AoAcywNqffOWK0z3m9pMJ7?=
 =?us-ascii?Q?BJuuAR5as1cuQAJQHYUVP+a8FuM/Nr6yDlLDKa2l7vNXuUsY+I4wzAwomsAD?=
 =?us-ascii?Q?PBqswVLiJlYhvXqFCBTpH0qr4WBypdraWB5LhSjN5sxPmLtGDTGK7Z3VCha5?=
 =?us-ascii?Q?GQF43KUwAimDsW9YNkk61IoIn+1Bqjq6k991XH3ul84np3bpQ0Rp4N2EH4Tq?=
 =?us-ascii?Q?KZ0Th8LJYJZxoohgd9lHgR1xP5gYSMAXL9iz0WXteGsf+RO4ej1S8GY1Rxrv?=
 =?us-ascii?Q?z9Mir1U/HgyEJi5z1+miH3k6rZ1HDp4zMgISm0vsVmOu+tRp7MCaK1EPpq6E?=
 =?us-ascii?Q?4B0nhjN9o06SHv7wUzJsh3OmifbzJp/eoxKTjBMoKQ7zavQS2ktipYiHpGwi?=
 =?us-ascii?Q?czAi1f1VQBJerCZHkC0/37DnhhlBqaX4euZcLorMBedS/Oy9ZsR4G48kX8aX?=
 =?us-ascii?Q?MiKawxOEY0zlBttQGOtIMxEPVdYSrmGwokutB/Aj6WVZUlWEh4eyzLg9kqUq?=
 =?us-ascii?Q?lW0EcxT7XgwpTy4EHRuEfbNGRDjOGJ0rcjt434Q/zhoGvKcy/ak4LBEHa+ED?=
 =?us-ascii?Q?RvnmsdyW1YxPzDQA0L6Q2F71UBRjtxQ36bi2v+s46GtqaKJv26czIHqDQlp0?=
 =?us-ascii?Q?YPFR6o4AXtNbvS37vxj2Yj8PSDyzRHOlusS3likeHqB9IRFxbyDDxGvxyJLY?=
 =?us-ascii?Q?A+iO74u3TMQ/D+oTRmZ95GC1pis/MzvGuzRsyW9ZGQeeFT/pj85KzUIY/I0l?=
 =?us-ascii?Q?aRKJQsgNPufu4JQmpU70EtufFXJ/wfFF03ANm+93Fy6ntfC8Zq4DGWsX2J7z?=
 =?us-ascii?Q?LrcsFiD3cX3Pj3/iAQreKBWebxVcpm/yzXHouhpJohn6b7Njj/4Mo/fewsFo?=
 =?us-ascii?Q?FAc3WowugxsQHuGqY0zfDHLj8IpCf8JxAjGbYXqysfY2lXk3TTmNed7aCn47?=
 =?us-ascii?Q?wJ5Lk5cOlYhiP7vLc3aG7we25laWt/vTmaJU?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2025 19:04:25.1929 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a2192eed-fd96-4374-1505-08ddbd891723
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE34.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7664
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
Tested-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
index 5be9cdcae32c1..7432990f77507 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
@@ -647,17 +647,10 @@ static int jpeg_v2_5_ring_reset(struct amdgpu_ring *ring,
 				unsigned int vmid,
 				struct amdgpu_fence *timedout_fence)
 {
-	int r;
-
-	drm_sched_wqueue_stop(&ring->sched);
+	amdgpu_ring_reset_helper_begin(ring, timedout_fence);
 	jpeg_v2_5_stop_inst(ring->adev, ring->me);
 	jpeg_v2_5_start_inst(ring->adev, ring->me);
-	r = amdgpu_ring_test_helper(ring);
-	if (r)
-		return r;
-	amdgpu_fence_driver_force_completion(ring);
-	drm_sched_wqueue_start(&ring->sched);
-	return 0;
+	return amdgpu_ring_reset_helper_end(ring, timedout_fence);
 }
 
 static const struct amd_ip_funcs jpeg_v2_5_ip_funcs = {
-- 
2.50.0

