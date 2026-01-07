Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72C5DCFD63A
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Jan 2026 13:52:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 020C310E0EF;
	Wed,  7 Jan 2026 13:52:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.cz header.i=@suse.cz header.b="hLGnd6ei";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="aHcQ9WLh";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="hLGnd6ei";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="aHcQ9WLh";
	dkim-atps=neutral
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9FC5F10E587
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Jan 2026 09:55:40 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 556CA33C4F;
 Wed,  7 Jan 2026 09:55:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1767779739; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=ERB9qiOb7qIDXvxfdQ+9v8QX8NseG5XlxnSG4mlYvHQ=;
 b=hLGnd6ei3tDBnshHMedOPSarPjdmPiL2+58baxvDsAG+9Qc6AMz1QGX6hbVvxfJoWHGiWt
 IGoicT/LM6s7sTmHkZbLMY6g8aFRhJ3REHB0MsmHCUnlLxfnCoUmCM+pPsJl0FTcFq0lvq
 ee6hsICxf5HY+ztxvULvitCdUzRcZxY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1767779739;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=ERB9qiOb7qIDXvxfdQ+9v8QX8NseG5XlxnSG4mlYvHQ=;
 b=aHcQ9WLhANDGgJ53AiJlTLbw5Zz75Uc5a1ySqnfBm+B325OVQZ0JkWoPbO5DXpvGBsIKJg
 ecO9L/YXFjLuRMCw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1767779739; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=ERB9qiOb7qIDXvxfdQ+9v8QX8NseG5XlxnSG4mlYvHQ=;
 b=hLGnd6ei3tDBnshHMedOPSarPjdmPiL2+58baxvDsAG+9Qc6AMz1QGX6hbVvxfJoWHGiWt
 IGoicT/LM6s7sTmHkZbLMY6g8aFRhJ3REHB0MsmHCUnlLxfnCoUmCM+pPsJl0FTcFq0lvq
 ee6hsICxf5HY+ztxvULvitCdUzRcZxY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1767779739;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=ERB9qiOb7qIDXvxfdQ+9v8QX8NseG5XlxnSG4mlYvHQ=;
 b=aHcQ9WLhANDGgJ53AiJlTLbw5Zz75Uc5a1ySqnfBm+B325OVQZ0JkWoPbO5DXpvGBsIKJg
 ecO9L/YXFjLuRMCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3D7873EA63;
 Wed,  7 Jan 2026 09:55:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id oHRpDpstXmn5NgAAD6G6ig
 (envelope-from <vbabka@suse.cz>); Wed, 07 Jan 2026 09:55:39 +0000
Message-ID: <26ec5b50-1bea-4a62-97bf-56162bdac4b9@suse.cz>
Date: Wed, 7 Jan 2026 10:55:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] mm: only interrupt taking all mm locks on fatal
 signal
Content-Language: en-US
To: "David Hildenbrand (Red Hat)" <david@kernel.org>,
 Mikulas Patocka <mpatocka@redhat.com>,
 =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel.daenzer@mailbox.org>
Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Andrew Morton <akpm@linux-foundation.org>, amd-gfx@lists.freedesktop.org,
 linux-mm@kvack.org, Jann Horn <jannh@google.com>,
 Pedro Falcato <pfalcato@suse.de>
References: <b672e17b-461d-16ae-e7d3-45d3c1aab142@redhat.com>
 <7whbqlfrwjr4z2d4bpny3rjyl5tetdyx7ccf52uvby7hgywoym@6l6m2xcytez7>
 <e597171a-cc64-4811-a043-db2e539aaf94@mailbox.org>
 <5dfbf2f9-0948-cd59-5c59-a6ee946ff9f2@redhat.com>
 <16dd4c62-c763-42fd-9ff1-a6dfcdbab109@kernel.org>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 xsFNBFZdmxYBEADsw/SiUSjB0dM+vSh95UkgcHjzEVBlby/Fg+g42O7LAEkCYXi/vvq31JTB
 KxRWDHX0R2tgpFDXHnzZcQywawu8eSq0LxzxFNYMvtB7sV1pxYwej2qx9B75qW2plBs+7+YB
 87tMFA+u+L4Z5xAzIimfLD5EKC56kJ1CsXlM8S/LHcmdD9Ctkn3trYDNnat0eoAcfPIP2OZ+
 9oe9IF/R28zmh0ifLXyJQQz5ofdj4bPf8ecEW0rhcqHfTD8k4yK0xxt3xW+6Exqp9n9bydiy
 tcSAw/TahjW6yrA+6JhSBv1v2tIm+itQc073zjSX8OFL51qQVzRFr7H2UQG33lw2QrvHRXqD
 Ot7ViKam7v0Ho9wEWiQOOZlHItOOXFphWb2yq3nzrKe45oWoSgkxKb97MVsQ+q2SYjJRBBH4
 8qKhphADYxkIP6yut/eaj9ImvRUZZRi0DTc8xfnvHGTjKbJzC2xpFcY0DQbZzuwsIZ8OPJCc
 LM4S7mT25NE5kUTG/TKQCk922vRdGVMoLA7dIQrgXnRXtyT61sg8PG4wcfOnuWf8577aXP1x
 6mzw3/jh3F+oSBHb/GcLC7mvWreJifUL2gEdssGfXhGWBo6zLS3qhgtwjay0Jl+kza1lo+Cv
 BB2T79D4WGdDuVa4eOrQ02TxqGN7G0Biz5ZLRSFzQSQwLn8fbwARAQABzSBWbGFzdGltaWwg
 QmFia2EgPHZiYWJrYUBzdXNlLmN6PsLBlAQTAQoAPgIbAwULCQgHAwUVCgkICwUWAgMBAAIe
 AQIXgBYhBKlA1DSZLC6OmRA9UCJPp+fMgqZkBQJnyBr8BQka0IFQAAoJECJPp+fMgqZkqmMQ
 AIbGN95ptUMUvo6aAdhxaOCHXp1DfIBuIOK/zpx8ylY4pOwu3GRe4dQ8u4XS9gaZ96Gj4bC+
 jwWcSmn+TjtKW3rH1dRKopvC07tSJIGGVyw7ieV/5cbFffA8NL0ILowzVg8w1ipnz1VTkWDr
 2zcfslxJsJ6vhXw5/npcY0ldeC1E8f6UUoa4eyoskd70vO0wOAoGd02ZkJoox3F5ODM0kjHu
 Y97VLOa3GG66lh+ZEelVZEujHfKceCw9G3PMvEzyLFbXvSOigZQMdKzQ8D/OChwqig8wFBmV
 QCPS4yDdmZP3oeDHRjJ9jvMUKoYODiNKsl2F+xXwyRM2qoKRqFlhCn4usVd1+wmv9iLV8nPs
 2Db1ZIa49fJet3Sk3PN4bV1rAPuWvtbuTBN39Q/6MgkLTYHb84HyFKw14Rqe5YorrBLbF3rl
 M51Dpf6Egu1yTJDHCTEwePWug4XI11FT8lK0LNnHNpbhTCYRjX73iWOnFraJNcURld1jL1nV
 r/LRD+/e2gNtSTPK0Qkon6HcOBZnxRoqtazTU6YQRmGlT0v+rukj/cn5sToYibWLn+RoV1CE
 Qj6tApOiHBkpEsCzHGu+iDQ1WT0Idtdynst738f/uCeCMkdRu4WMZjteQaqvARFwCy3P/jpK
 uvzMtves5HvZw33ZwOtMCgbpce00DaET4y/UzsBNBFsZNTUBCACfQfpSsWJZyi+SHoRdVyX5
 J6rI7okc4+b571a7RXD5UhS9dlVRVVAtrU9ANSLqPTQKGVxHrqD39XSw8hxK61pw8p90pg4G
 /N3iuWEvyt+t0SxDDkClnGsDyRhlUyEWYFEoBrrCizbmahOUwqkJbNMfzj5Y7n7OIJOxNRkB
 IBOjPdF26dMP69BwePQao1M8Acrrex9sAHYjQGyVmReRjVEtv9iG4DoTsnIR3amKVk6si4Ea
 X/mrapJqSCcBUVYUFH8M7bsm4CSxier5ofy8jTEa/CfvkqpKThTMCQPNZKY7hke5qEq1CBk2
 wxhX48ZrJEFf1v3NuV3OimgsF2odzieNABEBAAHCwXwEGAEKACYCGwwWIQSpQNQ0mSwujpkQ
 PVAiT6fnzIKmZAUCZ8gcVAUJFhTonwAKCRAiT6fnzIKmZLY8D/9uo3Ut9yi2YCuASWxr7QQZ
 lJCViArjymbxYB5NdOeC50/0gnhK4pgdHlE2MdwF6o34x7TPFGpjNFvycZqccSQPJ/gibwNA
 zx3q9vJT4Vw+YbiyS53iSBLXMweeVV1Jd9IjAoL+EqB0cbxoFXvnjkvP1foiiF5r73jCd4PR
 rD+GoX5BZ7AZmFYmuJYBm28STM2NA6LhT0X+2su16f/HtummENKcMwom0hNu3MBNPUOrujtW
 khQrWcJNAAsy4yMoJ2Lw51T/5X5Hc7jQ9da9fyqu+phqlVtn70qpPvgWy4HRhr25fCAEXZDp
 xG4RNmTm+pqorHOqhBkI7wA7P/nyPo7ZEc3L+ZkQ37u0nlOyrjbNUniPGxPxv1imVq8IyycG
 AN5FaFxtiELK22gvudghLJaDiRBhn8/AhXc642/Z/yIpizE2xG4KU4AXzb6C+o7LX/WmmsWP
 Ly6jamSg6tvrdo4/e87lUedEqCtrp2o1xpn5zongf6cQkaLZKQcBQnPmgHO5OG8+50u88D9I
 rywqgzTUhHFKKF6/9L/lYtrNcHU8Z6Y4Ju/MLUiNYkmtrGIMnkjKCiRqlRrZE/v5YFHbayRD
 dJKXobXTtCBYpLJM4ZYRpGZXne/FAtWNe4KbNJJqxMvrTOrnIatPj8NhBVI0RSJRsbilh6TE
 m6M14QORSWTLRg==
In-Reply-To: <16dd4c62-c763-42fd-9ff1-a6dfcdbab109@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.29 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.19)[-0.968]; MIME_GOOD(-0.10)[text/plain];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[]; RCPT_COUNT_TWELVE(0.00)[12];
 MID_RHS_MATCH_FROM(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 URIBL_BLOCKED(0.00)[suse.cz:mid]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid,imap1.dmz-prg2.suse.org:helo]
X-Mailman-Approved-At: Wed, 07 Jan 2026 13:52:00 +0000
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

On 1/6/26 16:03, David Hildenbrand (Red Hat) wrote:
> On 1/6/26 13:52, Mikulas Patocka wrote:
>> 
>> 
>> On Tue, 6 Jan 2026, Michel Dänzer wrote:
>> 
>>> On 1/5/26 19:15, Liam R. Howlett wrote:
>>>> * Mikulas Patocka <mpatocka@redhat.com> [260104 16:17]:
>>>>
>>>> I'm not saying it's wrong to change the signal handling, but this is
>>>> very much working around a bug in userspace constantly hammering a task
>>>> with signals and then is surprised there is a response that the kernel
>>>> was interrupted.
>>>
>>> I'd go further than that. If user space fails to retry the system call
>>> in response to -EINTR, that's a user-space bug, period. It can happen
>>> anytime for any number of other reasons. (That most system calls happen
>>> to get away without it most of the time doesn't make it not a bug)
>> 
>> So, I tried this - just for fun - and the machine doesn't even boot. I get
>> a lot of errors about inability to open particular files on the console.
>> 
>> Userspace is buggy, according to your definition, regardless of whether
>> you like it or not.
>> 
>> Mikulas
>> 
>> ---
>>   fs/open.c |    3 +++
>>   1 file changed, 3 insertions(+)
>> 
>> Index: linux-2.6/fs/open.c
>> ===================================================================
>> --- linux-2.6.orig/fs/open.c	2025-12-31 20:10:31.000000000 +0100
>> +++ linux-2.6/fs/open.c	2026-01-06 13:28:01.000000000 +0100
>> @@ -1419,6 +1419,9 @@ static int do_sys_openat2(int dfd, const
>>   	struct filename *tmp __free(putname) = NULL;
>>   	int err;
>>   
>> +	if (current->pid != 1 && !(get_random_u8() & 0x1))
>> +		return -EINTR;
> 
> Reading the man [1] page user space is only to expect EINTR in case it is
> prepared to deal with signals (install signal handlers), no?
> 
> There are some exception documented:
> 
>         On Linux, even in the absence of signal handlers, certain blocking
>         interfaces can fail with the error EINTR after the process is
>         stopped by one of the stop signals and then resumed via SIGCONT.
>         This behavior is not sanctioned by POSIX.1, and doesn't occur on
>         other systems.
> 
>         The Linux interfaces that display this behavior are:
> 
>         •  "Input" socket interfaces, when a timeout (SO_RCVTIMEO) has
>            been set on the socket using setsockopt(2): accept(2), recv(2),
>            recvfrom(2), recvmmsg(2) (also with a non-NULL timeout
>            argument), and recvmsg(2).
> 
>         •  "Output" socket interfaces, when a timeout (SO_RCVTIMEO) has
>            been set on the socket using setsockopt(2): connect(2),
>            send(2), sendto(2), and sendmsg(2), if a send timeout
>            (SO_SNDTIMEO) has been set.
> 
>         •  epoll_wait(2), epoll_pwait(2).
> 
>         •  semop(2), semtimedop(2).
> 
>         •  sigtimedwait(2), sigwaitinfo(2).
> 
>         •  Linux 3.7 and earlier: read(2) from an inotify(7) file
>            descriptor
> 
>         •  Linux 2.6.21 and earlier: futex(2) FUTEX_WAIT,
>            sem_timedwait(3), sem_wait(3).
> 
>         •  Linux 2.6.8 and earlier: msgrcv(2), msgsnd(2).
> 
>         •  Linux 2.4 and earlier: nanosleep(2).
> 
> 
> So I would expect that your test code hear breaks user space.

Since the patch is dead now, are we going to update this section in the manpage?

> 
> [1] https://man7.org/linux/man-pages/man7/signal.7.html
> 

