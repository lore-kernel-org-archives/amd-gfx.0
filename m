Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EC08C43334
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Jul 2022 06:14:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4ADBD10E5C6;
	Fri, 15 Jul 2022 06:14:38 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7FEDC10E5C6
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Jul 2022 06:14:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N6xuT1fbQFlpP7HnPylMeV56+VkB44jPpFDdD8uhFaodIc1di9kQbhWDuIvfo9EoiN9EYa/wL86mGq6sjZMd+2qB72D6uOhpudNlYRX72a1wk4SE5MtH3z5J56bwkRwwheuZmNcJztQXRIlBumRdsnHRAxYc0Sr9GHG8HpT6pz99DxOEe5GNLqYg95xhfXF42POyBL6R1JOG5cpRjZ9iP2Wjp9QR3XkrzJxi0nGYeXbfPOeQjZ5HT15cCAYEywMuxrTv5cYPtj3aqJxzhYAji6U2RckMqNwV7Scfp9W6lgUQwEm8kZrbF3UnhDQrlo+FRi6nkY3X51TaXzbxBa1BhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N7OAvSusN9AMG5zHZLRttMWr2PpbpPqW7FV1lRycZH0=;
 b=Sh7+KQuaTwZIVSxup+3VCKNRBGL5a2JbtRAm5I4+zrV1bv+rby0MBX3WwUuWQ8EZW15fOWsgwsjbOv4wAr8nMJZlf8gl4S+iuQZUN0PLCz3IrKmsqjcIn/tLurpAkCYSHy5yGF2RKCGKt0O9hheUOPbKNvflTl2zh/MUZrDKtMxMlKYx16XxUkpSHyxmcE5tVmKU+9/Uau/nfZterWovgXRBY6BtGWvx1xpZ/UJH1cAiQYyu1gxs32K+vzdTt1u6MBrqUghFRfRVeI3nHgY8naNV0agz1aDJC4X8/ZmUrkuD1Rbnv6SGff38pemZmk9H5A0I5oDj7f4msr5AzrCbeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N7OAvSusN9AMG5zHZLRttMWr2PpbpPqW7FV1lRycZH0=;
 b=uoia/S3d326ri+YH7/NggO0D9JcqEKQ/o21OPLc0kVaMSPPo4EG209vh+ZH3OdbaeX87PELjjYg9n0e14V8JtaXM1UabSS5NFdaO7Nh7JT+g7WDmZLTmctF+QyhEuPLaFLh8xWt4HKQ7qPdfAu7uM6vKJhhy/omGFA6DRmNhwKM=
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by DM4PR12MB6495.namprd12.prod.outlook.com (2603:10b6:8:bc::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.15; Fri, 15 Jul
 2022 06:14:33 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::b096:31c:bfb7:fa0a]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::b096:31c:bfb7:fa0a%4]) with mapi id 15.20.5438.014; Fri, 15 Jul 2022
 06:14:33 +0000
From: "Kuehling, Felix" <Felix.Kuehling@amd.com>
To: "Guo, Shikai" <Shikai.Guo@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdkfd: Remove Align VRAM allocations to 1MB on APU
 ASIC
Thread-Topic: [PATCH] drm/amdkfd: Remove Align VRAM allocations to 1MB on APU
 ASIC
Thread-Index: AQHYlpkEgiDjf37bGkenDWR465Ytyq18WS4AgAJtYICAAABIAIAAL77z
Date: Fri, 15 Jul 2022 06:14:33 +0000
Message-ID: <BN9PR12MB5115AB2A77A1EA7D6F921EC4928B9@BN9PR12MB5115.namprd12.prod.outlook.com>
References: <20220713091426.938701-1-shikai.guo@amd.com>
 <d329ff9e-b5ea-1d35-a600-1322a9136cfb@amd.com>
 <DM4PR12MB5868C5183137949E89165B8D9F8B9@DM4PR12MB5868.namprd12.prod.outlook.com>
 <DM4PR12MB586852A01ECAA344F359CA589F8B9@DM4PR12MB5868.namprd12.prod.outlook.com>
In-Reply-To: <DM4PR12MB586852A01ECAA344F359CA589F8B9@DM4PR12MB5868.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=True;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-07-15T06:14:32.924Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard; 
suggested_attachment_session_id: 05315f48-c116-fd38-c4b1-e2d53e121767
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b59247fc-345c-4791-560d-08da66294931
x-ms-traffictypediagnostic: DM4PR12MB6495:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vuwzMRlUlqJ4fsiQnKuLKAgFj18oKcPxXb/xDrSyMJwlOacd4schTQiMTKdTkA0xuL7H/MLTXZ9bqFzU/J0lQLRkQJeRfmZhgyc7T694jZdmjV0ZhHrl1VgCf7KlT9uDzzfXoqKIT8cU40qVNbe2Dyjflf6rKlj4eQMGseO830tmKzQWgI6QOJCdRHls1nGjPg4KdSMCZHAbkFkOLbQa+e3IZ8KYLOwUCqJ8jL7VyIjX9ClGWbOkMGfOD33reqU7Jd/9XpoViwqL9C6PU8ICW9YqI1YuybzQi8D2oX9GvKT6ulxr5/u93XFObRYCtzRyPGaqeO6aOyA0NBoCVnAelzC6MnMhFngJCdU9Dd8h2NQoRqCJtggdaAjHf0Q3WtwGiPQjRhru3gLyaIo0goN2QOtf36naUmznhycFG8v3sW9h5FXOP2W/wenhZ5svIeEJ8TNmSrh9CDGBz9fsevQXFn52fff9WHaka4jV6lKw6QsIealDnnA8l+RNwuV+6Bu2RAKUvZHZjVROe3zpEMK7VeYcVs3AlYoYyFhhfSUfY589m0Y42QKhLfWDttIq9fLlt4zAUraUOB+v+UbJCcLm5cpUDlflRn+/awb6woJsfDYNxubgpNDB0oHMms23rOQtt3PBYKZ+6suEGzYTp+RUBco+7BAO3Ba0reBxu8v3lJ3ICdpwWcnNwNVnsRhkxrN15keWM6ExuW6AeZCptn067Cbw1TiaEVSNXz04kGZDAk0I6yVjYhlyoigCgxsZ2LX4yi7FcLtrbXsO96TZzTBFhc05nB8WIVnE1lq1YwUy/ds+XC27TxP1KxEIheIcA76G
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(136003)(366004)(396003)(376002)(346002)(39860400002)(8936002)(52536014)(316002)(9686003)(86362001)(8676002)(186003)(38070700005)(64756008)(4326008)(66476007)(66446008)(66946007)(66556008)(76116006)(91956017)(26005)(110136005)(54906003)(7696005)(122000001)(478600001)(19627405001)(41300700001)(55016003)(5660300002)(33656002)(53546011)(38100700002)(71200400001)(83380400001)(2906002)(6506007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?sj7vZVJ2FDXqXjCZmCyZUz7T1+CXVERn1jwINSQQ2KjHCtl5IiFTRu73pehp?=
 =?us-ascii?Q?12QpEtnQnl2dTmPMYDG9FCbWHzTPm2CnKtnCuD74Pmj8MxhkRtV29dufYxia?=
 =?us-ascii?Q?VqdWZelH8W43dNTrN0FTh7t4n9fbPnmzzaccH5P2sif3UMGnLyJTAeU+c1aQ?=
 =?us-ascii?Q?9BJdMvp2yW3o3caH5AE4sGbOgUut2G0ddbsJIa/qLlQL2fBq79bvIsDQTKEt?=
 =?us-ascii?Q?Tckxsbu44D5Ekv7UxkOczB3+YMAUUIBJa+8qDCSO2/ikpmKtCf5IU9agdTF2?=
 =?us-ascii?Q?lC8ja1yCzgsMIPGb8T3FuhSGRvlE854MgBeSPNEDkwOy0Q0zYOc468JValxJ?=
 =?us-ascii?Q?7ML03MDosiTPyk2RyFTqTTNkC4R2aY6AZzva/s8zzcbwbILkr4FN0wQPcPjV?=
 =?us-ascii?Q?7AFpxcvIeNrWzfovdFnM44iLJdRgsSyLI/TD4NOAcbbFsYrKvylf+MmGQyhr?=
 =?us-ascii?Q?7/vyisckd5wv+VSzMI8KO61b0r3JU7TSzrjUqFGSBGB2/lA5CLdSPx4V45oz?=
 =?us-ascii?Q?2wOZJtBAH/QLOceyLN0xRkdSTwSc9g4kPfKKuPjsrjoF2L/Lq8eKn7OfQoMX?=
 =?us-ascii?Q?xpf4pSn7EBtAk1cXiuVHBl9iMB4MxRnv4dJAT/FyvODSLIrMrPNy0hVYA/QI?=
 =?us-ascii?Q?U2O/4uIIXliUDNodP8loCHrmGoRaW3S/Wg029F9FVTXg3x7J/x54D4GfVAlQ?=
 =?us-ascii?Q?JJMrlwYR+zHpvPzcEd6WfbTyrmD/kWkoBWofdWxaApqJcWxJaR2no1VF0/Kg?=
 =?us-ascii?Q?NJ1BkYOh+hhJEJHcAy0Fevd8CXH94cNKYY3YP/hOP8KH/wxQLsZFkzw2MT1B?=
 =?us-ascii?Q?sBDBP/Uxhgpfh8JeTKKLwfYD6/RzbOiNCD/t0RPqzKplKW+7K8zTrNN0rkFa?=
 =?us-ascii?Q?xxucBf5b2IkMDmkrd8WA5PaifLS2fcPr+9AbLKUOoqTOTxTNXh8QCvXcGP6G?=
 =?us-ascii?Q?UV2rcDA4l/W5PGF2NmUhyae22vaNdVxaL+PWiSZbVvnt2dYy0jAehhMsI5c8?=
 =?us-ascii?Q?5jeffFR0/FD63YezipcyxExgep1GS5RK4Nlf46o943Cu1WdT1XXq+SdF1Ps3?=
 =?us-ascii?Q?DY6Reeem1vHjVTvMoXDqDuGN/xESrUgQqCqaYXDwF1h57qx84pm8yz4OIdJt?=
 =?us-ascii?Q?FsyXatx9TbC7nJrXszJmMw/oewTWG2y3Un/iWzcaN9hBe7uu24KHZfTZ7Eki?=
 =?us-ascii?Q?ty1Ywnoe7Tlt+fO7b5bPLm1QD54jXfLilS4kBhzFzEX89rUmA1dvA5w3ZrJM?=
 =?us-ascii?Q?oLQWVT/42wYCLG1ys43ENNXYPYWFFQAYTOoVaf73Vw0z80ONdzABcZh6RxCy?=
 =?us-ascii?Q?nfQFxxDol60M6cSESx5A2oHyt/fqQ/vPB6pOp9xzqhJoxH1MR4CePgxux1d8?=
 =?us-ascii?Q?b807Yj8fWebbSCg+waUNZ3aEGUHV+5Ln+qP8rW5vXIM9cAbA0ta2YzHRlXS5?=
 =?us-ascii?Q?OKtFNoiVOn65RMPHlgYhSrhC59Dq9/SBDSzqviJvj/WHovgNelmiFtSHogm4?=
 =?us-ascii?Q?eLMmV4HWJuBARQBWgmBTCgVV5btTb0NFTqkSN1QQ1NaSEo5tYwZR8T0OXUWb?=
 =?us-ascii?Q?qKnI+gp1tYnubh8Jzag=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BN9PR12MB5115AB2A77A1EA7D6F921EC4928B9BN9PR12MB5115namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b59247fc-345c-4791-560d-08da66294931
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jul 2022 06:14:33.3540 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: t+r++7mII4lhZTX8lUHjEL+kRWRt3XNwzEUNCcQI2mHceUnEl5dQaoCa0UM0q7qlmjkyLHv8aQy2s9pHowhSBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6495
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
Cc: "Phillips, Daniel" <Daniel.Phillips@amd.com>, "Ji,
 Ruili" <Ruili.Ji@amd.com>, "Liu, Aaron" <Aaron.Liu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_BN9PR12MB5115AB2A77A1EA7D6F921EC4928B9BN9PR12MB5115namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - General]

As a compromise we are considering a change that restores the old allocatio=
n behaviour, keeping the more conservative estimate only for the available-=
memory API.

Regards,
  Felix

________________________________
From: Guo, Shikai <Shikai.Guo@amd.com>
Sent: Thursday, July 14, 2022 11:21 PM
To: Kuehling, Felix <Felix.Kuehling@amd.com>; amd-gfx@lists.freedesktop.org=
 <amd-gfx@lists.freedesktop.org>
Cc: Phillips, Daniel <Daniel.Phillips@amd.com>; Ji, Ruili <Ruili.Ji@amd.com=
>; Liu, Aaron <Aaron.Liu@amd.com>
Subject: RE: [PATCH] drm/amdkfd: Remove Align VRAM allocations to 1MB on AP=
U ASIC

[AMD Official Use Only - General]

Thanks Felix comment, I will further debug this issue.

-----Original Message-----
From: Guo, Shikai
Sent: Friday, July 15, 2022 11:21 AM
To: Kuehling, Felix <Felix.Kuehling@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Phillips, Daniel <Daniel.Phillips@amd.com>; Ji, Ruili <Ruili.Ji@amd.com=
>; Liu, Aaron <Aaron.Liu@amd.com>
Subject: RE: [PATCH] drm/amdkfd: Remove Align VRAM allocations to 1MB on AP=
U ASIC

[AMD Official Use Only - General]

This Felix comment, I will further debug this issue.

-----Original Message-----
From: Kuehling, Felix <Felix.Kuehling@amd.com>
Sent: Wednesday, July 13, 2022 10:17 PM
To: Guo, Shikai <Shikai.Guo@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Phillips, Daniel <Daniel.Phillips@amd.com>; Ji, Ruili <Ruili.Ji@amd.com=
>; Liu, Aaron <Aaron.Liu@amd.com>
Subject: Re: [PATCH] drm/amdkfd: Remove Align VRAM allocations to 1MB on AP=
U ASIC


Am 2022-07-13 um 05:14 schrieb shikai guo:
> From: Shikai Guo <Shikai.Guo@amd.com>
>
> While executing KFDMemoryTest.MMBench, test case will allocate 4KB size m=
emory 1000 times.
> Every time, user space will get 2M memory.APU VRAM is 512M, there is not =
enough memory to be allocated.
> So the 2M aligned feature is not suitable for APU.
NAK. We can try to make the estimate of available VRAM more accurate.
But in the end, this comes down to limitations of the VRAM manager and how =
it handles memory fragmentation.

A large discrepancy between total VRAM and available VRAM can have a few
reasons:

  * Big system memory means we need to reserve more space for page tables
  * Many small allocations causing lots of fragmentation. This may be
    the result of memory leaks in previous tests

This patch can "fix" a situation where a leak caused excessive fragmentatio=
n. But that just papers over the leak. And it will cause the opposite probl=
em for the new AvailableMemory test that checks that we can really allocate=
 as much memory as we promised.

Regards,
   Felix


>
> guoshikai@guoshikai-MayanKD-RMB:~/linth/libhsakmt/tests/kfdtest/build$ ./=
kfdtest --gtest_filter=3DKFDMemoryTest.MMBench
> [          ] Profile: Full Test
> [          ] HW capabilities: 0x9
> Note: Google Test filter =3D KFDMemoryTest.MMBench [=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D] Running
> 1 test from 1 test case.
> [----------] Global test environment set-up.
> [----------] 1 test from KFDMemoryTest
> [ RUN      ] KFDMemoryTest.MMBench
> [          ] Found VRAM of 512MB.
> [          ] Available VRAM 328MB.
> [          ] Test (avg. ns)         alloc   mapOne  umapOne   mapAll  uma=
pAll     free
> [          ] ------------------------------------------------------------=
--------------
> [          ]   4K-SysMem-noSDMA     26561    10350     5212     3787     =
3981    12372
> [          ]  64K-SysMem-noSDMA     42864     6648     3973     5223     =
3843    15100
> [          ]   2M-SysMem-noSDMA    312906    12614     4390     6254     =
4790    70260
> [          ]  32M-SysMem-noSDMA   4417812   130437    21625    97687    1=
8500   929562
> [          ]   1G-SysMem-noSDMA 132161000  2738000   583000  2181000   49=
9000 39091000
> [          ] ------------------------------------------------------------=
--------------
> /home/guoshikai/linth/libhsakmt/tests/kfdtest/src/KFDMemoryTest.cpp:92
> 2: Failure Value of: (hsaKmtAllocMemory(allocNode, bufSize, memFlags, &bu=
fs[i]))
>    Actual: 6
> Expected: HSAKMT_STATUS_SUCCESS
> Which is: 0
> [  FAILED  ] KFDMemoryTest.MMBench (749 ms)
>
> fix this issue by adding different treatments for apu and dgpu
>
> Signed-off-by: ruili ji <ruili.ji@amd.com>
> Signed-off-by: shikai guo <shikai.guo@amd.com>
> ---
>   .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c   | 18 +++++++++++++-----
>   1 file changed, 13 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> index d1657de5f875..2ad2cd5e3e8b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> @@ -115,7 +115,9 @@ void amdgpu_amdkfd_reserve_system_mem(uint64_t size)
>    * compromise that should work in most cases without reserving too
>    * much memory for page tables unnecessarily (factor 16K, >> 14).
>    */
> -#define ESTIMATE_PT_SIZE(mem_size) max(((mem_size) >> 14),
> AMDGPU_VM_RESERVED_VRAM)
> +
> +#define ESTIMATE_PT_SIZE(adev, mem_size)   (adev->flags & AMD_IS_APU) ? =
\
> +                (mem_size >> 14) : max(((mem_size) >> 14),
> +AMDGPU_VM_RESERVED_VRAM)
>
>   static size_t amdgpu_amdkfd_acc_size(uint64_t size)
>   {
> @@ -142,7 +144,7 @@ static int amdgpu_amdkfd_reserve_mem_limit(struct amd=
gpu_device *adev,
>                uint64_t size, u32 alloc_flag)
>   {
>        uint64_t reserved_for_pt =3D
> -             ESTIMATE_PT_SIZE(amdgpu_amdkfd_total_mem_size);
> +             ESTIMATE_PT_SIZE(adev, amdgpu_amdkfd_total_mem_size);
>        size_t acc_size, system_mem_needed, ttm_mem_needed, vram_needed;
>        int ret =3D 0;
>
> @@ -156,12 +158,15 @@ static int amdgpu_amdkfd_reserve_mem_limit(struct a=
mdgpu_device *adev,
>                system_mem_needed =3D acc_size;
>                ttm_mem_needed =3D acc_size;
>
> +             if (adev->flags & AMD_IS_APU)
> +                     vram_needed =3D size;
> +             else
>                /*
>                 * Conservatively round up the allocation requirement to 2=
 MB
>                 * to avoid fragmentation caused by 4K allocations in the =
tail
>                 * 2M BO chunk.
>                 */
> -             vram_needed =3D ALIGN(size, VRAM_ALLOCATION_ALIGN);
> +                     vram_needed =3D ALIGN(size, VRAM_ALLOCATION_ALIGN);
>        } else if (alloc_flag & KFD_IOC_ALLOC_MEM_FLAGS_USERPTR) {
>                system_mem_needed =3D acc_size + size;
>                ttm_mem_needed =3D acc_size;
> @@ -220,7 +225,10 @@ static void unreserve_mem_limit(struct amdgpu_device=
 *adev,
>        } else if (alloc_flag & KFD_IOC_ALLOC_MEM_FLAGS_VRAM) {
>                kfd_mem_limit.system_mem_used -=3D acc_size;
>                kfd_mem_limit.ttm_mem_used -=3D acc_size;
> -             adev->kfd.vram_used -=3D ALIGN(size, VRAM_ALLOCATION_ALIGN)=
;
> +             if (adev->flags & AMD_IS_APU)
> +                     adev->kfd.vram_used -=3D size;
> +             else
> +                     adev->kfd.vram_used -=3D ALIGN(size, VRAM_ALLOCATIO=
N_ALIGN);
>        } else if (alloc_flag & KFD_IOC_ALLOC_MEM_FLAGS_USERPTR) {
>                kfd_mem_limit.system_mem_used -=3D (acc_size + size);
>                kfd_mem_limit.ttm_mem_used -=3D acc_size; @@ -1666,7 +1674=
,7 @@ int
> amdgpu_amdkfd_criu_resume(void *p)
>   size_t amdgpu_amdkfd_get_available_memory(struct amdgpu_device *adev)
>   {
>        uint64_t reserved_for_pt =3D
> -             ESTIMATE_PT_SIZE(amdgpu_amdkfd_total_mem_size);
> +             ESTIMATE_PT_SIZE(adev, amdgpu_amdkfd_total_mem_size);
>        size_t available;
>
>        spin_lock(&kfd_mem_limit.mem_limit_lock);

--_000_BN9PR12MB5115AB2A77A1EA7D6F921EC4928B9BN9PR12MB5115namp_
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
<p style=3D"font-family:Arial;font-size:10pt;color:#0000FF;margin:5pt;" ali=
gn=3D"Left">
[AMD Official Use Only - General]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
As a compromise we are considering a change that restores the old allocatio=
n behaviour, keeping the more conservative estimate only for the available-=
memory API.</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
Regards,<br>
&nbsp; Felix</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Guo, Shikai &lt;Shika=
i.Guo@amd.com&gt;<br>
<b>Sent:</b> Thursday, July 14, 2022 11:21 PM<br>
<b>To:</b> Kuehling, Felix &lt;Felix.Kuehling@amd.com&gt;; amd-gfx@lists.fr=
eedesktop.org &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Cc:</b> Phillips, Daniel &lt;Daniel.Phillips@amd.com&gt;; Ji, Ruili &lt;=
Ruili.Ji@amd.com&gt;; Liu, Aaron &lt;Aaron.Liu@amd.com&gt;<br>
<b>Subject:</b> RE: [PATCH] drm/amdkfd: Remove Align VRAM allocations to 1M=
B on APU ASIC</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">[AMD Official Use Only - General]<br>
<br>
Thanks Felix comment, I will further debug this issue.<br>
<br>
-----Original Message-----<br>
From: Guo, Shikai <br>
Sent: Friday, July 15, 2022 11:21 AM<br>
To: Kuehling, Felix &lt;Felix.Kuehling@amd.com&gt;; amd-gfx@lists.freedeskt=
op.org<br>
Cc: Phillips, Daniel &lt;Daniel.Phillips@amd.com&gt;; Ji, Ruili &lt;Ruili.J=
i@amd.com&gt;; Liu, Aaron &lt;Aaron.Liu@amd.com&gt;<br>
Subject: RE: [PATCH] drm/amdkfd: Remove Align VRAM allocations to 1MB on AP=
U ASIC<br>
<br>
[AMD Official Use Only - General]<br>
<br>
This Felix comment, I will further debug this issue.<br>
<br>
-----Original Message-----<br>
From: Kuehling, Felix &lt;Felix.Kuehling@amd.com&gt; <br>
Sent: Wednesday, July 13, 2022 10:17 PM<br>
To: Guo, Shikai &lt;Shikai.Guo@amd.com&gt;; amd-gfx@lists.freedesktop.org<b=
r>
Cc: Phillips, Daniel &lt;Daniel.Phillips@amd.com&gt;; Ji, Ruili &lt;Ruili.J=
i@amd.com&gt;; Liu, Aaron &lt;Aaron.Liu@amd.com&gt;<br>
Subject: Re: [PATCH] drm/amdkfd: Remove Align VRAM allocations to 1MB on AP=
U ASIC<br>
<br>
<br>
Am 2022-07-13 um 05:14 schrieb shikai guo:<br>
&gt; From: Shikai Guo &lt;Shikai.Guo@amd.com&gt;<br>
&gt;<br>
&gt; While executing KFDMemoryTest.MMBench, test case will allocate 4KB siz=
e memory 1000 times.<br>
&gt; Every time, user space will get 2M memory.APU VRAM is 512M, there is n=
ot enough memory to be allocated.<br>
&gt; So the 2M aligned feature is not suitable for APU.<br>
NAK. We can try to make the estimate of available VRAM more accurate. <br>
But in the end, this comes down to limitations of the VRAM manager and how =
it handles memory fragmentation.<br>
<br>
A large discrepancy between total VRAM and available VRAM can have a few<br=
>
reasons:<br>
<br>
&nbsp; * Big system memory means we need to reserve more space for page tab=
les<br>
&nbsp; * Many small allocations causing lots of fragmentation. This may be<=
br>
&nbsp;&nbsp;&nbsp; the result of memory leaks in previous tests<br>
<br>
This patch can &quot;fix&quot; a situation where a leak caused excessive fr=
agmentation. But that just papers over the leak. And it will cause the oppo=
site problem for the new AvailableMemory test that checks that we can reall=
y allocate as much memory as we promised.<br>
<br>
Regards,<br>
&nbsp;&nbsp; Felix<br>
<br>
<br>
&gt;<br>
&gt; guoshikai@guoshikai-MayanKD-RMB:~/linth/libhsakmt/tests/kfdtest/build$=
 ./kfdtest --gtest_filter=3DKFDMemoryTest.MMBench<br>
&gt; [&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ] Profile: Ful=
l Test<br>
&gt; [&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ] HW capabilit=
ies: 0x9<br>
&gt; Note: Google Test filter =3D KFDMemoryTest.MMBench [=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D] Running <br>
&gt; 1 test from 1 test case.<br>
&gt; [----------] Global test environment set-up.<br>
&gt; [----------] 1 test from KFDMemoryTest<br>
&gt; [ RUN&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ] KFDMemoryTest.MMBench<br>
&gt; [&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ] Found VRAM o=
f 512MB.<br>
&gt; [&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ] Available VR=
AM 328MB.<br>
&gt; [&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ] Test (avg. n=
s)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; alloc&nbsp;&nbsp; mapOne=
&nbsp; umapOne&nbsp;&nbsp; mapAll&nbsp; umapAll&nbsp;&nbsp;&nbsp;&nbsp; fre=
e<br>
&gt; [&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ] ------------=
--------------------------------------------------------------<br>
&gt; [&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ]&nbsp;&nbsp; =
4K-SysMem-noSDMA&nbsp;&nbsp;&nbsp;&nbsp; 26561&nbsp;&nbsp;&nbsp; 10350&nbsp=
;&nbsp;&nbsp;&nbsp; 5212&nbsp;&nbsp;&nbsp;&nbsp; 3787&nbsp;&nbsp;&nbsp;&nbs=
p; 3981&nbsp;&nbsp;&nbsp; 12372<br>
&gt; [&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ]&nbsp; 64K-Sy=
sMem-noSDMA&nbsp;&nbsp;&nbsp;&nbsp; 42864&nbsp;&nbsp;&nbsp;&nbsp; 6648&nbsp=
;&nbsp;&nbsp;&nbsp; 3973&nbsp;&nbsp;&nbsp;&nbsp; 5223&nbsp;&nbsp;&nbsp;&nbs=
p; 3843&nbsp;&nbsp;&nbsp; 15100<br>
&gt; [&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ]&nbsp;&nbsp; =
2M-SysMem-noSDMA&nbsp;&nbsp;&nbsp; 312906&nbsp;&nbsp;&nbsp; 12614&nbsp;&nbs=
p;&nbsp;&nbsp; 4390&nbsp;&nbsp;&nbsp;&nbsp; 6254&nbsp;&nbsp;&nbsp;&nbsp; 47=
90&nbsp;&nbsp;&nbsp; 70260<br>
&gt; [&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ]&nbsp; 32M-Sy=
sMem-noSDMA&nbsp;&nbsp; 4417812&nbsp;&nbsp; 130437&nbsp;&nbsp;&nbsp; 21625&=
nbsp;&nbsp;&nbsp; 97687&nbsp;&nbsp;&nbsp; 18500&nbsp;&nbsp; 929562<br>
&gt; [&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ]&nbsp;&nbsp; =
1G-SysMem-noSDMA 132161000&nbsp; 2738000&nbsp;&nbsp; 583000&nbsp; 2181000&n=
bsp;&nbsp; 499000 39091000<br>
&gt; [&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ] ------------=
--------------------------------------------------------------<br>
&gt; /home/guoshikai/linth/libhsakmt/tests/kfdtest/src/KFDMemoryTest.cpp:92=
<br>
&gt; 2: Failure Value of: (hsaKmtAllocMemory(allocNode, bufSize, memFlags, =
&amp;bufs[i]))<br>
&gt;&nbsp;&nbsp;&nbsp; Actual: 6<br>
&gt; Expected: HSAKMT_STATUS_SUCCESS<br>
&gt; Which is: 0<br>
&gt; [&nbsp; FAILED&nbsp; ] KFDMemoryTest.MMBench (749 ms)<br>
&gt;<br>
&gt; fix this issue by adding different treatments for apu and dgpu<br>
&gt;<br>
&gt; Signed-off-by: ruili ji &lt;ruili.ji@amd.com&gt;<br>
&gt; Signed-off-by: shikai guo &lt;shikai.guo@amd.com&gt;<br>
&gt; ---<br>
&gt;&nbsp;&nbsp; .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c&nbsp;&nbsp; |=
 18 +++++++++++++-----<br>
&gt;&nbsp;&nbsp; 1 file changed, 13 insertions(+), 5 deletions(-)<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c <br>
&gt; b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c<br>
&gt; index d1657de5f875..2ad2cd5e3e8b 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c<br>
&gt; @@ -115,7 +115,9 @@ void amdgpu_amdkfd_reserve_system_mem(uint64_t siz=
e)<br>
&gt;&nbsp;&nbsp;&nbsp; * compromise that should work in most cases without =
reserving too<br>
&gt;&nbsp;&nbsp;&nbsp; * much memory for page tables unnecessarily (factor =
16K, &gt;&gt; 14).<br>
&gt;&nbsp;&nbsp;&nbsp; */<br>
&gt; -#define ESTIMATE_PT_SIZE(mem_size) max(((mem_size) &gt;&gt; 14), <br>
&gt; AMDGPU_VM_RESERVED_VRAM)<br>
&gt; +<br>
&gt; +#define ESTIMATE_PT_SIZE(adev, mem_size)&nbsp;&nbsp; (adev-&gt;flags =
&amp; AMD_IS_APU) ? \<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; (mem_size &gt;&gt; 14) : max(((mem_size) &gt;&gt; 14)=
, <br>
&gt; +AMDGPU_VM_RESERVED_VRAM)<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp; static size_t amdgpu_amdkfd_acc_size(uint64_t size)<br>
&gt;&nbsp;&nbsp; {<br>
&gt; @@ -142,7 +144,7 @@ static int amdgpu_amdkfd_reserve_mem_limit(struct =
amdgpu_device *adev,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; uint64_t size, u32 alloc_flag)<br>
&gt;&nbsp;&nbsp; {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t reserved_for_pt =3D=
<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; ESTIMATE_PT_SIZE(amdgpu_amdkfd_total_mem_size);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; ESTIMATE_PT_SIZE(adev, amdgpu_amdkfd_total_mem_size);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; size_t acc_size, system_mem_=
needed, ttm_mem_needed, vram_needed;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
&gt;&nbsp;&nbsp; <br>
&gt; @@ -156,12 +158,15 @@ static int amdgpu_amdkfd_reserve_mem_limit(struc=
t amdgpu_device *adev,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; system_mem_needed =3D acc_size;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; ttm_mem_needed =3D acc_size;<br>
&gt;&nbsp;&nbsp; <br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if (adev-&gt;flags &amp; AMD_IS_APU)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vram_needed =3D size;<b=
r>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; else<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; /*<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; * Conservatively round up the allocation requirem=
ent to 2 MB<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; * to avoid fragmentation caused by 4K allocations=
 in the tail<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; * 2M BO chunk.<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; vram_needed =3D ALIGN(size, VRAM_ALLOCATION_ALIGN);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vram_needed =3D ALIGN(s=
ize, VRAM_ALLOCATION_ALIGN);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else if (alloc_flag &amp; =
KFD_IOC_ALLOC_MEM_FLAGS_USERPTR) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; system_mem_needed =3D acc_size + size;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; ttm_mem_needed =3D acc_size;<br>
&gt; @@ -220,7 +225,10 @@ static void unreserve_mem_limit(struct amdgpu_dev=
ice *adev,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else if (alloc_flag &amp; =
KFD_IOC_ALLOC_MEM_FLAGS_VRAM) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; kfd_mem_limit.system_mem_used -=3D acc_size;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; kfd_mem_limit.ttm_mem_used -=3D acc_size;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; adev-&gt;kfd.vram_used -=3D ALIGN(size, VRAM_ALLOCATION_ALIGN);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if (adev-&gt;flags &amp; AMD_IS_APU)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;kfd.vram_used =
-=3D size;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; else<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;kfd.vram_used =
-=3D ALIGN(size, VRAM_ALLOCATION_ALIGN);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else if (alloc_flag &amp; =
KFD_IOC_ALLOC_MEM_FLAGS_USERPTR) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; kfd_mem_limit.system_mem_used -=3D (acc_size + size);<b=
r>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; kfd_mem_limit.ttm_mem_used -=3D acc_size; @@ -1666,7 +1=
674,7 @@ int
<br>
&gt; amdgpu_amdkfd_criu_resume(void *p)<br>
&gt;&nbsp;&nbsp; size_t amdgpu_amdkfd_get_available_memory(struct amdgpu_de=
vice *adev)<br>
&gt;&nbsp;&nbsp; {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t reserved_for_pt =3D=
<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; ESTIMATE_PT_SIZE(amdgpu_amdkfd_total_mem_size);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; ESTIMATE_PT_SIZE(adev, amdgpu_amdkfd_total_mem_size);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; size_t available;<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; spin_lock(&amp;kfd_mem_limit=
.mem_limit_lock);<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BN9PR12MB5115AB2A77A1EA7D6F921EC4928B9BN9PR12MB5115namp_--
