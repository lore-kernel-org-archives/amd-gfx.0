Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 745F6C25B08
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Aug 2022 02:11:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 28530B3BF2;
	Thu, 18 Aug 2022 02:11:20 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:3::133])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CA947B3B91;
 Thu, 18 Aug 2022 02:09:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
 Message-ID:Sender:Reply-To:Content-ID:Content-Description;
 bh=OSvVOdfA6FOAs8kDqxv//qJumZqVNEgMpVWHYd6sYHE=; b=ys1VzU4EM8SGT6HcPcATTxTCBz
 YhGNIaQuwsVtux+02LwQJ/ONRdIWcjxqbhHsZnXNkUYHiHeWn6xuTfqAi7a138FzBqBGJNXsOYVkM
 5+xI3dUvYbZkXDnDkqMkIm0KmCG1M9hmg4ckZ5uSEs0euHB1SyEHVKvNGUHXSrH1m/diER7q9Es0E
 9oBnFdFbT78A2q9ZPvgQaNcuNy5cgi9ObJIkMW5Lc/palxBvc7GZ1MV5ugbLwZZJVYWkxOcsdz+IM
 LNMbfnGN06rM+MEEUGTWUnOv7Eu5db00otKav1YD6eWbQuGZlnlF/kBK40DoSO9RJeu7X1+L4umRk
 ASA7BsYw==;
Received: from [2601:1c0:6280:3f0::a6b3]
 by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1oOUyN-00AzBi-GK; Thu, 18 Aug 2022 02:09:27 +0000
Message-ID: <5638aaf1-b808-bdc6-d84a-820f24facea6@infradead.org>
Date: Wed, 17 Aug 2022 19:09:26 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: build failure of next-20220817 for amdgpu
Content-Language: en-US
To: Alex Deucher <alexdeucher@gmail.com>,
 "Sudip Mukherjee (Codethink)" <sudipm.mukherjee@gmail.com>
References: <Yv1lepjhg/6QKyQl@debian>
 <CADnq5_Od9W1iuzYpsmODOB=Xem97ogeH_t0JrjWC-S8h0XM9fA@mail.gmail.com>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <CADnq5_Od9W1iuzYpsmODOB=Xem97ogeH_t0JrjWC-S8h0XM9fA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Thu, 18 Aug 2022 02:11:11 +0000
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
Cc: David Airlie <airlied@linux.ie>, "Pan, Xinhui" <Xinhui.Pan@amd.com>,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-next@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 Daniel Vetter <daniel@ffwll.ch>, Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 8/17/22 19:01, Alex Deucher wrote:
> On Wed, Aug 17, 2022 at 6:03 PM Sudip Mukherjee (Codethink)
> <sudipm.mukherjee@gmail.com> wrote:
>>
>> Hi All,
>>
>> Not sure if it has been reported, build of next-20220817 fails with the
>> error:
>>
>> ERROR: modpost: "cpu_smallcore_map" [drivers/gpu/drm/amd/amdgpu/amdgpu.ko] undefined!
>>
>> Trying to do a git bisect to find out the offending commit.
>>
> 
> Thanks.  I don't see that symbol in the driver at all.  Not sure where
> it is coming from.
> 

It's powerpc only.

Sudip, is it non-CONFIG_SMP by any chance?

> 
> 
>> I will be happy to test any patch or provide any extra log if needed.
>>
>>
>> --
>> Regards
>> Sudip

-- 
~Randy
