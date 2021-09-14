Return-Path: <SRS0=i1uT=OE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D966C433FE
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Sep 2021 23:59:58 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4424C61166
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Sep 2021 23:59:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4424C61166
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=froggi.es
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CDFB06E859;
	Tue, 14 Sep 2021 23:59:54 +0000 (UTC)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7FBB96E857
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Sep 2021 23:59:53 +0000 (UTC)
Received: by mail-wr1-x42b.google.com with SMTP id q26so912975wrc.7
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Sep 2021 16:59:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=froggi.es; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=DbJsVGT9iT8OgSbIbO/1gnF8vwppi0fnPqOct14ikzw=;
 b=VYYsc8JWNOC9k1mWJpWE3dKrkwNlvlIzS9xPiwzogAMzNzH33m1Z6VRZJ0HIoV8sPy
 0svdLni/DsBVVuXvW3kdoG3q1zBpM+dVKC/a9j/EFFL/LIUZdZoAEh+IXkUeU+kHVOP2
 SUlvuqteJSIHSpKums86GozINX16iH+3ywyx9jyV0N8DZyTGV7Tgo+FmlYsKdObrOOWh
 F/WEdqlPFncnjtQqGEebecnl9jevwx1ZkYhIut1FXYWbQu+H88qPRKsXie4eZ8NEK/Ym
 OWKITZFV/ZztAT7cLO3OpG3Owcz5DOfugOfkc3TAb4dKyxb34/cNvaygKONJhVp1D+S3
 5SnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=DbJsVGT9iT8OgSbIbO/1gnF8vwppi0fnPqOct14ikzw=;
 b=EPzxNjadu/lSrNhTsNdGY3YnxxJfREDlrTA4r3YzQB4HHzKUQpei5mK2IogkYwU4J1
 7dcDyiHqSA06LTUFBnQB2Kw6v3I8mWevRTHsfOBwB6RUdSjQNhrQKunSFv1VLyxNzRoY
 AQFfYpdPtQiRkFq+CvIdD420/+vDN3IqgFtxqDjnNB+TMXYbr5VJ+GlEbYSGb4tak68/
 LxqyBD7ZgBQr5+f4RD4OEcPC1NAIS+NAQnRl/B/hyEOC8EUxG9yfD0pMQ4VNLM6O8YtX
 Oea0zzgkm6aRcuDwCk9WlaHiUqO4OLzJX73JxNKz6IJkfzV/+UZt/JqZluWCNhY788V6
 zGGw==
X-Gm-Message-State: AOAM531Zt3VFrhcZEJQZlyxpoh4bPHYpD0lTD2md8WiEjx2LD5Na4myT
 a7ObCzGzD3oHKdWucoNBajCJ8NfwJjz0t4Hf0A4=
X-Google-Smtp-Source: ABdhPJz/mxIs7Z46/pq4ZtX0K12+RN3nGs6tlvPM2QrUQW2iP8r5bWdPlsn6JYHORyWaMeIhidvx0w==
X-Received: by 2002:a5d:6a81:: with SMTP id s1mr1768020wru.274.1631663992157; 
 Tue, 14 Sep 2021 16:59:52 -0700 (PDT)
Received: from localhost.localdomain
 (cpc89720-darl9-2-0-cust754.11-2.cable.virginm.net. [86.2.110.243])
 by smtp.gmail.com with ESMTPSA id m29sm12571637wrb.89.2021.09.14.16.59.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Sep 2021 16:59:51 -0700 (PDT)
From: Joshua Ashton <joshua@froggi.es>
To: amd-gfx@lists.freedesktop.org
Cc: Joshua Ashton <joshua@froggi.es>,
 Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
Subject: [PATCH 3/3] drm/amd/display: Add modifiers capable of DCC image
 stores for gfx10_3
Date: Wed, 15 Sep 2021 00:59:48 +0100
Message-Id: <20210914235948.893422-3-joshua@froggi.es>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210914235948.893422-1-joshua@froggi.es>
References: <20210914235948.893422-1-joshua@froggi.es>
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

Some games, ie. Doom Eternal, present from compute following compute
post-fx and would benefit from having DCC image stores available.

DCN on gfx10_3 doesn't need INDEPENDENT_128B_BLOCKS = 0 so we can expose
these modifiers capable of DCC image stores.

Signed-off-by: Joshua Ashton <joshua@froggi.es>
Reviewed-by: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 21 +++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 2a24e43623cb..a4e33a4336a0 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -4817,6 +4817,16 @@ add_gfx10_3_modifiers(const struct amdgpu_device *adev,
 		    AMD_FMT_MOD_SET(DCC_INDEPENDENT_128B, 1) |
 		    AMD_FMT_MOD_SET(DCC_MAX_COMPRESSED_BLOCK, AMD_FMT_MOD_DCC_BLOCK_64B));
 
+	add_modifier(mods, size, capacity, AMD_FMT_MOD |
+		    AMD_FMT_MOD_SET(TILE, AMD_FMT_MOD_TILE_GFX9_64K_R_X) |
+		    AMD_FMT_MOD_SET(TILE_VERSION, AMD_FMT_MOD_TILE_VER_GFX10_RBPLUS) |
+		    AMD_FMT_MOD_SET(PIPE_XOR_BITS, pipe_xor_bits) |
+		    AMD_FMT_MOD_SET(PACKERS, pkrs) |
+		    AMD_FMT_MOD_SET(DCC, 1) |
+		    AMD_FMT_MOD_SET(DCC_CONSTANT_ENCODE, 1) |
+		    AMD_FMT_MOD_SET(DCC_INDEPENDENT_128B, 1) |
+		    AMD_FMT_MOD_SET(DCC_MAX_COMPRESSED_BLOCK, AMD_FMT_MOD_DCC_BLOCK_128B));
+
 	add_modifier(mods, size, capacity, AMD_FMT_MOD |
 		    AMD_FMT_MOD_SET(TILE, AMD_FMT_MOD_TILE_GFX9_64K_R_X) |
 		    AMD_FMT_MOD_SET(TILE_VERSION, AMD_FMT_MOD_TILE_VER_GFX10_RBPLUS) |
@@ -4829,6 +4839,17 @@ add_gfx10_3_modifiers(const struct amdgpu_device *adev,
 		    AMD_FMT_MOD_SET(DCC_INDEPENDENT_128B, 1) |
 		    AMD_FMT_MOD_SET(DCC_MAX_COMPRESSED_BLOCK, AMD_FMT_MOD_DCC_BLOCK_64B));
 
+	add_modifier(mods, size, capacity, AMD_FMT_MOD |
+		    AMD_FMT_MOD_SET(TILE, AMD_FMT_MOD_TILE_GFX9_64K_R_X) |
+		    AMD_FMT_MOD_SET(TILE_VERSION, AMD_FMT_MOD_TILE_VER_GFX10_RBPLUS) |
+		    AMD_FMT_MOD_SET(PIPE_XOR_BITS, pipe_xor_bits) |
+		    AMD_FMT_MOD_SET(PACKERS, pkrs) |
+		    AMD_FMT_MOD_SET(DCC, 1) |
+		    AMD_FMT_MOD_SET(DCC_RETILE, 1) |
+		    AMD_FMT_MOD_SET(DCC_CONSTANT_ENCODE, 1) |
+		    AMD_FMT_MOD_SET(DCC_INDEPENDENT_128B, 1) |
+		    AMD_FMT_MOD_SET(DCC_MAX_COMPRESSED_BLOCK, AMD_FMT_MOD_DCC_BLOCK_128B));
+
 	add_modifier(mods, size, capacity, AMD_FMT_MOD |
 		    AMD_FMT_MOD_SET(TILE, AMD_FMT_MOD_TILE_GFX9_64K_R_X) |
 		    AMD_FMT_MOD_SET(TILE_VERSION, AMD_FMT_MOD_TILE_VER_GFX10_RBPLUS) |
-- 
2.33.0

