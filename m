Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFEFDC3DA6E
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Jan 2024 09:45:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3E0E110E267;
	Wed,  3 Jan 2024 09:45:20 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2086.outbound.protection.outlook.com [40.107.94.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3B2E110E261
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Jan 2024 09:45:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b20DwzFE486/OdQrUrLivwabdx/ecmhg1mvMcMu5vwgsy32kHw7NPWQVvOtiBPlbAiv221rGXobP4uZ/1cNdWlgDwTk7EcOPRCetztN/tlMOtBCPG65p7vyTTho0oecjiKHI4YXpSErePAWdU/WKjEV5BdlU+LcszqdrFfmS+EjuxcplAAPo4Nml6tx1Ya+sKn0Iq0Regf0wut3N41S2hcLTmSI15tLWlMIpqRnHCEeEUyPGjsgeigHx1+YFrOf5tWEf50fCkKxP6E/BPXABlLOcGvA61ruX8/fB5sKnrnTt+k0SSIweuXGs1d1Fv0aXsb1Z+mbIkG7ZvXqPG3b/gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s4iIduvkrplA5h7iyxM9FAkXYUjNeJEDfTsbLwylT9I=;
 b=I7ngJy+BhB6J4Bb0vj3MSkPw32p+EpBOBwWBYik4/PUq0Us5JPfboXa1OLlLMUjHzl7ZGrBPwyIYBPJug84ruA0qV1kVHckKQkO+qXQsNHoq763hLZ9d4lqXhXB/QQWnjgz8xL72yrzoW3SlQQemGwkA6535txy9GW1X8x7MBOTfkUZ8GO4nCWUgOJEE0aj00nzQoyrXqxohrCABIA0yL/gw2lstwXXWvKjon2y9jeVsbfQC+0chxkImkYG1SLCFfFP1T4usn3IkXgyYxbhJ/MQTbpeivzCAf/24a+6JavtIsGhKzhz1ABC5qrEjCoMD9vDGOxD5hUdbCebHu/xMrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s4iIduvkrplA5h7iyxM9FAkXYUjNeJEDfTsbLwylT9I=;
 b=LrAe60zPJ63nGG0XW+JC0fYlwx0Vr7RljPKHO49q+4UnFoHWo3A7lMyUc9mFdO/oPpEg0yPLqEqCRSaqfbFxuzif5ZQRmf7Ie9t31CWUHVQ6Da/qpWXXh3N2WaE66XZIgiZtKDxKh+EWaBK2zUDG7sBzj+6I3EBVGQxpJC3Lobw=
Received: from BL1PR12MB5254.namprd12.prod.outlook.com (2603:10b6:208:31e::21)
 by MW4PR12MB6951.namprd12.prod.outlook.com (2603:10b6:303:209::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.25; Wed, 3 Jan
 2024 09:45:16 +0000
Received: from BL1PR12MB5254.namprd12.prod.outlook.com
 ([fe80::eec3:bf1c:4deb:8810]) by BL1PR12MB5254.namprd12.prod.outlook.com
 ([fe80::eec3:bf1c:4deb:8810%3]) with mapi id 15.20.7159.013; Wed, 3 Jan 2024
 09:45:16 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/2] drm/amdgpu: skip gpu_info fw loading on navi12
Thread-Topic: [PATCH 2/2] drm/amdgpu: skip gpu_info fw loading on navi12
Thread-Index: AQHaNDkiSF5/3gdjoUiAf2qTM3SWYLDH6pCw
Date: Wed, 3 Jan 2024 09:45:16 +0000
Message-ID: <BL1PR12MB525482E1C58CEE31E725D1ECFC60A@BL1PR12MB5254.namprd12.prod.outlook.com>
References: <20231221181106.17924-1-alexander.deucher@amd.com>
 <20231221181106.17924-2-alexander.deucher@amd.com>
In-Reply-To: <20231221181106.17924-2-alexander.deucher@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=169ac928-b99d-424a-ba65-e6701c765917;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-01-03T09:44:54Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5254:EE_|MW4PR12MB6951:EE_
x-ms-office365-filtering-correlation-id: 6ce262f7-f186-487b-2111-08dc0c40b114
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: my2M6OG0O6R2nQK1hIHQOtQFIhIeJA7u/LBT6WS7/Ny9hDsV/DWk2tc3+uQr15SsY4frJ+mN/nQAe0mXYkApzzyP5y2TzkgK+EOpNRPmh3sqbGCJBn7vaNpblRrHgX4JMeF71WUdt031OPM7q2n5PHmCRj7Po04jWr/6ajBmApNNsNWkZggDFvPgqEV4GAqfWG7HUVDnpWPbskloQoxdbnmQ0kwDS5CX4YUuGJ7jwtB3oGAmGRLEg90fWw1DQESfDt6xpfsz5+fZ0zYQXXW2ePJicaI4vCcaxT2kJGFfisMGu+GOYH7x4xLWyBnK447gzVzU3NrjsbJSDTv7uZge0cJ1108CmLAIsN/ZRpLiFzFP8jpYKTbmEYyzzUsJZP81IcDCbkxM0avMyEcahRBOr7b5z2EdXUAG4YLcoFYlMQeic+rVUhXW8YRDkYrYic7D8jvfLBQ5kn06o1Ly2td/TiIbccDmszZ0/VGx8fykEgBX446h3ioVLPZNOS322cnfSktQG+tzz6LKclElZ0TUD4jUhiaHIpw6UBHnKe4KP8Qpv5YfSYzWs6i/U9oMEJmVPDYS5CuGMWWYKTpLjDMkm26xv3D+Stej6wRl5M3YSNY=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5254.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(396003)(346002)(366004)(136003)(376002)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(66476007)(64756008)(66946007)(52536014)(66446008)(76116006)(66556008)(316002)(8936002)(110136005)(4326008)(26005)(966005)(478600001)(9686003)(53546011)(7696005)(83380400001)(71200400001)(8676002)(41300700001)(2906002)(5660300002)(33656002)(38070700009)(122000001)(38100700002)(6506007)(86362001)(55016003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?rZUW1KtIbU1Ea3DMjnz1XkGv/hzBM+jxcTUR+pE8usjnaCrsgL5bE72heaT6?=
 =?us-ascii?Q?Bn9hwDerAAiayl0bKzKzFzhxNPULV6DXOBVZRBVkusPuozA3vVDLQ/dg8R7Z?=
 =?us-ascii?Q?fcEYex3wot2BRK90bHOzZT67SGXuYbFPX/uP3PA+LQL7erNQOWEKxIBIXFiZ?=
 =?us-ascii?Q?tD8Wb0CnqgyaGrYErGZssEcj4aE71Ya1bqZylImm8OhRnEqMUY2WJU9yWYMR?=
 =?us-ascii?Q?5LVeRpfwCeIX7Rz7pfcKc0r2ueR/GMlIUOtFA8o65MPCc2OoTn5jFow7xayW?=
 =?us-ascii?Q?Y4/jGPcb1yA79lTtxe8Hk3Zhvw21hFEEZqcZSDHchd1tyMjeXpycNNxtjU7h?=
 =?us-ascii?Q?pWsLIuIph0TAZfAIKCVXbmcj2SX1i3d2qZ68C3Gv2LhL1jOU5WZojXO/4mhS?=
 =?us-ascii?Q?1DkvANGiAwpb/jyI8BIi7BT9YiMCqIFdH99CoQuBjJADjwQ9VATJHfrOVnrw?=
 =?us-ascii?Q?kHS05QQsLieaFE3Zxs9LiTcsQyARemMNPE2Z6Rae4y0hgkMk8GtkTS0gvnpm?=
 =?us-ascii?Q?yI2ZphhUtEXivNnj4LjuhMSV5+Y9Uo+WjhJkUECAWjRoz2VFZ0yZn5/At7kZ?=
 =?us-ascii?Q?Tb0xDobF8bHfsjI5Zek53Nx0sutudr7+WkLLlk9FEr8Ng3xR/fb91KBRp6co?=
 =?us-ascii?Q?ndWMdxctfyH2+ITYQyJnch6Xh1pklk4qGwCfa8Yuvcq3S4nnxyjbmWruhXgJ?=
 =?us-ascii?Q?4ICnX1+XBXZp9DG5jkyDnH5ouydU0geZrqV0xtYbJgOQEnq+SE805sr5kmPV?=
 =?us-ascii?Q?JFdJTqlD02bOrtK7NwmyLBtGMq2agrwSVySp2i/B3v0eUYqRcs632uiBaWdL?=
 =?us-ascii?Q?tM14F+xDSdE/6b90ifoLFWKHwgu4kKiCwSQbcAJha/f5G8McYyMzuBrd3Lt4?=
 =?us-ascii?Q?Cpt98usX8mciynDhoxFDtDJuzAHiMcQ1l58WdDoH6CePShmJz/e8zJx5u1F5?=
 =?us-ascii?Q?mUsM30yacWBPeaA8qbHD33iqX/NKzHXiCFee1RCs/6HYLlU8XURr40VUzyjp?=
 =?us-ascii?Q?CNZQysRm7qaMgpdNEUtkJ1oiiPeqQTPvx+YeEOw/n8GsRZ0t9OD1qtZJ66f3?=
 =?us-ascii?Q?uCg1W+/dVEptIHH5dbaqkAvQY2mpZ+A1Fwr+mantpWwPYNLW5178A7gCO25Q?=
 =?us-ascii?Q?lV5CmFsX8C1FLUo0mHknBfaHdQ6kTlQ7NtCXAAEoylKyKdt7rkNRZ3lKiMlq?=
 =?us-ascii?Q?F3lUmigQ73+ZxWoaZDHvk+jKEAeVIN2ggJAyzOSYClt+3ArjCU+vRfz7R8W3?=
 =?us-ascii?Q?GcOECSw2o2nW5p2BPlTwu/FLAtxndy9FWvcG3hFLIOeFUwP7KIx26Qjd5fc1?=
 =?us-ascii?Q?oVuGl0aH8NjalcvN/n3XJK8abI7NB5tmjy+cwLvVdNi/fSdCT6eqfBfG8LVA?=
 =?us-ascii?Q?mrADIipOXNqN4V3OK8j6SoFHIQ6fC4WcEvZoYKplYjItmbK4WkpCAg0IDIdd?=
 =?us-ascii?Q?gIM6Qi0plRk1bzHwgQHZBPda8+U2QlRKLf9jVN9nhKMXkMUlsBMlsVo4lkL/?=
 =?us-ascii?Q?96Cz6JwXhG0We1qAh+OzHa+UiWuC9TdjJKNwIi3CYRO9uZZnZr2xgpWAD4+t?=
 =?us-ascii?Q?y7fV7zdHkwKtIr1NwqjEHTqqPRAX+yy7ZNbhXBhk?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5254.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ce262f7-f186-487b-2111-08dc0c40b114
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jan 2024 09:45:16.7707 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: P/Ohpat0r/Ed8LuY0MJuBqobjef4lo0ZhT7C18V+O7ndnHPYCc3wneVjlGxx0b7E51BayoIE2GSOMWZJWic5dg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6951
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

Series is

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex Deu=
cher
Sent: Friday, December 22, 2023 02:11
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: skip gpu_info fw loading on navi12

It's no longer required.

Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2318
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c
index 9c1ff893c03c..71e8fe2144b4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2251,15 +2251,8 @@ static int amdgpu_device_parse_gpu_info_fw(struct am=
dgpu_device *adev)

        adev->firmware.gpu_info_fw =3D NULL;

-       if (adev->mman.discovery_bin) {
-               /*
-                * FIXME: The bounding box is still needed by Navi12, so
-                * temporarily read it from gpu_info firmware. Should be dr=
opped
-                * when DAL no longer needs it.
-                */
-               if (adev->asic_type !=3D CHIP_NAVI12)
-                       return 0;
-       }
+       if (adev->mman.discovery_bin)
+               return 0;

        switch (adev->asic_type) {
        default:
--
2.42.0

