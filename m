Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B63C0D3748A
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Oct 2024 13:22:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6316310E846;
	Thu, 17 Oct 2024 13:22:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zsUGmNdC";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2046.outbound.protection.outlook.com [40.107.94.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 443D310E822
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Oct 2024 13:21:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PEzqAziLIng8HWc0+NFDhuPck9Fne0sWFjSdNEad1T8tvhY3ibPcKeONWova+3mnHPf+yQFuM9sp6LRygn5YBO1ksRgSFnGtGgRrnNJW8idgCkIDIMgtX+8BYet056unJvSzbucvlvCLCx1SFgddVKOX2Re3woHRJJM6dodTewaiCaP5xNcNKZl24rCa223Aiey0sc322oTtDChZupRrbrfWb4+mzT6Pcyh+6QSyhw0jA3B1w5JaNQp2+wArknxDoBJFVHhszgj0mlNaKCOkW9YoboX/RJ7E71Bq7a6jV4Ie8ksSB1MZxDYHzSWjtNkb7I9PtqjEe3irhYBOlQJQZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=izqkUufLIi74p3WqS33aANqkMymzTCI8frfFdlBcqmM=;
 b=p4YqK6sCKiM8L7uzAQf4DDQZG8NmkK5cUqUxuRGtzzKXT5o0zZRn4BAgT6AuGOyg2Hx/e9PHBvaqEmorkfs60fOa4phDxKlGS8Kd+PJPrtL+ts13Rr6O7yNOXUH+XDd8OE0lm8tzG9N74o04N7UJPVdJaXH06T+0tQfuGcFjmQcXb1O8jnjpoEndg5YcbzP986bsTnoobUpuT/F0KEvykC1GFmzA5qrFq09ashGb9fW26TxTWEZ9I568LlIjIMthFs3dZ+2XaDrmVHAeHXmVRmpRfpwxvpZtxkrA3njF1lpak2hDv1/MSV/QBDgoMNW6IlSYKRPInni3nsveoPiqlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=izqkUufLIi74p3WqS33aANqkMymzTCI8frfFdlBcqmM=;
 b=zsUGmNdChNz6/rMlsC+IXsEPvmGLR4QaNE2hx6QWmDhD/05nogK/PlbKA7kcGOtNVwqZC2ayR3Vq1wkUN5DzuMHSJf1Il8nBqHrHA77FY3az7J4GirXK9gzyvekm3cALe54eUteqbJj2Ny81cDeuvuw0QhW1a1W77h+kxZF/bO8=
Received: from BN9PR03CA0262.namprd03.prod.outlook.com (2603:10b6:408:ff::27)
 by IA1PR12MB6115.namprd12.prod.outlook.com (2603:10b6:208:3e9::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Thu, 17 Oct
 2024 13:21:31 +0000
Received: from BN2PEPF000044AA.namprd04.prod.outlook.com
 (2603:10b6:408:ff:cafe::e0) by BN9PR03CA0262.outlook.office365.com
 (2603:10b6:408:ff::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.19 via Frontend
 Transport; Thu, 17 Oct 2024 13:21:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044AA.mail.protection.outlook.com (10.167.243.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8069.17 via Frontend Transport; Thu, 17 Oct 2024 13:21:31 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 17 Oct
 2024 08:21:30 -0500
From: <boyuan.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <leo.liu@amd.com>,
 <christian.koenig@amd.com>, <alexander.deucher@amd.com>
CC: Boyuan Zhang <boyuan.zhang@amd.com>
Subject: [PATCH 24/32] drm/amdgpu: suspend for each vcn instance
Date: Thu, 17 Oct 2024 09:20:45 -0400
Message-ID: <20241017132053.53214-25-boyuan.zhang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241017132053.53214-1-boyuan.zhang@amd.com>
References: <20241017132053.53214-1-boyuan.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044AA:EE_|IA1PR12MB6115:EE_
X-MS-Office365-Filtering-Correlation-Id: ae7bc33c-5224-4198-edaa-08dceeae9d91
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?b93UJDQ33/XfpD4lh8pxzDTcnXdou50K1DgRvG8dUDVLS4tuIzXEtvSiwxqS?=
 =?us-ascii?Q?CaZoSG7VGhYtC+04H0mebFQmBpR3ZThuu9kRDDQAirNzxCJX7ixEscNcIRK5?=
 =?us-ascii?Q?h8fw28awwhRNa+6MUvqVQosc0Jsu/tI1xeIM10AaqVYEb9Om9N5UTVT4lmBZ?=
 =?us-ascii?Q?VMc3NNYUodBmP/XBVqiiiJ/UKWeiddHr+EomqmQuoKpL0rdLawvwKrXBsnqL?=
 =?us-ascii?Q?n57+XB+YXQ4lMCv7y/UAB7Ab3c8npEIegf6qUFNy7ZCxyJ/1jtZ54rlJKTrv?=
 =?us-ascii?Q?InXpoe0RYooEJ+lRGpmOgq02+vAMP2ilghXrgPLjQfrEjg4mvzFbmq3i0PJ6?=
 =?us-ascii?Q?Of7vXftUVN30wI42jw7fT5yDpjQp5OIFQqveRD5q6hv9WUh/KpV3BDB6234U?=
 =?us-ascii?Q?T5lGEr/CyjajwlR1qBHF0hALSv4TbZhVjz0/1J3KhyQbYmRoGozT2VRKJw6J?=
 =?us-ascii?Q?D+Alb3Yrn+6nch5b3Lld+xvA/gGaxJ3jStrRmpWwR6UMK8uHlQVSpTQTxpEl?=
 =?us-ascii?Q?7cgJ49Km40pCGFfVPFcX2KTNJDVvUfeTE4uaKxL/usIZLx6y56VwykDlFrPY?=
 =?us-ascii?Q?4qH40OppuLNyocrQWcwvHtpYa5MKvfwvZa8BTuuUQ5F94ZFWnCF2KmOM+HJ/?=
 =?us-ascii?Q?yj4MHg+iMo/a4gwrdsW5l7swt/3wqA0rq7UYyb4uF24kFarGyLNJa67viByX?=
 =?us-ascii?Q?zxVPNxxe09Uces2JxGccEBEttA/kqSabIPJ1olLIjJAtsR2W8olFmlaYktV4?=
 =?us-ascii?Q?GHtMyY2KORNVEyOIjzEBE7xYU2BVxGJMHDT3HXvQyfaoXNMdwXAxJyEUHi3+?=
 =?us-ascii?Q?hH4yNGkpZdhFlExl4cWQrDnBVXmObB4XnOgdTR9XInfmJtsa2QE7eu2ZxOdp?=
 =?us-ascii?Q?N3M0vx3lwDnhkhcaPYUy8WuGb5nbtUxOF8qWPsKvI+665i/eFuPy0pnd2AGH?=
 =?us-ascii?Q?cA4yITJl6DlM88j5NlIAH2T+W2vLVDKwmxEwClYfgusE9bG0Qlrw0AUPg0Vo?=
 =?us-ascii?Q?zbMZjef7WDfPJ2Gw7w+iyfwftGi98bUpywxLqr6dgewtUghoeU8Sa4R5g56N?=
 =?us-ascii?Q?D2eSLnkY/974eJnfwIjUBQ1ugkNmveH3u/0pOnr1thD5N+tN2TYDKoAkKSia?=
 =?us-ascii?Q?Ln8zCMJZxmGIhN5O8cLc6JwKxX1EFcYGx1qmxkVKo8w77w/CBLqjGJUX8VZ0?=
 =?us-ascii?Q?VXkOO+ZQN7JPiEa6SsGHD/xRfbORTLAXszo+p0MHT517dKZOokIfahyFgpgi?=
 =?us-ascii?Q?e7W8TH8/XfwNThYG+j1dBhRNyqUNsXuQkacWnDGCX5LCO8kbl0UepIJGGraX?=
 =?us-ascii?Q?2mTlS3Tj9o6jMgjUmZFJm8K63mt3MD3vPDSCaOdSEXuLmKNtTqJK7OttDenP?=
 =?us-ascii?Q?IjsruFIKJa/dPxquNOi6YRgcxh4NzMt636RsbdZkT4qS6jARfQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 13:21:31.4449 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ae7bc33c-5224-4198-edaa-08dceeae9d91
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044AA.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6115
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

From: Boyuan Zhang <boyuan.zhang@amd.com>

Pass instance parameter to amdgpu_vcn_suspend(), and perform
suspend ONLY for the given vcn instance, instead of for all
vcn instances. Modify each vcn generation accordingly.

Signed-off-by: Boyuan Zhang <boyuan.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 35 ++++++++++++-------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h |  2 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c   |  7 ++---
 drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c   |  6 +++--
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c   |  6 +++--
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c   |  6 +++--
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c   |  6 +++--
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c |  6 +++--
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c |  6 +++--
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c |  6 +++--
 10 files changed, 50 insertions(+), 36 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index 307615ffeb79..968355228095 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -294,40 +294,39 @@ bool amdgpu_vcn_is_disabled_vcn(struct amdgpu_device *adev, enum vcn_ring_type t
 	return ret;
 }
 
-int amdgpu_vcn_suspend(struct amdgpu_device *adev)
+int amdgpu_vcn_suspend(struct amdgpu_device *adev, int inst)
 {
 	unsigned int size;
 	void *ptr;
-	int i, idx;
+	int idx;
 
 	bool in_ras_intr = amdgpu_ras_intr_triggered();
 
-	for (i = 0; i < adev->vcn.num_vcn_inst; ++i)
-		cancel_delayed_work_sync(&adev->vcn.inst[i].idle_work);
+	cancel_delayed_work_sync(&adev->vcn.inst[inst].idle_work);
 
 	/* err_event_athub will corrupt VCPU buffer, so we need to
 	 * restore fw data and clear buffer in amdgpu_vcn_resume() */
 	if (in_ras_intr)
 		return 0;
 
-	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
-		if (adev->vcn.harvest_config & (1 << i))
-			continue;
-		if (adev->vcn.inst[i].vcpu_bo == NULL)
-			return 0;
+	if (adev->vcn.harvest_config & (1 << inst))
+		return 0;
 
-		size = amdgpu_bo_size(adev->vcn.inst[i].vcpu_bo);
-		ptr = adev->vcn.inst[i].cpu_addr;
+	if (adev->vcn.inst[inst].vcpu_bo == NULL)
+		return 0;
 
-		adev->vcn.inst[i].saved_bo = kvmalloc(size, GFP_KERNEL);
-		if (!adev->vcn.inst[i].saved_bo)
-			return -ENOMEM;
+	size = amdgpu_bo_size(adev->vcn.inst[inst].vcpu_bo);
+	ptr = adev->vcn.inst[inst].cpu_addr;
 
-		if (drm_dev_enter(adev_to_drm(adev), &idx)) {
-			memcpy_fromio(adev->vcn.inst[i].saved_bo, ptr, size);
-			drm_dev_exit(idx);
-		}
+	adev->vcn.inst[inst].saved_bo = kvmalloc(size, GFP_KERNEL);
+	if (!adev->vcn.inst[inst].saved_bo)
+		return -ENOMEM;
+
+	if (drm_dev_enter(adev_to_drm(adev), &idx)) {
+		memcpy_fromio(adev->vcn.inst[inst].saved_bo, ptr, size);
+		drm_dev_exit(idx);
 	}
+
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
index 883b9f9776a1..0695433a269c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
@@ -486,7 +486,7 @@ enum vcn_ring_type {
 int amdgpu_vcn_early_init(struct amdgpu_device *adev, int inst);
 int amdgpu_vcn_sw_init(struct amdgpu_device *adev, int inst);
 int amdgpu_vcn_sw_fini(struct amdgpu_device *adev, int inst);
-int amdgpu_vcn_suspend(struct amdgpu_device *adev);
+int amdgpu_vcn_suspend(struct amdgpu_device *adev, int inst);
 int amdgpu_vcn_resume(struct amdgpu_device *adev);
 void amdgpu_vcn_ring_begin_use(struct amdgpu_ring *ring);
 void amdgpu_vcn_ring_end_use(struct amdgpu_ring *ring);
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
index 8203f80be316..806ed6c550fb 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
@@ -226,7 +226,7 @@ static int vcn_v1_0_sw_fini(struct amdgpu_ip_block *ip_block)
 	int inst = ip_block->instance;
 	int r;
 
-	r = amdgpu_vcn_suspend(adev);
+	r = amdgpu_vcn_suspend(adev, inst);
 	if (r)
 		return r;
 
@@ -300,9 +300,10 @@ static int vcn_v1_0_hw_fini(struct amdgpu_ip_block *ip_block)
  */
 static int vcn_v1_0_suspend(struct amdgpu_ip_block *ip_block)
 {
-	int r;
 	struct amdgpu_device *adev = ip_block->adev;
+	int inst = ip_block->instance;
 	bool idle_work_unexecuted;
+	int r;
 
 	idle_work_unexecuted = cancel_delayed_work_sync(&adev->vcn.inst[0].idle_work);
 	if (idle_work_unexecuted) {
@@ -314,7 +315,7 @@ static int vcn_v1_0_suspend(struct amdgpu_ip_block *ip_block)
 	if (r)
 		return r;
 
-	r = amdgpu_vcn_suspend(adev);
+	r = amdgpu_vcn_suspend(adev, inst);
 
 	return r;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
index 0481a07054eb..397aec069862 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
@@ -257,7 +257,7 @@ static int vcn_v2_0_sw_fini(struct amdgpu_ip_block *ip_block)
 
 	amdgpu_virt_free_mm_table(adev);
 
-	r = amdgpu_vcn_suspend(adev);
+	r = amdgpu_vcn_suspend(adev, inst);
 	if (r)
 		return r;
 
@@ -335,13 +335,15 @@ static int vcn_v2_0_hw_fini(struct amdgpu_ip_block *ip_block)
  */
 static int vcn_v2_0_suspend(struct amdgpu_ip_block *ip_block)
 {
+	struct amdgpu_device *adev = ip_block->adev;
+	int inst = ip_block->instance;
 	int r;
 
 	r = vcn_v2_0_hw_fini(ip_block);
 	if (r)
 		return r;
 
-	r = amdgpu_vcn_suspend(ip_block->adev);
+	r = amdgpu_vcn_suspend(adev, inst);
 
 	return r;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
index f225a0b214d0..088a3521ac5a 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
@@ -316,7 +316,7 @@ static int vcn_v2_5_sw_fini(struct amdgpu_ip_block *ip_block)
 	if (amdgpu_sriov_vf(adev))
 		amdgpu_virt_free_mm_table(adev);
 
-	r = amdgpu_vcn_suspend(adev);
+	r = amdgpu_vcn_suspend(adev, inst);
 	if (r)
 		return r;
 
@@ -412,13 +412,15 @@ static int vcn_v2_5_hw_fini(struct amdgpu_ip_block *ip_block)
  */
 static int vcn_v2_5_suspend(struct amdgpu_ip_block *ip_block)
 {
+	struct amdgpu_device *adev = ip_block->adev;
+	int inst = ip_block->instance;
 	int r;
 
 	r = vcn_v2_5_hw_fini(ip_block);
 	if (r)
 		return r;
 
-	r = amdgpu_vcn_suspend(ip_block->adev);
+	r = amdgpu_vcn_suspend(adev, inst);
 
 	return r;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
index 2d1835d06ecb..bd8322cdbcfe 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
@@ -325,7 +325,7 @@ static int vcn_v3_0_sw_fini(struct amdgpu_ip_block *ip_block)
 	if (amdgpu_sriov_vf(adev))
 		amdgpu_virt_free_mm_table(adev);
 
-	r = amdgpu_vcn_suspend(adev);
+	r = amdgpu_vcn_suspend(adev, inst);
 	if (r)
 		return r;
 
@@ -444,13 +444,15 @@ static int vcn_v3_0_hw_fini(struct amdgpu_ip_block *ip_block)
  */
 static int vcn_v3_0_suspend(struct amdgpu_ip_block *ip_block)
 {
+	struct amdgpu_device *adev = ip_block->adev;
+	int inst = ip_block->instance;
 	int r;
 
 	r = vcn_v3_0_hw_fini(ip_block);
 	if (r)
 		return r;
 
-	r = amdgpu_vcn_suspend(ip_block->adev);
+	r = amdgpu_vcn_suspend(adev, inst);
 
 	return r;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
index afe2eba9aac4..c195742ee4f7 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
@@ -277,7 +277,7 @@ static int vcn_v4_0_sw_fini(struct amdgpu_ip_block *ip_block)
 	if (amdgpu_sriov_vf(adev))
 		amdgpu_virt_free_mm_table(adev);
 
-	r = amdgpu_vcn_suspend(adev);
+	r = amdgpu_vcn_suspend(adev, inst);
 	if (r)
 		return r;
 
@@ -372,13 +372,15 @@ static int vcn_v4_0_hw_fini(struct amdgpu_ip_block *ip_block)
  */
 static int vcn_v4_0_suspend(struct amdgpu_ip_block *ip_block)
 {
+	struct amdgpu_device *adev = ip_block->adev;
+	int inst = ip_block->instance;
 	int r;
 
 	r = vcn_v4_0_hw_fini(ip_block);
 	if (r)
 		return r;
 
-	r = amdgpu_vcn_suspend(ip_block->adev);
+	r = amdgpu_vcn_suspend(adev, inst);
 
 	return r;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
index 0dc26dc173cb..ed0f25f7ff5f 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
@@ -235,7 +235,7 @@ static int vcn_v4_0_3_sw_fini(struct amdgpu_ip_block *ip_block)
 	if (amdgpu_sriov_vf(adev))
 		amdgpu_virt_free_mm_table(adev);
 
-	r = amdgpu_vcn_suspend(adev);
+	r = amdgpu_vcn_suspend(adev, inst);
 	if (r)
 		return r;
 
@@ -331,13 +331,15 @@ static int vcn_v4_0_3_hw_fini(struct amdgpu_ip_block *ip_block)
  */
 static int vcn_v4_0_3_suspend(struct amdgpu_ip_block *ip_block)
 {
+	struct amdgpu_device *adev = ip_block->adev;
+	int inst = ip_block->instance;
 	int r;
 
 	r = vcn_v4_0_3_hw_fini(ip_block);
 	if (r)
 		return r;
 
-	r = amdgpu_vcn_suspend(ip_block->adev);
+	r = amdgpu_vcn_suspend(adev, inst);
 
 	return r;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
index 36e4477c99f3..75ea91749276 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
@@ -246,7 +246,7 @@ static int vcn_v4_0_5_sw_fini(struct amdgpu_ip_block *ip_block)
 	if (amdgpu_sriov_vf(adev))
 		amdgpu_virt_free_mm_table(adev);
 
-	r = amdgpu_vcn_suspend(adev);
+	r = amdgpu_vcn_suspend(adev, inst);
 	if (r)
 		return r;
 
@@ -323,13 +323,15 @@ static int vcn_v4_0_5_hw_fini(struct amdgpu_ip_block *ip_block)
  */
 static int vcn_v4_0_5_suspend(struct amdgpu_ip_block *ip_block)
 {
+	struct amdgpu_device *adev = ip_block->adev;
+	int inst = ip_block->instance;
 	int r;
 
 	r = vcn_v4_0_5_hw_fini(ip_block);
 	if (r)
 		return r;
 
-	r = amdgpu_vcn_suspend(ip_block->adev);
+	r = amdgpu_vcn_suspend(adev, inst);
 
 	return r;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
index 687d413a50b7..69aa555b7227 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
@@ -210,7 +210,7 @@ static int vcn_v5_0_0_sw_fini(struct amdgpu_ip_block *ip_block)
 		drm_dev_exit(idx);
 	}
 
-	r = amdgpu_vcn_suspend(adev);
+	r = amdgpu_vcn_suspend(adev, inst);
 	if (r)
 		return r;
 
@@ -287,13 +287,15 @@ static int vcn_v5_0_0_hw_fini(struct amdgpu_ip_block *ip_block)
  */
 static int vcn_v5_0_0_suspend(struct amdgpu_ip_block *ip_block)
 {
+	struct amdgpu_device *adev = ip_block->adev;
+	int inst = ip_block->instance;
 	int r;
 
 	r = vcn_v5_0_0_hw_fini(ip_block);
 	if (r)
 		return r;
 
-	r = amdgpu_vcn_suspend(ip_block->adev);
+	r = amdgpu_vcn_suspend(adev, inst);
 
 	return r;
 }
-- 
2.34.1

