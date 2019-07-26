From: "Thai, Thong" <Thong.Thai-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 1/2] drm/amd/amdgpu/vcn_v2_0: Mark RB commands as KMD
 commands
Date: Fri, 26 Jul 2019 10:45:01 +0000
Message-ID: <BN6PR1201MB0178F74D883BC13DD35CDC369DC00@BN6PR1201MB0178.namprd12.prod.outlook.com>
References: <20190725155204.5739-1-thong.thai@amd.com>,
 <2a7d972a-5916-7d00-c8ad-5ff33363d993@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1076389457=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <2a7d972a-5916-7d00-c8ad-5ff33363d993-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Content-Language: en-CA
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
To: "Koenig, Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============1076389457==
Content-Language: en-CA
Content-Type: multipart/alternative;
	boundary="_000_BN6PR1201MB0178F74D883BC13DD35CDC369DC00BN6PR1201MB0178_"

--_000_BN6PR1201MB0178F74D883BC13DD35CDC369DC00BN6PR1201MB0178_
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

Well, not through this particular piece of code, since this explicitly sets=
 it. But I would imagine someone could set the bit in userspace and insert =
KMD commands in the BO as part of some IB instructions - I=92ll have a look=
.

________________________________
From: Christian K=F6nig <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sent: Friday, July 26, 2019 3:17:19 AM
To: Thai, Thong <Thong.Thai-5C7GfCeVMHo@public.gmane.org>; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org <amd-gf=
x@lists.freedesktop.org>
Subject: Re: [PATCH 1/2] drm/amd/amdgpu/vcn_v2_0: Mark RB commands as KMD c=
ommands

Am 25.07.19 um 17:52 schrieb Thai, Thong:
> Sets the CMD_SOURCE bit for VCN 2.0 Decoder Ring Buffer commands. This
> bit was previously set by the RBC HW on older firmware. Newer firmware
> uses a SW RBC and this bit has to be set by the driver.

Mhm, another question came to my mind: Would it now be possible for user
space to set this flag and and gain access to the kernel driver commands?

Cause that could be a security problem.

Christian.

>
> Signed-off-by: Thong Thai <thong.thai-5C7GfCeVMHo@public.gmane.org>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h |  1 +
>   drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c   | 12 ++++++------
>   2 files changed, 7 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_vcn.h
> index 5e2453ee6b29..4d3bf4adf1eb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> @@ -30,6 +30,7 @@
>   #define AMDGPU_VCN_FIRMWARE_OFFSET  256
>   #define AMDGPU_VCN_MAX_ENC_RINGS    3
>
> +#define VCN_DEC_KMD_CMD                      0x80000000
>   #define VCN_DEC_CMD_FENCE           0x00000000
>   #define VCN_DEC_CMD_TRAP            0x00000001
>   #define VCN_DEC_CMD_WRITE_REG               0x00000004
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c b/drivers/gpu/drm/amd/=
amdgpu/vcn_v2_0.c
> index bc9726787c97..7091aef95ff0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
> @@ -1488,7 +1488,7 @@ static void vcn_v2_0_dec_ring_insert_start(struct a=
mdgpu_ring *ring)
>        amdgpu_ring_write(ring, PACKET0(mmUVD_GPCOM_VCPU_DATA0_INTERNAL_OF=
FSET, 0));
>        amdgpu_ring_write(ring, 0);
>        amdgpu_ring_write(ring, PACKET0(mmUVD_GPCOM_VCPU_CMD_INTERNAL_OFFS=
ET, 0));
> -     amdgpu_ring_write(ring, VCN_DEC_CMD_PACKET_START << 1);
> +     amdgpu_ring_write(ring, VCN_DEC_KMD_CMD | (VCN_DEC_CMD_PACKET_START=
 << 1));
>   }
>
>   /**
> @@ -1501,7 +1501,7 @@ static void vcn_v2_0_dec_ring_insert_start(struct a=
mdgpu_ring *ring)
>   static void vcn_v2_0_dec_ring_insert_end(struct amdgpu_ring *ring)
>   {
>        amdgpu_ring_write(ring, PACKET0(mmUVD_GPCOM_VCPU_CMD_INTERNAL_OFFS=
ET, 0));
> -     amdgpu_ring_write(ring, VCN_DEC_CMD_PACKET_END << 1);
> +     amdgpu_ring_write(ring, VCN_DEC_KMD_CMD | (VCN_DEC_CMD_PACKET_END <=
< 1));
>   }
>
>   /**
> @@ -1546,7 +1546,7 @@ static void vcn_v2_0_dec_ring_emit_fence(struct amd=
gpu_ring *ring, u64 addr, u64
>        amdgpu_ring_write(ring, upper_32_bits(addr) & 0xff);
>
>        amdgpu_ring_write(ring, PACKET0(mmUVD_GPCOM_VCPU_CMD_INTERNAL_OFFS=
ET, 0));
> -     amdgpu_ring_write(ring, VCN_DEC_CMD_FENCE << 1);
> +     amdgpu_ring_write(ring, VCN_DEC_KMD_CMD | (VCN_DEC_CMD_FENCE << 1))=
;
>
>        amdgpu_ring_write(ring, PACKET0(mmUVD_GPCOM_VCPU_DATA0_INTERNAL_OF=
FSET, 0));
>        amdgpu_ring_write(ring, 0);
> @@ -1556,7 +1556,7 @@ static void vcn_v2_0_dec_ring_emit_fence(struct amd=
gpu_ring *ring, u64 addr, u64
>
>        amdgpu_ring_write(ring, PACKET0(mmUVD_GPCOM_VCPU_CMD_INTERNAL_OFFS=
ET, 0));
>
> -     amdgpu_ring_write(ring, VCN_DEC_CMD_TRAP << 1);
> +     amdgpu_ring_write(ring, VCN_DEC_KMD_CMD | (VCN_DEC_CMD_TRAP << 1));
>   }
>
>   /**
> @@ -1600,7 +1600,7 @@ static void vcn_v2_0_dec_ring_emit_reg_wait(struct =
amdgpu_ring *ring,
>
>        amdgpu_ring_write(ring, PACKET0(mmUVD_GPCOM_VCPU_CMD_INTERNAL_OFFS=
ET, 0));
>
> -     amdgpu_ring_write(ring, VCN_DEC_CMD_REG_READ_COND_WAIT << 1);
> +     amdgpu_ring_write(ring, VCN_DEC_KMD_CMD | (VCN_DEC_CMD_REG_READ_CON=
D_WAIT << 1));
>   }
>
>   static void vcn_v2_0_dec_ring_emit_vm_flush(struct amdgpu_ring *ring,
> @@ -1629,7 +1629,7 @@ static void vcn_v2_0_dec_ring_emit_wreg(struct amdg=
pu_ring *ring,
>
>        amdgpu_ring_write(ring, PACKET0(mmUVD_GPCOM_VCPU_CMD_INTERNAL_OFFS=
ET, 0));
>
> -     amdgpu_ring_write(ring, VCN_DEC_CMD_WRITE_REG << 1);
> +     amdgpu_ring_write(ring, VCN_DEC_KMD_CMD | (VCN_DEC_CMD_WRITE_REG <<=
 1));
>   }
>
>   /**


--_000_BN6PR1201MB0178F74D883BC13DD35CDC369DC00BN6PR1201MB0178_
Content-Type: text/html; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3DWindows-1=
252">
<meta name=3D"Generator" content=3D"Microsoft Exchange Server">
<!-- converted from text --><style><!-- .EmailQuote { margin-left: 1pt; pad=
ding-left: 4pt; border-left: #800000 2px solid; } --></style>
</head>
<body>
<div>
<div>
<div>
<div style=3D"direction:ltr">Well, not through this particular piece of cod=
e, since this explicitly sets it. But I would imagine someone could set the=
 bit in userspace and insert KMD commands in the BO as part of some IB inst=
ructions - I=92ll have a look.</div>
</div>
<div><br>
</div>
<div class=3D"x_ms-outlook-ios-signature"></div>
</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"x_divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" =
color=3D"#000000" style=3D"font-size:11pt"><b>From:</b> Christian K=F6nig &=
lt;ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org&gt;<br>
<b>Sent:</b> Friday, July 26, 2019 3:17:19 AM<br>
<b>To:</b> Thai, Thong &lt;Thong.Thai-5C7GfCeVMHo@public.gmane.org&gt;; amd-gfx-PD4FTy7X32lNgt0PjOBp9w@public.gmane.org=
p.org &lt;amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt;<br>
<b>Subject:</b> Re: [PATCH 1/2] drm/amd/amdgpu/vcn_v2_0: Mark RB commands a=
s KMD commands</font>
<div>&nbsp;</div>
</div>
</div>
<font size=3D"2"><span style=3D"font-size:11pt;">
<div class=3D"PlainText">Am 25.07.19 um 17:52 schrieb Thai, Thong:<br>
&gt; Sets the CMD_SOURCE bit for VCN 2.0 Decoder Ring Buffer commands. This=
<br>
&gt; bit was previously set by the RBC HW on older firmware. Newer firmware=
<br>
&gt; uses a SW RBC and this bit has to be set by the driver.<br>
<br>
Mhm, another question came to my mind: Would it now be possible for user <b=
r>
space to set this flag and and gain access to the kernel driver commands?<b=
r>
<br>
Cause that could be a security problem.<br>
<br>
Christian.<br>
<br>
&gt;<br>
&gt; Signed-off-by: Thong Thai &lt;thong.thai-5C7GfCeVMHo@public.gmane.org&gt;<br>
&gt; ---<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h |&nbsp; 1 &#43;<br=
>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c&nbsp;&nbsp; | 12 &#4=
3;&#43;&#43;&#43;&#43;&#43;------<br>
&gt;&nbsp;&nbsp; 2 files changed, 7 insertions(&#43;), 6 deletions(-)<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_vcn.h<br>
&gt; index 5e2453ee6b29..4d3bf4adf1eb 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h<br>
&gt; @@ -30,6 &#43;30,7 @@<br>
&gt;&nbsp;&nbsp; #define AMDGPU_VCN_FIRMWARE_OFFSET&nbsp; 256<br>
&gt;&nbsp;&nbsp; #define AMDGPU_VCN_MAX_ENC_RINGS&nbsp;&nbsp;&nbsp; 3<br>
&gt;&nbsp;&nbsp; <br>
&gt; &#43;#define VCN_DEC_KMD_CMD&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; 0x80000000<br>
&gt;&nbsp;&nbsp; #define VCN_DEC_CMD_FENCE&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; 0x00000000<br>
&gt;&nbsp;&nbsp; #define VCN_DEC_CMD_TRAP&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x00000001<br>
&gt;&nbsp;&nbsp; #define VCN_DEC_CMD_WRITE_REG&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x00000004<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c b/drivers/gpu/drm/a=
md/amdgpu/vcn_v2_0.c<br>
&gt; index bc9726787c97..7091aef95ff0 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c<br>
&gt; @@ -1488,7 &#43;1488,7 @@ static void vcn_v2_0_dec_ring_insert_start(s=
truct amdgpu_ring *ring)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_write(ring, PACK=
ET0(mmUVD_GPCOM_VCPU_DATA0_INTERNAL_OFFSET, 0));<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_write(ring, 0);<=
br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_write(ring, PACK=
ET0(mmUVD_GPCOM_VCPU_CMD_INTERNAL_OFFSET, 0));<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_write(ring, VCN_DEC_CMD_PACKET_S=
TART &lt;&lt; 1);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_write(ring, VCN_DEC_KMD_CMD =
| (VCN_DEC_CMD_PACKET_START &lt;&lt; 1));<br>
&gt;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp; /**<br>
&gt; @@ -1501,7 &#43;1501,7 @@ static void vcn_v2_0_dec_ring_insert_start(s=
truct amdgpu_ring *ring)<br>
&gt;&nbsp;&nbsp; static void vcn_v2_0_dec_ring_insert_end(struct amdgpu_rin=
g *ring)<br>
&gt;&nbsp;&nbsp; {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_write(ring, PACK=
ET0(mmUVD_GPCOM_VCPU_CMD_INTERNAL_OFFSET, 0));<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_write(ring, VCN_DEC_CMD_PACKET_E=
ND &lt;&lt; 1);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_write(ring, VCN_DEC_KMD_CMD =
| (VCN_DEC_CMD_PACKET_END &lt;&lt; 1));<br>
&gt;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp; /**<br>
&gt; @@ -1546,7 &#43;1546,7 @@ static void vcn_v2_0_dec_ring_emit_fence(str=
uct amdgpu_ring *ring, u64 addr, u64<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_write(ring, uppe=
r_32_bits(addr) &amp; 0xff);<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_write(ring, PACK=
ET0(mmUVD_GPCOM_VCPU_CMD_INTERNAL_OFFSET, 0));<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_write(ring, VCN_DEC_CMD_FENCE &l=
t;&lt; 1);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_write(ring, VCN_DEC_KMD_CMD =
| (VCN_DEC_CMD_FENCE &lt;&lt; 1));<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_write(ring, PACK=
ET0(mmUVD_GPCOM_VCPU_DATA0_INTERNAL_OFFSET, 0));<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_write(ring, 0);<=
br>
&gt; @@ -1556,7 &#43;1556,7 @@ static void vcn_v2_0_dec_ring_emit_fence(str=
uct amdgpu_ring *ring, u64 addr, u64<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_write(ring, PACK=
ET0(mmUVD_GPCOM_VCPU_CMD_INTERNAL_OFFSET, 0));<br>
&gt;&nbsp;&nbsp; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_write(ring, VCN_DEC_CMD_TRAP &lt=
;&lt; 1);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_write(ring, VCN_DEC_KMD_CMD =
| (VCN_DEC_CMD_TRAP &lt;&lt; 1));<br>
&gt;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp; /**<br>
&gt; @@ -1600,7 &#43;1600,7 @@ static void vcn_v2_0_dec_ring_emit_reg_wait(=
struct amdgpu_ring *ring,<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_write(ring, PACK=
ET0(mmUVD_GPCOM_VCPU_CMD_INTERNAL_OFFSET, 0));<br>
&gt;&nbsp;&nbsp; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_write(ring, VCN_DEC_CMD_REG_READ=
_COND_WAIT &lt;&lt; 1);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_write(ring, VCN_DEC_KMD_CMD =
| (VCN_DEC_CMD_REG_READ_COND_WAIT &lt;&lt; 1));<br>
&gt;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp; static void vcn_v2_0_dec_ring_emit_vm_flush(struct amdgpu_=
ring *ring,<br>
&gt; @@ -1629,7 &#43;1629,7 @@ static void vcn_v2_0_dec_ring_emit_wreg(stru=
ct amdgpu_ring *ring,<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_write(ring, PACK=
ET0(mmUVD_GPCOM_VCPU_CMD_INTERNAL_OFFSET, 0));<br>
&gt;&nbsp;&nbsp; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_write(ring, VCN_DEC_CMD_WRITE_RE=
G &lt;&lt; 1);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_write(ring, VCN_DEC_KMD_CMD =
| (VCN_DEC_CMD_WRITE_REG &lt;&lt; 1));<br>
&gt;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp; /**<br>
<br>
</div>
</span></font>
</body>
</html>

--_000_BN6PR1201MB0178F74D883BC13DD35CDC369DC00BN6PR1201MB0178_--

--===============1076389457==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============1076389457==--
