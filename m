Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9750DE6749A
	for <amd-gfx@archiver.kernel.org>; Fri,  1 Nov 2024 04:25:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1DCF610E088;
	Fri,  1 Nov 2024 04:25:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2KfFP92L";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2047.outbound.protection.outlook.com [40.107.95.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2A96910E088
 for <amd-gfx@lists.freedesktop.org>; Fri,  1 Nov 2024 04:25:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HmUSl8hM8ElKHk5G0fye0SaA5AsoKhBl0aoIRX+iVKQ75pocuU/FRnIevxQyQ08o4mrdf9NxrdfCR5icBo4tCbefqgl5v64sYY/yEjw84rc9odg5Cn7N6ltn8PfnMHcpd1NFNE+ggjNfT1Ylg8bNxiHTm2jwqAoz73KhndMzkoiQGebp5cGvBDc1QU3oBP+UNCeSXv1yAQqWG9s/dF3FetzFT7VRbLAoxD2oLno9ShYV7hNLx1Oe+5OzTKxjZdWnUoj2u1qGCsTZtIy7B7r4zWRLS3GxELQS0aNvdkFV25DnFpkx8mHpL590OUGoFpKetq1Q5k5vGD3YC4TDuBqH5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S2gpe1TpnBWEBRuKo+Oz0fH1/ZN7o3k1/vi+oKZN8V0=;
 b=QtjbI885EnL85dRyulaMfu9HJCJP4yv3Kbo2RP05brRUPVdOboz5gMUxRVRq2qphDE9YDtIFe5Tu/s0+t7OlFwfAdKHx9ff54ixdhZjjQTRdLVyan5qmBj+SFcIaH5jeDV2gpV/Wq5BfOuY3jmdSfuIUGH7vQn47BmAPIdgtgwi2JEZjlgT1QIqdbapy2tjNTx/9SZl3GFEgIsnMvI+Zg390jHv67V9NpK9OoHbePcQxEAUTaABU0frS2VaZMnci+vzgRm06uoXcmaWfEEN2nEIwfgQORZtGIm8yOiOJ2L9yfKCYF/getIiN4NQ0pd9AA25kk4v2qz8B7yzMaGgB1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S2gpe1TpnBWEBRuKo+Oz0fH1/ZN7o3k1/vi+oKZN8V0=;
 b=2KfFP92Lka0k6ClAKYb9PDuWGbhiQM1K1S16vWtX73aJkGgFUrr6seEmy1Oymu4CUTB54ZDFyFI9j3f6eABuLKUHIZckuKWKxyBQ8jUUmKBJc0/JeDlpEnFL2DuXaqNlRZze07Y5b3ObJ2XhjWgK9ULUjNkrlprgg1dHaTcIIcg=
Received: from PH7PR12MB5997.namprd12.prod.outlook.com (2603:10b6:510:1d9::21)
 by CH3PR12MB8726.namprd12.prod.outlook.com (2603:10b6:610:17b::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.20; Fri, 1 Nov
 2024 04:25:47 +0000
Received: from PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::c5da:9b53:9d77:c708]) by PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::c5da:9b53:9d77:c708%5]) with mapi id 15.20.8093.027; Fri, 1 Nov 2024
 04:25:47 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: "Feng, Kenneth" <Kenneth.Feng@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Feng, Kenneth" <Kenneth.Feng@amd.com>
Subject: RE: [PATCH] drm/amd/pm: always pick the pptable from IFWI
Thread-Topic: [PATCH] drm/amd/pm: always pick the pptable from IFWI
Thread-Index: AQHbLBIld514GrEUOUys1SY5/DtlmrKhzugA
Date: Fri, 1 Nov 2024 04:25:47 +0000
Message-ID: <PH7PR12MB5997D0E3DE5B4A2546DD15D882562@PH7PR12MB5997.namprd12.prod.outlook.com>
References: <20241101035701.86175-1-kenneth.feng@amd.com>
In-Reply-To: <20241101035701.86175-1-kenneth.feng@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=1c76c8d4-3ebc-4803-9bd6-6c9489844103;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-11-01T04:07:11Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB5997:EE_|CH3PR12MB8726:EE_
x-ms-office365-filtering-correlation-id: dd5b6ee8-d7e3-4192-5887-08dcfa2d4239
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?rh/U4wOHHNOCb4+p/IEmI/sZI0bOu0k5d0LCXgr2HTotnyer/KR2lCN22s4+?=
 =?us-ascii?Q?X34df+4kCaHhHfRb8AQHIgFZMHFq6R7lAfss6mDE/KoXFs8kTmwX2oXzht6B?=
 =?us-ascii?Q?jViGTgENx2G3417ZAtt4215kHTZ20dITl7JVMXEaBcjtz6b2/XYTzaaZtEqS?=
 =?us-ascii?Q?7MId7sQ6EkVeyH0Uafc9Jdkagq7BMRvxQcHT7E/YPcA+ILWQ/CkZsuatYEct?=
 =?us-ascii?Q?53+VDR4atsWDsLtriYQMxI1lS1HBXOJ+3nlmorOB9HINFVrsUFGq1bCG/CWF?=
 =?us-ascii?Q?xQofm+I+PZNmlm/9T3sU8/nhjlffGrP1jnnG9EPLX6CtBc9kw4R+cSHw+b0v?=
 =?us-ascii?Q?GvtFy86PrGUEtllDmIb7FstcGWjOslDLmTNCo+IDCvgW4GoJ3f+w7e9qjkd2?=
 =?us-ascii?Q?02y+n0MMWpaVnJm/lNTvkXCeR4ZC1RlFioZMk2Jlhh/FxIc3DgMj926+5rUt?=
 =?us-ascii?Q?knHVobtBVZYo9jPExI3NAI4nlLlUXI6e/oMwXiftxU6ohck0rrvx3hdRHiaM?=
 =?us-ascii?Q?aXPLHtHZ7CgyeNBUQVrlK8VlEfzz+4BXFtJ8uIWfqGaktc+rpzHB4bfI0ZKb?=
 =?us-ascii?Q?qzwLO8+dwY8of0ytkTMD00t4N/x2PheLm9pbsRhFNA7FE1Qupm0EqrUfhY5R?=
 =?us-ascii?Q?1FYFCQR1ZrRiGOu+vRlCkFvaQQMWLaUSromeWMo4VzDGml6OIrWWNT7K15HN?=
 =?us-ascii?Q?r1oEmPHW+gexU2snSODYxoo9pYCQNhwNO+zi09L3yMGYVocLtLrTfgjwobFr?=
 =?us-ascii?Q?tT+dG/u8iK0wzMDEbOWPURZ4tqZoadU/r1nA2i1SdsTmXzVDwwHbP1ezUhPH?=
 =?us-ascii?Q?Gw/JPwQf0LW/vB9Dg/BFKawxLCfeHIgaoyxwTQhNHRirD6FXcG+KePbbV/TU?=
 =?us-ascii?Q?38mmN9ZKR+2lbmhRlsVwla0eK/k3h5Ke0diDSJsXVskqXwMU23ov7OYF6X2B?=
 =?us-ascii?Q?9lmErpxk3rwLE9ZySMPDsRq/NRwsFbl8Lbp/AecDDDdnZve6Z8AUBhYC6j3V?=
 =?us-ascii?Q?+iNcHkPxsuI3k8bW8dxs0jmDYM2J2ZBS7v0Nm2lnjy0e8jmZinzFlVMpVEjn?=
 =?us-ascii?Q?VLbOco2ohpW9D9Wfr+d4nrKgDEbnc/iVjRRx49g6VRmWXAwa4wMUX1vlWGzW?=
 =?us-ascii?Q?XlLvSYAaR69OGRoHqkAQOLMRdpYPPlnpdKLCBqWszloHqfT05/RxU+jxM3hD?=
 =?us-ascii?Q?9azC0nylx1FvkxEc1hJ2YaiohlhJinL0EFxu2q49xUBXw2vxlM7Pw3DNBH/X?=
 =?us-ascii?Q?rIO9Kyhp2EBOE9rX8H95J7vDpTk4UMO4rm8lQLp5sDUoRtsOjI3xz/q9TAWB?=
 =?us-ascii?Q?VwTi7qzKbhHMQFnEgzuCAg4C13yEOL3mxviKWGud+fEWQdk7yotA70SMoSRC?=
 =?us-ascii?Q?W8Um84Y=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5997.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?weha7knrYnfw2k/QcIUjD2SkU1rk3I7iiyLA+b9Q34vUJX4pe2ERcNHNSf5D?=
 =?us-ascii?Q?wXvLTN2P5ESobHJB3rvZp1LtAQiDDcHihV+7Lz8Na7u4IC3HSuNfE6ZL5zAG?=
 =?us-ascii?Q?IVbCnmmpVUx4Zsmu/0Xu34mW/t/zQDxSfn5dzIxuoEu+YH629EHTQ2vWMR4x?=
 =?us-ascii?Q?pmYyzfZtW5gKxc+0yeNxd3GupvEGGGVvI1gi7mcCci+J5d7MTo4cBEYgfAHV?=
 =?us-ascii?Q?OiTsOB05qUd/IfezpLVo9HlBtoHpNkNd4hmgwYKuqk5wI0WKcitYlvVsBZGY?=
 =?us-ascii?Q?4Z4WP3otC4ZYVM4ws0J/3nScu3tZszSrrCfriPwwqeqF0RtfH8WrppAq8bsz?=
 =?us-ascii?Q?8c56EcKbq32fIIYFTL0/bZ2hA+MlBv/2uyS2nzjVzM3/isnfaVlpwBVOKtGO?=
 =?us-ascii?Q?tHB0yxAkA7iAvbGHN8bp8B6AXAngi6wVqn14hvwBaXMwIUcy2GrU62o7fcDD?=
 =?us-ascii?Q?1DFlD5FaDSsbajo9aZHGouEXjFnZrszgEzkuEg1upCl3fosBKymMclRe8f/3?=
 =?us-ascii?Q?vo4vHjpE07DNMzAK4rtpKpN2Sx2QYTO6gTllEmXpO5dS29EBw4/CiKMOqlh2?=
 =?us-ascii?Q?matA7JJloaAP3375xENNPEsC3coXp8PkGoMUMT6MdUe4OXc0+xzJtJSlMONH?=
 =?us-ascii?Q?Rmmq5VuoWiyrfyFX2H9dHMVpMG8g99gnKDur7zH3Km7sCOsIGbKufMsxCyMB?=
 =?us-ascii?Q?6+gsJVmFBqAQueqf5mLFbhh7Dhb884Jl9CLO/nexqXIeGTtWODaf12ufVqhg?=
 =?us-ascii?Q?zDfQgiPHYjz8Cqz6vMZuHx5FgviHanVv9WVkgnohAGYmAPQUB/BRFfs9D/rw?=
 =?us-ascii?Q?KequjlO0UDlq+9672d6JvpifrBx3rKzoVU3hS3DHraXRQKbUrfqDk0gqXl+9?=
 =?us-ascii?Q?9IuLJuWuPBxXU540iU1hT0sOMTF8uIBZk4ds3OwoqKkGaEis39RUh4fCKOkw?=
 =?us-ascii?Q?ifQGoZBA9WNorEvWUwcQWjLEzQEmjo/fbTYf4MtQBfzK16v8Wzhbfkwf+ssY?=
 =?us-ascii?Q?6A1FH1xvtTFb5i/kN1O98wg14NIEBTb/hw+zlDwHpEJukJI3oAjme5wo/hYi?=
 =?us-ascii?Q?f8J56wRJspzQzapDwQscHWaw8YiMOkjqOMo7hVqeVDdO0qLjTK5Qy2Ayvoyn?=
 =?us-ascii?Q?tlEoFnb6fdiTVf8z3Ybj1gbFFtNA/AecUM6P5ZmNc0Ng12VlUTxGDnX9Bz+R?=
 =?us-ascii?Q?0/TH70dyPS9SNp3Jz+S/mNK3TW40HAlt9UXnAXkD5GlFIkcUTOZPgiGNF2bF?=
 =?us-ascii?Q?TXQOtHeI8a4HQ7NblQ5wRTFTHjWu6VLPhooYDHCYkQ/FCtj7oOC12fdkXacI?=
 =?us-ascii?Q?53HXzFFxwwlcKbVwp9xZHs5yk9WftV7eSgJ1Gbj5Lfrp3vDklJdnrEC4E+ko?=
 =?us-ascii?Q?/m7nSjGUIuEvqNbRiOPclgQF6CyHpvjfzCsdlslsUmhbzp0dZc1l+/bxiEu9?=
 =?us-ascii?Q?q7QE5wtDlKGDSQFtHBkXm9fZGthrFd66al7kMuG/lgJ+APvDfE3WUmq/q15y?=
 =?us-ascii?Q?3q35UzrmSh4RPdCqUhLh4Zq5XSC9rkA8K/jWW16VMBbDRPkvgS/2TYDun41U?=
 =?us-ascii?Q?KJ68IpqgACLm4dIaGqk=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5997.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd5b6ee8-d7e3-4192-5887-08dcfa2d4239
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Nov 2024 04:25:47.0791 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nliIrXJP5fsCm68+Q6Kitm3HrOBnU8VqBoCCP7q/p4xF6Tjw6hl20j96NJDUkG4a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8726
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

I suppose there is no backward compatibility issue with this patch.

Reviewed-by: Yang Wang <kevinyang.wang@amd.com>

Best Regards,
Kevin

-----Original Message-----
From: Kenneth Feng <kenneth.feng@amd.com>
Sent: Friday, November 1, 2024 11:57 AM
To: amd-gfx@lists.freedesktop.org
Cc: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>; Feng, Kenneth <Kenneth.Feng=
@amd.com>
Subject: [PATCH] drm/amd/pm: always pick the pptable from IFWI

always pick the pptable from IFWI on smu v14.0.2/3

Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
---
 .../drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c  | 65 +------------------
 1 file changed, 1 insertion(+), 64 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
index e8ef6aa1d664..59b369eff30f 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
@@ -367,54 +367,6 @@ static int smu_v14_0_2_store_powerplay_table(struct sm=
u_context *smu)
        return 0;
 }

-#ifndef atom_smc_dpm_info_table_14_0_0
-struct atom_smc_dpm_info_table_14_0_0 {
-       struct atom_common_table_header table_header;
-       BoardTable_t BoardTable;
-};
-#endif
-
-static int smu_v14_0_2_append_powerplay_table(struct smu_context *smu) -{
-       struct smu_table_context *table_context =3D &smu->smu_table;
-       PPTable_t *smc_pptable =3D table_context->driver_pptable;
-       struct atom_smc_dpm_info_table_14_0_0 *smc_dpm_table;
-       BoardTable_t *BoardTable =3D &smc_pptable->BoardTable;
-       int index, ret;
-
-       index =3D get_index_into_master_table(atom_master_list_of_data_tabl=
es_v2_1,
-                                           smc_dpm_info);
-
-       ret =3D amdgpu_atombios_get_data_table(smu->adev, index, NULL, NULL=
, NULL,
-                                            (uint8_t **)&smc_dpm_table);
-       if (ret)
-               return ret;
-
-       memcpy(BoardTable, &smc_dpm_table->BoardTable, sizeof(BoardTable_t)=
);
-
-       return 0;
-}
-
-#if 0
-static int smu_v14_0_2_get_pptable_from_pmfw(struct smu_context *smu,
-                                            void **table,
-                                            uint32_t *size)
-{
-       struct smu_table_context *smu_table =3D &smu->smu_table;
-       void *combo_pptable =3D smu_table->combo_pptable;
-       int ret =3D 0;
-
-       ret =3D smu_cmn_get_combo_pptable(smu);
-       if (ret)
-               return ret;
-
-       *table =3D combo_pptable;
-       *size =3D sizeof(struct smu_14_0_powerplay_table);
-
-       return 0;
-}
-#endif
-
 static int smu_v14_0_2_get_pptable_from_pmfw(struct smu_context *smu,
                                             void **table,
                                             uint32_t *size)
@@ -436,16 +388,12 @@ static int smu_v14_0_2_get_pptable_from_pmfw(struct s=
mu_context *smu,  static int smu_v14_0_2_setup_pptable(struct smu_context *=
smu)  {
        struct smu_table_context *smu_table =3D &smu->smu_table;
-       struct amdgpu_device *adev =3D smu->adev;
        int ret =3D 0;

        if (amdgpu_sriov_vf(smu->adev))
                return 0;

-       if (!adev->scpm_enabled)
-               ret =3D smu_v14_0_setup_pptable(smu);
-       else
-               ret =3D smu_v14_0_2_get_pptable_from_pmfw(smu,
+       ret =3D smu_v14_0_2_get_pptable_from_pmfw(smu,
                                                        &smu_table->power_p=
lay_table,
                                                        &smu_table->power_p=
lay_table_size);
        if (ret)
@@ -455,16 +403,6 @@ static int smu_v14_0_2_setup_pptable(struct smu_contex=
t *smu)
        if (ret)
                return ret;

-       /*
-        * With SCPM enabled, the operation below will be handled
-        * by PSP. Driver involvment is unnecessary and useless.
-        */
-       if (!adev->scpm_enabled) {
-               ret =3D smu_v14_0_2_append_powerplay_table(smu);
-               if (ret)
-                       return ret;
-       }
-
        ret =3D smu_v14_0_2_check_powerplay_table(smu);
        if (ret)
                return ret;
@@ -2785,7 +2723,6 @@ static const struct pptable_funcs smu_v14_0_2_ppt_fun=
cs =3D {
        .check_fw_status =3D smu_v14_0_check_fw_status,
        .setup_pptable =3D smu_v14_0_2_setup_pptable,
        .check_fw_version =3D smu_v14_0_check_fw_version,
-       .write_pptable =3D smu_cmn_write_pptable,
        .set_driver_table_location =3D smu_v14_0_set_driver_table_location,
        .system_features_control =3D smu_v14_0_system_features_control,
        .set_allowed_mask =3D smu_v14_0_set_allowed_mask,
--
2.34.1

