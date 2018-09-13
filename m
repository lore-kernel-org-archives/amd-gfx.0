From: Mike Lothian <mike@fireburn.co.uk>
Subject: Re: [PATCH 2/2] drm/ttm: once more fix ttm_bo_bulk_move_lru_tail v2
Date: Thu, 13 Sep 2018 16:52:31 +0100
Message-ID: <CAHbf0-Hf2GyXy94-gyQEXSc-6UphoiTA1Wx0G3P9v1getsU0jw@mail.gmail.com>
References: <20180913112208.1353-1-christian.koenig@amd.com>
 <20180913112208.1353-2-christian.koenig@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1734434571=="
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20180913112208.1353-2-christian.koenig@amd.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
Cc: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
List-Id: amd-gfx.lists.freedesktop.org

--===============1734434571==
Content-Type: multipart/alternative; boundary="0000000000008599110575c2b23e"

--0000000000008599110575c2b23e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

This fixes a boot issue I had on Raven (
https://bugs.freedesktop.org/show_bug.cgi?id=3D107922)

Feel free to add to both patches:

Tested-by: Mike Lothian <mike@fireburn.co.uk>

Cheers

Mike

On Thu, 13 Sep 2018 at 12:22 Christian K=C3=B6nig <
ckoenig.leichtzumerken@gmail.com> wrote:

> While cutting the lists we sometimes accidentally added a list_head from
> the stack to the LRUs, effectively corrupting the list.
>
> Remove the list cutting and use explicit list manipulation instead.
>
> v2: separate out new list_bulk_move_tail helper
>
> Signed-off-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> ---
>  drivers/gpu/drm/ttm/ttm_bo.c | 46
> +++++++++++++++++++-------------------------
>  1 file changed, 20 insertions(+), 26 deletions(-)
>
> diff --git a/drivers/gpu/drm/ttm/ttm_bo.c b/drivers/gpu/drm/ttm/ttm_bo.c
> index 138c98902033..26b889f86670 100644
> --- a/drivers/gpu/drm/ttm/ttm_bo.c
> +++ b/drivers/gpu/drm/ttm/ttm_bo.c
> @@ -247,47 +247,38 @@ void ttm_bo_move_to_lru_tail(struct
> ttm_buffer_object *bo,
>  }
>  EXPORT_SYMBOL(ttm_bo_move_to_lru_tail);
>
> -static void ttm_bo_bulk_move_helper(struct ttm_lru_bulk_move_pos *pos,
> -                                   struct list_head *lru, bool is_swap)
> -{
> -       struct list_head *list;
> -       LIST_HEAD(entries);
> -       LIST_HEAD(before);
> -
> -       reservation_object_assert_held(pos->last->resv);
> -       list =3D is_swap ? &pos->last->swap : &pos->last->lru;
> -       list_cut_position(&entries, lru, list);
> -
> -       reservation_object_assert_held(pos->first->resv);
> -       list =3D is_swap ? pos->first->swap.prev : pos->first->lru.prev;
> -       list_cut_position(&before, &entries, list);
> -
> -       list_splice(&before, lru);
> -       list_splice_tail(&entries, lru);
> -}
> -
>  void ttm_bo_bulk_move_lru_tail(struct ttm_lru_bulk_move *bulk)
>  {
>         unsigned i;
>
>         for (i =3D 0; i < TTM_MAX_BO_PRIORITY; ++i) {
> +               struct ttm_lru_bulk_move_pos *pos =3D &bulk->tt[i];
>                 struct ttm_mem_type_manager *man;
>
> -               if (!bulk->tt[i].first)
> +               if (!pos->first)
>                         continue;
>
> -               man =3D &bulk->tt[i].first->bdev->man[TTM_PL_TT];
> -               ttm_bo_bulk_move_helper(&bulk->tt[i], &man->lru[i], false=
);
> +               reservation_object_assert_held(pos->first->resv);
> +               reservation_object_assert_held(pos->last->resv);
> +
> +               man =3D &pos->first->bdev->man[TTM_PL_TT];
> +               list_bulk_move_tail(&man->lru[i], &pos->first->lru,
> +                                   &pos->last->lru);
>         }
>
>         for (i =3D 0; i < TTM_MAX_BO_PRIORITY; ++i) {
> +               struct ttm_lru_bulk_move_pos *pos =3D &bulk->vram[i];
>                 struct ttm_mem_type_manager *man;
>
> -               if (!bulk->vram[i].first)
> +               if (!pos->first)
>                         continue;
>
> -               man =3D &bulk->vram[i].first->bdev->man[TTM_PL_VRAM];
> -               ttm_bo_bulk_move_helper(&bulk->vram[i], &man->lru[i],
> false);
> +               reservation_object_assert_held(pos->first->resv);
> +               reservation_object_assert_held(pos->last->resv);
> +
> +               man =3D &pos->first->bdev->man[TTM_PL_VRAM];
> +               list_bulk_move_tail(&man->lru[i], &pos->first->lru,
> +                                   &pos->last->lru);
>         }
>
>         for (i =3D 0; i < TTM_MAX_BO_PRIORITY; ++i) {
> @@ -297,8 +288,11 @@ void ttm_bo_bulk_move_lru_tail(struct
> ttm_lru_bulk_move *bulk)
>                 if (!pos->first)
>                         continue;
>
> +               reservation_object_assert_held(pos->first->resv);
> +               reservation_object_assert_held(pos->last->resv);
> +
>                 lru =3D &pos->first->bdev->glob->swap_lru[i];
> -               ttm_bo_bulk_move_helper(&bulk->swap[i], lru, true);
> +               list_bulk_move_tail(lru, &pos->first->swap,
> &pos->last->swap);
>         }
>  }
>  EXPORT_SYMBOL(ttm_bo_bulk_move_lru_tail);
> --
> 2.14.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
>

--0000000000008599110575c2b23e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi=C2=A0<div><br></div><div>This fixes a boot issue I had =
on Raven (<a href=3D"https://bugs.freedesktop.org/show_bug.cgi?id=3D107922"=
>https://bugs.freedesktop.org/show_bug.cgi?id=3D107922</a>)</div><div><br><=
/div><div>Feel free to add to both patches:</div><div><br></div><div>Tested=
-by: Mike Lothian &lt;<a href=3D"mailto:mike@fireburn.co.uk">mike@fireburn.=
co.uk</a>&gt;</div><div><br></div><div>Cheers</div><div><br></div><div>Mike=
</div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr">On Thu, 13 Sep =
2018 at 12:22 Christian K=C3=B6nig &lt;<a href=3D"mailto:ckoenig.leichtzume=
rken@gmail.com">ckoenig.leichtzumerken@gmail.com</a>&gt; wrote:<br></div><b=
lockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px =
#ccc solid;padding-left:1ex">While cutting the lists we sometimes accidenta=
lly added a list_head from<br>
the stack to the LRUs, effectively corrupting the list.<br>
<br>
Remove the list cutting and use explicit list manipulation instead.<br>
<br>
v2: separate out new list_bulk_move_tail helper<br>
<br>
Signed-off-by: Christian K=C3=B6nig &lt;<a href=3D"mailto:christian.koenig@=
amd.com" target=3D"_blank">christian.koenig@amd.com</a>&gt;<br>
---<br>
=C2=A0drivers/gpu/drm/ttm/ttm_bo.c | 46 +++++++++++++++++++----------------=
---------<br>
=C2=A01 file changed, 20 insertions(+), 26 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/ttm/ttm_bo.c b/drivers/gpu/drm/ttm/ttm_bo.c<br=
>
index 138c98902033..26b889f86670 100644<br>
--- a/drivers/gpu/drm/ttm/ttm_bo.c<br>
+++ b/drivers/gpu/drm/ttm/ttm_bo.c<br>
@@ -247,47 +247,38 @@ void ttm_bo_move_to_lru_tail(struct ttm_buffer_object=
 *bo,<br>
=C2=A0}<br>
=C2=A0EXPORT_SYMBOL(ttm_bo_move_to_lru_tail);<br>
<br>
-static void ttm_bo_bulk_move_helper(struct ttm_lru_bulk_move_pos *pos,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct list_head *lru, =
bool is_swap)<br>
-{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0struct list_head *list;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0LIST_HEAD(entries);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0LIST_HEAD(before);<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0reservation_object_assert_held(pos-&gt;last-&gt=
;resv);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0list =3D is_swap ? &amp;pos-&gt;last-&gt;swap :=
 &amp;pos-&gt;last-&gt;lru;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0list_cut_position(&amp;entries, lru, list);<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0reservation_object_assert_held(pos-&gt;first-&g=
t;resv);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0list =3D is_swap ? pos-&gt;first-&gt;swap.prev =
: pos-&gt;first-&gt;lru.prev;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0list_cut_position(&amp;before, &amp;entries, li=
st);<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0list_splice(&amp;before, lru);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0list_splice_tail(&amp;entries, lru);<br>
-}<br>
-<br>
=C2=A0void ttm_bo_bulk_move_lru_tail(struct ttm_lru_bulk_move *bulk)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned i;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 for (i =3D 0; i &lt; TTM_MAX_BO_PRIORITY; ++i) =
{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct ttm_lru_bulk=
_move_pos *pos =3D &amp;bulk-&gt;tt[i];<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct ttm_mem_type=
_manager *man;<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!bulk-&gt;tt[i]=
.first)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!pos-&gt;first)=
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 continue;<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0man =3D &amp;bulk-&=
gt;tt[i].first-&gt;bdev-&gt;man[TTM_PL_TT];<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ttm_bo_bulk_move_he=
lper(&amp;bulk-&gt;tt[i], &amp;man-&gt;lru[i], false);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0reservation_object_=
assert_held(pos-&gt;first-&gt;resv);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0reservation_object_=
assert_held(pos-&gt;last-&gt;resv);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0man =3D &amp;pos-&g=
t;first-&gt;bdev-&gt;man[TTM_PL_TT];<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0list_bulk_move_tail=
(&amp;man-&gt;lru[i], &amp;pos-&gt;first-&gt;lru,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;pos-&gt;last-&gt;l=
ru);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 for (i =3D 0; i &lt; TTM_MAX_BO_PRIORITY; ++i) =
{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct ttm_lru_bulk=
_move_pos *pos =3D &amp;bulk-&gt;vram[i];<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct ttm_mem_type=
_manager *man;<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!bulk-&gt;vram[=
i].first)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!pos-&gt;first)=
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 continue;<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0man =3D &amp;bulk-&=
gt;vram[i].first-&gt;bdev-&gt;man[TTM_PL_VRAM];<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ttm_bo_bulk_move_he=
lper(&amp;bulk-&gt;vram[i], &amp;man-&gt;lru[i], false);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0reservation_object_=
assert_held(pos-&gt;first-&gt;resv);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0reservation_object_=
assert_held(pos-&gt;last-&gt;resv);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0man =3D &amp;pos-&g=
t;first-&gt;bdev-&gt;man[TTM_PL_VRAM];<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0list_bulk_move_tail=
(&amp;man-&gt;lru[i], &amp;pos-&gt;first-&gt;lru,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;pos-&gt;last-&gt;l=
ru);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 for (i =3D 0; i &lt; TTM_MAX_BO_PRIORITY; ++i) =
{<br>
@@ -297,8 +288,11 @@ void ttm_bo_bulk_move_lru_tail(struct ttm_lru_bulk_mov=
e *bulk)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!pos-&gt;first)=
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 continue;<br>
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0reservation_object_=
assert_held(pos-&gt;first-&gt;resv);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0reservation_object_=
assert_held(pos-&gt;last-&gt;resv);<br>
+<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 lru =3D &amp;pos-&g=
t;first-&gt;bdev-&gt;glob-&gt;swap_lru[i];<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ttm_bo_bulk_move_he=
lper(&amp;bulk-&gt;swap[i], lru, true);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0list_bulk_move_tail=
(lru, &amp;pos-&gt;first-&gt;swap, &amp;pos-&gt;last-&gt;swap);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
=C2=A0}<br>
=C2=A0EXPORT_SYMBOL(ttm_bo_bulk_move_lru_tail);<br>
-- <br>
2.14.1<br>
<br>
_______________________________________________<br>
dri-devel mailing list<br>
<a href=3D"mailto:dri-devel@lists.freedesktop.org" target=3D"_blank">dri-de=
vel@lists.freedesktop.org</a><br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/dri-devel" rel=3D=
"noreferrer" target=3D"_blank">https://lists.freedesktop.org/mailman/listin=
fo/dri-devel</a><br>
</blockquote></div>

--0000000000008599110575c2b23e--

--===============1734434571==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVs
IG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==

--===============1734434571==--
