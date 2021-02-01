Return-Path: <SRS0=/n0Y=HD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 249A2C433E0
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Feb 2021 12:07:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CBC2364E2A
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Feb 2021 12:07:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBC2364E2A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2C34789F89;
	Mon,  1 Feb 2021 12:07:52 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2080.outbound.protection.outlook.com [40.107.220.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 054B089F89
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Feb 2021 12:07:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jrgvgZh09i33t85z3BpmH+zi2DLY1bSxzVGf0oxPuAVs3YcIGoAX0s2y02CLT1jx7Pg4bLRThxqbGfcXkPi2J623JKPgVfnoz/CjqpV2khXIAoRgARPMBLihFdCF+2CrL4ukWhb47ROsjv1/VWFoXDwtn+MR+d9yfD0qx6qeDl3apbeTru1ScFWJeRDhTnfA+esDxHihiW7OS4XCgNhLPJN6rzIbRfwIcbNShajChZNbWKQulM1WOTpHYxFbdxnMHHbMYoan6GMnpaCwR+H0LdNQF7HuWzIlLI0KIz9FngrOOWDeEYFUxnYRtsIySKULTyHSF/Z7cr5AnW6vLI+6tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E2Ib8KTJ2FAPABrNO91oEZzQuOirDjNjn8Ld+QFWkYI=;
 b=aIP7ub8lN2VX40yZNa3fGctHqtaCo+ZZvPjFoRv2QrChwvIvuTBwvKGQ+2bHQlZ0K5I4If1rDgjEwNJz3jXvKnXeLq5eLbh8OLlQLpvGDgGDYnYUZ0Vl+GHeI5l6UdXS5B8jXTV/zjAsEJcT6ZsXZAEGJ9H6irEDU47gjxDM2MYlhwSHrJUUxX4vWwGpL443VkVxRKb2iXgdL2Grq8hCz0Ji/hjEWgZDGG9jKw5unVPv4LNNjn+8LAdOoqHPF5ToE46EX0UpvZIsyfC0j8SqM5n+2x0c+FwBtnw0gtmuTcegwcbHh3MXIljZnetTZPwvgLO99TpEPuJnp3HMqmpg0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E2Ib8KTJ2FAPABrNO91oEZzQuOirDjNjn8Ld+QFWkYI=;
 b=Mq7+lVYUEhseFuzRC2tRNJPITwhwDSqZEcUYIsFW3/Gx+afKeqRfRHVUfPdHeinkWsx9FAcdfakVB0e9lSdD5deVUXHNcC5jxpAkxQeZQdsyqAdEAeRnHuBiHlrmH/NYEZaQ6cn9aP9j5WktReZl2S5TjlVijBhosN1L+A2SrNc=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3916.namprd12.prod.outlook.com (2603:10b6:5:1ca::21)
 by DM5PR12MB2454.namprd12.prod.outlook.com (2603:10b6:4:ba::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.24; Mon, 1 Feb
 2021 12:07:49 +0000
Received: from DM6PR12MB3916.namprd12.prod.outlook.com
 ([fe80::f872:3677:28c3:660b]) by DM6PR12MB3916.namprd12.prod.outlook.com
 ([fe80::f872:3677:28c3:660b%5]) with mapi id 15.20.3805.027; Mon, 1 Feb 2021
 12:07:49 +0000
From: Nirmoy Das <nirmoy.das@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/3] drm/amdgpu: Enable only one high prio compute queue
Date: Mon,  1 Feb 2021 13:07:33 +0100
Message-Id: <20210201120735.2970-1-nirmoy.das@amd.com>
X-Mailer: git-send-email 2.30.0
X-Originating-IP: [93.229.32.223]
X-ClientProxiedBy: AM0PR05CA0087.eurprd05.prod.outlook.com
 (2603:10a6:208:136::27) To DM6PR12MB3916.namprd12.prod.outlook.com
 (2603:10b6:5:1ca::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from brihaspati.fritz.box (93.229.32.223) by
 AM0PR05CA0087.eurprd05.prod.outlook.com (2603:10a6:208:136::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.17 via Frontend
 Transport; Mon, 1 Feb 2021 12:07:47 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 95c62843-280a-4d69-639a-08d8c6a9fe07
X-MS-TrafficTypeDiagnostic: DM5PR12MB2454:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB245420876AD323F5CB6B590F8BB69@DM5PR12MB2454.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:568;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6AaKjlOoX/Iz/pvdwAawLcvut15gAivKWyGV0EPTeMw/5/NmKdCgB3zLJoEo60UQogV+VHdaXatAKFdc3+2q56wwzSY8OPNKYv8atXWrCIi82i/PSi+XOEj+7gEXiItDA3impeDapN+E2lmjNg+JqJ6QJtfLZLP473zLBRvicNZF9Sn3TmZJ8be12AIs3ddIhsrCp4Eumtvn0+8GQzFUvEwBy1i8RlUBG2j8vJQWhSOCqMNQsFFupveTalMzUtRI3TjYWQjmB4gX4rbcWEK6IMH7NDcUGr3nmCfx2VD1uk/DIyi3yfQBvI+bk8lludM4/LFOWU2UJGsggWWoExStCe+SOQCaxr+9839KnwrRAz4s5CGxsW+YQTEedqs+GB0M+SaiAcoubFM6zFx9TIPpfNBLuPFB5SNy3s7cSmSNuWhFuSJQ38/l+WMEAT/CiR2MQ0ZYlP0aq/TtIq7zmu3LsDZ8I9YZiJdIXAlFZF89BhLvYnx72LOHhwpgdd1P5vauQ8SESlbC47pl9yMWn462Pw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3916.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(376002)(346002)(136003)(396003)(39860400002)(52116002)(5660300002)(1076003)(6486002)(316002)(66556008)(6666004)(66946007)(6512007)(66476007)(6916009)(16526019)(2616005)(956004)(26005)(6506007)(86362001)(36756003)(478600001)(44832011)(4326008)(2906002)(83380400001)(186003)(8936002)(8676002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?QLNSs7j+mRz2lnq0TnKJ7355ZmqnwmRNomn5i3rKq3rajuKb5uXCe70ZRLyB?=
 =?us-ascii?Q?gDl/JU+80lQHIrRBu6pV+dxnDYKKVyI2mTS/82gVc8YHynZS3L6glY5Slu98?=
 =?us-ascii?Q?p7DUI1s5WAOPpDssz2nhMqGntsSyxaj0fcLeNXu2xcaQ+m3f0lPggKodnhLt?=
 =?us-ascii?Q?X7s3HYApzC67makn4sCFa4/5ore1rMvEYOuHcD8h1johwEco48oedLI7uk+r?=
 =?us-ascii?Q?EOt0s4rpBGULyjekX83BQj3BvfuzGPnHOcKH/jIdXfMMgnaDmdAibxx4Lye8?=
 =?us-ascii?Q?aUoWCE2/FGz8se5kteDN7jFy+uRoshJXnY8eFci7qHn7VwrpbWA1oYmOkE+d?=
 =?us-ascii?Q?667TunskkIAn/vL3X2r9U2E5+yHQggdec86JZk9+t2P5WMsy/PSFcDs6XcWD?=
 =?us-ascii?Q?ZdGELXElGaLwQe3FML3sUeNOEghwxKPsvKIxLicyJHYHV/OlAy1jOI4LrRs0?=
 =?us-ascii?Q?+cWwEZaXaLQWsZy5L7HPVVxS8C9Rd8HAfvpC3JslXX6ep9UlGCvc5rXq0OpI?=
 =?us-ascii?Q?Rnn5nebj3vJNnXaKX4kJIjDvk+Pp57gjfEdFZ6AFpWPf5Mfd05DX+dWggme+?=
 =?us-ascii?Q?KB3iFePLXxQdKRWdPxbRSy0FswyiT8eZwBXeJx1SkxnDIX4NML0pjPwuE7QO?=
 =?us-ascii?Q?HM4qBD31kKRH3LDbWr2+SRN0ngyMBLFFJZJfIqp+tWbqGDDeH6uYZye57/NL?=
 =?us-ascii?Q?/8JCQ5SvhNshuyJDZ15c6OX67RBB1TLBzL5w4q2CWULz1w0PEJSFHhnJabmX?=
 =?us-ascii?Q?4ICxg9wEB4qcg0gAkTI2lWSsl1ZsrwfqZAORj+m1GqqKaB05NNBrWF24OS4x?=
 =?us-ascii?Q?s2p/uYA5G2xZLii5a/q3BzeUabhRpyM7u1HsGpYiCy1+H1ugOmoLSr43iEIX?=
 =?us-ascii?Q?t5BHfV8SaFCQ9yaiym9+1CajgtOxAnZT4eS+uSiZSIRBF7q7cDKH9V7Y8/66?=
 =?us-ascii?Q?n/fOi3J5l931Jz4Z0sZbzKj2Rnd+eT3ugnF5aC7UX41EaDwrZE2XdOl4/UtD?=
 =?us-ascii?Q?CuG/38GNiyaUJRaWQeWKUO/ZlaGAZhqQQd7YULfzzlQIMvmimJfS8py4NwLG?=
 =?us-ascii?Q?Mepb4772?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95c62843-280a-4d69-639a-08d8c6a9fe07
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3916.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2021 12:07:48.9383 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IbN63wWFrBn0Gjtt9E+6QDJEGUTO8XE7Jqb6Z56Y70H6VRCQoVlpGlxSexqOtRZNHqap3P/ol9S7vvgisYDEZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2454
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
Cc: Alan.Harrison@amd.com, Felix.Kuehling@amd.com,
 Nirmoy Das <nirmoy.das@amd.com>, ray.huang@amd.com, Alexander.Deucher@amd.com,
 Christian.Koenig@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

For high priority compute to work properly we need to enable
wave limiting on gfx pipe. Wave limiting is done through writing
into mmSPI_WCL_PIPE_PERCENT_GFX register. Enable only one high
priority compute queue to avoid race condition between multiple
high priority compute queues writing that register simultaneously.

Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 15 ++++++++-------
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h |  2 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c  |  6 ++----
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c   |  6 ++----
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c   |  7 ++-----
 5 files changed, 15 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index cd2c676a2797..8e0a6c62322e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -193,15 +193,16 @@ static bool amdgpu_gfx_is_multipipe_capable(struct amdgpu_device *adev)
 }
 
 bool amdgpu_gfx_is_high_priority_compute_queue(struct amdgpu_device *adev,
-					       int pipe, int queue)
+					       struct amdgpu_ring *ring)
 {
-	bool multipipe_policy = amdgpu_gfx_is_multipipe_capable(adev);
-	int cond;
-	/* Policy: alternate between normal and high priority */
-	cond = multipipe_policy ? pipe : queue;
-
-	return ((cond % 2) != 0);
+	/* Policy: use 1st queue as high priority compute queue if we
+	 * have more than one compute queue.
+	 */
+	if (adev->gfx.num_compute_rings > 1 &&
+	    ring == &adev->gfx.compute_ring[0])
+		return true;
 
+	return false;
 }
 
 void amdgpu_gfx_compute_queue_acquire(struct amdgpu_device *adev)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
index 6b5a8f4642cc..72dbcd2bc6a6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
@@ -380,7 +380,7 @@ void amdgpu_queue_mask_bit_to_mec_queue(struct amdgpu_device *adev, int bit,
 bool amdgpu_gfx_is_mec_queue_enabled(struct amdgpu_device *adev, int mec,
 				     int pipe, int queue);
 bool amdgpu_gfx_is_high_priority_compute_queue(struct amdgpu_device *adev,
-					       int pipe, int queue);
+					       struct amdgpu_ring *ring);
 int amdgpu_gfx_me_queue_to_bit(struct amdgpu_device *adev, int me,
 			       int pipe, int queue);
 void amdgpu_gfx_bit_to_me_queue(struct amdgpu_device *adev, int bit,
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 426a217ce83f..0987890d3e51 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -4487,8 +4487,7 @@ static int gfx_v10_0_compute_ring_init(struct amdgpu_device *adev, int ring_id,
 	irq_type = AMDGPU_CP_IRQ_COMPUTE_MEC1_PIPE0_EOP
 		+ ((ring->me - 1) * adev->gfx.mec.num_pipe_per_mec)
 		+ ring->pipe;
-	hw_prio = amdgpu_gfx_is_high_priority_compute_queue(adev, ring->pipe,
-							    ring->queue) ?
+	hw_prio = amdgpu_gfx_is_high_priority_compute_queue(adev, ring) ?
 			AMDGPU_GFX_PIPE_PRIO_HIGH : AMDGPU_GFX_PIPE_PRIO_NORMAL;
 	/* type-2 packets are deprecated on MEC, use type-3 instead */
 	r = amdgpu_ring_init(adev, ring, 1024,
@@ -6530,8 +6529,7 @@ static void gfx_v10_0_compute_mqd_set_priority(struct amdgpu_ring *ring, struct
 	struct amdgpu_device *adev = ring->adev;
 
 	if (ring->funcs->type == AMDGPU_RING_TYPE_COMPUTE) {
-		if (amdgpu_gfx_is_high_priority_compute_queue(adev, ring->pipe,
-							      ring->queue)) {
+		if (amdgpu_gfx_is_high_priority_compute_queue(adev, ring)) {
 			mqd->cp_hqd_pipe_priority = AMDGPU_GFX_PIPE_PRIO_HIGH;
 			mqd->cp_hqd_queue_priority =
 				AMDGPU_GFX_QUEUE_PRIORITY_MAXIMUM;
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
index 37639214cbbb..b0284c4659ba 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
@@ -1923,8 +1923,7 @@ static int gfx_v8_0_compute_ring_init(struct amdgpu_device *adev, int ring_id,
 		+ ((ring->me - 1) * adev->gfx.mec.num_pipe_per_mec)
 		+ ring->pipe;
 
-	hw_prio = amdgpu_gfx_is_high_priority_compute_queue(adev, ring->pipe,
-							    ring->queue) ?
+	hw_prio = amdgpu_gfx_is_high_priority_compute_queue(adev, ring) ?
 			AMDGPU_GFX_PIPE_PRIO_HIGH : AMDGPU_RING_PRIO_DEFAULT;
 	/* type-2 packets are deprecated on MEC, use type-3 instead */
 	r = amdgpu_ring_init(adev, ring, 1024,
@@ -4442,8 +4441,7 @@ static void gfx_v8_0_mqd_set_priority(struct amdgpu_ring *ring, struct vi_mqd *m
 	struct amdgpu_device *adev = ring->adev;
 
 	if (ring->funcs->type == AMDGPU_RING_TYPE_COMPUTE) {
-		if (amdgpu_gfx_is_high_priority_compute_queue(adev, ring->pipe,
-							      ring->queue)) {
+		if (amdgpu_gfx_is_high_priority_compute_queue(adev, ring)) {
 			mqd->cp_hqd_pipe_priority = AMDGPU_GFX_PIPE_PRIO_HIGH;
 			mqd->cp_hqd_queue_priority =
 				AMDGPU_GFX_QUEUE_PRIORITY_MAXIMUM;
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index a896e3d0fcf8..7b13f9dd965a 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -2227,8 +2227,7 @@ static int gfx_v9_0_compute_ring_init(struct amdgpu_device *adev, int ring_id,
 	irq_type = AMDGPU_CP_IRQ_COMPUTE_MEC1_PIPE0_EOP
 		+ ((ring->me - 1) * adev->gfx.mec.num_pipe_per_mec)
 		+ ring->pipe;
-	hw_prio = amdgpu_gfx_is_high_priority_compute_queue(adev, ring->pipe,
-							    ring->queue) ?
+	hw_prio = amdgpu_gfx_is_high_priority_compute_queue(adev, ring) ?
 			AMDGPU_GFX_PIPE_PRIO_HIGH : AMDGPU_GFX_PIPE_PRIO_NORMAL;
 	/* type-2 packets are deprecated on MEC, use type-3 instead */
 	return amdgpu_ring_init(adev, ring, 1024,
@@ -3390,9 +3389,7 @@ static void gfx_v9_0_mqd_set_priority(struct amdgpu_ring *ring, struct v9_mqd *m
 	struct amdgpu_device *adev = ring->adev;
 
 	if (ring->funcs->type == AMDGPU_RING_TYPE_COMPUTE) {
-		if (amdgpu_gfx_is_high_priority_compute_queue(adev,
-							      ring->pipe,
-							      ring->queue)) {
+		if (amdgpu_gfx_is_high_priority_compute_queue(adev, ring)) {
 			mqd->cp_hqd_pipe_priority = AMDGPU_GFX_PIPE_PRIO_HIGH;
 			mqd->cp_hqd_queue_priority =
 				AMDGPU_GFX_QUEUE_PRIORITY_MAXIMUM;
-- 
2.30.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
