From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: Re: [PATCH] gpu: drm: use struct_size() in kmalloc()
Date: Mon, 20 May 2019 13:21:14 -0500
Message-ID: <f17d994b-c498-4002-dd72-2999574d84ec@embeddedor.com>
References: <1558082760-4915-1-git-send-email-xiaolinkui@kylinos.cn>
 <CADnq5_PE-mvW2zwNeHn6prvTQvh-en9E9F7VE-hCS=a8jJWhAQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CADnq5_PE-mvW2zwNeHn6prvTQvh-en9E9F7VE-hCS=a8jJWhAQ@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: xiaolinkui <xiaolinkui@kylinos.cn>
Cc: "Deucher, Alexander" <alexander.deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, Chunming Zhou <David1.Zhou@amd.com>, Dave Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, xinhui pan <xinhui.pan@amd.com>, "Quan, Evan" <evan.quan@amd.com>, Maling list - DRI developers <dri-devel@lists.freedesktop.org>, amd-gfx list <amd-gfx@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>, Alex Deucher <alexdeucher@gmail.com>
List-Id: amd-gfx.lists.freedesktop.org



On 5/20/19 12:41 PM, Alex Deucher wrote:
> On Fri, May 17, 2019 at 8:43 AM xiaolinkui <xiaolinkui@kylinos.cn> wrote:
>>
>> Use struct_size() helper to keep code simple.
>>

Again, this is not the reason why this helper was created.

>> Signed-off-by: xiaolinkui <xiaolinkui@kylinos.cn>
>> ---
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 3 +--
>>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> This patch results in the following build error:
>   DESCEND  objtool
>   CALL    scripts/checksyscalls.sh
>   CHK     include/generated/compile.h
>   CC [M]  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.o
> In file included from ./include/linux/kernel.h:15,
>                  from ./include/linux/list.h:9,
>                  from ./include/linux/wait.h:7,
>                  from ./include/linux/wait_bit.h:8,
>                  from ./include/linux/fs.h:6,
>                  from ./include/linux/debugfs.h:15,
>                  from drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c:24:
> drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c: In function ‘amdgpu_ras_init’:
> ./include/linux/build_bug.h:16:45: error: negative width in bit-field
> ‘<anonymous>’
>  #define BUILD_BUG_ON_ZERO(e) (sizeof(struct { int:(-!!(e)); }))
>                                              ^
> ./include/linux/compiler.h:349:28: note: in expansion of macro
> ‘BUILD_BUG_ON_ZERO’
>  #define __must_be_array(a) BUILD_BUG_ON_ZERO(__same_type((a), &(a)[0]))
>                             ^~~~~~~~~~~~~~~~~
> ./include/linux/overflow.h:306:30: note: in expansion of macro ‘__must_be_array’
>        sizeof(*(p)->member) + __must_be_array((p)->member),\
>                               ^~~~~~~~~~~~~~~
> drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c:1556:16: note: in expansion of
> macro ‘struct_size’
>   con = kmalloc(struct_size(con, objs, AMDGPU_RAS_BLOCK_COUNT),
>                 ^~~~~~~~~~~
> make[4]: *** [scripts/Makefile.build:276:
> drivers/gpu/drm/amd/amdgpu/amdgpu_ras.o] Error 1
> make[4]: *** Waiting for unfinished jobs....
> make[3]: *** [scripts/Makefile.build:492: drivers/gpu/drm/amd/amdgpu] Error 2
> make[3]: *** Waiting for unfinished jobs....
> make[2]: *** [scripts/Makefile.build:492: drivers/gpu/drm] Error 2
> make[1]: *** [scripts/Makefile.build:492: drivers/gpu] Error 2
> make: *** [Makefile:1042: drivers] Error 2
> 
> Alex
> 

You continue[1][2] sending these sorts of patches without really understanding what
you are doing. And you don't even compile them. Why?

--
Gustavo

[1] https://lore.kernel.org/lkml/d83390a9-33be-3d76-3e23-b97f0a05b72f@kernel.dk/
[2] https://lore.kernel.org/lkml/b4d33107-75d5-fa18-536e-6d21c96e4972@kernel.dk/

> 
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
>> index 22bd21e..4717a64 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
>> @@ -1375,8 +1375,7 @@ int amdgpu_ras_init(struct amdgpu_device *adev)
>>         if (con)
>>                 return 0;
>>
>> -       con = kmalloc(sizeof(struct amdgpu_ras) +
>> -                       sizeof(struct ras_manager) * AMDGPU_RAS_BLOCK_COUNT,
>> +       con = kmalloc(struct_size(con, objs, AMDGPU_RAS_BLOCK_COUNT),
>>                         GFP_KERNEL|__GFP_ZERO);
>>         if (!con)
>>                 return -ENOMEM;
>> --
>> 2.7.4
>>
>>
>>
>> _______________________________________________
>> amd-gfx mailing list
>> amd-gfx@lists.freedesktop.org
>> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
