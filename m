Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71C4EC5479D
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Jan 2023 02:39:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D53D510E128;
	Thu, 12 Jan 2023 02:39:32 +0000 (UTC)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 82AC510E128
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Jan 2023 02:39:30 +0000 (UTC)
Received: by mail-ed1-x530.google.com with SMTP id z11so25062325ede.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Jan 2023 18:39:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=F4OYvyqfIILYbu766xHlD+M6ysxbDa+Bjo45DwpWHAw=;
 b=irSRdzm6oa0uwPwv1+HZnsG6Hh3YOqa/U7JyjWgc7JW1BsDDkN0GCeXN+AX/RvaIuy
 ebgCxLn/ejA/hahSzhNeT+NVaWEE6rlB84ck3LncwDo2i5xYTmCWLQ1fJsr4PHN0IGxk
 qta4RURFHHH1lI36BKzP99ZNM+QHfxRveMHBBimZbX8I8GEUgHRA2t1ZVjDco4aPXpZ2
 bARR70sYwsg9C9tguI0cf2SO9bFLf3G7HyxVodlGIh4DbCpR8HKVceZashx56XUGIBzs
 szrdETzfPdX0ddA6/rasoZKGIQVJEaplrVTNfx0tTjkruWYzd4yOvEBAA2KbasAA6YUw
 JeOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=F4OYvyqfIILYbu766xHlD+M6ysxbDa+Bjo45DwpWHAw=;
 b=OAQm1EoFS5LhifsABjG7yQ5YIxAzRzX7aqdFb4DUTxttF26JoI60VMHAooQ73OtYhi
 nWWWZflawN4DYMC6TRg4D8UZBGZ0vUPlv2H8hqHY7sgnkFdI6JxWNjQbwVaA9EMbFWhy
 KnS97I2m/lHkWNUj2hRh8Qc58IYjsDN/Ay8Bwg7OuJ2RoF/x8j1isTXyqc4Gb540syVn
 PkDvvJTFvGTpaM9eD9SZbR5JqirZlqy5S7rFoPQzIMjRymPm6aHu/P6GgM/lH0Z0uYaO
 UW06n9ryda6PkT6W/1VBKFAVoXt9RInVvW40JUi01+tWNhvum954eZw4S9CEzeSTVFod
 I2Qg==
X-Gm-Message-State: AFqh2kpSf8ajvaXiNifaEyYx+XZVt6BrSlAyR7G0PJ6943Ba6loQ5j/t
 4j1mD1Rt3Efr2N4ZxLTwrEyc8hd7VDOkaf7BjOc=
X-Google-Smtp-Source: AMrXdXsPBptr1IYGDarL4fYPB4T9aQpjQiFe0HPu5APDVJb8fhd7V1kUjBZmIeJaJrkwni/+OQRkwsdtMT69tWhN5G8=
X-Received: by 2002:a05:6402:2b90:b0:495:a21b:b3b0 with SMTP id
 fj16-20020a0564022b9000b00495a21bb3b0mr2322044edb.131.1673491168868; Wed, 11
 Jan 2023 18:39:28 -0800 (PST)
MIME-Version: 1.0
References: <CAAxE2A720cJguG5b+0zbP=G4TxTjpqKBvOqDXXAP0LWHZEuj0A@mail.gmail.com>
 <0931a762-c3a3-16c3-33a5-88e83fca4bcb@gmail.com>
 <CAAxE2A5pBqOkny15tSRCWn_UW8=TTE=zYPChBZofZCrHZoQbww@mail.gmail.com>
 <35304b1e-98a7-d342-9f1b-50f07b45cf98@gmail.com>
 <CAAxE2A6KJWPJ3eqKoaiJZUJCNqRpx+WYwoGEZKxX2Kf_auLUWg@mail.gmail.com>
 <a90b0e8e-dd02-031f-0432-1c5f6f02e949@amd.com>
 <CAAxE2A7PJdiPORP-X+7kFmix9pCo63PqeamP20BZJx4GDfJdEQ@mail.gmail.com>
 <8ec2b238-fa8b-a693-b9d9-3a590cc05664@amd.com>
 <CAAxE2A7G_gjvuGNNtZ6J-4R25Ykx8ziz1B2f0Dc3KuC4KeYdzA@mail.gmail.com>
 <BYAPR12MB461473D2083BC8B9FB012AC297F59@BYAPR12MB4614.namprd12.prod.outlook.com>
 <CAAxE2A4F59qttYfrT66v4Fe0D1h4Km=DLY779uC=HHSGswg4Lg@mail.gmail.com>
 <CADnq5_MLO4FLXrmUXPUzo2UBzqxa_hjfL0qBzibWAqO79uhxvw@mail.gmail.com>
 <CADnq5_PPJanTuyNgL8eyxj-+HvPiPXN3e3hR3AHHivj0omcsXg@mail.gmail.com>
In-Reply-To: <CADnq5_PPJanTuyNgL8eyxj-+HvPiPXN3e3hR3AHHivj0omcsXg@mail.gmail.com>
From: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>
Date: Wed, 11 Jan 2023 21:39:16 -0500
Message-ID: <CAAxE2A732j-NNff4Dfqc7GAtrUJ6HcCMoz8ZFEz5KNpqWgvxkw@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/amdgpu: return the PCIe gen and lanes from the
 INFO
To: Alex Deucher <alexdeucher@gmail.com>
Content-Type: multipart/alternative; boundary="000000000000a7bbc505f2080695"
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Cc: "Lazar, Lijo" <Lijo.Lazar@amd.com>,
 amd-gfx mailing list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--000000000000a7bbc505f2080695
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 11, 2023, 15:50 Alex Deucher <alexdeucher@gmail.com> wrote:

> On Wed, Jan 11, 2023 at 3:48 PM Alex Deucher <alexdeucher@gmail.com>
> wrote:
> >
> > On Wed, Jan 4, 2023 at 3:17 PM Marek Ol=C5=A1=C3=A1k <maraeo@gmail.com>=
 wrote:
> > >
> > > Yes, it's meant to be like a spec sheet. We are not interested in the
> current bandwidth utilization.
> >
> > After chatting with Marek on IRC and thinking about this more, I think
> > this patch is fine.  It's not really meant for bandwidth per se, but
> > rather as a limit to determine what the driver should do in certain
> > cases (i.e., when does it make sense to copy to vram vs not).  It's
> > not straightforward for userspace to parse the full topology to
> > determine what links may be slow.  I guess one potential pitfall would
> > be that if you pass the device into a VM, the driver may report the
> > wrong values.  Generally in a VM the VM doesn't get the full view up
> > to the root port.  I don't know if the hypervisors report properly for
> > pcie_bandwidth_available() in a VM or if it just shows the info about
> > the endpoint in the VM.
> >
> > Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
>
> Actually:
>
> diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.=
h
> index fe7f871e3080..f7fc7325f17f 100644
> --- a/include/uapi/drm/amdgpu_drm.h
> +++ b/include/uapi/drm/amdgpu_drm.h
> @@ -1053,7 +1053,7 @@ struct drm_amdgpu_info_device {
>      __u32 enabled_rb_pipes_mask;
>      __u32 num_rb_pipes;
>      __u32 num_hw_gfx_contexts;
> -    __u32 _pad;
> +    __u32 pcie_gen;
>      __u64 ids_flags;
>      /** Starting virtual address for UMDs. */
>      __u64 virtual_address_offset;
> @@ -1109,6 +1109,7 @@ struct drm_amdgpu_info_device {
>      __u64 high_va_max;
>      /* gfx10 pa_sc_tile_steering_override */
>      __u32 pa_sc_tile_steering_override;
> +    __u32 pcie_num_lanes;
>      /* disabled TCCs */
>      __u64 tcc_disabled_mask;
>      __u64 min_engine_clock;
>
> Doesn't that last one need to be added to the end of the structure?
>

There was a hole because one u32 was surrounded by 2 u64s. (unless I missed
some packing #pragma)

Marek


> Alex
>
> >
> > Alex
> >
> > >
> > > Marek
> > >
> > > On Wed, Jan 4, 2023 at 10:33 AM Lazar, Lijo <Lijo.Lazar@amd.com>
> wrote:
> > >>
> > >> [AMD Official Use Only - General]
> > >>
> > >>
> > >> To clarify, with DPM in place, the current bandwidth will be changin=
g
> based on the load.
> > >>
> > >> If apps/umd already has a way to know the current bandwidth
> utilisation, then possible maximum also could be part of the same API.
> Otherwise, this only looks like duplicate information. We have the same
> information in sysfs DPM nodes.
> > >>
> > >> BTW, I don't know to what extent app/umd really makes use of this.
> Take that memory frequency as an example (I'm reading it as 16GHz). It on=
ly
> looks like a spec sheet.
> > >>
> > >> Thanks,
> > >> Lijo
> > >> ________________________________
> > >> From: Marek Ol=C5=A1=C3=A1k <maraeo@gmail.com>
> > >> Sent: Wednesday, January 4, 2023 8:40:00 PM
> > >> To: Lazar, Lijo <Lijo.Lazar@amd.com>
> > >> Cc: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
> > >> Subject: Re: [PATCH 1/2] drm/amdgpu: return the PCIe gen and lanes
> from the INFO
> > >>
> > >> On Wed, Jan 4, 2023 at 9:19 AM Lazar, Lijo <lijo.lazar@amd.com>
> wrote:
> > >>
> > >>
> > >>
> > >> On 1/4/2023 7:43 PM, Marek Ol=C5=A1=C3=A1k wrote:
> > >> > On Wed, Jan 4, 2023 at 6:50 AM Lazar, Lijo <lijo.lazar@amd.com
> > >> > <mailto:lijo.lazar@amd.com>> wrote:
> > >> >
> > >> >
> > >> >
> > >> >     On 1/4/2023 4:11 AM, Marek Ol=C5=A1=C3=A1k wrote:
> > >> >      > I see. Well, those sysfs files are not usable, and I don't
> think it
> > >> >      > would be important even if they were usable, but for
> completeness:
> > >> >      >
> > >> >      > The ioctl returns:
> > >> >      >      pcie_gen =3D 1
> > >> >      >      pcie_num_lanes =3D 16
> > >> >      >
> > >> >      > Theoretical bandwidth from those values: 4.0 GB/s
> > >> >      > My DMA test shows this write bandwidth: 3.5 GB/s
> > >> >      > It matches the expectation.
> > >> >      >
> > >> >      > Let's see the devices (there is only 1 GPU Navi21 in the
> system):
> > >> >      > $ lspci |egrep '(PCI|VGA).*Navi'
> > >> >      > 0a:00.0 PCI bridge: Advanced Micro Devices, Inc. [AMD/ATI]
> Navi
> > >> >     10 XL
> > >> >      > Upstream Port of PCI Express Switch (rev c3)
> > >> >      > 0b:00.0 PCI bridge: Advanced Micro Devices, Inc. [AMD/ATI]
> Navi
> > >> >     10 XL
> > >> >      > Downstream Port of PCI Express Switch
> > >> >      > 0c:00.0 VGA compatible controller: Advanced Micro Devices,
> Inc.
> > >> >      > [AMD/ATI] Navi 21 [Radeon RX 6800/6800 XT / 6900 XT] (rev c=
3)
> > >> >      >
> > >> >      > Let's read sysfs:
> > >> >      >
> > >> >      > $ cat /sys/bus/pci/devices/0000:0a:00.0/current_link_width
> > >> >      > 16
> > >> >      > $ cat /sys/bus/pci/devices/0000:0b:00.0/current_link_width
> > >> >      > 16
> > >> >      > $ cat /sys/bus/pci/devices/0000:0c:00.0/current_link_width
> > >> >      > 16
> > >> >      > $ cat /sys/bus/pci/devices/0000:0a:00.0/current_link_speed
> > >> >      > 2.5 GT/s PCIe
> > >> >      > $ cat /sys/bus/pci/devices/0000:0b:00.0/current_link_speed
> > >> >      > 16.0 GT/s PCIe
> > >> >      > $ cat /sys/bus/pci/devices/0000:0c:00.0/current_link_speed
> > >> >      > 16.0 GT/s PCIe
> > >> >      >
> > >> >      > Problem 1: None of the speed numbers match 4 GB/s.
> > >> >
> > >> >     US bridge =3D 2.5GT/s means operating at PCIe Gen 1 speed. Tot=
al
> > >> >     theoretical bandwidth is then derived based on encoding and
> total
> > >> >     number
> > >> >     of lanes.
> > >> >
> > >> >      > Problem 2: Userspace doesn't know the bus index of the
> bridges,
> > >> >     and it's
> > >> >      > not clear which bridge should be used.
> > >> >
> > >> >     In general, modern ones have this arch=3D US->DS->EP. US is th=
e
> one
> > >> >     connected to physical link.
> > >> >
> > >> >      > Problem 3: The PCIe gen number is missing.
> > >> >
> > >> >     Current link speed is based on whether it's Gen1/2/3/4/5.
> > >> >
> > >> >     BTW, your patch makes use of capabilities flags which gives th=
e
> maximum
> > >> >     supported speed/width by the device. It may not necessarily
> reflect the
> > >> >     current speed/width negotiated. I guess in NV, this info is
> already
> > >> >     obtained from PMFW and made available through metrics table.
> > >> >
> > >> >
> > >> > It computes the minimum of the device PCIe gen and the
> motherboard/slot
> > >> > PCIe gen to get the final value. These 2 lines do that. The low 16
> bits
> > >> > of the mask contain the device PCIe gen mask. The high 16 bits of
> the
> > >> > mask contain the slot PCIe gen mask.
> > >> > + pcie_gen_mask =3D adev->pm.pcie_gen_mask & (adev->pm.pcie_gen_ma=
sk
> >> 16);
> > >> > + dev_info->pcie_gen =3D fls(pcie_gen_mask);
> > >> >
> > >>
> > >> With DPM in place on some ASICs, how much does this static info help
> for
> > >> upper level apps?
> > >>
> > >>
> > >> It helps UMDs make better decisions if they know the maximum
> achievable bandwidth. UMDs also compute the maximum memory bandwidth and
> compute performance (FLOPS). Right now it's printed by Mesa to give users
> detailed information about their GPU. For example:
> > >>
> > >> $ AMD_DEBUG=3Dinfo glxgears
> > >> Device info:
> > >>     name =3D NAVI21
> > >>     marketing_name =3D AMD Radeon RX 6800
> > >>     num_se =3D 3
> > >>     num_rb =3D 12
> > >>     num_cu =3D 60
> > >>     max_gpu_freq =3D 2475 MHz
> > >>     max_gflops =3D 19008 GFLOPS
> > >>     l0_cache_size =3D 16 KB
> > >>     l1_cache_size =3D 128 KB
> > >>     l2_cache_size =3D 4096 KB
> > >>     l3_cache_size =3D 128 MB
> > >>     memory_channels =3D 16 (TCC blocks)
> > >>     memory_size =3D 16 GB (16384 MB)
> > >>     memory_freq =3D 16 GHz
> > >>     memory_bus_width =3D 256 bits
> > >>     memory_bandwidth =3D 512 GB/s
> > >>     pcie_gen =3D 1
> > >>     pcie_num_lanes =3D 16
> > >>     pcie_bandwidth =3D 4.0 GB/s
> > >>
> > >> Marek
>

--000000000000a7bbc505f2080695
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D=
"gmail_attr">On Wed, Jan 11, 2023, 15:50 Alex Deucher &lt;<a href=3D"mailto=
:alexdeucher@gmail.com">alexdeucher@gmail.com</a>&gt; wrote:<br></div><bloc=
kquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #cc=
c solid;padding-left:1ex">On Wed, Jan 11, 2023 at 3:48 PM Alex Deucher &lt;=
<a href=3D"mailto:alexdeucher@gmail.com" target=3D"_blank" rel=3D"noreferre=
r">alexdeucher@gmail.com</a>&gt; wrote:<br>
&gt;<br>
&gt; On Wed, Jan 4, 2023 at 3:17 PM Marek Ol=C5=A1=C3=A1k &lt;<a href=3D"ma=
ilto:maraeo@gmail.com" target=3D"_blank" rel=3D"noreferrer">maraeo@gmail.co=
m</a>&gt; wrote:<br>
&gt; &gt;<br>
&gt; &gt; Yes, it&#39;s meant to be like a spec sheet. We are not intereste=
d in the current bandwidth utilization.<br>
&gt;<br>
&gt; After chatting with Marek on IRC and thinking about this more, I think=
<br>
&gt; this patch is fine.=C2=A0 It&#39;s not really meant for bandwidth per =
se, but<br>
&gt; rather as a limit to determine what the driver should do in certain<br=
>
&gt; cases (i.e., when does it make sense to copy to vram vs not).=C2=A0 It=
&#39;s<br>
&gt; not straightforward for userspace to parse the full topology to<br>
&gt; determine what links may be slow.=C2=A0 I guess one potential pitfall =
would<br>
&gt; be that if you pass the device into a VM, the driver may report the<br=
>
&gt; wrong values.=C2=A0 Generally in a VM the VM doesn&#39;t get the full =
view up<br>
&gt; to the root port.=C2=A0 I don&#39;t know if the hypervisors report pro=
perly for<br>
&gt; pcie_bandwidth_available() in a VM or if it just shows the info about<=
br>
&gt; the endpoint in the VM.<br>
&gt;<br>
&gt; Reviewed-by: Alex Deucher &lt;<a href=3D"mailto:alexander.deucher@amd.=
com" target=3D"_blank" rel=3D"noreferrer">alexander.deucher@amd.com</a>&gt;=
<br>
<br>
Actually:<br>
<br>
diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h<=
br>
index fe7f871e3080..f7fc7325f17f 100644<br>
--- a/include/uapi/drm/amdgpu_drm.h<br>
+++ b/include/uapi/drm/amdgpu_drm.h<br>
@@ -1053,7 +1053,7 @@ struct drm_amdgpu_info_device {<br>
=C2=A0 =C2=A0 =C2=A0__u32 enabled_rb_pipes_mask;<br>
=C2=A0 =C2=A0 =C2=A0__u32 num_rb_pipes;<br>
=C2=A0 =C2=A0 =C2=A0__u32 num_hw_gfx_contexts;<br>
-=C2=A0 =C2=A0 __u32 _pad;<br>
+=C2=A0 =C2=A0 __u32 pcie_gen;<br>
=C2=A0 =C2=A0 =C2=A0__u64 ids_flags;<br>
=C2=A0 =C2=A0 =C2=A0/** Starting virtual address for UMDs. */<br>
=C2=A0 =C2=A0 =C2=A0__u64 virtual_address_offset;<br>
@@ -1109,6 +1109,7 @@ struct drm_amdgpu_info_device {<br>
=C2=A0 =C2=A0 =C2=A0__u64 high_va_max;<br>
=C2=A0 =C2=A0 =C2=A0/* gfx10 pa_sc_tile_steering_override */<br>
=C2=A0 =C2=A0 =C2=A0__u32 pa_sc_tile_steering_override;<br>
+=C2=A0 =C2=A0 __u32 pcie_num_lanes;<br>
=C2=A0 =C2=A0 =C2=A0/* disabled TCCs */<br>
=C2=A0 =C2=A0 =C2=A0__u64 tcc_disabled_mask;<br>
=C2=A0 =C2=A0 =C2=A0__u64 min_engine_clock;<br>
<br>
Doesn&#39;t that last one need to be added to the end of the structure?<br>=
</blockquote></div></div><div dir=3D"auto"><br></div><div dir=3D"auto">Ther=
e was a hole because one u32 was surrounded by 2 u64s. (unless I missed som=
e packing #pragma)</div><div dir=3D"auto"><br></div><div dir=3D"auto">Marek=
</div><div dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_quo=
te"><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-lef=
t:1px #ccc solid;padding-left:1ex">
<br>
Alex<br>
<br>
&gt;<br>
&gt; Alex<br>
&gt;<br>
&gt; &gt;<br>
&gt; &gt; Marek<br>
&gt; &gt;<br>
&gt; &gt; On Wed, Jan 4, 2023 at 10:33 AM Lazar, Lijo &lt;<a href=3D"mailto=
:Lijo.Lazar@amd.com" target=3D"_blank" rel=3D"noreferrer">Lijo.Lazar@amd.co=
m</a>&gt; wrote:<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; [AMD Official Use Only - General]<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; To clarify, with DPM in place, the current bandwidth will be =
changing based on the load.<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; If apps/umd already has a way to know the current bandwidth u=
tilisation, then possible maximum also could be part of the same API. Other=
wise, this only looks like duplicate information. We have the same informat=
ion in sysfs DPM nodes.<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; BTW, I don&#39;t know to what extent app/umd really makes use=
 of this. Take that memory frequency as an example (I&#39;m reading it as 1=
6GHz). It only looks like a spec sheet.<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; Thanks,<br>
&gt; &gt;&gt; Lijo<br>
&gt; &gt;&gt; ________________________________<br>
&gt; &gt;&gt; From: Marek Ol=C5=A1=C3=A1k &lt;<a href=3D"mailto:maraeo@gmai=
l.com" target=3D"_blank" rel=3D"noreferrer">maraeo@gmail.com</a>&gt;<br>
&gt; &gt;&gt; Sent: Wednesday, January 4, 2023 8:40:00 PM<br>
&gt; &gt;&gt; To: Lazar, Lijo &lt;<a href=3D"mailto:Lijo.Lazar@amd.com" tar=
get=3D"_blank" rel=3D"noreferrer">Lijo.Lazar@amd.com</a>&gt;<br>
&gt; &gt;&gt; Cc: <a href=3D"mailto:amd-gfx@lists.freedesktop.org" target=
=3D"_blank" rel=3D"noreferrer">amd-gfx@lists.freedesktop.org</a> &lt;<a hre=
f=3D"mailto:amd-gfx@lists.freedesktop.org" target=3D"_blank" rel=3D"norefer=
rer">amd-gfx@lists.freedesktop.org</a>&gt;<br>
&gt; &gt;&gt; Subject: Re: [PATCH 1/2] drm/amdgpu: return the PCIe gen and =
lanes from the INFO<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; On Wed, Jan 4, 2023 at 9:19 AM Lazar, Lijo &lt;<a href=3D"mai=
lto:lijo.lazar@amd.com" target=3D"_blank" rel=3D"noreferrer">lijo.lazar@amd=
.com</a>&gt; wrote:<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; On 1/4/2023 7:43 PM, Marek Ol=C5=A1=C3=A1k wrote:<br>
&gt; &gt;&gt; &gt; On Wed, Jan 4, 2023 at 6:50 AM Lazar, Lijo &lt;<a href=
=3D"mailto:lijo.lazar@amd.com" target=3D"_blank" rel=3D"noreferrer">lijo.la=
zar@amd.com</a><br>
&gt; &gt;&gt; &gt; &lt;mailto:<a href=3D"mailto:lijo.lazar@amd.com" target=
=3D"_blank" rel=3D"noreferrer">lijo.lazar@amd.com</a>&gt;&gt; wrote:<br>
&gt; &gt;&gt; &gt;<br>
&gt; &gt;&gt; &gt;<br>
&gt; &gt;&gt; &gt;<br>
&gt; &gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0On 1/4/2023 4:11 AM, Marek Ol=C5=A1=
=C3=A1k wrote:<br>
&gt; &gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 &gt; I see. Well, those sysfs files =
are not usable, and I don&#39;t think it<br>
&gt; &gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 &gt; would be important even if they=
 were usable, but for completeness:<br>
&gt; &gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt; &gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 &gt; The ioctl returns:<br>
&gt; &gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 pcie_gen =
=3D 1<br>
&gt; &gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 pcie_num_la=
nes =3D 16<br>
&gt; &gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt; &gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 &gt; Theoretical bandwidth from thos=
e values: 4.0 GB/s<br>
&gt; &gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 &gt; My DMA test shows this write ba=
ndwidth: 3.5 GB/s<br>
&gt; &gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 &gt; It matches the expectation.<br>
&gt; &gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt; &gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 &gt; Let&#39;s see the devices (ther=
e is only 1 GPU Navi21 in the system):<br>
&gt; &gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 &gt; $ lspci |egrep &#39;(PCI|VGA).*=
Navi&#39;<br>
&gt; &gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 &gt; 0a:00.0 PCI bridge: Advanced Mi=
cro Devices, Inc. [AMD/ATI] Navi<br>
&gt; &gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A010 XL<br>
&gt; &gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 &gt; Upstream Port of PCI Express Sw=
itch (rev c3)<br>
&gt; &gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 &gt; 0b:00.0 PCI bridge: Advanced Mi=
cro Devices, Inc. [AMD/ATI] Navi<br>
&gt; &gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A010 XL<br>
&gt; &gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 &gt; Downstream Port of PCI Express =
Switch<br>
&gt; &gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 &gt; 0c:00.0 VGA compatible controll=
er: Advanced Micro Devices, Inc.<br>
&gt; &gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 &gt; [AMD/ATI] Navi 21 [Radeon RX 68=
00/6800 XT / 6900 XT] (rev c3)<br>
&gt; &gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt; &gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 &gt; Let&#39;s read sysfs:<br>
&gt; &gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt; &gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 &gt; $ cat /sys/bus/pci/devices/0000=
:0a:00.0/current_link_width<br>
&gt; &gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 &gt; 16<br>
&gt; &gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 &gt; $ cat /sys/bus/pci/devices/0000=
:0b:00.0/current_link_width<br>
&gt; &gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 &gt; 16<br>
&gt; &gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 &gt; $ cat /sys/bus/pci/devices/0000=
:0c:00.0/current_link_width<br>
&gt; &gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 &gt; 16<br>
&gt; &gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 &gt; $ cat /sys/bus/pci/devices/0000=
:0a:00.0/current_link_speed<br>
&gt; &gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 &gt; 2.5 GT/s PCIe<br>
&gt; &gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 &gt; $ cat /sys/bus/pci/devices/0000=
:0b:00.0/current_link_speed<br>
&gt; &gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 &gt; 16.0 GT/s PCIe<br>
&gt; &gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 &gt; $ cat /sys/bus/pci/devices/0000=
:0c:00.0/current_link_speed<br>
&gt; &gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 &gt; 16.0 GT/s PCIe<br>
&gt; &gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt; &gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 &gt; Problem 1: None of the speed nu=
mbers match 4 GB/s.<br>
&gt; &gt;&gt; &gt;<br>
&gt; &gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0US bridge =3D 2.5GT/s means operating=
 at PCIe Gen 1 speed. Total<br>
&gt; &gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0theoretical bandwidth is then derived=
 based on encoding and total<br>
&gt; &gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0number<br>
&gt; &gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0of lanes.<br>
&gt; &gt;&gt; &gt;<br>
&gt; &gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 &gt; Problem 2: Userspace doesn&#39;=
t know the bus index of the bridges,<br>
&gt; &gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0and it&#39;s<br>
&gt; &gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 &gt; not clear which bridge should b=
e used.<br>
&gt; &gt;&gt; &gt;<br>
&gt; &gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0In general, modern ones have this arc=
h=3D US-&gt;DS-&gt;EP. US is the one<br>
&gt; &gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0connected to physical link.<br>
&gt; &gt;&gt; &gt;<br>
&gt; &gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 &gt; Problem 3: The PCIe gen number =
is missing.<br>
&gt; &gt;&gt; &gt;<br>
&gt; &gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0Current link speed is based on whethe=
r it&#39;s Gen1/2/3/4/5.<br>
&gt; &gt;&gt; &gt;<br>
&gt; &gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0BTW, your patch makes use of capabili=
ties flags which gives the maximum<br>
&gt; &gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0supported speed/width by the device. =
It may not necessarily reflect the<br>
&gt; &gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0current speed/width negotiated. I gue=
ss in NV, this info is already<br>
&gt; &gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0obtained from PMFW and made available=
 through metrics table.<br>
&gt; &gt;&gt; &gt;<br>
&gt; &gt;&gt; &gt;<br>
&gt; &gt;&gt; &gt; It computes the minimum of the device PCIe gen and the m=
otherboard/slot<br>
&gt; &gt;&gt; &gt; PCIe gen to get the final value. These 2 lines do that. =
The low 16 bits<br>
&gt; &gt;&gt; &gt; of the mask contain the device PCIe gen mask. The high 1=
6 bits of the<br>
&gt; &gt;&gt; &gt; mask contain the slot PCIe gen mask.<br>
&gt; &gt;&gt; &gt; + pcie_gen_mask =3D adev-&gt;pm.pcie_gen_mask &amp; (ade=
v-&gt;pm.pcie_gen_mask &gt;&gt; 16);<br>
&gt; &gt;&gt; &gt; + dev_info-&gt;pcie_gen =3D fls(pcie_gen_mask);<br>
&gt; &gt;&gt; &gt;<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; With DPM in place on some ASICs, how much does this static in=
fo help for<br>
&gt; &gt;&gt; upper level apps?<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; It helps UMDs make better decisions if they know the maximum =
achievable bandwidth. UMDs also compute the maximum memory bandwidth and co=
mpute performance (FLOPS). Right now it&#39;s printed by Mesa to give users=
 detailed information about their GPU. For example:<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; $ AMD_DEBUG=3Dinfo glxgears<br>
&gt; &gt;&gt; Device info:<br>
&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0name =3D NAVI21<br>
&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0marketing_name =3D AMD Radeon RX 6800<br>
&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0num_se =3D 3<br>
&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0num_rb =3D 12<br>
&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0num_cu =3D 60<br>
&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0max_gpu_freq =3D 2475 MHz<br>
&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0max_gflops =3D 19008 GFLOPS<br>
&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0l0_cache_size =3D 16 KB<br>
&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0l1_cache_size =3D 128 KB<br>
&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0l2_cache_size =3D 4096 KB<br>
&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0l3_cache_size =3D 128 MB<br>
&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0memory_channels =3D 16 (TCC blocks)<br>
&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0memory_size =3D 16 GB (16384 MB)<br>
&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0memory_freq =3D 16 GHz<br>
&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0memory_bus_width =3D 256 bits<br>
&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0memory_bandwidth =3D 512 GB/s<br>
&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0pcie_gen =3D 1<br>
&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0pcie_num_lanes =3D 16<br>
&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0pcie_bandwidth =3D 4.0 GB/s<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; Marek<br>
</blockquote></div></div></div>

--000000000000a7bbc505f2080695--
