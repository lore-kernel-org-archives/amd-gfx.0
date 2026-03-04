Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BB9BEB7EC9
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Mar 2026 10:57:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F1B0910E9B3;
	Wed,  4 Mar 2026 10:57:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="CbACVGIc";
	dkim-atps=neutral
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com
 [209.85.128.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F20D610E98E
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Mar 2026 09:30:37 +0000 (UTC)
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-48371119eacso80386755e9.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 04 Mar 2026 01:30:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772616636; x=1773221436; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BUzQoESoh9/PqMSFbMpuw4Pmh5IPXiGP/qvOjxX4wwo=;
 b=CbACVGIcQcxbQyCeWsG4sb0WsRIh99qRkO3bvVEdbdMUYKScNfOaPGjnL7aufnMbj1
 gYoa3mnyqY+7k2xOeFpz78zGuaHlPvukGfrlxJvkyPPG9g/rRNCfozER4kTQdOVYNamH
 a9F/HG2cQ/6j3RIgs8h1L2xfDPykm5l9rEnlFJ0Es9hUeYz0zv/elwqxGkCNehoqshue
 rCQooOaM9h37Bo6LDKzbAv23D53UD93woE5b1c0J0eeuNuxvHfH3xwqie5Z6xebLRMh4
 M5CRONHYNcl25pVh+6XOvNW1akMztJI+PXMzKqLGHwaYfj1LLx5mhVhzeld+6C5RTl2K
 T+tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772616636; x=1773221436;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=BUzQoESoh9/PqMSFbMpuw4Pmh5IPXiGP/qvOjxX4wwo=;
 b=rqTudEAsqqLjuYq6f7eHmyUrwK3aNZogVa4BlGyDE0+YV9b+sUS/kew1V+fC0bKovd
 n+3bg8nA/pe8ZD4kCKiHE17FBnCpSQU+oNDeP04FYQvGRBEZTcPoIeFAT81IdWAegUkg
 rNzsEVCsL71mV/1kDFFOIlf1diJdOeJf+1bzo7E2U4cbqzmvkZQQ2xFGzgR1t6sL6Qh8
 XG5BF1Gj0WtZveDkpktXpFKmYY/Hr36oyGqYl5UPn/H/xLWL7taGC1/MQoT6MC2IKFwh
 PSP7KHu/U2M8hKy0bzFbHf8/gKAA6GPaZaL1n+cW86fI1rELtSODt9DBXIbZ19qPUEho
 /5OQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWbJkI0eV/vNnwCJK1DGu7CBsfDoZIvjZk4N+Ov6c1ZWNW8SyAz6M/KLOxXhQATEyn4Fld4NeG5@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yxa5ILq3D6WUu0akEI+gKAbjOPJcfecVlyKcwtwvrIemoyqk26W
 OHtzqXJseK0c4uu+K6d35zItjUuflrweQvUjvU63eszcgZ477mhZ/Qc+
X-Gm-Gg: ATEYQzz7UTF/RF+/T910uc07rOpiK0jNmlHe1artj36mhKbabbhUnu8T3j8AXiEBr8e
 +awNboDWtXVptHdcTwU1llROaZwF83Da5PqWoaBScgyJua8hPvuGRMsOQHmWjCvEOC/UmLlbdCM
 +dC1Q5zxzvzkjGHRbA4qeUP20xY+Inklk+Eg9UK8mpC5cHrlC82nI3K0HZ7I3ecduRdOs/HQBpT
 RJFKFFVqu6itagYaRrIPmZMkIfK29BrfsBA59B9c2gz5udmADfHyQYExpKf3cjOampAaTqRpHEy
 w7PAdfB+/W9iA+qfdkoFCsM2SoHVzdjRTMeZhHcVR58NzquOzyPvA0zW9K0p+xA/k48dxSaXbyN
 8V7gDwZLq/2eFca6KOk7LFxTPO5SUWOOewNAitanA9rUZPhl5J0LAP6gfMtPEaHpyKxZH4o4Maw
 T6Bg9d4ncTv+jRiIS0XDMRYTi2KcwL2KaQodf9JPqpgChjiUHPeQQoCjG7yPTcpYFa
X-Received: by 2002:a05:600c:8b53:b0:483:498f:7963 with SMTP id
 5b1f17b1804b1-4851989024emr19550785e9.26.1772616636117; 
 Wed, 04 Mar 2026 01:30:36 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4851884225asm38972555e9.6.2026.03.04.01.30.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Mar 2026 01:30:35 -0800 (PST)
Date: Wed, 4 Mar 2026 09:30:33 +0000
From: David Laight <david.laight.linux@gmail.com>
To: NeilBrown <neilb@ownmail.net>
Cc: "Jeff Layton" <jlayton@kernel.org>, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 nvdimm@lists.linux.dev, fsverity@lists.linux.dev, linux-mm@kvack.org,
 netfs@lists.linux.dev, linux-ext4@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-nfs@vger.kernel.org,
 linux-cifs@vger.kernel.org, samba-technical@lists.samba.org,
 linux-nilfs@vger.kernel.org, v9fs@lists.linux.dev,
 linux-afs@lists.infradead.org, autofs@vger.kernel.org,
 ceph-devel@vger.kernel.org, codalist@coda.cs.cmu.edu,
 ecryptfs@vger.kernel.org, linux-mtd@lists.infradead.org,
 jfs-discussion@lists.sourceforge.net, ntfs3@lists.linux.dev,
 ocfs2-devel@lists.linux.dev, devel@lists.orangefs.org,
 linux-unionfs@vger.kernel.org, apparmor@lists.ubuntu.com,
 linux-security-module@vger.kernel.org, linux-integrity@vger.kernel.org,
 selinux@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org,
 linaro-mm-sig@lists.linaro.org, netdev@vger.kernel.org,
 linux-perf-users@vger.kernel.org, linux-fscrypt@vger.kernel.org,
 linux-xfs@vger.kernel.org, linux-hams@vger.kernel.org,
 linux-x25@vger.kernel.org, audit@vger.kernel.org,
 linux-bluetooth@vger.kernel.org, linux-can@vger.kernel.org,
 linux-sctp@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH v2 000/110] vfs: change inode->i_ino from unsigned long
 to u64
Message-ID: <20260304092559.554ac9a9@pumpkin>
In-Reply-To: <177260561903.7472.14075475865748618717@noble.neil.brown.name>
References: <20260302-iino-u64-v2-0-e5388800dae0@kernel.org>
 <1787281.1772535332@warthog.procyon.org.uk>
 <1c28e34c7167acf4e20c3e201476504135aa44e8.camel@kernel.org>
 <177260561903.7472.14075475865748618717@noble.neil.brown.name>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Wed, 04 Mar 2026 10:57:55 +0000
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

On Wed, 04 Mar 2026 17:26:59 +1100
NeilBrown <neilb@ownmail.net> wrote:

> On Tue, 03 Mar 2026, Jeff Layton wrote:
> > On Tue, 2026-03-03 at 10:55 +0000, David Howells wrote:  
> > > Jeff Layton <jlayton@kernel.org> wrote:
> > >   
> > > > This version splits the change up to be more bisectable. It first adds a
> > > > new kino_t typedef and a new "PRIino" macro to hold the width specifier
> > > > for format strings. The conversion is done, and then everything is
> > > > changed to remove the new macro and typedef.  
> > > 
> > > Why remove the typedef?  It might be better to keep it.
> > >   
> > 
> > Why? After this change, internel kernel inodes will be u64's -- full
> > stop. I don't see what the macro or typedef will buy us at that point.  
> 
> Implicit documentation?
> ktime_t is (now) always s64, but we still keep the typedef;
> 
> It would be cool if we could teach vsprintf to understand some new
> specifier to mean "kinode_t" or "ktime_t" etc.  But that would trigger
> gcc warnings.

A more interesting one would be something that made gcc re-write the
format with the correct 'length modifier' for the parameter.

That would save a lot of effort!

	David

> 
> NeilBrown
> 

