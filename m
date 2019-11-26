From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Subject: Re: [PATCH v2 2/2] drm: share address space for dma bufs
Date: Tue, 26 Nov 2019 12:15:02 +0100
Message-ID: <805a875c-a43f-556d-db72-3af32e3061d6@gmail.com>
References: <20191122063749.27113-1-kraxel@redhat.com>
 <20191122063749.27113-3-kraxel@redhat.com>
 <CAKMK7uFz3hmPT3OE8UtUQwmv+tXsjazUWT2RVHLxAq47X+EaXA@mail.gmail.com>
 <CADnq5_MvOE1Fw7-0g+Fo3Vvvu-c=Z9u+pZUEstv2cVXNKKL2=g@mail.gmail.com>
Reply-To: christian.koenig@amd.com
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CADnq5_MvOE1Fw7-0g+Fo3Vvvu-c=Z9u+pZUEstv2cVXNKKL2=g@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Alex Deucher <alexdeucher@gmail.com>, Daniel Vetter <daniel@ffwll.ch>
Cc: "open list:RADEON and AMDGPU DRM DRIVERS" <amd-gfx@lists.freedesktop.org>, David Airlie <airlied@linux.ie>, intel-gfx <intel-gfx@lists.freedesktop.org>, open list <linux-kernel@vger.kernel.org>, dri-devel <dri-devel@lists.freedesktop.org>, Gerd Hoffmann <kraxel@redhat.com>, Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
List-Id: amd-gfx.lists.freedesktop.org

Am 22.11.19 um 19:21 schrieb Alex Deucher:
> On Fri, Nov 22, 2019 at 4:17 AM Daniel Vetter <daniel@ffwll.ch> wrote:
>> On Fri, Nov 22, 2019 at 7:37 AM Gerd Hoffmann <kraxel@redhat.com> wrote:
>>> Use the shared address space of the drm device (see drm_open() in
>>> drm_file.c) for dma-bufs too.  That removes a difference betweem drm
>>> device mmap vmas and dma-buf mmap vmas and fixes corner cases like
>>> dropping ptes (using madvise(DONTNEED) for example) not working
>>> properly.
>>>
>>> Also remove amdgpu driver's private dmabuf update.  It is not needed
>>> any more now that we are doing this for everybody.
>>>
>>> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
>> Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
>>
>> But I think you want at least an ack from amd guys for double checking here.
>> -Daniel
> Looks correct to me.
>
> Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

>
>
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c | 4 +---
>>>   drivers/gpu/drm/drm_prime.c                 | 4 +++-
>>>   2 files changed, 4 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
>>> index d5bcdfefbad6..586db4fb46bd 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
>>> @@ -361,10 +361,8 @@ struct dma_buf *amdgpu_gem_prime_export(struct drm_gem_object *gobj,
>>>                  return ERR_PTR(-EPERM);
>>>
>>>          buf = drm_gem_prime_export(gobj, flags);
>>> -       if (!IS_ERR(buf)) {
>>> -               buf->file->f_mapping = gobj->dev->anon_inode->i_mapping;
>>> +       if (!IS_ERR(buf))
>>>                  buf->ops = &amdgpu_dmabuf_ops;
>>> -       }
>>>
>>>          return buf;
>>>   }
>>> diff --git a/drivers/gpu/drm/drm_prime.c b/drivers/gpu/drm/drm_prime.c
>>> index a9633bd241bb..c3fc341453c0 100644
>>> --- a/drivers/gpu/drm/drm_prime.c
>>> +++ b/drivers/gpu/drm/drm_prime.c
>>> @@ -240,6 +240,7 @@ void drm_prime_destroy_file_private(struct drm_prime_file_private *prime_fpriv)
>>>   struct dma_buf *drm_gem_dmabuf_export(struct drm_device *dev,
>>>                                        struct dma_buf_export_info *exp_info)
>>>   {
>>> +       struct drm_gem_object *obj = exp_info->priv;
>>>          struct dma_buf *dma_buf;
>>>
>>>          dma_buf = dma_buf_export(exp_info);
>>> @@ -247,7 +248,8 @@ struct dma_buf *drm_gem_dmabuf_export(struct drm_device *dev,
>>>                  return dma_buf;
>>>
>>>          drm_dev_get(dev);
>>> -       drm_gem_object_get(exp_info->priv);
>>> +       drm_gem_object_get(obj);
>>> +       dma_buf->file->f_mapping = obj->dev->anon_inode->i_mapping;
>>>
>>>          return dma_buf;
>>>   }
>>> --
>>> 2.18.1
>>>
>>
>> --
>> Daniel Vetter
>> Software Engineer, Intel Corporation
>> +41 (0) 79 365 57 48 - http://blog.ffwll.ch
>> _______________________________________________
>> dri-devel mailing list
>> dri-devel@lists.freedesktop.org
>> https://lists.freedesktop.org/mailman/listinfo/dri-devel
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
