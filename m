Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BA3FC021A0
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Feb 2025 10:34:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B17D510E0BB;
	Thu, 13 Feb 2025 10:34:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="KJq7nlrX";
	dkim-atps=neutral
Received: from mail-ed1-f67.google.com (mail-ed1-f67.google.com
 [209.85.208.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A445010E29B
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Feb 2025 22:43:02 +0000 (UTC)
Received: by mail-ed1-f67.google.com with SMTP id
 4fb4d7f45d1cf-5de5a853090so394048a12.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Feb 2025 14:43:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1739400181; x=1740004981;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=sVpfejHVAgrScsj2m/Clnt/hk7cG3yg5PRzNkuTsI54=;
 b=KJq7nlrXq5tv+q0sHhmoA5D0SGt8zcHk/p34yzJpxMrsOEXExEAt4CsjfjjNvKWUcs
 LNSHZr7YfzQez/uuVXNElzgF5fZP4Y5eze3cUtkLts8Mty9m2sW6/XAmAJIF3Cx3XyxS
 M3AIxiOUvKVXMAnC8ezu3n4rvrI58Xt+2/IkHbK6BG+RtZA2mEnh3tIrsvQfuwSgPq2+
 CnaluTAvDDsLnbqfrTMRNvGYKQjOsCwHwBSkdSLC6GcNe1ViQ2Dbd3PyTdGw3hBRj4hg
 BkSUOGTPUwzy6hXTqBvAtuNOGQcrCwuuxE06i4QX35bNmehdCCi0EBpln+qQxBm3L08x
 /jiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739400181; x=1740004981;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sVpfejHVAgrScsj2m/Clnt/hk7cG3yg5PRzNkuTsI54=;
 b=GMpTW6+4A3mmLznb6vOV7/7TjKMwAYobC/PMjuO3lBNJsa+45DiB2U6OHmdEpWTVnI
 CCbKISSBEiX+zQvm9uiVbI8fSSY32bPcXXxy0oClc5Jwsr+dXdT88K4+NEaqQj8EsCJF
 jMgn084C4nNuNwXCtfPlO3umSw+Fwb1rAIMQaOFiWroWtbkzFaHNB2b0oKEf9gvwEujN
 hssW+i9GFDupqTgjex1j+AfFPRrAHxvAEju76mqZiUUUQ8fkknKd71RNlChR8VBgRQVL
 W5IlxjQ28i+Y+VaYxAofsbY2m8GGu4ZKIRNSF9xlFBXf94UuRsDMlhUxorbgehqgMSzg
 EYUw==
X-Gm-Message-State: AOJu0YwQlU4qJ6zCbgIj084CW+g++hvLwLadtDRH5wTxPBDqV5iCJaDh
 gw7Qi+v+7T1que01rz1/EzU/p3o1hMcxWry7Es//6KBk2XkLiD//cvPF/uR50XI=
X-Gm-Gg: ASbGnctbwBUK57XMuvWfRQKfxIA9J4O18BtZuMrMKVbrJ1NuUljqBdlQQmRcyTRDiqR
 XO6z9Rz3ObdcInHlvUmxWGJ5zr9zzXZz4sAmOk/y/30j9rk5g1QI2LX4PMkwNDVRF9aump4NeyT
 7zDji/5p56TyLjMZ1pBEVQFlJKN+/I98PWvkzxpk40ccMH1KYhMj0CYPmTpoYYNlG3M/WS7o5pQ
 Bj3l+dCuEuwD4pTc/axIShx+ofLA8B0z19w1OC+SJ3pFugvoX+G2j6FNSKArDLa2pBXz5V6hZdX
 wMVsv4AxJMhE6eNGjcoM
X-Google-Smtp-Source: AGHT+IHEKbocUnqnlR+Rtf0hLyFJogHnkyCAOnjAMiGKbIRjZZT7rtNV2MioCmUXnZMPgwRVv//7qg==
X-Received: by 2002:a17:907:7b06:b0:aa6:7737:1991 with SMTP id
 a640c23a62f3a-ab7f334aa67mr497408166b.2.1739400180892; 
 Wed, 12 Feb 2025 14:43:00 -0800 (PST)
Received: from localhost ([2a02:8071:b783:6940:36f3:9aff:fec2:7e46])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aba5339dda8sm6417966b.154.2025.02.12.14.42.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Feb 2025 14:42:59 -0800 (PST)
Date: Wed, 12 Feb 2025 23:42:56 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Philip Yang <Philip.Yang@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Felix.Kuehling@amd.com, 
 Alexander.Deucher@amd.com, christian.koenig@amd.com,
 regressions@lists.linux.dev, Dieter Faulbaum <mail@faulbaum.in-berlin.de>
Subject: Re: [PATCH v2 4/9] drm/amdkfd: Validate user queue buffers
Message-ID: <zpzehsckjz2bee6w5bsnfpmkvtlxf6jywijz7iroausghoh43i@nxr644rwjsb3>
References: <20240718210558.26340-1-Philip.Yang@amd.com>
 <20240718210558.26340-5-Philip.Yang@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="vogrexjxudlhcvkm"
Content-Disposition: inline
In-Reply-To: <20240718210558.26340-5-Philip.Yang@amd.com>
X-Mailman-Approved-At: Thu, 13 Feb 2025 10:34:09 +0000
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


--vogrexjxudlhcvkm
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 4/9] drm/amdkfd: Validate user queue buffers
MIME-Version: 1.0

#regzbot introduced: 68e599db7a549f010a329515f3508d8a8c3467a4
#regzbot monitor: https://bugs.debian.org/1093124

Hello,

On Thu, Jul 18, 2024 at 05:05:53PM -0400, Philip Yang wrote:
> Find user queue rptr, ring buf, eop buffer and cwsr area BOs, and
> check BOs are mapped on the GPU with correct size and take the BO
> reference.
>=20
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
> Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>

This change made it into v6.12-rc1 as 68e599db7a54 ("drm/amdkfd:
Validate user queue buffers"). A Debian user (Dieter Faulbaum, on Cc)
reported that this change introduced a regression using a gfx803 device
resulting in a HSA exception when e.g. darktable is used. I didn't even
try to understand the problem, but maybe one of you have an idea about
the issue?!

See more details in the Debian bug at https://bugs.debian.org/1093124

Best regards
Uwe

--vogrexjxudlhcvkm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmetI+0ACgkQj4D7WH0S
/k7M9gf/SEogOZOC8jKLeLY8lsbtucwWMIx5UgloDwPf1RnhR+eCh1xjqKNhwt7+
Waidj24QuKlzZovTx3oTmsAWeijaq9SHyOJX2o9hd1TdXuhcOHZvrarLFn1ZhYOs
yflyCYl5jgb7vuby9TDAvBB7tjRcLt6PLkKJew9rAp9aQvVq/L3DFNmdh1y8R9US
TCfJGIGwGNaBpeXUM4VjiwIXpLQ04Xg8mSTFmNN5Zn61Wiz6Vm/vKG4iosvep/ll
XIS9mkk/Jk7ilzAfEN70w3ALVRYpDYItXH2u9rB9mTa/zQJQupar1AulICSVoneJ
suBobOj6sV693GbY2/EBerRqU+JZ8g==
=May1
-----END PGP SIGNATURE-----

--vogrexjxudlhcvkm--
