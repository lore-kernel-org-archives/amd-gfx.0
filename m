Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95A92D2ED0F
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Jan 2026 08:26:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DFD3010E579;
	Tue, 20 Jan 2026 08:25:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=ziepe.ca header.i=@ziepe.ca header.b="iei1T2Go";
	dkim-atps=neutral
Received: from mail-qt1-f194.google.com (mail-qt1-f194.google.com
 [209.85.160.194])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A794110E4CD
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Jan 2026 16:46:21 +0000 (UTC)
Received: by mail-qt1-f194.google.com with SMTP id
 d75a77b69052e-50145cede6eso36392511cf.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Jan 2026 08:46:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ziepe.ca; s=google; t=1768841181; x=1769445981; darn=lists.freedesktop.org; 
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=zfC54g6ZC0VxR+dcM7NfRz1NWoEdvriN2xR6YNn2bfs=;
 b=iei1T2GoIbcWnK9vQUSccpMoJNC1iC6IInjl8ybxCpon0+cgMAD2uewjPZ91zBfPVS
 MvZEZUw3ASKNM3qLnYTGUa6HRTjDbO3pbTClZm4G8P1mmm92+MMKwlP9BsTWMDyQ1wXQ
 SeeIj82rYuG5crjg38E11bYUkMw+ea8s97VH8t8SG4AqFqJ3ebcWdRLodP0DRZNPuUDU
 9hf8x9MnfSLoZ9cQuQl0hAgmk5djLfipbi1Kdm/NV6jTN6CZnn0raxJLLNg1E34ic9My
 NTCJTzIByNzAmfGNgz+BVjLjpAAPGL7hjapVYU8cQTGg1xc+QMxInrAZLfInl0D3hQ1a
 ePMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768841181; x=1769445981;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zfC54g6ZC0VxR+dcM7NfRz1NWoEdvriN2xR6YNn2bfs=;
 b=difXwmUt2VcXUWI6s+D60pKIP9oy6QPt+v4AXv4LcjpYM6EOwNS9KLRhzKepGQqU7b
 4USCw3LdUqkdRHM/CIDxnEf4k08sIXBGU06sqPLnWql41C10C/fQW8P2eCyenEGbMIxO
 WlBIq1tp7PDDvxU7m9/H1xa7UE2NkpkS3h/VP4s+A6pCoaWkpGPysTqA/Mbq2GQp0hvq
 LlNEZg6qry5EUUdY+okRsldgk71bW5GZ3jkuLRzEnVMM3mKknqH+6v9/wRiAV/IcNmxT
 fiV8wosqvzQSkkiIKe5RJgFaOzUtt/ci52uU4LSVKmWOFVu5fzX2lxBjydqD4cvFxbnN
 gxaA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXWsjeUKpMF7gHCtnsvtDdK5XEKmW0qt9CZfW4GDvIBmKHP9brthjhqgj5x3yioWKF4w4Bt722J@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzqYA0RNiCISPJ/vnWgp8b/9NZBNZCoqdpRhX01abmwlUvCGZRX
 8+navveHT/yQkR7PVftFu4uLREoFvLOA5lVxdoqzROIK91k39CQg80sxTOhsO/ikVWo=
X-Gm-Gg: AY/fxX5inTY/0FZA5vw8ANOiPlSanjw5WMqq6RoGGVaasZ3wiYKdMQAAgMPdJjoBLL4
 Q+yHyUyZr+OG52XKb0wK5Uq5QrX6VdYOwEfb8asCzUeW8E/QusKM4CvNcUAFK8tMZ9qE4xpa4EG
 r07VG6S44sONlf8XUNrc74aefG/Y/VY+JJWZVYy9HECWjKIz1vhGZAxMOh7HV0Y6QxjbuGyjp5L
 tZPEAg+mZctthhA0jIcxHW7HbZLin9OxWIdfk1R1a8jtsYS2pEGguxq5R+LncJi1m1F+Ac59u7O
 UoQKIuGHebZ+PumTN8oNHpANxgJ/5h6kkko0Vz1cuQRcK8MUPKFNejOaLszsMWCFu/e3+2AX5nX
 KPFNN3nHatj0b73vtlz24Ay1B3iKUXR9L64PvtVCbsE5SuVyAyvWmuXa2px1fqqBNl2KKToVR/G
 PTpzNkJvaqi8Ok84yR4OCrds90xlhSFwApwxoSE+boNUFLZIc8pU7N9mfpMlooaN5usmU=
X-Received: by 2002:a05:622a:58e:b0:4ee:17e9:999a with SMTP id
 d75a77b69052e-502a1e551b4mr166978451cf.33.1768841180580; 
 Mon, 19 Jan 2026 08:46:20 -0800 (PST)
Received: from ziepe.ca
 (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net.
 [142.162.112.119]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-502a1d9ee19sm71855641cf.14.2026.01.19.08.46.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Jan 2026 08:46:20 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
 (envelope-from <jgg@ziepe.ca>) id 1vhsOR-00000005IML-2VzR;
 Mon, 19 Jan 2026 12:46:19 -0400
Date: Mon, 19 Jan 2026 12:46:19 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Thomas =?utf-8?Q?Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>
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
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Kevin Tian <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Alex Williamson <alex@shazbot.org>, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 virtualization@lists.linux.dev, intel-xe@lists.freedesktop.org,
 linux-rdma@vger.kernel.org, iommu@lists.linux.dev, kvm@vger.kernel.org
Subject: Re: [PATCH v2 2/4] dma-buf: Document revoke semantics
Message-ID: <20260119164619.GG961572@ziepe.ca>
References: <20260118-dmabuf-revoke-v2-0-a03bb27c0875@nvidia.com>
 <20260118-dmabuf-revoke-v2-2-a03bb27c0875@nvidia.com>
 <8bc75706c18c410f9564805c487907aba0aab627.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8bc75706c18c410f9564805c487907aba0aab627.camel@linux.intel.com>
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

On Sun, Jan 18, 2026 at 03:29:02PM +0100, Thomas Hellström wrote:
> Why would the importer want to verify the exporter's support for
> revocation? If the exporter doesn't support it, the only consequence
> would be that invalidate_mappings() would never be called, and that
> dma_buf_pin() is a NOP. Besides, dma_buf_pin() would not return an
> error if the exporter doesn't implement the pin() callback?

I think the comment and commit message should be clarified that 
dma_buf_attachment_is_revoke() is called by the exporter.

The purpose is for the exporter that wants to call move_notify() on a
pinned DMABUF to determine if the importer is going to support it.

Jason
