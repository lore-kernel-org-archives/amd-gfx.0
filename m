Return-Path: <SRS0=y/UM=I3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85FEBC433E0
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Mar 2021 15:28:28 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F2AC617ED
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Mar 2021 15:28:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F2AC617ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B81C16E436;
	Mon, 29 Mar 2021 15:28:26 +0000 (UTC)
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com
 [IPv6:2607:f8b0:4864:20::32c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C2B2189FD4;
 Mon, 29 Mar 2021 15:28:24 +0000 (UTC)
Received: by mail-ot1-x32c.google.com with SMTP id
 91-20020a9d08640000b0290237d9c40382so12607474oty.12; 
 Mon, 29 Mar 2021 08:28:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=sL+u4G7CrcA6Z+TYaOSWP3JFMaDkhckMWoxhAu6f8eY=;
 b=G0/S0pMQjOWbDYVq3Eg2hpnVRgtSNFukbo80ggQSwyQO7G1V8RbEcV+ahVZmJl0M1X
 2keMHJsikzpjqQOsPFfwkdfoj7JS5vsEAlxWjJ3wy9BYG6k1wUmREvnuJQwEKYVclXis
 hhmQDwPw8dLrI5+VBEgi8u/bjutQHVIsAxfAgdm8sCD+vIxy38vVI6Cn5U5WwqIeUPZM
 VxwPyq9TLmOo9ZwKZr3VH33nd1EVOp9eMaaZYEqP6IrY1CjUHKmnunTBOsFw6WS9At/Q
 CH77zcFrcp4g0kViyGgxFD4Ja5OEarHddizi/5+3kjbeYbd18V5ahKoKu0sZ6TVLKFR3
 sqUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=sL+u4G7CrcA6Z+TYaOSWP3JFMaDkhckMWoxhAu6f8eY=;
 b=lKFHIKxSCgAFi447ZaUPXNt+9nnaEAhE5RyXZBjJz219PYpKWVq3b6976QIzYs1793
 LUW2Ke0GlGRfSttdcIGkIrTOy7UfOVM6TBxp6iLEBSlKJgshd3wtyuO6KeVDEq9q9g4h
 uk/NAfCgJwUtydOdWxFakhsg1XIv1m/WW7Kw4eWrDeSHXa3bcvAg2qpsTTo37B4vCljz
 G36286Du/6YwOIYYfj+Yc4g1az3ecX3+7oZayqzugB27xdj9cg18ykC0ZLXkg0e+SIRA
 0fJ6aYJv0y1UTCFNI+TCFZ/H3HrPcXPTySXE+fK880QraFrJkfq+1TpTKBxqMfwK3dq5
 OFTA==
X-Gm-Message-State: AOAM531Y52CLMR6SlhiZ7xOlPjGddf7ZUS/DE0u4Ev2lvTUNC9VwEQG3
 n03AHXgppF6C78yJ4hAvUOIBsCDPZV93WqUYIv8=
X-Google-Smtp-Source: ABdhPJw14WGwRwjI3JS9f/hgxbza0cAEMKGAJ1wRfH1tTSrMO2vp3Xb4f94nKSRpGzGiFNuddd5MLmhatevZH6uQA5A=
X-Received: by 2002:a9d:d89:: with SMTP id 9mr23556338ots.23.1617031704134;
 Mon, 29 Mar 2021 08:28:24 -0700 (PDT)
MIME-Version: 1.0
References: <20210317151348.11331-1-wse@tuxedocomputers.com>
 <CADnq5_OpJ-2jR4D8xwH93PZKoMWXx8C2yGTkqt7KRrVgph-KvA@mail.gmail.com>
 <53b26416-31d0-6efd-04e9-2a9f34e525b7@amd.com>
In-Reply-To: <53b26416-31d0-6efd-04e9-2a9f34e525b7@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 29 Mar 2021 11:28:13 -0400
Message-ID: <CADnq5_NwuTv5pWiOk_bYdemm+aPi_SNZTYzMLO3ewma-Bkwhkg@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Try YCbCr420 color when YCbCr444 fails
To: Harry Wentland <harry.wentland@amd.com>
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
Cc: "Leo \(Sunpeng\) Li" <sunpeng.li@amd.com>,
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
 Werner Sembach <wse@tuxedocomputers.com>, Dave Airlie <airlied@linux.ie>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>, Daniel Vetter <daniel@ffwll.ch>,
 "Deucher, Alexander" <alexander.deucher@amd.com>,
 "for 3.8" <stable@vger.kernel.org>,
 Christian Koenig <christian.koenig@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Applied.  Thanks!

Alex

On Fri, Mar 26, 2021 at 10:59 AM Harry Wentland <harry.wentland@amd.com> wrote:
>
>
>
> On 2021-03-24 4:23 p.m., Alex Deucher wrote:
> > On Wed, Mar 17, 2021 at 11:25 AM Werner Sembach <wse@tuxedocomputers.com> wrote:
> >>
> >> When encoder validation of a display mode fails, retry with less bandwidth
> >> heavy YCbCr420 color mode, if available. This enables some HDMI 1.4 setups
> >> to support 4k60Hz output, which previously failed silently.
> >>
> >> On some setups, while the monitor and the gpu support display modes with
> >> pixel clocks of up to 600MHz, the link encoder might not. This prevents
> >> YCbCr444 and RGB encoding for 4k60Hz, but YCbCr420 encoding might still be
> >> possible. However, which color mode is used is decided before the link
> >> encoder capabilities are checked. This patch fixes the problem by retrying
> >> to find a display mode with YCbCr420 enforced and using it, if it is
> >> valid.
> >>
> >> Signed-off-by: Werner Sembach <wse@tuxedocomputers.com>
> >> Cc: <stable@vger.kernel.org>
> >
> >
> > This seems reasonable to me.  Harry, Leo, Any objections?
> >
>
> Looks good to me.
>
> Reviewed-by: Harry Wentland <harry.wentland@amd.com>
>
> Harry
>
> > Alex
> >
> >> ---
> >>
> >>  From c9398160caf4ff20e63b8ba3a4366d6ef95c4ac3 Mon Sep 17 00:00:00 2001
> >> From: Werner Sembach <wse@tuxedocomputers.com>
> >> Date: Wed, 17 Mar 2021 12:52:22 +0100
> >> Subject: [PATCH] Retry forcing YCbCr420 color on failed encoder validation
> >>
> >> ---
> >>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 9 +++++++++
> >>   1 file changed, 9 insertions(+)
> >>
> >> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> >> index 961abf1cf040..2d16389b5f1e 100644
> >> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> >> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> >> @@ -5727,6 +5727,15 @@ create_validate_stream_for_sink(struct amdgpu_dm_connector *aconnector,
> >>
> >>          } while (stream == NULL && requested_bpc >= 6);
> >>
> >> +       if (dc_result == DC_FAIL_ENC_VALIDATE && !aconnector->force_yuv420_output) {
> >> +               DRM_DEBUG_KMS("Retry forcing YCbCr420 encoding\n");
> >> +
> >> +               aconnector->force_yuv420_output = true;
> >> +               stream = create_validate_stream_for_sink(aconnector, drm_mode,
> >> +                                               dm_state, old_stream);
> >> +               aconnector->force_yuv420_output = false;
> >> +       }
> >> +
> >>          return stream;
> >>   }
> >>
> >> --
> >> 2.25.1
> >>
> >> _______________________________________________
> >> dri-devel mailing list
> >> dri-devel@lists.freedesktop.org
> >> https://lists.freedesktop.org/mailman/listinfo/dri-devel>
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
