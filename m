From: Iago Abal <iago.abal-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Potential BUG: [PATCH 2/8] drm/amdgpu: add a generic fb accessing
 helper function(v3)
Date: Sat, 16 Nov 2019 17:21:37 +0100
Message-ID: <CAGbDTvpmPfrK=7a=mbnR-gKgi2ah+w6AeGYDU+9M9JOnWTzhBQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0846713704=="
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
To: "Tianci.Yin" <tianci.yin-5C7GfCeVMHo@public.gmane.org>, Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>, Luben Tuikov <luben.tuikov-5C7GfCeVMHo@public.gmane.org>
Cc: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

--===============0846713704==
Content-Type: multipart/alternative; boundary="000000000000f84ab90597791de4"

--000000000000f84ab90597791de4
Content-Type: text/plain; charset="UTF-8"

Hi,

With the help of a static bug finder (EBA - https://github.com/IagoAbal/eba)
I have found a potential double lock in Linux Next tag next-20191115, file
drivers/gpu/drm/amd/amdgpu/amdgpu_device.c.

This bug seems to be introduced by commit
e35e2b117f4 ("drm/amdgpu: add a generic fb accessing helper function(v3)").

The steps to reproduce it would be:

1. Start in function `amdgpu_device_vram_access`.
2. Enter for-loop `for (last += pos; pos <= last; pos += 4)`.
3. First lock: `spin_lock_irqsave(&adev->mmio_idx_lock, flags)`.
4. Call to `WREG32_NO_KIQ(mmMM_INDEX, ((uint32_t)pos) | 0x80000000)`.
   5. Note `#define WREG32_NO_KIQ(reg, v) amdgpu_mm_wreg(adev, (reg), (v),
AMDGPU_REGS_NO_KIQ)`.
   6. Continue in function `amdgpu_mm_wreg`.
   7. Take else-branch in the third if-statement.
   8. Double lock: `spin_lock_irqsave(&adev->mmio_idx_lock, flags)`.

I think the control flow could reach that second lock, but you may know
better.

Hope it helps!

-- iago

--000000000000f84ab90597791de4
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<br><br>With the help of a static bug finder (EBA - <a =
href=3D"https://github.com/IagoAbal/eba">https://github.com/IagoAbal/eba</a=
>) I have found a potential double lock in Linux Next tag next-20191115, fi=
le drivers/gpu/drm/amd/amdgpu/amdgpu_device.c.<br><br>This bug seems to be =
introduced by commit<br>e35e2b117f4 (&quot;drm/amdgpu: add a generic fb acc=
essing helper function(v3)&quot;).<br><br>The steps to reproduce it would b=
e:<br><br>1. Start in function `amdgpu_device_vram_access`.<br>2. Enter for=
-loop `for (last +=3D pos; pos &lt;=3D last; pos +=3D 4)`.<br>3. First lock=
: `spin_lock_irqsave(&amp;adev-&gt;mmio_idx_lock, flags)`.<br>4. Call to `W=
REG32_NO_KIQ(mmMM_INDEX, ((uint32_t)pos) | 0x80000000)`.<br>=C2=A0 =C2=A05.=
 Note `#define WREG32_NO_KIQ(reg, v) amdgpu_mm_wreg(adev, (reg), (v), AMDGP=
U_REGS_NO_KIQ)`.<br>=C2=A0 =C2=A06. Continue in function `amdgpu_mm_wreg`.<=
div>=C2=A0 =C2=A07. Take else-branch in the third if-statement.<br>=C2=A0 =
=C2=A08. Double lock: `spin_lock_irqsave(&amp;adev-&gt;mmio_idx_lock, flags=
)`.<br><br>I think the control flow could reach that second lock, but you m=
ay know better.</div><div><br>Hope it helps!<br clear=3D"all"><div><div dir=
=3D"ltr" class=3D"gmail_signature" data-smartmail=3D"gmail_signature"><br>-=
- iago</div></div></div></div>

--000000000000f84ab90597791de4--

--===============0846713704==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============0846713704==--
