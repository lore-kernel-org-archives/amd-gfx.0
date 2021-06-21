Return-Path: <SRS0=3j8t=LP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD0A5C4743C
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Jun 2021 12:29:05 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A50486112D
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Jun 2021 12:29:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A50486112D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E851189FC9;
	Mon, 21 Jun 2021 12:29:01 +0000 (UTC)
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com
 [IPv6:2607:f8b0:4864:20::335])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0A89F89FC5
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Jun 2021 12:28:59 +0000 (UTC)
Received: by mail-ot1-x335.google.com with SMTP id
 v5-20020a0568301bc5b029045c06b14f83so993568ota.13
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Jun 2021 05:28:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ffwll.ch; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=HHQC6lOkJEn8B4ZK4mW/HBR6aX7M4uga90R1ZErZgKw=;
 b=Td38oUyS/9/MPrT4jo5WsEx4w0MWOF/8bM1XyUzvOBwwzScRQorv0t2fw+zHCf7ir0
 h8zpP6oNobDqmDV0rX43vwv23S4wvsx20o1++gTR06+eOXnxOdhaB+3kQbyaZz/2S0tV
 GQVwEXVWhC4IEfs607x4fPCPD20Mejq78fTdQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=HHQC6lOkJEn8B4ZK4mW/HBR6aX7M4uga90R1ZErZgKw=;
 b=GtWUN+RR9WqK0I7uF4IdQrdER/WyJdNLwscqiziEknCPHWtA6YCwhXncZy518cE41J
 4T8u2E9/Umg6MttP/rD3VIdLUrINZnnuB6KGKsl+c8E+eCobDHgUBVERBsQy41iXLkr8
 eejC/6VfwXJTgtmmr3ELEbdFQqh/jVPCuFYE1SCikyHG0pD45vkHUhT/HdMLacvVaCHK
 gCjUQ9F9j7pEIE0XDJ+yk/J8KVHpGBcLMKiHv4UjyAuoWSOFgCRnifiRxi/Eql5s4ft4
 altmyPsS0LwxXIoatVB14T8t05c+JPyPNN5oeBYRTgVNlR71OLeGoyqYRPAl+aN7Yr7/
 Q4Dw==
X-Gm-Message-State: AOAM532OKI0obaLg1Jk/hYP08qtcg5FXJV2BPVVQhtZU1QIDh4z7nGgk
 fecKU/KKWntiNeuJzeBWfO+xPxCXAws4ej6b3/HimA==
X-Google-Smtp-Source: ABdhPJwD0i9Zn4q4SoQulAg+xyZR3j3c5+btpLl6Z1t9xWUhyH1ThXXNgyVXCPxYSRcrINNnl8lEcpNTDGpjBNUKKJE=
X-Received: by 2002:a9d:12eb:: with SMTP id g98mr20269296otg.303.1624278539116; 
 Mon, 21 Jun 2021 05:28:59 -0700 (PDT)
MIME-Version: 1.0
References: <20210618123615.11456-1-ogabbay@kernel.org>
In-Reply-To: <20210618123615.11456-1-ogabbay@kernel.org>
From: Daniel Vetter <daniel.vetter@ffwll.ch>
Date: Mon, 21 Jun 2021 14:28:48 +0200
Message-ID: <CAKMK7uFOfoxbD2Z5mb-qHFnUe5rObGKQ6Ygh--HSH9M=9bziGg@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] habanalabs: define uAPI to export FD for DMA-BUF
To: Oded Gabbay <ogabbay@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, 
 linux-rdma <linux-rdma@vger.kernel.org>, 
 "open list:DMA BUFFER SHARING FRAMEWORK" <linux-media@vger.kernel.org>,
 Doug Ledford <dledford@redhat.com>, 
 "airlied@gmail.com" <airlied@gmail.com>
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
Cc: Greg KH <gregkh@linuxfoundation.org>, sleybo@amazon.com,
 Christoph Hellwig <hch@lst.de>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 dri-devel <dri-devel@lists.freedesktop.org>,
 Gal Pressman <galpress@amazon.com>,
 "moderated list:DMA BUFFER SHARING FRAMEWORK" <linaro-mm-sig@lists.linaro.org>,
 Tomer Tayar <ttayar@habana.ai>, amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Alex Deucher <alexander.deucher@amd.com>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Leon Romanovsky <leonro@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, Jun 18, 2021 at 2:36 PM Oded Gabbay <ogabbay@kernel.org> wrote:
> User process might want to share the device memory with another
> driver/device, and to allow it to access it over PCIe (P2P).
>
> To enable this, we utilize the dma-buf mechanism and add a dma-buf
> exporter support, so the other driver can import the device memory and
> access it.
>
> The device memory is allocated using our existing allocation uAPI,
> where the user will get a handle that represents the allocation.
>
> The user will then need to call the new
> uAPI (HL_MEM_OP_EXPORT_DMABUF_FD) and give the handle as a parameter.
>
> The driver will return a FD that represents the DMA-BUF object that
> was created to match that allocation.
>
> Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
> Reviewed-by: Tomer Tayar <ttayar@habana.ai>

Mission acomplished, we've gone full circle, and the totally-not-a-gpu
driver is now trying to use gpu infrastructure. And seems to have
gained vram meanwhile too. Next up is going to be synchronization
using dma_fence so you can pass buffers back&forth without stalls
among drivers.

Bonus points for this being at v3 before it shows up on dri-devel and
cc's dma-buf folks properly (not quite all, I added the missing
people).

I think we roughly have two options here

a) Greg continues to piss off dri-devel folks while trying to look
cute&cuddly and steadfastly claiming that this accelator doesn't work
like any of the other accelerator drivers we have in drivers/gpu/drm.
All while the driver ever more looks like one of these other accel
drivers.

b) We finally do what we should have done years back and treat this as
a proper driver submission and review it on dri-devel instead of
sneaking it in through other channels because the merge criteria
dri-devel has are too onerous and people who don't have experience
with accel stacks for the past 20 years or so don't like them.

"But this probably means a new driver and big disruption!"

Not my problem, I'm not the dude who has to come up with an excuse for
this because I didn't merge the driver in the first place. I do get to
throw a "we all told you so" in though, but that's not helping.

Also I'm wondering which is the other driver that we share buffers
with. The gaudi stuff doesn't have real struct pages as backing
storage, it only fills out the dma_addr_t. That tends to blow up with
other drivers, and the only place where this is guaranteed to work is
if you have a dynamic importer which sets the allow_peer2peer flag.
Adding maintainers from other subsystems who might want to chime in
here. So even aside of the big question as-is this is broken.

Currently only 2 drivers set allow_peer2peer, so those are the only
ones who can consume these buffers from device memory. Pinging those
folks specifically.

Doug/Jason from infiniband: Should we add linux-rdma to the dma-buf
wildcard match so that you can catch these next time around too? At
least when people use scripts/get_maintainers.pl correctly. All the
other subsystems using dma-buf are on there already (dri-devel,
linux-media and linaro-mm-sig for android/arm embedded stuff).

Cheers, Daniel



> ---
>  include/uapi/misc/habanalabs.h | 28 +++++++++++++++++++++++++++-
>  1 file changed, 27 insertions(+), 1 deletion(-)
>
> diff --git a/include/uapi/misc/habanalabs.h b/include/uapi/misc/habanalabs.h
> index a47a731e4527..aa3d8e0ba060 100644
> --- a/include/uapi/misc/habanalabs.h
> +++ b/include/uapi/misc/habanalabs.h
> @@ -808,6 +808,10 @@ union hl_wait_cs_args {
>  #define HL_MEM_OP_UNMAP                        3
>  /* Opcode to map a hw block */
>  #define HL_MEM_OP_MAP_BLOCK            4
> +/* Opcode to create DMA-BUF object for an existing device memory allocation
> + * and to export an FD of that DMA-BUF back to the caller
> + */
> +#define HL_MEM_OP_EXPORT_DMABUF_FD     5
>
>  /* Memory flags */
>  #define HL_MEM_CONTIGUOUS      0x1
> @@ -878,11 +882,26 @@ struct hl_mem_in {
>                         /* Virtual address returned from HL_MEM_OP_MAP */
>                         __u64 device_virt_addr;
>                 } unmap;
> +
> +               /* HL_MEM_OP_EXPORT_DMABUF_FD */
> +               struct {
> +                       /* Handle returned from HL_MEM_OP_ALLOC. In Gaudi,
> +                        * where we don't have MMU for the device memory, the
> +                        * driver expects a physical address (instead of
> +                        * a handle) in the device memory space.
> +                        */
> +                       __u64 handle;
> +                       /* Size of memory allocation. Relevant only for GAUDI */
> +                       __u64 mem_size;
> +               } export_dmabuf_fd;
>         };
>
>         /* HL_MEM_OP_* */
>         __u32 op;
> -       /* HL_MEM_* flags */
> +       /* HL_MEM_* flags.
> +        * For the HL_MEM_OP_EXPORT_DMABUF_FD opcode, this field holds the
> +        * DMA-BUF file/FD flags.
> +        */
>         __u32 flags;
>         /* Context ID - Currently not in use */
>         __u32 ctx_id;
> @@ -919,6 +938,13 @@ struct hl_mem_out {
>
>                         __u32 pad;
>                 };
> +
> +               /* Returned in HL_MEM_OP_EXPORT_DMABUF_FD. Represents the
> +                * DMA-BUF object that was created to describe a memory
> +                * allocation on the device's memory space. The FD should be
> +                * passed to the importer driver
> +                */
> +               __u64 fd;
>         };
>  };
>
> --
> 2.25.1
>


--
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
