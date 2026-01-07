Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3AA9D185FB
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Jan 2026 13:37:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 34AE110E728;
	Thu,  8 Jan 2026 13:37:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="CzbPETCG";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5DB6D10E086
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Jan 2026 20:14:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767816858;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/aAUU7oRurHReAnd439MKGK9jt+5i42ycUj2/5vO6Ag=;
 b=CzbPETCG9fj0MlRIN9bXsMBn/mIv8NCJif1IeW9JT0K/e9xyj5eC2XQRYH4mAKI+kLdLr3
 6I9JAYc2hgnmmbMJGxAfN2zVe++HK9s1u66DGb9BOAomf9GK7UeNKbZt/kNfYxbDTUv/nn
 lhsOhBIVBG/3FWIHVJPqno6klQVRbGQ=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-517-DjI8NVljOIqS7WoYWekLlA-1; Wed,
 07 Jan 2026 15:14:16 -0500
X-MC-Unique: DjI8NVljOIqS7WoYWekLlA-1
X-Mimecast-MFC-AGG-ID: DjI8NVljOIqS7WoYWekLlA_1767816855
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 02A8B18005B2; Wed,  7 Jan 2026 20:14:15 +0000 (UTC)
Received: from [10.44.33.27] (unknown [10.44.33.27])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B162C1956048; Wed,  7 Jan 2026 20:14:11 +0000 (UTC)
Date: Wed, 7 Jan 2026 21:14:09 +0100 (CET)
From: Mikulas Patocka <mpatocka@redhat.com>
To: Pedro Falcato <pfalcato@suse.de>
cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
 Alex Deucher <alexander.deucher@amd.com>, 
 =?ISO-8859-15?Q?Christian_K=F6nig?= <christian.koenig@amd.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 David Hildenbrand <david@redhat.com>, amd-gfx@lists.freedesktop.org, 
 linux-mm@kvack.org, Vlastimil Babka <vbabka@suse.cz>, 
 Jann Horn <jannh@google.com>
Subject: Re: [PATCH v3 2/3] mm: only interrupt taking all mm locks on fatal
 signal
In-Reply-To: <mfgqbtiqtl7cxzxhvu6ossi5umek2vpb2rag2bcqsof7ommvfz@uz6fqkc2jhik>
Message-ID: <2a209a2a-12dd-96ec-9f3b-46c9b19a468a@redhat.com>
References: <b672e17b-461d-16ae-e7d3-45d3c1aab142@redhat.com>
 <7whbqlfrwjr4z2d4bpny3rjyl5tetdyx7ccf52uvby7hgywoym@6l6m2xcytez7>
 <e60858c9-12a6-2b04-35ae-9d676f14db2a@redhat.com>
 <j3dy3g5mchtdzxldtnqu5nwaalbr6ec4ceim3nuu6nwcddmqjc@7dgzr4m7pli2>
 <6633f8ed-f432-f4c4-3fe2-8c14248cadab@redhat.com>
 <mfgqbtiqtl7cxzxhvu6ossi5umek2vpb2rag2bcqsof7ommvfz@uz6fqkc2jhik>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: VwX1r0ct3zrkFRWyum_bdkzh7JuDE22QbGAj8eUtuPU_1767816855
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
X-Mailman-Approved-At: Thu, 08 Jan 2026 13:37:29 +0000
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



On Tue, 6 Jan 2026, Pedro Falcato wrote:

> On Tue, Jan 06, 2026 at 09:19:59PM +0100, Mikulas Patocka wrote:
> > 
> > 
> > On Tue, 6 Jan 2026, Liam R. Howlett wrote:
> > 
> > > Okay, so the other call paths also end up getting the -EINTR from this
> > > function?  Can you please add that detail to the commit message?
> > 
> > Yes. I'd like to ask the GPU people to look at it and say how much damage 
> > this -EINTR could do. I don't know - I just saw the messages "Failed to 
> > register MMU notifier: -4" in the syslog.

I read the ROCm source code and it seems to restart all ioctls on EINTR or 
EAGAIN correctly.

So, this syslog message is harmless.

The only problem is that open() is not restarted (even if the signal has 
the SA_RESTART flag).

> > > Any other -EINTR system call will also cause you problems since you
> > > continuously send signals to your process, so we'll have to change them
> > > all for this to work?
> > 
> > I use SA_RESTART for the signals. And I retry all the syscalls on EINTR 
> > just in case SA_RESTART didn't work. So, I don't experience random 
> > failures in my code due to the periodic signal.
> > 
> > But there is code that I have no control over - such as the OpenCL shared 
> > library.
> 
> Right. So I am wondering if just returning -ERESTARTSYS (whether in
> mm_take_all_locks(), or in the AMD driver) would satisfy both parties.
> 
> Folks installing and using signals need to pay attention and set
> SA_RESTART, but that's already best practice when dealing with third-party
> code. open(2) should be transparently restartable.
> 
> WDYT?

I tested it with -ERESTARTSYS and it works. I get the messages 
"init_user_pages: Failed to register MMU notifier: -512" in the syslog - 
but that is benign.

Mikulas

