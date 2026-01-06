Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B495CF6C19
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Jan 2026 09:14:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C2B1910E568;
	Wed,  7 Jan 2026 09:14:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="S5S8A8Fc";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="fL7rPxza";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="RSynUvnn";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="6+H6HZo1";
	dkim-atps=neutral
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EECEB10E004
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 Jan 2026 21:56:21 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 98EFC33EEC;
 Tue,  6 Jan 2026 21:56:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1767736580; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZiF59sRlfgLgwHwwGv0nIPwf5jObmU5X6nMiJr5SV10=;
 b=S5S8A8FcjAdtezms//JM07Cx9yHCHck5QomMgLAcqracx6P6johkA8ppFwcEzaS2BkUANR
 +61VL5LRoEfczyjaN+bY7KhWP8q2vLPMb8SK+3ATf75GpMSrXWsFxJwIYRr2hsRsBW2n7d
 fplNeHk/TabOgDM48WSwldpaDZd9x44=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1767736580;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZiF59sRlfgLgwHwwGv0nIPwf5jObmU5X6nMiJr5SV10=;
 b=fL7rPxzaHWqRpgxegyspX4Nl5/vUpJpOOJBbNTuwk18WszOEoy3nHnp7oP9QGneWOOwW1e
 Ob5XCL3bxVmNcRAQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=RSynUvnn;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=6+H6HZo1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1767736579; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZiF59sRlfgLgwHwwGv0nIPwf5jObmU5X6nMiJr5SV10=;
 b=RSynUvnntXRRRUGOF8fg8kmhSQj5haX4ZP/5xvRcqzv02mDAVbsMCt3NlO+NEjQXfRp3Lr
 3HWJ55LPCH4+k+9tcyCGmXvdHCOiLWcRFjqXad93gvMmyE5T8Qev7YWDkenI8D3D22RCjD
 BOTPkiVLejmONv6B899JmPBGmwUpNpc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1767736579;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZiF59sRlfgLgwHwwGv0nIPwf5jObmU5X6nMiJr5SV10=;
 b=6+H6HZo1PSoMX0nh4qzfNoZuFZV7CVwOAhf/J4ZubJZBdsMdQmiJbxAR2u4OzITUUfyblJ
 5cSjVEwUPRxclCAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CF4173EA63;
 Tue,  6 Jan 2026 21:56:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 7mS/LgKFXWnSCwAAD6G6ig
 (envelope-from <pfalcato@suse.de>); Tue, 06 Jan 2026 21:56:18 +0000
Date: Tue, 6 Jan 2026 21:56:17 +0000
From: Pedro Falcato <pfalcato@suse.de>
To: Mikulas Patocka <mpatocka@redhat.com>
Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Alex Deucher <alexander.deucher@amd.com>, 
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 Andrew Morton <akpm@linux-foundation.org>, 
 David Hildenbrand <david@redhat.com>, amd-gfx@lists.freedesktop.org,
 linux-mm@kvack.org, 
 Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>
Subject: Re: [PATCH v3 2/3] mm: only interrupt taking all mm locks on fatal
 signal
Message-ID: <mfgqbtiqtl7cxzxhvu6ossi5umek2vpb2rag2bcqsof7ommvfz@uz6fqkc2jhik>
References: <b672e17b-461d-16ae-e7d3-45d3c1aab142@redhat.com>
 <7whbqlfrwjr4z2d4bpny3rjyl5tetdyx7ccf52uvby7hgywoym@6l6m2xcytez7>
 <e60858c9-12a6-2b04-35ae-9d676f14db2a@redhat.com>
 <j3dy3g5mchtdzxldtnqu5nwaalbr6ec4ceim3nuu6nwcddmqjc@7dgzr4m7pli2>
 <6633f8ed-f432-f4c4-3fe2-8c14248cadab@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6633f8ed-f432-f4c4-3fe2-8c14248cadab@redhat.com>
X-Rspamd-Queue-Id: 98EFC33EEC
X-Spamd-Result: default: False [-4.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_SEVEN(0.00)[11];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
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

On Tue, Jan 06, 2026 at 09:19:59PM +0100, Mikulas Patocka wrote:
> 
> 
> On Tue, 6 Jan 2026, Liam R. Howlett wrote:
> 
> > * Mikulas Patocka <mpatocka@redhat.com> [260105 15:08]:
> > > 
> > > > If you only get the error message sometimes, does that mean there is
> > > > another signal check that isn't covered by this change - or another call
> > > > path?
> > > 
> > > This call path is also triggered by -EINTR from mm_take_all_locks: 
> > > "init_user_pages -> amdgpu_hmm_register -> mmu_interval_notifier_insert -> 
> > > mmu_notifier_register -> __mmu_notifier_register -> mm_take_all_locks -> 
> > > return -EINTR". I am not expert in the GPU code, so I don't know how much 
> > > serious it is.
> > 
> > Okay, so the other call paths also end up getting the -EINTR from this
> > function?  Can you please add that detail to the commit message?
> 
> Yes. I'd like to ask the GPU people to look at it and say how much damage 
> this -EINTR could do. I don't know - I just saw the messages "Failed to 
> register MMU notifier: -4" in the syslog.
> 
> > This means that -EINTR can no longer be returned from open(), right?
> > Otherwise you are just reducing a race condition between open() and a
> > signal entering from your timer.
> 
> EINTR can be returned from open() in cases when it was historically 
> behaving this way - such as opening a fifo when there is no matching 
> process having it open.
> 
> But I think that opening /dev/kfd doesn't fall into this category.
>

Well, it's a device - opening can and often does have side-effects.
It's not too far-fetched to -EINTR here.

> NFS has an "intr" flag that makes the filesystem syscalls interruptible by 
> signals. It is off by default, because many programs don't expect EINTR 
> when opening, reading or writing plain files on a filesystem.
> 
> > Any other -EINTR system call will also cause you problems since you
> > continuously send signals to your process, so we'll have to change them
> > all for this to work?
> 
> I use SA_RESTART for the signals. And I retry all the syscalls on EINTR 
> just in case SA_RESTART didn't work. So, I don't experience random 
> failures in my code due to the periodic signal.
> 
> But there is code that I have no control over - such as the OpenCL shared 
> library.

Right. So I am wondering if just returning -ERESTARTSYS (whether in
mm_take_all_locks(), or in the AMD driver) would satisfy both parties.

Folks installing and using signals need to pay attention and set
SA_RESTART, but that's already best practice when dealing with third-party
code. open(2) should be transparently restartable.

WDYT?

-- 
Pedro
