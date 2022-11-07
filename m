Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15F7EC433FE
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Nov 2022 17:26:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5B23210E512;
	Mon,  7 Nov 2022 17:26:07 +0000 (UTC)
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com
 [IPv6:2607:f8b0:4864:20::12e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 97EC910E4FD
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Nov 2022 17:26:02 +0000 (UTC)
Received: by mail-il1-x12e.google.com with SMTP id m15so6208596ilq.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 07 Nov 2022 09:26:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ffwll.ch; s=google;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=k05Y4e+PrHzSfY5WD7UasfT68aLf+beRaOmVJAx50IE=;
 b=aigTDkQoIrZ5du6qge/d6nU8XEtnOQxQGbL3jhraCwqwWSZTnNbLNTpEqxU68U6tqz
 dT7IR3PAOIU4mgnAoPDn37z3q9yYgeFFX+uYApeVR69MSmpm3kFyqRjh7+MlJpUiBvhf
 qt3+8nXCBsc8ZVaoQNdO/n7ydEFoq3KzLvkRg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=k05Y4e+PrHzSfY5WD7UasfT68aLf+beRaOmVJAx50IE=;
 b=ikwS6PLS6UJswJ5j2+/ensO7SBiHa70ZQlL3FNU4oY4QTjbSgLlvcsb+0huhnGzQtG
 MqglCTbZd8eH8jMaJqoGCBqZzv7WGxP1Wx7ivCGTfesHJBg9mc00250b6+Wc04WkZ/hf
 MwwoQfRA7PzigSg4bhomafYyQOvNRnlcf6fQGGe8xeCV6ifrYxDbTFKW/frnNTiGLMOm
 eyXxL9lcdSyJgHvfWyZjgzdtoyTfzKhkITI1XkOUE6yTkFlBdb/ToADUpawKJCyUmMJ7
 URt9rKsLYPBw64D+G0zjgcDWyZkiYiCZ2YgZm6/Kxu5Z5MLZP14Axx9rpzqVaRdrX4QW
 6W2g==
X-Gm-Message-State: ACrzQf2ll8RpejJYOINn8bjbOCqdGRRw6cLUD+0zR6EbhIgfaf9w/3RI
 wYwhm2lQIZdHE4f+wDDy7uNz6MIgvQke90ZgJp2m/Q==
X-Google-Smtp-Source: AMsMyM7TUXJXcis8PmcF9tz+mPP8pp0mnUv/KZmZclnSef+BAXAmZIP+VqDuAGl+a0+0RYzgd/QOqiORrMVMDd6y2JE=
X-Received: by 2002:a92:d681:0:b0:2ff:573c:8d44 with SMTP id
 p1-20020a92d681000000b002ff573c8d44mr29932067iln.203.1667841961903; Mon, 07
 Nov 2022 09:26:01 -0800 (PST)
MIME-Version: 1.0
References: <20221017172229.42269-1-dmitry.osipenko@collabora.com>
 <20221017172229.42269-19-dmitry.osipenko@collabora.com>
In-Reply-To: <20221017172229.42269-19-dmitry.osipenko@collabora.com>
From: Daniel Vetter <daniel@ffwll.ch>
Date: Mon, 7 Nov 2022 18:25:50 +0100
Message-ID: <CAKMK7uFFwTfNYT2BrubYvUMrH4fEmtF=yJshUck3-gKYLGqxCg@mail.gmail.com>
Subject: Re: [PATCH v7 18/21] dma-buf: Move dma_buf_mmap() to dynamic locking
 specification
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
Cc: David Airlie <airlied@linux.ie>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 dri-devel@lists.freedesktop.org, Gurchetan Singh <gurchetansingh@chromium.org>,
 Ruhl Michael J <michael.j.ruhl@intel.com>,
 Thierry Reding <thierry.reding@gmail.com>,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Dmitry Osipenko <digetx@gmail.com>,
 kernel@collabora.com, Sumit Semwal <sumit.semwal@linaro.org>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Stefano Stabellini <sstabellini@kernel.org>, Leon Romanovsky <leon@kernel.org>,
 Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org,
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas_os@shipmail.org>,
 Russell King <linux@armlinux.org.uk>, Daniel Stone <daniel@fooishbar.org>,
 Gustavo Padovan <gustavo.padovan@collabora.com>,
 virtualization@lists.linux-foundation.org, Chia-I Wu <olvaffe@gmail.com>,
 linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 intel-gfx@lists.freedesktop.org,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, linaro-mm-sig@lists.linaro.org,
 Christian Gmeiner <christian.gmeiner@gmail.com>,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, Juergen Gross <jgross@suse.com>,
 Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
 Daniel Almeida <daniel.almeida@collabora.com>, amd-gfx@lists.freedesktop.org,
 Tomi Valkeinen <tomba@kernel.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>,
 Gert Wollny <gert.wollny@collabora.com>, "Pan, Xinhui" <Xinhui.Pan@amd.com>,
 linux-kernel@vger.kernel.org, Tomasz Figa <tfiga@chromium.org>,
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
 Rob Clark <robdclark@gmail.com>, Qiang Yu <yuq825@gmail.com>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Alex Deucher <alexander.deucher@amd.com>,
 Amol Maheshwari <amahesh@qti.qualcomm.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Lucas Stach <l.stach@pengutronix.de>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, 17 Oct 2022 at 19:25, Dmitry Osipenko
<dmitry.osipenko@collabora.com> wrote:
>
> Move dma_buf_mmap() function to the dynamic locking specification by
> taking the reservation lock. Neither of the today's drivers take the
> reservation lock within the mmap() callback, hence it's safe to enforce
> the locking.
>
> Acked-by: Sumit Semwal <sumit.semwal@linaro.org>
> Acked-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>

Just noticed this while reading code ... this patch seems to have
missed dma_buf_mmap_internal()?

Might be good if at least some drivers gain a dma_resv_assert_held in
that path to make sure we're not quite this bad, together with fixing
this issue.
-Daniel

> ---
>  drivers/dma-buf/dma-buf.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
> index f54c649f922a..f149b384f4dd 100644
> --- a/drivers/dma-buf/dma-buf.c
> +++ b/drivers/dma-buf/dma-buf.c
> @@ -1390,6 +1390,8 @@ EXPORT_SYMBOL_NS_GPL(dma_buf_end_cpu_access, DMA_BU=
F);
>  int dma_buf_mmap(struct dma_buf *dmabuf, struct vm_area_struct *vma,
>                  unsigned long pgoff)
>  {
> +       int ret;
> +
>         if (WARN_ON(!dmabuf || !vma))
>                 return -EINVAL;
>
> @@ -1410,7 +1412,11 @@ int dma_buf_mmap(struct dma_buf *dmabuf, struct vm=
_area_struct *vma,
>         vma_set_file(vma, dmabuf->file);
>         vma->vm_pgoff =3D pgoff;
>
> -       return dmabuf->ops->mmap(dmabuf, vma);
> +       dma_resv_lock(dmabuf->resv, NULL);
> +       ret =3D dmabuf->ops->mmap(dmabuf, vma);
> +       dma_resv_unlock(dmabuf->resv);
> +
> +       return ret;
>  }
>  EXPORT_SYMBOL_NS_GPL(dma_buf_mmap, DMA_BUF);
>
> --
> 2.37.3
>


--=20
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
