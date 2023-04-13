Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E43D2C77B61
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Apr 2023 09:21:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 91B0510E28D;
	Thu, 13 Apr 2023 09:21:56 +0000 (UTC)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2DE0410E28D
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Apr 2023 09:21:55 +0000 (UTC)
Received: by mail-ej1-x62c.google.com with SMTP id f26so29660201ejb.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Apr 2023 02:21:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1681377713; x=1683969713;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=YWEhAdKcSLZm2Mnl9kUAGm2biGRf66BEyi8ZVc4dnxQ=;
 b=fwpjSynmIlQNWSgretXS39urbRL1JRAhywDsAX2bpaI2QGA48TV52Cbt38GxqkMj8D
 AfSVzaRseSGXX5UEjPk+0jqD6OzQFq5/YcxlBfEc0AvPEbEd/VlwXPXzSgjRVe7imNqp
 ckK9mNxlSKlBBu2czNBMMvlhvOAAw34zo6Oyvqwlfn9YiqVu2vAEPGynTerBCDEMT6/x
 MudI2j/zrOYIBltUZ1u0ZqOzpmCytyFTYIgDvHaAyCXlV2SaLkld6JdIB5+oW7au5AgN
 ZhHkNKVrvaw2Y24Nqjn0KO8wUn61y2SweurUGHk7x46MtOMtj7qfF4Z+TPh83C7OKXrW
 vscg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1681377713; x=1683969713;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YWEhAdKcSLZm2Mnl9kUAGm2biGRf66BEyi8ZVc4dnxQ=;
 b=fxTeow8yIiiXYHdVk3oBHjkzC2V6Gxp+MukWIMgy8VGGLSe0Zqz0zP0IjjEUWXa//f
 ECVZLWy4AOY6PeVydVs968NsV2v/Lf8R/aH+IAzQAW/SS70SMpdp0ZPtsWCYH91av4h3
 LHNFpfQgEVGmWh6jV3IPNrFaQddgiGxPwgqYz/6QQ9KjBFCTrbCdK4HYB/lqF1WXWyK1
 8oSRk/KGm4DTPIM780VaLbLIsU7uEF66tbQmvfa/N+7M8n73piUMBtlxpkU0IRK/3W1N
 nWOEg94npdBlzbtDnjGqFvKXw19OxeI86YN1JtJRYJ/vI/7XRoh72+SNOQ1KeDI8vdEE
 MCrA==
X-Gm-Message-State: AAQBX9eGQOq1mULqi/pszRIusUNM/HBoKiHJ2n0M+S/trfeOO0kyIKwB
 85lOx0iSVj6O9oMyx7GoOWBhs91/qSGujC9v3y0=
X-Google-Smtp-Source: AKy350ZIf6NF04xUmQZrVhNa+R771ZGB9XDZl20lNVuSQRkUptAm99apKRaPVtchokgb5GSX0YiaZWXA6fngokqzv68=
X-Received: by 2002:a17:906:78e:b0:8eb:27de:447e with SMTP id
 l14-20020a170906078e00b008eb27de447emr887406ejc.7.1681377713110; Thu, 13 Apr
 2023 02:21:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230330191750.1134210-1-alexander.deucher@amd.com>
 <20230330191750.1134210-4-alexander.deucher@amd.com>
 <CAAxE2A7nvmXdUaXESi4g6HVBFxk+dooz7tZYQfjGE8O2fKFi-w@mail.gmail.com>
 <8a98b160-5276-54f5-d166-e12a572892e9@amd.com>
 <CAAxE2A4LzFudfzTNRr290ORZvcF6-xzKiyNM6LZ3uiZDPerf5Q@mail.gmail.com>
 <b1485943-5f0a-1a7e-f0a4-b35771b48a23@gmail.com>
 <CAAxE2A6m346bTD7G=wMa=8OcRmk6OHui9N=Z9B5xHCS4VxxYwQ@mail.gmail.com>
 <2897fa79-f0ef-1ddb-dc38-05ef429fe0d9@gmail.com>
In-Reply-To: <2897fa79-f0ef-1ddb-dc38-05ef429fe0d9@gmail.com>
From: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>
Date: Thu, 13 Apr 2023 05:21:39 -0400
Message-ID: <CAAxE2A5mf8J_1JJvgPgx-G07zcc3vcHOD6jWUXL8Mhx3g-Zufw@mail.gmail.com>
Subject: Re: [PATCH 03/13] drm/amdgpu/UAPI: add new CS chunk for GFX shadow
 buffers
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
Content-Type: multipart/alternative; boundary="00000000000052c2ef05f93441b7"
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

--00000000000052c2ef05f93441b7
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

That's not why it was removed. It was removed because userspace doesn't use
GDS memory and gds_va is always going to be 0.

Firmware shouldn't use it because using it would increase preemption
latency.

Marek

On Sun, Apr 9, 2023, 11:21 Christian K=C3=B6nig <ckoenig.leichtzumerken@gma=
il.com>
wrote:

> We removed the GDS information because they were unnecessary. The GDS siz=
e
> was already part of the device info before we added the shadow info.
>
> But as far as I know the firmware needs valid VAs for all three buffers o=
r
> won't work correctly.
>
> Christian.
>
> Am 06.04.23 um 17:01 schrieb Marek Ol=C5=A1=C3=A1k:
>
> There is no GDS shadowing info in the device info uapi, so userspace can'=
t
> create any GDS buffer and thus can't have any GDS va. It's a uapi issue,
> not what firmware wants to do.
>
> Marek
>
> On Thu, Apr 6, 2023 at 6:31=E2=80=AFAM Christian K=C3=B6nig <
> ckoenig.leichtzumerken@gmail.com> wrote:
>
>> That's what I thought as well, but Mitch/Hans insisted on that.
>>
>> We should probably double check internally.
>>
>> Christian.
>>
>> Am 06.04.23 um 11:43 schrieb Marek Ol=C5=A1=C3=A1k:
>>
>> GDS memory isn't used on gfx11. Only GDS OA is used.
>>
>> Marek
>>
>> On Thu, Apr 6, 2023 at 5:09=E2=80=AFAM Christian K=C3=B6nig <christian.k=
oenig@amd.com>
>> wrote:
>>
>>> Why that?
>>>
>>> This is the save buffer for GDS, not the old style GDS BOs.
>>>
>>> Christian.
>>>
>>> Am 06.04.23 um 09:36 schrieb Marek Ol=C5=A1=C3=A1k:
>>>
>>> gds_va is unnecessary.
>>>
>>> Marek
>>>
>>> On Thu, Mar 30, 2023 at 3:18=E2=80=AFPM Alex Deucher <alexander.deucher=
@amd.com>
>>> wrote:
>>>
>>>> For GFX11, the UMD needs to allocate some shadow buffers
>>>> to be used for preemption.  The UMD allocates the buffers
>>>> and passes the GPU virtual address to the kernel since the
>>>> kernel will program the packet that specified these
>>>> addresses as part of its IB submission frame.
>>>>
>>>> v2: UMD passes shadow init to tell kernel when to initialize
>>>>     the shadow
>>>>
>>>> Reviewed-by: Christian K=C3=B6nig <christian.koenig@amd.com>
>>>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>>>> ---
>>>>  include/uapi/drm/amdgpu_drm.h | 10 ++++++++++
>>>>  1 file changed, 10 insertions(+)
>>>>
>>>> diff --git a/include/uapi/drm/amdgpu_drm.h
>>>> b/include/uapi/drm/amdgpu_drm.h
>>>> index b6eb90df5d05..3d9474af6566 100644
>>>> --- a/include/uapi/drm/amdgpu_drm.h
>>>> +++ b/include/uapi/drm/amdgpu_drm.h
>>>> @@ -592,6 +592,7 @@ struct drm_amdgpu_gem_va {
>>>>  #define AMDGPU_CHUNK_ID_SCHEDULED_DEPENDENCIES 0x07
>>>>  #define AMDGPU_CHUNK_ID_SYNCOBJ_TIMELINE_WAIT    0x08
>>>>  #define AMDGPU_CHUNK_ID_SYNCOBJ_TIMELINE_SIGNAL  0x09
>>>> +#define AMDGPU_CHUNK_ID_CP_GFX_SHADOW   0x0a
>>>>
>>>>  struct drm_amdgpu_cs_chunk {
>>>>         __u32           chunk_id;
>>>> @@ -708,6 +709,15 @@ struct drm_amdgpu_cs_chunk_data {
>>>>         };
>>>>  };
>>>>
>>>> +#define AMDGPU_CS_CHUNK_CP_GFX_SHADOW_FLAGS_INIT_SHADOW         0x1
>>>> +
>>>> +struct drm_amdgpu_cs_chunk_cp_gfx_shadow {
>>>> +       __u64 shadow_va;
>>>> +       __u64 csa_va;
>>>> +       __u64 gds_va;
>>>> +       __u64 flags;
>>>> +};
>>>> +
>>>>  /*
>>>>   *  Query h/w info: Flag that this is integrated (a.h.a. fusion) GPU
>>>>   *
>>>> --
>>>> 2.39.2
>>>>
>>>>
>>>
>>
>

--00000000000052c2ef05f93441b7
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div>That&#39;s not why it was removed. It was removed be=
cause userspace doesn&#39;t use GDS memory and gds_va is always going to be=
 0.</div><div dir=3D"auto"><br></div><div dir=3D"auto">Firmware shouldn&#39=
;t use it because using it would increase preemption latency.</div><div dir=
=3D"auto"><br></div><div dir=3D"auto">Marek<br><br><div class=3D"gmail_quot=
e" dir=3D"auto"><div dir=3D"ltr" class=3D"gmail_attr">On Sun, Apr 9, 2023, =
11:21 Christian K=C3=B6nig &lt;<a href=3D"mailto:ckoenig.leichtzumerken@gma=
il.com">ckoenig.leichtzumerken@gmail.com</a>&gt; wrote:<br></div><blockquot=
e class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc sol=
id;padding-left:1ex">
 =20
   =20
 =20
  <div>
    We removed the GDS information because they were unnecessary. The
    GDS size was already part of the device info before we added the
    shadow info.<br>
    <br>
    But as far as I know the firmware needs valid VAs for all three
    buffers or won&#39;t work correctly.<br>
    <br>
    Christian.<br>
    <br>
    <div>Am 06.04.23 um 17:01 schrieb Marek
      Ol=C5=A1=C3=A1k:<br>
    </div>
    <blockquote type=3D"cite">
     =20
      <div dir=3D"ltr">
        <div>There is no GDS shadowing info in the device info uapi, so
          userspace can&#39;t create any GDS buffer and thus can&#39;t have=
 any
          GDS va. It&#39;s a uapi issue, not what firmware wants to do.<br>
        </div>
        <div><br>
        </div>
        <div>Marek<br>
        </div>
      </div>
      <br>
      <div class=3D"gmail_quote">
        <div dir=3D"ltr" class=3D"gmail_attr">On Thu, Apr 6, 2023 at 6:31=
=E2=80=AFAM
          Christian K=C3=B6nig &lt;<a href=3D"mailto:ckoenig.leichtzumerken=
@gmail.com" target=3D"_blank" rel=3D"noreferrer">ckoenig.leichtzumerken@gma=
il.com</a>&gt;
          wrote:<br>
        </div>
        <blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex=
;border-left:1px solid rgb(204,204,204);padding-left:1ex">
          <div> That&#39;s what I thought as well, but Mitch/Hans insisted
            on that.<br>
            <br>
            We should probably double check internally.<br>
            <br>
            Christian.<br>
            <br>
            <div>Am 06.04.23 um 11:43 schrieb Marek Ol=C5=A1=C3=A1k:<br>
            </div>
            <blockquote type=3D"cite">
              <div dir=3D"ltr">
                <div>GDS memory isn&#39;t used on gfx11. Only GDS OA is
                  used.<br>
                </div>
                <div><br>
                </div>
                <div>Marek<br>
                </div>
              </div>
              <br>
              <div class=3D"gmail_quote">
                <div dir=3D"ltr" class=3D"gmail_attr">On Thu, Apr 6, 2023 a=
t
                  5:09=E2=80=AFAM Christian K=C3=B6nig &lt;<a href=3D"mailt=
o:christian.koenig@amd.com" target=3D"_blank" rel=3D"noreferrer">christian.=
koenig@amd.com</a>&gt;
                  wrote:<br>
                </div>
                <blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0=
px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
                  <div> Why that?<br>
                    <br>
                    This is the save buffer for GDS, not the old style
                    GDS BOs.<br>
                    <br>
                    Christian.<br>
                    <br>
                    <div>Am 06.04.23 um 09:36 schrieb Marek Ol=C5=A1=C3=A1k=
:<br>
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
                        <div dir=3D"ltr" class=3D"gmail_attr">On Thu, Mar
                          30, 2023 at 3:18=E2=80=AFPM Alex Deucher &lt;<a h=
ref=3D"mailto:alexander.deucher@amd.com" target=3D"_blank" rel=3D"noreferre=
r">alexander.deucher@amd.com</a>&gt;
                          wrote:<br>
                        </div>
                        <blockquote class=3D"gmail_quote" style=3D"margin:0=
px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">F=
or GFX11,
                          the UMD needs to allocate some shadow buffers<br>
                          to be used for preemption.=C2=A0 The UMD allocate=
s
                          the buffers<br>
                          and passes the GPU virtual address to the
                          kernel since the<br>
                          kernel will program the packet that specified
                          these<br>
                          addresses as part of its IB submission frame.<br>
                          <br>
                          v2: UMD passes shadow init to tell kernel when
                          to initialize<br>
                          =C2=A0 =C2=A0 the shadow<br>
                          <br>
                          Reviewed-by: Christian K=C3=B6nig &lt;<a href=3D"=
mailto:christian.koenig@amd.com" target=3D"_blank" rel=3D"noreferrer">chris=
tian.koenig@amd.com</a>&gt;<br>
                          Signed-off-by: Alex Deucher &lt;<a href=3D"mailto=
:alexander.deucher@amd.com" target=3D"_blank" rel=3D"noreferrer">alexander.=
deucher@amd.com</a>&gt;<br>
                          ---<br>
                          =C2=A0include/uapi/drm/amdgpu_drm.h | 10 ++++++++=
++<br>
                          =C2=A01 file changed, 10 insertions(+)<br>
                          <br>
                          diff --git a/include/uapi/drm/amdgpu_drm.h
                          b/include/uapi/drm/amdgpu_drm.h<br>
                          index b6eb90df5d05..3d9474af6566 100644<br>
                          --- a/include/uapi/drm/amdgpu_drm.h<br>
                          +++ b/include/uapi/drm/amdgpu_drm.h<br>
                          @@ -592,6 +592,7 @@ struct drm_amdgpu_gem_va {<br=
>
                          =C2=A0#define
                          AMDGPU_CHUNK_ID_SCHEDULED_DEPENDENCIES 0x07<br>
                          =C2=A0#define
                          AMDGPU_CHUNK_ID_SYNCOBJ_TIMELINE_WAIT=C2=A0 =C2=
=A0 0x08<br>
                          =C2=A0#define
                          AMDGPU_CHUNK_ID_SYNCOBJ_TIMELINE_SIGNAL=C2=A0 0x0=
9<br>
                          +#define AMDGPU_CHUNK_ID_CP_GFX_SHADOW=C2=A0 =C2=
=A00x0a<br>
                          <br>
                          =C2=A0struct drm_amdgpu_cs_chunk {<br>
                          =C2=A0 =C2=A0 =C2=A0 =C2=A0 __u32=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0chunk_id;<br>
                          @@ -708,6 +709,15 @@ struct
                          drm_amdgpu_cs_chunk_data {<br>
                          =C2=A0 =C2=A0 =C2=A0 =C2=A0 };<br>
                          =C2=A0};<br>
                          <br>
                          +#define
                          AMDGPU_CS_CHUNK_CP_GFX_SHADOW_FLAGS_INIT_SHADOW=
=C2=A0
                          =C2=A0 =C2=A0 =C2=A0 =C2=A00x1<br>
                          +<br>
                          +struct drm_amdgpu_cs_chunk_cp_gfx_shadow {<br>
                          +=C2=A0 =C2=A0 =C2=A0 =C2=A0__u64 shadow_va;<br>
                          +=C2=A0 =C2=A0 =C2=A0 =C2=A0__u64 csa_va;<br>
                          +=C2=A0 =C2=A0 =C2=A0 =C2=A0__u64 gds_va;<br>
                          +=C2=A0 =C2=A0 =C2=A0 =C2=A0__u64 flags;<br>
                          +};<br>
                          +<br>
                          =C2=A0/*<br>
                          =C2=A0 *=C2=A0 Query h/w info: Flag that this is
                          integrated (a.h.a. fusion) GPU<br>
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
        </blockquote>
      </div>
    </blockquote>
    <br>
  </div>

</blockquote></div></div></div>

--00000000000052c2ef05f93441b7--
