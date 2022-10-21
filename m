Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25C20C433FE
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Oct 2022 07:31:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C0B7210E602;
	Fri, 21 Oct 2022 07:31:32 +0000 (UTC)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4872810E5C0
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Oct 2022 05:37:00 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 0B01061D9D;
 Fri, 21 Oct 2022 05:37:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD180C433C1;
 Fri, 21 Oct 2022 05:36:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1666330619;
 bh=C4x6hYFDAWi4DXcimrF67aLQPsZW93Mx96V0amCnWn8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=QlbKpgGx1qrMgSdaJyivXXf5qor/X961lpc0yRR+woSzH3tCcgiu1gmz/NBYEXQfe
 K4vsmjcCVpegODndBu2vg9R9eT4zstEkXIb1SfoFeTNCPoQOhnVD+4siGARAhiytQw
 tUVK0o7ipMo473nLX2GyW5d8TYlaC0oYKW+aMHhw=
Date: Fri, 21 Oct 2022 07:37:48 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Luben Tuikov <luben.tuikov@amd.com>
Subject: Re: [PATCH 00/11] fix memory leak while kset_register() fails
Message-ID: <Y1IwLOUGayjT9p6d@kroah.com>
References: <20221021022102.2231464-1-yangyingliang@huawei.com>
 <d559793a-0ce4-3384-e74e-19855aa31f31@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d559793a-0ce4-3384-e74e-19855aa31f31@amd.com>
X-Mailman-Approved-At: Fri, 21 Oct 2022 07:30:36 +0000
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
Cc: rafael@kernel.org, qemu-devel@nongnu.org, liushixin2@huawei.com,
 joseph.qi@linux.alibaba.com, linux-mtd@lists.infradead.org,
 huangjianan@oppo.com, richard@nod.at, mark@fasheh.com, mst@redhat.com,
 amd-gfx@lists.freedesktop.org, Yang Yingliang <yangyingliang@huawei.com>,
 hsiangkao@linux.alibaba.com, somlo@cmu.edu, chao@kernel.org,
 jlbec@evilplan.org, jaegeuk@kernel.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, alexander.deucher@amd.com,
 akpm@linux-foundation.org, linux-erofs@lists.ozlabs.org,
 ocfs2-devel@oss.oracle.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, Oct 21, 2022 at 01:29:31AM -0400, Luben Tuikov wrote:
> On 2022-10-20 22:20, Yang Yingliang wrote:
> > The previous discussion link:
> > https://lore.kernel.org/lkml/0db486eb-6927-927e-3629-958f8f211194@huawei.com/T/
> 
> The very first discussion on this was here:
> 
> https://www.spinics.net/lists/dri-devel/msg368077.html
> 
> Please use this link, and not the that one up there you which quoted above,
> and whose commit description is taken verbatim from the this link.
> 
> > 
> > kset_register() is currently used in some places without calling
> > kset_put() in error path, because the callers think it should be
> > kset internal thing to do, but the driver core can not know what
> > caller doing with that memory at times. The memory could be freed
> > both in kset_put() and error path of caller, if it is called in
> > kset_register().
> 
> As I explained in the link above, the reason there's
> a memory leak is that one cannot call kset_register() without
> the kset->kobj.name being set--kobj_add_internal() returns -EINVAL,
> in this case, i.e. kset_register() fails with -EINVAL.
> 
> Thus, the most common usage is something like this:
> 
> 	kobj_set_name(&kset->kobj, format, ...);
> 	kset->kobj.kset = parent_kset;
> 	kset->kobj.ktype = ktype;
> 	res = kset_register(kset);
> 
> So, what is being leaked, is the memory allocated in kobj_set_name(),
> by the common idiom shown above. This needs to be mentioned in
> the documentation, at least, in case, in the future this is absolved
> in kset_register() redesign, etc.

Based on this, can kset_register() just clean up from itself when an
error happens?  Ideally that would be the case, as the odds of a kset
being embedded in a larger structure is probably slim, but we would have
to search the tree to make sure.

thanks,

greg k-h
