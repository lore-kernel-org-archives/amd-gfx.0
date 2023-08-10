Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46935C001DB
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Aug 2023 12:33:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2AE6010E187;
	Thu, 10 Aug 2023 12:33:31 +0000 (UTC)
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com
 [IPv6:2607:f8b0:4864:20::f34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 990C710E4B0
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Aug 2023 09:44:26 +0000 (UTC)
Received: by mail-qv1-xf34.google.com with SMTP id
 6a1803df08f44-63d48c3d242so4383656d6.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Aug 2023 02:44:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=vt-edu.20221208.gappssmtp.com; s=20221208; t=1691660665; x=1692265465;
 h=message-id:date:content-transfer-encoding:mime-version:references
 :in-reply-to:subject:cc:from:sender:from:to:cc:subject:date
 :message-id:reply-to;
 bh=u8N5qvppFagZ3/tTB5uDHm2P4arYErRxqlmJ6dmhhhE=;
 b=xN6cFEhFHyEsngG5emJdOap4+V+nE6gFuMUzdro7EScDcVOWsmda4a5Yw6aRYSrt8n
 jm6Qhipnw5nThRxhfFbcBO1m2y5tY2Ujx3HgkIjezxPQVeIv1v9hHy1pHLyfoDsAnXGj
 /Ylx9F9FHNKWVrZBMKqTl26kNfACgEs9xzcd5TJ4orblhIamQjkHYgTfnXWo1XhtIBmj
 y1VFqUqNVnZLVgbDuZbbxpiacez7Vyr+rjFYdLFRKFbS0UnsgVHbOGIHGLNOgQnVTd/Q
 UL3HE11PZFFHeTizd0aJPaX5X2DsdjBvoj1OOfHioowZCvCVBUbZ5sR5HHbzdGe+8wFu
 o7GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691660665; x=1692265465;
 h=message-id:date:content-transfer-encoding:mime-version:references
 :in-reply-to:subject:cc:from:sender:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=u8N5qvppFagZ3/tTB5uDHm2P4arYErRxqlmJ6dmhhhE=;
 b=IC8QWaO0x3uShzK7xSUI7ocRFObAWOd5G3sqgIcvcL83OTnN4tXFWD6Bz1HCrVLD1r
 kAtIDg67IknoCsCnZ0uYi3urnaUV5vaTPVC5A9y4cKun5lFDZyEdAsDceElb+2IHNcSh
 H5tV7yLJ6mMBBjC60XdsJVW2hnjxOoFyBkAEAmdpfbZZ784gPbMLW9Ys7ocwScfX9TAB
 w/SYZ0zRF4bOkM/skv0qHI2V6Qh2iZ051D9yaaExQy9fIseaRgUwy5ylC8lgWrtDKiHz
 azUD2WM5LZPe8opn4fSyTx8PASaHjI+6mXAmbT4C8LVS1aJSv5shBKmCqt/XdRfeKwcx
 zAtA==
X-Gm-Message-State: AOJu0Yz+SiN8Vwhzprh4eO4N/nVS4xgIEu9CFVLY91AL0eu5QcUY7Qvr
 T1VNqRPGO9COEF3D2RdaT/aIHw==
X-Google-Smtp-Source: AGHT+IEESh4xDID3zF+wAoEy9DnzJiY8LmKtY7N2rL3KylyDhQ2C7CAYIv8R76yPbkgFvDGO0D11aA==
X-Received: by 2002:a0c:edc7:0:b0:636:60c6:2034 with SMTP id
 i7-20020a0cedc7000000b0063660c62034mr1813651qvr.38.1691660665704; 
 Thu, 10 Aug 2023 02:44:25 -0700 (PDT)
Received: from turing-police (c-174-179-75-62.hsd1.va.comcast.net.
 [174.179.75.62]) by smtp.gmail.com with ESMTPSA id
 x6-20020a0cda06000000b00631f02c2279sm352804qvj.90.2023.08.10.02.44.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Aug 2023 02:44:25 -0700 (PDT)
From: "Valdis Kl=?utf-8?Q?=c4=93?=tnieks" <valdis.kletnieks@vt.edu>
X-Google-Original-From: "Valdis Kl=?utf-8?Q?=c4=93?=tnieks"
 <Valdis.Kletnieks@vt.edu>
X-Mailer: exmh version 2.10.0-pre 07/05/2021 with nmh-1.8+dev
Subject: Re: next-20230726 and later - crash in radeon module during init
In-Reply-To: <129403.1691660102@turing-police>
References: <129403.1691660102@turing-police>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1691660664_2972P";
 micalg=pgp-sha256; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Thu, 10 Aug 2023 05:44:24 -0400
Message-ID: <130185.1691660664@turing-police>
X-Mailman-Approved-At: Thu, 10 Aug 2023 12:33:24 +0000
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
Cc: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 David Airlie <airlied@gmail.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--==_Exmh_1691660664_2972P
Content-Type: text/plain; charset=us-ascii

On Thu, 10 Aug 2023 05:35:02 -0400, "Valdis Klētnieks" said:

> I am seeing the following consistent crash at boot:

> Some quick digging indicates the most likely culprit is:
>
> commit cbd0606e6a776bf2ba10d4a6957bb7628c0da947
> Author: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> Date:   Thu Jul 20 15:39:24 2023 +0530
>
>     drm/radeon: Prefer dev_* variant over printk

Nevermind - I see it was already reverted...

--==_Exmh_1691660664_2972P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Comment: Exmh version 2.9.0 11/07/2018

iQEcBAEBCAAGBQJk1LF4AAoJEI0DS38y7CIcCQMH/0Z74jwPSDcxxmLstOYKJ7lY
ApFXhH94MxeGEa7o0qtmysWn54I7/MmPHQMOZ3ZZWHHOF0QqpgahtO9Dm7XpFG9j
jwlFr+vODziew8p4dBjJ4BEZk9TpVoE8BOA2yUMpSylOGmw5t8uz3fUjEVGhtG8a
x/i+mZ/adPxymbtZ0h0NnhLabGXMYF5VZ2R2ZAbBwKOYR82UcNMEzm/IIWUOtapw
sa0+tgnGXe4PasXSXvx/TOaGJVIsPLLy2DwMu8EKwLT/KelLDS+cTPYlwZ06A1pg
CmYDOTTaB7cl0UxTmSfOduHo9o+Twx5ziyAuBfJ2540A2LXa2zDlgU//mb28jA4=
=kY7M
-----END PGP SIGNATURE-----

--==_Exmh_1691660664_2972P--
