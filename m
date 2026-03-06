Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B04AF01817
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Mar 2026 08:53:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2A51110ECA2;
	Fri,  6 Mar 2026 08:53:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="QVCdWYZo";
	dkim-atps=neutral
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com
 [209.85.161.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E166D10E2C2
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Mar 2026 01:50:58 +0000 (UTC)
Received: by mail-oo1-f43.google.com with SMTP id
 006d021491bc7-6775a46c6dfso3378360eaf.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 05 Mar 2026 17:50:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772761857; x=1773366657; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4BixrpmblYk1fVfc//g7Bejl2P3I3dQW/tYhS8Iov94=;
 b=QVCdWYZoEDsn6JhZMUKHhxVD9kq3sVmw1qCwV7duDjyYNhQvX57nPeH5hLnCSzhsAH
 hZKsqSJ5JVqvHaKGGosO9Lct5rLEYOHJzdZNBe5QwGFbFYr/OzDIpgZA/Pnw7GiLkfNQ
 lVXCydHByVgeH/0yJMTmV9z7an9SxvocK/kCsSUtJoWy4xWPPpRqW3EZg+m2KLjk1mAX
 fYpO3QC45BYvHjepIeYoKGrSmW5SuB8tLkhTnk1ayMP+L5mkuBJIAid3+zHl2lVqtp71
 BlbxoJcQ1jL2ZSiYNLYPX0itCFV3SDEeKEjP/BQdcbItOj6g+IczTqd4nWcz7cGFI1WP
 iQKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772761857; x=1773366657;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4BixrpmblYk1fVfc//g7Bejl2P3I3dQW/tYhS8Iov94=;
 b=ejqGH/wo9VedwdK7Yd4ubf2OKZhkjMbe3Q1wA5I8DXSUkP9brpxZeRqkEcv8YuvMof
 GBzOH/jQ3JEG6iTW6BLjv3JBs2QJr4ifc1yygt5YNc2G+8B7WQ2mR79Jc5TrxhiAcj4D
 MU5Rt67Gz9G1uLI7bbZ5eOPCafqqxChjEFBZdIqY/DLTHbeGs19kyO6r00VvXV8NF0Zn
 epc5vbCi1BkxgA3FK07aCLBLanHAWhi8M8xkNCnKYEIjvz0JNRl86PDHqj4DVe0hpDQN
 7r30nHssHHspYvn+zg1afyGVQ/o+uiEvcgT1BNSZkSsztxk8P1tib6KlAi+wSGYUK6tw
 QLiA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVV0HJiL+3Z0r1T7CWW7mOx2BXfwffiwe0pemepB94jOgb4FmHOcX6u5wFzNOLp1p/KTFA+Emea@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yxxovo4Bfgxsx2aAvhBV+WZBmlKqSt/mY3J3yZZRGWHCQGrp617
 qtYJCi9xu50Ny5JJ64BNwARWWGzmW4LZtwZTl7/73UAMF0d/6dDWOpNt
X-Gm-Gg: ATEYQzxRS9/EYfRUPOoDy33v5q+RIHX1J4Vt+D12ElSggSofidUiOojyXdwAhEzS020
 SRsDWGXPwH8OqyYQMBkZ0sGr5iwcDNsS1PW3Dvjxa32NpdrS8yl6foqL4zyXYh7k3LlrfOfN+VZ
 w3ziSKcN9CZk47fSEsef59eF7AwdKlUFGO6+GK5lfaWIbrhXqfNOun9VB4xKsB2EOcknAJIoXms
 Hw5jtrMorIzrZPfSbhu8v7dnZvWeLjLZ0FsNFDEaBxO1bfA4bk/TL3gKmiyO6+vb1R2dUHpYTGp
 ocFGrSlHXaGD/c21sUcSR1zomP2zzQv8zdKicD6qhjCHW2faK3cfzWLaB1L/NOy1dYPNnPQQDFZ
 e6IrO1BimTPevAUI5oZtww0WWNcgiDgYEs9etZpHAGWkgvHcQy/Uk6hPzxVi3ZG4Z9rNysgNE6M
 /er/PITJklNghm11KmfVAQXkg9pa7jgdvD4qYNZ/1GaAGsuTpX
X-Received: by 2002:a05:6820:4410:b0:677:2ac6:3beb with SMTP id
 006d021491bc7-67b9bd49539mr338521eaf.55.1772761856874; 
 Thu, 05 Mar 2026 17:50:56 -0800 (PST)
Received: from frodo (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
 by smtp.googlemail.com with ESMTPSA id
 006d021491bc7-67b9cc1a627sm115245eaf.6.2026.03.05.17.50.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Mar 2026 17:50:56 -0800 (PST)
From: Jim Cromie <jim.cromie@gmail.com>
To: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org, intel-gvt-dev@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org
Cc: Jim Cromie <jim.cromie@gmail.com>, Jason Baron <jbaron@akamai.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Josh Poimboeuf <jpoimboe@kernel.org>, Thomas Gleixner <tglx@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, Steven Rostedt <rostedt@goodmis.org>,
 Ard Biesheuvel <ardb@kernel.org>,
 Alexandre Chartre <alexandre.chartre@oracle.com>,
 Juergen Gross <jgross@suse.com>, Andy Lutomirski <luto@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, Kees Cook <kees@kernel.org>,
 Nathan Chancellor <nathan@kernel.org>,
 Lukas Bulwahn <lukas.bulwahn@redhat.com>
Subject: [RFC PATCH 1/7] jump_label: expose queueing API for batched static
 key updates
Date: Thu,  5 Mar 2026 18:50:04 -0700
Message-ID: <20260306015022.1940986-2-jim.cromie@gmail.com>
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

Currently, `HAVE_JUMP_LABEL_BATCH` provides an architecture-level
mechanism to defer instruction synchronization (`text_poke_sync()`)
when patching a sequence of static keys. However, this deferred
batching capability is not exposed as a public kernel API. Subsystems
that need to toggle a large number of static keys (e.g.,
dynamic_debug) currently suffer from O(N) overhead due to repeated
machine-wide synchronizations (stop_machine).

This patch introduces a public queueing API to expose this deferred
synchronization mechanism to the rest of the kernel. This allows
multiple static keys to be enabled/disabled by queueing their
architecture-level updates, before applying a single machine-wide
synchronization barrier after all instructions are modified.

The new API consists of:
- static_key_enable_queued(key)
- static_key_disable_queued(key)
- static_key_apply_queued() (the global barrier/flush)
- static_branch_enable_queued(x) / static_branch_disable_queued(x) macros

NOTES:

The '_queued' API suffix was chosen to match the underlying
'arch_jump_label_transform_queue' and to avoid confusion with the
existing rate-limited 'static_key_deferred' API.

Also unify the names under the 'static_key_*' prefix, renaming
jump_label_apply_queued to static_key_apply_queued (with a
compatibility macro) for consistency.

A pr_debug() is added to show the poked addresses, this exposed the
semi-random ordering coming from dynamic-debug, despite its ordered
descriptors.

So x86/kernel/alternatives gets new code to do an insert-sort, by
memcpy & memmove after appending.  This sorting yields a dramatic IPI
reduction; a following patch to dynamic-debug uses the API, and
includes the numbers.

Cc: Jason Baron <jbaron@akamai.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: Thomas Gleixner <tglx@kernel.org>
Cc: Alice Ryhl <aliceryhl@google.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: Alexandre Chartre <alexandre.chartre@oracle.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 arch/Kconfig                  |   3 +
 arch/x86/Kconfig              |   1 +
 arch/x86/kernel/alternative.c |  50 +++++++++-----
 arch/x86/kernel/jump_label.c  |  13 +++-
 include/linux/jump_label.h    |  24 +++++++
 kernel/jump_label.c           | 125 +++++++++++++++++++++++++++++++---
 6 files changed, 186 insertions(+), 30 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index 102ddbd4298e..388a73545005 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -505,6 +505,9 @@ config HAVE_ARCH_JUMP_LABEL
 config HAVE_ARCH_JUMP_LABEL_RELATIVE
 	bool
 
+config HAVE_JUMP_LABEL_BATCH
+	bool
+
 config MMU_GATHER_TABLE_FREE
 	bool
 
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index e2df1b147184..4d7705890558 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -249,6 +249,7 @@ config X86
 	select HAVE_IOREMAP_PROT
 	select HAVE_IRQ_EXIT_ON_IRQ_STACK	if X86_64
 	select HAVE_IRQ_TIME_ACCOUNTING
+	select HAVE_JUMP_LABEL_BATCH
 	select HAVE_JUMP_LABEL_HACK		if HAVE_OBJTOOL
 	select HAVE_KERNEL_BZIP2
 	select HAVE_KERNEL_GZIP
diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index a888ae0f01fb..85df82c36543 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -3137,26 +3137,19 @@ static void __smp_text_poke_batch_add(void *addr, const void *opcode, size_t len
 }
 
 /*
- * We hard rely on the text_poke_array.vec being ordered; ensure this is so by flushing
- * early if needed.
+ * We hard rely on the text_poke_array.vec being ordered; ensure this
+ * by finding where to insert to preserve the order, and mem-moving
+ * into place after appending it.
  */
-static bool text_poke_addr_ordered(void *addr)
+static int text_poke_get_insert_idx(void *addr)
 {
-	WARN_ON_ONCE(!addr);
+	int i;
 
-	if (!text_poke_array.nr_entries)
-		return true;
-
-	/*
-	 * If the last current entry's address is higher than the
-	 * new entry's address we'd like to add, then ordering
-	 * is violated and we must first flush all pending patching
-	 * requests:
-	 */
-	if (text_poke_addr(text_poke_array.vec + text_poke_array.nr_entries-1) > addr)
-		return false;
-
-	return true;
+	for (i = 0; i < text_poke_array.nr_entries; i++) {
+		if (text_poke_addr(&text_poke_array.vec[i]) > addr)
+			return i;
+	}
+	return text_poke_array.nr_entries;
 }
 
 /**
@@ -3174,9 +3167,30 @@ static bool text_poke_addr_ordered(void *addr)
  */
 void __ref smp_text_poke_batch_add(void *addr, const void *opcode, size_t len, const void *emulate)
 {
-	if (text_poke_array.nr_entries == TEXT_POKE_ARRAY_MAX || !text_poke_addr_ordered(addr))
+	int insert_idx;
+
+	pr_debug("incoming addr=%px, current_qlen=%d\n",
+		 addr, text_poke_array.nr_entries);
+
+	if (text_poke_array.nr_entries == TEXT_POKE_ARRAY_MAX)
 		smp_text_poke_batch_finish();
+
+	insert_idx = text_poke_get_insert_idx(addr);
 	__smp_text_poke_batch_add(addr, opcode, len, emulate);
+
+	if (insert_idx < text_poke_array.nr_entries - 1) {
+		struct smp_text_poke_loc tmp;
+		int last = text_poke_array.nr_entries - 1;
+		/* Copy the newly appended item out */
+		memcpy(&tmp, &text_poke_array.vec[last], sizeof(tmp));
+
+		/* Shift everything from insert_idx over by 1 */
+		memmove(&text_poke_array.vec[insert_idx + 1],
+			&text_poke_array.vec[insert_idx],
+			(last - insert_idx) * sizeof(struct smp_text_poke_loc));
+		/* Drop the new item into its sorted home */
+		memcpy(&text_poke_array.vec[insert_idx], &tmp, sizeof(tmp));
+	}
 }
 
 /**
diff --git a/arch/x86/kernel/jump_label.c b/arch/x86/kernel/jump_label.c
index a7949a54a0ff..6b5bab5f34e8 100644
--- a/arch/x86/kernel/jump_label.c
+++ b/arch/x86/kernel/jump_label.c
@@ -120,6 +120,8 @@ void arch_jump_label_transform(struct jump_entry *entry,
 	jump_label_transform(entry, type, 0);
 }
 
+static int jump_label_queue_len;
+
 bool arch_jump_label_transform_queue(struct jump_entry *entry,
 				     enum jump_label_type type)
 {
@@ -135,14 +137,23 @@ bool arch_jump_label_transform_queue(struct jump_entry *entry,
 
 	mutex_lock(&text_mutex);
 	jlp = __jump_label_patch(entry, type);
-	smp_text_poke_batch_add((void *)jump_entry_code(entry), jlp.code, jlp.size, NULL);
+	smp_text_poke_batch_add((void *)jump_entry_code(entry),
+				jlp.code, jlp.size, NULL);
+	jump_label_queue_len++;
 	mutex_unlock(&text_mutex);
 	return true;
 }
 
 void arch_jump_label_transform_apply(void)
 {
+	if (!jump_label_queue_len) {
+		pr_debug("no queued jump_labels to apply\n");
+		return;
+	}
+
+	pr_debug("applying %d queued jump_labels\n", jump_label_queue_len);
 	mutex_lock(&text_mutex);
 	smp_text_poke_batch_finish();
+	jump_label_queue_len = 0;
 	mutex_unlock(&text_mutex);
 }
diff --git a/include/linux/jump_label.h b/include/linux/jump_label.h
index fdb79dd1ebd8..17f572abe4bb 100644
--- a/include/linux/jump_label.h
+++ b/include/linux/jump_label.h
@@ -234,10 +234,20 @@ extern void static_key_slow_dec_cpuslocked(struct static_key *key);
 extern int static_key_count(struct static_key *key);
 extern void static_key_enable(struct static_key *key);
 extern void static_key_disable(struct static_key *key);
+extern void static_key_enable_queued(struct static_key *key);
+extern void static_key_disable_queued(struct static_key *key);
+extern void static_key_apply_queued(void);
 extern void static_key_enable_cpuslocked(struct static_key *key);
 extern void static_key_disable_cpuslocked(struct static_key *key);
 extern enum jump_label_type jump_label_init_type(struct jump_entry *entry);
 
+#define static_branch_enable(x)			static_key_enable(&(x)->key)
+#define static_branch_disable(x)		static_key_disable(&(x)->key)
+#define static_branch_enable_queued(x)		static_key_enable_queued(&(x)->key)
+#define static_branch_disable_queued(x)		static_key_disable_queued(&(x)->key)
+#define static_branch_enable_cpuslocked(x)	static_key_enable_cpuslocked(&(x)->key)
+#define static_branch_disable_cpuslocked(x)	static_key_disable_cpuslocked(&(x)->key)
+
 /*
  * We should be using ATOMIC_INIT() for initializing .enabled, but
  * the inclusion of atomic.h is problematic for inclusion of jump_label.h
@@ -340,6 +350,18 @@ static inline void static_key_disable(struct static_key *key)
 	atomic_set(&key->enabled, 0);
 }
 
+static inline void static_key_enable_queued(struct static_key *key)
+{
+	static_key_enable(key);
+}
+
+static inline void static_key_disable_queued(struct static_key *key)
+{
+	static_key_disable(key);
+}
+
+static inline void static_key_apply_queued(void) {}
+
 #define static_key_enable_cpuslocked(k)		static_key_enable((k))
 #define static_key_disable_cpuslocked(k)	static_key_disable((k))
 
@@ -535,6 +557,8 @@ extern bool ____wrong_branch_error(void);
 
 #define static_branch_enable(x)			static_key_enable(&(x)->key)
 #define static_branch_disable(x)		static_key_disable(&(x)->key)
+#define static_branch_enable_queued(x)		static_key_enable_queued(&(x)->key)
+#define static_branch_disable_queued(x)		static_key_disable_queued(&(x)->key)
 #define static_branch_enable_cpuslocked(x)	static_key_enable_cpuslocked(&(x)->key)
 #define static_branch_disable_cpuslocked(x)	static_key_disable_cpuslocked(&(x)->key)
 
diff --git a/kernel/jump_label.c b/kernel/jump_label.c
index 7cb19e601426..76a0f4e68b73 100644
--- a/kernel/jump_label.c
+++ b/kernel/jump_label.c
@@ -91,6 +91,7 @@ jump_label_sort_entries(struct jump_entry *start, struct jump_entry *stop)
 }
 
 static void jump_label_update(struct static_key *key);
+static void jump_label_update_queued(struct static_key *key);
 
 /*
  * There are similar definitions for the !CONFIG_JUMP_LABEL case in jump_label.h.
@@ -250,6 +251,41 @@ void static_key_disable(struct static_key *key)
 }
 EXPORT_SYMBOL_GPL(static_key_disable);
 
+void static_key_enable_queued(struct static_key *key)
+{
+	STATIC_KEY_CHECK_USE(key);
+
+	if (atomic_read(&key->enabled) > 0) {
+		WARN_ON_ONCE(atomic_read(&key->enabled) != 1);
+		return;
+	}
+
+	jump_label_lock();
+	if (atomic_read(&key->enabled) == 0) {
+		atomic_set(&key->enabled, -1);
+		jump_label_update_queued(key);
+		atomic_set_release(&key->enabled, 1);
+	}
+	jump_label_unlock();
+}
+EXPORT_SYMBOL_GPL(static_key_enable_queued);
+
+void static_key_disable_queued(struct static_key *key)
+{
+	STATIC_KEY_CHECK_USE(key);
+
+	if (atomic_read(&key->enabled) != 1) {
+		WARN_ON_ONCE(atomic_read(&key->enabled) != 0);
+		return;
+	}
+
+	jump_label_lock();
+	if (atomic_cmpxchg(&key->enabled, 1, 0) == 1)
+		jump_label_update_queued(key);
+	jump_label_unlock();
+}
+EXPORT_SYMBOL_GPL(static_key_disable_queued);
+
 static bool static_key_dec_not_one(struct static_key *key)
 {
 	int v;
@@ -488,39 +524,59 @@ static bool jump_label_can_update(struct jump_entry *entry, bool init)
 	return true;
 }
 
-#ifndef HAVE_JUMP_LABEL_BATCH
 static void __jump_label_update(struct static_key *key,
 				struct jump_entry *entry,
 				struct jump_entry *stop,
 				bool init)
 {
+#ifndef HAVE_JUMP_LABEL_BATCH
 	for (; (entry < stop) && (jump_entry_key(entry) == key); entry++) {
 		if (jump_label_can_update(entry, init))
 			arch_jump_label_transform(entry, jump_label_type(entry));
 	}
-}
 #else
-static void __jump_label_update(struct static_key *key,
-				struct jump_entry *entry,
-				struct jump_entry *stop,
-				bool init)
-{
 	for (; (entry < stop) && (jump_entry_key(entry) == key); entry++) {
 
 		if (!jump_label_can_update(entry, init))
 			continue;
 
 		if (!arch_jump_label_transform_queue(entry, jump_label_type(entry))) {
-			/*
-			 * Queue is full: Apply the current queue and try again.
-			 */
 			arch_jump_label_transform_apply();
-			BUG_ON(!arch_jump_label_transform_queue(entry, jump_label_type(entry)));
+			WARN_ON_ONCE(!arch_jump_label_transform_queue(entry, jump_label_type(entry)));
 		}
 	}
 	arch_jump_label_transform_apply();
+#endif
 }
+
+static void __jump_label_update_queued(struct static_key *key,
+				      struct jump_entry *entry,
+				      struct jump_entry *stop,
+				      bool init)
+{
+#ifdef HAVE_JUMP_LABEL_BATCH
+	for (; (entry < stop) && (jump_entry_key(entry) == key); entry++) {
+
+		if (!jump_label_can_update(entry, init))
+			continue;
+
+		if (!arch_jump_label_transform_queue(entry, jump_label_type(entry))) {
+			arch_jump_label_transform_apply();
+			WARN_ON_ONCE(!arch_jump_label_transform_queue(entry, jump_label_type(entry)));
+		}
+	}
+#else
+	__jump_label_update(key, entry, stop, init);
+#endif
+}
+
+void static_key_apply_queued(void)
+{
+#ifdef HAVE_JUMP_LABEL_BATCH
+	arch_jump_label_transform_apply();
 #endif
+}
+EXPORT_SYMBOL_GPL(static_key_apply_queued);
 
 void __init jump_label_init(void)
 {
@@ -696,6 +752,27 @@ static void __jump_label_mod_update(struct static_key *key)
 	}
 }
 
+static void __jump_label_mod_update_queued(struct static_key *key)
+{
+	struct static_key_mod *mod;
+
+	for (mod = static_key_mod(key); mod; mod = mod->next) {
+		struct jump_entry *stop;
+		struct module *m;
+
+		if (!mod->entries)
+			continue;
+
+		m = mod->mod;
+		if (!m)
+			stop = __stop___jump_table;
+		else
+			stop = m->jump_entries + m->num_jump_entries;
+		__jump_label_update_queued(key, mod->entries, stop,
+					   m && m->state == MODULE_STATE_COMING);
+	}
+}
+
 static int jump_label_add_module(struct module *mod)
 {
 	struct jump_entry *iter_start = mod->jump_entries;
@@ -919,6 +996,32 @@ static void jump_label_update(struct static_key *key)
 		__jump_label_update(key, entry, stop, init);
 }
 
+static void jump_label_update_queued(struct static_key *key)
+{
+	struct jump_entry *stop = __stop___jump_table;
+	bool init = system_state < SYSTEM_RUNNING;
+	struct jump_entry *entry;
+#ifdef CONFIG_MODULES
+	struct module *mod;
+
+	if (static_key_linked(key)) {
+		__jump_label_mod_update_queued(key);
+		return;
+	}
+
+	scoped_guard(rcu) {
+		mod = __module_address((unsigned long)key);
+		if (mod) {
+			stop = mod->jump_entries + mod->num_jump_entries;
+			init = mod->state == MODULE_STATE_COMING;
+		}
+	}
+#endif
+	entry = static_key_entries(key);
+	if (entry)
+		__jump_label_update_queued(key, entry, stop, init);
+}
+
 #ifdef CONFIG_STATIC_KEYS_SELFTEST
 static DEFINE_STATIC_KEY_TRUE(sk_true);
 static DEFINE_STATIC_KEY_FALSE(sk_false);
-- 
2.53.0

