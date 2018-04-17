From: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH v2 1/3] drm/prime: Iterate SG DMA addresses separately
Date: Tue, 17 Apr 2018 18:25:37 +0000
Message-ID: <DM5PR12MB1820D85680434ABB7573E171F7B70@DM5PR12MB1820.namprd12.prod.outlook.com>
References: <c15119b9e8e18d96fbef6592fd7e827883c7bf59.1523977133.git.robin.murphy@arm.com>
 <7552feb9-a512-eaee-103c-5f2367fcd9dd@gmail.com>,
 <73ac5c65-1dbd-8711-5770-75d79389bf44@arm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0154666542=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <73ac5c65-1dbd-8711-5770-75d79389bf44-5wv7dgnIgG8@public.gmane.org>
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
To: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>, "Koenig, Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "Suthikulpanit, Suravee" <Suravee.Suthikulpanit-5C7GfCeVMHo@public.gmane.org>
Cc: "okaya-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org" <okaya-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>

--===============0154666542==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_DM5PR12MB1820D85680434ABB7573E171F7B70DM5PR12MB1820namp_"

--_000_DM5PR12MB1820D85680434ABB7573E171F7B70DM5PR12MB1820namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

+ Suravee

________________________________
From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Sent: Tuesday, April 17, 2018 2:22:46 PM
To: Koenig, Christian; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org; dri-devel-PD4FTy7X32mMSPqsTGOZug@public.gmane.org=
esktop.org
Cc: okaya-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org; Deucher, Alexander
Subject: Re: [PATCH v2 1/3] drm/prime: Iterate SG DMA addresses separately

On 17/04/18 17:29, Christian K=F6nig wrote:
> Am 17.04.2018 um 17:58 schrieb Robin Murphy:
>> For dma_map_sg(), DMA API implementations are free to merge consecutive
>> segments into a single DMA mapping if conditions are suitable, thus the
>> resulting DMA addresses which drm_prime_sg_to_page_addr_arrays()
>> iterates may be packed into fewer entries than ttm->sg->nents implies.
>>
>> The current implementation does not account for this, meaning that its
>> callers either have to reject the 0 < count < nents case or risk getting
>> bogus DMA addresses beyond the first segment. Fortunately this is quite
>> easy to handle without having to rejig structures to also store the
>> mapped count, since the total DMA length should still be equal to the
>> total buffer length. All we need is a second scatterlist cursor to
>> iterate through the DMA addresses independently of the page addresses.
>>
>> Signed-off-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
>
> Reviewed-by: Christian K=F6nig <christian.koenig-5C7GfCeVMHo@public.gmane.org> for the whole
> series.

Thanks Christian.

FWIW, the following *completely untested* hack should in theory give the
AMD IOMMU similar segment-merging behaviour to the arm64 IOMMU DMA ops,
if that helps widen the scope for testing/investigation (I have neither
an AMD/ATI graphics card nor a PCIe-capable arm64 box to hand just at
the moment).

Robin.

----->8-----
diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index 2a99f0f14795..60b0e495b567 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -2489,11 +2489,11 @@ static int map_sg(struct device *dev, struct
scatterlist *sglist,
                   int nelems, enum dma_data_direction direction,
                   unsigned long attrs)
  {
-       int mapped_pages =3D 0, npages =3D 0, prot =3D 0, i;
+       int mapped_pages =3D 0, npages =3D 0, prot =3D 0, i, count;
         struct protection_domain *domain;
         struct dma_ops_domain *dma_dom;
-       struct scatterlist *s;
-       unsigned long address;
+       struct scatterlist *s, *d;
+       unsigned long address, max_seg;
         u64 dma_mask;

         domain =3D get_domain(dev);
@@ -2535,7 +2535,28 @@ static int map_sg(struct device *dev, struct
scatterlist *sglist,
                 s->dma_length   =3D s->length;
         }

-       return nelems;
+       d =3D sglist;
+       max_seg =3D dma_get_max_seg_size(dev);
+       count =3D 1;
+       nelems -=3D 1;
+       for_each_sg(sg_next(sglist), s, nelems, i) {
+               dma_addr_t s_dma_addr =3D s->dma_address;
+               unsigned int s_dma_len =3D s->dma_length;
+
+               s->dma_address =3D 0;
+               s->dma_length =3D 0;
+               if (s_dma_addr =3D=3D d->dma_address + d->dma_length &&
+                   d->dma_length + s_dma_len <=3D max_seg) {
+                       d->dma_length +=3D s_dma_len;
+               } else {
+                       d =3D sg_next(d);
+                       d->dma_address =3D s_dma_addr;
+                       d->dma_length =3D s_dma_len;
+                       count++;
+               }
+       }
+
+       return count;

  out_unmap:
         pr_err("%s: IOMMU mapping error in map_sg (io-pages: %d)\n",

--_000_DM5PR12MB1820D85680434ABB7573E171F7B70DM5PR12MB1820namp_
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
<div id=3D"divtagdefaultwrapper" style=3D"font-size:12pt;color:#000000;font=
-family:Calibri,Helvetica,sans-serif;" dir=3D"ltr">
<p style=3D"margin-top:0;margin-bottom:0">&#43; Suravee</p>
</div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Robin Murphy &lt;robi=
n.murphy-5wv7dgnIgG8@public.gmane.org&gt;<br>
<b>Sent:</b> Tuesday, April 17, 2018 2:22:46 PM<br>
<b>To:</b> Koenig, Christian; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org; dri-devel@list=
s.freedesktop.org<br>
<b>Cc:</b> okaya-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org; Deucher, Alexander<br>
<b>Subject:</b> Re: [PATCH v2 1/3] drm/prime: Iterate SG DMA addresses sepa=
rately</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">On 17/04/18 17:29, Christian K=F6nig wrote:<br>
&gt; Am 17.04.2018 um 17:58 schrieb Robin Murphy:<br>
&gt;&gt; For dma_map_sg(), DMA API implementations are free to merge consec=
utive<br>
&gt;&gt; segments into a single DMA mapping if conditions are suitable, thu=
s the<br>
&gt;&gt; resulting DMA addresses which drm_prime_sg_to_page_addr_arrays()<b=
r>
&gt;&gt; iterates may be packed into fewer entries than ttm-&gt;sg-&gt;nent=
s implies.<br>
&gt;&gt;<br>
&gt;&gt; The current implementation does not account for this, meaning that=
 its<br>
&gt;&gt; callers either have to reject the 0 &lt; count &lt; nents case or =
risk getting<br>
&gt;&gt; bogus DMA addresses beyond the first segment. Fortunately this is =
quite<br>
&gt;&gt; easy to handle without having to rejig structures to also store th=
e<br>
&gt;&gt; mapped count, since the total DMA length should still be equal to =
the<br>
&gt;&gt; total buffer length. All we need is a second scatterlist cursor to=
<br>
&gt;&gt; iterate through the DMA addresses independently of the page addres=
ses.<br>
&gt;&gt;<br>
&gt;&gt; Signed-off-by: Robin Murphy &lt;robin.murphy-5wv7dgnIgG8@public.gmane.org&gt;<br>
&gt; <br>
&gt; Reviewed-by: Christian K=F6nig &lt;christian.koenig-5C7GfCeVMHo@public.gmane.org&gt; for th=
e whole <br>
&gt; series.<br>
<br>
Thanks Christian.<br>
<br>
FWIW, the following *completely untested* hack should in theory give the <b=
r>
AMD IOMMU similar segment-merging behaviour to the arm64 IOMMU DMA ops, <br=
>
if that helps widen the scope for testing/investigation (I have neither <br=
>
an AMD/ATI graphics card nor a PCIe-capable arm64 box to hand just at <br>
the moment).<br>
<br>
Robin.<br>
<br>
-----&gt;8-----<br>
diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c<br>
index 2a99f0f14795..60b0e495b567 100644<br>
--- a/drivers/iommu/amd_iommu.c<br>
&#43;&#43;&#43; b/drivers/iommu/amd_iommu.c<br>
@@ -2489,11 &#43;2489,11 @@ static int map_sg(struct device *dev, struct <b=
r>
scatterlist *sglist,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int nelems, enum dma_data_direction direc=
tion,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned long attrs)<br>
&nbsp; {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int mapped_pages =3D 0, npages =3D 0,=
 prot =3D 0, i;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int mapped_pages =3D 0, npages =
=3D 0, prot =3D 0, i, count;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct protection_domain *=
domain;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dma_ops_domain *dma=
_dom;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct scatterlist *s;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned long address;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct scatterlist *s, *d;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned long address, max_seg;<b=
r>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u64 dma_mask;<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; domain =3D get_domain(dev)=
;<br>
@@ -2535,7 &#43;2535,28 @@ static int map_sg(struct device *dev, struct <br=
>
scatterlist *sglist,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; s-&gt;dma_length&nbsp;&nbsp; =3D s-&gt;length;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return nelems;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; d =3D sglist;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; max_seg =3D dma_get_max_seg_size(=
dev);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; count =3D 1;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; nelems -=3D 1;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for_each_sg(sg_next(sglist), s, n=
elems, i) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; dma_addr_t s_dma_addr =3D s-&gt;dma_address;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; unsigned int s_dma_len =3D s-&gt;dma_length;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; s-&gt;dma_address =3D 0;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; s-&gt;dma_length =3D 0;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; if (s_dma_addr =3D=3D d-&gt;dma_address &#43; d-&gt;dma_leng=
th &amp;&amp;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; d-&gt;dma_length &#43; s_dma_len &lt=
;=3D max_seg) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; d-&gt;dma_le=
ngth &#43;=3D s_dma_len;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; } else {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; d =3D sg_nex=
t(d);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; d-&gt;dma_ad=
dress =3D s_dma_addr;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; d-&gt;dma_le=
ngth =3D s_dma_len;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; count&#43;&#=
43;;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; }<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return count;<br>
<br>
&nbsp; out_unmap:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_err(&quot;%s: IOMMU map=
ping error in map_sg (io-pages: %d)\n&quot;,<br>
</div>
</span></font></div>
</body>
</html>

--_000_DM5PR12MB1820D85680434ABB7573E171F7B70DM5PR12MB1820namp_--

--===============0154666542==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0154666542==--
