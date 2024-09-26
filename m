Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8602CCF9E9
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Sep 2024 09:08:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5D12110EB21;
	Thu, 26 Sep 2024 09:08:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="m3dscDXr";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2064.outbound.protection.outlook.com [40.107.220.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0466B10EB21
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Sep 2024 09:08:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TaxtWgPNpLzqJIOpJIsgqlVlpTPuMe2/Ovns/yyIxf734GTlAA0maizABSQOHnPn35cwfckT6ssKgolAda3hIoca3jcIpaOF18AryejUDMPnUYJi5maeR2CuwZya5VXAJJyh4n+VQO2ucxQDYg4OIJ1hIuJGon1ESZq/0FR1RHVtrlcXvxyJmiOmyGQJIiwYIavfEtYMw4ke9/PrCIwXUIOHeOYRoYMeIJ85lgedLz7Yh8bfblj7AmMo5AT3ZrKYF6SpsU5ufSH05TmTWM5lBobuOYk/XdIgpJ3xRCsshQFnrrQ3fxVTOBWbxP9Y2B6ycZ8YlLKChYL/EBpQhXfSlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LtgcUfpdI6t11vMVZUikN1WtFrbEkogMG0qYtls9BA4=;
 b=KGxqndMAnuRKQIRCXUTMTaBlMXX0Xe0MTLoOtVPksymHfmKLnXp7v+xWGgAVQjiy6UkeDTPmLHm2/B8l/IKGd5GaF9Llebs+b29s638lEMcpH5U0arZQMzKdaHRpst8q/sEbbi0D6rKP7dVsXkIDyC9BBUbd28/Ieh2rrprPvaOS7fFEb4lVmIyUliKiFKA5iP/WBb4d05tY1sou8NxZuhFHGRzMmNsy0zxGmqPjVgD1ieeZ/h9lv+yJHJKdWhn8VqN4ArSd6RBj68yj3kYiTHbUuFCB+cDTUfXrwSJ6DhWggogoMryJ8bAwZjpMc86GS5x8iFc8LgWC/GSW/E0vgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LtgcUfpdI6t11vMVZUikN1WtFrbEkogMG0qYtls9BA4=;
 b=m3dscDXrdccXRqujE4tXrY1chYKTZTkSPU8QcJNl3foVdKmFyd/Q+8ZvVWLcOiFZMk8Tb1U1LP43r6jTh4JbSMMj7D4vcIJSinlzJBEIch5ayQhChjQk4IJm1frF2UEMmAxio6+LIWeD2cCEBa5HCNx8CrbaH7EEk4W1M5HvkzQ=
Received: from CH2PR12MB4152.namprd12.prod.outlook.com (2603:10b6:610:a7::8)
 by CH3PR12MB8212.namprd12.prod.outlook.com (2603:10b6:610:120::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.21; Thu, 26 Sep
 2024 09:08:16 +0000
Received: from CH2PR12MB4152.namprd12.prod.outlook.com
 ([fe80::8c7e:a1a7:74ac:29a8]) by CH2PR12MB4152.namprd12.prod.outlook.com
 ([fe80::8c7e:a1a7:74ac:29a8%6]) with mapi id 15.20.7982.018; Thu, 26 Sep 2024
 09:08:16 +0000
From: "Xu, Feifei" <Feifei.Xu@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Koenig, Christian" <Christian.Koenig@amd.com>,
 "Bhardwaj, Rajneesh" <Rajneesh.Bhardwaj@amd.com>, "Errabolu, Ramesh"
 <Ramesh.Errabolu@amd.com>
Subject: RE: [PATCH 7/7] drm/amdgpu: Add NPS switch support for GC 9.4.3
Thread-Topic: [PATCH 7/7] drm/amdgpu: Add NPS switch support for GC 9.4.3
Thread-Index: AQHbDkasNkc7YTA0yE+Cz8Lj8AtXDrJpyqgg
Date: Thu, 26 Sep 2024 09:08:16 +0000
Message-ID: <CH2PR12MB415218AFDB101F14049DBB50FE6A2@CH2PR12MB4152.namprd12.prod.outlook.com>
References: <20240924055652.2678433-1-lijo.lazar@amd.com>
 <20240924055652.2678433-8-lijo.lazar@amd.com>
In-Reply-To: <20240924055652.2678433-8-lijo.lazar@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=98a09991-d19b-4a3e-8d15-e1562e57b118;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-09-26T09:08:08Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PR12MB4152:EE_|CH3PR12MB8212:EE_
x-ms-office365-filtering-correlation-id: a3681501-7d32-4627-0488-08dcde0ac1d4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?b2l05pAX8YDyj7avj1Om6hMYJczZ4ds7BLjVNQZ5buiffiytSc7c2RbxjEKW?=
 =?us-ascii?Q?J5fwDMQBbLmMBdMH/f2QgjrXaiAu7rLuKxvhQ+CkmBrTkbeSHY22wt0DWbgx?=
 =?us-ascii?Q?OrEGd06D8Ey/jRaYfw4Dt02umBXTnPZaxN1Grw3f3iPAHxYShIe+5lY9LxDa?=
 =?us-ascii?Q?V2JNO4yYtUebLq4KhwI+c7utVoZzN2oZfzNmOsXyHMDvkkIidu8M60b6zZ5g?=
 =?us-ascii?Q?P+1ukZT5TS2O3ZW8l6HAahRimRjRCsWY9g3O53Iv8Q+A2kf0EV2nmvp9KvIQ?=
 =?us-ascii?Q?/SDO6byp1sMicMopvM+hrCPgI55VjlE4jVEloL5ILBcpK0tHAjgom/qtLLB5?=
 =?us-ascii?Q?l9KlTgQopi2Aztr3hUlL/we/3+yjVX8pRpx/9lWOtRF76qFRsaAzn6H1mJ7U?=
 =?us-ascii?Q?ac1Fd3gqVermY//+IjGd0REsKo+ED2zrM2AW7j09ab4Stq+mLIaeYiwwZbCS?=
 =?us-ascii?Q?zj+FYsTa85/z1ugM72tQJIDdbD4GB2JFEWulvWnIdlACNSMkoUh8jA4h17k7?=
 =?us-ascii?Q?FoyMipvyn8VrNYvX6rFhdA2wBuUQiUYuG6Hr72qNZ59AC5+ghFRlzQ9okv3m?=
 =?us-ascii?Q?U8dfNgNKzgzPhmXvHeq8o8x6lI1r4ME8EXKBIhbzRPATehXs4+Q9BZKa09uP?=
 =?us-ascii?Q?UHyzcbCHAFMOLda0tegc85zonrrn/vfeewMp9fQz7d6wiwr0+R56YCHPCTlK?=
 =?us-ascii?Q?3P/i2s8b4rJ+IiM5ivDjYuCEZgzS21n14YdVK/63CaAtnQ6m6PpO3nkyQJLR?=
 =?us-ascii?Q?e3joJu52bVLRAke/0yuaP58G5RZtKqPZmZxoQpc0ubFajKnnsFk6cLhVUK77?=
 =?us-ascii?Q?lPYxu4gBuGHtJf07U9tXApEng/kTnbMJlgpqeP8hRYLmpCREVA0lG4BNRDGU?=
 =?us-ascii?Q?wQVyjIyc4NR+z5AimRTjCWoMDCJg0UM/vc3J3dK439E/14uXc8xpB2nK2njs?=
 =?us-ascii?Q?Hd+mFyhx2AvQ1rmaPof1qcOhkL9niZ37fsW/CiTWW8171vmt/vX6iz1jsIXF?=
 =?us-ascii?Q?aZuwECiIm/u4yvutCW5f6DBkvWbNVoGHbi1ySz0Vnmi1qXq5ApQ8KUaem4m6?=
 =?us-ascii?Q?ZDJzTowPqq2POhAUtA8R9dr/vag+xTsRWM4pyPtaCeKMyQysF7olSXmkhpHw?=
 =?us-ascii?Q?vkum3x/by44Wdw4g+kNFHrs6fn6x5/rS85790LMvOlSXS8FY7wEI72kKcmF1?=
 =?us-ascii?Q?5s1P0v51YUaADkyPSL6R+LC08GmKqnENUxFEG3G2gdyYDWNcd/vE9INGc8ua?=
 =?us-ascii?Q?kUNsDc4HZLjhYg2oXqviYyoJew3RTvWQs9VFN6oeEm5kmPuqEg1pgvU5TmTh?=
 =?us-ascii?Q?rdi+NLDmDOBRtm85jOvnfy87J0kf+uHWHrWBzYdcljhJLeiNIMYUs+QG7lOM?=
 =?us-ascii?Q?caurOmcXfLGxg3kWhO/RHrNBJJvHbayL5jRKdPox8U6wzgifRA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4152.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?a6ORc2hfZOpUqpo0GpcKihcEMVwHWwy54x1CajLbSUnsejRkE1sEIxNfnm9Z?=
 =?us-ascii?Q?75DgPug/YI02t0BbrW25MDKyFfSys2pmHUvpS6A7ctkxRsbGiNct/OrsXcJ3?=
 =?us-ascii?Q?rWHQye+8ENWtS9i/2oW86TUpgj9hAsHXJEGbep7y61v08cyKtw1rndM4UPkt?=
 =?us-ascii?Q?tCBuHtYPSOt3fubO22FR/bXZ6cxi4y5nEsJudPw3vCx6sby7kct6sXPbQYIt?=
 =?us-ascii?Q?kAHjuxUQBO06LZzzdIVsLwlySy8voDAmHksiJ88LikcSnfgkyY1HcdFGKEZX?=
 =?us-ascii?Q?ZsN5Ofo9ZxbEZB6asn6qJdB5caAE1OO7ZlCM3oy+90imlTBnwBW/1HI7mzig?=
 =?us-ascii?Q?EkeNSP4iD/0bK42m6Zs9AyIrV3lSBnHkXQh8+pEnmGujrFkUpKcFnVVjCi3k?=
 =?us-ascii?Q?wA0kh4NW8vjElM55rughvhnFCJJUGCLGYnWHb3pcGLGGFG8pL/H9oCT4s1m/?=
 =?us-ascii?Q?y8Iee2QwRyCiQO4Nque11OiK9hpDtHkaknGJHcZOay5NowJ4kxheBI7aCvKD?=
 =?us-ascii?Q?y3VEDhjt9Pl1NR8hwgP0v7e+0BaCGLyR4N6JrOhwyzokgoGSX7sUaNY+1ZK+?=
 =?us-ascii?Q?00po7vU0uYM81q7ktJXFUm+JE/V3pAYXNpCAjEN3c0Wcq6H28wzDi5iww9GO?=
 =?us-ascii?Q?6mbUzGZCFhmiNwhS7IoKGQ1z1/BWO0xb13HRiXrXcXnX0zj6+3MICERLwZkt?=
 =?us-ascii?Q?Ycq+iY1L4UiCsdEwdWDN0n7dFd5gCQiM89QMo8pqKL4JY/MLD+lcnSiGysmA?=
 =?us-ascii?Q?Jja0k6yGHIs5zUzZnQ53snRjw44HS4P2QCfI+o2HAi040TziwaN3QF6WVWND?=
 =?us-ascii?Q?0cxwXgNTsmN365mULNYKDaI+U5IPklIpo2AjKJ2eZ4SiC2KXtRK2vTuaA3bz?=
 =?us-ascii?Q?uPwTy3nJc0Tlxi9VFiD8ceuy/egAa2jBW35BF3vYTVCB1KMugJafrL8+cr15?=
 =?us-ascii?Q?6w1dQKAE9Ca8h6cwFGeilm6Ow3Gj1g83Egoz+nglySVgA8BXgkH73iwliSWU?=
 =?us-ascii?Q?n6PgtxR6k35dquvzEEUO/ms0k0c8XaJKYb42B1SbFtmn1P1DPWhpSj1/aLEm?=
 =?us-ascii?Q?maji0hEZcbk2u/VBQ+HR+P7v6AZUI340RVwL4w5jPU2Cz0WoWPrlbThdyuFH?=
 =?us-ascii?Q?5FiKwZOheZwYQXBKT3hgli2+XCA/GIHq1DCpOM2NsRsNGCXtbuxda+7rZwL0?=
 =?us-ascii?Q?7i02mlmtqX49keG0zr+Iak7AeJJa1ENybtb9LkimgNw3cJZF+p6xnTZPAcdX?=
 =?us-ascii?Q?wNMODEpMOMa3NSIx2PoPqLAVu99bLnbve4dLrYVLZ52TmHSS1Yzn0U4qTAUa?=
 =?us-ascii?Q?IlKam1t/d5N6Q5aVCoYU1uWQjt5ntG64+kOQAFYOd0DYaYpLJ26mF+7XGrNQ?=
 =?us-ascii?Q?oaSbO7nj2V+UGIw2V37CMDw6tDH94xaEs+2j6pyBJJLDCvqlaGFxpYlPT4IF?=
 =?us-ascii?Q?UoW8aMLchLz3Hni17/r/A17gd0gtzQMaqtOCZRoeFkishOwjx5i45W/d+kfl?=
 =?us-ascii?Q?2GgELuuAnV9WI7v1upgxLg/o5RYVqVscrdhJERveBSwb5PZXeJyz4G2NB10H?=
 =?us-ascii?Q?1GwD9w7o8eLdc2Ew+OY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4152.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3681501-7d32-4627-0488-08dcde0ac1d4
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Sep 2024 09:08:16.2608 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IYR4c8OZNgjta72kH/c9hNvtzFju1llUTKmbedIvK6WmZD1qSbD06sGfoTXjsjrr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8212
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

Reviewed-by: Feifei Xu <Feifei.Xu@amd.com>

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Lijo Laz=
ar
Sent: Tuesday, September 24, 2024 1:57 PM
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>; Bhardwaj, Ra=
jneesh <Rajneesh.Bhardwaj@amd.com>; Errabolu, Ramesh <Ramesh.Errabolu@amd.c=
om>
Subject: [PATCH 7/7] drm/amdgpu: Add NPS switch support for GC 9.4.3

Add dynamic NPS switch support for GC 9.4.3 variants. Only GC v9.4.3 and GC=
 v9.4.4 currently support this. NPS switch is only supported if an SOC supp=
orts multiple NPS modes.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Signed-off-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h |  1 +
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c    | 44 ++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c   | 12 +++++++
 3 files changed, 57 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_nbio.h
index f61d117b0caf..79c2f807b9fe 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h
@@ -101,6 +101,7 @@ struct amdgpu_nbio_funcs {
        int (*get_compute_partition_mode)(struct amdgpu_device *adev);
        u32 (*get_memory_partition_mode)(struct amdgpu_device *adev,
                                         u32 *supp_modes);
+       bool (*is_nps_switch_requested)(struct amdgpu_device *adev);
        u64 (*get_pcie_replay_count)(struct amdgpu_device *adev);
        void (*set_reg_remap)(struct amdgpu_device *adev);  }; diff --git a=
/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_=
0.c
index cafcb24449df..6a95402985ef 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -1395,6 +1395,17 @@ gmc_v9_0_query_memory_partition(struct amdgpu_device=
 *adev)
        return gmc_v9_0_get_memory_partition(adev, NULL);  }

+static bool gmc_v9_0_need_reset_on_init(struct amdgpu_device *adev) {
+       if (adev->nbio.funcs &&
+           adev->nbio.funcs->is_nps_switch_requested(adev)) {
+               adev->gmc.reset_flags |=3D AMDGPU_GMC_INIT_RESET_NPS;
+               return true;
+       }
+
+       return false;
+}
+
 static const struct amdgpu_gmc_funcs gmc_v9_0_gmc_funcs =3D {
        .flush_gpu_tlb =3D gmc_v9_0_flush_gpu_tlb,
        .flush_gpu_tlb_pasid =3D gmc_v9_0_flush_gpu_tlb_pasid, @@ -1406,6 +=
1417,8 @@ static const struct amdgpu_gmc_funcs gmc_v9_0_gmc_funcs =3D {
        .override_vm_pte_flags =3D gmc_v9_0_override_vm_pte_flags,
        .get_vbios_fb_size =3D gmc_v9_0_get_vbios_fb_size,
        .query_mem_partition_mode =3D &gmc_v9_0_query_memory_partition,
+       .request_mem_partition_mode =3D &amdgpu_gmc_request_memory_partitio=
n,
+       .need_reset_on_init =3D &gmc_v9_0_need_reset_on_init,
 };

 static void gmc_v9_0_set_gmc_funcs(struct amdgpu_device *adev) @@ -1545,6 =
+1558,28 @@ static void gmc_v9_0_set_xgmi_ras_funcs(struct amdgpu_device *a=
dev)
                adev->gmc.xgmi.ras =3D &xgmi_ras;
 }

+static void gmc_v9_0_init_nps_details(struct amdgpu_device *adev) {
+       adev->gmc.supported_nps_modes =3D 0;
+
+       if (amdgpu_sriov_vf(adev) || (adev->flags & AMD_IS_APU))
+               return;
+
+       /*TODO: Check PSP version also which supports NPS switch. Otherwise=
 keep
+        * supported modes as 0.
+        */
+       switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
+       case IP_VERSION(9, 4, 3):
+       case IP_VERSION(9, 4, 4):
+               adev->gmc.supported_nps_modes =3D
+                       BIT(AMDGPU_NPS1_PARTITION_MODE) |
+                       BIT(AMDGPU_NPS4_PARTITION_MODE);
+               break;
+       default:
+               break;
+       }
+}
+
 static int gmc_v9_0_early_init(void *handle)  {
        struct amdgpu_device *adev =3D (struct amdgpu_device *)handle; @@ -=
2165,6 +2200,7 @@ static int gmc_v9_0_sw_init(void *handle)
        if (r)
                return r;

+       gmc_v9_0_init_nps_details(adev);
        /*
         * number of VMs
         * VMID 0 is reserved for System
@@ -2440,6 +2476,14 @@ static int gmc_v9_0_resume(void *handle)
        int r;
        struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;

+       /* If a reset is done for NPS mode switch, read the memory range
+        * information again.
+        */
+       if (adev->gmc.reset_flags & AMDGPU_GMC_INIT_RESET_NPS) {
+               gmc_v9_0_init_sw_mem_ranges(adev, adev->gmc.mem_partitions)=
;
+               adev->gmc.reset_flags &=3D ~AMDGPU_GMC_INIT_RESET_NPS;
+       }
+
        r =3D gmc_v9_0_hw_init(adev);
        if (r)
                return r;
diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c b/drivers/gpu/drm/amd/a=
mdgpu/nbio_v7_9.c
index d1bd79bbae53..8a0a63ac88d2 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c
@@ -401,6 +401,17 @@ static int nbio_v7_9_get_compute_partition_mode(struct=
 amdgpu_device *adev)
        return px;
 }

+static bool nbio_v7_9_is_nps_switch_requested(struct amdgpu_device
+*adev) {
+       u32 tmp;
+
+       tmp =3D RREG32_SOC15(NBIO, 0, regBIF_BX_PF0_PARTITION_MEM_STATUS);
+       tmp =3D REG_GET_FIELD(tmp, BIF_BX_PF0_PARTITION_MEM_STATUS,
+                           CHANGE_STATUE);
+
+       /* 0x8 - NPS switch requested */
+       return (tmp =3D=3D 0x8);
+}
 static u32 nbio_v7_9_get_memory_partition_mode(struct amdgpu_device *adev,
                                               u32 *supp_modes)
 {
@@ -508,6 +519,7 @@ const struct amdgpu_nbio_funcs nbio_v7_9_funcs =3D {
        .remap_hdp_registers =3D nbio_v7_9_remap_hdp_registers,
        .get_compute_partition_mode =3D nbio_v7_9_get_compute_partition_mod=
e,
        .get_memory_partition_mode =3D nbio_v7_9_get_memory_partition_mode,
+       .is_nps_switch_requested =3D nbio_v7_9_is_nps_switch_requested,
        .init_registers =3D nbio_v7_9_init_registers,
        .get_pcie_replay_count =3D nbio_v7_9_get_pcie_replay_count,
        .set_reg_remap =3D nbio_v7_9_set_reg_remap,
--
2.25.1

