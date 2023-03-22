Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5B3CC761A6
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Mar 2023 14:06:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 21D3A10E371;
	Wed, 22 Mar 2023 14:06:33 +0000 (UTC)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 18FFD10E371
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Mar 2023 14:06:31 +0000 (UTC)
Received: by mail-ed1-x532.google.com with SMTP id w9so73513147edc.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Mar 2023 07:06:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20210112; t=1679493989;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=tlCn+FG/EnBMooQNnmZGtRMIQYI844enbZaMHnfMaT0=;
 b=VWfPtXIbiSHNMZtxMFahjJTsxqeFR39LmmAQXFWKS85Xj+87yr3V5iTqgeLNGfn+o3
 X5eTYSUfCK1PmVCQbsRD3IycVYz2dGHZb2I7OUWZH/ZlX37r+R2DTIUX7dqa6NQ7QAnn
 En/hFyIUTYipfAfSReorAfT0UNqtrpbvLcD+8oVnjxLZcxCbnDcIn8V22LuZdcO6/Nxw
 F+vebr5NvEdtJYjXgLdjgyU9LAsVA3G4xOJ6aDqHePBYgVqnpKQPk9+/ih5xYbG6DRy1
 s8oa1Gm6+9yEG3xisxY+H9FHmZBCfWNO95c+GkqepsHCjuCnikhcmopZiEzw6rdJSnvm
 5CFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1679493989;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tlCn+FG/EnBMooQNnmZGtRMIQYI844enbZaMHnfMaT0=;
 b=WSEn8Bd2jopXNgr+S+cv8RqvKHszgDfc6C8v5h9dfOqncKL+FS+J7rrEVqLr3GW1mp
 UVctDN/jMv05K/o7bqpE/EbtkNTtn47db6whn1idYGr5bTlDVLJqkUghGjj42Y1W62Jy
 Q181ToOGCDSQhQOkndah/2vOZ3YzjnuXm2u5lXT9fZPJp/F2k6VJW9PugYwHc4aNiWFK
 uG+KkFZTVsBtP2Ox8QnmPdZFt1MYpjqwXSn6ohpdU5oGaKKgD4bVfL5fsdJfBS5aZfPC
 R4tU8BhAJdT+NXWbO2MT6dIToesQY9pmfjaJKpJvXZ18vGoIEdXUu+CZF+1vxW55DGkS
 SAMg==
X-Gm-Message-State: AO0yUKUDk+sFqylDschgpykq1nkrhCt7PSdVT2qOtXRL8r12A1HkaoBU
 2DyH5Kjf0dt7WPaVdGgprQQ9RQCMu5msV5ez/GE=
X-Google-Smtp-Source: AK7set/i7OKX5+9Zs4aWMyE7EFQ0u9w1esibQiBMrVJAzcUa0JxXqBzxONmk8ww84n5yqJ4SzvoeaVLLRYO65qEolzw=
X-Received: by 2002:a50:c384:0:b0:500:547b:4e1b with SMTP id
 h4-20020a50c384000000b00500547b4e1bmr3675455edf.6.1679493989318; Wed, 22 Mar
 2023 07:06:29 -0700 (PDT)
MIME-Version: 1.0
References: <20220926214014.5450-1-shashank.sharma@amd.com>
 <20220926214014.5450-2-shashank.sharma@amd.com>
 <CAAxE2A67NMxra-a9ZYbY8e8S4fjfdXgB1cpjYZsSS8DcUu=LbA@mail.gmail.com>
 <MW4PR12MB56678ED37B6E498D3405F875F2819@MW4PR12MB5667.namprd12.prod.outlook.com>
 <0e904e40-ee6f-dea2-b2de-3e408a72908e@gmail.com>
In-Reply-To: <0e904e40-ee6f-dea2-b2de-3e408a72908e@gmail.com>
From: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>
Date: Wed, 22 Mar 2023 10:05:53 -0400
Message-ID: <CAAxE2A66ZF==rvDd8KFrfz79rXBB52vnWU7zsM+rfH69OV0Psw@mail.gmail.com>
Subject: Re: [PATCH v3 1/5] drm/amdgpu: add UAPI for workload hints to ctx
 ioctl
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
Content-Type: multipart/alternative; boundary="000000000000a2c49f05f77daa67"
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Somalapuram,
 Amaranath" <Amaranath.Somalapuram@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Sharma,
 Shashank" <Shashank.Sharma@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--000000000000a2c49f05f77daa67
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

The option to change the hint after context creation and get the hint would
be unused uapi, and AFAIK we are not supposed to add unused uapi. What I
asked is to change it to a uapi that userspace will actually use.

Marek

On Tue, Mar 21, 2023 at 9:54=E2=80=AFAM Christian K=C3=B6nig <
ckoenig.leichtzumerken@gmail.com> wrote:

> Yes, I would like to avoid having multiple code paths for context creatio=
n.
>
> Setting it later on should be equally to specifying it on creation since
> we only need it during CS.
>
> Regards,
> Christian.
>
> Am 21.03.23 um 14:00 schrieb Sharma, Shashank:
>
> [AMD Official Use Only - General]
>
>
>
> When we started this patch series, the workload hint was a part of the
> ctx_flag only,
>
> But we changed that after the design review, to make it more like how we
> are handling PSTATE.
>
>
>
> Details:
>
> https://patchwork.freedesktop.org/patch/496111/
>
>
>
> Regards
>
> Shashank
>
>
>
> *From:* Marek Ol=C5=A1=C3=A1k <maraeo@gmail.com> <maraeo@gmail.com>
> *Sent:* 21 March 2023 04:05
> *To:* Sharma, Shashank <Shashank.Sharma@amd.com> <Shashank.Sharma@amd.com=
>
> *Cc:* amd-gfx@lists.freedesktop.org; Deucher, Alexander
> <Alexander.Deucher@amd.com> <Alexander.Deucher@amd.com>; Somalapuram,
> Amaranath <Amaranath.Somalapuram@amd.com> <Amaranath.Somalapuram@amd.com>=
;
> Koenig, Christian <Christian.Koenig@amd.com> <Christian.Koenig@amd.com>
> *Subject:* Re: [PATCH v3 1/5] drm/amdgpu: add UAPI for workload hints to
> ctx ioctl
>
>
>
> I think we should do it differently because this interface will be mostly
> unused by open source userspace in its current form.
>
>
>
> Let's set the workload hint in drm_amdgpu_ctx_in::flags, and that will be
> immutable for the lifetime of the context. No other interface is needed.
>
>
>
> Marek
>
>
>
> On Mon, Sep 26, 2022 at 5:41=E2=80=AFPM Shashank Sharma <shashank.sharma@=
amd.com>
> wrote:
>
> Allow the user to specify a workload hint to the kernel.
> We can use these to tweak the dpm heuristics to better match
> the workload for improved performance.
>
> V3: Create only set() workload UAPI (Christian)
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
> ---
>  include/uapi/drm/amdgpu_drm.h | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>
> diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.=
h
> index c2c9c674a223..23d354242699 100644
> --- a/include/uapi/drm/amdgpu_drm.h
> +++ b/include/uapi/drm/amdgpu_drm.h
> @@ -212,6 +212,7 @@ union drm_amdgpu_bo_list {
>  #define AMDGPU_CTX_OP_QUERY_STATE2     4
>  #define AMDGPU_CTX_OP_GET_STABLE_PSTATE        5
>  #define AMDGPU_CTX_OP_SET_STABLE_PSTATE        6
> +#define AMDGPU_CTX_OP_SET_WORKLOAD_PROFILE     7
>
>  /* GPU reset status */
>  #define AMDGPU_CTX_NO_RESET            0
> @@ -252,6 +253,17 @@ union drm_amdgpu_bo_list {
>  #define AMDGPU_CTX_STABLE_PSTATE_MIN_MCLK  3
>  #define AMDGPU_CTX_STABLE_PSTATE_PEAK  4
>
> +/* GPU workload hints, flag bits 8-15 */
> +#define AMDGPU_CTX_WORKLOAD_HINT_SHIFT     8
> +#define AMDGPU_CTX_WORKLOAD_HINT_MASK      (0xff <<
> AMDGPU_CTX_WORKLOAD_HINT_SHIFT)
> +#define AMDGPU_CTX_WORKLOAD_HINT_NONE      (0 <<
> AMDGPU_CTX_WORKLOAD_HINT_SHIFT)
> +#define AMDGPU_CTX_WORKLOAD_HINT_3D        (1 <<
> AMDGPU_CTX_WORKLOAD_HINT_SHIFT)
> +#define AMDGPU_CTX_WORKLOAD_HINT_VIDEO     (2 <<
> AMDGPU_CTX_WORKLOAD_HINT_SHIFT)
> +#define AMDGPU_CTX_WORKLOAD_HINT_VR        (3 <<
> AMDGPU_CTX_WORKLOAD_HINT_SHIFT)
> +#define AMDGPU_CTX_WORKLOAD_HINT_COMPUTE   (4 <<
> AMDGPU_CTX_WORKLOAD_HINT_SHIFT)
> +#define AMDGPU_CTX_WORKLOAD_HINT_MAX      AMDGPU_CTX_WORKLOAD_HINT_COMPU=
TE
> +#define AMDGPU_CTX_WORKLOAD_INDEX(n)      (n >>
> AMDGPU_CTX_WORKLOAD_HINT_SHIFT)
> +
>  struct drm_amdgpu_ctx_in {
>         /** AMDGPU_CTX_OP_* */
>         __u32   op;
> @@ -281,6 +293,11 @@ union drm_amdgpu_ctx_out {
>                         __u32   flags;
>                         __u32   _pad;
>                 } pstate;
> +
> +               struct {
> +                       __u32   flags;
> +                       __u32   _pad;
> +               } workload;
>  };
>
>  union drm_amdgpu_ctx {
> --
> 2.34.1
>
>
>

--000000000000a2c49f05f77daa67
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>The option to change the hint after context creation =
and get the hint would be unused uapi, and AFAIK we are not supposed to add=
 unused uapi. What I asked is to change it to a uapi that userspace will ac=
tually use.<br></div><div><br></div><div>Marek<br></div></div><br><div clas=
s=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Mar 21, 202=
3 at 9:54=E2=80=AFAM Christian K=C3=B6nig &lt;<a href=3D"mailto:ckoenig.lei=
chtzumerken@gmail.com" target=3D"_blank">ckoenig.leichtzumerken@gmail.com</=
a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0p=
x 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
 =20
   =20
 =20
  <div>
    Yes, I would like to avoid having multiple code paths for context
    creation.<br>
    <br>
    Setting it later on should be equally to specifying it on creation
    since we only need it during CS.<br>
    <br>
    Regards,<br>
    Christian.<br>
    <br>
    <div>Am 21.03.23 um 14:00 schrieb Sharma,
      Shashank:<br>
    </div>
    <blockquote type=3D"cite">
     =20
     =20
     =20
      <div>
        <p style=3D"margin:0cm"><span style=3D"font-size:10pt;font-family:&=
quot;Arial&quot;,sans-serif;color:blue">[AMD
            Official Use Only - General]</span><u></u><u></u></p>
        <p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
        <p class=3D"MsoNormal"><span>When
            we started this patch series, the workload hint was a part
            of the ctx_flag only,
            <u></u><u></u></span></p>
        <p class=3D"MsoNormal"><span>But
            we changed that after the design review, to make it more
            like how we are handling PSTATE.
            <u></u><u></u></span></p>
        <p class=3D"MsoNormal"><span><u></u>=C2=A0<u></u></span></p>
        <p class=3D"MsoNormal"><span>Details:
            <u></u><u></u></span></p>
        <p class=3D"MsoNormal"><span><a href=3D"https://patchwork.freedeskt=
op.org/patch/496111/" target=3D"_blank">https://patchwork.freedesktop.org/p=
atch/496111/</a>
            <u></u><u></u></span></p>
        <p class=3D"MsoNormal"><span><u></u>=C2=A0<u></u></span></p>
        <p class=3D"MsoNormal"><span>Regards<u></u><u></u></span></p>
        <p class=3D"MsoNormal"><span>Shashank
            <u></u><u></u></span></p>
        <p class=3D"MsoNormal"><span><u></u>=C2=A0<u></u></span></p>
        <div style=3D"border-color:rgb(225,225,225) currentcolor currentcol=
or;border-style:solid none none;border-width:1pt medium medium;padding:3pt =
0cm 0cm">
          <p class=3D"MsoNormal"><b><span lang=3D"EN-US">From:</span></b><s=
pan lang=3D"EN-US"> Marek Ol=C5=A1=C3=A1k <a href=3D"mailto:maraeo@gmail.co=
m" target=3D"_blank">&lt;maraeo@gmail.com&gt;</a>
              <br>
              <b>Sent:</b> 21 March 2023 04:05<br>
              <b>To:</b> Sharma, Shashank
              <a href=3D"mailto:Shashank.Sharma@amd.com" target=3D"_blank">=
&lt;Shashank.Sharma@amd.com&gt;</a><br>
              <b>Cc:</b> <a href=3D"mailto:amd-gfx@lists.freedesktop.org" t=
arget=3D"_blank">amd-gfx@lists.freedesktop.org</a>; Deucher,
              Alexander <a href=3D"mailto:Alexander.Deucher@amd.com" target=
=3D"_blank">&lt;Alexander.Deucher@amd.com&gt;</a>; Somalapuram,
              Amaranath <a href=3D"mailto:Amaranath.Somalapuram@amd.com" ta=
rget=3D"_blank">&lt;Amaranath.Somalapuram@amd.com&gt;</a>; Koenig,
              Christian <a href=3D"mailto:Christian.Koenig@amd.com" target=
=3D"_blank">&lt;Christian.Koenig@amd.com&gt;</a><br>
              <b>Subject:</b> Re: [PATCH v3 1/5] drm/amdgpu: add UAPI
              for workload hints to ctx ioctl<u></u><u></u></span></p>
        </div>
        <p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
        <div>
          <div>
            <p class=3D"MsoNormal">I think we should do it differently
              because this interface will be mostly unused by open
              source userspace in its current form.<u></u><u></u></p>
          </div>
          <div>
            <p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
          </div>
          <div>
            <p class=3D"MsoNormal">Let&#39;s set the workload hint in
              drm_amdgpu_ctx_in::flags, and that will be immutable for
              the lifetime of the context. No other interface is needed.<u>=
</u><u></u></p>
          </div>
          <div>
            <p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
          </div>
          <div>
            <p class=3D"MsoNormal">Marek<u></u><u></u></p>
          </div>
        </div>
        <p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
        <div>
          <div>
            <p class=3D"MsoNormal">On Mon, Sep 26, 2022 at 5:41=E2=80=AFPM
              Shashank Sharma &lt;<a href=3D"mailto:shashank.sharma@amd.com=
" target=3D"_blank">shashank.sharma@amd.com</a>&gt;
              wrote:<u></u><u></u></p>
          </div>
          <blockquote style=3D"border-color:currentcolor currentcolor curre=
ntcolor rgb(204,204,204);border-style:none none none solid;border-width:med=
ium medium medium 1pt;padding:0cm 0cm 0cm 6pt;margin:5pt 0cm 5pt 4.8pt">
            <p class=3D"MsoNormal" style=3D"margin-bottom:12pt">Allow the
              user to specify a workload hint to the kernel.<br>
              We can use these to tweak the dpm heuristics to better
              match<br>
              the workload for improved performance.<br>
              <br>
              V3: Create only set() workload UAPI (Christian)<br>
              <br>
              Signed-off-by: Alex Deucher &lt;<a href=3D"mailto:alexander.d=
eucher@amd.com" target=3D"_blank">alexander.deucher@amd.com</a>&gt;<br>
              Signed-off-by: Shashank Sharma &lt;<a href=3D"mailto:shashank=
.sharma@amd.com" target=3D"_blank">shashank.sharma@amd.com</a>&gt;<br>
              ---<br>
              =C2=A0include/uapi/drm/amdgpu_drm.h | 17 +++++++++++++++++<br=
>
              =C2=A01 file changed, 17 insertions(+)<br>
              <br>
              diff --git a/include/uapi/drm/amdgpu_drm.h
              b/include/uapi/drm/amdgpu_drm.h<br>
              index c2c9c674a223..23d354242699 100644<br>
              --- a/include/uapi/drm/amdgpu_drm.h<br>
              +++ b/include/uapi/drm/amdgpu_drm.h<br>
              @@ -212,6 +212,7 @@ union drm_amdgpu_bo_list {<br>
              =C2=A0#define AMDGPU_CTX_OP_QUERY_STATE2=C2=A0 =C2=A0 =C2=A04=
<br>
              =C2=A0#define AMDGPU_CTX_OP_GET_STABLE_PSTATE=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 5<br>
              =C2=A0#define AMDGPU_CTX_OP_SET_STABLE_PSTATE=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 6<br>
              +#define AMDGPU_CTX_OP_SET_WORKLOAD_PROFILE=C2=A0 =C2=A0 =C2=
=A07<br>
              <br>
              =C2=A0/* GPU reset status */<br>
              =C2=A0#define AMDGPU_CTX_NO_RESET=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 0<br>
              @@ -252,6 +253,17 @@ union drm_amdgpu_bo_list {<br>
              =C2=A0#define AMDGPU_CTX_STABLE_PSTATE_MIN_MCLK=C2=A0 3<br>
              =C2=A0#define AMDGPU_CTX_STABLE_PSTATE_PEAK=C2=A0 4<br>
              <br>
              +/* GPU workload hints, flag bits 8-15 */<br>
              +#define AMDGPU_CTX_WORKLOAD_HINT_SHIFT=C2=A0 =C2=A0 =C2=A08<=
br>
              +#define AMDGPU_CTX_WORKLOAD_HINT_MASK=C2=A0 =C2=A0 =C2=A0 (0=
xff &lt;&lt;
              AMDGPU_CTX_WORKLOAD_HINT_SHIFT)<br>
              +#define AMDGPU_CTX_WORKLOAD_HINT_NONE=C2=A0 =C2=A0 =C2=A0 (0=
 &lt;&lt;
              AMDGPU_CTX_WORKLOAD_HINT_SHIFT)<br>
              +#define AMDGPU_CTX_WORKLOAD_HINT_3D=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 (1 &lt;&lt;
              AMDGPU_CTX_WORKLOAD_HINT_SHIFT)<br>
              +#define AMDGPU_CTX_WORKLOAD_HINT_VIDEO=C2=A0 =C2=A0 =C2=A0(2=
 &lt;&lt;
              AMDGPU_CTX_WORKLOAD_HINT_SHIFT)<br>
              +#define AMDGPU_CTX_WORKLOAD_HINT_VR=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 (3 &lt;&lt;
              AMDGPU_CTX_WORKLOAD_HINT_SHIFT)<br>
              +#define AMDGPU_CTX_WORKLOAD_HINT_COMPUTE=C2=A0 =C2=A0(4 &lt;=
&lt;
              AMDGPU_CTX_WORKLOAD_HINT_SHIFT)<br>
              +#define AMDGPU_CTX_WORKLOAD_HINT_MAX=C2=A0 =C2=A0 =C2=A0
              AMDGPU_CTX_WORKLOAD_HINT_COMPUTE<br>
              +#define AMDGPU_CTX_WORKLOAD_INDEX(n)=C2=A0 =C2=A0 =C2=A0 (n =
&gt;&gt;
              AMDGPU_CTX_WORKLOAD_HINT_SHIFT)<br>
              +<br>
              =C2=A0struct drm_amdgpu_ctx_in {<br>
              =C2=A0 =C2=A0 =C2=A0 =C2=A0 /** AMDGPU_CTX_OP_* */<br>
              =C2=A0 =C2=A0 =C2=A0 =C2=A0 __u32=C2=A0 =C2=A0op;<br>
              @@ -281,6 +293,11 @@ union drm_amdgpu_ctx_out {<br>
              =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 __u32=C2=A0 =C2=A0flags;<br>
              =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 __u32=C2=A0 =C2=A0_pad;<br>
              =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } pst=
ate;<br>
              +<br>
              +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struc=
t {<br>
              +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0__u32=C2=A0 =C2=A0flags;<br>
              +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0__u32=C2=A0 =C2=A0_pad;<br>
              +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0} wor=
kload;<br>
              =C2=A0};<br>
              <br>
              =C2=A0union drm_amdgpu_ctx {<br>
              -- <br>
              2.34.1<u></u><u></u></p>
          </blockquote>
        </div>
      </div>
    </blockquote>
    <br>
  </div>

</blockquote></div>

--000000000000a2c49f05f77daa67--
