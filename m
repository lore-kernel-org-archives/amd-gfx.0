Return-Path: <SRS0=VH8F=JF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2204C433B4
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Apr 2021 09:55:11 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A07A7610FA
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Apr 2021 09:55:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A07A7610FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4CE746EA51;
	Thu,  8 Apr 2021 09:55:11 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2088.outbound.protection.outlook.com [40.107.92.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DF6436EA51
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Apr 2021 09:55:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z5FUzxUe4KY1oqNACRs9uwJpvCO2HllQUj7ACGaHqowVEeSZro/YA/qTTs9Gz4J0rs2D8i2iSUCf2dFHvaOCYSvFpYnqvDg+CaSNti+1/TEmsEfEFWGl+pD6m12yHfmw2NWyBFSBb7q2/FdwKfGpVbnpqmwIbO25iLZEsq4wQsiB6zA5hR54catjZ4Bdtkg7zXr5Gj+cAcXus4opp3R38WwSwi7H8+uWyfKfOPjkFpRx/YPvPYRIDK/PNDAdBkQeM3MDEPzNM7VrN9ctjDV4+GJrmEWU5tUExFT5fUB4is8ZWqzR71/In8ntQmTeVfLXmpkQsCtCD91iHRpiKDBnQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GXo/Oyax3sDO6jeqJHO8tVWYXUiYHvG8rxBT6cz+Gdk=;
 b=kAjIv1yaPrOuLi5glvJz+3DKJoUe/uRYWCs61d5m0rYf/G4Vp3TU8RCoBNX1CYlUySNovvrG6x0kCRjFEErd04O81ZKApH2VsV1VP9rLid0DGAAng0ED7lxAkH0a12vfHGGbtDAiKib9lJAkhWBvUatSYfYKMEsAjaFsVT/+rqfR8ppCtl2sHlWyw/W/nsZiq9stGkSZedaWEbPxBNmEPMnLAsqTgNE4aRTGpA571mXKqftd59ZUKerIwl894ebzjvXKBcmt8WmGC5l12tECt6pT0/JAUT5jUqkvGIGebxUHh8wnvM4lEYiJArxGBZHKd+Fu3X0ASAih/fWg0tSrBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GXo/Oyax3sDO6jeqJHO8tVWYXUiYHvG8rxBT6cz+Gdk=;
 b=RcPCHcIcrABA9j7nqg22r15BfBfcRBdofekaI0GVce8pZ12EJ67IqqVwrkPkXiZ5i/KTPcD2KyiwgEPB1Pswrngi7jE/18XYxOdK0uNjbZ3+odjN6MpUBClcWQ3ngwbEYNh+ibrjn3LOxthR0aTTeWV7w5FrXLMBghBOvbSkOpw=
Received: from CY4PR12MB1287.namprd12.prod.outlook.com (2603:10b6:903:40::8)
 by CY4PR12MB1510.namprd12.prod.outlook.com (2603:10b6:910:9::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.28; Thu, 8 Apr
 2021 09:55:07 +0000
Received: from CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::8908:d7:5544:6007]) by CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::8908:d7:5544:6007%8]) with mapi id 15.20.3999.032; Thu, 8 Apr 2021
 09:55:07 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Feng, Kenneth" <Kenneth.Feng@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/pm: enable ASPM on navi1x
Thread-Topic: [PATCH] drm/amd/pm: enable ASPM on navi1x
Thread-Index: AQHXLFoYeu48Nim0Y0qExcMH89Gk8qqqYaCw
Date: Thu, 8 Apr 2021 09:55:07 +0000
Message-ID: <CY4PR12MB1287BB707FC99DAF0BB77F62F1749@CY4PR12MB1287.namprd12.prod.outlook.com>
References: <20210408093256.10101-1-kenneth.feng@amd.com>
In-Reply-To: <20210408093256.10101-1-kenneth.feng@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-04-08T09:55:05Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=d13d2434-2e5b-4ef0-8e71-2f72ae0e8464;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d4bfb622-ded1-424f-db2a-08d8fa74644a
x-ms-traffictypediagnostic: CY4PR12MB1510:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR12MB15104299DCA286A6D46BE971F1749@CY4PR12MB1510.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OtlP82vwi+62DRADGgaj5wDQm+M+07mLi2+v2RzGmEhTA9zJwZHtfiPclQsCb8nxk+ynwbyOReOF1wYLwejkjVCS27JfHK3v/3c3V8S7OoxAn9QIbONfjTe+Pu+UtnvEbHmBrSpa5RXnWFJAcjDq9OcYBxptuG7QWEM4DPFI8kLhLck3DKknpmUO5wpLLeyarQ8kPRWib0nZeCfhOGOTqMWu3+9Pi9VIVkoE68ByaDxibeXZPiuSZFwO9LA/3RZpBS8chc092FXVH2ve3JgX+JpzQBsD8JuT9UvjkbYTOHcL0jcg6od4Pe0PRFrghOigxPkzVK24Pz087wXcZiXac5kDwXA2U3dSIZiNkVA2gDf/R1PSYu/tJw+kC49GXiofaXUqay4VL25m+B10/VUha5VCS6sxj6rXnNmm48aLiqc86mNGcU2KBMF/neuZ6ZKA4KLusiyHnJUB7nYoi3jCVP4ZqC6vOGDq0dRsKMxwvuDJwbF+aLRPGUX3gPMSugKcnaafjZKjspfrr8j5CgBAFeCgTZZrys4r+hK/mAxeAFpJpr0h/Je7j6nMI8qwj0AoPTBayqUrFlPGknKLcMpVIVJnP820a1AQx4yfCjB6+hH16eXn+fBZZ1QllQVjJhEcdyCBzzZVkQ64cQexDvfoL5XZqiZCKFkOIw2iQ6AMlEDSx1I2BmIEM/iAT1GUiqRWc6KbyUMD+HQ8JZh0qqMiwHUq+SIL9pIdKtAQRYHEWpQs/g+GA3Znv1ktBfcNGeuu
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1287.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(136003)(376002)(346002)(396003)(366004)(76116006)(5660300002)(7696005)(4326008)(33656002)(316002)(66946007)(186003)(8936002)(8676002)(2906002)(110136005)(83380400001)(86362001)(38100700001)(55016002)(52536014)(53546011)(71200400001)(6506007)(66446008)(66556008)(64756008)(45080400002)(66476007)(478600001)(966005)(9686003)(26005)(32563001)(357404004);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?zqr79jr/mdvUPLGQjuoxMXjUGKAob9ApfjQJaQVvHubBhqrTYNORdQyjW2YS?=
 =?us-ascii?Q?32ggH366TVQ8GBxK+e51qkuFH/llnT1IGqv3a122stUUEQWTkoqGa8HyfiPg?=
 =?us-ascii?Q?WqYDtSpxbSgBsGhhWPLLlRXWcJV0ljbH8cY9k/TOCByUXCXvtNQH23mVCSJ/?=
 =?us-ascii?Q?1p2fTLucv1yjq9/FiiNToKwe7qx6KSWHv+nt2bA79rEJy3CbD61RD1qOn0ni?=
 =?us-ascii?Q?6fJfa2QqecChTWre5feVfinae6Vm6CTEyZwTjumV73pD/LOeYbvzMi6LOG2Q?=
 =?us-ascii?Q?a8k4p9AfP4Ij81kJeBWL0W/rvTRWc7UTxel4BwSNoxvmcCD5fF9wNEJ+t+pW?=
 =?us-ascii?Q?Uybtr6P2q2/6myO1trQFtDGcytWM1rku0lY/EBI3ZyIO2JGc1SMhEkMIzCxh?=
 =?us-ascii?Q?FIm5Ox4WgAiKTTnLQqoPtuTPx/MyjtNS+sUo26xV4/r/rWMtOXADdfkl61bE?=
 =?us-ascii?Q?y7jxavi6nEjdec7xDOlbcdtA0dyBLQLhFMiRgE1YjZzhQ3krTfg59L8mglXf?=
 =?us-ascii?Q?r7fx+7S5QMJ7EddCaEw+fwSbMzYxti8va7vUpgOfOWgolMxpyox8JvP/hgvp?=
 =?us-ascii?Q?RQswtzFCJxPkwnERGBD25T4y9KsaR+/GxdL1SCJnXqdPLEqjtCasHpwNqP7w?=
 =?us-ascii?Q?lwAbodqq0ULO1Ns909lvrelZ+73ZbiZ6RnHi9s8pN/eL0Oq4g3TX5+pbGCdY?=
 =?us-ascii?Q?UXksgeImaSzT9nEKulBHQuUUqb0txbOyBm30PW29hVDlVy+XhoJ3y5SK0Slu?=
 =?us-ascii?Q?ND4DIoYEEg2FF4aZ+szFeXLcbM1SEUfCc7nXdIHz75HPBLtAzcGuYsybY/K7?=
 =?us-ascii?Q?jlpm0WoW70gG/RWIWyfEpY/yPUC2SrQsfk8INzk8FP8IGffh7CYnaIEnKXjk?=
 =?us-ascii?Q?CamgR6spDJ+jfGOIPhj6wBHfdxjK9GJMD59qNVFipQYU03n+LKnMSXysvsuI?=
 =?us-ascii?Q?+K/lqb+dNEShjAEyxs9O2kMvZxnCB232sN6xlWwXUlKO9HaLD1yWxxZvz2Rf?=
 =?us-ascii?Q?V22FtEkY7YaJiIQmC6BVgry2FoiKPFx9BGi43WI7qvyY7svj2MPsiTIQO1XR?=
 =?us-ascii?Q?BYYoeZr2v/tZkW3uhd0rs+GCAfwXiKeTeb7bv8gInXsNk0xS58UMcINsqaYD?=
 =?us-ascii?Q?S6RN4ChgUzek2qb9aSnsVoJirpt8lf23Ptzrm8UiBH0xvFyi/RRV8tsmsfjI?=
 =?us-ascii?Q?87fWN5Ceo9vIRJRBslMpyDrY9Cf3O0zlLRvDtIXHtWX8lk0TgasVrtHflBr6?=
 =?us-ascii?Q?NkyvlHX0ed297ycmvKFRbkfSATpcWMk7WbJqDy6CghcHancmzeCuMlkqW8wc?=
 =?us-ascii?Q?jAB9n6PCas0OmcqcHLdxDoXH?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1287.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4bfb622-ded1-424f-db2a-08d8fa74644a
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2021 09:55:07.7383 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Rz0RBWzy25gIUtThXSZLxpK/YJbsKc5vJRh4w06hOXW3SqCnFHJH0HORJN4Mb5ITgAHUtBIUVPS/fKztYZe3nQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1510
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
Cc: "Feng, Kenneth" <Kenneth.Feng@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]

* The ASPM function is not fully enabled and verified on
 	 * Navi yet. Temporarily skip this until ASPM enabled.
 	 */

The comments needs to be adjusted as well?

Regards,
Guchun

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Kenneth Feng
Sent: Thursday, April 8, 2021 5:33 PM
To: amd-gfx@lists.freedesktop.org
Cc: Feng, Kenneth <Kenneth.Feng@amd.com>
Subject: [PATCH] drm/amd/pm: enable ASPM on navi1x

ASPM can be verified funtionally on navi1x.
And can be enabled for the benefit of the power consumption without the performance hurt.

Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nv.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c index 46d4bbabce75..5edab56c6ab0 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -601,8 +601,7 @@ static void nv_program_aspm(struct amdgpu_device *adev)
 	if (amdgpu_aspm != 1)
 		return;
 
-	if ((adev->asic_type >= CHIP_SIENNA_CICHLID) &&
-	    !(adev->flags & AMD_IS_APU) &&
+	if (!(adev->flags & AMD_IS_APU) &&
 	    (adev->nbio.funcs->program_aspm))
 		adev->nbio.funcs->program_aspm(adev);
 
@@ -938,8 +937,7 @@ static int nv_update_umd_stable_pstate(struct amdgpu_device *adev,
 	 * The ASPM function is not fully enabled and verified on
 	 * Navi yet. Temporarily skip this until ASPM enabled.
 	 */
-	if ((adev->asic_type >= CHIP_SIENNA_CICHLID) &&
-	    !(adev->flags & AMD_IS_APU) &&
+	if (!(adev->flags & AMD_IS_APU) &&
 	    (adev->nbio.funcs->enable_aspm))
 		adev->nbio.funcs->enable_aspm(adev, !enter);
 
--
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7Cguchun.chen%40amd.com%7Ceb6ca4353559489ae74c08d8fa713a3f%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637534711508933688%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=%2BtDRLzFCbPb5S6aC1pYNULjoSLy9jemx1QLUzq0CoOg%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
