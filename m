From: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH libdrm] amdgpu: add a faster BO list API
Date: Wed, 16 Jan 2019 11:14:34 -0500
Message-ID: <CAAxE2A7W1T=K40UGvDvjnkH=9KoakprxqhkJyQxBRv0DdHweyw@mail.gmail.com>
References: <20190107193104.4361-1-maraeo@gmail.com>
 <CAP+8YyFD+LxEQOLOY+mDC5v3OOyh1De2DcXK0sRtMW0t7z20SQ@mail.gmail.com>
 <CAAxE2A5chwbGmQN2yqVCfvF=TPvFMN6Qu-iFUuRW-zBVm=AN9w@mail.gmail.com>
 <CAP+8YyFhXpM8eHEjWwy+yAs4s7A7FyrkYO8=FA0tf6M6n-ka+g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2033790180=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CAP+8YyFhXpM8eHEjWwy+yAs4s7A7FyrkYO8=FA0tf6M6n-ka+g-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
To: Bas Nieuwenhuizen <bas-dldO88ZXqoXqqjsSq9zF6IRWq/SkRNHw@public.gmane.org>
Cc: amd-gfx mailing list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============2033790180==
Content-Type: multipart/alternative; boundary="0000000000001022e0057f95950f"

--0000000000001022e0057f95950f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 16, 2019 at 10:15 AM Bas Nieuwenhuizen <bas-dldO88ZXqoXqqjsSq9zF6IRWq/SkRNHw@public.gmane.org=
>
wrote:

> On Wed, Jan 16, 2019 at 3:38 PM Marek Ol=C5=A1=C3=A1k <maraeo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> =
wrote:
> >
> >
> >
> > On Wed, Jan 16, 2019, 7:46 AM Bas Nieuwenhuizen <bas@basnieuwenhuizen.n=
l
> wrote:
> >>
> >> So random questions:
> >>
> >> 1) In this discussion it was mentioned that some Vulkan drivers still
> >> use the bo_list interface. I think that implies radv as I think we're
> >> still using bo_list. Is there any other API we should be using? (Also,
> >> with VK_EXT_descriptor_indexing I suspect we'll be moving more towards
> >> a global bo list instead of a cmd buffer one, as we cannot know all
> >> the BOs referenced anymore, but not sure what end state here will be).
> >>
> >> 2) The other alternative mentioned was adding the buffers directly
> >> into the submit ioctl. Is this the desired end state (though as above
> >> I'm not sure how that works for vulkan)? If yes, what is the timeline
> >> for this that we need something in the interim?
> >
> >
> > Radeonsi already uses this.
> >
> >>
> >> 3) Did we measure any performance benefit?
> >>
> >> In general I'd like to to ack the raw bo list creation function as
> >> this interface seems easier to use. The two arrays thing has always
> >> been kind of a pain when we want to use e.g. builtin sort functions to
> >> make sure we have no duplicate BOs, but have some comments below.
> >
> >
> > The reason amdgpu was slower than radeon was because of this inefficien=
t
> bo list interface.
> >
> >>
> >> On Mon, Jan 7, 2019 at 8:31 PM Marek Ol=C5=A1=C3=A1k <maraeo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org=
> wrote:
> >> >
> >> > From: Marek Ol=C5=A1=C3=A1k <marek.olsak-5C7GfCeVMHo@public.gmane.org>
> >> >
> >> > ---
> >> >  amdgpu/amdgpu-symbol-check |  3 ++
> >> >  amdgpu/amdgpu.h            | 56
> +++++++++++++++++++++++++++++++++++++-
> >> >  amdgpu/amdgpu_bo.c         | 36 ++++++++++++++++++++++++
> >> >  amdgpu/amdgpu_cs.c         | 25 +++++++++++++++++
> >> >  4 files changed, 119 insertions(+), 1 deletion(-)
> >> >
> >> > diff --git a/amdgpu/amdgpu-symbol-check b/amdgpu/amdgpu-symbol-check
> >> > index 6f5e0f95..96a44b40 100755
> >> > --- a/amdgpu/amdgpu-symbol-check
> >> > +++ b/amdgpu/amdgpu-symbol-check
> >> > @@ -12,20 +12,22 @@ _edata
> >> >  _end
> >> >  _fini
> >> >  _init
> >> >  amdgpu_bo_alloc
> >> >  amdgpu_bo_cpu_map
> >> >  amdgpu_bo_cpu_unmap
> >> >  amdgpu_bo_export
> >> >  amdgpu_bo_free
> >> >  amdgpu_bo_import
> >> >  amdgpu_bo_inc_ref
> >> > +amdgpu_bo_list_create_raw
> >> > +amdgpu_bo_list_destroy_raw
> >> >  amdgpu_bo_list_create
> >> >  amdgpu_bo_list_destroy
> >> >  amdgpu_bo_list_update
> >> >  amdgpu_bo_query_info
> >> >  amdgpu_bo_set_metadata
> >> >  amdgpu_bo_va_op
> >> >  amdgpu_bo_va_op_raw
> >> >  amdgpu_bo_wait_for_idle
> >> >  amdgpu_create_bo_from_user_mem
> >> >  amdgpu_cs_chunk_fence_info_to_data
> >> > @@ -40,20 +42,21 @@ amdgpu_cs_destroy_semaphore
> >> >  amdgpu_cs_destroy_syncobj
> >> >  amdgpu_cs_export_syncobj
> >> >  amdgpu_cs_fence_to_handle
> >> >  amdgpu_cs_import_syncobj
> >> >  amdgpu_cs_query_fence_status
> >> >  amdgpu_cs_query_reset_state
> >> >  amdgpu_query_sw_info
> >> >  amdgpu_cs_signal_semaphore
> >> >  amdgpu_cs_submit
> >> >  amdgpu_cs_submit_raw
> >> > +amdgpu_cs_submit_raw2
> >> >  amdgpu_cs_syncobj_export_sync_file
> >> >  amdgpu_cs_syncobj_import_sync_file
> >> >  amdgpu_cs_syncobj_reset
> >> >  amdgpu_cs_syncobj_signal
> >> >  amdgpu_cs_syncobj_wait
> >> >  amdgpu_cs_wait_fences
> >> >  amdgpu_cs_wait_semaphore
> >> >  amdgpu_device_deinitialize
> >> >  amdgpu_device_initialize
> >> >  amdgpu_find_bo_by_cpu_mapping
> >> > diff --git a/amdgpu/amdgpu.h b/amdgpu/amdgpu.h
> >> > index dc51659a..5b800033 100644
> >> > --- a/amdgpu/amdgpu.h
> >> > +++ b/amdgpu/amdgpu.h
> >> > @@ -35,20 +35,21 @@
> >> >  #define _AMDGPU_H_
> >> >
> >> >  #include <stdint.h>
> >> >  #include <stdbool.h>
> >> >
> >> >  #ifdef __cplusplus
> >> >  extern "C" {
> >> >  #endif
> >> >
> >> >  struct drm_amdgpu_info_hw_ip;
> >> > +struct drm_amdgpu_bo_list_entry;
> >> >
> >> >
> /*-----------------------------------------------------------------------=
---*/
> >> >  /* --------------------------- Defines
> ------------------------------------ */
> >> >
> /*-----------------------------------------------------------------------=
---*/
> >> >
> >> >  /**
> >> >   * Define max. number of Command Buffers (IB) which could be sent t=
o
> the single
> >> >   * hardware IP to accommodate CE/DE requirements
> >> >   *
> >> >   * \sa amdgpu_cs_ib_info
> >> > @@ -767,34 +768,65 @@ int amdgpu_bo_cpu_unmap(amdgpu_bo_handle
> buf_handle);
> >> >   *                            and no GPU access is scheduled.
> >> >   *                          1 GPU access is in fly or scheduled
> >> >   *
> >> >   * \return   0 - on success
> >> >   *          <0 - Negative POSIX Error code
> >> >   */
> >> >  int amdgpu_bo_wait_for_idle(amdgpu_bo_handle buf_handle,
> >> >                             uint64_t timeout_ns,
> >> >                             bool *buffer_busy);
> >> >
> >> > +/**
> >> > + * Creates a BO list handle for command submission.
> >> > + *
> >> > + * \param   dev                        - \c [in] Device handle.
> >> > + *                                See #amdgpu_device_initialize()
> >> > + * \param   number_of_buffers  - \c [in] Number of BOs in the list
> >> > + * \param   buffers            - \c [in] List of BO handles
> >> > + * \param   result             - \c [out] Created BO list handle
> >> > + *
> >> > + * \return   0 on success\n
> >> > + *          <0 - Negative POSIX Error code
> >> > + *
> >> > + * \sa amdgpu_bo_list_destroy_raw()
> >> > +*/
> >> > +int amdgpu_bo_list_create_raw(amdgpu_device_handle dev,
> >> > +                             uint32_t number_of_buffers,
> >> > +                             struct drm_amdgpu_bo_list_entry
> *buffers,
> >> > +                             uint32_t *result);
> >>
> >> So AFAIU  drm_amdgpu_bo_list_entry takes a raw bo handle while we
> >> never get a raw bo handle from libdrm_amdgpu. How are we supposed to
> >> fill it in?
> >
> >
> > This function returns it.
>
> This function returns a bo_list handle right? I'm talking about the BO
> handles in `buffers`, where do we get them?
>

Query KMS handles using the export function.

Marek

--0000000000001022e0057f95950f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail=
_attr">On Wed, Jan 16, 2019 at 10:15 AM Bas Nieuwenhuizen &lt;<a href=3D"ma=
ilto:bas-dldO88ZXqoXqqjsSq9zF6IRWq/SkRNHw@public.gmane.org">bas-dldO88ZXqoXqqjsSq9zF6IRWq/SkRNHw@public.gmane.org</a>&gt; wrote:<br></d=
iv><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bord=
er-left:1px solid rgb(204,204,204);padding-left:1ex">On Wed, Jan 16, 2019 a=
t 3:38 PM Marek Ol=C5=A1=C3=A1k &lt;<a href=3D"mailto:maraeo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" tar=
get=3D"_blank">maraeo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt; wrote:<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; On Wed, Jan 16, 2019, 7:46 AM Bas Nieuwenhuizen &lt;<a href=3D"mailto:=
bas-dldO88ZXqoXqqjsSq9zF6IRWq/SkRNHw@public.gmane.org" target=3D"_blank">bas-dldO88ZXqoXqqjsSq9zF6IRWq/SkRNHw@public.gmane.org</a> wrot=
e:<br>
&gt;&gt;<br>
&gt;&gt; So random questions:<br>
&gt;&gt;<br>
&gt;&gt; 1) In this discussion it was mentioned that some Vulkan drivers st=
ill<br>
&gt;&gt; use the bo_list interface. I think that implies radv as I think we=
&#39;re<br>
&gt;&gt; still using bo_list. Is there any other API we should be using? (A=
lso,<br>
&gt;&gt; with VK_EXT_descriptor_indexing I suspect we&#39;ll be moving more=
 towards<br>
&gt;&gt; a global bo list instead of a cmd buffer one, as we cannot know al=
l<br>
&gt;&gt; the BOs referenced anymore, but not sure what end state here will =
be).<br>
&gt;&gt;<br>
&gt;&gt; 2) The other alternative mentioned was adding the buffers directly=
<br>
&gt;&gt; into the submit ioctl. Is this the desired end state (though as ab=
ove<br>
&gt;&gt; I&#39;m not sure how that works for vulkan)? If yes, what is the t=
imeline<br>
&gt;&gt; for this that we need something in the interim?<br>
&gt;<br>
&gt;<br>
&gt; Radeonsi already uses this.<br>
&gt;<br>
&gt;&gt;<br>
&gt;&gt; 3) Did we measure any performance benefit?<br>
&gt;&gt;<br>
&gt;&gt; In general I&#39;d like to to ack the raw bo list creation functio=
n as<br>
&gt;&gt; this interface seems easier to use. The two arrays thing has alway=
s<br>
&gt;&gt; been kind of a pain when we want to use e.g. builtin sort function=
s to<br>
&gt;&gt; make sure we have no duplicate BOs, but have some comments below.<=
br>
&gt;<br>
&gt;<br>
&gt; The reason amdgpu was slower than radeon was because of this inefficie=
nt bo list interface.<br>
&gt;<br>
&gt;&gt;<br>
&gt;&gt; On Mon, Jan 7, 2019 at 8:31 PM Marek Ol=C5=A1=C3=A1k &lt;<a href=
=3D"mailto:maraeo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" target=3D"_blank">maraeo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt; wro=
te:<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; From: Marek Ol=C5=A1=C3=A1k &lt;<a href=3D"mailto:marek.olsak=
@amd.com" target=3D"_blank">marek.olsak-5C7GfCeVMHo@public.gmane.org</a>&gt;<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; ---<br>
&gt;&gt; &gt;=C2=A0 amdgpu/amdgpu-symbol-check |=C2=A0 3 ++<br>
&gt;&gt; &gt;=C2=A0 amdgpu/amdgpu.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 | 56 +++++++++++++++++++++++++++++++++++++-<br>
&gt;&gt; &gt;=C2=A0 amdgpu/amdgpu_bo.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 3=
6 ++++++++++++++++++++++++<br>
&gt;&gt; &gt;=C2=A0 amdgpu/amdgpu_cs.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 2=
5 +++++++++++++++++<br>
&gt;&gt; &gt;=C2=A0 4 files changed, 119 insertions(+), 1 deletion(-)<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; diff --git a/amdgpu/amdgpu-symbol-check b/amdgpu/amdgpu-symbo=
l-check<br>
&gt;&gt; &gt; index 6f5e0f95..96a44b40 100755<br>
&gt;&gt; &gt; --- a/amdgpu/amdgpu-symbol-check<br>
&gt;&gt; &gt; +++ b/amdgpu/amdgpu-symbol-check<br>
&gt;&gt; &gt; @@ -12,20 +12,22 @@ _edata<br>
&gt;&gt; &gt;=C2=A0 _end<br>
&gt;&gt; &gt;=C2=A0 _fini<br>
&gt;&gt; &gt;=C2=A0 _init<br>
&gt;&gt; &gt;=C2=A0 amdgpu_bo_alloc<br>
&gt;&gt; &gt;=C2=A0 amdgpu_bo_cpu_map<br>
&gt;&gt; &gt;=C2=A0 amdgpu_bo_cpu_unmap<br>
&gt;&gt; &gt;=C2=A0 amdgpu_bo_export<br>
&gt;&gt; &gt;=C2=A0 amdgpu_bo_free<br>
&gt;&gt; &gt;=C2=A0 amdgpu_bo_import<br>
&gt;&gt; &gt;=C2=A0 amdgpu_bo_inc_ref<br>
&gt;&gt; &gt; +amdgpu_bo_list_create_raw<br>
&gt;&gt; &gt; +amdgpu_bo_list_destroy_raw<br>
&gt;&gt; &gt;=C2=A0 amdgpu_bo_list_create<br>
&gt;&gt; &gt;=C2=A0 amdgpu_bo_list_destroy<br>
&gt;&gt; &gt;=C2=A0 amdgpu_bo_list_update<br>
&gt;&gt; &gt;=C2=A0 amdgpu_bo_query_info<br>
&gt;&gt; &gt;=C2=A0 amdgpu_bo_set_metadata<br>
&gt;&gt; &gt;=C2=A0 amdgpu_bo_va_op<br>
&gt;&gt; &gt;=C2=A0 amdgpu_bo_va_op_raw<br>
&gt;&gt; &gt;=C2=A0 amdgpu_bo_wait_for_idle<br>
&gt;&gt; &gt;=C2=A0 amdgpu_create_bo_from_user_mem<br>
&gt;&gt; &gt;=C2=A0 amdgpu_cs_chunk_fence_info_to_data<br>
&gt;&gt; &gt; @@ -40,20 +42,21 @@ amdgpu_cs_destroy_semaphore<br>
&gt;&gt; &gt;=C2=A0 amdgpu_cs_destroy_syncobj<br>
&gt;&gt; &gt;=C2=A0 amdgpu_cs_export_syncobj<br>
&gt;&gt; &gt;=C2=A0 amdgpu_cs_fence_to_handle<br>
&gt;&gt; &gt;=C2=A0 amdgpu_cs_import_syncobj<br>
&gt;&gt; &gt;=C2=A0 amdgpu_cs_query_fence_status<br>
&gt;&gt; &gt;=C2=A0 amdgpu_cs_query_reset_state<br>
&gt;&gt; &gt;=C2=A0 amdgpu_query_sw_info<br>
&gt;&gt; &gt;=C2=A0 amdgpu_cs_signal_semaphore<br>
&gt;&gt; &gt;=C2=A0 amdgpu_cs_submit<br>
&gt;&gt; &gt;=C2=A0 amdgpu_cs_submit_raw<br>
&gt;&gt; &gt; +amdgpu_cs_submit_raw2<br>
&gt;&gt; &gt;=C2=A0 amdgpu_cs_syncobj_export_sync_file<br>
&gt;&gt; &gt;=C2=A0 amdgpu_cs_syncobj_import_sync_file<br>
&gt;&gt; &gt;=C2=A0 amdgpu_cs_syncobj_reset<br>
&gt;&gt; &gt;=C2=A0 amdgpu_cs_syncobj_signal<br>
&gt;&gt; &gt;=C2=A0 amdgpu_cs_syncobj_wait<br>
&gt;&gt; &gt;=C2=A0 amdgpu_cs_wait_fences<br>
&gt;&gt; &gt;=C2=A0 amdgpu_cs_wait_semaphore<br>
&gt;&gt; &gt;=C2=A0 amdgpu_device_deinitialize<br>
&gt;&gt; &gt;=C2=A0 amdgpu_device_initialize<br>
&gt;&gt; &gt;=C2=A0 amdgpu_find_bo_by_cpu_mapping<br>
&gt;&gt; &gt; diff --git a/amdgpu/amdgpu.h b/amdgpu/amdgpu.h<br>
&gt;&gt; &gt; index dc51659a..5b800033 100644<br>
&gt;&gt; &gt; --- a/amdgpu/amdgpu.h<br>
&gt;&gt; &gt; +++ b/amdgpu/amdgpu.h<br>
&gt;&gt; &gt; @@ -35,20 +35,21 @@<br>
&gt;&gt; &gt;=C2=A0 #define _AMDGPU_H_<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt;=C2=A0 #include &lt;stdint.h&gt;<br>
&gt;&gt; &gt;=C2=A0 #include &lt;stdbool.h&gt;<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt;=C2=A0 #ifdef __cplusplus<br>
&gt;&gt; &gt;=C2=A0 extern &quot;C&quot; {<br>
&gt;&gt; &gt;=C2=A0 #endif<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt;=C2=A0 struct drm_amdgpu_info_hw_ip;<br>
&gt;&gt; &gt; +struct drm_amdgpu_bo_list_entry;<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt;=C2=A0 /*-----------------------------------------------------=
---------------------*/<br>
&gt;&gt; &gt;=C2=A0 /* --------------------------- Defines ----------------=
-------------------- */<br>
&gt;&gt; &gt;=C2=A0 /*-----------------------------------------------------=
---------------------*/<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt;=C2=A0 /**<br>
&gt;&gt; &gt;=C2=A0 =C2=A0* Define max. number of Command Buffers (IB) whic=
h could be sent to the single<br>
&gt;&gt; &gt;=C2=A0 =C2=A0* hardware IP to accommodate CE/DE requirements<b=
r>
&gt;&gt; &gt;=C2=A0 =C2=A0*<br>
&gt;&gt; &gt;=C2=A0 =C2=A0* \sa amdgpu_cs_ib_info<br>
&gt;&gt; &gt; @@ -767,34 +768,65 @@ int amdgpu_bo_cpu_unmap(amdgpu_bo_handl=
e buf_handle);<br>
&gt;&gt; &gt;=C2=A0 =C2=A0*=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 and no GPU access is sche=
duled.<br>
&gt;&gt; &gt;=C2=A0 =C2=A0*=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 1 GPU access is in fly or schedu=
led<br>
&gt;&gt; &gt;=C2=A0 =C2=A0*<br>
&gt;&gt; &gt;=C2=A0 =C2=A0* \return=C2=A0 =C2=A00 - on success<br>
&gt;&gt; &gt;=C2=A0 =C2=A0*=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;0 - Negat=
ive POSIX Error code<br>
&gt;&gt; &gt;=C2=A0 =C2=A0*/<br>
&gt;&gt; &gt;=C2=A0 int amdgpu_bo_wait_for_idle(amdgpu_bo_handle buf_handle=
,<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint64_t timeout_ns,<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bool *buffer_busy);<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; +/**<br>
&gt;&gt; &gt; + * Creates a BO list handle for command submission.<br>
&gt;&gt; &gt; + *<br>
&gt;&gt; &gt; + * \param=C2=A0 =C2=A0dev=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 - \c [in] Device handle.<b=
r>
&gt;&gt; &gt; + *=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 See #amdgpu_device_=
initialize()<br>
&gt;&gt; &gt; + * \param=C2=A0 =C2=A0number_of_buffers=C2=A0 - \c [in] Numb=
er of BOs in the list<br>
&gt;&gt; &gt; + * \param=C2=A0 =C2=A0buffers=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 - \c [in] List of BO handles<br>
&gt;&gt; &gt; + * \param=C2=A0 =C2=A0result=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0- \c [out] Created BO list handle<br>
&gt;&gt; &gt; + *<br>
&gt;&gt; &gt; + * \return=C2=A0 =C2=A00 on success\n<br>
&gt;&gt; &gt; + *=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;0 - Negative POSIX =
Error code<br>
&gt;&gt; &gt; + *<br>
&gt;&gt; &gt; + * \sa amdgpu_bo_list_destroy_raw()<br>
&gt;&gt; &gt; +*/<br>
&gt;&gt; &gt; +int amdgpu_bo_list_create_raw(amdgpu_device_handle dev,<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t number_of_buffers,<br=
>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct drm_amdgpu_bo_list_entr=
y *buffers,<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t *result);<br>
&gt;&gt;<br>
&gt;&gt; So AFAIU=C2=A0 drm_amdgpu_bo_list_entry takes a raw bo handle whil=
e we<br>
&gt;&gt; never get a raw bo handle from libdrm_amdgpu. How are we supposed =
to<br>
&gt;&gt; fill it in?<br>
&gt;<br>
&gt;<br>
&gt; This function returns it.<br>
<br>
This function returns a bo_list handle right? I&#39;m talking about the BO<=
br>
handles in `buffers`, where do we get them?<br></blockquote><div><br></div>=
<div>Query KMS handles using the export function.<br></div><div><br></div><=
div>Marek</div></div></div>

--0000000000001022e0057f95950f--

--===============2033790180==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============2033790180==--
