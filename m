Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 545D5C76196
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Apr 2023 15:02:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C2A1110EC0F;
	Thu,  6 Apr 2023 15:02:03 +0000 (UTC)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A3CBA10EC0F
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Apr 2023 15:02:02 +0000 (UTC)
Received: by mail-ej1-x62d.google.com with SMTP id l17so2109430ejp.8
 for <amd-gfx@lists.freedesktop.org>; Thu, 06 Apr 2023 08:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20210112; t=1680793321;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=la7I0bvWlXWzMPzf+qR8ovvZcnDZdOwFrrczktsG31o=;
 b=mRKj3NIjhcA+UwBv6DmYD7BdbRt/XyeCQ08zUW81BrD6gndVCnT7SqYNJkJrJCSHqz
 DCKRkMNA0FoXG7bkLa3ToQ/3t9xha/GZKX+KIwKMlYIQ68xxyKBqULwkmlz3AzkSFC/T
 iq1Qe8xAnWB1VPrTDrRHwRIcX5R3Ez3hKHPl4yA1aiGTcq8lxImACb6s3KW1W/HsHXFN
 6yA0EbUfWcC4zabFIw+N/W464JrX/8Cfvcjn951ltEFND2iGdzK8Bw/uc9HDKDYo9l7a
 alDDsrHnv/JmmGItgvpRjqldaSTVWWGYbynnNL6oxCVsbXO2gro9/OaOXrJD0j/fQlsv
 tPow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1680793321;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=la7I0bvWlXWzMPzf+qR8ovvZcnDZdOwFrrczktsG31o=;
 b=YZdfnBij8NByFXhsvqzlVxigvLWEEQsAFJxb592grIAg6aF2TgAMDvDF5JfmRJqQzH
 KbCM1KgxsRM7OPlPcYHDC4XFBXfow23mUqz5fB3dlB/z2FKLOdr5NSnY2DtBqiem6Dpa
 Y0d7NbDVW44EQ2dNlDQBW3PM8RzWBEJ+sEoTeoG8XvDSTe1+opDaQTi8siSIOnXY8h+u
 xcLvhtydJGTqQo6kJtyCoLGdRVtAEwPkvwzn4zslESnzgQ6GDN/XR4bd05fla1ntS72H
 y1OkAHLOvTzCXGwXL1Ujo5fHEPb7PudKAszqPPi3IZ7xcGhE4rl0+DY6p27wkb/Q7LXW
 iGEg==
X-Gm-Message-State: AAQBX9c3ITJVGbe4qufX0nfd3Bmo1XRj7HeiHv0LLitKhaxxVhmPQHJD
 J0gza2Ds5APRKWNMVYiTqO47rOb3iIQB5iPrBm4=
X-Google-Smtp-Source: AKy350Zd/Z5wPrgB+2bL5fS9ZZBDPQheQuYLl/abUuZGbqUPqmOovjnwr5qZonnxaOMLgEYwTvDZXOplTqBSAXKdoIk=
X-Received: by 2002:a17:906:2442:b0:934:b24e:26ba with SMTP id
 a2-20020a170906244200b00934b24e26bamr3250786ejb.7.1680793320861; Thu, 06 Apr
 2023 08:02:00 -0700 (PDT)
MIME-Version: 1.0
References: <20230330191750.1134210-1-alexander.deucher@amd.com>
 <20230330191750.1134210-4-alexander.deucher@amd.com>
 <CAAxE2A7nvmXdUaXESi4g6HVBFxk+dooz7tZYQfjGE8O2fKFi-w@mail.gmail.com>
 <8a98b160-5276-54f5-d166-e12a572892e9@amd.com>
 <CAAxE2A4LzFudfzTNRr290ORZvcF6-xzKiyNM6LZ3uiZDPerf5Q@mail.gmail.com>
 <b1485943-5f0a-1a7e-f0a4-b35771b48a23@gmail.com>
In-Reply-To: <b1485943-5f0a-1a7e-f0a4-b35771b48a23@gmail.com>
From: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>
Date: Thu, 6 Apr 2023 11:01:24 -0400
Message-ID: <CAAxE2A6m346bTD7G=wMa=8OcRmk6OHui9N=Z9B5xHCS4VxxYwQ@mail.gmail.com>
Subject: Re: [PATCH 03/13] drm/amdgpu/UAPI: add new CS chunk for GFX shadow
 buffers
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
Content-Type: multipart/alternative; boundary="000000000000d4b87005f8ac3082"
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
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--000000000000d4b87005f8ac3082
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

There is no GDS shadowing info in the device info uapi, so userspace can't
create any GDS buffer and thus can't have any GDS va. It's a uapi issue,
not what firmware wants to do.

Marek

On Thu, Apr 6, 2023 at 6:31=E2=80=AFAM Christian K=C3=B6nig <
ckoenig.leichtzumerken@gmail.com> wrote:

> That's what I thought as well, but Mitch/Hans insisted on that.
>
> We should probably double check internally.
>
> Christian.
>
> Am 06.04.23 um 11:43 schrieb Marek Ol=C5=A1=C3=A1k:
>
> GDS memory isn't used on gfx11. Only GDS OA is used.
>
> Marek
>
> On Thu, Apr 6, 2023 at 5:09=E2=80=AFAM Christian K=C3=B6nig <christian.ko=
enig@amd.com>
> wrote:
>
>> Why that?
>>
>> This is the save buffer for GDS, not the old style GDS BOs.
>>
>> Christian.
>>
>> Am 06.04.23 um 09:36 schrieb Marek Ol=C5=A1=C3=A1k:
>>
>> gds_va is unnecessary.
>>
>> Marek
>>
>> On Thu, Mar 30, 2023 at 3:18=E2=80=AFPM Alex Deucher <alexander.deucher@=
amd.com>
>> wrote:
>>
>>> For GFX11, the UMD needs to allocate some shadow buffers
>>> to be used for preemption.  The UMD allocates the buffers
>>> and passes the GPU virtual address to the kernel since the
>>> kernel will program the packet that specified these
>>> addresses as part of its IB submission frame.
>>>
>>> v2: UMD passes shadow init to tell kernel when to initialize
>>>     the shadow
>>>
>>> Reviewed-by: Christian K=C3=B6nig <christian.koenig@amd.com>
>>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>>> ---
>>>  include/uapi/drm/amdgpu_drm.h | 10 ++++++++++
>>>  1 file changed, 10 insertions(+)
>>>
>>> diff --git a/include/uapi/drm/amdgpu_drm.h
>>> b/include/uapi/drm/amdgpu_drm.h
>>> index b6eb90df5d05..3d9474af6566 100644
>>> --- a/include/uapi/drm/amdgpu_drm.h
>>> +++ b/include/uapi/drm/amdgpu_drm.h
>>> @@ -592,6 +592,7 @@ struct drm_amdgpu_gem_va {
>>>  #define AMDGPU_CHUNK_ID_SCHEDULED_DEPENDENCIES 0x07
>>>  #define AMDGPU_CHUNK_ID_SYNCOBJ_TIMELINE_WAIT    0x08
>>>  #define AMDGPU_CHUNK_ID_SYNCOBJ_TIMELINE_SIGNAL  0x09
>>> +#define AMDGPU_CHUNK_ID_CP_GFX_SHADOW   0x0a
>>>
>>>  struct drm_amdgpu_cs_chunk {
>>>         __u32           chunk_id;
>>> @@ -708,6 +709,15 @@ struct drm_amdgpu_cs_chunk_data {
>>>         };
>>>  };
>>>
>>> +#define AMDGPU_CS_CHUNK_CP_GFX_SHADOW_FLAGS_INIT_SHADOW         0x1
>>> +
>>> +struct drm_amdgpu_cs_chunk_cp_gfx_shadow {
>>> +       __u64 shadow_va;
>>> +       __u64 csa_va;
>>> +       __u64 gds_va;
>>> +       __u64 flags;
>>> +};
>>> +
>>>  /*
>>>   *  Query h/w info: Flag that this is integrated (a.h.a. fusion) GPU
>>>   *
>>> --
>>> 2.39.2
>>>
>>>
>>
>

--000000000000d4b87005f8ac3082
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>There is no GDS shadowing info in the device info uap=
i, so userspace can&#39;t create any GDS buffer and thus can&#39;t have any=
 GDS va. It&#39;s a uapi issue, not what firmware wants to do.<br></div><di=
v><br></div><div>Marek<br></div></div><br><div class=3D"gmail_quote"><div d=
ir=3D"ltr" class=3D"gmail_attr">On Thu, Apr 6, 2023 at 6:31=E2=80=AFAM Chri=
stian K=C3=B6nig &lt;<a href=3D"mailto:ckoenig.leichtzumerken@gmail.com" ta=
rget=3D"_blank">ckoenig.leichtzumerken@gmail.com</a>&gt; wrote:<br></div><b=
lockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-le=
ft:1px solid rgb(204,204,204);padding-left:1ex">
 =20
   =20
 =20
  <div>
    That&#39;s what I thought as well, but Mitch/Hans insisted on that.<br>
    <br>
    We should probably double check internally.<br>
    <br>
    Christian.<br>
    <br>
    <div>Am 06.04.23 um 11:43 schrieb Marek
      Ol=C5=A1=C3=A1k:<br>
    </div>
    <blockquote type=3D"cite">
     =20
      <div dir=3D"ltr">
        <div>GDS memory isn&#39;t used on gfx11. Only GDS OA is used.<br>
        </div>
        <div><br>
        </div>
        <div>Marek<br>
        </div>
      </div>
      <br>
      <div class=3D"gmail_quote">
        <div dir=3D"ltr" class=3D"gmail_attr">On Thu, Apr 6, 2023 at 5:09=
=E2=80=AFAM
          Christian K=C3=B6nig &lt;<a href=3D"mailto:christian.koenig@amd.c=
om" target=3D"_blank">christian.koenig@amd.com</a>&gt;
          wrote:<br>
        </div>
        <blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex=
;border-left:1px solid rgb(204,204,204);padding-left:1ex">
          <div> Why that?<br>
            <br>
            This is the save buffer for GDS, not the old style GDS BOs.<br>
            <br>
            Christian.<br>
            <br>
            <div>Am 06.04.23 um 09:36 schrieb Marek Ol=C5=A1=C3=A1k:<br>
            </div>
            <blockquote type=3D"cite">
              <div dir=3D"ltr">
                <div>gds_va is unnecessary.</div>
                <div><br>
                </div>
                <div>Marek<br>
                </div>
              </div>
              <br>
              <div class=3D"gmail_quote">
                <div dir=3D"ltr" class=3D"gmail_attr">On Thu, Mar 30, 2023
                  at 3:18=E2=80=AFPM Alex Deucher &lt;<a href=3D"mailto:ale=
xander.deucher@amd.com" target=3D"_blank">alexander.deucher@amd.com</a>&gt;
                  wrote:<br>
                </div>
                <blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0=
px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">For GFX11=
, the UMD
                  needs to allocate some shadow buffers<br>
                  to be used for preemption.=C2=A0 The UMD allocates the
                  buffers<br>
                  and passes the GPU virtual address to the kernel since
                  the<br>
                  kernel will program the packet that specified these<br>
                  addresses as part of its IB submission frame.<br>
                  <br>
                  v2: UMD passes shadow init to tell kernel when to
                  initialize<br>
                  =C2=A0 =C2=A0 the shadow<br>
                  <br>
                  Reviewed-by: Christian K=C3=B6nig &lt;<a href=3D"mailto:c=
hristian.koenig@amd.com" target=3D"_blank">christian.koenig@amd.com</a>&gt;=
<br>
                  Signed-off-by: Alex Deucher &lt;<a href=3D"mailto:alexand=
er.deucher@amd.com" target=3D"_blank">alexander.deucher@amd.com</a>&gt;<br>
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
                  =C2=A0#define AMDGPU_CHUNK_ID_SCHEDULED_DEPENDENCIES 0x07=
<br>
                  =C2=A0#define AMDGPU_CHUNK_ID_SYNCOBJ_TIMELINE_WAIT=C2=A0=
 =C2=A0 0x08<br>
                  =C2=A0#define AMDGPU_CHUNK_ID_SYNCOBJ_TIMELINE_SIGNAL=C2=
=A0 0x09<br>
                  +#define AMDGPU_CHUNK_ID_CP_GFX_SHADOW=C2=A0 =C2=A00x0a<b=
r>
                  <br>
                  =C2=A0struct drm_amdgpu_cs_chunk {<br>
                  =C2=A0 =C2=A0 =C2=A0 =C2=A0 __u32=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0chunk_id;<br>
                  @@ -708,6 +709,15 @@ struct drm_amdgpu_cs_chunk_data {<br=
>
                  =C2=A0 =C2=A0 =C2=A0 =C2=A0 };<br>
                  =C2=A0};<br>
                  <br>
                  +#define
                  AMDGPU_CS_CHUNK_CP_GFX_SHADOW_FLAGS_INIT_SHADOW=C2=A0 =C2=
=A0 =C2=A0 =C2=A0
                  =C2=A00x1<br>
                  +<br>
                  +struct drm_amdgpu_cs_chunk_cp_gfx_shadow {<br>
                  +=C2=A0 =C2=A0 =C2=A0 =C2=A0__u64 shadow_va;<br>
                  +=C2=A0 =C2=A0 =C2=A0 =C2=A0__u64 csa_va;<br>
                  +=C2=A0 =C2=A0 =C2=A0 =C2=A0__u64 gds_va;<br>
                  +=C2=A0 =C2=A0 =C2=A0 =C2=A0__u64 flags;<br>
                  +};<br>
                  +<br>
                  =C2=A0/*<br>
                  =C2=A0 *=C2=A0 Query h/w info: Flag that this is integrat=
ed
                  (a.h.a. fusion) GPU<br>
                  =C2=A0 *<br>
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

</blockquote></div>

--000000000000d4b87005f8ac3082--
