Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66D45F01818
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Mar 2026 08:53:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B6D7910ECAD;
	Fri,  6 Mar 2026 08:53:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="PX4ZsstA";
	dkim-atps=neutral
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com
 [209.85.161.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5466110E2ED
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Mar 2026 01:51:12 +0000 (UTC)
Received: by mail-oo1-f44.google.com with SMTP id
 006d021491bc7-662f30d3f1fso6451857eaf.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 05 Mar 2026 17:51:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772761871; x=1773366671; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Kg1pvIkGDhzpoqZiSRhgo/PesZkDB1/rihGlwx1MvAg=;
 b=PX4ZsstA23W9ANHLJGKInjgtZrPOrQmVQ4dUJDtASoI3qPHAxqP47KuELeMHfPyVsO
 K1iO6H2bo+tyr4yKRKgYhSoYd8cOvn+FS/7OWp6rVkpuo1cAkWq9WBrDOTKEz4sk8cOl
 J/OmP0Yd7wx7NA2bzBCOMAtpafroKpe2UxMRkurHoCEqZTC9oaJuJmOLaCkLFaajbTJ+
 YtwGuzQajGzpl5d4ccWim62Cr9XliIDl+BL91bEPleWENL/SK4VuTRoVuLQEX9Jc/uyi
 g19/Rwpc8Lppm5jBfCqTtEpaSqL33Ml3rCrT+dPizA3g1+rGa8o675Sjb+u2XysXPOkQ
 bA5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772761871; x=1773366671;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Kg1pvIkGDhzpoqZiSRhgo/PesZkDB1/rihGlwx1MvAg=;
 b=SGKCMrSD8lduoieIFP9SodGXXN7G8hiY0DYYUO8KIbz4kSEfu+mccnGkdE59kt4vvv
 g2L2kaWD9os/BSpMtdfRXZp2QsAQomdx+7UcvYeLcjLGuemxOdYTgObQsIppO5x3gXH0
 DsrvFfYz15NNLjVfaWL2ooKw8AlBZbRG/uqnwIym55/lN0yye+ye6a8zJDYAr1T7vqoG
 vEODO23coFZBY7Vd6rZa/FnGRuDYh6H8pDSLJs3fc+M6ujk+zG/EOYupNKJOF2kZ+u0d
 ssaaIm8J94EndlugXflpUdc/EcZ6n2IFpZ1QgYhX7L9czWlONiaR1GQGvEj7scSL6dbD
 jYgQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXc68AaJSpVPnYnJMAPM6PFosBQ7KUIHfHG0JzPJmyZuO18P5W+9PfnLrFrrpO1lX3J9W0yrEqI@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzPaOzvd0VCer0x3mfFOECJyLczNblRJnDHBrm06w0B1Z1gBHuL
 8jE6ISdE0JpatiJtdYN0+NCqy0LXU8pI1BBsTDYIGjVwga7QknaYc7u8FoB8pxOr
X-Gm-Gg: ATEYQzzl6fBY/mppz6UHaMRLCezWpPVjTdrtn6bhRirM62fiKDCw4JxAxfhEhZEJQpt
 ++pja8R1oQ12Zc94tW1xw5k1HMQmTQqpW94GDMPQXktgzdWEpvupVIiBuKhT9wWNmcd/+Cuu46O
 /F87Y85tIhbpuuoJm+/EAmjueKT8tQlDETz+PjoEdKImCVfv6C8kx8gi7AtA6v/CSGggGYMbjS2
 7mt5Nfez/Vd8312IRtZ/9eoapBX+iripThgVCtdMuCGSQo0Y0uijKiv4vOJwGWTqAJua/gf/0pN
 JHzGpWVQ0e42nUri9tN4I0IcsYy2EAMgb6MuVj3YpGSu/1wsOy88UtaU17ttSC60tRaQA7U/pU8
 7tPGr6AlF5Fpu6J3+FxK+L1lDFs5VCPm5u5t1qrMM9iAZcpGLHFOFk/klGPcbYhT2iBrnkGAJPb
 YC9JzSSd7CAx0DsBGpqHFEfzY6iiJntRtfL2VXP5d++0F98Kv3
X-Received: by 2002:a05:6820:1521:b0:679:c5f3:b1fe with SMTP id
 006d021491bc7-67b9c35cee8mr289127eaf.5.1772761871399; 
 Thu, 05 Mar 2026 17:51:11 -0800 (PST)
Received: from frodo (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
 by smtp.googlemail.com with ESMTPSA id
 006d021491bc7-67b9cc1a627sm115245eaf.6.2026.03.05.17.51.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Mar 2026 17:51:10 -0800 (PST)
From: Jim Cromie <jim.cromie@gmail.com>
To: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org, intel-gvt-dev@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org
Cc: Jim Cromie <jim.cromie@gmail.com>, Jason Baron <jbaron@akamai.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [RFC PATCH 5/7] dyndbg: hoist static_key_apply_queued up
Date: Thu,  5 Mar 2026 18:50:08 -0700
Message-ID: <20260306015022.1940986-6-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260306015022.1940986-1-jim.cromie@gmail.com>
References: <20260306015022.1940986-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 06 Mar 2026 08:52:54 +0000
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

hoist static_key_apply_queued from ddebug_change to exec_queries.
This can reduce IPIs when multiple queries are submitted together in
the same command-buffer, as when they're separated by by \n ; or %.
It won't affect single command submissions, or settings of
class-map-params, which are submitted 1 bit at a time.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 lib/dynamic_debug.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index e555a8dbdc27..80fa8d2143e8 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -386,8 +386,6 @@ static int ddebug_change(const struct ddebug_query *query, struct flag_settings
 			dp->flags = newflags;
 		}
 	}
-	pr_debug("applied queued updates to %d sites in total\n", nfound);
-	static_key_apply_queued();
 	mutex_unlock(&ddebug_lock);
 
 	return nfound;
@@ -719,10 +717,12 @@ static int ddebug_exec_queries(char *query, const char *modname)
 		}
 		i++;
 	}
-	if (i)
+	if (i) {
 		v2pr_info("processed %d queries, with %d matches, %d errs\n",
 			 i, nfound, errs);
-
+		pr_debug("applied queued updates to %d sites in total\n", nfound);
+		static_key_apply_queued();
+	}
 	if (exitcode)
 		return exitcode;
 	return nfound;
-- 
2.53.0

