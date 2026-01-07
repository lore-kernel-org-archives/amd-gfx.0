Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47968D185FA
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Jan 2026 13:37:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 359D410E72A;
	Thu,  8 Jan 2026 13:37:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="TiAGgbrW";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 863D410E086
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Jan 2026 20:29:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767817774;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EYBm4fsSKMIFV9VkRmhgrkSCmBstr4iH+VMnw9NmY+k=;
 b=TiAGgbrW5zzfJOA5RTua2TWx5KW8ptu8ODpDEOYu6vmnVZoBi7UQHpKPK0D5waNNqGK7O4
 qVYwW3kkP9LwdraMk8pnSbi+r2LWu9wNPS+s8g9RIBVlEWKQIgv8TfC9Im4YYirZa6e2/j
 I8qpWF0MJitWMcuOr2TUrmZcHnqqAGI=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-563-qSSJf_TFNOKML6QBkLcJVQ-1; Wed,
 07 Jan 2026 15:29:32 -0500
X-MC-Unique: qSSJf_TFNOKML6QBkLcJVQ-1
X-Mimecast-MFC-AGG-ID: qSSJf_TFNOKML6QBkLcJVQ_1767817770
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9849F1955DA7; Wed,  7 Jan 2026 20:29:29 +0000 (UTC)
Received: from [10.44.33.27] (unknown [10.44.33.27])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 70BC2180066A; Wed,  7 Jan 2026 20:29:26 +0000 (UTC)
Date: Wed, 7 Jan 2026 21:29:23 +0100 (CET)
From: Mikulas Patocka <mpatocka@redhat.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
cc: Alex Deucher <alexander.deucher@amd.com>, 
 =?ISO-8859-15?Q?Christian_K=F6nig?= <christian.koenig@amd.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 David Hildenbrand <david@redhat.com>, amd-gfx@lists.freedesktop.org, 
 linux-mm@kvack.org, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
 Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>, 
 Pedro Falcato <pfalcato@suse.de>
Subject: Re: [PATCH v3 3/3] amdgpu: don't report an error if the process was
 killed
In-Reply-To: <7ffacc33-9233-4fa1-a7d8-28fb3fbb8061@lucifer.local>
Message-ID: <06317034-2677-d2ca-b468-841a2076e84d@redhat.com>
References: <aca0147f-61be-30a3-eff5-cb981222aacc@redhat.com>
 <7ffacc33-9233-4fa1-a7d8-28fb3fbb8061@lucifer.local>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: E3DhtjiD8RxrGUi778NMTj7WOLXtfYyH3UnVzG9zZvE_1767817770
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



On Mon, 5 Jan 2026, Lorenzo Stoakes wrote:

> Gentle nudge to ask you to please thread these series emails properly in
> future.
> 
> Use something like:
> 
> git format-patch --cover-letter --thread ...
> 
> Or b4 or etc.
> 
> This is a nightmare to try to review without it.
> 
> Thanks!

I don't use git for patch development. I use quilt. I find git quite 
awkward when I need to move between multiple patches and update them 
independently.

I'll try to send the next version of this patchset using the 'quilt mail' 
command.

Mikulas

