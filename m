Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F2E9EE20AD
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Feb 2026 14:23:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0B7A010E7CF;
	Fri,  6 Feb 2026 14:23:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=ziepe.ca header.i=@ziepe.ca header.b="T82y2l+g";
	dkim-atps=neutral
Received: from mail-qv1-f65.google.com (mail-qv1-f65.google.com
 [209.85.219.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4A8A610E8E5
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Feb 2026 14:21:14 +0000 (UTC)
Received: by mail-qv1-f65.google.com with SMTP id
 6a1803df08f44-88fca7bce90so11618666d6.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 05 Feb 2026 06:21:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ziepe.ca; s=google; t=1770301273; x=1770906073; darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=MSUoQMJoCCNydU2DcwMWqdKRWnt0MqAVvIGN6ESmMGo=;
 b=T82y2l+gvgvflNe+Ykv+sIOMay/sO8Q2rFK8m/HCNE9dJZ/derfurWcpf8hRxRbpT3
 655hJEFUhTmBijclKOd6OJdPCtg1Yf9VzTMvpOb7HeJpH5Dvu5UP8r4zhIJZfs5B0rWG
 Z0WHLO0jQ2NQuqBscSKVlj3VUBrx0JSCZMyiS9hh6bT1oLtHqNctjEDV2xwlMJYRcNNN
 vVJ89ZccVFE6A+GE2+JFWg3LEeeD/kMUQUiF9zT2toKPNnw03RHF30r62sxxS5t0rS1/
 3SlNJIT3G0WqBtk7cca50Y61ey7EHayMa6gLR6/wmUbOE2cV8vqPmM4hQTaHrRIm0gxa
 euEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770301273; x=1770906073;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MSUoQMJoCCNydU2DcwMWqdKRWnt0MqAVvIGN6ESmMGo=;
 b=Pt5bsU4NC3tSGk3bu0fJDAkCpA7s1ca/9jpzYYffcXYKNxCjoiZQuxN/smanIpF+Qo
 2bs5lwt0IqTBUA3cjLqTJQnhERiuBBdICfijTuEPMS0sZKor4PnJwKLAVOC10sv8b8UA
 rEG8BI51ATE0tZfHlXE2Y7ONZg1H0n6tioEhfyF+VD3QxUdHNV/WHdmX29coknLIES55
 T8v6NyengmMUD3UJ1JCY65kA/wKCq3q5w0PQ5WiES/dgZf4SBOgc7sKzOXRMI4b3qwVk
 yUig+058JW9Ykk+fG1z0gyNTQNxGtPDe1ZHbzhSFhbrd22JgIUOjpyF8PVrOrBQmnfTS
 ij7w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUkcIYRhTSphElv5bVS6vWDTx5fa6ILjbuy+7ivWrY9m2WTrVwb4tYd0vlObHpsQCLLRA8mF2zQ@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwTu9kwZe51SHPlgNTUxbxLsBR6H5em9qD0xVNCenop3nuRd7Wo
 LOaSG6BytD3+jFo3WK8wdSE8GAJWiLgKotMduGDcAac9u+I7w07az8Y+IUi/MrxhTbE=
X-Gm-Gg: AZuq6aLu0pE4fcsFYvuov1BlGJFTNEOXfMugfXZJw3bWxk+lW14WDUTHSBQycM+swWG
 pcs86P+oASOlifEr5rH6DDvLAVmQBbg9N9fSKW8nfh+j3kT3RPOKqXUt2rsEoQgH/x5nBT42Db0
 iN5P5+sWZMSkoqd7Lj2MYP+yqHR8XHB4LJ5Uk3T5YntQ6maY+IY+VE86g2nGyYz8IgK1Yp05Hk6
 xhjC8VQ9NC4FPZI3EeN3JZ5IHVOYVRXwMXe+26WQEoMQkptQ/P/pNuHcR82wOxBl4xY0y1QRYe/
 24VDo5jNB2GYAqZyswpbWunkjT3BMfNEPl28XHJbW1IG8Q80L4Me3sxqFBu79W7lrhQjiFz3t8Y
 PPDuvUxCsLKxioUgeuywd2aYwgTqJkGjUQKgvitLNauuRbP3hnCn6x2J983y86VrsyW+mcCBxTn
 HT6jCT7D4iC1PkXO4gkEen7CdbrmcAPwmwtzw7CWauiyVRZ44ayZfyblge4Ps8PdjErRs=
X-Received: by 2002:ad4:5cc6:0:b0:88f:ca72:6ae8 with SMTP id
 6a1803df08f44-89522189787mr84672066d6.45.1770301272999; 
 Thu, 05 Feb 2026 06:21:12 -0800 (PST)
Received: from ziepe.ca
 (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net.
 [142.162.112.119]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-89521bff53esm42252276d6.8.2026.02.05.06.21.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Feb 2026 06:21:12 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
 (envelope-from <jgg@ziepe.ca>) id 1vo0EJ-00000000kPY-3gpa;
 Thu, 05 Feb 2026 10:21:11 -0400
Date: Thu, 5 Feb 2026 10:21:11 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Leon Romanovsky <leon@kernel.org>
Cc: Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 Alex Williamson <alex@shazbot.org>, Simona Vetter <simona@ffwll.ch>,
 Jani Nikula <jani.nikula@intel.com>,
 Lucas De Marchi <lucas.demarchi@intel.com>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 Alex Deucher <alexander.deucher@amd.com>,
 David Airlie <airlied@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Gurchetan Singh <gurchetansingh@chromium.org>,
 Chia-I Wu <olvaffe@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Thomas =?utf-8?Q?Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Kevin Tian <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>, Ankit Agrawal <ankita@nvidia.com>,
 Vivek Kasireddy <vivek.kasireddy@intel.com>,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, virtualization@lists.linux.dev,
 intel-xe@lists.freedesktop.org, linux-rdma@vger.kernel.org,
 iommu@lists.linux.dev, kvm@vger.kernel.org
Subject: Re: [PATCH v7 7/8] vfio: Permit VFIO to work with pinned importers
Message-ID: <20260205142111.GK2328995@ziepe.ca>
References: <20260131-dmabuf-revoke-v7-0-463d956bd527@nvidia.com>
 <20260131-dmabuf-revoke-v7-7-463d956bd527@nvidia.com>
 <fb9bf53a-7962-451a-bac2-c61eb52c7a0f@amd.com>
 <20260204095659.5a983af2@shazbot.org>
 <ac33ad1a-330c-4ab5-bb98-4a4dedccf0da@amd.com>
 <20260205121945.GC12824@unreal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260205121945.GC12824@unreal>
X-Mailman-Approved-At: Fri, 06 Feb 2026 14:22:59 +0000
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

On Thu, Feb 05, 2026 at 02:19:45PM +0200, Leon Romanovsky wrote:
> You don't need any backmerge, SHA-1 version of vfio-v6.19-rc8 tag is the
> same as in Linus's tree, so the flow is:

I'm confused what is the problem here?

From https://anongit.freedesktop.org/git/drm/drm-misc
 * branch                          drm-misc-next -> FETCH_HEAD

$ git show FETCH_HEAD
commit 779ec12c85c9e4547519e3903a371a3b26a289de
Author: Alexander Konyukhov <Alexander.Konyukhov@kaspersky.com>
Date:   Tue Feb 3 16:48:46 2026 +0300

    drm/komeda: fix integer overflow in AFBC framebuffer size check

$ git merge-base  FETCH_HEAD 61ceaf236115f20f4fdd7cf60f883ada1063349a
24d479d26b25bce5faea3ddd9fa8f3a6c3129ea7
$ git describe --contains 24d479d26b25bce5faea3ddd9fa8f3a6c3129ea7
v6.19-rc6^0

$ git log --oneline 61ceaf236115f20f4fdd7cf60f883ada1063349a ^FETCH_HEAD
61ceaf236115f2 vfio: Prevent from pinned DMABUF importers to attach to VFIO DMABUF

Just pull Alex's tree, the drm-misc-next tree already has v6.19-rc6,
so all they will see is one extra patch from Alex in your PR.

No need to backmerge, this is normal git stuff and there won't be
conflicts when they merge a later Linus tag.

Jason
