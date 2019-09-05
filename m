From: Markus Elfring <Markus.Elfring@web.de>
Subject: Re: [v2] drm/amdgpu: Remove two redundant null pointer checks
Date: Thu, 5 Sep 2019 10:23:32 +0200
Message-ID: <d1aee32e-c9ad-2953-84c0-267037a82288@web.de>
References: <1567662552-3583-1-git-send-email-zhongjiang@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1567662552-3583-1-git-send-email-zhongjiang@huawei.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: zhong jiang <zhongjiang@huawei.com>, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>, Chunming Zhou <David1.Zhou@amd.com>, Dan Carpenter <dan.carpenter@oracle.com>, Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@linux.ie>, Hawking Zhang <Hawking.Zhang@amd.com>, Jack Xiao <Jack.Xiao@amd.com>, Kevin Wang <Kevin1.Wang@amd.com>, Tom St Denis <tom.stdenis@amd.com>, Wang Xiayang <xywang.sjtu@sjtu.edu.cn>
Cc: linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
List-Id: amd-gfx.lists.freedesktop.org

> The functions "debugfs_remove" and "kfree" tolerate the passing
> of null pointers. Hence it is unnecessary to check such arguments
> around the calls. Thus remove the extra condition check at two places.

Will a tag like =E2=80=9CGenerated-by: scripts/coccinelle/free/ifnullfree.=
cocci=E2=80=9D be relevant here?

How do you think about to compare this change approach with another patch =
variant?

drm/amdgpu: Delete an unnecessary check before two function calls
https://lkml.org/lkml/2019/9/4/401
https://lore.kernel.org/patchwork/patch/1123689/
https://lore.kernel.org/r/a3739125-5fa8-cadb-d2b8-8a9f12e9bacd@web.de/

Regards,
Markus
