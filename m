From: Mario Kleiner <mario.kleiner.de@gmail.com>
Subject: Re: [PATCH] drm/i915: Before pageflip, also wait for shared dmabuf
 fences.
Date: Fri, 28 Oct 2016 19:37:28 +0200
Message-ID: <7eb19a73-a558-d2e6-bd8d-34fe95045dfd@gmail.com>
References: <3f4643cb-52a9-d7ae-439b-5f6fc6e718cc@vodafone.de>
 <20160922063625.GD22164@dvetter-linux.ger.corp.intel.com>
 <b95726e7-6bf6-a1b8-2a63-0758b1b185e2@vodafone.de>
 <CAKMK7uF13M7d8qRRwKs_8M-QHjnuB7k3jshTUDnccTTQf6unog@mail.gmail.com>
 <ddf99e2a-5f9a-41b9-9fde-af7bfd522572@vodafone.de>
 <CAKMK7uEidoKbTO-m3KSz8UmQhF+uorg2-cWY8UpOXjZ_9MCxLg@mail.gmail.com>
 <d2430ff8-43bd-bff2-9b02-847cabfd56c0@vodafone.de>
 <ed1a57a4-1409-6d07-998a-2b54f466f710@daenzer.net>
 <20160923120954.GH22164@dvetter-linux.ger.corp.intel.com>
 <8c21f70a-7f96-480e-9784-93f2d48f52bb@daenzer.net>
 <20160926080419.GV20761@phenom.ffwll.local>
 <CAHbf0-HZ6EotqwgvkxRTdRF97xB3qBA=DRKAzaAXguV_PR_P8w@mail.gmail.com>
 <d74d34a7-5221-d282-d9d1-b0e1007fc0c7@daenzer.net>
 <c77a2cb9-1f0e-f1a3-aedd-a111cd6ba8e8@vodafone.de>
 <e92512c7-4fb5-6fa1-e93f-0322d1537c46@daenzer.net>
 <CAHbf0-GGMWZrhB+PKpc-QbD__6fqB4pQVFfN+gzLWNhi+DuG3Q@mail.gmail.com>
 <720351a2-7597-aee3-58ce-9d65cad5762f@daenzer.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------21E73F7677855EB9ABB04C72"
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <720351a2-7597-aee3-58ce-9d65cad5762f@daenzer.net>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>, Mike Lothian <mike@fireburn.co.uk>, =?UTF-8?Q?Christian_K=c3=b6nig?= <deathsimple@vodafone.de>, Daniel Vetter <daniel@ffwll.ch>
Cc: Nayan Deshmukh <nayan26deshmukh@gmail.com>, amd-gfx list <amd-gfx@lists.freedesktop.org>, dri-devel <dri-devel@lists.freedesktop.org>
List-Id: amd-gfx.lists.freedesktop.org

This is a multi-part message in MIME format.
--------------21E73F7677855EB9ABB04C72
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit



On 10/28/2016 03:34 AM, Michel Dänzer wrote:
> On 27/10/16 10:33 PM, Mike Lothian wrote:
>>
>> Just another gentle ping to see where you are with this?
>
> I haven't got a chance to look into this any further.
>
>

Fwiw., as a proof of concept, the attached experimental patch does work 
as tested on Intel HD Haswell + AMD R9 380 Tonga under amdgpu and 
DRI3/Present when applied to drm-next (updated from a few days ago). 
With DRI_PRIME=1 tearing for page-flipped fullscreen windows is gone 
under all loads. The tearing with "windowed" windows now looks as 
expected for regular tearing not related to Prime.

ftrace confirms the i915 driver's pageflip function is waiting on the 
fence in reservation_object_wait_timeout_rcu() as it should.

That entry->tv.shared needs to be set false for such buffers in 
amdgpu_bo_list_set() makes sense to me, as that is part of the buffer 
validation for command stream submission. There are other places in the 
driver where tv.shared is set, which i didn't check so far.

I don't know which of these would need to be updated with a "exported 
bo" check as well, e.g., for video decoding or maybe gpu compute? Adding 
or removing the check to amdgpu_gem_va_update_vm(), e.g., made no 
difference. I assume that makes sense because that functions seems to 
deal with amdgpu internal vm page tables or page table entries for such 
a bo, not with something visible to external clients?

All i can say is it fixes 3D rendering under DRI3 + Prime + pageflipping 
without causing any obvious new problems.

-mario

--------------21E73F7677855EB9ABB04C72
Content-Type: text/x-patch;
 name="0001-drm-amdgpu-Attach-exclusive-fence-to-prime-exported-.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-drm-amdgpu-Attach-exclusive-fence-to-prime-exported-.pa";
 filename*1="tch"

>From 2a8d7fcd36da30305fa675df311c697162792597 Mon Sep 17 00:00:00 2001
From: Mario Kleiner <mario.kleiner.de@gmail.com>
Date: Wed, 26 Oct 2016 10:58:00 +0200
Subject: [PATCH] drm/amdgpu: Attach exclusive fence to prime exported bo's.

External clients which import our bo's wait only
for exclusive dmabuf-fences, not on shared ones,
so attach fences on such exported buffers as
exclusive ones, not shared ones.

-> Backup commit. Work in progress.

Signed-off-by: Mario Kleiner <mario.kleiner.de@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h         | 1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c | 5 ++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c     | 6 ++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_prime.c   | 3 +++
 4 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 039b57e..a337d56 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -459,6 +459,7 @@ struct amdgpu_bo {
 	u64				metadata_flags;
 	void				*metadata;
 	u32				metadata_size;
+	bool				prime_exported;
 	/* list of all virtual address to which this bo
 	 * is associated to
 	 */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c
index 651115d..6e1d7b3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c
@@ -132,7 +132,10 @@ static int amdgpu_bo_list_set(struct amdgpu_device *adev,
 		entry->priority = min(info[i].bo_priority,
 				      AMDGPU_BO_LIST_MAX_PRIORITY);
 		entry->tv.bo = &entry->robj->tbo;
-		entry->tv.shared = true;
+		entry->tv.shared = !entry->robj->prime_exported;
+
+		if (entry->robj->prime_exported)
+		    DRM_DEBUG_PRIME("Exclusive fence for exported prime bo %p\n", entry->robj);
 
 		if (entry->robj->prefered_domains == AMDGPU_GEM_DOMAIN_GDS)
 			gds_obj = entry->robj;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
index a7ea9a3..730a68e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
@@ -494,6 +494,12 @@ static void amdgpu_gem_va_update_vm(struct amdgpu_device *adev,
 
 	tv.bo = &bo_va->bo->tbo;
 	tv.shared = true;
+
+	if (bo_va->bo->prime_exported) {
+	    DRM_DEBUG_PRIME("Update for exported prime bo %p\n", bo_va->bo);
+	    /* tv.shared = false; */
+	}
+
 	list_add(&tv.head, &list);
 
 	amdgpu_vm_get_pd_bo(bo_va->vm, &list, &vm_pd);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_prime.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_prime.c
index 7700dc2..bfbfeb9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_prime.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_prime.c
@@ -121,5 +121,8 @@ struct dma_buf *amdgpu_gem_prime_export(struct drm_device *dev,
 	if (amdgpu_ttm_tt_get_usermm(bo->tbo.ttm))
 		return ERR_PTR(-EPERM);
 
+	bo->prime_exported = true;
+	DRM_DEBUG_PRIME("Exporting prime bo %p\n", bo);
+
 	return drm_gem_prime_export(dev, gobj, flags);
 }
-- 
2.7.4


--------------21E73F7677855EB9ABB04C72
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVs
IG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==

--------------21E73F7677855EB9ABB04C72--
