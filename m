From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: Re: [PATCH] drm/amd/powerplay/smu10_hwmgr: use struct_size() in
 kzalloc()
Date: Tue, 19 Feb 2019 14:08:26 -0600
Message-ID: <636b1826-b6c1-9a64-5abb-ee84bebaae1a@embeddedor.com>
References: <20190219185509.GA23853@embeddedor>
 <CADnq5_Nntrq2zdzkwERV3ShCRptifbgVNhKP+xNgtyaWftWDdg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CADnq5_Nntrq2zdzkwERV3ShCRptifbgVNhKP+xNgtyaWftWDdg@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Alex Deucher <alexdeucher@gmail.com>
Cc: Rex Zhu <rex.zhu@amd.com>, Evan Quan <evan.quan@amd.com>, Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>, "David (ChunMing) Zhou" <David1.Zhou@amd.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, Maling list - DRI developers <dri-devel@lists.freedesktop.org>, amd-gfx list <amd-gfx@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: amd-gfx.lists.freedesktop.org



On 2/19/19 1:51 PM, Alex Deucher wrote:
> On Tue, Feb 19, 2019 at 1:55 PM Gustavo A. R. Silva
> <gustavo@embeddedor.com> wrote:
>>
>> One of the more common cases of allocation size calculations is finding
>> the size of a structure that has a zero-sized array at the end, along
>> with memory for some number of elements for that array. For example:
>>
>> struct foo {
>>     int stuff;
>>     struct boo entry[];
>> };
>>
>> size = sizeof(struct foo) + count * sizeof(struct boo);
>> instance = kzalloc(size, GFP_KERNEL);
>>
>> Instead of leaving these open-coded and prone to type mistakes, we can
>> now use the new struct_size() helper:
>>
>> instance = kzalloc(struct_size(instance, entry, count), GFP_KERNEL);
>>
>> Notice that, in this case, variable table_size is not necessary, hence
>> it is removed.
>>
>> This code was detected with the help of Coccinelle.
>>
>> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> 
> Applied this and the smu8 patch.  Thanks!
> 
Great!

Thanks, Alex.

--
Gustavo
