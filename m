From: Guenter Roeck <groeck@google.com>
Subject: Re: [PATCH 1/2] amdgpu/dc/dml: Consolidate redundant CFLAGS
Date: Wed, 7 Feb 2018 17:32:58 -0800
Message-ID: <CABXOdTfUp6LYR0m4t7YVwox7F4-tZARzn5AhzG++vQsWHpkscw@mail.gmail.com>
References: <20180208012156.165934-1-mka@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180208012156.165934-1-mka@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Matthias Kaehlcke <mka@chromium.org>
Cc: Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, David Zhou <David1.Zhou@amd.com>, David Airlie <airlied@linux.ie>, Harry Wentland <harry.wentland@amd.com>, Felix Kuehling <Felix.Kuehling@amd.com>, Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>, amd-gfx list <amd-gfx@lists.freedesktop.org>, Maling list - DRI developers <dri-devel@lists.freedesktop.org>, linux-kernel <linux-kernel@vger.kernel.org>, Guenter Roeck <groeck@chromium.org>, Justin TerAvest <teravest@chromium.org>, Craig Bergstrom <craigb@chromium.org>
List-Id: amd-gfx.lists.freedesktop.org

On Wed, Feb 7, 2018 at 5:21 PM, Matthias Kaehlcke <mka@chromium.org> wrote:
> Use subdir-ccflags instead of specifying the same flags for every source
> file.
>
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>

Reviewed-by: Guenter Roeck <groeck@chromium.org>

> ---
>  drivers/gpu/drm/amd/display/dc/dml/Makefile | 10 +---------
>  1 file changed, 1 insertion(+), 9 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dml/Makefile b/drivers/gpu/drm/amd/display/dc/dml/Makefile
> index 3488af2b5786..b8cadf833e71 100644
> --- a/drivers/gpu/drm/amd/display/dc/dml/Makefile
> +++ b/drivers/gpu/drm/amd/display/dc/dml/Makefile
> @@ -24,15 +24,7 @@
>  # It provides the general basic services required by other DAL
>  # subcomponents.
>
> -CFLAGS_display_mode_vba.o := -mhard-float -msse -mpreferred-stack-boundary=4
> -CFLAGS_display_mode_lib.o := -mhard-float -msse -mpreferred-stack-boundary=4
> -CFLAGS_display_pipe_clocks.o := -mhard-float -msse -mpreferred-stack-boundary=4
> -CFLAGS_display_rq_dlg_calc.o := -mhard-float -msse -mpreferred-stack-boundary=4
> -CFLAGS_dml1_display_rq_dlg_calc.o := -mhard-float -msse -mpreferred-stack-boundary=4
> -CFLAGS_display_rq_dlg_helpers.o := -mhard-float -msse -mpreferred-stack-boundary=4
> -CFLAGS_soc_bounding_box.o := -mhard-float -msse -mpreferred-stack-boundary=4
> -CFLAGS_dml_common_defs.o := -mhard-float -msse -mpreferred-stack-boundary=4
> -
> +subdir-ccflags-y += -mhard-float -msse -mpreferred-stack-boundary=4
>
>  DML = display_mode_lib.o display_rq_dlg_calc.o \
>           display_rq_dlg_helpers.o dml1_display_rq_dlg_calc.o \
> --
> 2.16.0.rc1.238.g530d649a79-goog
>
