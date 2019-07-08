From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 2/2] amdgpu: make SOC15/navi support conditional
Date: Mon, 8 Jul 2019 18:08:21 +0200
Message-ID: <CAK8P3a1m-aDAsiVFYyQcoq0a=Y8rA5R3P5TSuBfmK2Gync-8eQ@mail.gmail.com>
References: <20190708144205.2770771-1-arnd@arndb.de> <20190708144205.2770771-2-arnd@arndb.de>
 <CADnq5_MFi1cGxo-AGMcGzY4nW8HAuX8SiPfAD=eRrdo0w-aoJQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CADnq5_MFi1cGxo-AGMcGzY4nW8HAuX8SiPfAD=eRrdo0w-aoJQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Alex Deucher <alexdeucher@gmail.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, "David (ChunMing) Zhou" <David1.Zhou@amd.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, Oded Gabbay <oded.gabbay@gmail.com>, Philip Yang <Philip.Yang@amd.com>, Jack Xiao <Jack.Xiao@amd.com>, Evan Quan <evan.quan@amd.com>, Yong Zhao <Yong.Zhao@amd.com>, Amber Lin <Amber.Lin@amd.com>, Feifei Xu <Feifei.Xu@amd.com>, Felix Kuehling <Felix.Kuehling@amd.com>, xinhui pan <xinhui.pan@amd.com>, LKML <linux-kernel@vger.kernel.org>, amd-gfx list <amd-gfx@lists.freedesktop.org>, Emily Deng <Emily.Deng@amd.com>, Huang Rui <ray.huang@amd.com>, Maling list - DRI developers <dri-devel@lists.freedesktop.org>, Rex Zhu <Rex.Zhu@amd.com>, Thom
List-Id: amd-gfx.lists.freedesktop.org

On Mon, Jul 8, 2019 at 4:46 PM Alex Deucher <alexdeucher@gmail.com> wrote:
>
> On Mon, Jul 8, 2019 at 10:42 AM Arnd Bergmann <arnd@arndb.de> wrote:
> >
> > Enabling amdgpu but not CONFIG_DRM_AMD_DC leads to a warning:
> >
> > drivers/gpu/drm/amd/amdgpu/nv.c: In function 'nv_set_ip_blocks':
> > drivers/gpu/drm/amd/amdgpu/nv.c:400:3: error: #warning "Enable CONFIG_DRM_AMD_DC for display support on navi." [-Werror=cpp]
> >  # warning "Enable CONFIG_DRM_AMD_DC for display support on navi."
> >    ^~~~~~~
> > drivers/gpu/drm/amd/amdgpu/soc15.c: In function 'soc15_set_ip_blocks':
> > drivers/gpu/drm/amd/amdgpu/soc15.c:653:3: error: #warning "Enable CONFIG_DRM_AMD_DC for display support on SOC15." [-Werror=cpp]
> >
> > However, CONFIG_DRM_AMD_DC can only be enabled on x86, so we
> > cannot do that when building for other architectures.
>
> DC is not limited to x86.

Ah, right, only DRM_AMD_DC_DCN1_0 is x86-only.

>  I can drop the warning if that is the concern.

That would be great, yes.

      Arnd
