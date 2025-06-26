Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70862C77B7C
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Jun 2025 01:57:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DEFB010E255;
	Thu, 26 Jun 2025 01:57:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="P1YzVLqu";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2082.outbound.protection.outlook.com [40.107.236.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6B33410E255
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Jun 2025 01:57:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qf5J1awkXJDzNpRfEhc39w7gl8BQAG2zVe63guC+vc9qrhY34mG+FckKf6RDKdNCcNLkhDNRBvB4u2VxM5sM1UIXiGJ40nWxuY/xi6fO6/AhfvgYKfVbPC9zHFUwWa0s7Jk5pPHe2MfFKz+Mm3gcili5MUga136HjBC+2gVzJGjEvPbCXNYE9P1L1FdpjRAvJGafeeP4liHZxrMK1dwRliLA/gF+pIBy33QORX5rENtE4qQdFLrclZCvvsOW29gGZuE6Kkcik9XR39ZODYRvd6vMlpDEHxH0crTm0CefVatkbLRm5+glUrr+d9MVg9cNwM6hep1jVJashIEtOUCiyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DYY0S3FyRYKZI2xu+XE4wCmFnYdZbj9WwqEyPzkyCg8=;
 b=T8Lfb+tr+hOI3M8Bx6y7DxxcJYtOO7ROSAWOCWWwbHGrOyb8tpyezjzot+e0zwo9zqVVzVdexoFp4M0O8v59w03jVd6wXXpAVg69ecAGgX9/PT5+aVj/+YbUev2wkaDWalhxLAXhxY/zd1yhg7DzQikLYRLxqM0F8Gu1HVl3HlsJ5mxyNqCKLxYuSSB4RiOacWOw8MW0CsbvRZq62LmpD4NZnBryoShYASpAgRyL3d5EgkPsp4byLUSXxHWmmZrbvQxOMaBA9/t1FUU8WnACj+HaWCBNxTkPvQjLKEj+PPcVXA7zKqShusHkC4aRStzGiRCh7PjE+gLI2pXPoxOoQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DYY0S3FyRYKZI2xu+XE4wCmFnYdZbj9WwqEyPzkyCg8=;
 b=P1YzVLqubOFZd4cdfT4cgSCIvoGuTLpq4zYXZfb9/cmSsE8/Bp/FF0WZdqviVjavCbvn1mXmtiAyBZpsoI/JPzyNtAfiSaYlbpqb47XmbbFhTGCApgScL9M6vUkfuo1Bcz9vmCYozVACCWE3iDCATrRxSWqt0CYnKccObl8NZg4=
Received: from BLAPR03CA0046.namprd03.prod.outlook.com (2603:10b6:208:32d::21)
 by BN7PPF8FCE094C0.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::6d8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.34; Thu, 26 Jun
 2025 01:57:28 +0000
Received: from BN3PEPF0000B070.namprd21.prod.outlook.com
 (2603:10b6:208:32d:cafe::2d) by BLAPR03CA0046.outlook.office365.com
 (2603:10b6:208:32d::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.19 via Frontend Transport; Thu,
 26 Jun 2025 01:57:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B070.mail.protection.outlook.com (10.167.243.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8901.1 via Frontend Transport; Thu, 26 Jun 2025 01:57:28 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 25 Jun
 2025 20:57:23 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 25 Jun
 2025 20:57:22 -0500
Received: from jessevm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 25 Jun 2025 20:57:10 -0500
From: Jesse Zhang <jesse.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse Zhang <jesse.zhang@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
 Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH V3] drm/amdgpu: Add user queue instance count in HW IP info
Date: Thu, 26 Jun 2025 09:57:09 +0800
Message-ID: <20250626015709.251938-1-jesse.zhang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B070:EE_|BN7PPF8FCE094C0:EE_
X-MS-Office365-Filtering-Correlation-Id: 622899a4-d8db-4f9a-c3be-08ddb454cdde
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?HwNWGxpy/bPW+Ui68RPGzJA2C1p0JJNz04S2pJU050tQdW0Ph8W1GXmbIKsF?=
 =?us-ascii?Q?AfmAn21kVjh3TBpP/6+wFQknWby8af6zXt1iuUfLycZS5x4Wuwx5tReUh3k0?=
 =?us-ascii?Q?BlJV4iLhtEyK2mtUdyun8Z9erfPko6OKZFT0DHN+ED6+NrGQYs0qCwuPNs3a?=
 =?us-ascii?Q?tMeyn6Kdwy7LHIO5xdad+PlKlsco/2yTWUrMIcep13ehoqRFeSgDA+D9cwXJ?=
 =?us-ascii?Q?37oxR6+uKxn2Zci33z846KGQCtkAlTFdYCr/GJNlvzloHTLv6isB/2OANqhe?=
 =?us-ascii?Q?JtWs5T4Q9xDCsvcRVbjktpKbpiawfayH1jeBpa40BxAgBI/8LqSoq9V9yWrf?=
 =?us-ascii?Q?SqzNzr8qPpfEtk9uOIgvj3j2UYq1DhtFNU9EXJwT08QoPq3RLZ+XJ37revS9?=
 =?us-ascii?Q?/25emZYQZGzlEdhxSBOWmzTUs89erMRuG5iNZnZ+0a/34o8NS+yfFMPJ494Z?=
 =?us-ascii?Q?DdxgBdHE030rLP5DLsDtKol4Sah4f8cDawioOIgUZVeHidGIbTPYcIXRdrn7?=
 =?us-ascii?Q?AcjL5awcvPUONQB27R6kPkJaYwpiBRcZBQEwwlMq4niZ2sb7mEvkF1VykLdD?=
 =?us-ascii?Q?f9VrrtYkQEfn4e2Gdubu+NKGOuZxZU3Dsfjynfinq6xHnHIwn2tQZkiIZKAP?=
 =?us-ascii?Q?4rizaOEPipBfIUIUksvlms4dxpU4bMZHVwhVcac5NSZkSwdkGWpLemMfp/M1?=
 =?us-ascii?Q?p7LE5hr/6nsdt8jTBCHXBnCHNAhvi5GMU592vyp5xCjbIyH8LsrUOvzdEEtZ?=
 =?us-ascii?Q?mGnTfTK+XluS6/RMl6D3u4qoV30IMP1lNZwuggdCoLtpsZTXlNuqG/LGUqCU?=
 =?us-ascii?Q?RyyfnwviLa6OVvQRmk6jUAf8Ce5cAgzpsIvH48ot2C/PqItJCkX/9tYsqTch?=
 =?us-ascii?Q?A3wzEPvzEPwunCC5j5jDcyiLof6mFxektr6kfbrT6IBN3oTfzzWjMrk5bnUi?=
 =?us-ascii?Q?D+KJZbbd5tjNj3dYD8cQ5tTAytBD+lW+onfBCfxCDA41dIjaG5XCuXvJtVmA?=
 =?us-ascii?Q?OIoJkeynrgKQVoFM7wdjex1E2i3sZqGbenALcZ+pvdkdyxsoC5LcivJgB2Ct?=
 =?us-ascii?Q?6cNBJ5LF4gPjcuB294wh4prRrkj0n+a+0VBD72PyFRXPBiCjE9FatdL7Duy2?=
 =?us-ascii?Q?0pLNXQ2/R3n3ZUzuAxPdn43QdFUNyo1skRo1FwrSACRJ6VkMXqiFWeJiRx2y?=
 =?us-ascii?Q?hqx5ZHIwbRlhqwW3ckjX0vhqUQl8Hlgi6fuvfYMjUal9Qzpsxy53bXo8P090?=
 =?us-ascii?Q?9gqRJYqTpbpmHNeRyDHSFNEnLdMF9HGgUUMAHG4dop+zWvP+IRm260AIoR8b?=
 =?us-ascii?Q?4PZJ4gpZl+KeNbr1luGLhTLUB7lAiyvPSj+Hi17wKjz8BJeiuNeED7AQVQP2?=
 =?us-ascii?Q?eCgVYSAsUmjjGCLPFfr3c9VAhAfAilYVXjios9BIxdcHZXgNsdpk14nlvSUv?=
 =?us-ascii?Q?Bw4W9oMQiTzWyJxNod/sh3vVM+HTHsnCGX8MFMKYfZxObTJT+hQW8+5tqmag?=
 =?us-ascii?Q?JV2IfBb+67aKfOpnwZmx9W//gzY25ItQnFBp?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2025 01:57:28.0230 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 622899a4-d8db-4f9a-c3be-08ddb454cdde
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B070.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF8FCE094C0
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

This change exposes the number of available user queue instances
for each hardware IP type (GFX, COMPUTE, SDMA) through the
drm_amdgpu_info_hw_ip interface.

Key changes:
1. Added userq_num_instance field to drm_amdgpu_info_hw_ip structure
2. Implemented counting of available HQD slots using:
   - mes.gfx_hqd_mask for GFX queues
   - mes.compute_hqd_mask for COMPUTE queues
   - mes.sdma_hqd_mask for SDMA queues
3. Only counts available instances when user queues are enabled
   (!disable_uq)

V2: using the adev->mes.gfx_hqd_mask[]/compute_hqd_mask[]/sdma_hqd_mask[] masks
  to determine the number of queue slots available for each engine type (Alex)

V3: rename userq_num_instance to userq_num_hqds (Alex)

Suggested-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 17 +++++++++++++++++
 include/uapi/drm/amdgpu_drm.h           |  2 ++
 2 files changed, 19 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index 195ed81d39ff..31ba4efabb9d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -399,6 +399,7 @@ static int amdgpu_hw_ip_info(struct amdgpu_device *adev,
 	uint32_t ib_size_alignment = 0;
 	enum amd_ip_block_type type;
 	unsigned int num_rings = 0;
+	uint32_t num_hqds = 0;
 	unsigned int i, j;
 
 	if (info->query_hw_ip.ip_instance >= AMDGPU_HW_IP_INSTANCE_MAX_COUNT)
@@ -411,6 +412,11 @@ static int amdgpu_hw_ip_info(struct amdgpu_device *adev,
 			if (adev->gfx.gfx_ring[i].sched.ready &&
 			    !adev->gfx.gfx_ring[i].no_user_submission)
 				++num_rings;
+
+		if (!adev->gfx.disable_uq)
+			for (i = 0; i < AMDGPU_MES_MAX_GFX_PIPES; i++)
+				num_hqds += hweight32(adev->mes.gfx_hqd_mask[i]);
+
 		ib_start_alignment = 32;
 		ib_size_alignment = 32;
 		break;
@@ -420,6 +426,11 @@ static int amdgpu_hw_ip_info(struct amdgpu_device *adev,
 			if (adev->gfx.compute_ring[i].sched.ready &&
 			    !adev->gfx.compute_ring[i].no_user_submission)
 				++num_rings;
+
+		if (!adev->sdma.disable_uq)
+			for (i = 0; i < AMDGPU_MES_MAX_COMPUTE_PIPES; i++)
+				num_hqds += hweight32(adev->mes.compute_hqd_mask[i]);
+
 		ib_start_alignment = 32;
 		ib_size_alignment = 32;
 		break;
@@ -429,6 +440,11 @@ static int amdgpu_hw_ip_info(struct amdgpu_device *adev,
 			if (adev->sdma.instance[i].ring.sched.ready &&
 			    !adev->sdma.instance[i].ring.no_user_submission)
 				++num_rings;
+
+		if (!adev->gfx.disable_uq)
+			for (i = 0; i < AMDGPU_MES_MAX_SDMA_PIPES; i++)
+				num_hqds += hweight32(adev->mes.sdma_hqd_mask[i]);
+
 		ib_start_alignment = 256;
 		ib_size_alignment = 4;
 		break;
@@ -570,6 +586,7 @@ static int amdgpu_hw_ip_info(struct amdgpu_device *adev,
 	}
 	result->capabilities_flags = 0;
 	result->available_rings = (1 << num_rings) - 1;
+	result->userq_num_hqds = num_hqds;
 	result->ib_start_alignment = ib_start_alignment;
 	result->ib_size_alignment = ib_size_alignment;
 	return 0;
diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index 45c4fa13499c..66c4a03ac9f9 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -1493,6 +1493,8 @@ struct drm_amdgpu_info_hw_ip {
 	__u32  available_rings;
 	/** version info: bits 23:16 major, 15:8 minor, 7:0 revision */
 	__u32  ip_discovery_version;
+	/* Userq available hqds */
+	__u32  userq_num_hqds;
 };
 
 /* GFX metadata BO sizes and alignment info (in bytes) */
-- 
2.34.1

