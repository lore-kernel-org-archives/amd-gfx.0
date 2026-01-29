Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34A49D49C85
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Jan 2026 09:22:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6096A10E988;
	Fri, 30 Jan 2026 09:22:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=ziepe.ca header.i=@ziepe.ca header.b="gAAIoJ7q";
	dkim-atps=neutral
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com
 [209.85.222.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D1D3810E87B
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Jan 2026 14:58:53 +0000 (UTC)
Received: by mail-qk1-f178.google.com with SMTP id
 af79cd13be357-8c530866cf0so109493885a.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Jan 2026 06:58:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ziepe.ca; s=google; t=1769698733; x=1770303533; darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=o4w2e3JsR9J6c+UOY9xxx12hv3SNlcI3MEz/ixg8Unk=;
 b=gAAIoJ7qumw1Ks75U1UYitTw5gNmdxYzNwMnEpfwgkyFoFq0cZNuKyY8+rLzAA97CY
 MhdlVSuDcflZJ2huTLdsiYmjp8DSGJFBW/9eRF8pYVw21vknwuLyRAW4BRWk+Nq9Q/+H
 OGJJ/SFTv7Wy7+/RofOAnS55IsOksjKMd8AL7oqFwonCakIhpASUnXDJ+N0gFZyBe6lk
 CEcsP9Iw5QDHvOQl3nrwoPbeCK0eHzpEg3Bflbyt7AXPZF9U+ILyhaXZpwTUFYK7VRiA
 zIgPgnRbdZN1a6iSwBkjCYd6JcE1/FtHUayYJdAi61eozTXWvsAKOXhuBasd9nY4BvWG
 bxOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769698733; x=1770303533;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=o4w2e3JsR9J6c+UOY9xxx12hv3SNlcI3MEz/ixg8Unk=;
 b=JbYb3TgxJRn6dFV6/GoqunYHJE93JHkkQbZtcMmpKnJHJ/t7yv2Bo3Zvh9EISMFbaf
 YxKn2iwQgjwbqcRvBFpknmdnebPhceh4vq27HtK3KvviXpvC7yRjCMvq7SYdU0bRKuH5
 cml+4AeeSJ5mfyBAQOpnentntBDpb2HIWsKVzer6oDkeOeMOK2BO1EzlPds3pcDNj9Nu
 blPOQvgo2ux6JRueOERCIMg28/W05//Enr6i+lwOUUKClUEo3iH1ab9pHl32AuuM7ZtU
 OpubGkzw7kQGckV+hJfJGkQ4DwsuszD+CS+MORUbcXvqC0N5PjCZ2cWp3wBHOXRPI8Ah
 lFPA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVC+bSh30+G3snwQ51t/v6P5E/qdsq2N3gJcuLWLkCJBrIcvFaCTMCtpDcMreWtz6qOmlwBlRW2@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwbdsXDOquljSRD/A8I1gdcDuaSfkV5ESJyR13CFB19oSc/bIAz
 MWGvWrgG9Tkc9+AAKYAcUTmU6lA/yUzV+usAG3BqjFzJSqwg4hZmIcjZRQa8LN0iFbI=
X-Gm-Gg: AZuq6aLT7alax/RLRpOmmtQ97LBcuIReh5Ea4SRS62MvJhIHvo2GCT373UF5pbfzwt4
 /r9gfC4lru9ht5VVEpGcZp/SSKueBxTWvb8vWt9+3j9R1r6XCJgZYaOvTjW35Tc7wuPKWGAnfhs
 w2d15jzjn2KMP/gty2U2lGLyAxdrV0Uakn1yx1L5OYfJklXoehDyHFuUUbomjYAXeexfUbr8yVs
 cyvqh0XWzeCTOnyIpUOTX2lB3F6AZoyCXM7rBERmfBhIIlg66PGccrYgcS9K6JuDAjw5+wVwzSk
 pxUoqmLPpxZnnYzTbqPKttIFtFS8+2qr+C/Vp8uqfUr/PGyTskYTXtwulS8oBXs0uCLe458sUWy
 Ph2IgytyVHh+IHuKIpTlIkOkrKTtLWRFET3gTB3k6b4v57sgcV4Pdk1emtAf5oGE15PvLrMmxHg
 scCuLX19EztBdccc+YuhzLJmSw/ZGWCvbu2SUUEZ2OATs37/Q0uIvJd/kzwASbyofBv6g=
X-Received: by 2002:a05:620a:2550:b0:8c6:d398:4a76 with SMTP id
 af79cd13be357-8c70b833da6mr1225384185a.2.1769698732651; 
 Thu, 29 Jan 2026 06:58:52 -0800 (PST)
Received: from ziepe.ca
 (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net.
 [142.162.112.119]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-894d375c0d8sm38242676d6.43.2026.01.29.06.58.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Jan 2026 06:58:52 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
 (envelope-from <jgg@ziepe.ca>) id 1vlTTv-00000009kfJ-363L;
 Thu, 29 Jan 2026 10:58:51 -0400
Date: Thu, 29 Jan 2026 10:58:51 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: Leon Romanovsky <leon@kernel.org>, Pranjal Shrivastava <praan@google.com>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
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
 "Vivi, Rodrigo" <rodrigo.vivi@intel.com>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>,
 Alex Williamson <alex@shazbot.org>, Ankit Agrawal <ankita@nvidia.com>,
 "Kasireddy, Vivek" <vivek.kasireddy@intel.com>,
 "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "linaro-mm-sig@lists.linaro.org" <linaro-mm-sig@lists.linaro.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
 "intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>,
 "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>
Subject: Re: [PATCH v5 4/8] vfio: Wait for dma-buf invalidation to complete
Message-ID: <20260129145851.GE2307128@ziepe.ca>
References: <20260124-dmabuf-revoke-v5-0-f98fca917e96@nvidia.com>
 <20260124-dmabuf-revoke-v5-4-f98fca917e96@nvidia.com>
 <aXfUZcSEr9N18o6w@google.com> <20260127085835.GQ13967@unreal>
 <20260127162754.GH1641016@ziepe.ca>
 <BN9PR11MB5276B99D4E8C6496B0C447888C9EA@BN9PR11MB5276.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB5276B99D4E8C6496B0C447888C9EA@BN9PR11MB5276.namprd11.prod.outlook.com>
X-Mailman-Approved-At: Fri, 30 Jan 2026 09:22:26 +0000
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

On Thu, Jan 29, 2026 at 07:06:37AM +0000, Tian, Kevin wrote:
> Bear me if it's an ignorant question.
> 
> The commit msg of patch6 says that VFIO doesn't tolerate unbounded
> wait, which is the reason behind the 2nd timeout wait here.

As far as I understand dmabuf design a fence wait should complete
eventually under kernel control, because these sleeps are
sprinkled all around the kernel today.

I suspect that is not actually true for every HW, probably something
like "shader programs can run forever technically".

We can argue if those cases should not report revocable either, but at
least this will work "correctly" even if it takes a huge amount of
time.

I wouldn't mind seeing a shorter timeout and print on the fence too
just in case.

Jason
