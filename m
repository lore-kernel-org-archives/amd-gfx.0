From: Emil Velikov <emil.l.velikov@gmail.com>
Subject: Re: [PATCH 06/30] drm/amdgpu: Use kmemdup rather than duplicating its implementation
Date: Wed, 3 Jul 2019 16:21:45 +0100
Message-ID: <CACvgo52wa8FzddSB09WoBCfR=Jdb-AD1G3_siB7c2nWWtmdpGg@mail.gmail.com>
References: <20190703131414.24947-1-huangfq.daxian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190703131414.24947-1-huangfq.daxian@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Fuqian Huang <huangfq.daxian@gmail.com>
Cc: David Zhou <David1.Zhou@amd.com>, David Airlie <airlied@linux.ie>, "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>, amd-gfx mailing list <amd-gfx@lists.freedesktop.org>, Leo Li <sunpeng.li@amd.com>, ML dri-devel <dri-devel@lists.freedesktop.org>, Daniel Vetter <daniel@ffwll.ch>, Alex Deucher <alexander.deucher@amd.com>, Harry Wentland <harry.wentland@amd.com>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
List-Id: amd-gfx.lists.freedesktop.org

On Wed, 3 Jul 2019 at 14:15, Fuqian Huang <huangfq.daxian@gmail.com> wrote:
>
> kmemdup is introduced to duplicate a region of memory in a neat way.
> Rather than kmalloc/kzalloc + memset, which the programmer needs to
> write the size twice (sometimes lead to mistakes), kmemdup improves
> readability, leads to smaller code and also reduce the chances of mistakes.
> Suggestion to use kmemdup rather than using kmalloc/kzalloc + memset.
>
> Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>
Fuqian please add reviewed-by and other tags when sending new revisions.

Fwiw the patch is:
Reviewed-by: Emil Velikov <emil.velikov@collabora.com>

-Emil
