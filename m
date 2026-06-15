Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A311BCD98C5
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Jun 2026 18:11:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 474D710E596;
	Mon, 15 Jun 2026 18:11:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jocktvn6";
	dkim-atps=neutral
Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B6E2D10E596
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Jun 2026 18:11:01 +0000 (UTC)
Received: by mail-dl1-f50.google.com with SMTP id
 a92af1059eb24-137fe3c973cso80272c88.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Jun 2026 11:11:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781547061; cv=none;
 d=google.com; s=arc-20240605;
 b=cvbdV7QNvptZA8P2f0oPufJx9tjkDBElS1JfqUwkO3NCDiYIx4KsIs1BMU3Bjjb8K4
 WbvmKXliwWLfDZiS3O1nTv6v7Na0msxwAKJSAQDDGnMvuESs3kyJL03vWzb1ZKmEv1W/
 i6TK1gFYBxjUxSVRfqIXa0+y7X9/sM54fo2kZn5+U8LLQvXalHdtQlF6PjumZjToABU/
 wGIPCzvN/5GQaPp57IQHvE3NkveEcjEhsJ6HjAnjYZqtqtDW1uYdk+tRnjb8ukvQCtHO
 Ai/StMgSl1WhealSAnABBgaJdjS8uoQhsGd+QzFUYruDLHismXCSPxI5Z5DeK2bgdGYD
 2w+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Ab9yu7Cd1q5D3mT7WWKeN/wFAyu07eUo+v0cx92nrXQ=;
 fh=/jXuF6kkEzGc76I89MWDwYajZhHhstOH8SMMdzCQivY=;
 b=cVaP20g0svoD0qtoh/5/eMbVP9taPWFAYNlibVpWRxcyMUCuvea6CVndNaWTQfaKFv
 KUeKwV+q5i8mMEL/bFaSpa/Bmw668p/fLUEHeaydkIbtN0OmjoR4r7UjVsL9cE8x0pEV
 xpc4FOwwWj+JEeziZZsHplrBTVUWKSk2J2C0tMEd1FstVVtlxG2NxLSgv4NtYD8Bmka9
 PC5ldcDqYTZoGzhXvu868kgue2QeXH2wvpNSCOaNWR8rthN9ZgIg2kuGAIIBScQBtMQM
 MyIaXz+N/jn4t3T+A4teWzrYfucYzkuf/CfGOpSQiVph3Ruo5BJQHbrtbMK0OehVIYHA
 d4EQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781547061; x=1782151861; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ab9yu7Cd1q5D3mT7WWKeN/wFAyu07eUo+v0cx92nrXQ=;
 b=jocktvn6887ZsoRWbF06y1pBUR4qJqje1YH64JuM0G99GUqZ9gKiFaKiYNxODhuhIK
 LCMNOAnDG7tv+HpjyZwE7rugVB7eSyjKa3l2V9d2F9Z9Chgp+45pjqYGIyDaNlvgFJoh
 N/YxYM5xTyg5J8yCn7Z4kFTqXg1+/KyW0sF8na6htUbqn3AT+e4UVV83dpSDCYIP7UYH
 uGT1vbZJ7e7OuNW8pJlsl4Z47hl22Goic8m3/S1NKL/WDnHjJOH1fqPzR+34NAaUw0jY
 EbJ+NFtIP/Nt17CJGDlmaoIPW3lHrZKeuR/RCpQQJOlTKoVPU3sDadI70BxXQprWOKqO
 77bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781547061; x=1782151861;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Ab9yu7Cd1q5D3mT7WWKeN/wFAyu07eUo+v0cx92nrXQ=;
 b=otCTFAR05tva+ZM5dRrzsI8DNpmfaB7HQwRosHDbqfEim6hX9WbY51vIrsIBmJ8IKF
 hEA7IzqnN5Pje3GkiR5op0IVB7cYvRiM7gK0fPL4cMUy9MRO9ITXnirfbScks243G1mj
 9iDMZdsl1WpWRNFZmRIdHH2mGxveexoYHhoybt7Hj4GjcnBhq7b2uRve/HPBZrkNGYrI
 VvHgMbm+rzRD4BF30XL1/Vnz9z8qi/b5UN1KLouBfB7o+b7ZKt2r7U56F5EGvoQZBhyz
 8tG9iMSK0VeHLu8Atr0yruTOojRtZzuBzvBRQzB/3ilMcPlxTRRAJHc+gWOahQPLizXR
 BLVA==
X-Gm-Message-State: AOJu0YwDMGkujMIpkWgw64mS7FS+N5UTJP/IkJ+Lb1Ba23SrNNtH0F3x
 Ocqb/2Olb5CiFcoY8tg8x9QszoJyKln++QevWxDGqY9ePqEWw/KdaZ5WGeTF75UaFW7aFJF9iV9
 +c7YvyAGwDfgc7JBgjqykLfvO/V8zXMaEOA==
X-Gm-Gg: Acq92OFPPWoXaaWRn4LbTL8771yM8tsruCeAKuDs/o5H28AREWFsSyvciieDqTjYKJd
 tT3sOaJQOqm/VE9/MSyE8OCGfxZI/3iLrHKb7hs64qVD+FqJDaHAO+uYw2XYurhUE12VgjaypST
 1gELUK8YNh19QT1KVe2w1Oq9EGzHRjZ6jCnDfxqHLx4ziRS7vkKwFElU9t/Yow6t4pnGCTpbAWf
 fgMZGSoqqVeLXrx1VHYR74l8S2wA0Rsly2+5Y4huFTOjPhciINBth4ihozYdlKiSLr7wEhSkrv+
 kyxbjhSemSnYFhyWOIpnJSESh1jooTrGSm+tjV5uZ9DP7PfYnCedZ32FttfiK98IODBm/g==
X-Received: by 2002:a05:7022:5f14:b0:137:fea7:9297 with SMTP id
 a92af1059eb24-1384bb009cdmr1838018c88.1.1781547060864; Mon, 15 Jun 2026
 11:11:00 -0700 (PDT)
MIME-Version: 1.0
References: <20260613022204.1147028-1-mario.limonciello@amd.com>
In-Reply-To: <20260613022204.1147028-1-mario.limonciello@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 15 Jun 2026 14:10:48 -0400
X-Gm-Features: AVVi8CeXxFhVmpCws5yZfgAUMYNDWGynkzZyxAddvSdOziARrYuJL-_gYg-j0QU
Message-ID: <CADnq5_OHUwBrENHoriQuu656gQmLYANHLior5Fc+4=mR3UCZcg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdkfd: fix list_del corruption in kfd_criu_resume_svm
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Fri, Jun 12, 2026 at 10:29=E2=80=AFPM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> The cleanup tail of kfd_criu_resume_svm() walks
> svms->criu_svm_metadata_list and kfree()s each struct criu_svm_metadata
> without removing it from the list. The list head is left pointing at
> freed kmalloc-96 objects.
>
> A second AMDKFD_IOC_CRIU_OP from the same process re-enters: list_empty()
> reads the dangling ->next (use-after-free), the loop walks freed entries,
> and each is kfree()'d again (double-free). This is reachable by an
> unprivileged render-group user via /dev/kfd with no capabilities required=
.
>
> Add list_del() before the kfree() so the list is properly emptied. The
> list_for_each_entry_safe() iterator already caches the next pointer, so
> unlinking during the walk is safe.
>
> Fixes: 2a909ae71871 ("drm/amdkfd: CRIU resume shared virtual memory range=
s")
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/a=
mdkfd/kfd_svm.c
> index 8d241ad760f19..df7fca65e9a21 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -4115,6 +4115,7 @@ int kfd_criu_resume_svm(struct kfd_process *p)
>         list_for_each_entry_safe(criu_svm_md, next, &svms->criu_svm_metad=
ata_list, list) {
>                 pr_debug("freeing criu_svm_md[]\n\tstart: 0x%llx\n",
>                                                 criu_svm_md->data.start_a=
ddr);
> +               list_del(&criu_svm_md->list);
>                 kfree(criu_svm_md);
>         }
>
> --
> 2.43.0
>
