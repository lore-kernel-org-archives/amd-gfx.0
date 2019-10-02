From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: Re: [PATCH] drm/amdgpu: fix structurally dead code vcn_v2_5_hw_init
Date: Wed, 2 Oct 2019 08:32:18 -0500
Message-ID: <36766293-28b1-8903-bde8-5f04082c8b89@embeddedor.com>
References: <20191001171635.GA17306@embeddedor>
 <192815d9-5ecb-09a7-4624-5fd36126890d@amd.com>
 <823b10a3-fe0e-2e8c-02c3-534944dbe6d2@embeddedor.com>
 <dc76a52b-09a2-7ab9-b53e-52500f4f8669@amd.com>
 <3c6ebf4a-8cba-40e2-7d70-c4d5006a160b@embeddedor.com>
 <23314fce-800c-552f-e879-464f9709d12b@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <23314fce-800c-552f-e879-464f9709d12b@amd.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "Liu, Leo" <Leo.Liu@amd.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian" <Christian.Koenig@amd.com>, "Zhou, David(ChunMing)" <David1.Zhou@amd.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: amd-gfx.lists.freedesktop.org



On 10/1/19 17:21, Liu, Leo wrote:

>>>> OK. So, maybe we can add a comment pointing that out?
>>> That could be better.
>>>
>> Great. I'm glad it's not a bug.  I'll write a patch for that so other
>> people don't waste time taking a look.
> 
> Thanks, just sent two patches to add comment, and long with the patch to 
> make VCN ring ready properly.
> 

Awesome. Thank you. I would just add a commit log to this patch:

[PATCH 2/2] drm/amdgpu: add a comment to VCN 2.5 encode ring

I'd update the subject to: drm/amdgpu: add code comment in vcn_v2_5_hw_init
and add this as a commit log: Add a comment to VCN 2.5 encode ring

Also, I think it's important to follow the process and CC all the people and lists
below:

$ scripts/get_maintainer.pl --nokeywords --nogit --nogit-fallback drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
Alex Deucher <alexander.deucher@amd.com> (supporter:RADEON and AMDGPU DRM DRIVERS)
"Christian König" <christian.koenig@amd.com> (supporter:RADEON and AMDGPU DRM DRIVERS)
"David (ChunMing) Zhou" <David1.Zhou@amd.com> (supporter:RADEON and AMDGPU DRM DRIVERS)
David Airlie <airlied@linux.ie> (maintainer:DRM DRIVERS)
Daniel Vetter <daniel@ffwll.ch> (maintainer:DRM DRIVERS)
amd-gfx@lists.freedesktop.org (open list:RADEON and AMDGPU DRM DRIVERS)
dri-devel@lists.freedesktop.org (open list:DRM DRIVERS)
linux-kernel@vger.kernel.org (open list)

Thanks
--
Gustavo
