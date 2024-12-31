Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EECE1E77188
	for <amd-gfx@archiver.kernel.org>; Tue, 31 Dec 2024 10:35:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5566710E63D;
	Tue, 31 Dec 2024 10:35:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="lnjwa/gO";
	dkim-atps=neutral
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com
 [209.85.214.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6A2BA10E59F
 for <amd-gfx@lists.freedesktop.org>; Tue, 31 Dec 2024 00:38:15 +0000 (UTC)
Received: by mail-pl1-f172.google.com with SMTP id
 d9443c01a7336-21636268e43so30730125ad.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 30 Dec 2024 16:38:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1735605435; x=1736210235;
 darn=lists.freedesktop.org; 
 h=to:from:cc:content-transfer-encoding:mime-version:message-id:date
 :subject:from:to:cc:subject:date:message-id:reply-to;
 bh=F2yAYYBK5Idg3mVjplhEp+hgexJeLdI0/aBpgj88mUU=;
 b=lnjwa/gO9ItPzAo7fwl7CnAmvmFWGyqUcPbbLMprQEaoW67Nahb/KwWbSHvLArpmmV
 UMkWD8RiyB1qT9EGsz4kQTZhgAlZMYFduVCLnhic8NTByAxav9yy1R0btdtnMMNgH8RN
 QpRAIqQuKM2ui4gr/I6um7uIfj8Z9/I558bpjl7+PIU/1vs8KU0WybgYHOoA/syRh2wU
 +OpIerXDxIqGUEOlEDRnNaKZHgpHiMLniVW08mRGfOw7KzaIU2E0WpjhN3/kHoANeeUP
 etWuFEHypPP6wzgrTmby91seUGWCvM34JkUEydUp4/LgX5jdrKRSDk/aDp0EPrpw4pRW
 JH4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735605435; x=1736210235;
 h=to:from:cc:content-transfer-encoding:mime-version:message-id:date
 :subject:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=F2yAYYBK5Idg3mVjplhEp+hgexJeLdI0/aBpgj88mUU=;
 b=eUMQ8nRsyQIquA8P8jRqH16KWzU3PFJNs9NFDRPJ7Ol1RkYGuWJtql/w8gX9Wxb242
 l+sOeawmrWeZb3b/6pYiWs/xLOKsLCUj4uWHiBQ+amB8GW1TtzqYRmdYPQ9jS5H2Gis9
 jzseq6fQT5WBvtxCaoQ1CAyZIWgLEYj/Thgq5DvwsLaQYDYNW/Mc70h7XBwzS+1G+VLv
 LVFXNMAI2mlG3aC3Lf9Iq1cCMNNK6jrtSodOIpZ87wLGtzdlo+8OAHOBCNG1TYfAts1H
 gZa2vNyO0qQro+6p1k0t6Fa7lWLxqJjO6CaRMy18flA3LjA91h8zAVTCaWnYKVHBklXd
 cp3w==
X-Gm-Message-State: AOJu0YwUcT80XkWPLpp8IoJKuScRw4DR7Lhz6SfRcthXZstLm53MSQ+r
 yoib37VLn10PjaNRgCFjl39GMaC5zrhfhLM/Wri00NrRgSKrhuKLzNX3NupUYn+NNfpWBuILQr7
 b
X-Gm-Gg: ASbGnctSpwi6HTUcX2jbjir9KJ6Bk+abvNO0I0JKMjwdn+J9tla5+aNiry91Obs+pDB
 BrRLswf+LZFPr3/HIVGGpExTuBfhlOfA8YAOYqGx5UoVh+JqyOAlsElLDMEN3MgLBDvAzdMWU+E
 /qqTCp37cbygW52UESGIViRRrTQpsGr0RKpu22YBqFYO4BDTcclOzXaI5B/BtAct2O5JAxNxjKV
 G7dSiqIBzGeyux00XnqjmpqWFOyrPobBn0dO327ZDtLkw0e2qI=
X-Google-Smtp-Source: AGHT+IE/AWOTszHUHtDpafE3qaXtf5KGoLf4JTW95pN+XrZuZ58jSfDBFbstrD9PLNosWr8Nde4ntQ==
X-Received: by 2002:a17:902:e886:b0:216:5e6e:68cb with SMTP id
 d9443c01a7336-219e6e9fd95mr561177575ad.16.1735603603622; 
 Mon, 30 Dec 2024 16:06:43 -0800 (PST)
Received: from localhost ([50.145.13.30]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-219dc964a8bsm183765495ad.8.2024.12.30.16.06.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Dec 2024 16:06:39 -0800 (PST)
Subject: [PATCH] drm/amd/display: Increase frame-larger-than warning limit for
 DCN401
Date: Mon, 30 Dec 2024 16:02:58 -0800
Message-ID: <20241231000257.8533-2-palmer@rivosinc.com>
X-Mailer: git-send-email 2.45.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: harry.wentland@amd.com, sunpeng.li@amd.com, Rodrigo.Siqueira@amd.com,
 alexander.deucher@amd.com, christian.koenig@amd.com, Xinhui.Pan@amd.com,
 airlied@gmail.com, 
 simona@ffwll.ch, hamza.mahfooz@amd.com, aurabindo.pillai@amd.com,
 wayne.lin@amd.com, Palmer Dabbelt <palmer@rivosinc.com>, moadhuri@amd.com,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
From: Palmer Dabbelt <palmer@rivosinc.com>
To: amd-gfx@lists.freedesktop.org
X-Mailman-Approved-At: Tue, 31 Dec 2024 10:35:23 +0000
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

From: Palmer Dabbelt <palmer@rivosinc.com>

Without this I get

  CC [M]  drivers/gpu/drm/amd/amdgpu/../display/dc/resource/dcn401/dcn401_resource.o
drivers/gpu/drm/amd/amdgpu/../display/dc/resource/dcn401/dcn401_resource.c: In function ‘dcn401_dpp_create’:
drivers/gpu/drm/amd/amdgpu/../display/dc/resource/dcn401/dcn401_resource.c:936:1: error: the frame size of 2720 bytes is larger than 2048 bytes [-Werror=frame-larger-than=]
  936 | }
      | ^

when building for RISC-V/allmodconfig.

Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
---
 drivers/gpu/drm/amd/display/dc/resource/Makefile | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/resource/Makefile b/drivers/gpu/drm/amd/display/dc/resource/Makefile
index 09320344d8e9..c2700a184f06 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/resource/Makefile
@@ -22,6 +22,13 @@
 # Makefile for the 'resource' sub-component of DAL.
 #
 
+ifneq ($(CONFIG_FRAME_WARN),0)
+ifeq ($(filter y,$(CONFIG_KASAN)$(CONFIG_KCSAN)),y)
+frame_warn_flag := -Wframe-larger-than=4096
+else
+frame_warn_flag := -Wframe-larger-than=3072
+endif
+endif
 
 ###############################################################################
 #  DCE
@@ -203,5 +210,6 @@ RESOURCE_DCN401 = dcn401_resource.o
 AMD_DAL_RESOURCE_DCN401 = $(addprefix $(AMDDALPATH)/dc/resource/dcn401/,$(RESOURCE_DCN401))
 
 AMD_DISPLAY_FILES += $(AMD_DAL_RESOURCE_DCN401)
+CFLAGS_$(AMD_DAL_RESOURCE_DCN401) := $(frame_warn_flag)
 
 endif
-- 
2.45.1

