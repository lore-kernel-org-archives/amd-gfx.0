From: Sven Van Asbroeck <thesven73@gmail.com>
Subject: Re: [PATCH v2] drm/amdgpu: fix multiple memory leaks
Date: Wed, 18 Sep 2019 15:45:32 -0400
Message-ID: <CAGngYiUJYUGN9CA1smKvy3GF=HWEXtaSdCZHEK64A_63edqF6A@mail.gmail.com>
References: <7bab24ff-ded7-9f76-ba25-efd07cdd30dd@amd.com> <20190918190529.17298-1-navid.emamdoost@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190918190529.17298-1-navid.emamdoost@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Navid Emamdoost <navid.emamdoost@gmail.com>
Cc: Christian.Koenig@amd.com, emamd001@umn.edu, smccaman@umn.edu, kjlu@umn.edu, Alex Deucher <alexander.deucher@amd.com>, "David (ChunMing) Zhou" <David1.Zhou@amd.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, Rex Zhu <Rex.Zhu@amd.com>, Sam Ravnborg <sam@ravnborg.org>, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: amd-gfx.lists.freedesktop.org

On Wed, Sep 18, 2019 at 3:09 PM Navid Emamdoost
<navid.emamdoost@gmail.com> wrote:
>
>         i2s_pdata = kcalloc(3, sizeof(struct i2s_platform_data), GFP_KERNEL);
>         if (i2s_pdata == NULL) {
> -               kfree(adev->acp.acp_res);
> -               kfree(adev->acp.acp_cell);
> -               return -ENOMEM;
> +               ret = -ENOMEM;
> +               goto out3;
>         }

I don't see a corresponding kfree() for i2s_pdata in acp_hw_fini().
Could this be a memory leak?
