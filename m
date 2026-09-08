Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51B73C79F82
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Sep 2026 18:24:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E09FB10ED30;
	Tue,  8 Sep 2026 18:24:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gQ5dv6N9";
	dkim-atps=neutral
Received: from mail-vs2-f12.google.com (mail-vs2-f12.google.com
 [74.125.227.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C673D10ED2C
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Sep 2026 18:24:36 +0000 (UTC)
Received: by mail-vs2-f12.google.com with SMTP id
 ada2fe7eead31-781d5818297so127964137.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 08 Sep 2026 11:24:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788891876; cv=none;
 d=google.com; s=arc-20260327;
 b=PZOS63Tk3/W/4xqxh4zrNgx5PgPTmBvmlxRfkMYqsryWoplgrs61TWwPO7dk6BleZ3
 MHxJYs8Moe0FnTg/x7utwXADug5uTilSEaQsk+tdTD6QSsbX0kdpRdsjLwWDzijDe1kL
 95++VAnWP1IrpuieJLy1zd0J0sNjgG/2hWOAbONlLw0mR6x8P/F2rHHNfPNzmtI6/N2O
 TAJXzKxGK6tbXVYRGvT0SBISr12QHS4B+GvtGVqSyixkVtkk82BAnDta02HYs0k7E1Rk
 7kfRfOnDLdtqYrMYOVGQVCcK5+KPJnxrVr+xH55nVcAW9mQMVXwwa7+HlYAp4e6g7vTS
 cYWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=7dDlt7A15+D8kvp+wdkvNLV3QYDahtH6TWhi9Cb0jpE=;
 fh=qY2gmIBjRXzVRx1Crrxqj9gwq1af1SsGKBPLsDnuKf8=;
 b=p7897AvWpKuu4rE0y1z57ccFUv7FtVm+0dHWLub5tXBu57NiPGbjtfN4ung9I6Uhnk
 Y+KJupLAsAb7h9Rc5zqA+Q4zkbEBUzVwrrJUiYzw/rQYhZlT0gNJfHBwFY1xmahtC5qA
 NmLHvd07fl9qqtgaNCBXZ2zLkJm9FjD/O9zbYJf6zrVvpgJINN3c5SpvCJoWYHAieEWs
 3Sfcw9mg47EcK9lU1OwfriQ4tvScUWZWQCFExl4Nc139KUlN+7q4PnVrLc11H9q9dRPg
 xFzBP6Bh5DXMBY2J9tU4BhZkaMdM7exB9nAko59U5X6E870C7cwrXl3nn6ardCAY2rtX
 udfQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788891876; x=1789496676; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=7dDlt7A15+D8kvp+wdkvNLV3QYDahtH6TWhi9Cb0jpE=;
 b=gQ5dv6N9pc0XQ5qNgGzneDhKKPMqpcc1iXj+R6xvK8DCbm/JmJYZv7pL9TEfnfYTwx
 y5eA1TjRXu1D6y7Z3LWdFzgJnhZ8gjwNfiYGpL8HrZeUm2sranRvE5OD77QOmQcXM1MU
 fhCn+XZAXrBuY9ZJMdRKVbV5gR3II/AeU2F7mbQsHmz6awlC1EBIYNBukeorS59goONR
 exiORASbBIcD/K1JtgX/cjfH85IFE3Pk06osVrK4mjQ/OSJUQGXR8TeYUhgz6v5JEHtG
 PdvtlxLfnXp/reKD9kFqTwW8fP1YC4P3/fazB+NzjVJhKlLhdodLVyEFPxsQzAmM4o1m
 yoFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788891876; x=1789496676;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=7dDlt7A15+D8kvp+wdkvNLV3QYDahtH6TWhi9Cb0jpE=;
 b=bC4IlblQ3FUwJPpHbA6yN2K2KMVgHWIdcYq1msWHXe7a0Q7HBc3Ipi7MGGsDNuqgRK
 LhuDWbu/TqZ9pQD3hcA2neSVGts5Iuls79+mlltNmv34XIEjQdjc8Lbi7u+jvLeTpO/f
 0kZ1pXMuvKtTzcW1jTI0jdoEOFKpXv2LtBjGNXZ714VvOBEOO0XYrMLMcUEKrI9+1YsM
 jO+AkWelAmpKR+YX6MHE/2JpNYHk7Vb/0VkEhjWJHWPc7aZuyn6OV5HLsT6jSKDRIa8K
 phqWGbV06g+1T8zbFODM4Zq8mKi48SEK5zYfesayUcQekVN7J2DG6559Nzafs/QRu68M
 /VAg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxrxYH9TnfoQO/UmfsuM8Qvcdx1OsRuK7Tr5YqkyAFmzmcu3QlqFxmCMlWg/3EH7jnCDbn8kJX/@lists.freedesktop.org
X-Gm-Message-State: AFuF++n1PwcuPmov51ma0X5EU1T/hRDT+xJjM03LGjWK/u/AT7jyEbl/
 Fe6Ca5p/2hjGXCt29zITRHEBIVFmF2obGJt/Y/wA+EFo8sJx9Vj5mGhp91I0OV9ed4Lq959/mW5
 mvoq4QELa3qoZEx+AzCmTvgOUhJW8+vs=
X-Gm-Gg: AYBFou2ZOBGfqjxtkFBfc5D5dwpLYmnPWtUfd9MKdfs6wt8ZMiFmKQQk3iadHL2yuti
 Zw3pjeZqTEINabiA2qDJ4coisYqUunxoa5EpQb40jWSnJei64ZRcIQMASospAgnPoq7P+jIneWq
 uc4bgadAVJPhVYL2Q0JyVAsycSlu4tEdxZ7KYQc6O5YxgvNrkJrSBiNvEkPxkJMjq1s4eyRN3P+
 Hr1oJfe/+cKwDbT8W4mu5Z3zx3kALvG1/jTKKSISWZDd458OQTwkKtRyIsRMnxqf1ySvsc8WGWI
 tRUM5PQH1ioh6rbUb3I1zBL/UQd7czyhVkh8a9IG/ci8vyB5VBk3Mpo7FkCAvODffS6+g/96pbb
 X5zgFejlArV5q1iHAJerHD8guUcjD+FZ6pOdtIp4vxF4=
X-Received: by 2002:a05:6102:390b:b0:784:a169:1925 with SMTP id
 ada2fe7eead31-78a60f2f87fmr3978548137.2.1788891870816; Tue, 08 Sep 2026
 11:24:30 -0700 (PDT)
MIME-Version: 1.0
References: <20260905133405.3733-1-williandossantosdeoliveira287@gmail.com>
In-Reply-To: <20260905133405.3733-1-williandossantosdeoliveira287@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 8 Sep 2026 14:24:16 -0400
X-Gm-Features: AcwNN1Uk0e4DpddE6Fug7WAF4PUZv3cWBapnLxAt0DlxdiPlRpH65L6MJkBojVM
Message-ID: <CADnq5_MKbn9CArL+JNT1NLkK0b80CMF4B+yThgbZTHbKS4FByg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/gfx8: fix register_list_format leak in
 gfx_v8_0_init_microcode
To: Willian Oliveira <williandossantosdeoliveira287@gmail.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
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

On Sat, Sep 5, 2026 at 12:00=E2=80=AFPM Willian Oliveira
<williandossantosdeoliveira287@gmail.com> wrote:
>
> gfx_v8_0_init_microcode() allocates rlc.register_list_format before
> loading the MEC firmware.
>
> If loading one of the subsequent firmware files fails, the function
> returns through the error path without freeing register_list_format.
>
> Use gfx_v8_0_free_microcode() in the error path so all previously
> allocated firmware resources, including register_list_format, are
> released.
>
> Signed-off-by: Willian Oliveira <williandossantosdeoliveira287@gmail.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/=
amdgpu/gfx_v8_0.c
> index 7f91186ef1d1..b213870ecb96 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> @@ -1211,12 +1211,7 @@ static int gfx_v8_0_init_microcode(struct amdgpu_d=
evice *adev)
>  out:
>         if (err) {
>                 dev_err(adev->dev, "gfx8: Failed to load firmware %s gfx =
firmware\n", chip_name);
> -               amdgpu_ucode_release(&adev->gfx.pfp_fw);
> -               amdgpu_ucode_release(&adev->gfx.me_fw);
> -               amdgpu_ucode_release(&adev->gfx.ce_fw);
> -               amdgpu_ucode_release(&adev->gfx.rlc_fw);
> -               amdgpu_ucode_release(&adev->gfx.mec_fw);
> -               amdgpu_ucode_release(&adev->gfx.mec2_fw);
> +               gfx_v8_0_free_microcode(adev);
>         }
>         return err;
>  }
> --
> 2.47.3
>
