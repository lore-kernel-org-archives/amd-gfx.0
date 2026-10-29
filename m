Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26A6E606A31D
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Oct 2026 13:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gZJLpiuI
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 902631122F7;
	Thu, 29 Oct 2026 13:40:56 +0000 (UTC)
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com
 [74.125.82.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7A1CF1122F7
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Oct 2026 13:40:50 +0000 (UTC)
Received: by mail-dy1-f181.google.com with SMTP id
 5a478bee46e88-36a10095f3aso286760eec.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Oct 2026 06:40:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793281250; cv=none;
 d=google.com; s=arc-20260327;
 b=Cx/okLOoAVbiizx9cdi4/oMOzgXpKCpNJWPhsvaccE43UVwiEJvmfVQetVkZ2xr42b
 EgeNNytmsgkbDPdFY1EsQbIpU/7NBK1vnEZ8KDE296Fni0BcKbC+TO8YyvUW5TsPxBbF
 aW27aqZna0+qOyRA9zguOvk2sgXQG4ZSizcS1RGjXPl8RKdMyzA6n002Ci65XtvUU9fr
 KEtr8EonEBgFrQccYXkwDk3h9BY1UPNQEPY77qAlS7CFAj9t0ja0hWoUejksVXENXdoi
 OjvwlLmz0fXxsLvcBIMiJoAL7DzVEvZ1wCigDiw/dLpqHDmmAhurL9grfab8c++Zl2HV
 KQZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=bVFiTkau5t5vHIJyBHdT3bKSMdiPD0r0JutRryDGxNA=;
 fh=O3SVxhtq4B/tA5mcBaap42hJtOSXgcztKMGfeYgQ0is=;
 b=D40IyuwUc9JcLJ2e0MMRRyq05pJyMY5Z1WSmFooMFiZ2dJFQlBkKPPbw1gjVSKiFxT
 tQeJryAtzqbcdVExOYuWt2Ki40nHglrqSI/TaKExG00MWQSIelB1MGQ3x44Tsx0GAS0B
 ONZlvtQWTUwGzFf/eOrBhNFFOOpocOGRh+x7pwrAtDQbpj8PWR36vpvFm30ii72mf7QT
 57FLbBq0gzffvxZO0pfVGJx26FdpZCEFqdmk0Fsv6mgXCMhNu51Zji8NJ2Rso2XXWg86
 WgSIUQzM481g65T38FASeJAszwvgMc0LIwlE6tWKBF8UdWhcvrbncLtUyip2KGXama4T
 N0HA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793281250; x=1793886050; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=bVFiTkau5t5vHIJyBHdT3bKSMdiPD0r0JutRryDGxNA=;
 b=gZJLpiuIfnUPDHXq3bFWyTHxt+Jlx3kuKJTic5a2WQ02oaxba5MV2zyo/AKZnzS2eP
 gPCwrykDQcuYCXOvsp3LVtrCS1uzvSmd7qWFJUbu0fJqLoAqz9q67VhlhQHcPex0rUll
 lRCCSu4P8Sqg6X7QECkBA04mgT9+3X5jjlzc7CbDWZr+I+k385eb1JENeG1udIuhYe4E
 nuELKh1WCa95G2kLn6n4P4uVCtxFzVkpfdHrsiVWxXvqnFgCFPqTXR14Q60yREAb6CLy
 sxXT0wlp/eEnt3QkUQllMJuV0cDiHJ/5OsyI0OIAFPO2MQtUc1ZbfFYDWsT/RMlSPjZE
 vkaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793281250; x=1793886050;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=bVFiTkau5t5vHIJyBHdT3bKSMdiPD0r0JutRryDGxNA=;
 b=zpUTnE8EuK2CUgLDAF3GD39BeZWJwcmdu3zyJPL/ng9aU2uZK0sCm22The24aaYU2x
 4bzR1+vK7PXdZQDrjupaKr0Ywp3QxnZx5Ink6KhjhKjBzQkKytLWjoEiM7aHR/csFA8c
 6+B4K8y9LvGjFDtwkocxK04soc2rct259g6hmR2SHYi2ze2kdgJq69hThEAg+Zkxx9E7
 7VEVW++mFcq/hZ7IWx13NOlBCysSeZIwqxUf3Ub4FKhg3ed5RJb/Ihy8cHNRPfpSyWXE
 Pa/FAgQ9fKrWS840z8Skf+sGPHxKMCZtib8kfC5jH9FgNedI/Z9PiQWaGtvzdpt+ALTk
 6ZUA==
X-Gm-Message-State: AFq9FYIzoIpAVxZd3ZQ8u8855Ii6hpZfnYp3x02GUAvRCO5h5M6q2DEK
 XxOS99SBxTeU/H7GlOqoes8S+bKFxMQ1NJosg21tvDGqe5ATU/ctsL0FG4nIea6trFjtwrWGHAD
 3+L8cNlv8kaiXIM6S8rxB1m/eSNSiheA=
X-Gm-Gg: AYBFou2PJFES1v1YEYYIAGC5UJ08wXIn7cTFw/x90P1uCznAIzk3dyuk4ZYOhpc5E3Z
 B32NClM7V93efazQ6B/AVmVQb07W+gJwFaEDpdTNyOZbtWDS4r933bpGRdO/oTPAcSuAKhyvjL9
 0SPhOq/W0Uhg/bv1rEixwLw4aWpLocvne5wz5pex2eCO6mDzzhr7/0p+dVOw6Ax8Ft/0cFdo26p
 zRFMnJgYqRJ7Z0IgLjL0giotkCxV7eFTSGAFJnCy9PYdxRF51z4Djj3PPMNGJ+QaQ/rn2xajWIP
 6dAwlSZ68Atp+bdQ4jM3phcF4TLePKYhrYorurSI59jUiJPN1docRQbhDejpxXfdM9oK/n44X3f
 Cf2co/BNGat2ogTg4xdrMIMGiTeVdB6bZpt33sFmLe4wnQRopIcII8PuimoR1+Y2q2raSCJ/ciN
 lZqjsMvmLEGfwvC0bI6E5DPdE=
X-Received: by 2002:a05:7022:299:20b0:165:be2f:c56e with SMTP id
 a92af1059eb24-1a6cbaa9b2cmr10537103c88.2.1793281249625; Thu, 29 Oct 2026
 06:40:49 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261029070403.22012-1-Jesse.Zhang@amd.com>
 <20261029070403.22012-3-Jesse.Zhang@amd.com>
In-Reply-To: <20261029070403.22012-3-Jesse.Zhang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 29 Oct 2026 09:40:37 -0400
X-Gm-Features: AclHuK_p4T_SQLvC7jZFc9-SvIG2bPhDfXpXXwyKcWyIGN8VI6mGgBanuu0KQWw
Message-ID: <CADnq5_OFBoDLvSPass0hBSxZqpOzdDEFOMDHi0Mvs5_aj_Ro+g@mail.gmail.com>
Subject: Re: [PATCH 3/3] drm/amdgpu: program the SH_MEM registers of the SPM
 VMID
To: Jesse Zhang <Jesse.Zhang@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com, 
 Christian Koenig <christian.koenig@amd.com>, Prike Liang <prike.liang@amd.com>,
 Sunil Khatri <sunil.khatri@amd.com>
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
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Oct 29, 2026 at 3:41=E2=80=AFAM Jesse Zhang <Jesse.Zhang@amd.com> w=
rote:
>
> Commit 02232367be23 ("drm/amdgpu: add spm_vmid and exclude it from the
> MES, KFD and kq pools") took the SPM VMID out of the kernel queue and the
> user queue VMID masks, and since commit 8a9263fc8812 ("drm/amdgpu: use
> dedicated SPM VMID from the reserved path") the kernel queue jobs of a VM
> with a reserved VMID run on it. The gfx constants_init() only programs
> SH_MEM_CONFIG and SH_MEM_BASES for VMID 0 and the kernel queue mask
> though, and init_compute_vmid() for the user queue mask, so the SPM VMID
> keeps the reset defaults: no unaligned access mode and no apertures.

This is fine for now, but I think it would be better to unify
constants_init() and init_compute_vmid() and update all the vmids in
one place.  The reserved vmid will need to reflect the configuration
of whoever uses it, which could be gfx or compute.

Alex

>
> On navi48 VMID 15 has SH_MEM_CONFIG 0xc000 and SH_MEM_BASES 0 while the
> other graphics VMIDs have 0xc00c and 0x20001000. A shader storing a dword
> to an address with a byte offset of 1 writes it there in a normal
> process, but at the dword aligned address in one which reserved a VMID,
> e.g. for profiling with SPM:
>
>   $ umr -i 0 -sb 0 0 0 15 -r '*.*.regSH_MEM_CONFIG'
>   gfx1201.regSH_MEM_CONFIG =3D> 0x0000c000
>   $ amd_pmc --run-subtest reserved-vmid-unaligned-store
>   unaligned store: 0x0000000000002a00 normally, 0x000000000000002a with a=
 reserved VMID
>
> Include the SPM VMID in for_each_vmid_and_zero() for the GFXHUB so the
> constants_init() of all gfx generations program it like the other
> kernel queue VMIDs.
>
> Fixes: 8a9263fc8812 ("drm/amdgpu: use dedicated SPM VMID from the reserve=
d path")
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_ids.h
> index c134000eecfd..6d0f302c1344 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h
> @@ -45,14 +45,17 @@
>   * Equivalent to OR-ing BIT(0) into id_mgr[hub].vmid_mask and walking
>   * the result with for_each_set_bit(). Used by the gfx_v*_constants_init=
()
>   * paths which must always touch VMID 0 (system) in addition to the regu=
lar
> - * VMIDs owned by the hub.
> + * VMIDs owned by the hub. On the GFXHUB this includes the SPM VMID, whi=
ch is
> + * kept out of the pool but runs the kernel queue jobs of the VM reservi=
ng it.
>   *
>   * Relies on AMDGPU_NUM_VMID (16) fitting in a single unsigned long, i.e=
.
>   * vmid_mask[] being a 1-element bitmap.
>   */
>  #define for_each_vmid_and_zero(vmid, adev, hub)                         =
       \
>         for (unsigned long __vmid_mask =3D                               =
 \
> -               (adev)->vm_manager.id_mgr[(hub)].vmid_mask[0] | BIT(0); \
> +               (adev)->vm_manager.id_mgr[(hub)].vmid_mask[0] | BIT(0) | =
       \
> +               ((hub) =3D=3D AMDGPU_GFXHUB(0) && (adev)->vm_manager.spm_=
vmid ?     \
> +                BIT((adev)->vm_manager.spm_vmid) : 0);                 \
>              __vmid_mask; __vmid_mask =3D 0)                             =
 \
>                 for_each_set_bit((vmid), &__vmid_mask, AMDGPU_NUM_VMID)
>
> --
> 2.50.1
>
