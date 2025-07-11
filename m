Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FD7DC83F22
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Jul 2025 22:40:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6D78A10EAF3;
	Fri, 11 Jul 2025 22:40:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hQ9GN6xV";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2069.outbound.protection.outlook.com [40.107.94.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6107610EAEA
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Jul 2025 22:40:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FoDPZyZc0uc593YjxPsrRkRXpFDxAoXwsvqTk+A6JLVxNIfcp/dADjNv1I+bTzQDfnizrpvkFh5s0qdA/NURXw0exhQkQ5wG36Th/4Bt91h811idoAh5nxlHEXZdc1ExOmlwX9ot5f79FY9Qcq8sOrawjRDKQIkwH+QEkyMKKxN9cqCbKDVrEDaM0Nx1UPIdYtZb3S5UXgERVhTXwnuhYN3ZTTFfJhMfz1NQkHrwbmv6GRqUJe281202hMZo/FSlnXRTUE7yueXT+iIKOMaTWxEcpa1lsHRl6DuouTtE5FHTlQAOAZE/isI5/ly9M9SJhDvnEdHhFMYPKX823vxyWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qdSbWLI92fk0NZIiSIRPb2CgujkbU8C7oti6Cmgn7EY=;
 b=yZfeVhXg7UK5kk4AfwcFyRquD+mxjfkTGIS+80YABh7Nghb3n+F4MfIgzYUfzayi4VPvFWthQPytDsOU0lAPct0yhhbYYS3o69hULtUPEHU27gsbEV7qvpBO1iUdGpTiou7S4E9D61iwfxn8+BMulKiytBoss6Pxdq68ZLaOFO2qwXTaawcbfxl9lpCw/aF0t/gkNJ2E2CbimAGuG4oDEly3odEL2SjRWc+1B482UH9exbZIyp47qqL4+klmxa0/tqI3J/ofe4UQXqedYihqhAVUFE0+nUV3tWQBS4l6HI90rLOAcCE9794REVUNB6cJCBANJS1LAhYjTlZeYvpCTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qdSbWLI92fk0NZIiSIRPb2CgujkbU8C7oti6Cmgn7EY=;
 b=hQ9GN6xVR7eUkvrWHC3YoSB060om1gZ5b2Hz/GYtc7E9ckJuPQ8a+Hgvz8WmQpKUcEMkGqmumh97kB64Ue9F+OukPK3DLSDGCXQmnV5QLXeX/YYzSes7sm+T/ZjpXZyQ/bU1H1lx2Oi3xJ3oK+BIB2MIJ7s8M84bffKo1UvnxHk=
Received: from BYAPR01CA0054.prod.exchangelabs.com (2603:10b6:a03:94::31) by
 MN0PR12MB6151.namprd12.prod.outlook.com (2603:10b6:208:3c5::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.28; Fri, 11 Jul
 2025 22:40:50 +0000
Received: from CY4PEPF0000E9D5.namprd05.prod.outlook.com
 (2603:10b6:a03:94:cafe::f1) by BYAPR01CA0054.outlook.office365.com
 (2603:10b6:a03:94::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.24 via Frontend Transport; Fri,
 11 Jul 2025 22:40:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D5.mail.protection.outlook.com (10.167.241.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8922.22 via Frontend Transport; Fri, 11 Jul 2025 22:40:49 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 11 Jul
 2025 17:40:48 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <sasundar@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>, Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH 17/33] drm/amdgpu/sdma7: re-emit unprocessed state on ring
 reset
Date: Fri, 11 Jul 2025 18:40:08 -0400
Message-ID: <20250711224024.410506-18-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250711224024.410506-1-alexander.deucher@amd.com>
References: <20250711224024.410506-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D5:EE_|MN0PR12MB6151:EE_
X-MS-Office365-Filtering-Correlation-Id: 774d6ee3-dc3a-4258-ff06-08ddc0cbfc06
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?1QSWqh+pJOi2mvhLQvFZcBPWZ5KFjOKYGc/0f0cgQNmyzRYwSlAtdk9OGX3K?=
 =?us-ascii?Q?QUD0I1uTHgGtkhI6xxvRZKf7flYPAjLyfcMcPI3IxFnU39tGtJpgeaZosP2Z?=
 =?us-ascii?Q?s2ddgngwHqULljJqldp4dJpeNzvDiQ3l7wvP8vfxDO3Q4y1uvT/e1eDZzGLS?=
 =?us-ascii?Q?Wsux95asJKLxGYOrZT8bXaHxq6nOnmfhj6xhvzUNcZL/MtgvNE8HjKzM6Hq+?=
 =?us-ascii?Q?JzZ6Tfk+EuuueLw/xA6CbJ8x1i9H1cyChmJvsQiqwoJ4wSqX/QcJEYq+FWDf?=
 =?us-ascii?Q?EhvnGYeggGdFTEbbArOTkXcQxe9EI3/YvHOAhps7Dut5536dLXYrGTk8Kakf?=
 =?us-ascii?Q?DOTC9OVP7spnNvqgwh8ktx6mVt13efiKs8Q6uS+QO0d5AwxjJcpclufaRKVe?=
 =?us-ascii?Q?F4Pgpyqz87r2deAlJQJe1GEktc4ryL+DVbZDO+cv8BuZaMIhlvPcJG3/PEom?=
 =?us-ascii?Q?C2zSIsxKLuAE4xdjwcOgkWcfJPmQ0+4YqPRtW7JdeHuvZCBobd+zWH4Et4TN?=
 =?us-ascii?Q?O2WHh2DPLCwTB5X7EKP7qpO+wotD+IA5o7IlltrY8wrUMvnX65Jec5zqzgPQ?=
 =?us-ascii?Q?qeLifXgSqBfZ9U5/5N0PW1dxGPw01hytxea+Mg0Q1NTVnDdo1J2lbr1Zgfy8?=
 =?us-ascii?Q?lNA/vAgvced5Cfj1k1BnqvLLftgXPBohofkYNaYu84SBbKn+WGC738gaQSai?=
 =?us-ascii?Q?rmQipravdwGxZSo6m6fSlkTHiWrSGqfashPHIuC0FV94JMpsN17lveQakTS6?=
 =?us-ascii?Q?Y99nZgQH8vcxhe1wCgFVxInOgg+HEPkEe/ghhEnKvYTBT7MGeQofOPab7FdV?=
 =?us-ascii?Q?AqB7DwC/SQph29h7jB3iOi0PrrU3GiSAQWFfCvhp7TNFJuO3tGGoPtc04r5C?=
 =?us-ascii?Q?d54WsoDBG49E1MoIgNZZ1vG4vHIdocE2VLZuUMQ0Pr1Al24yuA4q0OrazZKD?=
 =?us-ascii?Q?wJq5vs5+ppwHuU0UewWlv2+v/4B5EPgrdcbVvdV4HnWz6nouwMqGJPZALVnB?=
 =?us-ascii?Q?fDbwlvM/I4F+iSuYBw4Gof7H+MpVN/QWKSBqD8wk20jhCQeGyea1mP/9zCMJ?=
 =?us-ascii?Q?CjgLnySHm2GeETdiBuBR8k/zarz7LJ6S+CaluqF22YGlmBbFyLXAIHcPhZbK?=
 =?us-ascii?Q?cLj8O2Rbl5j4nKpwpCcCazBjGL4z2/maSqngMjwyfcxCZxaCkyiOaTtIWrqx?=
 =?us-ascii?Q?k9RYqk0gooqY62kaAmXc9bWU/ysOBKUNczUJQEXK99q9eIodgaAEk3H4Kfg/?=
 =?us-ascii?Q?k6JS7zYO6yYZgArTXiOMt9fwgT9YVnLg5OMl92la/OGvvN+pLxM0vdLNZ3rS?=
 =?us-ascii?Q?WFOCdQFjqT3uKuDtcjZa3nqUzrzt27/MjMtcWTXmWVByZR0POsW1WJ84Kd2S?=
 =?us-ascii?Q?dO/u7X6a0A3WDH2MaDRX2mBCrHjKSC4yw3uOqpwSB629m0QdIGzm+k7rfXIK?=
 =?us-ascii?Q?Jerrf5ZjqPhsN5hecURR86JuBBlsfCcYrAIWVYdsdWJPyX+lUorSs1OSmtvP?=
 =?us-ascii?Q?FjNCD6a54UJWlvQ9EeBYMiwJL8KAhfJpgAVX?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2025 22:40:49.4808 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 774d6ee3-dc3a-4258-ff06-08ddc0cbfc06
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6151
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

Reviewed-by: Jesse Zhang <Jesse.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
index ba1f3e3b6eb61..13abc0c46eab0 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
@@ -817,7 +817,7 @@ static int sdma_v7_0_reset_queue(struct amdgpu_ring *ring,
 		return -EINVAL;
 	}
 
-	drm_sched_wqueue_stop(&ring->sched);
+	amdgpu_ring_reset_helper_begin(ring, timedout_fence);
 
 	r = amdgpu_mes_reset_legacy_queue(adev, ring, vmid, true);
 	if (r)
@@ -826,9 +826,8 @@ static int sdma_v7_0_reset_queue(struct amdgpu_ring *ring,
 	r = sdma_v7_0_gfx_resume_instance(adev, ring->me, true);
 	if (r)
 		return r;
-	amdgpu_fence_driver_force_completion(ring);
-	drm_sched_wqueue_start(&ring->sched);
-	return 0;
+
+	return amdgpu_ring_reset_helper_end(ring, timedout_fence);
 }
 
 /**
-- 
2.50.0

