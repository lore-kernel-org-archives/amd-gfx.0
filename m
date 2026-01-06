Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2100CF6C1A
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Jan 2026 09:14:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5C70910E56E;
	Wed,  7 Jan 2026 09:14:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="1uwYOfE1";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="JPYE1q2g";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="1uwYOfE1";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="JPYE1q2g";
	dkim-atps=neutral
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 61B1A10E004
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 Jan 2026 21:52:30 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 4219433EDF;
 Tue,  6 Jan 2026 21:52:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1767736348; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KhfcYuntLo/0K/I5/LJIlPz4iiF0QOoGlUFbzP41ypk=;
 b=1uwYOfE1IbbFYBumW3FpqbgfTw68MJn4HcKT5dzZBq5uCqwNb/Be0WRQENYzwAhOzDZ/g2
 OlKbHHRRRW2Pl0zK3lZapeiOYkQc+056bVHMHdjH3rdkQxfDghsUL2E06HnOhDtoXzJoWj
 7Ce+3At/Ogb6mutvVHl4ls2/b/4SbVY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1767736348;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KhfcYuntLo/0K/I5/LJIlPz4iiF0QOoGlUFbzP41ypk=;
 b=JPYE1q2gl6jhMpzAlZnqo8dfLZuHI+eI4WCjmihTkKD6YAizT2kmQOETKYBNkXJWQb0dH7
 wa4F6A/8LXwgAGDw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=1uwYOfE1;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=JPYE1q2g
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1767736348; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KhfcYuntLo/0K/I5/LJIlPz4iiF0QOoGlUFbzP41ypk=;
 b=1uwYOfE1IbbFYBumW3FpqbgfTw68MJn4HcKT5dzZBq5uCqwNb/Be0WRQENYzwAhOzDZ/g2
 OlKbHHRRRW2Pl0zK3lZapeiOYkQc+056bVHMHdjH3rdkQxfDghsUL2E06HnOhDtoXzJoWj
 7Ce+3At/Ogb6mutvVHl4ls2/b/4SbVY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1767736348;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KhfcYuntLo/0K/I5/LJIlPz4iiF0QOoGlUFbzP41ypk=;
 b=JPYE1q2gl6jhMpzAlZnqo8dfLZuHI+eI4WCjmihTkKD6YAizT2kmQOETKYBNkXJWQb0dH7
 wa4F6A/8LXwgAGDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A1F603EA63;
 Tue,  6 Jan 2026 21:52:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id STtTIxuEXWlnCAAAD6G6ig
 (envelope-from <pfalcato@suse.de>); Tue, 06 Jan 2026 21:52:27 +0000
Date: Tue, 6 Jan 2026 21:52:25 +0000
From: Pedro Falcato <pfalcato@suse.de>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
 Alex Deucher <alexander.deucher@amd.com>, Mikulas Patocka <mpatocka@redhat.com>,
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 David Hildenbrand <david@redhat.com>, 
 amd-gfx@lists.freedesktop.org, linux-mm@kvack.org
Subject: Re: [PATCH v2] fix AMDGPU failure with periodic signal
Message-ID: <f6pged4wdv2qrpwn6uiqeampyi4m64xoey26eudw56k3txu6oi@3uwgwbyfrlwm>
References: <6f16b618-26fc-3031-abe8-65c2090262e7@redhat.com>
 <61c3d41d-602d-4dfc-872a-873acf653b6d@lucifer.local>
 <20260106101249.be7514e75c09a928c6fa71ef@linux-foundation.org>
 <52bffed4-d9b0-4ec9-85a6-ba70e22106f3@lucifer.local>
 <20260106125912.a4975dd1919c913c22fd5101@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260106125912.a4975dd1919c913c22fd5101@linux-foundation.org>
X-Spamd-Result: default: False [-4.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_SEVEN(0.00)[8];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 4219433EDF
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

On Tue, Jan 06, 2026 at 12:59:12PM -0800, Andrew Morton wrote:
> On Tue, 6 Jan 2026 18:24:10 +0000 Lorenzo Stoakes <lorenzo.stoakes@oracle.com> wrote:
> 
> > On Tue, Jan 06, 2026 at 10:12:49AM -0800, Andrew Morton wrote:
> > > On Tue, 6 Jan 2026 11:51:49 +0000 Lorenzo Stoakes <lorenzo.stoakes@oracle.com> wrote:
> > >
> > > > I'm not sure if the git repos are lagging vs. quilt, but as reported this
> > > > patch breaks the VMA tests, and the tests are _still_ broken.
> > > >
> > > > Yet it's still in mm-new, mm-unstable, and even mm-hotfixes-unstable.
> > > >
> > > > This is interfering with my work, can we please drop this.
> > > >
> > > > Also the v3 is currently being debated, so surely should have been dropped
> > > > until we have this resolved?
> > >
> > > Well.  I don't drop fixes unless it's decided to be a non-issue or
> > > unless a better fix is available.
> > 
> > Even if it breaks the build and that's been reported on-list?
> 
> I addressed that.
> 
> > >
> > > I've done this for ever - I've held onto "wrong" fixes for *years*.
> > > View this as a weird issue-tracking system for a project which has no
> > > issue-tracking system.  It's to prevent issues from falling through
> > > cracks and getting lost.
> > 
> > I think a lot of the issue is these processes seem to work to you but those
> > on the ground are finding them not to work.
> > 
> > The kernel today is not the same as the kernel X years ago, esp. in terms
> > of sheer volume.
> > 
> > Having a patch that none of the relevant maintainers/reviewers have seen
> > land in an -rc out of the blue is a really serious problem.
> 
> It isn't in -rc.  It's in mm-hotfixes-unstable and it's marked "acks?",
> which means not to go upstream without further consideration.
> 
> > Also it was taken 2 months after it was submitted, so nobody could have
> > _possibly_ picked this up by reading the list. This is why I am really
> > underlining this case.
> 
> That's why I grabbed it.  Had I not done so, this issue would have been
> lost.  What I do *worked*.
> 
> > >
> > > It's unfortunate that this one causes disruption so I guess I'll loudly
> > > comment it out and track the issue that way.
> > >
> > 
> > I think we need a better approach, yes.
> > 
> > We in mm are really very responsive compared to most, I think asking people
> > to wait and resend if somehow it got missed is considerably saner than
> > 'well I'll take any patch purporting to be a fix from anyone so we keep
> > track of stuff'.
> 
> If someone wants to step up and be MM issue tracking person then great.
> I don't want to be that person.
> 
> And let me reiterate: had I not done this, the issue Mikulas identified
> would have remained unaddressed.
> 

I understand your point. I don't think anyone wants to see patches falling
through the cracks. But we also don't want patches to get applied without
any review.

Perhaps it's time to deploy something like Patchwork to help track
outstanding patches?

-- 
Pedro
