Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 538D2C02180
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jan 2025 08:37:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 993CE10E532;
	Wed, 15 Jan 2025 08:37:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; secure) header.d=ffwll.ch header.i=@ffwll.ch header.b="MD8m5Vy4";
	dkim-atps=neutral
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3B43A10E532
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jan 2025 08:37:42 +0000 (UTC)
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4364a37a1d7so65929925e9.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jan 2025 00:37:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ffwll.ch; s=google; t=1736930261; x=1737535061; darn=lists.freedesktop.org; 
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=t1lDtsTBmzeHySH6Oo2lABqepsQDxWNeuVS+1+aT2Qg=;
 b=MD8m5Vy4OrlZDFAzIO++9D7LKSXDi836aAfTgOumoLGI974HFxC3MJAVgSazqp0lC4
 f2B4CLlvtQ3TAFLmGXLEPwB3TafwV+/BeKEL44gIuhvVqEyfYWT7kZcYXegPT35K99fd
 macd3YNSRI1X4mp8CJifDJ0rV8VXPxVgqdL8E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736930261; x=1737535061;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=t1lDtsTBmzeHySH6Oo2lABqepsQDxWNeuVS+1+aT2Qg=;
 b=ce+ZIxGS4D+npNkaspGiEMy5qsbiZhX8cJ1KfzEhDONNwLDv8Cx/mryIlJLLs+eZRH
 tc+PDKsr1IUK0qPoLwLriLs5rE/GdRVpusPN09o0NSe9RE1EivoE3AUU0LmH8WQAm2lj
 cnHTXOW9UGTCmj2KZTWWRiDQcOro+lt71erq7h/1DhAiD17mXNO1II8HIFB7FRU97jj6
 q/kccVcOewNLExx3iKv8fFXRD/zRnYtW67CoeKH1mwfNXrbYheUnQOlIQFeBvbqoQSJt
 GVhaeBylDjT4yCAtNKqyNug4xIqcXh8cL3HbX5w4b002fJ2+GURod2syJTm5XvSgrvrt
 3SZQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWw9jVH+RtQPHPGco8PIY4K23kM0JihjIP4Q6ly9OBJ0vRo7HuBfEe/AHNKxcuXGd8j1+hy7rJw@lists.freedesktop.org
X-Gm-Message-State: AOJu0YykFzFIraCroqHaG/Hs8LAm5Zk38ZiuuGmG+qkSpZFjVUmMkZbp
 5ZXWoY90OUkhsy4bPKjR56ekXM904GXgyApg/Rl5bV0lJBFPHqny/y4rDnOesOo=
X-Gm-Gg: ASbGncuhwIkULOma1WOgOPZ/M66I57bKxBZ7MsVinqu0jr+SYTGHnRNw9dWxpJyOGHD
 VHMOZX7lFmem6MBHgN0eI/55xehXFAs6kifmArB8oq6r1iSRAvXArL93excO44EkFdP2MSntU++
 aPu4CFv5G0dPaH0Pj/15To0z85dftUaTNxQBpw55TadMZ1Fyo5uRTx3gr2DqFpplJNiHAjCElgE
 449rXQQYuO2JFWp1dQCgfXe1nWFJmG1qZ8r2f4pEyYcXdBkpmcnsmhm5pKBLaiBO3q7
X-Google-Smtp-Source: AGHT+IFCngAu+YTirFFtvbri7ZMR5JigjYzfZ83aMKoKXVXXIAkEYs+Sq0xIkzeDUko621Th102jfQ==
X-Received: by 2002:a7b:c4c9:0:b0:436:f960:3428 with SMTP id
 5b1f17b1804b1-436f96034b3mr120401255e9.29.1736930260377; 
 Wed, 15 Jan 2025 00:37:40 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:5485:d4b2:c087:b497])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-437c74e6511sm15215655e9.38.2025.01.15.00.37.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jan 2025 00:37:39 -0800 (PST)
Date: Wed, 15 Jan 2025 09:37:37 +0100
From: Simona Vetter <simona.vetter@ffwll.ch>
To: Faith Ekstrand <faith@gfxstrand.net>
Cc: Marek =?utf-8?B?T2zFocOhaw==?= <maraeo@gmail.com>,
 James Jones <jajones@nvidia.com>, Simona Vetter <simona.vetter@ffwll.ch>,
 Daniel Stone <daniel@fooishbar.org>, Brian Starkey <brian.starkey@arm.com>,
 Michel =?iso-8859-1?Q?D=E4nzer?= <michel.daenzer@mailbox.org>,
 dri-devel <dri-devel@lists.freedesktop.org>,
 amd-gfx mailing list <amd-gfx@lists.freedesktop.org>,
 ML Mesa-dev <mesa-dev@lists.freedesktop.org>, nd@arm.com,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH] drm/fourcc: add LINEAR modifiers with an exact pitch
 alignment
Message-ID: <Z4dz0dP12dcy5bhz@phenom.ffwll.local>
References: <c64cb9d8-5ea7-4644-93c8-04a97b758fa0@mailbox.org>
 <h26quuebhpxwkc3fl4vtfteoqyvingnddgxbnzptfnxfg6xgkd@kkkmeqwplomv>
 <8dae97c9-9286-451a-8122-b309eb21b2f4@mailbox.org>
 <Z2Ki-lQH4Fbch6RO@phenom.ffwll.local>
 <q45c43j5kwwvemec7mcs4kqzt54pa3nz3jlhkcky2v63s2vfie@him4q253uw4p>
 <CAPj87rMFJ0JRvsKqZUsw_EGrFWr1VLO4Ne2w_bZ5cH+gs_d=og@mail.gmail.com>
 <Z2Rf7mpSuzZ0ObmT@phenom.ffwll.local>
 <07d08a42-c44a-477e-8057-721b270310cf@nvidia.com>
 <CAAxE2A6N0xtgZmzTR9FXMN79xxy3T8zfhh1sz73h1h8=0ycJ2g@mail.gmail.com>
 <19466180208.28b9.76a0d8c26856b44b62c020e2e9d89f6d@gfxstrand.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <19466180208.28b9.76a0d8c26856b44b62c020e2e9d89f6d@gfxstrand.net>
X-Operating-System: Linux phenom 6.12.3-amd64 
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

On Tue, Jan 14, 2025 at 12:33:57PM -0600, Faith Ekstrand wrote:
> On January 14, 2025 03:39:45 Marek Olšák <maraeo@gmail.com> wrote:
> > I would keep the existing modifier interfaces, API extensions, and
> > expectations the same as today for simplicity.
> > 
> > The new linear modifier definition (proposal) will have these fields:
> >   5 bits for log2 pitch alignment in bytes
> >   5 bits for log2 height alignment in rows
> > 
> >   5 bits for log2 offset alignment in bytes
> >   5 bits for log2 minimum pitch in bytes
> > 
> >   5 bits for log2 minimum (2D) image size in bytes
> 
> I'm not strictly opposed to adding a new modifier or two but this seems
> massively over-designed. First off, no one uses anything but simple 2D
> images for WSI and BOs are allocated in units of 4k pages so 2, 4, and 5 can
> go. If we assume pitch alignment and offset alignment are the same (and
> offset is almost always 0 anyway), 3 can go.
> 
> Even with that, I'm struggling to see how useful this is. My understanding
> is that you're trying to solve a problem where you need an exact 64-byte
> alignment for some AMD scanout stuff. That's not even possible to support on
> Nvidia (minimum alignment is 128B) so practically you're looking at one
> modifier that's shared between AMD and Intel. Why can't we just add an AMD
> modifier, make Intel support it, and move on?
> 
> Otherwise we're massively exploding the modifier space for... Why? Intel
> will have to advertise basically all of them. Nvidia will advertise most of
> them. AMD will advertise something. And now apps have tens of thousands of
> modifiers to sort through when we could have just added one and solved the
> problem.

Yeah I feel like step 1 here would be to just add LINEAR_AMD, document the
requirements, add it to drivers that can pull it in for display or
whatever or have some other interop requirement, and see where we go.

The combinatorial explosion of linear constraints is way too much as
Daniel/James both point out, but luckily there's not that many
gpu/display/camera vendors in this world, and we do have like almost
56bits of LINEAR space we can waste.

What we cannot do is drop LINEAR itself, since that would break the world.
Maybe in some glorious future, if there's enough drivers out there
supporting vendor linear modifiers, userspace could know that LINEAR is
special, and if it finds a matching vendor LINEAR_FOO modifier, it should
prefer that one. But then we could probably achieve the same by something
like "try common modifiers in order" and put LINEAR last consistently,
after all the vendor linear modifers, and have the same effect.
-Sima

> ~Faith
> 
> 
> > 
> > 
> > 
> > The pitch and the image size in bytes are no longer arbitrary values.
> > They are fixed values computed from {width, height, bpp, modifier} as
> > follows:
> >   aligned_width = align(width * bpp / 8, 1 << log2_pitch_alignment);
> > 
> >   aligned_height = align(height, 1 << log2_height_alignment);
> >   pitch = max(1 << log2_minimum_pitch, aligned_width);
> > 
> >   image_size = max(1 << log2_minimum_image_size, pitch * aligned_height);
> > 
> > 
> > The modifier defines the layout exactly and non-ambiguously.
> > Overaligning the pitch or height is not supported. Only the offset
> > alignment has some freedom regarding placement. Drivers can expose
> > whatever they want within that definition, even exposing only 1 linear
> > modifier is OK. Then, you can look at modifiers of other drivers if you
> > want to find commonalities.
> > 
> > 
> > DRM_FORMAT_MOD_LINEAR needs to go because it prevents apps from
> > detecting whether 2 devices have 0 compatible memory layouts, which is a
> > useful thing to know.
> > 
> > 
> > Marek
> > 
> > 
> > 
> > On Fri, Jan 10, 2025 at 4:23 PM James Jones <jajones@nvidia.com> wrote:
> > 
> > On 12/19/24 10:03, Simona Vetter wrote:
> > > On Thu, Dec 19, 2024 at 09:02:27AM +0000, Daniel Stone wrote:
> > > > On Wed, 18 Dec 2024 at 10:32, Brian Starkey <brian.starkey@arm.com> wrote:
> > > > > On Wed, Dec 18, 2024 at 11:24:58AM +0000, Simona Vetter wrote:
> > > > > > For that reason I think linear modifiers with explicit pitch/size
> > > > > > alignment constraints is a sound concept and fits into how modifiers work
> > > > > > overall.
> > > > > 
> > > > > Could we make it (more) clear that pitch alignment is a "special"
> > > > > constraint (in that it's really a description of the buffer layout),
> > > > > and that constraints in-general shouldn't be exposed via modifiers?
> > > > 
> > > > It's still worryingly common to see requirements for contiguous
> > > > allocation, if for no other reason than we'll all be stuck with
> > > > Freescale/NXP i.MX6 for a long time to come. Would that be in scope
> > > > for expressing constraints via modifiers as well, and if so, should we
> > > > be trying to use feature bits to express this?
> > > > 
> > > > How this would be used in practice is also way too underdocumented. We
> > > > need to document that exact-round-up 64b is more restrictive than
> > > > any-multiple-of 64b is more restrictive than 'classic' linear. We need
> > > > to document what people should advertise - if we were starting from
> > > > scratch, the clear answer would be that anything which doesn't care
> > > > should advertise all three, anything advertising any-multiple-of
> > > > should also advertise exact-round-up, etc.
> > > > 
> > > > But we're not starting from scratch, and since linear is 'special',
> > > > userspace already has explicit knowledge of it. So AMD is going to
> > > > have to advertise LINEAR forever, because media frameworks know about
> > > > DRM_FORMAT_MOD_LINEAR and pass that around explicitly when they know
> > > > that the buffer is linear. That and not breaking older userspace
> > > > running in containers or as part of a bisect or whatever.
> > > > 
> > > > There's also the question of what e.g. gbm_bo_get_modifier() should
> > > > return. Again, if we were starting from scratch, most restrictive
> > > > would make sense. But we're not, so I think it has to return LINEAR
> > > > for maximum compatibility (because modifiers can't be morphed into
> > > > other ones for fun), which further cements that we're not removing
> > > > LINEAR.
> > > > 
> > > > And how should allocators determine what to go for? Given that, I
> > > > think the only sensible semantics are, when only LINEAR has been
> > > > passed, to pick the most restrictive set possible; when LINEAR
> > > > variants have been passed as well as LINEAR, to act as if LINEAR were
> > > > not passed at all.
> > > 
> > > Yeah I think this makes sense, and we'd need to add that to the kerneldoc
> > > about how drivers/apps/frameworks need to work with variants of LINEAR.
> > > 
> > > Just deprecating LINEAR does indeed not work. The same way it was really
> > > hard slow crawl (and we're still not there everywhere, if you include
> > > stuff like bare metal Xorg) trying to retire the implied modifier. Maybe,
> > > in an extremely bright future were all relevant drivers advertise a full
> > > set of LINEAR variants, and all frameworks understand them, we'll get
> > > there. But if AMD is the one special case that really needs this I don't
> > > think it's realistic to plan for that, and what Daniel describe above
> > > looks like the future we're stuck to.
> > > -Sima
> > 
> > I spent some time thinking about this over the break, because on a venn
> > diagram it does overlap a sliver of the work we've done to define the
> > differences between the concepts of constraints Vs. capabilities in the
> > smorgasbord of unified memory allocator talks/workshops/prototypes/etc.
> > over the years. I'm not that worried about some overlap being
> > introduced, because every reasonable rule deserves an exception here and
> > there, but I have concerns similar to Daniel's and Brian's.
> > 
> > Once you start adding more than one special modifier, some things in the
> > existing usage start to break down. Right now you can naively pass
> > around modifiers, then somewhere either before or just after allocation
> > depending on your usage, check if LINEAR is available and take your
> > special "I can parse this thing" path, for whatever that means in your
> > special use case. Modifying all those paths to include one variant of
> > linear is probably OK-but-not-great. Modifying all those paths to
> > include <N> variants of linear is probably unrealistic, and I do worry
> > about slippery slopes here.
> > 
> > ---
> > 
> > What got me more interested though was this led to another thought. At
> > first I didn't notice that this was an exact-match constraint and
> > thought it meant the usual alignment constraint of >=, and I was
> > concerned about how future variants would interact poorly. It could
> > still be a concern if things progress down this route, and we have
> > vendor A requiring >= 32B alignment and vendor B requiring == 64B
> > alignment. They're compatible, but modifiers expressing this would
> > naively cancel each-other out unless vendor A proactively advertised ==
> > 64B linear modifiers too. This isn't a huge deal at that scale, but it
> > could get worse, and it got me thinking about a way to solve the problem
> > of a less naive way to merge modifier lists.
> > 
> > As a background, the two hard problems left with implementing a
> > constraint system to sit alongside the format modifier system are:
> > 
> > 1) A way to name special heaps (E.g., local vidmem on device A) in the
> > constraints in a way that spans process boundaries using some sort of
> > identifier. There are various ways to solve this. Lately the thinking is
> > something around dma heaps, but no one's fleshed it out yet that I'm aware.
> > 
> > 2) A transport that doesn't require us to revise every userspace API,
> > kernel API, and protocol that got revised to support DRM format
> > modifiers, and every API/protocol introduced since.
> > 
> > I haven't seen any great ideas for the latter problem yet, but what if
> > we did this:
> > 
> > - Introduced a new DRM format modifier vendor that was actually
> > vendor-agnostic, but implied the format modifier was a constraint
> > definition fragment instead of an actual modifier.
> > 
> > - Constraint-aware code could tack on its constraints (The ones it
> > requires and/or the ones it can support allocating) as a series of
> > additional modifiers using this vendor code. A given constraint might be
> > fragmented into multiple modifiers, but their definition and
> > serialization/deserialization mechanism could be defined in drm_fourcc.h
> > as macros all the clients could use.
> > 
> > - Existing non-constraint-aware code in a modifier usage chain might
> > filter these modifiers out using the existing strict intersection logic.
> > Hence, any link in the chain not aware of constraints would likely block
> > their use, but that's OK. We're muddling along without them now. It
> > wouldn't make those situations any worse.
> > 
> > - New code would be required to use some minimal library (Header-only
> > perhaps, as Simon and I proposed a few years ago) to intersect format
> > modifier lists instead, and this code would parse out the constraint
> > modifiers from each input list and use the envisioned per-constraint
> > logic to merge them. It would result in yet another merged
> > modifier+constraint list encoded as a list of modifiers that could be
> > passed along through any format-modifier-aware API.
> > 
> > - One consideration that would be sort of tricky is that constraints are
> > supposed to be advertised per-modifier, so you'd have to have a way to
> > associate constraint modifiers in a given set with real modifiers in
> > that set or in general. This is easily solved though. Some bits of the
> > constraint modifiers would already need to be used to associate and
> > order constraint fragments during deserialization, since modifier lists
> > aren't strictly ordered.
> > 
> > This effectively allows you to use format modifiers to encode
> > arbitrarily complex constraint mechanisms by piggybacking on the
> > existing format modifier definition and transport mechanisms without
> > breaking backwards compatibility. It's a little dirty, because modifiers
> > are being abused to implement a raw bitstream, but modifiers and
> > constraints are related concepts, so it's not a complete hack. It still
> > requires modifying all the implementations in the system to fully make
> > use of constraints, but doesn't require e.g. revising X11 DRI3 protocol
> > again to tunnel them through Xwayland, and in situations where the
> > constraint-aware thing sits downstream of the non-constraint-aware thing
> > in the allocation pipeline, you could get some benefit even when all the
> > upstream things aren't updated yet, because it could still merge in its
> > local constraints before allocating or passing the modifier list down
> > the chain.
> > 
> > Does this seem like something worth pursuing to others? I've been trying
> > to decide how to best move the allocation constraints efforts forward,
> > so it's potentially something I could put some time into this year.
> > 
> > Thanks,
> > -James
> 

-- 
Simona Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
