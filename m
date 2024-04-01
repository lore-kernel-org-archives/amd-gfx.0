Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85ABBCD128A
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Apr 2024 08:01:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0396410EF8F;
	Mon,  1 Apr 2024 08:01:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="kIR1EvoM";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2125.outbound.protection.outlook.com [40.107.101.125])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EF3A410EF8F
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Apr 2024 08:01:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UecT/jJNFYl2i/IUq3C7SQv9olrELarAWVe0ptlmCuaFRGO7HrODREmr6XSjxT4FpgVrVdDgzRMWrtL8fNhKwvcWD40S60OxmjazcNkaqYHfhW442tc/Y18tcfzYr6Kz3HOS4SYXG/noJAV+QQhaT4zMvZexiXvPOc/LNiLOGk+HDEoOBlOM4Ka6woTlGrBqickVDynUzmnFK4WkBgmSjctApglasRio3K4/0dDP47VAVrDf91QPyTFEWDrksNByYQMWnD+UuO/dGi3RaNYsOJLmCrWNK8GnGwofiaKG17hI71ZPdn9Bvn1XLnZetZ7DsMbq32lyR9M5p5xc8kU+Yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K0HXsBzSyeENtY+bRRtwmV1f7SU6/ofEDijOudK3k14=;
 b=BPhtLcFlnp+8VH6qvfcnxPV9hS8mKuy9DM4BcxGBJbkVRJgIWkzytJk4nape01FZzHx+1ooAN4DdcP9UzcBgqr9+Jpi0CGV5FI/7mj3X4AGFIS/U31Im1FhdeQf5Ki425GzH9LLeXkSIS7xT7rCNqGzRBdZCUQDg7+6oVkW1X2SEGfrToD7DMQmSmY4qIb2vvFKot358Ac9XdkZYFPKjaDmEVojjhadjhSToDy4mDtLxF4LDxNGNtDbwbAh5E/wyBzharzxHdKR7ScL8zp08zhlnF4vbxovUIkreh02y+x1LU0Ly+nENOrsoVys0h9HqT4OgW6tZ3BwBLpYLoLlR3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K0HXsBzSyeENtY+bRRtwmV1f7SU6/ofEDijOudK3k14=;
 b=kIR1EvoMx0cCfauZr7fsov4G+gQLZkT3wGJOENzMSPnaMDtyEOvoPDwa25b8+2bQYHB3YuvvZSVAxxq2hAR2WLttn4SkwZb05ZhbFhecR1Lhi1sxwvUsyIVPdAizKCCy/AgsOJMytD/qeRLu18peVkAnM5GPjYEgtZvJE/6pp/A=
Received: from PH7PR12MB5997.namprd12.prod.outlook.com (2603:10b6:510:1d9::21)
 by SA1PR12MB5614.namprd12.prod.outlook.com (2603:10b6:806:228::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.45; Mon, 1 Apr
 2024 08:01:10 +0000
Received: from PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::d1a1:5993:ef75:9419]) by PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::d1a1:5993:ef75:9419%6]) with mapi id 15.20.7409.042; Mon, 1 Apr 2024
 08:01:10 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhou1, Tao" <Tao.Zhou1@amd.com>
Subject: RE: [PATCH] drm/amdgpu: update check condition for XGMI ACA UE
Thread-Topic: [PATCH] drm/amdgpu: update check condition for XGMI ACA UE
Thread-Index: AQHahAlOcQu1KmNjsEWm2bwz758RFLFTDVmA
Date: Mon, 1 Apr 2024 08:01:10 +0000
Message-ID: <PH7PR12MB5997869DA7DC113CCCE0E6BC823F2@PH7PR12MB5997.namprd12.prod.outlook.com>
References: <20240401075023.370054-1-tao.zhou1@amd.com>
In-Reply-To: <20240401075023.370054-1-tao.zhou1@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=b58ec071-6efb-4447-abd0-551facf41fcf;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-04-01T08:00:50Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB5997:EE_|SA1PR12MB5614:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RjCHUPYSV2Kc7cLwW6Q+cR4l2xUmRI7oTMCZSqwRz9KHPwb4z1WgsYPGigZe+cOd8O/rpNEqRJdltxNGtzSsTX/p1caUttqcgFXuvN3mG58fIyt9tFA2oFQ6wfTDnbD9VXFodkmqywtS7ZZMm7nfs6RREVHS08y3fkbldtbiEsnWHevr7IAw3iej3Y6TMwM5snAj2U1CJvl2Kxdevm9OykBdn4hE+iqAUNSkKUCx7dk8YppB7MtBh1lieGdR6LbtqSBVOj27AvzSRzAEyK+7btqk5K84+pWuosjACFtxsXEV3ykViZHOtQF3nmGEcJze3MWBSJMuO9U4nfQYFYiDiagUz6+pEJvEXyJHMz5dPWjwG42lB8BxJ5sThcF/V0kSqAs1bwV2WLZGbC/V3HJPaiCq9Dw6xaZSZeVQolzioffswWbRPrFwXnK3tLCXRbx5nrT/4hRjdLSnMee89w4V0hIXtDbkehZRCyS76eNZpOW0u83YlylijWBcBSGZulhwsz1jR86v7KeJn5xungmF1KTaiUOwT2gQ3bI9pyP8Yt4TFFytkjUh57Wc3Qb24gyGGLAr6GEGoO2hRxvguO91sNxMpom+B8NH7Bmz/JIb6nGVLTL9qDGBBQ2CsbiK+/9nH2/WAcxJlWS3ybdiHslqlDETzQITcySnbW7Tg0jhsnE=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5997.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(1800799015); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?qqlT16DwBxBj1HQOxyerVnslLrRVBoWjMyBzYNEl5pv0uDUGVg2MI17/grD9?=
 =?us-ascii?Q?fqxOVSmiFl4CL/U+kS6ZuTO1VhCNLCqicMn5ABjpMLSYLNBLxJQT+LKu9mHD?=
 =?us-ascii?Q?BsN/jYYIRtLlZEsWLqAgpC8D/sM1UZMPlDodJe04faWZh2ThDWGy7+dvpFsB?=
 =?us-ascii?Q?bSAelOfgfEnRWJwWDT2dvib1Daq46XOu3qlq0niGLnlA3xBNfglnH2xsf7ha?=
 =?us-ascii?Q?PxKnD6R7Ev1+8DJgEWjRm+DGAVggUaWsNcdlzGZm/wnjw3jX04K/BhcnXec7?=
 =?us-ascii?Q?O6CC5wyIsQUkvaWLQLf9f/iYFFwBLTbQYtkiBUpY4PsLuncdl2M9bL2yWu4Z?=
 =?us-ascii?Q?tJWF+fwkLgluyRCI9VP4D0S2Uy8SAYrw7XYrO0Lr20U8c4r4lW/p7lTEV+57?=
 =?us-ascii?Q?p7MwYhlbh/SS9IClUmbWIPd7JgOY9NcXkjy1Dxz4BjV0zD0BitI3j1BAVOvG?=
 =?us-ascii?Q?s4q9hfKVqQUUditNO/2klT+qjp8igGxymWGpdVsGU5iXnAu+zVqxJVC8Bv3G?=
 =?us-ascii?Q?an0OwdvTnUt2ARQKevlTqaHTHF7mlSoXo5ZqoU1JeKqZEuKkPXgxBcHlVp2T?=
 =?us-ascii?Q?D2/mAMm6BWI75c/Y1z16iQ4LoA2u9C3lulbuS3g1CybeYwzgLLZwU05SLHVX?=
 =?us-ascii?Q?onX3VXo8c/+3XH4baeCaIHb76izffaBt4OU+QSh63jomS5RC43qMds649VKw?=
 =?us-ascii?Q?MTm9udrHTGBSAo4KhZgON9WZEYtwyOCtC5F7c1zo0sgo+N1sUxdde2oaIPZS?=
 =?us-ascii?Q?Zy7+Or4p6ALdRBrpR9hhaLDVKLTdYfA8lXRxGe7f68teUV72Aqp6kYriaPOs?=
 =?us-ascii?Q?CWcLOwTBIXBZ6LVLQohgRB9+H0tIqWMtV5lMRFyEQ/e9i33QInDZ2idlDSQw?=
 =?us-ascii?Q?FQWD7NFm5u06XgdkEJF9EVqf/L0Q/Fxr/tIg8nG2u6kjZxbIYYJcvdZNvYJW?=
 =?us-ascii?Q?DAIZxMipU6+BMu7wRAmt9Qwmxk6F4VaxKeHPY+lsvJsOvKXkFVw0R59zHQX2?=
 =?us-ascii?Q?XFxocAwo7ZrSt+tA91LMXkkVFvk7cxuhNY8aZrUbdjuZWjyZ+fAvxwLnzl0t?=
 =?us-ascii?Q?l8NYGfKbvlrig+9TjNOK6mAU7XGLGpRnIY7hKswwrPsCH8+j2/4hQjO96Vlk?=
 =?us-ascii?Q?oDV0tVMiSxQi71POK3zCEDVZyOYQXd3zOCbUZksngJvD0ODK7b5zgqyEl56J?=
 =?us-ascii?Q?o8wE//PtjJr6cPTP6+CSr3WIF+U3huTrvGYWLPWT5SVd7lYe8ORQ5QHdkvlD?=
 =?us-ascii?Q?dfJc0uXSyz0ulWq19JvjE8tsCLl3DFwqPnLK36qkG6sM3iFYH61Zb9S7Rx3h?=
 =?us-ascii?Q?6DUsZ1Ze28haW629y9WS2OJplAQ+in28D1MvfDW8fDNKFh2Um6uddtPVdXGC?=
 =?us-ascii?Q?tZg//PSLxJpqHq8meCB+16VQZlETMs6nJ+Ntez0NLpcqUdkeJzlrhNgz0hVd?=
 =?us-ascii?Q?Ib2NKu/obUvaxip9/et/n8lb3cAJ+XfBa7UaxNPvhG+kXI3GL2HKU7L6GP+M?=
 =?us-ascii?Q?rmiP9hw4sxRnXo2VkYvfpMty5EydVZkZHbNsMN83tgUZQOh94MROs1HrvOvh?=
 =?us-ascii?Q?7e3wZFMstlIAbQVM5JI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5997.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc9b39b2-906d-455b-760f-08dc5221e4b7
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2024 08:01:10.4271 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JqJ8pLJPfOxlZKqjemWnBwkB+b/DpemkwLRXpDXyL9mosAOD/xMMSqZljSXDB0aK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5614
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
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Tao Zhou
Sent: Monday, April 1, 2024 3:50 PM
To: amd-gfx@lists.freedesktop.org
Cc: Zhou1, Tao <Tao.Zhou1@amd.com>
Subject: [PATCH] drm/amdgpu: update check condition for XGMI ACA UE

Check more possibile ext error codes.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_xgmi.c
index f4be524b0dc1..be1f4efa9ef6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
@@ -1066,7 +1066,9 @@ static int xgmi_v6_4_0_aca_bank_parser(struct aca_han=
dle *handle, struct aca_ban

        switch (type) {
        case ACA_SMU_TYPE_UE:
-               count =3D ext_error_code =3D=3D 0 ? count : 0ULL;
+               if (ext_error_code !=3D 0 && ext_error_code !=3D 9)
+                       count =3D 0ULL;
+
                ret =3D aca_error_cache_log_bank_error(handle, &info, ACA_E=
RROR_TYPE_UE, count);
                break;
        case ACA_SMU_TYPE_CE:
--
2.34.1

