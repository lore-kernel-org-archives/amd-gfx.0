Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48C32C982DE
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Sep 2026 10:37:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B8FC889613;
	Mon, 21 Sep 2026 10:37:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="CZDTftZo";
	dkim-atps=neutral
Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com
 [74.125.228.140])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6A17C10E087
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Sep 2026 10:37:47 +0000 (UTC)
Received: by mail-ej2-f12.google.com with SMTP id
 a640c23a62f3a-c294496989aso371124166b.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Sep 2026 03:37:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789987065; x=1790591865; darn=lists.freedesktop.org;
 h=content-type:content-transfer-encoding:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=PT83wCYstVYb77BaJ6O2wnsCGDMjJZAMJK8lDtmAAac=;
 b=CZDTftZoFZUEv38VlsqfFnZqY1VnBalXrCTPiMi5x1HvTeTsee1fvkdhev6CWF/dxj
 hZc3RTkKWG4HxKIHBysAecs1P85J3+kOVnWKopJ8AFaOGtMpS0WiL9lPab+1DfhQZH00
 DPG0MpQo7kjUcKCWo7qKug8gwmk+KI/1tLV1E3E5S0E7cdneg1uK6yv6qZKOBRYafLQV
 Vr8oN8iv8O8RnE2yJ4Se8P3ftR8F3gjGjwFgNhiUmKg1VTveORMiTTUNNtg/kAJDA/01
 9toFsHnGMuyZA1+KNuGBG0dg2wnw3h/utEcGAzFUETwiDo+nd6NRy01Q3W5QhC71NQB7
 EpTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789987065; x=1790591865;
 h=content-type:content-transfer-encoding:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=PT83wCYstVYb77BaJ6O2wnsCGDMjJZAMJK8lDtmAAac=;
 b=qKH+7nWcmnJ95Et1Vv4lhHcEMaf4UFFicV/+LzvKa0AoKKJmLaQR8uFVEMOFbXODxS
 T0gDjtDRWHeK8bzEUEXKqnrh8TlxU9+6jgLw1DabzWyT8na6lQ2RlJqwkiR3rM/0iqel
 HtJGwTeM9SRysPzGiKsjV6e5yti1fK9Bu9/atwWQpqxT81DZ3uB1EUW/lodhpaJ8g0k/
 M9exA64OfiIXKMbYPlAlR2+hvVSIUFvfMzJzcfvqAxSJjEiR5t24moRxV08Ch5x+jjnk
 qfodzqkmcCR7iGF/35AYLEiT1aeXNl+Eqtnt9rDg18Lkqjr5rCw5q0ITxU74XPhQyibw
 tQ7w==
X-Gm-Message-State: AFuF++lEMSuYngVAEy8zIV3BeYgo+zNXKZlmV8GBLGjT2VoEG5N9GGhJ
 aWebU7yoYAGmLXjGXtAGpLdSNJtXcIZk7zh8DqZUDv9wSznHHszRYZ/n/1hSsQ==
X-Gm-Gg: AYBFou15eI2L/hC3hapCb/eKgge3k8Q6rPawAAB64zreF/4DON0nHbOOJHFWe7GaQPe
 qPRvkRrfefDCsakXgsQVDddc8UtistbxyvM4U78gPwl9rsK1ajRHEU6yMvNAJUD8XajqTgFpDNf
 RK5kIhzxh07DRjBKV7x6NRrROMOsN2fdYe0DIlQKanb5iOvTdMSh8X07XmP73qZhIXlEGkYL/Az
 jbSYuqDOWjcvx0PAmhwBqfF+vQ8+Kfc2Fm7aM3E+SVzWNy0NgSw5+qyVdEk4D/HordYmjDPXT/H
 KXO5e1+gorLpXOZ67603+y92w6EoqOdXUYMXAzDQXjtwqsPoFnPecSFQriez53P/KE0MntsXFOC
 LzHMAbRq7jhI8ZdEoZvxDggojfuP6bS139lrjPYPat9pebfMz8M5zO1CTf+wdJpOeSDGANBGHVD
 iGLy5S/xCyyLGcbmUpSQhX34s4l3ag2gpZg7S7rjDn6crmwJrmTlpgJWX2IU09mnRvLglHd7wxS
 3kmV9Lm8mFUZEvyQDys7CrXq0bDbcin8zrnmoJs/hdKfZM=
X-Received: by 2002:a17:907:9345:b0:c25:5a7:87f with SMTP id
 a640c23a62f3a-c2a1547f75cmr822506066b.0.1789987065302; 
 Mon, 21 Sep 2026 03:37:45 -0700 (PDT)
Received: from timur-hyperion.localnet (5401D96A.dsl.pool.telekom.hu.
 [84.1.217.106]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c2a355ea970sm280707166b.20.2026.09.21.03.37.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Sep 2026 03:37:44 -0700 (PDT)
From: Timur =?UTF-8?B?S3Jpc3TDs2Y=?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com,
 Natalie Vock <natalie.vock@gmx.de>, Tvrtko Ursulin <tursulin@ursulin.net>,
 Felix Kuehling <Felix.Kuehling@amd.com>, Lijo Lazar <lijo.lazar@amd.com>,
 Christian =?UTF-8?B?S8O2bmln?= <christian.koenig@amd.com>
Subject: Re: [PATCH 1/5] drm/amdgpu: Delete SI/CIK/VI IH soft_reset() code
Date: Mon, 21 Sep 2026 12:37:43 +0200
Message-ID: <RY2IRd_oQXa3Lr23bQzSrw@gmail.com>
In-Reply-To: <77bd73f2-3e33-4c78-adaa-634b381ea5b8@amd.com>
References: <20260904183409.571117-1-timur.kristof@gmail.com>
 <77bd73f2-3e33-4c78-adaa-634b381ea5b8@amd.com>
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

On Monday, September 7, 2026 9:43:55=E2=80=AFAM Central European Summer Tim=
e Christian=20
K=C3=B6nig wrote:
> On 9/4/26 20:34, Timur Krist=C3=B3f wrote:
> > The code for SI/CIK/VI IH (interrupt handler) IP blocks
> > has a soft_reset() function for each block.
> > These functions are not called from anywhere and are
> > dead code. It's unclear what the original intention
> > was or why the IH block would ever need to be reset.
> >=20
> > All SI/CIK/VI GPUs have been working well for
> > 10+ years without ever resetting the IH block
> > so it's time to just delete the dead code.
> >=20
> > Signed-off-by: Timur Krist=C3=B3f <timur.kristof@gmail.com>
>=20
> Acked-by: Christian K=C3=B6nig <christian.koenig@amd.com> for the entire =
series.
>=20
> @Alex do you pick them up or should I?
>=20
> Thanks,
> Christian.

Hi Alex & Christian,

Ping. Is there anything I need to do to move forward with this series?



