From: Julia Lawall <julia.lawall@lip6.fr>
Subject: Re: [Outreachy kernel] Re: [PATCH] gpu: drm: Use list_first_entry
 instead of list_entry
Date: Mon, 19 Mar 2018 12:06:31 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1803191204550.3392@hadrien>
References: <20180318215105.GA15431@seema-Inspiron-15-3567> <8b1e22f8-7a05-b66b-8825-7d4d97e46dac@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-369822278-1521457591=:3392"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <8b1e22f8-7a05-b66b-8825-7d4d97e46dac@amd.com>
Sender: linux-kernel-owner@vger.kernel.org
To: =?ISO-8859-15?Q?Christian_K=F6nig?= <christian.koenig@amd.com>
Cc: Arushi Singhal <arushisinghal19971997@gmail.com>, alexander.deucher@amd.com, David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, outreachy-kernel@googlegroups.com, Tomi Valkeinen <tomi.valkeinen@ti.com>, amd-gfx@lists.freedesktop.org
List-Id: amd-gfx.lists.freedesktop.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-369822278-1521457591=:3392
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Mon, 19 Mar 2018, Christian König wrote:

> Mhm, actually that patch isn't correct. What we grab get here is the next
> entry, not the first one.
>
> We don't have an alias list_next_entry for list_first_entry?

As compared to the semantic patch I proposed earlier today, it would seem
that list_first_entry is useful when the types are different?  One would
have to check the result of course, but a list eleemnt with the same type
as the structure that contains the list might be unlikely?

julia

>
> Regards,
> Christian.
>
> Am 18.03.2018 um 22:51 schrieb Arushi Singhal:
> > This patch replaces list_entry with list_first_entry as it makes the
> > code more clear.
> > Done using coccinelle:
> >
> > @@
> > expression e;
> > @@
> > (
> > - list_entry(e->next,
> > + list_first_entry(e,
> >    ...)
> > |
> > - list_entry(e->prev,
> > + list_last_entry(e,
> >    ...)
> > )
> >
> > Signed-off-by: Arushi Singhal <arushisinghal19971997@gmail.com>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_sa.c | 4 ++--
> >   drivers/gpu/drm/omapdrm/dss/display.c  | 4 ++--
> >   drivers/gpu/drm/radeon/radeon_sa.c     | 4 ++--
> >   3 files changed, 6 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sa.c
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_sa.c
> > index 3144400..646f593 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sa.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sa.c
> > @@ -158,7 +158,7 @@ static void amdgpu_sa_bo_try_free(struct
> > amdgpu_sa_manager *sa_manager)
> >   	if (sa_manager->hole->next == &sa_manager->olist)
> >   		return;
> >   -	sa_bo = list_entry(sa_manager->hole->next, struct amdgpu_sa_bo,
> > olist);
> > +	sa_bo = list_first_entry(sa_manager->hole, struct amdgpu_sa_bo,
> > olist);
> >   	list_for_each_entry_safe_from(sa_bo, tmp, &sa_manager->olist, olist) {
> >   		if (sa_bo->fence == NULL ||
> >   		    !dma_fence_is_signaled(sa_bo->fence)) {
> > @@ -183,7 +183,7 @@ static inline unsigned amdgpu_sa_bo_hole_eoffset(struct
> > amdgpu_sa_manager *sa_ma
> >   	struct list_head *hole = sa_manager->hole;
> >     	if (hole->next != &sa_manager->olist) {
> > -		return list_entry(hole->next, struct amdgpu_sa_bo,
> > olist)->soffset;
> > +		return list_first_entry(hole, struct amdgpu_sa_bo,
> > olist)->soffset;
> >   	}
> >   	return sa_manager->size;
> >   }
> > diff --git a/drivers/gpu/drm/omapdrm/dss/display.c
> > b/drivers/gpu/drm/omapdrm/dss/display.c
> > index 0c9480b..fb9ecae 100644
> > --- a/drivers/gpu/drm/omapdrm/dss/display.c
> > +++ b/drivers/gpu/drm/omapdrm/dss/display.c
> > @@ -158,8 +158,8 @@ struct omap_dss_device *omap_dss_get_next_device(struct
> > omap_dss_device *from)
> >   				goto out;
> >   			}
> >   -			dssdev = list_entry(l->next, struct omap_dss_device,
> > -					panel_list);
> > +			dssdev = list_first_entry(l, struct omap_dss_device,
> > +						  panel_list);
> >   			omap_dss_get_device(dssdev);
> >   			goto out;
> >   		}
> > diff --git a/drivers/gpu/drm/radeon/radeon_sa.c
> > b/drivers/gpu/drm/radeon/radeon_sa.c
> > index 197b157..66c0482 100644
> > --- a/drivers/gpu/drm/radeon/radeon_sa.c
> > +++ b/drivers/gpu/drm/radeon/radeon_sa.c
> > @@ -158,7 +158,7 @@ static void radeon_sa_bo_try_free(struct
> > radeon_sa_manager *sa_manager)
> >   	if (sa_manager->hole->next == &sa_manager->olist)
> >   		return;
> >   -	sa_bo = list_entry(sa_manager->hole->next, struct radeon_sa_bo,
> > olist);
> > +	sa_bo = list_first_entry(sa_manager->hole, struct radeon_sa_bo,
> > olist);
> >   	list_for_each_entry_safe_from(sa_bo, tmp, &sa_manager->olist, olist) {
> >   		if (sa_bo->fence == NULL ||
> > !radeon_fence_signaled(sa_bo->fence)) {
> >   			return;
> > @@ -182,7 +182,7 @@ static inline unsigned radeon_sa_bo_hole_eoffset(struct
> > radeon_sa_manager *sa_ma
> >   	struct list_head *hole = sa_manager->hole;
> >     	if (hole->next != &sa_manager->olist) {
> > -		return list_entry(hole->next, struct radeon_sa_bo,
> > olist)->soffset;
> > +		return list_first_entry(hole, struct radeon_sa_bo,
> > olist)->soffset;
> >   	}
> >   	return sa_manager->size;
> >   }
>
> --
> You received this message because you are subscribed to the Google Groups
> "outreachy-kernel" group.
> To unsubscribe from this group and stop receiving emails from it, send an
> email to outreachy-kernel+unsubscribe@googlegroups.com.
> To post to this group, send email to outreachy-kernel@googlegroups.com.
> To view this discussion on the web visit
> https://groups.google.com/d/msgid/outreachy-kernel/8b1e22f8-7a05-b66b-8825-7d4d97e46dac%40amd.com.
> For more options, visit https://groups.google.com/d/optout.
>
--8323329-369822278-1521457591=:3392--
