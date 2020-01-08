Return-Path: <SRS0=oKuu=25=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93EF2C33CA1
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Jan 2020 22:49:24 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6843B2053B
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Jan 2020 22:49:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ASP8SCjh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6843B2053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 17A8D6E34E;
	Wed,  8 Jan 2020 22:49:22 +0000 (UTC)
Received: from mail-yw1-xc42.google.com (mail-yw1-xc42.google.com
 [IPv6:2607:f8b0:4864:20::c42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5012C6E34E
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Jan 2020 22:49:21 +0000 (UTC)
Received: by mail-yw1-xc42.google.com with SMTP id i190so1968509ywc.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 08 Jan 2020 14:49:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=k8E4ILrGHMC3mtIbbbjR37Eb6M0J1SMJX8qAFj73+gc=;
 b=ASP8SCjhQ7lU9rEYKPGdjRSbngI9oEUCNuukQXr1cZHap8xQgMYbBE8j2QbxXuWO5E
 BQBDL82F/lbMUJ1TK9pcwEmzg1kPcBz+tydhFwHig+6LwZ5G5DQOf1mKpUpYFfLz/k9/
 yr0nAq3nuImpF++HosxYEU2kgu1GBlLKejU7FNsFh9krVPTU6NNHVdmZ1lIonBcg9F/v
 0sZcwfJKKxbNc5RVjCJkkC34n7/1qy6w9J9PS/yV0o7q83/Zdn0XH2ukuPmvxPbgvIUT
 aZLWYVENvoK6UKtybp5LKwbxmePQmJsDswQaodQHT9Pyi0VkOpXrAJQygEnqZj5V3B2T
 WH3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=k8E4ILrGHMC3mtIbbbjR37Eb6M0J1SMJX8qAFj73+gc=;
 b=Qj/eS+0E62zT/cOA1AUVbb7EZoQPgIj53AUMlWyzg5ejhYYbkhCJwgSAv3i+pUyz77
 KCafCwbrrL/AvrwH3emEqjYCyehq3D3M2AF1IHtfVNdSxlZmZIOJU5bOF7c01flf/ESc
 Wu5QwAmkEB50PEj8vmhtcXM6ANFU+rkMI/bUquRLefkvRgwWsH48lb3a8nHlVgp/04FL
 7lO8x/YfeUXyrEqRFrV5iXKjGcVl0gAvR/YCbJl2ZwYS2XRyxAhvFaAIF9p0awnJqMZ+
 R9Lj6uwQzRmJsl3V3GjCZH8WWEwzxlyaTTBo6moAiPT3wLVRUIg28JYqkZ8mL63bDp6/
 KJoQ==
X-Gm-Message-State: APjAAAX9GDJBi1l+QnUXYek7jsornAt/3gHooWWmVHPeR/42koeHElJS
 USAdkKiYQK+IDTZwq8yPfF4lh6JB
X-Google-Smtp-Source: APXvYqwbQOl9aE8HKNJzmwj7/tnbXpyrFB1pv9QJBHYTrzQ+ZhmZbT303u1upX1ZyyTsOPnxTtS5Bw==
X-Received: by 2002:a81:1c15:: with SMTP id c21mr5584884ywc.408.1578523760333; 
 Wed, 08 Jan 2020 14:49:20 -0800 (PST)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id t15sm1209519ywg.67.2020.01.08.14.49.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jan 2020 14:49:19 -0800 (PST)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 3/3] drm/amdgpu/display: set gpu vm flag for renoir
Date: Wed,  8 Jan 2020 17:49:10 -0500
Message-Id: <20200108224910.289731-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200108224910.289731-1-alexander.deucher@amd.com>
References: <20200108224910.289731-1-alexander.deucher@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

It won't get used unless the driver allows the gtt domain for
display buffers which is controlled elsewhere.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index fdf4d202ea1f..d0c9a5725813 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -910,6 +910,7 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
 	case CHIP_CARRIZO:
 	case CHIP_STONEY:
 	case CHIP_RAVEN:
+	case CHIP_RENOIR:
 		init_data.flags.gpu_vm_support = true;
 		break;
 	default:
-- 
2.24.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
