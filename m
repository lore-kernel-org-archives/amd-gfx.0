Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B987D2ED19
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Jan 2026 08:26:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A32D110E57C;
	Tue, 20 Jan 2026 08:26:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=ziepe.ca header.i=@ziepe.ca header.b="Z6TPRuYt";
	dkim-atps=neutral
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com
 [209.85.217.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6E66910E4D3
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Jan 2026 17:03:35 +0000 (UTC)
Received: by mail-vs1-f42.google.com with SMTP id
 ada2fe7eead31-5ed0a9cbb3fso2907247137.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Jan 2026 09:03:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ziepe.ca; s=google; t=1768842214; x=1769447014; darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=xPF37M4OZRPT3BtJHYXM5EEOm0b3fHdtNnzMGWb7xcQ=;
 b=Z6TPRuYtomHhTBeFZIgMWviJSMbcBE2fNtKf36Znh1aZLvLYdheJPhf1X2bALW/brH
 27V9tlMlKMazmNkLilW/8IEvUqXwPkdEPd+o6SZoIlpr7gPKB7Q9NTEjZn/fUJoEHnet
 Sl4seCcJpF9sAEo3cx/xrjI3WtMxM1miUfDxgRlj2FaUpqyHwB6wuewGIVxouNd0PEc6
 7KOi/FiA3HqttbUwlqnEorYYzbQJuc7j+eQ8P6jj0fQOU68ygUtUsP5zHitRA8AuXMPm
 QoX/6I5krfzITY01HQ/tSOoQjhFbP6cMcZEO9k2NshkEn7/jQupB/6sOgjKdRBAr5hx3
 JP0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768842214; x=1769447014;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xPF37M4OZRPT3BtJHYXM5EEOm0b3fHdtNnzMGWb7xcQ=;
 b=Spkn4sii1XXkM2Nw+MIHrGpz0MtOhzZ14RH5JUHdDLr9Ec0bIPZlCqH1gtWIMVlhDN
 yQVTnO4qIZKPWpDT41LEIuzOs+gr22FdsVYcR+3ON0emfsdbS+A4GC36uZPzxyXN3W8D
 9bg7DL2FW7QJyJtImbRzUNkSK+6C80RCswDoDhQFo31Ld0ee4p4SRRVnw/SqnfI7ZPmI
 6LN9bftFcGwQRnNDZ2wY2CxsUuS8vW5fA9DD+6KK4ZdDyoSR/0V1nCD5qF0/wOIW3S5A
 a5YDSwsrozftSxk0bX2u6STi5c7xsLmv9Kie/pZoi0ojzNuA3L1Hvt/H/vX+I8N4cl12
 X10Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXmZTOAcUPJQklIRiUUGaP5BxSrDvhVlg62QPV0AiDtNWRWjKWLI5rEv/NzHOhxSm8i7UGHeOay@lists.freedesktop.org
X-Gm-Message-State: AOJu0Ywak+CNz+BQ04KWhvx8IGz/g2Ie6Zjg+MbR0BRY57BcDQ7SqLRp
 ukUP8oFBPfFLlIJZKLmaVHHWG3xx7oKcU3bI4wW3AQHaempVcN2WPjHKTKnDqwpELXI=
X-Gm-Gg: AY/fxX4Jfc2SOqMYe1QeUIVpXzF+3Is+S8N78fGCRHSrfLtKdmzaLIBZvdE+0wNrZTH
 a9YuMyW8zIagShsgQv8fRgFWaYcQ9MPvYHogfEp5yAzIi5yiRPy2vTz2xgXrxULEhELBnZYb4Ot
 AguR0PDQt980xLQh35ItWWTcBerJN+xM8Jxa7jJ82g2LTpBgR/xFb+PvAQT3E/efValIthiZ2ln
 +b3dhtQsSmQ4ztLR7dQOH9g30S3LOn9Q0O86FDhDSfNh4hpJUV5Su/JOpFZeS1EvEZlCvt42KMj
 qk0hsfbKIBqeQiWkuKoAghYiqRk7SwSLRtCK6qHyBIy6aoqKWEOiwxKyr9w3mWdpc4Wpo3cJWzq
 xYkX1fER/P8VCRuGDOhfCqdnK4nlzKyEuSvL22mC2vSz+lcN6NuQ7jUXrjdJ67TgGKUSMS2QuJq
 cnvhVBXAsudOQ57Y6ohBSUzN2deKldG+4mcACs0A70Rt0fgOcnwvkewDESuFUAawMPApU=
X-Received: by 2002:a05:6102:2ac9:b0:5db:d07c:218f with SMTP id
 ada2fe7eead31-5f1a55dacc2mr3505780137.40.1768842212920; 
 Mon, 19 Jan 2026 09:03:32 -0800 (PST)
Received: from ziepe.ca
 (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net.
 [142.162.112.119]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8942e6027c9sm90833946d6.13.2026.01.19.09.03.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Jan 2026 09:03:32 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
 (envelope-from <jgg@ziepe.ca>) id 1vhsf5-00000005ITl-3vB3;
 Mon, 19 Jan 2026 13:03:31 -0400
Date: Mon, 19 Jan 2026 13:03:31 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Leon Romanovsky <leon@kernel.org>
Cc: Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 Alex Deucher <alexander.deucher@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Gurchetan Singh <gurchetansingh@chromium.org>,
 Chia-I Wu <olvaffe@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Lucas De Marchi <lucas.demarchi@intel.com>,
 Thomas =?utf-8?Q?Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Kevin Tian <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Alex Williamson <alex@shazbot.org>, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 virtualization@lists.linux.dev, intel-xe@lists.freedesktop.org,
 linux-rdma@vger.kernel.org, iommu@lists.linux.dev, kvm@vger.kernel.org
Subject: Re: [PATCH v2 4/4] vfio: Add pinned interface to perform revoke
 semantics
Message-ID: <20260119170331.GJ961572@ziepe.ca>
References: <20260118-dmabuf-revoke-v2-0-a03bb27c0875@nvidia.com>
 <20260118-dmabuf-revoke-v2-4-a03bb27c0875@nvidia.com>
 <bd37adf0-afd0-49c4-b608-7f9aa5994f7b@amd.com>
 <20260119130244.GN13201@unreal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260119130244.GN13201@unreal>
X-Mailman-Approved-At: Tue, 20 Jan 2026 08:25:58 +0000
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

On Mon, Jan 19, 2026 at 03:02:44PM +0200, Leon Romanovsky wrote:

> We (VFIO and IOMMUFD) followed the same pattern used in  
> amdgpu_bo_move_notify(), which also does not wait.

You have to be really careful copying anything from the GPU drivers as
they have these waits hidden and batched in other parts of their
operations..

Jason
