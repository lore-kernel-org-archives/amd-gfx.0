Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0F01C7EE2C
	for <amd-gfx@archiver.kernel.org>; Tue, 30 May 2023 13:50:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4E4F910E395;
	Tue, 30 May 2023 13:50:30 +0000 (UTC)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4D1E410E13C
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 May 2023 11:22:56 +0000 (UTC)
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-3f6e68cc738so29887215e9.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 May 2023 04:22:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685445774; x=1688037774;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=97Z4eV9V3DldLgqN5w3lvvZak1iMnPtv9R7TQuTgF3g=;
 b=qTy8dyzuRWF/mj9Ze94/9J/+0Z2sGQBaJAgnWhmqj/4ynHpL3gZ6e+pQep6J5Yu+JJ
 +joQ6U+9S5qyMAU4uLLFXLFhzkWhj2F2L4VqyZZgoOp2Gp559XK6bwPBJcVUDozDooHD
 vVePYHYY47MYkTBOwwPFSix8x5zJuUfS6aMjHv6XGS7tmC2jrA7WJCl9XxDBYXZu9fxZ
 X8kfOb4AbDoaz7wXBq4mXSFurH/+VkJD8a14exMGg3FyJYEAQsT8VfP2JqAWg8VeaF8L
 5w7xfqw9PMZdM2yqHWvZ/LCCYuNp98b9xyPxHPhnGlh+Nzxiss5PQyWTaNn3isCjSCW7
 v73Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685445774; x=1688037774;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=97Z4eV9V3DldLgqN5w3lvvZak1iMnPtv9R7TQuTgF3g=;
 b=BiXgO69geM/ceKaEtyIG4UFTQPYqaH9RogGHk6+Tp7TVbURz/+UB+AM0piICn81Kjk
 NdbeoEMucI6PyMs4h7d+AyDyToQXO38lGBCmPQqL3het46F9JTOLsTuGVd/d+EqPQ5Wd
 7rZbZspUcAtUH/BnglOkUPECFFbzFSpQKlXE5OaBamDm+gi0Pc9+5Czz87yycjMRYsGy
 bMBuVoExIxsfTy1QKzhV6urFkAwbcBBi29FrQEARnLP1fZMjMQuGzR2K2AkXh01kq18g
 vsQBXm1B8LqkHgKBqs9/Tk+BbqiqfmY1f0PtFaK1guJKVbZQxQUQv723FK0vOj/zUtmx
 N7JQ==
X-Gm-Message-State: AC+VfDxelLZNO2ZUkq4QDYVgi+ZetlE61WzZt11RtitxLrBVdmSluQa/
 N0VMGG2KcX0TY66+4d5lacs/MQ==
X-Google-Smtp-Source: ACHHUZ4kU14nz6zYAt//WST+vJZjHT1A0ZslMCXW2yWFwv1A1FzuUkpwCt4nzo8X4FLfv/F4WQ33Hw==
X-Received: by 2002:a05:600c:250:b0:3f6:3bb:5135 with SMTP id
 16-20020a05600c025000b003f603bb5135mr1416524wmj.14.1685445774105; 
 Tue, 30 May 2023 04:22:54 -0700 (PDT)
Received: from localhost ([102.36.222.112]) by smtp.gmail.com with ESMTPSA id
 f13-20020a7bcd0d000000b003f60d0eef36sm20788514wmj.48.2023.05.30.04.22.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 May 2023 04:22:52 -0700 (PDT)
Date: Tue, 30 May 2023 14:22:49 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: chris@chris-wilson.co.uk
Subject: [bug report] drm: Track drm_mm allocators and show leaks on shutdown
Message-ID: <d870b9c1-fb95-41fd-820f-68f78ca39148@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailman-Approved-At: Tue, 30 May 2023 13:50:27 +0000
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
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hello Chris Wilson,

The patch 5705670d0463: "drm: Track drm_mm allocators and show leaks
on shutdown" from Oct 31, 2016, leads to the following Smatch static
checker warning:

	drivers/gpu/drm/drm_mm.c:1001 drm_mm_takedown()
	warn: sleeping in atomic context

drivers/gpu/drm/drm_mm.c
    991  * drm_mm_takedown - clean up a drm_mm allocator
    992  * @mm: drm_mm allocator to clean up
    993  *
    994  * Note that it is a bug to call this function on an allocator which is not
    995  * clean.
    996  */
    997 void drm_mm_takedown(struct drm_mm *mm)
    998 {
    999         if (WARN(!drm_mm_clean(mm),
    1000                  "Memory manager not clean during takedown.\n"))
--> 1001                 show_leaks(mm);
                         ^^^^^^^^^^^^^^^
The show_leaks() function does a GFP_KERNEL allocation but a couple
of the callers for drm_mm_takedown() are holding spinlocks so it's a
sleeping in atomic bug.

The problematic callers are ttm_range_man_fini_nocheck() and
amdgpu_gtt_mgr_fini().

    1002 }

regards,
dan carpenter
