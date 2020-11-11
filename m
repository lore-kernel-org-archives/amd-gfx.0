Return-Path: <SRS0=tzQw=ER=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DB3DC388F7
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Nov 2020 02:48:41 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 06AEA2168B
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Nov 2020 02:48:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=basnieuwenhuizen.nl header.i=@basnieuwenhuizen.nl header.b="Ba+5goXK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06AEA2168B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=basnieuwenhuizen.nl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2A83689D77;
	Wed, 11 Nov 2020 02:48:39 +0000 (UTC)
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com
 [IPv6:2a00:1450:4864:20::444])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A610489D77
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Nov 2020 02:48:38 +0000 (UTC)
Received: by mail-wr1-x444.google.com with SMTP id r17so1028528wrw.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Nov 2020 18:48:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=basnieuwenhuizen.nl; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=GDzXrS6xTQ6WhlvyVfYd5jt/U6Kj/uFhRtaV4t83c8w=;
 b=Ba+5goXK00cxmKf6aVhyU0HPwPwWgBUUuBTe1BwIxCZvzxY9iMZFq/vo3FOixQwW4Q
 n4stYgGxBVSDnnnU8IK041XsJlkS54GDTA6jZ5cf5jVZ0BrAFy7O/JGBTt1KbES9DHtt
 W28JAwKKZDfjd1WCFyg5At0b6A739Oi7lEd4KehRws31pkw8W+C0BjqB90S+kWAiq8M5
 v9S7ZE2m/Lz7t5dEhnP4P+1oXRqPKMxpuG5HXDWN6wn/DkljHaeKI3zEykTF9E57MbAe
 hW+KUBFDSRQ3rbytqQ/GyWRn2QrLhmsebOiCBtdu/0MBhzp3RRzB+8D1BcG/LHDyOd0Y
 c2RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=GDzXrS6xTQ6WhlvyVfYd5jt/U6Kj/uFhRtaV4t83c8w=;
 b=Vr1+/DuhO4FLuyCWWIeZR4R9eXwHR7gsB6a5aEOsKjbdg5UbtU8zNXCKz7vykbDqU+
 fAVu2RPZ+kjwVsbV50pV7WtmHH/8AlsaEnSBAj+41S56G5Tpk7G95IaKZ6XASQpZJYNU
 NhFFA1x6pf/mXXIKU9gDKUuxfB5VyMwix++QmUxCMDItwn4udT7AhbUtMc+Jgtt96XBt
 W0Gqsk4OX0SsA/JOLynJj7ynyJ8/dU9K/HmahopPlXaSicLf7yJ44D20hGpzrkd6/CFg
 y0BJ26sf9RYMK5CBpWX7NrGEho+FQcoJcvtRjyQ1s8UX0RrwK5temcBXUVh6ag5RJUEk
 2HXQ==
X-Gm-Message-State: AOAM5316ADL3sJOMWVH3rnnVV8gYWQEvi2DeDKeUkcxMYB8GMMSxQYb3
 l+M7RlOhNAmoS9SGQmyNIPLFIPdLNEXChPkZ
X-Google-Smtp-Source: ABdhPJym8v7F+nyW07cwxBIfIpiOdghKshiABu+lWNp3DLEvOOkPab678Uf2SXv8zJ8JZVMr1hEwrg==
X-Received: by 2002:a05:6000:1d2:: with SMTP id
 t18mr1451040wrx.14.1605062917080; 
 Tue, 10 Nov 2020 18:48:37 -0800 (PST)
Received: from localhost.localdomain
 ([2a02:aa12:a77f:2000:4cea:81e7:5fd4:93f7])
 by smtp.gmail.com with ESMTPSA id c185sm724498wma.44.2020.11.10.18.48.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Nov 2020 18:48:36 -0800 (PST)
From: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 0/3] amdgpu getfb2+modifier improvements
Date: Wed, 11 Nov 2020 03:48:37 +0100
Message-Id: <20201111024840.496679-1-bas@basnieuwenhuizen.nl>
X-Mailer: git-send-email 2.29.2
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
Cc: alexdeucher@gmail.com, harry.wentland@amd.com,
 Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This has some more improvements for the addfb2 code in amdgpu.

These patches make ffmpeg work with DCC compressed and YUV surfaces
with kmsgrab, both in the modifier and non-modifier case.

Bas Nieuwenhuizen (3):
  drm/amd/display: Store gem objects for planes 1-3
  drm/amd/display: Set new format info for converted metadata.
  drm/amd/display: Extract 3rd plane from metadata

 drivers/gpu/drm/amd/amdgpu/amdgpu_display.c   | 211 +++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_display.h   |   2 +
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  88 +-------
 3 files changed, 207 insertions(+), 94 deletions(-)

-- 
2.29.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
