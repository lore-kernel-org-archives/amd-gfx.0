From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Subject: Re: The issue with page allocation 5.3 rc1-rc2 (seems drm culprit here)
Date: Mon, 5 Aug 2019 22:14:47 +0500
Message-ID: <CABXGCsM3-Ax0jsLS=QCM6m331onGXLEcfmmc_kLdqgOLzMSj9Q@mail.gmail.com>
References: <20190805032114.8740-1-hdanton@sina.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190805032114.8740-1-hdanton@sina.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Hillf Danton <hdanton@sina.com>
Cc: Dave Airlie <airlied@gmail.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian" <Christian.Koenig@amd.com>, Harry Wentland <harry.wentland@amd.com>, amd-gfx list <amd-gfx@lists.freedesktop.org>, Linux Memory Management List <linux-mm@kvack.org>, Linux List Kernel Mailing <linux-kernel@vger.kernel.org>, dri-devel <dri-devel@lists.freedesktop.org>
List-Id: amd-gfx.lists.freedesktop.org

On Mon, 5 Aug 2019 at 08:21, Hillf Danton <hdanton@sina.com> wrote:
>
>
>
> Try to fix the failure above using vmalloc + kmalloc.
>
> --- a/drivers/gpu/drm/amd/display/dc/core/dc.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
> @@ -1174,8 +1174,12 @@ struct dc_state *dc_create_state(struct
>         struct dc_state *context = kzalloc(sizeof(struct dc_state),
>                                            GFP_KERNEL);
>
> -       if (!context)
> -               return NULL;
> +       if (!context) {
> +               context = kvzalloc(sizeof(struct dc_state),
> +                                          GFP_KERNEL);
> +               if (!context)
> +                       return NULL;
> +       }
>         /* Each context must have their own instance of VBA and in order to
>          * initialize and obtain IP and SOC the base DML instance from DC is
>          * initially copied into every context
> @@ -1195,8 +1199,13 @@ struct dc_state *dc_copy_state(struct dc
>         struct dc_state *new_ctx = kmemdup(src_ctx,
>                         sizeof(struct dc_state), GFP_KERNEL);
>
> -       if (!new_ctx)
> -               return NULL;
> +       if (!new_ctx) {
> +               new_ctx = kvmalloc(sizeof(*new_ctx), GFP_KERNEL);
> +               if (new_ctx)
> +                       *new_ctx = *src_ctx;
> +               else
> +                       return NULL;
> +       }
>
>         for (i = 0; i < MAX_PIPES; i++) {
>                         struct pipe_ctx *cur_pipe = &new_ctx->res_ctx.pipe_ctx[i];
> @@ -1230,7 +1239,7 @@ static void dc_state_free(struct kref *k
>  {
>         struct dc_state *context = container_of(kref, struct dc_state, refcount);
>         dc_resource_state_destruct(context);
> -       kfree(context);
> +       kvfree(context);
>  }
>
>  void dc_release_state(struct dc_state *context)
> --

Unfortunately couldn't check this patch because, with the patch, the
kernel did not compile.
Here is compile error messages:

drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc.c: In function
'dc_create_state':
drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc.c:1178:13: error:
implicit declaration of function 'kvzalloc'; did you mean 'kzalloc'?
[-Werror=implicit-function-declaration]
 1178 |   context = kvzalloc(sizeof(struct dc_state),
      |             ^~~~~~~~
      |             kzalloc
drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc.c:1178:11: warning:
assignment to 'struct dc_state *' from 'int' makes pointer from
integer without a cast [-Wint-conversion]
 1178 |   context = kvzalloc(sizeof(struct dc_state),
      |           ^
drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc.c: In function 'dc_copy_state':
drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc.c:1203:13: error:
implicit declaration of function 'kvmalloc'; did you mean 'kmalloc'?
[-Werror=implicit-function-declaration]
 1203 |   new_ctx = kvmalloc(sizeof(*new_ctx), GFP_KERNEL);
      |             ^~~~~~~~
      |             kmalloc
drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc.c:1203:11: warning:
assignment to 'struct dc_state *' from 'int' makes pointer from
integer without a cast [-Wint-conversion]
 1203 |   new_ctx = kvmalloc(sizeof(*new_ctx), GFP_KERNEL);
      |           ^
drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc.c: In function 'dc_state_free':
drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc.c:1242:2: error:
implicit declaration of function 'kvfree'; did you mean 'kzfree'?
[-Werror=implicit-function-declaration]
 1242 |  kvfree(context);
      |  ^~~~~~
      |  kzfree
cc1: some warnings being treated as errors
make[4]: *** [scripts/Makefile.build:274:
drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc.o] Error 1
make[4]: *** Waiting for unfinished jobs....
make[3]: *** [scripts/Makefile.build:490: drivers/gpu/drm/amd/amdgpu] Error 2
make[3]: *** Waiting for unfinished jobs....
make: *** [Makefile:1084: drivers] Error 2


--
Best Regards,
Mike Gavrilov.
