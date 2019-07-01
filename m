From: Emil Velikov <emil.l.velikov@gmail.com>
Subject: Re: [PATCH v2 07/27] gpu: drm: remove memset after zalloc
Date: Mon, 1 Jul 2019 13:43:16 +0100
Message-ID: <CACvgo52dW16DahT37aAxF8snZSJo_42ie3M0Le_edF19SBYL0Q@mail.gmail.com>
References: <20190628024700.15141-1-huangfq.daxian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190628024700.15141-1-huangfq.daxian@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Fuqian Huang <huangfq.daxian@gmail.com>
Cc: Leo Li <sunpeng.li@amd.com>, Rex Zhu <rex.zhu@amd.com>, David Airlie <airlied@linux.ie>, "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>, amd-gfx mailing list <amd-gfx@lists.freedesktop.org>, Alex Deucher <alexander.deucher@amd.com>, Huang Rui <ray.huang@amd.com>, ML dri-devel <dri-devel@lists.freedesktop.org>, David Francis <David.Francis@amd.com>, Colin Ian King <colin.king@canonical.com>, Evan Quan <evan.quan@amd.com>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
List-Id: amd-gfx.lists.freedesktop.org

Hi Fuqian,

On Fri, 28 Jun 2019 at 09:30, Fuqian Huang <huangfq.daxian@gmail.com> wrote:
>
> zalloc has already zeroed the memory.
> so memset is unneeded.
>
> Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>
> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c       | 2 --
>  drivers/gpu/drm/amd/powerplay/hwmgr/process_pptables_v1_0.c | 2 --
>  drivers/gpu/drm/amd/powerplay/smumgr/ci_smumgr.c            | 2 --
>  drivers/gpu/drm/amd/powerplay/smumgr/iceland_smumgr.c       | 2 --
>  drivers/gpu/drm/amd/powerplay/smumgr/tonga_smumgr.c         | 2 --
>  5 files changed, 10 deletions(-)
>
Thanks for fixing these. One nit pick: the commit message should start
with "drm/amdgpu:" as you can see from git log.
With that:

Reviewed-by: Emil Velikov <emil.velikov@collabora.com>

-Emil
