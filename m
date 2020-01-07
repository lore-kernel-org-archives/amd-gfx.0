Return-Path: <SRS0=EvZE=24=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D10D8C282DD
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Jan 2020 19:41:34 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A8B8020848
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Jan 2020 19:41:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=digitalocean.com header.i=@digitalocean.com header.b="IOJjPyAy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8B8020848
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=digitalocean.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F19C76E130;
	Tue,  7 Jan 2020 19:41:31 +0000 (UTC)
Received: from mail-yb1-xb44.google.com (mail-yb1-xb44.google.com
 [IPv6:2607:f8b0:4864:20::b44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EECE86E83A
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Jan 2020 19:26:01 +0000 (UTC)
Received: by mail-yb1-xb44.google.com with SMTP id n66so460100ybg.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 07 Jan 2020 11:26:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=digitalocean.com; s=google;
 h=from:to:cc:subject:date:message-id;
 bh=4DKB6Qc7EQjmBiBL2Egn9+nwj/mOHqlQ9foMEYlIG8s=;
 b=IOJjPyAyvnzuaeYvsM7svksubqWXA8Hoa7vK1bSt+tq7EJBo7VMbZS8S8OZSLwg1pG
 36w/czHJ96ImfadkDxCEjuu2XWNf62lAMDsXNsGFKHjawBMtvJOe2BF5ITEpiN1FAxl9
 5YiirNrNugcI13cQILvJLZwP+M6SsP86e47EU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=4DKB6Qc7EQjmBiBL2Egn9+nwj/mOHqlQ9foMEYlIG8s=;
 b=ZOm8c7bcKcpZW5D5Hg8ZuGrWcRjC3Wq5+Z5nfkg5+QgkIy/Ul4I9bh29adZcn+7an4
 UuUcSFR3dzhyZtwo/DIqwsZULsKth3oMSxaGas+k5UO3ZxX2PMs3aCM8elzVGVvA1aBw
 vNyWc1aaHnucF1K4Ti/OtAHoKtjJEX4tXn7pkPxlpEApy33Xv+jhr8sFI8IS4sqWc2TB
 F8pkV9wFZ6oBzsZ/3w0/XkuKA/25a1/tLNz/TXPncn7fiaPCEmR30rJWLgGK7etNtHsv
 PXQmmf3hv5kL8deB2rW95VNN25ThBF6elbD46VRgQsZcmtpxhY6PT2iIDX+jteIN7OJl
 ozPQ==
X-Gm-Message-State: APjAAAUFRwgANiOp+Vw8+PEX8+v4NVMbpCIb1IXWxfShope6cz86/CyR
 Oa4EI1Phm1mkDBNgvEvjuUDg
X-Google-Smtp-Source: APXvYqy+9ob7vtrukxOuHGC9cxGwvi0VR2CE0/vcLH7EgE5nxS3/p087frpqoeKCnXIBDamwJYeLvQ==
X-Received: by 2002:a25:40c4:: with SMTP id n187mr909330yba.199.1578425160957; 
 Tue, 07 Jan 2020 11:26:00 -0800 (PST)
Received: from tina-kpatch ([162.243.188.76])
 by smtp.gmail.com with ESMTPSA id y9sm252630ywc.19.2020.01.07.11.26.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jan 2020 11:26:00 -0800 (PST)
From: Tianlin Li <tli@digitalocean.com>
To: kernel-hardening@lists.openwall.com,
	keescook@chromium.org
Subject: [PATCH 0/2] drm/radeon: have the callers of set_memory_*() check the
 return value
Date: Tue,  7 Jan 2020 13:25:53 -0600
Message-Id: <20200107192555.20606-1-tli@digitalocean.com>
X-Mailer: git-send-email 2.17.1
X-Mailman-Approved-At: Tue, 07 Jan 2020 19:41:30 +0000
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
Cc: David1.Zhou@amd.com, David Airlie <airlied@linux.ie>,
 linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 Tianlin Li <tli@digitalocean.com>, dri-devel@lists.freedesktop.org,
 Daniel Vetter <daniel@ffwll.ch>, Alex Deucher <alexander.deucher@amd.com>,
 christian.koenig@amd.com
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Right now several architectures allow their set_memory_*() family of  
functions to fail, but callers may not be checking the return values.
If set_memory_*() returns with an error, call-site assumptions may be
infact wrong to assume that it would either succeed or not succeed at  
all. Ideally, the failure of set_memory_*() should be passed up the 
call stack, and callers should examine the failure and deal with it. 

Need to fix the callers and add the __must_check attribute. They also 
may not provide any level of atomicity, in the sense that the memory 
protections may be left incomplete on failure. This issue likely has a 
few steps on effects architectures:
1)Have all callers of set_memory_*() helpers check the return value.
2)Add __must_check to all set_memory_*() helpers so that new uses do  
not ignore the return value.
3)Add atomicity to the calls so that the memory protections aren't left 
in a partial state.

This series is part of step 1. Make drm/radeon check the return value of  
set_memory_*().

Tianlin Li (2):
  drm/radeon: have the callers of set_memory_*() check the return value
  drm/radeon: change call sites to handle return value properly.

 drivers/gpu/drm/radeon/r100.c        |  3 ++-
 drivers/gpu/drm/radeon/radeon.h      |  2 +-
 drivers/gpu/drm/radeon/radeon_gart.c | 22 ++++++++++++++++++----
 drivers/gpu/drm/radeon/rs400.c       |  3 ++-
 4 files changed, 23 insertions(+), 7 deletions(-)

-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
