From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>
Subject: Re: Linux 4.11: Reported regressions as of Tuesday, 20176-03-14
Date: Wed, 15 Mar 2017 10:59:42 +0900
Message-ID: <a0495348-acd8-f28d-e144-80ac79dccc3b@daenzer.net>
References: <5d399102-c648-7a87-1dff-f8b74c12ceaa@leemhuis.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5d399102-c648-7a87-1dff-f8b74c12ceaa@leemhuis.info>
Sender: linux-kernel-owner@vger.kernel.org
To: Thorsten Leemhuis <regressions@leemhuis.info>
Cc: amd-gfx@lists.freedesktop.org
List-Id: amd-gfx.lists.freedesktop.org


[ Moving this sub-thread to the amd-gfx mailing list ]

On 14/03/17 07:02 PM, Thorsten Leemhuis wrote:
> Hi! Find below my first regression report for Linux 4.11. It lists 9
> regressions I'm currently aware of.

[...]

> Desc: DRM BUG while initializing cape verde (2nd card)
> Repo: 2017-03-13 https://bugzilla.kernel.org/show_bug.cgi?id=194867
> Stat: n/a 
> Note: patch proposed by reporter

I don't see any patch.

Looks like the amdgpu driver has never fully initialized GDS support for
SI family GPUs, and this now triggers the DRM_MM_BUG_ON which was added
to drm_mm_init in 4.11.

AMD folks, should this be addressed by fleshing out SI GDS support, or
by completely disabling GDS initialization for SI?


-- 
Earthling Michel Dänzer               |               http://www.amd.com
Libre software enthusiast             |             Mesa and X developer
