Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E5AAC25B78
	for <amd-gfx@archiver.kernel.org>; Tue, 14 May 2024 02:15:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A15EE10E0A4;
	Tue, 14 May 2024 02:15:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="EwVZbs3+";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2042.outbound.protection.outlook.com [40.107.220.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DAB7610E0AC
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 May 2024 02:15:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kEWmhEzKVNn7aa1PLJ8QcCEyZAqH3fi1MOSwVcBJWx1ev4NWhQpJaOLS1qo6GVMrzVwhxfOimGP6K5njoDRwc5E9z+ieonBF5L0q/xv4i9WaTszvT/izNiGW9rq844aRfA0Fsu7o5VSQ7eAakuTpDdN40p1FgF6CPpDbhqaIDH72nLoibril8efTcUYaFzaw6/jwZF5onE0/fGI/WUtDZTqJRWOUqwKAUzEEO99x+mqdUj0LT6cnoj3p6JfOKUF2O0TRDQbg7uQqNnxeld7alx2PBr+8pGtitzinyebbrjtsZo3xO7v+HZlZ4FI5SwWT2naLLds6L0apzqd4J0A/Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zpEqWlyFqUtNuWgWa5pWiK+bGf9pVo27QfFS/Kwt4S8=;
 b=C1DYpr0cezPndQreFHeju9khLAQsrrQfJO4HJZNVOwfMbaTpygSKIVKeCAHSPJG0qdp4djkrIS3x11BjQmIYlocYBSjM1DIgmDoeOE2KL5U0T+qTAwLlTUGFiRH/00jHvLfubvunS0FYL5Fre+OCtDJOqn60QWVWfK+iHLQsVuwRcHlLjuoqH6KPvaW56ryIv+8bNaU5cHRVDHC2y275jC4C25FpgboR4Q7M78/+cChBaQiQG4nmiFqZnh3bXzRb8m595ZCCIwcIWsAl+NZg6rznV7OWW3bhAYCVN9UoFTHTssNuk7fMAeMFvuZ+Hw8CxULxu26SpMZIaFUw6D/Ykg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zpEqWlyFqUtNuWgWa5pWiK+bGf9pVo27QfFS/Kwt4S8=;
 b=EwVZbs3+LIVddkJZ7vtEYmcX+6nuPEdIPDXG6B65NNulkRKRE2MiVfmmb2WteWwySxWFmyHJ7sWXTat/SXUI3gieA2Gc6luUa63MDxgCuvrkZgAVhsuO2nJXXJVl9FoEUMHho7QnHNKeJfH+nLsqy72lnTRfHAeoTIfAKezp9vA=
Received: from PH7PR12MB5997.namprd12.prod.outlook.com (2603:10b6:510:1d9::21)
 by DM4PR12MB6134.namprd12.prod.outlook.com (2603:10b6:8:ad::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Tue, 14 May
 2024 02:15:40 +0000
Received: from PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::d1a1:5993:ef75:9419]) by PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::d1a1:5993:ef75:9419%6]) with mapi id 15.20.7544.052; Tue, 14 May 2024
 02:15:40 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: "Ma, Jun" <Jun.Ma2@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Feng, Kenneth" <Kenneth.Feng@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Koenig, Christian" <Christian.Koenig@amd.com>
Subject: RE: [PATCH 1/5] drm/amdgpu/pm: Fix the null pointer dereference for
 smu7
Thread-Topic: [PATCH 1/5] drm/amdgpu/pm: Fix the null pointer dereference for
 smu7
Thread-Index: AQHapRN6wsa0drG3tUWFOOPrtTtQLrGV/vsg
Date: Tue, 14 May 2024 02:15:39 +0000
Message-ID: <PH7PR12MB599734B78CA864DE96A35DCE82E32@PH7PR12MB5997.namprd12.prod.outlook.com>
References: <20240513085616.584249-1-Jun.Ma2@amd.com>
In-Reply-To: <20240513085616.584249-1-Jun.Ma2@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=5cb1f91a-82a5-4161-9e47-2d2ddcc71724;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-05-14T02:15:19Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB5997:EE_|DM4PR12MB6134:EE_
x-ms-office365-filtering-correlation-id: e9113660-17c5-44f2-8820-08dc73bbc033
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|376005|366007|1800799015|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?2W6VkYwczYHMD7jFy20r8UEOoyMTxvBGQttaTzsHukMdv+H6Fi/PfI3jfdx2?=
 =?us-ascii?Q?Dd2cRJ6LdfcXmkYo442sOG2yRs4vGnSwGV/nSp3NgTcrNYhVEwTSNHjQQ5zt?=
 =?us-ascii?Q?bbAPhGgv9vDKpMbSDmI4SqfKAbojZNfvq9zRJuHoQEXcpA8t4hOT5wHD2sLT?=
 =?us-ascii?Q?TS6oJcsdrz8Kez91TA6k2e0EPMbYVoaNehjZ3N6FGFHGxRBylu/jRuGG37vM?=
 =?us-ascii?Q?+k4BrG7ZNbiJf6fsNg5L95sTP1lfGx+bv4E3Xc6hapqUXpjFcPhMV6IEBiMT?=
 =?us-ascii?Q?vOAQtQbHTE6bO+NP9lVXe7SbFMlcjjYLNRtlG7AMKGXXmt+67nkF83d//AkP?=
 =?us-ascii?Q?9oSau4QaYh7wPl9/3PVqu5kFMYzEmoPwbjKL6hnaAAWoBDskylmk6jAY2fks?=
 =?us-ascii?Q?E2+/ukZ68OpgzA881J9Ql6PJuDr2CFkPE1X4yB5RYXVjG9f2B1iNgN3fBqPa?=
 =?us-ascii?Q?N0rLfca4RTwlNEbUkgx29/eAHuQUrD49cCOtel/hO6BjBhoQN7qlGkrN+73F?=
 =?us-ascii?Q?u/7AK7wHlIXSrN8TX3x/tiPh9segcZiVgBiRQlBCNsIK0mKmQPpX9qqJoiXg?=
 =?us-ascii?Q?muOXhDTALPUQGGvQ1nb5x4v/GZ2UIVv2CAC2On3izX/GULusnc+1lorxpzJ+?=
 =?us-ascii?Q?Mgc11hCQMgv4RuxRPDnzWsyCuGVwjBUNJeazsDGSYPbV3O93WJEQ3fxVZFEW?=
 =?us-ascii?Q?j2tlQC7GmcZIZafItsj/4c8ur9rxF/MeGLnu4UaACw+NSdGuuYWG0NO1Bx6J?=
 =?us-ascii?Q?Te9MldF4FAYDsM/8nX6wkrIilsCKq6TOJfmPYYT3RUCslTIA2JyUKgShKtt5?=
 =?us-ascii?Q?dMpo0lgEvUG7bp0b0vEVVhoDzLHpV+5UQihfQ2GxlUv4KOR9h+a3EhnGmST/?=
 =?us-ascii?Q?HxmbfJxPQYWYnLbYtqRiAQP0MT5K4wZZ4S2A/ekejqGiCfpyF2QTllAo3/Tk?=
 =?us-ascii?Q?W97hVP09dRJLSWPFXDS7rYFnJhTX6F2RD09ptZim7ZQthf3Z8uAl5jNQoQtC?=
 =?us-ascii?Q?md1C/a3DmP0FxYqLM5/iwz/R0FGT5MDwPyq6RifrIScID2ytyViSRFBo7tyk?=
 =?us-ascii?Q?NutHl+Z92++IHbRrr+M1FGRWbBNl6e9OI8hUpE1LPzBTB2ETisJxMYFvsht5?=
 =?us-ascii?Q?Jp9YAPJZWI6x8GQk8hfgonraUQUIcn4DKGmiL+GFasfjjdQFxVwlCrlDReBj?=
 =?us-ascii?Q?+QmcxpRojQhtYlNw0amUx8c2X3lcgRgdP0M/MVi2Z1I93tk1YHuD1SZOx9t9?=
 =?us-ascii?Q?G8IpRlKJEOpN0LDjKTx+CnIf9YXknY/9ina1YXYjriQaRufX3kxwEticVI8E?=
 =?us-ascii?Q?K/0dC7u/FiT7QFQcF6zSeryXrtvTle/3twltxuB+ouX2NQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5997.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(366007)(1800799015)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?YQx7lpxX9upmOwN7aNIqi7ekfVn2MRhboslcdmZWjrjDtk1o/UaOoVunYwPX?=
 =?us-ascii?Q?tjIaRlfDccBKQhg+wGtN9lPZWwEw0VQUhNxR6o31Ax0z73u2/c/c3ixDWA0k?=
 =?us-ascii?Q?9QDB0BzTO7IWFYh6t1uVkvF4aHI9tLbW4ZdoG++i1nLeZKrpujXVPkWJrmST?=
 =?us-ascii?Q?+7hcVp0myB5rOEUPR8K4vnOb+rpKHk1EjkMzg/1KliPQV7pPEi7ppVhaaVKy?=
 =?us-ascii?Q?DOfvlVZYtgi9bfGmTNAwctmewNGjyoElAUixEQugoya0p2hFWfQcun2YSMzb?=
 =?us-ascii?Q?AFtVw79/a13oy/HDbdA5QQ0whv0EXXnCI2RQTySPgN1xn8n5EQEkBIx86z9a?=
 =?us-ascii?Q?NR41u3ni6SpduPbO8KvbWiqbGYzSox2SZjJuli9FskwEzfXZHwDSIUxo8J4l?=
 =?us-ascii?Q?y0hCFL7fnSAMnlyPhjmP+/r/TpDnbWrNuBP2oQhjgUG/fD6Ov2phpWZxFLo9?=
 =?us-ascii?Q?1KDRtaTC5mnOUohF1FmYz/Vy0Tqgbh1p8l7MEWbLqQsJ+eiGjoitDt2JGVG0?=
 =?us-ascii?Q?O+xWiiDmjqAQnLHa1/717AkL0aWW0ltQAnYrinBWtEWtGiA6mFSCBVQxVf5s?=
 =?us-ascii?Q?HBKy224ERsK3WTjhBS7VRy1y/GKHLBbv8mO43gxUxzol4tyWrEi2u+mOq0U7?=
 =?us-ascii?Q?xUgl0v2iT359mGS2ES+2BQT1eowJiP5o50zTWfLaF5pw4zxEpK/ppF7MdaVT?=
 =?us-ascii?Q?FiF8smHjZxzTh/kyh1k7nBCstEdjrHM8AIs9jxPd9swT2DT6Gxlrw0jmDqwb?=
 =?us-ascii?Q?iFgxR+Sj6dZERw8XlIUB+bSAoDoWF49TN0dOQrHkBDj4nJPsUdyQS8W4EIaj?=
 =?us-ascii?Q?BOKv9A77jai/OezdIjTMw2BlJNwL2002fH+031H1R5Rd546Dt1eQu4IURdsv?=
 =?us-ascii?Q?6EXJacHB6h/zOKttTlJdZKyRmFA826kFbehTvfruNCYm1nFtkLYUQ4airHYh?=
 =?us-ascii?Q?D0gFJ9ocMfiuZ8Y1jP+ReJeseJeL4byHl03ayrQTCc8RTyGk6Fo8X8ItM83t?=
 =?us-ascii?Q?g65hHvpES23SWB2X1E7Kp8sQHHuRSNPb/wZLTzGYJT7+evU31+qe/K84gnJ3?=
 =?us-ascii?Q?oPWOc/pzkJoxy4NrkNTtzVvyUh/w+a7dkA45IGK4RfXUi1ud44VNrEcJnGBg?=
 =?us-ascii?Q?Lv9j18QImt32EF2AXwlpoHf8Bp1sWWMH30WRn/34irLLLCnVS2JRombhZk6M?=
 =?us-ascii?Q?swKmTOlAtJD7I3c8e0x6skD78kZUxW7z3+s1o6a0+FxkOxn8YsD61i2l6/vQ?=
 =?us-ascii?Q?D8ky2l0pbW78+aSNJWkX9ULUFCz8lGAmKZVNF1ZFk99mGg+XY63tirKFh3Ac?=
 =?us-ascii?Q?gbtnF0VTpU0AxPBCesuQ6M9lLZjREF0I5upSPbzjXFjOqwenO3XKGQBhevQo?=
 =?us-ascii?Q?fcCwIWfjtiqn/SOKy+MurUwifcJ858d3KWxEXxh+hwG88hZ3Jznldbq5+yls?=
 =?us-ascii?Q?EXYxPT/6ETOAEMIuZg8G4+0URGqpyHlu/HFLMGC/tDd4hrqdjxXrAuOioo0m?=
 =?us-ascii?Q?vQHOyX1lcC1WZM/DapzhAHI/S9o22HjZqgr+zi/iEBbCurp+14CGhyPkf//P?=
 =?us-ascii?Q?x72LnjTFMLcRY8++8AA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5997.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9113660-17c5-44f2-8820-08dc73bbc033
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 May 2024 02:15:40.0012 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7+rMl79ypZWaVl7PzT/LazY7IllhjvjKAHVz3Ftw68TBPNbvwpR2aDu7L2pARMsK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6134
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

Reviewed-by: Yang Wang <kevinyang.wang@amd.com>

Best Regards,
Kevin

-----Original Message-----
From: Ma, Jun <Jun.Ma2@amd.com>
Sent: Monday, May 13, 2024 4:56 PM
To: amd-gfx@lists.freedesktop.org
Cc: Feng, Kenneth <Kenneth.Feng@amd.com>; Deucher, Alexander <Alexander.Deu=
cher@amd.com>; Wang, Yang(Kevin) <KevinYang.Wang@amd.com>; Koenig, Christia=
n <Christian.Koenig@amd.com>; Ma, Jun <Jun.Ma2@amd.com>
Subject: [PATCH 1/5] drm/amdgpu/pm: Fix the null pointer dereference for sm=
u7

optimize the code to avoid pass a null pointer (hwmgr->backend) to function=
 smu7_update_edc_leakage_table.

Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
---
 .../drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c   | 50 +++++++++----------
 1 file changed, 24 insertions(+), 26 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c b/drivers/=
gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
index 123af237878f..632a25957477 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
@@ -2957,6 +2957,7 @@ static int smu7_update_edc_leakage_table(struct pp_hw=
mgr *hwmgr)

 static int smu7_hwmgr_backend_init(struct pp_hwmgr *hwmgr)  {
+       struct amdgpu_device *adev =3D hwmgr->adev;
        struct smu7_hwmgr *data;
        int result =3D 0;

@@ -2993,40 +2994,37 @@ static int smu7_hwmgr_backend_init(struct pp_hwmgr =
*hwmgr)
        /* Initalize Dynamic State Adjustment Rule Settings */
        result =3D phm_initializa_dynamic_state_adjustment_rule_settings(hw=
mgr);

-       if (0 =3D=3D result) {
-               struct amdgpu_device *adev =3D hwmgr->adev;
+       if (result)
+               goto fail;

-               data->is_tlu_enabled =3D false;
+       data->is_tlu_enabled =3D false;

-               hwmgr->platform_descriptor.hardwareActivityPerformanceLevel=
s =3D
+       hwmgr->platform_descriptor.hardwareActivityPerformanceLevels =3D
                                                        SMU7_MAX_HARDWARE_P=
OWERLEVELS;
-               hwmgr->platform_descriptor.hardwarePerformanceLevels =3D 2;
-               hwmgr->platform_descriptor.minimumClocksReductionPercentage=
 =3D 50;
+       hwmgr->platform_descriptor.hardwarePerformanceLevels =3D 2;
+       hwmgr->platform_descriptor.minimumClocksReductionPercentage =3D 50;

-               data->pcie_gen_cap =3D adev->pm.pcie_gen_mask;
-               if (data->pcie_gen_cap & CAIL_PCIE_LINK_SPEED_SUPPORT_GEN3)
-                       data->pcie_spc_cap =3D 20;
-               else
-                       data->pcie_spc_cap =3D 16;
-               data->pcie_lane_cap =3D adev->pm.pcie_mlw_mask;
-
-               hwmgr->platform_descriptor.vbiosInterruptId =3D 0x20000400;=
 /* IRQ_SOURCE1_SW_INT */
-/* The true clock step depends on the frequency, typically 4.5 or 9 MHz. H=
ere we use 5. */
-               hwmgr->platform_descriptor.clockStep.engineClock =3D 500;
-               hwmgr->platform_descriptor.clockStep.memoryClock =3D 500;
-               smu7_thermal_parameter_init(hwmgr);
-       } else {
-               /* Ignore return value in here, we are cleaning up a mess. =
*/
-               smu7_hwmgr_backend_fini(hwmgr);
-       }
+       data->pcie_gen_cap =3D adev->pm.pcie_gen_mask;
+       if (data->pcie_gen_cap & CAIL_PCIE_LINK_SPEED_SUPPORT_GEN3)
+               data->pcie_spc_cap =3D 20;
+       else
+               data->pcie_spc_cap =3D 16;
+       data->pcie_lane_cap =3D adev->pm.pcie_mlw_mask;
+
+       hwmgr->platform_descriptor.vbiosInterruptId =3D 0x20000400; /* IRQ_=
SOURCE1_SW_INT */
+       /* The true clock step depends on the frequency, typically 4.5 or 9=
 MHz. Here we use 5. */
+       hwmgr->platform_descriptor.clockStep.engineClock =3D 500;
+       hwmgr->platform_descriptor.clockStep.memoryClock =3D 500;
+       smu7_thermal_parameter_init(hwmgr);

        result =3D smu7_update_edc_leakage_table(hwmgr);
-       if (result) {
-               smu7_hwmgr_backend_fini(hwmgr);
-               return result;
-       }
+       if (result)
+               goto fail;

        return 0;
+fail:
+       smu7_hwmgr_backend_fini(hwmgr);
+       return result;
 }

 static int smu7_force_dpm_highest(struct pp_hwmgr *hwmgr)
--
2.34.1

