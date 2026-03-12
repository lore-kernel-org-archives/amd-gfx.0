Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A93F106FD9F
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Mar 2026 08:55:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B79D610EB3B;
	Fri, 13 Mar 2026 08:55:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=ziepe.ca header.i=@ziepe.ca header.b="Qa46A1Mc";
	dkim-atps=neutral
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com
 [209.85.160.177])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F203D10EA80
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Mar 2026 16:54:51 +0000 (UTC)
Received: by mail-qt1-f177.google.com with SMTP id
 d75a77b69052e-509006c070eso10771451cf.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Mar 2026 09:54:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ziepe.ca; s=google; t=1773334491; x=1773939291; darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=VQXCfPVu6b6dIVECzm0C8AUD7IL7VvpSkD5+M4S95sw=;
 b=Qa46A1McVwmlcasUD4+tK3sCeg3xRVUvmk3CAjnCoDU2/RZpYVx1vU9EUWEizf1BqX
 RgQI42Lc6KP2M/VxYTT1oDg+i1svtu4Hz0LeB7UQ9cZ0DM+mKi6hHM4qceJ1VtBqeSf2
 HU5UIaswuz45g1lXexUrhgosGjl0Z9qkdZ7NPpHMhc51O/jgkCL2Ufb5/LxuKynbNoID
 FjbRyLWHyb9Xe3DZs8KSGTsT+LmJ10RIzTlD61Dmphy2V2tKZ9iTjDkGwHV5WPxKjJKf
 zjuRRS+OUz+P13BkmCKTBoTHJeMgqwDb4XZ4geDWJ0ZJQIEUorRGky4P5uZp5nnjs+c4
 Oe0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773334491; x=1773939291;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VQXCfPVu6b6dIVECzm0C8AUD7IL7VvpSkD5+M4S95sw=;
 b=XIkPpKk62UnuI5Vrglam5qnA/RWq5ouEIXILvrFQCdYqOU+pJ5HVlTm/Fq/LoG9i8Z
 TQfJXqM/H2eAG6yOlGcTblFItRHSrxafXf26OEh8KjikTvsFh/EMf0zKcUW2n5Lh5MUk
 1TVYa/tdkSf4+1pYz5nM+khvJ8M1nc3ZnHcLyigc1W0YRMUHp8cpeDEZwh/kZmfquzKC
 qa8sC/oty1wxnreZuLbB6tQFFTQEIcnYFXOcZRzx3eXcph7H25/DNGtrsU5L0tk6wDB0
 AEEuZeo/j/gXVeXtDd3kp8DiXNS+HikSpXvFcEelwwbeMC1Nbwq4iY5ACs5pwX9zT3Oq
 Edwg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVUAbxBWSyKFXY+CS928OOcBL9DaFBpNbgu/N1STXLjMdQ50fMqUgvWKXkz+hYbkUBchn5Mff1y@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwKKoAUTZoLFNy24MYWILHSMyQOoJUKfs7/5F6IHEbQv4JvRQrX
 V471PQSXRlblcr8is7ryd5H3DpOq5dNflgl04fMJPHQy5qPFCS7P5e3CK1vsMww2t60=
X-Gm-Gg: ATEYQzy39XY3DUSyrfMfzau7n/eO9lR4YDiiXd5GZ8LByPjwV/FK25+axgDBUqa9484
 0a7WKeIh5ABEYIyd605aUGyBmDVYeKdFsGuz5Bg/wOQFpnqXCi6hXcXsdRupvdQ5OEalax/6KLI
 H2WaUw2dZHG0kVo6+dHUs2X3ac9lG2l92yi2v3s2KfuD6OZzJiCwUuQxh4Mbpu8epnELcyivE5X
 WtvrAJUQP2EjGoG+7OXHM2XYJTEnTxXUCjpfqQ0qbRoA98zugw70o3YkNhGZwOx+1Cq625sHIkv
 Vjj6jvbLoI4hZ4c8PVAxx2H7VpJOr9+/XaQoqy+PEGtm7JqcuGU10V+VvV0DEDjP+qLPLf0Bgv/
 NhnsQoudmdpHLUCI3G4D2ATacjvPIgWJ3YmqTjrMd++f8FbcGd29xFZSBL7QTl1XvbV0GM8fQTR
 tgKWSFSkbKU76bx/xkoU/V8CXrAvB2Gd5GCjdEHA8EsT1bm0Fx8pJIBI0370+uIprli14BUS2xC
 sAgu0VP4jO1GZIeSpU=
X-Received: by 2002:a05:622a:289:b0:509:44c3:5ffa with SMTP id
 d75a77b69052e-50957e10673mr1403911cf.52.1773334490530; 
 Thu, 12 Mar 2026 09:54:50 -0700 (PDT)
Received: from ziepe.ca
 (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net.
 [142.162.112.119]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-5093a119602sm36658181cf.28.2026.03.12.09.54.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Mar 2026 09:54:49 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
 (envelope-from <jgg@ziepe.ca>) id 1w0jJA-00000006i8N-40X9;
 Thu, 12 Mar 2026 13:54:48 -0300
Date: Thu, 12 Mar 2026 13:54:48 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: Kuan-Wei Chiu <visitorckw@gmail.com>, Philipp Hahn <phahn-oss@avm.de>,
 amd-gfx@lists.freedesktop.org, apparmor@lists.ubuntu.com,
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
 tipc-discussion@lists.sourceforge.net, v9fs@lists.linux.dev
Subject: Re: [PATCH 00/61] treewide: Use IS_ERR_OR_NULL over manual NULL
 check - refactor
Message-ID: <20260312165448.GN1469476@ziepe.ca>
References: <20260310-b4-is_err_or_null-v1-0-bd63b656022d@avm.de>
 <abBlpGKO842B3yl9@google.com> <20260312125730.GI1469476@ziepe.ca>
 <f5688b895eaebabae6545a0d9baf8f1404e8454e.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f5688b895eaebabae6545a0d9baf8f1404e8454e.camel@HansenPartnership.com>
X-Mailman-Approved-At: Fri, 13 Mar 2026 08:55:39 +0000
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

On Thu, Mar 12, 2026 at 11:32:37AM -0400, James Bottomley wrote:
> On Thu, 2026-03-12 at 09:57 -0300, Jason Gunthorpe wrote:
> > On Wed, Mar 11, 2026 at 02:40:36AM +0800, Kuan-Wei Chiu wrote:
> > 
> > > IMHO, the necessity of IS_ERR_OR_NULL() often highlights a
> > > confusing or flawed API design. It usually implies that the caller
> > > is unsure whether a failure results in an error pointer or a NULL
> > > pointer. 
> > 
> > +1
> > 
> > IS_ERR_OR_NULL() should always be looked on with suspicion. Very
> > little should be returning some tri-state 'ERR' 'NULL' 'SUCCESS'
> > pointer. What does the middle condition even mean? IS_ERR_OR_NULL()
> > implies ERR and NULL are semanticly the same, so fix the things to
> > always use ERR.
> 
> Not in any way supporting the original patch.  However, the pattern
> ERR, NULL, PTR is used extensively in the dentry code of filesystems. 
> See the try_lookup..() set of functions in fs/namei.c
> 
> The meaning is
> 
> PTR - I found it
> NULL - It definitely doesn't exist
> ERR - something went wrong during the lookup.
> 
> So I don't think you can blanket say this pattern is wrong.

Lots of places also would return ENOENT, I'd argue that is easier to
use..

But yes, I did use the word "suspicion" not blanket wrong :)

Jason
