From: Alex Deucher <alexdeucher@gmail.com>
Subject: Re: [PATCH 2/6] drm/amdgpu/dm/mst: Remove unnecessary NULL check
Date: Fri, 27 Sep 2019 10:05:54 -0400
Message-ID: <CADnq5_MR_WZHOMa0JQWpm9fZgpsCWFpmO1B5Rph_OVhje6kokg@mail.gmail.com>
References: <20190926225122.31455-1-lyude@redhat.com> <20190926225122.31455-3-lyude@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190926225122.31455-3-lyude@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Lyude Paul <lyude@redhat.com>
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>, "David (ChunMing) Zhou" <David1.Zhou@amd.com>, Thomas Lim <Thomas.Lim@amd.com>, Leo Li <sunpeng.li@amd.com>, David Francis <David.Francis@amd.com>, LKML <linux-kernel@vger.kernel.org>, Maling list - DRI developers <dri-devel@lists.freedesktop.org>, Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>, David Airlie <airlied@linux.ie>, "Jerry (Fangzhi) Zuo" <Jerry.Zuo@amd.com>, Daniel Vetter <daniel@ffwll.ch>, Alex Deucher <alexander.deucher@amd.com>, Harry Wentland <harry.wentland@amd.com>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
List-Id: amd-gfx.lists.freedesktop.org

On Thu, Sep 26, 2019 at 6:52 PM Lyude Paul <lyude@redhat.com> wrote:
>
> kfree() checks this automatically.
>
> Signed-off-by: Lyude Paul <lyude@redhat.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

And applied.  Thanks!

Alex

> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
> index 185bf0e2bda2..a398ddd1f306 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
> @@ -144,10 +144,8 @@ dm_dp_mst_connector_destroy(struct drm_connector *connector)
>         struct amdgpu_dm_connector *amdgpu_dm_connector = to_amdgpu_dm_connector(connector);
>         struct amdgpu_encoder *amdgpu_encoder = amdgpu_dm_connector->mst_encoder;
>
> -       if (amdgpu_dm_connector->edid) {
> -               kfree(amdgpu_dm_connector->edid);
> -               amdgpu_dm_connector->edid = NULL;
> -       }
> +       kfree(amdgpu_dm_connector->edid);
> +       amdgpu_dm_connector->edid = NULL;
>
>         drm_encoder_cleanup(&amdgpu_encoder->base);
>         kfree(amdgpu_encoder);
> --
> 2.21.0
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
