From: "Zhao, Yong" <Yong.Zhao-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 2/3] drm/amdkfd: only keep release_mem function for Hawaii
Date: Thu, 7 Nov 2019 16:57:00 +0000
Message-ID: <DM6PR12MB2778C141CFEA0006DA2CEC6DF0780@DM6PR12MB2778.namprd12.prod.outlook.com>
References: <20191031001739.10764-1-Yong.Zhao@amd.com>
 <20191031001739.10764-2-Yong.Zhao@amd.com>,
 <31102345-20f7-1b0e-dd2a-f7984b253a07@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0676136989=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <31102345-20f7-1b0e-dd2a-f7984b253a07-5C7GfCeVMHo@public.gmane.org>
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
To: "Kuehling, Felix" <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============0676136989==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_DM6PR12MB2778C141CFEA0006DA2CEC6DF0780DM6PR12MB2778namp_"

--_000_DM6PR12MB2778C141CFEA0006DA2CEC6DF0780DM6PR12MB2778namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Felix,

That's because v8 and v7 share the same packet_manager_funcs. In this case,=
 it is better to keep it as it is.

Regards,
Yong
________________________________
From: Kuehling, Felix <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>
Sent: Wednesday, November 6, 2019 11:45 PM
To: Zhao, Yong <Yong.Zhao-5C7GfCeVMHo@public.gmane.org>; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org <amd-gfx@=
lists.freedesktop.org>
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
> Signed-off-by: Yong Zhao <Yong.Zhao-5C7GfCeVMHo@public.gmane.org>
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

--_000_DM6PR12MB2778C141CFEA0006DA2CEC6DF0780DM6PR12MB2778namp_
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
Hi Felix,</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
That's because v8 and v7 share the same <span style=3D"font-family: &quot;S=
egoe UI&quot;, &quot;Segoe UI Web (West European)&quot;, &quot;Segoe UI&quo=
t;, -apple-system, BlinkMacSystemFont, Roboto, &quot;Helvetica Neue&quot;, =
sans-serif; font-size: 14.6667px; background-color: rgb(255, 255, 255); dis=
play: inline !important">
packet_manager_funcs. In this case, it is better to keep it as it is.</span=
></div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Segoe UI&quot;, &quot;Segoe UI Web (West =
European)&quot;, &quot;Segoe UI&quot;, -apple-system, BlinkMacSystemFont, R=
oboto, &quot;Helvetica Neue&quot;, sans-serif; font-size: 14.6667px; backgr=
ound-color: rgb(255, 255, 255); display: inline !important"><br>
</span></div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Segoe UI&quot;, &quot;Segoe UI Web (West =
European)&quot;, &quot;Segoe UI&quot;, -apple-system, BlinkMacSystemFont, R=
oboto, &quot;Helvetica Neue&quot;, sans-serif; font-size: 14.6667px; backgr=
ound-color: rgb(255, 255, 255); display: inline !important">Regards,</span>=
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Segoe UI&quot;, &quot;Segoe UI Web (West =
European)&quot;, &quot;Segoe UI&quot;, -apple-system, BlinkMacSystemFont, R=
oboto, &quot;Helvetica Neue&quot;, sans-serif; font-size: 14.6667px; backgr=
ound-color: rgb(255, 255, 255); display: inline !important">Yong</span></di=
v>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Kuehling, Felix &lt;F=
elix.Kuehling-5C7GfCeVMHo@public.gmane.org&gt;<br>
<b>Sent:</b> Wednesday, November 6, 2019 11:45 PM<br>
<b>To:</b> Zhao, Yong &lt;Yong.Zhao-5C7GfCeVMHo@public.gmane.org&gt;; amd-gfx-PD4FTy7X32lNgt0PjOBp9/rsn8yoX9R0@public.gmane.org=
org &lt;amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt;<br>
<b>Subject:</b> Re: [PATCH 2/3] drm/amdkfd: only keep release_mem function =
for Hawaii</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">On 2019-10-30 20:17, Zhao, Yong wrote:<br>
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
&gt; Signed-off-by: Yong Zhao &lt;Yong.Zhao-5C7GfCeVMHo@public.gmane.org&gt;<br>
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
&gt;&nbsp;&nbsp; };<br>
</div>
</span></font></div>
</body>
</html>

--_000_DM6PR12MB2778C141CFEA0006DA2CEC6DF0780DM6PR12MB2778namp_--

--===============0676136989==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============0676136989==--
