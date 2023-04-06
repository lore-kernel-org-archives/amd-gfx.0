Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6FC8C7618D
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Apr 2023 09:44:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2A1EF10E066;
	Thu,  6 Apr 2023 09:44:13 +0000 (UTC)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4D1D010E066
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Apr 2023 09:44:12 +0000 (UTC)
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-4fa3ca4052eso1131559a12.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 06 Apr 2023 02:44:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20210112; t=1680774249;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=nlkFN1Lo1Q6+ecfIJ6APKDoGvubMxyNPS98GNJXUnto=;
 b=mAmCiqcpXfb8dbt1BynFoUlomlgXQi6rcr6+PpPNBQbZlbBCdPS7CUs9GelRvS3cSR
 P0IYa4kG5/sSCYARTk4qm2BtqT6gdUFK6lGeXMPA0S+SdEPIRfwxIEAIw4kl7iJsV7uH
 Q5tz82BdeSC0O7qWhNqpEKAkX4ZhJyu9FnK/vGT5oxGchQDtohVzo2p5mr8ttf0C/iBG
 xESPVBqdVD0guq80hoFrUE3dXcDqaaQ/BqPqLNtjjm/EPRbNuBpjB2vdh+s/6guT4Ubm
 dGEvi8llmjIxglBUrcW07gEdIfHNLjdm50kNlXLLOYpQh0pWEtfVNyso+EBc8fFu8cbY
 Ez2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1680774249;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nlkFN1Lo1Q6+ecfIJ6APKDoGvubMxyNPS98GNJXUnto=;
 b=aVFaiFLwc2Pkc6MoWahAIZW0BHu8KL9lGZGK8osP8GoVGf5bKQiwo/KUwPxY1Dwx/C
 ah4+oMzAlKyIwAccCGd09FS7cnVZjOgtuevPDdDMVd8pi26WG73MGkKrea9aos8Oh4pT
 j35d8hdGHTD+/pL5v3GVs1C8GNIijWu+joOhK4UYmoHBevwRcmxRPihx8vM5PjBl2Z0B
 7HvKoKs2+X3nljgnFOGaNum4eInfKcknh4OBl7IO75ksB9ATZiRAeWBMNSBrATN4u5TK
 xGobCaXLR1goG3/gyVebgWMb3iYuX1WfbA25r9dywKZP1Ce3cWbZWzJ2GYxb1zbsYV0C
 EsEw==
X-Gm-Message-State: AAQBX9ea74WB/GV/EUFd9D9gdUHz9CPg9wjr3+OJbVSjxAXj9eFtYPSd
 Ty3P1fIc+MIKwD1a1/qFBp0Y3iu9t/MpltBUlLI=
X-Google-Smtp-Source: AKy350axJfM3gMld+BapchRVJg9FMEqyHiR/tS3TAQiIMlOXGJs9MoUtWwE2aBjcnvSzDL30M6mY5B3f2C3Uckl8VLs=
X-Received: by 2002:a50:d781:0:b0:500:547b:4e1b with SMTP id
 w1-20020a50d781000000b00500547b4e1bmr2822430edi.6.1680774248684; Thu, 06 Apr
 2023 02:44:08 -0700 (PDT)
MIME-Version: 1.0
References: <20230330191750.1134210-1-alexander.deucher@amd.com>
 <20230330191750.1134210-4-alexander.deucher@amd.com>
 <CAAxE2A7nvmXdUaXESi4g6HVBFxk+dooz7tZYQfjGE8O2fKFi-w@mail.gmail.com>
 <8a98b160-5276-54f5-d166-e12a572892e9@amd.com>
In-Reply-To: <8a98b160-5276-54f5-d166-e12a572892e9@amd.com>
From: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>
Date: Thu, 6 Apr 2023 05:43:32 -0400
Message-ID: <CAAxE2A4LzFudfzTNRr290ORZvcF6-xzKiyNM6LZ3uiZDPerf5Q@mail.gmail.com>
Subject: Re: [PATCH 03/13] drm/amdgpu/UAPI: add new CS chunk for GFX shadow
 buffers
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: multipart/alternative; boundary="0000000000000a5e2305f8a7c016"
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

--0000000000000a5e2305f8a7c016
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

GDS memory isn't used on gfx11. Only GDS OA is used.

Marek

On Thu, Apr 6, 2023 at 5:09=E2=80=AFAM Christian K=C3=B6nig <christian.koen=
ig@amd.com>
wrote:

> Why that?
>
> This is the save buffer for GDS, not the old style GDS BOs.
>
> Christian.
>
> Am 06.04.23 um 09:36 schrieb Marek Ol=C5=A1=C3=A1k:
>
> gds_va is unnecessary.
>
> Marek
>
> On Thu, Mar 30, 2023 at 3:18=E2=80=AFPM Alex Deucher <alexander.deucher@a=
md.com>
> wrote:
>
>> For GFX11, the UMD needs to allocate some shadow buffers
>> to be used for preemption.  The UMD allocates the buffers
>> and passes the GPU virtual address to the kernel since the
>> kernel will program the packet that specified these
>> addresses as part of its IB submission frame.
>>
>> v2: UMD passes shadow init to tell kernel when to initialize
>>     the shadow
>>
>> Reviewed-by: Christian K=C3=B6nig <christian.koenig@amd.com>
>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>> ---
>>  include/uapi/drm/amdgpu_drm.h | 10 ++++++++++
>>  1 file changed, 10 insertions(+)
>>
>> diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm=
.h
>> index b6eb90df5d05..3d9474af6566 100644
>> --- a/include/uapi/drm/amdgpu_drm.h
>> +++ b/include/uapi/drm/amdgpu_drm.h
>> @@ -592,6 +592,7 @@ struct drm_amdgpu_gem_va {
>>  #define AMDGPU_CHUNK_ID_SCHEDULED_DEPENDENCIES 0x07
>>  #define AMDGPU_CHUNK_ID_SYNCOBJ_TIMELINE_WAIT    0x08
>>  #define AMDGPU_CHUNK_ID_SYNCOBJ_TIMELINE_SIGNAL  0x09
>> +#define AMDGPU_CHUNK_ID_CP_GFX_SHADOW   0x0a
>>
>>  struct drm_amdgpu_cs_chunk {
>>         __u32           chunk_id;
>> @@ -708,6 +709,15 @@ struct drm_amdgpu_cs_chunk_data {
>>         };
>>  };
>>
>> +#define AMDGPU_CS_CHUNK_CP_GFX_SHADOW_FLAGS_INIT_SHADOW         0x1
>> +
>> +struct drm_amdgpu_cs_chunk_cp_gfx_shadow {
>> +       __u64 shadow_va;
>> +       __u64 csa_va;
>> +       __u64 gds_va;
>> +       __u64 flags;
>> +};
>> +
>>  /*
>>   *  Query h/w info: Flag that this is integrated (a.h.a. fusion) GPU
>>   *
>> --
>> 2.39.2
>>
>>
>

--0000000000000a5e2305f8a7c016
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>GDS memory isn&#39;t used on gfx11. Only GDS OA is us=
ed.<br></div><div><br></div><div>Marek<br></div></div><br><div class=3D"gma=
il_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Apr 6, 2023 at 5:09=
=E2=80=AFAM Christian K=C3=B6nig &lt;<a href=3D"mailto:christian.koenig@amd=
.com">christian.koenig@amd.com</a>&gt; wrote:<br></div><blockquote class=3D=
"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(2=
04,204,204);padding-left:1ex">

 =20
  <div>
    Why that?<br>
    <br>
    This is the save buffer for GDS, not the old style GDS BOs.<br>
    <br>
    Christian.<br>
    <br>
    <div>Am 06.04.23 um 09:36 schrieb Marek
      Ol=C5=A1=C3=A1k:<br>
    </div>
    <blockquote type=3D"cite">
     =20
      <div dir=3D"ltr">
        <div>gds_va is unnecessary.</div>
        <div><br>
        </div>
        <div>Marek<br>
        </div>
      </div>
      <br>
      <div class=3D"gmail_quote">
        <div dir=3D"ltr" class=3D"gmail_attr">On Thu, Mar 30, 2023 at
          3:18=E2=80=AFPM Alex Deucher &lt;<a href=3D"mailto:alexander.deuc=
her@amd.com" target=3D"_blank">alexander.deucher@amd.com</a>&gt;
          wrote:<br>
        </div>
        <blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex=
;border-left:1px solid rgb(204,204,204);padding-left:1ex">For
          GFX11, the UMD needs to allocate some shadow buffers<br>
          to be used for preemption.=C2=A0 The UMD allocates the buffers<br=
>
          and passes the GPU virtual address to the kernel since the<br>
          kernel will program the packet that specified these<br>
          addresses as part of its IB submission frame.<br>
          <br>
          v2: UMD passes shadow init to tell kernel when to initialize<br>
          =C2=A0 =C2=A0 the shadow<br>
          <br>
          Reviewed-by: Christian K=C3=B6nig &lt;<a href=3D"mailto:christian=
.koenig@amd.com" target=3D"_blank">christian.koenig@amd.com</a>&gt;<br>
          Signed-off-by: Alex Deucher &lt;<a href=3D"mailto:alexander.deuch=
er@amd.com" target=3D"_blank">alexander.deucher@amd.com</a>&gt;<br>
          ---<br>
          =C2=A0include/uapi/drm/amdgpu_drm.h | 10 ++++++++++<br>
          =C2=A01 file changed, 10 insertions(+)<br>
          <br>
          diff --git a/include/uapi/drm/amdgpu_drm.h
          b/include/uapi/drm/amdgpu_drm.h<br>
          index b6eb90df5d05..3d9474af6566 100644<br>
          --- a/include/uapi/drm/amdgpu_drm.h<br>
          +++ b/include/uapi/drm/amdgpu_drm.h<br>
          @@ -592,6 +592,7 @@ struct drm_amdgpu_gem_va {<br>
          =C2=A0#define AMDGPU_CHUNK_ID_SCHEDULED_DEPENDENCIES 0x07<br>
          =C2=A0#define AMDGPU_CHUNK_ID_SYNCOBJ_TIMELINE_WAIT=C2=A0 =C2=A0 =
0x08<br>
          =C2=A0#define AMDGPU_CHUNK_ID_SYNCOBJ_TIMELINE_SIGNAL=C2=A0 0x09<=
br>
          +#define AMDGPU_CHUNK_ID_CP_GFX_SHADOW=C2=A0 =C2=A00x0a<br>
          <br>
          =C2=A0struct drm_amdgpu_cs_chunk {<br>
          =C2=A0 =C2=A0 =C2=A0 =C2=A0 __u32=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0chunk_id;<br>
          @@ -708,6 +709,15 @@ struct drm_amdgpu_cs_chunk_data {<br>
          =C2=A0 =C2=A0 =C2=A0 =C2=A0 };<br>
          =C2=A0};<br>
          <br>
          +#define AMDGPU_CS_CHUNK_CP_GFX_SHADOW_FLAGS_INIT_SHADOW=C2=A0 =
=C2=A0 =C2=A0
          =C2=A0 =C2=A00x1<br>
          +<br>
          +struct drm_amdgpu_cs_chunk_cp_gfx_shadow {<br>
          +=C2=A0 =C2=A0 =C2=A0 =C2=A0__u64 shadow_va;<br>
          +=C2=A0 =C2=A0 =C2=A0 =C2=A0__u64 csa_va;<br>
          +=C2=A0 =C2=A0 =C2=A0 =C2=A0__u64 gds_va;<br>
          +=C2=A0 =C2=A0 =C2=A0 =C2=A0__u64 flags;<br>
          +};<br>
          +<br>
          =C2=A0/*<br>
          =C2=A0 *=C2=A0 Query h/w info: Flag that this is integrated (a.h.=
a.
          fusion) GPU<br>
          =C2=A0 *<br>
          -- <br>
          2.39.2<br>
          <br>
        </blockquote>
      </div>
    </blockquote>
    <br>
  </div>

</blockquote></div>

--0000000000000a5e2305f8a7c016--
