Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F652C77B6C
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Apr 2023 02:47:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D32F10EA0C;
	Thu, 13 Apr 2023 02:47:52 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2089.outbound.protection.outlook.com [40.107.93.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4C07310EA0C
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Apr 2023 02:47:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mwhTEZRj4GBtAQmox6Ohno0N+PdT7fZatXu5GsX1dbQrEtfKXXuHSwP827ptcurbGCZoJbUXYjhIgr613TbTk5NqdpiUttzcQ1RMrdGbQ+pX55wK+dl5xtpWXJWRHeYo7CqcMPoMwF4bd+fkJCeugK8Lr7pdIsKRgKquvRilDyOc7soNg82enHbFoEifgbwh1LyRxOG1H6on/KSkNkTiWEwNpYZnFuXh/BQ5pgO8YK9x0Lk1D6EnA1z9vScpAGBoL30ywa04EqI+vPq08ZsaDW/Y+rgg1D1KvPwRZvSDNt21Nwhh+7VgiDc+mYRGyZ6Lw51Og1PpG9zlxcXOnz8E4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cfTyecgvz78Q4orf3Xa5TuzJps8c17C3xrpJZ8IJoYo=;
 b=aMAnCS3JMmNDf5RzZ4jeGitfvT/IrVPyZhahDMlcvkFmsRklrAEHRyRcm/9i4e6Bs15t0aPwhxiK8UDGD3NUqxuAERUt49hx1jmYJdpx5PnZyxpa+KBclwSCX6MLGDRdzAFSaZweZqmvnBFMv7rvD+dmMRmdHbeJxwU8Ag89jbCQEwmOsFiv0wTpBNJjby2pPKGWj1bv7gZPAbz/4g2pqGEXLJ3YHPQB7SBzVtCphpJ/AmYAU+kMrWiyjdfsqdkyTMfRLO/cqMgbHB9EwCVnnACg3rxx6fudHNA4P+uKVDcgWMq4yfgxo2WEnYvUVFPWoTsAlpewCJ2hhPehRgsGpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cfTyecgvz78Q4orf3Xa5TuzJps8c17C3xrpJZ8IJoYo=;
 b=MMlZLuPEENZCP9nnWwbi4mkt54niHyzhU6oESVP0ecYkrhWZpyznSoNy0SdI6zvfQA+dHQyC/qC3H1VTcm2bd5y7vHfsPa6EAJqQlqh/p9X0wT4Cz2swreWczTtIyRarPppqvw9Wk2HkhZABiwPC6k8/9mX4FehRasKJ3k9r0F0=
Received: from CY5PR12MB6369.namprd12.prod.outlook.com (2603:10b6:930:21::10)
 by PH7PR12MB7354.namprd12.prod.outlook.com (2603:10b6:510:20d::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.38; Thu, 13 Apr
 2023 02:47:48 +0000
Received: from CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::1647:e9a8:e6b7:7a0a]) by CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::1647:e9a8:e6b7:7a0a%6]) with mapi id 15.20.6277.031; Thu, 13 Apr 2023
 02:47:47 +0000
From: "Zhang, Yifan" <Yifan1.Zhang@amd.com>
To: "Ma, Li" <Li.Ma@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: reserve the old gc_11_0_*_mes.bin
Thread-Topic: [PATCH] drm/amdgpu: reserve the old gc_11_0_*_mes.bin
Thread-Index: AQHZbbCTuU0Cm+XLZkSaMWJ9mGrKHa8oh+Sw
Date: Thu, 13 Apr 2023 02:47:47 +0000
Message-ID: <CY5PR12MB63694878D49DA957DFC2D2C2C1989@CY5PR12MB6369.namprd12.prod.outlook.com>
References: <20230413023406.3111352-1-li.ma@amd.com>
In-Reply-To: <20230413023406.3111352-1-li.ma@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-04-13T02:47:43Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=5b3babf9-5409-459b-83af-a3d8477680ac;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2023-04-13T02:47:43Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: 1028f751-ded5-4ebd-bc0e-e92d7e2937f1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR12MB6369:EE_|PH7PR12MB7354:EE_
x-ms-office365-filtering-correlation-id: 76f56322-3ee1-478f-6ff4-08db3bc976fd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zBQb9tryV6KLPoBQsAZFfPLC2c7PPJM8cIykWkdH/OyAa5S6Bvzae8AvhS4ZygzE/Tu4yAGrxBWpJHeWJupixhvqA56uMoAwJHcDvfiQOxIKlMSE3VKfgO1j/akT/VHlQncBbCRe0a1ShcHJ06Y3Pl3xFK88Q5pbtjdIhe+2dVk9ywg/6dxdOaSAjNT3IIraFdeipYiqqOXJnxFSeDvnYKw5t9WVfMvwV416bKKLjuA5KaUVjtaWj3HUMt4kxP73zuU+PdExwrb4yE8t+9ymY7Neqp8EjU7X9XKuW44Y6CNd3Sgkg2WRseD2ORk+QP2ksZJfJt5gVntk8x3NgMcT/1Scfjv4JU++QUvJVJyLMbij0IjUOIiiZsAvTWe+6RbinZfBOy1uvoJIpXxgBfhY8Fbdx0gjXDwzPij01UwaY9PbtzptK7NgiGSyrFc4huH71xn6IPZbhW+dhZ4bhN6SfBKI0vHY+98yzcfSdxApFsEx1f6g+ZLSASByw6e3hUsbdQTB7zrXC0zgcWW3ypGoDU6OFUkuu4RR4/Z5VMm/+A9EcPlzYD0uppJk4G1Uw+5v7952ANyelFokoixuIJwWh73PTbIJAfvGGqG5dcDqjOd7wYrEoyoX7cSzWEC6x9iv
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY5PR12MB6369.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(396003)(39860400002)(366004)(376002)(346002)(451199021)(38070700005)(2906002)(86362001)(33656002)(55016003)(9686003)(7696005)(71200400001)(53546011)(83380400001)(186003)(26005)(6506007)(76116006)(478600001)(66446008)(64756008)(66556008)(66946007)(66476007)(38100700002)(4326008)(8676002)(8936002)(316002)(41300700001)(54906003)(110136005)(5660300002)(122000001)(52536014);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?2r06IMTaE3cJyMBnUROZiQ68qmfsV/qjNQmPj4oBVe1/P/xul11gTKcbISwZ?=
 =?us-ascii?Q?DU5Fwk05d3rABWdjOG64jPy262j1iM6PzPS42Wi7pMF8kdCQktzvrhPtD7io?=
 =?us-ascii?Q?HEEXhCpaQ0kUA+pfoizLpLGVm8mqyMRnpWUJqiDpD+ZA/iSGqOp3NT+ZqGYE?=
 =?us-ascii?Q?rNjOuuxyF6jGGC64NfpP3qhKVyaS8K+RifI+MMmicKSTZGwUepK3U56mB+Du?=
 =?us-ascii?Q?dhJ3rprxl8Oz/mLdYvD4tA5grCR9hoMBYqTH+vRwA90so2WjRMKmQHpPWOUC?=
 =?us-ascii?Q?s+nCCyeXrpBOiLfqfUg+1D8x45yd8JRYB3xcb/7Lhq35jio3Im0xl6N6wGEA?=
 =?us-ascii?Q?Or19f+2EguhfWZv+cSO23sSCL2ESVj127Tf9dxPuMCi9kEy57vZS/If+FHOW?=
 =?us-ascii?Q?PtKsFPZuYPaqr2fe2MQAOQh3i0iI90nSy9jGXtNu8o5i8HuUQtIgj9on1x9j?=
 =?us-ascii?Q?2Oa/UhwH0t1czZzyxFz8PxH744aosQJzb0XeW8iXEoGqpgSKWPZ7Ax3w9lpx?=
 =?us-ascii?Q?RgQFbMkaNAH7DH/Gvmvp9wSNHt5pUTrByq4skHtqtzGxhxSimp2bECLOs9pM?=
 =?us-ascii?Q?28kVjdlyxA3kIEt5k/CpOxgsmV14JqZkp/hO9+XsP8aV+Xo4xOXQ+1ofa5XU?=
 =?us-ascii?Q?FT1BC72o6GOjJGWDphzHgXEHAWX48H8FEGO/aAdXEN6H4Xf3/z9mgteMeHRU?=
 =?us-ascii?Q?G4hFBfuc3e1pMyzaxfHI4jP6wZs+o8AW4nv1WMSvQs/uKdJuqWZTYvjvX0Sy?=
 =?us-ascii?Q?ucvuckbOjkxBqv9db3LtDeq75mVGQvxZvebgXlm/J5xBOcs4hLRFpJY0WWpb?=
 =?us-ascii?Q?6anUhutunyPrKRmUofFJeIF5zxtf2ZxrzhsEREK2fIG7tz/AmXok1yR5qWBy?=
 =?us-ascii?Q?4mHa/kY/XG6zx0nVSkXps1SYddsOFwEbW5xoypfRdmOLtRVzzpv0jbQ6PU4M?=
 =?us-ascii?Q?2mD86mVbni9ZMgomdwOaL7sf23cAZcXnUpilgOGJUFw+xM+xLLnXBoWUOQ0p?=
 =?us-ascii?Q?XB2wgc3lH3yxcSlX43wJ1L0l1C4opDAKD5qUlPmuu5BuKZIHsvom96CYI/6V?=
 =?us-ascii?Q?HpRKKENzNXq6j/fRunJK0vEEFGedIk3rcBW7Ih6xD++5Cx1+/XHnLnSsRBsV?=
 =?us-ascii?Q?eu4DMk2hnltfugmjcCPJpgcURddEfwkwfAT3/Q5ImlH/Y9YS4V5gDiQJa7qW?=
 =?us-ascii?Q?FvSuqaDZUsbUEMkq7JKQxiBjSYe5HM8jl8A/9XAfgPdvnHo1dK7rXoAYDd/c?=
 =?us-ascii?Q?PlDOVt3pD5uMa3Te1qDEvrlskboe4N3UCwQDtb0txO8UnraobpJXye/Fs+hR?=
 =?us-ascii?Q?EYcZtqLIRdnbhbiK8TeGrZ+lXdK/93NiynGkUbhHAx5To0tQ6RjAGDLdgfi0?=
 =?us-ascii?Q?5eHSxDMArb1K3V4twQUffurvHevNpH0sEIr3G2j+4dTuo30tanoI+GcBF8As?=
 =?us-ascii?Q?chRebvkU74miT5mflAiQ0Qx8l1JJEoekZHwnCJWYkpi8vS4/jz+X/BRMY30s?=
 =?us-ascii?Q?L2EEGTIKdmWPmxH4nAiLFX0YderHRKgVO7VmmW6ee/9R0DGjH07TkYntbxwY?=
 =?us-ascii?Q?cayCbeqDeAl3xwwJP24=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6369.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76f56322-3ee1-478f-6ff4-08db3bc976fd
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Apr 2023 02:47:47.3531 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EsWL61SKtKX1wDBHUHaTzMmFqG9F67DHIFGIjqjeVEpLFo6gIxjKAu7dzyGFFqbk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7354
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Huang,
 Tim" <Tim.Huang@amd.com>, "Du, Xiaojian" <Xiaojian.Du@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Fixes tag should be in a separate line, right above Signed off, with that f=
ixed, patch is=20

Reviewed-by: Yifan Zhang <yifan1.zhang@amd.com>

-----Original Message-----
From: Ma, Li <Li.Ma@amd.com>=20
Sent: Thursday, April 13, 2023 10:34 AM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Yifan <Yifan1.Zh=
ang@amd.com>; Huang, Tim <Tim.Huang@amd.com>; Du, Xiaojian <Xiaojian.Du@amd=
.com>; Ma, Li <Li.Ma@amd.com>
Subject: [PATCH] drm/amdgpu: reserve the old gc_11_0_*_mes.bin

Fixes: 0f486b64b8d4 ("drm/amd/amdgpu: introduce gc_*_mes_2.bin v2") Reserve=
 the MOUDLE_FIRMWARE declaration of gc_11_0_*_mes.bin to avoid falling back=
 to old mes bin failure via autoload.

Signed-off-by: Li Ma <li.ma@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/a=
mdgpu/mes_v11_0.c
index 7e8c15cd8dc2..45280f047180 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -32,14 +32,19 @@
 #include "v11_structs.h"
 #include "mes_v11_api_def.h"
=20
+MODULE_FIRMWARE("amdgpu/gc_11_0_0_mes.bin");
 MODULE_FIRMWARE("amdgpu/gc_11_0_0_mes_2.bin");
 MODULE_FIRMWARE("amdgpu/gc_11_0_0_mes1.bin");
+MODULE_FIRMWARE("amdgpu/gc_11_0_1_mes.bin");
 MODULE_FIRMWARE("amdgpu/gc_11_0_1_mes_2.bin");
 MODULE_FIRMWARE("amdgpu/gc_11_0_1_mes1.bin");
+MODULE_FIRMWARE("amdgpu/gc_11_0_2_mes.bin");
 MODULE_FIRMWARE("amdgpu/gc_11_0_2_mes_2.bin");
 MODULE_FIRMWARE("amdgpu/gc_11_0_2_mes1.bin");
+MODULE_FIRMWARE("amdgpu/gc_11_0_3_mes.bin");
 MODULE_FIRMWARE("amdgpu/gc_11_0_3_mes_2.bin");
 MODULE_FIRMWARE("amdgpu/gc_11_0_3_mes1.bin");
+MODULE_FIRMWARE("amdgpu/gc_11_0_4_mes.bin");
 MODULE_FIRMWARE("amdgpu/gc_11_0_4_mes_2.bin");
 MODULE_FIRMWARE("amdgpu/gc_11_0_4_mes1.bin");
=20
--
2.25.1
