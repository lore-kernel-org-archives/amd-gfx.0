From: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 2/3] drm: export gem dmabuf_ops for drivers to reuse
Date: Tue, 9 Jan 2018 15:56:26 +0000
Message-ID: <BN6PR12MB1652646849B5874BFB9F209AF7100@BN6PR12MB1652.namprd12.prod.outlook.com>
References: <1515100334-6845-1-git-send-email-Samuel.Li@amd.com>
 <c816da24-7676-8cef-528f-77bfa44af049@gmail.com>
 <20180109092201.GE26573@phenom.ffwll.local>,
 <BLUPR12MB06285B53BBB52C80D9F15780F5100@BLUPR12MB0628.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0589420597=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <BLUPR12MB06285B53BBB52C80D9F15780F5100-7LeqcoF/hwrL9O90+oShTwdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
Content-Language: en-US
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
List-Help: <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=subscribe>
Errors-To: amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Sender: "amd-gfx" <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
To: "Li, Samuel" <Samuel.Li-5C7GfCeVMHo@public.gmane.org>, Daniel Vetter <daniel-/w4YWyX8dFk@public.gmane.org>, "Koenig, Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>
Cc: "dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============0589420597==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BN6PR12MB1652646849B5874BFB9F209AF7100BN6PR12MB1652namp_"

--_000_BN6PR12MB1652646849B5874BFB9F209AF7100BN6PR12MB1652namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

I'll can push this and a few other misc patches today.

Alex
________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of Li, Samu=
el <Samuel.Li-5C7GfCeVMHo@public.gmane.org>
Sent: Tuesday, January 9, 2018 10:20 AM
To: Daniel Vetter; Koenig, Christian
Cc: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org; dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Subject: RE: [PATCH 2/3] drm: export gem dmabuf_ops for drivers to reuse

Yes, please hush this for me.

Regards,
Samuel Li


> -----Original Message-----
> From: Daniel Vetter [mailto:daniel.vetter-/w4YWyX8dFk@public.gmane.org] On Behalf Of Daniel
> Vetter
> Sent: Tuesday, January 09, 2018 4:22 AM
> To: Koenig, Christian <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>
> Cc: Li, Samuel <Samuel.Li-5C7GfCeVMHo@public.gmane.org>; dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org; amd-
> gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> Subject: Re: [PATCH 2/3] drm: export gem dmabuf_ops for drivers to reuse
>
> On Fri, Jan 05, 2018 at 10:16:04AM +0100, Christian K=F6nig wrote:
> > Am 04.01.2018 um 22:12 schrieb Samuel Li:
> > > Change-Id: I03c22a890d2305f3243d88019d1a28bddd4ddda7
> > > Signed-off-by: Samuel Li <Samuel.Li-5C7GfCeVMHo@public.gmane.org>
> >
> > Reviewed-by: Christian K=F6nig <christian.koenig-5C7GfCeVMHo@public.gmane.org>
>
> Want to push to drm-misc or some other plan with this?
> -Daniel
>
> >
> > > ---
> > >   drivers/gpu/drm/drm_prime.c | 53 ++++++++++++++++++++++++++---
> ----------------
> > >   include/drm/drm_prime.h     | 22 +++++++++++++++++++
> > >   2 files changed, 53 insertions(+), 22 deletions(-)
> > >
> > > diff --git a/drivers/gpu/drm/drm_prime.c
> > > b/drivers/gpu/drm/drm_prime.c index 8de93a2..68a69e9 100644
> > > --- a/drivers/gpu/drm/drm_prime.c
> > > +++ b/drivers/gpu/drm/drm_prime.c
> > > @@ -180,9 +180,8 @@ static int drm_prime_lookup_buf_handle(struct
> drm_prime_file_private *prime_fpri
> > >    return -ENOENT;
> > >   }
> > > -static int drm_gem_map_attach(struct dma_buf *dma_buf,
> > > -                       struct device *target_dev,
> > > -                       struct dma_buf_attachment *attach)
> > > +int drm_gem_map_attach(struct dma_buf *dma_buf, struct device
> *target_dev,
> > > +                struct dma_buf_attachment *attach)
> > >   {
> > >    struct drm_prime_attachment *prime_attach;
> > >    struct drm_gem_object *obj =3D dma_buf->priv; @@ -200,9 +199,10
> @@
> > > static int drm_gem_map_attach(struct dma_buf *dma_buf,
> > >    return dev->driver->gem_prime_pin(obj);
> > >   }
> > > +EXPORT_SYMBOL(drm_gem_map_attach);
> > > -static void drm_gem_map_detach(struct dma_buf *dma_buf,
> > > -                        struct dma_buf_attachment *attach)
> > > +void drm_gem_map_detach(struct dma_buf *dma_buf,
> > > +                 struct dma_buf_attachment *attach)
> > >   {
> > >    struct drm_prime_attachment *prime_attach =3D attach->priv;
> > >    struct drm_gem_object *obj =3D dma_buf->priv; @@ -227,6 +227,7
> @@
> > > static void drm_gem_map_detach(struct dma_buf *dma_buf,
> > >    kfree(prime_attach);
> > >    attach->priv =3D NULL;
> > >   }
> > > +EXPORT_SYMBOL(drm_gem_map_detach);
> > >   void drm_prime_remove_buf_handle_locked(struct
> drm_prime_file_private *prime_fpriv,
> > >                                    struct dma_buf *dma_buf)
> > > @@ -253,8 +254,8 @@ void
> drm_prime_remove_buf_handle_locked(struct drm_prime_file_private
> *prime_fpr
> > >    }
> > >   }
> > > -static struct sg_table *drm_gem_map_dma_buf(struct
> dma_buf_attachment *attach,
> > > -                                     enum dma_data_direction dir)
> > > +struct sg_table *drm_gem_map_dma_buf(struct dma_buf_attachment
> *attach,
> > > +                              enum dma_data_direction dir)
> > >   {
> > >    struct drm_prime_attachment *prime_attach =3D attach->priv;
> > >    struct drm_gem_object *obj =3D attach->dmabuf->priv; @@ -289,13
> > > +290,15 @@ static struct sg_table *drm_gem_map_dma_buf(struct
> dma_buf_attachment *attach,
> > >    return sgt;
> > >   }
> > > +EXPORT_SYMBOL(drm_gem_map_dma_buf);
> > > -static void drm_gem_unmap_dma_buf(struct dma_buf_attachment
> *attach,
> > > -                           struct sg_table *sgt,
> > > -                           enum dma_data_direction dir)
> > > +void drm_gem_unmap_dma_buf(struct dma_buf_attachment *attach,
> > > +                    struct sg_table *sgt,
> > > +                    enum dma_data_direction dir)
> > >   {
> > >    /* nothing to be done here */
> > >   }
> > > +EXPORT_SYMBOL(drm_gem_unmap_dma_buf);
> > >   /**
> > >    * drm_gem_dmabuf_export - dma_buf export implementation for
> GEM
> > > @@ -346,47 +349,52 @@ void drm_gem_dmabuf_release(struct
> dma_buf *dma_buf)
> > >   }
> > >   EXPORT_SYMBOL(drm_gem_dmabuf_release);
> > > -static void *drm_gem_dmabuf_vmap(struct dma_buf *dma_buf)
> > > +void *drm_gem_dmabuf_vmap(struct dma_buf *dma_buf)
> > >   {
> > >    struct drm_gem_object *obj =3D dma_buf->priv;
> > >    struct drm_device *dev =3D obj->dev;
> > >    return dev->driver->gem_prime_vmap(obj);
> > >   }
> > > +EXPORT_SYMBOL(drm_gem_dmabuf_vmap);
> > > -static void drm_gem_dmabuf_vunmap(struct dma_buf *dma_buf, void
> > > *vaddr)
> > > +void drm_gem_dmabuf_vunmap(struct dma_buf *dma_buf, void
> *vaddr)
> > >   {
> > >    struct drm_gem_object *obj =3D dma_buf->priv;
> > >    struct drm_device *dev =3D obj->dev;
> > >    dev->driver->gem_prime_vunmap(obj, vaddr);
> > >   }
> > > +EXPORT_SYMBOL(drm_gem_dmabuf_vunmap);
> > > -static void *drm_gem_dmabuf_kmap_atomic(struct dma_buf
> *dma_buf,
> > > -                                 unsigned long page_num)
> > > +void *drm_gem_dmabuf_kmap_atomic(struct dma_buf *dma_buf,
> > > +                          unsigned long page_num)
> > >   {
> > >    return NULL;
> > >   }
> > > +EXPORT_SYMBOL(drm_gem_dmabuf_kmap_atomic);
> > > -static void drm_gem_dmabuf_kunmap_atomic(struct dma_buf
> *dma_buf,
> > > -                                  unsigned long page_num, void *addr=
)
> > > +void drm_gem_dmabuf_kunmap_atomic(struct dma_buf *dma_buf,
> > > +                           unsigned long page_num, void *addr)
> > >   {
> > >   }
> > > -static void *drm_gem_dmabuf_kmap(struct dma_buf *dma_buf,
> > > -                          unsigned long page_num)
> > > +EXPORT_SYMBOL(drm_gem_dmabuf_kunmap_atomic);
> > > +
> > > +void *drm_gem_dmabuf_kmap(struct dma_buf *dma_buf, unsigned
> long
> > > +page_num)
> > >   {
> > >    return NULL;
> > >   }
> > > +EXPORT_SYMBOL(drm_gem_dmabuf_kmap);
> > > -static void drm_gem_dmabuf_kunmap(struct dma_buf *dma_buf,
> > > -                           unsigned long page_num, void *addr)
> > > +void drm_gem_dmabuf_kunmap(struct dma_buf *dma_buf, unsigned
> long page_num,
> > > +                    void *addr)
> > >   {
> > >   }
> > > +EXPORT_SYMBOL(drm_gem_dmabuf_kunmap);
> > > -static int drm_gem_dmabuf_mmap(struct dma_buf *dma_buf,
> > > -                        struct vm_area_struct *vma)
> > > +int drm_gem_dmabuf_mmap(struct dma_buf *dma_buf, struct
> > > +vm_area_struct *vma)
> > >   {
> > >    struct drm_gem_object *obj =3D dma_buf->priv;
> > >    struct drm_device *dev =3D obj->dev; @@ -396,6 +404,7 @@ static in=
t
> > > drm_gem_dmabuf_mmap(struct dma_buf *dma_buf,
> > >    return dev->driver->gem_prime_mmap(obj, vma);
> > >   }
> > > +EXPORT_SYMBOL(drm_gem_dmabuf_mmap);
> > >   static const struct dma_buf_ops drm_gem_prime_dmabuf_ops =3D  {
> > >    .attach =3D drm_gem_map_attach,
> > > diff --git a/include/drm/drm_prime.h b/include/drm/drm_prime.h index
> > > 9cd9e36..4d5f5d6 100644
> > > --- a/include/drm/drm_prime.h
> > > +++ b/include/drm/drm_prime.h
> > > @@ -54,6 +54,9 @@ struct device;
> > >   struct dma_buf_export_info;
> > >   struct dma_buf;
> > > +struct dma_buf_attachment;
> > > +
> > > +enum dma_data_direction;
> > >   struct drm_device;
> > >   struct drm_gem_object;
> > > @@ -79,6 +82,25 @@ int drm_gem_prime_fd_to_handle(struct
> drm_device *dev,
> > >   struct dma_buf *drm_gem_dmabuf_export(struct drm_device *dev,
> > >                                  struct dma_buf_export_info *exp_info=
);
> > >   void drm_gem_dmabuf_release(struct dma_buf *dma_buf);
> > > +int drm_gem_map_attach(struct dma_buf *dma_buf, struct device
> *target_dev,
> > > +                struct dma_buf_attachment *attach); void
> > > +drm_gem_map_detach(struct dma_buf *dma_buf,
> > > +                 struct dma_buf_attachment *attach); struct sg_table
> > > +*drm_gem_map_dma_buf(struct dma_buf_attachment *attach,
> > > +                              enum dma_data_direction dir); void
> > > +drm_gem_unmap_dma_buf(struct dma_buf_attachment *attach,
> > > +                    struct sg_table *sgt,
> > > +                    enum dma_data_direction dir); void
> > > +*drm_gem_dmabuf_vmap(struct dma_buf *dma_buf); void
> > > +drm_gem_dmabuf_vunmap(struct dma_buf *dma_buf, void *vaddr);
> void
> > > +*drm_gem_dmabuf_kmap_atomic(struct dma_buf *dma_buf,
> > > +                          unsigned long page_num);
> > > +void drm_gem_dmabuf_kunmap_atomic(struct dma_buf *dma_buf,
> > > +                           unsigned long page_num, void *addr); void
> > > +*drm_gem_dmabuf_kmap(struct dma_buf *dma_buf, unsigned long
> > > +page_num); void drm_gem_dmabuf_kunmap(struct dma_buf
> *dma_buf, unsigned long page_num,
> > > +                    void *addr);
> > > +int drm_gem_dmabuf_mmap(struct dma_buf *dma_buf, struct
> > > +vm_area_struct *vma);
> > >   int drm_prime_sg_to_page_addr_arrays(struct sg_table *sgt, struct
> page **pages,
> > >                                 dma_addr_t *addrs, int max_pages);
> >
> > _______________________________________________
> > dri-devel mailing list
> > dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> > https://lists.freedesktop.org/mailman/listinfo/dri-devel
>
> --
> Daniel Vetter
> Software Engineer, Intel Corporation
> http://blog.ffwll.ch
_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_BN6PR12MB1652646849B5874BFB9F209AF7100BN6PR12MB1652namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"><!-- P {margin-top:0;margi=
n-bottom:0;} --></style>
</head>
<body dir=3D"ltr">
<div id=3D"divtagdefaultwrapper" style=3D"font-size: 12pt; color: rgb(0, 0,=
 0); font-family: Calibri, Helvetica, sans-serif, &quot;EmojiFont&quot;, &q=
uot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, NotoColorEmoji, &q=
uot;Segoe UI Symbol&quot;, &quot;Android Emoji&quot;, EmojiSymbols;" dir=3D=
"ltr">
<p style=3D"margin-top:0;margin-bottom:0">I'll can push this and a few othe=
r misc patches today.<br>
</p>
<br>
Alex<br>
<div style=3D"color: rgb(0, 0, 0);">
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font style=3D"font-size:11pt" face=
=3D"Calibri, sans-serif" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx=
-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; on behalf of Li, Samuel &lt;Samuel.Li@am=
d.com&gt;<br>
<b>Sent:</b> Tuesday, January 9, 2018 10:20 AM<br>
<b>To:</b> Daniel Vetter; Koenig, Christian<br>
<b>Cc:</b> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org; dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<b=
r>
<b>Subject:</b> RE: [PATCH 2/3] drm: export gem dmabuf_ops for drivers to r=
euse</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Yes, please hush this for me.<br>
<br>
Regards,<br>
Samuel Li<br>
<br>
<br>
&gt; -----Original Message-----<br>
&gt; From: Daniel Vetter [<a href=3D"mailto:daniel.vetter-/w4YWyX8dFk@public.gmane.org">mailto:=
daniel.vetter-/w4YWyX8dFk@public.gmane.org</a>] On Behalf Of Daniel<br>
&gt; Vetter<br>
&gt; Sent: Tuesday, January 09, 2018 4:22 AM<br>
&gt; To: Koenig, Christian &lt;Christian.Koenig-5C7GfCeVMHo@public.gmane.org&gt;<br>
&gt; Cc: Li, Samuel &lt;Samuel.Li-5C7GfCeVMHo@public.gmane.org&gt;; dri-devel-PD4FTy7X32lNgt0PjOBp9/rsn8yoX9R0@public.gmane.org=
org; amd-<br>
&gt; gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
&gt; Subject: Re: [PATCH 2/3] drm: export gem dmabuf_ops for drivers to reu=
se<br>
&gt; <br>
&gt; On Fri, Jan 05, 2018 at 10:16:04AM &#43;0100, Christian K=F6nig wrote:=
<br>
&gt; &gt; Am 04.01.2018 um 22:12 schrieb Samuel Li:<br>
&gt; &gt; &gt; Change-Id: I03c22a890d2305f3243d88019d1a28bddd4ddda7<br>
&gt; &gt; &gt; Signed-off-by: Samuel Li &lt;Samuel.Li-5C7GfCeVMHo@public.gmane.org&gt;<br>
&gt; &gt;<br>
&gt; &gt; Reviewed-by: Christian K=F6nig &lt;christian.koenig-5C7GfCeVMHo@public.gmane.org&gt;<b=
r>
&gt; <br>
&gt; Want to push to drm-misc or some other plan with this?<br>
&gt; -Daniel<br>
&gt; <br>
&gt; &gt;<br>
&gt; &gt; &gt; ---<br>
&gt; &gt; &gt;&nbsp;&nbsp; drivers/gpu/drm/drm_prime.c | 53 &#43;&#43;&#43;=
&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;=
&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;---<br>
&gt; ----------------<br>
&gt; &gt; &gt;&nbsp;&nbsp; include/drm/drm_prime.h&nbsp;&nbsp;&nbsp;&nbsp; =
| 22 &#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;=
&#43;&#43;&#43;&#43;&#43;<br>
&gt; &gt; &gt;&nbsp;&nbsp; 2 files changed, 53 insertions(&#43;), 22 deleti=
ons(-)<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; diff --git a/drivers/gpu/drm/drm_prime.c<br>
&gt; &gt; &gt; b/drivers/gpu/drm/drm_prime.c index 8de93a2..68a69e9 100644<=
br>
&gt; &gt; &gt; --- a/drivers/gpu/drm/drm_prime.c<br>
&gt; &gt; &gt; &#43;&#43;&#43; b/drivers/gpu/drm/drm_prime.c<br>
&gt; &gt; &gt; @@ -180,9 &#43;180,8 @@ static int drm_prime_lookup_buf_hand=
le(struct<br>
&gt; drm_prime_file_private *prime_fpri<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp; return -ENOENT;<br>
&gt; &gt; &gt;&nbsp;&nbsp; }<br>
&gt; &gt; &gt; -static int drm_gem_map_attach(struct dma_buf *dma_buf,<br>
&gt; &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s=
truct device *target_dev,<br>
&gt; &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s=
truct dma_buf_attachment *attach)<br>
&gt; &gt; &gt; &#43;int drm_gem_map_attach(struct dma_buf *dma_buf, struct =
device<br>
&gt; *target_dev,<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dma_buf_attachment *attach)<br>
&gt; &gt; &gt;&nbsp;&nbsp; {<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp; struct drm_prime_attachment *prime_attach;=
<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp; struct drm_gem_object *obj =3D dma_buf-&gt=
;priv; @@ -200,9 &#43;199,10<br>
&gt; @@<br>
&gt; &gt; &gt; static int drm_gem_map_attach(struct dma_buf *dma_buf,<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp; return dev-&gt;driver-&gt;gem_prime_pin(ob=
j);<br>
&gt; &gt; &gt;&nbsp;&nbsp; }<br>
&gt; &gt; &gt; &#43;EXPORT_SYMBOL(drm_gem_map_attach);<br>
&gt; &gt; &gt; -static void drm_gem_map_detach(struct dma_buf *dma_buf,<br>
&gt; &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; struct dma_buf_attachment *attach)<br>
&gt; &gt; &gt; &#43;void drm_gem_map_detach(struct dma_buf *dma_buf,<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dma_buf_attachment *attach=
)<br>
&gt; &gt; &gt;&nbsp;&nbsp; {<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp; struct drm_prime_attachment *prime_attach =
=3D attach-&gt;priv;<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp; struct drm_gem_object *obj =3D dma_buf-&gt=
;priv; @@ -227,6 &#43;227,7<br>
&gt; @@<br>
&gt; &gt; &gt; static void drm_gem_map_detach(struct dma_buf *dma_buf,<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp; kfree(prime_attach);<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp; attach-&gt;priv =3D NULL;<br>
&gt; &gt; &gt;&nbsp;&nbsp; }<br>
&gt; &gt; &gt; &#43;EXPORT_SYMBOL(drm_gem_map_detach);<br>
&gt; &gt; &gt;&nbsp;&nbsp; void drm_prime_remove_buf_handle_locked(struct<b=
r>
&gt; drm_prime_file_private *prime_fpriv,<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
struct dma_buf *dma_buf)<br>
&gt; &gt; &gt; @@ -253,8 &#43;254,8 @@ void<br>
&gt; drm_prime_remove_buf_handle_locked(struct drm_prime_file_private<br>
&gt; *prime_fpr<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp; }<br>
&gt; &gt; &gt;&nbsp;&nbsp; }<br>
&gt; &gt; &gt; -static struct sg_table *drm_gem_map_dma_buf(struct<br>
&gt; dma_buf_attachment *attach,<br>
&gt; &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; enum dma_data_direction dir)<br>
&gt; &gt; &gt; &#43;struct sg_table *drm_gem_map_dma_buf(struct dma_buf_att=
achment<br>
&gt; *attach,<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum dma_data_direction dir)<b=
r>
&gt; &gt; &gt;&nbsp;&nbsp; {<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp; struct drm_prime_attachment *prime_attach =
=3D attach-&gt;priv;<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp; struct drm_gem_object *obj =3D attach-&gt;=
dmabuf-&gt;priv; @@ -289,13<br>
&gt; &gt; &gt; &#43;290,15 @@ static struct sg_table *drm_gem_map_dma_buf(s=
truct<br>
&gt; dma_buf_attachment *attach,<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp; return sgt;<br>
&gt; &gt; &gt;&nbsp;&nbsp; }<br>
&gt; &gt; &gt; &#43;EXPORT_SYMBOL(drm_gem_map_dma_buf);<br>
&gt; &gt; &gt; -static void drm_gem_unmap_dma_buf(struct dma_buf_attachment=
<br>
&gt; *attach,<br>
&gt; &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; struct sg_table *sgt,<br>
&gt; &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; enum dma_data_direction dir)<br>
&gt; &gt; &gt; &#43;void drm_gem_unmap_dma_buf(struct dma_buf_attachment *a=
ttach,<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct sg_table=
 *sgt,<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum dma_data_d=
irection dir)<br>
&gt; &gt; &gt;&nbsp;&nbsp; {<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp; /* nothing to be done here */<br>
&gt; &gt; &gt;&nbsp;&nbsp; }<br>
&gt; &gt; &gt; &#43;EXPORT_SYMBOL(drm_gem_unmap_dma_buf);<br>
&gt; &gt; &gt;&nbsp;&nbsp; /**<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp; * drm_gem_dmabuf_export - dma_buf export i=
mplementation for<br>
&gt; GEM<br>
&gt; &gt; &gt; @@ -346,47 &#43;349,52 @@ void drm_gem_dmabuf_release(struct=
<br>
&gt; dma_buf *dma_buf)<br>
&gt; &gt; &gt;&nbsp;&nbsp; }<br>
&gt; &gt; &gt;&nbsp;&nbsp; EXPORT_SYMBOL(drm_gem_dmabuf_release);<br>
&gt; &gt; &gt; -static void *drm_gem_dmabuf_vmap(struct dma_buf *dma_buf)<b=
r>
&gt; &gt; &gt; &#43;void *drm_gem_dmabuf_vmap(struct dma_buf *dma_buf)<br>
&gt; &gt; &gt;&nbsp;&nbsp; {<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp; struct drm_gem_object *obj =3D dma_buf-&gt=
;priv;<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp; struct drm_device *dev =3D obj-&gt;dev;<br=
>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp; return dev-&gt;driver-&gt;gem_prime_vmap(o=
bj);<br>
&gt; &gt; &gt;&nbsp;&nbsp; }<br>
&gt; &gt; &gt; &#43;EXPORT_SYMBOL(drm_gem_dmabuf_vmap);<br>
&gt; &gt; &gt; -static void drm_gem_dmabuf_vunmap(struct dma_buf *dma_buf, =
void<br>
&gt; &gt; &gt; *vaddr)<br>
&gt; &gt; &gt; &#43;void drm_gem_dmabuf_vunmap(struct dma_buf *dma_buf, voi=
d<br>
&gt; *vaddr)<br>
&gt; &gt; &gt;&nbsp;&nbsp; {<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp; struct drm_gem_object *obj =3D dma_buf-&gt=
;priv;<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp; struct drm_device *dev =3D obj-&gt;dev;<br=
>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp; dev-&gt;driver-&gt;gem_prime_vunmap(obj, v=
addr);<br>
&gt; &gt; &gt;&nbsp;&nbsp; }<br>
&gt; &gt; &gt; &#43;EXPORT_SYMBOL(drm_gem_dmabuf_vunmap);<br>
&gt; &gt; &gt; -static void *drm_gem_dmabuf_kmap_atomic(struct dma_buf<br>
&gt; *dma_buf,<br>
&gt; &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned long pa=
ge_num)<br>
&gt; &gt; &gt; &#43;void *drm_gem_dmabuf_kmap_atomic(struct dma_buf *dma_bu=
f,<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; unsigned long page_num)<br>
&gt; &gt; &gt;&nbsp;&nbsp; {<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp; return NULL;<br>
&gt; &gt; &gt;&nbsp;&nbsp; }<br>
&gt; &gt; &gt; &#43;EXPORT_SYMBOL(drm_gem_dmabuf_kmap_atomic);<br>
&gt; &gt; &gt; -static void drm_gem_dmabuf_kunmap_atomic(struct dma_buf<br>
&gt; *dma_buf,<br>
&gt; &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned l=
ong page_num, void *addr)<br>
&gt; &gt; &gt; &#43;void drm_gem_dmabuf_kunmap_atomic(struct dma_buf *dma_b=
uf,<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; unsigned long page_num, void *addr)<br>
&gt; &gt; &gt;&nbsp;&nbsp; {<br>
&gt; &gt; &gt;&nbsp;&nbsp; }<br>
&gt; &gt; &gt; -static void *drm_gem_dmabuf_kmap(struct dma_buf *dma_buf,<b=
r>
&gt; &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; unsigned long page_num)<br>
&gt; &gt; &gt; &#43;EXPORT_SYMBOL(drm_gem_dmabuf_kunmap_atomic);<br>
&gt; &gt; &gt; &#43;<br>
&gt; &gt; &gt; &#43;void *drm_gem_dmabuf_kmap(struct dma_buf *dma_buf, unsi=
gned<br>
&gt; long<br>
&gt; &gt; &gt; &#43;page_num)<br>
&gt; &gt; &gt;&nbsp;&nbsp; {<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp; return NULL;<br>
&gt; &gt; &gt;&nbsp;&nbsp; }<br>
&gt; &gt; &gt; &#43;EXPORT_SYMBOL(drm_gem_dmabuf_kmap);<br>
&gt; &gt; &gt; -static void drm_gem_dmabuf_kunmap(struct dma_buf *dma_buf,<=
br>
&gt; &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; unsigned long page_num, void *addr)<br>
&gt; &gt; &gt; &#43;void drm_gem_dmabuf_kunmap(struct dma_buf *dma_buf, uns=
igned<br>
&gt; long page_num,<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void *addr)<br>
&gt; &gt; &gt;&nbsp;&nbsp; {<br>
&gt; &gt; &gt;&nbsp;&nbsp; }<br>
&gt; &gt; &gt; &#43;EXPORT_SYMBOL(drm_gem_dmabuf_kunmap);<br>
&gt; &gt; &gt; -static int drm_gem_dmabuf_mmap(struct dma_buf *dma_buf,<br>
&gt; &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; struct vm_area_struct *vma)<br>
&gt; &gt; &gt; &#43;int drm_gem_dmabuf_mmap(struct dma_buf *dma_buf, struct=
<br>
&gt; &gt; &gt; &#43;vm_area_struct *vma)<br>
&gt; &gt; &gt;&nbsp;&nbsp; {<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp; struct drm_gem_object *obj =3D dma_buf-&gt=
;priv;<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp; struct drm_device *dev =3D obj-&gt;dev; @@=
 -396,6 &#43;404,7 @@ static int<br>
&gt; &gt; &gt; drm_gem_dmabuf_mmap(struct dma_buf *dma_buf,<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp; return dev-&gt;driver-&gt;gem_prime_mmap(o=
bj, vma);<br>
&gt; &gt; &gt;&nbsp;&nbsp; }<br>
&gt; &gt; &gt; &#43;EXPORT_SYMBOL(drm_gem_dmabuf_mmap);<br>
&gt; &gt; &gt;&nbsp;&nbsp; static const struct dma_buf_ops drm_gem_prime_dm=
abuf_ops =3D&nbsp; {<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp; .attach =3D drm_gem_map_attach,<br>
&gt; &gt; &gt; diff --git a/include/drm/drm_prime.h b/include/drm/drm_prime=
.h index<br>
&gt; &gt; &gt; 9cd9e36..4d5f5d6 100644<br>
&gt; &gt; &gt; --- a/include/drm/drm_prime.h<br>
&gt; &gt; &gt; &#43;&#43;&#43; b/include/drm/drm_prime.h<br>
&gt; &gt; &gt; @@ -54,6 &#43;54,9 @@ struct device;<br>
&gt; &gt; &gt;&nbsp;&nbsp; struct dma_buf_export_info;<br>
&gt; &gt; &gt;&nbsp;&nbsp; struct dma_buf;<br>
&gt; &gt; &gt; &#43;struct dma_buf_attachment;<br>
&gt; &gt; &gt; &#43;<br>
&gt; &gt; &gt; &#43;enum dma_data_direction;<br>
&gt; &gt; &gt;&nbsp;&nbsp; struct drm_device;<br>
&gt; &gt; &gt;&nbsp;&nbsp; struct drm_gem_object;<br>
&gt; &gt; &gt; @@ -79,6 &#43;82,25 @@ int drm_gem_prime_fd_to_handle(struct=
<br>
&gt; drm_device *dev,<br>
&gt; &gt; &gt;&nbsp;&nbsp; struct dma_buf *drm_gem_dmabuf_export(struct drm=
_device *dev,<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dma_b=
uf_export_info *exp_info);<br>
&gt; &gt; &gt;&nbsp;&nbsp; void drm_gem_dmabuf_release(struct dma_buf *dma_=
buf);<br>
&gt; &gt; &gt; &#43;int drm_gem_map_attach(struct dma_buf *dma_buf, struct =
device<br>
&gt; *target_dev,<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dma_buf_attachment *attach); voi=
d<br>
&gt; &gt; &gt; &#43;drm_gem_map_detach(struct dma_buf *dma_buf,<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dma_buf_attachment *attach=
); struct sg_table<br>
&gt; &gt; &gt; &#43;*drm_gem_map_dma_buf(struct dma_buf_attachment *attach,=
<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum dma_data_direction dir); =
void<br>
&gt; &gt; &gt; &#43;drm_gem_unmap_dma_buf(struct dma_buf_attachment *attach=
,<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct sg_table=
 *sgt,<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum dma_data_d=
irection dir); void<br>
&gt; &gt; &gt; &#43;*drm_gem_dmabuf_vmap(struct dma_buf *dma_buf); void<br>
&gt; &gt; &gt; &#43;drm_gem_dmabuf_vunmap(struct dma_buf *dma_buf, void *va=
ddr);<br>
&gt; void<br>
&gt; &gt; &gt; &#43;*drm_gem_dmabuf_kmap_atomic(struct dma_buf *dma_buf,<br=
>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; unsigned long page_num);<br>
&gt; &gt; &gt; &#43;void drm_gem_dmabuf_kunmap_atomic(struct dma_buf *dma_b=
uf,<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; unsigned long page_num, void *addr); void<br>
&gt; &gt; &gt; &#43;*drm_gem_dmabuf_kmap(struct dma_buf *dma_buf, unsigned =
long<br>
&gt; &gt; &gt; &#43;page_num); void drm_gem_dmabuf_kunmap(struct dma_buf<br=
>
&gt; *dma_buf, unsigned long page_num,<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void *addr);<br=
>
&gt; &gt; &gt; &#43;int drm_gem_dmabuf_mmap(struct dma_buf *dma_buf, struct=
<br>
&gt; &gt; &gt; &#43;vm_area_struct *vma);<br>
&gt; &gt; &gt;&nbsp;&nbsp; int drm_prime_sg_to_page_addr_arrays(struct sg_t=
able *sgt, struct<br>
&gt; page **pages,<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dma_addr_t *addrs,=
 int max_pages);<br>
&gt; &gt;<br>
&gt; &gt; _______________________________________________<br>
&gt; &gt; dri-devel mailing list<br>
&gt; &gt; dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
&gt; &gt; <a href=3D"https://lists.freedesktop.org/mailman/listinfo/dri-dev=
el">https://lists.freedesktop.org/mailman/listinfo/dri-devel</a><br>
&gt; <br>
&gt; --<br>
&gt; Daniel Vetter<br>
&gt; Software Engineer, Intel Corporation<br>
&gt; <a href=3D"http://blog.ffwll.ch">http://blog.ffwll.ch</a><br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://=
lists.freedesktop.org/mailman/listinfo/amd-gfx</a><br>
</div>
</span></font></div>
</div>
</div>
</body>
</html>

--_000_BN6PR12MB1652646849B5874BFB9F209AF7100BN6PR12MB1652namp_--

--===============0589420597==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0589420597==--
