Return-Path: <SRS0=17Cd=5L=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB085C43331
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Mar 2020 06:04:16 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D64420719
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Mar 2020 06:04:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D64420719
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=earthlink.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1C7E56E27C;
	Thu, 26 Mar 2020 06:04:16 +0000 (UTC)
Received: from elasmtp-galgo.atl.sa.earthlink.net
 (elasmtp-galgo.atl.sa.earthlink.net [209.86.89.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CA5136E277
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Mar 2020 06:04:14 +0000 (UTC)
Received: from [104.136.253.32] (helo=[192.168.0.11])
 by elasmtp-galgo.atl.sa.earthlink.net with esmtpa (Exim 4)
 (envelope-from <mrmazda@earthlink.net>) id 1jHLcj-000C4H-J7
 for amd-gfx@lists.freedesktop.org; Thu, 26 Mar 2020 02:04:13 -0400
Subject: Re: rv200 video corruption caused by what? kernel? Xserver? DDX? Mesa?
From: Felix Miata <mrmazda@earthlink.net>
To: amd-gfx@lists.freedesktop.org
References: <f3ee9d2f-ab80-5e66-08e2-02bc773699c3@earthlink.net>
 <CADnq5_NQ=NUueGK4+V1Z0ZjfjKzis9bHJLZdxqtsNdhw_oW8Sg@mail.gmail.com>
 <5f3d97d6-18bf-b6f9-f81f-30a735eb2716@earthlink.net>
 <1d155a58-d7e5-a286-627a-a03d303257f3@earthlink.net>
Organization: less than infinite
Message-ID: <5e2c78a7-2bc2-e648-611d-51af3b2ae7f4@earthlink.net>
Date: Thu, 26 Mar 2020 02:04:13 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 SeaMonkey/2.49.5
MIME-Version: 1.0
In-Reply-To: <1d155a58-d7e5-a286-627a-a03d303257f3@earthlink.net>
X-ELNK-Trace: 7235c9a3853724b974bf435c0eb9d478486f62d0a25b55cb21e358fd51acb11c2c593befc1f0037d350badd9bab72f9c350badd9bab72f9c350badd9bab72f9c
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

Felix Miata composed on 2020-03-25 20:59 (UTC-0400):

> Felix Miata composed on 2020-03-25 19:30 (UTC-0400):
 
>> Alex Deucher composed on 2020-03-25 13:22 (UTC-0400):
 
>>> Felix Miata wrote:
 
>>>> 01:00.0 VGA compatible controller [0300]: Advanced Micro Devices, Inc. [AMD/ATI] RV200 [Radeon 7500/7500 LE] [1002:5157]
 
>>>> Debian Buster and Mageia 7 are OK, but with Fedora 30 and Tumbleweed with
>>>> kernels newer than 5.3.x, solid background and mouse pointer are all that
>>>> paint properly: http://fm.no-ip.com/SS/rv200corrupt.png
 
>>>> Is this a known problem? If not, whose bug tracker do I file this on, and
>>>> which component?
 
>>> Can you bisect?  The relevant radeon code in all of these components
>>> hasn't really been touched in ages.  Maybe related to this:
>>> https://lkml.org/lkml/2019/12/14/263
>>> but that was kernel 5.4 not 5.3.
 
>> I spent a bunch of time looking for in between kernels to try. In the process I
>> tried also with RV250 and RV380 without being able to repro. Eventually I stumbled
>> onto radeon.agpmode=-1, which worked around the corruption well enough on Fedora
>> and Tumbleweed.
 
>> I got luckier and found after reading your lkml URL
>> https://bugs.mageia.org/show_bug.cgi?id=26237
>> reported against kernel-desktop-5.5.4-1.mga7-1-1.mga7 to produce corrupt Xorg
>> video described much like observed here. That bug reports fixed with
>> kernel-desktop-5.5.6-1.mga7. I found and installed 5.5.4 and confirm it's broken,
>> and that it's fixed in 5.5.6-2.mga7, which explains why I failed to experience
>> this in Mageia, where I had jumped from 5.3.13 to 5.4.17.
 
>> Apparently whatever Mageia did should be upstreamed if it hasn't been lately.
>> Fedora's 5.5.10 remains bad.
 
>>From Mageia kernel-desktop changelogs:
> update to 5.5.6 20200312:
> - work around radeon regression introduced in 5.4 series (mga#26237)
>   * Revert "drm/radeon: simplify and cleanup setting the dma mask"
>   * Revert "drm/radeon: handle PCIe root ports with addressing limitations"
> update to 5.4.6 20200215:
> - Revert "drm/radeon: simplify and cleanup setting the dma mask"
> - Revert "drm/radeon: handle PCIe root ports with addressing limitations" 

I reported a bug: https://bugzilla.kernel.org/show_bug.cgi?id=206973
[AMD/ATI] RV200 [Radeon 7500/7500 LE] [1002:5157] overwhelming video
corruption in Xorg
-- 
Evolution as taught in public schools is religion, not science.

 Team OS/2 ** Reg. Linux User #211409 ** a11y rocks!

Felix Miata  ***  http://fm.no-ip.com/
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
