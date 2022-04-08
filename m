Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7603C433EF
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Apr 2022 13:50:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EAEDF10F224;
	Fri,  8 Apr 2022 13:50:31 +0000 (UTC)
Received: from ipmail04.adl3.internode.on.net (ipmail04.adl3.internode.on.net
 [150.101.137.10])
 by gabe.freedesktop.org (Postfix) with ESMTP id BF06C10F201
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Apr 2022 13:48:10 +0000 (UTC)
X-SMTP-MATCH: 1
IronPort-Data: =?us-ascii?q?A9a23=3AiA4fLqnUQ3IoUW790bltHVzo5gzKJ0RdPkR7X?=
 =?us-ascii?q?Q2eYbSJt1+Wr1GztxIdUD/TMvvfYjahf9p3aYTk8UJV6pPWy4RqHQo/qCo3R?=
 =?us-ascii?q?H8R8ZGZCI/IchuhZSnJIMObEhtr5J8SMIKQIJprEHPRjxr8abKJQVtUjPHQH?=
 =?us-ascii?q?OCgYALn1oGdfeLXIcsYoUoLd9MR2+aEv/DpW2thhvuqyyHvEAfNNw9cagr42?=
 =?us-ascii?q?YrawP9clKyaVAcjg7ALTasjUGkyNpUiJMl3yamZdxMUS2TPdwKwb76rILqRp?=
 =?us-ascii?q?gs18/qxY+5JnIoXcmVSKlLTFTvX0CUQA+76xEF3zsAw+v99baBALx4J03PQz?=
 =?us-ascii?q?o4ZJNZl7PRcTS8gJLHMhf5bVhBCCCFWPKta9aXBJnSy98uViUvLbxMAxt00U?=
 =?us-ascii?q?h5sY9FEob4f7WZmr6dGcFjhdCurqvy/xvSCV+Bqrs0mII/gO4Z3klhkwCHQC?=
 =?us-ascii?q?/orW9bvTrjB5dJC9D41ioZFGvO2T+EZczt0cBXJZVtsPVoRCZ0WleKkwHL4d?=
 =?us-ascii?q?lVwi1+To6cr4y79wQp++LHoPJzefdnibeFUnEHegmvU9n7RCxQWcteYzFKt+?=
 =?us-ascii?q?3egw+DBjQv/WZkOD/u27PNnjFCIxXAUEFsRT1TTnBUTolrmDpcGcwpM7nN79?=
 =?us-ascii?q?e5q4Bb+Fp+sAEbjtCXR5lhBT4UFK+c+/FjVn/KQuxLx6nMsF3gYMoBg7ZFuA?=
 =?us-ascii?q?2V7iDe0cxrSLWQHmNWopbi1pt94dQ+PBBU=3D?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3ALzsXIavbolHQnYhBDKeZrJL17skDetV00z?=
 =?us-ascii?q?EX/kB9WHVpmszxrayTdZMgpHvJYVcqKRQdcL+7U5VoLUm3yXcx2+gs1NSZLW?=
 =?us-ascii?q?vbUQmTXeJfBOLZqlXd8m/FltK1vp0OT0ERMrDN5BRB4/rH3A=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2BVAACRPFBiAMSgfAENTRsBAQEBAQE?=
 =?us-ascii?q?BAQUBAQESAQEBAwMBAQFACYFRhHuEVYJgjjkDnmYLAT0XBAEBhQcChHAmOBM?=
 =?us-ascii?q?BAgQVAQEGAQEBAQEHBBABOVKMNwEBAQEDASIEUgwECw0EBAEBAQICJgICKCc?=
 =?us-ascii?q?IBg4FgwSxRXp/MhpniBeBZYEQLIFmiFaEEzeBVUSBFScPDXmBbj6ECRoBAYM?=
 =?us-ascii?q?6N4IuBJobJRIHJgKBaQQENAyTXYMljQKdcTQHg0yBPAYMlkKHdC6DdIw5hkM?=
 =?us-ascii?q?Di3qFZC2WMaFRhziBfjMaLm8Bgj5Rf41VFo4+ZQI2AgYLAQEDCY5jAQE?=
Received: from unknown (HELO [127.0.0.1]) ([1.124.160.196])
 by ipmail04.adl3.internode.on.net with ESMTP; 08 Apr 2022 23:18:06 +0930
Date: Fri, 08 Apr 2022 23:17:55 +0930
From: Arthur Marsh <arthur.marsh@internode.on.net>
To: "Quan, Evan" <Evan.Quan@amd.com>
Subject: =?US-ASCII?Q?RE=3A_=5BPATCH_V4_17/17=5D_drm/amd/pm=3A_uni?=
 =?US-ASCII?Q?fied_lock_protections_in_amdgpu=5Fdpm=2Ec?=
User-Agent: K-9 Mail for Android
In-Reply-To: <DM6PR12MB2619529F8A58B49D2244745EE4E99@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <BYAPR12MB2615608D66B2894697D8C5FEE4E09@BYAPR12MB2615.namprd12.prod.outlook.com>
 <20220401121847.5754-1-amarsh04@internode.on.net>
 <DM6PR12MB261926C1A94C438BA37815DEE4E39@DM6PR12MB2619.namprd12.prod.outlook.com>
 <DM6PR12MB2619529F8A58B49D2244745EE4E99@DM6PR12MB2619.namprd12.prod.outlook.com>
Message-ID: <2816B6AE-0C5D-4FF1-A5A3-BED5D5B11BC5@internode.on.net>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Fri, 08 Apr 2022 13:50:30 +0000
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Lazar,
 Lijo" <Lijo.Lazar@amd.com>, "Feng, Kenneth" <Kenneth.Feng@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Thanks Evan, your patch applied to Linus' origin/master source worked for m=
e running amdgpu module with a Radeon SI (Cape Verde) GPU card=2E

Regards,

Arthur Marsh=2E=20

On 8 April 2022 9:54:57 pm ACST, "Quan, Evan" <Evan=2EQuan@amd=2Ecom> wrot=
e:
>[AMD Official Use Only]
>
>Hi Arthur,
>
>Please give the attached patch a try and let me know the result=2E
>
>Thanks,
>Evan
>> -----Original Message-----
>> From: Quan, Evan
>> Sent: Saturday, April 2, 2022 9:32 AM
>> To: 'Arthur Marsh' <arthur=2Emarsh@internode=2Eon=2Enet>
>> Cc: Deucher, Alexander <Alexander=2EDeucher@amd=2Ecom>; Koenig, Christi=
an
>> <Christian=2EKoenig@amd=2Ecom>; Feng, Kenneth <Kenneth=2EFeng@amd=2Ecom=
>;
>> Lazar, Lijo <Lijo=2ELazar@amd=2Ecom>; amd-gfx@lists=2Efreedesktop=2Eorg
>> Subject: RE: [PATCH V4 17/17] drm/amd/pm: unified lock protections in
>> amdgpu_dpm=2Ec
>>=20
>> [AMD Official Use Only]
>>=20
>> Thanks for the confirming=2E I probably know the root cause=2E
>> Let me prepare an official patch for you=2E
>>=20
>> BR
>> Evan
>> > -----Original Message-----
>> > From: Arthur Marsh <arthur=2Emarsh@internode=2Eon=2Enet>
>> > Sent: Friday, April 1, 2022 8:19 PM
>> > To: Quan, Evan <Evan=2EQuan@amd=2Ecom>
>> > Cc: Deucher, Alexander <Alexander=2EDeucher@amd=2Ecom>; Koenig,
>> Christian
>> > <Christian=2EKoenig@amd=2Ecom>; Feng, Kenneth <Kenneth=2EFeng@amd=2Ec=
om>;
>> > Lazar, Lijo <Lijo=2ELazar@amd=2Ecom>; amd-gfx@lists=2Efreedesktop=2Eo=
rg;
>> > arthur=2Emarsh@internode=2Eon=2Enet
>> > Subject: [PATCH V4 17/17] drm/amd/pm: unified lock protections in
>> > amdgpu_dpm=2Ec
>> >
>> > Hi, short answer is that with both patches applied, I am successfully
>> > running the amdgpu kernel module on radeonsi (plasma desktop on X=2Eo=
rg)=2E
>> >
>> > I confirmed that CONFIG_LOCKDEP_SUPPORT=3Dy is enabled in the kernel=
=2E
>> >
>> > With the first patch applied and remotely connecting to the machine
>> > and loading amdgpu via:
>> >
>> > modprobe amdgpu si_support=3D1 gpu_recovery=3D1
>> >
>> > the last lines of dmesg were:
>> >
>> > [  264=2E095969] [drm] Found UVD firmware Version: 64=2E0 Family ID: =
13 [
>> > 264=2E097779] [drm] PCIE gen 2 link speeds already enabled [
>> > 264=2E648137] [drm] UVD initialized successfully=2E
>> > [  264=2E648696] amdgpu 0000:01:00=2E0: amdgpu: SE 1, SH per SE 2, CU=
 per
>> > SH 5, active_cu_number 8 [  264=2E984814] [drm] Initialized amdgpu
>> > 3=2E46=2E0 20150101 for 0000:01:00=2E0 on minor 0 [  265=2E040280] fb=
con:
>> > amdgpudrmfb (fb0) is primary device
>> >
>> > After applying the second patch and building and restarting with the
>> > new kernel, I could load amdgpu successfuly and start the plasma
>> > desktop under X=2Eorg, with the last amdgpu load lines being:
>> >
>> > [  227=2E736281] fbcon: amdgpudrmfb (fb0) is primary device [
>> > 227=2E760719] Console: switching to colour frame buffer device 240x67=
 [
>> > 227=2E765024] amdgpu 0000:01:00=2E0: [drm] fb0: amdgpudrmfb frame buf=
fer
>> > device
>> >
>> > I tried building a kernel with just the second patch and that
>> > experienced a lockup after apparently loading amdgpu alright=2E
>> >
>> > First and second patches combined:
>> >
>> > diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm=2Ec
>> > b/drivers/gpu/drm/amd/pm/amdgpu_dpm=2Ec
>> > index 89fbee568be4=2E=2Ee9ebbc9f4cd2 100644
>> > --- a/drivers/gpu/drm/amd/pm/amdgpu_dpm=2Ec
>> > +++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm=2Ec
>> > @@ -80,8 +80,6 @@ int amdgpu_dpm_set_powergating_by_smu(struct
>> > amdgpu_device *adev, uint32_t block
>> >  		return 0;
>> >  	}
>> >
>> > -	mutex_lock(&adev->pm=2Emutex);
>> > -
>> >  	switch (block_type) {
>> >  	case AMD_IP_BLOCK_TYPE_UVD:
>> >  	case AMD_IP_BLOCK_TYPE_VCE:
>> > @@ -102,8 +100,6 @@ int amdgpu_dpm_set_powergating_by_smu(struct
>> > amdgpu_device *adev, uint32_t block
>> >  	if (!ret)
>> >  		atomic_set(&adev->pm=2Epwr_state[block_type], pwr_state);
>> >
>> > -	mutex_unlock(&adev->pm=2Emutex);
>> > -
>> >  	return ret;
>> >  }
>> >
>> > @@ -423,9 +419,7 @@ void amdgpu_dpm_compute_clocks(struct
>> > amdgpu_device *adev)
>> >  	if (!pp_funcs->pm_compute_clocks)
>> >  		return;
>> >
>> > -	mutex_lock(&adev->pm=2Emutex);
>> >  	pp_funcs->pm_compute_clocks(adev->powerplay=2Epp_handle);
>> > -	mutex_unlock(&adev->pm=2Emutex);
>> >  }
>> >
>> >  void amdgpu_dpm_enable_uvd(struct amdgpu_device *adev, bool
>> enable)
>> >
>> > Thanks for the assistance!
>> >
>> > Arthur=2E

--=20
Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E
