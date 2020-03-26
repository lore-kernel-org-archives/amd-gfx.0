Return-Path: <SRS0=17Cd=5L=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35922C43331
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Mar 2020 05:38:28 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F2C0D206E6
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Mar 2020 05:38:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="CK0vtf9/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2C0D206E6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 61B936E264;
	Thu, 26 Mar 2020 05:38:27 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760077.outbound.protection.outlook.com [40.107.76.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BA8076E264
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Mar 2020 05:38:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PBVTavkaueOnCSqBqJkCngd5ZyEFXMzN8uRMuoaUjXERmmY8swchBad/PHj0J7ynLldS4acg32qP8loB/+owMTjI+KT76l6kEY71HeHIOOfyHykk1PVz1+doFinn0AtZSglf89AI5Iy6wWvYLXSSU03mIGtBiwxi2+v9zLSdBbl4a9aCLGFjJo7wdpNuvdY76u65zbAsV5crcxy3kfWSMZrMLi/nGOGAYe1S0KhWhbuNM2UGGlcpGkKH4xYF5anbRu1D0j/v+gGnGj/SEla01JH4sSSvtcW2WOiTm9ipYvzYmqLwIo6P8NtMabJCCay2qmp5p+b6SDtXQhF5JfR/sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7QgtdBDMPfTUm8PaBhPB4Rg1x7KTRR3fpWGTOzS5vaU=;
 b=ENYS3jgZZgx5nOxL8GAkenIi558w+TjCoA02Av17s0NY9M3eBcvVLr62Zo5TMjVJU0CWftltvtCNvl7LxPTxoOZ/AXJ4hVGD/PIdKWaYL15qeReGdRkEg4RBhBvGOcbR/Q9VdKQob5tCidJXYUqKyaKtohIf1Mqn1cSiNA2WDp39MQC0JyKjph2aQYsgRqv0Fgd2aRDBQ4El1JvMs7bUYHjJf02q7sx2ZgvyBeH1XTmQNedDuWG9fUDtk5ho20VQdbJbzS/0+fsYebzicSkjo1JclXb/69z0oXpv3/9EwepHZl2CHZacBRrl/C8688pT+pAW4HCUJWJO7u7+w/u6vA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7QgtdBDMPfTUm8PaBhPB4Rg1x7KTRR3fpWGTOzS5vaU=;
 b=CK0vtf9/m+7MFUZyubhNjs0m2OfDO22JcxH+J5topo/Qd5sSzntnovWdQdxmMC1M1gnpKKEddOWpe/mCkYeDsb9dP5WktobNkV/I5r3UBELJ40XNXFQ2t/Vxj73oV/bn1UCCfrNlN/eL515oCA4oVLHRChVgWbo+TPf8CFMcKD0=
Received: from DM6PR12MB4401.namprd12.prod.outlook.com (2603:10b6:5:2a9::15)
 by DM6PR12MB2763.namprd12.prod.outlook.com (2603:10b6:5:48::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.19; Thu, 26 Mar
 2020 05:38:21 +0000
Received: from DM6PR12MB4401.namprd12.prod.outlook.com
 ([fe80::f164:85c4:1b51:14d2]) by DM6PR12MB4401.namprd12.prod.outlook.com
 ([fe80::f164:85c4:1b51:14d2%4]) with mapi id 15.20.2856.019; Thu, 26 Mar 2020
 05:38:21 +0000
From: "Koenig, Christian" <Christian.Koenig@amd.com>
To: "Pan, Xinhui" <Xinhui.Pan@amd.com>
Subject: Re: [RFC PATCH 1/2] drm/amdgpu: add direct ib pool
Thread-Topic: [RFC PATCH 1/2] drm/amdgpu: add direct ib pool
Thread-Index: AQHWAxKQlIR6ybFd4kK6xpm0YTsr+KhaW2AU
Date: Thu, 26 Mar 2020 05:38:21 +0000
Message-ID: <c2d11468-f6c6-4b3c-a6be-af5c0e68c9b8@email.android.com>
References: <20200326020144.5953-1-xinhui.pan@amd.com>,
 <20200326020144.5953-2-xinhui.pan@amd.com>
In-Reply-To: <20200326020144.5953-2-xinhui.pan@amd.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com; 
x-originating-ip: [2a02:908:1252:fb60:dc49:624f:5fe9:21c1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 3a57b921-28ad-4a39-07f9-08d7d147e552
x-ms-traffictypediagnostic: DM6PR12MB2763:|DM6PR12MB2763:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB27631452D5DBCCC0DC76144D83CF0@DM6PR12MB2763.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0354B4BED2
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(396003)(366004)(136003)(346002)(376002)(6512007)(6506007)(31696002)(81156014)(81166006)(9686003)(76116006)(91956017)(66946007)(66446008)(64756008)(66556008)(66476007)(478600001)(8936002)(2906002)(6862004)(31686004)(86362001)(4326008)(71200400001)(5660300002)(8676002)(186003)(6486002)(6636002)(54906003)(316002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB2763;
 H:DM6PR12MB4401.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: G6NT8nzIB6yikXNMQmSlXg6sAeGPnmsFGhkdcGVFLBGi6srSyPjq3Zk9wxP9MaQDO/eDfE0jks08s84h7x2AoeI4jarfWNn++ywkyHL5LHcjWzNRD8qevKgKK914TxjB9CZbKgdVsB+LvdliI7Q66hT0s9cze9xe52mjMxP7Qx3254F/Thay+stekkO1fwqGfGPx/dksQkhJ9+1xZJ4pJr+apxe8++XH/lfecZG8aVyDnKJYQpsj78GyfXaSowZuWjaasUqgbzQgP1Yq11x5zkqPu+JYGA9ytpg2xcCrjtaLOQz7lf8jqtFU7o5kRuJzZ+YseDQfnJM5W6j6yDArkcjtf30+HPQNJ1CYIcQPV1jzX6gJb2KyViGCBacVfYSl7DCW4fD5aQXdZPUhG2/gQYf1IsSIJ8EgzOLvrPlM+2AWHkneth9TmIldRMdEfvqK
x-ms-exchange-antispam-messagedata: CeGQgdU7jnfQtbUMmOVP/84wrBgNk4La4MvpRNCL0g7sE7lsaDaCdRgGVcRclYdaUbWayEeGXLUZ1ksew9rPFKsxwjB+K4DybQ++fGat/7XkDZGs3z6FdctJY28V8SvW1w/Z9GKJ8G3kmIjdblz1hzzQGK1BlgISZp41jP+uZpe2HKL2UDVrvvWbsEkPKsn1I9lYBI5kamgahTZiFuIbUg==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a57b921-28ad-4a39-07f9-08d7d147e552
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Mar 2020 05:38:21.5629 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mSNae/AtHA6FOoWEASbmfqWK+knSjbjw7mOCWD6vw0VaAawhr4fylSBeGYT5h0kV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2763
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Kuehling,
 Felix" <Felix.Kuehling@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: multipart/mixed; boundary="===============0769158324=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0769158324==
Content-Language: de-DE
Content-Type: multipart/alternative;
	boundary="_000_c2d11468f6c64b3ca6beaf5c0e68c9b8emailandroidcom_"

--_000_c2d11468f6c64b3ca6beaf5c0e68c9b8emailandroidcom_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Yeah that's on my TODO list for quite a while as well.

But we even need three IB pools. One very small for the IB tests, one for d=
irect VM updates and one for the rest.

So please make the pool a parameter to ib_get() and not the hack you have b=
elow.

Thanks,
Christian.

Am 26.03.2020 03:02 schrieb "Pan, Xinhui" <Xinhui.Pan@amd.com>:
Another ib poll for direct submit.
Any jobs schedule IBs without dependence on gpu scheduler should use
this pool firstly.

Signed-off-by: xinhui pan <xinhui.pan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h     |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c  |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c  | 12 ++++++++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c |  8 +++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.h |  3 ++-
 5 files changed, 21 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdg=
pu/amdgpu.h
index 7dd74253e7b6..c01423ffb8ed 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -849,6 +849,7 @@ struct amdgpu_device {
         struct amdgpu_ring              *rings[AMDGPU_MAX_RINGS];
         bool                            ib_pool_ready;
         struct amdgpu_sa_manager        ring_tmp_bo;
+       struct amdgpu_sa_manager        ring_tmp_bo_direct;

         /* interrupts */
         struct amdgpu_irq               irq;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/a=
mdgpu/amdgpu_cs.c
index 8304d0c87899..28be4efb3d5b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -920,7 +920,7 @@ static int amdgpu_cs_ib_fill(struct amdgpu_device *adev=
,
                 parser->entity =3D entity;

                 ring =3D to_amdgpu_ring(entity->rq->sched);
-               r =3D  amdgpu_ib_get(adev, vm, ring->funcs->parse_cs ?
+               r =3D  amdgpu_ib_get(adev, (unsigned long )vm|0x1, ring->fu=
ncs->parse_cs ?
                                    chunk_ib->ib_bytes : 0, ib);
                 if (r) {
                         DRM_ERROR("Failed to get ib !\n");
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c b/drivers/gpu/drm/amd/a=
mdgpu/amdgpu_ib.c
index bece01f1cf09..f2e08c372d57 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
@@ -66,7 +66,7 @@ int amdgpu_ib_get(struct amdgpu_device *adev, struct amdg=
pu_vm *vm,
         int r;

         if (size) {
-               r =3D amdgpu_sa_bo_new(&adev->ring_tmp_bo,
+               r =3D amdgpu_sa_bo_new(vm ? &adev->ring_tmp_bo : &adev->rin=
g_tmp_bo_direct,
                                       &ib->sa_bo, size, 256);
                 if (r) {
                         dev_err(adev->dev, "failed to get a new IB (%d)\n"=
, r);
@@ -75,7 +75,7 @@ int amdgpu_ib_get(struct amdgpu_device *adev, struct amdg=
pu_vm *vm,

                 ib->ptr =3D amdgpu_sa_bo_cpu_addr(ib->sa_bo);

-               if (!vm)
+               if (!((unsigned long)vm & ~0x1))
                         ib->gpu_addr =3D amdgpu_sa_bo_gpu_addr(ib->sa_bo);
         }

@@ -310,6 +310,13 @@ int amdgpu_ib_pool_init(struct amdgpu_device *adev)
                 return r;
         }

+       r =3D amdgpu_sa_bo_manager_init(adev, &adev->ring_tmp_bo_direct,
+                                     AMDGPU_IB_POOL_SIZE*64*1024,
+                                     AMDGPU_GPU_PAGE_SIZE,
+                                     AMDGPU_GEM_DOMAIN_GTT);
+       if (r) {
+               return r;
+       }
         adev->ib_pool_ready =3D true;

         return 0;
@@ -327,6 +334,7 @@ void amdgpu_ib_pool_fini(struct amdgpu_device *adev)
 {
         if (adev->ib_pool_ready) {
                 amdgpu_sa_bo_manager_fini(adev, &adev->ring_tmp_bo);
+               amdgpu_sa_bo_manager_fini(adev, &adev->ring_tmp_bo_direct);
                 adev->ib_pool_ready =3D false;
         }
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_job.c
index 4981e443a884..6a63826c6760 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
@@ -88,6 +88,12 @@ int amdgpu_job_alloc(struct amdgpu_device *adev, unsigne=
d num_ibs,

 int amdgpu_job_alloc_with_ib(struct amdgpu_device *adev, unsigned size,
                              struct amdgpu_job **job)
+{
+       return amdgpu_job_alloc_with_ib_direct(adev, size, job, 0);
+}
+
+int amdgpu_job_alloc_with_ib_direct(struct amdgpu_device *adev, unsigned s=
ize,
+                            struct amdgpu_job **job, int direct)
 {
         int r;

@@ -95,7 +101,7 @@ int amdgpu_job_alloc_with_ib(struct amdgpu_device *adev,=
 unsigned size,
         if (r)
                 return r;

-       r =3D amdgpu_ib_get(adev, NULL, size, &(*job)->ibs[0]);
+       r =3D amdgpu_ib_get(adev, direct ? NULL : 0x1, size, &(*job)->ibs[0=
]);
         if (r)
                 kfree(*job);

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_job.h
index 2e2110dddb76..be9dd72b9912 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
@@ -67,7 +67,8 @@ int amdgpu_job_alloc(struct amdgpu_device *adev, unsigned=
 num_ibs,
                      struct amdgpu_job **job, struct amdgpu_vm *vm);
 int amdgpu_job_alloc_with_ib(struct amdgpu_device *adev, unsigned size,
                              struct amdgpu_job **job);
-
+int amdgpu_job_alloc_with_ib_direct(struct amdgpu_device *adev, unsigned s=
ize,
+                            struct amdgpu_job **job, int direct);
 void amdgpu_job_free_resources(struct amdgpu_job *job);
 void amdgpu_job_free(struct amdgpu_job *job);
 int amdgpu_job_submit(struct amdgpu_job *job, struct drm_sched_entity *ent=
ity,
--
2.17.1


--_000_c2d11468f6c64b3ca6beaf5c0e68c9b8emailandroidcom_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<meta name=3D"Generator" content=3D"Microsoft Exchange Server">
<!-- converted from text --><style><!-- .EmailQuote { margin-left: 1pt; pad=
ding-left: 4pt; border-left: #800000 2px solid; } --></style>
</head>
<body>
<div>
<div dir=3D"auto">Yeah that's on my TODO list for quite a while as well.
<div dir=3D"auto"><br>
</div>
<div dir=3D"auto">But we even need three IB pools. One very small for the I=
B tests, one for direct VM updates and one for the rest.</div>
<div dir=3D"auto"><br>
</div>
<div dir=3D"auto">So please make the pool a parameter to ib_get() and not t=
he hack you have below.</div>
<div dir=3D"auto"><br>
</div>
<div dir=3D"auto">Thanks,</div>
<div dir=3D"auto">Christian.</div>
</div>
<div class=3D"x_gmail_extra"><br>
<div class=3D"x_gmail_quote">Am 26.03.2020 03:02 schrieb &quot;Pan, Xinhui&=
quot; &lt;Xinhui.Pan@amd.com&gt;:<br type=3D"attribution">
</div>
</div>
</div>
<font size=3D"2"><span style=3D"font-size:11pt;">
<div class=3D"PlainText">Another ib poll for direct submit.<br>
Any jobs schedule IBs without dependence on gpu scheduler should use<br>
this pool firstly.<br>
<br>
Signed-off-by: xinhui pan &lt;xinhui.pan@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu.h&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 1=
 &#43;<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c&nbsp; |&nbsp; 2 &#43;-<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c&nbsp; | 12 &#43;&#43;&#43;&#43=
;&#43;&#43;&#43;&#43;&#43;&#43;--<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_job.c |&nbsp; 8 &#43;&#43;&#43;&#43=
;&#43;&#43;&#43;-<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_job.h |&nbsp; 3 &#43;&#43;-<br>
&nbsp;5 files changed, 21 insertions(&#43;), 5 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdg=
pu/amdgpu.h<br>
index 7dd74253e7b6..c01423ffb8ed 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu.h<br>
@@ -849,6 &#43;849,7 @@ struct amdgpu_device {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_ring&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *rin=
gs[AMDGPU_MAX_RINGS];<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ib_pool_r=
eady;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_sa_manager&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ring_tmp_bo;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_sa_manager&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ring_tmp_bo_direct;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* interrupts */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_irq&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 irq;<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/a=
mdgpu/amdgpu_cs.c<br>
index 8304d0c87899..28be4efb3d5b 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c<br>
@@ -920,7 &#43;920,7 @@ static int amdgpu_cs_ib_fill(struct amdgpu_device *=
adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; parser-&gt;entity =3D entity;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; ring =3D to_amdgpu_ring(entity-&gt;rq-&gt;sched);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; r =3D&nbsp; amdgpu_ib_get(adev, vm, ring-&gt;funcs-&gt;parse_cs =
?<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; r =3D&nbsp; amdgpu_ib_get(adev, (unsigned long )vm|0x1, ring=
-&gt;funcs-&gt;parse_cs ?<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; chunk_ib-&gt;i=
b_bytes : 0, ib);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (r) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_E=
RROR(&quot;Failed to get ib !\n&quot;);<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c b/drivers/gpu/drm/amd/a=
mdgpu/amdgpu_ib.c<br>
index bece01f1cf09..f2e08c372d57 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c<br>
@@ -66,7 &#43;66,7 @@ int amdgpu_ib_get(struct amdgpu_device *adev, struct =
amdgpu_vm *vm,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int r;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (size) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; r =3D amdgpu_sa_bo_new(&amp;adev-&gt;ring_tmp_bo,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; r =3D amdgpu_sa_bo_new(vm ? &amp;adev-&gt;ring_tmp_bo : &amp=
;adev-&gt;ring_tmp_bo_direct,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; &amp;ib-&gt;sa_bo, size, 256);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (r) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_e=
rr(adev-&gt;dev, &quot;failed to get a new IB (%d)\n&quot;, r);<br>
@@ -75,7 &#43;75,7 @@ int amdgpu_ib_get(struct amdgpu_device *adev, struct =
amdgpu_vm *vm,<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; ib-&gt;ptr =3D amdgpu_sa_bo_cpu_addr(ib-&gt;sa_bo);<b=
r>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (!vm)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; if (!((unsigned long)vm &amp; ~0x1))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ib-&g=
t;gpu_addr =3D amdgpu_sa_bo_gpu_addr(ib-&gt;sa_bo);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
@@ -310,6 &#43;310,13 @@ int amdgpu_ib_pool_init(struct amdgpu_device *adev=
)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return r;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_sa_bo_manager_init(a=
dev, &amp;adev-&gt;ring_tmp_bo_direct,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMD=
GPU_IB_POOL_SIZE*64*1024,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMD=
GPU_GPU_PAGE_SIZE,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMD=
GPU_GEM_DOMAIN_GTT);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return r;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;ib_pool_ready =3D=
 true;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
@@ -327,6 &#43;334,7 @@ void amdgpu_ib_pool_fini(struct amdgpu_device *adev=
)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;ib_pool_ready=
) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; amdgpu_sa_bo_manager_fini(adev, &amp;adev-&gt;ring_tm=
p_bo);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; amdgpu_sa_bo_manager_fini(adev, &amp;adev-&gt;ring_tmp_bo_di=
rect);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; adev-&gt;ib_pool_ready =3D false;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;}<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_job.c<br>
index 4981e443a884..6a63826c6760 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c<br>
@@ -88,6 &#43;88,12 @@ int amdgpu_job_alloc(struct amdgpu_device *adev, uns=
igned num_ibs,<br>
&nbsp;<br>
&nbsp;int amdgpu_job_alloc_with_ib(struct amdgpu_device *adev, unsigned siz=
e,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_job **job)<br>
&#43;{<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return amdgpu_job_alloc_with_ib_d=
irect(adev, size, job, 0);<br>
&#43;}<br>
&#43;<br>
&#43;int amdgpu_job_alloc_with_ib_direct(struct amdgpu_device *adev, unsign=
ed size,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; struct amdgpu_job **job, int direct)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int r;<br>
&nbsp;<br>
@@ -95,7 &#43;101,7 @@ int amdgpu_job_alloc_with_ib(struct amdgpu_device *a=
dev, unsigned size,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return r;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_ib_get(adev, NULL, size,=
 &amp;(*job)-&gt;ibs[0]);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_ib_get(adev, direct =
? NULL : 0x1, size, &amp;(*job)-&gt;ibs[0]);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; kfree(*job);<br>
&nbsp;<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_job.h<br>
index 2e2110dddb76..be9dd72b9912 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h<br>
@@ -67,7 &#43;67,8 @@ int amdgpu_job_alloc(struct amdgpu_device *adev, unsi=
gned num_ibs,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_job **job=
, struct amdgpu_vm *vm);<br>
&nbsp;int amdgpu_job_alloc_with_ib(struct amdgpu_device *adev, unsigned siz=
e,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_job **job);<br>
-<br>
&#43;int amdgpu_job_alloc_with_ib_direct(struct amdgpu_device *adev, unsign=
ed size,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; struct amdgpu_job **job, int direct);<br>
&nbsp;void amdgpu_job_free_resources(struct amdgpu_job *job);<br>
&nbsp;void amdgpu_job_free(struct amdgpu_job *job);<br>
&nbsp;int amdgpu_job_submit(struct amdgpu_job *job, struct drm_sched_entity=
 *entity,<br>
-- <br>
2.17.1<br>
<br>
</div>
</span></font>
</body>
</html>

--_000_c2d11468f6c64b3ca6beaf5c0e68c9b8emailandroidcom_--

--===============0769158324==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0769158324==--
