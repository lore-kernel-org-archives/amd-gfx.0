From: Markus Elfring <Markus.Elfring@web.de>
Subject: Re: drm/amd/powerplay: remove redundant memset
Date: Mon, 15 Jul 2019 15:22:07 +0200
Message-ID: <d74e5147-7429-8f11-a7dc-389714315e38@web.de>
References: <20190715114332.24634-1-huangfq.daxian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190715114332.24634-1-huangfq.daxian@gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Fuqian Huang <huangfq.daxian@gmail.com>, Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>, Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@linux.ie>, David Zhou <David1.Zhou@amd.com>, Evan Quan <evan.quan@amd.com>, Rex Zhu <rex.zhu@amd.com>
List-Id: amd-gfx.lists.freedesktop.org

> kzalloc has already zeroed the memory.
> So the memset is unneeded.

See also a previous patch:
drm/amd/powerplay: Delete a redundant memory setting in vega20_set_default_od8_setttings()
https://lore.kernel.org/lkml/de3f6a5e-8ac4-bc8e-0d0c-3a4a5db283e9@web.de/
https://lore.kernel.org/patchwork/patch/1089691/
https://lkml.org/lkml/2019/6/17/460

Regards,
Markus
