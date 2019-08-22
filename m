From: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 2/2] drm/radeon: use WAIT_REG_MEM special op for CP HDP
 flush
Date: Thu, 22 Aug 2019 12:47:51 +0000
Message-ID: <BN6PR12MB1809C8AD78F826E8D3CD30F4F7A50@BN6PR12MB1809.namprd12.prod.outlook.com>
References: <20190821222034.13387-1-alexander.deucher@amd.com>
 <20190821222034.13387-5-alexander.deucher@amd.com>,
 <217a929a-543f-7aa4-4494-3569f9998a97@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1592280231=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <217a929a-543f-7aa4-4494-3569f9998a97-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
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
To: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "Koenig, Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>

--===============1592280231==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BN6PR12MB1809C8AD78F826E8D3CD30F4F7A50BN6PR12MB1809namp_"

--_000_BN6PR12MB1809C8AD78F826E8D3CD30F4F7A50BN6PR12MB1809namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

This was an old patch I accidentally sent out.  Please ignore.

Alex
________________________________
From: Christian K?nig <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sent: Thursday, August 22, 2019 5:32 AM
To: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org <am=
d-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: Deucher, Alexander <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 2/2] drm/radeon: use WAIT_REG_MEM special op for CP HDP=
 flush

Every time we actually tried this it just ended in users reporting CP hangs=
.

Christian.

Am 22.08.19 um 00:20 schrieb Alex Deucher:
> Flush via the ring works differently on CIK and requires a
> special sequence.
>
> Signed-off-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
> ---
>   drivers/gpu/drm/radeon/cik.c | 73 +++++++++++++++++++++++++++----------=
-------
>   1 file changed, 45 insertions(+), 28 deletions(-)
>
> diff --git a/drivers/gpu/drm/radeon/cik.c b/drivers/gpu/drm/radeon/cik.c
> index 0847367..03dd075 100644
> --- a/drivers/gpu/drm/radeon/cik.c
> +++ b/drivers/gpu/drm/radeon/cik.c
> @@ -3485,6 +3485,48 @@ int cik_ring_test(struct radeon_device *rdev, stru=
ct radeon_ring *ring)
>        return r;
>   }
>
> +static void cik_gfx_hdp_flush(struct radeon_device *rdev,
> +                           int ridx)
> +{
> +     struct radeon_ring *ring =3D &rdev->ring[ridx];
> +     u32 ref_and_mask;
> +
> +     switch (ring->idx) {
> +     case CAYMAN_RING_TYPE_CP1_INDEX:
> +     case CAYMAN_RING_TYPE_CP2_INDEX:
> +             switch (ring->me) {
> +             case 0:
> +                     ref_and_mask =3D CP2 << ring->pipe;
> +                     break;
> +             case 1:
> +                     ref_and_mask =3D CP6 << ring->pipe;
> +                     break;
> +             default:
> +                     return;
> +             }
> +             break;
> +     case RADEON_RING_TYPE_GFX_INDEX:
> +             ref_and_mask =3D CP0;
> +             break;
> +     default:
> +             return;
> +     }
> +
> +     radeon_ring_write(ring, PACKET3(PACKET3_SET_UCONFIG_REG, 1));
> +     radeon_ring_write(ring, ((CP_WAIT_REG_MEM_TIMEOUT -
> +                               PACKET3_SET_UCONFIG_REG_START) >> 2));
> +     radeon_ring_write(ring, 0xfff);
> +
> +     radeon_ring_write(ring, PACKET3(PACKET3_WAIT_REG_MEM, 5));
> +     radeon_ring_write(ring, (WAIT_REG_MEM_OPERATION(1) | /* special op =
*/
> +                              WAIT_REG_MEM_FUNCTION(3))); /* =3D=3D */
> +     radeon_ring_write(ring, GPU_HDP_FLUSH_REQ >> 2);
> +     radeon_ring_write(ring, GPU_HDP_FLUSH_DONE >> 2);
> +     radeon_ring_write(ring, ref_and_mask);
> +     radeon_ring_write(ring, ref_and_mask);
> +     radeon_ring_write(ring, 0xa); /* poll interval */
> +}
> +
>   /**
>    * cik_fence_gfx_ring_emit - emit a fence on the gfx ring
>    *
> @@ -3511,15 +3553,7 @@ void cik_fence_gfx_ring_emit(struct radeon_device =
*rdev,
>        radeon_ring_write(ring, fence->seq);
>        radeon_ring_write(ring, 0);
>        /* HDP flush */
> -     /* We should be using the new WAIT_REG_MEM special op packet here
> -      * but it causes the CP to hang
> -      */
> -     radeon_ring_write(ring, PACKET3(PACKET3_WRITE_DATA, 3));
> -     radeon_ring_write(ring, (WRITE_DATA_ENGINE_SEL(0) |
> -                              WRITE_DATA_DST_SEL(0)));
> -     radeon_ring_write(ring, HDP_MEM_COHERENCY_FLUSH_CNTL >> 2);
> -     radeon_ring_write(ring, 0);
> -     radeon_ring_write(ring, 0);
> +     cik_gfx_hdp_flush(rdev, fence->ring);
>   }
>
>   /**
> @@ -3549,15 +3583,7 @@ void cik_fence_compute_ring_emit(struct radeon_dev=
ice *rdev,
>        radeon_ring_write(ring, fence->seq);
>        radeon_ring_write(ring, 0);
>        /* HDP flush */
> -     /* We should be using the new WAIT_REG_MEM special op packet here
> -      * but it causes the CP to hang
> -      */
> -     radeon_ring_write(ring, PACKET3(PACKET3_WRITE_DATA, 3));
> -     radeon_ring_write(ring, (WRITE_DATA_ENGINE_SEL(0) |
> -                              WRITE_DATA_DST_SEL(0)));
> -     radeon_ring_write(ring, HDP_MEM_COHERENCY_FLUSH_CNTL >> 2);
> -     radeon_ring_write(ring, 0);
> -     radeon_ring_write(ring, 0);
> +     cik_gfx_hdp_flush(rdev, fence->ring);
>   }
>
>   bool cik_semaphore_ring_emit(struct radeon_device *rdev,
> @@ -5369,16 +5395,7 @@ void cik_vm_flush(struct radeon_device *rdev, int =
ridx, struct radeon_vm *vm)
>        radeon_ring_write(ring, VMID(0));
>
>        /* HDP flush */
> -     /* We should be using the WAIT_REG_MEM packet here like in
> -      * cik_fence_ring_emit(), but it causes the CP to hang in this
> -      * context...
> -      */
> -     radeon_ring_write(ring, PACKET3(PACKET3_WRITE_DATA, 3));
> -     radeon_ring_write(ring, (WRITE_DATA_ENGINE_SEL(0) |
> -                              WRITE_DATA_DST_SEL(0)));
> -     radeon_ring_write(ring, HDP_MEM_COHERENCY_FLUSH_CNTL >> 2);
> -     radeon_ring_write(ring, 0);
> -     radeon_ring_write(ring, 0);
> +     cik_gfx_hdp_flush(rdev, ridx);
>
>        /* bits 0-15 are the VM contexts0-15 */
>        radeon_ring_write(ring, PACKET3(PACKET3_WRITE_DATA, 3));


--_000_BN6PR12MB1809C8AD78F826E8D3CD30F4F7A50BN6PR12MB1809namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
This was an old patch I accidentally sent out.&nbsp; Please ignore.</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Alex<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Christian K&ouml;nig =
&lt;ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org&gt;<br>
<b>Sent:</b> Thursday, August 22, 2019 5:32 AM<br>
<b>To:</b> Alex Deucher &lt;alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org&gt;; amd-gfx-PD4FTy7X32lMiVNPc3mojA@public.gmane.org=
sktop.org &lt;amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt;<br>
<b>Cc:</b> Deucher, Alexander &lt;Alexander.Deucher-5C7GfCeVMHo@public.gmane.org&gt;<br>
<b>Subject:</b> Re: [PATCH 2/2] drm/radeon: use WAIT_REG_MEM special op for=
 CP HDP flush</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Every time we actually tried this it just ended in=
 users reporting CP hangs.<br>
<br>
Christian.<br>
<br>
Am 22.08.19 um 00:20 schrieb Alex Deucher:<br>
&gt; Flush via the ring works differently on CIK and requires a<br>
&gt; special sequence.<br>
&gt;<br>
&gt; Signed-off-by: Alex Deucher &lt;alexander.deucher-5C7GfCeVMHo@public.gmane.org&gt;<br>
&gt; ---<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/radeon/cik.c | 73 &#43;&#43;&#43;&#43;&#43=
;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43=
;&#43;&#43;&#43;&#43;&#43;&#43;&#43;-----------------<br>
&gt;&nbsp;&nbsp; 1 file changed, 45 insertions(&#43;), 28 deletions(-)<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/radeon/cik.c b/drivers/gpu/drm/radeon/cik=
.c<br>
&gt; index 0847367..03dd075 100644<br>
&gt; --- a/drivers/gpu/drm/radeon/cik.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/radeon/cik.c<br>
&gt; @@ -3485,6 &#43;3485,48 @@ int cik_ring_test(struct radeon_device *rde=
v, struct radeon_ring *ring)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;<br>
&gt;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp; <br>
&gt; &#43;static void cik_gfx_hdp_flush(struct radeon_device *rdev,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; int ridx)<br>
&gt; &#43;{<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; struct radeon_ring *ring =3D &amp;rdev-&=
gt;ring[ridx];<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; u32 ref_and_mask;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; switch (ring-&gt;idx) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; case CAYMAN_RING_TYPE_CP1_INDEX:<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; case CAYMAN_RING_TYPE_CP2_INDEX:<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; switch (ring-&gt;me) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; case 0:<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ref_and_mask =3D CP=
2 &lt;&lt; ring-&gt;pipe;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; case 1:<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ref_and_mask =3D CP=
6 &lt;&lt; ring-&gt;pipe;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; default:<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; }<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; break;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; case RADEON_RING_TYPE_GFX_INDEX:<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; ref_and_mask =3D CP0;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; break;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; default:<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; return;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; radeon_ring_write(ring, PACKET3(PACKET3_=
SET_UCONFIG_REG, 1));<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; radeon_ring_write(ring, ((CP_WAIT_REG_ME=
M_TIMEOUT -<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PACKET3_SET_UCONFIG_REG_START) &gt=
;&gt; 2));<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; radeon_ring_write(ring, 0xfff);<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; radeon_ring_write(ring, PACKET3(PACKET3_=
WAIT_REG_MEM, 5));<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; radeon_ring_write(ring, (WAIT_REG_MEM_OP=
ERATION(1) | /* special op */<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WAIT_REG_MEM_FUNCTION(3))); /* =3D=3D */=
<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; radeon_ring_write(ring, GPU_HDP_FLUSH_RE=
Q &gt;&gt; 2);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; radeon_ring_write(ring, GPU_HDP_FLUSH_DO=
NE &gt;&gt; 2);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; radeon_ring_write(ring, ref_and_mask);<b=
r>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; radeon_ring_write(ring, ref_and_mask);<b=
r>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; radeon_ring_write(ring, 0xa); /* poll in=
terval */<br>
&gt; &#43;}<br>
&gt; &#43;<br>
&gt;&nbsp;&nbsp; /**<br>
&gt;&nbsp;&nbsp;&nbsp; * cik_fence_gfx_ring_emit - emit a fence on the gfx =
ring<br>
&gt;&nbsp;&nbsp;&nbsp; *<br>
&gt; @@ -3511,15 &#43;3553,7 @@ void cik_fence_gfx_ring_emit(struct radeon_=
device *rdev,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; radeon_ring_write(ring, fenc=
e-&gt;seq);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; radeon_ring_write(ring, 0);<=
br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* HDP flush */<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; /* We should be using the new WAIT_REG_MEM s=
pecial op packet here<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * but it causes the CP to hang<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; radeon_ring_write(ring, PACKET3(PACKET3_WRIT=
E_DATA, 3));<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; radeon_ring_write(ring, (WRITE_DATA_ENGINE_S=
EL(0) |<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WRITE_DATA_DST_SEL(0)));<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; radeon_ring_write(ring, HDP_MEM_COHERENCY_FL=
USH_CNTL &gt;&gt; 2);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; radeon_ring_write(ring, 0);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; radeon_ring_write(ring, 0);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; cik_gfx_hdp_flush(rdev, fence-&gt;ring);=
<br>
&gt;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp; /**<br>
&gt; @@ -3549,15 &#43;3583,7 @@ void cik_fence_compute_ring_emit(struct rad=
eon_device *rdev,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; radeon_ring_write(ring, fenc=
e-&gt;seq);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; radeon_ring_write(ring, 0);<=
br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* HDP flush */<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; /* We should be using the new WAIT_REG_MEM s=
pecial op packet here<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * but it causes the CP to hang<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; radeon_ring_write(ring, PACKET3(PACKET3_WRIT=
E_DATA, 3));<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; radeon_ring_write(ring, (WRITE_DATA_ENGINE_S=
EL(0) |<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WRITE_DATA_DST_SEL(0)));<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; radeon_ring_write(ring, HDP_MEM_COHERENCY_FL=
USH_CNTL &gt;&gt; 2);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; radeon_ring_write(ring, 0);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; radeon_ring_write(ring, 0);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; cik_gfx_hdp_flush(rdev, fence-&gt;ring);=
<br>
&gt;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp; bool cik_semaphore_ring_emit(struct radeon_device *rdev,<b=
r>
&gt; @@ -5369,16 &#43;5395,7 @@ void cik_vm_flush(struct radeon_device *rde=
v, int ridx, struct radeon_vm *vm)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; radeon_ring_write(ring, VMID=
(0));<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* HDP flush */<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; /* We should be using the WAIT_REG_MEM packe=
t here like in<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * cik_fence_ring_emit(), but it causes=
 the CP to hang in this<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * context...<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; radeon_ring_write(ring, PACKET3(PACKET3_WRIT=
E_DATA, 3));<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; radeon_ring_write(ring, (WRITE_DATA_ENGINE_S=
EL(0) |<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WRITE_DATA_DST_SEL(0)));<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; radeon_ring_write(ring, HDP_MEM_COHERENCY_FL=
USH_CNTL &gt;&gt; 2);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; radeon_ring_write(ring, 0);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; radeon_ring_write(ring, 0);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; cik_gfx_hdp_flush(rdev, ridx);<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* bits 0-15 are the VM cont=
exts0-15 */<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; radeon_ring_write(ring, PACK=
ET3(PACKET3_WRITE_DATA, 3));<br>
<br>
</div>
</span></font></div>
</body>
</html>

--_000_BN6PR12MB1809C8AD78F826E8D3CD30F4F7A50BN6PR12MB1809namp_--

--===============1592280231==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============1592280231==--
