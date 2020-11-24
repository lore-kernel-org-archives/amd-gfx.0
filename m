Return-Path: <SRS0=xWtd=E6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIM_ADSP_ALL,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	HTTPS_HTTP_MISMATCH,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAB20C2D0E4
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Nov 2020 21:58:07 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 62359206FB
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Nov 2020 21:58:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=valvesoftware.com header.i=@valvesoftware.com header.b="S7Mpfnux"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62359206FB
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=valvesoftware.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F23C389FD4;
	Tue, 24 Nov 2020 21:58:06 +0000 (UTC)
Received: from us-smtp-delivery-172.mimecast.com
 (us-smtp-delivery-172.mimecast.com [216.205.24.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 22ACC89FD4
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Nov 2020 21:58:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valvesoftware.com;
 s=mc20150811; t=1606255085;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7aSNdNJ1R8gEolJw9QSJ6yB7eLySq9xKIfeMvOqBou8=;
 b=S7MpfnuxXZGHLZwLRuZMi78dKHhhNhPL0tQo1hhFz9/P7GdS/CXBxkYjMhyiMryF4ZMFOK
 xDRqjbDewxoXK9a1zMSn+iq0TSM2ULkv1+SNowRoPTf/0d6BkiNnpkfj30emLa+AIAfjJK
 haBTFDsjMOTbNdYHIOWqBbvFeqAIi48=
Received: from smtp-01-blv1.valvesoftware.com (smtp01.valvesoftware.com
 [208.64.203.181]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-273-NP0yjI6_OGG0Z2dC4gGx9Q-1; Tue, 24 Nov 2020 16:58:01 -0500
X-MC-Unique: NP0yjI6_OGG0Z2dC4gGx9Q-1
Received: from [172.16.1.107] (helo=antispam.valve.org)
 by smtp-01-blv1.valvesoftware.com with esmtp (Exim 4.86_2)
 (envelope-from <pgriffais@valvesoftware.com>) id 1khgK1-0002Gc-12
 for amd-gfx@lists.freedesktop.org; Tue, 24 Nov 2020 13:58:01 -0800
Received: from antispam.valve.org (127.0.0.1) id hnm0ui0171s7 for
 <amd-gfx@lists.freedesktop.org>;
 Tue, 24 Nov 2020 13:58:01 -0800 (envelope-from <pgriffais@valvesoftware.com>)
Received: from mail1.valvemail.org ([172.16.144.22])
 by antispam.valve.org ([172.16.1.107]) (SonicWALL 9.0.5.2081 )
 with ESMTP id o202011242158000013984-5; Tue, 24 Nov 2020 13:58:00 -0800
Received: from [172.16.36.229] (172.16.36.229) by mail1.valvemail.org
 (172.16.144.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2044.4; Tue, 24 Nov
 2020 13:58:00 -0800
Subject: Re: [PATCH] drm/amdgpu: unpack dma_fence_chain containers during sync
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>
References: <20201118132039.2336-1-christian.koenig@amd.com>
 <1a20a665-f859-6ed3-be98-48cb5b9fcf37@gmail.com>
 <CAAxE2A5BLn0ygJc6nx5QPW1qWq6hpvQbzFm51pzan+jhe_BWWw@mail.gmail.com>
 <53b5d31f-e533-0fb3-0907-76d2f3730af3@gmail.com>
 <CAAxE2A4MThFV0Whms5QGHmXNhhw-9++naxWV0n=HqinJAOupSw@mail.gmail.com>
 <8c9a2e5d-fbfc-45b9-f0de-92e292fcb7e7@valvesoftware.com>
 <575332de-fb65-7122-f68a-1ab2e89c1adc@amd.com>
From: "Pierre-Loup A. Griffais" <pgriffais@valvesoftware.com>
Message-ID: <fbe8dcb1-cc98-a34e-c287-503efacff12f@valvesoftware.com>
Date: Tue, 24 Nov 2020 13:58:00 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <575332de-fb65-7122-f68a-1ab2e89c1adc@amd.com>
X-ClientProxiedBy: mail1.valvemail.org (172.16.144.22) To mail1.valvemail.org
 (172.16.144.22)
X-EXCLAIMER-MD-CONFIG: fe5cb8ea-1338-4c54-81e0-ad323678e037
X-Mlf-CnxnMgmt-Allow: 172.16.144.22
X-Mlf-Version: 9.0.5.2081
X-Mlf-License: BSVKCAP__
X-Mlf-UniqueId: o202011242158000013984
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
Content-Type: multipart/mixed; boundary="===============0333421842=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0333421842==
Content-Type: multipart/alternative;
	boundary="------------92A5BACE4F53C405E195A631"
Content-Language: en-US

--------------92A5BACE4F53C405E195A631
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

I can test some more tonight. I'll also try to prepare a standalone=20
trace so you can observe the exact pattern being used on your end.=20
Vulkan traces tend to be GPU and driver-specific. We'll use Mesa as the=20
driver, but what GPU would be most convenient on your side for=20
replaying? On our end I would guess Navi10 would be most practical.

On 11/23/20 11:56 PM, Christian K=C3=B6nig wrote:
> Mhm, then I don't know what's going wrong here.
>
> Could be that the fence somehow ends up in a BO dependency.
>
> Pierre do you have some time for testing today? Or could you provide=20
> me some way to test this?
>
> Christian.
>
> Am 24.11.20 um 03:48 schrieb Pierre-Loup A. Griffais:
>>
>> I just built my kernel with it and tested Horizon Zero Dawn on stock=20
>> Proton 5.13, and it doesn't seem to change things there.
>>
>> This pattern looks identical as with before the kernel patch, as far=20
>> as I can tell:
>>
>> https://imgur.com/a/1fZWgNG
>>
>> The last purple block is a piece of GPU work on the gfx ring. It's=20
>> been queued by software 0.7ms ago, but doesn't get put on the HW ring=20
>> until right after the previous piece of GPU work completes. The=20
>> orange chunk below is the 'gfx' kernel task executing, to queue it.
>>
>> Thanks,
>>
>> =C2=A0- Pierre-Loup
>>
>> On 2020-11-23 18:09, Marek Ol=C5=A1=C3=A1k wrote:
>>> Pierre-Loup, does this do what you requested?
>>>
>>> Thanks,
>>> Marek
>>>
>>> On Mon, Nov 23, 2020 at 3:17 PM Christian K=C3=B6nig=20
>>> <ckoenig.leichtzumerken@gmail.com=20
>>> <mailto:ckoenig.leichtzumerken@gmail.com>> wrote:
>>>
>>>     That the CPU round trip is gone now.
>>>
>>>     Christian.
>>>
>>>     Am 23.11.20 um 20:49 schrieb Marek Ol=C5=A1=C3=A1k:
>>>>     What is the behavior we should expect?
>>>>
>>>>     Marek
>>>>
>>>>     On Mon, Nov 23, 2020 at 7:31 AM Christian K=C3=B6nig
>>>>     <ckoenig.leichtzumerken@gmail.com
>>>>     <mailto:ckoenig.leichtzumerken@gmail.com>> wrote:
>>>>
>>>>         Ping, Pierre/Marek does this change works as expected?
>>>>
>>>>         Regards,
>>>>         Christian.
>>>>
>>>>         Am 18.11.20 um 14:20 schrieb Christian K=C3=B6nig:
>>>>         > This allows for optimizing the CPU round trip away.
>>>>         >
>>>>         > Signed-off-by: Christian K=C3=B6nig <christian.koenig@amd.co=
m
>>>>         <mailto:christian.koenig@amd.com>>
>>>>         > ---
>>>>         >=C2=A0 =C2=A0drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c=C2=A0 =C2=
=A0| 2 +-
>>>>         >=C2=A0 =C2=A0drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c | 27
>>>>         ++++++++++++++++++++++++
>>>>         >=C2=A0 =C2=A0drivers/gpu/drm/amd/amdgpu/amdgpu_sync.h | 1 +
>>>>         >=C2=A0 =C2=A03 files changed, 29 insertions(+), 1 deletion(-)
>>>>         >
>>>>         > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
>>>>         b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
>>>>         > index 79342976fa76..68f9a4adf5d2 100644
>>>>         > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
>>>>         > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
>>>>         > @@ -1014,7 +1014,7 @@ static int
>>>>         amdgpu_syncobj_lookup_and_add_to_sync(struct
>>>>         amdgpu_cs_parser *p,
>>>>         >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return=
 r;
>>>>         >=C2=A0 =C2=A0 =C2=A0 =C2=A0}
>>>>         >
>>>>         > -=C2=A0 =C2=A0 =C2=A0r =3D amdgpu_sync_fence(&p->job->sync, =
fence);
>>>>         > +=C2=A0 =C2=A0 =C2=A0r =3D amdgpu_sync_fence_chain(&p->job->=
sync, fence);
>>>>         >=C2=A0 =C2=A0 =C2=A0 =C2=A0dma_fence_put(fence);
>>>>         >
>>>>         >=C2=A0 =C2=A0 =C2=A0 =C2=A0return r;
>>>>         > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c
>>>>         b/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c
>>>>         > index 8ea6c49529e7..d0d64af06f54 100644
>>>>         > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c
>>>>         > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c
>>>>         > @@ -28,6 +28,8 @@
>>>>         >=C2=A0 =C2=A0 *=C2=A0 =C2=A0 Christian K=C3=B6nig <christian.=
koenig@amd.com
>>>>         <mailto:christian.koenig@amd.com>>
>>>>         >=C2=A0 =C2=A0 */
>>>>         >
>>>>         > +#include <linux/dma-fence-chain.h>
>>>>         > +
>>>>         >=C2=A0 =C2=A0#include "amdgpu.h"
>>>>         >=C2=A0 =C2=A0#include "amdgpu_trace.h"
>>>>         >=C2=A0 =C2=A0#include "amdgpu_amdkfd.h"
>>>>         > @@ -169,6 +171,31 @@ int amdgpu_sync_fence(struct
>>>>         amdgpu_sync *sync, struct dma_fence *f)
>>>>         >=C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;
>>>>         >=C2=A0 =C2=A0}
>>>>         >
>>>>         > +/**
>>>>         > + * amdgpu_sync_fence_chain - unpack dma_fence_chain and syn=
c
>>>>         > + *
>>>>         > + * @sync: sync object to add fence to
>>>>         > + * @f: potential dma_fence_chain to sync to.
>>>>         > + *
>>>>         > + * Add the fences inside the chain to the sync object.
>>>>         > + */
>>>>         > +int amdgpu_sync_fence_chain(struct amdgpu_sync *sync,
>>>>         struct dma_fence *f)
>>>>         > +{
>>>>         > +=C2=A0 =C2=A0 =C2=A0int r;
>>>>         > +
>>>>         > +=C2=A0 =C2=A0 =C2=A0dma_fence_chain_for_each(f, f) {
>>>>         > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (dma_fen=
ce_is_signaled(f))
>>>>         > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0continue;
>>>>         > +
>>>>         > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0r =3D amdgp=
u_sync_fence(sync, f);
>>>>         > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (r) {
>>>>         > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0dma_fence_put(f);
>>>>         > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0return r;
>>>>         > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>>>>         > +=C2=A0 =C2=A0 =C2=A0}
>>>>         > +=C2=A0 =C2=A0 =C2=A0return 0;
>>>>         > +}
>>>>         > +
>>>>         >=C2=A0 =C2=A0/**
>>>>         >=C2=A0 =C2=A0 * amdgpu_sync_vm_fence - remember to sync to th=
is VM fence
>>>>         >=C2=A0 =C2=A0 *
>>>>         > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.h
>>>>         b/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.h
>>>>         > index 7c0fe20c470d..b142175b65b6 100644
>>>>         > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.h
>>>>         > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.h
>>>>         > @@ -48,6 +48,7 @@ struct amdgpu_sync {
>>>>         >
>>>>         >=C2=A0 =C2=A0void amdgpu_sync_create(struct amdgpu_sync *sync=
);
>>>>         >=C2=A0 =C2=A0int amdgpu_sync_fence(struct amdgpu_sync *sync, =
struct
>>>>         dma_fence *f);
>>>>         > +int amdgpu_sync_fence_chain(struct amdgpu_sync *sync,
>>>>         struct dma_fence *f);
>>>>         >=C2=A0 =C2=A0int amdgpu_sync_vm_fence(struct amdgpu_sync *syn=
c,
>>>>         struct dma_fence *fence);
>>>>         >=C2=A0 =C2=A0int amdgpu_sync_resv(struct amdgpu_device *adev,=
 struct
>>>>         amdgpu_sync *sync,
>>>>         >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 struct dma_resv *resv, enum
>>>>         amdgpu_sync_mode mode,
>>>>
>>>>         _______________________________________________
>>>>         amd-gfx mailing list
>>>>         amd-gfx@lists.freedesktop.org
>>>>         <mailto:amd-gfx@lists.freedesktop.org>
>>>>         https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>>>>         <https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3=
A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&data=3D04%7C01%=
7Cchristian.koenig%40amd.com%7C4b90eb41edd04592bd4f08d89023653b%7C3dd8961fe=
4884e608e11a82d994e183d%7C0%7C0%7C637417828990103282%7CUnknown%7CTWFpbGZsb3=
d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000=
&sdata=3DwHx40e8opSOOIndSVMBaPuMarMpA%2FnDRxl%2BI5BV210s%3D&reserved=3D0>
>>>>
>>>
>

--------------92A5BACE4F53C405E195A631
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<html>
  <head>
    <meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3DUTF-8=
">
  </head>
  <body>
    <p>I can test some more tonight. I'll also try to prepare a
      standalone trace so you can observe the exact pattern being used
      on your end. Vulkan traces tend to be GPU and driver-specific.
      We'll use Mesa as the driver, but what GPU would be most
      convenient on your side for replaying? On our end I would guess
      Navi10 would be most practical.<br>
    </p>
    <div class=3D"moz-cite-prefix">On 11/23/20 11:56 PM, Christian K=C3=B6n=
ig
      wrote:<br>
    </div>
    <blockquote type=3D"cite"
      cite=3D"mid:575332de-fb65-7122-f68a-1ab2e89c1adc@amd.com">
      <meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3DUTF=
-8">
      <div class=3D"moz-cite-prefix">Mhm, then I don't know what's going
        wrong here.<br>
        <br>
        Could be that the fence somehow ends up in a BO dependency.<br>
        <br>
        Pierre do you have some time for testing today? Or could you
        provide me some way to test this?<br>
        <br>
        Christian.<br>
        <br>
        Am 24.11.20 um 03:48 schrieb Pierre-Loup A. Griffais:<br>
      </div>
      <blockquote type=3D"cite"
        cite=3D"mid:8c9a2e5d-fbfc-45b9-f0de-92e292fcb7e7@valvesoftware.com"=
>
        <p>I just built my kernel with it and tested Horizon Zero Dawn
          on stock Proton 5.13, and it doesn't seem to change things
          there.</p>
        <p>This pattern looks identical as with before the kernel patch,
          as far as I can tell:</p>
        <p><a class=3D"moz-txt-link-freetext"
href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2=
Fimgur.com%2Fa%2F1fZWgNG&amp;data=3D04%7C01%7Cchristian.koenig%40amd.com%7C=
4b90eb41edd04592bd4f08d89023653b%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0=
%7C637417828990103282%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV=
2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=3D9GgRTJGEvsilDAKk%2=
BAmMsOYtkaV6KDQvW%2B%2ByZ%2BjNoVk%3D&amp;reserved=3D0"
            originalsrc=3D"https://imgur.com/a/1fZWgNG"
shash=3D"fjxcl2lQPlDhPxkxjqbnhCKpKxeIFE3SWb6jZu+GyS6Z+iqx9FCHR+axtP4fvW+QSK=
rpK4+sLhPZs1HlyV/sudPTOi4vS9KRgbJLorAgWuRBD78Mp1mDD0M9SKn9d2UVTrNFjJfJJP0VY=
Vd24KKYUmqbuCf2Aoeao9jVwx+Es3I=3D"
            moz-do-not-send=3D"true">https://imgur.com/a/1fZWgNG</a></p>
        <p>The last purple block is a piece of GPU work on the gfx ring.
          It's been queued by software 0.7ms ago, but doesn't get put on
          the HW ring until right after the previous piece of GPU work
          completes. The orange chunk below is the 'gfx' kernel task
          executing, to queue it.</p>
        <p>Thanks,</p>
        <p>=C2=A0- Pierre-Loup<br>
        </p>
        On 2020-11-23 18:09, Marek Ol=C5=A1=C3=A1k wrote:<br>
        <blockquote type=3D"cite"
cite=3D"mid:CAAxE2A4MThFV0Whms5QGHmXNhhw-9++naxWV0n=3DHqinJAOupSw@mail.gmai=
l.com">
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
            <div dir=3D"ltr" class=3D"gmail_attr">On Mon, Nov 23, 2020 at
              3:17 PM Christian K=C3=B6nig &lt;<a
                href=3D"mailto:ckoenig.leichtzumerken@gmail.com"
                moz-do-not-send=3D"true">ckoenig.leichtzumerken@gmail.com</=
a>&gt;
              wrote:<br>
            </div>
            <blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px
              0.8ex;border-left:1px solid
              rgb(204,204,204);padding-left:1ex">
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
                    <div dir=3D"ltr" class=3D"gmail_attr">On Mon, Nov 23,
                      2020 at 7:31 AM Christian K=C3=B6nig &lt;<a
                        href=3D"mailto:ckoenig.leichtzumerken@gmail.com"
                        target=3D"_blank" moz-do-not-send=3D"true">ckoenig.=
leichtzumerken@gmail.com</a>&gt;
                      wrote:<br>
                    </div>
                    <blockquote class=3D"gmail_quote" style=3D"margin:0px
                      0px 0px 0.8ex;border-left:1px solid
                      rgb(204,204,204);padding-left:1ex">Ping,
                      Pierre/Marek does this change works as expected?<br>
                      <br>
                      Regards,<br>
                      Christian.<br>
                      <br>
                      Am 18.11.20 um 14:20 schrieb Christian K=C3=B6nig:<br=
>
                      &gt; This allows for optimizing the CPU round trip
                      away.<br>
                      &gt;<br>
                      &gt; Signed-off-by: Christian K=C3=B6nig &lt;<a
                        href=3D"mailto:christian.koenig@amd.com"
                        target=3D"_blank" moz-do-not-send=3D"true">christia=
n.koenig@amd.com</a>&gt;<br>
                      &gt; ---<br>
                      &gt;=C2=A0 =C2=A0drivers/gpu/drm/amd/amdgpu/amdgpu_cs=
.c=C2=A0 =C2=A0|=C2=A0
                      2 +-<br>
                      &gt;=C2=A0 =C2=A0drivers/gpu/drm/amd/amdgpu/amdgpu_sy=
nc.c |
                      27 ++++++++++++++++++++++++<br>
                      &gt;=C2=A0 =C2=A0drivers/gpu/drm/amd/amdgpu/amdgpu_sy=
nc.h |=C2=A0
                      1 +<br>
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
                      &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0return r;<br>
                      &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
                      &gt;=C2=A0 =C2=A0<br>
                      &gt; -=C2=A0 =C2=A0 =C2=A0r =3D
                      amdgpu_sync_fence(&amp;p-&gt;job-&gt;sync, fence);<br=
>
                      &gt; +=C2=A0 =C2=A0 =C2=A0r =3D
                      amdgpu_sync_fence_chain(&amp;p-&gt;job-&gt;sync,
                      fence);<br>
                      &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0dma_fence_put(fence);<=
br>
                      &gt;=C2=A0 =C2=A0<br>
                      &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0return r;<br>
                      &gt; diff --git
                      a/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c
                      b/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c<br>
                      &gt; index 8ea6c49529e7..d0d64af06f54 100644<br>
                      &gt; ---
                      a/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c<br>
                      &gt; +++
                      b/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c<br>
                      &gt; @@ -28,6 +28,8 @@<br>
                      &gt;=C2=A0 =C2=A0 *=C2=A0 =C2=A0 Christian K=C3=B6nig=
 &lt;<a
                        href=3D"mailto:christian.koenig@amd.com"
                        target=3D"_blank" moz-do-not-send=3D"true">christia=
n.koenig@amd.com</a>&gt;<br>
                      &gt;=C2=A0 =C2=A0 */<br>
                      &gt;=C2=A0 =C2=A0<br>
                      &gt; +#include &lt;linux/dma-fence-chain.h&gt;<br>
                      &gt; +<br>
                      &gt;=C2=A0 =C2=A0#include "amdgpu.h"<br>
                      &gt;=C2=A0 =C2=A0#include "amdgpu_trace.h"<br>
                      &gt;=C2=A0 =C2=A0#include "amdgpu_amdkfd.h"<br>
                      &gt; @@ -169,6 +171,31 @@ int
                      amdgpu_sync_fence(struct amdgpu_sync *sync, struct
                      dma_fence *f)<br>
                      &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
                      &gt;=C2=A0 =C2=A0}<br>
                      &gt;=C2=A0 =C2=A0<br>
                      &gt; +/**<br>
                      &gt; + * amdgpu_sync_fence_chain - unpack
                      dma_fence_chain and sync<br>
                      &gt; + *<br>
                      &gt; + * @sync: sync object to add fence to<br>
                      &gt; + * @f: potential dma_fence_chain to sync to.<br=
>
                      &gt; + *<br>
                      &gt; + * Add the fences inside the chain to the
                      sync object.<br>
                      &gt; + */<br>
                      &gt; +int amdgpu_sync_fence_chain(struct
                      amdgpu_sync *sync, struct dma_fence *f)<br>
                      &gt; +{<br>
                      &gt; +=C2=A0 =C2=A0 =C2=A0int r;<br>
                      &gt; +<br>
                      &gt; +=C2=A0 =C2=A0 =C2=A0dma_fence_chain_for_each(f,=
 f) {<br>
                      &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0if (dma_fence_is_signaled(f))<br>
                      &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0continue;<br>
                      &gt; +<br>
                      &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0r =3D amdgpu_sync_fence(sync, f);<br>
                      &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0if (r) {<br>
                      &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dma_fence_put(f);<br>
                      &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return r;<br>
                      &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0}<br>
                      &gt; +=C2=A0 =C2=A0 =C2=A0}<br>
                      &gt; +=C2=A0 =C2=A0 =C2=A0return 0;<br>
                      &gt; +}<br>
                      &gt; +<br>
                      &gt;=C2=A0 =C2=A0/**<br>
                      &gt;=C2=A0 =C2=A0 * amdgpu_sync_vm_fence - remember t=
o sync
                      to this VM fence<br>
                      &gt;=C2=A0 =C2=A0 *<br>
                      &gt; diff --git
                      a/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.h
                      b/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.h<br>
                      &gt; index 7c0fe20c470d..b142175b65b6 100644<br>
                      &gt; ---
                      a/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.h<br>
                      &gt; +++
                      b/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.h<br>
                      &gt; @@ -48,6 +48,7 @@ struct amdgpu_sync {<br>
                      &gt;=C2=A0 =C2=A0<br>
                      &gt;=C2=A0 =C2=A0void amdgpu_sync_create(struct amdgp=
u_sync
                      *sync);<br>
                      &gt;=C2=A0 =C2=A0int amdgpu_sync_fence(struct amdgpu_=
sync
                      *sync, struct dma_fence *f);<br>
                      &gt; +int amdgpu_sync_fence_chain(struct
                      amdgpu_sync *sync, struct dma_fence *f);<br>
                      &gt;=C2=A0 =C2=A0int amdgpu_sync_vm_fence(struct amdg=
pu_sync
                      *sync, struct dma_fence *fence);<br>
                      &gt;=C2=A0 =C2=A0int amdgpu_sync_resv(struct amdgpu_d=
evice
                      *adev, struct amdgpu_sync *sync,<br>
                      &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 struct dma_resv *resv,
                      enum amdgpu_sync_mode mode,<br>
                      <br>
                      _______________________________________________<br>
                      amd-gfx mailing list<br>
                      <a href=3D"mailto:amd-gfx@lists.freedesktop.org"
                        target=3D"_blank" moz-do-not-send=3D"true">amd-gfx@=
lists.freedesktop.org</a><br>
                      <a
href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2=
Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D04%7C01%7C=
christian.koenig%40amd.com%7C4b90eb41edd04592bd4f08d89023653b%7C3dd8961fe48=
84e608e11a82d994e183d%7C0%7C0%7C637417828990103282%7CUnknown%7CTWFpbGZsb3d8=
eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&a=
mp;sdata=3DwHx40e8opSOOIndSVMBaPuMarMpA%2FnDRxl%2BI5BV210s%3D&amp;reserved=
=3D0"
originalsrc=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx"
shash=3D"xpxE/e8BBF2CgWMJeAAYsTY9C3Bcx9TWRUNAY3Z4mTv0R+mpp82lp4dQIV/2Groekf=
XfwgCURj1mOZjgd3L19S7ND6Fz0kkN33+W1ieirsReq158EC4Jmwcy4/s0M8OdBrZt0S6eiwgGF=
gTgqvQomTfdz+ZV6Q2G9izPVnSsZzk=3D"
                        rel=3D"noreferrer" target=3D"_blank"
                        moz-do-not-send=3D"true">https://lists.freedesktop.=
org/mailman/listinfo/amd-gfx</a><br>
                    </blockquote>
                  </div>
                </blockquote>
                <br>
              </div>
            </blockquote>
          </div>
        </blockquote>
      </blockquote>
      <br>
    </blockquote>
  </body>
</html>

--------------92A5BACE4F53C405E195A631--


--===============0333421842==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0333421842==--

