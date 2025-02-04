Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60C79C02194
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Feb 2025 14:31:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0DA2210E661;
	Tue,  4 Feb 2025 14:31:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="QNHDuSCs";
	dkim-atps=neutral
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com
 [209.85.128.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4655810E662
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Feb 2025 14:31:17 +0000 (UTC)
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-43618283d48so42143625e9.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 04 Feb 2025 06:31:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1738679476; x=1739284276; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=m6jS/iW8hbFj5Vv4IbwSRCEs5J/d2lId7ZuIiC51rmU=;
 b=QNHDuSCs68pvEoaGZvkBc6J2BnDJ2DYSAjnDmGC2JfZcs2t1D8khRbIG5YCD2ZiD56
 aG6goSVAP7+LI/OEwcDCcWvslso6FIKnci3kPPY9uTvNn+H9t8nwrdIlGAd7sbrmHtjS
 JZpxFXM+o72LXh3uAi2gyWxWLGasvIUQPjrc+f4V3vNCvInm9wSA5uug8hPYX9y3AX0c
 zFlONldAAA5c77IwcXxPeCfe39taB5op/8e/7B0M9Dzt6LCAYQCqL5v+XOovtGrd0YfQ
 VBC9dtJQzjceeoawf5tcpbCZEysA6HaBFhy7umMVM87UU+wDXxuDGBwwXWYySUIvUBnO
 jfUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738679476; x=1739284276;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=m6jS/iW8hbFj5Vv4IbwSRCEs5J/d2lId7ZuIiC51rmU=;
 b=N5SyuYfcZx4THXwrBtyvLAxkkcViINWlnqOQm9ys8SXJSUFoN1BFc0QK9vjrVU0JXF
 H6IHt4oSfA+v/vy6sAVEhEAwK8JtX9U7Jh1x5zW/Rq/lISHYy4+tXRBOCh00r7MM7dbq
 PRvV+tvcR+zTAFQmrN6Jjo+YwHpq1GtScglqDCgssU8SwAvfXEYCpnatxqUk99r4qdlt
 fsjpfoaWVuzMdk59sSug/vRngiaJrQYB6xX30X8FkOOh4vYi2vd2AZB0iXBiokGFBNzh
 5VrcOps3jCbFxu2ywrIDDuZpOcBS/wCMLOJrLj6lefq99GpHsCNsGzkQiCawZMQef9Uf
 LeYg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWIPiM4Jt2v1lb7k3vJA2h7bqYEeYkRSLTzuG9RbrmtW2nOmdP+5ULMUinGYiVFXPNUucX2QYMG@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxlayCCbXW/mLFYVLX1RDtL9ymZ1V4fx/ulOUeq7xYRov+hziD3
 +lTdfCjaAfNcvW3rhBt/aOQxosUDSoLJ19QSpToX4dGmlAxphLBE
X-Gm-Gg: ASbGncsmkhtJCdtmqV9Vv2RJv/9Oo00+gTOdVHYPUt4n8w/FTnLT1HoQjnC/9vWPkm3
 LOyOBF6PH4xGSmZ5PDyDr8K6l5AitVsWVXDETsuB+s4v5EL5iOwKR3xT7HUWPCONRZEYaN7UUMV
 fainYCcKrKYMnO/SasMDKnXDq7PUM/kmqV0umDwBiCYNwTumoiVtCMN8/2OhtwKbDYbi4CKaN4F
 Li+Jq+cYFD/VtXc8aGR0L6DYgPUeJyv/TOW3e6nu0WXZlka9Rorj/Dg2VLwREjd1gaVxVrY63ib
 v5Ma61DcIwArjimjjrB5xJozZmt5
X-Google-Smtp-Source: AGHT+IESKCafhroexNVXFH0Qh8vRQFGQ9VSVZkXvrP8HCE1IdG921juYhNr5FWbL/1zj3rpEqbwpjA==
X-Received: by 2002:a05:600c:3b94:b0:434:a929:42bb with SMTP id
 5b1f17b1804b1-438dc3cbb71mr237313795e9.18.1738679475327; 
 Tue, 04 Feb 2025 06:31:15 -0800 (PST)
Received: from able.fritz.box ([2a00:e180:15d3:1100:15c3:7ea2:8ff1:462c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438e244eb0dsm194169135e9.27.2025.02.04.06.31.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Feb 2025 06:31:14 -0800 (PST)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: timur.kristof@gmail.com, Alexander.Deucher@amd.com,
 amd-gfx@lists.freedesktop.org
Subject: Rework and fix queue reset for gfx7-gfx10
Date: Tue,  4 Feb 2025 15:31:08 +0100
Message-Id: <20250204143113.6320-1-christian.koenig@amd.com>
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

Hi guys,

I finally found time to work on queue reset a bit more and also gave it
some more testing.

The per VMID reset actually seems to work 100% reliable at least on gfx9.

What still could be is that an application is using multiple VMIDs on the
graphics ring or that we re-use the same VMID for a different application.
Preventing this will need some more work on the VMID management.

The compute queue reset as well as the gfx11 and gfx12 code unfortunately
still has some calls to amdgpu_bo_reserv/amdgpu_bo_kmap in their path
which are totally illegal inside the reset handling, but that can be fixed
later on.

Please test, comment and review,
Christian.


