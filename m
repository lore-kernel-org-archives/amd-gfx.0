Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0591AC36008
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Mar 2025 08:40:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B630010E66E;
	Wed, 26 Mar 2025 08:39:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="SV+Ai5Z8";
	dkim-atps=neutral
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com
 [209.85.214.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7A77A10E639
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Mar 2025 01:53:47 +0000 (UTC)
Received: by mail-pl1-f173.google.com with SMTP id
 d9443c01a7336-227d6b530d8so53772925ad.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Mar 2025 18:53:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742954027; x=1743558827; darn=lists.freedesktop.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=bHUdmQyO2BpdhwAwvhp39Sm8OM9BEkdjoS919AZ2eZ4=;
 b=SV+Ai5Z8PFkKK8Y1kC8MP46U6dK4SjXqWd0FthmDEPj+g5GQhwvHDnVJg4Ut1JBtfm
 7W00hcPdELs0QPWwA/2te1qb098baSTK074a+fJN4g3HpQCF32MzP0MTbFXdJX4O8oA1
 +7cs3NrmUnyep36Id92q6d1LuG5Y1P4kLGsE41Mm3dfxrDiGxn/FX9t3ckHuhW8aWVDZ
 4ccJsJDrDEpLzR0sIc+XQ8rLCfOIyRsegORfvY+ZS3k87sSHieP5R/68BLciJ92jD6O5
 fwBmC+GAtqd2tN8M3ViGtXAlesuKAe8EsmVomqhu2roO+4MDDDzNvdFw2coi1VwDDATp
 bDKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742954027; x=1743558827;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bHUdmQyO2BpdhwAwvhp39Sm8OM9BEkdjoS919AZ2eZ4=;
 b=QXJDyLVj0fK3h/07U4ArAu7Y5nNyljzd5Igm+JEB6EDwcustb862HJ5zUE6mBX6yFB
 xWfhtn67vcaZ51n3+9zA7avgVhPyR5ES/ge7k5hAfd0rkiOPSTZW5T3zQMoqb0CReS4T
 rXfVAW53uiYqZJHMRjnWx+zdMbDGcW7BLHNcjC03z1mIck6U/fK4QzIFFT/SeAB6CfTh
 9O85JjnPXHk9Fm8aqbU3Ia29QX8NMjbr2LwZ/lq0MJ0stHkIwsVCOMhpia0Cb9T2Rk56
 w+yaiL9lCwalPPuTMQfWmUONWBfMNcP2gKUpKBij3oreZ4JPqJhIqMTkWo/nZoYtPF5n
 e7sg==
X-Gm-Message-State: AOJu0YzlNTyXmPYOZeYMWmBDaIw3nsPe8nI6THAY8L2/eGDaUe6fu92s
 5aiHAh9TwJadXadDwW3w2hx1UwWqJeQB7OckE5Qq3czV8ZVmBO06cg+W1g==
X-Gm-Gg: ASbGncvim5XXg5xkm7Y2WRUkd0BNWsvMVUBf60uqYbejddP1RWWJHfINhwxBadVNSTO
 0bjCjU603PGu3DeCZOuSL7bjBtAqjHpFF2BXM7+KATVZcgJBExYQV5y19BT5Qj0DIpjK3obSS1q
 0KjGBjQnaJ3lkZWXRshFjlD46WR5h6idvdvMm02R+deDw+uJtUwZEg/PTBEhh6NoXYic47ebOVS
 JgCVkSwJkVcHtj8cCFoWdi31b/Cwf69qX++9Byvt7TWRb8FI9ei05EH3UDDz/UVnrqPvrQDvHej
 5PdfAqCQOWbg3fIykWp9MaoNirC0T8e+NfAenikSn+6m3XQfr13pczI=
X-Google-Smtp-Source: AGHT+IHD8Vo8UwujuN7hNNDBusTP3KjsT+y+ccOlwpD/9Ek/nB8mPA7Mfk+LlbXQbxCuUDQpKgy6fw==
X-Received: by 2002:a05:6a20:729e:b0:1f5:6abb:7cbb with SMTP id
 adf61e73a8af0-1fe42f585c0mr33547160637.23.1742954026671; 
 Tue, 25 Mar 2025 18:53:46 -0700 (PDT)
Received: from archie.me ([103.124.138.155]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-739061560d6sm11307073b3a.148.2025.03.25.18.53.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Mar 2025 18:53:45 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
 id AD0C54230C05; Wed, 26 Mar 2025 08:53:43 +0700 (WIB)
Date: Wed, 26 Mar 2025 08:53:43 +0700
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
Subject: Re: [PATCH 4/6] Documentation/gpu: Add explanation about AMD Pipes
 and Queues
Message-ID: <Z-NeJwfu1Gyx_CeX@archie.me>
References: <20250325172623.225901-1-siqueira@igalia.com>
 <20250325172623.225901-5-siqueira@igalia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="/mnH3a2A936fTjj8"
Content-Disposition: inline
In-Reply-To: <20250325172623.225901-5-siqueira@igalia.com>
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


--/mnH3a2A936fTjj8
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 25, 2025 at 11:18:45AM -0600, Rodrigo Siqueira wrote:
> +.. kernel-figure:: pipe_and_queue_abstraction.svg
> +
> +In the central part of this figure, you can see two elements, one called
Did you mean hardware block?
> +**Pipe** and another named **Queues**; it is important to highlight that=
 Queues
> +must be associated with a Pipe and vice-versa. Every specific hardware m=
ay have
> +a different number of Pipes and, in turn, a different number of Queues; =
for
> +example, GFX 11 has two Pipes and two Queues=C2=A0per Pipe.
> +
> +Pipe is the hardware that processes the instructions available in the Qu=
eues;
> +in other words, it is a thread executing the operations inserted in the =
Queue.
> +One crucial characteristic of Pipes is that they can only execute one Qu=
eue at
> +a time; no matter if the hardware has multiple Queues in the Pipe, it on=
ly runs
> +one Queue per Pipe. When a queue is running in the Pipe, it is said that=
 the
> +Queue is **Active**.
> +
> +Pipes have the mechanics of swapping between queues at the hardware leve=
l.
> +Nonetheless, they only make use of Queues that are considered mapped. Pi=
pes can
> +switch between queues based on any of the following inputs:
> +
> +1. Command Stream;
> +2. Packet by Packet;
> +3. Other hardware requests the change (e.g., MES).
> +
> +Queues within Pipes are defined by the Hardware Queue Descriptors (HQD).
> +Associated with the HQD concept, we have the Memory Queue Descriptor (MQ=
D),
Related to HQD, we have MQD?
> +which is responsible for storing information about the state of each of =
the
> +available Queues in the memory. The state of a Queue contains informatio=
n such
> +as the GPU virtual address of the queue itself, save areas, doorbell, et=
c. The
> +MQD also stores the HQD registers, which are vital for activating or
> +deactivating a given Queue.
> +

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--/mnH3a2A936fTjj8
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZ+NeGQAKCRD2uYlJVVFO
oye9AP4iR8Vfseiyzk8xEC38+vn4Jm0SA+1phHuaBIUg4JgxTAEA0b0qh5O2KT7G
AqtO7nxuNxNoBeaZD1kAxX4AszF8DQA=
=TdVl
-----END PGP SIGNATURE-----

--/mnH3a2A936fTjj8--
