Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D86AC433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Feb 2022 14:06:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D954F10E835;
	Tue, 22 Feb 2022 14:06:43 +0000 (UTC)
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com
 [IPv6:2607:f8b0:4864:20::32d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E32B710E63C
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Feb 2022 13:18:22 +0000 (UTC)
Received: by mail-ot1-x32d.google.com with SMTP id
 g6-20020a9d6486000000b005acf9a0b644so9549480otl.12
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Feb 2022 05:18:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=usp.br; s=usp-google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=sDN/q36ne++w24m6ta6Mu8DvTucc3A8JRf+sG15A4uk=;
 b=gwNgQ82BffFNGYRWppEJcVbH9lkHH4pDVyKTZaRhGLp+f2xO5A1Rx15s9yci3hHm4w
 FR1uQhg8pvxh6Nres53U9+5PeQJjeY4FqukANXW+8jQxQv139/laPSL8d4aiynsMT7my
 oM5Wamd+Hc1OYtVIoCGTe5UqhD9E3zG6UB+aAagv3NxkPhAqTy845/1Yegz+Ca/xHwmK
 YaQM48FZyG/26ee4ISyofDBH3oxrbmeQdpILyFa49nlOGi9EKrN2uGD9mf6DccDzN5M1
 DUU+/U+aSWi9pPrfoohDvEJclSE8CUZvlfVrqhZg4DwOkDj8i05D6c/wK2OrBZbxVyJ3
 DXkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=sDN/q36ne++w24m6ta6Mu8DvTucc3A8JRf+sG15A4uk=;
 b=vyqRrUiL1kmpGxrYn8xChVYsKR8NzTa8zmMVT5Jcwcng07AbTkiwgmaMW1MSxvXs84
 YTYmfIPVG+OgNojKDLyGTL8XTdMQ1L0yPGtQR3XC5ENRsT1A9eRxngAYdLePCPL5A7MW
 DX12MYSEVbuK00n1/rX2qVsZJGthdWw+rvqPsiP/1B566yaNCv0aNCig0pL5A6niuHeR
 Ou7FgyL8e35Ge5gRSlAVRPdBoGfjxZohVChShkb24ZJNgbHX3yRVQ1q6qz2KHnBV5TSA
 hDltBV4IZz+farWBaWFC7ELKZaFXUER5RlMTA2mYSe73nIIuCYFSCXhouc3t2M9wYxjX
 bKlQ==
X-Gm-Message-State: AOAM533Jzxv0Q6Uqkp4Rg5bojl9IQZMAyWkvLPzWGpI6ygn0oMMjGHr2
 jHwbbmREjV0/LJzg7elSQbuKKQ==
X-Google-Smtp-Source: ABdhPJyc2O86+E0dEG/No0hmALq+XxmG2EgDiNrBeWwpqJKHrw0001sfFqK9Y7CYkpxQ9BvdfQuGzg==
X-Received: by 2002:a9d:714a:0:b0:5ad:f8f9:b50d with SMTP id
 y10-20020a9d714a000000b005adf8f9b50dmr4817459otj.47.1645535902206; 
 Tue, 22 Feb 2022 05:18:22 -0800 (PST)
Received: from fedora.. ([187.36.236.204])
 by smtp.gmail.com with ESMTPSA id c9sm6325050otd.26.2022.02.22.05.18.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Feb 2022 05:18:21 -0800 (PST)
From: =?UTF-8?q?Ma=C3=ADra=20Canal?= <maira.canal@usp.br>
To: alexander.deucher@amd.com, christian.koenig@amd.com, Xinhui.Pan@amd.com,
 Hawking.Zhang@amd.com, john.clements@amd.com, tao.zhou1@amd.com,
 YiPeng.Chai@amd.com, luben.tuikov@amd.com, Stanley.Yang@amd.com,
 Dennis.Li@amd.com, mukul.joshi@amd.com, harry.wentland@amd.com,
 sunpeng.li@amd.com, Rodrigo.Siqueira@amd.com, Anthony.Koo@amd.com
Subject: [PATCH 07/10] drm/amd/display: Remove unused
 dmub_outbox_irq_info_funcs variable
Date: Tue, 22 Feb 2022 10:16:58 -0300
Message-Id: <20220222131701.356117-8-maira.canal@usp.br>
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

Remove the unused struct irq_source_info_funcs
dmub_outbox_irq_info_funcs from the file, which was declared but never
hooked up.

This was pointed by clang with the following warning:

drivers/gpu/drm/amd/amdgpu/../display/dc/irq/dcn201/irq_service_dcn201.c:141:43:
warning: unused variable 'dmub_outbox_irq_info_funcs'
[-Wunused-const-variable]
static const struct irq_source_info_funcs dmub_outbox_irq_info_funcs = {
                                          ^

Signed-off-by: Maíra Canal <maira.canal@usp.br>
---
 .../gpu/drm/amd/display/dc/irq/dcn201/irq_service_dcn201.c   | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/irq/dcn201/irq_service_dcn201.c b/drivers/gpu/drm/amd/display/dc/irq/dcn201/irq_service_dcn201.c
index aa708b61142f..45f99351a0ab 100644
--- a/drivers/gpu/drm/amd/display/dc/irq/dcn201/irq_service_dcn201.c
+++ b/drivers/gpu/drm/amd/display/dc/irq/dcn201/irq_service_dcn201.c
@@ -138,11 +138,6 @@ static const struct irq_source_info_funcs vupdate_no_lock_irq_info_funcs = {
 	.ack = NULL
 };
 
-static const struct irq_source_info_funcs dmub_outbox_irq_info_funcs = {
-	.set = NULL,
-	.ack = NULL
-};
-
 #undef BASE_INNER
 #define BASE_INNER(seg) DMU_BASE__INST0_SEG ## seg
 
-- 
2.35.1

