Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EB41C77B73
	for <amd-gfx@archiver.kernel.org>; Fri, 19 May 2023 02:08:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 98DEF10E59E;
	Fri, 19 May 2023 02:08:40 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2049.outbound.protection.outlook.com [40.107.244.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CE3A810E59C
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 May 2023 02:08:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bqW0XNsnKEhdYr3/XboE6NWv+yDoqvTpljNvmnt4ItSk4hhBTOT+ZawJckoYa74bthHb1pm2/217i1VrblLOafgai0QEUOLPhksNWsLOIWzTNVjl/sa5PnPvdAC0Ja6uFQ1do5Vno0BgOvLgp0lJioWnGIHpkwtZGyfHZgJ5iJlRDdxqrY5cH7VhTKjH+2B4E70VE9Ro2/oj01lA0gWRPGx/qZMgo8aMWNWmfU1gzvhiBcRRXweEx9gkrqmPPvfPHshHgxq3SH5mTAwSd+wIAUFPvVaQpiKa1qsCnGW2dm1tqrF230oqwOi/wppnvz7DRfsJ+eusqK37jz/LDSAFaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mLXsuL1jEYoUqo8Q6mhoVUnyW3VndR6aL2gyuoo9ZSQ=;
 b=fp3V6QvsGl5NCRPf6+Q6rVrXlPdaHyyhTCSh36/rcLLo4RB5uV/VgOvH8NEyU2GyKDAm6sRzM7OaY2yJb2khYUH7cbQjlg45Xwtoncj3at0ilYq2LpJ6v80DAZvy0ymHcZwgWJf3mRguE24gZ1zEx/hxCyiAUrvKYuHYWDKyh4ljnugZqWuoaKlCgPXi84sCDB0+kRGq98CuSx2okBpXRZ9qD8X7K+pwecl1+q9ShaxF9jsRWN8Qn772Cdd7h7rtFG+60V+bp9YeTSvYc0tMLGWLUjd7CiRP/Yhqff+MxIWLLa2XEr6mxxJhg8iSi+1ygZcCWZj3Yr2GUFpWsGJJjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mLXsuL1jEYoUqo8Q6mhoVUnyW3VndR6aL2gyuoo9ZSQ=;
 b=Ro3W+QMgWMwz1Lmr+MaIrbRyGx6e8cAAe4yTz2eNwFSzVu9p2GfDzDP3rea3Cku+lGHepZVgUIAHac5iPKXwZE8xF1Cd0AYxAMpnZADkhM859i/6dg25ufFCUcXXxbIVljQbdkvobLpxeUm9ig61Rqilldj6DQn3q8Efpz/m+50=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by BL3PR12MB9049.namprd12.prod.outlook.com (2603:10b6:208:3b8::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.19; Fri, 19 May
 2023 02:08:34 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::95d1:b78d:686d:2ec6]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::95d1:b78d:686d:2ec6%6]) with mapi id 15.20.6411.021; Fri, 19 May 2023
 02:08:34 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Zhang, Morris" <Shiwu.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH v2 1/6] drm/amdgpu: add the smu_v13_0_6 and gfx_v9_4_3 ip
 block
Thread-Topic: [PATCH v2 1/6] drm/amdgpu: add the smu_v13_0_6 and gfx_v9_4_3 ip
 block
Thread-Index: AQHZiYNYKphPrB2a7kuRE+HLo+pTtK9g2npQ
Date: Fri, 19 May 2023 02:08:34 +0000
Message-ID: <BN9PR12MB5257543106720333A777C9BDFC7C9@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20230518122059.28815-1-shiwu.zhang@amd.com>
 <20230518122059.28815-2-shiwu.zhang@amd.com>
In-Reply-To: <20230518122059.28815-2-shiwu.zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-05-19T02:08:32Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=aecf931a-930f-44b3-af6c-167c724efe50;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|BL3PR12MB9049:EE_
x-ms-office365-filtering-correlation-id: 72b1562d-37ad-49ad-ec4e-08db580df344
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8vBduTB7fWsxsE+5SMDWxPh/JzJ6HlIOzVmiuwcRoS+00ulHYDqVpA7vEZoWDVA9PPfe35FyxsjVh+clmaVy4HujqWHaSTlli1SB5ZGsJnreqgqaKZQtL6fkLA1zhXbQRfEaHeVAFG8JjPXKuma5YuHTmxo3JhuGg8il4KTfQeBNVGLb/GtrlfepgHKfPZw78vfLXbLWiTpqcD2dINF0gNXnjSedjWnGVMMelYtXDKL+gAh1LP7zFAbx1z+5oi2GT1wZKOUEadqvM9RbZ4NW0mSsjKeXszNsjL9z3IENrLwsTz3MuCv6ZUBY+x/kBAOqfa59BW7++NYWOnCtko7NTmvQv/3JvemQhqK5yDQ/uLvX9F8X2JlE8ytC9d0p8rtr0htCmcHLvM11G3sMay3PFwJ7NnKvWaZfobWkv7f6jv4W2Bg1dZw7bMA96hmokHLGclfGDOk17mosUQgBj3k1Gwjc6JB3piUaXI9Le0xhL+JOz29WHZocSxGoGeX5a+D55K6tBWOK4huE/frHq+kshb5yj43oa6uqzy3n1NhTVZQAC6q+bHYxU6GVWreW4sI4nuZ7U+aucnziHi4PjBuXZL8VqlCFzSV1UI0ky6CO+74=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(366004)(396003)(376002)(346002)(39860400002)(451199021)(86362001)(316002)(110136005)(8676002)(8936002)(5660300002)(52536014)(66946007)(41300700001)(38070700005)(122000001)(33656002)(38100700002)(64756008)(478600001)(2906002)(66446008)(66476007)(76116006)(66556008)(7696005)(71200400001)(83380400001)(6506007)(26005)(9686003)(53546011)(186003)(55016003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?86r8kBNSW1Pq+ApRqzK5mFcaA09ZFrM2iVLzUTnYOnIRN6c4urwVnuvAhJZc?=
 =?us-ascii?Q?cI49uG/TemR5Ry+3blPl45VTAMRylX1Rny3NZ+7sY6eLN7zcwofH3GPGWmEA?=
 =?us-ascii?Q?lXRbxSUu2F/7mEenpZPjVfZayRy1z7FhuKm+6FPUskAKP2/Zy72bKl8LPSv5?=
 =?us-ascii?Q?z4+RLpHsHaFQWNAWz1OSLc/3UzxFDFiTHb26OOz23mF25lWwHnK+TrmWKdpv?=
 =?us-ascii?Q?jdmJpLNI8rjDMZV4gq4AJfM+O+FH/n06juCDMHGuT/Va/oaSSRVRuvtpj5lp?=
 =?us-ascii?Q?PZUdg6rdInx0YFvgkRE0We5qewU7luKp5CCIwAQhgcM7QgGAUVKlZHP9Xhse?=
 =?us-ascii?Q?vtgZ0rfuArXa4/hnkuQbz+MwKI60scR4bU40ojfRW+wFW8PTj+z6jJiCWEsA?=
 =?us-ascii?Q?PE/DsYwFI+Gj2yPhCvI9c5k0C93XAx6WW6jQE/S0RylMDsIInjOTK9RLFbIL?=
 =?us-ascii?Q?QM3No1dS8Axzg8ZvLKWmjcr6OlkxYbJc85BF7WcVv+dPgMioZ3EeCGl8yh2w?=
 =?us-ascii?Q?Ak3U4eKwxhHEOMxZR5+Im2fpJrvLopcX5zxirXzxOhM7sQx/evxUls6L0KXk?=
 =?us-ascii?Q?Sk9FEZXQSKoANUUz93qqSESKL+haB3fdGZ6fnU1UpkYufEzNsFEpCd4+5BJ5?=
 =?us-ascii?Q?XoKKS+7Oq7Cs/EcUw3OL7P4LzqjrLr85MQGMoaoef4qqvIsjLI2TeQltOhrY?=
 =?us-ascii?Q?8tBYkpcsfhNRb3bVWOWxNJ4NBpQ+G4PN1juFhXvnmWaLtPv2u9Lmne5rphVE?=
 =?us-ascii?Q?Sh+3HnbPLvbi5PXgO85C16bw9/p/SbFu+9gf7+nLQEVkKk2ZwJ+U+P0q2trG?=
 =?us-ascii?Q?EC3vnRRpcNivRxpRXLse5guCuKiEu8PcKvy54ketuaJxZ3wpvHBZwELWQXhV?=
 =?us-ascii?Q?MsmHaRhZLxNp9Dv/tmVo1KQqtkewt5eBfnWB/o9MMy7GSv6AKYezlgT0v5ug?=
 =?us-ascii?Q?Bx1GgKiP9TgXVisBmXb7arv0HHKFItpwB7fiwfLxJxBQWM647PHxhilawtrg?=
 =?us-ascii?Q?TGNMFfUGHReYWLAP9KCaj00EeTg2OVKBad+5lyEvH1CWxXowZ9uZ+S6gMnE8?=
 =?us-ascii?Q?5XyX6oMkKkAjeDR5NAH+pC4EE9Y70ldJHeEdLV/jIVUHuFYtZmoxlMVwJoXx?=
 =?us-ascii?Q?KldSckzYqS0z13uuRJnZm1fL2/AGMIwZ3evCE4OO5i8+t90Y/xfbP0wYs45N?=
 =?us-ascii?Q?9B+tagq9bwdiIOxvnXj6CJBgoeB05Bj4N+8VqD3BQoF6g5OusRSizreThK7G?=
 =?us-ascii?Q?TTkW8OJYD2oLodIo+aksYhdHOaQdMe264OGtsJSmlb/RZbuhCHeFlCDugVTB?=
 =?us-ascii?Q?tF8H1Hwr7X0uR0grji7IRnq8Vb2lJ7mWk8GzhUDg97PB6WbYaeXtCPElInqS?=
 =?us-ascii?Q?UuFdoHZHFvxguTCitjpDFC9cbu9N8yfCKypoP/UIBfSBbJwzOKe9Q89KPEh3?=
 =?us-ascii?Q?4uENvAC7kbkB5rh7ZNTkyQsGK9ZTddxLNWY4B6dZRPysz8/azgAneGb/dZaN?=
 =?us-ascii?Q?VPYMnGeJqrDmaay9+X+ErcgqKKlgaZ98qefG14+poM6gTYsSWYk4PKCZJXZC?=
 =?us-ascii?Q?SECQsCpJQs4X4D8m7ew=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72b1562d-37ad-49ad-ec4e-08db580df344
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 May 2023 02:08:34.2011 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: H53GJdswZc7scGLpn0LnmxD838b43Uuhcjc/CTn03BcEP2lfw2Z7Jex8HzVUKA68vn9vq7S/6DqEWUXtM/5HPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB9049
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

The patch is

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Shiwu Zh=
ang
Sent: Thursday, May 18, 2023 20:21
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH v2 1/6] drm/amdgpu: add the smu_v13_0_6 and gfx_v9_4_3 ip b=
lock

Signed-off-by: Shiwu Zhang <shiwu.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_discovery.c
index caae6bf2fd30..a0685a5ebda6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -30,6 +30,7 @@
=20
 #include "soc15.h"
 #include "gfx_v9_0.h"
+#include "gfx_v9_4_3.h"
 #include "gmc_v9_0.h"
 #include "df_v1_7.h"
 #include "df_v3_6.h"
@@ -1795,6 +1796,7 @@ static int amdgpu_discovery_set_smu_ip_blocks(struct =
amdgpu_device *adev)
 	case IP_VERSION(13, 0, 3):
 	case IP_VERSION(13, 0, 4):
 	case IP_VERSION(13, 0, 5):
+	case IP_VERSION(13, 0, 6):
 	case IP_VERSION(13, 0, 7):
 	case IP_VERSION(13, 0, 8):
 	case IP_VERSION(13, 0, 10):
@@ -1893,6 +1895,9 @@ static int amdgpu_discovery_set_gc_ip_blocks(struct a=
mdgpu_device *adev)
 	case IP_VERSION(9, 4, 2):
 		amdgpu_device_ip_block_add(adev, &gfx_v9_0_ip_block);
 		break;
+	case IP_VERSION(9, 4, 3):
+		amdgpu_device_ip_block_add(adev, &gfx_v9_4_3_ip_block);
+		break;
 	case IP_VERSION(10, 1, 10):
 	case IP_VERSION(10, 1, 2):
 	case IP_VERSION(10, 1, 1):
--=20
2.17.1
