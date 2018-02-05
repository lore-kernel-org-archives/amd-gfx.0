From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 3/9] drm/amdkfd: Make IOMMUv2 code conditional
Date: Mon, 5 Feb 2018 20:00:22 +0100
Message-ID: <044a3842-92d1-fe2a-c432-0719e8528416@gmail.com>
References: <1515104268-25087-1-git-send-email-Felix.Kuehling@amd.com>
 <1515104268-25087-4-git-send-email-Felix.Kuehling@amd.com>
 <CAFCwf125cHCf=fsfiMhhASjgMNEcau04gNGKKHFu7PQGeorpZQ@mail.gmail.com>
 <CAFCwf12pqRA4KdRLpkUmiBs7EQmTePcy80V2kP9mP3pN8V-eTg@mail.gmail.com>
 <5a1e7696-b5bf-547c-4fe6-e71e0ae7f5e0@amd.com>
Reply-To: christian.koenig-5C7GfCeVMHo@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1142501818=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <5a1e7696-b5bf-547c-4fe6-e71e0ae7f5e0-5C7GfCeVMHo@public.gmane.org>
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
To: Felix Kuehling <felix.kuehling-5C7GfCeVMHo@public.gmane.org>, Oded Gabbay <oded.gabbay-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

This is a multi-part message in MIME format.
--===============1142501818==
Content-Type: multipart/alternative;
 boundary="------------447CF3450049AB6687E85ABB"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------447CF3450049AB6687E85ABB
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

Looks good to me on first glance.

You probably don't mind that I'm going to pull a good part of that into 
amdgpu as next step?

Regards,
Christian.

Am 03.02.2018 um 03:29 schrieb Felix Kuehling:
> The attached patch is my attempt to keep most of the IOMMU code in one
> place (new kfd_iommu.c) to avoid #ifdefs all over the place. This way I
> can still conditionally compile a bunch of KFD code that is only needed
> for IOMMU handling, with stub functions for kernel configs without IOMMU
> support. About 300 lines of conditionally compiled code got moved to
> kfd_iommu.c.
>
> The only piece I didn't move into kfd_iommu.c is
> kfd_signal_iommu_event. I prefer to keep that in kfd_events.c because it
> doesn't call any IOMMU driver functions, and because it's closely
> related to the rest of the event handling logic. It could be compiled
> unconditionally, but it would be dead code without IOMMU support.
>
> And I moved pdd->bound to a place where it doesn't consume extra space
> (on 64-bit systems due to structure alignment) instead of making it
> conditional.
>
> This is only compile-tested for now.
>
> If you like this approach, I'll do more testing and squash it with "Make
> IOMMUv2 code conditional".
>
> Regards,
>    Felix
>
>
> On 2018-01-31 10:00 AM, Oded Gabbay wrote:
>> On Wed, Jan 31, 2018 at 4:56 PM, Oded Gabbay <oded.gabbay-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
>>> Hi Felix,
>>> Please don't spread 19 #ifdefs throughout the code.
>>> I suggest to put one #ifdef in linux/amd-iommu.h itself around all the
>>> functions declarations and in the #else section put macros with empty
>>> implementations. This is much more readable and maintainable.
>>>
>>> Oded
>> To emphasize my point, there is a call to amd_iommu_bind_pasid in
>> kfd_bind_processes_to_device() which isn't wrapped with the #ifdef so
>> the compliation breaks. Putting the #ifdefs around the calls is simply
>> not scalable.
>>
>> Oded
>>
>>> On Fri, Jan 5, 2018 at 12:17 AM, Felix Kuehling <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org> wrote:
>>>> dGPUs work without IOMMUv2. Make IOMMUv2 initialization dependent on
>>>> ASIC information. Also allow building KFD without IOMMUv2 support.
>>>> This is still useful for dGPUs and prepares for enabling KFD on
>>>> architectures that don't support AMD IOMMUv2.
>>>>
>>>> Signed-off-by: Felix Kuehling <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>
>>>> ---
>>>>   drivers/gpu/drm/amd/amdkfd/Kconfig        |  2 +-
>>>>   drivers/gpu/drm/amd/amdkfd/kfd_crat.c     |  8 +++-
>>>>   drivers/gpu/drm/amd/amdkfd/kfd_device.c   | 62 +++++++++++++++++++++----------
>>>>   drivers/gpu/drm/amd/amdkfd/kfd_events.c   |  2 +
>>>>   drivers/gpu/drm/amd/amdkfd/kfd_priv.h     |  5 +++
>>>>   drivers/gpu/drm/amd/amdkfd/kfd_process.c  | 17 ++++++---
>>>>   drivers/gpu/drm/amd/amdkfd/kfd_topology.c |  2 +
>>>>   drivers/gpu/drm/amd/amdkfd/kfd_topology.h |  2 +
>>>>   8 files changed, 74 insertions(+), 26 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdkfd/Kconfig b/drivers/gpu/drm/amd/amdkfd/Kconfig
>>>> index bc5a294..5bbeb95 100644
>>>> --- a/drivers/gpu/drm/amd/amdkfd/Kconfig
>>>> +++ b/drivers/gpu/drm/amd/amdkfd/Kconfig
>>>> @@ -4,6 +4,6 @@
>>>>
>>>>   config HSA_AMD
>>>>          tristate "HSA kernel driver for AMD GPU devices"
>>>> -       depends on DRM_AMDGPU && AMD_IOMMU_V2 && X86_64
>>>> +       depends on DRM_AMDGPU && X86_64
>>>>          help
>>>>            Enable this if you want to use HSA features on AMD GPU devices.
>>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
>>>> index 2bc2816..3478270 100644
>>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
>>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
>>>> @@ -22,7 +22,9 @@
>>>>
>>>>   #include <linux/pci.h>
>>>>   #include <linux/acpi.h>
>>>> +#if defined(CONFIG_AMD_IOMMU_V2_MODULE) || defined(CONFIG_AMD_IOMMU_V2)
>>>>   #include <linux/amd-iommu.h>
>>>> +#endif
>>>>   #include "kfd_crat.h"
>>>>   #include "kfd_priv.h"
>>>>   #include "kfd_topology.h"
>>>> @@ -1037,15 +1039,17 @@ static int kfd_create_vcrat_image_gpu(void *pcrat_image,
>>>>          struct crat_subtype_generic *sub_type_hdr;
>>>>          struct crat_subtype_computeunit *cu;
>>>>          struct kfd_cu_info cu_info;
>>>> -       struct amd_iommu_device_info iommu_info;
>>>>          int avail_size = *size;
>>>>          uint32_t total_num_of_cu;
>>>>          int num_of_cache_entries = 0;
>>>>          int cache_mem_filled = 0;
>>>>          int ret = 0;
>>>> +#if defined(CONFIG_AMD_IOMMU_V2_MODULE) || defined(CONFIG_AMD_IOMMU_V2)
>>>> +       struct amd_iommu_device_info iommu_info;
>>>>          const u32 required_iommu_flags = AMD_IOMMU_DEVICE_FLAG_ATS_SUP |
>>>>                                           AMD_IOMMU_DEVICE_FLAG_PRI_SUP |
>>>>                                           AMD_IOMMU_DEVICE_FLAG_PASID_SUP;
>>>> +#endif
>>>>          struct kfd_local_mem_info local_mem_info;
>>>>
>>>>          if (!pcrat_image || avail_size < VCRAT_SIZE_FOR_GPU)
>>>> @@ -1106,12 +1110,14 @@ static int kfd_create_vcrat_image_gpu(void *pcrat_image,
>>>>          /* Check if this node supports IOMMU. During parsing this flag will
>>>>           * translate to HSA_CAP_ATS_PRESENT
>>>>           */
>>>> +#if defined(CONFIG_AMD_IOMMU_V2_MODULE) || defined(CONFIG_AMD_IOMMU_V2)
>>>>          iommu_info.flags = 0;
>>>>          if (amd_iommu_device_info(kdev->pdev, &iommu_info) == 0) {
>>>>                  if ((iommu_info.flags & required_iommu_flags) ==
>>>>                                  required_iommu_flags)
>>>>                          cu->hsa_capability |= CRAT_CU_FLAGS_IOMMU_PRESENT;
>>>>          }
>>>> +#endif
>>>>
>>>>          crat_table->length += sub_type_hdr->length;
>>>>          crat_table->total_entries++;
>>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
>>>> index fafe971..5205b34 100644
>>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
>>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
>>>> @@ -20,7 +20,9 @@
>>>>    * OTHER DEALINGS IN THE SOFTWARE.
>>>>    */
>>>>
>>>> +#if defined(CONFIG_AMD_IOMMU_V2_MODULE) || defined(CONFIG_AMD_IOMMU_V2)
>>>>   #include <linux/amd-iommu.h>
>>>> +#endif
>>>>   #include <linux/bsearch.h>
>>>>   #include <linux/pci.h>
>>>>   #include <linux/slab.h>
>>>> @@ -31,6 +33,7 @@
>>>>
>>>>   #define MQD_SIZE_ALIGNED 768
>>>>
>>>> +#if defined(CONFIG_AMD_IOMMU_V2_MODULE) || defined(CONFIG_AMD_IOMMU_V2)
>>>>   static const struct kfd_device_info kaveri_device_info = {
>>>>          .asic_family = CHIP_KAVERI,
>>>>          .max_pasid_bits = 16,
>>>> @@ -41,6 +44,7 @@ static const struct kfd_device_info kaveri_device_info = {
>>>>          .num_of_watch_points = 4,
>>>>          .mqd_size_aligned = MQD_SIZE_ALIGNED,
>>>>          .supports_cwsr = false,
>>>> +       .needs_iommu_device = true,
>>>>          .needs_pci_atomics = false,
>>>>   };
>>>>
>>>> @@ -54,8 +58,10 @@ static const struct kfd_device_info carrizo_device_info = {
>>>>          .num_of_watch_points = 4,
>>>>          .mqd_size_aligned = MQD_SIZE_ALIGNED,
>>>>          .supports_cwsr = true,
>>>> +       .needs_iommu_device = true,
>>>>          .needs_pci_atomics = false,
>>>>   };
>>>> +#endif
>>>>
>>>>   struct kfd_deviceid {
>>>>          unsigned short did;
>>>> @@ -64,6 +70,7 @@ struct kfd_deviceid {
>>>>
>>>>   /* Please keep this sorted by increasing device id. */
>>>>   static const struct kfd_deviceid supported_devices[] = {
>>>> +#if defined(CONFIG_AMD_IOMMU_V2_MODULE) || defined(CONFIG_AMD_IOMMU_V2)
>>>>          { 0x1304, &kaveri_device_info },        /* Kaveri */
>>>>          { 0x1305, &kaveri_device_info },        /* Kaveri */
>>>>          { 0x1306, &kaveri_device_info },        /* Kaveri */
>>>> @@ -91,6 +98,7 @@ static const struct kfd_deviceid supported_devices[] = {
>>>>          { 0x9875, &carrizo_device_info },       /* Carrizo */
>>>>          { 0x9876, &carrizo_device_info },       /* Carrizo */
>>>>          { 0x9877, &carrizo_device_info }        /* Carrizo */
>>>> +#endif
>>>>   };
>>>>
>>>>   static int kfd_gtt_sa_init(struct kfd_dev *kfd, unsigned int buf_size,
>>>> @@ -161,6 +169,7 @@ struct kfd_dev *kgd2kfd_probe(struct kgd_dev *kgd,
>>>>          return kfd;
>>>>   }
>>>>
>>>> +#if defined(CONFIG_AMD_IOMMU_V2_MODULE) || defined(CONFIG_AMD_IOMMU_V2)
>>>>   static bool device_iommu_pasid_init(struct kfd_dev *kfd)
>>>>   {
>>>>          const u32 required_iommu_flags = AMD_IOMMU_DEVICE_FLAG_ATS_SUP |
>>>> @@ -231,6 +240,7 @@ static int iommu_invalid_ppr_cb(struct pci_dev *pdev, int pasid,
>>>>
>>>>          return AMD_IOMMU_INV_PRI_RSP_INVALID;
>>>>   }
>>>> +#endif /* CONFIG_AMD_IOMMU_V2 */
>>>>
>>>>   static void kfd_cwsr_init(struct kfd_dev *kfd)
>>>>   {
>>>> @@ -321,12 +331,14 @@ bool kgd2kfd_device_init(struct kfd_dev *kfd,
>>>>                  goto device_queue_manager_error;
>>>>          }
>>>>
>>>> -       if (!device_iommu_pasid_init(kfd)) {
>>>> -               dev_err(kfd_device,
>>>> -                       "Error initializing iommuv2 for device %x:%x\n",
>>>> -                       kfd->pdev->vendor, kfd->pdev->device);
>>>> -               goto device_iommu_pasid_error;
>>>> +#if defined(CONFIG_AMD_IOMMU_V2_MODULE) || defined(CONFIG_AMD_IOMMU_V2)
>>>> +       if (kfd->device_info->needs_iommu_device) {
>>>> +               if (!device_iommu_pasid_init(kfd)) {
>>>> +                       dev_err(kfd_device, "Error initializing iommuv2\n");
>>>> +                       goto device_iommu_pasid_error;
>>>> +               }
>>>>          }
>>>> +#endif
>>>>
>>>>          kfd_cwsr_init(kfd);
>>>>
>>>> @@ -386,11 +398,16 @@ void kgd2kfd_suspend(struct kfd_dev *kfd)
>>>>
>>>>          kfd->dqm->ops.stop(kfd->dqm);
>>>>
>>>> +#if defined(CONFIG_AMD_IOMMU_V2_MODULE) || defined(CONFIG_AMD_IOMMU_V2)
>>>> +       if (!kfd->device_info->needs_iommu_device)
>>>> +               return;
>>>> +
>>>>          kfd_unbind_processes_from_device(kfd);
>>>>
>>>>          amd_iommu_set_invalidate_ctx_cb(kfd->pdev, NULL);
>>>>          amd_iommu_set_invalid_ppr_cb(kfd->pdev, NULL);
>>>>          amd_iommu_free_device(kfd->pdev);
>>>> +#endif
>>>>   }
>>>>
>>>>   int kgd2kfd_resume(struct kfd_dev *kfd)
>>>> @@ -405,19 +422,24 @@ int kgd2kfd_resume(struct kfd_dev *kfd)
>>>>   static int kfd_resume(struct kfd_dev *kfd)
>>>>   {
>>>>          int err = 0;
>>>> -       unsigned int pasid_limit = kfd_get_pasid_limit();
>>>>
>>>> -       err = amd_iommu_init_device(kfd->pdev, pasid_limit);
>>>> -       if (err)
>>>> -               return -ENXIO;
>>>> -       amd_iommu_set_invalidate_ctx_cb(kfd->pdev,
>>>> -                                       iommu_pasid_shutdown_callback);
>>>> -       amd_iommu_set_invalid_ppr_cb(kfd->pdev,
>>>> -                                    iommu_invalid_ppr_cb);
>>>> -
>>>> -       err = kfd_bind_processes_to_device(kfd);
>>>> -       if (err)
>>>> -               goto processes_bind_error;
>>>> +#if defined(CONFIG_AMD_IOMMU_V2_MODULE) || defined(CONFIG_AMD_IOMMU_V2)
>>>> +       if (kfd->device_info->needs_iommu_device) {
>>>> +               unsigned int pasid_limit = kfd_get_pasid_limit();
>>>> +
>>>> +               err = amd_iommu_init_device(kfd->pdev, pasid_limit);
>>>> +               if (err)
>>>> +                       return -ENXIO;
>>>> +               amd_iommu_set_invalidate_ctx_cb(kfd->pdev,
>>>> +                                               iommu_pasid_shutdown_callback);
>>>> +               amd_iommu_set_invalid_ppr_cb(kfd->pdev,
>>>> +                                            iommu_invalid_ppr_cb);
>>>> +
>>>> +               err = kfd_bind_processes_to_device(kfd);
>>>> +               if (err)
>>>> +                       goto processes_bind_error;
>>>> +       }
>>>> +#endif
>>>>
>>>>          err = kfd->dqm->ops.start(kfd->dqm);
>>>>          if (err) {
>>>> @@ -431,8 +453,10 @@ static int kfd_resume(struct kfd_dev *kfd)
>>>>
>>>>   dqm_start_error:
>>>>   processes_bind_error:
>>>> -       amd_iommu_free_device(kfd->pdev);
>>>> -
>>>> +#if defined(CONFIG_AMD_IOMMU_V2_MODULE) || defined(CONFIG_AMD_IOMMU_V2)
>>>> +       if (kfd->device_info->needs_iommu_device)
>>>> +               amd_iommu_free_device(kfd->pdev);
>>>> +#endif
>>>>          return err;
>>>>   }
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_events.c b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
>>>> index 93aae5c..f770dc7 100644
>>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_events.c
>>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
>>>> @@ -837,6 +837,7 @@ static void lookup_events_by_type_and_signal(struct kfd_process *p,
>>>>          }
>>>>   }
>>>>
>>>> +#if defined(CONFIG_AMD_IOMMU_V2_MODULE) || defined(CONFIG_AMD_IOMMU_V2)
>>>>   void kfd_signal_iommu_event(struct kfd_dev *dev, unsigned int pasid,
>>>>                  unsigned long address, bool is_write_requested,
>>>>                  bool is_execute_requested)
>>>> @@ -905,6 +906,7 @@ void kfd_signal_iommu_event(struct kfd_dev *dev, unsigned int pasid,
>>>>          mutex_unlock(&p->event_mutex);
>>>>          kfd_unref_process(p);
>>>>   }
>>>> +#endif /* CONFIG_AMD_IOMMU_V2_MODULE */
>>>>
>>>>   void kfd_signal_hw_exception_event(unsigned int pasid)
>>>>   {
>>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>>>> index eebfb1e..9f4766c 100644
>>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>>>> @@ -158,6 +158,7 @@ struct kfd_device_info {
>>>>          uint8_t num_of_watch_points;
>>>>          uint16_t mqd_size_aligned;
>>>>          bool supports_cwsr;
>>>> +       bool needs_iommu_device;
>>>>          bool needs_pci_atomics;
>>>>   };
>>>>
>>>> @@ -617,9 +618,11 @@ void kfd_unref_process(struct kfd_process *p);
>>>>
>>>>   struct kfd_process_device *kfd_bind_process_to_device(struct kfd_dev *dev,
>>>>                                                  struct kfd_process *p);
>>>> +#if defined(CONFIG_AMD_IOMMU_V2_MODULE) || defined(CONFIG_AMD_IOMMU_V2)
>>>>   int kfd_bind_processes_to_device(struct kfd_dev *dev);
>>>>   void kfd_unbind_processes_from_device(struct kfd_dev *dev);
>>>>   void kfd_process_iommu_unbind_callback(struct kfd_dev *dev, unsigned int pasid);
>>>> +#endif
>>>>   struct kfd_process_device *kfd_get_process_device_data(struct kfd_dev *dev,
>>>>                                                          struct kfd_process *p);
>>>>   struct kfd_process_device *kfd_create_process_device_data(struct kfd_dev *dev,
>>>> @@ -784,9 +787,11 @@ int kfd_wait_on_events(struct kfd_process *p,
>>>>                         uint32_t *wait_result);
>>>>   void kfd_signal_event_interrupt(unsigned int pasid, uint32_t partial_id,
>>>>                                  uint32_t valid_id_bits);
>>>> +#if defined(CONFIG_AMD_IOMMU_V2_MODULE) || defined(CONFIG_AMD_IOMMU_V2)
>>>>   void kfd_signal_iommu_event(struct kfd_dev *dev,
>>>>                  unsigned int pasid, unsigned long address,
>>>>                  bool is_write_requested, bool is_execute_requested);
>>>> +#endif
>>>>   void kfd_signal_hw_exception_event(unsigned int pasid);
>>>>   int kfd_set_event(struct kfd_process *p, uint32_t event_id);
>>>>   int kfd_reset_event(struct kfd_process *p, uint32_t event_id);
>>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>>>> index a22fb071..1d0e02c 100644
>>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>>>> @@ -173,14 +173,17 @@ static void kfd_process_wq_release(struct work_struct *work)
>>>>   {
>>>>          struct kfd_process *p = container_of(work, struct kfd_process,
>>>>                                               release_work);
>>>> +#if defined(CONFIG_AMD_IOMMU_V2_MODULE) || defined(CONFIG_AMD_IOMMU_V2)
>>>>          struct kfd_process_device *pdd;
>>>>
>>>>          pr_debug("Releasing process (pasid %d) in workqueue\n", p->pasid);
>>>>
>>>>          list_for_each_entry(pdd, &p->per_device_data, per_device_list) {
>>>> -               if (pdd->bound == PDD_BOUND)
>>>> +               if (pdd->bound == PDD_BOUND &&
>>>> +                   pdd->dev->device_info->needs_iommu_device)
>>>>                          amd_iommu_unbind_pasid(pdd->dev->pdev, p->pasid);
>>>>          }
>>>> +#endif
>>>>
>>>>          kfd_process_destroy_pdds(p);
>>>>
>>>> @@ -421,7 +424,6 @@ struct kfd_process_device *kfd_bind_process_to_device(struct kfd_dev *dev,
>>>>                                                          struct kfd_process *p)
>>>>   {
>>>>          struct kfd_process_device *pdd;
>>>> -       int err;
>>>>
>>>>          pdd = kfd_get_process_device_data(dev, p);
>>>>          if (!pdd) {
>>>> @@ -436,9 +438,14 @@ struct kfd_process_device *kfd_bind_process_to_device(struct kfd_dev *dev,
>>>>                  return ERR_PTR(-EINVAL);
>>>>          }
>>>>
>>>> -       err = amd_iommu_bind_pasid(dev->pdev, p->pasid, p->lead_thread);
>>>> -       if (err < 0)
>>>> -               return ERR_PTR(err);
>>>> +#if defined(CONFIG_AMD_IOMMU_V2_MODULE) || defined(CONFIG_AMD_IOMMU_V2)
>>>> +       if (dev->device_info->needs_iommu_device) {
>>>> +               int err = amd_iommu_bind_pasid(dev->pdev, p->pasid,
>>>> +                                              p->lead_thread);
>>>> +               if (err < 0)
>>>> +                       return ERR_PTR(err);
>>>> +       }
>>>> +#endif
>>>>
>>>>          pdd->bound = PDD_BOUND;
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
>>>> index c6a7609..f57c305 100644
>>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
>>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
>>>> @@ -875,6 +875,7 @@ static void find_system_memory(const struct dmi_header *dm,
>>>>    */
>>>>   static int kfd_add_perf_to_topology(struct kfd_topology_device *kdev)
>>>>   {
>>>> +#if defined(CONFIG_AMD_IOMMU_V2_MODULE) || defined(CONFIG_AMD_IOMMU_V2)
>>>>          struct kfd_perf_properties *props;
>>>>
>>>>          if (amd_iommu_pc_supported()) {
>>>> @@ -886,6 +887,7 @@ static int kfd_add_perf_to_topology(struct kfd_topology_device *kdev)
>>>>                          amd_iommu_pc_get_max_counters(0); /* assume one iommu */
>>>>                  list_add_tail(&props->list, &kdev->perf_props);
>>>>          }
>>>> +#endif
>>>>
>>>>          return 0;
>>>>   }
>>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.h b/drivers/gpu/drm/amd/amdkfd/kfd_topology.h
>>>> index 53fca1f..111fda2 100644
>>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.h
>>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.h
>>>> @@ -183,8 +183,10 @@ struct kfd_topology_device *kfd_create_topology_device(
>>>>                  struct list_head *device_list);
>>>>   void kfd_release_topology_device_list(struct list_head *device_list);
>>>>
>>>> +#if defined(CONFIG_AMD_IOMMU_V2_MODULE) || defined(CONFIG_AMD_IOMMU_V2)
>>>>   extern bool amd_iommu_pc_supported(void);
>>>>   extern u8 amd_iommu_pc_get_max_banks(u16 devid);
>>>>   extern u8 amd_iommu_pc_get_max_counters(u16 devid);
>>>> +#endif
>>>>
>>>>   #endif /* __KFD_TOPOLOGY_H__ */
>>>> --
>>>> 2.7.4
>>>>
>
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx


--------------447CF3450049AB6687E85ABB
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <div class="moz-cite-prefix">Looks good to me on first glance.<br>
      <br>
      You probably don't mind that I'm going to pull a good part of that
      into amdgpu as next step?<br>
      <br>
      Regards,<br>
      Christian.<br>
      <br>
      Am 03.02.2018 um 03:29 schrieb Felix Kuehling:<br>
    </div>
    <blockquote type="cite"
      cite="mid:5a1e7696-b5bf-547c-4fe6-e71e0ae7f5e0-5C7GfCeVMHo@public.gmane.org">
      <pre wrap="">The attached patch is my attempt to keep most of the IOMMU code in one
place (new kfd_iommu.c) to avoid #ifdefs all over the place. This way I
can still conditionally compile a bunch of KFD code that is only needed
for IOMMU handling, with stub functions for kernel configs without IOMMU
support. About 300 lines of conditionally compiled code got moved to
kfd_iommu.c.

The only piece I didn't move into kfd_iommu.c is 
kfd_signal_iommu_event. I prefer to keep that in kfd_events.c because it
doesn't call any IOMMU driver functions, and because it's closely
related to the rest of the event handling logic. It could be compiled
unconditionally, but it would be dead code without IOMMU support.

And I moved pdd-&gt;bound to a place where it doesn't consume extra space
(on 64-bit systems due to structure alignment) instead of making it
conditional.

This is only compile-tested for now.

If you like this approach, I'll do more testing and squash it with "Make
IOMMUv2 code conditional".

Regards,
  Felix


On 2018-01-31 10:00 AM, Oded Gabbay wrote:
</pre>
      <blockquote type="cite">
        <pre wrap="">On Wed, Jan 31, 2018 at 4:56 PM, Oded Gabbay <a class="moz-txt-link-rfc2396E" href="mailto:oded.gabbay-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">&lt;oded.gabbay-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org&gt;</a> wrote:
</pre>
        <blockquote type="cite">
          <pre wrap="">Hi Felix,
Please don't spread 19 #ifdefs throughout the code.
I suggest to put one #ifdef in linux/amd-iommu.h itself around all the
functions declarations and in the #else section put macros with empty
implementations. This is much more readable and maintainable.

Oded
</pre>
        </blockquote>
        <pre wrap="">To emphasize my point, there is a call to amd_iommu_bind_pasid in
kfd_bind_processes_to_device() which isn't wrapped with the #ifdef so
the compliation breaks. Putting the #ifdefs around the calls is simply
not scalable.

Oded

</pre>
        <blockquote type="cite">
          <pre wrap="">
On Fri, Jan 5, 2018 at 12:17 AM, Felix Kuehling <a class="moz-txt-link-rfc2396E" href="mailto:Felix.Kuehling-5C7GfCeVMHo@public.gmane.org">&lt;Felix.Kuehling-5C7GfCeVMHo@public.gmane.org&gt;</a> wrote:
</pre>
          <blockquote type="cite">
            <pre wrap="">dGPUs work without IOMMUv2. Make IOMMUv2 initialization dependent on
ASIC information. Also allow building KFD without IOMMUv2 support.
This is still useful for dGPUs and prepares for enabling KFD on
architectures that don't support AMD IOMMUv2.

Signed-off-by: Felix Kuehling <a class="moz-txt-link-rfc2396E" href="mailto:Felix.Kuehling-5C7GfCeVMHo@public.gmane.org">&lt;Felix.Kuehling-5C7GfCeVMHo@public.gmane.org&gt;</a>
---
 drivers/gpu/drm/amd/amdkfd/Kconfig        |  2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_crat.c     |  8 +++-
 drivers/gpu/drm/amd/amdkfd/kfd_device.c   | 62 +++++++++++++++++++++----------
 drivers/gpu/drm/amd/amdkfd/kfd_events.c   |  2 +
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h     |  5 +++
 drivers/gpu/drm/amd/amdkfd/kfd_process.c  | 17 ++++++---
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c |  2 +
 drivers/gpu/drm/amd/amdkfd/kfd_topology.h |  2 +
 8 files changed, 74 insertions(+), 26 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/Kconfig b/drivers/gpu/drm/amd/amdkfd/Kconfig
index bc5a294..5bbeb95 100644
--- a/drivers/gpu/drm/amd/amdkfd/Kconfig
+++ b/drivers/gpu/drm/amd/amdkfd/Kconfig
@@ -4,6 +4,6 @@

 config HSA_AMD
        tristate "HSA kernel driver for AMD GPU devices"
-       depends on DRM_AMDGPU &amp;&amp; AMD_IOMMU_V2 &amp;&amp; X86_64
+       depends on DRM_AMDGPU &amp;&amp; X86_64
        help
          Enable this if you want to use HSA features on AMD GPU devices.
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
index 2bc2816..3478270 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
@@ -22,7 +22,9 @@

 #include &lt;linux/pci.h&gt;
 #include &lt;linux/acpi.h&gt;
+#if defined(CONFIG_AMD_IOMMU_V2_MODULE) || defined(CONFIG_AMD_IOMMU_V2)
 #include &lt;linux/amd-iommu.h&gt;
+#endif
 #include "kfd_crat.h"
 #include "kfd_priv.h"
 #include "kfd_topology.h"
@@ -1037,15 +1039,17 @@ static int kfd_create_vcrat_image_gpu(void *pcrat_image,
        struct crat_subtype_generic *sub_type_hdr;
        struct crat_subtype_computeunit *cu;
        struct kfd_cu_info cu_info;
-       struct amd_iommu_device_info iommu_info;
        int avail_size = *size;
        uint32_t total_num_of_cu;
        int num_of_cache_entries = 0;
        int cache_mem_filled = 0;
        int ret = 0;
+#if defined(CONFIG_AMD_IOMMU_V2_MODULE) || defined(CONFIG_AMD_IOMMU_V2)
+       struct amd_iommu_device_info iommu_info;
        const u32 required_iommu_flags = AMD_IOMMU_DEVICE_FLAG_ATS_SUP |
                                         AMD_IOMMU_DEVICE_FLAG_PRI_SUP |
                                         AMD_IOMMU_DEVICE_FLAG_PASID_SUP;
+#endif
        struct kfd_local_mem_info local_mem_info;

        if (!pcrat_image || avail_size &lt; VCRAT_SIZE_FOR_GPU)
@@ -1106,12 +1110,14 @@ static int kfd_create_vcrat_image_gpu(void *pcrat_image,
        /* Check if this node supports IOMMU. During parsing this flag will
         * translate to HSA_CAP_ATS_PRESENT
         */
+#if defined(CONFIG_AMD_IOMMU_V2_MODULE) || defined(CONFIG_AMD_IOMMU_V2)
        iommu_info.flags = 0;
        if (amd_iommu_device_info(kdev-&gt;pdev, &amp;iommu_info) == 0) {
                if ((iommu_info.flags &amp; required_iommu_flags) ==
                                required_iommu_flags)
                        cu-&gt;hsa_capability |= CRAT_CU_FLAGS_IOMMU_PRESENT;
        }
+#endif

        crat_table-&gt;length += sub_type_hdr-&gt;length;
        crat_table-&gt;total_entries++;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index fafe971..5205b34 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -20,7 +20,9 @@
  * OTHER DEALINGS IN THE SOFTWARE.
  */

+#if defined(CONFIG_AMD_IOMMU_V2_MODULE) || defined(CONFIG_AMD_IOMMU_V2)
 #include &lt;linux/amd-iommu.h&gt;
+#endif
 #include &lt;linux/bsearch.h&gt;
 #include &lt;linux/pci.h&gt;
 #include &lt;linux/slab.h&gt;
@@ -31,6 +33,7 @@

 #define MQD_SIZE_ALIGNED 768

+#if defined(CONFIG_AMD_IOMMU_V2_MODULE) || defined(CONFIG_AMD_IOMMU_V2)
 static const struct kfd_device_info kaveri_device_info = {
        .asic_family = CHIP_KAVERI,
        .max_pasid_bits = 16,
@@ -41,6 +44,7 @@ static const struct kfd_device_info kaveri_device_info = {
        .num_of_watch_points = 4,
        .mqd_size_aligned = MQD_SIZE_ALIGNED,
        .supports_cwsr = false,
+       .needs_iommu_device = true,
        .needs_pci_atomics = false,
 };

@@ -54,8 +58,10 @@ static const struct kfd_device_info carrizo_device_info = {
        .num_of_watch_points = 4,
        .mqd_size_aligned = MQD_SIZE_ALIGNED,
        .supports_cwsr = true,
+       .needs_iommu_device = true,
        .needs_pci_atomics = false,
 };
+#endif

 struct kfd_deviceid {
        unsigned short did;
@@ -64,6 +70,7 @@ struct kfd_deviceid {

 /* Please keep this sorted by increasing device id. */
 static const struct kfd_deviceid supported_devices[] = {
+#if defined(CONFIG_AMD_IOMMU_V2_MODULE) || defined(CONFIG_AMD_IOMMU_V2)
        { 0x1304, &amp;kaveri_device_info },        /* Kaveri */
        { 0x1305, &amp;kaveri_device_info },        /* Kaveri */
        { 0x1306, &amp;kaveri_device_info },        /* Kaveri */
@@ -91,6 +98,7 @@ static const struct kfd_deviceid supported_devices[] = {
        { 0x9875, &amp;carrizo_device_info },       /* Carrizo */
        { 0x9876, &amp;carrizo_device_info },       /* Carrizo */
        { 0x9877, &amp;carrizo_device_info }        /* Carrizo */
+#endif
 };

 static int kfd_gtt_sa_init(struct kfd_dev *kfd, unsigned int buf_size,
@@ -161,6 +169,7 @@ struct kfd_dev *kgd2kfd_probe(struct kgd_dev *kgd,
        return kfd;
 }

+#if defined(CONFIG_AMD_IOMMU_V2_MODULE) || defined(CONFIG_AMD_IOMMU_V2)
 static bool device_iommu_pasid_init(struct kfd_dev *kfd)
 {
        const u32 required_iommu_flags = AMD_IOMMU_DEVICE_FLAG_ATS_SUP |
@@ -231,6 +240,7 @@ static int iommu_invalid_ppr_cb(struct pci_dev *pdev, int pasid,

        return AMD_IOMMU_INV_PRI_RSP_INVALID;
 }
+#endif /* CONFIG_AMD_IOMMU_V2 */

 static void kfd_cwsr_init(struct kfd_dev *kfd)
 {
@@ -321,12 +331,14 @@ bool kgd2kfd_device_init(struct kfd_dev *kfd,
                goto device_queue_manager_error;
        }

-       if (!device_iommu_pasid_init(kfd)) {
-               dev_err(kfd_device,
-                       "Error initializing iommuv2 for device %x:%x\n",
-                       kfd-&gt;pdev-&gt;vendor, kfd-&gt;pdev-&gt;device);
-               goto device_iommu_pasid_error;
+#if defined(CONFIG_AMD_IOMMU_V2_MODULE) || defined(CONFIG_AMD_IOMMU_V2)
+       if (kfd-&gt;device_info-&gt;needs_iommu_device) {
+               if (!device_iommu_pasid_init(kfd)) {
+                       dev_err(kfd_device, "Error initializing iommuv2\n");
+                       goto device_iommu_pasid_error;
+               }
        }
+#endif

        kfd_cwsr_init(kfd);

@@ -386,11 +398,16 @@ void kgd2kfd_suspend(struct kfd_dev *kfd)

        kfd-&gt;dqm-&gt;ops.stop(kfd-&gt;dqm);

+#if defined(CONFIG_AMD_IOMMU_V2_MODULE) || defined(CONFIG_AMD_IOMMU_V2)
+       if (!kfd-&gt;device_info-&gt;needs_iommu_device)
+               return;
+
        kfd_unbind_processes_from_device(kfd);

        amd_iommu_set_invalidate_ctx_cb(kfd-&gt;pdev, NULL);
        amd_iommu_set_invalid_ppr_cb(kfd-&gt;pdev, NULL);
        amd_iommu_free_device(kfd-&gt;pdev);
+#endif
 }

 int kgd2kfd_resume(struct kfd_dev *kfd)
@@ -405,19 +422,24 @@ int kgd2kfd_resume(struct kfd_dev *kfd)
 static int kfd_resume(struct kfd_dev *kfd)
 {
        int err = 0;
-       unsigned int pasid_limit = kfd_get_pasid_limit();

-       err = amd_iommu_init_device(kfd-&gt;pdev, pasid_limit);
-       if (err)
-               return -ENXIO;
-       amd_iommu_set_invalidate_ctx_cb(kfd-&gt;pdev,
-                                       iommu_pasid_shutdown_callback);
-       amd_iommu_set_invalid_ppr_cb(kfd-&gt;pdev,
-                                    iommu_invalid_ppr_cb);
-
-       err = kfd_bind_processes_to_device(kfd);
-       if (err)
-               goto processes_bind_error;
+#if defined(CONFIG_AMD_IOMMU_V2_MODULE) || defined(CONFIG_AMD_IOMMU_V2)
+       if (kfd-&gt;device_info-&gt;needs_iommu_device) {
+               unsigned int pasid_limit = kfd_get_pasid_limit();
+
+               err = amd_iommu_init_device(kfd-&gt;pdev, pasid_limit);
+               if (err)
+                       return -ENXIO;
+               amd_iommu_set_invalidate_ctx_cb(kfd-&gt;pdev,
+                                               iommu_pasid_shutdown_callback);
+               amd_iommu_set_invalid_ppr_cb(kfd-&gt;pdev,
+                                            iommu_invalid_ppr_cb);
+
+               err = kfd_bind_processes_to_device(kfd);
+               if (err)
+                       goto processes_bind_error;
+       }
+#endif

        err = kfd-&gt;dqm-&gt;ops.start(kfd-&gt;dqm);
        if (err) {
@@ -431,8 +453,10 @@ static int kfd_resume(struct kfd_dev *kfd)

 dqm_start_error:
 processes_bind_error:
-       amd_iommu_free_device(kfd-&gt;pdev);
-
+#if defined(CONFIG_AMD_IOMMU_V2_MODULE) || defined(CONFIG_AMD_IOMMU_V2)
+       if (kfd-&gt;device_info-&gt;needs_iommu_device)
+               amd_iommu_free_device(kfd-&gt;pdev);
+#endif
        return err;
 }

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_events.c b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
index 93aae5c..f770dc7 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_events.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
@@ -837,6 +837,7 @@ static void lookup_events_by_type_and_signal(struct kfd_process *p,
        }
 }

+#if defined(CONFIG_AMD_IOMMU_V2_MODULE) || defined(CONFIG_AMD_IOMMU_V2)
 void kfd_signal_iommu_event(struct kfd_dev *dev, unsigned int pasid,
                unsigned long address, bool is_write_requested,
                bool is_execute_requested)
@@ -905,6 +906,7 @@ void kfd_signal_iommu_event(struct kfd_dev *dev, unsigned int pasid,
        mutex_unlock(&amp;p-&gt;event_mutex);
        kfd_unref_process(p);
 }
+#endif /* CONFIG_AMD_IOMMU_V2_MODULE */

 void kfd_signal_hw_exception_event(unsigned int pasid)
 {
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index eebfb1e..9f4766c 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -158,6 +158,7 @@ struct kfd_device_info {
        uint8_t num_of_watch_points;
        uint16_t mqd_size_aligned;
        bool supports_cwsr;
+       bool needs_iommu_device;
        bool needs_pci_atomics;
 };

@@ -617,9 +618,11 @@ void kfd_unref_process(struct kfd_process *p);

 struct kfd_process_device *kfd_bind_process_to_device(struct kfd_dev *dev,
                                                struct kfd_process *p);
+#if defined(CONFIG_AMD_IOMMU_V2_MODULE) || defined(CONFIG_AMD_IOMMU_V2)
 int kfd_bind_processes_to_device(struct kfd_dev *dev);
 void kfd_unbind_processes_from_device(struct kfd_dev *dev);
 void kfd_process_iommu_unbind_callback(struct kfd_dev *dev, unsigned int pasid);
+#endif
 struct kfd_process_device *kfd_get_process_device_data(struct kfd_dev *dev,
                                                        struct kfd_process *p);
 struct kfd_process_device *kfd_create_process_device_data(struct kfd_dev *dev,
@@ -784,9 +787,11 @@ int kfd_wait_on_events(struct kfd_process *p,
                       uint32_t *wait_result);
 void kfd_signal_event_interrupt(unsigned int pasid, uint32_t partial_id,
                                uint32_t valid_id_bits);
+#if defined(CONFIG_AMD_IOMMU_V2_MODULE) || defined(CONFIG_AMD_IOMMU_V2)
 void kfd_signal_iommu_event(struct kfd_dev *dev,
                unsigned int pasid, unsigned long address,
                bool is_write_requested, bool is_execute_requested);
+#endif
 void kfd_signal_hw_exception_event(unsigned int pasid);
 int kfd_set_event(struct kfd_process *p, uint32_t event_id);
 int kfd_reset_event(struct kfd_process *p, uint32_t event_id);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index a22fb071..1d0e02c 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -173,14 +173,17 @@ static void kfd_process_wq_release(struct work_struct *work)
 {
        struct kfd_process *p = container_of(work, struct kfd_process,
                                             release_work);
+#if defined(CONFIG_AMD_IOMMU_V2_MODULE) || defined(CONFIG_AMD_IOMMU_V2)
        struct kfd_process_device *pdd;

        pr_debug("Releasing process (pasid %d) in workqueue\n", p-&gt;pasid);

        list_for_each_entry(pdd, &amp;p-&gt;per_device_data, per_device_list) {
-               if (pdd-&gt;bound == PDD_BOUND)
+               if (pdd-&gt;bound == PDD_BOUND &amp;&amp;
+                   pdd-&gt;dev-&gt;device_info-&gt;needs_iommu_device)
                        amd_iommu_unbind_pasid(pdd-&gt;dev-&gt;pdev, p-&gt;pasid);
        }
+#endif

        kfd_process_destroy_pdds(p);

@@ -421,7 +424,6 @@ struct kfd_process_device *kfd_bind_process_to_device(struct kfd_dev *dev,
                                                        struct kfd_process *p)
 {
        struct kfd_process_device *pdd;
-       int err;

        pdd = kfd_get_process_device_data(dev, p);
        if (!pdd) {
@@ -436,9 +438,14 @@ struct kfd_process_device *kfd_bind_process_to_device(struct kfd_dev *dev,
                return ERR_PTR(-EINVAL);
        }

-       err = amd_iommu_bind_pasid(dev-&gt;pdev, p-&gt;pasid, p-&gt;lead_thread);
-       if (err &lt; 0)
-               return ERR_PTR(err);
+#if defined(CONFIG_AMD_IOMMU_V2_MODULE) || defined(CONFIG_AMD_IOMMU_V2)
+       if (dev-&gt;device_info-&gt;needs_iommu_device) {
+               int err = amd_iommu_bind_pasid(dev-&gt;pdev, p-&gt;pasid,
+                                              p-&gt;lead_thread);
+               if (err &lt; 0)
+                       return ERR_PTR(err);
+       }
+#endif

        pdd-&gt;bound = PDD_BOUND;

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
index c6a7609..f57c305 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
@@ -875,6 +875,7 @@ static void find_system_memory(const struct dmi_header *dm,
  */
 static int kfd_add_perf_to_topology(struct kfd_topology_device *kdev)
 {
+#if defined(CONFIG_AMD_IOMMU_V2_MODULE) || defined(CONFIG_AMD_IOMMU_V2)
        struct kfd_perf_properties *props;

        if (amd_iommu_pc_supported()) {
@@ -886,6 +887,7 @@ static int kfd_add_perf_to_topology(struct kfd_topology_device *kdev)
                        amd_iommu_pc_get_max_counters(0); /* assume one iommu */
                list_add_tail(&amp;props-&gt;list, &amp;kdev-&gt;perf_props);
        }
+#endif

        return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.h b/drivers/gpu/drm/amd/amdkfd/kfd_topology.h
index 53fca1f..111fda2 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.h
@@ -183,8 +183,10 @@ struct kfd_topology_device *kfd_create_topology_device(
                struct list_head *device_list);
 void kfd_release_topology_device_list(struct list_head *device_list);

+#if defined(CONFIG_AMD_IOMMU_V2_MODULE) || defined(CONFIG_AMD_IOMMU_V2)
 extern bool amd_iommu_pc_supported(void);
 extern u8 amd_iommu_pc_get_max_banks(u16 devid);
 extern u8 amd_iommu_pc_get_max_counters(u16 devid);
+#endif

 #endif /* __KFD_TOPOLOGY_H__ */
--
2.7.4

</pre>
          </blockquote>
        </blockquote>
      </blockquote>
      <pre wrap="">
</pre>
      <br>
      <fieldset class="mimeAttachmentHeader"></fieldset>
      <br>
      <pre wrap="">_______________________________________________
amd-gfx mailing list
<a class="moz-txt-link-abbreviated" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>
<a class="moz-txt-link-freetext" href="https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a>
</pre>
    </blockquote>
    <br>
  </body>
</html>

--------------447CF3450049AB6687E85ABB--

--===============1142501818==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1142501818==--
