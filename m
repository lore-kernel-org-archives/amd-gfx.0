Return-Path: <SRS0=Rlnb=AT=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D48BC433DF
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Jul 2020 17:35:24 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 376B0206DF
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Jul 2020 17:35:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="txdPHnuK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 376B0206DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C8F9E6E902;
	Wed,  8 Jul 2020 17:35:23 +0000 (UTC)
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com
 [IPv6:2607:f8b0:4864:20::62b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3CFAA6E06D
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Jul 2020 16:12:02 +0000 (UTC)
Received: by mail-pl1-x62b.google.com with SMTP id x8so17476960plm.10
 for <amd-gfx@lists.freedesktop.org>; Wed, 08 Jul 2020 09:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:mime-version:content-disposition
 :user-agent; bh=O8NVmCrn7rmWx/EasIgqaaIL2HEOytbX8KlkosnSljU=;
 b=txdPHnuKi8jNIzLrEJ2Jsanim9Gtuu9h9TVh3AYwbvPOiYex6jxnL4nHM29ZbFOItJ
 Kr4fPd2Uq6Uaw3WK2H9BUVYJHBbg6NrMs+N46T5+0LFmwGudJiC96NOw53nZXvnYuq9I
 kWdvNsWybDklGVbhpewXqhJuEicCtHfoSATA0m7hPt3I4Ity6uoBdvrcH7jPJAhCYyne
 qAHV1S6w7iGDGM4P1yVQ2kGMbfqM6Jb17TpP5z2XgFlAjj+bmJ9McBEPc4TnIhQVE2bX
 KTIsloHDtoldoaac6b/FxU9EMIbwPRkV7Qt/6mfPY7GqUzEELwKNgPZrcoAA/CtYyCv7
 Z7uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
 :content-disposition:user-agent;
 bh=O8NVmCrn7rmWx/EasIgqaaIL2HEOytbX8KlkosnSljU=;
 b=B4J/4yyhbC01XXs9Di5woSpKvOH8LyOWO7XIs+Z/59V5sgHEy5F23ON2I+nGBF5M/q
 /oobXlNzh6MG28Y7rLqqJw6wkQ9/Vj4K99+2rkNNUvxlwgRIHzHK1RNKbGgi+y9Sia67
 HUompOcSUm1xuICYb0dVil1jp/KvYR/+I/mUwFchr2Qb/3UPNbiQ5AE0IyqxD0KBZfoI
 b1RGa2zv5EaGbF4FauV+Z1othGLJm6PoTu9QWOF17JlnAtRMnoUDs+jw9JG/DYfeDJKF
 8wwCcuAFlEHi0kFlcrnidgI2tDOIx7+BpCrWeO9Tq7lfoEOvszjEJeJge9qPdfxUoceg
 L02A==
X-Gm-Message-State: AOAM532w+Ww7cEBX8UONjloZuV2zUUsmM3Pi3CIUJD2QvmAupeMGdY10
 ++VbaE/cIW3V14UIr6nE19o=
X-Google-Smtp-Source: ABdhPJwZK9rxp3LPxedGPA+AhLma7JOzuo6h4Jy9BY9kWGCtku96xzxKbMxxipK+Yo+nTV4wGra79g==
X-Received: by 2002:a17:902:934a:: with SMTP id
 g10mr40305193plp.83.1594224721738; 
 Wed, 08 Jul 2020 09:12:01 -0700 (PDT)
Received: from blackclown ([103.88.82.67])
 by smtp.gmail.com with ESMTPSA id u20sm305267pfk.91.2020.07.08.09.11.59
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 08 Jul 2020 09:12:00 -0700 (PDT)
Date: Wed, 8 Jul 2020 21:41:46 +0530
From: Suraj Upadhyay <usuraj35@gmail.com>
To: alexander.deucher@amd.com, christian.koenig@amd.com
Subject: [Proposal] DRM: AMD: Convert logging to drm_* functions.
Message-ID: <20200708161123.GA30962@blackclown>
MIME-Version: 1.0
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Mailman-Approved-At: Wed, 08 Jul 2020 17:35:22 +0000
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
Cc: linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org
Content-Type: multipart/mixed; boundary="===============1888364270=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


--===============1888364270==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Clx92ZfkiYIKRjnr"
Content-Disposition: inline


--Clx92ZfkiYIKRjnr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hii AMD Maintainers,
	I plan to convert logging of information, error and warnings
inside the AMD driver(s) to drm_* functions and macros for loggin,
as described by the TODO list in the DRM documentation[1].

I need your approval for the change before sending any patches, to make
sure that this is a good idea and that the patches will be merged.

The patches will essentially convert all the dev_info(), dev_warn(),
dev_err() and dev_err_once() to drm_info(), drm_warn(), drm_err() and
drm_err_once() respectively.

Thank You,

Suraj Upadhyay.

[1] https://dri.freedesktop.org/docs/drm/gpu/todo.html#convert-logging-to-drm-functions-with-drm-device-paramater


--Clx92ZfkiYIKRjnr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE7AbCa0kOsMJ4cx0j+gRsbIfe744FAl8F8EEACgkQ+gRsbIfe
747q8RAAiRLWSZwsG5CBT/ZTm2IXpxxLmCcMsgTF6ntpL2WjPwHGgsECD1NPYR7T
Cdxs0Kc0OnpO/MZqoiaqXhPvfvX61zww/nWX3kl0aDhAh6nZlfQ758hO6bY//fNg
cKmF5WEj2xWxpMNCfvYet/8k74iAcZ/+LVMAo9AgWcWb3tFr/pUqAX+NrtpxEibc
SyOZOF2HuSjVsrQkUmbtcJ1plvhVQ6AUdn4UNIGXaPxxamQvNjXuorqELERoCXZH
GTtiAe3X68D0f3k5nwaE6yqiKwL5qlPMkulOqbW1qPmYB6vQZAdSaHhHVANuTwlS
A3LlnPHvnNtluOukB+obqxZw5MKLCderk1KfHESHudF9am/8IKI5YFSqJR4LtHBm
lJHyfc3b54kljwxTbs6KVP/o6lTjTBX7KuTvj9ZHIbTGRZ0Fip/E5gOkuwU9l2OA
WpB1Rqle/FB3mZFeNTB/Blk1y59aOsRDCqYU91xCDictW7ho8sd5F3h90llFQADL
qbQKhiveae0fcqApt84hjxdnpoc0EWRpcO0Cs4swRyngxu9KFv5LnWy6Zqh/EMJk
jrja2upJzZc7wNWtOQ/Fvn7CaBhhto940aBp/u+rrBg/Ow20sbh3KJdOKABdq2ZJ
FNR22+8vibUNaIJiae6sEx1DisK/izz0XJpf5PnU8ACnBvCEdK8=
=DuJn
-----END PGP SIGNATURE-----

--Clx92ZfkiYIKRjnr--

--===============1888364270==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1888364270==--
