Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B339C47BF2
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Jan 2026 14:00:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3D5DF10E2BC;
	Tue,  6 Jan 2026 14:00:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="eNtqMy1Z";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B5A6E10E3DE
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 Jan 2026 12:52:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767703962;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6VWZ/QqZENWpaP5ZlDrRpX55Me1mi2AKp72VpmjbLgI=;
 b=eNtqMy1ZvnSFhlRlNZYSS+o56cs7tEvPme2VYxfWqgdQA6ofghPaM2Zx2E1reZIl7BBv6/
 2ryWFJ5TaPcH3+/eHpz3++K4d1v0qXbnD9F4BCTkPxCOHl/mY//u9LPq+AHBrmtSR+ywr3
 lYJkEpJnltx4MgjR40EYhyRmaB9xx4Q=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-612-iQ6kWQC-MeyBEacBgOE78Q-1; Tue,
 06 Jan 2026 07:52:39 -0500
X-MC-Unique: iQ6kWQC-MeyBEacBgOE78Q-1
X-Mimecast-MFC-AGG-ID: iQ6kWQC-MeyBEacBgOE78Q_1767703957
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 93B92196C402; Tue,  6 Jan 2026 12:52:37 +0000 (UTC)
Received: from [10.44.33.27] (unknown [10.44.33.27])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0485830001A7; Tue,  6 Jan 2026 12:52:33 +0000 (UTC)
Date: Tue, 6 Jan 2026 13:52:28 +0100 (CET)
From: Mikulas Patocka <mpatocka@redhat.com>
To: =?ISO-8859-15?Q?Michel_D=E4nzer?= <michel.daenzer@mailbox.org>
cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
 Alex Deucher <alexander.deucher@amd.com>, 
 =?ISO-8859-15?Q?Christian_K=F6nig?= <christian.koenig@amd.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 David Hildenbrand <david@redhat.com>, amd-gfx@lists.freedesktop.org, 
 linux-mm@kvack.org, Vlastimil Babka <vbabka@suse.cz>, 
 Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>
Subject: Re: [PATCH v3 2/3] mm: only interrupt taking all mm locks on fatal
 signal
In-Reply-To: <e597171a-cc64-4811-a043-db2e539aaf94@mailbox.org>
Message-ID: <5dfbf2f9-0948-cd59-5c59-a6ee946ff9f2@redhat.com>
References: <b672e17b-461d-16ae-e7d3-45d3c1aab142@redhat.com>
 <7whbqlfrwjr4z2d4bpny3rjyl5tetdyx7ccf52uvby7hgywoym@6l6m2xcytez7>
 <e597171a-cc64-4811-a043-db2e539aaf94@mailbox.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 6arazUP6rKxbDTwssrGkDmodcUSxzzENsGkkVuQ2qKs_1767703957
X-Mimecast-Originator: redhat.com
Content-Type: multipart/mixed;
 BOUNDARY="-1463811712-1739719334-1767702910=:329667"
Content-ID: <4dd8c681-f09b-0e56-d450-138c4d923bc8@redhat.com>
X-Mailman-Approved-At: Tue, 06 Jan 2026 14:00:21 +0000
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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
---1463811712-1739719334-1767702910=:329667
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Content-ID: <0b5eb857-a42d-63b4-aa09-99752d29977a@redhat.com>



On Tue, 6 Jan 2026, Michel Dänzer wrote:

> On 1/5/26 19:15, Liam R. Howlett wrote:
> > * Mikulas Patocka <mpatocka@redhat.com> [260104 16:17]:
> >
> > I'm not saying it's wrong to change the signal handling, but this is
> > very much working around a bug in userspace constantly hammering a task
> > with signals and then is surprised there is a response that the kernel
> > was interrupted.
> 
> I'd go further than that. If user space fails to retry the system call 
> in response to -EINTR, that's a user-space bug, period. It can happen 
> anytime for any number of other reasons. (That most system calls happen 
> to get away without it most of the time doesn't make it not a bug)

So, I tried this - just for fun - and the machine doesn't even boot. I get 
a lot of errors about inability to open particular files on the console.

Userspace is buggy, according to your definition, regardless of whether 
you like it or not.

Mikulas

---
 fs/open.c |    3 +++
 1 file changed, 3 insertions(+)

Index: linux-2.6/fs/open.c
===================================================================
--- linux-2.6.orig/fs/open.c	2025-12-31 20:10:31.000000000 +0100
+++ linux-2.6/fs/open.c	2026-01-06 13:28:01.000000000 +0100
@@ -1419,6 +1419,9 @@ static int do_sys_openat2(int dfd, const
 	struct filename *tmp __free(putname) = NULL;
 	int err;
 
+	if (current->pid != 1 && !(get_random_u8() & 0x1))
+		return -EINTR;
+
 	err = build_open_flags(how, &op);
 	if (unlikely(err))
 		return err;
---1463811712-1739719334-1767702910=:329667--

