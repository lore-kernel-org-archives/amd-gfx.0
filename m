Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CE6710FCAE8
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Apr 2026 18:19:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 01BD910EEE3;
	Wed,  1 Apr 2026 18:19:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="CnEazit3";
	dkim-atps=neutral
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com
 [209.85.221.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8370210ECB4
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 Apr 2026 07:14:50 +0000 (UTC)
Received: by mail-wr1-f45.google.com with SMTP id
 ffacd0b85a97d-43cf8fe9c2aso1819362f8f.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 01 Apr 2026 00:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775027689; x=1775632489; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=I1Zg9qefULvMA0VEY6YtWmjW/Qd6isiaJ36QEzyOFMw=;
 b=CnEazit3bQic2kmIdFHYeC1ATkmGO0ki/EuqfpHql4OrHfjIsZNAfnkAoHuzaUqtOH
 n4laUcmE5QKIpoAN8DQUiV45SZnd+AjuoS0aGqv847/G9CEOe8cx6t5aaRgN+qhmhxFd
 G1Nmnze2XSeU0r0w9DccgjlGmvH6SlpSoHx3h3rLoxqEr4FCEn2y9WZRMdJxGFpc1W24
 0Q/DxMC+hycEE9njin2BBbay8kN44G5ey6zWkpope9aIk5rRnD77VS9LG09mOpRIMMzV
 hop4EbOI42sgp6WEwEsKn+Pcly1cSHKlBHx3QWYvMlKxhDMgU848ASeje9fujPsoXq2o
 v/5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775027689; x=1775632489;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=I1Zg9qefULvMA0VEY6YtWmjW/Qd6isiaJ36QEzyOFMw=;
 b=dFU/L5oRIEmWTPdk79OyiQYDmDXeMFxjT1vkCFn7N/GiJvG6Ftf0beL2EZjyNvBT3D
 eiVHJyyHKkRxEBrw74o3vxZWFPx37rqrk1wvAj2hqkcNMYFscsG9SyXmYa8JhpUdq3/o
 3U9Q72dg2O5zyJpmh6fARuLPu1ecBuBjCTbfQWfCGz3Dv7/wE20t7ko2dPRAC5TWvjnX
 cNcaW1m1uhPD86XOfRcYDDC11JJrE1tuYpqI3ZCtM6AX37faizQQ4R8BoKw7ZQmOdzwr
 HEXPpWaGD4qutJD9zIaA/TWCCeWloVygr+Zi3D6p2wEFCRMBp/MxrkLsLwN7fO+Ylp0u
 5Hvg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVrouFqOlxA1xR25SUnGt2nnKmCt2rN+fplQ/3LxheENRLoxBamSY+00UiSzDi0jCfnEkc1bntu@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyQnaFVVY3Bk+Cxnr58ppWKOpxn0yT1NK3Ly9mGMyh6INbb+QK0
 c97F0CIShtqnvDj0lyGu/JwWzP2lip/GMraFrQXN6irJBo3B7uENB2h6
X-Gm-Gg: ATEYQzxhWuEs2WBHEwUpivTs2XnIh+fafg1Y2Zd2MOq4Y4os6amoCw+mWN5WDXQ2BIN
 SgiMrtcQulgNr16mRBhZ6bC19nO43GkITm3ol7o24Qcyp6gDfRTzdpi0qPoN9Bjp8HmErhogV97
 ZYnrAO66kJ9qWUz5CTYsVB4/MlU+YhqeM2Zhm20WLzalVyluMsAhO3YFCfFMRsYdZyXz94aagiu
 jb6SoaWDgFKT/s2iRb3LD6uzBuK0tTQMtItmDFR424v3ErLisd/h1sx631eSUN4GVIXI8V36nTw
 XmNA7JD9C75SwaUjEcJkigM/+aCEipKVr9h7O1LDS3aIi7Bb4Fb2pEPUhMx1dJaiLNdE3yRQzxx
 xsCJ2zH/KxyLJnFfTEphlmK05H4LFR68ALgoWP2VlbcgXgBGRo1Z2l1L9AQp2uoogdyb8bCFfkQ
 Ro8zHblIOf98SUxWdIy1/kyXtKaEfJfaw0gMoKwRoBAshZh76oGl0aozJcrpI=
X-Received: by 2002:a5d:64c5:0:b0:43b:95ec:992c with SMTP id
 ffacd0b85a97d-43d150b87c3mr4337989f8f.23.1775027688724; 
 Wed, 01 Apr 2026 00:14:48 -0700 (PDT)
Received: from ionutnechita-arz2022.localdomain
 ([2a02:2f0e:ca00:8f00:8f20:93ba:1e9a:9f08])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43cf245e2f6sm34598225f8f.18.2026.04.01.00.14.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Apr 2026 00:14:48 -0700 (PDT)
From: "Ionut Nechita (Sunlight Linux)" <sunlightlinux@gmail.com>
To: ivlipski@amd.com
Cc: IVAN.LIPSKI@amd.com, airlied@gmail.com, alexander.deucher@amd.com,
 alexdeucher@gmail.com, amd-gfx@lists.freedesktop.org,
 christian.koenig@amd.com, dri-devel@lists.freedesktop.org,
 harry.wentland@amd.com, ionut_n2001@yahoo.com, simona@ffwll.ch,
 siqueira@igalia.com, sunlightlinux@gmail.com, sunpeng.li@amd.com
Subject: Re: [PATCH] drm/amd/display: Wire up dcn10_dio_construct() for all
 pre-DCN401 generations
Date: Wed,  1 Apr 2026 10:14:46 +0300
Message-ID: <20260401071446.91826-1-sunlightlinux@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <22eb66d8-b74a-4e0a-9851-7e39c7f950cd@amd.com>
References: <22eb66d8-b74a-4e0a-9851-7e39c7f950cd@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 01 Apr 2026 18:19:20 +0000
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

From: Ionut Nechita <ionut_n2001@yahoo.com>

Thank you, Ivan, for picking up this patch and for the review.

If any issues come up during the promotion cycle testing, I'll be
around to address them.

Best regards,
Ionut
