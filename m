Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8054CA1013
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Sep 2025 19:57:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4221410E1B0;
	Thu, 18 Sep 2025 19:57:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="B37fp9d0";
	dkim-atps=neutral
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com
 [209.85.214.177])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3025610E1B0
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Sep 2025 19:57:45 +0000 (UTC)
Received: by mail-pl1-f177.google.com with SMTP id
 d9443c01a7336-2680ee37b21so2303525ad.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Sep 2025 12:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1758225464; x=1758830264; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GXVT4+3FYobUeuHXP2ISFEEF/s53PhZFruppoYb827E=;
 b=B37fp9d0EQk2CB2R0JKr6imxQ5f6On4V6wewADCiAgi43IX/aAbAQbtHrhJ6KX6fF1
 y78LHTRiQNsqxIN0U06kU/zisQCCOCZdfQPzNEs2pQk+WhgfbAEjhtKuYIVYF7+7H+XW
 FWxYpnfpyzmkNuyTaYqlMpgcEus77RGVqk4VlX+kKmPLJI+LGvFCOjQZ8GWgO652wqg4
 sJzwcYWJ8jH4M483t6qOp4Ja+vUAeCO3gv8MQcsLbvHyA0wAqiPv1nYTLCn6aj+nxOYo
 KTagh5eEEW4FXHlVcwuOZ+xddQNn0K14+MlCaAtzQI6azgu01VI3H0OS0cK8yVKtRntY
 +F1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758225464; x=1758830264;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GXVT4+3FYobUeuHXP2ISFEEF/s53PhZFruppoYb827E=;
 b=k7+nFq/0OgwEPvgIR0Jyt4FQ/k8F0PqYpU0aqL6p2xLBIEysnB5VybjzNqni74TeMz
 PmsCbshURvzifgnnFaJZWTYppgHT3JpXkw+pAK1OXivBO+O04QVsJsVEklThZa/cGZ8j
 +lOKb0FBEa2TGj2ZCMpSwEDuzqBlC47ru6vFyNlgni1rHGDqSVgusnZJIbAXqhBI9689
 DawIAelRy8LYAniUAyRPiiiE+kLEVfUGVUeHlNci4n2UrOh0xEZMYF2rMIaph0pmDjx0
 /cYh7qgXCEazIlF6kFxynAF1Du/lqPE/36grurA0RW1w1sH6CfTlMC9qNX7q1P0cnsJ7
 z+FA==
X-Gm-Message-State: AOJu0YzgkOJJDqaIP+U41yF0PVTfENF/xO1+tkcslK/p2neKNsTXkuIV
 Fpy6hLNEhZOLrAiObStzF8MNGpZdPjgfxpJCdP49t6Od47lCYyiZSDmaA2uXY6xQ5h0BAKH30ya
 F0imO3+QxnHQKc+RRJetXCA4MivtmcU8=
X-Gm-Gg: ASbGncv0+L8Mq6p6aYmDrk/Ge1+OWp+fyw/dszCLASxE/Ueh2cLqD/ntDw+vxLZ7Bop
 2h4B1kyAmKPPDyX8BmnDCWuviBEB0uhZW1OcmcIs3nRgOurxARuIYLSUHM9uxO7QvD+X78blspJ
 4GorxuxM9cgkk54JS+RHbdTMqPBWCnHC4M6T8d6hMnsOANajxa2M29ybAUPEjhDMmbRdkq3KXmg
 N68GtAdiZZp2zI7M/gbTwKByA==
X-Google-Smtp-Source: AGHT+IFxmiqNJR0DiNdd5rVHuIr1OYSQ3RsPNBJeCCWeOvM/8sEKaX3Pq6I6OLEcY8J2r4sNUpyAwLxTKfKYaWiyS4Q=
X-Received: by 2002:a17:902:ecd2:b0:248:a01f:a549 with SMTP id
 d9443c01a7336-269ba563fffmr5663615ad.11.1758225464597; Thu, 18 Sep 2025
 12:57:44 -0700 (PDT)
MIME-Version: 1.0
References: <20250918013507.2629620-1-YiPeng.Chai@amd.com>
In-Reply-To: <20250918013507.2629620-1-YiPeng.Chai@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 18 Sep 2025 15:57:32 -0400
X-Gm-Features: AS18NWBWJp2iqyZgt_RYzx7Abg6TWSPmlsfDGGD6DaWSVUFwAVAYpWXmx8QxzuQ
Message-ID: <CADnq5_O4210XRs7w=C83JRCsiVXD=sckf4z_RGDHn0gig2MFKQ@mail.gmail.com>
Subject: Re: [PATCH 01/10] drm/amd/ras: Add amdgpu ras manager folder
To: YiPeng Chai <YiPeng.Chai@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Hawking.Zhang@amd.com, Tao.Zhou1@amd.com, 
 Candice.Li@amd.com, Stanley.Yang@amd.com
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

On Wed, Sep 17, 2025 at 9:54=E2=80=AFPM YiPeng Chai <YiPeng.Chai@amd.com> w=
rote:
>
> Add amdgpu ras manager folder.
>
> Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
> Reviewed-by: Tao Zhou <tao.zhou1@amd.com>
> ---
>  drivers/gpu/drm/amd/ras/ras_mgr/Makefile | 0
>  1 file changed, 0 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/gpu/drm/amd/ras/ras_mgr/Makefile
>
> diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/Makefile b/drivers/gpu/drm/a=
md/ras/ras_mgr/Makefile
> new file mode 100644
> index 000000000000..e69de29bb2d1

Why is this just adding an empty file?  If some content exists for
this file later in the series, just merge this patch with that one.


Alex

> --
> 2.34.1
>
