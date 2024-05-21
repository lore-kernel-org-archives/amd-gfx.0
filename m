Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38BE5C25B74
	for <amd-gfx@archiver.kernel.org>; Tue, 21 May 2024 05:24:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 210C510E647;
	Tue, 21 May 2024 05:24:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="LkyaCIT/";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2048.outbound.protection.outlook.com [40.107.223.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 39DB210E647
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 May 2024 05:24:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O2NU6VUoFZBr6ikklp9wrw6fl7Uzg1n6UgadZ7enVJdqHRnkwXStdpZlu5lpko094gFbcBV5bO1vEiHAaxshO8b6rk3F1k9o26OM2ZGLJQ60O0hLx6BjLEDMEDO8CQtHFgL1wBhuLlTWmKIm1TyJKswIslhlR1eWke74d2tTCkGHBqOdcarkO7J2/3TGnUm3oBWePJZWVFyKsS6IC0I5eYV1BW/Ez4bDWOkExeSrsf40zqXlXlogDvqa3225urbUhPKb4WOW0sYf8bDqx4jMS+cFnE5kG8s8HgeCCYgHfqnkUpuRzRofQzUP+ppl+gbXBpb7T+d2WplrpbMRUcGXSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z3UKvmf4vjtFGqFnizAnki8RMdv6XLipWL3hPP3S3OQ=;
 b=G5VYWnnbBoWrmHqSk+wEbUee+B8wfOD306JPL0U4qw/F1RKPFUkjicyTwnzO2fgrk9GlgtAfk338iutSOzLapCEPBg6RFUf1GoUcbghlqO24AyHXjZnA194EYTmlVSkroDtX/O5RvbTQ3S40BlUiwDcCLqTBY0XJmayIURtZFZ0kyQ9RjkjYzG009r3fSsomeUNjhw8yKshFn2uL0MBR3hY9hVVyUsGuTtUpjt7gnLXYMJZVWG9EI1xm3kBe4+vyd4lZJsoLA1+RH90YTVH2UvWI+HVFmMVmRm4qc3Ik0wQdGVj6HgATKFpLK+kxuOPo4S0KaTrU2MOgn5YRbjn6IA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z3UKvmf4vjtFGqFnizAnki8RMdv6XLipWL3hPP3S3OQ=;
 b=LkyaCIT/YxeAo+xYMbzM0NNTypalBwhpKcqXRnR2D6M4zQBkERh0fZ1+GA4wO7KnRmnP7Vky2ArNMRjzddztT1xmokU+GS1+c+/cmOrsUi8dA4ocwRvDOgFgs6m99dnrP5kpEJpAqB4FMCRl6fLpzx+kQjIRbYsDWF/aVW4em50=
Received: from SA1PR12MB5659.namprd12.prod.outlook.com (2603:10b6:806:236::7)
 by DM4PR12MB6109.namprd12.prod.outlook.com (2603:10b6:8:ae::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36; Tue, 21 May
 2024 05:24:25 +0000
Received: from SA1PR12MB5659.namprd12.prod.outlook.com
 ([fe80::e783:dfa3:88e4:d166]) by SA1PR12MB5659.namprd12.prod.outlook.com
 ([fe80::e783:dfa3:88e4:d166%7]) with mapi id 15.20.7587.030; Tue, 21 May 2024
 05:24:25 +0000
From: "Min, Frank" <Frank.Min@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Gao, Likun"
 <Likun.Gao@amd.com>, "Feng, Kenneth" <Kenneth.Feng@amd.com>
Subject: FW: [PATCH] drm/amdgpu: program device_cntl2 through pci cfg space
Thread-Topic: [PATCH] drm/amdgpu: program device_cntl2 through pci cfg space
Thread-Index: AQHaqz7TLPbkKJ28lk6jMq5ZVhobcrGhJ5Ag
Date: Tue, 21 May 2024 05:24:25 +0000
Message-ID: <SA1PR12MB5659DAB6257465D37B5DA89DE9EA2@SA1PR12MB5659.namprd12.prod.outlook.com>
References: <20240521052004.17905-1-Frank.Min@amd.com>
In-Reply-To: <20240521052004.17905-1-Frank.Min@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=ea865aff-74e2-459d-90d2-ca4121ca5c4e;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-05-21T05:23:35Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR12MB5659:EE_|DM4PR12MB6109:EE_
x-ms-office365-filtering-correlation-id: 6b092fba-254f-4c71-1a04-08dc79564757
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|366007|376005|1800799015|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?OP+dkvo87HaGG/Q+Zt6AjoUsASjDJ4IUJLqJ52uAfMqAR++a4wj930DOyj8R?=
 =?us-ascii?Q?VsabbPvKZcXh52AXsXPwBKRryBzyyflIBCPgfkuwJpMYVBUzU6ftaEAXRJfJ?=
 =?us-ascii?Q?E2gu0wDmTWIVvGKCDpPFXlgUDZJ//b6xvvoEBIAI6N0POUCn4BKT9txtepUb?=
 =?us-ascii?Q?wUlYYTPJt8bPEj9rWLIgc7ng9I0TFhP+krBLLcWpXGiEySXS8oUjo+2qJ6/B?=
 =?us-ascii?Q?aXGoolcKK5LVcMYKspNGOmmddGKaVgFldwpTZWAGCf0m3kKM+fyTS5kfy63J?=
 =?us-ascii?Q?6afWKuPQR+q6p+fIuUomSvRa/wtiJtvpBD/VxWsArRjtwHgPMy5MtHlyZavJ?=
 =?us-ascii?Q?O6ve0dHbJxc0W/wHY5gBBsTk+tuGlKwusjnH/MepgtyT/tM8R4FToXvaZRDt?=
 =?us-ascii?Q?P3AOt/2k4nq/+6yUZyTmGa3R86fUShXhX74fFMeMgp0/k8r/AYJlqTvpUyq9?=
 =?us-ascii?Q?Btm/SaQEK4RoQsMdG4coUb7sUPE1QMim1avzSOhxoH+BlB9bnFn7UUxfk6rL?=
 =?us-ascii?Q?oSMELSkyFhbE4CqHw8jhExNc0G5LsK8agSIJOzj4scf0AT3HNzQWOzcByaLP?=
 =?us-ascii?Q?XbANVPYwHvygS8J5GnXdoIJ5izqgd8gc8qNR40qfx1K9y+VX5VttAoaJmDQp?=
 =?us-ascii?Q?R3TnD2f6d6+vLeJ6T5bcX7MrzCaaGtKFKWCLSIUKOX/Ol/2SCDxlKJ/T2W1c?=
 =?us-ascii?Q?SicO74OGTxdmhaihGyRJQ7Its7e0E5Uh3tHjTjqrtBXx0LeTIYbZzJ//2AFK?=
 =?us-ascii?Q?hOore7eOwK2KO63Wgkog6AytAzaja/VetY1YmHr4HzfbhmVp2x6acLgg8vJF?=
 =?us-ascii?Q?K2WIyC+ojpKSm7Xydm59Mdthr69KLcAbEeT/4T7kLzycLDu87TaSEgSJaV96?=
 =?us-ascii?Q?8Mhqhb3HJljz9n6mLp6fl06XHLINJjNhicJk9QUjZLTy3k0+Yupq8A9dOctq?=
 =?us-ascii?Q?b5ym5zom34y2JEwf0sYYGa2mPw61u6MCxfWONPCZCSGF0ILBYlKKj0Iq3wu3?=
 =?us-ascii?Q?jIzSEAYSy8qkScH6oas2EoMY+AhVGtyA2tUc3rfRSgqHyWgesxMLclz2LUGV?=
 =?us-ascii?Q?GSGkkW8cNfA6RqoLP/21vgcg7CfIHDqmd89LKvBFzMcMJhcNROYOdaHofCcR?=
 =?us-ascii?Q?8kjmkbF4LWbl+Cg8dT04MWkQygtxNBEUujMVqbnwXrTJD8lrlxi4dzqPr8fg?=
 =?us-ascii?Q?RURzjZXU2FThs7eA5LPO7bs1A2kL/m6H8HD8/q1+Y8cUDk20RZ1RwqWRNuf9?=
 =?us-ascii?Q?n9Afb+N/7OBCnuUmC/BKfQuLicbDTVzP/0UkeFiBosuAq+/Bo3CKLv1vXqZL?=
 =?us-ascii?Q?TPcP5OKLI5qQCWdJ8UcJEWv+yTKWZtgByXUX2OM2/QiWJg=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR12MB5659.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(1800799015)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?HnPVJ6cmKdTEb5oQDi3EhGtZAWLX5DUAaME+oLW2MKwtSqLoNrWLe4ee4Y2+?=
 =?us-ascii?Q?rHuX4C4apI6zbFbSNuqNVoypgwL+hwB47qUj70ZeErC+/TzOyUnKxuFxmeew?=
 =?us-ascii?Q?EpoB0t21mlGx3uVObR9LukvPMSKf2SOj7I/tCH82qdueQ9gy7oIAp38C2erA?=
 =?us-ascii?Q?sHS3nfZj/zPSqJCTwbyjJm484ksU9UC1JummgBruq9P3Kmq1QuNkNyWWdKoy?=
 =?us-ascii?Q?6AW2rAho1EAzGf/P/mDMe0thxVyyMbzoo80cb+M9eGsnCPcQ0Vk3a9SdVGSI?=
 =?us-ascii?Q?3dNKv/2YRFKRy+R25JVppI/otC12YUz5jN2Ks8x1AU6deiAGOSLTScjLBXhO?=
 =?us-ascii?Q?47UpAoa9BLslk+id9TshwmKScWKv2XyLJfCSjGvMRnKpQMOSlf7FLcVbGJaL?=
 =?us-ascii?Q?SyJ/9tNa2zd+fkyumITjS5t+mwhf7LizuqooAEoQuwhQKEdMXbThXH/o/ax+?=
 =?us-ascii?Q?g5h3vfDTzr9SGCs2gwkikpmJ50ex9KikPEQWJnnbisIXxL2dJem/O+vwih2R?=
 =?us-ascii?Q?4Rigp4exvW7KJdr9Y162u5ZAsevq4/yaP7M6dTg5Ir+OzRihFxOHboueUOaH?=
 =?us-ascii?Q?zWoLE4p5qRJtT+NCQP8FE0mmdXEAWFOTExV4OVYFzwSo345qB1erwrJih8G7?=
 =?us-ascii?Q?Wk7DeZUksIO8l64GBdIgsuE+uPo30FJeXStv4sbCTnPBzTYYDUFwhSXmvAs6?=
 =?us-ascii?Q?Jr02GRgWR1UeqAHmYJcVwpbqGKAijdanN5tD2M1XhzApalbqs5gxBktqRQIv?=
 =?us-ascii?Q?0dB4dHNh24g+/GpNOTtzzS5OJBrMDjYh5xyByFeaIb23jPEqs5AqhtmT6PqF?=
 =?us-ascii?Q?FTPrw3Xszs9jOWwbW3Wpp6gD8wFW/Q5YclKE/JoXs7I7KXX5SWaw520Ryw3m?=
 =?us-ascii?Q?kuIBodUNmjPeI4WR2I0YtMm2PPGRAxdMcoleJF9Sd7T1z4bZdIz8NVvaiUs4?=
 =?us-ascii?Q?5/Ie4BtKndGXPTicCll21rqf57OyzO9qCnqix+Tu4jiGsoHpcCGtoc9JGScf?=
 =?us-ascii?Q?Ro9wCqM//0TMQQYI64GaAzdkR3j+ka7FHcyZUA5ZFKEivVscLvDg6exKnwac?=
 =?us-ascii?Q?34TNdVwM8/xiWUxnv5P8V6D+exSplYZ9C3+/eCjuNukbqzvgBUB57iPDZUkW?=
 =?us-ascii?Q?f/ASNuJqi2vQed7jkbETIthcfzA5f+nigZDH6ugtIxZpK00wgkI4NKekYnIy?=
 =?us-ascii?Q?mX+Tg++vzL1tcUebaEO6+msbY9H1R3uPRBd82rPHRMrfJcR4Kf4ekVe0ACgt?=
 =?us-ascii?Q?qUQOTLT+pbU690ZCwj9/hgF0ooD+nsQjCsw/T5iWr0ap3iOCR2cWEVobnF60?=
 =?us-ascii?Q?JOhIRCDcQl8dpAgsXdApSoIedzPIThQaRqSt/Oho9kNWP983eCgTFOuJSKvd?=
 =?us-ascii?Q?6hYFN2Yr7vsKXtK3p6PFfMiCXzrkKpClhYgAArt2u6ySqactGrzxraGsTXh3?=
 =?us-ascii?Q?ATf4WACpCe+o2/oKSeed3gL33bIPjw2zbzr+jG4NtsBfb+RMll1oK2H8QfYK?=
 =?us-ascii?Q?uOXLN6+Dt/AxkfRK5vDDsNCrp026X5dVn6AJ/7hb70LP317KbAr+O7qowJ5t?=
 =?us-ascii?Q?IBq2zOz/aMJ8h+A0/zE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB5659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b092fba-254f-4c71-1a04-08dc79564757
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2024 05:24:25.0245 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0UriBRmaWBX5TX52YzhH7Q5hx8lp/Ajf53EGX6dyh1yqg2Snp7i3b1V5jNYQ7J98
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6109
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

[AMD Official Use Only - AMD Internal Distribution Only]

From: Frank Min <Frank.Min@amd.com>

device_cntl2 is accessible from pci config space, so program it through pci=
 cfg space instead of mmio.

Signed-off-by: Frank Min <Frank.Min@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nbif_v6_3_1.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/nbif_v6_3_1.c b/drivers/gpu/drm/amd=
/amdgpu/nbif_v6_3_1.c
index fe64c04ee20b..5a20bb229788 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbif_v6_3_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbif_v6_3_1.c
@@ -315,6 +315,7 @@ static u32 nbif_v6_3_1_get_rom_offset(struct amdgpu_dev=
ice *adev)  static void nbif_v6_3_1_program_ltr(struct amdgpu_device *adev)=
  {
        uint32_t def, data;
+       u16 devctl2;

        def =3D RREG32_SOC15(NBIO, 0, regRCC_EP_DEV0_0_EP_PCIE_TX_LTR_CNTL)=
;
        data =3D 0x35EB;
@@ -328,13 +329,15 @@ static void nbif_v6_3_1_program_ltr(struct amdgpu_dev=
ice *adev)
        if (def !=3D data)
                WREG32_SOC15(NBIO, 0, regRCC_STRAP0_RCC_BIF_STRAP2, data);

-       def =3D data =3D RREG32_SOC15(NBIO, 0, regBIF_CFG_DEV0_EPF0_DEVICE_=
CNTL2);
+       pcie_capability_read_word(adev->pdev, PCI_EXP_DEVCTL2, &devctl2);
+
+       if (adev->pdev->ltr_path =3D=3D (devctl2 & PCI_EXP_DEVCTL2_LTR_EN))
+               return;
+
        if (adev->pdev->ltr_path)
-               data |=3D BIF_CFG_DEV0_EPF0_DEVICE_CNTL2__LTR_EN_MASK;
+               pcie_capability_set_word(adev->pdev, PCI_EXP_DEVCTL2,
+PCI_EXP_DEVCTL2_LTR_EN);
        else
-               data &=3D ~BIF_CFG_DEV0_EPF0_DEVICE_CNTL2__LTR_EN_MASK;
-       if (def !=3D data)
-               WREG32_SOC15(NBIO, 0, regBIF_CFG_DEV0_EPF0_DEVICE_CNTL2, da=
ta);
+               pcie_capability_clear_word(adev->pdev, PCI_EXP_DEVCTL2,
+PCI_EXP_DEVCTL2_LTR_EN);
 }
 #endif

--
2.34.1

