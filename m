Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B74FEC5B567
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Aug 2026 04:03:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0773B10EE1C;
	Wed, 12 Aug 2026 04:03:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="f6n04YlD";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011043.outbound.protection.outlook.com [40.107.208.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4045610EE1C
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Aug 2026 04:03:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uLrw7sRD3GDwR9BcGLh/fvQXNCoBUXmO6H+8HVZgOUtWjlBVqjJJYXB74V01JNJhQ4V6E/WTPZv2OF52sICZ6zKEQ0xCDWUGtcjSnIHAhkUsIYjfV6x+cxF+r2RYeealowm/Zhukyiit05YuL017PdnIzRzV+kuwS29U0SoICysFDnPyvEka1hd4WiBFCm69oZNyWeXaTjkDpua5kSaCvEkhCKrLnrMpyWkD70b+vVyLp1HRuGfdRHGt+BU6Hedal8/E/nIU6yJPdByu/NzcQDeWWmJmvMFeZBW0mmsd+u8m+BORDjaDzqskKsgnn2CCnmbEoy7RPJHulpplWidRWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HUu97VlUKV1ZqnJ9Za6gpJ4UKL6HbYq8jnqmJ6seJc8=;
 b=htyWK33i5/VK9B518BLtv6I/CtDyn0ofde07S9AIuqjqgRhOkB/IN9kzlYiB2Xt6pRPoma/9WbYvKKpQVOAQUi17crMI20tvjNkCPyhPJwH0IB64KbDgDesAEC+iPCVM3oCI7QN37haC5S3bKhdnx48zOxkAxNH3LjmI8B0gvrk8vjtdPLrC3laTIrCiCk4BNbUpv+zJaYbPEEPNtiPcFR8tojpqx1ymwu6b3AJ1SITKnmzD1vflwbTbuuQzPUTHw8u/3U+dvbQpGCupcNbpVSwm02K3eULcBXdWaqZxqNOspvhWUeN9iFbO2l8Cldru5SOiYh+xBvW69ZBh3mbwmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HUu97VlUKV1ZqnJ9Za6gpJ4UKL6HbYq8jnqmJ6seJc8=;
 b=f6n04YlDO+j8KjDtVxU1rUiqrPpJO3CuK0/Nw/W6UR7dUzMP9/IGUr7qe/sInR5nEdLw+53DmE9vrmXfNgOPF1U/N5ipRghLhZWVkPkKuqFMBmkYEE1SI1y7m5+pO5wTkGE2Y8vIzvRSCMGSJID6e1x8W3xb8f3BmMrPerYoPts=
Received: from MW4PR12MB6803.namprd12.prod.outlook.com (2603:10b6:303:20e::10)
 by DS0PR12MB8788.namprd12.prod.outlook.com (2603:10b6:8:14f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.11; Wed, 12 Aug
 2026 04:03:35 +0000
Received: from MW4PR12MB6803.namprd12.prod.outlook.com
 ([fe80::c193:ef2e:260f:dcfd]) by MW4PR12MB6803.namprd12.prod.outlook.com
 ([fe80::c193:ef2e:260f:dcfd%6]) with mapi id 15.21.0292.024; Wed, 12 Aug 2026
 04:03:35 +0000
From: "Feng, Kenneth" <Kenneth.Feng@amd.com>
To: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Zhang, Hawking"
 <Hawking.Zhang@amd.com>
Subject: RE: [PATCH] drm/amdgpu: check thunderbolt before switcheroo
 registration
Thread-Topic: [PATCH] drm/amdgpu: check thunderbolt before switcheroo
 registration
Thread-Index: AQHdKg1eef9a2Tc56E6vnL2Wrl3qY7aZyp4A
Date: Wed, 12 Aug 2026 04:03:35 +0000
Message-ID: <MW4PR12MB68039DF3A0BAE220A309F95D8EDC2@MW4PR12MB6803.namprd12.prod.outlook.com>
References: <20260812034733.2087420-1-kevinyang.wang@amd.com>
In-Reply-To: <20260812034733.2087420-1-kevinyang.wang@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-08-12T04:02:16.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR12MB6803:EE_|DS0PR12MB8788:EE_
x-ms-office365-filtering-correlation-id: f313ee45-8017-452d-8098-08def826ae96
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|38070700021|10067099003|56012099006|11063799006|22082099003|18002099003;
x-microsoft-antispam-message-info: +GQPU26oUcluFop6eSd/6rN+O06rXWtc3JEc/2NZtVWvn2HrjrmjAO4GD6va4VrrrEEVt2zHyQpcgp3OX5nBL62OyxH/8VkR0Iq5qj3zmrRmsXp8tC8ka3hHTvkSU0WREfgvI+AZVenklR80gB6IzM434jWl4PjGHboT0wP/OGrLVAb5BCZqj6xe9Ya4GFj0DRmpayVDSkFXI6r8DHyGvEIag2pfopyg7qBBYqera5Nw2ZavUb8q03ElgLA56mWcbggCDSESp3u9J2LJdaJdMsQ0diV9q/2yTYxlIuOLNF7WTMEMDhosUtNM+7qpMgsKswyKwCeSM2SDSGx6RV+OBpzJHRNOhTpvWA3WdzBNp3PiVxscv6YVvtAXiF2lxriZqS8XpMLOBw+w1KdLF2maRoRRTZqv0FJ0o4QekYqopR+5f08EUlbaFE/TU0ZvOfqZxu5nYr6jzGyK47zZ2dA+JhyC8P9Zhe7GYeWb5YhWW7uwujaQPWdHsJKngrUEKNUYmcBqnuCtOFEg43nZ3L6NUwakkOCLGgFNy/RE/0B/kbYLsnevOxoGUPkbZU/7wTrsogN2V6vlaEw74KaKQ5bI2mjCQni1Af5v2SgL6ZBoOPJCX6DpgiKCGLERFtD+S8sFI/0v05n3dQY6sMTdYCMbdX8qAqX/DU5EoJksEyE7ZLI8LaYELeQ7R8wWlIXsYFiJRwIeViXkB8N6S7uO7ARddU+BBOlqTXGGJIqjh9kEue0=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6803.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(38070700021)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?aPdeurULMoAT/Rt9jF8alQBb47KmC0xpEDLPWIC956l+FdhvySd0zKg8ElzJ?=
 =?us-ascii?Q?RTWfSBWmOT3wU6unu8cBrytDlqnnTOXnnVJBxi/PImEQ1IlICoPWz1GTUwgd?=
 =?us-ascii?Q?gD1hkLI6g8SLZSlAmdn4iUCeYlTSKg7LxWW99ZgtjC1zT4kav/j+hSl2JdnT?=
 =?us-ascii?Q?fgVYzA/3CsTMAkQXSWNY4lGE7+kgfO200fanDE8mcmLdgDrHz4Zbc1THXxFz?=
 =?us-ascii?Q?6iRO23rUa1SoRUb+ttr5IoLp4npwfoAMQuTKYsCYGJYDoyelDf7lmYkwcPFt?=
 =?us-ascii?Q?9YpSVE9Iyd2v/QLPx+AUN+VzlF2m7DfuqdH2BteyWKeriCmaRYBTDgRbDt0T?=
 =?us-ascii?Q?NpC+gNmJTEISX4aEN/duAHK9LKPF8jG5X0nU2YY2zHPH+czyKzBHi49dxgMF?=
 =?us-ascii?Q?9Qw4aIprZSpazeLaoep2aVWk8CqQCPj6SbjCdH46t4TBqmXmk3iMWxm5AKw3?=
 =?us-ascii?Q?fkxQg8wEH5y6NBAll4CrIjlrdhQaGF3BTcrkRWa+qlMD4sXaZE1b6z5n/wDb?=
 =?us-ascii?Q?hjDqk965MbIk3mw6e+AHM7zbvNusT8qUocEcLEtRahOH0tlje5iKkFuKJXeA?=
 =?us-ascii?Q?prwFxJMEYGv8kr57dMnS2P8aCFH/7oBiHuUq/d0YV2QrG5A9/DgBoSRHM3Ht?=
 =?us-ascii?Q?sIRirv7wUEhYpLmzvrCnt5sMu6UKgGudfi6AIjZ5kPLqcQ+V1HsYduR1sr7D?=
 =?us-ascii?Q?Sh+X4C7cH8K7nPTOPJINhIH9nE28TfxUgYZxG8WGNXMxtC5gaEIIbVeQc+64?=
 =?us-ascii?Q?jUYGPDEINfWslMnIwpsnsg4daGW68Hm91hTdREz+d9PP5rKlkpYHKpT3PVjg?=
 =?us-ascii?Q?NAVEm8hzIW8E7FQ1Uul0HlPZzd42WcuX7CjOhx4A3HTW9ALOgWQZUQDuSt2j?=
 =?us-ascii?Q?awTYupLwCNE5uGbs7+JiQOinWnWWSrv+BxtF8L5JmYTqa9NCtlknaowsEof+?=
 =?us-ascii?Q?U3JztGV+ka40mjrMgrlanBSAES054x91aV0t9/8Aklj2lqvepJ+VoAaCl/uE?=
 =?us-ascii?Q?bh8PNJcCeIMaJe+AHvTeeRraAMCX05aNAcQtmfFXmv4TX3Gf5CBDqJ+C3VPA?=
 =?us-ascii?Q?i6PnBV3JLFr1assw8RZ0eOZxa8v8uq5ARwfyLXIN6Ll7qkWtvaqh90AWJhMt?=
 =?us-ascii?Q?G5xGpmV6wSth6/pK7ovI0xHBBgdvLGrQVpPnA9Qo4kUUKjJi8ayKnSvQZJBi?=
 =?us-ascii?Q?y7+qEZml0hS7Oi64zFuJ53oL2vFlOalZTd+3fdTWUmrmef7hNj8XP/nPU6Af?=
 =?us-ascii?Q?xJwMqV1K8enAXSqa9oIHcWg3DHiPi20nNldTTIVPvI2yy7/5KvNPjsfFw7w2?=
 =?us-ascii?Q?TfxArZj9wIx78W9Oqf5+A7HjheUDeEYEC2RoeoyqB6qG0cipsdMdqEMKemPM?=
 =?us-ascii?Q?xxFXtLwYxPvku7FdJAePkR1LhTWWfpe1eHYvnrGVSrZS5efJLnTdTPgHS6MY?=
 =?us-ascii?Q?Bdu8+7W0/K7Bn0r3RQhZeIdvVPigwT07bNdBaSXh2xZoSsJ/MHNd2VVYxNak?=
 =?us-ascii?Q?YwEu2U5lQ3mKmUEMvZ/2UwP2EDfJVJmJFSiobg+aIyZAffoZZvkP+BWABpTl?=
 =?us-ascii?Q?SGnK2CO5KX+hXCmpuN6rdPDFwdh9lXLgRHl+lE1988YEdsCIQJm81mxIErCv?=
 =?us-ascii?Q?pPHo+4MPMH56LwW3kPZyQihGHDj6WhqMywBvSu5n/OVvheCLnBv3RN7wFfyW?=
 =?us-ascii?Q?Jdbjh7cViCwA0hZLxlMxLvCYoW/o/QZv/DodjuniOayXlExK?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6803.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f313ee45-8017-452d-8098-08def826ae96
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Aug 2026 04:03:35.4424 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bXU0pnI7HQUj6fX42D8hGNslw2dStisfz0H1Rvt7Jqm0cMObkTXLBnhovgDm5LmM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8788
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

AMD General

Reviewed-by: Kenneth Feng <kenneth.feng@amd.com>


-----Original Message-----
From: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>
Sent: Wednesday, August 12, 2026 11:48 AM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Hawking <Hawking=
.Zhang@amd.com>; Feng, Kenneth <Kenneth.Feng@amd.com>
Subject: [PATCH] drm/amdgpu: check thunderbolt before switcheroo registrati=
on

introduce a helper to consolidate the vga_switcheroo registration condition=
 used by the init and fini paths.

keep the explicit pci_is_thunderbolt_attached() check, as dev_is_removable(=
) does not provide equivalent coverage for thunderbolt-attached gpus.

this ensures such devices remain excluded from switcheroo registration whil=
e preserving the existing px and apple gmux handling.

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c
index dd48ad6e9c52..5fd9116d3581 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3807,6 +3807,14 @@ static void amdgpu_device_sys_interface_fini(struct =
amdgpu_device *adev)
        amdgpu_ptl_sysfs_fini(adev);
 }

+static bool
+amdgpu_device_should_register_switcheroo(struct amdgpu_device *adev,
+bool px) {
+       return !pci_is_thunderbolt_attached(adev->pdev) &&
+              (px || (!dev_is_removable(&adev->pdev->dev) &&
+                      apple_gmux_detect(NULL, NULL))); }
+
 /**
  * amdgpu_device_init - initialize the driver
  *
@@ -4257,9 +4265,7 @@ int amdgpu_device_init(struct amdgpu_device *adev,

        px =3D amdgpu_device_supports_px(adev);

-       if (!pci_is_thunderbolt_attached(adev->pdev) &&
-           (px || (!dev_is_removable(&adev->pdev->dev) &&
-                   apple_gmux_detect(NULL, NULL))))
+       if (amdgpu_device_should_register_switcheroo(adev, px))
                vga_switcheroo_register_client(adev->pdev,
                                               &amdgpu_switcheroo_ops, px);

@@ -4424,9 +4430,7 @@ void amdgpu_device_fini_sw(struct amdgpu_device *adev=
)

        px =3D amdgpu_device_supports_px(adev);

-       if (!pci_is_thunderbolt_attached(adev->pdev) &&
-           (px || (!dev_is_removable(&adev->pdev->dev) &&
-                   apple_gmux_detect(NULL, NULL))))
+       if (amdgpu_device_should_register_switcheroo(adev, px))
                vga_switcheroo_unregister_client(adev->pdev);

        if (px)
--
2.54.0

