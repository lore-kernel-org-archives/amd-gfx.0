Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A78510ED664
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Mar 2026 12:40:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4A5FC10EE20;
	Fri, 27 Mar 2026 12:40:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="mJhJjzTm";
	dkim-atps=neutral
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com
 [209.85.161.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 569EA10EBF1
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Mar 2026 18:55:55 +0000 (UTC)
Received: by mail-oo1-f52.google.com with SMTP id
 006d021491bc7-67de15e8452so1423120eaf.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Mar 2026 11:55:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774551354; x=1775156154; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rnDJitpTduufuEe6X95vH8IiBFUBoxeB6eQQOPNaxFg=;
 b=mJhJjzTm8qISXbzl5jpQyS4CG7SCSUDLI+0ASdFjNJPf7y4DlBcsex23kVzT8MpSo6
 HACOvlioMgkFt28hF3c/KTn18MFDVP48YOtG7eu5EAFChuNzUXatsVZQtwf0ud8TSdTO
 138YeFE+469ngqVh/LUjLnSkvSvW2apoHUvgGmNebys5QOiv15unTYxhmU0UFda7mfSh
 G0qioJsLGmUfxRp6nVZFavQgdLnlcJIh1+NfTsUqeA2R6gG40bZezwE33Tzczx3JZpUj
 YvrXb0d/8zbbBH+ZQEOY+eUXbK1tP3dh/WUEmD+RS5aPDPZqMkLEACukCkkruVG+7xus
 kKpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774551354; x=1775156154;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=rnDJitpTduufuEe6X95vH8IiBFUBoxeB6eQQOPNaxFg=;
 b=Va0mBNwd7sR6k8MhxBpGCYujMefJ2YivmKhlyCG5dEusaC9QSKrcrEGqenvB18+Jsz
 bTgBmtO242IpTa1OLkVkOCmF98Rg0kVkA9V/PQV+d4QxeXWmorRLFdJbSkSIooGtcWxM
 YR9lwAZqbdRyXkv6BHiemdzIGtQA1ND3D3PjU8HvJjYe3OuTvNFH+rJm6lPjjOWrxa5X
 kSdxfroXSa9u7I0MTK7cu368vwzzHw9c8fmdF+aAcfE8tWunw0ZZp00nCSPe32z3erz3
 F3B6fCT4CxMMvBAdtjp866f3neKj3gBll+YlyWVvWz2uA986pULqyUqaZPW7Rz65CK/f
 787A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUkwmsJIimUjVm/x2JUxg/Ye+DyGX3TUKToacRZ0Ta+xPLOSC5fmRhzUJkcUzdqBnsAhmpbFCXN@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyCX4Aw4jPXD2yHHUDOJta6MftGjeZve4wlCCrRLX/UR3oPpfog
 tr/u1v4kdn5LOumyRx61XfSSdxhMFUnSyiN9zFVIyqza1BonJkKGvE5C
X-Gm-Gg: ATEYQzxcoMcAOKgGlJtMuOANY20I10ljaIOD6J2gAPgITzNNsSPS6urg9ur1GjI29Mk
 fl5DJoox/oMJl1YZnG0CsrW8SsszjhljVV92nBOCdWfmnC8vfi7qvgVoPrdFRnxobGWNOQYUGUg
 fRQa0a6QagePouarulRYlxZF39pc/g/9AP4aM+JwqXDvISvWs8Uqsqok1zhk6pQ7uGkPGvf0OAd
 fuMtQx1USh01rjV8NGJM5Fd30QBvIKLAvD/E07ImiwrqQGNqlcxZlz8hy4GeY7v9W6nayLoh5rB
 9VECJt+Vqf9fKLVHnI+7IfCzEpfd+K8Cvz5Qf1pF6ADLC1JthH3MguE173y1G6vZ6gniTVGbMiG
 umVuErknQ5SFW+1LFjBuMEzurZ620871an2BbN79cgDJnAvo/7WFbq8sdB2rdlA9Lr3iK2Ar2RD
 0coIbrkq4tJqoy20NxDIM0n7bsY5aZO4v7cZOyCruXPgEwqQb5
X-Received: by 2002:a4a:bb88:0:b0:67c:2bfd:24a3 with SMTP id
 006d021491bc7-67e10ce7d8dmr943404eaf.20.1774551354565; 
 Thu, 26 Mar 2026 11:55:54 -0700 (PDT)
Received: from frodo (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
 by smtp.googlemail.com with ESMTPSA id
 586e51a60fabf-41cc7760c08sm3075171fac.4.2026.03.26.11.55.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2026 11:55:54 -0700 (PDT)
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
Subject: [PATCH v12 54/69] drm-dyndbg: add DRM_CLASSMAP_USE to etnaviv
Date: Thu, 26 Mar 2026 12:53:58 -0600
Message-ID: <20260326185413.1205870-55-jim.cromie@gmail.com>
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

etnaviv has 5 DRM_UT_CORE debugs, make them controllable when
CONFIG_DRM_USE_DYNAMIC_DEBUG=y by telling dyndbg that the module has
class'd debugs as well as plain-old pr_debug()s

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 drivers/gpu/drm/etnaviv/etnaviv_drv.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/etnaviv/etnaviv_drv.c b/drivers/gpu/drm/etnaviv/etnaviv_drv.c
index 08aca9035fc1..ef4423d4987f 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_drv.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_drv.c
@@ -26,6 +26,8 @@
 #include "etnaviv_mmu.h"
 #include "etnaviv_perfmon.h"
 
+DRM_CLASSMAP_USE(drm_debug_classes);
+
 /*
  * DRM operations:
  */
-- 
2.53.0

