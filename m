Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6E0CC77B70
	for <amd-gfx@archiver.kernel.org>; Sun,  9 Apr 2023 15:21:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 87EC410E1BA;
	Sun,  9 Apr 2023 15:21:37 +0000 (UTC)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 484D310E1BA
 for <amd-gfx@lists.freedesktop.org>; Sun,  9 Apr 2023 15:21:35 +0000 (UTC)
Received: by mail-wm1-x32e.google.com with SMTP id
 hg25-20020a05600c539900b003f05a99a841so9487976wmb.3
 for <amd-gfx@lists.freedesktop.org>; Sun, 09 Apr 2023 08:21:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20210112; t=1681053693; x=1683645693;
 h=in-reply-to:from:references:cc:to:content-language:subject
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wMB0wcqy/oxeERBh1qn/dfjt06YJyHzfy0J4864U8nk=;
 b=Gyex41tckFcWZEH21xWVdhZ4HHRwaDrLtBlLq/S4J06pI7Hm9rxfsNzZpZEz4wAmH0
 YFITQrNHGMJ1EL0L1Vv/tPu29SsX1BAiO3sdQdc4GJ+atCe5S0GJmeBcNLpsZ/qgtlV0
 lej0vAmWeSMhVdYKZiAmcepPWY8Bcm5jRuG/Ri9xOnF/NqequBPWoxwstK/tUE1ol23N
 9gdvrlKbG+XSEc1VlCJH3sNFDcdpQFkyk35vdA/mEVOtwJu/jo81zcQrQ213vQwRJhvr
 510c4ps8YNNfk/oVTMi5+dQ/Y8aP7Fx9+plPV5vek4NgsuL4jMMzIu+XWndDQG2BjIZo
 zQoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1681053693; x=1683645693;
 h=in-reply-to:from:references:cc:to:content-language:subject
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=wMB0wcqy/oxeERBh1qn/dfjt06YJyHzfy0J4864U8nk=;
 b=teCBa2Fet4cTqF4oZegqXI6ZIav72BaCLn5+02aNufhOntkZxw4Q34RjdyuZeei8BX
 zWm71Ppo/ypbqtGhDBB7PY4x2r5/zXZdfexTxq667M12zKzlewjy+VzmYQfn0c6NU2tn
 kCXEI8uWQ0lQSM6WQS/b2F/O0LvAzH+YthWrU4k1ZSu12UeguSmFhkJOfZbABXk3h6a/
 il036kXfomYYKvHMCcKdSurSi84kdBBfJenryoxteb3LHkH04VBgUJHnbtxd9+c5Wxav
 KnKoxp1yBfeAephNy2whLhP1JeDZM6K5Dp7nZO4NwyKJQWBNTKcb1sDRAtFNHcLjQbE7
 zKdQ==
X-Gm-Message-State: AAQBX9efcaiWkrc9EzUSLykPXKywGsYWvt52rimFSb/Ge1aQCE5iQswD
 6i5yHoIOyi9lzT6cL2jHT0g=
X-Google-Smtp-Source: AKy350YCTxwGfm+dmZlRP1EvUu6eXFWg/B4OZseLBdnLfM4Y9a3FVxuO9rP9tOhRdzk5v71k+Spodg==
X-Received: by 2002:a05:600c:2184:b0:3ef:64b4:b081 with SMTP id
 e4-20020a05600c218400b003ef64b4b081mr3143294wme.39.1681053693053; 
 Sun, 09 Apr 2023 08:21:33 -0700 (PDT)
Received: from ?IPV6:2a02:908:1256:79a0:f3e8:9542:46ff:241f?
 ([2a02:908:1256:79a0:f3e8:9542:46ff:241f])
 by smtp.gmail.com with ESMTPSA id
 k23-20020a05600c0b5700b003ee44b2effasm10849200wmr.12.2023.04.09.08.21.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 09 Apr 2023 08:21:32 -0700 (PDT)
Content-Type: multipart/alternative;
 boundary="------------eBFm1rYmJ2UK6NMVt24iB3Lc"
Message-ID: <2897fa79-f0ef-1ddb-dc38-05ef429fe0d9@gmail.com>
Date: Sun, 9 Apr 2023 17:21:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 03/13] drm/amdgpu/UAPI: add new CS chunk for GFX shadow
 buffers
Content-Language: en-US
To: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
References: <20230330191750.1134210-1-alexander.deucher@amd.com>
 <20230330191750.1134210-4-alexander.deucher@amd.com>
 <CAAxE2A7nvmXdUaXESi4g6HVBFxk+dooz7tZYQfjGE8O2fKFi-w@mail.gmail.com>
 <8a98b160-5276-54f5-d166-e12a572892e9@amd.com>
 <CAAxE2A4LzFudfzTNRr290ORZvcF6-xzKiyNM6LZ3uiZDPerf5Q@mail.gmail.com>
 <b1485943-5f0a-1a7e-f0a4-b35771b48a23@gmail.com>
 <CAAxE2A6m346bTD7G=wMa=8OcRmk6OHui9N=Z9B5xHCS4VxxYwQ@mail.gmail.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <CAAxE2A6m346bTD7G=wMa=8OcRmk6OHui9N=Z9B5xHCS4VxxYwQ@mail.gmail.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This is a multi-part message in MIME format.
--------------eBFm1rYmJ2UK6NMVt24iB3Lc
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

We removed the GDS information because they were unnecessary. The GDS 
size was already part of the device info before we added the shadow info.

But as far as I know the firmware needs valid VAs for all three buffers 
or won't work correctly.

Christian.

Am 06.04.23 um 17:01 schrieb Marek Olšák:
> There is no GDS shadowing info in the device info uapi, so userspace 
> can't create any GDS buffer and thus can't have any GDS va. It's a 
> uapi issue, not what firmware wants to do.
>
> Marek
>
> On Thu, Apr 6, 2023 at 6:31 AM Christian König 
> <ckoenig.leichtzumerken@gmail.com> wrote:
>
>     That's what I thought as well, but Mitch/Hans insisted on that.
>
>     We should probably double check internally.
>
>     Christian.
>
>     Am 06.04.23 um 11:43 schrieb Marek Olšák:
>>     GDS memory isn't used on gfx11. Only GDS OA is used.
>>
>>     Marek
>>
>>     On Thu, Apr 6, 2023 at 5:09 AM Christian König
>>     <christian.koenig@amd.com> wrote:
>>
>>         Why that?
>>
>>         This is the save buffer for GDS, not the old style GDS BOs.
>>
>>         Christian.
>>
>>         Am 06.04.23 um 09:36 schrieb Marek Olšák:
>>>         gds_va is unnecessary.
>>>
>>>         Marek
>>>
>>>         On Thu, Mar 30, 2023 at 3:18 PM Alex Deucher
>>>         <alexander.deucher@amd.com> wrote:
>>>
>>>             For GFX11, the UMD needs to allocate some shadow buffers
>>>             to be used for preemption.  The UMD allocates the buffers
>>>             and passes the GPU virtual address to the kernel since the
>>>             kernel will program the packet that specified these
>>>             addresses as part of its IB submission frame.
>>>
>>>             v2: UMD passes shadow init to tell kernel when to initialize
>>>                 the shadow
>>>
>>>             Reviewed-by: Christian König <christian.koenig@amd.com>
>>>             Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>>>             ---
>>>              include/uapi/drm/amdgpu_drm.h | 10 ++++++++++
>>>              1 file changed, 10 insertions(+)
>>>
>>>             diff --git a/include/uapi/drm/amdgpu_drm.h
>>>             b/include/uapi/drm/amdgpu_drm.h
>>>             index b6eb90df5d05..3d9474af6566 100644
>>>             --- a/include/uapi/drm/amdgpu_drm.h
>>>             +++ b/include/uapi/drm/amdgpu_drm.h
>>>             @@ -592,6 +592,7 @@ struct drm_amdgpu_gem_va {
>>>              #define AMDGPU_CHUNK_ID_SCHEDULED_DEPENDENCIES 0x07
>>>              #define AMDGPU_CHUNK_ID_SYNCOBJ_TIMELINE_WAIT    0x08
>>>              #define AMDGPU_CHUNK_ID_SYNCOBJ_TIMELINE_SIGNAL  0x09
>>>             +#define AMDGPU_CHUNK_ID_CP_GFX_SHADOW   0x0a
>>>
>>>              struct drm_amdgpu_cs_chunk {
>>>                     __u32           chunk_id;
>>>             @@ -708,6 +709,15 @@ struct drm_amdgpu_cs_chunk_data {
>>>                     };
>>>              };
>>>
>>>             +#define AMDGPU_CS_CHUNK_CP_GFX_SHADOW_FLAGS_INIT_SHADOW
>>>                    0x1
>>>             +
>>>             +struct drm_amdgpu_cs_chunk_cp_gfx_shadow {
>>>             +       __u64 shadow_va;
>>>             +       __u64 csa_va;
>>>             +       __u64 gds_va;
>>>             +       __u64 flags;
>>>             +};
>>>             +
>>>              /*
>>>               *  Query h/w info: Flag that this is integrated
>>>             (a.h.a. fusion) GPU
>>>               *
>>>             -- 
>>>             2.39.2
>>>
>>
>

--------------eBFm1rYmJ2UK6NMVt24iB3Lc
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    We removed the GDS information because they were unnecessary. The
    GDS size was already part of the device info before we added the
    shadow info.<br>
    <br>
    But as far as I know the firmware needs valid VAs for all three
    buffers or won't work correctly.<br>
    <br>
    Christian.<br>
    <br>
    <div class="moz-cite-prefix">Am 06.04.23 um 17:01 schrieb Marek
      Olšák:<br>
    </div>
    <blockquote type="cite"
cite="mid:CAAxE2A6m346bTD7G=wMa=8OcRmk6OHui9N=Z9B5xHCS4VxxYwQ@mail.gmail.com">
      <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
      <div dir="ltr">
        <div>There is no GDS shadowing info in the device info uapi, so
          userspace can't create any GDS buffer and thus can't have any
          GDS va. It's a uapi issue, not what firmware wants to do.<br>
        </div>
        <div><br>
        </div>
        <div>Marek<br>
        </div>
      </div>
      <br>
      <div class="gmail_quote">
        <div dir="ltr" class="gmail_attr">On Thu, Apr 6, 2023 at 6:31 AM
          Christian König &lt;<a
            href="mailto:ckoenig.leichtzumerken@gmail.com"
            target="_blank" moz-do-not-send="true"
            class="moz-txt-link-freetext">ckoenig.leichtzumerken@gmail.com</a>&gt;
          wrote:<br>
        </div>
        <blockquote class="gmail_quote" style="margin:0px 0px 0px
          0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
          <div> That's what I thought as well, but Mitch/Hans insisted
            on that.<br>
            <br>
            We should probably double check internally.<br>
            <br>
            Christian.<br>
            <br>
            <div>Am 06.04.23 um 11:43 schrieb Marek Olšák:<br>
            </div>
            <blockquote type="cite">
              <div dir="ltr">
                <div>GDS memory isn't used on gfx11. Only GDS OA is
                  used.<br>
                </div>
                <div><br>
                </div>
                <div>Marek<br>
                </div>
              </div>
              <br>
              <div class="gmail_quote">
                <div dir="ltr" class="gmail_attr">On Thu, Apr 6, 2023 at
                  5:09 AM Christian König &lt;<a
                    href="mailto:christian.koenig@amd.com"
                    target="_blank" moz-do-not-send="true"
                    class="moz-txt-link-freetext">christian.koenig@amd.com</a>&gt;
                  wrote:<br>
                </div>
                <blockquote class="gmail_quote" style="margin:0px 0px
                  0px 0.8ex;border-left:1px solid
                  rgb(204,204,204);padding-left:1ex">
                  <div> Why that?<br>
                    <br>
                    This is the save buffer for GDS, not the old style
                    GDS BOs.<br>
                    <br>
                    Christian.<br>
                    <br>
                    <div>Am 06.04.23 um 09:36 schrieb Marek Olšák:<br>
                    </div>
                    <blockquote type="cite">
                      <div dir="ltr">
                        <div>gds_va is unnecessary.</div>
                        <div><br>
                        </div>
                        <div>Marek<br>
                        </div>
                      </div>
                      <br>
                      <div class="gmail_quote">
                        <div dir="ltr" class="gmail_attr">On Thu, Mar
                          30, 2023 at 3:18 PM Alex Deucher &lt;<a
                            href="mailto:alexander.deucher@amd.com"
                            target="_blank" moz-do-not-send="true"
                            class="moz-txt-link-freetext">alexander.deucher@amd.com</a>&gt;
                          wrote:<br>
                        </div>
                        <blockquote class="gmail_quote"
                          style="margin:0px 0px 0px
                          0.8ex;border-left:1px solid
                          rgb(204,204,204);padding-left:1ex">For GFX11,
                          the UMD needs to allocate some shadow buffers<br>
                          to be used for preemption.  The UMD allocates
                          the buffers<br>
                          and passes the GPU virtual address to the
                          kernel since the<br>
                          kernel will program the packet that specified
                          these<br>
                          addresses as part of its IB submission frame.<br>
                          <br>
                          v2: UMD passes shadow init to tell kernel when
                          to initialize<br>
                              the shadow<br>
                          <br>
                          Reviewed-by: Christian König &lt;<a
                            href="mailto:christian.koenig@amd.com"
                            target="_blank" moz-do-not-send="true"
                            class="moz-txt-link-freetext">christian.koenig@amd.com</a>&gt;<br>
                          Signed-off-by: Alex Deucher &lt;<a
                            href="mailto:alexander.deucher@amd.com"
                            target="_blank" moz-do-not-send="true"
                            class="moz-txt-link-freetext">alexander.deucher@amd.com</a>&gt;<br>
                          ---<br>
                           include/uapi/drm/amdgpu_drm.h | 10 ++++++++++<br>
                           1 file changed, 10 insertions(+)<br>
                          <br>
                          diff --git a/include/uapi/drm/amdgpu_drm.h
                          b/include/uapi/drm/amdgpu_drm.h<br>
                          index b6eb90df5d05..3d9474af6566 100644<br>
                          --- a/include/uapi/drm/amdgpu_drm.h<br>
                          +++ b/include/uapi/drm/amdgpu_drm.h<br>
                          @@ -592,6 +592,7 @@ struct drm_amdgpu_gem_va {<br>
                           #define
                          AMDGPU_CHUNK_ID_SCHEDULED_DEPENDENCIES 0x07<br>
                           #define
                          AMDGPU_CHUNK_ID_SYNCOBJ_TIMELINE_WAIT    0x08<br>
                           #define
                          AMDGPU_CHUNK_ID_SYNCOBJ_TIMELINE_SIGNAL  0x09<br>
                          +#define AMDGPU_CHUNK_ID_CP_GFX_SHADOW   0x0a<br>
                          <br>
                           struct drm_amdgpu_cs_chunk {<br>
                                  __u32           chunk_id;<br>
                          @@ -708,6 +709,15 @@ struct
                          drm_amdgpu_cs_chunk_data {<br>
                                  };<br>
                           };<br>
                          <br>
                          +#define
                          AMDGPU_CS_CHUNK_CP_GFX_SHADOW_FLAGS_INIT_SHADOW 
                                 0x1<br>
                          +<br>
                          +struct drm_amdgpu_cs_chunk_cp_gfx_shadow {<br>
                          +       __u64 shadow_va;<br>
                          +       __u64 csa_va;<br>
                          +       __u64 gds_va;<br>
                          +       __u64 flags;<br>
                          +};<br>
                          +<br>
                           /*<br>
                            *  Query h/w info: Flag that this is
                          integrated (a.h.a. fusion) GPU<br>
                            *<br>
                          -- <br>
                          2.39.2<br>
                          <br>
                        </blockquote>
                      </div>
                    </blockquote>
                    <br>
                  </div>
                </blockquote>
              </div>
            </blockquote>
            <br>
          </div>
        </blockquote>
      </div>
    </blockquote>
    <br>
  </body>
</html>

--------------eBFm1rYmJ2UK6NMVt24iB3Lc--
