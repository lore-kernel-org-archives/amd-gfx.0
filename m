Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A55ACD3432
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Sep 2023 03:18:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7E55B10E222;
	Tue, 19 Sep 2023 03:18:08 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2050.outbound.protection.outlook.com [40.107.92.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EFE2310E222
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Sep 2023 03:18:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WBK+5+eD5WunbFJZRD1p4GMiLncUNb1jJozgA5nf0fJUDPOHPUEtPTwHO+MgXMnRPFYSUlmO1wf0YojlpCqXcit8I7kXNGuz0/5Q5IgI2p3XR2UlanoIRPuiiFZU+ost+UYkT6z+aBIPelI3SHagKP18iEBq1Kzw+hQZxkHFxGTTb3U/i07Rc4b0Z+C6GYXIf/u+rQ/aDDLwDNgi7qfKyVw7IjhWKfE/89LF9TfdsV50a234T4/zcQwc1U3rJi3QlZ2/u+2T4+Qt+ZnjBVR2OteMsy2Z0FVff411rqhLWs3ArWWLXDWk3tDMyzu3tl/9Yr85UvYj8fY2rMv/kjHJZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mOg4HA6R+zU5pved8G4AQsd7zLycQgk0ajDkqEt2cqY=;
 b=oVhsqoWU/o62ujWlyVMvZJ0WNh9VhcyHk6idyTtjEE//lvo94cPFg2QxBS8w9Y7jRWJwzNTXGLhe99YVHxSV35U2vpKKp4l22g67PP4nnyEUYCeREAVXNYckGnpYOoAYod5Uaz/XSoX3yTrjmpxszHLSGDhwI1c+Osmd27WCLq+3HazEpg1ChDetJTv0QSJdMx5waJI5217pkKzaQIEwQWKv2u7dIxj5ioCEZVOZQfwWaQOdczgyreYy8ymQ5wVNJjojtV6hJSYKNXL5vPDEEgOQv/ljwfED6BuNr4NeRbJhBDdZqbLyD78mtHSZmI1xMEx4dk3L5qFr/8kZfEct/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mOg4HA6R+zU5pved8G4AQsd7zLycQgk0ajDkqEt2cqY=;
 b=Wm9+rZv9qiLsE7eIOJX8xzVjQ/3dyGxoJkZZhDBoDWVa9fVSq5uoGFnVVxl+HH/xpGTsmebTKWXCmY57trePoM/N7RQcn7KYoMHtPZRKbW0zdPDKUyg3+V4OYKaCqmPs3389C2nYB9ngF9TepAsKVcKU8aoTMRChrrMwnOMkg74=
Received: from DS7PR12MB6071.namprd12.prod.outlook.com (2603:10b6:8:9d::11) by
 SN7PR12MB7202.namprd12.prod.outlook.com (2603:10b6:806:2a9::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.26; Tue, 19 Sep
 2023 03:18:01 +0000
Received: from DS7PR12MB6071.namprd12.prod.outlook.com
 ([fe80::c363:292a:63cc:ccf4]) by DS7PR12MB6071.namprd12.prod.outlook.com
 ([fe80::c363:292a:63cc:ccf4%3]) with mapi id 15.20.6792.024; Tue, 19 Sep 2023
 03:18:01 +0000
From: "Kamal, Asad" <Asad.Kamal@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Lazar,
 Lijo" <Lijo.Lazar@amd.com>
Subject: Re: [PATCH] drm/amd/pm: Round Q10 format values in SMU v13.0.6
Thread-Topic: [PATCH] drm/amd/pm: Round Q10 format values in SMU v13.0.6
Thread-Index: AQHZ59Sc3+haVQ2IE0ilgWvArardnrAhf/Wr
Date: Tue, 19 Sep 2023 03:18:00 +0000
Message-ID: <DS7PR12MB60713F01FFDC6A2154E564CD8EFAA@DS7PR12MB6071.namprd12.prod.outlook.com>
References: <20230915125937.1261267-1-lijo.lazar@amd.com>
In-Reply-To: <20230915125937.1261267-1-lijo.lazar@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=True;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-09-19T03:17:24.4348652Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6071:EE_|SN7PR12MB7202:EE_
x-ms-office365-filtering-correlation-id: 1cd70e7e-b290-4af3-26a3-08dbb8bf07b1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8vcyrAtYeP7vfTE6PGlslhPqyemA5lmFhOwnVjBu8rEJWsHsa/bze6ZJwkmTbbSc07PveeS/bOc30RcoR81pgcdU88QnSfCj9iDI0VKk+bL9FBlD8ak4FW8jTEHJmHVtSkaogDn54+aJs3vw8zjh0MdR3oM6rcVWGaeQp6ZocVLOLttDvWkxBX528T+a4hz7l5frF6bouh+TsEOuN9M/F/JImNqKubzZG7Qo/aFBw2tfu0yyiZigOM6ax3zFvMrRAbv6jzrjBL5DzHzQyxNH+GRgbabHXrF0xlSwVZ5O0CImggnRHZFJwFauG/u+asbI9Tq+Ykd6h7P3LMu0Son1kuHqRWFIl04y7lFQUXnan2DsieTMS2hQnm8nYJu1cKy9bMa0oOB0mZSsMpBQs9al9GrD00D9EalKpdvnD+8QtgdPhHG3fRTKStZ6aV29XiYAqVbs6bj+3Q82MtVRc0KNLHJrKHLS7zoAB5zmR3qpmhc/P068m26C4quxZ7p5Eo+F+8fm0MLIWepjl0MgQm+1FLX7u21GFgKo3QrYqNLMzkjAjSDGHkeQ/tMGZmQ0bfEv403E2ZczM0pkhBVAeQUg1fQvuqDd9WuAUjl1HyS+dWuW3l8jnCmZ3E2w1hJqZR48
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6071.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(346002)(396003)(39860400002)(136003)(376002)(1800799009)(186009)(451199024)(26005)(52536014)(8936002)(8676002)(122000001)(4326008)(83380400001)(33656002)(2906002)(55016003)(5660300002)(86362001)(53546011)(7696005)(6506007)(478600001)(71200400001)(6636002)(316002)(54906003)(9686003)(110136005)(76116006)(66946007)(66446008)(64756008)(38100700002)(38070700005)(66476007)(66556008)(41300700001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?8t31li0fVsjd73la7MMbT/Ws/+W4mb1oo7oV3pqdgx7nyJYefKUWDOTzzgQ7?=
 =?us-ascii?Q?gwZUJK8vmkWDstiNH6VxrTLQYGsCvTvjY6cCJYv4UAFqYQNBEfTenJk3VZ6L?=
 =?us-ascii?Q?+aBro1A96A0LDywrqLiDy64K7fE+u/Xq6/4XuR3KsdRpbB/PdVGWaSZ4P6xy?=
 =?us-ascii?Q?Uggrh2XOfuKjvRVXpBzbAjsIFPvj6dmqjybXi0CFwurThsRrBnst4gyi0VqJ?=
 =?us-ascii?Q?c56aXlRP7uzztYqoqs6rHr5xlFW/jvwnBrt2KAQkWBcnvT8/Ig31uK3c7/Fq?=
 =?us-ascii?Q?6pZ2JagCqPzijWWfCIPt5/eYiwMt4voqnu1f0mKdLjFJhf316ppUPbiHF979?=
 =?us-ascii?Q?QFjBzeICNmcbOqmgmw7r5tz4A/mKffTAkdTTYjoNM70pSc3pomHrNyNDtih6?=
 =?us-ascii?Q?uFvej+aCB9jGFNsMD8BZm9kIHCm30+nrrXekCMmr25ckgJWRbXp0vSZWb/7u?=
 =?us-ascii?Q?x5uFtIGyIi+1JdQMZ0yi7cvLx3lneiti6YgPb0YGSJdpFeVuyhYZqT4ZPZmg?=
 =?us-ascii?Q?hvWYGFt6wXz+u7G/O9afDnGuyKIPNjD/KzE6CX1z2vBZ4E2XY5YtIY0Vs/Kn?=
 =?us-ascii?Q?oIWhlk5UNTAa6lrq8WzoyKlQzhFUTIFity2D11+XZja3hMg6Uhx/F5ckmYLf?=
 =?us-ascii?Q?bnKN30ocnWXvyC8KvUYc/LFbwk7gNb45K+uB/PMrfYRamnYCJEAeY1ZaAGnL?=
 =?us-ascii?Q?vj7BNsJtmi3cIumAJCCAKwusb6ebAr+/EzST/tIgLNZJ1+P8k48ODax/2G89?=
 =?us-ascii?Q?4CCNVC5pCoW2O3IK9zBPi/wY5Ka1NsM7DKMgO/9bnOIVNLB+O0DvXB4eG7WO?=
 =?us-ascii?Q?J6fG9XOWmT+5CAG3D0V0tENaWRaUDT8ktJbEM6dz7umJiRGC0RiiD/3bAXxj?=
 =?us-ascii?Q?mE0IcSoK2biiYdAjUbz391spVWhgOZRvCvov+205OljvGfBrG1aIzzP66Ceh?=
 =?us-ascii?Q?1wCtz2w6rF/obw1pbsxx9uO+8Gn7mTk4WRXeZqCBo6y4zXRu20dFCSMQr+on?=
 =?us-ascii?Q?7+TtAigBgM019e7BuiRKh5XVHAWDOQdS6i3ua0q9r5gOj7c0KuOdCQo4Ae1v?=
 =?us-ascii?Q?UvfVVZgAVoU8sJf4YdOouRqPXp1AfiAmpkbVwGMYsna9t4fZ89jn5P2eJ5RW?=
 =?us-ascii?Q?/ndMeLhbzIjjZcCg1LTj/0QhUb4ldaNkIKF/l8vD+Acw9id1aJu70zYjaXsU?=
 =?us-ascii?Q?x2ennUBsggh8zdW7uYDku2GMQBZCH4sekJbEdgOx2iTNO5hDwTUZcR65uEJI?=
 =?us-ascii?Q?XSwLRJS8+uVZNawExP+A07X+diTy0oHxU5/UUIZpPOpEt50HkQMtxqLg/+4+?=
 =?us-ascii?Q?Uort3yLaBEZxVNLYlSBCzOSjWlHeplTkZWKgWGlqA3IBfVF4v6Ng2pC5PlQQ?=
 =?us-ascii?Q?Gnsr6kaB0M6slic/Ne4T3VunzwC9a6WKjeNLvdWynftZguNxNdsBAbwDuPbQ?=
 =?us-ascii?Q?KmHVfrBo8EEgfTy3JZcwWRqEAL983gk17OIBtmQiypPljv0dS+yGMxDM7HyS?=
 =?us-ascii?Q?8IHe7i1TPCka2LO9P065a+hxS4AIRMauTgbExR3fSZPOOw380581Rz8NYk/d?=
 =?us-ascii?Q?TfDpSF5BNwPazEq0F77h200mmSarqPUmL0+gu59RbTD4ZZ+IQMdUSTZkqxTo?=
 =?us-ascii?Q?XQ=3D=3D?=
Content-Type: multipart/alternative;
 boundary="_000_DS7PR12MB60713F01FFDC6A2154E564CD8EFAADS7PR12MB6071namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6071.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cd70e7e-b290-4af3-26a3-08dbb8bf07b1
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2023 03:18:00.9807 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jzS+mTcI+DKlSvxMwCMGOxQJL+GMzARdRHtBD+7SDsKgb5FsUJA0W+dLtH1ogpWiT+4IZZVNK8QSOCSWAK6rVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7202
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

--_000_DS7PR12MB60713F01FFDC6A2154E564CD8EFAADS7PR12MB6071namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - General]

Reviewed-by: Asad Kamal <asad.kamal@amd.com<mailto:asad.kamal@amd.com>>

Thanks & Regards
Asad
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Lijo Laz=
ar <lijo.lazar@amd.com>
Sent: Friday, September 15, 2023 6:29:37 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Kamal, Asad <Asad.Kamal=
@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>
Subject: [PATCH] drm/amd/pm: Round Q10 format values in SMU v13.0.6

Instead of neglecting fractional part, round the Q10 format values in
SMU v13.0.6 metrics table.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  | 70 ++++++++++---------
 1 file changed, 36 insertions(+), 34 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index f9c1219f0c4f..11a6cd96c601 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -244,6 +244,8 @@ struct PPTable_t {
 };

 #define SMUQ10_TO_UINT(x) ((x) >> 10)
+#define SMUQ10_FRAC(x) ((x) & 0x3ff)
+#define SMUQ10_ROUND(x) ((SMUQ10_TO_UINT(x)) + ((SMUQ10_FRAC(x)) >=3D 0x20=
0))

 struct smu_v13_0_6_dpm_map {
         enum smu_clk_type clk_type;
@@ -389,25 +391,25 @@ static int smu_v13_0_6_setup_driver_pptable(struct sm=
u_context *smu)
                         return -ETIME;

                 pptable->MaxSocketPowerLimit =3D
-                       SMUQ10_TO_UINT(metrics->MaxSocketPowerLimit);
+                       SMUQ10_ROUND(metrics->MaxSocketPowerLimit);
                 pptable->MaxGfxclkFrequency =3D
-                       SMUQ10_TO_UINT(metrics->MaxGfxclkFrequency);
+                       SMUQ10_ROUND(metrics->MaxGfxclkFrequency);
                 pptable->MinGfxclkFrequency =3D
-                       SMUQ10_TO_UINT(metrics->MinGfxclkFrequency);
+                       SMUQ10_ROUND(metrics->MinGfxclkFrequency);

                 for (i =3D 0; i < 4; ++i) {
                         pptable->FclkFrequencyTable[i] =3D
-                               SMUQ10_TO_UINT(metrics->FclkFrequencyTable[=
i]);
+                               SMUQ10_ROUND(metrics->FclkFrequencyTable[i]=
);
                         pptable->UclkFrequencyTable[i] =3D
-                               SMUQ10_TO_UINT(metrics->UclkFrequencyTable[=
i]);
-                       pptable->SocclkFrequencyTable[i] =3D SMUQ10_TO_UINT=
(
+                               SMUQ10_ROUND(metrics->UclkFrequencyTable[i]=
);
+                       pptable->SocclkFrequencyTable[i] =3D SMUQ10_ROUND(
                                 metrics->SocclkFrequencyTable[i]);
                         pptable->VclkFrequencyTable[i] =3D
-                               SMUQ10_TO_UINT(metrics->VclkFrequencyTable[=
i]);
+                               SMUQ10_ROUND(metrics->VclkFrequencyTable[i]=
);
                         pptable->DclkFrequencyTable[i] =3D
-                               SMUQ10_TO_UINT(metrics->DclkFrequencyTable[=
i]);
+                               SMUQ10_ROUND(metrics->DclkFrequencyTable[i]=
);
                         pptable->LclkFrequencyTable[i] =3D
-                               SMUQ10_TO_UINT(metrics->LclkFrequencyTable[=
i]);
+                               SMUQ10_ROUND(metrics->LclkFrequencyTable[i]=
);
                 }

                 /* use AID0 serial number by default */
@@ -730,50 +732,50 @@ static int smu_v13_0_6_get_smu_metrics_data(struct sm=
u_context *smu,
                 smu_cmn_get_smc_version(smu, NULL, &smu_version);
                 if (smu_version >=3D 0x552F00) {
                         xcc_id =3D GET_INST(GC, 0);
-                       *value =3D SMUQ10_TO_UINT(metrics->GfxclkFrequency[=
xcc_id]);
+                       *value =3D SMUQ10_ROUND(metrics->GfxclkFrequency[xc=
c_id]);
                 } else {
                         *value =3D 0;
                 }
                 break;
         case METRICS_CURR_SOCCLK:
         case METRICS_AVERAGE_SOCCLK:
-               *value =3D SMUQ10_TO_UINT(metrics->SocclkFrequency[0]);
+               *value =3D SMUQ10_ROUND(metrics->SocclkFrequency[0]);
                 break;
         case METRICS_CURR_UCLK:
         case METRICS_AVERAGE_UCLK:
-               *value =3D SMUQ10_TO_UINT(metrics->UclkFrequency);
+               *value =3D SMUQ10_ROUND(metrics->UclkFrequency);
                 break;
         case METRICS_CURR_VCLK:
-               *value =3D SMUQ10_TO_UINT(metrics->VclkFrequency[0]);
+               *value =3D SMUQ10_ROUND(metrics->VclkFrequency[0]);
                 break;
         case METRICS_CURR_DCLK:
-               *value =3D SMUQ10_TO_UINT(metrics->DclkFrequency[0]);
+               *value =3D SMUQ10_ROUND(metrics->DclkFrequency[0]);
                 break;
         case METRICS_CURR_FCLK:
-               *value =3D SMUQ10_TO_UINT(metrics->FclkFrequency);
+               *value =3D SMUQ10_ROUND(metrics->FclkFrequency);
                 break;
         case METRICS_AVERAGE_GFXACTIVITY:
-               *value =3D SMUQ10_TO_UINT(metrics->SocketGfxBusy);
+               *value =3D SMUQ10_ROUND(metrics->SocketGfxBusy);
                 break;
         case METRICS_AVERAGE_MEMACTIVITY:
-               *value =3D SMUQ10_TO_UINT(metrics->DramBandwidthUtilization=
);
+               *value =3D SMUQ10_ROUND(metrics->DramBandwidthUtilization);
                 break;
         case METRICS_CURR_SOCKETPOWER:
-               *value =3D SMUQ10_TO_UINT(metrics->SocketPower) << 8;
+               *value =3D SMUQ10_ROUND(metrics->SocketPower) << 8;
                 break;
         case METRICS_TEMPERATURE_HOTSPOT:
-               *value =3D SMUQ10_TO_UINT(metrics->MaxSocketTemperature) *
+               *value =3D SMUQ10_ROUND(metrics->MaxSocketTemperature) *
                          SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
                 break;
         case METRICS_TEMPERATURE_MEM:
-               *value =3D SMUQ10_TO_UINT(metrics->MaxHbmTemperature) *
+               *value =3D SMUQ10_ROUND(metrics->MaxHbmTemperature) *
                          SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
                 break;
         /* This is the max of all VRs and not just SOC VR.
          * No need to define another data type for the same.
          */
         case METRICS_TEMPERATURE_VRSOC:
-               *value =3D SMUQ10_TO_UINT(metrics->MaxVrTemperature) *
+               *value =3D SMUQ10_ROUND(metrics->MaxVrTemperature) *
                          SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
                 break;
         default:
@@ -1996,33 +1998,33 @@ static ssize_t smu_v13_0_6_get_gpu_metrics(struct s=
mu_context *smu, void **table
         smu_cmn_init_soft_gpu_metrics(gpu_metrics, 1, 3);

         gpu_metrics->temperature_hotspot =3D
-               SMUQ10_TO_UINT(metrics->MaxSocketTemperature);
+               SMUQ10_ROUND(metrics->MaxSocketTemperature);
         /* Individual HBM stack temperature is not reported */
         gpu_metrics->temperature_mem =3D
-               SMUQ10_TO_UINT(metrics->MaxHbmTemperature);
+               SMUQ10_ROUND(metrics->MaxHbmTemperature);
         /* Reports max temperature of all voltage rails */
         gpu_metrics->temperature_vrsoc =3D
-               SMUQ10_TO_UINT(metrics->MaxVrTemperature);
+               SMUQ10_ROUND(metrics->MaxVrTemperature);

         gpu_metrics->average_gfx_activity =3D
-               SMUQ10_TO_UINT(metrics->SocketGfxBusy);
+               SMUQ10_ROUND(metrics->SocketGfxBusy);
         gpu_metrics->average_umc_activity =3D
-               SMUQ10_TO_UINT(metrics->DramBandwidthUtilization);
+               SMUQ10_ROUND(metrics->DramBandwidthUtilization);

         gpu_metrics->average_socket_power =3D
-               SMUQ10_TO_UINT(metrics->SocketPower);
+               SMUQ10_ROUND(metrics->SocketPower);
         /* Energy counter reported in 15.259uJ (2^-16) units */
         gpu_metrics->energy_accumulator =3D metrics->SocketEnergyAcc;

         gpu_metrics->current_gfxclk =3D
-               SMUQ10_TO_UINT(metrics->GfxclkFrequency[xcc0]);
+               SMUQ10_ROUND(metrics->GfxclkFrequency[xcc0]);
         gpu_metrics->current_socclk =3D
-               SMUQ10_TO_UINT(metrics->SocclkFrequency[inst0]);
-       gpu_metrics->current_uclk =3D SMUQ10_TO_UINT(metrics->UclkFrequency=
);
+               SMUQ10_ROUND(metrics->SocclkFrequency[inst0]);
+       gpu_metrics->current_uclk =3D SMUQ10_ROUND(metrics->UclkFrequency);
         gpu_metrics->current_vclk0 =3D
-               SMUQ10_TO_UINT(metrics->VclkFrequency[inst0]);
+               SMUQ10_ROUND(metrics->VclkFrequency[inst0]);
         gpu_metrics->current_dclk0 =3D
-               SMUQ10_TO_UINT(metrics->DclkFrequency[inst0]);
+               SMUQ10_ROUND(metrics->DclkFrequency[inst0]);

         gpu_metrics->average_gfxclk_frequency =3D gpu_metrics->current_gfx=
clk;
         gpu_metrics->average_socclk_frequency =3D gpu_metrics->current_soc=
clk;
@@ -2047,9 +2049,9 @@ static ssize_t smu_v13_0_6_get_gpu_metrics(struct smu=
_context *smu, void **table
         gpu_metrics->system_clock_counter =3D ktime_get_boottime_ns();

         gpu_metrics->gfx_activity_acc =3D
-               SMUQ10_TO_UINT(metrics->SocketGfxBusyAcc);
+               SMUQ10_ROUND(metrics->SocketGfxBusyAcc);
         gpu_metrics->mem_activity_acc =3D
-               SMUQ10_TO_UINT(metrics->DramBandwidthUtilizationAcc);
+               SMUQ10_ROUND(metrics->DramBandwidthUtilizationAcc);

         gpu_metrics->firmware_timestamp =3D metrics->Timestamp;

--
2.25.1


--_000_DS7PR12MB60713F01FFDC6A2154E564CD8EFAADS7PR12MB6071namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
</head>
<body>
<p style=3D"font-family:Arial;font-size:10pt;color:#0000FF;margin:5pt;font-=
style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
[AMD Official Use Only - General]<br>
</p>
<br>
<div>
<div dir=3D"auto"><span style=3D"font-family:-apple-system, HelveticaNeue;f=
ont-size:14.6667px;display:inline !important">Reviewed-by: Asad Kamal &lt;<=
/span><a href=3D"mailto:asad.kamal@amd.com" class=3D"ms-outlook-linkify" st=
yle=3D"font-family: -apple-system, HelveticaNeue; font-size: 14.6667px; col=
or: rgb(0, 120, 212);">asad.kamal@amd.com</a><span style=3D"font-family:-ap=
ple-system, HelveticaNeue;font-size:14.6667px;display:inline !important">&g=
t;</span><br>
</div>
<div dir=3D"auto">
<div><br>
</div>
</div>
<div id=3D"ms-outlook-mobile-signature" dir=3D"auto">Thanks &amp; Rega<span=
>rds</span></div>
<div id=3D"ms-outlook-mobile-signature" dir=3D"auto"><span>Asad</span></div=
>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Lijo Lazar &lt;lijo.lazar@amd=
.com&gt;<br>
<b>Sent:</b> Friday, September 15, 2023 6:29:37 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Kamal, Asa=
d &lt;Asad.Kamal@amd.com&gt;; Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;<=
br>
<b>Subject:</b> [PATCH] drm/amd/pm: Round Q10 format values in SMU v13.0.6<=
/font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Instead of neglecting fractional part, round the Q=
10 format values in<br>
SMU v13.0.6 metrics table.<br>
<br>
Signed-off-by: Lijo Lazar &lt;lijo.lazar@amd.com&gt;<br>
---<br>
&nbsp;.../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c&nbsp; | 70 ++++++++++---=
------<br>
&nbsp;1 file changed, 36 insertions(+), 34 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c<br>
index f9c1219f0c4f..11a6cd96c601 100644<br>
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c<br>
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c<br>
@@ -244,6 +244,8 @@ struct PPTable_t {<br>
&nbsp;};<br>
&nbsp;<br>
&nbsp;#define SMUQ10_TO_UINT(x) ((x) &gt;&gt; 10)<br>
+#define SMUQ10_FRAC(x) ((x) &amp; 0x3ff)<br>
+#define SMUQ10_ROUND(x) ((SMUQ10_TO_UINT(x)) + ((SMUQ10_FRAC(x)) &gt;=3D 0=
x200))<br>
&nbsp;<br>
&nbsp;struct smu_v13_0_6_dpm_map {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum smu_clk_type clk_type=
;<br>
@@ -389,25 +391,25 @@ static int smu_v13_0_6_setup_driver_pptable(struct sm=
u_context *smu)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; retur=
n -ETIME;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; pptable-&gt;MaxSocketPowerLimit =3D<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SMUQ10_TO_UINT(m=
etrics-&gt;MaxSocketPowerLimit);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SMUQ10_ROUND(met=
rics-&gt;MaxSocketPowerLimit);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; pptable-&gt;MaxGfxclkFrequency =3D<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SMUQ10_TO_UINT(m=
etrics-&gt;MaxGfxclkFrequency);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SMUQ10_ROUND(met=
rics-&gt;MaxGfxclkFrequency);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; pptable-&gt;MinGfxclkFrequency =3D<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SMUQ10_TO_UINT(m=
etrics-&gt;MinGfxclkFrequency);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SMUQ10_ROUND(met=
rics-&gt;MinGfxclkFrequency);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; 4; ++i) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pptab=
le-&gt;FclkFrequencyTable[i] =3D<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SMUQ10_TO_UINT(metrics-&gt;FclkFrequencyTab=
le[i]);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SMUQ10_ROUND(metrics-&gt;FclkFrequencyTable=
[i]);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pptab=
le-&gt;UclkFrequencyTable[i] =3D<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SMUQ10_TO_UINT(metrics-&gt;UclkFrequencyTab=
le[i]);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pptable-&gt;Socc=
lkFrequencyTable[i] =3D SMUQ10_TO_UINT(<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SMUQ10_ROUND(metrics-&gt;UclkFrequencyTable=
[i]);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pptable-&gt;Socc=
lkFrequencyTable[i] =3D SMUQ10_ROUND(<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; metrics-&gt;SocclkFrequencyTable=
[i]);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pptab=
le-&gt;VclkFrequencyTable[i] =3D<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SMUQ10_TO_UINT(metrics-&gt;VclkFrequencyTab=
le[i]);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SMUQ10_ROUND(metrics-&gt;VclkFrequencyTable=
[i]);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pptab=
le-&gt;DclkFrequencyTable[i] =3D<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SMUQ10_TO_UINT(metrics-&gt;DclkFrequencyTab=
le[i]);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SMUQ10_ROUND(metrics-&gt;DclkFrequencyTable=
[i]);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pptab=
le-&gt;LclkFrequencyTable[i] =3D<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SMUQ10_TO_UINT(metrics-&gt;LclkFrequencyTab=
le[i]);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SMUQ10_ROUND(metrics-&gt;LclkFrequencyTable=
[i]);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; /* use AID0 serial number by default */<br>
@@ -730,50 +732,50 @@ static int smu_v13_0_6_get_smu_metrics_data(struct sm=
u_context *smu,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; smu_cmn_get_smc_version(smu, NULL, &amp;smu_version);=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (smu_version &gt;=3D 0x552F00) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; xcc_i=
d =3D GET_INST(GC, 0);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *value =3D SMUQ1=
0_TO_UINT(metrics-&gt;GfxclkFrequency[xcc_id]);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *value =3D SMUQ1=
0_ROUND(metrics-&gt;GfxclkFrequency[xcc_id]);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; } else {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *valu=
e =3D 0;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; break;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case METRICS_CURR_SOCCLK:<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case METRICS_AVERAGE_SOCCL=
K:<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; *value =3D SMUQ10_TO_UINT(metrics-&gt;SocclkFrequency[0]);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; *value =3D SMUQ10_ROUND(metrics-&gt;SocclkFrequency[0]);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; break;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case METRICS_CURR_UCLK:<br=
>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case METRICS_AVERAGE_UCLK:=
<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; *value =3D SMUQ10_TO_UINT(metrics-&gt;UclkFrequency);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; *value =3D SMUQ10_ROUND(metrics-&gt;UclkFrequency);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; break;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case METRICS_CURR_VCLK:<br=
>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; *value =3D SMUQ10_TO_UINT(metrics-&gt;VclkFrequency[0]);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; *value =3D SMUQ10_ROUND(metrics-&gt;VclkFrequency[0]);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; break;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case METRICS_CURR_DCLK:<br=
>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; *value =3D SMUQ10_TO_UINT(metrics-&gt;DclkFrequency[0]);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; *value =3D SMUQ10_ROUND(metrics-&gt;DclkFrequency[0]);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; break;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case METRICS_CURR_FCLK:<br=
>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; *value =3D SMUQ10_TO_UINT(metrics-&gt;FclkFrequency);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; *value =3D SMUQ10_ROUND(metrics-&gt;FclkFrequency);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; break;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case METRICS_AVERAGE_GFXAC=
TIVITY:<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; *value =3D SMUQ10_TO_UINT(metrics-&gt;SocketGfxBusy);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; *value =3D SMUQ10_ROUND(metrics-&gt;SocketGfxBusy);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; break;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case METRICS_AVERAGE_MEMAC=
TIVITY:<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; *value =3D SMUQ10_TO_UINT(metrics-&gt;DramBandwidthUtilization);=
<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; *value =3D SMUQ10_ROUND(metrics-&gt;DramBandwidthUtilization);<b=
r>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; break;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case METRICS_CURR_SOCKETPO=
WER:<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; *value =3D SMUQ10_TO_UINT(metrics-&gt;SocketPower) &lt;&lt; 8;<b=
r>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; *value =3D SMUQ10_ROUND(metrics-&gt;SocketPower) &lt;&lt; 8;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; break;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case METRICS_TEMPERATURE_H=
OTSPOT:<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; *value =3D SMUQ10_TO_UINT(metrics-&gt;MaxSocketTemperature) *<br=
>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; *value =3D SMUQ10_ROUND(metrics-&gt;MaxSocketTemperature) *<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; break;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case METRICS_TEMPERATURE_M=
EM:<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; *value =3D SMUQ10_TO_UINT(metrics-&gt;MaxHbmTemperature) *<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; *value =3D SMUQ10_ROUND(metrics-&gt;MaxHbmTemperature) *<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; break;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* This is the max of all =
VRs and not just SOC VR.<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * No need to define =
another data type for the same.<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case METRICS_TEMPERATURE_V=
RSOC:<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; *value =3D SMUQ10_TO_UINT(metrics-&gt;MaxVrTemperature) *<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; *value =3D SMUQ10_ROUND(metrics-&gt;MaxVrTemperature) *<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; break;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default:<br>
@@ -1996,33 +1998,33 @@ static ssize_t smu_v13_0_6_get_gpu_metrics(struct s=
mu_context *smu, void **table<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_cmn_init_soft_gpu_metr=
ics(gpu_metrics, 1, 3);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpu_metrics-&gt;temperatur=
e_hotspot =3D<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; SMUQ10_TO_UINT(metrics-&gt;MaxSocketTemperature);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; SMUQ10_ROUND(metrics-&gt;MaxSocketTemperature);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Individual HBM stack te=
mperature is not reported */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpu_metrics-&gt;temperatur=
e_mem =3D<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; SMUQ10_TO_UINT(metrics-&gt;MaxHbmTemperature);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; SMUQ10_ROUND(metrics-&gt;MaxHbmTemperature);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Reports max temperature=
 of all voltage rails */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpu_metrics-&gt;temperatur=
e_vrsoc =3D<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; SMUQ10_TO_UINT(metrics-&gt;MaxVrTemperature);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; SMUQ10_ROUND(metrics-&gt;MaxVrTemperature);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpu_metrics-&gt;average_gf=
x_activity =3D<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; SMUQ10_TO_UINT(metrics-&gt;SocketGfxBusy);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; SMUQ10_ROUND(metrics-&gt;SocketGfxBusy);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpu_metrics-&gt;average_um=
c_activity =3D<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; SMUQ10_TO_UINT(metrics-&gt;DramBandwidthUtilization);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; SMUQ10_ROUND(metrics-&gt;DramBandwidthUtilization);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpu_metrics-&gt;average_so=
cket_power =3D<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; SMUQ10_TO_UINT(metrics-&gt;SocketPower);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; SMUQ10_ROUND(metrics-&gt;SocketPower);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Energy counter reported=
 in 15.259uJ (2^-16) units */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpu_metrics-&gt;energy_acc=
umulator =3D metrics-&gt;SocketEnergyAcc;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpu_metrics-&gt;current_gf=
xclk =3D<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; SMUQ10_TO_UINT(metrics-&gt;GfxclkFrequency[xcc0]);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; SMUQ10_ROUND(metrics-&gt;GfxclkFrequency[xcc0]);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpu_metrics-&gt;current_so=
cclk =3D<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; SMUQ10_TO_UINT(metrics-&gt;SocclkFrequency[inst0]);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpu_metrics-&gt;current_uclk =3D SMUQ=
10_TO_UINT(metrics-&gt;UclkFrequency);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; SMUQ10_ROUND(metrics-&gt;SocclkFrequency[inst0]);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpu_metrics-&gt;current_uclk =3D SMUQ=
10_ROUND(metrics-&gt;UclkFrequency);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpu_metrics-&gt;current_vc=
lk0 =3D<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; SMUQ10_TO_UINT(metrics-&gt;VclkFrequency[inst0]);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; SMUQ10_ROUND(metrics-&gt;VclkFrequency[inst0]);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpu_metrics-&gt;current_dc=
lk0 =3D<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; SMUQ10_TO_UINT(metrics-&gt;DclkFrequency[inst0]);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; SMUQ10_ROUND(metrics-&gt;DclkFrequency[inst0]);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpu_metrics-&gt;average_gf=
xclk_frequency =3D gpu_metrics-&gt;current_gfxclk;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpu_metrics-&gt;average_so=
cclk_frequency =3D gpu_metrics-&gt;current_socclk;<br>
@@ -2047,9 +2049,9 @@ static ssize_t smu_v13_0_6_get_gpu_metrics(struct smu=
_context *smu, void **table<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpu_metrics-&gt;system_clo=
ck_counter =3D ktime_get_boottime_ns();<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpu_metrics-&gt;gfx_activi=
ty_acc =3D<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; SMUQ10_TO_UINT(metrics-&gt;SocketGfxBusyAcc);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; SMUQ10_ROUND(metrics-&gt;SocketGfxBusyAcc);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpu_metrics-&gt;mem_activi=
ty_acc =3D<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; SMUQ10_TO_UINT(metrics-&gt;DramBandwidthUtilizationAcc);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; SMUQ10_ROUND(metrics-&gt;DramBandwidthUtilizationAcc);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpu_metrics-&gt;firmware_t=
imestamp =3D metrics-&gt;Timestamp;<br>
&nbsp;<br>
-- <br>
2.25.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_DS7PR12MB60713F01FFDC6A2154E564CD8EFAADS7PR12MB6071namp_--
