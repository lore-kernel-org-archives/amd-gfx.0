From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH libdrm] amdgpu: add a faster BO list API
Date: Wed, 9 Jan 2019 14:08:58 +0100
Message-ID: <513ee137-7e99-c8fc-9e3b-e9077ead60a3@gmail.com>
References: <20190107193104.4361-1-maraeo@gmail.com>
 <a0a15ed6-eb1a-fbbe-7c1b-e3b9a64c1008@gmail.com>
 <CAAxE2A5M2WW6uPFo0a=+6ukbtgx5xHfkKUKOB9dgtB=qH88htQ@mail.gmail.com>
Reply-To: christian.koenig-5C7GfCeVMHo@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1199913667=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CAAxE2A5M2WW6uPFo0a=+6ukbtgx5xHfkKUKOB9dgtB=qH88htQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
To: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>
Cc: amd-gfx mailing list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

This is a multi-part message in MIME format.
--===============1199913667==
Content-Type: multipart/alternative;
 boundary="------------A3EF581148CEFE578928D9C5"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------A3EF581148CEFE578928D9C5
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 09.01.19 um 13:36 schrieb Marek Olšák:
>
>
> On Wed, Jan 9, 2019, 5:28 AM Christian König 
> <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org 
> <mailto:ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
>
>     Looks good, but I'm wondering what's the actual improvement?
>
>
> No malloc calls and 1 less for loop copying the bo list.

Yeah, but didn't we want to get completely rid of the bo list?

Christian.

>
> Marek
>
>
>     Christian.
>
>     Am 07.01.19 um 20:31 schrieb Marek Olšák:
>     > From: Marek Olšák <marek.olsak-5C7GfCeVMHo@public.gmane.org <mailto:marek.olsak-5C7GfCeVMHo@public.gmane.org>>
>     >
>     > ---
>     >   amdgpu/amdgpu-symbol-check |  3 ++
>     >   amdgpu/amdgpu.h            | 56
>     +++++++++++++++++++++++++++++++++++++-
>     >   amdgpu/amdgpu_bo.c         | 36 ++++++++++++++++++++++++
>     >   amdgpu/amdgpu_cs.c         | 25 +++++++++++++++++
>     >   4 files changed, 119 insertions(+), 1 deletion(-)
>     >
>     > diff --git a/amdgpu/amdgpu-symbol-check b/amdgpu/amdgpu-symbol-check
>     > index 6f5e0f95..96a44b40 100755
>     > --- a/amdgpu/amdgpu-symbol-check
>     > +++ b/amdgpu/amdgpu-symbol-check
>     > @@ -12,20 +12,22 @@ _edata
>     >   _end
>     >   _fini
>     >   _init
>     >   amdgpu_bo_alloc
>     >   amdgpu_bo_cpu_map
>     >   amdgpu_bo_cpu_unmap
>     >   amdgpu_bo_export
>     >   amdgpu_bo_free
>     >   amdgpu_bo_import
>     >   amdgpu_bo_inc_ref
>     > +amdgpu_bo_list_create_raw
>     > +amdgpu_bo_list_destroy_raw
>     >   amdgpu_bo_list_create
>     >   amdgpu_bo_list_destroy
>     >   amdgpu_bo_list_update
>     >   amdgpu_bo_query_info
>     >   amdgpu_bo_set_metadata
>     >   amdgpu_bo_va_op
>     >   amdgpu_bo_va_op_raw
>     >   amdgpu_bo_wait_for_idle
>     >   amdgpu_create_bo_from_user_mem
>     >   amdgpu_cs_chunk_fence_info_to_data
>     > @@ -40,20 +42,21 @@ amdgpu_cs_destroy_semaphore
>     >   amdgpu_cs_destroy_syncobj
>     >   amdgpu_cs_export_syncobj
>     >   amdgpu_cs_fence_to_handle
>     >   amdgpu_cs_import_syncobj
>     >   amdgpu_cs_query_fence_status
>     >   amdgpu_cs_query_reset_state
>     >   amdgpu_query_sw_info
>     >   amdgpu_cs_signal_semaphore
>     >   amdgpu_cs_submit
>     >   amdgpu_cs_submit_raw
>     > +amdgpu_cs_submit_raw2
>     >   amdgpu_cs_syncobj_export_sync_file
>     >   amdgpu_cs_syncobj_import_sync_file
>     >   amdgpu_cs_syncobj_reset
>     >   amdgpu_cs_syncobj_signal
>     >   amdgpu_cs_syncobj_wait
>     >   amdgpu_cs_wait_fences
>     >   amdgpu_cs_wait_semaphore
>     >   amdgpu_device_deinitialize
>     >   amdgpu_device_initialize
>     >   amdgpu_find_bo_by_cpu_mapping
>     > diff --git a/amdgpu/amdgpu.h b/amdgpu/amdgpu.h
>     > index dc51659a..5b800033 100644
>     > --- a/amdgpu/amdgpu.h
>     > +++ b/amdgpu/amdgpu.h
>     > @@ -35,20 +35,21 @@
>     >   #define _AMDGPU_H_
>     >
>     >   #include <stdint.h>
>     >   #include <stdbool.h>
>     >
>     >   #ifdef __cplusplus
>     >   extern "C" {
>     >   #endif
>     >
>     >   struct drm_amdgpu_info_hw_ip;
>     > +struct drm_amdgpu_bo_list_entry;
>     >
>     >
>      /*--------------------------------------------------------------------------*/
>     >   /* --------------------------- Defines
>     ------------------------------------ */
>     >
>      /*--------------------------------------------------------------------------*/
>     >
>     >   /**
>     >    * Define max. number of Command Buffers (IB) which could be
>     sent to the single
>     >    * hardware IP to accommodate CE/DE requirements
>     >    *
>     >    * \sa amdgpu_cs_ib_info
>     > @@ -767,34 +768,65 @@ int amdgpu_bo_cpu_unmap(amdgpu_bo_handle
>     buf_handle);
>     >    *                            and no GPU access is scheduled.
>     >    *                          1 GPU access is in fly or scheduled
>     >    *
>     >    * \return   0 - on success
>     >    *          <0 - Negative POSIX Error code
>     >    */
>     >   int amdgpu_bo_wait_for_idle(amdgpu_bo_handle buf_handle,
>     >                           uint64_t timeout_ns,
>     >                           bool *buffer_busy);
>     >
>     > +/**
>     > + * Creates a BO list handle for command submission.
>     > + *
>     > + * \param   dev                      - \c [in] Device handle.
>     > + *                              See #amdgpu_device_initialize()
>     > + * \param   number_of_buffers        - \c [in] Number of BOs in
>     the list
>     > + * \param   buffers          - \c [in] List of BO handles
>     > + * \param   result           - \c [out] Created BO list handle
>     > + *
>     > + * \return   0 on success\n
>     > + *          <0 - Negative POSIX Error code
>     > + *
>     > + * \sa amdgpu_bo_list_destroy_raw()
>     > +*/
>     > +int amdgpu_bo_list_create_raw(amdgpu_device_handle dev,
>     > +                           uint32_t number_of_buffers,
>     > +                           struct drm_amdgpu_bo_list_entry
>     *buffers,
>     > +                           uint32_t *result);
>     > +
>     > +/**
>     > + * Destroys a BO list handle.
>     > + *
>     > + * \param   bo_list  - \c [in] BO list handle.
>     > + *
>     > + * \return   0 on success\n
>     > + *          <0 - Negative POSIX Error code
>     > + *
>     > + * \sa amdgpu_bo_list_create_raw(), amdgpu_cs_submit_raw2()
>     > +*/
>     > +int amdgpu_bo_list_destroy_raw(amdgpu_device_handle dev,
>     uint32_t bo_list);
>     > +
>     >   /**
>     >    * Creates a BO list handle for command submission.
>     >    *
>     >    * \param   dev                     - \c [in] Device handle.
>     >    *                             See #amdgpu_device_initialize()
>     >    * \param   number_of_resources     - \c [in] Number of BOs in
>     the list
>     >    * \param   resources               - \c [in] List of BO handles
>     >    * \param   resource_prios  - \c [in] Optional priority for
>     each handle
>     >    * \param   result          - \c [out] Created BO list handle
>     >    *
>     >    * \return   0 on success\n
>     >    *          <0 - Negative POSIX Error code
>     >    *
>     > - * \sa amdgpu_bo_list_destroy()
>     > + * \sa amdgpu_bo_list_destroy(), amdgpu_cs_submit_raw2()
>     >   */
>     >   int amdgpu_bo_list_create(amdgpu_device_handle dev,
>     >                         uint32_t number_of_resources,
>     >                         amdgpu_bo_handle *resources,
>     >                         uint8_t *resource_prios,
>     >                         amdgpu_bo_list_handle *result);
>     >
>     >   /**
>     >    * Destroys a BO list handle.
>     >    *
>     > @@ -1580,20 +1612,42 @@ struct drm_amdgpu_cs_chunk;
>     >   struct drm_amdgpu_cs_chunk_dep;
>     >   struct drm_amdgpu_cs_chunk_data;
>     >
>     >   int amdgpu_cs_submit_raw(amdgpu_device_handle dev,
>     >                        amdgpu_context_handle context,
>     >                        amdgpu_bo_list_handle bo_list_handle,
>     >                        int num_chunks,
>     >                        struct drm_amdgpu_cs_chunk *chunks,
>     >                        uint64_t *seq_no);
>     >
>     > +/**
>     > + * Submit raw command submission to the kernel with a raw BO
>     list handle.
>     > + *
>     > + * \param   dev             - \c [in] device handle
>     > + * \param   context    - \c [in] context handle for context id
>     > + * \param   bo_list_handle - \c [in] raw bo list handle (0 for
>     none)
>     > + * \param   num_chunks - \c [in] number of CS chunks to submit
>     > + * \param   chunks     - \c [in] array of CS chunks
>     > + * \param   seq_no     - \c [out] output sequence number for
>     submission.
>     > + *
>     > + * \return   0 on success\n
>     > + *          <0 - Negative POSIX Error code
>     > + *
>     > + * \sa amdgpu_bo_list_create_raw(), amdgpu_bo_list_destroy_raw()
>     > + */
>     > +int amdgpu_cs_submit_raw2(amdgpu_device_handle dev,
>     > +                       amdgpu_context_handle context,
>     > +                       uint32_t bo_list_handle,
>     > +                       int num_chunks,
>     > +                       struct drm_amdgpu_cs_chunk *chunks,
>     > +                       uint64_t *seq_no);
>     > +
>     >   void amdgpu_cs_chunk_fence_to_dep(struct amdgpu_cs_fence *fence,
>     >                                 struct drm_amdgpu_cs_chunk_dep
>     *dep);
>     >   void amdgpu_cs_chunk_fence_info_to_data(struct
>     amdgpu_cs_fence_info *fence_info,
>     >                                       struct
>     drm_amdgpu_cs_chunk_data *data);
>     >
>     >   /**
>     >    * Reserve VMID
>     >    * \param   context - \c [in]  GPU Context
>     >    * \param   flags - \c [in]  TBD
>     >    *
>     > diff --git a/amdgpu/amdgpu_bo.c b/amdgpu/amdgpu_bo.c
>     > index c0f42e81..21bc73aa 100644
>     > --- a/amdgpu/amdgpu_bo.c
>     > +++ b/amdgpu/amdgpu_bo.c
>     > @@ -611,20 +611,56 @@ drm_public int
>     amdgpu_create_bo_from_user_mem(amdgpu_device_handle dev,
>     >  pthread_mutex_lock(&dev->bo_table_mutex);
>     >       r = handle_table_insert(&dev->bo_handles,
>     (*buf_handle)->handle,
>     >                               *buf_handle);
>     >  pthread_mutex_unlock(&dev->bo_table_mutex);
>     >       if (r)
>     >               amdgpu_bo_free(*buf_handle);
>     >   out:
>     >       return r;
>     >   }
>     >
>     > +drm_public int amdgpu_bo_list_create_raw(amdgpu_device_handle dev,
>     > +                                      uint32_t number_of_buffers,
>     > +                                      struct
>     drm_amdgpu_bo_list_entry *buffers,
>     > +                                      uint32_t *result)
>     > +{
>     > +     union drm_amdgpu_bo_list args;
>     > +     int r;
>     > +
>     > +     memset(&args, 0, sizeof(args));
>     > +     args.in.operation = AMDGPU_BO_LIST_OP_CREATE;
>     > +     args.in.bo_number = number_of_buffers;
>     > +     args.in.bo_info_size = sizeof(struct
>     drm_amdgpu_bo_list_entry);
>     > +     args.in.bo_info_ptr = (uint64_t)(uintptr_t)buffers;
>     > +
>     > +     r = drmCommandWriteRead(dev->fd, DRM_AMDGPU_BO_LIST,
>     > +                             &args, sizeof(args));
>     > +     if (r)
>     > +             return r;
>     > +
>     > +     *result = args.out.list_handle;
>     > +     return 0;
>     > +}
>     > +
>     > +drm_public int amdgpu_bo_list_destroy_raw(amdgpu_device_handle dev,
>     > +                                       uint32_t bo_list)
>     > +{
>     > +     union drm_amdgpu_bo_list args;
>     > +
>     > +     memset(&args, 0, sizeof(args));
>     > +     args.in.operation = AMDGPU_BO_LIST_OP_DESTROY;
>     > +     args.in.list_handle = bo_list;
>     > +
>     > +     return drmCommandWriteRead(dev->fd, DRM_AMDGPU_BO_LIST,
>     > +                                &args, sizeof(args));
>     > +}
>     > +
>     >   drm_public int amdgpu_bo_list_create(amdgpu_device_handle dev,
>     >                                    uint32_t number_of_resources,
>     >                                    amdgpu_bo_handle *resources,
>     >                                    uint8_t *resource_prios,
>     > amdgpu_bo_list_handle *result)
>     >   {
>     >       struct drm_amdgpu_bo_list_entry *list;
>     >       union drm_amdgpu_bo_list args;
>     >       unsigned i;
>     >       int r;
>     > diff --git a/amdgpu/amdgpu_cs.c b/amdgpu/amdgpu_cs.c
>     > index 3b8231aa..5bedf748 100644
>     > --- a/amdgpu/amdgpu_cs.c
>     > +++ b/amdgpu/amdgpu_cs.c
>     > @@ -724,20 +724,45 @@ drm_public int
>     amdgpu_cs_submit_raw(amdgpu_device_handle dev,
>     >       r = drmCommandWriteRead(dev->fd, DRM_AMDGPU_CS,
>     >                               &cs, sizeof(cs));
>     >       if (r)
>     >               return r;
>     >
>     >       if (seq_no)
>     >               *seq_no = cs.out.handle;
>     >       return 0;
>     >   }
>     >
>     > +drm_public int amdgpu_cs_submit_raw2(amdgpu_device_handle dev,
>     > + amdgpu_context_handle context,
>     > +                                  uint32_t bo_list_handle,
>     > +                                  int num_chunks,
>     > +                                  struct drm_amdgpu_cs_chunk
>     *chunks,
>     > +                                  uint64_t *seq_no)
>     > +{
>     > +     union drm_amdgpu_cs cs = {0};
>     > +     uint64_t *chunk_array;
>     > +     int i, r;
>     > +
>     > +     chunk_array = alloca(sizeof(uint64_t) * num_chunks);
>     > +     for (i = 0; i < num_chunks; i++)
>     > +             chunk_array[i] = (uint64_t)(uintptr_t)&chunks[i];
>     > +     cs.in.chunks = (uint64_t)(uintptr_t)chunk_array;
>     > +     cs.in.ctx_id = context->id;
>     > +     cs.in.bo_list_handle = bo_list_handle;
>     > +     cs.in.num_chunks = num_chunks;
>     > +     r = drmCommandWriteRead(dev->fd, DRM_AMDGPU_CS,
>     > +                             &cs, sizeof(cs));
>     > +     if (!r && seq_no)
>     > +             *seq_no = cs.out.handle;
>     > +     return r;
>     > +}
>     > +
>     >   drm_public void amdgpu_cs_chunk_fence_info_to_data(struct
>     amdgpu_cs_fence_info *fence_info,
>     >                                       struct
>     drm_amdgpu_cs_chunk_data *data)
>     >   {
>     >       data->fence_data.handle = fence_info->handle->handle;
>     >       data->fence_data.offset = fence_info->offset *
>     sizeof(uint64_t);
>     >   }
>     >
>     >   drm_public void amdgpu_cs_chunk_fence_to_dep(struct
>     amdgpu_cs_fence *fence,
>     >                                       struct
>     drm_amdgpu_cs_chunk_dep *dep)
>     >   {
>
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx


--------------A3EF581148CEFE578928D9C5
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <div class="moz-cite-prefix">Am 09.01.19 um 13:36 schrieb Marek
      Olšák:<br>
    </div>
    <blockquote type="cite"
cite="mid:CAAxE2A5M2WW6uPFo0a=+6ukbtgx5xHfkKUKOB9dgtB=qH88htQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org">
      <meta http-equiv="content-type" content="text/html; charset=UTF-8">
      <div dir="auto">
        <div><br>
          <br>
          <div class="gmail_quote">
            <div dir="ltr">On Wed, Jan 9, 2019, 5:28 AM Christian König
              &lt;<a href="mailto:ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org"
                moz-do-not-send="true">ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>
              wrote:<br>
            </div>
            <blockquote class="gmail_quote" style="margin:0 0 0
              .8ex;border-left:1px #ccc solid;padding-left:1ex">Looks
              good, but I'm wondering what's the actual improvement?<br>
            </blockquote>
          </div>
        </div>
        <div dir="auto"><br>
        </div>
        <div dir="auto">No malloc calls and 1 less for loop copying the
          bo list.</div>
      </div>
    </blockquote>
    <br>
    Yeah, but didn't we want to get completely rid of the bo list?<br>
    <br>
    Christian.<br>
    <br>
    <blockquote type="cite"
cite="mid:CAAxE2A5M2WW6uPFo0a=+6ukbtgx5xHfkKUKOB9dgtB=qH88htQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org">
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
              <br>
              Christian.<br>
              <br>
              Am 07.01.19 um 20:31 schrieb Marek Olšák:<br>
              &gt; From: Marek Olšák &lt;<a
                href="mailto:marek.olsak-5C7GfCeVMHo@public.gmane.org" target="_blank"
                rel="noreferrer" moz-do-not-send="true">marek.olsak-5C7GfCeVMHo@public.gmane.org</a>&gt;<br>
              &gt;<br>
              &gt; ---<br>
              &gt;   amdgpu/amdgpu-symbol-check |  3 ++<br>
              &gt;   amdgpu/amdgpu.h            | 56
              +++++++++++++++++++++++++++++++++++++-<br>
              &gt;   amdgpu/amdgpu_bo.c         | 36
              ++++++++++++++++++++++++<br>
              &gt;   amdgpu/amdgpu_cs.c         | 25 +++++++++++++++++<br>
              &gt;   4 files changed, 119 insertions(+), 1 deletion(-)<br>
              &gt;<br>
              &gt; diff --git a/amdgpu/amdgpu-symbol-check
              b/amdgpu/amdgpu-symbol-check<br>
              &gt; index 6f5e0f95..96a44b40 100755<br>
              &gt; --- a/amdgpu/amdgpu-symbol-check<br>
              &gt; +++ b/amdgpu/amdgpu-symbol-check<br>
              &gt; @@ -12,20 +12,22 @@ _edata<br>
              &gt;   _end<br>
              &gt;   _fini<br>
              &gt;   _init<br>
              &gt;   amdgpu_bo_alloc<br>
              &gt;   amdgpu_bo_cpu_map<br>
              &gt;   amdgpu_bo_cpu_unmap<br>
              &gt;   amdgpu_bo_export<br>
              &gt;   amdgpu_bo_free<br>
              &gt;   amdgpu_bo_import<br>
              &gt;   amdgpu_bo_inc_ref<br>
              &gt; +amdgpu_bo_list_create_raw<br>
              &gt; +amdgpu_bo_list_destroy_raw<br>
              &gt;   amdgpu_bo_list_create<br>
              &gt;   amdgpu_bo_list_destroy<br>
              &gt;   amdgpu_bo_list_update<br>
              &gt;   amdgpu_bo_query_info<br>
              &gt;   amdgpu_bo_set_metadata<br>
              &gt;   amdgpu_bo_va_op<br>
              &gt;   amdgpu_bo_va_op_raw<br>
              &gt;   amdgpu_bo_wait_for_idle<br>
              &gt;   amdgpu_create_bo_from_user_mem<br>
              &gt;   amdgpu_cs_chunk_fence_info_to_data<br>
              &gt; @@ -40,20 +42,21 @@ amdgpu_cs_destroy_semaphore<br>
              &gt;   amdgpu_cs_destroy_syncobj<br>
              &gt;   amdgpu_cs_export_syncobj<br>
              &gt;   amdgpu_cs_fence_to_handle<br>
              &gt;   amdgpu_cs_import_syncobj<br>
              &gt;   amdgpu_cs_query_fence_status<br>
              &gt;   amdgpu_cs_query_reset_state<br>
              &gt;   amdgpu_query_sw_info<br>
              &gt;   amdgpu_cs_signal_semaphore<br>
              &gt;   amdgpu_cs_submit<br>
              &gt;   amdgpu_cs_submit_raw<br>
              &gt; +amdgpu_cs_submit_raw2<br>
              &gt;   amdgpu_cs_syncobj_export_sync_file<br>
              &gt;   amdgpu_cs_syncobj_import_sync_file<br>
              &gt;   amdgpu_cs_syncobj_reset<br>
              &gt;   amdgpu_cs_syncobj_signal<br>
              &gt;   amdgpu_cs_syncobj_wait<br>
              &gt;   amdgpu_cs_wait_fences<br>
              &gt;   amdgpu_cs_wait_semaphore<br>
              &gt;   amdgpu_device_deinitialize<br>
              &gt;   amdgpu_device_initialize<br>
              &gt;   amdgpu_find_bo_by_cpu_mapping<br>
              &gt; diff --git a/amdgpu/amdgpu.h b/amdgpu/amdgpu.h<br>
              &gt; index dc51659a..5b800033 100644<br>
              &gt; --- a/amdgpu/amdgpu.h<br>
              &gt; +++ b/amdgpu/amdgpu.h<br>
              &gt; @@ -35,20 +35,21 @@<br>
              &gt;   #define _AMDGPU_H_<br>
              &gt;   <br>
              &gt;   #include &lt;stdint.h&gt;<br>
              &gt;   #include &lt;stdbool.h&gt;<br>
              &gt;   <br>
              &gt;   #ifdef __cplusplus<br>
              &gt;   extern "C" {<br>
              &gt;   #endif<br>
              &gt;   <br>
              &gt;   struct drm_amdgpu_info_hw_ip;<br>
              &gt; +struct drm_amdgpu_bo_list_entry;<br>
              &gt;   <br>
              &gt; 
 /*--------------------------------------------------------------------------*/<br>
              &gt;   /* --------------------------- Defines
              ------------------------------------ */<br>
              &gt; 
 /*--------------------------------------------------------------------------*/<br>
              &gt;   <br>
              &gt;   /**<br>
              &gt;    * Define max. number of Command Buffers (IB) which
              could be sent to the single<br>
              &gt;    * hardware IP to accommodate CE/DE requirements<br>
              &gt;    *<br>
              &gt;    * \sa amdgpu_cs_ib_info<br>
              &gt; @@ -767,34 +768,65 @@ int
              amdgpu_bo_cpu_unmap(amdgpu_bo_handle buf_handle);<br>
              &gt;    *                            and no GPU access is
              scheduled.<br>
              &gt;    *                          1 GPU access is in fly
              or scheduled<br>
              &gt;    *<br>
              &gt;    * \return   0 - on success<br>
              &gt;    *          &lt;0 - Negative POSIX Error code<br>
              &gt;    */<br>
              &gt;   int amdgpu_bo_wait_for_idle(amdgpu_bo_handle
              buf_handle,<br>
              &gt;                           uint64_t timeout_ns,<br>
              &gt;                           bool *buffer_busy);<br>
              &gt;   <br>
              &gt; +/**<br>
              &gt; + * Creates a BO list handle for command submission.<br>
              &gt; + *<br>
              &gt; + * \param   dev                      - \c [in]
              Device handle.<br>
              &gt; + *                              See
              #amdgpu_device_initialize()<br>
              &gt; + * \param   number_of_buffers        - \c [in]
              Number of BOs in the list<br>
              &gt; + * \param   buffers          - \c [in] List of BO
              handles<br>
              &gt; + * \param   result           - \c [out] Created BO
              list handle<br>
              &gt; + *<br>
              &gt; + * \return   0 on success\n<br>
              &gt; + *          &lt;0 - Negative POSIX Error code<br>
              &gt; + *<br>
              &gt; + * \sa amdgpu_bo_list_destroy_raw()<br>
              &gt; +*/<br>
              &gt; +int amdgpu_bo_list_create_raw(amdgpu_device_handle
              dev,<br>
              &gt; +                           uint32_t
              number_of_buffers,<br>
              &gt; +                           struct
              drm_amdgpu_bo_list_entry *buffers,<br>
              &gt; +                           uint32_t *result);<br>
              &gt; +<br>
              &gt; +/**<br>
              &gt; + * Destroys a BO list handle.<br>
              &gt; + *<br>
              &gt; + * \param   bo_list  - \c [in] BO list handle.<br>
              &gt; + *<br>
              &gt; + * \return   0 on success\n<br>
              &gt; + *          &lt;0 - Negative POSIX Error code<br>
              &gt; + *<br>
              &gt; + * \sa amdgpu_bo_list_create_raw(),
              amdgpu_cs_submit_raw2()<br>
              &gt; +*/<br>
              &gt; +int amdgpu_bo_list_destroy_raw(amdgpu_device_handle
              dev, uint32_t bo_list);<br>
              &gt; +<br>
              &gt;   /**<br>
              &gt;    * Creates a BO list handle for command submission.<br>
              &gt;    *<br>
              &gt;    * \param   dev                     - \c [in]
              Device handle.<br>
              &gt;    *                             See
              #amdgpu_device_initialize()<br>
              &gt;    * \param   number_of_resources     - \c [in]
              Number of BOs in the list<br>
              &gt;    * \param   resources               - \c [in] List
              of BO handles<br>
              &gt;    * \param   resource_prios  - \c [in] Optional
              priority for each handle<br>
              &gt;    * \param   result          - \c [out] Created BO
              list handle<br>
              &gt;    *<br>
              &gt;    * \return   0 on success\n<br>
              &gt;    *          &lt;0 - Negative POSIX Error code<br>
              &gt;    *<br>
              &gt; - * \sa amdgpu_bo_list_destroy()<br>
              &gt; + * \sa amdgpu_bo_list_destroy(),
              amdgpu_cs_submit_raw2()<br>
              &gt;   */<br>
              &gt;   int amdgpu_bo_list_create(amdgpu_device_handle dev,<br>
              &gt;                         uint32_t number_of_resources,<br>
              &gt;                         amdgpu_bo_handle *resources,<br>
              &gt;                         uint8_t *resource_prios,<br>
              &gt;                         amdgpu_bo_list_handle
              *result);<br>
              &gt;   <br>
              &gt;   /**<br>
              &gt;    * Destroys a BO list handle.<br>
              &gt;    *<br>
              &gt; @@ -1580,20 +1612,42 @@ struct drm_amdgpu_cs_chunk;<br>
              &gt;   struct drm_amdgpu_cs_chunk_dep;<br>
              &gt;   struct drm_amdgpu_cs_chunk_data;<br>
              &gt;   <br>
              &gt;   int amdgpu_cs_submit_raw(amdgpu_device_handle dev,<br>
              &gt;                        amdgpu_context_handle context,<br>
              &gt;                        amdgpu_bo_list_handle
              bo_list_handle,<br>
              &gt;                        int num_chunks,<br>
              &gt;                        struct drm_amdgpu_cs_chunk
              *chunks,<br>
              &gt;                        uint64_t *seq_no);<br>
              &gt;   <br>
              &gt; +/**<br>
              &gt; + * Submit raw command submission to the kernel with
              a raw BO list handle.<br>
              &gt; + *<br>
              &gt; + * \param   dev             - \c [in] device handle<br>
              &gt; + * \param   context    - \c [in] context handle for
              context id<br>
              &gt; + * \param   bo_list_handle - \c [in] raw bo list
              handle (0 for none)<br>
              &gt; + * \param   num_chunks - \c [in] number of CS chunks
              to submit<br>
              &gt; + * \param   chunks     - \c [in] array of CS chunks<br>
              &gt; + * \param   seq_no     - \c [out] output sequence
              number for submission.<br>
              &gt; + *<br>
              &gt; + * \return   0 on success\n<br>
              &gt; + *          &lt;0 - Negative POSIX Error code<br>
              &gt; + *<br>
              &gt; + * \sa amdgpu_bo_list_create_raw(),
              amdgpu_bo_list_destroy_raw()<br>
              &gt; + */<br>
              &gt; +int amdgpu_cs_submit_raw2(amdgpu_device_handle dev,<br>
              &gt; +                       amdgpu_context_handle
              context,<br>
              &gt; +                       uint32_t bo_list_handle,<br>
              &gt; +                       int num_chunks,<br>
              &gt; +                       struct drm_amdgpu_cs_chunk
              *chunks,<br>
              &gt; +                       uint64_t *seq_no);<br>
              &gt; +<br>
              &gt;   void amdgpu_cs_chunk_fence_to_dep(struct
              amdgpu_cs_fence *fence,<br>
              &gt;                                 struct
              drm_amdgpu_cs_chunk_dep *dep);<br>
              &gt;   void amdgpu_cs_chunk_fence_info_to_data(struct
              amdgpu_cs_fence_info *fence_info,<br>
              &gt;                                       struct
              drm_amdgpu_cs_chunk_data *data);<br>
              &gt;   <br>
              &gt;   /**<br>
              &gt;    * Reserve VMID<br>
              &gt;    * \param   context - \c [in]  GPU Context<br>
              &gt;    * \param   flags - \c [in]  TBD<br>
              &gt;    *<br>
              &gt; diff --git a/amdgpu/amdgpu_bo.c b/amdgpu/amdgpu_bo.c<br>
              &gt; index c0f42e81..21bc73aa 100644<br>
              &gt; --- a/amdgpu/amdgpu_bo.c<br>
              &gt; +++ b/amdgpu/amdgpu_bo.c<br>
              &gt; @@ -611,20 +611,56 @@ drm_public int
              amdgpu_create_bo_from_user_mem(amdgpu_device_handle dev,<br>
              &gt;     
               pthread_mutex_lock(&amp;dev-&gt;bo_table_mutex);<br>
              &gt;       r =
              handle_table_insert(&amp;dev-&gt;bo_handles,
              (*buf_handle)-&gt;handle,<br>
              &gt;                               *buf_handle);<br>
              &gt;     
               pthread_mutex_unlock(&amp;dev-&gt;bo_table_mutex);<br>
              &gt;       if (r)<br>
              &gt;               amdgpu_bo_free(*buf_handle);<br>
              &gt;   out:<br>
              &gt;       return r;<br>
              &gt;   }<br>
              &gt;   <br>
              &gt; +drm_public int
              amdgpu_bo_list_create_raw(amdgpu_device_handle dev,<br>
              &gt; +                                      uint32_t
              number_of_buffers,<br>
              &gt; +                                      struct
              drm_amdgpu_bo_list_entry *buffers,<br>
              &gt; +                                      uint32_t
              *result)<br>
              &gt; +{<br>
              &gt; +     union drm_amdgpu_bo_list args;<br>
              &gt; +     int r;<br>
              &gt; +<br>
              &gt; +     memset(&amp;args, 0, sizeof(args));<br>
              &gt; +     args.in.operation = AMDGPU_BO_LIST_OP_CREATE;<br>
              &gt; +     args.in.bo_number = number_of_buffers;<br>
              &gt; +     args.in.bo_info_size = sizeof(struct
              drm_amdgpu_bo_list_entry);<br>
              &gt; +     args.in.bo_info_ptr =
              (uint64_t)(uintptr_t)buffers;<br>
              &gt; +<br>
              &gt; +     r = drmCommandWriteRead(dev-&gt;fd,
              DRM_AMDGPU_BO_LIST,<br>
              &gt; +                             &amp;args,
              sizeof(args));<br>
              &gt; +     if (r)<br>
              &gt; +             return r;<br>
              &gt; +<br>
              &gt; +     *result = args.out.list_handle;<br>
              &gt; +     return 0;<br>
              &gt; +}<br>
              &gt; +<br>
              &gt; +drm_public int
              amdgpu_bo_list_destroy_raw(amdgpu_device_handle dev,<br>
              &gt; +                                       uint32_t
              bo_list)<br>
              &gt; +{<br>
              &gt; +     union drm_amdgpu_bo_list args;<br>
              &gt; +<br>
              &gt; +     memset(&amp;args, 0, sizeof(args));<br>
              &gt; +     args.in.operation = AMDGPU_BO_LIST_OP_DESTROY;<br>
              &gt; +     args.in.list_handle = bo_list;<br>
              &gt; +<br>
              &gt; +     return drmCommandWriteRead(dev-&gt;fd,
              DRM_AMDGPU_BO_LIST,<br>
              &gt; +                                &amp;args,
              sizeof(args));<br>
              &gt; +}<br>
              &gt; +<br>
              &gt;   drm_public int
              amdgpu_bo_list_create(amdgpu_device_handle dev,<br>
              &gt;                                    uint32_t
              number_of_resources,<br>
              &gt;                                    amdgpu_bo_handle
              *resources,<br>
              &gt;                                    uint8_t
              *resource_prios,<br>
              &gt;                                   
              amdgpu_bo_list_handle *result)<br>
              &gt;   {<br>
              &gt;       struct drm_amdgpu_bo_list_entry *list;<br>
              &gt;       union drm_amdgpu_bo_list args;<br>
              &gt;       unsigned i;<br>
              &gt;       int r;<br>
              &gt; diff --git a/amdgpu/amdgpu_cs.c b/amdgpu/amdgpu_cs.c<br>
              &gt; index 3b8231aa..5bedf748 100644<br>
              &gt; --- a/amdgpu/amdgpu_cs.c<br>
              &gt; +++ b/amdgpu/amdgpu_cs.c<br>
              &gt; @@ -724,20 +724,45 @@ drm_public int
              amdgpu_cs_submit_raw(amdgpu_device_handle dev,<br>
              &gt;       r = drmCommandWriteRead(dev-&gt;fd,
              DRM_AMDGPU_CS,<br>
              &gt;                               &amp;cs, sizeof(cs));<br>
              &gt;       if (r)<br>
              &gt;               return r;<br>
              &gt;   <br>
              &gt;       if (seq_no)<br>
              &gt;               *seq_no = cs.out.handle;<br>
              &gt;       return 0;<br>
              &gt;   }<br>
              &gt;   <br>
              &gt; +drm_public int
              amdgpu_cs_submit_raw2(amdgpu_device_handle dev,<br>
              &gt; +                                 
              amdgpu_context_handle context,<br>
              &gt; +                                  uint32_t
              bo_list_handle,<br>
              &gt; +                                  int num_chunks,<br>
              &gt; +                                  struct
              drm_amdgpu_cs_chunk *chunks,<br>
              &gt; +                                  uint64_t *seq_no)<br>
              &gt; +{<br>
              &gt; +     union drm_amdgpu_cs cs = {0};<br>
              &gt; +     uint64_t *chunk_array;<br>
              &gt; +     int i, r;<br>
              &gt; +<br>
              &gt; +     chunk_array = alloca(sizeof(uint64_t) *
              num_chunks);<br>
              &gt; +     for (i = 0; i &lt; num_chunks; i++)<br>
              &gt; +             chunk_array[i] =
              (uint64_t)(uintptr_t)&amp;chunks[i];<br>
              &gt; +     cs.in.chunks =
              (uint64_t)(uintptr_t)chunk_array;<br>
              &gt; +     cs.in.ctx_id = context-&gt;id;<br>
              &gt; +     cs.in.bo_list_handle = bo_list_handle;<br>
              &gt; +     cs.in.num_chunks = num_chunks;<br>
              &gt; +     r = drmCommandWriteRead(dev-&gt;fd,
              DRM_AMDGPU_CS,<br>
              &gt; +                             &amp;cs, sizeof(cs));<br>
              &gt; +     if (!r &amp;&amp; seq_no)<br>
              &gt; +             *seq_no = cs.out.handle;<br>
              &gt; +     return r;<br>
              &gt; +}<br>
              &gt; +<br>
              &gt;   drm_public void
              amdgpu_cs_chunk_fence_info_to_data(struct
              amdgpu_cs_fence_info *fence_info,<br>
              &gt;                                       struct
              drm_amdgpu_cs_chunk_data *data)<br>
              &gt;   {<br>
              &gt;       data-&gt;fence_data.handle =
              fence_info-&gt;handle-&gt;handle;<br>
              &gt;       data-&gt;fence_data.offset =
              fence_info-&gt;offset * sizeof(uint64_t);<br>
              &gt;   }<br>
              &gt;   <br>
              &gt;   drm_public void amdgpu_cs_chunk_fence_to_dep(struct
              amdgpu_cs_fence *fence,<br>
              &gt;                                       struct
              drm_amdgpu_cs_chunk_dep *dep)<br>
              &gt;   {<br>
              <br>
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

--------------A3EF581148CEFE578928D9C5--

--===============1199913667==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1199913667==--
