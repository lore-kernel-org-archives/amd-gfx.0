Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C9B3107BCCC
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Mar 2026 16:51:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8B12310EC60;
	Fri, 13 Mar 2026 16:51:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Aamel5+i";
	dkim-atps=neutral
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com
 [209.85.167.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 897D110EBF1
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Mar 2026 13:23:12 +0000 (UTC)
Received: by mail-oi1-f169.google.com with SMTP id
 5614622812f47-466f00535cfso1534245b6e.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Mar 2026 06:23:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773408192; x=1774012992; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6DJe7q9AzKIA5JE9j9dS7BkLMe6yLjsp/ulkOtgleYM=;
 b=Aamel5+i4EvQRqTbJeWKQTYzNrPJgUdLhphQaGIOxbMmoZuEEmzgtIlyL16GJ1t7H3
 BS2/izNHTkjAoiWAoAVCUW/MmRV1s+DCciAerYretcpqhmHAQWx+gB0bl4IdjcMSr0xU
 VVBewsyOYG5QRDHmq47pHp+wp+8I0l+fZVJy5IbiEtvGP+ivhheMTmCzx9BnvUrsH6dD
 8d8+oZa2GzlU+bu5qpnrdY91liaHyHj0OQN/c0krs6w0NHNZgmawFr3zjrrT8oNaDaVt
 Qo0usr1X7TKnKgT0V/oRyq0GOVtWn3YfG/vGRJIdkY0CbfjHh0yoWpSllOc9DW1wBjQi
 bpBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773408192; x=1774012992;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=6DJe7q9AzKIA5JE9j9dS7BkLMe6yLjsp/ulkOtgleYM=;
 b=q880cOF8OTYP2dJftBgqu/pQxAACCjELb3Oipgf+QtveA0UIP3vphw3mnUozR2wZIh
 YCGJmQ7yp0F4LitAB1ZQBmKgW/iMjaMOLHVzofVljHzVEgJ/RF0UPFZXbeiLPcWgKb5q
 t9dMrotnDP2IQhwYsz8LR3hdHiE3NFOBHEtHdO0qK8mtJn0rCtnc3QNuPU7XjyOHfV8H
 nCVFWptQsAXGrLGV4we9BPPc1CIITjKGQoW/mwc2ZFfS9OTOMx2RIm0xvDCnYaaZOgQi
 Zrs6ap0TH/fMlqEHWZ/S59ksOvHUU7K/YHJ0OthhHTSArUQsL6CZKML0o1KOfyRsvT/x
 JyHg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWYpv2fphsBCWDMJro3ssbd+hbsSKyoJmDoFtqjqN0W/bHDAQlsEKHOFAvZwzVxbFulbnQCgdbz@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwZ15WGXuhKBIG35YH60lf2MVtNXadM1pl/RS19M6i0Q4CsVqhn
 Ei0eT3se8fShRPJPOXBKWBjZ+oljuWplxn4Ei1ZhF9s3NpC88FLa6ZF0
X-Gm-Gg: ATEYQzwOQtXzRpitYD7k2/pYHmJU1DEFsayW26UVeC5STCJHUNzIeCwb8yNn5zfOC2H
 mmsvy5vWKrt0HxIV4nButSEAdGpbHxIzDJlz9XaLkucIDsusmj4fQI3ZUim30QtIH2ma4jZySf7
 VYoVjQY5zqsIXTAI00zIxAUbaGy5XXj0346U224RvDDQBhBW4wMjAha2PkL3VhKMjLS0ZAOadP3
 2BZnj8IH1mULP2zBBQ52CsOeTuIb8cazT6rKfVs6GE1r80KSYAJf+9CKUeBr91GEostynBNJjF3
 4cUFcQap+WI8IGgj6DpnKzoAa/RVmtjnIHWhsCBlvx0O/pI3honXdXa7Nuc8Rdnqf0eYZxoEhFq
 TilFm3jPlC2lrpNqrvfG3AVNeQxrMN6Xtxv0wshuJX6CnhfhS/jRXIbnrFsVYH7mksnkeAgep1c
 OEDe9yqa/0Q/VAA3jUT6LV+jrhvKYD5zg8kuuIM+eQQjXrWodpkoIo/lybhE0=
X-Received: by 2002:a05:6808:514b:b0:45f:59e:1e06 with SMTP id
 5614622812f47-467570a2074mr1690601b6e.4.1773408191750; 
 Fri, 13 Mar 2026 06:23:11 -0700 (PDT)
Received: from frodo (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
 by smtp.googlemail.com with ESMTPSA id
 5614622812f47-4673434a35csm4795987b6e.20.2026.03.13.06.23.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Mar 2026 06:23:11 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
To: airlied@gmail.com, simona@ffwll.ch, jbaron@akamai.com,
 gregkh@linuxfoundation.org, Jim Cromie <jim.cromie@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org
Cc: mripard@kernel.org, tzimmermann@suse.de, maarten.lankhorst@linux.intel.com,
 jani.nikula@intel.com, ville.syrjala@linux.intel.com,
 christian.koenig@amd.com, matthew.auld@intel.com,
 arunpravin.paneerselvam@amd.com, louis.chauvet@bootlin.com,
 skhan@linuxfoundation.org, pmladek@suse.com, ukaszb@chromium.org,
 dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org
Subject: [PATCH v11 08/65] dyndbg: make ddebug_class_param union members same
 size
Date: Fri, 13 Mar 2026 07:19:33 -0600
Message-ID: <20260313132103.2529746-9-jim.cromie@gmail.com>
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

struct ddebug_class_param keeps a ref to the state-storage of the
param; make both class-types use the same unsigned long storage type.

ISTM this is simpler and safer; it avoids an irrelevant difference,
and if 2 users somehow get class-type mixed up (or refer to the wrong
union member), at least they will both see the same value.

Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>
Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 include/linux/dynamic_debug.h | 2 +-
 lib/dynamic_debug.c           | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
index a10adac8e8f0..441305277914 100644
--- a/include/linux/dynamic_debug.h
+++ b/include/linux/dynamic_debug.h
@@ -104,7 +104,7 @@ struct _ddebug_info {
 struct ddebug_class_param {
 	union {
 		unsigned long *bits;
-		unsigned int *lvl;
+		unsigned long *lvl;
 	};
 	char flags[8];
 	const struct ddebug_class_map *map;
diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index a9caf84ddb22..ffa1cf7c2c72 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -811,7 +811,7 @@ int param_get_dyndbg_classes(char *buffer, const struct kernel_param *kp)
 
 	case DD_CLASS_TYPE_LEVEL_NAMES:
 	case DD_CLASS_TYPE_LEVEL_NUM:
-		return scnprintf(buffer, PAGE_SIZE, "%d\n", *dcp->lvl);
+		return scnprintf(buffer, PAGE_SIZE, "%ld\n", *dcp->lvl);
 	default:
 		return -1;
 	}
-- 
2.53.0

