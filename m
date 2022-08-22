Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 340E2C28D13
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Aug 2022 07:19:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F40D397B87;
	Mon, 22 Aug 2022 07:19:01 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:3::133])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A3D3C97D9A
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Aug 2022 03:53:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
 Message-ID:Sender:Reply-To:Content-ID:Content-Description;
 bh=zTBrQi6tIHnpiZJcLtL9JGqfihQa+Uot5l+YHLsSKrU=; b=yU0c+4dj7PJ4pHovwDZMqOakG5
 kLJ+s38h9D7SfdV41AYLVig5CGyaTJp+yb1rT6ZQZX6pFLW3zQLvGLTNQwY9a3AwRpF6KZayqxf8+
 Itgy2L8nsAbjTkfodDLVLVo1MryD2liICOS8lB7x+TQ0gP4i03iCclgyR3nBQg/wWb80vI8TfMASi
 1oCfmk4ti2SqVOvE0qdrSPALegV6PXL9pF45lK4UyqZQ8AyH0xbDszy0qWubUx5/mLzpqijzzvmkR
 hzR093ck590rou/62nsxjfo8eWRG2AymqJ5FvKSaDEP6kNCDt4iWVY1MoNNKTh2kePf8A9uy9FuZV
 k6+ZlYWg==;
Received: from [2601:1c0:6280:3f0::a6b3]
 by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1oPyV6-004Y5h-Pd; Mon, 22 Aug 2022 03:53:20 +0000
Message-ID: <f7214c7d-d573-ef4a-413d-28a63d293838@infradead.org>
Date: Sun, 21 Aug 2022 20:53:19 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH] powerpc: export cpu_smallcore_map for modules
Content-Language: en-US
To: Michael Ellerman <mpe@ellerman.id.au>, linux-kernel@vger.kernel.org
References: <20220819210112.7924-1-rdunlap@infradead.org>
 <87o7wdkkt4.fsf@mpe.ellerman.id.au>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <87o7wdkkt4.fsf@mpe.ellerman.id.au>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Mon, 22 Aug 2022 07:18:35 +0000
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
Cc: "Gautham R . Shenoy" <ego@linux.vnet.ibm.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>, "Pan, Xinhui" <Xinhui.Pan@amd.com>,
 Nicholas Piggin <npiggin@gmail.com>, amd-gfx@lists.freedesktop.org,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Alex Deucher <alexander.deucher@amd.com>, linuxppc-dev@lists.ozlabs.org,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 8/21/22 20:40, Michael Ellerman wrote:
> Randy Dunlap <rdunlap@infradead.org> writes:
>> Fix build error when CONFIG_DRM_AMDGPU=m:
>>
>> ERROR: modpost: "cpu_smallcore_map" [drivers/gpu/drm/amd/amdgpu/amdgpu.ko] undefined!
>>
>> by exporting 'cpu_smallcore_map' just as other per_cpu
>> symbols are exported.
>>
>> drivers/gpu/drm/amd/amdkfd/kfd_device.c calls cpu_smt_mask().
>> This is an inline function on powerpc which references
>> cpu_smallcore_map.
>>
>> Fixes: 425752c63b6f ("powerpc: Detect the presence of big-cores via "ibm, thread-groups"")
>> Fixes: 7bc913085765 ("drm/amdkfd: Try to schedule bottom half on same core")
> 
> That 2nd commit is not in mainline, only linux-next.
> 
> I don't mind merging this fix preemptively, but is that SHA stable?

Felix, Alex, can you answer that, please?

-- 
~Randy
