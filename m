Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEBC7C55ABA
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Aug 2026 13:41:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 77EC910E225;
	Wed,  5 Aug 2026 13:41:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="A8yFF7Rk";
	dkim-atps=neutral
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com
 [209.85.216.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 07D3410E225
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Aug 2026 13:41:02 +0000 (UTC)
Received: by mail-pj1-f41.google.com with SMTP id
 98e67ed59e1d1-384caf7b168so166899a91.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 05 Aug 2026 06:41:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785937261; cv=none;
 d=google.com; s=arc-20260327;
 b=Axm9mYnbvbx00V+77y34R+xQqbCujwAQCha7M8+tWUq9C65UZqX3ggv/9XVt5p+yhc
 JQ3gODUW79eqXSUkc2SiBiP9KdHEucUEGBvwmnu3OyVMz39MVoK9nzNHeYEuKe2FjbuU
 lrXpmfzU3X5SXaejGFWCpxxdHyCTbk7Dd0NES0RAtWD+XxoeyEOA/IY5kWGdX821isYg
 CJQxygnSULSeTVRjuqpExqCtwcuqaTadqySLlqLSQ6rZaqndhVc5r3zq5nwP5OX2MCh0
 O4yNrP5re6eP+DDiVlcHERB95Rk0IhhRjTMaTwDWdtXkDHrAbcj1rtz/+SZxnpCgB35o
 52hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=GapiQ9StxYxVk7zeJhKlHuUvvsowJkq+WOElDe+zHKc=;
 fh=jsbzaPJV6Idfu/aHZHBtuLdy3EnYYz6dSh2l+d/SLOk=;
 b=ISkXfpfNEFhalkmYp4Sy/YdzpG99atvKaM0xs89lE2U9jKJls1JHxR/QmOnZ1h68nj
 8lKarycmRMm/XIxyyFVvtegLKOv4ZBrlWbOnk26MXCHUVFnK5Xfl/REWV3+7FthKA0XD
 IrHXW0SPnEvgYeo1MsEVCAY9s9onQd/b8aMjPEU+gQ4JoG5z+GJrlDVmNH9k8Zn7smgM
 0AX3mKHSiB4QB8Erd4jZKvsHIprg1yimZTvU/e+UIvA5mpmzpz65whKC0qd6SldRMFBi
 3A1T4ZqK00yaw0D7FfYcSCsFi59UCu0/Tf8Gqv24y51QZ2lStWSsJU8wHksN1QgvqL/3
 5nXA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785937261; x=1786542061; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=GapiQ9StxYxVk7zeJhKlHuUvvsowJkq+WOElDe+zHKc=;
 b=A8yFF7RkrixdgeaNd4OC4uLUmlD7esDv2Z9A1OKtDHax8ZmXmsSHy+BFd9aSU93U8F
 r0+2w5+gHurf+bkYXRFAPIsczh+qDhFAPE5wJ2WKsH1Vlw06JGVrfLIwBfz9Y6Pj7LfW
 MtAMi6bJPYKDM1t0LcZs4RpLgr9tWJmkDea5P+MwBEVEA7VTqxXD0Vsr7bRdZSUcgHTt
 s5GXUhMlDDYaS8HLGv1W1Ms8bBaJOVtT0c93b+jwQyMQlFcf+1RlH+Ga3XxpyboUp+EG
 0Kz1Ir0qvEe8v+8u/olQmxdK3r/88GGwyFnXQetxz8C6idCVWFOEv6FNhQWgNgxXYAp+
 Q9eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785937261; x=1786542061;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=GapiQ9StxYxVk7zeJhKlHuUvvsowJkq+WOElDe+zHKc=;
 b=b4KrRDCLEtqueVLIRXBQQg5OrrydHZOwEmYVbZWeEvBIJVbkF19wqbz+NTJd2P6a+E
 94k+Ohllmy6PRKf04X1YIfHHHbPreFzpnofq+iNld62DgzkBKq/r6MOvM8VFERYFoBoo
 2RGyBCOjMMxr02NEy4dwWXLIAAm6UMsXDDTPHDJJfsPdCGEzL935rJ7NdXDMtTBfl0L9
 X55YVnacg7kl/mBWbJwmSBjCmAmbmQrhU3SEkPtWcXwsS32Px6+MD0L4WYLJwZiVK2/V
 HFQqBTLfU6Ia5zoMOGqMBGCgnOdGfFVRp5/h+h48vtXHyvemqvcRj9kV/k2sbuBJd9W1
 dAjA==
X-Forwarded-Encrypted: i=1;
 AHgh+RomE1emzDpWgkTxeztszRvHAFI6SoPHHvK1Pb2Uaz2+WzhPpUUWJ4Lm1Nmi2F3CGwi66xKnSb83@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwMvZ7xJ4ff+sQsPtcyMwpOakzUL6FindJ8JVn5WMCzAl7478s5
 V3EeSy8oKNZ3AsYJfwUT2pNbtNF/PqArSG36LLhaBYCrTww5bHcC3PIyWQRS0yWulY33uGj/b99
 7362t7WMeTx492s+jJIuMAsMObnpVFps=
X-Gm-Gg: AR+sD11ilAtwd9dDWEKHaCXg/I02tVNHnhPS7v3ZRLRwvD5+APQSHqNfmiBc6vP1BOc
 N5HfompqN5RWuM9XM3knsomwNXSYtt9MM9aqX+bmSAaF/iBRD1Fom/ZW0jKygvj+5216dMmXVr2
 P6CSLxJy4/tOpsA5b7IPFggsqlGtAnB5+V9W2XAuXGURiU6SvARRqR0zXsKOclocyGi5tlohnvB
 5tlrWw71To/cmYl4UcjdPJMqzEYjAb3BOSL2AePKcuOZhKHbxcYa7U8qrb5JjEbdf6SKYVEPB6M
 0OOXDLB5teNXR8AD13rqnR3Foc8oTfJiyavfjOQSzJnzHyrGxF31A1HRdB+WwAlTVZ2HWNBoeKp
 SlTIEQ/zzyWt8qLzY8LemS752T3tUlAs=
X-Received: by 2002:a17:90b:4410:b0:38e:6d4c:14df with SMTP id
 98e67ed59e1d1-3903c5bff9dmr4959975a91.1.1785937261455; Wed, 05 Aug 2026
 06:41:01 -0700 (PDT)
MIME-Version: 1.0
References: <20260804125234.14043-1-dken4546@gmail.com>
In-Reply-To: <20260804125234.14043-1-dken4546@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 5 Aug 2026 09:40:49 -0400
X-Gm-Features: AUfX_mxOD6243SnvlN5N56bm-RB7Vl1khc3d_eIp5-pR51TnhUKoQMUSReOW35M
Message-ID: <CADnq5_O=3gwWFUcUpV-YBxHwQrxpxF_jQC5m+vn06f3VmPExxQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Fix typo in comment
To: Kenji Takahashi <dken4546@gmail.com>
Cc: alexander.deucher@amd.com, amd-gfx@lists.freedesktop.org
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

Applied.  Thanks!

On Wed, Aug 5, 2026 at 3:43=E2=80=AFAM Kenji Takahashi <dken4546@gmail.com>=
 wrote:
>
> Fix a spelling mistake in a comment.
>
> Signed-off-by: Kenji Takahashi <dken4546@gmail.com>
> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_queue.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_queue.c b/drivers/gpu/drm/amd=
/amdkfd/kfd_queue.c
> index b249e7d1af48..d634b91bf81d 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
> @@ -102,7 +102,7 @@ static int kfd_queue_buffer_svm_get(struct kfd_proces=
s_device *pdd, u64 addr, u6
>         mutex_lock(&p->svms.lock);
>
>         /*
> -        * range may split to multiple svm pranges aligned to granularity=
 boundaery.
> +        * range may split to multiple svm pranges aligned to granularity=
 boundary.
>          */
>         while (size) {
>                 uint32_t gpuid, gpuidx;
> --
> 2.43.0
>
