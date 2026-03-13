Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15ED8107BCD5
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Mar 2026 16:51:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5EBC610ECB7;
	Fri, 13 Mar 2026 16:51:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="m3kl09Ol";
	dkim-atps=neutral
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com
 [209.85.167.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2657510EC25
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Mar 2026 13:24:40 +0000 (UTC)
Received: by mail-oi1-f176.google.com with SMTP id
 5614622812f47-4672076355aso1531072b6e.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Mar 2026 06:24:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773408279; x=1774013079; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rnDJitpTduufuEe6X95vH8IiBFUBoxeB6eQQOPNaxFg=;
 b=m3kl09OlQN5dK2iZ3NA0J2efr132PpZtDsIPxBXmaAKJ4RI0ksQkuzxGLA6izbl41V
 k74ar3fx3+22dsxwwqDJLTrI77Fppo8C7usxpODu7DgqrKgG+//9SEg13QZE0dMNV2Od
 iDuopc7myG6Bq6sgV9TWhkzhBbx/oMXUABnmnhW3DX4GBTXsNZqxM9nEtW8oS3PI3q11
 eVue2eMom4TE8QvVJGeCqAyG9PYXV1iV91BGY+xom+yXKM/vc2nrTq+ZeSHJm1I8wU+Y
 /ek9E0mOkrZfncmtkCXwH4Y0r6Oxc3AOKju4dNqkaCsMMOcEuyDgMmItIbHudzGrXqGj
 ZtNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773408279; x=1774013079;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=rnDJitpTduufuEe6X95vH8IiBFUBoxeB6eQQOPNaxFg=;
 b=VmcH5sVFzDfoEx0EQ4I2RR1XTuinGxqeDr3++gZ1BVXN43zUolXlPe6ASBU+WwcICX
 T+MK62TVIEo4lPlMbrntvA4Eji8LCBYm9b3ggTdcZPyyBb7TVPvXegzej0xP/lRCuLyx
 qofgfVm4Nisb6BmJNgbLuADrz3qGvV9QkuAyQn1HZFZwER6zjbMq3bvS7yh5vM4lb400
 ud7KzD+gSr2Na9Ke2Zuy+e/h1yx5USre81YHB45XH8LwQOgOe1W9jQhNbMxMHbpQS3zk
 qmPLjhBXUlDpbtlp54+WhuG+7udKu3pdd0bhfJjMCK+hzlL/yEEUD3xH1FgIHvhk2DxW
 RuBg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXJP3PrIS01qMG1pOAVvyOaMZuwvWnTX6wyVraC+eavxRQu0aHnkXVX4t1D6wBw8n2knaUUkFhf@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzJQLMNFAvGtpw3fzVxDBvAwd/ZfPsT9sI1rNcDld2EHZx8yoy4
 VFtPW75y4g+XLae2vkXO+t7mea0jOOnwlUdidt2YRTSsP4ok6/IoiLox
X-Gm-Gg: ATEYQzwuUkgO+djCnyIw+i29g9fk3+FmBxZSB2ckQ6rC1fkNMRVcTC3pDGodZk3ZIZV
 J44simReQI9tTpCajrlpYkxm6Kskt2REMaMwrAzy73U27b0Yxx2OByQKJxkJjXT6+byh2Ek+MyB
 6Ir5xSPE/IiEMeT5tIfN2hPGMOES2mueFoyXxJBW/Jz46TtRRloqfhQRr+DQX0fXgkaOmeubRFs
 5Iinycah98nPG+GfiLctiX3ItAFaGmoUTWxqes8ROC7n2vpt23LtXG7W89Ej4viezbiM8xKDENw
 xXg7Xrp8boW3jPniVf9wFAB4PpCaLjAHpju4y9OzPE+2qafFUzkjSRVGwcY3ZRjjXq65XeAR5BU
 7QvmHGYPrR6UAuXQLNKCSu7Y4QQL2qyE4v0M4bXodk6h0D+xqTRC8LhFfBDFiCwvoL0Gz0L/ENy
 sITlcadjLjMQdC+1McFifB1vfm8L6GwnQxqPb7LW0A47/y7bc/
X-Received: by 2002:a05:6808:11cb:b0:464:305e:8fcc with SMTP id
 5614622812f47-4675713631amr1649395b6e.20.1773408279143; 
 Fri, 13 Mar 2026 06:24:39 -0700 (PDT)
Received: from frodo (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
 by smtp.googlemail.com with ESMTPSA id
 5614622812f47-4673434a35csm4795987b6e.20.2026.03.13.06.24.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Mar 2026 06:24:38 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
To: airlied@gmail.com, simona@ffwll.ch, jbaron@akamai.com,
 gregkh@linuxfoundation.org, Lucas Stach <l.stach@pengutronix.de>,
 Russell King <linux+etnaviv@armlinux.org.uk>,
 Christian Gmeiner <christian.gmeiner@gmail.com>,
 etnaviv@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Cc: Jim Cromie <jim.cromie@gmail.com>, mripard@kernel.org, tzimmermann@suse.de,
 maarten.lankhorst@linux.intel.com, jani.nikula@intel.com,
 ville.syrjala@linux.intel.com, christian.koenig@amd.com,
 matthew.auld@intel.com, arunpravin.paneerselvam@amd.com,
 louis.chauvet@bootlin.com, skhan@linuxfoundation.org, pmladek@suse.com,
 ukaszb@chromium.org, intel-gfx@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org
Subject: [PATCH v11 48/65] drm-dyndbg: add DRM_CLASSMAP_USE to etnaviv
Date: Fri, 13 Mar 2026 07:20:13 -0600
Message-ID: <20260313132103.2529746-49-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260313132103.2529746-1-jim.cromie@gmail.com>
References: <20260313132103.2529746-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 13 Mar 2026 16:51:10 +0000
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

