Return-Path: <SRS0=dANk=CK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3C4DC433E2
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Sep 2020 16:30:39 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AFF2A2065F
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Sep 2020 16:30:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BAYv9bIK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFF2A2065F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 847406E86A;
	Tue,  1 Sep 2020 16:30:38 +0000 (UTC)
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com
 [IPv6:2a00:1450:4864:20::441])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BD4616E86A;
 Tue,  1 Sep 2020 16:30:37 +0000 (UTC)
Received: by mail-wr1-x441.google.com with SMTP id x14so2236184wrl.12;
 Tue, 01 Sep 2020 09:30:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=dJWXvZJM7Rn58/XCux894oNDEA8N0mvrqTZBm36mRD8=;
 b=BAYv9bIKlv5XxzGIg6gQ4IP+lB247VfdzjbsG0AIE6Xa5tHfIgi7s5SNp1TAn6dQ+3
 yyJSGNQJNTU7b3U4q1Db1mzZZyYNVJqpb+3BNi2lCay9ZWcxYxAeXrUKXRCrUsEnb5IC
 vIvE5Bqzlr1pvwvcTVsVEX2JD59ZDJJqlVLqt/AaLcbqN3anmWKTdXzkhiX31VOG9dD2
 iZiuIcP9PYMGizayS5dQy+iWShXEOz2cBmYgHN0JC06ElVtmu/hAskEs6C7X8WTuvAFo
 82AwE458kdU70SwXYGW5tudnXh92/gBdlmAMaS8dGhlqOj3EtzHi+6j5csQF/WhltvFr
 eTlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=dJWXvZJM7Rn58/XCux894oNDEA8N0mvrqTZBm36mRD8=;
 b=hfQX7JIpUUi+kEGzREg3FbtPnWMrltEVd16x8Yq4ITLByziN/rqYPIqLFLfahH3YYz
 9DHlG5J5CipwvfhAzw7xnRVPfVDcMkuRgiiG3V6gknXrAvm+HZ3OG0l25wzlEBsqVMtO
 uJFbG9ZNfEqBUNCXHk7Y5nLHqtE8NBBSY3ANeZOk+Z0uC2Vf2hnKFw2An6N7AMyciXKc
 wwRPL1fxty78Tw8oIKlChV6Sd5kc/IPy/HAJSl9Sgrh59cZSDCaJzzKjEXNA8JqZDG6D
 tdqLdzbqj03koHrqL8WsGG+y4Z6VUB7M9q1AVInFNCHqF5bexoXZjHYxcfhaxbqYkM4g
 MiWw==
X-Gm-Message-State: AOAM530GNT7Ip9dnbEU6WDP3cHDltv1pB+dkN2YgYrI3OJpeXUJjpyvc
 H2GOaXQIJ7XjT4SH3cGbJpBknMqNwOKXEoQZCFE=
X-Google-Smtp-Source: ABdhPJzzSrHT7+gBJQ7wWBvPgJGllAEIrLh9E3aUHR/FsKFXgMIVyTDBs4wzl5zRXelF2y/qR6xaj9Pen/T2mxCXszw=
X-Received: by 2002:adf:ef0a:: with SMTP id e10mr2733473wro.362.1598977836259; 
 Tue, 01 Sep 2020 09:30:36 -0700 (PDT)
MIME-Version: 1.0
References: <20200901063227.6057-1-kai.heng.feng@canonical.com>
 <CADnq5_MXs-=BpMrYVudhHPjTpgs1XUE=GEujpp5AeYy5vWS=YA@mail.gmail.com>
 <3269C99F-2349-4004-8B5F-31A2297A5043@canonical.com>
In-Reply-To: <3269C99F-2349-4004-8B5F-31A2297A5043@canonical.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 1 Sep 2020 12:30:25 -0400
Message-ID: <CADnq5_PMLoL0Zkw8uB+noPJ0buO5aUavDrFGBhBp_GEz8+xBDA@mail.gmail.com>
Subject: Re: [PATCH] drm/radeon: Reset ASIC if suspend is not managed by
 platform firmware
To: Kai-Heng Feng <kai.heng.feng@canonical.com>
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
Cc: David Airlie <airlied@linux.ie>, open list <linux-kernel@vger.kernel.org>,
 "open list:RADEON and AMDGPU DRM DRIVERS" <amd-gfx@lists.freedesktop.org>,
 "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>, "Deucher,
 Alexander" <alexander.deucher@amd.com>,
 Christian Koenig <christian.koenig@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Sep 1, 2020 at 12:21 PM Kai-Heng Feng
<kai.heng.feng@canonical.com> wrote:
>
>
>
> > On Sep 1, 2020, at 22:19, Alex Deucher <alexdeucher@gmail.com> wrote:
> >
> > On Tue, Sep 1, 2020 at 3:32 AM Kai-Heng Feng
> > <kai.heng.feng@canonical.com> wrote:
> >>
> >> Suspend with s2idle or by the following steps cause screen frozen:
> >> # echo devices > /sys/power/pm_test
> >> # echo freeze > /sys/power/mem
> >>
> >> [  289.625461] [drm:uvd_v1_0_ib_test [radeon]] *ERROR* radeon: fence wait timed out.
> >> [  289.625494] [drm:radeon_ib_ring_tests [radeon]] *ERROR* radeon: failed testing IB on ring 5 (-110).
> >>
> >> The issue doesn't happen on traditional S3, probably because firmware or
> >> hardware provides extra power management.
> >>
> >> Inspired by Daniel Drake's patch [1] on amdgpu, using a similar approach
> >> can fix the issue.
> >
> > It doesn't actually fix the issue.  The device is never powered down
> > so you are using more power than you would if you did not suspend in
> > the first place.  The reset just works around the fact that the device
> > is never powered down.
>
> So how do we properly suspend/resume the device without help from platform firmware?

I guess you don't?

Alex


>
> Kai-Heng
>
> >
> > Alex
> >
> >>
> >> [1] https://patchwork.freedesktop.org/patch/335839/
> >>
> >> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> >> ---
> >> drivers/gpu/drm/radeon/radeon_device.c | 3 +++
> >> 1 file changed, 3 insertions(+)
> >>
> >> diff --git a/drivers/gpu/drm/radeon/radeon_device.c b/drivers/gpu/drm/radeon/radeon_device.c
> >> index 266e3cbbd09b..df823b9ad79f 100644
> >> --- a/drivers/gpu/drm/radeon/radeon_device.c
> >> +++ b/drivers/gpu/drm/radeon/radeon_device.c
> >> @@ -33,6 +33,7 @@
> >> #include <linux/slab.h>
> >> #include <linux/vga_switcheroo.h>
> >> #include <linux/vgaarb.h>
> >> +#include <linux/suspend.h>
> >>
> >> #include <drm/drm_cache.h>
> >> #include <drm/drm_crtc_helper.h>
> >> @@ -1643,6 +1644,8 @@ int radeon_suspend_kms(struct drm_device *dev, bool suspend,
> >>                rdev->asic->asic_reset(rdev, true);
> >>                pci_restore_state(dev->pdev);
> >>        } else if (suspend) {
> >> +               if (pm_suspend_no_platform())
> >> +                       rdev->asic->asic_reset(rdev, true);
> >>                /* Shut down the device */
> >>                pci_disable_device(dev->pdev);
> >>                pci_set_power_state(dev->pdev, PCI_D3hot);
> >> --
> >> 2.17.1
> >>
> >> _______________________________________________
> >> dri-devel mailing list
> >> dri-devel@lists.freedesktop.org
> >> https://lists.freedesktop.org/mailman/listinfo/dri-devel
>
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
