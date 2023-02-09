Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40CC3C05027
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Feb 2023 13:43:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DAE1610EAE8;
	Thu,  9 Feb 2023 13:43:51 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D441D10EAD2
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Feb 2023 13:41:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1675950060;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=OzV7p16/yEZQKmwWUFxj9RZMdMX7gGqoUkNDU++eOPw=;
 b=L9fnaGfd06AluNk7o4BdXtsyuJ3uQqdit/2s5BHbKCTOewP87RS6raPqb6NqykkF2du9nl
 xmO/UoGTBf3bBScgEcVrSXmaoPJfMRMH7Uj9j2Je0z9h18DjrGvpeacfJSq/3LsXnimUxY
 StWp+jNHqAwb+fih4uqjHWvu2XRtLh8=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-439-CCE5BFHQOm2b2ZHrO6CKuw-1; Thu, 09 Feb 2023 08:40:59 -0500
X-MC-Unique: CCE5BFHQOm2b2ZHrO6CKuw-1
Received: by mail-qt1-f198.google.com with SMTP id
 bs11-20020ac86f0b000000b003b9b4ec27c4so1077095qtb.19
 for <amd-gfx@lists.freedesktop.org>; Thu, 09 Feb 2023 05:40:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OzV7p16/yEZQKmwWUFxj9RZMdMX7gGqoUkNDU++eOPw=;
 b=jMdTbOnDgymvrbKmNR87JE/TRe1D7ZSrgakklPHgGboz1kUQDwO9WXqYSFx+fG1Bnp
 sXg7wdLXLoC5AX3c5fndaG7dgNfpYjh2db592ogvBMSZpz3Z4GiYvAtOwHva1lHNo+Pu
 5jJ3xvvQOt3dPdNheLmgq6JO4THfMMtHyhnEmp5dahC+XaDsv1VIU4W8SUMwFXD9+Shq
 xjut/o/PP/PmsOaeujK5o6MN3TK/zKRZMZ3nxsmaecucecIXKPvq7aDw5Qlj7qR1gvni
 A9dgaxy1gE7EVsHq9BM8LlkTB/i8zqbcbO7vBWRhzjr2T6totF3M5PhP/DVdukwTBSZE
 wYhw==
X-Gm-Message-State: AO0yUKVw8dUrYqK0SDo5NT2jjv7TDchPx5ygqQ62D9bg7fniumqhAV05
 xACPe6Zl12nSS0Urm1BoSvHdGfaPilfNt7Gx6GuY4R4qil4D9+PrlxjQIiwt9FPf8QfIZBr8z69
 lw7nw7l8BaLR58x0zfQmKDwdfZA==
X-Received: by 2002:a05:6214:2684:b0:56b:f2d7:f66d with SMTP id
 gm4-20020a056214268400b0056bf2d7f66dmr21321720qvb.46.1675950058604; 
 Thu, 09 Feb 2023 05:40:58 -0800 (PST)
X-Google-Smtp-Source: AK7set8nFqGwwydA/Qv//jTnLpI8YmlDl2IBDR+nilaOo8Jek16gZhJgf+ALhc6AphqS+W1bio6i8w==
X-Received: by 2002:a05:6214:2684:b0:56b:f2d7:f66d with SMTP id
 gm4-20020a056214268400b0056bf2d7f66dmr21321696qvb.46.1675950058373; 
 Thu, 09 Feb 2023 05:40:58 -0800 (PST)
Received: from localhost.localdomain.com (024-205-208-113.res.spectrum.com.
 [24.205.208.113]) by smtp.gmail.com with ESMTPSA id
 t187-20020ae9dfc4000000b0073902217c00sm224072qkf.23.2023.02.09.05.40.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Feb 2023 05:40:58 -0800 (PST)
From: Tom Rix <trix@redhat.com>
To: harry.wentland@amd.com, sunpeng.li@amd.com, Rodrigo.Siqueira@amd.com,
 alexander.deucher@amd.com, christian.koenig@amd.com, Xinhui.Pan@amd.com,
 airlied@gmail.com, daniel@ffwll.ch, Dmytro.Laktyushkin@amd.com,
 qingqing.zhuo@amd.com, Charlene.Liu@amd.com, nicholas.kazlauskas@amd.com,
 meenakshikumar.somasundaram@amd.com
Subject: [PATCH] drm/amd/display: set should_disable_otg
 storage-class-specifier to static
Date: Thu,  9 Feb 2023 05:40:49 -0800
Message-Id: <20230209134049.2000865-1-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true
X-Mailman-Approved-At: Thu, 09 Feb 2023 13:43:50 +0000
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
Cc: Tom Rix <trix@redhat.com>, dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

smatch reports
drivers/gpu/drm/amd/amdgpu/../display/dc/clk_mgr/dcn315/dcn315_clk_mgr.c:90:6:
  warning: symbol 'should_disable_otg' was not declared. Should it be static?

should_disable_otg() is only used in dcn315_clk_mgr.c, so it should be static

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_clk_mgr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_clk_mgr.c
index 8c368bcc8e7e..a737782b2840 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_clk_mgr.c
@@ -87,7 +87,7 @@ static int dcn315_get_active_display_cnt_wa(
 	return display_count;
 }
 
-bool should_disable_otg(struct pipe_ctx *pipe)
+static bool should_disable_otg(struct pipe_ctx *pipe)
 {
 	bool ret = true;
 
-- 
2.26.3

