Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2817106FD9A
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Mar 2026 08:55:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 39C2310EB3E;
	Fri, 13 Mar 2026 08:55:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=ziepe.ca header.i=@ziepe.ca header.b="N+o6W8oQ";
	dkim-atps=neutral
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com
 [209.85.160.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DD31310E9E2
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Mar 2026 12:57:32 +0000 (UTC)
Received: by mail-qt1-f176.google.com with SMTP id
 d75a77b69052e-5094b54a250so5475771cf.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Mar 2026 05:57:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ziepe.ca; s=google; t=1773320252; x=1773925052; darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=J1SF1XBHkHR0j7NZVucv0LxpGoGXl67PUefLsfwpAbo=;
 b=N+o6W8oQwaNn75PwxqY2ERViHP198Q2FUgE8iQA7+0gEKBKucnKn5t6Nu9vdLvWdvD
 2jpdcy72+laP9MHp8b/s8fHMXhQOO2SXTjcZe8JuZGRvRLE87p+Yedmf1fkTdLCHWNPW
 kzwcg0h4Qi4aPEJFAVk6+v1RDZlU/+sfZYq6JUaT6zIMrXsfaov9viVgNmSM4DdNmXwB
 LlOFEh6ApB+QTCn1NzAXLINlYA+ssTuTIfK9WJy7f7DfBO5ubXYiZ3BM1TgZlG/vyMbx
 bMnz2mLLAZ4m+He8lKKQpvUrgkMYhGKAiaJUPIku9OHtvzbLeGqrgfkOaIvXnuLt8zyt
 rBQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773320252; x=1773925052;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=J1SF1XBHkHR0j7NZVucv0LxpGoGXl67PUefLsfwpAbo=;
 b=mEnS5cVNoe4BbqylR9Ro7YLNfqoL9/hK53uJtAjWGOTh8NiHQyPBU/Fof8CS0bcAbY
 3nH72oYrKn+hXHwmrgzk+L1FMe/8JQH9N1hgKotKqyYczP7z6aB9jIaBB0OfqomxwhyG
 Zuc2SuzV3BJBTLiY+NAlMR+Tnh7Vt9qBKbA2rwutYemDxbZM1RSEZKG4Ek3NfcZaqExQ
 9Q7fRLCIy39+Bxr+4TVXjmkkgvEOCaAIpezxOqhGULDMmnr+lyUCwhmjFedmoHgRm0Kp
 GShdEMIMa7acy2Ix3IXB2+1+xnYctS7hq8T6d6G9I4pFYkP4bM7E83IbHgsMLI10TaCY
 fcBA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWrO5dKEQLe6hpRBfqK56X6TWHeZDAqFIF5klkHQB8GzI1+8zyau9+Z5MOY9/NmWqRtTHhsvp3q@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxG3xeiNxUo0MsGalaxyiiW8rpjTRstZmMysI32MYYSAcYRznAU
 U8/pZ7aD+dNIRomiCiRAf0N32+/UaOV50fklAib76+6CUgIZxMDI8UJT3MBI7lG4OMA=
X-Gm-Gg: ATEYQzz46Pl0L3dS5UKwd3BD0q+6He1v+31TxZ98SCd37EzbN9WyRYFf7gwUPkArMGp
 MDVfUVFb0ynx8kjGQZtHZgabA+IVeOoA+7ef36nMQGsslPWeQBjsl2SWLtGq0Ez3qTsnzU8YPnx
 ywgOBb1kqMoACCyAmghesrgc/j/0/cLsrlCrlVVQDK/hdhFSRxmIprx0dKv2ZcfrgbNNWa9v/QL
 Bjl1q/0tJhNH7QQhfMYYV36E7Edaww1Be91MybGOlgIPXr6x2JMATSPEg4IsocmZUOpgPPf4A0G
 2vPVQWGldTmqv/znASYs48qpG7ujKeDU1YPagN5Qh51i4hScyLNrvJ0zqWakl4MGNvMvTLASjnO
 WWfom0tWA6G6xm/W8E4PPmDNdSVWn9IrWQ8zFeicZYwfYKc8XXY0RLR4emuVESLLvXMiEf2e0ek
 9kGRXLFW9on72HJmFPnpaUD1Yve80O6SB4hlU5KjLvaQg6zS6gTo7H07ECvM5HSPeYmsGeNZAzx
 ryanS5g
X-Received: by 2002:ac8:5d4d:0:b0:509:cbc:127b with SMTP id
 d75a77b69052e-5093a1bd58fmr77950521cf.60.1773320251710; 
 Thu, 12 Mar 2026 05:57:31 -0700 (PDT)
Received: from ziepe.ca
 (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net.
 [142.162.112.119]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-89a65bd318fsm33341196d6.8.2026.03.12.05.57.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Mar 2026 05:57:31 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
 (envelope-from <jgg@ziepe.ca>) id 1w0fbW-00000006fKD-1POa;
 Thu, 12 Mar 2026 09:57:30 -0300
Date: Thu, 12 Mar 2026 09:57:30 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Kuan-Wei Chiu <visitorckw@gmail.com>
Cc: Philipp Hahn <phahn-oss@avm.de>, amd-gfx@lists.freedesktop.org,
 apparmor@lists.ubuntu.com, bpf@vger.kernel.org,
 ceph-devel@vger.kernel.org, cocci@inria.fr,
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
Message-ID: <20260312125730.GI1469476@ziepe.ca>
References: <20260310-b4-is_err_or_null-v1-0-bd63b656022d@avm.de>
 <abBlpGKO842B3yl9@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <abBlpGKO842B3yl9@google.com>
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

On Wed, Mar 11, 2026 at 02:40:36AM +0800, Kuan-Wei Chiu wrote:

> IMHO, the necessity of IS_ERR_OR_NULL() often highlights a confusing or
> flawed API design. It usually implies that the caller is unsure whether
> a failure results in an error pointer or a NULL pointer. 

+1

IS_ERR_OR_NULL() should always be looked on with suspicion. Very
little should be returning some tri-state 'ERR' 'NULL' 'SUCCESS'
pointer. What does the middle condition even mean? IS_ERR_OR_NULL()
implies ERR and NULL are semanticly the same, so fix the things to
always use ERR.

If you want to improve things work to get rid of the NULL checks this
script identifies. Remove ERR or NULL because only one can ever
happen, or fix the source to consistently return ERR.

Jason
