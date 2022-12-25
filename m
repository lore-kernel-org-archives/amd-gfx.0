Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 338C4C3DA79
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Dec 2022 13:19:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 392C010E02B;
	Mon, 26 Dec 2022 13:19:00 +0000 (UTC)
X-Greylist: delayed 512 seconds by postgrey-1.36 at gabe;
 Sun, 25 Dec 2022 12:23:04 UTC
Received: from voltaic.bi-co.net (voltaic.bi-co.net [134.119.3.22])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4106210E0A0
 for <amd-gfx@lists.freedesktop.org>; Sun, 25 Dec 2022 12:23:04 +0000 (UTC)
Received: from [192.168.0.36] (ip-037-201-145-015.um10.pools.vodafone-ip.de
 [37.201.145.15])
 by voltaic.bi-co.net (Postfix) with ESMTPSA id 3C25321179;
 Sun, 25 Dec 2022 13:14:29 +0100 (CET)
Message-ID: <1c9c00dec72c241a399b3b7c0a305382a5712529.camel@bi-co.net>
Subject: Re: [PATCH] ALSA: hda/hdmi: Use only dynamic PCM device allocation
From: Michael =?ISO-8859-1?Q?La=DF?= <bevan@bi-co.net>
To: Jaroslav Kysela <perex@perex.cz>, ALSA development
 <alsa-devel@alsa-project.org>
Date: Sun, 25 Dec 2022 13:14:28 +0100
In-Reply-To: <20220922084017.25925-1-perex@perex.cz>
References: <20220922084017.25925-1-perex@perex.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.2 
MIME-Version: 1.0
X-Mailman-Approved-At: Mon, 26 Dec 2022 13:18:59 +0000
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
Cc: Takashi Iwai <tiwai@suse.de>, amd-gfx@lists.freedesktop.org,
 Kai Vehmanen <kai.vehmanen@linux.intel.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

CC'ing amd-gfx as this might be an issue in the amd driver.

This change causes a regression in Linux 6.1 at least on some AMD APUs.
There are reports from users with Ryzen 4750U, 5800U and 5850U chips
where the HDMI sound devices don't show up anymore. I'm affected by
this as well.

Reverting this commit (ef6f5494) makes the HDMI audio devices show up
again. I verified that this is still an issue in current Linux git
(72a85e2b).

Am Donnerstag, dem 22.09.2022 um 10:40 +0200 schrieb Jaroslav Kysela:
> > Per discussion on the alsa-devel mailing list [1], the legacy PIN to PC=
M
> > device mapping is obsolete nowadays. The maximum number of the simultan=
eously
> > usable PCM devices is equal to the HDMI codec converters.
> >=20
> > Remove the extra PCM devices (beyond the detected converters) and force
> > the use of the dynamic PCM device allocation. The legacy code is remove=
d.
> >=20
> > I believe that all HDMI codecs have the jack sensing feature. Move the =
check
> > to the codec probe function and print a warning, if a codec without thi=
s
> > feature is detected.

The corresponding message ("jack not detectable") is not shown on the
affected system.

> > [1] https://lore.kernel.org/alsa-devel/2f37e0b2-1e82-8c0b-2bbd-1e5038d6=
ecc6@perex.cz/

Links to some reports of this issue:
https://bugzilla.kernel.org/show_bug.cgi?id=3D216836
https://bbs.archlinux.org/viewtopic.php?pid=3D2075700
https://bugs.archlinux.org/task/76917
https://www.reddit.com/r/archlinux/comments/zsqq7i/hdmi_audio_is_broken_aft=
er_updating_kernel_to_611

Best regards,
Michael
