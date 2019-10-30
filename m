From: Alex Deucher <alexdeucher@gmail.com>
Subject: Re: [PATCH] Drivers: gpu: drm: amd: display: amdgpu_dm: amdgpu_dm.h:
 Fixed a documentation warning
Date: Wed, 30 Oct 2019 15:08:48 -0400
Message-ID: <CADnq5_PHHNYp-nfjsgRfeoaMEo+QeQD1-rtDpQhqdJeG7gMMVA@mail.gmail.com>
References: <20191028060443.14997-1-madhuparnabhowmik04@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191028060443.14997-1-madhuparnabhowmik04@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: madhuparnabhowmik04@gmail.com
Cc: "Wentland, Harry" <harry.wentland@amd.com>, "Deucher, Alexander" <alexander.deucher@amd.com>, linux-kernel-mentees@lists.linuxfoundation.org, Maling list - DRI developers <dri-devel@lists.freedesktop.org>, amd-gfx list <amd-gfx@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: amd-gfx.lists.freedesktop.org

On Mon, Oct 28, 2019 at 4:25 AM <madhuparnabhowmik04@gmail.com> wrote:
>
> From: Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>
>
> This patch fixes the following  warning: Incorrect use of
>  kernel-doc format:          * @atomic_obj
> by adding a colon after @atomic_obj.
>
> Signed-off-by: Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>

Thanks for the patch.  This as already fixed by Harry.

Alex

> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
> index c8c525a2b505..80d53d095773 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
> @@ -128,7 +128,7 @@ struct amdgpu_display_manager {
>         u16 display_indexes_num;
>
>         /**
> -        * @atomic_obj
> +        * @atomic_obj:
>          *
>          * In combination with &dm_atomic_state it helps manage
>          * global atomic state that doesn't map cleanly into existing
> --
> 2.17.1
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
