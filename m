Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13A15C25B5F
	for <amd-gfx@archiver.kernel.org>; Fri, 10 May 2024 03:29:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A18DC10E203;
	Fri, 10 May 2024 03:29:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wCJND73p";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2089.outbound.protection.outlook.com [40.107.244.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9086A10E203
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 May 2024 03:29:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n3mClr7MF7q+IFZscfrETpJNMC0KufgmQwJ17lp2GPNJ4H7yZ6yX4LTme2Odk2XdwLOAro2V7AGEBmaN9IwNtrwZRf2V6mt6DCzrthfG0Za2POErpi+JdUDDCKs6KsSBymEdCbnsjhUus+twDsClzvkkfmWYCfp+/v5P7BVuE30qgC5Hqge5Be6DmgDuFfBsDTctyMxV9rCuCzetJIsAJvLIpwH19937lLA0NY+UfdSN+vwvSMv+2pC3mHoZO3e19w0x+Wa5Cb8fFfvrdA6R4t0zdyzb/XDoET1qvuuGd0I8gf/5Ox1jkrAT4cQ9LeyOSRsweujXhMUcEKKOx+Lqjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lif1QBfy+mew0XQsNrZx/yMoXhvCz++6Cvv9UsZVVqI=;
 b=lvaPyndUTeLF/737Ms3XVm91NQMaQVSxy+j3LagWLJeB1Oe7w7A1xwxURpN24L41x4Mq3Ha45xRPHHUE2gR8Hme3QyH73cd9owkuX51o2DRG889iR1iotJ5qaxxhp42P1xcUFn0lXaolNdiuT5R+vAZghaXtyt0wRDNZndKO8jowCjUgpBWU2nexVIo0LVKI+Oy3xVfvUSMyQa1blHz0E78FBiwbES9eMMX4RxPsa9Jt44UyiIB7infO7UWJ1ZSmz63p2C0XYh00Iy4g9wKEjEg5g5J3+ULlDl5JmECCzfsh7uSIhNWHLuHp9ejPGeri2yBER1Mh6POA+BBESVLxww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lif1QBfy+mew0XQsNrZx/yMoXhvCz++6Cvv9UsZVVqI=;
 b=wCJND73ptEZ0CdCGABVRcLrntj4pRPPmY67fOl3eEWtJTQg5r2E/R5eQXmEH3dC9Svh9JbcLATYQUSkFiWhfoJbYdNZZte1N6Pie8I6k11shdknBrOEoHyMXSkC25XV+sfDxAqYEy19hRptKxXIZcAyjM7sBQdyS4EJuZ40DbDA=
Received: from PH7PR12MB5997.namprd12.prod.outlook.com (2603:10b6:510:1d9::21)
 by SA3PR12MB7805.namprd12.prod.outlook.com (2603:10b6:806:319::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.49; Fri, 10 May
 2024 03:29:43 +0000
Received: from PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::d1a1:5993:ef75:9419]) by PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::d1a1:5993:ef75:9419%6]) with mapi id 15.20.7544.046; Fri, 10 May 2024
 03:29:43 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Huang, Tim" <Tim.Huang@amd.com>, "Zhang,
 Jesse(Jie)" <Jesse.Zhang@amd.com>, "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
Subject: RE: [PATCH 15/22] drm/amd/pm: fix enum feature compared against 0
Thread-Topic: [PATCH 15/22] drm/amd/pm: fix enum feature compared against 0
Thread-Index: AQHaooVSBXLNv5mT60aqtf9cG0n8ybGPz3vg
Date: Fri, 10 May 2024 03:29:43 +0000
Message-ID: <PH7PR12MB5997220534AA47E0BFE08E1982E72@PH7PR12MB5997.namprd12.prod.outlook.com>
References: <20240510025038.3488381-1-jesse.zhang@amd.com>
 <20240510025038.3488381-15-jesse.zhang@amd.com>
In-Reply-To: <20240510025038.3488381-15-jesse.zhang@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=ef4c96c5-03dc-44e3-8bfe-4cb38bb94e8b;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-05-10T03:29:27Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB5997:EE_|SA3PR12MB7805:EE_
x-ms-office365-filtering-correlation-id: c3bdc189-e9fa-4fe8-f76d-08dc70a16ee3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|366007|376005|1800799015|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?MLIHyf7zE3/eowPyWjZyC5lD+5i3oeRbWQIAdkoAvi4q4Y9N9BQYXPKcOrgX?=
 =?us-ascii?Q?+I+lCg9GuAX5JDuKeapP4Uudv90g0KfSjtGDRTD/H2khc467ObXE5RQmOCuO?=
 =?us-ascii?Q?ViLyNPNnEYwOB+v5OmxDy7X0MJ+kTgBUWD2ZeUuTjh7JkjBb+XmjT6CVUtv1?=
 =?us-ascii?Q?IJIBCibkwZpfrrVwk0j/4t70ZIzBMQdTxq855i4rkUSXPUK+HxbauHawUZ3l?=
 =?us-ascii?Q?p3pvdz/jYBCm+C1YrFnNJ7TTRFTrJqiY5EF6oK5tTN0xrLZl+0U3oOhsy6lg?=
 =?us-ascii?Q?UU/318Zhmtvt1BxMYZ/7El/IxzbtVs1UqYTxvjmH+XwPMTdjyhKJ4YtHddDP?=
 =?us-ascii?Q?7f98nzLmsFpSpSn7lvSJs9y3hnyUW7KUE/ynbomCbt9pxMxWQ1Z2e97ydx6t?=
 =?us-ascii?Q?c+QhKlFzWZq9IO5nEfpMsWy2QIQQWZoZ28qkg+w9Ls419FrKZxlzdqzLXy+n?=
 =?us-ascii?Q?HJEdKLLRyaXAHajVzt53fJ1OU6rsACFP0O4YRniJ0Bit280BzUrGLQgsKKeW?=
 =?us-ascii?Q?fPo6XCefAnZcfK2BzN9+PeLtEU9qsay7ivcOxq6m0X5qf26xWJ+uKXpYW+GU?=
 =?us-ascii?Q?vynoHdIWVQ5B0EmG9dD33dCmNbpp82BeKp6FdDgd7KQUcOPm4b6Eg/B8LtUo?=
 =?us-ascii?Q?X6NqVSB1stH9Gc67dFkMI9LG4DXkvNAY5D0WvVWaTHa6RgV/lYhP65j2F2gw?=
 =?us-ascii?Q?v1iD5u/S5J70/Q7vYYxUNIWliX5VgY4JUxYp4x4uWuiVKVh0NC3edxHqimkP?=
 =?us-ascii?Q?aFJtoMyaMswwXl8PQD96fBFghg71hcq66+B5wxZa40dNc4HvMFWVzRy+3SyU?=
 =?us-ascii?Q?tr9KUN/uu67vCEoqXuWNoLKTprJsWQ31+Ph7bwBbrF69aOKj3Z7bi1rFW2mf?=
 =?us-ascii?Q?//YknbuvXK9L2d+ZvQWqx213pZcuzhkgwOVhh5qpcy/GZi3Y8tC+Pw8q0Zlh?=
 =?us-ascii?Q?N5WAmEPce0YPrDO4Prtb5Hsxx328gj+RWW/uoAp3/h/Kp4HifYqIh/LmJ2nD?=
 =?us-ascii?Q?ahSEJV3hOtB2/uDWsWeFGDv4EmMiJDvPeplEayNdiV6XOcHoFY8IKjESHuKo?=
 =?us-ascii?Q?X1ZjsqcSv2lXmeD17S5BXXRiUIt7TVI7vOQ3Kl5z6wPCE2Whdu63AMMeswaf?=
 =?us-ascii?Q?hj6Ly/Smo2fLvWzopdhDTrfDkh/7TBnUIIW2SYVs5oPOQ9iuonZYMcqn2/KU?=
 =?us-ascii?Q?bfHv79hQBjn1VJ0uD8xo3u8ZF7Y5LWQzcksN5DLU6TS1RhijzUVQudhsSwR7?=
 =?us-ascii?Q?u8Tld/CD8ko0kJn2aX2wBttvyoMbRIkFQ4qBBRR85NknQtjHWwhm0SkPoCso?=
 =?us-ascii?Q?RhfZGt07awWxx8jrjuIFCy+7wU80qHsryL6mtAHdrFfmiQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5997.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(1800799015)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ImFifJxkmffFSoqfPOGRz1f3F6xN6YK8j5ymPwlOkvvoFSTYbujwNd2FP17x?=
 =?us-ascii?Q?+oR05ZGVI9R3NMgknCkVS6WCZDfjQ3J1ehFeYfKfgAx7EDakPFQE8f3ThtdN?=
 =?us-ascii?Q?BbLZUGHpt0198PeU/9FUPLK60AB7hbxsyi2tdnoY/iCWhTp8BZ7WKiCx6/j5?=
 =?us-ascii?Q?E3pTuW3PaaI5WSJ0F3fmEpc/y5r9udREJTPEreKe22A0pyb7cO8oNg2gBd/g?=
 =?us-ascii?Q?EZi2OVO7gx7Q2JMioNuOGbyzVbjE6HF4T+jwaBEhCe5u0a1R+DvRBJOhpHjk?=
 =?us-ascii?Q?lCvKlu4NH4A63airnY+dK7Xvn2p2J2DktDAqMoi9RCchfGpKwT9W/3VpPIG9?=
 =?us-ascii?Q?doqK15AxZQZvmcDZHtOjA8YpjdFbyzWvuwFRxUkoEF0Om8MAx5D9y/QdsuVp?=
 =?us-ascii?Q?FG3yjTXZ+zifPCyCfueVnK4Bl4HBok3diBM/Hd63PLyeMkdVT51bswrWAc6j?=
 =?us-ascii?Q?U4bg9qzgkTzEUmz/pak4T1MvHolYQmMw8uQ93fL70iNpXmM8qctl7DKxA2Em?=
 =?us-ascii?Q?1tjFe1pxqPJSuhnTihNsqHYYa1pbLpq3EaF16J5TZK0HA8Q5pgX9FDKpg4Na?=
 =?us-ascii?Q?8vLQbinRaxULsYYDiyDCJ6Mmms6MNwvm2GyLDmntEorYQiFIgCvZyWhWwXo7?=
 =?us-ascii?Q?ZnqIovl3CKUBH5PWJQYc8jRHfCYbS7318BPD97Ws6iniHETBYx0gghs9PV25?=
 =?us-ascii?Q?9/XHJFtwdJB91dRtyP3LJ+J50z7Ie4kaRPvBrv60cVC41V7/Zl3uW66ZUb1f?=
 =?us-ascii?Q?lPmE0qdP9xJJ6ZfoOpFS9Tz6U6wPE6nGI+508wKPQSb7eBPoFkdKI3XNILKH?=
 =?us-ascii?Q?UtkaEg/mKXScAvR9bCw+SKCntRw04CdWPLGSLsMl2V5pnQ2PD/owdVo9rnwu?=
 =?us-ascii?Q?wf33I6OxOQ2LAS8kdx/2fdfW/aWjLCIiWLaewlNdmdNw7cxLNc1v+FrDxvMm?=
 =?us-ascii?Q?w0aKeh70pMKqeQHUhNzObhRB8kinxFJzAQ1b4IMmeg48/fijYuLfxnryi+/M?=
 =?us-ascii?Q?E3UmdxQDKpS2FPPLAqOMEm5wgn99o/UgfR3kbs9+lu4fYDredGlfOgYEUaxP?=
 =?us-ascii?Q?xXifgakXuHHGEEFvU/qFD0pxL74Pm9+BZLCOwYBu6rnD5llDCHzT1Ph00xs+?=
 =?us-ascii?Q?qfr9080Y+PupjSeez6DOLtpAu7muhqpj4EY8XEHzYnZbwPsIaOEk3zDs5wHz?=
 =?us-ascii?Q?z86/v4l81cMuK5KURKk96u5JsPvoAcTExjQtNt4Ab2dsINDV7wHoG1Bju1El?=
 =?us-ascii?Q?USQ9Mn4Om30sxYNo6eR4vE3HCMYk6UMfagSmiFhvMf7zVcfAEibLmtNzR5Ix?=
 =?us-ascii?Q?H8LC5l9qTU46rz2yqEiLv+Z6yw1BOS8Aex9ghuPsxLqykwVfv4Tn6sBLVmFf?=
 =?us-ascii?Q?2LAButM0OOyeuA7Yn/F67OdRcTnunbTKaWItYTYIwKH4ulYFzaY1Fj0gJldz?=
 =?us-ascii?Q?7GnppNAQYittUFY4iRYdV5D0Omp7OgVFeO3olMzpcAKZYZ3vBi7vs0ucowWi?=
 =?us-ascii?Q?FCPncVptEMdkjfIf+vMHi1TMGTJCsSBqxn9ED4CO5DD3PH7yB8/oKyxwMqtL?=
 =?us-ascii?Q?ggdos0cR4TBKRGzpAKU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5997.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3bdc189-e9fa-4fe8-f76d-08dc70a16ee3
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 May 2024 03:29:43.1735 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zt8Cb6AOE1LN29lf4sIySZe6KsSlRMfOudSaz2ORfpEWuRvMcc7/xmlCZ1oyfoVD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7805
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Reviewed-by: Yang Wang <kevinyang.wang@amd.com>

Best Regards,
Kevin

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Jesse Zh=
ang
Sent: Friday, May 10, 2024 10:51 AM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <Chri=
stian.Koenig@amd.com>; Huang, Tim <Tim.Huang@amd.com>; Zhang, Jesse(Jie) <J=
esse.Zhang@amd.com>; Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>
Subject: [PATCH 15/22] drm/amd/pm: fix enum feature compared against 0

This less-than-zero comparison of an unsigned value is never true. feature =
< 0U

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/p=
m/swsmu/smu_cmn.c
index 6d1c3af927ca..d439b95bfb79 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
@@ -760,7 +760,7 @@ static const char *__smu_feature_names[] =3D {  static =
const char *smu_get_feature_name(struct smu_context *smu,
                                        enum smu_feature_mask feature)
 {
-       if (feature < 0 || feature >=3D SMU_FEATURE_COUNT)
+       if (feature >=3D SMU_FEATURE_COUNT)
                return "unknown smu feature";
        return __smu_feature_names[feature];
 }
--
2.25.1

