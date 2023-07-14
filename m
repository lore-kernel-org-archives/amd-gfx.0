Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D026EB64DC
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Jul 2023 13:08:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7A22F10E19D;
	Fri, 14 Jul 2023 13:08:11 +0000 (UTC)
Received: from madras.collabora.co.uk (madras.collabora.co.uk
 [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6684E10E87B
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Jul 2023 12:20:44 +0000 (UTC)
Received: from localhost (unknown
 [IPv6:2a0c:5a83:9100:a000:f3b4:c45b:fd64:e7b9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested) (Authenticated sender: rcn)
 by madras.collabora.co.uk (Postfix) with ESMTPSA id 7574E6605954;
 Fri, 14 Jul 2023 13:20:41 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1689337241;
 bh=/QK1CvoIj4sPYbE24wl2osdOcD4Lks2qAy78j0SBdy4=;
 h=From:To:Cc:Subject:References:In-reply-to:Date:From;
 b=KI+v8ICaXYe0qBHunUu7ifXsoZFh1r1SckVzT9hMQMwjecy5kF+NRZAAbS9gav9y/
 SCbi8kn9r/2R+/4Nc1wjt6JANiMyAPLZgZy7XOu20jzoCeZ8wl59PvmfU6YevsO3SX
 ofYQUvoaGD68Qz1iUEkO1pUHV3petdAOlvQKBcVR5vLwDYTwwewTAmEdH7YjUdmIHd
 ZYoG/MHdayycywJpSlPyA74BCC17CNdrcYHjd+jRMiSOy2By4PizahiOktBb9xo/k2
 xIWtuP1b2++ufZgcQnS5yOHfFvKwQvRMnCnhCpFl8Fxkro45hbT7oFk3MI/g2DbHha
 1pkEmWD0Xss8g==
From: Ricardo =?utf-8?Q?Ca=C3=B1uelo?= <ricardo.canuelo@collabora.com>
To: Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>,
 Alex Deucher <alexdeucher@gmail.com>
Subject: Re: [PATCH] drm/amdgpu: replace 1-element arrays with flexible arrays
References: <20230712083137.1080883-1-ricardo.canuelo@collabora.com>
 <CADnq5_OUS=JDfCdrCsuzTB0xD5yeX7piEDEqkRO-ffPTFVYs3g@mail.gmail.com>
 <ZLEmDBfklhfGCLGa@mail.google.com>
In-reply-to: <ZLEmDBfklhfGCLGa@mail.google.com>
Date: Fri, 14 Jul 2023 14:20:38 +0200
Message-ID: <87ilamit0p.fsf@rcn-XPS-13-9305.i-did-not-set--mail-host-address--so-tickle-me>
MIME-Version: 1.0
Content-Type: text/plain
X-Mailman-Approved-At: Fri, 14 Jul 2023 13:08:00 +0000
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
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org, alexander.deucher@amd.com,
 kernel@collabora.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi Paulo,

> I didn't review all struct changes but I reckon that you got the train
> of thought to be followed by now. Please count on me for reviewing those
> changes :-)

Thanks for reviewing the patch. It turned out that making these changes
properly isn't so trivial as I thought and I'll need to spend more time
working on it. Unfortunately I can't right now and I'll be away next
week. Since this isn't really urgent I guess I can keep working on it
after I come back. I'll take your suggestions into consideration for v2.

Cheers,
Ricardo
