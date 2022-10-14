Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0B6BC433FE
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Oct 2022 07:41:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6FC7910EA94;
	Fri, 14 Oct 2022 07:41:19 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8985C10E11D
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Oct 2022 07:41:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B4ArafPPzdReZS0pxV73jyRf6XzHYAD27+MBXaVRZhCQQdIPqqd8HSAWkrTgOwYompNLv0tIcxEfCWHh4kFe7MGvQHHjWBQF8v6egwfUwsO4SpVGOKiLOmG8tyoEYS/ot639mOJRsyEaPm1IbjJNlbuorJnXv9cgLavsgn+T6/u8ZAXQ9DNKBguOFF7EX2jE+Y+ZePpgeltFBRTRbF/2kniYRuSw4b6ZbmHLslzsyEwGjGL3W9M4QIEzO7zb1qqJuDxBXnLSw833BiEALN5RjXyoPXLrdJ39YkWN5P0mAGe/GmQedvAmq9w5PY4TT1TZMPFnA+o75pESf9tONx4HnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bscG7xxh+kZf4LLCPyZhMYLyKbugtg8T1MMJf0iwydY=;
 b=gHg7tljr44+HJKp0SeUnhCW6yFWsj5Qgf9UXf5qPlLIKs/p/RPavCS5FflktGmdC4Y5Jf+3QkcVqGHHf61xw6KNxp7UzlfME5mjnMF7yB38NxlN0raOnskwzynOXDw6ujrvshSg3b8vMatWu8478e5vLEDDmNno/4i447BQvpk4UTQRnlSEViYrHO7p9HyG0RwELDEOoy3VcVYv7IIJ7ZRRTfM7pwq+8q7AJIM1nVXn+MvijldwnzBeRQmApto07ixP4VQDFfcxwzwxB/9qfACLFrQCvcwuiKBNz7kgP0O+5fclbHIr+zHSBVcxn7oFlAb/wxaBymjhh3yYH+H9k+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bscG7xxh+kZf4LLCPyZhMYLyKbugtg8T1MMJf0iwydY=;
 b=xtOB0LEuZfwboOEyFl986lq5PT4x3htD+vjlj7Va2dsYK7q0HSxhmANPufZHqI29stbz+7kzJGZHBgo8G5V9z86JD30H3s1JmRdFzCpUToufi0dn4RVCkVZda4cOKx0NSrE2nhpEBLUUpENDATFGKMip/AKAbNMCrzi5wE8Z2oI=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by MN2PR12MB4109.namprd12.prod.outlook.com (2603:10b6:208:1d9::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.26; Fri, 14 Oct
 2022 07:41:11 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::877b:16ff:dd33:debe]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::877b:16ff:dd33:debe%9]) with mapi id 15.20.5723.026; Fri, 14 Oct 2022
 07:41:11 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Feng, Kenneth" <Kenneth.Feng@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/2] drm/amd/pm: enable thermal alart on smu_v13_0_10
Thread-Topic: [PATCH 2/2] drm/amd/pm: enable thermal alart on smu_v13_0_10
Thread-Index: AQHY356WFYLELQ9gP0GeYsAK2xWe3a4NgQRw
Date: Fri, 14 Oct 2022 07:41:11 +0000
Message-ID: <BN9PR12MB525756818B3994F372CE9795FC249@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20221014072808.3712546-1-kenneth.feng@amd.com>
 <20221014072808.3712546-2-kenneth.feng@amd.com>
In-Reply-To: <20221014072808.3712546-2-kenneth.feng@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-10-14T07:41:07Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=bb577ff2-7ce8-4a76-891d-42a5aab57a8c;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|MN2PR12MB4109:EE_
x-ms-office365-filtering-correlation-id: 887a46f8-c847-40fd-79bb-08daadb776e0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /jbBeU3HGZ8DUSVWZoE9vwelQuRPC0ZPSNE54wgmoWECHgQ71g+rkYpo0zpeF+lN/AEdRlW3Q95KfnvI4Dbf1mYvT8CuxrF804K+0HJijzOAITakHOb5gSmEJ4/vCiR1o0vg1l6PyRys1ppiIrCc+MMIHLBUN2HnJ17S5uRXDZ7oloYJOCPVIyuj63Th9HVv5rXHj0K6CcC6Jd1GQqr2L2TlXbuSs11trb6xG1ePD2EeeEC1giL0pnF0CzFLvglUqf1uCv5uLtdy9r2i8bSOP2EQjQsqmLcWIUMRVglAgTV49RLLdIzHDmqTBeYEeGXNFJfoEw3A6h87IRp0xWig6KsJux9q+W7HRI32IIh4Jqh5Moiso8NNStv2NHsfR5n8Be7d6XBHdGeB6HR2LIGRGAgRYiH0Beg/xXEuHimXKNc80m8G2gUHPpQ0/nCKGztangWQcRRRJ+o279zf401F0L9SXs5TI2NTbX+VdVemDnk1viEPa3H96ujO6nsmwuNP2ZaDvtog7jHA3XZ7Hi4LYDr/1/ieDZShhcwDogNjLCBMYlrcb0b1aCcAoXfa1pFalflNBgb36FSTfPS/dJIP0mNrjxqslBO40sUZZH/FhMPA44kYdHwljQ07pa0JV9+ZcKO3j4Z5Q3XfEc0YJohUfxVfDw/sxx5cxQ4tX6Y19kEbwy6dBkXybnaiF+KAQsVrIkRwu5AfEJ54MD5Im07u8nOkOFPZt9C8z10Wf+fGLIhLJiHI9KAikXXm5pHup2G7zat+ltsvCzekiu+Q/mjLdA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(366004)(39860400002)(136003)(396003)(346002)(376002)(451199015)(41300700001)(83380400001)(26005)(33656002)(52536014)(8936002)(316002)(66476007)(66446008)(76116006)(8676002)(66946007)(66556008)(186003)(64756008)(9686003)(2906002)(55016003)(122000001)(86362001)(4326008)(53546011)(110136005)(6506007)(5660300002)(38070700005)(71200400001)(38100700002)(7696005)(478600001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?/agD1ZFIDMj8Q/GkZ6Z2UM//nxkoEmFpBcBeSHBBA1EnPzeD92eAmEf6kmfh?=
 =?us-ascii?Q?TcW5BphCH6/R1AGVEga2nObulsZWNNng7uhbWF4+7o5hdD6MS+DEqGHfircl?=
 =?us-ascii?Q?GFufeLLo4hPCtjGTPdkiLlYK5aO9Uc5zPCn8Ixl8BWDiZkk6Pla57hXQH41C?=
 =?us-ascii?Q?ZaOTjvAWbVIR1O4VcG+AHk/3FIpFcInS3xHnMcJwNCNMqvXW+szwGSC+IaP7?=
 =?us-ascii?Q?0N6zZnv+rPyTIucK870qtrBPPdSkyJ+FKdZDEDq+92TdkYJCfnoAFYlUSU8U?=
 =?us-ascii?Q?9PmfKECJF8l6CfBmpPMzWzzCzMnwaz6g7QoNy7KG9NXcsomUh3Wx4ut8do3r?=
 =?us-ascii?Q?CjHksgs9ewsZtjgZdQOkZapkszMQn2rT9Ho6As8yDWS6qMVzcCw3bzMNiNZz?=
 =?us-ascii?Q?cG8ZN837gGppu/vV0dPndSOr973GP/HTmtTswuZZx0QYxS1ef5i0tnYBRTSP?=
 =?us-ascii?Q?d3Y/AZTtY2X7bHlepBEpGgo/nPF/o+x2pIOqjaTuLYEVV0SEJF6bkLUohwqy?=
 =?us-ascii?Q?oPT7LqhEPlY9kV+PqqZsiMaXu7Ftry2CbZq5Hri8XqpPIJ5Dy5CH3hyRM4vO?=
 =?us-ascii?Q?V4x83Wwsl2fNKq6tkkEwh1avGZevBFPPcOymUr5xsUhQ7FDKYypDMoygE4Jl?=
 =?us-ascii?Q?tnn1W4IY0i3pz8PIdizMci8Y1J840XoP4vU+pNNyv36KWfS8G2S3Hysc3axN?=
 =?us-ascii?Q?SS5rgJgwTKDZAtiZTAGRs9m0vEDqpW2AJ0lBByn2Xv5ejdcvyfJLW3XMkcWy?=
 =?us-ascii?Q?9dZUKZ6787E6H0fJrNM82yPm5q2lEYp1JXWVA2D7aF9RVtTmlSiOWLfvP+3c?=
 =?us-ascii?Q?PgodNS1cTxgPeE/VCI/DlAbRuOhDqbf/IsbKeXNOuwjc2rLBrCePyHDPJcO5?=
 =?us-ascii?Q?U8aLlq2Wd6hZ1nls25DK9KdbGYZ+X6iQCmKqDRUxlRpGyIZ/mmZzdvxtSc+g?=
 =?us-ascii?Q?k+YibLmBVfwJh+zrqjy2ltqs4xJyJM2aPK7t8A3cN72LT3V+BxFrTBCx4Z7M?=
 =?us-ascii?Q?1zYqUzy9ZWt6FjJdn7ppAS49I1sUYJ95qWZdyGmC0oFvC1B8gkkXlSRBvuVD?=
 =?us-ascii?Q?YPDyBbd9uFb021XSXbcOBZWR96+OKIs6SLiScTWKqgR2XuOLsQK3/8F2hHFU?=
 =?us-ascii?Q?xi8qB46WQxxfm2MLVCXAaL052hIvltPizhIHUufklpVfpB3jiZ18WqhFbGsW?=
 =?us-ascii?Q?XoM97bN6IiwFGT1rcA3XhIVOIFCiUlDf3AYuDtoFZFHK9yrwMGuqLLBoU4Vo?=
 =?us-ascii?Q?RBLxbV4n54Rq40OGrzFze2B2XDwKBf81WaxeGU9MF32guYeRCa6iWCkZuhBr?=
 =?us-ascii?Q?IAfga0REohKOPHBsIhWcm2Gp3190DWhD4EZa585rhJy06G40xf/UjUXQxQKH?=
 =?us-ascii?Q?0OAVw4T2A/qoFsTqHVj50hsxrWTJx9OLRJIvjMKaXEiwav5VUWbXb255K/vh?=
 =?us-ascii?Q?YtvUVHM8ENnhucKGa+Gg24tC7+agjdp1RKeaTddUBahPld+vUVCI1DmUHS51?=
 =?us-ascii?Q?q4ziMp/xNZHHaN92n7+KQfIyPgxYsYjkbpaQfH/tAZsbVnGhbLwVZ6yFvhI6?=
 =?us-ascii?Q?GF26A+jjjIk7Fhoxne0lTslXC+j4bfE8PGpWJLI3?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 887a46f8-c847-40fd-79bb-08daadb776e0
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Oct 2022 07:41:11.0920 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /BaRZOBp2xZ3fY2phMyxtgkOPXXY0cnCkkvZbPmIEbYpX78OAsMRpHA8xz5NcVpWRHde/Q3dJokBgMf3PhYcyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4109
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
Cc: "Feng, Kenneth" <Kenneth.Feng@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

+	if (ret) {
+	  dev_err(adev->dev, "Failed to enable thermal alert!\n");
+	  return ret;

It seems code alignment issue here, please double check before the commit

Other than that, series is

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Kenneth =
Feng
Sent: Friday, October 14, 2022 15:28
To: amd-gfx@lists.freedesktop.org
Cc: Feng, Kenneth <Kenneth.Feng@amd.com>
Subject: [PATCH 2/2] drm/amd/pm: enable thermal alart on smu_v13_0_10

enable thermal alart on smu_v13_0_10

Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/am=
d/pm/swsmu/amdgpu_smu.c
index 3d436e7f6e95..4fe75dd2b329 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -1312,12 +1312,10 @@ static int smu_smc_hw_setup(struct smu_context *smu=
)
 		return ret;
 	}
=20
-	if (adev->ip_versions[MP1_HWIP][0] !=3D IP_VERSION(13, 0, 10)) {
-		ret =3D smu_enable_thermal_alert(smu);
-		if (ret) {
-			dev_err(adev->dev, "Failed to enable thermal alert!\n");
-			return ret;
-		}
+	ret =3D smu_enable_thermal_alert(smu);
+	if (ret) {
+	  dev_err(adev->dev, "Failed to enable thermal alert!\n");
+	  return ret;
 	}
=20
 	ret =3D smu_notify_display_change(smu);
--=20
2.25.1
