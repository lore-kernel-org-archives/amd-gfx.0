Return-Path: <SRS0=i1Lp=MX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D5DFC4338F
	for <amd-gfx@archiver.kernel.org>; Sat, 31 Jul 2021 21:42:34 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DFDBA60F39
	for <amd-gfx@archiver.kernel.org>; Sat, 31 Jul 2021 21:42:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org DFDBA60F39
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 98BA06E8F4;
	Sat, 31 Jul 2021 21:42:33 +0000 (UTC)
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com
 [IPv6:2607:f8b0:4864:20::12b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C7EB76E8F2;
 Sat, 31 Jul 2021 21:42:32 +0000 (UTC)
Received: by mail-il1-x12b.google.com with SMTP id r1so13010025iln.6;
 Sat, 31 Jul 2021 14:42:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=FVzAd0b7G06F+b9x5+FC/aHuzWCnZbaicUuNK8fUHeA=;
 b=im7afXLgSWUILaAASEAeZU/LwwVX1SZ6P517INeRbwmW2P/hFuwWJObGJH8hqMSqqj
 bcO77GbwKF8aa9UNSH2YQo6Jc0lfiHjybWGqyfM1sWZVmbaKm7G/AEhi94bV8Zauy049
 Mc95i1CHbX/T/92IWCD6PLmCQBaYSKTtRsvubIh5EWWT643Uxi5REtHwbJE/86rgawga
 4ZhtIzDi0lp1xjpELCec1MWDNg9ujPcI7cUvV/MLyoEdv3egmEC7JVqd4/xyxS51uVCK
 NQeVFQBKnUxB2Pcpha9cPwMO41WTZ3+RSw+NZb9ZalXrRlTLV7nOTEq/dVxUdzkSsvbl
 KJwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=FVzAd0b7G06F+b9x5+FC/aHuzWCnZbaicUuNK8fUHeA=;
 b=aJ+G5p7XNGjcH/58PwurQQFhDzgInzfkqVJgs9LM9Kzwrt4TZofhyUu6BGfVRAwiSq
 fMSoTaGThcldZTTroWiE9kKuIJdJ7knr0BwY+HtiQ/mcvUTrHNStMIMG9hW3RL705HWW
 TuvsYXk3VFTxEZsyrSAZcfatOlUs8Kg49H4Ebb78K6hIWahuVjZLVaSfrAZF79DDQs+7
 fcRaPCCAAua6ROxzufIuttlbpIn8gYKDJOQPkfqKjU9RTxwbMA6BaHjnOI9C07fQAc6F
 smbHnUKz8ePgELLT4r4JrgUxvpT8C0nTZFW0irJoicc+07GCug2BKbjg42b1rDjZxBnh
 AhXg==
X-Gm-Message-State: AOAM531ngjEPPxftZJmYdpndsHEIJDLLSnqu40H2v8rBRj5JweCkbYhO
 2sUxkC/Db2jLAL+aSvdiy68=
X-Google-Smtp-Source: ABdhPJwOVDZdNuyCxOD9UoCaMWITVwXrdhXAHTL3qSQNIVo5TmDJ1ed0abVTIJeR08hq9h9Tw27odg==
X-Received: by 2002:a92:d112:: with SMTP id a18mr5649773ilb.67.1627767752154; 
 Sat, 31 Jul 2021 14:42:32 -0700 (PDT)
Received: from frodo.. (c-24-9-77-57.hsd1.co.comcast.net. [24.9.77.57])
 by smtp.googlemail.com with ESMTPSA id q10sm3721040ion.3.2021.07.31.14.42.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 31 Jul 2021 14:42:31 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@linux.ie>,
 Daniel Vetter <daniel@ffwll.ch>, Harry Wentland <harry.wentland@amd.com>,
 Leo Li <sunpeng.li@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 "Pan, Xinhui" <Xinhui.Pan@amd.com>, Zhenyu Wang <zhenyuw@linux.intel.com>,
 Zhi Wang <zhi.a.wang@intel.com>, Jani Nikula <jani.nikula@linux.intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, Jason Baron <jbaron@akamai.com>,
 Ashley Thomas <Ashley.Thomas2@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>,
 Qingqing Zhuo <qingqing.zhuo@amd.com>, Wyatt Wood <Wyatt.Wood@amd.com>,
 Jim Cromie <jim.cromie@gmail.com>, Jessica Yu <jeyu@kernel.org>,
 Johan Hovold <johan@kernel.org>, Joe Perches <joe@perches.com>,
 Miguel Ojeda <ojeda@kernel.org>,
 Nick Desaulniers <ndesaulniers@gooogle.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, intel-gvt-dev@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org
Subject: [PATCH v4 2/7] moduleparam: add data member to struct kernel_param
Date: Sat, 31 Jul 2021 15:41:59 -0600
Message-Id: <20210731214211.657280-3-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210731214211.657280-1-jim.cromie@gmail.com>
References: <20210731214211.657280-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Add a void* data member to the struct, to allow attaching private data
that will be used soon by a setter method (via kp->data) to perform
more elaborate actions.

To attach the data at compile time, add new macros:
module_param_cbd() derives from module_param_cb(), adding data param.
It calls __module_param_call_wdata(), which has accepts new data
param and inits .data with it. Re-define __module_param_call() using it.

Use of this new data member will be rare, it might be worth redoing
this as a separate/sub-type to keep the base case.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 include/linux/moduleparam.h | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/include/linux/moduleparam.h b/include/linux/moduleparam.h
index eed280fae433..e9495b1e794d 100644
--- a/include/linux/moduleparam.h
+++ b/include/linux/moduleparam.h
@@ -78,6 +78,7 @@ struct kernel_param {
 		const struct kparam_string *str;
 		const struct kparam_array *arr;
 	};
+	void *data;
 };
 
 extern const struct kernel_param __start___param[], __stop___param[];
@@ -175,6 +176,9 @@ struct kparam_array
 #define module_param_cb(name, ops, arg, perm)				      \
 	__module_param_call(MODULE_PARAM_PREFIX, name, ops, arg, perm, -1, 0)
 
+#define module_param_cbd(name, ops, arg, perm, data)				\
+	__module_param_call_wdata(MODULE_PARAM_PREFIX, name, ops, arg, perm, -1, 0, data)
+
 #define module_param_cb_unsafe(name, ops, arg, perm)			      \
 	__module_param_call(MODULE_PARAM_PREFIX, name, ops, arg, perm, -1,    \
 			    KERNEL_PARAM_FL_UNSAFE)
@@ -284,14 +288,17 @@ struct kparam_array
 
 /* This is the fundamental function for registering boot/module
    parameters. */
-#define __module_param_call(prefix, name, ops, arg, perm, level, flags)	\
+#define __module_param_call(prefix, name, ops, arg, perm, level, flags) \
+	__module_param_call_wdata(prefix, name, ops, arg, perm, level, flags, NULL)
+
+#define __module_param_call_wdata(prefix, name, ops, arg, perm, level, flags, data) \
 	/* Default value instead of permissions? */			\
 	static const char __param_str_##name[] = prefix #name;		\
 	static struct kernel_param __moduleparam_const __param_##name	\
 	__used __section("__param")					\
 	__aligned(__alignof__(struct kernel_param))			\
 	= { __param_str_##name, THIS_MODULE, ops,			\
-	    VERIFY_OCTAL_PERMISSIONS(perm), level, flags, { arg } }
+	    VERIFY_OCTAL_PERMISSIONS(perm), level, flags, { arg }, data }
 
 /* Obsolete - use module_param_cb() */
 #define module_param_call(name, _set, _get, arg, perm)			\
-- 
2.31.1

