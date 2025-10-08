Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05C3ECCD183
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Oct 2025 12:49:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5649910E7FE;
	Wed,  8 Oct 2025 12:49:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="UQclxZnd";
	dkim-atps=neutral
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com
 [209.85.216.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C57A310E7B9
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Oct 2025 10:31:57 +0000 (UTC)
Received: by mail-pj1-f44.google.com with SMTP id
 98e67ed59e1d1-33274fcf5c1so7797366a91.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 08 Oct 2025 03:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1759919517; x=1760524317; darn=lists.freedesktop.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=f6LZkodDEq1HIxCXkobbf13l6U/GJUVBzoud6sJa3VY=;
 b=UQclxZndgONbsS4hhke3sosOw5t154y5KwFi9/gGB93AMISrWwNITrSVAzBcqWXXiK
 VtDg1p7JFrpBD7g9RkhCtkLTJcz/l1qK1s5NmiiVfG1YSutGSbcOkEB/QHZvFBAEyoUV
 gMkuYXfN+b6ZVVZ65tXViGynmARQiC8LeKI6lx/98x0xcUuuYy+Rm7KBDYkieW8/cH6h
 4/7sPeU+THr6MGDhlgPvks8ogSC/A5HFPyGO39d1N3HInSOzD4DLn3oG0b71DStfWpl6
 EbgSzjc5+04k4YmjT3QP5HwJBxyYfdMTuR6yRIh8x8isWqX5iqTbaMuyawL1Mya5UMLg
 YJyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759919517; x=1760524317;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=f6LZkodDEq1HIxCXkobbf13l6U/GJUVBzoud6sJa3VY=;
 b=oK51WqolvE12Gu45jvuKe4dYcK4mJ1QRkI0WQZs228Uqcfjn30XcUfwK5wYJsppJec
 Bc/cPM1KkQdJ7Jtg8cRxXuTE4W/pkFTo02Z0rrMsXFAQG/8CRho5khz0SgLSr4866gM1
 We/jgq3E3yoL8ILx7nv5zfmJmGj8ZSog4HD59a/LUCNJzDBamcSBF/RPL2H30Aq8Httf
 ImNGFbyczUzWsmcprdT8iBZ6k8GRxfBzy3dzZZ6Rh60QKWuyyS7AnHMi/k8RzwcVVMJR
 SXpjLnjBpUxWc0iAf6uWugqeCEJfBRTeddul4/gKYe5I+Uy2y3pQ8ceOYjPjbV4ks4Am
 JLuQ==
X-Gm-Message-State: AOJu0Yw7fx6oGEWVQaTEEDErqfF5Di7xuCTv4vSXH2ofOsgVBt0cd+/h
 6wkY1ZWEJlFZXfg+qkJj+NmwechCRxXlY92bpr2syms921OizqnYYlWJ4vCtbQfG4imrUdReUbr
 D8KsNdh+Et3RGcYPUbGBpDpUiw6Vh7mM=
X-Gm-Gg: ASbGnctstWUNaYpgotGJ8e2UnxaVaIjBw4PfZFlWZGwzBekRArkHdDgzTnaPGV5gc0C
 Qz2bME/O5JiuPV9RSlUm+41B8etmz2rOSlJNgozRxF3hDpDmHD8HbBNrLzjCQdNMcKsK4SCO/4t
 U25WaLQGqy1hqYvEXd6kKoaAxRWwBZ2Gr/441/P7i5U+Cs7XV2XVtlW0Anp3Atjq/7+DU27K4nJ
 4SrnEhoztelcN8gW1O+j+s1OiqIWA==
X-Google-Smtp-Source: AGHT+IF14AhZT9buSbXWxBQj5IqiSkq7Ctbzzynaj0/ilXj75RIGaxagvOzHwMf1yydBcpOxbxFs4BVRVEGf1xQ5Pq0=
X-Received: by 2002:a17:90b:4b8c:b0:32b:6cf2:a2cf with SMTP id
 98e67ed59e1d1-33b5111895amr3871446a91.14.1759919517166; Wed, 08 Oct 2025
 03:31:57 -0700 (PDT)
MIME-Version: 1.0
References: <20251008085359.52404-1-tvrtko.ursulin@igalia.com>
 <20251008085359.52404-19-tvrtko.ursulin@igalia.com>
In-Reply-To: <20251008085359.52404-19-tvrtko.ursulin@igalia.com>
From: Christian Gmeiner <christian.gmeiner@gmail.com>
Date: Wed, 8 Oct 2025 12:31:45 +0200
X-Gm-Features: AS18NWA5_CTsZJVKKZZArYCDqLMe_ZXWxpoEel2YI71aNaG-kPc51XfoHb4pNy0
Message-ID: <CAH9NwWdStMzwzhhpbJrsX42_gffD4hFkyy7QErJvPOCtZSRf=g@mail.gmail.com>
Subject: Re: [PATCH 18/28] drm/etnaviv: Remove drm_sched_init_args->num_rqs
 usage
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 kernel-dev@igalia.com, Lucas Stach <l.stach@pengutronix.de>, 
 Russell King <linux+etnaviv@armlinux.org.uk>, etnaviv@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Wed, 08 Oct 2025 12:49:35 +0000
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

>
> Remove member no longer used by the scheduler core.
>
> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
> Cc: Lucas Stach <l.stach@pengutronix.de>
> Cc: Russell King <linux+etnaviv@armlinux.org.uk>
> Cc: Christian Gmeiner <christian.gmeiner@gmail.com>
> Cc: etnaviv@lists.freedesktop.org

Reviewed-by: Christian Gmeiner <cgmeiner@igalia.com>

-- 
greets
--
Christian Gmeiner, MSc

https://christian-gmeiner.info/privacypolicy
