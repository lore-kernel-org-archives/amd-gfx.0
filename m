Return-Path: <SRS0=KDYH=4M=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_HTML_MOSTLY,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A90B5C11D2F
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Feb 2020 18:16:01 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A8C920732
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Feb 2020 18:16:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Zmza8hTp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A8C920732
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 09ED789906;
	Mon, 24 Feb 2020 18:16:01 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2058.outbound.protection.outlook.com [40.107.236.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D97F389906
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Feb 2020 18:15:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NB9QCIdSTqRcIgIPC+l74m7mcYV768uAh8gSOJZKAzBQ+UJ3rS1oZAhF+JmsahopE+ZV2FEPtf0XgZcdHEJYZFhgjg4hI1AI5rEkCOpa/2CsM5SGqXYL4KmXv1yDEgKGhTg2GEyERy/VYd5u03391mWcRbSsrhVHRiCRUa/qS8P6PI66RzHjlKXM6mki1B8nyhp1xWU06iLtnRRIed7Gq2X/IxMlSUYd57NLm2HOoAYILmr/5686aJY2wnuZaXDmG9LCgPwNLy3Nc+tovYxd8HlRhEK+/SI1hNynE2LPFt9uvoVfAcys6+5pO7C2wlnrOW9Ffzv2qRXwPpzeo4N5+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TAOXVX7BKxTT1bnsgmxoGGO7rP4KafSushYAk7St2+I=;
 b=lapXxt1RnHGatYw+yigOq6oj3kU3ADi86SSJHpttSOW+M1oJXY4ZVr36EA2kQ2M/o1IJZ+t7FEllmZmMiAFpt9b0NUy/J+CdGQh01HAkiPsvrDpMz2z7CNr7ccjZZWdtLsfER0G4z1fw74OlsB10p5oS+GSfR6KikU5OLqHqWodWggOlTgZM7GppzEU2eif1jMvV1El/arXJrsjLydskR+P8EPLvXWYNf66epQfG79p9No5AZL6ORa56km1WjP1Q/Q7LjGeTUQVBxCZpBIjQmvi3lILV7ywDNmrevVYgXqXvBLi6WOVrCRdyju3xgm1yvBNZnjVkhBsEFwvOwwI7cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TAOXVX7BKxTT1bnsgmxoGGO7rP4KafSushYAk7St2+I=;
 b=Zmza8hTpoyBYoJW0WnVNzL4F9MLbDO+AmGf7voUtJAR+xoS8WtvFCwc4cir3iCs9bXXaC3nGNXBM9krcx2UU1FD7u6XaxOuDa3g19sacN4xg5vQHu1sB0hMutlnT6VZ78E4jnD6ZjkGFMGq7YbcMJ8kFlu4pE0hoZSnau/2mKX0=
Received: from DM5PR12MB2376.namprd12.prod.outlook.com (2603:10b6:4:b9::11) by
 DM5PR12MB1947.namprd12.prod.outlook.com (2603:10b6:3:111::23) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.21; Mon, 24 Feb 2020 18:15:58 +0000
Received: from DM5PR12MB2376.namprd12.prod.outlook.com
 ([fe80::ac12:6413:cd14:4904]) by DM5PR12MB2376.namprd12.prod.outlook.com
 ([fe80::ac12:6413:cd14:4904%4]) with mapi id 15.20.2750.021; Mon, 24 Feb 2020
 18:15:58 +0000
From: "Das, Nirmoy" <Nirmoy.Das@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>
Subject: Re: [RFC PATCH 1/1] drm/amdgpu: wait for sched to become ready on job
 submit
Thread-Topic: [RFC PATCH 1/1] drm/amdgpu: wait for sched to become ready on
 job submit
Thread-Index: AQHV6zTB+fnA+B3EDkmR9G8hBv9pt6gqlK2y
Date: Mon, 24 Feb 2020 18:15:57 +0000
Message-ID: <DM5PR12MB23765A9C06DB2B62ECF0B6208BEC0@DM5PR12MB2376.namprd12.prod.outlook.com>
References: <9d1fd4e5-adcb-470b-a0be-5528af050d14@email.android.com>
In-Reply-To: <9d1fd4e5-adcb-470b-a0be-5528af050d14@email.android.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-02-24T17:12:08.5720248Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Privileged
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Nirmoy.Das@amd.com; 
x-originating-ip: [2.247.253.148]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 53726a8f-f06b-4d59-b5a0-08d7b95598aa
x-ms-traffictypediagnostic: DM5PR12MB1947:|DM5PR12MB1947:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB1947F7C6277D2F8DAC42C79A8BEC0@DM5PR12MB1947.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:133;
x-forefront-prvs: 032334F434
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(366004)(376002)(396003)(136003)(346002)(189003)(199004)(71200400001)(33656002)(55016002)(66556008)(76116006)(64756008)(9686003)(316002)(91956017)(5660300002)(7696005)(66446008)(52536014)(26005)(53546011)(6506007)(186003)(6862004)(86362001)(2906002)(6636002)(4326008)(66946007)(66476007)(8676002)(54906003)(81156014)(478600001)(45080400002)(81166006)(8936002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1947;
 H:DM5PR12MB2376.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oXoi00n6/ktXb7nWUVccNRsmhuQHXazZMkzBhaS/TuFUIsk/Uo3BrCIHoU4SZbktJNphJ5xB2xHzyTk4YhEa0Agt8p46y/bpK10XUqMVqapmqxdhVx7y2BoEDUO3Xi9P6X1tIhIFieJflanLGBLesSgJ/LwLrhAtt+X59m5WIo2++tMpx/iQiJx5fMrnCcwsHOnMzvh2vUMGk9Mj0msJgSdR3CQI1HTmWkjODahquxP0HNhWbwmNaiHjIC3qlxn1TPodJt9IbYZ0ee0AjuQmQtNrMhyw1IH4yroNx1tuf1jRSrO75ekP7NwuwMtvt3VAv5aTkV33M6XDf77wgGPsNUWR1KFs/j3OtcvsGCjMYaXL+6oeEmv+cXIRvvowYxtNti54p6CbZlzkpwGYFmlzgztFGwNPJcekyYTjE3cE5VCEgKpK5mSb70Q8qdO8vwoY2G2m4df9ubl3lVW2mM5dwGxkVu/rYkOkoRyDQY5+RpbPu6oKgXoVDUwZ6X9lcVcOUQZgquqn8Y2eumHbDn/28A==
x-ms-exchange-antispam-messagedata: sEUJxBafZvbko9pIdO2hkfFecb6nUlIZFcl/lyFYOrr2qF5bJqz0HEffp8TvJb8rah1l+O96y7vgoD9Nr+VCg5rwNqL1d0aLGJJaK6EgEBOJ8PTNP1xFWPfIsfUeWKkmGnN/6i1XEl1cC7GVyX+PtA==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53726a8f-f06b-4d59-b5a0-08d7b95598aa
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2020 18:15:57.8968 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zifAeD3pl38DKEVZ4kOnEdAowiScl1xpQbOVY6IVNtxt3oIVTDjjNxI654qZRzKKzVWfcUHoLNHVoR/PfD/Fmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1947
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
Cc: "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, "Liu, Monk" <Monk.Liu@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Li, 
 Dennis" <Dennis.Li@amd.com>
Content-Type: multipart/mixed; boundary="===============1881874043=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1881874043==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_DM5PR12MB23765A9C06DB2B62ECF0B6208BEC0DM5PR12MB2376namp_"

--_000_DM5PR12MB23765A9C06DB2B62ECF0B6208BEC0DM5PR12MB2376namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

Thanks Christian. I will try to send a updated patch soon.

Get Outlook for Android<https://aka.ms/ghei36>

________________________________
From: Koenig, Christian <Christian.Koenig@amd.com>
Sent: Monday, February 24, 2020, 18:06
To: Nirmoy Das
Cc: amd-gfx@lists.freedesktop.org; Deucher, Alexander; Liu, Monk; Li, Denni=
s; Das, Nirmoy
Subject: Re: [RFC PATCH 1/1] drm/amdgpu: wait for sched to become ready on =
job submit

Hi Nirmoy,

Am 24.02.2020 17:48 schrieb Nirmoy Das <nirmoy.aiemd@gmail.com>:
On reset, amdgpu can set a drm sched's ready status to false temporarily. d=
rm job
init will fail if all of the drm scheds are not ready for a HW IP. This pat=
ch tries to make
kernel's internal drm job submit handle, amdgpu_job_submit() a bit more fau=
lt tolerant.

I don't think that this approach makes sense. Since it is a front end prope=
rty we should rather stop setting the scheduler ready status to false durin=
g reset.

Instead we should only set it to false when the ring/IB test fails and we c=
an't bring the ring back to life again.

Christian.


Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c     | 35 +++++++++++++++++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.h     |  5 +--
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c     |  6 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c     |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c     |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c |  2 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c      |  2 +-
 7 files changed, 43 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_job.c
index d42be880a236..0745df80112f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
@@ -139,7 +139,38 @@ void amdgpu_job_free(struct amdgpu_job *job)
         kfree(job);
 }

-int amdgpu_job_submit(struct amdgpu_job *job, struct drm_sched_entity *ent=
ity,
+static int amdgpu_job_try_init(struct amdgpu_device *adev,
+                              struct drm_sched_job *base,
+                              struct drm_sched_entity *entity,
+                              void *owner)
+{
+       int r, i;
+
+       r =3D drm_sched_job_init(base, entity, owner);
+       if (r =3D=3D -ENOENT) {
+               /* retry till we come out of reset phase */
+               while (!mutex_trylock(&adev->lock_reset))
+                       msleep(10);
+               /* retry for a second for the sched to get ready*/
+               for (i =3D 0; i < 100; i++) {
+                       msleep(10);
+                       r =3D drm_sched_job_init(base, entity, owner);
+                       if (r =3D=3D -ENOENT)
+                               continue;
+               }
+
+               mutex_unlock(&adev->lock_reset);
+               /* If after all these we failed to initialize a job
+                * it means the IP is unrecoverable */
+               if (r =3D=3D -ENOENT)
+                       return -ENODEV;
+       }
+
+       return r;
+}
+
+int amdgpu_job_submit(struct amdgpu_device *adev,struct amdgpu_job *job,
+                     struct drm_sched_entity *entity,
                       void *owner, struct dma_fence **f)
 {
         enum drm_sched_priority priority;
@@ -149,7 +180,7 @@ int amdgpu_job_submit(struct amdgpu_job *job, struct dr=
m_sched_entity *entity,
         if (!f)
                 return -EINVAL;

-       r =3D drm_sched_job_init(&job->base, entity, owner);
+       r =3D amdgpu_job_try_init(adev, &job->base, entity, owner);
         if (r)
                 return r;

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_job.h
index 2e2110dddb76..fed87e96cacc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
@@ -70,8 +70,9 @@ int amdgpu_job_alloc_with_ib(struct amdgpu_device *adev, =
unsigned size,

 void amdgpu_job_free_resources(struct amdgpu_job *job);
 void amdgpu_job_free(struct amdgpu_job *job);
-int amdgpu_job_submit(struct amdgpu_job *job, struct drm_sched_entity *ent=
ity,
-                     void *owner, struct dma_fence **f);
+int amdgpu_job_submit(struct amdgpu_device *adev, struct amdgpu_job *job,
+                     struct drm_sched_entity *entity, void *owner,
+                     struct dma_fence **f);
 int amdgpu_job_submit_direct(struct amdgpu_job *job, struct amdgpu_ring *r=
ing,
                              struct dma_fence **fence);

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ttm.c
index 660867cf2597..adfde07eb75f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -2066,7 +2066,7 @@ static int amdgpu_map_buffer(struct ttm_buffer_object=
 *bo,
         if (r)
                 goto error_free;

-       r =3D amdgpu_job_submit(job, &adev->mman.entity,
+       r =3D amdgpu_job_submit(adev, job, &adev->mman.entity,
                               AMDGPU_FENCE_OWNER_UNDEFINED, &fence);
         if (r)
                 goto error_free;
@@ -2137,7 +2137,7 @@ int amdgpu_copy_buffer(struct amdgpu_ring *ring, uint=
64_t src_offset,
         if (direct_submit)
                 r =3D amdgpu_job_submit_direct(job, ring, fence);
         else
-               r =3D amdgpu_job_submit(job, &adev->mman.entity,
+               r =3D amdgpu_job_submit(adev, job, &adev->mman.entity,
                                       AMDGPU_FENCE_OWNER_UNDEFINED, fence)=
;
         if (r)
                 goto error_free;
@@ -2231,7 +2231,7 @@ int amdgpu_fill_buffer(struct amdgpu_bo *bo,

         amdgpu_ring_pad_ib(ring, &job->ibs[0]);
         WARN_ON(job->ibs[0].length_dw > num_dw);
-       r =3D amdgpu_job_submit(job, &adev->mman.entity,
+       r =3D amdgpu_job_submit(adev, job, &adev->mman.entity,
                               AMDGPU_FENCE_OWNER_UNDEFINED, fence);
         if (r)
                 goto error_free;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_uvd.c
index 5fd32ad1c575..8ff97b24914e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
@@ -1104,7 +1104,7 @@ static int amdgpu_uvd_send_msg(struct amdgpu_ring *ri=
ng, struct amdgpu_bo *bo,
                 if (r)
                         goto err_free;

-               r =3D amdgpu_job_submit(job, &adev->uvd.entity,
+               r =3D amdgpu_job_submit(adev, job, &adev->uvd.entity,
                                       AMDGPU_FENCE_OWNER_UNDEFINED, &f);
                 if (r)
                         goto err_free;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_vce.c
index 59ddba137946..e721d3367783 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
@@ -554,7 +554,7 @@ static int amdgpu_vce_get_destroy_msg(struct amdgpu_rin=
g *ring, uint32_t handle,
         if (direct)
                 r =3D amdgpu_job_submit_direct(job, ring, &f);
         else
-               r =3D amdgpu_job_submit(job, &ring->adev->vce.entity,
+               r =3D amdgpu_job_submit(ring->adev, job, &ring->adev->vce.e=
ntity,
                                       AMDGPU_FENCE_OWNER_UNDEFINED, &f);
         if (r)
                 goto err;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_vm_sdma.c
index 4cc7881f438c..b536962c22d9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
@@ -100,7 +100,7 @@ static int amdgpu_vm_sdma_commit(struct amdgpu_vm_updat=
e_params *p,
         WARN_ON(ib->length_dw =3D=3D 0);
         amdgpu_ring_pad_ib(ring, ib);
         WARN_ON(ib->length_dw > p->num_dw_left);
-       r =3D amdgpu_job_submit(p->job, entity, AMDGPU_FENCE_OWNER_VM, &f);
+       r =3D amdgpu_job_submit(p->adev, p->job, entity, AMDGPU_FENCE_OWNER=
_VM, &f);
         if (r)
                 goto error;

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/a=
mdgpu/gmc_v10_0.c
index 9775eca6fe43..a4aaa2a1f878 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -377,7 +377,7 @@ static void gmc_v10_0_flush_gpu_tlb(struct amdgpu_devic=
e *adev, uint32_t vmid,
         job->vm_needs_flush =3D true;
         job->ibs->ptr[job->ibs->length_dw++] =3D ring->funcs->nop;
         amdgpu_ring_pad_ib(ring, &job->ibs[0]);
-       r =3D amdgpu_job_submit(job, &adev->mman.entity,
+       r =3D amdgpu_job_submit(adev, job, &adev->mman.entity,
                               AMDGPU_FENCE_OWNER_UNDEFINED, &fence);
         if (r)
                 goto error_submit;
--
2.25.0




--_000_DM5PR12MB23765A9C06DB2B62ECF0B6208BEC0DM5PR12MB2376namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
</head>
<body>
<p style=3D"font-family:Arial;font-size:10pt;color:#0078D7;margin:15pt;" al=
ign=3D"Left">
[AMD Official Use Only - Internal Distribution Only]<br>
</p>
<br>
<div>
<div data-ogsc=3D"" style=3D"">
<meta content=3D"text/html; charset=3Dus-ascii" data-ogsc=3D"" style=3D"">
</div>
<div dir=3D"auto" style=3D"color: rgb(33, 33, 33); background-color: rgb(25=
5, 255, 255); text-align: left;">
Thanks Christian. I will try to send a updated patch soon.&nbsp;</div>
<div id=3D"ms-outlook-mobile-signature" data-ogsc=3D"" style=3D"text-align:=
 left;" dir=3D"auto">
<div><br>
</div>
Get <a href=3D"https://aka.ms/ghei36">Outlook for Android</a></div>
<div id=3D"id-3a39905a-0ef3-4e35-9b95-a5c89c0aa02a" class=3D"ms-outlook-mob=
ile-reference-message" data-ogsc=3D"" style=3D"">
<div style=3D"font-family: sans-serif; font-size: 12pt; color: rgb(0, 0, 0)=
;"><br>
</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"divRplyFwdMsg"><strong>From:</strong> Koenig, Christian &lt;Chri=
stian.Koenig@amd.com&gt;<br>
<strong>Sent:</strong> Monday, February 24, 2020, 18:06<br>
<strong>To:</strong> Nirmoy Das<br>
<strong>Cc:</strong> amd-gfx@lists.freedesktop.org; Deucher, Alexander; Liu=
, Monk; Li, Dennis; Das, Nirmoy<br>
<strong>Subject:</strong> Re: [RFC PATCH 1/1] drm/amdgpu: wait for sched to=
 become ready on job submit<br>
</div>
<br>
<meta content=3D"text/html; charset=3Dutf-8">
<div dir=3D"auto">
<div>Hi Nirmoy,<br>
<div class=3D"gmail_extra"><br>
<div class=3D"gmail_quote">Am 24.02.2020 17:48 schrieb Nirmoy Das &lt;nirmo=
y.aiemd@gmail.com&gt;:<br type=3D"attribution">
<blockquote class=3D"quote" style=3D"margin:0 0 0 .8ex; border-left:1px #cc=
c solid; padding-left:1ex">
<div><font size=3D"2"><span style=3D"font-size:11pt">
<div>On reset, amdgpu can set a drm sched's ready status to false temporari=
ly. drm job<br>
init will fail if all of the drm scheds are not ready for a HW IP. This pat=
ch tries to make<br>
kernel's internal drm job submit handle, amdgpu_job_submit() a bit more fau=
lt tolerant.<br>
</div>
</span></font></div>
</blockquote>
</div>
</div>
</div>
<div dir=3D"auto"><br>
</div>
<div dir=3D"auto">I don't think that this approach makes sense. Since it is=
 a front end property we should rather stop setting the scheduler ready sta=
tus to false during reset.</div>
<div dir=3D"auto"><br>
</div>
<div dir=3D"auto">Instead we should only set it to false when the ring/IB t=
est fails and we can't bring the ring back to life again.</div>
<div dir=3D"auto"><br>
</div>
<div dir=3D"auto">Christian.</div>
<div dir=3D"auto"><br>
</div>
<div dir=3D"auto">
<div class=3D"gmail_extra">
<div class=3D"gmail_quote">
<blockquote class=3D"quote" style=3D"margin:0 0 0 .8ex; border-left:1px #cc=
c solid; padding-left:1ex">
<div><font size=3D"2"><span style=3D"font-size:11pt">
<div><br>
Signed-off-by: Nirmoy Das &lt;nirmoy.das@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_job.c&nbsp;&nbsp;&nbsp;&nbsp; | 35 =
&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;=
&#43;&#43;&#43;&#43;--<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_job.h&nbsp;&nbsp;&nbsp;&nbsp; |&nbs=
p; 5 &#43;--<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c&nbsp;&nbsp;&nbsp;&nbsp; |&nbs=
p; 6 &#43;&#43;--<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c&nbsp;&nbsp;&nbsp;&nbsp; |&nbs=
p; 2 &#43;-<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c&nbsp;&nbsp;&nbsp;&nbsp; |&nbs=
p; 2 &#43;-<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c |&nbsp; 2 &#43;-<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
|&nbsp; 2 &#43;-<br>
&nbsp;7 files changed, 43 insertions(&#43;), 11 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_job.c<br>
index d42be880a236..0745df80112f 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c<br>
@@ -139,7 &#43;139,38 @@ void amdgpu_job_free(struct amdgpu_job *job)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfree(job);<br>
&nbsp;}<br>
&nbsp;<br>
-int amdgpu_job_submit(struct amdgpu_job *job, struct drm_sched_entity *ent=
ity,<br>
&#43;static int amdgpu_job_try_init(struct amdgpu_device *adev,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct drm_sched_job *base,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct drm_sched_entity *entity,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void *owner)<br>
&#43;{<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int r, i;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D drm_sched_job_init(base, en=
tity, owner);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r =3D=3D -ENOENT) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; /* retry till we come out of reset phase */<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; while (!mutex_trylock(&amp;adev-&gt;lock_reset))<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; msleep(10);<=
br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; /* retry for a second for the sched to get ready*/<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; for (i =3D 0; i &lt; 100; i&#43;&#43;) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; msleep(10);<=
br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D drm_sc=
hed_job_init(base, entity, owner);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r =3D=3D=
 -ENOENT)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; continue;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; }<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; mutex_unlock(&amp;adev-&gt;lock_reset);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; /* If after all these we failed to initialize a job<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; * it means the IP is unrecoverable */<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; if (r =3D=3D -ENOENT)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -ENOD=
EV;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;<br>
&#43;}<br>
&#43;<br>
&#43;int amdgpu_job_submit(struct amdgpu_device *adev,struct amdgpu_job *jo=
b,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct drm_sched_entity =
*entity,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void *owner, stru=
ct dma_fence **f)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum drm_sched_priority pr=
iority;<br>
@@ -149,7 &#43;180,7 @@ int amdgpu_job_submit(struct amdgpu_job *job, struc=
t drm_sched_entity *entity,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!f)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D drm_sched_job_init(&amp;job-&gt=
;base, entity, owner);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_job_try_init(adev, &=
amp;job-&gt;base, entity, owner);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return r;<br>
&nbsp;<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_job.h<br>
index 2e2110dddb76..fed87e96cacc 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h<br>
@@ -70,8 &#43;70,9 @@ int amdgpu_job_alloc_with_ib(struct amdgpu_device *ad=
ev, unsigned size,<br>
&nbsp;<br>
&nbsp;void amdgpu_job_free_resources(struct amdgpu_job *job);<br>
&nbsp;void amdgpu_job_free(struct amdgpu_job *job);<br>
-int amdgpu_job_submit(struct amdgpu_job *job, struct drm_sched_entity *ent=
ity,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void *owner, struct dma_fenc=
e **f);<br>
&#43;int amdgpu_job_submit(struct amdgpu_device *adev, struct amdgpu_job *j=
ob,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct drm_sched_entity =
*entity, void *owner,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dma_fence **f);<b=
r>
&nbsp;int amdgpu_job_submit_direct(struct amdgpu_job *job, struct amdgpu_ri=
ng *ring,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; struct dma_fence **fence);<br>
&nbsp;<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ttm.c<br>
index 660867cf2597..adfde07eb75f 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c<br>
@@ -2066,7 &#43;2066,7 @@ static int amdgpu_map_buffer(struct ttm_buffer_ob=
ject *bo,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; goto error_free;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_job_submit(job, &amp;ade=
v-&gt;mman.entity,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_job_submit(adev, job=
, &amp;adev-&gt;mman.entity,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_FENCE_OWNER_UNDEFINED, &amp;fence);<b=
r>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; goto error_free;<br>
@@ -2137,7 &#43;2137,7 @@ int amdgpu_copy_buffer(struct amdgpu_ring *ring, =
uint64_t src_offset,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (direct_submit)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_job_submit_direct(job, ring, fence);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; r =3D amdgpu_job_submit(job, &amp;adev-&gt;mman.entity,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; r =3D amdgpu_job_submit(adev, job, &amp;adev-&gt;mman.entity=
,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; AMDGPU_FENCE_OWNER_UNDEFINED, fence);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; goto error_free;<br>
@@ -2231,7 &#43;2231,7 @@ int amdgpu_fill_buffer(struct amdgpu_bo *bo,<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_pad_ib(ring, &=
amp;job-&gt;ibs[0]);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WARN_ON(job-&gt;ibs[0].len=
gth_dw &gt; num_dw);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_job_submit(job, &amp;ade=
v-&gt;mman.entity,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_job_submit(adev, job=
, &amp;adev-&gt;mman.entity,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_FENCE_OWNER_UNDEFINED, fence);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; goto error_free;<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_uvd.c<br>
index 5fd32ad1c575..8ff97b24914e 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c<br>
@@ -1104,7 &#43;1104,7 @@ static int amdgpu_uvd_send_msg(struct amdgpu_ring=
 *ring, struct amdgpu_bo *bo,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (r)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto =
err_free;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; r =3D amdgpu_job_submit(job, &amp;adev-&gt;uvd.entity,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; r =3D amdgpu_job_submit(adev, job, &amp;adev-&gt;uvd.entity,=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; AMDGPU_FENCE_OWNER_UNDEFINED, &amp;f);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (r)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto =
err_free;<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_vce.c<br>
index 59ddba137946..e721d3367783 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c<br>
@@ -554,7 &#43;554,7 @@ static int amdgpu_vce_get_destroy_msg(struct amdgpu=
_ring *ring, uint32_t handle,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (direct)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_job_submit_direct(job, ring, &amp;f);<br=
>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; r =3D amdgpu_job_submit(job, &amp;ring-&gt;adev-&gt;vce.entity,<=
br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; r =3D amdgpu_job_submit(ring-&gt;adev, job, &amp;ring-&gt;ad=
ev-&gt;vce.entity,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; AMDGPU_FENCE_OWNER_UNDEFINED, &amp;f);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; goto err;<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_vm_sdma.c<br>
index 4cc7881f438c..b536962c22d9 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c<br>
@@ -100,7 &#43;100,7 @@ static int amdgpu_vm_sdma_commit(struct amdgpu_vm_u=
pdate_params *p,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WARN_ON(ib-&gt;length_dw =
=3D=3D 0);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_pad_ib(ring, i=
b);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WARN_ON(ib-&gt;length_dw &=
gt; p-&gt;num_dw_left);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_job_submit(p-&gt;job, en=
tity, AMDGPU_FENCE_OWNER_VM, &amp;f);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_job_submit(p-&gt;ade=
v, p-&gt;job, entity, AMDGPU_FENCE_OWNER_VM, &amp;f);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; goto error;<br>
&nbsp;<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/a=
mdgpu/gmc_v10_0.c<br>
index 9775eca6fe43..a4aaa2a1f878 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c<br>
@@ -377,7 &#43;377,7 @@ static void gmc_v10_0_flush_gpu_tlb(struct amdgpu_d=
evice *adev, uint32_t vmid,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; job-&gt;vm_needs_flush =3D=
 true;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; job-&gt;ibs-&gt;ptr[job-&g=
t;ibs-&gt;length_dw&#43;&#43;] =3D ring-&gt;funcs-&gt;nop;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_pad_ib(ring, &=
amp;job-&gt;ibs[0]);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_job_submit(job, &amp;ade=
v-&gt;mman.entity,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_job_submit(adev, job=
, &amp;adev-&gt;mman.entity,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_FENCE_OWNER_UNDEFINED, &amp;fence);<b=
r>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; goto error_submit;<br>
-- <br>
2.25.0<br>
<br>
</div>
</span></font></div>
</blockquote>
</div>
<br>
</div>
</div>
</div>
<br>
</div>
</div>
</body>
</html>

--_000_DM5PR12MB23765A9C06DB2B62ECF0B6208BEC0DM5PR12MB2376namp_--

--===============1881874043==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1881874043==--
