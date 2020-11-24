Return-Path: <SRS0=xWtd=E6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_ADSP_ALL,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0BC3C2D0E4
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Nov 2020 02:54:32 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 41BD520719
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Nov 2020 02:54:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=valvesoftware.com header.i=@valvesoftware.com header.b="iYeNpUbU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41BD520719
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=valvesoftware.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 71B3889DB2;
	Tue, 24 Nov 2020 02:54:31 +0000 (UTC)
X-Greylist: delayed 372 seconds by postgrey-1.36 at gabe;
 Tue, 24 Nov 2020 02:54:30 UTC
Received: from us-smtp-delivery-172.mimecast.com
 (us-smtp-delivery-172.mimecast.com [216.205.24.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B93C689DB2
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Nov 2020 02:54:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valvesoftware.com;
 s=mc20150811; t=1606186469;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kRBSQSws8D+BAQx1wQI7afVPmn89P+ji44ZNucbYSKU=;
 b=iYeNpUbUW+3BrVmAjAHhnlItcvCHld8DMpkSyaU5IlfT8jf8rU0c1RSEHbcCOHCQFzmENU
 alX/9pRJqdz5j23mjsmr6AoZg6wddH2WSKTEOCO2eLD8x5JfvR3HnK302KVJuNh7/3j7UK
 ZKClN7w4/dZ/HGWz3G/xSJAMXeppq4Q=
Received: from smtp-01-blv1.valvesoftware.com (smtp01.valvesoftware.com
 [208.64.203.181]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-421-gYPPi6pTOuStPNyJH_jMqw-1; Mon, 23 Nov 2020 21:48:12 -0500
X-MC-Unique: gYPPi6pTOuStPNyJH_jMqw-1
Received: from [172.16.1.107] (helo=antispam.valve.org)
 by smtp-01-blv1.valvesoftware.com with esmtp (Exim 4.86_2)
 (envelope-from <pgriffais@valvesoftware.com>) id 1khONH-0002L1-Nd
 for amd-gfx@lists.freedesktop.org; Mon, 23 Nov 2020 18:48:11 -0800
Received: from antispam.valve.org (127.0.0.1) id hnhq6m0171s6 for
 <amd-gfx@lists.freedesktop.org>;
 Mon, 23 Nov 2020 18:48:11 -0800 (envelope-from <pgriffais@valvesoftware.com>)
Received: from mail1.valvemail.org ([172.16.144.22])
 by antispam.valve.org ([172.16.1.107]) (SonicWALL 9.0.5.2081 )
 with ESMTP id o202011240248110008505-5; Mon, 23 Nov 2020 18:48:11 -0800
Received: from [172.18.21.23] (172.18.21.23) by mail1.valvemail.org
 (172.16.144.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2044.4; Mon, 23 Nov
 2020 18:48:11 -0800
Subject: Re: [PATCH] drm/amdgpu: unpack dma_fence_chain containers during sync
To: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
References: <20201118132039.2336-1-christian.koenig@amd.com>
 <1a20a665-f859-6ed3-be98-48cb5b9fcf37@gmail.com>
 <CAAxE2A5BLn0ygJc6nx5QPW1qWq6hpvQbzFm51pzan+jhe_BWWw@mail.gmail.com>
 <53b5d31f-e533-0fb3-0907-76d2f3730af3@gmail.com>
 <CAAxE2A4MThFV0Whms5QGHmXNhhw-9++naxWV0n=HqinJAOupSw@mail.gmail.com>
From: "Pierre-Loup A. Griffais" <pgriffais@valvesoftware.com>
Message-ID: <8c9a2e5d-fbfc-45b9-f0de-92e292fcb7e7@valvesoftware.com>
Date: Mon, 23 Nov 2020 18:48:10 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <CAAxE2A4MThFV0Whms5QGHmXNhhw-9++naxWV0n=HqinJAOupSw@mail.gmail.com>
X-ClientProxiedBy: mail1.valvemail.org (172.16.144.22) To mail1.valvemail.org
 (172.16.144.22)
X-EXCLAIMER-MD-CONFIG: fe5cb8ea-1338-4c54-81e0-ad323678e037
X-Mlf-CnxnMgmt-Allow: 172.16.144.22
X-Mlf-Version: 9.0.5.2081
X-Mlf-License: BSVKCAP__
X-Mlf-UniqueId: o202011240248110008505
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA72A183 smtp.mailfrom=pgriffais@valvesoftware.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: valvesoftware.com
Content-Language: en-US
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
Cc: Pierre-Eric Pelloux-Prayer <Pierre-eric.Pelloux-prayer@amd.com>,
 amd-gfx mailing list <amd-gfx@lists.freedesktop.org>
Content-Type: multipart/mixed; boundary="===============0805401206=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0805401206==
Content-Type: multipart/alternative;
	boundary="------------81E16703787DE16773E477EB"
Content-Language: en-US

--------------81E16703787DE16773E477EB
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

I just built my kernel with it and tested Horizon Zero Dawn on stock=20
Proton 5.13, and it doesn't seem to change things there.

This pattern looks identical as with before the kernel patch, as far as=20
I can tell:

https://imgur.com/a/1fZWgNG

The last purple block is a piece of GPU work on the gfx ring. It's been=20
queued by software 0.7ms ago, but doesn't get put on the HW ring until=20
right after the previous piece of GPU work completes. The orange chunk=20
below is the 'gfx' kernel task executing, to queue it.

Thanks,

 =C2=A0- Pierre-Loup

On 2020-11-23 18:09, Marek Ol=C5=A1=C3=A1k wrote:
> Pierre-Loup, does this do what you requested?
>
> Thanks,
> Marek
>
> On Mon, Nov 23, 2020 at 3:17 PM Christian K=C3=B6nig=20
> <ckoenig.leichtzumerken@gmail.com=20
> <mailto:ckoenig.leichtzumerken@gmail.com>> wrote:
>
>     That the CPU round trip is gone now.
>
>     Christian.
>
>     Am 23.11.20 um 20:49 schrieb Marek Ol=C5=A1=C3=A1k:
>>     What is the behavior we should expect?
>>
>>     Marek
>>
>>     On Mon, Nov 23, 2020 at 7:31 AM Christian K=C3=B6nig
>>     <ckoenig.leichtzumerken@gmail.com
>>     <mailto:ckoenig.leichtzumerken@gmail.com>> wrote:
>>
>>         Ping, Pierre/Marek does this change works as expected?
>>
>>         Regards,
>>         Christian.
>>
>>         Am 18.11.20 um 14:20 schrieb Christian K=C3=B6nig:
>>         > This allows for optimizing the CPU round trip away.
>>         >
>>         > Signed-off-by: Christian K=C3=B6nig <christian.koenig@amd.com
>>         <mailto:christian.koenig@amd.com>>
>>         > ---
>>         >=C2=A0 =C2=A0drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c=C2=A0 =C2=
=A0|=C2=A0 2 +-
>>         >=C2=A0 =C2=A0drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c | 27
>>         ++++++++++++++++++++++++
>>         >=C2=A0 =C2=A0drivers/gpu/drm/amd/amdgpu/amdgpu_sync.h |=C2=A0 1=
 +
>>         >=C2=A0 =C2=A03 files changed, 29 insertions(+), 1 deletion(-)
>>         >
>>         > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
>>         b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
>>         > index 79342976fa76..68f9a4adf5d2 100644
>>         > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
>>         > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
>>         > @@ -1014,7 +1014,7 @@ static int
>>         amdgpu_syncobj_lookup_and_add_to_sync(struct amdgpu_cs_parser *p=
,
>>         >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return r=
;
>>         >=C2=A0 =C2=A0 =C2=A0 =C2=A0}
>>         >
>>         > -=C2=A0 =C2=A0 =C2=A0r =3D amdgpu_sync_fence(&p->job->sync, fe=
nce);
>>         > +=C2=A0 =C2=A0 =C2=A0r =3D amdgpu_sync_fence_chain(&p->job->sy=
nc, fence);
>>         >=C2=A0 =C2=A0 =C2=A0 =C2=A0dma_fence_put(fence);
>>         >
>>         >=C2=A0 =C2=A0 =C2=A0 =C2=A0return r;
>>         > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c
>>         b/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c
>>         > index 8ea6c49529e7..d0d64af06f54 100644
>>         > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c
>>         > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c
>>         > @@ -28,6 +28,8 @@
>>         >=C2=A0 =C2=A0 *=C2=A0 =C2=A0 Christian K=C3=B6nig <christian.ko=
enig@amd.com
>>         <mailto:christian.koenig@amd.com>>
>>         >=C2=A0 =C2=A0 */
>>         >
>>         > +#include <linux/dma-fence-chain.h>
>>         > +
>>         >=C2=A0 =C2=A0#include "amdgpu.h"
>>         >=C2=A0 =C2=A0#include "amdgpu_trace.h"
>>         >=C2=A0 =C2=A0#include "amdgpu_amdkfd.h"
>>         > @@ -169,6 +171,31 @@ int amdgpu_sync_fence(struct
>>         amdgpu_sync *sync, struct dma_fence *f)
>>         >=C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;
>>         >=C2=A0 =C2=A0}
>>         >
>>         > +/**
>>         > + * amdgpu_sync_fence_chain - unpack dma_fence_chain and sync
>>         > + *
>>         > + * @sync: sync object to add fence to
>>         > + * @f: potential dma_fence_chain to sync to.
>>         > + *
>>         > + * Add the fences inside the chain to the sync object.
>>         > + */
>>         > +int amdgpu_sync_fence_chain(struct amdgpu_sync *sync,
>>         struct dma_fence *f)
>>         > +{
>>         > +=C2=A0 =C2=A0 =C2=A0int r;
>>         > +
>>         > +=C2=A0 =C2=A0 =C2=A0dma_fence_chain_for_each(f, f) {
>>         > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (dma_fence=
_is_signaled(f))
>>         > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0continue;
>>         > +
>>         > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0r =3D amdgpu_=
sync_fence(sync, f);
>>         > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (r) {
>>         > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0dma_fence_put(f);
>>         > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0return r;
>>         > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>>         > +=C2=A0 =C2=A0 =C2=A0}
>>         > +=C2=A0 =C2=A0 =C2=A0return 0;
>>         > +}
>>         > +
>>         >=C2=A0 =C2=A0/**
>>         >=C2=A0 =C2=A0 * amdgpu_sync_vm_fence - remember to sync to this=
 VM fence
>>         >=C2=A0 =C2=A0 *
>>         > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.h
>>         b/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.h
>>         > index 7c0fe20c470d..b142175b65b6 100644
>>         > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.h
>>         > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.h
>>         > @@ -48,6 +48,7 @@ struct amdgpu_sync {
>>         >
>>         >=C2=A0 =C2=A0void amdgpu_sync_create(struct amdgpu_sync *sync);
>>         >=C2=A0 =C2=A0int amdgpu_sync_fence(struct amdgpu_sync *sync, st=
ruct
>>         dma_fence *f);
>>         > +int amdgpu_sync_fence_chain(struct amdgpu_sync *sync,
>>         struct dma_fence *f);
>>         >=C2=A0 =C2=A0int amdgpu_sync_vm_fence(struct amdgpu_sync *sync,=
 struct
>>         dma_fence *fence);
>>         >=C2=A0 =C2=A0int amdgpu_sync_resv(struct amdgpu_device *adev, s=
truct
>>         amdgpu_sync *sync,
>>         >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 struct dma_resv *resv, enum
>>         amdgpu_sync_mode mode,
>>
>>         _______________________________________________
>>         amd-gfx mailing list
>>         amd-gfx@lists.freedesktop.org
>>         <mailto:amd-gfx@lists.freedesktop.org>
>>         https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>>
>

--------------81E16703787DE16773E477EB
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<html>
  <head>
    <meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3DUTF-8=
">
  </head>
  <body>
    <p>I just built my kernel with it and tested Horizon Zero Dawn on
      stock Proton 5.13, and it doesn't seem to change things there.</p>
    <p>This pattern looks identical as with before the kernel patch, as
      far as I can tell:</p>
    <p><a class=3D"moz-txt-link-freetext" href=3D"https://imgur.com/a/1fZWg=
NG">https://imgur.com/a/1fZWgNG</a></p>
    <p>The last purple block is a piece of GPU work on the gfx ring.
      It's been queued by software 0.7ms ago, but doesn't get put on the
      HW ring until right after the previous piece of GPU work
      completes. The orange chunk below is the 'gfx' kernel task
      executing, to queue it.</p>
    <p>Thanks,</p>
    <p>=C2=A0- Pierre-Loup<br>
    </p>
    On 2020-11-23 18:09, Marek Ol=C5=A1=C3=A1k wrote:<br>
    <blockquote type=3D"cite"
cite=3D"mid:CAAxE2A4MThFV0Whms5QGHmXNhhw-9++naxWV0n=3DHqinJAOupSw@mail.gmai=
l.com">
      <meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3DUTF=
-8">
      <div dir=3D"ltr">
        <div>Pierre-Loup, does this do what you requested?</div>
        <div><br>
        </div>
        <div>Thanks,</div>
        <div>Marek<br>
        </div>
      </div>
      <br>
      <div class=3D"gmail_quote">
        <div dir=3D"ltr" class=3D"gmail_attr">On Mon, Nov 23, 2020 at 3:17
          PM Christian K=C3=B6nig &lt;<a
            href=3D"mailto:ckoenig.leichtzumerken@gmail.com"
            moz-do-not-send=3D"true">ckoenig.leichtzumerken@gmail.com</a>&g=
t;
          wrote:<br>
        </div>
        <blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px
          0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
          <div>
            <div>That the CPU round trip is gone now.<br>
              <br>
              Christian.<br>
              <br>
              Am 23.11.20 um 20:49 schrieb Marek Ol=C5=A1=C3=A1k:<br>
            </div>
            <blockquote type=3D"cite">
              <div dir=3D"ltr">
                <div>What is the behavior we should expect?</div>
                <div><br>
                </div>
                <div>Marek<br>
                </div>
              </div>
              <br>
              <div class=3D"gmail_quote">
                <div dir=3D"ltr" class=3D"gmail_attr">On Mon, Nov 23, 2020
                  at 7:31 AM Christian K=C3=B6nig &lt;<a
                    href=3D"mailto:ckoenig.leichtzumerken@gmail.com"
                    target=3D"_blank" moz-do-not-send=3D"true">ckoenig.leic=
htzumerken@gmail.com</a>&gt;
                  wrote:<br>
                </div>
                <blockquote class=3D"gmail_quote" style=3D"margin:0px 0px
                  0px 0.8ex;border-left:1px solid
                  rgb(204,204,204);padding-left:1ex">Ping, Pierre/Marek
                  does this change works as expected?<br>
                  <br>
                  Regards,<br>
                  Christian.<br>
                  <br>
                  Am 18.11.20 um 14:20 schrieb Christian K=C3=B6nig:<br>
                  &gt; This allows for optimizing the CPU round trip
                  away.<br>
                  &gt;<br>
                  &gt; Signed-off-by: Christian K=C3=B6nig &lt;<a
                    href=3D"mailto:christian.koenig@amd.com"
                    target=3D"_blank" moz-do-not-send=3D"true">christian.ko=
enig@amd.com</a>&gt;<br>
                  &gt; ---<br>
                  &gt;=C2=A0 =C2=A0drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c=
=C2=A0 =C2=A0|=C2=A0 2
                  +-<br>
                  &gt;=C2=A0 =C2=A0drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c=
 | 27
                  ++++++++++++++++++++++++<br>
                  &gt;=C2=A0 =C2=A0drivers/gpu/drm/amd/amdgpu/amdgpu_sync.h=
 |=C2=A0 1 +<br>
                  &gt;=C2=A0 =C2=A03 files changed, 29 insertions(+), 1
                  deletion(-)<br>
                  &gt;<br>
                  &gt; diff --git
                  a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
                  b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c<br>
                  &gt; index 79342976fa76..68f9a4adf5d2 100644<br>
                  &gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c<br>
                  &gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c<br>
                  &gt; @@ -1014,7 +1014,7 @@ static int
                  amdgpu_syncobj_lookup_and_add_to_sync(struct
                  amdgpu_cs_parser *p,<br>
                  &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0return r;<br>
                  &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
                  &gt;=C2=A0 =C2=A0<br>
                  &gt; -=C2=A0 =C2=A0 =C2=A0r =3D
                  amdgpu_sync_fence(&amp;p-&gt;job-&gt;sync, fence);<br>
                  &gt; +=C2=A0 =C2=A0 =C2=A0r =3D
                  amdgpu_sync_fence_chain(&amp;p-&gt;job-&gt;sync,
                  fence);<br>
                  &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0dma_fence_put(fence);<br>
                  &gt;=C2=A0 =C2=A0<br>
                  &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0return r;<br>
                  &gt; diff --git
                  a/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c
                  b/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c<br>
                  &gt; index 8ea6c49529e7..d0d64af06f54 100644<br>
                  &gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c<br>
                  &gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c<br>
                  &gt; @@ -28,6 +28,8 @@<br>
                  &gt;=C2=A0 =C2=A0 *=C2=A0 =C2=A0 Christian K=C3=B6nig &lt=
;<a
                    href=3D"mailto:christian.koenig@amd.com"
                    target=3D"_blank" moz-do-not-send=3D"true">christian.ko=
enig@amd.com</a>&gt;<br>
                  &gt;=C2=A0 =C2=A0 */<br>
                  &gt;=C2=A0 =C2=A0<br>
                  &gt; +#include &lt;linux/dma-fence-chain.h&gt;<br>
                  &gt; +<br>
                  &gt;=C2=A0 =C2=A0#include "amdgpu.h"<br>
                  &gt;=C2=A0 =C2=A0#include "amdgpu_trace.h"<br>
                  &gt;=C2=A0 =C2=A0#include "amdgpu_amdkfd.h"<br>
                  &gt; @@ -169,6 +171,31 @@ int amdgpu_sync_fence(struct
                  amdgpu_sync *sync, struct dma_fence *f)<br>
                  &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
                  &gt;=C2=A0 =C2=A0}<br>
                  &gt;=C2=A0 =C2=A0<br>
                  &gt; +/**<br>
                  &gt; + * amdgpu_sync_fence_chain - unpack
                  dma_fence_chain and sync<br>
                  &gt; + *<br>
                  &gt; + * @sync: sync object to add fence to<br>
                  &gt; + * @f: potential dma_fence_chain to sync to.<br>
                  &gt; + *<br>
                  &gt; + * Add the fences inside the chain to the sync
                  object.<br>
                  &gt; + */<br>
                  &gt; +int amdgpu_sync_fence_chain(struct amdgpu_sync
                  *sync, struct dma_fence *f)<br>
                  &gt; +{<br>
                  &gt; +=C2=A0 =C2=A0 =C2=A0int r;<br>
                  &gt; +<br>
                  &gt; +=C2=A0 =C2=A0 =C2=A0dma_fence_chain_for_each(f, f) =
{<br>
                  &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if =
(dma_fence_is_signaled(f))<br>
                  &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0continue;<br>
                  &gt; +<br>
                  &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0r =
=3D amdgpu_sync_fence(sync, f);<br>
                  &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if =
(r) {<br>
                  &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0dma_fence_put(f);<br>
                  &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0return r;<br>
                  &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<b=
r>
                  &gt; +=C2=A0 =C2=A0 =C2=A0}<br>
                  &gt; +=C2=A0 =C2=A0 =C2=A0return 0;<br>
                  &gt; +}<br>
                  &gt; +<br>
                  &gt;=C2=A0 =C2=A0/**<br>
                  &gt;=C2=A0 =C2=A0 * amdgpu_sync_vm_fence - remember to sy=
nc to
                  this VM fence<br>
                  &gt;=C2=A0 =C2=A0 *<br>
                  &gt; diff --git
                  a/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.h
                  b/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.h<br>
                  &gt; index 7c0fe20c470d..b142175b65b6 100644<br>
                  &gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.h<br>
                  &gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.h<br>
                  &gt; @@ -48,6 +48,7 @@ struct amdgpu_sync {<br>
                  &gt;=C2=A0 =C2=A0<br>
                  &gt;=C2=A0 =C2=A0void amdgpu_sync_create(struct amdgpu_sy=
nc
                  *sync);<br>
                  &gt;=C2=A0 =C2=A0int amdgpu_sync_fence(struct amdgpu_sync=
 *sync,
                  struct dma_fence *f);<br>
                  &gt; +int amdgpu_sync_fence_chain(struct amdgpu_sync
                  *sync, struct dma_fence *f);<br>
                  &gt;=C2=A0 =C2=A0int amdgpu_sync_vm_fence(struct amdgpu_s=
ync
                  *sync, struct dma_fence *fence);<br>
                  &gt;=C2=A0 =C2=A0int amdgpu_sync_resv(struct amdgpu_devic=
e
                  *adev, struct amdgpu_sync *sync,<br>
                  &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 struct dma_resv *resv, enum
                  amdgpu_sync_mode mode,<br>
                  <br>
                  _______________________________________________<br>
                  amd-gfx mailing list<br>
                  <a href=3D"mailto:amd-gfx@lists.freedesktop.org"
                    target=3D"_blank" moz-do-not-send=3D"true">amd-gfx@list=
s.freedesktop.org</a><br>
                  <a
                    href=3D"https://lists.freedesktop.org/mailman/listinfo/=
amd-gfx"
                    rel=3D"noreferrer" target=3D"_blank"
                    moz-do-not-send=3D"true">https://lists.freedesktop.org/=
mailman/listinfo/amd-gfx</a><br>
                </blockquote>
              </div>
            </blockquote>
            <br>
          </div>
        </blockquote>
      </div>
    </blockquote>
  </body>
</html>

--------------81E16703787DE16773E477EB--


--===============0805401206==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0805401206==--

