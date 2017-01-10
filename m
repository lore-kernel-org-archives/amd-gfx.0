From: =?UTF-8?Q?Nils_Wallm=C3=A9nius?= <nils.wallmenius-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 6/7] drm/amdgpu:alloc/dealloc csa accordingly
Date: Tue, 10 Jan 2017 08:56:36 +0100
Message-ID: <CA+nq7DuCviSbC7ty46j7YqYM83c5=oZF19eAfZLT1_ehYNqu+A@mail.gmail.com>
References: <1483948982-27056-1-git-send-email-Monk.Liu@amd.com>
 <1483948982-27056-7-git-send-email-Monk.Liu@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1778523437=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1483948982-27056-7-git-send-email-Monk.Liu-5C7GfCeVMHo@public.gmane.org>
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
To: Monk Liu <Monk.Liu-5C7GfCeVMHo@public.gmane.org>
Cc: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

--===============1778523437==
Content-Type: multipart/alternative; boundary=94eb2c0d106ed33c9b0545b8d2ae

--94eb2c0d106ed33c9b0545b8d2ae
Content-Type: text/plain; charset=UTF-8

Hi Monk, a comment below.


Den 9 jan. 2017 9:07 fm skrev "Monk Liu" <Monk.Liu-5C7GfCeVMHo@public.gmane.org>:

Change-Id: I110af93c4f17ab18d1be199c6ebe9ee965483a66
Signed-off-by: Monk Liu <Monk.Liu-5C7GfCeVMHo@public.gmane.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index f82919d..5253aa2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -1384,6 +1384,10 @@ static int amdgpu_init(struct amdgpu_device *adev)
                                return r;
                        }
                        adev->ip_blocks[i].status.hw = true;
+
+                       /* right after GMC hw init, we create CSA */
+                       if (amdgpu_sriov_vf(adev))
+                               adev->virt.allocate_csa(adev);


The amdgpu_allocate_static_csa function returns a value, presumably an
error on failure. Shouldn't the return value be checked here and errors
handled?

Best regards,
Nils

                }
        }

@@ -1517,6 +1521,9 @@ static int amdgpu_fini(struct amdgpu_device *adev)
                adev->ip_blocks[i].status.late_initialized = false;
        }

+       if (amdgpu_sriov_vf(adev))
+               adev->virt.deallocate_csa(adev);
+
        return 0;
 }

--
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--94eb2c0d106ed33c9b0545b8d2ae
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Hi Monk, a comment below.<div><br><div class=3D"gmail_ext=
ra"><br><div class=3D"gmail_quote">Den 9 jan. 2017 9:07 fm skrev &quot;Monk=
 Liu&quot; &lt;<a href=3D"mailto:Monk.Liu-5C7GfCeVMHo@public.gmane.org" target=3D"_blank">Monk.L=
iu-5C7GfCeVMHo@public.gmane.org</a>&gt;:<br type=3D"attribution"><blockquote class=3D"m_28201111=
08539082759quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;pad=
ding-left:1ex">Change-Id: I110af93c4f17ab18d1be199c6ebe9<wbr>ee965483a66<br=
>
Signed-off-by: Monk Liu &lt;<a href=3D"mailto:Monk.Liu-5C7GfCeVMHo@public.gmane.org" target=3D"_=
blank">Monk.Liu-5C7GfCeVMHo@public.gmane.org</a>&gt;<br>
---<br>
=C2=A0drivers/gpu/drm/amd/amdgpu/am<wbr>dgpu_device.c | 7 +++++++<br>
=C2=A01 file changed, 7 insertions(+)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/a<wbr>mdgpu_device.c b/drivers/gpu/=
drm/amd/amdgpu/a<wbr>mdgpu_device.c<br>
index f82919d..5253aa2 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/a<wbr>mdgpu_device.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/a<wbr>mdgpu_device.c<br>
@@ -1384,6 +1384,10 @@ static int amdgpu_init(struct amdgpu_device *adev)<b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return r;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 adev-&gt;ip_blocks[i].status.hw =3D true;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0/* right after GMC hw init, we create CSA */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0if (amdgpu_sriov_vf(adev))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0adev-&gt;virt.allocate_csa(adev)<wbr>=
;<br></blockquote></div></div></div><div dir=3D"auto"><br></div><div dir=3D=
"auto">The=C2=A0<span style=3D"font-family:sans-serif;font-size:13.696px">a=
mdgpu_allocate_static_csa function returns a value, presumably an error on =
failure. Shouldn&#39;t the return value be checked here and errors handled?=
</span></div><div dir=3D"auto"><span style=3D"font-family:sans-serif;font-s=
ize:13.696px"><br></span></div><div dir=3D"auto"><font face=3D"sans-serif">=
<span style=3D"font-size:13.696px">Best regards,</span></font></div><div di=
r=3D"auto"><font face=3D"sans-serif"><span style=3D"font-size:13.696px">Nil=
s</span></font></div><div dir=3D"auto"><br></div><div dir=3D"auto"><div cla=
ss=3D"gmail_extra"><div class=3D"gmail_quote"><blockquote class=3D"m_282011=
1108539082759quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;p=
adding-left:1ex">
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
<br>
@@ -1517,6 +1521,9 @@ static int amdgpu_fini(struct amdgpu_device *adev)<br=
>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 adev-&gt;ip_blocks[=
i].status.late<wbr>_initialized =3D false;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (amdgpu_sriov_vf(adev))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0adev-&gt;virt.deall=
ocate_csa(ade<wbr>v);<br>
+<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;<br>
=C2=A0}<br>
<font color=3D"#888888"><br>
--<br>
2.7.4<br>
<br>
______________________________<wbr>_________________<br>
amd-gfx mailing list<br>
<a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" target=3D"_blank">amd-gfx@=
lists.freedesktop.org</a><br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx" rel=3D"n=
oreferrer" target=3D"_blank">https://lists.freedesktop.org/<wbr>mailman/lis=
tinfo/amd-gfx</a><br>
</font></blockquote></div><br></div></div></div>

--94eb2c0d106ed33c9b0545b8d2ae--

--===============1778523437==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1778523437==--
