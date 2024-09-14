Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BAA7C02190
	for <amd-gfx@archiver.kernel.org>; Sat, 14 Sep 2024 09:55:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8712010E2A9;
	Sat, 14 Sep 2024 09:55:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=weissschuh.net header.i=@weissschuh.net header.b="rEcu3WzR";
	dkim-atps=neutral
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 417FD10E29B
 for <amd-gfx@lists.freedesktop.org>; Sat, 14 Sep 2024 06:58:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
 s=mail; t=1726297136;
 bh=zo3lQ2PITtK27dWmpgtRGMq18fxwP0kU+d8KPqbe0I8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=rEcu3WzR34S4GB9FAOlrHTMIl3QiMi7XwQvXm0yU4nPUvcbHrO7nU4ct1ascvtoTx
 GFYahHN9F5AhGqgNwvqVKZhEhw+sNR1V6d4rPi9tSwbuHNuPqpjq+4fsahGv1StBPR
 2RDZI0XAoMksQYjjfvv1PqLwFRKrL/TXU4n517lI=
Date: Sat, 14 Sep 2024 08:58:56 +0200
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexdeucher@gmail.com>, 
 Harry Wentland <harry.wentland@amd.com>, amd-gfx@lists.freedesktop.org
Subject: Re: [PATCH] drm/amd/display: Validate backlight caps are sane
Message-ID: <be04226a-a9e3-4a45-a83b-6d263c6557d8@t-8ch.de>
References: <20240913180039.38146-1-mario.limonciello@amd.com>
 <db78e83a-6b4b-4d87-a2b7-8a2a912e63b2@amd.com>
 <04ca46bd-c734-4fe8-9244-bbc138b55b57@amd.com>
 <CADnq5_Pw6CKn-La4kUu0YL=M_4KdZ6PFL7+26pU421kEc30O=g@mail.gmail.com>
 <619e24cd-a382-41c7-bcc6-26656156ba3e@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <619e24cd-a382-41c7-bcc6-26656156ba3e@amd.com>
X-Mailman-Approved-At: Sat, 14 Sep 2024 09:55:27 +0000
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2024-09-13 15:48:55+0000, Mario Limonciello wrote:
> On 9/13/2024 15:36, Alex Deucher wrote:
> > On Fri, Sep 13, 2024 at 2:51 PM Mario Limonciello
> > <mario.limonciello@amd.com> wrote:
> > > 
> > > On 9/13/2024 13:47, Harry Wentland wrote:
> > > > 
> > > > 
> > > > On 2024-09-13 14:00, Mario Limonciello wrote:
> > > > > Currently amdgpu takes backlight caps provided by the ACPI tables
> > > > > on systems as is.  If the firmware sets maximums that are too low
> > > > > this means that users don't get a good experience.
> > > > > 
> > > > > To avoid having to maintain a quirk list of such systems, do a sanity
> > > > > check on the values.  Check that the spread is at least half of the
> > > > > values that amdgpu would use if no ACPI table was found and if not
> > > > > use the amdgpu defaults.
> > > > > 
> > > > > Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3020
> > > > > Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> > > > > ---
> > > > >    .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c    | 16 ++++++++++++++++
> > > > >    1 file changed, 16 insertions(+)
> > > > > 
> > > > > diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > > > > index 5942fc4e1c86..ad66f09cd0bb 100644
> > > > > --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > > > > +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > > > > @@ -4428,6 +4428,7 @@ static int amdgpu_dm_mode_config_init(struct amdgpu_device *adev)
> > > > > 
> > > > >    #define AMDGPU_DM_DEFAULT_MIN_BACKLIGHT 12
> > > > >    #define AMDGPU_DM_DEFAULT_MAX_BACKLIGHT 255
> > > > > +#define AMDGPU_DM_MIN_SPREAD ((AMDGPU_DM_DEFAULT_MAX_BACKLIGHT - AMDGPU_DM_DEFAULT_MIN_BACKLIGHT) / 2)
> > > > >    #define AUX_BL_DEFAULT_TRANSITION_TIME_MS 50
> > > > > 
> > > > >    static void amdgpu_dm_update_backlight_caps(struct amdgpu_display_manager *dm,
> > > > > @@ -4442,6 +4443,21 @@ static void amdgpu_dm_update_backlight_caps(struct amdgpu_display_manager *dm,
> > > > >               return;
> > > > > 
> > > > >       amdgpu_acpi_get_backlight_caps(&caps);
> > > > > +
> > > > > +    /* validate the firmware value is sane */
> > > > > +    if (caps.caps_valid) {
> > > > > +            int spread = caps.max_input_signal - caps.min_input_signal;
> > > > > +
> > > > > +            if (caps.max_input_signal > AMDGPU_DM_DEFAULT_MAX_BACKLIGHT ||
> > > > > +                caps.min_input_signal < AMDGPU_DM_DEFAULT_MIN_BACKLIGHT ||
> > > > 
> > > > Would we still want to allow signals below AMDGPU_DM_DEFAULT_MIN_BACKLIGHT
> > > > (but above 0)? The min backlight value of 12 is a bit conservative and
> > > > I wouldn't be surprised if systems set it lower via ACPI.
> > > > 
> > > > The rest looks like great checks that we should absolutely have.
> > > 
> > > I'm waffling about that one because Thomas' testing showed that there
> > > was some problems with panel power savings when he quirked the Framework
> > > panels below their ACPI default (12) in his v6 series of the Framework
> > > quirks.
> > 
> > What about systems without the need for a quirk?  E.g., the vendor put
> > a value less than AMDGPU_DM_DEFAULT_MIN_BACKLIGHT in the ACPI tables
> > because they validated it and it works.  Won't this break that?
> > 
> 
> From what I can tell from the observations that Thomas had (mentioned in
> this commit message) setting it below 12 causes panel power saving to not
> work properly; the issue should be specifically in how DC/DMCUB handles that
> case.

I said that enabling panel power savings would slightly adjust the
brightness. But that difference is very tiny and nearly not perceptible.
Surely it is not "not a good experience" on my machine.
Also it turns out I my testing was incomplete. The same effect also
occurs with the default min backlight of AMDGPU_DM_DEFAULT_MIN_BACKLIGHT=12.

> I think once that's fixed we should open it up further.
> 
> > Alex
> > 
> > > 
> > > So my thought process was we should put in an explicit check for now and
> > > then when we have panel power savings working without a modeset landed
> > > then we can also add code to the backlight set callback to turn off
> > > panel power savings when set below AMDGPU_DM_DEFAULT_MIN_BACKLIGHT to
> > > prevent the issue he found.
> > > 
> > > > 
> > > > Harry
> > > > 
> > > > > +                spread > AMDGPU_DM_DEFAULT_MAX_BACKLIGHT ||
> > > > > +                spread < AMDGPU_DM_MIN_SPREAD) {
> > > > > +                    DRM_DEBUG_KMS("DM: Invalid backlight caps: min=%d, max=%d\n",
> > > > > +                                  caps.min_input_signal, caps.max_input_signal);
> > > > > +                    caps.caps_valid = false;
> > > > > +            }
> > > > > +    }
> > > > > +
> > > > >       if (caps.caps_valid) {
> > > > >               dm->backlight_caps[bl_idx].caps_valid = true;
> > > > >               if (caps.aux_support)
> > > > 
> > > 
> 
