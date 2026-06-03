Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74019CD6E57
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Jun 2026 15:14:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 03FB510E113;
	Wed,  3 Jun 2026 15:14:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="LPTkBfu9";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5A3AC10FFB5
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Jun 2026 15:14:29 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id B6D316021A;
 Wed,  3 Jun 2026 15:14:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8B6F1F00899;
 Wed,  3 Jun 2026 15:14:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780499668;
 bh=Aq028AynYYctYnzfZbArV/GKcGfBvb5dUmYBpDOGCSM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=LPTkBfu9XhTQZh4UVyuDOm1BBIW9y2slYIXZ8q05Z8QCMNc7TTinn0cPSyjjwexbJ
 az2fCIWYK5lOE/gr6+Aw9kE180vyo+nf4Pn/UZb7BZTPUAbKM7w8l72Uju6AYSXAme
 KYsxgmiw7qH9tO56ZLg6Yzkg5XCegLiAZhP7KaHFeZ88V39HlZhWKnw8zPd9ZZGbuC
 XYlkqe6hOGikd+eCfE+jH88TplH+/lmTSVqRbS6JFchBtKy+kSI69F8cbF6IGuZsMY
 N3rBqN+bsuq9Vin/ZN5WOwaC51KyDT3ZMP5U/inkZ2o+OuO7piq8wIZiaTj6VW/VvV
 Wfxj3ptOQbB8A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>, amd-gfx@lists.freedesktop.org,
 Xi Ruoyao <xry111@xry111.site>
Subject: Re: [PATCH v7.0.y 0/8] drm/amd: Backport FPU Guard Move from DML to DC
Date: Wed,  3 Jun 2026 11:13:54 -0400
Message-ID: <20260603105137.drm-amd-fpu-guard@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260527144428.1095001-1-xry111@xry111.site>
References: <20260527144428.1095001-1-xry111@xry111.site>
MIME-Version: 1.0
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

> [PATCH v7.0.y 0/8] drm/amd: Backport FPU Guard Move from DML to DC
>
> As the mainline already contains the move of FPU guard which should
> ultimately resolve the issue, it seems better to just backport the
> final fix instead of adding the temporary ad-hoc change back.

Thanks for the series. Unfortunately it doesn't apply cleanly to 7.0.y.

-- 
Thanks,
Sasha
