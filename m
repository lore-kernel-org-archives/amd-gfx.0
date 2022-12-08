Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA20AC63705
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Dec 2022 08:30:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7470310E471;
	Thu,  8 Dec 2022 08:30:36 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2050.outbound.protection.outlook.com [40.107.96.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B4E1F10E472
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Dec 2022 08:30:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jnOyYAbsTHcwji84fviXfXqrZR4Pgj8t3OgQAG7O94NDqpqcQyn7boyKLYMaFYvazAE6VKkpIdoBo92z3SNSowPpeBErJzgOtODVr1zq+rFdmMPtB/CFkIMOvVd75odNyXZ4cr7BVl0wM8XeO7KZLuAlUJNISZOeDv3xVuUA4KVJclguzI7X3mtUK7wBw4nRTbWzoxu36iYownirf7ENuf5YXbQ6CQZe6VPK8lOOH0kvevX+Mr1UwRI0rXozwKGkOU6dB4oKXaRTAKanHZVcn/NUIsej9FuOHnbwLmBQad5oNliZqZQRogphbJokg9FnOpeJfaD8Qm5+u9+uNeZ1ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F2sKM5bu8RMAoZGBI0rFB/LjihfyEXcvJMITMvEgeqw=;
 b=m2umZDJ5N2vG2HtLcDBAYcSQ/jPNnzE+pXA14hWsFwH1Ew47GWkTjowC7JFeNS/DvRKf8GRonwqVePe9EQwRBUuRRN+EZFxHf1a9BBSk50urHUE8Z5lT7zp0xgHKjyYeY8c/6l3OiqRan53asUnKr8E8HIMz//ntCdvhjFHCZhrjoJcBPaRwVQgn0JVz9dKrGaJUbN5Kk+SEP59DjwRfGAfSRSdzQFeyZgD2KQ3PE1cbIy5x0ShbXXvZsCmzoPtmxSxqcXjuTO5E1HIDmvrLRHDv5qhCd+zD0bHpANEn3eJt95op83fkXpdQ+ZuQhVgptrgPbv3sS6Wbq5MYaTiu4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F2sKM5bu8RMAoZGBI0rFB/LjihfyEXcvJMITMvEgeqw=;
 b=il0GwSbtko9VkoaCXyHpVZzkwsDTpI9GrC3mPee240u6m7s+Hpg266lpnP8qOEhIS4OM3vJSTzi4KlyDsVflTGlFwfIRxGO8Mril5LJZuIgLPYmxQWHOJOyWy0AEm+UA9u4wP8ee5lM2ofmFLBmLMAEWCTBVxvYVUKPbJd3H/jE=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by DM4PR12MB6565.namprd12.prod.outlook.com (2603:10b6:8:8c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Thu, 8 Dec
 2022 08:30:30 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::39a0:6c44:c6a5:cfa9]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::39a0:6c44:c6a5:cfa9%3]) with mapi id 15.20.5880.014; Thu, 8 Dec 2022
 08:30:30 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Yang, Stanley" <Stanley.Yang@amd.com>,
 "Wan, Gavin" <Gavin.Wan@amd.com>, "Chander, Vignesh"
 <Vignesh.Chander@amd.com>, "Yu, David" <David.Yu@amd.com>
Subject: RE: [PATCH 7/7] drm/amdgpu: define RAS poison mode query function
Thread-Topic: [PATCH 7/7] drm/amdgpu: define RAS poison mode query function
Thread-Index: AQHZCtn9ou8lQ8k6GE+R3mpRAuTzha5jqNmQ
Date: Thu, 8 Dec 2022 08:30:30 +0000
Message-ID: <BN9PR12MB525731B37CA100BAC1D1BD16FC1D9@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20221208075122.28702-1-tao.zhou1@amd.com>
 <20221208075122.28702-7-tao.zhou1@amd.com>
In-Reply-To: <20221208075122.28702-7-tao.zhou1@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=69c85059-8f55-45fb-a131-d689734cf7de;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-12-08T08:30:06Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|DM4PR12MB6565:EE_
x-ms-office365-filtering-correlation-id: e2fbb78a-f0b2-474d-3417-08dad8f67761
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oE2vkGSAgh/p2VyKpMBlK6CRRfzeaW03Xm0ZjTkELv/7l4wI4YgUnc3giP28lEjVHyRuHGWz20NuJBdcVx2eqfJQPSrwi3siMXyTEjlHsrDvKpBKLR85C4IAGuQ/5o5xrhs/Ah36kOkVT+0APLsmZ6NsTccquHK7fukP61SSavMa4boW2oeKwjC1l8ee+QS0E/NXSXHijLeQkXTt4Q7v0zt5xOAROPHHArQF2e+sV4HXQDY+SYkgbXeuI2j0brb88OHSoGrAxBSGYpu4pDzbhDJhdMneedxqGCwN/dv2fjkCUb+esZobqgei9p/5/3yl8YfRbMFy0usuB3CgOM0axW2tp6FunrRSMce2j4MrQ/W/uMAmUE5Tbp22JnSjLqN3PiZlGbgPC5p2hNXW4BE4QeHy5VsdFrsaIP6yeXgH84tNB047MHZZx3C7GQ2RDJJm6u875UrBfOcJs7a6YVO9VtzHaccJN5Si1W6tgqt5FJw/LzQ3IuDqxr29eXsf1jLKJdSw4vvAQTJjRPrJsxfLyRndYjuu+RYzlr2m6loYfN4v2t2qzUfqcICJugk0AVjR5bFZLFNi248tg4j85eczVo+qhuv2bVKQAL5xgOraoz86mSz85IoOaDBm9Ru5OwbPoxkeGsKxoFxUq+sJvDSf9HMX1WyqU+nwsOOKTWV6LiRQSlBRs9jJYlUvCRgbNOGyijl9PCfPn6bNfGPCvOPKrLJlhU3Syd2qhDKnZgQsEHg=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(376002)(136003)(346002)(366004)(396003)(451199015)(86362001)(921005)(4326008)(8936002)(2906002)(8676002)(5660300002)(38070700005)(122000001)(83380400001)(33656002)(478600001)(66556008)(66946007)(66476007)(316002)(110136005)(6636002)(76116006)(71200400001)(38100700002)(64756008)(52536014)(41300700001)(55016003)(6506007)(53546011)(66446008)(186003)(7696005)(26005)(9686003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?N7ub3X/XRjLolTAPRMMQUHlkE3Dyns5aviIDanFdzvSU8QGRkgdoWgsZ/UiJ?=
 =?us-ascii?Q?AD7GMYdqZehNtO2DB64VmiiAxKxAJZBfI0Rmjk4JBBheYpAKO5T9EOYhjNYy?=
 =?us-ascii?Q?PxjuBhNOUGAix+Zh2VhW7dnrAB/JKwpsTvA8A7QJz+IOW5V8rvmF8eg70Scj?=
 =?us-ascii?Q?pcFCk/M0B4kO6q3+TAIL4aW6JjAckVuSCxXkdmfmFtGJ/7vDy+8gBZZP4bRr?=
 =?us-ascii?Q?k4V/GYFHA5xY0MlR0h7B0EuJVsGC3xgABNJnFGtvLO4KYrRq79lUXi99pNyW?=
 =?us-ascii?Q?pOoUSBu6FUUAoltyhJWslIsT6Djk7mKc28JZyCbxD6V8VshSHAK6YCrDZi53?=
 =?us-ascii?Q?whR34r5doyT82TQnsJZ5eyajQAvlls07zAtYuWJ6wZHiGKcMPcYTGD1/6us9?=
 =?us-ascii?Q?osAzpJ0ZiCyFTAeyviXFhpEg9cSQzvkkd7MVgQTyTrLIArhpCeysfO4Osq6n?=
 =?us-ascii?Q?sOzi+DmCeuBjJDpfjV1rESzkWbG9h0IYjsVGgplHpjV11QlHv1si0XtyLGeF?=
 =?us-ascii?Q?dlqvBODXoZ7lJOI0CX4eL9gvJCs8S1sOU3rZM1uDgeWW/iSbJCGOPizHnioB?=
 =?us-ascii?Q?VhKi8CeDyqQ6u8nSJWFT5DxIgUCgFY+TOBqgqcPSXfgpI+A1AmCMMZllgmKR?=
 =?us-ascii?Q?tk6hXosuQKxpPLUE/vmo+stRHA6p6Ey8BjFPSTelu+X7vh+Igh75ib1Eocn/?=
 =?us-ascii?Q?WkyWsTQZwFU1xmkOVjG5vsiny+JI4g2ruJ90BTDHs1IHVQYadn0BABVUjiYH?=
 =?us-ascii?Q?GsAo9Mj45uK76z9bL1Z3ViqVHZDljuHvxXLVEeYNarZHyelb0FxknmDwKv8P?=
 =?us-ascii?Q?qmCNpdEMsjIF3wd8NS4J3AWOr4UWEgG1ytdkmRyke98RBpyU4+q2UfMVF0m1?=
 =?us-ascii?Q?s0vmhMODb3QTx6W+B0ji9K47wzyNd3tPK+CiPHMCNrfyZgFDG6+zqtG/qRnm?=
 =?us-ascii?Q?PBWBGAEBTBDZuUsetT6th5FdSY076l6ll1pRbKesXIwUXW37lWmpa+8G/jXs?=
 =?us-ascii?Q?gdOnj7a7sffanxbyA7u6IjpEpznzLKmpz2fBXqCHUsvLMfou5v4Ah0DAOfSK?=
 =?us-ascii?Q?gPe2YbYXJoZqxaVfcGlHSAakXiqRZgn4VF3S2nssgxjl5tglH1k/msiT2hLR?=
 =?us-ascii?Q?II0rtruHjnlCH7MagIHPpaeCJNk682GBbQ/dXLKT1CoQHd0NmbYsPJdOIbdT?=
 =?us-ascii?Q?bqgMqcSIUgn0aloQhBX3N3pC9IcZBYr3obcR84nBrwNz/42OM7SA0tiJKAtu?=
 =?us-ascii?Q?X2cZ6uAWHicEXVXsO1j7HGxxMieYIPJFl424k8yC4w8JCsyq3YL4jrIhVHvN?=
 =?us-ascii?Q?mIN6e30aDwmhrkhUjXM1aB2sUXsddjIwjN7iv+ji2h9lOfAL5cDSxOEOUn12?=
 =?us-ascii?Q?sQxgHRUVk0HEM1EJaOZ2o191KgJEqGvx1Psrwrg19yK9VONLTai/yteRQqig?=
 =?us-ascii?Q?YSU47vIxz9RQfwS+aYVdVDDCQbsjbOj+aUD8kbIy0G8dDNKoq3OMUzLeUZVx?=
 =?us-ascii?Q?pdEiUEdkW75R0VJJfz/ZPfmS5V/injLIB9naQugvxL/R2ESSUC8DrAQm0KmT?=
 =?us-ascii?Q?PhkiY7yk88jtZJWZjp55ksAdJ3MyMrr2pKK+K8KJ?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2fbb78a-f0b2-474d-3417-08dad8f67761
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Dec 2022 08:30:30.2290 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Z18Y3wg/PVvFQJwRr+AMP4NZ0Z44jfKvmJlGMoHf0B3s2BcPBowVraIyBKk5QQqEsyf0WQO/GN9m2TwNgRzoUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6565
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
Cc: "Zhou1, Tao" <Tao.Zhou1@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Series is

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Tao Zhou
Sent: Thursday, December 8, 2022 15:51
To: amd-gfx@lists.freedesktop.org; Zhang, Hawking <Hawking.Zhang@amd.com>; =
Yang, Stanley <Stanley.Yang@amd.com>; Wan, Gavin <Gavin.Wan@amd.com>; Chand=
er, Vignesh <Vignesh.Chander@amd.com>; Yu, David <David.Yu@amd.com>
Cc: Zhou1, Tao <Tao.Zhou1@amd.com>
Subject: [PATCH 7/7] drm/amdgpu: define RAS poison mode query function

1. no need to query poison mode on SRIOV guest side, host can handle it.
2. define the function to simplify code.

v2: rename amdgpu_ras_poison_mode_query to amdgpu_ras_query_poison_mode.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 54 +++++++++++++++----------
 1 file changed, 33 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ras.c
index 56d2c581f545..0735dfd72c99 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -2411,11 +2411,42 @@ static void amdgpu_ras_counte_dw(struct work_struct=
 *work)
        pm_runtime_put_autosuspend(dev->dev);
 }

+static void amdgpu_ras_query_poison_mode(struct amdgpu_device *adev) {
+       struct amdgpu_ras *con =3D amdgpu_ras_get_context(adev);
+       bool df_poison, umc_poison;
+
+       /* poison setting is useless on SRIOV guest */
+       if (amdgpu_sriov_vf(adev) || !con)
+               return;
+
+       /* Init poison supported flag, the default value is false */
+       if (adev->gmc.xgmi.connected_to_cpu) {
+               /* enabled by default when GPU is connected to CPU */
+               con->poison_supported =3D true;
+       } else if (adev->df.funcs &&
+           adev->df.funcs->query_ras_poison_mode &&
+           adev->umc.ras &&
+           adev->umc.ras->query_ras_poison_mode) {
+               df_poison =3D
+                       adev->df.funcs->query_ras_poison_mode(adev);
+               umc_poison =3D
+                       adev->umc.ras->query_ras_poison_mode(adev);
+
+               /* Only poison is set in both DF and UMC, we can support it=
 */
+               if (df_poison && umc_poison)
+                       con->poison_supported =3D true;
+               else if (df_poison !=3D umc_poison)
+                       dev_warn(adev->dev,
+                               "Poison setting is inconsistent in DF/UMC(%=
d:%d)!\n",
+                               df_poison, umc_poison);
+       }
+}
+
 int amdgpu_ras_init(struct amdgpu_device *adev)  {
        struct amdgpu_ras *con =3D amdgpu_ras_get_context(adev);
        int r;
-       bool df_poison, umc_poison;

        if (con)
                return 0;
@@ -2490,26 +2521,7 @@ int amdgpu_ras_init(struct amdgpu_device *adev)
                        goto release_con;
        }

-       /* Init poison supported flag, the default value is false */
-       if (adev->gmc.xgmi.connected_to_cpu) {
-               /* enabled by default when GPU is connected to CPU */
-               con->poison_supported =3D true;
-       }
-       else if (adev->df.funcs &&
-           adev->df.funcs->query_ras_poison_mode &&
-           adev->umc.ras &&
-           adev->umc.ras->query_ras_poison_mode) {
-               df_poison =3D
-                       adev->df.funcs->query_ras_poison_mode(adev);
-               umc_poison =3D
-                       adev->umc.ras->query_ras_poison_mode(adev);
-               /* Only poison is set in both DF and UMC, we can support it=
 */
-               if (df_poison && umc_poison)
-                       con->poison_supported =3D true;
-               else if (df_poison !=3D umc_poison)
-                       dev_warn(adev->dev, "Poison setting is inconsistent=
 in DF/UMC(%d:%d)!\n",
-                                       df_poison, umc_poison);
-       }
+       amdgpu_ras_query_poison_mode(adev);

        if (amdgpu_ras_fs_init(adev)) {
                r =3D -EINVAL;
--
2.35.1

