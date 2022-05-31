Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4369CC433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 31 May 2022 14:43:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AA07410EE2B;
	Tue, 31 May 2022 14:43:07 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2062.outbound.protection.outlook.com [40.107.223.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AB86A10EE8F
 for <amd-gfx@lists.freedesktop.org>; Tue, 31 May 2022 14:43:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UjqNnRFXgZLH7vxxiOZdHPx6SZcaf2XW2BuQQsr1Sg/QYOduvjgsxF7T6vW/kEvuQWB4kbV2x124X/Hdlqhni5tbJSX2+AOPZ68hItTszP32K29bswO9GIADbsZuMI9sBWf0qcY0JpF5JjCvxf8sZzngt8ATRCBhVubZElX90gLDI6pWBRR4E6vtzMkVpuIVGX2D0LnjFf87VsjESW6eIEAcA5IbTgOwzdxW4it7x4RC6Z2qSakn9VZDNuiFXR02pogljDyiXjV4wjmLN6quHs0XsjHO9CTzd/7b6+JwHbnmvX8yLvwGbZt65MavMZJJvz+7vV/BBx8sVauPs7wMeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2Z4hFGuA77XYPV345gRNiaDU6OKPcaN877Y8j3rLlk8=;
 b=HvxqguCjvIkgXf8YABp0LIx0LddhnyguU6T3cxGQEcH+3HKmKTswoL3UunyjDdVOITLhgrBESFii7McarNCOjbqVmYJlbWgKIUmnKxK+JHxzBwqtkJiGOzO8DjrNcMcxjZhoHwqsPxNnxpJZcBig3PcNBDk15xLLvQDC94wsefmgPSWKh4KpfFHCHCik6TsVzC00cUOLstargqfScICFGtbMW4s2xVGCu9sMKZCnUSVnbJhZoT5r3IaHor2n7dFfGUdDu0kaIxNd6UL/0xm0o3o2/KcFCOZU8pkJ3KCAjutdFmNW+6bY0nb/nnNsFdraTJw12MBNGxHZaDBei8clGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2Z4hFGuA77XYPV345gRNiaDU6OKPcaN877Y8j3rLlk8=;
 b=zcQTHZ/7WM8uBji6o2tBj351RpjKyshYNXnT1SJaOM5vzIBHmuVDaweeTGAjfaJt53KOiv1Em8AlGFxdw7U9lHmeqhdBtCtvHl/eU4qjH374xD7YHCIQ83s4Uz9aZMZKhZO3hrghZ7PJRTK0wauENGzLb7gdUtkih8fPIlyMu0A=
Received: from BL1PR12MB5254.namprd12.prod.outlook.com (2603:10b6:208:31e::21)
 by BYAPR12MB2760.namprd12.prod.outlook.com (2603:10b6:a03:72::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.16; Tue, 31 May
 2022 14:43:02 +0000
Received: from BL1PR12MB5254.namprd12.prod.outlook.com
 ([fe80::e42d:5116:24c6:8a1c]) by BL1PR12MB5254.namprd12.prod.outlook.com
 ([fe80::e42d:5116:24c6:8a1c%9]) with mapi id 15.20.5314.012; Tue, 31 May 2022
 14:43:02 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Yang, Stanley" <Stanley.Yang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Zhou1, Tao" <Tao.Zhou1@amd.com>
Subject: RE: [PATCH Review 1/1] drm/amdgpu: fix ras suppoted check
Thread-Topic: [PATCH Review 1/1] drm/amdgpu: fix ras suppoted check
Thread-Index: AQHYdN5shymsdoCD90umKQhhuFfphq05D3cw
Date: Tue, 31 May 2022 14:43:02 +0000
Message-ID: <BL1PR12MB5254E1A336BEE15524C46B22FCDC9@BL1PR12MB5254.namprd12.prod.outlook.com>
References: <20220531110600.8514-1-Stanley.Yang@amd.com>
In-Reply-To: <20220531110600.8514-1-Stanley.Yang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=16895122-18f1-4fb1-b645-d15e09199585;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-05-31T14:42:07Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a3f75e8f-b843-4826-ccb2-08da4313dd83
x-ms-traffictypediagnostic: BYAPR12MB2760:EE_
x-microsoft-antispam-prvs: <BYAPR12MB2760DD20DC1C64FE488F283BFCDC9@BYAPR12MB2760.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: d4BWpNbxIJOjRXPoDdPVVB7hMVIOJX7d3XrSoQDzJL2gipLGtk9iZMmBNeU/nmv61TwFArWzRcgnPq9z8kenAfodELMnQ9yoNqorEO4uDgUWWvymYiSEq2JSR25R0rAkVhBvKKAfkV5YtXK4xHu1pS9k6W/KPYguF3P+Lu5z0zYSnrxhSP8jAmq5WhZURFGpq2mRV0KSdsDajfq2UC3kWaB/qZcLE4MWUwj2HjdLH6do0MsOXhH7wusGwja882H8ruj6FmXOdfqnhNN2gpYoY+iKH09ZEvgt+bFAgXfjnwjtbeAInYhuvuRVlDEH4q55rj+oZDmsnhUC8ZFq7s9unwiU/GgYRS4f7eS4t7Pz8M4Vpn4D+hKKHdnUKuz1HONHDnsbjvxiP7KMOv9aKwvJWuI3QSk+3bTThgoqhVaU4vR5ONXQTcmcqoQlGLakWqKXrVgRqLwHM7u1DTpT/2LqFAYJfc9C4caWX3ceb29k3AnCoWg/+VWBTdA+dVG2eU99aSkwu6TbK5zumFtQEt3L4Gxz876tNrualcrNahNWCV12xWST3AQnMk9nNi94Z1FYL+vINNqmlLS2v0FxIp+9yzbCtTc8qQXbHGbNM4HHMxh77VPv9CdGAi89d2k4Pr0wvINJfb3kSNdwyr1o+l/bm7it1Yt/l6xTA3Kfb2s1k2owCBn8YY5iM6L7oZ+i+EsDHqunhzRBUNEEe0vdZPBYyQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5254.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(316002)(66446008)(66556008)(64756008)(122000001)(66476007)(66946007)(53546011)(5660300002)(8676002)(4326008)(76116006)(508600001)(71200400001)(110136005)(6636002)(38070700005)(55016003)(6506007)(86362001)(26005)(52536014)(8936002)(2906002)(33656002)(83380400001)(7696005)(38100700002)(186003)(9686003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?fYBFjebYqWloUhzEY6MMWcnPdPP8Ognkg6tTR52i1PU9Kj1yAfEoBhaOITIb?=
 =?us-ascii?Q?myHKC/3FYLdIkUpbxicxxW2oXSEdpvdI3xya8aAyPiiqOvUcAOAiUesYAoJl?=
 =?us-ascii?Q?P61wYQIkX9ORVnDp5JRZwIE/mdZ7SEN1PpKeqJDAMqr8IiglThp+0zJvl3dI?=
 =?us-ascii?Q?vkLJWr3PvYfEOmqZGkNhhTBjIhAbCfoYIiXMezJCo3xV8Yf1NDXSIIVla4Ms?=
 =?us-ascii?Q?ZiqmkfnSoETYqip/0YhyiC9+0xnJ2hN7nsn06zIseJxGVGJSTyNMuHzCJRV6?=
 =?us-ascii?Q?fvJ7KgLVga2U/vST6mHCFHXTaWtZ/aa20+19cd5cneiDq5voW8bnfM/QZhvU?=
 =?us-ascii?Q?L9e7i1miV/VD21qneSenj6C2B6jF4NFzvhArb+0aVSkA2irqbCq3A41EIBHD?=
 =?us-ascii?Q?4eP4iIpYcv3sGXOOvlUe2oROfN5t+b3rN/8VLRjTe0lvLRNG9/2CuTHIAJiE?=
 =?us-ascii?Q?qbQh0rRBxqtxTtPlZeIjJ4SVasYV3XJzr4GUvhXImQsYeh0mUCflC3tBr5+3?=
 =?us-ascii?Q?aWua0G/93L6ZDFj07LNnWEcly4SHYwVjnY3My0uag4/qug4hjRkeutktGmah?=
 =?us-ascii?Q?h1WClosiQzoz6ot++Fv2WUFZi4ptbNusBZo5LiAsca0rFgq/brQuK6kriNN0?=
 =?us-ascii?Q?+bF7TIB/cLlK/gIhSHAWkkT4S4eNI9FXBt0QLaOSTuoeWepHUXjACJ1F4x/X?=
 =?us-ascii?Q?w3dU49UhTb76V2ONdwkIIhxyVCn02bxaTHtAe4M1tJocP2cB0kiBIC5qfkkm?=
 =?us-ascii?Q?d50+4k6jmOL3BGs5GVt3uegT6plzOnBVEHhamY3hlkBvNsdcWK/wsKgzpaha?=
 =?us-ascii?Q?iyQntyjQXCSGYwpEfE2FYcNQ2T4f8pB8Tw6Gv5Lla8O845xCPPMoqMtxMTc1?=
 =?us-ascii?Q?mWUFsp+7QCztjNWYRt5hghgua9hu6vQsCZjRbmbcxMRrdpps60TmLDMB9438?=
 =?us-ascii?Q?7Epsf+SP+pblBogRHA+tmYcZIPJCg6mtx9gj1/lhLXytilD75vqdaGpm48SC?=
 =?us-ascii?Q?lxc9Mum2ECmpp7yuIxjqYguXYUdkPrXxVpN6guyFS8XYDMvKkbeB0k6eRBSH?=
 =?us-ascii?Q?0eNlQJ+5GP0zFfZSLzjBQSnuflyhW5YYeH1umnGuN4h3vCLel6JpJbSYUsYF?=
 =?us-ascii?Q?nYviGLTbFN23W7HjEW7vtshOvD8YIGPobopy6NiiD+eJIWzNuVqzpZ6O4xo2?=
 =?us-ascii?Q?HQXKtVgOtxfdriqNwBQvdLiPBkzuuYmL4WQ3sNHCOMP99gDTm9xkpseX/k3s?=
 =?us-ascii?Q?soH+fPB1AP7R+Fel2T/6LUd2Un4PCrH2LTthM7uwSp12FnlmAddidCK8wiiU?=
 =?us-ascii?Q?P4sKf1Ex4v1QIlCqvw2+MbbgWJrtCCDeazT0CqIQnHoyAWHiguAHSfGVspxh?=
 =?us-ascii?Q?YdGz+GqX+WFBBrRjtEAKI9uTQFZzP0uwI7rWINUwVJKzfxAzcqXCMOfAiNPO?=
 =?us-ascii?Q?X2ZUeKljX5f/7MEYQ02bMH9u0DMiUnnp/3fczkjOfQCktnxGW1cab7GYQLjo?=
 =?us-ascii?Q?MoRyphvCov9MnUlieUxwTzAHUhMl/IdPh1sASXV1rT4oasdsU0Tyx79r7+Bo?=
 =?us-ascii?Q?gEb+pUlBCjjlxz8hdWlLj6iJmcn47oMMCRoYrgdAjZii8UF0eCGNZ56igERe?=
 =?us-ascii?Q?AHW5seRcJvU5MLYM3/BZrWrX0VLGH4/7cmNvdjWKEIhuHFEziXzd72POtGPX?=
 =?us-ascii?Q?c4WQkAsPdCjbfQMFssWWHKpAzwNcvCkR72B50Z935AIme/mD?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5254.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3f75e8f-b843-4826-ccb2-08da4313dd83
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 May 2022 14:43:02.6032 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cj6mLahKW4Nz2ps5WQ43Rv/L3SLuqixjpXGsfh+VCopWOanjuzmp4J1ZEfA0P5jnnarE16RJ++RREEU83ZOo9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2760
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
Cc: "Yang, Stanley" <Stanley.Yang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Stanley.Yang <Stanley.Yang@amd.com>
Sent: Tuesday, May 31, 2022 19:06
To: amd-gfx@lists.freedesktop.org; Zhang, Hawking <Hawking.Zhang@amd.com>; =
Zhou1, Tao <Tao.Zhou1@amd.com>
Cc: Yang, Stanley <Stanley.Yang@amd.com>
Subject: [PATCH Review 1/1] drm/amdgpu: fix ras suppoted check

Fix aldebaran ras supported check on SRIOV guest side, the previous check c=
onditicon block all ras feature on baremetal

Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ras.c
index a9d1cce192b2..8bda285c9e97 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -2285,8 +2285,9 @@ static void amdgpu_ras_check_supported(struct amdgpu_=
device *adev)
            !amdgpu_ras_asic_supported(adev))
                return;

-       if (!(amdgpu_sriov_vf(adev) &&
-               (adev->ip_versions[MP1_HWIP][0] =3D=3D IP_VERSION(13, 0, 2)=
)))
+       /* If driver run on sriov guest side, only enable ras for aldebaran=
 */
+       if (amdgpu_sriov_vf(adev) &&
+               adev->ip_versions[MP1_HWIP][0] !=3D IP_VERSION(13, 0, 2))
                return;

        if (!adev->gmc.xgmi.connected_to_cpu) {
--
2.17.1

