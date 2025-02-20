Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB2B5C021B1
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Feb 2025 14:08:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 76E8310E965;
	Thu, 20 Feb 2025 14:08:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="bLkn6APa";
	dkim-atps=neutral
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com
 [209.85.214.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0FF2F10E965
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Feb 2025 14:08:36 +0000 (UTC)
Received: by mail-pl1-f174.google.com with SMTP id
 d9443c01a7336-2166db59927so2202855ad.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Feb 2025 06:08:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740060515; x=1740665315; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OjmM5gbTC9mvcMhJU+L68piC1eRyu7CQvSJe9PX9cWs=;
 b=bLkn6APaxX1zKlArmGp7hc7hS9vrGnqphzs1jw5ikAunuzTLxje+3DO4iyXwlnWz4x
 Z0iiqIOvN/ftFHklHUSqN8sYjLx/COVZrfAwJs4E+s1WQom9xqm91tRfbpstIKjZae2D
 2+0wYue3x5r0fWT3bmhWvS1Sc5yPPO5j1waX1Coj5bFd5mDJV1dFIFYmTTsJQQwJH5du
 i6ZmbhYj9JbvnrP9knI4D+XdiskcoU/8AjXmVF/TE3M5TDWaRR4ZUlMuwU4LXJGKGGsq
 Grc0MwQlO4Q1fmovbB6a00HmYZ503EH+OhZE3iqfLlqlhq1AgxHQNEQaob65uwcxoVW7
 kZAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740060515; x=1740665315;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OjmM5gbTC9mvcMhJU+L68piC1eRyu7CQvSJe9PX9cWs=;
 b=fRgCOE2mtpbwksZWa0iiyNSOYaeaukEIytqSYa0BetOSAIGSD8+ra/sgVUgJR8pSSy
 rVoiUo+plFIc0LoDADDwX2gR5NUSoLH+l+U1g9EWvzF18+MhOOIcZt12Spo/5xcrifGH
 OZR5PjhbmXG8pY/qxZCVUOZKV8rtRFgr+PBY9rsxvctdj7+Tknh6s62phUmgcey0UYUd
 snzqjebG3R7O0QgCJ3U6BL6oc2BC9J7gfE6cYdhHY3AiO+bYLiCru+ohngJ/+iJQh6Y5
 /bWxC1vr5L+QIBAYPWpLwwp272YRKtTm2/Vjc+dta3LHfYd4kEazkSiqKQhMa0N8rgYb
 WiNg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWaXbnzVq5mHTFZygqiKBeAhwVDthmVspe0hENh409sRTjAlvojqdFLlLAoR+rsTTuI7qDc28o2@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyPExOho9B01s+aNFNqAGPq6Tc7L10R7pRSKirUJa97922b98CF
 XzhKEHTUBs0vLKZ/zml/nff9vXhg+Z32yjv1hdIZc8Y+a+TxULhST9EEVkQs4cmVyzxjcF5yz3J
 MAoFbGImHUtM69/Rx7jRE5Ko0eHk=
X-Gm-Gg: ASbGncv8WhCnHsGbkVXS5fnm8k++gLVT1DV8w/VePdhOwPkjSpTp2/Xj7CnG7VHxU6o
 zD2ras+SixWqlBoqE3VOb8qOiXOmxLvatGdMpVVRtg7LGbup0xaU3akWzeVTU1OQ6PxB9bIT3
X-Google-Smtp-Source: AGHT+IGkQAqVX+MDRMILw0YtR9i6iMI9KuYyxccf6C9LXlRgIPcyWd9dbDjU2gBO1tA4wBcbe8Rl1yWltmTLHYcUx4A=
X-Received: by 2002:a17:903:32c7:b0:21f:3e2d:7d43 with SMTP id
 d9443c01a7336-221040b48d5mr130525715ad.13.1740060514034; Thu, 20 Feb 2025
 06:08:34 -0800 (PST)
MIME-Version: 1.0
References: <20250217151053.420882-1-alexander.deucher@amd.com>
In-Reply-To: <20250217151053.420882-1-alexander.deucher@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 20 Feb 2025 09:08:22 -0500
X-Gm-Features: AWEUYZmH7n-J4pdID-Gbt_Ubv5ZtjOVDv1UbvJ66j9xAALjB-6p7CCfjQGwrQc4
Message-ID: <CADnq5_P_oZ808SbHf3Vpga8x+c=WopRpBWUuL2=KpuXwh6cUPg@mail.gmail.com>
Subject: Re: [PATCH] PCI: fix Sapphire PCI rebar quirk
To: Alex Deucher <alexander.deucher@amd.com>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org, 
 amd-gfx@lists.freedesktop.org, Mario.Limonciello@amd.com, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Nirmoy Das <nirmoy.aiemd@gmail.com>
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

Dropping this patch.  Will work around this in the driver.

Alex

On Mon, Feb 17, 2025 at 10:48=E2=80=AFAM Alex Deucher <alexander.deucher@am=
d.com> wrote:
>
> There was a quirk added to add a workaround for a Sapphire
> RX 5600 XT Pulse.  However, the quirk only checks the vendor
> ids and not the subsystem ids.  The quirk really should
> have checked the subsystem vendor and device ids as now
> this quirk gets applied to all RX 5600 and it seems to
> cause problems on some Dell laptops.  Add a subsystem vendor
> id check to limit the quirk to Sapphire boards.
>
> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/1707
> Fixes: 907830b0fc9e ("PCI: Add a REBAR size quirk for Sapphire RX 5600 XT=
 Pulse")
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Nirmoy Das <nirmoy.aiemd@gmail.com>
> ---
>  drivers/pci/pci.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 225a6cd2e9ca3..dec917636974e 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -3766,6 +3766,7 @@ u32 pci_rebar_get_possible_sizes(struct pci_dev *pd=
ev, int bar)
>
>         /* Sapphire RX 5600 XT Pulse has an invalid cap dword for BAR 0 *=
/
>         if (pdev->vendor =3D=3D PCI_VENDOR_ID_ATI && pdev->device =3D=3D =
0x731f &&
> +           pdev->subsystem_vendor =3D=3D 0x1da2 &&
>             bar =3D=3D 0 && cap =3D=3D 0x700)
>                 return 0x3f00;
>
> --
> 2.48.1
>
