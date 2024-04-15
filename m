Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 007B5C4345F
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Apr 2024 21:25:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 08AFF10F4CB;
	Mon, 15 Apr 2024 21:25:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qLH63sP4";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2056.outbound.protection.outlook.com [40.107.95.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 223FB10F471
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Apr 2024 21:25:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i5QhefgEc78VeEAzfsUJkwm69V5XeNTXianIL5jfsgCsjh0HwnV6U9vzV+V7fkyJtK+cHhwSomaex2fSkV5cr1B8Df0+ANSC9Z0q9Ev2zw1tNymlTDojtP4NBKL4JynuJNgs1qUnnajBNMq5hEB3wzQPQivJJ6pDisnFoHEs7VUL/Qt/JOSqKzJN8lQNBCqifHinKnIVoEF1rDziT4AKIk9aRf7u6Eup4YcJi15liyvUBTBals7qpD3D++0xmj0J3ag+iWX3hkq7blHLIwIVDibjygOhk1Mj0eNv1cVEg4vVlxUcHq21uJiAZ3a1Kllz1q0JZFhp9jbvNFcVqb5i/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8swEmzvZkdiLWw041N04wBQnkuEwuI+ZS4AYjcNLgMY=;
 b=mMkI04bgZwXuCX0mhFibSJwjKY22u3rEx6IMAHBdovxSRsjbTrAE6/BXVXNsFMVNxM0ZBxptxfUljQvkyuEojXav8RZO+pqczS/WBtqyTrzCEVyAHNLPIScuLR4sjbdl/SpFns4k5dh4EqMWqCH1HACDAQw/lVQfHDP5TsqemEmL1QHP3NFLQ5Ima6v9zKrTcwEhM6F8pVtr9YbQAQgegG0Po8P87zKdECEsxDBIsfoXRX+W5KvjKVbtYtG8ELHcxD6cpDVbqWieJaA6RPFWOQeCl7oC9n7Gt2mh9hxLX47EyxzWRveuiLBWQquVzgRSsTwBBvDzaHr7sWnP3w4MIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8swEmzvZkdiLWw041N04wBQnkuEwuI+ZS4AYjcNLgMY=;
 b=qLH63sP4gFBHbqM8yv05kgeoLA9jKh/8i3ADS4e0q6f3IPGYlovUlhf9Pqh2yQ8ITQF8SW9x6mVyIukNuUzSPMYkceGECHG9cyfFsCgbGHoaksIpkR6i8y0p0fAqUThbi50itv8tfav2u0ku7d1ADC5YhgfJgwgsogdwIqIbkCI=
Received: from PH0PR07CA0083.namprd07.prod.outlook.com (2603:10b6:510:f::28)
 by BY5PR12MB4322.namprd12.prod.outlook.com (2603:10b6:a03:20a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Mon, 15 Apr
 2024 21:25:16 +0000
Received: from SA2PEPF000015CB.namprd03.prod.outlook.com
 (2603:10b6:510:f:cafe::c8) by PH0PR07CA0083.outlook.office365.com
 (2603:10b6:510:f::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.32 via Frontend
 Transport; Mon, 15 Apr 2024 21:25:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015CB.mail.protection.outlook.com (10.167.241.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Mon, 15 Apr 2024 21:25:15 +0000
Received: from sonny-B650.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 15 Apr
 2024 16:25:15 -0500
From: Sonny Jiang <sonny.jiang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Sonny Jiang <sonjiang@amd.com>, Sonny Jiang <sonny.jiang@amd.com>
Subject: [PATCH 1/2] drm/amdgpu: IB size alignment on VCN5
Date: Mon, 15 Apr 2024 17:24:59 -0400
Message-ID: <20240415212500.1097164-1-sonny.jiang@amd.com>
X-Mailer: git-send-email 2.43.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CB:EE_|BY5PR12MB4322:EE_
X-MS-Office365-Filtering-Correlation-Id: b1ec5844-c9a0-4a65-4560-08dc5d928b0a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uMVN9t6PQZBc+II23itQv6lS+thqi6/pSNtoEl84iB6I0G8L45uh+813D7kxRjnKrid+CydTqgJ+wZwnORGqN6In3NnTWvXke0p4TFKdMk+iLXJ8jAuyRM2GfEBecFRnG4ua6HS2KqEMAiUgVObjItRgbpUzqjXowGQ8QNo5Uo1zwwZUrMrM16MIgjGDQ0emJyEcvT9nFFdZbtC3cK1pzV3n/4Afx4gjwzSCVnDQSOZxhd6KZvdR1wIKpU7PRVwbJxmTB3yn6/+m9z1KUaXFazvZBPzHhRKLwG+ml2UWprmb7/4MKtqEO8hoKmjz3Jy8ZVOrzoH03NiJyjaHlA1J306VUoQcO5vdFOp5bY3SvSOmrCC42e/8u8m3bagy+zjujaqNi29Ay2xAghcCBGU6JiaAKfQ3JRPxYqfxZdYEDq67UDCNnBY7FD3DOLQ1c2cwt1XvfHyKd4wKeEMN4wB1ZMJjwIZawXgu1zoYzu4DBDWLVnXJMBARBH/+G1yiAchj61mEj0ouatLKZIeRNajCBLCvudJBvrI8nj8eugOFiSW3Ai0F6e96uqCHCR6imYslTZs9cwakhwKrFETSIkbaF0o7bxFAVCns8gxI09jYsj3QcblZtyLCJ/zzCb4o2ATPk/BDfG4DH3SIuobxyiqpUW6zc6eXE0N2Ht0WCXmdA3zAhxMcMGI3tORR5spunRYGRixj052dZiE2QK2GsPkUJmIshLDJJZxh37ozGjVD2MeEoXTpCOyY3vGnkuqclfex
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(82310400014)(36860700004)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2024 21:25:15.8457 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b1ec5844-c9a0-4a65-4560-08dc5d928b0a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015CB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4322
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

From: Sonny Jiang <sonjiang@amd.com>

VCN5 IB size alignment adjusted.

Signed-off-by: Sonny Jiang <sonny.jiang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index 5d1b084eb631..94ae14e0989c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -509,7 +509,7 @@ static int amdgpu_hw_ip_info(struct amdgpu_device *adev,
 					++num_rings;
 		}
 		ib_start_alignment = 256;
-		ib_size_alignment = 4;
+		ib_size_alignment = 64;
 		break;
 	case AMDGPU_HW_IP_VCN_JPEG:
 		type = (amdgpu_device_ip_get_ip_block(adev, AMD_IP_BLOCK_TYPE_JPEG)) ?
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index bb85772b1374..7d176046498f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -731,7 +731,7 @@ static int amdgpu_vcn_dec_sw_send_msg(struct amdgpu_ring *ring,
 	int i, r;
 
 	if (sq)
-		ib_size_dw += 8;
+		ib_size_dw += 16;
 
 	r = amdgpu_job_alloc_with_ib(ring->adev, NULL, NULL,
 				     ib_size_dw * 4, AMDGPU_IB_POOL_DIRECT,
@@ -861,7 +861,7 @@ static int amdgpu_vcn_enc_get_create_msg(struct amdgpu_ring *ring, uint32_t hand
 	int i, r;
 
 	if (sq)
-		ib_size_dw += 8;
+		ib_size_dw += 16;
 
 	r = amdgpu_job_alloc_with_ib(ring->adev, NULL, NULL,
 				     ib_size_dw * 4, AMDGPU_IB_POOL_DIRECT,
@@ -928,7 +928,7 @@ static int amdgpu_vcn_enc_get_destroy_msg(struct amdgpu_ring *ring, uint32_t han
 	int i, r;
 
 	if (sq)
-		ib_size_dw += 8;
+		ib_size_dw += 16;
 
 	r = amdgpu_job_alloc_with_ib(ring->adev, NULL, NULL,
 				     ib_size_dw * 4, AMDGPU_IB_POOL_DIRECT,
-- 
2.43.2

