From: Helen Koike <helen.koike@collabora.com>
Subject: Re: [PATCH v3 2/4] drm/atomic: rename async_{update,check} to
 amend_{update,check}
Date: Fri, 12 Apr 2019 11:06:13 -0300
Message-ID: <bda69249-f193-9dbc-5186-7139fb2c365a@collabora.com>
References: <20190412125827.5877-1-helen.koike@collabora.com>
 <20190412125827.5877-3-helen.koike@collabora.com>
 <20190412154957.558e49f8@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190412154957.558e49f8@collabora.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Boris Brezillon <boris.brezillon@collabora.com>
Cc: dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>, dnicoara@chromium.org, daniels@collabora.com, alexandros.frantzis@collabora.com, daniel.vetter@ffwll.ch, linux-kernel@vger.kernel.org, tomasz Figa <tfiga@chromium.org>, tina.zhang@intel.com, Sean Paul <seanpaul@google.com>, kernel@collabora.com, nicholas.kazlauskas@amd.com, =?UTF-8?Q?St=c3=a9phane_Marchesin?= <marcheu@google.com>, Gustavo Padovan <gustavo.padovan@collabora.com>, Sean Paul <sean@poorly.run>, Sandy Huang <hjc@rock-chips.com>, linux-doc@vger.kernel.org, Thomas Zimmermann <tzimmermann@suse.de>, Jonathan Corbet <corbet@lwn.net>, Harry Wentland <harry.wentland@amd.com>, Alex Deucher <alexander.deucher@amd.com>, Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>, "David (ChunMing) Zhou" <David1.Zhou@amd.>
List-Id: amd-gfx.lists.freedesktop.org

Hi Boris,

On 4/12/19 10:49 AM, Boris Brezillon wrote:
> Hi Helen,
> 
> On Fri, 12 Apr 2019 09:58:25 -0300
> Helen Koike <helen.koike@collabora.com> wrote:
> 
>> Asynchronous update is the ability change the hw state at any time, not
>> only during vblank.
>>
>> Amend mode is the ability to perform 1000 commits to be applied as soon
>> as possible without waiting for 1000 vblanks.
>>
>> async updates can be seen as amend, but the opposite is not true.
>>
>> &drm_plane_helper_funcs.atomic_async_{update,check}() was being used by
>> drivers to implement amend and not async. So rename them to amend.
>>
>> Also improve docs explaining the difference.
>>
>> If asynchronous is required, normal page flip can be performed using
>> DRM_MODE_PAGE_FLIP_ASYNC flag.
>>
>> Signed-off-by: Helen Koike <helen.koike@collabora.com>
>>
>> ---
>> Hello,
>>
>> I would like to officially clarify what async update means by adding it
>> in the docs.
>> Please correct me if I am wrong, but the current async_{update,check}
>> callbacks are being used to do amend (the legacy cursor behavior), i.e.
>> to allow 1000 updates without waiting for 1000 vblanks.
> 
> Right now, the semantic of async update is driver dependent. Some
> drivers will amend the last commit touching that plane (amend semantic),
> others will update the plane buffer immediately which might cause
> tearing (async semantic).

In my pov, async updates holds the properties of an amend update, so all
async updates we have are amend, but the opposite is not true.

> 
>>
>> So I would like to clarify this in the docs and rename the current
>> callbacks to reflect this behaviour.
> 
> I'm all for this clarification, but I don't think renaming the async
> hooks is a good idea, since some drivers will not do real 'amend'. So,
> you're changing the name, but it's still confusing :-).
> 
> How about adding new hooks (and/or flags) for the AMEND case, and
> keeping the async path untouched. We can then let drivers that
> currently implement async as amend implement the amend hooks instead.
> Once you've done that, you can hook that up to the legacy cursor update
> path so that it first tries one then the other and finally falls back
> to a sync update if none of ASYNC/AMEND is possible.

I kinda did this (I re-introduced async in the last patch in the
series). I know this order is confusing, but as rockchip doesn't
implement true async, I would have to do a bunch of modifs at once to
keep the commits consistent, but I can re-work on that if it makes
things clearer.

> 
>>
>> I also see that for real async updates, the flag
>> DRM_MODE_PAGE_FLIP_ASYNC can be used in a normal sync update (it is
>> already being used by some drivers actually, in the atomic path, not only
>> in the legacy page flip, at least is what I understood from
>> amdgpu_dm_atomic_commit_tail() implementation).
> 
> Yes, right now, async does not necessarily imply non-block, but
> Daniel seemed to think that most users want non-block when they do an
> async page flip, so maybe it should be clarified too.

users could combine NONBLOCK flag with PAGE_FLIP_ASYNC, no? (we need to
add code for it of course).

Thanks
Helen

> 
> Regards,
> 
> Boris
> 
