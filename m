Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BC0CC47BF0
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Jan 2026 11:43:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 225E410E479;
	Tue,  6 Jan 2026 11:43:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="ah+mVaBs";
	dkim-atps=neutral
X-Greylist: delayed 445 seconds by postgrey-1.36 at gabe;
 Tue, 06 Jan 2026 11:43:53 UTC
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 58FDA10E0E5
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 Jan 2026 11:43:53 +0000 (UTC)
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4dlpyx1tPSz9srM;
 Tue,  6 Jan 2026 12:36:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1767699385;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bAmqeFdlWOAGRIi5evINvMoi90p8G0L9s9GZUo+ZNnU=;
 b=ah+mVaBsxyCrWuJq0ICyA0wUs6qdvWHHEffzIOxZzoDfHemd/91ncSYxpx97QhP/x6Xx7t
 WMJqVFYqXZBfIPrnxbihfpX3TaTuxc0EEFysJs+MjETToA4+wVQb/Zr2TOMF1vmUUyWpLZ
 I1WI8Q3w6S0Tu0uVAchQ3NwLFLEzTf134oeD3UHiVTC5btx5iJ0HUCgeYiXMmbIhrZN6Dd
 n9dQku6N1qBOUGqE2lbkFMx28w3gQi21avSl9JKCYlzXPNeHn/3dEUvqtt3iRaZ8aweASZ
 2ROzNFrr8yjvwftDD9bz+7ZuG7IZ820R5HqH0NqsLfFxdn1DLAZuEpe86DgcHA==
Message-ID: <e597171a-cc64-4811-a043-db2e539aaf94@mailbox.org>
Date: Tue, 6 Jan 2026 12:36:20 +0100
MIME-Version: 1.0
Subject: Re: [PATCH v3 2/3] mm: only interrupt taking all mm locks on fatal
 signal
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Mikulas Patocka <mpatocka@redhat.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@redhat.com>, amd-gfx@lists.freedesktop.org,
 linux-mm@kvack.org, Vlastimil Babka <vbabka@suse.cz>,
 Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>
References: <b672e17b-461d-16ae-e7d3-45d3c1aab142@redhat.com>
 <7whbqlfrwjr4z2d4bpny3rjyl5tetdyx7ccf52uvby7hgywoym@6l6m2xcytez7>
From: =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel.daenzer@mailbox.org>
Content-Language: en-CA
In-Reply-To: <7whbqlfrwjr4z2d4bpny3rjyl5tetdyx7ccf52uvby7hgywoym@6l6m2xcytez7>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 7ceeee7f4f9448e5d4c
X-MBO-RS-META: tgxmey483p8e7gbw9y4cgr43xd49dy1g
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

On 1/5/26 19:15, Liam R. Howlett wrote:
> * Mikulas Patocka <mpatocka@redhat.com> [260104 16:17]:
>
> I'm not saying it's wrong to change the signal handling, but this is
> very much working around a bug in userspace constantly hammering a task
> with signals and then is surprised there is a response that the kernel
> was interrupted.

I'd go further than that. If user space fails to retry the system call in response to -EINTR, that's a user-space bug, period. It can happen anytime for any number of other reasons. (That most system calls happen to get away without it most of the time doesn't make it not a bug)

(This is assuming the system call can be safely retried, otherwise returning -EINTR to user space for non-fatal signals would be a kernel bug)


>> I'm submitting this patch for the stable kernels, because this bug may
>> cause random failures in any code that calls mm_take_all_locks.
> 
> They aren't random failures, they are a response to a signal sent to the
> process that may be taking a very long time to do something.
> 
> I really don't see how continuously sending signals at a short interval
> interrupting system calls can be considered random failures, especially
> when the return is -EINTR which literally means "Interrupted system
> call".  How else would you interrupt a system call, if not a signal?
> 
> I feel like we are making the code less versatile to work around the
> fact that userspace didn't realise that system calls could be
> interrupted without a fatal signal.
> 
> And from that view, I consider this a functional change and not a bug
> fix.

I agree.


-- 
Earthling Michel Dänzer       \        GNOME / Xwayland / Mesa developer
https://redhat.com             \               Libre software enthusiast
