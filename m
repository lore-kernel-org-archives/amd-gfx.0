Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFBD4CE79AF
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Sep 2023 09:58:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7A8AA10E16E;
	Wed, 20 Sep 2023 09:58:04 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2060f.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e88::60f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3ADF310E16E
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Sep 2023 09:58:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=muxU7AajEMlmFbMfcjtR3vU7ko+y+Hz+dgvgZzajPDvoL3Tipr3Kj4M4cO+aidmS0tgK4bj2Bw4mQ698pMV6UBVktfBnGI0Bf0WbhhHb486fqnnbPPENgizMmh/S4OD6XMALnTYJKTkRXnVp23Rpzyx666lIamVQ0wyDgfW0HKc47w5lmxi94Va9+YKCK3Y3FIoTunAPmgZhk4IdHa6x6CQyqOABxr8E8GCwn2u/f8C70NfvJ5DJiILMpwAjGJmRrDhnmJhZBTl9jVdMXwedb7mdLuxT/Qo12g28rmt3dJB/uNyz+nL4cP4E3DiJRBnDpCzSL90Goh+LES1ZMLULVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UEny59kXEZo9bF3b0lbGMY0We5HBm6yfYUdk7f76yJc=;
 b=VOTtGuwjnY4qM4osT8puZPIgewDb2XbHynZ4EFZ959cXsx4EtgzjXERlfuw4KBbJ6aNPK5JGpFnyaFqhCEbnpwTeo3EZNgA+7wZ+4tMCHSORKjMdUnhIZ5KVz4nX8D/+YE/Tp+CD8EHZX/UQYsX3XiPy4CGtozooRGPO37JfN4AcP9K+Amln05zvHyfyTtWr73djrmmm0Moy40nEdiMKPRH810AGn0OPgbS4Hm9d+aaD2oAB7sL6rCGsPdn8LwRe44V3W5V1gMrGfvDjbdilsqCcylksf/tVSWR3086kLW0vaXzzcxlyEJkvfixk3p3nLWeKGSZTzLQ0rvb/S4JIkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UEny59kXEZo9bF3b0lbGMY0We5HBm6yfYUdk7f76yJc=;
 b=PRXtTPS7j9kdLNhzsth5muJskSXzr2rKAaQwidHVZA1n2426YYIyjnSCD7oa9pAhDI4HsGTzizn4PkTRoznkjZQZvjGszwRrB7xeOY25zXYmHuGIuOhzpPqhBw+i4cJevI/D673GByKQuAL19xB1xUcNzUhNpRmhTjzLaApQNkA=
Received: from PH7PR12MB5997.namprd12.prod.outlook.com (2603:10b6:510:1d9::21)
 by MN0PR12MB6200.namprd12.prod.outlook.com (2603:10b6:208:3c3::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.28; Wed, 20 Sep
 2023 09:57:59 +0000
Received: from PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::734d:d070:e2db:de7a]) by PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::734d:d070:e2db:de7a%7]) with mapi id 15.20.6768.029; Wed, 20 Sep 2023
 09:57:59 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu/gmc11: disable AGP on GC 11.5
Thread-Topic: [PATCH] drm/amdgpu/gmc11: disable AGP on GC 11.5
Thread-Index: AQHZ6wb0GyoJbP9aJEKiPgrygRB7j7Ajdqfw
Date: Wed, 20 Sep 2023 09:57:59 +0000
Message-ID: <PH7PR12MB5997FA25F37B4C1F6C005E6482F9A@PH7PR12MB5997.namprd12.prod.outlook.com>
References: <20230919143734.2618529-1-alexander.deucher@amd.com>
In-Reply-To: <20230919143734.2618529-1-alexander.deucher@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=7a43f0bc-d85c-4907-9eef-c31514459085;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-09-20T09:39:30Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB5997:EE_|MN0PR12MB6200:EE_
x-ms-office365-filtering-correlation-id: 1f12ddc2-8613-4ccd-5ae2-08dbb9c01221
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yQWzhTtIr4ShvpLdPVMO/Das3iATAVYmMpKWw53X/0TvzHGSLStN1Ch+Cb+UGsfnwjjQXn8DL/qjbO5ftIHmvuX90A36Z8HKvQBIEEWi04BTsHScr/qskJEVcRePBN503Gs5q35A5J2POXkF6h26OeVZCozA3SjK9PlK+dyNGkgYssoYTd1jkQN3aMLs8TaIUqM7ddbvyYiH9Zr6A6VvsvSszlyL8DUz6zwnzUDc/T1cRbWg2nDsxRSgqfDYwqlNpDVzMgObK/inqkWZbrKzVPC4R8w6/FDH64em361EBBeDPxVSSORelg4PHTYZxtkaPqiaTc0bohOmUBUYhuCrd5XRlc8aDkNSAEsG1luJMaZqX+xnpfVBDf155JzPb14KaQ+2Iuh3AVw6ZKCrqA5TAPcmhPeHAvJjwzdxirbM/hEoFU/zZ3W42uIUY/J6EIcSTQfIsBwoYONaY9WTYivix8f7KeE2QPOGQ6+2qr6MKhY2W934LNQPcefIh/tuFifweCyxE8750xS17bstzqMo3eUJTnWymrXIwd/UyTBOY7TJ1wgFmYxY1ZS7NNc3wNKlMjOguTtkjjtaZp8io08im+2psMJn6ME32Z3vkyYd7WaOM4Zi6qEXU9Okojg4/5A+
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5997.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(366004)(346002)(136003)(396003)(39860400002)(186009)(1800799009)(451199024)(7696005)(6506007)(53546011)(9686003)(71200400001)(478600001)(83380400001)(26005)(4326008)(2906002)(76116006)(66476007)(66556008)(64756008)(66446008)(316002)(66946007)(110136005)(8676002)(52536014)(5660300002)(8936002)(41300700001)(55016003)(38100700002)(33656002)(38070700005)(86362001)(122000001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?XRVqVK2yXF59SIs0W9N85nNXuDBtnA4A162SlSf5KTDeWM8mBF86eUNdoFHc?=
 =?us-ascii?Q?XbMfnkLYiMaHAsUsCr+DAqudEPrZEvqXl3z4oB5Um6ihSM0iTKM32uB60g9u?=
 =?us-ascii?Q?QbgWIAa9RajnnjjEXcfLboS8YgQR1bVGyTUxsFTSoXba2ptlRKnxTguXCzEU?=
 =?us-ascii?Q?pwJK9bW3RNOlShR/Zya0vOPfs6m4H1sdo9nCtIvhEDoD4idDp/TgP7rnhsjn?=
 =?us-ascii?Q?C3j8fIPB9/TuHg84siikMJx7kIk8/AcfdgsKv1UI6OYxJODHDe425KTbDStN?=
 =?us-ascii?Q?tOEJgApgM5zkVguZyiu4dhYSgi6E81mBtHJr6IbO+WrVme3jzOOAlwvzGdc6?=
 =?us-ascii?Q?iHlNTok2XcKpQ8jR3v96bW1OFx3qIyiFlLoJZUmgJTVHEc6tDX636yX3+Vlk?=
 =?us-ascii?Q?igoXNjo4Kj+to8ZcrGMXy7vXqMzK2gW/udg4Re4HWml24gVMTqsQ9a1Tohf0?=
 =?us-ascii?Q?JOZSK1Qpx0+0EnDeUTIe+Pv/XUI5AzulOxVdH0hsuC4HY1Pgrx2a8l+DYndQ?=
 =?us-ascii?Q?aeYO281wpxSROqD5XZkjn57Sgp9nRHPAHDebE/wZSc60EjrFYKBfiOvbm7DU?=
 =?us-ascii?Q?i0utV7nQt0aMi9/nvgg1WZaO3ZzFh0i2nWAFLVXLtv29hpVn/lt/n/P95DPf?=
 =?us-ascii?Q?agb+Aem5iwQRXswWuQpINjpeMHIpGRf58WpH2aC6131E5dtAzeFeOOnJpyNm?=
 =?us-ascii?Q?HanJLGERzZg2jh0zv/1hQwpeRN1B1WJHCgP5ezX8F49f+C5jrk2g+KF1EoZ5?=
 =?us-ascii?Q?oOVOnMRwpLYNBbVJFp3IydUsQayb6hY/e37xhs6pWDdSpnrEtwj0vepQYDh7?=
 =?us-ascii?Q?HisLrO0no/ejLBSlXBem0oVO7DU/y3fXRo/UfyLIqyUF2grQ19QaiRuETo33?=
 =?us-ascii?Q?w9QwZPIys71SleCs+P5Qv2LN+0QB1Q7NZReRuNiFCybt+AgHcrxEDB/95RlH?=
 =?us-ascii?Q?Ujj4lOjF1PCoeSoDG8FCCF0W8IaSlMOmXZ/Hl9yaZt2aRHhaZboW9FlEAnsE?=
 =?us-ascii?Q?NeCBEp++QDDVOXQsOqlhaGTaF9MR2C/3KZnMIwUF+UF6FQoTqZB3Am8m1jRQ?=
 =?us-ascii?Q?mrcqIKepSSgsZ6tZM6bF4YFkCHeFRxIQSMgcOq6jd8l301t12EoTzYNxm8z1?=
 =?us-ascii?Q?euUcB+YByR+YGCJTUpRhOoKJwMoFWKDXuEX/9Q2FzJMU6m2nL9ZShG0XNsmp?=
 =?us-ascii?Q?krXv7iYo1r5GskBO6x/zkSwiL/uLQF72P/spZf8THf85XvcCim0X78utpHzg?=
 =?us-ascii?Q?nayRWfaN+ELxuxj7CptNQFVf5Lx1r5djmijeU2v2OIGgAp7CS/VoPEC4WVzM?=
 =?us-ascii?Q?81AqRr/XbNcMGcCrP0F9Rkfodyx1kHn43O04MH8ar3D2bgDQBeYCc94XiPZS?=
 =?us-ascii?Q?1g+Y3nRx2vJfeLcFGMLQhmvxNz7IJjXf0PEwYewi2xYhrDfHfTRQFSNua94e?=
 =?us-ascii?Q?3nJKJDwD+OG3dvHzy28tBwjKWaB6z/YDhtDWt/QPuoBsbxurNHX37kLscT8k?=
 =?us-ascii?Q?60DPWWfJ5wiWReeEaAOmDAa+OCg/Up3pARvJW3MmDcNIt/L4sLLVY43X6nsY?=
 =?us-ascii?Q?6Pj+wyZGpN0//PW3gJ8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5997.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f12ddc2-8613-4ccd-5ae2-08dbb9c01221
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2023 09:57:59.1709 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Y5zkZHI643InBlMVZV9TtfpJg6Mlgg98XicTnKRhpSPWWy/yCHoRhPNqOC2lHSGS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6200
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Hi Alex,

Does driver also need to disable AGP aperture in hardware side ? (Set regis=
ter GCMC_VM_AGP_BOT/TOP to make AGP address range invalid).
The current changes only make the GPU not use AGP range addresses, but the =
hardware unit of AGP's aperture is still working.
There seems to be some hidden danger here, if the generates GPU an illegal =
address, then GPU can access it.

Ref commit: 81c274c473a2 drm/amdgpu: disable agp for sriov

Best Regards,
Kevin

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex Deu=
cher
Sent: Tuesday, September 19, 2023 10:38 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: [PATCH] drm/amdgpu/gmc11: disable AGP on GC 11.5

AGP aperture is deprecated and no longer functional.

v2: fix typo (Alex)
v3: just skip the agp setup call

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/a=
mdgpu/gmc_v11_0.c
index 69f65e9c4f93..01cff4a3d4b1 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
@@ -689,7 +689,8 @@ static void gmc_v11_0_vram_gtt_location(struct amdgpu_d=
evice *adev,

        amdgpu_gmc_vram_location(adev, &adev->gmc, base);
        amdgpu_gmc_gart_location(adev, mc);
-       amdgpu_gmc_agp_location(adev, mc);
+       if (amdgpu_ip_version(adev, GC_HWIP, 0) < IP_VERSION(11, 5, 0))
+               amdgpu_gmc_agp_location(adev, mc);

        /* base offset of vram pages */
        if (amdgpu_sriov_vf(adev))
--
2.41.0

