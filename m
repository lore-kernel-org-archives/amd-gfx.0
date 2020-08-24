Return-Path: <SRS0=//M4=CC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 327C4C433E1
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Aug 2020 18:23:57 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08AF92075B
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Aug 2020 18:23:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QiSYkoWo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08AF92075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 617C96E42F;
	Mon, 24 Aug 2020 18:23:56 +0000 (UTC)
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com
 [IPv6:2a00:1450:4864:20::343])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 45C716E3FC;
 Mon, 24 Aug 2020 18:23:55 +0000 (UTC)
Received: by mail-wm1-x343.google.com with SMTP id y8so83751wma.0;
 Mon, 24 Aug 2020 11:23:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=RWt4HdLDDE3cWxWp14ftYZ+Ff9vvdCYJgVm+2n4jMk0=;
 b=QiSYkoWo6+sxPSh3nCgtbEpKl3GLoyehwM+22cwGTFHcJya9CyycE6Itv87bRJPk3j
 v9I6aZYCB+IE+ZdGk3iP25ymbh7BfnT9lSbW7dBiGTpn/eHa16Y8AkyEB2wCHyjSbE+g
 UCOkmnQgllkEhED10e+YnAcstwHyO04ClrqHock8KudzOiU/WzMu5gwGEvoaoSEAUxPG
 uHAFuGyrhhH21eNpmrGqyLjUttypNN1xgAn/Teh6IFQlv6Munft6kJ8gzGj7T+Nn0Adu
 go+n7QSoZHmpaz3vBnj6Ue01+GiesPwGZ3zZzKDH6nJUIFTEUBcklmHyTrH/0xsttsjB
 IRdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=RWt4HdLDDE3cWxWp14ftYZ+Ff9vvdCYJgVm+2n4jMk0=;
 b=rou9M9fxOu9o7kvh0n9S6JS7S3CV3wt/etnoAI7g8SXM4zIIR6x/EBmNkvh7ipEYFy
 7nAPRhCrznQR0ygHwzeqz8p5jnb9/gy7N2V8cv6wnuD0m7hUXENrbmz2Rn/Yl/sqAuJg
 Mj/X2yVfjhc71J265taEi28O0cG/HSnDQnpYRjB0PiNp7kQvl6nti6am5Jh7/PuAbMSb
 4mJDdoOJbvSp0VchjmzapHmCBTGgBsYYlfQG8jhb8VHCkOAeGMEZWfBMyi8tnfw0LYt2
 TpnctfiFYLgpUj4o/2Sd7Acc+kmtrLOuW81EA8ohrY13XwDDEg2U1yNldLmXbs66I+x8
 mvug==
X-Gm-Message-State: AOAM532dVzW8VBVXefpj8vzfPWGDHeEMe9c/avffWUY2lBbdyQjKgDMk
 UUbZnLP4Fypm5efZ+wzhqEK8FoGIASpO23qYNvo=
X-Google-Smtp-Source: ABdhPJzV3/zbrwXpoEPGTg1sHHiKvs4tr77eqoVjZcOGpQIpHr6awTnlu0abG4mFeyvWAKC8PhSVLwnMYAmPxPuzEv0=
X-Received: by 2002:a7b:c941:: with SMTP id i1mr487708wml.73.1598293433887;
 Mon, 24 Aug 2020 11:23:53 -0700 (PDT)
MIME-Version: 1.0
References: <20200824163504.605538-1-sashal@kernel.org>
 <20200824163504.605538-52-sashal@kernel.org>
In-Reply-To: <20200824163504.605538-52-sashal@kernel.org>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 24 Aug 2020 14:23:42 -0400
Message-ID: <CADnq5_Osp+ePNgm1c5VxRzuymZzkTCF1Zps+Y0JjO8AJ66r+TQ@mail.gmail.com>
Subject: Re: [PATCH AUTOSEL 5.8 52/63] drm/amdgpu: disable gfxoff for
 navy_flounder
To: Sasha Levin <sashal@kernel.org>
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
Cc: Tao Zhou <tao.zhou1@amd.com>, LKML <linux-kernel@vger.kernel.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
 Jiansong Chen <Jiansong.Chen@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, "for 3.8" <stable@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Aug 24, 2020 at 12:36 PM Sasha Levin <sashal@kernel.org> wrote:
>
> From: Jiansong Chen <Jiansong.Chen@amd.com>
>
> [ Upstream commit 9c9b17a7d19a8e21db2e378784fff1128b46c9d3 ]
>
> gfxoff is temporarily disabled for navy_flounder,
> since at present the feature has broken some basic
> amdgpu test.
>
> Signed-off-by: Jiansong Chen <Jiansong.Chen@amd.com>
> Reviewed-by: Tao Zhou <tao.zhou1@amd.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Sasha Levin <sashal@kernel.org>

Support for this chip does not exist in 5.8 or any other older trees.
Please drop this.

Alex


> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> index fac77a86c04b2..2c870ff7f8a45 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> @@ -3427,6 +3427,9 @@ static void gfx_v10_0_check_gfxoff_flag(struct amdgpu_device *adev)
>                 if (!gfx_v10_0_navi10_gfxoff_should_enable(adev))
>                         adev->pm.pp_feature &= ~PP_GFXOFF_MASK;
>                 break;
> +       case CHIP_NAVY_FLOUNDER:
> +               adev->pm.pp_feature &= ~PP_GFXOFF_MASK;
> +               break;
>         default:
>                 break;
>         }
> --
> 2.25.1
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
