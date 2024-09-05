Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 319B0CD5BA3
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Sep 2024 10:16:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4E37610E856;
	Thu,  5 Sep 2024 10:16:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=fooishbar.org header.i=@fooishbar.org header.b="htBiISGE";
	dkim-atps=neutral
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com
 [209.85.219.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5A53910E850
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Sep 2024 10:16:36 +0000 (UTC)
Received: by mail-yb1-f178.google.com with SMTP id
 3f1490d57ef6-e1a819488e3so641618276.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 05 Sep 2024 03:16:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fooishbar.org; s=google; t=1725531395; x=1726136195;
 darn=lists.freedesktop.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=xd6tRDcBI6nT0vpG0+47dCoixHmT48y9ZIC4bv5qVFY=;
 b=htBiISGElkQQwgK1SQoF/+qPjmAgVpRBZ3gLBuVkIckzW1XdVkeProqo/m/11NDoTh
 F81k9ZqYsq0eqFa/340NBGFp3NjNLSf48QpLhaVnhreL8XPKeSbaYmH1qMYiWUZl60jN
 Jq6j/VBDjqTP+vjCmHS5bhz3wo5D/eS17K8r7B8KPry/q2itnybvO4pJEey37nzX26nA
 ePcHnBli29Mo77rbsyZwn8xmDTHBZ0f/lYZ0l4GqQERfEbxaHDnAmz+cvXL47zAQpr/o
 K2YlHvC26r5kx8ixmf43xoHCq7r2AScRtgeoA/PelThrkRQrs1nby7LHmREoR1iNFaMu
 DX6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725531395; x=1726136195;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xd6tRDcBI6nT0vpG0+47dCoixHmT48y9ZIC4bv5qVFY=;
 b=chjOR1iVVsUYSQX0NP7XNg0cAxhHSlrrdqYfe3w2MCxQgV63FuLkROmPfV5QHqjKqc
 p03MslIn1fKoJssSNH0sAQLda5KU0X+VnvzOU273hiqtgWBjIZOrHSR13KsA105KWIkf
 7G/6GZ/zEaUlqtQupMmsW3YH5SuwNOOwD7Qd5s7XexMNl+oCPQyXEQNoM6Mle0hPk+nm
 0zn/XvL/4bbSmxq8IYRbiG7YDk1mIHXLo6Wox5iG7m9xdYptK6GO96eZUiQWCXJv1Vq9
 cpnhUzEGrMXBZsYv9PB0DiKnNrif8nffYr11tANUrc1YPo6RmYjuv3qN25kXmzVzzQUE
 udew==
X-Forwarded-Encrypted: i=1;
 AJvYcCU1zs0HrBK5nkfqlzpzlgqK3wFB+R27vmpOJVojAd8RnjQF7Uc6hzSmhnSQLfWhs24FUf3fLVxw@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwEJTRxf9CIgwB7pqrS2GuLk0rEiK9t3d9JfQnbryHxKwXs2f9X
 gPMky4pMR4G3EvUAyWnk7cYA4dJPaD4mEjGFCKkriOgX8jzbMfkQYBtjCVQh2n7d8fghwxTmYh3
 kKLchDE9+vuLKrYhE7MrxWhEjD8gqM8BErVueRg==
X-Google-Smtp-Source: AGHT+IHOAa2WnFWM0m3QmtHGwmSzixacJsCBpWRBvguStq1YD37bVLj0/P6F5Iapvjw7xs8jP/X43ydPbq380G1rQQ4=
X-Received: by 2002:a05:6902:1547:b0:e1d:1b8a:ac4 with SMTP id
 3f1490d57ef6-e1d1b8a0cbemr3960625276.11.1725531395247; Thu, 05 Sep 2024
 03:16:35 -0700 (PDT)
MIME-Version: 1.0
References: <20240905093935.2780632-1-vignesh.raman@collabora.com>
In-Reply-To: <20240905093935.2780632-1-vignesh.raman@collabora.com>
From: Daniel Stone <daniel@fooishbar.org>
Date: Thu, 5 Sep 2024 11:16:23 +0100
Message-ID: <CAPj87rPCctE=iJKfQXR-PJdUHR+5f-t2bRA5Daq2fzUTNekzcg@mail.gmail.com>
Subject: Re: [PATCH v1] drm/ci: uprev IGT and deqp-runner
To: Vignesh Raman <vignesh.raman@collabora.com>
Cc: dri-devel@lists.freedesktop.org, daniels@collabora.com, 
 helen.koike@collabora.com, airlied@gmail.com, daniel@ffwll.ch, 
 robdclark@gmail.com, guilherme.gallo@collabora.com, 
 sergi.blanch.torne@collabora.com, deborah.brouwer@collabora.com, 
 linux-mediatek@lists.infradead.org, linux-amlogic@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, amd-gfx@lists.freedesktop.org, 
 linux-arm-msm@vger.kernel.org, intel-gfx@lists.freedesktop.org, 
 virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi Vignesh,

On Thu, 5 Sept 2024 at 10:41, Vignesh Raman <vignesh.raman@collabora.com> wrote:
> Uprev IGT to the latest version and deqp-runner
> to v0.20.0. Also update expectation files.

Thanks! This is:
Reviewed-by: Daniel Stone <daniels@collabora.com>
