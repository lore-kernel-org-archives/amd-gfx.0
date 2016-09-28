From: Mike Lothian <mike-4+n8WJKc9ve9FHfhHBbuYA@public.gmane.org>
Subject: Re: [PATCH xf86-video-amdgpu] Add support for
 ScreenPtr::SyncSharedPixmap
Date: Wed, 28 Sep 2016 08:42:39 +0000
Message-ID: <CAHbf0-GuUZPCGHzQrooOi4cTmRSJMQGrph4oD9E7+4DtW=z0Aw@mail.gmail.com>
References: <20160928080018.17364-1-michel@daenzer.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1479052211=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20160928080018.17364-1-michel-otUistvHUpPR7s880joybQ@public.gmane.org>
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
To: =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

--===============1479052211==
Content-Type: multipart/alternative; boundary=001a114b2f669ed8e9053d8d5832

--001a114b2f669ed8e9053d8d5832
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Am I right in guessing this is only required for DRI2?

On Wed, 28 Sep 2016 at 09:00 Michel D=C3=A4nzer <michel-otUistvHUpPR7s880joybQ@public.gmane.org> wrote:

> From: Michel D=C3=A4nzer <michel.daenzer-5C7GfCeVMHo@public.gmane.org>
>
> This allows deferring shared pixmap updates between different drivers.
>
> (Ported from radeon commit 53be26b00e83f871f0afd39caa5a7a1d6ec4aea1)
>
> Signed-off-by: Michel D=C3=A4nzer <michel.daenzer-5C7GfCeVMHo@public.gmane.org>
> ---
>  src/amdgpu_kms.c | 43 ++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 42 insertions(+), 1 deletion(-)
>
> diff --git a/src/amdgpu_kms.c b/src/amdgpu_kms.c
> index a159c84..4ae7995 100644
> --- a/src/amdgpu_kms.c
> +++ b/src/amdgpu_kms.c
> @@ -491,6 +491,35 @@ amdgpu_sync_shared_pixmap(PixmapDirtyUpdatePtr dirty=
)
>         }
>  }
>
> +
> +#if HAS_SYNC_SHARED_PIXMAP
> +
> +static Bool
> +master_has_sync_shared_pixmap(ScrnInfoPtr scrn, PixmapDirtyUpdatePtr
> dirty)
> +{
> +       ScreenPtr master_screen =3D
> dirty->src->master_pixmap->drawable.pScreen;
> +
> +       return master_screen->SyncSharedPixmap !=3D NULL;
> +}
> +
> +static Bool
> +slave_has_sync_shared_pixmap(ScrnInfoPtr scrn, PixmapDirtyUpdatePtr dirt=
y)
> +{
> +       ScreenPtr slave_screen =3D dirty->slave_dst->drawable.pScreen;
> +
> +       return slave_screen->SyncSharedPixmap !=3D NULL;
> +}
> +
> +static void
> +call_sync_shared_pixmap(PixmapDirtyUpdatePtr dirty)
> +{
> +       ScreenPtr master_screen =3D
> dirty->src->master_pixmap->drawable.pScreen;
> +
> +       master_screen->SyncSharedPixmap(dirty);
> +}
> +
> +#else /* !HAS_SYNC_SHARED_PIXMAP */
> +
>  static Bool
>  master_has_sync_shared_pixmap(ScrnInfoPtr scrn, PixmapDirtyUpdatePtr
> dirty)
>  {
> @@ -507,6 +536,15 @@ slave_has_sync_shared_pixmap(ScrnInfoPtr scrn,
> PixmapDirtyUpdatePtr dirty)
>         return slave_scrn->driverName =3D=3D scrn->driverName;
>  }
>
> +static void
> +call_sync_shared_pixmap(PixmapDirtyUpdatePtr dirty)
> +{
> +       amdgpu_sync_shared_pixmap(dirty);
> +}
> +
> +#endif /* HAS_SYNC_SHARED_PIXMAPS */
> +
> +
>  static Bool
>  amdgpu_prime_scanout_do_update(xf86CrtcPtr crtc, unsigned scanout_id)
>  {
> @@ -524,7 +562,7 @@ amdgpu_prime_scanout_do_update(xf86CrtcPtr crtc,
> unsigned scanout_id)
>                         RegionPtr region;
>
>                         if (master_has_sync_shared_pixmap(scrn, dirty))
> -                               amdgpu_sync_shared_pixmap(dirty);
> +                               call_sync_shared_pixmap(dirty);
>
>                         region =3D dirty_region(dirty);
>                         if (RegionNil(region))
> @@ -1803,6 +1841,9 @@ Bool AMDGPUScreenInit_KMS(SCREEN_INIT_ARGS_DECL)
>  #ifdef AMDGPU_PIXMAP_SHARING
>         pScreen->StartPixmapTracking =3D PixmapStartDirtyTracking;
>         pScreen->StopPixmapTracking =3D PixmapStopDirtyTracking;
> +#if HAS_SYNC_SHARED_PIXMAP
> +       pScreen->SyncSharedPixmap =3D amdgpu_sync_shared_pixmap;
> +#endif
>  #endif
>
>         if (!xf86CrtcScreenInit(pScreen))
> --
> 2.9.3
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>

--001a114b2f669ed8e9053d8d5832
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Am I right in guessing this is only required for DRI2?</di=
v><br><div class=3D"gmail_quote"><div dir=3D"ltr">On Wed, 28 Sep 2016 at 09=
:00 Michel D=C3=A4nzer &lt;<a href=3D"mailto:michel-otUistvHUpPR7s880joybQ@public.gmane.org">michel@dae=
nzer.net</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D=
"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">From: Miche=
l D=C3=A4nzer &lt;<a href=3D"mailto:michel.daenzer-5C7GfCeVMHo@public.gmane.org" target=3D"_blan=
k">michel.daenzer-5C7GfCeVMHo@public.gmane.org</a>&gt;<br>
<br>
This allows deferring shared pixmap updates between different drivers.<br>
<br>
(Ported from radeon commit 53be26b00e83f871f0afd39caa5a7a1d6ec4aea1)<br>
<br>
Signed-off-by: Michel D=C3=A4nzer &lt;<a href=3D"mailto:michel.daenzer@amd.=
com" target=3D"_blank">michel.daenzer-5C7GfCeVMHo@public.gmane.org</a>&gt;<br>
---<br>
=C2=A0src/amdgpu_kms.c | 43 ++++++++++++++++++++++++++++++++++++++++++-<br>
=C2=A01 file changed, 42 insertions(+), 1 deletion(-)<br>
<br>
diff --git a/src/amdgpu_kms.c b/src/amdgpu_kms.c<br>
index a159c84..4ae7995 100644<br>
--- a/src/amdgpu_kms.c<br>
+++ b/src/amdgpu_kms.c<br>
@@ -491,6 +491,35 @@ amdgpu_sync_shared_pixmap(PixmapDirtyUpdatePtr dirty)<=
br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
=C2=A0}<br>
<br>
+<br>
+#if HAS_SYNC_SHARED_PIXMAP<br>
+<br>
+static Bool<br>
+master_has_sync_shared_pixmap(ScrnInfoPtr scrn, PixmapDirtyUpdatePtr dirty=
)<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0ScreenPtr master_screen =3D dirty-&gt;src-&gt;m=
aster_pixmap-&gt;drawable.pScreen;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0return master_screen-&gt;SyncSharedPixmap !=3D =
NULL;<br>
+}<br>
+<br>
+static Bool<br>
+slave_has_sync_shared_pixmap(ScrnInfoPtr scrn, PixmapDirtyUpdatePtr dirty)=
<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0ScreenPtr slave_screen =3D dirty-&gt;slave_dst-=
&gt;drawable.pScreen;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0return slave_screen-&gt;SyncSharedPixmap !=3D N=
ULL;<br>
+}<br>
+<br>
+static void<br>
+call_sync_shared_pixmap(PixmapDirtyUpdatePtr dirty)<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0ScreenPtr master_screen =3D dirty-&gt;src-&gt;m=
aster_pixmap-&gt;drawable.pScreen;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0master_screen-&gt;SyncSharedPixmap(dirty);<br>
+}<br>
+<br>
+#else /* !HAS_SYNC_SHARED_PIXMAP */<br>
+<br>
=C2=A0static Bool<br>
=C2=A0master_has_sync_shared_pixmap(ScrnInfoPtr scrn, PixmapDirtyUpdatePtr =
dirty)<br>
=C2=A0{<br>
@@ -507,6 +536,15 @@ slave_has_sync_shared_pixmap(ScrnInfoPtr scrn, PixmapD=
irtyUpdatePtr dirty)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 return slave_scrn-&gt;driverName =3D=3D scrn-&g=
t;driverName;<br>
=C2=A0}<br>
<br>
+static void<br>
+call_sync_shared_pixmap(PixmapDirtyUpdatePtr dirty)<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0amdgpu_sync_shared_pixmap(dirty);<br>
+}<br>
+<br>
+#endif /* HAS_SYNC_SHARED_PIXMAPS */<br>
+<br>
+<br>
=C2=A0static Bool<br>
=C2=A0amdgpu_prime_scanout_do_update(xf86CrtcPtr crtc, unsigned scanout_id)=
<br>
=C2=A0{<br>
@@ -524,7 +562,7 @@ amdgpu_prime_scanout_do_update(xf86CrtcPtr crtc, unsign=
ed scanout_id)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 RegionPtr region;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 if (master_has_sync_shared_pixmap(scrn, dirty))<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0amdgpu_sync_shared_pixmap(dirty);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0call_sync_shared_pixmap(dirty);<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 region =3D dirty_region(dirty);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 if (RegionNil(region))<br>
@@ -1803,6 +1841,9 @@ Bool AMDGPUScreenInit_KMS(SCREEN_INIT_ARGS_DECL)<br>
=C2=A0#ifdef AMDGPU_PIXMAP_SHARING<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 pScreen-&gt;StartPixmapTracking =3D PixmapStart=
DirtyTracking;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 pScreen-&gt;StopPixmapTracking =3D PixmapStopDi=
rtyTracking;<br>
+#if HAS_SYNC_SHARED_PIXMAP<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0pScreen-&gt;SyncSharedPixmap =3D amdgpu_sync_sh=
ared_pixmap;<br>
+#endif<br>
=C2=A0#endif<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!xf86CrtcScreenInit(pScreen))<br>
--<br>
2.9.3<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
<a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" target=3D"_blank">amd-gfx@=
lists.freedesktop.org</a><br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx" rel=3D"n=
oreferrer" target=3D"_blank">https://lists.freedesktop.org/mailman/listinfo=
/amd-gfx</a><br>
</blockquote></div>

--001a114b2f669ed8e9053d8d5832--

--===============1479052211==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1479052211==--
