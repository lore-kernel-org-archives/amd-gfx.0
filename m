Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DF07E99046
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Apr 2026 07:07:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F1B7310E8AE;
	Fri, 10 Apr 2026 07:07:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="HudpbZAo";
	dkim-atps=neutral
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com
 [209.85.128.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B270310E112
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Apr 2026 06:51:52 +0000 (UTC)
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-482f454be5bso17445735e9.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 09 Apr 2026 23:51:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775803911; x=1776408711; darn=lists.freedesktop.org;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=RJ5SRBZpbdL/GJFHQ8bYlck4jvpUNx3WyiuwmBRSeI8=;
 b=HudpbZAoMsrBzm2r5LNnyA4JbJed2n7yQRzsALDj6I9fjpiY3cpUtAS1dXG05ZV4T1
 FlCWz10divm+xgR7XWwlWHPSekBbtbhBjj9zAhgFLueYA+tlaH2hNrYR7rankqCBHPXI
 1qEkBFebkR+5QBl8PSiT6mePebwcuUxItPIeuf6FNncg7LPwvcWbcgId4yQlGHid47v4
 yqDAPNDkN9FpDx2uu5CR8lyDyaNQt7v6v9XKPxcjOGMdTZ66XatXFGK3i4OL5XIJVY/B
 p7fYlSA5dqQdZqkUkAkCFlzFTW8W1zaBjKj4bqyi9BmjulpzsmCjYl/4fdXddXOfGINX
 VO0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775803911; x=1776408711;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RJ5SRBZpbdL/GJFHQ8bYlck4jvpUNx3WyiuwmBRSeI8=;
 b=PVcQ45pJdvUQtiqPEUnmtcayzd2DSznzTHAhZUcfKx6lx+z9SjuP2dcPKbDy1RReMf
 WF16ChYw3M3jJyyxpA6fKQqYHkF6yaCbxGCj/7vNNVz6VyH9cy5oZUCsaCWvw85lvboK
 CvcLF9AfAHeIYH/uxOFjEDqr8fc+cW3K1eXb/rMBjWkimKnLpP8JFM4NBk8qVOEyw1Ml
 WrN7eL0rjmSAP7kLqzWhFLj9vDsBsNCqfmDWiNKpInKTKYuynUHBxWN0r80OtXgaIzoo
 hepyFrkHjOGTWp9lKoD9QEnB1GMse8L1snkhu5HK9/jRe9XjGFvVMdAegc7Kn1ZA33+j
 zeyw==
X-Gm-Message-State: AOJu0YypLBcXguhKJ6vh0DQHc4osT76hvX5gI6ZvuOyggykfsg9BkLhD
 wxniIr66zl9A5iOlMTBgn0ndJO++VxGSZi1XkxdPXObkPeS8PNwM91RTV4Z+pJ9H
X-Gm-Gg: AeBDieuBf9br8+GhsHtCp0cnHA6yQMpwDEja5wXuF7vSbtBUUfNiVUft2kdhTtLo4AA
 cOfRw5L+Y88gu3MpdkLT57dp8+34mjgrDanEZ+XZIaZxkMcq9tMu41clJshpfhUMTXGrcV0q2sE
 mBGxouqzbAlGJZhs0WUKzNSfdlYv07sqluOHxckuAQgid2i9vtvuJAjGPc4hlqHk5zs2kMKP6hj
 M8u6BB68pPuukjNQARMqAwaTUr1JoA+w63VZhgNA7VB1FnxJKUJ/g5xVzB/jncorZrbHbrsgV+2
 h7UMVQx+roZg1vqhK/lURR0H8se/3pbM4iicJFsaYK/IN5NPZjSvDmAr310ZAEeQ2cJcIyrvYIa
 MT0bBOqr8z8wi73ZizyExmmitZy76WUv1XZr07ZkZcCvkM0wSCwFh/u+uCHB9TrCVFi9uMmUdXq
 JHacyoCUhhvdmVbTiJc+0=
X-Received: by 2002:a05:600c:c10c:b0:486:faa8:9e4 with SMTP id
 5b1f17b1804b1-488d68cb8demr12482345e9.12.1775803911132; 
 Thu, 09 Apr 2026 23:51:51 -0700 (PDT)
Received: from localhost ([196.207.164.177]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488d67e685csm19689115e9.6.2026.04.09.23.51.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Apr 2026 23:51:50 -0700 (PDT)
Date: Fri, 10 Apr 2026 09:51:47 +0300
From: Dan Carpenter <error27@gmail.com>
To: Jack Xiao <Jack.Xiao@amd.com>
Cc: amd-gfx@lists.freedesktop.org,
 "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>
Subject: [bug report] drm/amdgpu/mes_v12_1: add mes self test
Message-ID: <adieA8FBJYs-Dwh7@stanley.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailman-Approved-At: Fri, 10 Apr 2026 07:07:32 +0000
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

Hello Jack Xiao,

Commit 44e5195fa3d4 ("drm/amdgpu/mes_v12_1: add mes self test") from
Jun 11, 2025 (linux-next), leads to the following Smatch static
checker warning:

	drivers/gpu/drm/amd/amdgpu/mes_v12_1.c:2080 mes_v12_1_test_ring()
	warn: reusing outside iterator: 'i'

drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
    2069         atomic64_set((atomic64_t *)wptr_cpu_addr, wptr);
    2070         WDOORBELL64(doorbell_idx, wptr);
    2071 
    2072         for (i = 0; i < adev->usec_timeout; i++) {

i is counting usec

    2073                 if (queue_type == AMDGPU_RING_TYPE_SDMA) {
    2074                         tmp = le32_to_cpu(*cpu_ptr);
    2075                 } else {
    2076                         if (!adev->mes.enable_coop_mode) {
    2077                                 tmp = RREG32_SOC15(GC, GET_INST(GC, xcc_id),
    2078                                                    regSCRATCH_REG0);
    2079                         } else {
--> 2080                                 for (i = 0; i < num_xcc; i++) {

and then re-used to count something else

    2081                                         if (xcc_id != adev->mes.master_xcc_ids[i])
    2082                                                 continue;
    2083 
    2084                                         tmp = RREG32_SOC15(GC, GET_INST(GC, i),
    2085                                                            regSCRATCH_REG0);
    2086                                         if (tmp != 0xDEADBEEF)
    2087                                                 break;
    2088                                 }
    2089                         }
    2090                 }
    2091 
    2092                 if (tmp == 0xDEADBEEF)
    2093                         break;
    2094 
    2095                 if (amdgpu_emu_mode == 1)
    2096                         msleep(1);
    2097                 else
    2098                         udelay(1);
    2099         }
    2100 
    2101         if (i >= adev->usec_timeout) {
    2102                 dev_err(adev->dev, "xcc%d: mes self test (%s) failed\n", xcc_id,
    2103                       queue_type == AMDGPU_RING_TYPE_SDMA ? "sdma" : "compute");
    2104 
    2105                 while (halt_if_hws_hang)
    2106                         schedule();
    2107 
    2108                 r = -ETIMEDOUT;
    2109         } else {
    2110                 dev_info(adev->dev, "xcc%d: mes self test (%s) pass\n", xcc_id,
    2111                       queue_type == AMDGPU_RING_TYPE_SDMA ? "sdma" : "compute");
    2112         }
    2113 
    2114         return r;
    2115 }

This email is a free service from the Smatch-CI project [smatch.sf.net].

regards,
dan carpenter
