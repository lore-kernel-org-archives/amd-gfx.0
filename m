From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>
Subject: Re: [PATCH] drm/radeon: Handle workqueue allocation failure
Date: Fri, 25 Oct 2019 18:06:26 +0200
Message-ID: <5d6a88a2-2719-a859-04df-10b0d893ff39@daenzer.net>
References: <20191025110450.10474-1-will@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191025110450.10474-1-will@kernel.org>
Content-Language: en-CA
Sender: linux-kernel-owner@vger.kernel.org
To: Will Deacon <will@kernel.org>
Cc: amd-gfx@lists.freedesktop.org, David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, Nicolas Waisman <nico@semmle.com>, Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
List-Id: amd-gfx.lists.freedesktop.org

On 2019-10-25 1:04 p.m., Will Deacon wrote:
> In the highly unlikely event that we fail to allocate the "radeon-crtc"
> workqueue, we should bail cleanly rather than blindly march on with a
> NULL pointer installed for the 'flip_queue' field of the 'radeon_crtc'
> structure.
> 
> This was reported previously by Nicolas, but I don't think his fix was
> correct:

Neither is this one I'm afraid. See my feedback on
https://patchwork.freedesktop.org/patch/331534/ .


-- 
Earthling Michel Dänzer               |               https://redhat.com
Libre software enthusiast             |             Mesa and X developer
