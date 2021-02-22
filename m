Return-Path: <SRS0=DoF4=HY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EE0AC433E0
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Feb 2021 16:14:33 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2101C64E40
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Feb 2021 16:14:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2101C64E40
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BCCB06E489;
	Mon, 22 Feb 2021 16:14:32 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770078.outbound.protection.outlook.com [40.107.77.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5992E6E489
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Feb 2021 16:14:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UC34V2ujWd/EF7jVAGImvjztryeuN2FfDnynlXue1hYw34MB2a6MmeEAnX2lKmJr8p8jdcnTAWW5OePqaU15wNNXucMzi2xRF8z0HVvY5boYH+gP0fGcSHyj52VLiJvw0nFNETqgjS4x3zO97KZI1+TBSdX+dAMorLU0DJmLeLsczDG0YXwR2DqS6PN7Wbtnig4Rse+u4usWsmXkugu6quI+xz7ChZswRXpfnnmFjtw2jiP4OjcykDoBsWUoXNImuXbpPH5rVX4ODEMFaG0qdsImoXgxm007Zjpimnvs3uhSLc+c3voj+lH1Wd9gVs39rh7zP5Y01pT5/hc7UY4FLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OLs64C9K7Yej4fBEoxPuFrlptvseFfQQd2wFqwzLuFE=;
 b=RY3UkZMb0j6hKgG8/3aT1uT2xIRmdoflTJKDDes5+OY7gpeT9UfHtcFtVpnkFG0xzJqcKOax4NKXLxjrmy+thoN13qyAsKqliuC7s9UE7I76CzMtBonuzDwXPokOZAa6YaLkpUe/ALNtUuChoASI+6k6v/z3NV+ACIlIOzed4CN3dQLkzB7+nKX2o4Yiw5Ny391OljKol0AkRyU09GDy+z6/Up7Q7VNcKs/enQQCtmKWr7brEIHOoihdId9tspMTxGC3ZpyZJSRgXH3hOgHdfrkEG1qNLLEs7t8ZVhuOuMjKFj0bAhbak6imPVsjz5z6rcyNdEzuTct4gmy0qK3GtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OLs64C9K7Yej4fBEoxPuFrlptvseFfQQd2wFqwzLuFE=;
 b=4OQ1KT0joEVVqKslykMOR+g5h6/7FqEsH672G4VHPHIaROEJUzEE36781sM/OoHYz+CmyBpYM2cIIg/JmddA8SCl0U0Sgh2tUbu8woVX773uHt+I1+auTkp6IHS/TrpRUBbeNrEBTjwAg4mojq7fKyCGrzfWRUGwHsbSKoVlC5I=
Received: from DM6PR12MB3835.namprd12.prod.outlook.com (2603:10b6:5:1c7::12)
 by DM5PR12MB2488.namprd12.prod.outlook.com (2603:10b6:4:b5::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.25; Mon, 22 Feb
 2021 16:14:28 +0000
Received: from DM6PR12MB3835.namprd12.prod.outlook.com
 ([fe80::102:2c9a:54ce:63e9]) by DM6PR12MB3835.namprd12.prod.outlook.com
 ([fe80::102:2c9a:54ce:63e9%6]) with mapi id 15.20.3846.046; Mon, 22 Feb 2021
 16:14:28 +0000
From: "Liu, Shaoyun" <Shaoyun.Liu@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/4] drm/amdgpu: get xgmi info at eary_init
Thread-Topic: [PATCH 2/4] drm/amdgpu: get xgmi info at eary_init
Thread-Index: AQHXBl1DZPzDdb8rM0+OGe/1p9c/UKpkXsNw
Date: Mon, 22 Feb 2021 16:14:28 +0000
Message-ID: <DM6PR12MB38352B24ED28EBD8C684DECFF4819@DM6PR12MB3835.namprd12.prod.outlook.com>
References: <20210219011913.28464-1-shaoyun.liu@amd.com>
In-Reply-To: <20210219011913.28464-1-shaoyun.liu@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-02-22T16:14:21Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=e54cd02f-9b21-4222-b861-7e70f604419b;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_justification: I confirm the recipients are approved for sharing this
 content
authentication-results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
x-originating-ip: [2607:fea8:3bc0:316:c0d5:387b:19b:615f]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 6e869094-05e4-4172-9846-08d8d74cee2a
x-ms-traffictypediagnostic: DM5PR12MB2488:
x-microsoft-antispam-prvs: <DM5PR12MB24889E3F54C00364C4FF3DD1F4819@DM5PR12MB2488.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2958;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rLX48mHygyUy3bcOAtNIpFr4pH8TNSW81fOZuA2Sda5MJL/Ofg1Mo5IILUyzxQE5TLi2+/WJaPG6g6bnMmHhFnDsfZJyYoWA6txOd7nJkFZDNT9nDtEYne/cgTrjyiB6d+IYdFP8qALl82iZvkCJzD7E/lsd8tBpbg4+6Ho4X9J6XaNLxVBr0UBf6hhZNOq/W5u4VemGelRXYUPUAMsrYzdUTLNYOfi8IniJCzjSXY/heYAzW+tG5lpvzLuQNM5KHRU3gOeENbPJ+lX8PytwbAQiWMnIboDYUq/EHSP3jRhT0xMoeEop7O7miNtccjExYHrzU8IP7fuPVohAKA7/k8Z5EnTDDQlh14H0Wcx/PXKrWWbMcxj3Sdo9KU1q+A83fScuj1dzxMvBk9erWUO16P8TBjYYsJbO/qsdrCnoUS6wl0VVqVgxBNUGYVVpuD05l7QOFUECCuFYtGzJGJ7qaRczoWxZqrMm/9m7isr5q0wf0/Kh36Vis6awFVYxWRd7+w3VxX0b7MKk/UdQbuJbIw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3835.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(136003)(376002)(39860400002)(346002)(396003)(9686003)(2906002)(66446008)(186003)(5660300002)(66476007)(55016002)(66556008)(33656002)(8676002)(66946007)(6506007)(76116006)(52536014)(8936002)(64756008)(53546011)(316002)(71200400001)(83380400001)(6916009)(7696005)(86362001)(478600001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?K1uzSdLS7eeteGtGEeBYl4m9lCJ8p5OU0iF/1IMPQiqJm/QR4GqPOt9jIdM4?=
 =?us-ascii?Q?sL7gTc8ll7QZm4fRIqb0zqHl+xzvhm1gVbe/2QR1W7/+qxTq01OJLheAmRJy?=
 =?us-ascii?Q?udU1Ou64sWh85r/A5GDyN5YRBO7dTAEbVe/u0f9BWUtzNRpHVkVxbsYDq1Ro?=
 =?us-ascii?Q?I09x8HX7p2ioGioHlaYtds6xMhOMS2gi+7YccX1aGZy272Vj//jPwA/xiBcA?=
 =?us-ascii?Q?PoB4Zlq1Nvb6RvQK+Lu9/sEMpapW0d17XzDDk7kytNyuHP2vofo4RK7PNGoZ?=
 =?us-ascii?Q?hFL10M8LddD5HKfGCBrniwhNJ9MnXnFsA+vLYSpjvli2RdhQofnaXlRbM0aG?=
 =?us-ascii?Q?ZvBKMEXLI64V9UgZbluOHxEVy6XvhqLDlTwDC1sMi9gJi4M+1MDK6SMhDWx9?=
 =?us-ascii?Q?S1f/N4SP4unhv8XCahBncaAq+pnbM9xa6sicRfzQibxL9/qPLKvHIe4mLRPN?=
 =?us-ascii?Q?lpSGKVpRCOeNA39p7uJgN91n9iQxqQ+JWC7GyEoZi2rl61iXeszRWHJbjQnT?=
 =?us-ascii?Q?nbKxd2qMQEOiLBPVPl6ysk6dzR+Y98gfEK/MRnVBGmORlZPeGXOj6G67GuMo?=
 =?us-ascii?Q?8FZXlKY9L7fWJ889XeC22fUFXygoBmbW4tcOR0tcshp9VwdOWHJGBg0F5b41?=
 =?us-ascii?Q?5uNwVgCwuZw+GpcDdsJwqOq9Xnxpizhy0jNelElgSuPTvqsQOopyV6rkInfU?=
 =?us-ascii?Q?oYs43iJtCfYEx3fiQbrakvxctZ09nr4Qo2t99g/di8T95K/vG1vqrGcCUTPX?=
 =?us-ascii?Q?vkgMeEGO2b9BKGy6OxnyEez9g9jPIfRKsb/7a6LpfEmHPkxl/sNFpOszqyh0?=
 =?us-ascii?Q?3G+b6l6+Nzu8fqfQypG1InuQlO8D/11lrl9jBOFXmK0aAcxliRpwkZ/rgd88?=
 =?us-ascii?Q?AtNhHnFwPPK2pnqHWuhLtMkbud/bw6HvLz/LlDh9oLV42NowNPn5aB5vV8Np?=
 =?us-ascii?Q?pIZqIWK0uGdNtF9D8HZjtP/IfhELnYbbtL1OyiRXOPhLb5M2GbaV2KaUGLmO?=
 =?us-ascii?Q?xJPsYgmPNQPoiqgjJJ/V23x7PxyS2Q80ELXKWi8oAW+0NCSLIkq6yCgqbE6h?=
 =?us-ascii?Q?j4sD8ugl/G0T5h2jgdD6YLgTV6kCbqMCngTsIgRboy06W7JLrjPebv2+J1S4?=
 =?us-ascii?Q?zvFtWJpDLSyMaPez+KlhqMka6ELKosgb00tV0+o4hGdVRn7h+HPYLwz7Q/9W?=
 =?us-ascii?Q?DEgTxvvzpQmORjRk4Be8tTCxpzms6Omr34k+m0w4pNwdJqM0SA4+an8B9rsW?=
 =?us-ascii?Q?QA98ZIBWtW5PojPNpVMrRMnmhMOiizIH5i5FKa0WahqT4iIrx8REvJCmgi3j?=
 =?us-ascii?Q?O5hbTNEUNLfc0/SSXO13qBS/26u3jBRRCmO3PflLIQ5cuD/gxM9vGoHPg3fJ?=
 =?us-ascii?Q?RsU7+CDvsQ24fM9vLhH0a+Cv5zCU?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3835.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e869094-05e4-4172-9846-08d8d74cee2a
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Feb 2021 16:14:28.5420 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rq94jupbxBVVfBeVWVQ8lqR83vDW6C3tJBz7hcy6KzRnw+LasHTqXtNT50H35CC1RxsIbpNXQyikDTI2agBuOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2488
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]



-----Original Message-----
From: Liu, Shaoyun <shaoyun.liu@amd.com> 
Sent: Thursday, February 18, 2021 8:19 PM
To: amd-gfx@lists.freedesktop.org
Cc: Liu, Shaoyun <Shaoyun.Liu@amd.com>
Subject: [PATCH 2/4] drm/amdgpu: get xgmi info at eary_init

Driver need to get XGMI info function earlier before ip_init since driver need to check the XGMI setting to determine how to perform reset during init

Signed-off-by: shaoyunl <shaoyun.liu@amd.com>
Change-Id: Ic37276bbb6640bb4e9360220fed99494cedd3ef5
---
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 3686e777c76c..3e6bfab5b855 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -1151,6 +1151,10 @@ static int gmc_v9_0_early_init(void *handle)
 	adev->gmc.private_aperture_end =
 		adev->gmc.private_aperture_start + (4ULL << 30) - 1;
 
+	/* Need to get xgmi info earlier to decide the reset behavior*/
+	if (adev->gmc.xgmi.supported)
+		adev->gfxhub.funcs->get_xgmi_info(adev);
+
 	return 0;
 }
 
@@ -1416,12 +1420,6 @@ static int gmc_v9_0_sw_init(void *handle)
 	}
 	adev->need_swiotlb = drm_need_swiotlb(44);
 
-	if (adev->gmc.xgmi.supported) {
-		r = adev->gfxhub.funcs->get_xgmi_info(adev);
-		if (r)
-			return r;
-	}
-
 	r = gmc_v9_0_mc_init(adev);
 	if (r)
 		return r;
--
2.17.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
