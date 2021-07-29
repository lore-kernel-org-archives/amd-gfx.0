Return-Path: <SRS0=5qjI=MV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E399C4338F
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Jul 2021 01:33:43 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BEA166101C
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Jul 2021 01:33:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org BEA166101C
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 429BC6E487;
	Thu, 29 Jul 2021 01:33:42 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2046.outbound.protection.outlook.com [40.107.243.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CF8156E487
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Jul 2021 01:33:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N2ioSkjvuqIFfHdVDrtl3KU6hT7jjSR1uEujO3ToQ40T4+khi7QLmZZvOnev0BLnfaB2XEVZUjscDZ/kplSI6tjHQhkkX3UmXLJQ5iu1vy1peMI8I/wdIBdxXx+eLTZWzGAZxxAHz1XlxW6D401Uy3BPGHU7nHZEp61FY2cWzZ9ehgFdY/fUTXEwl11foEAAUA4LogXyv7YHBKPQPVVKtvz3vm3//sk7JV3acFh1yfUxq3hi3M5hwXKCK6foRi5DdeM2qXPqV5ZIXCUSkboMOs3tDBT4atYhHKMn4rxqTKtFEpQG/ReGA1jVDQycRvl5IENh+4849/SKI1RIcbchrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iWMWebeRXhLnyljxHelqZKYA2TA1XiyhWeyrgYatbIA=;
 b=mUnwa64oSDMOX9BfMYtm4XrAl3Q7zGaXcvz1O16GpXsPGD8Yon/ZWkXKsZwS3WSqvVzOUUaYouNqbVOY6S66SAHeRhTnxzJCNQeaKbLNH/Q104UjS4hoF7zXQwUFAGXPezqeRTUOKUapkaFS6b+2IQ333ng0IAuEnPbUBnaRNQU6B56HVcsjilIlo1SUbfNH66eaObUrczad42r8Ao/yMIfPnsxceZL18fKoZkNrBO0sYj//9BwJtqBT+A3fLJw6dkSO6W6cFRIcHTiSwm892n5WyRr+w4gniIi2H/lD29b7YYA7CME47/CrBky77Qlyja541OAY1B49hesJKw60iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iWMWebeRXhLnyljxHelqZKYA2TA1XiyhWeyrgYatbIA=;
 b=JbCIK5v6uSbPgF2n3Rl0H7fdSE118euaV/7Tj7EtzxFxqYPWbYVVTNphi9+RYgljI0JI9I+9VQKjo1bQ3zFnXXR9xeVaI0B+suXcw7/7P8wEAwSJ4cthWTjRbDxCeIwO+EvF7mjaMMmMr6AIAFWX9WU4YSd1Zljn8lLFmQpVs8k=
Received: from BYAPR12MB3416.namprd12.prod.outlook.com (2603:10b6:a03:ac::10)
 by BYAPR12MB2776.namprd12.prod.outlook.com (2603:10b6:a03:67::31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.17; Thu, 29 Jul
 2021 01:33:36 +0000
Received: from BYAPR12MB3416.namprd12.prod.outlook.com
 ([fe80::f5f9:93c:a602:61ff]) by BYAPR12MB3416.namprd12.prod.outlook.com
 ([fe80::f5f9:93c:a602:61ff%7]) with mapi id 15.20.4373.021; Thu, 29 Jul 2021
 01:33:36 +0000
From: "Zhang, Yifan" <Yifan1.Zhang@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>
Subject: RE: [PATCH v2] drm/amdgpu: fix the doorbell missing when in CGPG
 issue for renoir.
Thread-Topic: [PATCH v2] drm/amdgpu: fix the doorbell missing when in CGPG
 issue for renoir.
Thread-Index: AQHXg3dCKMUfZnH4u0W53sQJbTf2D6tYZtCAgADCkNA=
Date: Thu, 29 Jul 2021 01:33:36 +0000
Message-ID: <BYAPR12MB3416560A44B08B69871F64FFC1EB9@BYAPR12MB3416.namprd12.prod.outlook.com>
References: <20210728061018.2512047-1-yifan1.zhang@amd.com>
 <CADnq5_Oc-TY9e9=wEnhY7mgV8gBpxM=qPSwomW4ceQ-ondngGw@mail.gmail.com>
In-Reply-To: <CADnq5_Oc-TY9e9=wEnhY7mgV8gBpxM=qPSwomW4ceQ-ondngGw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a721b3c8-9ca3-4023-c11f-08d95230e2c5
x-ms-traffictypediagnostic: BYAPR12MB2776:
x-microsoft-antispam-prvs: <BYAPR12MB2776958800F799B29887B31DC1EB9@BYAPR12MB2776.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2331;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Wp5VTsnK3/mrxzVEkshOcYbjRqGGKebJR8TLO9lyYiNj05Md5DILey3r/jMfTnFFQSPz6YVlW3D1R74qN/SKlF26hsR/ZabuoIMvDU6zCTlyhqbdDADg1akQewZXNkrjlfZR/7MnZM4KpQqOQkEvkUvSb6JZfHfQkjVQTJhxD36cs6m1D9T+NI+goIvwz3jiBDUur599Zar9Vm9pRGSTfOJRKkGp834S3mbdz7LAPAl7TACHB0qXm2U7yR9O9GuNsVsRi+T6zoTIAbaqem1NHCnhPaiqO59d9ZVenhJCDqRaQg9YnfbpsXk8V49x9bBSailJQh0V30IwHGI/0H2DQ7VNWdS1F84jEoVcpPWbXlaYCFKicUQiLnCLIeDiuJsXEQJZERrBIwBzzRTKaCiUAKhxolYt6EUP1aSpo8F8amraAGhyrC/vvWSMrsxxm+Lx2qqwDs6CrAHJehvvQGaZJXu50T0bETrbNsPLsrd5rMBEHUO5A9X6UTCMI81cDd6sw7biubGAM3QRNa5MOHfzJxsucx8/6336ylqfHl95oLXAqgaX7tu+ZzxYjnnT3hasBzDbCnK6w2QzdlZA1baqB5SlFJVK1+zm2c12KeCxFUnmdWrrqtMdKUKdH7Babp7QwJ5moLJXFrYnbN2Y2msaGHU9BI6D3TFBzMYdj37VEjhOEGITqM1FbwCwI+AJaBg8YT1QKn+8FrOo+4iVxnfmexhPN7FyOtTOoARBsrRIUPgSegEjmM+d4clhl3b16kDncuf+C2qIuccWcSeBIW7Xbae459KLOITtSe2GzjThVBM=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB3416.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(136003)(366004)(396003)(346002)(39860400002)(66476007)(71200400001)(66446008)(38070700005)(64756008)(66556008)(6506007)(53546011)(316002)(2906002)(8936002)(45080400002)(76116006)(26005)(8676002)(4326008)(86362001)(186003)(966005)(38100700002)(122000001)(83380400001)(52536014)(478600001)(6916009)(5660300002)(66946007)(9686003)(55016002)(33656002)(7696005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?+LKlMpN4aqYmeheslK3t4b03UBzsF8JdquQlH0JF/pJGbw5Wwd25cfF4R6K7?=
 =?us-ascii?Q?lBtVsEi2Pj26IRbfqv0yCpKGeB1pPts5/bkluvSech5zt6NRQeshKdIOzI6l?=
 =?us-ascii?Q?61ZNwzAGtHy/9Usc33SnXQUGqPLVf+0IE5q9esFpbNPNl+xtIdTVscotdL8n?=
 =?us-ascii?Q?cfchJHbkLYlqO3IH9QvlOosGnAoBgGmSIblJHu1F5Ahrr3xj/uulsyaFLjRi?=
 =?us-ascii?Q?YmjoMRa9URc/TztywQi6Ay1VtZMumP5+4k66FSG9oipB3kyBIkWCkyK8nCfh?=
 =?us-ascii?Q?HuCOCEi22UsrGMu0hhKw0LFbftgRNbQRYn3r/mfpkG/UDagwjDNLDnqPvF5g?=
 =?us-ascii?Q?dRUv0qLLaHPzJLJDd93ZPriCrz43/B9KyJUv1PsDDQL37zTLWLQoR4+u1PbY?=
 =?us-ascii?Q?ilRpshwUBiwKnA229Fets0LNp6KELcDtIGjwJz2DUVMp4OU/cE/Ii7nzMX8T?=
 =?us-ascii?Q?PahCRYzma9xzYHi49k8xbZdfX8VdKdLkNTHoEtRAXP0Yy4qMIMvG2hW7qxZ1?=
 =?us-ascii?Q?d2YvRxebq3mJz3YyCE8QrVnEz+qVRPTYlHAdqWmAbqK9i9dKdN6r7VFn9/SO?=
 =?us-ascii?Q?afwTh8QM90Xg8r1jD8pvitQ5ZNlGGlG4XVpHhMSGT2nv7GMGa6O+kjISYScB?=
 =?us-ascii?Q?e6hCCHhW+O0743tGXGuWw7UwfTejeXjIyvuxpP4sUHFgyrDIwX6ani9F+yTa?=
 =?us-ascii?Q?kO+N7BZonzvJ0gF014tljUs3AvkyJIC+VwA+DuZ3hVV4/jbr1dbd08LAKsaa?=
 =?us-ascii?Q?vjur0R1vkHxXVitiyfdozxW00Y+WWB+bpAtAKH8i5FsrBIYkb+myOxvRJjXB?=
 =?us-ascii?Q?wqRcfIRcIEe+MkBpdumKwiRFM+SEZqNg9ZBIRUL8Llm5VydpxN83Mia6uJj0?=
 =?us-ascii?Q?lEsJJMzeRZoCFsWsxSJ6p6RQ7m7tIr944aLt3yO8LPW/MMFSkm9E82qLSFrI?=
 =?us-ascii?Q?fXC9Wt0kGoVAqWBq78qk7+2D309l1xFtj4HTYFLiJqj+j9tIa1pRbx8Sp6c4?=
 =?us-ascii?Q?+sbO0eVDvZoPhVkxNLcUV6fxgXUJ/nadJaPAHQPoc99XF8m4aaQqDGKXnE67?=
 =?us-ascii?Q?LphBMLvMD7gS7yATz9zDHi83PFfQ7nGUN1VzDSDBxIT+Q0V32now3TpOA7oy?=
 =?us-ascii?Q?SyJgOwBJCcVndbtjYtl2uikTVgGmKaH6dzKI6X5iAcq6o+v5khsTIoujYzUA?=
 =?us-ascii?Q?m1mmvN165xxXm1X/NPiQdxqmLfDJ8dg8Iw/DzYOtpoYdMHJwZJ47+hO/iMmM?=
 =?us-ascii?Q?G8FMcng0TTfqXkV03xZRKsJRbmRWl4VaiDevvzToSUipi6FE42aJtRagD8NT?=
 =?us-ascii?Q?arWdp6qCYCqoBv0T41Uk9b6L?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3416.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a721b3c8-9ca3-4023-c11f-08d95230e2c5
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jul 2021 01:33:36.4945 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BkCI/V9FTp2QV2OvrLO0N8X375g1f84xuN8oeFnxq0X4/q5pNRNdVr+ybF5BnfwS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2776
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
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi Alex,

No, it won't break gfxoff. The "gfxoff broken" issue we saw last time has been fixed on CP firmware update for Renoir, and this patch changes doorbell range setting specifically for Renoir, not covering the other ASICs. I think it is better to change doorbell range setting per ASIC to mitigate possible side effects.

BRs,
Yifan

-----Original Message-----
From: Alex Deucher <alexdeucher@gmail.com> 
Sent: Wednesday, July 28, 2021 9:46 PM
To: Zhang, Yifan <Yifan1.Zhang@amd.com>
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH v2] drm/amdgpu: fix the doorbell missing when in CGPG issue for renoir.

On Wed, Jul 28, 2021 at 2:10 AM Yifan Zhang <yifan1.zhang@amd.com> wrote:
>
> If GC has entered CGPG, ringing doorbell > first page doesn't wakeup GC.
> Enlarge CP_MEC_DOORBELL_RANGE_UPPER to workaround this issue.
>
> Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>

I assume this won't break gfxoff?  The last time we changed this, it broke a bunch of scenarios.  Won't this cause just about all doorbells to wake gfx?

Alex

> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c 
> b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> index 03acc777adf7..70b64b510743 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> @@ -3675,7 +3675,15 @@ static int gfx_v9_0_kiq_init_register(struct amdgpu_ring *ring)
>         if (ring->use_doorbell) {
>                 WREG32_SOC15(GC, 0, mmCP_MEC_DOORBELL_RANGE_LOWER,
>                                         (adev->doorbell_index.kiq * 2) << 2);
> -               WREG32_SOC15(GC, 0, mmCP_MEC_DOORBELL_RANGE_UPPER,
> +               /* In renoir, if GC has entered CGPG, ringing doorbell > first page
> +                * doesn't wakeup GC. Enlarge CP_MEC_DOORBELL_RANGE_UPPER to
> +                * workaround this issue.
> +                */
> +               if (adev->asic_type == CHIP_RENOIR)
> +                       WREG32_SOC15(GC, 0, mmCP_MEC_DOORBELL_RANGE_UPPER,
> +                                       (adev->doorbell.size - 4));
> +               else
> +                       WREG32_SOC15(GC, 0, 
> + mmCP_MEC_DOORBELL_RANGE_UPPER,
>                                         (adev->doorbell_index.userqueue_end * 2) << 2);
>         }
>
> --
> 2.25.1
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flist
> s.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7Cyi
> fan1.zhang%40amd.com%7C4a2605541c22483b4a3a08d951ce097c%7C3dd8961fe488
> 4e608e11a82d994e183d%7C0%7C0%7C637630767650055129%7CUnknown%7CTWFpbGZs
> b3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D
> %7C1000&amp;sdata=1TIsNslKHeSNNMDR3MHPaIiP%2BSLVrr5cEfAbCmvZlCw%3D&amp
> ;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
