Return-Path: <SRS0=4Sal=K5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DBDCC47096
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Jun 2021 15:10:51 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 38DAC60FF2
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Jun 2021 15:10:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38DAC60FF2
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E72DB6F495;
	Thu,  3 Jun 2021 15:10:50 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2065.outbound.protection.outlook.com [40.107.223.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2A63D6F495
 for <amd-gfx@lists.freedesktop.org>; Thu,  3 Jun 2021 15:10:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jJ2CKO6oJOLtj95yK2SF2DdWd3yIgv7UoVYdx0HJcGn9Qogs3fYnFPu+Ze0oKbAe5jILjama+mEKesRH/uCQuWhN93+FZQ5CAH5Dlitn/ByN57qNv6jjCMYKha/wf7Jv7BrGAqYrgmYjSw8XIRe3cZRAL4TE+A2T4fPtTsYM6S1RDyIvfh8voNW2suyAdcSdcBRaIBid31o6WQphmjCAWEyd9KdaUCir/oS15rphxk5jDGWnZVUWZ+0KxGVXMiCmW6fBMDx1tM/LT2q23E6RxvsTZYtJl5HJuOjYflL1eANaaVzTghWUs0qgLa6OMg4NIUIXcuDkQLOrt2LRIlzULg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WZU0PSXa3xktkZj0mR4jxojUVZTUYDtzUo0TYZzmBjI=;
 b=WfAHFu8d7x7nWxl00r/C7ZG3OTESQk8C9cl3KLFOK4ZUy3KZpYHqy/JcG3QQyZOZMmfhaOQf2ZW2dzzqr1Pf7t37NmkdhzWb0nh40lzF/9/EQEDXv1YRDI1R2cyvTQQDuHqcUK7d1QDWccyz5euFkKjqikCQ34mY4LAyqzOJRCpn7W/6wUxNHmLRSecpuXnvfNPV3vOJ63Jdfuok0DEJYs3XKKtgzQH68VE6jOInrAAc76BOUa28p1v+heK+GXtrUGlAgMSdEtSxQl/NzsT3/rwd1qxOZ361AgidLkPYnBsHEUwrwDBHgb9nlG1pFxssk0Nu9ZokL+xLmS35eRg/2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WZU0PSXa3xktkZj0mR4jxojUVZTUYDtzUo0TYZzmBjI=;
 b=3djoWDnOaVJis7G6zlcJ/DPIAJ5H1ghdsPGuYISKk4izJwS4EqvRrWtojFTt8AYnEmYns8FCSeefiWDEDzdFi2K9jDSc8dDErLZdTr5w1rU9K9fl5E/ulRpAFAolqDwWoK/dmdhTCkkTenGVDhI/m4lVmEEoj+YB6R6CD5mmCEE=
Received: from DM6PR12MB5534.namprd12.prod.outlook.com (2603:10b6:5:20b::9) by
 DM4PR12MB5214.namprd12.prod.outlook.com (2603:10b6:5:395::22) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4173.22; Thu, 3 Jun 2021 15:10:46 +0000
Received: from DM6PR12MB5534.namprd12.prod.outlook.com
 ([fe80::a8c8:ff39:a981:445c]) by DM6PR12MB5534.namprd12.prod.outlook.com
 ([fe80::a8c8:ff39:a981:445c%6]) with mapi id 15.20.4195.024; Thu, 3 Jun 2021
 15:10:46 +0000
From: "Liu, Shaoyun" <Shaoyun.Liu@amd.com>
To: "Luo, Zhigang" <Zhigang.Luo@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/5] drm/amdgpu: remove sriov vf gfxhub fb location
 programming
Thread-Topic: [PATCH 2/5] drm/amdgpu: remove sriov vf gfxhub fb location
 programming
Thread-Index: AQHXWIKpt6bC5z/qZkC1jIm6RNcbTqsCY/0A
Date: Thu, 3 Jun 2021 15:10:46 +0000
Message-ID: <DM6PR12MB5534530CED9007835EB82450F43C9@DM6PR12MB5534.namprd12.prod.outlook.com>
References: <20210603141305.2542-1-zhigang.luo@amd.com>
 <20210603141305.2542-2-zhigang.luo@amd.com>
In-Reply-To: <20210603141305.2542-2-zhigang.luo@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-06-03T15:10:44Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=154d4e63-9ab3-42e8-9d98-f933fed1e38f;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.55.211]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 71d2ebb3-72b3-4661-0e45-08d926a1c38a
x-ms-traffictypediagnostic: DM4PR12MB5214:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM4PR12MB5214C5E3D4D22E2782845D5BF43C9@DM4PR12MB5214.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:883;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: T7Bz41f8DBnCiXlS3sbCIvbS6SBysgQmhxDZkPGh7QUAdoE08VJQGVeW4uCtr57+K8mdwepG2iyNGRPqzMdkMW2AN8MLbH3XI1BYlovgUcm/dzN6NEz/qEFDCOlmV5CNHQ4sbBJZgBVo1nZ3/mRauMIwUjOEaKTavpsRv2KF1Cgle/C38pp/jjC7dWEe163kcXagyEwN0AGC109osES+V0G4TCBADpp+iZC48JbGLobUBQdS7J/1puWis3cUZZUQkggBeiCEklxJE73XVlJ1H4X2Jz9vbTKnPycPrKJcV4HtluggkVOURL9dvkvf/BZEZ/U4wuwfXFzuHDTXsJbX+A6jdfBLd2Agj7Hz9Eo2h50sM9vlKZANfdH7U8G5SOagGDDedgIMXyi5ASiS2wecrlgdEiJZiro8jIm2ZaD2ebAPJPIUzzzKFZhz3JGF6KYmUhnJ7s9oFley7EoAUdDGGai+Hx+/IN3k8h6CwYU2BcPu1GyLhkf9U5TemFy4ENK429/X18TYAhW4C3u52gWkUA/QHhTMDv9uhnGhtt7V3STtODzffNVMDsaqnyD/NMaFytiD/pBMAUjD0ay58gPt3d/gItdIUbnPmSxwo0GJEzVzzOJCuKg+8zS2IvchMOQAHCahuZ7WSlmC60lTD9Fn+g==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB5534.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(366004)(39830400003)(346002)(136003)(396003)(966005)(110136005)(478600001)(83380400001)(26005)(45080400002)(38100700002)(8676002)(316002)(122000001)(53546011)(33656002)(4326008)(8936002)(9686003)(66476007)(86362001)(6506007)(2906002)(76116006)(66946007)(5660300002)(52536014)(64756008)(71200400001)(7696005)(55016002)(66556008)(186003)(66446008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?iMT8thoW3+FfdG0Ukwa+yJ7VKwZigVfPo14Gw1Zd891TLRdavnxTMA+HVDKJ?=
 =?us-ascii?Q?U+71UNwDV2hJDbiKRpNNe+Z3vEhVOPqVEm5LPnaE6g4J9qgx2kvYJDhnyuJf?=
 =?us-ascii?Q?2PsR/PSOtqzQUnz9xJF4PcayzJUXCguBtITOO9kWOkTlpqDfcthYDoThfeA2?=
 =?us-ascii?Q?iBvgsiaH2CWgcsJZbAFat2EYdnIzpSTucp4nTzQYd6cVkXwKiLfrcvoC3Bn6?=
 =?us-ascii?Q?Vww6ZmOQKauaXBxuIYRIp+SHldW8yZYxt6Uy1RcDQMVJq7oZJTbBbIsLK+Ot?=
 =?us-ascii?Q?LJk4XztRZjelmsc58xDXzc0HxPKqgzkqjQe5K6NBSawvZd8JgHIlm5IetFke?=
 =?us-ascii?Q?qHrnwndKqtwcnChx3WVdbJ7SwMW2m/8yOsUdsxL6RhlSUtRARq2hAUlFTcT6?=
 =?us-ascii?Q?h2/mLk4Y/wuA+PhqKnliMYDTiaPAWQPD2G5qCVEXzYX0GeBcHSEkz5idYlS5?=
 =?us-ascii?Q?3RhEqE4zl9UdVR4bZa12b7S0xZBQLlCMZtoX7mEjlgmOkpDK1jxMotzTh5k0?=
 =?us-ascii?Q?Lbgb449Z2WjgNs5VUMUxEZTDuA8mx/jmAj1hnkACmW3YaAKMvLcSH6ZlNxQZ?=
 =?us-ascii?Q?xhGtV14x2MLrhQbYE4PUFQ2Z9KPHRYT82okIjdxtFq11WDTqKQ5umNPFVZWt?=
 =?us-ascii?Q?DxRlxt3lpQgDu4FZmqRg8Q6+88iP5eA9CeaOTCOzNPwa0AMq2bxEWq/bASZW?=
 =?us-ascii?Q?j4oUBnN41RUMXTg0fFgC8JKv14T4icg924LS1gVYwuXo3Gm9DCOSevBFuwmW?=
 =?us-ascii?Q?J2DTwHS7ejtWlQFC25C7SrFDVXHse+NUOPaV8oGLOakaVl+e+VCJI5/6cCCD?=
 =?us-ascii?Q?WSAhHFbFRHQksVpdtgo5wYNqQb8w/CxtgKsGV+3ESVtz6Y462FiyOfyURdsP?=
 =?us-ascii?Q?GieUcbU6EIY/P8OLTVt4jzBxsC7UEk0cCRgR848+xhNbcyh0bf6eWy329WjG?=
 =?us-ascii?Q?p6MQ06liu3TCCDh/OOu6MJU/pqdkbQ15tUi2cw7zSUZKRH+74mt/3KRRCOuS?=
 =?us-ascii?Q?wqPM0q3Kxi4ZdbHsEiiM+qolWz7OoKYilFF9QnRdKuhTJGK1w003qnwTZJPr?=
 =?us-ascii?Q?gnHteAdY5oLfPVMVfRxXY9K1EMgCXShYVDeEDbSvl/R9i3fspDfqcBIg2MxM?=
 =?us-ascii?Q?jyqqTcBgXq3cPCN4yxzM7t+X/0yB+Rx7xnS9h1OXuZDjZckEMxr+2W4+csQV?=
 =?us-ascii?Q?MbJyY/prGvdaTkX5U2htMYJEAIwTWZ3AGwOckjAAf3mLguJT4zQnRi0eBV+x?=
 =?us-ascii?Q?MdVtb4GVyoYP2rApQQ7bnHJkhtsz1Q2bdYyf6r7dc93cCZE1jakT7p4w91PR?=
 =?us-ascii?Q?XQBaaSKsaN0GMuPHO1yf9vZ+?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5534.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71d2ebb3-72b3-4661-0e45-08d926a1c38a
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2021 15:10:46.0257 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4iCQ7QTi8zDxifNCqke/0vvivpWCSWahLLCjwCJUQlyqOsXK46hUPFkyiVkcRCeziPBKCTmbr0tylqFyC758Hw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5214
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
Cc: "Luo, Zhigang" <Zhigang.Luo@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only]

This looks will affect other ASIC , Can you double check that ? 

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Zhigang Luo
Sent: Thursday, June 3, 2021 10:13 AM
To: amd-gfx@lists.freedesktop.org
Cc: Luo, Zhigang <Zhigang.Luo@amd.com>
Subject: [PATCH 2/5] drm/amdgpu: remove sriov vf gfxhub fb location programming

host driver programmed the gfxhub fb location for vf, no need to program in guest side.

Signed-off-by: Zhigang Luo <zhigang.luo@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c
index 063e48df0b2d..f51fd0688eca 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c
@@ -320,18 +320,6 @@ static void gfxhub_v1_0_program_invalidation(struct amdgpu_device *adev)
 
 static int gfxhub_v1_0_gart_enable(struct amdgpu_device *adev)  {
-	if (amdgpu_sriov_vf(adev) && adev->asic_type != CHIP_ARCTURUS) {
-		/*
-		 * MC_VM_FB_LOCATION_BASE/TOP is NULL for VF, becuase they are
-		 * VF copy registers so vbios post doesn't program them, for
-		 * SRIOV driver need to program them
-		 */
-		WREG32_SOC15_RLC(GC, 0, mmMC_VM_FB_LOCATION_BASE,
-			     adev->gmc.vram_start >> 24);
-		WREG32_SOC15_RLC(GC, 0, mmMC_VM_FB_LOCATION_TOP,
-			     adev->gmc.vram_end >> 24);
-	}
-
 	/* GART Enable. */
 	gfxhub_v1_0_init_gart_aperture_regs(adev);
 	gfxhub_v1_0_init_system_aperture_regs(adev);
--
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7CShaoyun.Liu%40amd.com%7C5e79adbeb3bb46b1cf7e08d92699c8c9%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637583264238382812%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=%2FHQnWwOdUVoyXVRBwx03aJqif3bVRKkKfDT82lr3ZJ8%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
