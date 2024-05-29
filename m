Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B5FAC25B75
	for <amd-gfx@archiver.kernel.org>; Wed, 29 May 2024 07:44:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BD86B112A68;
	Wed, 29 May 2024 07:44:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="F5SPuZwB";
	dkim-atps=neutral
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com
 [209.85.208.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E38C0112A68
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 May 2024 07:44:46 +0000 (UTC)
Received: by mail-lj1-f171.google.com with SMTP id
 38308e7fff4ca-2e716e3030aso15809971fa.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 May 2024 00:44:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716968685; x=1717573485; darn=lists.freedesktop.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=S1XyMvug7w7dhtxZdl8ZlGvff2YgfxxUHgfNNPJEirc=;
 b=F5SPuZwBm5Z/qjk6XGggfgrIjLX1DnQflZdLKexxg/3azcWFUWKRY+24C5XMdjJMlQ
 pp/udkxK2KRIUyd6w/diOxd73HDA6N3MirrcbjLle92rkDxlbZ5wBoWY+Oje5E+E8FNz
 kecOxOCS2aswsCfHm3m6bOd0317go0n04QeNFUMHKdAUrC4vWANlmNoPQWMRW0giIyjw
 8vP2IxvFjJeaCS0g/y0+CXy7VVOCT6/Mlec8l/tqeL2acf481iQZzbmvnTfOJrJ/tj/O
 fwPSw2gMqeiVMv9+/LxlT64qBmN4QIxFOchIeX/GULjNKcFxc7EqnT1oOP5osFbNPXk8
 wA9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716968685; x=1717573485;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=S1XyMvug7w7dhtxZdl8ZlGvff2YgfxxUHgfNNPJEirc=;
 b=KEpdWzN5+h+WEdCzFfmTWGUp7B40Xr4+g0GYImwI75IwhxwjPLc1lFuxArFd+DaahL
 m3VgnBpcI8yTWEMudIv0MRyip0UYi3Mat5YbpYgpyDIZVjG1vRD7GKjRegh2ylXPgYHb
 4OXU26CUIN6T30az0qTbgUW4dGt3vYS3gW6JdZuuUVsTgS7CMK5bfr70UbPrswTLNQOp
 C0lXhl3JUcUG1YEFN/vbkgLAiMR99CgoyIDAZhGvf7pCFP8KjFfyF5D43Nzswp5fnmQ+
 tyIwVVtRyo63LUPQN6RW87SGpYspJnLX7vquoTPa2c6XLPSXLUf8dLun8Jrpakpn7Cyo
 HxQA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV6eiEpAEUuQCP8SaUK0wKCMwGs6LqxCJ9JbzY1/qqvzShfi5twZ+eRp+X4SJHu/NHH7WlgERf0bZJhJJisRkK0qde56jF/rhFZMsdwLA==
X-Gm-Message-State: AOJu0YxrvOQ9uwi9N8IQqng3nL/muoo9zN71Si7NskXYU7Kb4Jv8ihdQ
 ov1dTgbKKUxVW9H4vVmf1GGiTyeBBiio0+68Ew+hDm6QYWKfvg+K01xBtcj9IM8=
X-Google-Smtp-Source: AGHT+IHWA2lvLG0B0kntbUD/V5owakoa3EW0tQI6tq3UwCSFqELYaCxoJok/0cawUBov1/1KRXreEw==
X-Received: by 2002:a2e:b05a:0:b0:2e7:c29:dadc with SMTP id
 38308e7fff4ca-2e95b24e06amr72686241fa.34.1716968684582; 
 Wed, 29 May 2024 00:44:44 -0700 (PDT)
Received: from eriador.lumag.spb.ru
 (dzdbxzyyyyyyyyyyyykxt-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::227])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-2e9816943d2sm6297271fa.61.2024.05.29.00.44.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 May 2024 00:44:44 -0700 (PDT)
Date: Wed, 29 May 2024 10:44:42 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Vignesh Raman <vignesh.raman@collabora.com>
Cc: dri-devel@lists.freedesktop.org, daniels@collabora.com, 
 helen.koike@collabora.com, airlied@gmail.com, daniel@ffwll.ch,
 robdclark@gmail.com, 
 david.heidelberg@collabora.com, guilherme.gallo@collabora.com,
 sergi.blanch.torne@collabora.com, 
 mcanal@igalia.com, linux-mediatek@lists.infradead.org, 
 linux-amlogic@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 amd-gfx@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
 intel-gfx@lists.freedesktop.org, 
 virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/6] drm/ci: generate testlist from build
Message-ID: <nsamdoevg6fhop3otikwsmu4ga6ysyrg2ogxbqhw3sqg2nbqq2@n5xbqid7ltiw>
References: <20240529024049.356327-1-vignesh.raman@collabora.com>
 <20240529024049.356327-4-vignesh.raman@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240529024049.356327-4-vignesh.raman@collabora.com>
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

On Wed, May 29, 2024 at 08:10:46AM +0530, Vignesh Raman wrote:
> Stop vendoring the testlist into the kernel. Instead, use the
> testlist from the IGT build to ensure we do not miss renamed
> or newly added tests.
> 
> Signed-off-by: Vignesh Raman <vignesh.raman@collabora.com>
> ---
> 
> v2:
>   - Fix testlist generation for arm and arm64 builds.
> 
> v3:
>   - Rename generated testlist file to ci-testlist.
> 
> ---
>  drivers/gpu/drm/ci/build-igt.sh  |   35 +
>  drivers/gpu/drm/ci/igt_runner.sh |    9 +-
>  drivers/gpu/drm/ci/testlist.txt  | 2761 ------------------------------
>  3 files changed, 40 insertions(+), 2765 deletions(-)
>  delete mode 100644 drivers/gpu/drm/ci/testlist.txt
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


-- 
With best wishes
Dmitry
