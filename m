Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AED3CCD192
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Oct 2025 14:35:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7817210E472;
	Mon, 13 Oct 2025 14:35:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="fUyKlPIP";
	dkim-atps=neutral
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com
 [209.85.208.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 27EEF10E472
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Oct 2025 14:35:12 +0000 (UTC)
Received: by mail-ed1-f50.google.com with SMTP id
 4fb4d7f45d1cf-63babfdb52cso1614924a12.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Oct 2025 07:35:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760366111; x=1760970911; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=r+M6T90aofvVrx2e1vqwPoDjqCLdEjx6BHMLbVIttJc=;
 b=fUyKlPIPOtT47kiIFcXtOEY0Gfdg6FHOS7FMWzmKnyPEg8fyPiv8zIpjqDZ7O3AmVU
 de8szRrtv+RY7mP33CAVLutfEtgq412VtP2WRhLeqcxzkiz+3O+FFyBSqslFjbqyKW+2
 L+VEyaiVL9SFDMGzFHjUKp1OzaQijDC66zWwzQB27d/R9PQyOA/NcNyQKBD/eGwL2+Yq
 u73YXxbLfmtWr0M3h7ECB56Ihojfqh+2yR8lgCmNUjNmAmCzbIBgg1b99K0C5eUdJJER
 7a6no9QardqFRtCEDMhHaZ2w1dm2+htYhS7rHiNxtbL6hP4GPSF9IPZ0H1mSZUguqSfb
 m0Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760366111; x=1760970911;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=r+M6T90aofvVrx2e1vqwPoDjqCLdEjx6BHMLbVIttJc=;
 b=uLDluXj/TRfsTh6KI46d8JAEOLDBCC0hHZAVY9ZSeN22r4ze6d1BZ4P4zD91KoOH/J
 84/UCcpFYGqE9+B9bN/WtluDaSz7DGUdeIJoZUCY6O0zNgrPWm1m7a6Rw0XI+FW2oeiX
 dXEYnyyb3ru1S+HzxVaH6Q6Q0qflbfNDMDK8vFmeF6BfU+6iTvc4ZByNHE9hEuW9mG97
 cc90Wp3pT0eHb39nLs+9osxCu6lWep5XrRb64xVnDlzmwLVsYRHNo8spti6JOVmLx2sc
 XQPjXT48b0BWFLFu3BY2vT+lP3WQzBS/KC+hldi4Hlyjlnf8WfjUL/T3VZZRoYCS2Ome
 UM6w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUw7vznARiqVBvnl5FIhevKGGALrS/FnDDhKBkdcyWhz+9S78GpudrfHW+TQxpko+tfJejybSLD@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yxn7utlr8g1k2xiiU7kH2EsmVoeJu1vH/GpY0WqDjz8riCaCq0M
 N7sOxeT5hz8y4IqjRisGt63cyNJqYqbL5pVcTaxR1a05qE5XwrfuvPpkGUuGgg==
X-Gm-Gg: ASbGncsl18mbRR8RuiN1zu4fSh8PVcMZht9FWpyqECSJHtVY+to6O8IexoUN2DmY47n
 R5vifp2TWq6pV2xaHdiQ9AEU1L7Qs5PrRHyGIZfi5mzumuI/3JQP9Zi79LlTa9w/qoBwcQSS+xo
 uYVN32sZtpPuJEESbnxRHyI9F9KEDpOkSARairAbIEgADhPAk+uuVMUUCykg8UOnMzLYMusGCNt
 cXrQRQvt97VrjfCxzv9jERmpUGssMGjlKb57enY4zfW5j0MI0+uddYTd20J0n/PtVwQ+iPOiXMG
 3nvU8fPj4/A/vQoGR9f30Bd9O8tyyK35ILtipu8CZxFys1FVj0MTUUkyZEi/HLQuVfuF2M1legv
 wGbH0PlAqiXPNdO3A4u3BUCyIls0RPyDBApuzeCLmRrZetHzFFpjjGK0=
X-Google-Smtp-Source: AGHT+IGfdI6Oj1WLuruFkjDpBWShReH7o0XKE+2jBb30VmEvhIh56qe5192WVy+lq83KXszpXTzFHw==
X-Received: by 2002:aa7:d0c9:0:b0:633:8787:607b with SMTP id
 4fb4d7f45d1cf-639d5b84856mr14366662a12.12.1760366110556; 
 Mon, 13 Oct 2025 07:35:10 -0700 (PDT)
Received: from able.fritz.box ([2a00:e180:151b:dc00:15d1:ebc5:76e6:730f])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-63a5c321453sm8942037a12.39.2025.10.13.07.35.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Oct 2025 07:35:10 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: phasta@mailbox.org, alexdeucher@gmail.com, simona.vetter@ffwll.ch,
 tursulin@ursulin.net
Cc: dri-devel@lists.freedesktop.org,
	amd-gfx@lists.freedesktop.org
Subject: [PATCH 08/15] dma-buf: use inline lock for the dma-fence-chain
Date: Mon, 13 Oct 2025 15:48:35 +0200
Message-ID: <20251013143502.1655-9-christian.koenig@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251013143502.1655-1-christian.koenig@amd.com>
References: <20251013143502.1655-1-christian.koenig@amd.com>
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

Just as proof of concept and minor cleanup.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/dma-buf/dma-fence-chain.c | 3 +--
 include/linux/dma-fence-chain.h   | 1 -
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/dma-buf/dma-fence-chain.c b/drivers/dma-buf/dma-fence-chain.c
index a8a90acf4f34..a707792b6025 100644
--- a/drivers/dma-buf/dma-fence-chain.c
+++ b/drivers/dma-buf/dma-fence-chain.c
@@ -245,7 +245,6 @@ void dma_fence_chain_init(struct dma_fence_chain *chain,
 	struct dma_fence_chain *prev_chain = to_dma_fence_chain(prev);
 	uint64_t context;
 
-	spin_lock_init(&chain->lock);
 	rcu_assign_pointer(chain->prev, prev);
 	chain->fence = fence;
 	chain->prev_seqno = 0;
@@ -261,7 +260,7 @@ void dma_fence_chain_init(struct dma_fence_chain *chain,
 			seqno = max(prev->seqno, seqno);
 	}
 
-	dma_fence_init64(&chain->base, &dma_fence_chain_ops, &chain->lock,
+	dma_fence_init64(&chain->base, &dma_fence_chain_ops, NULL,
 			 context, seqno);
 
 	/*
diff --git a/include/linux/dma-fence-chain.h b/include/linux/dma-fence-chain.h
index 68c3c1e41014..d39ce7a2e599 100644
--- a/include/linux/dma-fence-chain.h
+++ b/include/linux/dma-fence-chain.h
@@ -46,7 +46,6 @@ struct dma_fence_chain {
 		 */
 		struct irq_work work;
 	};
-	spinlock_t lock;
 };
 
 
-- 
2.43.0

