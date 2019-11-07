From: "Russell, Kent" <Kent.Russell-5C7GfCeVMHo@public.gmane.org>
Subject: RE: [PATCH 2/3] drm/amdkfd: only keep release_mem function for Hawaii
Date: Thu, 7 Nov 2019 17:33:27 +0000
Message-ID: <CY4PR1201MB2533087B346C4619F461FF3185780@CY4PR1201MB2533.namprd12.prod.outlook.com>
References: <20191031001739.10764-1-Yong.Zhao@amd.com>
 <20191031001739.10764-2-Yong.Zhao@amd.com>,
 <31102345-20f7-1b0e-dd2a-f7984b253a07@amd.com>
 <DM6PR12MB2778C141CFEA0006DA2CEC6DF0780@DM6PR12MB2778.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0961424190=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <DM6PR12MB2778C141CFEA0006DA2CEC6DF0780-lmeGfMZKVrFSet88YzIdmgdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
To: "Zhao, Yong" <Yong.Zhao-5C7GfCeVMHo@public.gmane.org>, "Kuehling, Felix" <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============0961424190==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_CY4PR1201MB2533087B346C4619F461FF3185780CY4PR1201MB2533_"

--_000_CY4PR1201MB2533087B346C4619F461FF3185780CY4PR1201MB2533_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

I think that the versioning is getting a little confusing since we're using=
 the old GFX versions, but not really sticking to it due to the shareabilit=
y of certain managers and shaders. Could we look into doing something like =
gen1 or gen2, or some other more ambiguous non-GFX-related versioning? Othe=
rwise we'll keep having these questions of "why is Hawaii GFX8", "why is Ar=
cturus GFX9", etc. Then if things change, we just up the value concretely, =
instead of maybe doing a v11 if GFX11 changes things, and only GFX11 ASICs =
use those functions/variables.

Obviously not high-priority, but maybe something to consider as you continu=
e to consolidate and remove duplicate code.

Kent

From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> On Behalf Of Zhao, Yo=
ng
Sent: Thursday, November 7, 2019 11:57 AM
To: Kuehling, Felix <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Subject: Re: [PATCH 2/3] drm/amdkfd: only keep release_mem function for Haw=
aii

Hi Felix,

That's because v8 and v7 share the same packet_manager_funcs. In this case,=
 it is better to keep it as it is.

Regards,
Yong
________________________________
From: Kuehling, Felix <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org<mailto:Felix.Kuehling-5C7GfCeVMHo@public.gmane.org=
>>
Sent: Wednesday, November 6, 2019 11:45 PM
To: Zhao, Yong <Yong.Zhao-5C7GfCeVMHo@public.gmane.org<mailto:Yong.Zhao-5C7GfCeVMHo@public.gmane.org>>; amd-gfx@lists=
.freedesktop.org<mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> <amd-gfx-PD4FTy7X32mMSPqsTGOZug@public.gmane.org=
esktop.org<mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>>
Subject: Re: [PATCH 2/3] drm/amdkfd: only keep release_mem function for Haw=
aii

On 2019-10-30 20:17, Zhao, Yong wrote:
> release_mem won't be used at all on GFX9 and GFX10, so delete it.

Hawaii was GFXv7. So we're not using the release_mem packet on GFXv8
either. Why arbitrarily limit this change to GFXv9 and 10?

Regards,
   Felix

>
> Change-Id: I13787a8a29b83e7516c582a7401f2e14721edf5f
> Signed-off-by: Yong Zhao <Yong.Zhao-5C7GfCeVMHo@public.gmane.org<mailto:Yong.Zhao-5C7GfCeVMHo@public.gmane.org>>
> ---
>   .../gpu/drm/amd/amdkfd/kfd_kernel_queue_v10.c | 35 ++-----------------
>   .../gpu/drm/amd/amdkfd/kfd_kernel_queue_v9.c  | 33 ++---------------
>   2 files changed, 4 insertions(+), 64 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue_v10.c b/drivers/=
gpu/drm/amd/amdkfd/kfd_kernel_queue_v10.c
> index aed32ab7102e..bfd6221acae9 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue_v10.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue_v10.c
> @@ -298,37 +298,6 @@ static int pm_query_status_v10(struct packet_manager=
 *pm, uint32_t *buffer,
>        return 0;
>   }
>
> -
> -static int pm_release_mem_v10(uint64_t gpu_addr, uint32_t *buffer)
> -{
> -     struct pm4_mec_release_mem *packet;
> -
> -     WARN_ON(!buffer);
> -
> -     packet =3D (struct pm4_mec_release_mem *)buffer;
> -     memset(buffer, 0, sizeof(struct pm4_mec_release_mem));
> -
> -     packet->header.u32All =3D pm_build_pm4_header(IT_RELEASE_MEM,
> -                                     sizeof(struct pm4_mec_release_mem))=
;
> -
> -     packet->bitfields2.event_type =3D CACHE_FLUSH_AND_INV_TS_EVENT;
> -     packet->bitfields2.event_index =3D event_index__mec_release_mem__en=
d_of_pipe;
> -     packet->bitfields2.tcl1_action_ena =3D 1;
> -     packet->bitfields2.tc_action_ena =3D 1;
> -     packet->bitfields2.cache_policy =3D cache_policy__mec_release_mem__=
lru;
> -
> -     packet->bitfields3.data_sel =3D data_sel__mec_release_mem__send_32_=
bit_low;
> -     packet->bitfields3.int_sel =3D
> -             int_sel__mec_release_mem__send_interrupt_after_write_confir=
m;
> -
> -     packet->bitfields4.address_lo_32b =3D (gpu_addr & 0xffffffff) >> 2;
> -     packet->address_hi =3D upper_32_bits(gpu_addr);
> -
> -     packet->data_lo =3D 0;
> -
> -     return sizeof(struct pm4_mec_release_mem) / sizeof(unsigned int);
> -}
> -
>   const struct packet_manager_funcs kfd_v10_pm_funcs =3D {
>        .map_process                    =3D pm_map_process_v10,
>        .runlist                        =3D pm_runlist_v10,
> @@ -336,13 +305,13 @@ const struct packet_manager_funcs kfd_v10_pm_funcs =
=3D {
>        .map_queues                     =3D pm_map_queues_v10,
>        .unmap_queues                   =3D pm_unmap_queues_v10,
>        .query_status                   =3D pm_query_status_v10,
> -     .release_mem                    =3D pm_release_mem_v10,
> +     .release_mem                    =3D NULL,
>        .map_process_size               =3D sizeof(struct pm4_mes_map_proc=
ess),
>        .runlist_size                   =3D sizeof(struct pm4_mes_runlist)=
,
>        .set_resources_size             =3D sizeof(struct pm4_mes_set_reso=
urces),
>        .map_queues_size                =3D sizeof(struct pm4_mes_map_queu=
es),
>        .unmap_queues_size              =3D sizeof(struct pm4_mes_unmap_qu=
eues),
>        .query_status_size              =3D sizeof(struct pm4_mes_query_st=
atus),
> -     .release_mem_size               =3D sizeof(struct pm4_mec_release_m=
em)
> +     .release_mem_size               =3D 0,
>   };
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue_v9.c b/drivers/g=
pu/drm/amd/amdkfd/kfd_kernel_queue_v9.c
> index 3b5ca2b1d7a6..f0e4910a8865 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue_v9.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue_v9.c
> @@ -336,35 +336,6 @@ static int pm_query_status_v9(struct packet_manager =
*pm, uint32_t *buffer,
>        return 0;
>   }
>
> -
> -static int pm_release_mem_v9(uint64_t gpu_addr, uint32_t *buffer)
> -{
> -     struct pm4_mec_release_mem *packet;
> -
> -     packet =3D (struct pm4_mec_release_mem *)buffer;
> -     memset(buffer, 0, sizeof(struct pm4_mec_release_mem));
> -
> -     packet->header.u32All =3D pm_build_pm4_header(IT_RELEASE_MEM,
> -                                     sizeof(struct pm4_mec_release_mem))=
;
> -
> -     packet->bitfields2.event_type =3D CACHE_FLUSH_AND_INV_TS_EVENT;
> -     packet->bitfields2.event_index =3D event_index__mec_release_mem__en=
d_of_pipe;
> -     packet->bitfields2.tcl1_action_ena =3D 1;
> -     packet->bitfields2.tc_action_ena =3D 1;
> -     packet->bitfields2.cache_policy =3D cache_policy__mec_release_mem__=
lru;
> -
> -     packet->bitfields3.data_sel =3D data_sel__mec_release_mem__send_32_=
bit_low;
> -     packet->bitfields3.int_sel =3D
> -             int_sel__mec_release_mem__send_interrupt_after_write_confir=
m;
> -
> -     packet->bitfields4.address_lo_32b =3D (gpu_addr & 0xffffffff) >> 2;
> -     packet->address_hi =3D upper_32_bits(gpu_addr);
> -
> -     packet->data_lo =3D 0;
> -
> -     return 0;
> -}
> -
>   const struct packet_manager_funcs kfd_v9_pm_funcs =3D {
>        .map_process            =3D pm_map_process_v9,
>        .runlist                =3D pm_runlist_v9,
> @@ -372,12 +343,12 @@ const struct packet_manager_funcs kfd_v9_pm_funcs =
=3D {
>        .map_queues             =3D pm_map_queues_v9,
>        .unmap_queues           =3D pm_unmap_queues_v9,
>        .query_status           =3D pm_query_status_v9,
> -     .release_mem            =3D pm_release_mem_v9,
> +     .release_mem            =3D NULL,
>        .map_process_size       =3D sizeof(struct pm4_mes_map_process),
>        .runlist_size           =3D sizeof(struct pm4_mes_runlist),
>        .set_resources_size     =3D sizeof(struct pm4_mes_set_resources),
>        .map_queues_size        =3D sizeof(struct pm4_mes_map_queues),
>        .unmap_queues_size      =3D sizeof(struct pm4_mes_unmap_queues),
>        .query_status_size      =3D sizeof(struct pm4_mes_query_status),
> -     .release_mem_size       =3D sizeof(struct pm4_mec_release_mem)
> +     .release_mem_size       =3D 0,
>   };

--_000_CY4PR1201MB2533087B346C4619F461FF3185780CY4PR1201MB2533_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<!--[if !mso]><style>v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
w\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style><![endif]--><style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:"Segoe UI";
	panose-1:2 11 5 2 4 2 4 2 2 3;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:#954F72;
	text-decoration:underline;}
p.msonormal0, li.msonormal0, div.msonormal0
	{mso-style-name:msonormal;
	margin:0in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
span.EmailStyle20
	{mso-style-type:personal-reply;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"#0563C1" vlink=3D"#954F72">
<div class=3D"WordSection1">
<p class=3D"MsoNormal">I think that the versioning is getting a little conf=
using since we&#8217;re using the old GFX versions, but not really sticking=
 to it due to the shareability of certain managers and shaders. Could we lo=
ok into doing something like gen1 or gen2,
 or some other more ambiguous non-GFX-related versioning? Otherwise we&#821=
7;ll keep having these questions of &#8220;why is Hawaii GFX8&#8221;, &#822=
0;why is Arcturus GFX9&#8221;, etc. Then if things change, we just up the v=
alue concretely, instead of maybe doing a v11 if GFX11 changes
 things, and only GFX11 ASICs use those functions/variables. <o:p></o:p></p=
>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Obviously not high-priority, but maybe something to =
consider as you continue to consolidate and remove duplicate code.<o:p></o:=
p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Kent<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> amd-gfx &lt;amd-gfx-bounces-PD4FTy7X32mMSPqsTGOZug@public.gmane.org=
esktop.org&gt;
<b>On Behalf Of </b>Zhao, Yong<br>
<b>Sent:</b> Thursday, November 7, 2019 11:57 AM<br>
<b>To:</b> Kuehling, Felix &lt;Felix.Kuehling-5C7GfCeVMHo@public.gmane.org&gt;; amd-gfx-PD4FTy7X32k@public.gmane.org=
eedesktop.org<br>
<b>Subject:</b> Re: [PATCH 2/3] drm/amdkfd: only keep release_mem function =
for Hawaii<o:p></o:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">Hi Feli=
x,<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black"><o:p>&n=
bsp;</o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">That's =
because v8 and v7 share the same
</span><span style=3D"font-family:&quot;Segoe UI&quot;,sans-serif;color:bla=
ck;background:white">packet_manager_funcs. In this case, it is better to ke=
ep it as it is.</span><span style=3D"font-size:12.0pt;color:black"><o:p></o=
:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black"><o:p>&n=
bsp;</o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Segoe UI&quot;,sans=
-serif;color:black;background:white">Regards,</span><span style=3D"font-siz=
e:12.0pt;color:black"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Segoe UI&quot;,sans=
-serif;color:black;background:white">Yong</span><span style=3D"font-size:12=
.0pt;color:black"><o:p></o:p></span></p>
</div>
<div class=3D"MsoNormal" align=3D"center" style=3D"text-align:center">
<hr size=3D"2" width=3D"98%" align=3D"center">
</div>
<div id=3D"divRplyFwdMsg">
<p class=3D"MsoNormal"><b><span style=3D"color:black">From:</span></b><span=
 style=3D"color:black"> Kuehling, Felix &lt;<a href=3D"mailto:Felix.Kuehlin=
g@amd.com">Felix.Kuehling-5C7GfCeVMHo@public.gmane.org</a>&gt;<br>
<b>Sent:</b> Wednesday, November 6, 2019 11:45 PM<br>
<b>To:</b> Zhao, Yong &lt;<a href=3D"mailto:Yong.Zhao-5C7GfCeVMHo@public.gmane.org">Yong.Zhao@am=
d.com</a>&gt;;
<a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9/rsn8yoX9R0@public.gmane.org=
org</a> &lt;<a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx@lists.=
freedesktop.org</a>&gt;<br>
<b>Subject:</b> Re: [PATCH 2/3] drm/amdkfd: only keep release_mem function =
for Hawaii</span>
<o:p></o:p></p>
<div>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
</div>
</div>
<div>
<div>
<p class=3D"MsoNormal">On 2019-10-30 20:17, Zhao, Yong wrote:<br>
&gt; release_mem won't be used at all on GFX9 and GFX10, so delete it.<br>
<br>
Hawaii was GFXv7. So we're not using the release_mem packet on GFXv8 <br>
either. Why arbitrarily limit this change to GFXv9 and 10?<br>
<br>
Regards,<br>
&nbsp;&nbsp; Felix<br>
<br>
&gt;<br>
&gt; Change-Id: I13787a8a29b83e7516c582a7401f2e14721edf5f<br>
&gt; Signed-off-by: Yong Zhao &lt;<a href=3D"mailto:Yong.Zhao-5C7GfCeVMHo@public.gmane.org">Yong=
.Zhao-5C7GfCeVMHo@public.gmane.org</a>&gt;<br>
&gt; ---<br>
&gt;&nbsp;&nbsp; .../gpu/drm/amd/amdkfd/kfd_kernel_queue_v10.c | 35 &#43;&#=
43;-----------------<br>
&gt;&nbsp;&nbsp; .../gpu/drm/amd/amdkfd/kfd_kernel_queue_v9.c&nbsp; | 33 &#=
43;&#43;---------------<br>
&gt;&nbsp;&nbsp; 2 files changed, 4 insertions(&#43;), 64 deletions(-)<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue_v10.c b/drive=
rs/gpu/drm/amd/amdkfd/kfd_kernel_queue_v10.c<br>
&gt; index aed32ab7102e..bfd6221acae9 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue_v10.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue_v10.c<br=
>
&gt; @@ -298,37 &#43;298,6 @@ static int pm_query_status_v10(struct packet_=
manager *pm, uint32_t *buffer,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp; <br>
&gt; -<br>
&gt; -static int pm_release_mem_v10(uint64_t gpu_addr, uint32_t *buffer)<br=
>
&gt; -{<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; struct pm4_mec_release_mem *packet;<br>
&gt; -<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; WARN_ON(!buffer);<br>
&gt; -<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; packet =3D (struct pm4_mec_release_mem *)buf=
fer;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; memset(buffer, 0, sizeof(struct pm4_mec_rele=
ase_mem));<br>
&gt; -<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; packet-&gt;header.u32All =3D pm_build_pm4_he=
ader(IT_RELEASE_MEM,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; si=
zeof(struct pm4_mec_release_mem));<br>
&gt; -<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; packet-&gt;bitfields2.event_type =3D CACHE_F=
LUSH_AND_INV_TS_EVENT;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; packet-&gt;bitfields2.event_index =3D event_=
index__mec_release_mem__end_of_pipe;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; packet-&gt;bitfields2.tcl1_action_ena =3D 1;=
<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; packet-&gt;bitfields2.tc_action_ena =3D 1;<b=
r>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; packet-&gt;bitfields2.cache_policy =3D cache=
_policy__mec_release_mem__lru;<br>
&gt; -<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; packet-&gt;bitfields3.data_sel =3D data_sel_=
_mec_release_mem__send_32_bit_low;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; packet-&gt;bitfields3.int_sel =3D<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; int_sel__mec_release_mem__send_interrupt_after_write_confirm;<br>
&gt; -<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; packet-&gt;bitfields4.address_lo_32b =3D (gp=
u_addr &amp; 0xffffffff) &gt;&gt; 2;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; packet-&gt;address_hi =3D upper_32_bits(gpu_=
addr);<br>
&gt; -<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; packet-&gt;data_lo =3D 0;<br>
&gt; -<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; return sizeof(struct pm4_mec_release_mem) / =
sizeof(unsigned int);<br>
&gt; -}<br>
&gt; -<br>
&gt;&nbsp;&nbsp; const struct packet_manager_funcs kfd_v10_pm_funcs =3D {<b=
r>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .map_process&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; =3D pm_map_process_v10,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .runlist&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D pm_runlist_v10,<br>
&gt; @@ -336,13 &#43;305,13 @@ const struct packet_manager_funcs kfd_v10_pm=
_funcs =3D {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .map_queues&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D pm_map_queues_v10,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .unmap_queues&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; =3D pm_unmap_queues_v10,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .query_status&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; =3D pm_query_status_v10,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; .release_mem&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; =3D pm_release_mem_v10,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; .release_mem&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; =3D NULL,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .map_process_size&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
=3D sizeof(struct pm4_mes_map_process),<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .runlist_size&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; =3D sizeof(struct pm4_mes_runlist),<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_resources_size&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D sizeof(=
struct pm4_mes_set_resources),<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .map_queues_size&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; =3D sizeof(struct pm4_mes_map_queues),<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .unmap_queues_size&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D si=
zeof(struct pm4_mes_unmap_queues),<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .query_status_size&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D si=
zeof(struct pm4_mes_query_status),<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; .release_mem_size&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D sizeof(struct=
 pm4_mec_release_mem)<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; .release_mem_size&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D 0,<br>
&gt;&nbsp;&nbsp; };<br>
&gt;&nbsp;&nbsp; <br>
&gt; diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue_v9.c b/driver=
s/gpu/drm/amd/amdkfd/kfd_kernel_queue_v9.c<br>
&gt; index 3b5ca2b1d7a6..f0e4910a8865 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue_v9.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue_v9.c<br>
&gt; @@ -336,35 &#43;336,6 @@ static int pm_query_status_v9(struct packet_m=
anager *pm, uint32_t *buffer,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp; <br>
&gt; -<br>
&gt; -static int pm_release_mem_v9(uint64_t gpu_addr, uint32_t *buffer)<br>
&gt; -{<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; struct pm4_mec_release_mem *packet;<br>
&gt; -<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; packet =3D (struct pm4_mec_release_mem *)buf=
fer;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; memset(buffer, 0, sizeof(struct pm4_mec_rele=
ase_mem));<br>
&gt; -<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; packet-&gt;header.u32All =3D pm_build_pm4_he=
ader(IT_RELEASE_MEM,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; si=
zeof(struct pm4_mec_release_mem));<br>
&gt; -<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; packet-&gt;bitfields2.event_type =3D CACHE_F=
LUSH_AND_INV_TS_EVENT;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; packet-&gt;bitfields2.event_index =3D event_=
index__mec_release_mem__end_of_pipe;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; packet-&gt;bitfields2.tcl1_action_ena =3D 1;=
<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; packet-&gt;bitfields2.tc_action_ena =3D 1;<b=
r>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; packet-&gt;bitfields2.cache_policy =3D cache=
_policy__mec_release_mem__lru;<br>
&gt; -<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; packet-&gt;bitfields3.data_sel =3D data_sel_=
_mec_release_mem__send_32_bit_low;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; packet-&gt;bitfields3.int_sel =3D<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; int_sel__mec_release_mem__send_interrupt_after_write_confirm;<br>
&gt; -<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; packet-&gt;bitfields4.address_lo_32b =3D (gp=
u_addr &amp; 0xffffffff) &gt;&gt; 2;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; packet-&gt;address_hi =3D upper_32_bits(gpu_=
addr);<br>
&gt; -<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; packet-&gt;data_lo =3D 0;<br>
&gt; -<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt; -}<br>
&gt; -<br>
&gt;&nbsp;&nbsp; const struct packet_manager_funcs kfd_v9_pm_funcs =3D {<br=
>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .map_process&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D pm_map_process_v9,<b=
r>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .runlist&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D =
pm_runlist_v9,<br>
&gt; @@ -372,12 &#43;343,12 @@ const struct packet_manager_funcs kfd_v9_pm_=
funcs =3D {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .map_queues&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D pm_map_queues_v=
9,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .unmap_queues&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D pm_unmap_queues_v9,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .query_status&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D pm_query_status_v9,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; .release_mem&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D pm_release_mem_v9,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; .release_mem&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D NULL,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .map_process_size&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; =3D sizeof(struct pm4_mes_map_process),<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .runlist_size&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D sizeof(struct pm4_mes_run=
list),<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_resources_size&nbsp;&nb=
sp;&nbsp;&nbsp; =3D sizeof(struct pm4_mes_set_resources),<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .map_queues_size&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D sizeof(struct pm4_mes_map_queues),<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .unmap_queues_size&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; =3D sizeof(struct pm4_mes_unmap_queues),<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .query_status_size&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; =3D sizeof(struct pm4_mes_query_status),<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; .release_mem_size&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; =3D sizeof(struct pm4_mec_release_mem)<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; .release_mem_size&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; =3D 0,<br>
&gt;&nbsp;&nbsp; };<o:p></o:p></p>
</div>
</div>
</div>
</body>
</html>

--_000_CY4PR1201MB2533087B346C4619F461FF3185780CY4PR1201MB2533_--

--===============0961424190==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============0961424190==--
