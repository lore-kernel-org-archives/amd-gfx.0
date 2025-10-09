Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 629BCCCD18D
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Oct 2025 08:03:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4760110EB4D;
	Fri, 10 Oct 2025 08:03:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="KSQbhaHV";
	dkim-atps=neutral
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com
 [209.85.166.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 155F410EAD5
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Oct 2025 17:58:53 +0000 (UTC)
Received: by mail-il1-f169.google.com with SMTP id
 e9e14a558f8ab-42d7ef9a402so8852725ab.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 09 Oct 2025 10:58:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760032732; x=1760637532; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+5lAaOOjCc4ULiFrsiLFYK9hqRtLQli7F1TlUXtnya4=;
 b=KSQbhaHVff3etj+Um7dySfayvj9UMe8TeQJs4CTfYe09P7fe/7QbQjuJwIQCjvRmCk
 sXEK1G949wUN9rRFz9SzNKi44Ss0H9F7Iy0dtJ3lo3tTVOgZISdq+jaExv5JhovrmTTb
 6pwVJ5LuGeKYzxzV+VxUX7gPpvHqeH3YTTcXtW0RwSGkYHWLtx3thZg9BxIcQORtFzbp
 RipvvCxZLvlfLHJqSWlh098SkjS3Ywu+eI9j2sB8TzMS71hIHODSOesJkPGNvuOXH2O9
 Q6sz0+iIrFjCZzKj+cnvq7J25epwyHf+S7C8e3dtFiz4M9uuFDFF+7IAs2i5v76tP5jZ
 Ssbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760032732; x=1760637532;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+5lAaOOjCc4ULiFrsiLFYK9hqRtLQli7F1TlUXtnya4=;
 b=RBMIAH800ZAg+i4n61ST+wxWR9pLIXJxRrywMJpHkVygCczzCsdHBPc+ZmjJmuHlDr
 cO0WNgL2DerQ07dpkReriy+4O3oEG/wzMZQ4jjRrhtUaNYMvYRzehj27jbeWtz1qdQrM
 dTdH58Vg2WoMkqcZLUgPfjJnMMoLacSUOL7qdKeKgAuug3mQy8nUjKoLg2LkCSXKwcKt
 f/ogvdcZ//+m5JDPiorXVvv1uGQoZ3ePL1HZa2AV3ZVCbza6ARWt6ihm693nJYRywz1r
 2rDuZ1DzWYRpQFCmSpSm6AziUneeGI2bR//camTgu7rnaSN060fbuu4Aadt8NtYAhgC+
 65Cw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWEOcapuL+x+YkPpNcdhn379YNWuBCRhTbakVHv5Dd/LkReUk5iPgukcDvW6WO+8JCdg/tDUpaX@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw1s+/lI4l4UwYdHX4G5CwZNAHqbuQyscO64pwivZgI7JJggaci
 8oVxFVTD1Gtm2CpNmcH/GFF0CXi+//MKHsg6B2Wgc/7Ccu038tBXv5WV
X-Gm-Gg: ASbGncvIPlaPINLGas6nSyOP2JaiXhUDbYI1SFdkN3LKaJjygePMgGtnu5t4+Nx2fIX
 USEWpKaHsbQ32V825JDuPXV404+LrsZ6JbC1O9GwR7H64+CQXHgfeEE+zg9QLXDUfIPP9NA55CV
 CjInhjDWunmnBrmIEhlugkS6kTATBXOzvVmrs8uomOqK7N0lYmn2cDSWTb3Tv43LS5pHNmqQgkT
 xY6MEq9PewxzMVOczipDpbs3LllZbXBWoU/P21aj4oo2umXx/d0jZZI0Xixj1a8b6OQUDVuf4IS
 M4v2JdQ1G3tqCPDLQNOJQ7tOymLKm+qGNzIDRaZdv9j+GAXGqZmZx7xl7lQtfweztxBO5AB7/vb
 P70sS5ydD2vE/KcTovCM0EfeiC4/sE4xXq7QWVh1eEzy14iXWZEKFLRQinWrE9gJkWLm4SIhKiF
 gpk2/kGEXu37mUOGyROQeDLRHBiXQ8May2MbnNfQ==
X-Google-Smtp-Source: AGHT+IFFRLinxOs/9OTcYHa0TTaGH+h0f+hAtiRcea3Rwbgg5dAqda5gTWAF7gYArlA/stW+upYWUA==
X-Received: by 2002:a92:cdac:0:b0:405:d8c4:ab8f with SMTP id
 e9e14a558f8ab-42f7c3b2655mr137425675ab.14.1760032732136; 
 Thu, 09 Oct 2025 10:58:52 -0700 (PDT)
Received: from godzilla.raven-morpho.ts.net
 (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
 by smtp.googlemail.com with ESMTPSA id
 8926c6da1cb9f-58f7200c4afsm30256173.35.2025.10.09.10.58.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Oct 2025 10:58:51 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
To: jbaron@akamai.com
Cc: gregkh@linuxfoundation.org, ukaszb@chromium.org, louis.chauvet@bootlin.com,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org, intel-gvt-dev@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org, daniel.vetter@ffwll.ch,
 tvrtko.ursulin@linux.intel.com, jani.nikula@intel.com,
 ville.syrjala@linux.intel.com, Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v5 05/30] dyndbg: make ddebug_class_param union members same
 size
Date: Thu,  9 Oct 2025 11:58:09 -0600
Message-ID: <20251009175834.1024308-6-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251009175834.1024308-1-jim.cromie@gmail.com>
References: <20251009175834.1024308-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 10 Oct 2025 08:03:12 +0000
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

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
 include/linux/dynamic_debug.h | 2 +-
 lib/dynamic_debug.c           | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
index ff44ec346162..b9afc7731b7c 100644
--- a/include/linux/dynamic_debug.h
+++ b/include/linux/dynamic_debug.h
@@ -124,7 +124,7 @@ struct _ddebug_info {
 struct ddebug_class_param {
 	union {
 		unsigned long *bits;
-		unsigned int *lvl;
+		unsigned long *lvl;
 	};
 	char flags[8];
 	const struct ddebug_class_map *map;
diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 147540c57154..55df35df093b 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -799,7 +799,7 @@ int param_get_dyndbg_classes(char *buffer, const struct kernel_param *kp)
 
 	case DD_CLASS_TYPE_LEVEL_NAMES:
 	case DD_CLASS_TYPE_LEVEL_NUM:
-		return scnprintf(buffer, PAGE_SIZE, "%d\n", *dcp->lvl);
+		return scnprintf(buffer, PAGE_SIZE, "%ld\n", *dcp->lvl);
 	default:
 		return -1;
 	}
-- 
2.51.0

