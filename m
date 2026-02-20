Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D9A7C531FC
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Feb 2026 03:14:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EB7D388130;
	Fri, 20 Feb 2026 03:14:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="VpBNfBQK";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CC45910E771;
 Fri, 20 Feb 2026 03:14:09 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id E11DC60054;
 Fri, 20 Feb 2026 03:14:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25C18C4CEF7;
 Fri, 20 Feb 2026 03:14:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1771557248;
 bh=IVN7r0xifPkdyJXi/FO57cCcO7FR6lu7aoviGEL/TIU=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=VpBNfBQKAQHyHko8NqxvqnEC46v6jYRrZ/qHUzqjgYvFiANO7oipkHFjHYM/o5SOS
 6FLKeUTEGUZLJqlwnoNer2FNAYZ9CSBi6HfBp6LPhYkABJALwFVy+BHCJdqFhHt3yX
 whh9PdXTTsUQhHBnDZpKHyfEi1A8tOHFX7AGuw/Wk8kc2cOCSB/FjhDKaysfYE2Vmt
 UmtL6X6y/s13xee7y19AC1aNFxQLblg/ttFBli9JtpmMPBLzgfaB3Oiju+TUSdX+S9
 Yz72ypRl+GS1QdUChjrsq5czaSNEAuXlEm10W37iTHjj/zl9hYJK77+jOkV9iA7/Er
 2qlgOnYFO6WyA==
Message-ID: <c70fe261-7fb0-4af5-b755-f02b193c8c5f@kernel.org>
Date: Thu, 19 Feb 2026 21:14:05 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] VRR not detected on a DisplayPort monitor using an
 AMD GPU
To: Ivan Sergeev <ivan8215145640@gmail.com>, amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, regressions@lists.linux.dev,
 mwen@igalia.com, mario.limonciello@amd.com, alex.hung@amd.com,
 daniel.wheeler@amd.com, rodrigo.siqueira@amd.com, alexander.deucher@amd.com,
 harry.wentland@amd.com, sunpeng.li@amd.com, christian.koenig@amd.com,
 huangalex409@gmail.com
References: <CAKx_Wg7_HBxuq5W4T_AmoFYJGQpa6TAS_Fx9SUzyy1itPmj5Bw@mail.gmail.com>
 <090d89a2-4f80-44ef-827c-6462d8948493@kernel.org>
 <DGJFVPAQJA15.378GMU7XZXLU@gmail.com> <DGJGDIRQWDG7.XHHKF6UQP0HG@gmail.com>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <DGJGDIRQWDG7.XHHKF6UQP0HG@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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



On 2/19/26 9:02 PM, Ivan Sergeev wrote:
> On Fri Feb 20, 2026 at 5:38 AM MSK, Ivan Sergeev wrote:
>>
>> I've done the bisect using the v6.12.68 tag as good and v6.18.8 tag as bad
> 
> Sorry, those are not the tags I've used for the bisect. Before doing a
> bisect in git I first checked versions from 6.18 to 6.13, and could
> reproduce the issue in all of them, so after that I went for the git
> bisect between 6.12.68 and 6.13.6.

I'm wondering if you actually have a second regression manifesting 
similarly.

Can you check out at your bad commit and apply just 7f2b5237e313 at the 
bad commit?  Confirm that fixes it.

If it does, then redo your bisect applying 7f2b5237e313 where applicable.
