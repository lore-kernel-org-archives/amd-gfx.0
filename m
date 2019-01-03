From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: Re: [PATCH] drm/amd/display: Fix boolean expression in
 get_surf_rq_param
Date: Thu, 3 Jan 2019 15:18:42 -0600
Message-ID: <fa256e45-60dd-d7ea-75c4-898583b49480@embeddedor.com>
References: <20190103194845.GA26175@embeddedor>
 <8169baae-434e-2d08-d63f-a285d1c3457e@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <8169baae-434e-2d08-d63f-a285d1c3457e@amd.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "Wentland, Harry" <Harry.Wentland@amd.com>, "Laktyushkin, Dmytro" <Dmytro.Laktyushkin@amd.com>, "Li, Sun peng (Leo)" <Sunpeng.Li@amd.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian" <Christian.Koenig@amd.com>, "Zhou, David(ChunMing)" <David1.Zhou@amd.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: amd-gfx.lists.freedesktop.org



On 1/3/19 3:11 PM, Wentland, Harry wrote:
> On 2019-01-03 2:48 p.m., Gustavo A. R. Silva wrote:
>> Fix boolean expression by using logical AND operator '&&'
>> instead of bitwise operator '&'.
>>
>> This issue was detected with the help of Coccinelle.
>>
>> Fixes: 6d04ee9dc101 ("drm/amd/display: Restructuring and cleaning up DML")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> 
> Reviewed-by: Harry Wentland <harry.wentland@amd.com>
> 
> and applied.
> 

Thanks, Harry.

--
Gustavo
