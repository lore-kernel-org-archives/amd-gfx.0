Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E620CA5FD4
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Oct 2026 20:30:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7B91210E461;
	Thu,  1 Oct 2026 20:30:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ICXtw6ON";
	dkim-atps=neutral
Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com
 [74.125.225.140])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2DD6E10E3FF
 for <amd-gfx@lists.freedesktop.org>; Thu,  1 Oct 2026 20:30:45 +0000 (UTC)
Received: by mail-wm2-f12.google.com with SMTP id
 5b1f17b1804b1-49d1fb0cf5eso63308945e9.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 01 Oct 2026 13:30:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790886643; x=1791491443; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=LO3dC9Yk/7Xw/7Y6ZLMi8x1WMU9teTasOYMSgKdw/nw=;
 b=ICXtw6ONXJG7ReJU/6mIaFlgvWS+WJIq31iqYmHy5XQPs43Ax4bDkcpF6+qmL1NXeV
 cNnMQXNQoOB5FJuLr3vtiwUkSOgP/C1uxD4NMJhoGBdc0bkY42+3DOTqwFCRUDcNazSg
 sd1mGLpji/JsQzaomnJ8h8cnEWHDsqvPDweFTCQU3W3YSk+Tejqgm5yQAlf+9edX+B8C
 P4W//6tvAM8azOsAucRFNZJGsmR97rnDgoOj6GLOG7LoyQWPusToH16IXYKU1AWDN/au
 hndqeZZmnMn8i7fxDLHsPkd5nnEdzKNC7XnnrbxIZiO+PmG/mWcVPs+ue4u+5M8vWMNL
 hYPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790886643; x=1791491443;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=LO3dC9Yk/7Xw/7Y6ZLMi8x1WMU9teTasOYMSgKdw/nw=;
 b=LAczn6Kp1C1LzJ1llEttnqwNEG8BA5sWAHoB+AgYk/FOmQsPKoj6GBmORm7sB+EDxJ
 o1pyOYp96Y61+FPI2y7osidkTb2D6qelDL8OPjkoaRDW5HKv5SxuV1d8kKQ6Ck15exvS
 Rn9kZhMNmEQ05DgzZ2lC3uRDgAShqslDZ4fCDURY7GDcHr+K/y7lQ1eGxOWyiyk8YosL
 bAwNDZciYfbORbszdUfdWv1zTIrX406DglMLZMw+w0r1H/BH57i7zgSUVvv2KzU3dw7U
 i3XH1+eay3DvxDVJoYyQGfFJOG48t7qO6479MzzmswBqipDLjq2iRHhcGGBpRA0Jwwlr
 jX5A==
X-Gm-Message-State: AFuF++k+hy1K2jpOEibAAWZFIbzmxAhiyV1sk8I0tkRArKYc6Q8iY3U8
 zbOSciGe3ntJzbZM4uTOj/DEsz+od5VcHU9O6RYh2N+rUjcg//0IBu02HFKkGg==
X-Gm-Gg: AYBFou2ZvViF4l0qXUrM9LC36m17Gr8nc2bLe25EQ/XWrBAG6FyhAdk17yHnv8PXgou
 p8KNT0aQGrnq2jB7bPisuv3K5yLjK8s7b5jkS/T7n9ii6HFiWHtZuscqWMXKRK65IwnP/p/YjAL
 HTmqQYxRsUFpcGED0jwdiIC3Dd/G3y4dSvV5jxSiSKFOdVny/li1v/7SURqoIqCzBqLYEN9MjaI
 ByNk0qGcGSWro3/7NR1LMZSDH9MCMHBaLpZ0eYplGulXub7f9O44WJDlt6QrD88NM595YQIDtsw
 g9YuQKa0eJasb96aJkr6mfhFqvrl9XSaS1tyEHn2K9grGtMYUtMXpZceFmJ6cr9rSEIi8Qy7ATp
 XYBdv3ex28SNpuBAM1pNUbGIweCDO+u1bSf1SsHcZLHr5JMe5qHzBRfnY+jr9bz37X81H6klUm0
 vLlg+t1CboZFyPWiqh6UxDBsHNcB24C2FFvXbbd/B3Htct8cYoy7/Uuw8IqlzQip76xGLaTS8YM
 nE5Y+d1dChoThIdOHQtQMlejXV4S9+YCqnkZsiMcqQYJ3nv6AFruuGbDA25fOyd20F6YsvZ/Ozp
 ua+4SvgKOj0j4vOlnb9QSB+9Lo08xZSuag+O822GWnfBX9oCRzhnaXd6LNXZQtv3nyBO+tlyt6J
 AEwa55EpZKhmo56f0nS9cLJ1HvoDa9wRkXZ0K9ijn2nDadKM8jlJlizpCevG0exVRXHWDan9nfJ
 4dNEeQ3GahuAqmzDsApOmjhw==
X-Received: by 2002:a05:600c:4e13:b0:49c:cee0:e7c1 with SMTP id
 5b1f17b1804b1-4a02757999cmr13397835e9.16.1790886643472; 
 Thu, 01 Oct 2026 13:30:43 -0700 (PDT)
Received: from localhost.localdomain
 ([2a0d:e487:413f:30f1:9466:ed6d:7fbe:54c3])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a0280c8bb0sm13085425e9.11.2026.10.01.13.30.42
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 01 Oct 2026 13:30:43 -0700 (PDT)
From: Olivier Kaloudoff <olivier.kaloudoff@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: felix.kuehling@amd.com,
	christian.koenig@amd.com
Subject: Re: [PATCH 8/9] drm/amdgpu: fix the HMM range handling for KFD SVM v2
Date: Thu,  1 Oct 2026 22:30:40 +0200
Message-ID: <20261001203041.59923-2-olivier.kaloudoff@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <e524b40e-fc05-4e9d-a87c-e38d88359511@amd.com>
References: <e524b40e-fc05-4e9d-a87c-e38d88359511@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Hi Felix,

> @Philip, do you have time to test this? Do we need to ask someone
> else?

Independent datapoint: I've been running this patch (as part of the
Sep-30 8-patch set, hand-backported to 7.2.6) on gfx906 / MI50 under
exactly the workload it targets - KFD SVM map/unmap/evict/restore churn
from ROCm inference (vLLM model staging + llama.cpp) plus memory
pressure.

Previously this setup produced deterministic MMHUB "PTE not valid"
faults and SVM restore-worker wedges on every run. With the series:
zero faults across sustained sessions.

So at least on GFX9-class hardware with the classic KFD SVM path, this
version of the HMM range handling is behaving correctly. Obviously
Philip's coverage on the NPA/UALink side is still needed - we have no
such hardware.

Tested-by: Olivier Kaloudoff <olivier.kaloudoff@gmail.com>

Regards,
Olivier
