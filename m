Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6487F606A31B
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Nov 2026 13:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=z2b4S2S7
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5BB9610E48F;
	Thu,  5 Nov 2026 13:45:32 +0000 (UTC)
Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8682010FEC6
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Nov 2026 20:02:10 +0000 (UTC)
Received: by mail-dl1-f51.google.com with SMTP id
 a92af1059eb24-1aefd1bf74aso1000801c88.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 04 Nov 2026 12:02:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793822530; x=1794427330; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=snH4D1yne3D/mpsYO+9jWAO5X0a2o/1BALUeP4JZhFE=;
 b=z2b4S2S7dCHAVIqPziUiUnGvsyS4K0YYbBQgdMNqO5PH09cwJPJWOPN2cvYwxRgpnT
 D/64ngDMooroJ0m9oOW58Kww49UDC8wQCRDdgZEG6g7TDq9wnJtNRjS/YcG9QswWfbpa
 4v/kiIXjb81z6bkraCLSlucp4AqDEk/Vb5Qh7xTePyXGd8yWyo05rAbnyz0d5t1zoyN/
 dHb/gNtrNhUlcGNOJKQaTZ+O7PNBnc2X0VOrzb8+1iYV1cLqvJKK8j/8Jy6x9fDPBVVV
 sWq58pZRyhbfEwCJL+VpI7/GXzeZffVjPoALPpGRP+saYhM8VPfnuytrJeubepDvSFtb
 LIeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793822530; x=1794427330;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=snH4D1yne3D/mpsYO+9jWAO5X0a2o/1BALUeP4JZhFE=;
 b=PcMVFbDVwxvA/gsXG4SZv/LHeQ3Z/6xydS3R51/PBM4hEVnb9GLYVNQuB04rgHEB+h
 cltOnVcsDB5Fq002GuUb1Hc+iCoqgF10bwmUEDFH746xYX3h/n4PqQzgiG2Nygr9IQ/e
 YMor7WAvY6YX3XFRRFRG1eoqnpqhWxzsC/AvUpiy49thi8nX/eucnRAyi4xnZg3ddN1f
 pC8KKYuSlk4wscd18p32uAGsId9Ji+A/0PGDEbsfcNBYXnROmke5a8wKscdmzAQJBVSK
 Xg+Vx2fAT4fGR9OK7IuyF8kyDQXXhDyBgZRWw1M0dUIyu9eFuQN5FhMaiy8NhHxGHTzQ
 gkOw==
X-Forwarded-Encrypted: i=1;
 AKwUvBy+Tj0jKQIzUedBR4CUekGiHD1vUw8DdRQ9ppA+IUmV0to4q3QugHOAfdObESGyGIfZmicp6yme@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/wLryeICpLH7SBy5eWZA3Q9uTPuFllQ1yzm1cOaNPfcC0Vxztg
 yIsCjoakr1Gt47gPsByfhIo8umMm1ezYNqVTBj8LTntmWHxLOtsL3qU=
X-Gm-Gg: AYBFou11SV246TU6dqA3jsPS6Q7stCJHT2IH1kD1hP4xfa0fdJLPhmq4MHY/YvyFq7p
 6O2NLktoyKYz+YpFLDEL2SYBKD/IRzhlzUPRvWD8EiHbx+6qkSeIx4JXrn8MUW3TyObu/Ex9Liv
 3x1GTWLl/GWrg9DyPCOq8zPHndXQgwyrH1epwnpzNXGXOS16REzJw/T4qYCkOvmDVB851unJMRa
 W7D0a9jsyhoxNJBvHMT8HQe5+q9dMEiyMhkyn/wSdZwphddrFGyFLRfVBzI5HbNnPY49CRSv1Sj
 f5LpFlHNrhBrwaMjDP7IK2GqrDtjnRrGO2YjC5pS5/J8mdRm1JYT7xRL9WEQACBc3hIkjd6u43f
 8o94tG4ThASq/tTFhL4a/Iyo+5FK+n/zW67+c+zZUbxEOD+77I5FPLZmoHyhdhYuolv02iwdtn1
 r7ZG0swjJh21lGAQlse6xckCBVkej0ZfbgLG9dJ8jGNg7VwUL1rfssRGMYBx3yZx3F2buDOt9bE
 BkKFzKsagDJABHTzfVll0cRwtsXSGeYEKq0H8qOqFs2DgpaeGe4ROmP4BnN1amDC8TDa6rfiGD/
 N1/guMMyftfiwzxDw2hMaUvLZvqPfteEQwwcMAYQcMXP8VqZvzoVBjsFUL8GLKxD
X-Received: by 2002:a05:7022:f90d:b0:151:7831:e403 with SMTP id
 a92af1059eb24-1b24f44df52mr534313c88.13.1793822529479; 
 Wed, 04 Nov 2026 12:02:09 -0800 (PST)
Received: from at-Standard-PC-Q35-ICH9-2009 ([106.194.66.249])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1b245c4706bsm12453149c88.15.2026.11.04.12.02.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 12:02:09 -0800 (PST)
From: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
To: alexdeucher@gmail.com
Cc: airlied@gmail.com, alexander.deucher@amd.com,
 amd-gfx@lists.freedesktop.org, atharvatiwarilinuxdev@gmail.com,
 christian.koenig@amd.com, dri-devel@lists.freedesktop.org,
 harry.wentland@amd.com, linux-kernel@vger.kernel.org, simona@ffwll.ch,
 siqueira@igalia.com, sunpeng.li@amd.com
Subject: Re: [PATCH] drm/amd/amdgpu: Add 5K Support for iMac20,1 and iMac20,2
Date: Wed,  4 Nov 2026 15:02:01 -0500
Message-ID: <20261104200201.8358-1-atharvatiwarilinuxdev@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <CADnq5_PjiWHEDzS5DJgB1wS72_tHp4Ju5Wwr0R0N5EK-i9fXfQ@mail.gmail.com>
References: <CADnq5_PjiWHEDzS5DJgB1wS72_tHp4Ju5Wwr0R0N5EK-i9fXfQ@mail.gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
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

> What's the reason for this change?

This is the code that fixes the SMU boot issue, that we discussed eariler:

https://lore.kernel.org/all/20261103160553.1431-1-atharvatiwarilinuxdev@gmail.com/

Its confirmed to be 0x4F1 as OCLP enables it, and with OCLP and no patches it booted fine.

I plan to add 5K support to efi libstub or something in the future, hence the TODO, so we
get 5K in simpledrm and get rid of this not good looking quirk.
