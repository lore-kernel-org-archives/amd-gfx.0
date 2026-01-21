Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E3EAC4453D
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Jan 2026 13:47:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C358410E7A3;
	Wed, 21 Jan 2026 13:47:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=ziepe.ca header.i=@ziepe.ca header.b="ogVqmj1l";
	dkim-atps=neutral
Received: from mail-qk1-f196.google.com (mail-qk1-f196.google.com
 [209.85.222.196])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 84E4810E1EF
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Jan 2026 13:18:55 +0000 (UTC)
Received: by mail-qk1-f196.google.com with SMTP id
 af79cd13be357-8c538d17816so846594585a.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Jan 2026 05:18:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ziepe.ca; s=google; t=1769001534; x=1769606334; darn=lists.freedesktop.org; 
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=wNQCHIWEBRMpiFqsZYjt880FRkRpyp1yzlc3O4lUKsM=;
 b=ogVqmj1lFq0VLtfSIM84UcyM5lgYt3S8nd+JxAFD1e2wx+WgMk6zjfXLcYmP0Hzpsn
 RBETwhsPdVCqLlBXyxa1EWR6XdVL9toE9d4pp7hw9e9N17SDuq/sEzKGOU8QgYlvnnKn
 hWeXYIYtZ9ssUyumpjOm+dJ/CWkgKbiyfwU1HSbqkZjVOwr6Xf4MhehwEAnv9teyO4ZF
 WYJKQyspAKWeehNezBh8Z3rYcT55g0O9mp8FJntuqodEOx6nZAC2gh2SkrNjfjCSG4Yb
 C6nqZeNG8kbWA4WPrQY9ynLlOtPGU6oUeAxc7EPKrZAmXzkYZT2+BNla5EK0fT7Vl3pU
 CMvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769001534; x=1769606334;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wNQCHIWEBRMpiFqsZYjt880FRkRpyp1yzlc3O4lUKsM=;
 b=pKJaE1rPos+FVnd65reSP+QxHDJfK3MxqVlJ7j42Ds4Lw8wr7adj6+u1AwO8TJDsSz
 /I438IZtLVIjbkMAY0vPOCom6/LIznlpIOM9AR7x6fRnze6An2P9kXS5M+uo081tGlZD
 TdLILKt/dQBjuQAtHdme5EtNTAwrU4+SL+vx0nBu2no2w+wkPNr+TRpZbmyOtG9OAlSs
 E3Be8okV3RSX8JBZti4uUnb6N72DB+LF84yPttnbZUbc5exWysUqaRDYXmhzCY0nVCfg
 soTKZC5fNZAxJeddWsvMseBPCD5m6P/pSb5wpwPYap742z2XMulRcP3BZTM3kTTW0SnS
 YeZw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVuxZMXku6sqMKylP85lW7/qgy7ZslTwdHPo3UhHrd/stk6EV3rmUmD+wyO9hqpHWDmztqluu5t@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzoqanPFwHA5pmr8+dYdevRwYlRq4Rmjtkq1LyLm8lLyZFWTMdb
 vbxpRFJe2vOw9TsH80sNO+DPL7VW73FMd5Fkeb4up59epomE41+1VlYhorWWWorvL2E=
X-Gm-Gg: AZuq6aJUhvJPYlTeeiQCXUyWppXDDZTN5wJoV55adXEq8DG4VEzy4pe7gYGzkGAwAY/
 yPXqhrDq59w0A/Ettts6G6yyCPcKaKPoYLoEBAYvAqx1emOyGMQ1wy7Bl4Tv7wi4rTVKKQEYbtB
 CP54Z8ENi8gGb8goYMWESAJkXUAuWIpHRS+81+D9aCwPy9xalMb0mnPUYAg/3hlXFRx3dbgeVD/
 u+K7yoizWnpVG38MpCBVujLl3o6VJl/dJW0qDJ6Tto4RqFdOI9dZXWCxdIay1rpkD45W8VJniFb
 Y2SLcq/BB7q7+ROGVkqb/7raOOgg5QcVHC/w0yknyrd3QHEZlztd54x8O5hThzDfkb5s7UufyA4
 +JShMHrM2V0WPX2mKdEOq7coEhZUG1yq22ndELmKZny4Kac6AZ/Zc70Hb/Sq6UFGd1y8sxhDZE2
 OLqmQLNgR0zOWSuSsxMYmFeaKGd2/yQbL9q9MDTZhficiP0lGeFc/KT3MaOR5eit2s1kk=
X-Received: by 2002:a05:620a:a819:b0:8c6:aaf3:cb44 with SMTP id
 af79cd13be357-8c6aaf3cd9bmr2247463385a.4.1769001534382; 
 Wed, 21 Jan 2026 05:18:54 -0800 (PST)
Received: from ziepe.ca
 (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net.
 [142.162.112.119]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8c6a71ad820sm1209794385a.10.2026.01.21.05.18.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Jan 2026 05:18:53 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
 (envelope-from <jgg@ziepe.ca>) id 1viY6m-00000006DUF-3lkE;
 Wed, 21 Jan 2026 09:18:52 -0400
Date: Wed, 21 Jan 2026 09:18:52 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>
Cc: Leon Romanovsky <leon@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>,
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
 Felix Kuehling <Felix.Kuehling@amd.com>,
 Alex Williamson <alex@shazbot.org>, Ankit Agrawal <ankita@nvidia.com>,
 Vivek Kasireddy <vivek.kasireddy@intel.com>,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, virtualization@lists.linux.dev,
 intel-xe@lists.freedesktop.org, linux-rdma@vger.kernel.org,
 iommu@lists.linux.dev, kvm@vger.kernel.org
Subject: Re: [PATCH v3 3/7] dma-buf: Document RDMA non-ODP
 invalidate_mapping() special case
Message-ID: <20260121131852.GX961572@ziepe.ca>
References: <20260120-dmabuf-revoke-v3-0-b7e0b07b8214@nvidia.com>
 <20260120-dmabuf-revoke-v3-3-b7e0b07b8214@nvidia.com>
 <4fe42e7e-846c-4aae-8274-3e9a5e7f9a6d@amd.com>
 <20260121091423.GY13201@unreal>
 <7cfe0495-f654-4f9d-8194-fa5717eeafff@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7cfe0495-f654-4f9d-8194-fa5717eeafff@amd.com>
X-Mailman-Approved-At: Wed, 21 Jan 2026 13:47:28 +0000
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

On Wed, Jan 21, 2026 at 10:17:16AM +0100, Christian König wrote:
> The whole idea is to make invalidate_mappings truly optional.

But it's not really optional! It's absence means we are ignoring UAF
security issues when the exporters do their move_notify() and nothing
happens.

Given this I don't want to loose the warning log either, the situation
needs to be reported..

Jason
