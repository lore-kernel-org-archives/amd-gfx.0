From: Mike Lothian <mike-4+n8WJKc9ve9FHfhHBbuYA@public.gmane.org>
Subject: Re: [PATCH 0/6] Raven support for KFD
Date: Thu, 12 Jul 2018 23:28:03 +0100
Message-ID: <CAHbf0-Fv9npKsGZmgrNLmx6tS7800YOP4ijFEWGjCa3EwfzftQ@mail.gmail.com>
References: <1531430694-23966-1-git-send-email-Felix.Kuehling@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1448730435=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1531430694-23966-1-git-send-email-Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>
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
Cc: oded.gabbay-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

--===============1448730435==
Content-Type: multipart/alternative; boundary="0000000000000f299b0570d4e145"

--0000000000000f299b0570d4e145
Content-Type: text/plain; charset="UTF-8"

Hi

I'm happy to test this out, just wondering what userspace I should pair it
with

Cheers

Mike

On Thu, 12 Jul 2018 at 22:25 Felix Kuehling <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org> wrote:

> Raven refers to Ryzen APUs with integrated GFXv9 GPU.
> This patch series completes Raven support for KFD:
>
> * fix up memory banks info from CRAT
> * support different number of SDMA engines
> * workaround IOMMUv2 PPR issues
> * add device info
>
> Yong Zhao (6):
>   drm/amdkfd: Consolidate duplicate memory banks info in topology
>   drm/amdkfd: Make SDMA engine number an ASIC-dependent variable
>   drm/amdkfd: Avoid flooding dmesg on Raven due to IOMMU issues
>   drm/amdkfd: Workaround to accommodate Raven too many PPR issue
>   drm/amdkfd: Optimize out some duplicated code in
>     kfd_signal_iommu_event()
>   drm/amdkfd: Enable Raven for KFD
>
>  drivers/gpu/drm/amd/amdkfd/kfd_crat.c              | 57
> +++++++++++++++++-----
>  drivers/gpu/drm/amd/amdkfd/kfd_device.c            | 28 +++++++++++
>  .../gpu/drm/amd/amdkfd/kfd_device_queue_manager.c  | 29 +++++++----
>  .../gpu/drm/amd/amdkfd/kfd_device_queue_manager.h  |  6 +--
>  drivers/gpu/drm/amd/amdkfd/kfd_events.c            | 47 ++++++++++--------
>  drivers/gpu/drm/amd/amdkfd/kfd_iommu.c             |  2 +-
>  drivers/gpu/drm/amd/amdkfd/kfd_priv.h              |  1 +
>  .../gpu/drm/amd/amdkfd/kfd_process_queue_manager.c |  3 +-
>  8 files changed, 126 insertions(+), 47 deletions(-)
>
> --
> 2.7.4
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>

--0000000000000f299b0570d4e145
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi<div><br></div><div>I&#39;m happy to test this out, just=
 wondering what userspace I should pair it with</div><div><br></div><div>Ch=
eers</div><div><br></div><div>Mike</div></div><br><div class=3D"gmail_quote=
"><div dir=3D"ltr">On Thu, 12 Jul 2018 at 22:25 Felix Kuehling &lt;<a href=
=3D"mailto:Felix.Kuehling-5C7GfCeVMHo@public.gmane.org">Felix.Kuehling-5C7GfCeVMHo@public.gmane.org</a>&gt; wrote:<br=
></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-=
left:1px #ccc solid;padding-left:1ex">Raven refers to Ryzen APUs with integ=
rated GFXv9 GPU.<br>
This patch series completes Raven support for KFD:<br>
<br>
* fix up memory banks info from CRAT<br>
* support different number of SDMA engines<br>
* workaround IOMMUv2 PPR issues<br>
* add device info<br>
<br>
Yong Zhao (6):<br>
=C2=A0 drm/amdkfd: Consolidate duplicate memory banks info in topology<br>
=C2=A0 drm/amdkfd: Make SDMA engine number an ASIC-dependent variable<br>
=C2=A0 drm/amdkfd: Avoid flooding dmesg on Raven due to IOMMU issues<br>
=C2=A0 drm/amdkfd: Workaround to accommodate Raven too many PPR issue<br>
=C2=A0 drm/amdkfd: Optimize out some duplicated code in<br>
=C2=A0 =C2=A0 kfd_signal_iommu_event()<br>
=C2=A0 drm/amdkfd: Enable Raven for KFD<br>
<br>
=C2=A0drivers/gpu/drm/amd/amdkfd/kfd_crat.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 | 57 +++++++++++++++++-----<br>
=C2=A0drivers/gpu/drm/amd/amdkfd/kfd_device.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 | 28 +++++++++++<br>
=C2=A0.../gpu/drm/amd/amdkfd/kfd_device_queue_manager.c=C2=A0 | 29 +++++++-=
---<br>
=C2=A0.../gpu/drm/amd/amdkfd/kfd_device_queue_manager.h=C2=A0 |=C2=A0 6 +--=
<br>
=C2=A0drivers/gpu/drm/amd/amdkfd/kfd_events.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 | 47 ++++++++++--------<br>
=C2=A0drivers/gpu/drm/amd/amdkfd/kfd_iommu.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0|=C2=A0 2 +-<br>
=C2=A0drivers/gpu/drm/amd/amdkfd/kfd_priv.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 |=C2=A0 1 +<br>
=C2=A0.../gpu/drm/amd/amdkfd/kfd_process_queue_manager.c |=C2=A0 3 +-<br>
=C2=A08 files changed, 126 insertions(+), 47 deletions(-)<br>
<br>
-- <br>
2.7.4<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
<a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" target=3D"_blank">amd-gfx@=
lists.freedesktop.org</a><br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx" rel=3D"n=
oreferrer" target=3D"_blank">https://lists.freedesktop.org/mailman/listinfo=
/amd-gfx</a><br>
</blockquote></div>

--0000000000000f299b0570d4e145--

--===============1448730435==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1448730435==--
