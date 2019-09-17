From: Alex Deucher <alexdeucher@gmail.com>
Subject: Re: [PATCH] drm/amd/display: Restore backlight brightness after
 system resume
Date: Tue, 17 Sep 2019 08:32:23 -0400
Message-ID: <CADnq5_NtPXA-87MU-nmnT4t4+cjgJfR7VbyRxYCpSH9YXE4RUA@mail.gmail.com>
References: <20190902083342.27393-1-kai.heng.feng@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20190902083342.27393-1-kai.heng.feng@canonical.com>
Sender: stable-owner@vger.kernel.org
To: Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc: "Wentland, Harry" <harry.wentland@amd.com>, "Leo (Sunpeng) Li" <sunpeng.li@amd.com>, "Deucher, Alexander" <alexander.deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, Chunming Zhou <David1.Zhou@amd.com>, "for 3.8" <stable@vger.kernel.org>, Maling list - DRI developers <dri-devel@lists.freedesktop.org>, amd-gfx list <amd-gfx@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: amd-gfx.lists.freedesktop.org

Applied.  Thanks!

Alex

On Mon, Sep 2, 2019 at 4:16 PM Kai-Heng Feng
<kai.heng.feng@canonical.com> wrote:
>
> Laptops with AMD APU doesn't restore display backlight brightness after
> system resume.
>
> This issue started when DC was introduced.
>
> Let's use BL_CORE_SUSPENDRESUME so the backlight core calls
> update_status callback after system resume to restore the backlight
> level.
>
> Tested on Dell Inspiron 3180 (Stoney Ridge) and Dell Latitude 5495
> (Raven Ridge).
>
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 1b0949dd7808..183ef18ac6f3 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -2111,6 +2111,7 @@ static int amdgpu_dm_backlight_get_brightness(struct backlight_device *bd)
>  }
>
>  static const struct backlight_ops amdgpu_dm_backlight_ops = {
> +       .options = BL_CORE_SUSPENDRESUME,
>         .get_brightness = amdgpu_dm_backlight_get_brightness,
>         .update_status  = amdgpu_dm_backlight_update_status,
>  };
> --
> 2.17.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
