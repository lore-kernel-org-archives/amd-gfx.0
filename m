From: Markus Elfring <Markus.Elfring@web.de>
Subject: Re: drm/amdgpu: remove the redundant null check
Date: Wed, 4 Sep 2019 19:50:35 +0200
Message-ID: <62b33279-9ca9-5970-5336-a8511ce54197@web.de>
References: <1567491305-18320-1-git-send-email-zhongjiang@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1567491305-18320-1-git-send-email-zhongjiang@huawei.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: zhong jiang <zhongjiang@huawei.com>, Chunming Zhou <David1.Zhou@amd.com>, David Airlie <airlied@linux.ie>, Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>, Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
List-Id: amd-gfx.lists.freedesktop.org

> debugfs_remove and kfree has taken the null check in account.
> hence it is unnecessary to check it. Just remove the condition.

How do you think about a wording like the following?

  The functions =E2=80=9Cdebugfs_remove=E2=80=9D and =E2=80=9Ckfree=E2=80=
=9D tolerate the passing
  of null pointers. Hence it is unnecessary to check such arguments
  around the calls. Thus remove the extra condition check at two places.


> No functional change.

I find this information questionable while it is partly reasonable
according to the shown software refactoring.

Can a subject like =E2=80=9C[PATCH] drm/amdgpu: Remove two redundant
null pointer checks=E2=80=9D be nicer here?


Were any source code analysis tools involved for finding
these update candidates?

Regards,
Markus
