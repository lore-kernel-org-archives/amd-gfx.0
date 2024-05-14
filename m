Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 207BAC04FFE
	for <amd-gfx@archiver.kernel.org>; Tue, 14 May 2024 06:32:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ACAE810E244;
	Tue, 14 May 2024 06:32:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZPrVnaYj";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2062.outbound.protection.outlook.com [40.107.243.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3288F10E244
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 May 2024 06:32:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OcM3y05WamlS3t33UuTw6RG3ctJVBFwNcHpxk1hz1Cj92i0nUqk/HkMX9zUmHx9Msw/QcLXNHtuD0fA9uP1CB5tB7LnmVgGAGL7ezotO/QlVwd/46j4FgEgap5OoOqwO6CjlIM2cugI4nzAc5geK1uVgGBkPaCapAzHl4RnzxPduHo5ahe4BnWvAqQhqEVY8LSuW5PFPGhLRwZL9lhDbe/Rrtd5hf9TnHwv1yBL1F3b1RWwCi3lN/DixH1X9ovVUT1DMkSihlNcIyD85BzmW9zhRoK7+zLzjuiRa4vVlzk9MMGU/aXHX2gm+ez3DhCyuBv5khMFZelzdaI50RVIKQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=akJV0umbQJkAnk2T+Y3u3nYFw+NJlbsjpGld/dhRXLE=;
 b=mX6ajSJY5ESnW2gj/FEE/M8PxEXRlVokamlM3s2Bi7047z4HMbhdi6fmE/B2bRFrrSOwxn061n3rVxOU5w6pSoxyG4+sRCMON+x31zYIZpJdFhprL8OP0y0oj6+DdgBBYI6GX5qDA55FcqRTrAS6KiBu5vU90wWAKMipWn9EKDxzpyd5UsMHCqmnG4y7aCbkRzRmcbCIH+WVw4IvkaVhJN2O/mAHvG05jKOnqSn3GfTscFYF7dRsv8Kvp4TREbDWqzB5JJXHnuC2m3pzHi3RGfj9zISO4L4F7vN17U+POFEcGJ2iEHPsLiDtJMCe1w81z95jcoFVw4Erd2C9IAejLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=akJV0umbQJkAnk2T+Y3u3nYFw+NJlbsjpGld/dhRXLE=;
 b=ZPrVnaYjCuEicSv4Fd4Ti+Fb8YtLK3zf5Fs8tud+mY/FXaNQzYZv56U3HCOuZLCT3pMRP77xPhMnWEJsJWKQTf+4FglxcFLLQR4E5zX+9cD1yIDBQrw5Y/P++y686ymLrNqfN/d5iQEvKgO3BKZaa0JWF3U0DjYVDF4R6do3Ceg=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by PH0PR12MB7472.namprd12.prod.outlook.com (2603:10b6:510:1e9::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Tue, 14 May
 2024 06:32:19 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009%3]) with mapi id 15.20.7544.052; Tue, 14 May 2024
 06:32:12 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Kamal, Asad" <Asad.Kamal@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "Ma, Le" <Le.Ma@amd.com>, "Zhang,
 Morris" <Shiwu.Zhang@amd.com>, "Cheung, Donald" <donald.cheung@amd.com>,
 "Khatir, Sepehr" <sepehr.khatir@amd.com>, "Oliveira, Daniel"
 <Daniel.Oliveira@amd.com>, "Poag, Charis" <Charis.Poag@amd.com>, "Liu,
 Shuzhou (Bill)" <Shuzhou.Liu@amd.com>
Subject: RE: [PATCH 2/2] drm/amd/pm: Use gpu_metrics_v1_6 for SMUv13.0.6
Thread-Topic: [PATCH 2/2] drm/amd/pm: Use gpu_metrics_v1_6 for SMUv13.0.6
Thread-Index: AQHapcc55Yx7vzR+Bk+RBCUuGbOcErGWRToQ
Date: Tue, 14 May 2024 06:32:12 +0000
Message-ID: <BN9PR12MB52576268A440296DAECE33F2FCE32@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20240514062255.648187-1-asad.kamal@amd.com>
 <20240514062255.648187-2-asad.kamal@amd.com>
In-Reply-To: <20240514062255.648187-2-asad.kamal@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=2b6cb642-db5e-45b9-95b2-34e54f6e4736;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-05-14T06:31:45Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|PH0PR12MB7472:EE_
x-ms-office365-filtering-correlation-id: 57d6e083-577a-435e-d040-08dc73df96cb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|1800799015|366007|376005|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?G9KXITo/42QnqXO4SvYD0f2r62A9+hCJ/hI7eIC8CO1Bs8MOUl8PgSDmWpsy?=
 =?us-ascii?Q?Lu7iRWsnPtFbyLCPCl3tGsPDeguEze1itk4No/8hS0/Zg3AT4QfhJzPkTZgu?=
 =?us-ascii?Q?8i7gBvwxM5gwHpfwhjNh1JnSAyfzDEEzCU8pM1AZ4lO5SMA6J/3t1Eh/Qh7C?=
 =?us-ascii?Q?c1NdiXPYLIftvJEAMb49H6WxG3YahemKlc9OrT0/R7PPsj6qV0+Ol60wheu6?=
 =?us-ascii?Q?f0cmBCjV3xqKn2SC9dcQ6OOiYLq7gLqDdzA1TgS00GfpHRmEQhqfjgomBHRK?=
 =?us-ascii?Q?IARalyx7rAI3HuIrxhHplnJzr4l8GsH6+lQJkacIW9Lf0rBjLmKSUEnJntn4?=
 =?us-ascii?Q?evfbVv44VBVaDIGd4B0iTsg5xn72K5Nfh7meFy2CfgSWLhkayVKNpikVJEcD?=
 =?us-ascii?Q?i/VnjTQjUMwyHX73j5A/JR2V4C0iQM1LduAxdd6Jw3NLCC+cH7WA983qlP6u?=
 =?us-ascii?Q?klX+p1cdNx/vToJkMfWBgFzIfmfJ60ynIpXcpS25p0MEGdl82hQ9oRYHJJqH?=
 =?us-ascii?Q?JUu30Yb5EuuPSKcJ4TEILJ5UiXyJY+DvAlxJqTDH6ixeiAcRw/bsN1TdEDZm?=
 =?us-ascii?Q?bVUiA4d+i5TgOwCQEyy8EQ8u6KPbL0YDmmWJ0Msub+zBzgpCGFeU0LQ6kZwJ?=
 =?us-ascii?Q?jfaiXpEUH1Txi/em7VYjr0U7jpQs1BzxBdUuQQLtkz2mS62MzpHEjlgMdRlk?=
 =?us-ascii?Q?8q530Bo3BnO7yKHoc2GfiyYRjKeOTH+Q/iEuIQ1Ob1YMh83s5BRAcl7TAoSb?=
 =?us-ascii?Q?pw5P0CKn0w20JWCapH78ZhW1mI3sb5LBdv9CG32OH0IbnbZ0Vn+UvLBPrYIa?=
 =?us-ascii?Q?Ykuc3JibwxzOfX7cQNsEnCcvm+B9i+6E14Lols5cHAD8vcsp6+o/2yLxB5Hm?=
 =?us-ascii?Q?LAf9TYNLEQSzhKWxOn8ML55p1NHkLlulTqnNdcgO7TSc0UZFgOhh5QjdB57U?=
 =?us-ascii?Q?clXXGLINQvpuXDtQiooYzFlAZ+y0mV6tZ1tWSkB6VTYzEW6FHXzHhieVlr5m?=
 =?us-ascii?Q?SNDnzieH4mEUloyWLKqg/wcP4LYPWVrlLJzgElH5BfN5+qpUjNdrpHsEghqK?=
 =?us-ascii?Q?UcE0G8RRlNnKZW4pd1xYYCa+X3BkLYWxS8JvomiCNdOMrYQguPoyVAlvgzLi?=
 =?us-ascii?Q?/HmqnIXHumPT5xInxNi24fYnh2YVyfuYmKLXL3GLCG6eQ3rcp8YQELTz3Fs2?=
 =?us-ascii?Q?4SXtrLYsSConc8UUGCDUoHPqJ15CzJE+rIj1CsyzBVFCmhPNBR1BoS7/KAO8?=
 =?us-ascii?Q?FrNz0y/xLBGF/denZ5zr+wjUUbz3YXTv1jwmauZxMskEupvuP1+Nb5ud0Dh9?=
 =?us-ascii?Q?8SJUwpWQ09bSkk5PO7gqcPT5?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(366007)(376005)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?RZN/6EkOsTv5SXkwB3V3vZkHO4Vb2oQOmnUYgKUIehuHWXxV/4PXvyg9Fg14?=
 =?us-ascii?Q?P0AA8oFzs8Mk0atvQ7M5hnh7NNudhpEfUCNvLrWxUWgxh9TdlmgzeN83hMmG?=
 =?us-ascii?Q?Rirz+B8N8Xpdy+fprAMYBcfmV/Zsd30lclxlu35G7SMUptZ4CZB+mpkZWaJ5?=
 =?us-ascii?Q?VtxIlffEVrRVAsFVkeIeeIkPbV2V0iYAK6BuutEL2CxyAX874Qkr20NxzgtH?=
 =?us-ascii?Q?gcXnl2MP2cF5We9qJJZGXMS6JJOpjvMwTTicAXbRwXpmboOI+owwDoiVDG7a?=
 =?us-ascii?Q?Jyr6z6TcWhomDfDdJnpWK26s4zJeokZ+Mq8E5RiBbpcA00V/PuAzV3Myq577?=
 =?us-ascii?Q?7TGhwqOB4jQnaXZX9Da3StpV1ZBMT2YfHpXt652HcvIjT/uqi3GMiY25NeJW?=
 =?us-ascii?Q?scz3j0km80+942Flm0zBykeYRgfPuBTLPfkzQjMEj4IugEMwy4vF5lkDS5wE?=
 =?us-ascii?Q?ZZoGF9GV/PB1qgvVE5aLnFbU1OkVn2/9iKtJofAhtLx3tJMmE5yUh2y91pak?=
 =?us-ascii?Q?hKE5O7bazWTZzGe+pJ3c5yBbya0GZcQRtXjXh3C6p9OOYHqiGMmmHgjNvoKi?=
 =?us-ascii?Q?Fd/YgNaNXjVZn2luuB/StA0/MwSgu470dSF3/qeuGKAue1o2cubW0rWeMQVu?=
 =?us-ascii?Q?3tIVjLx3FLUJlY3ZDImO5EiTNbJV+X8N35CK1kx/ietrItyFKZlkT/tDuWhM?=
 =?us-ascii?Q?naN68fRHFXJyqc3Zw4HewxxaWdP2lGazWSDETbZmALO/4kdVA58IIX1rLXZO?=
 =?us-ascii?Q?L4fpu70S7TT5UdwZGo1IpsuQTo4eH2c5Iu/v0rfcSA6qGR1gD7vtyeLJx7wX?=
 =?us-ascii?Q?zXB6TWmovOJyyQyV8UWmYLu7BMdtDC9ze0qp0XqD/IkK+UyEgMCLDbYcCbRa?=
 =?us-ascii?Q?EISi7gktCMB2Dg5Z22NbNs2eanxwLLU/FAdswSZqU18sAkjPXhO9oq+QQBDk?=
 =?us-ascii?Q?Em3DwHDBr/EimLW7edaF6MXSJSgNvcyuH6V8xIL4u6X5ebYNXJg79wETp42d?=
 =?us-ascii?Q?2UTaCWgSX0cw4Pt0e8jwHw8uaiZw6nk1CFpXkiO3wFqFohFgTfMGSwlnJV50?=
 =?us-ascii?Q?5ew5AfAFCtm4fNjElWk8ICAUSxgSu5+xihByyF4CcCFpFsJDIeT8gWYlTHCO?=
 =?us-ascii?Q?9ah33y/7fRqLVWLQtj/FwZqvfDceZDMWvfTdLHcOev3prPJWbggxMKxv/zv3?=
 =?us-ascii?Q?LUZrdC0PcN/pe2slQxkBBK21z534gO3vCabYC7yArr7TpN/xld6hHAhZiZr1?=
 =?us-ascii?Q?eXMDB0t8wavCGhI8k6AkvCY597MS8AvqmST6/eK3OXCEOE5yIXe+ifMOqzyk?=
 =?us-ascii?Q?Sc2BwActRK8fByZwnc4jUofhdHRLaSG88YKNsc8SvOGEyfxUzNtJRni7s82J?=
 =?us-ascii?Q?KXu2lt8gaon7oRaBBncTzMw17j+qWrNt7oVVmvsIZOiBKT+CjZvGEDR5H43t?=
 =?us-ascii?Q?3VvxmBflFfD+60RN0Tv59ptiLbJV4L3L3Ia5vSTS+pwilfQnlYk1tJm6loEd?=
 =?us-ascii?Q?OIAAt+/3BR2oNt2ZrmGq91yotFZPzWR8RVrVIDzUvAqoEfmzKEEalcfOpur9?=
 =?us-ascii?Q?wdCn8TPLa0ExkKxdYZk=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57d6e083-577a-435e-d040-08dc73df96cb
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 May 2024 06:32:12.4338 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: h/OEFYXwHrQIztdDK+X62KQHSK80VCeUM/HuLY89IlC6nv2C3M42brbyMeq6Z0Ih2m/SMVEzlA/O4Ex72GpbeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7472
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
Sent: Tuesday, May 14, 2024 14:23
To: amd-gfx@lists.freedesktop.org
Cc: Lazar, Lijo <Lijo.Lazar@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com=
>; Ma, Le <Le.Ma@amd.com>; Zhang, Morris <Shiwu.Zhang@amd.com>; Kamal, Asad=
 <Asad.Kamal@amd.com>; Cheung, Donald <donald.cheung@amd.com>; Khatir, Sepe=
hr <sepehr.khatir@amd.com>; Oliveira, Daniel <Daniel.Oliveira@amd.com>; Poa=
g, Charis <Charis.Poag@amd.com>; Liu, Shuzhou (Bill) <Shuzhou.Liu@amd.com>
Subject: [PATCH 2/2] drm/amd/pm: Use gpu_metrics_v1_6 for SMUv13.0.6

Use gpu_metrics_v1_6 for SMUv13.0.6 to fill gpu metric info

Signed-off-by: Asad Kamal <asad.kamal@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
---
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c   | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 46ab70a244af..70e5589f6229 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -350,7 +350,7 @@ static int smu_v13_0_6_tables_init(struct smu_context *=
smu)
                return -ENOMEM;
        smu_table->metrics_time =3D 0;

-       smu_table->gpu_metrics_table_size =3D sizeof(struct gpu_metrics_v1_=
5);
+       smu_table->gpu_metrics_table_size =3D sizeof(struct gpu_metrics_v1_=
6);
        smu_table->gpu_metrics_table =3D
                kzalloc(smu_table->gpu_metrics_table_size, GFP_KERNEL);
        if (!smu_table->gpu_metrics_table) {
@@ -2176,8 +2176,8 @@ static int smu_v13_0_6_get_current_pcie_link_speed(st=
ruct smu_context *smu)  static ssize_t smu_v13_0_6_get_gpu_metrics(struct s=
mu_context *smu, void **table)  {
        struct smu_table_context *smu_table =3D &smu->smu_table;
-       struct gpu_metrics_v1_5 *gpu_metrics =3D
-               (struct gpu_metrics_v1_5 *)smu_table->gpu_metrics_table;
+       struct gpu_metrics_v1_6 *gpu_metrics =3D
+               (struct gpu_metrics_v1_6 *)smu_table->gpu_metrics_table;
        struct amdgpu_device *adev =3D smu->adev;
        int ret =3D 0, xcc_id, inst, i, j;
        MetricsTableX_t *metrics_x;
@@ -2193,7 +2193,7 @@ static ssize_t smu_v13_0_6_get_gpu_metrics(struct smu=
_context *smu, void **table

        metrics_a =3D (MetricsTableA_t *)metrics_x;

-       smu_cmn_init_soft_gpu_metrics(gpu_metrics, 1, 5);
+       smu_cmn_init_soft_gpu_metrics(gpu_metrics, 1, 6);

        gpu_metrics->temperature_hotspot =3D
                SMUQ10_ROUND(GET_METRIC_FIELD(MaxSocketTemperature));
@@ -2235,6 +2235,16 @@ static ssize_t smu_v13_0_6_get_gpu_metrics(struct sm=
u_context *smu, void **table

        gpu_metrics->current_uclk =3D SMUQ10_ROUND(GET_METRIC_FIELD(UclkFre=
quency));

+       /* Total accumulated cycle counter */
+       gpu_metrics->accumulation_counter =3D
+GET_METRIC_FIELD(AccumulationCounter);
+
+       /* Accumulated throttler residencies */
+       gpu_metrics->prochot_residency_acc =3D GET_METRIC_FIELD(ProchotResi=
dencyAcc);
+       gpu_metrics->ppt_residency_acc =3D GET_METRIC_FIELD(PptResidencyAcc=
);
+       gpu_metrics->socket_thm_residency_acc =3D GET_METRIC_FIELD(SocketTh=
mResidencyAcc);
+       gpu_metrics->vr_thm_residency_acc =3D GET_METRIC_FIELD(VrThmResiden=
cyAcc);
+       gpu_metrics->hbm_thm_residency_acc =3D
+GET_METRIC_FIELD(HbmThmResidencyAcc);
+
        /* Throttle status is not reported through metrics now */
        gpu_metrics->throttle_status =3D 0;

--
2.42.0

