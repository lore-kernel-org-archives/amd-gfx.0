Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D012BC10F05
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Dec 2023 14:59:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5BF9710E8CC;
	Thu,  7 Dec 2023 14:59:36 +0000 (UTC)
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com
 [IPv6:2607:f8b0:4864:20::62a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 452E110E183
 for <amd-gfx@lists.freedesktop.org>; Thu,  7 Dec 2023 02:39:26 +0000 (UTC)
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1d0a5422c80so3780335ad.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 06 Dec 2023 18:39:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1701916766; x=1702521566; darn=lists.freedesktop.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=elG8GlXQstrh+7SbheHvlM9Wbdhuu5GKD5vjQyxAHjA=;
 b=W6VrQGIKfrcAiQ9cGm9LXXCSGTuNOWFjGbPKQH6OP1sRo/98HAGDwNoVdXefjFhfWD
 J95FSM3EOABVtB9gTKkt5+2Ze97169JzfVJalIG9cb4AaU6VJP4RLBGg+x7GO+lmf0un
 ZL/sNN3zmsPN19aLQE5y++3V4eAtfEhrZSCgu3F5godjimSJELKydxLOLQn8OEqf6xQY
 dne8rNmYaV4Bt2qxNx+Z8HVyzsn03fjHIiXDgPALGf9p57t8MW8b0x4lN6AFyC9Ej57E
 nZbpdOeeuyLSZaRNT6toOZH7/0KbH0GWq4/AvQtZqu/QvwvGqpq44nYiNnmknzgEtYWf
 siGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701916766; x=1702521566;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=elG8GlXQstrh+7SbheHvlM9Wbdhuu5GKD5vjQyxAHjA=;
 b=Y8mSVZSjfqclL4/o1K4EroUHAqXrEPyp/01ljyqlekycajNlepBai86aaDK4JLjxwq
 BlDmHqSpasQhLMO1lveMFqFF9Yp8ZmBp+RD2M/wa7Vsx+YkdAG7WkLnvRaSl3wvRNvjF
 8TZBjoWBggWWqUyZckLowY8VO7ge5i3E8a3u+AedW37c+z2wzHPKwhkm8TfV4st34hJN
 iIm7SxYJDk3m8NW62u/DsRBsIMs6hrdADXN3vRc6AIX6T/MFv0aZjXkBjJ+EQ/NwtLax
 4iRhdkx8c1MFuv8aIP4ZkQ5gGLoABwQagr7Tq/1CdWvxeaekFqoU3X5nCZl1aeyydq6z
 S/VA==
X-Gm-Message-State: AOJu0YwJkez8lySpj1okFL2ZFfTPCwzTleCwnydUzPikxfJwQTeObt2h
 r8YCPbqMecaascwUbxewTGM=
X-Google-Smtp-Source: AGHT+IEK+qI5y2AHtPi9fYvkLjo2GmFVrcscUkg3UWuixiW/+HC2JdXhLqGPHnNbolOnqpMcPBpTHA==
X-Received: by 2002:a17:902:dacf:b0:1cf:c42c:cfbd with SMTP id
 q15-20020a170902dacf00b001cfc42ccfbdmr2468303plx.0.1701916765692; 
 Wed, 06 Dec 2023 18:39:25 -0800 (PST)
Received: from archie.me ([103.131.18.64]) by smtp.gmail.com with ESMTPSA id
 m2-20020a170902768200b001cc3fae06a6sm149846pll.159.2023.12.06.18.39.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Dec 2023 18:39:25 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
 id E1D9B1143CC84; Thu,  7 Dec 2023 09:39:19 +0700 (WIB)
Date: Thu, 7 Dec 2023 09:39:19 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Dianne Skoll <dianne@skoll.ca>, Linux Stable <stable@vger.kernel.org>
Subject: Re: Regression: Radeon video card does not work with 6.6.4; works
 fine with 6.6.3
Message-ID: <ZXEwV_BRROeu84Zh@archie.me>
References: <20231206172220.37ff4df9@gato.skoll.ca>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="9mKsw2ilVY5K14MK"
Content-Disposition: inline
In-Reply-To: <20231206172220.37ff4df9@gato.skoll.ca>
X-Mailman-Approved-At: Thu, 07 Dec 2023 14:59:30 +0000
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
Cc: Pan@archie.me, Linux Regressions <regressions@lists.linux.dev>,
 Xinhui <Xinhui.Pan@amd.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux AMDGPU <amd-gfx@lists.freedesktop.org>,
 Alex Deucher <alexander.deucher@amd.com>,
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


--9mKsw2ilVY5K14MK
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

[Cc'ing also amdgpu people]

On Wed, Dec 06, 2023 at 05:22:20PM -0500, Dianne Skoll wrote:
> Hi,
>=20
> I had to go back to 6.6.3 because 6.6.4 seems to have broken my Radeon
> video setup.  The full bug report:
> https://bugzilla.kernel.org/show_bug.cgi?id=3D218238
>=20

Can you bisect to find the culprit commit? See
Documentation/admin-guide/bug-bisect.rst in the kernel sources for reference
if you have never done bisection.

Also, can you check if latest mainline (currently v6.7-rc4) still have this
regression?

Regardless, please also report on freedesktop tracker [1].

Thanks.

[1]: https://gitlab.freedesktop.org/drm/amd/-/issues

--=20
An old man doll... just what I always wanted! - Clara

--9mKsw2ilVY5K14MK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZXEwUgAKCRD2uYlJVVFO
o26uAP4pJSbOfEfKR0cpWObUfKDiW5fKckPa8tUO8ExaxMRvWgEAjV139d+uzj2c
9OyU7VsBGW31gkolGGzUhLp5YIce2QI=
=isDS
-----END PGP SIGNATURE-----

--9mKsw2ilVY5K14MK--
