From: Hillf Danton <hdanton-k+cT0dCbe1g@public.gmane.org>
Subject: [RFC] drm/amdkfd: Use logical cpu id for building vcrat
Date: Tue, 16 Apr 2019 10:39:59 +0800
Message-ID: <20190416071201.109E98961D@gabe.freedesktop.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0880515967=="
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
To: "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: "Mark Nutter <Mark.Nutter-5wv7dgnIgG8@public.gmane.org>" <Mark.Nutter-5wv7dgnIgG8@public.gmane.org>, "Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>" <arnd-r2nGTMty4D4@public.gmane.org>, "Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>" <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, "Felix Kuehling <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>" <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>, "Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>" <alexander.deucher-5C7GfCeVMHo@public.gmane.org>, "Christian Koenig <christian.koenig-5C7GfCeVMHo@public.gmane.org>" <christian.koenig-5C7GfCeVMHo@public.gmane.org>


--===============0880515967==
Content-Type: multipart/alternative;
	boundary="_D8351805-A468-40BD-AC85-85920FD01267_"


--_D8351805-A468-40BD-AC85-85920FD01267_
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Hi folks

In commit d1c234e2cd, arm64 is granted to build kfd. Currently, it is physi=
cal
cpu id that is used for building the x86_64 vcrat, but logical cpu id is us=
ed
instead for arm64, though the function name requires apicid. Can we use the
physical id for both arches if it really has an up-hand over the logical on=
e,
as the following tiny diff represents?

--- linux-5.1-rc4/drivers/gpu/drm/amd/amdkfd/kfd_topology.c	2019-04-16 07:5=
5:56.611685400 +0800
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c	2019-04-16 09:16:50.5061266=
00 +0800
@@ -1405,11 +1405,7 @@ static int kfd_cpumask_to_apic_id(const
	first_cpu_of_numa_node =3D cpumask_first(cpumask);
	if (first_cpu_of_numa_node >=3D nr_cpu_ids)
		return -1;
-#ifdef CONFIG_X86_64
-	return cpu_data(first_cpu_of_numa_node).apicid;
-#else
-	return first_cpu_of_numa_node;
-#endif
+	return cpu_physical_id(first_cpu_of_numa_node);
}
 /* kfd_numa_node_to_apic_id - Returns the APIC ID of the first logical pro=
cessor
--


Or is logical cpu id enough to do the work, with some cosmetic applied to t=
he=20
function names(not included in the following simple diff yet)?

thanks
Hillf


--- linux-5.1-rc4/drivers/gpu/drm/amd/amdkfd/kfd_topology.c	2019-04-16 07:5=
5:56.611685400 +0800
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c	2019-04-16 09:18:24.5465784=
00 +0800
@@ -1405,11 +1405,7 @@ static int kfd_cpumask_to_apic_id(const
	first_cpu_of_numa_node =3D cpumask_first(cpumask);
	if (first_cpu_of_numa_node >=3D nr_cpu_ids)
		return -1;
-#ifdef CONFIG_X86_64
-	return cpu_data(first_cpu_of_numa_node).apicid;
-#else
	return first_cpu_of_numa_node;
-#endif
}
 /* kfd_numa_node_to_apic_id - Returns the APIC ID of the first logical pro=
cessor
--


--_D8351805-A468-40BD-AC85-85920FD01267_
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html; charset="utf-8"

<html xmlns:o=3D"urn:schemas-microsoft-com:office:office" xmlns:w=3D"urn:sc=
hemas-microsoft-com:office:word" xmlns:m=3D"http://schemas.microsoft.com/of=
fice/2004/12/omml" xmlns=3D"http://www.w3.org/TR/REC-html40"><head><meta ht=
tp-equiv=3DContent-Type content=3D"text/html; charset=3Dutf-8"><meta name=
=3DGenerator content=3D"Microsoft Word 15 (filtered medium)"><style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:DengXian;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:DengXian;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	margin-bottom:.0001pt;
	text-align:justify;
	text-justify:inter-ideograph;
	font-size:10.5pt;
	font-family:DengXian;}
.MsoChpDefault
	{mso-style-type:export-only;}
/* Page Definitions */
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:72.0pt 90.0pt 72.0pt 90.0pt;}
div.WordSection1
	{page:WordSection1;}
--></style></head><body lang=3DZH-CN><div class=3DWordSection1><p class=3DM=
soNormal><span lang=3DEN-US>Hi folks</span></p><p class=3DMsoNormal><span l=
ang=3DEN-US><o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal><span lang=3DE=
N-US>In commit d1c234e2cd, arm64 is granted to build kfd. Currently, it is =
physical</span></p><p class=3DMsoNormal><span lang=3DEN-US>cpu id that is u=
sed for building the x86_64 vcrat, but logical cpu id is used</span></p><p =
class=3DMsoNormal><span lang=3DEN-US>instead for arm64, though the function=
 name requires apicid. Can we use the</span></p><p class=3DMsoNormal><span =
lang=3DEN-US>physical id for both arches if it really has an up-hand over t=
he logical one,</span></p><p class=3DMsoNormal><span lang=3DEN-US>as the fo=
llowing tiny diff represents?</span></p><p class=3DMsoNormal><span lang=3DE=
N-US><o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal><span lang=3DEN-US>--=
- linux-5.1-rc4/drivers/gpu/drm/amd/amdkfd/kfd_topology.c=C2=A0=C2=A0=C2=A0=
 2019-04-16 07:55:56.611685400 +0800</span></p><p class=3DMsoNormal><span l=
ang=3DEN-US>+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c 2019-04-16 09:1=
6:50.506126600 +0800</span></p><p class=3DMsoNormal><span lang=3DEN-US>@@ -=
1405,11 +1405,7 @@ static int kfd_cpumask_to_apic_id(const</span></p><p cla=
ss=3DMsoNormal><span lang=3DEN-US>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 firs=
t_cpu_of_numa_node =3D cpumask_first(cpumask);</span></p><p class=3DMsoNorm=
al><span lang=3DEN-US>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (first_cpu_of=
_numa_node &gt;=3D nr_cpu_ids)</span></p><p class=3DMsoNormal><span lang=3D=
EN-US>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 return -1;</span></p><p class=3DMsoNormal><span lang=3DEN-US>-#ifdef CO=
NFIG_X86_64</span></p><p class=3DMsoNormal><span lang=3DEN-US>-=C2=A0=C2=A0=
=C2=A0=C2=A0 return cpu_data(first_cpu_of_numa_node).apicid;</span></p><p c=
lass=3DMsoNormal><span lang=3DEN-US>-#else</span></p><p class=3DMsoNormal><=
span lang=3DEN-US>-=C2=A0=C2=A0=C2=A0=C2=A0 return first_cpu_of_numa_node;<=
/span></p><p class=3DMsoNormal><span lang=3DEN-US>-#endif</span></p><p clas=
s=3DMsoNormal><span lang=3DEN-US>+=C2=A0=C2=A0=C2=A0 return cpu_physical_id=
(first_cpu_of_numa_node);</span></p><p class=3DMsoNormal><span lang=3DEN-US=
>}</span></p><p class=3DMsoNormal><span lang=3DEN-US> /* kfd_numa_node_to_a=
pic_id - Returns the APIC ID of the first logical processor</span></p><p cl=
ass=3DMsoNormal><span lang=3DEN-US>--</span></p><p class=3DMsoNormal><span =
lang=3DEN-US><o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal><span lang=3D=
EN-US><o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal><span lang=3DEN-US>O=
r is logical cpu id enough to do the work, with some cosmetic applied to th=
e </span></p><p class=3DMsoNormal><span lang=3DEN-US>function names(not inc=
luded in the following simple diff yet)?</span></p><p class=3DMsoNormal><sp=
an lang=3DEN-US><o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal><span lang=
=3DEN-US>thanks</span></p><p class=3DMsoNormal><span lang=3DEN-US>Hillf</sp=
an></p><p class=3DMsoNormal><span lang=3DEN-US><o:p>&nbsp;</o:p></span></p>=
<p class=3DMsoNormal><span lang=3DEN-US><o:p>&nbsp;</o:p></span></p><p clas=
s=3DMsoNormal><span lang=3DEN-US>--- linux-5.1-rc4/drivers/gpu/drm/amd/amdk=
fd/kfd_topology.c=C2=A0=C2=A0=C2=A0 2019-04-16 07:55:56.611685400 +0800</sp=
an></p><p class=3DMsoNormal><span lang=3DEN-US>+++ b/drivers/gpu/drm/amd/am=
dkfd/kfd_topology.c 2019-04-16 09:18:24.546578400 +0800</span></p><p class=
=3DMsoNormal><span lang=3DEN-US>@@ -1405,11 +1405,7 @@ static int kfd_cpuma=
sk_to_apic_id(const</span></p><p class=3DMsoNormal><span lang=3DEN-US>=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 first_cpu_of_numa_node =3D cpumask_first(=
cpumask);</span></p><p class=3DMsoNormal><span lang=3DEN-US>=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 if (first_cpu_of_numa_node &gt;=3D nr_cpu_ids)</span>=
</p><p class=3DMsoNormal><span lang=3DEN-US>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -1;</span></p><p class=3D=
MsoNormal><span lang=3DEN-US>-#ifdef CONFIG_X86_64</span></p><p class=3DMso=
Normal><span lang=3DEN-US>-=C2=A0=C2=A0=C2=A0=C2=A0 return cpu_data(first_c=
pu_of_numa_node).apicid;</span></p><p class=3DMsoNormal><span lang=3DEN-US>=
-#else</span></p><p class=3DMsoNormal><span lang=3DEN-US>=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 return first_cpu_of_numa_node;</span></p><p class=3DMsoN=
ormal><span lang=3DEN-US>-#endif</span></p><p class=3DMsoNormal><span lang=
=3DEN-US>}</span></p><p class=3DMsoNormal><span lang=3DEN-US> /* kfd_numa_n=
ode_to_apic_id - Returns the APIC ID of the first logical processor</span><=
/p><p class=3DMsoNormal><span lang=3DEN-US>--</span><span lang=3DEN-US styl=
e=3D'font-size:12.0pt'><o:p></o:p></span></p><p class=3DMsoNormal><span lan=
g=3DEN-US><o:p>&nbsp;</o:p></span></p></div></body></html>=

--_D8351805-A468-40BD-AC85-85920FD01267_--



--===============0880515967==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============0880515967==--
