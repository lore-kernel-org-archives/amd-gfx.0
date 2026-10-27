Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19426606A321
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Oct 2026 12:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=OijH8ZWb
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B510510F481;
	Tue, 27 Oct 2026 12:58:09 +0000 (UTC)
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com
 [209.85.214.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1ABB310F481
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Oct 2026 12:58:03 +0000 (UTC)
Received: by mail-pl1-f178.google.com with SMTP id
 d9443c01a7336-2e93e0d86a0so4352775ad.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Oct 2026 05:58:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793105882; cv=none;
 d=google.com; s=arc-20260327;
 b=h4bTdVac/k+opiNWqT2Axckt7xSTYWeb/fISLqhJOyiWH5AF3/r2CWCzlqS/tnxhEK
 SkWIaS4qo11n07NRiXhrbY0SqDCL0mCXXsWeXBcKchCAn2QwKSTh4fquf7csCSFOgOQy
 ml+HwzCMFkSMkLBauDw1w1EJjnv1MD0lKnCpgUBjjucvwg7ud052Cr32VOgjo27J1bnr
 eNjKkKPIvgH9VXk1YxcQjYdLgNasB97/GrIPjasYCypBzsFszOumbNxzPdyEOkRV3CMs
 TvHut3bpPGFTFmvGCyNs4hequg5sgg6gUXpug1SRK985p3Pp4wESvreYQk2ZTFp4yyrI
 BwHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=5cFHz19Fl8DmCi1uIfI6RDZnDxd7w5JrqZ9wd9VXgCk=;
 fh=X3mKZhz78s2OvAwXIAkQ+e/q07VaYdt7OQXoXI8uj7A=;
 b=kSpLddnJ1+srjgL4QgjqXobkfqrAZQcPmOMQ6mfNyKSeCB6ZE3iArh0zEVPNOd4rUc
 /RnVrE2x8mwqBNXLVhBJEkvOLE+yCVVP+oaNO+D6Euz4W93W469d7iDovOMhscDhvVkt
 VRoAhYuOsouRTNFcB3acCKpMrW6XMlYJTiCen8Yh0hYko3bYxwFjK6vGPNpGhaZ8ccoA
 Nu8zVSW7V8/Xk3sMiVuHu73u4iaWB+v7bRB2ysNFBP9P1yx1IrKO0rDSJIp28WVjq9oa
 2ohEOyQIECp15i/UqSdTG8evgG/hjPSAih9SAu1CHdvUXMj/WRxxjElp4C+xdd+bNBcl
 Pdtg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1793105882; x=1793710682; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=5cFHz19Fl8DmCi1uIfI6RDZnDxd7w5JrqZ9wd9VXgCk=;
 b=OijH8ZWb3IRxYYp73go0LVGqeHC4xrZZvSFMXL4RWOGtcns7/RkmVl3VDFvHW4Q4pu
 iYyBDJxrOEJWiXDkoC/PeeK1fTkmtFQmN52FbNSDBTgMGlGoGEgx1eyzzic6uMmKiRrH
 OLfbCcZnmELtPvN/eiMhnV89L9uF/su8Bhdlxm+hMHtNkeh3gSBaLrS0qC7yJB1olHdZ
 /gBW5isrODvzG90bM+C/Mip7IgcfFcJUVI47PilW0q61r2NEWwrTtJwi1Nh41eNwgMyp
 /kmN5+E9g2X1JrWS7CG/e8dPXYAXLOexZUJHCBZUF3oNqWnuySWaiTMsrxOpcgwDfMvN
 VAlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793105882; x=1793710682;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=5cFHz19Fl8DmCi1uIfI6RDZnDxd7w5JrqZ9wd9VXgCk=;
 b=fk8msHZc6FKeNfgBgytm7louv0DSFz1Rp3sdy0AHvyv+edYcRCuo/R2Ht7wGVUxQop
 Cxio3fLNRniMGBQFi2d30tl1cAvPDP247ApHQLJxiFU3xTU8mKXoZMFnsxidmCNXLtlc
 d/7X17ErSUXRP49mix7DjDzuhhm8chFLPijd7+aqm4dOoBIVQajDoWStMjWgiRbN048d
 onGQt2Q+F/gpMHVG302sUmY/c6NJ1kp7mCy7ibLUqcWsdd4hXZjyvx24qtlf4Tr3/t0t
 uy16sCvyFlOvBJ9YUOszXamGcG/ibDHOrgCuSCQw3zHocNofOPHWeeujKeLOP/w6czDN
 Ai/A==
X-Forwarded-Encrypted: i=1;
 AKwUvByuBWN8eWgYVH2L6eIsW9oRI7EvjLu8dJcXsoB8kBk+N6zucGjAMPr3Vxy+vyLVhe/N3JPrUKix@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLPp/JtUdAob6ZgcJ4ZfzVZb13TIGoxuNMatvQAT80DmBmuqyu/
 E37JS47nrq5hEHPrPcNurb7d9cxXMP0lu0vyYmWeqGIZHukL/60/g/jnhFuS9brCg+GaUbvaof/
 rWDSpYo3t2JChVC9xxhB7knIUrCqWdvI=
X-Gm-Gg: AYBFou1/e9yxQAcGbQQIcHLasS7IQIu3AXptTFYqZ/23GIc0jEOOZFC232T+lQ+29kS
 WJTVaIjiK29yZiXKVwEwqu6ph9Y1QTYlMB5e20wsiDMzgh+hZIv5bJELr87Ht34GSO9cH7jOHHU
 bgQQW52DjbJ+T+yNV5Vt2BajfNSZ8n/nYZElHrK8MTVyxeKDEr4hLLd6LZbM3Ncbw7+L2tWJIkC
 AAnSrXLXpNGJgLqB1oUD8uhqloKtyjTN4b4jbtrEaBsNCbjFavYfc+gQy4+MebFmONrwuL3GnYL
 o8uEszfWLp+r53XpgkBIlZzvQF3z6G620zzAT0ikyToZXZVYot+f4hSsUCbObFxZ56iSCCQUDjo
 wfR8u592GptJugr7YvNNF+qFhLIwBwcklO6fQ+i5T+x2zHbb/IQigE2xcj525wlxf45gFUk7yBZ
 sW9Vpu+phOlApIK6ve9B2QGTs=
X-Received: by 2002:a17:903:1246:b0:2e9:53b1:a3c8 with SMTP id
 d9443c01a7336-2ea9b8cedd9mr139799795ad.0.1793105882570; Tue, 27 Oct 2026
 05:58:02 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <a826b32d-597a-4c01-8b30-218cbca8627a@gmail.com>
 <e0573e72-dcc1-4ff2-8cf2-53aefde912cb@amd.com>
In-Reply-To: <e0573e72-dcc1-4ff2-8cf2-53aefde912cb@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 27 Oct 2026 08:57:51 -0400
X-Gm-Features: AclHuK92ggwXiFq1nRRsvD9VvQPc9NQzHHjBp1wqrlbElWtCAuab7SLZN1uuWeE
Message-ID: <CADnq5_M8f2Hgs06n9EXUaihGsr6YEm6G4YFVQmPfQbGU08XkBg@mail.gmail.com>
Subject: Re: [PATCH 1/3] drm/amdgpu: reserve 64M stolen memory for Apple 5K
 iMac
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Richard Lane <richardlanedev@gmail.com>, amd-gfx@lists.freedesktop.org, 
 Alex Deucher <alexander.deucher@amd.com>,
 Harry Wentland <harry.wentland@amd.com>, 
 Leo Li <sunpeng.li@amd.com>, Rodrigo Siqueira <siqueira@igalia.com>, 
 Mario Limonciello <mario.limonciello@amd.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org
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
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Oct 27, 2026 at 8:21=E2=80=AFAM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> On 10/26/26 23:46, Richard Lane wrote:
> > Apple 27" 5K iMacs report a single 2560x2880 tile (28.125 MiB) in
> > VIEWPORT_SIZE while scanning out up to 64 MiB across the relocated EFI
> > framebuffer.
> >
> > Override the stolen VGA memory allocation size to 64 MiB when matching
> > PCI_VENDOR_ID_APPLE with a 2560x2880x4 viewport size to prevent
> > framebuffer corruption during boot handover.
>
> Hacks like those are usually a big no-go.
>
> Why is that framebuffer handling not working with DC out of the box?

The GMC IP code reserves the memory used by the display hardware from
the pre-OS console.  The gmc get_vbios_fb_size() callback looks to see
what display viewport was set by the pre-OS environment.  If the Macs
need a workaround, that's where it should go.  Since these displays
require multiple display pipes, my guess is you need to double the
allocation in that case since the current code just checks the first
pipe.

Alex

>
> Regards,
> Christian.
>
> >
> > Signed-off-by: Richard Lane <richardlanedev@gmail.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 10 +++++++++-
> >  1 file changed, 9 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_gmc.c
> > index 4204c3c750a8..8b196fbfa724 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> > @@ -1232,7 +1232,15 @@ void amdgpu_gmc_init_vga_resv_regions(struct amd=
gpu_device *adev)
> >         } else {
> >                 size =3D amdgpu_gmc_get_vbios_fb_size(adev);
> >
> > -               if (adev->mman.keep_stolen_vga_memory)
> > +               /*
> > +                * Apple 5K iMacs report one 2560x2880 tile in VIEWPORT=
_SIZE
> > +                * while scanning out up to 64M across the relocated EF=
I
> > +                * framebuffer.
> > +                */
> > +               if (adev->pdev->subsystem_vendor =3D=3D PCI_VENDOR_ID_A=
PPLE &&
> > +                   size =3D=3D (2560 * 2880 * 4))
> > +                       size =3D 64U * 1024 * 1024;
> > +               else if (adev->mman.keep_stolen_vga_memory)
> >                         size =3D max(size, (unsigned)AMDGPU_VBIOS_VGA_A=
LLOCATION);
> >         }
> >
> > --
> > 2.55.0
>
