Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F324A606A326
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Nov 2026 13:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UpqoqS//
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5B12B112456;
	Thu,  5 Nov 2026 13:45:30 +0000 (UTC)
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com
 [209.85.208.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 59EAE10E201
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Nov 2026 11:59:35 +0000 (UTC)
Received: by mail-ed1-f49.google.com with SMTP id
 4fb4d7f45d1cf-6b58cb69927so190989a12.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 05 Nov 2026 03:59:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793879974; x=1794484774; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=kajzKvWY75Cu10GQGa9WW0sgGHgnyFOgTW+IibeEeQw=;
 b=UpqoqS//JdRxG5rudHF8mVgY6JVSjLP4VlJLvASTpH24KW+QieGaNqC7PA4hpOT6rX
 tWIMNhm3Tu6jMkpBRO2DkUhGAZG6rRy7op1vFzgsvz9oU5M38OUbC2CJnTO3tRr1g+Aq
 8Si/GJnk8H1HG5dhCM1HgcTY/zdEprGKLreG/whu1GpDGiuIpVsgarU6LtNl9JoUcj+s
 k6kFXafYZwJz7iDeDZnPwWr38JaQm/QPICktxC6qFurZC7vAvUkEg2iVXjhoU2pV3ZwN
 swpd0X5KdJEoovhlGOHJCFVmw8nAh4FYBD31ZZBaf3GZn4egCMwerWviryEGsf5NHMFU
 lVYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793879974; x=1794484774;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=kajzKvWY75Cu10GQGa9WW0sgGHgnyFOgTW+IibeEeQw=;
 b=DGKV/hHepA0NjaKeNIw4xxdgNrayKlHYDTvGpZY3RN7+agYekv4d3jiw0FEJpdU+Ah
 p6CDfe+FaNTaev542D1Zh4tgytb3wnVtfp0ico1r7jchx/X/XZQjwJShzbS23KIfeg2E
 4AsAdIgcZpJh0fkHReIDE6ArT6utAmNZ6fJjnIJr5vVkxX9ewnJtGky7ohhapO+BCjO6
 AVXYgqZCrqSOZ0mD5uZBUIscN0mflXiMZtX9qFshsDrRNccFzl1fckzfJyqwtEdFE9Cc
 3SvGJDfGX2beu776xyFrVkSr136cmMpy7Mqw488bV+YqYv2H9soG5YuxFreT7efi0vNS
 K2sA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxUHJmdmipL8cZiHtShTKMJcbfgE6I+mhr6/Nutod/fhKHhGMQ0R0nw8edADNDZ/jtIz3u1MKfu@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+nVJfXe6KfVlt3aYxlZdkXZUXkzgwtZFqI+CNDnVDxtOUuqke7
 FfJeSMiyQEPzs8dKdY1SuhlcBo6wxQpzOtxxRHuXFBbHquss5r9jv8d79wEL0uhFNyA=
X-Gm-Gg: AYBFou1PqND2Crj343lXh8YUATL7uFusSzauYcjKE5TVew140xby/BzwEXMB0Pu2QQ8
 ei7QMSYQZJ3NgllNDHXsV2yn9hBeTlmuzyly/coxXCgvsQhqO6kyYoFItCXvgWJjc9IK0067ndb
 l/dpA+cz/5N61YzLoG/B2h/hMjqlYJwIQ3xKJ0xSDKxVTNRE8rnGuA61qhquKywMoA3Q47UP0/Z
 xsiUd+wmtDi3Ywh0xbNFGqv8cYkA9RnVXD2MUUTjl0P4Q9XuD9WogvCobl2NHm0uYIWmlb9s2A7
 GR87PtXBYbBWcMwsirCnGqcwIXnqBCC3Ao1/wgc1poqBuRNz61xssF74f99MKLPD+WGf5iogHYW
 qEKb+G2iSZASsGH3p9HnDjI9Qh1ya3CtCgUxZlbA3QK551jazf86yvhLEJZOOvQTw0cXzt+cmyU
 ZnnQ8mk1IQYyEk78aLnyVnFdPFGcgXfVKnRITE7mTUYrlaO0+GgJy9aJUlBlNxDS/zXCHhkIhXe
 lIt9ycm+Q8K91Y9dB1aRy2W8uojLvKrMNPZYsbGnGsg3SX3tTRdtYjY6+ncI95A7hmHYGDLadOu
 5ylyR7Id1IdKkBrpYzs9EZ1S6pZngVqSuy4Q372zTVH/ITooIbE=
X-Received: by 2002:a17:906:c108:b0:c26:1cfd:4244 with SMTP id
 a640c23a62f3a-c4d20659a41mr194875966b.11.1793879973561; 
 Thu, 05 Nov 2026 03:59:33 -0800 (PST)
Received: from mbp-2015 (46.205.244.1.static.t-mobile.pl. [46.205.244.1])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c4d0e487700sm165375266b.63.2026.11.05.03.59.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2026 03:59:32 -0800 (PST)
From: Maciej Kucharek <qchcio@gmail.com>
To: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Cc: Maciej Kucharek <qchcio@gmail.com>, Brad Drury <drury.brad@gmail.com>,
 amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Subject: Re: [PATCH v2 1/3] drm/amdgpu: reset SI ASIC on MacBookPros with VRAM
 at 0
Date: Thu,  5 Nov 2026 12:58:25 +0100
Message-ID: <20261105115857.6103-1-qchcio@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <oVwVffbwQ9mrJnRml_R8-Q@gmail.com>
References: <20261015095713.20560-1-qchcio@gmail.com>
 <20261015095713.20560-2-qchcio@gmail.com>
 <20261022073638.724414-1-drury.brad@gmail.com>
 <oVwVffbwQ9mrJnRml_R8-Q@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 05 Nov 2026 13:45:29 +0000
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sun, 25 Oct 2026 18:14:35 +0100, Timur Kristóf wrote:
> The following patch should fix that:
> "drm/amdgpu/vce1: Fix checking whether VCE1 is idle"
> https://lists.freedesktop.org/archives/amd-gfx/2026-October/154367.html

Thanks, Timur. That matches what I see here.

On my MacBookPro11,5 (R9 M370X, 1002:6821), 7.2.15 with the SI patch and
VCE enabled (no amdgpu.ip_block_mask), all 8 of 8 S3 resumes worked,
with no ring test failures, -110 errors or GPU resets. "VCE busy" was
logged on every VCE stop: 24 messages, mostly VCE_STATUS=0x100,
SRBM_STATUS2=0x0, and 3 of VCE_STATUS=0x102, SRBM_STATUS2=0x80 right
after resume. The stock module, without the reset at load, logged the
same 0x100 message at load on this machine, so it doesn't come from the
new VRAM layout.

With your patch on top, the same test gave 3 messages instead of 24. I
sent the details and a Tested-by in your thread:
https://lore.kernel.org/amd-gfx/20261006170352.26722-1-timur.kristof@gmail.com/

Maciej
