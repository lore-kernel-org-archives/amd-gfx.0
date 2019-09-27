From: Alex Deucher <alexdeucher@gmail.com>
Subject: Re: [PATCH 3/6] drm/amdgpu/dm/mst: Use ->atomic_best_encoder
Date: Fri, 27 Sep 2019 10:06:33 -0400
Message-ID: <CADnq5_NUkJxcdc4PFW6MNiDaVD7WR+_JtztOxFqWkkXaR2Br=A@mail.gmail.com>
References: <20190926225122.31455-1-lyude@redhat.com> <20190926225122.31455-4-lyude@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190926225122.31455-4-lyude@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Lyude Paul <lyude@redhat.com>
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>, "David (ChunMing) Zhou" <David1.Zhou@amd.com>, Thomas Lim <Thomas.Lim@amd.com>, Leo Li <sunpeng.li@amd.com>, David Francis <David.Francis@amd.com>, LKML <linux-kernel@vger.kernel.org>, Maling list - DRI developers <dri-devel@lists.freedesktop.org>, David Airlie <airlied@linux.ie>, "Jerry (Fangzhi) Zuo" <Jerry.Zuo@amd.com>, Daniel Vetter <daniel@ffwll.ch>, Alex Deucher <alexander.deucher@amd.com>, Harry Wentland <harry.wentland@amd.com>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
List-Id: amd-gfx.lists.freedesktop.org

On Thu, Sep 26, 2019 at 6:52 PM Lyude Paul <lyude@redhat.com> wrote:
>
> We are supposed to be atomic after all. We'll need this in a moment for
> the next commit.
>
> Signed-off-by: Lyude Paul <lyude@redhat.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  .../drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c    | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
> index a398ddd1f306..d9113ce0be09 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
> @@ -243,17 +243,17 @@ static int dm_dp_mst_get_modes(struct drm_connector *connector)
>         return ret;
>  }
>
> -static struct drm_encoder *dm_mst_best_encoder(struct drm_connector *connector)
> +static struct drm_encoder *
> +dm_mst_atomic_best_encoder(struct drm_connector *connector,
> +                          struct drm_connector_state *connector_state)
>  {
> -       struct amdgpu_dm_connector *amdgpu_dm_connector = to_amdgpu_dm_connector(connector);
> -
> -       return &amdgpu_dm_connector->mst_encoder->base;
> +       return &to_amdgpu_dm_connector(connector)->mst_encoder->base;
>  }
>
>  static const struct drm_connector_helper_funcs dm_dp_mst_connector_helper_funcs = {
>         .get_modes = dm_dp_mst_get_modes,
>         .mode_valid = amdgpu_dm_connector_mode_valid,
> -       .best_encoder = dm_mst_best_encoder,
> +       .atomic_best_encoder = dm_mst_atomic_best_encoder,
>  };
>
>  static void amdgpu_dm_encoder_destroy(struct drm_encoder *encoder)
> --
> 2.21.0
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
