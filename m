Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 959B7CD4851
	for <amd-gfx@archiver.kernel.org>; Fri, 15 May 2026 23:45:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0A6D310E43F;
	Fri, 15 May 2026 23:45:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=triang3l.ru header.i=@triang3l.ru header.b="Aqszet8y";
	dkim-atps=neutral
Received: from smtp-out7.jino.ru (smtp-out7.jino.ru [81.177.141.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3C9CF10E43F
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 May 2026 23:45:10 +0000 (UTC)
Received: from [192.168.0.195] (unknown [5.18.177.157])
 (Authenticated sender: ml@triang3l.ru)
 by smtp-out7.jino.ru (Postfix) with ESMTPSA id 34FD33780BAA
 for <amd-gfx@lists.freedesktop.org>; Sat, 16 May 2026 02:45:07 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=triang3l.ru; s=dkim;
 t=1778888708;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fnHyhE8OC7E4tandFEoDZ0xs3JV66veXOI2xfewdno4=;
 b=Aqszet8yuKxYDsTXG18Za08teAPjLZyoxoW6wTpGxiNGIxMjCxkR0ZvG2dnVCD2mntAm+B
 zIA29UfPstLR83x934qe1zpsXUh6FRnQhFKqd5XT3SANU9u/PmJUbPOZYUZxA2KEB5duMz
 IYX6pJKpaH7AmP5/ruwUdeEWqn6fYuEXhdKUzFp8MjpHclKoYoGAMtFaQaE5Tyvp5yky8o
 1Ctg6Lhfp/QOHO9oGD+n9ez+QrgbyunlqZObSLHKmqKuuqXV2yvjyvUUPN2xgli3p5kJ9b
 L1k/fClUMeOcm3EQPo1A5B32QW92hkiR8YpNmaXFwalzRsY/U+kEgBkvgYwsTw==
Message-ID: <3fab7c2d-8979-43cf-a38c-3d59862e08b9@triang3l.ru>
Date: Sat, 16 May 2026 02:45:06 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: amd-gfx@lists.freedesktop.org
References: <20260515091054.529610-1-arnd@kernel.org>
Subject: Re: [PATCH] drm/radeon: avoid printing NULL strings
Content-Language: en-US
From: Vitaliy Triang3l Kuzmin <ml@triang3l.ru>
In-Reply-To: <20260515091054.529610-1-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

Nice catch, but NAK on the proposed solution.

The NULL prefix is passed to 'evergreen_surface_check' intentionally to
disable printing the warnings, and explicitly handled, but there's one
place where the NULL check was likely forgotten.

I've proposed a patch adding it there with a detailed explanation:
https://lists.freedesktop.org/archives/amd-gfx/2026-May/144615.html
