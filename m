Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D801BCF6C1A
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Jan 2026 09:26:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3964810E58F;
	Wed,  7 Jan 2026 09:26:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="WotMMt1L";
	dkim-atps=neutral
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 20F8310E57F
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Jan 2026 09:26:05 +0000 (UTC)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4dmN213yhvz9tHd;
 Wed,  7 Jan 2026 10:26:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1767777961;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IkcN9yr36Tdc4k0VIXN57D0NnZ4/zhZ0850Zx69uq/8=;
 b=WotMMt1LP1uSfCU/khv2JRIrAoUkuUdjdPeW2GGuNesm+b7aaWZhn5hOkD5VZ1rXA6tut+
 3yKD1I5RIcwQpMZZUQL9ulBdsFbeQXzOu3FxMJyzyS7OPwuathrvARi/mNtMhHmD56w18v
 uUXRArlKaIuh/MCpsY4mWWifxNzZiokzAF+rnLHa2sdpWwLP/Ux0KnKymfS7O6DQY145j5
 /1HfEa/khRY5IDK04mSFrwMMV6lZyCXlhyp9LekuUcuTfUhJozD7C/bX6AhSN/FD6otd3F
 AprRji4xCeaErHhFoQ47ws63y3inpEOligIneaEO4b9G/HMM6UCammw+cedCBA==
Message-ID: <fa6a1cbf-2853-4add-94c6-d5c2e0a3a2b7@mailbox.org>
Date: Wed, 7 Jan 2026 10:25:57 +0100
MIME-Version: 1.0
Subject: Re: [PATCH v3 2/3] mm: only interrupt taking all mm locks on fatal
 signal
To: Mikulas Patocka <mpatocka@redhat.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@redhat.com>, amd-gfx@lists.freedesktop.org,
 linux-mm@kvack.org, Vlastimil Babka <vbabka@suse.cz>,
 Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>
References: <b672e17b-461d-16ae-e7d3-45d3c1aab142@redhat.com>
 <7whbqlfrwjr4z2d4bpny3rjyl5tetdyx7ccf52uvby7hgywoym@6l6m2xcytez7>
 <e60858c9-12a6-2b04-35ae-9d676f14db2a@redhat.com>
 <j3dy3g5mchtdzxldtnqu5nwaalbr6ec4ceim3nuu6nwcddmqjc@7dgzr4m7pli2>
 <6633f8ed-f432-f4c4-3fe2-8c14248cadab@redhat.com>
Content-Language: en-CA
From: =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel.daenzer@mailbox.org>
In-Reply-To: <6633f8ed-f432-f4c4-3fe2-8c14248cadab@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: 53gdztw874atruuukg3n3nw118ikg3tf
X-MBO-RS-ID: a72ef34075f8cc7d704
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

On 1/6/26 21:19, Mikulas Patocka wrote:
> On Tue, 6 Jan 2026, Liam R. Howlett wrote:
> 
>> Any other -EINTR system call will also cause you problems since you
>> continuously send signals to your process, so we'll have to change them
>> all for this to work?
> 
> I use SA_RESTART for the signals. And I retry all the syscalls on EINTR 
> just in case SA_RESTART didn't work. So, I don't experience random 
> failures in my code due to the periodic signal.
> 
> But there is code that I have no control over - such as the OpenCL shared 
> library.

AFAIK all current OpenCL support code for AMD GPUs is open source. I see no reason why it couldn't be fixed.


-- 
Earthling Michel Dänzer       \        GNOME / Xwayland / Mesa developer
https://redhat.com             \               Libre software enthusiast
