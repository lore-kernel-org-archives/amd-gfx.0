From: Alex Deucher <alexdeucher@gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Initialize variable before use
Date: Wed, 2 Oct 2019 09:41:21 -0400
Message-ID: <CADnq5_MapuHn=yNSkYf6yUzatXps2sMJPNLJ-wUad5jqg+GuQw@mail.gmail.com>
References: <20190930200902.inmjn264l6pxcdsq@outlook.office365.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190930200902.inmjn264l6pxcdsq@outlook.office365.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Siqueira, Rodrigo" <Rodrigo.Siqueira@amd.com>
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Zhou, David(ChunMing)" <David1.Zhou@amd.com>, "Li, Sun peng (Leo)" <Sunpeng.Li@amd.com>, "Kazlauskas, Nicholas" <Nicholas.Kazlauskas@amd.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Wentland, Harry" <Harry.Wentland@amd.com>, "Koenig, Christian" <Christian.Koenig@amd.com>
List-Id: amd-gfx.lists.freedesktop.org

On Mon, Sep 30, 2019 at 4:09 PM Siqueira, Rodrigo
<Rodrigo.Siqueira@amd.com> wrote:
>
> The 'debug_data' variable gets printed in debug statements without a
> prior initialization in the function
> hubbub1_verify_allow_pstate_change_high, as reported when building with
> gcc 9.1.0:
>
> warning: =E2=80=98debug_data=E2=80=99 may be used uninitialized in this f=
unction [-Wmaybe-uninitialized]
>   290 |  printk##once(KERN_##level "[" DRM_NAME "] " fmt, ##__VA_ARGS__)
>       |  ^~~~~~
> dc/dcn10/dcn10_hubbub.c:134:15: note: =E2=80=98debug_data=E2=80=99 was de=
clared here
>   134 |  unsigned int debug_data;
>
> Note that initialize debug_data with 0, in this case, is safe because we
> have a loop in a few lines below that will initialize this variable with
> the proper value.
>
> Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hubbub.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hubbub.c b/driver=
s/gpu/drm/amd/display/dc/dcn10/dcn10_hubbub.c
> index a780057e2dbc..b6967a7e6c7b 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hubbub.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hubbub.c
> @@ -133,7 +133,7 @@ bool hubbub1_verify_allow_pstate_change_high(
>         static unsigned int max_sampled_pstate_wait_us; /* data collectio=
n */
>         static bool forced_pstate_allow; /* help with revert wa */
>
> -       unsigned int debug_data;
> +       unsigned int debug_data =3D 0;
>         unsigned int i;
>
>         if (forced_pstate_allow) {
> --
> 2.23.0
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
