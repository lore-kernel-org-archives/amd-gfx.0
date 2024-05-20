Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 637C9C25B78
	for <amd-gfx@archiver.kernel.org>; Mon, 20 May 2024 11:03:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A4A2410E58E;
	Mon, 20 May 2024 11:03:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="BLPZZPm9";
	dkim-atps=neutral
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com
 [209.85.208.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 410FC10E5F7
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 May 2024 11:03:53 +0000 (UTC)
Received: by mail-lj1-f181.google.com with SMTP id
 38308e7fff4ca-2e2b468ea12so35699001fa.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 May 2024 04:03:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716203031; x=1716807831; darn=lists.freedesktop.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=TrnpWE7dPEJmYiT/RDr1bXYldnFvFFfi6hz3R8sA0hI=;
 b=BLPZZPm9yIT+NGfhGAUJROhZ8Ab0xBYpTk86teyJMBnvZXXBgOWXfViI/rMkmds2WG
 oS7rp9YAIc20QyZx+n+GR74lLgKpZDKb7/yJXZdDZrtFStQPi8vp+h2Eaha5eVSCLC52
 yI9iQX7Hc1db9Ykq5oJ9RTwEXoVG/h4yMVyGjD2Z1RRGTwBan9D42qY5fkt5k455RWt4
 oZyxfwu5d+dONhnJ2AGYeRawLwoGNAwDyjJsGXLMcxkbDCprC8NMzetty2Ox/kfEmkTq
 uOPnekfHdyd50zilwNTELmSw1HaD4scrmfmYOPzBUaE8vVA67CpCcPXRH1rD62T4MpTj
 dw/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716203031; x=1716807831;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TrnpWE7dPEJmYiT/RDr1bXYldnFvFFfi6hz3R8sA0hI=;
 b=PGegNY/wgJeiDw9Vt7dvt9c8W1AevY7N7wCFitY85w+CPpXNEDg/gXgEatYtT3lRGz
 CrPLoEdv8HFZKaFn0kK2NjYaX6tR9ggDd4M63u6qMcRCxVATfWdq4KGBBqk+FDQ9cvD0
 fUhucA8Hwsjby1439rzosNTZn+pz3N8tDtE7tL9M9/utA+cd2rWFCFIcMub48FiWgQzN
 jLLX9KOoFtvAy/0UNARvmuVnqTyOPdSAv03yWm0PVhU7zPDA176yfqnr9lAVOvWkpMvw
 lpvwSwM9l0pA+j/JovVTX9h04bFM4NtZ1kuQxpA7YNpW2OCJcInRrV4PNWiNlO8nVQ1/
 bEdw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWhYquHhb52HJvCV2zPJEIadND5H/iQt72LcQ1ZWgsIMqRdYEU4tMOKME34Z0Ogl+HrcijLCBlm/0Ys6Bo5JC3CrHMtlZ6Uf+qK8zdnag==
X-Gm-Message-State: AOJu0YzMN2TYrBJZEn6E8okxTzBSzYnmocbeYQuzctd3/VAqxttEwWi5
 xTvbJRtckKHnQSQP4kkXivTs/VHeph709lsbc/FiA3reZM9T77QXXe2azvP/ChA=
X-Google-Smtp-Source: AGHT+IHrPX1EE5HJbqIWKfZcM1kS0oKboB5I8XtzpfJrKSrhX0xiWZVBV8AXw8xry+E6Y03ekdH7bw==
X-Received: by 2002:a2e:9d8a:0:b0:2d8:611c:228a with SMTP id
 38308e7fff4ca-2e71714cb85mr17078161fa.8.1716203031220; 
 Mon, 20 May 2024 04:03:51 -0700 (PDT)
Received: from eriador.lumag.spb.ru
 (dzdbxzyyyyyyyyyyyykxt-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::227])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-2e4d0ce30e1sm34354131fa.38.2024.05.20.04.03.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 May 2024 04:03:50 -0700 (PDT)
Date: Mon, 20 May 2024 14:03:49 +0300
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
Subject: Re: [PATCH v2 5/6] drm/ci: skip driver specific tests
Message-ID: <mxolwwmi5rjaevuwi7qy6rm5n62rhnpbi7hz4n7xbshmi2hoqq@5uzamkipouek>
References: <20240517092502.647420-1-vignesh.raman@collabora.com>
 <20240517092502.647420-6-vignesh.raman@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240517092502.647420-6-vignesh.raman@collabora.com>
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

On Fri, May 17, 2024 at 02:55:01PM +0530, Vignesh Raman wrote:
> Skip driver specific tests and skip kms tests for
> panfrost driver since it is not a kms driver.
> 
> Signed-off-by: Vignesh Raman <vignesh.raman@collabora.com>
> ---

I didn't perform a through check, but generally looks good.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry
