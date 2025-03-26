Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0039DC36010
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Mar 2025 08:39:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 866A410E665;
	Wed, 26 Mar 2025 08:39:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="N5j0YAbi";
	dkim-atps=neutral
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com
 [209.85.214.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 257C710E63D
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Mar 2025 01:55:37 +0000 (UTC)
Received: by mail-pl1-f172.google.com with SMTP id
 d9443c01a7336-224341bbc1dso122815775ad.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Mar 2025 18:55:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742954136; x=1743558936; darn=lists.freedesktop.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=RhoGeUb32vm6SYpduUh6vVqWnZMsaqggCcYZ4Rk0eKo=;
 b=N5j0YAbiYNxsHqXsIj5F6pCyGy9c+pI/7LiUNwg/vqgs1lWAxOA6w599d280z4WXSv
 HY5ny8vRmdIeu0SE26+L0g7qD7O3kxfex/Zwo958ShEhMMrLfJoP9+ZT9mDCkAOYm1Uk
 Bpxxky3wJKGvznNENRSlYhvyF20X3oOs5muROBdRwbodCWNJ5ZBcVj673rcleo/mfXKX
 2W7whIk61Pc3kZA8UGJtMDwQiRvnImdppz/azhtrZyKXbBOOq793qCFR/3EiKfEsDr23
 orCwOgcVJ5IJqzoQ8HCIrtXc0MdCCQBiCgq+hznZTx+fP7QKKPrXStRrhQLlhSUImrjE
 4EoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742954136; x=1743558936;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RhoGeUb32vm6SYpduUh6vVqWnZMsaqggCcYZ4Rk0eKo=;
 b=AWgK3UEHgE51lv3XB+deCx2cfLFa2PR3/rwkZaCVKIRQV4oyz3Nvu/Gmxda3MOMo6g
 6vUNCEKzAtBXQdgPwWAy0KDdDyvQnWhzF0InWuM/JCEVJhKefOsUGEPjrbsBZ3Rxf9zw
 p9hgYnVbzskOFdVx4E2RKQbWKjMaMGrEC97D+ga0Sru5dW6fSK5kMmizhLBL0ivKZT02
 cEbK210Hz0OhjEY4uUfquB/JUmQ1zoHShdn++vdmLcYssK7benCClaPze4VMlY7CEpM/
 3FD6RMVTcSmOwIuhmzyZgBzW62w6GfiyIrvykQ3P5ZrXcP7r1W1Y8nDwhPdEvPybmtZF
 by4w==
X-Gm-Message-State: AOJu0YyRIGqQ7PG9NEIUPSrYvf+C/kzUctm8EbrGT6zGfbQdf6rNIzah
 DpFt3sh/l7yh8McqKTw43zT28q0kSEeztkledtMPpnXiU6t0zYz1
X-Gm-Gg: ASbGncuKH5KNhjAW5tpAgqtb+Hwj/XO/awUhHGiuvKkJilBIWNLOreTK4m9lNFuOn7S
 8uVRp99E9TaAvEFSV62+XcXJYCIpqGgTYT2n5qN4eRapAXg5UrIaeJCGPhUzHOCUXJfEfl+tK3l
 VWymmBBVM5Fi4lrNc7O3A8uu5uGVNQaPopGb6FTF2Xl7Kmztm26xLGFqa6af9z7KjCY5kNcoH+D
 s506YdWhEeMLUUczaLIAQgIEypm56drr2dbfhsYp3j37NMPI7v/dPTmj/sfPRa4xf+JM8deAi79
 W4AvFX1BOr89jaXlGzyUWMCwX7niCJi1nMhfy6hcwLBv
X-Google-Smtp-Source: AGHT+IE7D2EDUvRYr7rRqAPgLAX7soipBYpCk8xJ8LrYa/wI8aAMYAdtBnkhSDtVNtp9+5WRjLi22w==
X-Received: by 2002:a17:902:ce03:b0:21f:4c8b:c4de with SMTP id
 d9443c01a7336-22780e177edmr287235645ad.42.1742954136344; 
 Tue, 25 Mar 2025 18:55:36 -0700 (PDT)
Received: from archie.me ([103.124.138.155]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-227811f33f6sm97643965ad.226.2025.03.25.18.55.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Mar 2025 18:55:35 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
 id C5BF04230C05; Wed, 26 Mar 2025 08:55:33 +0700 (WIB)
Date: Wed, 26 Mar 2025 08:55:33 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 'Christian =?utf-8?Q?K=C3=B6nig'?= <christian.koenig@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Melissa Wen <mwen@igalia.com>,
 =?utf-8?Q?'Andr=C3=A9?= Almeida' <andrealmeid@igalia.com>,
 'Timur =?utf-8?B?S3Jpc3TDs2Yn?= <timur.kristof@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, linux-doc@vger.kernel.org,
 kernel-dev@igalia.com
Subject: Re: [PATCH 5/6] Documentation/gpu: Create a GC entry in the amdgpu
 documentation
Message-ID: <Z-NelWkIAtyAzoE1@archie.me>
References: <20250325172623.225901-1-siqueira@igalia.com>
 <20250325172623.225901-6-siqueira@igalia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="DIB49pRixYM85JwS"
Content-Disposition: inline
In-Reply-To: <20250325172623.225901-6-siqueira@igalia.com>
X-Mailman-Approved-At: Wed, 26 Mar 2025 08:39:53 +0000
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


--DIB49pRixYM85JwS
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 25, 2025 at 11:18:46AM -0600, Rodrigo Siqueira wrote:
> +The component that acts as the front end between the CPU and the GPU is =
called
> +the Command Processor (CP). This component is responsible for providing =
greater
> +flexibility to the GC since CP makes it possible to program various aspe=
cts of
> +the GPU pipeline. CP also coordinates the communication between the CPU =
and GPU
> +via a mechanism named **Ring Buffers**, where the CPU appends informatio=
n to
> +the buffer while the GPU removes operations. It is relevant to highlight=
 that a
> +CPU can add a pointer to the Ring Buffer that points to another region of
> +memory outside the Ring Buffer, and CP can handle it; this mechanism is =
called
> +**Indirect Buffer (IB)**. CP receives and parses the Command Streams (CS=
), and
> +according to the parser result, the CP writes the request for operations=
 in the
"depending on the parser result, ..."
> +correct block.

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--DIB49pRixYM85JwS
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZ+NelQAKCRD2uYlJVVFO
o8sIAQDkGjPRsJ2EtTpo2Ib2Qn/FWZ3h9QNmLPDpIX3hqMAYvQEAx55KZjJDXuQU
ubIbfwJlEd+9PtWYkKY/lcKCQPahsAA=
=b8uh
-----END PGP SIGNATURE-----

--DIB49pRixYM85JwS--
