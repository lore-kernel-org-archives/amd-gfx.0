Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B12CD606A31E
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Nov 2026 08:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=quNlLDUe
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0AF1210FA08;
	Wed, 25 Nov 2026 08:42:04 +0000 (UTC)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com
 [209.85.128.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4074F10F0D3
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Nov 2026 22:21:38 +0000 (UTC)
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-4a2153c8525so40871395e9.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Nov 2026 14:21:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795558896; x=1796163696; darn=lists.freedesktop.org;
 h=content-type:mime-version:subject:message-id:cc:to:from:date:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=zq0MEvnPyJvqm+XWDHyPGqImXfHM7CVjIXqvO9H2kvY=;
 b=quNlLDUeAf71bZ+RuanEC1TgPiAu4Q9b4ulKZJDgiqGOQCYKsFQEEla9pJ1loFFCtg
 7U/PLCVZ0YqVV3o5aIK+DBP4iZE8d/xEnunTmcZoe2XWW7qr9CQ8/VKg2VNui/XBSf8e
 Sh+CG9FGENZYoLot4+V+5z1XJbdew5G4Xj7tkQXXjF44pWkJ7o8lWzUrIQ4fcGFlfaMu
 FcThe0KkSzOcg1VlPu7iSaU66K6LFfmCLVHbi3BYluTME1dPed1Vvk3fPC/l30hSb8Up
 dHlqfD0wI9pAASFHK/Y4zDxXJ7hyfsJJ1BwkDRJaoSoCwdkeVTCEx3aUmR8qRIfBiDdx
 f0dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795558896; x=1796163696;
 h=content-type:mime-version:subject:message-id:cc:to:from:date
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=zq0MEvnPyJvqm+XWDHyPGqImXfHM7CVjIXqvO9H2kvY=;
 b=cXq7FnVd1HslHxgopU2gN8AEuePjE7bGS2Z9M486DuTtmFZIsBFyiiG6WSHpB6iY1j
 QJASWY2b5sN3dU9tznFC8SN42CSmxjWEWZGJ8osGCW84Jy0+46keb/MjHZhOhyrqp/1d
 P9D/uETuCbU0in97pO9mX9LcSnsTQkfWZzlrZoEXYsafBeB/6uHrVaxEpjiwOqQfBaMy
 LZwWoEHy6hTAOwUJyoqzjL5kueQGPtWrZe7YRxOzob45/5BAPuqgwHGfhCO4NKDElBqY
 HhlHJwpPCSppEq62neCqXdD+JXSbM/JvdgFa/jklci/AgPC/NCRnVO6Zr6/IhMbtA6qA
 X46A==
X-Forwarded-Encrypted: i=1;
 AL+hErFPgpTF1dz1Ur6GXOI2OVuNen9kUVRsYEjbpTmgqvcqs49de6fuH1DwqUgUNmzKSAMN83tDVvP6@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8YcLG7QJxAqX+Bo3o4SZm2wPs7YK8zxSe75b8CNeaNKL4+NFbU
 ZQsnUp7qkdsPD4KbqkGGw4Ypk8IKRkPl+5BcaScEhPWx1Ur9vPUSvciv
X-Gm-Gg: AZFdTZd0xo6T6tqmxzNlEpUcXEqVn/DHEhPPlVeu9Dq1aledRRjl8NgK7ECVfjMEYX7
 aJAFWwqpZY2d755QGsWIPk1VoIa+ANXLxVtSNpHOcwosT+qrEeKZlbCYOIMMmixQ2E4HXZBqNqG
 /T+nkhJlRsGzqsUucIg36vQMVW5G3p2RL29E4dK2D31iaKQxwr1DZaUv56zLl8xEpr0vBOh4dev
 7s/NFJv/TcTz30awnARlYipNfZLOm5KlWIZfLCv9MZidCi9+tEkTHRZJOALC83WNKmA5NLhQMZn
 W64HNHlwiP4lyooS/8XJElZGfVQslm++iz8FO5B9MoM8IvviHvF2JOEopm1BN47ssRmiHxaulyo
 YRRRwOH2sa8yesQZpxiQJvPk1fI8Qu0CeqgIoz4VXCHpsx+vaaN1hyNCoaelWZ0M+C+ooi2qGIB
 2jUYtBIFw7CJDKj41coLD8nkZzZoYV/2bcNwQs0D+yepiPwAoLks39+UapqpfzMwRg/oMoR5FAT
 DD26lk6KPmmOXsGCdCPOkv/hZ/6vO/n3hTFjbamkBpMS5rp+MXwaclrFV4TWUXNesmizsCt+IwO
 ubtgS95K1HqiWEGRhi1spMUc/QJUHEpwDNbfejQkIA==
X-Received: by 2002:a05:600c:83c3:b0:4a1:7e77:c382 with SMTP id
 5b1f17b1804b1-4bb8880ad68mr314756635e9.5.1795558896216; 
 Tue, 24 Nov 2026 14:21:36 -0800 (PST)
Received: from [192.168.1.167] ([145.40.135.74])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab6a68048esm31736518f8f.29.2026.11.24.14.21.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Nov 2026 14:21:34 -0800 (PST)
Date: Tue, 24 Nov 2026 22:21:32 +0000
From: Matthew Eaves <mr.matthew.eaves@gmail.com>
To: "=?utf-8?Q?linux-input=40vger.kernel.org?=" <linux-input@vger.kernel.org>
Cc: "=?utf-8?Q?bentiss=40kernel.org?=" <bentiss@kernel.org>, 
 "=?utf-8?Q?jikos=40kernel.org?=" <jikos@kernel.org>, 
 "=?utf-8?Q?amd-gfx=40lists.freedesktop.org?="
 <amd-gfx@lists.freedesktop.org>
Message-ID: <4977F4CA-5D7C-4026-AC45-D410896B080B@getmailspring.com>
Subject: [BUG] ONEXPLAYER X1 Pro NVTK0603: pen contact/pressure lost
 after display transitions; also fails when starting at 60 Hz
X-Mailer: Mailspring
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="6b060dec_1af5fbc6_ae"
X-Mailman-Approved-At: Wed, 25 Nov 2026 08:41:41 +0000
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
X-Spam-Status: No, score=0.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--6b060dec_1af5fbc6_ae
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

What instrumentation would best compare the display configuration and seq=
uencing between a working normal boot, a startup at 60 Hz that lacks pen =
contact, successful hibernation restoration, and a failing ordinary displ=
ay restoration=3F Raw I=C2=B2C reports already show that contact/pressure=
 are missing before input interpretation, while transport and proximity r=
eporting work.

Thank you=21
Matthew Eaves
--6b060dec_1af5fbc6_ae
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<div>What instrumentation would best compare the display configuration an=
d sequencing between a working normal boot, a startup at 60 Hz that lacks=
 pen contact, successful hibernation restoration, and a failing ordinary =
display restoration=3F Raw I=C2=B2C reports already show that contact/pre=
ssure are missing before input interpretation, while transport and proxim=
ity reporting work.</div><br><div>Thank you=21</div><br><div>Matthew Eave=
s</div>
--6b060dec_1af5fbc6_ae--

