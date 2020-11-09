Return-Path: <SRS0=C2iJ=EP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43D86C388F7
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Nov 2020 18:12:45 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BFEE62068D
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Nov 2020 18:12:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="SFWy/S2Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFEE62068D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3E9B789264;
	Mon,  9 Nov 2020 18:12:44 +0000 (UTC)
Received: from NAM04-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr690077.outbound.protection.outlook.com [40.107.69.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D743E89264
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Nov 2020 18:12:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lgpse6FuuFnazbyq38WP9wtSfTPnI90BNhrlaXIB6CphZOojOc0L/NF0MxVZLuRICmw2Ip+BlBMdDubHqWJEtg4qOGutwu+4DT2hPw5xoVpQhDmUp8zmY5msJe5/Yg4J2qSUuJtrsA7nvDtabcJtF0QtlgIDuuO0647lMeJ7vnZQA/OGpkVY3pqO9xjC+cMa453njuFxpqEIEtOasTC8z41K71QL17v1wBA3Z6QO7GyN4jwxs9K//BMA4fuEqlNnzDpX45rqgHHR6LepqZ072AGkQcMgZ55146sYz9ffOuj0HocQBDYruD7Zn3SdgmH3tEqvp2FW2YeCM9C3AIgN1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oyv+JqoWYZmjI8Xt5cuu+YebAZjhnSbATDT/4CKINGU=;
 b=SNx5cNwLLz7wwgYH2kI2eqcaFQCgk4nE2+xhHISrsCGiZItErLoYUaysCUkNUdF9g6x+3XW70jvcSnpe4tsEtaQSd8izCWpwe43GCIPB4cLVDett6pqQMZlLoXqVbA5pjy/GAyn7GUhKMiscNGmRN+F09eWQpRQRwW5ONmSG6VOnsmAScpIzO3zkOdhfH6BWYUytN8bmVJnUXCyMMAeo310R1tIt1ANVhgQ9zyGKpTgh41CDIBswaDyx+oSGo2Cd50dN4NG16Z92vO16ZKvpjozhM8xHFAouB/xA7keJu9YnQbFazN12Cl6U3Kfl/3Z5Js+rlSSAxq1MyxG+1sWiDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oyv+JqoWYZmjI8Xt5cuu+YebAZjhnSbATDT/4CKINGU=;
 b=SFWy/S2YyHwBN5u4LJ4+tHX+KnVCOd5HQDUV+iw+ljhHT7e55ne9RgOpzE6cD3H8MafWggenBBKwym6vC0pEua6dQSyvn+yMjQeXfNx6cB5+o8XZLRVX9L8uWncz3ZFeV1f0YT7ShRy59o8DGhZaHw55N+UpfTIC0HWw/v9gxMA=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3916.namprd12.prod.outlook.com (2603:10b6:5:1ca::21)
 by DM5PR1201MB0090.namprd12.prod.outlook.com (2603:10b6:4:53::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21; Mon, 9 Nov
 2020 18:12:41 +0000
Received: from DM6PR12MB3916.namprd12.prod.outlook.com
 ([fe80::7080:fa49:2223:5f4e]) by DM6PR12MB3916.namprd12.prod.outlook.com
 ([fe80::7080:fa49:2223:5f4e%7]) with mapi id 15.20.3541.025; Mon, 9 Nov 2020
 18:12:41 +0000
From: Nirmoy Das <nirmoy.das@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/3] drm/amdgpu: fix compute queue priority if num_kcq is less
 than 4
Date: Mon,  9 Nov 2020 19:12:13 +0100
Message-Id: <20201109181214.35540-2-nirmoy.das@amd.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20201109181214.35540-1-nirmoy.das@amd.com>
References: <20201109181214.35540-1-nirmoy.das@amd.com>
X-Originating-IP: [165.204.84.11]
X-ClientProxiedBy: BN6PR1201CA0024.namprd12.prod.outlook.com
 (2603:10b6:405:4c::34) To DM6PR12MB3916.namprd12.prod.outlook.com
 (2603:10b6:5:1ca::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from brihaspati.amd.com (165.204.84.11) by
 BN6PR1201CA0024.namprd12.prod.outlook.com (2603:10b6:405:4c::34) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21 via Frontend
 Transport; Mon, 9 Nov 2020 18:12:39 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 0aca0d00-bcbc-429b-0d29-08d884db0c48
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0090:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR1201MB0090EFD4FFA620C95FCC22B98BEA0@DM5PR1201MB0090.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4IHiiU1LgnahqJLipLY3bbxUpwQF1xDUdDGzhKiLN/p73htUxNgrFbzDhuO7lcUsiOFsbksY8AUIQNtipZHQoq5jvCwDb+PcysgR9xyQOmrL6Gr/nXQ5esGHcMpo5tjIJDbPlOvkRhoIN9jxz/45yef7aTmGyNOtAdSmV837nXMrbrwok59Su4ALiG/2jsXB5bd63idVUt/2NkCxfeHCz0kVUKZ2miz5Kd5JRvtDH4Zn8sAC66Y9XOJj12qwMlBOh3LQT6UYy3zm3kTfkFLjqvaiosy483rxyP6Sh1qRCzN9BC13k0VVKdJSzUl/3F/Wlm4UihVnVQjAnk8wWwYZqQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3916.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(376002)(346002)(366004)(136003)(396003)(6916009)(66556008)(1076003)(66476007)(66946007)(8676002)(86362001)(8936002)(26005)(52116002)(7696005)(5660300002)(316002)(2616005)(6666004)(956004)(186003)(16526019)(44832011)(83380400001)(2906002)(6486002)(36756003)(4326008)(478600001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: 5qJDyi6/yiwgNusJzxGQftHr2+ufkxN37unOVmj+KGW5tWYw8bBgaLNeL8fWVlOrWaGfEuOxR0h0w9Vjj4Hs58V615GRrsSU1V3XDkk4x1Y5NADnEf4pbWVN5DFGMOLP5amsyZO1EEF5XBh/iTcNuvRmfeBp65Ay5SKufD0LyvkkDt28SHiFK+kEwoyA4hGSHVf38cSOge7u9uYKi+X1MYqwBD2P26KvdWNyljzQVTjCauJZHTLnKoEX5kzG7ZkqhZFJLMbGMQTfAmnMeNpNqbVorCO4C43Ofa2H0GN1YglCHejWcftAI0n4V+E9DSfiKAL4KvTR2EHElMIRyI+AZvcbX0TP3STz96CB18LV/jzW9iP1V30mMVwLuUltxnY+e7Uk4miIQPnm93QqxQbwcD7dFi4VOkfX2iLam8UaxOI7VjJI/ys8KZQMro+gwKUaX58CRKIP/fQ9wCTGXFSoKmnRo2pCp5bqlMEuZxTmeQKg7jwxUss0dW5TT24LReKs9Wc29iPfDb1leMtyOd1Wkl1TiCUOB32rfE2hqMqxYaYbA8LWhKWDaWajfXAin4A9eQyWcVMOJBJgZ5iCeE+RIwjGymojYHdXo155KznFRdrG7xd18m/MOhjn2Rtmz6vvJj4zVKW5LHw6qnGTvOw+6/1Oip1+YLQ+MFz3+TiG/5HWp3jFuzcrirBhxHVbEOTqU31O+c1CLnOAJAS8ovE9QPgoRJD8ISNLqHoTPJDtDahwj2ssC+5V0O4LZ1YyWHP0Ppe/wnTgWTjaeeeO3+jqu7plSNzWx6r0qZz1J6eZI27d2Xq9iHnR7U3r5Xmcffy+WV+R5CYTDnZ/kFGLkpoWhWtrlT/hzoOVCG099HL1cwjVNsRuQJThNvWt2Cvve+vX1R+OJpdCJIuVCyKnh3RcyQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0aca0d00-bcbc-429b-0d29-08d884db0c48
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3916.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2020 18:12:41.5765 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: juAKyTQFEcxgjUtGi3oIEXZC+tRiIPdCOEUO7vqPD6lo6mwaXAzlPnEa/dJ1+gYZ8SsnzbNrosdQ8CMbXmDe4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0090
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
Cc: Guchun.Chen@amd.com, felix.kuehling@amd.com, Aaron.Liu@amd.com,
 Nirmoy Das <nirmoy.das@amd.com>, alexander.deucher@amd.com,
 Christian.Koenig@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Compute queues are configurable with module param, num_kcq.
amdgpu_gfx_is_high_priority_compute_queue was setting 1st 4 queues to
high priority queue leaving a null drm scheduler in
adev->gpu_sched[hw_ip]["normal_prio"].sched if num_kcq < 5.

This patch tries to fix it by alternating compute queue priority between
normal and high priority.

Fixes: 33abcb1f5a1719b1c (drm/amdgpu: set compute queue priority at mqd_init)

Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 10 +++++++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h |  2 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c  |  6 ++++--
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c   |  6 ++++--
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c   |  7 +++++--
 5 files changed, 21 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index e584f48f3b54..97a8f786cf85 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -193,10 +193,14 @@ static bool amdgpu_gfx_is_multipipe_capable(struct amdgpu_device *adev)
 }
 
 bool amdgpu_gfx_is_high_priority_compute_queue(struct amdgpu_device *adev,
-					       int queue)
+					       int pipe, int queue)
 {
-	/* Policy: make queue 0 of each pipe as high priority compute queue */
-	return (queue == 0);
+	bool multipipe_policy = amdgpu_gfx_is_multipipe_capable(adev);
+	int cond;
+	/* Policy: alternate between normal and high priority */
+	cond = multipipe_policy ? pipe : queue;
+
+	return ((cond % 2) != 0);
 
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
index 786eb4aa7314..671d4b37c397 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
@@ -374,7 +374,7 @@ void amdgpu_queue_mask_bit_to_mec_queue(struct amdgpu_device *adev, int bit,
 bool amdgpu_gfx_is_mec_queue_enabled(struct amdgpu_device *adev, int mec,
 				     int pipe, int queue);
 bool amdgpu_gfx_is_high_priority_compute_queue(struct amdgpu_device *adev,
-					       int queue);
+					       int pipe, int queue);
 int amdgpu_gfx_me_queue_to_bit(struct amdgpu_device *adev, int me,
 			       int pipe, int queue);
 void amdgpu_gfx_bit_to_me_queue(struct amdgpu_device *adev, int bit,
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 8c3bad3dfc01..da5a139c7022 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -4472,7 +4472,8 @@ static int gfx_v10_0_compute_ring_init(struct amdgpu_device *adev, int ring_id,
 	irq_type = AMDGPU_CP_IRQ_COMPUTE_MEC1_PIPE0_EOP
 		+ ((ring->me - 1) * adev->gfx.mec.num_pipe_per_mec)
 		+ ring->pipe;
-	hw_prio = amdgpu_gfx_is_high_priority_compute_queue(adev, ring->queue) ?
+	hw_prio = amdgpu_gfx_is_high_priority_compute_queue(adev, ring->pipe,
+							    ring->queue) ?
 			AMDGPU_GFX_PIPE_PRIO_HIGH : AMDGPU_GFX_PIPE_PRIO_NORMAL;
 	/* type-2 packets are deprecated on MEC, use type-3 instead */
 	r = amdgpu_ring_init(adev, ring, 1024,
@@ -6507,7 +6508,8 @@ static void gfx_v10_0_compute_mqd_set_priority(struct amdgpu_ring *ring, struct
 	struct amdgpu_device *adev = ring->adev;
 
 	if (ring->funcs->type == AMDGPU_RING_TYPE_COMPUTE) {
-		if (amdgpu_gfx_is_high_priority_compute_queue(adev, ring->queue)) {
+		if (amdgpu_gfx_is_high_priority_compute_queue(adev, ring->pipe,
+							      ring->queue)) {
 			mqd->cp_hqd_pipe_priority = AMDGPU_GFX_PIPE_PRIO_HIGH;
 			mqd->cp_hqd_queue_priority =
 				AMDGPU_GFX_QUEUE_PRIORITY_MAXIMUM;
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
index c3fff49e6514..5e6d15f44560 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
@@ -1923,7 +1923,8 @@ static int gfx_v8_0_compute_ring_init(struct amdgpu_device *adev, int ring_id,
 		+ ((ring->me - 1) * adev->gfx.mec.num_pipe_per_mec)
 		+ ring->pipe;
 
-	hw_prio = amdgpu_gfx_is_high_priority_compute_queue(adev, ring->queue) ?
+	hw_prio = amdgpu_gfx_is_high_priority_compute_queue(adev, ring->pipe,
+							    ring->queue) ?
 			AMDGPU_GFX_PIPE_PRIO_HIGH : AMDGPU_RING_PRIO_DEFAULT;
 	/* type-2 packets are deprecated on MEC, use type-3 instead */
 	r = amdgpu_ring_init(adev, ring, 1024,
@@ -4441,7 +4442,8 @@ static void gfx_v8_0_mqd_set_priority(struct amdgpu_ring *ring, struct vi_mqd *m
 	struct amdgpu_device *adev = ring->adev;
 
 	if (ring->funcs->type == AMDGPU_RING_TYPE_COMPUTE) {
-		if (amdgpu_gfx_is_high_priority_compute_queue(adev, ring->queue)) {
+		if (amdgpu_gfx_is_high_priority_compute_queue(adev, ring->pipe,
+							      ring->queue)) {
 			mqd->cp_hqd_pipe_priority = AMDGPU_GFX_PIPE_PRIO_HIGH;
 			mqd->cp_hqd_queue_priority =
 				AMDGPU_GFX_QUEUE_PRIORITY_MAXIMUM;
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 3d6fb5a514c8..5d53baadd6f5 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -2228,7 +2228,8 @@ static int gfx_v9_0_compute_ring_init(struct amdgpu_device *adev, int ring_id,
 	irq_type = AMDGPU_CP_IRQ_COMPUTE_MEC1_PIPE0_EOP
 		+ ((ring->me - 1) * adev->gfx.mec.num_pipe_per_mec)
 		+ ring->pipe;
-	hw_prio = amdgpu_gfx_is_high_priority_compute_queue(adev, ring->queue) ?
+	hw_prio = amdgpu_gfx_is_high_priority_compute_queue(adev, ring->pipe,
+							    ring->queue) ?
 			AMDGPU_GFX_PIPE_PRIO_HIGH : AMDGPU_GFX_PIPE_PRIO_NORMAL;
 	/* type-2 packets are deprecated on MEC, use type-3 instead */
 	return amdgpu_ring_init(adev, ring, 1024,
@@ -3383,7 +3384,9 @@ static void gfx_v9_0_mqd_set_priority(struct amdgpu_ring *ring, struct v9_mqd *m
 	struct amdgpu_device *adev = ring->adev;
 
 	if (ring->funcs->type == AMDGPU_RING_TYPE_COMPUTE) {
-		if (amdgpu_gfx_is_high_priority_compute_queue(adev, ring->queue)) {
+		if (amdgpu_gfx_is_high_priority_compute_queue(adev,
+							      ring->pipe,
+							      ring->queue)) {
 			mqd->cp_hqd_pipe_priority = AMDGPU_GFX_PIPE_PRIO_HIGH;
 			mqd->cp_hqd_queue_priority =
 				AMDGPU_GFX_QUEUE_PRIORITY_MAXIMUM;
-- 
2.29.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
