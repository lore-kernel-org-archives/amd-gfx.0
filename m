Return-Path: <SRS0=Seja=5K=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFC2CC43331
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Mar 2020 23:31:03 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C0CC420719
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Mar 2020 23:31:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0CC420719
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=earthlink.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 86AC86E84E;
	Wed, 25 Mar 2020 23:31:02 +0000 (UTC)
Received: from elasmtp-masked.atl.sa.earthlink.net
 (elasmtp-masked.atl.sa.earthlink.net [209.86.89.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B205E6E84E
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Mar 2020 23:31:01 +0000 (UTC)
Received: from [104.136.253.32] (helo=[192.168.0.11])
 by elasmtp-masked.atl.sa.earthlink.net with esmtpa (Exim 4)
 (envelope-from <mrmazda@earthlink.net>) id 1jHFUB-00052U-Jj
 for amd-gfx@lists.freedesktop.org; Wed, 25 Mar 2020 19:30:59 -0400
Subject: Re: rv200 video corruption caused by what? kernel? Xserver? DDX? Mesa?
To: amd-gfx@lists.freedesktop.org
References: <f3ee9d2f-ab80-5e66-08e2-02bc773699c3@earthlink.net>
 <CADnq5_NQ=NUueGK4+V1Z0ZjfjKzis9bHJLZdxqtsNdhw_oW8Sg@mail.gmail.com>
From: Felix Miata <mrmazda@earthlink.net>
Organization: less than infinite
Message-ID: <5f3d97d6-18bf-b6f9-f81f-30a735eb2716@earthlink.net>
Date: Wed, 25 Mar 2020 19:30:59 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 SeaMonkey/2.49.5
MIME-Version: 1.0
In-Reply-To: <CADnq5_NQ=NUueGK4+V1Z0ZjfjKzis9bHJLZdxqtsNdhw_oW8Sg@mail.gmail.com>
X-ELNK-Trace: 7235c9a3853724b974bf435c0eb9d478486f62d0a25b55cb963146c00f6b988bd35d0b369e4fcb51350badd9bab72f9c350badd9bab72f9c350badd9bab72f9c
X-Originating-IP: 104.136.253.32
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Alex Deucher composed on 2020-03-25 13:22 (UTC-0400):

> Felix Miata wrote:

>> 01:00.0 VGA compatible controller [0300]: Advanced Micro Devices, Inc. [AMD/ATI] RV200 [Radeon 7500/7500 LE] [1002:5157]

>> Debian Buster and Mageia 7 are OK, but with Fedora 30 and Tumbleweed with
>> kernels newer than 5.3.x, solid background and mouse pointer are all that
>> paint properly: http://fm.no-ip.com/SS/rv200corrupt.png

>> Is this a known problem? If not, whose bug tracker do I file this on, and
>> which component?

> Can you bisect?  The relevant radeon code in all of these components
> hasn't really been touched in ages.  Maybe related to this:
> https://lkml.org/lkml/2019/12/14/263
> but that was kernel 5.4 not 5.3.
I spent a bunch of time looking for in between kernels to try. In the process I
tried also with RV250 and RV380 without being able to repro. Eventually I stumbled
onto radeon.agpmode=-1, which worked around the corruption well enough on Fedora
and Tumbleweed.

I got luckier and found after reading your lkml URL
https://bugs.mageia.org/show_bug.cgi?id=26237
reported against kernel-desktop-5.5.4-1.mga7-1-1.mga7 to produce corrupt Xorg
video described much like observed here. That bug reports fixed with
kernel-desktop-5.5.6-1.mga7. I found and installed 5.5.4 and confirm it's broken,
and that it's fixed in 5.5.6-2.mga7, which explains why I failed to experience
this in Mageia, where I had jumped from 5.3.13 to 5.4.17.

Apparently whatever Mageia did should be upstreamed if it hasn't been lately.
Fedora's 5.5.10 remains bad.
-- 
Evolution as taught in public schools is religion, not science.

 Team OS/2 ** Reg. Linux User #211409 ** a11y rocks!

Felix Miata  ***  http://fm.no-ip.com/
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
