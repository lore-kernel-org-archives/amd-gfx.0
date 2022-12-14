Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82FC8C4332F
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Dec 2022 23:06:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 97C0310E4BC;
	Wed, 14 Dec 2022 23:06:25 +0000 (UTC)
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com
 [IPv6:2001:4860:4864:20::2e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A9FDB10E4BC
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Dec 2022 23:06:21 +0000 (UTC)
Received: by mail-oa1-x2e.google.com with SMTP id
 586e51a60fabf-144bd860fdbso18810606fac.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Dec 2022 15:06:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=d34q+COdqvAHtLruCKyTQ8oxckz5H+XCWdCniXdKcpU=;
 b=jQA4I7l3RzigLxV+7b06ByTywTyuktl/30pOtcVKRGCVCtCoPIqVFOmfzuULca8nEH
 5WXI1+72vEsOohfuObLPkIN73UKOjpV2E2hxDl9Uptk0mIz9X7AcWMDXgehYlxPS6frS
 vtt441K5DU2Te8c0wC30YBTALyTaa4q/wmqpzJjCWo9/9Y1QDEJ5i4i7ljTqdog2tp9a
 1o/cvlI6AA3UCP38LZhRRAIiuIewmYoRsA5Azbz+lfsGo2FEKhsJ7U1ho4ME+tlGlfeD
 7r+uLsyhhYO9r1NYnoMSNzFvDQT9y4sIz5sCzcFwoQILHBtj8l/duaMBlEQMPI+ALa6U
 n5fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=d34q+COdqvAHtLruCKyTQ8oxckz5H+XCWdCniXdKcpU=;
 b=KB4AYeLPrB9t31ZZRfhgTXLJDcm5w6mdPivi06RFeFPFd5fVirOyDYKNvjLF4qcKar
 RGWmpbIeyMn3+xP9HGAlmf4VyxESyq0mgwEsZbO5xQJvrkJL7q6FmUvhWUo2Xnl9ESj1
 ZvPa51XIM5EAUyxKHWLylepOGGfIdKTCxUFo9fupcSCI23fvs364wFckC113NUs3bNTF
 Dy+WsREZleKo9HEvFbtPlGIeBAaWn+SY8vgrW5g2whaU10TwnOT8kDqAh9dHOKa1QcRL
 xCERc34acKMX7PhWZl8ABD4Vw58Hl6lZ0Zp4LMaZlXqKHqjH4dSMmENaLncPcPJou/kU
 wpLQ==
X-Gm-Message-State: AFqh2koeeh0cO376Dghz870AKYAfDkNepAw3lp/AASbbHISn6lVULkuH
 fs4W/uw4sxXwedT/x9pSR4EPb/biluzUXxfgcV0=
X-Google-Smtp-Source: AMrXdXtf87/C1Lsn/xqtKVhfSTHzJWFOwbiJLKF8sqCg/Nexp6fcKRu3Vok/UTAWkTTF56hsIrgbDSw5LQtso+mordU=
X-Received: by 2002:a05:6870:4687:b0:143:8a81:116c with SMTP id
 a7-20020a056870468700b001438a81116cmr442190oap.96.1671059180900; Wed, 14 Dec
 2022 15:06:20 -0800 (PST)
MIME-Version: 1.0
References: <20221214202141.1721178-1-aurabindo.pillai@amd.com>
 <20221214202141.1721178-6-aurabindo.pillai@amd.com>
 <CADnq5_PKy2+2-5X+zn4Ax2wp1iuiZ7E-r-bQ3cSHifE34FYfRA@mail.gmail.com>
 <2938ab78-3224-4097-f5d1-f64c354e5eb6@amd.com>
 <CADnq5_P83EkSqXxe29diJZ2eJH8-8v308jLRZxJ4f8e7FnEOmw@mail.gmail.com>
 <12eed813-c250-4b14-7497-afbd6a41cf2b@amd.com>
 <CADnq5_OzcwSgC3a5MwX=tdLNAxuSeQiAjei9b6CYq84rhA6ncQ@mail.gmail.com>
 <fb472bf8-0478-0acb-a730-19802277dfdc@amd.com>
In-Reply-To: <fb472bf8-0478-0acb-a730-19802277dfdc@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 14 Dec 2022 18:06:09 -0500
Message-ID: <CADnq5_Pz=JDUaGW3HE17sL0rnkOB9KSVKeNc5u5zn-8QNTNPrQ@mail.gmail.com>
Subject: Re: [PATCH 05/18] drm/amd/display: Use mdelay to avoid crashes
To: Alex Hung <alex.hung@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
Cc: stylon.wang@amd.com, Sunpeng.Li@amd.com, Bhawanpreet.Lakha@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 amd-gfx@lists.freedesktop.org, solomon.chiu@amd.com,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, wayne.lin@amd.com,
 Harry.Wentland@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Dec 14, 2022 at 5:56 PM Alex Hung <alex.hung@amd.com> wrote:
>
>
>
> On 2022-12-14 15:35, Alex Deucher wrote:
> > On Wed, Dec 14, 2022 at 5:25 PM Alex Hung <alex.hung@amd.com> wrote:
> >>
> >>
> >>
> >> On 2022-12-14 14:54, Alex Deucher wrote:
> >>> On Wed, Dec 14, 2022 at 4:50 PM Alex Hung <alex.hung@amd.com> wrote:
> >>>>
> >>>>
> >>>>
> >>>> On 2022-12-14 13:48, Alex Deucher wrote:
> >>>>> On Wed, Dec 14, 2022 at 3:22 PM Aurabindo Pillai
> >>>>> <aurabindo.pillai@amd.com> wrote:
> >>>>>>
> >>>>>> From: Alex Hung <alex.hung@amd.com>
> >>>>>>
> >>>>>> [Why]
> >>>>>> When running IGT kms_bw test with DP monitor, some systems crash f=
rom
> >>>>>> msleep no matter how long or short the time is.
> >>>>>>
> >>>>>> [How]
> >>>>>> To replace msleep with mdelay.
> >>>>>
> >>>>> Can you provide a bit more info about the crash?  A lot of platform=
s
> >>>>> don't support delay larger than 2-4ms so this change will generate
> >>>>> errors on ARM and possibly other platforms.
> >>>>>
> >>>>> Alex
> >>>>
> >>>> The msleep was introduced in eec3303de3378 for non-compliant display
> >>>> port monitors but IGT's kms_bw test can cause a recent h/w to hang a=
t
> >>>> msleep(60) when calling "igt_remove_fb" in IGT
> >>>> (https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2=
Fgitlab.freedesktop.org%2Fdrm%2Figt-gpu-tools%2F-%2Fblob%2Fmaster%2Ftests%2=
Fkms_bw.c%23L197&amp;data=3D05%7C01%7Calex.hung%40amd.com%7Cef40490c3d0f4a0=
448a808dade239493%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C638066541657=
914573%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6=
Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=3Dkx7mnbuN%2BhmIPEgj4l1cue=
k0nvqK16Ig3fWAHopA8CI%3D&amp;reserved=3D0)
> >>>>
> >>>> It is possible to workaround this by reversing order of
> >>>> igt_remove_fb(&buffer[i]), as the following example:
> >>>>
> >>>>      igt_create_color_fb with the order buffer[0], buffer[1], buffer=
[2]
> >>>>
> >>>> Hangs:
> >>>>      igt_remove_fb with the order buffer[0], buffer[1], buffer[2]
> >>>>
> >>>> No hangs:
> >>>>      igt_remove_fb with the reversed order buffer[2], buffer[1], buf=
fer[0]
> >>>>
> >>>> However, IGT simply exposes the problem and it makes more sense to s=
top
> >>>> the hang from occurring.
> >>>>
> >>>> I also tried to remove the msleep completely and it also work, but I
> >>>> didn't want to break the fix for the original problematic hardware
> >>>> configuration.
> >>>
> >>> Why does sleep vs delay make a difference?  Is there some race that w=
e
> >>> are not locking against?
> >>>
> >>> Alex
> >>>
> >>
> >> That was my original thought but I did not find any previously. I will
> >> investigate it again.
> >>
> >> If mdelay(>4) isn't usable on other platforms, is it an option to use
> >> mdelay on x86_64 only and keep msleep on other platforms or just remov=
e
> >> the msleep for other platforms, something like
> >>
> >> -                       msleep(60);
> >> +#ifdef CONFIG_X86_64
> >> +                       mdelay(60);
> >> +#endif
> >
> > That's pretty ugly.  I'd rather try and resolve the root cause.  How
> > important is the IGT test?  What does it do?  Is the test itself
> > correct?
> >
>
> Agreed, and I didn't want to add conditions around the mdelay for the
> same reason. I will assume this is not an option now.
>
> As in the previous comment, IGT can be modified to avoid the crash by
> reversing the order fb is removed - though I suspect I will receive
> questions why this is not fixed in kernel.
>
> I wanted to fix this in kernel because nothing stops other user-space
> applications to use the same way to crash kernel, so fixing IGT is the
> second option.
>
> Apparently causing problems on other platforms isn't an option at all so
> I will try to figure out an non-mdelay solution, and then maybe an IGT
> solution instead.
>

What hangs?  The test or the kernel or the hardware?

Alex


> > Alex
> >
> >
> >>
> >>
> >>>>
> >>>>>
> >>>>>>
> >>>>>> Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
> >>>>>> Signed-off-by: Alex Hung <alex.hung@amd.com>
> >>>>>> Reviewed-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
> >>>>>> ---
> >>>>>>     drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c | =
2 +-
> >>>>>>     1 file changed, 1 insertion(+), 1 deletion(-)
> >>>>>>
> >>>>>> diff --git a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_seque=
ncer.c b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
> >>>>>> index 913a1fe6b3da..e6251ccadb70 100644
> >>>>>> --- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
> >>>>>> +++ b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
> >>>>>> @@ -1215,7 +1215,7 @@ void dce110_blank_stream(struct pipe_ctx *pi=
pe_ctx)
> >>>>>>                             * After output is idle pattern some si=
nks need time to recognize the stream
> >>>>>>                             * has changed or they enter protection=
 state and hang.
> >>>>>>                             */
> >>>>>> -                       msleep(60);
> >>>>>> +                       mdelay(60);
> >>>>>>                    } else if (pipe_ctx->stream->signal =3D=3D SIGN=
AL_TYPE_EDP) {
> >>>>>>                            if (!link->dc->config.edp_no_power_sequ=
encing) {
> >>>>>>                                    /*
> >>>>>> --
> >>>>>> 2.39.0
> >>>>>>
