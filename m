From: Alex Deucher <alexdeucher@gmail.com>
Subject: Re: [PATCH 05/12] dma-buf: add explicit buffer pinning
Date: Fri, 19 Apr 2019 15:05:09 -0400
Message-ID: <CADnq5_OFh0UDvMkt+yTKBLjysuTmB==Lug-=d04E_eUHPn1ENQ@mail.gmail.com>
References: <20190416183841.1577-1-christian.koenig@amd.com> <20190416183841.1577-6-christian.koenig@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190416183841.1577-6-christian.koenig@amd.com>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
Cc: Sumit Semwal <sumit.semwal@linaro.org>, linux-media <linux-media@vger.kernel.org>, Maling list - DRI developers <dri-devel@lists.freedesktop.org>, "moderated list:DMA BUFFER SHARING FRAMEWORK" <linaro-mm-sig@lists.linaro.org>, LKML <linux-kernel@vger.kernel.org>, amd-gfx list <amd-gfx@lists.freedesktop.org>
List-Id: amd-gfx.lists.freedesktop.org

On Tue, Apr 16, 2019 at 2:39 PM Christian K=C3=B6nig
<ckoenig.leichtzumerken@gmail.com> wrote:
>
> Add optional explicit pinning callbacks instead of implicitly assume the
> exporter pins the buffer when a mapping is created.
>
> Signed-off-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> ---
>  drivers/dma-buf/dma-buf.c | 39 +++++++++++++++++++++++++++++++++++++++
>  include/linux/dma-buf.h   | 37 +++++++++++++++++++++++++++++++------
>  2 files changed, 70 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
> index a3738fab3927..f23ff8355505 100644
> --- a/drivers/dma-buf/dma-buf.c
> +++ b/drivers/dma-buf/dma-buf.c
> @@ -630,6 +630,41 @@ void dma_buf_detach(struct dma_buf *dmabuf, struct d=
ma_buf_attachment *attach)
>  }
>  EXPORT_SYMBOL_GPL(dma_buf_detach);
>
> +/**
> + * dma_buf_pin - Lock down the DMA-buf
> + *
> + * @dmabuf:    [in]    DMA-buf to lock down.
> + *
> + * Returns:
> + * 0 on success, negative error code on failure.
> + */
> +int dma_buf_pin(struct dma_buf *dmabuf)
> +{
> +       int ret =3D 0;
> +
> +       reservation_object_assert_held(dmabuf->resv);
> +
> +       if (dmabuf->ops->pin)
> +               ret =3D dmabuf->ops->pin(dmabuf);
> +
> +       return ret;
> +}
> +EXPORT_SYMBOL_GPL(dma_buf_pin);
> +
> +/**
> + * dma_buf_unpin - Remove lock from DMA-buf
> + *
> + * @dmabuf:    [in]    DMA-buf to unlock.
> + */
> +void dma_buf_unpin(struct dma_buf *dmabuf)
> +{
> +       reservation_object_assert_held(dmabuf->resv);
> +
> +       if (dmabuf->ops->unpin)
> +               dmabuf->ops->unpin(dmabuf);
> +}
> +EXPORT_SYMBOL_GPL(dma_buf_unpin);
> +
>  /**
>   * dma_buf_map_attachment_locked - Maps the buffer into _device_ address=
 space
>   * with the reservation lock held. Is a wrapper for map_dma_buf() of the
> @@ -666,6 +701,8 @@ dma_buf_map_attachment_locked(struct dma_buf_attachme=
nt *attach,
>          */
>         if (attach->invalidate)
>                 list_del(&attach->node);
> +       else
> +               dma_buf_pin(attach->dmabuf);
>         sg_table =3D attach->dmabuf->ops->map_dma_buf(attach, direction);
>         if (attach->invalidate)
>                 list_add(&attach->node, &attach->dmabuf->attachments);
> @@ -735,6 +772,8 @@ void dma_buf_unmap_attachment_locked(struct dma_buf_a=
ttachment *attach,
>
>         attach->dmabuf->ops->unmap_dma_buf(attach, sg_table,
>                                                 direction);
> +       if (!attach->invalidate)
> +               dma_buf_unpin(attach->dmabuf);
>  }
>  EXPORT_SYMBOL_GPL(dma_buf_unmap_attachment_locked);
>
> diff --git a/include/linux/dma-buf.h b/include/linux/dma-buf.h
> index ece4638359a8..a615b74e5894 100644
> --- a/include/linux/dma-buf.h
> +++ b/include/linux/dma-buf.h
> @@ -100,14 +100,40 @@ struct dma_buf_ops {
>          */
>         void (*detach)(struct dma_buf *, struct dma_buf_attachment *);
>
> +       /**
> +        * @pin_dma_buf:
> +        *
> +        * This is called by dma_buf_pin and lets the exporter know that =
an
> +        * importer assumes that the DMA-buf can't be invalidated any mor=
e.
> +        *
> +        * This is called with the dmabuf->resv object locked.
> +        *
> +        * This callback is optional.
> +        *
> +        * Returns:
> +        *
> +        * 0 on success, negative error code on failure.
> +        */
> +       int (*pin)(struct dma_buf *);
> +
> +       /**
> +        * @unpin_dma_buf:
> +        *
> +        * This is called by dma_buf_unpin and lets the exporter know tha=
t an
> +       * importer doesn't need to the DMA-buf to stay were it is any mor=
e.

This should read:
* importer doesn't need the DMA-buf to stay were it is anymore.

> +        *
> +        * This is called with the dmabuf->resv object locked.
> +        *
> +        * This callback is optional.
> +        */
> +       void (*unpin)(struct dma_buf *);
> +
>         /**
>          * @map_dma_buf:
>          *
>          * This is called by dma_buf_map_attachment() and is used to map =
a
>          * shared &dma_buf into device address space, and it is mandatory=
. It
> -        * can only be called if @attach has been called successfully. Th=
is
> -        * essentially pins the DMA buffer into place, and it cannot be m=
oved
> -        * any more
> +        * can only be called if @attach has been called successfully.
>          *
>          * This call may sleep, e.g. when the backing storage first needs=
 to be
>          * allocated, or moved to a location suitable for all currently a=
ttached
> @@ -148,9 +174,6 @@ struct dma_buf_ops {
>          *
>          * This is called by dma_buf_unmap_attachment() and should unmap =
and
>          * release the &sg_table allocated in @map_dma_buf, and it is man=
datory.
> -        * It should also unpin the backing storage if this is the last m=
apping
> -        * of the DMA buffer, it the exporter supports backing storage
> -        * migration.
>          *
>          * This is always called with the dmabuf->resv object locked when
>          * no_sgt_cache is true.
> @@ -442,6 +465,8 @@ int dma_buf_fd(struct dma_buf *dmabuf, int flags);
>  struct dma_buf *dma_buf_get(int fd);
>  void dma_buf_put(struct dma_buf *dmabuf);
>
> +int dma_buf_pin(struct dma_buf *dmabuf);
> +void dma_buf_unpin(struct dma_buf *dmabuf);
>  struct sg_table *dma_buf_map_attachment_locked(struct dma_buf_attachment=
 *,
>                                                enum dma_data_direction);
>  struct sg_table *dma_buf_map_attachment(struct dma_buf_attachment *,
> --
> 2.17.1
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
