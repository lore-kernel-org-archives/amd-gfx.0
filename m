Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25B6DF9936B
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Apr 2026 10:57:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B207210F09A;
	Thu, 23 Apr 2026 10:57:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="RCfSGMo1";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010043.outbound.protection.outlook.com [52.101.46.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1BCC510F09A
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Apr 2026 10:57:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ik6xPX+L6BABG0vzp0fRwPsM3Hr51gTB5xr0P1FokgY465ryjFZQnndWYbaDNvTpmnaZ14DWj1vZwn4ZRDgzyvq0v4Shc3hED8cO5ZYyycxCQd0mMgR06Aeq/mhK1icow4lUS8MjUKFLGLPKgqiUxUuSxumARW4z5PEYXD0uZo3DHOsnSGIcK34uSAmTDMOEllngRDcpVluIRjLE8TjUeyA3AkzLYW+EWalXn5aqJ7G60WCKV1Zr8NcEHTBa9HZiJCfFBAdPHWNrNAkBN3Socn7B7k0flMf9tIYFYnndkUW3tyCDRLm0dRqox5uVpc5irQe8PxK8uqpm2ZmHdfi38w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xz2FqVteSKfXip0HrlnRCZsRKgm8KRs6EsyPnVFGSnk=;
 b=dLNa9qrEC9GNpUPqG1oRZRe7BMNC8t33NyXNZLRxiGcda4d4z7a2ROoyRGAJdPZ6oN2wUp3Tbu2eTGA3hC0qUUJ84KHTgP/J6FRUYBoI8fvGvTyg/mZXuLQHQkcnhcp18+5wyTT8X4sT2wo6C+M0sh1mGjE2HNSWmEvj83q0QZYycpmTnKIkf9OxUpjWl/W5P/tBWnpzdV7BJoR4UunAhTK7nzgWuvSBkxNKd6w6bXSD8FKGO70Aytc3i9jId8EmuzEpAd8xatYfj/0VVjA/EyuJ1r7tuVGbGALLytqzI/RdNBCxoyTZmNAAPYEZTA9BouYCKZA9XD3gwK5QKArQ0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xz2FqVteSKfXip0HrlnRCZsRKgm8KRs6EsyPnVFGSnk=;
 b=RCfSGMo1NkCdfrXKTJw+YFU/aksMqYOyA3fqL2fRBzhMHDb6ukJB2lFbR3n2J7QzGTJhgrmGb7a0t3lR5mC4lKvWqbdmJs3zghV4WxHZagu/HJ4DbIXOYXLU0fQ3brayZPvMrr/vNWtmNlaKCxroIGaAo/p/KJVP2g6eBka5r5U=
Received: from DM6PR12MB2972.namprd12.prod.outlook.com (2603:10b6:5:39::31) by
 IA4PR12MB9788.namprd12.prod.outlook.com (2603:10b6:208:5d5::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.21; Thu, 23 Apr
 2026 10:57:22 +0000
Received: from DM6PR12MB2972.namprd12.prod.outlook.com
 ([fe80::574d:7c2d:4d0a:855e]) by DM6PR12MB2972.namprd12.prod.outlook.com
 ([fe80::574d:7c2d:4d0a:855e%6]) with mapi id 15.20.9846.019; Thu, 23 Apr 2026
 10:57:22 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: "Ramalingeswara Reddy, Kanala" <Kanala.RamalingeswaraReddy@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Vishwakarma, Pratik" <Pratik.Vishwakarma@amd.com>, "Guttula, Suresh"
 <Suresh.Guttula@amd.com>
Subject: RE: [PATCH v4 3/3] drm/amdgpu: smu: cache and reuse averaged unified
 metrics values
Thread-Topic: [PATCH v4 3/3] drm/amdgpu: smu: cache and reuse averaged unified
 metrics values
Thread-Index: AQHc0bZR8EGg1WNIK0WajUeq0YrMZrXsesfg
Date: Thu, 23 Apr 2026 10:57:22 +0000
Message-ID: <DM6PR12MB2972941385D26498DB2B1FD2822A2@DM6PR12MB2972.namprd12.prod.outlook.com>
References: <20260421174014.3284999-1-Kanala.RamalingeswaraReddy@amd.com>
 <20260421174014.3284999-3-Kanala.RamalingeswaraReddy@amd.com>
In-Reply-To: <20260421174014.3284999-3-Kanala.RamalingeswaraReddy@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2026-04-23T10:51:12.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB2972:EE_|IA4PR12MB9788:EE_
x-ms-office365-filtering-correlation-id: e9279a36-38ee-4ecf-505f-08dea12718d8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|38070700021|22082099003|18002099003|56012099003;
x-microsoft-antispam-message-info: D8m6uL8kjIs3yjLU3asTRGlxdRPLTZn70iTXiLu5gvs2c8cGEwqn0fDUHLz2XTlWSizkv0Ua7tRjio2Bm29Oe+cSc6mAujYYsmZIm7CP9KmeOzjjxdPCft7uoYiQxFmlTeSDEyiH2vjVaIolEMLxUhaNJj8hORpI98HLeT46+XWr79aDQ5Gn+8dMxXvYVaoNXJ2ecnghgrqf4D1qY4GNGMhH0WSdvV/zK0g4lPKuK6Zt8aL6Ug8nYiwf1BXxkI7DJwylpTzMOyavTJgtIgBrVG2dgOzFSjGlAU+muEb0yDpkkZmCfm19Bv0sZSPwQiQ4hRWWi3/NLzI4yhyhyMLl7MWuNC0IonnaIq7aFo8wMeYrcoijjUNf18cpoRWyOsYuNTbHLzfymvQNo6yRCdkaUtTijVsS8JLh8vnjperVDoZhBtFugveyC8sytP289NkUmufbOdDE9nRsNaZTj7G4ewKnRB0LcDFYhrbp/7VI1m1bWVLmm7CjZJvXFXNHvXKzvsSKWqD5tIXI/0BaXc6+mbpemaxIxqFYBnUPbwRJN0aFJvtVurqgQZ1Hvg1grjkYY5ydWgUyy7H0hkyAHjrSPEtpGiY7V8teQ32Qvs4bGEyjnPKaD0ubTny+RJ8VVffLPr2krXo50jpHhPaoSB3NyEM8T3mDXan3J+7R9kPYCIbx3FtsO584Jv7TCjCYc96kaijkHJf2c5WWMjp2ZZqvmXZWJ+u5cyM1cfV2orOIUdZdbPuhDd4HuueknD7UhVbFBzk7hoAf6s86h5Q06yV6pQCJHSA8lxrxKdLuxcTfyXo=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2972.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700021)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?nSviZ+OI4dGtZI5PsHQddr4jCWYoDli784xNNYGKsP183ItIPWshBKqY5BvE?=
 =?us-ascii?Q?bFizaGJY6vjoZKfBCHOTsZu5ZYPztHO7C0ywzqzSvOlTUM2ObECqs+97KKa1?=
 =?us-ascii?Q?JXMqN6H0e5zhif/KmYcmf7Ic1QSvdLHe74m8pRckMX9wl/B++4R0V0q43kfS?=
 =?us-ascii?Q?c93s+1hyb7PIt6em9j39G3LutnEstxFSViovif8bOx6b4HrIMpIOUFJL5w4y?=
 =?us-ascii?Q?8a+/oobUj6jxDL4ebTuFQA9QchCtnjCFwBI5IMtJOnV9Jy9ea/409pBiV1TL?=
 =?us-ascii?Q?ytb/2OD+UmVt6p+kFIiVXfMNR9G+NGCv5ZMTXd7EZVtNWtkx+8qnEhYylBxo?=
 =?us-ascii?Q?eVveb3tzljq9mPBau9J1bHjLkwmrfpzuakm53T7qDaaTDSdNUJ5zCzuLbNQv?=
 =?us-ascii?Q?Rotto1aCAfRFigwsa47WV+xxtEjq3LkcAz1d6PZ4+j720+G70/23GB0okCpa?=
 =?us-ascii?Q?gl46KhSnRlzpcNfKQgmXWnCKb/6AOKdBIq5qqaGjdY2l00jmB1yenlOBArLq?=
 =?us-ascii?Q?rKfdQOElrOedBwenXUBNSjg7KvaKbwNtz40Z7hH4MOg21uG8n/Oa03g31EwM?=
 =?us-ascii?Q?PcItQnZxl7hR5/3lzpzWt0J9cpLV2mhIp9r3rNM00jfoD3ZMYjgpoX4WGBCg?=
 =?us-ascii?Q?TgzkjZmmCWaUqdkGo3roM7YCfDQGy29gk7mbApRgyXqZVItP4cKTmTDor346?=
 =?us-ascii?Q?kRO4DUfRxdtise6nHuV6zczy+iYFhL6Ej96DkTzw1HBc1b1JPnPWOKauAodj?=
 =?us-ascii?Q?WUewSAVzhRK0asaLmY/9S0GeidIYFdar/C8JeN/WCCsI7kxm7TFWvVOGXjYD?=
 =?us-ascii?Q?JDhfB7Xyj17hybIS22jCR+Fqkk9oXLdPh+smbdsGufJ//Ru8yvzGJZ8ipThM?=
 =?us-ascii?Q?EyIu+exilY7/apqF+N5y1VQEh6UuuRdxlK31IqK2i7FgKhmZWpufUew0XoEB?=
 =?us-ascii?Q?JDEW0TU8S/tamjXlZ6ZldB+H1F6R0R8pZ3C41brNq3wk6VC0LHdgsaO6SfyE?=
 =?us-ascii?Q?rk+3upuxdOj2T9Gt7Jrlg1uHT4R9DIEwBBdrHVQp3nBARLVoCM6V8ASmpgzX?=
 =?us-ascii?Q?eXexdHKuTD6bZwsH3+1qhmZrCRmABqqmos4PaHzPlTxFlBLd46Mum4bLOiFY?=
 =?us-ascii?Q?dipYDvrpq53KPcoVnpbAANOB+elCakksiqlm2S9dGg9YL0vLmO1aIBGjbEgH?=
 =?us-ascii?Q?KFFcSg0+p1LKc+6eqXIPz/QcJUiQCeL3wuAO6988reLZ6FVWqX8P6Y+QPz5D?=
 =?us-ascii?Q?Rx7LmeDyDx3s8ZU1s6DPdAEFokBK5kdJ2k0adeVkdXJ0cZ1uCjGGXbEQCdcI?=
 =?us-ascii?Q?83GMiog62G41G6BJi5AI12GaJrfSF1quHMtKGf9cl7VCn8b3dPXePbtCypjg?=
 =?us-ascii?Q?sxTKjdEbddcrZW7nBgOIEShAq464DGfIh4bcaAcbrff6f2cH3Tu1s+38IRM9?=
 =?us-ascii?Q?DWMFP2jhzM9hQQyLK/BZOWExG4xlxNFtK2OsPGkNjgHco4Jb7t1C4mZcMH8y?=
 =?us-ascii?Q?W6mnu87tKh6R2Ga4RzwI6TZJUp2zj5DeFVDHGmYngiF4xlhl5zdPJiZVoRW2?=
 =?us-ascii?Q?cyvKMAKZDwC9GTaLuDt1x/Hap2ko8EOmn6aHVDMFgRgQJng2fx/n2Xf31OmY?=
 =?us-ascii?Q?DocutSHBS6Xt/DdOt1YOSDF2FNLQV3sxVBiAZKlZi2aIuoPbmOtKRF6PXrLg?=
 =?us-ascii?Q?pWwQBJlPYX45ihh1lAuWLU/fANBPXJSsoXo26ehIvBJE9MIT?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2972.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9279a36-38ee-4ecf-505f-08dea12718d8
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2026 10:57:22.5410 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eSvXRBbpmXpKsXZQK7NzZOgHYv2FRMNf6qluYP6nL/LCcPsgNAaAoc0ASrXIZM0U
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR12MB9788
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

I suspect you've run into a known issue: reading the metrics table too freq=
uently within an extremely short period causes PMFW to become unresponsive.
The SMU driver already has a similar implementation, could you refer to its=
 API and usage cases to see if they help with the issue you're facing?
Btw, the SMU driver should retain identical internal processing logic to fa=
cilitate future code maintenance and optimization.

Ref: smu_cmn_get_metrics_table()

Best Regards,
Kevin

-----Original Message-----
From: Ramalingeswara Reddy, Kanala <Kanala.RamalingeswaraReddy@amd.com>
Sent: Wednesday, April 22, 2026 01:40
To: Deucher, Alexander <Alexander.Deucher@amd.com>; amd-gfx@lists.freedeskt=
op.org; Vishwakarma, Pratik <Pratik.Vishwakarma@amd.com>; Guttula, Suresh <=
Suresh.Guttula@amd.com>; Wang, Yang(Kevin) <KevinYang.Wang@amd.com>
Cc: Ramalingeswara Reddy, Kanala <Kanala.RamalingeswaraReddy@amd.com>
Subject: [PATCH v4 3/3] drm/amdgpu: smu: cache and reuse averaged unified m=
etrics values

Compute averaged metrics from accumulated SMU values and store them in a lo=
cal cache. If the metrics accumulation counter has not changed, return the =
previously cached metrics instead of recalculating them.

Signed-off-by: Ramalingeswara Reddy, Kanala <Kanala.RamalingeswaraReddy@amd=
.com>
---
 .../drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c  | 169 +++++++++++-------
 .../drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.h  |   9 +
 2 files changed, 115 insertions(+), 63 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c
index f2549754e8e9..6635177881e8 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c
@@ -173,10 +173,10 @@ static int smu_v15_0_0_init_smc_tables(struct smu_con=
text *smu)
                PAGE_SIZE, AMDGPU_GEM_DOMAIN_VRAM);
        SMU_TABLE_INIT(tables, SMU_TABLE_DPMCLOCKS, sizeof(DpmClocks_t),
                PAGE_SIZE, AMDGPU_GEM_DOMAIN_VRAM);
-       SMU_TABLE_INIT(tables, SMU_TABLE_SMU_METRICS, sizeof(SMU_15_0_0_Met=
ricsTable_t),
+       SMU_TABLE_INIT(tables, SMU_TABLE_SMU_METRICS,
+sizeof(SMU_15_0_0_MetricsInfo_t),
                PAGE_SIZE, AMDGPU_GEM_DOMAIN_VRAM);

-       smu_table->metrics_table =3D kzalloc(sizeof(SMU_15_0_0_MetricsTable=
_t), GFP_KERNEL);
+       smu_table->metrics_table =3D kzalloc(sizeof(SMU_15_0_0_MetricsInfo_=
t),
+GFP_KERNEL);
        if (!smu_table->metrics_table)
                goto err0_out;
        smu_table->metrics_time =3D 0;
@@ -334,16 +334,13 @@ static int smu_v15_0_0_get_gpu_metrics_table(struct s=
mu_context *smu,


 static int smu_v15_0_0_get_metrics_table(struct smu_context *smu,
-                                       SMU_15_0_0_MetricsTable_t *metrics)
+                                       SMU_15_0_0_MetricsInfo_t *metrics_i=
nfo)
 {
        void __iomem *cpu_addr =3D NULL;
        struct smu_msg_ctl *ctl =3D &smu->msg_ctl;
        struct smu_msg_args args =3D {0};
-       /* store table_size and DramAddr value returned by SMU in static at=
 first request,
-        * use these valuse to read LogSample in case of later requests
-        */
-       static int table_size;
-       static uint64_t addr;
+       int table_size =3D metrics_info->table_size;
+       uint64_t addr =3D metrics_info->addr;
        int ret;

        if (addr =3D=3D 0) {
@@ -360,6 +357,8 @@ static int smu_v15_0_0_get_metrics_table(struct smu_con=
text *smu,

                addr =3D ((uint64_t)args.out_args[1] << 32) | args.out_args=
[0];
                table_size =3D args.out_args[2];
+               metrics_info->addr =3D addr;
+               metrics_info->table_size =3D table_size;
        }

        cpu_addr =3D ioremap_wc(addr, table_size); @@ -374,9 +373,9 @@ stat=
ic int smu_v15_0_0_get_metrics_table(struct smu_context *smu,
        if (!ret) {
                amdgpu_hdp_invalidate(smu->adev, NULL);//best to flush befo=
re copy
                if (table_size <=3D sizeof(SMU_15_0_0_MetricsTable_t))
-                       memcpy(metrics, cpu_addr, table_size);
+                       memcpy(&metrics_info->metrics, cpu_addr, table_size=
);
                else
-                       memcpy(metrics, cpu_addr, sizeof(SMU_15_0_0_Metrics=
Table_t));
+                       memcpy(&metrics_info->metrics, cpu_addr,
+sizeof(SMU_15_0_0_MetricsTable_t));
        }
        iounmap(cpu_addr);
        return ret;
@@ -396,134 +395,173 @@ static int smu_v15_0_0_get_smu_metrics_data(struct =
smu_context *smu,
        struct smu_table_context *smu_table =3D &smu->smu_table;
        SmuMetrics_t *metrics =3D (SmuMetrics_t *)smu_table->metrics_table;=
 //TBD

-       SMU_15_0_0_MetricsTable_t prev_metrics;
+       SMU_15_0_0_MetricsInfo_t *prev_metrics;
+       SMU_15_0_0_MetricsInfo_t *curr_metrics;
        uint64_t counter, val;
        int ret;

-       memcpy(&prev_metrics, smu_table->metrics_table,
-                       sizeof(SMU_15_0_0_MetricsTable_t));
+       prev_metrics =3D kzalloc(sizeof(SMU_15_0_0_MetricsInfo_t), GFP_KERN=
EL);
+       if (!prev_metrics)
+               return -ENOMEM;
+
+       memcpy(prev_metrics, smu_table->metrics_table,
+                       sizeof(SMU_15_0_0_MetricsInfo_t));
        ret =3D smu_v15_0_0_get_metrics_table(smu,
-                       (SMU_15_0_0_MetricsTable_t *)smu_table->metrics_tab=
le);
+                       (SMU_15_0_0_MetricsInfo_t *)smu_table->metrics_tabl=
e);
        if (ret)
                return ret;

+       curr_metrics =3D (SMU_15_0_0_MetricsInfo_t *)smu_table->metrics_tab=
le;
+
+       if (prev_metrics->metrics.IOD.AccumulationCounter =3D=3D
+               curr_metrics->metrics.IOD.AccumulationCounter) {
+               *value =3D prev_metrics->avg_metric[member];
+               kfree(prev_metrics);
+               return 0;
+       }
+
        switch (member) {
        case METRICS_AVERAGE_GFXCLK:
-               counter =3D get_diff_count(prev_metrics.IOD.AccumulationCou=
nter,
-                ((SMU_15_0_0_MetricsTable_t *)smu_table->metrics_table)->I=
OD.AccumulationCounter);
-               val =3D get_diff_val(prev_metrics.IOD.GfxclkFreqEffAcc,
-                ((SMU_15_0_0_MetricsTable_t *)smu_table->metrics_table)->I=
OD.GfxclkFreqEffAcc);
+               counter =3D get_diff_count(prev_metrics->metrics.IOD.Accumu=
lationCounter,
+                               curr_metrics->metrics.IOD.AccumulationCount=
er);
+               val =3D get_diff_val(prev_metrics->metrics.IOD.GfxclkFreqEf=
fAcc,
+                               curr_metrics->metrics.IOD.GfxclkFreqEffAcc)=
;
                *value =3D counter ? (val/counter)/1024 : 0;
+               curr_metrics->avg_metric[member] =3D *value;
                break;
        case METRICS_AVERAGE_SOCCLK:
-               counter =3D get_diff_count(prev_metrics.IOD.AccumulationCou=
nter,
-                ((SMU_15_0_0_MetricsTable_t *)smu_table->metrics_table)->I=
OD.AccumulationCounter);
-               val =3D get_diff_val(prev_metrics.IOD.SocclkFreqEffAcc,
-                ((SMU_15_0_0_MetricsTable_t *)smu_table->metrics_table)->I=
OD.SocclkFreqEffAcc);
+               counter =3D get_diff_count(prev_metrics->metrics.IOD.Accumu=
lationCounter,
+                               curr_metrics->metrics.IOD.AccumulationCount=
er);
+               val =3D get_diff_val(prev_metrics->metrics.IOD.SocclkFreqEf=
fAcc,
+                               curr_metrics->metrics.IOD.SocclkFreqEffAcc)=
;
                *value =3D counter ? (val/counter)/1024 : 0;
+               curr_metrics->avg_metric[member] =3D *value;
                break;
        case METRICS_AVERAGE_VCLK:
-               counter =3D get_diff_count(prev_metrics.IOD.AccumulationCou=
nter,
-                ((SMU_15_0_0_MetricsTable_t *)smu_table->metrics_table)->I=
OD.AccumulationCounter);
-               val =3D get_diff_val(prev_metrics.IOD.VclkFreqEffAcc,
-                ((SMU_15_0_0_MetricsTable_t *)smu_table->metrics_table)->I=
OD.VclkFreqEffAcc);
+               counter =3D get_diff_count(prev_metrics->metrics.IOD.Accumu=
lationCounter,
+                               curr_metrics->metrics.IOD.AccumulationCount=
er);
+               val =3D get_diff_val(prev_metrics->metrics.IOD.VclkFreqEffA=
cc,
+                               curr_metrics->metrics.IOD.VclkFreqEffAcc);
                *value =3D counter ? (val/counter)/1024 : 0;
+               curr_metrics->avg_metric[member] =3D *value;
                break;
        case METRICS_AVERAGE_DCLK:
                *value =3D 0;
+               curr_metrics->avg_metric[member] =3D *value;
                break;
        case METRICS_AVERAGE_UCLK:
-               counter =3D get_diff_count(prev_metrics.IOD.AccumulationCou=
nter,
-                ((SMU_15_0_0_MetricsTable_t *)smu_table->metrics_table)->I=
OD.AccumulationCounter);
-               val =3D get_diff_val(prev_metrics.IOD.MemclkFreqEffAcc,
-                ((SMU_15_0_0_MetricsTable_t *)smu_table->metrics_table)->I=
OD.MemclkFreqEffAcc);
+               counter =3D get_diff_count(prev_metrics->metrics.IOD.Accumu=
lationCounter,
+                               curr_metrics->metrics.IOD.AccumulationCount=
er);
+               val =3D get_diff_val(prev_metrics->metrics.IOD.MemclkFreqEf=
fAcc,
+                               curr_metrics->metrics.IOD.MemclkFreqEffAcc)=
;
                *value =3D counter ? (val/counter)/1024 : 0;
+               curr_metrics->avg_metric[member] =3D *value;
                break;
        case METRICS_AVERAGE_FCLK:
-               counter =3D get_diff_count(prev_metrics.IOD.AccumulationCou=
nter,
-                ((SMU_15_0_0_MetricsTable_t *)smu_table->metrics_table)->I=
OD.AccumulationCounter);
-               val =3D get_diff_val(prev_metrics.IOD.FclkFreqEffAcc,
-                ((SMU_15_0_0_MetricsTable_t *)smu_table->metrics_table)->I=
OD.FclkFreqEffAcc);
+               counter =3D get_diff_count(prev_metrics->metrics.IOD.Accumu=
lationCounter,
+                               curr_metrics->metrics.IOD.AccumulationCount=
er);
+               val =3D get_diff_val(prev_metrics->metrics.IOD.FclkFreqEffA=
cc,
+                               curr_metrics->metrics.IOD.FclkFreqEffAcc);
                *value =3D counter ? (val/counter)/1024 : 0;
+               curr_metrics->avg_metric[member] =3D *value;
                break;
        case METRICS_AVERAGE_VPECLK:
                *value =3D metrics->VpeclkFrequency;
+               curr_metrics->avg_metric[member] =3D *value;
                break;
        case METRICS_AVERAGE_NPUCLK:
-               counter =3D get_diff_count(prev_metrics.IOD.AccumulationCou=
nter,
-                ((SMU_15_0_0_MetricsTable_t *)smu_table->metrics_table)->I=
OD.AccumulationCounter);
-               val =3D get_diff_val(prev_metrics.IOD.NpuhclkFreqEffAcc,
-                ((SMU_15_0_0_MetricsTable_t *)smu_table->metrics_table)->I=
OD.NpuhclkFreqEffAcc);
+               counter =3D get_diff_count(prev_metrics->metrics.IOD.Accumu=
lationCounter,
+                               curr_metrics->metrics.IOD.AccumulationCount=
er);
+               val =3D get_diff_val(prev_metrics->metrics.IOD.NpuhclkFreqE=
ffAcc,
+                               curr_metrics->metrics.IOD.NpuhclkFreqEffAcc=
);
                *value =3D counter ? (val/counter)/1024 : 0;
+               curr_metrics->avg_metric[member] =3D *value;
                break;
        case METRICS_AVERAGE_GFXACTIVITY:
-               counter =3D get_diff_count(prev_metrics.IOD.AccumulationCou=
nter,
-                ((SMU_15_0_0_MetricsTable_t *)smu_table->metrics_table)->I=
OD.AccumulationCounter);
-               val =3D get_diff_val(prev_metrics.IOD.GfxBusyAcc,
-                ((SMU_15_0_0_MetricsTable_t *)smu_table->metrics_table)->I=
OD.GfxBusyAcc);
+               counter =3D get_diff_count(prev_metrics->metrics.IOD.Accumu=
lationCounter,
+                               curr_metrics->metrics.IOD.AccumulationCount=
er);
+               val =3D get_diff_val(prev_metrics->metrics.IOD.GfxBusyAcc,
+                               curr_metrics->metrics.IOD.GfxBusyAcc);
                *value =3D counter ? (val/counter)/1024 : 0;
+               curr_metrics->avg_metric[member] =3D *value;
                break;
        case METRICS_AVERAGE_VCNACTIVITY:
-               counter =3D get_diff_count(prev_metrics.IOD.AccumulationCou=
nter,
-                ((SMU_15_0_0_MetricsTable_t *)smu_table->metrics_table)->I=
OD.AccumulationCounter);
-               val =3D get_diff_val(prev_metrics.IOD.VcnBusyAcc,
-                ((SMU_15_0_0_MetricsTable_t *)smu_table->metrics_table)->I=
OD.VcnBusyAcc);
+               counter =3D get_diff_count(prev_metrics->metrics.IOD.Accumu=
lationCounter,
+                               curr_metrics->metrics.IOD.AccumulationCount=
er);
+               val =3D get_diff_val(prev_metrics->metrics.IOD.VcnBusyAcc,
+                               curr_metrics->metrics.IOD.VcnBusyAcc);
                *value =3D counter ? (val/counter)/1024 : 0;
+               curr_metrics->avg_metric[member] =3D *value;
                break;
        case METRICS_AVERAGE_SOCKETPOWER:
-               counter =3D get_diff_count(prev_metrics.IOD.AccumulationCou=
nter,
-                ((SMU_15_0_0_MetricsTable_t *)smu_table->metrics_table)->I=
OD.AccumulationCounter);
-               val =3D get_diff_val(prev_metrics.IOD.ApuPowerAcc,
-                ((SMU_15_0_0_MetricsTable_t *)smu_table->metrics_table)->I=
OD.ApuPowerAcc);
+               counter =3D get_diff_count(prev_metrics->metrics.IOD.Accumu=
lationCounter,
+                               curr_metrics->metrics.IOD.AccumulationCount=
er);
+               val =3D get_diff_val(prev_metrics->metrics.IOD.ApuPowerAcc,
+                               curr_metrics->metrics.IOD.ApuPowerAcc);
                *value =3D counter ? (val/counter)/1024 : 0;
+               curr_metrics->avg_metric[member] =3D *value;
+               break;
        case METRICS_CURR_SOCKETPOWER:
-               counter =3D get_diff_count(prev_metrics.IOD.AccumulationCou=
nter,
-                ((SMU_15_0_0_MetricsTable_t *)smu_table->metrics_table)->I=
OD.AccumulationCounter);
-               val =3D get_diff_val(prev_metrics.IOD.SystemPowerAcc,
-                ((SMU_15_0_0_MetricsTable_t *)smu_table->metrics_table)->I=
OD.SystemPowerAcc);
+               counter =3D get_diff_count(prev_metrics->metrics.IOD.Accumu=
lationCounter,
+                               curr_metrics->metrics.IOD.AccumulationCount=
er);
+               val =3D get_diff_val(prev_metrics->metrics.IOD.SystemPowerA=
cc,
+                               curr_metrics->metrics.IOD.SystemPowerAcc);
                *value =3D counter ? (val/counter)/1024 : 0;
+               curr_metrics->avg_metric[member] =3D *value;
                break;
        case METRICS_TEMPERATURE_EDGE:
-               counter =3D get_diff_count(prev_metrics.IOD.AccumulationCou=
nter,
-                ((SMU_15_0_0_MetricsTable_t *)smu_table->metrics_table)->I=
OD.AccumulationCounter);
-               val =3D get_diff_val(prev_metrics.IOD.GFX_TempAcc,
-                ((SMU_15_0_0_MetricsTable_t *)smu_table->metrics_table)->I=
OD.GFX_TempAcc);
-               *value =3D counter ? (val/counter)/1024 : 0;
+               counter =3D get_diff_count(prev_metrics->metrics.IOD.Accumu=
lationCounter,
+                               curr_metrics->metrics.IOD.AccumulationCount=
er);
+               val =3D get_diff_val(prev_metrics->metrics.IOD.GFX_TempAcc,
+                               curr_metrics->metrics.IOD.GFX_TempAcc);
+               *value =3D counter ? (val/counter) : 0;
+               curr_metrics->avg_metric[member] =3D *value;
                break;
        case METRICS_TEMPERATURE_HOTSPOT:
                *value =3D metrics->SocTemperature / 100 *
                SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
+               curr_metrics->avg_metric[member] =3D *value;
                break;
        case METRICS_THROTTLER_RESIDENCY_PROCHOT:
                *value =3D metrics->ThrottleResidency_PROCHOT;
+               curr_metrics->avg_metric[member] =3D *value;
                break;
        case METRICS_THROTTLER_RESIDENCY_SPL:
                *value =3D metrics->ThrottleResidency_SPL;
+               curr_metrics->avg_metric[member] =3D *value;
                break;
        case METRICS_THROTTLER_RESIDENCY_FPPT:
                *value =3D metrics->ThrottleResidency_FPPT;
+               curr_metrics->avg_metric[member] =3D *value;
                break;
        case METRICS_THROTTLER_RESIDENCY_SPPT:
                *value =3D metrics->ThrottleResidency_SPPT;
+               curr_metrics->avg_metric[member] =3D *value;
                break;
        case METRICS_THROTTLER_RESIDENCY_THM_SOC:
                *value =3D metrics->ThrottleResidency_THM_SOC;
+               curr_metrics->avg_metric[member] =3D *value;
                break;
        case METRICS_VOLTAGE_VDDGFX:
                *value =3D 0;
+               curr_metrics->avg_metric[member] =3D *value;
                break;
        case METRICS_VOLTAGE_VDDSOC:
                *value =3D 0;
+               curr_metrics->avg_metric[member] =3D *value;
                break;
        case METRICS_SS_APU_SHARE:
                /* return the percentage of APU power with respect to APU's=
 power limit.
                 * percentage is reported, this isn't boost value. Smartshi=
ft power
                 * boost/shift is only when the percentage is more than 100=
.
                 */
-               if (metrics->StapmOpnLimit > 0)
+               if (metrics->StapmOpnLimit > 0) {
                        *value =3D (metrics->ApuPower * 100) / metrics->Sta=
pmOpnLimit;
-               else
+                       curr_metrics->avg_metric[member] =3D *value;
+               } else {
                        *value =3D 0;
+                       curr_metrics->avg_metric[member] =3D *value;
+               }
                break;
        case METRICS_SS_DGPU_SHARE:
                /* return the percentage of dGPU power with respect to dGPU=
's power limit.
@@ -531,17 +569,22 @@ static int smu_v15_0_0_get_smu_metrics_data(struct sm=
u_context *smu,
                 * boost/shift is only when the percentage is more than 100=
.
                 */
                if ((metrics->dGpuPower > 0) &&
-                   (metrics->StapmCurrentLimit > metrics->StapmOpnLimit))
+                   (metrics->StapmCurrentLimit > metrics->StapmOpnLimit)) =
{
                        *value =3D (metrics->dGpuPower * 100) /
                                 (metrics->StapmCurrentLimit - metrics->Sta=
pmOpnLimit);
-               else
+                       curr_metrics->avg_metric[member] =3D *value;
+               } else {
                        *value =3D 0;
+                       curr_metrics->avg_metric[member] =3D *value;
+               }
                break;
        default:
                *value =3D UINT_MAX;
+               curr_metrics->avg_metric[member] =3D *value;
                break;
        }

+       kfree(prev_metrics);
        return ret;
 }

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.h b/drivers=
/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.h
index 592bb0f8ee96..d4708ad23bcd 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.h
@@ -23,6 +23,8 @@
 #ifndef __SMU_V15_0_0_PPT_H__
 #define __SMU_V15_0_0_PPT_H__

+#include "amdgpu_smu.h"
+
 #define MAX_UINT32 0x00000000FFFFFFFF
 #define MAX_UINT64 0xFFFFFFFFFFFFFFFF
 #pragma pack(push, 1)
@@ -220,6 +222,13 @@ typedef struct {
 } SMU_15_0_0_MetricsTable_t;


+typedef struct {
+       SMU_15_0_0_MetricsTable_t metrics;
+       uint32_t table_size;
+       uint64_t addr;
+       uint32_t avg_metric[METRICS_AVERAGE_NPUCLK+1];
+} SMU_15_0_0_MetricsInfo_t;
+
 extern void smu_v15_0_0_set_ppt_funcs(struct smu_context *smu);

 #endif
--
2.53.0

