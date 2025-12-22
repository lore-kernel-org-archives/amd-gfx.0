Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC9C6E67495
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Dec 2025 08:23:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6892610E5B3;
	Mon, 22 Dec 2025 08:23:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="eNza9X9c";
	dkim-atps=neutral
Received: from mail-pf1-f196.google.com (mail-pf1-f196.google.com
 [209.85.210.196])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5FBF010E568
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Dec 2025 08:22:40 +0000 (UTC)
Received: by mail-pf1-f196.google.com with SMTP id
 d2e1a72fcca58-7bb710d1d1dso5330009b3a.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Dec 2025 00:22:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1766391759; x=1766996559; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pKljsU8Xmw+/foisR3SYsx7mqK9N8s1wNDUiE0Eb/VY=;
 b=eNza9X9cWDOMp2GilAlg91Nzc21blG8h1Hc0U/KUi5BTUkG7ZybroPG41eRKjuhO5e
 A8tFirPssDMIwFgU9j306iDKiOpa4M7CUciZ5X7PGvKh7wEZRTRHsPE1oLaxhk/mhzMM
 EW9V35TGtd46aFBvkO42IyutYy6DrKt221sQyjWB0vlF0d0HYhFyZtCB18xoS4mFNcoA
 CAZrSiVTBTuK1Ay5esg2sxSt726VYJzjwyYtjguUUSDXOHVCzrZbHAz8lLkueLQ1gcqw
 S6o5JkDYr6JVd0s1y3RlSiEVnjgDUWglC/dDWElI5+w6qeTw4f09+SICD9/GgH/X8eAu
 YWZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766391759; x=1766996559;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=pKljsU8Xmw+/foisR3SYsx7mqK9N8s1wNDUiE0Eb/VY=;
 b=Dwf7ik3Vp/SYQUU0/UBr0/AR4SM0VrwZTPZIJEHV4EymREeKLv/yA/8BUWQoYnytv+
 s4srEYtG8dDRIRx5K1kNEWQH2MCN5o8b2YST4xO7AMzj9kbR/sIXktg+D0FZfE2Aa2hi
 D8CSUfotUfpfuDBhWKWHjhzJj0jjDLzXrrfRYH3s8JT6eeYh4CnHizWDNUVwPm6IGci0
 MqifsNEh+R0VqPS9/i5oQj1QLH8KsT8JjCrs9ehe8Xnj0xxbINPqt4Tg+AI6LBnnXLj+
 SQO9hGUEUCN8fBoMZR7EDdHGFxydxMSnBQbCjXUc4rxvSOfVM8oiNg5MO+zckXHtDiLD
 Wbhw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVHVQ9dw8LSnRNUVyc/itZLrjo08IIaasQ0Hqv03ccbFNUxsNGMdO0x79u2/hDwZ5WN8M7Qnwey@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyLAY+04gNG7YjrhpOWxkwm6RQ570UI1sRw54zQkPw1UJ7ndqnz
 1ZAVsu4b6Bs/siEPTQbDZu0lxt8FcAwfT9o7PzGIrvq63XtzBMle4Jo1
X-Gm-Gg: AY/fxX54PIfH/IEiDrTF/YzOiqMPfBwicN77x/KAGEHH0Q9HPMlhaQtlBHROKzGUc2K
 ZtVey/2ibFG6cYowbUpUj5kM2JgIDKGxPSTqIjWZT1lHOnSlYAi6dpXCmGyGnutbXw0II+KozF3
 kUgBJCgHAEgBRxtva0vYN4fH4Qrwpj13/yewXIJ+8KghLUbFVDXySl002R/kCNuLRFZDrHpVC+f
 alGKU4Lz/0CoVO2o4ByMwQTjKjScBOVBn43EgFUhjpKsQwWWiNDtl517KAHzH+lOZqJlhMVm4QX
 U/JRmF6MXQVOKYLBu7Hln0eTFArCRnyaQ3znvNa6H4s8V6BZd1m4Celqe6pt+mwKyKjeO5ITAzQ
 qslQgcsPGa41O7E/4RtkDJRZ7VnDQhsiia5rLUC19bjCAdUNId/UxXlQUZJOgNYpzMV2z+Ga27W
 05e919BP3g
X-Google-Smtp-Source: AGHT+IEbn13GAc82azOlCQBzD0kgiJPbfq4yJfKj6lNc2cko7ljpTpb+ZvesmNM1IQ0X0cprC78m6A==
X-Received: by 2002:a05:6a21:3395:b0:366:2341:4980 with SMTP id
 adf61e73a8af0-376a81dd746mr9694106637.11.1766391759442; 
 Mon, 22 Dec 2025 00:22:39 -0800 (PST)
Received: from frodo ([2404:4400:417e:3d00:8b90:7f55:1261:772f])
 by smtp.googlemail.com with ESMTPSA id
 d2e1a72fcca58-7ff7e493123sm9540699b3a.50.2025.12.22.00.22.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Dec 2025 00:22:38 -0800 (PST)
From: Jim Cromie <jim.cromie@gmail.com>
To: linux-kernel@vger.kernel.org, jbaron@akamai.com,
 gregkh@linuxfoundation.org, ukaszb@chromium.org, louis.chauvet@bootlin.com
Cc: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 intel-gvt-dev@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 daniel.vetter@ffwll.ch, tvrtko.ursulin@linux.intel.com,
 jani.nikula@intel.com, ville.syrjala@linux.intel.com,
 seanpaul@chromium.org, robdclark@gmail.com, groeck@google.com,
 yanivt@google.com, bleung@google.com, quic_saipraka@quicinc.com,
 will@kernel.org, catalin.marinas@arm.com, quic_psodagud@quicinc.com,
 maz@kernel.org, arnd@arndb.de, linux-arm-kernel@lists.infradead.org,
 linux-arm-msm@vger.kernel.org, mingo@redhat.com, jim.cromie@gmail.com
Subject: [PATCH v7 07/31] dyndbg: make ddebug_class_param union members same
 size
Date: Mon, 22 Dec 2025 21:20:24 +1300
Message-ID: <20251222082049.1782440-8-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251222082049.1782440-3-jim.cromie@gmail.com>
References: <20251222082049.1782440-3-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 22 Dec 2025 08:23:36 +0000
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
index 98a36e2f94b6..4b7c3b997657 100644
--- a/include/linux/dynamic_debug.h
+++ b/include/linux/dynamic_debug.h
@@ -103,7 +103,7 @@ struct _ddebug_info {
 struct ddebug_class_param {
 	union {
 		unsigned long *bits;
-		unsigned int *lvl;
+		unsigned long *lvl;
 	};
 	char flags[8];
 	const struct ddebug_class_map *map;
diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index cb171088850c..d2ff203d0873 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -810,7 +810,7 @@ int param_get_dyndbg_classes(char *buffer, const struct kernel_param *kp)
 
 	case DD_CLASS_TYPE_LEVEL_NAMES:
 	case DD_CLASS_TYPE_LEVEL_NUM:
-		return scnprintf(buffer, PAGE_SIZE, "%d\n", *dcp->lvl);
+		return scnprintf(buffer, PAGE_SIZE, "%ld\n", *dcp->lvl);
 	default:
 		return -1;
 	}
-- 
2.52.0

