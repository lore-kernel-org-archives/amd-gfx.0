Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6333CC433FE
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Feb 2022 14:06:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9CCD810E84F;
	Tue, 22 Feb 2022 14:06:50 +0000 (UTC)
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com
 [IPv6:2607:f8b0:4864:20::c32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D5F4710E626
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Feb 2022 13:17:53 +0000 (UTC)
Received: by mail-oo1-xc32.google.com with SMTP id
 j7-20020a4ad6c7000000b0031c690e4123so8312446oot.11
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Feb 2022 05:17:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=usp.br; s=usp-google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=gUjTQJmzrA7YmPv0U39+3zh4DUhMv7PoZUE1y8daTkU=;
 b=FPkH1X3s9Z4MaxrX4uqfjr3F7a7VH/XL8sjYBD6kv6nMhEpAtU0QfomFMaSf8GNpNb
 t8YlseyboP1Z50Mc5eIfXqwSJbkKQTQ9ZXMON7BiQCTV40wpQybAmTe494JaSNRDO+zC
 vbuySWtEozg1GqhKsGDm9fQ6jWZhJiM7f8lLHj9CylLBenQ2MER4QfyRBDuXXRIlTfvt
 5ryycyOYPDO6dj2uPS+Xzphui8DCkRzUX48xpDmIKU+nAvi9WGP2l70vmWQ0sQFkV6ea
 LdMIKNtGBicAKMdkC8dcenYvWdwTribZIuLNqcKIWS1LNJGiEYXiZp0ClRVbRr+Q0sZT
 YZIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=gUjTQJmzrA7YmPv0U39+3zh4DUhMv7PoZUE1y8daTkU=;
 b=fsvs9/l9qEo3vPbnXS0R3moiOzuYIMmTOF4gQDXhAkj2aqMWiBKeo3P2RgG4NlR1k0
 f6+yjO2/X85CaIAbZFaWg6qktCzQuzplfvZBL/qVY9KMqo+Ifce8eHGdPTDTk/1qJVk2
 06AcaUKHTc399usUSYO+ugeXwvmIAXLton5eA87w9cmyY5re2svuo1TScdZ6wfTs3j1M
 z/a5HgZupJdCGRjIGRj4sBzBfZsE7xOLKcqmsrXDtkiotGp2D86lzOTXDLy60QPYb/h9
 3QKyZGkhvUrdFvbEnKCh0hMp0pBwgXU5lCiBOWXubyixbiWLrfhRckdU2ZpZnA9unLoZ
 6r5w==
X-Gm-Message-State: AOAM533c5WZKpuu+8SYD6/k0aZvI+VFCHeHU9R62J5RTJddhedquNue1
 6RCYGT9wRE7fr8H+9JQmAJv8hw==
X-Google-Smtp-Source: ABdhPJzSWobKzGCiBglLAMfGQ3zQeN2B60sOxZj/bjK565W/h7V9hy4VhSqKHUZu46XzLWuT1K3MqQ==
X-Received: by 2002:a05:6870:2142:b0:d2:c3fe:83c8 with SMTP id
 g2-20020a056870214200b000d2c3fe83c8mr1630946oae.165.1645535873120; 
 Tue, 22 Feb 2022 05:17:53 -0800 (PST)
Received: from fedora.. ([187.36.236.204])
 by smtp.gmail.com with ESMTPSA id c9sm6325050otd.26.2022.02.22.05.17.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Feb 2022 05:17:52 -0800 (PST)
From: =?UTF-8?q?Ma=C3=ADra=20Canal?= <maira.canal@usp.br>
To: alexander.deucher@amd.com, christian.koenig@amd.com, Xinhui.Pan@amd.com,
 Hawking.Zhang@amd.com, john.clements@amd.com, tao.zhou1@amd.com,
 YiPeng.Chai@amd.com, luben.tuikov@amd.com, Stanley.Yang@amd.com,
 Dennis.Li@amd.com, mukul.joshi@amd.com, harry.wentland@amd.com,
 sunpeng.li@amd.com, Rodrigo.Siqueira@amd.com, Anthony.Koo@amd.com
Subject: [PATCH 03/10] drm/amdgpu: Remove unused get_umc_v8_7_channel_index
 function
Date: Tue, 22 Feb 2022 10:16:54 -0300
Message-Id: <20220222131701.356117-4-maira.canal@usp.br>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220222131701.356117-1-maira.canal@usp.br>
References: <20220222131701.356117-1-maira.canal@usp.br>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 22 Feb 2022 14:06:42 +0000
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
Cc: magalilemes00@gmail.com,
 =?UTF-8?q?Ma=C3=ADra=20Canal?= <maira.canal@usp.br>,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, mwen@igalia.com,
 amd-gfx@lists.freedesktop.org, isabbasso@riseup.net
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Remove get_umc_v8_7_channel_index function, which is not used
in the codebase.

This was pointed by clang with the following warning:

drivers/gpu/drm/amd/amdgpu/umc_v8_7.c:50:24: warning: unused function
'get_umc_v8_7_channel_index' [-Wunused-function]
static inline uint32_t get_umc_v8_7_channel_index(struct amdgpu_device *adev,
                       ^

Signed-off-by: Maíra Canal <maira.canal@usp.br>
---
 drivers/gpu/drm/amd/amdgpu/umc_v8_7.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v8_7.c b/drivers/gpu/drm/amd/amdgpu/umc_v8_7.c
index de85a998ef99..f35253e0eaa6 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v8_7.c
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v8_7.c
@@ -47,13 +47,6 @@ static inline uint32_t get_umc_v8_7_reg_offset(struct amdgpu_device *adev,
 	return adev->umc.channel_offs*ch_inst + UMC_8_INST_DIST*umc_inst;
 }
 
-static inline uint32_t get_umc_v8_7_channel_index(struct amdgpu_device *adev,
-						uint32_t umc_inst,
-						uint32_t ch_inst)
-{
-	return adev->umc.channel_idx_tbl[umc_inst * adev->umc.channel_inst_num + ch_inst];
-}
-
 static void umc_v8_7_ecc_info_query_correctable_error_count(struct amdgpu_device *adev,
 						uint32_t umc_inst, uint32_t ch_inst,
 						unsigned long *error_count)
-- 
2.35.1

