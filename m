Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8418EFD207
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Feb 2026 08:31:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 04B2B10E6F4;
	Wed, 25 Feb 2026 08:31:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="lM1ZKmfH";
	dkim-atps=neutral
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com
 [209.85.167.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3731510E6C4
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Feb 2026 07:42:02 +0000 (UTC)
Received: by mail-lf1-f52.google.com with SMTP id
 2adb3069b0e04-59e4a04f059so7677253e87.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Feb 2026 23:42:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772005320; x=1772610120; darn=lists.freedesktop.org;
 h=in-reply-to:references:from:subject:cc:to:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nA6orqw1ilUvcxpwS693fEfzchG2J2+WvoJ8C1eqQSU=;
 b=lM1ZKmfHHC00GuzpbxNFYQFbKG9eKe+3F22yARoI/UmY41VFGHRuFz2uZbCB3EmAys
 slWx8Lc9gSFAUxG/j7RXfTvmxq14ad5CpyrwVXh2jL5KeDjHpL5MHFFvyjt2UTHh9qek
 2R0AZb8p3U0H0nSrQ1Rj0rpO9mmN3Ps1m31GXEhF8ks0MJH/F/doHtdpotyAOk4CZgNY
 tPm3gFaczp2R6zz3+oGTyjl4BlKYHO6Qxm7HGSfevcD+nCFn8V8VbRyRo9QkroKNppCM
 DtvovbqOUrkKGMBv4cpgNtqrh7gOb3doriITpO8aeawf1twqURIlgDVlgz8LmBgkaXR6
 JsBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772005320; x=1772610120;
 h=in-reply-to:references:from:subject:cc:to:message-id:date
 :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=nA6orqw1ilUvcxpwS693fEfzchG2J2+WvoJ8C1eqQSU=;
 b=XMHzKaNkACSfLM/mJRei/2QBiGBWVkZEO0uxRMZxYqIdjtg9KlglB7RjCsj8e8dIeX
 6EByZLYLU5GUjz6e4gEUP+bzRnv8jheEO8EEJyuugWK1A65GIXsEipdzaIzt6fkJOsTk
 2dTdsR8RiEKJcxszCxOlnNkU0n/QMlIrhTzgGu5HpZrvXHvoHTfRmVVIdqsOm8O9aDOD
 pLTX59UebEloEDH+Uo3MODfLsvSsfp1nkTcnwrz2r4bc2xTNpgmuTHmaBwHwClb3izxC
 /SW4O7T7ul3XBOtGS/OpmRfynLPg0ExyT139KokdnnLOlDkwOXlXcrZh6H8Mtfk4eihV
 9m5g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXvKQdRN/g9ytsS01QeriWd7ygrk518woNPkFJmgHzVjzV3BVeNsyzfMX38vSBNN9QaqIVzvWVN@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxcBA7QDPdrrHCTevAbq6EJLX0ZogzN90+/MqoM5kWuKdlLOXLO
 LTYKIzqG6jqoaQEQoddMNcqsmRP2gSZ8Bl1t18b8Yz6ZlADEb2WUOUE=
X-Gm-Gg: ATEYQzz2q3Ixj9svxn/rVvRw1NCGgd5G3pavV+1kwotBsu1l9scKqaV6AnQobY+2lz4
 +D8V7rjmkN9BbEOsG7YJL0JEh8mmbxrMZyCsqynmBUb/VDlfZ0w7CCEVS7FVsniyOBGHJ6VfQa1
 0o1qgCBRkUGglPvAPysiRLy+4XdtasVDc0WfwmvrQhhShQEOT3CzCQLI2gvhxquNE+gsnJ9AmaK
 wFgy6HNuvj/er3Lq9xw7SnGXdSWQAOChxVld78wNpmulpWBiuElY3Atgt9tW+RZYgLZcZC85q3K
 KF+WnLiPd61QsF9GuWOhUHOBk2CEis8xvNBqiH4445vqgA8scQbcJwWsvEf0eLpwguJVs1wB5Ii
 Wjo76zzG4zrB7UDyDYLqGAtcZaatuwOu3k7hm4OIqRWwYGSGL9LpqViZAY2xrxj16zAdIW8ptg+
 fsfhIlxys2
X-Received: by 2002:a05:6512:334c:b0:5a0:efe2:e8f7 with SMTP id
 2adb3069b0e04-5a1026939a1mr472592e87.5.1772005320173; 
 Tue, 24 Feb 2026 23:42:00 -0800 (PST)
Received: from localhost ([2a0e:e6c0:20d0:4f00::1d])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a103e98512sm156088e87.29.2026.02.24.23.41.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Feb 2026 23:41:59 -0800 (PST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 25 Feb 2026 10:41:58 +0300
Message-Id: <DGNVGLH1VK9K.LHA4SXPPH8PK@gmail.com>
To: =?utf-8?q?Ville_Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>,
 "Melissa Wen" <mwen@igalia.com>
Cc: <maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
 <tzimmermann@suse.de>, <airlied@gmail.com>, <simona@ffwll.ch>,
 <siqueira@igalia.com>, <mario.limonciello@amd.com>,
 <alexander.deucher@amd.com>, <alex.hung@amd.com>, "Ivan Sergeev"
 <ivan8215145640@gmail.com>, =?utf-8?q?Michel_D=C3=A4nzer?=
 <michel.daenzer@mailbox.org>, "Xaver Hugl" <xaver.hugl@gmail.com>,
 <amd-gfx@lists.freedesktop.org>, <kernel-dev@igalia.com>, "Jani Nikula"
 <jani.nikula@intel.com>, "Harry Wentland" <harry.wentland@amd.com>, "Mario
 Limonciello" <superm1@kernel.org>, <dri-devel@lists.freedesktop.org>
Subject: Re: [RFC PATCH] drm/drm_edid: ignore continuous frequency support
 for VRR
From: "Ivan Sergeev" <ivan8215145640@gmail.com>
X-Mailer: aerc 0.21.0
References: <20260223203528.213275-1-mwen@igalia.com>
 <aZ1YE6dcEfTMwly1@intel.com>
 <b6f267f4-812f-441b-939d-1ff24fd3406e@igalia.com>
 <aZ6iSdsTfzQX4_op@intel.com>
In-Reply-To: <aZ6iSdsTfzQX4_op@intel.com>
X-Mailman-Approved-At: Wed, 25 Feb 2026 08:31:40 +0000
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

On Wed Feb 25, 2026 at 10:18 AM MSK, Ville Syrj=C3=A4l=C3=A4 wrote:
> I see no mention of the model of the display. What is it, and is it
> really supposed to support VRR?

The display is DEXP DQ27N2. It has a Freesync option in the on-screen
menu, and it is turned on.
