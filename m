Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46BE2C79F9F
	for <amd-gfx@archiver.kernel.org>; Mon,  5 Jan 2026 15:58:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DE8FB10E46A;
	Mon,  5 Jan 2026 15:57:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="eqMwdDan";
	dkim-atps=neutral
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com
 [209.85.214.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ECFAF10E47A
 for <amd-gfx@lists.freedesktop.org>; Mon,  5 Jan 2026 15:57:58 +0000 (UTC)
Received: by mail-pl1-f176.google.com with SMTP id
 d9443c01a7336-2a3051bc432so28055ad.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 05 Jan 2026 07:57:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1767628678; x=1768233478; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cVbZQ91soDHYVgnMTy0/CFemKFtrGVLcjjCXIJxjjPs=;
 b=eqMwdDanpznus9mlYaXpaTkXs4+CAay5nUyIBwWs68/Mod4aLsVvnPil6g8zLC8Vqa
 i0kHRRo9mUck2fJ/zKAwsL8X2K2HB5hCL0DLMXc80udS/Sav2AVDfB7FYpU26fsBQr2Q
 75kfMgD0mW83MHoOkJ79qbwBlufoLRDybSH/QVAQfggFB7eqgto+eieAGBDiy9tLOtvM
 bh3KiQ+sdgsU2JGfldDECDqhjahX+1uMylKpWULGoGCYx4dPuR515iUDtZZFy35SCPsk
 3HblcN9EnOjhZDjc0hOihYonZUfq5dOKuHwHD/95yweuBiFxueSzGm4lWSU7vQPqQJGs
 brFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767628678; x=1768233478;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=cVbZQ91soDHYVgnMTy0/CFemKFtrGVLcjjCXIJxjjPs=;
 b=lBApo2hTqXgkoI4RPVxYIChS92RRd8QwTs/hXoCmDCip7hUHbhhPvZGWiJjoI7lnzx
 SwGfZtIbQvel+5KK3YtUlir4pSG7Phsei/P7kEnz6IUTlI8BoOBUaaO/Lf8M9achBTfP
 Ls4gb4oE5dv+HSlccqEdHzjq1i9OADWf61pNQENLtfXPW9gXTGl+XIw2FWzdgkd8TEBK
 6yvuJoRGs/VkZs5QmavBAcl7YIdxGnvubseAVyJZC36JOPf02oiVJjv+2ZLA3FBF+eHt
 eERF+BlaXyLZidlaLJR5F9/9ED0fx41tQ2hAK4vXuI7FmBZ5Eg/b1A2OaArX3jbm/l/z
 7f0A==
X-Gm-Message-State: AOJu0YzLSOS2C063K19H2wZLRW3JcKj23ZEYD/4eh0DLa4yeUeY42jRa
 ytovPMtCXD4wuTAMX83uc/7AphBqS6FO4y2U+Zq4WTUU5eVUanMATE8Da4no5BB29RktiRCpJkA
 ZHANnXkmw4keXioTlWGQkbCWSYeE12JrCeg==
X-Gm-Gg: AY/fxX7dSO+UeyqhY38eTHFS8ftfONVqMf5ta98njQhlJYx6ISpptyldAHdLm0uyiTk
 WrWS8VU5ZWKgzc2gy/wALfB13Nt8GSdMFseBkT2FHCW71BNFZnSPAb1pRLn9sSYhz4c6sAcvNxl
 e+nLOGXACRuorghzmENKuIjZDWLipYXS4M6vF0Ki5I1MCdW/FDZtVY1pqMpvDYdNsCFDO3L5dYg
 LEVdd5t/u6GUi11D8cz6eBEumDuWlQ5ZTfIuvc7R3m4/LAh6worWzh/wJwOXD87lX6RvoYe4Br+
 PuHDSfk=
X-Google-Smtp-Source: AGHT+IGPF4hyaYlbtnbTQsm63mFqBhF+I8/kxOQfEKXpDlbvw201/0g7Um9ViM0FAyZdKhiaB435NF2qZTv1k+m6Mro=
X-Received: by 2002:a05:7022:4298:b0:11e:3e9:3e9b with SMTP id
 a92af1059eb24-121723088c9mr25134317c88.6.1767628678281; Mon, 05 Jan 2026
 07:57:58 -0800 (PST)
MIME-Version: 1.0
References: <DS0PR12MB79939AFCEC76469487E48C82F786A@DS0PR12MB7993.namprd12.prod.outlook.com>
In-Reply-To: <DS0PR12MB79939AFCEC76469487E48C82F786A@DS0PR12MB7993.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 5 Jan 2026 10:57:46 -0500
X-Gm-Features: AQt7F2oF5JeYiud5gDhrWkNQgiKQIwoy-ZeWpVD40GMtbf-rwvcY84_fV1CCiLw
Message-ID: <CADnq5_O-C=4_1XjHSpZo+-gCCv_dMLVDNu-CkPE4JWEu3C_zyg@mail.gmail.com>
Subject: Re: drm/amd/amdgpu: Port over some missing registers and bits from GC
 10.1 to 10.3 (v2)
To: "StDenis, Tom" <Tom.StDenis@amd.com>
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>, 
 "Deucher, Alexander" <Alexander.Deucher@amd.com>
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

Acked-by: Alex Deucher <alexander.deucher@amd.com>

On Mon, Jan 5, 2026 at 10:36=E2=80=AFAM StDenis, Tom <Tom.StDenis@amd.com> =
wrote:
>
> This adds some regs and bits missing in the GFX 10.3 header that should h=
ave been copied over from the 10.1 header.
>
> Tom
