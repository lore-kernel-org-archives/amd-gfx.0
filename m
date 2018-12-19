From: Souptick Joarder <jrdr.linux@gmail.com>
Subject: Re: [PATCH] drm/amd/display: Remove duplicate header
Date: Wed, 19 Dec 2018 17:18:40 +0530
Message-ID: <CAFqt6zZ6f3wiHWR1jyLBr+8cOwjkQy-8V2zYZx0T1gE7=8Rj7Q@mail.gmail.com>
References: <20181219075713.GA2259@hp-pavilion-15-notebook-pc-brajeswar>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181219075713.GA2259@hp-pavilion-15-notebook-pc-brajeswar>
Sender: linux-kernel-owner@vger.kernel.org
To: Brajeswar Ghosh <brajeswar.linux@gmail.com>
Cc: harry.wentland@amd.com, sunpeng.li@amd.com, "Deucher, Alexander" <alexander.deucher@amd.com>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, "Zhou, David(ChunMing)" <David1.Zhou@amd.com>, airlied@linux.ie, Tony.Cheng@amd.com, Dmytro.Laktyushkin@amd.com, yongqiang.sun@amd.com, eric.bernstein@amd.com, Eric.Yang2@amd.com, Anthony.Koo@amd.com, nikola.cornij@amd.com, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, Sabyasachi Gupta <sabyasachi.linux@gmail.com>
List-Id: amd-gfx.lists.freedesktop.org

On Wed, Dec 19, 2018 at 1:27 PM Brajeswar Ghosh
<brajeswar.linux@gmail.com> wrote:
>
> Remove custom_float.h which is included more than once
>
> Signed-off-by: Brajeswar Ghosh <brajeswar.linux@gmail.com>
> ---
Acked-by: Souptick Joarder <jrdr.linux@gmail.com>

>  drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
> index 193184affefb..3e21c2d26998 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
> @@ -40,7 +40,6 @@
>  #include "ipp.h"
>  #include "mpc.h"
>  #include "reg_helper.h"
> -#include "custom_float.h"
>  #include "dcn10_hubp.h"
>  #include "dcn10_hubbub.h"
>  #include "dcn10_cm_common.h"
> --
> 2.17.1
>
