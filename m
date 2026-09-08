Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C96F2C79FA0
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Sep 2026 08:42:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5929010E0C3;
	Tue,  8 Sep 2026 08:42:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="HJ41I7Kw";
	dkim-atps=neutral
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com
 [209.85.128.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 509B410E0C3
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Sep 2026 08:42:12 +0000 (UTC)
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-498028b3d5eso41658275e9.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 08 Sep 2026 01:42:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788856931; x=1789461731; darn=lists.freedesktop.org;
 h=content-type:content-transfer-encoding:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=joPEKDE4UQKIZJf0CfPXD8xX7p4OCRKtZfIi90wqNms=;
 b=HJ41I7Kwl71gKzUdBX9+znij9zxHktjSFL4Tb8qFGhcnGFlma92+m7IhJ4vJD2q+rc
 HX76HVNxhPDHjrfzpC8TEmBJK25CeQYO4YG8uoifBC1uJ9o5D5o6Y5ASmAzrZBPwO9yk
 IKru5/k+pYQOg5lwFVT9rqYU0aUsBrdN/EPUvD9/+804m9aj97dK1yPwdZP4nPGYd9lx
 qIkzNcLm7yze32MleXvuRrlfaUL34N49iZrlYfUvyNaN7sgOpCiYYZIOs8AbTKG8BeN7
 YsamvTdbC3RAkSJuBxJnjSdMu+wdPeQPEV55vj/hgHnbPevEi63IF+P+XiIOxpY2toJm
 ignQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788856931; x=1789461731;
 h=content-type:content-transfer-encoding:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=joPEKDE4UQKIZJf0CfPXD8xX7p4OCRKtZfIi90wqNms=;
 b=Xx00rr2REOTt0Po5afSOM38PKvOqqzUkTqfASQPK5+h8O9hpi5cDzD/Ro38dfqzZQ5
 msSB1wr/vgdp/e+3pENsgrV2TzywOVxauFpXncm6aCbmH9/wDKIbeLmfr6GY7t+jGRxL
 lkdVPSxUXOGTObBM+YkqNAHZ98ADgTUUK+Qbac07czje8SpX6H2IIZXhKqsZQEK7WCgh
 DuetgcA7qupvAsLNyjyX6K4lrIMuz3l2IanKkt2YjFlDbv2oXMEr4//x0YPkvTeAmucV
 rh6vVZHKOzJVfSYLFxsaWqQM0NWBii/yoWRhGpckpYcjW/El0/srFRKW2TPhMS/3Wfm4
 hyqQ==
X-Gm-Message-State: AFuF++lHMYm4HsIzVo3PTVQh/1A5w+enEbSg7LjJ/bvNXBVpupee5idR
 qUIRAgRNCzq46aivEHx2TkbYC6kXTayoneSxaduiq30b5qAsuvydmm4yK4Ff1sFg
X-Gm-Gg: AYBFou1PeLwjc8zPiqrBI0pUgRhES9+p++WME39UATUHuK4eQq8WQyLfViUgPGgo7X/
 HWMNYDiEzhy11+Z7kfp4u6xkMz50n8OwMKrqPU+/iWilGZKICuVdCMFIhkn6kXE0Tw8NNNgcDaI
 d1bPmiSVdPO0qUebOAs0KEgNymM70QvZwN5Ju2XpW/KstpC2iywebJ904XLIgZBM0/dQ7P+WecI
 Wc/xcBBixnDg5rjvLtqqoS3T2CcAR7AlDfqJCsOlME+5ybpq0kC7nX+gQPrYedtSbJDxDqBS1j3
 uBHB5hXlb4QhrTqwGexzvBDqM/oIEvwBG+gs4oY4Q9tdDrN9xA3EMSq5Yu13R+4itNQzIQbOedr
 HH+XdCan08G2+Zy/SKOFDeUyJEMtaog1FHKAI2SQtGk97zebczSOSDBbtxuUHlG2CVSfYxLPCsC
 ZOBii1fiyENGiRf/CxLlDRX+tS1b0O8E8mx6jS3ADnzhUNEuOjp1RS2fkKQOSHanpjt33T/6fAb
 9Uvvgdq6zTROkLj/bK69fnEJ671FLDV
X-Received: by 2002:a05:600c:1f87:b0:49d:827:e5b6 with SMTP id
 5b1f17b1804b1-49d0827e5ffmr157291015e9.20.1788856930459; 
 Tue, 08 Sep 2026 01:42:10 -0700 (PDT)
Received: from timur-max.localnet (athedsl-4460056.home.otenet.gr.
 [79.129.254.8]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-485958f1493sm23213622f8f.37.2026.09.08.01.42.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Sep 2026 01:42:09 -0700 (PDT)
From: Timur =?UTF-8?B?S3Jpc3TDs2Y=?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Subject: Re: [RFC 2/2] drm/amdgpu: Drop null SDMA instance checks from SDMA
 vfuncs
Date: Tue, 08 Sep 2026 10:42:05 +0200
Message-ID: <KxQ5VDZpTeijTso_Uy70_Q@gmail.com>
In-Reply-To: <20260622143649.54632-3-tvrtko.ursulin@igalia.com>
References: <20260622143649.54632-1-tvrtko.ursulin@igalia.com>
 <20260622143649.54632-3-tvrtko.ursulin@igalia.com>
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

On 2026. j=C3=BAnius 22., h=C3=A9tf=C5=91 16:36:49 k=C3=B6z=C3=A9p-eur=C3=
=B3pai ny=C3=A1ri id=C5=91 Tvrtko Ursulin=20
wrote:
> Commit message TBD - Can these be NULL?

I've looked it up, burst_nop was added 11 years ago in commit 18111de0dfc3.
I have the following thoughts on this topic:

1. For newer SDMA IP block versions, I think burst_nop would be supported o=
n=20
all firmware versions and the check shouldn't be necessary at all. (Eg. I d=
on't=20
think there was ever any SDMA v5.x+ FW without this feature.) We should fin=
d=20
out which IP block versions exactly are the ones that always supported it a=
nd=20
we should just remove the check from those.

2. I don't understand why the burst_nop flag is per-instance. Is it really=
=20
possible that not all SDMA instances support it? We should find out and if=
=20
possible move the flag to amdgpu_sdma instead of amdgpu_sdma_instance.

3. To actually answer the question in the commit message, I don't think the=
y=20
can be NULL, unless an invalid (not SDMA) amdgpu_ring pointer is passed. I=
=20
would rather just assert that the ring type is correct.

Best regards,
Timur



