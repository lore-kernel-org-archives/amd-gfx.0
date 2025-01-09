Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80619E77197
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Jan 2025 05:34:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1E29F10ECE0;
	Thu,  9 Jan 2025 05:34:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="WDDVF/at";
	dkim-atps=neutral
Received: from out30-119.freemail.mail.aliyun.com
 (out30-119.freemail.mail.aliyun.com [115.124.30.119])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7B67110ECE0
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Jan 2025 05:34:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1736400846; h=From:Message-Id:Content-Type:Mime-Version:Subject:Date:To;
 bh=qvi14AqawMZxS5WL8IE406Dawlq5z1HCXPZIROQlQx4=;
 b=WDDVF/athyJkTOY3vPPJEz9Ag4JPD01K7vSYU4eV3cafeKi1+stBz6CodHxXa61xJJzzd4k/Hxp6wEI5May0QWeMvTGILPzS/ACQREWa9ZdAiZqwwhg+lTMLTy9V3RkLAe/KspIf0XGCXBtxhAhyuywh2R/snuDtTvBdZfSZBPc=
Received: from smtpclient.apple(mailfrom:gerry@linux.alibaba.com
 fp:SMTPD_---0WNGGZMv_1736400844 cluster:ay36) by smtp.aliyun-inc.com;
 Thu, 09 Jan 2025 13:34:05 +0800
From: Gerry Liu <gerry@linux.alibaba.com>
Message-Id: <A6A619E6-08E4-4A60-951B-26F2BF4F93E4@linux.alibaba.com>
Content-Type: multipart/alternative;
 boundary="Apple-Mail=_EDF93A91-C2F0-472C-839F-0316D67A3F6E"
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.1\))
Subject: Re: 
Date: Thu, 9 Jan 2025 13:34:03 +0800
In-Reply-To: <37c31a32-c5fb-4a5b-8aad-448997f94cda@amd.com>
Cc: alexander.deucher@amd.com, christian.koenig@amd.com, Xinhui.Pan@amd.com,
 airlied@gmail.com, simona@ffwll.ch, sunil.khatri@amd.com,
 "Lazar, Lijo" <lijo.lazar@amd.com>, Hawking.Zhang@amd.com,
 "Chen, Xiaogang" <xiaogang.chen@amd.com>, Kent.Russell@amd.com,
 Shuo Liu <shuox.liu@linux.alibaba.com>, amd-gfx@lists.freedesktop.org
To: Mario Limonciello <mario.limonciello@amd.com>
References: <cover.1736344725.git.gerry@linux.alibaba.com>
 <37c31a32-c5fb-4a5b-8aad-448997f94cda@amd.com>
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


--Apple-Mail=_EDF93A91-C2F0-472C-839F-0316D67A3F6E
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8



> 2025=E5=B9=B41=E6=9C=889=E6=97=A5 00:33=EF=BC=8CMario Limonciello =
<mario.limonciello@amd.com> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> On 1/8/2025 07:59, Jiang Liu wrote:
>> Subject: [RFC PATCH 00/13] Enhance device state machine to better =
support suspend/resume
>=20
> I'm not sure how this happened, but your subject didn't end up in the =
subject of the thread on patch 0 so the thread just looks like an =
unsubjected thread.
Maybe it=E2=80=99s caused by one extra blank line at the header.

>=20
>> Recently we were testing suspend/resume functionality with AMD GPUs,
>> we have encountered several resource tracking related bugs, such as
>> double buffer free, use after free and unbalanced irq reference =
count.
>=20
> Can you share more aobut how you were hitting these issues?  Are they =
specific to S3 or to s2idle flows?  dGPU or APU?
> Are they only with SRIOV?
>=20
> Is there anything to do with the host influencing the failures to =
happen, or are you contriving the failures to find the bugs?
>=20
> I know we've had some reports about resource tracking warnings on the =
reset flows, but I haven't heard much about suspend/resume.
We are investigating to develop some advanced product features based on =
amdgpu suspend/resume.
So we started by tested the suspend/resume functionality of AMD 308x =
GPUs with the following simple script:
```
echo platform > /sys/power/pm_test
i=3D0
while true; do
        echo mem > /sys/power/state
        let i=3Di+1
        echo $i
        sleep 1
done
```

It succeeds with the first and second iteration but always fails on =
following iterations on a bare metal servers with eight MI308X GPUs.
With some investigation we found that the gpu asic should be reset =
during the test, so we submitted a patch to fix the failure =
(https://github.com/ROCm/ROCK-Kernel-Driver/pull/181 =
<https://github.com/ROCm/ROCK-Kernel-Driver/pull/181>)

During analyze and root-cause the failure, we have encountered several =
crashes, resource leakages and false alarms.
So I have worked out patch sets to solve issues we encountered. The =
other patch set is =
https://lists.freedesktop.org/archives/amd-gfx/2025-January/118484.html =
<https://lists.freedesktop.org/archives/amd-gfx/2025-January/118484.html>

With sriov in single VF mode, resume always fails. Seems some =
contexts/vram buffers get lost during suspend and haven=E2=80=99t be =
restored on resume, so cause failure.
We haven=E2=80=99t tested sriov in multiple VFs mode yet. We need more =
help from AMD side to make SR work for SRIOV:) =20

>=20
>> We have tried to solve these issues case by case, but found that may
>> not be the right way. Especially about the unbalanced irq reference
>> count, there will be new issues appear once we fixed the current =
known
>> issues. After analyzing related source code, we found that there may =
be
>> some fundamental implementaion flaws behind these resource tracking
>=20
> implementation
>=20
>> issues.
>> The amdgpu driver has two major state machines to driver the device
>> management flow, one is for ip blocks, the other is for ras blocks.
>> The hook points defined in struct amd_ip_funcs for device =
setup/teardown
>> are symmetric, but the implementation is asymmetric, sometime even
>> ambiguous. The most obvious two issues we noticed are:
>> 1) amdgpu_irq_get() are called from .late_init() but amdgpu_irq_put()
>>    are called from .hw_fini() instead of .early_fini().
>> 2) the way to reset ip_bloc.status.valid/sw/hw/late_initialized =
doesn't
>>    match the way to set those flags.
>> When taking device suspend/resume into account, in addition to device
>> probe/remove, things get much more complex. Some issues arise because
>> many suspend/resume implementations directly reuse .hw_init/.hw_fini/
>> .late_init hook points.
>>=20
>> So we try to fix those issues by two enhancements/refinements to =
current
>> device management state machines.
>> The first change is to make the ip block state machine and associated
>> status flags work in stack-like way as below:
>> Callback        Status Flags
>> early_init:     valid =3D true
>> sw_init:        sw =3D true
>> hw_init:        hw =3D true
>> late_init:      late_initialized =3D true
>> early_fini:     late_initialized =3D false
>> hw_fini:        hw =3D false
>> sw_fini:        sw =3D false
>> late_fini:      valid =3D false
>=20
> At a high level this makes sense to me, but I'd just call 'late' or =
'late_init'.
>=20
> Another idea if you make it stack like is to do it as a true enum for =
the state machine and store it all in one variable.
I will add a patch to convert those bool flags into an enum.
Thanks,
Gerry

>=20
>> Also do the same thing for ras block state machine, though it's much
>> more simpler.
>> The second change is fine tune the overall device management work
>> flow as below:
>> 1. amdgpu_driver_load_kms()
>> 	amdgpu_device_init()
>> 		amdgpu_device_ip_early_init()
>> 			ip_blocks[i].early_init()
>> 			ip_blocks[i].status.valid =3D true
>> 		amdgpu_device_ip_init()
>> 			amdgpu_ras_init()
>> 			ip_blocks[i].sw_init()
>> 			ip_blocks[i].status.sw =3D true
>> 			ip_blocks[i].hw_init()
>> 			ip_blocks[i].status.hw =3D true
>> 		amdgpu_device_ip_late_init()
>> 			ip_blocks[i].late_init()
>> 			ip_blocks[i].status.late_initialized =3D true
>> 			amdgpu_ras_late_init()
>> 				ras_blocks[i].ras_late_init()
>> 					=
amdgpu_ras_feature_enable_on_boot()
>> 2. =
amdgpu_pmops_suspend()/amdgpu_pmops_freeze()/amdgpu_pmops_poweroff()
>> 	amdgpu_device_suspend()
>> 		amdgpu_ras_early_fini()
>> 			ras_blocks[i].ras_early_fini()
>> 				amdgpu_ras_feature_disable()
>> 		amdgpu_ras_suspend()
>> 			amdgpu_ras_disable_all_features()
>> +++		ip_blocks[i].early_fini()
>> +++		ip_blocks[i].status.late_initialized =3D false
>> 		ip_blocks[i].suspend()
>> 3. amdgpu_pmops_resume()/amdgpu_pmops_thaw()/amdgpu_pmops_restore()
>> 	amdgpu_device_resume()
>> 		amdgpu_device_ip_resume()
>> 			ip_blocks[i].resume()
>> 		amdgpu_device_ip_late_init()
>> 			ip_blocks[i].late_init()
>> 			ip_blocks[i].status.late_initialized =3D true
>> 			amdgpu_ras_late_init()
>> 				ras_blocks[i].ras_late_init()
>> 					=
amdgpu_ras_feature_enable_on_boot()
>> 		amdgpu_ras_resume()
>> 			amdgpu_ras_enable_all_features()
>> 4. amdgpu_driver_unload_kms()
>> 	amdgpu_device_fini_hw()
>> 		amdgpu_ras_early_fini()
>> 			ras_blocks[i].ras_early_fini()
>> +++		ip_blocks[i].early_fini()
>> +++		ip_blocks[i].status.late_initialized =3D false
>> 		ip_blocks[i].hw_fini()
>> 		ip_blocks[i].status.hw =3D false
>> 5. amdgpu_driver_release_kms()
>> 	amdgpu_device_fini_sw()
>> 		amdgpu_device_ip_fini()
>> 			ip_blocks[i].sw_fini()
>> 			ip_blocks[i].status.sw =3D false
>> ---			ip_blocks[i].status.valid =3D false
>> +++			amdgpu_ras_fini()
>> 			ip_blocks[i].late_fini()
>> +++			ip_blocks[i].status.valid =3D false
>> ---			ip_blocks[i].status.late_initialized =3D false
>> ---			amdgpu_ras_fini()
>> The main changes include:
>> 1) invoke ip_blocks[i].early_fini in amdgpu_pmops_suspend().
>>    Currently there's only one ip block which provides `early_fini`
>>    callback. We have add a check of `in_s3` to keep current behavior =
in
>>    function amdgpu_dm_early_fini(). So there should be no functional
>>    changes.
>> 2) set ip_blocks[i].status.late_initialized to false after calling
>>    callback `early_fini`. We have auditted all usages of the
>>    late_initialized flag and no functional changes found.
>> 3) only set ip_blocks[i].status.valid =3D false after calling the
>>    `late_fini` callback.
>> 4) call amdgpu_ras_fini() before invoking ip_blocks[i].late_fini.
>> Then we try to refine each subsystem, such as nbio, asic, gfx, gmc,
>> ras etc, to follow the new design. Currently we have only taken the
>> nbio and asic as examples to show the proposed changes. Once we have
>> confirmed that's the right way to go, we will handle the lefting
>> subsystems.
>> This is in early stage and requesting for comments, any comments and
>> suggestions are welcomed!
>> Jiang Liu (13):
>>   amdgpu: wrong array index to get ip block for PSP
>>   drm/admgpu: add helper functions to track status for ras manager
>>   drm/amdgpu: add a flag to track ras debugfs creation status
>>   drm/amdgpu: free all resources on error recovery path of
>>     amdgpu_ras_init()
>>   drm/amdgpu: introduce a flag to track refcount held for features
>>   drm/amdgpu: enhance amdgpu_ras_block_late_fini()
>>   drm/amdgpu: enhance amdgpu_ras_pre_fini() to better support SR
>>   drm/admgpu: rename amdgpu_ras_pre_fini() to amdgpu_ras_early_fini()
>>   drm/amdgpu: make IP block state machine works in stack like way
>>   drm/admgpu: make device state machine work in stack like way
>>   drm/amdgpu/sdma: improve the way to manage irq reference count
>>   drm/amdgpu/nbio: improve the way to manage irq reference count
>>   drm/amdgpu/asic: make ip block operations symmetric by =
.early_fini()
>>  drivers/gpu/drm/amd/amdgpu/amdgpu.h           |  40 +++++
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |  37 ++++-
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c       |   2 +-
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c      |   2 +-
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.c      |  16 +-
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h      |   1 +
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c       |   8 +-
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c       | 144 =
+++++++++++++-----
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h       |  16 +-
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c      |  26 +++-
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h      |   2 +
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c       |   2 +-
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c       |   2 +-
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c      |   2 +-
>>  drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c       |   2 +-
>>  drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c       |   2 +-
>>  drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c        |   1 +
>>  drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c        |   1 +
>>  drivers/gpu/drm/amd/amdgpu/nv.c               |  14 +-
>>  drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c        |   8 -
>>  drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c      |  23 +--
>>  drivers/gpu/drm/amd/amdgpu/soc15.c            |  38 ++---
>>  drivers/gpu/drm/amd/amdgpu/soc21.c            |  35 +++--
>>  drivers/gpu/drm/amd/amdgpu/soc24.c            |  17 ++-
>>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |   3 +
>>  25 files changed, 326 insertions(+), 118 deletions(-)


--Apple-Mail=_EDF93A91-C2F0-472C-839F-0316D67A3F6E
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=utf-8

<html><head><meta http-equiv=3D"Content-Type" content=3D"text/html; =
charset=3Dutf-8"></head><body style=3D"word-wrap: break-word; =
-webkit-nbsp-mode: space; line-break: after-white-space;" class=3D""><br =
class=3D""><div><br class=3D""><blockquote type=3D"cite" class=3D""><div =
class=3D"">2025=E5=B9=B41=E6=9C=889=E6=97=A5 00:33=EF=BC=8CMario =
Limonciello &lt;<a href=3D"mailto:mario.limonciello@amd.com" =
class=3D"">mario.limonciello@amd.com</a>&gt; =E5=86=99=E9=81=93=EF=BC=9A</=
div><br class=3D"Apple-interchange-newline"><div class=3D""><meta =
charset=3D"UTF-8" class=3D""><span style=3D"caret-color: rgb(0, 0, 0); =
font-family: Helvetica; font-size: 18px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none; float: none; display: inline !important;" =
class=3D"">On 1/8/2025 07:59, Jiang Liu wrote:</span><br =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
18px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none;" =
class=3D""><blockquote type=3D"cite" style=3D"font-family: Helvetica; =
font-size: 18px; font-style: normal; font-variant-caps: normal; =
font-weight: 400; letter-spacing: normal; orphans: auto; text-align: =
start; text-indent: 0px; text-transform: none; white-space: normal; =
widows: auto; word-spacing: 0px; -webkit-text-size-adjust: auto; =
-webkit-text-stroke-width: 0px; text-decoration: none;" =
class=3D"">Subject: [RFC PATCH 00/13] Enhance device state machine to =
better support suspend/resume<br class=3D""></blockquote><br =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
18px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none;" class=3D""><span =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
18px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none; float: none; =
display: inline !important;" class=3D"">I'm not sure how this happened, =
but your subject didn't end up in the subject of the thread on patch 0 =
so the thread just looks like an unsubjected thread.</span><br =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
18px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none;" =
class=3D""></div></blockquote><div>Maybe it=E2=80=99s caused by one =
extra blank line at the header.</div><br class=3D""><blockquote =
type=3D"cite" class=3D""><div class=3D""><br style=3D"caret-color: =
rgb(0, 0, 0); font-family: Helvetica; font-size: 18px; font-style: =
normal; font-variant-caps: normal; font-weight: 400; letter-spacing: =
normal; text-align: start; text-indent: 0px; text-transform: none; =
white-space: normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none;" class=3D""><blockquote type=3D"cite" =
style=3D"font-family: Helvetica; font-size: 18px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
orphans: auto; text-align: start; text-indent: 0px; text-transform: =
none; white-space: normal; widows: auto; word-spacing: 0px; =
-webkit-text-size-adjust: auto; -webkit-text-stroke-width: 0px; =
text-decoration: none;" class=3D"">Recently we were testing =
suspend/resume functionality with AMD GPUs,<br class=3D"">we have =
encountered several resource tracking related bugs, such as<br =
class=3D"">double buffer free, use after free and unbalanced irq =
reference count.<br class=3D""></blockquote><br style=3D"caret-color: =
rgb(0, 0, 0); font-family: Helvetica; font-size: 18px; font-style: =
normal; font-variant-caps: normal; font-weight: 400; letter-spacing: =
normal; text-align: start; text-indent: 0px; text-transform: none; =
white-space: normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none;" class=3D""><span style=3D"caret-color: rgb(0, 0, =
0); font-family: Helvetica; font-size: 18px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none; float: none; display: inline !important;" =
class=3D"">Can you share more aobut how you were hitting these issues? =
&nbsp;Are they specific to S3 or to s2idle flows? &nbsp;dGPU or =
APU?</span><br style=3D"caret-color: rgb(0, 0, 0); font-family: =
Helvetica; font-size: 18px; font-style: normal; font-variant-caps: =
normal; font-weight: 400; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: =
none;" class=3D""><span style=3D"caret-color: rgb(0, 0, 0); font-family: =
Helvetica; font-size: 18px; font-style: normal; font-variant-caps: =
normal; font-weight: 400; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: =
none; float: none; display: inline !important;" class=3D"">Are they only =
with SRIOV?</span><br style=3D"caret-color: rgb(0, 0, 0); font-family: =
Helvetica; font-size: 18px; font-style: normal; font-variant-caps: =
normal; font-weight: 400; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: =
none;" class=3D""><br style=3D"caret-color: rgb(0, 0, 0); font-family: =
Helvetica; font-size: 18px; font-style: normal; font-variant-caps: =
normal; font-weight: 400; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: =
none;" class=3D""><span style=3D"caret-color: rgb(0, 0, 0); font-family: =
Helvetica; font-size: 18px; font-style: normal; font-variant-caps: =
normal; font-weight: 400; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: =
none; float: none; display: inline !important;" class=3D"">Is there =
anything to do with the host influencing the failures to happen, or are =
you contriving the failures to find the bugs?</span><br =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
18px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none;" class=3D""><br =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
18px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none;" class=3D""><span =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
18px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none; float: none; =
display: inline !important;" class=3D"">I know we've had some reports =
about resource tracking warnings on the reset flows, but I haven't heard =
much about suspend/resume.</span><br style=3D"caret-color: rgb(0, 0, 0); =
font-family: Helvetica; font-size: 18px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none;" class=3D""></div></blockquote><div>We are =
investigating to develop some advanced product features based on amdgpu =
suspend/resume.</div><div>So we started by tested the suspend/resume =
functionality of AMD 308x GPUs with the following simple =
script:</div><div>```</div><div><div style=3D"margin: 0px; font-stretch: =
normal; font-size: 24px; line-height: normal; font-family: Menlo;" =
class=3D""><span style=3D"font-variant-ligatures: no-common-ligatures; =
color: #c1651c" class=3D"">echo</span><span =
style=3D"font-variant-ligatures: no-common-ligatures; color: #b42419" =
class=3D""> platform </span><span style=3D"font-variant-ligatures: =
no-common-ligatures; color: #c1651c" class=3D"">&gt;</span><span =
style=3D"font-variant-ligatures: no-common-ligatures" class=3D""> =
/sys/power/pm_test</span></div><div style=3D"margin: 0px; font-stretch: =
normal; font-size: 24px; line-height: normal; font-family: Menlo;" =
class=3D""><span style=3D"font-variant-ligatures: no-common-ligatures; =
color: #2eaebb" class=3D"">i</span><span style=3D"font-variant-ligatures: =
no-common-ligatures" class=3D"">=3D</span><span =
style=3D"font-variant-ligatures: no-common-ligatures; color: #b42419" =
class=3D"">0</span></div><div style=3D"margin: 0px; font-stretch: =
normal; font-size: 24px; line-height: normal; font-family: Menlo; color: =
rgb(193, 101, 28);" class=3D""><span style=3D"font-variant-ligatures: =
no-common-ligatures" class=3D"">while true; do</span></div><div =
style=3D"margin: 0px; font-stretch: normal; font-size: 24px; =
line-height: normal; font-family: Menlo;" class=3D""><span =
style=3D"font-variant-ligatures: no-common-ligatures" class=3D"">&nbsp; =
&nbsp; &nbsp; &nbsp; </span><span style=3D"font-variant-ligatures: =
no-common-ligatures; color: #c1651c" class=3D"">echo</span><span =
style=3D"font-variant-ligatures: no-common-ligatures; color: #b42419" =
class=3D""> mem </span><span style=3D"font-variant-ligatures: =
no-common-ligatures; color: #c1651c" class=3D"">&gt;</span><span =
style=3D"font-variant-ligatures: no-common-ligatures" class=3D""> =
/sys/power/state</span></div><div style=3D"margin: 0px; font-stretch: =
normal; font-size: 24px; line-height: normal; font-family: Menlo;" =
class=3D""><span style=3D"font-variant-ligatures: no-common-ligatures" =
class=3D"">&nbsp; &nbsp; &nbsp; &nbsp; </span><span =
style=3D"font-variant-ligatures: no-common-ligatures; color: #c1651c" =
class=3D"">let</span><span style=3D"font-variant-ligatures: =
no-common-ligatures" class=3D""> </span><span =
style=3D"font-variant-ligatures: no-common-ligatures; color: #2eaebb" =
class=3D"">i</span><span style=3D"font-variant-ligatures: =
no-common-ligatures" class=3D"">=3Di+</span><span =
style=3D"font-variant-ligatures: no-common-ligatures; color: #b42419" =
class=3D"">1</span></div><div style=3D"margin: 0px; font-stretch: =
normal; font-size: 24px; line-height: normal; font-family: Menlo;" =
class=3D""><span style=3D"font-variant-ligatures: no-common-ligatures" =
class=3D"">&nbsp; &nbsp; &nbsp; &nbsp; </span><span =
style=3D"font-variant-ligatures: no-common-ligatures; color: #c1651c" =
class=3D"">echo</span><span style=3D"font-variant-ligatures: =
no-common-ligatures; color: #b42419" class=3D""> </span><span =
style=3D"font-variant-ligatures: no-common-ligatures; color: #c814c9" =
class=3D"">$i</span></div><div style=3D"margin: 0px; font-stretch: =
normal; font-size: 24px; line-height: normal; font-family: Menlo;" =
class=3D""><span style=3D"font-variant-ligatures: no-common-ligatures" =
class=3D"">&nbsp; &nbsp; &nbsp; &nbsp; </span><span =
style=3D"font-variant-ligatures: no-common-ligatures; color: #c1651c" =
class=3D"">sleep</span><span style=3D"font-variant-ligatures: =
no-common-ligatures" class=3D""> </span><span =
style=3D"font-variant-ligatures: no-common-ligatures; color: #b42419" =
class=3D"">1</span></div><div style=3D"margin: 0px; font-stretch: =
normal; font-size: 24px; line-height: normal; font-family: Menlo; color: =
rgb(193, 101, 28);" class=3D""><span style=3D"font-variant-ligatures: =
no-common-ligatures" class=3D"">done</span></div><div class=3D""><span =
style=3D"font-variant-ligatures: no-common-ligatures" =
class=3D"">```</span></div><div class=3D""><span =
style=3D"font-variant-ligatures: no-common-ligatures" class=3D""><br =
class=3D""></span></div><div class=3D"">It succeeds with the first and =
second iteration but always fails on following iterations on a bare =
metal servers with eight MI308X GPUs.</div><div class=3D"">With some =
investigation we found that the gpu asic should be reset during the =
test, so we submitted a patch to fix the failure (<a =
href=3D"https://github.com/ROCm/ROCK-Kernel-Driver/pull/181" =
class=3D"">https://github.com/ROCm/ROCK-Kernel-Driver/pull/181</a>)</div><=
div class=3D""><br class=3D""></div><div class=3D"">During analyze and =
root-cause the failure, we have encountered several crashes, resource =
leakages and false alarms.</div><div class=3D"">So I have worked out =
patch sets to solve issues we encountered. The other patch set is <a =
href=3D"https://lists.freedesktop.org/archives/amd-gfx/2025-January/118484=
.html" =
class=3D"">https://lists.freedesktop.org/archives/amd-gfx/2025-January/118=
484.html</a></div><div class=3D""><br class=3D""></div><div =
class=3D"">With sriov in single VF mode, resume always fails. Seems some =
contexts/vram buffers get lost during suspend and haven=E2=80=99t be =
restored on resume, so cause failure.</div><div class=3D"">We haven=E2=80=99=
t tested sriov in multiple VFs mode yet. We need more help from AMD side =
to make SR work for SRIOV:) &nbsp;</div></div><br class=3D""><blockquote =
type=3D"cite" class=3D""><div class=3D""><br style=3D"caret-color: =
rgb(0, 0, 0); font-family: Helvetica; font-size: 18px; font-style: =
normal; font-variant-caps: normal; font-weight: 400; letter-spacing: =
normal; text-align: start; text-indent: 0px; text-transform: none; =
white-space: normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none;" class=3D""><blockquote type=3D"cite" =
style=3D"font-family: Helvetica; font-size: 18px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
orphans: auto; text-align: start; text-indent: 0px; text-transform: =
none; white-space: normal; widows: auto; word-spacing: 0px; =
-webkit-text-size-adjust: auto; -webkit-text-stroke-width: 0px; =
text-decoration: none;" class=3D"">We have tried to solve these issues =
case by case, but found that may<br class=3D"">not be the right way. =
Especially about the unbalanced irq reference<br class=3D"">count, there =
will be new issues appear once we fixed the current known<br =
class=3D"">issues. After analyzing related source code, we found that =
there may be<br class=3D"">some fundamental implementaion flaws behind =
these resource tracking<br class=3D""></blockquote><br =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
18px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none;" class=3D""><span =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
18px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none; float: none; =
display: inline !important;" class=3D"">implementation</span><br =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
18px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none;" class=3D""><br =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
18px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none;" =
class=3D""><blockquote type=3D"cite" style=3D"font-family: Helvetica; =
font-size: 18px; font-style: normal; font-variant-caps: normal; =
font-weight: 400; letter-spacing: normal; orphans: auto; text-align: =
start; text-indent: 0px; text-transform: none; white-space: normal; =
widows: auto; word-spacing: 0px; -webkit-text-size-adjust: auto; =
-webkit-text-stroke-width: 0px; text-decoration: none;" =
class=3D"">issues.<br class=3D"">The amdgpu driver has two major state =
machines to driver the device<br class=3D"">management flow, one is for =
ip blocks, the other is for ras blocks.<br class=3D"">The hook points =
defined in struct amd_ip_funcs for device setup/teardown<br class=3D"">are=
 symmetric, but the implementation is asymmetric, sometime even<br =
class=3D"">ambiguous. The most obvious two issues we noticed are:<br =
class=3D"">1) amdgpu_irq_get() are called from .late_init() but =
amdgpu_irq_put()<br class=3D"">&nbsp;&nbsp;&nbsp;are called from =
.hw_fini() instead of .early_fini().<br class=3D"">2) the way to reset =
ip_bloc.status.valid/sw/hw/late_initialized doesn't<br =
class=3D"">&nbsp;&nbsp;&nbsp;match the way to set those flags.<br =
class=3D"">When taking device suspend/resume into account, in addition =
to device<br class=3D"">probe/remove, things get much more complex. Some =
issues arise because<br class=3D"">many suspend/resume implementations =
directly reuse .hw_init/.hw_fini/<br class=3D"">.late_init hook =
points.<br class=3D""><br class=3D"">So we try to fix those issues by =
two enhancements/refinements to current<br class=3D"">device management =
state machines.<br class=3D"">The first change is to make the ip block =
state machine and associated<br class=3D"">status flags work in =
stack-like way as below:<br class=3D"">Callback =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Status Flags<br =
class=3D"">early_init: &nbsp;&nbsp;&nbsp;&nbsp;valid =3D true<br =
class=3D"">sw_init: &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;sw =3D =
true<br class=3D"">hw_init: &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;hw =
=3D true<br class=3D"">late_init: =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;late_initialized =3D true<br =
class=3D"">early_fini: &nbsp;&nbsp;&nbsp;&nbsp;late_initialized =3D =
false<br class=3D"">hw_fini: =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;hw =3D false<br =
class=3D"">sw_fini: &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;sw =3D =
false<br class=3D"">late_fini: &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;valid =3D =
false<br class=3D""></blockquote><br style=3D"caret-color: rgb(0, 0, 0); =
font-family: Helvetica; font-size: 18px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none;" class=3D""><span style=3D"caret-color: rgb(0, 0, =
0); font-family: Helvetica; font-size: 18px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none; float: none; display: inline !important;" =
class=3D"">At a high level this makes sense to me, but I'd just call =
'late' or 'late_init'.</span><br style=3D"caret-color: rgb(0, 0, 0); =
font-family: Helvetica; font-size: 18px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none;" class=3D""><br style=3D"caret-color: rgb(0, 0, =
0); font-family: Helvetica; font-size: 18px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none;" class=3D""><span style=3D"caret-color: rgb(0, 0, =
0); font-family: Helvetica; font-size: 18px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none; float: none; display: inline !important;" =
class=3D"">Another idea if you make it stack like is to do it as a true =
enum for the state machine and store it all in one variable.</span><br =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
18px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none;" =
class=3D""></div></blockquote><div>I will add a patch to convert those =
bool flags into an enum.</div><div>Thanks,</div><div>Gerry</div><br =
class=3D""><blockquote type=3D"cite" class=3D""><div class=3D""><br =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
18px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none;" =
class=3D""><blockquote type=3D"cite" style=3D"font-family: Helvetica; =
font-size: 18px; font-style: normal; font-variant-caps: normal; =
font-weight: 400; letter-spacing: normal; orphans: auto; text-align: =
start; text-indent: 0px; text-transform: none; white-space: normal; =
widows: auto; word-spacing: 0px; -webkit-text-size-adjust: auto; =
-webkit-text-stroke-width: 0px; text-decoration: none;" class=3D"">Also =
do the same thing for ras block state machine, though it's much<br =
class=3D"">more simpler.<br class=3D"">The second change is fine tune =
the overall device management work<br class=3D"">flow as below:<br =
class=3D"">1. amdgpu_driver_load_kms()<br class=3D""><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>amdgpu_device_init()<br class=3D""><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>amdgpu_device_ip_early_init()<br =
class=3D""><span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>ip_blocks[i].early_init()<br class=3D""><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>ip_blocks[i].status.valid =3D true<br class=3D""><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>amdgpu_device_ip_init()<br class=3D""><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>amdgpu_ras_init()<br class=3D""><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>ip_blocks[i].sw_init()<br =
class=3D""><span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>ip_blocks[i].status.sw =3D true<br class=3D""><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>ip_blocks[i].hw_init()<br class=3D""><span class=3D"Apple-tab-span"=
 style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>ip_blocks[i].status.hw =3D =
true<br class=3D""><span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span><span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>amdgpu_device_ip_late_init()<br class=3D""><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>ip_blocks[i].late_init()<br class=3D""><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>ip_blocks[i].status.late_initialized =3D true<br class=3D""><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>amdgpu_ras_late_init()<br class=3D""><span class=3D"Apple-tab-span"=
 style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>ras_blocks[i].ras_late_init()<br =
class=3D""><span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>amdgpu_ras_feature_enable_on_boot()<br class=3D"">2. =
amdgpu_pmops_suspend()/amdgpu_pmops_freeze()/amdgpu_pmops_poweroff()<br =
class=3D""><span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>amdgpu_device_suspend()<br class=3D""><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>amdgpu_ras_early_fini()<br class=3D""><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>ras_blocks[i].ras_early_fini()<br class=3D""><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>amdgpu_ras_feature_disable()<br class=3D""><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>amdgpu_ras_suspend()<br class=3D""><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	=
</span>amdgpu_ras_disable_all_features()<br class=3D"">+++<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>ip_blocks[i].early_fini()<br class=3D"">+++<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>ip_blocks[i].status.late_initialized =3D false<br class=3D""><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>ip_blocks[i].suspend()<br class=3D"">3. =
amdgpu_pmops_resume()/amdgpu_pmops_thaw()/amdgpu_pmops_restore()<br =
class=3D""><span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>amdgpu_device_resume()<br class=3D""><span class=3D"Apple-tab-span"=
 style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>amdgpu_device_ip_resume()<br =
class=3D""><span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>ip_blocks[i].resume()<br class=3D""><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>amdgpu_device_ip_late_init()<br =
class=3D""><span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>ip_blocks[i].late_init()<br class=3D""><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>ip_blocks[i].status.late_initialized =3D true<br class=3D""><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>amdgpu_ras_late_init()<br class=3D""><span class=3D"Apple-tab-span"=
 style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>ras_blocks[i].ras_late_init()<br =
class=3D""><span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>amdgpu_ras_feature_enable_on_boot()<br class=3D""><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>amdgpu_ras_resume()<br class=3D""><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	=
</span>amdgpu_ras_enable_all_features()<br class=3D"">4. =
amdgpu_driver_unload_kms()<br class=3D""><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>amdgpu_device_fini_hw()<br =
class=3D""><span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>amdgpu_ras_early_fini()<br class=3D""><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>ras_blocks[i].ras_early_fini()<br class=3D"">+++<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>ip_blocks[i].early_fini()<br class=3D"">+++<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>ip_blocks[i].status.late_initialized =3D false<br class=3D""><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>ip_blocks[i].hw_fini()<br class=3D""><span class=3D"Apple-tab-span"=
 style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>ip_blocks[i].status.hw =3D =
false<br class=3D"">5. amdgpu_driver_release_kms()<br class=3D""><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>amdgpu_device_fini_sw()<br class=3D""><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>amdgpu_device_ip_fini()<br class=3D""><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>ip_blocks[i].sw_fini()<br class=3D""><span class=3D"Apple-tab-span"=
 style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>ip_blocks[i].status.sw =3D =
false<br class=3D"">---<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>ip_blocks[i].status.valid =3D =
false<br class=3D"">+++<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>amdgpu_ras_fini()<br =
class=3D""><span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>ip_blocks[i].late_fini()<br class=3D"">+++<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>ip_blocks[i].status.valid =3D false<br class=3D"">---<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>ip_blocks[i].status.late_initialized =3D false<br =
class=3D"">---<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span><span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span><span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>amdgpu_ras_fini()<br class=3D"">The main changes =
include:<br class=3D"">1) invoke ip_blocks[i].early_fini in =
amdgpu_pmops_suspend().<br class=3D"">&nbsp;&nbsp;&nbsp;Currently =
there's only one ip block which provides `early_fini`<br =
class=3D"">&nbsp;&nbsp;&nbsp;callback. We have add a check of `in_s3` to =
keep current behavior in<br class=3D"">&nbsp;&nbsp;&nbsp;function =
amdgpu_dm_early_fini(). So there should be no functional<br =
class=3D"">&nbsp;&nbsp;&nbsp;changes.<br class=3D"">2) set =
ip_blocks[i].status.late_initialized to false after calling<br =
class=3D"">&nbsp;&nbsp;&nbsp;callback `early_fini`. We have auditted all =
usages of the<br class=3D"">&nbsp;&nbsp;&nbsp;late_initialized flag and =
no functional changes found.<br class=3D"">3) only set =
ip_blocks[i].status.valid =3D false after calling the<br =
class=3D"">&nbsp;&nbsp;&nbsp;`late_fini` callback.<br class=3D"">4) call =
amdgpu_ras_fini() before invoking ip_blocks[i].late_fini.<br =
class=3D"">Then we try to refine each subsystem, such as nbio, asic, =
gfx, gmc,<br class=3D"">ras etc, to follow the new design. Currently we =
have only taken the<br class=3D"">nbio and asic as examples to show the =
proposed changes. Once we have<br class=3D"">confirmed that's the right =
way to go, we will handle the lefting<br class=3D"">subsystems.<br =
class=3D"">This is in early stage and requesting for comments, any =
comments and<br class=3D"">suggestions are welcomed!<br class=3D"">Jiang =
Liu (13):<br class=3D"">&nbsp;&nbsp;amdgpu: wrong array index to get ip =
block for PSP<br class=3D"">&nbsp;&nbsp;drm/admgpu: add helper functions =
to track status for ras manager<br class=3D"">&nbsp;&nbsp;drm/amdgpu: =
add a flag to track ras debugfs creation status<br =
class=3D"">&nbsp;&nbsp;drm/amdgpu: free all resources on error recovery =
path of<br class=3D"">&nbsp;&nbsp;&nbsp;&nbsp;amdgpu_ras_init()<br =
class=3D"">&nbsp;&nbsp;drm/amdgpu: introduce a flag to track refcount =
held for features<br class=3D"">&nbsp;&nbsp;drm/amdgpu: enhance =
amdgpu_ras_block_late_fini()<br class=3D"">&nbsp;&nbsp;drm/amdgpu: =
enhance amdgpu_ras_pre_fini() to better support SR<br =
class=3D"">&nbsp;&nbsp;drm/admgpu: rename amdgpu_ras_pre_fini() to =
amdgpu_ras_early_fini()<br class=3D"">&nbsp;&nbsp;drm/amdgpu: make IP =
block state machine works in stack like way<br =
class=3D"">&nbsp;&nbsp;drm/admgpu: make device state machine work in =
stack like way<br class=3D"">&nbsp;&nbsp;drm/amdgpu/sdma: improve the =
way to manage irq reference count<br =
class=3D"">&nbsp;&nbsp;drm/amdgpu/nbio: improve the way to manage irq =
reference count<br class=3D"">&nbsp;&nbsp;drm/amdgpu/asic: make ip block =
operations symmetric by .early_fini()<br =
class=3D"">&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu.h =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| &nbsp;40 =
+++++<br class=3D"">&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_device.c =
&nbsp;&nbsp;&nbsp;| &nbsp;37 ++++-<br =
class=3D"">&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| &nbsp;&nbsp;2 +-<br =
class=3D"">&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| &nbsp;&nbsp;2 +-<br =
class=3D"">&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.c =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| &nbsp;16 +-<br =
class=3D"">&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| &nbsp;&nbsp;1 +<br =
class=3D"">&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| &nbsp;&nbsp;8 +-<br =
class=3D"">&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| 144 +++++++++++++-----<br =
class=3D"">&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| &nbsp;16 +-<br =
class=3D"">&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| &nbsp;26 +++-<br =
class=3D"">&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| &nbsp;&nbsp;2 +<br =
class=3D"">&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| &nbsp;&nbsp;2 +-<br =
class=3D"">&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| &nbsp;&nbsp;2 +-<br =
class=3D"">&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| &nbsp;&nbsp;2 +-<br =
class=3D"">&nbsp;drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| &nbsp;&nbsp;2 +-<br =
class=3D"">&nbsp;drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| &nbsp;&nbsp;2 +-<br =
class=3D"">&nbsp;drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| &nbsp;&nbsp;1 +<br =
class=3D"">&nbsp;drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| &nbsp;&nbsp;1 +<br =
class=3D"">&nbsp;drivers/gpu/drm/amd/amdgpu/nv.c =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;| &nbsp;14 +-<br =
class=3D"">&nbsp;drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| &nbsp;&nbsp;8 -<br =
class=3D"">&nbsp;drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| &nbsp;23 +--<br =
class=3D"">&nbsp;drivers/gpu/drm/amd/amdgpu/soc15.c =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| =
&nbsp;38 ++---<br class=3D"">&nbsp;drivers/gpu/drm/amd/amdgpu/soc21.c =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| =
&nbsp;35 +++--<br class=3D"">&nbsp;drivers/gpu/drm/amd/amdgpu/soc24.c =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| =
&nbsp;17 ++-<br =
class=3D"">&nbsp;.../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | =
&nbsp;&nbsp;3 +<br class=3D"">&nbsp;25 files changed, 326 insertions(+), =
118 deletions(-)</blockquote></div></blockquote></div><br =
class=3D""></body></html>=

--Apple-Mail=_EDF93A91-C2F0-472C-839F-0316D67A3F6E--
