Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB752D68BF7
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Dec 2025 09:00:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 48CA210E484;
	Thu, 18 Dec 2025 09:00:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="k30ZvcBH";
	dkim-atps=neutral
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com
 [209.85.210.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6470310E374
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Dec 2025 05:08:36 +0000 (UTC)
Received: by mail-pf1-f169.google.com with SMTP id
 d2e1a72fcca58-7f89d0b37f0so703879b3a.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Dec 2025 21:08:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1766034516; x=1766639316; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FjcGM5VTK5l67wkUrio2NVMt8umJm7P9p36dbsbXPfc=;
 b=k30ZvcBHEBl+ABAH96nIXjWPdyA1+w/RWc3U7mn8Rm6vPX2gmwtymCY5WDftOD9oQG
 TUlFs6gIN+c/S1rSfMwGcVQo0QLkUKjELJN+iMczYebzx1jbVqJ0XfJauBo0mDwvssh0
 GpYlyT6PqcE+Zqxr0WW39rTtnd56cRSa1a+J1SpYIlKD7+0x/GubKbwqcpYMrBSkbuBN
 CvBNxKxd7ftdVbQpAaz2Gxt06e+W3d5u56pIVEuBQkkhM2jMmWrAYCOyQiOOVqNUDDSq
 yYIiblss2ZpZkOBtWjrDJO3X5dpj80VvO7KYSXsrn/VTYpGXs2t8uQzjutM+oFKG9YJ6
 ieNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766034516; x=1766639316;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=FjcGM5VTK5l67wkUrio2NVMt8umJm7P9p36dbsbXPfc=;
 b=Ppu70jIULlsKJqaofaOpADv4j+qG8d9oQVkR3u40Ots8FWO2TLONNlj7qDppjKG+Fo
 ToevpBtKgE2VbpwHWw0QpJD8SQEsR+5eV+YHvfPMmxQAO58d/PsKM8bPpRyk+6ZDcUtP
 7oqGxFaHfcu5CBNhG54X/xm4VOuR105zFCClQJ/nWhtUD0nSIU6YvOPSqGj7xT8E146R
 3KGfVsv8Lq3RKaU7zeAb//o5kJ3fVRFeq5v3qnq/lqRMsL6uXcyprzb97ezs0WhvxOUY
 nOHk+ygir4i1vL+hVHs1VBJppOlTNJR1ydDnxFRuHUPgbAh+39EG5Of7QE2zXVMn97dY
 Eueg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWHS/ahhSTlzLeKvMAG4MPQCEEEuRNVZGLuPlw67xU3EDHCHRNig6pCrFyyUJVAnI6uh3ZPMEl2@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw6ncsSH8j1gUv43t8DRpDh9K5xxhxrVqlRS20qu/eJczEnJQGh
 b+otBI4Ryy7OpH15khPOyv9qq4d4avQG+//DNDJX3t3rFdInT2SqOBjmXXq10EcO8ae5jr8uiQI
 86rVogdU1EYyIw/kerpzOzITstvdiuNc=
X-Gm-Gg: AY/fxX4w9QUf5OEhIexQ71Hv/LFLPLflfIzFOTcOc78r/tyzLWDy7sos5YJqoG/brjb
 gcRuv2Nn5/+3ZhJ7D4kM7EuWQ+f8ZZk735Fjup1IpM6F6Lot1KWI1K9dLWu9/UKjPYcG0p1eNU1
 zd8wG056t8M8W4PoqNrHwxH4wp9koWszgLffE9xgpMkY2XGVmk0vwuPapo2Q0WOX67l/kSRaRqi
 Coj4QAO7I6v6sbtmX+DlwOSCFjQei36kgk2FOS/UJKuViWxtLyMc7pbkVkJdOf9w84Ksvkg
X-Google-Smtp-Source: AGHT+IGq6/nMOiB2lnPK9y8yr1jjzPOXZ+THQMFogZeydpYpCLbdWv0ujw5klX1QwrcBpi7ZqC5hyE567ybtLRh20ec=
X-Received: by 2002:a05:6a20:9151:b0:366:14b0:4b16 with SMTP id
 adf61e73a8af0-3755408aa5emr1988106637.33.1766034515891; Wed, 17 Dec 2025
 21:08:35 -0800 (PST)
MIME-Version: 1.0
References: <20251217170104.2767939-1-suryasaimadhu369@gmail.com>
 <4f872e73-5961-4cc1-a826-850445235a36@amd.com>
In-Reply-To: <4f872e73-5961-4cc1-a826-850445235a36@amd.com>
From: Sai Madhu <suryasaimadhu369@gmail.com>
Date: Thu, 18 Dec 2025 10:38:24 +0530
X-Gm-Features: AQt7F2rsUKtXkOCC1wfOQu0Mcmws3R8p9eouU3IF3TCiZBCmsgHa4wR8itgik04
Message-ID: <CAB0uMAfmpYdGPwtZZkaBf1ShOtXbdDSdbR7Mkqp=+P+nN55Kaw@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/dm: Convert IRQ logging to drm_* helpers
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: harry.wentland@amd.com, sunpeng.li@amd.com, alexander.deucher@amd.com, 
 christian.koenig@amd.com, airlied@gmail.com, simona@ffwll.ch, 
 amd-gfx@lists.freedesktop.org, siqueira@igalia.com, wayne.lin@amd.com, 
 roman.li@amd.com, timur.kristof@gmail.com, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Thu, 18 Dec 2025 09:00:47 +0000
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

Thanks for the review.



You=E2=80=99re right =E2=80=94 I should be using adev_to_drm() instead of a=
ccessing
adev->ddev directly.
I=E2=80=99ll rework the patch to:
  - use adev_to_drm(adev) for drm_* logging
  - drop any unrelated changes



I=E2=80=99ll send a v2 shortly.
