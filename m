Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A914606A31A
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Oct 2026 13:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=WT0PTt67
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AD45D10EEEC;
	Mon, 26 Oct 2026 13:01:09 +0000 (UTC)
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com
 [209.85.221.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2272F10EF2E
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Oct 2026 13:01:03 +0000 (UTC)
Received: by mail-wr1-f48.google.com with SMTP id
 ffacd0b85a97d-48df54150dfso1597146f8f.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Oct 2026 06:01:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1793019661; x=1793624461; darn=lists.freedesktop.org;
 h=content-type:content-transfer-encoding:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Kb3CRsS6vKiJycz5YVdXLF4v+bWHThPYevMD2NB3ilE=;
 b=WT0PTt67e9bZiJh3h1W3E3c6KMoLa1nlo8U19dq65mHsHmC4OsSvjTQb+yFdDdBtIM
 lZr+z2H7z+Hq3W2La/9sbBNp+BVFuyqkC8Rk0KbWdq9QwMIJ1gausqkkVnYGPojmWiOi
 YAHPd6TRaz1Y+91ObOkR47ogOwf7KYL5jzfps+M4p79hcv6wSqUl3Uo2wtj9KcmHkltd
 /PDyMRcQBNOp5Jk3iToigHsx6nxTlSNzHZb+Qa9jVJ/iHL38BCdGwFWqUfyIHwFgH0Y8
 8oSqFs9Ld3ijPFVL3zdngNJCSoyOPcuzIyixmyFHjPSckEay000Dj89FUgwV5BVzRond
 NWiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793019661; x=1793624461;
 h=content-type:content-transfer-encoding:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Kb3CRsS6vKiJycz5YVdXLF4v+bWHThPYevMD2NB3ilE=;
 b=irZ+WhAX+img+7zw0u13w2EJ1oj0uLcPFAm9RMfypFCWXusHUJ5MJz33YpqPNFSoET
 puAqvLNGBv6A+WDhRy6472gQKTcs4xIQyZtCDwB9lcDCkK5u1YzfA3RfJUjNqzWSsmXU
 JvdGL6kknkSijsZ2/TwsJ6lVS3zR8Rf20oepmGsENreDoLSjTfIbz+DNyh8CNVqJX+XP
 FbAniBfEs5DSsHF/y7IkorcGhcnyuHEL0Sd2Ugpn3bxl/sCeiCFUH0CmVXQfK7ghM3d9
 KugOcuk5cFHUvfZhXFusjqEfmo0XPCMd+zoBtJLzs/S+5yGjeNaxVPgmdCLxfthIynpk
 FEwQ==
X-Gm-Message-State: AFq9FYJUoegNh6FC0DHEutPp6W2aAZJsbR8ExWkSnivMBEfOdTwcF+Yu
 /PmyCMHlt26Ak6Su/jsy0bDNWaY4G8CGgdjbzqU65aFgVA7AAyGrk06N55nS1imP
X-Gm-Gg: AYBFou32ujnk2yyNKAfZMUA3lj1k6VUGO3qBih0CSfkjgk94Uh/S2PYoaruwQQiy7H1
 FPDAYQauPlGOpA+NoSBFvlGXrHymr/tPkAsuw5PBVmEhEE/v2aFHqnYSl9lLMfh1t3z95ihXLpj
 N88D49dwIHreNKswr+s4Zn4RHZRFCeRU3px5KgKFiZ3KsewSf2Sg3y9Nf2sHPUg6j/vsH+9yVyt
 q12hyag43dz5ZemTbK02FB3p4d6c1iZa/c7iqZS7oHYBrAzbzeDyxqm2Gv4BsHlOhZrSgAFugTi
 zYe0SoQcQHfB8pz+nKZs6IK0ATCraDZkXFGS8m8/kseeZwKBH1T2Jot1HKEvfwSDrxA0tUh7hFf
 NF6hlQuUMXm1Wlk7BFAp8hI3g8yqYyA8CJKnw2uvZyHAy4bxEAxmctCZSAZgE5hgJjMI4pjABLw
 zEyvNena1aYSIwtnWffyIxrw42PPy0hK35uu/t0YY8niOve9Uv2uooxglU2V59CWt02ftpgB4iH
 HWbzbnLsrG5TSJIWznp1naO6qu1+JszkhNcBnoQDhvZ/6yk3KvW4WQUyxbD3zp5/ISCX24Ci5OW
 yXbdXxy9vuB2fM/TTrZ5u8RrUg==
X-Received: by 2002:a05:6000:3111:b0:487:b50:101c with SMTP id
 ffacd0b85a97d-48e3eb2b67amr14404934f8f.5.1793019661127; 
 Mon, 26 Oct 2026 06:01:01 -0700 (PDT)
Received: from timur-hyperion.localnet (4E5C1F56.dsl.pool.telekom.hu.
 [78.92.31.86]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ebcb902sm17124202f8f.24.2026.10.26.06.00.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2026 06:00:59 -0700 (PDT)
From: Timur =?UTF-8?B?S3Jpc3TDs2Y=?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com,
 Natalie Vock <natalie.vock@gmx.de>,
 Mario Limonciello <mario.limonciello@amd.com>,
 David Rosca <david.rosca@amd.com>
Subject: Re: [PATCH] drm/amdgpu/vce1: Fix checking whether VCE1 is idle
Date: Mon, 26 Oct 2026 14:00:58 +0100
Message-ID: <Yxz3zvy3ScSroj40wKVDxA@gmail.com>
In-Reply-To: <54fd40c6-f13f-45ed-ba55-ca38052cc3ad@amd.com>
References: <20261006170352.26722-1-timur.kristof@gmail.com>
 <54fd40c6-f13f-45ed-ba55-ca38052cc3ad@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
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
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sunday, October 25, 2026 7:22:04=E2=80=AFPM Central European Standard Ti=
me David=20
Rosca wrote:
> On 10/6/26 19:03, Timur Krist=C3=B3f wrote:
> > It turns out that the VCE_STATUS register bits that we
> > used to check whether VCE1 is idle are actually not useful:
> > VCE_STATUS.JOB_BUSY doesn't exist until VCE3
> > VCE_STATUS.UENC_BUSY seems to be stuck high on Cape Verde
> >=20
> > Instead, do the following:
> > Check that the read and write pointer matches for each ring.
> > Check VCE_STATUS.VCPU_REPORT bits to check busy status.
> > Finally, also check SRBM_STATUS2.VCE_BUSY just in case,
> > although this one seems bogus on VCE1.
> >=20
> > Fixes: d4a640d4b9f3 ("drm/amdgpu/vce1: Implement VCE1 IP block (v2)")
> > Signed-off-by: Timur Krist=C3=B3f <timur.kristof@gmail.com>
>=20
> There's still occasional warning that VCE is not idle on my cape verde,
> but it's much better than the current state where it prints it every time.
>=20

Hi David,

Can you say what the remaining warning says?
Do you think we could fix the remaining warning by removing the check for t=
he=20
SRBM_STATUS bit entirely?

Thanks,
Timur


>=20
> > ---
> >=20
> >   drivers/gpu/drm/amd/amdgpu/vce_v1_0.c         | 25 ++++++++++++++-----
> >   .../include/asic_reg/vce/vce_1_0_sh_mask.h    |  2 --
> >   2 files changed, 19 insertions(+), 8 deletions(-)
> >=20
> > diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v1_0.c
> > b/drivers/gpu/drm/amd/amdgpu/vce_v1_0.c index b1428f5bbc81..38e21d1a3ebb
> > 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/vce_v1_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/vce_v1_0.c
> > @@ -47,6 +47,9 @@
> >=20
> >   #define VCE_V1_0_STACK_SIZE	(64 * 1024)
> >   #define VCE_V1_0_DATA_SIZE	(ALIGN(7808 * (AMDGPU_MAX_VCE_HANDLES +=20
1),
> >   VCE_V1_0_ALIGNMENT)) #define VCE_STATUS_VCPU_REPORT_FW_LOADED_MASK=09
0x02
> >=20
> > +#define VCE_STATUS_VCPU_REPORT_AUTO_BUSY_MASK   0x08
> > +#define VCE_STATUS_VCPU_REPORT_RB0_BUSY_MASK    0x10
> > +#define VCE_STATUS_VCPU_REPORT_RB1_BUSY_MASK    0x20
> >=20
> >   static void vce_v1_0_set_ring_funcs(struct amdgpu_device *adev);
> >   static void vce_v1_0_set_irq_funcs(struct amdgpu_device *adev);
> >=20
> > @@ -349,19 +352,29 @@ static int vce_v1_0_mc_resume(struct amdgpu_device
> > *adev)>=20
> >    *
> >    * @ip_block: amdgpu_ip_block pointer
> >    *
> >=20
> > - * Check whether VCE is busy according to VCE_STATUS.
> > + * Check whether VCE is busy according to VCE_STATUS
> > + * and whether the ring pointers match.
> > + *
> >=20
> >    * Also check whether the SRBM thinks VCE is busy, although
> >=20
> > - * SRBM_STATUS.VCE_BUSY seems to be bogus because it
> > + * SRBM_STATUS2.VCE_BUSY seems to be bogus because it
> >=20
> >    * appears to mirror the VCE_STATUS.VCPU_REPORT_FW_LOADED bit.
> >    */
> >  =20
> >   static bool vce_v1_0_is_idle(struct amdgpu_ip_block *ip_block)
> >   {
> >  =20
> >   	struct amdgpu_device *adev =3D ip_block->adev;
> >=20
> > -	bool busy =3D
> > -		(RREG32(mmVCE_STATUS) & (VCE_STATUS__JOB_BUSY_MASK |
> > VCE_STATUS__UENC_BUSY_MASK)) || -	=09
(RREG32(mmSRBM_STATUS2) &
> > SRBM_STATUS2__VCE_BUSY_MASK);
> >=20
> > -	return !busy;
> > +	/* Check whether the rings are busy. */
> > +	if (RREG32(mmVCE_RB_RPTR) !=3D RREG32(mmVCE_RB_WPTR) ||
> > +	    RREG32(mmVCE_RB_RPTR2) !=3D RREG32(mmVCE_RB_WPTR2))
> > +		return false;
> > +
> > +	/* Check whether the VCPU is busy. */
> > +	if (RREG32(mmVCE_STATUS) & (VCE_STATUS_VCPU_REPORT_AUTO_BUSY_MASK=20
|
> > +				   =20
VCE_STATUS_VCPU_REPORT_RB0_BUSY_MASK |
> > +				   =20
VCE_STATUS_VCPU_REPORT_RB1_BUSY_MASK))
> > +		return false;
> > +
> > +	return !(RREG32(mmSRBM_STATUS2) & SRBM_STATUS2__VCE_BUSY_MASK);
> >=20
> >   }
> >  =20
> >   static int vce_v1_0_wait_for_idle(struct amdgpu_ip_block *ip_block)
> >=20
> > diff --git a/drivers/gpu/drm/amd/include/asic_reg/vce/vce_1_0_sh_mask.h
> > b/drivers/gpu/drm/amd/include/asic_reg/vce/vce_1_0_sh_mask.h index
> > 1f82d6f5abde..13c15c2138b3 100644
> > --- a/drivers/gpu/drm/amd/include/asic_reg/vce/vce_1_0_sh_mask.h
> > +++ b/drivers/gpu/drm/amd/include/asic_reg/vce/vce_1_0_sh_mask.h
> > @@ -63,8 +63,6 @@
> >=20
> >   #define VCE_SOFT_RESET__ECPU_SOFT_RESET__SHIFT 0x00000000
> >   #define VCE_SOFT_RESET__FME_SOFT_RESET_MASK 0x00000004L
> >   #define VCE_SOFT_RESET__FME_SOFT_RESET__SHIFT 0x00000002
> >=20
> > -#define VCE_STATUS__JOB_BUSY_MASK 0x00000001L
> > -#define VCE_STATUS__JOB_BUSY__SHIFT 0x00000000
> >=20
> >   #define VCE_STATUS__UENC_BUSY_MASK 0x00000100L
> >   #define VCE_STATUS__UENC_BUSY__SHIFT 0x00000008
> >   #define VCE_STATUS__VCPU_REPORT_MASK 0x000000feL




