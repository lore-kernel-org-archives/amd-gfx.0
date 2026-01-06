Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDA50CE9D42
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Jan 2026 15:03:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4472010E511;
	Tue,  6 Jan 2026 15:03:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="iKG6OAaX";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F036710E511
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 Jan 2026 15:03:40 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id B765F43E72;
 Tue,  6 Jan 2026 15:03:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99ECAC116C6;
 Tue,  6 Jan 2026 15:03:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1767711820;
 bh=6PWRTCruCy2T9djEXYIVH4hnSort9aaCvbTjSWdu5AU=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=iKG6OAaXKypLdxRdWrfF8wqoX/pa8DaYhUihXN9PBnElPaKxikr2eCblQ+2JPDFIi
 9CHZFzMrsG4j6vRHVjdElsw2gdd6yQR0aaUnoof9xdihy2nc1KX1NXmE16jr0US1wu
 mEkLNuYE31NRKSQNmg63vyWdM6qQQAEq3HSQXkh8eetANNYT8kTstxqK4x4DJfvGoX
 yxxPH1JlDu6+Pt0gRdmQZVxMbz+1yOVH0H6CfD9PuXGByFslK+A+Ozwmn1FHEWWeB9
 JGIBKFmqmTKuikomCq67l9qYO8c7mplYf499rmaKTMNlybqNW4tyckz4zWHYcb1xqZ
 2eEhWS+v/Uovw==
Message-ID: <16dd4c62-c763-42fd-9ff1-a6dfcdbab109@kernel.org>
Date: Tue, 6 Jan 2026 16:03:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] mm: only interrupt taking all mm locks on fatal
 signal
To: Mikulas Patocka <mpatocka@redhat.com>,
 =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel.daenzer@mailbox.org>
Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Andrew Morton <akpm@linux-foundation.org>, amd-gfx@lists.freedesktop.org,
 linux-mm@kvack.org, Vlastimil Babka <vbabka@suse.cz>,
 Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>
References: <b672e17b-461d-16ae-e7d3-45d3c1aab142@redhat.com>
 <7whbqlfrwjr4z2d4bpny3rjyl5tetdyx7ccf52uvby7hgywoym@6l6m2xcytez7>
 <e597171a-cc64-4811-a043-db2e539aaf94@mailbox.org>
 <5dfbf2f9-0948-cd59-5c59-a6ee946ff9f2@redhat.com>
From: "David Hildenbrand (Red Hat)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
In-Reply-To: <5dfbf2f9-0948-cd59-5c59-a6ee946ff9f2@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 1/6/26 13:52, Mikulas Patocka wrote:
> 
> 
> On Tue, 6 Jan 2026, Michel Dänzer wrote:
> 
>> On 1/5/26 19:15, Liam R. Howlett wrote:
>>> * Mikulas Patocka <mpatocka@redhat.com> [260104 16:17]:
>>>
>>> I'm not saying it's wrong to change the signal handling, but this is
>>> very much working around a bug in userspace constantly hammering a task
>>> with signals and then is surprised there is a response that the kernel
>>> was interrupted.
>>
>> I'd go further than that. If user space fails to retry the system call
>> in response to -EINTR, that's a user-space bug, period. It can happen
>> anytime for any number of other reasons. (That most system calls happen
>> to get away without it most of the time doesn't make it not a bug)
> 
> So, I tried this - just for fun - and the machine doesn't even boot. I get
> a lot of errors about inability to open particular files on the console.
> 
> Userspace is buggy, according to your definition, regardless of whether
> you like it or not.
> 
> Mikulas
> 
> ---
>   fs/open.c |    3 +++
>   1 file changed, 3 insertions(+)
> 
> Index: linux-2.6/fs/open.c
> ===================================================================
> --- linux-2.6.orig/fs/open.c	2025-12-31 20:10:31.000000000 +0100
> +++ linux-2.6/fs/open.c	2026-01-06 13:28:01.000000000 +0100
> @@ -1419,6 +1419,9 @@ static int do_sys_openat2(int dfd, const
>   	struct filename *tmp __free(putname) = NULL;
>   	int err;
>   
> +	if (current->pid != 1 && !(get_random_u8() & 0x1))
> +		return -EINTR;

Reading the man [1] page user space is only to expect EINTR in case it is
prepared to deal with signals (install signal handlers), no?

There are some exception documented:

        On Linux, even in the absence of signal handlers, certain blocking
        interfaces can fail with the error EINTR after the process is
        stopped by one of the stop signals and then resumed via SIGCONT.
        This behavior is not sanctioned by POSIX.1, and doesn't occur on
        other systems.

        The Linux interfaces that display this behavior are:

        •  "Input" socket interfaces, when a timeout (SO_RCVTIMEO) has
           been set on the socket using setsockopt(2): accept(2), recv(2),
           recvfrom(2), recvmmsg(2) (also with a non-NULL timeout
           argument), and recvmsg(2).

        •  "Output" socket interfaces, when a timeout (SO_RCVTIMEO) has
           been set on the socket using setsockopt(2): connect(2),
           send(2), sendto(2), and sendmsg(2), if a send timeout
           (SO_SNDTIMEO) has been set.

        •  epoll_wait(2), epoll_pwait(2).

        •  semop(2), semtimedop(2).

        •  sigtimedwait(2), sigwaitinfo(2).

        •  Linux 3.7 and earlier: read(2) from an inotify(7) file
           descriptor

        •  Linux 2.6.21 and earlier: futex(2) FUTEX_WAIT,
           sem_timedwait(3), sem_wait(3).

        •  Linux 2.6.8 and earlier: msgrcv(2), msgsnd(2).

        •  Linux 2.4 and earlier: nanosleep(2).


So I would expect that your test code hear breaks user space.


[1] https://man7.org/linux/man-pages/man7/signal.7.html

-- 
Cheers

David
