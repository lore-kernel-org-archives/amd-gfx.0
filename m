Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80356C0219B
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Feb 2025 16:58:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 16E5910E715;
	Tue, 11 Feb 2025 16:58:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=aosc.io header.i=@aosc.io header.b="e/gML5h+";
	dkim-atps=neutral
X-Greylist: delayed 392 seconds by postgrey-1.36 at gabe;
 Tue, 11 Feb 2025 14:34:19 UTC
Received: from relay-us1.mymailcheap.com (relay-us1.mymailcheap.com
 [51.81.35.219])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1BAE710E6D0
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Feb 2025 14:34:19 +0000 (UTC)
Received: from relay5.mymailcheap.com (relay5.mymailcheap.com
 [159.100.248.207])
 by relay-us1.mymailcheap.com (Postfix) with ESMTPS id 33DF1205D5
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Feb 2025 14:27:46 +0000 (UTC)
Received: from relay4.mymailcheap.com (relay4.mymailcheap.com [137.74.80.155])
 by relay5.mymailcheap.com (Postfix) with ESMTPS id 4D7A7260EB
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Feb 2025 14:27:43 +0000 (UTC)
Received: from nf1.mymailcheap.com (nf1.mymailcheap.com [51.75.14.91])
 by relay4.mymailcheap.com (Postfix) with ESMTPS id 12A6E20319;
 Tue, 11 Feb 2025 14:27:40 +0000 (UTC)
Received: from mail20.mymailcheap.com (mail20.mymailcheap.com [51.83.111.147])
 by nf1.mymailcheap.com (Postfix) with ESMTPSA id A3F544023E;
 Tue, 11 Feb 2025 14:27:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=aosc.io; s=default;
 t=1739284059; bh=ykaLlg8HghwqKHvMRIYVlPnOo3Hdw86rjso/x8RKXFM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=e/gML5h+N4T5zFb+89aGoEeB/kIkhHUwClhA3fowiCFNwMwkWZpegyDva+y/A5YtS
 xsnvAzxxLoF+9PncyXNOsdEOxUdZVvbemNQKpiNT9T/tkbZMIZ1LklvXGqX4Is2ROr
 lANBFZsaWBqOIwuL5e1aR0edV2QwiWKWu8tf/TDo=
Received: from localhost.localdomain (unknown [58.32.42.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mail20.mymailcheap.com (Postfix) with ESMTPSA id A4F99406D3;
 Tue, 11 Feb 2025 14:27:36 +0000 (UTC)
From: Kexy Biscuit <kexybiscuit@aosc.io>
To: yangtiezhu@loongson.cn
Cc: amd-gfx@lists.freedesktop.org, chenhuacai@kernel.org, jpoimboe@kernel.org,
 linux-kernel@vger.kernel.org, loongarch@lists.linux.dev,
 peterz@infradead.org, Kexy Biscuit <kexybiscuit@aosc.io>
Subject: [PATCH] objtool: remove duplicate case value R_PPC64_REL32
Date: Tue, 11 Feb 2025 22:19:57 +0800
Message-ID: <20250211141956.553850-2-kexybiscuit@aosc.io>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20241217010905.13054-3-yangtiezhu@loongson.cn>
References: <20241217010905.13054-3-yangtiezhu@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: nf1.mymailcheap.com
X-Rspamd-Queue-Id: A3F544023E
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.90 / 10.00]; MID_CONTAINS_FROM(1.00)[];
 MIME_GOOD(-0.10)[text/plain]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_TLS_ALL(0.00)[];
 RCVD_COUNT_ONE(0.00)[1];
 ASN(0.00)[asn:16276, ipnet:51.83.0.0/16, country:FR];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; RCPT_COUNT_SEVEN(0.00)[8];
 SPFBL_URIBL_EMAIL_FAIL(0.00)[kexybiscuit.aosc.io:server fail];
 FROM_HAS_DN(0.00)[]; MIME_TRACE(0.00)[0:+];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_SOME(0.00)[];
 TO_DN_SOME(0.00)[]
X-Mailman-Approved-At: Tue, 11 Feb 2025 16:57:59 +0000
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

In arch/powerpc/include/uapi/asm/elf.h, R_PPC64_REL32 is defined as a
macro to R_PPC_REL32, makes the case value here being duplicate and
creates the following error...

arch/powerpc/decode.c: In function ‘arch_reloc_size’:
arch/powerpc/decode.c:114:9: error: duplicate case value
  114 |         case R_PPC64_REL32:
      |         ^~~~
arch/powerpc/decode.c:113:9: note: previously used here
  113 |         case R_PPC_REL32:
      |         ^~~~

Remove the duplicate case value to fix the error.

Fixes: "FROMLIST: objtool: Handle different entry size of rodata"
Signed-off-by: Kexy Biscuit <kexybiscuit@aosc.io>
---
This patch is required for this series to build on powerpc, however I'm
not sure if it's the preferred way... Please advise.

 tools/objtool/arch/powerpc/decode.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/objtool/arch/powerpc/decode.c b/tools/objtool/arch/powerpc/decode.c
index 3c95dd74fca0..7c0bf2429067 100644
--- a/tools/objtool/arch/powerpc/decode.c
+++ b/tools/objtool/arch/powerpc/decode.c
@@ -111,7 +111,6 @@ unsigned int arch_reloc_size(struct reloc *reloc)
 {
 	switch (reloc_type(reloc)) {
 	case R_PPC_REL32:
-	case R_PPC64_REL32:
 	case R_PPC_ADDR32:
 	case R_PPC_UADDR32:
 	case R_PPC_PLT32:
-- 
2.48.1

