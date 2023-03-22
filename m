Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC687C6FD1F
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Mar 2023 14:25:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5101010E96B;
	Wed, 22 Mar 2023 14:25:37 +0000 (UTC)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1FAA510E38A
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Mar 2023 14:25:36 +0000 (UTC)
Received: by mail-ed1-x52f.google.com with SMTP id i5so26816773eda.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Mar 2023 07:25:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20210112; t=1679495134;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=fKmw/jYXQe3j90rqeLfwWrKDt2llWsD6paQijRIkoEo=;
 b=N3xACocBq9/XSA8lcIDH9+DSV7TP4WSo8mh+1f/AhLLhojmOwvzvEV+Ik5W441cds5
 0d0P3wkDZk8JO6m13219PfQ2pBfZwTZFc7qxahcANt7KcGpP7xOTQ/FRFDKTUTXyoteo
 nxhY4GuRYGh+BOuqllKKeJv2ARTBsAvhpMIr6jcrV1l+VhtNZeNNcUiWA6+G4lvfg/lY
 0p+ZsAHJ21hd6jMLVtAIVIMKZdtGHCeU/VGTjnkLASYqMfU4pjBXxHHYBX4CK6Y3zgAr
 3/VfArBPmxM5EMwEZPQ4PKXdF5mBVNvmU/8rGC+aEfi/LmIIX/o4TVaQCHNGE2INXz6M
 2H4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1679495134;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fKmw/jYXQe3j90rqeLfwWrKDt2llWsD6paQijRIkoEo=;
 b=V4bDVPl6xfb9OkH70u5tWoksLyCi44ujVA/LBPlhZKXU+OT5CuELkI1386XJUriNiy
 /zuQQtwQdu7CRI55NHI/t3/AkTmOegIfvPQwup2vuvLrcaq+l8HbjjU5HRexhYP8lufO
 wqcYIzC7X27DmC8o8O7gJVMY7UvonRcMcV9AdQlv2dtjUEzZguLNkUyCAeWWMXl1Pn+l
 wGwbjYxEh6n+LrOXsGG2YOc38iaswq/0+rK8ohlqxdkQGe/kpX6pL9Ro+9pE8VKGlpbY
 IlrJyRCA5FRUbj8WsqVUhZT1hUvZS6p12XB0Rtu3cvyWD2IPYw4zWiyaCEGtOPNhkaCz
 ggPg==
X-Gm-Message-State: AO0yUKW8Ga+tqIYdqWufLVWLISMCNoebw27/vzpAe7qlwaQLmMG3qZRc
 fZ+2sj0j9mGmIbIdC558mw/4mk1OGWSjM101frHts3twuWE=
X-Google-Smtp-Source: AK7set/Aj+ok8Qi2eAgQexiLbcsyVjeHGkwdojEkBJE3CQtr8vKcZ/B43JPBJKhT9EzLvs2MRbd8GvlLw2PWl8aHP/U=
X-Received: by 2002:a17:907:60cc:b0:93b:1ca6:6adc with SMTP id
 hv12-20020a17090760cc00b0093b1ca66adcmr1634386ejc.7.1679495134454; Wed, 22
 Mar 2023 07:25:34 -0700 (PDT)
MIME-Version: 1.0
References: <20220926214014.5450-1-shashank.sharma@amd.com>
 <20220926214014.5450-2-shashank.sharma@amd.com>
 <CAAxE2A67NMxra-a9ZYbY8e8S4fjfdXgB1cpjYZsSS8DcUu=LbA@mail.gmail.com>
 <MW4PR12MB56678ED37B6E498D3405F875F2819@MW4PR12MB5667.namprd12.prod.outlook.com>
 <0e904e40-ee6f-dea2-b2de-3e408a72908e@gmail.com>
 <CAAxE2A66ZF==rvDd8KFrfz79rXBB52vnWU7zsM+rfH69OV0Psw@mail.gmail.com>
 <ac80456d-ac57-dbf4-dca0-7f92a40bb603@amd.com>
In-Reply-To: <ac80456d-ac57-dbf4-dca0-7f92a40bb603@amd.com>
From: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>
Date: Wed, 22 Mar 2023 10:24:58 -0400
Message-ID: <CAAxE2A60VNbjKS3LpKjX=Y9gPD92gw4hBJpQApmcQKCu0UM4UQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/5] drm/amdgpu: add UAPI for workload hints to ctx
 ioctl
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: multipart/alternative; boundary="000000000000e426bc05f77deef6"
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

--000000000000e426bc05f77deef6
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

The hint is static per API (one of graphics, video, compute, unknown). In
the case of Vulkan, which exposes all queues, the hint is unknown, so
Vulkan won't use it. (or make it based on the queue being used and not the
uapi context state) GL won't use it because the default hint is already 3D.
That makes VAAPI the only user that only sets the hint once, and maybe it's
not worth even adding this uapi just for VAAPI.

Marek

On Wed, Mar 22, 2023 at 10:08=E2=80=AFAM Christian K=C3=B6nig <christian.ko=
enig@amd.com>
wrote:

> Well completely agree that we shouldn't have unused API. That's why I sai=
d
> we should remove the getting the hint from the UAPI.
>
> But what's wrong with setting it after creating the context? Don't you
> know enough about the use case? I need to understand the background a bit
> better here.
>
> Christian.
>
> Am 22.03.23 um 15:05 schrieb Marek Ol=C5=A1=C3=A1k:
>
> The option to change the hint after context creation and get the hint
> would be unused uapi, and AFAIK we are not supposed to add unused uapi.
> What I asked is to change it to a uapi that userspace will actually use.
>
> Marek
>
> On Tue, Mar 21, 2023 at 9:54=E2=80=AFAM Christian K=C3=B6nig <
> ckoenig.leichtzumerken@gmail.com> wrote:
>
>> Yes, I would like to avoid having multiple code paths for context
>> creation.
>>
>> Setting it later on should be equally to specifying it on creation since
>> we only need it during CS.
>>
>> Regards,
>> Christian.
>>
>> Am 21.03.23 um 14:00 schrieb Sharma, Shashank:
>>
>> [AMD Official Use Only - General]
>>
>>
>>
>> When we started this patch series, the workload hint was a part of the
>> ctx_flag only,
>>
>> But we changed that after the design review, to make it more like how we
>> are handling PSTATE.
>>
>>
>>
>> Details:
>>
>> https://patchwork.freedesktop.org/patch/496111/
>>
>>
>>
>> Regards
>>
>> Shashank
>>
>>
>>
>> *From:* Marek Ol=C5=A1=C3=A1k <maraeo@gmail.com> <maraeo@gmail.com>
>> *Sent:* 21 March 2023 04:05
>> *To:* Sharma, Shashank <Shashank.Sharma@amd.com>
>> <Shashank.Sharma@amd.com>
>> *Cc:* amd-gfx@lists.freedesktop.org; Deucher, Alexander
>> <Alexander.Deucher@amd.com> <Alexander.Deucher@amd.com>; Somalapuram,
>> Amaranath <Amaranath.Somalapuram@amd.com> <Amaranath.Somalapuram@amd.com=
>;
>> Koenig, Christian <Christian.Koenig@amd.com> <Christian.Koenig@amd.com>
>> *Subject:* Re: [PATCH v3 1/5] drm/amdgpu: add UAPI for workload hints to
>> ctx ioctl
>>
>>
>>
>> I think we should do it differently because this interface will be mostl=
y
>> unused by open source userspace in its current form.
>>
>>
>>
>> Let's set the workload hint in drm_amdgpu_ctx_in::flags, and that will b=
e
>> immutable for the lifetime of the context. No other interface is needed.
>>
>>
>>
>> Marek
>>
>>
>>
>> On Mon, Sep 26, 2022 at 5:41=E2=80=AFPM Shashank Sharma <shashank.sharma=
@amd.com>
>> wrote:
>>
>> Allow the user to specify a workload hint to the kernel.
>> We can use these to tweak the dpm heuristics to better match
>> the workload for improved performance.
>>
>> V3: Create only set() workload UAPI (Christian)
>>
>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
>> ---
>>  include/uapi/drm/amdgpu_drm.h | 17 +++++++++++++++++
>>  1 file changed, 17 insertions(+)
>>
>> diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm=
.h
>> index c2c9c674a223..23d354242699 100644
>> --- a/include/uapi/drm/amdgpu_drm.h
>> +++ b/include/uapi/drm/amdgpu_drm.h
>> @@ -212,6 +212,7 @@ union drm_amdgpu_bo_list {
>>  #define AMDGPU_CTX_OP_QUERY_STATE2     4
>>  #define AMDGPU_CTX_OP_GET_STABLE_PSTATE        5
>>  #define AMDGPU_CTX_OP_SET_STABLE_PSTATE        6
>> +#define AMDGPU_CTX_OP_SET_WORKLOAD_PROFILE     7
>>
>>  /* GPU reset status */
>>  #define AMDGPU_CTX_NO_RESET            0
>> @@ -252,6 +253,17 @@ union drm_amdgpu_bo_list {
>>  #define AMDGPU_CTX_STABLE_PSTATE_MIN_MCLK  3
>>  #define AMDGPU_CTX_STABLE_PSTATE_PEAK  4
>>
>> +/* GPU workload hints, flag bits 8-15 */
>> +#define AMDGPU_CTX_WORKLOAD_HINT_SHIFT     8
>> +#define AMDGPU_CTX_WORKLOAD_HINT_MASK      (0xff <<
>> AMDGPU_CTX_WORKLOAD_HINT_SHIFT)
>> +#define AMDGPU_CTX_WORKLOAD_HINT_NONE      (0 <<
>> AMDGPU_CTX_WORKLOAD_HINT_SHIFT)
>> +#define AMDGPU_CTX_WORKLOAD_HINT_3D        (1 <<
>> AMDGPU_CTX_WORKLOAD_HINT_SHIFT)
>> +#define AMDGPU_CTX_WORKLOAD_HINT_VIDEO     (2 <<
>> AMDGPU_CTX_WORKLOAD_HINT_SHIFT)
>> +#define AMDGPU_CTX_WORKLOAD_HINT_VR        (3 <<
>> AMDGPU_CTX_WORKLOAD_HINT_SHIFT)
>> +#define AMDGPU_CTX_WORKLOAD_HINT_COMPUTE   (4 <<
>> AMDGPU_CTX_WORKLOAD_HINT_SHIFT)
>> +#define AMDGPU_CTX_WORKLOAD_HINT_MAX
>> AMDGPU_CTX_WORKLOAD_HINT_COMPUTE
>> +#define AMDGPU_CTX_WORKLOAD_INDEX(n)      (n >>
>> AMDGPU_CTX_WORKLOAD_HINT_SHIFT)
>> +
>>  struct drm_amdgpu_ctx_in {
>>         /** AMDGPU_CTX_OP_* */
>>         __u32   op;
>> @@ -281,6 +293,11 @@ union drm_amdgpu_ctx_out {
>>                         __u32   flags;
>>                         __u32   _pad;
>>                 } pstate;
>> +
>> +               struct {
>> +                       __u32   flags;
>> +                       __u32   _pad;
>> +               } workload;
>>  };
>>
>>  union drm_amdgpu_ctx {
>> --
>> 2.34.1
>>
>>
>>
>

--000000000000e426bc05f77deef6
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>The hint is static per API (one of graphics, video, c=
ompute, unknown). In the case of Vulkan, which exposes all queues, the hint=
 is unknown, so Vulkan won&#39;t use it. (or make it based on the queue bei=
ng used and not the uapi context state) GL won&#39;t use it because the def=
ault hint is already 3D. That makes VAAPI the only user that only sets the =
hint once, and maybe it&#39;s not worth even adding this uapi just for VAAP=
I.<br></div><div><br></div><div>Marek<br></div><br><div class=3D"gmail_quot=
e"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Mar 22, 2023 at 10:08=E2=
=80=AFAM Christian K=C3=B6nig &lt;<a href=3D"mailto:christian.koenig@amd.co=
m">christian.koenig@amd.com</a>&gt; wrote:<br></div><blockquote class=3D"gm=
ail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,=
204,204);padding-left:1ex">

 =20
  <div>
    Well completely agree that we shouldn&#39;t have unused API. That&#39;s=
 why
    I said we should remove the getting the hint from the UAPI.<br>
    <br>
    But what&#39;s wrong with setting it after creating the context? Don&#3=
9;t
    you know enough about the use case? I need to understand the
    background a bit better here.<br>
    <br>
    Christian.<br>
    <br>
    <div>Am 22.03.23 um 15:05 schrieb Marek
      Ol=C5=A1=C3=A1k:<br>
    </div>
    <blockquote type=3D"cite">
     =20
      <div dir=3D"ltr">
        <div>The option to change the hint after context creation and
          get the hint would be unused uapi, and AFAIK we are not
          supposed to add unused uapi. What I asked is to change it to a
          uapi that userspace will actually use.<br>
        </div>
        <div><br>
        </div>
        <div>Marek<br>
        </div>
      </div>
      <br>
      <div class=3D"gmail_quote">
        <div dir=3D"ltr" class=3D"gmail_attr">On Tue, Mar 21, 2023 at
          9:54=E2=80=AFAM Christian K=C3=B6nig &lt;<a href=3D"mailto:ckoeni=
g.leichtzumerken@gmail.com" target=3D"_blank">ckoenig.leichtzumerken@gmail.=
com</a>&gt;
          wrote:<br>
        </div>
        <blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex=
;border-left:1px solid rgb(204,204,204);padding-left:1ex">
          <div> Yes, I would like to avoid having multiple code paths
            for context creation.<br>
            <br>
            Setting it later on should be equally to specifying it on
            creation since we only need it during CS.<br>
            <br>
            Regards,<br>
            Christian.<br>
            <br>
            <div>Am 21.03.23 um 14:00 schrieb Sharma, Shashank:<br>
            </div>
            <blockquote type=3D"cite">
              <div>
                <p style=3D"margin:0cm"><span style=3D"font-size:10pt;font-=
family:&quot;Arial&quot;,sans-serif;color:blue">[AMD
                    Official Use Only - General]</span></p>
                <p class=3D"MsoNormal">=C2=A0</p>
                <p class=3D"MsoNormal"><span>When we started this patch
                    series, the workload hint was a part of the ctx_flag
                    only, </span></p>
                <p class=3D"MsoNormal"><span>But we changed that after the
                    design review, to make it more like how we are
                    handling PSTATE. </span></p>
                <p class=3D"MsoNormal"><span>=C2=A0</span></p>
                <p class=3D"MsoNormal"><span>Details: </span></p>
                <p class=3D"MsoNormal"><span><a href=3D"https://patchwork.f=
reedesktop.org/patch/496111/" target=3D"_blank">https://patchwork.freedeskt=
op.org/patch/496111/</a>
                  </span></p>
                <p class=3D"MsoNormal"><span>=C2=A0</span></p>
                <p class=3D"MsoNormal"><span>Regards</span></p>
                <p class=3D"MsoNormal"><span>Shashank </span></p>
                <p class=3D"MsoNormal"><span>=C2=A0</span></p>
                <div style=3D"border-color:rgb(225,225,225) currentcolor cu=
rrentcolor;border-style:solid none none;border-width:1pt medium medium;padd=
ing:3pt 0cm 0cm">
                  <p class=3D"MsoNormal"><b><span lang=3D"EN-US">From:</spa=
n></b><span lang=3D"EN-US"> Marek Ol=C5=A1=C3=A1k <a href=3D"mailto:maraeo@=
gmail.com" target=3D"_blank">&lt;maraeo@gmail.com&gt;</a>
                      <br>
                      <b>Sent:</b> 21 March 2023 04:05<br>
                      <b>To:</b> Sharma, Shashank <a href=3D"mailto:Shashan=
k.Sharma@amd.com" target=3D"_blank">&lt;Shashank.Sharma@amd.com&gt;</a><br>
                      <b>Cc:</b> <a href=3D"mailto:amd-gfx@lists.freedeskto=
p.org" target=3D"_blank">amd-gfx@lists.freedesktop.org</a>;
                      Deucher, Alexander <a href=3D"mailto:Alexander.Deuche=
r@amd.com" target=3D"_blank">&lt;Alexander.Deucher@amd.com&gt;</a>;
                      Somalapuram, Amaranath <a href=3D"mailto:Amaranath.So=
malapuram@amd.com" target=3D"_blank">&lt;Amaranath.Somalapuram@amd.com&gt;<=
/a>;
                      Koenig, Christian <a href=3D"mailto:Christian.Koenig@=
amd.com" target=3D"_blank">&lt;Christian.Koenig@amd.com&gt;</a><br>
                      <b>Subject:</b> Re: [PATCH v3 1/5] drm/amdgpu: add
                      UAPI for workload hints to ctx ioctl</span></p>
                </div>
                <p class=3D"MsoNormal">=C2=A0</p>
                <div>
                  <div>
                    <p class=3D"MsoNormal">I think we should do it
                      differently because this interface will be mostly
                      unused by open source userspace in its current
                      form.</p>
                  </div>
                  <div>
                    <p class=3D"MsoNormal">=C2=A0</p>
                  </div>
                  <div>
                    <p class=3D"MsoNormal">Let&#39;s set the workload hint =
in
                      drm_amdgpu_ctx_in::flags, and that will be
                      immutable for the lifetime of the context. No
                      other interface is needed.</p>
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
                    <p class=3D"MsoNormal">On Mon, Sep 26, 2022 at 5:41=E2=
=80=AFPM
                      Shashank Sharma &lt;<a href=3D"mailto:shashank.sharma=
@amd.com" target=3D"_blank">shashank.sharma@amd.com</a>&gt;
                      wrote:</p>
                  </div>
                  <blockquote style=3D"border-color:currentcolor currentcol=
or currentcolor rgb(204,204,204);border-style:none none none solid;border-w=
idth:medium medium medium 1pt;padding:0cm 0cm 0cm 6pt;margin:5pt 0cm 5pt 4.=
8pt">
                    <p class=3D"MsoNormal" style=3D"margin-bottom:12pt">All=
ow
                      the user to specify a workload hint to the kernel.<br=
>
                      We can use these to tweak the dpm heuristics to
                      better match<br>
                      the workload for improved performance.<br>
                      <br>
                      V3: Create only set() workload UAPI (Christian)<br>
                      <br>
                      Signed-off-by: Alex Deucher &lt;<a href=3D"mailto:ale=
xander.deucher@amd.com" target=3D"_blank">alexander.deucher@amd.com</a>&gt;=
<br>
                      Signed-off-by: Shashank Sharma &lt;<a href=3D"mailto:=
shashank.sharma@amd.com" target=3D"_blank">shashank.sharma@amd.com</a>&gt;<=
br>
                      ---<br>
                      =C2=A0include/uapi/drm/amdgpu_drm.h | 17
                      +++++++++++++++++<br>
                      =C2=A01 file changed, 17 insertions(+)<br>
                      <br>
                      diff --git a/include/uapi/drm/amdgpu_drm.h
                      b/include/uapi/drm/amdgpu_drm.h<br>
                      index c2c9c674a223..23d354242699 100644<br>
                      --- a/include/uapi/drm/amdgpu_drm.h<br>
                      +++ b/include/uapi/drm/amdgpu_drm.h<br>
                      @@ -212,6 +212,7 @@ union drm_amdgpu_bo_list {<br>
                      =C2=A0#define AMDGPU_CTX_OP_QUERY_STATE2=C2=A0 =C2=A0=
 =C2=A04<br>
                      =C2=A0#define AMDGPU_CTX_OP_GET_STABLE_PSTATE=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 5<br>
                      =C2=A0#define AMDGPU_CTX_OP_SET_STABLE_PSTATE=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 6<br>
                      +#define AMDGPU_CTX_OP_SET_WORKLOAD_PROFILE=C2=A0 =C2=
=A0 =C2=A07<br>
                      <br>
                      =C2=A0/* GPU reset status */<br>
                      =C2=A0#define AMDGPU_CTX_NO_RESET=C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 0<br>
                      @@ -252,6 +253,17 @@ union drm_amdgpu_bo_list {<br>
                      =C2=A0#define AMDGPU_CTX_STABLE_PSTATE_MIN_MCLK=C2=A0=
 3<br>
                      =C2=A0#define AMDGPU_CTX_STABLE_PSTATE_PEAK=C2=A0 4<b=
r>
                      <br>
                      +/* GPU workload hints, flag bits 8-15 */<br>
                      +#define AMDGPU_CTX_WORKLOAD_HINT_SHIFT=C2=A0 =C2=A0 =
=C2=A08<br>
                      +#define AMDGPU_CTX_WORKLOAD_HINT_MASK=C2=A0 =C2=A0 =
=C2=A0 (0xff
                      &lt;&lt; AMDGPU_CTX_WORKLOAD_HINT_SHIFT)<br>
                      +#define AMDGPU_CTX_WORKLOAD_HINT_NONE=C2=A0 =C2=A0 =
=C2=A0 (0
                      &lt;&lt; AMDGPU_CTX_WORKLOAD_HINT_SHIFT)<br>
                      +#define AMDGPU_CTX_WORKLOAD_HINT_3D=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 (1
                      &lt;&lt; AMDGPU_CTX_WORKLOAD_HINT_SHIFT)<br>
                      +#define AMDGPU_CTX_WORKLOAD_HINT_VIDEO=C2=A0 =C2=A0 =
=C2=A0(2
                      &lt;&lt; AMDGPU_CTX_WORKLOAD_HINT_SHIFT)<br>
                      +#define AMDGPU_CTX_WORKLOAD_HINT_VR=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 (3
                      &lt;&lt; AMDGPU_CTX_WORKLOAD_HINT_SHIFT)<br>
                      +#define AMDGPU_CTX_WORKLOAD_HINT_COMPUTE=C2=A0 =C2=
=A0(4
                      &lt;&lt; AMDGPU_CTX_WORKLOAD_HINT_SHIFT)<br>
                      +#define AMDGPU_CTX_WORKLOAD_HINT_MAX=C2=A0 =C2=A0 =
=C2=A0
                      AMDGPU_CTX_WORKLOAD_HINT_COMPUTE<br>
                      +#define AMDGPU_CTX_WORKLOAD_INDEX(n)=C2=A0 =C2=A0 =
=C2=A0 (n
                      &gt;&gt; AMDGPU_CTX_WORKLOAD_HINT_SHIFT)<br>
                      +<br>
                      =C2=A0struct drm_amdgpu_ctx_in {<br>
                      =C2=A0 =C2=A0 =C2=A0 =C2=A0 /** AMDGPU_CTX_OP_* */<br=
>
                      =C2=A0 =C2=A0 =C2=A0 =C2=A0 __u32=C2=A0 =C2=A0op;<br>
                      @@ -281,6 +293,11 @@ union drm_amdgpu_ctx_out {<br>
                      =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 __u32=C2=A0 =C2=A0flags;<br>
                      =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 __u32=C2=A0 =C2=A0_pad;<br>
                      =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 } pstate;<br>
                      +<br>
                      +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0struct {<br>
                      +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0__u32=C2=A0 =C2=A0flags;<br>
                      +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0__u32=C2=A0 =C2=A0_pad;<br>
                      +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0} workload;<br>
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

</blockquote></div></div>

--000000000000e426bc05f77deef6--
