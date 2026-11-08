Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB2C0606A33A
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Nov 2026 14:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=GCojNfz9
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 019C810F335;
	Mon,  9 Nov 2026 14:09:37 +0000 (UTC)
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DED5F10E111
 for <amd-gfx@lists.freedesktop.org>; Sun,  8 Nov 2026 22:39:46 +0000 (UTC)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-3724667bc16so320737eec.1
 for <amd-gfx@lists.freedesktop.org>; Sun, 08 Nov 2026 14:39:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20260707; t=1794177586; x=1794782386;
 darn=lists.freedesktop.org; 
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=xwXDua19Tz/IicJklctcGTeEqQvEHLiE8QZruqc+WN4=;
 b=GCojNfz9hW/94pt4pOCvqXASs0Wb5wbP+N9NIUihplJKFdb/6UHcbF2M/0mDiGYi/f
 jC8uRChq1So/dxMyWQrwEgkI19P336hOOwArts0xGaiN09YrCM/QpUIlp28axp+H0frz
 x/YiiOej7HpGpMNa8BZSZeEazFtPzo/GP3Nd1dP7JSPI2ydrLt9W6bQVnJYzXPOW3Aw4
 0nueGpdvY/KB77iT7Rn7wEkx2T7mKcREBisISfhmIlP5Cb9t6m/2CQeitwJRk1Xh2LXW
 JO4wgPbH+J8pWdsmCI1oSfqCAMFJBLu0jO29JuQZbgsqw7jaVIlxsrcXMoHDWeeQkfHB
 lJ3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794177586; x=1794782386;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=xwXDua19Tz/IicJklctcGTeEqQvEHLiE8QZruqc+WN4=;
 b=qQt2nRjFlcysZSLXf/3Yx146HHxDTnixESYIMAtNR7/f3zkPmve13H29f95LLmlLBH
 5q/GgimVve2TfM8hQFCvm7B1Ao4u8kTj0Yqqj3VrI0Ls2pv/9QPI7fOFB8q8F2U7Ach7
 a+K+1/br90qSnCxGPz6KFH+yk0CLEdXtKd43JVGN/iyzXUz+pBhoyymd7V94uYo6lfQs
 ibe80aETGRLub9hUvGsyHrpFz8PSY6/7eOux0vUufMBW9YqFMx3gckjqTeiSZY9GYqs5
 MDSVvzf2ee1aQy9GoIEMbQVVMGf+dXHzS7BimwYufGzi1LnvUfo+C1TLrvY7l3jpPD3K
 +QZA==
X-Forwarded-Encrypted: i=1;
 AL+hErE+py+JEyo4MNZtKuiu38htl0NAFbgbBEkZr6d23GUy8lGQsJqxZzfANcxHTGPC5xWt4pVqVIDJ@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8d2wXZ8lUsH6MAML4bHsAOBuMcdom+9lxTsnh/0nBWEjqVPCT+
 w5s/N6FVtjtf5F1arvQFl9o42PV2DYZ8L3nti7Bk3ul6FpVMY+c5rmamGvXIA+Dd/RBGrAtNdmj
 if7s/wMBdCA==
X-Received: from dyx10.prod.google.com ([2002:a05:693c:820a:b0:36a:eec:f68c])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7300:c00c:10b0:36d:dcdb:70c5
 with SMTP id 5a478bee46e88-370f7b8f918mr9710009eec.20.1794177585797; Sun, 08
 Nov 2026 14:39:45 -0800 (PST)
Date: Sun,  8 Nov 2026 14:39:07 -0800
In-Reply-To: <20261108223913.3624571-1-irogers@google.com>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261108223913.3624571-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.455.g6c5a503b38-goog
Message-ID: <20261108223913.3624571-4-irogers@google.com>
Subject: [PATCH v3 3/9] sh: sq: Add missing kobject release callback to
 ktype_percpu_entry
From: Ian Rogers <irogers@google.com>
To: Danilo Krummrich <dakr@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Kees Cook <kees@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
 "Rafael J . Wysocki" <rafael@kernel.org>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, 
 Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <chleroy@kernel.org>,
 Nayna Jain <nayna@linux.ibm.com>, 
 Srish Srinivasan <ssrish@linux.ibm.com>, Mimi Zohar <zohar@linux.ibm.com>, 
 Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, 
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 Juergen Gross <jgross@suse.com>, 
 Stefano Stabellini <sstabellini@kernel.org>, 
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
 Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <ndesaulniers@google.com>,
 Viresh Kumar <viresh.kumar@linaro.org>, 
 Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>,
 Alexander Aring <aahringo@redhat.com>, 
 Felix Kuehling <felix.kuehling@amd.com>, 
 "=?UTF-8?q?Christian=20K=C3=B6nig?=" <christian.koenig@amd.com>,
 Zhihao Cheng <chengzhihao1@huawei.com>, 
 Sumanth Korikkar <sumanthk@linux.ibm.com>, Bill Wendling <morbo@google.com>, 
 Justin Stitt <justinstitt@google.com>, driver-core@lists.linux.dev,
 llvm@lists.linux.dev, 
 linux-hardening@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-acpi@vger.kernel.org, 
 linux-pm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
 linux-sh@vger.kernel.org, linux-s390@vger.kernel.org, gfs2@lists.linux.dev, 
 xen-devel@lists.xenproject.org, linux-mtd@lists.infradead.org, 
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Mon, 09 Nov 2026 14:09:35 +0000
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

In sq_dev_add(), sq_kobject[cpu] is dynamically allocated with
kzalloc_obj() and initialized with ktype_percpu_entry. When
sq_dev_remove() calls kobject_put(kobj), the kobject is never freed
because ktype_percpu_entry lacks a .release callback.

Provide a sq_kobj_release() callback that calls kfree(kobj).

Fixes: d7c30c682a27 ("sh: Store Queue API rework.")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 arch/sh/kernel/cpu/sh4/sq.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/sh/kernel/cpu/sh4/sq.c b/arch/sh/kernel/cpu/sh4/sq.c
index 908a8e09113b..f33864958487 100644
--- a/arch/sh/kernel/cpu/sh4/sq.c
+++ b/arch/sh/kernel/cpu/sh4/sq.c
@@ -331,7 +331,13 @@ static const struct sysfs_ops sq_sysfs_ops = {
 	.store	= sq_sysfs_store,
 };
 
+static void sq_kobj_release(struct kobject *kobj)
+{
+	kfree(kobj);
+}
+
 static struct kobj_type ktype_percpu_entry = {
+	.release	= sq_kobj_release,
 	.sysfs_ops	= &sq_sysfs_ops,
 	.default_groups	= sq_sysfs_groups,
 };
-- 
2.56.0.455.g6c5a503b38-goog

