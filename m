From: Oded Gabbay <oded.gabbay-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 0/9] WIP: Retry page fault handling for Vega10
Date: Mon, 28 Aug 2017 01:22:37 +0300
Message-ID: <CAFCwf10G+4ra9UD6upxaBc5FwSu4efB9oLKKYSZHcHQ-w9TZgQ@mail.gmail.com>
References: <1503731949-22742-1-git-send-email-Felix.Kuehling@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0720940745=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1503731949-22742-1-git-send-email-Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>
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
To: "Kuehling, Felix" <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>
Cc: amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============0720940745==
Content-Type: multipart/alternative; boundary="f403045db94c9ffae60557c39d77"

--f403045db94c9ffae60557c39d77
Content-Type: text/plain; charset="UTF-8"

Hi Felix,
I'm currently on vacation and I will return at the end of the week, so I
will not be able to review the patches until then.

Oded

On Aug 26, 2017 09:19, "Felix Kuehling" <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org> wrote:

> This is based on amd-kfd-staging, because that's easier for me to test.
> I'm planning to port to amd-staging-4.x for submission upstream.
>
> With this patch series, I'm able to turn retry faults on and handle the
> interrupt storm from VM faults. Only the first VM fault interrupt per
> process and address gets handled the usual way. Retry interruptr are
> filtered in a new prescreening stage in amdgpu_ih_process.
>
> Pending faults are tracked in a hash table in IH to detect retry faults
> and a FIFO in the VM for later processing.
>
> Looking up the VM from the fault interrupt depends on the PASID.
> Currently only KFD VMs have proper PASIDs.
>
> TODO (need some help with these):
> * Allocate PASIDs for graphics contexts
> * Setup VMID-PASID mapping during graphics command submission
> * Confirm that graphics page faults have the correct PASID in the IV
>
> Once that's done, we should have a foundation to start working on HMM
> and proper SVM memory management with demand paging.
>
> Felix Kuehling (9):
>   drm/amdgpu: Fix error handling in amdgpu_vm_init
>   drm/amdgpu: Add PASID management
>   drm/radeon: Add PASID manager for KFD
>   drm/amdkfd: Separate doorbell allocation from PASID
>   drm/amdkfd: Use PASID manager from KGD
>   drm/amd: Set the PASID for KFD VMs
>   drm/amdgpu: Add prescreening stage in IH processing
>   lib: Closed hash table with low overhead
>   drm/amdgpu: Track pending retry faults in IH and VM
>
>  drivers/gpu/drm/Kconfig                           |   1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h               |   2 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h        |   3 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v7.c |   2 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v8.c |   2 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c |   2 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  |   6 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c            |  82 ++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h            |  12 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c           |   2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c            |  88 +++-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h            |  21 +-
>  drivers/gpu/drm/amd/amdgpu/cik_ih.c               |  14 +
>  drivers/gpu/drm/amd/amdgpu/cz_ih.c                |  14 +
>  drivers/gpu/drm/amd/amdgpu/iceland_ih.c           |  14 +
>  drivers/gpu/drm/amd/amdgpu/si_ih.c                |  14 +
>  drivers/gpu/drm/amd/amdgpu/tonga_ih.c             |  14 +
>  drivers/gpu/drm/amd/amdgpu/vega10_ih.c            |  90 ++++
>  drivers/gpu/drm/amd/amdkfd/kfd_device.c           |  18 +-
>  drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c         |  48 +-
>  drivers/gpu/drm/amd/amdkfd/kfd_module.c           |   6 -
>  drivers/gpu/drm/amd/amdkfd/kfd_pasid.c            |  84 ++--
>  drivers/gpu/drm/amd/amdkfd/kfd_priv.h             |  10 +-
>  drivers/gpu/drm/amd/amdkfd/kfd_process.c          |   8 +-
>  drivers/gpu/drm/amd/include/kgd_kfd_interface.h   |   8 +-
>  drivers/gpu/drm/radeon/radeon_kfd.c               |  36 +-
>  include/linux/chash.h                             | 349 +++++++++++++++
>  lib/Kconfig                                       |   8 +
>  lib/Makefile                                      |   2 +
>  lib/chash.c                                       | 521
> ++++++++++++++++++++++
>  30 files changed, 1376 insertions(+), 105 deletions(-)
>  create mode 100644 include/linux/chash.h
>  create mode 100644 lib/chash.c
>
> --
> 2.7.4
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>

--f403045db94c9ffae60557c39d77
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Hi Felix,=C2=A0<div dir=3D"auto">I&#39;m currently on vac=
ation and I will return at the end of the week, so I will not be able to re=
view the patches until then.=C2=A0</div><div dir=3D"auto"><br></div><div di=
r=3D"auto">Oded</div></div><div class=3D"gmail_extra"><br><div class=3D"gma=
il_quote">On Aug 26, 2017 09:19, &quot;Felix Kuehling&quot; &lt;<a href=3D"=
mailto:Felix.Kuehling-5C7GfCeVMHo@public.gmane.org">Felix.Kuehling-5C7GfCeVMHo@public.gmane.org</a>&gt; wrote:<br typ=
e=3D"attribution"><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .=
8ex;border-left:1px #ccc solid;padding-left:1ex">This is based on amd-kfd-s=
taging, because that&#39;s easier for me to test.<br>
I&#39;m planning to port to amd-staging-4.x for submission upstream.<br>
<br>
With this patch series, I&#39;m able to turn retry faults on and handle the=
<br>
interrupt storm from VM faults. Only the first VM fault interrupt per<br>
process and address gets handled the usual way. Retry interruptr are<br>
filtered in a new prescreening stage in amdgpu_ih_process.<br>
<br>
Pending faults are tracked in a hash table in IH to detect retry faults<br>
and a FIFO in the VM for later processing.<br>
<br>
Looking up the VM from the fault interrupt depends on the PASID.<br>
Currently only KFD VMs have proper PASIDs.<br>
<br>
TODO (need some help with these):<br>
* Allocate PASIDs for graphics contexts<br>
* Setup VMID-PASID mapping during graphics command submission<br>
* Confirm that graphics page faults have the correct PASID in the IV<br>
<br>
Once that&#39;s done, we should have a foundation to start working on HMM<b=
r>
and proper SVM memory management with demand paging.<br>
<br>
Felix Kuehling (9):<br>
=C2=A0 drm/amdgpu: Fix error handling in amdgpu_vm_init<br>
=C2=A0 drm/amdgpu: Add PASID management<br>
=C2=A0 drm/radeon: Add PASID manager for KFD<br>
=C2=A0 drm/amdkfd: Separate doorbell allocation from PASID<br>
=C2=A0 drm/amdkfd: Use PASID manager from KGD<br>
=C2=A0 drm/amd: Set the PASID for KFD VMs<br>
=C2=A0 drm/amdgpu: Add prescreening stage in IH processing<br>
=C2=A0 lib: Closed hash table with low overhead<br>
=C2=A0 drm/amdgpu: Track pending retry faults in IH and VM<br>
<br>
=C2=A0drivers/gpu/drm/Kconfig=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A01 +<br>
=C2=A0drivers/gpu/drm/amd/amdgpu/<wbr>amdgpu.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A02 +<br>
=C2=A0drivers/gpu/drm/amd/amdgpu/<wbr>amdgpu_amdkfd.h=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 |=C2=A0 =C2=A03 +-<br>
=C2=A0drivers/gpu/drm/amd/amdgpu/<wbr>amdgpu_amdkfd_gfx_v7.c |=C2=A0 =C2=A0=
2 +<br>
=C2=A0drivers/gpu/drm/amd/amdgpu/<wbr>amdgpu_amdkfd_gfx_v8.c |=C2=A0 =C2=A0=
2 +<br>
=C2=A0drivers/gpu/drm/amd/amdgpu/<wbr>amdgpu_amdkfd_gfx_v9.c |=C2=A0 =C2=A0=
2 +<br>
=C2=A0drivers/gpu/drm/amd/amdgpu/<wbr>amdgpu_amdkfd_gpuvm.c=C2=A0 |=C2=A0 =
=C2=A06 +-<br>
=C2=A0drivers/gpu/drm/amd/amdgpu/<wbr>amdgpu_ih.c=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 |=C2=A0 82 ++++<br>
=C2=A0drivers/gpu/drm/amd/amdgpu/<wbr>amdgpu_ih.h=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 |=C2=A0 12 +<br>
=C2=A0drivers/gpu/drm/amd/amdgpu/<wbr>amdgpu_kms.c=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A02 +-<br>
=C2=A0drivers/gpu/drm/amd/amdgpu/<wbr>amdgpu_vm.c=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 |=C2=A0 88 +++-<br>
=C2=A0drivers/gpu/drm/amd/amdgpu/<wbr>amdgpu_vm.h=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 |=C2=A0 21 +-<br>
=C2=A0drivers/gpu/drm/amd/amdgpu/<wbr>cik_ih.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 14 +<br>
=C2=A0drivers/gpu/drm/amd/amdgpu/cz_<wbr>ih.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 14 +<br>
=C2=A0drivers/gpu/drm/amd/amdgpu/<wbr>iceland_ih.c=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0|=C2=A0 14 +<br>
=C2=A0drivers/gpu/drm/amd/amdgpu/si_<wbr>ih.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 14 +<br>
=C2=A0drivers/gpu/drm/amd/amdgpu/<wbr>tonga_ih.c=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0|=C2=A0 14 +<br>
=C2=A0drivers/gpu/drm/amd/amdgpu/<wbr>vega10_ih.c=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 |=C2=A0 90 ++++<br>
=C2=A0drivers/gpu/drm/amd/amdkfd/<wbr>kfd_device.c=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0|=C2=A0 18 +-<br>
=C2=A0drivers/gpu/drm/amd/amdkfd/<wbr>kfd_doorbell.c=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0|=C2=A0 48 +-<br>
=C2=A0drivers/gpu/drm/amd/amdkfd/<wbr>kfd_module.c=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A06 -<br>
=C2=A0drivers/gpu/drm/amd/amdkfd/<wbr>kfd_pasid.c=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 |=C2=A0 84 ++--<br>
=C2=A0drivers/gpu/drm/amd/amdkfd/<wbr>kfd_priv.h=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0|=C2=A0 10 +-<br>
=C2=A0drivers/gpu/drm/amd/amdkfd/<wbr>kfd_process.c=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 |=C2=A0 =C2=A08 +-<br>
=C2=A0drivers/gpu/drm/amd/include/<wbr>kgd_kfd_interface.h=C2=A0 =C2=A0|=C2=
=A0 =C2=A08 +-<br>
=C2=A0drivers/gpu/drm/radeon/radeon_<wbr>kfd.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 36 +-<br>
=C2=A0include/linux/chash.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 349 +++++++++++++=
++<br>
=C2=A0lib/Kconfig=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0|=C2=A0 =C2=A08 +<br>
=C2=A0lib/Makefile=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 |=C2=A0 =C2=A02 +<br>
=C2=A0lib/chash.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0| 521 ++++++++++++++++++++++<br>
=C2=A030 files changed, 1376 insertions(+), 105 deletions(-)<br>
=C2=A0create mode 100644 include/linux/chash.h<br>
=C2=A0create mode 100644 lib/chash.c<br>
<br>
--<br>
2.7.4<br>
<br>
______________________________<wbr>_________________<br>
amd-gfx mailing list<br>
<a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9/rsn8yoX9R0@public.gmane.org=
org</a><br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx" rel=3D"n=
oreferrer" target=3D"_blank">https://lists.freedesktop.org/<wbr>mailman/lis=
tinfo/amd-gfx</a><br>
</blockquote></div></div>

--f403045db94c9ffae60557c39d77--

--===============0720940745==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0720940745==--
