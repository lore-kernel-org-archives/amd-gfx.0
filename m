Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0C5CC6FD1C
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Mar 2023 15:12:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5B4B910E376;
	Wed, 22 Mar 2023 15:12:03 +0000 (UTC)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5EDF910E376
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Mar 2023 15:12:00 +0000 (UTC)
Received: by mail-ed1-x52b.google.com with SMTP id r11so74344625edd.5
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Mar 2023 08:12:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20210112; t=1679497919;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=VwLh9yj4Mn+6gQpe7BvJehy/L2DZ/CxKYdIEQID2BwI=;
 b=UbU5dYg3FJts0EVPsTGV0zJTBdsW5Yf8YkmDEEra9ZTSky1yYHHhjTxR/4L8RJFcT9
 wzTQgAdubtIaNa9Yp5eKmbzRxUcTIKoXhj0XpLubD3UbKjdvZmAnO5Zm7hGvAOj5S8fx
 vZaheig374/f5nIGTTcV1A6o+HgLlyfnfjCTZEP2g80flNeyAYoqBbt2RcfopDlF3Qp9
 y1W5PF4TsbYPlYvRX6WIkpmutTSwILmg1lND80KH0NDrRmbIDFy/kONy541pMCzjeTct
 RLoYIxsm151N7Y8I0L9cpeo8m5lV0PFxD5iSXDsBJu5VWAlpHWmIJC3LrQXJLnkmT0di
 dlfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1679497919;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VwLh9yj4Mn+6gQpe7BvJehy/L2DZ/CxKYdIEQID2BwI=;
 b=gp1jr6YohFFROAAn7/j6Z3iRInxEwW3kpWrfjjBkvcm5mdvLOCkOW+kMVFmfEv+u+0
 Tffbu0ACyaK7BgR/OovD7o7uThMVjmV5ToPMCW2AVM/eOEZUthjPzcHs6om7bMdeg+CE
 LAVxUq6QX1feqbnjEGNsIHxFYHjxw3SAYd6TKh1+h5cx/GMLgcaw11reCUxSlVkCMGPt
 /ATStfu8cSJ8RpEogiVL/s7Wa84EVvHksP/urPT5ggpMt2T81QCC+4ckiCEHrSKCs57t
 L70aNLdU724Rl9XWB3TXRJVFZiGnipCS6fONaMsec+TiK24Hr35qNLiyoMv8Idc1wtv8
 jkkA==
X-Gm-Message-State: AO0yUKXb9qPortnPCXyvvkhAK8bDls6Rylb2Ls23EqZKYIMfn0m6poT/
 mlRbwSInEeurGJYVPdJqYliMJ6xLowfmu/7pc/Zg/exa
X-Google-Smtp-Source: AK7set8V5d3vaM0JU/gLabvUIflr3mjVNycmZRa4c3D/KXtl6GJG05DEIaHLhT0vjDk9QEmvH6u1vGVbes7dVlqW0Zo=
X-Received: by 2002:a50:d597:0:b0:4fb:e0e8:5140 with SMTP id
 v23-20020a50d597000000b004fbe0e85140mr3712575edi.6.1679497918690; Wed, 22 Mar
 2023 08:11:58 -0700 (PDT)
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
 <CAAxE2A7qaVseu8zJRe=2T0QobsT_SErrLS+s0D50CJPkCiVedQ@mail.gmail.com>
 <CADnq5_McsW5Xthrhn2YNWHZQwsgXTW46HaSZM5-+=-YNpe5fDQ@mail.gmail.com>
In-Reply-To: <CADnq5_McsW5Xthrhn2YNWHZQwsgXTW46HaSZM5-+=-YNpe5fDQ@mail.gmail.com>
From: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>
Date: Wed, 22 Mar 2023 11:11:22 -0400
Message-ID: <CAAxE2A4ZQuZPp2+qssiuT2G3BQ19Z_F1NNKCkAG4XiF2qxD6aw@mail.gmail.com>
Subject: Re: [PATCH v3 1/5] drm/amdgpu: add UAPI for workload hints to ctx
 ioctl
To: Alex Deucher <alexdeucher@gmail.com>
Content-Type: multipart/alternative; boundary="000000000000d8374605f77e9483"
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
Cc: "Sharma, Shashank" <Shashank.Sharma@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 "Somalapuram, Amaranath" <Amaranath.Somalapuram@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--000000000000d8374605f77e9483
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

The uapi would make sense if somebody wrote and implemented a Vulkan
extension exposing the hints and if we had customers who require that
extension. Without that, userspace knows almost nothing. If anything, this
effort should be led by our customers especially in the case of Vulkan
(writing the extension spec, etc.)

This is not a stack issue as much as it is an interface designed around
Windows that doesn't fit Linux, and for that reason, putting into uapi in
the current form doesn't seem to be a good idea.

Marek

On Wed, Mar 22, 2023 at 10:52=E2=80=AFAM Alex Deucher <alexdeucher@gmail.co=
m> wrote:

> On Wed, Mar 22, 2023 at 10:37=E2=80=AFAM Marek Ol=C5=A1=C3=A1k <maraeo@gm=
ail.com> wrote:
> >
> > It sounds like the kernel should set the hint based on which queues are
> used, so that every UMD doesn't have to duplicate the same logic.
>
> Userspace has a better idea of what they are doing than the kernel.
> That said, we already set the video hint in the kernel when we submit
> work to VCN/UVD/VCE and we already set hint COMPUTE when user queues
> are active in ROCm because user queues don't go through the kernel.  I
> guess we could just set 3D by default.  On windows there is a separate
> API for fullscreen 3D games so 3D is only enabled in that case.  I
> assumed UMDs would want to select a hint, but maybe we should just
> select the kernel set something.  I figured vulkan or OpenGL would
> select 3D vs COMPUTE depending on what queues/extensions the app uses.
>
> Thinking about it more, if we do keep the hints, maybe it makes more
> sense to select the hint at context init.  Then we can set the hint to
> the hardware at context init time.  If multiple hints come in from
> different contexts we'll automatically select the most aggressive one.
> That would also be compatible with user mode queues.
>
> Alex
>
> >
> > Marek
> >
> > On Wed, Mar 22, 2023 at 10:29=E2=80=AFAM Christian K=C3=B6nig <
> christian.koenig@amd.com> wrote:
> >>
> >> Well that sounds like being able to optionally set it after context
> creation is actually the right approach.
> >>
> >> VA-API could set it as soon as we know that this is a video codec
> application.
> >>
> >> Vulkan can set it depending on what features are used by the
> application.
> >>
> >> But yes, Shashank (or whoever requested that) should come up with some
> code for Mesa to actually use it. Otherwise we don't have the justificati=
on
> to push it into the kernel driver.
> >>
> >> Christian.
> >>
> >> Am 22.03.23 um 15:24 schrieb Marek Ol=C5=A1=C3=A1k:
> >>
> >> The hint is static per API (one of graphics, video, compute, unknown).
> In the case of Vulkan, which exposes all queues, the hint is unknown, so
> Vulkan won't use it. (or make it based on the queue being used and not th=
e
> uapi context state) GL won't use it because the default hint is already 3=
D.
> That makes VAAPI the only user that only sets the hint once, and maybe it=
's
> not worth even adding this uapi just for VAAPI.
> >>
> >> Marek
> >>
> >> On Wed, Mar 22, 2023 at 10:08=E2=80=AFAM Christian K=C3=B6nig <
> christian.koenig@amd.com> wrote:
> >>>
> >>> Well completely agree that we shouldn't have unused API. That's why I
> said we should remove the getting the hint from the UAPI.
> >>>
> >>> But what's wrong with setting it after creating the context? Don't yo=
u
> know enough about the use case? I need to understand the background a bit
> better here.
> >>>
> >>> Christian.
> >>>
> >>> Am 22.03.23 um 15:05 schrieb Marek Ol=C5=A1=C3=A1k:
> >>>
> >>> The option to change the hint after context creation and get the hint
> would be unused uapi, and AFAIK we are not supposed to add unused uapi.
> What I asked is to change it to a uapi that userspace will actually use.
> >>>
> >>> Marek
> >>>
> >>> On Tue, Mar 21, 2023 at 9:54=E2=80=AFAM Christian K=C3=B6nig <
> ckoenig.leichtzumerken@gmail.com> wrote:
> >>>>
> >>>> Yes, I would like to avoid having multiple code paths for context
> creation.
> >>>>
> >>>> Setting it later on should be equally to specifying it on creation
> since we only need it during CS.
> >>>>
> >>>> Regards,
> >>>> Christian.
> >>>>
> >>>> Am 21.03.23 um 14:00 schrieb Sharma, Shashank:
> >>>>
> >>>> [AMD Official Use Only - General]
> >>>>
> >>>>
> >>>>
> >>>> When we started this patch series, the workload hint was a part of
> the ctx_flag only,
> >>>>
> >>>> But we changed that after the design review, to make it more like ho=
w
> we are handling PSTATE.
> >>>>
> >>>>
> >>>>
> >>>> Details:
> >>>>
> >>>> https://patchwork.freedesktop.org/patch/496111/
> >>>>
> >>>>
> >>>>
> >>>> Regards
> >>>>
> >>>> Shashank
> >>>>
> >>>>
> >>>>
> >>>> From: Marek Ol=C5=A1=C3=A1k <maraeo@gmail.com>
> >>>> Sent: 21 March 2023 04:05
> >>>> To: Sharma, Shashank <Shashank.Sharma@amd.com>
> >>>> Cc: amd-gfx@lists.freedesktop.org; Deucher, Alexander <
> Alexander.Deucher@amd.com>; Somalapuram, Amaranath <
> Amaranath.Somalapuram@amd.com>; Koenig, Christian <
> Christian.Koenig@amd.com>
> >>>> Subject: Re: [PATCH v3 1/5] drm/amdgpu: add UAPI for workload hints
> to ctx ioctl
> >>>>
> >>>>
> >>>>
> >>>> I think we should do it differently because this interface will be
> mostly unused by open source userspace in its current form.
> >>>>
> >>>>
> >>>>
> >>>> Let's set the workload hint in drm_amdgpu_ctx_in::flags, and that
> will be immutable for the lifetime of the context. No other interface is
> needed.
> >>>>
> >>>>
> >>>>
> >>>> Marek
> >>>>
> >>>>
> >>>>
> >>>> On Mon, Sep 26, 2022 at 5:41=E2=80=AFPM Shashank Sharma <
> shashank.sharma@amd.com> wrote:
> >>>>
> >>>> Allow the user to specify a workload hint to the kernel.
> >>>> We can use these to tweak the dpm heuristics to better match
> >>>> the workload for improved performance.
> >>>>
> >>>> V3: Create only set() workload UAPI (Christian)
> >>>>
> >>>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> >>>> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
> >>>> ---
> >>>>  include/uapi/drm/amdgpu_drm.h | 17 +++++++++++++++++
> >>>>  1 file changed, 17 insertions(+)
> >>>>
> >>>> diff --git a/include/uapi/drm/amdgpu_drm.h
> b/include/uapi/drm/amdgpu_drm.h
> >>>> index c2c9c674a223..23d354242699 100644
> >>>> --- a/include/uapi/drm/amdgpu_drm.h
> >>>> +++ b/include/uapi/drm/amdgpu_drm.h
> >>>> @@ -212,6 +212,7 @@ union drm_amdgpu_bo_list {
> >>>>  #define AMDGPU_CTX_OP_QUERY_STATE2     4
> >>>>  #define AMDGPU_CTX_OP_GET_STABLE_PSTATE        5
> >>>>  #define AMDGPU_CTX_OP_SET_STABLE_PSTATE        6
> >>>> +#define AMDGPU_CTX_OP_SET_WORKLOAD_PROFILE     7
> >>>>
> >>>>  /* GPU reset status */
> >>>>  #define AMDGPU_CTX_NO_RESET            0
> >>>> @@ -252,6 +253,17 @@ union drm_amdgpu_bo_list {
> >>>>  #define AMDGPU_CTX_STABLE_PSTATE_MIN_MCLK  3
> >>>>  #define AMDGPU_CTX_STABLE_PSTATE_PEAK  4
> >>>>
> >>>> +/* GPU workload hints, flag bits 8-15 */
> >>>> +#define AMDGPU_CTX_WORKLOAD_HINT_SHIFT     8
> >>>> +#define AMDGPU_CTX_WORKLOAD_HINT_MASK      (0xff <<
> AMDGPU_CTX_WORKLOAD_HINT_SHIFT)
> >>>> +#define AMDGPU_CTX_WORKLOAD_HINT_NONE      (0 <<
> AMDGPU_CTX_WORKLOAD_HINT_SHIFT)
> >>>> +#define AMDGPU_CTX_WORKLOAD_HINT_3D        (1 <<
> AMDGPU_CTX_WORKLOAD_HINT_SHIFT)
> >>>> +#define AMDGPU_CTX_WORKLOAD_HINT_VIDEO     (2 <<
> AMDGPU_CTX_WORKLOAD_HINT_SHIFT)
> >>>> +#define AMDGPU_CTX_WORKLOAD_HINT_VR        (3 <<
> AMDGPU_CTX_WORKLOAD_HINT_SHIFT)
> >>>> +#define AMDGPU_CTX_WORKLOAD_HINT_COMPUTE   (4 <<
> AMDGPU_CTX_WORKLOAD_HINT_SHIFT)
> >>>> +#define AMDGPU_CTX_WORKLOAD_HINT_MAX
> AMDGPU_CTX_WORKLOAD_HINT_COMPUTE
> >>>> +#define AMDGPU_CTX_WORKLOAD_INDEX(n)      (n >>
> AMDGPU_CTX_WORKLOAD_HINT_SHIFT)
> >>>> +
> >>>>  struct drm_amdgpu_ctx_in {
> >>>>         /** AMDGPU_CTX_OP_* */
> >>>>         __u32   op;
> >>>> @@ -281,6 +293,11 @@ union drm_amdgpu_ctx_out {
> >>>>                         __u32   flags;
> >>>>                         __u32   _pad;
> >>>>                 } pstate;
> >>>> +
> >>>> +               struct {
> >>>> +                       __u32   flags;
> >>>> +                       __u32   _pad;
> >>>> +               } workload;
> >>>>  };
> >>>>
> >>>>  union drm_amdgpu_ctx {
> >>>> --
> >>>> 2.34.1
> >>>>
> >>>>
> >>>
> >>
>

--000000000000d8374605f77e9483
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>The uapi would make sense if somebody wrote and imple=
mented a Vulkan extension exposing the hints and if we had customers who re=
quire that extension. Without that, userspace knows almost nothing. If anyt=
hing, this effort should be led by our customers especially in the case of =
Vulkan (writing the extension spec, etc.)</div><div><br></div><div>This is =
not a stack issue as much as it is an interface designed around Windows tha=
t doesn&#39;t fit Linux, and for that reason, putting into uapi in the curr=
ent form doesn&#39;t seem to be a good idea.<br></div><div><br></div><div>M=
arek<br></div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=
=3D"gmail_attr">On Wed, Mar 22, 2023 at 10:52=E2=80=AFAM Alex Deucher &lt;<=
a href=3D"mailto:alexdeucher@gmail.com" target=3D"_blank">alexdeucher@gmail=
.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"mar=
gin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1=
ex">On Wed, Mar 22, 2023 at 10:37=E2=80=AFAM Marek Ol=C5=A1=C3=A1k &lt;<a h=
ref=3D"mailto:maraeo@gmail.com" target=3D"_blank">maraeo@gmail.com</a>&gt; =
wrote:<br>
&gt;<br>
&gt; It sounds like the kernel should set the hint based on which queues ar=
e used, so that every UMD doesn&#39;t have to duplicate the same logic.<br>
<br>
Userspace has a better idea of what they are doing than the kernel.<br>
That said, we already set the video hint in the kernel when we submit<br>
work to VCN/UVD/VCE and we already set hint COMPUTE when user queues<br>
are active in ROCm because user queues don&#39;t go through the kernel.=C2=
=A0 I<br>
guess we could just set 3D by default.=C2=A0 On windows there is a separate=
<br>
API for fullscreen 3D games so 3D is only enabled in that case.=C2=A0 I<br>
assumed UMDs would want to select a hint, but maybe we should just<br>
select the kernel set something.=C2=A0 I figured vulkan or OpenGL would<br>
select 3D vs COMPUTE depending on what queues/extensions the app uses.<br>
<br>
Thinking about it more, if we do keep the hints, maybe it makes more<br>
sense to select the hint at context init.=C2=A0 Then we can set the hint to=
<br>
the hardware at context init time.=C2=A0 If multiple hints come in from<br>
different contexts we&#39;ll automatically select the most aggressive one.<=
br>
That would also be compatible with user mode queues.<br>
<br>
Alex<br>
<br>
&gt;<br>
&gt; Marek<br>
&gt;<br>
&gt; On Wed, Mar 22, 2023 at 10:29=E2=80=AFAM Christian K=C3=B6nig &lt;<a h=
ref=3D"mailto:christian.koenig@amd.com" target=3D"_blank">christian.koenig@=
amd.com</a>&gt; wrote:<br>
&gt;&gt;<br>
&gt;&gt; Well that sounds like being able to optionally set it after contex=
t creation is actually the right approach.<br>
&gt;&gt;<br>
&gt;&gt; VA-API could set it as soon as we know that this is a video codec =
application.<br>
&gt;&gt;<br>
&gt;&gt; Vulkan can set it depending on what features are used by the appli=
cation.<br>
&gt;&gt;<br>
&gt;&gt; But yes, Shashank (or whoever requested that) should come up with =
some code for Mesa to actually use it. Otherwise we don&#39;t have the just=
ification to push it into the kernel driver.<br>
&gt;&gt;<br>
&gt;&gt; Christian.<br>
&gt;&gt;<br>
&gt;&gt; Am 22.03.23 um 15:24 schrieb Marek Ol=C5=A1=C3=A1k:<br>
&gt;&gt;<br>
&gt;&gt; The hint is static per API (one of graphics, video, compute, unkno=
wn). In the case of Vulkan, which exposes all queues, the hint is unknown, =
so Vulkan won&#39;t use it. (or make it based on the queue being used and n=
ot the uapi context state) GL won&#39;t use it because the default hint is =
already 3D. That makes VAAPI the only user that only sets the hint once, an=
d maybe it&#39;s not worth even adding this uapi just for VAAPI.<br>
&gt;&gt;<br>
&gt;&gt; Marek<br>
&gt;&gt;<br>
&gt;&gt; On Wed, Mar 22, 2023 at 10:08=E2=80=AFAM Christian K=C3=B6nig &lt;=
<a href=3D"mailto:christian.koenig@amd.com" target=3D"_blank">christian.koe=
nig@amd.com</a>&gt; wrote:<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Well completely agree that we shouldn&#39;t have unused API. T=
hat&#39;s why I said we should remove the getting the hint from the UAPI.<b=
r>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; But what&#39;s wrong with setting it after creating the contex=
t? Don&#39;t you know enough about the use case? I need to understand the b=
ackground a bit better here.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Christian.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Am 22.03.23 um 15:05 schrieb Marek Ol=C5=A1=C3=A1k:<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; The option to change the hint after context creation and get t=
he hint would be unused uapi, and AFAIK we are not supposed to add unused u=
api. What I asked is to change it to a uapi that userspace will actually us=
e.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Marek<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; On Tue, Mar 21, 2023 at 9:54=E2=80=AFAM Christian K=C3=B6nig &=
lt;<a href=3D"mailto:ckoenig.leichtzumerken@gmail.com" target=3D"_blank">ck=
oenig.leichtzumerken@gmail.com</a>&gt; wrote:<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; Yes, I would like to avoid having multiple code paths for =
context creation.<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; Setting it later on should be equally to specifying it on =
creation since we only need it during CS.<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; Regards,<br>
&gt;&gt;&gt;&gt; Christian.<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; Am 21.03.23 um 14:00 schrieb Sharma, Shashank:<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; [AMD Official Use Only - General]<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; When we started this patch series, the workload hint was a=
 part of the ctx_flag only,<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; But we changed that after the design review, to make it mo=
re like how we are handling PSTATE.<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; Details:<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; <a href=3D"https://patchwork.freedesktop.org/patch/496111/=
" rel=3D"noreferrer" target=3D"_blank">https://patchwork.freedesktop.org/pa=
tch/496111/</a><br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; Regards<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; Shashank<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; From: Marek Ol=C5=A1=C3=A1k &lt;<a href=3D"mailto:maraeo@g=
mail.com" target=3D"_blank">maraeo@gmail.com</a>&gt;<br>
&gt;&gt;&gt;&gt; Sent: 21 March 2023 04:05<br>
&gt;&gt;&gt;&gt; To: Sharma, Shashank &lt;<a href=3D"mailto:Shashank.Sharma=
@amd.com" target=3D"_blank">Shashank.Sharma@amd.com</a>&gt;<br>
&gt;&gt;&gt;&gt; Cc: <a href=3D"mailto:amd-gfx@lists.freedesktop.org" targe=
t=3D"_blank">amd-gfx@lists.freedesktop.org</a>; Deucher, Alexander &lt;<a h=
ref=3D"mailto:Alexander.Deucher@amd.com" target=3D"_blank">Alexander.Deuche=
r@amd.com</a>&gt;; Somalapuram, Amaranath &lt;<a href=3D"mailto:Amaranath.S=
omalapuram@amd.com" target=3D"_blank">Amaranath.Somalapuram@amd.com</a>&gt;=
; Koenig, Christian &lt;<a href=3D"mailto:Christian.Koenig@amd.com" target=
=3D"_blank">Christian.Koenig@amd.com</a>&gt;<br>
&gt;&gt;&gt;&gt; Subject: Re: [PATCH v3 1/5] drm/amdgpu: add UAPI for workl=
oad hints to ctx ioctl<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; I think we should do it differently because this interface=
 will be mostly unused by open source userspace in its current form.<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; Let&#39;s set the workload hint in drm_amdgpu_ctx_in::flag=
s, and that will be immutable for the lifetime of the context. No other int=
erface is needed.<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; Marek<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; On Mon, Sep 26, 2022 at 5:41=E2=80=AFPM Shashank Sharma &l=
t;<a href=3D"mailto:shashank.sharma@amd.com" target=3D"_blank">shashank.sha=
rma@amd.com</a>&gt; wrote:<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; Allow the user to specify a workload hint to the kernel.<b=
r>
&gt;&gt;&gt;&gt; We can use these to tweak the dpm heuristics to better mat=
ch<br>
&gt;&gt;&gt;&gt; the workload for improved performance.<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; V3: Create only set() workload UAPI (Christian)<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; Signed-off-by: Alex Deucher &lt;<a href=3D"mailto:alexande=
r.deucher@amd.com" target=3D"_blank">alexander.deucher@amd.com</a>&gt;<br>
&gt;&gt;&gt;&gt; Signed-off-by: Shashank Sharma &lt;<a href=3D"mailto:shash=
ank.sharma@amd.com" target=3D"_blank">shashank.sharma@amd.com</a>&gt;<br>
&gt;&gt;&gt;&gt; ---<br>
&gt;&gt;&gt;&gt;=C2=A0 include/uapi/drm/amdgpu_drm.h | 17 +++++++++++++++++=
<br>
&gt;&gt;&gt;&gt;=C2=A0 1 file changed, 17 insertions(+)<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/=
drm/amdgpu_drm.h<br>
&gt;&gt;&gt;&gt; index c2c9c674a223..23d354242699 100644<br>
&gt;&gt;&gt;&gt; --- a/include/uapi/drm/amdgpu_drm.h<br>
&gt;&gt;&gt;&gt; +++ b/include/uapi/drm/amdgpu_drm.h<br>
&gt;&gt;&gt;&gt; @@ -212,6 +212,7 @@ union drm_amdgpu_bo_list {<br>
&gt;&gt;&gt;&gt;=C2=A0 #define AMDGPU_CTX_OP_QUERY_STATE2=C2=A0 =C2=A0 =C2=
=A04<br>
&gt;&gt;&gt;&gt;=C2=A0 #define AMDGPU_CTX_OP_GET_STABLE_PSTATE=C2=A0 =C2=A0=
 =C2=A0 =C2=A0 5<br>
&gt;&gt;&gt;&gt;=C2=A0 #define AMDGPU_CTX_OP_SET_STABLE_PSTATE=C2=A0 =C2=A0=
 =C2=A0 =C2=A0 6<br>
&gt;&gt;&gt;&gt; +#define AMDGPU_CTX_OP_SET_WORKLOAD_PROFILE=C2=A0 =C2=A0 =
=C2=A07<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;=C2=A0 /* GPU reset status */<br>
&gt;&gt;&gt;&gt;=C2=A0 #define AMDGPU_CTX_NO_RESET=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 0<br>
&gt;&gt;&gt;&gt; @@ -252,6 +253,17 @@ union drm_amdgpu_bo_list {<br>
&gt;&gt;&gt;&gt;=C2=A0 #define AMDGPU_CTX_STABLE_PSTATE_MIN_MCLK=C2=A0 3<br=
>
&gt;&gt;&gt;&gt;=C2=A0 #define AMDGPU_CTX_STABLE_PSTATE_PEAK=C2=A0 4<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; +/* GPU workload hints, flag bits 8-15 */<br>
&gt;&gt;&gt;&gt; +#define AMDGPU_CTX_WORKLOAD_HINT_SHIFT=C2=A0 =C2=A0 =C2=
=A08<br>
&gt;&gt;&gt;&gt; +#define AMDGPU_CTX_WORKLOAD_HINT_MASK=C2=A0 =C2=A0 =C2=A0=
 (0xff &lt;&lt; AMDGPU_CTX_WORKLOAD_HINT_SHIFT)<br>
&gt;&gt;&gt;&gt; +#define AMDGPU_CTX_WORKLOAD_HINT_NONE=C2=A0 =C2=A0 =C2=A0=
 (0 &lt;&lt; AMDGPU_CTX_WORKLOAD_HINT_SHIFT)<br>
&gt;&gt;&gt;&gt; +#define AMDGPU_CTX_WORKLOAD_HINT_3D=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 (1 &lt;&lt; AMDGPU_CTX_WORKLOAD_HINT_SHIFT)<br>
&gt;&gt;&gt;&gt; +#define AMDGPU_CTX_WORKLOAD_HINT_VIDEO=C2=A0 =C2=A0 =C2=
=A0(2 &lt;&lt; AMDGPU_CTX_WORKLOAD_HINT_SHIFT)<br>
&gt;&gt;&gt;&gt; +#define AMDGPU_CTX_WORKLOAD_HINT_VR=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 (3 &lt;&lt; AMDGPU_CTX_WORKLOAD_HINT_SHIFT)<br>
&gt;&gt;&gt;&gt; +#define AMDGPU_CTX_WORKLOAD_HINT_COMPUTE=C2=A0 =C2=A0(4 &=
lt;&lt; AMDGPU_CTX_WORKLOAD_HINT_SHIFT)<br>
&gt;&gt;&gt;&gt; +#define AMDGPU_CTX_WORKLOAD_HINT_MAX=C2=A0 =C2=A0 =C2=A0 =
AMDGPU_CTX_WORKLOAD_HINT_COMPUTE<br>
&gt;&gt;&gt;&gt; +#define AMDGPU_CTX_WORKLOAD_INDEX(n)=C2=A0 =C2=A0 =C2=A0 =
(n &gt;&gt; AMDGPU_CTX_WORKLOAD_HINT_SHIFT)<br>
&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt;=C2=A0 struct drm_amdgpu_ctx_in {<br>
&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/** AMDGPU_CTX_OP_* */<br=
>
&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0__u32=C2=A0 =C2=A0op;<br>
&gt;&gt;&gt;&gt; @@ -281,6 +293,11 @@ union drm_amdgpu_ctx_out {<br>
&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0__u32=C2=A0 =C2=A0flags;<br>
&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0__u32=C2=A0 =C2=A0_pad;<br>
&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0} pstate;<br>
&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0st=
ruct {<br>
&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0__u32=C2=A0 =C2=A0flags;<br>
&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0__u32=C2=A0 =C2=A0_pad;<br>
&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0} =
workload;<br>
&gt;&gt;&gt;&gt;=C2=A0 };<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;=C2=A0 union drm_amdgpu_ctx {<br>
&gt;&gt;&gt;&gt; --<br>
&gt;&gt;&gt;&gt; 2.34.1<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;<br>
&gt;&gt;<br>
</blockquote></div>

--000000000000d8374605f77e9483--
