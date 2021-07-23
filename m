Return-Path: <SRS0=Den1=MP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95ACEC432BE
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Jul 2021 08:29:40 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3DD7660E77
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Jul 2021 08:29:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3DD7660E77
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ED9386EA78;
	Fri, 23 Jul 2021 08:29:39 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2066.outbound.protection.outlook.com [40.107.237.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 678946EA78
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Jul 2021 08:29:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mKuUHE7PvkX/EyIE7ttM+qgDP/rOOu9bdJNYPQXh+urrtOSdeuxtN3REoyV2csFttCA6xbsbiQlxZB5+v9ECmY4nZYDVCuv6q0CF5qPgbQ5qQ1SokHWo7bDaofcFxj34GotchUpXdwunOebHe0mm8fJezQcHZL1Pjyb7scVUO6J72PMH15lbeu45y6rRzknI3WGOwC50QXn3Pr/7QiWQpjj37QMJreO7Cu/93x6Aq2XK7D1Z74ayYB+kvsgFM6A9PUEl/uuCNwaX85IXExPpzK38anjk472B1NAq5c7fTSG7dbUka1JVmptc9Y5FPUxtgOfq4y2q1k4y5Q2zYNs9JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9U8QoyXU0U0izlLAcACt6Qk5UA09rnTUF1ofaJ9cdh8=;
 b=Nlx2t4BCgP+prajc0aECnTYyojMUTa2WMAcCmL5n/0gKbEwpKGfEViuMGiaZ+NizgCdNFOSZTKrKLpOsUQzebu7AfMpaaQuD7RZ8T7SDZ5QrOqBDUx5pj9/3AkPNBLChaU82/dq0ARCcSE5QRJILm1vzH2qdnMtFiYBabiEGxNZ8tzHKXctjNTq0ily3Tm9yy3H5XwvMk65O9URL1gKZTsiE9W95xiGd0z/g0QZe4P+qxV68M7M2H1IquP5c387qjR4K9TzpFatUmqXquFLx5WYTdSiAtC7jY5+hI2jFsLrRJgDVRgkh5MLMNqFOsjaOvZzgSTqhRYbm0C4q0fLArw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9U8QoyXU0U0izlLAcACt6Qk5UA09rnTUF1ofaJ9cdh8=;
 b=p43GUoCUOe6NRt79O1bKyTcZI0fXeO/y0Ji+//ARHgR2geB7FStCv1X/gnLZogQ6u4UEaodHAktGTUbRA+oW605D1dEuARSqMxzk+4gmTJF35nOudp2cif4o/4gKJQMOPNEjXhVX09PHhfRK8RNOtR0XBtGiCdOZtvDC3FOsZqg=
Received: from BL1PR12MB5269.namprd12.prod.outlook.com (2603:10b6:208:30b::20)
 by BL1PR12MB5191.namprd12.prod.outlook.com (2603:10b6:208:318::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.24; Fri, 23 Jul
 2021 08:29:36 +0000
Received: from BL1PR12MB5269.namprd12.prod.outlook.com
 ([fe80::d9d7:2d92:acc3:e3c3]) by BL1PR12MB5269.namprd12.prod.outlook.com
 ([fe80::d9d7:2d92:acc3:e3c3%3]) with mapi id 15.20.4352.029; Fri, 23 Jul 2021
 08:29:36 +0000
From: "Liu, Monk" <Monk.Liu@amd.com>
To: "Chen, JingWen" <JingWen.Chen2@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 1/2] drm/amd/amdgpu embed hw_fence into amdgpu_job
Thread-Topic: [PATCH 1/2] drm/amd/amdgpu embed hw_fence into amdgpu_job
Thread-Index: AQHXf30UaGK2z0zefU6P0c0eXdG+FKtQON2A
Date: Fri, 23 Jul 2021 08:29:36 +0000
Message-ID: <BL1PR12MB5269B9F06F4FB2BC261237DD84E59@BL1PR12MB5269.namprd12.prod.outlook.com>
References: <20210723044137.61682-1-Jingwen.Chen2@amd.com>
In-Reply-To: <20210723044137.61682-1-Jingwen.Chen2@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-07-23T08:29:33Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=b172db9d-0b2b-43c8-98b4-a76c5f6d0e1f;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1b3a4ec6-c063-4b70-9564-08d94db401ad
x-ms-traffictypediagnostic: BL1PR12MB5191:
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL1PR12MB5191B94305B1C34F5A3CC9CC84E59@BL1PR12MB5191.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1186;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XZyvRg1oUbNaPX3app0R9oQWrC/QE/WKwePdJZvnsweeHWm0wQIJHKTAYjSICHnabOgCB5ybQRa/YsPUU3Ay7PIsMGZ5uecGfaozMeIdhKT3K55YBHK4AG4bW7LDnqSg+SR1tlRiKEBks85ZqXiEBnfFsv7wvMOyNC70RpMeVcT63kFex25fYasYl0z/2u2y3Te8DpNqIhddALgKKi8zQDgaLkdC8u+4QmpEtgBPBAS1SYjtWDZHbZsapf3I32sOIXYVjetJ3ZdAMHNjRU78GzO4A618Z/p99ES3mb+QSaPNUalXkwLwcH6sa5j3uzWYOotjpGz1ol5591PHwF6Sq0An0TpBCtdBLiQX952Ri8lKoDmRjPaMotWKmoB7m43+1D54QzYA+8eXaimcCQCnJHHPjZXWetMegKs/+2sDHDWWNKQsuporrrTlop6P4FVfatbOiqt+wB+MAh+YnDDfmV+E9GosBGSAhLssrzyDnNCX4J4/XGXF2Nd2USGKzqWiX8q5GXnqHGJ8dWwz3PcqT0GuDaE+0tF2YEcXNFyZqpRXUPR/9mWrXpZtQ01YyU5VjHMCdtJVwBgMmSx3ioKkHaM2nVHH6S5QIk6poKMMQcnveEpbD+0t0S+n9ZYYA8+N6ntt4Psxya04KIopnvtAVoHSpzaRyTyUfY9AcfY+A04OntBaUEzR6h0zNbt0whkyClpm+uZhjDIL0zfyXb9GEQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5269.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(366004)(376002)(39860400002)(346002)(396003)(55016002)(8936002)(33656002)(83380400001)(316002)(71200400001)(8676002)(186003)(7696005)(86362001)(38100700002)(66476007)(54906003)(66556008)(53546011)(5660300002)(6506007)(64756008)(52536014)(66446008)(66946007)(478600001)(9686003)(76116006)(26005)(30864003)(122000001)(110136005)(4326008)(2906002)(38070700004);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?F7BPB1tCq4ASyMlhSyV0NCnjGEIqUiJZ6YypWLBxQbM4dW7sG0qjpsluiP2I?=
 =?us-ascii?Q?uakqFOEaEaWKwnQrWrBO/2dATj1j8ImXHsPbVrNg5kqwHDjeVbyJIGg083ZW?=
 =?us-ascii?Q?7r03bdEr4W2PNtu+Lb3SSB9XbEAgKpGRRLYpFC7eRqM6VJSM6hasTiXae6Mo?=
 =?us-ascii?Q?NcnohhYuAnoPQJNGJMEGwv/Bn6p8LWSjpCLsmztn/NZtpmFg7ISq7tLJTPJ0?=
 =?us-ascii?Q?66tKE3nXmN9VHKeeSy3fV9EdVQG3qgttH4V6E+B2QKASUiNBqPVnLVlBDMsT?=
 =?us-ascii?Q?MJVhQ9CGrlcuau7AjgPPH/kOMkAewbmRvSw88Vbw0c8bDq6lDJG0AmB/3MZZ?=
 =?us-ascii?Q?RCNk8iqtylOskMw2V6OccUClm0x7+Xwl/w8L9qY3RUFZM62nrA1r5kbvJHlB?=
 =?us-ascii?Q?lCl/FfciH28hPXrExJSjbSr9UI94S/wLf80GdFszl9tYver3M/184gMLXO54?=
 =?us-ascii?Q?c3pgFgNnavdeGkyqjgOMqquEk/U9lvnrGDIBQzhote/Ew3vLuuPj5+I2TU91?=
 =?us-ascii?Q?vLQCJln14NRslvJKmgnPlL3Lw9MV5fYSh07nj+YeHVOROn8PGu6am8JLClug?=
 =?us-ascii?Q?5xVLx/pD083ZeH9uPZ7n3Vs/UagqW4/CHI75+mfZvfAm/2v55Ue2Md1KECq3?=
 =?us-ascii?Q?bLaTjOI02QtLfoFKI8wx30ecm+Liw3WVKpcbiKl9FfxxALXRZAIAmS/fr8/1?=
 =?us-ascii?Q?yn9P51Z1nnO6qQUtd07oZXG4HyoRcFwVrHEz8JnmwNp//uRFcCEqHZ7NT4hU?=
 =?us-ascii?Q?Vwg0s2GYRupKSf5KmV86nKMC+duZFepDYs9LrzegfTLWcHR+ITvOUQd0MxfL?=
 =?us-ascii?Q?lnYipYTMt0y3SqNVKnDpgtMwX5lMgHhJHdEv650CmNeIx/TQlh9FKjWHsE0v?=
 =?us-ascii?Q?SS9ogbcaZgDSSB5zVYQLvRAjA8PEyqs2mSsn7Bng24gJOtj/e96yH0juj0sA?=
 =?us-ascii?Q?mIPg6uspnivmnTfEWGJ7i4l7A7duTm/119+5zMlyIk/kfsUpJt0vdmBB22qI?=
 =?us-ascii?Q?nxIQMgzV2MZZTYwWNB+r2L48j+8G8//1tqHLdHa+ISgLOBKeHhksUwBpe4HA?=
 =?us-ascii?Q?ojVFxC42J6PYEkV0QQfglps5WKAHBkS7dhN7IBef1mQLtkAli9Me4EC5VoN4?=
 =?us-ascii?Q?QaKj+g3kJ9CeSo2n7aae0jtQ84cUK0hKtWwlUfpdh9J4ibPncBjUMYH15YkX?=
 =?us-ascii?Q?TOjXmhhZlLJN/InaX959EsMaJwzH7mWGMNw1UAW9JoOVyYBKSE5vbYCLhYgB?=
 =?us-ascii?Q?0t5DXRbCT4mWFpsJJpQqNgfHl7zYP8FCATVKPhqAqKfyNHG/A6aQJxGEhv84?=
 =?us-ascii?Q?Dvb4o1A+xnrL/srw8R5ggI+/?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5269.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b3a4ec6-c063-4b70-9564-08d94db401ad
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jul 2021 08:29:36.5279 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1/km9V0qZnWJn5ZehyI1m0UPNrtnaGtLoiYtXHj/7RLM3EoOYjIQVUlXc6hxf1en
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5191
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
Cc: "Grodzovsky, Andrey" <Andrey.Grodzovsky@amd.com>, "Zhang,
 Jack \(Jian\)" <Jack.Zhang1@amd.com>, "Chen, JingWen" <JingWen.Chen2@amd.com>,
 "ckoenig.leichtzumerken@gmail.com" <ckoenig.leichtzumerken@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only]

Hi jingwen

In the lines like  below:
+	if (job != NULL) {
+		/* mark this fence has a parent job */
+		set_bit(DMA_FENCE_FLAG_USER_BITS, &fence->flags);
+	}

The DMA_FENCE_FLAG_USER_BITS usage looks not good enough

Please try to improve it, e.g.:

#define AMDGPU_DMA_FENCE_FLAG_INSIDE_JOB  DMA_FENCE_FLAG_USER_BITS

This way in the future USER BITS could be extended to other purpose:
#define AMDGPU_DMA_FENCE_FLAG_XXXXX(AMDGPU_DMA_FENCE_FLAG_INSIDE_JOB  + 1)

Please try to use AMDGPU_DMA_FENCE_FLAG_INSIDE_JOB instead of DMA_FENCE_FLAG_USER_BITS everywhere 

For other logic parts I do not have suggestions since I already know those history and the corresponding changes much enough 

Thanks 

------------------------------------------
Monk Liu | Cloud-GPU Core team
------------------------------------------

-----Original Message-----
From: Jingwen Chen <Jingwen.Chen2@amd.com> 
Sent: Friday, July 23, 2021 12:42 PM
To: amd-gfx@lists.freedesktop.org
Cc: Liu, Monk <Monk.Liu@amd.com>; Grodzovsky, Andrey <Andrey.Grodzovsky@amd.com>; ckoenig.leichtzumerken@gmail.com; Zhang, Jack (Jian) <Jack.Zhang1@amd.com>; Chen, JingWen <JingWen.Chen2@amd.com>
Subject: [PATCH 1/2] drm/amd/amdgpu embed hw_fence into amdgpu_job

From: Jack Zhang <Jack.Zhang1@amd.com>

Why: Previously hw fence is alloced separately with job.
It caused historical lifetime issues and corner cases.
The ideal situation is to take fence to manage both job and fence's lifetime, and simplify the design of gpu-scheduler.

How:
We propose to embed hw_fence into amdgpu_job.
1. We cover the normal job submission by this method.
2. For ib_test, and submit without a parent job keep the legacy way to create a hw fence separately.

Signed-off-by: Jingwen Chen <Jingwen.Chen2@amd.com>
Signed-off-by: Jack Zhang <Jack.Zhang1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c  |  1 -  drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c   | 62 ++++++++++++++++-----
 drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c      |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c     | 35 ++++++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.h     |  4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h    |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c      |  2 +-
 8 files changed, 80 insertions(+), 30 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
index b6d33f13b476..bad403978bac 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
@@ -714,7 +714,6 @@ int amdgpu_amdkfd_submit_ib(struct kgd_dev *kgd, enum kgd_engine_type engine,
 	ret = dma_fence_wait(f, false);
 
 err_ib_sched:
-	dma_fence_put(f);
 	amdgpu_job_free(job);
 err:
 	return ret;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
index 536005bff24a..277128846dd1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
@@ -1414,7 +1414,7 @@ static void amdgpu_ib_preempt_mark_partial_job(struct amdgpu_ring *ring)
 			continue;
 		}
 		job = to_amdgpu_job(s_job);
-		if (preempted && job->fence == fence)
+		if (preempted && (&job->hw_fence) == fence)
 			/* mark the job as preempted */
 			job->preemption_status |= AMDGPU_IB_PREEMPTED;
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
index 30772608eac6..eecf21d8ec33 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
@@ -133,25 +133,40 @@ static u32 amdgpu_fence_read(struct amdgpu_ring *ring)
  * Emits a fence command on the requested ring (all asics).
  * Returns 0 on success, -ENOMEM on failure.
  */
-int amdgpu_fence_emit(struct amdgpu_ring *ring, struct dma_fence **f,
+int amdgpu_fence_emit(struct amdgpu_ring *ring, struct dma_fence **f, 
+struct amdgpu_job *job,
 		      unsigned flags)
 {
 	struct amdgpu_device *adev = ring->adev;
-	struct amdgpu_fence *fence;
+	struct dma_fence *fence;
+	struct amdgpu_fence *am_fence;
 	struct dma_fence __rcu **ptr;
 	uint32_t seq;
 	int r;
 
-	fence = kmem_cache_alloc(amdgpu_fence_slab, GFP_KERNEL);
-	if (fence == NULL)
-		return -ENOMEM;
+	if (job == NULL) {
+		/* create a sperate hw fence */
+		am_fence = kmem_cache_alloc(amdgpu_fence_slab, GFP_KERNEL);
+		if (am_fence == NULL)
+			return -ENOMEM;
+		fence = &am_fence->base;
+		am_fence->ring = ring;
+	} else {
+		/* take use of job-embedded fence */
+		fence = &job->hw_fence;
+		job->ring = ring;
+	}
 
 	seq = ++ring->fence_drv.sync_seq;
-	fence->ring = ring;
-	dma_fence_init(&fence->base, &amdgpu_fence_ops,
+	dma_fence_init(fence, &amdgpu_fence_ops,
 		       &ring->fence_drv.lock,
 		       adev->fence_context + ring->idx,
 		       seq);
+
+	if (job != NULL) {
+		/* mark this fence has a parent job */
+		set_bit(DMA_FENCE_FLAG_USER_BITS, &fence->flags);
+	}
+
 	amdgpu_ring_emit_fence(ring, ring->fence_drv.gpu_addr,
 			       seq, flags | AMDGPU_FENCE_FLAG_INT);
 	pm_runtime_get_noresume(adev_to_drm(adev)->dev);
@@ -174,9 +189,9 @@ int amdgpu_fence_emit(struct amdgpu_ring *ring, struct dma_fence **f,
 	/* This function can't be called concurrently anyway, otherwise
 	 * emitting the fence would mess up the hardware ring buffer.
 	 */
-	rcu_assign_pointer(*ptr, dma_fence_get(&fence->base));
+	rcu_assign_pointer(*ptr, dma_fence_get(fence));
 
-	*f = &fence->base;
+	*f = fence;
 
 	return 0;
 }
@@ -636,8 +651,16 @@ static const char *amdgpu_fence_get_driver_name(struct dma_fence *fence)
 
 static const char *amdgpu_fence_get_timeline_name(struct dma_fence *f)  {
-	struct amdgpu_fence *fence = to_amdgpu_fence(f);
-	return (const char *)fence->ring->name;
+	struct amdgpu_ring *ring;
+
+	if (test_bit(DMA_FENCE_FLAG_USER_BITS, &f->flags)) {
+		struct amdgpu_job *job = container_of(f, struct amdgpu_job, 
+hw_fence);
+
+		ring = job->ring;
+	} else {
+		ring = to_amdgpu_fence(f)->ring;
+	}
+	return (const char *)ring->name;
 }
 
 /**
@@ -671,8 +694,20 @@ static bool amdgpu_fence_enable_signaling(struct dma_fence *f)  static void amdgpu_fence_free(struct rcu_head *rcu)  {
 	struct dma_fence *f = container_of(rcu, struct dma_fence, rcu);
-	struct amdgpu_fence *fence = to_amdgpu_fence(f);
-	kmem_cache_free(amdgpu_fence_slab, fence);
+
+	if (test_bit(DMA_FENCE_FLAG_USER_BITS, &f->flags)) {
+	/* free job if fence has a parent job */
+		struct amdgpu_job *job;
+
+		job = container_of(f, struct amdgpu_job, hw_fence);
+		kfree(job);
+	} else {
+	/* free fence_slab if it's separated fence*/
+		struct amdgpu_fence *fence;
+
+		fence = to_amdgpu_fence(f);
+		kmem_cache_free(amdgpu_fence_slab, fence);
+	}
 }
 
 /**
@@ -695,6 +730,7 @@ static const struct dma_fence_ops amdgpu_fence_ops = {
 	.release = amdgpu_fence_release,
 };
 
+
 /*
  * Fence debugfs
  */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
index ec65ab0ddf89..c076a6b9a5a2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
@@ -262,7 +262,7 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned num_ibs,
 				       fence_flags | AMDGPU_FENCE_FLAG_64BIT);
 	}
 
-	r = amdgpu_fence_emit(ring, f, fence_flags);
+	r = amdgpu_fence_emit(ring, f, job, fence_flags);
 	if (r) {
 		dev_err(adev->dev, "failed to emit fence (%d)\n", r);
 		if (job && job->vmid)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
index 759b34799221..7c426e225b24 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
@@ -114,11 +114,16 @@ void amdgpu_job_free_resources(struct amdgpu_job *job)  {
 	struct amdgpu_ring *ring = to_amdgpu_ring(job->base.sched);
 	struct dma_fence *f;
+	struct dma_fence *hw_fence;
 	unsigned i;
 
-	/* use sched fence if available */
-	f = job->base.s_fence ? &job->base.s_fence->finished : job->fence;
+	if (job->hw_fence.ops == NULL)
+		hw_fence = job->external_hw_fence;
+	else
+		hw_fence = &job->hw_fence;
 
+	/* use sched fence if available */
+	f = job->base.s_fence ? &job->base.s_fence->finished : hw_fence;
 	for (i = 0; i < job->num_ibs; ++i)
 		amdgpu_ib_free(ring->adev, &job->ibs[i], f);  } @@ -129,20 +134,27 @@ static void amdgpu_job_free_cb(struct drm_sched_job *s_job)
 
 	drm_sched_job_cleanup(s_job);
 
-	dma_fence_put(job->fence);
 	amdgpu_sync_free(&job->sync);
 	amdgpu_sync_free(&job->sched_sync);
-	kfree(job);
+
+    /* only put the hw fence if has embedded fence */
+	if (job->hw_fence.ops != NULL)
+		dma_fence_put(&job->hw_fence);
+	else
+		kfree(job);
 }
 
 void amdgpu_job_free(struct amdgpu_job *job)  {
 	amdgpu_job_free_resources(job);
-
-	dma_fence_put(job->fence);
 	amdgpu_sync_free(&job->sync);
 	amdgpu_sync_free(&job->sched_sync);
-	kfree(job);
+
+	/* only put the hw fence if has embedded fence */
+	if (job->hw_fence.ops != NULL)
+		dma_fence_put(&job->hw_fence);
+	else
+		kfree(job);
 }
 
 int amdgpu_job_submit(struct amdgpu_job *job, struct drm_sched_entity *entity, @@ -171,11 +183,14 @@ int amdgpu_job_submit_direct(struct amdgpu_job *job, struct amdgpu_ring *ring,
 
 	job->base.sched = &ring->sched;
 	r = amdgpu_ib_schedule(ring, job->num_ibs, job->ibs, NULL, fence);
-	job->fence = dma_fence_get(*fence);
+	/* record external_hw_fence for direct submit */
+	job->external_hw_fence = dma_fence_get(*fence);
 	if (r)
 		return r;
 
 	amdgpu_job_free(job);
+	dma_fence_put(*fence);
+
 	return 0;
 }
 
@@ -233,10 +248,8 @@ static struct dma_fence *amdgpu_job_run(struct drm_sched_job *sched_job)
 		if (r)
 			DRM_ERROR("Error scheduling IBs (%d)\n", r);
 	}
-	/* if gpu reset, hw fence will be replaced here */
-	dma_fence_put(job->fence);
-	job->fence = dma_fence_get(fence);
 
+	dma_fence_get(fence);
 	amdgpu_job_free_resources(job);
 
 	fence = r ? ERR_PTR(r) : fence;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
index 81caac9b958a..92324c978534 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
@@ -46,7 +46,9 @@ struct amdgpu_job {
 	struct amdgpu_sync	sync;
 	struct amdgpu_sync	sched_sync;
 	struct amdgpu_ib	*ibs;
-	struct dma_fence	*fence; /* the hw fence */
+	struct dma_fence	hw_fence;
+	struct amdgpu_ring *ring;
+	struct dma_fence	*external_hw_fence;
 	uint32_t		preamble_status;
 	uint32_t                preemption_status;
 	uint32_t		num_ibs;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
index ca1622835296..2306424cbcb4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
@@ -118,7 +118,7 @@ int amdgpu_fence_driver_start_ring(struct amdgpu_ring *ring,
 				   unsigned irq_type);
 void amdgpu_fence_driver_suspend(struct amdgpu_device *adev);  void amdgpu_fence_driver_resume(struct amdgpu_device *adev); -int amdgpu_fence_emit(struct amdgpu_ring *ring, struct dma_fence **fence,
+int amdgpu_fence_emit(struct amdgpu_ring *ring, struct dma_fence 
+**fence, struct amdgpu_job *job,
 		      unsigned flags);
 int amdgpu_fence_emit_polling(struct amdgpu_ring *ring, uint32_t *s,
 			      uint32_t timeout);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 358316d6a38c..0670f43ef22a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -1216,7 +1216,7 @@ int amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
 		amdgpu_gmc_emit_pasid_mapping(ring, job->vmid, job->pasid);
 
 	if (vm_flush_needed || pasid_mapping_needed) {
-		r = amdgpu_fence_emit(ring, &fence, 0);
+		r = amdgpu_fence_emit(ring, &fence, NULL, 0);
 		if (r)
 			return r;
 	}
--
2.25.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
