Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 181A5C001B0
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Jul 2023 12:58:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2F60510E2FB;
	Mon, 24 Jul 2023 12:58:44 +0000 (UTC)
Received: from mail.208.org (unknown [183.242.55.162])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 145B410E27B
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Jul 2023 07:02:26 +0000 (UTC)
Received: from mail.208.org (email.208.org [127.0.0.1])
 by mail.208.org (Postfix) with ESMTP id 4R8WLg1kLyzBRx4b
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Jul 2023 15:02:19 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
 reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
 content-transfer-encoding:content-type:message-id:user-agent
 :references:in-reply-to:subject:to:from:date:mime-version; s=
 dkim; t=1690182139; x=1692774140; bh=D+4P5p5qab67/2JnjNtYcP9Rkun
 WsCExLiGCPkJOU9k=; b=jzyg4Ed4QSZ6URKfdmyUmjgSyc+iFU+jR8RBGOeUfSo
 tJHjbKPHToRyMpccgA2nU98kEAsTgxrhfPaa988QNjx8IQFMO5y8kBl0yWdxwwYj
 bLlkJOvx5ckGDo2XlTFqLZGeQ8t9QNpLDO7ewGngQfsvztd2VUwd9IN0JPzKJVP0
 c/m6jrTVcgk6oG8QSxTHOq3dj37QmtWtDzq4BSVOkc2HbU6ZBQ8aPBcAgyWPp25c
 1mlQXWMdNBLmjv+KKMhL0BGaGEJAKgegBMrtIn7oSdDuQWr8EMScBP8jXC2rsbhD
 xU3Lt4LsoaXbicQIxt0c0KjFQBzwOftvp/TvJdRCrGA==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
 by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id n6uvh7cLmzoO for <amd-gfx@lists.freedesktop.org>;
 Mon, 24 Jul 2023 15:02:19 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
 by mail.208.org (Postfix) with ESMTPSA id 4R8WLf5QW2zBRYmB;
 Mon, 24 Jul 2023 15:02:18 +0800 (CST)
MIME-Version: 1.0
Date: Mon, 24 Jul 2023 15:02:18 +0800
From: sunran001@208suo.com
To: airlied@gmail.com, daniel@ffwll.ch, alexander.deucher@amd.com
Subject: [PATCH] drm/amd/pm: add missing spaces before '('
In-Reply-To: <20230724070049.8540-1-xujianghui@cdjrlc.com>
References: <20230724070049.8540-1-xujianghui@cdjrlc.com>
User-Agent: Roundcube Webmail
Message-ID: <7ad78e88ddb94a0811947b48b04dfb2c@208suo.com>
X-Sender: sunran001@208suo.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Mon, 24 Jul 2023 12:58:34 +0000
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
Cc: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

ERROR: space required before the open parenthesis '('

Signed-off-by: Ran Sun <sunran001@208suo.com>
---
  drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c | 6 +++---
  1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c 
b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
index 8a8ba25c9ad7..a7569354229d 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
@@ -262,15 +262,15 @@ static int renoir_get_profiling_clk_mask(struct 
smu_context *smu,
  			/* mclk levels are in reverse order */
  			*mclk_mask = NUM_MEMCLK_DPM_LEVELS - 1;
  	} else if (level == AMD_DPM_FORCED_LEVEL_PROFILE_PEAK) {
-		if(sclk_mask)
+		if (sclk_mask)
  			/* The sclk as gfxclk and has three level about max/min/current */
  			*sclk_mask = 3 - 1;

-		if(mclk_mask)
+		if (mclk_mask)
  			/* mclk levels are in reverse order */
  			*mclk_mask = 0;

-		if(soc_mask)
+		if (soc_mask)
  			*soc_mask = NUM_SOCCLK_DPM_LEVELS - 1;
  	}
