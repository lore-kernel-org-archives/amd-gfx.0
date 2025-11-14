Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CCDACE7B14
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Nov 2025 14:08:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4A4E110EA7B;
	Fri, 14 Nov 2025 14:08:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="YU++uOa/";
	dkim-atps=neutral
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com
 [209.85.128.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B69FF10EA6B
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Nov 2025 13:10:14 +0000 (UTC)
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-471191ac79dso21250805e9.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Nov 2025 05:10:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763125813; x=1763730613; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EJ9S8y/liwc1XSXK0RvzbAJey2hh3NqcyHJfhnjyxSE=;
 b=YU++uOa/prmyZdae+fODyXW3wecgtfGXB+Mt8uCcw5T07DnltADGzjPP2nkrVrU61g
 FwploZLaPwsU5qgTnCw6xYlJgyi7WWLUdeMIt/9xe9sSs4wOdN84qY+WcE1Q7EbMApLG
 4m90WEdsyuJiHaS3Rg4fSqO6o9YZlYNl37ZgfweAtZK+dXxKosJM707C1+SuT1wfj1mn
 7M/2Nb/PfqPna17ZfJAJx2CPguUDmUMF2XMoFMr1pha5FcsnCF+2Emj3ToYBcO0ALLyF
 nhf/zMjhLcBQt6P9YQAEudvWWnUhSt9DlC5bB7jpTraP223MuehUpjT5BPgbOtMSWrtJ
 S/Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763125813; x=1763730613;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=EJ9S8y/liwc1XSXK0RvzbAJey2hh3NqcyHJfhnjyxSE=;
 b=XEXE1O4kDIBG/LR3bSBp/KW3CX/wLokAmEV0YiNNq0e2/dZ/jFcroAmpZ2rGQ6Dd7X
 xX/rUU3YxRJtfQjR/ujj+uYGgrTsaMc1/5p1BdD7yDoLGDxAzFn9DF/hTELmtrgARA9V
 dt8+8QDKgk3llgLt3KQD49tFGBPOd1fQBFBq/N9kzBPJiGIL/8N3lK1oMRLJakAC2alZ
 c4o2/cYbfdXlYyTGgmAfl/hpLii9+lDT4BCaBV7bRqAzGUqiCiD0NCrbY1oiCwxlGxbc
 vhphqytS60xVwDRhCD33UymBMchz4vci/bjHyxbeRjlcHpCkNEOcEa6hS0ZeVw07OY4c
 mvzA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUg6F170jF2ccUMgmpUKgchc2XbdKnPOsjfmfxj9KUdjLN005XXmEhgLL/QIoKshF0a7vvegnQC@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzDIq9XZTpQLQ3qLYJH89Tt2WICBnxPnsuksxDh1ioZPRyJC1GT
 5KnvxXIoH0zLWFOu2M8fbvfjs6MPaI1Ek/Ba18mJ6sIXWqdThaySWH51Mb1AcgW7+3U=
X-Gm-Gg: ASbGncvUbYSm2TetQmBGoSHURBLowRxcO5s/w5IcjM2ZGCjqQnaNBXi5aiioAC9GV50
 Yl4YuP2jE/JxSwZISixjJgOHG8QQo5+JL/QqEMt1P64/O25+Uq3A+4ntO3zI+Qn9UKxcN9ZwcYu
 UAfrio2tbL6zgMGIxIUqZ3m7vBdxtod53HHjMneYXPXs5nDMlwwxeu//YjggIBDhPYMXFNh0wbw
 95yn2USXSXVe14d64WvGuNDAwKyJ/J7A2/jU/SfrJEWeOhUSLFNPhxTNNTiuhW+eVKJULxdzENO
 16UymoWgahj4OMrX6W/SUKxDguMnZLJLSmDNO/pNOvYz0BNJK3mMkrabGxMoCk44/ebDxH8sWPe
 sMpt9XouW4rv9cAUrYrNsKApZyhzuNQApIN/5bhVOtRKDzq5ZoU5vDBnoL8fgOZIs4bW45ZrywA
 1q
X-Google-Smtp-Source: AGHT+IFRUwKdmMnVHD85N3NvYRNZUnPZKMrSMMhF+DQcXz4gku9fHv+s1niWianlCFXxAAY6/RwthA==
X-Received: by 2002:a05:600c:3587:b0:477:63b5:7148 with SMTP id
 5b1f17b1804b1-4778fe55174mr31972855e9.6.1763125812943; 
 Fri, 14 Nov 2025 05:10:12 -0800 (PST)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4779527a656sm5951845e9.10.2025.11.14.05.10.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Nov 2025 05:10:11 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 1B92A5F820;
 Fri, 14 Nov 2025 13:10:11 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Ilpo =?utf-8?Q?J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Simon Richter <Simon.Richter@hogyros.de>,  Lucas De Marchi
 <lucas.demarchi@intel.com>,  Alex Deucher <alexander.deucher@amd.com>,
 amd-gfx@lists.freedesktop.org,  Bjorn Helgaas <bhelgaas@google.com>,
 David Airlie <airlied@gmail.com>,  dri-devel@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org,  intel-xe@lists.freedesktop.org,  Jani
 Nikula <jani.nikula@linux.intel.com>,  Joonas Lahtinen
 <joonas.lahtinen@linux.intel.com>,  linux-pci@vger.kernel.org,  Rodrigo
 Vivi <rodrigo.vivi@intel.com>,  Simona Vetter <simona@ffwll.ch>,  Tvrtko
 Ursulin <tursulin@ursulin.net>,  Christian =?utf-8?Q?K=C3=B6nig?=
 <christian.koenig@amd.com>,  Thomas =?utf-8?Q?Hellstr=C3=B6m?=
 <thomas.hellstrom@linux.intel.com>,  =?utf-8?Q?Micha=C5=82?= Winiarski
 <michal.winiarski@intel.com>,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 08/11] drm/xe: Remove driver side BAR release before
 resize
In-Reply-To: <20251113162628.5946-9-ilpo.jarvinen@linux.intel.com> ("Ilpo
 =?utf-8?Q?J=C3=A4rvinen=22's?= message of "Thu, 13 Nov 2025 18:26:25
 +0200")
References: <20251113162628.5946-1-ilpo.jarvinen@linux.intel.com>
 <20251113162628.5946-9-ilpo.jarvinen@linux.intel.com>
User-Agent: mu4e 1.12.14-dev2; emacs 30.1
Date: Fri, 14 Nov 2025 13:10:11 +0000
Message-ID: <87ecq0pxos.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Fri, 14 Nov 2025 14:08:08 +0000
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

Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com> writes:

> PCI core handles releasing device's resources and their rollback in
> case of failure of a BAR resizing operation. Releasing resource prior
> to calling pci_resize_resource() prevents PCI core from restoring the
> BARs as they were.
>
> Remove driver-side release of BARs from the xe driver.
>
> Signed-off-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
> Cc: Lucas De Marchi <lucas.demarchi@intel.com>
> ---
>  drivers/gpu/drm/xe/xe_vram.c | 3 ---
>  1 file changed, 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/xe/xe_vram.c b/drivers/gpu/drm/xe/xe_vram.c
> index 00dd027057df..5aacab9358a4 100644
> --- a/drivers/gpu/drm/xe/xe_vram.c
> +++ b/drivers/gpu/drm/xe/xe_vram.c
> @@ -33,9 +33,6 @@ _resize_bar(struct xe_device *xe, int resno, resource_s=
ize_t size)
>  	int bar_size =3D pci_rebar_bytes_to_size(size);
>  	int ret;
>=20=20
> -	if (pci_resource_len(pdev, resno))
> -		pci_release_resource(pdev, resno);
> -
>  	ret =3D pci_resize_resource(pdev, resno, bar_size, 0);
>  	if (ret) {
>  		drm_info(&xe->drm, "Failed to resize BAR%d to %dM (%pe). Consider enab=
ling 'Resizable BAR' support in your BIOS\n",

This didn't apply, I assume due to a clash with:

  d30203739be79 (drm/xe: Move rebar to be done earlier)

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro
