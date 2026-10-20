Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 902C1606A32A
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Oct 2026 16:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=F0kog+ea
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 385A810E188;
	Tue, 20 Oct 2026 16:13:27 +0000 (UTC)
Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C237A10E188
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Oct 2026 16:13:21 +0000 (UTC)
Received: by mail-dl1-f53.google.com with SMTP id
 a92af1059eb24-1397a4855beso235440c88.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Oct 2026 09:13:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792512801; cv=none;
 d=google.com; s=arc-20260327;
 b=cqpXlvTEqR877FdN9HZ+QlGcC0AhE9ZmFBJdci7b/bSPlyr+g+DwGoiXi7Gwjt2rBH
 YR3ApgPjQ3yxvBS0aCO1AluJd0SgxQP8BluUs8Sc26e68B4ndjhBafD0iB0L3n4NW52D
 IaCHbhllWcmhR215tiDxoCbTYhEfvHzL5ZD+UQqA7+gBhR1PVkwsYuTBc37Q1jWfw3Ic
 FQizkQErLuOrmKN3XYhz6LvZBJT11Ij+e8MO8eUAKSlT7sD87Hg3Fj06COGscRkf4LY1
 iIQUfKAizOJwn0jDK3Fl9bvLmhUTKi1hrU/6eY+QcEGmtIc7hHJlgd8sRD8EQnp946lY
 OllA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=lWeMvkkCIi4m7pcvCrwRAC3nE3MaPtqeML0KJ5LXHz0=;
 fh=H66sDFOJP49CEBGQKdrcKluMCabi0Af161YzNi4o7bo=;
 b=T3FocGToHdvZouGzoo/IkSZNK7yswtMfN6UDEjw/PUjrCxATV501JKpIRKAzgNhsyR
 3ToR3IMvxi96Lhn0xeB2KFD2I83ruhsIFXoyPUN9KaxrbfjmJkSTrcmt4QA+EgNOc4pu
 uI4smtjpkkp2n1lqZyP/OzZ5Fd6cd2ZMs3MdqwHvrMvKhxEIwCsMNHCVgOgsKRddfC3N
 CZ5odXASp9grWDLS+JMUuk4h6uXR5qEt5+YfCfeja4AalL7SCU06EqEYuc8Haj2wexV8
 pn7JvGi09LNFENTdsBwJ9GAsuJY2FZLy/EP9A1dEVsyeT0wI9DePZvRoBZAiWZvjuvz7
 PJNQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792512801; x=1793117601; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=lWeMvkkCIi4m7pcvCrwRAC3nE3MaPtqeML0KJ5LXHz0=;
 b=F0kog+eaM2Dj+wMi3MN/vgtvjK0E/VBvkAxi2KGkuvvfw1YLusqbIxUAmCPJHebuqH
 x2jwDPL1N/+1ybkMq7K9lLpXTrCj73k7Kion2vUTg11fJSrpIvaJjtDJq9tUSKj8kKfw
 FukBTxMQ4lEbGAYR1OYuaYHvLPyTjwj6aJD2pHeZJ7HWbhitzxS45mmvR1MPwzryWQu6
 B/t4bxTBDmAk+UiDqhqyQ++XhzMKxUltc2Lx3ikkb+Fq2XxNFdGY0Ftbs7mVGJI7Mldb
 pqLh3clKWgW4sqksW/x5vOFpbKv5PM+fvgv6v6hyvQxk2wJsGZRBssYK1Q2EEF3IXzsJ
 GSMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792512801; x=1793117601;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=lWeMvkkCIi4m7pcvCrwRAC3nE3MaPtqeML0KJ5LXHz0=;
 b=pyzPelJzbruQTu5FoBeltAUZWgHjPfthK2AAj48T8sduKzBswlKudxAILr8TCMmreF
 Bwh7mWWOhqOxr74VkfGkljGhGBG6REKhyu4qZGLftABYs529M3h2RE+d5UZrm9MqrmLB
 k2rxgKyIAvLKR+In3/ItDDhpEerCWl9OAr75KvMhqgevlJKxC4AmhBPnaqrY4QjC/31l
 rE8T7dgxLo6sT0Yo2D/sQ+t94FomLAJRWMxD2/GIjiiRZstOaOodUtGy0KeykGFQWEjp
 dg+7z5GxiyDJSpEMhrsbLZJS+twdIR9j3ZPUpHJ7qQungVttcYof/w7yFpTxK7KzyjjB
 LRZw==
X-Gm-Message-State: AFq9FYLt96/BjAm/6boAyV7DjqHSd6ATKF/5GvUhrWbTO+GzImg4RAQz
 EI/7sJMbf3n5bPf+AiFuKrNffCprDeCOFAC5KSI3EFEngH6sMnX4PKOtizODI7Cm3yEKidEAI9i
 mvj/F7kSaV31sVdrvFLUaevqjd6tLZfU=
X-Gm-Gg: AYBFou1OZlGrqfZYovCjGPXfWLafRGt0xuHs2OsdVgeBEqR+BXsZews3S26H4SRbL2R
 Rf1c6iQK+g+W5OLzoJAx1NsEyExLzmoZ1ULSDQJH/arDLC9NUa79DAsEfn+3N6FHiP5lXmMpVF2
 ma6Euv2W+bunPQ/jS4pAYlzcSt4pgZ0lXDZpcilz5rIAs1yWeDiWGW41g5l1xir9FU/ej1ySTI3
 Y0usIGsEyKz/28uDJRnIgPfqwgVCVA2VbFQvDkTtCUijBDemWg9PIs2cQiy4O5jEqgBF4KA7Aky
 1s7Zk6QYYh8QQ6ue7f1N15u7LeHm+UjBwxXab5fZnaunWkl7pkcNd98tNdk3uXkXeg6vT9TRh3v
 ZVAysTnBbtCg1adRQ/2FivyCbzEble2FYLNr5r3rdDyA=
X-Received: by 2002:a05:7023:a5b:10b0:147:d430:7322 with SMTP id
 a92af1059eb24-1850fb0317cmr24287028c88.1.1792512800718; Tue, 20 Oct 2026
 09:13:20 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261020160316.2411569-1-harkirat.gill@amd.com>
In-Reply-To: <20261020160316.2411569-1-harkirat.gill@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 20 Oct 2026 12:13:08 -0400
X-Gm-Features: AclHuK9CFYMwHswXwzJMapl6Efz8SZU2Fva4LaTCE6LDDyfKtXQGBW5F0I-y4f4
Message-ID: <CADnq5_NQst-5DeGcNpEV=s4Lsc7QKyq1Dtx3VMWPYCJig4qJfw@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: re-enable GFXOFF for compute on GFX12
To: Harkirat Gill <harkirat.gill@amd.com>
Cc: amd-gfx@lists.freedesktop.org, kenneth.feng@amd.com
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

On Tue, Oct 20, 2026 at 12:04=E2=80=AFPM Harkirat Gill <harkirat.gill@amd.c=
om> wrote:
>
> Commit 2affe2bbc997 ("drm/amdgpu: disable gfxoff with the compute
> workload on gfx12") disabled GFXOFF whenever a user-mode compute queue
> exists, as a workaround for an OpenCL test failure. The MES firmware
> issue behind that failure has since been addressed, so the workaround
> is no longer required.

Do you know what firmware version this was fixed in?  It would be
better to add the firmware version check like was done for gfx11.

Alex

>
> Without this change, idle inference servers that hold a context for
> hours never let the graphics block power down, costing roughly 3-4%
> reported GPU activity and ~3 W per GPU at idle.
>
> Measured on gfx1200 with an idle HIP process holding one stream and
> two resident KFD queues:
>
>   before:  VDDGFX 695 mV, GPU load 2%, ~9-10 W
>   after:   VDDGFX  35 mV, GPU load 0%, ~8 W (idle baseline)
>
> The resident queue count is unchanged in both cases; only GFXOFF
> availability differs. The ocltst runtime suite (40 tests) passes with
> and without this change.
>
> Fixes: 2affe2bbc997 ("drm/amdgpu: disable gfxoff with the compute workloa=
d on gfx12")
> Signed-off-by: Harkirat Gill <harkirat.gill@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_amdkfd.c
> index 121282dd30c1..34573cef3393 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> @@ -746,9 +746,8 @@ int amdgpu_amdkfd_submit_ib(struct amdgpu_device *ade=
v,
>  void amdgpu_amdkfd_set_compute_idle(struct amdgpu_device *adev, bool idl=
e)
>  {
>         enum amd_powergating_state state =3D idle ? AMD_PG_STATE_GATE : A=
MD_PG_STATE_UNGATE;
> -       if ((IP_VERSION_MAJ(amdgpu_ip_version(adev, GC_HWIP, 0)) =3D=3D 1=
1 &&
> -           ((adev->mes.kiq_version & AMDGPU_MES_VERSION_MASK) <=3D 64)) =
||
> -               (IP_VERSION_MAJ(amdgpu_ip_version(adev, GC_HWIP, 0)) =3D=
=3D 12)) {
> +       if (IP_VERSION_MAJ(amdgpu_ip_version(adev, GC_HWIP, 0)) =3D=3D 11=
 &&
> +           ((adev->mes.kiq_version & AMDGPU_MES_VERSION_MASK) <=3D 64)) =
{
>                 pr_debug("GFXOFF is %s\n", idle ? "enabled" : "disabled")=
;
>                 amdgpu_gfx_off_ctrl(adev, idle);
>         } else if ((IP_VERSION_MAJ(amdgpu_ip_version(adev, GC_HWIP, 0)) =
=3D=3D 9) &&
> --
> 2.43.0
>
