Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C046EC2D0CD
	for <amd-gfx@archiver.kernel.org>; Mon, 19 May 2025 12:19:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3096B10E198;
	Mon, 19 May 2025 12:19:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="tKSxlEzb";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2073.outbound.protection.outlook.com [40.107.223.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C055610E1B0
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 May 2025 12:19:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QO9tnDUgTJLcw5XwAYL8R8tpKjWElY8+9fIoLD0yBGFMTQAlobNYXQvYewGj0mkjrv73E0KDCAJ3ANpx/31IQR1rNXT1phESwXQS8hJRlvq3SuRMr7ABL2Bg6W2TWZByQy62JZYmpiELmHdnMA9lE1iyhob3RBc7yQI6lhhzQxhicAPN9OTkFcdTEwxrzys/FJq43QCXdQRDEq7wD+DfVy6+/5zHZ7c87MR/QUSRBf7Szvz4JM6NizUAYI5rTD8R65lb0JAuRoz3xIlrV6IQVUkBFqKeC2YmswvsxLNRHPF2swAVfzasBm2cvMbz6zWgv1RCf8uQUS3kxGdwZP0/9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CajkyOH6t2JeYHeY9zyXpnmmQyEj8RF11vmnc1yx4fw=;
 b=L3WV1k5wu7C7W1E0oQp52YNbAAygNelQ6WdLsASCFloJH0HGFIUWNZzHSjo0h6edNNxVKLWYCn2c6vCAo84nHu8Xs7PQxkorG+QXyregmQbMVkQyFMnsBI+Y/49yVuzF7BmP/V3ihErF6i7syjUVSw4Mm8ALA/xcu9cL5h9eyKgHWbyKcTGIvncBM8uvJwtZu0XxtYsS1tNGOCvVHuXVKoHHdjV+b1P4LNpTa+Z3ORcF2DshZRoQlrLWrZDVirCSG4SAAhaCckGWr5S+cOCFeVfXiG9w4ZmrOQneRL62i5vhmywuuHBKvhp/xB/gKFt5EtZTfT8Kd6+S8ds282Ndfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CajkyOH6t2JeYHeY9zyXpnmmQyEj8RF11vmnc1yx4fw=;
 b=tKSxlEzbN39P+GzuS1by10DxxVNBFzHy7WsRbgNnU4Wy4oTruPs7YSbNbFhWbHnrWGl1jcv/N62x/WoKrLvxdL7AoYuiu/v4vcthVD+jUGUiFrEP97tn3XeHOqcTyzvUGN4kkxizhndC41aMH2IC/VWsK4XFN4k6Qo8xdlypMDQ=
Received: from PH7PR12MB5997.namprd12.prod.outlook.com (2603:10b6:510:1d9::21)
 by CH2PR12MB9543.namprd12.prod.outlook.com (2603:10b6:610:27f::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Mon, 19 May
 2025 12:19:42 +0000
Received: from PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::c5da:9b53:9d77:c708]) by PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::c5da:9b53:9d77:c708%2]) with mapi id 15.20.8746.030; Mon, 19 May 2025
 12:19:42 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Kamal, Asad" <Asad.Kamal@amd.com>
Subject: RE: [PATCH] drm/amd/pm: Use external link order for xgmi data
Thread-Topic: [PATCH] drm/amd/pm: Use external link order for xgmi data
Thread-Index: AQHbyK2EDynXqOBuK0azWJxShtpmBbPZ3hqg
Date: Mon, 19 May 2025 12:19:42 +0000
Message-ID: <PH7PR12MB5997604F13E4AC3D03170F2B829CA@PH7PR12MB5997.namprd12.prod.outlook.com>
References: <20250519110151.507729-1-lijo.lazar@amd.com>
In-Reply-To: <20250519110151.507729-1-lijo.lazar@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=572449bb-da40-4390-bb53-0d9def5679f6;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-05-19T12:15:37Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB5997:EE_|CH2PR12MB9543:EE_
x-ms-office365-filtering-correlation-id: 48fa680b-89d2-4157-76a5-08dd96cf6f1f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?obcIvuEMpwe0pNW+mddXu7JB5dFEpDK9pcPcUSNw9Kh12U5dksbU0ICnkHJL?=
 =?us-ascii?Q?kVSPlXjGw/li5m3NsBI7HkhRLfM2i4IjudxtEK8unMAiKkajL/uhD+15LuMh?=
 =?us-ascii?Q?KvpGUIgWn0ApIUKhey1vtFtwph+j0HzCMgjBz0IdxTyYSrYKCT6Y9n0FYAp+?=
 =?us-ascii?Q?SZIoa578z1dc8n30hyCr89cTnZl7X/NB4NJLzoIRjJ1el+5NTYs7ZQ4lRVv8?=
 =?us-ascii?Q?dtY910eo6DNo6Eqa2ozateEzvCd7qZnZd4TXfLyrxkU6ka4NyCpEWl6OvIyU?=
 =?us-ascii?Q?jKl842fWY2bu9tXKZ2tPyfncpKx/yJOnKl6h8IGW1BEYumAKunDARdD1TNpD?=
 =?us-ascii?Q?QKsibyK1HuBxgAHoSZ/DvtXS0VtatVzozM5C4aWLrqoyPxORwonG8477k+6V?=
 =?us-ascii?Q?qGY8dkDXoK2h5IIr6ENjmZYoDON8ZjyfJHaHjQEGI4dWnygf5804zWJHYOsE?=
 =?us-ascii?Q?BqZJmJt8dz6qmFdFnHE8a4L1s8Sb/J9QkyVrUPvSCKd58GQAoEV/jzgAZp9y?=
 =?us-ascii?Q?ySbvxujOpIaOvuGKudY/P+x0Wvydm6yzCp6uBthEkcKhcpQXtxtmyE3cNrFF?=
 =?us-ascii?Q?Zw8N26DtZBCwrnrNhvWZjqPHO2zllOhj2GFKcaL2iVfpzmgBShy0agSZ4JSJ?=
 =?us-ascii?Q?E9qR3PZgjLaRVg1XvW3x3oTiINMI/0GKtlOosYaL9Ey0LobmacQuzRfduSkH?=
 =?us-ascii?Q?cLzA2xzgZEaqXjaOzq3x7L/CcRLpsApqU8f6WPPo9YecJUSsMs3XNnr2dRf2?=
 =?us-ascii?Q?H4r3aDjrpR5Q5cLRf7dl0YFfQZGXw6F+8QXGkBr5/lzT1a341ez3fTvcSX1y?=
 =?us-ascii?Q?DkzPtYdcUsrGL9jtRWFRWEi36tYPssP9qtpcGDLQDcMKLXfsODXANB6KjZpW?=
 =?us-ascii?Q?bwjyuuSvfqxKgNEfK2YEcWGmBQyxggM5EonEdIIb15WU/vQkUD4leKq63DDd?=
 =?us-ascii?Q?3fVBX6mUA8700l/gqPNXaJm1dRWduBY5vexuMdrzNvHRLJ1E929hvtxuQQPi?=
 =?us-ascii?Q?csiGXH0GQlUqgOqua2Wq7bWxlagwVErET2GD98S5S3q1XncmBkDueiG5seXi?=
 =?us-ascii?Q?YdVgkCey2oliWeR6XIZuUvg6SiAfMd2IzeztXVP7i9SxmxgvPgnqN3D4glEc?=
 =?us-ascii?Q?M9goSAiz4dbSZ7+X7+Psl+4vU5f715jiTOsDosDDgKuUwklVCoLGKN0MaLNf?=
 =?us-ascii?Q?pLXfTAHh7tmOIEPs/yM8bWyJTVtc+EB4z7kFiOvPHD/F4FFTmPPRPN+G6Vws?=
 =?us-ascii?Q?TIyjZZW9eARNWVsWpxe3kfYMQzPhWi/mr2M+30RwjPO6icrSuJqXUz0rj6Xr?=
 =?us-ascii?Q?zU4kMOswRWYO+xoXQkAtbrGrgt1yX2v4DakQlkgSmf7Odudi2153ffrFwvWh?=
 =?us-ascii?Q?dnAgPi8gGM2wK72q2NjT5sptkq8WbyhGSNbgVbuYsmedP2CaerJSs/+667es?=
 =?us-ascii?Q?MOcZBzZFEqlPJmYudiE3j0n55iqj5ktwu4hDpxD26TeAVwozO3uABHLS7cR9?=
 =?us-ascii?Q?qnWOXKqOOER6/Ao=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5997.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?SZBurGgf9TVfiD5KNNKIzSzyK6vxFmQirffacAhjTpPPdKd/k8u8IfPH25B0?=
 =?us-ascii?Q?blxFQq+GdUHn/UN11zH9MIufNHHPVoiSVutJwzaNbgoWQAH5+bH7pQuoyVo3?=
 =?us-ascii?Q?GqTmecHzIaUJ4Kxe7AJkuWbME90f03OgCNQCSxt1BzH2CJ1IWvXek3ZT4Yq7?=
 =?us-ascii?Q?Ta7lBJkTQGDYn3JflQMU6rploih6VvpB/GueiaS79OCrW4f+M5RSxa+k4eT3?=
 =?us-ascii?Q?lhlkfqY5BwyD6k8DMesJeL5czUsM5aXP6rC0J+HBlwLIyp7m2FqOsmp+iMjm?=
 =?us-ascii?Q?eJPxElAx4yrd4V292QuFEYkZ8cORKTHM5uOwRhbzi5Q2pYeOzG3oTemdwIgj?=
 =?us-ascii?Q?Bd/qwTqJECs1qC8V47SlNN8KUS+GJS1EmKaO+SiCn0j66tgYNiwytG+NdRxY?=
 =?us-ascii?Q?rXzgYlWTnnVIyQY+JMENpKTBDZ6fnufrcP0UYlGgICB9alPPORM+H9BTBBgv?=
 =?us-ascii?Q?FtEf313oL9ocWRcJa8Jy1W/hjadUrSomdcgkA0L595Va2AK9viw/WTFM5add?=
 =?us-ascii?Q?MEJ0tZpN/S0xRWq9Y7oZRS49c73ss3bRlFPzvZ/ZvXMOs2KhA0z8gfLxPShu?=
 =?us-ascii?Q?CVZVbxxcPm2l9xG0ikKoHnV58koC1BASEpGCHsZo5mwdfP9mFi1D903ZHQU+?=
 =?us-ascii?Q?8ZNNOM+KPgBIn6xWqJKJ4gfj7fy0AeFA2RsZLvHmepiw1giyUjKR6HAKyQdz?=
 =?us-ascii?Q?7903GwhUzsdEuGGEmUOLxiyZNWPYgcGEHTPsUGRXXBGOldPG6pkSbeTTnwGc?=
 =?us-ascii?Q?bndlfpq2Pp976YlVZKxkBHSN6OCxNi3ECZTPIDhsl+3qyTmTQfC56ChwSLUJ?=
 =?us-ascii?Q?VQ9TnR8AxRnXqiTQjEQDkv6jCHG93xsstAY8Qx1LybVmDXXzInPl7sMWWQb4?=
 =?us-ascii?Q?QuAiWAkd15T8dyREbKTwUDBtUs5a/VzVzgkPHDB04g6Qu5MRmFHKmV5XdwjI?=
 =?us-ascii?Q?nuBJbL9CYpBRnVQU0YiVNbChxIYSIyOey808dABnKvqBhcW5e3YwwLLEyVyn?=
 =?us-ascii?Q?NYYBjdZnU+UhNkl/FTzWWTyuHxOKPm83A/9s4a2ootD53pQORFkBbWFUmjS1?=
 =?us-ascii?Q?A3UCh21sxFH1gJOm3TwUSx+klszsVRyFn8V+fEBLo+9fMa1G3VEvmphOuW62?=
 =?us-ascii?Q?cLiDNs/WGrq82C66SyqvS5p6qS3O5FxKy6uqOcYs5cXC4I+Eoq4XUPNLW70h?=
 =?us-ascii?Q?c2L/zNUstSAA4Pi4qIep9ZoUk44W8bm2b/hlFkBmHPzMKilr4SBzcdqBhpEa?=
 =?us-ascii?Q?Ys0C8QBJym+EKFfrGyoyG2PuzhHYNW/+P+UW5wsibE9j1vIz8cTTxA70Azdy?=
 =?us-ascii?Q?nHhmaTbgQaZl6VYhO4QD6gZrkX2+vnhyKudp2wwQTaCfl1FPdCyaBq0c80kw?=
 =?us-ascii?Q?Fc8f30Ogo/OaglSsjt9xAYRjq51V+cTyOU11BNhf3fmBu7dPZ0I6eehleH67?=
 =?us-ascii?Q?ER8Lyfn5TnUKkPP+EucmsVaPHTqwMK2mxGmRoYJ7VwwzFcSEiqRjPsl3aqRd?=
 =?us-ascii?Q?T8pRkStVMyrf42xIOTumFPjvZjM1TvkaiyP6ptdeQNXAQWLt47Me6229Bau4?=
 =?us-ascii?Q?9JzH8c+N1Y/WL5gr1e4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5997.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48fa680b-89d2-4157-76a5-08dd96cf6f1f
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 May 2025 12:19:42.2720 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: poKNOil3g2igejioIIPrmdzquz1xpnT0fe+X6BaKs1KILOsrVrTHKxzFX6QJeKYv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB9543
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

"-1" is meaningless, it is recommended to use -EINVAL or -EOPNOTSUPP.

Acked-by: Yang Wang <kevinyang.wang@amd.com>

Best Regards,
Kevin

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Lijo Laz=
ar
Sent: Monday, May 19, 2025 19:02
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>; Kamal, Asad <Asad.Kamal@amd.com>
Subject: [PATCH] drm/amd/pm: Use external link order for xgmi data

xgmi_port_num interface reports external link number for port number. To be=
 consistent, use the external link number for reporting other XGMI link dat=
a also.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c        | 17 +++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h        |  1 +
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c   |  9 ++++++---
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c    | 13 ++++++++-----
 4 files changed, 32 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_xgmi.c
index f51ef4cf16e0..b3006ca7fd28 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
@@ -294,6 +294,23 @@ static const struct amdgpu_pcs_ras_field xgmi3x16_pcs_=
ras_fields[] =3D {
         SOC15_REG_FIELD(PCS_XGMI3X16_PCS_ERROR_STATUS, RxCMDPktErr)},  };

+int amdgpu_xgmi_get_ext_link(struct amdgpu_device *adev, int link_num)
+{
+       int link_map_6_4_x[8] =3D { 0, 3, 1, 2, 7, 6, 4, 5 };
+
+       switch (amdgpu_ip_version(adev, XGMI_HWIP, 0)) {
+       case IP_VERSION(6, 4, 0):
+       case IP_VERSION(6, 4, 1):
+               if (link_num < ARRAY_SIZE(link_map_6_4_x))
+                       return link_map_6_4_x[link_num];
+               break;
+       default:
+               return -1;
+       }
+
+       return -1;
+}
+
 static u32 xgmi_v6_4_get_link_status(struct amdgpu_device *adev, int globa=
l_link_num)  {
        const u32 smn_xgmi_6_4_pcs_state_hist1[2] =3D { 0x11a00070, 0x11b00=
070 }; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h b/drivers/gpu/=
drm/amd/amdgpu/amdgpu_xgmi.h
index 32dabba4062f..f994be985f42 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h
@@ -125,6 +125,7 @@ int amdgpu_xgmi_request_nps_change(struct amdgpu_device=
 *adev,
                                   int req_nps_mode);
 int amdgpu_get_xgmi_link_status(struct amdgpu_device *adev,
                                int global_link_num);
+int amdgpu_xgmi_get_ext_link(struct amdgpu_device *adev, int link_num);

 void amdgpu_xgmi_early_init(struct amdgpu_device *adev);  uint32_t amdgpu_=
xgmi_get_max_bandwidth(struct amdgpu_device *adev); diff --git a/drivers/gp=
u/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/=
smu13/smu_v13_0_12_ppt.c
index ac172b21f803..69f92bd35bf2 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
@@ -472,13 +472,16 @@ ssize_t smu_v13_0_12_get_gpu_metrics(struct smu_conte=
xt *smu, void **table)
        gpu_metrics->mem_activity_acc =3D SMUQ10_ROUND(metrics->DramBandwid=
thUtilizationAcc);

        for (i =3D 0; i < NUM_XGMI_LINKS; i++) {
-               gpu_metrics->xgmi_read_data_acc[i] =3D
+               j =3D amdgpu_xgmi_get_ext_link(adev, i);
+               if (j < 0 || j >=3D NUM_XGMI_LINKS)
+                       continue;
+               gpu_metrics->xgmi_read_data_acc[j] =3D
                        SMUQ10_ROUND(metrics->XgmiReadDataSizeAcc[i]);
-               gpu_metrics->xgmi_write_data_acc[i] =3D
+               gpu_metrics->xgmi_write_data_acc[j] =3D
                        SMUQ10_ROUND(metrics->XgmiWriteDataSizeAcc[i]);
                ret =3D amdgpu_get_xgmi_link_status(adev, i);
                if (ret >=3D 0)
-                       gpu_metrics->xgmi_link_status[i] =3D ret;
+                       gpu_metrics->xgmi_link_status[j] =3D ret;
        }

        gpu_metrics->num_partition =3D adev->xcp_mgr->num_xcps; diff --git =
a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/am=
d/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 645c2bff3e5f..179b1b16edd1 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -2819,13 +2819,16 @@ static ssize_t smu_v13_0_6_get_gpu_metrics(struct s=
mu_context *smu, void **table
                SMUQ10_ROUND(GET_METRIC_FIELD(DramBandwidthUtilizationAcc, =
version));

        for (i =3D 0; i < NUM_XGMI_LINKS; i++) {
-               gpu_metrics->xgmi_read_data_acc[i] =3D
-                       SMUQ10_ROUND(GET_METRIC_FIELD(XgmiReadDataSizeAcc, =
version)[i]);
-               gpu_metrics->xgmi_write_data_acc[i] =3D
-                       SMUQ10_ROUND(GET_METRIC_FIELD(XgmiWriteDataSizeAcc,=
 version)[i]);
+               j =3D amdgpu_xgmi_get_ext_link(adev, i);
+               if (j < 0 || j >=3D NUM_XGMI_LINKS)
+                       continue;
+               gpu_metrics->xgmi_read_data_acc[j] =3D SMUQ10_ROUND(
+                       GET_METRIC_FIELD(XgmiReadDataSizeAcc, version)[i]);
+               gpu_metrics->xgmi_write_data_acc[j] =3D SMUQ10_ROUND(
+                       GET_METRIC_FIELD(XgmiWriteDataSizeAcc, version)[i])=
;
                ret =3D amdgpu_get_xgmi_link_status(adev, i);
                if (ret >=3D 0)
-                       gpu_metrics->xgmi_link_status[i] =3D ret;
+                       gpu_metrics->xgmi_link_status[j] =3D ret;
        }

        gpu_metrics->num_partition =3D adev->xcp_mgr->num_xcps;
--
2.25.1

