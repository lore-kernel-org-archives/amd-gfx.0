From: Oded Gabbay <oded.gabbay-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 00/17] KFD interrupt and signal event handling
 improvements v2
Date: Wed, 1 Nov 2017 10:33:29 +0200
Message-ID: <CAFCwf11G-2TfmSAS7cXZYx_keHWiv1xS4150VaXXncZMP8ZABA@mail.gmail.com>
References: <1509147334-16281-1-git-send-email-Felix.Kuehling@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0058720112=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1509147334-16281-1-git-send-email-Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>
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
To: Felix Kuehling <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>
Cc: amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============0058720112==
Content-Type: multipart/alternative; boundary="001a11465d5ab27ef4055ce7bbd4"

--001a11465d5ab27ef4055ce7bbd4
Content-Type: text/plain; charset="UTF-8"

Hi,
I've taken the patch-set to -next.
Oded

On Sat, Oct 28, 2017 at 2:35 AM, Felix Kuehling <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>
wrote:

> This patch series improves interrupt handling latency, signal event
> processing overhead and replaces some custom data structures with
> standard kernel data structures (idr, kfifo, waitqueue).
>
> It also increases the capacity of the number of signals that can be
> processed from 256 to 4096. This breaks ancient versions of the Thunk
> that support only 256 signal events. The current WIP-version on github
> supports both sizes. If support for ancient Thunks is considered
> important, this could be fixed by allowing mappings that are smaller
> than 4096 signals, and limiting the number of signals per process
> depending on the size of the mapped events page.
>
> v2:
>  * Don't break ABI when changing KFD_SIGNAL_EVENT_LIMIT
>  * Integrated review feedback for "Use wait_queue_t to implement event
> waiting"
>  * Integrated review feedback for "Don't dereference kfd_process.mm"
>
> Andres Rodriguez (4):
>   drm/amdkfd: use standard kernel kfifo for IH
>   drm/amdkfd: increase IH num entries to 8192
>   drm/amdkfd: wait only for IH work on IH exit
>   drm/amdkfd: use a high priority workqueue for IH work
>
> Besar Wicaksono (1):
>   drm/amdkfd: Add SDMA trap src id to the KFD isr wanted list
>
> Felix Kuehling (9):
>   drm/amdkfd: Don't dereference kfd_process.mm v2
>   drm/amdkfd: Clean up kfd_wait_on_events
>   drm/amdkfd: Fix event destruction with pending waiters
>   drm/amdkfd: remove redundant kfd_event_waiter.input_index
>   drm/amdkfd: Use wait_queue_t to implement event waiting
>   drm/amdkfd: Simplify events page allocator
>   drm/amdkfd: Simplify event ID and signal slot management
>   drm/amdkfd: Use IH context ID for signal lookup
>   drm/amdkfd: Make event limit dependent on user mode mapping size
>
> Oded Gabbay (1):
>   drm/amdkfd: increase limit of signal events to 4096 per process
>
> Sean Keely (2):
>   drm/amdkfd: Short cut for kfd_wait_on_events without waiting
>   drm/amdkfd: Fix scheduler race in kfd_wait_on_events sleep loop
>
>  drivers/gpu/drm/amd/amdkfd/cik_event_interrupt.c |   8 +-
>  drivers/gpu/drm/amd/amdkfd/cik_int.h             |   3 +-
>  drivers/gpu/drm/amd/amdkfd/kfd_chardev.c         |   5 +-
>  drivers/gpu/drm/amd/amdkfd/kfd_device.c          |   2 +-
>  drivers/gpu/drm/amd/amdkfd/kfd_events.c          | 615
> +++++++++++------------
>  drivers/gpu/drm/amd/amdkfd/kfd_events.h          |  18 +-
>  drivers/gpu/drm/amd/amdkfd/kfd_interrupt.c       |  83 ++-
>  drivers/gpu/drm/amd/amdkfd/kfd_priv.h            |  33 +-
>  drivers/gpu/drm/amd/amdkfd/kfd_process.c         |   1 -
>  include/uapi/linux/kfd_ioctl.h                   |   2 +-
>  10 files changed, 350 insertions(+), 420 deletions(-)
>
> --
> 2.7.4
>
>

--001a11465d5ab27ef4055ce7bbd4
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_default" style=3D"font-size:small">Hi,=
</div><div class=3D"gmail_default" style=3D"font-size:small">I&#39;ve taken=
 the patch-set to -next.</div><div class=3D"gmail_default" style=3D"font-si=
ze:small">Oded</div></div><div class=3D"gmail_extra"><br><div class=3D"gmai=
l_quote">On Sat, Oct 28, 2017 at 2:35 AM, Felix Kuehling <span dir=3D"ltr">=
&lt;<a href=3D"mailto:Felix.Kuehling-5C7GfCeVMHo@public.gmane.org" target=3D"_blank">Felix.Kuehl=
ing-5C7GfCeVMHo@public.gmane.org</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" styl=
e=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">This pa=
tch series improves interrupt handling latency, signal event<br>
processing overhead and replaces some custom data structures with<br>
standard kernel data structures (idr, kfifo, waitqueue).<br>
<br>
It also increases the capacity of the number of signals that can be<br>
processed from 256 to 4096. This breaks ancient versions of the Thunk<br>
that support only 256 signal events. The current WIP-version on github<br>
supports both sizes. If support for ancient Thunks is considered<br>
important, this could be fixed by allowing mappings that are smaller<br>
than 4096 signals, and limiting the number of signals per process<br>
depending on the size of the mapped events page.<br>
<br>
v2:<br>
=C2=A0* Don&#39;t break ABI when changing KFD_SIGNAL_EVENT_LIMIT<br>
=C2=A0* Integrated review feedback for &quot;Use wait_queue_t to implement =
event waiting&quot;<br>
=C2=A0* Integrated review feedback for &quot;Don&#39;t dereference <a href=
=3D"http://kfd_process.mm" rel=3D"noreferrer" target=3D"_blank">kfd_process=
.mm</a>&quot;<br>
<br>
Andres Rodriguez (4):<br>
=C2=A0 drm/amdkfd: use standard kernel kfifo for IH<br>
=C2=A0 drm/amdkfd: increase IH num entries to 8192<br>
=C2=A0 drm/amdkfd: wait only for IH work on IH exit<br>
=C2=A0 drm/amdkfd: use a high priority workqueue for IH work<br>
<br>
Besar Wicaksono (1):<br>
=C2=A0 drm/amdkfd: Add SDMA trap src id to the KFD isr wanted list<br>
<br>
Felix Kuehling (9):<br>
=C2=A0 drm/amdkfd: Don&#39;t dereference <a href=3D"http://kfd_process.mm" =
rel=3D"noreferrer" target=3D"_blank">kfd_process.mm</a> v2<br>
=C2=A0 drm/amdkfd: Clean up kfd_wait_on_events<br>
=C2=A0 drm/amdkfd: Fix event destruction with pending waiters<br>
=C2=A0 drm/amdkfd: remove redundant kfd_event_waiter.input_index<br>
=C2=A0 drm/amdkfd: Use wait_queue_t to implement event waiting<br>
=C2=A0 drm/amdkfd: Simplify events page allocator<br>
=C2=A0 drm/amdkfd: Simplify event ID and signal slot management<br>
=C2=A0 drm/amdkfd: Use IH context ID for signal lookup<br>
=C2=A0 drm/amdkfd: Make event limit dependent on user mode mapping size<br>
<br>
Oded Gabbay (1):<br>
=C2=A0 drm/amdkfd: increase limit of signal events to 4096 per process<br>
<br>
Sean Keely (2):<br>
=C2=A0 drm/amdkfd: Short cut for kfd_wait_on_events without waiting<br>
=C2=A0 drm/amdkfd: Fix scheduler race in kfd_wait_on_events sleep loop<br>
<br>
=C2=A0drivers/gpu/drm/amd/amdkfd/<wbr>cik_event_interrupt.c |=C2=A0 =C2=A08=
 +-<br>
=C2=A0drivers/gpu/drm/amd/amdkfd/<wbr>cik_int.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A03 +-<br>
=C2=A0drivers/gpu/drm/amd/amdkfd/<wbr>kfd_chardev.c=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0|=C2=A0 =C2=A05 +-<br>
=C2=A0drivers/gpu/drm/amd/amdkfd/<wbr>kfd_device.c=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 |=C2=A0 =C2=A02 +-<br>
=C2=A0drivers/gpu/drm/amd/amdkfd/<wbr>kfd_events.c=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 | 615 +++++++++++------------<br>
=C2=A0drivers/gpu/drm/amd/amdkfd/<wbr>kfd_events.h=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 |=C2=A0 18 +-<br>
=C2=A0drivers/gpu/drm/amd/amdkfd/<wbr>kfd_interrupt.c=C2=A0 =C2=A0 =C2=A0 =
=C2=A0|=C2=A0 83 ++-<br>
=C2=A0drivers/gpu/drm/amd/amdkfd/<wbr>kfd_priv.h=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 |=C2=A0 33 +-<br>
=C2=A0drivers/gpu/drm/amd/amdkfd/<wbr>kfd_process.c=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0|=C2=A0 =C2=A01 -<br>
=C2=A0include/uapi/linux/kfd_ioctl.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A02 +-<br>
=C2=A010 files changed, 350 insertions(+), 420 deletions(-)<br>
<span class=3D"HOEnZb"><font color=3D"#888888"><br>
--<br>
2.7.4<br>
<br>
</font></span></blockquote></div><br></div>

--001a11465d5ab27ef4055ce7bbd4--

--===============0058720112==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0058720112==--
