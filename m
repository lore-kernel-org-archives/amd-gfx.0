Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EF78C4332F
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Feb 2022 16:27:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8F4D310E74C;
	Tue, 22 Feb 2022 16:27:47 +0000 (UTC)
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com
 [IPv6:2607:f8b0:4864:20::22d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DB0CB10E70A;
 Tue, 22 Feb 2022 16:27:45 +0000 (UTC)
Received: by mail-oi1-x22d.google.com with SMTP id z7so12085571oid.4;
 Tue, 22 Feb 2022 08:27:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=Wc0yqHfoagRsyXzdU2Y5/dAqtfWLM+jPqSQjyf20DAQ=;
 b=OHvXsiq6g3Rnm/ksDpKM0+8vS0aMDT5I0AZgHcAPddmSWj23yidnTLsiT5ki1k+pXC
 1p9cfzcgh6jCI28Jxy5mljhTRq8Z2cxKb4SM+a+RJa3Tmz+BA4IEosYgK1omDVW96b6w
 De7m1v1lUngpKTVZdoXCcVvmPiZ55am3YZIE5Gu09L7Hh/sVJ2f8JMI2cW5sni7V3eVs
 PLDdZlHkN2Tz/vPzC1rhAXKbr+uJD6LrNvLVoASYseP+j2wUmW1ADbLBvLoytPM+XP9q
 l7zb1W7wU69C+O3FHe3by/W1BzYzFpHV3NH0xOygMopJWD78LuX2GkmdNhGz4wUtX/hF
 /a9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=Wc0yqHfoagRsyXzdU2Y5/dAqtfWLM+jPqSQjyf20DAQ=;
 b=nQi/0ACYbZFOoonMv2tbCLDGiWjI+5eu0Ntdv5d0hI4m/NG9xSBkLUp2ORXwpHWuSP
 0S07V1a5Xll1w2q2pssUuKLmYfT6O+hNA9w2r1m8yxkH1HPvKraix3YiZU/fOcoi7EmI
 LUE0wDBfwspwqJ51JDVmkK7dvsvdw7CCymBIhChL14oN7jQVMohdGth80bntXc61sV1T
 ceNhyp8ryljjwAF0tiNyYPb1n8+Cxg1oxySfqcetyUWTo8/+gpQbaNO9II7T+Q7rUaAr
 YPONZmW3PnQWsnw4JPOzpvT00AQr/HJXcv1mCnP8cv9yHIsCy10p4OfFXkENQWNsD1Qc
 7nUA==
X-Gm-Message-State: AOAM531kzTZ0fjTgVrJTK0WzQ1j3qdCO3Obpm3CEo3wa9f5fiAJuKIRt
 Cgmq3mK4b+33sUUQo1o2X+xXbnnCyB4YX7qV0cE=
X-Google-Smtp-Source: ABdhPJzMY92Uod9CyBXvXvpyKVk0Yx2FnD1eNM4cD0ag4qAyG9Rjjzu0pW/fwzoshhVCCjQURT/oah1xCbxHxh0TvcA=
X-Received: by 2002:aca:ab4c:0:b0:2d4:7c7d:606e with SMTP id
 u73-20020acaab4c000000b002d47c7d606emr2360947oie.132.1645547265176; Tue, 22
 Feb 2022 08:27:45 -0800 (PST)
MIME-Version: 1.0
References: <20220222131701.356117-1-maira.canal@usp.br>
 <20220222131701.356117-2-maira.canal@usp.br>
In-Reply-To: <20220222131701.356117-2-maira.canal@usp.br>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 22 Feb 2022 11:27:34 -0500
Message-ID: <CADnq5_M0yBD7oE+y-gcsKkSxP+CmYxx-pdzytG-Wpqv=hw=r-g@mail.gmail.com>
Subject: Re: [PATCH 01/10] drm/amdgpu: Change
 amdgpu_ras_block_late_init_default function scope
To: =?UTF-8?B?TWHDrXJhIENhbmFs?= <maira.canal@usp.br>
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
Cc: "Tuikov, Luben" <luben.tuikov@amd.com>, Tao Zhou <tao.zhou1@amd.com>,
 Anthony Koo <Anthony.Koo@amd.com>, "Joshi, Mukul" <mukul.joshi@amd.com>,
 "Leo \(Sunpeng\) Li" <sunpeng.li@amd.com>, "Wentland,
 Harry" <harry.wentland@amd.com>, xinhui pan <Xinhui.Pan@amd.com>, "Siqueira,
 Rodrigo" <Rodrigo.Siqueira@amd.com>, LKML <linux-kernel@vger.kernel.org>,
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
 mwen@igalia.com, "Chai, Thomas" <YiPeng.Chai@amd.com>,
 "Stanley.Yang" <Stanley.Yang@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Magali Lemes <magalilemes00@gmail.com>, "Deucher,
 Alexander" <alexander.deucher@amd.com>, Isabella Basso <isabbasso@riseup.net>,
 John Clements <john.clements@amd.com>,
 Christian Koenig <christian.koenig@amd.com>, Dennis Li <Dennis.Li@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Applied.  Thanks!

On Tue, Feb 22, 2022 at 8:17 AM Ma=C3=ADra Canal <maira.canal@usp.br> wrote=
:
>
> Turn previously global function into a static function to avoid the
> following Clang warning:
>
> drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c:2459:5: warning: no previous prot=
otype
> for function 'amdgpu_ras_block_late_init_default' [-Wmissing-prototypes]
> int amdgpu_ras_block_late_init_default(struct amdgpu_device *adev,
>     ^
> drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c:2459:1: note: declare 'static' if=
 the
> function is not intended to be used outside of this translation unit
> int amdgpu_ras_block_late_init_default(struct amdgpu_device *adev,
> ^
> static
>
> Signed-off-by: Ma=C3=ADra Canal <maira.canal@usp.br>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_ras.c
> index e5874df3c9ca..dff5240efcc7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -2456,7 +2456,7 @@ int amdgpu_ras_block_late_init(struct amdgpu_device=
 *adev,
>         return r;
>  }
>
> -int amdgpu_ras_block_late_init_default(struct amdgpu_device *adev,
> +static int amdgpu_ras_block_late_init_default(struct amdgpu_device *adev=
,
>                          struct ras_common_if *ras_block)
>  {
>         return amdgpu_ras_block_late_init(adev, ras_block);
> --
> 2.35.1
>
