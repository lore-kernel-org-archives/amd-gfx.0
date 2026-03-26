Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7015810ED66E
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Mar 2026 12:40:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4D1D110ED80;
	Fri, 27 Mar 2026 12:40:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Mj9P+dgz";
	dkim-atps=neutral
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com
 [209.85.160.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E337610EBF1
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Mar 2026 18:55:57 +0000 (UTC)
Received: by mail-oa1-f49.google.com with SMTP id
 586e51a60fabf-40974bf7781so1893961fac.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Mar 2026 11:55:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774551357; x=1775156157; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QeA7b49GNmqPBpy8bbweHTxpApMcFe3iFgz41hqVwCU=;
 b=Mj9P+dgzDwdhPEqBHMNGeOF1x5WytNOWdAS1R3h8ApNSURK0dDaCkk7Em5A67zQGXE
 /cYTajPQARaA0Q7Mcv12PfBgNwZ5oQpM9KEzdoqsM+uCTWkj/K614s+7m1M4lPV2FqGj
 kNWriKbUbFc8dbkpNS2422M16aBpNVqsiupHMEbLUFb95eNj3QFNnVJd6bL5wXnn2Sv3
 eTDIlnej+JrkTmNTsvXz8hbzxRHDeLTMXmnItErF9NgrQm9JOwahvvwS6dAlEFGg967H
 qBiDurL3Pm/H4RLHRUxfdNL/Bwdz461poBO7jieXsL337UrF0eyklsmGR5UT9aeRzs2G
 MaYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774551357; x=1775156157;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=QeA7b49GNmqPBpy8bbweHTxpApMcFe3iFgz41hqVwCU=;
 b=fncJYhBgGwz898cDBqcjTjcf0n9dEjEALD1N6nEJ69o+YIpGKAXDr6VhyWnoFEB+MY
 otO4THYXZKcDQ0ZjIrzIYckgDhB17CX8kJBwgR/BkJmOQtZp8ZZQMRcYZDdy7rnRTE0W
 8CtGVnr4XOG1kq3Ny9jjaaXENYbXe9aM+U7Ck1BuU7YhH4ac+FUvrGDECaOILq4+MYNG
 livmZTpwemBjU3ckdpNX7eOKYLoyNVUWaNkCY/c65/nLHbCm+IjwModtoQ0/+lUCBUuI
 qbQgk+WhTC6pAPt/Y6G4GhoVF073eq9HCLjV42LTjXfM5RepeyQSDGHh+Dv26K1i6Zoz
 YmGA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU7Z7ewCI0tt/c/wmBEBlqZ6DGllWE6D7Pb/j2Oau6BcqP0hER4Kttw6p9i0vjXbHEkx+ydZd7p@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxbqGoFJk13baie2mQrhzAhJCplKLjTueidd0oOqXBlt5HGJs7F
 FUVnGzBIbV8fFZoMST2y0cbhI2sdvFUpyIrkGtUqB0YAxEw4U79ix4fc
X-Gm-Gg: ATEYQzyJK7JkHiMOGhTUNs5ZmQJwx8VmFK58GdMECFoym94lwaEbybPdXB7hmjXNTFG
 jZA0LR8N8ZoQpNNTK0p1ELioXMZuFdvDkinpHujzSo2k7voMw60HH+YAApbA99LSXpn+Ds6Mc3w
 iB6jpK3X3pWqSHHW6K1e50CrS0i7i1RZPXEcaQUU+EjFjv8Bbbs4z5NKw0iObxzDxoKBykVp9ca
 bJa1BRCi92AuZ9ss2t60PMcWL1793tQ/TwdkfErEIL6hHfbE9Z+mHyHUjo5ssPa0FkLXS7C313M
 JyFr8IIOiqr2BViV4xOZcYHyC2hphaPn0fNWZ9JyqujTqK9AajM0Pr3eNIOHjwbj+hrF+UvYXbm
 hQa/a6tbg57F5YPECozRvRJH2By9ARaSSTyNHB7vTErM52hDvKR9g23hnQwZplXHxNYYiVxnkZH
 WJAGVRhdb1Fh45CJfW8kgh6YRHf+G/ewM3ITaQ7v04m/NMgxWs/jEgqkeWVHk=
X-Received: by 2002:a05:6871:4e41:b0:41c:4cd8:4e8a with SMTP id
 586e51a60fabf-41cd7bf490emr1301986fac.15.1774551357153; 
 Thu, 26 Mar 2026 11:55:57 -0700 (PDT)
Received: from frodo (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
 by smtp.googlemail.com with ESMTPSA id
 586e51a60fabf-41cc7760c08sm3075171fac.4.2026.03.26.11.55.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2026 11:55:56 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
To: linux-kernel@vger.kernel.org, airlied@gmail.com, simona@ffwll.ch,
 jbaron@akamai.com, gregkh@linuxfoundation.org
Cc: jim.cromie@gmail.com, mripard@kernel.org, tzimmermann@suse.de,
 maarten.lankhorst@linux.intel.com, jani.nikula@intel.com,
 ville.syrjala@linux.intel.com, christian.koenig@amd.com,
 matthew.auld@intel.com, arunpravin.paneerselvam@amd.com,
 louis.chauvet@bootlin.com, skhan@linuxfoundation.org, pmladek@suse.com,
 ukaszb@chromium.org, dri-devel@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
Subject: [PATCH v12 56/69] drm-dyndbg: add DRM_CLASSMAP_USE to radeon
Date: Thu, 26 Mar 2026 12:54:00 -0600
Message-ID: <20260326185413.1205870-57-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260326185413.1205870-1-jim.cromie@gmail.com>
References: <20260326185413.1205870-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 27 Mar 2026 12:40:00 +0000
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

radeon has some DRM_UT_* debugs, make them controllable when
CONFIG_DRM_USE_DYNAMIC_DEBUG=y by telling dyndbg about its use of
the class'd debugs.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 drivers/gpu/drm/radeon/radeon_drv.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/radeon/radeon_drv.c b/drivers/gpu/drm/radeon/radeon_drv.c
index 87fd6255c114..a7133fb6377d 100644
--- a/drivers/gpu/drm/radeon/radeon_drv.c
+++ b/drivers/gpu/drm/radeon/radeon_drv.c
@@ -254,6 +254,8 @@ static const struct pci_device_id pciidlist[] = {
 };
 MODULE_DEVICE_TABLE(pci, pciidlist);
 
+DRM_CLASSMAP_USE(drm_debug_classes);
+
 static const struct drm_driver kms_driver;
 
 static bool radeon_support_enabled(struct device *dev,
-- 
2.53.0

