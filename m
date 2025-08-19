Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2ECEFCA0EE6
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Aug 2025 18:50:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B68D410E64E;
	Tue, 19 Aug 2025 18:50:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jnD+TPRi";
	dkim-atps=neutral
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com
 [209.85.128.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9FCE510E64E
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Aug 2025 18:50:45 +0000 (UTC)
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-45a1b0cd668so30397825e9.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Aug 2025 11:50:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1755629444; x=1756234244; darn=lists.freedesktop.org;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
 :date:message-id:reply-to;
 bh=6Zon+rXvcjlDBXNpQFLyDVHr4E/LKBHqe2gL6TuYdH4=;
 b=jnD+TPRitYSCPH4vRAsMmTu93hkmDBLM0LDMepdvAZZqtdkpYRdNKTqweBeDDxZ44j
 7K6jxyMBg6rpBYIrdnDRlmeI38VFLfdUsWlARzrtxvmfjpXcVK1XgTS30Go8UY1jcQ8i
 e4wX9HBFQjtkwljIG+/wpRyTp+qqBe5aAAqHUs+e39oX5lHCe0CwuvmqE7r8gE724SgM
 DhIe/YDHeokX8DsEteZgRxLstGB0ZNlhPAhmD6THivcPDg6XW0NbNpHvBhaJZ3seEe76
 yxFOUgOF25JH7yCfsuYyhk386FqPQ+zJRZdhmrX50JUqBTl3g3m3H7UvoU2qLx4UHRwX
 SSPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755629444; x=1756234244;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6Zon+rXvcjlDBXNpQFLyDVHr4E/LKBHqe2gL6TuYdH4=;
 b=d9f7EcYzhiZONA3AsGzXJlwDP9TvbkRYsOtM3VBX5Y4zhjCJfElm2/fZyoc6q2fuUl
 vOkMloH4vqJMlckzPjjxVqmyMlSBvDctakUkL3A7T3IMxAyIv0qLe3K0Uud4q1ahph2/
 QC6iwMC4jDMkfqYk/hr80l7e1MrO50V14ZlhN/Jfj7fzLYGnjean3XlpAhBinnVDCNyu
 XN/dB1JIb0Uj3T0m9q07m82VQ6y/MzA9shaJMb6VIq6TKvROnDkLqVIkAOQXaV7dviD3
 Z15wt9r8SmTsa5EDu0viXIcA8j8SrHyyixTq2o1+r6yKBWG35wABrhtpm36V0jfchump
 HifQ==
X-Gm-Message-State: AOJu0YzXegFQKIb8NK5wXANSHkzQzUKJLYGXwYF71SJkc9Efdm+mosMP
 +ee/9175xxxRoW3wZR/B+ZMCgpCmL7OkW6RYpXBmwaYuzdBGwwkXblmO
X-Gm-Gg: ASbGncugFjgiuy8kJlCgFQIpFD/F/TkIHvKZmmskJFSLI5Ch6q/lZXUSJhaVt8wLL6e
 Y+VWPNsNM3/0uGee2eRgU6+cY6DCsQrHHAhz9KB9b9mdOtlCeOreatP+uCCRrJ/G/+D/U12w9ID
 J0qOfK8JlB6I13GPGVI1fzBHNrXQNwd9DSo2N9JXFFXxnMyCDcTHP6frF2cTzuvx4XA6H2XmYmU
 /DOP/S+ZJFbN3lJWRdpujfdsy1J+hGXQc5Spa1sxutsjDZyXMgtEPGd91PY0GkXVIOcasVcS23u
 Zl79JDiPNWppTxwB6dUfcEn5uSPhFRxM6vBf2q/rQvhiJLN9tFbLgsBMKhamLuklYHJyWbz1sAV
 ZTNBvDtUT1Oe444N/VghukhfLVmtO82QWRz8UpEAhD0sukpqGuHAV4QJdxjW9L1XXR6OlqSZztq
 cWStrHikfoIJhSYsApb2HMIkYtIK9nX8Q861VqZDnwtOKOBb+pCYI0QrxP
X-Google-Smtp-Source: AGHT+IHtDESGIDfuh2lPK37xqiHNzOGJjT8VgQmBuM2uHzxXwYiKCf8w1W0Fd6jyteg3gH1YBgcrFQ==
X-Received: by 2002:a05:600c:3144:b0:456:2212:46b8 with SMTP id
 5b1f17b1804b1-45b43e0bfbcmr25924225e9.28.1755629443704; 
 Tue, 19 Aug 2025 11:50:43 -0700 (PDT)
Received: from ?IPv6:2001:4c4e:24d9:d00:e837:7025:20a0:bf2?
 (20014C4E24D90D00E837702520A00BF2.dsl.pool.telekom.hu.
 [2001:4c4e:24d9:d00:e837:7025:20a0:bf2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3c0771c166bsm4675585f8f.33.2025.08.19.11.50.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Aug 2025 11:50:43 -0700 (PDT)
Message-ID: <ddd650e7d6887103c6c91ff89d81411bdf4d0a8e.camel@gmail.com>
Subject: Re: [PATCH 2/5] Documentation/gpu: Add new glossary entries from UMR
From: Timur =?ISO-8859-1?Q?Krist=F3f?= <timur.kristof@gmail.com>
To: Rodrigo Siqueira <siqueira@igalia.com>, Alex Deucher
 <alexander.deucher@amd.com>, Christian =?ISO-8859-1?Q?K=F6nig?=
 <christian.koenig@amd.com>
Cc: amd-gfx@lists.freedesktop.org, kernel-dev@igalia.com
Date: Tue, 19 Aug 2025 20:50:42 +0200
In-Reply-To: <20250816153315.1285182-3-siqueira@igalia.com>
References: <20250816153315.1285182-1-siqueira@igalia.com>
 <20250816153315.1285182-3-siqueira@igalia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi,

On Sat, 2025-08-16 at 09:31 -0600, Rodrigo Siqueira wrote:
> When using UMR, a dashboard is available that displays the CPC, CPF,
> CPG, TCP, and UTCL utilization. This commit introduces the meanings
> of
> those acronyms (and others) to the glossary to improve the
> comprehension
> of the UMR dashboard.
>=20
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> Cc: Timur Krist=C3=B3f <timur.kristof@gmail.com>
> Signed-off-by: Rodrigo Siqueira <siqueira@igalia.com>
> ---
> =C2=A0Documentation/gpu/amdgpu/amdgpu-glossary.rst | 21
> ++++++++++++++++++++
> =C2=A01 file changed, 21 insertions(+)
>=20
> diff --git a/Documentation/gpu/amdgpu/amdgpu-glossary.rst
> b/Documentation/gpu/amdgpu/amdgpu-glossary.rst
> index 30812d9d53c6..eb72e6f6d4f1 100644
> --- a/Documentation/gpu/amdgpu/amdgpu-glossary.rst
> +++ b/Documentation/gpu/amdgpu/amdgpu-glossary.rst
> @@ -30,6 +30,15 @@ we have a dedicated glossary for Display Core at
> =C2=A0=C2=A0=C2=A0=C2=A0 CP
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Command Processor
> =C2=A0
> +=C2=A0=C2=A0=C2=A0 CPC
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Command Processor Compute
> +
> +=C2=A0=C2=A0=C2=A0 CPF
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Command Processor Fetch
> +
> +=C2=A0=C2=A0=C2=A0 CPG
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Command Processor Graphics
> +

I would apprectiate a few more details here to connect these to other
glossary items. Here are a few questions:

- Is CPC the same as MEC?
- Is CPF the same as PFP?
- Is CPG the same as ME?

> =C2=A0=C2=A0=C2=A0=C2=A0 CPLIB
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Content Protection Library
> =C2=A0
> @@ -78,6 +87,9 @@ we have a dedicated glossary for Display Core at
> =C2=A0=C2=A0=C2=A0=C2=A0 GMC
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Graphic Memory Controller
> =C2=A0
> +=C2=A0=C2=A0=C2=A0 GPR
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 General Purpose Register
> +

Does this refer to registers in shaders or registers in the various IP
blocks? If this is about shaders, it would be useful to mention that in
the context of shaders, a GPR is either SGPR or VGPR. (Those two are
already in the glossary.)

> =C2=A0=C2=A0=C2=A0=C2=A0 GPUVM
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 GPU Virtual Memory.=C2=A0 This is th=
e GPU's MMU.=C2=A0 The GPU supports
> multiple
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 virtual address spaces that can be i=
n flight at any given
> time.=C2=A0 These
> @@ -92,6 +104,9 @@ we have a dedicated glossary for Display Core at
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 table for use by the kernel driver o=
r into per process GPUVM
> page tables
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for application usage.
> =C2=A0
> +=C2=A0=C2=A0=C2=A0 GWS
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Global Wave Syncs
> +
> =C2=A0=C2=A0=C2=A0=C2=A0 IH
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Interrupt Handler
> =C2=A0
> @@ -206,12 +221,18 @@ we have a dedicated glossary for Display Core
> at
> =C2=A0=C2=A0=C2=A0=C2=A0 TC
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Texture Cache
> =C2=A0
> +=C2=A0=C2=A0=C2=A0 TCP (AMDGPU)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Texture Cache Processing
> +
> =C2=A0=C2=A0=C2=A0=C2=A0 TOC
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Table of Contents
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0 UMSCH
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 User Mode Scheduler
> =C2=A0
> +=C2=A0=C2=A0=C2=A0 UTCL
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Universal Texture Cache Line
> +
> =C2=A0=C2=A0=C2=A0=C2=A0 UVD
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Unified Video Decoder
> =C2=A0
