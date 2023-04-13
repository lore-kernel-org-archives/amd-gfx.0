Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37A85C77B61
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Apr 2023 18:58:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C71F910EBDF;
	Thu, 13 Apr 2023 18:58:09 +0000 (UTC)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 60B9A10EBDF
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Apr 2023 18:58:07 +0000 (UTC)
Received: by mail-wm1-x334.google.com with SMTP id he13so14151462wmb.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Apr 2023 11:58:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1681412285; x=1684004285;
 h=in-reply-to:from:references:cc:to:content-language:subject
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Br9hs+0lRUdt9uHveanInosB4SwTGEA//ciRI9EljF8=;
 b=W5hfUTN8yiga1cPhkxbjrbkkx8YboUvOjZJ05IPbmQ8oIeKovwJiF8lko/OZH8FxsF
 Rcyxs8beBAOBcGTNuUyloI4zq5cAuLZD7VStXQwuTF/ZLXFi6IDyaATro/UKGShJ+NPf
 sYa1NNVzvc3ERu1JBWieS4qQ06rdtcaY5cPNGHZYqjS0SFC3jYY/+HfWIKAE1/toi5N4
 Ka7gphlHUGELeeEvdUQxzlE9zwBFX1LTq8ZcRvLJh6cCFk1VB+cfi12HFTWlqhxelxjT
 GkczrQ46f88WAw61194A7ciV6t7XpCPsT/+HOumcMHLpNWz3rdfTSo5x6/z6HswVmo7z
 5jig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1681412285; x=1684004285;
 h=in-reply-to:from:references:cc:to:content-language:subject
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Br9hs+0lRUdt9uHveanInosB4SwTGEA//ciRI9EljF8=;
 b=LMjFc9zHbdC/eP6wcIkSHIvukyMt7jAmcquKRPvMB6uofgsQLnpUsqKElO7RGM1L+n
 XG8vU4Lt2wIJTD0wkucaLBRSZW7kn9b6pU23H51WOD9oo5Jm2NRzXxuy5y/XzrCOiOrB
 BChzNYR97KjeH9b7CtcCUOdjRY4clJckuBUFICZbhMnWbK11i9RbuKY/6WUim5pFHATh
 2VOWqQ5D+xUBmn+oPkb4mG3ox4ew1SeZ/kB9iksWJAhNaU2AsqRtHYB2N4H1q4NES4+f
 4j699k2qTdzWhs6sx54wC1WPM6upVXm97Rh7bh3a89FkvFqFmVrCJo35PhzDHETZtzmq
 yUMA==
X-Gm-Message-State: AAQBX9eytgFc0TZlhzfm7wFLh4adbzqDzsoKSm/2WBaxDhQOtrmcaJqF
 iuocUUryxVhyGsOQ9bjrMt41b4RAtWI=
X-Google-Smtp-Source: AKy350ZnxibM09HOh0gn567m4ZWtX4n0NxXQXsFz3r6W8bPUTXX+v6iSXYl0OtLwXVzeput7S5yQ/w==
X-Received: by 2002:a05:600c:2157:b0:3f0:a9d9:9ebf with SMTP id
 v23-20020a05600c215700b003f0a9d99ebfmr2149177wml.26.1681412284861; 
 Thu, 13 Apr 2023 11:58:04 -0700 (PDT)
Received: from ?IPV6:2a02:908:1256:79a0:e7c0:ec45:b30d:3c16?
 ([2a02:908:1256:79a0:e7c0:ec45:b30d:3c16])
 by smtp.gmail.com with ESMTPSA id
 q9-20020a1ce909000000b003ee20b4b2dasm2458826wmc.46.2023.04.13.11.58.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Apr 2023 11:58:04 -0700 (PDT)
Content-Type: multipart/alternative;
 boundary="------------Afx6I4vuTvEAfeQrGrLIq60o"
Message-ID: <2ff1b67c-7795-552f-4623-ffee14c4e9ac@gmail.com>
Date: Thu, 13 Apr 2023 20:58:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 03/13] drm/amdgpu/UAPI: add new CS chunk for GFX shadow
 buffers
Content-Language: en-US
To: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>,
 Alex Deucher <alexdeucher@gmail.com>
References: <20230330191750.1134210-1-alexander.deucher@amd.com>
 <20230330191750.1134210-4-alexander.deucher@amd.com>
 <CAAxE2A7nvmXdUaXESi4g6HVBFxk+dooz7tZYQfjGE8O2fKFi-w@mail.gmail.com>
 <8a98b160-5276-54f5-d166-e12a572892e9@amd.com>
 <CAAxE2A4LzFudfzTNRr290ORZvcF6-xzKiyNM6LZ3uiZDPerf5Q@mail.gmail.com>
 <b1485943-5f0a-1a7e-f0a4-b35771b48a23@gmail.com>
 <CAAxE2A6m346bTD7G=wMa=8OcRmk6OHui9N=Z9B5xHCS4VxxYwQ@mail.gmail.com>
 <2897fa79-f0ef-1ddb-dc38-05ef429fe0d9@gmail.com>
 <CAAxE2A5mf8J_1JJvgPgx-G07zcc3vcHOD6jWUXL8Mhx3g-Zufw@mail.gmail.com>
 <0e2e1902-54e8-0626-c7ca-3f818f8792fb@gmail.com>
 <CADnq5_MrY3QtU_--B=OYD+_+nx6jNyzJfOxBzfoPrmeLJC6h3Q@mail.gmail.com>
 <8b2df4e1-ad00-a834-3382-d25f1c667978@gmail.com>
 <CADnq5_PLfseKjhYZe54poe+hE4-cL+Fgqc=sZ=QabN1Xqud0Lg@mail.gmail.com>
 <CAAxE2A5XxySNG2BqcXZKhq=wyC7DnhONLtyFLgRx4x65K3ZbTA@mail.gmail.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <CAAxE2A5XxySNG2BqcXZKhq=wyC7DnhONLtyFLgRx4x65K3ZbTA@mail.gmail.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 amd-gfx mailing list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This is a multi-part message in MIME format.
--------------Afx6I4vuTvEAfeQrGrLIq60o
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Me as well.

Christian.

Am 13.04.23 um 20:23 schrieb Marek Olšák:
> I'm OK with that.
>
> Marek
>
> On Thu, Apr 13, 2023 at 12:56 PM Alex Deucher <alexdeucher@gmail.com> 
> wrote:
>
>     On Thu, Apr 13, 2023 at 11:54 AM Christian König
>     <ckoenig.leichtzumerken@gmail.com> wrote:
>     >
>     > Am 13.04.23 um 14:26 schrieb Alex Deucher:
>     > > On Thu, Apr 13, 2023 at 7:32 AM Christian König
>     > > <ckoenig.leichtzumerken@gmail.com> wrote:
>     > >> Ok, then we have a problem.
>     > >>
>     > >> Alex what do you think?
>     > > If you program it to 0, FW skips the GDS backup I think so
>     UMD's can
>     > > decide whether they want to use it or not, depending on
>     whether they
>     > > use GDS.
>     >
>     > Yeah, but when Mesa isn't using it we have a hard way justifying to
>     > upstream that because it isn't tested at all.
>
>     Well, the interface would still get used, it's just that mesa would
>     likely only ever pass 0 for the virtual address.  It's just a
>     passthrough to the packet.  If we discover we need it at some point,
>     it would be nice to not have to add a new interface to add it.
>
>     Alex
>
>     >
>     > Christian.
>     >
>     > >
>     > > Alex
>     > >
>     > >
>     > >> Christian.
>     > >>
>     > >> Am 13.04.23 um 11:21 schrieb Marek Olšák:
>     > >>
>     > >> That's not why it was removed. It was removed because
>     userspace doesn't use GDS memory and gds_va is always going to be 0.
>     > >>
>     > >> Firmware shouldn't use it because using it would increase
>     preemption latency.
>     > >>
>     > >> Marek
>     > >>
>     > >> On Sun, Apr 9, 2023, 11:21 Christian König
>     <ckoenig.leichtzumerken@gmail.com> wrote:
>     > >>> We removed the GDS information because they were
>     unnecessary. The GDS size was already part of the device info
>     before we added the shadow info.
>     > >>>
>     > >>> But as far as I know the firmware needs valid VAs for all
>     three buffers or won't work correctly.
>     > >>>
>     > >>> Christian.
>     > >>>
>     > >>> Am 06.04.23 um 17:01 schrieb Marek Olšák:
>     > >>>
>     > >>> There is no GDS shadowing info in the device info uapi, so
>     userspace can't create any GDS buffer and thus can't have any GDS
>     va. It's a uapi issue, not what firmware wants to do.
>     > >>>
>     > >>> Marek
>     > >>>
>     > >>> On Thu, Apr 6, 2023 at 6:31 AM Christian König
>     <ckoenig.leichtzumerken@gmail.com> wrote:
>     > >>>> That's what I thought as well, but Mitch/Hans insisted on that.
>     > >>>>
>     > >>>> We should probably double check internally.
>     > >>>>
>     > >>>> Christian.
>     > >>>>
>     > >>>> Am 06.04.23 um 11:43 schrieb Marek Olšák:
>     > >>>>
>     > >>>> GDS memory isn't used on gfx11. Only GDS OA is used.
>     > >>>>
>     > >>>> Marek
>     > >>>>
>     > >>>> On Thu, Apr 6, 2023 at 5:09 AM Christian König
>     <christian.koenig@amd.com> wrote:
>     > >>>>> Why that?
>     > >>>>>
>     > >>>>> This is the save buffer for GDS, not the old style GDS BOs.
>     > >>>>>
>     > >>>>> Christian.
>     > >>>>>
>     > >>>>> Am 06.04.23 um 09:36 schrieb Marek Olšák:
>     > >>>>>
>     > >>>>> gds_va is unnecessary.
>     > >>>>>
>     > >>>>> Marek
>     > >>>>>
>     > >>>>> On Thu, Mar 30, 2023 at 3:18 PM Alex Deucher
>     <alexander.deucher@amd.com> wrote:
>     > >>>>>> For GFX11, the UMD needs to allocate some shadow buffers
>     > >>>>>> to be used for preemption.  The UMD allocates the buffers
>     > >>>>>> and passes the GPU virtual address to the kernel since the
>     > >>>>>> kernel will program the packet that specified these
>     > >>>>>> addresses as part of its IB submission frame.
>     > >>>>>>
>     > >>>>>> v2: UMD passes shadow init to tell kernel when to initialize
>     > >>>>>>      the shadow
>     > >>>>>>
>     > >>>>>> Reviewed-by: Christian König <christian.koenig@amd.com>
>     > >>>>>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>     > >>>>>> ---
>     > >>>>>>   include/uapi/drm/amdgpu_drm.h | 10 ++++++++++
>     > >>>>>>   1 file changed, 10 insertions(+)
>     > >>>>>>
>     > >>>>>> diff --git a/include/uapi/drm/amdgpu_drm.h
>     b/include/uapi/drm/amdgpu_drm.h
>     > >>>>>> index b6eb90df5d05..3d9474af6566 100644
>     > >>>>>> --- a/include/uapi/drm/amdgpu_drm.h
>     > >>>>>> +++ b/include/uapi/drm/amdgpu_drm.h
>     > >>>>>> @@ -592,6 +592,7 @@ struct drm_amdgpu_gem_va {
>     > >>>>>>   #define AMDGPU_CHUNK_ID_SCHEDULED_DEPENDENCIES 0x07
>     > >>>>>>   #define AMDGPU_CHUNK_ID_SYNCOBJ_TIMELINE_WAIT    0x08
>     > >>>>>>   #define AMDGPU_CHUNK_ID_SYNCOBJ_TIMELINE_SIGNAL  0x09
>     > >>>>>> +#define AMDGPU_CHUNK_ID_CP_GFX_SHADOW   0x0a
>     > >>>>>>
>     > >>>>>>   struct drm_amdgpu_cs_chunk {
>     > >>>>>>          __u32  chunk_id;
>     > >>>>>> @@ -708,6 +709,15 @@ struct drm_amdgpu_cs_chunk_data {
>     > >>>>>>          };
>     > >>>>>>   };
>     > >>>>>>
>     > >>>>>> +#define AMDGPU_CS_CHUNK_CP_GFX_SHADOW_FLAGS_INIT_SHADOW 
>            0x1
>     > >>>>>> +
>     > >>>>>> +struct drm_amdgpu_cs_chunk_cp_gfx_shadow {
>     > >>>>>> +       __u64 shadow_va;
>     > >>>>>> +       __u64 csa_va;
>     > >>>>>> +       __u64 gds_va;
>     > >>>>>> +       __u64 flags;
>     > >>>>>> +};
>     > >>>>>> +
>     > >>>>>>   /*
>     > >>>>>>    *  Query h/w info: Flag that this is integrated
>     (a.h.a. fusion) GPU
>     > >>>>>>    *
>     > >>>>>> --
>     > >>>>>> 2.39.2
>     > >>>>>>
>     >
>

--------------Afx6I4vuTvEAfeQrGrLIq60o
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    Me as well.<br>
    <br>
    Christian.<br>
    <br>
    <div class="moz-cite-prefix">Am 13.04.23 um 20:23 schrieb Marek
      Olšák:<br>
    </div>
    <blockquote type="cite"
cite="mid:CAAxE2A5XxySNG2BqcXZKhq=wyC7DnhONLtyFLgRx4x65K3ZbTA@mail.gmail.com">
      <meta http-equiv="content-type" content="text/html; charset=UTF-8">
      <div dir="ltr">
        <div>I'm OK with that.</div>
        <div><br>
        </div>
        <div>Marek<br>
        </div>
      </div>
      <br>
      <div class="gmail_quote">
        <div dir="ltr" class="gmail_attr">On Thu, Apr 13, 2023 at
          12:56 PM Alex Deucher &lt;<a
            href="mailto:alexdeucher@gmail.com" moz-do-not-send="true"
            class="moz-txt-link-freetext">alexdeucher@gmail.com</a>&gt;
          wrote:<br>
        </div>
        <blockquote class="gmail_quote" style="margin:0px 0px 0px
          0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On
          Thu, Apr 13, 2023 at 11:54 AM Christian König<br>
          &lt;<a href="mailto:ckoenig.leichtzumerken@gmail.com"
            target="_blank" moz-do-not-send="true"
            class="moz-txt-link-freetext">ckoenig.leichtzumerken@gmail.com</a>&gt;
          wrote:<br>
          &gt;<br>
          &gt; Am 13.04.23 um 14:26 schrieb Alex Deucher:<br>
          &gt; &gt; On Thu, Apr 13, 2023 at 7:32 AM Christian König<br>
          &gt; &gt; &lt;<a
            href="mailto:ckoenig.leichtzumerken@gmail.com"
            target="_blank" moz-do-not-send="true"
            class="moz-txt-link-freetext">ckoenig.leichtzumerken@gmail.com</a>&gt;
          wrote:<br>
          &gt; &gt;&gt; Ok, then we have a problem.<br>
          &gt; &gt;&gt;<br>
          &gt; &gt;&gt; Alex what do you think?<br>
          &gt; &gt; If you program it to 0, FW skips the GDS backup I
          think so UMD's can<br>
          &gt; &gt; decide whether they want to use it or not, depending
          on whether they<br>
          &gt; &gt; use GDS.<br>
          &gt;<br>
          &gt; Yeah, but when Mesa isn't using it we have a hard way
          justifying to<br>
          &gt; upstream that because it isn't tested at all.<br>
          <br>
          Well, the interface would still get used, it's just that mesa
          would<br>
          likely only ever pass 0 for the virtual address.  It's just a<br>
          passthrough to the packet.  If we discover we need it at some
          point,<br>
          it would be nice to not have to add a new interface to add it.<br>
          <br>
          Alex<br>
          <br>
          &gt;<br>
          &gt; Christian.<br>
          &gt;<br>
          &gt; &gt;<br>
          &gt; &gt; Alex<br>
          &gt; &gt;<br>
          &gt; &gt;<br>
          &gt; &gt;&gt; Christian.<br>
          &gt; &gt;&gt;<br>
          &gt; &gt;&gt; Am 13.04.23 um 11:21 schrieb Marek Olšák:<br>
          &gt; &gt;&gt;<br>
          &gt; &gt;&gt; That's not why it was removed. It was removed
          because userspace doesn't use GDS memory and gds_va is always
          going to be 0.<br>
          &gt; &gt;&gt;<br>
          &gt; &gt;&gt; Firmware shouldn't use it because using it would
          increase preemption latency.<br>
          &gt; &gt;&gt;<br>
          &gt; &gt;&gt; Marek<br>
          &gt; &gt;&gt;<br>
          &gt; &gt;&gt; On Sun, Apr 9, 2023, 11:21 Christian König &lt;<a
            href="mailto:ckoenig.leichtzumerken@gmail.com"
            target="_blank" moz-do-not-send="true"
            class="moz-txt-link-freetext">ckoenig.leichtzumerken@gmail.com</a>&gt;
          wrote:<br>
          &gt; &gt;&gt;&gt; We removed the GDS information because they
          were unnecessary. The GDS size was already part of the device
          info before we added the shadow info.<br>
          &gt; &gt;&gt;&gt;<br>
          &gt; &gt;&gt;&gt; But as far as I know the firmware needs
          valid VAs for all three buffers or won't work correctly.<br>
          &gt; &gt;&gt;&gt;<br>
          &gt; &gt;&gt;&gt; Christian.<br>
          &gt; &gt;&gt;&gt;<br>
          &gt; &gt;&gt;&gt; Am 06.04.23 um 17:01 schrieb Marek Olšák:<br>
          &gt; &gt;&gt;&gt;<br>
          &gt; &gt;&gt;&gt; There is no GDS shadowing info in the device
          info uapi, so userspace can't create any GDS buffer and thus
          can't have any GDS va. It's a uapi issue, not what firmware
          wants to do.<br>
          &gt; &gt;&gt;&gt;<br>
          &gt; &gt;&gt;&gt; Marek<br>
          &gt; &gt;&gt;&gt;<br>
          &gt; &gt;&gt;&gt; On Thu, Apr 6, 2023 at 6:31 AM Christian
          König &lt;<a href="mailto:ckoenig.leichtzumerken@gmail.com"
            target="_blank" moz-do-not-send="true"
            class="moz-txt-link-freetext">ckoenig.leichtzumerken@gmail.com</a>&gt;
          wrote:<br>
          &gt; &gt;&gt;&gt;&gt; That's what I thought as well, but
          Mitch/Hans insisted on that.<br>
          &gt; &gt;&gt;&gt;&gt;<br>
          &gt; &gt;&gt;&gt;&gt; We should probably double check
          internally.<br>
          &gt; &gt;&gt;&gt;&gt;<br>
          &gt; &gt;&gt;&gt;&gt; Christian.<br>
          &gt; &gt;&gt;&gt;&gt;<br>
          &gt; &gt;&gt;&gt;&gt; Am 06.04.23 um 11:43 schrieb Marek
          Olšák:<br>
          &gt; &gt;&gt;&gt;&gt;<br>
          &gt; &gt;&gt;&gt;&gt; GDS memory isn't used on gfx11. Only GDS
          OA is used.<br>
          &gt; &gt;&gt;&gt;&gt;<br>
          &gt; &gt;&gt;&gt;&gt; Marek<br>
          &gt; &gt;&gt;&gt;&gt;<br>
          &gt; &gt;&gt;&gt;&gt; On Thu, Apr 6, 2023 at 5:09 AM Christian
          König &lt;<a href="mailto:christian.koenig@amd.com"
            target="_blank" moz-do-not-send="true"
            class="moz-txt-link-freetext">christian.koenig@amd.com</a>&gt;
          wrote:<br>
          &gt; &gt;&gt;&gt;&gt;&gt; Why that?<br>
          &gt; &gt;&gt;&gt;&gt;&gt;<br>
          &gt; &gt;&gt;&gt;&gt;&gt; This is the save buffer for GDS, not
          the old style GDS BOs.<br>
          &gt; &gt;&gt;&gt;&gt;&gt;<br>
          &gt; &gt;&gt;&gt;&gt;&gt; Christian.<br>
          &gt; &gt;&gt;&gt;&gt;&gt;<br>
          &gt; &gt;&gt;&gt;&gt;&gt; Am 06.04.23 um 09:36 schrieb Marek
          Olšák:<br>
          &gt; &gt;&gt;&gt;&gt;&gt;<br>
          &gt; &gt;&gt;&gt;&gt;&gt; gds_va is unnecessary.<br>
          &gt; &gt;&gt;&gt;&gt;&gt;<br>
          &gt; &gt;&gt;&gt;&gt;&gt; Marek<br>
          &gt; &gt;&gt;&gt;&gt;&gt;<br>
          &gt; &gt;&gt;&gt;&gt;&gt; On Thu, Mar 30, 2023 at 3:18 PM Alex
          Deucher &lt;<a href="mailto:alexander.deucher@amd.com"
            target="_blank" moz-do-not-send="true"
            class="moz-txt-link-freetext">alexander.deucher@amd.com</a>&gt;
          wrote:<br>
          &gt; &gt;&gt;&gt;&gt;&gt;&gt; For GFX11, the UMD needs to
          allocate some shadow buffers<br>
          &gt; &gt;&gt;&gt;&gt;&gt;&gt; to be used for preemption.  The
          UMD allocates the buffers<br>
          &gt; &gt;&gt;&gt;&gt;&gt;&gt; and passes the GPU virtual
          address to the kernel since the<br>
          &gt; &gt;&gt;&gt;&gt;&gt;&gt; kernel will program the packet
          that specified these<br>
          &gt; &gt;&gt;&gt;&gt;&gt;&gt; addresses as part of its IB
          submission frame.<br>
          &gt; &gt;&gt;&gt;&gt;&gt;&gt;<br>
          &gt; &gt;&gt;&gt;&gt;&gt;&gt; v2: UMD passes shadow init to
          tell kernel when to initialize<br>
          &gt; &gt;&gt;&gt;&gt;&gt;&gt;      the shadow<br>
          &gt; &gt;&gt;&gt;&gt;&gt;&gt;<br>
          &gt; &gt;&gt;&gt;&gt;&gt;&gt; Reviewed-by: Christian König
          &lt;<a href="mailto:christian.koenig@amd.com" target="_blank"
            moz-do-not-send="true" class="moz-txt-link-freetext">christian.koenig@amd.com</a>&gt;<br>
          &gt; &gt;&gt;&gt;&gt;&gt;&gt; Signed-off-by: Alex Deucher &lt;<a
            href="mailto:alexander.deucher@amd.com" target="_blank"
            moz-do-not-send="true" class="moz-txt-link-freetext">alexander.deucher@amd.com</a>&gt;<br>
          &gt; &gt;&gt;&gt;&gt;&gt;&gt; ---<br>
          &gt; &gt;&gt;&gt;&gt;&gt;&gt;   include/uapi/drm/amdgpu_drm.h
          | 10 ++++++++++<br>
          &gt; &gt;&gt;&gt;&gt;&gt;&gt;   1 file changed, 10
          insertions(+)<br>
          &gt; &gt;&gt;&gt;&gt;&gt;&gt;<br>
          &gt; &gt;&gt;&gt;&gt;&gt;&gt; diff --git
          a/include/uapi/drm/amdgpu_drm.h
          b/include/uapi/drm/amdgpu_drm.h<br>
          &gt; &gt;&gt;&gt;&gt;&gt;&gt; index b6eb90df5d05..3d9474af6566
          100644<br>
          &gt; &gt;&gt;&gt;&gt;&gt;&gt; ---
          a/include/uapi/drm/amdgpu_drm.h<br>
          &gt; &gt;&gt;&gt;&gt;&gt;&gt; +++
          b/include/uapi/drm/amdgpu_drm.h<br>
          &gt; &gt;&gt;&gt;&gt;&gt;&gt; @@ -592,6 +592,7 @@ struct
          drm_amdgpu_gem_va {<br>
          &gt; &gt;&gt;&gt;&gt;&gt;&gt;   #define
          AMDGPU_CHUNK_ID_SCHEDULED_DEPENDENCIES 0x07<br>
          &gt; &gt;&gt;&gt;&gt;&gt;&gt;   #define
          AMDGPU_CHUNK_ID_SYNCOBJ_TIMELINE_WAIT    0x08<br>
          &gt; &gt;&gt;&gt;&gt;&gt;&gt;   #define
          AMDGPU_CHUNK_ID_SYNCOBJ_TIMELINE_SIGNAL  0x09<br>
          &gt; &gt;&gt;&gt;&gt;&gt;&gt; +#define
          AMDGPU_CHUNK_ID_CP_GFX_SHADOW   0x0a<br>
          &gt; &gt;&gt;&gt;&gt;&gt;&gt;<br>
          &gt; &gt;&gt;&gt;&gt;&gt;&gt;   struct drm_amdgpu_cs_chunk {<br>
          &gt; &gt;&gt;&gt;&gt;&gt;&gt;          __u32         
           chunk_id;<br>
          &gt; &gt;&gt;&gt;&gt;&gt;&gt; @@ -708,6 +709,15 @@ struct
          drm_amdgpu_cs_chunk_data {<br>
          &gt; &gt;&gt;&gt;&gt;&gt;&gt;          };<br>
          &gt; &gt;&gt;&gt;&gt;&gt;&gt;   };<br>
          &gt; &gt;&gt;&gt;&gt;&gt;&gt;<br>
          &gt; &gt;&gt;&gt;&gt;&gt;&gt; +#define
          AMDGPU_CS_CHUNK_CP_GFX_SHADOW_FLAGS_INIT_SHADOW         0x1<br>
          &gt; &gt;&gt;&gt;&gt;&gt;&gt; +<br>
          &gt; &gt;&gt;&gt;&gt;&gt;&gt; +struct
          drm_amdgpu_cs_chunk_cp_gfx_shadow {<br>
          &gt; &gt;&gt;&gt;&gt;&gt;&gt; +       __u64 shadow_va;<br>
          &gt; &gt;&gt;&gt;&gt;&gt;&gt; +       __u64 csa_va;<br>
          &gt; &gt;&gt;&gt;&gt;&gt;&gt; +       __u64 gds_va;<br>
          &gt; &gt;&gt;&gt;&gt;&gt;&gt; +       __u64 flags;<br>
          &gt; &gt;&gt;&gt;&gt;&gt;&gt; +};<br>
          &gt; &gt;&gt;&gt;&gt;&gt;&gt; +<br>
          &gt; &gt;&gt;&gt;&gt;&gt;&gt;   /*<br>
          &gt; &gt;&gt;&gt;&gt;&gt;&gt;    *  Query h/w info: Flag that
          this is integrated (a.h.a. fusion) GPU<br>
          &gt; &gt;&gt;&gt;&gt;&gt;&gt;    *<br>
          &gt; &gt;&gt;&gt;&gt;&gt;&gt; --<br>
          &gt; &gt;&gt;&gt;&gt;&gt;&gt; 2.39.2<br>
          &gt; &gt;&gt;&gt;&gt;&gt;&gt;<br>
          &gt;<br>
        </blockquote>
      </div>
    </blockquote>
    <br>
  </body>
</html>

--------------Afx6I4vuTvEAfeQrGrLIq60o--
