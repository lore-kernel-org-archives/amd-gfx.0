Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D6C6E77188
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Jan 2025 01:20:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A01D910E073;
	Mon, 13 Jan 2025 01:20:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="gDKKDrsl";
	dkim-atps=neutral
Received: from out30-98.freemail.mail.aliyun.com
 (out30-98.freemail.mail.aliyun.com [115.124.30.98])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9436E10E073
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Jan 2025 01:20:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1736731200; h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To;
 bh=ECHL4Tw4kFRpv0QQsI7s42VneduoDPcXRBrVQoLuUFA=;
 b=gDKKDrslPnrrz80ZX1HuYqw7FpKuIww9XbNd8o3nU2pW3kR5eQnE5gP8vhFzBq+l6+UQ/i/+xcsIgVlNuP16NB3uMdtcMtXQ524pXd+8F/UVukTMMqPBNjEFbgnwk7YKQVLGrcTuD7p0fs/q0eawyoMnUCOsd2fTL1+T65n7j8k=
Received: from smtpclient.apple(mailfrom:gerry@linux.alibaba.com
 fp:SMTPD_---0WNRxpXl_1736731197 cluster:ay36) by smtp.aliyun-inc.com;
 Mon, 13 Jan 2025 09:19:59 +0800
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.1\))
Subject: Re: 
From: Gerry Liu <gerry@linux.alibaba.com>
In-Reply-To: <512c6943-57a7-4cc5-98cc-5400a5113b58@amd.com>
Date: Mon, 13 Jan 2025 09:19:57 +0800
Cc: alexander.deucher@amd.com, christian.koenig@amd.com, Xinhui.Pan@amd.com,
 airlied@gmail.com, simona@ffwll.ch, sunil.khatri@amd.com,
 "Lazar, Lijo" <lijo.lazar@amd.com>, Hawking.Zhang@amd.com,
 "Chen, Xiaogang" <xiaogang.chen@amd.com>, Kent.Russell@amd.com,
 Shuo Liu <shuox.liu@linux.alibaba.com>, amd-gfx@lists.freedesktop.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <883EFB5E-1140-4757-969B-C2A8E4842E22@linux.alibaba.com>
References: <cover.1736344725.git.gerry@linux.alibaba.com>
 <37c31a32-c5fb-4a5b-8aad-448997f94cda@amd.com>
 <A6A619E6-08E4-4A60-951B-26F2BF4F93E4@linux.alibaba.com>
 <512c6943-57a7-4cc5-98cc-5400a5113b58@amd.com>
To: Mario Limonciello <mario.limonciello@amd.com>
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



> 2025=E5=B9=B41=E6=9C=8810=E6=97=A5 01:10=EF=BC=8CMario Limonciello =
<mario.limonciello@amd.com> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> General note - don't use HTML for mailing list communication.
>=20
> I'm not sure if Apple Mail lets you switch this around.
>=20
> If not, you might try using Thunderbird instead.  You can pick to =
reply in plain text or HTML by holding shift when you hit "reply all"
>=20
> For my reply I'll convert my reply to plain text, please see inline =
below.
>=20
> On 1/8/2025 23:34, Gerry Liu wrote:
>>> 2025=E5=B9=B41=E6=9C=889=E6=97=A5 00:33=EF=BC=8CMario Limonciello =
<mario.limonciello@amd.com <mailto:mario.limonciello@amd.com>> =E5=86=99=E9=
=81=93=EF=BC=9A
>>>=20
>>> On 1/8/2025 07:59, Jiang Liu wrote:
>>>> Subject: [RFC PATCH 00/13] Enhance device state machine to better =
support suspend/resume
>>>=20
>>> I'm not sure how this happened, but your subject didn't end up in =
the subject of the thread on patch 0 so the thread just looks like an =
unsubjected thread.
>> Maybe it=E2=80=99s caused by one extra blank line at the header.
>=20
> Yeah that might be it.  Hopefully it doesn't happen on v2.
>=20
>>>=20
>>>> Recently we were testing suspend/resume functionality with AMD =
GPUs,
>>>> we have encountered several resource tracking related bugs, such as
>>>> double buffer free, use after free and unbalanced irq reference =
count.
>>>=20
>>> Can you share more aobut how you were hitting these issues?  Are =
they specific to S3 or to s2idle flows?  dGPU or APU?
>>> Are they only with SRIOV?
>>>=20
>>> Is there anything to do with the host influencing the failures to =
happen, or are you contriving the failures to find the bugs?
>>>=20
>>> I know we've had some reports about resource tracking warnings on =
the reset flows, but I haven't heard much about suspend/resume.
>> We are investigating to develop some advanced product features based =
on amdgpu suspend/resume.
>> So we started by tested the suspend/resume functionality of AMD 308x =
GPUs with the following simple script:
>> ```
>> echoplatform >/sys/power/pm_test
>> i=3D0
>> while true; do
>> echomem >/sys/power/state
>> leti=3Di+1
>> echo$i
>> sleep1
>> done
>> ```
>> It succeeds with the first and second iteration but always fails on =
following iterations on a bare metal servers with eight MI308X GPUs.
>=20
> Can you share more about this server?  Does it support suspend to ram =
or a hardware backed suspend to idle?  If you don't know, you can check =
like this:
>=20
> =E2=9D=AF cat /sys/power/mem_sleep
> s2idle [deep]
# cat /sys/power/mem_sleep=20
[s2idle]

>=20
> If it's suspend to idle, what does the FACP indicate?  You can do this =
check to find out if you don't know.
>=20
> =E2=9D=AF sudo cp /sys/firmware/acpi/tables/FACP /tmp
> =E2=9D=AF sudo iasl -d /tmp/FACP
> =E2=9D=AF grep "idle" -i /tmp/FACP.dsl
>                      Low Power S0 Idle (V5) : 0
>=20
With acpidump and `iasl -d facp.data`, we got:
[070h 0112   4]        Flags (decoded below) : 000084A5
      WBINVD instruction is operational (V1) : 1
              WBINVD flushes all caches (V1) : 0
                    All CPUs support C1 (V1) : 1
                  C2 works on MP system (V1) : 0
            Control Method Power Button (V1) : 0
            Control Method Sleep Button (V1) : 1
        RTC wake not in fixed reg space (V1) : 0
            RTC can wake system from S4 (V1) : 1
                        32-bit PM Timer (V1) : 0
                      Docking Supported (V1) : 0
               Reset Register Supported (V2) : 1
                            Sealed Case (V3) : 0
                    Headless - No Video (V3) : 0
        Use native instr after SLP_TYPx (V3) : 0
              PCIEXP_WAK Bits Supported (V4) : 0
                     Use Platform Timer (V4) : 1
               RTC_STS valid on S4 wake (V4) : 0
                Remote Power-on capable (V4) : 0
                 Use APIC Cluster Model (V4) : 0
     Use APIC Physical Destination Mode (V4) : 0
                       Hardware Reduced (V5) : 0
                      Low Power S0 Idle (V5) : 0

>> With some investigation we found that the gpu asic should be reset =
during the test,=20
>=20
> Yeah; but this comes back to my above questions.  Typically there is =
an assumption that the power rails are going to be cut in system =
suspend.
>=20
> If that doesn't hold true, then you're doing a pure software suspend =
and have found a series of issues in the driver with how that's handled.
Yeah, we are trying to do a `pure software suspend`, letting hypervisor =
to save/restore system images instead of guest OS.
And during the suspend process, we hope we can cancel the suspend =
request at any later stage.
We cancel suspend at late stages, it does behave like a pure software =
suspend.

>=20
>> so we submitted a patch to fix the failure (https:// =
github.com/ROCm/ROCK-Kernel-Driver/pull/181 <https://github.com/ROCm/ =
ROCK-Kernel-Driver/pull/181>)
>=20
> Typically kernel patches don't go through that repo, they're discussed =
on the mailing lists. Can you bring this patch for discussion on =
amd-gfx?
Will post to amd-gfx after solving the conflicts.

Regards,
Gerry

>=20
>> During analyze and root-cause the failure, we have encountered =
several crashes, resource leakages and false alarms.
>=20
> Yeah; I think you found some real issues.
>=20
>> So I have worked out patch sets to solve issues we encountered. The =
other patch set is https://lists.freedesktop.org/archives/amd-gfx/2025- =
January/118484.html <https://lists.freedesktop.org/archives/amd- =
gfx/2025-January/118484.html>
>=20
> Thanks!
>=20
>> With sriov in single VF mode, resume always fails. Seems some =
contexts/ vram buffers get lost during suspend and haven=E2=80=99t be =
restored on resume, so cause failure.
>> We haven=E2=80=99t tested sriov in multiple VFs mode yet. We need =
more help from AMD side to make SR work for SRIOV:)
>>>=20
>>>> We have tried to solve these issues case by case, but found that =
may
>>>> not be the right way. Especially about the unbalanced irq reference
>>>> count, there will be new issues appear once we fixed the current =
known
>>>> issues. After analyzing related source code, we found that there =
may be
>>>> some fundamental implementaion flaws behind these resource tracking
>>>=20
>>> implementation
>>>=20
>>>> issues.
>>>> The amdgpu driver has two major state machines to driver the device
>>>> management flow, one is for ip blocks, the other is for ras blocks.
>>>> The hook points defined in struct amd_ip_funcs for device =
setup/teardown
>>>> are symmetric, but the implementation is asymmetric, sometime even
>>>> ambiguous. The most obvious two issues we noticed are:
>>>> 1) amdgpu_irq_get() are called from .late_init() but =
amdgpu_irq_put()
>>>>    are called from .hw_fini() instead of .early_fini().
>>>> 2) the way to reset ip_bloc.status.valid/sw/hw/late_initialized =
doesn't
>>>>    match the way to set those flags.
>>>> When taking device suspend/resume into account, in addition to =
device
>>>> probe/remove, things get much more complex. Some issues arise =
because
>>>> many suspend/resume implementations directly reuse =
.hw_init/.hw_fini/
>>>> .late_init hook points.
>>>>=20
>>>> So we try to fix those issues by two enhancements/refinements to =
current
>>>> device management state machines.
>>>> The first change is to make the ip block state machine and =
associated
>>>> status flags work in stack-like way as below:
>>>> Callback        Status Flags
>>>> early_init:     valid =3D true
>>>> sw_init:        sw =3D true
>>>> hw_init:        hw =3D true
>>>> late_init:      late_initialized =3D true
>>>> early_fini:     late_initialized =3D false
>>>> hw_fini:        hw =3D false
>>>> sw_fini:        sw =3D false
>>>> late_fini:      valid =3D false
>>>=20
>>> At a high level this makes sense to me, but I'd just call 'late' or =
'late_init'.
>>>=20
>>> Another idea if you make it stack like is to do it as a true enum =
for the state machine and store it all in one variable.
>> I will add a patch to convert those bool flags into an enum.
>=20
> Thanks!

