Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D3B9CC6B1A
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Oct 2026 12:47:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D94ED10FD65;
	Wed, 14 Oct 2026 12:47:43 +0000 (UTC)
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1408910EA53
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Oct 2026 22:40:18 +0000 (UTC)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-351788121cfso4936550eec.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Oct 2026 15:40:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1791931217; x=1792536017;
 darn=lists.freedesktop.org; 
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=qdtOvNbLAOJ9idJnmqNXkxs2lXj3bNW1pL8KRmE6mUU=;
 b=mQS31v5EyK0zyMPvNJ/znK3Uhl7fLcPcG383xi3y1WT7YFpVQgf66w3l/Sed/pbh9q
 XCV0cgZl//WFsHY1uVEzIAbyGd5SFDXjweYXt1Qw1/xeZq1CynrtyEzroJP6GBKLxnhH
 /fSgmNKuKPYc4/jUQLCjRqd698cTTmDmmwtOxcxS4oJFxi3eTpG1C7EGiDMYYQiDeDkb
 EfHMptaZiF/mdZdd1kuFsBc5RbgD6nVvahvgfFwhoRMvXq/CXDayR772cYi+lRuqiMHl
 EKnp1ligXnlNoJXsx3hqKxtUC3R/F8KYjAFj/rO1VxZ4GuWHV3zV8tbBMIv2a0BWbk70
 a1AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791931217; x=1792536017;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=qdtOvNbLAOJ9idJnmqNXkxs2lXj3bNW1pL8KRmE6mUU=;
 b=Ps5rw6Hhy7FnHd1vXhKCsgIkFn6OO9pobGwGVEAhAdRA0xUBUx0oHiKPyRMLrGxvJg
 iheGGpGrSJSvqQSn8WSB/Oc/q2oUOJ8O2j3UzIBoiAkDSZr3IMEhKMFD1d+RBWz+eTQ8
 qdz1XqZRQDkFQXGpmYSM7dQlgFLaOluKpbVL7txqo0vct2Nf1IYd6yZcyxAs+rU40ar4
 6ropAQk4w4bnFtJKom+p3u+ufLnb7SZoM82ttiusWLF+/pLr4b2zfP5IWNfHw3BlrjgG
 qiQPzo5PxZ86CL14oN3Nw3Ah5Cm7j9eQY6EN6pkJQioBgL+RuqigVUb7fS0f4L6KMnsH
 3ZAQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzeGma1bTg4NLtqRucK8uk1aNbmzWplpPi+2C06H41Bq5apb4mmYZl6CHtPO2rBGp7nptujLLdz@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJQApfmU6IIT/ayQHYO/es38Kw8tL938ubKUZ0rA8bB0fWjxr6m
 Buzp2pMaLZnT6u9y7Z9DaYSBfs4IABbkpuUXq8OHAbLlHslHtXvQYYVn8mqpRFIE5rHeFq7whHx
 BRIIWJeVM1Q==
X-Received: from dycrm16.prod.google.com
 ([2002:a05:693c:2a10:b0:358:f250:485f])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:693c:4141:20b0:35c:8d1f:5634
 with SMTP id 5a478bee46e88-35c8d1f58e8mr4713972eec.12.1791931216820; Tue, 13
 Oct 2026 15:40:16 -0700 (PDT)
Date: Tue, 13 Oct 2026 15:39:37 -0700
In-Reply-To: <20261013223946.1836757-1-irogers@google.com>
Mime-Version: 1.0
References: <20261013223946.1836757-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.385.gd3acb90ef8-goog
Message-ID: <20261013223946.1836757-3-irogers@google.com>
Subject: [PATCH 02/11] powerpc/secvar: Add missing kobject release callback to
 secvar_ktype
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

In add_var(), a struct kobject is dynamically allocated with
kzalloc_obj() and initialized with secvar_ktype. If kobject_add() or
sysfs_create_file() fails, kobject_put(kobj) is called to clean up.
However, secvar_ktype does not define a .release callback, which results
in a memory leak of kobj (and a pr_debug warning in kobject_cleanup()
when CONFIG_DEBUG_KOBJECT_RELEASE is enabled).

Provide a secvar_release() callback that calls kfree(kobj).

Fixes: bd5d9c743d38 ("powerpc: expose secure variables to userspace via sysfs")
Assisted-by: Antigravity:gemini-3.1-pro
Signed-off-by: Ian Rogers <irogers@google.com>
---
 arch/powerpc/kernel/secvar-sysfs.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/powerpc/kernel/secvar-sysfs.c b/arch/powerpc/kernel/secvar-sysfs.c
index 395399bbab2c..f3f6ac25ea78 100644
--- a/arch/powerpc/kernel/secvar-sysfs.c
+++ b/arch/powerpc/kernel/secvar-sysfs.c
@@ -126,7 +126,13 @@ static const struct attribute_group secvar_attr_group = {
 };
 __ATTRIBUTE_GROUPS(secvar_attr);
 
+static void secvar_release(struct kobject *kobj)
+{
+	kfree(kobj);
+}
+
 static const struct kobj_type secvar_ktype = {
+	.release	= secvar_release,
 	.sysfs_ops	= &kobj_sysfs_ops,
 	.default_groups = secvar_attr_groups,
 };
-- 
2.56.0.385.gd3acb90ef8-goog

