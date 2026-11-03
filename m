Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38049606A324
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Nov 2026 16:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=thUIAh0g
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AFE0E10F6F4;
	Tue,  3 Nov 2026 16:32:21 +0000 (UTC)
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com
 [74.125.82.177])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1502510F706
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Nov 2026 16:32:16 +0000 (UTC)
Received: by mail-dy1-f177.google.com with SMTP id
 5a478bee46e88-36a6ee9c59aso363180eec.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 03 Nov 2026 08:32:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793723535; cv=none;
 d=google.com; s=arc-20260327;
 b=jKPbl13vXvKNWFK+AHReZsAnxnSAjTljdbuyxnPbPSzUQUSFRIVIg8hR4rC1cVcw6E
 n1a/rGV8+A+/kxvepnuUfWnYzt0wh+I98rH/ViBOrihHNodIFU8T6YHNC8pnrXb0aySP
 f470yNelsprikpzuFpn4d9ObxZvYmDdAfn8MPW3ZEFeyupGLGpElE0Ak/hZYH7lmeaMa
 NUJ+xNrXs/YwE4AVh+htKM+yjslVQQONP6/YkAaaS9xWkmRuVmLAU79ZxWvkn7/KDQUH
 fN6T91rY4MbxxgDRkdjn91JyxEonkJPlpsWE51ojx2kVJMUMKBXmcZRjhJ+RjxqFTlBT
 Ecow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=RUgxAAqPwp8DYJoBFr9fZ4AWpYkzpcXC2s7/8PRv2B4=;
 fh=P13Q+D6vgw6089BRtghh5PhejZMtZuJ2xQE/Hvn3+lY=;
 b=J7NrrD3E3FLmTDAM3KmR27Bx1dYqfgNwbhtK2ES2y97B08J/AMFCVvb7L0soVOqDoI
 5sEaYwMUdsa2OhCwmEocowNzf8W0Spsr97N6se1IITQDYi6GhNcDSGzjMoypRz+u8vP3
 NN43raEwjqnHqjIMSL9Z3UMlqsGD0UkQDozCT39TnNi6U2andFEhFdJqo1UW8cDviXhT
 9bhm72RQalgnB9CoPc/DAG2jFw3fdGam1syV1HPs9iWxwx68zjCnpAEC7h+VnfhIqOr8
 26ut+atpU+s6R5/I/5ii+tn3Lwb4zLLAWUkuuJSwH/LKA5Q9en/vABuJ4UlMfiqj95uE
 s8Ow==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793723535; x=1794328335; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=RUgxAAqPwp8DYJoBFr9fZ4AWpYkzpcXC2s7/8PRv2B4=;
 b=thUIAh0goEERlsvqKFZtQHMyPZKVkJwjiA+Enuenyg4gN/5orbk11MnSG3tdfyaX+v
 YKJL/0jIGNldv9f1YYicNTmERjYk3d+DNvYWfyKmSUgm0G+9pvLp3iFO3P4mpG0Wriiw
 nG94qnQMeJtNOBONirQV8dxi2bTslZOiJQvV19/kAQuQIVKLBCWdX/iIlnNuO0HBiXwS
 AqMP3Ha7K0GZoumcSfMP5+V9rz/LCD5Gufhx2ddO2MhlYRqdS+o1bTxJJmVaB0vDDaLp
 VmnsnWwptqRJPragMbdgFC4dlytbLu0zvEGztqswj0VCMW2tbG2ZvxtrwfdGcUiYdToN
 9aPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793723535; x=1794328335;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=RUgxAAqPwp8DYJoBFr9fZ4AWpYkzpcXC2s7/8PRv2B4=;
 b=sQ67gP4LX+ke0G2boHd7PvbMQ/Hk3d1wc25IZC9cbnxFWUF4vOyAhd4anzuisDJ4BR
 ffkXWIEF9d6Y4xEbWF1eYlkY26P6ZyRk7ztlT2a6h8QMUTl7b/8o0urlGHkgDNdKA4s/
 MibmL6Tf5CMUdWkZ4BOZRsNjaGSIiELxYYOr2hHlHYqpYRaaM3LKRx72SOsoTorCIA0P
 AoivtOOA/Nngl3P+LGAzt1mVmBPJDDi0bAzf8sTE9rHBdkxpawqf8/YssOvTWQnTywio
 O9DQ4lzX9z5nPNzXONfkGmj/JvA7+3deK0e3OVJq4da7+KBBPkgCbYceYycvQEjN6pxH
 kqQA==
X-Gm-Message-State: APuU4Z+URnSzLUPWCHtdxwULy7Jx8U+s+byBaiOgPm9taqGg2eKSARMP
 gAv8EPutH8mbg9zB0bm/RxEIdY0R6oGSqgaUaoQt7wbSHvq30DAtMQZgFErNAz+kguvw6Gf/2R9
 xUzH5VpYyihbEuGsOwEdWmXApKDc5Eys=
X-Gm-Gg: AYBFou3M5BHtLLbyeyTUqaoX4b2B+mriOGhIc3HRBb8/H8T41PB6k8379F8j9kwxFY3
 hH7eZPZgo+spqckSjN9N1/VA/fypwdMmWNeTGUOT1DidrdessYUBn8Z1P/W0AtFimMBQZK6TjyZ
 EbDgNPenSDzY1UyiTQ3N/qY3mS08qX3VrkpawJuELudH0IEzNQc4jOzsoJ0c7WZIPn1wR3Z64Lu
 SWSYYwSdOjQkg+b+j17uT02poRbfeK/RVj3E/XvPClzdRHqx45O5ywnEYkVYqpTJRLdHnHiYnZN
 PRkH5P/AHQY4ZtZtu1kSjVqgsK1qOFSFP5lUqMlk2AoLS0Z6yYp3wBVvS8Avs9ORDosja5OYm7H
 yrxMPM6MZg/aJocU7y76GTfQ9La+6512l5NjyxfhfcAPE01p8khe6zgBPT36ixt02vl6tYWUPP7
 sgVpL1cIIuqBebQy9et91ZEgs=
X-Received: by 2002:a05:701b:2302:b0:183:d275:cf76 with SMTP id
 a92af1059eb24-1ac59dd0e2emr29195696c88.2.1793723534961; Tue, 03 Nov 2026
 08:32:14 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261103141457.2558235-1-mario.limonciello@amd.com>
In-Reply-To: <20261103141457.2558235-1-mario.limonciello@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 3 Nov 2026 11:32:02 -0500
X-Gm-Features: AclHuK9x0PbEHQ4rgK1NtHon50xnLpZFe7zq5inPV-BvQTUHuxkRwp2TyENpsY8
Message-ID: <CADnq5_OL6vPrBX4qqCmr-uSe0nUOtNU7Z2ZgiSf596svWBy6VQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/pm: track BACO state in the SMU v11 ArmD3 sequence
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Nathan Blomquist <nblomquist@gmail.com>
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

On Tue, Nov 3, 2026 at 10:31=E2=80=AFAM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> On Navi1x/Sienna Cichlid with runtime PM, when the audio function is
> enabled, BACO entry and exit are delegated to PMFW by sending
> SMU_MSG_ArmD3 instead of going through smu_v11_0_baco_set_state().
> Unlike the v13/v14/v15 helpers, smu_v11_0_baco_set_armd3_sequence()
> does not update smu_baco->state, so the driver keeps reporting
> SMU_BACO_STATE_EXIT while the ASIC is armed for / sitting in BACO.
>
> At runtime resume amdgpu_device_baco_exit() checks
> amdgpu_device_supports_baco(), which ends up in
> smu_v11_0_get_bamaco_support().  Since the state never reads ENTER, the
> "already in BACO" shortcut is skipped and the live BACO feature bit is
> consulted instead.  PMFW clears that bit once ArmD3(BACO) is armed, so
> the check reports "supported but not enabled", the exit fails with
> -ENOTSUPP and the ULPS ArmD3 message is never sent.  The runtime resume
> caller ignores the error, and a later secondary bus reset leaves the
> device unreachable.  This shows up on a Navi 23 being handed from amdgpu
> to vfio-pci:
>
>   baco_enter: in_runpm=3D1 audio_enabled=3D1 armd3=3D1 baco_state=3D1 ret=
=3D0
>   bamaco: state=3D1 ... feat supported=3D1 enabled=3D0 in_runpm=3D1
>   baco_exit: supports=3D0 ...
>   runtime resume: baco_exit ret=3D-524
>
> Update smu_baco->state in the helper, mirroring the v13 implementation,
> so the capability check short-circuits while in BACO.
>
> Reported-by: Nathan Blomquist <nblomquist@gmail.com>
> Closes: https://gitlab.freedesktop.org/drm/amd/-/work_items/6076
> Tested-by: Nathan Blomquist <nblomquist@gmail.com>
> Fixes: 13d75eadfa1a5 ("drm/amd/pm: correct the runpm handling for BACO su=
pported ASIC")
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
> This was developed with help from Claude Sonnet based on an extra debuggi=
ng
> patch shared on the bug.
> ---
>  .../gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c    | 20 ++++++++++++++++++-
>  1 file changed, 19 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/gpu=
/drm/amd/pm/swsmu/smu11/smu_v11_0.c
> index 09e20d5ee0446..18d8b2105a663 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
> @@ -1419,7 +1419,25 @@ int smu_v11_0_get_max_sustainable_clocks_by_dc(str=
uct smu_context *smu,
>  int smu_v11_0_baco_set_armd3_sequence(struct smu_context *smu,
>                                       enum smu_baco_seq baco_seq)
>  {
> -       return smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_ArmD3, baco_s=
eq, NULL);
> +       struct smu_baco_context *smu_baco =3D &smu->smu_baco;
> +       int ret;
> +
> +       ret =3D smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_ArmD3, baco_=
seq, NULL);
> +       if (ret)
> +               return ret;
> +
> +       /*
> +        * PMFW owns the BACO transition once armed, so keep the driver's=
 view
> +        * in sync.  Otherwise smu_v11_0_get_bamaco_support() falls back =
to the
> +        * live BACO feature bit, which PMFW clears when armed, and the r=
untime
> +        * resume wrongly concludes BACO is unsupported and skips the exi=
t.
> +        */
> +       if (baco_seq =3D=3D BACO_SEQ_BAMACO || baco_seq =3D=3D BACO_SEQ_B=
ACO)
> +               smu_baco->state =3D SMU_BACO_STATE_ENTER;
> +       else
> +               smu_baco->state =3D SMU_BACO_STATE_EXIT;
> +
> +       return 0;
>  }
>
>  int smu_v11_0_get_bamaco_support(struct smu_context *smu)
> --
> 2.43.0
>
