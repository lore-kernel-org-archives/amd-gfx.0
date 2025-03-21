Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E3EBC35FFF
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Mar 2025 10:27:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A733D10E780;
	Fri, 21 Mar 2025 10:27:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=fooishbar.org header.i=@fooishbar.org header.b="UsncP2e9";
	dkim-atps=neutral
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com
 [209.85.222.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AA81810E782
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Mar 2025 10:27:04 +0000 (UTC)
Received: by mail-qk1-f171.google.com with SMTP id
 af79cd13be357-7c59e7039eeso238291785a.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Mar 2025 03:27:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fooishbar.org; s=google; t=1742552823; x=1743157623;
 darn=lists.freedesktop.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=C6XBFDQAIe6jgF6F40xRB15uQkrbHzlxj9SySg4AP08=;
 b=UsncP2e9n3QNbKNxZR9VuO0EAMPJbvKSYfFP1ZrgDxZcz93zOv/jaLFIWidxpfe7Oj
 vCWo9ZgtxCdavBaeguknpbzXxjVVfrf//zmC1Phd6eRPKrrUxiDNCtotg5BNtnPhThgY
 GMlqnQo9e2WDFoFLNeBtJhpnbV6qkNBwrAwErTZoC/PRbCDjvBqa/87HGn65lwvxvsqk
 UBeJN/cRvZx+zH/IsIGWFYwQ2JWTRSrTS9S50sqEyEykyla6gax6cZ6ZqNu3HVpU6tZE
 r3OihHp3BHjebgW3DnH2d6E9rLjtmYUUbe9lZqThPl+alpzH1agT72Xzh8sI+d0NimFI
 YYIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742552823; x=1743157623;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=C6XBFDQAIe6jgF6F40xRB15uQkrbHzlxj9SySg4AP08=;
 b=jP8CFc4lptTezVE0j0WVrGDwIf4VyNWSevs+z0ksBq+Hsv/Ev2RxuwL17Nxb3xZnl5
 q95EgP/J0r0UgFeqJ8r9wuhQudGjFuTghH5qqwUkSwPSxsULqsOsNwf0mGve8nDRYN0o
 ZcBSguBuziwAIDRa3mf4zTWBBePam7WmTWpB7t7UMlAek8kkqzrIQh4JJJUO0MVtf+Xi
 ghaHTGAFVV35a2x+QjSboatUDPzbt/tYAuYnvSDl8e5vuJtJJOTd2KHQobuHJXCRq1Xu
 ykfTZjCsJx4J0wgn4AXKGASVJ3/wDVfZ1c4XBoBFFBZb+CoHLeIBEQywfVT8+9lVpLy3
 3JHg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW2NTE3bJDbC00pE5KaBy3vuthtE8xCYUDikYXAB0OzWFvctyLB58bFx/G9fVXmsg5fNC4F162p@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxXMx2pH6hGxAN5SkOiSBgnXPRORLv+GpK/4MJE6ZgOnam1QXSx
 UZznqv5XHIuFMyYfBj7KP4nClZ4JznAMATdgELunScwOYqwToPdk2+hZ4VrTWLDHsUFcC+DHcVN
 PPz8/Hp3YDLCqM3cHqHy9bQ6bCFW909ENVr3HPQ==
X-Gm-Gg: ASbGncskk5PC298yrH0UqJeHXj9879Ss1rRx9hhVZfq1KnZRrl9AFp0qlvqWqytzb7x
 itRyfDtGDlrPwiMtLWcDLFQdutRGS7IN/icLsv8BOcA/LKt4V/zKot/6FXGJz9xvUEJFQ3hPlM/
 qBRe4DxHbQGqbw6yVaU+3VBRNg
X-Google-Smtp-Source: AGHT+IGtKZxKAoZgtR0aBlIVmyFJdz4vLgELnLl5z6u4LuYLjXNoyuq0UVrTF+CIIc7xPDTVRmAHZ+SRVPvG/7TyZXI=
X-Received: by 2002:a05:620a:4055:b0:7c5:a423:f5b0 with SMTP id
 af79cd13be357-7c5ba13361dmr406693385a.7.1742552823192; Fri, 21 Mar 2025
 03:27:03 -0700 (PDT)
MIME-Version: 1.0
References: <20250314085858.39328-1-vignesh.raman@collabora.com>
 <20250314085858.39328-2-vignesh.raman@collabora.com>
In-Reply-To: <20250314085858.39328-2-vignesh.raman@collabora.com>
From: Daniel Stone <daniel@fooishbar.org>
Date: Fri, 21 Mar 2025 10:26:52 +0000
X-Gm-Features: AQ5f1JpymW7UP78_0g_Z-sNByprYGBFX-xYqr_OlbVrsK0-Hob7Zk88vIu6Znbc
Message-ID: <CAPj87rMjF84yyPqBshuGu=8qx6Xhq9Z-HgEnQe=tRtbu3E8OtQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/3] drm/ci: uprev mesa
To: Vignesh Raman <vignesh.raman@collabora.com>
Cc: dri-devel@lists.freedesktop.org, daniels@collabora.com, 
 helen.fornazier@gmail.com, airlied@gmail.com, simona.vetter@ffwll.ch, 
 robdclark@gmail.com, guilherme.gallo@collabora.com, 
 sergi.blanch.torne@collabora.com, valentine.burley@collabora.com, 
 lumag@kernel.org, quic_abhinavk@quicinc.com, mripard@kernel.org, 
 jani.nikula@linux.intel.com, linux-mediatek@lists.infradead.org, 
 linux-amlogic@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 amd-gfx@lists.freedesktop.org, linux-arm-msm@vger.kernel.org, 
 intel-gfx@lists.freedesktop.org, virtualization@lists.linux.dev, 
 linux-kernel@vger.kernel.org
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

On Fri, 14 Mar 2025 at 08:59, Vignesh Raman <vignesh.raman@collabora.com> wrote:
> LAVA was recently patched [1] with a fix on how parameters are parsed in
> `lava-test-case`, so we don't need to repeat quotes to send the
> arguments properly to it. Uprev mesa to fix this issue.

Thanks a lot; the series is:
Acked-by: Daniel Stone <daniels@collabora.com>

Cheers,
Daniel
