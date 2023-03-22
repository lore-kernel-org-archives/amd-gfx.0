Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94773C6FD1C
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Mar 2023 14:37:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 15CD310E97A;
	Wed, 22 Mar 2023 14:37:23 +0000 (UTC)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2D41E10E97A
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Mar 2023 14:37:20 +0000 (UTC)
Received: by mail-ed1-x534.google.com with SMTP id ew6so10887720edb.7
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Mar 2023 07:37:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20210112; t=1679495838;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=yabySQibADqo4vJVgx4fCXX8NyNMLxI9isvKAhuvxCM=;
 b=KvrEgOsIYWSyIL+nPM+1GAgXA8q3F5Wpb5VhQR/8kHeSwYXfZlqM4t/CBTi3fPZu+0
 Y3Ck3WrSz9aYjh6o/aRxE979FmEz9E4UzbqrxuW2OdWxzIo4lqTR1FrcIjyOn8aSE7q3
 aDVz5c8IM5sPvnAjsYn/iOFUPLtW2Ch2p+L/YcKh45XsjQ7ffIsyVkgy22lb9uuVfRc+
 W5Og4+Sw5/dq5c4FDCsAJ6yJMe7/IofhrfrlHp59nzTbuFARWYBD5T1qjZSwHip0lJ/w
 T2e8Fo8t2/SfOCABoG3bdNm1RoqRzPVFge/zyKtm4Hqyv8msCyUIDXA1c5MSLOdjUrAq
 2+ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1679495838;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yabySQibADqo4vJVgx4fCXX8NyNMLxI9isvKAhuvxCM=;
 b=GJ9HEKjL0g4EdctnWOS02BT2a9Zdp93eSOFg+YbGuCfQEjPtfNttz+aaWznL0a82So
 OE4wROvogzUIi+M9XRxgQeZNe9bgVpbDwf5f/yaxqOJsttzHiu3fGpLimrzsXb3SKbEt
 pw9RKmNeoZu6EhB2Fmjvy447vodIGCP5lzT9hrHo8x5CsqQrWw7tuHj+O8oJBfbcXk7K
 dkdq2ySuATYA1FmP4o9dJSTczFY9bk5fABdfliUQ1MPQiydfY4lO/ygX1jShaj6XF9o5
 f9A2zMsLKKPVgRuBD4AxdjgHybprDrTUPXNdrCZOjA4/P1NUnBjKgoY2zPP/++iv4dx4
 q/iw==
X-Gm-Message-State: AO0yUKVMsSRK/TWAy52ZIIw0RfLyhjNBw9HhCSLipwvLBppAFLk5bCSw
 9kQ8cPfBy/nNyeG/mut4TLmhw5DaCpIKKsf+WioYMo/Y
X-Google-Smtp-Source: AK7set8pu7A3t8UFJR8IqVeYZsTFit/dUjFoBXd1lGwPCUhRIs/ktuZBhGMR8v1+sZzyFpl6BCRj4pCvBskL8Ctlalo=
X-Received: by 2002:a50:d597:0:b0:4fb:e0e8:5140 with SMTP id
 v23-20020a50d597000000b004fbe0e85140mr3650539edi.6.1679495838574; Wed, 22 Mar
 2023 07:37:18 -0700 (PDT)
MIME-Version: 1.0
References: <20220926214014.5450-1-shashank.sharma@amd.com>
 <20220926214014.5450-2-shashank.sharma@amd.com>
 <CAAxE2A67NMxra-a9ZYbY8e8S4fjfdXgB1cpjYZsSS8DcUu=LbA@mail.gmail.com>
 <MW4PR12MB56678ED37B6E498D3405F875F2819@MW4PR12MB5667.namprd12.prod.outlook.com>
 <0e904e40-ee6f-dea2-b2de-3e408a72908e@gmail.com>
 <CAAxE2A66ZF==rvDd8KFrfz79rXBB52vnWU7zsM+rfH69OV0Psw@mail.gmail.com>
 <ac80456d-ac57-dbf4-dca0-7f92a40bb603@amd.com>
 <CAAxE2A60VNbjKS3LpKjX=Y9gPD92gw4hBJpQApmcQKCu0UM4UQ@mail.gmail.com>
 <ea9ce74c-664c-47de-c750-bd4f3893ac72@amd.com>
In-Reply-To: <ea9ce74c-664c-47de-c750-bd4f3893ac72@amd.com>
From: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>
Date: Wed, 22 Mar 2023 10:36:42 -0400
Message-ID: <CAAxE2A7qaVseu8zJRe=2T0QobsT_SErrLS+s0D50CJPkCiVedQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/5] drm/amdgpu: add UAPI for workload hints to ctx
 ioctl
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: multipart/alternative; boundary="000000000000dc2ba105f77e1811"
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 "Somalapuram, Amaranath" <Amaranath.Somalapuram@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Sharma,
 Shashank" <Shashank.Sharma@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--000000000000dc2ba105f77e1811
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

It sounds like the kernel should set the hint based on which queues are
used, so that every UMD doesn't have to duplicate the same logic.

Marek

On Wed, Mar 22, 2023 at 10:29=E2=80=AFAM Christian K=C3=B6nig <christian.ko=
enig@amd.com>
wrote:

> Well that sounds like being able to optionally set it after context
> creation is actually the right approach.
>
> VA-API could set it as soon as we know that this is a video codec
> application.
>
> Vulkan can set it depending on what features are used by the application.
>
> But yes, Shashank (or whoever requested that) should come up with some
> code for Mesa to actually use it. Otherwise we don't have the justificati=
on
> to push it into the kernel driver.
>
> Christian.
>
> Am 22.03.23 um 15:24 schrieb Marek Ol=C5=A1=C3=A1k:
>
> The hint is static per API (one of graphics, video, compute, unknown). In
> the case of Vulkan, which exposes all queues, the hint is unknown, so
> Vulkan won't use it. (or make it based on the queue being used and not th=
e
> uapi context state) GL won't use it because the default hint is already 3=
D.
> That makes VAAPI the only user that only sets the hint once, and maybe it=
's
> not worth even adding this uapi just for VAAPI.
>
> Marek
>
> On Wed, Mar 22, 2023 at 10:08=E2=80=AFAM Christian K=C3=B6nig <christian.=
koenig@amd.com>
> wrote:
>
>> Well completely agree that we shouldn't have unused API. That's why I
>> said we should remove the getting the hint from the UAPI.
>>
>> But what's wrong with setting it after creating the context? Don't you
>> know enough about the use case? I need to understand the background a bi=
t
>> better here.
>>
>> Christian.
>>
>> Am 22.03.23 um 15:05 schrieb Marek Ol=C5=A1=C3=A1k:
>>
>> The option to change the hint after context creation and get the hint
>> would be unused uapi, and AFAIK we are not supposed to add unused uapi.
>> What I asked is to change it to a uapi that userspace will actually use.
>>
>> Marek
>>
>> On Tue, Mar 21, 2023 at 9:54=E2=80=AFAM Christian K=C3=B6nig <
>> ckoenig.leichtzumerken@gmail.com> wrote:
>>
>>> Yes, I would like to avoid having multiple code paths for context
>>> creation.
>>>
>>> Setting it later on should be equally to specifying it on creation sinc=
e
>>> we only need it during CS.
>>>
>>> Regards,
>>> Christian.
>>>
>>> Am 21.03.23 um 14:00 schrieb Sharma, Shashank:
>>>
>>> [AMD Official Use Only - General]
>>>
>>>
>>>
>>> When we started this patch series, the workload hint was a part of the
>>> ctx_flag only,
>>>
>>> But we changed that after the design review, to make it more like how w=
e
>>> are handling PSTATE.
>>>
>>>
>>>
>>> Details:
>>>
>>> https://patchwork.freedesktop.org/patch/496111/
>>>
>>>
>>>
>>> Regards
>>>
>>> Shashank
>>>
>>>
>>>
>>> *From:* Marek Ol=C5=A1=C3=A1k <maraeo@gmail.com> <maraeo@gmail.com>
>>> *Sent:* 21 March 2023 04:05
>>> *To:* Sharma, Shashank <Shashank.Sharma@amd.com>
>>> <Shashank.Sharma@amd.com>
>>> *Cc:* amd-gfx@lists.freedesktop.org; Deucher, Alexander
>>> <Alexander.Deucher@amd.com> <Alexander.Deucher@amd.com>; Somalapuram,
>>> Amaranath <Amaranath.Somalapuram@amd.com>
>>> <Amaranath.Somalapuram@amd.com>; Koenig, Christian
>>> <Christian.Koenig@amd.com> <Christian.Koenig@amd.com>
>>> *Subject:* Re: [PATCH v3 1/5] drm/amdgpu: add UAPI for workload hints
>>> to ctx ioctl
>>>
>>>
>>>
>>> I think we should do it differently because this interface will be
>>> mostly unused by open source userspace in its current form.
>>>
>>>
>>>
>>> Let's set the workload hint in drm_amdgpu_ctx_in::flags, and that will
>>> be immutable for the lifetime of the context. No other interface is nee=
ded.
>>>
>>>
>>>
>>> Marek
>>>
>>>
>>>
>>> On Mon, Sep 26, 2022 at 5:41=E2=80=AFPM Shashank Sharma <shashank.sharm=
a@amd.com>
>>> wrote:
>>>
>>> Allow the user to specify a workload hint to the kernel.
>>> We can use these to tweak the dpm heuristics to better match
>>> the workload for improved performance.
>>>
>>> V3: Create only set() workload UAPI (Christian)
>>>
>>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>>> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
>>> ---
>>>  include/uapi/drm/amdgpu_drm.h | 17 +++++++++++++++++
>>>  1 file changed, 17 insertions(+)
>>>
>>> diff --git a/include/uapi/drm/amdgpu_drm.h
>>> b/include/uapi/drm/amdgpu_drm.h
>>> index c2c9c674a223..23d354242699 100644
>>> --- a/include/uapi/drm/amdgpu_drm.h
>>> +++ b/include/uapi/drm/amdgpu_drm.h
>>> @@ -212,6 +212,7 @@ union drm_amdgpu_bo_list {
>>>  #define AMDGPU_CTX_OP_QUERY_STATE2     4
>>>  #define AMDGPU_CTX_OP_GET_STABLE_PSTATE        5
>>>  #define AMDGPU_CTX_OP_SET_STABLE_PSTATE        6
>>> +#define AMDGPU_CTX_OP_SET_WORKLOAD_PROFILE     7
>>>
>>>  /* GPU reset status */
>>>  #define AMDGPU_CTX_NO_RESET            0
>>> @@ -252,6 +253,17 @@ union drm_amdgpu_bo_list {
>>>  #define AMDGPU_CTX_STABLE_PSTATE_MIN_MCLK  3
>>>  #define AMDGPU_CTX_STABLE_PSTATE_PEAK  4
>>>
>>> +/* GPU workload hints, flag bits 8-15 */
>>> +#define AMDGPU_CTX_WORKLOAD_HINT_SHIFT     8
>>> +#define AMDGPU_CTX_WORKLOAD_HINT_MASK      (0xff <<
>>> AMDGPU_CTX_WORKLOAD_HINT_SHIFT)
>>> +#define AMDGPU_CTX_WORKLOAD_HINT_NONE      (0 <<
>>> AMDGPU_CTX_WORKLOAD_HINT_SHIFT)
>>> +#define AMDGPU_CTX_WORKLOAD_HINT_3D        (1 <<
>>> AMDGPU_CTX_WORKLOAD_HINT_SHIFT)
>>> +#define AMDGPU_CTX_WORKLOAD_HINT_VIDEO     (2 <<
>>> AMDGPU_CTX_WORKLOAD_HINT_SHIFT)
>>> +#define AMDGPU_CTX_WORKLOAD_HINT_VR        (3 <<
>>> AMDGPU_CTX_WORKLOAD_HINT_SHIFT)
>>> +#define AMDGPU_CTX_WORKLOAD_HINT_COMPUTE   (4 <<
>>> AMDGPU_CTX_WORKLOAD_HINT_SHIFT)
>>> +#define AMDGPU_CTX_WORKLOAD_HINT_MAX
>>> AMDGPU_CTX_WORKLOAD_HINT_COMPUTE
>>> +#define AMDGPU_CTX_WORKLOAD_INDEX(n)      (n >>
>>> AMDGPU_CTX_WORKLOAD_HINT_SHIFT)
>>> +
>>>  struct drm_amdgpu_ctx_in {
>>>         /** AMDGPU_CTX_OP_* */
>>>         __u32   op;
>>> @@ -281,6 +293,11 @@ union drm_amdgpu_ctx_out {
>>>                         __u32   flags;
>>>                         __u32   _pad;
>>>                 } pstate;
>>> +
>>> +               struct {
>>> +                       __u32   flags;
>>> +                       __u32   _pad;
>>> +               } workload;
>>>  };
>>>
>>>  union drm_amdgpu_ctx {
>>> --
>>> 2.34.1
>>>
>>>
>>>
>>
>

--000000000000dc2ba105f77e1811
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>It sounds like the kernel should set the hint based o=
n which queues are used, so that every UMD doesn&#39;t have to duplicate th=
e same logic.<br></div><div><br></div><div>Marek</div><div><br></div><div c=
lass=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Mar 22, =
2023 at 10:29=E2=80=AFAM Christian K=C3=B6nig &lt;<a href=3D"mailto:christi=
an.koenig@amd.com" target=3D"_blank">christian.koenig@amd.com</a>&gt; wrote=
:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.=
8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">

 =20
  <div>
    Well that sounds like being able to optionally set it after context
    creation is actually the right approach.<br>
    <br>
    VA-API could set it as soon as we know that this is a video codec
    application.<br>
    <br>
    Vulkan can set it depending on what features are used by the
    application.<br>
    <br>
    But yes, Shashank (or whoever requested that) should come up with
    some code for Mesa to actually use it. Otherwise we don&#39;t have the
    justification to push it into the kernel driver.<br>
    <br>
    Christian.<br>
    <br>
    <div>Am 22.03.23 um 15:24 schrieb Marek
      Ol=C5=A1=C3=A1k:<br>
    </div>
    <blockquote type=3D"cite">
     =20
      <div dir=3D"ltr">
        <div>The hint is static per API (one of graphics, video,
          compute, unknown). In the case of Vulkan, which exposes all
          queues, the hint is unknown, so Vulkan won&#39;t use it. (or make
          it based on the queue being used and not the uapi context
          state) GL won&#39;t use it because the default hint is already 3D=
.
          That makes VAAPI the only user that only sets the hint once,
          and maybe it&#39;s not worth even adding this uapi just for VAAPI=
.<br>
        </div>
        <div><br>
        </div>
        <div>Marek<br>
        </div>
        <br>
        <div class=3D"gmail_quote">
          <div dir=3D"ltr" class=3D"gmail_attr">On Wed, Mar 22, 2023 at
            10:08=E2=80=AFAM Christian K=C3=B6nig &lt;<a href=3D"mailto:chr=
istian.koenig@amd.com" target=3D"_blank">christian.koenig@amd.com</a>&gt;
            wrote:<br>
          </div>
          <blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8=
ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
            <div> Well completely agree that we shouldn&#39;t have unused
              API. That&#39;s why I said we should remove the getting the
              hint from the UAPI.<br>
              <br>
              But what&#39;s wrong with setting it after creating the
              context? Don&#39;t you know enough about the use case? I need
              to understand the background a bit better here.<br>
              <br>
              Christian.<br>
              <br>
              <div>Am 22.03.23 um 15:05 schrieb Marek Ol=C5=A1=C3=A1k:<br>
              </div>
              <blockquote type=3D"cite">
                <div dir=3D"ltr">
                  <div>The option to change the hint after context
                    creation and get the hint would be unused uapi, and
                    AFAIK we are not supposed to add unused uapi. What I
                    asked is to change it to a uapi that userspace will
                    actually use.<br>
                  </div>
                  <div><br>
                  </div>
                  <div>Marek<br>
                  </div>
                </div>
                <br>
                <div class=3D"gmail_quote">
                  <div dir=3D"ltr" class=3D"gmail_attr">On Tue, Mar 21, 202=
3
                    at 9:54=E2=80=AFAM Christian K=C3=B6nig &lt;<a href=3D"=
mailto:ckoenig.leichtzumerken@gmail.com" target=3D"_blank">ckoenig.leichtzu=
merken@gmail.com</a>&gt;
                    wrote:<br>
                  </div>
                  <blockquote class=3D"gmail_quote" style=3D"margin:0px 0px=
 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
                    <div> Yes, I would like to avoid having multiple
                      code paths for context creation.<br>
                      <br>
                      Setting it later on should be equally to
                      specifying it on creation since we only need it
                      during CS.<br>
                      <br>
                      Regards,<br>
                      Christian.<br>
                      <br>
                      <div>Am 21.03.23 um 14:00 schrieb Sharma,
                        Shashank:<br>
                      </div>
                      <blockquote type=3D"cite">
                        <div>
                          <p style=3D"margin:0cm"><span style=3D"font-size:=
10pt;font-family:&quot;Arial&quot;,sans-serif;color:blue">[AMD
                              Official Use Only - General]</span></p>
                          <p class=3D"MsoNormal">=C2=A0</p>
                          <p class=3D"MsoNormal"><span>When we started
                              this patch series, the workload hint was a
                              part of the ctx_flag only, </span></p>
                          <p class=3D"MsoNormal"><span>But we changed that
                              after the design review, to make it more
                              like how we are handling PSTATE. </span></p>
                          <p class=3D"MsoNormal"><span>=C2=A0</span></p>
                          <p class=3D"MsoNormal"><span>Details: </span></p>
                          <p class=3D"MsoNormal"><span><a href=3D"https://p=
atchwork.freedesktop.org/patch/496111/" target=3D"_blank">https://patchwork=
.freedesktop.org/patch/496111/</a>
                            </span></p>
                          <p class=3D"MsoNormal"><span>=C2=A0</span></p>
                          <p class=3D"MsoNormal"><span>Regards</span></p>
                          <p class=3D"MsoNormal"><span>Shashank </span></p>
                          <p class=3D"MsoNormal"><span>=C2=A0</span></p>
                          <div style=3D"border-color:rgb(225,225,225) curre=
ntcolor currentcolor;border-style:solid none none;border-width:1pt medium m=
edium;padding:3pt 0cm 0cm">
                            <p class=3D"MsoNormal"><b><span lang=3D"EN-US">=
From:</span></b><span lang=3D"EN-US"> Marek Ol=C5=A1=C3=A1k <a href=3D"mail=
to:maraeo@gmail.com" target=3D"_blank">&lt;maraeo@gmail.com&gt;</a>
                                <br>
                                <b>Sent:</b> 21 March 2023 04:05<br>
                                <b>To:</b> Sharma, Shashank <a href=3D"mail=
to:Shashank.Sharma@amd.com" target=3D"_blank">&lt;Shashank.Sharma@amd.com&g=
t;</a><br>
                                <b>Cc:</b> <a href=3D"mailto:amd-gfx@lists.=
freedesktop.org" target=3D"_blank">amd-gfx@lists.freedesktop.org</a>;
                                Deucher, Alexander <a href=3D"mailto:Alexan=
der.Deucher@amd.com" target=3D"_blank">&lt;Alexander.Deucher@amd.com&gt;</a=
>;
                                Somalapuram, Amaranath <a href=3D"mailto:Am=
aranath.Somalapuram@amd.com" target=3D"_blank">&lt;Amaranath.Somalapuram@am=
d.com&gt;</a>;
                                Koenig, Christian <a href=3D"mailto:Christi=
an.Koenig@amd.com" target=3D"_blank">&lt;Christian.Koenig@amd.com&gt;</a><b=
r>
                                <b>Subject:</b> Re: [PATCH v3 1/5]
                                drm/amdgpu: add UAPI for workload hints
                                to ctx ioctl</span></p>
                          </div>
                          <p class=3D"MsoNormal">=C2=A0</p>
                          <div>
                            <div>
                              <p class=3D"MsoNormal">I think we should do
                                it differently because this interface
                                will be mostly unused by open source
                                userspace in its current form.</p>
                            </div>
                            <div>
                              <p class=3D"MsoNormal">=C2=A0</p>
                            </div>
                            <div>
                              <p class=3D"MsoNormal">Let&#39;s set the
                                workload hint in
                                drm_amdgpu_ctx_in::flags, and that will
                                be immutable for the lifetime of the
                                context. No other interface is needed.</p>
                            </div>
                            <div>
                              <p class=3D"MsoNormal">=C2=A0</p>
                            </div>
                            <div>
                              <p class=3D"MsoNormal">Marek</p>
                            </div>
                          </div>
                          <p class=3D"MsoNormal">=C2=A0</p>
                          <div>
                            <div>
                              <p class=3D"MsoNormal">On Mon, Sep 26, 2022
                                at 5:41=E2=80=AFPM Shashank Sharma &lt;<a h=
ref=3D"mailto:shashank.sharma@amd.com" target=3D"_blank">shashank.sharma@am=
d.com</a>&gt;
                                wrote:</p>
                            </div>
                            <blockquote style=3D"border-color:currentcolor =
currentcolor currentcolor rgb(204,204,204);border-style:none none none soli=
d;border-width:medium medium medium 1pt;padding:0cm 0cm 0cm 6pt;margin:5pt =
0cm 5pt 4.8pt">
                              <p class=3D"MsoNormal" style=3D"margin-bottom=
:12pt">Allow the
                                user to specify a workload hint to the
                                kernel.<br>
                                We can use these to tweak the dpm
                                heuristics to better match<br>
                                the workload for improved performance.<br>
                                <br>
                                V3: Create only set() workload UAPI
                                (Christian)<br>
                                <br>
                                Signed-off-by: Alex Deucher &lt;<a href=3D"=
mailto:alexander.deucher@amd.com" target=3D"_blank">alexander.deucher@amd.c=
om</a>&gt;<br>
                                Signed-off-by: Shashank Sharma &lt;<a href=
=3D"mailto:shashank.sharma@amd.com" target=3D"_blank">shashank.sharma@amd.c=
om</a>&gt;<br>
                                ---<br>
                                =C2=A0include/uapi/drm/amdgpu_drm.h | 17
                                +++++++++++++++++<br>
                                =C2=A01 file changed, 17 insertions(+)<br>
                                <br>
                                diff --git
                                a/include/uapi/drm/amdgpu_drm.h
                                b/include/uapi/drm/amdgpu_drm.h<br>
                                index c2c9c674a223..23d354242699 100644<br>
                                --- a/include/uapi/drm/amdgpu_drm.h<br>
                                +++ b/include/uapi/drm/amdgpu_drm.h<br>
                                @@ -212,6 +212,7 @@ union
                                drm_amdgpu_bo_list {<br>
                                =C2=A0#define AMDGPU_CTX_OP_QUERY_STATE2=C2=
=A0 =C2=A0
                                =C2=A04<br>
                                =C2=A0#define
                                AMDGPU_CTX_OP_GET_STABLE_PSTATE=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 5<br>
                                =C2=A0#define
                                AMDGPU_CTX_OP_SET_STABLE_PSTATE=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 6<br>
                                +#define
                                AMDGPU_CTX_OP_SET_WORKLOAD_PROFILE=C2=A0 =
=C2=A0 =C2=A07<br>
                                <br>
                                =C2=A0/* GPU reset status */<br>
                                =C2=A0#define AMDGPU_CTX_NO_RESET=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0
                                0<br>
                                @@ -252,6 +253,17 @@ union
                                drm_amdgpu_bo_list {<br>
                                =C2=A0#define
                                AMDGPU_CTX_STABLE_PSTATE_MIN_MCLK=C2=A0 3<b=
r>
                                =C2=A0#define AMDGPU_CTX_STABLE_PSTATE_PEAK=
=C2=A0
                                4<br>
                                <br>
                                +/* GPU workload hints, flag bits 8-15
                                */<br>
                                +#define AMDGPU_CTX_WORKLOAD_HINT_SHIFT=C2=
=A0
                                =C2=A0 =C2=A08<br>
                                +#define AMDGPU_CTX_WORKLOAD_HINT_MASK=C2=
=A0
                                =C2=A0 =C2=A0 (0xff &lt;&lt;
                                AMDGPU_CTX_WORKLOAD_HINT_SHIFT)<br>
                                +#define AMDGPU_CTX_WORKLOAD_HINT_NONE=C2=
=A0
                                =C2=A0 =C2=A0 (0 &lt;&lt;
                                AMDGPU_CTX_WORKLOAD_HINT_SHIFT)<br>
                                +#define AMDGPU_CTX_WORKLOAD_HINT_3D=C2=A0 =
=C2=A0
                                =C2=A0 =C2=A0 (1 &lt;&lt;
                                AMDGPU_CTX_WORKLOAD_HINT_SHIFT)<br>
                                +#define AMDGPU_CTX_WORKLOAD_HINT_VIDEO=C2=
=A0
                                =C2=A0 =C2=A0(2 &lt;&lt;
                                AMDGPU_CTX_WORKLOAD_HINT_SHIFT)<br>
                                +#define AMDGPU_CTX_WORKLOAD_HINT_VR=C2=A0 =
=C2=A0
                                =C2=A0 =C2=A0 (3 &lt;&lt;
                                AMDGPU_CTX_WORKLOAD_HINT_SHIFT)<br>
                                +#define
                                AMDGPU_CTX_WORKLOAD_HINT_COMPUTE=C2=A0 =C2=
=A0(4
                                &lt;&lt; AMDGPU_CTX_WORKLOAD_HINT_SHIFT)<br=
>
                                +#define AMDGPU_CTX_WORKLOAD_HINT_MAX=C2=A0=
 =C2=A0
                                =C2=A0 AMDGPU_CTX_WORKLOAD_HINT_COMPUTE<br>
                                +#define AMDGPU_CTX_WORKLOAD_INDEX(n)=C2=A0=
 =C2=A0
                                =C2=A0 (n &gt;&gt;
                                AMDGPU_CTX_WORKLOAD_HINT_SHIFT)<br>
                                +<br>
                                =C2=A0struct drm_amdgpu_ctx_in {<br>
                                =C2=A0 =C2=A0 =C2=A0 =C2=A0 /** AMDGPU_CTX_=
OP_* */<br>
                                =C2=A0 =C2=A0 =C2=A0 =C2=A0 __u32=C2=A0 =C2=
=A0op;<br>
                                @@ -281,6 +293,11 @@ union
                                drm_amdgpu_ctx_out {<br>
                                =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 __u32=C2=A0 =C2=A0flags;<br>
                                =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 __u32=C2=A0 =C2=A0_pad;<br>
                                =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 } pstate;<br>
                                +<br>
                                +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0struct {<br>
                                +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0__u32=C2=A0 =C2=A0flags;<br>
                                +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0__u32=C2=A0 =C2=A0_pad;<br>
                                +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0} workload;<br>
                                =C2=A0};<br>
                                <br>
                                =C2=A0union drm_amdgpu_ctx {<br>
                                -- <br>
                                2.34.1</p>
                            </blockquote>
                          </div>
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
      </div>
    </blockquote>
    <br>
  </div>

</blockquote></div></div>

--000000000000dc2ba105f77e1811--
