Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FAA1CD8CA8
	for <amd-gfx@archiver.kernel.org>; Sat, 13 Jun 2026 12:22:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7B9FA10E3EA;
	Sat, 13 Jun 2026 12:22:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="YzneGPgH";
	dkim-atps=neutral
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com
 [209.85.128.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2C41110E3EA
 for <amd-gfx@lists.freedesktop.org>; Sat, 13 Jun 2026 12:22:28 +0000 (UTC)
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-490b3637b90so13679335e9.3
 for <amd-gfx@lists.freedesktop.org>; Sat, 13 Jun 2026 05:22:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781353347; x=1781958147; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PLEQjlHPyxb7qmLXVpiD2viGlLngNz3OwPerweNOL9c=;
 b=YzneGPgHPZtQyCWh0MRiqTx5eCP90T7dAqOjjyJvwA2FVt4vbvXI+NR/2fUi7afafM
 73QePLJu/w/xANgqtCzqXvELltMW0Ams436hkIlbQbyDBEims5B5ic+L8x+/1UsVJFCM
 LCHIeWZZtwO+dl/dJujBdQ1u5ThZY+zwWzkDNWAGvnKbb5NLPjRgdZW2l/6ZBNjsVIIa
 MThFSfouN9ZFjqQ/PCIXJznEfTLNwGFqIH7CZoBVO4UVMweAdRWUMFoHf0OvazxkkDvt
 N//APXykLMnJyAzbyE9x3Lv8o4CMYzQtAb5pDV23qsRMJXgOVVu5SBz8+Etgxf04FaUs
 0iig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781353347; x=1781958147;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=PLEQjlHPyxb7qmLXVpiD2viGlLngNz3OwPerweNOL9c=;
 b=lBxKb7AY+tCKx2tKK/U/SD4Ndm28avhdDzFL5/AAY8BD1/oQlxGHxvnUAGUd4/Zpi/
 ObqYq9U70daIbay72gw2acBeFDlX+xwiNXWuGES8efZp/3KIcops+iWSjCtP9kj/StWy
 I8dNKznIlpuj3aAmMUSBgZ8cOHKjQq/l+zjXOmLY2KdijCvF7h8J+oaos0zpDfcNaRWU
 nnjPEjv8fSSi13MWiY3xe21yWuCHmNYnB5PNTABoOtJ+dKTkuZ4+yDrC2aR/dXjJ1LGS
 N9UwRGRdzjqyGgf1StPwhoM/r2l0Qan2bsUGAOp7npFBu9G2qQ7tKeVETsWOTETXS5dX
 Yc7Q==
X-Gm-Message-State: AOJu0YwrpyptJ5JECYWj/7r61dShTRWZTcqNa7ebPZpGNqFjZ/oU2QRz
 +iwgBPVUCcQ74tgr0Q6k7XIwN8HEWb8GGrFME+uyNGxVUsFjy2U6234BhM9dk4Be
X-Gm-Gg: Acq92OFgK0nu2oNZGP/vMdPibM9T+JyDX8iLnI1Zy1U0ftp9bMNw151Jjxn3RWEs6he
 7TZLK4oIVYef5zxYArd/4OErDMvYSzZQQRUO7MviWVnyg+zo9cQymsX5Y9+StGE3SIxWdIFTBP4
 pwDn5HmtFXPDb0Oe1I2szMPlaEPS/WGCzyN/cwmBMOJ0rcAXWeQSH1T7m5YTLOpXbtzdJyIVlOO
 +YB6OdX4VT/O3tlqCUMphPfxnHMpCcLz3/TOMZlwaHJT8Kk4ZExtKIZ0HDHOVwQhJSZa1y1tGls
 iyu9awKyx9urVWnahCuWrxd8/Ac01X0mIaGSVBuVm7IfCy+y2MOTu3PnN0qBV+sZCqlMMZJDI4j
 Deyj+yVE24LIOwxc96Z7wmzZ7vYzn9Ar/C2zUUJmfcAX7NzNA2UWgv2WYi5E6p7JU5s14oSuwN4
 7YwQRufT3rnAb0AX4qgjzoC47rqJJ2l3cOS/q6nxDyXeh81gXlqsskzVtHXjuN9W/8eE2eMd1U2
 VT/EJSX3I/oQTt94CB6Az0iXSCh+g==
X-Received: by 2002:a7b:c017:0:b0:48e:6db3:ff2e with SMTP id
 5b1f17b1804b1-49220093459mr29113745e9.15.1781353346482; 
 Sat, 13 Jun 2026 05:22:26 -0700 (PDT)
Received: from timur-max.localnet
 (20014C4E24EDFA00ACE56DB4A62D1E35.dsl.pool.telekom.hu.
 [2001:4c4e:24ed:fa00:ace5:6db4:a62d:1e35])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606f26434dsm15521120f8f.1.2026.06.13.05.22.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 13 Jun 2026 05:22:25 -0700 (PDT)
From: Timur =?UTF-8?B?S3Jpc3TDs2Y=?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 Alex Deucher <alexander.deucher@amd.com>, Chenyu Chen <chen-yu.chen@amd.com>, 
 Christian =?UTF-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Harry Wentland <harry.wentland@amd.com>,
 Ivan Lipski <ivan.lipski@amd.com>, Kees Cook <kees@kernel.org>,
 Leo Li <sunpeng.li@amd.com>, Mario Limonciello <mario.limonciello@amd.com>,
 Ray Wu <ray.wu@amd.com>, Rodrigo Siqueira <siqueira@igalia.com>,
 Rong Zhang <i@rong.moe>, Simona Vetter <simona@ffwll.ch>,
 Tom Chung <chiahsuan.chung@amd.com>, Markus Elfring <Markus.Elfring@web.de>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/3] drm/amd/display: More efficient data output in four
 functions
Date: Sat, 13 Jun 2026 13:05:54 +0200
Message-ID: <2796386.vuYhMxLoTh@timur-max>
In-Reply-To: <e0689a10-9cd6-4d74-a276-99f8f01c83fa@web.de>
References: <e0689a10-9cd6-4d74-a276-99f8f01c83fa@web.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
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

On 2026. j=C3=BAnius 5., p=C3=A9ntek 13:30:13 k=C3=B6z=C3=A9p-eur=C3=B3pai =
ny=C3=A1ri id=C5=91 Markus Elfring=20
wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Fri, 5 Jun 2026 13:00:03 +0200
>=20
> A few update suggestions were taken into account
> from static source code analysis.

The series looks good to me. Thank you!

Reviewed-by: Timur Krist=C3=B3f <timur.kristof@gmail.com>

>=20
> Markus Elfring (3):
>   Simplify data output in psr_capability_show()
>   Simplify data output in ips_status_show()
>   Use seq_putc() in three functions
>=20
>  .../drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c   | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)




