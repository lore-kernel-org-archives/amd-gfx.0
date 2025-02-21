Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AE02C021AA
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Feb 2025 12:59:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DC64E10E33D;
	Fri, 21 Feb 2025 12:59:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="kL8ECvCK";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2078.outbound.protection.outlook.com [40.107.92.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0BD4B10E2E5
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Feb 2025 12:59:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YTaB7Sllv/8NBA5eqpZgoh58qvFMjKwK6wfI+nQnvuNJoULf1XG72cn/znknA/sWi2tzffIO3Lds+wlmyJicAt5xGw0hIrETK9MO+sWco3SZ98WXgpqUjLxmlYBJZhLLBNYl3sNfVhTfYJJT/OApDwoSXGI1DAgXeLM0pMZpv+kXsOP4Cko6qFGM4WIbhydPJy9xIihLJbSLCt8k1WiH3/cCAaa+SEHs3GD87KoVjiistH4md841+q7vRrPxLD0honwqxFvd5cslUpb8EloL+dUQLGmw/nuV2oMEmeQKg/Yu3369OE/Wcp1WKRdxUY3lRacKu9jdqsmBw27FCwxcLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=37CbkTr1j22pHwRr7WopqS0HKvz3G5nR+mKuciGHtTA=;
 b=Oa+NaSoLqeB7x0SQUnxxeK7uOYzYy7/1NyqnzG8qkolWxNwNKZlPWxJgav2I+xEYxjg3GmNVSRUPl9pv8pwKDGsA3Gs/giirgAYPKix1jvQUIApU83upw1bgCAPTzHfac4nB9iE05BMQRyxk305ydiRyt8sG9bVIkrX4iXa9S3O3sT6iFqT6Z0z9wMoUY1gvxttDXhk3x7y8t4k2b+J7LcTkJY2e3gVWdB30hM6cOcMzr0WA1ogh8x5RrVwfYx9Ff6JUhEJCNviXKhcQLk9wpMlyqCB6y990FQalnIhe+Yayqw80I9dJXQAlLliI13hO0njoZAGPc9UzyfeRTnPtcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=37CbkTr1j22pHwRr7WopqS0HKvz3G5nR+mKuciGHtTA=;
 b=kL8ECvCK0Q8KFYEAsK3wjWCjk6sQ+wn2YLz2GMWZN4AzF/ilOJ46xXyGikwCWFOLLAubqDDFE4DAHXsFQ33pdXlRnXeR2/wUJZdA/RJgHYuQLzwOjUe/49erTSkxbOt3S7vqu539i7VT2IQf3puLbR+MOh0FUtt43vAMpiEl99c=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by SA1PR12MB9489.namprd12.prod.outlook.com (2603:10b6:806:45c::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.17; Fri, 21 Feb
 2025 12:59:45 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009%7]) with mapi id 15.20.8466.015; Fri, 21 Feb 2025
 12:59:45 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Kamal, Asad" <Asad.Kamal@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Lazar, Lijo" <Lijo.Lazar@amd.com>
CC: "Ma, Le" <Le.Ma@amd.com>, "Zhang, Morris" <Shiwu.Zhang@amd.com>, "Deucher, 
 Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH 5/5] drm/amd/pm: Use separate metrics table for
 smu_v13_0_12
Thread-Topic: [PATCH 5/5] drm/amd/pm: Use separate metrics table for
 smu_v13_0_12
Thread-Index: AQHbhFrmonfz4ddvE0Ojnt8RL6XWcLNRuCKA
Date: Fri, 21 Feb 2025 12:59:45 +0000
Message-ID: <BN9PR12MB525735246CF35C9C3A0F2884FCC72@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20250221121920.779576-1-asad.kamal@amd.com>
 <20250221121920.779576-5-asad.kamal@amd.com>
In-Reply-To: <20250221121920.779576-5-asad.kamal@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=2c09efac-18c4-4647-8695-f94938b02750;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-02-21T12:59:20Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|SA1PR12MB9489:EE_
x-ms-office365-filtering-correlation-id: d30a1a63-8864-49ac-50ec-08dd52779d89
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?sb3mNdBeQ4RfAj8APEL/GRmf/R1Pk+hTpx6Lr+P+if6fy/Yc4PgFaKEYa78i?=
 =?us-ascii?Q?a4rtTb09cgJPcd2xMmHtYIUAabBu8Se7UbxnDVIjHqk/eSNDcVWpfjyql7kb?=
 =?us-ascii?Q?BH7iK4kVwrFPPjUS7ZDprcXr75AvtakWakTP8lYEnFblUDWeHqu81VaJk3Vl?=
 =?us-ascii?Q?YCGIv1PqW0+eZ7jk6AKRhVSy3PvLFv7ItlUKJSw1UYBn0Je6q4yTEQGdckyn?=
 =?us-ascii?Q?9GCpu9wMgGDTm/p5JD6saqegvUl7XGiun/huteD0XB7tn+X3Z9bc92IHYj7v?=
 =?us-ascii?Q?eF22IZWGTeebe0QAxzd7oHzzOGgvxO+uGyzSs8/2aJUNs6Ym3yA9krMkgb7R?=
 =?us-ascii?Q?Vre3zBV98QdRu+rQRxPnrpI7al3Hh6prnJ84/EFGEl0BoXwSKivDHdrhfjl5?=
 =?us-ascii?Q?LbEl1uc/R67BAveGSO1LIHCuq5G/xmGQkOnPsRXtPVOwfKntV9TTz7Ny53oy?=
 =?us-ascii?Q?tABMx6RXNr/P7Az2GxWRr5aFRy5mspwkUpWHh9MRbflTqk1ZnEfqB1MSXNBm?=
 =?us-ascii?Q?ElaumNysS4Zf7rBRjWJK+0xzWGIIIvwPgcodtWZfSNhLEHlfhHUXSIrZo3xJ?=
 =?us-ascii?Q?ReCTGn8xrNOg5A1K90E+X73CaW+B2BACiBwPxDVz4gMx5BB6E8tAe9vUxoZq?=
 =?us-ascii?Q?vQnOqkIbexOE8p2bGNXNjxlkQPUH4HxGZL7QFsmN1KgKoChfFoifaxHlGSHx?=
 =?us-ascii?Q?cNGWESRWm3OHYR0gLmSnCT7VF6jrlJ+kc5F6JAngepT4dz/6+mYQI2hXyaU5?=
 =?us-ascii?Q?H4wZ0tIPGJ3C6T8LiD7qVZRv4W2e9QldoAgNOi45ugnV583XzbDtTUJQRJ1O?=
 =?us-ascii?Q?Q5xfo11Dj+fR/NsR22Vjt/KOamyYApMWCoPu+bZ9WrN/S/Mmvj0FvMPUCLF2?=
 =?us-ascii?Q?njKUOsy542ush7umjJmpOVpBZxIJLQb3BnSFYXrRMIGfycZvAsPZrbWJhkys?=
 =?us-ascii?Q?3Ao+o5GxP5jBTtuZMG4dcXXUKKDkrwrqcaBQA9rffWr8ff1nQ57OnU/JAE/k?=
 =?us-ascii?Q?6ZGvE00AZOmdwp8BeQImpnDJV2saxjLPRR+6ZUpl2siZG+fBB/kU5CQgt0Ij?=
 =?us-ascii?Q?yMyc3bzhG/AlfGRpUCb/81uO9hSf5hbeTVOYSja1IneeOfpU7afy5H0hu/bR?=
 =?us-ascii?Q?4Lj2aWK88v4TQl4RmkyzLM1/jP1Z/L0Nhd6oJfe2k1+kODcUQ5COyA0SyAWT?=
 =?us-ascii?Q?QRL88OGQGoVq2whSKtR2I2tvfVMuNQbgZahUsywAh5lgjLgxt0gV5Ul+nmYP?=
 =?us-ascii?Q?5FQJNrAEOxzA/f9Wy4a2izAUwvHgB54LuGPWNdpeFbiSOtGdDxY4yLpmGXlG?=
 =?us-ascii?Q?oiy48LEk6m03xYJTAehK2Y9ZOFeRxUV6nk7LYv7cDqZMOcsSrDAnWqVo//f3?=
 =?us-ascii?Q?QlU3tEKVzOVgpIMRONo7OWYPpe5K+qmnqAt9c0rMuGkheSSXex0Qn57yxEJO?=
 =?us-ascii?Q?UNny1IdF04V63HPSsyr0OsuadX3Cuol6?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?/EGM/neU05OSFffcOkF1jNcoBG/7OS4Y/sYUI/HkZ/l3b8p843vje1S5E6TN?=
 =?us-ascii?Q?FOZdj7ABQkBHTmyPgNS5sxgSIavAq8I5MSZGQTXiKAycUtPF9wX1mT5PGh+G?=
 =?us-ascii?Q?AFvAkY0uh59T7PRA/yOdHPGc6sPa2KabgE2xfAWpCIP3C4l6KgqjZk29JErT?=
 =?us-ascii?Q?0ZIgcOXob+3SOH7z0LF69Lc5l3p55CPnBYuIBRU5UM/XvYtW1niUKY+tOsce?=
 =?us-ascii?Q?N4Sib5K7cN+epaZGz1BZcKi00E9eoLvJiWY0ManPaIJ2vHSXO0tsQiHLwXNY?=
 =?us-ascii?Q?qNQfKyZq+EJ05DHH4gOgyeM4/2838SANdYJjF0YJX7i4R+a0Ye55mwkFb4Hc?=
 =?us-ascii?Q?l5kSCKpCeQ2bdWbVOXan1SEGiRj4Us221V8nyK5TmNHCM0NyweTDNl/JV1gT?=
 =?us-ascii?Q?02oAsmtskAA5Dyh+P+5PBqq615efxNVLj3y2RJczfK9l87GlE1oGLHyFB7af?=
 =?us-ascii?Q?lSGXbLRO0nVZ6ju+S5UMYanH8ls6IE4zayV5rX+nHte5fO45cP/Ilp7CiSH+?=
 =?us-ascii?Q?DgBXsJz77OakLKsjMfD1wT3cB/QxmAmyzH6b/kEA5cqJrQL1iVZbArwp1T52?=
 =?us-ascii?Q?gUArdAesJ1zmHzMUODJ34oFfGMfDkTjlha7ssHMaAgAM19G+trL1+RC5l1/E?=
 =?us-ascii?Q?NjCwrBhGxwHRFmjbeMGTzXuVKlBFLy4MJWYaAXMNuZzc0Hme0QzwbfP+WYnu?=
 =?us-ascii?Q?x59n3DOyeqF6Y0vHuHGGKnX/b+uEjvEbdGpY8T3onl5BmFKSMHgO/jg+sVPO?=
 =?us-ascii?Q?qHHPv4opVPboSSQAq72f3kGeuFPzYnHirxF4AU+AVd3IcV0HM40nT1+9wUkZ?=
 =?us-ascii?Q?t3NWNEo3WCQ7BjAL8DzpiZQAr84hga5zeLnDZ4TiVaN1gHzI2c1udJcH1cv9?=
 =?us-ascii?Q?zZKa0EYTnxibWMWx+xqWFV31LvPyyw1pY32ay7Hgh3DhGiZUct+U6ng6kB98?=
 =?us-ascii?Q?xGo6H/hKm3AoOCPzBG2ecOg007FXNq+RFVqpODv9cgXAEve033P3r2WU4Jzd?=
 =?us-ascii?Q?0GATbH9gC2ZYj03rqCPTgvPsNXiOr2XV4eqYH0outKKdLUCXP05UTQ7NQMit?=
 =?us-ascii?Q?t2Sp8FtQkVV52TSxLMrR4+5cHAldMksTNNgxXg3VmIzFfZZTdobw0X103gKl?=
 =?us-ascii?Q?giPd2yobxTeO2Apkcm6ru/XmIzN0SyDpTchPCQiRTtQNp7d7UNU5hi/6EMxu?=
 =?us-ascii?Q?76usfmKUoh42pztYjTGkJUpefLTBhlxuoIm+bQStUwLB5jxhUFzuudfAfNTF?=
 =?us-ascii?Q?mZ3Fkox0o9HpNOxbFbvHnIWLkSnn5FwcGuabi9NVYim/dtNPYDSCz0mt6SRn?=
 =?us-ascii?Q?1Tk9mleW86527jR6msZWhYIMOuyPUqEbVQb4bRbtZQUeQq2o9mX+nH/WMQE4?=
 =?us-ascii?Q?jpodl6s2deocZIEMWaN7yXKz4EVVYOJOZqtd6nVQhwfLpF0KO32ROa8l1DIi?=
 =?us-ascii?Q?QPayLB/u4sx8umKHJJiamQaQAzBio7ETUkKPO2/z9BM7zU+bgpiHoMv1t6dB?=
 =?us-ascii?Q?I2pVtsP57jhY+88fPK6unaqlwGfKr12ENLYB441t9+uueR3UhjJefGbLYMKZ?=
 =?us-ascii?Q?3qbDeJJoqaErbt4FPCR3OFPrjZPGIBEepOSrUZBv?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d30a1a63-8864-49ac-50ec-08dd52779d89
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2025 12:59:45.4045 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: l7EpHt2FysqEeVCbb6iYqt3V1NkRnumRe2ZW+cgeJqcERGj9OlIu79F53EFtj1kpFaW9Bv1dKw6VfhrXrkP8RA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9489
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

Series is

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Kamal, Asad <Asad.Kamal@amd.com>
Sent: Friday, February 21, 2025 20:19
To: amd-gfx@lists.freedesktop.org; Lazar, Lijo <Lijo.Lazar@amd.com>
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Ma, Le <Le.Ma@amd.com>; Zhang, =
Morris <Shiwu.Zhang@amd.com>; Kamal, Asad <Asad.Kamal@amd.com>; Deucher, Al=
exander <Alexander.Deucher@amd.com>
Subject: [PATCH 5/5] drm/amd/pm: Use separate metrics table for smu_v13_0_1=
2

Use separate metrics table for smu_v13_0_12 and fetch metrics data using th=
at.

v2: Fix jpeg busy indexing (Lijo)

Signed-off-by: Asad Kamal <asad.kamal@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h  |   4 +
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c | 219 +++++++++++++++++-
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  |   9 +-
 3 files changed, 230 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h b/drivers/gpu/drm=
/amd/pm/swsmu/inc/smu_v13_0.h
index 4dc3b37d52b9..cd03caffe317 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
@@ -313,6 +313,10 @@ void smu_v13_0_interrupt_work(struct smu_context *smu)=
;  bool smu_v13_0_12_is_dpm_running(struct smu_context *smu);  int smu_v13_=
0_12_get_max_metrics_size(void);
 int smu_v13_0_12_setup_driver_pptable(struct smu_context *smu);
+int smu_v13_0_12_get_smu_metrics_data(struct smu_context *smu,
+                                     MetricsMember_t member,
+                                     uint32_t *value);
+ssize_t smu_v13_0_12_get_gpu_metrics(struct smu_context *smu, void
+**table);
 extern const struct cmn2asic_mapping smu_v13_0_12_feature_mask_map[];  ext=
ern const struct cmn2asic_msg_mapping smu_v13_0_12_message_map[];  #endif d=
iff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
index e153062adf77..5e7e97d90805 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
@@ -56,6 +56,10 @@
        (FEATURE_MASK(FEATURE_DATA_CALCULATION) |                          =
    \
         FEATURE_MASK(FEATURE_DPM_GFXCLK) | FEATURE_MASK(FEATURE_DPM_FCLK))

+#define NUM_JPEG_RINGS_FW      10
+#define NUM_JPEG_RINGS_GPU_METRICS(gpu_metrics) \
+       (ARRAY_SIZE(gpu_metrics->xcp_stats[0].jpeg_busy) / 4)
+
 const struct cmn2asic_mapping smu_v13_0_12_feature_mask_map[SMU_FEATURE_CO=
UNT] =3D {
        SMU_13_0_12_FEA_MAP(SMU_FEATURE_DATA_CALCULATIONS_BIT,          FEA=
TURE_DATA_CALCULATION),
        SMU_13_0_12_FEA_MAP(SMU_FEATURE_DPM_GFXCLK_BIT,                 FEA=
TURE_DPM_GFXCLK),
@@ -175,7 +179,7 @@ static int smu_v13_0_12_fru_get_product_info(struct smu=
_context *smu,

 int smu_v13_0_12_get_max_metrics_size(void)
 {
-       return sizeof(StaticMetricsTable_t);
+       return max(sizeof(StaticMetricsTable_t), sizeof(MetricsTable_t));
 }

 static int smu_v13_0_12_get_static_metrics_table(struct smu_context *smu) =
@@ -258,3 +262,216 @@ bool smu_v13_0_12_is_dpm_running(struct smu_context *=
smu)

        return !!(feature_enabled & SMC_DPM_FEATURE);  }
+
+int smu_v13_0_12_get_smu_metrics_data(struct smu_context *smu,
+                                     MetricsMember_t member,
+                                     uint32_t *value)
+{
+       struct smu_table_context *smu_table =3D &smu->smu_table;
+       MetricsTable_t *metrics =3D (MetricsTable_t *)smu_table->metrics_ta=
ble;
+       struct amdgpu_device *adev =3D smu->adev;
+       int ret =3D 0;
+       int xcc_id;
+
+       /* For clocks with multiple instances, only report the first one */
+       switch (member) {
+       case METRICS_CURR_GFXCLK:
+       case METRICS_AVERAGE_GFXCLK:
+               xcc_id =3D GET_INST(GC, 0);
+               *value =3D SMUQ10_ROUND(metrics->GfxclkFrequency[xcc_id]);
+               break;
+       case METRICS_CURR_SOCCLK:
+       case METRICS_AVERAGE_SOCCLK:
+               *value =3D SMUQ10_ROUND(metrics->SocclkFrequency[0]);
+               break;
+       case METRICS_CURR_UCLK:
+       case METRICS_AVERAGE_UCLK:
+               *value =3D SMUQ10_ROUND(metrics->UclkFrequency);
+               break;
+       case METRICS_CURR_VCLK:
+               *value =3D SMUQ10_ROUND(metrics->VclkFrequency[0]);
+               break;
+       case METRICS_CURR_DCLK:
+               *value =3D SMUQ10_ROUND(metrics->DclkFrequency[0]);
+               break;
+       case METRICS_CURR_FCLK:
+               *value =3D SMUQ10_ROUND(metrics->FclkFrequency);
+               break;
+       case METRICS_AVERAGE_GFXACTIVITY:
+               *value =3D SMUQ10_ROUND(metrics->SocketGfxBusy);
+               break;
+       case METRICS_AVERAGE_MEMACTIVITY:
+               *value =3D SMUQ10_ROUND(metrics->DramBandwidthUtilization);
+               break;
+       case METRICS_CURR_SOCKETPOWER:
+               *value =3D SMUQ10_ROUND(metrics->SocketPower) << 8;
+               break;
+       case METRICS_TEMPERATURE_HOTSPOT:
+               *value =3D SMUQ10_ROUND(metrics->MaxSocketTemperature) *
+                        SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
+               break;
+       case METRICS_TEMPERATURE_MEM:
+               *value =3D SMUQ10_ROUND(metrics->MaxHbmTemperature) *
+                        SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
+               break;
+       /* This is the max of all VRs and not just SOC VR.
+        * No need to define another data type for the same.
+        */
+       case METRICS_TEMPERATURE_VRSOC:
+               *value =3D SMUQ10_ROUND(metrics->MaxVrTemperature) *
+                        SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
+               break;
+       default:
+               *value =3D UINT_MAX;
+               break;
+       }
+
+       return ret;
+}
+
+ssize_t smu_v13_0_12_get_gpu_metrics(struct smu_context *smu, void
+**table) {
+       struct smu_table_context *smu_table =3D &smu->smu_table;
+       struct gpu_metrics_v1_7 *gpu_metrics =3D
+               (struct gpu_metrics_v1_7 *)smu_table->gpu_metrics_table;
+       int ret =3D 0, xcc_id, inst, i, j, k, idx;
+       struct amdgpu_device *adev =3D smu->adev;
+       u8 num_jpeg_rings_gpu_metrics;
+       MetricsTable_t *metrics;
+       struct amdgpu_xcp *xcp;
+       u32 inst_mask;
+
+       metrics =3D kzalloc(sizeof(MetricsTable_t), GFP_KERNEL);
+       memcpy(metrics, smu_table->metrics_table, sizeof(MetricsTable_t));
+
+       smu_cmn_init_soft_gpu_metrics(gpu_metrics, 1, 7);
+
+       gpu_metrics->temperature_hotspot =3D
+               SMUQ10_ROUND(metrics->MaxSocketTemperature);
+       /* Individual HBM stack temperature is not reported */
+       gpu_metrics->temperature_mem =3D
+               SMUQ10_ROUND(metrics->MaxHbmTemperature);
+       /* Reports max temperature of all voltage rails */
+       gpu_metrics->temperature_vrsoc =3D
+               SMUQ10_ROUND(metrics->MaxVrTemperature);
+
+       gpu_metrics->average_gfx_activity =3D
+               SMUQ10_ROUND(metrics->SocketGfxBusy);
+       gpu_metrics->average_umc_activity =3D
+               SMUQ10_ROUND(metrics->DramBandwidthUtilization);
+
+       gpu_metrics->mem_max_bandwidth =3D
+               SMUQ10_ROUND(metrics->MaxDramBandwidth);
+
+       gpu_metrics->curr_socket_power =3D
+               SMUQ10_ROUND(metrics->SocketPower);
+       /* Energy counter reported in 15.259uJ (2^-16) units */
+       gpu_metrics->energy_accumulator =3D metrics->SocketEnergyAcc;
+
+       for (i =3D 0; i < MAX_GFX_CLKS; i++) {
+               xcc_id =3D GET_INST(GC, i);
+               if (xcc_id >=3D 0)
+                       gpu_metrics->current_gfxclk[i] =3D
+                               SMUQ10_ROUND(metrics->GfxclkFrequency[xcc_i=
d]);
+
+               if (i < MAX_CLKS) {
+                       gpu_metrics->current_socclk[i] =3D
+                               SMUQ10_ROUND(metrics->SocclkFrequency[i]);
+                       inst =3D GET_INST(VCN, i);
+                       if (inst >=3D 0) {
+                               gpu_metrics->current_vclk0[i] =3D
+                                       SMUQ10_ROUND(metrics->VclkFrequency=
[inst]);
+                               gpu_metrics->current_dclk0[i] =3D
+                                       SMUQ10_ROUND(metrics->DclkFrequency=
[inst]);
+                       }
+               }
+       }
+
+       gpu_metrics->current_uclk =3D SMUQ10_ROUND(metrics->UclkFrequency);
+
+       /* Total accumulated cycle counter */
+       gpu_metrics->accumulation_counter =3D metrics->AccumulationCounter;
+
+       /* Accumulated throttler residencies */
+       gpu_metrics->prochot_residency_acc =3D metrics->ProchotResidencyAcc=
;
+       gpu_metrics->ppt_residency_acc =3D metrics->PptResidencyAcc;
+       gpu_metrics->socket_thm_residency_acc =3D metrics->SocketThmResiden=
cyAcc;
+       gpu_metrics->vr_thm_residency_acc =3D metrics->VrThmResidencyAcc;
+       gpu_metrics->hbm_thm_residency_acc =3D metrics->HbmThmResidencyAcc;
+
+       /* Clock Lock Status. Each bit corresponds to each GFXCLK instance =
*/
+       gpu_metrics->gfxclk_lock_status =3D metrics->GfxLockXCDMak >>
+GET_INST(GC, 0);
+
+       gpu_metrics->pcie_link_width =3D metrics->PCIeLinkWidth;
+       gpu_metrics->pcie_link_speed =3D
+               pcie_gen_to_speed(metrics->PCIeLinkSpeed);
+       gpu_metrics->pcie_bandwidth_acc =3D
+               SMUQ10_ROUND(metrics->PcieBandwidthAcc[0]);
+       gpu_metrics->pcie_bandwidth_inst =3D
+               SMUQ10_ROUND(metrics->PcieBandwidth[0]);
+       gpu_metrics->pcie_l0_to_recov_count_acc =3D metrics->PCIeL0ToRecove=
ryCountAcc;
+       gpu_metrics->pcie_replay_count_acc =3D metrics->PCIenReplayAAcc;
+       gpu_metrics->pcie_replay_rover_count_acc =3D
+               metrics->PCIenReplayARolloverCountAcc;
+       gpu_metrics->pcie_nak_sent_count_acc =3D metrics->PCIeNAKSentCountA=
cc;
+       gpu_metrics->pcie_nak_rcvd_count_acc =3D metrics->PCIeNAKReceivedCo=
untAcc;
+       gpu_metrics->pcie_lc_perf_other_end_recovery =3D
+metrics->PCIeOtherEndRecoveryAcc;
+
+       gpu_metrics->system_clock_counter =3D ktime_get_boottime_ns();
+
+       gpu_metrics->gfx_activity_acc =3D SMUQ10_ROUND(metrics->SocketGfxBu=
syAcc);
+       gpu_metrics->mem_activity_acc =3D
+SMUQ10_ROUND(metrics->DramBandwidthUtilizationAcc);
+
+       for (i =3D 0; i < NUM_XGMI_LINKS; i++) {
+               gpu_metrics->xgmi_read_data_acc[i] =3D
+                       SMUQ10_ROUND(metrics->XgmiReadDataSizeAcc[i]);
+               gpu_metrics->xgmi_write_data_acc[i] =3D
+                       SMUQ10_ROUND(metrics->XgmiWriteDataSizeAcc[i]);
+               ret =3D amdgpu_get_xgmi_link_status(adev, i);
+               if (ret >=3D 0)
+                       gpu_metrics->xgmi_link_status[i] =3D ret;
+       }
+
+       gpu_metrics->num_partition =3D adev->xcp_mgr->num_xcps;
+
+       num_jpeg_rings_gpu_metrics =3D NUM_JPEG_RINGS_GPU_METRICS(gpu_metri=
cs);
+       for_each_xcp(adev->xcp_mgr, xcp, i) {
+               amdgpu_xcp_get_inst_details(xcp, AMDGPU_XCP_VCN, &inst_mask=
);
+               idx =3D 0;
+               for_each_inst(k, inst_mask) {
+                       /* Both JPEG and VCN has same instances */
+                       inst =3D GET_INST(VCN, k);
+
+                       for (j =3D 0; j < num_jpeg_rings_gpu_metrics; ++j) =
{
+                               gpu_metrics->xcp_stats[i].jpeg_busy
+                                       [(idx * num_jpeg_rings_gpu_metrics)=
 + j] =3D
+                                       SMUQ10_ROUND(metrics->JpegBusy
+                                                       [(inst * NUM_JPEG_R=
INGS_FW) + j]);
+                       }
+                       gpu_metrics->xcp_stats[i].vcn_busy[idx] =3D
+                              SMUQ10_ROUND(metrics->VcnBusy[inst]);
+                       idx++;
+               }
+
+               amdgpu_xcp_get_inst_details(xcp, AMDGPU_XCP_GFX, &inst_mask=
);
+               idx =3D 0;
+               for_each_inst(k, inst_mask) {
+                       inst =3D GET_INST(GC, k);
+                       gpu_metrics->xcp_stats[i].gfx_busy_inst[idx] =3D
+                               SMUQ10_ROUND(metrics->GfxBusy[inst]);
+                       gpu_metrics->xcp_stats[i].gfx_busy_acc[idx] =3D
+                               SMUQ10_ROUND(metrics->GfxBusyAcc[inst]);
+                               idx++;
+               }
+       }
+
+       gpu_metrics->xgmi_link_width =3D SMUQ10_ROUND(metrics->XgmiWidth);
+       gpu_metrics->xgmi_link_speed =3D SMUQ10_ROUND(metrics->XgmiBitrate)=
;
+
+       gpu_metrics->firmware_timestamp =3D metrics->Timestamp;
+
+       *table =3D (void *)gpu_metrics;
+       kfree(metrics);
+
+       return sizeof(*gpu_metrics);
+}
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index c3e0da680cf8..76cc827f128c 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -515,7 +515,8 @@ static int smu_v13_0_6_tables_init(struct smu_context *=
smu)
                               PAGE_SIZE, AMDGPU_GEM_DOMAIN_VRAM);

        SMU_TABLE_INIT(tables, SMU_TABLE_SMU_METRICS,
-                      max(gpu_metrcs_size, smu_v13_0_12_get_max_metrics_si=
ze()),
+                      max(gpu_metrcs_size,
+                           smu_v13_0_12_get_max_metrics_size()),
                       PAGE_SIZE,
                       AMDGPU_GEM_DOMAIN_VRAM | AMDGPU_GEM_DOMAIN_GTT);

@@ -1145,6 +1146,9 @@ static int smu_v13_0_6_get_smu_metrics_data(struct sm=
u_context *smu,
        if (ret)
                return ret;

+       if (smu_v13_0_6_cap_supported(smu, SMU_CAP(STATIC_METRICS)))
+               return smu_v13_0_12_get_smu_metrics_data(smu, member, value=
);
+
        /* For clocks with multiple instances, only report the first one */
        switch (member) {
        case METRICS_CURR_GFXCLK:
@@ -2507,6 +2511,9 @@ static ssize_t smu_v13_0_6_get_gpu_metrics(struct smu=
_context *smu, void **table
                return ret;
        }

+       if (smu_v13_0_6_cap_supported(smu, SMU_CAP(STATIC_METRICS)))
+               return smu_v13_0_12_get_gpu_metrics(smu, table);
+
        metrics_v1 =3D (MetricsTableV1_t *)metrics_v0;
        metrics_v2 =3D (MetricsTableV2_t *)metrics_v0;

--
2.46.0

