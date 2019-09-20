From: Randy Dunlap <rdunlap@infradead.org>
Subject: Re: linux-next: Tree for Sep 20 (amdgpu-2)
Date: Fri, 20 Sep 2019 15:35:56 -0700
Message-ID: <797e0870-bab3-2716-119c-c06735354506@infradead.org>
References: <20190920163637.GI3822@sirena.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190920163637.GI3822@sirena.co.uk>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Linux Next Mailing List <linux-next@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, dri-devel <dri-devel@lists.freedesktop.org>
List-Id: amd-gfx.lists.freedesktop.org

On 9/20/19 9:36 AM, Mark Brown wrote:
> Hi all,
> 
> News: There will likely be no more -next builds until Stephen returns on
> the 30th, I *may* do some next week but it's more likely that I won't
> and it certainly won't be every day.
> 
> Changes since 20190919:
> 

on x86_64:

(1) where is function get_wm_urgent() defined?  I cannot find it (i.e.,
grep cannot find it).

../drivers/gpu/drm/amd/amdgpu/../display/dc/dcn21/dcn21_resource.c: In function ‘calculate_wm_set_for_vlevel’:
../drivers/gpu/drm/amd/amdgpu/../display/dc/dcn21/dcn21_resource.c:964:22: error: SSE register return with SSE disabled
  wm_set->urgent_ns = get_wm_urgent(dml, pipes, pipe_cnt) * 1000;
                      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

(2) drivers/gpu/drm/amd/amdgpu/../display/dc/dcn21/dcn21_resource.c needs
#include <linux/slab.h>
for the kzalloc() and kfree() function calls.


Thanks.
-- 
~Randy
