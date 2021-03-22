Return-Path: <SRS0=Az3f=IU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE226C433C1
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Mar 2021 08:20:00 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2EF606192D
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Mar 2021 08:20:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EF606192D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B004A8985A;
	Mon, 22 Mar 2021 08:19:59 +0000 (UTC)
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com
 [IPv6:2a00:1450:4864:20::136])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4CB8C899DC
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Mar 2021 00:12:33 +0000 (UTC)
Received: by mail-lf1-x136.google.com with SMTP id w37so18529646lfu.13
 for <amd-gfx@lists.freedesktop.org>; Sun, 21 Mar 2021 17:12:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=+N+7Ciagtr7IVQ3/iKqMDQJKQGscQk5dJiTJvc9J1ss=;
 b=jkBHW1BMRAO6K3maQ3h1tVFQgiw6CLJZPA5j8Q4u76B3HMv5+7WZ2nNwKXU+PAZjt5
 kcGclsq27PoO6vbUWl3FHeoOQ+F6s59d2XjscUcoG0ESfD1UuwNXJIen95x9jomdgYJW
 sdFeJ67GaHo8AJhCF1P5E6wZqmq0eF+c2t2zw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=+N+7Ciagtr7IVQ3/iKqMDQJKQGscQk5dJiTJvc9J1ss=;
 b=X0e0S2kchcnMNnXY0EeVFflFl9myjb+dChv5tpcL+/alrVvs5aAhsVjOvlfY6D4ByH
 0qRkUqsbVFjoYa2Nln4OZFoDtsAxEq9c4NLDnqGpz1xVeM75VVJ74jEFNAwzjoiu3LQ0
 V3uNihD7KhsyNAEz8UtP/Gah4CNQ5723mWrYOHr74KZ4GTjMuGK7i9EDhA1V/5AypmgN
 Fwyq1tvHXr5Z1yQjmIkLfjbHG9m8LLqmNLR+KTqUdJOP++5+rf9UY2b/oW6Wqpw+iq9n
 GnDODQLrNIvAoPMBMRTFhvrhJ00gopAMFjjZP/+NrLULQSddLwQeX9jUJNVEDcLrtO+B
 DDbA==
X-Gm-Message-State: AOAM533GVV815jBzMlf3cFdTzh+qUTZ6bKc3/yI7EOyUE1zFf4gdd15k
 3LrlG3WCl1jJ/bvXxOKvb2383NLPPlEtGA==
X-Google-Smtp-Source: ABdhPJwvnbWCsEPwzSKVwgdzEi3LJrx9p0iUmlp1cMT9HAGhAVmkVnEzTjV2y+1KLy1g6CQ6tG/5MQ==
X-Received: by 2002:ac2:5144:: with SMTP id q4mr7790183lfd.145.1616371951157; 
 Sun, 21 Mar 2021 17:12:31 -0700 (PDT)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com.
 [209.85.167.47])
 by smtp.gmail.com with ESMTPSA id t16sm1715248ljj.137.2021.03.21.17.12.30
 for <amd-gfx@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 21 Mar 2021 17:12:30 -0700 (PDT)
Received: by mail-lf1-f47.google.com with SMTP id a198so18539556lfd.7
 for <amd-gfx@lists.freedesktop.org>; Sun, 21 Mar 2021 17:12:30 -0700 (PDT)
X-Received: by 2002:a05:6512:3ba3:: with SMTP id
 g35mr7156536lfv.606.1616371949650; 
 Sun, 21 Mar 2021 17:12:29 -0700 (PDT)
MIME-Version: 1.0
References: <20210319164418.1.I5d51cc12776ee8993a1a54089b548952f75ada41@changeid>
 <CADnq5_OguuMsqT7MVC=ieNZm9mqyVUsGpQDHr59BWtBJJUvFoA@mail.gmail.com>
 <54fc883a-c149-3f43-fb79-3cbff13e7b6a@amd.com>
 <CAP8nV8rL6eYSDyQ1jyv267ER8_E+rMBQkza2ZYZvwvdE+=sd3Q@mail.gmail.com>
 <CADnq5_O5AOK7B-3AM-qpPXcWD1LgdpnfLMd8NBds0Jfd_tZCBQ@mail.gmail.com>
In-Reply-To: <CADnq5_O5AOK7B-3AM-qpPXcWD1LgdpnfLMd8NBds0Jfd_tZCBQ@mail.gmail.com>
From: Evan Benn <evanbenn@chromium.org>
Date: Mon, 22 Mar 2021 11:12:03 +1100
X-Gmail-Original-Message-ID: <CAKz_xw0vKSojPqh7QsJPY5eQBLcnteFmL1AJimJTXJmzmQd9kA@mail.gmail.com>
Message-ID: <CAKz_xw0vKSojPqh7QsJPY5eQBLcnteFmL1AJimJTXJmzmQd9kA@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Set AMDGPU_DM_DEFAULT_MIN_BACKLIGHT to 0
To: Alex Deucher <alexdeucher@gmail.com>
X-Mailman-Approved-At: Mon, 22 Mar 2021 08:19:58 +0000
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
Cc: Stylon Wang <stylon.wang@amd.com>, Eryk Brol <eryk.brol@amd.com>,
 David Airlie <airlied@linux.ie>, Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 LKML <linux-kernel@vger.kernel.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>,
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
 Evan Benn <evanbenn@gmail.com>, Alex Deucher <alexander.deucher@amd.com>,
 Harry Wentland <harry.wentland@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Anand <amistry@chromium.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Sat, Mar 20, 2021 at 8:36 AM Alex Deucher <alexdeucher@gmail.com> wrote:
>
> On Fri, Mar 19, 2021 at 5:31 PM Evan Benn <evanbenn@gmail.com> wrote:
> >
> > On Sat, 20 Mar 2021 at 02:10, Harry Wentland <harry.wentland@amd.com> wrote:
> > > On 2021-03-19 10:22 a.m., Alex Deucher wrote:
> > > > On Fri, Mar 19, 2021 at 3:23 AM Evan Benn <evanbenn@chromium.org> wrote:
> > > >>
> > > >> AMDGPU_DM_DEFAULT_MIN_BACKLIGHT was set to the value of 12
> > > >> to ensure no display backlight will flicker at low user brightness
> > > >> settings. However this value is quite bright, so for devices that do not
> > > >> implement the ACPI ATIF
> > > >> ATIF_FUNCTION_QUERY_BRIGHTNESS_TRANSFER_CHARACTERISTICS
> > > >> functionality the user cannot set the brightness to a low level even if
> > > >> the display would support such a low PWM.
> > > >>
> > > >> This ATIF feature is not implemented on for example AMD grunt chromebooks.
> > > >>
> > > >> Signed-off-by: Evan Benn <evanbenn@chromium.org>
> > > >>
> > > >> ---
> > > >> I could not find a justification for the reason for the value. It has
> > > >> caused some noticable regression for users: https://bugzilla.kernel.org/show_bug.cgi?id=203439>>>
> > > >> Maybe this can be either user controlled or userspace configured, but
> > > >> preventing users from turning their backlight dim seems wrong.
> > > >
> > > > My understanding is that some panels flicker if you set the min to a
> > > > value too low.  This was a safe minimum if the platform didn't specify
> > > > it's own safe minimum.  I think we'd just be trading one bug for
> > > > another (flickering vs not dim enough).  Maybe a whitelist or
> > > > blacklist would be a better solution?
> > > >
> > >
> > > Yeah, this is a NACK from me as-is for the reasons Alex described.
> >
> > Thanks Harry + Alex,
> >
> > I agree this solution is not the best.
> >
> > >
> > > I agree a whitelist approach might be best.
> >
> > Do you have any idea what an allowlist could be keyed on?
> > Is the flickering you observed here a function of the panel or the gpu
> > or some other component?
> > Maybe we could move the minimum level into the logic for that hardware.
> >
>
> Maybe the panel string from the EDID?  Either that or something from
> dmi data?  Harry would probably have a better idea.

One problem with keying from panel EDID is that for example the grunt chromebook
platform has more than 100 different panels already shipped. Add to that that
repair centers or people repairing their own device will use 'compatible'
panels. I'm sure the AMD windows laptops have even more variety!

>
> Alex
>
> > >
> > > Is this fix perhaps for OLED panels? If so we could use a different
> > > min-value for OLED panels that don't do PWM, but use 12 for everything else.
> >
> > All the chromebooks I have worked with LCD + LED backlight have been
> > fine with a backlight set to 0.
> > We do have OLED panels too, but I'm not aware of what they do.
> >
> > > Harry
> > >
> > > > Alex
> > > >
> > > >
> > > >>
> > > >> Also reviewed here: https://chromium-review.googlesource.com/c/chromiumos/third_party/kernel/+/2748377>>>
> > > >>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 2 +-
> > > >>   1 file changed, 1 insertion(+), 1 deletion(-)
> > > >>
> > > >> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > > >> index 573cf17262da..0129bd69b94e 100644
> > > >> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > > >> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > > >> @@ -3151,7 +3151,7 @@ static int amdgpu_dm_mode_config_init(struct amdgpu_device *adev)
> > > >>          return 0;
> > > >>   }
> > > >>
> > > >> -#define AMDGPU_DM_DEFAULT_MIN_BACKLIGHT 12
> > > >> +#define AMDGPU_DM_DEFAULT_MIN_BACKLIGHT 0
> > > >>   #define AMDGPU_DM_DEFAULT_MAX_BACKLIGHT 255
> > > >>   #define AUX_BL_DEFAULT_TRANSITION_TIME_MS 50
> > > >>
> > > >> --
> > > >> 2.31.0.291.g576ba9dcdaf-goog
> > > >>
> > > >> _______________________________________________
> > > >> dri-devel mailing list
> > > >> dri-devel@lists.freedesktop.org
> > > >> https://lists.freedesktop.org/mailman/listinfo/dri-devel>> _______________________________________________
> > > > dri-devel mailing list
> > > > dri-devel@lists.freedesktop.org
> > > > https://lists.freedesktop.org/mailman/listinfo/dri-devel>>
> > >
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
