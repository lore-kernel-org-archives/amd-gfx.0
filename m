Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28314C433EF
	for <amd-gfx@archiver.kernel.org>; Sat,  2 Apr 2022 01:31:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6AB3310E09C;
	Sat,  2 Apr 2022 01:31:38 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2071.outbound.protection.outlook.com [40.107.223.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0158810E09C
 for <amd-gfx@lists.freedesktop.org>; Sat,  2 Apr 2022 01:31:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FMA4XJpxEviuQPWl5vtUcMi1tSxdbBN8n6O+4p1WxfIWXTatc342ZPPd3oUpMvPf71h+M8ZxeSp9VRVHI7A2XLRGEnekME7aQNBUFbSCR5Gb8TQjdUEf9NODeoSB6ylJYmy4EBlcZj7jUWkuQNr256sH6k88BL4686QkjTfX1ckJk8iC+buMa/U3L56vRGS2n3eYmRrdcx7pPI9LxlOet5kAR/mMPB24wRGg8oIPLeH9JTADi4y9IaC3SUKGWm11R7/LZK7cGkzari/M9C74Cx3fegb2TB55SAC07e5mDDK9AOpLKZvtrgkTyqisIGrRm/ZK5eipdggZdOoKmrTm8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5Y8ksSWpuQj6pv8DN1t4CpgvDrd2jAVrss+mqSHXda0=;
 b=eM2LoraKRscA1IQ5BLErMFxQEpYB2ruuutettFWziKf1eZRc7rXUZCXo5UMckiXs+PN7G4tjv6SX/jYAOMtqA1g6McIKROsfouvOoTodsZpbmbJrMz8NsO3UAqq6Sa1eZj6cwvBfZtRdgipwbYJ3Hv824zwnNSdmtQTLuP0yXwoQVuccOe+4nfCUeGeW5DOPCMGFCj3k/qNoS0kucUILv87WryYZw07YJxXlK5IiPijAnbKNcAOal7zqzHo3NXGo9XgTZ/YzGTU8x/cEXaEq1/O1M4CJi54Xd/eUIsDaL6vtvRVvAskWckHvpK4rzx6VP7RVllhq3Dha4kgwPyK/Bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Y8ksSWpuQj6pv8DN1t4CpgvDrd2jAVrss+mqSHXda0=;
 b=khhLxE0O20K0r61ueIGcBx65ugC4vYIKACEpdh2mK53sOdIMtXs0vs8GAnSb0DO2o+jvyj4qceqFdy7W1/ec4me9qtrUNGMtzRg6R2ZpMZJTfO7jrz7yEYs3h7z5zUfG3i5b85/BLV8M6m4v3jgMbPIt3e6qzpJe8tOltePWeIs=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (20.176.117.82) by
 MN2PR12MB4128.namprd12.prod.outlook.com (52.135.51.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5123.26; Sat, 2 Apr 2022 01:31:34 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::bc5c:3ef0:1281:98ba]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::bc5c:3ef0:1281:98ba%3]) with mapi id 15.20.5123.026; Sat, 2 Apr 2022
 01:31:34 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: Arthur Marsh <arthur.marsh@internode.on.net>
Subject: RE: [PATCH V4 17/17] drm/amd/pm: unified lock protections in
 amdgpu_dpm.c
Thread-Topic: [PATCH V4 17/17] drm/amd/pm: unified lock protections in
 amdgpu_dpm.c
Thread-Index: AQHX5/LJ4D+1UL2cPU263eD1r1iEEqzZfgGAgAANK6CAABQxgIABvleAgAAdTQCAAAHRAIAABW2QgAAzIYCAANzAsA==
Date: Sat, 2 Apr 2022 01:31:34 +0000
Message-ID: <DM6PR12MB261926C1A94C438BA37815DEE4E39@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <BYAPR12MB2615608D66B2894697D8C5FEE4E09@BYAPR12MB2615.namprd12.prod.outlook.com>
 <20220401121847.5754-1-amarsh04@internode.on.net>
In-Reply-To: <20220401121847.5754-1-amarsh04@internode.on.net>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-04-02T01:31:31Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=d46372c8-6faa-4e58-9ff3-1962b9e20458;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 42c3ca57-14bb-4d85-d3dc-08da14488627
x-ms-traffictypediagnostic: MN2PR12MB4128:EE_
x-microsoft-antispam-prvs: <MN2PR12MB4128F8A517310403097215D5E4E39@MN2PR12MB4128.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9DGm27Jl7POubLlAwNZBToXnQQeSvrXIKcIbDSU9qqZQD+4Q1Y264AUcP8wqePCLbhyXF9WjMqDtDc6tJW+Ih/9BY+OhVk70PfjgRl0UfLQhklUVx0nLcBZbGPENafarzmC6CNMyqQOU6NGi8KWiY5N7PM59g4jeQ///7xs4G1hSLmYvhijRKhieiz4GCfi4PWBFPwMXXkMpjRGfjiLagDleKPGbYlPiGj/nQevHkgv8+WbrSnQeGlUCsw7wvMXasujMDL7yF6UR6Uymxan/5q7CCz6qF1+RiQvRxBvF5792uAdq45vj13kogLJtYiIS/+qcgNVmkWysO7goudK8F69fDuYvVq6hYEz+OJpf+P930kRpGJorHz0vWqESjh+blTkF/vKV2qlhomiF0aL2XVyYFUEB4Pms3E4zltl8aaNK3VyaVWafjC9fnBwvYkvvBt1Gxn/K0lRfvfZ8+5ILsRZMCv2Pk8ymljNmexvZU4CzhoPSg3E6vL7RvLoiYg1cwzY91FiI+ZvX8FggP5SqiO7nunaBrplD19cD6Y9b4kOaw03OxGm7ruoRYA6mUrqoOkHohp+KYa1OCnt4QcH2oS/CijCGXhyhC2ZQTlCxaF5rpxKhRrq92tOl7KIWagQZ2ic5mJN+Hc3tAXjWqCOvZ2VY2B5ZfHo36QRjeU1xh0SAKf5/YJ92QQd9oM/B1Hcm8dLgOE8Mn+BOOFjUKdjr9A==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(54906003)(6916009)(76116006)(316002)(26005)(8936002)(55016003)(52536014)(508600001)(83380400001)(66476007)(8676002)(4326008)(66556008)(71200400001)(66446008)(64756008)(7696005)(6506007)(66946007)(5660300002)(2906002)(53546011)(38070700005)(86362001)(122000001)(38100700002)(9686003)(186003)(33656002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?3jWtLyXPvY0GuGQlT9eS3lc+h53KlgDo+aYefFQgUJtAAxdu/AaQ7MKSBOAv?=
 =?us-ascii?Q?TgMLJ6fVZE/zGcNVsX004y2HOESvqmW+rzQqJ14o2dgCnLUGGnWJD9HBKsjp?=
 =?us-ascii?Q?E3dkRkZGyegti5v/VGh3GCciyWTHSBQIZh8gbriELG8vhSb7a/mDhx9scwql?=
 =?us-ascii?Q?jgp5gxEYwFJorfT5WbshaY/S+sCouqpv4aFpWXfFjBMjvF5mJc1RxaO7iZUV?=
 =?us-ascii?Q?MC14GbXmQmc7IAfMyWgDp9oU3HQBmklcrLkqZCA2uFOUbOjdKwuUoND4tizF?=
 =?us-ascii?Q?F6WRjXHC+7h+39T2FdD4htKS00DCq9OkweQ+WOszRjv+BQs+MPXWdXf07mNp?=
 =?us-ascii?Q?BGGQ6naDXCFK0Guo583i4Xw8jeswpHiHMzhLzPlkqUkcJMmjIPSA62YpCZV7?=
 =?us-ascii?Q?kqskM7U5i2p+nHoZ/NXkVDnUHpsL5Yi/LumMwhjzXR6/ljjuNlwtIJAZXSMh?=
 =?us-ascii?Q?xkAPpr4LONPPv7I2in/azHKigLVtlghBGdZW9ZpQQMIBZVWN3XQwC7dY3Rr3?=
 =?us-ascii?Q?cRNmxIquYfodQSLDzWEMA1oAh3nwRkFxFK7goXmoP2+x0eihZE42vLVS8Pfx?=
 =?us-ascii?Q?7ur7LGQWJ1iOLA4JIlstrZPfB+Ce7BP43gcw34ywi6lwSflwUmNAaRdLIC10?=
 =?us-ascii?Q?ARtlBkq2s4Spv48EVcsvfn74NyW0NFao1LCJr0z2gPjVdiFOfsgMFgYci8zo?=
 =?us-ascii?Q?4m+qfX7ImEka5pdwfYpmYtkmn6QuyfDfaE8F0geCg/vxw7oY2A4aGUmyRnJX?=
 =?us-ascii?Q?JfLN3XfLmmcrJGxTnuEq9bFdFxB8E/gAtd7xJWLXIgboX6l0fTpvtkx+voNI?=
 =?us-ascii?Q?VlmIJ6zmiyE2r9yuQEnasjYxuPg1PCynwG0D+wtpsjfJskGKIqyJyRe8wZ9L?=
 =?us-ascii?Q?RM/9AkiKVHD+uxPrZFHy3p+sn2QMd19YFKWuQ5LRPiFZVUZ2vsXHZIjPN31C?=
 =?us-ascii?Q?buY5wnCKlXCibAHYQBfzoztliAQh1j9tiOQo0OTR3fF8m5ScIv9Y91iSfkRp?=
 =?us-ascii?Q?1brMk+SvSTRCZgNS7gBDIXzZ4Y3f1GPgIekeeiq4wXLMkzo/tQ6AQ1oGHSbU?=
 =?us-ascii?Q?F8gBZ/SV9JfA0Qf22ZN8xOQBymUsHogu+dYeI3IX4n4Jfh7QSqCoT1AezQnu?=
 =?us-ascii?Q?wmRXRzfcje0K65AZLAqr74YY+tygZW+Wpoi2mXWM/DftD6lmYQFsSjnZXXlR?=
 =?us-ascii?Q?3oMubD4epbLybPD4/VBryJG20MwRIYC0AHESEaS1/7wm214TKIDPXqVZceQ7?=
 =?us-ascii?Q?4d3p2cYWfmeqX/dq+4iTug0e4maDGNZ+zwy4o5wcxKNxm4m4pvoITrDofyg+?=
 =?us-ascii?Q?q+nZFj4Mf+eTNtX6V/ANRUAwEjjbWhYQvC9RRZQAe8fnXyfNnmeL3zi3CPvR?=
 =?us-ascii?Q?/lbFIQKc+GgXYvPFtIe8D3MTTBTQxq1j426jYpsRhQQYbvLsRwv2kCPf0Cvk?=
 =?us-ascii?Q?G0PjaY8IcWPj+rgE5rtBFylu9mMjkfefEz/gd7U0sNuivSLS+H516H9Pn/QD?=
 =?us-ascii?Q?5dns7CTKHpClC7GDMsHsVA0zhyfiIbZNB8WtCz+Fy9oAdwsSL8YsPCmlMIc6?=
 =?us-ascii?Q?7I9vsfKpBMUOWYDoUJt46WD9JZ3PNuyve7Pyg1nEnBCTqJOskbgZhLiuqs8r?=
 =?us-ascii?Q?qUIEKYXOZgKSsqvCOrGk9/pLw8xuV8WKXCO3OHx4nbaazME5z95ENhkSPgjq?=
 =?us-ascii?Q?0XM4MUf6WUyxyzNAzQmqYzVZR6LXFCPRyK/nccB6tZJT8HGf?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42c3ca57-14bb-4d85-d3dc-08da14488627
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Apr 2022 01:31:34.5742 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mpZE8kgjOK0QvDJOKmG3YmZhk1frcBLP+LNunZfmngqPsKmp6cdln2qF7OFTr78Y
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4128
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

[AMD Official Use Only]

Thanks for the confirming. I probably know the root cause.
Let me prepare an official patch for you.

BR
Evan
> -----Original Message-----
> From: Arthur Marsh <arthur.marsh@internode.on.net>
> Sent: Friday, April 1, 2022 8:19 PM
> To: Quan, Evan <Evan.Quan@amd.com>
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
> <Christian.Koenig@amd.com>; Feng, Kenneth <Kenneth.Feng@amd.com>;
> Lazar, Lijo <Lijo.Lazar@amd.com>; amd-gfx@lists.freedesktop.org;
> arthur.marsh@internode.on.net
> Subject: [PATCH V4 17/17] drm/amd/pm: unified lock protections in
> amdgpu_dpm.c
>=20
> Hi, short answer is that with both patches applied, I am successfully run=
ning
> the amdgpu kernel module on radeonsi (plasma desktop on X.org).
>=20
> I confirmed that CONFIG_LOCKDEP_SUPPORT=3Dy is enabled in the kernel.
>=20
> With the first patch applied and remotely connecting to the machine and
> loading amdgpu via:
>=20
> modprobe amdgpu si_support=3D1 gpu_recovery=3D1
>=20
> the last lines of dmesg were:
>=20
> [  264.095969] [drm] Found UVD firmware Version: 64.0 Family ID: 13
> [  264.097779] [drm] PCIE gen 2 link speeds already enabled
> [  264.648137] [drm] UVD initialized successfully.
> [  264.648696] amdgpu 0000:01:00.0: amdgpu: SE 1, SH per SE 2, CU per SH =
5,
> active_cu_number 8
> [  264.984814] [drm] Initialized amdgpu 3.46.0 20150101 for 0000:01:00.0 =
on
> minor 0
> [  265.040280] fbcon: amdgpudrmfb (fb0) is primary device
>=20
> After applying the second patch and building and restarting with the new
> kernel, I could load amdgpu successfuly and start
> the plasma desktop under X.org, with the last amdgpu load lines being:
>=20
> [  227.736281] fbcon: amdgpudrmfb (fb0) is primary device
> [  227.760719] Console: switching to colour frame buffer device 240x67
> [  227.765024] amdgpu 0000:01:00.0: [drm] fb0: amdgpudrmfb frame buffer
> device
>=20
> I tried building a kernel with just the second patch and that experienced
> a lockup after apparently loading amdgpu alright.
>=20
> First and second patches combined:
>=20
> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> index 89fbee568be4..e9ebbc9f4cd2 100644
> --- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> +++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> @@ -80,8 +80,6 @@ int amdgpu_dpm_set_powergating_by_smu(struct
> amdgpu_device *adev, uint32_t block
>  		return 0;
>  	}
>=20
> -	mutex_lock(&adev->pm.mutex);
> -
>  	switch (block_type) {
>  	case AMD_IP_BLOCK_TYPE_UVD:
>  	case AMD_IP_BLOCK_TYPE_VCE:
> @@ -102,8 +100,6 @@ int amdgpu_dpm_set_powergating_by_smu(struct
> amdgpu_device *adev, uint32_t block
>  	if (!ret)
>  		atomic_set(&adev->pm.pwr_state[block_type], pwr_state);
>=20
> -	mutex_unlock(&adev->pm.mutex);
> -
>  	return ret;
>  }
>=20
> @@ -423,9 +419,7 @@ void amdgpu_dpm_compute_clocks(struct
> amdgpu_device *adev)
>  	if (!pp_funcs->pm_compute_clocks)
>  		return;
>=20
> -	mutex_lock(&adev->pm.mutex);
>  	pp_funcs->pm_compute_clocks(adev->powerplay.pp_handle);
> -	mutex_unlock(&adev->pm.mutex);
>  }
>=20
>  void amdgpu_dpm_enable_uvd(struct amdgpu_device *adev, bool enable)
>=20
> Thanks for the assistance!
>=20
> Arthur.
