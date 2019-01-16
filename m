From: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH libdrm] amdgpu: add a faster BO list API
Date: Wed, 16 Jan 2019 09:39:34 -0500
Message-ID: <CAAxE2A4k8JtkrS2XfgRdmYY3NVR4ges=Yqfh-TH9O=LnaVv02g@mail.gmail.com>
References: <20190107193104.4361-1-maraeo@gmail.com>
 <CAP+8YyFD+LxEQOLOY+mDC5v3OOyh1De2DcXK0sRtMW0t7z20SQ@mail.gmail.com>
 <74054b1e-5211-3bfc-ab0f-27e8604759d1@gmail.com>
 <CAAxE2A5ywFkNMtPbesU_kuSwKCmsPJ0D8wRFuSp14mpORcwYhg@mail.gmail.com>
 <a550562a-7d36-9acf-3143-217c507e667a@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0917280486=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <a550562a-7d36-9acf-3143-217c507e667a-5C7GfCeVMHo@public.gmane.org>
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
To: "Koenig, Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>
Cc: amd-gfx mailing list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, Bas Nieuwenhuizen <bas-dldO88ZXqoXqqjsSq9zF6IRWq/SkRNHw@public.gmane.org>

--===============0917280486==
Content-Type: multipart/alternative; boundary="000000000000de2ae8057f943fe7"

--000000000000de2ae8057f943fe7
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 16, 2019, 9:34 AM Koenig, Christian <Christian.Koenig-5C7GfCeVMHo@public.gmane.org
wrote:

> Am 16.01.19 um 15:31 schrieb Marek Ol=C5=A1=C3=A1k:
>
>
>
> On Wed, Jan 16, 2019, 7:55 AM Christian K=C3=B6nig <
> ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org wrote:
>
>> Well if you ask me we should have the following interface for
>> negotiating memory management with the kernel:
>>
>> 1. We have per process BOs which can't be shared between processes.
>>
>> Those are always valid and don't need to be mentioned in any BO list
>> whatsoever.
>>
>> If we knew that a per process BO is currently not in use we can
>> optionally tell that to the kernel to make memory management more
>> efficient.
>>
>> In other words instead of a list of stuff which is used we send down to
>> the kernel a list of stuff which is not used any more and that only when
>> we know that it is necessary, e.g. when a game or application overcommit=
s.
>>
>
> Radeonsi doesn't use this because this approach caused performance
> degradation and also drops BO priorities.
>
>
> The performance degradation where mostly shortcomings with the LRU which
> by now have been fixed.
>
> BO priorities are a different topic, but could be added to per VM BOs as
> well.
>

What's the minimum drm version that contains the fixes?

Marek


> Christian.
>
>
> Marek
>
>
>> 2. We have shared BOs which are used by more than one process.
>>
>> Those are rare and should be added to the per CS list of BOs in use.
>>
>>
>> The whole BO list interface Marek tries to optimize here should be
>> deprecated and not used any more.
>>
>> Regards,
>> Christian.
>>
>> Am 16.01.19 um 13:46 schrieb Bas Nieuwenhuizen:
>> > So random questions:
>> >
>> > 1) In this discussion it was mentioned that some Vulkan drivers still
>> > use the bo_list interface. I think that implies radv as I think we're
>> > still using bo_list. Is there any other API we should be using? (Also,
>> > with VK_EXT_descriptor_indexing I suspect we'll be moving more towards
>> > a global bo list instead of a cmd buffer one, as we cannot know all
>> > the BOs referenced anymore, but not sure what end state here will be).
>> >
>> > 2) The other alternative mentioned was adding the buffers directly
>> > into the submit ioctl. Is this the desired end state (though as above
>> > I'm not sure how that works for vulkan)? If yes, what is the timeline
>> > for this that we need something in the interim?
>> >
>> > 3) Did we measure any performance benefit?
>> >
>> > In general I'd like to to ack the raw bo list creation function as
>> > this interface seems easier to use. The two arrays thing has always
>> > been kind of a pain when we want to use e.g. builtin sort functions to
>> > make sure we have no duplicate BOs, but have some comments below.
>> >
>> > On Mon, Jan 7, 2019 at 8:31 PM Marek Ol=C5=A1=C3=A1k <maraeo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org=
> wrote:
>> >> From: Marek Ol=C5=A1=C3=A1k <marek.olsak-5C7GfCeVMHo@public.gmane.org>
>> >>
>> >> ---
>> >>   amdgpu/amdgpu-symbol-check |  3 ++
>> >>   amdgpu/amdgpu.h            | 56
>> +++++++++++++++++++++++++++++++++++++-
>> >>   amdgpu/amdgpu_bo.c         | 36 ++++++++++++++++++++++++
>> >>   amdgpu/amdgpu_cs.c         | 25 +++++++++++++++++
>> >>   4 files changed, 119 insertions(+), 1 deletion(-)
>> >>
>> >> diff --git a/amdgpu/amdgpu-symbol-check b/amdgpu/amdgpu-symbol-check
>> >> index 6f5e0f95..96a44b40 100755
>> >> --- a/amdgpu/amdgpu-symbol-check
>> >> +++ b/amdgpu/amdgpu-symbol-check
>> >> @@ -12,20 +12,22 @@ _edata
>> >>   _end
>> >>   _fini
>> >>   _init
>> >>   amdgpu_bo_alloc
>> >>   amdgpu_bo_cpu_map
>> >>   amdgpu_bo_cpu_unmap
>> >>   amdgpu_bo_export
>> >>   amdgpu_bo_free
>> >>   amdgpu_bo_import
>> >>   amdgpu_bo_inc_ref
>> >> +amdgpu_bo_list_create_raw
>> >> +amdgpu_bo_list_destroy_raw
>> >>   amdgpu_bo_list_create
>> >>   amdgpu_bo_list_destroy
>> >>   amdgpu_bo_list_update
>> >>   amdgpu_bo_query_info
>> >>   amdgpu_bo_set_metadata
>> >>   amdgpu_bo_va_op
>> >>   amdgpu_bo_va_op_raw
>> >>   amdgpu_bo_wait_for_idle
>> >>   amdgpu_create_bo_from_user_mem
>> >>   amdgpu_cs_chunk_fence_info_to_data
>> >> @@ -40,20 +42,21 @@ amdgpu_cs_destroy_semaphore
>> >>   amdgpu_cs_destroy_syncobj
>> >>   amdgpu_cs_export_syncobj
>> >>   amdgpu_cs_fence_to_handle
>> >>   amdgpu_cs_import_syncobj
>> >>   amdgpu_cs_query_fence_status
>> >>   amdgpu_cs_query_reset_state
>> >>   amdgpu_query_sw_info
>> >>   amdgpu_cs_signal_semaphore
>> >>   amdgpu_cs_submit
>> >>   amdgpu_cs_submit_raw
>> >> +amdgpu_cs_submit_raw2
>> >>   amdgpu_cs_syncobj_export_sync_file
>> >>   amdgpu_cs_syncobj_import_sync_file
>> >>   amdgpu_cs_syncobj_reset
>> >>   amdgpu_cs_syncobj_signal
>> >>   amdgpu_cs_syncobj_wait
>> >>   amdgpu_cs_wait_fences
>> >>   amdgpu_cs_wait_semaphore
>> >>   amdgpu_device_deinitialize
>> >>   amdgpu_device_initialize
>> >>   amdgpu_find_bo_by_cpu_mapping
>> >> diff --git a/amdgpu/amdgpu.h b/amdgpu/amdgpu.h
>> >> index dc51659a..5b800033 100644
>> >> --- a/amdgpu/amdgpu.h
>> >> +++ b/amdgpu/amdgpu.h
>> >> @@ -35,20 +35,21 @@
>> >>   #define _AMDGPU_H_
>> >>
>> >>   #include <stdint.h>
>> >>   #include <stdbool.h>
>> >>
>> >>   #ifdef __cplusplus
>> >>   extern "C" {
>> >>   #endif
>> >>
>> >>   struct drm_amdgpu_info_hw_ip;
>> >> +struct drm_amdgpu_bo_list_entry;
>> >>
>> >>
>>  /*---------------------------------------------------------------------=
-----*/
>> >>   /* --------------------------- Defines
>> ------------------------------------ */
>> >>
>>  /*---------------------------------------------------------------------=
-----*/
>> >>
>> >>   /**
>> >>    * Define max. number of Command Buffers (IB) which could be sent t=
o
>> the single
>> >>    * hardware IP to accommodate CE/DE requirements
>> >>    *
>> >>    * \sa amdgpu_cs_ib_info
>> >> @@ -767,34 +768,65 @@ int amdgpu_bo_cpu_unmap(amdgpu_bo_handle
>> buf_handle);
>> >>    *                            and no GPU access is scheduled.
>> >>    *                          1 GPU access is in fly or scheduled
>> >>    *
>> >>    * \return   0 - on success
>> >>    *          <0 - Negative POSIX Error code
>> >>    */
>> >>   int amdgpu_bo_wait_for_idle(amdgpu_bo_handle buf_handle,
>> >>                              uint64_t timeout_ns,
>> >>                              bool *buffer_busy);
>> >>
>> >> +/**
>> >> + * Creates a BO list handle for command submission.
>> >> + *
>> >> + * \param   dev                        - \c [in] Device handle.
>> >> + *                                See #amdgpu_device_initialize()
>> >> + * \param   number_of_buffers  - \c [in] Number of BOs in the list
>> >> + * \param   buffers            - \c [in] List of BO handles
>> >> + * \param   result             - \c [out] Created BO list handle
>> >> + *
>> >> + * \return   0 on success\n
>> >> + *          <0 - Negative POSIX Error code
>> >> + *
>> >> + * \sa amdgpu_bo_list_destroy_raw()
>> >> +*/
>> >> +int amdgpu_bo_list_create_raw(amdgpu_device_handle dev,
>> >> +                             uint32_t number_of_buffers,
>> >> +                             struct drm_amdgpu_bo_list_entry *buffer=
s,
>> >> +                             uint32_t *result);
>> > So AFAIU  drm_amdgpu_bo_list_entry takes a raw bo handle while we
>> > never get a raw bo handle from libdrm_amdgpu. How are we supposed to
>> > fill it in?
>> >
>> > What do we win by having the raw handle for the bo_list? If we would
>> > not return the raw handle we would not need the submit_raw2.
>> >
>> >> +
>> >> +/**
>> >> + * Destroys a BO list handle.
>> >> + *
>> >> + * \param   bo_list    - \c [in] BO list handle.
>> >> + *
>> >> + * \return   0 on success\n
>> >> + *          <0 - Negative POSIX Error code
>> >> + *
>> >> + * \sa amdgpu_bo_list_create_raw(), amdgpu_cs_submit_raw2()
>> >> +*/
>> >> +int amdgpu_bo_list_destroy_raw(amdgpu_device_handle dev, uint32_t
>> bo_list);
>> >> +
>> >>   /**
>> >>    * Creates a BO list handle for command submission.
>> >>    *
>> >>    * \param   dev                        - \c [in] Device handle.
>> >>    *                                See #amdgpu_device_initialize()
>> >>    * \param   number_of_resources        - \c [in] Number of BOs in
>> the list
>> >>    * \param   resources          - \c [in] List of BO handles
>> >>    * \param   resource_prios     - \c [in] Optional priority for each
>> handle
>> >>    * \param   result             - \c [out] Created BO list handle
>> >>    *
>> >>    * \return   0 on success\n
>> >>    *          <0 - Negative POSIX Error code
>> >>    *
>> >> - * \sa amdgpu_bo_list_destroy()
>> >> + * \sa amdgpu_bo_list_destroy(), amdgpu_cs_submit_raw2()
>> >>   */
>> >>   int amdgpu_bo_list_create(amdgpu_device_handle dev,
>> >>                            uint32_t number_of_resources,
>> >>                            amdgpu_bo_handle *resources,
>> >>                            uint8_t *resource_prios,
>> >>                            amdgpu_bo_list_handle *result);
>> >>
>> >>   /**
>> >>    * Destroys a BO list handle.
>> >>    *
>> >> @@ -1580,20 +1612,42 @@ struct drm_amdgpu_cs_chunk;
>> >>   struct drm_amdgpu_cs_chunk_dep;
>> >>   struct drm_amdgpu_cs_chunk_data;
>> >>
>> >>   int amdgpu_cs_submit_raw(amdgpu_device_handle dev,
>> >>                           amdgpu_context_handle context,
>> >>                           amdgpu_bo_list_handle bo_list_handle,
>> >>                           int num_chunks,
>> >>                           struct drm_amdgpu_cs_chunk *chunks,
>> >>                           uint64_t *seq_no);
>> >>
>> >> +/**
>> >> + * Submit raw command submission to the kernel with a raw BO list
>> handle.
>> >> + *
>> >> + * \param   dev               - \c [in] device handle
>> >> + * \param   context    - \c [in] context handle for context id
>> >> + * \param   bo_list_handle - \c [in] raw bo list handle (0 for none)
>> >> + * \param   num_chunks - \c [in] number of CS chunks to submit
>> >> + * \param   chunks     - \c [in] array of CS chunks
>> >> + * \param   seq_no     - \c [out] output sequence number for
>> submission.
>> >> + *
>> >> + * \return   0 on success\n
>> >> + *          <0 - Negative POSIX Error code
>> >> + *
>> >> + * \sa amdgpu_bo_list_create_raw(), amdgpu_bo_list_destroy_raw()
>> >> + */
>> >> +int amdgpu_cs_submit_raw2(amdgpu_device_handle dev,
>> >> +                         amdgpu_context_handle context,
>> >> +                         uint32_t bo_list_handle,
>> >> +                         int num_chunks,
>> >> +                         struct drm_amdgpu_cs_chunk *chunks,
>> >> +                         uint64_t *seq_no);
>> >> +
>> >>   void amdgpu_cs_chunk_fence_to_dep(struct amdgpu_cs_fence *fence,
>> >>                                    struct drm_amdgpu_cs_chunk_dep
>> *dep);
>> >>   void amdgpu_cs_chunk_fence_info_to_data(struct amdgpu_cs_fence_info
>> *fence_info,
>> >>                                          struct
>> drm_amdgpu_cs_chunk_data *data);
>> >>
>> >>   /**
>> >>    * Reserve VMID
>> >>    * \param   context - \c [in]  GPU Context
>> >>    * \param   flags - \c [in]  TBD
>> >>    *
>> >> diff --git a/amdgpu/amdgpu_bo.c b/amdgpu/amdgpu_bo.c
>> >> index c0f42e81..21bc73aa 100644
>> >> --- a/amdgpu/amdgpu_bo.c
>> >> +++ b/amdgpu/amdgpu_bo.c
>> >> @@ -611,20 +611,56 @@ drm_public int
>> amdgpu_create_bo_from_user_mem(amdgpu_device_handle dev,
>> >>          pthread_mutex_lock(&dev->bo_table_mutex);
>> >>          r =3D handle_table_insert(&dev->bo_handles,
>> (*buf_handle)->handle,
>> >>                                  *buf_handle);
>> >>          pthread_mutex_unlock(&dev->bo_table_mutex);
>> >>          if (r)
>> >>                  amdgpu_bo_free(*buf_handle);
>> >>   out:
>> >>          return r;
>> >>   }
>> >>
>> >> +drm_public int amdgpu_bo_list_create_raw(amdgpu_device_handle dev,
>> >> +                                        uint32_t number_of_buffers,
>> >> +                                        struct
>> drm_amdgpu_bo_list_entry *buffers,
>> >> +                                        uint32_t *result)
>> >> +{
>> >> +       union drm_amdgpu_bo_list args;
>> >> +       int r;
>> >> +
>> >> +       memset(&args, 0, sizeof(args));
>> >> +       args.in.operation =3D AMDGPU_BO_LIST_OP_CREATE;
>> >> +       args.in.bo_number =3D number_of_buffers;
>> >> +       args.in.bo_info_size =3D sizeof(struct drm_amdgpu_bo_list_ent=
ry);
>> >> +       args.in.bo_info_ptr =3D (uint64_t)(uintptr_t)buffers;
>> >> +
>> >> +       r =3D drmCommandWriteRead(dev->fd, DRM_AMDGPU_BO_LIST,
>> >> +                               &args, sizeof(args));
>> >> +       if (r)
>> >> +               return r;
>> >> +
>> >> +       *result =3D args.out.list_handle;
>> >> +       return 0;
>> >> +}
>> >> +
>> >> +drm_public int amdgpu_bo_list_destroy_raw(amdgpu_device_handle dev,
>> >> +                                         uint32_t bo_list)
>> >> +{
>> >> +       union drm_amdgpu_bo_list args;
>> >> +
>> >> +       memset(&args, 0, sizeof(args));
>> >> +       args.in.operation =3D AMDGPU_BO_LIST_OP_DESTROY;
>> >> +       args.in.list_handle =3D bo_list;
>> >> +
>> >> +       return drmCommandWriteRead(dev->fd, DRM_AMDGPU_BO_LIST,
>> >> +                                  &args, sizeof(args));
>> >> +}
>> >> +
>> >>   drm_public int amdgpu_bo_list_create(amdgpu_device_handle dev,
>> >>                                       uint32_t number_of_resources,
>> >>                                       amdgpu_bo_handle *resources,
>> >>                                       uint8_t *resource_prios,
>> >>                                       amdgpu_bo_list_handle *result)
>> >>   {
>> >>          struct drm_amdgpu_bo_list_entry *list;
>> >>          union drm_amdgpu_bo_list args;
>> >>          unsigned i;
>> >>          int r;
>> >> diff --git a/amdgpu/amdgpu_cs.c b/amdgpu/amdgpu_cs.c
>> >> index 3b8231aa..5bedf748 100644
>> >> --- a/amdgpu/amdgpu_cs.c
>> >> +++ b/amdgpu/amdgpu_cs.c
>> >> @@ -724,20 +724,45 @@ drm_public int
>> amdgpu_cs_submit_raw(amdgpu_device_handle dev,
>> >>          r =3D drmCommandWriteRead(dev->fd, DRM_AMDGPU_CS,
>> >>                                  &cs, sizeof(cs));
>> >>          if (r)
>> >>                  return r;
>> >>
>> >>          if (seq_no)
>> >>                  *seq_no =3D cs.out.handle;
>> >>          return 0;
>> >>   }
>> >>
>> >> +drm_public int amdgpu_cs_submit_raw2(amdgpu_device_handle dev,
>> >> +                                    amdgpu_context_handle context,
>> >> +                                    uint32_t bo_list_handle,
>> >> +                                    int num_chunks,
>> >> +                                    struct drm_amdgpu_cs_chunk
>> *chunks,
>> >> +                                    uint64_t *seq_no)
>> >> +{
>> >> +       union drm_amdgpu_cs cs =3D {0};
>> >> +       uint64_t *chunk_array;
>> >> +       int i, r;
>> >> +
>> >> +       chunk_array =3D alloca(sizeof(uint64_t) * num_chunks);
>> >> +       for (i =3D 0; i < num_chunks; i++)
>> >> +               chunk_array[i] =3D (uint64_t)(uintptr_t)&chunks[i];
>> >> +       cs.in.chunks =3D (uint64_t)(uintptr_t)chunk_array;
>> >> +       cs.in.ctx_id =3D context->id;
>> >> +       cs.in.bo_list_handle =3D bo_list_handle;
>> >> +       cs.in.num_chunks =3D num_chunks;
>> >> +       r =3D drmCommandWriteRead(dev->fd, DRM_AMDGPU_CS,
>> >> +                               &cs, sizeof(cs));
>> >> +       if (!r && seq_no)
>> >> +               *seq_no =3D cs.out.handle;
>> >> +       return r;
>> >> +}
>> >> +
>> >>   drm_public void amdgpu_cs_chunk_fence_info_to_data(struct
>> amdgpu_cs_fence_info *fence_info,
>> >>                                          struct
>> drm_amdgpu_cs_chunk_data *data)
>> >>   {
>> >>          data->fence_data.handle =3D fence_info->handle->handle;
>> >>          data->fence_data.offset =3D fence_info->offset *
>> sizeof(uint64_t);
>> >>   }
>> >>
>> >>   drm_public void amdgpu_cs_chunk_fence_to_dep(struct amdgpu_cs_fence
>> *fence,
>> >>                                          struct
>> drm_amdgpu_cs_chunk_dep *dep)
>> >>   {
>> >> --
>> >> 2.17.1
>> >>
>> >> _______________________________________________
>> >> amd-gfx mailing list
>> >> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
>> >> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>> > _______________________________________________
>> > amd-gfx mailing list
>> > amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
>> > https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>>
>>
>

--000000000000de2ae8057f943fe7
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr">=
On Wed, Jan 16, 2019, 9:34 AM Koenig, Christian &lt;<a href=3D"mailto:Chris=
tian.Koenig-5C7GfCeVMHo@public.gmane.org">Christian.Koenig-5C7GfCeVMHo@public.gmane.org</a> wrote:<br></div><blockquo=
te class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc so=
lid;padding-left:1ex">



<div text=3D"#000000" bgcolor=3D"#FFFFFF">
<div class=3D"m_3799249069402976776moz-cite-prefix">Am 16.01.19 um 15:31 sc=
hrieb Marek Ol=C5=A1=C3=A1k:<br>
</div>
<blockquote type=3D"cite">
<div dir=3D"auto">
<div><br>
<br>
<div class=3D"gmail_quote">
<div dir=3D"ltr">On Wed, Jan 16, 2019, 7:55 AM Christian K=C3=B6nig &lt;<a =
href=3D"mailto:ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" target=3D"_blank" rel=3D"n=
oreferrer">ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a> wrote:<br>
</div>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
Well if you ask me we should have the following interface for <br>
negotiating memory management with the kernel:<br>
<br>
1. We have per process BOs which can&#39;t be shared between processes.<br>
<br>
Those are always valid and don&#39;t need to be mentioned in any BO list <b=
r>
whatsoever.<br>
<br>
If we knew that a per process BO is currently not in use we can <br>
optionally tell that to the kernel to make memory management more efficient=
.<br>
<br>
In other words instead of a list of stuff which is used we send down to <br=
>
the kernel a list of stuff which is not used any more and that only when <b=
r>
we know that it is necessary, e.g. when a game or application overcommits.<=
br>
</blockquote>
</div>
</div>
<div dir=3D"auto"><br>
</div>
<div dir=3D"auto">Radeonsi doesn&#39;t use this because this approach cause=
d performance degradation and also drops BO priorities.</div>
</div>
</blockquote>
<br>
The performance degradation where mostly shortcomings with the LRU which by=
 now have been fixed.<br>
<br>
BO priorities are a different topic, but could be added to per VM BOs as we=
ll.<br></div></blockquote></div></div><div dir=3D"auto"><br></div><div dir=
=3D"auto">What&#39;s the minimum drm version that contains the fixes?</div>=
<div dir=3D"auto"><br></div><div dir=3D"auto">Marek</div><div dir=3D"auto">=
<br></div><div dir=3D"auto"><div class=3D"gmail_quote"><blockquote class=3D=
"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding=
-left:1ex"><div text=3D"#000000" bgcolor=3D"#FFFFFF">
<br>
Christian.<br>
<br>
<blockquote type=3D"cite">
<div dir=3D"auto">
<div dir=3D"auto"><br>
</div>
<div dir=3D"auto">Marek</div>
<div dir=3D"auto"><br>
</div>
<div dir=3D"auto">
<div class=3D"gmail_quote">
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
<br>
2. We have shared BOs which are used by more than one process.<br>
<br>
Those are rare and should be added to the per CS list of BOs in use.<br>
<br>
<br>
The whole BO list interface Marek tries to optimize here should be <br>
deprecated and not used any more.<br>
<br>
Regards,<br>
Christian.<br>
<br>
Am 16.01.19 um 13:46 schrieb Bas Nieuwenhuizen:<br>
&gt; So random questions:<br>
&gt;<br>
&gt; 1) In this discussion it was mentioned that some Vulkan drivers still<=
br>
&gt; use the bo_list interface. I think that implies radv as I think we&#39=
;re<br>
&gt; still using bo_list. Is there any other API we should be using? (Also,=
<br>
&gt; with VK_EXT_descriptor_indexing I suspect we&#39;ll be moving more tow=
ards<br>
&gt; a global bo list instead of a cmd buffer one, as we cannot know all<br=
>
&gt; the BOs referenced anymore, but not sure what end state here will be).=
<br>
&gt;<br>
&gt; 2) The other alternative mentioned was adding the buffers directly<br>
&gt; into the submit ioctl. Is this the desired end state (though as above<=
br>
&gt; I&#39;m not sure how that works for vulkan)? If yes, what is the timel=
ine<br>
&gt; for this that we need something in the interim?<br>
&gt;<br>
&gt; 3) Did we measure any performance benefit?<br>
&gt;<br>
&gt; In general I&#39;d like to to ack the raw bo list creation function as=
<br>
&gt; this interface seems easier to use. The two arrays thing has always<br=
>
&gt; been kind of a pain when we want to use e.g. builtin sort functions to=
<br>
&gt; make sure we have no duplicate BOs, but have some comments below.<br>
&gt;<br>
&gt; On Mon, Jan 7, 2019 at 8:31 PM Marek Ol=C5=A1=C3=A1k &lt;<a href=3D"ma=
ilto:maraeo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" rel=3D"noreferrer noreferrer" target=3D"_blank">mara=
eo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt; wrote:<br>
&gt;&gt; From: Marek Ol=C5=A1=C3=A1k &lt;<a href=3D"mailto:marek.olsak@amd.=
com" rel=3D"noreferrer noreferrer" target=3D"_blank">marek.olsak-5C7GfCeVMHo@public.gmane.org</a=
>&gt;<br>
&gt;&gt;<br>
&gt;&gt; ---<br>
&gt;&gt;=C2=A0 =C2=A0amdgpu/amdgpu-symbol-check |=C2=A0 3 ++<br>
&gt;&gt;=C2=A0 =C2=A0amdgpu/amdgpu.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 | 56 +++++++++++++++++++++++++++++++++++++-<br>
&gt;&gt;=C2=A0 =C2=A0amdgpu/amdgpu_bo.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| =
36 ++++++++++++++++++++++++<br>
&gt;&gt;=C2=A0 =C2=A0amdgpu/amdgpu_cs.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| =
25 +++++++++++++++++<br>
&gt;&gt;=C2=A0 =C2=A04 files changed, 119 insertions(+), 1 deletion(-)<br>
&gt;&gt;<br>
&gt;&gt; diff --git a/amdgpu/amdgpu-symbol-check b/amdgpu/amdgpu-symbol-che=
ck<br>
&gt;&gt; index 6f5e0f95..96a44b40 100755<br>
&gt;&gt; --- a/amdgpu/amdgpu-symbol-check<br>
&gt;&gt; +++ b/amdgpu/amdgpu-symbol-check<br>
&gt;&gt; @@ -12,20 +12,22 @@ _edata<br>
&gt;&gt;=C2=A0 =C2=A0_end<br>
&gt;&gt;=C2=A0 =C2=A0_fini<br>
&gt;&gt;=C2=A0 =C2=A0_init<br>
&gt;&gt;=C2=A0 =C2=A0amdgpu_bo_alloc<br>
&gt;&gt;=C2=A0 =C2=A0amdgpu_bo_cpu_map<br>
&gt;&gt;=C2=A0 =C2=A0amdgpu_bo_cpu_unmap<br>
&gt;&gt;=C2=A0 =C2=A0amdgpu_bo_export<br>
&gt;&gt;=C2=A0 =C2=A0amdgpu_bo_free<br>
&gt;&gt;=C2=A0 =C2=A0amdgpu_bo_import<br>
&gt;&gt;=C2=A0 =C2=A0amdgpu_bo_inc_ref<br>
&gt;&gt; +amdgpu_bo_list_create_raw<br>
&gt;&gt; +amdgpu_bo_list_destroy_raw<br>
&gt;&gt;=C2=A0 =C2=A0amdgpu_bo_list_create<br>
&gt;&gt;=C2=A0 =C2=A0amdgpu_bo_list_destroy<br>
&gt;&gt;=C2=A0 =C2=A0amdgpu_bo_list_update<br>
&gt;&gt;=C2=A0 =C2=A0amdgpu_bo_query_info<br>
&gt;&gt;=C2=A0 =C2=A0amdgpu_bo_set_metadata<br>
&gt;&gt;=C2=A0 =C2=A0amdgpu_bo_va_op<br>
&gt;&gt;=C2=A0 =C2=A0amdgpu_bo_va_op_raw<br>
&gt;&gt;=C2=A0 =C2=A0amdgpu_bo_wait_for_idle<br>
&gt;&gt;=C2=A0 =C2=A0amdgpu_create_bo_from_user_mem<br>
&gt;&gt;=C2=A0 =C2=A0amdgpu_cs_chunk_fence_info_to_data<br>
&gt;&gt; @@ -40,20 +42,21 @@ amdgpu_cs_destroy_semaphore<br>
&gt;&gt;=C2=A0 =C2=A0amdgpu_cs_destroy_syncobj<br>
&gt;&gt;=C2=A0 =C2=A0amdgpu_cs_export_syncobj<br>
&gt;&gt;=C2=A0 =C2=A0amdgpu_cs_fence_to_handle<br>
&gt;&gt;=C2=A0 =C2=A0amdgpu_cs_import_syncobj<br>
&gt;&gt;=C2=A0 =C2=A0amdgpu_cs_query_fence_status<br>
&gt;&gt;=C2=A0 =C2=A0amdgpu_cs_query_reset_state<br>
&gt;&gt;=C2=A0 =C2=A0amdgpu_query_sw_info<br>
&gt;&gt;=C2=A0 =C2=A0amdgpu_cs_signal_semaphore<br>
&gt;&gt;=C2=A0 =C2=A0amdgpu_cs_submit<br>
&gt;&gt;=C2=A0 =C2=A0amdgpu_cs_submit_raw<br>
&gt;&gt; +amdgpu_cs_submit_raw2<br>
&gt;&gt;=C2=A0 =C2=A0amdgpu_cs_syncobj_export_sync_file<br>
&gt;&gt;=C2=A0 =C2=A0amdgpu_cs_syncobj_import_sync_file<br>
&gt;&gt;=C2=A0 =C2=A0amdgpu_cs_syncobj_reset<br>
&gt;&gt;=C2=A0 =C2=A0amdgpu_cs_syncobj_signal<br>
&gt;&gt;=C2=A0 =C2=A0amdgpu_cs_syncobj_wait<br>
&gt;&gt;=C2=A0 =C2=A0amdgpu_cs_wait_fences<br>
&gt;&gt;=C2=A0 =C2=A0amdgpu_cs_wait_semaphore<br>
&gt;&gt;=C2=A0 =C2=A0amdgpu_device_deinitialize<br>
&gt;&gt;=C2=A0 =C2=A0amdgpu_device_initialize<br>
&gt;&gt;=C2=A0 =C2=A0amdgpu_find_bo_by_cpu_mapping<br>
&gt;&gt; diff --git a/amdgpu/amdgpu.h b/amdgpu/amdgpu.h<br>
&gt;&gt; index dc51659a..5b800033 100644<br>
&gt;&gt; --- a/amdgpu/amdgpu.h<br>
&gt;&gt; +++ b/amdgpu/amdgpu.h<br>
&gt;&gt; @@ -35,20 +35,21 @@<br>
&gt;&gt;=C2=A0 =C2=A0#define _AMDGPU_H_<br>
&gt;&gt;<br>
&gt;&gt;=C2=A0 =C2=A0#include &lt;stdint.h&gt;<br>
&gt;&gt;=C2=A0 =C2=A0#include &lt;stdbool.h&gt;<br>
&gt;&gt;<br>
&gt;&gt;=C2=A0 =C2=A0#ifdef __cplusplus<br>
&gt;&gt;=C2=A0 =C2=A0extern &quot;C&quot; {<br>
&gt;&gt;=C2=A0 =C2=A0#endif<br>
&gt;&gt;<br>
&gt;&gt;=C2=A0 =C2=A0struct drm_amdgpu_info_hw_ip;<br>
&gt;&gt; +struct drm_amdgpu_bo_list_entry;<br>
&gt;&gt;<br>
&gt;&gt;=C2=A0 =C2=A0/*----------------------------------------------------=
----------------------*/<br>
&gt;&gt;=C2=A0 =C2=A0/* --------------------------- Defines ---------------=
--------------------- */<br>
&gt;&gt;=C2=A0 =C2=A0/*----------------------------------------------------=
----------------------*/<br>
&gt;&gt;<br>
&gt;&gt;=C2=A0 =C2=A0/**<br>
&gt;&gt;=C2=A0 =C2=A0 * Define max. number of Command Buffers (IB) which co=
uld be sent to the single<br>
&gt;&gt;=C2=A0 =C2=A0 * hardware IP to accommodate CE/DE requirements<br>
&gt;&gt;=C2=A0 =C2=A0 *<br>
&gt;&gt;=C2=A0 =C2=A0 * \sa amdgpu_cs_ib_info<br>
&gt;&gt; @@ -767,34 +768,65 @@ int amdgpu_bo_cpu_unmap(amdgpu_bo_handle buf=
_handle);<br>
&gt;&gt;=C2=A0 =C2=A0 *=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 and no GPU access is schedule=
d.<br>
&gt;&gt;=C2=A0 =C2=A0 *=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 1 GPU access is in fly or scheduled<=
br>
&gt;&gt;=C2=A0 =C2=A0 *<br>
&gt;&gt;=C2=A0 =C2=A0 * \return=C2=A0 =C2=A00 - on success<br>
&gt;&gt;=C2=A0 =C2=A0 *=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;0 - Negative =
POSIX Error code<br>
&gt;&gt;=C2=A0 =C2=A0 */<br>
&gt;&gt;=C2=A0 =C2=A0int amdgpu_bo_wait_for_idle(amdgpu_bo_handle buf_handl=
e,<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint64_t timeout_ns,<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bool *buffer_busy);<br>
&gt;&gt;<br>
&gt;&gt; +/**<br>
&gt;&gt; + * Creates a BO list handle for command submission.<br>
&gt;&gt; + *<br>
&gt;&gt; + * \param=C2=A0 =C2=A0dev=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 - \c [in] Device handle.<br>
&gt;&gt; + *=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 See #amdgpu_device_initial=
ize()<br>
&gt;&gt; + * \param=C2=A0 =C2=A0number_of_buffers=C2=A0 - \c [in] Number of=
 BOs in the list<br>
&gt;&gt; + * \param=C2=A0 =C2=A0buffers=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 - \c [in] List of BO handles<br>
&gt;&gt; + * \param=C2=A0 =C2=A0result=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0- \c [out] Created BO list handle<br>
&gt;&gt; + *<br>
&gt;&gt; + * \return=C2=A0 =C2=A00 on success\n<br>
&gt;&gt; + *=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;0 - Negative POSIX Error=
 code<br>
&gt;&gt; + *<br>
&gt;&gt; + * \sa amdgpu_bo_list_destroy_raw()<br>
&gt;&gt; +*/<br>
&gt;&gt; +int amdgpu_bo_list_create_raw(amdgpu_device_handle dev,<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t number_of_buffers,<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct drm_amdgpu_bo_list_entry *b=
uffers,<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t *result);<br>
&gt; So AFAIU=C2=A0 drm_amdgpu_bo_list_entry takes a raw bo handle while we=
<br>
&gt; never get a raw bo handle from libdrm_amdgpu. How are we supposed to<b=
r>
&gt; fill it in?<br>
&gt;<br>
&gt; What do we win by having the raw handle for the bo_list? If we would<b=
r>
&gt; not return the raw handle we would not need the submit_raw2.<br>
&gt;<br>
&gt;&gt; +<br>
&gt;&gt; +/**<br>
&gt;&gt; + * Destroys a BO list handle.<br>
&gt;&gt; + *<br>
&gt;&gt; + * \param=C2=A0 =C2=A0bo_list=C2=A0 =C2=A0 - \c [in] BO list hand=
le.<br>
&gt;&gt; + *<br>
&gt;&gt; + * \return=C2=A0 =C2=A00 on success\n<br>
&gt;&gt; + *=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;0 - Negative POSIX Error=
 code<br>
&gt;&gt; + *<br>
&gt;&gt; + * \sa amdgpu_bo_list_create_raw(), amdgpu_cs_submit_raw2()<br>
&gt;&gt; +*/<br>
&gt;&gt; +int amdgpu_bo_list_destroy_raw(amdgpu_device_handle dev, uint32_t=
 bo_list);<br>
&gt;&gt; +<br>
&gt;&gt;=C2=A0 =C2=A0/**<br>
&gt;&gt;=C2=A0 =C2=A0 * Creates a BO list handle for command submission.<br=
>
&gt;&gt;=C2=A0 =C2=A0 *<br>
&gt;&gt;=C2=A0 =C2=A0 * \param=C2=A0 =C2=A0dev=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 - \c [in] Device ha=
ndle.<br>
&gt;&gt;=C2=A0 =C2=A0 *=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 See #amdgpu_dev=
ice_initialize()<br>
&gt;&gt;=C2=A0 =C2=A0 * \param=C2=A0 =C2=A0number_of_resources=C2=A0 =C2=A0=
 =C2=A0 =C2=A0 - \c [in] Number of BOs in the list<br>
&gt;&gt;=C2=A0 =C2=A0 * \param=C2=A0 =C2=A0resources=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 - \c [in] List of BO handles<br>
&gt;&gt;=C2=A0 =C2=A0 * \param=C2=A0 =C2=A0resource_prios=C2=A0 =C2=A0 =C2=
=A0- \c [in] Optional priority for each handle<br>
&gt;&gt;=C2=A0 =C2=A0 * \param=C2=A0 =C2=A0result=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0- \c [out] Created BO list handle<br>
&gt;&gt;=C2=A0 =C2=A0 *<br>
&gt;&gt;=C2=A0 =C2=A0 * \return=C2=A0 =C2=A00 on success\n<br>
&gt;&gt;=C2=A0 =C2=A0 *=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;0 - Negative =
POSIX Error code<br>
&gt;&gt;=C2=A0 =C2=A0 *<br>
&gt;&gt; - * \sa amdgpu_bo_list_destroy()<br>
&gt;&gt; + * \sa amdgpu_bo_list_destroy(), amdgpu_cs_submit_raw2()<br>
&gt;&gt;=C2=A0 =C2=A0*/<br>
&gt;&gt;=C2=A0 =C2=A0int amdgpu_bo_list_create(amdgpu_device_handle dev,<br=
>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint32_t number_of_resources,<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 amdgpu_bo_handle *resources,<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint8_t *resource_prios,<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 amdgpu_bo_list_handle *result);<br>
&gt;&gt;<br>
&gt;&gt;=C2=A0 =C2=A0/**<br>
&gt;&gt;=C2=A0 =C2=A0 * Destroys a BO list handle.<br>
&gt;&gt;=C2=A0 =C2=A0 *<br>
&gt;&gt; @@ -1580,20 +1612,42 @@ struct drm_amdgpu_cs_chunk;<br>
&gt;&gt;=C2=A0 =C2=A0struct drm_amdgpu_cs_chunk_dep;<br>
&gt;&gt;=C2=A0 =C2=A0struct drm_amdgpu_cs_chunk_data;<br>
&gt;&gt;<br>
&gt;&gt;=C2=A0 =C2=A0int amdgpu_cs_submit_raw(amdgpu_device_handle dev,<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0amdgpu_context_handle context,<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0amdgpu_bo_list_handle bo_list_handle,<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int num_chunks,<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct drm_amdgpu_cs_chunk *chunks,<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint64_t *seq_no);<br>
&gt;&gt;<br>
&gt;&gt; +/**<br>
&gt;&gt; + * Submit raw command submission to the kernel with a raw BO list=
 handle.<br>
&gt;&gt; + *<br>
&gt;&gt; + * \param=C2=A0 =C2=A0dev=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0- \c [in] device handle<br>
&gt;&gt; + * \param=C2=A0 =C2=A0context=C2=A0 =C2=A0 - \c [in] context hand=
le for context id<br>
&gt;&gt; + * \param=C2=A0 =C2=A0bo_list_handle - \c [in] raw bo list handle=
 (0 for none)<br>
&gt;&gt; + * \param=C2=A0 =C2=A0num_chunks - \c [in] number of CS chunks to=
 submit<br>
&gt;&gt; + * \param=C2=A0 =C2=A0chunks=C2=A0 =C2=A0 =C2=A0- \c [in] array o=
f CS chunks<br>
&gt;&gt; + * \param=C2=A0 =C2=A0seq_no=C2=A0 =C2=A0 =C2=A0- \c [out] output=
 sequence number for submission.<br>
&gt;&gt; + *<br>
&gt;&gt; + * \return=C2=A0 =C2=A00 on success\n<br>
&gt;&gt; + *=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;0 - Negative POSIX Error=
 code<br>
&gt;&gt; + *<br>
&gt;&gt; + * \sa amdgpu_bo_list_create_raw(), amdgpu_bo_list_destroy_raw()<=
br>
&gt;&gt; + */<br>
&gt;&gt; +int amdgpu_cs_submit_raw2(amdgpu_device_handle dev,<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0amdgpu_context_handle context,<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t bo_list_handle,<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0int num_chunks,<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0struct drm_amdgpu_cs_chunk *chunks,<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0uint64_t *seq_no);<br>
&gt;&gt; +<br>
&gt;&gt;=C2=A0 =C2=A0void amdgpu_cs_chunk_fence_to_dep(struct amdgpu_cs_fen=
ce *fence,<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct drm_amdg=
pu_cs_chunk_dep *dep);<br>
&gt;&gt;=C2=A0 =C2=A0void amdgpu_cs_chunk_fence_info_to_data(struct amdgpu_=
cs_fence_info *fence_info,<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 struct drm_amdgpu_cs_chunk_data *data);<br>
&gt;&gt;<br>
&gt;&gt;=C2=A0 =C2=A0/**<br>
&gt;&gt;=C2=A0 =C2=A0 * Reserve VMID<br>
&gt;&gt;=C2=A0 =C2=A0 * \param=C2=A0 =C2=A0context - \c [in]=C2=A0 GPU Cont=
ext<br>
&gt;&gt;=C2=A0 =C2=A0 * \param=C2=A0 =C2=A0flags - \c [in]=C2=A0 TBD<br>
&gt;&gt;=C2=A0 =C2=A0 *<br>
&gt;&gt; diff --git a/amdgpu/amdgpu_bo.c b/amdgpu/amdgpu_bo.c<br>
&gt;&gt; index c0f42e81..21bc73aa 100644<br>
&gt;&gt; --- a/amdgpu/amdgpu_bo.c<br>
&gt;&gt; +++ b/amdgpu/amdgpu_bo.c<br>
&gt;&gt; @@ -611,20 +611,56 @@ drm_public int amdgpu_create_bo_from_user_me=
m(amdgpu_device_handle dev,<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pthread_mutex_lock(&amp;dev-&gt;=
bo_table_mutex);<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 r =3D handle_table_insert(&amp;d=
ev-&gt;bo_handles, (*buf_handle)-&gt;handle,<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 *buf_handle);<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pthread_mutex_unlock(&amp;dev-&g=
t;bo_table_mutex);<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (r)<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 amdg=
pu_bo_free(*buf_handle);<br>
&gt;&gt;=C2=A0 =C2=A0out:<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return r;<br>
&gt;&gt;=C2=A0 =C2=A0}<br>
&gt;&gt;<br>
&gt;&gt; +drm_public int amdgpu_bo_list_create_raw(amdgpu_device_handle dev=
,<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 uint32_t number_of_buffers,<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 struct drm_amdgpu_bo_list_entry *buffers,<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 uint32_t *result)<br>
&gt;&gt; +{<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0union drm_amdgpu_bo_list args;<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0int r;<br>
&gt;&gt; +<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0memset(&amp;args, 0, sizeof(args));<br=
>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0args.in.operation =3D AMDGPU_BO_LIST_O=
P_CREATE;<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0args.in.bo_number =3D number_of_buffer=
s;<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0args.in.bo_info_size =3D sizeof(struct=
 drm_amdgpu_bo_list_entry);<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0args.in.bo_info_ptr =3D (uint64_t)(uin=
tptr_t)buffers;<br>
&gt;&gt; +<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0r =3D drmCommandWriteRead(dev-&gt;fd, =
DRM_AMDGPU_BO_LIST,<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;args, sizeof(args));<b=
r>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0if (r)<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return r;<=
br>
&gt;&gt; +<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0*result =3D args.out.list_handle;<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
&gt;&gt; +}<br>
&gt;&gt; +<br>
&gt;&gt; +drm_public int amdgpu_bo_list_destroy_raw(amdgpu_device_handle de=
v,<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0uint32_t bo_list)<br>
&gt;&gt; +{<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0union drm_amdgpu_bo_list args;<br>
&gt;&gt; +<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0memset(&amp;args, 0, sizeof(args));<br=
>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0args.in.operation =3D AMDGPU_BO_LIST_O=
P_DESTROY;<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0args.in.list_handle =3D bo_list;<br>
&gt;&gt; +<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0return drmCommandWriteRead(dev-&gt;fd,=
 DRM_AMDGPU_BO_LIST,<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;args, sizeof(a=
rgs));<br>
&gt;&gt; +}<br>
&gt;&gt; +<br>
&gt;&gt;=C2=A0 =C2=A0drm_public int amdgpu_bo_list_create(amdgpu_device_han=
dle dev,<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ui=
nt32_t number_of_resources,<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0am=
dgpu_bo_handle *resources,<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ui=
nt8_t *resource_prios,<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0am=
dgpu_bo_list_handle *result)<br>
&gt;&gt;=C2=A0 =C2=A0{<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct drm_amdgpu_bo_list_entry =
*list;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 union drm_amdgpu_bo_list args;<b=
r>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned i;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int r;<br>
&gt;&gt; diff --git a/amdgpu/amdgpu_cs.c b/amdgpu/amdgpu_cs.c<br>
&gt;&gt; index 3b8231aa..5bedf748 100644<br>
&gt;&gt; --- a/amdgpu/amdgpu_cs.c<br>
&gt;&gt; +++ b/amdgpu/amdgpu_cs.c<br>
&gt;&gt; @@ -724,20 +724,45 @@ drm_public int amdgpu_cs_submit_raw(amdgpu_d=
evice_handle dev,<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 r =3D drmCommandWriteRead(dev-&g=
t;fd, DRM_AMDGPU_CS,<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;cs, sizeof(cs));<=
br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (r)<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 retu=
rn r;<br>
&gt;&gt;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (seq_no)<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 *seq=
_no =3D cs.out.handle;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;<br>
&gt;&gt;=C2=A0 =C2=A0}<br>
&gt;&gt;<br>
&gt;&gt; +drm_public int amdgpu_cs_submit_raw2(amdgpu_device_handle dev,<br=
>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 amdgpu_conte=
xt_handle context,<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint32_t bo_=
list_handle,<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int num_chun=
ks,<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct drm_a=
mdgpu_cs_chunk *chunks,<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint64_t *se=
q_no)<br>
&gt;&gt; +{<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0union drm_amdgpu_cs cs =3D {0};<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0uint64_t *chunk_array;<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0int i, r;<br>
&gt;&gt; +<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0chunk_array =3D alloca(sizeof(uint64_t=
) * num_chunks);<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0for (i =3D 0; i &lt; num_chunks; i++)<=
br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0chunk_arra=
y[i] =3D (uint64_t)(uintptr_t)&amp;chunks[i];<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0cs.in.chunks =3D (uint64_t)(uintptr_t)=
chunk_array;<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0cs.in.ctx_id =3D context-&gt;id;<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0cs.in.bo_list_handle =3D bo_list_handl=
e;<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0cs.in.num_chunks =3D num_chunks;<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0r =3D drmCommandWriteRead(dev-&gt;fd, =
DRM_AMDGPU_CS,<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;cs, sizeof(cs));<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!r &amp;&amp; seq_no)<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*seq_no =
=3D cs.out.handle;<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0return r;<br>
&gt;&gt; +}<br>
&gt;&gt; +<br>
&gt;&gt;=C2=A0 =C2=A0drm_public void amdgpu_cs_chunk_fence_info_to_data(str=
uct amdgpu_cs_fence_info *fence_info,<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 struct drm_amdgpu_cs_chunk_data *data)<br>
&gt;&gt;=C2=A0 =C2=A0{<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 data-&gt;fence_data.handle =3D f=
ence_info-&gt;handle-&gt;handle;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 data-&gt;fence_data.offset =3D f=
ence_info-&gt;offset * sizeof(uint64_t);<br>
&gt;&gt;=C2=A0 =C2=A0}<br>
&gt;&gt;<br>
&gt;&gt;=C2=A0 =C2=A0drm_public void amdgpu_cs_chunk_fence_to_dep(struct am=
dgpu_cs_fence *fence,<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 struct drm_amdgpu_cs_chunk_dep *dep)<br>
&gt;&gt;=C2=A0 =C2=A0{<br>
&gt;&gt; --<br>
&gt;&gt; 2.17.1<br>
&gt;&gt;<br>
&gt;&gt; _______________________________________________<br>
&gt;&gt; amd-gfx mailing list<br>
&gt;&gt; <a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" rel=3D"noreferrer=
 noreferrer" target=3D"_blank">
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
&gt;&gt; <a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx"=
 rel=3D"noreferrer noreferrer noreferrer" target=3D"_blank">
https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a><br>
&gt; _______________________________________________<br>
&gt; amd-gfx mailing list<br>
&gt; <a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" rel=3D"noreferrer nor=
eferrer" target=3D"_blank">
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
&gt; <a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx" rel=
=3D"noreferrer noreferrer noreferrer" target=3D"_blank">
https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a><br>
<br>
</blockquote>
</div>
</div>
</div>
</blockquote>
<br>
</div>

</blockquote></div></div></div>

--000000000000de2ae8057f943fe7--

--===============0917280486==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0917280486==--
