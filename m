Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82ACCC19F2D
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Aug 2022 11:20:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3734CD0425;
	Tue,  9 Aug 2022 11:20:13 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2082.outbound.protection.outlook.com [40.107.102.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CCB67D03C6
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 Aug 2022 11:19:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i1Hy1U7Iz8yYx8aCt7GDngFAs8e/2zWBB/OeaiVdaQcYqwePztQozOGA2iGMssacYM1E/7RE3iGCck1gmK1CbITnudl+Zuuw4X9dBMgvUUPX09pI88/1fQCXlew9jUeCQrcotu6T+fZGNkf+DLAlh6QGqVwA802N0zpV3fSD9AmkEuH9As6QYhCyC7idR5ppiu+48wx522f7oKfmTIh7+1PlxUQ7Fu697+5arU6Xf85GF1D9Gctf3iUAU4CdbbVYMm37ZnWLk2gAtHJBBbnV6SzXzdp/GziIPwEZiB/zRgpivAFYAZcPHrn8Yl63xuRAyYErtyZSURLrl1Ilrk3egA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Js+wfq3/CAquA41eJGzT4nFroy4cEW5g43qazqWhpJs=;
 b=VZAMxfUb6GFttdu6wikOSCJPBFeJAmi9BsVOZq6XtW+usVJpBLlo/2YffD5t9XKjB5qPoPTXwUSsoubFNwahIcnXTQY4fkmyA0LKV8xDCsEnz72JZUHL8AXD8pyp/g6uApjDWxkQpiKN+qeItRCzArp1RZsTqg862MTw4yvFY+5G/3wAnNbEsnr4nJxoI/qaujjvzQtnIlWIpioXYuxZaR0P7cRpUWFGQZDiqE6EQSYScvMxxIATTh8yLQcS33YdrYEgsZMbgGYQ12lMOCm0DJXR3m92Snws0yJ94FWcTOu7G7RDLA1kCJAY0Ql1AO2L6TqA+rQPDnIdHsUeLdSe7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Js+wfq3/CAquA41eJGzT4nFroy4cEW5g43qazqWhpJs=;
 b=ysuwJO+sHh4r0PEcJsrcUjjRv8Gum/bDXZHlDb3E5nrOpYmmg5yMRwAV4cBToQJgq8KLEoRd2q4q9TPNnVrlVDqdCdBXY+71+yWbiMdOSKkCSrI5AaYLBGh7EzwlCk1fw6kUwZm4BZXnVlVPFgdH2hzr0k2LW2nymuwDE1ke7r4=
Received: from BY5PR12MB4260.namprd12.prod.outlook.com (2603:10b6:a03:206::22)
 by MN2PR12MB3822.namprd12.prod.outlook.com (2603:10b6:208:166::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Tue, 9 Aug
 2022 11:19:41 +0000
Received: from BY5PR12MB4260.namprd12.prod.outlook.com
 ([fe80::7dd7:f4fd:2b2b:65ea]) by BY5PR12MB4260.namprd12.prod.outlook.com
 ([fe80::7dd7:f4fd:2b2b:65ea%5]) with mapi id 15.20.5525.011; Tue, 9 Aug 2022
 11:19:41 +0000
From: "Milinkovic, Dusica" <Dusica.Milinkovic@amd.com>
To: "Liu, Shaoyun" <Shaoyun.Liu@amd.com>, Alex Deucher <alexdeucher@gmail.com>
Subject: RE: [PATCH] Increase tlb flush timeout for sriov
Thread-Topic: [PATCH] Increase tlb flush timeout for sriov
Thread-Index: AQHYpxe9lMoKAhSgzUCwfDGUWGxCj62lgnSAgAAcZoCAANEz0A==
Date: Tue, 9 Aug 2022 11:19:41 +0000
Message-ID: <BY5PR12MB426064BCC7DC38C5B8AF7CABED629@BY5PR12MB4260.namprd12.prod.outlook.com>
References: <20220803090134.529299-1-dusica.milinkovic@amd.com>
 <CADnq5_ODjyTHPpGcsuHpbmaC-_MXvzKq7xXVKY9e5q7bwRBAfw@mail.gmail.com>
 <CH0PR12MB537246946D63A6599FD167CAF4639@CH0PR12MB5372.namprd12.prod.outlook.com>
In-Reply-To: <CH0PR12MB537246946D63A6599FD167CAF4639@CH0PR12MB5372.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=65fddf9c-6458-48bb-a052-f8f99af732c9;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-08-09T10:59:38Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 404c5405-5e38-46c6-7c1e-08da79f90e1b
x-ms-traffictypediagnostic: MN2PR12MB3822:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9d8i4B9v/uT/jpxHnUuIKHzC1OluS818rs01pH8B9d8giueW32q0Aak3f872X3CO0Elb3BcI8v1jQkXeoIZFOJ4PtoHUvjxN3/1HqJt3UITWtddT9NPT+gCHCfZKoch2ELSC/nKvrykndGuACHgDTcuWJe9yfXWDLg7HG6ywrMtZH3vmn0q9coZxlNCCqsMlHlf2Je0m/jPmTnNiHkz1w/pqPpaD79GhyX6ZPHrQ4pIHyg11fLGUrNekRMVa5cEFX1ix6iJ+UHE2Jm+cWT7TMBHnZjoip59vOqtPta5SJ5i6uqgGn20d6aCuU0Yezw39hf1cTODmXdGjKK3dZJ4xCdRIgnKW1Kgq7bIsQ/bEr5Sl/nPW3ayYuDQWKLTjTkNuECIjP5QmRVlBnb6h7XO8184EK6rfSZdFkUKs23u4c7SLQYfIRF5sEmDsErOMZOYJVL9MHLtqI8Rja0UQkhc6Kd14cqHO3iRZOxylk5A5WYpTv4wvjgMKN2BFlaAdk/hdwjlf9isOp+09FDINcrPNK7Buj8tbULE6zug7Zvumq4GH98sNAWoeiY+KBzHGF33U8kiAjpNuYotVRni0leA0UkBG0qAHbT0HD9K+gL7vmRpDH8W1eBswIXrghcS4AvgQ9XjbS22bf/zFwExpwqXqzweRnAJ86MR2IzCCfEvIT5xItXE6paUeuYfye6Q6clTdTdOWFLwUoQLsxan1wFpU2J7pnNzauzO86MwBbPF9VzC5JXyz8oEJR1c0qILTSs6OH4p1wVw2ZNAMtqUUUufsAOQqxifD7EGxWk0ZH/x6DuU5pyLAKzTqtrwHF2yNRhvO
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB4260.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(346002)(366004)(376002)(136003)(396003)(39860400002)(53546011)(38070700005)(186003)(76116006)(5660300002)(66556008)(316002)(110136005)(66476007)(66446008)(64756008)(2906002)(8936002)(8676002)(4326008)(66946007)(52536014)(55016003)(7696005)(478600001)(41300700001)(71200400001)(26005)(6506007)(38100700002)(9686003)(86362001)(122000001)(33656002)(83380400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?3ytuvJDzpi2sTvznqQLSa2dp0GbXnRZx1C1nmQRn6OQJhI/pQHA2iazHA4kR?=
 =?us-ascii?Q?TGJswgFpQqaKtsyq5CWQSBPLa7+ry6UNUTgdUkRjdNoCjq3T92FMWIMRsMiL?=
 =?us-ascii?Q?u9wIN/t3cLShIodrqP9/Wzpg/xzqR1102x8cJjpv+TsiKCjgLP8vD9RBLhQg?=
 =?us-ascii?Q?sf05y0GMM7y4JMMY1b+MNwXzudquHctwRrmqyESFpaOSQlCyCaK+PuFievar?=
 =?us-ascii?Q?x0FhU5efu9gmj9/kWY/z3335nZCHXnciI9zKdOErrM0XUUraPk1e1GufT585?=
 =?us-ascii?Q?loSjprc/BB/IiwefgJQhDvMIHaBS1Cr1Zhx02z2qMss+9M3SZ5cfY2kUtEfh?=
 =?us-ascii?Q?3+UaM4fzT6dU7DLki0qx08Pig50GPHYOVMceeED27N0VWh71Iw1ql7R4ZyS5?=
 =?us-ascii?Q?LdLneCnFhpkDm05O1jUfnL8zaCAV73Y8e0OnixxSLff9vutIVKDF/Ek4wuXi?=
 =?us-ascii?Q?EKmiUjq35gqBB7/z8kOKQagfM/rwkKF79JdlUpwJy/waXY9h8WfKkQxq0mlD?=
 =?us-ascii?Q?EJQRZd5QLEF1rqBhEzLDSlHPKlxhSYjoR3zETV3BizGKW8rjI7wIpr/sVGqM?=
 =?us-ascii?Q?rpTxKf0nlz7QHWJ4BMxB4n/gPyyxtqGGr7j6K5yUrmb6Z59yxeyaRGG81wQT?=
 =?us-ascii?Q?FknuwA2v6CuMRAjscmhnHt43YW1u1KbJcRRrysOSWGDAyELA2E++jj0c6nuU?=
 =?us-ascii?Q?kL5y5dQYbqi7eGwlH259iBoLT0lvavJ3h3rTduL8cIaJtO2nahYuW9KfCJUs?=
 =?us-ascii?Q?V1R7hHhBhquzOdOpk8yVo5VWKXYdRPbC8StGOMqc7uMgdVDia28Du6bYE2ks?=
 =?us-ascii?Q?EXNoiohn4Zj9nnv2KimAzuoML7Z+de6r7WReGJk7SG8xs6KKvW6Sqlj/SZY6?=
 =?us-ascii?Q?lAos3ORQbnwxf8rGEIkRQPCjfoIaNFPZLI2LDWOQJ0OymDfH8wma6E7vJFVk?=
 =?us-ascii?Q?KtKTbMqSzGH0Ly7SCUqGmkulD9JTsbxeCqDtBs+XYusY0ufuJsWWswTRYXqY?=
 =?us-ascii?Q?v9C1XDsB+j6aR20zG12Y7XcYo3aam5yOyBWv+F+xZttVdAYoNsGRXKHyUmvf?=
 =?us-ascii?Q?jcyxkPNd9nL9fDwDX56D57rRhgDJ83v4GnFCWc+xEJKJPfcweIDVZ8c205ur?=
 =?us-ascii?Q?yaslzKzowpv38zHyOqtmQ6PgatG4hMC6k2WrvQVJngvq0gvDETDKxsajGFGE?=
 =?us-ascii?Q?G2fkLktu6MQSeCSsp14kc6NMN8rAyetgl3RqI99oJ9Tciw/Yb/y+NiHF94QZ?=
 =?us-ascii?Q?fqBDGe5COr1DwFNubq9SIt6nBajCU4MmtPcG8nwenM2ur7tP60jDB9QtPe2k?=
 =?us-ascii?Q?Iw9pW4Tyifwqagq+0jsQqzwZzwLu2q660KP/a/ERBBGxT18Li65kHfpNA9Nj?=
 =?us-ascii?Q?X3VW0xMPiDKkVagetoeF/hEMp0/HwrhukWsB/uGnynHb0X+IQ6ZdciNYOmnO?=
 =?us-ascii?Q?hn5cdkmJymIWuLpcOMmKJIlIlX0zzjiR0VRwedvFUa6CobktFX2iFjF2xBFW?=
 =?us-ascii?Q?oGi4LjMhrtYNdEgginFktW9kVrLCODxmORNSm3TrT1Wn8IaYaY82LB6qWCwp?=
 =?us-ascii?Q?KfqFlh6blqn00PIFWJ8=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BY5PR12MB426064BCC7DC38C5B8AF7CABED629BY5PR12MB4260namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4260.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 404c5405-5e38-46c6-7c1e-08da79f90e1b
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Aug 2022 11:19:41.6533 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: E3PQ/Dp3vpG0KB/pp1fx+IPvq4iWuBhCHftiZ9WYJZTWGCHRt66oNPrx3/C/h2TUAWUscH0Yor5krFVH5Tfzyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3822
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
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_BY5PR12MB426064BCC7DC38C5B8AF7CABED629BY5PR12MB4260namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - General]

Hello all,

I just checked this with 1200ms for timeout, test case successfully passed =
10 loops.
If all of you agree, I will change a value in the patch.

Regards,
Dusica

From: Liu, Shaoyun <Shaoyun.Liu@amd.com>
Sent: Tuesday, August 9, 2022 12:31 AM
To: Alex Deucher <alexdeucher@gmail.com>; Milinkovic, Dusica <Dusica.Milink=
ovic@amd.com>
Cc: amd-gfx@lists.freedesktop.org
Subject: Re: [PATCH] Increase tlb flush timeout for sriov

As I discussed with Alice ,this change is when multi-vf running compute ben=
chmark (Luxmark) at the same time, which involves multiple vf  do the tlb i=
nvalidation at the same time. They observed kiq timeout after submit the tl=
b invalidate command. Although each vf has the invalidate register set, but=
 from hw, the invalidate requests are queue to execute.

Alice, as we discussed, we can use maximum 12*100ms for the timeout , it sh=
ouldn't be 6000ms. Did you see issues with 1200 ms timeout?

Regards
Shaoyun.liu
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org<mailto:amd-gfx-bounces=
@lists.freedesktop.org>> on behalf of Alex Deucher <alexdeucher@gmail.com<m=
ailto:alexdeucher@gmail.com>>
Sent: August 8, 2022 4:49 PM
To: Milinkovic, Dusica <Dusica.Milinkovic@amd.com<mailto:Dusica.Milinkovic@=
amd.com>>
Cc: amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org> <am=
d-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>>
Subject: Re: [PATCH] Increase tlb flush timeout for sriov

On Wed, Aug 3, 2022 at 5:02 AM Dusica Milinkovic
<dusica.milinkovic@amd.com<mailto:dusica.milinkovic@amd.com>> wrote:
>

Please include a patch description.  Why do you need a longer timeout?
 What problem does it fix?

> Signed-off-by: Dusica Milinkovic <dusica.milinkovic@amd.com<mailto:dusica=
.milinkovic@amd.com>>
> ---
>  drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c | 6 +++++-
>  drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c  | 6 +++++-
>  2 files changed, 10 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd=
/amdgpu/gmc_v10_0.c
> index 9ae8cdaa033e..6ab7d329916f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> @@ -419,6 +419,7 @@ static int gmc_v10_0_flush_gpu_tlb_pasid(struct amdgp=
u_device *adev,
>         uint32_t seq;
>         uint16_t queried_pasid;
>         bool ret;
> +       uint32_t sriov_usec_timeout =3D 6000000;  /* wait for 12 * 500ms =
for SRIOV */
>         struct amdgpu_ring *ring =3D &adev->gfx.kiq.ring;
>         struct amdgpu_kiq *kiq =3D &adev->gfx.kiq;
>
> @@ -437,7 +438,10 @@ static int gmc_v10_0_flush_gpu_tlb_pasid(struct amdg=
pu_device *adev,
>
>                 amdgpu_ring_commit(ring);
>                 spin_unlock(&adev->gfx.kiq.ring_lock);
> -               r =3D amdgpu_fence_wait_polling(ring, seq, adev->usec_tim=
eout);
> +               if (amdgpu_sriov_vf(adev))
> +                       r =3D amdgpu_fence_wait_polling(ring, seq, sriov_=
usec_timeout);
> +               else
> +                       r =3D amdgpu_fence_wait_polling(ring, seq, adev->=
usec_timeout);

What about something like this?
u32 usec_timeout =3D amdgpu_sriov_vf(adev) ? 6000000 :
adev->usec_timeout;  /* wait for 12 * 500ms for SRIOV */
...
r =3D amdgpu_fence_wait_polling(ring, seq, usec_timeout);


>                 if (r < 1) {
>                         dev_err(adev->dev, "wait for kiq fence error: %ld=
.\n", r);
>                         return -ETIME;
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/=
amdgpu/gmc_v9_0.c
> index 22761a3bb818..941a6b52fa72 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> @@ -896,6 +896,7 @@ static int gmc_v9_0_flush_gpu_tlb_pasid(struct amdgpu=
_device *adev,
>         uint32_t seq;
>         uint16_t queried_pasid;
>         bool ret;
> +       uint32_t sriov_usec_timeout =3D 6000000;  /* wait for 12 * 500ms =
for SRIOV */
>         struct amdgpu_ring *ring =3D &adev->gfx.kiq.ring;
>         struct amdgpu_kiq *kiq =3D &adev->gfx.kiq;
>
> @@ -935,7 +936,10 @@ static int gmc_v9_0_flush_gpu_tlb_pasid(struct amdgp=
u_device *adev,
>
>                 amdgpu_ring_commit(ring);
>                 spin_unlock(&adev->gfx.kiq.ring_lock);
> -               r =3D amdgpu_fence_wait_polling(ring, seq, adev->usec_tim=
eout);
> +               if (amdgpu_sriov_vf(adev))
> +                       r =3D amdgpu_fence_wait_polling(ring, seq, sriov_=
usec_timeout);
> +               else
> +                       r =3D amdgpu_fence_wait_polling(ring, seq, adev->=
usec_timeout);

Same comment here.

Alex

>                 if (r < 1) {
>                         dev_err(adev->dev, "wait for kiq fence error: %ld=
.\n", r);
>                         up_read(&adev->reset_domain->sem);
> --
> 2.25.1
>

--_000_BY5PR12MB426064BCC7DC38C5B8AF7CABED629BY5PR12MB4260namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<!--[if !mso]><style>v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
w\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style><![endif]--><style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
span.EmailStyle19
	{mso-style-type:personal-reply;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"#0563C1" vlink=3D"#954F72" style=3D"word-wrap:=
break-word">
<p style=3D"font-family:Arial;font-size:10pt;color:#0000FF;margin:5pt;" ali=
gn=3D"Left">
[AMD Official Use Only - General]<br>
</p>
<br>
<div>
<div class=3D"WordSection1">
<p class=3D"MsoNormal">Hello all, <br>
<br>
I just checked this with 1200ms for timeout, test case successfully passed =
10 loops.<br>
If all of you agree, I will change a value in the patch.<br>
<br>
Regards, <br>
Dusica<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> Liu, Shaoyun &lt;Shaoyun.Liu@amd.com&gt=
; <br>
<b>Sent:</b> Tuesday, August 9, 2022 12:31 AM<br>
<b>To:</b> Alex Deucher &lt;alexdeucher@gmail.com&gt;; Milinkovic, Dusica &=
lt;Dusica.Milinkovic@amd.com&gt;<br>
<b>Cc:</b> amd-gfx@lists.freedesktop.org<br>
<b>Subject:</b> Re: [PATCH] Increase tlb flush timeout for sriov<o:p></o:p>=
</p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<p class=3D"MsoNormal">As I discussed with Alice ,this change is when multi=
-vf running compute benchmark (Luxmark) at the same time, which involves mu=
ltiple vf&nbsp; do the tlb invalidation at the same time. They observed kiq=
 timeout after submit the tlb invalidate
 command. Although each vf has the invalidate register set, but from hw, th=
e invalidate requests are queue to execute.
<o:p></o:p></p>
</div>
<div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
<div>
<p class=3D"MsoNormal">Alice, as we discussed, we can use maximum 12*100ms =
for the timeout , it shouldn't be 6000ms. Did you see issues with 1200 ms t=
imeout?<o:p></o:p></p>
</div>
<div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
<div>
<p class=3D"MsoNormal">Regards<o:p></o:p></p>
</div>
<div>
<p class=3D"MsoNormal">Shaoyun.liu<o:p></o:p></p>
</div>
<div class=3D"MsoNormal" align=3D"center" style=3D"text-align:center">
<hr size=3D"2" width=3D"98%" align=3D"center">
</div>
<div id=3D"divRplyFwdMsg">
<p class=3D"MsoNormal"><b><span style=3D"color:black">From:</span></b><span=
 style=3D"color:black"> amd-gfx &lt;<a href=3D"mailto:amd-gfx-bounces@lists=
.freedesktop.org">amd-gfx-bounces@lists.freedesktop.org</a>&gt; on behalf o=
f Alex Deucher &lt;<a href=3D"mailto:alexdeucher@gmail.com">alexdeucher@gma=
il.com</a>&gt;<br>
<b>Sent:</b> August 8, 2022 4:49 PM<br>
<b>To:</b> Milinkovic, Dusica &lt;<a href=3D"mailto:Dusica.Milinkovic@amd.c=
om">Dusica.Milinkovic@amd.com</a>&gt;<br>
<b>Cc:</b> <a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.f=
reedesktop.org</a> &lt;<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd=
-gfx@lists.freedesktop.org</a>&gt;<br>
<b>Subject:</b> Re: [PATCH] Increase tlb flush timeout for sriov</span> <o:=
p></o:p></p>
<div>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
</div>
</div>
<div>
<div>
<p class=3D"MsoNormal">On Wed, Aug 3, 2022 at 5:02 AM Dusica Milinkovic<br>
&lt;<a href=3D"mailto:dusica.milinkovic@amd.com">dusica.milinkovic@amd.com<=
/a>&gt; wrote:<br>
&gt;<br>
<br>
Please include a patch description.&nbsp; Why do you need a longer timeout?=
<br>
&nbsp;What problem does it fix?<br>
<br>
&gt; Signed-off-by: Dusica Milinkovic &lt;<a href=3D"mailto:dusica.milinkov=
ic@amd.com">dusica.milinkovic@amd.com</a>&gt;<br>
&gt; ---<br>
&gt;&nbsp; drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c | 6 +++++-<br>
&gt;&nbsp; drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c&nbsp; | 6 +++++-<br>
&gt;&nbsp; 2 files changed, 10 insertions(+), 2 deletions(-)<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/=
amd/amdgpu/gmc_v10_0.c<br>
&gt; index 9ae8cdaa033e..6ab7d329916f 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c<br>
&gt; @@ -419,6 +419,7 @@ static int gmc_v10_0_flush_gpu_tlb_pasid(struct am=
dgpu_device *adev,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t seq;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint16_t queried_pasid=
;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool ret;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t sriov_usec_timeout =3D =
6000000;&nbsp; /* wait for 12 * 500ms for SRIOV */<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_ring *ri=
ng =3D &amp;adev-&gt;gfx.kiq.ring;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_kiq *kiq=
 =3D &amp;adev-&gt;gfx.kiq;<br>
&gt;<br>
&gt; @@ -437,7 +438,10 @@ static int gmc_v10_0_flush_gpu_tlb_pasid(struct a=
mdgpu_device *adev,<br>
&gt;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_commit(ring);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; spin_unlock(&amp;adev-&gt;gfx.kiq.ring_lock);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; r =3D amdgpu_fence_wait_polling(ring, seq, adev-&gt;usec_ti=
meout);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; if (amdgpu_sriov_vf(adev))<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgp=
u_fence_wait_polling(ring, seq, sriov_usec_timeout);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; else<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgp=
u_fence_wait_polling(ring, seq, adev-&gt;usec_timeout);<br>
<br>
What about something like this?<br>
u32 usec_timeout =3D amdgpu_sriov_vf(adev) ? 6000000 :<br>
adev-&gt;usec_timeout;&nbsp; /* wait for 12 * 500ms for SRIOV */<br>
...<br>
r =3D amdgpu_fence_wait_polling(ring, seq, usec_timeout);<br>
<br>
<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; if (r &lt; 1) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; d=
ev_err(adev-&gt;dev, &quot;wait for kiq fence error: %ld.\n&quot;, r);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r=
eturn -ETIME;<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/a=
md/amdgpu/gmc_v9_0.c<br>
&gt; index 22761a3bb818..941a6b52fa72 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c<br>
&gt; @@ -896,6 +896,7 @@ static int gmc_v9_0_flush_gpu_tlb_pasid(struct amd=
gpu_device *adev,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t seq;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint16_t queried_pasid=
;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool ret;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t sriov_usec_timeout =3D =
6000000;&nbsp; /* wait for 12 * 500ms for SRIOV */<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_ring *ri=
ng =3D &amp;adev-&gt;gfx.kiq.ring;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_kiq *kiq=
 =3D &amp;adev-&gt;gfx.kiq;<br>
&gt;<br>
&gt; @@ -935,7 +936,10 @@ static int gmc_v9_0_flush_gpu_tlb_pasid(struct am=
dgpu_device *adev,<br>
&gt;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_commit(ring);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; spin_unlock(&amp;adev-&gt;gfx.kiq.ring_lock);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; r =3D amdgpu_fence_wait_polling(ring, seq, adev-&gt;usec_ti=
meout);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; if (amdgpu_sriov_vf(adev))<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgp=
u_fence_wait_polling(ring, seq, sriov_usec_timeout);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; else<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgp=
u_fence_wait_polling(ring, seq, adev-&gt;usec_timeout);<br>
<br>
Same comment here.<br>
<br>
Alex<br>
<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; if (r &lt; 1) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; d=
ev_err(adev-&gt;dev, &quot;wait for kiq fence error: %ld.\n&quot;, r);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u=
p_read(&amp;adev-&gt;reset_domain-&gt;sem);<br>
&gt; --<br>
&gt; 2.25.1<br>
&gt;<o:p></o:p></p>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_BY5PR12MB426064BCC7DC38C5B8AF7CABED629BY5PR12MB4260namp_--
