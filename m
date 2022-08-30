Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47EFFECAAA1
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Aug 2022 08:11:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 51B2E10EB21;
	Tue, 30 Aug 2022 08:11:56 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2083.outbound.protection.outlook.com [40.107.223.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 35B7510EB21
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Aug 2022 08:11:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nADe12olV2dIdGPMfk3b1aEQRzBkaWlN9ss+6MA7d0hsFMd4sF3GQJOaci6mMoLg5cYp/+bUYUbgzp1oCuLqv1DGoXqYlf3+9AjLs2/SIocN8GTD7gTK0HmjsHJZhFBYD6b0+2niMszNddIwf2k5k1FJHZ1uozpAAvDrmSqW3zLcSz6cYmc0bKhEpMleZlQ4uO7WnauPrjzsPxmv/6/b9Ut2yfZ58w1D1lmrG/ToCpokYdlSVNlUaYFSrlNA3NDVPsk1EPjD5rukhcNSIUz/j2qkXrc5faVSns+6Lz3yZXe9Qnluhj1oWSdToUVrP6Kk8+wIyFcIjxPvu5xVeviU1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V0JhbveXvKPCP6ezw1tH0XxNJzh4MPv17+wxdMBvmE8=;
 b=JKEJOyFGAGA3KTBG+f4Z+bdECfw290ODKjXSM6b4soqgEPRa2w22F8gVTmnICw978495+PGYIrdvmQK0VNmfPE/Y3BPnOwHqsD4tJkse0eq4V26cvzn/p2u9BGioHgOliW4Ze50+tnTzH5xvw2N6e7NeMwRz0peVDZ5QzO2kfcpvaUjXGVDtvqRCCtzECAR9f2w/rlLiGnEoSm4rb2r87fsCIBP7j7WynV5nGWKCfr7qZjoE2CHNxfOdsMDrQOuACToQyzkQXNjI4OGl/GV/7tLaymdZd0wTVXr+ZN4Nrl5Vz9ZubuMLNiJC+5iBsUH+P4s71/5BEFrVUG1kzmoCQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V0JhbveXvKPCP6ezw1tH0XxNJzh4MPv17+wxdMBvmE8=;
 b=KHsK/keIk2BaiPQWIJCOqJXNCVzDwDRjOYGY/kfWEvQQ1rhUY3PCv3IvGzkCuLKs6J65HX0dyh1WyYkQv7QaRzTxYLqZcALlHul0bYDiK34uo4HeDNMJvnsJasf4/+mlPCSz2bWYD5KfAhAKfUVhGcHC5cKJ3lOGKRxaJE++TSQ=
Received: from CH0PR12MB5234.namprd12.prod.outlook.com (2603:10b6:610:d1::24)
 by BL1PR12MB5336.namprd12.prod.outlook.com (2603:10b6:208:314::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Tue, 30 Aug
 2022 08:11:50 +0000
Received: from CH0PR12MB5234.namprd12.prod.outlook.com
 ([fe80::ed3e:d0bb:2a43:8ce9]) by CH0PR12MB5234.namprd12.prod.outlook.com
 ([fe80::ed3e:d0bb:2a43:8ce9%7]) with mapi id 15.20.5566.019; Tue, 30 Aug 2022
 08:11:50 +0000
From: "Gui, Jack" <Jack.Gui@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: only init tap_delay ucode when it's included
 in ucode binary
Thread-Topic: [PATCH] drm/amdgpu: only init tap_delay ucode when it's included
 in ucode binary
Thread-Index: AQHYvEf386J7P9/pNU+xvVLYK5oBca3HF42A
Date: Tue, 30 Aug 2022 08:11:50 +0000
Message-ID: <CH0PR12MB5234FCF405AC51C8C2BBC2078B799@CH0PR12MB5234.namprd12.prod.outlook.com>
References: <20220830081000.9500-1-Hawking.Zhang@amd.com>
In-Reply-To: <20220830081000.9500-1-Hawking.Zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-08-30T08:11:45Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=a7707776-1339-4ed5-9dd8-1e25059cc63d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2022-08-30T08:11:45Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: 6619b3ca-3c78-43f2-a722-13e3d76775e5
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 067e0947-297b-4114-e69a-08da8a5f4a6f
x-ms-traffictypediagnostic: BL1PR12MB5336:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cFDE92U/T3wpLuIvJJY3jAMkWtb7hsFp0av4OYsrZeDR5SXl2NWGXAiTJX+U9phocFv/Da8a52MASbA5k/D8NaA/pRbrtrakGBM+91744tM5lH6GLJnm6ijm7pfDG+eE1CGF+zcQHINwmmuCazuGzb9Rll5JQjoORzCQsP6HoX1geYGnyTl+ECOu/2WFQTIfx3al8xDKiI29BDGdskLN0vQhedDODJZXK9RjcOqIHR51O7RSoBqCovc0YrbIozJHx9f72LyG0K+dwc/UGQS5a7M4rtBnbSYoXRxJ0BIxdomyqfEUNXyIKnP6Jkm7ensLGjlDDaebsOdZj/Q22lCbFGXztvCYAl7v8/0NWsp76LQGDwrZiXSEsHBo5swaxSgaRzT0PXkZSwtCi10bUGgvei3s17F/s6hn8jyBwn/Yvej50asN7VIm01hhImmnOK0pcjG/lJjQpempZEEwn2gb4ek1GQDUBv/WSQWUIDITFczbjB1Lo5I+G3DSF82EtNEKXqn5bM02ZJXjIP6LLjytDdF1UIoD7PMvoVsLnzGGgxaujvnwa5AnVfM6m+SUCzRg5DQVzG4/3SIS3ij8M70gpjJqvQBGS3p5AeSfRBv0Pu7Sf84tveMyRHcML8y0eF7ixxlhN7g4VlqEiVVtn9i7Ye0BYGS1eJa++Cbx6Nb2eh7Pj/9Yn8SHV38lr7+KtA2RfcrqwtGonxFku2bAZtFvuJuONgJt0B8qTeVtr4uyiK4f3i9WbdsDrQoTOTSbwEHpPPNgyiMZYTQ01zDZH/THhA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5234.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(366004)(396003)(346002)(376002)(39860400002)(136003)(478600001)(71200400001)(53546011)(41300700001)(83380400001)(186003)(26005)(9686003)(5660300002)(52536014)(8936002)(6506007)(55016003)(110136005)(7696005)(2906002)(66476007)(66946007)(64756008)(8676002)(76116006)(66446008)(38070700005)(33656002)(316002)(86362001)(122000001)(38100700002)(66556008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?YehcOMgH3ZhYWryH/c/oghwbMXuATzqzpw3dpms8iNKYY0tb2Yqbee0UxRWU?=
 =?us-ascii?Q?XbhOOiOiKZbL1cXo3CDgsSp4QllBDqIbuNAKsiODrojEKukIRiHrgu2wTsLx?=
 =?us-ascii?Q?WLa6PuJlNObE+TUYYJ52X6EIvru8sWctRSsKSJm5Bmlss4ToBoVI4FEsI6GT?=
 =?us-ascii?Q?QIclAqB+CESYPKrVtojcWuzyp8LkUjSS5reUf7DSzHyiZKqDtXNciCwg+Bap?=
 =?us-ascii?Q?8PUSsFxyFU8eJ4hAp/3x2dUMTRAK/MpWQtXDt2uAN3Fx7HP/trOvKQ+dauK+?=
 =?us-ascii?Q?z3cGAHSaVecLs0q8K3MyDG6Tvj1gpmW/dY2zgKTB4IgBLms/TgpsFTJOrS3v?=
 =?us-ascii?Q?nivGP5ph6U/hgY62PzCJbpyGODsvHSeM7kakDT9cs12Zm9eOQcCmcgnqp3iA?=
 =?us-ascii?Q?ZeCjN1WZHH/wIvXTBEBuRwHNW+hXRx/v2GbfnHqY63bKU6A1WWZuCeKIIUYz?=
 =?us-ascii?Q?SwJlOr5aE+zExZwX8efGfmnTt9pKYVaTPOHYAt45WjinYtkZ350o/M+nZf8H?=
 =?us-ascii?Q?e9EdnetPXDAi0liWyzOABZ+ruhF4IhM+/Qv/I8/CNygMnHK24D39jOtLiwsT?=
 =?us-ascii?Q?0zm597ut1ljoGvzgM3BN9RcUYNwO9RbQG0zuqg6wE7BJwD0iGoMNuC31HA/e?=
 =?us-ascii?Q?Ysk9WAiqtJRA+Mr9M6yoApXipzWUGXpgEkJvlCs5KqiRjRKDEnU8NbmoPDPp?=
 =?us-ascii?Q?kcPMKG/SklcZnlhc+9nhJ66wHTPCjytFxIQoN326ZFX40ax87mOQe2WqGimm?=
 =?us-ascii?Q?a23cfeNao24ai4zcNnHxMg3g57cHRuLn6NDGXiCk9/OxRs10yq/kftllHHx4?=
 =?us-ascii?Q?otDnBrEeVFQEHffkX0tVP5+h/N6Ii54lzKZ9ZVvl3X1QgdIQwJEXbvws0TrH?=
 =?us-ascii?Q?5wpQkv0mpBnE1iOxrJk+lYmLLuSXlw84lCdsod+fH2oFKVy9tA0o6SOkJEmB?=
 =?us-ascii?Q?7U8hUF7SY+6P8LELBX5W9qwpUkWBFd5oCoTfhVtm0JfH2fK5zCKn9cdzatOL?=
 =?us-ascii?Q?4NJW6dHlwgfRK28/8rFS7D3D/+f/kaCLX6XaS1s21RNCFNmEcLEiDEr/B7zQ?=
 =?us-ascii?Q?uNTA9KmyDyKUHiqVKs9DFZEExFCfgnXmgDAVnZRrXFy/wWTX1SQUdM7xYGc7?=
 =?us-ascii?Q?qK7e+MqELirthaHkOjyG2CDCO6bcrdgVtJAEQVtqdItuAfuc3EEu+t2hLZL7?=
 =?us-ascii?Q?qsXPF1aZV8YemN4nkW2WL7i2sPRRppmKKhzIvwnY09F+XKn5w2oqB9NXTtCB?=
 =?us-ascii?Q?9V+9aHeHpELA0Hj6oI3enizTU/z4K6Kvpz0vLVzxqge87jJB73YLDYsFo4oH?=
 =?us-ascii?Q?JdcE8GzkWKzyWJtZfh0CKrFoUDuNsQ+99Ow4k4ZVrDxSV5BkbO+J57IWvzY9?=
 =?us-ascii?Q?MrPR4maDykcBuxhD6yXCXUAp4SduMptyNuqgcd1xssYclqkDVrrstBMcm/W1?=
 =?us-ascii?Q?pu7gxaEeeye3IouVWz0ICHAfwtsvzX32FwL+69hEpRlmxER/kAV/HlqXZa8C?=
 =?us-ascii?Q?h1RJry9anQ3ip3tbYrJE5IhNJHJax+44TVjoJLEXiyKCZBC6nsSvFRKb9zIc?=
 =?us-ascii?Q?UeyH9s2TJQfgAm89NJc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5234.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 067e0947-297b-4114-e69a-08da8a5f4a6f
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Aug 2022 08:11:50.1251 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oyS1HSr3+P4juZvy2d2qpEncI3WoH42xIJMCieWgYOnzrFTMXOeehiXnakNxuTtL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5336
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

Reviewed-by: Jack Gui <Jack.Gui@amd.com>

-----Original Message-----
From: Zhang, Hawking <Hawking.Zhang@amd.com>=20
Sent: Tuesday, August 30, 2022 4:10 PM
To: amd-gfx@lists.freedesktop.org; Gui, Jack <Jack.Gui@amd.com>
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu: only init tap_delay ucode when it's included i=
n ucode binary

Not all the gfx10 variants need to integrate global tap_delay and per se ta=
p_delay firmwares

Only init tap_delay ucode when it does include in rlc ucode binary so drive=
r doesn't send a null buffer to psp for firmware loading

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 60 +++++++++++++++-----------
 1 file changed, 35 insertions(+), 25 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/a=
mdgpu/gfx_v10_0.c
index 1a915edccb92..e4dde41f2f68 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -4274,35 +4274,45 @@ static int gfx_v10_0_init_microcode(struct amdgpu_d=
evice *adev)
=20
 		}
=20
-		info =3D &adev->firmware.ucode[AMDGPU_UCODE_ID_GLOBAL_TAP_DELAYS];
-		info->ucode_id =3D AMDGPU_UCODE_ID_GLOBAL_TAP_DELAYS;
-		info->fw =3D adev->gfx.rlc_fw;
-		adev->firmware.fw_size +=3D
-			ALIGN(adev->gfx.rlc.global_tap_delays_ucode_size_bytes, PAGE_SIZE);
+		if (adev->gfx.rlc.global_tap_delays_ucode_size_bytes) {
+			info =3D &adev->firmware.ucode[AMDGPU_UCODE_ID_GLOBAL_TAP_DELAYS];
+			info->ucode_id =3D AMDGPU_UCODE_ID_GLOBAL_TAP_DELAYS;
+			info->fw =3D adev->gfx.rlc_fw;
+			adev->firmware.fw_size +=3D
+				ALIGN(adev->gfx.rlc.global_tap_delays_ucode_size_bytes, PAGE_SIZE);
+		}
=20
-		info =3D &adev->firmware.ucode[AMDGPU_UCODE_ID_SE0_TAP_DELAYS];
-		info->ucode_id =3D AMDGPU_UCODE_ID_SE0_TAP_DELAYS;
-		info->fw =3D adev->gfx.rlc_fw;
-		adev->firmware.fw_size +=3D
-			ALIGN(adev->gfx.rlc.se0_tap_delays_ucode_size_bytes, PAGE_SIZE);
+		if (adev->gfx.rlc.se0_tap_delays_ucode_size_bytes) {
+			info =3D &adev->firmware.ucode[AMDGPU_UCODE_ID_SE0_TAP_DELAYS];
+			info->ucode_id =3D AMDGPU_UCODE_ID_SE0_TAP_DELAYS;
+			info->fw =3D adev->gfx.rlc_fw;
+			adev->firmware.fw_size +=3D
+				ALIGN(adev->gfx.rlc.se0_tap_delays_ucode_size_bytes, PAGE_SIZE);
+		}
=20
-		info =3D &adev->firmware.ucode[AMDGPU_UCODE_ID_SE1_TAP_DELAYS];
-		info->ucode_id =3D AMDGPU_UCODE_ID_SE1_TAP_DELAYS;
-		info->fw =3D adev->gfx.rlc_fw;
-		adev->firmware.fw_size +=3D
-			ALIGN(adev->gfx.rlc.se1_tap_delays_ucode_size_bytes, PAGE_SIZE);
+		if (adev->gfx.rlc.se1_tap_delays_ucode_size_bytes) {
+			info =3D &adev->firmware.ucode[AMDGPU_UCODE_ID_SE1_TAP_DELAYS];
+			info->ucode_id =3D AMDGPU_UCODE_ID_SE1_TAP_DELAYS;
+			info->fw =3D adev->gfx.rlc_fw;
+			adev->firmware.fw_size +=3D
+				ALIGN(adev->gfx.rlc.se1_tap_delays_ucode_size_bytes, PAGE_SIZE);
+		}
=20
-		info =3D &adev->firmware.ucode[AMDGPU_UCODE_ID_SE2_TAP_DELAYS];
-		info->ucode_id =3D AMDGPU_UCODE_ID_SE2_TAP_DELAYS;
-		info->fw =3D adev->gfx.rlc_fw;
-		adev->firmware.fw_size +=3D
-			ALIGN(adev->gfx.rlc.se2_tap_delays_ucode_size_bytes, PAGE_SIZE);
+		if (adev->gfx.rlc.se2_tap_delays_ucode_size_bytes) {
+			info =3D &adev->firmware.ucode[AMDGPU_UCODE_ID_SE2_TAP_DELAYS];
+			info->ucode_id =3D AMDGPU_UCODE_ID_SE2_TAP_DELAYS;
+			info->fw =3D adev->gfx.rlc_fw;
+			adev->firmware.fw_size +=3D
+				ALIGN(adev->gfx.rlc.se2_tap_delays_ucode_size_bytes, PAGE_SIZE);
+		}
=20
-		info =3D &adev->firmware.ucode[AMDGPU_UCODE_ID_SE3_TAP_DELAYS];
-		info->ucode_id =3D AMDGPU_UCODE_ID_SE3_TAP_DELAYS;
-		info->fw =3D adev->gfx.rlc_fw;
-		adev->firmware.fw_size +=3D
-			ALIGN(adev->gfx.rlc.se3_tap_delays_ucode_size_bytes, PAGE_SIZE);
+		if (adev->gfx.rlc.se3_tap_delays_ucode_size_bytes) {
+			info =3D &adev->firmware.ucode[AMDGPU_UCODE_ID_SE3_TAP_DELAYS];
+			info->ucode_id =3D AMDGPU_UCODE_ID_SE3_TAP_DELAYS;
+			info->fw =3D adev->gfx.rlc_fw;
+			adev->firmware.fw_size +=3D
+				ALIGN(adev->gfx.rlc.se3_tap_delays_ucode_size_bytes, PAGE_SIZE);
+		}
=20
 		info =3D &adev->firmware.ucode[AMDGPU_UCODE_ID_CP_MEC1];
 		info->ucode_id =3D AMDGPU_UCODE_ID_CP_MEC1;
--
2.34.1
