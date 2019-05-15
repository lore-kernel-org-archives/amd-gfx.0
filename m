From: Micah Morton <mortonm-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
Subject: GPU passthrough support for Stoney [Radeon R2/R3/R4/R5 Graphics]?
Date: Wed, 15 May 2019 11:14:59 -0700
Message-ID: <CAJEGiUaGUG_8FK33-_a4ufTgacjzMds66boF+1Ytx9NYKbPX9Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1095822132=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
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
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

--===============1095822132==
Content-Type: multipart/alternative; boundary="00000000000043ba7e0588f121c1"

--00000000000043ba7e0588f121c1
Content-Type: text/plain; charset="UTF-8"

Hi folks,

I'm interested in running a VM on a system with an integrated Stoney
[Radeon R2/R3/R4/R5 Graphics] card and passing through the graphics card to
the VM using the IOMMU. I'm wondering whether this is feasible and supposed
to be doable with the right setup (as opposed to passing a discrete GPU to
the VM, which I think is definitely doable?).

So far, I can do all the qemu/kvm/vfio/iommu stuff to run the VM and pass
the integrated GPU to it, but the drm driver in the VM fails during
amdgpu_device_init(). Specifically, the logs show the SMU being
unresponsive, which leads to a 'SMU firmware load failed' error message and
kernel panic. I can share VM logs and the invocation of qemu and such if
helpful, but first wanted to know at a high level if this should be
feasible?

P.S.: I'm not initializing the GPU in the host bios or host kernel at all,
so I should be passing a fresh GPU to the VM. Also, I'm pretty sure I'm
running the correct VGA bios for this GPU in the guest VM bios before guest
boot.

Any comments/suggestions would be appreciated!

Micah

--00000000000043ba7e0588f121c1
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr">Hi folk=
s,</div><div dir=3D"ltr"><div><br></div><div>I&#39;m interested in running =
a VM on a system with an integrated Stoney [Radeon R2/R3/R4/R5 Graphics] ca=
rd and passing through the graphics card to the VM using the IOMMU. I&#39;m=
 wondering whether this is feasible and supposed to be doable with the righ=
t setup (as opposed to passing a discrete GPU to the VM, which I think is d=
efinitely doable?).</div><div><br></div><div>So far, I can do all the qemu/=
kvm/vfio/iommu stuff to run the VM and pass the integrated GPU to it, but t=
he drm driver in the VM fails during amdgpu_device_init(). Specifically, th=
e logs show the SMU being unresponsive, which leads to a &#39;SMU firmware =
load failed&#39; error message and kernel panic. I can share VM logs and th=
e invocation of qemu and such if helpful, but first wanted to know at a hig=
h level if this should be feasible?</div><div><br></div><div>P.S.: I&#39;m =
not initializing the GPU in the host bios or host kernel at all, so I shoul=
d be passing a fresh GPU to the VM. Also, I&#39;m pretty sure I&#39;m runni=
ng the correct VGA bios for this GPU in the guest VM bios before guest boot=
.</div><div><br></div><div>Any comments/suggestions would be appreciated!</=
div><div><br></div><div>Micah</div><div><br></div><div><br></div></div></di=
v></div></div>

--00000000000043ba7e0588f121c1--

--===============1095822132==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============1095822132==--
