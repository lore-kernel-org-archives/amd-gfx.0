Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE3F9C5B569
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Aug 2026 19:16:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B834210E984;
	Mon, 10 Aug 2026 19:16:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="XaDfzBQC";
	dkim-atps=neutral
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com
 [209.85.214.177])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0D4AB10E220
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Aug 2026 19:16:14 +0000 (UTC)
Received: by mail-pl1-f177.google.com with SMTP id
 d9443c01a7336-2d027b7c8easo5857175ad.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Aug 2026 12:16:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786389373; cv=none;
 d=google.com; s=arc-20260327;
 b=HWKhLR9ZKhe5bPbzy/jJzGyw7fqgS3Z5kLTtUkLvKryOjTcu8grr3RrDRGfqKkD5dF
 W0TjagCpua8ESJj9uF0xRr1fP9u3EIj9RB7ATCT5QL9wUbdBTfmbnZy41OItt/aWZYih
 mys6yo+iQbbraJcFAjdgRHe7qv+9Q6TIXuWkEFFvOerfNlJZ5TgIY2K70sBtsMa4J/+/
 QHnFFedDhmlRB9zA3DczuSHW4/toBrzv+4752mx7cQH3Oze490MB3cMNvKk45aYhKVxi
 s0JUOWHuNd2NwwGp0uSg8XDkomIscAXJjhGhZmk6uFPwWbn0kuzCMoSlsVBnlxEFLC9x
 /Hng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=HQKyHVq3ygy/Bc3aNr+atei5qWh9KHU8VwmS9zk6DmY=;
 fh=XwLyg1jXE2pBGupH75bMp/CUvSf//NSKrnnnO7U8v6M=;
 b=QWiwC/5pmM6XGp1ARUdmHo/z3Zk5YMuPb4lhS+bOIq7ZrGS8VgGApJsRK8dtmr0rZA
 urhEIoV0phaz18e/wRksEENQLrqmtaM4IXGjFa3hHrRvHzjXAohfzZ+rhiDADwGOZbtV
 UuLIiT8P6RGefQtFG5AXVGw06JUtzpRFCABy/P8uEi2guk0jGeryzJxndP9ZXQw9xJHZ
 oyAzX4YAU8cFdom57BLRVdec2O6msv93bGf8F2j0ARBLiZy0x3adYpF/qfnGq2R/CQ4Q
 ek/1iBKnz3ecegdzAl8R+dgZwSodTFMWY9O3toK9x9lIwX0VrIaQoNaWNFeB6fjP7zCF
 cGgw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786389373; x=1786994173; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=HQKyHVq3ygy/Bc3aNr+atei5qWh9KHU8VwmS9zk6DmY=;
 b=XaDfzBQC7lY0qq9CtZHFxqHWcUGOQzkpbj10s8+Q6r3kmwBLvYKebTfccx8fsQpX6F
 zM8oSEn0ooMj2eCRMOxkYPAnMmFTQ2kDO3irtGF1es9X/+vm+Ud3kCxffAGJJTuxn/rD
 KMWWSEKeuwqX7htfYnKdHaI2pBAewWTUwGXgVZe7MSlFzniRyNxEc+yznzk1pEvDC7WP
 ygmxnbZF7jshzupp3OrqksRRhFvdoUwB+rRHkMNiJyRhcqW3IMj2xsx9EN1XYK9bJQX5
 JwdC73t2KwM6QTJBYVLLZAmFIMPWcrwcOJkW/iVQmyS0d/Z7nAazRRcYh8frF2dcMeEL
 oxVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786389373; x=1786994173;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=HQKyHVq3ygy/Bc3aNr+atei5qWh9KHU8VwmS9zk6DmY=;
 b=pJxKI2ajxeFusJK+3T5KNg5nBk87ICcrglCXtNsTVKWKEl9iGIgo/o5bb+kCRqmi33
 HlDhjzlULN86NX/fecOWZ4NjAdgLaJ5N8lg3Pwcw/vBDuLm+WtrK41XutLWHX2CsrtVA
 UAwR1s543yXerN7XJwe/pw2zWfAYzbKfBVV5pgH5eAIabkKvcrhVSL+tY7MG6K4q/BQR
 gKEfsq867ko0jdWlcz1/29QqhwtyrWt6RGd2WNFAldJuPKpIGJ3oOgi0VuNTwZ0P/FhV
 TukxljxCFu8jPsTbWPv4rdA436N80aQFt7Pw79uJ27mI9oROuldKgD960oIt64+YYgE8
 D9ow==
X-Gm-Message-State: AOJu0YzBD4ALLF0Jk/5Dor3+FkAAXJSMX98hmNIjf2tgubgfY83UdR1/
 Xv+2VApK32yUvbQWulai5DAto0bK5HE78RflaYmeCFEB5r9/j5xyG2MXO6I1Z2yXGCYvijU4epS
 cjJvAkWLvlIbcmF2xbSE87ScIJzw2IqE=
X-Gm-Gg: AR+sD13cpSMWLPl5Gi6Ska0h6GNZvdgxdmoBj+b+co6qXSW9WbtdEX4qasFub/qUqY2
 mse0E1ZPcOZOOihVdhHSUyn+JtbDnxpchI0gh1eg9/c1ALA0H/qM8tgbQFBTh0DQI/WcXscEWlr
 MVDptKNdraEMvAYDGb59d6ZfjuwDnadpzkZ4FySf0r2bDk8xRokGF9Jl3b0nvYjcQG/yFdTac/Z
 M2W3L5jsg+4sQgrZh8H/kpvjxcfJfCvtoeLk7fBsKNFYfl3N/vOJr52NaVy3A0sIa0ArDsoBNmT
 euWFWAeuHbNyg6M8cnHc3MLsEG3AgXN7bDY8PnnIDCIjt1SdhKUvjO10YYlFrSDFEgeierWLrNF
 hJNEc83VGVLltRGppSq/wWyFYluaYU9k=
X-Received: by 2002:a17:90b:278c:b0:38f:aa76:88b with SMTP id
 98e67ed59e1d1-3903c776ae3mr32451041a91.4.1786389373401; Mon, 10 Aug 2026
 12:16:13 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1785616749.git.nlucasgit@gmail.com>
In-Reply-To: <cover.1785616749.git.nlucasgit@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 10 Aug 2026 15:16:01 -0400
X-Gm-Features: AUfX_mwrEJIp4EMHkXnoK416XqZ0pGnbbA8pXDtHVtlj5DDXVcVLCr8qek9F3n4
Message-ID: <CADnq5_NMWdV_zy6xJUtkdLGxXSCe2vfGp=Kc0kH_Rqg1SAV2Kg@mail.gmail.com>
Subject: Re: [PATCH 0/2] drm/amd/display: fix BT.2020 YCbCr output CSC matrices
To: Nathan Lucas <nlucasgit@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, harry.wentland@amd.com, sunpeng.li@amd.com, 
 siqueira@igalia.com, alexander.deucher@amd.com, joshua@froggi.es, 
 mwen@igalia.com, leorize+oss@disroot.org, alex.hung@amd.com, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
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

Applied the series.  Thanks!

Alex

On Sun, Aug 2, 2026 at 10:35=E2=80=AFAM Nathan Lucas <nlucasgit@gmail.com> =
wrote:
>
> This patch series fixes COLOR_SPACE_YCBCR2020_TYPE in dc_hw_sequencer.c
> which is used for COLOR_SPACE_2020_YCBCR_LIMITED output but does not have
> correct luma and chroma scaling for that output range, and fixes its
> copies in dce_transform.c and dce110_opp_csc_v.c.
>
> It looks like this matrix was originally added in commit 40df2f809e8f
> ("drm/amd/display: color space ycbcr709 support") as a raw BT.2020-NCL RG=
B
> to YCbCr conversion matrix that had not yet been prepared for unsigned
> limited or full-range quantization.  Commit 973a9c810c78
> ("drm/amd/display: Fix COLOR_SPACE_YCBCR2020_TYPE matrix") applied offset=
s
> for unsigned limited-range quantization but did not fix the luma and chro=
ma
> scales which are still full range.  Because of this, output on a calibrat=
ed
> display is too bright with incorrect color, although it still looks rough=
ly
> correct at low luminance in my testing.
>
> Later, in commit 51e6668ab4ba
> ("drm/amd/display: add missing CSC entries for BT.2020 for DCE IPs"), the
> incorrect COLOR_SPACE_YCBCR2020_TYPE matrix coefficients were duplicated =
to
> DCE COLOR_SPACE_2020_YCBCR_LIMITED and COLOR_SPACE_2020_YCBCR_FULL, so
> those matrices are also currently incorrect.
>
> The first patch adds separate matrices for full and limited-range.  The
> derivation is in the commit message.  The second patch replaces the copie=
d
> matrix coefficients in dce_transform.c and dce110_opp_csc_v.c with the ne=
w
> ones.
>
> For testing I have only been able to check the limited-range DCN path on =
a
> 9070 XT with a patched kernel.  amdgpu_dm_get_output_color_space does not
> currently have a path to select COLOR_SPACE_2020_YCBCR_FULL although the
> enum value exists.  Also, I cannot test the DCE paths as I do not have th=
e
> hardware to do so.
>
> I ran into this issue measuring PQ test patterns through mpv with the
> following command line:
>
> mpv \
>   --no-config \
>   --vo=3Dgpu-next \
>   --gpu-context=3Ddisplayvk \
>   --gpu-api=3Dvulkan \
>   --vulkan-display-plane=3D3 \
>   --vulkan-display-mode=3D22 \
>   --target-trc=3Dpq \
>   --target-prim=3Dbt.2020 \
>   --target-colorspace-hint-mode=3Dsource \
>   --target-colorspace-hint=3Dyes \
>   --tone-mapping=3Dclip \
>   --hdr-compute-peak=3Dno \
>   [pattern file]
>
> Free test patterns:
> https://diversifiedvideosolutions.com/hdr-10.html
>
> Below is a table of values I measured on a Samsung S95H (US model) with a
> Calibrite Display Pro HL meter.
>
> Three sets of meter readings below:
> Unpatched - Unpatched Fedora 44 kernel 7.1.4-200.fc44.x86_64
> Patched   - The patches in these e-mails applied to Fedora 44 kernel
>             7.1.4-200.fc44.x86_64
> NVS/Kodi  - NVIDIA Shield Pro with Kodi
>
>  5% HDR10/PQ
>  Test Pattern        Meter Readings (nits)
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D   =3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> PQ%       Nits   Unpatched   Patched   NVS/Kodi
> 15        1.01        1.63      1.01     1.02
> 25        5.24        9.68      5.46     5.12
> 35       18.78       40        20.5     21.2
> 45       56.55      128        62.0     62.1
> 55      148.03      369       155      155
> 65      384.71     1106       403      401
> 75      973.13     2681*     1030     1025
>
> * This is at the peak capability for this TV.
>
> PQ brightness overtracks a bit in Patched and NVS/Kodi, but that is likel=
y
> due to the TV's default calibration or my meter since the readings are so
> similar.  Unpatched stands out as being way too bright.
>
> Nathan Lucas (2):
>   drm/amd/display: fix BT.2020 YCbCr limited output CSC matrix
>   drm/amd/display: fix BT.2020 YCbCr output CSC matrices for DCE
>
>  .../drm/amd/display/dc/core/dc_hw_sequencer.c | 31 ++++++++++++-------
>  .../drm/amd/display/dc/dce/dce_transform.c    |  7 +++--
>  .../amd/display/dc/dce110/dce110_opp_csc_v.c  |  7 +++--
>  3 files changed, 28 insertions(+), 17 deletions(-)
>
> --
> 2.55.0
>
