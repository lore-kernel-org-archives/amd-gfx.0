From: Alex Deucher <alexdeucher@gmail.com>
Subject: Re: [PATCH v2 24/27] drm/amdgpu/dm: Resume short HPD IRQs before
 resuming MST topology
Date: Fri, 13 Sep 2019 16:46:12 -0400
Message-ID: <CADnq5_NNdGxtpF477Lu3nTMmHJ+EtYJ1bU2vEzaeQLfJjzQjmg@mail.gmail.com>
References: <20190903204645.25487-1-lyude@redhat.com> <20190903204645.25487-25-lyude@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190903204645.25487-25-lyude@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Lyude Paul <lyude@redhat.com>
Cc: Maling list - DRI developers <dri-devel@lists.freedesktop.org>, nouveau <nouveau@lists.freedesktop.org>, amd-gfx list <amd-gfx@lists.freedesktop.org>, Leo Li <sunpeng.li@amd.com>, Daniel Vetter <daniel.vetter@ffwll.ch>, LKML <linux-kernel@vger.kernel.org>, Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>, Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>, David Airlie <airlied@linux.ie>, Juston Li <juston.li@intel.com>, Alex Deucher <alexander.deucher@amd.com>, David Francis <David.Francis@amd.com>, Harry Wentland <hwentlan@amd.com>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
List-Id: amd-gfx.lists.freedesktop.org

On Tue, Sep 3, 2019 at 4:49 PM Lyude Paul <lyude@redhat.com> wrote:
>
> Since we're going to be reprobing the entire topology state on resume
> now using sideband transactions, we need to ensure that we actually have
> short HPD irqs enabled before calling drm_dp_mst_topology_mgr_resume().
> So, do that.
>
> Cc: Juston Li <juston.li@intel.com>
> Cc: Imre Deak <imre.deak@intel.com>
> Cc: Ville Syrj=C3=A4l=C3=A4 <ville.syrjala@linux.intel.com>
> Cc: Harry Wentland <hwentlan@amd.com>
> Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
> Signed-off-by: Lyude Paul <lyude@redhat.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/=
gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 73630e2940d4..4d3c8bff77da 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -1185,15 +1185,15 @@ static int dm_resume(void *handle)
>         /* program HPD filter */
>         dc_resume(dm->dc);
>
> -       /* On resume we need to  rewrite the MSTM control bits to enamble=
 MST*/
> -       s3_handle_mst(ddev, false);
> -
>         /*
>          * early enable HPD Rx IRQ, should be done before set mode as sho=
rt
>          * pulse interrupts are used for MST
>          */
>         amdgpu_dm_irq_resume_early(adev);
>
> +       /* On resume we need to  rewrite the MSTM control bits to enamble=
 MST*/
> +       s3_handle_mst(ddev, false);
> +
>         /* Do detection*/
>         drm_connector_list_iter_begin(ddev, &iter);
>         drm_for_each_connector_iter(connector, &iter) {
> --
> 2.21.0
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
