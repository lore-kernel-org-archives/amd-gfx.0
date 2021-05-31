Return-Path: <SRS0=CFk9=K2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2361C4708F
	for <amd-gfx@archiver.kernel.org>; Mon, 31 May 2021 05:12:44 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A41461108
	for <amd-gfx@archiver.kernel.org>; Mon, 31 May 2021 05:12:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A41461108
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E2E7D6E484;
	Mon, 31 May 2021 05:12:43 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2069.outbound.protection.outlook.com [40.107.236.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4A42A6E484
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 May 2021 05:12:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zn6kzre5eiIugnZ+W5XhCFNl8xQOyiZYrz1WOoevUq8JfHWF6zk4AAD27S559ECzpjGUhkmLJa0/JWW476gEZ4RMGGYmJXea2VmkAiSwIWfB867FBPQrqET5I4NpbStodixSkuLLfhvo54IRZVZdQwKtUcCYMKBmU90N2usGrflFVb8I4LMiJQj8YS3hpJlN1IxiPhAS9A1SAbmetiuL00PsMwCOUP+bFreNXXz8VFNdKA/QbA5Sg//SEcY30xO8CeU/BTmyasKtIZ7n5vpSdfHYefdV4N6AJrq5RxZdZ5HUHj/8guXOpGSm1q3av37O62UyYatrPaMP6fEnvf1dzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ckHNCezCTDAkcss4X9Byh137MnFbIIII/iC7/80xVLI=;
 b=Dq+bS/BQ8C8vEbMRDyqixBn63mCVBETS+alTGfX3YS6ZLR6jQsvnxdDacf5cxNXl1YrxQMziAkr4ohWo2+pc3Vdx/rNFT2YeN0y9nkOhvVa545EcGwaaD8GvubNTahrLhHIBsKiBRKJsIRo0yNBW1TjUZWG9tki9XI2WEqvjgRvHmh1yNhGCFB9xROU/5Cc/9XZih/XzuZJOZbffEAImcCTsOA+rVa0Lk7BQOXqN6xp9tnORCw1z1kkBRAFMHUXjLG/CniSU/viS5dhshJX3YjAz3bNxYmGNMTyDMWDeIcmUZOc42UJUTFi/1CtdxH7KgMEPBxHagcBKOT8IreKW/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ckHNCezCTDAkcss4X9Byh137MnFbIIII/iC7/80xVLI=;
 b=Wx0P2MxLw8VA82gJtf5oSTEhtBFsV4C+ZqJ1lJo/gTFlkZAYy61NXZZNQ0q+rznVWFAz86bxckW6fIXM0La28IkeQlS6Z91ty1M4gtuE0eA66UYt8F7qH4wMhl3omsne3PFFmi6ad/NIFrOZ5qJ+5xhAnSAA2JfrDkCIAAUFh58=
Received: from CH0PR12MB5348.namprd12.prod.outlook.com (2603:10b6:610:d7::9)
 by CH2PR12MB5561.namprd12.prod.outlook.com (2603:10b6:610:69::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20; Mon, 31 May
 2021 05:12:37 +0000
Received: from CH0PR12MB5348.namprd12.prod.outlook.com
 ([fe80::9c3:508d:5340:8efd]) by CH0PR12MB5348.namprd12.prod.outlook.com
 ([fe80::9c3:508d:5340:8efd%6]) with mapi id 15.20.4173.030; Mon, 31 May 2021
 05:12:37 +0000
From: "Lazar, Lijo" <Lijo.Lazar@amd.com>
To: "Sider, Graham" <Graham.Sider@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH v2 4/8] drm/amd/pm: Add navi1x throttler translation
Thread-Topic: [PATCH v2 4/8] drm/amd/pm: Add navi1x throttler translation
Thread-Index: AQHXU/w+qR+FgJIYYkaHye819fhn6ar9BaPQ
Date: Mon, 31 May 2021 05:12:37 +0000
Message-ID: <CH0PR12MB53482CA6E88715706506E2B8973F9@CH0PR12MB5348.namprd12.prod.outlook.com>
References: <20210528195815.2615-1-Graham.Sider@amd.com>
 <20210528195815.2615-4-Graham.Sider@amd.com>
In-Reply-To: <20210528195815.2615-4-Graham.Sider@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-05-31T05:12:33Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=a6d7f43e-15e2-4042-bb02-393a2395573c;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [59.97.59.203]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 916e25ea-9c1b-43c1-74dd-08d923f2b4e6
x-ms-traffictypediagnostic: CH2PR12MB5561:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH2PR12MB556190E1592E929B352EF7A3973F9@CH2PR12MB5561.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1148;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9I8oHDgWB54HOR+OS55ArkVdGseW/U3585u+tkNu/r4V/s77EXDQIkoW7jKMpYLItmYKAWcXlongXotyUMescJweUi3DWOAH0Lj1usWdBRjJH+zLgCDm0P6hnQBzPrN6Hw/B8q/SQWtOmkdTldJNwMh/C9wYaKpLsUBcmFcG0Dg4TaGdsgh6o+T7+kxYb+GGxhXYGExo+xFrPIvGcujRYrHDi952OkIyhGgiDBxzE4fHgkdpsNpq8/ApWz84a+9MAHR9hLHHUM2wkWTJkxWSaBa2cpYcYxutN7gNRFhSTfMWFb48h/sdn0OzgXfBmv+U+wKnK99BZjBqz/e+XGd0Ft86tXlqtui0Cz5dxY49WbpOKTW/bVRHfFSKLvP4pvRAGQ1upDQLuyTzVlJS5akMyNB8nc2+72it/JS5yQ8QEW/tG+Z21z+GleZaSzoA4RCX1+ZtTFf19Sa4eAmgJTolZsNRY+slc28X2+tgubYxTnbt88guh9OH7PrRIJ0Vo7GCmxupqgioWDjNatr8tXMC8UZxWzBF7Aow9UXHg243YcYsNrIvx1zqiXOXj2jEMkBg4Uz92Sks9tDd0j9RBqF1cXATD3ZLT34H+baEWZFcTb3XCF1+IwoytHIC0eyWswRyChv29UOQkkzOsXKiiwYb89h6I16qI2NjOgLFNcPdF2CXTjIIn/csG45rg7jg5XpqX+n7R3TVtpIdsMjMDAkxHQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5348.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(346002)(136003)(366004)(376002)(39860400002)(122000001)(38100700002)(55016002)(110136005)(33656002)(54906003)(186003)(5660300002)(45080400002)(966005)(66446008)(52536014)(4326008)(316002)(478600001)(64756008)(66556008)(76116006)(53546011)(66476007)(66946007)(8936002)(86362001)(9686003)(2906002)(26005)(8676002)(83380400001)(7696005)(71200400001)(6506007)(32563001)(357404004);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?+RmShXAfbKkOEsExa9tJhS9oMPQ0HVkY+IKOugpx2sKj3aUZehy9il3FbDdF?=
 =?us-ascii?Q?pkCKODbNnIDXs2cHQvsK8eqaBG9FZDKpuCFyuLbZfp/+xFGPHd++WKHxIFhB?=
 =?us-ascii?Q?03di1l/2HNfl4ERkyo6ixDlFHqM3K2N/XfV1JvHXELd5Bmf+2N3DwC4ZC7B5?=
 =?us-ascii?Q?hXkZyVFTflM/r0LDE0MnvNmGk3uyl/tvRPkbJrX69v4zQ98XOwOgTU3mfhx7?=
 =?us-ascii?Q?COubAweAKFLh3IFfTMbu7O78D5KQBO7HhykE43twWDllHKGI7H8R209qoyCj?=
 =?us-ascii?Q?vKhwDJLigpV6TzIZ6uhf6sDKGAOqmM+gZv+Kk0x2cHgvDRTND04yfmRK9QR1?=
 =?us-ascii?Q?hlpOYsXP4bciDWinHNJePOY+h9NqFKUx7eRRsvfPLDRkdqVuzQrN4tHa4sqY?=
 =?us-ascii?Q?1pCqBvC0TV4pdwaBvuoypF8eclFlrlridAWUHtcbb6rTMQ+fe2cx6G6AJ5yG?=
 =?us-ascii?Q?80xzwmDOefsQypbiQOWNcD8ZcdNf8yNaniuha2Xv5k9vvWcR6doPpPC5DedB?=
 =?us-ascii?Q?cODs1GhZHn07kDOg2t8wvWuCNjtu+jx6Ziz+7jvY2LahVZwC6hEztN620rjw?=
 =?us-ascii?Q?4gbI31C6YBvue+KY7tFyFmHkJy8xanryxfrhwBGgEaGIf0j3Ale8EaC73lZ8?=
 =?us-ascii?Q?cLnIgy8JHKO6QhKY0TE8vHebGXlLvKhShc0x8MiHtW+Z2wQDfy7ndUB8DHAN?=
 =?us-ascii?Q?jT52eA9UqrJQediVYH5DHwRrZO0APsH6JnrybdX1kx3f2L23Hd3PmGtkV/ST?=
 =?us-ascii?Q?bYV66k8BbuF0QAQ3I+ZIdUnx3K8JOhKnsCJdja0oqtK8dOyiRbkMTisM464C?=
 =?us-ascii?Q?cEYB816q1ALEc57psW1KbVjmPyJOY4VTO9wdx0CkkBUx6PpWvUN0EUNrv8sL?=
 =?us-ascii?Q?NGZz5bR42L2DY3N6qeiXD8MJ35s0VNdYci5ok9fQCDOVUC5KWq4gvi/GOo2y?=
 =?us-ascii?Q?PWMNNyeJReldd2U9cvxmFlJxJ0TX6zfTf39M8Bkmn24bTu6jjxZ9XxJmqJ4i?=
 =?us-ascii?Q?s2Dkc8mj1fnEUyZVwN+C1FOnia3bO5WI6ewdVCd8bSa81A0sJeKFossBmVO2?=
 =?us-ascii?Q?vHCc2NNipDxXs9dyFCVFz4U67h+wmnn4rxGMZuFqI5Z5blZ254NV2jUtdK9t?=
 =?us-ascii?Q?NCCYmi49kaPeqX+QTBkvCRQ0xA1aOWOVTJA9DprIMueP7b5gfghJmiCqc0jJ?=
 =?us-ascii?Q?jaxOdiA6EEM6n+k+xVbl6wgS13aNOrUSEiCS25WDxJK2wAldHzg7ss6NcnJX?=
 =?us-ascii?Q?CaMmZB94qN/nprM7/1wtIQDtE/R63FVSLRgRToQ2a7ufs+LgTw6m0HhTZwiz?=
 =?us-ascii?Q?5Xc=3D?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5348.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 916e25ea-9c1b-43c1-74dd-08d923f2b4e6
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 May 2021 05:12:37.2530 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ht9dkilnA9xqIzTSlMc3a6ZG+Jnm9iE2PkLwSprDrQQ/VlZHjq7hLa72UgFfZZxD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB5561
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
Cc: "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>, "Sider,
 Graham" <Graham.Sider@amd.com>, "Sakhnovitch,
 Elena \(Elen\)" <Elena.Sakhnovitch@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only]



-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Graham Sider
Sent: Saturday, May 29, 2021 1:28 AM
To: amd-gfx@lists.freedesktop.org
Cc: Kasiviswanathan, Harish <Harish.Kasiviswanathan@amd.com>; Sider, Graham <Graham.Sider@amd.com>; Sakhnovitch, Elena (Elen) <Elena.Sakhnovitch@amd.com>
Subject: [PATCH v2 4/8] drm/amd/pm: Add navi1x throttler translation

Perform dependent to independent throttle status translation for navi1x.

Signed-off-by: Graham Sider <Graham.Sider@amd.com>
---
 .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   | 56 +++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
index 78fe13183e8b..878ec698909c 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
@@ -524,6 +524,54 @@ static int navi10_tables_init(struct smu_context *smu)
 	return -ENOMEM;
 }
 
+static uint64_t navi1x_get_indep_throttler_status(
+					uint32_t dep_status)
+{
+	if (dep_status == 0)
+		return 0;
+
+	uint64_t indep_status = 0;

< > Extending Harish's comments - it's very unlikely that all or even 50% of these bits are set together. It may be better to do something like  

while (bit=ffs(dep_status)) {
 indep_status |= 1ULL  << mapping[bit-1];
dep_status &= ~(1UL << bit - 1);
}
Will need a lookup table, should be fine though. 

Thanks,
Lijo

+	indep_status |= smu_u64_throttler_bit(dep_status,
+			SMU_THROTTLER_TEMP_EDGE_BIT, THROTTLER_TEMP_EDGE_BIT);
+	indep_status |= smu_u64_throttler_bit(dep_status,
+			SMU_THROTTLER_TEMP_HOTSPOT_BIT, THROTTLER_TEMP_HOTSPOT_BIT);
+	indep_status |= smu_u64_throttler_bit(dep_status,
+			SMU_THROTTLER_TEMP_MEM_BIT, THROTTLER_TEMP_MEM_BIT);
+	indep_status |= smu_u64_throttler_bit(dep_status,
+			SMU_THROTTLER_TEMP_VR_GFX_BIT, THROTTLER_TEMP_VR_GFX_BIT);
+	indep_status |= smu_u64_throttler_bit(dep_status,
+			SMU_THROTTLER_TEMP_VR_MEM_BIT, THROTTLER_TEMP_VR_MEM0_BIT);
+	indep_status |= smu_u64_throttler_bit(dep_status,
+			SMU_THROTTLER_TEMP_VR_MEM_BIT, THROTTLER_TEMP_VR_MEM1_BIT);
+	indep_status |= smu_u64_throttler_bit(dep_status,
+			SMU_THROTTLER_TEMP_VR_SOC_BIT, THROTTLER_TEMP_VR_SOC_BIT);
+	indep_status |= smu_u64_throttler_bit(dep_status,
+			SMU_THROTTLER_TEMP_LIQUID_BIT, THROTTLER_TEMP_LIQUID0_BIT);
+	indep_status |= smu_u64_throttler_bit(dep_status,
+			SMU_THROTTLER_TEMP_LIQUID_BIT, THROTTLER_TEMP_LIQUID1_BIT);
+	indep_status |= smu_u64_throttler_bit(dep_status,
+			SMU_THROTTLER_TDC_GFX_BIT, THROTTLER_TDC_GFX_BIT);
+	indep_status |= smu_u64_throttler_bit(dep_status,
+			SMU_THROTTLER_TDC_SOC_BIT, THROTTLER_TDC_SOC_BIT);
+	indep_status |= smu_u64_throttler_bit(dep_status,
+			SMU_THROTTLER_PPT0_BIT, THROTTLER_PPT0_BIT);
+	indep_status |= smu_u64_throttler_bit(dep_status,
+			SMU_THROTTLER_PPT1_BIT, THROTTLER_PPT1_BIT);
+	indep_status |= smu_u64_throttler_bit(dep_status,
+			SMU_THROTTLER_PPT2_BIT, THROTTLER_PPT2_BIT);
+	indep_status |= smu_u64_throttler_bit(dep_status,
+			SMU_THROTTLER_PPT3_BIT, THROTTLER_PPT3_BIT);
+	indep_status |= smu_u64_throttler_bit(dep_status,
+			SMU_THROTTLER_FIT_BIT, THROTTLER_FIT_BIT);
+	indep_status |= smu_u64_throttler_bit(dep_status,
+			SMU_THROTTLER_PPM_BIT, THROTTLER_PPM_BIT);
+	indep_status |= smu_u64_throttler_bit(dep_status,
+			SMU_THROTTLER_APCC_BIT, THROTTLER_APCC_BIT);
+
+	return indep_status;
+}
+
 static int navi10_get_legacy_smu_metrics_data(struct smu_context *smu,
 					      MetricsMember_t member,
 					      uint32_t *value)
@@ -2673,6 +2721,8 @@ static ssize_t navi10_get_legacy_gpu_metrics(struct smu_context *smu,
 	gpu_metrics->current_dclk0 = metrics.CurrClock[PPCLK_DCLK];
 
 	gpu_metrics->throttle_status = metrics.ThrottlerStatus;
+	gpu_metrics->indep_throttle_status =
+			navi1x_get_indep_throttler_status(metrics.ThrottlerStatus);
 
 	gpu_metrics->current_fan_speed = metrics.CurrFanSpeed;
 
@@ -2750,6 +2800,8 @@ static ssize_t navi10_get_gpu_metrics(struct smu_context *smu,
 	gpu_metrics->current_dclk0 = metrics.CurrClock[PPCLK_DCLK];
 
 	gpu_metrics->throttle_status = metrics.ThrottlerStatus;
+	gpu_metrics->indep_throttle_status =
+			navi1x_get_indep_throttler_status(metrics.ThrottlerStatus);
 
 	gpu_metrics->current_fan_speed = metrics.CurrFanSpeed;
 
@@ -2826,6 +2878,8 @@ static ssize_t navi12_get_legacy_gpu_metrics(struct smu_context *smu,
 	gpu_metrics->current_dclk0 = metrics.CurrClock[PPCLK_DCLK];
 
 	gpu_metrics->throttle_status = metrics.ThrottlerStatus;
+	gpu_metrics->indep_throttle_status =
+			navi1x_get_indep_throttler_status(metrics.ThrottlerStatus);
 
 	gpu_metrics->current_fan_speed = metrics.CurrFanSpeed;
 
@@ -2908,6 +2962,8 @@ static ssize_t navi12_get_gpu_metrics(struct smu_context *smu,
 	gpu_metrics->current_dclk0 = metrics.CurrClock[PPCLK_DCLK];
 
 	gpu_metrics->throttle_status = metrics.ThrottlerStatus;
+	gpu_metrics->indep_throttle_status =
+			navi1x_get_indep_throttler_status(metrics.ThrottlerStatus);
 
 	gpu_metrics->current_fan_speed = metrics.CurrFanSpeed;
 
--
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7Clijo.lazar%40amd.com%7C0e8287b706374269018508d922135f02%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637578288869743604%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=9u%2FUr8%2FPuSekq2ttc0NiYeacZoAnPZNb2BTXUSD2Fd8%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
