From: Tom St Denis <tom.stdenis-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 5/5] drm/amdgpu: replace iova debugfs file with iomem
Date: Mon, 5 Feb 2018 08:55:19 -0500
Message-ID: <5177b275-635f-a5b1-6c93-71627d115996@amd.com>
References: <20180202190948.2654-1-christian.koenig@amd.com>
 <20180202190948.2654-5-christian.koenig@amd.com>
 <MWHPR1201MB012743AB6452692097481D08FDFE0@MWHPR1201MB0127.namprd12.prod.outlook.com>
 <8c826b1d-1a3c-e36f-c978-48b286b10f0f@amd.com>
 <0db6d2d5-8cd1-31e3-8443-4be9394fd8ff@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------E0CFB1D095300CED87AD3D40"
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <0db6d2d5-8cd1-31e3-8443-4be9394fd8ff-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
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
To: christian.koenig-5C7GfCeVMHo@public.gmane.org, "He, Roger" <Hongbo.He-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

This is a multi-part message in MIME format.
--------------E0CFB1D095300CED87AD3D40
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

Attached is a patch for umr{master} which should in theory support both 
iova and iomem.

I can add the write method if you want since ya it should be fairly 
simple to copy/pasta that up.

Cheers,
Tom

On 05/02/18 07:07 AM, Christian König wrote:
> Well adding write support is trivial.
> 
> What I'm more concerned about is if setting page->mapping during 
> allocation of the page could have any negative effect?
> 
> I of hand don't see any since the page isn't reclaimable directly 
> anyway, but I'm not 100% sure of that.
> 
> Christian.
> 
> Am 05.02.2018 um 12:49 schrieb Tom St Denis:
>> Another thing that occurred to me is this will break write access to 
>> GPU bound memory.  Previously we relied on iova to translate the 
>> address and then /dev/mem or /dev/fmem to read/write it.  But since 
>> this is literally a read only method obviously there's no write support.
>>
>> Tom
>>
>>
>> On 04/02/18 09:56 PM, He, Roger wrote:
>>> Patch1 & 2 & 4,   Reviewed-by: Roger He <Hongbo.He-5C7GfCeVMHo@public.gmane.org>
>>> Patch 5:  Acked-by: Roger He <Hongbo.He-5C7GfCeVMHo@public.gmane.org>
>>>
>>> -----Original Message-----
>>> From: dri-devel [mailto:dri-devel-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org] On 
>>> Behalf Of Christian K?nig
>>> Sent: Saturday, February 03, 2018 3:10 AM
>>> To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org; dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
>>> Subject: [PATCH 5/5] drm/amdgpu: replace iova debugfs file with iomem
>>>
>>> This allows access to pages allocated through the driver with 
>>> optional IOMMU mapping.
>>>
>>> Signed-off-by: Christian König <christian.koenig-5C7GfCeVMHo@public.gmane.org>
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 57 
>>> ++++++++++++++++++++-------------
>>>   1 file changed, 35 insertions(+), 22 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>>> index 648c449aaa79..795ceaeb82d5 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>>> @@ -1929,38 +1929,51 @@ static const struct file_operations 
>>> amdgpu_ttm_gtt_fops = {
>>>     #endif
>>>   -static ssize_t amdgpu_iova_to_phys_read(struct file *f, char 
>>> __user *buf,
>>> -                   size_t size, loff_t *pos)
>>> +static ssize_t amdgpu_iomem_read(struct file *f, char __user *buf,
>>> +                 size_t size, loff_t *pos)
>>>   {
>>>       struct amdgpu_device *adev = file_inode(f)->i_private;
>>> -    int r;
>>> -    uint64_t phys;
>>>       struct iommu_domain *dom;
>>> +    ssize_t result = 0;
>>> +    int r;
>>>   -    // always return 8 bytes
>>> -    if (size != 8)
>>> -        return -EINVAL;
>>> +    dom = iommu_get_domain_for_dev(adev->dev);
>>>   -    // only accept page addresses
>>> -    if (*pos & 0xFFF)
>>> -        return -EINVAL;
>>> +    while (size) {
>>> +        phys_addr_t addr = *pos & PAGE_MASK;
>>> +        loff_t off = *pos & ~PAGE_MASK;
>>> +        size_t bytes = PAGE_SIZE - off;
>>> +        unsigned long pfn;
>>> +        struct page *p;
>>> +        void *ptr;
>>>   -    dom = iommu_get_domain_for_dev(adev->dev);
>>> -    if (dom)
>>> -        phys = iommu_iova_to_phys(dom, *pos);
>>> -    else
>>> -        phys = *pos;
>>> +        addr = dom ? iommu_iova_to_phys(dom, addr) : addr;
>>>   -    r = copy_to_user(buf, &phys, 8);
>>> -    if (r)
>>> -        return -EFAULT;
>>> +        pfn = addr >> PAGE_SHIFT;
>>> +        if (!pfn_valid(pfn))
>>> +            return -EPERM;
>>> +
>>> +        p = pfn_to_page(pfn);
>>> +        if (p->mapping != adev->mman.bdev.dev_mapping)
>>> +            return -EPERM;
>>> +
>>> +        ptr = kmap(p);
>>> +        r = copy_to_user(buf, ptr, bytes);
>>> +        kunmap(p);
>>> +        if (r)
>>> +            return -EFAULT;
>>>   -    return 8;
>>> +        size -= bytes;
>>> +        *pos += bytes;
>>> +        result += bytes;
>>> +    }
>>> +
>>> +    return result;
>>>   }
>>>   -static const struct file_operations amdgpu_ttm_iova_fops = {
>>> +static const struct file_operations amdgpu_ttm_iomem_fops = {
>>>       .owner = THIS_MODULE,
>>> -    .read = amdgpu_iova_to_phys_read,
>>> +    .read = amdgpu_iomem_read,
>>>       .llseek = default_llseek
>>>   };
>>>   @@ -1973,7 +1986,7 @@ static const struct {  #ifdef 
>>> CONFIG_DRM_AMDGPU_GART_DEBUGFS
>>>       { "amdgpu_gtt", &amdgpu_ttm_gtt_fops, TTM_PL_TT }, #endif
>>> -    { "amdgpu_iova", &amdgpu_ttm_iova_fops, TTM_PL_SYSTEM },
>>> +    { "amdgpu_iomem", &amdgpu_ttm_iomem_fops, TTM_PL_SYSTEM },
>>>   };
>>>     #endif
>>> -- 
>>> 2.14.1
>>>
>>> _______________________________________________
>>> dri-devel mailing list
>>> dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
>>> https://lists.freedesktop.org/mailman/listinfo/dri-devel
>>> _______________________________________________
>>> amd-gfx mailing list
>>> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
>>> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>>>
>>
> 


--------------E0CFB1D095300CED87AD3D40
Content-Type: text/x-patch;
 name="0001-add-support-for-new-iomem-debugfs-entry.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="0001-add-support-for-new-iomem-debugfs-entry.patch"

>From 67703a62763dfb2107bd503c5ae76414a50c50a4 Mon Sep 17 00:00:00 2001
From: Tom St Denis <tom.stdenis-5C7GfCeVMHo@public.gmane.org>
Date: Mon, 5 Feb 2018 08:53:40 -0500
Subject: [PATCH umr] add support for new iomem debugfs entry

Signed-off-by: Tom St Denis <tom.stdenis-5C7GfCeVMHo@public.gmane.org>
---
 src/lib/close_asic.c |  1 +
 src/lib/discover.c   |  3 +++
 src/lib/read_vram.c  | 29 +++++++++++++++++++----------
 src/umr.h            |  3 ++-
 4 files changed, 25 insertions(+), 11 deletions(-)

diff --git a/src/lib/close_asic.c b/src/lib/close_asic.c
index 782b1a0d029b..6b220cd578e9 100644
--- a/src/lib/close_asic.c
+++ b/src/lib/close_asic.c
@@ -57,6 +57,7 @@ void umr_close_asic(struct umr_asic *asic)
 		cond_close(asic->fd.gpr);
 		cond_close(asic->fd.drm);
 		cond_close(asic->fd.iova);
+		cond_close(asic->fd.iomem);
 		umr_free_asic(asic);
 	}
 }
diff --git a/src/lib/discover.c b/src/lib/discover.c
index 4af3733c8af8..dedcedc776ab 100644
--- a/src/lib/discover.c
+++ b/src/lib/discover.c
@@ -232,6 +232,8 @@ struct umr_asic *umr_discover_asic(struct umr_options *options)
 			asic->fd.gpr = open(fname, O_RDWR);
 			snprintf(fname, sizeof(fname)-1, "/sys/kernel/debug/dri/%d/amdgpu_iova", asic->instance);
 			asic->fd.iova = open(fname, O_RDWR);
+			snprintf(fname, sizeof(fname)-1, "/sys/kernel/debug/dri/%d/amdgpu_iomem", asic->instance);
+			asic->fd.iomem = open(fname, O_RDWR);
 			asic->fd.drm = -1; // default to closed
 			// if appending to the fd list remember to update close_asic() and discover_by_did()...
 		} else {
@@ -246,6 +248,7 @@ struct umr_asic *umr_discover_asic(struct umr_options *options)
 			asic->fd.gpr = -1;
 			asic->fd.drm = -1;
 			asic->fd.iova = -1;
+			asic->fd.iomem = -1;
 		}
 
 		if (options->use_pci) {
diff --git a/src/lib/read_vram.c b/src/lib/read_vram.c
index 25ffec93f54d..c685955e5050 100644
--- a/src/lib/read_vram.c
+++ b/src/lib/read_vram.c
@@ -73,30 +73,39 @@ static void access_vram_via_mmio(struct umr_asic *asic, uint64_t address, uint32
 #define DEBUG(...)
 #endif
 
-static int umr_access_sram(uint64_t address, uint32_t size, void *dst, int write_en)
+static int umr_access_sram(struct umr_asic *asic, uint64_t address, uint32_t size, void *dst, int write_en)
 {
-	int fd;
+	int fd, need_close=0;
 
 	DEBUG("Reading physical sys addr: 0x%llx\n", (unsigned long long)address);
 
-	fd = open("/dev/fmem", O_RDWR);
-	if (fd < 0)
-		fd = open("/dev/mem", O_RDWR | O_DSYNC);
+	if (asic->fd.iomem >= 0) {
+		fd = asic->fd.iomem;
+	} else {
+		need_close = 1;
+
+		fd = open("/dev/fmem", O_RDWR);
+		if (fd < 0)
+			fd = open("/dev/mem", O_RDWR | O_DSYNC);
+	}
 	if (fd >= 0) {
 		lseek(fd, address, SEEK_SET);
 		if (write_en == 0) {
 			memset(dst, 0xFF, size);
 			if (read(fd, dst, size) != size) {
-				close(fd);
+				if (need_close)
+					close(fd);
 				return -1;
 			}
 		} else {
 			if (write(fd, dst, size) != size) {
-				close(fd);
+				if (need_close)
+					close(fd);
 				return -1;
 			}
 		}
-		close(fd);
+		if (need_close)
+			close(fd);
 		return 0;
 	}
 	return -1;
@@ -292,7 +301,7 @@ next_page:
 		// allow destination to be NULL to simply use decoder
 		if (pdst) {
 			if (pte_fields.system) {
-				if (umr_access_sram(start_addr, chunk_size, pdst, write_en) < 0) {
+				if (umr_access_sram(asic, start_addr, chunk_size, pdst, write_en) < 0) {
 					fprintf(stderr, "[ERROR]: Cannot access system ram, perhaps CONFIG_STRICT_DEVMEM is set in your kernel config?\n");
 					fprintf(stderr, "[ERROR]: Alternatively download and install /dev/fmem\n");
 					return -1;
@@ -663,7 +672,7 @@ next_page:
 		if (pte_fields.valid) {
 			if (pdst) {
 				if (pte_fields.system) {
-					if (umr_access_sram(start_addr, chunk_size, pdst, write_en) < 0) {
+					if (umr_access_sram(asic, start_addr, chunk_size, pdst, write_en) < 0) {
 						fprintf(stderr, "[ERROR]: Cannot access system ram, perhaps CONFIG_STRICT_DEVMEM is set in your kernel config?\n");
 						fprintf(stderr, "[ERROR]: Alternatively download and install /dev/fmem\n");
 						return -1;
diff --git a/src/umr.h b/src/umr.h
index 9c006f00cf45..da67abf6dc2b 100644
--- a/src/umr.h
+++ b/src/umr.h
@@ -233,7 +233,8 @@ struct umr_asic {
 		    wave,
 		    vram,
 		    gpr,
-		    iova;
+		    iova,
+		    iomem;
 	} fd;
 	struct {
 		struct pci_device *pdevice;
-- 
2.14.3


--------------E0CFB1D095300CED87AD3D40
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--------------E0CFB1D095300CED87AD3D40--
