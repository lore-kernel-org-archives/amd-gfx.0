From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH libdrm] amdgpu: add a faster BO list API
Date: Wed, 16 Jan 2019 15:43:15 +0100
Message-ID: <3d525127-825b-efab-b0c8-76550634d1c1@gmail.com>
References: <20190107193104.4361-1-maraeo@gmail.com>
 <CAP+8YyFD+LxEQOLOY+mDC5v3OOyh1De2DcXK0sRtMW0t7z20SQ@mail.gmail.com>
 <74054b1e-5211-3bfc-ab0f-27e8604759d1@gmail.com>
 <CAAxE2A5ywFkNMtPbesU_kuSwKCmsPJ0D8wRFuSp14mpORcwYhg@mail.gmail.com>
 <a550562a-7d36-9acf-3143-217c507e667a@amd.com>
 <CAAxE2A4k8JtkrS2XfgRdmYY3NVR4ges=Yqfh-TH9O=LnaVv02g@mail.gmail.com>
Reply-To: christian.koenig-5C7GfCeVMHo@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1910847877=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CAAxE2A4k8JtkrS2XfgRdmYY3NVR4ges=Yqfh-TH9O=LnaVv02g-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
To: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "Koenig, Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>
Cc: amd-gfx mailing list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, Bas Nieuwenhuizen <bas-dldO88ZXqoXqqjsSq9zF6IRWq/SkRNHw@public.gmane.org>

This is a multi-part message in MIME format.
--===============1910847877==
Content-Type: multipart/alternative;
 boundary="------------7DB6E7F80146BE6904688AE2"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------7DB6E7F80146BE6904688AE2
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 16.01.19 um 15:39 schrieb Marek Olšák:
>
>
> On Wed, Jan 16, 2019, 9:34 AM Koenig, Christian 
> <Christian.Koenig-5C7GfCeVMHo@public.gmane.org <mailto:Christian.Koenig-5C7GfCeVMHo@public.gmane.org> wrote:
>
>     Am 16.01.19 um 15:31 schrieb Marek Olšák:
>>
>>
>>     On Wed, Jan 16, 2019, 7:55 AM Christian König
>>     <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
>>     <mailto:ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
>>
>>         Well if you ask me we should have the following interface for
>>         negotiating memory management with the kernel:
>>
>>         1. We have per process BOs which can't be shared between
>>         processes.
>>
>>         Those are always valid and don't need to be mentioned in any
>>         BO list
>>         whatsoever.
>>
>>         If we knew that a per process BO is currently not in use we can
>>         optionally tell that to the kernel to make memory management
>>         more efficient.
>>
>>         In other words instead of a list of stuff which is used we
>>         send down to
>>         the kernel a list of stuff which is not used any more and
>>         that only when
>>         we know that it is necessary, e.g. when a game or application
>>         overcommits.
>>
>>
>>     Radeonsi doesn't use this because this approach caused
>>     performance degradation and also drops BO priorities.
>
>     The performance degradation where mostly shortcomings with the LRU
>     which by now have been fixed.
>
>     BO priorities are a different topic, but could be added to per VM
>     BOs as well.
>
>
> What's the minimum drm version that contains the fixes?

I've pushed the last optimization this morning. No idea when it really 
became useful, but the numbers from the closed source clients now look 
much better.

We should probably test and bump the drm version when we are sure that 
this now works as expected.

Christian.

>
> Marek
>
>
>     Christian.
>
>>
>>     Marek
>>
>>
>>         2. We have shared BOs which are used by more than one process.
>>
>>         Those are rare and should be added to the per CS list of BOs
>>         in use.
>>
>>
>>         The whole BO list interface Marek tries to optimize here
>>         should be
>>         deprecated and not used any more.
>>
>>         Regards,
>>         Christian.
>>
>>         Am 16.01.19 um 13:46 schrieb Bas Nieuwenhuizen:
>>         > So random questions:
>>         >
>>         > 1) In this discussion it was mentioned that some Vulkan
>>         drivers still
>>         > use the bo_list interface. I think that implies radv as I
>>         think we're
>>         > still using bo_list. Is there any other API we should be
>>         using? (Also,
>>         > with VK_EXT_descriptor_indexing I suspect we'll be moving
>>         more towards
>>         > a global bo list instead of a cmd buffer one, as we cannot
>>         know all
>>         > the BOs referenced anymore, but not sure what end state
>>         here will be).
>>         >
>>         > 2) The other alternative mentioned was adding the buffers
>>         directly
>>         > into the submit ioctl. Is this the desired end state
>>         (though as above
>>         > I'm not sure how that works for vulkan)? If yes, what is
>>         the timeline
>>         > for this that we need something in the interim?
>>         >
>>         > 3) Did we measure any performance benefit?
>>         >
>>         > In general I'd like to to ack the raw bo list creation
>>         function as
>>         > this interface seems easier to use. The two arrays thing
>>         has always
>>         > been kind of a pain when we want to use e.g. builtin sort
>>         functions to
>>         > make sure we have no duplicate BOs, but have some comments
>>         below.
>>         >
>>         > On Mon, Jan 7, 2019 at 8:31 PM Marek Olšák
>>         <maraeo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org <mailto:maraeo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>> wrote:
>>         >> From: Marek Olšák <marek.olsak-5C7GfCeVMHo@public.gmane.org
>>         <mailto:marek.olsak-5C7GfCeVMHo@public.gmane.org>>
>>         >>
>>         >> ---
>>         >>   amdgpu/amdgpu-symbol-check |  3 ++
>>         >>   amdgpu/amdgpu.h            | 56
>>         +++++++++++++++++++++++++++++++++++++-
>>         >>   amdgpu/amdgpu_bo.c         | 36 ++++++++++++++++++++++++
>>         >>   amdgpu/amdgpu_cs.c         | 25 +++++++++++++++++
>>         >>   4 files changed, 119 insertions(+), 1 deletion(-)
>>         >>
>>         >> diff --git a/amdgpu/amdgpu-symbol-check
>>         b/amdgpu/amdgpu-symbol-check
>>         >> index 6f5e0f95..96a44b40 100755
>>         >> --- a/amdgpu/amdgpu-symbol-check
>>         >> +++ b/amdgpu/amdgpu-symbol-check
>>         >> @@ -12,20 +12,22 @@ _edata
>>         >>   _end
>>         >>   _fini
>>         >>   _init
>>         >>   amdgpu_bo_alloc
>>         >>   amdgpu_bo_cpu_map
>>         >>   amdgpu_bo_cpu_unmap
>>         >>   amdgpu_bo_export
>>         >>   amdgpu_bo_free
>>         >>   amdgpu_bo_import
>>         >>   amdgpu_bo_inc_ref
>>         >> +amdgpu_bo_list_create_raw
>>         >> +amdgpu_bo_list_destroy_raw
>>         >>   amdgpu_bo_list_create
>>         >>   amdgpu_bo_list_destroy
>>         >>   amdgpu_bo_list_update
>>         >>   amdgpu_bo_query_info
>>         >>   amdgpu_bo_set_metadata
>>         >>   amdgpu_bo_va_op
>>         >>   amdgpu_bo_va_op_raw
>>         >>   amdgpu_bo_wait_for_idle
>>         >>   amdgpu_create_bo_from_user_mem
>>         >>   amdgpu_cs_chunk_fence_info_to_data
>>         >> @@ -40,20 +42,21 @@ amdgpu_cs_destroy_semaphore
>>         >>   amdgpu_cs_destroy_syncobj
>>         >>   amdgpu_cs_export_syncobj
>>         >>   amdgpu_cs_fence_to_handle
>>         >>   amdgpu_cs_import_syncobj
>>         >>   amdgpu_cs_query_fence_status
>>         >>   amdgpu_cs_query_reset_state
>>         >>   amdgpu_query_sw_info
>>         >>   amdgpu_cs_signal_semaphore
>>         >>   amdgpu_cs_submit
>>         >>   amdgpu_cs_submit_raw
>>         >> +amdgpu_cs_submit_raw2
>>         >>   amdgpu_cs_syncobj_export_sync_file
>>         >>   amdgpu_cs_syncobj_import_sync_file
>>         >>   amdgpu_cs_syncobj_reset
>>         >>   amdgpu_cs_syncobj_signal
>>         >>   amdgpu_cs_syncobj_wait
>>         >>   amdgpu_cs_wait_fences
>>         >>   amdgpu_cs_wait_semaphore
>>         >>   amdgpu_device_deinitialize
>>         >>   amdgpu_device_initialize
>>         >>   amdgpu_find_bo_by_cpu_mapping
>>         >> diff --git a/amdgpu/amdgpu.h b/amdgpu/amdgpu.h
>>         >> index dc51659a..5b800033 100644
>>         >> --- a/amdgpu/amdgpu.h
>>         >> +++ b/amdgpu/amdgpu.h
>>         >> @@ -35,20 +35,21 @@
>>         >>   #define _AMDGPU_H_
>>         >>
>>         >>   #include <stdint.h>
>>         >>   #include <stdbool.h>
>>         >>
>>         >>   #ifdef __cplusplus
>>         >>   extern "C" {
>>         >>   #endif
>>         >>
>>         >>   struct drm_amdgpu_info_hw_ip;
>>         >> +struct drm_amdgpu_bo_list_entry;
>>         >>
>>         >>
>>          /*--------------------------------------------------------------------------*/
>>         >>   /* --------------------------- Defines
>>         ------------------------------------ */
>>         >>
>>          /*--------------------------------------------------------------------------*/
>>         >>
>>         >>   /**
>>         >>    * Define max. number of Command Buffers (IB) which
>>         could be sent to the single
>>         >>    * hardware IP to accommodate CE/DE requirements
>>         >>    *
>>         >>    * \sa amdgpu_cs_ib_info
>>         >> @@ -767,34 +768,65 @@ int
>>         amdgpu_bo_cpu_unmap(amdgpu_bo_handle buf_handle);
>>         >>    *                            and no GPU access is
>>         scheduled.
>>         >>    *                          1 GPU access is in fly or
>>         scheduled
>>         >>    *
>>         >>    * \return   0 - on success
>>         >>    *          <0 - Negative POSIX Error code
>>         >>    */
>>         >>   int amdgpu_bo_wait_for_idle(amdgpu_bo_handle buf_handle,
>>         >>                              uint64_t timeout_ns,
>>         >>                              bool *buffer_busy);
>>         >>
>>         >> +/**
>>         >> + * Creates a BO list handle for command submission.
>>         >> + *
>>         >> + * \param   dev   - \c [in] Device handle.
>>         >> + * See #amdgpu_device_initialize()
>>         >> + * \param   number_of_buffers  - \c [in] Number of BOs in
>>         the list
>>         >> + * \param   buffers            - \c [in] List of BO handles
>>         >> + * \param   result             - \c [out] Created BO list
>>         handle
>>         >> + *
>>         >> + * \return   0 on success\n
>>         >> + *          <0 - Negative POSIX Error code
>>         >> + *
>>         >> + * \sa amdgpu_bo_list_destroy_raw()
>>         >> +*/
>>         >> +int amdgpu_bo_list_create_raw(amdgpu_device_handle dev,
>>         >> +  uint32_t number_of_buffers,
>>         >> +                             struct
>>         drm_amdgpu_bo_list_entry *buffers,
>>         >> +  uint32_t *result);
>>         > So AFAIU  drm_amdgpu_bo_list_entry takes a raw bo handle
>>         while we
>>         > never get a raw bo handle from libdrm_amdgpu. How are we
>>         supposed to
>>         > fill it in?
>>         >
>>         > What do we win by having the raw handle for the bo_list? If
>>         we would
>>         > not return the raw handle we would not need the submit_raw2.
>>         >
>>         >> +
>>         >> +/**
>>         >> + * Destroys a BO list handle.
>>         >> + *
>>         >> + * \param   bo_list    - \c [in] BO list handle.
>>         >> + *
>>         >> + * \return   0 on success\n
>>         >> + *          <0 - Negative POSIX Error code
>>         >> + *
>>         >> + * \sa amdgpu_bo_list_create_raw(), amdgpu_cs_submit_raw2()
>>         >> +*/
>>         >> +int amdgpu_bo_list_destroy_raw(amdgpu_device_handle dev,
>>         uint32_t bo_list);
>>         >> +
>>         >>   /**
>>         >>    * Creates a BO list handle for command submission.
>>         >>    *
>>         >>    * \param   dev     - \c [in] Device handle.
>>         >>    * See #amdgpu_device_initialize()
>>         >>    * \param   number_of_resources     - \c [in] Number of
>>         BOs in the list
>>         >>    * \param   resources          - \c [in] List of BO handles
>>         >>    * \param   resource_prios     - \c [in] Optional
>>         priority for each handle
>>         >>    * \param   result             - \c [out] Created BO
>>         list handle
>>         >>    *
>>         >>    * \return   0 on success\n
>>         >>    *          <0 - Negative POSIX Error code
>>         >>    *
>>         >> - * \sa amdgpu_bo_list_destroy()
>>         >> + * \sa amdgpu_bo_list_destroy(), amdgpu_cs_submit_raw2()
>>         >>   */
>>         >>   int amdgpu_bo_list_create(amdgpu_device_handle dev,
>>         >>                            uint32_t number_of_resources,
>>         >> amdgpu_bo_handle *resources,
>>         >>                            uint8_t *resource_prios,
>>         >> amdgpu_bo_list_handle *result);
>>         >>
>>         >>   /**
>>         >>    * Destroys a BO list handle.
>>         >>    *
>>         >> @@ -1580,20 +1612,42 @@ struct drm_amdgpu_cs_chunk;
>>         >>   struct drm_amdgpu_cs_chunk_dep;
>>         >>   struct drm_amdgpu_cs_chunk_data;
>>         >>
>>         >>   int amdgpu_cs_submit_raw(amdgpu_device_handle dev,
>>         >>  amdgpu_context_handle context,
>>         >>  amdgpu_bo_list_handle bo_list_handle,
>>         >>                           int num_chunks,
>>         >>                           struct drm_amdgpu_cs_chunk *chunks,
>>         >>                           uint64_t *seq_no);
>>         >>
>>         >> +/**
>>         >> + * Submit raw command submission to the kernel with a raw
>>         BO list handle.
>>         >> + *
>>         >> + * \param   dev               - \c [in] device handle
>>         >> + * \param   context    - \c [in] context handle for
>>         context id
>>         >> + * \param   bo_list_handle - \c [in] raw bo list handle
>>         (0 for none)
>>         >> + * \param   num_chunks - \c [in] number of CS chunks to
>>         submit
>>         >> + * \param   chunks     - \c [in] array of CS chunks
>>         >> + * \param   seq_no     - \c [out] output sequence number
>>         for submission.
>>         >> + *
>>         >> + * \return   0 on success\n
>>         >> + *          <0 - Negative POSIX Error code
>>         >> + *
>>         >> + * \sa amdgpu_bo_list_create_raw(),
>>         amdgpu_bo_list_destroy_raw()
>>         >> + */
>>         >> +int amdgpu_cs_submit_raw2(amdgpu_device_handle dev,
>>         >> +  amdgpu_context_handle context,
>>         >> +                         uint32_t bo_list_handle,
>>         >> +                         int num_chunks,
>>         >> +                         struct drm_amdgpu_cs_chunk *chunks,
>>         >> +                         uint64_t *seq_no);
>>         >> +
>>         >>   void amdgpu_cs_chunk_fence_to_dep(struct amdgpu_cs_fence
>>         *fence,
>>         >> struct drm_amdgpu_cs_chunk_dep *dep);
>>         >>   void amdgpu_cs_chunk_fence_info_to_data(struct
>>         amdgpu_cs_fence_info *fence_info,
>>         >>     struct drm_amdgpu_cs_chunk_data *data);
>>         >>
>>         >>   /**
>>         >>    * Reserve VMID
>>         >>    * \param   context - \c [in]  GPU Context
>>         >>    * \param   flags - \c [in]  TBD
>>         >>    *
>>         >> diff --git a/amdgpu/amdgpu_bo.c b/amdgpu/amdgpu_bo.c
>>         >> index c0f42e81..21bc73aa 100644
>>         >> --- a/amdgpu/amdgpu_bo.c
>>         >> +++ b/amdgpu/amdgpu_bo.c
>>         >> @@ -611,20 +611,56 @@ drm_public int
>>         amdgpu_create_bo_from_user_mem(amdgpu_device_handle dev,
>>         >> pthread_mutex_lock(&dev->bo_table_mutex);
>>         >>          r = handle_table_insert(&dev->bo_handles,
>>         (*buf_handle)->handle,
>>         >> *buf_handle);
>>         >> pthread_mutex_unlock(&dev->bo_table_mutex);
>>         >>          if (r)
>>         >> amdgpu_bo_free(*buf_handle);
>>         >>   out:
>>         >>          return r;
>>         >>   }
>>         >>
>>         >> +drm_public int
>>         amdgpu_bo_list_create_raw(amdgpu_device_handle dev,
>>         >> +     uint32_t number_of_buffers,
>>         >> +     struct drm_amdgpu_bo_list_entry *buffers,
>>         >> +     uint32_t *result)
>>         >> +{
>>         >> +       union drm_amdgpu_bo_list args;
>>         >> +       int r;
>>         >> +
>>         >> +       memset(&args, 0, sizeof(args));
>>         >> +       args.in.operation = AMDGPU_BO_LIST_OP_CREATE;
>>         >> +       args.in.bo_number = number_of_buffers;
>>         >> +       args.in.bo_info_size = sizeof(struct
>>         drm_amdgpu_bo_list_entry);
>>         >> +       args.in.bo_info_ptr = (uint64_t)(uintptr_t)buffers;
>>         >> +
>>         >> +       r = drmCommandWriteRead(dev->fd, DRM_AMDGPU_BO_LIST,
>>         >> +  &args, sizeof(args));
>>         >> +       if (r)
>>         >> +               return r;
>>         >> +
>>         >> +       *result = args.out.list_handle;
>>         >> +       return 0;
>>         >> +}
>>         >> +
>>         >> +drm_public int
>>         amdgpu_bo_list_destroy_raw(amdgpu_device_handle dev,
>>         >> +      uint32_t bo_list)
>>         >> +{
>>         >> +       union drm_amdgpu_bo_list args;
>>         >> +
>>         >> +       memset(&args, 0, sizeof(args));
>>         >> +       args.in.operation = AMDGPU_BO_LIST_OP_DESTROY;
>>         >> +       args.in.list_handle = bo_list;
>>         >> +
>>         >> +       return drmCommandWriteRead(dev->fd,
>>         DRM_AMDGPU_BO_LIST,
>>         >> + &args, sizeof(args));
>>         >> +}
>>         >> +
>>         >>   drm_public int
>>         amdgpu_bo_list_create(amdgpu_device_handle dev,
>>         >>  uint32_t number_of_resources,
>>         >>  amdgpu_bo_handle *resources,
>>         >>  uint8_t *resource_prios,
>>         >>  amdgpu_bo_list_handle *result)
>>         >>   {
>>         >>          struct drm_amdgpu_bo_list_entry *list;
>>         >>          union drm_amdgpu_bo_list args;
>>         >>          unsigned i;
>>         >>          int r;
>>         >> diff --git a/amdgpu/amdgpu_cs.c b/amdgpu/amdgpu_cs.c
>>         >> index 3b8231aa..5bedf748 100644
>>         >> --- a/amdgpu/amdgpu_cs.c
>>         >> +++ b/amdgpu/amdgpu_cs.c
>>         >> @@ -724,20 +724,45 @@ drm_public int
>>         amdgpu_cs_submit_raw(amdgpu_device_handle dev,
>>         >>          r = drmCommandWriteRead(dev->fd, DRM_AMDGPU_CS,
>>         >> &cs, sizeof(cs));
>>         >>          if (r)
>>         >>                  return r;
>>         >>
>>         >>          if (seq_no)
>>         >>                  *seq_no = cs.out.handle;
>>         >>          return 0;
>>         >>   }
>>         >>
>>         >> +drm_public int amdgpu_cs_submit_raw2(amdgpu_device_handle
>>         dev,
>>         >> + amdgpu_context_handle context,
>>         >> + uint32_t bo_list_handle,
>>         >> + int num_chunks,
>>         >> + struct drm_amdgpu_cs_chunk *chunks,
>>         >> + uint64_t *seq_no)
>>         >> +{
>>         >> +       union drm_amdgpu_cs cs = {0};
>>         >> +       uint64_t *chunk_array;
>>         >> +       int i, r;
>>         >> +
>>         >> +       chunk_array = alloca(sizeof(uint64_t) * num_chunks);
>>         >> +       for (i = 0; i < num_chunks; i++)
>>         >> +               chunk_array[i] =
>>         (uint64_t)(uintptr_t)&chunks[i];
>>         >> +       cs.in.chunks = (uint64_t)(uintptr_t)chunk_array;
>>         >> +       cs.in.ctx_id = context->id;
>>         >> +       cs.in.bo_list_handle = bo_list_handle;
>>         >> +       cs.in.num_chunks = num_chunks;
>>         >> +       r = drmCommandWriteRead(dev->fd, DRM_AMDGPU_CS,
>>         >> +  &cs, sizeof(cs));
>>         >> +       if (!r && seq_no)
>>         >> +               *seq_no = cs.out.handle;
>>         >> +       return r;
>>         >> +}
>>         >> +
>>         >>   drm_public void
>>         amdgpu_cs_chunk_fence_info_to_data(struct
>>         amdgpu_cs_fence_info *fence_info,
>>         >>     struct drm_amdgpu_cs_chunk_data *data)
>>         >>   {
>>         >>          data->fence_data.handle = fence_info->handle->handle;
>>         >>          data->fence_data.offset = fence_info->offset *
>>         sizeof(uint64_t);
>>         >>   }
>>         >>
>>         >>   drm_public void amdgpu_cs_chunk_fence_to_dep(struct
>>         amdgpu_cs_fence *fence,
>>         >>     struct drm_amdgpu_cs_chunk_dep *dep)
>>         >>   {
>>         >> --
>>         >> 2.17.1
>>         >>
>>         >> _______________________________________________
>>         >> amd-gfx mailing list
>>         >> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
>>         <mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
>>         >> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>>         > _______________________________________________
>>         > amd-gfx mailing list
>>         > amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
>>         <mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
>>         > https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>>
>
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx


--------------7DB6E7F80146BE6904688AE2
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <div class="moz-cite-prefix">Am 16.01.19 um 15:39 schrieb Marek
      Olšák:<br>
    </div>
    <blockquote type="cite"
cite="mid:CAAxE2A4k8JtkrS2XfgRdmYY3NVR4ges=Yqfh-TH9O=LnaVv02g-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org">
      <meta http-equiv="content-type" content="text/html; charset=UTF-8">
      <div dir="auto">
        <div><br>
          <br>
          <div class="gmail_quote">
            <div dir="ltr">On Wed, Jan 16, 2019, 9:34 AM Koenig,
              Christian &lt;<a href="mailto:Christian.Koenig-5C7GfCeVMHo@public.gmane.org"
                moz-do-not-send="true">Christian.Koenig-5C7GfCeVMHo@public.gmane.org</a>
              wrote:<br>
            </div>
            <blockquote class="gmail_quote" style="margin:0 0 0
              .8ex;border-left:1px #ccc solid;padding-left:1ex">
              <div text="#000000" bgcolor="#FFFFFF">
                <div class="m_3799249069402976776moz-cite-prefix">Am
                  16.01.19 um 15:31 schrieb Marek Olšák:<br>
                </div>
                <blockquote type="cite">
                  <div dir="auto">
                    <div><br>
                      <br>
                      <div class="gmail_quote">
                        <div dir="ltr">On Wed, Jan 16, 2019, 7:55 AM
                          Christian König &lt;<a
                            href="mailto:ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org"
                            target="_blank" rel="noreferrer"
                            moz-do-not-send="true">ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>
                          wrote:<br>
                        </div>
                        <blockquote class="gmail_quote" style="margin:0
                          0 0 .8ex;border-left:1px #ccc
                          solid;padding-left:1ex">
                          Well if you ask me we should have the
                          following interface for <br>
                          negotiating memory management with the kernel:<br>
                          <br>
                          1. We have per process BOs which can't be
                          shared between processes.<br>
                          <br>
                          Those are always valid and don't need to be
                          mentioned in any BO list <br>
                          whatsoever.<br>
                          <br>
                          If we knew that a per process BO is currently
                          not in use we can <br>
                          optionally tell that to the kernel to make
                          memory management more efficient.<br>
                          <br>
                          In other words instead of a list of stuff
                          which is used we send down to <br>
                          the kernel a list of stuff which is not used
                          any more and that only when <br>
                          we know that it is necessary, e.g. when a game
                          or application overcommits.<br>
                        </blockquote>
                      </div>
                    </div>
                    <div dir="auto"><br>
                    </div>
                    <div dir="auto">Radeonsi doesn't use this because
                      this approach caused performance degradation and
                      also drops BO priorities.</div>
                  </div>
                </blockquote>
                <br>
                The performance degradation where mostly shortcomings
                with the LRU which by now have been fixed.<br>
                <br>
                BO priorities are a different topic, but could be added
                to per VM BOs as well.<br>
              </div>
            </blockquote>
          </div>
        </div>
        <div dir="auto"><br>
        </div>
        <div dir="auto">What's the minimum drm version that contains the
          fixes?</div>
      </div>
    </blockquote>
    <br>
    I've pushed the last optimization this morning. No idea when it
    really became useful, but the numbers from the closed source clients
    now look much better.<br>
    <br>
    We should probably test and bump the drm version when we are sure
    that this now works as expected.<br>
    <br>
    Christian.<br>
    <br>
    <blockquote type="cite"
cite="mid:CAAxE2A4k8JtkrS2XfgRdmYY3NVR4ges=Yqfh-TH9O=LnaVv02g-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org">
      <div dir="auto">
        <div dir="auto"><br>
        </div>
        <div dir="auto">Marek</div>
        <div dir="auto"><br>
        </div>
        <div dir="auto">
          <div class="gmail_quote">
            <blockquote class="gmail_quote" style="margin:0 0 0
              .8ex;border-left:1px #ccc solid;padding-left:1ex">
              <div text="#000000" bgcolor="#FFFFFF">
                <br>
                Christian.<br>
                <br>
                <blockquote type="cite">
                  <div dir="auto">
                    <div dir="auto"><br>
                    </div>
                    <div dir="auto">Marek</div>
                    <div dir="auto"><br>
                    </div>
                    <div dir="auto">
                      <div class="gmail_quote">
                        <blockquote class="gmail_quote" style="margin:0
                          0 0 .8ex;border-left:1px #ccc
                          solid;padding-left:1ex">
                          <br>
                          2. We have shared BOs which are used by more
                          than one process.<br>
                          <br>
                          Those are rare and should be added to the per
                          CS list of BOs in use.<br>
                          <br>
                          <br>
                          The whole BO list interface Marek tries to
                          optimize here should be <br>
                          deprecated and not used any more.<br>
                          <br>
                          Regards,<br>
                          Christian.<br>
                          <br>
                          Am 16.01.19 um 13:46 schrieb Bas
                          Nieuwenhuizen:<br>
                          &gt; So random questions:<br>
                          &gt;<br>
                          &gt; 1) In this discussion it was mentioned
                          that some Vulkan drivers still<br>
                          &gt; use the bo_list interface. I think that
                          implies radv as I think we're<br>
                          &gt; still using bo_list. Is there any other
                          API we should be using? (Also,<br>
                          &gt; with VK_EXT_descriptor_indexing I suspect
                          we'll be moving more towards<br>
                          &gt; a global bo list instead of a cmd buffer
                          one, as we cannot know all<br>
                          &gt; the BOs referenced anymore, but not sure
                          what end state here will be).<br>
                          &gt;<br>
                          &gt; 2) The other alternative mentioned was
                          adding the buffers directly<br>
                          &gt; into the submit ioctl. Is this the
                          desired end state (though as above<br>
                          &gt; I'm not sure how that works for vulkan)?
                          If yes, what is the timeline<br>
                          &gt; for this that we need something in the
                          interim?<br>
                          &gt;<br>
                          &gt; 3) Did we measure any performance
                          benefit?<br>
                          &gt;<br>
                          &gt; In general I'd like to to ack the raw bo
                          list creation function as<br>
                          &gt; this interface seems easier to use. The
                          two arrays thing has always<br>
                          &gt; been kind of a pain when we want to use
                          e.g. builtin sort functions to<br>
                          &gt; make sure we have no duplicate BOs, but
                          have some comments below.<br>
                          &gt;<br>
                          &gt; On Mon, Jan 7, 2019 at 8:31 PM Marek
                          Olšák &lt;<a href="mailto:maraeo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org"
                            rel="noreferrer noreferrer" target="_blank"
                            moz-do-not-send="true">maraeo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt;
                          wrote:<br>
                          &gt;&gt; From: Marek Olšák &lt;<a
                            href="mailto:marek.olsak-5C7GfCeVMHo@public.gmane.org"
                            rel="noreferrer noreferrer" target="_blank"
                            moz-do-not-send="true">marek.olsak-5C7GfCeVMHo@public.gmane.org</a>&gt;<br>
                          &gt;&gt;<br>
                          &gt;&gt; ---<br>
                          &gt;&gt;   amdgpu/amdgpu-symbol-check |  3 ++<br>
                          &gt;&gt;   amdgpu/amdgpu.h            | 56
                          +++++++++++++++++++++++++++++++++++++-<br>
                          &gt;&gt;   amdgpu/amdgpu_bo.c         | 36
                          ++++++++++++++++++++++++<br>
                          &gt;&gt;   amdgpu/amdgpu_cs.c         | 25
                          +++++++++++++++++<br>
                          &gt;&gt;   4 files changed, 119 insertions(+),
                          1 deletion(-)<br>
                          &gt;&gt;<br>
                          &gt;&gt; diff --git
                          a/amdgpu/amdgpu-symbol-check
                          b/amdgpu/amdgpu-symbol-check<br>
                          &gt;&gt; index 6f5e0f95..96a44b40 100755<br>
                          &gt;&gt; --- a/amdgpu/amdgpu-symbol-check<br>
                          &gt;&gt; +++ b/amdgpu/amdgpu-symbol-check<br>
                          &gt;&gt; @@ -12,20 +12,22 @@ _edata<br>
                          &gt;&gt;   _end<br>
                          &gt;&gt;   _fini<br>
                          &gt;&gt;   _init<br>
                          &gt;&gt;   amdgpu_bo_alloc<br>
                          &gt;&gt;   amdgpu_bo_cpu_map<br>
                          &gt;&gt;   amdgpu_bo_cpu_unmap<br>
                          &gt;&gt;   amdgpu_bo_export<br>
                          &gt;&gt;   amdgpu_bo_free<br>
                          &gt;&gt;   amdgpu_bo_import<br>
                          &gt;&gt;   amdgpu_bo_inc_ref<br>
                          &gt;&gt; +amdgpu_bo_list_create_raw<br>
                          &gt;&gt; +amdgpu_bo_list_destroy_raw<br>
                          &gt;&gt;   amdgpu_bo_list_create<br>
                          &gt;&gt;   amdgpu_bo_list_destroy<br>
                          &gt;&gt;   amdgpu_bo_list_update<br>
                          &gt;&gt;   amdgpu_bo_query_info<br>
                          &gt;&gt;   amdgpu_bo_set_metadata<br>
                          &gt;&gt;   amdgpu_bo_va_op<br>
                          &gt;&gt;   amdgpu_bo_va_op_raw<br>
                          &gt;&gt;   amdgpu_bo_wait_for_idle<br>
                          &gt;&gt;   amdgpu_create_bo_from_user_mem<br>
                          &gt;&gt;   amdgpu_cs_chunk_fence_info_to_data<br>
                          &gt;&gt; @@ -40,20 +42,21 @@
                          amdgpu_cs_destroy_semaphore<br>
                          &gt;&gt;   amdgpu_cs_destroy_syncobj<br>
                          &gt;&gt;   amdgpu_cs_export_syncobj<br>
                          &gt;&gt;   amdgpu_cs_fence_to_handle<br>
                          &gt;&gt;   amdgpu_cs_import_syncobj<br>
                          &gt;&gt;   amdgpu_cs_query_fence_status<br>
                          &gt;&gt;   amdgpu_cs_query_reset_state<br>
                          &gt;&gt;   amdgpu_query_sw_info<br>
                          &gt;&gt;   amdgpu_cs_signal_semaphore<br>
                          &gt;&gt;   amdgpu_cs_submit<br>
                          &gt;&gt;   amdgpu_cs_submit_raw<br>
                          &gt;&gt; +amdgpu_cs_submit_raw2<br>
                          &gt;&gt;   amdgpu_cs_syncobj_export_sync_file<br>
                          &gt;&gt;   amdgpu_cs_syncobj_import_sync_file<br>
                          &gt;&gt;   amdgpu_cs_syncobj_reset<br>
                          &gt;&gt;   amdgpu_cs_syncobj_signal<br>
                          &gt;&gt;   amdgpu_cs_syncobj_wait<br>
                          &gt;&gt;   amdgpu_cs_wait_fences<br>
                          &gt;&gt;   amdgpu_cs_wait_semaphore<br>
                          &gt;&gt;   amdgpu_device_deinitialize<br>
                          &gt;&gt;   amdgpu_device_initialize<br>
                          &gt;&gt;   amdgpu_find_bo_by_cpu_mapping<br>
                          &gt;&gt; diff --git a/amdgpu/amdgpu.h
                          b/amdgpu/amdgpu.h<br>
                          &gt;&gt; index dc51659a..5b800033 100644<br>
                          &gt;&gt; --- a/amdgpu/amdgpu.h<br>
                          &gt;&gt; +++ b/amdgpu/amdgpu.h<br>
                          &gt;&gt; @@ -35,20 +35,21 @@<br>
                          &gt;&gt;   #define _AMDGPU_H_<br>
                          &gt;&gt;<br>
                          &gt;&gt;   #include &lt;stdint.h&gt;<br>
                          &gt;&gt;   #include &lt;stdbool.h&gt;<br>
                          &gt;&gt;<br>
                          &gt;&gt;   #ifdef __cplusplus<br>
                          &gt;&gt;   extern "C" {<br>
                          &gt;&gt;   #endif<br>
                          &gt;&gt;<br>
                          &gt;&gt;   struct drm_amdgpu_info_hw_ip;<br>
                          &gt;&gt; +struct drm_amdgpu_bo_list_entry;<br>
                          &gt;&gt;<br>
                          &gt;&gt; 
 /*--------------------------------------------------------------------------*/<br>
                          &gt;&gt;   /* ---------------------------
                          Defines ------------------------------------
                          */<br>
                          &gt;&gt; 
 /*--------------------------------------------------------------------------*/<br>
                          &gt;&gt;<br>
                          &gt;&gt;   /**<br>
                          &gt;&gt;    * Define max. number of Command
                          Buffers (IB) which could be sent to the single<br>
                          &gt;&gt;    * hardware IP to accommodate CE/DE
                          requirements<br>
                          &gt;&gt;    *<br>
                          &gt;&gt;    * \sa amdgpu_cs_ib_info<br>
                          &gt;&gt; @@ -767,34 +768,65 @@ int
                          amdgpu_bo_cpu_unmap(amdgpu_bo_handle
                          buf_handle);<br>
                          &gt;&gt;    *                            and
                          no GPU access is scheduled.<br>
                          &gt;&gt;    *                          1 GPU
                          access is in fly or scheduled<br>
                          &gt;&gt;    *<br>
                          &gt;&gt;    * \return   0 - on success<br>
                          &gt;&gt;    *          &lt;0 - Negative POSIX
                          Error code<br>
                          &gt;&gt;    */<br>
                          &gt;&gt;   int
                          amdgpu_bo_wait_for_idle(amdgpu_bo_handle
                          buf_handle,<br>
                          &gt;&gt;                              uint64_t
                          timeout_ns,<br>
                          &gt;&gt;                              bool
                          *buffer_busy);<br>
                          &gt;&gt;<br>
                          &gt;&gt; +/**<br>
                          &gt;&gt; + * Creates a BO list handle for
                          command submission.<br>
                          &gt;&gt; + *<br>
                          &gt;&gt; + * \param   dev                     
                            - \c [in] Device handle.<br>
                          &gt;&gt; + *                               
                          See #amdgpu_device_initialize()<br>
                          &gt;&gt; + * \param   number_of_buffers  - \c
                          [in] Number of BOs in the list<br>
                          &gt;&gt; + * \param   buffers            - \c
                          [in] List of BO handles<br>
                          &gt;&gt; + * \param   result             - \c
                          [out] Created BO list handle<br>
                          &gt;&gt; + *<br>
                          &gt;&gt; + * \return   0 on success\n<br>
                          &gt;&gt; + *          &lt;0 - Negative POSIX
                          Error code<br>
                          &gt;&gt; + *<br>
                          &gt;&gt; + * \sa amdgpu_bo_list_destroy_raw()<br>
                          &gt;&gt; +*/<br>
                          &gt;&gt; +int
                          amdgpu_bo_list_create_raw(amdgpu_device_handle
                          dev,<br>
                          &gt;&gt; +                           
                           uint32_t number_of_buffers,<br>
                          &gt;&gt; +                             struct
                          drm_amdgpu_bo_list_entry *buffers,<br>
                          &gt;&gt; +                           
                           uint32_t *result);<br>
                          &gt; So AFAIU  drm_amdgpu_bo_list_entry takes
                          a raw bo handle while we<br>
                          &gt; never get a raw bo handle from
                          libdrm_amdgpu. How are we supposed to<br>
                          &gt; fill it in?<br>
                          &gt;<br>
                          &gt; What do we win by having the raw handle
                          for the bo_list? If we would<br>
                          &gt; not return the raw handle we would not
                          need the submit_raw2.<br>
                          &gt;<br>
                          &gt;&gt; +<br>
                          &gt;&gt; +/**<br>
                          &gt;&gt; + * Destroys a BO list handle.<br>
                          &gt;&gt; + *<br>
                          &gt;&gt; + * \param   bo_list    - \c [in] BO
                          list handle.<br>
                          &gt;&gt; + *<br>
                          &gt;&gt; + * \return   0 on success\n<br>
                          &gt;&gt; + *          &lt;0 - Negative POSIX
                          Error code<br>
                          &gt;&gt; + *<br>
                          &gt;&gt; + * \sa amdgpu_bo_list_create_raw(),
                          amdgpu_cs_submit_raw2()<br>
                          &gt;&gt; +*/<br>
                          &gt;&gt; +int
                          amdgpu_bo_list_destroy_raw(amdgpu_device_handle
                          dev, uint32_t bo_list);<br>
                          &gt;&gt; +<br>
                          &gt;&gt;   /**<br>
                          &gt;&gt;    * Creates a BO list handle for
                          command submission.<br>
                          &gt;&gt;    *<br>
                          &gt;&gt;    * \param   dev                   
                              - \c [in] Device handle.<br>
                          &gt;&gt;    *                               
                          See #amdgpu_device_initialize()<br>
                          &gt;&gt;    * \param   number_of_resources   
                              - \c [in] Number of BOs in the list<br>
                          &gt;&gt;    * \param   resources          - \c
                          [in] List of BO handles<br>
                          &gt;&gt;    * \param   resource_prios     - \c
                          [in] Optional priority for each handle<br>
                          &gt;&gt;    * \param   result             - \c
                          [out] Created BO list handle<br>
                          &gt;&gt;    *<br>
                          &gt;&gt;    * \return   0 on success\n<br>
                          &gt;&gt;    *          &lt;0 - Negative POSIX
                          Error code<br>
                          &gt;&gt;    *<br>
                          &gt;&gt; - * \sa amdgpu_bo_list_destroy()<br>
                          &gt;&gt; + * \sa amdgpu_bo_list_destroy(),
                          amdgpu_cs_submit_raw2()<br>
                          &gt;&gt;   */<br>
                          &gt;&gt;   int
                          amdgpu_bo_list_create(amdgpu_device_handle
                          dev,<br>
                          &gt;&gt;                            uint32_t
                          number_of_resources,<br>
                          &gt;&gt;                           
                          amdgpu_bo_handle *resources,<br>
                          &gt;&gt;                            uint8_t
                          *resource_prios,<br>
                          &gt;&gt;                           
                          amdgpu_bo_list_handle *result);<br>
                          &gt;&gt;<br>
                          &gt;&gt;   /**<br>
                          &gt;&gt;    * Destroys a BO list handle.<br>
                          &gt;&gt;    *<br>
                          &gt;&gt; @@ -1580,20 +1612,42 @@ struct
                          drm_amdgpu_cs_chunk;<br>
                          &gt;&gt;   struct drm_amdgpu_cs_chunk_dep;<br>
                          &gt;&gt;   struct drm_amdgpu_cs_chunk_data;<br>
                          &gt;&gt;<br>
                          &gt;&gt;   int
                          amdgpu_cs_submit_raw(amdgpu_device_handle dev,<br>
                          &gt;&gt;                         
                           amdgpu_context_handle context,<br>
                          &gt;&gt;                         
                           amdgpu_bo_list_handle bo_list_handle,<br>
                          &gt;&gt;                           int
                          num_chunks,<br>
                          &gt;&gt;                           struct
                          drm_amdgpu_cs_chunk *chunks,<br>
                          &gt;&gt;                           uint64_t
                          *seq_no);<br>
                          &gt;&gt;<br>
                          &gt;&gt; +/**<br>
                          &gt;&gt; + * Submit raw command submission to
                          the kernel with a raw BO list handle.<br>
                          &gt;&gt; + *<br>
                          &gt;&gt; + * \param   dev               - \c
                          [in] device handle<br>
                          &gt;&gt; + * \param   context    - \c [in]
                          context handle for context id<br>
                          &gt;&gt; + * \param   bo_list_handle - \c [in]
                          raw bo list handle (0 for none)<br>
                          &gt;&gt; + * \param   num_chunks - \c [in]
                          number of CS chunks to submit<br>
                          &gt;&gt; + * \param   chunks     - \c [in]
                          array of CS chunks<br>
                          &gt;&gt; + * \param   seq_no     - \c [out]
                          output sequence number for submission.<br>
                          &gt;&gt; + *<br>
                          &gt;&gt; + * \return   0 on success\n<br>
                          &gt;&gt; + *          &lt;0 - Negative POSIX
                          Error code<br>
                          &gt;&gt; + *<br>
                          &gt;&gt; + * \sa amdgpu_bo_list_create_raw(),
                          amdgpu_bo_list_destroy_raw()<br>
                          &gt;&gt; + */<br>
                          &gt;&gt; +int
                          amdgpu_cs_submit_raw2(amdgpu_device_handle
                          dev,<br>
                          &gt;&gt; +                       
                           amdgpu_context_handle context,<br>
                          &gt;&gt; +                         uint32_t
                          bo_list_handle,<br>
                          &gt;&gt; +                         int
                          num_chunks,<br>
                          &gt;&gt; +                         struct
                          drm_amdgpu_cs_chunk *chunks,<br>
                          &gt;&gt; +                         uint64_t
                          *seq_no);<br>
                          &gt;&gt; +<br>
                          &gt;&gt;   void
                          amdgpu_cs_chunk_fence_to_dep(struct
                          amdgpu_cs_fence *fence,<br>
                          &gt;&gt;                                   
                          struct drm_amdgpu_cs_chunk_dep *dep);<br>
                          &gt;&gt;   void
                          amdgpu_cs_chunk_fence_info_to_data(struct
                          amdgpu_cs_fence_info *fence_info,<br>
                          &gt;&gt;                                     
                              struct drm_amdgpu_cs_chunk_data *data);<br>
                          &gt;&gt;<br>
                          &gt;&gt;   /**<br>
                          &gt;&gt;    * Reserve VMID<br>
                          &gt;&gt;    * \param   context - \c [in]  GPU
                          Context<br>
                          &gt;&gt;    * \param   flags - \c [in]  TBD<br>
                          &gt;&gt;    *<br>
                          &gt;&gt; diff --git a/amdgpu/amdgpu_bo.c
                          b/amdgpu/amdgpu_bo.c<br>
                          &gt;&gt; index c0f42e81..21bc73aa 100644<br>
                          &gt;&gt; --- a/amdgpu/amdgpu_bo.c<br>
                          &gt;&gt; +++ b/amdgpu/amdgpu_bo.c<br>
                          &gt;&gt; @@ -611,20 +611,56 @@ drm_public int
amdgpu_create_bo_from_user_mem(amdgpu_device_handle dev,<br>
                          &gt;&gt;         
                          pthread_mutex_lock(&amp;dev-&gt;bo_table_mutex);<br>
                          &gt;&gt;          r =
                          handle_table_insert(&amp;dev-&gt;bo_handles,
                          (*buf_handle)-&gt;handle,<br>
                          &gt;&gt;                                 
                          *buf_handle);<br>
                          &gt;&gt;         
                          pthread_mutex_unlock(&amp;dev-&gt;bo_table_mutex);<br>
                          &gt;&gt;          if (r)<br>
                          &gt;&gt;                 
                          amdgpu_bo_free(*buf_handle);<br>
                          &gt;&gt;   out:<br>
                          &gt;&gt;          return r;<br>
                          &gt;&gt;   }<br>
                          &gt;&gt;<br>
                          &gt;&gt; +drm_public int
                          amdgpu_bo_list_create_raw(amdgpu_device_handle
                          dev,<br>
                          &gt;&gt; +                                   
                              uint32_t number_of_buffers,<br>
                          &gt;&gt; +                                   
                              struct drm_amdgpu_bo_list_entry *buffers,<br>
                          &gt;&gt; +                                   
                              uint32_t *result)<br>
                          &gt;&gt; +{<br>
                          &gt;&gt; +       union drm_amdgpu_bo_list
                          args;<br>
                          &gt;&gt; +       int r;<br>
                          &gt;&gt; +<br>
                          &gt;&gt; +       memset(&amp;args, 0,
                          sizeof(args));<br>
                          &gt;&gt; +       args.in.operation =
                          AMDGPU_BO_LIST_OP_CREATE;<br>
                          &gt;&gt; +       args.in.bo_number =
                          number_of_buffers;<br>
                          &gt;&gt; +       args.in.bo_info_size =
                          sizeof(struct drm_amdgpu_bo_list_entry);<br>
                          &gt;&gt; +       args.in.bo_info_ptr =
                          (uint64_t)(uintptr_t)buffers;<br>
                          &gt;&gt; +<br>
                          &gt;&gt; +       r =
                          drmCommandWriteRead(dev-&gt;fd,
                          DRM_AMDGPU_BO_LIST,<br>
                          &gt;&gt; +                             
                           &amp;args, sizeof(args));<br>
                          &gt;&gt; +       if (r)<br>
                          &gt;&gt; +               return r;<br>
                          &gt;&gt; +<br>
                          &gt;&gt; +       *result =
                          args.out.list_handle;<br>
                          &gt;&gt; +       return 0;<br>
                          &gt;&gt; +}<br>
                          &gt;&gt; +<br>
                          &gt;&gt; +drm_public int
                          amdgpu_bo_list_destroy_raw(amdgpu_device_handle
                          dev,<br>
                          &gt;&gt; +                                   
                               uint32_t bo_list)<br>
                          &gt;&gt; +{<br>
                          &gt;&gt; +       union drm_amdgpu_bo_list
                          args;<br>
                          &gt;&gt; +<br>
                          &gt;&gt; +       memset(&amp;args, 0,
                          sizeof(args));<br>
                          &gt;&gt; +       args.in.operation =
                          AMDGPU_BO_LIST_OP_DESTROY;<br>
                          &gt;&gt; +       args.in.list_handle =
                          bo_list;<br>
                          &gt;&gt; +<br>
                          &gt;&gt; +       return
                          drmCommandWriteRead(dev-&gt;fd,
                          DRM_AMDGPU_BO_LIST,<br>
                          &gt;&gt; +                                 
                          &amp;args, sizeof(args));<br>
                          &gt;&gt; +}<br>
                          &gt;&gt; +<br>
                          &gt;&gt;   drm_public int
                          amdgpu_bo_list_create(amdgpu_device_handle
                          dev,<br>
                          &gt;&gt;                                     
                           uint32_t number_of_resources,<br>
                          &gt;&gt;                                     
                           amdgpu_bo_handle *resources,<br>
                          &gt;&gt;                                     
                           uint8_t *resource_prios,<br>
                          &gt;&gt;                                     
                           amdgpu_bo_list_handle *result)<br>
                          &gt;&gt;   {<br>
                          &gt;&gt;          struct
                          drm_amdgpu_bo_list_entry *list;<br>
                          &gt;&gt;          union drm_amdgpu_bo_list
                          args;<br>
                          &gt;&gt;          unsigned i;<br>
                          &gt;&gt;          int r;<br>
                          &gt;&gt; diff --git a/amdgpu/amdgpu_cs.c
                          b/amdgpu/amdgpu_cs.c<br>
                          &gt;&gt; index 3b8231aa..5bedf748 100644<br>
                          &gt;&gt; --- a/amdgpu/amdgpu_cs.c<br>
                          &gt;&gt; +++ b/amdgpu/amdgpu_cs.c<br>
                          &gt;&gt; @@ -724,20 +724,45 @@ drm_public int
                          amdgpu_cs_submit_raw(amdgpu_device_handle dev,<br>
                          &gt;&gt;          r =
                          drmCommandWriteRead(dev-&gt;fd, DRM_AMDGPU_CS,<br>
                          &gt;&gt;                                 
                          &amp;cs, sizeof(cs));<br>
                          &gt;&gt;          if (r)<br>
                          &gt;&gt;                  return r;<br>
                          &gt;&gt;<br>
                          &gt;&gt;          if (seq_no)<br>
                          &gt;&gt;                  *seq_no =
                          cs.out.handle;<br>
                          &gt;&gt;          return 0;<br>
                          &gt;&gt;   }<br>
                          &gt;&gt;<br>
                          &gt;&gt; +drm_public int
                          amdgpu_cs_submit_raw2(amdgpu_device_handle
                          dev,<br>
                          &gt;&gt; +                                   
                          amdgpu_context_handle context,<br>
                          &gt;&gt; +                                   
                          uint32_t bo_list_handle,<br>
                          &gt;&gt; +                                   
                          int num_chunks,<br>
                          &gt;&gt; +                                   
                          struct drm_amdgpu_cs_chunk *chunks,<br>
                          &gt;&gt; +                                   
                          uint64_t *seq_no)<br>
                          &gt;&gt; +{<br>
                          &gt;&gt; +       union drm_amdgpu_cs cs = {0};<br>
                          &gt;&gt; +       uint64_t *chunk_array;<br>
                          &gt;&gt; +       int i, r;<br>
                          &gt;&gt; +<br>
                          &gt;&gt; +       chunk_array =
                          alloca(sizeof(uint64_t) * num_chunks);<br>
                          &gt;&gt; +       for (i = 0; i &lt;
                          num_chunks; i++)<br>
                          &gt;&gt; +               chunk_array[i] =
                          (uint64_t)(uintptr_t)&amp;chunks[i];<br>
                          &gt;&gt; +       cs.in.chunks =
                          (uint64_t)(uintptr_t)chunk_array;<br>
                          &gt;&gt; +       cs.in.ctx_id =
                          context-&gt;id;<br>
                          &gt;&gt; +       cs.in.bo_list_handle =
                          bo_list_handle;<br>
                          &gt;&gt; +       cs.in.num_chunks =
                          num_chunks;<br>
                          &gt;&gt; +       r =
                          drmCommandWriteRead(dev-&gt;fd, DRM_AMDGPU_CS,<br>
                          &gt;&gt; +                             
                           &amp;cs, sizeof(cs));<br>
                          &gt;&gt; +       if (!r &amp;&amp; seq_no)<br>
                          &gt;&gt; +               *seq_no =
                          cs.out.handle;<br>
                          &gt;&gt; +       return r;<br>
                          &gt;&gt; +}<br>
                          &gt;&gt; +<br>
                          &gt;&gt;   drm_public void
                          amdgpu_cs_chunk_fence_info_to_data(struct
                          amdgpu_cs_fence_info *fence_info,<br>
                          &gt;&gt;                                     
                              struct drm_amdgpu_cs_chunk_data *data)<br>
                          &gt;&gt;   {<br>
                          &gt;&gt;          data-&gt;fence_data.handle =
                          fence_info-&gt;handle-&gt;handle;<br>
                          &gt;&gt;          data-&gt;fence_data.offset =
                          fence_info-&gt;offset * sizeof(uint64_t);<br>
                          &gt;&gt;   }<br>
                          &gt;&gt;<br>
                          &gt;&gt;   drm_public void
                          amdgpu_cs_chunk_fence_to_dep(struct
                          amdgpu_cs_fence *fence,<br>
                          &gt;&gt;                                     
                              struct drm_amdgpu_cs_chunk_dep *dep)<br>
                          &gt;&gt;   {<br>
                          &gt;&gt; --<br>
                          &gt;&gt; 2.17.1<br>
                          &gt;&gt;<br>
                          &gt;&gt;
                          _______________________________________________<br>
                          &gt;&gt; amd-gfx mailing list<br>
                          &gt;&gt; <a
                            href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org"
                            rel="noreferrer noreferrer" target="_blank"
                            moz-do-not-send="true">
                            amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
                          &gt;&gt; <a
                            href="https://lists.freedesktop.org/mailman/listinfo/amd-gfx"
                            rel="noreferrer noreferrer noreferrer"
                            target="_blank" moz-do-not-send="true">
https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a><br>
                          &gt;
                          _______________________________________________<br>
                          &gt; amd-gfx mailing list<br>
                          &gt; <a
                            href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org"
                            rel="noreferrer noreferrer" target="_blank"
                            moz-do-not-send="true">
                            amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
                          &gt; <a
                            href="https://lists.freedesktop.org/mailman/listinfo/amd-gfx"
                            rel="noreferrer noreferrer noreferrer"
                            target="_blank" moz-do-not-send="true">
https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a><br>
                          <br>
                        </blockquote>
                      </div>
                    </div>
                  </div>
                </blockquote>
                <br>
              </div>
            </blockquote>
          </div>
        </div>
      </div>
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

--------------7DB6E7F80146BE6904688AE2--

--===============1910847877==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1910847877==--
