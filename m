From: Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH] drm/amdgpu: Add braces to initialize task_info subojects
Date: Wed, 12 Sep 2018 10:38:30 -0700
Message-ID: <CAKwvOdkMg_1JxVNhKrUM0CZxF6nQo8c5h7t4zu4RP2xEXyQdKQ@mail.gmail.com>
References: <20180912002559.1853-1-natechancellor@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180912002559.1853-1-natechancellor@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nathan Chancellor <natechancellor@gmail.com>
Cc: alexander.deucher@amd.com, christian.koenig@amd.com, David1.Zhou@amd.com, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, LKML <linux-kernel@vger.kernel.org>, Richard Smith <richardsmith@google.com>
List-Id: amd-gfx.lists.freedesktop.org

On Tue, Sep 11, 2018 at 5:26 PM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> Clang warns if there are missing braces around a subobject
> initializer.
>
> drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c:1447:41: warning: suggest braces
> around initialization of subobject [-Wmissing-braces]
>                 struct amdgpu_task_info task_info = { 0 };
>                                                       ^
>                                                       {}
> 1 warning generated.
>
> drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c:262:41: warning: suggest braces
> around initialization of subobject [-Wmissing-braces]
>                 struct amdgpu_task_info task_info = { 0 };
>                                                       ^
>                                                       {}
> 1 warning generated.
>
> Reported-by: Nick Desaulniers <ndesaulniers@google.com>
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c | 2 +-
>  drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
> index 9333109b210d..968cc1b8cdff 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
> @@ -1444,7 +1444,7 @@ static int gmc_v8_0_process_interrupt(struct amdgpu_device *adev,
>                 gmc_v8_0_set_fault_enable_default(adev, false);
>
>         if (printk_ratelimit()) {
> -               struct amdgpu_task_info task_info = { 0 };
> +               struct amdgpu_task_info task_info = { { 0 } };

Hi Nathan,
Thanks for this patch.  I discussed this syntax with our language
lawyers.  Turns out, this is not quite correct, as you're now saying
"initialize the first subobject to zero, but not the rest of the
object."  -Wmissing-field-initializers would highlight this, but it's
not part of -Wall.  It would be more correct to zero initialize the
full struct, including all of its subobjects with `= {};`.

>
>                 amdgpu_vm_get_task_info(adev, entry->pasid, &task_info);
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> index 72f8018fa2a8..a781a5027212 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> @@ -259,7 +259,7 @@ static int gmc_v9_0_process_interrupt(struct amdgpu_device *adev,
>         }
>
>         if (printk_ratelimit()) {
> -               struct amdgpu_task_info task_info = { 0 };
> +               struct amdgpu_task_info task_info = { { 0 } };
>
>                 amdgpu_vm_get_task_info(adev, entry->pasid, &task_info);
>
> --
> 2.18.0
>


-- 
Thanks,
~Nick Desaulniers
