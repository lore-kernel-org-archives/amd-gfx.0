Return-Path: <SRS0=JNIh=LB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C011C47082
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Jun 2021 08:06:38 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 01EB4610A1
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Jun 2021 08:06:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01EB4610A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AD0646E86F;
	Mon,  7 Jun 2021 08:06:37 +0000 (UTC)
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com
 [IPv6:2a00:1450:4864:20::22c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3FF056E86F;
 Mon,  7 Jun 2021 08:06:37 +0000 (UTC)
Received: by mail-lj1-x22c.google.com with SMTP id z22so5003310ljh.8;
 Mon, 07 Jun 2021 01:06:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:in-reply-to:references
 :mime-version; bh=eyePaBGmpqwFtJTw3decZ+zo/NqxGl1QTrI3CsTKpHg=;
 b=i0msT2A2akzBLZIXg3oeRXhAt6dYn7/C38kxE8AlxMO7R3DjKzmlHBrlWWB6B/uKur
 Z0J3qKbkl29HWYuy7ycZBH10+ih2aNggNLlT68Is/WWsKJ+w8pTi9LvpeI6AhGuH1s/T
 hN7OxVhiaXL94s2P0UOkRlUsXGBz82Vs7RNodB/QAh+ibRi7VHWIIDY/0uZsbvATP/OI
 V+jc3U60beCfXWYKhuCL45aCQpUJ3mo3MCUSPkeuO2kbSNlZGoQutRdAJ5WrVRL0og7W
 6gO8d12jy+rof6ynBRn3d22ETp+c2uZkVMlznRV1zj+PXQWpMOJ63dmhjQ+FdV4rj28U
 wBuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
 :references:mime-version;
 bh=eyePaBGmpqwFtJTw3decZ+zo/NqxGl1QTrI3CsTKpHg=;
 b=J2K4QKLvB71Xxv4qVpXd1TPiHEnNG0rYhSQ6nvm7KRf7Hz4gZ0Zaa1oshR+MFz+vAi
 SVRNXGu9zKsZu88wcWcApA7ZoDC+5ZEfqYRNciOSjjkYD56RFd22E0l/YpTCfNpsqfqO
 S0wU4JIInT4FS2vis94pboQlM4aJzSelr3gZUi4n4CdLMrmWzDgbZWfchCDZZYqBDnw+
 8Kks6T1rkiPhO6b2ZGf3e6Bp5X34Rk+h5EQP+sh4GNabqfktHHOFCkV9+3PBkmhXUl4a
 P49Zr+C54I+E7Zmyd9qFiN5/VYx7AI2BTWI1UT5+gWkF8cf3ZkywI/pjZ4kxOKYGs0OQ
 /pxQ==
X-Gm-Message-State: AOAM532irRWp+btyS5D/ufCyebrLK6LcE2lBM888YZsvO8zqQV/UUIBG
 7+Do6x/tFh29Qv/ZaohreqY=
X-Google-Smtp-Source: ABdhPJy0L81pGMA1sdOx3mHywKnkhaSeCHCIbhmKJCwXq18AwhWRUAmr1THrUkJx3nG3TqZFDpb4fQ==
X-Received: by 2002:a2e:9f4c:: with SMTP id v12mr13494509ljk.176.1623053195729; 
 Mon, 07 Jun 2021 01:06:35 -0700 (PDT)
Received: from eldfell ([194.136.85.206])
 by smtp.gmail.com with ESMTPSA id bu14sm881716lfb.65.2021.06.07.01.06.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Jun 2021 01:06:35 -0700 (PDT)
Date: Mon, 7 Jun 2021 11:06:32 +0300
From: Pekka Paalanen <ppaalanen@gmail.com>
To: Maxime Ripard <maxime@cerno.tech>
Subject: Re: New uAPI for color management proposal and feedback request
Message-ID: <20210607110632.6ec38e38@eldfell>
In-Reply-To: <20210607074805.bmonbg5nhr4etab2@gilmour>
References: <8c0d7ad8-7ade-bf8a-0414-cc795fbb6aa2@tuxedocomputers.com>
 <20210607074805.bmonbg5nhr4etab2@gilmour>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
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
Cc: "Deucher, Alexander" <alexander.deucher@amd.com>,
 intel-gfx@lists.freedesktop.org,
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Werner Sembach <wse@tuxedocomputers.com>
Content-Type: multipart/mixed; boundary="===============0037641570=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0037641570==
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/yof8fdu=MosNqMNpnuybyzU"; protocol="application/pgp-signature"

--Sig_/yof8fdu=MosNqMNpnuybyzU
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Mon, 7 Jun 2021 09:48:05 +0200
Maxime Ripard <maxime@cerno.tech> wrote:

> I've started to implement this for the raspberrypi some time ago.
>=20
> https://github.com/raspberrypi/linux/pull/4201
>=20
> It's basically two properties: a bitmask of the available output pixel
> encoding to report both what the display and the controller supports,
> and one to actually set what the userspace wants to get enforced (and
> that would return the active one when read).

Hi Maxime,

I would like to point out that I think it is a bad design to create a
read/write property that returns not what was written to it. It can
cause headaches to userspace that wants to save and restore property
values it does not understand. Userspace would want to do that to
mitigate damage from switching to another KMS client and then back. The
other KMS client could change properties the first KMS client does not
understand, causing the first KMS client to show incorrectly after
switching back.

Please, consider whether this use-case will work before designing a
property where read-back may not necessarily return the written value.


Thanks,
pq

--Sig_/yof8fdu=MosNqMNpnuybyzU
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEJQjwWQChkWOYOIONI1/ltBGqqqcFAmC904gACgkQI1/ltBGq
qqeRjRAAr2qAqV+qFCJ4350hoO6pWNIOtRS+q72DuMuvyBbI8VoCIg+gv4q1O270
gY63QrvH3GPdWsYyTdNCt6BGWS/6aWvpwpLfUzBt4ldcDZxfx+HdJjHAPHlp6puy
DS7Oz4BeAzYPlKHV1EEvyfZ0YnOBsm0/FgxEXmhNUfrUAh7MNzSwL5J3d9qf10EQ
sOtrD4rs6i3kJawKKtnCGYNy3hP0oa0Svc1V4tlYvQJIARE+XioY0a59mOetonRC
ONrn4Cy15MPFa4yCuB4aZTvXfDEN9HawV9udmaFe8PzmjmJD0p1k7YHif+t/FctH
/1i4h1XKWVNb23yPIyTuBVRvgNppJOkkfjia7b16sg93i6Dreo5RfiEKaEwqU/d/
vqsILZQ/XKv5E2wRsJbPnuqtGKEt2kPAnTSkZBnnQn5bJOshCfZe0lPkCNC+1DWw
Fo3buMd3sJbgSYG2UEml8uftNinblkpBQZfropaB5cDJzWJAxHUGx8pdHzFlrHZT
ADQspRyEAW07BbNsXcU//aIs4WfdoOp3FtE+TYsrCLOllOERI6T3YY2PjMmceXh3
iDwwYVXRA+lvAnWra3HWew3dOk5+H1cjv9L2wQpvHjiodqdpqISw8qW2q16KfEk0
raYSjJwCR/vefFajLoYildAjtpGjCv6hf/l4/N5sQGYIQd5hiKQ=
=wYNI
-----END PGP SIGNATURE-----

--Sig_/yof8fdu=MosNqMNpnuybyzU--

--===============0037641570==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0037641570==--
