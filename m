From: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 10/21] drm/amdgpu: wire up emit_wreg for UVD v6
Date: Wed, 17 Jan 2018 14:22:39 +0000
Message-ID: <BN6PR12MB1652DE27EE111B57EC39AA78F7E90@BN6PR12MB1652.namprd12.prod.outlook.com>
References: <20180116194017.39067-1-christian.koenig@amd.com>
 <20180116194017.39067-10-christian.koenig@amd.com>
 <CADnq5_Pc2QujuEDmsb8O2E0-VGmMgSCkN2K-B4O_1y-3zrQE7A@mail.gmail.com>,
 <c33f3adf-66d4-1d37-ebc9-cf3ab7d1b967@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0711127676=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <c33f3adf-66d4-1d37-ebc9-cf3ab7d1b967-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
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
To: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "Koenig, Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>
Cc: amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============0711127676==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BN6PR12MB1652DE27EE111B57EC39AA78F7E90BN6PR12MB1652namp_"

--_000_BN6PR12MB1652DE27EE111B57EC39AA78F7E90BN6PR12MB1652namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable


________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of Christia=
n K=F6nig <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sent: Wednesday, January 17, 2018 7:42 AM
To: Alex Deucher
Cc: amd-gfx list
Subject: Re: [PATCH 10/21] drm/amdgpu: wire up emit_wreg for UVD v6

Am 16.01.2018 um 21:01 schrieb Alex Deucher:
> On Tue, Jan 16, 2018 at 2:40 PM, Christian K=F6nig
> <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
>> Needed for vm_flush unification.
>>
>> Signed-off-by: Christian K=F6nig <christian.koenig-5C7GfCeVMHo@public.gmane.org>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c | 12 ++++++++++++
>>   1 file changed, 12 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c b/drivers/gpu/drm/amd=
/amdgpu/uvd_v6_0.c
>> index c6e22eff89e7..b48b843c66ae 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
>> @@ -1059,6 +1059,17 @@ static void uvd_v6_0_enc_ring_emit_ib(struct amdg=
pu_ring *ring,
>>          amdgpu_ring_write(ring, ib->length_dw);
>>   }
>>
>> +static void uvd_v6_0_ring_emit_wreg(struct amdgpu_ring *ring,
>> +                                   uint32_t reg, uint32_t val)
>> +{
>> +       amdgpu_ring_write(ring, PACKET0(mmUVD_GPCOM_VCPU_DATA0, 0));
>> +       amdgpu_ring_write(ring, reg << 2);
>> +       amdgpu_ring_write(ring, PACKET0(mmUVD_GPCOM_VCPU_DATA1, 0));
>> +       amdgpu_ring_write(ring, val);
>> +       amdgpu_ring_write(ring, PACKET0(mmUVD_GPCOM_VCPU_CMD, 0));
>> +       amdgpu_ring_write(ring, 0x8);
> Is this valid on UVD6?

This is valid on the decode ring of UVD6, only the HEVC UVD6 encode and
VCE3 rings use different commands.

>    I think this may be a UVD7 thing.  Looking at
> the other UVD code, I think we just want:
>          amdgpu_ring_write(ring, PACKET0(reg, 0));
>          amdgpu_ring_write(ring, val);

IIRC that won't work. The UVD RBC can only write to UVD registers using
the PACKET0 command.

We probably need to fix a bunch of functions in uvd4,5,6,7 in that case whi=
ch use packet0 directly to write non-UVD registers.

Alex


Regards,
Christian.

>
> Alex
>
>
>> +}
>> +
>>   static void uvd_v6_0_ring_emit_vm_flush(struct amdgpu_ring *ring,
>>                                          unsigned vmid, unsigned pasid,
>>                                          uint64_t pd_addr)
>> @@ -1595,6 +1606,7 @@ static const struct amdgpu_ring_funcs uvd_v6_0_rin=
g_vm_funcs =3D {
>>          .pad_ib =3D amdgpu_ring_generic_pad_ib,
>>          .begin_use =3D amdgpu_uvd_ring_begin_use,
>>          .end_use =3D amdgpu_uvd_ring_end_use,
>> +       .emit_wreg =3D uvd_v6_0_ring_emit_wreg,
>>   };
>>
>>   static const struct amdgpu_ring_funcs uvd_v6_0_enc_ring_vm_funcs =3D {
>> --
>> 2.14.1
>>
>> _______________________________________________
>> amd-gfx mailing list
>> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
>> https://lists.freedesktop.org/mailman/listinfo/amd-gfx

_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_BN6PR12MB1652DE27EE111B57EC39AA78F7E90BN6PR12MB1652namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"><!-- P {margin-top:0;margi=
n-bottom:0;} --></style>
</head>
<body dir=3D"ltr">
<div id=3D"divtagdefaultwrapper" style=3D"font-size: 12pt; color: rgb(0, 0,=
 0); font-family: Calibri, Helvetica, sans-serif, &quot;EmojiFont&quot;, &q=
uot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, NotoColorEmoji, &q=
uot;Segoe UI Symbol&quot;, &quot;Android Emoji&quot;, EmojiSymbols;" dir=3D=
"ltr">
<p style=3D"margin-top:0;margin-bottom:0"><br>
</p>
<div style=3D"color: rgb(0, 0, 0);">
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font style=3D"font-size:11pt" face=
=3D"Calibri, sans-serif" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx=
-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; on behalf of Christian K=F6nig &lt;ckoen=
ig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org&gt;<br>
<b>Sent:</b> Wednesday, January 17, 2018 7:42 AM<br>
<b>To:</b> Alex Deucher<br>
<b>Cc:</b> amd-gfx list<br>
<b>Subject:</b> Re: [PATCH 10/21] drm/amdgpu: wire up emit_wreg for UVD v6<=
/font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Am 16.01.2018 um 21:01 schrieb Alex Deucher:<br>
&gt; On Tue, Jan 16, 2018 at 2:40 PM, Christian K=F6nig<br>
&gt; &lt;ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org&gt; wrote:<br>
&gt;&gt; Needed for vm_flush unification.<br>
&gt;&gt;<br>
&gt;&gt; Signed-off-by: Christian K=F6nig &lt;christian.koenig-5C7GfCeVMHo@public.gmane.org&gt;<=
br>
&gt;&gt; ---<br>
&gt;&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c | 12 &#43;&#43;&=
#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;<br>
&gt;&gt;&nbsp;&nbsp; 1 file changed, 12 insertions(&#43;)<br>
&gt;&gt;<br>
&gt;&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c b/drivers/gpu/d=
rm/amd/amdgpu/uvd_v6_0.c<br>
&gt;&gt; index c6e22eff89e7..b48b843c66ae 100644<br>
&gt;&gt; --- a/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c<br>
&gt;&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c<br>
&gt;&gt; @@ -1059,6 &#43;1059,17 @@ static void uvd_v6_0_enc_ring_emit_ib(s=
truct amdgpu_ring *ring,<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_=
write(ring, ib-&gt;length_dw);<br>
&gt;&gt;&nbsp;&nbsp; }<br>
&gt;&gt;<br>
&gt;&gt; &#43;static void uvd_v6_0_ring_emit_wreg(struct amdgpu_ring *ring,=
<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32=
_t reg, uint32_t val)<br>
&gt;&gt; &#43;{<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_write(ring, =
PACKET0(mmUVD_GPCOM_VCPU_DATA0, 0));<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_write(ring, =
reg &lt;&lt; 2);<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_write(ring, =
PACKET0(mmUVD_GPCOM_VCPU_DATA1, 0));<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_write(ring, =
val);<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_write(ring, =
PACKET0(mmUVD_GPCOM_VCPU_CMD, 0));<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_write(ring, =
0x8);<br>
&gt; Is this valid on UVD6?<br>
<br>
This is valid on the decode ring of UVD6, only the HEVC UVD6 encode and <br=
>
VCE3 rings use different commands.<br>
<br>
&gt;&nbsp;&nbsp;&nbsp; I think this may be a UVD7 thing.&nbsp; Looking at<b=
r>
&gt; the other UVD code, I think we just want:<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_writ=
e(ring, PACKET0(reg, 0));<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_writ=
e(ring, val);<br>
<br>
IIRC that won't work. The UVD RBC can only write to UVD registers using <br=
>
the PACKET0 command.</div>
<div class=3D"PlainText"><br>
</div>
<div class=3D"PlainText">We probably need to fix a bunch of functions in uv=
d4,5,6,7 in that case which use packet0 directly to write non-UVD registers=
.<br>
</div>
<div class=3D"PlainText"><br>
</div>
<div class=3D"PlainText">Alex<br>
</div>
<div class=3D"PlainText"><br>
<br>
Regards,<br>
Christian.<br>
<br>
&gt;<br>
&gt; Alex<br>
&gt;<br>
&gt;<br>
&gt;&gt; &#43;}<br>
&gt;&gt; &#43;<br>
&gt;&gt;&nbsp;&nbsp; static void uvd_v6_0_ring_emit_vm_flush(struct amdgpu_=
ring *ring,<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned vmid, unsigned pasid,<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t pd_addr)<br>
&gt;&gt; @@ -1595,6 &#43;1606,7 @@ static const struct amdgpu_ring_funcs uv=
d_v6_0_ring_vm_funcs =3D {<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .pad_ib =3D =
amdgpu_ring_generic_pad_ib,<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .begin_use =
=3D amdgpu_uvd_ring_begin_use,<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .end_use =3D=
 amdgpu_uvd_ring_end_use,<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .emit_wreg =3D uvd_v6_0_=
ring_emit_wreg,<br>
&gt;&gt;&nbsp;&nbsp; };<br>
&gt;&gt;<br>
&gt;&gt;&nbsp;&nbsp; static const struct amdgpu_ring_funcs uvd_v6_0_enc_rin=
g_vm_funcs =3D {<br>
&gt;&gt; --<br>
&gt;&gt; 2.14.1<br>
&gt;&gt;<br>
&gt;&gt; _______________________________________________<br>
&gt;&gt; amd-gfx mailing list<br>
&gt;&gt; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
&gt;&gt; <a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx"=
 id=3D"LPlnk963697" previewremoved=3D"true">
https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a><br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx" id=3D"LP=
lnk476865" previewremoved=3D"true">https://lists.freedesktop.org/mailman/li=
stinfo/amd-gfx</a><br>
</div>
</span></font></div>
</div>
</div>
</body>
</html>

--_000_BN6PR12MB1652DE27EE111B57EC39AA78F7E90BN6PR12MB1652namp_--

--===============0711127676==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0711127676==--
