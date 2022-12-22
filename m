Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18DF4C001B2
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Dec 2022 16:42:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E577A10E548;
	Thu, 22 Dec 2022 16:42:54 +0000 (UTC)
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com
 [209.85.219.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 62C7810E548
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Dec 2022 16:42:52 +0000 (UTC)
Received: by mail-qv1-f48.google.com with SMTP id i12so1585414qvs.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Dec 2022 08:42:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fSG4zYUj7P9Kgd+tx/TGwxdJYqamamppxaq2ATrBM24=;
 b=tskY0afMqyoAlQp8pAnMs6HHKmix9s1o0eOdbvjCHz/ytQqA1f5RFu532kn+i+UQHZ
 L3XrHDehDYTxRI9EqhGVSK7p8GHFndqE9iAhtSf6WsxEi/4Hzqg/rghMQfbApzFx8hmu
 lK8U4Wknlzl2tDrxaDNJABemIfq4kxm5IFL+DvjbeoMiJqOivYDpSl9jRXXPRZWDoGpy
 3pkKBmiOhquH16cN2Etks+AfSb5ATGRmon0+UgGomWlIF41UQm95iluqwu3E//o3zuGH
 BOxoAYJt1Zw2SMXD/LyUxoE3irdiviayOyyjgFxsmHCfAqAvOIsrNW9pQFeDDsyv3pdk
 Kt6g==
X-Gm-Message-State: AFqh2koEmYRbEPwBEorE+satvO5fqqvD9PkrtnVTTnBWdBUSSZB74yPZ
 /rA3utrElRN1Rd+2GghUQsoAnvNtI70WCQvsVxQ=
X-Google-Smtp-Source: AMrXdXsZFdpO33sUccLBgM5DQFt0F7BiKU2fEqrR0SD5IJsittclD8nA5IuXCdJ3dQ7XhNJeW4xjYbPfDTTeKPBigjQ=
X-Received: by 2002:a0c:c345:0:b0:4c7:27cf:dfca with SMTP id
 j5-20020a0cc345000000b004c727cfdfcamr270636qvi.3.1671727371530; Thu, 22 Dec
 2022 08:42:51 -0800 (PST)
MIME-Version: 1.0
References: <20221208164207.13518-1-mario.limonciello@amd.com>
 <MN0PR12MB61014F8D6D5B04B90997480DE2E19@MN0PR12MB6101.namprd12.prod.outlook.com>
 <CAJZ5v0hm00E4xNC6r9MieOTFtdchQHj9k8a34fk-0Oi6UzwLQA@mail.gmail.com>
In-Reply-To: <CAJZ5v0hm00E4xNC6r9MieOTFtdchQHj9k8a34fk-0Oi6UzwLQA@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 22 Dec 2022 17:42:40 +0100
Message-ID: <CAJZ5v0g8eF5B1D0qUGMXeSuMBenCJ4NixHALPpxS_xc+B5z89w@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] Adjust ACPI video detection fallback path
To: "Rafael J. Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"
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
Cc: Daniel Dadap <ddadap@nvidia.com>,
 "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 Hans de Goede <hdegoede@redhat.com>, "Limonciello,
 Mario" <Mario.Limonciello@amd.com>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Dec 15, 2022 at 8:38 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Thu, Dec 15, 2022 at 8:20 PM Limonciello, Mario
> <Mario.Limonciello@amd.com> wrote:
> >
> > [Public]
> >
> > > -----Original Message-----
> > > From: Limonciello, Mario <Mario.Limonciello@amd.com>
> > > Sent: Thursday, December 8, 2022 10:42
> > > To: Rafael J . Wysocki <rafael@kernel.org>; Deucher, Alexander
> > > <Alexander.Deucher@amd.com>; Hans de Goede
> > > <hdegoede@redhat.com>
> > > Cc: amd-gfx@lists.freedesktop.org; linux-acpi@vger.kernel.org; Daniel
> > > Dadap <ddadap@nvidia.com>; Limonciello, Mario
> > > <Mario.Limonciello@amd.com>
> > > Subject: [PATCH v3 0/3] Adjust ACPI video detection fallback path
> > >
> > > In kernel 6.1 the backlight registration code was overhauled so that
> > > at most one backlight device got registered. As part of this change
> > > there was code added to still allow making an acpi_video0 device if the
> > > BIOS contained backlight control methods but no native or vendor drivers
> > > registered.
> > >
> > > Even after the overhaul this fallback logic is failing on the BIOS from
> > > a number of motherboard manufacturers supporting Ryzen APUs.
> > > What happens is the amdgpu driver finishes registration and as expected
> > > doesn't create a backlight control device since no eDP panels are connected
> > > to a desktop.
> > >
> > > Then 8 seconds later the ACPI video detection code creates an
> > > acpi_video0 device that is non-operational. GNOME then creates a
> > > backlight slider.
> > >
> > > To avoid this situation from happening make two sets of changes:
> > >
> > > Prevent desktop problems w/ fallback logic
> > > ------------------------------------------
> > > 1) Add support for the video detect code to let native drivers cancel the
> > > fallback logic if they didn't find a panel.
> > >
> > > This is done this way so that if another driver decides that the ACPI
> > > mechanism is still needed it can instead directly call the registration
> > > function.
> > >
> > > 2) Add code to amdgpu to notify the ACPI video detection code that no panel
> > > was detected on an APU.
> > >
> > > Disable fallback logic by default
> > > ---------------------------------
> > > This fallback logic was introduced to prevent regressions in the backlight
> > > overhaul.  As it has been deemed unnecessary by Hans explicitly disable the
> > > timeout.  If this turns out to be mistake and this part is reverted, the
> > > other patches for preventing desktop problems will avoid regressions on
> > > desktops.
> > >
> > > Mario Limonciello (3):
> > >   ACPI: video: Allow GPU drivers to report no panels
> > >   drm/amd/display: Report to ACPI video if no panels were found
> > >   ACPI: video: Don't enable fallback path for creating ACPI backlight by
> > >     default
> > >
> > >  drivers/acpi/acpi_video.c                       | 17 ++++++++++++-----
> > >  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c   |  4 ++++
> > >  include/acpi/video.h                            |  2 ++
> > >  3 files changed, 18 insertions(+), 5 deletions(-)
> > >
> > > --
> > > 2.34.1
> >
> > FYI, besides me, this series also tested successfully by one of the
> > reporters to the Red Hat bugzilla.
> >
> > https://bugzilla.redhat.com/show_bug.cgi?id=1783786#c8
>
> Thanks for letting me know!
>
> I'll queue it up for 6.2-rc next week.

Done now, thanks!
