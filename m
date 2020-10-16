Return-Path: <SRS0=ko+j=DX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C040FC433E7
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Oct 2020 15:34:27 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E314207C4
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Oct 2020 15:34:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="MfGwjYZq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E314207C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 85AC46E3C6;
	Fri, 16 Oct 2020 15:34:26 +0000 (UTC)
Received: from NAM04-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr690066.outbound.protection.outlook.com [40.107.69.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 572A06E3C6
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Oct 2020 15:34:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cZ8pUqcXPOcwtN0pYR0O4biWMdhSvUWVczb1FdENA1qEcNoyNXC7T3rfozvXbdhbEoC/Mg3DmujbIIY6i7O0KKg//1JS+Fdh/ppPlf1JbRbyERhjTjb4qt+K14Lfa4A+DKI/Pnnzwqg6V8MK0midAP7AigW4BGFj1Oq40fD5wbGX1Vp+Jraqvzolp0J/cgrl6/eTZeOfzGnhemCDk4pY5MsxQlSLPoBcspv9/+SyaIgK018AkL7OED/QB+FKrq5B7EwSezbTWYlv3yeV+H8N3aaFU0ipiV2i4Liu8LZ7wZfMBu5CbuLYjgjGSmJCPewtjyBhhdqov3RnMnZBBEinIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AocIQXOJb3VTrVXKuPX5PVtn9J4D+/5rjU81iaBQurg=;
 b=bYC0Zj0Ewq5H2RvisRVpRCs+XheBSM0nPKbhVbwIHoFocAkdR2bSw6zyPHR3jbTMuQRJZ9KItqks+6Yu/ovu7eecnJoQa3/PugrbZixBQFMvXd5z4G7KqL7Zj0bNoGOO/EgmRGBa3PPpvu688wVBEwjSetdlGBC8L3IPmqr2Aqs3ekCTcvXymOLNQ4TEtnAJ5Wq8DC3Bkc9I/u+IcGuHzZdLrMuzGU0KvWVl7ccGwsh3Lo/MkZ2hwjNpNVAnZx2rXr1XxsGnCswANiKnysLYxaesgZCB7f5P2aaSv5XbcGUUwVj6vs+yvLehEqcnejwWvbFkkByteoT+8pvqGBXeKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AocIQXOJb3VTrVXKuPX5PVtn9J4D+/5rjU81iaBQurg=;
 b=MfGwjYZqfuhj8j7LUADy31YSkOpoJltpSVFIN3fZ55zI8mx4LDbAHpmMoKBlLajcB39xP/F4odPs5Jfik7q2fkuf4ToOiQuIeFgsDu6f6xn5VNTZedX6dxcxqB3130Qh3WkC5K8YE4Ma8IXO1O6FpD2b1i2NIkbBMAYVozbyRPI=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3916.namprd12.prod.outlook.com (2603:10b6:5:1ca::21)
 by DM6PR12MB4236.namprd12.prod.outlook.com (2603:10b6:5:212::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.23; Fri, 16 Oct
 2020 15:34:24 +0000
Received: from DM6PR12MB3916.namprd12.prod.outlook.com
 ([fe80::5c29:f133:1209:b74d]) by DM6PR12MB3916.namprd12.prod.outlook.com
 ([fe80::5c29:f133:1209:b74d%6]) with mapi id 15.20.3477.024; Fri, 16 Oct 2020
 15:34:23 +0000
From: Nirmoy Das <nirmoy.das@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/1] drm/amdgpu: fix compute queue priority if num_kcq is less
 than 4
Date: Fri, 16 Oct 2020 17:34:02 +0200
Message-Id: <20201016153402.36515-1-nirmoy.das@amd.com>
X-Mailer: git-send-email 2.28.0
X-Originating-IP: [165.204.84.11]
X-ClientProxiedBy: BN8PR03CA0033.namprd03.prod.outlook.com
 (2603:10b6:408:94::46) To DM6PR12MB3916.namprd12.prod.outlook.com
 (2603:10b6:5:1ca::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from brihaspati.amd.com (165.204.84.11) by
 BN8PR03CA0033.namprd03.prod.outlook.com (2603:10b6:408:94::46) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3477.21 via Frontend Transport; Fri, 16 Oct 2020 15:34:22 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 7c2fbadd-9f04-4156-9c85-08d871e8f54a
X-MS-TrafficTypeDiagnostic: DM6PR12MB4236:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB42367CEA710190E29E5A2CFC8B030@DM6PR12MB4236.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3173;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4PR9yLRWSJr1j8DIo9JO1J6IDKWQUs6KaGylVH70ow8+BWpnYJJYIXJCLOeyjb+JFi3cK53v2M8RN5Do64dNQNUN7UIRXPD3LCjrCXTf6jIVY83OXRPveqYIKONXFFK44KktkKqwrL9XTGDJIPtqJrK/NxcnX5RaFddKyqLJYHZ5aRoemfYndQatj3hRt7YE3MbUwBqR/ZusqkbjndRsNCsdo8y07AOG5Xqb4aw2iqew3FOGQNjxjVDd1QZmxTW2hPINpmYqkAbPMn/afwBzei+CNLzoe+q6QUYIPXnH6iduELSqoRqNI7NAk8YQLTMNfZWmjpU2JQpCiUBKaytIe1rWgUX9ywACax3BTz3vjrjYOGxXc9tepGc6nRt8AaBm
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3916.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(396003)(346002)(39860400002)(366004)(376002)(186003)(52116002)(26005)(44832011)(6486002)(7696005)(83380400001)(36756003)(2616005)(34490700002)(956004)(86362001)(316002)(4326008)(6666004)(66946007)(66476007)(66556008)(8676002)(1076003)(5660300002)(6916009)(478600001)(8936002)(16526019)(2906002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: wY6p9hnyTj0XzxDjZ1NaV9YyudbQkgbw8gR+P3IQuOHszSAkxTehR20FNRs+tj8kwf22E05rW1gXK+9PceSzYbRC41L0zca3Vd8gRZ1NV3okkbzbYsQBsZPsN49tK2M5h0YigrCREPgLpI+trFAYUsWnZBh0H5cAP07+BVaKUz2H4J65iVhdbDKwOxc7JrZS4NEmkQtcGG25cnZKOvPAk2qKFtXgY+cGkWidTEP7Q26o8xHenbfBXIKrrwUkkJYC9HDvx+q93FDlgRNWCqWkTUGBdWKZR0DlyJhHRQ0tEMeyKuBFLpYXf8coAnf4T/rAyib+FkW4h7lqpbjB9VEWRFdjr+2MX0lF7HiQOSnTubMVr2t9Y92cUDxsFKkqpVUk/g5ZRhe6jqGLGv+VN5f11LNEB7qpGNJ95HkP/t1ii0IKy8DifP0PapQmj4d2Bn8Oxtl1NTH7gwE3KL7ujh+sV6ka2BOGOF+/cBmn9Wn1XDRl0sjPrpdDt4ofODQ8fHwYxqP1nd+L66odSPV0xxbOF5PmGs78Rvryjl1NQM9ErnOff/Z03ZQzLpd0NUzA6uIGBE/5A1nHtygZelnhbGkMngtF3a9RxaeFTucWjs9fKr4x2U6CLzFs9NvTpDyTaHKcRCf8dvDrhvkh5oTLfbZC0g==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c2fbadd-9f04-4156-9c85-08d871e8f54a
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3916.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2020 15:34:23.7662 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /fyTJAs4tn9uXzFCcRvBODifge+ql2RSgp+B2jHF25YtZnuTwQqbduoM83npMks19Z2aGhQweN9AqyJSRDl+Mg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4236
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
Cc: alexander.deucher@amd.com, Nirmoy Das <nirmoy.das@amd.com>,
 Christian.Koenig@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Compute queues are configurable with module param, num_kcq.
amdgpu_gfx_is_high_priority_compute_queue was setting 1st 4 queues to
high priority queue leaving a null drm scheduler in
adev->gpu_sched[hw_ip]["normal_prio"].sched if num_kcq < 5

Fixes: 33abcb1f5a1719b1c (drm/amdgpu: set compute queue priority at mqd_init)

Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 6 +++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h | 2 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c  | 4 ++--
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c   | 4 ++--
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c   | 4 ++--
 5 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index 8c9bacfdbc30..56d384656c45 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -193,10 +193,10 @@ static bool amdgpu_gfx_is_multipipe_capable(struct amdgpu_device *adev)
 }

 bool amdgpu_gfx_is_high_priority_compute_queue(struct amdgpu_device *adev,
-					       int queue)
+					       int pipe)
 {
-	/* Policy: make queue 0 of each pipe as high priority compute queue */
-	return (queue == 0);
+	/* Policy: even pipe num = normal priority, odd pipe num = high priority */
+	return ((pipe % 2) != 0);

 }

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
index 190753930b11..b167ebb6385d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
@@ -374,7 +374,7 @@ void amdgpu_queue_mask_bit_to_mec_queue(struct amdgpu_device *adev, int bit,
 bool amdgpu_gfx_is_mec_queue_enabled(struct amdgpu_device *adev, int mec,
 				     int pipe, int queue);
 bool amdgpu_gfx_is_high_priority_compute_queue(struct amdgpu_device *adev,
-					       int queue);
+					       int pipe);
 int amdgpu_gfx_me_queue_to_bit(struct amdgpu_device *adev, int me,
 			       int pipe, int queue);
 void amdgpu_gfx_bit_to_me_queue(struct amdgpu_device *adev, int bit,
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index e42542e564f7..e39737680017 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -4465,7 +4465,7 @@ static int gfx_v10_0_compute_ring_init(struct amdgpu_device *adev, int ring_id,
 	irq_type = AMDGPU_CP_IRQ_COMPUTE_MEC1_PIPE0_EOP
 		+ ((ring->me - 1) * adev->gfx.mec.num_pipe_per_mec)
 		+ ring->pipe;
-	hw_prio = amdgpu_gfx_is_high_priority_compute_queue(adev, ring->queue) ?
+	hw_prio = amdgpu_gfx_is_high_priority_compute_queue(adev, ring->pipe) ?
 			AMDGPU_GFX_PIPE_PRIO_HIGH : AMDGPU_GFX_PIPE_PRIO_NORMAL;
 	/* type-2 packets are deprecated on MEC, use type-3 instead */
 	r = amdgpu_ring_init(adev, ring, 1024,
@@ -6498,7 +6498,7 @@ static void gfx_v10_0_compute_mqd_set_priority(struct amdgpu_ring *ring, struct
 	struct amdgpu_device *adev = ring->adev;

 	if (ring->funcs->type == AMDGPU_RING_TYPE_COMPUTE) {
-		if (amdgpu_gfx_is_high_priority_compute_queue(adev, ring->queue)) {
+		if (amdgpu_gfx_is_high_priority_compute_queue(adev, ring->pipe)) {
 			mqd->cp_hqd_pipe_priority = AMDGPU_GFX_PIPE_PRIO_HIGH;
 			mqd->cp_hqd_queue_priority =
 				AMDGPU_GFX_QUEUE_PRIORITY_MAXIMUM;
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
index d5843e8a6e17..ada54a96c676 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
@@ -1915,7 +1915,7 @@ static int gfx_v8_0_compute_ring_init(struct amdgpu_device *adev, int ring_id,
 		+ ((ring->me - 1) * adev->gfx.mec.num_pipe_per_mec)
 		+ ring->pipe;

-	hw_prio = amdgpu_gfx_is_high_priority_compute_queue(adev, ring->queue) ?
+	hw_prio = amdgpu_gfx_is_high_priority_compute_queue(adev, ring->pipe) ?
 			AMDGPU_GFX_PIPE_PRIO_HIGH : AMDGPU_RING_PRIO_DEFAULT;
 	/* type-2 packets are deprecated on MEC, use type-3 instead */
 	r = amdgpu_ring_init(adev, ring, 1024,
@@ -4433,7 +4433,7 @@ static void gfx_v8_0_mqd_set_priority(struct amdgpu_ring *ring, struct vi_mqd *m
 	struct amdgpu_device *adev = ring->adev;

 	if (ring->funcs->type == AMDGPU_RING_TYPE_COMPUTE) {
-		if (amdgpu_gfx_is_high_priority_compute_queue(adev, ring->queue)) {
+		if (amdgpu_gfx_is_high_priority_compute_queue(adev, ring->pipe)) {
 			mqd->cp_hqd_pipe_priority = AMDGPU_GFX_PIPE_PRIO_HIGH;
 			mqd->cp_hqd_queue_priority =
 				AMDGPU_GFX_QUEUE_PRIORITY_MAXIMUM;
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 0d8e203b10ef..94cfaeebb7d1 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -2228,7 +2228,7 @@ static int gfx_v9_0_compute_ring_init(struct amdgpu_device *adev, int ring_id,
 	irq_type = AMDGPU_CP_IRQ_COMPUTE_MEC1_PIPE0_EOP
 		+ ((ring->me - 1) * adev->gfx.mec.num_pipe_per_mec)
 		+ ring->pipe;
-	hw_prio = amdgpu_gfx_is_high_priority_compute_queue(adev, ring->queue) ?
+	hw_prio = amdgpu_gfx_is_high_priority_compute_queue(adev, ring->pipe) ?
 			AMDGPU_GFX_PIPE_PRIO_HIGH : AMDGPU_GFX_PIPE_PRIO_NORMAL;
 	/* type-2 packets are deprecated on MEC, use type-3 instead */
 	return amdgpu_ring_init(adev, ring, 1024,
@@ -3383,7 +3383,7 @@ static void gfx_v9_0_mqd_set_priority(struct amdgpu_ring *ring, struct v9_mqd *m
 	struct amdgpu_device *adev = ring->adev;

 	if (ring->funcs->type == AMDGPU_RING_TYPE_COMPUTE) {
-		if (amdgpu_gfx_is_high_priority_compute_queue(adev, ring->queue)) {
+		if (amdgpu_gfx_is_high_priority_compute_queue(adev, ring->pipe)) {
 			mqd->cp_hqd_pipe_priority = AMDGPU_GFX_PIPE_PRIO_HIGH;
 			mqd->cp_hqd_queue_priority =
 				AMDGPU_GFX_QUEUE_PRIORITY_MAXIMUM;
--
2.28.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
