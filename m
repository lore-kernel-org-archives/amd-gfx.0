Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4378DC6FD18
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Apr 2023 14:43:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DE27C10E133;
	Wed, 19 Apr 2023 14:43:28 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D113F10E9CA
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Apr 2023 14:15:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
 References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=PwVq/qutJNHYdGyaN2pFZpUUGRnNT+OajhbfjI6fupE=; b=JZD7OMRk62qwBM4VOvDjO+3RlN
 dG32QY6u50xWg5HL9O92ZtTSv6IT4OlHw4RzHMTJVoKaZunJBk9GCl1WpgpaRA2TDSPYxcmOJvksL
 uXUVppUWH/2L6E20giQPjgswCASUstOeXEYYsXTMJ2uxM8oNsxc2AKPfFCGCF7ifP+LuBHo7n0DGw
 TgFDevFu2JzhUZNhrPqdiFrx33XouA8GZT3aoDe0/Yl0l88lUP8+99pJK79jzTC10aGJEWPdKMc2Z
 qmgBjnEfez4MixEvwVXcaPAvH/VxEp7XZd9sy4pouieeCfsXeDF0S+U3ghHWoscV3zH0hDpNMP02+
 8GT0xFvA==;
Received: from 201-92-79-199.dsl.telesp.net.br ([201.92.79.199]
 helo=[192.168.1.60]) by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1pp8aN-005PWp-TI; Wed, 19 Apr 2023 16:15:04 +0200
Message-ID: <be4babae-4791-11f3-1f0f-a46480ce3db2@igalia.com>
Date: Wed, 19 Apr 2023 11:14:58 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 6.1.y] drm/amdgpu/vcn: Disable indirect SRAM on Vangogh
 broken BIOSes
Content-Language: en-US
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>
References: <20230418221522.1287942-1-gpiccoli@igalia.com>
 <BL1PR12MB514405B37FC8691CB24F9DADF7629@BL1PR12MB5144.namprd12.prod.outlook.com>
From: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <BL1PR12MB514405B37FC8691CB24F9DADF7629@BL1PR12MB5144.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Wed, 19 Apr 2023 14:43:26 +0000
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
Cc: "sashal@kernel.org" <sashal@kernel.org>,
 "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
 "kernel@gpiccoli.net" <kernel@gpiccoli.net>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>,
 "kernel-dev@igalia.com" <kernel-dev@igalia.com>, "Zhu,
 James" <James.Zhu@amd.com>, "Liu, Leo" <Leo.Liu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 19/04/2023 10:16, Deucher, Alexander wrote:
> [...]
>> This is quite strange for me, we have 2 commit hashes pointing to the
>> *same* commit, and each one is present..in a different release !!?!
>> Since I've marked this patch as fixing 82132ecc5432 originally, 6.1.y stable
>> misses it, since it only contains 9a8cc8cabc1e (which is the same patch!).
>>
>> Alex, do you have an idea why sometimes commits from the AMD tree
>> appear duplicate in mainline? Specially in different releases, this could cause
>> some confusion I guess.
> 
> This is pretty common in the drm.  The problem is there is not a good way to get bug fixes into both -next and -fixes without constant back merges.  So the patches end up in -next and if they are important for stable, they go to -fixes too.  We don't want -next to be broken, but we can't wait until the next kernel cycle to get the bug fixes into the current kernel and stable.  I don't know of a good way to make this smoother.
> 
> Alex

Thanks Alex, seems quite complicated indeed.

So, let me check if I understood properly: there are 2 trees (-fixes and
-next), and the problem is that their merge onto mainline happens apart
and there are kind of duplicate commits, that were first merged on
-fixes, then "re-merged" on -next, right?

Would be possible to clean the -next tree right before the merge, using
some script to find commits there that are going to be merged but are
already present? Then you'd have a -next-to-merge tree that is clean and
doesn't present dups, avoiding this.

Disclaimer: I'm not a maintainer, maybe there are smart ways of doing
that or perhaps my suggestion is silly and unfeasible heh
But seems likely that other maintainers face this problem as well and
came up with some solution - avoiding the dups would be a good thing,
IMO, if possible.

Cheers,


Guilherme


