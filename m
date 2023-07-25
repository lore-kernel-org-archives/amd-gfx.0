Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64E44C001DF
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Jul 2023 10:30:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D2BD310E072;
	Tue, 25 Jul 2023 10:30:54 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2043.outbound.protection.outlook.com [40.107.223.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C58C410E072
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Jul 2023 10:30:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d3awqvLZhWG567nX1lANd4ydysCDG6MaeWGhW2zsrU0DCfy9SAYQl4Dh8XOOg0ZyEZ2vhjXoctJUZwFCkY00rT9KDR8TpLt0DPBuKm/DxDuPGQzl+a4no24+/FazTUjaYmB3DOJxSrSb3moCAIXk/9rSS8pZLbj+AJ/+FQ/qHWfRJS6wR5YmxvR9Et/gUWIAQ8XB25DRkgNHbj+6e5UM4ZF6EiGZ4RUh+cFM0bhkebsZg3IYIH5KLefiv7xxkNWOYY4sToS+m4XzidcDwTIUd7eLfrFNEXFqOJS0hgvritKmoxSX18pBUIDV5wUpzBEmzDFIobtOMxnVKgkyux30PQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+HU75SsF7OH7XYi+53ZmdoZaTTCWwstZs/P1alP44og=;
 b=e4S8XA3uXDDiDU0GLG3hO64K4NYeO1vcjxANlsK4VmG1odW33YUvUnFnvtvgelEyGFh+hx1X8/TBABIH7IVx6zLXZ18ylJEKyIxac5BW1UuRju4n5wt4YK8gdgOPulLpH7PdH3l50SeFABa7jwHocmtDMezOeb9XQBpJBa8yYBwS/B2Ca3eapwoWymw+RGkoT2hGPRPmhu6CeTYJU1cANNLRFGrw1wokv3auKJAT7WdkegMh6We99+R4lx5smk6m0QTbBeYmAz8+NWFORHO05wvAGFEFRbowf6JllHRSq0Tykvk43LxNuKCjYmYV/VD4T3Rui29Y9qAR5gbXqnRFWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+HU75SsF7OH7XYi+53ZmdoZaTTCWwstZs/P1alP44og=;
 b=JJjFzhmv2H2+D4ImXAaexHU/V9Ek2iSEwyreqy6No5QlFdAcc+BNadRxHjFYvxjNJXTueXnqWhQQ42m0ZPOGc1lF8+SoMIj4AlNm8feS1/4WXAMtAhgngY1f3FrLMsXEYgmIL0wBrKnsgJ4STI2rAPSchkx0lkpQacBpX/30BSU=
Received: from DM4PR12MB5868.namprd12.prod.outlook.com (2603:10b6:8:67::17) by
 IA0PR12MB8304.namprd12.prod.outlook.com (2603:10b6:208:3dc::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.33; Tue, 25 Jul
 2023 10:30:42 +0000
Received: from DM4PR12MB5868.namprd12.prod.outlook.com
 ([fe80::645e:42c2:1108:8b87]) by DM4PR12MB5868.namprd12.prod.outlook.com
 ([fe80::645e:42c2:1108:8b87%4]) with mapi id 15.20.6609.032; Tue, 25 Jul 2023
 10:30:42 +0000
From: "Guo, Shikai" <Shikai.Guo@amd.com>
To: "Liang, Prike" <Prike.Liang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: enable SDMA MGCG for SDMA 5.2.x
Thread-Topic: [PATCH] drm/amdgpu: enable SDMA MGCG for SDMA 5.2.x
Thread-Index: AQHZvtlDxYRSIm07N0ixsrbLgtg0rK/KSEgg
Date: Tue, 25 Jul 2023 10:30:42 +0000
Message-ID: <DM4PR12MB5868E6929BB15BAEC72089BD9F03A@DM4PR12MB5868.namprd12.prod.outlook.com>
References: <20230725092020.3777355-1-Prike.Liang@amd.com>
In-Reply-To: <20230725092020.3777355-1-Prike.Liang@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=05f36ebd-8f61-4eb2-9c1d-ccfa42820bd1;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-07-25T10:30:10Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5868:EE_|IA0PR12MB8304:EE_
x-ms-office365-filtering-correlation-id: 29093b24-2ab6-4b6f-fef9-08db8cfa3292
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zcjFJ3gEpsdHVPeXk/iyLINeHIlIOaoU9Y0jJ8idzmzvvEgWDG1K9he5/eDZa25Z+gEEex6sk7LEXcG9LAMIm3MpxCIRALClvQKJ66hU5W4rdKw3gycu9jGSF7XxNRCQ/daOf7x2l27tQQsxrWjeVAw+hFff5g85bFlrAi2gD23NSEOy5PG+rlyPRr5JvPQQF33u5GsTxTZ0AW7TjrsNTWq1Y4Fd2zP8vjGJVaYSKkTKfP/iRWkkXy4793JIz0+CxXbvja4dVzSUfa3DPyC4c/aBOf/rR83EYUVFhFXxfU8RpxPTAcQEPeUk6RDpA9Ycc/smG7Kwj6B3IB6fwMQd4yGs9vUbq37R2UIaUVqUNInKFpXiuiAEk4LT0hsjoA7KT+Y/+tiCQUFG8Sv6ONtIgy8PfxPUJ014daJK0iT0b3JQ93poZu38Gdx21LvYVHxf643MRKkw9A3OAyCnwtW089Qcx6qFrpjvtfk0rUxTAF/ZAu/u7UNCvJM3iCWmpo3SuiBOoeqWdjZulDUMYIOZ8Zm/19v2A+4IOqG6SE3HBpsM9zrVmNvff+DmUAI6dZ8FZ98dN6K6lPU6u/C+86oteA4U83ToH2ZZismjmwyEfRPpFoD4uXQGZqnUyfyyJGFW
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5868.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(396003)(376002)(346002)(366004)(136003)(451199021)(55016003)(26005)(186003)(6506007)(71200400001)(53546011)(4326008)(83380400001)(66556008)(316002)(8676002)(76116006)(66476007)(64756008)(66446008)(8936002)(66946007)(41300700001)(52536014)(5660300002)(7696005)(9686003)(2906002)(478600001)(110136005)(38100700002)(122000001)(33656002)(86362001)(38070700005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ReenBAOuHt6sVmZQa6ZdiBtJfGkFWKdUF4x0ztLabrOmjNEt79RPd4KE/V4R?=
 =?us-ascii?Q?gwKP37rHKWzpv49+cmYVl2t2U98JVrYbn0ZKIP1Piw7uBIyz96QyNzmhDlvY?=
 =?us-ascii?Q?VAItuApLq6uO6UvyqV0xeXLweGS6ZiJtL2n0vSQrKYiTbLrtgNpsSBYlb8Ts?=
 =?us-ascii?Q?FqQ9bXhWBJOUW/Gc72UsB761VCtLrXkM9f9cCNlQmgbtoy+x+0kbmifejDGT?=
 =?us-ascii?Q?SjpD0GhL6NE+lBZyY11xmEKIgeixSfhThOe/FMqC6pclR1Pnlq4TmYdqqx75?=
 =?us-ascii?Q?E+qhzELnYOrrtDs4iU2yI+hCxvr36ZD0VSCdZnNWlU9dVsbIOOE9Q6aGAbWD?=
 =?us-ascii?Q?aSx9L1V/V2MgVGbQluiXdzMVX618MPQtRnP3ShcV2lo0xY1QfD30s+2VkWoQ?=
 =?us-ascii?Q?8I4JOyVO3Aox4mLD8oCRqHKqHTFtuHo0PyKM+n5WRLxZ3aps1cA45Iu+Ynbj?=
 =?us-ascii?Q?/ciV6Ij/sjSDocjMFrI/PTXeNosB5ELs3VB3btg0T9C2+xhpIgKythGeGo5q?=
 =?us-ascii?Q?apsd4Yu7cb7hx+FjBB/Ll2rkU3wH1ublQuRZ4JY+Svs3RP2GQhpsmIUX+5h2?=
 =?us-ascii?Q?ORmc2QnXqZquY789rA4E96kxG5Qks4KW1mCQMQCKZ9ou4ObxkiRmgHpHu0qH?=
 =?us-ascii?Q?k3Vk9JBMUrDmsb22ELwNBdbO2gXSqiBuszaTK4p3A1eR6P0DU79hcDF1+bwD?=
 =?us-ascii?Q?ANgjstyfrnqAaPfEXaKgp6Uz0XPj0EcpvOixNSRHtsJRYH4CxppgW60OGrQM?=
 =?us-ascii?Q?AdM0S1fnFb4bBv5UWvg7/Ij2/HocI+yOhokj93tKhqpZMjKze2uncxEgj5rJ?=
 =?us-ascii?Q?N6Vdh7vlr68+NIMydtz315zPqQOUgwt14eZ3xhHACRYlrwjrtn0ELzAFAvs6?=
 =?us-ascii?Q?8crqrJxOAzDTcM4T5zhaMW96FbXsukafh0SFFdq6jJI6O5KzL4XG+LNevqa0?=
 =?us-ascii?Q?ISOfVxEkUWjt0PU9XatG5DKNwkU4KL6kpnJ6ebucFKS7oGZ+JexVHmgyCdcI?=
 =?us-ascii?Q?mGln/7wP1VJVtJvZUpR4seTMqc+nYoi9MMmTvUgy3yaPMcyp5lFeDF1vSvB9?=
 =?us-ascii?Q?yF0fQCxx5+TZJShCAYkXwYbwdvhVyUdE3tXr5Ehtocj7s0aH6kogSbkS81rI?=
 =?us-ascii?Q?kJLv3sp92fg/09CkehoBw4i/BG5eNjPgvav+H/mQOo2yQYhzPLdQse7fo3Vj?=
 =?us-ascii?Q?BvqY1ZYTgqb33Rwi3aWMo8fo/iTQxrJF3dh5zzbT4iSDrECkaX6NRVI9BRev?=
 =?us-ascii?Q?JptZE3QjyGKMFJwtkqf/sbNxSABVS1ImVQZAt6pYr4d6MLX7kGPsqxm5das8?=
 =?us-ascii?Q?VhCs5iMNjEvtEqbtkDhtjtLxE/t1h6GHtgEumnBqUAFUfo68JDZZBk/00mO6?=
 =?us-ascii?Q?VMbGe+b29+fc9094WwljfNYQG1d6DVv7lzTZdwNsffAgzflqTlEekr1bVc3t?=
 =?us-ascii?Q?Mw3ZsABGFIuXdFBYFsNrIZhSgPl8OfjOXHabBjJNr3ZARReeyaaRNNlShBI8?=
 =?us-ascii?Q?mQwPhyf64HFnvoG36NMp6BNgm1t2TODvP3gRBbRCFeBCzl8r2AyAE1q1lgOv?=
 =?us-ascii?Q?mWeSGD2avo7+0nwEnu4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5868.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29093b24-2ab6-4b6f-fef9-08db8cfa3292
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jul 2023 10:30:42.0842 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /hog3Cfubbz5jT29LdfsV1GgJdty6je9cI2z+UQ/rCt+Fa6Ujh+vH1WcmQDKspI+YsBA7/Dpvmvu091nGfnZDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8304
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

Reviewed-by: shikaguo <shikai.guo@amd.com>

-----Original Message-----
From: Liang, Prike <Prike.Liang@amd.com>
Sent: Tuesday, July 25, 2023 5:20 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Guo, Shikai <Shikai.Guo=
@amd.com>; Liang, Prike <Prike.Liang@amd.com>
Subject: [PATCH] drm/amdgpu: enable SDMA MGCG for SDMA 5.2.x

Now the SDMA firmware support SDMA MGCG properly, so let's enable it from t=
he driver side.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nv.c        | 6 ++++--
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c | 1 +
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/n=
v.c index 6853b93ac82e..9bf7872e260d 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -901,7 +901,8 @@ static int nv_common_early_init(void *handle)
                        AMD_CG_SUPPORT_ATHUB_LS |
                        AMD_CG_SUPPORT_IH_CG |
                        AMD_CG_SUPPORT_VCN_MGCG |
-                       AMD_CG_SUPPORT_JPEG_MGCG;
+                       AMD_CG_SUPPORT_JPEG_MGCG |
+                       AMD_CG_SUPPORT_SDMA_MGCG;
                adev->pg_flags =3D AMD_PG_SUPPORT_GFX_PG |
                        AMD_PG_SUPPORT_VCN |
                        AMD_PG_SUPPORT_VCN_DPG |
@@ -962,7 +963,8 @@ static int nv_common_early_init(void *handle)
                        AMD_CG_SUPPORT_ATHUB_LS |
                        AMD_CG_SUPPORT_IH_CG |
                        AMD_CG_SUPPORT_VCN_MGCG |
-                       AMD_CG_SUPPORT_JPEG_MGCG;
+                       AMD_CG_SUPPORT_JPEG_MGCG |
+                       AMD_CG_SUPPORT_SDMA_MGCG;
                adev->pg_flags =3D AMD_PG_SUPPORT_VCN |
                        AMD_PG_SUPPORT_VCN_DPG |
                        AMD_PG_SUPPORT_JPEG |
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/a=
mdgpu/sdma_v5_2.c
index 809eca54fc61..f8b6a2637d1d 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
@@ -1653,6 +1653,7 @@ static int sdma_v5_2_set_clockgating_state(void *hand=
le,
        case IP_VERSION(5, 2, 5):
        case IP_VERSION(5, 2, 6):
        case IP_VERSION(5, 2, 3):
+       case IP_VERSION(5, 2, 7):
                sdma_v5_2_update_medium_grain_clock_gating(adev,
                                state =3D=3D AMD_CG_STATE_GATE);
                sdma_v5_2_update_medium_grain_light_sleep(adev,
--
2.34.1

