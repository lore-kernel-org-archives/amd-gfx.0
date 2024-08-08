Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B758C3DA7F
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Aug 2024 01:43:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B95E510E629;
	Thu,  8 Aug 2024 01:43:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4I42Czwb";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2057.outbound.protection.outlook.com [40.107.237.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2093810E629
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Aug 2024 01:43:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZYMcmAoJWSLJ+gef4tzlf0VvmBLC9zxEHlRZ1tXDH4QhGzHwfY4yK6NlkX4Im4/vAlCvX4a1mFqvPJz1xhKC1NIE0YwhG9twNJcYpMLmaAzcDqyiyQt6i8EhQTWemZR5BeNJxOs6Cu2KZUao9NS0EttlvkUGuiu2tvJQ0IdHN7jL0kP5xgyDtAUQlGJpb1Gr7GbBms6j2fdXVZzn13H7E10kSAQvPr76uMkrRTG6cLfnmLL6x+bxw97+18YACrDRzfYY+NjyVKfpAugw5MHeulcqd/O7d4CsZO2OdZHEHgKirRNf26Ob1aEAQmUqDnMJfXWeWEqxgvEZqDHB7ge7iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A+w9dJfTEkPPvkwb7wi6g1ZVC3+D7GZa9+DTvIH0CGs=;
 b=sVXO2ZpROd2AEXT9gf8wIYEwJbcjoouNRa/qqPqgccZVOIk7h5zpSJLbgwygFufdKpS2PQdlBVRCzq5MPPGQhzLTVzF9ceneltY9K2dVRpe2JhNVWXZECA+G4WAlPOM2oXabXaofd8A3AcOL75koDIFKllOoV/fkJ19FK6RxEEIZr0sxu/vUrKupyV25U9sq/Mv5udLbLPUsz+2Ri0jMrD4HLXmTBllKGADkex8Xxz+dZCFFiEERHlOWchN8aFfGSuFOPnaldjoAMb/cKO7RMsdSS90cqQ0WBnHcUyTPQlN33X3d2QZVsWxAttZKmYEArEIkFmSKrhDX+qt6eQB3oQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A+w9dJfTEkPPvkwb7wi6g1ZVC3+D7GZa9+DTvIH0CGs=;
 b=4I42CzwbrJqX3YthV1aC9CF9r6wxenFmMOEwod/hkSzhh34x/N+hRU0Ux9GMN3ghOhH6CQ1/4k84PApg6yDuw1XR/j3HddPwKZ6w3kNAwZAoTM2Jd0wwvLiYGfYEUlEnE46pMUMtjpFCkeQIjl2FOQLPvlzRs3o3IUrFoC7/Zr0=
Received: from SJ0PR03CA0165.namprd03.prod.outlook.com (2603:10b6:a03:338::20)
 by PH8PR12MB6914.namprd12.prod.outlook.com (2603:10b6:510:1cb::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.25; Thu, 8 Aug
 2024 01:43:31 +0000
Received: from SJ1PEPF0000231F.namprd03.prod.outlook.com
 (2603:10b6:a03:338:cafe::ae) by SJ0PR03CA0165.outlook.office365.com
 (2603:10b6:a03:338::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.29 via Frontend
 Transport; Thu, 8 Aug 2024 01:43:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF0000231F.mail.protection.outlook.com (10.167.242.235) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7828.19 via Frontend Transport; Thu, 8 Aug 2024 01:43:30 +0000
Received: from KfdLnx23.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 7 Aug
 2024 20:43:24 -0500
From: Ramesh Errabolu <Ramesh.Errabolu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Ramesh Errabolu <Ramesh.Errabolu@amd.com>
Subject: [PATCH] drm/amdgpu: Apply IH Ptr mask after updating IH Read Ptr
Date: Wed, 7 Aug 2024 20:42:34 -0500
Message-ID: <20240808014234.1165123-1-Ramesh.Errabolu@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231F:EE_|PH8PR12MB6914:EE_
X-MS-Office365-Filtering-Correlation-Id: 2545386e-5ac0-435c-275f-08dcb74b81fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?tYaGhtwMFZewUoY2WZmzQaN77Wsb5mvCE043GCQTE8CuBhEsBLDbavsjmTho?=
 =?us-ascii?Q?L5wgVZ687ZebuFZOwugykT71BFqQctqSDanTeS2AAnPMw3DPR6OzsZUJCul9?=
 =?us-ascii?Q?LPh4LV4lZF0SiIIu8irA+eqYOCeovwe3v13HdwvWU7fah4q1GEqt12rf6u1v?=
 =?us-ascii?Q?GFqByPhKfURJy0QVktrbuEwb7JT5dZGgHXg6dpeA0ciLTKyPpf5AALACO8ym?=
 =?us-ascii?Q?Kzc5yBKkcdBVvAQ8SsPhsf7XnQngEX03D/G78BpP3eISmN3RN+7z/JMuEMqu?=
 =?us-ascii?Q?u5VrLbZm4D9HmHMbJLZr8zs5l7WFRsrFjIpteXCFfUP455fLO9rAkzE4RosP?=
 =?us-ascii?Q?VVCgwAaZLA91jRBC0JEvhjIgLeSCRVwpVhA1iXAzVeD32gxRapoStIyoQGu5?=
 =?us-ascii?Q?XosR7fWxLmsO4wmSGbkqYZmww1DE1JKq7blrN3jzlOhY2b9rYhV0Lo+P0fv0?=
 =?us-ascii?Q?XFCJe6SyLcet4zif5vQL5TrpzeFvMnqDp/CKYZf9Tjn2oCNNu4K9BUlW4yM4?=
 =?us-ascii?Q?4Gtaki+8GoYwsCKmSen93jdgimfrX7EhvATi2gjBsK5qppIzghYBrFMjYyY+?=
 =?us-ascii?Q?YOKDgOCVrQzSd/UxyB+Iu356W5pDmpD34RoLqqTCJwjtNH4qXrld2AvQfZiD?=
 =?us-ascii?Q?pHrLVrAHT0DivthGRodegilrn2FJL/Dlf3OMgQUu7LHIMd7L4y3WrUES0dzZ?=
 =?us-ascii?Q?ibjMwimFPFpmlnJpg5b5CFKX1O1kNUco35natjogd/7kVwiMT7HViBgJ/aQD?=
 =?us-ascii?Q?/iIn+0r5+1Rn6jCEI41K21xSDKE+48YkEhV5mKdSPN3A2MqKy1m9vXz1HRo4?=
 =?us-ascii?Q?l46Fe0Inp4+Yhd/C9a0bnCSTAutXoxQ0uzkD4Es2NZ8uXMwvJLNGaCZKvDiQ?=
 =?us-ascii?Q?CWBNExhyPJxVPfjlHlk+x+hywuZCpubagoK7625FWVpVeColJBmffbL6/Kzu?=
 =?us-ascii?Q?3wnVjJrUO913DoNOeqwwy4BTfrMuLC+HuPuoKJ4B0doWdJ/a7d8cMfS+OAJq?=
 =?us-ascii?Q?2Rx+a4gSfs5oPVhBkleBzmv4awyjkwdTklYbBpIF+g+FvtkqKpoLnUHFVK5o?=
 =?us-ascii?Q?a3U4R/0QEOWFH5hEw+acZbPSNC7ZrDLrOjt+bm6jpqtRzVYgUwMrlVd6ODis?=
 =?us-ascii?Q?fgRmlEXdmaQD7O8CisBSBNla5Qw/wNwGAA8/OX1nt/akkydUzUVW5v0/Isjx?=
 =?us-ascii?Q?uW+Jh2Sw8ha9ZtHBFgU8YvZnq6cOLHMOqyrf2oVpKyd+AtxxfkkLEXjXKHwi?=
 =?us-ascii?Q?e70skZyNhtxQ2jsD12smX25cKbZqpYrq1qSpwLnW8hv+Ojut1QvONTNJS5vL?=
 =?us-ascii?Q?0VRx4E8JUAPsXOmuHd7yAb6j7ocvaIT/XriTMwr/0c0QJybfPaAbSu2KLAFT?=
 =?us-ascii?Q?bumxzxZ1n7l0sqMgqqnJUl3rnUCo4EKPwks0thLAEG3xSgrrnuuXI3w7U0tA?=
 =?us-ascii?Q?+Z66vaVDkhEP5+fWTBrJL430OwgSi+3v?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2024 01:43:30.9421 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2545386e-5ac0-435c-275f-08dcb74b81fc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF0000231F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6914
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

Apply IH Ptr mask immediately after updating to IH Read ptr.
Ideally the operation to update and mask should be atomic. This
will ensure that Read Ptr points to a valid index in the IH
ring buffer.

Signed-off-by: Ramesh Errabolu <Ramesh.Errabolu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c  | 5 ++++-
 drivers/gpu/drm/amd/amdgpu/cik_ih.c     | 5 ++++-
 drivers/gpu/drm/amd/amdgpu/cz_ih.c      | 5 ++++-
 drivers/gpu/drm/amd/amdgpu/iceland_ih.c | 5 ++++-
 drivers/gpu/drm/amd/amdgpu/si_ih.c      | 4 ++++
 drivers/gpu/drm/amd/amdgpu/tonga_ih.c   | 5 ++++-
 6 files changed, 24 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c
index f3b0aaf3ebc6..2fd13d424213 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c
@@ -280,8 +280,11 @@ void amdgpu_ih_decode_iv_helper(struct amdgpu_device *adev,
 	entry->src_data[2] = dw[6];
 	entry->src_data[3] = dw[7];
 
-	/* wptr/rptr are in bytes! */
+	/* Apply IH Ptr mask after adding sizeof(Intrpt)
+	 * bytes to IH Read ptr
+	 */
 	ih->rptr += 32;
+	ih->rptr &= ih->ptr_mask;
 }
 
 uint64_t amdgpu_ih_decode_iv_ts_helper(struct amdgpu_ih_ring *ih, u32 rptr,
diff --git a/drivers/gpu/drm/amd/amdgpu/cik_ih.c b/drivers/gpu/drm/amd/amdgpu/cik_ih.c
index 576baa9dbb0e..41c0c56d41f6 100644
--- a/drivers/gpu/drm/amd/amdgpu/cik_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/cik_ih.c
@@ -265,8 +265,11 @@ static void cik_ih_decode_iv(struct amdgpu_device *adev,
 	entry->vmid = (dw[2] >> 8) & 0xff;
 	entry->pasid = (dw[2] >> 16) & 0xffff;
 
-	/* wptr/rptr are in bytes! */
+	/* Apply IH Ptr mask after adding sizeof(Intrpt)
+	 * bytes to IH Read ptr
+	 */
 	ih->rptr += 16;
+	ih->rptr &= ih->ptr_mask;
 }
 
 /**
diff --git a/drivers/gpu/drm/amd/amdgpu/cz_ih.c b/drivers/gpu/drm/amd/amdgpu/cz_ih.c
index 072643787384..a94ddecc3d33 100644
--- a/drivers/gpu/drm/amd/amdgpu/cz_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/cz_ih.c
@@ -256,8 +256,11 @@ static void cz_ih_decode_iv(struct amdgpu_device *adev,
 	entry->vmid = (dw[2] >> 8) & 0xff;
 	entry->pasid = (dw[2] >> 16) & 0xffff;
 
-	/* wptr/rptr are in bytes! */
+	/* Apply IH Ptr mask after adding sizeof(Intrpt)
+	 * bytes to IH Read ptr
+	 */
 	ih->rptr += 16;
+	ih->rptr &= ih->ptr_mask;
 }
 
 /**
diff --git a/drivers/gpu/drm/amd/amdgpu/iceland_ih.c b/drivers/gpu/drm/amd/amdgpu/iceland_ih.c
index 07984f7c3ae7..d47f008110ba 100644
--- a/drivers/gpu/drm/amd/amdgpu/iceland_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/iceland_ih.c
@@ -255,8 +255,11 @@ static void iceland_ih_decode_iv(struct amdgpu_device *adev,
 	entry->vmid = (dw[2] >> 8) & 0xff;
 	entry->pasid = (dw[2] >> 16) & 0xffff;
 
-	/* wptr/rptr are in bytes! */
+	/* Apply IH Ptr mask after adding sizeof(Intrpt)
+	 * bytes to IH Read ptr
+	 */
 	ih->rptr += 16;
+	ih->rptr &= ih->ptr_mask;
 }
 
 /**
diff --git a/drivers/gpu/drm/amd/amdgpu/si_ih.c b/drivers/gpu/drm/amd/amdgpu/si_ih.c
index 5237395e4fab..9e51024f1851 100644
--- a/drivers/gpu/drm/amd/amdgpu/si_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/si_ih.c
@@ -147,7 +147,11 @@ static void si_ih_decode_iv(struct amdgpu_device *adev,
 	entry->ring_id = dw[2] & 0xff;
 	entry->vmid = (dw[2] >> 8) & 0xff;
 
+	/* Apply IH Ptr mask after adding sizeof(Intrpt)
+	 * bytes to IH Read ptr
+	 */
 	ih->rptr += 16;
+	ih->rptr &= ih->ptr_mask;
 }
 
 static void si_ih_set_rptr(struct amdgpu_device *adev,
diff --git a/drivers/gpu/drm/amd/amdgpu/tonga_ih.c b/drivers/gpu/drm/amd/amdgpu/tonga_ih.c
index 24d49d813607..db3c7aeb9425 100644
--- a/drivers/gpu/drm/amd/amdgpu/tonga_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/tonga_ih.c
@@ -259,8 +259,11 @@ static void tonga_ih_decode_iv(struct amdgpu_device *adev,
 	entry->vmid = (dw[2] >> 8) & 0xff;
 	entry->pasid = (dw[2] >> 16) & 0xffff;
 
-	/* wptr/rptr are in bytes! */
+	/* Apply IH Ptr mask after adding sizeof(Intrpt)
+	 * bytes to IH Read ptr
+	 */
 	ih->rptr += 16;
+	ih->rptr &= ih->ptr_mask;
 }
 
 /**
-- 
2.34.1

