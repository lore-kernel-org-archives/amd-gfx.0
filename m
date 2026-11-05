Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89284606A328
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Nov 2026 13:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RYNE5djt
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 94EB1112460;
	Thu,  5 Nov 2026 13:45:33 +0000 (UTC)
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com
 [209.85.218.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C5EAF10E201
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Nov 2026 11:58:27 +0000 (UTC)
Received: by mail-ej1-f51.google.com with SMTP id
 a640c23a62f3a-c45551fa84eso294243466b.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 05 Nov 2026 03:58:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793879906; x=1794484706; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=4udPAj+vAjGY7pMySfGgY8VTD3eMnTYqHum4BF9LIFY=;
 b=RYNE5djtpsQW5enmDj5RjRkRwhLsbgHkqJyM5TEtB5WjI8x1GSBcx9Afny2gIQkGbu
 AM3uqUjDDN0eWzDI1SbVjJtVjEwS+yAYrf5s2OVgsibNDCHC6pHOqp0KO6G4J1rhRck3
 IW6CSR2Ngmfdsp8sOqoqSZLtjnz+2M6yx9zdDBr4vrukGVPYf8ZVJumP2LdyMN/rJOvN
 4/Y7385Wmufb1rSjhkXa9cKcGZwUCS6rx0jq0nFUiq1twiZgNxUWBc+N01dSWAD4EeH2
 q0wwXncXmF8pl/eGvY9yLqONHqfCYHk/qgIrgMmySXTxef1Zdlh8l2t/9UplfCdy6aBF
 syrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793879906; x=1794484706;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=4udPAj+vAjGY7pMySfGgY8VTD3eMnTYqHum4BF9LIFY=;
 b=YADqoUKSVq7HQrM8w6IGE6wPonkbOwfyJNQ4w8erVlKlVIt8VCbBr1Ig+VGEriDreA
 ZJvGym+I/q+/bYwfsArRKC0oES9RcGHlRObl11ueqXc9iUPaS7fKq5j31boZ1ExivR7w
 vgn/TXfMkdzsupG9jE0m0wlVMxdHaf1d0b9kmtwLdyT1Yw9d9iIxbaurusbxNHdeiLz1
 UhXPvbPvqCcaIcF/o6kmohFB9q6U6HQlfwEkwhAl/S6sDbtRPW9DrCijNhdnctVcYdi6
 3oaFmwf5KUY9M62Z3RvkPhA4wW3r297RAnpHN6Lm6xoW1sVR0anRx0f6bik5bSNNDzMQ
 uQKg==
X-Forwarded-Encrypted: i=1;
 AKwUvByi3d/sCyJjGZiukzTELq8XtHN6+CMyYgt7yyw3tT07E8owa+gPpIekmjl0wWE9UyvwGWQ6WndZ@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9asLdodhkPnihQLDwF6/rhQ9k7BF7QbPLrnIMqD9V0vw5roRjp
 Y/eOFDIVqjM86nXwuhLiXbXW8y/G9QGDTc+4cs+Jw77+wOeQA1S4Gbic
X-Gm-Gg: AYBFou0smRnWsJm45DDXLCav7f19rTIPnL0aGDYrrCjsaw5wucAHhIuV4m67AoC87NX
 hm9GTMjLuQdxfKsiNFUKY4tvtkAa3IHhx+71TdFZdb5aTCo7JBsxQOrBl5z3oWuBMKf+ZrqytxB
 zrzLT9K4rB9SMYfPCib6YIoDpBIez119JZxKHXLJXT443ZA5mtP7gAJewuGfOiPk9zX8ihSP8BA
 2ax2F3e+NDZqcKqehh3ddUs1Vie16LO3oHx/eV7il3I2mUNbSFkd/WCMns9pX8o7RHz3VPjYx7/
 8nG5jC55ZAXx7bM4A55HhhJ2FNoc+DLAV7rtTFd5mPfTs8Q0McR9h9yaVTxdC1uQN5WBVj6wEKf
 u2r0Mh8GWUW29L5P88ma7AvCK2IUaBEKI0oTyYzZmpGKdWE04rzwj5UQzFAtwi7nxgcn1UPNSSR
 CkIR7iwE6m5jQezp+NwgvHpqHDAi4xwICd8y0H6700qYbm/KWjo4feXAcGgPSIcLFvFXFDLz+gf
 gG1KAmUCms6jUPdutVApjbEyNKIu6uB53KDj5pBL/WRJ/ZGyy8yy+yyykb3Ye5knrPcrEc+QEx1
 wIAxbMjdzhb2qwSk6AhJ74SPGDDNn4oZgAR5uhRHb7lQ6jJzJn0=
X-Received: by 2002:a17:906:f5a1:b0:c42:4750:8d33 with SMTP id
 a640c23a62f3a-c4ca7a669c9mr1671981666b.28.1793879905834; 
 Thu, 05 Nov 2026 03:58:25 -0800 (PST)
Received: from mbp-2015 (46.205.244.1.static.t-mobile.pl. [46.205.244.1])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c4d0e4662d1sm168632066b.49.2026.11.05.03.58.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2026 03:58:25 -0800 (PST)
From: Maciej Kucharek <qchcio@gmail.com>
To: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Cc: Maciej Kucharek <qchcio@gmail.com>, David Rosca <david.rosca@amd.com>,
 amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com,
 Natalie Vock <natalie.vock@gmx.de>,
 Mario Limonciello <mario.limonciello@amd.com>
Subject: Re: [PATCH] drm/amdgpu/vce1: Fix checking whether VCE1 is idle
Date: Thu,  5 Nov 2026 12:55:41 +0100
Message-ID: <20261105115735.5298-1-qchcio@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <f5baae8455d060493c72c68d160f8a5b61d9aa03.camel@gmail.com>
References: <20261006170352.26722-1-timur.kristof@gmail.com>
 <54fd40c6-f13f-45ed-ba55-ca38052cc3ad@amd.com>
 <Yxz3zvy3ScSroj40wKVDxA@gmail.com>
 <48b0f431-2abe-4e9b-b0bb-aff6f4fbf5d8@amd.com>
 <f5baae8455d060493c72c68d160f8a5b61d9aa03.camel@gmail.com>
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, 26 Oct 2026 23:38:50 +0100, Timur Kristóf wrote:
> When do you see the warning? Does it happen after an encoding job or
> after suspend/resume? Or...?

Hi Timur,

I'm not David, but I see both on a MacBookPro11,5 (R9 M370X, Cape
Verde, 1002:6821). Kernel 7.2.15 with your patch, VCE enabled (no
amdgpu.ip_block_mask), and the SI reset-at-load patch from [1], which
this machine needs for S3.

Without your patch, "VCE busy" is logged on every VCE stop: at load,
at suspend, right after S3 resume and about 1 s later. That was 24
messages over 8 S3 cycles, 21 of them VCE_STATUS=0x100,
SRBM_STATUS2=0x0.

With your patch:

- Load and suspend: no message.
- 8 S3 cycles of 30 s: all resumes fine, 3 messages, each
  VCE_STATUS=0x102, SRBM_STATUS2=0x80, right after resume or about 1 s
  later.
- 7 H.264 encodes (ffmpeg h264_vaapi, 1280x720) in two batches: all
  worked, 1 message per batch, each VCE_STATUS=0x142,
  SRBM_STATUS2=0x80. That's the same value David reported.

None of the remaining messages has AUTO_BUSY, RB0_BUSY or RB1_BUSY set
in VCE_STATUS, so each one came from either a ring pointer mismatch or
SRBM_STATUS2.VCE_BUSY. The message doesn't say which. I'm happy to
test a version that drops the SRBM_STATUS2 check, or that logs the
ring pointers.

Tested-by: Maciej Kucharek <qchcio@gmail.com> # MacBookPro11,5, R9 M370X

[1] https://lore.kernel.org/amd-gfx/20261015095713.20560-1-qchcio@gmail.com/T/

Maciej
