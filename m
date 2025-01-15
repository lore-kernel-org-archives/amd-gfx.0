Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D9FDE77188
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jan 2025 01:47:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ACC2C10E4A0;
	Wed, 15 Jan 2025 01:47:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="xh79FPCW";
	dkim-atps=neutral
Received: from out30-98.freemail.mail.aliyun.com
 (out30-98.freemail.mail.aliyun.com [115.124.30.98])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4742610E4A0
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jan 2025 01:47:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1736905658; h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To;
 bh=vM3O5MdA4RKLBSLx909KS/fU6ghNrkpi2B0asy2DSSM=;
 b=xh79FPCWhc1Ektvmf/L1E8GThxESq7RoScs/6sHZd/BXxzLuKt0MJFE7EbaD1rcTCJ5CT3jWCNChkFBMPujP5W0gyL/xi2zNacMhLTzgEDANherv8FNEoPHKZ8OLxMkwkz6IG1XavgZCweMaMxb4j8CiL6L3SfIAwwl6Ri2j038=
Received: from smtpclient.apple(mailfrom:gerry@linux.alibaba.com
 fp:SMTPD_---0WNgc9wE_1736905655 cluster:ay36) by smtp.aliyun-inc.com;
 Wed, 15 Jan 2025 09:47:36 +0800
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.1\))
Subject: Re: [RFC v1 0/2] Enable resume with different AMD SRIOV vGPUs
From: Gerry Liu <gerry@linux.alibaba.com>
In-Reply-To: <CH0PR12MB53726FB2D787A0A6D22A2603F4182@CH0PR12MB5372.namprd12.prod.outlook.com>
Date: Wed, 15 Jan 2025 09:47:35 +0800
Cc: "Koenig, Christian" <Christian.Koenig@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Pan, Xinhui" <Xinhui.Pan@amd.com>,
 "airlied@gmail.com" <airlied@gmail.com>,
 "simona@ffwll.ch" <simona@ffwll.ch>,
 "Khatri, Sunil" <Sunil.Khatri@amd.com>, "Lazar, Lijo" <Lijo.Lazar@amd.com>,
 "Zhang, Hawking" <Hawking.Zhang@amd.com>,
 "Limonciello, Mario" <Mario.Limonciello@amd.com>,
 "Chen, Xiaogang" <Xiaogang.Chen@amd.com>,
 "Russell, Kent" <Kent.Russell@amd.com>,
 "shuox.liu@linux.alibaba.com" <shuox.liu@linux.alibaba.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <3C088F3C-8592-494D-8976-4BCD64C2A6A9@linux.alibaba.com>
References: <cover.1736847835.git.gerry@linux.alibaba.com>
 <46f008f8-6e88-4475-9510-6072f990c377@amd.com>
 <DC5FBF2C-9F17-4E22-9D51-525EB33FC79E@linux.alibaba.com>
 <820617e7-f82f-4a08-9035-0c4a753b61ee@amd.com>
 <CH0PR12MB53726FB2D787A0A6D22A2603F4182@CH0PR12MB5372.namprd12.prod.outlook.com>
To: "Liu, Shaoyun" <Shaoyun.Liu@amd.com>
X-Mailer: Apple Mail (2.3696.120.41.1.1)
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



> 2025=E5=B9=B41=E6=9C=8815=E6=97=A5 02:00=EF=BC=8CLiu, Shaoyun =
<Shaoyun.Liu@amd.com> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> [AMD Official Use Only - AMD Internal Distribution Only]
>=20
> I think to resume with different SRIOV vGPUs depends on the  =
hypervisor has the live migration support . Different Hypervisor have =
different implementation , basically  it will call into the  host gpu =
driver in different stage and  host side do the  hw related  migration =
including the FW state.
Hi Shaoyun,
	Great news! That sounds like what I=E2=80=99m looking for:)
	Is there any documentation about how to enable this with an =
in-house implemented hypervisor? Will the hypervisor need to cooperate =
with the gim driver to enable resume with different vGPUs?
Regards
Gerry

> =20
> Regards
> Shaoyun.liu
> =20
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of =
Christian K=C3=B6nig
> Sent: Tuesday, January 14, 2025 7:44 AM
> To: Gerry Liu <gerry@linux.alibaba.com>
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Pan, Xinhui =
<Xinhui.Pan@amd.com>; airlied@gmail.com; simona@ffwll.ch; Khatri, Sunil =
<Sunil.Khatri@amd.com>; Lazar, Lijo <Lijo.Lazar@amd.com>; Zhang, Hawking =
<Hawking.Zhang@amd.com>; Limonciello, Mario <Mario.Limonciello@amd.com>; =
Chen, Xiaogang <Xiaogang.Chen@amd.com>; Russell, Kent =
<Kent.Russell@amd.com>; shuox.liu@linux.alibaba.com; =
amd-gfx@lists.freedesktop.org
> Subject: Re: [RFC v1 0/2] Enable resume with different AMD SRIOV vGPUs
> =20
> Hi Gerry,
>=20
> Am 14.01.25 um 12:03 schrieb Gerry Liu:=20
> 2025=E5=B9=B41=E6=9C=8814=E6=97=A5 18:46=EF=BC=8CChristian K=C3=B6nig =
<christian.koenig@amd.com> =E5=86=99=E9=81=93=EF=BC=9A
> =20
> Hi Jiang,
> =20
> Some of the firmware, especially the multimedia ones, keep FW pointers =
to buffers in the suspend/resume state.
> =20
> In other words the firmware needs to be in the exact same location =
before and after resume. That's why we don't unpin the firmware BOs, but =
rather save their content and restore it. See function =
amdgpu_vcn_save_vcpu_bo() for reference.
> =20
> Additional to that the serial numbers, IDs etc are used for things =
like TMZ. So anything which uses HW encryption won't work any more.
> =20
> Then even two identical boards can have different harvest and memory =
channel configurations. Could be that we might be able to abstract that =
with SR-IOV but I won't rely on that.
> =20
> To summarize that looks like a completely futile effort which most =
likely won't work reliable in a production environment.
> Hi Christian,
>   Thanks for the information. Previously I assume that we may reset =
the asic and reload all firmwares on resume, but missed the vcn ip block =
which save and restore firmware vram content during suspend/resume. Is =
there any other IP blocks which save and restore firmware ram content?
>=20
> Not that I of hand know of any, but neither the hypervisor nor the =
driver stack was designed with something like this in mind. So could be =
that there are other dependencies I don't know about.
>=20
> I do remember that this idea of resuming on different HW than =
suspending came up a while ago and was rejected by multiple parties as =
to complicated and error prone.
>=20
> So we never looked more deeply into the possibility of doing that.
>=20
>=20
> =20
>   Our usage scenario targets GPGPU workload (amdkfd) with AMD GPU in =
single SR-IOV vGPU mode. Is it possible to resume on a different vGPU =
device in such a case?
>=20
> If I'm not completely mistaken you can use checkpoint/restore for =
that. It's still under development, but as far as I can see it should =
solve your problem quite nicely.
>=20
> Regards,
> Christian.
>=20
>=20
> =20
> Regards,
> Gerry=20
> =20
> =20
> =20
> Regards,
> Christian.
> =20
> Am 14.01.25 um 10:54 schrieb Jiang Liu:
> For virtual machines with AMD SR-IOV vGPUs, following work flow may be
> used to support virtual machine hibernation(suspend):
> 1) suspends a virtual machine with AMD vGPU A.
> 2) hypervisor dumps guest RAM content to a disk image.
> 3) hypervisor loads the guest system image from disk.
> 4) resumes the guest OS with a different AMD vGPU B.
> =20
> The step 4 above is special because we are resuming with a different
> AMD vGPU device and the amdgpu driver may observe changed device
> properties. To support above work flow, we need to fix those changed
> device properties cached by the amdgpu drivers.
> =20
> With information from the amdgpu driver source code (haven't read
> corresponding hardware specs yet), we have identified following =
changed
> device properties:
> 1) PCI MMIO address. This can be fixed by hypervisor.
> 2) serial_number, unique_id, xgmi_device_id, fru_id in sysfs. Seems
>    they are information only.
> 3) xgmi_physical_id if xgmi is enabled, which affects VRAM MC address.
> 4) mc_fb_offset, which affects VRAM physical address.
> =20
> We will focus on the VRAM address related changes here, because it's
> sensitive to the GPU functionalities. The original data sources =
include
> .get_mc_fb_offset(), .get_fb_location() and xgmi hardware registers.
> The main data cached by amdgpu driver are adev->gmc.vram_start and
> adev->vm_manager.vram_base_offset. And the major consumers of the
> cached information are ip_block.hw_init() and GMU page table builder.
> =20
> After code analysis, we found that most consumers of =
dev->gmc.vram_start
> and adev->vm_manager.vram_base_offset directly read value from these
> two variables on demand instead of caching them. So if we fix these
> two cached fields on resume, everything should work as expected.
> =20
> But there's an exception, and an very import exception, that callers
> of amdgpu_bo_create_kernel()/amdgpu_bo_create_reserved() may cache
> VRAM addresses. With further analysis, the callers of these interface
> have three different patterns:
> 1) This pattern is safe.
>    - call amdgpu_bo_create_reserved() in ip_block.hw_init()
>    - call amdgpu_bo_free_kernel() in ip_block.suspend()
>    - call amdgpu_bo_create_reserved() in ip_block.resume()
> 2) This pattern works with current implementaiton of =
amdgpu_bo_create_reserved()
>    but bo.pin_count gets incorrect.
>    - call amdgpu_bo_create_reserved() in ip_block.hw_init()
>    - call amdgpu_bo_create_reserved() in ip_block.resume()
> 3) This pattern needs to be enhanced.
>    - call amdgpu_bo_create_reserved() in ip_block.sw_init()
> =20
> So my question is which pattern should we use here? Personally I =
prefer
> pattern 2 with enhancement to fix the bo.pin_count.
> =20
> Currently there're still bugs in SRIOV suspend/resume, so we can't =
test
> our hypothesis. And we are not sure whether there are still other
> blocking to enable resume with different AMD SR-IOV vGPUs.
> =20
> Help is needed to identify more task items to enable resume with
> different AMD SR-IOV vGPUs:)
> =20
> Jiang Liu (2):
>   drm/amdgpu: update cached vram base addresses on resume
>   drm/amdgpu: introduce helper amdgpu_bo_get_pinned_gpu_addr()
> =20
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c   | 15 +++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h      |  6 ++++--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_object.c   |  9 +++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_object.h   |  1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c |  9 +++++++++
>  drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c       |  7 +++++++
>  drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c        |  6 ++++++
>  7 files changed, 51 insertions(+), 2 deletions(-)

