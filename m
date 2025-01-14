Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 738DBE77188
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jan 2025 11:03:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1E66C10E14D;
	Tue, 14 Jan 2025 11:03:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="xezEohKU";
	dkim-atps=neutral
Received: from out30-113.freemail.mail.aliyun.com
 (out30-113.freemail.mail.aliyun.com [115.124.30.113])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 88EAF10E13C
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jan 2025 11:03:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1736852624; h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To;
 bh=luCXh2YJiupM4hJkz9RwaoCkwhQYMJ/GKHFGfM0nFBE=;
 b=xezEohKU/8K67KuFQgAOyLo7gtbDCP3x7Eisc1/WxTKFqTtNYYPwdEibHywwHYZ+hRCRPF+jpoksEkt+zR/O5NtYLFAyC6/6o6D6N/3lQ4zPPh2LBv7yQTFfprcHLZSuL1o0V4qrxDYw0zxB0zqelN3OSP+Aike2Z96KaJcDhpE=
Received: from smtpclient.apple(mailfrom:gerry@linux.alibaba.com
 fp:SMTPD_---0WNf4uvx_1736852622 cluster:ay36) by smtp.aliyun-inc.com;
 Tue, 14 Jan 2025 19:03:43 +0800
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.1\))
Subject: Re: [RFC v1 0/2] Enable resume with different AMD SRIOV vGPUs
From: Gerry Liu <gerry@linux.alibaba.com>
In-Reply-To: <46f008f8-6e88-4475-9510-6072f990c377@amd.com>
Date: Tue, 14 Jan 2025 19:03:41 +0800
Cc: alexander.deucher@amd.com, Xinhui.Pan@amd.com, airlied@gmail.com,
 simona@ffwll.ch, sunil.khatri@amd.com, lijo.lazar@amd.com,
 Hawking.Zhang@amd.com, mario.limonciello@amd.com, xiaogang.chen@amd.com,
 Kent.Russell@amd.com, shuox.liu@linux.alibaba.com,
 amd-gfx@lists.freedesktop.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <DC5FBF2C-9F17-4E22-9D51-525EB33FC79E@linux.alibaba.com>
References: <cover.1736847835.git.gerry@linux.alibaba.com>
 <46f008f8-6e88-4475-9510-6072f990c377@amd.com>
To: =?utf-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
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



> 2025=E5=B9=B41=E6=9C=8814=E6=97=A5 18:46=EF=BC=8CChristian K=C3=B6nig =
<christian.koenig@amd.com> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> Hi Jiang,
>=20
> Some of the firmware, especially the multimedia ones, keep FW pointers =
to buffers in the suspend/resume state.
>=20
> In other words the firmware needs to be in the exact same location =
before and after resume. That's why we don't unpin the firmware BOs, but =
rather save their content and restore it. See function =
amdgpu_vcn_save_vcpu_bo() for reference.
>=20
> Additional to that the serial numbers, IDs etc are used for things =
like TMZ. So anything which uses HW encryption won't work any more.
>=20
> Then even two identical boards can have different harvest and memory =
channel configurations. Could be that we might be able to abstract that =
with SR-IOV but I won't rely on that.
>=20
> To summarize that looks like a completely futile effort which most =
likely won't work reliable in a production environment.
Hi Christian,
	Thanks for the information. Previously I assume that we may =
reset the asic and reload all firmwares on resume, but missed the vcn ip =
block which save and restore firmware vram content during =
suspend/resume. Is there any other IP blocks which save and restore =
firmware ram content?
	Our usage scenario targets GPGPU workload (amdkfd) with AMD GPU =
in single SR-IOV vGPU mode. Is it possible to resume on a different vGPU =
device in such a case?
Regards,
Gerry=20


>=20
> Regards,
> Christian.
>=20
> Am 14.01.25 um 10:54 schrieb Jiang Liu:
>> For virtual machines with AMD SR-IOV vGPUs, following work flow may =
be
>> used to support virtual machine hibernation(suspend):
>> 1) suspends a virtual machine with AMD vGPU A.
>> 2) hypervisor dumps guest RAM content to a disk image.
>> 3) hypervisor loads the guest system image from disk.
>> 4) resumes the guest OS with a different AMD vGPU B.
>>=20
>> The step 4 above is special because we are resuming with a different
>> AMD vGPU device and the amdgpu driver may observe changed device
>> properties. To support above work flow, we need to fix those changed
>> device properties cached by the amdgpu drivers.
>>=20
>> With information from the amdgpu driver source code (haven't read
>> corresponding hardware specs yet), we have identified following =
changed
>> device properties:
>> 1) PCI MMIO address. This can be fixed by hypervisor.
>> 2) serial_number, unique_id, xgmi_device_id, fru_id in sysfs. Seems
>>    they are information only.
>> 3) xgmi_physical_id if xgmi is enabled, which affects VRAM MC =
address.
>> 4) mc_fb_offset, which affects VRAM physical address.
>>=20
>> We will focus on the VRAM address related changes here, because it's
>> sensitive to the GPU functionalities. The original data sources =
include
>> .get_mc_fb_offset(), .get_fb_location() and xgmi hardware registers.
>> The main data cached by amdgpu driver are adev->gmc.vram_start and
>> adev->vm_manager.vram_base_offset. And the major consumers of the
>> cached information are ip_block.hw_init() and GMU page table builder.
>>=20
>> After code analysis, we found that most consumers of =
dev->gmc.vram_start
>> and adev->vm_manager.vram_base_offset directly read value from these
>> two variables on demand instead of caching them. So if we fix these
>> two cached fields on resume, everything should work as expected.
>>=20
>> But there's an exception, and an very import exception, that callers
>> of amdgpu_bo_create_kernel()/amdgpu_bo_create_reserved() may cache
>> VRAM addresses. With further analysis, the callers of these interface
>> have three different patterns:
>> 1) This pattern is safe.
>>    - call amdgpu_bo_create_reserved() in ip_block.hw_init()
>>    - call amdgpu_bo_free_kernel() in ip_block.suspend()
>>    - call amdgpu_bo_create_reserved() in ip_block.resume()
>> 2) This pattern works with current implementaiton of =
amdgpu_bo_create_reserved()
>>    but bo.pin_count gets incorrect.
>>    - call amdgpu_bo_create_reserved() in ip_block.hw_init()
>>    - call amdgpu_bo_create_reserved() in ip_block.resume()
>> 3) This pattern needs to be enhanced.
>>    - call amdgpu_bo_create_reserved() in ip_block.sw_init()
>>=20
>> So my question is which pattern should we use here? Personally I =
prefer
>> pattern 2 with enhancement to fix the bo.pin_count.
>>=20
>> Currently there're still bugs in SRIOV suspend/resume, so we can't =
test
>> our hypothesis. And we are not sure whether there are still other
>> blocking to enable resume with different AMD SR-IOV vGPUs.
>>=20
>> Help is needed to identify more task items to enable resume with
>> different AMD SR-IOV vGPUs:)
>>=20
>> Jiang Liu (2):
>>   drm/amdgpu: update cached vram base addresses on resume
>>   drm/amdgpu: introduce helper amdgpu_bo_get_pinned_gpu_addr()
>>=20
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c   | 15 +++++++++++++++
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h      |  6 ++++--
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_object.c   |  9 +++++++++
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_object.h   |  1 +
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c |  9 +++++++++
>>  drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c       |  7 +++++++
>>  drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c        |  6 ++++++
>>  7 files changed, 51 insertions(+), 2 deletions(-)
>>=20

