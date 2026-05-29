Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B56ECD6E4A
	for <amd-gfx@archiver.kernel.org>; Fri, 29 May 2026 11:40:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A70EE10FDB6;
	Fri, 29 May 2026 11:40:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ohuC1wz+";
	dkim-atps=neutral
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com
 [209.85.221.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ED93A10FDB6
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 May 2026 11:40:35 +0000 (UTC)
Received: by mail-wr1-f51.google.com with SMTP id
 ffacd0b85a97d-45ef56d9b67so143481f8f.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 May 2026 04:40:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780054834; x=1780659634; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=A6u9YQBx5a51F8fm8zqzaMdB1I+HWop/Y2OuGryekEU=;
 b=ohuC1wz+oGzDctTKwpVKEz1PkUqSwKuwrdABqjGPnRSClqPBrQdnbCTroM0w6FPfIg
 5EuRcH1HqhhM7iC1E6IxhkfDiHr+4vB65xCsE1DOPzqLzuvUmHPU3latDS7d69++9FQc
 VjI79g5IJ9NP7Md3tGJ4BVkuv3ofSuEufhe3MkTceEu/QmUAQjR96EkRVvq+Xzp5iSQP
 xTINmm/mSdbt6gkJDXfDz1epbzeONJR7x1zY20sas2qJIoYHF0hy5bjkQkxPFwwezFL8
 fsCe9Gdgx9KpZTr9vB3UtCNjGZFyrE9BR61exMTdySA4VW+jJOuinFL7EcRzlRNA2iki
 bspA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780054834; x=1780659634;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=A6u9YQBx5a51F8fm8zqzaMdB1I+HWop/Y2OuGryekEU=;
 b=mGgxD0urYyc6PTMzBVod0MQjntUh5Qekz64WPkgfGGlKIZGJkzlbczD4q1PCRtSeFT
 JDjc7u8B8zVHQ9anKi2l0otSXMjAT1GPQ/LpZ9TpzjwZeBFXOVKRC04kYC7OcP7TUFy5
 0Dtb/TjHbtihFKqAV3gIQBmWMJ6lKzcbaFpkWyRE0K6HlqtWOe6nBusdLG8/ckQCqIlM
 XISsm2ZH9MCEW+ALLXY9Ts4oXbyi0kUCvnXhl2+WlOl+b2D787tjVTbZIZbwa0viXPSi
 ZAl6K3CVv8bX1Ri2zWaCRoGFrTC30vmOSFicVAvLxR7/co6j3qAYHDAbFKWxVmUWOU2n
 JTIg==
X-Gm-Message-State: AOJu0Yzz9NYSZ73W1+nP53LqGhiLNN9x+4n11pCmsXELz/vqssKpx+J4
 aRmF30lZmF6e2I3HsCg3bqzijyJbu6VNZU6DFT4+8Efhltrlu2Zf4gnx
X-Gm-Gg: Acq92OFZpX2tOht7UBlrtCdC2bNdb7S2ygj2IsKJYos9dvllj8e07MJdVihAK4o+F2g
 II1j4zrX6Bz0KNgFn0F1AgN5Os8OGDOTSrQxfp2ELGTMhnCoRbKvNz0l7bEDlugio+ZTv/p0wfo
 lUICOa6kJEfZfSd/cjJ//GfSJUkmuJuSKKeut2+MEAyv0WY5YiIFR6JesFAx7GSjyQJryM6jtGN
 Z2mbdaYmUl7K7E7gPJu2YP/yeWVV7JfpRRY5TlAcP0uHrJEuA+mlP3cvzBSEF0yUotI9ZPfGjIZ
 WHTzswCkZk0gpTFjZjvJV+zfgN+1J49gXb5oTFbqkaC7Skg2onF2cwdqoPc0iHIsFUTQSLXiGJ7
 gP9eP5yJbRz+zAznY66s1lKVSOJo8+DVAMgNDiTmg42AgsIeCTPLJAxxnusqgfjSGsy8j+7BfEn
 YuYDNZQggrMgvlkXAmiGjIeLB+3j6kFAS3PgMaO7Esx7s=
X-Received: by 2002:adf:e008:0:10b0:45e:e44b:312b with SMTP id
 ffacd0b85a97d-45ef1444276mr3126155f8f.18.1780054834223; 
 Fri, 29 May 2026 04:40:34 -0700 (PDT)
Received: from able.fritz.box ([2a00:e180:1544:8100:da55:fa26:bd:a26])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45ef354cf0dsm2993109f8f.17.2026.05.29.04.40.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 May 2026 04:40:33 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: natalie.vock@gmx.de, honghuan@amd.com, Alexander.Deucher@amd.com,
 Felix.Kuehling@amd.com, Philip.Yang@amd.com, timur.kristof@gmail.com
Cc: amd-gfx@lists.freedesktop.org
Subject: 
Date: Fri, 29 May 2026 13:24:02 +0200
Message-ID: <20260529114031.3714-1-christian.koenig@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
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

Hi everyone,

this patch set aims to fix a couple of problems we still have with the VM, page fault and HMM/SVM handling.

First I rework a bit what we have on headers/defines for the suballocator, especially that the right GFP flags are now used for GPU reset and graphics page faults is important to avoid hangs.

Then I rework the VM handling, especially splitting up the amdgpu_vm_update_range() into an amdgpu_vm_map_range() and unmap_range(). The later is only meant to be used for MMU notifier/HMM/SVM use, but I couldn't come up with a better name.

And finally it fixes the problem with KFD SVM that we can't properly allocate page tables under the SVM lock. The missing piece here is to remove the SVM lock and rely on the eviction lock of the VM for that.

Timur & Natalie I've put you on the patch set because I know you have page fault patches in the pipeline, it would be nice if you could apply this set to amd-staging-drm-next and rebase your stuff on top of it.

Honglei and Philip this is basically the pre-requisite work I have been talking about. Please integrate that into the new SVM patches and re-test.

I've only did some very brief testing, so something more extensional testing is clearly a good idea.

Thanks,
Christian.

