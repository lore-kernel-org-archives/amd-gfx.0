From: Oded Gabbay <oded.gabbay-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 00/21] GFXv9/Vega10 support for KFD
Date: Tue, 10 Apr 2018 21:58:33 +0000
Message-ID: <CAFCwf12duDgzQ89SLz1cBDCYSyuJD19z=YxTWGE6OS8cN-yTgg@mail.gmail.com>
References: <1523395998-31314-1-git-send-email-Felix.Kuehling@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0104995475=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1523395998-31314-1-git-send-email-Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>
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

--===============0104995475==
Content-Type: multipart/alternative; boundary="f403045e64fc4292a5056985a0be"

--f403045e64fc4292a5056985a0be
Content-Type: text/plain; charset="UTF-8"

Hi Felix,
Just to let you know that I am currently on vacation and will be back home
only on 4/21 so all patch reviews from my side will be done after that
date.

Thanks,
Oded

On Tue, 10 Apr 2018, 17:33 Felix Kuehling <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org> wrote:

> This patch series adds support for GFXv9 GPUs to KFD. In this series it
> enables support for Vega10. Raven support requires some extra work that
> will follow shortly, but Raven support is already included and I didn't
> go out of my way to keep it out.
>
> Felix Kuehling (19):
>   drm/amdgpu: Remove unused interface from kfd2kgd interface
>   drm/amd: Update GFXv9 SDMA MQD structure
>   drm/amdgpu: Add GFXv9 TLB invalidation packet definition
>   drm/amdgpu: Add GFXv9 kfd2kgd interface functions
>   drm/amdgpu: Add doorbell routing info to kgd2kfd_shared_resources
>   drm/amdkfd: Make doorbell size ASIC-dependent
>   drm/amdkfd: Implement doorbell allocation for SOC15
>   drm/amdkfd: Move packet writer functions into ASIC-specific file
>   drm/amdkfd: Add GFXv9 PM4 packet writer functions
>   drm/amdkfd: Add GFXv9 MQD manager
>   drm/amdkfd: Add GFXv9 device queue manager
>   drm/amdkfd: Add SOC15 interrupt processing support
>   drm/amdkfd: Fix goto usage
>   drm/amdkfd: Fix kernel queue rollback_packet
>   drm/amdkfd: Add 64-bit doorbell and wptr support to kernel queue
>   drm/amdkfd: Remove limit on number of GPUs (follow-up)
>   drm/amdkfd: Support flat memory apertures for GFXv9
>   drm/amdkfd: Add GFXv9 CWSR trap handler
>   drm/amdkfd: Add Vega10 topology and device info
>
> Harish Kasiviswanathan (1):
>   drm/amdkfd: Clean up KFD_MMAP_ offset handling
>
> welu (1):
>   drm/amdkfd: Try to enable atomics for all GPUs
>
>  MAINTAINERS                                        |    2 +
>  drivers/gpu/drm/amd/amdgpu/Makefile                |    3 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c         |   26 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h         |    1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v7.c  |   10 -
>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v8.c  |   10 -
>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c  | 1043 ++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c              |    1 +
>  drivers/gpu/drm/amd/amdgpu/soc15d.h                |    5 +
>  drivers/gpu/drm/amd/amdkfd/Makefile                |   10 +-
>  .../gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx9.asm  | 1495
> ++++++++++++++++++++
>  drivers/gpu/drm/amd/amdkfd/kfd_chardev.c           |   42 +-
>  drivers/gpu/drm/amd/amdkfd/kfd_crat.c              |   11 +
>  drivers/gpu/drm/amd/amdkfd/kfd_device.c            |   89 +-
>  .../gpu/drm/amd/amdkfd/kfd_device_queue_manager.c  |  102 +-
>  .../gpu/drm/amd/amdkfd/kfd_device_queue_manager.h  |    2 +
>  .../drm/amd/amdkfd/kfd_device_queue_manager_v9.c   |   84 ++
>  drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c          |   65 +-
>  drivers/gpu/drm/amd/amdkfd/kfd_events.c            |    2 +-
>  drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c       |  119 +-
>  drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c    |   84 ++
>  drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c      |   39 +-
>  drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.h      |    7 +-
>  drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue_cik.c  |    9 +
>  drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue_v9.c   |  340 +++++
>  drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue_vi.c   |  319 +++++
>  drivers/gpu/drm/amd/amdkfd/kfd_module.c            |    5 +
>  drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c       |    3 +
>  drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c    |  443 ++++++
>  drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c    |  385 +----
>  drivers/gpu/drm/amd/amdkfd/kfd_pm4_headers_ai.h    |  583 ++++++++
>  drivers/gpu/drm/amd/amdkfd/kfd_priv.h              |  106 +-
>  drivers/gpu/drm/amd/amdkfd/kfd_process.c           |   40 +-
>  .../gpu/drm/amd/amdkfd/kfd_process_queue_manager.c |   12 +-
>  drivers/gpu/drm/amd/amdkfd/kfd_topology.c          |    6 +
>  drivers/gpu/drm/amd/amdkfd/kfd_topology.h          |    1 +
>  drivers/gpu/drm/amd/amdkfd/soc15_int.h             |   47 +
>  drivers/gpu/drm/amd/include/kgd_kfd_interface.h    |   20 +-
>  drivers/gpu/drm/amd/include/v9_structs.h           |   48 +-
>  39 files changed, 5118 insertions(+), 501 deletions(-)
>  create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
>  create mode 100644 drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx9.asm
>  create mode 100644
> drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_v9.c
>  create mode 100644 drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
>  create mode 100644 drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue_v9.c
>  create mode 100644 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
>  create mode 100644 drivers/gpu/drm/amd/amdkfd/kfd_pm4_headers_ai.h
>  create mode 100644 drivers/gpu/drm/amd/amdkfd/soc15_int.h
>
> --
> 2.7.4
>
>

--f403045e64fc4292a5056985a0be
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Hi Felix,<div dir=3D"auto">Just to let you know that I am=
 currently on vacation and will be back home only on 4/21 so all patch revi=
ews from my side will be done after that date.=C2=A0</div><div dir=3D"auto"=
><br></div><div dir=3D"auto">Thanks,=C2=A0</div><div dir=3D"auto">Oded=C2=
=A0</div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr">On Tue, 10 A=
pr 2018, 17:33 Felix Kuehling &lt;<a href=3D"mailto:Felix.Kuehling-5C7GfCeVMHo@public.gmane.org"=
>Felix.Kuehling-5C7GfCeVMHo@public.gmane.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_=
quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1=
ex">This patch series adds support for GFXv9 GPUs to KFD. In this series it=
<br>
enables support for Vega10. Raven support requires some extra work that<br>
will follow shortly, but Raven support is already included and I didn&#39;t=
<br>
go out of my way to keep it out.<br>
<br>
Felix Kuehling (19):<br>
=C2=A0 drm/amdgpu: Remove unused interface from kfd2kgd interface<br>
=C2=A0 drm/amd: Update GFXv9 SDMA MQD structure<br>
=C2=A0 drm/amdgpu: Add GFXv9 TLB invalidation packet definition<br>
=C2=A0 drm/amdgpu: Add GFXv9 kfd2kgd interface functions<br>
=C2=A0 drm/amdgpu: Add doorbell routing info to kgd2kfd_shared_resources<br=
>
=C2=A0 drm/amdkfd: Make doorbell size ASIC-dependent<br>
=C2=A0 drm/amdkfd: Implement doorbell allocation for SOC15<br>
=C2=A0 drm/amdkfd: Move packet writer functions into ASIC-specific file<br>
=C2=A0 drm/amdkfd: Add GFXv9 PM4 packet writer functions<br>
=C2=A0 drm/amdkfd: Add GFXv9 MQD manager<br>
=C2=A0 drm/amdkfd: Add GFXv9 device queue manager<br>
=C2=A0 drm/amdkfd: Add SOC15 interrupt processing support<br>
=C2=A0 drm/amdkfd: Fix goto usage<br>
=C2=A0 drm/amdkfd: Fix kernel queue rollback_packet<br>
=C2=A0 drm/amdkfd: Add 64-bit doorbell and wptr support to kernel queue<br>
=C2=A0 drm/amdkfd: Remove limit on number of GPUs (follow-up)<br>
=C2=A0 drm/amdkfd: Support flat memory apertures for GFXv9<br>
=C2=A0 drm/amdkfd: Add GFXv9 CWSR trap handler<br>
=C2=A0 drm/amdkfd: Add Vega10 topology and device info<br>
<br>
Harish Kasiviswanathan (1):<br>
=C2=A0 drm/amdkfd: Clean up KFD_MMAP_ offset handling<br>
<br>
welu (1):<br>
=C2=A0 drm/amdkfd: Try to enable atomics for all GPUs<br>
<br>
=C2=A0MAINTAINERS=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 |=C2=A0 =C2=A0 2 +<br>
=C2=A0drivers/gpu/drm/amd/amdgpu/Makefile=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0 3 +-<br>
=C2=A0drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0|=C2=A0 =C2=A026 +<br>
=C2=A0drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0|=C2=A0 =C2=A0 1 +<br>
=C2=A0drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v7.c=C2=A0 |=C2=A0 =C2=
=A010 -<br>
=C2=A0drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v8.c=C2=A0 |=C2=A0 =C2=
=A010 -<br>
=C2=A0drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c=C2=A0 | 1043 ++++++=
++++++++<br>
=C2=A0drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0 1 +<br>
=C2=A0drivers/gpu/drm/amd/amdgpu/soc15d.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0 5 +<br>
=C2=A0drivers/gpu/drm/amd/amdkfd/Makefile=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A010 +-<br>
=C2=A0.../gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx9.asm=C2=A0 | 1495 ++++++=
++++++++++++++<br>
=C2=A0drivers/gpu/drm/amd/amdkfd/kfd_chardev.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0|=C2=A0 =C2=A042 +-<br>
=C2=A0drivers/gpu/drm/amd/amdkfd/kfd_crat.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A011 +<br>
=C2=A0drivers/gpu/drm/amd/amdkfd/kfd_device.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 |=C2=A0 =C2=A089 +-<br>
=C2=A0.../gpu/drm/amd/amdkfd/kfd_device_queue_manager.c=C2=A0 |=C2=A0 102 +=
-<br>
=C2=A0.../gpu/drm/amd/amdkfd/kfd_device_queue_manager.h=C2=A0 |=C2=A0 =C2=
=A0 2 +<br>
=C2=A0.../drm/amd/amdkfd/kfd_device_queue_manager_v9.c=C2=A0 =C2=A0|=C2=A0 =
=C2=A084 ++<br>
=C2=A0drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 |=C2=A0 =C2=A065 +-<br>
=C2=A0drivers/gpu/drm/amd/amdkfd/kfd_events.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 |=C2=A0 =C2=A0 2 +-<br>
=C2=A0drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c=C2=A0 =C2=A0 =C2=A0 =C2=
=A0|=C2=A0 119 +-<br>
=C2=A0drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c=C2=A0 =C2=A0 |=C2=A0 =
=C2=A084 ++<br>
=C2=A0drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c=C2=A0 =C2=A0 =C2=A0 |=
=C2=A0 =C2=A039 +-<br>
=C2=A0drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.h=C2=A0 =C2=A0 =C2=A0 |=
=C2=A0 =C2=A0 7 +-<br>
=C2=A0drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue_cik.c=C2=A0 |=C2=A0 =C2=
=A0 9 +<br>
=C2=A0drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue_v9.c=C2=A0 =C2=A0|=C2=A0 =
340 +++++<br>
=C2=A0drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue_vi.c=C2=A0 =C2=A0|=C2=A0 =
319 +++++<br>
=C2=A0drivers/gpu/drm/amd/amdkfd/kfd_module.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 |=C2=A0 =C2=A0 5 +<br>
=C2=A0drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c=C2=A0 =C2=A0 =C2=A0 =C2=
=A0|=C2=A0 =C2=A0 3 +<br>
=C2=A0drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c=C2=A0 =C2=A0 |=C2=A0 =
443 ++++++<br>
=C2=A0drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c=C2=A0 =C2=A0 |=C2=A0 =
385 +----<br>
=C2=A0drivers/gpu/drm/amd/amdkfd/kfd_pm4_headers_ai.h=C2=A0 =C2=A0 |=C2=A0 =
583 ++++++++<br>
=C2=A0drivers/gpu/drm/amd/amdkfd/kfd_priv.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 |=C2=A0 106 +-<br>
=C2=A0drivers/gpu/drm/amd/amdkfd/kfd_process.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0|=C2=A0 =C2=A040 +-<br>
=C2=A0.../gpu/drm/amd/amdkfd/kfd_process_queue_manager.c |=C2=A0 =C2=A012 +=
-<br>
=C2=A0drivers/gpu/drm/amd/amdkfd/kfd_topology.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 |=C2=A0 =C2=A0 6 +<br>
=C2=A0drivers/gpu/drm/amd/amdkfd/kfd_topology.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 |=C2=A0 =C2=A0 1 +<br>
=C2=A0drivers/gpu/drm/amd/amdkfd/soc15_int.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A047 +<br>
=C2=A0drivers/gpu/drm/amd/include/kgd_kfd_interface.h=C2=A0 =C2=A0 |=C2=A0 =
=C2=A020 +-<br>
=C2=A0drivers/gpu/drm/amd/include/v9_structs.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0|=C2=A0 =C2=A048 +-<br>
=C2=A039 files changed, 5118 insertions(+), 501 deletions(-)<br>
=C2=A0create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c<=
br>
=C2=A0create mode 100644 drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx9.=
asm<br>
=C2=A0create mode 100644 drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manage=
r_v9.c<br>
=C2=A0create mode 100644 drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c<br=
>
=C2=A0create mode 100644 drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue_v9.c<b=
r>
=C2=A0create mode 100644 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c<br=
>
=C2=A0create mode 100644 drivers/gpu/drm/amd/amdkfd/kfd_pm4_headers_ai.h<br=
>
=C2=A0create mode 100644 drivers/gpu/drm/amd/amdkfd/soc15_int.h<br>
<br>
--<br>
2.7.4<br>
<br>
</blockquote></div>

--f403045e64fc4292a5056985a0be--

--===============0104995475==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0104995475==--
