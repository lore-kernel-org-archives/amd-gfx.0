Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A456CF6C17
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Jan 2026 09:14:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D4CF210E571;
	Wed,  7 Jan 2026 09:14:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="SvvJMHY8";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9757110E546
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 Jan 2026 18:12:50 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 2BF84434FE;
 Tue,  6 Jan 2026 18:12:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFBA7C116C6;
 Tue,  6 Jan 2026 18:12:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
 s=korg; t=1767723170;
 bh=7RWo5kCkraUDoq57VjbK3vtHJlUViu8hMIUnWPNU4PE=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=SvvJMHY8GZvf0rhRiXF+ngUuo5JoM8fBXf3Mn3NQVKG/YTyBOx4qR/KZkfGW+NO8K
 WK6XyJ4hwj+Aqy0mqisS4E5WMj9n6t2X1M7+en2gOWlIfFbyd7MqdRZ2yhaGsJkI5B
 QOWcpPmayIYNzA8ljDv0/REstaGB+lb4rQkxZdN4=
Date: Tue, 6 Jan 2026 10:12:49 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, Mikulas Patocka
 <mpatocka@redhat.com>, Christian =?ISO-8859-1?Q?K=F6nig?=
 <christian.koenig@amd.com>, David Hildenbrand <david@redhat.com>,
 amd-gfx@lists.freedesktop.org, linux-mm@kvack.org
Subject: Re: [PATCH v2] fix AMDGPU failure with periodic signal
Message-Id: <20260106101249.be7514e75c09a928c6fa71ef@linux-foundation.org>
In-Reply-To: <61c3d41d-602d-4dfc-872a-873acf653b6d@lucifer.local>
References: <6f16b618-26fc-3031-abe8-65c2090262e7@redhat.com>
 <61c3d41d-602d-4dfc-872a-873acf653b6d@lucifer.local>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Wed, 07 Jan 2026 09:14:38 +0000
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

On Tue, 6 Jan 2026 11:51:49 +0000 Lorenzo Stoakes <lorenzo.stoakes@oracle.com> wrote:

> I'm not sure if the git repos are lagging vs. quilt, but as reported this
> patch breaks the VMA tests, and the tests are _still_ broken.
> 
> Yet it's still in mm-new, mm-unstable, and even mm-hotfixes-unstable.
> 
> This is interfering with my work, can we please drop this.
> 
> Also the v3 is currently being debated, so surely should have been dropped
> until we have this resolved?

Well.  I don't drop fixes unless it's decided to be a non-issue or
unless a better fix is available.

I've done this for ever - I've held onto "wrong" fixes for *years*. 
View this as a weird issue-tracking system for a project which has no
issue-tracking system.  It's to prevent issues from falling through
cracks and getting lost.

It's unfortunate that this one causes disruption so I guess I'll loudly
comment it out and track the issue that way.
