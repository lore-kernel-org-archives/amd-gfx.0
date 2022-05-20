Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA788C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 20 May 2022 10:36:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2D21C10E9A8;
	Fri, 20 May 2022 10:36:42 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2054.outbound.protection.outlook.com [40.107.94.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 05F8F10E9A8
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 May 2022 10:36:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=natJtmpdQw5sU+3rhDMrdODONQBj97OoIO2vWE6CCwi0yhyM/qhHNI5pfYORHlv1+vsB1jVB1AXR7vSVBhyktUDFeUustwGyAcGMf1217CoiOUbPMU6qd+Hn0a/b0pL5E/5zggInWsnNSbMkZQZx+fWsl4CrFn85loWAcfsghef5RsD0aEpGDEuKkt9J8+m1xhOBjRLcRoKUuVXW5Sru5ohnvIu/XwIUrEBWhGxE5CMIRzyQLmEr904YDEN5I5cMBHy9ZthAaUt8jRETMYBFAJWOVRP1y5pLtgH8Ue7Sw5hfX8RpGyO/rMps0eu+nZSTqpTdvc/g08bLJJbvJXQebw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T2Ng88IMZs4Te5DnRDlLglyjGQMJRjsnQjUc4BePxTk=;
 b=MaZvjTUUES6JukhZTnrAq8vDc9h1Pu+OXuz+/7la1fk2Tz/K0I5jnjS45bPc2kP94RO6kio4q8bwMq91skDnAgRGzUuHSsKRvrpCnk6HBmislXDRkdjeVZmXxeGk7W23UAZkdO/qVLz7sC1efRswTkZt9Ltee8DYS5ajkHr+pcHEJ+uIqRG9z6T913W7j0zEjkNgdQ6FlL5wHI1l85aK0vPwVgMjWeObNiOS52P6Df1IB+HeuD+KB0nKrJDq3L9NAifiIJPKlZg0Ra4O0lw4LFPdvTpEf05xtjs3C7CxbxypTO3suizzc0mTqbeXfnzpFmMLJLMkUCO19AebermRDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T2Ng88IMZs4Te5DnRDlLglyjGQMJRjsnQjUc4BePxTk=;
 b=S/hJuNY+QnqEnVLQDXCYZb8b1PZtttAjXerQEpHzGFw9NJ/+biS76cMyGvVksqnIDeT/cCjdI5R6F1qoGcPvlwwG+EJBsCiBs19QXAjwePkXHJj3ZeFnD2F8E4FuEamP1+L9jZxQNse2vylZj8oyK6BE5eodV4q2+OyAiN1V/kk=
Received: from DM5PR12MB2504.namprd12.prod.outlook.com (2603:10b6:4:b5::19) by
 CH0PR12MB5300.namprd12.prod.outlook.com (2603:10b6:610:d7::22) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5273.15; Fri, 20 May 2022 10:36:37 +0000
Received: from DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::b846:d865:5901:f76d]) by DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::b846:d865:5901:f76d%7]) with mapi id 15.20.5273.014; Fri, 20 May 2022
 10:36:37 +0000
From: "Huang, Ray" <Ray.Huang@amd.com>
To: "Liang, Prike" <Prike.Liang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: clean up asd on the ta_firmware_header_v2_0
Thread-Topic: [PATCH] drm/amdgpu: clean up asd on the ta_firmware_header_v2_0
Thread-Index: AQHYbBEQWQDMAvcXR0SguYf5BGBB+K0nkq6A
Date: Fri, 20 May 2022 10:36:37 +0000
Message-ID: <DM5PR12MB2504B33AB28BD08817F243C0ECD39@DM5PR12MB2504.namprd12.prod.outlook.com>
References: <1653027110-15667-1-git-send-email-Prike.Liang@amd.com>
In-Reply-To: <1653027110-15667-1-git-send-email-Prike.Liang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-05-20T10:36:05Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=e168b16d-1066-4263-9f49-db792c3df4c7;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2022-05-20T10:36:35Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: 949890fa-de27-4701-b33a-c85a4e61eb7f
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c74f450d-aff5-4b6b-8c38-08da3a4c9e81
x-ms-traffictypediagnostic: CH0PR12MB5300:EE_
x-microsoft-antispam-prvs: <CH0PR12MB530083C3FDD382112995A8E8ECD39@CH0PR12MB5300.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lRBmtA7bFJI0Tintx17KHZvSuOV2Dlcs/YKHG3h79qJIrgPoFH4GL6xlHmNf1SVO9uMnJQkJFmBioCEvmK4+jQtM76nVF13ia03E4vFgPCtF8EzcUG+l2UZPpqoyfEIvypWKyxRu0erjp9vPXxsO7mb61Dxgs9mfHIZECt6u/Jc2Qzm6Qq9M4eC9OBajLejEltRmTmAmEc1EWRpU0P76Kdh3OoqonmNN2SLATrsOdpqoQbaQ3GiWPnxDnr2O5TKGuSMfA5PToMeGmWTEKcXd2M+IuNsAD4URvALrlDcgUxf/jQuMrHX4TFVeDryMv0JiMGDabRj+t0vgWFBPhPXqAWswEesKWnrhZo/GrmyAFcCUDgEE500+cbHJ/mmStKUcjJe1NPLBk767Uyul2zCugwm3xZaoM06AhXAMkL3xC4cVOsZSUoG7KRYCHnz+hZ5V+xU0ct9AsdK19gckf5EPymyREJmD5keThzrJO8blz3IvGOTBJGjEl0i2KCqjoPWjnc5gwOu2jkem3gSXY+H9QS6BG2EtUgeauRoqRR7gmza80C4xos1GQvE/bj98OPHUHY8eGBTITAi+YD9HBDAIv22Yy1WAb1bdBDvCcHBxh8Y79KRmX4kDIN/9c4boWKfnD2IVJtNmgh1RQVmNOS1q3KZRuJsPgr904FgYBiZWwthekkkREuHtf1d53qS3A2fsielGQDYcWHbrK9wrM6PtBA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2504.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(38070700005)(86362001)(186003)(33656002)(316002)(83380400001)(508600001)(38100700002)(71200400001)(53546011)(26005)(7696005)(6506007)(9686003)(110136005)(54906003)(55016003)(8676002)(4326008)(5660300002)(52536014)(2906002)(122000001)(76116006)(64756008)(66446008)(66476007)(66556008)(66946007)(8936002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?a4NYTVE8RvkRw4lMT+FsEXcdFV1RA6BQmVe+rHOu8qe9Q+bZhduB0ySQv9gf?=
 =?us-ascii?Q?oB2rDiiDgkV5uUpcWmuG2Ee3GTD6draITT1tBMud/pceKtupTea3KFHofryi?=
 =?us-ascii?Q?jryo5c53/sEUfux3uPmvTLprTvC2dswUgMreYiWy/2ZJWUNiN9iVKPkQ+jp9?=
 =?us-ascii?Q?5uMeLKiDHsg/MDHSr2FjOtLv60pNhdwBWA96CkdKUDq12902G+UtU56vKjal?=
 =?us-ascii?Q?Xn+3S3rXJSOd2x13z56cbZP1iu7CkdA6EwFM07T8cfU5iu7EWHmEtrDG/im+?=
 =?us-ascii?Q?iDbXWOuC+oFp2/9UsZiip5YiJEKU8I3z3+OoxL/3gbIbfACOG1Vz8kS5hS7P?=
 =?us-ascii?Q?igr0YV31aE0T6AlcTbNX+79gVlfzHq6IGoFqCqX+zFivGW/nBOuz/jLJh5M0?=
 =?us-ascii?Q?RRJwQAu/WoCJ/ATJXLnBvDYoqbJBqNMfuJHd/MTds2c9Lyz+JLnyg4v18ooh?=
 =?us-ascii?Q?Y7lqduGWkEoEG7f5mzKojSiiiW/w8y+Wol5dzE53Q8U+bnpiB2pzDs/9u866?=
 =?us-ascii?Q?lksMSd2dq8Oeln82uy8S4xUG5ugNOruIh2qEQWZiEjYPyDDuF3hsyFDKcRAu?=
 =?us-ascii?Q?4CkxdiCQJfNMXa+MaGSUld/Rb1IhXLDEe0gwgSelzHatuND8lti24QLqJYnb?=
 =?us-ascii?Q?v/R2wX18ULaqnINhBZpvn2FBxEwzyGpZkVrX6UeWZLKrI2iW1SjH54ykT2us?=
 =?us-ascii?Q?5JHnYidcpEsRTefqvi+JrG6z3fz2NaLcDChu/mSrjYqTqyoqnhHSU6mevQkk?=
 =?us-ascii?Q?pVFQCxPchV/GlgmRcuRc8uj9whkkTj7WRt6gG4c7iQjUORFX7v74tjB/OqJT?=
 =?us-ascii?Q?W3AN9No6nVEfMUCedQpGYBWuGZIiok1TQtG39wuEfubzT3Rc9r4oZ2TFCGEY?=
 =?us-ascii?Q?xE2vDstWiDNXQrPXWac6I2Xa4/zOo726JQFxs8LW5SeDFxThe+h1MhurShMA?=
 =?us-ascii?Q?n+/YdF1ezKTnYDxIAdYTvvUVExSlOrbaru7M8+D41ITvfFSVNeN6MjKAtK2D?=
 =?us-ascii?Q?aIsL5VwsczypYkx682uvOqKgUCCg2Be2CAjlx6kXF0K3z/ilge2cozltkoa6?=
 =?us-ascii?Q?i5zrtE5GXrShRdivhNpqOY7J73mMxRfteCUqylZz0W957ZRoAM/wZ7O8qJIK?=
 =?us-ascii?Q?WgJQoQuhHbwQYbiht78zHPIHHKpQ5k8RXCGGHMpMyHZamIl2JvG7bMS29UeE?=
 =?us-ascii?Q?71UgSqJZctWV/HmG9iOLToJGEQoVpgPH5MtGufiRPmiEKded+FDuvnZzRHUY?=
 =?us-ascii?Q?ZaoCzFZhfwbCShxYpbgRVvfLKuenlx3O5tFIMa28hL2Uilp8rFf1T3MzDeKR?=
 =?us-ascii?Q?lrByj8Yjoz3eIZZUz4A8O+SGk3tb6c2LcAHSOlqWRcLqTcbmf81KcZ+2HJpn?=
 =?us-ascii?Q?xLZivv5iwbISL1c04iHP4O0cHBnz500zCTLGSovx+IdYIWlRADxF2+s7antY?=
 =?us-ascii?Q?igbMJYKExRoRAMPH5jY0dDOtTdkwCeJowww5yTwOUxNDvZsHgOm9RP0wjTjk?=
 =?us-ascii?Q?LB8E+RgE7h4ScsUjGTRakqbphuc0CYf/XcJp4abM2+nTTSx3kWULu8uCDWzn?=
 =?us-ascii?Q?6dzTReNM6uhgMLRINPF8mF4S0/AM4UiDZL8A+7gVcq6mt+CiqfReDJjHbZJE?=
 =?us-ascii?Q?iscbowA9K1rsglpYHT4EUJ77Nt+wJZd7cDFC4r5rGUX1X2WTAP/Lou6B9Ohm?=
 =?us-ascii?Q?aORohbZmFJb/d6ErJCC4OKfA+My2toBYRvPioVto/MvhczaxFGaouSDPOy99?=
 =?us-ascii?Q?9p1ou67xcQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2504.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c74f450d-aff5-4b6b-8c38-08da3a4c9e81
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 May 2022 10:36:37.6937 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: d4eKuYOGvl9OUVSda8Ux/x74o2RGp/fbcfStsMaY3sHscA0E8Amr3/AS8U2zAY3aklKWGBp83LwFeWO+LqiHPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5300
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Zhang,
 Yifan" <Yifan1.Zhang@amd.com>, "Liu, Aaron" <Aaron.Liu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Acked-by: Huang Rui <ray.huang@amd.com>

-----Original Message-----
From: Liang, Prike <Prike.Liang@amd.com>=20
Sent: Friday, May 20, 2022 2:12 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Huang, Ray <Ray.Huang@a=
md.com>; Liu, Aaron <Aaron.Liu@amd.com>; Zhang, Yifan <Yifan1.Zhang@amd.com=
>; Liang, Prike <Prike.Liang@amd.com>
Subject: [PATCH] drm/amdgpu: clean up asd on the ta_firmware_header_v2_0

On the psp13 series use ta_firmware_header_v2_0 and the asd firmware was bu=
ildin ta, so needn't request asd firmware separately.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/psp_v13_0.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c b/drivers/gpu/drm/amd/a=
mdgpu/psp_v13_0.c
index d6d79e97def9..f2e3b6ede77b 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
@@ -32,13 +32,10 @@
 MODULE_FIRMWARE("amdgpu/aldebaran_sos.bin");
 MODULE_FIRMWARE("amdgpu/aldebaran_ta.bin");
 MODULE_FIRMWARE("amdgpu/aldebaran_cap.bin");
-MODULE_FIRMWARE("amdgpu/yellow_carp_asd.bin");
 MODULE_FIRMWARE("amdgpu/yellow_carp_toc.bin");
 MODULE_FIRMWARE("amdgpu/yellow_carp_ta.bin");
-MODULE_FIRMWARE("amdgpu/psp_13_0_5_asd.bin");
 MODULE_FIRMWARE("amdgpu/psp_13_0_5_toc.bin");
 MODULE_FIRMWARE("amdgpu/psp_13_0_5_ta.bin");
-MODULE_FIRMWARE("amdgpu/psp_13_0_8_asd.bin");
 MODULE_FIRMWARE("amdgpu/psp_13_0_8_toc.bin");
 MODULE_FIRMWARE("amdgpu/psp_13_0_8_ta.bin");
 MODULE_FIRMWARE("amdgpu/psp_13_0_0_sos.bin");
@@ -93,9 +90,6 @@ static int psp_v13_0_init_microcode(struct psp_context *p=
sp)
 	case IP_VERSION(13, 0, 3):
 	case IP_VERSION(13, 0, 5):
 	case IP_VERSION(13, 0, 8):
-		err =3D psp_init_asd_microcode(psp, chip_name);
-		if (err)
-			return err;
 		err =3D psp_init_toc_microcode(psp, chip_name);
 		if (err)
 			return err;
--
2.25.1
