Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82931C36011
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Mar 2025 08:39:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C309310E66B;
	Wed, 26 Mar 2025 08:39:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Awl3BWcL";
	dkim-atps=neutral
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com
 [209.85.216.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E0B1E10E63D
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Mar 2025 01:58:25 +0000 (UTC)
Received: by mail-pj1-f47.google.com with SMTP id
 98e67ed59e1d1-301918a4e1bso8411876a91.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Mar 2025 18:58:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742954305; x=1743559105; darn=lists.freedesktop.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=AeXFszc7HISwc/6qx4eotMeyW2rrTjB9ur7q0g6J/Ko=;
 b=Awl3BWcLM1h7vqBq937I5GbvIcq6Si3qDE4sPaPT5K1wHAymERH4Ux24D4CRB863+b
 yGr3LC47Sct7Az7NdG/u4xkTk+/OhvF8cRTViWjwk9V8u9eaNygduHbbgLkXDngqHB7G
 rmolRejhjrW3creq0r8RjftWNMcO2jg2BKXdzkKBYDZbbrXsv2Yh+QlIPpCT91ob32da
 Fs+5kGp4UbvBNP8OJvqsGtI7T0+l47Nn2n63xLcYlFbE9HfC4CQ5VpujNe24m3xTBCLx
 QCELrKohsCsST9uJYVzcctwFxqudTmb43YN3wlQiw0zNMMwogj5uCk2Dqm/0TcwwC5pm
 QUeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742954305; x=1743559105;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AeXFszc7HISwc/6qx4eotMeyW2rrTjB9ur7q0g6J/Ko=;
 b=InBDnW0HKz7Zjye2q+3olUo04Vd35Ec1bmhehBYOV2oL1UE2RNdAazwuHNKF0dA4YC
 O/5CmMDeab8Nn9Uycx7uhbi29PEVBkoupfVhVXT5twcWLDe2JaAI4c4YN59TFA7fvVej
 ha3qQHRT3QeVLj6GSmR/KOFTdtaA0kZq0P6wFAgQsj5BQRKbNWSw1zZjEEjZoOIlhx7R
 DS6GXOpOuo34fmB/b6g5zucK5V3igYdjT/uBmbxDuTEgyJlTC74WvGA5AwUWSJ8Coz2t
 l+s0wm/iAuIW90SIoI6lJgHbC3nXf663flQ5Ou0r6ZcYj49DtQvP84MPgG1ul5knz/++
 PusA==
X-Gm-Message-State: AOJu0YwOYpVQh5OWn1JWT6veXypndc60VUxnxWdoUqM/qUNRQ30K+g35
 bffT0AwkhPmBqo5VLhZRG1obaVveNnSx98ja6ENyJ4Z8zpuKBPNI
X-Gm-Gg: ASbGncswglmf/luGP/x4Tl7bRa7gINOFK0f6Foa4qIqVyrYNTJBAASAsDdxZAOh473F
 tRHfFBoq2ZobYI5+AnUZ0b0nU1kktf7I/GO6oNQBKxf7XWO7pay2H877q59x8Zg/wpoq320bT8n
 ZnOYWHkpP/H1kN6Ett9Zzjf90srzCYTMvbudlspxe5PQ6UPf7D08i9IcUn97JvFOh5LgXhRmrRR
 spQAxUKruSP93pRZcQ2F+DAxrkpF6yT8yVbMEZE9V5JiKNm7x4QLsJatzznjmZxvwzp9YK7n1um
 BvJSHqJ5OkJSzReX74MK9SC0AJMgqpKdE/53EAiyKF6R
X-Google-Smtp-Source: AGHT+IFQmS5IKC7gUJXuWGe/8tEO3Kw/TUAAHpJS3gqgq+OXBI+mLKukwUA6BCV1ZiMphA4EHjNxPQ==
X-Received: by 2002:a17:90b:1c0d:b0:2ee:f076:20f1 with SMTP id
 98e67ed59e1d1-3030fb216b9mr36885227a91.0.1742954305071; 
 Tue, 25 Mar 2025 18:58:25 -0700 (PDT)
Received: from archie.me ([103.124.138.155]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3030f5b782esm11157741a91.2.2025.03.25.18.58.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Mar 2025 18:58:24 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
 id A04E54230C05; Wed, 26 Mar 2025 08:58:21 +0700 (WIB)
Date: Wed, 26 Mar 2025 08:58:21 +0700
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
Subject: Re: [PATCH 6/6] Documentation/gpu: Add an intro about MES
Message-ID: <Z-NfPeUP5g2TdWy5@archie.me>
References: <20250325172623.225901-1-siqueira@igalia.com>
 <20250325172623.225901-7-siqueira@igalia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="T7r84Huw4Mg6PNRy"
Content-Disposition: inline
In-Reply-To: <20250325172623.225901-7-siqueira@igalia.com>
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


--T7r84Huw4Mg6PNRy
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 25, 2025 at 11:18:47AM -0600, Rodrigo Siqueira wrote:
> diff --git a/Documentation/gpu/amdgpu/gc/mes.rst b/Documentation/gpu/amdg=
pu/gc/mes.rst
> new file mode 100644
> index 000000000000..b99eb211b179
> --- /dev/null
> +++ b/Documentation/gpu/amdgpu/gc/mes.rst
> @@ -0,0 +1,38 @@
> +.. _amdgpu-mes:
> +
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> + MicroEngine Scheduler (MES)
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> +
> +.. note::
> +   Queue and ring buffer are used as a synonymous.
> +
> +.. note::
> +   This section assumes that you are familiar with the concept of Pipes,=
 Queues, and GC.
> +   If not, check :ref:`GFX, Compute, and SDMA Overall Behavior<pipes-and=
-queues-description>`
> +   and :ref:`drm/amdgpu - Graphics and Compute (GC) <amdgpu-gc>`.
> +
> +Every GFX has a pipe component with one or more hardware queues. Pipes c=
an
> +switch between queues depending on certain conditions, and one of the
> +components that can request a queue switch to a pipe is the MicroEngine
> +Scheduler (MES). Whenever the driver is initialized, it creates one MQD =
per
> +hardware queue, and then the MQDs are handed to the MES firmware for map=
ping
> +to:
> +
> +1. Kernel Queues (legacy): This queue is statically mapped to HQDs and n=
ever
> +   preempted. Even though this is a legacy feature, it is the current de=
fault, and
> +   most existing hardware supports it. When an application submits work =
to the
> +   kernel driver, it submits all of the application command buffers to t=
he kernel
> +   queues. The CS IOCTL takes the command buffer from the applications a=
nd
> +   schedules them on the kernel queue.
> +
> +2. User Queues: These queues are dynamically mapped to the HQDs. Regardi=
ng the
> +   utilization of User Queues, the userspace application will create its=
 user
> +   queues and submit work directly to its user queues with no need to IO=
CTL for
> +   each submission and no need to share a single kernel queue.
> +
> +In terms of User Queues, MES can dynamically map them to the HQD. If the=
re are
> +more MQDs than HQDs, the MES firmware will preempt other user queues to =
make
> +sure each queues get a time slice; in other words, MES is a microcontrol=
ler
> +that handles the mapping and unmapping of MQDs into HQDs, as well as the
> +priorities and oversubscription of MQDs.

The doc LGTM, thanks!

Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--T7r84Huw4Mg6PNRy
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZ+NfPQAKCRD2uYlJVVFO
o6UAAP9lsXJ6l4cqF7vmeIBW9n4YJ2zC41NH/uOp6yO5dvxAzgD/WuufE/4Enb/F
3EDZtK7z4NvrYU2wMCsKX+SSFoHxUAs=
=xTf7
-----END PGP SIGNATURE-----

--T7r84Huw4Mg6PNRy--
