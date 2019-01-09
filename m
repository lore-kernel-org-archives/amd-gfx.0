From: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH libdrm] amdgpu: add a faster BO list API
Date: Wed, 9 Jan 2019 07:36:36 -0500
Message-ID: <CAAxE2A5M2WW6uPFo0a=+6ukbtgx5xHfkKUKOB9dgtB=qH88htQ@mail.gmail.com>
References: <20190107193104.4361-1-maraeo@gmail.com>
 <a0a15ed6-eb1a-fbbe-7c1b-e3b9a64c1008@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0423776317=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <a0a15ed6-eb1a-fbbe-7c1b-e3b9a64c1008-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
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
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>
Cc: amd-gfx mailing list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============0423776317==
Content-Type: multipart/alternative; boundary="000000000000492023057f05b721"

--000000000000492023057f05b721
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 9, 2019, 5:28 AM Christian K=C3=B6nig <
ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org wrote:

> Looks good, but I'm wondering what's the actual improvement?
>

No malloc calls and 1 less for loop copying the bo list.

Marek


> Christian.
>
> Am 07.01.19 um 20:31 schrieb Marek Ol=C5=A1=C3=A1k:
> > From: Marek Ol=C5=A1=C3=A1k <marek.olsak-5C7GfCeVMHo@public.gmane.org>
> >
> > ---
> >   amdgpu/amdgpu-symbol-check |  3 ++
> >   amdgpu/amdgpu.h            | 56 +++++++++++++++++++++++++++++++++++++=
-
> >   amdgpu/amdgpu_bo.c         | 36 ++++++++++++++++++++++++
> >   amdgpu/amdgpu_cs.c         | 25 +++++++++++++++++
> >   4 files changed, 119 insertions(+), 1 deletion(-)
> >
> > diff --git a/amdgpu/amdgpu-symbol-check b/amdgpu/amdgpu-symbol-check
> > index 6f5e0f95..96a44b40 100755
> > --- a/amdgpu/amdgpu-symbol-check
> > +++ b/amdgpu/amdgpu-symbol-check
> > @@ -12,20 +12,22 @@ _edata
> >   _end
> >   _fini
> >   _init
> >   amdgpu_bo_alloc
> >   amdgpu_bo_cpu_map
> >   amdgpu_bo_cpu_unmap
> >   amdgpu_bo_export
> >   amdgpu_bo_free
> >   amdgpu_bo_import
> >   amdgpu_bo_inc_ref
> > +amdgpu_bo_list_create_raw
> > +amdgpu_bo_list_destroy_raw
> >   amdgpu_bo_list_create
> >   amdgpu_bo_list_destroy
> >   amdgpu_bo_list_update
> >   amdgpu_bo_query_info
> >   amdgpu_bo_set_metadata
> >   amdgpu_bo_va_op
> >   amdgpu_bo_va_op_raw
> >   amdgpu_bo_wait_for_idle
> >   amdgpu_create_bo_from_user_mem
> >   amdgpu_cs_chunk_fence_info_to_data
> > @@ -40,20 +42,21 @@ amdgpu_cs_destroy_semaphore
> >   amdgpu_cs_destroy_syncobj
> >   amdgpu_cs_export_syncobj
> >   amdgpu_cs_fence_to_handle
> >   amdgpu_cs_import_syncobj
> >   amdgpu_cs_query_fence_status
> >   amdgpu_cs_query_reset_state
> >   amdgpu_query_sw_info
> >   amdgpu_cs_signal_semaphore
> >   amdgpu_cs_submit
> >   amdgpu_cs_submit_raw
> > +amdgpu_cs_submit_raw2
> >   amdgpu_cs_syncobj_export_sync_file
> >   amdgpu_cs_syncobj_import_sync_file
> >   amdgpu_cs_syncobj_reset
> >   amdgpu_cs_syncobj_signal
> >   amdgpu_cs_syncobj_wait
> >   amdgpu_cs_wait_fences
> >   amdgpu_cs_wait_semaphore
> >   amdgpu_device_deinitialize
> >   amdgpu_device_initialize
> >   amdgpu_find_bo_by_cpu_mapping
> > diff --git a/amdgpu/amdgpu.h b/amdgpu/amdgpu.h
> > index dc51659a..5b800033 100644
> > --- a/amdgpu/amdgpu.h
> > +++ b/amdgpu/amdgpu.h
> > @@ -35,20 +35,21 @@
> >   #define _AMDGPU_H_
> >
> >   #include <stdint.h>
> >   #include <stdbool.h>
> >
> >   #ifdef __cplusplus
> >   extern "C" {
> >   #endif
> >
> >   struct drm_amdgpu_info_hw_ip;
> > +struct drm_amdgpu_bo_list_entry;
> >
> >
>  /*----------------------------------------------------------------------=
----*/
> >   /* --------------------------- Defines
> ------------------------------------ */
> >
>  /*----------------------------------------------------------------------=
----*/
> >
> >   /**
> >    * Define max. number of Command Buffers (IB) which could be sent to
> the single
> >    * hardware IP to accommodate CE/DE requirements
> >    *
> >    * \sa amdgpu_cs_ib_info
> > @@ -767,34 +768,65 @@ int amdgpu_bo_cpu_unmap(amdgpu_bo_handle
> buf_handle);
> >    *                            and no GPU access is scheduled.
> >    *                          1 GPU access is in fly or scheduled
> >    *
> >    * \return   0 - on success
> >    *          <0 - Negative POSIX Error code
> >    */
> >   int amdgpu_bo_wait_for_idle(amdgpu_bo_handle buf_handle,
> >                           uint64_t timeout_ns,
> >                           bool *buffer_busy);
> >
> > +/**
> > + * Creates a BO list handle for command submission.
> > + *
> > + * \param   dev                      - \c [in] Device handle.
> > + *                              See #amdgpu_device_initialize()
> > + * \param   number_of_buffers        - \c [in] Number of BOs in the li=
st
> > + * \param   buffers          - \c [in] List of BO handles
> > + * \param   result           - \c [out] Created BO list handle
> > + *
> > + * \return   0 on success\n
> > + *          <0 - Negative POSIX Error code
> > + *
> > + * \sa amdgpu_bo_list_destroy_raw()
> > +*/
> > +int amdgpu_bo_list_create_raw(amdgpu_device_handle dev,
> > +                           uint32_t number_of_buffers,
> > +                           struct drm_amdgpu_bo_list_entry *buffers,
> > +                           uint32_t *result);
> > +
> > +/**
> > + * Destroys a BO list handle.
> > + *
> > + * \param   bo_list  - \c [in] BO list handle.
> > + *
> > + * \return   0 on success\n
> > + *          <0 - Negative POSIX Error code
> > + *
> > + * \sa amdgpu_bo_list_create_raw(), amdgpu_cs_submit_raw2()
> > +*/
> > +int amdgpu_bo_list_destroy_raw(amdgpu_device_handle dev, uint32_t
> bo_list);
> > +
> >   /**
> >    * Creates a BO list handle for command submission.
> >    *
> >    * \param   dev                     - \c [in] Device handle.
> >    *                             See #amdgpu_device_initialize()
> >    * \param   number_of_resources     - \c [in] Number of BOs in the li=
st
> >    * \param   resources               - \c [in] List of BO handles
> >    * \param   resource_prios  - \c [in] Optional priority for each hand=
le
> >    * \param   result          - \c [out] Created BO list handle
> >    *
> >    * \return   0 on success\n
> >    *          <0 - Negative POSIX Error code
> >    *
> > - * \sa amdgpu_bo_list_destroy()
> > + * \sa amdgpu_bo_list_destroy(), amdgpu_cs_submit_raw2()
> >   */
> >   int amdgpu_bo_list_create(amdgpu_device_handle dev,
> >                         uint32_t number_of_resources,
> >                         amdgpu_bo_handle *resources,
> >                         uint8_t *resource_prios,
> >                         amdgpu_bo_list_handle *result);
> >
> >   /**
> >    * Destroys a BO list handle.
> >    *
> > @@ -1580,20 +1612,42 @@ struct drm_amdgpu_cs_chunk;
> >   struct drm_amdgpu_cs_chunk_dep;
> >   struct drm_amdgpu_cs_chunk_data;
> >
> >   int amdgpu_cs_submit_raw(amdgpu_device_handle dev,
> >                        amdgpu_context_handle context,
> >                        amdgpu_bo_list_handle bo_list_handle,
> >                        int num_chunks,
> >                        struct drm_amdgpu_cs_chunk *chunks,
> >                        uint64_t *seq_no);
> >
> > +/**
> > + * Submit raw command submission to the kernel with a raw BO list
> handle.
> > + *
> > + * \param   dev             - \c [in] device handle
> > + * \param   context    - \c [in] context handle for context id
> > + * \param   bo_list_handle - \c [in] raw bo list handle (0 for none)
> > + * \param   num_chunks - \c [in] number of CS chunks to submit
> > + * \param   chunks     - \c [in] array of CS chunks
> > + * \param   seq_no     - \c [out] output sequence number for submissio=
n.
> > + *
> > + * \return   0 on success\n
> > + *          <0 - Negative POSIX Error code
> > + *
> > + * \sa amdgpu_bo_list_create_raw(), amdgpu_bo_list_destroy_raw()
> > + */
> > +int amdgpu_cs_submit_raw2(amdgpu_device_handle dev,
> > +                       amdgpu_context_handle context,
> > +                       uint32_t bo_list_handle,
> > +                       int num_chunks,
> > +                       struct drm_amdgpu_cs_chunk *chunks,
> > +                       uint64_t *seq_no);
> > +
> >   void amdgpu_cs_chunk_fence_to_dep(struct amdgpu_cs_fence *fence,
> >                                 struct drm_amdgpu_cs_chunk_dep *dep);
> >   void amdgpu_cs_chunk_fence_info_to_data(struct amdgpu_cs_fence_info
> *fence_info,
> >                                       struct drm_amdgpu_cs_chunk_data
> *data);
> >
> >   /**
> >    * Reserve VMID
> >    * \param   context - \c [in]  GPU Context
> >    * \param   flags - \c [in]  TBD
> >    *
> > diff --git a/amdgpu/amdgpu_bo.c b/amdgpu/amdgpu_bo.c
> > index c0f42e81..21bc73aa 100644
> > --- a/amdgpu/amdgpu_bo.c
> > +++ b/amdgpu/amdgpu_bo.c
> > @@ -611,20 +611,56 @@ drm_public int
> amdgpu_create_bo_from_user_mem(amdgpu_device_handle dev,
> >       pthread_mutex_lock(&dev->bo_table_mutex);
> >       r =3D handle_table_insert(&dev->bo_handles, (*buf_handle)->handle=
,
> >                               *buf_handle);
> >       pthread_mutex_unlock(&dev->bo_table_mutex);
> >       if (r)
> >               amdgpu_bo_free(*buf_handle);
> >   out:
> >       return r;
> >   }
> >
> > +drm_public int amdgpu_bo_list_create_raw(amdgpu_device_handle dev,
> > +                                      uint32_t number_of_buffers,
> > +                                      struct drm_amdgpu_bo_list_entry
> *buffers,
> > +                                      uint32_t *result)
> > +{
> > +     union drm_amdgpu_bo_list args;
> > +     int r;
> > +
> > +     memset(&args, 0, sizeof(args));
> > +     args.in.operation =3D AMDGPU_BO_LIST_OP_CREATE;
> > +     args.in.bo_number =3D number_of_buffers;
> > +     args.in.bo_info_size =3D sizeof(struct drm_amdgpu_bo_list_entry);
> > +     args.in.bo_info_ptr =3D (uint64_t)(uintptr_t)buffers;
> > +
> > +     r =3D drmCommandWriteRead(dev->fd, DRM_AMDGPU_BO_LIST,
> > +                             &args, sizeof(args));
> > +     if (r)
> > +             return r;
> > +
> > +     *result =3D args.out.list_handle;
> > +     return 0;
> > +}
> > +
> > +drm_public int amdgpu_bo_list_destroy_raw(amdgpu_device_handle dev,
> > +                                       uint32_t bo_list)
> > +{
> > +     union drm_amdgpu_bo_list args;
> > +
> > +     memset(&args, 0, sizeof(args));
> > +     args.in.operation =3D AMDGPU_BO_LIST_OP_DESTROY;
> > +     args.in.list_handle =3D bo_list;
> > +
> > +     return drmCommandWriteRead(dev->fd, DRM_AMDGPU_BO_LIST,
> > +                                &args, sizeof(args));
> > +}
> > +
> >   drm_public int amdgpu_bo_list_create(amdgpu_device_handle dev,
> >                                    uint32_t number_of_resources,
> >                                    amdgpu_bo_handle *resources,
> >                                    uint8_t *resource_prios,
> >                                    amdgpu_bo_list_handle *result)
> >   {
> >       struct drm_amdgpu_bo_list_entry *list;
> >       union drm_amdgpu_bo_list args;
> >       unsigned i;
> >       int r;
> > diff --git a/amdgpu/amdgpu_cs.c b/amdgpu/amdgpu_cs.c
> > index 3b8231aa..5bedf748 100644
> > --- a/amdgpu/amdgpu_cs.c
> > +++ b/amdgpu/amdgpu_cs.c
> > @@ -724,20 +724,45 @@ drm_public int
> amdgpu_cs_submit_raw(amdgpu_device_handle dev,
> >       r =3D drmCommandWriteRead(dev->fd, DRM_AMDGPU_CS,
> >                               &cs, sizeof(cs));
> >       if (r)
> >               return r;
> >
> >       if (seq_no)
> >               *seq_no =3D cs.out.handle;
> >       return 0;
> >   }
> >
> > +drm_public int amdgpu_cs_submit_raw2(amdgpu_device_handle dev,
> > +                                  amdgpu_context_handle context,
> > +                                  uint32_t bo_list_handle,
> > +                                  int num_chunks,
> > +                                  struct drm_amdgpu_cs_chunk *chunks,
> > +                                  uint64_t *seq_no)
> > +{
> > +     union drm_amdgpu_cs cs =3D {0};
> > +     uint64_t *chunk_array;
> > +     int i, r;
> > +
> > +     chunk_array =3D alloca(sizeof(uint64_t) * num_chunks);
> > +     for (i =3D 0; i < num_chunks; i++)
> > +             chunk_array[i] =3D (uint64_t)(uintptr_t)&chunks[i];
> > +     cs.in.chunks =3D (uint64_t)(uintptr_t)chunk_array;
> > +     cs.in.ctx_id =3D context->id;
> > +     cs.in.bo_list_handle =3D bo_list_handle;
> > +     cs.in.num_chunks =3D num_chunks;
> > +     r =3D drmCommandWriteRead(dev->fd, DRM_AMDGPU_CS,
> > +                             &cs, sizeof(cs));
> > +     if (!r && seq_no)
> > +             *seq_no =3D cs.out.handle;
> > +     return r;
> > +}
> > +
> >   drm_public void amdgpu_cs_chunk_fence_info_to_data(struct
> amdgpu_cs_fence_info *fence_info,
> >                                       struct drm_amdgpu_cs_chunk_data
> *data)
> >   {
> >       data->fence_data.handle =3D fence_info->handle->handle;
> >       data->fence_data.offset =3D fence_info->offset * sizeof(uint64_t)=
;
> >   }
> >
> >   drm_public void amdgpu_cs_chunk_fence_to_dep(struct amdgpu_cs_fence
> *fence,
> >                                       struct drm_amdgpu_cs_chunk_dep
> *dep)
> >   {
>
>

--000000000000492023057f05b721
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr">=
On Wed, Jan 9, 2019, 5:28 AM Christian K=C3=B6nig &lt;<a href=3D"mailto:cko=
enig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a> wrote:<=
br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;borde=
r-left:1px #ccc solid;padding-left:1ex">Looks good, but I&#39;m wondering w=
hat&#39;s the actual improvement?<br></blockquote></div></div><div dir=3D"a=
uto"><br></div><div dir=3D"auto">No malloc calls and 1 less for loop copyin=
g the bo list.</div><div dir=3D"auto"><br></div><div dir=3D"auto">Marek</di=
v><div dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_quote">=
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
<br>
Christian.<br>
<br>
Am 07.01.19 um 20:31 schrieb Marek Ol=C5=A1=C3=A1k:<br>
&gt; From: Marek Ol=C5=A1=C3=A1k &lt;<a href=3D"mailto:marek.olsak-5C7GfCeVMHo@public.gmane.org"=
 target=3D"_blank" rel=3D"noreferrer">marek.olsak-5C7GfCeVMHo@public.gmane.org</a>&gt;<br>
&gt;<br>
&gt; ---<br>
&gt;=C2=A0 =C2=A0amdgpu/amdgpu-symbol-check |=C2=A0 3 ++<br>
&gt;=C2=A0 =C2=A0amdgpu/amdgpu.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=
 56 +++++++++++++++++++++++++++++++++++++-<br>
&gt;=C2=A0 =C2=A0amdgpu/amdgpu_bo.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 36 +=
+++++++++++++++++++++++<br>
&gt;=C2=A0 =C2=A0amdgpu/amdgpu_cs.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 25 +=
++++++++++++++++<br>
&gt;=C2=A0 =C2=A04 files changed, 119 insertions(+), 1 deletion(-)<br>
&gt;<br>
&gt; diff --git a/amdgpu/amdgpu-symbol-check b/amdgpu/amdgpu-symbol-check<b=
r>
&gt; index 6f5e0f95..96a44b40 100755<br>
&gt; --- a/amdgpu/amdgpu-symbol-check<br>
&gt; +++ b/amdgpu/amdgpu-symbol-check<br>
&gt; @@ -12,20 +12,22 @@ _edata<br>
&gt;=C2=A0 =C2=A0_end<br>
&gt;=C2=A0 =C2=A0_fini<br>
&gt;=C2=A0 =C2=A0_init<br>
&gt;=C2=A0 =C2=A0amdgpu_bo_alloc<br>
&gt;=C2=A0 =C2=A0amdgpu_bo_cpu_map<br>
&gt;=C2=A0 =C2=A0amdgpu_bo_cpu_unmap<br>
&gt;=C2=A0 =C2=A0amdgpu_bo_export<br>
&gt;=C2=A0 =C2=A0amdgpu_bo_free<br>
&gt;=C2=A0 =C2=A0amdgpu_bo_import<br>
&gt;=C2=A0 =C2=A0amdgpu_bo_inc_ref<br>
&gt; +amdgpu_bo_list_create_raw<br>
&gt; +amdgpu_bo_list_destroy_raw<br>
&gt;=C2=A0 =C2=A0amdgpu_bo_list_create<br>
&gt;=C2=A0 =C2=A0amdgpu_bo_list_destroy<br>
&gt;=C2=A0 =C2=A0amdgpu_bo_list_update<br>
&gt;=C2=A0 =C2=A0amdgpu_bo_query_info<br>
&gt;=C2=A0 =C2=A0amdgpu_bo_set_metadata<br>
&gt;=C2=A0 =C2=A0amdgpu_bo_va_op<br>
&gt;=C2=A0 =C2=A0amdgpu_bo_va_op_raw<br>
&gt;=C2=A0 =C2=A0amdgpu_bo_wait_for_idle<br>
&gt;=C2=A0 =C2=A0amdgpu_create_bo_from_user_mem<br>
&gt;=C2=A0 =C2=A0amdgpu_cs_chunk_fence_info_to_data<br>
&gt; @@ -40,20 +42,21 @@ amdgpu_cs_destroy_semaphore<br>
&gt;=C2=A0 =C2=A0amdgpu_cs_destroy_syncobj<br>
&gt;=C2=A0 =C2=A0amdgpu_cs_export_syncobj<br>
&gt;=C2=A0 =C2=A0amdgpu_cs_fence_to_handle<br>
&gt;=C2=A0 =C2=A0amdgpu_cs_import_syncobj<br>
&gt;=C2=A0 =C2=A0amdgpu_cs_query_fence_status<br>
&gt;=C2=A0 =C2=A0amdgpu_cs_query_reset_state<br>
&gt;=C2=A0 =C2=A0amdgpu_query_sw_info<br>
&gt;=C2=A0 =C2=A0amdgpu_cs_signal_semaphore<br>
&gt;=C2=A0 =C2=A0amdgpu_cs_submit<br>
&gt;=C2=A0 =C2=A0amdgpu_cs_submit_raw<br>
&gt; +amdgpu_cs_submit_raw2<br>
&gt;=C2=A0 =C2=A0amdgpu_cs_syncobj_export_sync_file<br>
&gt;=C2=A0 =C2=A0amdgpu_cs_syncobj_import_sync_file<br>
&gt;=C2=A0 =C2=A0amdgpu_cs_syncobj_reset<br>
&gt;=C2=A0 =C2=A0amdgpu_cs_syncobj_signal<br>
&gt;=C2=A0 =C2=A0amdgpu_cs_syncobj_wait<br>
&gt;=C2=A0 =C2=A0amdgpu_cs_wait_fences<br>
&gt;=C2=A0 =C2=A0amdgpu_cs_wait_semaphore<br>
&gt;=C2=A0 =C2=A0amdgpu_device_deinitialize<br>
&gt;=C2=A0 =C2=A0amdgpu_device_initialize<br>
&gt;=C2=A0 =C2=A0amdgpu_find_bo_by_cpu_mapping<br>
&gt; diff --git a/amdgpu/amdgpu.h b/amdgpu/amdgpu.h<br>
&gt; index dc51659a..5b800033 100644<br>
&gt; --- a/amdgpu/amdgpu.h<br>
&gt; +++ b/amdgpu/amdgpu.h<br>
&gt; @@ -35,20 +35,21 @@<br>
&gt;=C2=A0 =C2=A0#define _AMDGPU_H_<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0#include &lt;stdint.h&gt;<br>
&gt;=C2=A0 =C2=A0#include &lt;stdbool.h&gt;<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0#ifdef __cplusplus<br>
&gt;=C2=A0 =C2=A0extern &quot;C&quot; {<br>
&gt;=C2=A0 =C2=A0#endif<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0struct drm_amdgpu_info_hw_ip;<br>
&gt; +struct drm_amdgpu_bo_list_entry;<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0/*--------------------------------------------------------=
------------------*/<br>
&gt;=C2=A0 =C2=A0/* --------------------------- Defines -------------------=
----------------- */<br>
&gt;=C2=A0 =C2=A0/*--------------------------------------------------------=
------------------*/<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0/**<br>
&gt;=C2=A0 =C2=A0 * Define max. number of Command Buffers (IB) which could =
be sent to the single<br>
&gt;=C2=A0 =C2=A0 * hardware IP to accommodate CE/DE requirements<br>
&gt;=C2=A0 =C2=A0 *<br>
&gt;=C2=A0 =C2=A0 * \sa amdgpu_cs_ib_info<br>
&gt; @@ -767,34 +768,65 @@ int amdgpu_bo_cpu_unmap(amdgpu_bo_handle buf_han=
dle);<br>
&gt;=C2=A0 =C2=A0 *=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 and no GPU access is scheduled.<b=
r>
&gt;=C2=A0 =C2=A0 *=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 1 GPU access is in fly or scheduled<br>
&gt;=C2=A0 =C2=A0 *<br>
&gt;=C2=A0 =C2=A0 * \return=C2=A0 =C2=A00 - on success<br>
&gt;=C2=A0 =C2=A0 *=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;0 - Negative POSI=
X Error code<br>
&gt;=C2=A0 =C2=A0 */<br>
&gt;=C2=A0 =C2=A0int amdgpu_bo_wait_for_idle(amdgpu_bo_handle buf_handle,<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0uint64_t timeout_ns,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0bool *buffer_busy);<br>
&gt;=C2=A0 =C2=A0<br>
&gt; +/**<br>
&gt; + * Creates a BO list handle for command submission.<br>
&gt; + *<br>
&gt; + * \param=C2=A0 =C2=A0dev=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 - \c [in] Device handle.<br>
&gt; + *=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 See #amdgpu_device_initialize()<br>
&gt; + * \param=C2=A0 =C2=A0number_of_buffers=C2=A0 =C2=A0 =C2=A0 =C2=A0 - =
\c [in] Number of BOs in the list<br>
&gt; + * \param=C2=A0 =C2=A0buffers=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 - \c =
[in] List of BO handles<br>
&gt; + * \param=C2=A0 =C2=A0result=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
- \c [out] Created BO list handle<br>
&gt; + *<br>
&gt; + * \return=C2=A0 =C2=A00 on success\n<br>
&gt; + *=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;0 - Negative POSIX Error cod=
e<br>
&gt; + *<br>
&gt; + * \sa amdgpu_bo_list_destroy_raw()<br>
&gt; +*/<br>
&gt; +int amdgpu_bo_list_create_raw(amdgpu_device_handle dev,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t number_of_buffers,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct drm_amdgpu_bo_list_entry *buffers,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t *result);<br>
&gt; +<br>
&gt; +/**<br>
&gt; + * Destroys a BO list handle.<br>
&gt; + *<br>
&gt; + * \param=C2=A0 =C2=A0bo_list=C2=A0 - \c [in] BO list handle.<br>
&gt; + *<br>
&gt; + * \return=C2=A0 =C2=A00 on success\n<br>
&gt; + *=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;0 - Negative POSIX Error cod=
e<br>
&gt; + *<br>
&gt; + * \sa amdgpu_bo_list_create_raw(), amdgpu_cs_submit_raw2()<br>
&gt; +*/<br>
&gt; +int amdgpu_bo_list_destroy_raw(amdgpu_device_handle dev, uint32_t bo_=
list);<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0/**<br>
&gt;=C2=A0 =C2=A0 * Creates a BO list handle for command submission.<br>
&gt;=C2=A0 =C2=A0 *<br>
&gt;=C2=A0 =C2=A0 * \param=C2=A0 =C2=A0dev=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0- \c [in] Device handle.<br>
&gt;=C2=A0 =C2=A0 *=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0See #amdgpu_device_initiali=
ze()<br>
&gt;=C2=A0 =C2=A0 * \param=C2=A0 =C2=A0number_of_resources=C2=A0 =C2=A0 =C2=
=A0- \c [in] Number of BOs in the list<br>
&gt;=C2=A0 =C2=A0 * \param=C2=A0 =C2=A0resources=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0- \c [in] List of BO handles<br>
&gt;=C2=A0 =C2=A0 * \param=C2=A0 =C2=A0resource_prios=C2=A0 - \c [in] Optio=
nal priority for each handle<br>
&gt;=C2=A0 =C2=A0 * \param=C2=A0 =C2=A0result=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 - \c [out] Created BO list handle<br>
&gt;=C2=A0 =C2=A0 *<br>
&gt;=C2=A0 =C2=A0 * \return=C2=A0 =C2=A00 on success\n<br>
&gt;=C2=A0 =C2=A0 *=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;0 - Negative POSI=
X Error code<br>
&gt;=C2=A0 =C2=A0 *<br>
&gt; - * \sa amdgpu_bo_list_destroy()<br>
&gt; + * \sa amdgpu_bo_list_destroy(), amdgpu_cs_submit_raw2()<br>
&gt;=C2=A0 =C2=A0*/<br>
&gt;=C2=A0 =C2=A0int amdgpu_bo_list_create(amdgpu_device_handle dev,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0uint32_t number_of_resources,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0amdgpu_bo_handle *resources,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0uint8_t *resource_prios,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0amdgpu_bo_list_handle *result);<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0/**<br>
&gt;=C2=A0 =C2=A0 * Destroys a BO list handle.<br>
&gt;=C2=A0 =C2=A0 *<br>
&gt; @@ -1580,20 +1612,42 @@ struct drm_amdgpu_cs_chunk;<br>
&gt;=C2=A0 =C2=A0struct drm_amdgpu_cs_chunk_dep;<br>
&gt;=C2=A0 =C2=A0struct drm_amdgpu_cs_chunk_data;<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0int amdgpu_cs_submit_raw(amdgpu_device_handle dev,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 amdgpu_context_handle context,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 amdgpu_bo_list_handle bo_list_handle,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 int num_chunks,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 struct drm_amdgpu_cs_chunk *chunks,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 uint64_t *seq_no);<br>
&gt;=C2=A0 =C2=A0<br>
&gt; +/**<br>
&gt; + * Submit raw command submission to the kernel with a raw BO list han=
dle.<br>
&gt; + *<br>
&gt; + * \param=C2=A0 =C2=A0dev=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0- \c [in] device handle<br>
&gt; + * \param=C2=A0 =C2=A0context=C2=A0 =C2=A0 - \c [in] context handle f=
or context id<br>
&gt; + * \param=C2=A0 =C2=A0bo_list_handle - \c [in] raw bo list handle (0 =
for none)<br>
&gt; + * \param=C2=A0 =C2=A0num_chunks - \c [in] number of CS chunks to sub=
mit<br>
&gt; + * \param=C2=A0 =C2=A0chunks=C2=A0 =C2=A0 =C2=A0- \c [in] array of CS=
 chunks<br>
&gt; + * \param=C2=A0 =C2=A0seq_no=C2=A0 =C2=A0 =C2=A0- \c [out] output seq=
uence number for submission.<br>
&gt; + *<br>
&gt; + * \return=C2=A0 =C2=A00 on success\n<br>
&gt; + *=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;0 - Negative POSIX Error cod=
e<br>
&gt; + *<br>
&gt; + * \sa amdgpu_bo_list_create_raw(), amdgpu_bo_list_destroy_raw()<br>
&gt; + */<br>
&gt; +int amdgpu_cs_submit_raw2(amdgpu_device_handle dev,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0amdgpu_context_handle context,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0uint32_t bo_list_handle,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0int num_chunks,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0struct drm_amdgpu_cs_chunk *chunks,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0uint64_t *seq_no);<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0void amdgpu_cs_chunk_fence_to_dep(struct amdgpu_cs_fence *=
fence,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct drm_amdgpu_cs_chunk_=
dep *dep);<br>
&gt;=C2=A0 =C2=A0void amdgpu_cs_chunk_fence_info_to_data(struct amdgpu_cs_f=
ence_info *fence_info,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct=
 drm_amdgpu_cs_chunk_data *data);<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0/**<br>
&gt;=C2=A0 =C2=A0 * Reserve VMID<br>
&gt;=C2=A0 =C2=A0 * \param=C2=A0 =C2=A0context - \c [in]=C2=A0 GPU Context<=
br>
&gt;=C2=A0 =C2=A0 * \param=C2=A0 =C2=A0flags - \c [in]=C2=A0 TBD<br>
&gt;=C2=A0 =C2=A0 *<br>
&gt; diff --git a/amdgpu/amdgpu_bo.c b/amdgpu/amdgpu_bo.c<br>
&gt; index c0f42e81..21bc73aa 100644<br>
&gt; --- a/amdgpu/amdgpu_bo.c<br>
&gt; +++ b/amdgpu/amdgpu_bo.c<br>
&gt; @@ -611,20 +611,56 @@ drm_public int amdgpu_create_bo_from_user_mem(am=
dgpu_device_handle dev,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0pthread_mutex_lock(&amp;dev-&gt;bo_table_mut=
ex);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0r =3D handle_table_insert(&amp;dev-&gt;bo_ha=
ndles, (*buf_handle)-&gt;handle,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*buf_handle);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0pthread_mutex_unlock(&amp;dev-&gt;bo_table_m=
utex);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (r)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0amdgpu_bo_free(*=
buf_handle);<br>
&gt;=C2=A0 =C2=A0out:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0return r;<br>
&gt;=C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0<br>
&gt; +drm_public int amdgpu_bo_list_create_raw(amdgpu_device_handle dev,<br=
>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint32_t nu=
mber_of_buffers,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct drm_=
amdgpu_bo_list_entry *buffers,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint32_t *r=
esult)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0union drm_amdgpu_bo_list args;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0int r;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0memset(&amp;args, 0, sizeof(args));<br>
&gt; +=C2=A0 =C2=A0 =C2=A0args.in.operation =3D AMDGPU_BO_LIST_OP_CREATE;<b=
r>
&gt; +=C2=A0 =C2=A0 =C2=A0args.in.bo_number =3D number_of_buffers;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0args.in.bo_info_size =3D sizeof(struct drm_amdgpu=
_bo_list_entry);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0args.in.bo_info_ptr =3D (uint64_t)(uintptr_t)buff=
ers;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0r =3D drmCommandWriteRead(dev-&gt;fd, DRM_AMDGPU_=
BO_LIST,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;args, sizeof(args));<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (r)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return r;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0*result =3D args.out.list_handle;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0return 0;<br>
&gt; +}<br>
&gt; +<br>
&gt; +drm_public int amdgpu_bo_list_destroy_raw(amdgpu_device_handle dev,<b=
r>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint3=
2_t bo_list)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0union drm_amdgpu_bo_list args;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0memset(&amp;args, 0, sizeof(args));<br>
&gt; +=C2=A0 =C2=A0 =C2=A0args.in.operation =3D AMDGPU_BO_LIST_OP_DESTROY;<=
br>
&gt; +=C2=A0 =C2=A0 =C2=A0args.in.list_handle =3D bo_list;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0return drmCommandWriteRead(dev-&gt;fd, DRM_AMDGPU=
_BO_LIST,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;args, sizeof(args));<br>
&gt; +}<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0drm_public int amdgpu_bo_list_create(amdgpu_device_handle =
dev,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint32_t number_of_=
resources,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 amdgpu_bo_handle *r=
esources,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint8_t *resource_p=
rios,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 amdgpu_bo_list_hand=
le *result)<br>
&gt;=C2=A0 =C2=A0{<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0struct drm_amdgpu_bo_list_entry *list;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0union drm_amdgpu_bo_list args;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned i;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0int r;<br>
&gt; diff --git a/amdgpu/amdgpu_cs.c b/amdgpu/amdgpu_cs.c<br>
&gt; index 3b8231aa..5bedf748 100644<br>
&gt; --- a/amdgpu/amdgpu_cs.c<br>
&gt; +++ b/amdgpu/amdgpu_cs.c<br>
&gt; @@ -724,20 +724,45 @@ drm_public int amdgpu_cs_submit_raw(amdgpu_devic=
e_handle dev,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0r =3D drmCommandWriteRead(dev-&gt;fd, DRM_AM=
DGPU_CS,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;cs, sizeof(cs));<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (r)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return r;<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (seq_no)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*seq_no =3D cs.o=
ut.handle;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
&gt;=C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0<br>
&gt; +drm_public int amdgpu_cs_submit_raw2(amdgpu_device_handle dev,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 amdgpu_context_handle con=
text,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint32_t bo_list_handle,<=
br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int num_chunks,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct drm_amdgpu_cs_chun=
k *chunks,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint64_t *seq_no)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0union drm_amdgpu_cs cs =3D {0};<br>
&gt; +=C2=A0 =C2=A0 =C2=A0uint64_t *chunk_array;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0int i, r;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0chunk_array =3D alloca(sizeof(uint64_t) * num_chu=
nks);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0for (i =3D 0; i &lt; num_chunks; i++)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0chunk_array[i] =3D (u=
int64_t)(uintptr_t)&amp;chunks[i];<br>
&gt; +=C2=A0 =C2=A0 =C2=A0cs.in.chunks =3D (uint64_t)(uintptr_t)chunk_array=
;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0cs.in.ctx_id =3D context-&gt;id;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0cs.in.bo_list_handle =3D bo_list_handle;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0cs.in.num_chunks =3D num_chunks;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0r =3D drmCommandWriteRead(dev-&gt;fd, DRM_AMDGPU_=
CS,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;cs, sizeof(cs));<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (!r &amp;&amp; seq_no)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*seq_no =3D cs.out.ha=
ndle;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0return r;<br>
&gt; +}<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0drm_public void amdgpu_cs_chunk_fence_info_to_data(struct =
amdgpu_cs_fence_info *fence_info,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct=
 drm_amdgpu_cs_chunk_data *data)<br>
&gt;=C2=A0 =C2=A0{<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0data-&gt;fence_data.handle =3D fence_info-&g=
t;handle-&gt;handle;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0data-&gt;fence_data.offset =3D fence_info-&g=
t;offset * sizeof(uint64_t);<br>
&gt;=C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0drm_public void amdgpu_cs_chunk_fence_to_dep(struct amdgpu=
_cs_fence *fence,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct=
 drm_amdgpu_cs_chunk_dep *dep)<br>
&gt;=C2=A0 =C2=A0{<br>
<br>
</blockquote></div></div></div>

--000000000000492023057f05b721--

--===============0423776317==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0423776317==--
