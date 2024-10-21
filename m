Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08DA4D15D82
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Oct 2024 12:18:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2C73F10E4BF;
	Mon, 21 Oct 2024 12:17:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ft04Dkyz";
	dkim-atps=neutral
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com
 [209.85.167.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 07DF610E4BA
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Oct 2024 12:17:56 +0000 (UTC)
Received: by mail-lf1-f51.google.com with SMTP id
 2adb3069b0e04-539fbe22ac0so4828502e87.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Oct 2024 05:17:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729513074; x=1730117874; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=f9yzL3cq6refE/8jHrgfUykQ00f5QT9/9b/0xTf+sbg=;
 b=ft04Dkyz7OsCWy/rwwMiMdPMTUHhexmOW4DDhe3q3Mg1zwizxbJ5j1cfhDLxU4HiBi
 29PsCgqU2K0tfuibgfWZw+N8DirJqB4eUNbVCp1vNEangBJGtKjAln1PTpEM90Lwqaez
 WQFCISxDrID5T7fgijUMD0n1Fqhp5Mk/s7xOgSE1RW7s3yBRaM9r+4sNHrtKbOTXDd1U
 qcuqobYSqjy586hcYSEKh24w7V0W+H404+2heh7aHDCRjFy/3Do3toGxMtWn6XoZ1ZRE
 B9tTiHIQYA5f9BS2WgpnuXKmjO5zLCpv+dGWzIKtfITnyjYz8lnxnW5AFTTw6NBARVbC
 Aq+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729513074; x=1730117874;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=f9yzL3cq6refE/8jHrgfUykQ00f5QT9/9b/0xTf+sbg=;
 b=fTqQ9MmZA7+8v+ZYPs0p02q19IqpVEWALmAWgHHQyQ1vCN0rzjCoAuTbcfDsRGEOaf
 tgwKQoG38uFRDX7JsVehWQ8gusNLo55wDjyRFzFkAcuRhwjn+5SK+SNRZf2+7PzAfeuZ
 9uoBasssTmWg3KM227oH72YZhOmc0ubBNaxsTGNavHrbUZahkt6kJwCYcpp1lJuqm3er
 9iS2gsWbGNf2AiL9yy4FJBD7GKSSmxpZAxWQTfDgagEQ68U96R/ln455ySSqv1DrdScg
 S3v17M8890l5T5v16uq+Zon6/OxEJJMv4f/+/I+JkSJR1C3Dirr3UPIdQt2x+sb/pVDg
 kSQA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWIaVWDbSXOnEPs5i0zU0Swkv6eAKNc6Fi0kiHgtKZYo4sRdEjT6PsG57x238KfMDr2G1rvALA8@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyLSrurctyEf85XxRdsDhkoR0DiI4wscCSHgyMXbFkA2Yft5DaH
 KdROBaSBpNtLC76Zx7UxO2x2lRxQBCQZ1Mhx4XyU7v9nbVdZZGtC6pej4tW74Sg=
X-Google-Smtp-Source: AGHT+IEsjekVnrcVqImxMZbmo0i6wP10FDI9NRJIYrGYKmreelLfg+89QH4satNGiJJ0wxtZuHKbxw==
X-Received: by 2002:a05:6512:2393:b0:539:f65b:401 with SMTP id
 2adb3069b0e04-53a154a2413mr4923387e87.57.1729513073979; 
 Mon, 21 Oct 2024 05:17:53 -0700 (PDT)
Received: from umbar.unikie.fi ([192.130.178.90])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-53a22431454sm464210e87.212.2024.10.21.05.17.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Oct 2024 05:17:53 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: javierm@redhat.com, airlied@gmail.com, simona@ffwll.ch,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 Thomas Zimmermann <tzimmermann@suse.de>
Cc: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org
Subject: Re: (subset) [PATCH 00/28] drm: Remove DRM aperture helpers
Date: Mon, 21 Oct 2024 15:17:43 +0300
Message-Id: <172950935856.2053501.4410265648664199730.b4-ty@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20240930130921.689876-1-tzimmermann@suse.de>
References: <20240930130921.689876-1-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
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


On Mon, 30 Sep 2024 15:02:58 +0200, Thomas Zimmermann wrote:
> DRM's aperture helpers are merely wrappers around the respective
> helpers in drivers/video/. The DRM interface existed first, but was
> later generalized for use with fbdev and a few other graphics-related
> places in the kernel. It is time to remove the DRM wrappers and call
> the video helpers directly.
> 
> No functional changes intended. This series should replace one interface
> with another. Individual patches could go into the various trees and the
> DRM wrappers can be removed when all driver changes have been merged.
> 
> [...]

Applied, thanks!

[11/28] drm/msm: Use video aperture helpers
        https://gitlab.freedesktop.org/lumag/msm/-/commit/42170670ee76

Best regards,
-- 
Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
