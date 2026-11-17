Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B6DB606A31C
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Nov 2026 15:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=o1q8eWpj
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C389410E543;
	Tue, 17 Nov 2026 15:13:46 +0000 (UTC)
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com
 [209.85.210.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8669D10E5FF
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Nov 2026 15:13:40 +0000 (UTC)
Received: by mail-ot1-f41.google.com with SMTP id
 46e09a7af769-7f421638271so580478a34.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Nov 2026 07:13:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794928420; cv=none;
 d=google.com; s=arc-20260327;
 b=qv9CyVx7jcSpsqh2FgZ3Xgtu1Rmc/nzDsOkx3OffL2r6rXDEw59L4zCQ0kEWsXoX2w
 ICn4xEn/J8KlfpuqtHZFuoLnxA+q25wzmDpvNsEGrGQdrVCWL/fiRoKDhN/bP4v/LYHe
 FxgRVm//dof23u3Kp3+Sj0N28EPk++h9nFoXRte1W0D7mFB2UcJGjfmdI9RR+ch/SKlw
 ga3/ro5fe7qNA9sN6gpwihZGS3xB1q4K4eUVupXaYZVe4UikC9kQt7pJpkPokI2zQxkz
 kLZ8PaZnBGawnSdTPTEOtyRIjM1ilge/3Lmv2YHb9GF+J6CFy6S4dofJL+snwax3FoWY
 TfTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=uD7DrI1IbTcdbS/rOYIPz3194YH5tQaT0AHkvD2uUUk=;
 fh=IY98SR0cNO93Tj0qH750yd04bAXFkNbDKtBTzSqo1Bw=;
 b=Oyld/AER5TH5KpwfVaPDujaN7jFDYNh+o2pfeJlhJ9vTF3X8l9/WaErHaXR/pvd8fW
 KEAao3/lmvoNwck5t6YpLiCw0DGuRS21tFxdiBahzBkcpRBlvAlF0KpYTe80metSVOME
 fkzdBvABI3R3uHBPGEblzfL7rVgALr2Zzc9x75Jv/rLn80DIdAwJC4qMjQcEPMZWyp8L
 18EySKAK10PdBQPOi6BEp4X9GWlsQ5XlH8WW3K3m/35/1L8XfkexMyMcEOabvSpSChld
 Bl/KnoKLmKpcISt1CFhqZXfbv3lEGIPRPaCRbe+N0ey4KoHJD5mpu9iDJDWzpj3zczWl
 Zz8A==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794928420; x=1795533220; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=uD7DrI1IbTcdbS/rOYIPz3194YH5tQaT0AHkvD2uUUk=;
 b=o1q8eWpjw3dDnWETdZd/rn1y58OhloWGt9uitlclvKJqTzq4GnO1fqXlWdgh7brGHQ
 sk3zH8vFGDorsiDaU0Qex9YUnubKbdh2ruCvAcC3P5Ek0bUnm87GVeZtt+EqVrZZuF7Z
 cGxOaz0ZHCr4KtxxjCbVhzb026fQYS8miEdfkCT6B77SIiBEd8d+jnvffJOgwMyeYrku
 fkgtgsKQfQgGCpoEsO1y/3EXghVuq7Vkj0xJhvjr4CXOQ3qNQE/Bafas11NjCZxBD3+9
 HPlK/8Da36pEbAq3f2sNXx3zpUbX50gdnrFsnEzYUDHlnEDuUs4daWee1NUThKvV8UD6
 GbiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794928420; x=1795533220;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=uD7DrI1IbTcdbS/rOYIPz3194YH5tQaT0AHkvD2uUUk=;
 b=uPJqBECLH94iw7NRQs2lU2AKhPCFiDbGzbSFWTGwZNyGUqY8om4ufQ37jjz9jNUa1a
 /aQnI4/mxFG9gcWtZBZWTWp/qLKuOzwxupLSObEQ2HJBDohf81hnAoH/EPh0gCZzOXlR
 KLxYGHx3QafJNWQzaEvoUFQkDil5vQ2liTfgKs2Qpnlv/q4hBo7pFZvsMvMsvWslK1SN
 gFltPqxLTgfTXYcy/hqFKKqyWyytH9DiOl7LGtaXp9FSyeP/pMFbLV8eDh2UkaIBbrW1
 PhBOcqsCEeBdaKQjUZRy1jXgDOgDXEHmfScD9R79sGVW1d5avgesFKO5/EB6SMtoct1p
 Kwug==
X-Gm-Message-State: APuU4Z+YEjCPxi+hPOAsheyGg6H3JqezsK5yh1rus1s3YNyfaN75xOv9
 aWHAzKnuHHEmne825Us9K/m1RwW0/nepo5+aGZPyY6QWsS3FzXgde8JxV/SPejBeHwFaJzwlbXs
 U0Xbr5B1394rDQe39/FQYPF6gXeCdTHU=
X-Gm-Gg: AYBFou1CTjoPtM1pIj1UaTX8n5RvyQ3hWxJRaU6I9xMS6A6yy3iX86fLVqe/bocf7EE
 XkVf7kV0ny4qp/IFQq1yArx6AoOnSwDpkzt5FYAkVH78PmxHwXN2BfImBXcIdcJOTk6uzv9SkMF
 nlaTgaoh98PYg/9tTQ/onswA+cgxQxQtIuZ92IlvXOzpX36eRtstMXubA8VEOdGmEJWvr6Y/S7h
 7Yop50PHIMpksfsyuY2+ypoGjwseB9BwYuwjpAQAmj7eZTLjQhmNwZT3RyPyI8b5X3scyJL50eK
 waaoMJJp6KuyuvKYbKB8xcKL4hMYwSj8+nDywL/bK9mc1oKNDDxguMM0O0Yk5h299vJbQ9yACBZ
 mhBEUNa41RdWgqyUSXs031J/sw/0ASbGV/7jkRgRSyJFwi2EfLFu178MA7sqLfiTMKQHATXN2Sp
 ZT7aeIehoXaI59Lhs63V7tfdIIgizzwrpAbHqQE/KJUFDt7rfgaTl1lSnzc1A=
X-Received: by 2002:a05:6808:118a:b0:567:de70:d493 with SMTP id
 5614622812f47-56e66989723mr17912056b6e.5.1794928419390; Tue, 17 Nov 2026
 07:13:39 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261106225913.3569203-1-alexander.deucher@amd.com>
In-Reply-To: <20261106225913.3569203-1-alexander.deucher@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 17 Nov 2026 10:13:28 -0500
X-Gm-Features: AclHuK8iZ7jDpRLMQOlTRFV9QnC6S5jsyiu9Bf_CdqY0wX_1MW82p1p7uq_B6Mw
Message-ID: <CADnq5_PozNVt1RxtQUY8HyNJ7mqzKkiSr6f-cODe7onrNg0ewg@mail.gmail.com>
Subject: Re: [PATCH 0/4] Add SDMA v8.x support
To: Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Nov 6, 2026 at 6:06=E2=80=AFPM Alex Deucher <alexander.deucher@amd.=
com> wrote:
>
> Add initial support for SDMA (System DMA) v8.  SDMA is the paging
> and transfer engine on the GPU.
>
> Frank Min (2):
>   drm/amdgpu: add v13_structs.h
>   drm/amdgpu: Add sdma v8 ip block
>
> Hawking Zhang (1):
>   drm/amdgpu: Add gfx v13_0_1 irqsrc header
>
> Likun Gao (1):
>   drm/amdgpu: add new sdma pkt header

Series is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

>
>  drivers/gpu/drm/amd/amdgpu/Makefile           |    3 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c |    4 +
>  drivers/gpu/drm/amd/amdgpu/sdma_v8_0.c        | 1840 ++++++++
>  drivers/gpu/drm/amd/amdgpu/sdma_v8_0.h        |   30 +
>  .../gpu/drm/amd/amdgpu/sdma_v8_0_0_pkt_open.h | 3988 +++++++++++++++++
>  .../include/ivsrcid/gfx/irqsrcs_gfx_13_0_1.h  |   77 +
>  drivers/gpu/drm/amd/include/v13_structs.h     | 2288 ++++++++++
>  7 files changed, 8229 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/gpu/drm/amd/amdgpu/sdma_v8_0.c
>  create mode 100644 drivers/gpu/drm/amd/amdgpu/sdma_v8_0.h
>  create mode 100644 drivers/gpu/drm/amd/amdgpu/sdma_v8_0_0_pkt_open.h
>  create mode 100644 drivers/gpu/drm/amd/include/ivsrcid/gfx/irqsrcs_gfx_1=
3_0_1.h
>  create mode 100644 drivers/gpu/drm/amd/include/v13_structs.h
>
> --
> 2.56.0
>
