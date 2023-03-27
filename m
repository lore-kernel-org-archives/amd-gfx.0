Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F12BC76195
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Mar 2023 19:36:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EEE8710E716;
	Mon, 27 Mar 2023 19:36:30 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2082.outbound.protection.outlook.com [40.107.220.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 201F010E714
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Mar 2023 19:36:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=evOYk8MY3OIM9YDmWBVhkCxYLiBjcHf5cP3yjYWQx1KBgVStUkT+EU0gRalljuYjgQ6g0e23wTwKNWCInPJqqzowZSxgAOZtmCIAfwzvaiIqLhgJ99Qlb5qg/FlrYCgDMZYMj1MuGTVKd/zWNP9rYP/96/nl29V76XojDlD/BOP87iLxnuaBTtCr3n4B+vzSPx07cBWHKTU/J9e5yX7dR5VDYETbBE89cCpH6pRtZX0w9+rkIWKNNRTxyM2h3UeKIsTyKvIJKm4ZZmJ7Qv4+OpCfY+X8Nrnwq8gbW4oV8KdI5TnWUIJ0qC4zre2+q7LlTVB4zUcL5MblXA/MP18uZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FcXugRtvVR2X2qYRk8k315LzpRs9P7yNGdPs3ZQ2ThY=;
 b=i7LTExi6kOquVWAx6hSD3bFMAF3WEJVClHKYaNDc1mwFm1h5sSWxRoycgsk6ZWUt1CTxvsu66BNCbGhO+jrM+o5oGocfYyRFZATMHZr49ZJ6NdV3Fil11A4mWyI9DK06N0iDRNhBtYbW2n7VLA6MAnwnmrasKmCyQ5D9Y04r1At5KE9vG5kH34UhmfgpaDFbUGCOFOxiXJDKf8nsf6HcQTKCnrqWrlmxwkbpQ8iZJwPjkmQOHzSPJggk/NkqV7i4hAMvLqvXkT1DIls8wn5h+451VzVrr/umdL8bGu+NsskIYIPAeAG5MuogFNtsyxf/WfDPZQardA048V2//7Tq1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FcXugRtvVR2X2qYRk8k315LzpRs9P7yNGdPs3ZQ2ThY=;
 b=k2XZdPsC3HatSVDj2UiSyt6Pu/Kp2+JfjFNiFnPAOrJeCf1GwbewuG4so8+IGztH0HkRYps6c7JnLm/RhknJOJuYAf6u4+44fmzPRXyI7eext8DXnUrK94eFE3gzsbXc1/YtcF9GooDY55p1tU/dL8j3VeyClHR2sAgFAi8wgk4=
Received: from BN8PR15CA0066.namprd15.prod.outlook.com (2603:10b6:408:80::43)
 by PH7PR12MB7890.namprd12.prod.outlook.com (2603:10b6:510:268::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.41; Mon, 27 Mar
 2023 19:36:22 +0000
Received: from BL02EPF000100D0.namprd05.prod.outlook.com
 (2603:10b6:408:80:cafe::8c) by BN8PR15CA0066.outlook.office365.com
 (2603:10b6:408:80::43) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.41 via Frontend
 Transport; Mon, 27 Mar 2023 19:36:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF000100D0.mail.protection.outlook.com (10.167.241.204) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.30 via Frontend Transport; Mon, 27 Mar 2023 19:36:21 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 27 Mar
 2023 14:36:20 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 04/28] drm/amdgpu: move queue_bitmap to an independent
 structure (v3)
Date: Mon, 27 Mar 2023 15:35:38 -0400
Message-ID: <20230327193602.7901-4-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230327193602.7901-1-alexander.deucher@amd.com>
References: <20230327193602.7901-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF000100D0:EE_|PH7PR12MB7890:EE_
X-MS-Office365-Filtering-Correlation-Id: 03f4aae2-046f-4cac-f033-08db2efa8b63
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lGMY62j2264UP1PXmXwflSSR+qfT2kzNySeLzL99fAu3Sq4Hds4cRVzL5Bspbm27kSPfks/TtXXxvCQLcGvX1gmqmRDSU63JSGPPrygU6JcD6oQsFPzSVup5qzhjvUgGla1PyAKa+IvQZqsuTMv3GN7RIEmAKgX1n0EbSQwSw1H/3Uo5ikuDFPm7574vM200efS9eWEy+uJSolq00UfTkSGGwDQiGWjnQkXiHz1qrceXiBgrKYTx/m9qeA3H1xkg07+Fo8z90kVYC6gGQD+Rl+PPArDK908E0HqniMVew0KiMcZd3xpQj21r9gPIw3YY0LCXaekzZwx/fczn4cmkoyilD5dvyz9LJkztKyjzGuKjX82wjLO69p3JMb7A0soL0f44hgu5mFURVgW3J4NEYCWvu14u5cweAN+R88+ckkz7sEcxPKk6cUzUSHc/KUWEgusOwfrNIuSx2+ltroroaonVyDfUNz4UDHQBFa+y6t7fq+KCmrvlIyk6qHtfH3lwMhTpNkMF0pdOb4K0iE6eiLiZPNnfetB24ywzQ5tFM8aqdHT1w7CrjsCjGNOOs1jLZ6N57P/3fPExb71kd7VWc28I3pJ+WA0ac4aGY6d/RlIYgGmUzYVoEyAYr+YzdImpsvCi55LR71Gp5TTkQMdelmU5mpfuZ23NrZO7wmoRhh45W6/vjPF6oIpVQED9By2qpRABomsxJzpvLOvnz7UndXECCJ0kiy+d4sa4lTIE8yI=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(39860400002)(346002)(136003)(376002)(451199021)(40470700004)(46966006)(36840700001)(6916009)(26005)(40460700003)(8676002)(4326008)(316002)(70586007)(70206006)(36860700001)(5660300002)(41300700001)(8936002)(54906003)(186003)(16526019)(81166007)(30864003)(82740400003)(47076005)(7696005)(2616005)(426003)(1076003)(336012)(83380400001)(6666004)(478600001)(40480700001)(86362001)(356005)(2906002)(82310400005)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2023 19:36:21.7872 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 03f4aae2-046f-4cac-f033-08db2efa8b63
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF000100D0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7890
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Le Ma <le.ma@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Le Ma <le.ma@amd.com>

To allocate independent queue_bitmap for each XCD,
then the old bitmap policy can be continued to use
with a clear logic.

Use mec_bitmap[0] as default for all non-GC 9.4.3 IPs.

v2: squash commits to avoid breaking the build
v3: unify naming style

Signed-off-by: Le Ma <le.ma@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c    |  2 +-
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c       | 41 +++++++++++--------
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h       |  7 +++-
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c        |  6 +--
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c        |  6 +--
 drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c         |  5 ++-
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c         |  7 ++--
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c         |  5 ++-
 9 files changed, 48 insertions(+), 33 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
index f99d4873bf22..2ce93b27131b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
@@ -162,7 +162,7 @@ void amdgpu_amdkfd_device_init(struct amdgpu_device *adev)
 		 * clear
 		 */
 		bitmap_complement(gpu_resources.cp_queue_bitmap,
-				  adev->gfx.mec.queue_bitmap,
+				  adev->gfx.mec_bitmap[0].queue_bitmap,
 				  KGD_MAX_QUEUES);
 
 		/* According to linux/bitmap.h we shouldn't use bitmap_clear if
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
index bc944ae4fd5b..03875b971ba6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
@@ -778,7 +778,7 @@ void kgd_gfx_v9_get_cu_occupancy(struct amdgpu_device *adev, int pasid,
 	 * Iterate through the shader engines and arrays of the device
 	 * to get number of waves in flight
 	 */
-	bitmap_complement(cp_queue_bitmap, adev->gfx.mec.queue_bitmap,
+	bitmap_complement(cp_queue_bitmap, adev->gfx.mec_bitmap[0].queue_bitmap,
 			  KGD_MAX_QUEUES);
 	max_queue_cnt = adev->gfx.mec.num_pipe_per_mec *
 			adev->gfx.mec.num_queue_per_pipe;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index 9b6071df1fa7..b300b1784210 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -63,10 +63,10 @@ void amdgpu_queue_mask_bit_to_mec_queue(struct amdgpu_device *adev, int bit,
 }
 
 bool amdgpu_gfx_is_mec_queue_enabled(struct amdgpu_device *adev,
-				     int mec, int pipe, int queue)
+				     int xcc_id, int mec, int pipe, int queue)
 {
 	return test_bit(amdgpu_gfx_mec_queue_to_bit(adev, mec, pipe, queue),
-			adev->gfx.mec.queue_bitmap);
+			adev->gfx.mec_bitmap[xcc_id].queue_bitmap);
 }
 
 int amdgpu_gfx_me_queue_to_bit(struct amdgpu_device *adev,
@@ -204,29 +204,38 @@ bool amdgpu_gfx_is_high_priority_compute_queue(struct amdgpu_device *adev,
 
 void amdgpu_gfx_compute_queue_acquire(struct amdgpu_device *adev)
 {
-	int i, queue, pipe;
+	int i, j, queue, pipe;
 	bool multipipe_policy = amdgpu_gfx_is_compute_multipipe_capable(adev);
 	int max_queues_per_mec = min(adev->gfx.mec.num_pipe_per_mec *
 				     adev->gfx.mec.num_queue_per_pipe,
 				     adev->gfx.num_compute_rings);
+	int num_xcd = (adev->gfx.num_xcd > 1) ? adev->gfx.num_xcd : 1;
 
 	if (multipipe_policy) {
-		/* policy: make queues evenly cross all pipes on MEC1 only */
-		for (i = 0; i < max_queues_per_mec; i++) {
-			pipe = i % adev->gfx.mec.num_pipe_per_mec;
-			queue = (i / adev->gfx.mec.num_pipe_per_mec) %
-				adev->gfx.mec.num_queue_per_pipe;
-
-			set_bit(pipe * adev->gfx.mec.num_queue_per_pipe + queue,
-					adev->gfx.mec.queue_bitmap);
+		/* policy: make queues evenly cross all pipes on MEC1 only
+		 * for multiple xcc, just use the original policy for simplicity */
+		for (j = 0; j < num_xcd; j++) {
+			for (i = 0; i < max_queues_per_mec; i++) {
+				pipe = i % adev->gfx.mec.num_pipe_per_mec;
+				queue = (i / adev->gfx.mec.num_pipe_per_mec) %
+					 adev->gfx.mec.num_queue_per_pipe;
+
+				set_bit(pipe * adev->gfx.mec.num_queue_per_pipe + queue,
+					adev->gfx.mec_bitmap[j].queue_bitmap);
+			}
 		}
 	} else {
 		/* policy: amdgpu owns all queues in the given pipe */
-		for (i = 0; i < max_queues_per_mec; ++i)
-			set_bit(i, adev->gfx.mec.queue_bitmap);
+		for (j = 0; j < num_xcd; j++) {
+			for (i = 0; i < max_queues_per_mec; ++i)
+				set_bit(i, adev->gfx.mec_bitmap[j].queue_bitmap);
+		}
 	}
 
-	dev_dbg(adev->dev, "mec queue bitmap weight=%d\n", bitmap_weight(adev->gfx.mec.queue_bitmap, AMDGPU_MAX_COMPUTE_QUEUES));
+	for (j = 0; j < num_xcd; j++) {
+		dev_dbg(adev->dev, "mec queue bitmap weight=%d\n",
+			bitmap_weight(adev->gfx.mec_bitmap[j].queue_bitmap, AMDGPU_MAX_COMPUTE_QUEUES));
+	}
 }
 
 void amdgpu_gfx_graphics_queue_acquire(struct amdgpu_device *adev)
@@ -268,7 +277,7 @@ static int amdgpu_gfx_kiq_acquire(struct amdgpu_device *adev,
 		    * adev->gfx.mec.num_queue_per_pipe;
 
 	while (--queue_bit >= 0) {
-		if (test_bit(queue_bit, adev->gfx.mec.queue_bitmap))
+		if (test_bit(queue_bit, adev->gfx.mec_bitmap[0].queue_bitmap))
 			continue;
 
 		amdgpu_queue_mask_bit_to_mec_queue(adev, queue_bit, &mec, &pipe, &queue);
@@ -516,7 +525,7 @@ int amdgpu_gfx_enable_kcq(struct amdgpu_device *adev)
 		return -EINVAL;
 
 	for (i = 0; i < AMDGPU_MAX_COMPUTE_QUEUES; ++i) {
-		if (!test_bit(i, adev->gfx.mec.queue_bitmap))
+		if (!test_bit(i, adev->gfx.mec_bitmap[0].queue_bitmap))
 			continue;
 
 		/* This situation may be hit in the future if a new HW
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
index c742b4a36979..830323310694 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
@@ -76,7 +76,9 @@ struct amdgpu_mec {
 	u32 num_pipe_per_mec;
 	u32 num_queue_per_pipe;
 	void			*mqd_backup[AMDGPU_MAX_COMPUTE_RINGS + 1];
+};
 
+struct amdgpu_mec_bitmap {
 	/* These are the resources for which amdgpu takes ownership */
 	DECLARE_BITMAP(queue_bitmap, AMDGPU_MAX_COMPUTE_QUEUES);
 };
@@ -296,6 +298,7 @@ struct amdgpu_gfx {
 	struct amdgpu_ce		ce;
 	struct amdgpu_me		me;
 	struct amdgpu_mec		mec;
+	struct amdgpu_mec_bitmap	mec_bitmap[AMDGPU_MAX_GC_INSTANCES];
 	struct amdgpu_kiq		kiq[AMDGPU_MAX_GC_INSTANCES];
 	struct amdgpu_imu		imu;
 	bool				rs64_enable; /* firmware format */
@@ -425,8 +428,8 @@ int amdgpu_gfx_mec_queue_to_bit(struct amdgpu_device *adev, int mec,
 				int pipe, int queue);
 void amdgpu_queue_mask_bit_to_mec_queue(struct amdgpu_device *adev, int bit,
 				 int *mec, int *pipe, int *queue);
-bool amdgpu_gfx_is_mec_queue_enabled(struct amdgpu_device *adev, int mec,
-				     int pipe, int queue);
+bool amdgpu_gfx_is_mec_queue_enabled(struct amdgpu_device *adev, int inst,
+				     int mec, int pipe, int queue);
 bool amdgpu_gfx_is_high_priority_compute_queue(struct amdgpu_device *adev,
 					       struct amdgpu_ring *ring);
 bool amdgpu_gfx_is_high_priority_graphics_queue(struct amdgpu_device *adev,
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index d4e7de8fd9da..88f8424ea1e4 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -4219,7 +4219,7 @@ static int gfx_v10_0_mec_init(struct amdgpu_device *adev)
 
 	const struct gfx_firmware_header_v1_0 *mec_hdr = NULL;
 
-	bitmap_zero(adev->gfx.mec.queue_bitmap, AMDGPU_MAX_COMPUTE_QUEUES);
+	bitmap_zero(adev->gfx.mec_bitmap[0].queue_bitmap, AMDGPU_MAX_COMPUTE_QUEUES);
 
 	/* take ownership of the relevant compute queues */
 	amdgpu_gfx_compute_queue_acquire(adev);
@@ -4614,8 +4614,8 @@ static int gfx_v10_0_sw_init(void *handle)
 	for (i = 0; i < adev->gfx.mec.num_mec; ++i) {
 		for (j = 0; j < adev->gfx.mec.num_queue_per_pipe; j++) {
 			for (k = 0; k < adev->gfx.mec.num_pipe_per_mec; k++) {
-				if (!amdgpu_gfx_is_mec_queue_enabled(adev, i, k,
-								     j))
+				if (!amdgpu_gfx_is_mec_queue_enabled(adev, 0, i,
+								     k, j))
 					continue;
 
 				r = gfx_v10_0_compute_ring_init(adev, ring_id,
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 2eb2c65e37b3..fd7b73688879 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -699,7 +699,7 @@ static int gfx_v11_0_mec_init(struct amdgpu_device *adev)
 	u32 *hpd;
 	size_t mec_hpd_size;
 
-	bitmap_zero(adev->gfx.mec.queue_bitmap, AMDGPU_MAX_COMPUTE_QUEUES);
+	bitmap_zero(adev->gfx.mec_bitmap[0].queue_bitmap, AMDGPU_MAX_COMPUTE_QUEUES);
 
 	/* take ownership of the relevant compute queues */
 	amdgpu_gfx_compute_queue_acquire(adev);
@@ -1374,8 +1374,8 @@ static int gfx_v11_0_sw_init(void *handle)
 	for (i = 0; i < adev->gfx.mec.num_mec; ++i) {
 		for (j = 0; j < adev->gfx.mec.num_queue_per_pipe; j++) {
 			for (k = 0; k < adev->gfx.mec.num_pipe_per_mec; k++) {
-				if (!amdgpu_gfx_is_mec_queue_enabled(adev, i, k,
-								     j))
+				if (!amdgpu_gfx_is_mec_queue_enabled(adev, 0, i,
+								     k, j))
 					continue;
 
 				r = gfx_v11_0_compute_ring_init(adev, ring_id,
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
index 9d5c1e29b4a3..46740ad9a80f 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
@@ -2728,7 +2728,7 @@ static int gfx_v7_0_mec_init(struct amdgpu_device *adev)
 	u32 *hpd;
 	size_t mec_hpd_size;
 
-	bitmap_zero(adev->gfx.mec.queue_bitmap, AMDGPU_MAX_COMPUTE_QUEUES);
+	bitmap_zero(adev->gfx.mec_bitmap[0].queue_bitmap, AMDGPU_MAX_COMPUTE_QUEUES);
 
 	/* take ownership of the relevant compute queues */
 	amdgpu_gfx_compute_queue_acquire(adev);
@@ -4456,7 +4456,8 @@ static int gfx_v7_0_sw_init(void *handle)
 	for (i = 0; i < adev->gfx.mec.num_mec; ++i) {
 		for (j = 0; j < adev->gfx.mec.num_queue_per_pipe; j++) {
 			for (k = 0; k < adev->gfx.mec.num_pipe_per_mec; k++) {
-				if (!amdgpu_gfx_is_mec_queue_enabled(adev, i, k, j))
+				if (!amdgpu_gfx_is_mec_queue_enabled(adev, 0, i,
+								     k, j))
 					continue;
 
 				r = gfx_v7_0_compute_ring_init(adev,
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
index ed04bad8543d..18722450e265 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
@@ -1304,7 +1304,7 @@ static int gfx_v8_0_mec_init(struct amdgpu_device *adev)
 	u32 *hpd;
 	size_t mec_hpd_size;
 
-	bitmap_zero(adev->gfx.mec.queue_bitmap, AMDGPU_MAX_COMPUTE_QUEUES);
+	bitmap_zero(adev->gfx.mec_bitmap[0].queue_bitmap, AMDGPU_MAX_COMPUTE_QUEUES);
 
 	/* take ownership of the relevant compute queues */
 	amdgpu_gfx_compute_queue_acquire(adev);
@@ -2001,7 +2001,8 @@ static int gfx_v8_0_sw_init(void *handle)
 	for (i = 0; i < adev->gfx.mec.num_mec; ++i) {
 		for (j = 0; j < adev->gfx.mec.num_queue_per_pipe; j++) {
 			for (k = 0; k < adev->gfx.mec.num_pipe_per_mec; k++) {
-				if (!amdgpu_gfx_is_mec_queue_enabled(adev, i, k, j))
+				if (!amdgpu_gfx_is_mec_queue_enabled(adev, 0, i,
+								     k, j))
 					continue;
 
 				r = gfx_v8_0_compute_ring_init(adev,
@@ -4319,7 +4320,7 @@ static int gfx_v8_0_kiq_kcq_enable(struct amdgpu_device *adev)
 	int r, i;
 
 	for (i = 0; i < AMDGPU_MAX_COMPUTE_QUEUES; ++i) {
-		if (!test_bit(i, adev->gfx.mec.queue_bitmap))
+		if (!test_bit(i, adev->gfx.mec_bitmap[0].queue_bitmap))
 			continue;
 
 		/* This situation may be hit in the future if a new HW
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index e5944619b87c..9f5a8d2d545d 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -1703,7 +1703,7 @@ static int gfx_v9_0_mec_init(struct amdgpu_device *adev)
 
 	const struct gfx_firmware_header_v1_0 *mec_hdr;
 
-	bitmap_zero(adev->gfx.mec.queue_bitmap, AMDGPU_MAX_COMPUTE_QUEUES);
+	bitmap_zero(adev->gfx.mec_bitmap[0].queue_bitmap, AMDGPU_MAX_COMPUTE_QUEUES);
 
 	/* take ownership of the relevant compute queues */
 	amdgpu_gfx_compute_queue_acquire(adev);
@@ -2144,7 +2144,8 @@ static int gfx_v9_0_sw_init(void *handle)
 	for (i = 0; i < adev->gfx.mec.num_mec; ++i) {
 		for (j = 0; j < adev->gfx.mec.num_queue_per_pipe; j++) {
 			for (k = 0; k < adev->gfx.mec.num_pipe_per_mec; k++) {
-				if (!amdgpu_gfx_is_mec_queue_enabled(adev, i, k, j))
+				if (!amdgpu_gfx_is_mec_queue_enabled(adev, 0, i,
+								     k, j))
 					continue;
 
 				r = gfx_v9_0_compute_ring_init(adev,
-- 
2.39.2

