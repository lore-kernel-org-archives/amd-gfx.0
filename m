Return-Path: <SRS0=gTHH=EF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B56EC00A89
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Oct 2020 08:35:51 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A349720739
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Oct 2020 08:35:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="wp8/hvRE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A349720739
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 280F96ED0E;
	Fri, 30 Oct 2020 08:35:50 +0000 (UTC)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3D4306E957;
 Fri, 30 Oct 2020 07:10:33 +0000 (UTC)
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 1665120723;
 Fri, 30 Oct 2020 07:10:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1604041832;
 bh=6UZfI9KlukChYkAwmZBY+j32nu5aC1F84wLitkAFcHg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=wp8/hvRE/LfhJJ1P3TNOzq9lgzVnDlBRiSdLAl6MZXbf1TkKDHk95RR2Xjzd6+IUb
 tgKDQcRYbI6wWvk5mHsZThQB/1uDo+V8qIpoGs4X6ScEv9ONzxbN9egoDEZGb29nxz
 T8j3F0UclYetTTGfjJGzHyDJSfrpyLmCI0/UquMY=
Date: Fri, 30 Oct 2020 08:11:20 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Deepak R Varma <mh12gx2825@gmail.com>
Subject: Re: [Outreachy kernel] [PATCH] drm/amdgpu: use
 DEFINE_DEBUGFS_ATTRIBUTE with debugfs_create_file_unsafe()
Message-ID: <20201030071120.GA1493629@kroah.com>
References: <20201030032245.GA274478@my--box>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201030032245.GA274478@my--box>
X-Mailman-Approved-At: Fri, 30 Oct 2020 08:35:49 +0000
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
Cc: David Airlie <airlied@linux.ie>, daniel.vetter@ffwll.ch,
 linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 melissa.srw@gmail.com, outreachy-kernel@googlegroups.com,
 dri-devel@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>,
 Alex Deucher <alexander.deucher@amd.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, Oct 30, 2020 at 08:52:45AM +0530, Deepak R Varma wrote:
> Using DEFINE_DEBUGFS_ATTRIBUTE macro with debugfs_create_file_unsafe()
> function in place of the debugfs_create_file() function will make the
> file operation struct "reset" aware of the file's lifetime. Additional
> details here: https://lists.archive.carbon60.com/linux/kernel/2369498
> 
> Issue reported by Coccinelle script:
> scripts/coccinelle/api/debugfs/debugfs_simple_attr.cocci
> 
> Signed-off-by: Deepak R Varma <mh12gx2825@gmail.com>
> ---
> Please Note: This is a Outreachy project task patch.
> 
>  drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> index 2d125b8b15ee..f076b1ba7319 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> @@ -1551,29 +1551,29 @@ static int amdgpu_debugfs_sclk_set(void *data, u64 val)
>  	return 0;
>  }
>  
> -DEFINE_SIMPLE_ATTRIBUTE(fops_ib_preempt, NULL,
> -			amdgpu_debugfs_ib_preempt, "%llu\n");
> +DEFINE_DEBUGFS_ATTRIBUTE(fops_ib_preempt, NULL,
> +			 amdgpu_debugfs_ib_preempt, "%llu\n");

Are you sure this is ok?  Do these devices need this additional
"protection"?  Do they have the problem that these macros were written
for?

Same for the other patches you just submitted here, I think you need to
somehow "prove" that these changes are necessary, checkpatch isn't able
to determine this all the time.

thanks,

greg k-h
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
