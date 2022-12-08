Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29B9FC3A5A7
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Dec 2022 04:20:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7B48310E453;
	Thu,  8 Dec 2022 04:20:47 +0000 (UTC)
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com
 [IPv6:2607:f8b0:4864:20::232])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7672710E453
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Dec 2022 04:20:43 +0000 (UTC)
Received: by mail-oi1-x232.google.com with SMTP id c129so265636oia.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 07 Dec 2022 20:20:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=0MrySoT78eAXinHx32v2uXWfM8EsdztbXrnpEJqgHG0=;
 b=Az8Sswl5Mt6Spcw4vLcq6h1bI4myiYIEFlKLVhbQAZBfC1HPzu3yM3IswZfeBoPcJ6
 3rfVQ6evk2jiOCCnfq3nmi4wWlkue01K58iZ19Y5gctH0xMEAaurBcu3zNsaIhqf1IHb
 Dis5z9TGCMzyFUoDD9CLLuY7AO1wzcpHj8ctAMXuOnqz8dVKp+hK88t2E+FLQDlDEOzd
 NruJyCh14eykWHVRUVjigHIkbExEbyG/eOuHLyoQpJRhbfsrQyjXc/jgMU3sdIqeSWXw
 XlqUmWuYl9dW2jP+K96i68ENFBNd9mO+RmPNVcbRcC21GmuprlyMugeWQGE77II6lfUz
 /20g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0MrySoT78eAXinHx32v2uXWfM8EsdztbXrnpEJqgHG0=;
 b=yLsGdLUlq1DSVLeLNQYNaR4SqLBhfnNVTd86OZZV9EEn1XoCiFmhy5kEpQeTbPlPak
 BQKzT+h5INelXZgxHmg7qzZAMIwDhlf+iBvb30DZXJS7gcuMnbcshZ5FiIvbam3VxXdT
 MdMR9P9TAM+TSJ3RDNgUJ8aNVTuB22l2sBPwEw190rqp4fm8NgtU5LXJODAyysnQaihl
 hx6SMqMON6RqCE53vyt1jFX7/9m+04aDcJY3MNiVr5uTEHXFzaf8QxJn6p/fnL7KMHRP
 HnabHD8yA+FqXTgaJg+Zv0LlUfcDMyT6exkt+BzROD3P+jWnjlYF48hGasZ92oV2/Z4J
 hP2A==
X-Gm-Message-State: ANoB5pnbaWc5GnR4yrnh0EPFC50ki2HrDbkwwfTId8FWZYkJ+XfaYDd2
 8CTCDmE2YVddA03rAuxXp616r9IJ23Pfu05qB64=
X-Google-Smtp-Source: AA0mqf52lAA+3+j+4L6ihKxfGbagVMOBTceplGvV4B9JiAmJrXHMp1yqLvrgdj5khqlgNLXxN8hNfUEjl9W+kLbjWo8=
X-Received: by 2002:a05:6808:bc2:b0:35b:d93f:cbc4 with SMTP id
 o2-20020a0568080bc200b0035bd93fcbc4mr16535454oik.96.1670473242601; Wed, 07
 Dec 2022 20:20:42 -0800 (PST)
MIME-Version: 1.0
References: <20221208041405.3992585-1-yifan1.zhang@amd.com>
In-Reply-To: <20221208041405.3992585-1-yifan1.zhang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 7 Dec 2022 23:20:31 -0500
Message-ID: <CADnq5_Om_WZPvXOZNfQHJB_KafgXquJhXu2kmJGHWUy8yTNtuw@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Add DCN314 display SG Support
To: Yifan Zhang <yifan1.zhang@amd.com>
Content-Type: text/plain; charset="UTF-8"
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
Cc: Alexander.Deucher@amd.com, Harry.Wentland@amd.com, Roman.Li@amd.com,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Dec 7, 2022 at 11:14 PM Yifan Zhang <yifan1.zhang@amd.com> wrote:
>
> Add display SG support for DCN 3.1.4.
>
> Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 0f391a147354..6f1e5f787af6 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -1504,6 +1504,7 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
>                 case IP_VERSION(3, 0, 1):
>                 case IP_VERSION(3, 1, 2):
>                 case IP_VERSION(3, 1, 3):
> +               case IP_VERSION(3, 1, 4):
>                 case IP_VERSION(3, 1, 5):
>                 case IP_VERSION(3, 1, 6):
>                         init_data.flags.gpu_vm_support = true;
> --
> 2.37.3
>
