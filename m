Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D3E2C25B76
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Jun 2024 11:44:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C2E6510E5BB;
	Tue, 11 Jun 2024 11:44:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="SDKYbABv";
	dkim-atps=neutral
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com
 [209.85.128.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3884C10E5BB
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Jun 2024 11:44:03 +0000 (UTC)
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-4217990f997so26812935e9.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Jun 2024 04:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1718106241; x=1718711041; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ipFKgK5brd43vjaNU/5crwam41epHE8cJX3R7ka1/20=;
 b=SDKYbABvGi0VVQrD7ZE2LuFShucoK3qnzJp5fcYb5Kuti1li1dxffNS70VTZOR+DZc
 VGibMmQPe2u0kAV5ISgd+8CVc8s6HaTiuBbJ5CXpiUIlZEeC0+OLQ7l5BHD3ecnvb91W
 x71HkojtKIBMJQS/sX5xPOtWvDE8rzid97k4G//L0601zN1IdBNDJpRDrHQUFro2MV6M
 Ki1o8hDJ1E22k1JNnfgOgu801RIZLC0YhHVndbUDTmTN1CJvwvFBwCJIovJzlSfuFsWw
 JuuZ2mFKOJ+VFYrfXC3h2LdRIjBvLolW4TGPcRR9HYoytbb7PbO0SyaHHWRgbWD5/+y3
 ljSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718106241; x=1718711041;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ipFKgK5brd43vjaNU/5crwam41epHE8cJX3R7ka1/20=;
 b=fyOyLct+fylhW9nWlAW5On1tMcPF68/3j3+7V+NOemP8Cvgpu32hw1gqI8QABdNElN
 DQWjGjnPqwtW2bv6IusjhJ/fMejyKMD8pExm/6SGHqlulTX+hBZzz29oaVNcOooqBT36
 NQjozk9l2i5Xwl/F3qhwQ+wthUz/68nFRZx0BBb/cw4EObZUlY2hjow0+wllFLB01Ceo
 APV/A8pjmChtIWbeaeO4Q3UCAjokmJ1sr76+oLCoIOdCld+UgI3Y9g9Oxr3Gdcj404Bq
 2xWfykawD+e+9iJ1qfF6bN1ncIk+QucgwSLKJfE6dVcXD6l+FeU3AWpA0kNK74qnvFgw
 qwzA==
X-Gm-Message-State: AOJu0YyZQ9SstpW2JD5TIp1HhFBsuqTvBRJlg5eqiZ31vp8muW01P4Qs
 Rs7NTSnssJttQdYLAicHNxy2E/Ckt3GH3NvZ59BI1HbfkIx4AyTq
X-Google-Smtp-Source: AGHT+IEbEpH35xE/ZqDsIuRbBoneM7ctH2id096/+sf96oPo4FxqW0GS5cClNt0u5jfRNvfxeOKD2g==
X-Received: by 2002:a05:600c:4450:b0:422:13b2:584 with SMTP id
 5b1f17b1804b1-42213b2073emr33869355e9.37.1718106241229; 
 Tue, 11 Jun 2024 04:44:01 -0700 (PDT)
Received: from able.fritz.box ([2a00:e180:150f:5400:ff5e:7fcf:f525:27f])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4217c59be82sm114610895e9.0.2024.06.11.04.44.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Jun 2024 04:44:00 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: Alexander.Deucher@amd.com
Cc: amd-gfx@lists.freedesktop.org
Subject: Fix for reserved VMID handling together with gang submit
Date: Tue, 11 Jun 2024 13:43:56 +0200
Message-Id: <20240611114358.1774-1-christian.koenig@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

Hey Alex,

I've worked on this back in January but never found time to finish it.

Vitaly already tested the patches on the CI system with some test cases
back then.

Thanks,
Christian.


