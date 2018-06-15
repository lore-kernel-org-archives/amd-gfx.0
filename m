From: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: update ib_start/size_alignment same as
 windows used
Date: Fri, 15 Jun 2018 12:15:39 -0400
Message-ID: <CAAxE2A4F+bZyvnZF8CT+yPg4xfbs5FZgdz645Q8vQTbVfF7E0Q@mail.gmail.com>
References: <20180615064542.16504-1-david1.zhou@amd.com>
 <dd3006dc-203f-9fb8-b43f-14151f01127a@gmail.com>
 <CY4PR12MB141405AC0D97B1A681203BC6FF7C0@CY4PR12MB1414.namprd12.prod.outlook.com>
 <21a15654-b8f1-da9b-5771-bfd28c8a25ca@amd.com>
 <b4dcf392-e29b-ca30-12d8-69434c28e834@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0617827798=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <b4dcf392-e29b-ca30-12d8-69434c28e834-5C7GfCeVMHo@public.gmane.org>
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
To: Chunming Zhou <zhoucm1-5C7GfCeVMHo@public.gmane.org>
Cc: "Zhou, David(ChunMing)" <David1.Zhou-5C7GfCeVMHo@public.gmane.org>, "Olsak,
 Marek" <Marek.Olsak-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "Ryan,
 Sean" <Sean.Ryan-5C7GfCeVMHo@public.gmane.org>, Junwei Zhang <Jerry.Zhang-5C7GfCeVMHo@public.gmane.org>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>

--===============0617827798==
Content-Type: multipart/alternative; boundary="0000000000008d85f3056eb08753"

--0000000000008d85f3056eb08753
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Acked-by: Marek Ol=C5=A1=C3=A1k <marek.olsak-5C7GfCeVMHo@public.gmane.org>

Marek

On Fri, Jun 15, 2018, 4:03 AM zhoucm1 <zhoucm1-5C7GfCeVMHo@public.gmane.org> wrote:

> Marek, Can I get your RB or Acked on this patches? Since these info are
> reported to UMD.
>
>
> Thanks,
>
> David Zhou
>
>
> On 2018=E5=B9=B406=E6=9C=8815=E6=97=A5 15:22, zhoucm1 wrote:
> >
> >
> > On 2018=E5=B9=B406=E6=9C=8815=E6=97=A5 15:16, Zhang, Jerry wrote:
> >>> -----Original Message-----
> >>> From: amd-gfx [mailto:amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org] On
> >>> Behalf Of
> >>> Christian K?nig
> >>> Sent: Friday, June 15, 2018 15:09
> >>> To: Zhou, David(ChunMing) <David1.Zhou-5C7GfCeVMHo@public.gmane.org>; amd-
> >>> gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> >>> Cc: Olsak, Marek <Marek.Olsak-5C7GfCeVMHo@public.gmane.org>; Ryan, Sean <Sean.Ryan-5C7GfCeVMHo@public.gmane.org=
>
> >>> Subject: Re: [PATCH] drm/amdgpu: update ib_start/size_alignment same =
as
> >>> windows used
> >>>
> >>> Am 15.06.2018 um 08:45 schrieb Chunming Zhou:
> >>>> PAGE_SIZE for start_alignment is far much than hw requirement, And
> >>>> now, update to expereince value from window side.
> >>>>
> >>>> Change-Id: I08a7e72076386c32faf36ec4812b30e68dde23e5
> >>>> Signed-off-by: Chunming Zhou <david1.zhou-5C7GfCeVMHo@public.gmane.org>
> >>> Acked-by: Christian K=C3=B6nig <christian.koenig-5C7GfCeVMHo@public.gmane.org>
> >> Acked-by: Junwei Zhang <Jerry.Zhang-5C7GfCeVMHo@public.gmane.org>
> >>
> >> BTW, any issue it fixes?
> > Yes, as talked in internal brahma list " whether ib_start_alignment is
> > proper", which fixes some PAL assert checking.
> >
> > Regards,
> > David Zhou
> >>
> >> Jerry
> >>
> >>>> ---
> >>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 28
> >>>> ++++++++++++++---------
> >>> -----
> >>>>    1 file changed, 14 insertions(+), 14 deletions(-)
> >>>>
> >>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> >>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> >>>> index 392dd24e83f5..d041dddaad0c 100644
> >>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> >>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> >>>> @@ -329,35 +329,35 @@ static int amdgpu_info_ioctl(struct
> >>>> drm_device *dev,
> >>> void *data, struct drm_file
> >>>>                type =3D AMD_IP_BLOCK_TYPE_GFX;
> >>>>                for (i =3D 0; i < adev->gfx.num_gfx_rings; i++)
> >>>>                    ring_mask |=3D ((adev->gfx.gfx_ring[i].ready ? 1 =
: 0)
> >>> << i);
> >>>> -            ib_start_alignment =3D AMDGPU_GPU_PAGE_SIZE;
> >>>> -            ib_size_alignment =3D 8;
> >>>> +            ib_start_alignment =3D 32;
> >>>> +            ib_size_alignment =3D 32;
> >>>>                break;
> >>>>            case AMDGPU_HW_IP_COMPUTE:
> >>>>                type =3D AMD_IP_BLOCK_TYPE_GFX;
> >>>>                for (i =3D 0; i < adev->gfx.num_compute_rings; i++)
> >>>>                    ring_mask |=3D ((adev->gfx.compute_ring[i].ready =
?
> >>> 1 : 0) << i);
> >>>> -            ib_start_alignment =3D AMDGPU_GPU_PAGE_SIZE;
> >>>> -            ib_size_alignment =3D 8;
> >>>> +            ib_start_alignment =3D 32;
> >>>> +            ib_size_alignment =3D 32;
> >>>>                break;
> >>>>            case AMDGPU_HW_IP_DMA:
> >>>>                type =3D AMD_IP_BLOCK_TYPE_SDMA;
> >>>>                for (i =3D 0; i < adev->sdma.num_instances; i++)
> >>>>                    ring_mask |=3D ((adev-
> >>>> sdma.instance[i].ring.ready ? 1 : 0) << i);
> >>>> -            ib_start_alignment =3D AMDGPU_GPU_PAGE_SIZE;
> >>>> -            ib_size_alignment =3D 1;
> >>>> +            ib_start_alignment =3D 256;
> >>>> +            ib_size_alignment =3D 4;
> >>>>                break;
> >>>>            case AMDGPU_HW_IP_UVD:
> >>>>                type =3D AMD_IP_BLOCK_TYPE_UVD;
> >>>>                for (i =3D 0; i < adev->uvd.num_uvd_inst; i++)
> >>>>                    ring_mask |=3D ((adev->uvd.inst[i].ring.ready ? 1
> >>>> : 0)
> >>> << i);
> >>>> -            ib_start_alignment =3D AMDGPU_GPU_PAGE_SIZE;
> >>>> -            ib_size_alignment =3D 16;
> >>>> +            ib_start_alignment =3D 64;
> >>>> +            ib_size_alignment =3D 64;
> >>>>                break;
> >>>>            case AMDGPU_HW_IP_VCE:
> >>>>                type =3D AMD_IP_BLOCK_TYPE_VCE;
> >>>>                for (i =3D 0; i < adev->vce.num_rings; i++)
> >>>>                    ring_mask |=3D ((adev->vce.ring[i].ready ? 1 : 0)=
 <<
> >>> i);
> >>>> -            ib_start_alignment =3D AMDGPU_GPU_PAGE_SIZE;
> >>>> +            ib_start_alignment =3D 4;
> >>>>                ib_size_alignment =3D 1;
> >>>>                break;
> >>>>            case AMDGPU_HW_IP_UVD_ENC:
> >>>> @@ -367,26 +367,26 @@ static int amdgpu_info_ioctl(struct
> >>>> drm_device *dev,
> >>> void *data, struct drm_file
> >>>>                        ring_mask |=3D
> >>>> ((adev->uvd.inst[i].ring_enc[j].ready ? 1 :
> >>> 0) <<
> >>>>                        (j + i * adev->uvd.num_enc_rings));
> >>>> -            ib_start_alignment =3D AMDGPU_GPU_PAGE_SIZE;
> >>>> -            ib_size_alignment =3D 1;
> >>>> +            ib_start_alignment =3D 64;
> >>>> +            ib_size_alignment =3D 64;
> >>>>                break;
> >>>>            case AMDGPU_HW_IP_VCN_DEC:
> >>>>                type =3D AMD_IP_BLOCK_TYPE_VCN;
> >>>>                ring_mask =3D adev->vcn.ring_dec.ready ? 1 : 0;
> >>>> -            ib_start_alignment =3D AMDGPU_GPU_PAGE_SIZE;
> >>>> +            ib_start_alignment =3D 16;
> >>>>                ib_size_alignment =3D 16;
> >>>>                break;
> >>>>            case AMDGPU_HW_IP_VCN_ENC:
> >>>>                type =3D AMD_IP_BLOCK_TYPE_VCN;
> >>>>                for (i =3D 0; i < adev->vcn.num_enc_rings; i++)
> >>>>                    ring_mask |=3D ((adev->vcn.ring_enc[i].ready ? 1 =
: 0)
> >>> << i);
> >>>> -            ib_start_alignment =3D AMDGPU_GPU_PAGE_SIZE;
> >>>> +            ib_start_alignment =3D 64;
> >>>>                ib_size_alignment =3D 1;
> >>>>                break;
> >>>>            case AMDGPU_HW_IP_VCN_JPEG:
> >>>>                type =3D AMD_IP_BLOCK_TYPE_VCN;
> >>>>                ring_mask =3D adev->vcn.ring_jpeg.ready ? 1 : 0;
> >>>> -            ib_start_alignment =3D AMDGPU_GPU_PAGE_SIZE;
> >>>> +            ib_start_alignment =3D 16;
> >>>>                ib_size_alignment =3D 16;
> >>>>                break;
> >>>>            default:
> >>> _______________________________________________
> >>> amd-gfx mailing list
> >>> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> >>> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
> >
> > _______________________________________________
> > amd-gfx mailing list
> > amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> > https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>

--0000000000008d85f3056eb08753
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Acked-by: Marek Ol=C5=A1=C3=A1k &lt;<a href=3D"mailto:mar=
ek.olsak-5C7GfCeVMHo@public.gmane.org">marek.olsak-5C7GfCeVMHo@public.gmane.org</a>&gt;<div dir=3D"auto"><br></div><d=
iv dir=3D"auto">Marek</div></div><br><div class=3D"gmail_quote"><div dir=3D=
"ltr">On Fri, Jun 15, 2018, 4:03 AM zhoucm1 &lt;<a href=3D"mailto:zhoucm1@a=
md.com">zhoucm1-5C7GfCeVMHo@public.gmane.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_=
quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1=
ex">Marek, Can I get your RB or Acked on this patches? Since these info are=
 <br>
reported to UMD.<br>
<br>
<br>
Thanks,<br>
<br>
David Zhou<br>
<br>
<br>
On 2018=E5=B9=B406=E6=9C=8815=E6=97=A5 15:22, zhoucm1 wrote:<br>
&gt;<br>
&gt;<br>
&gt; On 2018=E5=B9=B406=E6=9C=8815=E6=97=A5 15:16, Zhang, Jerry wrote:<br>
&gt;&gt;&gt; -----Original Message-----<br>
&gt;&gt;&gt; From: amd-gfx [mailto:<a href=3D"mailto:amd-gfx-bounces@lists.=
freedesktop.org" target=3D"_blank" rel=3D"noreferrer">amd-gfx-bounces@lists=
.freedesktop.org</a>] On <br>
&gt;&gt;&gt; Behalf Of<br>
&gt;&gt;&gt; Christian K?nig<br>
&gt;&gt;&gt; Sent: Friday, June 15, 2018 15:09<br>
&gt;&gt;&gt; To: Zhou, David(ChunMing) &lt;<a href=3D"mailto:David1.Zhou@am=
d.com" target=3D"_blank" rel=3D"noreferrer">David1.Zhou-5C7GfCeVMHo@public.gmane.org</a>&gt;; am=
d-<br>
&gt;&gt;&gt; <a href=3D"mailto:gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" target=3D"_blank"=
 rel=3D"noreferrer">gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
&gt;&gt;&gt; Cc: Olsak, Marek &lt;<a href=3D"mailto:Marek.Olsak-5C7GfCeVMHo@public.gmane.org" ta=
rget=3D"_blank" rel=3D"noreferrer">Marek.Olsak-5C7GfCeVMHo@public.gmane.org</a>&gt;; Ryan, Sean =
&lt;<a href=3D"mailto:Sean.Ryan-5C7GfCeVMHo@public.gmane.org" target=3D"_blank" rel=3D"noreferre=
r">Sean.Ryan-5C7GfCeVMHo@public.gmane.org</a>&gt;<br>
&gt;&gt;&gt; Subject: Re: [PATCH] drm/amdgpu: update ib_start/size_alignmen=
t same as<br>
&gt;&gt;&gt; windows used<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Am 15.06.2018 um 08:45 schrieb Chunming Zhou:<br>
&gt;&gt;&gt;&gt; PAGE_SIZE for start_alignment is far much than hw requirem=
ent, And<br>
&gt;&gt;&gt;&gt; now, update to expereince value from window side.<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; Change-Id: I08a7e72076386c32faf36ec4812b30e68dde23e5<br>
&gt;&gt;&gt;&gt; Signed-off-by: Chunming Zhou &lt;<a href=3D"mailto:david1.=
zhou-5C7GfCeVMHo@public.gmane.org" target=3D"_blank" rel=3D"noreferrer">david1.zhou-5C7GfCeVMHo@public.gmane.org</a>&=
gt;<br>
&gt;&gt;&gt; Acked-by: Christian K=C3=B6nig &lt;<a href=3D"mailto:christian=
.koenig-5C7GfCeVMHo@public.gmane.org" target=3D"_blank" rel=3D"noreferrer">christian.koenig@amd.=
com</a>&gt;<br>
&gt;&gt; Acked-by: Junwei Zhang &lt;<a href=3D"mailto:Jerry.Zhang-5C7GfCeVMHo@public.gmane.org" =
target=3D"_blank" rel=3D"noreferrer">Jerry.Zhang-5C7GfCeVMHo@public.gmane.org</a>&gt;<br>
&gt;&gt;<br>
&gt;&gt; BTW, any issue it fixes?<br>
&gt; Yes, as talked in internal brahma list &quot; whether ib_start_alignme=
nt is <br>
&gt; proper&quot;, which fixes some PAL assert checking.<br>
&gt;<br>
&gt; Regards,<br>
&gt; David Zhou<br>
&gt;&gt;<br>
&gt;&gt; Jerry<br>
&gt;&gt;<br>
&gt;&gt;&gt;&gt; ---<br>
&gt;&gt;&gt;&gt; =C2=A0=C2=A0 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 28 =
<br>
&gt;&gt;&gt;&gt; ++++++++++++++---------<br>
&gt;&gt;&gt; -----<br>
&gt;&gt;&gt;&gt; =C2=A0=C2=A0 1 file changed, 14 insertions(+), 14 deletion=
s(-)<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c<br>
&gt;&gt;&gt;&gt; b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c<br>
&gt;&gt;&gt;&gt; index 392dd24e83f5..d041dddaad0c 100644<br>
&gt;&gt;&gt;&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c<br>
&gt;&gt;&gt;&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c<br>
&gt;&gt;&gt;&gt; @@ -329,35 +329,35 @@ static int amdgpu_info_ioctl(struct =
<br>
&gt;&gt;&gt;&gt; drm_device *dev,<br>
&gt;&gt;&gt; void *data, struct drm_file<br>
&gt;&gt;&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 type =3D AMD_IP_BLOCK_TYPE_GFX;<br>
&gt;&gt;&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 for (i =3D 0; i &lt; adev-&gt;gfx.num_gfx_rings=
; i++)<br>
&gt;&gt;&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ring_mask |=3D ((adev-&=
gt;gfx.gfx_ring[i].ready ? 1 : 0)<br>
&gt;&gt;&gt; &lt;&lt; i);<br>
&gt;&gt;&gt;&gt; -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 ib_start_alignment =3D AMDGPU_GPU_PAGE_SIZE;<br>
&gt;&gt;&gt;&gt; -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 ib_size_alignment =3D 8;<br>
&gt;&gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 ib_start_alignment =3D 32;<br>
&gt;&gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 ib_size_alignment =3D 32;<br>
&gt;&gt;&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;<br>
&gt;&gt;&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 case AMDGPU_HW_IP_COMPUTE:<br>
&gt;&gt;&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 type =3D AMD_IP_BLOCK_TYPE_GFX;<br>
&gt;&gt;&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 for (i =3D 0; i &lt; adev-&gt;gfx.num_compute_r=
ings; i++)<br>
&gt;&gt;&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ring_mask |=3D ((adev-&=
gt;gfx.compute_ring[i].ready ?<br>
&gt;&gt;&gt; 1 : 0) &lt;&lt; i);<br>
&gt;&gt;&gt;&gt; -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 ib_start_alignment =3D AMDGPU_GPU_PAGE_SIZE;<br>
&gt;&gt;&gt;&gt; -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 ib_size_alignment =3D 8;<br>
&gt;&gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 ib_start_alignment =3D 32;<br>
&gt;&gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 ib_size_alignment =3D 32;<br>
&gt;&gt;&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;<br>
&gt;&gt;&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 case AMDGPU_HW_IP_DMA:<br>
&gt;&gt;&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 type =3D AMD_IP_BLOCK_TYPE_SDMA;<br>
&gt;&gt;&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 for (i =3D 0; i &lt; adev-&gt;sdma.num_instance=
s; i++)<br>
&gt;&gt;&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ring_mask |=3D ((adev-<=
br>
&gt;&gt;&gt;&gt; sdma.instance[i].ring.ready ? 1 : 0) &lt;&lt; i);<br>
&gt;&gt;&gt;&gt; -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 ib_start_alignment =3D AMDGPU_GPU_PAGE_SIZE;<br>
&gt;&gt;&gt;&gt; -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 ib_size_alignment =3D 1;<br>
&gt;&gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 ib_start_alignment =3D 256;<br>
&gt;&gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 ib_size_alignment =3D 4;<br>
&gt;&gt;&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;<br>
&gt;&gt;&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 case AMDGPU_HW_IP_UVD:<br>
&gt;&gt;&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 type =3D AMD_IP_BLOCK_TYPE_UVD;<br>
&gt;&gt;&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 for (i =3D 0; i &lt; adev-&gt;uvd.num_uvd_inst;=
 i++)<br>
&gt;&gt;&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ring_mask |=3D ((adev-&=
gt;uvd.inst[i].ring.ready ? 1 <br>
&gt;&gt;&gt;&gt; : 0)<br>
&gt;&gt;&gt; &lt;&lt; i);<br>
&gt;&gt;&gt;&gt; -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 ib_start_alignment =3D AMDGPU_GPU_PAGE_SIZE;<br>
&gt;&gt;&gt;&gt; -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 ib_size_alignment =3D 16;<br>
&gt;&gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 ib_start_alignment =3D 64;<br>
&gt;&gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 ib_size_alignment =3D 64;<br>
&gt;&gt;&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;<br>
&gt;&gt;&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 case AMDGPU_HW_IP_VCE:<br>
&gt;&gt;&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 type =3D AMD_IP_BLOCK_TYPE_VCE;<br>
&gt;&gt;&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 for (i =3D 0; i &lt; adev-&gt;vce.num_rings; i+=
+)<br>
&gt;&gt;&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ring_mask |=3D ((adev-&=
gt;vce.ring[i].ready ? 1 : 0) &lt;&lt;<br>
&gt;&gt;&gt; i);<br>
&gt;&gt;&gt;&gt; -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 ib_start_alignment =3D AMDGPU_GPU_PAGE_SIZE;<br>
&gt;&gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 ib_start_alignment =3D 4;<br>
&gt;&gt;&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 ib_size_alignment =3D 1;<br>
&gt;&gt;&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;<br>
&gt;&gt;&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 case AMDGPU_HW_IP_UVD_ENC:<br>
&gt;&gt;&gt;&gt; @@ -367,26 +367,26 @@ static int amdgpu_info_ioctl(struct =
<br>
&gt;&gt;&gt;&gt; drm_device *dev,<br>
&gt;&gt;&gt; void *data, struct drm_file<br>
&gt;&gt;&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 ring_mask |=3D<br>
&gt;&gt;&gt;&gt; ((adev-&gt;uvd.inst[i].ring_enc[j].ready ? 1 :<br>
&gt;&gt;&gt; 0) &lt;&lt;<br>
&gt;&gt;&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 (j + i * adev-&gt;uvd.num_enc_rings));<br>
&gt;&gt;&gt;&gt; -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 ib_start_alignment =3D AMDGPU_GPU_PAGE_SIZE;<br>
&gt;&gt;&gt;&gt; -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 ib_size_alignment =3D 1;<br>
&gt;&gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 ib_start_alignment =3D 64;<br>
&gt;&gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 ib_size_alignment =3D 64;<br>
&gt;&gt;&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;<br>
&gt;&gt;&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 case AMDGPU_HW_IP_VCN_DEC:<br>
&gt;&gt;&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 type =3D AMD_IP_BLOCK_TYPE_VCN;<br>
&gt;&gt;&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 ring_mask =3D adev-&gt;vcn.ring_dec.ready ? 1 :=
 0;<br>
&gt;&gt;&gt;&gt; -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 ib_start_alignment =3D AMDGPU_GPU_PAGE_SIZE;<br>
&gt;&gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 ib_start_alignment =3D 16;<br>
&gt;&gt;&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 ib_size_alignment =3D 16;<br>
&gt;&gt;&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;<br>
&gt;&gt;&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 case AMDGPU_HW_IP_VCN_ENC:<br>
&gt;&gt;&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 type =3D AMD_IP_BLOCK_TYPE_VCN;<br>
&gt;&gt;&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 for (i =3D 0; i &lt; adev-&gt;vcn.num_enc_rings=
; i++)<br>
&gt;&gt;&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ring_mask |=3D ((adev-&=
gt;vcn.ring_enc[i].ready ? 1 : 0)<br>
&gt;&gt;&gt; &lt;&lt; i);<br>
&gt;&gt;&gt;&gt; -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 ib_start_alignment =3D AMDGPU_GPU_PAGE_SIZE;<br>
&gt;&gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 ib_start_alignment =3D 64;<br>
&gt;&gt;&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 ib_size_alignment =3D 1;<br>
&gt;&gt;&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;<br>
&gt;&gt;&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 case AMDGPU_HW_IP_VCN_JPEG:<br>
&gt;&gt;&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 type =3D AMD_IP_BLOCK_TYPE_VCN;<br>
&gt;&gt;&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 ring_mask =3D adev-&gt;vcn.ring_jpeg.ready ? 1 =
: 0;<br>
&gt;&gt;&gt;&gt; -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 ib_start_alignment =3D AMDGPU_GPU_PAGE_SIZE;<br>
&gt;&gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 ib_start_alignment =3D 16;<br>
&gt;&gt;&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 ib_size_alignment =3D 16;<br>
&gt;&gt;&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;<br>
&gt;&gt;&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 default:<br>
&gt;&gt;&gt; _______________________________________________<br>
&gt;&gt;&gt; amd-gfx mailing list<br>
&gt;&gt;&gt; <a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" target=3D"_bl=
ank" rel=3D"noreferrer">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
&gt;&gt;&gt; <a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-=
gfx" rel=3D"noreferrer noreferrer" target=3D"_blank">https://lists.freedesk=
top.org/mailman/listinfo/amd-gfx</a><br>
&gt;<br>
&gt; _______________________________________________<br>
&gt; amd-gfx mailing list<br>
&gt; <a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" target=3D"_blank" rel=
=3D"noreferrer">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
&gt; <a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx" rel=
=3D"noreferrer noreferrer" target=3D"_blank">https://lists.freedesktop.org/=
mailman/listinfo/amd-gfx</a><br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
<a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" target=3D"_blank" rel=3D"n=
oreferrer">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx" rel=3D"n=
oreferrer noreferrer" target=3D"_blank">https://lists.freedesktop.org/mailm=
an/listinfo/amd-gfx</a><br>
</blockquote></div>

--0000000000008d85f3056eb08753--

--===============0617827798==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0617827798==--
