Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C373BCD6E6B
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Jun 2026 07:42:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6232F11A50E;
	Fri,  5 Jun 2026 07:42:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="BfZ9NUMX";
	dkim-atps=neutral
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 94D4B11A50E
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Jun 2026 07:42:21 +0000 (UTC)
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4gWtgY2hmdz9tSw;
 Fri,  5 Jun 2026 09:42:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1780645337;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HMgUcgbliuW0O9oKzyYh13yjBTCej89mTEZ41tXG0kE=;
 b=BfZ9NUMXT7K805n+3uWei27aK+AtoE7V7H7m+WwOv4yQ/9XrKfvmhhEyVSKa3YMZQWiZKn
 JP/TtSkRajgu/sO20Nz8nHoMT73qm0y6Lrxi0quudOVdGhDVernmVduw7ZbAocy8e6L06a
 DgqDZ5QDorNaVyK7kevTzKLjgUJxZeZCNE7nUL37nxx0++5cIvXDYA4tBI9dgINYxLpP/J
 QvxMZsmSU3YNZ+sckh1Z/0kq8vRqkddqRvpdRzHbg1P9aEXjUC3C7swH6PfUpwmTQ8VGrr
 SkI+fQKuZ3UBsW8A0vgZwvtHt2rPQvMQXq8eK7i/JoFKKK48/RrzRxvar68DMA==
Message-ID: <ebe757cd-59d2-4590-b2f8-1e75a789fdb8@mailbox.org>
Date: Fri, 5 Jun 2026 09:42:14 +0200
MIME-Version: 1.0
Subject: Re: [External Mail] Re: Test result / finding of "drm/amd/display:
 Consult MCCS FreeSync cap only if requested & supported"
To: Pei-Hsin Yang <peihsiny@valvesoftware.com>,
 Alex Deucher <alexdeucher@gmail.com>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 Thorsten Leemhuis <regressions@leemhuis.info>,
 "Wentland, Harry" <Harry.Wentland@amd.com>,
 "Li, Sun peng (Leo)" <Sunpeng.Li@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 Linux kernel regressions list <regressions@lists.linux.dev>,
 "Koenig, Christian" <Christian.Koenig@amd.com>
References: <44069eb146824aa195312f5b02c49287@valvesoftware.com>
 <7a9021cd-fd78-4b0d-846b-135d0d72224e@mailbox.org>
 <16231b1742004f848af243ce398281ec@valvesoftware.com>
 <ce51243c-3b98-4f99-911f-70dd0b860da0@mailbox.org>
 <1c522568-1d5e-4210-8f25-1aa96e0d3c3a@leemhuis.info>
 <BL1PR12MB51447AB016BB28843BAD0216F7092@BL1PR12MB5144.namprd12.prod.outlook.com>
 <af4dff0f-0c62-4a7d-9a3f-fc029c8757f4@mailbox.org>
 <CADnq5_O9xMagapKQSO-6waXtmmFkDV-47ExVaNuiZd2xVdhefw@mail.gmail.com>
 <39ff584f-66ed-421a-918b-347d020a393a@mailbox.org>
 <399d0170414b4304823e866b04ab518a@valvesoftware.com>
From: =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel.daenzer@mailbox.org>
Content-Language: en-CA
In-Reply-To: <399d0170414b4304823e866b04ab518a@valvesoftware.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 0821db636d736f4c1ad
X-MBO-RS-META: c3s3twhtc95fn9umw8hbkuobwdexeiri
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

On 6/4/26 19:21, Pei-Hsin Yang wrote:
> 
>> Note that Pei-Hsin reported an issue when running with my fix at the start of this thread, unfortunately it's still unclear if that's a regression of > my fix or happens even without it (in which case it might be another regression of the MCCS related changes for 7.1).
> 
> As I have mentioned earlier, my testing of your patch confirms that it is a regression even without your patch.

You previously wrote "There are other issues without your patch applied", I didn't see anything about whether or not the issue you reported in the post which started this thread happens without my fix though.

Anyway, thanks for confirming that it's not a regression of my fix, that's a relief.


Alex, since the MCCS changes caused other regressions, it might be better to revert them for now anyway though?


-- 
Earthling Michel Dänzer       \        GNOME / Xwayland / Mesa developer
https://redhat.com             \               Libre software enthusiast
