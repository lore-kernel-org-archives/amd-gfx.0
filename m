Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6F23C2D0CD
	for <amd-gfx@archiver.kernel.org>; Mon, 19 May 2025 12:55:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 53FD010E0E5;
	Mon, 19 May 2025 12:55:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ZDwBsXYz";
	dkim-atps=neutral
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com
 [209.85.214.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C00D610E0E5
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 May 2025 12:55:21 +0000 (UTC)
Received: by mail-pl1-f169.google.com with SMTP id
 d9443c01a7336-22eed3b3cabso6758335ad.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 May 2025 05:55:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747659321; x=1748264121; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=m5RSdMBEXiPV/jvwuXN507mvIoEfjCO+UiWKE7ohZEg=;
 b=ZDwBsXYzfjIM2l/wtHlENcYXOZokjGPG3NvtjawRcuDG8MJ2XyA6wOa+eo2gSGqNZQ
 fOyUCUy9jfDAJDD533xhAejEVy21fsmf/r+dSj1rEmVD8Z9AyWS8j+DlXL7RtKepikff
 btzDhkux86aGN/UwYRTX1divpkt3dElYZIykW4Yb5+1CCPj98r2eElru0HVHL8+02LXs
 /nFp6ETCUijVHWfCadl2pjl+wAVWYz33u9FXVSW9yh8mpBckp8i47ICHxU/aXubp5hrW
 XfGPX9XTgERbd78gVANT3Wen7OybicqOafjv482d4jLrSR23Vb1Uw0aMIlTlnkcOLikz
 CByw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747659321; x=1748264121;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=m5RSdMBEXiPV/jvwuXN507mvIoEfjCO+UiWKE7ohZEg=;
 b=shiUx3tM2fd7H0wwHD4gVh/xnZhqef+DGZccjRSXkJvQ2bNyp7bJ/rtMXLn2/xakh2
 HMINY8cXlMBrZlJiQZ41A9DhTnZqDA1qbpBvC59Sf9AH6/k6shqvFTS2MqO8dWXDtXoK
 17D2DqccgBFcsVvnzAKkZyASNZ3WpXYKu9mijdt2/NBH+o6BqM+9R9ZTJvtcvGuhdiUU
 Yxy2SBk4pNi1tLHcbZJyLyyH6HOw1YQAGMrI9+vYC22ToA+nu/nAkuloe0aVbDLCjASW
 VTO513Pqi818/Gpp1l8LLAoAvQQ6q/astThA32Fty3kQZw77Wbpce34NRFhNESZe4EH7
 fLLQ==
X-Gm-Message-State: AOJu0Yxq/hsgWZYb0xqEuDg26GKare+SRtP+RubjwR9b/+kY7QQf7CRk
 lyUrl1noskpu4uqaiHnanZoMdapvM36bCQ5w6Lc8r93yiZypIu5uWrjziuFujiKlRNBslQ2nHGs
 CptHfF4oDVSkw51DcA3B1r7kXbpQpQT0JFQ==
X-Gm-Gg: ASbGncuteCIzQxjllSVSt8qo7x6/q5GxMsKlUPI5nC/oEwr1UC32wTdtPaeHvorM20E
 CXDq66orJT8ePSX6JMUEIDbHXENZcO3PVbc49hbTlWA1RNzBenXIRgfcF5uK91TpTO7YOyHAD95
 +IrOWY5DomwvCHBQnSYC9CPUFfHOYN8BWetQ==
X-Google-Smtp-Source: AGHT+IHJQmtlreCHWjLweUiEGWE5HWEZUqgP+MfdJt5pSBth5mKimOlNJmwxlYhlimgqDta97+NgejtqsiefWXvx/Ig=
X-Received: by 2002:a17:903:1ca:b0:21d:cdb7:876c with SMTP id
 d9443c01a7336-231d43893c2mr75688515ad.3.1747659321123; Mon, 19 May 2025
 05:55:21 -0700 (PDT)
MIME-Version: 1.0
References: <CA+T1z7Spnh+_PRWtpmCdg4rrsBi2uNrBvmc1LOvyHmeFjxPSXw@mail.gmail.com>
In-Reply-To: <CA+T1z7Spnh+_PRWtpmCdg4rrsBi2uNrBvmc1LOvyHmeFjxPSXw@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 19 May 2025 08:55:09 -0400
X-Gm-Features: AX0GCFs5pLO_V5iqphHGPIxuEvQ6Sn92toAxTgnXaWTaldg6X9Eu_t8Oq3EBwWI
Message-ID: <CADnq5_MD2ua5psx0QbZgkj-CzOAcGMZAxa_8hJUhBQZQtFt14g@mail.gmail.com>
Subject: Re: [AMDGPU] DP AUX transfer fail, as of 6.14.7
To: Mr Penguin <mr.penguin.mkv@gmail.com>
Cc: amd-gfx@lists.freedesktop.org
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

On Mon, May 19, 2025 at 8:53=E2=80=AFAM Mr Penguin <mr.penguin.mkv@gmail.co=
m> wrote:
>
> Hi,
>
> I've upgraded my vanilla 6.14.6 kernel to 6.14.7, and I am now seeing "DP=
 AUX transfer fail: 4" warnings. These don't appear to be significant, but =
they are definitely new. And there are definitely a LOT of them:
>
> ...
> [   26.915115] amdgpu 0000:04:00.0: amdgpu: Using BACO for runtime pm
> [   26.920868] amdgpu 0000:04:00.0: [drm] Registered 5 planes with drm pa=
nic
> [   26.926418] [drm] Initialized amdgpu 3.61.0 for 0000:04:00.0 on minor =
0
> [   26.938637] fbcon: amdgpudrmfb (fb0) is primary device
> [   26.939008] [drm] pre_validate_dsc:1621 MST_DSC dsc precompute is not =
needed
> [   26.939522] amdgpu 0000:04:00.0: amdgpu: [drm] amdgpu: DP AUX transfer=
 fail:4
> [   26.940222] amdgpu 0000:04:00.0: amdgpu: [drm] amdgpu: DP AUX transfer=
 fail:4
> [   26.940921] amdgpu 0000:04:00.0: amdgpu: [drm] amdgpu: DP AUX transfer=
 fail:4
> [   26.941667] amdgpu 0000:04:00.0: amdgpu: [drm] amdgpu: DP AUX transfer=
 fail:4
> [   26.942419] amdgpu 0000:04:00.0: amdgpu: [drm] amdgpu: DP AUX transfer=
 fail:4
> ...
> [   26.984445] amdgpu 0000:04:00.0: amdgpu: [drm] amdgpu: DP AUX transfer=
 fail:4
> [   26.985183] amdgpu 0000:04:00.0: amdgpu: [drm] amdgpu: DP AUX transfer=
 fail:4
> [   27.020491] Console: switching to colour frame buffer device 210x65
> [   27.437597] amdgpu 0000:04:00.0: [drm] fb0: amdgpudrmfb frame buffer d=
evice
> ...
>
> Should I be concerned by this? I would guess that this is a race at start=
-up.

You can ignore it.  There was an aux fix that went in that was a
little too verbose.  Its verbosity was reduced last week so you should
see those messages disappear in the next update.

Alex

>
> The full dmesg log is attached.
>
> Cheers,
> Chris
>
