Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31B72CC6B2D
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Oct 2026 12:48:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A761010FDA2;
	Wed, 14 Oct 2026 12:48:03 +0000 (UTC)
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F0E2410ECC8
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Oct 2026 22:40:27 +0000 (UTC)
Received: by mail-dl1-f70.google.com with SMTP id
 a92af1059eb24-1665200f4c2so4837737c88.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Oct 2026 15:40:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1791931227; x=1792536027;
 darn=lists.freedesktop.org; 
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=zqg4bcg4yTM1CSL1NV7gzxaOXxYgsDcagY96onRKZWw=;
 b=Xw3di7vhxstMXvUFMbRxQfGb4ObDMo6doJr+VO+YMJhzYsiIZ7q5BejUZguCr5hkpl
 R/xc3vTCxBQNIOXavbe6KAXGDfQRVtJ1QU2mCNl4zTcqvnA9a3uXPHrWVQmWzOHax1UI
 OkuKzpGWFYH4hXM86WhM8fGSg/K5iF2cy6PX/y5wihJj4mGqh/IDpWK6CK4fOskbKPWY
 lA3ZmB5WuwIRWkjC9XPf6rAo7EqilOG64BmCx3B+GSLr6nvqzr9/3FTHF9E4UjngaTqb
 35Ehq0peUGlnnrSFQHCMpE4CiTbzH7n1D6A1ZLj07cvdZsq6K3OHtq7WZISpMpnTzkAh
 7tSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791931227; x=1792536027;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=zqg4bcg4yTM1CSL1NV7gzxaOXxYgsDcagY96onRKZWw=;
 b=av0dYKCX036+QgU7NsA+tdJ9uZ7Lxe7o950kCjcXyc5PwmX6nLdsJYtkDEa5YsQxBJ
 1Ta1aV2Jy0A8h3xhnpm2i1+u6B4gHOZNLTfQY7VzQnRiAj/HOH2YReLq8c66XCWQ8XSp
 bK93hgP+zbM9lNCKU5ywG1WNjujJuGtg86N1Jqw8oXJqTd8hifkzKIQI0xX2T1RWbqjV
 Hwc/YHu5fFag9AoqIYO5ZDHQnBugLza6tWOTRexP1QpGywcVM3clYCXZKBaoMfkBzFQW
 aosrbiGmKO/vFMA3OHvqaw3gzCQ3U2Bt1FsIf1Vs5dbLRg9NC1bYstpSuRcNpoAwHUY7
 c/jA==
X-Forwarded-Encrypted: i=1;
 AKwUvByo+RsH36MG9wmi+QT21r2ISl7G+LAgiUAZWfLd3tjgQPLd53gjBIZge3al5HlrPLBL641M2WTv@lists.freedesktop.org
X-Gm-Message-State: AFq9FYL3e9NjiGbw3D34LKmTh42QxmrSyHH9gIu9f19pVWUryjqnEJeP
 Ez9RSkHjJiZaSeRSqvGpDok4FaMfB+vMl/AlrgrJkpVTaVX435ojanNBuiK0fW97B1hJFj6cB1+
 HRN+tulz/5Q==
X-Received: from dldyq19-n1.prod.google.com
 ([2002:a05:701b:4553:10b0:164:47f8:a96a])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:701b:4286:10b0:144:c128:4c4b
 with SMTP id a92af1059eb24-16a5e49c474mr18578865c88.36.1791931226644; Tue, 13
 Oct 2026 15:40:26 -0700 (PDT)
Date: Tue, 13 Oct 2026 15:39:41 -0700
In-Reply-To: <20261013223946.1836757-1-irogers@google.com>
Mime-Version: 1.0
References: <20261013223946.1836757-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.385.gd3acb90ef8-goog
Message-ID: <20261013223946.1836757-7-irogers@google.com>
Subject: [PATCH 06/11] dlm: Free dlm_ls in kobject release callback
From: Ian Rogers <irogers@google.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J . Wysocki" <rafael@kernel.org>, 
 Danilo Krummrich <dakr@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
 Kees Cook <kees@kernel.org>, Nathan Chancellor <nathan@kernel.org>
Cc: Nick Desaulniers <ndesaulniers@google.com>,
 Bill Wendling <morbo@google.com>, 
 Justin Stitt <justinstitt@google.com>, Jonathan Corbet <corbet@lwn.net>, 
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, 
 Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <chleroy@kernel.org>,
 Nayna Jain <nayna@linux.ibm.com>, 
 Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, 
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 Viresh Kumar <viresh.kumar@linaro.org>, 
 David Teigland <teigland@redhat.com>, Alexander Aring <aahringo@redhat.com>, 
 Juergen Gross <jgross@suse.com>, Stefano Stabellini <sstabellini@kernel.org>, 
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
 Heiko Carstens <hca@linux.ibm.com>, 
 Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>, 
 Richard Weinberger <richard@nod.at>, Zhihao Cheng <chengzhihao1@huawei.com>, 
 Felix Kuehling <Felix.Kuehling@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, 
 "=?UTF-8?q?Christian=20K=C3=B6nig?=" <christian.koenig@amd.com>,
 driver-core@lists.linux.dev, 
 llvm@lists.linux.dev, linux-hardening@vger.kernel.org, 
 linux-doc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
 linux-sh@vger.kernel.org, linux-pm@vger.kernel.org, 
 linux-acpi@vger.kernel.org, gfs2@lists.linux.dev, 
 xen-devel@lists.xenproject.org, linux-s390@vger.kernel.org, 
 linux-mtd@lists.infradead.org, amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Wed, 14 Oct 2026 12:47:38 +0000
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

struct dlm_ls embeds a struct kobject (ls_kobj), but dlm_ktype lacked a
.release callback and dlm freed the lockspace structure directly via
kfree(ls). With CONFIG_DEBUG_KOBJECT_RELEASE=y, freeing ls before the
kobject release runs causes a use-after-free.

Add dlm_ls_release() to free struct dlm_ls when the last reference to
ls_kobj is dropped, use kobject_del() in release_lockspace(), and drop
the final kobject reference in free_lockspace().

Fixes: 3514faca19a6 ("kobject: remove struct kobj_type from struct kset")
Assisted-by: Antigravity:gemini-3.1-pro
Signed-off-by: Ian Rogers <irogers@google.com>
---
 fs/dlm/lockspace.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/fs/dlm/lockspace.c b/fs/dlm/lockspace.c
index a9c98b4f378f..1d226b27d8e6 100644
--- a/fs/dlm/lockspace.c
+++ b/fs/dlm/lockspace.c
@@ -179,7 +179,15 @@ static const struct sysfs_ops dlm_attr_ops = {
 	.store = dlm_attr_store,
 };
 
+static void dlm_ls_release(struct kobject *kobj)
+{
+	struct dlm_ls *ls = container_of(kobj, struct dlm_ls, ls_kobj);
+
+	kfree(ls);
+}
+
 static struct kobj_type dlm_ktype = {
+	.release        = dlm_ls_release,
 	.default_groups = dlm_groups,
 	.sysfs_ops     = &dlm_attr_ops,
 };
@@ -355,7 +363,7 @@ static void free_lockspace(struct work_struct *work)
 	 */
 	rhashtable_free_and_destroy(&ls->ls_rsbtbl, rhash_free_rsb, NULL);
 
-	kfree(ls);
+	kobject_put(&ls->ls_kobj);
 }
 
 static int new_lockspace(const char *name, const char *cluster,
@@ -436,6 +444,8 @@ static int new_lockspace(const char *name, const char *cluster,
 	atomic_set(&ls->ls_count, 0);
 	init_waitqueue_head(&ls->ls_count_wait);
 	ls->ls_flags = 0;
+	ls->ls_kobj.kset = dlm_kset;
+	kobject_init(&ls->ls_kobj, &dlm_ktype);
 
 	if (ops && dlm_config.ci_recover_callbacks) {
 		ls->ls_ops = ops;
@@ -567,9 +577,7 @@ static int new_lockspace(const char *name, const char *cluster,
 	wait_event(ls->ls_recover_lock_wait,
 		   test_bit(LSFL_RECOVER_LOCK, &ls->ls_flags));
 
-	ls->ls_kobj.kset = dlm_kset;
-	error = kobject_init_and_add(&ls->ls_kobj, &dlm_ktype, NULL,
-				     "%s", ls->ls_name);
+	error = kobject_add(&ls->ls_kobj, NULL, "%s", ls->ls_name);
 	if (error)
 		goto out_recoverd;
 	kobject_uevent(&ls->ls_kobj, KOBJ_ADD);
@@ -615,7 +623,6 @@ static int new_lockspace(const char *name, const char *cluster,
 	rhashtable_destroy(&ls->ls_rsbtbl);
  out_lsfree:
 	kobject_put(&ls->ls_kobj);
-	kfree(ls);
  out:
 	module_put(THIS_MODULE);
 	return error;
@@ -759,7 +766,7 @@ static int release_lockspace(struct dlm_ls *ls, unsigned int release_option)
 
 	dlm_delete_debug_file(ls);
 
-	kobject_put(&ls->ls_kobj);
+	kobject_del(&ls->ls_kobj);
 
 	xa_destroy(&ls->ls_recover_xa);
 	kfree(ls->ls_recover_buf);
-- 
2.56.0.385.gd3acb90ef8-goog

