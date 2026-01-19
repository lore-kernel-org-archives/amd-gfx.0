Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD2BAD2ED18
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Jan 2026 08:26:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EF75810E585;
	Tue, 20 Jan 2026 08:25:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=ziepe.ca header.i=@ziepe.ca header.b="Jema+que";
	dkim-atps=neutral
Received: from mail-qv1-f67.google.com (mail-qv1-f67.google.com
 [209.85.219.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 00D4110E4D1
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Jan 2026 16:58:45 +0000 (UTC)
Received: by mail-qv1-f67.google.com with SMTP id
 6a1803df08f44-88a2d21427dso33403876d6.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Jan 2026 08:58:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ziepe.ca; s=google; t=1768841925; x=1769446725; darn=lists.freedesktop.org; 
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=ljxKTxaVdu8I0ces4FnKFMKgo+H8JcchtOlXOe2X8IE=;
 b=Jema+queIL0hQwAtJFjPoQTtTKh/xtjTGhoD6njed7GJWMUrzhR5YhlssnJTF/XK7O
 /Kqf8kWiuvM3qijCCiQi+t+km8lLR1/23sLOL2S3FsC3tMOschYF7BJViBdeVSxsK/Ot
 9LKl7P0z65DxYczWufYFxOmYVUpxfAu1tThZdxyYnGuiIkjt/PrYCwIXFmDM8VQ79f9n
 KeXlchhlcqnbyWlWjpLviRLXM30BxaJ9kpuIXl1IVQh6ifwGCM5iDmqXT6BFY25y650q
 LP0U+NdWcqlupLjL/1Es5zwZtgGhSC9INZXGwSQa7UOPL77rsXQ94kMZwW3OGlyZBiz9
 2vcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768841925; x=1769446725;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ljxKTxaVdu8I0ces4FnKFMKgo+H8JcchtOlXOe2X8IE=;
 b=A20vNrcJB6IBjqsaYwTwH+1Do3uvh1VeuPflnUzD/kirBArVHeVQgthcRysO4IVPPg
 s8O2riwCE738e+6lKq7b1SbAmtd3hoyVQcw/w0nUtQvT9RUlOw527vxuViBagSFaXc8g
 pdphNhtmgt7TDRx7XyQKjwwfyHtSf8pJ19eJRQcVHnMWElR8/aKNOmXylTbm2TAZCjdr
 pg6MjDO7bYUqkblYTQph88EYyk0Y/SgqlpStN7jTx9oEz0VN6mI/jTxjDjs8ioLmsH1x
 TMx8nNKuEy/mD/GKDoHIT7cuZkU9eTayV7zA79aZbD83p9nvW9EWn3kNLIk1xy8ZH3o0
 3oPQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU8DU7V8SwKJjNv6xRMWICDWNJV/lXil4zRKcZEg0NBMhIPoTPSi4sYdcTtO6bSmcJsuttE2g48@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz1ogNmfd4JvpuZc/BWS1PN2ZezE4cIbo7RrB3d3wsRWI49AW5x
 WRQkoKRElcA+1RMNpTzjhyNkaU5ba2EJ91tYDoemAan7oqDkoyGLG0DzqpSifb9+LII=
X-Gm-Gg: AZuq6aLV6fwu4BT+cRr770HOzZMEDbbohzUBCpYWoIosiwx+Vr2d3qqF3lGpXPnYYNy
 AwM6BnVHOrO1kwKri8fGilJPjD005hPvmdup7fM6plOp93gjUO8SS7uHwe1xvILtCipdu0ckH51
 KXrvdCWRbV/5msUPE5aVqtJRaioRSVR68HrJ5cE5cUvP0IIjtJIXkQHD4FYppi5Fhc6IcwRlhOu
 DgX28JaS5N4DBseUiilhMbz9NhMnPLdooUqhVln0/eX2/qmpmlGIcnz2VOgQCVb1Vk3X/4NSKIU
 wxxpPNX11Rq4NdfG3QPPnTCpQBw96Ce8bKI5fbLvCb4NZduo+ypV1OEtw6qbqe98PAD/gi0ZSSe
 EkCVG/NAEyrBLnfYat4bsuDQl2APv2a2dlMuTeLz2AogNwMy4Xm7la9lWVNb6/UNZBvawkT2GUf
 15ffzg72uqrRgXOHEbxcgn9OWUzNDP9wxlr+1tIPgnEEMY5lUmoHWkZA6KnRWdZj35D9wE+Lyjc
 9/HJQ==
X-Received: by 2002:a05:6214:2523:b0:88a:2e39:957e with SMTP id
 6a1803df08f44-8942dd9e90fmr129930286d6.57.1768841924690; 
 Mon, 19 Jan 2026 08:58:44 -0800 (PST)
Received: from ziepe.ca
 (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net.
 [142.162.112.119]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8942e5e526dsm87021366d6.12.2026.01.19.08.58.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Jan 2026 08:58:44 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
 (envelope-from <jgg@ziepe.ca>) id 1vhsaR-00000005IQb-2Wqn;
 Mon, 19 Jan 2026 12:58:43 -0400
Date: Mon, 19 Jan 2026 12:58:43 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Leon Romanovsky <leon@kernel.org>
Cc: Sumit Semwal <sumit.semwal@linaro.org>,
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
 Alex Williamson <alex@shazbot.org>, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 virtualization@lists.linux.dev, intel-xe@lists.freedesktop.org,
 linux-rdma@vger.kernel.org, iommu@lists.linux.dev, kvm@vger.kernel.org
Subject: Re: [PATCH v2 0/4] dma-buf: document revoke mechanism to invalidate
 shared buffers
Message-ID: <20260119165843.GH961572@ziepe.ca>
References: <20260118-dmabuf-revoke-v2-0-a03bb27c0875@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260118-dmabuf-revoke-v2-0-a03bb27c0875@nvidia.com>
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

On Sun, Jan 18, 2026 at 02:08:44PM +0200, Leon Romanovsky wrote:
> Changelog:
> v2:
>  * Changed series to document the revoke semantics instead of
>    implementing it.
> v1: https://patch.msgid.link/20260111-dmabuf-revoke-v1-0-fb4bcc8c259b@nvidia.com
> 
> -------------------------------------------------------------------------
> This series documents a dma-buf “revoke” mechanism: to allow a dma-buf
> exporter to explicitly invalidate (“kill”) a shared buffer after it has
> been distributed to importers, so that further CPU and device access is
> prevented and importers reliably observe failure.
> 
> The change in this series is to properly document and use existing core
> “revoked” state on the dma-buf object and a corresponding exporter-triggered
> revoke operation. Once a dma-buf is revoked, new access paths are blocked so
> that attempts to DMA-map, vmap, or mmap the buffer fail in a consistent way.

I think it would help to explain the bigger picture in the cover letter:


DMABUF has quietly allowed calling move_notify on pinned DMABUFs, even
though legacy importers using dma_buf_attach() would simply ignore
these calls.

RDMA saw this and needed to use allow_peer2peer=true, so implemented a
new-style pinned importer with an explicitly non-working move_notify()
callback.

This has been tolerable because the existing exporters are thought to
only call move_notify() on a pinned DMABUF under RAS events and we
have been willing to tolerate the UAF that results by allowing the
importer to continue to use the mapping in this rare case.

VFIO wants to implement a pin supporting exporter that will issue a
revoking move_notify() around FLRs and a few other user triggerable
operations. Since this is much more common we are not willing to
tolerate the security UAF caused by interworking with
non-move_notify() supporting drivers. Thus till now VFIO has required
dynamic importers, even though it never actually moves the buffer
location.

To allow VFIO to work with pinned importers, according to how DMABUF
was intended, we need to allow VFIO to detect if an importer is legacy
or RDMA and does not actually implement move_notify().

Introduce a new function that exporters can call to detect these less
capable importers. VFIO can then refuse to accept them during attach.

In theory all exporters that call move_notify() on pinned DMABUF's
should call this function, however that would break a number of widely
used NIC/GPU flows. Thus for now do not spread this further than VFIO
until we can understand how much of RDMA can implement the full
semantic.

In the process clarify how move_notify is intended to be used with
pinned DMABUFs.

Jason
