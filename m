Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B4EDD62606
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Jan 2026 08:36:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5B84510E92A;
	Thu, 22 Jan 2026 08:36:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=ziepe.ca header.i=@ziepe.ca header.b="Fiy3ityz";
	dkim-atps=neutral
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com
 [209.85.222.179])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5B40B10E825
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Jan 2026 15:50:02 +0000 (UTC)
Received: by mail-qk1-f179.google.com with SMTP id
 af79cd13be357-8c5386f1c9fso963074985a.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Jan 2026 07:50:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ziepe.ca; s=google; t=1769010601; x=1769615401; darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=q7hXpke/3/yOS39pnZAAHMgYMjm6i7TC9CfciaL4A2Y=;
 b=Fiy3ityzmtR55ry9UXUn7nibRo4qZNtkI8wxLo41VNQXZNkC8kdUI+PqnGbFfWIGIn
 uwuCT8T7zTzqXlEM4nLk4vevBpjo/6lQjFh3jnU2TZZdEZ+t4MXEcQW8acJPbGLVBjIV
 xhvOL0lPpMp/+lQYI6MHXiy91UCQ8ICwXVV86Rgw0mQuupaomqOyu1QUl5i+42AfiXX1
 JcDhvXA1qxtPTzfNjj3J5lkuk4A7KfrOuSKy2Un1y7OdyAcQBNB4s9XU47SGdzt+X9Fu
 kdXC2mUlat78oppJvtjImYuL6mF4u5GbMtwqZ1plt+XO88rSDEbO0JxO96kbxkfIcmPi
 H+4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769010601; x=1769615401;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=q7hXpke/3/yOS39pnZAAHMgYMjm6i7TC9CfciaL4A2Y=;
 b=ICMyqpycPSrbLqWiRlF63+y3ZZp3saCIZBC7fwZ6dd8ALqHjefOKx7d12fanTQnIF0
 WaBzdhXfkdUmvWDljh7WD1f/tXTnyRmck+G+b6PAxfRJUdZ2ybusb91n6KFYJ3ql77su
 EBCSXr4qmbIY1619Bhca9Y1Cwy6HnTIwuAN8WnNLbOAt7pUroeWnzG2opsc8N03FUNBR
 pOvUDtUwoofe3qqwNiZBCgUKsnSQhRoUfAfKqdPzGPebESUnYZVaFVv9hg3sHF17FNxZ
 /fvWKWlHjVP7gvKao3HJU4gDm+BhSvd1uUWZBiNDfsQM9HAmOQ48E9kq9BYgYJIlry1o
 EEjw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVZR1tu90/571GSDGNyTJcqLoGT0u7k3IJ3VIlPX/3DS8ByOR7JSVoSBzTIREBllglH+1KkewxX@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwEIockFQfcfbUdc0O6yoISodxXYXijPgQwH77vhiZHnDRuJFL4
 9os3cJFMWmcHtUphRJ+bE+u8Wzc/2oyOswUCjX2CUdeS4No2iaQqJQIDQCBlfik8BUc=
X-Gm-Gg: AZuq6aJdi9E71nj4to3srS6cOYAWlKgrk5M5x9FRl6Wl1JrUUhUtY3zOVLBKTkB/vI9
 TLNvzUxjf7ASs4nAcmzWn9ezQolZdTY/KuoJQuL1G15Ir/fIeW3XhLYry6sAcgynAAR6+elnrQi
 H+nlfxayggyfsm58c8AqZZ6wsLeJvEprw6UsLCvX0iWR9WXBZNeRG7FMOO/Bj23UGuxL89svwgG
 HrgC8RFdQu2RCRLSe6N3Mmx9HgbwOAw04RfRr+WSRPEzqlIxQHl8WSTAZZgWPcwZ/KndsUJMHg9
 fDtOlvdzQz4Q+b+ckpMQbBK95w89RFUiJys1TOZuzxtJ9Lxw8ctea9c6zzhYtjJ6GqZQpcTkwBH
 kgYYzHOOJz3S5M/pBCCQtiUoKwBPmGR+E3AlUknV0GTuV5CksShWSqNa1XfmI3DleeIyjQd7ZMw
 e0TKKeXi46K/FMpboHqc57zwKuJEAu0pLIJtdnnHMP0E7zBfKbN4N5S/vTKFfN++tknZHoGx85J
 CPshA==
X-Received: by 2002:a05:620a:298a:b0:8b2:7290:27da with SMTP id
 af79cd13be357-8c6a68ec70emr2561552085a.12.1769010601362; 
 Wed, 21 Jan 2026 07:50:01 -0800 (PST)
Received: from ziepe.ca
 (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net.
 [142.162.112.119]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8942e6a9d97sm127467116d6.34.2026.01.21.07.50.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Jan 2026 07:50:00 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
 (envelope-from <jgg@ziepe.ca>) id 1viaT2-00000006Emy-0KMB;
 Wed, 21 Jan 2026 11:50:00 -0400
Date: Wed, 21 Jan 2026 11:50:00 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Pranjal Shrivastava <praan@google.com>
Cc: Leon Romanovsky <leon@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>,
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
Subject: Re: [PATCH v4 8/8] vfio: Validate dma-buf revocation semantics
Message-ID: <20260121155000.GE961572@ziepe.ca>
References: <20260121-dmabuf-revoke-v4-0-d311cbc8633d@nvidia.com>
 <20260121-dmabuf-revoke-v4-8-d311cbc8633d@nvidia.com>
 <20260121134712.GZ961572@ziepe.ca> <aXDhJ89Yru577jeY@google.com>
 <20260121142528.GC13201@unreal> <aXDnAVzTuCSZHxgF@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aXDnAVzTuCSZHxgF@google.com>
X-Mailman-Approved-At: Thu, 22 Jan 2026 08:36:26 +0000
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

On Wed, Jan 21, 2026 at 02:47:29PM +0000, Pranjal Shrivastava wrote:
> But at the same time, I'd like to discuss if we should think about
> changing the dmabuf core, NULL op == success feels like relying on a bug

Agree, IMHO, it is surprising and counter intuitive in the kernel that
a NULL op means the feature is supported and default to success.

Jason
