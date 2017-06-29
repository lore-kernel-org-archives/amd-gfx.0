From: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Subject: Re: [PATCH] drm/radeon: add header comment for clarification to
 vce_v2_0_enable_mgcg()
Date: Thu, 29 Jun 2017 14:52:17 -0500
Message-ID: <20170629145217.Horde.s0Lc3y1UFt_0nnWLWEj95xk@gator4166.hostgator.com>
References: <CADnq5_NhSDyBRSTpYEnBnSNG1AC=W_bHew-VcU1MxzaBcAURnQ@mail.gmail.com>
 <20170629173837.GA3397@embeddedgus>
 <CADnq5_NmU1FTFqRO8Ye+DXZrCAvJ0hOsz8YX7uU9SM+LGiMtWA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed; DelSp=Yes
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CADnq5_NmU1FTFqRO8Ye+DXZrCAvJ0hOsz8YX7uU9SM+LGiMtWA@mail.gmail.com>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Alex Deucher <alexdeucher@gmail.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, Christian =?utf-8?b?S8O2bmln?= <christian.koenig@amd.com>, David Airlie <airlied@linux.ie>, amd-gfx list <amd-gfx@lists.freedesktop.org>, Maling list - DRI developers <dri-devel@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: amd-gfx.lists.freedesktop.org


Quoting Alex Deucher <alexdeucher@gmail.com>:

> On Thu, Jun 29, 2017 at 1:38 PM, Gustavo A. R. Silva
> <garsilva@embeddedor.com> wrote:
>> Add function header comment to make it clear that local variable sw_cg
>> is used for debugging and it should not be removed.
>>
>> Addresses-Coverity-ID: 1198635
>> Cc: Alex Deucher <alexdeucher@gmail.com>
>> Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>
>
> Applied.  thanks!
>

Great, glad to help :)

Thanks
--
Gustavo A. R. Silva
