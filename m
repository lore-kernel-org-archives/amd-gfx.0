Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C58C607BDF1
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Nov 2026 16:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=itka6e4w
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D584E10F04A;
	Mon,  2 Nov 2026 16:05:29 +0000 (UTC)
Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4633A10F071
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Nov 2026 16:05:23 +0000 (UTC)
Received: by mail-dl1-f51.google.com with SMTP id
 a92af1059eb24-1ac926f28c9so217253c88.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 02 Nov 2026 08:05:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793635522; cv=none;
 d=google.com; s=arc-20260327;
 b=ATV5rCmTTEhE1ijiYPoybOqQ9nW/7NrQiKTDwrx1EHMc9+zVCwtR3BnjGm+cestVX7
 5xhBoCAANiL8gWpgvCyFgdmFIryi6j14xg3l8SaGBJdKmBoZOz0dZM4yrXjbNvlxPW5O
 2lEjIORxtmOI0QhoKQq47vGCQmSrerey/PT1/YNsIVFOPgr4vAqmuQsOABhwphPGJDKE
 YzGkVh0kOXSEydk3wSQId3Y9SBhmW2qNwmqSD72Ts71KuM0m597W3G+1hFn93C+iqgte
 YNwm5LDu9dai0BlQM7ReBom650a+t7Weu6LkWucj0QGzCe9MIhIxPP+CQF7JsB2fbP3t
 fVRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=qM2dyLxIJxVzLOT8NAS4jU2rvWxXsjk/TSdQCq7DDTQ=;
 fh=v8hfTPCRfCGRBhqytfXhDpSJqeKR6pVB9GGkxHWzPBU=;
 b=muUTJO0D/VCVk+hCIb3cGSWXHFnjJtTSlsLE8n5veR5lVSKX2QbR9TiDPgV1qOOkmx
 O/Ms+QMW6MkOdeiRms2+pIYTSUy0uPP1dgOqb0DAf1m3+PFWsnXpm1GJrBUwUdnIclXo
 rGSVasCWOq4gTZq+au3ENsL7HRGXYgFh6RfPj6JFr6Q/D0TlQwYFedNjz8G61BI2jIsa
 522M/6i98KSpj0rQ6XNjvdXtLJ2/UAzPmvxmPAjRNGb4oNU0IWvECmpY0Q6UtGotzzCw
 PYFDIkJ31hyy33E3RTeHOI70+tsoTV/7SJ9ysyOFqWfV9W8vyUXmFeBLAFOveppl/YKc
 CBvA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793635522; x=1794240322; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=qM2dyLxIJxVzLOT8NAS4jU2rvWxXsjk/TSdQCq7DDTQ=;
 b=itka6e4w/AXkiyU+zIUWxi+JkxVSE554Fat/hPiC+8urWBL+gYbwEAaMZKX9bTX1y7
 sB7XAnn3WjDzMBu6klam9lupx/NfIg/lu8p69LFO85HFJU7iTsPzSg9splm1weuqQqr8
 sYHdHkpGiZaOnJ/NuogjC8Xjixk+6O9kTxHqIHBXjNbkZG+dA0KJ1o1U6hbgd1r7HjAU
 aALUetuQIeDOFAjoXVMgtvfjquXxzr3Tz9ssIH2QbcNeBNz4Vu0JPwzNIxfU51Ognbgq
 JD3PY99ESKoM4uqmSHgcFkYU2omM8wUshps6q8c/d2LdGE9u/iyHRJ/fQGASZY7fYjPs
 +D5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793635522; x=1794240322;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=qM2dyLxIJxVzLOT8NAS4jU2rvWxXsjk/TSdQCq7DDTQ=;
 b=SSeEjaKSzzbbkrPP3zK3mZAgExKg2rTDzOvaBhUb/HNQMwAPpE0IXAMMl61kXO/XIX
 DSlHvxoVmAAe8CfjNslsxT398VpXBEQLvIt5POe5mnPSKHggN92LUu3Mk93dotVtpYUD
 /9wBOTO6woCweJTEWOqyrXKomVfzuU7MlHHLB308Qv2Ko5qNvirMfE0dbPXd8VxSUZIR
 U5UX65GpXnevOSvkVeomMcxq+4KdSmBdxMGbhLQK82LN8Ib/OK9S86VnrkVnaUPrartP
 qw2MUaMLoh4QZFP38slLLe2lkXhMw7L6gTJX+z2om+ymaT+ljR4eVi+cE9C7bxvuU/aW
 5ISQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxtedI5yfh4py9veJdN3/jn2VpvG8xfjxiim9EPBloUck/q+S1Jg/6wDagQZtE3DjCzKB2kiGkr@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJIaCj2A3iEs+wGZBKhCLKyfkQXE3nKqzguezsl2gPRskPcnB7r
 8uhAue9JBnqU5dDponf1xqMz4BJG4cpObgcrm9suBg2foXgzwaNEhLExQyT9YAzzn2SR9KUE6iI
 Z7YVR1v0D73ycLwij20yOhV8UfHzZgOM=
X-Gm-Gg: AYBFou28H5DI8Jf6D9VPKZ1uR27chMMLSKBP4yISerg71GAtY3SXyJgZ+Q/T8H5x2uD
 grM/BsGUDqOAJAhBPAL2i1kA/WmGoKWAKpSUHCFkNlM06JZ8XC+PBlR6E0/GFDU2vjuCYI/+Loo
 SOZrZlU4mzq97yhMLDoijayTs/ipHE4HMOpYnJs3f9DiCBeyiwycF7zIMa7yR7bdyGX20zAKrtt
 Z6qGZYcQ1HucMfmUNCbAgKGl7MaYHKnwAT16sFNJWbE7CWHkYvgsyMUN5yRVcQb/1Reo1DnD0EK
 IT/q5aXdvMZMVlmWurDXivPI5sv7Tr74+06Ca+l0teAhXplXSGCukUdm9ZyR9SNkocDfk0r95NK
 Llt4OXXZiCHIpvo/heNnT+QlJ3TXHqrt0rAMPWjm4P0QeIxkgKSXhlJ8D6O3PqJRLiR54jer7K7
 +J+XFQnVS2ieGQuYxPfrlQsGc=
X-Received: by 2002:a05:7022:7e0c:b0:165:be2f:c56e with SMTP id
 a92af1059eb24-1ac5b7dcb2bmr26252824c88.2.1793635520495; Mon, 02 Nov 2026
 08:05:20 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <25995707c39c0c191e3ac46c4813f55a7f928403.1793131583.git.calvin@wbinvd.org>
In-Reply-To: <25995707c39c0c191e3ac46c4813f55a7f928403.1793131583.git.calvin@wbinvd.org>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 2 Nov 2026 11:05:08 -0500
X-Gm-Features: AclHuK_T_9wl2_ge7HTrGL9Ufakev4qpuajb3TNVntCGEszFix2ZV1_vjQMYFjg
Message-ID: <CADnq5_NuQEvx8OpyPOuXgtzQB67jgaNtwW85X70UraOLaF=M=A@mail.gmail.com>
Subject: Re: [PATCH] Revert "drm/amd/display: Allocate DCN32/1 dmub memory to
 GTT"
To: Calvin Owens <calvin@wbinvd.org>
Cc: linux-kernel@vger.kernel.org, Harry Wentland <harry.wentland@amd.com>, 
 Leo Li <sunpeng.li@amd.com>, Rodrigo Siqueira <siqueira@igalia.com>, 
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Alex Hung <alex.hung@amd.com>, 
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Fangzhi Zuo <Jerry.Zuo@amd.com>, 
 George Zhang <george.zhang@amd.com>,
 Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
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
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Reviewed and applied.  Thanks!

Alex

On Tue, Oct 27, 2026 at 4:36=E2=80=AFPM Calvin Owens <calvin@wbinvd.org> wr=
ote:
>
> After commit a637a140ab860310 ("drm/amd/display: Allocate DCN32/1 dmub
> memory to GTT"), a machine with a Radeon RX 7900 shows random garbage on
> the screen. It reproduces sporadically, but at times it is so bad the
> machine is more or less unusable.
>
> The garbage is always horizontal bars extending across the entire
> screen, always approximately 200 pixels tall on a 3840x2160 screen,
> for what looks like a single frame. The bars are mostly black, but will
> sometimes exhibit striping and periodic artifacts which smell like
> non-framebuffer data is being rendered to the screen.
>
> It took some patience on the "good" side, but I was able to nail it down
> to commit a637a140ab860310818a14fb4d37e39e51a06be4 with this bisect:
>
>   bad: [cee9395acd8043be0644b25c34bfa86623f2b935] Linux 7.3-rc1
>   good: [8d3ae59288f1e7d58d76558a6ee96d533bc5019f] Linux 7.2
>   good: [55ab7e14222e5f0b0fd9f7711ca391d2924b35e3] Merge tag 'for-7.3/blo=
ck-20260819' of git://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux
>   bad: [df51bdc5e80dae43cab81f6cc641e98638303c88] Merge tag 'mtd/for-7.3'=
 of git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux
>   bad: [29daacacf4cd84e6917f09de6a99fb170071c14c] Merge tag 'drm-rust-nex=
t-2026-08-08' of https://gitlab.freedesktop.org/drm/rust/kernel into drm-ne=
xt
>   good: [fff648aec5e2790d117a0ec5c849a284d9d33d70] drm/amdgpu: include am=
dgpu_video_codecs.h only where needed
>   bad: [336e0cd576817ac64a4b394ca2b3680029f3e37f] Revert "drm/amdgpu: fix=
 aperture mapping leak"
>   bad: [789f7486a384ca58b9d7a76abba5efa0e80e8dab] drm/amd/display: Test p=
lane colorop helper walkers
>   good: [e0e426f10ad653c5e9dd33fb4a76d55f06101992] drm/amd/display: Test =
helper_check_state rejects
>   bad: [982b2a43682b55e7d9800000f2592832ff2865ba] drm/amdgpu: Fix IP bloc=
k NULL check during soft reset
>   bad: [9102b39fa924dcc3dc75a3137bfa9633c40b88c0] drm/amdgpu/userq: fix i=
ndefinite fence wait during GPU reset
>   bad: [b23470a026afe64de5c1df4ad181587b49c22923] drm/amd/display: Exit L=
S for ISHARP before coefficient write
>   bad: [f02b2e47355e9d381a7f34acc997e1c47879ca21] drm/amd/display: Add KU=
nit test for wb jobs
>   bad: [c6a13d145cc811b19c8a0620f25868cf7d5700c0] drm/amd/display: remove=
 unused dcn42 socbb values
>   good: [1d8327353de6f1f34063840f362c208c84064f54] drm/amd/display: Fix V=
ABC Init and OLED Support
>   bad: [a637a140ab860310818a14fb4d37e39e51a06be4] drm/amd/display: Alloca=
te DCN32/1 dmub memory to GTT
>   first 'bad' commit: [a637a140ab860310818a14fb4d37e39e51a06be4] drm/amd/=
display: Allocate DCN32/1 dmub memory to GTT
>
> Sure enough, reverting a637a140ab860310818a14fb4d37e39e51a06be4 on top
> of v7.3 completely and totally eliminates the problem for me.
>
> Mikhail has separately reported this regression:
>
>   https://lore.kernel.org/all/20260829010525.29935-1-mikhail.v.gavrilov@g=
mail.com/
>
> ...but it seems to be much more consistent for me than for Mikhail, it's
> never taken more than 30 minutes even when the machine is completely
> idle. I've also never been able to reproduce any artifact one single
> time without commit a637a140, despite a lot of effort.
>
> I'm not sure reverting this is the right way forward, since presumably
> this would re-regress the timing issue Fangzhi alluded to in the
> original commit. But nobody has proposed anything concrete yet... so
> let's start the discussion here.
>
> I'm happy to help test other better ideas as well :)
>
> Signed-off-by: Calvin Owens <calvin@wbinvd.org>
> ---
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_dmub.c    | 11 ++---------
>  1 file changed, 2 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_dmub.c b/dri=
vers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_dmub.c
> index 9ff25bc8ee5ae..870534b7cf46d 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_dmub.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_dmub.c
> @@ -511,7 +511,6 @@ int dm_dmub_sw_init(struct amdgpu_device *adev)
>                 DMUB_WINDOW_MEMORY_TYPE_FB,             /* DMUB_WINDOW_CU=
RSOR_OFFLOAD */
>         };
>         int r;
> -       int mem_domain =3D AMDGPU_GEM_DOMAIN_GTT;
>
>         switch (amdgpu_ip_version(adev, DCE_HWIP, 0)) {
>         case IP_VERSION(2, 1, 0):
> @@ -648,19 +647,13 @@ int dm_dmub_sw_init(struct amdgpu_device *adev)
>                 return -EINVAL;
>         }
>
> -       /* Limit to allocate dmub to GTT on DCN32/1
> -        * TODO: Other asics with GDDR7 may have worse latency
> -        */
> -       if (dmub_asic !=3D DMUB_ASIC_DCN32 &&
> -           dmub_asic !=3D DMUB_ASIC_DCN321)
> -               mem_domain |=3D AMDGPU_GEM_DOMAIN_VRAM;
> -
>         /*
>          * Allocate a framebuffer based on the total size of all the regi=
ons.
>          * TODO: Move this into GART.
>          */
>         r =3D amdgpu_bo_create_kernel(adev, region_info.fb_size, PAGE_SIZ=
E,
> -                                   mem_domain,
> +                                   AMDGPU_GEM_DOMAIN_VRAM |
> +                                   AMDGPU_GEM_DOMAIN_GTT,
>                                     &adev->dm.dmub_bo,
>                                     &adev->dm.dmub_bo_gpu_addr,
>                                     &adev->dm.dmub_bo_cpu_addr);
> --
> 2.47.3
>
