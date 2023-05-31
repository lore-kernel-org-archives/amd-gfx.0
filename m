Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78A9DC77B7A
	for <amd-gfx@archiver.kernel.org>; Wed, 31 May 2023 14:02:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EA37D10E4CA;
	Wed, 31 May 2023 14:02:04 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2064.outbound.protection.outlook.com [40.107.243.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 40FC710E4CA
 for <amd-gfx@lists.freedesktop.org>; Wed, 31 May 2023 14:02:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lzPqKvH7jy4quDPsX6QxBXhXge9FgUrmVnA5AOqMor2L8eR6GOAjU3EaD/61bPnHbd0AKWdfHLmmL5YO0gZXcT3u/gFcbDYeSXo0Zg4uOz55SQnOn0i27Ge4Wcz0GDHaYs2GiG/+CbaIFoVrIlR8gHhitjoXTN0AAc9DdpPqTC+Nu2B/eCb5RCprdSLl979QqJvLq1nAe9UrAJ5JeWxigELtvKN8RyT93AJhEkKQUgf3Anf485iw+hr98JkY7ziS5DGHy7ojmrUqBw2pMp/Fx9aUXCjMba3HD20maqqj0barFvMj0TtxemKVm4IpdmZl5MQP2luQms+eszBTJ6WNCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mB336DEs8UjRoU7uM0FBPWAaIEus9JlEDvixNaiV9K0=;
 b=NYgHKqYYoROZZXZD1bd690SaHfSqlmX3Uc4ReIUAwUvQhVF2As2+XbypNsNt0EVooLLNXJXDwZxH34RyeWaxfD0E/YonFSEvZTf3Abc4EFSB/Jjp8yrAedKuEcKzeVqzhrW9QaBPOtXCJYXyzURECg7Xihy0l0BVJ+mbB+7dpR73V0fJhF/yO1qLpctzXAxVY+eoUal50sP3r/2fdfoFM9m0JaeVYF+DkOq0w31amMAiM6NdTBdv7FaV0Mf83cY9uaYdvUmj1Whn0OvF8wN1Q16cDEmM0R3zx68IidFYyv2pQqgX1eYx7CpZVN6CYcg4spKa1Bits2rITVp4Lr4Iyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mB336DEs8UjRoU7uM0FBPWAaIEus9JlEDvixNaiV9K0=;
 b=Beg9mVvBRaK1mxlQiL8dbIyXL3twGe0Q0BsT/HQKkG55aUQJDkzKIOObrKjahfkpK7PUi/hV0Jz9ppPf1v/4r8Jvs286ITeKu7wgbg1gE5lm8HPQYhZVV/O0gwXhNKoL+GoAdP0fn7K7uldGNtxRP8XZukoxJ9ZtrvkocnO+6yQ=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by SJ2PR12MB8720.namprd12.prod.outlook.com (2603:10b6:a03:539::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.24; Wed, 31 May
 2023 14:02:00 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::9c90:4cbc:7d12:fb99]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::9c90:4cbc:7d12:fb99%3]) with mapi id 15.20.6433.022; Wed, 31 May 2023
 14:02:00 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Kamal, Asad" <Asad.Kamal@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/pm: add unique serial number support for
 smu_v13_0_6
Thread-Topic: [PATCH] drm/amd/pm: add unique serial number support for
 smu_v13_0_6
Thread-Index: AQHZk8IWcHR+3lBA8UmAq7VuDdlsS690aVQQ
Date: Wed, 31 May 2023 14:01:59 +0000
Message-ID: <BN9PR12MB5257DD68FF6B392D6A1144D5FC489@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20230531131601.806247-1-asad.kamal@amd.com>
In-Reply-To: <20230531131601.806247-1-asad.kamal@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=ff23c0e5-64ea-4e80-8929-714641748da0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-05-31T14:01:40Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|SJ2PR12MB8720:EE_
x-ms-office365-filtering-correlation-id: 81af030c-a1b5-4e03-0843-08db61df9a7a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2AWSTTKeHvTqgqgOX0Dh1e+Gaj8UJT5IbdocU/vXcQ4WejQAm7wxAocrbH/q2nYrCbmJ2LuClw9I4n8Z7+ICtim+O1KYUqRMBn0EXG93S1lKgcsh9/bRqYt3UslVOJ746pbwMXPDdvnHi+N7DtymvXxt6zna8BOaK/SMQ98Gl8cKMb/btRe1zgWT8aMB3oO6lrPypJ8IYVtBezNQ71yMzshQ6gxEIs5V/1utX4UYKMAczlV7MFHh/BnE5Qgx9E6MMc2bD8wTPS/Cq1wEXCj7oVKwePI+fuwNOYH+vtuIyE2ysYtHyUHwwkOfKoSeQ5ZwrKostazTAubAE+nPQYXQdYnTixBpsmO4NRDrcbqsRhPOcyeyU+YE4LuUxYL9vey2ApS9No9svgd1ISPFH1CPyBhIMK43Wr3FWHkiUT6lrSXVY4TyOIOkV8oS3JGu1IljeeuwHePQIMNW6HLHJPvzva5mrYJyo/6VGiOQdNS6qhPp4HQ3YuehRAiIFS5IstSBcOsdKxHAbpcQF+AzLpxBBmQjluq02KzU69e1uiCl4lfjSi9vFj5pI/sHLHEDJPzABZT9OUp2d8nzj6O4fkpaTKI9OXnFrKC+iHNB3YqOJhE8NgjSecJm+9AhwErrVG99
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(39860400002)(346002)(136003)(396003)(366004)(451199021)(41300700001)(54906003)(478600001)(110136005)(38100700002)(122000001)(66446008)(64756008)(66476007)(76116006)(66946007)(38070700005)(4326008)(71200400001)(66556008)(86362001)(33656002)(316002)(7696005)(55016003)(6506007)(9686003)(53546011)(26005)(2906002)(186003)(83380400001)(8676002)(52536014)(5660300002)(8936002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?vqsaCbpKjaC9B2wv/DZvZQcfg14whWbS4s4H8D0dXi3A0aQRDF2TVs+8xsMo?=
 =?us-ascii?Q?vpYu7/QxwwHFCCZKF5QwiOrVsoRBqzy08nzfKq8fEi9cyUHbF+MvtX9rnBAu?=
 =?us-ascii?Q?ojsJ+LoHUO6le2mChVEfxmwD0uWHwPW7WzsnQKc19aq0RHGRG75jwzzVnUSN?=
 =?us-ascii?Q?0MwO9h2GIFdEk5wOJmT1hDY5oa89Mo7M+TDBdfZY/uGK+icEW+j/XCI7Q0sf?=
 =?us-ascii?Q?9HQlHxhbpDlfn0sLDrjw1naLU1YFwQ7UtKJTyKoZlqq1GES27oxxVfR6olHt?=
 =?us-ascii?Q?jUrH5ZcJJSMc0kWg/aGRVx1k86xJC/NeQHbM7jMMbBDMXGjanav0dZGAm8ur?=
 =?us-ascii?Q?UnuW++cPp6McLSrEsnWDW1Hjh+TBYKT5gPNnSY2MGkde0QKC2L9voemjCMWx?=
 =?us-ascii?Q?KZlUEZ13eLsYOS9N2dDqSyllukhthshNbLYPrE1ZMK56EDFRwO5OKc/2ACjr?=
 =?us-ascii?Q?+JxfWJkpotYZevb0xyS5viRlLur2w1109G2gNW7zHSqAIg45Cs1jZxki+xS8?=
 =?us-ascii?Q?DzHIlcHveZZS5UO35AgBpLL2josoku/YNWRicre1XL5yYD1XMx5+l0bc+ayD?=
 =?us-ascii?Q?+gxXSq6i8Wune162hn2JiH5iqaos9EKatYFMRxxYX9lESodnamKTCsIowA9G?=
 =?us-ascii?Q?BqCAvy1nkl18/7qfzusF+Nqnm/0MoEI2PEbEmniE+o/fs+eUEM+/6RmrzPvy?=
 =?us-ascii?Q?VzAfyXOQSRXjecRcgC//CJ6hajnqYkQKovCMyuOPq8K4nRjGKzxF7M6foQWR?=
 =?us-ascii?Q?OA5HxuNd6OfAeXlFexfGc/yYqkWewWBPbOyHJWVtG4L4P5wsnzCQ59AhJNOA?=
 =?us-ascii?Q?D1/rcRthbqwC8BoRhgoNAM6JRNoCGqeFBbNRZ6vwVJSyS9fr/ZdUYEHKKWDd?=
 =?us-ascii?Q?RQ+4sKsDLCQ1FJwwmFW7vrGWLpI3T8vcch/GNHzu8vO6ueCcIKsbp3J8rxPG?=
 =?us-ascii?Q?pLqm0d5bEuWnBahSSOdn8mhTtJeUklOWSKbmClvyiwJMzPk5B8SCSEh/pCkN?=
 =?us-ascii?Q?US17OYbGvfsAJ3TYnoPuPmrqPh2xSIwgFUSrqzIwj83THNL61oIRrQMJuueW?=
 =?us-ascii?Q?6yLcy3ZsKyo3yl6MsW4KdM+97JEY6NDSG79titeHmQdrsWE9zeq0A3LSejK0?=
 =?us-ascii?Q?mEENbfi+Ecr5r5Ck+HLjI0UQ/wisXVLLn5E/dBgzfkg/+mEX6U6i6Hy2oTN8?=
 =?us-ascii?Q?tDPPYNsXbKLJU9yyT7jsrvh7kZL/hB7dt1OeKOP8N9DL3dBiza52R3L305PQ?=
 =?us-ascii?Q?WtMrA2iU2/tMUhxLeJHsSd28oWaSOpsJvYTS4X8QVKFiXa3/tXEnndrR5lYc?=
 =?us-ascii?Q?1iDpmPz2i+7BpGvZuymRlW6su6dPN4QbbMsBpwrt0CzAWKUxxtpsbCyF18Vb?=
 =?us-ascii?Q?wTXm1fMEfFDWIvgX6lfTpFxJbfySoIGMrR4rQL/0x8VWtezknPdR0cbGYAUZ?=
 =?us-ascii?Q?rlhZ6LCNwiNg4WMUecyJwtGlL9Gjuo2QdRHFLea7K//7Yf3iyCbvtV8g0ANz?=
 =?us-ascii?Q?6w12kf+ZS0EODnqGTB2rLPPhvgpE419DVfcv/QcWOoGq0nhpqQHh8NzwvXx+?=
 =?us-ascii?Q?G7scTlqCe2RLliXqA+uyN1tmvGzstReTApRTjMCX?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81af030c-a1b5-4e03-0843-08db61df9a7a
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 May 2023 14:01:59.9825 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: y9I/8x8FbelEoLSyqPytMA2ooJChuiPuvyPtQcntbrxPWYkrprpG0tA6H/bVeJYot4cuS757wvt+x3++RPZ57g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8720
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
Cc: "Ma, Le" <Le.Ma@amd.com>, "Lazar, Lijo" <Lijo.Lazar@amd.com>, "Wang,
 Yang\(Kevin\)" <KevinYang.Wang@amd.com>, "Zhang, 
 Morris" <Shiwu.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Kamal, Asad <Asad.Kamal@amd.com>
Sent: Wednesday, May 31, 2023 21:16
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Lazar, Lijo <Lijo.Lazar@amd.com=
>; Ma, Le <Le.Ma@amd.com>; Zhang, Morris <Shiwu.Zhang@amd.com>; Wang, Yang(=
Kevin) <KevinYang.Wang@amd.com>
Subject: [PATCH] drm/amd/pm: add unique serial number support for smu_v13_0=
_6

From: Yang Wang <KevinYang.Wang@amd.com>

add unique serial number support for smu_v13_0_6.
(use aid0 serial number by default)

Signed-off-by: Yang Wang <KevinYang.Wang@amd.com>
Signed-off-by: Asad Kamal <asad.kamal@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
---
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  | 20 ++++++++-----------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index b9f32e0364db..75255e0baf91 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -192,6 +192,7 @@ struct PPTable_t {
        uint32_t LclkFrequencyTable[4];
        uint32_t MaxLclkDpmRange;
        uint32_t MinLclkDpmRange;
+       uint64_t PublicSerialNumber_AID;
        bool Init;
 };

@@ -352,6 +353,9 @@ static int smu_v13_0_6_setup_driver_pptable(struct smu_=
context *smu)
                                SMUQ10_TO_UINT(metrics->LclkFrequencyTable[=
i]);
                }

+               /* use AID0 serial number by default */
+               pptable->PublicSerialNumber_AID =3D metrics->PublicSerialNu=
mber_AID[0];
+
                pptable->Init =3D true;
        }

@@ -1856,19 +1860,11 @@ static void smu_v13_0_6_i2c_control_fini(struct smu=
_context *smu)  static void smu_v13_0_6_get_unique_id(struct smu_context *s=
mu)  {
        struct amdgpu_device *adev =3D smu->adev;
-       //SmuMetrics_t *metrics =3D smu->smu_table.metrics_table;
-       uint32_t upper32 =3D 0, lower32 =3D 0;
-       int ret;
-
-       ret =3D smu_cmn_get_metrics_table(smu, NULL, false);
-       if (ret)
-               goto out;
-
-       //upper32 =3D metrics->PublicSerialNumUpper32;
-       //lower32 =3D metrics->PublicSerialNumLower32;
+       struct smu_table_context *smu_table =3D &smu->smu_table;
+       struct PPTable_t *pptable =3D
+               (struct PPTable_t *)smu_table->driver_pptable;

-out:
-       adev->unique_id =3D ((uint64_t)upper32 << 32) | lower32;
+       adev->unique_id =3D pptable->PublicSerialNumber_AID;
        if (adev->serial[0] =3D=3D '\0')
                sprintf(adev->serial, "%016llx", adev->unique_id);  }
--
2.34.1

