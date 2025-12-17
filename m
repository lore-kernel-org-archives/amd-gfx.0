Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48AC4D64099
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Dec 2025 08:54:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CD64A10E58D;
	Wed, 17 Dec 2025 08:54:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Kkv2rKxj";
	dkim-atps=neutral
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com
 [209.85.128.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1869510E0D9
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Dec 2025 07:16:30 +0000 (UTC)
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-477619f8ae5so41592415e9.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Dec 2025 23:16:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1765955788; x=1766560588; darn=lists.freedesktop.org;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=QBNEh/Q+8Cj7bGKHt6/CHAXFo4JFMP4SwRCCUU30DSc=;
 b=Kkv2rKxjdbbKa7Mdta1PuNfq2RX442TvTHXO3P4t9WBY8AV77bYNOiwON8lREAlarf
 nz0CnMk5Mm3/vPXIPdZcSP1kkPauBTcJCzZZz/yw5EpBq/Fv6rxNlwegqCW0RN+uSGbu
 JGQUul9B4cPxzkjNSlsqTHWmwf8qrewWvbi89yQS6GqCh/UIfZnwf5xv5lRP1bYk4+Y2
 SOobmrC0o4wdzdtpscDqKGgoblsof9EXV6ec2lmFzX13/c+6g5Vene+rXNuGkcNFMWs7
 EXBs/+OvBNQJyR0fwFu3L7nnfoghmzIGD83AldUqYEtbhR+aaoYPwhMpNODNFL+QBtLl
 8T4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765955788; x=1766560588;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QBNEh/Q+8Cj7bGKHt6/CHAXFo4JFMP4SwRCCUU30DSc=;
 b=Nzo90R6ZpVThG5NrlWSanzDjo6Nn7LUC+8scDLjUl0S7ep+F2uahWLVaaZSqYuqEsl
 IQ0rfDZMm36yZVF9LDKqM4fBC5Irv2KiyfFMl/9tl5X9svTEBydQoYmPKXIUBEshxrNV
 6e5mZmdOmdqmYlRbgU4xt7tvkM2PVtQ6bVv3V6E8I8eGaX7F0Hd0LWsUW52bb1AMvH7S
 AhSBTqOr1PPkU20F+N+6bmv5JLG8wavPZZ5vEdpKSy2jAz57u1UnxH0abFerEpSPKp/c
 QOOvRdYzOnGEyk5rV53kB77Tvt91l5zeytTNXKVfcPKPzD8jWO2IrDyg93ZIbBYgkXmF
 t2oA==
X-Gm-Message-State: AOJu0Yyg/8cElP8CqNh4eDbTVujCFDFkV0qaITdjF0no3r1v/anTDVjE
 GBdumydb8Xb7TZ7m1qXXpO15+ZHudn3HWn7bYOCnrSui6CmXGV6153anrDzJSIKPvh4=
X-Gm-Gg: AY/fxX5S3Dtapzw2Ffx/Lf01GMTHOKsCm7y6Qp083AaRWuGY4FIOwWEoZYwc6FdzJl+
 Hj9wkZWalUv+V4GQPDcj5cxj3k0RcLbd3hOwCYoXDwTuO60dWY0D8bUwO3vu/Ld+GidaBawK0bE
 aLOAJEp8LD+4d16UT2fb7vpr8exVNkQODdAJZV/suHYYmdhU1DTvFa7wx9e5YQOxCds/EBSmuId
 DCdvx9kI5ZplKxS/pvv/WMW8CITd2AsmRPo3+3O0xUoSloU84pShtAohBGnpV/nNmwtQUWICjNc
 GrHH4DUKuCZDAnhZDQYOuE/ZJxNur29Xem4yjZDf75zOPq4BWGgo4J2H6PYgh5KWRcFM7qrr7zO
 PQqkW5SYeVW8I+AlXOvHYNSpf+t9EpCz45YTD4V5g79jHoyQDBw2saoZdGX3BQ51ZZsqPqMBYnv
 Pe0hVSNxtXDLh/qBScK/o56e7zlX0=
X-Google-Smtp-Source: AGHT+IEZXOoyoTaVFDuk8cTdOrTrttImCdvdvzvjV5QegyEIg3VY2k6xryOuxEGl8EipS43Ex0dkgQ==
X-Received: by 2002:a05:600c:1c81:b0:477:a02d:397a with SMTP id
 5b1f17b1804b1-47a8f89c91cmr161034025e9.2.1765955788499; 
 Tue, 16 Dec 2025 23:16:28 -0800 (PST)
Received: from localhost ([196.207.164.177]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47bd995cc3fsm23659395e9.16.2025.12.16.23.16.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Dec 2025 23:16:28 -0800 (PST)
Date: Wed, 17 Dec 2025 10:16:24 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Felix Kuehling <felix.kuehling@amd.com>
Cc: amd-gfx@lists.freedesktop.org,
 "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>
Subject: [bug report] drm/amdkfd: Fix eviction fence handling
Message-ID: <aUJYyFnyeGgC2iYi@stanley.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailman-Approved-At: Wed, 17 Dec 2025 08:54:23 +0000
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

Hello Felix Kuehling,

Commit 7e38ccb5276f ("drm/amdkfd: Fix eviction fence handling") from
Apr 17, 2024 (linux-next), leads to the following Smatch static
checker warning:

	drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_process.c:2099 signal_eviction_fence()
	warn: '(-22)' is not bool

drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_process.c
    2090 static bool signal_eviction_fence(struct kfd_process *p)
                ^^^^

    2091 {
    2092         struct dma_fence *ef;
    2093         bool ret;
    2094 
    2095         rcu_read_lock();
    2096         ef = dma_fence_get_rcu_safe(&p->ef);
    2097         rcu_read_unlock();
    2098         if (!ef)
--> 2099                 return -EINVAL;

This should be either true or false.  Probably true because presumably
it has been tested?

    2100 
    2101         ret = dma_fence_check_and_signal(ef);
    2102         dma_fence_put(ef);
    2103 
    2104         return ret;
    2105 }

regards,
dan carpenter
