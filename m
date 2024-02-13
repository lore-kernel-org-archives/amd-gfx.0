Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB682C48260
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Feb 2024 22:52:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 01EFE10E89F;
	Tue, 13 Feb 2024 22:52:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=usp.br header.i=@usp.br header.b="CXCkHbJq";
	dkim-atps=neutral
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com
 [209.85.215.179])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 453C010E89F
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Feb 2024 22:52:32 +0000 (UTC)
Received: by mail-pg1-f179.google.com with SMTP id
 41be03b00d2f7-5bdbe2de25fso3800603a12.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Feb 2024 14:52:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=usp.br; s=usp-google; t=1707864752; x=1708469552; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QPJKSwZeBPbnMdgaHzTCAO+LMUvPfr/R89O0sEj9gkg=;
 b=CXCkHbJqqrqZ/9lY3vwOm1MOrVUinur5eKT7iTC06A8NfhG2vlAHY/+19ecDXev8MT
 aYuqWJpawOhmOE2nv51AWGhlSp4CNpGMBTNCQl+fbMZEANvCxsa6e9VRgtI1dwRqsiAo
 k8vzMdajzSy12FVJZKgxaEw3WTgNQirKhRpICxSNWqhgfotALt/zlwKB4PPVZZSF/Agm
 SlXjZcU/bToFGBzm2p7sNx5ggFZ/8FB0P4gfqCikv9h6HUJE3E5oEPCMDWTztx8UlmB8
 XQ2QKpVK+/NNHjRey6DrG+6ZmF3nbjKMJJo8m4ty7DM5daM1KUyREnPmZhCJ5nm5HFcV
 zn8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707864752; x=1708469552;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QPJKSwZeBPbnMdgaHzTCAO+LMUvPfr/R89O0sEj9gkg=;
 b=CgFeOka/+vQRQ11ppgc5nDbqLOmDQz/ScDd9a3LaJ415rwnJZjPoJv6OPImYA6b0OZ
 7OGMryyhhSn9QcWLqiFRGosfifa2VfvQmZE/GsjixKtXlc8rKMgxJS96BV6qcJBIpZPa
 9Ol47XrMX2e2tvOV0DT93RlIzbZ68xopyTE/Ceb0OHinzWb6xyK6J9KMugu1edwxtSzI
 hC+IhzAlZgTxYev8azwTabe6DV0mR3A0oBK27P9233rySUyK4ggGd9L2YixfTw1kOTbd
 wAlu7qhx1pCdWujmUznpzlxM10uv4TVIKD9+5AocUhPaCYM+aUkPuCbT74rL1GS0ZcoR
 pldQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV8sekoTqCsaze3oEVJrw6k6pRN5jNec5SNM7oPCwgnQ0r4JQwwrV8rtuq7yW6AZqyDLwYM78KAFQHY7m5JKC7NOEUlUKxoBVJZMlHv+Q==
X-Gm-Message-State: AOJu0YwVn0a8Vox2b6ldXF7mBgaVo5RDzCuvG82gzWTJW4JCtyDmW/8U
 4pg0SNCK4pQ+iM/j2eG8utxS5CbykiU7fhiOIL9gtP02JQyExIQCzhXOiMMmwQ==
X-Google-Smtp-Source: AGHT+IGSVr1+ATMwQt5rCANQn9q3OD2vEHmgNWq0lf5mwJzw3k+MmI5D9ArWdBHWaD3kaezo+zKTPw==
X-Received: by 2002:a05:6a20:c31e:b0:19e:cdca:3e56 with SMTP id
 dk30-20020a056a20c31e00b0019ecdca3e56mr867986pzb.27.1707864752221; 
 Tue, 13 Feb 2024 14:52:32 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCW52IN1lDshHR0n+DFxTl/0nUBytZBx6Gn6E+V37MN90DN4GVE5nHDXjmnSmnGwA48ONfiECF3JCJZhC3TMYMK8+sdzURjVyLZrUQm+4hnwN68ihzKSyXE1M2sqjXh8qxb+1LcFikiiqnFszpbxUjkiscV4xyOzyQpN1nrNcgRada/FK2R+Ue6NG/u5tnvWZSPRMyzDwuQj/qKbayv4HSTWuGsFO7ZQ1EJ5Lyk9XdONKKwF8PLtPTV3ieueWt+wW90ePBSmy012+anstlecrNIm4DI29byFTNS7iPRSp7mp53zvMTdpv9eBG6X8hJPSm6f8h34uO5KexMW0YpmpPaIQnNIirFvR0ohn3iCN9CDEnySd9WJIffxeHG/v
Received: from fedora.. ([2804:7f4:8280:6434:9a20:a151:2d8b:d5a0])
 by smtp.gmail.com with ESMTPSA id
 r25-20020a639b19000000b005dc89142b99sm1528379pgd.84.2024.02.13.14.52.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Feb 2024 14:52:31 -0800 (PST)
From: Joao Paulo Pereira da Silva <jppaulo11@usp.br>
To: harry.wentland@amd.com, sunpeng.li@amd.com, Rodrigo.Siqueira@amd.com,
 alexander.deucher@amd.com, christian.koenig@amd.com, Xinhui.Pan@amd.com,
 airlied@gmail.com, daniel@ffwll.ch
Cc: jppaulo <jppaulo11@hotmail.com>,
 Joao Paulo Pereira da Silva <jppaulo11@usp.br>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: [PATCH 1/2] drm/amd/display: clean inconsistent indenting
Date: Tue, 13 Feb 2024 19:43:09 -0300
Message-ID: <20240213224339.379599-2-jppaulo11@usp.br>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240213224339.379599-1-jppaulo11@usp.br>
References: <20240213224339.379599-1-jppaulo11@usp.br>
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

From: jppaulo <jppaulo11@hotmail.com>

Clean some wrong indenting that throw errors in checkpatch.

Signed-off-by: Joao Paulo Pereira da Silva <jppaulo11@usp.br>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index aa7c02ba948e..7832832b973d 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -962,7 +962,7 @@ static bool dc_construct(struct dc *dc,
 		goto fail;
 	}
 
-        dc_ctx = dc->ctx;
+	dc_ctx = dc->ctx;
 
 	/* Resource should construct all asic specific resources.
 	 * This should be the only place where we need to parse the asic id
@@ -3155,10 +3155,10 @@ static void commit_planes_do_stream_update(struct dc *dc,
 				if (stream_update->mst_bw_update->is_increase)
 					dc->link_srv->increase_mst_payload(pipe_ctx,
 							stream_update->mst_bw_update->mst_stream_bw);
- 				else
+				else
 					dc->link_srv->reduce_mst_payload(pipe_ctx,
 							stream_update->mst_bw_update->mst_stream_bw);
- 			}
+			}
 
 			if (stream_update->pending_test_pattern) {
 				dc_link_dp_set_test_pattern(stream->link,
-- 
2.43.0

