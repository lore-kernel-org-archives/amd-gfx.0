Return-Path: <SRS0=7mEa=IH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 408C4C433DB
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Mar 2021 16:20:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F0C7A64FE3
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Mar 2021 16:20:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0C7A64FE3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 92E7A6E90B;
	Tue,  9 Mar 2021 16:20:25 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2076.outbound.protection.outlook.com [40.107.92.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 27BDD6E90B
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 Mar 2021 16:20:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QwfoCP3GwrslISffm+iF8AHX6eZSYuwS3BoTS4z0YQwQP6UpymrVS4/R3GEGK9aYIn4L94vJ1Esjm8lDt/QPP32VzQKYbvT7XSvhJzgdpnqZXi0mPI6SAvmKLurwNj4bJDy6CXhkQdzYVNu5QcyIZJt7CeHnljb9h06inKEZegPIumNlfg7UZOTy7GOSfQboZWsqZ9M4Zw/yCXNFkArMmrhWvSZAZ4y0SPA0ydGlIv7Ds6jb9oFVkreTQhmJNCzricgX5oeJNpXnWY45JtXZPg9Amm5iE3xE1GtNNfk/ixACNthTlm3YuiCrh/GKovNxH5Hqk+piaL1bz/BEclvjNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jLPlg7CUHZNH1d54NdFpyBOL3t9a0OfdcxmXhtkhI+w=;
 b=ckbW5orqitxfWkAtpsrekyk0F5b7iEBKd5XkS4qBbsdqslYNmHvNi5FgscK0iveuQvrhV2o1sMKjxdzf9ftdD5wPw0sLxCO5MdoLxXT9W/ulWxdMFrJduKzXX0iv8UZCspw8ztXjoKzDBvqkmtRqqeKONLWtHJZfB988PM6iqJlji1OOUcCXfIKnfAlpjvnXbOZivOTGHTNCsCnoGwS1Z1tvo7LdefBPYMK3IhUkZ6M3vT9MmWsqOzSF4gMEbwiDIS2mS9GCakY5f6uy7g3AN4ElDJ+3lozsOVaWDWWSQlzyEdnQDh9EZetx+2D8hP4NVZhfSUvhL1GadGx4a0LoqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jLPlg7CUHZNH1d54NdFpyBOL3t9a0OfdcxmXhtkhI+w=;
 b=jeQIR0q7xyPfSu/3W8gpzFqPhLfLD8CeG9CxAi2fkaxwI87Cl5m4Nz8RNaPfmlDLRpXszm7Gl/b6q6gRrqQvCzuWM5SC4tYQ2XgVuwcfcO18/D9lG0jI5LExA1VDoAHG89PhN8xHYC+c8sDHEfmsKJw8E1HHjKLh3s7prP6ZUls=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB4680.namprd12.prod.outlook.com (2603:10b6:4:a6::33) by
 DM5PR1201MB0217.namprd12.prod.outlook.com (2603:10b6:4:54::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3912.27; Tue, 9 Mar 2021 16:20:21 +0000
Received: from DM5PR12MB4680.namprd12.prod.outlook.com
 ([fe80::b193:3bb1:c6d8:aeec]) by DM5PR12MB4680.namprd12.prod.outlook.com
 ([fe80::b193:3bb1:c6d8:aeec%3]) with mapi id 15.20.3890.038; Tue, 9 Mar 2021
 16:20:21 +0000
From: Jonathan Kim <jonathan.kim@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: add ih waiter on process until checkpoint
Date: Tue,  9 Mar 2021 11:19:11 -0500
Message-Id: <20210309161911.45133-1-jonathan.kim@amd.com>
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.55.251]
X-ClientProxiedBy: YTOPR0101CA0011.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:15::24) To DM5PR12MB4680.namprd12.prod.outlook.com
 (2603:10b6:4:a6::33)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from jonathan-KFD.amd.com (165.204.55.251) by
 YTOPR0101CA0011.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:15::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.26 via Frontend
 Transport; Tue, 9 Mar 2021 16:20:20 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: cdc7b350-6ae7-4b5e-7767-08d8e3173c42
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0217:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR1201MB02178A29A9466A5F43FB719085929@DM5PR1201MB0217.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1332;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sKuzJ6IQ9yA9K60ronDrB6JkRvzJWJe7Y9h39sW4Ley6HdsT94r+4S6OXjDcvbUkzP0gCH0z97uSM+tcFpbZ9cAEiWyVZjV+BRpP96gUh5ebmCSD0RhWZKmYzBjbq8tdGRpR4EPFFPhiOlyIQPalMJUtZ1oG4EAjmX01JhJJBF3DI71He9rxhwrTHBM/Ck1KwrYk7zRxbpF4v5e5Ck3213cqp1kow6s5EVqbQGB3lZg7iZZ/0J6nAlLgOi+kpCHywtzkcvu8Yc+LSA3ceXfAzuMUNp4F0Z7Q/Au5bZ6cSjsC1fkY5i9n9I9g9OJVhyuMgO0YUhRukw5r9v0MXLgLzCBd2239lXJRy6r0r5lGPclghRk20DVeMYISiDY0ipxIMUKXleTDAb51P73MRUVsV4eiR4eLFLj9Qk7n6mz8mJIf8tW304XRntDcBpJeir1rWsZHWU/SNXqReSmOhbIfGgTlz7ePZJo3LZ7fRbZZoWlxBNZLjY0I+sp/22cgLQKPgALSukIitsg4tfq4lDD07Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB4680.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(39860400002)(366004)(376002)(346002)(136003)(52116002)(7696005)(66476007)(8936002)(316002)(86362001)(16526019)(6486002)(956004)(6666004)(2906002)(186003)(66556008)(2616005)(5660300002)(1076003)(26005)(4326008)(44832011)(66946007)(8676002)(478600001)(36756003)(83380400001)(6916009);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?MpdYEow3U5bj6oG4h1YcsBDzbJzF/LWzVnSwgVb3EfBG9FJqXtywSFlokCJp?=
 =?us-ascii?Q?5Oro4XY8Op1LaFvfJgDbI3HgUDfWg6LT3CgcDLQqfISVdSQmz3UNka/SlC9t?=
 =?us-ascii?Q?jfpA/AJfU0wzGxAVl7R56UoZ6mRQEaEBZ5pN9n9MONkxYVVcAP7aT+gZWWB/?=
 =?us-ascii?Q?euhzbtFCTTFmgTKtZ//mPqp8/WI/GQ7aFQnJCgzjr5Vm/d6N+2H7bMXqfJxJ?=
 =?us-ascii?Q?aPJONs2q4yVKMmlpY+UFY+NC2w3IKjbSgVV+XmHZiJQ6W8jsoh/YLJChPLIE?=
 =?us-ascii?Q?4DkJPsUB7Vr8JZcgArpUApJXrLQiovz/T6U5Sa+K+zwSH8/YXEwpM6wAliUF?=
 =?us-ascii?Q?hWtg8KadLXmV5wu/6krzP98ZIvPdPOGNN9+iZxFnlLCoQWS+PoYMRyn2Ptr3?=
 =?us-ascii?Q?fB1c3DjnOBTuHvjFobBZ+aSU5m6y4nqtiAa15aVHCBi+LFKjZzNHSLCHejyU?=
 =?us-ascii?Q?9NSKa+KgD3HQLtbTvt+XTnUKIlW/JdyeSC6YhnXzUzRNY81L47JhODhR6JQj?=
 =?us-ascii?Q?e2XT7ZV6LwoGu8aJj4qDHy/6GpyqmZvSZLohJQfB7wA2fXRTlFngeKI2K5By?=
 =?us-ascii?Q?DuWmD1TIpuMhucxrNcVBa6Wf1RwFFVnVRFRoo4knLlI8zsguf+/79c9D/5X8?=
 =?us-ascii?Q?XGfsxPfvvynEM1OTULh3e03ZwAV8LPEdSeuufT/YgF1M+cLeDb1kIw3F3mx/?=
 =?us-ascii?Q?AvtO+aYz21tt+A1ADl2Nk5utc9IL33fTaKeqASTFQ2/uzfs+vF/8k6EkJMFM?=
 =?us-ascii?Q?AHMGjiD2MZi++KI3KGip1QOyeE1mtH4kwOsxtc7DfROBIJOzX8YQmEPodDPu?=
 =?us-ascii?Q?88gGDKeJlNDBRQ1vPgMhMJyRL/o49oXc7dgXZpU+ZCQwQ8XWierEWVIske4F?=
 =?us-ascii?Q?C2RkHO1ktElrmB9o9n8DoRzXF8mVnQtpUnQY/skswB9lG7qyW92MAyNHbb9b?=
 =?us-ascii?Q?yt9mH1YdeWop16NGmokGwjsvkbCHQHL6qgVS3tkKwSB53pKMC/UazFLw1WLI?=
 =?us-ascii?Q?OoF/Xzps9t7qtP4j6guwpcgTDJaYyRV2OQMaTjI1rcWqU7hQTuP9MCAidndL?=
 =?us-ascii?Q?d27txnK1dAxEdEk6OnzJhz/bOylXBgURAm408z2FMX817FrVlsQPGEExDDSz?=
 =?us-ascii?Q?xc7fXZH3atJC1iMdepouLKoG1ACufgcHz2K2om+SPdrXwJusSbCll6b/ZDlu?=
 =?us-ascii?Q?ws/aCkhXt12SIompwyDfrIeJxqGJaSPVsxoA76seBJHxZBGGNArwqUFYHby1?=
 =?us-ascii?Q?6+UQk5Mk2F0rQld7PTQMTGNeU3YeK9mM1TT4p6sCZTf9M0jmfNF+/3s4POrd?=
 =?us-ascii?Q?pVUKTLMNQCrtBoZKHerfPSQv?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cdc7b350-6ae7-4b5e-7767-08d8e3173c42
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB4680.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2021 16:20:21.0015 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GnWnky5r0ggw10ZQhEZWR3f0y4DTK/SvaOqIGkKToOUErNITT6Zw7p7EnygIdwKO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0217
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
Cc: Philip.Yang@amd.com, Felix.Kuehling@amd.com,
 Jonathan Kim <jonathan.kim@amd.com>, Christian.Koenig@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add IH function to allow caller to wait until ring entries are processed
until the checkpoint write pointer.

This will be primarily used by HMM to drain pending page fault interrupts
before memory unmap to prevent HMM from handling stale interrupts.

v3: Scrap busy loop and change to wait_event.

v2: Update title and description to clarify use.
Add rptr/wptr wrap counter checks to guarantee ring entries are processed
until the checkpoint.

Suggested-by: Christian Koenig <christian.koenig@amd.com>
Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c | 49 ++++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h |  5 +++
 2 files changed, 54 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c
index dc852af4f3b7..1024065f1f03 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c
@@ -99,6 +99,8 @@ int amdgpu_ih_ring_init(struct amdgpu_device *adev, struct amdgpu_ih_ring *ih,
 		ih->rptr_addr = adev->wb.gpu_addr + rptr_offs * 4;
 		ih->rptr_cpu = &adev->wb.wb[rptr_offs];
 	}
+
+	init_waitqueue_head(&ih->wait_process);
 	return 0;
 }
 
@@ -160,6 +162,52 @@ void amdgpu_ih_ring_write(struct amdgpu_ih_ring *ih, const uint32_t *iv,
 	}
 }
 
+/* Waiter helper that checks current rptr matches or passes checkpoint wptr */
+static bool amdgpu_ih_has_checkpoint_processed(struct amdgpu_device *adev,
+					struct amdgpu_ih_ring *ih,
+					uint32_t checkpoint_wptr,
+					uint32_t *prev_rptr)
+{
+	uint32_t cur_rptr = ih->rptr | (*prev_rptr & ~ih->ptr_mask);
+
+	/* rptr has wrapped. */
+	if (cur_rptr < *prev_rptr)
+		cur_rptr += ih->ptr_mask + 1;
+	*prev_rptr = cur_rptr;
+
+	return cur_rptr >= checkpoint_wptr;
+}
+
+/**
+ * amdgpu_ih_wait_on_checkpoint_process - wait to process IVs up to checkpoint
+ *
+ * @adev: amdgpu_device pointer
+ * @ih: ih ring to process
+ *
+ * Used to ensure ring has processed IVs up to the checkpoint write pointer.
+ */
+int amdgpu_ih_wait_on_checkpoint_process(struct amdgpu_device *adev,
+					struct amdgpu_ih_ring *ih)
+{
+	uint32_t checkpoint_wptr, rptr;
+
+	if (!ih->enabled || adev->shutdown)
+		return -ENODEV;
+
+	checkpoint_wptr = amdgpu_ih_get_wptr(adev, ih);
+	/* Order wptr with rptr. */
+	rmb();
+	rptr = READ_ONCE(ih->rptr);
+
+	/* wptr has wrapped. */
+	if (rptr > checkpoint_wptr)
+		checkpoint_wptr += ih->ptr_mask + 1;
+
+	return wait_event_interruptible(ih->wait_process,
+				amdgpu_ih_has_checkpoint_processed(adev, ih,
+						checkpoint_wptr, &rptr));
+}
+
 /**
  * amdgpu_ih_process - interrupt handler
  *
@@ -195,6 +243,7 @@ int amdgpu_ih_process(struct amdgpu_device *adev, struct amdgpu_ih_ring *ih)
 	}
 
 	amdgpu_ih_set_rptr(adev, ih);
+	wake_up_all(&ih->wait_process);
 	atomic_set(&ih->lock, 0);
 
 	/* make sure wptr hasn't changed while processing */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h
index 6ed4a85fc7c3..87ec6d20dbe0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h
@@ -66,6 +66,9 @@ struct amdgpu_ih_ring {
 	unsigned		rptr;
 	atomic_t		lock;
 	struct amdgpu_ih_regs	ih_regs;
+
+	/* For waiting on IH processing at checkpoint. */
+	wait_queue_head_t wait_process;
 };
 
 /* provided by the ih block */
@@ -87,6 +90,8 @@ int amdgpu_ih_ring_init(struct amdgpu_device *adev, struct amdgpu_ih_ring *ih,
 void amdgpu_ih_ring_fini(struct amdgpu_device *adev, struct amdgpu_ih_ring *ih);
 void amdgpu_ih_ring_write(struct amdgpu_ih_ring *ih, const uint32_t *iv,
 			  unsigned int num_dw);
+int amdgpu_ih_wait_on_checkpoint_process(struct amdgpu_device *adev,
+					struct amdgpu_ih_ring *ih);
 int amdgpu_ih_process(struct amdgpu_device *adev, struct amdgpu_ih_ring *ih);
 void amdgpu_ih_decode_iv_helper(struct amdgpu_device *adev,
 				struct amdgpu_ih_ring *ih,
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
