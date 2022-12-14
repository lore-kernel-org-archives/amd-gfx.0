Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5699AC4332F
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Dec 2022 22:36:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8AEEE10E080;
	Wed, 14 Dec 2022 22:36:04 +0000 (UTC)
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com
 [IPv6:2001:4860:4864:20::30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2AAA910E080
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Dec 2022 22:36:02 +0000 (UTC)
Received: by mail-oa1-x30.google.com with SMTP id
 586e51a60fabf-1445ca00781so18659780fac.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Dec 2022 14:36:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=srUs+yPCePRxpRz1iMR5QCzfYVkU5yOxuMolIqpRhyk=;
 b=hvID2jS8WTm5vAwzXN/0RoocyvvIzNwizBKfqp/dH/4cLijIIficpMXg3sNaubbx1G
 5RIa/3VJTODJ1y9jGyO9R9hC14lBuWFAnXzWwLSD3bADjJ5ldYsK+8zcdgl81xhSH8RW
 0DxM9tYKOhN7RR6o/9LRmx8HqI/bb+cH7U2ERuLeOe9p49R+Vtnq1+AMr1ZFgWA7HbR3
 1pf1lIM0TxKfJ4qRmt7QpYdohJi9LZ2m7I1RM/+i4W7N7vSMFVZxaX7RHuberZgTZSMb
 rJlEuUwxpaoFoS/hhrM5vuBRas66nVwWKEqRtMu7sG+jM2nO0VJIN9oYGvL5at3ffCGd
 VjSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=srUs+yPCePRxpRz1iMR5QCzfYVkU5yOxuMolIqpRhyk=;
 b=II4HiE8zXsoqyNkTSUgVvmD+/hOgVXq5z7HUwqH/K0TRJinTFTs4Xk3HL+bN+jEP7k
 LvFr3VsMsx639oA/9QIG70az5L+S68wi6jvW/rPfBKbA5dN6uYLEDpeIyFlSzOO6gs5I
 tHbx/baVGmS6KNBi1J/CZKmhhcHvSailcxDJ8ZZ/cgxMs/XV2fxX0BwSniZt671XxQ6F
 i6vJW43obX2fxrYcJ1H7M5u1OggmgezxYxPxV6DTr8lhwqFUXsCvajqT8tQWG23HSBzr
 wR8hVfExGY17025bgs91e3JWXQqtTgZcbLpk7Y5FQpBamOZjZduY2e+2Tyu9gNuIwk0S
 pSmA==
X-Gm-Message-State: AFqh2koY2D9npNPrl0aRgyX53DUf5O3EZV+lgLBhkX7PcjR5pxse7Aef
 gsdNnMJl3UcPAyMBngWUherIy622QttyFKu3C+8=
X-Google-Smtp-Source: AA0mqf4WUHn0r3P6Vew8i7CBFn+8ZTQxkkf1+bLlTfSjFW9TJAjeIW7jw7OJ5zbt8UlUxFKE+/uHxCEaMGMy7sQU2TU=
X-Received: by 2002:a05:6870:41cd:b0:148:3c8f:15ab with SMTP id
 z13-20020a05687041cd00b001483c8f15abmr505795oac.46.1671057361344; Wed, 14 Dec
 2022 14:36:01 -0800 (PST)
MIME-Version: 1.0
References: <20221214202141.1721178-1-aurabindo.pillai@amd.com>
 <20221214202141.1721178-6-aurabindo.pillai@amd.com>
 <CADnq5_PKy2+2-5X+zn4Ax2wp1iuiZ7E-r-bQ3cSHifE34FYfRA@mail.gmail.com>
 <2938ab78-3224-4097-f5d1-f64c354e5eb6@amd.com>
 <CADnq5_P83EkSqXxe29diJZ2eJH8-8v308jLRZxJ4f8e7FnEOmw@mail.gmail.com>
 <12eed813-c250-4b14-7497-afbd6a41cf2b@amd.com>
In-Reply-To: <12eed813-c250-4b14-7497-afbd6a41cf2b@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 14 Dec 2022 17:35:49 -0500
Message-ID: <CADnq5_OzcwSgC3a5MwX=tdLNAxuSeQiAjei9b6CYq84rhA6ncQ@mail.gmail.com>
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

On Wed, Dec 14, 2022 at 5:25 PM Alex Hung <alex.hung@amd.com> wrote:
>
>
>
> On 2022-12-14 14:54, Alex Deucher wrote:
> > On Wed, Dec 14, 2022 at 4:50 PM Alex Hung <alex.hung@amd.com> wrote:
> >>
> >>
> >>
> >> On 2022-12-14 13:48, Alex Deucher wrote:
> >>> On Wed, Dec 14, 2022 at 3:22 PM Aurabindo Pillai
> >>> <aurabindo.pillai@amd.com> wrote:
> >>>>
> >>>> From: Alex Hung <alex.hung@amd.com>
> >>>>
> >>>> [Why]
> >>>> When running IGT kms_bw test with DP monitor, some systems crash fro=
m
> >>>> msleep no matter how long or short the time is.
> >>>>
> >>>> [How]
> >>>> To replace msleep with mdelay.
> >>>
> >>> Can you provide a bit more info about the crash?  A lot of platforms
> >>> don't support delay larger than 2-4ms so this change will generate
> >>> errors on ARM and possibly other platforms.
> >>>
> >>> Alex
> >>
> >> The msleep was introduced in eec3303de3378 for non-compliant display
> >> port monitors but IGT's kms_bw test can cause a recent h/w to hang at
> >> msleep(60) when calling "igt_remove_fb" in IGT
> >> (https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fg=
itlab.freedesktop.org%2Fdrm%2Figt-gpu-tools%2F-%2Fblob%2Fmaster%2Ftests%2Fk=
ms_bw.c%23L197&amp;data=3D05%7C01%7Calex.hung%40amd.com%7Cee0c28620f2447f13=
a8f08dade1dc0bc%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C63806651663410=
0466%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik=
1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=3Dmx33srt3RgcA4ZklYVXom9ZQkl=
JjWmcywEtb4qJQVBQ%3D&amp;reserved=3D0)
> >>
> >> It is possible to workaround this by reversing order of
> >> igt_remove_fb(&buffer[i]), as the following example:
> >>
> >>     igt_create_color_fb with the order buffer[0], buffer[1], buffer[2]
> >>
> >> Hangs:
> >>     igt_remove_fb with the order buffer[0], buffer[1], buffer[2]
> >>
> >> No hangs:
> >>     igt_remove_fb with the reversed order buffer[2], buffer[1], buffer=
[0]
> >>
> >> However, IGT simply exposes the problem and it makes more sense to sto=
p
> >> the hang from occurring.
> >>
> >> I also tried to remove the msleep completely and it also work, but I
> >> didn't want to break the fix for the original problematic hardware
> >> configuration.
> >
> > Why does sleep vs delay make a difference?  Is there some race that we
> > are not locking against?
> >
> > Alex
> >
>
> That was my original thought but I did not find any previously. I will
> investigate it again.
>
> If mdelay(>4) isn't usable on other platforms, is it an option to use
> mdelay on x86_64 only and keep msleep on other platforms or just remove
> the msleep for other platforms, something like
>
> -                       msleep(60);
> +#ifdef CONFIG_X86_64
> +                       mdelay(60);
> +#endif

That's pretty ugly.  I'd rather try and resolve the root cause.  How
important is the IGT test?  What does it do?  Is the test itself
correct?

Alex


>
>
> >>
> >>>
> >>>>
> >>>> Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
> >>>> Signed-off-by: Alex Hung <alex.hung@amd.com>
> >>>> Reviewed-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
> >>>> ---
> >>>>    drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c | 2 +=
-
> >>>>    1 file changed, 1 insertion(+), 1 deletion(-)
> >>>>
> >>>> diff --git a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequenc=
er.c b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
> >>>> index 913a1fe6b3da..e6251ccadb70 100644
> >>>> --- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
> >>>> +++ b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
> >>>> @@ -1215,7 +1215,7 @@ void dce110_blank_stream(struct pipe_ctx *pipe=
_ctx)
> >>>>                            * After output is idle pattern some sinks=
 need time to recognize the stream
> >>>>                            * has changed or they enter protection st=
ate and hang.
> >>>>                            */
> >>>> -                       msleep(60);
> >>>> +                       mdelay(60);
> >>>>                   } else if (pipe_ctx->stream->signal =3D=3D SIGNAL_=
TYPE_EDP) {
> >>>>                           if (!link->dc->config.edp_no_power_sequenc=
ing) {
> >>>>                                   /*
> >>>> --
> >>>> 2.39.0
> >>>>
