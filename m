Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA5DBC001DE
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Aug 2023 08:54:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DBA9E10E4F5;
	Thu, 10 Aug 2023 08:54:00 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2052.outbound.protection.outlook.com [40.107.96.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8453E10E4F5
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Aug 2023 08:53:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VlZpqYTN/KGms/scih+Q4FWY3f5LqJvKgFtGtSyurOFZ8WAr62UQ5YbP5ePIzsr2251cb/MvTHbypHmyMujM/uvSKJs5Ei3i2QGgDKdeILBYjP4ydT2CEdCEpl4x3PXcQFgEKZwTrhUoi6jL1eL14J7P0m/Pn0w9gIFhBsH2SqX84ywG79p0sgKISdbsTxCfiKx2mjRiHIYd8qo85r2j7+iUNJeZnGM3uQBLo9jD1ONCX9pqRk+gy4gZY3/S3IPl5eJP4DRXOR8cuor9uO83W8M2EwbTPinpDFOqmFKn1PoF0wApnLzBmotE7EsTVhjTbv2RvOOK6hjp+ED6Tvs4fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xfMmNdwbrdsHFuvv8ZOkUZDk/jaEQInMs7/h23C+F6Q=;
 b=T9F4fKerfQ4G7edEgK4rGOwJky3NqMNw6nAgDcQeW8+oNb+E5M5r3TZFtAP8OJUWbAeCByOljP2ginmRz/wAL6SjQR6NNKzehxO4R6mWTVxp364176ffhvhHQt/auh5tCW3SOhdigNE9g0Qm3uW0l6VrfbY8QUj1+BS7gKrSdyV2tp3YAa3bsjJGEYaucCsovRzotyzybSsqRo/LqITljPlFroMwpGx6DtH1GeSm2wnkcUUDfe//v+5Ocwm5xPm3mGjiKLffDy/HVzP4qx1VaLIecAzun7dIQ/lcUafnjEEeMoNBCS0FlvOEArVm+GothWLUYtm00NUQ4q7ycNW+xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xfMmNdwbrdsHFuvv8ZOkUZDk/jaEQInMs7/h23C+F6Q=;
 b=lt/fruxTX5dxfdJHWM7HhDXBhtkv4qbCaAhlkSCx0WMsv/IR/91sQfnzg9Etvz8tEndQDXy3KqJuZybl9DerCnj2aMVt7aDSMevg7HEbhPz3vukc0GjhbpKPym0cHIav9hOaJetxUeU0MeBLOuzqCV8OlhRIxdIgOWNNDgx6q2g=
Received: from PH7PR12MB5997.namprd12.prod.outlook.com (2603:10b6:510:1d9::21)
 by CH3PR12MB9079.namprd12.prod.outlook.com (2603:10b6:610:1a1::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Thu, 10 Aug
 2023 08:53:56 +0000
Received: from PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::ffd8:4c61:6807:9ec4]) by PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::ffd8:4c61:6807:9ec4%7]) with mapi id 15.20.6652.029; Thu, 10 Aug 2023
 08:53:56 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: "Li, Candice" <Candice.Li@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Add I2C EEPROM support on smu v13_0_6
Thread-Topic: [PATCH] drm/amdgpu: Add I2C EEPROM support on smu v13_0_6
Thread-Index: AQHZy2P+V1tvCi9jAEuEn3BU5JCw/K/jOUOQ
Date: Thu, 10 Aug 2023 08:53:55 +0000
Message-ID: <PH7PR12MB5997E9B2BC1FFCE11A67B8178213A@PH7PR12MB5997.namprd12.prod.outlook.com>
References: <20230810082324.2659934-1-candice.li@amd.com>
In-Reply-To: <20230810082324.2659934-1-candice.li@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=6be5c758-b949-4d4b-bd17-202c7cb7e152;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-08-10T08:52:42Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB5997:EE_|CH3PR12MB9079:EE_
x-ms-office365-filtering-correlation-id: 0941d4ee-8430-4021-3ef2-08db997f5452
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: f0wItmnHl6R9inBE3l2XKq/ewmeVpR5mk2zue26pwe79aMm3nWdrT84nPiOWEpZIMMuajhDCEQKvw7F3qg+ikwyNjBeNJnnDwxyMT3AmZ2G+5EjKP9RjL8sFEBgcqdeBhuJqAxT0BVHjIIU6U4Q5MJzBZ0pi1f1PG0i3khzXglOyGDKjdEuYuGyPOxsKsfXP/YLRwZI/PvaUmzGG3jgVJB/K8xf0XcgP3flOZkr+gzLzv2jIPtwdFH3iI41w98iSpc6f3UwEydWVeR3RbGbDgLaI0smjex7090XzcUvrloG7MxxGqYP+Pspg/bUo3OebZ/5Nk8Pi64T9q+G2Gq5EPcmBx5CglIQoX0Ji11koQz9D4H7c5AxrBD7+aNTH5bJFmh1Qi/wbH+yTNQu0dxMnhPSkS+5kukjdmpIsQG88nQ9C8cAA5GLuzIlEagKSQcj3qLgv7pcvrvFcUvWB3mXA+CLvbOXvkKKkc/tcAAJ9gz8p8+3VgZBnhK14vRFRdnqdwMTT9K543HjDJuaW9UCQrQ7+q8dZPtX8isjwn/AA7IFKbS2CA/TVAPsTendRsCdyn+CWhrOGMLBm3se8uiKZk9y5Uu2vbKlWfOxAip8OaNE=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5997.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(366004)(396003)(376002)(346002)(39860400002)(186006)(451199021)(1800799006)(316002)(52536014)(8676002)(8936002)(71200400001)(9686003)(7696005)(41300700001)(4326008)(64756008)(76116006)(66446008)(66476007)(5660300002)(66946007)(66556008)(110136005)(478600001)(2906002)(38100700002)(122000001)(33656002)(83380400001)(38070700005)(26005)(55016003)(86362001)(53546011)(6506007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?wzdH4gSJrtRVBIJIB7E+8qdVnbk25MhjemaHikBkJBo71guOB8fyAGH1EHZV?=
 =?us-ascii?Q?3xEmgSu9I2MIyQ0Wp+vrdpxwaSv7yePXNhMli52uMXoIK5LyKtGocJr5nqeU?=
 =?us-ascii?Q?tBPUeyYCPNUiGIBXreRUCTuTbsxjxxlw7V2I9LuxiKxyvjLQS3aFjbbSmw6f?=
 =?us-ascii?Q?bl3E8ti/EDvdWjCOugdWY1ChHyiHf70CuY7v8x4Or0sO3wnBVOA7Y9+bp7eA?=
 =?us-ascii?Q?Z7lzzg7TMbbnAWmXnJ7Hr3Ef8c+5W1E2bprErzcznZeYoEwvk8vSfkVRUARk?=
 =?us-ascii?Q?FSqnPoItMR0UlrD5k1rOiYwY/YyIYtZyF0gwSc0Y4Jxk/hkl9si8mu4iAGLh?=
 =?us-ascii?Q?WpQwNd81cAXJV5KWTambwRYX50WuSgQpTqxOwfO6idT/ULhegu9FU/93mv8S?=
 =?us-ascii?Q?9Ie662949Z1FlyUvGkal+62UaTEPUmwc1MVyUoz6nsamjDjfWMELEyzTXSYi?=
 =?us-ascii?Q?cVJM4PHqkH3HqcM4iTetQEkCiJbnCO/hrjOq+vUz3tztuY/5d22Q8MP9zHu3?=
 =?us-ascii?Q?xngDDOjbVuN7tLWzjW1WVq1DZglmof4gZeysU9tqKX8Tc6MXeRO+1tws8Zvn?=
 =?us-ascii?Q?D6MyhOILM006iEmOhhi5ytWAQHZQbT2yaGN57leCotx3OkPI3/t+h0FxI/Q7?=
 =?us-ascii?Q?iRXy1D4m/wdqOiQBwEk+Fd84SDmqmOIhgDvCi8hKzC0hUJoxuISqBywKlTc2?=
 =?us-ascii?Q?ruqoA7OreiU9agukkjF78U3DExFW5otOoYcF8tlF5TaT0woE/T1yWEtFCtqb?=
 =?us-ascii?Q?krq9FVxjgIA/eqJWYuMjG7qv7dXXuCYO2bT1S1vq4/x/Ceqn0nPtW9MWQ9q8?=
 =?us-ascii?Q?k20DkjCFT+V1zrDBKJOEGv5AJpzVkq/AmbKA8xSb7jbRmIE6PzY8T2hXIeDG?=
 =?us-ascii?Q?bSeElI60Fo2/tDQazMkzFkLqNGm1W31sIef2Ogb04B7rdygVQORFLgAVHVJO?=
 =?us-ascii?Q?gdZBaLAcZ4aqP/xhrD7ADPzkMazmYIeK3lE3enHYQ6w/xFluiLmHt8Pz4M17?=
 =?us-ascii?Q?VE+4fSM4aX5NdfqXXKajAifqStWjDtyMLBizo9tRuzbLcumzEeCMQMaLtJK5?=
 =?us-ascii?Q?v+HZk4FfInPSUAa7SpnNRrtpLXrTlVRws7KBUSrT6qdfOQaVhhoB58DSvPNR?=
 =?us-ascii?Q?CoFu3PWoGTno7LWhyNVdsGFHWVpVguxC+OOtNIjVQ+ZceMCcbwjZGfRhAuVf?=
 =?us-ascii?Q?pUyb3u9LFBzd9I7YdJ7/bCvHoUxAS2kITOxEgWx64rrsJIK2eYVzzYNYzTHR?=
 =?us-ascii?Q?/7ZAQCsKVKRfRNeV9jvLNLeOnU0R6oFqFUIHRfYZVjx6ThcfffGXJeTVL5R5?=
 =?us-ascii?Q?lVrmHnj8XpTHsTdulT53T0h6VhnGv5pfYhd5olx77MIF19cgVyP9qBmy0uQp?=
 =?us-ascii?Q?wYDOWolQno0/Dfy0OIwPgUxSRDFMELoyPZsuQAVRnDzdXMA2lunayVo6sV1z?=
 =?us-ascii?Q?7E36pmcnquEAgnPyuIwep/se7lrliEoFvWHfvchny8QBpuLERDS/Gp5QatwL?=
 =?us-ascii?Q?FkkYpEDuwP6CUNyV8/iVxjsdma0Te5s0plN6NzeB+OlZr+0bVJkrfc0TfXn7?=
 =?us-ascii?Q?OOFT2xQx/Kj8NWW5b0w=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5997.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0941d4ee-8430-4021-3ef2-08db997f5452
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Aug 2023 08:53:55.7598 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NrDDpdC1+ATlE9/dRUI/ZjTW00HA4ROPLdgyrdZ+37T9mfi/+R3kiEcODppO5nKb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9079
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
Cc: "Li, Candice" <Candice.Li@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Reviewed-by: Yang Wang <kevinyang.wang@amd.com>

Best Regards,
Kevin

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Candice =
Li
Sent: Thursday, August 10, 2023 4:23 PM
To: amd-gfx@lists.freedesktop.org
Cc: Li, Candice <Candice.Li@amd.com>
Subject: [PATCH] drm/amdgpu: Add I2C EEPROM support on smu v13_0_6

Support I2C EEPROM on smu v13_0_6.

Signed-off-by: Candice Li <candice.li@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu/d=
rm/amd/amdgpu/amdgpu_ras_eeprom.c
index 4287743e121245..27fb9b640011c2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
@@ -159,6 +159,7 @@ static bool __is_ras_eeprom_supported(struct amdgpu_dev=
ice *adev)
        case IP_VERSION(13, 0, 0):
        case IP_VERSION(13, 0, 2): /* Aldebaran */
        case IP_VERSION(13, 0, 10):
+       case IP_VERSION(13, 0, 6):
                return true;
        default:
                return false;
@@ -213,6 +214,7 @@ static bool __get_eeprom_i2c_addr(struct amdgpu_device =
*adev,
                return true;
        case IP_VERSION(13, 0, 0):
        case IP_VERSION(13, 0, 10):
+       case IP_VERSION(13, 0, 6):
                control->i2c_address =3D EEPROM_I2C_MADDR_4;
                return true;
        default:
--
2.25.1

