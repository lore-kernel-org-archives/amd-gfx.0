Return-Path: <SRS0=otPk=OY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 526F7C433F5
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Oct 2021 08:20:51 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0FB0B61248
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Oct 2021 08:20:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0FB0B61248
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9394E6E955;
	Mon,  4 Oct 2021 08:20:50 +0000 (UTC)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 26FDE6E955
 for <amd-gfx@lists.freedesktop.org>; Mon,  4 Oct 2021 08:20:49 +0000 (UTC)
Received: by mail-wm1-x335.google.com with SMTP id p21so3061807wmq.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 04 Oct 2021 01:20:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-transfer-encoding:content-language;
 bh=lUxMEDDQUa+0+zKC/fYMNWxt64QtX7zCm011xbYcy78=;
 b=ddRdfa83MFDqpfkugwPsuhlQFPwjZuXMgujaozyz+G49VgsTzw/ATCYaUihB0E6+q1
 FKq7JzGNQ1V6koAmlelXv8tN/AjnMz4Zq+P0XXdt4jbAFqa40eN/RPdes6q5S2ubr7tq
 XqegI2Wxgkji8onE653+G4UJqENxa9XNDBx0rDlHz5AmDkkgN8wQpcYcMCa8JfHglvJM
 a8pWsyYTimgFUCfxearHU1R+mgow0jJMwS+sWHrwoZGSva5qmneQCaWibjRfWgyVz0Fu
 vvbnMeodjpw2u6OI9dbsTOBtFX4eeLVh4HniBK8jAAvnVpHV0lnLFHGxuEjKESsv9XaD
 gcVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=lUxMEDDQUa+0+zKC/fYMNWxt64QtX7zCm011xbYcy78=;
 b=q9KV8TyLhns3Tmz4/0YQrUVxwCrSJoqswtHuTdP/Wgy3x36KeONQw+fNwNc6GWVYS5
 tAQt4XJ13XWKOOE5fmCUr8KHV/itMl53mBqrvaqx4KAHrpxxKXAf5LehhmGiPFvqCT62
 8gDCShM3HZ1Aje0ufQA5SKcWLy66KWxv1ggDiAWXP6j/FuHrVHG82q5VR5CGvQNCeWVU
 20H9qLxIi2xJr+6by7qLHbZG4A3uQqKEzz1dPx5Icgqd+w95HDkCjXpiJ2ihzeXxJ6fX
 zNw1yDOC9RsF4VSxrMTaKTgpJiSsGTh1aG1IRWJ0GM8FQ3sgEIOGPfZ6iWbEp/FR1DBc
 E8xA==
X-Gm-Message-State: AOAM532+887j+8GcjsCi+TCF15SC4SlduOCV6jwYDXpdRh5KHjsw4qxm
 LyMCAvWRmDtS/RnXWvUVtSiHJ0KHfOQ=
X-Google-Smtp-Source: ABdhPJwTr2CwQCqagJhlUhdzDHvDQ3A+sv4N4BtZJ9fqBafp9Vc7jGieFuh4OdwsZOtVe9a+VxoQkA==
X-Received: by 2002:a05:600c:2f9a:: with SMTP id
 t26mr16685664wmn.143.1633335647705; 
 Mon, 04 Oct 2021 01:20:47 -0700 (PDT)
Received: from [192.168.178.21] (p5b0ea1b5.dip0.t-ipconnect.de.
 [91.14.161.181])
 by smtp.gmail.com with ESMTPSA id f8sm13409398wrx.15.2021.10.04.01.20.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 Oct 2021 01:20:47 -0700 (PDT)
Subject: Re: [PATCH] drm/amdgpu/display: fix dependencies for DRM_AMD_DC_SI
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20211001194822.1818798-1-alexander.deucher@amd.com>
 <20211001194822.1818798-3-alexander.deucher@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <d7d18426-ad08-e2b0-cf81-7210d68208cb@gmail.com>
Date: Mon, 4 Oct 2021 10:20:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211001194822.1818798-3-alexander.deucher@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
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

Am 01.10.21 um 21:48 schrieb Alex Deucher:
> Depends on DRM_AMDGPU_SI and DRM_AMD_DC
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/amd/display/Kconfig | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/display/Kconfig b/drivers/gpu/drm/amd/display/Kconfig
> index 7dffc04a557e..127667e549c1 100644
> --- a/drivers/gpu/drm/amd/display/Kconfig
> +++ b/drivers/gpu/drm/amd/display/Kconfig
> @@ -25,6 +25,8 @@ config DRM_AMD_DC_HDCP
>   
>   config DRM_AMD_DC_SI
>   	bool "AMD DC support for Southern Islands ASICs"
> +	depends on DRM_AMDGPU_SI
> +	depends on DRM_AMD_DC
>   	default n
>   	help
>   	  Choose this option to enable new AMD DC support for SI asics

