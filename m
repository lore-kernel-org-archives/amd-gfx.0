Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77422CA9EDD
	for <amd-gfx@archiver.kernel.org>; Mon, 12 Oct 2026 07:42:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0E71C10EF00;
	Mon, 12 Oct 2026 07:42:52 +0000 (UTC)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com
 [209.85.128.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2FD7510E076
 for <amd-gfx@lists.freedesktop.org>; Sun, 11 Oct 2026 07:45:21 +0000 (UTC)
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-4a140e7405dso11850625e9.3
 for <amd-gfx@lists.freedesktop.org>; Sun, 11 Oct 2026 00:45:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791704719; x=1792309519; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=BqM+9SRRezlqj4MjJGtTvfOzuMvNp9lIqAkwlEew1kk=;
 b=KojSEPFIsZYjxEWczTnI1oIXl9Ch7FLK8+pFJHBzgFss3g0ndEkq/a9NQzxgMCB+Xj
 gtsED/bpah0eQtPcU5WOT+JiuhMqxqqW8HqHGM3MM8ZAyejQVraJgGQc4s2jTyu+qVby
 aeU2eSyQT5dJQZiTdqwMtZwsM41f19MKceqvubG36pUzQ0h2LX5wsQ8H5jaEAXdP1S3/
 +/XenbZQjF6xX27LDwQwqqlARPIdjtSj6wOOMAMZuvD/J3ib2z5gK9l+erdiKgH3LY/F
 lFTWdosjWUISZDEv5b+25VSbafXEW/y2FxRpZJ7LWE6T2YZzHOycXmPvsEdyyRcKcveK
 y2Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791704719; x=1792309519;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=BqM+9SRRezlqj4MjJGtTvfOzuMvNp9lIqAkwlEew1kk=;
 b=tb/9IGW1ldjdpU4bZMCvzFukrM8UN+GxkXAlqGGfKPYjA7alSje8gUxMJjJmg17khf
 JJJzcdwNnnPc4rF7qjNZa52K8C2ddttYvbV020Xo8awjpgpA+rp8Fr+PetW5nz69yY4G
 8SH3UfhsJ5xoNMHp15s7JWEpXzna1Dy7Nq4rqAPuFD3QfhtPASsa5YtqlNHWgP4tcIH3
 3jWEEQdMG7TxctMZs38aJPEnEjB974xZP/noZYPc5P7G8eBskO2oppqzEml3tne/B6DE
 D0wPLfoZmX5nHT3Xow4GMPY/eqUWO0hPtc6SJzclZFz6i2+bihYjPj6/TDdvcABbtjJ4
 bNFw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxHimSXbT6q09H9PjG8hDSEloKnUHFfsEaHY8aLSnFdwo6qYXJGKQ8iLReLRA3AxA3K0CLngM5/@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJtdxbhOHE3CXjCcOyJpZQhQ7IEfW0bOjmthGGIAqAPE/pk0X4F
 /c/WtUzfVr5S6MQ9N/L9lIZSwUh4H3I13dcnXgDV8ZcZZfCxuIakD9os
X-Gm-Gg: AYBFou10UOo6i88SeJTuENISIN+L0TzE6IWVELyJOszJNyexMhif4KO9lQm+G6zHUuq
 wJT4QU16KQ2mo6Ux1sHvwqBHsR8uvIYkl/fYa7lv28y5Ao+i3X9TWYvUVsdzJ71LdN7/trwZYOw
 5Ut6CZg8YZ1FDpZ3CixL8GapP7CI/vklwmDKEpGKMHRR1+tjYb4XPbulFvSYoAUtN/+/bRVmoz0
 BwyvYpMAqx/iiWGAL9qyIFq810qMnotgAYld+QWyc4JT1okyyD+1y2DMdDdPe4+OPLazs7vappE
 ycfA57d7cQCxoEakZpbSQv5+h7b+uyxi3mi91ELHqbnqdMJ6LxaLdYKmLFHp6LnNYSX4d/zP+bF
 5+3e+LFKGSIXp9ETvogA5uwG5wqgeX/CWQ/jkYXiclQGOco6kuh+dnIDjYA2W6NH0ThyQQ14Yi7
 /tCAVCUbRF0UhrSpsqyr4DVGC79eUJ3LjTE/yyHAKjP6rl8YdXEl3N9gQRSc5z7YDLM3E+OVRN/
 YV4+bIpmhEGm0OzVVCpcOo=
X-Received: by 2002:a05:600c:620b:b0:49c:fc6c:be19 with SMTP id
 5b1f17b1804b1-4a18e4d12e7mr102284445e9.31.1791704719496; 
 Sun, 11 Oct 2026 00:45:19 -0700 (PDT)
Received: from LAPTOP-AVI.taile24b5.ts.net
 ([2a06:c701:4778:c500:e952:dc8f:95c1:823c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a18e48db03sm271020005e9.3.2026.10.11.00.45.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Oct 2026 00:45:19 -0700 (PDT)
From: Avi Weiss <thnkslprpt@gmail.com>
To: austin.zheng@amd.com,
	jun.lei@amd.com
Cc: harry.wentland@amd.com, sunpeng.li@amd.com, siqueira@igalia.com,
 alexander.deucher@amd.com, aurabindo.pillai@amd.com,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH] drm/amd/display: Initialize missing TD-LUT programming inputs
Date: Sun, 11 Oct 2026 10:45:10 +0300
Message-ID: <20261011074510.2495683-1-thnkslprpt@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 12 Oct 2026 07:42:49 +0000
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

dml_core_mode_programming() memsets (clears) its scratch structure
before calculating TD-LUT settings, but does not initialize
tdlut_mpc_width_flag or is_gfx11.

Both inputs therefore remain false regardless of the plane
configuration which can result in incorrect calculations.

Initialize both fields using the same sources as the mode
support path (now both paths are aligned).

Fixes: 70839da63605 ("drm/amd/display: Add new DCN401 sources")
Signed-off-by: Avi Weiss <thnkslprpt@gmail.com>
---
 .../dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn4_calcs.c        | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn4_calcs.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn4_calcs.c
index 72acf12e9251..0ee385e8ba5f 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn4_calcs.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn4_calcs.c
@@ -11074,6 +11074,8 @@ static bool dml_core_mode_programming(struct dml2_core_calcs_mode_programming_ex
 		calculate_tdlut_setting_params->cursor_buffer_size = mode_lib->ip.cursor_buffer_size;
 		calculate_tdlut_setting_params->gpuvm_enable = display_cfg->gpuvm_enable;
 		calculate_tdlut_setting_params->gpuvm_page_size_kbytes = display_cfg->plane_descriptors[k].overrides.gpuvm_min_page_size_kbytes;
+		calculate_tdlut_setting_params->tdlut_mpc_width_flag = display_cfg->plane_descriptors[k].tdlut.tdlut_mpc_width_flag;
+		calculate_tdlut_setting_params->is_gfx11 = dml_get_gfx_version(display_cfg->plane_descriptors[k].surface.tiling);
 
 		// output
 		calculate_tdlut_setting_params->tdlut_pte_bytes_per_frame = &s->tdlut_pte_bytes_per_frame[k];
-- 
2.43.0

