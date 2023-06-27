Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D16CEB64DC
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Jun 2023 16:18:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1146F10E312;
	Tue, 27 Jun 2023 16:18:48 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2066.outbound.protection.outlook.com [40.107.243.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5A17E10E310
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Jun 2023 16:18:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T/YXuy/aS5XfNS7q4OviSN02otQHrpNv1aT1YK6Ccs2RTA8VHai076k+bBGdn4pXZvLMUhEZ0wsUHB5IMiXA8dFCcMwJsmOCryU0Lf2epSbxTh0o2Zy+WIdYUznzGdMvznuzhBQS7AccuPeFgBour6Vn+akKVZvOShvpGGBNHV1CIu69fFdugTgD+TU6TbxFuCGox5dDo1TPs3ksw4346WXanTEzQBcWEswCyT5xgnMeeiHPDeV62k4pTOFWrxy6HyAsCxaM58WZBKCrhEj3jO9+/I1ZHHpGvcLicygLanFQOMp4u9nwjqOY34mhgJPfL7LoGbTi+mBA1VaHWBlqiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lY38YUPukaK2yBIu1cso68ZZNittALfHiafqflDw0d4=;
 b=CoUVi+MjQEi7msnOBNa1BKfZjQpOQ0tDNxPyNs2zsZpIa1DTiSWy9/UGNBgOuJah2zscZS9G421EXMO5WE2jC6y/W8pYdEndOmDPzR3UXxgb3Dci5pfBM2M98Q1790Q9WT8uPQTLfx1k8ZbIcGGKLNBZrQrkQexBf2n9rgA1zIUeFzp0Pcw6IESuVJYD+6m3841QS+uPBCwG+N8C//9Xy8Z8XdA9MWTLikw8QxwOO+p6kUg8wVLodTWTRHSUbKjWxhPiwJ72vIP6AQXkZckJfUnfH4q/RXnXp3F0Us4TjbSOxyvxaYriZubYcDs2WKFap3m2Fp87hVFLCx60LTNjMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lY38YUPukaK2yBIu1cso68ZZNittALfHiafqflDw0d4=;
 b=KTWG73prNPUDK8HlwZ2jqEoXbLdBHno9vWthaYib0RKMb2wCPV2aa7x4O88Qc7liUrnvkkT+Kib7Pk2IyIhO2CCyV5osJj3XxrcUDxE53zEI/xxkbt7e7VQE2q4fmzfSEXTFOtDm3ndHCbRpvh0J/koQA1zUZJgi3TjcOiHbtx8=
Received: from MW2PR12MB4668.namprd12.prod.outlook.com (2603:10b6:302:e::21)
 by CH2PR12MB4310.namprd12.prod.outlook.com (2603:10b6:610:a9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Tue, 27 Jun
 2023 16:18:43 +0000
Received: from MW2PR12MB4668.namprd12.prod.outlook.com
 ([fe80::3d38:7a76:2925:91f0]) by MW2PR12MB4668.namprd12.prod.outlook.com
 ([fe80::3d38:7a76:2925:91f0%7]) with mapi id 15.20.6521.024; Tue, 27 Jun 2023
 16:18:43 +0000
From: "Gadre, Mangesh" <Mangesh.Gadre@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Keep non-psp path for partition switch
Thread-Topic: [PATCH] drm/amdgpu: Keep non-psp path for partition switch
Thread-Index: AQHZqLb+FJtzkZnE10Ocoexw6Kv5l6+e09Iw
Date: Tue, 27 Jun 2023 16:18:43 +0000
Message-ID: <MW2PR12MB46684583D8E0D588A7203A9FFD27A@MW2PR12MB4668.namprd12.prod.outlook.com>
References: <20230627051922.2644853-1-lijo.lazar@amd.com>
In-Reply-To: <20230627051922.2644853-1-lijo.lazar@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=b7b13e3d-9a95-4e3c-b135-aba659b9fe26;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-06-27T16:15:44Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4668:EE_|CH2PR12MB4310:EE_
x-ms-office365-filtering-correlation-id: f3ba9f2c-7a15-46ee-6221-08db772a2d4f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SIjrW5EuWoF5ovQHnv1hGLSjKivpJaGm5CoD5uqMS2yQay7b2SLEP6VaLqxts+46MXCqGj3Mafnj3dBH1/fdV4R1cbCQdPPnQoloDcVf+Wa/DHnPZNAmqYC4keZWLeluc/th6czLvm4t2X2pWZsuYCp8W0YlO5GKi8M/SyCrkcnuvLP4CKahQZaT3eG2ufaC7G33s3kCfGdfRvVfyBOq00R8dJX4UriIHVr2J66qXIWG68iAhC+OTLC1kvM8W2hv8xoZ3aauSLfqRX+lleGiacmKmmNTwlkYRWWP9Tj6f1DKZlYMsoTrwTX9kyOABkx5B8RsFPGrRkhuKAnnm95DF9mjclJkAMTXmjUWryB7F2h5lumYwNT6BlZpJPUQWK9HtSbB6D47XKsBhMqXKWH+Zt9Ij4jDaySw4O+go5v/66Ipt2YjZqOVyE2DHZe/MWI/yozfJuIqcCd2GaazBG4ZDIUCrLG/lUhNyzg+QU18ZUKqxzn6xzUHzkXp520f2q6kjgaiXilH9s2gv34bNUoftwvd9rH2rhMw3wF+C9lMywHEDuO5gr76WamVdXxCUTnp0qixnQbGc8pGEXNBH57Lc/Qh/uearfcBwnNKX0RN6saJxzCC6F4MULcn61m84ViH
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR12MB4668.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(396003)(366004)(346002)(136003)(39860400002)(451199021)(8676002)(8936002)(66946007)(55016003)(76116006)(66556008)(66446008)(316002)(64756008)(66476007)(4326008)(9686003)(186003)(6506007)(53546011)(110136005)(7696005)(54906003)(41300700001)(71200400001)(2906002)(5660300002)(52536014)(478600001)(38070700005)(38100700002)(122000001)(86362001)(33656002)(83380400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?8nZCt23DR96hzW6uGraTDlFA9AaQCrjbs1mgOHuOjj5AQ/3JBYuocdVh2FW2?=
 =?us-ascii?Q?q+jR0ItN/gCbjPmAdrVDiycvWXYu29l4FB1/bNxqNB6igE6SMb9iSoLDmiFL?=
 =?us-ascii?Q?YaZxRfOUmug6AGAGqt3ERFCz8KhB4lIxkIAB1cK4udNpp7hZjBODrt6bPu9d?=
 =?us-ascii?Q?g3gjBoOjWgdSIPCE3pKsFFYxWoi5yAMQ1YfHR7trF1d3rKGGYK7bkHzzH5vG?=
 =?us-ascii?Q?xX80ynxI6b+e0F3CqwMNquq7OPPIrvH7l+v9d3C4WNmqZ8wMtMPAxqtbpPLr?=
 =?us-ascii?Q?EKfQNnHsNAXaItv60f2XF5QzOkKnRiyTmKzCQ7q4FdZtHFFjSDeD0trvLOD2?=
 =?us-ascii?Q?M2B+XTJ3KenV1nuL6NUsTqtmGHKuxPAl68UbHgzVtULl2wlbK7Lqg+X2ucHA?=
 =?us-ascii?Q?dom/the40AwpyKwXjVKE7rF/EYhur9TOI0onau8Xxdhp7FJwsVPiZ+2S5Nr1?=
 =?us-ascii?Q?z2noHhWtRiSVaItjJvwLHj2GmV+XqBfqMrsCBX8i3+xGE222pDqnJ5MEcFSX?=
 =?us-ascii?Q?gqeW5pdNw82DqfZedb1K3xtwzBRsS75TWW0IwvlnfydacXVuRn0Ni1pS4YMA?=
 =?us-ascii?Q?Zq92R4ZBxffM40/jSq2HdtZqm1n+xVim90csAdOSH5VJQbMJKTNyngf/9pp1?=
 =?us-ascii?Q?cbgvU9NBcj+05+Do2Tl2NHfWXLO5W2k+UFNFGoP9rAiVKy6wd4FNMAq4voAP?=
 =?us-ascii?Q?YGZ0HhNafC++0YPu29dv4kH0mq0cmvQAdMvmJ63+xzC1AsoBq/2cP3ZE3Yw4?=
 =?us-ascii?Q?AJwdq5+s0eccWl1rhHLfuawIIKM+UBfGEqfxxyEIqHGb6hoEOQRTdGOglmVo?=
 =?us-ascii?Q?ez+G89RtjSGPhGgxEK+kDj5elYBHEhn2b/uVsSCQboG5NzDYQsN7wC+2jP1w?=
 =?us-ascii?Q?DCiWTOh9Zfc0u721+7Jzc5H45o6bvyyX+q/qY9DjJc3C4FI+Ih5v0CSJs+3E?=
 =?us-ascii?Q?EPXMQAdnbUSbIB8oBe6X1zo5B8Yqk3GlPZQCt14y3NgxpiqBmhhN52LBW2B0?=
 =?us-ascii?Q?e69wNKKWPFSto7pM9hI4tMZv+eBBaE3sCTy6Io+ajMIpsq8QXMT8TuDixqjF?=
 =?us-ascii?Q?T/n99I2sAyTmPyTGrS7d8yBqQF8trDmAx7HE28Bifo3VVDDb1OM6MApXsjBq?=
 =?us-ascii?Q?IydE7n7FnImB6x3wRbdzUD5ahCsIiWfLsI4zyxQ3IWYUUwCvrVXcK3EUvSKH?=
 =?us-ascii?Q?GhRmvOT6BbBjJQFVOBe7qRpHqTKppNmoSTDPFDRDYtu4YWn4Ir+Ieqm3lNkb?=
 =?us-ascii?Q?b5q7Ntnq14SUIMy+arhpgp7Ah2sH3JOBLcqnCrJ0PWBdkVP379qLkgNDlIKS?=
 =?us-ascii?Q?A9qifVVpVs+/ARBh0pxNvOpeDr8GFhfEr2DycVpe347GbTZquFusqqAGRY07?=
 =?us-ascii?Q?0uw8rrk3Lr6s33fjV/kM/x2aj/I516/SjSDXwCIA7J6A4VArGPY9I/RRyOod?=
 =?us-ascii?Q?UYKOhQN60uTniIGdHrLTJLWYxDpT0Hs7OPq/f5QSeqLBnhmf4JtgZhYQ3xxe?=
 =?us-ascii?Q?r/YiKOVfDOls0zMytekMjea/q0JWuJeVLoO3F1Y3PNwRhAKihOBb2VFhfrdX?=
 =?us-ascii?Q?DYMqxvx1N3KdF3i5gjWrhe3kc09HqWv6ElP55mtvGWWyKftz/mtP6CeZ9Uav?=
 =?us-ascii?Q?34D0+seaKrPNFZoKqaWccps=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4668.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3ba9f2c-7a15-46ee-6221-08db772a2d4f
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jun 2023 16:18:43.5124 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 19WJub71LMymKWKe87YTaWNV7U3DdhAtt/GhIsJLu3Zp3NX/IITBJj3OARbr1laPt34fg/7oLKcY2YTBdhstBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4310
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

[AMD Official Use Only - General]

Reviewed-by: Mangesh Gadre <Mangesh.Gadre@amd.com>

Regards,
Mangesh

-----Original Message-----
From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Tuesday, June 27, 2023 10:49 AM
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>; Gadre, Mangesh <Mangesh.Gadre@amd.com>
Subject: [PATCH] drm/amdgpu: Keep non-psp path for partition switch

When PSP block is not present, use direct programming.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Acked-by: Mangesh Gadre <Mangesh.Gadre@amd.com>
Tested-by: Mangesh Gadre <Mangesh.Gadre@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 28 +++++++++++++++++++------
 1 file changed, 22 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/=
amdgpu/gfx_v9_4_3.c
index 76b189bd244a..9e3b835bdbb2 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -623,12 +623,28 @@ static void gfx_v9_4_3_select_me_pipe_q(struct amdgpu=
_device *adev,  static int gfx_v9_4_3_switch_compute_partition(struct amdgp=
u_device *adev,
                                                int num_xccs_per_xcp)
 {
-       int ret;
-
-       ret =3D psp_spatial_partition(&adev->psp, NUM_XCC(adev->gfx.xcc_mas=
k) /
-                                                       num_xccs_per_xcp);
-       if (ret)
-               return ret;
+       int ret, i, num_xcc;
+       u32 tmp =3D 0;
+
+       if (adev->psp.funcs) {
+               ret =3D psp_spatial_partition(&adev->psp,
+                                           NUM_XCC(adev->gfx.xcc_mask) /
+                                                   num_xccs_per_xcp);
+               if (ret)
+                       return ret;
+       } else {
+               num_xcc =3D NUM_XCC(adev->gfx.xcc_mask);
+
+               for (i =3D 0; i < num_xcc; i++) {
+                       tmp =3D REG_SET_FIELD(tmp, CP_HYP_XCP_CTL, NUM_XCC_=
IN_XCP,
+                                           num_xccs_per_xcp);
+                       tmp =3D REG_SET_FIELD(tmp, CP_HYP_XCP_CTL, VIRTUAL_=
XCC_ID,
+                                           i % num_xccs_per_xcp);
+                       WREG32_SOC15(GC, GET_INST(GC, i), regCP_HYP_XCP_CTL=
,
+                                    tmp);
+               }
+               ret =3D 0;
+       }

        adev->gfx.num_xcc_per_xcp =3D num_xccs_per_xcp;

--
2.25.1

