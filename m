Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0D1BC76196
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Apr 2023 10:31:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4F91510EB4C;
	Thu,  6 Apr 2023 10:31:25 +0000 (UTC)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 67BA810EB4C
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Apr 2023 10:31:23 +0000 (UTC)
Received: by mail-wr1-x42d.google.com with SMTP id y14so39046979wrq.4
 for <amd-gfx@lists.freedesktop.org>; Thu, 06 Apr 2023 03:31:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20210112; t=1680777081; x=1683369081;
 h=in-reply-to:from:references:cc:to:content-language:subject
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6z7X0k5PRwTtFsVwxtnrEnLsaOtQuQHT21b/gQZ8/fM=;
 b=b257hvip20lBuifEgPznlP2RlJKYoxjuGw4TAY+PArtZnbOft49PyIx/WLy2HAyzHr
 aKkIIiAsxE37K+kP1FZsamg+bsvMQLZbVPTfH3VzE+9MpZLIav7blm5j7fhM4u0wSK1u
 QrewY7HHQI8FDqaS1e+pSuQVSHdbfJokfQ3pYZG4lxfdnnp8Kmb8ueSiUNX53cdY9ote
 BrqiVknPUgcKx14jVW6nwxWF6sPuyNJhD72NIse5W1lwcCuLTOkRykUUiEnwRdZy7IzN
 GLybUn6CnyFAQcgiPQaRYt4Lag6Zmv8QYQ/tgcOkBFjLUVNyq8EnpU/BCLCbVzXLRmKH
 n1dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1680777081; x=1683369081;
 h=in-reply-to:from:references:cc:to:content-language:subject
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=6z7X0k5PRwTtFsVwxtnrEnLsaOtQuQHT21b/gQZ8/fM=;
 b=SYc0BjFtlDZZJ4gCBeZzrZWHmPQ5XRGDkGLdaEBm0mDz3R6F6/Swu0ikVqNisUU18T
 LELv91J0RH8Mi973H9gkW0ncig9U87aRQfrUqmqLf7CGj5P1Zsi3wIZu0tNWOGtqqb65
 5nbrqfPIV2bmPL1aNK5zK+A8dvTbuymV066LoIEz4vFBe1fV9Txha3MhmS742MEY2K1N
 oFCe8v+ZM6zO2IeGGztrrkwLy69vVZ+iFk+iiPA2R8HdhU0y78tnbL0dcSnE7S3+hu82
 /nXVN5cY1PK2T1It+oI4M1dJRxX6Egdc+83yZNZyygDNDNuXQqw1V9zFH4l04PLsD2v/
 K0fA==
X-Gm-Message-State: AAQBX9cZnAd20CGhrB/MUwcvI8DNAtmHnTcdfIwi/b0XgAl5s5wQXW6y
 j/A1TKQvlgu8ZkbFzSnH9dTRzEIabhc=
X-Google-Smtp-Source: AKy350YHWUr0shmGdcOjk29++2+omLMYMYmigrk+UBGKk3Ko5/FBPPc/4gHUVWP2oWUvUezCZEtj2g==
X-Received: by 2002:a5d:4ec3:0:b0:2ce:ae54:1592 with SMTP id
 s3-20020a5d4ec3000000b002ceae541592mr6194860wrv.38.1680777081266; 
 Thu, 06 Apr 2023 03:31:21 -0700 (PDT)
Received: from [192.168.178.21] (p4fc2092b.dip0.t-ipconnect.de. [79.194.9.43])
 by smtp.gmail.com with ESMTPSA id
 x1-20020adfec01000000b002e52dfb9256sm1393462wrn.41.2023.04.06.03.31.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Apr 2023 03:31:20 -0700 (PDT)
Content-Type: multipart/alternative;
 boundary="------------7BiG3h0lsTmJiZMpuaYi56KG"
Message-ID: <b1485943-5f0a-1a7e-f0a4-b35771b48a23@gmail.com>
Date: Thu, 6 Apr 2023 12:31:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 03/13] drm/amdgpu/UAPI: add new CS chunk for GFX shadow
 buffers
Content-Language: en-US
To: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
References: <20230330191750.1134210-1-alexander.deucher@amd.com>
 <20230330191750.1134210-4-alexander.deucher@amd.com>
 <CAAxE2A7nvmXdUaXESi4g6HVBFxk+dooz7tZYQfjGE8O2fKFi-w@mail.gmail.com>
 <8a98b160-5276-54f5-d166-e12a572892e9@amd.com>
 <CAAxE2A4LzFudfzTNRr290ORZvcF6-xzKiyNM6LZ3uiZDPerf5Q@mail.gmail.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <CAAxE2A4LzFudfzTNRr290ORZvcF6-xzKiyNM6LZ3uiZDPerf5Q@mail.gmail.com>
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
--------------7BiG3h0lsTmJiZMpuaYi56KG
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

That's what I thought as well, but Mitch/Hans insisted on that.

We should probably double check internally.

Christian.

Am 06.04.23 um 11:43 schrieb Marek Olšák:
> GDS memory isn't used on gfx11. Only GDS OA is used.
>
> Marek
>
> On Thu, Apr 6, 2023 at 5:09 AM Christian König 
> <christian.koenig@amd.com> wrote:
>
>     Why that?
>
>     This is the save buffer for GDS, not the old style GDS BOs.
>
>     Christian.
>
>     Am 06.04.23 um 09:36 schrieb Marek Olšák:
>>     gds_va is unnecessary.
>>
>>     Marek
>>
>>     On Thu, Mar 30, 2023 at 3:18 PM Alex Deucher
>>     <alexander.deucher@amd.com> wrote:
>>
>>         For GFX11, the UMD needs to allocate some shadow buffers
>>         to be used for preemption.  The UMD allocates the buffers
>>         and passes the GPU virtual address to the kernel since the
>>         kernel will program the packet that specified these
>>         addresses as part of its IB submission frame.
>>
>>         v2: UMD passes shadow init to tell kernel when to initialize
>>             the shadow
>>
>>         Reviewed-by: Christian König <christian.koenig@amd.com>
>>         Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>>         ---
>>          include/uapi/drm/amdgpu_drm.h | 10 ++++++++++
>>          1 file changed, 10 insertions(+)
>>
>>         diff --git a/include/uapi/drm/amdgpu_drm.h
>>         b/include/uapi/drm/amdgpu_drm.h
>>         index b6eb90df5d05..3d9474af6566 100644
>>         --- a/include/uapi/drm/amdgpu_drm.h
>>         +++ b/include/uapi/drm/amdgpu_drm.h
>>         @@ -592,6 +592,7 @@ struct drm_amdgpu_gem_va {
>>          #define AMDGPU_CHUNK_ID_SCHEDULED_DEPENDENCIES 0x07
>>          #define AMDGPU_CHUNK_ID_SYNCOBJ_TIMELINE_WAIT    0x08
>>          #define AMDGPU_CHUNK_ID_SYNCOBJ_TIMELINE_SIGNAL  0x09
>>         +#define AMDGPU_CHUNK_ID_CP_GFX_SHADOW   0x0a
>>
>>          struct drm_amdgpu_cs_chunk {
>>                 __u32           chunk_id;
>>         @@ -708,6 +709,15 @@ struct drm_amdgpu_cs_chunk_data {
>>                 };
>>          };
>>
>>         +#define AMDGPU_CS_CHUNK_CP_GFX_SHADOW_FLAGS_INIT_SHADOW  0x1
>>         +
>>         +struct drm_amdgpu_cs_chunk_cp_gfx_shadow {
>>         +       __u64 shadow_va;
>>         +       __u64 csa_va;
>>         +       __u64 gds_va;
>>         +       __u64 flags;
>>         +};
>>         +
>>          /*
>>           *  Query h/w info: Flag that this is integrated (a.h.a.
>>         fusion) GPU
>>           *
>>         -- 
>>         2.39.2
>>
>

--------------7BiG3h0lsTmJiZMpuaYi56KG
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    That's what I thought as well, but Mitch/Hans insisted on that.<br>
    <br>
    We should probably double check internally.<br>
    <br>
    Christian.<br>
    <br>
    <div class="moz-cite-prefix">Am 06.04.23 um 11:43 schrieb Marek
      Olšák:<br>
    </div>
    <blockquote type="cite"
cite="mid:CAAxE2A4LzFudfzTNRr290ORZvcF6-xzKiyNM6LZ3uiZDPerf5Q@mail.gmail.com">
      <meta http-equiv="content-type" content="text/html; charset=UTF-8">
      <div dir="ltr">
        <div>GDS memory isn't used on gfx11. Only GDS OA is used.<br>
        </div>
        <div><br>
        </div>
        <div>Marek<br>
        </div>
      </div>
      <br>
      <div class="gmail_quote">
        <div dir="ltr" class="gmail_attr">On Thu, Apr 6, 2023 at 5:09 AM
          Christian König &lt;<a href="mailto:christian.koenig@amd.com"
            moz-do-not-send="true" class="moz-txt-link-freetext">christian.koenig@amd.com</a>&gt;
          wrote:<br>
        </div>
        <blockquote class="gmail_quote" style="margin:0px 0px 0px
          0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
          <div> Why that?<br>
            <br>
            This is the save buffer for GDS, not the old style GDS BOs.<br>
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
                <div dir="ltr" class="gmail_attr">On Thu, Mar 30, 2023
                  at 3:18 PM Alex Deucher &lt;<a
                    href="mailto:alexander.deucher@amd.com"
                    target="_blank" moz-do-not-send="true"
                    class="moz-txt-link-freetext">alexander.deucher@amd.com</a>&gt;
                  wrote:<br>
                </div>
                <blockquote class="gmail_quote" style="margin:0px 0px
                  0px 0.8ex;border-left:1px solid
                  rgb(204,204,204);padding-left:1ex">For GFX11, the UMD
                  needs to allocate some shadow buffers<br>
                  to be used for preemption.  The UMD allocates the
                  buffers<br>
                  and passes the GPU virtual address to the kernel since
                  the<br>
                  kernel will program the packet that specified these<br>
                  addresses as part of its IB submission frame.<br>
                  <br>
                  v2: UMD passes shadow init to tell kernel when to
                  initialize<br>
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
                   #define AMDGPU_CHUNK_ID_SCHEDULED_DEPENDENCIES 0x07<br>
                   #define AMDGPU_CHUNK_ID_SYNCOBJ_TIMELINE_WAIT    0x08<br>
                   #define AMDGPU_CHUNK_ID_SYNCOBJ_TIMELINE_SIGNAL  0x09<br>
                  +#define AMDGPU_CHUNK_ID_CP_GFX_SHADOW   0x0a<br>
                  <br>
                   struct drm_amdgpu_cs_chunk {<br>
                          __u32           chunk_id;<br>
                  @@ -708,6 +709,15 @@ struct drm_amdgpu_cs_chunk_data {<br>
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
                    *  Query h/w info: Flag that this is integrated
                  (a.h.a. fusion) GPU<br>
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
  </body>
</html>

--------------7BiG3h0lsTmJiZMpuaYi56KG--
