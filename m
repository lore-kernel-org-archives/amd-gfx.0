From: Felix Kuehling <felix.kuehling-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 3/9] drm/amdkfd: Make IOMMUv2 code conditional
Date: Fri, 2 Feb 2018 21:29:07 -0500
Message-ID: <5a1e7696-b5bf-547c-4fe6-e71e0ae7f5e0@amd.com>
References: <1515104268-25087-1-git-send-email-Felix.Kuehling@amd.com>
 <1515104268-25087-4-git-send-email-Felix.Kuehling@amd.com>
 <CAFCwf125cHCf=fsfiMhhASjgMNEcau04gNGKKHFu7PQGeorpZQ@mail.gmail.com>
 <CAFCwf12pqRA4KdRLpkUmiBs7EQmTePcy80V2kP9mP3pN8V-eTg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------63A2EFE5436A6E5848849BC2"
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CAFCwf12pqRA4KdRLpkUmiBs7EQmTePcy80V2kP9mP3pN8V-eTg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Content-Language: en-CA
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
To: Oded Gabbay <oded.gabbay-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

This is a multi-part message in MIME format.
--------------63A2EFE5436A6E5848849BC2
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

The attached patch is my attempt to keep most of the IOMMU code in one
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

And I moved pdd->bound to a place where it doesn't consume extra space
(on 64-bit systems due to structure alignment) instead of making it
conditional.

This is only compile-tested for now.

If you like this approach, I'll do more testing and squash it with "Make
IOMMUv2 code conditional".

Regards,
  Felix


On 2018-01-31 10:00 AM, Oded Gabbay wrote:
> On Wed, Jan 31, 2018 at 4:56 PM, Oded Gabbay <oded.gabbay-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
>> Hi Felix,
>> Please don't spread 19 #ifdefs throughout the code.
>> I suggest to put one #ifdef in linux/amd-iommu.h itself around all the
>> functions declarations and in the #else section put macros with empty
>> implementations. This is much more readable and maintainable.
>>
>> Oded
> To emphasize my point, there is a call to amd_iommu_bind_pasid in
> kfd_bind_processes_to_device() which isn't wrapped with the #ifdef so
> the compliation breaks. Putting the #ifdefs around the calls is simply
> not scalable.
>
> Oded
>
>>
>> On Fri, Jan 5, 2018 at 12:17 AM, Felix Kuehling <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org> wrote:
>>> dGPUs work without IOMMUv2. Make IOMMUv2 initialization dependent on
>>> ASIC information. Also allow building KFD without IOMMUv2 support.
>>> This is still useful for dGPUs and prepares for enabling KFD on
>>> architectures that don't support AMD IOMMUv2.
>>>
>>> Signed-off-by: Felix Kuehling <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>
>>> ---
>>>  drivers/gpu/drm/amd/amdkfd/Kconfig        |  2 +-
>>>  drivers/gpu/drm/amd/amdkfd/kfd_crat.c     |  8 +++-
>>>  drivers/gpu/drm/amd/amdkfd/kfd_device.c   | 62 +++++++++++++++++++++----------
>>>  drivers/gpu/drm/amd/amdkfd/kfd_events.c   |  2 +
>>>  drivers/gpu/drm/amd/amdkfd/kfd_priv.h     |  5 +++
>>>  drivers/gpu/drm/amd/amdkfd/kfd_process.c  | 17 ++++++---
>>>  drivers/gpu/drm/amd/amdkfd/kfd_topology.c |  2 +
>>>  drivers/gpu/drm/amd/amdkfd/kfd_topology.h |  2 +
>>>  8 files changed, 74 insertions(+), 26 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdkfd/Kconfig b/drivers/gpu/drm/amd/amdkfd/Kconfig
>>> index bc5a294..5bbeb95 100644
>>> --- a/drivers/gpu/drm/amd/amdkfd/Kconfig
>>> +++ b/drivers/gpu/drm/amd/amdkfd/Kconfig
>>> @@ -4,6 +4,6 @@
>>>
>>>  config HSA_AMD
>>>         tristate "HSA kernel driver for AMD GPU devices"
>>> -       depends on DRM_AMDGPU && AMD_IOMMU_V2 && X86_64
>>> +       depends on DRM_AMDGPU && X86_64
>>>         help
>>>           Enable this if you want to use HSA features on AMD GPU devices.
>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
>>> index 2bc2816..3478270 100644
>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
>>> @@ -22,7 +22,9 @@
>>>
>>>  #include <linux/pci.h>
>>>  #include <linux/acpi.h>
>>> +#if defined(CONFIG_AMD_IOMMU_V2_MODULE) || defined(CONFIG_AMD_IOMMU_V2)
>>>  #include <linux/amd-iommu.h>
>>> +#endif
>>>  #include "kfd_crat.h"
>>>  #include "kfd_priv.h"
>>>  #include "kfd_topology.h"
>>> @@ -1037,15 +1039,17 @@ static int kfd_create_vcrat_image_gpu(void *pcrat_image,
>>>         struct crat_subtype_generic *sub_type_hdr;
>>>         struct crat_subtype_computeunit *cu;
>>>         struct kfd_cu_info cu_info;
>>> -       struct amd_iommu_device_info iommu_info;
>>>         int avail_size = *size;
>>>         uint32_t total_num_of_cu;
>>>         int num_of_cache_entries = 0;
>>>         int cache_mem_filled = 0;
>>>         int ret = 0;
>>> +#if defined(CONFIG_AMD_IOMMU_V2_MODULE) || defined(CONFIG_AMD_IOMMU_V2)
>>> +       struct amd_iommu_device_info iommu_info;
>>>         const u32 required_iommu_flags = AMD_IOMMU_DEVICE_FLAG_ATS_SUP |
>>>                                          AMD_IOMMU_DEVICE_FLAG_PRI_SUP |
>>>                                          AMD_IOMMU_DEVICE_FLAG_PASID_SUP;
>>> +#endif
>>>         struct kfd_local_mem_info local_mem_info;
>>>
>>>         if (!pcrat_image || avail_size < VCRAT_SIZE_FOR_GPU)
>>> @@ -1106,12 +1110,14 @@ static int kfd_create_vcrat_image_gpu(void *pcrat_image,
>>>         /* Check if this node supports IOMMU. During parsing this flag will
>>>          * translate to HSA_CAP_ATS_PRESENT
>>>          */
>>> +#if defined(CONFIG_AMD_IOMMU_V2_MODULE) || defined(CONFIG_AMD_IOMMU_V2)
>>>         iommu_info.flags = 0;
>>>         if (amd_iommu_device_info(kdev->pdev, &iommu_info) == 0) {
>>>                 if ((iommu_info.flags & required_iommu_flags) ==
>>>                                 required_iommu_flags)
>>>                         cu->hsa_capability |= CRAT_CU_FLAGS_IOMMU_PRESENT;
>>>         }
>>> +#endif
>>>
>>>         crat_table->length += sub_type_hdr->length;
>>>         crat_table->total_entries++;
>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
>>> index fafe971..5205b34 100644
>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
>>> @@ -20,7 +20,9 @@
>>>   * OTHER DEALINGS IN THE SOFTWARE.
>>>   */
>>>
>>> +#if defined(CONFIG_AMD_IOMMU_V2_MODULE) || defined(CONFIG_AMD_IOMMU_V2)
>>>  #include <linux/amd-iommu.h>
>>> +#endif
>>>  #include <linux/bsearch.h>
>>>  #include <linux/pci.h>
>>>  #include <linux/slab.h>
>>> @@ -31,6 +33,7 @@
>>>
>>>  #define MQD_SIZE_ALIGNED 768
>>>
>>> +#if defined(CONFIG_AMD_IOMMU_V2_MODULE) || defined(CONFIG_AMD_IOMMU_V2)
>>>  static const struct kfd_device_info kaveri_device_info = {
>>>         .asic_family = CHIP_KAVERI,
>>>         .max_pasid_bits = 16,
>>> @@ -41,6 +44,7 @@ static const struct kfd_device_info kaveri_device_info = {
>>>         .num_of_watch_points = 4,
>>>         .mqd_size_aligned = MQD_SIZE_ALIGNED,
>>>         .supports_cwsr = false,
>>> +       .needs_iommu_device = true,
>>>         .needs_pci_atomics = false,
>>>  };
>>>
>>> @@ -54,8 +58,10 @@ static const struct kfd_device_info carrizo_device_info = {
>>>         .num_of_watch_points = 4,
>>>         .mqd_size_aligned = MQD_SIZE_ALIGNED,
>>>         .supports_cwsr = true,
>>> +       .needs_iommu_device = true,
>>>         .needs_pci_atomics = false,
>>>  };
>>> +#endif
>>>
>>>  struct kfd_deviceid {
>>>         unsigned short did;
>>> @@ -64,6 +70,7 @@ struct kfd_deviceid {
>>>
>>>  /* Please keep this sorted by increasing device id. */
>>>  static const struct kfd_deviceid supported_devices[] = {
>>> +#if defined(CONFIG_AMD_IOMMU_V2_MODULE) || defined(CONFIG_AMD_IOMMU_V2)
>>>         { 0x1304, &kaveri_device_info },        /* Kaveri */
>>>         { 0x1305, &kaveri_device_info },        /* Kaveri */
>>>         { 0x1306, &kaveri_device_info },        /* Kaveri */
>>> @@ -91,6 +98,7 @@ static const struct kfd_deviceid supported_devices[] = {
>>>         { 0x9875, &carrizo_device_info },       /* Carrizo */
>>>         { 0x9876, &carrizo_device_info },       /* Carrizo */
>>>         { 0x9877, &carrizo_device_info }        /* Carrizo */
>>> +#endif
>>>  };
>>>
>>>  static int kfd_gtt_sa_init(struct kfd_dev *kfd, unsigned int buf_size,
>>> @@ -161,6 +169,7 @@ struct kfd_dev *kgd2kfd_probe(struct kgd_dev *kgd,
>>>         return kfd;
>>>  }
>>>
>>> +#if defined(CONFIG_AMD_IOMMU_V2_MODULE) || defined(CONFIG_AMD_IOMMU_V2)
>>>  static bool device_iommu_pasid_init(struct kfd_dev *kfd)
>>>  {
>>>         const u32 required_iommu_flags = AMD_IOMMU_DEVICE_FLAG_ATS_SUP |
>>> @@ -231,6 +240,7 @@ static int iommu_invalid_ppr_cb(struct pci_dev *pdev, int pasid,
>>>
>>>         return AMD_IOMMU_INV_PRI_RSP_INVALID;
>>>  }
>>> +#endif /* CONFIG_AMD_IOMMU_V2 */
>>>
>>>  static void kfd_cwsr_init(struct kfd_dev *kfd)
>>>  {
>>> @@ -321,12 +331,14 @@ bool kgd2kfd_device_init(struct kfd_dev *kfd,
>>>                 goto device_queue_manager_error;
>>>         }
>>>
>>> -       if (!device_iommu_pasid_init(kfd)) {
>>> -               dev_err(kfd_device,
>>> -                       "Error initializing iommuv2 for device %x:%x\n",
>>> -                       kfd->pdev->vendor, kfd->pdev->device);
>>> -               goto device_iommu_pasid_error;
>>> +#if defined(CONFIG_AMD_IOMMU_V2_MODULE) || defined(CONFIG_AMD_IOMMU_V2)
>>> +       if (kfd->device_info->needs_iommu_device) {
>>> +               if (!device_iommu_pasid_init(kfd)) {
>>> +                       dev_err(kfd_device, "Error initializing iommuv2\n");
>>> +                       goto device_iommu_pasid_error;
>>> +               }
>>>         }
>>> +#endif
>>>
>>>         kfd_cwsr_init(kfd);
>>>
>>> @@ -386,11 +398,16 @@ void kgd2kfd_suspend(struct kfd_dev *kfd)
>>>
>>>         kfd->dqm->ops.stop(kfd->dqm);
>>>
>>> +#if defined(CONFIG_AMD_IOMMU_V2_MODULE) || defined(CONFIG_AMD_IOMMU_V2)
>>> +       if (!kfd->device_info->needs_iommu_device)
>>> +               return;
>>> +
>>>         kfd_unbind_processes_from_device(kfd);
>>>
>>>         amd_iommu_set_invalidate_ctx_cb(kfd->pdev, NULL);
>>>         amd_iommu_set_invalid_ppr_cb(kfd->pdev, NULL);
>>>         amd_iommu_free_device(kfd->pdev);
>>> +#endif
>>>  }
>>>
>>>  int kgd2kfd_resume(struct kfd_dev *kfd)
>>> @@ -405,19 +422,24 @@ int kgd2kfd_resume(struct kfd_dev *kfd)
>>>  static int kfd_resume(struct kfd_dev *kfd)
>>>  {
>>>         int err = 0;
>>> -       unsigned int pasid_limit = kfd_get_pasid_limit();
>>>
>>> -       err = amd_iommu_init_device(kfd->pdev, pasid_limit);
>>> -       if (err)
>>> -               return -ENXIO;
>>> -       amd_iommu_set_invalidate_ctx_cb(kfd->pdev,
>>> -                                       iommu_pasid_shutdown_callback);
>>> -       amd_iommu_set_invalid_ppr_cb(kfd->pdev,
>>> -                                    iommu_invalid_ppr_cb);
>>> -
>>> -       err = kfd_bind_processes_to_device(kfd);
>>> -       if (err)
>>> -               goto processes_bind_error;
>>> +#if defined(CONFIG_AMD_IOMMU_V2_MODULE) || defined(CONFIG_AMD_IOMMU_V2)
>>> +       if (kfd->device_info->needs_iommu_device) {
>>> +               unsigned int pasid_limit = kfd_get_pasid_limit();
>>> +
>>> +               err = amd_iommu_init_device(kfd->pdev, pasid_limit);
>>> +               if (err)
>>> +                       return -ENXIO;
>>> +               amd_iommu_set_invalidate_ctx_cb(kfd->pdev,
>>> +                                               iommu_pasid_shutdown_callback);
>>> +               amd_iommu_set_invalid_ppr_cb(kfd->pdev,
>>> +                                            iommu_invalid_ppr_cb);
>>> +
>>> +               err = kfd_bind_processes_to_device(kfd);
>>> +               if (err)
>>> +                       goto processes_bind_error;
>>> +       }
>>> +#endif
>>>
>>>         err = kfd->dqm->ops.start(kfd->dqm);
>>>         if (err) {
>>> @@ -431,8 +453,10 @@ static int kfd_resume(struct kfd_dev *kfd)
>>>
>>>  dqm_start_error:
>>>  processes_bind_error:
>>> -       amd_iommu_free_device(kfd->pdev);
>>> -
>>> +#if defined(CONFIG_AMD_IOMMU_V2_MODULE) || defined(CONFIG_AMD_IOMMU_V2)
>>> +       if (kfd->device_info->needs_iommu_device)
>>> +               amd_iommu_free_device(kfd->pdev);
>>> +#endif
>>>         return err;
>>>  }
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_events.c b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
>>> index 93aae5c..f770dc7 100644
>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_events.c
>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
>>> @@ -837,6 +837,7 @@ static void lookup_events_by_type_and_signal(struct kfd_process *p,
>>>         }
>>>  }
>>>
>>> +#if defined(CONFIG_AMD_IOMMU_V2_MODULE) || defined(CONFIG_AMD_IOMMU_V2)
>>>  void kfd_signal_iommu_event(struct kfd_dev *dev, unsigned int pasid,
>>>                 unsigned long address, bool is_write_requested,
>>>                 bool is_execute_requested)
>>> @@ -905,6 +906,7 @@ void kfd_signal_iommu_event(struct kfd_dev *dev, unsigned int pasid,
>>>         mutex_unlock(&p->event_mutex);
>>>         kfd_unref_process(p);
>>>  }
>>> +#endif /* CONFIG_AMD_IOMMU_V2_MODULE */
>>>
>>>  void kfd_signal_hw_exception_event(unsigned int pasid)
>>>  {
>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>>> index eebfb1e..9f4766c 100644
>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>>> @@ -158,6 +158,7 @@ struct kfd_device_info {
>>>         uint8_t num_of_watch_points;
>>>         uint16_t mqd_size_aligned;
>>>         bool supports_cwsr;
>>> +       bool needs_iommu_device;
>>>         bool needs_pci_atomics;
>>>  };
>>>
>>> @@ -617,9 +618,11 @@ void kfd_unref_process(struct kfd_process *p);
>>>
>>>  struct kfd_process_device *kfd_bind_process_to_device(struct kfd_dev *dev,
>>>                                                 struct kfd_process *p);
>>> +#if defined(CONFIG_AMD_IOMMU_V2_MODULE) || defined(CONFIG_AMD_IOMMU_V2)
>>>  int kfd_bind_processes_to_device(struct kfd_dev *dev);
>>>  void kfd_unbind_processes_from_device(struct kfd_dev *dev);
>>>  void kfd_process_iommu_unbind_callback(struct kfd_dev *dev, unsigned int pasid);
>>> +#endif
>>>  struct kfd_process_device *kfd_get_process_device_data(struct kfd_dev *dev,
>>>                                                         struct kfd_process *p);
>>>  struct kfd_process_device *kfd_create_process_device_data(struct kfd_dev *dev,
>>> @@ -784,9 +787,11 @@ int kfd_wait_on_events(struct kfd_process *p,
>>>                        uint32_t *wait_result);
>>>  void kfd_signal_event_interrupt(unsigned int pasid, uint32_t partial_id,
>>>                                 uint32_t valid_id_bits);
>>> +#if defined(CONFIG_AMD_IOMMU_V2_MODULE) || defined(CONFIG_AMD_IOMMU_V2)
>>>  void kfd_signal_iommu_event(struct kfd_dev *dev,
>>>                 unsigned int pasid, unsigned long address,
>>>                 bool is_write_requested, bool is_execute_requested);
>>> +#endif
>>>  void kfd_signal_hw_exception_event(unsigned int pasid);
>>>  int kfd_set_event(struct kfd_process *p, uint32_t event_id);
>>>  int kfd_reset_event(struct kfd_process *p, uint32_t event_id);
>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>>> index a22fb071..1d0e02c 100644
>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>>> @@ -173,14 +173,17 @@ static void kfd_process_wq_release(struct work_struct *work)
>>>  {
>>>         struct kfd_process *p = container_of(work, struct kfd_process,
>>>                                              release_work);
>>> +#if defined(CONFIG_AMD_IOMMU_V2_MODULE) || defined(CONFIG_AMD_IOMMU_V2)
>>>         struct kfd_process_device *pdd;
>>>
>>>         pr_debug("Releasing process (pasid %d) in workqueue\n", p->pasid);
>>>
>>>         list_for_each_entry(pdd, &p->per_device_data, per_device_list) {
>>> -               if (pdd->bound == PDD_BOUND)
>>> +               if (pdd->bound == PDD_BOUND &&
>>> +                   pdd->dev->device_info->needs_iommu_device)
>>>                         amd_iommu_unbind_pasid(pdd->dev->pdev, p->pasid);
>>>         }
>>> +#endif
>>>
>>>         kfd_process_destroy_pdds(p);
>>>
>>> @@ -421,7 +424,6 @@ struct kfd_process_device *kfd_bind_process_to_device(struct kfd_dev *dev,
>>>                                                         struct kfd_process *p)
>>>  {
>>>         struct kfd_process_device *pdd;
>>> -       int err;
>>>
>>>         pdd = kfd_get_process_device_data(dev, p);
>>>         if (!pdd) {
>>> @@ -436,9 +438,14 @@ struct kfd_process_device *kfd_bind_process_to_device(struct kfd_dev *dev,
>>>                 return ERR_PTR(-EINVAL);
>>>         }
>>>
>>> -       err = amd_iommu_bind_pasid(dev->pdev, p->pasid, p->lead_thread);
>>> -       if (err < 0)
>>> -               return ERR_PTR(err);
>>> +#if defined(CONFIG_AMD_IOMMU_V2_MODULE) || defined(CONFIG_AMD_IOMMU_V2)
>>> +       if (dev->device_info->needs_iommu_device) {
>>> +               int err = amd_iommu_bind_pasid(dev->pdev, p->pasid,
>>> +                                              p->lead_thread);
>>> +               if (err < 0)
>>> +                       return ERR_PTR(err);
>>> +       }
>>> +#endif
>>>
>>>         pdd->bound = PDD_BOUND;
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
>>> index c6a7609..f57c305 100644
>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
>>> @@ -875,6 +875,7 @@ static void find_system_memory(const struct dmi_header *dm,
>>>   */
>>>  static int kfd_add_perf_to_topology(struct kfd_topology_device *kdev)
>>>  {
>>> +#if defined(CONFIG_AMD_IOMMU_V2_MODULE) || defined(CONFIG_AMD_IOMMU_V2)
>>>         struct kfd_perf_properties *props;
>>>
>>>         if (amd_iommu_pc_supported()) {
>>> @@ -886,6 +887,7 @@ static int kfd_add_perf_to_topology(struct kfd_topology_device *kdev)
>>>                         amd_iommu_pc_get_max_counters(0); /* assume one iommu */
>>>                 list_add_tail(&props->list, &kdev->perf_props);
>>>         }
>>> +#endif
>>>
>>>         return 0;
>>>  }
>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.h b/drivers/gpu/drm/amd/amdkfd/kfd_topology.h
>>> index 53fca1f..111fda2 100644
>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.h
>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.h
>>> @@ -183,8 +183,10 @@ struct kfd_topology_device *kfd_create_topology_device(
>>>                 struct list_head *device_list);
>>>  void kfd_release_topology_device_list(struct list_head *device_list);
>>>
>>> +#if defined(CONFIG_AMD_IOMMU_V2_MODULE) || defined(CONFIG_AMD_IOMMU_V2)
>>>  extern bool amd_iommu_pc_supported(void);
>>>  extern u8 amd_iommu_pc_get_max_banks(u16 devid);
>>>  extern u8 amd_iommu_pc_get_max_counters(u16 devid);
>>> +#endif
>>>
>>>  #endif /* __KFD_TOPOLOGY_H__ */
>>> --
>>> 2.7.4
>>>


--------------63A2EFE5436A6E5848849BC2
Content-Type: text/x-patch;
 name="0001-drm-amdkfd-Centralize-IOMMU-handling.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="0001-drm-amdkfd-Centralize-IOMMU-handling.patch"

>From a7e4ba61c9ef58bd543df6ae4324e8825933f5fc Mon Sep 17 00:00:00 2001
From: Felix Kuehling <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>
Date: Fri, 2 Feb 2018 21:06:34 -0500
Subject: [PATCH 1/1] drm/amdkfd: Centralize IOMMU handling

Avoid scattering IOMMU ifdefs in too many places.

Signed-off-by: Felix Kuehling <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>
---
 drivers/gpu/drm/amd/amdkfd/Makefile       |   4 +
 drivers/gpu/drm/amd/amdkfd/kfd_crat.c     |  20 +-
 drivers/gpu/drm/amd/amdkfd/kfd_device.c   | 127 +----------
 drivers/gpu/drm/amd/amdkfd/kfd_events.c   |   5 +-
 drivers/gpu/drm/amd/amdkfd/kfd_iommu.c    | 357 ++++++++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdkfd/kfd_iommu.h    |  78 +++++++
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h     |  17 +-
 drivers/gpu/drm/amd/amdkfd/kfd_process.c  | 151 +------------
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c |  18 +-
 drivers/gpu/drm/amd/amdkfd/kfd_topology.h |   8 +-
 10 files changed, 476 insertions(+), 309 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/amdkfd/kfd_iommu.c
 create mode 100644 drivers/gpu/drm/amd/amdkfd/kfd_iommu.h

diff --git a/drivers/gpu/drm/amd/amdkfd/Makefile b/drivers/gpu/drm/amd/amdkfd/Makefile
index a317e76..0d02422 100644
--- a/drivers/gpu/drm/amd/amdkfd/Makefile
+++ b/drivers/gpu/drm/amd/amdkfd/Makefile
@@ -37,6 +37,10 @@ amdkfd-y	:= kfd_module.o kfd_device.o kfd_chardev.o kfd_topology.o \
 		kfd_interrupt.o kfd_events.o cik_event_interrupt.o \
 		kfd_dbgdev.o kfd_dbgmgr.o kfd_crat.o
 
+ifneq ($(CONFIG_AMD_IOMMU_V2),)
+amdkfd-y += kfd_iommu.o
+endif
+
 amdkfd-$(CONFIG_DEBUG_FS) += kfd_debugfs.o
 
 obj-$(CONFIG_HSA_AMD)	+= amdkfd.o
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
index c1981b1..3c6c4cdd 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
@@ -22,12 +22,10 @@
 
 #include <linux/pci.h>
 #include <linux/acpi.h>
-#if defined(CONFIG_AMD_IOMMU_V2_MODULE) || defined(CONFIG_AMD_IOMMU_V2)
-#include <linux/amd-iommu.h>
-#endif
 #include "kfd_crat.h"
 #include "kfd_priv.h"
 #include "kfd_topology.h"
+#include "kfd_iommu.h"
 
 /* GPU Processor ID base for dGPUs for which VCRAT needs to be created.
  * GPU processor ID are expressed with Bit[31]=1.
@@ -1044,12 +1042,6 @@ static int kfd_create_vcrat_image_gpu(void *pcrat_image,
 	int num_of_cache_entries = 0;
 	int cache_mem_filled = 0;
 	int ret = 0;
-#if defined(CONFIG_AMD_IOMMU_V2_MODULE) || defined(CONFIG_AMD_IOMMU_V2)
-	struct amd_iommu_device_info iommu_info;
-	const u32 required_iommu_flags = AMD_IOMMU_DEVICE_FLAG_ATS_SUP |
-					 AMD_IOMMU_DEVICE_FLAG_PRI_SUP |
-					 AMD_IOMMU_DEVICE_FLAG_PASID_SUP;
-#endif
 	struct kfd_local_mem_info local_mem_info;
 
 	if (!pcrat_image || avail_size < VCRAT_SIZE_FOR_GPU)
@@ -1110,14 +1102,8 @@ static int kfd_create_vcrat_image_gpu(void *pcrat_image,
 	/* Check if this node supports IOMMU. During parsing this flag will
 	 * translate to HSA_CAP_ATS_PRESENT
 	 */
-#if defined(CONFIG_AMD_IOMMU_V2_MODULE) || defined(CONFIG_AMD_IOMMU_V2)
-	iommu_info.flags = 0;
-	if (amd_iommu_device_info(kdev->pdev, &iommu_info) == 0) {
-		if ((iommu_info.flags & required_iommu_flags) ==
-				required_iommu_flags)
-			cu->hsa_capability |= CRAT_CU_FLAGS_IOMMU_PRESENT;
-	}
-#endif
+	if (!kfd_iommu_check_device(kdev))
+		cu->hsa_capability |= CRAT_CU_FLAGS_IOMMU_PRESENT;
 
 	crat_table->length += sub_type_hdr->length;
 	crat_table->total_entries++;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index 9299a91..f87ee43 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -30,11 +30,12 @@
 #include "kfd_device_queue_manager.h"
 #include "kfd_pm4_headers_vi.h"
 #include "cwsr_trap_handler_gfx8.asm"
+#include "kfd_iommu.h"
 
 #define MQD_SIZE_ALIGNED 768
 static atomic_t kfd_device_suspended = ATOMIC_INIT(0);
 
-#if defined(CONFIG_AMD_IOMMU_V2_MODULE) || defined(CONFIG_AMD_IOMMU_V2)
+#ifdef KFD_SUPPORT_IOMMU_V2
 static const struct kfd_device_info kaveri_device_info = {
 	.asic_family = CHIP_KAVERI,
 	.max_pasid_bits = 16,
@@ -177,7 +178,7 @@ struct kfd_deviceid {
 };
 
 static const struct kfd_deviceid supported_devices[] = {
-#if defined(CONFIG_AMD_IOMMU_V2_MODULE) || defined(CONFIG_AMD_IOMMU_V2)
+#ifdef KFD_SUPPORT_IOMMU_V2
 	{ 0x1304, &kaveri_device_info },	/* Kaveri */
 	{ 0x1305, &kaveri_device_info },	/* Kaveri */
 	{ 0x1306, &kaveri_device_info },	/* Kaveri */
@@ -319,79 +320,6 @@ struct kfd_dev *kgd2kfd_probe(struct kgd_dev *kgd,
 	return kfd;
 }
 
-#if defined(CONFIG_AMD_IOMMU_V2_MODULE) || defined(CONFIG_AMD_IOMMU_V2)
-static bool device_iommu_pasid_init(struct kfd_dev *kfd)
-{
-	const u32 required_iommu_flags = AMD_IOMMU_DEVICE_FLAG_ATS_SUP |
-					AMD_IOMMU_DEVICE_FLAG_PRI_SUP |
-					AMD_IOMMU_DEVICE_FLAG_PASID_SUP;
-
-	struct amd_iommu_device_info iommu_info;
-	unsigned int pasid_limit;
-	int err;
-
-	err = amd_iommu_device_info(kfd->pdev, &iommu_info);
-	if (err < 0) {
-		dev_err(kfd_device,
-			"error getting iommu info. is the iommu enabled?\n");
-		return false;
-	}
-
-	if ((iommu_info.flags & required_iommu_flags) != required_iommu_flags) {
-		dev_err(kfd_device, "error required iommu flags ats %i, pri %i, pasid %i\n",
-		       (iommu_info.flags & AMD_IOMMU_DEVICE_FLAG_ATS_SUP) != 0,
-		       (iommu_info.flags & AMD_IOMMU_DEVICE_FLAG_PRI_SUP) != 0,
-		       (iommu_info.flags & AMD_IOMMU_DEVICE_FLAG_PASID_SUP)
-									!= 0);
-		return false;
-	}
-
-	pasid_limit = min_t(unsigned int,
-			(unsigned int)(1 << kfd->device_info->max_pasid_bits),
-			iommu_info.max_pasids);
-
-	if (!kfd_set_pasid_limit(pasid_limit)) {
-		dev_err(kfd_device, "error setting pasid limit\n");
-		return false;
-	}
-
-	return true;
-}
-
-static void iommu_pasid_shutdown_callback(struct pci_dev *pdev, int pasid)
-{
-	struct kfd_dev *dev = kfd_device_by_pci_dev(pdev);
-
-	if (dev)
-		kfd_process_iommu_unbind_callback(dev, pasid);
-}
-
-/*
- * This function called by IOMMU driver on PPR failure
- */
-static int iommu_invalid_ppr_cb(struct pci_dev *pdev, int pasid,
-		unsigned long address, u16 flags)
-{
-	struct kfd_dev *dev;
-
-	dev_warn(kfd_device,
-			"Invalid PPR device %x:%x.%x pasid %d address 0x%lX flags 0x%X",
-			PCI_BUS_NUM(pdev->devfn),
-			PCI_SLOT(pdev->devfn),
-			PCI_FUNC(pdev->devfn),
-			pasid,
-			address,
-			flags);
-
-	dev = kfd_device_by_pci_dev(pdev);
-	if (!WARN_ON(!dev))
-		kfd_signal_iommu_event(dev, pasid, address,
-			flags & PPR_FAULT_WRITE, flags & PPR_FAULT_EXEC);
-
-	return AMD_IOMMU_INV_PRI_RSP_INVALID;
-}
-#endif /* CONFIG_AMD_IOMMU_V2 */
-
 static void kfd_cwsr_init(struct kfd_dev *kfd)
 {
 	if (cwsr_enable && kfd->device_info->supports_cwsr) {
@@ -481,14 +409,10 @@ bool kgd2kfd_device_init(struct kfd_dev *kfd,
 		goto device_queue_manager_error;
 	}
 
-#if defined(CONFIG_AMD_IOMMU_V2_MODULE) || defined(CONFIG_AMD_IOMMU_V2)
-	if (kfd->device_info->needs_iommu_device) {
-		if (!device_iommu_pasid_init(kfd)) {
-			dev_err(kfd_device, "Error initializing iommuv2\n");
-			goto device_iommu_pasid_error;
-		}
+	if (!kfd_iommu_device_init(kfd)) {
+		dev_err(kfd_device, "Error initializing iommuv2\n");
+		goto device_iommu_error;
 	}
-#endif
 
 	kfd_cwsr_init(kfd);
 
@@ -507,7 +431,7 @@ bool kgd2kfd_device_init(struct kfd_dev *kfd,
 	goto out;
 
 kfd_resume_error:
-device_iommu_pasid_error:
+device_iommu_error:
 	device_queue_manager_uninit(kfd->dqm);
 device_queue_manager_error:
 	kfd_interrupt_exit(kfd);
@@ -552,16 +476,7 @@ void kgd2kfd_suspend(struct kfd_dev *kfd)
 
 	kfd->dqm->ops.stop(kfd->dqm);
 
-#if defined(CONFIG_AMD_IOMMU_V2_MODULE) || defined(CONFIG_AMD_IOMMU_V2)
-	if (!kfd->device_info->needs_iommu_device)
-		return;
-
-	kfd_unbind_processes_from_device(kfd);
-
-	amd_iommu_set_invalidate_ctx_cb(kfd->pdev, NULL);
-	amd_iommu_set_invalid_ppr_cb(kfd->pdev, NULL);
-	amd_iommu_free_device(kfd->pdev);
-#endif
+	kfd_iommu_suspend(kfd);
 }
 
 int kgd2kfd_resume(struct kfd_dev *kfd)
@@ -587,23 +502,9 @@ static int kfd_resume(struct kfd_dev *kfd)
 {
 	int err = 0;
 
-#if defined(CONFIG_AMD_IOMMU_V2_MODULE) || defined(CONFIG_AMD_IOMMU_V2)
-	if (kfd->device_info->needs_iommu_device) {
-		unsigned int pasid_limit = kfd_get_pasid_limit();
-
-		err = amd_iommu_init_device(kfd->pdev, pasid_limit);
-		if (err)
-			return -ENXIO;
-		amd_iommu_set_invalidate_ctx_cb(kfd->pdev,
-						iommu_pasid_shutdown_callback);
-		amd_iommu_set_invalid_ppr_cb(kfd->pdev,
-					     iommu_invalid_ppr_cb);
-
-		err = kfd_bind_processes_to_device(kfd);
-		if (err)
-			goto processes_bind_error;
-	}
-#endif
+	err = kfd_iommu_resume(kfd);
+	if (err)
+		return err;
 
 	err = kfd->dqm->ops.start(kfd->dqm);
 	if (err) {
@@ -616,11 +517,7 @@ static int kfd_resume(struct kfd_dev *kfd)
 	return err;
 
 dqm_start_error:
-processes_bind_error:
-#if defined(CONFIG_AMD_IOMMU_V2_MODULE) || defined(CONFIG_AMD_IOMMU_V2)
-	if (kfd->device_info->needs_iommu_device)
-		amd_iommu_free_device(kfd->pdev);
-#endif
+	kfd_iommu_suspend(kfd);
 	return err;
 }
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_events.c b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
index 56ec74a..4890a90 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_events.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
@@ -30,6 +30,7 @@
 #include <linux/memory.h>
 #include "kfd_priv.h"
 #include "kfd_events.h"
+#include "kfd_iommu.h"
 #include <linux/device.h>
 
 /*
@@ -864,7 +865,7 @@ static void lookup_events_by_type_and_signal(struct kfd_process *p,
 	}
 }
 
-#if defined(CONFIG_AMD_IOMMU_V2_MODULE) || defined(CONFIG_AMD_IOMMU_V2)
+#ifdef KFD_SUPPORT_IOMMU_V2
 void kfd_signal_iommu_event(struct kfd_dev *dev, unsigned int pasid,
 		unsigned long address, bool is_write_requested,
 		bool is_execute_requested)
@@ -933,7 +934,7 @@ void kfd_signal_iommu_event(struct kfd_dev *dev, unsigned int pasid,
 	mutex_unlock(&p->event_mutex);
 	kfd_unref_process(p);
 }
-#endif /* CONFIG_AMD_IOMMU_V2_MODULE */
+#endif /* KFD_SUPPORT_IOMMU_V2 */
 
 void kfd_signal_hw_exception_event(unsigned int pasid)
 {
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_iommu.c b/drivers/gpu/drm/amd/amdkfd/kfd_iommu.c
new file mode 100644
index 0000000..333c1ff
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_iommu.c
@@ -0,0 +1,357 @@
+/*
+ * Copyright 2018 Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ */
+
+#include <linux/printk.h>
+#include <linux/device.h>
+#include <linux/slab.h>
+#include <linux/pci.h>
+#include <linux/amd-iommu.h>
+#include "kfd_priv.h"
+#include "kfd_dbgmgr.h"
+#include "kfd_topology.h"
+#include "kfd_iommu.h"
+
+static const u32 required_iommu_flags = AMD_IOMMU_DEVICE_FLAG_ATS_SUP |
+					AMD_IOMMU_DEVICE_FLAG_PRI_SUP |
+					AMD_IOMMU_DEVICE_FLAG_PASID_SUP;
+
+/** kfd_iommu_check_device - Check whether IOMMU is available for device
+ */
+int kfd_iommu_check_device(struct kfd_dev *kfd)
+{
+	struct amd_iommu_device_info iommu_info;
+	int err;
+
+	if (!kfd->device_info->needs_iommu_device)
+		return -ENODEV;
+
+	iommu_info.flags = 0;
+	err = amd_iommu_device_info(kfd->pdev, &iommu_info);
+	if (err)
+		return err;
+
+	if ((iommu_info.flags & required_iommu_flags) != required_iommu_flags)
+		return -ENODEV;
+
+	return 0;
+}
+
+/** kfd_iommu_device_init - Initialize IOMMU for device
+ */
+int kfd_iommu_device_init(struct kfd_dev *kfd)
+{
+	struct amd_iommu_device_info iommu_info;
+	unsigned int pasid_limit;
+	int err;
+
+	if (!kfd->device_info->needs_iommu_device)
+		return 0;
+
+	iommu_info.flags = 0;
+	err = amd_iommu_device_info(kfd->pdev, &iommu_info);
+	if (err < 0) {
+		dev_err(kfd_device,
+			"error getting iommu info. is the iommu enabled?\n");
+		return -ENODEV;
+	}
+
+	if ((iommu_info.flags & required_iommu_flags) != required_iommu_flags) {
+		dev_err(kfd_device, "error required iommu flags ats %i, pri %i, pasid %i\n",
+		       (iommu_info.flags & AMD_IOMMU_DEVICE_FLAG_ATS_SUP) != 0,
+		       (iommu_info.flags & AMD_IOMMU_DEVICE_FLAG_PRI_SUP) != 0,
+		       (iommu_info.flags & AMD_IOMMU_DEVICE_FLAG_PASID_SUP)
+									!= 0);
+		return -ENODEV;
+	}
+
+	pasid_limit = min_t(unsigned int,
+			(unsigned int)(1 << kfd->device_info->max_pasid_bits),
+			iommu_info.max_pasids);
+
+	if (!kfd_set_pasid_limit(pasid_limit)) {
+		dev_err(kfd_device, "error setting pasid limit\n");
+		return -EBUSY;
+	}
+
+	return 0;
+}
+
+/** kfd_iommu_bind_process_to_device - Have the IOMMU bind a process
+ *
+ * Binds the given process to the given device using its PASID. This
+ * enables IOMMUv2 address translation for the process on the device.
+ *
+ * This function assumes that the process mutex is held.
+ */
+int kfd_iommu_bind_process_to_device(struct kfd_process_device *pdd)
+{
+	struct kfd_dev *dev = pdd->dev;
+	struct kfd_process *p = pdd->process;
+	int err;
+
+	if (!dev->device_info->needs_iommu_device || pdd->bound == PDD_BOUND)
+		return 0;
+
+	if (unlikely(pdd->bound == PDD_BOUND_SUSPENDED)) {
+		pr_err("Binding PDD_BOUND_SUSPENDED pdd is unexpected!\n");
+		return -EINVAL;
+	}
+
+	err = amd_iommu_bind_pasid(dev->pdev, p->pasid, p->lead_thread);
+	if (!err)
+		pdd->bound = PDD_BOUND;
+
+	return err;
+}
+
+/** kfd_iommu_unbind_process - Unbind process from all devices
+ *
+ * This removes all IOMMU device bindings of the process. To be used
+ * before process termination.
+ */
+void kfd_iommu_unbind_process(struct kfd_process *p)
+{
+	struct kfd_process_device *pdd;
+
+	list_for_each_entry(pdd, &p->per_device_data, per_device_list)
+		if (pdd->bound == PDD_BOUND)
+			amd_iommu_unbind_pasid(pdd->dev->pdev, p->pasid);
+}
+
+/* Callback for process shutdown invoked by the IOMMU driver */
+static void iommu_pasid_shutdown_callback(struct pci_dev *pdev, int pasid)
+{
+	struct kfd_dev *dev = kfd_device_by_pci_dev(pdev);
+	struct kfd_process *p;
+	struct kfd_process_device *pdd;
+
+	if (!dev)
+		return;
+
+	/*
+	 * Look for the process that matches the pasid. If there is no such
+	 * process, we either released it in amdkfd's own notifier, or there
+	 * is a bug. Unfortunately, there is no way to tell...
+	 */
+	p = kfd_lookup_process_by_pasid(pasid);
+	if (!p)
+		return;
+
+	pr_debug("Unbinding process %d from IOMMU\n", pasid);
+
+	mutex_lock(kfd_get_dbgmgr_mutex());
+
+	if (dev->dbgmgr && dev->dbgmgr->pasid == p->pasid) {
+		if (!kfd_dbgmgr_unregister(dev->dbgmgr, p)) {
+			kfd_dbgmgr_destroy(dev->dbgmgr);
+			dev->dbgmgr = NULL;
+		}
+	}
+
+	mutex_unlock(kfd_get_dbgmgr_mutex());
+
+	mutex_lock(&p->mutex);
+
+	pdd = kfd_get_process_device_data(dev, p);
+	if (pdd)
+		/* For GPU relying on IOMMU, we need to dequeue here
+		 * when PASID is still bound.
+		 */
+		kfd_process_dequeue_from_device(pdd);
+
+	mutex_unlock(&p->mutex);
+
+	kfd_unref_process(p);
+}
+
+/* This function called by IOMMU driver on PPR failure */
+static int iommu_invalid_ppr_cb(struct pci_dev *pdev, int pasid,
+		unsigned long address, u16 flags)
+{
+	struct kfd_dev *dev;
+
+	dev_warn(kfd_device,
+			"Invalid PPR device %x:%x.%x pasid %d address 0x%lX flags 0x%X",
+			PCI_BUS_NUM(pdev->devfn),
+			PCI_SLOT(pdev->devfn),
+			PCI_FUNC(pdev->devfn),
+			pasid,
+			address,
+			flags);
+
+	dev = kfd_device_by_pci_dev(pdev);
+	if (!WARN_ON(!dev))
+		kfd_signal_iommu_event(dev, pasid, address,
+			flags & PPR_FAULT_WRITE, flags & PPR_FAULT_EXEC);
+
+	return AMD_IOMMU_INV_PRI_RSP_INVALID;
+}
+
+/*
+ * Bind processes do the device that have been temporarily unbound
+ * (PDD_BOUND_SUSPENDED) in kfd_unbind_processes_from_device.
+ */
+static int kfd_bind_processes_to_device(struct kfd_dev *kfd)
+{
+	struct kfd_process_device *pdd;
+	struct kfd_process *p;
+	unsigned int temp;
+	int err = 0;
+
+	int idx = srcu_read_lock(&kfd_processes_srcu);
+
+	hash_for_each_rcu(kfd_processes_table, temp, p, kfd_processes) {
+		mutex_lock(&p->mutex);
+		pdd = kfd_get_process_device_data(kfd, p);
+
+		if (WARN_ON(!pdd) || pdd->bound != PDD_BOUND_SUSPENDED) {
+			mutex_unlock(&p->mutex);
+			continue;
+		}
+
+		err = amd_iommu_bind_pasid(kfd->pdev, p->pasid,
+				p->lead_thread);
+		if (err < 0) {
+			pr_err("Unexpected pasid %d binding failure\n",
+					p->pasid);
+			mutex_unlock(&p->mutex);
+			break;
+		}
+
+		pdd->bound = PDD_BOUND;
+		mutex_unlock(&p->mutex);
+	}
+
+	srcu_read_unlock(&kfd_processes_srcu, idx);
+
+	return err;
+}
+
+/*
+ * Mark currently bound processes as PDD_BOUND_SUSPENDED. These
+ * processes will be restored to PDD_BOUND state in
+ * kfd_bind_processes_to_device.
+ */
+static void kfd_unbind_processes_from_device(struct kfd_dev *kfd)
+{
+	struct kfd_process_device *pdd;
+	struct kfd_process *p;
+	unsigned int temp;
+
+	int idx = srcu_read_lock(&kfd_processes_srcu);
+
+	hash_for_each_rcu(kfd_processes_table, temp, p, kfd_processes) {
+		mutex_lock(&p->mutex);
+		pdd = kfd_get_process_device_data(kfd, p);
+
+		if (WARN_ON(!pdd)) {
+			mutex_unlock(&p->mutex);
+			continue;
+		}
+
+		if (pdd->bound == PDD_BOUND)
+			pdd->bound = PDD_BOUND_SUSPENDED;
+		mutex_unlock(&p->mutex);
+	}
+
+	srcu_read_unlock(&kfd_processes_srcu, idx);
+}
+
+/** kfd_iommu_suspend - Prepare IOMMU for suspend
+ *
+ * This unbinds processes from the device and disables the IOMMU for
+ * the device.
+ */
+void kfd_iommu_suspend(struct kfd_dev *kfd)
+{
+	if (!kfd->device_info->needs_iommu_device)
+		return;
+
+	kfd_unbind_processes_from_device(kfd);
+
+	amd_iommu_set_invalidate_ctx_cb(kfd->pdev, NULL);
+	amd_iommu_set_invalid_ppr_cb(kfd->pdev, NULL);
+	amd_iommu_free_device(kfd->pdev);
+}
+
+/** kfd_iommu_resume - Restore IOMMU after resume
+ *
+ * This reinitializes the IOMMU for the device and re-binds previously
+ * suspended processes to the device.
+ */
+int kfd_iommu_resume(struct kfd_dev *kfd)
+{
+	unsigned int pasid_limit;
+	int err;
+
+	if (kfd->device_info->needs_iommu_device)
+		return 0;
+
+	pasid_limit = kfd_get_pasid_limit();
+
+	err = amd_iommu_init_device(kfd->pdev, pasid_limit);
+	if (err)
+		return -ENXIO;
+
+	amd_iommu_set_invalidate_ctx_cb(kfd->pdev,
+					iommu_pasid_shutdown_callback);
+	amd_iommu_set_invalid_ppr_cb(kfd->pdev,
+				     iommu_invalid_ppr_cb);
+
+	err = kfd_bind_processes_to_device(kfd);
+	if (err)
+		goto processes_bind_error;
+
+processes_bind_error:
+	amd_iommu_set_invalidate_ctx_cb(kfd->pdev, NULL);
+	amd_iommu_set_invalid_ppr_cb(kfd->pdev, NULL);
+	amd_iommu_free_device(kfd->pdev);
+
+	return err;
+}
+
+extern bool amd_iommu_pc_supported(void);
+extern u8 amd_iommu_pc_get_max_banks(u16 devid);
+extern u8 amd_iommu_pc_get_max_counters(u16 devid);
+
+/** kfd_iommu_add_perf_counters - Add IOMMU performance counters to topology
+ */
+int kfd_iommu_add_perf_counters(struct kfd_topology_device *kdev)
+{
+	struct kfd_perf_properties *props;
+
+	if (!(kdev->node_props.capability & HSA_CAP_ATS_PRESENT))
+		return 0;
+
+	if (!amd_iommu_pc_supported())
+		return 0;
+
+	props = kfd_alloc_struct(props);
+	if (!props)
+		return -ENOMEM;
+	strcpy(props->block_name, "iommu");
+	props->max_concurrent = amd_iommu_pc_get_max_banks(0) *
+		amd_iommu_pc_get_max_counters(0); /* assume one iommu */
+	list_add_tail(&props->list, &kdev->perf_props);
+
+	return 0;
+}
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_iommu.h b/drivers/gpu/drm/amd/amdkfd/kfd_iommu.h
new file mode 100644
index 0000000..dd23d9f
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_iommu.h
@@ -0,0 +1,78 @@
+/*
+ * Copyright 2018 Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ */
+
+#ifndef __KFD_IOMMU_H__
+#define __KFD_IOMMU_H__
+
+#if defined(CONFIG_AMD_IOMMU_V2_MODULE) || defined(CONFIG_AMD_IOMMU_V2)
+
+#define KFD_SUPPORT_IOMMU_V2
+
+int kfd_iommu_check_device(struct kfd_dev *kfd);
+int kfd_iommu_device_init(struct kfd_dev *kfd);
+
+int kfd_iommu_bind_process_to_device(struct kfd_process_device *pdd);
+void kfd_iommu_unbind_process(struct kfd_process *p);
+
+void kfd_iommu_suspend(struct kfd_dev *kfd);
+int kfd_iommu_resume(struct kfd_dev *kfd);
+
+int kfd_iommu_add_perf_counters(struct kfd_topology_device *kdev);
+
+#else
+
+static inline int kfd_iommu_check_device(struct kfd_dev *kfd)
+{
+	return -ENODEV;
+}
+static inline int kfd_iommu_device_init(struct kfd_dev *kfd)
+{
+	return 0;
+}
+
+static inline int kfd_iommu_bind_process_to_device(
+	struct kfd_process_device *pdd)
+{
+	return 0;
+}
+static inline void kfd_iommu_unbind_process(struct kfd_process *p)
+{
+	/* empty */
+}
+
+static inline void kfd_iommu_suspend(struct kfd_dev *kfd)
+{
+	/* empty */
+}
+static inline int kfd_iommu_resume(struct kfd_dev *kfd)
+{
+	return 0;
+}
+
+static inline int kfd_iommu_add_perf_counters(struct kfd_topology_device *kdev)
+{
+	return 0;
+}
+
+#endif /* defined(CONFIG_AMD_IOMMU_V2) */
+
+#endif /* __KFD_IOMMU_H__ */
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index 2eba853..63e86926 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -554,9 +554,6 @@ struct kfd_process_device {
 	uint64_t scratch_base;
 	uint64_t scratch_limit;
 
-	/* Is this process/pasid bound to this device? (amd_iommu_bind_pasid) */
-	enum kfd_pdd_bound bound;
-
 	/* VM context for GPUVM allocations */
 	void *vm;
 
@@ -569,6 +566,9 @@ struct kfd_process_device {
 	 * function.
 	 */
 	bool already_dequeued;
+
+	/* Is this process/pasid bound to this device? (amd_iommu_bind_pasid) */
+	enum kfd_pdd_bound bound;
 };
 
 #define qpd_to_pdd(x) container_of(x, struct kfd_process_device, qpd)
@@ -651,6 +651,10 @@ struct kfd_process {
 	unsigned long last_restore_timestamp;
 };
 
+#define KFD_PROCESS_TABLE_SIZE 5 /* bits: 32 entries */
+extern DECLARE_HASHTABLE(kfd_processes_table, KFD_PROCESS_TABLE_SIZE);
+extern struct srcu_struct kfd_processes_srcu;
+
 /**
  * Ioctl function type.
  *
@@ -681,11 +685,6 @@ int kfd_resume_all_processes(void);
 
 struct kfd_process_device *kfd_bind_process_to_device(struct kfd_dev *dev,
 						struct kfd_process *p);
-#if defined(CONFIG_AMD_IOMMU_V2_MODULE) || defined(CONFIG_AMD_IOMMU_V2)
-int kfd_bind_processes_to_device(struct kfd_dev *dev);
-void kfd_unbind_processes_from_device(struct kfd_dev *dev);
-void kfd_process_iommu_unbind_callback(struct kfd_dev *dev, unsigned int pasid);
-#endif
 struct kfd_process_device *kfd_get_process_device_data(struct kfd_dev *dev,
 							struct kfd_process *p);
 struct kfd_process_device *kfd_create_process_device_data(struct kfd_dev *dev,
@@ -864,11 +863,9 @@ int kfd_wait_on_events(struct kfd_process *p,
 		       uint32_t *wait_result);
 void kfd_signal_event_interrupt(unsigned int pasid, uint32_t partial_id,
 				uint32_t valid_id_bits);
-#if defined(CONFIG_AMD_IOMMU_V2_MODULE) || defined(CONFIG_AMD_IOMMU_V2)
 void kfd_signal_iommu_event(struct kfd_dev *dev,
 		unsigned int pasid, unsigned long address,
 		bool is_write_requested, bool is_execute_requested);
-#endif
 void kfd_signal_hw_exception_event(unsigned int pasid);
 int kfd_set_event(struct kfd_process *p, uint32_t event_id);
 int kfd_reset_event(struct kfd_process *p, uint32_t event_id);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index 32c0f34..0684c49 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -36,16 +36,16 @@ struct mm_struct;
 #include "kfd_priv.h"
 #include "kfd_device_queue_manager.h"
 #include "kfd_dbgmgr.h"
+#include "kfd_iommu.h"
 
 /*
  * List of struct kfd_process (field kfd_process).
  * Unique/indexed by mm_struct*
  */
-#define KFD_PROCESS_TABLE_SIZE 5 /* bits: 32 entries */
-static DEFINE_HASHTABLE(kfd_processes_table, KFD_PROCESS_TABLE_SIZE);
+DEFINE_HASHTABLE(kfd_processes_table, KFD_PROCESS_TABLE_SIZE);
 static DEFINE_MUTEX(kfd_processes_mutex);
 
-DEFINE_STATIC_SRCU(kfd_processes_srcu);
+DEFINE_SRCU(kfd_processes_srcu);
 
 static struct workqueue_struct *kfd_process_wq;
 
@@ -333,17 +333,8 @@ static void kfd_process_wq_release(struct work_struct *work)
 {
 	struct kfd_process *p = container_of(work, struct kfd_process,
 					     release_work);
-#if defined(CONFIG_AMD_IOMMU_V2_MODULE) || defined(CONFIG_AMD_IOMMU_V2)
-	struct kfd_process_device *pdd;
-
-	pr_debug("Releasing process (pasid %d) in workqueue\n", p->pasid);
 
-	list_for_each_entry(pdd, &p->per_device_data, per_device_list) {
-		if (pdd->bound == PDD_BOUND &&
-		    pdd->dev->device_info->needs_iommu_device)
-			amd_iommu_unbind_pasid(pdd->dev->pdev, p->pasid);
-	}
-#endif
+	kfd_iommu_unbind_process(p);
 
 	kfd_process_free_outstanding_kfd_bos(p);
 
@@ -636,6 +627,7 @@ struct kfd_process_device *kfd_bind_process_to_device(struct kfd_dev *dev,
 							struct kfd_process *p)
 {
 	struct kfd_process_device *pdd;
+	int err;
 
 	pdd = kfd_get_process_device_data(dev, p);
 	if (!pdd) {
@@ -643,140 +635,13 @@ struct kfd_process_device *kfd_bind_process_to_device(struct kfd_dev *dev,
 		return ERR_PTR(-ENOMEM);
 	}
 
-	if (pdd->bound == PDD_BOUND) {
-		return pdd;
-	} else if (unlikely(pdd->bound == PDD_BOUND_SUSPENDED)) {
-		pr_err("Binding PDD_BOUND_SUSPENDED pdd is unexpected!\n");
-		return ERR_PTR(-EINVAL);
-	}
-
-#if defined(CONFIG_AMD_IOMMU_V2_MODULE) || defined(CONFIG_AMD_IOMMU_V2)
-	if (dev->device_info->needs_iommu_device) {
-		int err = amd_iommu_bind_pasid(dev->pdev, p->pasid,
-					       p->lead_thread);
-		if (err < 0)
-			return ERR_PTR(err);
-	}
-#endif
-
-	pdd->bound = PDD_BOUND;
+	err = kfd_iommu_bind_process_to_device(pdd);
+	if (err)
+		return ERR_PTR(err);
 
 	return pdd;
 }
 
-#if defined(CONFIG_AMD_IOMMU_V2_MODULE) || defined(CONFIG_AMD_IOMMU_V2)
-/*
- * Bind processes do the device that have been temporarily unbound
- * (PDD_BOUND_SUSPENDED) in kfd_unbind_processes_from_device.
- */
-int kfd_bind_processes_to_device(struct kfd_dev *dev)
-{
-	struct kfd_process_device *pdd;
-	struct kfd_process *p;
-	unsigned int temp;
-	int err = 0;
-
-	int idx = srcu_read_lock(&kfd_processes_srcu);
-
-	hash_for_each_rcu(kfd_processes_table, temp, p, kfd_processes) {
-		mutex_lock(&p->mutex);
-		pdd = kfd_get_process_device_data(dev, p);
-
-		if (WARN_ON(!pdd) || pdd->bound != PDD_BOUND_SUSPENDED) {
-			mutex_unlock(&p->mutex);
-			continue;
-		}
-
-		err = amd_iommu_bind_pasid(dev->pdev, p->pasid,
-				p->lead_thread);
-		if (err < 0) {
-			pr_err("Unexpected pasid %d binding failure\n",
-					p->pasid);
-			mutex_unlock(&p->mutex);
-			break;
-		}
-
-		pdd->bound = PDD_BOUND;
-		mutex_unlock(&p->mutex);
-	}
-
-	srcu_read_unlock(&kfd_processes_srcu, idx);
-
-	return err;
-}
-
-/*
- * Mark currently bound processes as PDD_BOUND_SUSPENDED. These
- * processes will be restored to PDD_BOUND state in
- * kfd_bind_processes_to_device.
- */
-void kfd_unbind_processes_from_device(struct kfd_dev *dev)
-{
-	struct kfd_process_device *pdd;
-	struct kfd_process *p;
-	unsigned int temp;
-
-	int idx = srcu_read_lock(&kfd_processes_srcu);
-
-	hash_for_each_rcu(kfd_processes_table, temp, p, kfd_processes) {
-		mutex_lock(&p->mutex);
-		pdd = kfd_get_process_device_data(dev, p);
-
-		if (WARN_ON(!pdd)) {
-			mutex_unlock(&p->mutex);
-			continue;
-		}
-
-		if (pdd->bound == PDD_BOUND)
-			pdd->bound = PDD_BOUND_SUSPENDED;
-		mutex_unlock(&p->mutex);
-	}
-
-	srcu_read_unlock(&kfd_processes_srcu, idx);
-}
-
-void kfd_process_iommu_unbind_callback(struct kfd_dev *dev, unsigned int pasid)
-{
-	struct kfd_process *p;
-	struct kfd_process_device *pdd;
-
-	/*
-	 * Look for the process that matches the pasid. If there is no such
-	 * process, we either released it in amdkfd's own notifier, or there
-	 * is a bug. Unfortunately, there is no way to tell...
-	 */
-	p = kfd_lookup_process_by_pasid(pasid);
-	if (!p)
-		return;
-
-	pr_debug("Unbinding process %d from IOMMU\n", pasid);
-
-	mutex_lock(kfd_get_dbgmgr_mutex());
-
-	if (dev->dbgmgr && dev->dbgmgr->pasid == p->pasid) {
-		if (!kfd_dbgmgr_unregister(dev->dbgmgr, p)) {
-			kfd_dbgmgr_destroy(dev->dbgmgr);
-			dev->dbgmgr = NULL;
-		}
-	}
-
-	mutex_unlock(kfd_get_dbgmgr_mutex());
-
-	mutex_lock(&p->mutex);
-
-	pdd = kfd_get_process_device_data(dev, p);
-	if (pdd)
-		/* For GPU relying on IOMMU, we need to dequeue here
-		 * when PASID is still bound.
-		 */
-		kfd_process_dequeue_from_device(pdd);
-
-	mutex_unlock(&p->mutex);
-
-	kfd_unref_process(p);
-}
-#endif /* CONFIG_AMD_IOMMU_V2 */
-
 struct kfd_process_device *kfd_get_first_process_device_data(
 						struct kfd_process *p)
 {
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
index af77e42..9de9ac9 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
@@ -35,6 +35,7 @@
 #include "kfd_crat.h"
 #include "kfd_topology.h"
 #include "kfd_device_queue_manager.h"
+#include "kfd_iommu.h"
 
 /* topology_device_list - Master list of all topology devices */
 static struct list_head topology_device_list;
@@ -877,21 +878,8 @@ static void find_system_memory(const struct dmi_header *dm,
  */
 static int kfd_add_perf_to_topology(struct kfd_topology_device *kdev)
 {
-#if defined(CONFIG_AMD_IOMMU_V2_MODULE) || defined(CONFIG_AMD_IOMMU_V2)
-	struct kfd_perf_properties *props;
-
-	if (amd_iommu_pc_supported()) {
-		props = kfd_alloc_struct(props);
-		if (!props)
-			return -ENOMEM;
-		strcpy(props->block_name, "iommu");
-		props->max_concurrent = amd_iommu_pc_get_max_banks(0) *
-			amd_iommu_pc_get_max_counters(0); /* assume one iommu */
-		list_add_tail(&props->list, &kdev->perf_props);
-	}
-#endif
-
-	return 0;
+	/* These are the only counters supported so far */
+	return kfd_iommu_add_perf_counters(kdev);
 }
 
 /* kfd_add_non_crat_information - Add information that is not currently
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.h b/drivers/gpu/drm/amd/amdkfd/kfd_topology.h
index be812bb..eb54cfc 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.h
@@ -25,7 +25,7 @@
 
 #include <linux/types.h>
 #include <linux/list.h>
-#include "kfd_priv.h"
+#include "kfd_crat.h"
 
 #define KFD_TOPOLOGY_PUBLIC_NAME_SIZE 128
 
@@ -184,10 +184,4 @@ struct kfd_topology_device *kfd_create_topology_device(
 		struct list_head *device_list);
 void kfd_release_topology_device_list(struct list_head *device_list);
 
-#if defined(CONFIG_AMD_IOMMU_V2_MODULE) || defined(CONFIG_AMD_IOMMU_V2)
-extern bool amd_iommu_pc_supported(void);
-extern u8 amd_iommu_pc_get_max_banks(u16 devid);
-extern u8 amd_iommu_pc_get_max_counters(u16 devid);
-#endif
-
 #endif /* __KFD_TOPOLOGY_H__ */
-- 
2.7.4


--------------63A2EFE5436A6E5848849BC2
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--------------63A2EFE5436A6E5848849BC2--
