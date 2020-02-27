Return-Path: <SRS0=YjM5=4P=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 187D6C3567B
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Feb 2020 14:39:51 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DFAEB24656
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Feb 2020 14:39:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OSJ5IdAJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFAEB24656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C91386ECC0;
	Thu, 27 Feb 2020 14:39:49 +0000 (UTC)
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com
 [IPv6:2a00:1450:4864:20::342])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7BA166ECC0
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Feb 2020 14:39:48 +0000 (UTC)
Received: by mail-wm1-x342.google.com with SMTP id f19so1557910wmh.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Feb 2020 06:39:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Kp1jLFdsE9TPEA/oAVXG4AYpJxYtqHTDgORXw3rj9fE=;
 b=OSJ5IdAJ5afmhFxLT6ZGiUTNrFecg1ShfH785icYRwJamNBz3H4OQ2A2ZFAIVpn+6y
 xZLC9ncoDeiKbqEW2vgeOmvkLT9c9qTW9P2CxMLjbxMetHTHNpqJSsnpcpUZ5szhfFxC
 srhlFxGywTe1sGF6pJlmn4jHOhq4QRVKSwE28AmgY5A4FkAgReaeMSjsejywfm+7OYHN
 0J9IAel1/zyKE1Ea+tkMO5id3IuaKYsmWOImct9JKY5ATki+6fsc5GsyMm2NxG2V2E6T
 WvpoUozXakGT528pHyLVmcqRugwZsd64M67wrOHiCbNK8hiqYe1818fJ3xir4bgHtLGw
 IJPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Kp1jLFdsE9TPEA/oAVXG4AYpJxYtqHTDgORXw3rj9fE=;
 b=Ar8IxjkkIn0aO/6JVBYq5xVnig+ipeC+S/juRPt70HjjFg9z5Pl499nWnxWLuMdh0w
 3b4VO3RF4rFSlRzXPIat/B3rCfAz7AmMRh84igDO67ntBlrUpMmSMtR8RDxOdSMO84Sh
 rkTA389E33ErU2r2kGiyC0yEgBOL0nHb3GA2XumY4Y0G1n7Ou1q5h/mxtMi35baGGc3L
 fCcfXMWoapoLPo1LvUUSmZi5nT4hmxpbkBMyQXac/SuZEumxJsZ677dXwbETWEHgUQ1m
 kAs0T8xh4W5exBN6Co7UwWvPbdlBCyMU5MoCJyYoNeEa8YU/scJjOk/FhasvAaz98vTh
 ENig==
X-Gm-Message-State: APjAAAXmZiRHPqiLiOLY9ANdALZMwe9kC0DjWa0RZqvUVNrxyKQqx9K8
 kTRpJTxFIV30796X7/eIpbty3IRYSI009eb6FbpiqQ==
X-Google-Smtp-Source: APXvYqx3kIo5I31oChU20qCf5G7IV+aFMwriEjD1BjuNeURJBDulf1Sal6M+vJnOhOqzMNxCYWzQxJs6puZiaK11rJE=
X-Received: by 2002:a05:600c:2255:: with SMTP id
 a21mr2773920wmm.79.1582814387185; 
 Thu, 27 Feb 2020 06:39:47 -0800 (PST)
MIME-Version: 1.0
References: <20200227141118.3271-1-yttao@amd.com>
In-Reply-To: <20200227141118.3271-1-yttao@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 27 Feb 2020 09:39:35 -0500
Message-ID: <CADnq5_P+v3MwHURRPBxvCfqbQPcG7Cx3Sg8vU-L22ZeJpnRbVg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: miss to remove pp_sclk file
To: Yintian Tao <yttao@amd.com>
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 Christian Koenig <christian.koenig@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Feb 27, 2020 at 9:11 AM Yintian Tao <yttao@amd.com> wrote:
>
> Miss to remove pp_sclk file
>
> Signed-off-by: Yintian Tao <yttao@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
> index 9deff8cc9723..a43fc1c8ffd0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
> @@ -3471,6 +3471,7 @@ void amdgpu_pm_sysfs_fini(struct amdgpu_device *adev)
>         device_remove_file(adev->dev, &dev_attr_pp_cur_state);
>         device_remove_file(adev->dev, &dev_attr_pp_force_state);
>         device_remove_file(adev->dev, &dev_attr_pp_table);
> +       device_remove_file(adev->dev, &dev_attr_pp_sclk);
>
>         device_remove_file(adev->dev, &dev_attr_pp_dpm_sclk);
>         device_remove_file(adev->dev, &dev_attr_pp_dpm_mclk);
> --
> 2.17.1
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
