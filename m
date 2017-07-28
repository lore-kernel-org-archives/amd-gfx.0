From: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: use 256 bit buffers for all wb allocations
Date: Fri, 28 Jul 2017 18:15:45 -0400
Message-ID: <CADnq5_PumnBBWeb0j2KyxSURtizKrMUrY4FWH1TKn4wX9L+Gxw@mail.gmail.com>
References: <1501258540-9950-1-git-send-email-alexander.deucher@amd.com>
 <b589c629-dc1e-0cd4-80e5-aa6b1aa910ab@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="94eb2c07cdb6d57e480555680598"
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <b589c629-dc1e-0cd4-80e5-aa6b1aa910ab-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
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
To: Andy Furniss <adf.lists-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>, amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--94eb2c07cdb6d57e480555680598
Content-Type: text/plain; charset="UTF-8"

On Fri, Jul 28, 2017 at 6:08 PM, Andy Furniss <adf.lists-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> Alex Deucher wrote:
>>
>> May waste a bit of memory, but simplifies the interface
>> significantly.
>
>
> Can't boot tonga with this (testing 4.14-wip)

Should be fixed with this patch.

Alex

>
> Jul 28 23:00:29 ph4 kernel: [drm] amdgpu kernel modesetting enabled.
> Jul 28 23:00:29 ph4 kernel: [drm] initializing kernel modesetting (TONGA
> 0x1002:0x6939 0x1458:0x229D 0x00).
> Jul 28 23:00:29 ph4 kernel: [drm] register mmio base: 0xFEA00000
> Jul 28 23:00:29 ph4 kernel: [drm] register mmio size: 262144
> Jul 28 23:00:29 ph4 kernel: [drm] probing gen 2 caps for device 1002:5a16 =
> 31cd02/0
> Jul 28 23:00:29 ph4 kernel: [drm] probing mlw for device 1002:5a16 = 31cd02
> Jul 28 23:00:29 ph4 kernel: [drm] VCE enabled in physical mode
> Jul 28 23:00:29 ph4 kernel: amdgpu 0000:01:00.0: Invalid PCI ROM header
> signature: expecting 0xaa55, got 0x8b00
> Jul 28 23:00:29 ph4 kernel: ATOM BIOS: 113-xxx-Xxx
> Jul 28 23:00:29 ph4 kernel: [drm] GPU post is not needed
> Jul 28 23:00:29 ph4 kernel: [drm] Changing default dispclk from 600Mhz to
> 625Mhz
> Jul 28 23:00:29 ph4 kernel: [drm] vm size is 64 GB, block size is 13-bit
> Jul 28 23:00:29 ph4 kernel: amdgpu 0000:01:00.0: VRAM: 2048M
> 0x000000F400000000 - 0x000000F47FFFFFFF (2048M used)
> Jul 28 23:00:29 ph4 kernel: amdgpu 0000:01:00.0: GTT: 256M
> 0x0000000000000000 - 0x000000000FFFFFFF
> Jul 28 23:00:29 ph4 kernel: [drm] Detected VRAM RAM=2048M, BAR=256M
> Jul 28 23:00:29 ph4 kernel: [drm] RAM width 256bits GDDR5
> Jul 28 23:00:29 ph4 kernel: [TTM] Zone  kernel: Available graphics memory:
> 4069418 kiB
> Jul 28 23:00:29 ph4 kernel: [TTM] Zone   dma32: Available graphics memory:
> 2097152 kiB
> Jul 28 23:00:29 ph4 kernel: [TTM] Initializing pool allocator
> Jul 28 23:00:29 ph4 kernel: [TTM] Initializing DMA pool allocator
> Jul 28 23:00:29 ph4 kernel: [drm] amdgpu: 2048M of VRAM memory ready
> Jul 28 23:00:29 ph4 kernel: [drm] amdgpu: 3072M of GTT memory ready.
> Jul 28 23:00:29 ph4 kernel: [drm] GART: num cpu pages 65536, num gpu pages
> 65536
> Jul 28 23:00:29 ph4 kernel: [drm] PCIE GART of 256M enabled (table at
> 0x000000F400040000).
> Jul 28 23:00:29 ph4 kernel: [drm] Supports vblank timestamp caching Rev 2
> (21.10.2013).
> Jul 28 23:00:29 ph4 kernel: [drm] Driver supports precise vblank timestamp
> query.
> Jul 28 23:00:29 ph4 kernel: amdgpu 0000:01:00.0: amdgpu: using MSI.
> Jul 28 23:00:29 ph4 kernel: [drm] amdgpu: irq initialized.
> Jul 28 23:00:29 ph4 kernel: amdgpu: [powerplay] amdgpu: powerplay sw
> initialized
> Jul 28 23:00:29 ph4 kernel: [drm] AMDGPU Display Connectors
> Jul 28 23:00:29 ph4 kernel: [drm] Connector 0:
> Jul 28 23:00:29 ph4 kernel: [drm]   DP-1
> Jul 28 23:00:29 ph4 kernel: [drm]   HPD4
> Jul 28 23:00:29 ph4 kernel: [drm]   DDC: 0x4868 0x4868 0x4869 0x4869 0x486a
> 0x486a 0x486b 0x486b
> Jul 28 23:00:29 ph4 kernel: [drm]   Encoders:
> Jul 28 23:00:29 ph4 kernel: [drm]     DFP1: INTERNAL_UNIPHY1
> Jul 28 23:00:29 ph4 kernel: [drm] Connector 1:
> Jul 28 23:00:29 ph4 kernel: [drm]   HDMI-A-1
> Jul 28 23:00:29 ph4 kernel: [drm]   HPD5
> Jul 28 23:00:29 ph4 kernel: [drm]   DDC: 0x4870 0x4870 0x4871 0x4871 0x4872
> 0x4872 0x4873 0x4873
> Jul 28 23:00:29 ph4 kernel: [drm]   Encoders:
> Jul 28 23:00:29 ph4 kernel: [drm]     DFP2: INTERNAL_UNIPHY1
> Jul 28 23:00:29 ph4 kernel: [drm] Connector 2:
> Jul 28 23:00:29 ph4 kernel: [drm]   DVI-D-1
> Jul 28 23:00:29 ph4 kernel: [drm]   HPD1
> Jul 28 23:00:29 ph4 kernel: [drm]   DDC: 0x4878 0x4878 0x4879 0x4879 0x487a
> 0x487a 0x487b 0x487b
> Jul 28 23:00:29 ph4 kernel: [drm]   Encoders:
> Jul 28 23:00:29 ph4 kernel: [drm]     DFP3: INTERNAL_UNIPHY
> Jul 28 23:00:29 ph4 kernel: [drm] Connector 3:
> Jul 28 23:00:29 ph4 kernel: [drm]   DVI-I-1
> Jul 28 23:00:29 ph4 kernel: [drm]   HPD6
> Jul 28 23:00:29 ph4 kernel: [drm]   DDC: 0x487c 0x487c 0x487d 0x487d 0x487e
> 0x487e 0x487f 0x487f
> Jul 28 23:00:29 ph4 kernel: [drm]   Encoders:
> Jul 28 23:00:29 ph4 kernel: [drm]     DFP4: INTERNAL_UNIPHY2
> Jul 28 23:00:29 ph4 kernel: [drm]     CRT1: INTERNAL_KLDSCP_DAC1
> Jul 28 23:00:29 ph4 kernel: amdgpu 0000:01:00.0: fence driver on ring 0 use
> gpu addr 0x0000000000400200, cpu addr 0xffff88022e059200
> Jul 28 23:00:29 ph4 kernel: amdgpu 0000:01:00.0: fence driver on ring 1 use
> gpu addr 0x0000000000400600, cpu addr 0xffff88022e059600
> Jul 28 23:00:29 ph4 kernel: amdgpu 0000:01:00.0: fence driver on ring 2 use
> gpu addr 0x0000000000400a00, cpu addr 0xffff88022e059a00
> Jul 28 23:00:29 ph4 kernel: amdgpu 0000:01:00.0: fence driver on ring 3 use
> gpu addr 0x0000000000400e00, cpu addr 0xffff88022e059e00
> Jul 28 23:00:29 ph4 kernel: amdgpu 0000:01:00.0: (-22) ring rptr_offs wb
> alloc failed
> Jul 28 23:00:29 ph4 kernel: [drm:amdgpu_device_init [amdgpu]] *ERROR*
> sw_init of IP block <gfx_v8_0> failed -22
> Jul 28 23:00:29 ph4 kernel: amdgpu 0000:01:00.0: amdgpu_init failed
> Jul 28 23:00:29 ph4 kernel: [TTM] Finalizing pool allocator
> Jul 28 23:00:29 ph4 kernel: [TTM] Finalizing DMA pool allocator
> Jul 28 23:00:29 ph4 kernel: [TTM] Zone  kernel: Used memory at exit: 73 kiB
> Jul 28 23:00:29 ph4 kernel: [TTM] Zone   dma32: Used memory at exit: 25 kiB
> Jul 28 23:00:29 ph4 kernel: [drm] amdgpu: ttm finalized
> Jul 28 23:00:29 ph4 kernel: amdgpu 0000:01:00.0: Fatal error during GPU init
> Jul 28 23:00:29 ph4 kernel: [drm] amdgpu: finishing device.
> Jul 28 23:00:29 ph4 kernel: [TTM] Memory type 2 has not been initialized
> Jul 28 23:00:29 ph4 kernel: amdgpu: probe of 0000:01:00.0 failed with error
> -22
>
>
>
>>
>> Signed-off-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  4 --
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 65
>> ------------------------------
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c   | 65
>> ++++++++----------------------
>>   drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c     |  8 ++--
>>   4 files changed, 20 insertions(+), 122 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> index ed1b688..c880851 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> @@ -1190,10 +1190,6 @@ struct amdgpu_wb {
>>     int amdgpu_wb_get(struct amdgpu_device *adev, u32 *wb);
>>   void amdgpu_wb_free(struct amdgpu_device *adev, u32 wb);
>> -int amdgpu_wb_get_64bit(struct amdgpu_device *adev, u32 *wb);
>> -int amdgpu_wb_get_256bit(struct amdgpu_device *adev, u32 *wb);
>> -void amdgpu_wb_free_64bit(struct amdgpu_device *adev, u32 wb);
>> -void amdgpu_wb_free_256bit(struct amdgpu_device *adev, u32 wb);
>>     void amdgpu_get_pcie_info(struct amdgpu_device *adev);
>>   diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> index c2ddeb1..d422277 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> @@ -570,41 +570,6 @@ static int amdgpu_wb_init(struct amdgpu_device *adev)
>>    */
>>   int amdgpu_wb_get(struct amdgpu_device *adev, u32 *wb)
>>   {
>> -       unsigned long offset = find_first_zero_bit(adev->wb.used,
>> adev->wb.num_wb);
>> -       if (offset < adev->wb.num_wb) {
>> -               __set_bit(offset, adev->wb.used);
>> -               *wb = offset;
>> -               return 0;
>> -       } else {
>> -               return -EINVAL;
>> -       }
>> -}
>> -
>> -/**
>> - * amdgpu_wb_get_64bit - Allocate a wb entry
>> - *
>> - * @adev: amdgpu_device pointer
>> - * @wb: wb index
>> - *
>> - * Allocate a wb slot for use by the driver (all asics).
>> - * Returns 0 on success or -EINVAL on failure.
>> - */
>> -int amdgpu_wb_get_64bit(struct amdgpu_device *adev, u32 *wb)
>> -{
>> -       unsigned long offset =
>> bitmap_find_next_zero_area_off(adev->wb.used,
>> -                               adev->wb.num_wb, 0, 2, 7, 0);
>> -       if ((offset + 1) < adev->wb.num_wb) {
>> -               __set_bit(offset, adev->wb.used);
>> -               __set_bit(offset + 1, adev->wb.used);
>> -               *wb = offset;
>> -               return 0;
>> -       } else {
>> -               return -EINVAL;
>> -       }
>> -}
>> -
>> -int amdgpu_wb_get_256bit(struct amdgpu_device *adev, u32 *wb)
>> -{
>>         int i = 0;
>>         unsigned long offset =
>> bitmap_find_next_zero_area_off(adev->wb.used,
>>                                 adev->wb.num_wb, 0, 8, 63, 0);
>> @@ -628,36 +593,6 @@ int amdgpu_wb_get_256bit(struct amdgpu_device *adev,
>> u32 *wb)
>>    */
>>   void amdgpu_wb_free(struct amdgpu_device *adev, u32 wb)
>>   {
>> -       if (wb < adev->wb.num_wb)
>> -               __clear_bit(wb, adev->wb.used);
>> -}
>> -
>> -/**
>> - * amdgpu_wb_free_64bit - Free a wb entry
>> - *
>> - * @adev: amdgpu_device pointer
>> - * @wb: wb index
>> - *
>> - * Free a wb slot allocated for use by the driver (all asics)
>> - */
>> -void amdgpu_wb_free_64bit(struct amdgpu_device *adev, u32 wb)
>> -{
>> -       if ((wb + 1) < adev->wb.num_wb) {
>> -               __clear_bit(wb, adev->wb.used);
>> -               __clear_bit(wb + 1, adev->wb.used);
>> -       }
>> -}
>> -
>> -/**
>> - * amdgpu_wb_free_256bit - Free a wb entry
>> - *
>> - * @adev: amdgpu_device pointer
>> - * @wb: wb index
>> - *
>> - * Free a wb slot allocated for use by the driver (all asics)
>> - */
>> -void amdgpu_wb_free_256bit(struct amdgpu_device *adev, u32 wb)
>> -{
>>         int i = 0;
>>         if ((wb + 7) < adev->wb.num_wb)
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
>> index 3874be8..704475674 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
>> @@ -184,47 +184,22 @@ int amdgpu_ring_init(struct amdgpu_device *adev,
>> struct amdgpu_ring *ring,
>>                         return r;
>>         }
>>   -     if (ring->funcs->support_64bit_ptrs) {
>> -               r = amdgpu_wb_get_64bit(adev, &ring->rptr_offs);
>> -               if (r) {
>> -                       dev_err(adev->dev, "(%d) ring rptr_offs wb alloc
>> failed\n", r);
>> -                       return r;
>> -               }
>> -
>> -               r = amdgpu_wb_get_64bit(adev, &ring->wptr_offs);
>> -               if (r) {
>> -                       dev_err(adev->dev, "(%d) ring wptr_offs wb alloc
>> failed\n", r);
>> -                       return r;
>> -               }
>> -
>> -       } else {
>> -               r = amdgpu_wb_get(adev, &ring->rptr_offs);
>> -               if (r) {
>> -                       dev_err(adev->dev, "(%d) ring rptr_offs wb alloc
>> failed\n", r);
>> -                       return r;
>> -               }
>> -
>> -               r = amdgpu_wb_get(adev, &ring->wptr_offs);
>> -               if (r) {
>> -                       dev_err(adev->dev, "(%d) ring wptr_offs wb alloc
>> failed\n", r);
>> -                       return r;
>> -               }
>> -
>> +       r = amdgpu_wb_get(adev, &ring->rptr_offs);
>> +       if (r) {
>> +               dev_err(adev->dev, "(%d) ring rptr_offs wb alloc
>> failed\n", r);
>> +               return r;
>>         }
>>   -     if (amdgpu_sriov_vf(adev) && ring->funcs->type ==
>> AMDGPU_RING_TYPE_GFX) {
>> -               r = amdgpu_wb_get_256bit(adev, &ring->fence_offs);
>> -               if (r) {
>> -                       dev_err(adev->dev, "(%d) ring fence_offs wb alloc
>> failed\n", r);
>> -                       return r;
>> -               }
>> +       r = amdgpu_wb_get(adev, &ring->wptr_offs);
>> +       if (r) {
>> +               dev_err(adev->dev, "(%d) ring wptr_offs wb alloc
>> failed\n", r);
>> +               return r;
>> +       }
>>   -     } else {
>> -               r = amdgpu_wb_get(adev, &ring->fence_offs);
>> -               if (r) {
>> -                       dev_err(adev->dev, "(%d) ring fence_offs wb alloc
>> failed\n", r);
>> -                       return r;
>> -               }
>> +       r = amdgpu_wb_get(adev, &ring->fence_offs);
>> +       if (r) {
>> +               dev_err(adev->dev, "(%d) ring fence_offs wb alloc
>> failed\n", r);
>> +               return r;
>>         }
>>         r = amdgpu_wb_get(adev, &ring->cond_exe_offs);
>> @@ -286,19 +261,11 @@ void amdgpu_ring_fini(struct amdgpu_ring *ring)
>>   {
>>         ring->ready = false;
>>   -     if (ring->funcs->support_64bit_ptrs) {
>> -               amdgpu_wb_free_64bit(ring->adev, ring->rptr_offs);
>> -               amdgpu_wb_free_64bit(ring->adev, ring->wptr_offs);
>> -       } else {
>> -               amdgpu_wb_free(ring->adev, ring->rptr_offs);
>> -               amdgpu_wb_free(ring->adev, ring->wptr_offs);
>> -       }
>> +       amdgpu_wb_free(ring->adev, ring->rptr_offs);
>> +       amdgpu_wb_free(ring->adev, ring->wptr_offs);
>>         amdgpu_wb_free(ring->adev, ring->cond_exe_offs);
>> -       if (amdgpu_sriov_vf(ring->adev) && ring->funcs->type ==
>> AMDGPU_RING_TYPE_GFX)
>> -               amdgpu_wb_free_256bit(ring->adev, ring->fence_offs);
>> -       else
>> -               amdgpu_wb_free(ring->adev, ring->fence_offs);
>> +       amdgpu_wb_free(ring->adev, ring->fence_offs);
>>         amdgpu_bo_free_kernel(&ring->ring_obj,
>>                               &ring->gpu_addr,
>> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
>> b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
>> index 5c24708..8273e63 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
>> @@ -1278,8 +1278,8 @@ static int sdma_v4_0_sw_init(void *handle)
>>                                      AMDGPU_SDMA_IRQ_TRAP1);
>>                 if (amdgpu_sriov_vf(adev)) {
>> -                       r = amdgpu_wb_get_64bit(adev,
>> -
>> &adev->sdma.instance[i].poll_mem_offs);
>> +                       r = amdgpu_wb_get(adev,
>> +
>> &adev->sdma.instance[i].poll_mem_offs);
>>                         if (r) {
>>                                 dev_err(adev->dev, "(%d) failed to
>> allocate SDMA poll mem wb.\n", r);
>>                                 return r;
>> @@ -1301,8 +1301,8 @@ static int sdma_v4_0_sw_fini(void *handle)
>>                 amdgpu_ring_fini(&adev->sdma.instance[i].ring);
>>                 if (amdgpu_sriov_vf(adev))
>> -                       amdgpu_wb_free_64bit(adev,
>> -
>> adev->sdma.instance[i].poll_mem_offs);
>> +                       amdgpu_wb_free(adev,
>> +
>> adev->sdma.instance[i].poll_mem_offs);
>>         }
>>         return 0;
>>   }
>>
>

--94eb2c07cdb6d57e480555680598
Content-Type: text/x-diff; charset="US-ASCII";
	name="0001-drm-amdgpu-bump-AMDGPU_MAX_WB.patch"
Content-Disposition: attachment;
	filename="0001-drm-amdgpu-bump-AMDGPU_MAX_WB.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_j5offmxc0

RnJvbSA4MDk0Y2VjNzFiYTNkYTA3NjE3ZmYwOGU1YzM5MmM3OGRhNzBkN2QxIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5j
b20+CkRhdGU6IEZyaSwgMjggSnVsIDIwMTcgMTg6MTM6NDIgLTA0MDAKU3ViamVjdDogW1BBVENI
XSBkcm0vYW1kZ3B1OiBidW1wIEFNREdQVV9NQVhfV0IKClNpbmNlIHdlIGFsd2F5cyB1c2UgMjU2
Yml0IHdiIHNsb3RzIG5vdy4KClNpZ25lZC1vZmYtYnk6IEFsZXggRGV1Y2hlciA8YWxleGFuZGVy
LmRldWNoZXJAYW1kLmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHUu
aCB8IDIgKy0KIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQoK
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdS5oIGIvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1LmgKaW5kZXggNjhiMzAyMy4uZDAwMTI2MmQgMTAw
NjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdS5oCisrKyBiL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdS5oCkBAIC0xMTE4LDcgKzExMTgsNyBAQCBzdGF0
aWMgaW5saW5lIHZvaWQgYW1kZ3B1X3NldF9pYl92YWx1ZShzdHJ1Y3QgYW1kZ3B1X2NzX3BhcnNl
ciAqcCwKIC8qCiAgKiBXcml0ZWJhY2sKICAqLwotI2RlZmluZSBBTURHUFVfTUFYX1dCIDEwMjQJ
LyogUmVzZXJ2ZSBhdCBtb3N0IDEwMjQgV0Igc2xvdHMgZm9yIGFtZGdwdS1vd25lZCByaW5ncy4g
Ki8KKyNkZWZpbmUgQU1ER1BVX01BWF9XQiAxNjM4NAkvKiBSZXNlcnZlIGF0IG1vc3QgMTYzODQg
V0Igc2xvdHMgZm9yIGFtZGdwdS1vd25lZCByaW5ncy4gKi8KIAogc3RydWN0IGFtZGdwdV93YiB7
CiAJc3RydWN0IGFtZGdwdV9ibwkqd2Jfb2JqOwotLSAKMi41LjUKCg==
--94eb2c07cdb6d57e480555680598
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--94eb2c07cdb6d57e480555680598--
