Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0497DCF0429
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Oct 2024 21:16:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C942B10E5EA;
	Tue,  8 Oct 2024 21:16:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="MKGEuKs5";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2042.outbound.protection.outlook.com [40.107.220.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B388710E5D5
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Oct 2024 21:16:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fKJO64PX9TK+FTEikebshF6fRc9DTd/cgCbjqGVMohQyGYNW3Z4IhT1QCaEWHQvGSYWTNJuDyYLyS9jgV61jHL9viE1QYT/O6kux1NL7JSutBDF6POsQR1pa8rpp1TJQ+hPzBtMyXid3SoTKMKxbza3JjRrJ8ihyGAT99mkEsxX56RnnKvulhzK+8UwF0D9KYqXxLeNQcYDjVrVqXcdS0iONYX7Ari2O4IG3/8Qp/5CNmcfMbiidl/WQK9qGnVJlkyyEqBnXYPgqQIomCGWL4Wzo1MagE8XocXk10k9U/4VV37428CiQybOCJoNxbAiJqcCaFXPI4/eUOPQDrwf7Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UNW5+1hGdQIP/jjfRtyqMTCfrVZEtVYICTxnAklct6E=;
 b=i5NeraE3/Xc3bRFh4kzZgk/SQkXmfT6DGRI5tCOxnjNj9UhNwNHMS5VxAh0k/6I44Fj1/eAlwdWzLX1V7fWIhyq546PDbfk5CZs/nyKEHELTdeMcfePGc4hz75J1Yh69auak8HEYSE70+ghTubhVRcRCAofzgcZnX/1o35nZKmNHY+LqQFKA1YWjyMF5z8USOEQUHs0QAfkX5Hl7mmBXiPi1Q6ylhM9qlGf4xx0Eq30MX1BpsD0RnZlaLpJslsR5esJkg3xFUZ6Jrc9BHthjmkl84ImyrOCKcy2ppPbm01rQuL5rcUP//KSRh2wpOxfT/ax1c+jzw6y2+AZCpCqPIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UNW5+1hGdQIP/jjfRtyqMTCfrVZEtVYICTxnAklct6E=;
 b=MKGEuKs56AebDgBZxyvHjxUbEQEaGXgOGjcaOLHb3zyc+Wpg1dCLuLn0ED/xlMxR6aU3qE9EJDcMHfUgR3WtGW2zMfY6Tj0+UZ8ovBq/StBswiX93Lj04V7UAps+cMBg9k2IEOzSJoiM+qNOTqJuMtJbep8Yi4zBn+sbS6UhCxo=
Received: from CH0PR03CA0400.namprd03.prod.outlook.com (2603:10b6:610:11b::20)
 by CH3PR12MB7713.namprd12.prod.outlook.com (2603:10b6:610:14d::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23; Tue, 8 Oct
 2024 21:16:31 +0000
Received: from DS2PEPF00003442.namprd04.prod.outlook.com
 (2603:10b6:610:11b:cafe::bf) by CH0PR03CA0400.outlook.office365.com
 (2603:10b6:610:11b::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23 via Frontend
 Transport; Tue, 8 Oct 2024 21:16:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003442.mail.protection.outlook.com (10.167.17.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8048.13 via Frontend Transport; Tue, 8 Oct 2024 21:16:31 +0000
Received: from atitest-Rembrandt.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 8 Oct 2024 16:16:27 -0500
From: <boyuan.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <leo.liu@amd.com>,
 <christian.koenig@amd.com>, <alexander.deucher@amd.com>,
 <sunil.khatri@amd.com>
CC: Boyuan Zhang <boyuan.zhang@amd.com>
Subject: [PATCH 22/32] drm/amdgpu: sw_fini for each vcn instance
Date: Tue, 8 Oct 2024 17:15:43 -0400
Message-ID: <20241008211553.36264-23-boyuan.zhang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241008211553.36264-1-boyuan.zhang@amd.com>
References: <20241008211553.36264-1-boyuan.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003442:EE_|CH3PR12MB7713:EE_
X-MS-Office365-Filtering-Correlation-Id: d0749caa-657b-48fb-370a-08dce7de7b22
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?T/tz5Z4AgIDnO3RzxzgIOVKcsShx4ciIfRsCQ1TjkfzJ+gsdEgLYfel5dg9k?=
 =?us-ascii?Q?ckJ3mvDdFOK2tRqXFBDIJ7EKCo3/Y3Py1ROlyKZXXTDl5eX1X127M5/lKcbr?=
 =?us-ascii?Q?apTNlX/uN5CxZgpWT7Ovoobr8HOBrSHhhY2r+IbAKbd2QKAaPIBf5qdz/053?=
 =?us-ascii?Q?2I6JjSxKxtxFAJOd1JEQ9YPFagV7q9c/1Df6Ytnm5QGL6jqdiQ3yTJb7Y1YM?=
 =?us-ascii?Q?AR/Ykoq/bzUgJTejNdRo7gkiWafd0k2lrnh5mg6r0HpYteZ9VOp5NP7Ez9od?=
 =?us-ascii?Q?rF+4d6M8CNI+xDn7vMrswo4TT83+mcwZCZRLWch9KmzvyJZq+hftMkozKuji?=
 =?us-ascii?Q?gHTgE/P2cq/x/w3yL4gnChMf3ixcWQINo3R2qnVUi0k6xRpwqbpqvocmbv2Y?=
 =?us-ascii?Q?YRqAzarbHw3kknITJ4cGazSoD3P7XjIAguZVH8CLQMUKHkeKUg6YYuDTRp9Z?=
 =?us-ascii?Q?Bc7MCc20iKsZZFf3yRBXWx50l5Vtn9v4jrOQJgtoLa3dIXnRQFKU7DYKLyyL?=
 =?us-ascii?Q?NeuFNiIRUhFprIkPXGYlVsuU59INTcOqSW461auTz3C6RBPHKC0QFK3oXaxv?=
 =?us-ascii?Q?3Rvs7UOioZ8AQvxsIb+sCKsCPwODevXn9VWdeSEVh5K8v4kf23acm0XkHKgO?=
 =?us-ascii?Q?Zu5IdXsyk4MAGLixg0G/ReC4Hov2MCAwj5gErBFNSfl2bPiGeFNn+OqVLD3L?=
 =?us-ascii?Q?CpKe1/0nFEd8ZR+GZ9gXNc7CqMcqMnKpT47RH67ct14G/9Exgtt+T7Bdyhfi?=
 =?us-ascii?Q?KweqcTZKU2dhjmoi6ei0F+LcroM+J3EGtxSvT4uUay1+tgYUr6iEQFmighIt?=
 =?us-ascii?Q?p1IFcI2LC5asZOxN0qu0yMd6P635QogGRrOvmR7slYoV6j1UXM7EcGl98gsh?=
 =?us-ascii?Q?jc820Ct/ge5xcgtT5oOQNAAA9pACK9lryjsJKnADX4UCEQ8jltIvYA0bG+kp?=
 =?us-ascii?Q?sIf52jdts0gsilHFVdhm+I2f3tlUhlQ/r+2CZUk1ciilmXuRf4z3uYkn9svd?=
 =?us-ascii?Q?g41vLG5G5ncW5DmSmzKAoOwnzyKFTfzGkBMbsyOolJLC1WPnOEjUB9zBohip?=
 =?us-ascii?Q?5VxYG9fsH2xf6fCnFIzjn3VPSH2pBK2+xhi3EuN3x7PAKeiZCQjjQMX+vc0i?=
 =?us-ascii?Q?13OVnYolQaWV4FgjDXPEXPdY/DLB42UJHxerW/wPWsZ8aM/+H/ZfMbuFiwAZ?=
 =?us-ascii?Q?okvWOcSR9XlmCQMjnsr/YKeHk8Ddy/KDpNpxxwwP7wksf6CK6xd94DsrJ86y?=
 =?us-ascii?Q?STzCApD+LTc7NA/DaZKpVa5vErFrFUosOm6nTRz9da5TMpS/ongVKc1bqhgs?=
 =?us-ascii?Q?Jj2Pk7uYjLDetrde5eSQq633ab0JeCKR1SaqzYeMwEq3+TVUUJlBqWHMgQXa?=
 =?us-ascii?Q?gqQhNM0=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2024 21:16:31.2644 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d0749caa-657b-48fb-370a-08dce7de7b22
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003442.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7713
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

Pass instance parameter to amdgpu_vcn_sw_fini(), and perform
sw fini ONLY for the given vcn instance, instead of for all
vcn instances. Modify each vcn generation accordingly.

Signed-off-by: Boyuan Zhang <boyuan.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 36 ++++++++++++-------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h |  2 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c   |  5 ++--
 drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c   |  5 ++--
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c   | 17 ++++++------
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c   | 20 +++++++-------
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c   | 21 +++++++--------
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c | 16 +++++------
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c | 21 +++++++--------
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c | 21 +++++++--------
 10 files changed, 81 insertions(+), 83 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index 791b95867ac2..307615ffeb79 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -248,33 +248,31 @@ int amdgpu_vcn_sw_init(struct amdgpu_device *adev, int inst)
 	return 0;
 }
 
-int amdgpu_vcn_sw_fini(struct amdgpu_device *adev)
+int amdgpu_vcn_sw_fini(struct amdgpu_device *adev, int inst)
 {
-	int i, j;
-
-	for (j = 0; j < adev->vcn.num_vcn_inst; ++j) {
-		if (adev->vcn.harvest_config & (1 << j))
-			continue;
+	int i;
 
-		amdgpu_bo_free_kernel(
-			&adev->vcn.inst[j].dpg_sram_bo,
-			&adev->vcn.inst[j].dpg_sram_gpu_addr,
-			(void **)&adev->vcn.inst[j].dpg_sram_cpu_addr);
+	if (adev->vcn.harvest_config & (1 << inst))
+		goto done;
 
-		kvfree(adev->vcn.inst[j].saved_bo);
+	amdgpu_bo_free_kernel(
+		&adev->vcn.inst[inst].dpg_sram_bo,
+		&adev->vcn.inst[inst].dpg_sram_gpu_addr,
+		(void **)&adev->vcn.inst[inst].dpg_sram_cpu_addr);
 
-		amdgpu_bo_free_kernel(&adev->vcn.inst[j].vcpu_bo,
-					  &adev->vcn.inst[j].gpu_addr,
-					  (void **)&adev->vcn.inst[j].cpu_addr);
+	kvfree(adev->vcn.inst[inst].saved_bo);
 
-		amdgpu_ring_fini(&adev->vcn.inst[j].ring_dec);
+	amdgpu_bo_free_kernel(&adev->vcn.inst[inst].vcpu_bo,
+				  &adev->vcn.inst[inst].gpu_addr,
+				  (void **)&adev->vcn.inst[inst].cpu_addr);
 
-		for (i = 0; i < adev->vcn.num_enc_rings; ++i)
-			amdgpu_ring_fini(&adev->vcn.inst[j].ring_enc[i]);
+	amdgpu_ring_fini(&adev->vcn.inst[inst].ring_dec);
 
-		amdgpu_ucode_release(&adev->vcn.inst[j].fw);
-	}
+	for (i = 0; i < adev->vcn.num_enc_rings; ++i)
+		amdgpu_ring_fini(&adev->vcn.inst[inst].ring_enc[i]);
 
+	amdgpu_ucode_release(&adev->vcn.inst[inst].fw);
+done:
 	mutex_destroy(&adev->vcn.vcn1_jpeg1_workaround);
 	mutex_destroy(&adev->vcn.vcn_pg_lock);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
index 825b70a396cd..883b9f9776a1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
@@ -485,7 +485,7 @@ enum vcn_ring_type {
 
 int amdgpu_vcn_early_init(struct amdgpu_device *adev, int inst);
 int amdgpu_vcn_sw_init(struct amdgpu_device *adev, int inst);
-int amdgpu_vcn_sw_fini(struct amdgpu_device *adev);
+int amdgpu_vcn_sw_fini(struct amdgpu_device *adev, int inst);
 int amdgpu_vcn_suspend(struct amdgpu_device *adev);
 int amdgpu_vcn_resume(struct amdgpu_device *adev);
 void amdgpu_vcn_ring_begin_use(struct amdgpu_ring *ring);
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
index 70d865724463..8203f80be316 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
@@ -222,8 +222,9 @@ static int vcn_v1_0_sw_init(struct amdgpu_ip_block *ip_block)
  */
 static int vcn_v1_0_sw_fini(struct amdgpu_ip_block *ip_block)
 {
-	int r;
 	struct amdgpu_device *adev = ip_block->adev;
+	int inst = ip_block->instance;
+	int r;
 
 	r = amdgpu_vcn_suspend(adev);
 	if (r)
@@ -231,7 +232,7 @@ static int vcn_v1_0_sw_fini(struct amdgpu_ip_block *ip_block)
 
 	jpeg_v1_0_sw_fini(ip_block);
 
-	r = amdgpu_vcn_sw_fini(adev);
+	r = amdgpu_vcn_sw_fini(adev, inst);
 
 	kfree(adev->vcn.ip_dump);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
index 834311e13a4c..0481a07054eb 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
@@ -245,9 +245,10 @@ static int vcn_v2_0_sw_init(struct amdgpu_ip_block *ip_block)
  */
 static int vcn_v2_0_sw_fini(struct amdgpu_ip_block *ip_block)
 {
-	int r, idx;
 	struct amdgpu_device *adev = ip_block->adev;
+	int inst = ip_block->instance;
 	volatile struct amdgpu_fw_shared *fw_shared = adev->vcn.inst->fw_shared.cpu_addr;
+	int r, idx;
 
 	if (drm_dev_enter(adev_to_drm(adev), &idx)) {
 		fw_shared->present_flag_0 = 0;
@@ -260,7 +261,7 @@ static int vcn_v2_0_sw_fini(struct amdgpu_ip_block *ip_block)
 	if (r)
 		return r;
 
-	r = amdgpu_vcn_sw_fini(adev);
+	r = amdgpu_vcn_sw_fini(adev, inst);
 
 	kfree(adev->vcn.ip_dump);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
index f6d2e3e3bf32..ed972d843f93 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
@@ -297,17 +297,18 @@ static int vcn_v2_5_sw_init(struct amdgpu_ip_block *ip_block)
  */
 static int vcn_v2_5_sw_fini(struct amdgpu_ip_block *ip_block)
 {
-	int i, r, idx;
 	struct amdgpu_device *adev = ip_block->adev;
 	volatile struct amdgpu_fw_shared *fw_shared;
+	int inst = ip_block->instance;
+	int r, idx;
 
 	if (drm_dev_enter(adev_to_drm(adev), &idx)) {
-		for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
-			if (adev->vcn.harvest_config & (1 << i))
-				continue;
-			fw_shared = adev->vcn.inst[i].fw_shared.cpu_addr;
-			fw_shared->present_flag_0 = 0;
-		}
+		if (adev->vcn.harvest_config & (1 << inst))
+			goto done;
+
+		fw_shared = adev->vcn.inst[inst].fw_shared.cpu_addr;
+		fw_shared->present_flag_0 = 0;
+	done:
 		drm_dev_exit(idx);
 	}
 
@@ -319,7 +320,7 @@ static int vcn_v2_5_sw_fini(struct amdgpu_ip_block *ip_block)
 	if (r)
 		return r;
 
-	r = amdgpu_vcn_sw_fini(adev);
+	r = amdgpu_vcn_sw_fini(adev, inst);
 
 	kfree(adev->vcn.ip_dump);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
index 9b62296cc233..c45bebeb0aaa 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
@@ -306,19 +306,19 @@ static int vcn_v3_0_sw_init(struct amdgpu_ip_block *ip_block)
 static int vcn_v3_0_sw_fini(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
-	int i, r, idx;
+	int inst = ip_block->instance;
+	int r, idx;
 
 	if (drm_dev_enter(adev_to_drm(adev), &idx)) {
-		for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
-			volatile struct amdgpu_fw_shared *fw_shared;
+		volatile struct amdgpu_fw_shared *fw_shared;
 
-			if (adev->vcn.harvest_config & (1 << i))
-				continue;
-			fw_shared = adev->vcn.inst[i].fw_shared.cpu_addr;
-			fw_shared->present_flag_0 = 0;
-			fw_shared->sw_ring.is_enabled = false;
-		}
+		if (adev->vcn.harvest_config & (1 << inst))
+			goto done;
 
+		fw_shared = adev->vcn.inst[inst].fw_shared.cpu_addr;
+		fw_shared->present_flag_0 = 0;
+		fw_shared->sw_ring.is_enabled = false;
+	done:
 		drm_dev_exit(idx);
 	}
 
@@ -329,7 +329,7 @@ static int vcn_v3_0_sw_fini(struct amdgpu_ip_block *ip_block)
 	if (r)
 		return r;
 
-	r = amdgpu_vcn_sw_fini(adev);
+	r = amdgpu_vcn_sw_fini(adev, inst);
 
 	kfree(adev->vcn.ip_dump);
 	return r;
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
index 79d5ef8f857c..c87b4e46f2b0 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
@@ -258,20 +258,19 @@ static int vcn_v4_0_sw_init(struct amdgpu_ip_block *ip_block)
 static int vcn_v4_0_sw_fini(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
-	int i, r, idx;
+	int inst = ip_block->instance;
+	int r, idx;
 
 	if (drm_dev_enter(adev_to_drm(adev), &idx)) {
-		for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
-			volatile struct amdgpu_vcn4_fw_shared *fw_shared;
+		volatile struct amdgpu_vcn4_fw_shared *fw_shared;
 
-			if (adev->vcn.harvest_config & (1 << i))
-				continue;
-
-			fw_shared = adev->vcn.inst[i].fw_shared.cpu_addr;
-			fw_shared->present_flag_0 = 0;
-			fw_shared->sq.is_enabled = 0;
-		}
+		if (adev->vcn.harvest_config & (1 << inst))
+			goto done;
 
+		fw_shared = adev->vcn.inst[inst].fw_shared.cpu_addr;
+		fw_shared->present_flag_0 = 0;
+		fw_shared->sq.is_enabled = 0;
+	done:
 		drm_dev_exit(idx);
 	}
 
@@ -282,7 +281,7 @@ static int vcn_v4_0_sw_fini(struct amdgpu_ip_block *ip_block)
 	if (r)
 		return r;
 
-	r = amdgpu_vcn_sw_fini(adev);
+	r = amdgpu_vcn_sw_fini(adev, inst);
 
 	kfree(adev->vcn.ip_dump);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
index 0932e992d088..0b55d801ae88 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
@@ -219,16 +219,16 @@ static int vcn_v4_0_3_sw_init(struct amdgpu_ip_block *ip_block)
 static int vcn_v4_0_3_sw_fini(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
-	int i, r, idx;
+	int inst = ip_block->instance;
+	int r, idx;
 
 	if (drm_dev_enter(&adev->ddev, &idx)) {
-		for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
-			volatile struct amdgpu_vcn4_fw_shared *fw_shared;
+		volatile struct amdgpu_vcn4_fw_shared *fw_shared;
+
+		fw_shared = adev->vcn.inst[inst].fw_shared.cpu_addr;
+		fw_shared->present_flag_0 = 0;
+		fw_shared->sq.is_enabled = cpu_to_le32(false);
 
-			fw_shared = adev->vcn.inst[i].fw_shared.cpu_addr;
-			fw_shared->present_flag_0 = 0;
-			fw_shared->sq.is_enabled = cpu_to_le32(false);
-		}
 		drm_dev_exit(idx);
 	}
 
@@ -239,7 +239,7 @@ static int vcn_v4_0_3_sw_fini(struct amdgpu_ip_block *ip_block)
 	if (r)
 		return r;
 
-	r = amdgpu_vcn_sw_fini(adev);
+	r = amdgpu_vcn_sw_fini(adev, inst);
 
 	kfree(adev->vcn.ip_dump);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
index e551ba1d1e12..b88fdb00cc5e 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
@@ -227,20 +227,19 @@ static int vcn_v4_0_5_sw_init(struct amdgpu_ip_block *ip_block)
 static int vcn_v4_0_5_sw_fini(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
-	int i, r, idx;
+	int inst = ip_block->instance;
+	int r, idx;
 
 	if (drm_dev_enter(adev_to_drm(adev), &idx)) {
-		for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
-			volatile struct amdgpu_vcn4_fw_shared *fw_shared;
-
-			if (adev->vcn.harvest_config & (1 << i))
-				continue;
+		volatile struct amdgpu_vcn4_fw_shared *fw_shared;
 
-			fw_shared = adev->vcn.inst[i].fw_shared.cpu_addr;
-			fw_shared->present_flag_0 = 0;
-			fw_shared->sq.is_enabled = 0;
-		}
+		if (adev->vcn.harvest_config & (1 << inst))
+			goto done;
 
+		fw_shared = adev->vcn.inst[inst].fw_shared.cpu_addr;
+		fw_shared->present_flag_0 = 0;
+		fw_shared->sq.is_enabled = 0;
+	done:
 		drm_dev_exit(idx);
 	}
 
@@ -251,7 +250,7 @@ static int vcn_v4_0_5_sw_fini(struct amdgpu_ip_block *ip_block)
 	if (r)
 		return r;
 
-	r = amdgpu_vcn_sw_fini(adev);
+	r = amdgpu_vcn_sw_fini(adev, inst);
 
 	kfree(adev->vcn.ip_dump);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
index dc15a74bb3d8..15cdc7be9062 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
@@ -194,20 +194,19 @@ static int vcn_v5_0_0_sw_init(struct amdgpu_ip_block *ip_block)
 static int vcn_v5_0_0_sw_fini(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
-	int i, r, idx;
+	int inst = ip_block->instance;
+	int r, idx;
 
 	if (drm_dev_enter(adev_to_drm(adev), &idx)) {
-		for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
-			volatile struct amdgpu_vcn5_fw_shared *fw_shared;
-
-			if (adev->vcn.harvest_config & (1 << i))
-				continue;
+		volatile struct amdgpu_vcn5_fw_shared *fw_shared;
 
-			fw_shared = adev->vcn.inst[i].fw_shared.cpu_addr;
-			fw_shared->present_flag_0 = 0;
-			fw_shared->sq.is_enabled = 0;
-		}
+		if (adev->vcn.harvest_config & (1 << inst))
+			goto done;
 
+		fw_shared = adev->vcn.inst[inst].fw_shared.cpu_addr;
+		fw_shared->present_flag_0 = 0;
+		fw_shared->sq.is_enabled = 0;
+	done:
 		drm_dev_exit(idx);
 	}
 
@@ -215,7 +214,7 @@ static int vcn_v5_0_0_sw_fini(struct amdgpu_ip_block *ip_block)
 	if (r)
 		return r;
 
-	r = amdgpu_vcn_sw_fini(adev);
+	r = amdgpu_vcn_sw_fini(adev, inst);
 
 	kfree(adev->vcn.ip_dump);
 
-- 
2.34.1

