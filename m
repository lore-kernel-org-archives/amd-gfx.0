Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32F1FC28B28
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Mar 2025 05:28:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C64C210E0B8;
	Wed, 12 Mar 2025 05:28:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wMvX+kYJ";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2047.outbound.protection.outlook.com [40.107.237.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AFE0010E0B8
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Mar 2025 05:28:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d0qNBM4BgajjDGgZzNPMysK3NG8Sv/61Kg0bJS3f93zdBZzKcB14YfT750efOi7/uTIlCA5C57BJNXgzC061wvqT+DkXGHdyByLIqPQ14Ey+FGVw4o0E0PtefeoPMVL7VGX5mS4K/pEDokfLBEZ8RoRmtNHluHVlYCgqTAxei1kLZRiLdcoCMUmR1BM7LIvDUHsDCCebbMvIgAiCwqXm6IewS/ImzXFeqPn6qzky+H0br0YHVBzklXp5AoMZccsZXSjCs6C13bALMbrfOjIKLcaHePpcUQX4njvYeUzw9+beUfsAGy98hfTXHvKZp+T8kq8rPDYQo4HQ4rkQRL0t+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+qx4gyiLNNIbhQcsmIn679iRCXakkIc6BoQ3s6NQbbw=;
 b=dJsJ5P2c6KaeK8DmkRaMJ4hjYT276tuPHnbuD1YoOlBr1US878t0LLXG8sVFqO+/QK9juLb6vK/t6mqtE9x80xyuFnAHT7iKReQVMKbqaTPb+yyisxw79psyzYWJEwCS+MGVP70Z6UuP+03PGI14zXcYGO6HBVjLLFzAIX3BFuBK6p8nwhhxtCMRZ18LM8UQVZFDtENbpd6fN0uXusy8Ogp/z2SOVLJSBCE5qd1Rb7twqq2jf7oD58kJSbjN74D7gZNAyIgAQwJ+Mlq+xtTE8viGkD5yUo0n3XWDMVsIw0Fdo5l+JIjLqa4qnpDCTy7yEdkIjt2LyOgs2CToJdxDrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+qx4gyiLNNIbhQcsmIn679iRCXakkIc6BoQ3s6NQbbw=;
 b=wMvX+kYJCTOe0C+IEs7R0q9Hyh/8XdBDVAacwrZBEyvXT+S7EhcxB8f4tpRDtpVGpbFnNyClOBKidW9mleN+D9FwKeSNpw9q2pqIR9kk6DzK2Yve544Pn+qHm0j3j9mlYx2crrP9XSFLo5OICq0wIFiWVEIKYRzI2KZpsiP0mrw=
Received: from BL1PR12MB5158.namprd12.prod.outlook.com (2603:10b6:208:31c::11)
 by MN2PR12MB4063.namprd12.prod.outlook.com (2603:10b6:208:1dc::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.22; Wed, 12 Mar
 2025 05:28:46 +0000
Received: from BL1PR12MB5158.namprd12.prod.outlook.com
 ([fe80::b9ae:fa61:11ed:4e3b]) by BL1PR12MB5158.namprd12.prod.outlook.com
 ([fe80::b9ae:fa61:11ed:4e3b%3]) with mapi id 15.20.8511.026; Wed, 12 Mar 2025
 05:28:46 +0000
From: "Feng, Kenneth" <Kenneth.Feng@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH 1/6] drm/amdgpu/pm: add VCN activity for renoir
Thread-Topic: [PATCH 1/6] drm/amdgpu/pm: add VCN activity for renoir
Thread-Index: AQHbksaEoG6EZFZ5NU6A/gCYFUhy37Nu+YwA
Date: Wed, 12 Mar 2025 05:28:46 +0000
Message-ID: <BL1PR12MB51589AD949B3E78A58E9C6428ED02@BL1PR12MB5158.namprd12.prod.outlook.com>
References: <20250311204459.23864-1-alexander.deucher@amd.com>
In-Reply-To: <20250311204459.23864-1-alexander.deucher@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=6f321bf8-910f-4b93-af1f-80dbc83464f7;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-03-12T05:28:13Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5158:EE_|MN2PR12MB4063:EE_
x-ms-office365-filtering-correlation-id: 45a9fa1c-5ae2-4ccf-8e31-08dd6126c305
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?r6pSHHjviqlI/8AplvBtk3nN/9o3bYwksxofzWHuu4PGZPeTenJ04gmGu0ha?=
 =?us-ascii?Q?EO9v5+x3Qlj3P8iNubMhLwpRTKyRcMs6iFslQEPQfMoxxd1x9Je51lS/6TUp?=
 =?us-ascii?Q?AvS9SqMJZ3MQakeixmvhGbF818G3aGgogHdOQJnarWFmTUYsHcasByJ+pebg?=
 =?us-ascii?Q?yzC3+8awj8i7r+7eLPE5M4Cq81u95vcQc+a5YxPyoKwZcgIr0TEWGdNKtsch?=
 =?us-ascii?Q?ipdCzCIXBon4X2eI7MMiF0UK4Dx132G5aCgGUb9DECQ2q3G1gOrBHiglo8U4?=
 =?us-ascii?Q?B5xkKByla80PlcqKwbNch4K6kplDA+raB6bxX4vUES50y0F8eSOeBk9vNKlk?=
 =?us-ascii?Q?0ZYE5mNiMNdgj6ezHCWo4sM1sHAQuf6mmG6xD+zgHzinycD611fIXFhcc3Ae?=
 =?us-ascii?Q?J06SOJuULBpEx+VI21xs1x/+CAQ7l0LE5XP1YXlSbSeUoUif2ybM/fucNfxM?=
 =?us-ascii?Q?j7TH8TIOHZAVg1WhF+jg/f80SmkiIQ8f8RVVgtunptDlQ+s3fLFQoH4ICRTE?=
 =?us-ascii?Q?4VzSVvsaugkEQQxDrAlVOfzHyz1TsGMKdsPlyStndvKVT5Mx0IN5c4S7hht1?=
 =?us-ascii?Q?2CEO8amMCdMNHzEwmowk/BI5cNv80xuCHtqepwEuR+6BKgT8rJRpl94Tw91y?=
 =?us-ascii?Q?WJR6JamwWgEMwJWqW6ZnfaF/aMjT/TnPBFHooIyz2TeMewSX/no1Fq3Te3AQ?=
 =?us-ascii?Q?QPLIA55Qjh+1gjKCBBM9RIs9GQ8xR5aZdTyoK7uYXeWFY8zZYnO4po0WV1Kc?=
 =?us-ascii?Q?oplvXELKAIavIOH3i99mX6pTfFlbjuxurgPA7cDYDHscBL51JeUzfxw8+qI6?=
 =?us-ascii?Q?mFGsAAuaoBXGt3mXPTN/lUhe9j2piQDUnWI2OsxXzM2JJ0p+Z2rLGwtDCyzA?=
 =?us-ascii?Q?LNH3c6mtg8Q5QsQ0+vzuh01H5EuOweQPNPrUZmECKAwrSw9YBtrD91nGHeRO?=
 =?us-ascii?Q?+9At0r/t8lfg1p2VsMRkXBmAJGSK2rK025wAT3lI29RdwrLkGRCNM5hv6BMz?=
 =?us-ascii?Q?vkOIgzMwdbec5tHtj2N8HGrOx20lMjzHUkREv3PS8pceCQxWDNPvFFms03Qm?=
 =?us-ascii?Q?TRZdm0UeTMVEZb2krk6QRgLAIhX2uR20T+Ig/GL12/22Rj2ruYJZKbgSkuZN?=
 =?us-ascii?Q?JbkaPJ2DBVndJczN4BCoo5SU+wRgWmjD0wV5GdxISDpv1unzqjjZ4th6HGtB?=
 =?us-ascii?Q?pslsL5Vrnyl+inrJiGc6TWNYX2ESt3/O3PEgH35oil7n5cZHzR2JXj+t6MFJ?=
 =?us-ascii?Q?495dyaapNP8L0qXraQWfYV+mbBqei4H8uynOzXaSE0O4xt9dOE1OtuXpRZmY?=
 =?us-ascii?Q?yvOyfXso4oUl7n31JwIADw5ZEWOd6VuCjaPd3SeBTZuQ2RuK3aIYJVeSbUQu?=
 =?us-ascii?Q?yMhdOk901RV1U/4wcU63RR4hN05MjoonzckMfrugnZG6i8OeHap/fD6cWXDS?=
 =?us-ascii?Q?UMWrLlgHxDaHkktfcBSCEaNGxaa0L2Ww?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5158.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?pNj2wEb4pK3zgUwUfcBcPworT8xhPvDcChkJ2Z1uImz0oLON0QxKZQ9cJMlp?=
 =?us-ascii?Q?w+5+3nV0Knqm/kwQ7YZ02waQztSCvQBcSIWcV+s34NWMn2+97mTqn6myQiSU?=
 =?us-ascii?Q?/EwYx83X2KPZGjQzzJjFuZzyiKFyyHOj0jUZhHP+yLcdW4G5x+vmOvquNIZA?=
 =?us-ascii?Q?xOCHmBKHKcAXFTMmNl/cv/QNqjjWDOnP9rUmilTVIROvHV9C6c1FEQWey0UB?=
 =?us-ascii?Q?TvIi41L3vdM2OkiTXdmqKCpLTzRbR5zmmDYmo1BJQzM3a9xc6MueIfmKnc9r?=
 =?us-ascii?Q?qrAqFVA6PWvVBTmSEDOpAxblTPuzUDRdvIVH1xgVtA7P9KG11SHaJRSb5v3B?=
 =?us-ascii?Q?jxLkJDpKYdeD6pe5oeAy4fQK3EyI6YpmWaoOF1oKPl+BVEpevV0OLo9XaDTH?=
 =?us-ascii?Q?mu05HYzj1UIHn3i9Mv5+bQTuQMAV21iksDBzRIHelD2BslYVeO6Q67ovK4ka?=
 =?us-ascii?Q?0yyX/zwADxWPDDcnqz9uM4HUQAKC7X2vWG1jpRVA3CSV4jjXE8R0trGEZDxz?=
 =?us-ascii?Q?Dj0oDc+44rT8amQl94aprtj49zPfWH302D513+kB13kK+EK6Q1rw8RBb7pOw?=
 =?us-ascii?Q?xzuiuWpUfjAiXUzD357W52rLcPHcCbrUmZns/Thzu8NuQ8mDBfvjlrsySzvO?=
 =?us-ascii?Q?twXA+ptG4hB0TeSvOc6DcToHgbRmEX5hmQaapEm+tha2x9ntaWR/KoZwC5fO?=
 =?us-ascii?Q?1L0tsXL8SIaPjscc5lmVF6igUVbv+ExVC6nOx2XmHybaVe6VdJwv+/mL3GMO?=
 =?us-ascii?Q?PSjc/LgUvqLWI8+pfjXCq2d58SB2lbPGUtJy07Bk8DkRF/ulq8xz3Tkuj8NV?=
 =?us-ascii?Q?SFfzZ0swErXQsPcEX9sL2xrS6tEyNwzn/dCD94v6lpMugTeDpVRQMY1NnKNB?=
 =?us-ascii?Q?Cj8Lsm45AUO1g/ytOao/aGEtPjLgb8O5yWdKBwnlIqtTCRfo9YPcS/PNCTC4?=
 =?us-ascii?Q?ZzQd97CxH1lU4fUfg/sMnk852fRZUJlqEpNELOMYIRsLa5ZQbD7B6WHiVAdg?=
 =?us-ascii?Q?LgnGwHNnvpcbVvb/zHWM/8dpfcnSJN/YjtNqYqmhKnQNPitA2EMy0BQJT3SX?=
 =?us-ascii?Q?uoSlljIxi8QOsr9jKXYVozmgepp0P+OH7x7KXucT5fPbTGPTZpPMzoo7LtpP?=
 =?us-ascii?Q?MvyFWW6ghhyFExziKVmPuY/5h/myIm7uBwvyTLBecLeuXWfi1daOVD08owD+?=
 =?us-ascii?Q?lg17QBlJWDe1bNb7LGe/28BesmgBtplKvUYJAlkvHscRTmOOoUOt9YHinUkI?=
 =?us-ascii?Q?Yp/mPW+1RViyOoqLRpHgbX4T+F+T8gHrYw9ByJFaJt7OAPm75K0myb3J5ibn?=
 =?us-ascii?Q?uu17MIjlqBPRQK12LPnAM8J0TbtzmQySkU0QsNcETZtG+GSED3Rnzq2OcEhQ?=
 =?us-ascii?Q?AIRWh8YComqbPiXwiRgZdZT6yDLX3yOgR3QQQNALyKSdC1MWxpKY9n9sAQX+?=
 =?us-ascii?Q?RSeyj1BoI3M1DzWbJrsuwx7ex1Qao94u46YyUgFJOSyJISuR5blBYS88IjoL?=
 =?us-ascii?Q?pjY3QnIaD7Xd3lOtoLivjQPU6gWvySLm/+FeWCEVgUVHiBprYIyLFN8BWKPB?=
 =?us-ascii?Q?Z3CMu83nrgrQpusDGvw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5158.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45a9fa1c-5ae2-4ccf-8e31-08dd6126c305
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2025 05:28:46.4758 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8ImnemUPAFKlBN0I4eKuV9zM+TEjoJnUO6soyTDy8phwSPDiAgHtqGQ5/y2Il+2I
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4063
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

Series is Reviewed-by: Kenneth Feng <kenneth.feng@amd.com>


-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex Deu=
cher
Sent: Wednesday, March 12, 2025 4:45 AM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: [PATCH 1/6] drm/amdgpu/pm: add VCN activity for renoir

Caution: This message originated from an External Source. Use proper cautio=
n when opening attachments, clicking links, or responding.


Wire up the query.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c b/drivers/gpu/=
drm/amd/pm/swsmu/smu12/renoir_ppt.c
index 37d82a71a2d7c..9481f897432d7 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
@@ -1285,6 +1285,12 @@ static int renoir_read_sensor(struct smu_context *sm=
u,
                                                  (uint32_t *)data);
                *size =3D 4;
                break;
+       case AMDGPU_PP_SENSOR_VCN_LOAD:
+               ret =3D renoir_get_smu_metrics_data(smu,
+                                                 METRICS_AVERAGE_VCNACTIVI=
TY,
+                                                 (uint32_t *)data);
+               *size =3D 4;
+               break;
        case AMDGPU_PP_SENSOR_EDGE_TEMP:
                ret =3D renoir_get_smu_metrics_data(smu,
                                                  METRICS_TEMPERATURE_EDGE,
--
2.48.1

