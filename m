Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E39C7C25B5C
	for <amd-gfx@archiver.kernel.org>; Fri,  3 May 2024 13:10:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1F264112A29;
	Fri,  3 May 2024 13:10:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=ziepe.ca header.i=@ziepe.ca header.b="Ra0yfgQK";
	dkim-atps=neutral
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com
 [209.85.161.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A2E8410FC23
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 May 2024 13:04:20 +0000 (UTC)
Received: by mail-oo1-f42.google.com with SMTP id
 006d021491bc7-5ac90ad396dso4893704eaf.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 03 May 2024 06:04:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ziepe.ca; s=google; t=1714741459; x=1715346259; darn=lists.freedesktop.org; 
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=T24fsb6UmCj1BuBe7A8xi01GqDYWjj7XjEjPE3iHXwo=;
 b=Ra0yfgQK4+YOaEkqjoRtMpsyUbrroEWzrCqMpQW1fiWOa2NT1f7YEDipuz3w3HI7E6
 yQN36xVPDbHdDg4qigdL+P3Km416ynfs9SgKB3Fr6yqsmHyMU3TkijZrxfR1sNqlAhWl
 S0dGv+YMKtyR0JjayClKnr7pAe4/0t8A0ThzM46rjC891IMTAhelPeRllFnisUg3unU9
 O0vWG2bEcyrm4z2v9nUFaHTT8p3stAyPXResmf5LUcRRs/3AAVM111OULmPkKFp11Biv
 xlneJSEB9u9oYvnXAe+YqM9nwYDPmhJ8ZIYi64s8g5CSMgtqd5aJaPPIvjnOOYpz70db
 c1cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714741459; x=1715346259;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=T24fsb6UmCj1BuBe7A8xi01GqDYWjj7XjEjPE3iHXwo=;
 b=nEzem9gAB5XrEFhD6tgklJmDoGdkHYFFseAL783WWJSCWmdMf0TSLD4PvVjMtnpnCS
 2zin1YAW3LOMuyMITSS1EZebgxg6X6bCCeyW/KXoWBuT9Swx3nSg4vW1zNVqUpPfQ4Ov
 ZlRtHmvsISrZafA7HY7ZqJH9eZIXQ5yl516nsRoR6ynOucBj0XNPqE+PSjIbQKW3PTEZ
 SXwrQN5AbXxm+I5vpj3diNQKSo4J4Pkg+6GYd5UFR9p0Ew40gYoeyy1qT8S8d6A1E56x
 8dfPMhHn5GogyWoJ12/vdA5KP1IsVWLw5oEoUsHalq4OHph8RuCPSw5sV5c1evmPY3JZ
 Ydcw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUV7zb8pN2GSdYIXoSmy2KHXqE9O1WMANN1L4QLCIptkJPm5E8jUDm5cvF6S1S8PcfUQOpkKNB2F6OwZEFhh40usOQIjvzZjYILw88R6A==
X-Gm-Message-State: AOJu0YwBNVYDZ25NAvZj4HEVYNaAajXu+9ZyywAB+j4aORWft6gk/Rmv
 +R41sv5r3WVGF8zax0Lku7dUcydZfDfN4qIadqXinnVedFS9jb13qs4qLjhFr60=
X-Google-Smtp-Source: AGHT+IFkDVZmGphlJUVtShrOiyFDXAxL2dqwcQGk35D/hs5G0hXFSbZERBs+fJjVjtBARWifNREq9A==
X-Received: by 2002:a4a:4bc6:0:b0:5a9:cef4:fcea with SMTP id
 q189-20020a4a4bc6000000b005a9cef4fceamr2843172ooa.1.1714741459559; 
 Fri, 03 May 2024 06:04:19 -0700 (PDT)
Received: from ziepe.ca ([216.228.117.190]) by smtp.gmail.com with ESMTPSA id
 gr5-20020a0568204cc500b005a4bb400a0fsm620032oob.4.2024.05.03.06.04.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 May 2024 06:04:18 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
 (envelope-from <jgg@ziepe.ca>) id 1s2saG-006Wjv-Qi;
 Fri, 03 May 2024 10:04:16 -0300
Date: Fri, 3 May 2024 10:04:16 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org,
 Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@gmail.com>,
 Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
 dri-devel@lists.freedesktop.org, Leon Romanovsky <leon@kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, linux-rdma@vger.kernel.org,
 "Pan, Xinhui" <Xinhui.Pan@amd.com>,
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 Lukas Wunner <lukas@wunner.de>,
 Dean Luick <dean.luick@cornelisnetworks.com>
Subject: Re: [PATCH 3/3] RDMA/hfi1: Use RMW accessors for changing LNKCTL2
Message-ID: <20240503130416.GA901876@ziepe.ca>
References: <20240215133155.9198-1-ilpo.jarvinen@linux.intel.com>
 <20240215133155.9198-4-ilpo.jarvinen@linux.intel.com>
 <26be3948-e687-f510-0612-abcac5d919af@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <26be3948-e687-f510-0612-abcac5d919af@linux.intel.com>
X-Mailman-Approved-At: Fri, 03 May 2024 13:10:22 +0000
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

On Fri, May 03, 2024 at 01:18:35PM +0300, Ilpo Järvinen wrote:
> On Thu, 15 Feb 2024, Ilpo Järvinen wrote:
> 
> > Convert open coded RMW accesses for LNKCTL2 to use
> > pcie_capability_clear_and_set_word() which makes its easier to
> > understand what the code tries to do.
> > 
> > LNKCTL2 is not really owned by any driver because it is a collection of
> > control bits that PCI core might need to touch. RMW accessors already
> > have support for proper locking for a selected set of registers
> > (LNKCTL2 is not yet among them but likely will be in the future) to
> > avoid losing concurrent updates.
> > 
> > Suggested-by: Lukas Wunner <lukas@wunner.de>
> > Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> > Reviewed-by: Dean Luick <dean.luick@cornelisnetworks.com>
> 
> I found out from Linux RDMA and InfiniBand patchwork that this patch had 
> been silently closed as "Not Applicable". Is there some reason for
> that?

It is part of a series that crosses subsystems, series like that
usually go through some other trees.

If you want single patches applied then please send single
patches.. It is hard to understand intent from mixed series.

Jason
