From: Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH] drm/amdgpu/pm: Remove VLA usage
Date: Mon, 16 Jul 2018 20:59:07 -0700
Message-ID: <CAGXu5jK74ew7iTw2_OqJSj4wYjBggPpkN-ENEFRpuq0C-eGRDg@mail.gmail.com>
References: <20180620182647.GA24405@beast>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180620182647.GA24405@beast>
Sender: linux-kernel-owner@vger.kernel.org
To: Alex Deucher <alexander.deucher@amd.com>
Cc: LKML <linux-kernel@vger.kernel.org>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, "David (ChunMing) Zhou" <David1.Zhou@amd.com>, David Airlie <airlied@linux.ie>, Rex Zhu <Rex.Zhu@amd.com>, Huang Rui <ray.huang@amd.com>, Felix Kuehling <Felix.Kuehling@amd.com>, amd-gfx list <amd-gfx@lists.freedesktop.org>, Maling list - DRI developers <dri-devel@lists.freedesktop.org>
List-Id: amd-gfx.lists.freedesktop.org

On Wed, Jun 20, 2018 at 11:26 AM, Kees Cook <keescook@chromium.org> wrote:
> In the quest to remove all stack VLA usage from the kernel[1], this
> uses the maximum sane buffer size and removes copy/paste code.
>
> [1] https://lkml.kernel.org/r/CA+55aFzCG-zNmZwX4A2FQpadafLfEzK6CC=qPXydAacU1RqZWA@mail.gmail.com
>
> Signed-off-by: Kees Cook <keescook@chromium.org>

Friendly ping! Who's tree should this go through?

Thanks!

-Kees

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c | 100 +++++++++++--------------
>  1 file changed, 42 insertions(+), 58 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
> index b455da487782..5eb98cde22ed 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
> @@ -593,40 +593,59 @@ static ssize_t amdgpu_get_pp_dpm_sclk(struct device *dev,
>                 return snprintf(buf, PAGE_SIZE, "\n");
>  }
>
> -static ssize_t amdgpu_set_pp_dpm_sclk(struct device *dev,
> -               struct device_attribute *attr,
> -               const char *buf,
> -               size_t count)
> +/*
> + * Worst case: 32 bits individually specified, in octal at 12 characters
> + * per line (+1 for \n).
> + */
> +#define AMDGPU_MASK_BUF_MAX    (32 * 13)
> +
> +static ssize_t amdgpu_read_mask(const char *buf, size_t count, uint32_t *mask)
>  {
> -       struct drm_device *ddev = dev_get_drvdata(dev);
> -       struct amdgpu_device *adev = ddev->dev_private;
>         int ret;
>         long level;
> -       uint32_t mask = 0;
>         char *sub_str = NULL;
>         char *tmp;
> -       char buf_cpy[count];
> +       char buf_cpy[AMDGPU_MASK_BUF_MAX + 1];
>         const char delimiter[3] = {' ', '\n', '\0'};
> +       size_t bytes;
>
> -       memcpy(buf_cpy, buf, count+1);
> +       *mask = 0;
> +
> +       bytes = min(count, sizeof(buf_cpy) - 1);
> +       memcpy(buf_cpy, buf, bytes);
> +       buf_cpy[bytes] = '\0';
>         tmp = buf_cpy;
>         while (tmp[0]) {
> -               sub_str =  strsep(&tmp, delimiter);
> +               sub_str = strsep(&tmp, delimiter);
>                 if (strlen(sub_str)) {
>                         ret = kstrtol(sub_str, 0, &level);
> -
> -                       if (ret) {
> -                               count = -EINVAL;
> -                               goto fail;
> -                       }
> -                       mask |= 1 << level;
> +                       if (ret)
> +                               return -EINVAL;
> +                       *mask |= 1 << level;
>                 } else
>                         break;
>         }
> +
> +       return 0;
> +}
> +
> +static ssize_t amdgpu_set_pp_dpm_sclk(struct device *dev,
> +               struct device_attribute *attr,
> +               const char *buf,
> +               size_t count)
> +{
> +       struct drm_device *ddev = dev_get_drvdata(dev);
> +       struct amdgpu_device *adev = ddev->dev_private;
> +       int ret;
> +       uint32_t mask = 0;
> +
> +       ret = amdgpu_read_mask(buf, count, &mask);
> +       if (ret)
> +               return ret;
> +
>         if (adev->powerplay.pp_funcs->force_clock_level)
>                 amdgpu_dpm_force_clock_level(adev, PP_SCLK, mask);
>
> -fail:
>         return count;
>  }
>
> @@ -651,32 +670,15 @@ static ssize_t amdgpu_set_pp_dpm_mclk(struct device *dev,
>         struct drm_device *ddev = dev_get_drvdata(dev);
>         struct amdgpu_device *adev = ddev->dev_private;
>         int ret;
> -       long level;
>         uint32_t mask = 0;
> -       char *sub_str = NULL;
> -       char *tmp;
> -       char buf_cpy[count];
> -       const char delimiter[3] = {' ', '\n', '\0'};
>
> -       memcpy(buf_cpy, buf, count+1);
> -       tmp = buf_cpy;
> -       while (tmp[0]) {
> -               sub_str =  strsep(&tmp, delimiter);
> -               if (strlen(sub_str)) {
> -                       ret = kstrtol(sub_str, 0, &level);
> +       ret = amdgpu_read_mask(buf, count, &mask);
> +       if (ret)
> +               return ret;
>
> -                       if (ret) {
> -                               count = -EINVAL;
> -                               goto fail;
> -                       }
> -                       mask |= 1 << level;
> -               } else
> -                       break;
> -       }
>         if (adev->powerplay.pp_funcs->force_clock_level)
>                 amdgpu_dpm_force_clock_level(adev, PP_MCLK, mask);
>
> -fail:
>         return count;
>  }
>
> @@ -701,33 +703,15 @@ static ssize_t amdgpu_set_pp_dpm_pcie(struct device *dev,
>         struct drm_device *ddev = dev_get_drvdata(dev);
>         struct amdgpu_device *adev = ddev->dev_private;
>         int ret;
> -       long level;
>         uint32_t mask = 0;
> -       char *sub_str = NULL;
> -       char *tmp;
> -       char buf_cpy[count];
> -       const char delimiter[3] = {' ', '\n', '\0'};
> -
> -       memcpy(buf_cpy, buf, count+1);
> -       tmp = buf_cpy;
>
> -       while (tmp[0]) {
> -               sub_str =  strsep(&tmp, delimiter);
> -               if (strlen(sub_str)) {
> -                       ret = kstrtol(sub_str, 0, &level);
> +       ret = amdgpu_read_mask(buf, count, &mask);
> +       if (ret)
> +               return ret;
>
> -                       if (ret) {
> -                               count = -EINVAL;
> -                               goto fail;
> -                       }
> -                       mask |= 1 << level;
> -               } else
> -                       break;
> -       }
>         if (adev->powerplay.pp_funcs->force_clock_level)
>                 amdgpu_dpm_force_clock_level(adev, PP_PCIE, mask);
>
> -fail:
>         return count;
>  }
>
> --
> 2.17.1
>
>
> --
> Kees Cook
> Pixel Security



-- 
Kees Cook
Pixel Security
