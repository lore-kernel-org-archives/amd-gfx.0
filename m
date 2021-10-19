Return-Path: <SRS0=2AtA=PH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08070C433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Oct 2021 07:54:25 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F0204611EF
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Oct 2021 07:54:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org F0204611EF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5F45D6EB41;
	Tue, 19 Oct 2021 07:54:22 +0000 (UTC)
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6F0C56EB41
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Oct 2021 07:54:20 +0000 (UTC)
Received: from [192.168.0.2] (ip5f5aef98.dynamic.kabel-deutschland.de
 [95.90.239.152])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested) (Authenticated sender: pmenzel)
 by mx.molgen.mpg.de (Postfix) with ESMTPSA id DD19F61E5FE00;
 Tue, 19 Oct 2021 09:54:18 +0200 (CEST)
Subject: Re: [PATCH 0/5] Remove 0 MHz as a valid current frequency (v4)
To: Luben Tuikov <luben.tuikov@amd.com>
Cc: amd-gfx@lists.freedesktop.org,
 Alexander Deucher <Alexander.Deucher@amd.com>
References: <20211018234913.42349-1-luben.tuikov@amd.com>
 <a653a699-69a9-9671-4bfd-e02f3d22fc2f@molgen.mpg.de>
 <6ce5dbce-fe8e-3535-d9c3-1a45e0fcb7f0@amd.com>
From: Paul Menzel <pmenzel@molgen.mpg.de>
Message-ID: <8a83562c-5af3-58e7-aaca-2159e1dc1739@molgen.mpg.de>
Date: Tue, 19 Oct 2021 09:54:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <6ce5dbce-fe8e-3535-d9c3-1a45e0fcb7f0@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
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

Dear Luben,


Thank you for your quick reply.

Am 19.10.21 um 09:43 schrieb Luben Tuikov:
> On 2021-10-19 03:23, Paul Menzel wrote:

>> Sorry, two more style nits.
>>
>> 1.  Could you please use 75 characters per line for the text width of
>> the commit messages. Currently, especially 4/5, are hard to read being
>> so short.
> 
> This is the default we use--I've not made any changes to the wrap.

What do you mean? Your editor wraps the lines at the point, where you 
configured it, doesn’t it?

> git-log(1) indents the text by 4/8 chars and it looks better if the
> text doesn't roll past 75 chars per line in git-log.
Patch 4/5 uses a text width of 50 characters, which is too short. From 
commit 2a076f40d8c9 (checkpatch, SubmittingPatches: suggest line 
wrapping commit messages at 75 columns) [1], which added a check for too 
long lines:

> Suggest line wrapping at 75 columns so the default git commit log
> indentation of 4 plus the commit message text still fits on an 80 column
> screen.


>> 2.  No idea, what is done in amd-gfx, but for me it is more common to
>> put the iteration number (reroll count) in the PATCH tag in the
>> beginning. No idea, how Patchwork deals with it.
> 
> This is what we do in amd-gfx and particularly in amdgpu, so that the
> version of the patch is recorded in the title of the patch and in history.
I forgot. Thank you.


Kind regards,

Paul


[1]: 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=2a076f40d8c9be95bee7bcf18436655e1140447f
