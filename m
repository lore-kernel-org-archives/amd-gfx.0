Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 981E8C25B7E
	for <amd-gfx@archiver.kernel.org>; Wed, 29 May 2024 07:44:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D87DC10E5FE;
	Wed, 29 May 2024 07:44:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="LNIV2oXO";
	dkim-atps=neutral
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com
 [209.85.167.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D3CB210E51C
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 May 2024 07:43:57 +0000 (UTC)
Received: by mail-lf1-f45.google.com with SMTP id
 2adb3069b0e04-52b119986f2so273661e87.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 May 2024 00:43:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716968636; x=1717573436; darn=lists.freedesktop.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Ka2Maam5Ei5EuRcb2P0MO3/hFv2w3w7reQQ7Fg93ZTo=;
 b=LNIV2oXOqcICHyLl2FxKuPWLLiUd3eFbjVQTBvyEaxl/J2WJqC/22VCC4yGu8uEale
 a9ZhLrA7A0yp+cDwB9jGqaOpCG+8tSf8GbiOuTiSghHqMQr4aJrRXHPN//QDUZMTY0/s
 9fq8j4Pjgy7b8WF/c9QH7jvQ6ppf1HwmoOU43v7lyACP1E6aG8RKG0/MuG4KbPNOlKaj
 dmz9WpZYmhx0gSn5ZvnkDLHGiwNuQ4/zqUTTVb62xFfdk9ySsJiLl+bzgLmfOqiGZ/d7
 wMW1ajhZRY6GQWTRmJOrHM/7jxpi2kGlcHW8JLgxrBBVKoOcDwjfATXbs16yzabPLmqg
 zc2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716968636; x=1717573436;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ka2Maam5Ei5EuRcb2P0MO3/hFv2w3w7reQQ7Fg93ZTo=;
 b=uGUkwYzdyCWSKHcKOP1OirV9BWk3RMgsLHRJrsVsQcZmx1XpqGcc//oLdzr8kKybz5
 o+6i9rnVi7BTBu6Wv3xNaYeBGUI6ScrqnC+dUR/ZtSpEIkpsfouFh23e1EmOqV8ha3Wy
 RtEMD+vqLnAjYshuM53d4ii4UqyVVMZdBC8qGKljwfmYvDrpmzjj2wD2NlwzYoOOporQ
 BanbZTc0lp9LTAxpFXgMbfjVl9Ojmrig75R1FTqj4lGxmYyoBdCOj8whiT3jyP93flBu
 QYa1jorgOefHi3V5ZvXUqeN7syWRd7WpF5zJBsbIC0xmYqdQFxl0Flif0e3Y5eRNy/fH
 6vvg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWJVr5+hbjyg34uoK3j5j/COgir+Glx3T50ERmayvGmZBf+fKst9/0noKSsKonbHn6PPiHJgcRrLiJ05WW0lEP8iyNWe2O9qhBhWutDwA==
X-Gm-Message-State: AOJu0Ywid/whn9yERIgLnURCrauyqtdWKN/hmn/JLxOwdCFmJkED3MS+
 eRK1PJHGVSMYiQDFOUJvYqBM43vwhdWiqnxYCF4rm0db5wrryyaBzCj1yLjrTKE=
X-Google-Smtp-Source: AGHT+IEpKoJxeYMMRmRHKz19pKO8ijGaGc5T6KYCnRuUNFgdev3K9Yfz0P6oPUoZ1/TYqG8Ww0hnig==
X-Received: by 2002:a05:6512:3241:b0:51c:df1f:2edc with SMTP id
 2adb3069b0e04-529644ebe8cmr7988541e87.2.1716968635950; 
 Wed, 29 May 2024 00:43:55 -0700 (PDT)
Received: from eriador.lumag.spb.ru
 (dzdbxzyyyyyyyyyyyykxt-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::227])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-529a50b1d85sm978336e87.113.2024.05.29.00.43.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 May 2024 00:43:55 -0700 (PDT)
Date: Wed, 29 May 2024 10:43:54 +0300
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
Subject: Re: [PATCH v3 2/6] drm/ci: add farm variable
Message-ID: <xhdcswueynlctjznqnxo663v2k6q2lrk55jjdodrkd7ojijaiw@lg3e2e5qcnny>
References: <20240529024049.356327-1-vignesh.raman@collabora.com>
 <20240529024049.356327-3-vignesh.raman@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240529024049.356327-3-vignesh.raman@collabora.com>
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

On Wed, May 29, 2024 at 08:10:45AM +0530, Vignesh Raman wrote:
> Mesa uses structured logs for logging and debug purpose,
> https://mesa.pages.freedesktop.org/-/mesa/-/jobs/59165650/artifacts/results/job_detail.json
> 
> Since drm-ci uses the mesa scripts, add the farm variable
> and update the device type for missing jobs.
> 
> Signed-off-by: Vignesh Raman <vignesh.raman@collabora.com>
> ---
> 
> v3:
>   - New commit to add farm variable and update device type variable.
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


-- 
With best wishes
Dmitry
