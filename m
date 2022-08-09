Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3282C19F2D
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Aug 2022 07:41:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 10D2BC9E18;
	Tue,  9 Aug 2022 07:41:17 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EFE8FC9E02
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 Aug 2022 07:41:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hgKpfAGDmCTHUoIVJyLEVaNxBHD3jZPAEvhWVEsHlZYqVHxz+0LHBm7vr/Zz3rTfx3RGe1el2HQ+CaA5jstrT0g5ZUOSC1dkyBASzX0wSdBNrWgBUSwEX6xs92VcDHmdP3ln1UWjy9ow2zFOdlfDu0uwTX9cki+bq0LUQsphwcOnNTZrRUXKCTfgarjLOkfQrEIKoEqaajWezt+j7pQdVUtSjv3fNkOKs/0pFAMzxJD7gY8yxqrryJyQrA5p80eKWTU1JbiX/icZTNkHsKyRBtXDfMAVKpvRKTuy8GaYR/mF9tUzNBRflxX5LCmcia7Zy9Ox5aQUxnzlLfRY/toHdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y7GyuQfqnDIsduqsnOCRkoCiihffsRT5MTpcKlgdvDs=;
 b=TVneAvDBSoXaRoMSjw4gCuXOcw4uskw00JDDXTOldwWl6ozlEnO2rSzLcaJ0NbHr7AZwgnqKXBGP3VuhcyZQR05Jb5lma9Q2ksBJXzRB2h6PEOzXnkBYg1yET3AK+3BZOXpLylIQcRwYhFb55MtJoVcQ6r5kXoSU+14zXdW0Zcooiy6T1GIZ7jbF1hKHK/kfoo9UyU3SpGjuaOYzaOuv+26Hbzyy0uNeFrrUsgQU4qxx6qt4qI4GInZxi4hGGmtflUj98QHHwNp2SEx5iGkErWAVxqXQqWw1nUI/cSpKoZan7QibNy/S+exmtHaED4eh9O4HMUXL7MC7xFRaLvFgIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y7GyuQfqnDIsduqsnOCRkoCiihffsRT5MTpcKlgdvDs=;
 b=kDL6+dQAlLBEgaUk3wQ4XsGq8ylGtxcD6DKZ6n1mD8tZ3dYEZyNf9xBF7sy8uWL4js/81FRbgYiX7dr7QG2x5HowmPQJPHK8QBWtXRwl54yqatPglQ1D8riuKeF5JLcm0BrwZBv1p1zk/uetVYV9cbGxvpx2tZXZqpKRp4ZdLvk=
Received: from CH2PR12MB4152.namprd12.prod.outlook.com (2603:10b6:610:a7::8)
 by BY5PR12MB3939.namprd12.prod.outlook.com (2603:10b6:a03:1a5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Tue, 9 Aug
 2022 07:40:59 +0000
Received: from CH2PR12MB4152.namprd12.prod.outlook.com
 ([fe80::c9df:9f8:142f:6d92]) by CH2PR12MB4152.namprd12.prod.outlook.com
 ([fe80::c9df:9f8:142f:6d92%4]) with mapi id 15.20.5504.021; Tue, 9 Aug 2022
 07:40:59 +0000
From: "Xu, Feifei" <Feifei.Xu@amd.com>
To: "Feng, Kenneth" <Kenneth.Feng@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/pm: skip pptable override for smu_v13_0_7
Thread-Topic: [PATCH] drm/amd/pm: skip pptable override for smu_v13_0_7
Thread-Index: AQHYq8DcnX5twZb5lkOOJf9z1u4vca2mLzBg
Date: Tue, 9 Aug 2022 07:40:59 +0000
Message-ID: <CH2PR12MB4152070E3E505A361ED59580FE629@CH2PR12MB4152.namprd12.prod.outlook.com>
References: <20220809072219.436078-1-kenneth.feng@amd.com>
In-Reply-To: <20220809072219.436078-1-kenneth.feng@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-08-09T07:40:50Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=5c93582b-e80c-4102-ad40-3a292642007c;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2022-08-09T07:40:57Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: 4f60f923-f2ea-42be-bf7f-4e6b5dc5f009
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 859224d5-4a14-4fea-2fe8-08da79da80af
x-ms-traffictypediagnostic: BY5PR12MB3939:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8H2MXp0C4jDLBxlUhjRRkRSr/6p3hxikXGBePGRXi8D2eidu1m3DZZmJF3k4j7JVKLiNFklWzZ3IJPduCdGLWHOOpLG3fDx5NKKVN7T9yi6x9hXig3vhjEBLvZGwoZyEJPg89QGhirnMaA9ZRh1MgsVV6Tcw+2Cm56yEg0yn56iRYL5OQL02uqyNMOQNiJt9ihbW/p7HECdLG0C/48unKPwSTydXUIDMt4eoMk4QJB1JeoLwKpSx5zDXYnJy5Mfjhz9N4hBmRtL4YsBIXugzs9APr1IPfXsdIoRkOS+4mZFYJ1eJCVibsuMUHlUrxzU2gEvV4KFtRRgeLTvXtZ92y9OM1kBx3DDb61nDK6Cp1TobnHVhTr0bST/qrfz0n6C4/wQZ/4lkRfmIFcAfaeuFp9JxM/+nR2HhJVWs0+hVi932heuUr9tt1SKUb7Nc6OB39jM+/1eMehbNI6zuULSptUjM5iEkT/rIvKzFc4oTD8v0QAzV78Gu3RFrDWa/pTrjAWql7GDeTXHXclpaEvWfO6yIVambuq5MbEJueBGHSTkD1NmMIVSwSWcpJyiizg3Bkf694GYb846O8HJB63y33n5GLOy3WqVGdzKw9StTV4jE7eLf9bnIIL6iJ9nSu55dsn5Idu0LQQ5pxI6lZLVmYBi1MBSMevG8mTi13mOoRoZCG9A09GZh2+FU2J2X1N3YzuR1GC0IF1pOcdUsMVMUiQJWA/MvD+lvbW4/IYWAdV7qasfUo8GbbR/VSvOa2+h1iolXoZh6n2+b5hewZXXJVdJitXhWBD2t/qU3kwQY38ZF17tBw1jsj4BRmrDnvz+D
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4152.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(39860400002)(136003)(376002)(396003)(346002)(366004)(38100700002)(4326008)(8676002)(41300700001)(66946007)(66556008)(66476007)(66446008)(38070700005)(64756008)(76116006)(83380400001)(26005)(110136005)(2906002)(9686003)(186003)(53546011)(122000001)(6506007)(7696005)(316002)(8936002)(33656002)(5660300002)(478600001)(55016003)(86362001)(71200400001)(52536014);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?0yd273fVF/LQeLwGlUhnEX6wdvAWa8q4hFBX7zT6hBj09DRORClxuNaO1YJ9?=
 =?us-ascii?Q?BgAzVMmGevQncKiO6lxDk+Tu1+ni0qxoZ3oE/lYRqWrbvJkDScDpnW0Y41hU?=
 =?us-ascii?Q?wV4x9merIYNE4+rbsdmqZPZyifpcABjtT9iaUBiviAV70DrotAR+eOXfO5+F?=
 =?us-ascii?Q?KzA1MhzigqESP+Dp8uz3NE+SwEjeLIrKc95MucwWCZMszLwh5bVZjill+uAU?=
 =?us-ascii?Q?aM6JTVbQMV40G9O9pOQLYJLpB3+czecFCCKwLHarf/zju8Tb+uUBIUajVLyp?=
 =?us-ascii?Q?P2V2pn1OoZf90gXUeAIH9XozxmBSqRMx0EgkbbWRH4TwzviOHvhMoYIDY1SP?=
 =?us-ascii?Q?4H9mIKUEtIT+X7gxctQnB6gz/skL+mVX78fLKTR2/EHFFY65oougKf9mV8cH?=
 =?us-ascii?Q?+WazvGJUkA+rDaXIp4kXOzd552t47oNaeFi+b/GI8tjV4Kow33g53Gi+mqjR?=
 =?us-ascii?Q?p8ulA5B24TuXv8hKIw/oslXreGGPfTke6Bv/KCWFVa8+EGTOnBh0iilyRIBm?=
 =?us-ascii?Q?q+5uAKeCaHnWXvUX31yYj5YX44uFljS6d/WjLAlLbDJ+7OuE6WDe5uft/o+F?=
 =?us-ascii?Q?783VzIwTVKQrXbJAynzBTVjBMeUbvn818kaUV0YsMomWoxXXvLA2eWLq3wSO?=
 =?us-ascii?Q?iBCeLqgrd1+D1yAZEWAHphXWYug+YsA1ktUrJccEXxqmfqNOt/7PRw3sXjqc?=
 =?us-ascii?Q?0o/OMOw4AuZUJaRmP5n+VIxpn+mpDZBp2CimJGmtljLOZyezoin6G5yKacXZ?=
 =?us-ascii?Q?xLpHmkb7ozOk+jwzrbagaaexmEqwwxcmVyhTlMx5xHRg9Z3sWoJXghVs75vv?=
 =?us-ascii?Q?HfEGG1+k5NG8HCH1k7k4l8+KrvmBXbg1gAcOUROp7EVXjjhxR60ZvcVazmop?=
 =?us-ascii?Q?gw/t91uX+YsCsyLXZE9fTqy5f54vNni7kFvi50v3C5nBDfPcw/+dZc8owO9I?=
 =?us-ascii?Q?o/0INanuRCi8UdkDT879WXaR1qFE6DyskVEIt2Ox8v1lohFqCogg5qPe4xjA?=
 =?us-ascii?Q?x7jtWHAECz5dJB1Y0a8TNQWMBLIOwVBgAaM72Ze+po8tRiURs5lx/qT5rYI9?=
 =?us-ascii?Q?ZPgt9i2MBgr5Pj1p6g88mBfpaGcCMsHvahrbexejzzgWcR8yWsBgtxVv4q2C?=
 =?us-ascii?Q?PEyV/xZ7b3TTS4DTguL2EQyPMhHwByfj2ESWREr7CQ+vZKlF4qxBQtf9Ddvd?=
 =?us-ascii?Q?SCEtZAE84OaSK+SNmMJ6iTf6HPuCMP1DTTqA6kB8mm8iDJzaQEyPtDbP6vn7?=
 =?us-ascii?Q?9p8KvitaZwGp5xv1vtQO92w52wBRfuKvCUsJ38yar/GyV6Y9ydRe5MnsGrog?=
 =?us-ascii?Q?RvIXNTFGjmLPNN2cXhRlZwrT45j8n/APbFE4H/KFCW8u2ZhIAqeN6MAYLYCo?=
 =?us-ascii?Q?FksGVoR9rt8HMR9AgryCi3dxWTLeb+q/OOh1eSUNZhKtcjzi1wNKBfDn2//4?=
 =?us-ascii?Q?jJGJ9d/H58RDMRggBxfz41wmUjyRQONCH4Ds61IvIjOSnpJuuMVQn43HpHiN?=
 =?us-ascii?Q?ceb7DiSrV3J+dZVk5EZpDQd3V4x1ID0QnABJ/+Ql6qMdgvh0dbBkIEs+H7VJ?=
 =?us-ascii?Q?gasRWVeHwc37NwvHb1Y=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4152.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 859224d5-4a14-4fea-2fe8-08da79da80af
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Aug 2022 07:40:59.4830 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gzur0TIM8NboXrtdOatlpEHpPwV3tY6NXPMZFzF0cO0fbU4mQHijg3JWtQ4R2htr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3939
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]



Reviewed-by: Feifei Xu <Feifei.Xu@amd.com>



-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Kenneth =
Feng
Sent: Tuesday, August 9, 2022 3:22 PM
To: amd-gfx@lists.freedesktop.org
Cc: Feng, Kenneth <Kenneth.Feng@amd.com>
Subject: [PATCH] drm/amd/pm: skip pptable override for smu_v13_0_7

skip pptable override for smu_v13_0_7 secure boards only.

Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/d=
rm/amd/pm/swsmu/smu13/smu_v13_0.c
index 0370482dd52b..daf4dc9811af 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
@@ -212,6 +212,9 @@ int smu_v13_0_init_pptable_microcode(struct smu_context=
 *smu)
 	if (!adev->scpm_enabled)
 		return 0;
=20
+	if (adev->ip_versions[MP1_HWIP][0] =3D=3D IP_VERSION(13, 0, 7))
+		return 0;
+
 	/* override pptable_id from driver parameter */
 	if (amdgpu_smu_pptable_id >=3D 0) {
 		pptable_id =3D amdgpu_smu_pptable_id;
@@ -219,13 +222,6 @@ int smu_v13_0_init_pptable_microcode(struct smu_contex=
t *smu)
 	} else {
 		pptable_id =3D smu->smu_table.boot_values.pp_table_id;
=20
-		if (adev->ip_versions[MP1_HWIP][0] =3D=3D IP_VERSION(13, 0, 7) &&
-			pptable_id =3D=3D 3667)
-			pptable_id =3D 36671;
-
-		if (adev->ip_versions[MP1_HWIP][0] =3D=3D IP_VERSION(13, 0, 7) &&
-			pptable_id =3D=3D 3688)
-			pptable_id =3D 36881;
 		/*
 		 * Temporary solution for SMU V13.0.0 with SCPM enabled:
 		 *   - use 36831 signed pptable when pp_table_id is 3683
--=20
2.25.1
