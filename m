Return-Path: <SRS0=Iydh=KT=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E07C3C04FF3
	for <amd-gfx@archiver.kernel.org>; Mon, 24 May 2021 18:50:22 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A0E9D61413
	for <amd-gfx@archiver.kernel.org>; Mon, 24 May 2021 18:50:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0E9D61413
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F01B16E90C;
	Mon, 24 May 2021 18:50:21 +0000 (UTC)
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com
 [IPv6:2607:f8b0:4864:20::32c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 38FEF6E90C;
 Mon, 24 May 2021 18:50:10 +0000 (UTC)
Received: by mail-ot1-x32c.google.com with SMTP id
 i14-20020a9d624e0000b029033683c71999so15004788otk.5; 
 Mon, 24 May 2021 11:50:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=OA4u1hUVW7+czWLOl7FPRNPAHAh/vc/gl/M2fiIZYJo=;
 b=tQ32gaJ+K524LKDCVZIVsFdMx5pCHrP/SDGMrpfkp0V7f+aQg0NutnYXMkesDoexif
 n2+tK4S+bphjLSN2kEcC6C7z9YBFVFBIreIhdg0x4rRIMU0jkHEkla0y5cDBNr3mHaPn
 kl8H3/DFY/rz9Dl+uqpvH3aJCCgzHC7tfzu/wQlTFe+UWJf9hTPXJ12olYhHAgghQGgO
 FSYeEShH7WQ1ssMxvkzVLmVtMoOpF7BFQdFzoPKM1HQYO+GKODiYM5nw84om2K2sR5Hf
 LJ9MmwmflUEZffrDx/bUSw6EugvN8R10GbN5W5H9uShfTJaZGM9EWKVUfVjCP36awygI
 55fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=OA4u1hUVW7+czWLOl7FPRNPAHAh/vc/gl/M2fiIZYJo=;
 b=gzRBDIyWikDmwNNUSFAq+MsIqidEFokWbxc7sFFmG8k5a15ar7KcQ7rdUOQw5AFvAM
 nWk5zfBw4fmu/22mJ3p7F3NRHYM0Qb9EKjb/loeZxvIdHfxD36F/bnjoD+jkqKDekg4T
 +bXVWG8gaDXsDkv1KgMoCVQzsQ/8pqQuEj1DR9ov3gtXV/QbtkYrkF665s3DGtYzaRna
 dwhU59yiMVYcc543p/cea86BoZDTkE02CxMXLwHrbTl64XGn2RP/Nz34wKPZvy4TtHtm
 jbujAo1qxi70oqQDOu3T3iFZUQFMO7rNQv3fyTM3UUtpgwczQUeax7Hh2Z6SNmpqPQXy
 eU+A==
X-Gm-Message-State: AOAM533THZHrN5lgd+9+Muhk9xCUTtQw41tj6aoFTrJYqIHXD+90pwl4
 9fKabfEFNakDo1jyKywk8s4Hu2GbHH3lT3qCp6s=
X-Google-Smtp-Source: ABdhPJwiKzX9Gj1sMzHOgN92igF3UyXdCiTIb4xlUH7OP/tM0D4aeQ/+U1aKEUBnpy8WLZa75emQN038NmfSWdArwjY=
X-Received: by 2002:a9d:57cd:: with SMTP id q13mr19783026oti.23.1621882209553; 
 Mon, 24 May 2021 11:50:09 -0700 (PDT)
MIME-Version: 1.0
References: <20210524071554.12344-1-nswdhpyhwt@163.com>
In-Reply-To: <20210524071554.12344-1-nswdhpyhwt@163.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 24 May 2021 14:49:58 -0400
Message-ID: <CADnq5_OoFF=zEr61yRj0c6xXTBO4qLwor76e4knyyPg1ZhHF0g@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: fix typo
To: nswdhpyhwt@163.com
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
Cc: Dave Airlie <airlied@linux.ie>, Lee Jones <lee.jones@linaro.org>,
 xinhui pan <Xinhui.Pan@amd.com>, LKML <linux-kernel@vger.kernel.org>,
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
 Sonny Jiang <sonny.jiang@amd.com>, "tony.huang_cp" <huangwentao@yulong.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>, Daniel Vetter <daniel@ffwll.ch>,
 "Deucher, Alexander" <alexander.deucher@amd.com>, Leo Liu <leo.liu@amd.com>,
 Christian Koenig <christian.koenig@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Applied.  Thanks!

Alex

On Mon, May 24, 2021 at 3:45 AM <nswdhpyhwt@163.com> wrote:
>
> From: "tony.huang_cp" <huangwentao@yulong.com>
>
> change 'interupt' to 'interrupt'
>
> Signed-off-by: tony.huang_cp <huangwentao@yulong.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c b/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c
> index 284447d..6c0e914 100644
> --- a/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c
> @@ -340,7 +340,7 @@ static int uvd_v3_1_start(struct amdgpu_device *adev)
>         /* enable VCPU clock */
>         WREG32(mmUVD_VCPU_CNTL,  1 << 9);
>
> -       /* disable interupt */
> +       /* disable interrupt */
>         WREG32_P(mmUVD_MASTINT_EN, 0, ~(1 << 1));
>
>  #ifdef __BIG_ENDIAN
> @@ -405,7 +405,7 @@ static int uvd_v3_1_start(struct amdgpu_device *adev)
>                 return r;
>         }
>
> -       /* enable interupt */
> +       /* enable interrupt */
>         WREG32_P(mmUVD_MASTINT_EN, 3<<1, ~(3 << 1));
>
>         WREG32_P(mmUVD_STATUS, 0, ~(1<<2));
> --
> 1.9.1
>
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
