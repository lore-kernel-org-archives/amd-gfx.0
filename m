Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3756C10ED67E
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Mar 2026 12:40:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B669510EE16;
	Fri, 27 Mar 2026 12:40:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="iUCWAdEA";
	dkim-atps=neutral
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com
 [209.85.160.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 797CD10EBF0
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Mar 2026 18:55:59 +0000 (UTC)
Received: by mail-oa1-f44.google.com with SMTP id
 586e51a60fabf-41c0aae84e5so971201fac.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Mar 2026 11:55:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774551359; x=1775156159; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TGwHOHakhEHhnxVqmZq5DXxfR0MylvY9XafKKBqzVj0=;
 b=iUCWAdEAO1gVfN4+XaMQq4vLDknq2x2vA66IcR8iNK0Etrr5URWKtVnhnhgskqXtJg
 6F2kvkc7x9hNhr5hAet7NCQW/3vGIDFZjUrZdYktGDUPy8fHsgEl39P2n2jMWAcal7RJ
 EPhqh2Ao0R2GwF9m3zOvhw6uOmXhMj/+MbiEFELbVi/KsSpfRt3e8VTdIpJmxdcP4eb9
 gTWAHEZ+yo+CTj2JbNfVrDx3KZ0XAtzYib8iZQKoWZ8aSyEpZf+iL6swukJ0fu+unndc
 bYdEYRW0vNlhobK3FQpjL6Tw91GINx7u/ZunMZ8OsRKfgI5uIUoCtCx3ZRe4W/SKiU2b
 DtZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774551359; x=1775156159;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=TGwHOHakhEHhnxVqmZq5DXxfR0MylvY9XafKKBqzVj0=;
 b=UP89B0Ye7BBe15uXTkKTgPfDqICWlu57zW5HRj25sDCemKrJVi6hG2fdMwwoEd36We
 wMxoexKaLTjfdIOODwJdsNAVFfKhmO+Y9DD5v85rACZiDfoBx8RuXZCeK0OAtdnJcRvR
 /1+OC3K+XmUQD06ycGcPLHN+TKXSNFQ0Bw/3iFwQHbNRif/yCfBv0V/miHtFidjbUXGe
 LwOGtsiBJDMpSdEzy94LuqU+B4Idq7oKTNpV4ImR/kARE094Y4EW7oFxh0Yqbr9lEB0U
 jmkBXU/RR+RQ1oBGFQp3oyrGIUHqKamukiXoGVgzZN84JrKCjWYhcfdwA+8vCG0NXgHT
 oRJg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXtXB6SmklaIl3018gyPLsT3I6yze5Fb1pxTnJzplMF1O+ikDvZKYA2FfOy/B/Yzp1f+qQcMhbu@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxHEceLaInNIc8CqponplDHzW/YOP4TJvzigyY+jrKiDKMjY3+r
 HnNJ0l+9MnpfbyzNnrkcHg7FLEY96wkqQDBX7sIKrPlcY8RVFLLP9T71
X-Gm-Gg: ATEYQzywO1QJioLZVvAzowU+FsFQUZMF+NhoohaffupdEzVSg30jN8pz9QLPRGWLILH
 PedN28rq3i0GS7wz/NRo/92AaR0POdlPdqyLGw9p+s+8yPvzeyY+bOw+dbCFhYngEbzr6rYdRHt
 VmNpBKY4nGBENd0EE0CdU6UWc9yO7bu8eDxCcmYAToNvwqsRncDm66FgtC0osI1gXQVWCGo0eEL
 Zcnj2vm0lkdnObCKSPpZs824pTUIq69+1FCigsiHjKKUKy/fujBmn0OEMg7jCfvgsRhw3uLTPhW
 R//tVIynJGBlnz6Bu8cL4eJDOkC7FQYTCoQa+T3d9eopM/UfVtRgS8x+/4BbTbEXVegUXw8WYxO
 RgxTquRGYGjnpyZMijnUseh1QpXvOqQ/Al6qhaYH1UZhS1C2Sbxwwu3Nnc53aTInBLLc17H3vaE
 C88/eWIWUGxQ8tloV0AqEDKc9nqH0ws/+nrJJ8vaegHd80Jkws
X-Received: by 2002:a05:6870:458c:b0:416:32c1:4276 with SMTP id
 586e51a60fabf-41ca7005de9mr4737216fac.28.1774551358609; 
 Thu, 26 Mar 2026 11:55:58 -0700 (PDT)
Received: from frodo (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
 by smtp.googlemail.com with ESMTPSA id
 586e51a60fabf-41cc7760c08sm3075171fac.4.2026.03.26.11.55.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2026 11:55:58 -0700 (PDT)
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
Subject: [PATCH v12 57/69] drm-dyndbg: add DRM_CLASSMAP_USE to vmwgfx driver
Date: Thu, 26 Mar 2026 12:54:01 -0600
Message-ID: <20260326185413.1205870-58-jim.cromie@gmail.com>
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

The vmwgfx driver has a number of DRM_UT_* debugs, make them
controllable when CONFIG_DRM_USE_DYNAMIC_DEBUG=y by telling dyndbg
that the module uses them.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 drivers/gpu/drm/vmwgfx/vmwgfx_drv.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c b/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c
index 0f101aedb49a..d877d0a8c830 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c
@@ -259,6 +259,8 @@ static int vmw_probe(struct pci_dev *, const struct pci_device_id *);
 static int vmwgfx_pm_notifier(struct notifier_block *nb, unsigned long val,
 			      void *ptr);
 
+DRM_CLASSMAP_USE(drm_debug_classes);
+
 MODULE_PARM_DESC(restrict_iommu, "Try to limit IOMMU usage for TTM pages");
 module_param_named(restrict_iommu, vmw_restrict_iommu, int, 0600);
 MODULE_PARM_DESC(force_coherent, "Force coherent TTM pages");
-- 
2.53.0

