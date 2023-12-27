Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5F70C46CD4
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Dec 2023 16:12:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 39EBE8903B;
	Wed, 27 Dec 2023 16:12:37 +0000 (UTC)
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com
 [IPv6:2607:f8b0:4864:20::102d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BD28810E11F
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Dec 2023 05:52:29 +0000 (UTC)
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-28c17b6f91bso767360a91.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Dec 2023 21:52:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1703656349; x=1704261149; darn=lists.freedesktop.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Xsm5Ju4rKSSyd/yy5bB4YOrfNpuRcRC6WiB2aAOy3+k=;
 b=VWB/fPRb5EL2w/rkryAdCk6M6V6ysqh/sBRPrh841Y1ix81R9X1IUFyAooYIqq4wss
 3lq8mPSpa9teiSUQV/3FKpq93DHc35HFW3nZ0HtyNn65+OPac9C2KoyvqCjTXUsEFkL6
 M7y4xUYcGui7H3J0PCBrSQMIzJeHMJLSaqH3whU/3bh1280Dwizsdn5FsKDsGJML5Xg+
 aJRWey7mQDeczlSKgBLYHllkLa3eJ7jft6WZv7wDQhnIqeK2SEli867w0iJi1nB3SaDi
 bHQZMVrZUGwrqrmNXJX1cBmh1RkS2aZbxYQGA4xQHVar+rslx2T2CQChkPI09qJzASX5
 7cZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703656349; x=1704261149;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Xsm5Ju4rKSSyd/yy5bB4YOrfNpuRcRC6WiB2aAOy3+k=;
 b=BYKNCXREz14Rk0DkpM71UMdVwEcBsOTWgQj7z1L27uCWL5lV0RznOPRXumhTvjGom4
 3kIv3XMaSvBoRmBkkhxk7dFMsh0gr6Tbfc7S5JI45g5ueZ7MPMoVaqe5BzP5Rp0O00Ml
 0qpxyQvo6ARmRjQbXMGWhPPOMtA+lXUApMAyeH+xQ5KSFrnsS/Y7dN1xkk6DafJiGTd9
 mcHCwdt+e70Ua1ZbhCWWHRNn1v/mchvUwoxDq+2bI7PZJCmpM5K1uj0YON71dW54QWVm
 RhdEOk9EU2Z0b5qI6LuNzASWtrg/UA8PfzBvuUVIhG/H/ooURPe2OteiBxS39SVlf0S3
 Y5VA==
X-Gm-Message-State: AOJu0YwlrbfODs96saRZU6PmULASVozRMoJkvjXye2ypUM0lCTvZn+Ir
 tUtfJHwcyVN6zTe6FUZjVnvE69ETGqcfzQ==
X-Google-Smtp-Source: AGHT+IExDYQd4jUOqkatAsAW34ElSyA+4kT9esf58JKswXuRFYVF514ypvVLQK7Ao04wa/jziw4ymg==
X-Received: by 2002:a17:90b:3c2:b0:28c:374f:8028 with SMTP id
 go2-20020a17090b03c200b0028c374f8028mr1108023pjb.27.1703656349153; 
 Tue, 26 Dec 2023 21:52:29 -0800 (PST)
Received: from archie.me ([103.131.18.64]) by smtp.gmail.com with ESMTPSA id
 e15-20020a170902ed8f00b001cfed5524easm11020411plj.288.2023.12.26.21.52.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Dec 2023 21:52:28 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
 id D253811564AAC; Wed, 27 Dec 2023 12:52:23 +0700 (WIB)
Date: Wed, 27 Dec 2023 12:52:23 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Marcelo Mendes <marcelomspessoto@gmail.com>
Subject: Re: [PATCH] Removing duplicate copyright text
Message-ID: <ZYu7l9LiCJWdw0CB@archie.me>
References: <20231226235741.4376-1-marcelomspessoto@gmail.com>
 <ZYuMRZU85plJiVWO@archie.me>
 <CAB4W1t5GsDUEUT6m_qHeEBC=gnQxyebY8W0n5uF1GGAh5yLgtw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="7Tqr7xErRV4RDN7U"
Content-Disposition: inline
In-Reply-To: <CAB4W1t5GsDUEUT6m_qHeEBC=gnQxyebY8W0n5uF1GGAh5yLgtw@mail.gmail.com>
X-Mailman-Approved-At: Wed, 27 Dec 2023 16:12:36 +0000
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
Cc: sunpeng.li@amd.com, Rodrigo.Siqueira@amd.com, harry.wentland@amd.com,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux AMDGPU <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


--7Tqr7xErRV4RDN7U
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 26, 2023 at 11:49:09PM -0300, Marcelo Mendes wrote:
> Hello Bagas,
>=20
> I'm sorry for that. I will send another mail of this patch with your
> recommendations.
>=20

Please don't top-post; reply inline with appropriate context instead.
And don't send HTML emails as mailing lists don't like such.

When sending v2 (aka rerolling), mark it as such when generating patches
by passing `-v 2` to git-format-patch(1). And don't be rushed to send
the reroll; wait at least a day to allow reviewers to review before
reroll. If there are any comments from them, you should address them too.

See you in v2!

--=20
An old man doll... just what I always wanted! - Clara

--7Tqr7xErRV4RDN7U
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZYu7kwAKCRD2uYlJVVFO
o1UCAP9TiBj/fIiGJmgCvf+j92xuF8SnsZYURkswkTmiEAwilwEAkWigOnNnWcZC
aI05d64L0t/EMQKRKyZBMxZeDa5aRAU=
=OzmJ
-----END PGP SIGNATURE-----

--7Tqr7xErRV4RDN7U--
