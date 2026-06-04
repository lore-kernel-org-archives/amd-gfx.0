Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F020ACD6E4A
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Jun 2026 13:58:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6C4F511A0EA;
	Thu,  4 Jun 2026 13:58:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="Q04oiKb7";
	dkim-atps=neutral
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5CCB211A0EA
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 Jun 2026 13:58:17 +0000 (UTC)
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4gWR3n4qS0z9tkg;
 Thu,  4 Jun 2026 15:58:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1780581494;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=20HnuCiLeZUp7D71D0Pu4lsKsj/HfsPf3C0COQTiyfE=;
 b=Q04oiKb7JIK6kXBYuDqtzk8cYQ2FUiD2Xze5bRXZdnfkcdFJXSSgR7ePt5YaVIt/Ib3i3H
 dQQ7htsMPSdrrHxFzZVu8mJDR6t+rq4GAniga4Km4exuAbgksY04wns84l0xo+htJAEkhf
 j7pXT5atztUERk+mBiMi02TeiiS4Rba4draOQ54tAHPAQ4tAG6UhKYxFETGJUoReeX9mJV
 SjSGwoU/w71bvJ67lLEd57XLGOQPj1tVVvmxyQRXYa+Ff6bc/illq2acytohmxS2+PJFO8
 8k+4H27DU+JIV0o6v1CUFcgryXmGnQsgb8GHnzPgXFAQpk9EhVDVjCdpo92uyQ==
Message-ID: <39ff584f-66ed-421a-918b-347d020a393a@mailbox.org>
Date: Thu, 4 Jun 2026 15:58:09 +0200
MIME-Version: 1.0
Subject: Re: Test result / finding of "drm/amd/display: Consult MCCS FreeSync
 cap only if requested & supported"
To: Alex Deucher <alexdeucher@gmail.com>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 Thorsten Leemhuis <regressions@leemhuis.info>,
 Pei-Hsin Yang <peihsiny@valvesoftware.com>,
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
From: =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel.daenzer@mailbox.org>
Content-Language: en-CA
In-Reply-To: <CADnq5_O9xMagapKQSO-6waXtmmFkDV-47ExVaNuiZd2xVdhefw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: d774bbd2ba4169ceed4
X-MBO-RS-META: dowj6wdkmupcjgb6gsrzft39m4na7k8a
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

On 6/4/26 15:20, Alex Deucher wrote:
> On Thu, Jun 4, 2026 at 3:59 AM Michel Dänzer <michel.daenzer@mailbox.org> wrote:
>> On 5/29/26 00:02, Deucher, Alexander wrote:
>>>> From: Thorsten Leemhuis <regressions@leemhuis.info>
>>>> On 5/21/26 09:09, Michel Dänzer wrote:
>>>>>
>>>>> Note that some kind of short-term solution is needed for the regression(s) in
>>>> 7.1-rc.
>>>>
>>>> Yeah, that would be good. Makes me wonder how the rough plan to realize
>>>> this looks like? Sounds like Michael's patch[1] that was discussed here is not a
>>>> good option? Reminder, Linus ideally wants known regression fixed by -rc6,
>>>> which is why I'm asking.
>>>
>>> @Wentland, Harry can you sort this out for next week's -fixes PR?
>>
>> Looks like this regression will make it to 7.1 final?
>>
>> I filed https://gitlab.freedesktop.org/drm/amd/-/work_items/5286 3 weeks ago, and proposed a fix the following week. There's been no reaction by any AMD display developer.
>>
>> This is pretty sad.
> 
> @Wentland, Harry , @Leo (Sunpeng) Li come on guys!  I've picked up
> Michel's patch and I'll send an update -PR today.

Thanks Alex.


Note that Pei-Hsin reported an issue when running with my fix at the start of this thread, unfortunately it's still unclear if that's a regression of my fix or happens even without it (in which case it might be another regression of the MCCS related changes for 7.1).

An alternative would be reverting the 4 commits d49086491bcb..8dc88c6a5948.


-- 
Earthling Michel Dänzer       \        GNOME / Xwayland / Mesa developer
https://redhat.com             \               Libre software enthusiast
