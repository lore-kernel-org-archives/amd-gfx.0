Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22F46C79F82
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Sep 2026 10:27:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9282E10E8D6;
	Tue,  8 Sep 2026 10:27:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="HJrNuELy";
	dkim-atps=neutral
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com
 [209.85.222.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5773010EB1C
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Sep 2026 10:27:17 +0000 (UTC)
Received: by mail-qk1-f182.google.com with SMTP id
 af79cd13be357-9399798cdd2so180912085a.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 08 Sep 2026 03:27:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788863236; cv=none;
 d=google.com; s=arc-20260327;
 b=nktNUgX/kCz6dX0H0I8bTo1HGHqIfhFlD5le8WVwiC0Qex+RrsAy4cWDBAEWVeC80P
 /oCkc7END8p/Ad3OacTA5DTNuT6bGVZkAKeoN4O4cMh3CRTYK8mKQmZtPv63n4f3slQ4
 PhumprmpPo5zZqwNT5InN8T0k00XBBqLBSAAgWqpAwsQgz6u5tPvFccAtLEp/BResLko
 0Q+tLG3qQf68OqmeKtqCA97rgNzN19173e0wX6/kbDZDk/IIiMghm715qbTPNGDIlY0S
 uUrInWaftA4+zPaf70CEc3/oEAEYXJpHNqOml0ONTkMFqvyQ8Th004P9GFi65UhKz+ZH
 R3cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=z8a//pM/Ql6aGzlfUZAtH3NGbwHwZ/hnr+wzfI3LfTM=;
 fh=CbhFwWSgrqnlQ6l28SVRgfQ+vib9rglbQhAc6zEVsQo=;
 b=fDpmu9Z4Cd7cZNgr/3jEXVD4uV1PcUs3OV5e9Poqz+j2d3PTIZ+Ezqtb8BSzhuv0Wn
 FFjatVkCHEsd2YGz3BDUQU3R0C4VF9lJqm07T0lJwi6Ah/s2bIfQoRI3SRMbcc09PGcx
 PQW0jF8k2S7TSmVZYb5WQ8/tuKavcONKQ9obY8KZvB0XT5aExh3rLf98RFzGRxUCHVFM
 u8VQVkAnu+WqjLzToSJNW/LWFnVq5RDR0n1tnOt85OBfMAEwSvrbwQy6Wpc7eL0HMXcE
 zej4Gu+UfChIOfjsAFLuczDJDhQQ5/EVGtlin/I/2kLgp4QQidmEPmBpZSrodLykRdWX
 PY5g==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788863236; x=1789468036; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=z8a//pM/Ql6aGzlfUZAtH3NGbwHwZ/hnr+wzfI3LfTM=;
 b=HJrNuELy0TftLDve0sK2P7IX2rOo83TLwnf7rRXkzMcH+5FdQIjImIFAFVxxj1TOA7
 xL/1q6u348JcFDBfElycJW6a0v/F6dP3MrmOZkiz4DuVn6f0dQy9hyz72kIwbopMbdtC
 ssOZe14y7gKhHT5ne1nLpr7M5rvqdbAH5/jNdqJg57hzVf+wz3djTcAXuzJFZ7l6c48s
 omgqvfGS8Z3ZrtvX71mXjI+pDGV2RkWMi0JPZ67kTGzVyLAuHNQB7+sCnldQfrtzEbrG
 dG8l0sFo/ejES/ZuFtlPjaF1hZGZosR1cebZSXYsGEC89FMVzetKJT+q4hnG+s58XBef
 y0Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788863236; x=1789468036;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=z8a//pM/Ql6aGzlfUZAtH3NGbwHwZ/hnr+wzfI3LfTM=;
 b=jf8JSIxKFmMoE69jXVEUUC4z5UIEMlOF56V+FRs4DNKEs1eM7WdSJFx/7PU57ySQfn
 CwHlrmBNdyKkIhZlgy3XfHfqXh9t5c3u2N92ouYUl72qpgAahx5pXbV8YPJhl4FHfH2M
 2GP5rI2kC9oFQqgIDPUFU1SexfpF79FVV8JZtErQ01aCn2xUL1OViPWiYIOzKTVqN4VU
 1Bii+NSzrZSUlsjYo04FTaYINSjsk6HLmwzrCQfmVFuEUpsOXDYAilwPNl0gRSTZBJVI
 bA9Ns/CQXx4qyKxVjOzIxRYKJDL6iZyE0F5B5Xw3h+bfJVA1JKMlzzlO+P8LyJ7M0PuY
 +lLA==
X-Forwarded-Encrypted: i=1;
 AKwUvBz4NTO/Sikb1IIJSSM7SyjfJ2CgNG6Ia/9OQ+C4osX4U4ILIPtOnUcDf9qhitEYulek4FoxLEzx@lists.freedesktop.org
X-Gm-Message-State: AFuF++mhMFel1MOJxY2b3jpB5Kl20WTHeptbbHO/8wf2BCJ+X19E1T8Q
 NpRrSWVaMAEZZqgM5t/qHKBjRgRGbtRHykadxVMIKOp6pKOu6L8yptxePBqMy+eEvEj2/LsX8r8
 eT3TvaNUqKNYvtgzI3idDseAakXyM6Rk=
X-Gm-Gg: AYBFou26orUUOzE2vgPyokck5O5Riz92rPDasage9Pttfu5OZ20871Bv1EFaoE9U78X
 tKDwff7q5Nk6WG4DsDPX3OrOkMvqOzMDxOP86mCDYVj1Zo2NhtekdHCUiOh/DRNYWQxYtfmEEIx
 7SfTluKQS/62av7k6BGfzdN8WoNCqBmmdAZJwLzIiI+33ZSLyFI5FdhY3cBsv7nGymXBfU5aw7m
 IMIRVqcGQ6+aNa6MuWyi61xnpwvBJxiUvUSKELAH6EpAPeAGGd+Infr9eqaIT3q+wMK3FOZuxjO
 W1GiY5seRfOVLS61drGGhp/7pghz2IZ3zPLvNkuRHYWk8Qrk9QbocHybO3RvURWPWBx3fxXDHs2
 sYz+UwnKsIm9r5OaUtkBU5asjisme/h6mwRdxQIDN
X-Received: by 2002:a05:620a:234:b0:939:4b31:4669 with SMTP id
 af79cd13be357-93980434d0bmr2329407185a.29.1788863236207; Tue, 08 Sep 2026
 03:27:16 -0700 (PDT)
MIME-Version: 1.0
References: <20260820142802.1342066-2-rodrigo.vivi@intel.com>
 <e48a854b-1240-4fcb-a429-2c02be10da5d@kernel.org>
 <CADnq5_PvMKVbmukOJW9oHK-bw3110eAf97WXfUVi-urhcEGMMg@mail.gmail.com>
In-Reply-To: <CADnq5_PvMKVbmukOJW9oHK-bw3110eAf97WXfUVi-urhcEGMMg@mail.gmail.com>
From: Dave Airlie <airlied@gmail.com>
Date: Tue, 8 Sep 2026 20:27:03 +1000
X-Gm-Features: AcwNN1UdfEqDvqt4h6-mGvR-jvMGVCb1iWb0peyiWxGKDTiEmCJKruGXVCWaOeg
Message-ID: <CAPM=9tws_bMnxt9QVjt4bP_bO9YM5h2n4FtNZMg1p0ZLsrLw5g@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Drop KUnit tests for removed
 parse_hdmi_amd_vsdb()
To: Alex Deucher <alexdeucher@gmail.com>
Cc: Mario Limonciello <superm1@kernel.org>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, 
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 Alex Huang <Alex.Huang2@amd.com>
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, 21 Aug 2026 at 07:30, Alex Deucher <alexdeucher@gmail.com> wrote:
>
> On Thu, Aug 20, 2026 at 3:30=E2=80=AFPM Mario Limonciello <superm1@kernel=
.org> wrote:
> >
> > On 8/20/26 09:28, Rodrigo Vivi wrote:
> > > parse_hdmi_amd_vsdb() was removed when HDMI FreeSync detection moved =
to
> > > the common EDID parser, but its declaration and KUnit tests remained,
> > > breaking modpost:
> > >
> > >    ERROR: modpost: "parse_hdmi_amd_vsdb" [...connector_test.ko] undef=
ined!
> > >
> > > Remove the stale declaration and the three dead test cases.
> > >
> > > Fixes: f65198b3d073 ("drm/amd/display: Use HDMI FreeSync range from c=
ommon EDID parser")
> > > Cc: Alex Huang <Alex.Huang2@amd.com>
> > > Cc: Mario Limonciello <superm1@kernel.org>
> > > Assisted-by: Copilot:Claude-Opus-5
> > > Signed-off-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
> > > ---
> > Thanks this looks correct to me.
> >
> > Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>
> >
> > I'm not sure where we should apply it though, it's from a conflict
> > between drm-misc-next and Alex's drm-next pull.
>
> I'll pull it into my next -fixes PR.

I think this should be merged into drm-misc-next ASAP, since the merge
is in there.

Dave.
