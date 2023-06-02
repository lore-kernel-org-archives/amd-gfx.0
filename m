Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EF6EC7EE23
	for <amd-gfx@archiver.kernel.org>; Fri,  2 Jun 2023 03:16:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0342110E60D;
	Fri,  2 Jun 2023 03:16:42 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2057.outbound.protection.outlook.com [40.107.212.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 88F0F10E60D
 for <amd-gfx@lists.freedesktop.org>; Fri,  2 Jun 2023 03:16:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XrzEop3C3bQk2vqdBeUcVpeteGmd27zjjusXtZMIW5fN033VRgz0BZ/Euwwi8w+UPLIswwCkzB3m7td8xTjGoq2M84TPpTtSNpGoRGOfjT9skm6zWKaPK2uMKr6MxVe0jO/xGLawAdPyjwi9dV3dBCPbyKkCOI8KOPaJKumKqU8NIPL3XNoC5UoSABQJVMpitv7/RmwXwlmKXx+cLAbGele4ejsT2eFW8SBcBFEQFf/IHY1RKzAeQ5IAeJOP9uyqb9qg0lH6NVV8Zy9qZFalf8b5teCw1yHYhMlFJsnEvxp1Js+QnI6i6avWrlZFrcdbQ0TXGdKlWgjPiW/AyEc9uQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VByeqgyTubZknxzP5TCwYfK3gzPT6AiEkM2E8LGFskk=;
 b=FsfoFe6PMORCZWN7zc+jUkWbEAh3bwEIFF4ixjyXXTdWS0hqwXiFJzhcY4d6yYJdMJ1tqdOuGrqNl3iM9baboZGddsJh4Fa+nfqTxKEwpTY99SYhlCv1WH7QUUCDyhslgSHNFSLg+MCZ/Y93UJfc87iT1iobc1pRZSqsk7bEnMvpahcIxZnqEwwq0fd7y5FXXi4VPzwaIcR5xZmXpdqqlWbAQI7ZhiBT4cV+ZEIsnFOAIu19mxI/n1SOPbwPfouTHDv8vr/r9VDEBotdzgcZoUDZxKN4N21bOG4HYv2bQKFrg9kl9klRy8ZA5Xn8MbTH7mHcPHrdeZIcefjbB7D5Pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VByeqgyTubZknxzP5TCwYfK3gzPT6AiEkM2E8LGFskk=;
 b=f/mJgb55y4euAaV2g6Q4j743nQ7Yo2Mdi9YEG8X8sLv4+a3GNCHu4SfaeULlTThEez/N4kHNMpyyE89bF2qg05S7fwrQ8EuNweOsECYdrNtQGgSM6Rnv/U0hOSdZ+MX2KSeQIb6nk7Zhz0aBxmWxDZddDDIrihZYXgiIAvKzE3g=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by SJ2PR12MB7821.namprd12.prod.outlook.com (2603:10b6:a03:4d2::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.22; Fri, 2 Jun
 2023 03:16:35 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::9c90:4cbc:7d12:fb99]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::9c90:4cbc:7d12:fb99%3]) with mapi id 15.20.6433.022; Fri, 2 Jun 2023
 03:16:35 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Ma, Le" <Le.Ma@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 1/1] drm/amdgpu/pm: notify driver unloading to PMFW for
 SMU v13.0.6 dGPU
Thread-Topic: [PATCH 1/1] drm/amdgpu/pm: notify driver unloading to PMFW for
 SMU v13.0.6 dGPU
Thread-Index: AQHZlPvkuxj2sAQs9E+9fnZ8QorkmK921zdA
Date: Fri, 2 Jun 2023 03:16:35 +0000
Message-ID: <BN9PR12MB52576E4252D33CB862306CC9FC4EA@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20230602024150.1840-1-le.ma@amd.com>
In-Reply-To: <20230602024150.1840-1-le.ma@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=4923c3e6-366d-4762-b714-f6425d708a5b;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-06-02T03:16:16Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|SJ2PR12MB7821:EE_
x-ms-office365-filtering-correlation-id: bc4e4df2-8664-4156-5c51-08db6317c571
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BpD/rTtG+WlbFozJTbsAzYIK59CPjh7uKNNAhISE3gMJdwquaJvu8jPV+dFHsf6UR9wAS6g7Q6su011iDPoOw1DBF18B7YjHSsjOjRw1yaNLJaZvwCOqvXGU9SMOZi95o7ST2UYpG8Ao2ZP71Dz0/0YCrD0XPQC+/nTlwtFWipxEMJ4+pE6maQxh7dvfw60uzHIzENkEZun+fdhKnRgoEFT8gaXwz8uXgph/JCd3UMUs4yfysV1E/amDoqUjPn96wy4J1ouDCFVtE1RB0dHTUakIHjUvDMvpXYsV7CB/2IZRok2WCI8H4aFr4QomnmvUbSpTFoQl4ZGUa3/7C9dL0UE9+4M3xDrbA2E5wkO31SRPMrxvEpOTWkEErL4pEMkJuhvYFiIm3HsN299jaKDgVIqnklqDox5cHAvpLEvlIDaTgugPcg0LHPNFH5dS3XCCjhB1wbNiX6hg97li0+jjHvdSTXKm51C7AHqPVnjEQuhcnEr5r0rdm8Raxmn5kW5uomsQBNWjOlV4gii9rVmmZF0ACH1sPO4LmGwQ0Nl7z7YIiMSfZwMAJKJ5Z8JtO2djstkmJA3f2HOEo0iYf46fvi956LXZhH/333UvmMGVthe6Gs/SGnB53iA5HkT8h1X2
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(136003)(376002)(366004)(39860400002)(346002)(451199021)(8676002)(2906002)(66556008)(76116006)(66476007)(66446008)(64756008)(5660300002)(316002)(52536014)(4326008)(66946007)(41300700001)(110136005)(54906003)(8936002)(7696005)(71200400001)(478600001)(55016003)(53546011)(33656002)(83380400001)(9686003)(122000001)(186003)(26005)(38070700005)(38100700002)(6506007)(86362001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?1kKG0Ya6YHOU7b02n5Q0UQ7Rv0bkSLYHYitQRG8xUa+vQmc2E1Tyiu6Png1D?=
 =?us-ascii?Q?Darfvz9oAJ/a0TwRHerZ0srF5OFPU5IAs5bdW2LSEOncufbaZOvyyqM7W7VT?=
 =?us-ascii?Q?rtia/6PFsQwxkX/B1zhFmww7IJAXUEGXEoqBfS9BDVzKrvGdJBnut911x1zo?=
 =?us-ascii?Q?aeBNjgVY9ievxYlZ7t+tvxDOVPfkPtege6Obz23MnRQzmUTWUM4pIw2vobov?=
 =?us-ascii?Q?5JVhALVtvo91PlgzoTs+y3uSti6A30viwooaRrzRmqlSMsy1oKDM2v8ya7BC?=
 =?us-ascii?Q?4usJIkq3Q/l/BjY2C/vPdwqa0HSg5LS2xzsZfniGouqtWpNwSrQnSylH6FA1?=
 =?us-ascii?Q?1xX+M27JaKT7MwNaNFrAmI+qrJ8ZSnk349geNe8uXq190lwL4Ze0Prb6uUVt?=
 =?us-ascii?Q?/7gTVPEF/M/F32QuDCvn4O3wAS3k6g6yrlXL2Aw1iTPDJ8/87VJ0wS4mn+iH?=
 =?us-ascii?Q?L/HUSwhsbW87lVDnR+L0cGKLsE13ejXzvA8+ucZrPS2BjTbXiqd62pOshIr5?=
 =?us-ascii?Q?abWQxLastAOWNcpQfaF0MOZ2xy6UwDXNuUGVV5UkL3hhFTIUSB8KROXXQF10?=
 =?us-ascii?Q?TDUE8/mr/SYebu9P70GjC91i4AtQPwZbXzWD3LSUSRqlIOdfu05Q3PO0Dpwh?=
 =?us-ascii?Q?SLIOPoSvjkiLbChLUOD1Z3F6u3L1bcHJuz0ZQVwzc1fOcmXmXYADiPTiYFL9?=
 =?us-ascii?Q?Jl1MeL+8G4s54tWBzpBBPsB6I78Kwt5VHN0yViqr0jkSvO4rdL1R5UDat4R/?=
 =?us-ascii?Q?dI93G6yF8vVNBXlAMoc6zznTrj8hQu2Id1NR31XbfeCy04smlDfvhkzY/5yH?=
 =?us-ascii?Q?7hK8j7ZHPIo6lTq358FpTdASaOiHsg6NgWUbqcxEo0QQ1GjLXRcq8/ZcCuZd?=
 =?us-ascii?Q?f9hi1rpz+GkA4ZR6fKnp2LVfv+XGh1gufZQYYL7WGCZfPqH24hbtEj2jVLsy?=
 =?us-ascii?Q?dKO+0MiK6438DHsE9l8biw/pX5gZ/lG7t+dFZ6/htBennJ1qHuIRY+VTW7fx?=
 =?us-ascii?Q?I70+VE5MF1jby344pe4X3YavXTu5vgWb6wMLZhBYhJFR/SNV2FXCXLolDxKc?=
 =?us-ascii?Q?R6VPaqjMAcshyBHd17AyjSq5Hk70i2DrLhrBZmDrCyHa8r52hxxQT4I2oacl?=
 =?us-ascii?Q?Q3FEKxYF08KyPM950YeakaaJznDTj2ksz5nTaO4bewDaaMmic/radNJTcVaV?=
 =?us-ascii?Q?cJPkh7450QuYcK8kijeAZDeVd2jqCKqJx9NmsuKcPbZ7FCDYV6ZurcLpnM/U?=
 =?us-ascii?Q?/lvaNn9ZetdWZJkioRxY3fD1IWnNItmiyExvTZYPT8zpsp9vl+ewKq0a8ioG?=
 =?us-ascii?Q?CwdNKPrDmciKR53jdjW8bQJewsHP4rsoB/tjmsySWXGlBQso/S/V/Gpe5nxJ?=
 =?us-ascii?Q?wK5AvNKmNB7Co0B/PlaKPE7h+Dy+vrHpZYuYKkYEFIBlqcxQ5vIvewaHQY7H?=
 =?us-ascii?Q?HSzGGKMGIBIUfMhC55RUTDUdaNd+EPhl6BBagHq40smMCgenMl5IT5pxgScl?=
 =?us-ascii?Q?vOMi2mTeuRP8+HQRMDg1/XjyhhiwiWkSyHPh/bLPPj3AHSr8yo6BIrSfVZ9X?=
 =?us-ascii?Q?QTqKl35B3/s5hgKdaspQe5PcauEIsPYtZbiXa8Qk?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc4e4df2-8664-4156-5c51-08db6317c571
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jun 2023 03:16:35.0568 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jSmk5JYbYD+gYge6LMbPRiXxLDbzVNbP5Aq+iWsYk8qg01m2nqkzQOSbQF47iD7We2pbpMOk9GUxR49ohOnKdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7821
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
Cc: "Ma, Le" <Le.Ma@amd.com>, "Lazar, Lijo" <Lijo.Lazar@amd.com>, "Zhang,
 Morris" <Shiwu.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Le Ma
Sent: Friday, June 2, 2023 10:42
To: amd-gfx@lists.freedesktop.org
Cc: Ma, Le <Le.Ma@amd.com>; Lazar, Lijo <Lijo.Lazar@amd.com>; Zhang, Morris=
 <Shiwu.Zhang@amd.com>
Subject: [PATCH 1/1] drm/amdgpu/pm: notify driver unloading to PMFW for SMU=
 v13.0.6 dGPU

Per requested, follow the same sequence as APU to send only PPSMC_MSG_Prepa=
reForDriverUnload to PMFW during driver unloading.

Change-Id: I2dc8495572b0bce6e21eafb51b215c83d94ac647
Signed-off-by: Le Ma <le.ma@amd.com>
Reviewed-by: Shiwu Zhang <shiwu.zhang@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
---
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 3da614faf75d..392ccebc8dac 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -1409,18 +1409,16 @@ static int smu_v13_0_6_system_features_control(stru=
ct smu_context *smu,
                                              bool enable)
 {
        struct amdgpu_device *adev =3D smu->adev;
-       int ret;
-
-       /* On APUs, notify FW that the device is no longer driver managed *=
/
-       if (adev->flags & AMD_IS_APU) {
-               if (!enable)
-                       smu_v13_0_6_notify_unload(smu);
+       int ret =3D 0;

-               return 0;
+       if (enable) {
+               if (!(adev->flags & AMD_IS_APU))
+                       ret =3D smu_v13_0_system_features_control(smu, enab=
le);
+       } else {
+               /* Notify FW that the device is no longer driver managed */
+               smu_v13_0_6_notify_unload(smu);
        }

-       ret =3D smu_v13_0_system_features_control(smu, enable);
-
        return ret;
 }

--
2.38.1

