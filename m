Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0914AC2A077
	for <amd-gfx@archiver.kernel.org>; Mon,  5 Jan 2026 08:27:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9DBA010E1DB;
	Mon,  5 Jan 2026 08:27:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="TpSsv4YI";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D7AEB10E233
 for <amd-gfx@lists.freedesktop.org>; Sun,  4 Jan 2026 21:15:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767561349;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=IlIrsuj0G1VmQJQm2jrruKAmlWEPSsKvc1kYYbu0tgU=;
 b=TpSsv4YI3U4ZdSm19/lkCX7XQTpNNw5XysDjlIX/acMR1jMxWQFI1weq943LSsO6HHUHyc
 8W8tjUln/7mHKoI6qQPND46Yr+2gUI3k2aReD1Hof/ctA1W90ZnuTtF5/QcprObRQIYUBh
 VtFeKc42fgrgt19vgHDU+BlWMbKxN2c=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-367-YYmF9m-IP3aIT5zDsRAeDQ-1; Sun,
 04 Jan 2026 16:15:44 -0500
X-MC-Unique: YYmF9m-IP3aIT5zDsRAeDQ-1
X-Mimecast-MFC-AGG-ID: YYmF9m-IP3aIT5zDsRAeDQ_1767561342
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 793401956089; Sun,  4 Jan 2026 21:15:42 +0000 (UTC)
Received: from [10.44.33.27] (unknown [10.44.33.27])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0924C19560A7; Sun,  4 Jan 2026 21:15:38 +0000 (UTC)
Date: Sun, 4 Jan 2026 22:15:36 +0100 (CET)
From: Mikulas Patocka <mpatocka@redhat.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
cc: Alex Deucher <alexander.deucher@amd.com>, 
 =?ISO-8859-15?Q?Christian_K=F6nig?= <christian.koenig@amd.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 David Hildenbrand <david@redhat.com>, amd-gfx@lists.freedesktop.org, 
 linux-mm@kvack.org, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
 Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>, 
 Pedro Falcato <pfalcato@suse.de>
Subject: [PATCH v3 1/3] tools/testing/vma/vma_internal.h: provide
 fatal_signal_pending
Message-ID: <45dd9b02-7867-6e5a-4a64-02c4d43c9b68@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: PkXxUTkPK32dDZWTyzVbUcFBVOIt6VoIq-Qd4TOO25M_1767561342
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
X-Mailman-Approved-At: Mon, 05 Jan 2026 08:27:08 +0000
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

Provide a dummy function fatal_signal_pending, because it will be used in
the following patch in the function mm_take_all_locks.

This commit avoids a test failure when the following patch will be apllied.

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Cc: stable@vger.kernel.org

---
 tools/testing/vma/vma_internal.h |    5 +++++
 1 file changed, 5 insertions(+)

Index: mm/tools/testing/vma/vma_internal.h
===================================================================
--- mm.orig/tools/testing/vma/vma_internal.h	2026-01-04 21:19:10.000000000 +0100
+++ mm/tools/testing/vma/vma_internal.h	2026-01-04 21:19:10.000000000 +0100
@@ -1364,6 +1364,11 @@ static inline bool signal_pending(void *
 	return false;
 }
 
+static inline bool fatal_signal_pending(void *p)
+{
+	return false;
+}
+
 static inline bool is_file_hugepages(struct file *file)
 {
 	return false;

