Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CFEFC87FCB
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Jul 2025 17:15:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C15A210E20E;
	Wed, 30 Jul 2025 17:15:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="cQUHGTHQ";
	dkim-atps=neutral
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com
 [209.85.221.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 85F7E10E20E
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Jul 2025 17:15:50 +0000 (UTC)
Received: by mail-wr1-f51.google.com with SMTP id
 ffacd0b85a97d-3b7825e2775so31362f8f.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Jul 2025 10:15:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1753895749; x=1754500549; darn=lists.freedesktop.org;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JD0IjRt9LhedTgSP9OS2gibaRHGOyFCuZPu0z/W80Ac=;
 b=cQUHGTHQKCZEQpnuEou0py1VL0AkxBIQk9c2IW8txg5aNZWLnPvnGwRqLu/9xlu+c1
 5SV8GrnVZQU2FgUGwlWjBdNn2QqHegwdbC+asclgSJX08IiZJQP1rsN7k4Y+NxITF2IQ
 AOA4vHiRRu/YVsSJ4yiRMa6l699OHU2dgJqcbOc4vizSsNJSNUhiyn9nNhb6JUiul/CO
 XG5d1u+GVd+Fao0OD5k98657CiMnHCCfhi6Aho1k28oAQ9me8uTcV91UTKa5CqZkV5lo
 t8Hm2Dc4sqLezFeEIM42EgzBUSZoH0myGjFuYck4mtiF/GKZMtk/Zro4KacRYWEWPXja
 rs8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753895749; x=1754500549;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=JD0IjRt9LhedTgSP9OS2gibaRHGOyFCuZPu0z/W80Ac=;
 b=ftVF/bFJQ9Q1gSyajnsgvMXYy4j7QDbPvEGOJIGfJDwmr0YNn0zVweYgRBwF6w0gGo
 WTjasEJpMzLU609tVVnjfnffdkfvWP0/k8tZpHrH7y4AkK7wm7GCO5yNa5b2Nsmuy+cD
 1F2MQhIDSU2y3XUCDTlpU+U47Pt5CWIGwyadlcaN5O4FGNhisi+BC9fCKcTqxAznKK+O
 IEcr0NKHhv2SWkE7hSbVSpWusM6wuln5CbziI60eydOBkWxh3KEkKdMXVYkD/E/MqYVZ
 Kp1wIK5ZMIYC8ZZhFhbndHTIxKZzjVoJK0kdJwZ2YiDjZ6Ma107XrFK1QjsPH7G6byAg
 XLOA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV4JU5zN4OayCkiHN5D7sC9c8CZ7Ke+UU1OfwfpU53oDf3M564M8BJLNZESHB1vW5joJdsIO2Y9@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxeK1rMroHENZ/LfP90EnoNjL5yiAPWZv6y+FywAe5AKze0YN8Q
 HtsMzDH5dN/1txZMchk+nrmdotV7OacONUujsaL9bNkSdR9hipZSp4AR
X-Gm-Gg: ASbGncuH7V1E69HLkf+1FYc3m5SI2kTUc6/cmZXu0t9Qr4v3SU6weFjXaEef+Ng8dCu
 7AfGI3OB8kTT5RqVG3rpdHuUtn3+OyS+4T3ZKmifaQJHDNX3rvt6Sz8/X5HbZ/dzSseeTz1daBk
 Yc0KK3sdimuo8oavbivp/5aHkcV5xJUpp4PuYDGkDUdP2ACfYT4Qplel29QESzUw6Y2ojBz4web
 b4JYfQQrxtMPsInoySsxQ9D3FBporiWalJm0yZdpH0Jny0GMewKRuidvdu23LKZh9AdzLDT5KH6
 nxnK09RxnxSUcTsWI39/LqnVDdgrJh718aungVuF80mjyuDMTN4hGXivUCVnYejeg5+GPikxui3
 CFR7Z9zxuUjQjmZsHHVPBJ1WcBvCnjJ2M7zRvD8dzM8V+dIzQI1xoQV7bTlt7nSFGQoWmCw4WNW
 a+7YYpirWzSBMIJwLNHFCKuST+DSk1jdlgoAYrgLl68Z4ku8co5578+A4UnrFE1w==
X-Google-Smtp-Source: AGHT+IG6yIuDuWNOFRY8/aIfiXEwzmrCePdtC7EGvadSo4SQnuw7YtU8VJIELFedNsKoVW3NoSsoyg==
X-Received: by 2002:a05:6000:c06:b0:3b7:8412:4540 with SMTP id
 ffacd0b85a97d-3b79502a30fmr2475061f8f.27.1753895748702; 
 Wed, 30 Jul 2025 10:15:48 -0700 (PDT)
Received: from ?IPv6:2001:4c4d:24d8:fc00:b1a6:598e:5b78:7d57?
 (20014C4D24D8FC00B1A6598E5B787D57.dsl.pool.telekom.hu.
 [2001:4c4d:24d8:fc00:b1a6:598e:5b78:7d57])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b7967a6924sm2759579f8f.49.2025.07.30.10.15.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Jul 2025 10:15:48 -0700 (PDT)
Message-ID: <6eb7b5d34ee3f688d16017b17ec6203bea187d11.camel@gmail.com>
Subject: Re: [PATCH 00/20] Analog connector support in DC
From: Timur =?ISO-8859-1?Q?Krist=F3f?= <timur.kristof@gmail.com>
To: Harry Wentland <harry.wentland@amd.com>, amd-gfx@lists.freedesktop.org
Date: Wed, 30 Jul 2025 19:15:47 +0200
In-Reply-To: <96c3a9c5-f9e7-4b32-8a42-b931b9b96e85@amd.com>
References: <20250723155813.9101-1-timur.kristof@gmail.com>
 <96c3a9c5-f9e7-4b32-8a42-b931b9b96e85@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
MIME-Version: 1.0
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

On Wed, 2025-07-30 at 12:29 -0400, Harry Wentland wrote:
>=20
>=20
> The series looks good to me.
>=20
> Patches 2-20 are
> Reviewed-by: Harry Wentland <harry.wentland@amd.com>
>=20
> Patch 1 is probably good, just waiting for feedback on my comments.
>=20
> Though I would like to send this through our weekly testing cycle
> before we merge to ensure it doesn't regress DCN in some non-obvious
> ways.
>=20
> Harry

Thank you for the quick review, Harry!

I will send a second version of this series addressing your comments.

(Also it was reported to me that the series causes a crash on Kaveri.
While TRAVIS and NUTMEG are not supported yet for Kaveri, I would still
like to fix the crash.)

Cheers,
Timur
