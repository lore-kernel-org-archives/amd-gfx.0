Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C15F4CD6E74
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Nov 2025 14:53:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4BF9A10E820;
	Thu, 13 Nov 2025 14:53:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="liWHr7dJ";
	dkim-atps=neutral
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com
 [209.85.218.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 452F610E820
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Nov 2025 14:53:36 +0000 (UTC)
Received: by mail-ej1-f53.google.com with SMTP id
 a640c23a62f3a-b73161849e1so148143566b.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Nov 2025 06:53:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1763045615; x=1763650415; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=2KuY4uk9dx+SEK4R72zOc8sDn7Cu3S//j0y0j/oIKkY=;
 b=liWHr7dJWqs8+xMVtdKDuVNdTdioArAPEJpe7DMLwLZ/RV51TBmgat7SvtRBnvLHnn
 oqwaLTlHruy/tmJ/8tdYP0uYlbRoGvg7YN7gw8cWLWjvuh940hAZjEkijLWiu4nl/Dyr
 61Es/EoTiSA6KiK7fimuncERP5rTMWLb4+oV3GoCyVu63rnR4J+6tKXZosSWSX2/A/cw
 OCWVC4B7K3udaHpSlZRL4RwvI+/Xl1qJ925KQ2jegbVJ6QQ3aGh8mi7ioFSv9lxtpCd6
 9gL2VnnuCTUI+AewAL1APW53YsujfYg4X7qpppCc4Y+j+KAOS3qY+4EAh/7lJUou3Z/9
 PyuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763045615; x=1763650415;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2KuY4uk9dx+SEK4R72zOc8sDn7Cu3S//j0y0j/oIKkY=;
 b=r8J3QYIsi32fIZl8QZWAiLcw1GHCC+vg3cfBo3l8iabHxmTbDgl5vLUlzBjLkVJRL9
 LAGwSK9Qe9kNiCM5qW/ACGRRGOTHChfUVcR0UzrB6SGHBTOf/N2zfGeZHWrTGcofG3QZ
 XqNkNmX6nxdJeSDHCeyJcain47pN3ugT4hl4GRc89cwx3IBKAYL4k6gH8baK3jpLnVtu
 uX/H/B6gkIicxvZ/3DIkEDyYhhr1aNTxe/MbRJsxQLU9YjD/r9KinDnXx1OSF1uFbr+f
 ZA9/u9KBf5+om/fJcGMDlQtEC1hzkHfm5Ip67t2qG1onNmn6lXtOlR7IcFs5l0hbh3Oz
 AS6g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXk8xSLZCpgUDQyErCvJBdhohgCKND1F8NhJsASLQqOCdvY1eeaWNN/AEMeZXA8lgBMs/Hd4+oH@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzYcEMJobyhc1d7+dHFEqk3b5Pr0IADRDfNwQdK+HPcMKQ+xFFy
 VjXtHLOEXx2FKyWjscL7lOOdr5La2mVjI1Nf9ya+0kcNx4VIudoCFqoT
X-Gm-Gg: ASbGncs+sV0/asngjiVpR2rcxmSBEhexmSYUvAyZ3KEv9ZcdDopR6FVxbigjrK7+//o
 S8+oK4z+z6tjiDNMSHUUPjKRE3/gDTHqZ4my4qAHeiLT1JnW7hzzFyuLCp/TrlryFA+zgjjoGT6
 TwkHeekuIBUbiMoaJVZXtVCmHpPTVVu9+4Rf/b8rhTALRjej87tDP+tz9kFCCMulhmmZ/VFOKEo
 wCMsTWPAohLlJbNxI1a2bWPOeG1u8T2WxLF2gtw4kp9ctYFX9u2l9dTAA55X6BxG6g9DxrGteaK
 sVzKAs1TrNr5FvsAoBeu9ZYh0Hq73SzdoTiH0Elcbegj9jzzMVbh+U1EbCi2I7cXfTqLZHVadW1
 jMuEm38DBtlFZ4NIIW8yi6SVYqW0fbrfWmJuPHR7o4NtmMKfzm7j7YoMhnTdRpO4AgelTkLZxsR
 kYEncB0H1W6PY=
X-Google-Smtp-Source: AGHT+IE17n8JQmz8ZzOanQPyu0ficEa1gOkY5xc57eixhccSjQy8+v1v9r9GRlWtfqrRxGWCG8nk1w==
X-Received: by 2002:a17:906:f597:b0:b04:32ff:5d3a with SMTP id
 a640c23a62f3a-b73317a7930mr732977566b.0.1763045614394; 
 Thu, 13 Nov 2025 06:53:34 -0800 (PST)
Received: from able.fritz.box ([2a00:e180:15aa:c600:cef:d94:436c:abc5])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b73513b400fsm173747166b.1.2025.11.13.06.53.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Nov 2025 06:53:33 -0800 (PST)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: phasta@mailbox.org, alexdeucher@gmail.com, simona.vetter@ffwll.ch,
 tursulin@ursulin.net, matthew.brost@intel.com,
 dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, sumit.semwal@linaro.org
Subject: Independence for dma_fences! v3
Date: Thu, 13 Nov 2025 15:51:37 +0100
Message-ID: <20251113145332.16805-1-christian.koenig@amd.com>
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

dma_fences have ever lived under the tyranny dictated by the module
lifetime of their issuer, leading to crashes should anybody still holding
a reference to a dma_fence when the module of the issuer was unloaded.

The basic problem is that when buffer are shared between drivers
dma_fence objects can leak into external drivers and stay there even
after they are signaled. The dma_resv object for example only lazy releases
dma_fences.

So what happens is that when the module who originally created the dma_fence
unloads the dma_fence_ops function table becomes unavailable as well and so
any attempt to release the fence crashes the system.

Previously various approaches have been discussed, including changing the
locking semantics of the dma_fence callbacks (by me) as well as using the
drm scheduler as intermediate layer (by Sima) to disconnect dma_fences
from their actual users, but none of them are actually solving all problems.

Tvrtko did some really nice prerequisite work by protecting the returned
strings of the dma_fence_ops by RCU. This way dma_fence creators where
able to just wait for an RCU grace period after fence signaling before
they could be save to free those data structures.

Now this patch set here goes a step further and protects the whole
dma_fence_ops structure by RCU, so that after the fence signals the
pointer to the dma_fence_ops is set to NULL when there is no wait nor
release callback given. All functionality which use the dma_fence_ops
reference are put inside an RCU critical section, except for the
deprecated issuer specific wait and of course the optional release
callback.

Additional to the RCU changes the lock protecting the dma_fence state
previously had to be allocated external. This set here now changes the
functionality to make that external lock optional and allows dma_fences
to use an inline lock and be self contained.

This patch set addressed all previous code review comments and is based
on drm-tip, includes my changes for amdgpu as well as Mathew's patches for XE.

Going to push the core DMA-buf changes to drm-misc-next as soon as I get
the appropriate rb. The driver specific changes can go upstream through
the driver channels as necessary.

Please review and comment,
Christian.


