Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5498FD0653
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Mar 2026 08:09:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5EEC910E82D;
	Wed, 11 Mar 2026 08:09:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="bhooD2D+";
	dkim-atps=neutral
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com
 [209.85.214.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 709F910E700
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Mar 2026 12:54:08 +0000 (UTC)
Received: by mail-pl1-f178.google.com with SMTP id
 d9443c01a7336-2aeab6ff148so1435ad.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Mar 2026 05:54:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1773147248; x=1773752048;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=mm6hm+LHoMGo5Ew01sq1dP9YSITnoqIDxYFDqmtgvh0=;
 b=bhooD2D+L9M7Bb9jOkredVaupFVK95A3sh2S6yWFIZ05Vc638sgtqAYZ9F8/n0bKfO
 5aNu6qlMna3zywhSUahfFye9TuELYIDxKWwCIZZqHK9176KywLp+1sq9NKWS2UDTwjJt
 STqnSGQIPajj7SFTQLJcuGMbQmm0P0ma9Ip0IZZoc6G3/bVZA5KxujVyyk8tpx7uEODr
 YjkYBX/ZoCW8RQmVUgxWf0ArsgvIK/Tvve8GMvWzsFnXQPs0b0tUU0tXNXaQ2uXBqeL6
 +idSRiH0mLn0WJw/NGsDEoYYt2Kz5XZSQ3WXFwKZNOauCA9F299ZAOgvbXtLCY/QYrmF
 w6yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773147248; x=1773752048;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mm6hm+LHoMGo5Ew01sq1dP9YSITnoqIDxYFDqmtgvh0=;
 b=mDELem3XjiU7i066Bfth8jErP/JE3zqg3KmewM48H+lYFq5ycDDDzdtOKe0RE/Lx6T
 MDFH4bMO1Ev1K1qBNXlDEraek4H3kJQ565TfnSkjRvQoIkXqh4BtfTgWLvUKGEQ1Y/r5
 Akc+RM2zXs/M2RM5chDsddXV+l40eIb+wI6sWrjbYi3k/2J/f4rRAlu2yy9LRIq7hpew
 yS8uM4aaoJXkD3jk3u+5//js6rOSz4FTLlY+iPa28/X0egvKy7yVceiZl4qKpWjeBMV8
 T17me0PCvI/UzzFdS62EPw1xBC7OnDvbhfidzXMvdeGObicN8xvFxGSoD2esvIhWPbGG
 VxRg==
X-Gm-Message-State: AOJu0YyiQzf/gm/mwIofd3gT0WB2/qxLzv+TuHPPaYb1Dd5cuzq5kikv
 FZklRNXsvlo/FTJa8UZBD0cnpYqEfbpIW9y49umWRbct8cY4kCGq0o2uZq03T6xsUg==
X-Gm-Gg: ATEYQzxdJ8nt0T9WbSUscMeomrmhiIKJfd2putTf/6Z4ThVqWKHJtF/LpT86Y6h1cCH
 nlPHO8fpj1JdSZA8roq/mm88Rmk6KXU5KTgTzWJKBKWWCCLevcf7iND242HdOjhzXTlFNBUA2uR
 jV3IgnYaLgRugbBPSl8ElhHX5EPBjw72orqSBs0pGcPtGSaVwMHaOzoqjOApFeV5D6gLItEFUSk
 zq1q7CetI9Y2i+WVjlELAyNSdXBVL7RGsBYF7z8raJfQv+CxQYNn0HeDppKfDQ3lf7NfsLSNndA
 nADbqvVPIpf4UUPStDipRXrICOT7lTfinWtPUsdZoL4r0sZYCEsmZihWGRqMg1PAvUjxHyOSPkg
 d+u/vWbhHjVUZXwEBGS4J8juT+mpDCMa3xEFI5eCfhD3GMBbgBrXanf8/iNUVXJ6OOqeaNAyWAI
 8+9z3GOTd7SqFfMQYkpnhtpNcvbnb4RC8G/WIXMH6XH+KFkC7yIlE1MxD2SQ==
X-Received: by 2002:a17:902:ebd2:b0:2ae:45bb:bc4e with SMTP id
 d9443c01a7336-2aea30ebe48mr3008685ad.24.1773147247400; 
 Tue, 10 Mar 2026 05:54:07 -0700 (PDT)
Received: from google.com (10.129.124.34.bc.googleusercontent.com.
 [34.124.129.10]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c739e0cb73dsm12445679a12.11.2026.03.10.05.53.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Mar 2026 05:54:06 -0700 (PDT)
Date: Tue, 10 Mar 2026 12:53:54 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Philipp Hahn <phahn-oss@avm.de>
Cc: amd-gfx@lists.freedesktop.org, apparmor@lists.ubuntu.com,
 bpf@vger.kernel.org, ceph-devel@vger.kernel.org, cocci@inria.fr,
 dm-devel@lists.linux.dev, dri-devel@lists.freedesktop.org,
 gfs2@lists.linux.dev, intel-gfx@lists.freedesktop.org,
 intel-wired-lan@lists.osuosl.org, iommu@lists.linux.dev,
 kvm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-block@vger.kernel.org, linux-bluetooth@vger.kernel.org,
 linux-btrfs@vger.kernel.org, linux-cifs@vger.kernel.org,
 linux-clk@vger.kernel.org, linux-erofs@lists.ozlabs.org,
 linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-gpio@vger.kernel.org, linux-hyperv@vger.kernel.org,
 linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-leds@vger.kernel.org, linux-media@vger.kernel.org,
 linux-mips@vger.kernel.org, linux-mm@kvack.org,
 linux-modules@vger.kernel.org, linux-mtd@lists.infradead.org,
 linux-nfs@vger.kernel.org, linux-omap@vger.kernel.org,
 linux-phy@lists.infradead.org, linux-pm@vger.kernel.org,
 linux-rockchip@lists.infradead.org, linux-s390@vger.kernel.org,
 linux-scsi@vger.kernel.org, linux-sctp@vger.kernel.org,
 linux-security-module@vger.kernel.org, linux-sh@vger.kernel.org,
 linux-sound@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-trace-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
 ntfs3@lists.linux.dev, samba-technical@lists.samba.org,
 sched-ext@lists.linux.dev, target-devel@vger.kernel.org,
 tipc-discussion@lists.sourceforge.net, v9fs@lists.linux.dev,
 Alex Williamson <alex@shazbot.org>
Subject: Re: [PATCH 46/61] vfio: Prefer IS_ERR_OR_NULL over manual NULL check
Message-ID: <abAUYvx6VEdSmInm@google.com>
References: <20260310-b4-is_err_or_null-v1-0-bd63b656022d@avm.de>
 <20260310-b4-is_err_or_null-v1-46-bd63b656022d@avm.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260310-b4-is_err_or_null-v1-46-bd63b656022d@avm.de>
X-Mailman-Approved-At: Wed, 11 Mar 2026 08:09:27 +0000
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

On Tue, Mar 10, 2026 at 12:49:12PM +0100, Philipp Hahn wrote:
> Prefer using IS_ERR_OR_NULL() over using IS_ERR() and a manual NULL
> check.
> 
> Change generated with coccinelle.
> 
> To: Alex Williamson <alex@shazbot.org>
> Cc: kvm@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Philipp Hahn <phahn-oss@avm.de>
> ---
>  drivers/vfio/vfio_main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/vfio/vfio_main.c b/drivers/vfio/vfio_main.c
> index 742477546b15d4dbaf9ebcfb2e67627db71521e0..d71922dfde5885967398deddec3e9e04b05adfec 100644
> --- a/drivers/vfio/vfio_main.c
> +++ b/drivers/vfio/vfio_main.c
> @@ -923,7 +923,7 @@ vfio_ioctl_device_feature_mig_device_state(struct vfio_device *device,
>  
>  	/* Handle the VFIO_DEVICE_FEATURE_SET */
>  	filp = device->mig_ops->migration_set_state(device, mig.device_state);
> -	if (IS_ERR(filp) || !filp)
> +	if (IS_ERR_OR_NULL(filp))
>  		goto out_copy;
>  
>  	return vfio_ioct_mig_return_fd(filp, arg, &mig);
> 

Reviewed-by: Pranjal Shrivastava <praan@google.com>

The cleanup alone looks fine, but I'm not sure if the maintainers would
be happy about the tree-wide spam, since each patch might go through a
different tree. I'd wait for Alex's preference/ack on that.

Thanks,
Praan
