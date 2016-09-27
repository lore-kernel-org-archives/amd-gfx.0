From: "StDenis, Tom" <Tom.StDenis-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 2/2] drm/amdkfd: Decode bit fields in 'cik_ih_ring_entry'
 directly
Date: Tue, 27 Sep 2016 13:02:01 +0000
Message-ID: <CY4PR12MB17680FE69F96B2B57A1161EEF7CC0@CY4PR12MB1768.namprd12.prod.outlook.com>
References: <1474980460-8743-1-git-send-email-funfunctor@folklore1984.net>
 <1474980460-8743-3-git-send-email-funfunctor@folklore1984.net>,
 <856c4498-9096-6a02-9e9a-c97e7f313252@vodafone.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0660784530=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <856c4498-9096-6a02-9e9a-c97e7f313252-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
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
To: =?iso-8859-1?Q?Christian_K=F6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>, Edward
 O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============0660784530==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_CY4PR12MB17680FE69F96B2B57A1161EEF7CC0CY4PR12MB1768namp_"

--_000_CY4PR12MB17680FE69F96B2B57A1161EEF7CC0CY4PR12MB1768namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Better would be to add them to a bitmask header and then use REG_GET_FIELD(=
) so it's nice and clean looking.


Tom


________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of Christia=
n K=F6nig <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
Sent: Tuesday, September 27, 2016 08:52
To: Edward O'Callaghan; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Subject: Re: [PATCH 2/2] drm/amdkfd: Decode bit fields in 'cik_ih_ring_entr=
y' directly

NAK, don't use bitfields to decode hardware values. They aren't portable.

Regards,
Christian.

Am 27.09.2016 um 14:47 schrieb Edward O'Callaghan:
> Signed-off-by: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
> ---
>   drivers/gpu/drm/amd/amdkfd/cik_event_interrupt.c | 15 +++++----------
>   drivers/gpu/drm/amd/amdkfd/cik_int.h             | 20 ++++++++++++++++-=
---
>   2 files changed, 21 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/cik_event_interrupt.c b/drivers/g=
pu/drm/amd/amdkfd/cik_event_interrupt.c
> index 211fc48..1c47b9e 100644
> --- a/drivers/gpu/drm/amd/amdkfd/cik_event_interrupt.c
> +++ b/drivers/gpu/drm/amd/amdkfd/cik_event_interrupt.c
> @@ -27,14 +27,12 @@
>   static bool cik_event_interrupt_isr(struct kfd_dev *dev,
>                                        const uint32_t *ih_ring_entry)
>   {
> -     unsigned int pasid;
>        const struct cik_ih_ring_entry *ihre =3D
>                        (const struct cik_ih_ring_entry *)ih_ring_entry;
>
> -     pasid =3D (ihre->ring_id & 0xffff0000) >> 16;
>
>        /* Do not process in ISR, just request it to be forwarded to WQ. *=
/
> -     return (pasid !=3D 0) &&
> +     return (ihre->pasid !=3D 0) &&
>                (ihre->source_id =3D=3D CIK_INTSRC_CP_END_OF_PIPE ||
>                ihre->source_id =3D=3D CIK_INTSRC_SQ_INTERRUPT_MSG ||
>                ihre->source_id =3D=3D CIK_INTSRC_CP_BAD_OPCODE);
> @@ -43,21 +41,18 @@ static bool cik_event_interrupt_isr(struct kfd_dev *d=
ev,
>   static void cik_event_interrupt_wq(struct kfd_dev *dev,
>                                        const uint32_t *ih_ring_entry)
>   {
> -     unsigned int pasid;
>        const struct cik_ih_ring_entry *ihre =3D
>                        (const struct cik_ih_ring_entry *)ih_ring_entry;
>
> -     pasid =3D (ihre->ring_id & 0xffff0000) >> 16;
> -
> -     if (pasid =3D=3D 0)
> +     if (ihre->pasid =3D=3D 0)
>                return;
>
>        if (ihre->source_id =3D=3D CIK_INTSRC_CP_END_OF_PIPE)
> -             kfd_signal_event_interrupt(pasid, 0, 0);
> +             kfd_signal_event_interrupt(ihre->pasid, 0, 0);
>        else if (ihre->source_id =3D=3D CIK_INTSRC_SQ_INTERRUPT_MSG)
> -             kfd_signal_event_interrupt(pasid, ihre->data & 0xFF, 8);
> +             kfd_signal_event_interrupt(ihre->pasid, ihre->data & 0xFF, =
8);
>        else if (ihre->source_id =3D=3D CIK_INTSRC_CP_BAD_OPCODE)
> -             kfd_signal_hw_exception_event(pasid);
> +             kfd_signal_hw_exception_event(ihre->pasid);
>   }
>
>   const struct kfd_event_interrupt_class event_interrupt_class_cik =3D {
> diff --git a/drivers/gpu/drm/amd/amdkfd/cik_int.h b/drivers/gpu/drm/amd/a=
mdkfd/cik_int.h
> index 79a16d2..27d1ede 100644
> --- a/drivers/gpu/drm/amd/amdkfd/cik_int.h
> +++ b/drivers/gpu/drm/amd/amdkfd/cik_int.h
> @@ -26,10 +26,22 @@
>   #include <linux/types.h>
>
>   struct cik_ih_ring_entry {
> -     uint32_t source_id;
> -     uint32_t data;
> -     uint32_t ring_id;
> -     uint32_t reserved;
> +     uint32_t source_id:8;
> +     uint32_t reserved1:8;
> +     uint32_t reserved2:16;
> +
> +     uint32_t data:28;
> +     uint32_t reserved3:4;
> +
> +     /* pipeid, meid and unused3 are officially called RINGID,
> +      * but for our purposes, they always decode into pipe and ME. */
> +     uint32_t pipeid:2;
> +     uint32_t meid:2;
> +     uint32_t reserved4:4;
> +     uint32_t vmid:8;
> +     uint32_t pasid:16;
> +
> +     uint32_t reserved5;
>   };
>
>   #define CIK_INTSRC_DEQUEUE_COMPLETE 0xC6


_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
amd-gfx Info Page - lists.freedesktop.org<https://lists.freedesktop.org/mai=
lman/listinfo/amd-gfx>
lists.freedesktop.org
To see the collection of prior postings to the list, visit the amd-gfx Arch=
ives. Using amd-gfx: To post a message to all the list members, send email =
...




--_000_CY4PR12MB17680FE69F96B2B57A1161EEF7CC0CY4PR12MB1768namp_
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
-family:Calibri,Arial,Helvetica,sans-serif;">
<p>Better would be to add them to a bitmask header and then use REG_GET_FIE=
LD() so it's nice and clean looking.</p>
<p><br>
</p>
<p>Tom</p>
<br>
<br>
<div style=3D"color: rgb(0, 0, 0);">
<div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"x_divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" =
color=3D"#000000" style=3D"font-size:11pt"><b>From:</b> amd-gfx &lt;amd-gfx=
-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; on behalf of Christian K=F6nig &lt;death=
simple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org&gt;<br>
<b>Sent:</b> Tuesday, September 27, 2016 08:52<br>
<b>To:</b> Edward O'Callaghan; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Subject:</b> Re: [PATCH 2/2] drm/amdkfd: Decode bit fields in 'cik_ih_ri=
ng_entry' directly</font>
<div>&nbsp;</div>
</div>
</div>
<font size=3D"2"><span style=3D"font-size:10pt;">
<div class=3D"PlainText">NAK, don't use bitfields to decode hardware values=
. They aren't portable.<br>
<br>
Regards,<br>
Christian.<br>
<br>
Am 27.09.2016 um 14:47 schrieb Edward O'Callaghan:<br>
&gt; Signed-off-by: Edward O'Callaghan &lt;funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org&gt;<=
br>
&gt; ---<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdkfd/cik_event_interrupt.c | 15 &#43=
;&#43;&#43;&#43;&#43;----------<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdkfd/cik_int.h&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | 20 &#43;&#43;&#43;&#43=
;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;----<br>
&gt;&nbsp;&nbsp; 2 files changed, 21 insertions(&#43;), 14 deletions(-)<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdkfd/cik_event_interrupt.c b/driver=
s/gpu/drm/amd/amdkfd/cik_event_interrupt.c<br>
&gt; index 211fc48..1c47b9e 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdkfd/cik_event_interrupt.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdkfd/cik_event_interrupt.c<br>
&gt; @@ -27,14 &#43;27,12 @@<br>
&gt;&nbsp;&nbsp; static bool cik_event_interrupt_isr(struct kfd_dev *dev,<b=
r>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; const uint32_t *ih_ring_entry)<br>
&gt;&nbsp;&nbsp; {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; unsigned int pasid;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const struct cik_ih_ring_ent=
ry *ihre =3D<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (const =
struct cik_ih_ring_entry *)ih_ring_entry;<br>
&gt;&nbsp;&nbsp; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; pasid =3D (ihre-&gt;ring_id &amp; 0xffff0000=
) &gt;&gt; 16;<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Do not process in ISR, ju=
st request it to be forwarded to WQ. */<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; return (pasid !=3D 0) &amp;&amp;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; return (ihre-&gt;pasid !=3D 0) &amp;&amp=
;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; (ihre-&gt;source_id =3D=3D CIK_INTSRC_CP_END_OF_PIPE ||=
<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; ihre-&gt;source_id =3D=3D CIK_INTSRC_SQ_INTERRUPT_MSG |=
|<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; ihre-&gt;source_id =3D=3D CIK_INTSRC_CP_BAD_OPCODE);<br=
>
&gt; @@ -43,21 &#43;41,18 @@ static bool cik_event_interrupt_isr(struct kfd=
_dev *dev,<br>
&gt;&nbsp;&nbsp; static void cik_event_interrupt_wq(struct kfd_dev *dev,<br=
>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; const uint32_t *ih_ring_entry)<br>
&gt;&nbsp;&nbsp; {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; unsigned int pasid;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const struct cik_ih_ring_ent=
ry *ihre =3D<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (const =
struct cik_ih_ring_entry *)ih_ring_entry;<br>
&gt;&nbsp;&nbsp; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; pasid =3D (ihre-&gt;ring_id &amp; 0xffff0000=
) &gt;&gt; 16;<br>
&gt; -<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; if (pasid =3D=3D 0)<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; if (ihre-&gt;pasid =3D=3D 0)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; return;<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ihre-&gt;source_id =3D=
=3D CIK_INTSRC_CP_END_OF_PIPE)<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; kfd_signal_event_interrupt(pasid, 0, 0);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; kfd_signal_event_interrupt(ihre-&gt;pasid, 0, 0);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else if (ihre-&gt;source_id =
=3D=3D CIK_INTSRC_SQ_INTERRUPT_MSG)<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; kfd_signal_event_interrupt(pasid, ihre-&gt;data &amp; 0xFF, 8);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; kfd_signal_event_interrupt(ihre-&gt;pasid, ihre-&gt;data &amp; 0xFF=
, 8);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else if (ihre-&gt;source_id =
=3D=3D CIK_INTSRC_CP_BAD_OPCODE)<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; kfd_signal_hw_exception_event(pasid);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; kfd_signal_hw_exception_event(ihre-&gt;pasid);<br>
&gt;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp; const struct kfd_event_interrupt_class event_interrupt_cla=
ss_cik =3D {<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdkfd/cik_int.h b/drivers/gpu/drm/am=
d/amdkfd/cik_int.h<br>
&gt; index 79a16d2..27d1ede 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdkfd/cik_int.h<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdkfd/cik_int.h<br>
&gt; @@ -26,10 &#43;26,22 @@<br>
&gt;&nbsp;&nbsp; #include &lt;linux/types.h&gt;<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp; struct cik_ih_ring_entry {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; uint32_t source_id;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; uint32_t data;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; uint32_t ring_id;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; uint32_t reserved;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t source_id:8;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t reserved1:8;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t reserved2:16;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t data:28;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t reserved3:4;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; /* pipeid, meid and unused3 are official=
ly called RINGID,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * but for our purposes, they alway=
s decode into pipe and ME. */<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t pipeid:2;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t meid:2;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t reserved4:4;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t vmid:8;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t pasid:16;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t reserved5;<br>
&gt;&nbsp;&nbsp; };<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp; #define CIK_INTSRC_DEQUEUE_COMPLETE 0xC6<br>
<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx" id=3D"LP=
lnk334039" previewremoved=3D"true">https://lists.freedesktop.org/mailman/li=
stinfo/amd-gfx</a>
<div id=3D"LPBorder_GT_14749812728050.7048501784478629" style=3D"margin-bot=
tom: 20px; overflow: auto; width: 100%; text-indent: 0px;">
<table id=3D"LPContainer_14749812728030.5642919220195035" cellspacing=3D"0"=
 style=3D"width: 90%; background-color: rgb(255, 255, 255); position: relat=
ive; overflow: auto; padding-top: 20px; padding-bottom: 20px; margin-top: 2=
0px; border-top: 1px dotted rgb(200, 200, 200); border-bottom: 1px dotted r=
gb(200, 200, 200);">
<tbody>
<tr valign=3D"top" style=3D"border-spacing: 0px;">
<td id=3D"TextCell_14749812728040.9268417870047556" colspan=3D"2" style=3D"=
vertical-align: top; position: relative; padding: 0px; display: table-cell;=
">
<div id=3D"LPRemovePreviewContainer_14749812728040.34307252866659876"></div=
>
<div id=3D"LPTitle_14749812728040.8388090385131661" style=3D"top: 0px; colo=
r: rgb(59, 87, 119); font-weight: normal; font-size: 21px; font-family: wf_=
segoe-ui_light, &quot;Segoe UI Light&quot;, &quot;Segoe WP Light&quot;, &qu=
ot;Segoe UI&quot;, &quot;Segoe WP&quot;, Tahoma, Arial, sans-serif; line-he=
ight: 21px;">
<a id=3D"LPUrlAnchor_14749812728050.28844807438263875" href=3D"https://list=
s.freedesktop.org/mailman/listinfo/amd-gfx" target=3D"_blank" style=3D"text=
-decoration: none;">amd-gfx Info Page - lists.freedesktop.org</a></div>
<div id=3D"LPMetadata_14749812728050.9572512473940396" style=3D"margin: 10p=
x 0px 16px; color: rgb(102, 102, 102); font-weight: normal; font-family: wf=
_segoe-ui_normal, &quot;Segoe UI&quot;, &quot;Segoe WP&quot;, Tahoma, Arial=
, sans-serif; font-size: 14px; line-height: 14px;">
lists.freedesktop.org</div>
<div id=3D"LPDescription_14749812728050.8362385945355966" style=3D"display:=
 block; color: rgb(102, 102, 102); font-weight: normal; font-family: wf_seg=
oe-ui_normal, &quot;Segoe UI&quot;, &quot;Segoe WP&quot;, Tahoma, Arial, sa=
ns-serif; font-size: 14px; line-height: 20px; max-height: 100px; overflow: =
hidden;">
To see the collection of prior postings to the list, visit the amd-gfx Arch=
ives. Using amd-gfx: To post a message to all the list members, send email =
...</div>
</td>
</tr>
</tbody>
</table>
</div>
<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_CY4PR12MB17680FE69F96B2B57A1161EEF7CC0CY4PR12MB1768namp_--

--===============0660784530==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0660784530==--
