From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 0/5] Clean up TTM mmap offsets
Date: Tue, 26 Feb 2019 14:01:04 +0100
Message-ID: <387dcf10-77a2-1ba9-c63e-a925d11fd091@gmail.com>
References: <20190207085931.29569-1-tzimmermann@suse.de>
 <e03e4cff-557b-9d50-dba8-94835e768743@amd.com>
 <552aa321-98d4-344d-eda2-8441940b5811@suse.de>
Reply-To: christian.koenig-5C7GfCeVMHo@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0757250819=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <552aa321-98d4-344d-eda2-8441940b5811-l3A5Bk7waGM@public.gmane.org>
Content-Language: en-US
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
List-Help: <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=subscribe>
Errors-To: amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Sender: "amd-gfx" <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
To: Thomas Zimmermann <tzimmermann-l3A5Bk7waGM@public.gmane.org>, "Koenig, Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>, "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, "Zhou, David(ChunMing)" <David1.Zhou-5C7GfCeVMHo@public.gmane.org>, "airlied-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org" <airlied-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "kraxel-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org" <kraxel-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "z.liuxinliang-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org" <z.liuxinliang-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org>, "zourongrong-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <zourongrong-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "kong.kongxinwei-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org" <kong.kongxinwei-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org>, "puck.chen-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org" <puck.chen-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org>, "bskeggs-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org" <bskeggs-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "thellstrom-pghWNbHTmq7QT0dZR+AlfA@public.gmane.org" <thellstrom-pghWNbHTmq7QT0dZR+AlfA@public.gmane.org>, "linux-graphics-maintainer-pghWNbHTmq7QT0dZR+AlfA@public.gmane.org" <linux-graphics-maintainer-pghWNbHTmq7QT0dZR+AlfA@public.gmane.org>, "daniel-/w4YWyX8dFk@public.gmane.org" <daniel-/w4YWyX8dFk@public.gmane.org>, "hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org" <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "arnd-r2nGTMty4D4@public.gmane.org" <arnd-r2nGTMty4D4@public.gmane.org>, "gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org" <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, "Huang, Ray" <Ray.Huang-5C7GfCeVMHo@public.gmane.org>Zh
Cc: "spice-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <spice-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "virtualization-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <virtualization-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>

This is a multi-part message in MIME format.
--===============0757250819==
Content-Type: multipart/alternative;
 boundary="------------519B1619873C07614C46F7E4"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------519B1619873C07614C46F7E4
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 07.02.19 um 10:45 schrieb Thomas Zimmermann:
> Am 07.02.19 um 10:36 schrieb Koenig, Christian:
>> Am 07.02.19 um 09:59 schrieb Thomas Zimmermann:
>>> Almost all TTM-based drivers use the same values for the mmap-able
>>> range of BO addresses. Each driver therefore duplicates the
>>> DRM_FILE_PAGE_OFFSET constant. OTOH, the mmap range's size is not
>>> configurable by drivers.
>>>
>>> This patch set replaces driver-specific configuration with a single
>>> setup. All code is located within TTM. TTM and GEM share the same
>>> range for mmap-able BOs.
>>>
>>> Thomas Zimmermann (5):
>>>     staging/vboxvideo: Use same BO mmap offset as other drivers
>>>     drm/ttm: Define a single DRM_FILE_PAGE_OFFSET constant
>>>     drm/ttm: Remove file_page_offset parameter from ttm_bo_device_init()
>>>     drm/ttm: Quick-test mmap offset in ttm_bo_mmap()
>>>     drm: Use the same mmap-range offset and size for GEM and TTM
>> Reviewed-by: Christian König <christian.koenig-5C7GfCeVMHo@public.gmane.org> for the whole
>> series.
> That was quick! Thank you.

FYI I just pushed this series into our internal branch for upstreaming.

Regards,
Christian.

>
>> Nice cleanup! Thanks,
>> Christian.
>>
>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c     | 12 ++----------
>>>    drivers/gpu/drm/ast/ast_drv.h               |  2 --
>>>    drivers/gpu/drm/ast/ast_ttm.c               | 10 ++--------
>>>    drivers/gpu/drm/bochs/bochs.h               |  2 --
>>>    drivers/gpu/drm/bochs/bochs_mm.c            | 10 ++--------
>>>    drivers/gpu/drm/cirrus/cirrus_drv.h         |  1 -
>>>    drivers/gpu/drm/cirrus/cirrus_ttm.c         | 10 ++--------
>>>    drivers/gpu/drm/drm_gem.c                   | 17 -----------------
>>>    drivers/gpu/drm/hisilicon/hibmc/hibmc_ttm.c | 12 ++----------
>>>    drivers/gpu/drm/mgag200/mgag200_drv.h       |  1 -
>>>    drivers/gpu/drm/mgag200/mgag200_ttm.c       | 10 ++--------
>>>    drivers/gpu/drm/nouveau/nouveau_drv.h       |  2 --
>>>    drivers/gpu/drm/nouveau/nouveau_ttm.c       |  4 ----
>>>    drivers/gpu/drm/qxl/qxl_drv.h               |  3 ---
>>>    drivers/gpu/drm/qxl/qxl_ttm.c               | 11 +++--------
>>>    drivers/gpu/drm/radeon/radeon_ttm.c         | 13 ++-----------
>>>    drivers/gpu/drm/ttm/ttm_bo.c                |  6 +++---
>>>    drivers/gpu/drm/ttm/ttm_bo_vm.c             |  3 +++
>>>    drivers/gpu/drm/virtio/virtgpu_ttm.c        |  4 +---
>>>    drivers/gpu/drm/vmwgfx/vmwgfx_drv.c         |  1 -
>>>    drivers/gpu/drm/vmwgfx/vmwgfx_drv.h         |  1 -
>>>    drivers/gpu/drm/vmwgfx/vmwgfx_ttm_glue.c    | 11 ++---------
>>>    drivers/staging/vboxvideo/vbox_drv.h        |  2 --
>>>    drivers/staging/vboxvideo/vbox_ttm.c        | 12 +++---------
>>>    include/drm/drm_vma_manager.h               | 12 ++++++++++++
>>>    include/drm/ttm/ttm_bo_driver.h             |  2 +-
>>>    26 files changed, 42 insertions(+), 132 deletions(-)
>>>
>> _______________________________________________
>> dri-devel mailing list
>> dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
>> https://lists.freedesktop.org/mailman/listinfo/dri-devel
>>
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx


--------------519B1619873C07614C46F7E4
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <div class="moz-cite-prefix">Am 07.02.19 um 10:45 schrieb Thomas
      Zimmermann:<br>
    </div>
    <blockquote type="cite"
      cite="mid:552aa321-98d4-344d-eda2-8441940b5811-l3A5Bk7waGM@public.gmane.org">
      <pre class="moz-quote-pre" wrap="">Am 07.02.19 um 10:36 schrieb Koenig, Christian:
</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">Am 07.02.19 um 09:59 schrieb Thomas Zimmermann:
</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">Almost all TTM-based drivers use the same values for the mmap-able
range of BO addresses. Each driver therefore duplicates the
DRM_FILE_PAGE_OFFSET constant. OTOH, the mmap range's size is not
configurable by drivers.

This patch set replaces driver-specific configuration with a single
setup. All code is located within TTM. TTM and GEM share the same
range for mmap-able BOs.

Thomas Zimmermann (5):
   staging/vboxvideo: Use same BO mmap offset as other drivers
   drm/ttm: Define a single DRM_FILE_PAGE_OFFSET constant
   drm/ttm: Remove file_page_offset parameter from ttm_bo_device_init()
   drm/ttm: Quick-test mmap offset in ttm_bo_mmap()
   drm: Use the same mmap-range offset and size for GEM and TTM
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">
Reviewed-by: Christian König <a class="moz-txt-link-rfc2396E" href="mailto:christian.koenig-5C7GfCeVMHo@public.gmane.org">&lt;christian.koenig-5C7GfCeVMHo@public.gmane.org&gt;</a> for the whole 
series.
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
That was quick! Thank you.</pre>
    </blockquote>
    <br>
    FYI I just pushed this series into our internal branch for
    upstreaming.<br>
    <br>
    Regards,<br>
    Christian.<br>
    <br>
    <blockquote type="cite"
      cite="mid:552aa321-98d4-344d-eda2-8441940b5811-l3A5Bk7waGM@public.gmane.org">
      <pre class="moz-quote-pre" wrap="">

</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">
Nice cleanup! Thanks,
Christian.

</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">
  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c     | 12 ++----------
  drivers/gpu/drm/ast/ast_drv.h               |  2 --
  drivers/gpu/drm/ast/ast_ttm.c               | 10 ++--------
  drivers/gpu/drm/bochs/bochs.h               |  2 --
  drivers/gpu/drm/bochs/bochs_mm.c            | 10 ++--------
  drivers/gpu/drm/cirrus/cirrus_drv.h         |  1 -
  drivers/gpu/drm/cirrus/cirrus_ttm.c         | 10 ++--------
  drivers/gpu/drm/drm_gem.c                   | 17 -----------------
  drivers/gpu/drm/hisilicon/hibmc/hibmc_ttm.c | 12 ++----------
  drivers/gpu/drm/mgag200/mgag200_drv.h       |  1 -
  drivers/gpu/drm/mgag200/mgag200_ttm.c       | 10 ++--------
  drivers/gpu/drm/nouveau/nouveau_drv.h       |  2 --
  drivers/gpu/drm/nouveau/nouveau_ttm.c       |  4 ----
  drivers/gpu/drm/qxl/qxl_drv.h               |  3 ---
  drivers/gpu/drm/qxl/qxl_ttm.c               | 11 +++--------
  drivers/gpu/drm/radeon/radeon_ttm.c         | 13 ++-----------
  drivers/gpu/drm/ttm/ttm_bo.c                |  6 +++---
  drivers/gpu/drm/ttm/ttm_bo_vm.c             |  3 +++
  drivers/gpu/drm/virtio/virtgpu_ttm.c        |  4 +---
  drivers/gpu/drm/vmwgfx/vmwgfx_drv.c         |  1 -
  drivers/gpu/drm/vmwgfx/vmwgfx_drv.h         |  1 -
  drivers/gpu/drm/vmwgfx/vmwgfx_ttm_glue.c    | 11 ++---------
  drivers/staging/vboxvideo/vbox_drv.h        |  2 --
  drivers/staging/vboxvideo/vbox_ttm.c        | 12 +++---------
  include/drm/drm_vma_manager.h               | 12 ++++++++++++
  include/drm/ttm/ttm_bo_driver.h             |  2 +-
  26 files changed, 42 insertions(+), 132 deletions(-)

</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">
_______________________________________________
dri-devel mailing list
<a class="moz-txt-link-abbreviated" href="mailto:dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>
<a class="moz-txt-link-freetext" href="https://lists.freedesktop.org/mailman/listinfo/dri-devel">https://lists.freedesktop.org/mailman/listinfo/dri-devel</a>

</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
</pre>
      <br>
      <fieldset class="mimeAttachmentHeader"></fieldset>
      <pre class="moz-quote-pre" wrap="">_______________________________________________
amd-gfx mailing list
<a class="moz-txt-link-abbreviated" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>
<a class="moz-txt-link-freetext" href="https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a>
</pre>
    </blockquote>
    <br>
  </body>
</html>

--------------519B1619873C07614C46F7E4--

--===============0757250819==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============0757250819==--
