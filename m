Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07CAEC433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Nov 2021 15:37:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 841EB6E85F;
	Wed, 24 Nov 2021 15:37:06 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4CDD26E838;
 Wed, 24 Nov 2021 15:35:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
 Subject:Sender:Reply-To:Content-ID:Content-Description;
 bh=HR2bPhOh6y/Sf5n3jhbYJzVMzoIIcULV90TnyCvdCuc=; b=aRhazJxBSfJbaE77TdGnnejHwm
 dcAdMLbzN58H5/FwM3asc3PuurCBNF6Upei0LnxAyDAE4+Vyz8nU+JiwoIPsYrncPkn7lW5CIaUal
 fBc+AEb18gLB2ixUN3Ma30q/DdvPaxu/a4Vr3YeCklnINhLEiLuaEuQbtNeZOYa3lymriJVqWfurf
 H+jfQ3LGQ1ZglWJnFjFfWMFKnf4w3UqOfmJxPDwZbogRdBL0m68Fe/5TVYqx7/0chg0Vi3/+2+nFf
 8C1l7pHTaBPviaNyW7JiIV6d+XAapfeHNUtQ3pKVujn8xW5GoLeriOdKHEeCvQbRC5jbU8N2d7Ah/
 9KKhWB4A==;
Received: from [2601:1c0:6280:3f0::aa0b]
 by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mpuIg-00566i-JH; Wed, 24 Nov 2021 15:35:10 +0000
Subject: Re: linux-next: Tree for Nov 24
 (drivers/gpu/drm/amd/display/dc/dsc/rc_calc_dpi.o)
To: Stephen Rothwell <sfr@canb.auug.org.au>,
 Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20211124161632.1aabe7a5@canb.auug.org.au>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <4084c3ab-1467-8da6-200d-9f123c3b99ac@infradead.org>
Date: Wed, 24 Nov 2021 07:35:09 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211124161632.1aabe7a5@canb.auug.org.au>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Wed, 24 Nov 2021 15:37:05 +0000
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
Cc: Leo Li <sunpeng.li@amd.com>, Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 DRI <dri-devel@lists.freedesktop.org>, amd-gfx@lists.freedesktop.org,
 Harry Wentland <harry.wentland@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 11/23/21 9:16 PM, Stephen Rothwell wrote:
> Hi all,
> 
> Changes since 20211123:
> 

on i386:

ld: drivers/gpu/drm/amd/display/dc/dsc/rc_calc_dpi.o: in function `dscc_compute_dsc_parameters':
rc_calc_dpi.c:(.text+0x31f): undefined reference to `__udivdi3'


-- 
~Randy
