Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47DBFC44533
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Jul 2026 07:22:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 725A510E6CA;
	Tue, 21 Jul 2026 07:22:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="V8f31Zyx";
	dkim-atps=neutral
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com
 [209.85.214.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 789C510E13A
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Jul 2026 19:18:39 +0000 (UTC)
Received: by mail-pl1-f175.google.com with SMTP id
 d9443c01a7336-2cacef7d299so405345ad.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Jul 2026 12:18:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784575119; cv=none;
 d=google.com; s=arc-20260327;
 b=ATx0vo9Nzd/at+BJFEQiT1rw6uOh/k1qGZA1UXx88jOIdhCsgEjbo6EtTLo6Vov0Pw
 BCnxje3TiDW/b4OGECRhQRNATmgmITSrR62iLBTXks/mzs/AILwm6BeZZqbhVdFlRRNr
 4sYyBiGWZwQ0VOT3TFVqzQ3rmuGSIT8CdTqMzhYQKR2Z+v71j9Z+aJDnptrn1CGhWiGM
 ItRXbP9XzQVxpspprLcivorwQX7ThYYbEvPMpvc3iQATc2fL4Xdp2c/h3bSE0rNTacOm
 NrcjMIF8425XArbNUTxye+p9R+zM13fG/se2d1Ea4Mf7Qobc+t/+ybvIJmYOEDrp74Mj
 nqgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=xZApkQlP3tUF+0sIVFilGXDzjCPNwegylhqk3EBxphQ=;
 fh=6i/vPTo5mvONX6sce8GeluPej2SQmcL9ruGS5hA7Qvk=;
 b=mc5kByNRRvOZaMftDE7+dRd4gWL6vUinHVimLEyWP50qP3QlZ+2buxHC2Sxx8Bq0/G
 uZEpbt0aovKgbLoFFFnR7PVwMXKa9BFM+koMXJBJcZW3rXoRpCrlIDbiz3xOeLoScWtK
 3SoqcM4RHDEzabnO6JzjprimXuNohmt/pwaaitbkakMlMu8uo8sbwlHhmJS4znAAinnz
 xkNVZqEto5ffvGbmPMGsEU0ue1eWpLqjDNinq9pRJ/JPokkj5SzcsLVT6y+gPN5mf1VZ
 jUyWVQKWGd8A9A3DlI4ZrKLk04qqNo6HxauZh+qv1MVJgfZ85Hj7m2BJgF0Z/ctQJFhc
 4uow==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1784575119; x=1785179919;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=xZApkQlP3tUF+0sIVFilGXDzjCPNwegylhqk3EBxphQ=;
 b=V8f31ZyxyX3Vb93HQ+KsflhGSQm8jIwr5R0CeR21h3RWrQ5PfNrUXBmmrz/brOtoUP
 SujhxHx7oZJX0H0jqVNQCXjy/JIRfJbiD882wKYYNWTnQtnAYm4fGg7BYtCU7LMO/y3L
 V+azX0I2Tf97eogEodd9FFxWJc7+7WFi/TjJUfhSQBZ//mhV7poSKGIe0GQ0Eab7ey/7
 19J7VG+dZ2a0iBoRqc/5Uyl8Qssh2KEL/mWrJnYjXBURAzXfkOnXaG7eVUeCLp3otM1Z
 OEnt0EGia3iIhfW3RZ8XWSFkYJKjvdK1t6Yg1cgbowU7rLJ8UpAs9KelIMu2mK634J7v
 AbsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784575119; x=1785179919;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=xZApkQlP3tUF+0sIVFilGXDzjCPNwegylhqk3EBxphQ=;
 b=kTsn56Ql+gbgIVxcjLSlePT/nRzmWyHHZXZtXouoNLBkscKq6Ht/ffUQepjrP5wKBV
 OYGK5L9wHUsEJBgunFmOcV4aKZMEc/kt5vyrwfYMiSi3G7ASw5gdc/58A66Dl0bMVjlS
 YtuSXbUjnEczyqxPqstnbHqkXuUYTERJDhkTKupaPnnvuyioPzGOZbBH0Td7/EERGwVz
 H0HB1Y9DZos9wqEv1ZYB7QFPr+k3jxJAIoGAKZow1+G2a+K2J9yiDHesAwh3G+9+Yjy1
 b40jzWCDWBpi/54ulT0jX9zTjVGbNO8rjmXRZlNtHy65T0h9rxXjXGpwUK/BU3BlFdGL
 jH7w==
X-Forwarded-Encrypted: i=1;
 AHgh+RojMjWGcquhzOViBUNwj6QIsXIjpQixXGIJ26MeHNFksnICmahsnLnUaEiP0J/xfyBwy4tBWSQC@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwVpa5IuPn55CLSoc27i1SHV9gT/S5q1sKX5+CR8cKhgbW2Enns
 l94JW4aZXYpsyAcqj1kGDCbvTvTbmX45cBVGijpzkEtsaw54DYnfqZiH2Bksv2RfLs5rp9fuQc4
 7Y9p04F71EW8Plw24xxIwCuizgLsvtF/19n2IgfLodTrY7NwgLpSwNzcu
X-Gm-Gg: AR+sD11QCG4+RAtN4Zhy2itC+YMOYGy8qtxh3asB+gXzdczK4Vqu3ZtapX6/J7ykhRf
 hpDTRDm/lUqnUvd8G9zNSTpyf/jYwpwJ7ghuG+PXEShPnHzPbEhlJOg0FUgASpgeitDH7o6wikq
 KFQ7jU/vp+L1xrGcUhXcwOFkzzHitebtLDRZVKnzQv0q7+M/0osAKm0lEzDtQan9xISfEJYpxbg
 B3+m8vuoTuzXaWWQ3WqCKFqhDamWtSfYFoKASvqVRnc9d4hVF25aHGxT71Bac4B+4+RM9dEGtfj
 0eN8s4T6Es+qPjuQxLF9tWvsVBw=
X-Received: by 2002:a17:902:ec92:b0:2ce:f9e2:4646 with SMTP id
 d9443c01a7336-2cf7b71d50emr2078035ad.27.1784575118135; Mon, 20 Jul 2026
 12:18:38 -0700 (PDT)
MIME-Version: 1.0
References: <20260719175857.4071636-1-ap420073@gmail.com>
In-Reply-To: <20260719175857.4071636-1-ap420073@gmail.com>
From: Mina Almasry <almasrymina@google.com>
Date: Mon, 20 Jul 2026 12:18:25 -0700
X-Gm-Features: AUfX_mytWgNwpYQoEAQtZaZUmAoldCJ_ZYmUTMTxrjD32WIPJUFR9GJy7g5tI1U
Message-ID: <CAHS8izMocev_0TtAsUr9BqCm6sH2DBh-bPK4DfZYNEAb_d2G6w@mail.gmail.com>
Subject: Re: [RFC PATCH net-next 00/13] net: knod: in-kernel network offload
 device
To: Taehee Yoo <ap420073@gmail.com>
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Alexei Starovoitov <ast@kernel.org>, 
 amd-gfx@lists.freedesktop.org, Andrew Lunn <andrew+netdev@lunn.ch>, 
 Andrii Nakryiko <andrii@kernel.org>, Bill Wendling <morbo@google.com>,
 bpf@vger.kernel.org, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Daniel Borkmann <daniel@iogearbox.net>, David Airlie <airlied@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>,
 Donald Hunter <donald.hunter@gmail.com>, 
 dri-devel@lists.freedesktop.org, Eduard Zingerman <eddyz87@gmail.com>, 
 Emil Tsalapatis <emil@etsalapatis.com>, Eric Dumazet <edumazet@google.com>, 
 Felix Kuehling <Felix.Kuehling@amd.com>, Hoyeon Lee <hoyeon.rhee@gmail.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jakub Kicinski <kuba@kernel.org>, 
 Jesper Dangaard Brouer <hawk@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>,
 Justin Stitt <justinstitt@google.com>, 
 Kees Cook <kees@kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Leon Romanovsky <leon@kernel.org>, 
 linaro-mm-sig@lists.linaro.org, linux-hardening@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-media@vger.kernel.org, linux-rdma@vger.kernel.org, llvm@lists.linux.dev, 
 Mark Bloch <mbloch@nvidia.com>, Martin KaFai Lau <martin.lau@linux.dev>, 
 Michael Chan <michael.chan@broadcom.com>, Nathan Chancellor <nathan@kernel.org>,
 netdev@vger.kernel.org, 
 Nick Desaulniers <ndesaulniers@google.com>, Paolo Abeni <pabeni@redhat.com>, 
 Pavan Chebbi <pavan.chebbi@broadcom.com>, Saeed Mahameed <saeedm@nvidia.com>, 
 Shuah Khan <shuah@kernel.org>, Simona Vetter <simona@ffwll.ch>,
 Simon Horman <horms@kernel.org>, 
 Song Liu <song@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, 
 Sumit Semwal <sumit.semwal@linaro.org>, Tariq Toukan <tariqt@nvidia.com>, 
 Yonghong Song <yonghong.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Tue, 21 Jul 2026 07:22:12 +0000
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

On Sun, Jul 19, 2026 at 11:01=E2=80=AFAM Taehee Yoo <ap420073@gmail.com> wr=
ote:
>
> knod (in-kernel network offload device) drives a GPU directly from the
> Linux kernel - with no userspace GPU runtime such as CUDA or ROCm, and
> no userspace component in the data path - to accelerate packet
> processing.
>
> The kernel itself allocates the GPU's queues, JIT-compiles the
> per-packet program to GPU machine code, and dispatches it; the NIC DMAs
> received packets straight into GPU memory and the GPU returns a verdict.
> The GPU is programmed like any other in-kernel offload, not through a
> userspace framework, so existing XDP programs and IPsec SAs can be
> offloaded to it transparently.
>
> The design and motivation were presented at Linux Plumbers Conference
> 2025:
>
>   https://lpc.events/event/19/contributions/2267/
>
> Motivation
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> Line-rate packet processing that does non-trivial per-packet work - an
> XDP program doing L4 load balancing, or IPsec crypto - is bound by the
> host CPU: each core handles one packet at a time, so scaling means
> spending more cores. A GPU is the opposite shape - thousands of lanes
> running the same small program over many packets at once (SIMT) - which
> happens to match the per-packet-program model of XDP.
>
> knod moves that per-packet compute off the host CPU and onto a GPU. The
> NIC DMAs received packets directly into GPU memory, the GPU runs the
> program across a batch of packets in parallel, and only the result
> comes back: a verdict for every packet, plus the packet itself for the
> ones destined to the host. The CPU no longer pays the per-packet
> program cost, and throughput scales with GPU occupancy rather than core
> count.
>
> Crucially this happens entirely inside the kernel. GPU packet processing
> today generally launches work from a userspace GPU runtime (CUDA and
> friends) and keeps that runtime in the data path; knod instead builds
> the GPU queues, compiles the program, and dispatches it from the kernel,
> so it plugs into existing offload paths (XDP, xfrm) with nothing to
> install or keep running in userspace.
>

TBH I found this motivation weak, especially since IIUC you're asking
for almost ~50K lines of code to be merged to the kernel. My thinking
is that (a) it's true that Native XDP takes up CPU cores, but
HW-offload XDP already exists and takes up no CPU. (b) with AI, GPUs
are very expensive and the work they're doing is critical, so you're
unlikely to buy a GPU and use it for knod-offloaded XDP; you'd
probably buy a cheaper smart-NIC? And in the cases where you do have a
GPU, it's likely your system's money-maker, and you probably want to
offload work from the GPU, not to your GPU.

But as far as I can tell there should be much more interesting
applications for what you're doing rather than offloading XDP. Like
wouldn't you with this feature be able to implement ML collectively
like all-to-all/all-reduce/all-gather as purely XDP programs offloaded
to the GPU? If you have that implemented and can positively compare
performance to RoCE or RDMA that would be a much more interesting use
case IMO.

> Model
> =3D=3D=3D=3D=3D
>
> knod binds two endpoints through a third object:
>
>   - a NIC-side netdev, registered by the NIC driver;
>   - an accelerator (the GPU), registered by a provider built into the
>     GPU driver;
>   - an offload device, created on attach, that connects them and owns
>     the per-queue data-path state.
>
> The accelerator ops are feature-agnostic, so different per-packet
> programs plug in behind one interface. This series ships two features
> to show the framework is not tied to a single use case (the accel-type
> uAPI also reserves "dpu" for future non-GPU backends):
>
>   - BPF:   an XDP program attached in offload mode is JIT-compiled from
>            eBPF to an AMD GCN shader and executed on the GPU.
>   - IPsec: RX ESP full-packet decrypt on the GPU (proof of concept,
>            see below).
>
> Data path
> =3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> For a NIC RX queue bound to an accelerator, a received packet flows as
> follows:
>
>   1. Attach reconfigures the NIC's page_pool so its pages come from GPU
>      memory, exported as a dma-buf and plugged in through the devmem
>      memory provider. The NIC therefore DMAs the packet straight into
>      GPU memory - there is no host-side copy on RX.
>
>   2. Instead of building an skb and entering the stack, the NIC's NAPI
>      pushes a small descriptor (memory ref + offset + length) onto a
>      per-queue lock-free SPSC ring shared with the GPU.
>
>   3. A persistent GPU worker drains descriptors and runs the active
>      feature's shader over a batch of packets in parallel - one
>      workgroup per packet - then writes a per-packet verdict back onto
>      the ring: PASS, DROP or TX.
>
>   4. Back on the NIC NAPI, each verdict is applied:
>        - DROP: the GPU page is recycled to the pool;
>        - TX:   the packet is sent back out the NIC directly from GPU
>                memory (XDP_TX), with no host round-trip;
>        - PASS: the packet is copied out of GPU memory into a host
>                delivery page by the GPU's DMA engine (async SDMA),
>                wrapped as an skb, and handed to the normal stack.
>
> So only PASS packets ever touch host memory, and even then the copy is
> done by the GPU, not the CPU.
>
> The control plane is a generic netlink family ("knod") for
> attach/detach, accelerator/NIC inventory, and per-accelerator feature
> selection, with notifications on bind/unbind.
>
> Code layout
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> knod separates into a subsystem-neutral core and a GPU-specific
> provider; nothing in the core knows about GPUs. Roughly:
>
>   - core + control plane + NIC drivers   net/, kernel/bpf/       (~4.4k)
>   - GPU provider (queues, JIT, shaders)  drivers/gpu/drm/amd/    (~39k)
>

Since the changes are so large, I would break this work into many
series, the first which only supports a very minimal set of work
(which I would guess would be XDP_DROP and XDP_TX), and then follow up
with another series which adds XDP_PASS support, and then IPSec, etc.

--=20
Thanks,
Mina
