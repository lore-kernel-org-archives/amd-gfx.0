From: Felix Kuehling <felix.kuehling-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: Improve Vega10 VM fault handling
Date: Tue, 28 Mar 2017 14:10:23 -0400
Message-ID: <e518dba8-03c1-5b8f-99a1-e0f7f5254c2f@amd.com>
References: <1490653526-30073-1-git-send-email-Felix.Kuehling@amd.com>
 <58D9BB23.4070009@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------19EEF6BC419C35C4604B7755"
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <58D9BB23.4070009-5C7GfCeVMHo@public.gmane.org>
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
To: "Zhang, Jerry (Junwei)" <Jerry.Zhang-5C7GfCeVMHo@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

--------------19EEF6BC419C35C4604B7755
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit


On 17-03-27 09:23 PM, Zhang, Jerry (Junwei) wrote:
>
>
> On 03/28/2017 06:25 AM, Felix Kuehling wrote:
>> Register AMDGPU_IH_CLIENTID_UTCL2 as a source of VM faults. Clean
>> up the VM fault message format and use rate-limiting similar to
>> other ASICs.
>>
>> Signed-off-by: Felix Kuehling <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>
>
> May be better to split it into 2 patches
> Reviewed-by: Junwei Zhang <Jerry.Zhang-5C7GfCeVMHo@public.gmane.org>

I had to rebase my patch and had to resolve a conflict with an SRIOV
change that just landed. So I split it into two commits while I was at
it. Please review the attached patches.

Thanks,
  Felix


>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c | 19 +++++++++++++------
>>   1 file changed, 13 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
>> b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
>> index 232c208..9831025 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
>> @@ -145,12 +145,17 @@ static int gmc_v9_0_process_interrupt(struct
>> amdgpu_device *adev,
>>           WREG32_P(gfxhub->vm_l2_pro_fault_cntl, 1, ~1);
>>       }
>>
>> -    DRM_ERROR("[%s]VMC page fault (src_id:%u ring:%u vm_id:%u
>> pas_id:%u) "
>> -          "at page 0x%016llx from %d\n"
>> -          "VM_L2_PROTECTION_FAULT_STATUS:0x%08X\n",
>> -          entry->vm_id_src ? "mmhub" : "gfxhub",
>> -          entry->src_id, entry->ring_id, entry->vm_id, entry->pas_id,
>> -          addr, entry->client_id, status);
>> +    if (printk_ratelimit()) {
>> +        dev_err(adev->dev,
>> +            "[%s] VMC page fault (src_id:%u ring:%u vm_id:%u
>> pas_id:%u)\n",
>> +            entry->vm_id_src ? "mmhub" : "gfxhub",
>> +            entry->src_id, entry->ring_id, entry->vm_id,
>> +            entry->pas_id);
>> +        dev_err(adev->dev, "  at page 0x%016llx from %d\n",
>> +            addr, entry->client_id);
>> +        dev_err(adev->dev, "VM_L2_PROTECTION_FAULT_STATUS:0x%08X\n",
>> +            status);
>> +    }
>>
>>       return 0;
>>   }
>> @@ -539,6 +544,8 @@ static int gmc_v9_0_sw_init(void *handle)
>>       /* This interrupt is VMC page fault.*/
>>       r = amdgpu_irq_add_id(adev, AMDGPU_IH_CLIENTID_VMC, 0,
>>                   &adev->mc.vm_fault);
>> +    r = amdgpu_irq_add_id(adev, AMDGPU_IH_CLIENTID_UTCL2, 0,
>> +                &adev->mc.vm_fault);
>>
>>       if (r)
>>           return r;
>>


--------------19EEF6BC419C35C4604B7755
Content-Type: text/x-patch;
	name="0001-drm-amdgpu-Register-UTCL2-as-a-source-of-VM-faults.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename*0="0001-drm-amdgpu-Register-UTCL2-as-a-source-of-VM-faults.patc";
	filename*1="h"

>From 9690de839e9ee7f6fc31cd777ffde8770858edb0 Mon Sep 17 00:00:00 2001
From: Felix Kuehling <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>
Date: Tue, 28 Mar 2017 13:41:11 -0400
Subject: [PATCH 1/2] drm/amdgpu: Register UTCL2 as a source of VM faults

Signed-off-by: Felix Kuehling <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 87bea71..981d3d9 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -556,6 +556,8 @@ static int gmc_v9_0_sw_init(void *handle)
 	/* This interrupt is VMC page fault.*/
 	r = amdgpu_irq_add_id(adev, AMDGPU_IH_CLIENTID_VMC, 0,
 				&adev->mc.vm_fault);
+	r = amdgpu_irq_add_id(adev, AMDGPU_IH_CLIENTID_UTCL2, 0,
+				&adev->mc.vm_fault);
 
 	if (r)
 		return r;
-- 
1.9.1


--------------19EEF6BC419C35C4604B7755
Content-Type: text/x-patch;
	name="0002-drm-amdgpu-Clean-up-GFX-9-VM-fault-messages.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="0002-drm-amdgpu-Clean-up-GFX-9-VM-fault-messages.patch"

>From 9d47433ae1e799cacab2b002c75fcda41543beed Mon Sep 17 00:00:00 2001
From: Felix Kuehling <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>
Date: Tue, 28 Mar 2017 13:42:31 -0400
Subject: [PATCH 2/2] drm/amdgpu: Clean up GFX 9 VM fault messages

Clean up the VM fault message format and use rate-limiting similar
to other ASICs.

Signed-off-by: Felix Kuehling <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 981d3d9..1e4734d 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -131,7 +131,7 @@ static int gmc_v9_0_process_interrupt(struct amdgpu_device *adev,
 {
 	struct amdgpu_vmhub *gfxhub = &adev->vmhub[AMDGPU_GFXHUB];
 	struct amdgpu_vmhub *mmhub = &adev->vmhub[AMDGPU_MMHUB];
-	uint32_t status;
+	uint32_t status = 0;
 	u64 addr;
 
 	addr = (u64)entry->src_data[0] << 12;
@@ -145,19 +145,20 @@ static int gmc_v9_0_process_interrupt(struct amdgpu_device *adev,
 			status = RREG32(gfxhub->vm_l2_pro_fault_status);
 			WREG32_P(gfxhub->vm_l2_pro_fault_cntl, 1, ~1);
 		}
+	}
 
-		DRM_ERROR("[%s]VMC page fault (src_id:%u ring:%u vm_id:%u pas_id:%u) "
-		  "at page 0x%016llx from %d\n"
-		  "VM_L2_PROTECTION_FAULT_STATUS:0x%08X\n",
-		  entry->vm_id_src ? "mmhub" : "gfxhub",
-		  entry->src_id, entry->ring_id, entry->vm_id, entry->pas_id,
-		  addr, entry->client_id, status);
-	} else {
-		DRM_ERROR("[%s]VMC page fault (src_id:%u ring:%u vm_id:%u pas_id:%u) "
-		  "at page 0x%016llx from %d\n",
-		  entry->vm_id_src ? "mmhub" : "gfxhub",
-		  entry->src_id, entry->ring_id, entry->vm_id, entry->pas_id,
-		  addr, entry->client_id);
+	if (printk_ratelimit()) {
+		dev_err(adev->dev,
+			"[%s] VMC page fault (src_id:%u ring:%u vm_id:%u pas_id:%u)\n",
+			entry->vm_id_src ? "mmhub" : "gfxhub",
+			entry->src_id, entry->ring_id, entry->vm_id,
+			entry->pas_id);
+		dev_err(adev->dev, "  at page 0x%016llx from %d\n",
+			addr, entry->client_id);
+		if (!amdgpu_sriov_vf(adev))
+			dev_err(adev->dev,
+				"VM_L2_PROTECTION_FAULT_STATUS:0x%08X\n",
+				status);
 	}
 
 	return 0;
-- 
1.9.1


--------------19EEF6BC419C35C4604B7755
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--------------19EEF6BC419C35C4604B7755--
