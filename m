Return-Path: <SRS0=uqvu=KN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20E16C433B4
	for <amd-gfx@archiver.kernel.org>; Tue, 18 May 2021 02:59:55 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D338360FE9
	for <amd-gfx@archiver.kernel.org>; Tue, 18 May 2021 02:59:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D338360FE9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 65E676E5B4;
	Tue, 18 May 2021 02:59:54 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2045.outbound.protection.outlook.com [40.107.102.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 388136E5B4
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 May 2021 02:59:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mOpgV+FK82JhMbCgQdw++njRMb5ZW0yWKbdPkVxSKdRDZd7sWoIWbROD2LPjTfgwnttQuykBubrcwzVgTww8lEwkZZqETcwbGoUVrYNC1qbh/icSko+lReBPeHjPxR7WDBywen5kzeHHqWlMuyzL+VH76t7s9jHXsFvAf3CH7Y2+hHTFsEjkRTbTD4J7I7IV0aUeDQxNLGsEeLiFwjiib5W6YA8oQtvJ0fQPKnHN+6sKK1E/MVmXHc7dkNyEn2k2kljURa6jhNzkLbCJnHUCGyrAFbm/A9BZ7YSbQf9im0ItwtG92l42KzTfIiomADR93xRdeQmBht7k8ywv8i9jNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5i0gYh7yDSaa+ZCiVoerjbwUAa9x2a2js28L7bP35/k=;
 b=FjeyXz0NMg5SdTrq+r4G7yMqAZyaxOZ8Z6sTUL/FbUkq9DhoajQotXtMkthN72d83cvRd1WVDRI5ly6q2YLMNIdYkcyiqMh394tJeM1BGtgAAmaZ1F0dQ/Ut6LS5qprNYxdBF/pVCvR/eqFgeZag9l7oyPbh+2MsUYmFtwDYQNeN3ORKuZ2W8rYhiYDVg3iy6uWGX7WKrhvTXU/uj3QwRcT39DnqG1G62JmNVhNjpT+8JWsKcVq8p9vvlXhGCzoTvQkuWrwcvQAkdNCHR8Ctcq+XHuxUDRD3OQOB0fYkotj5JbsPGUp3z3Z0iEXmwUkuDnOuXsvMsArGFQO2LcD0VQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5i0gYh7yDSaa+ZCiVoerjbwUAa9x2a2js28L7bP35/k=;
 b=Okk6ovxG2wQ7GcAikKZgeLjvcT3EubMKGu/h6E8eJyTnC9d6Q1jVD4FOYyrmsI/MlN9afLK/bzvUXjWifa5NrP1IpVfvDPrQRJSs/zf+5Z7IrLfoU2a0Q1ze67RwMUOtHUDgeWx6RdCBlJ+sYIizA7X+Duegrxes+DmV41uTHIo=
Received: from BYAPR12MB3640.namprd12.prod.outlook.com (2603:10b6:a03:aa::12)
 by BY5PR12MB3684.namprd12.prod.outlook.com (2603:10b6:a03:1a2::32)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.28; Tue, 18 May
 2021 02:59:51 +0000
Received: from BYAPR12MB3640.namprd12.prod.outlook.com
 ([fe80::a01f:b2a0:9723:22fb]) by BYAPR12MB3640.namprd12.prod.outlook.com
 ([fe80::a01f:b2a0:9723:22fb%7]) with mapi id 15.20.4129.032; Tue, 18 May 2021
 02:59:51 +0000
From: "Feng, Kenneth" <Kenneth.Feng@amd.com>
To: "Quan, Evan" <Evan.Quan@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/pm: correct MGpuFanBoost setting
Thread-Topic: [PATCH] drm/amd/pm: correct MGpuFanBoost setting
Thread-Index: AQHXS4pCidS2xxFg5ECVdxndsJE3EarojJfw
Date: Tue, 18 May 2021 02:59:51 +0000
Message-ID: <BYAPR12MB364031C662ABE2B04ADE75758E2C9@BYAPR12MB3640.namprd12.prod.outlook.com>
References: <20210518020502.351803-1-evan.quan@amd.com>
In-Reply-To: <20210518020502.351803-1-evan.quan@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-05-18T02:59:49Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=aa88661e-f46f-4d3d-accc-b9fb78f428d5;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.134.244]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cd0d78af-d628-47ad-b26e-08d919a901b8
x-ms-traffictypediagnostic: BY5PR12MB3684:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR12MB3684E7458C20077B488CF6258E2C9@BY5PR12MB3684.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1417;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kD8e9/b21ZLhTeTppv1nT8nNsABEBodAX77s+GVUogO1CwBRRa8IvngBoNejAhz78zyOLcIm13WhK0ykP5l+gx08ggtRx36PD1FmnbZosBXRY6zc/RN5Y5aYLx4Uw+OV7v+rQtq1aHGvhbgXz67A/8x/GPr9kS777tXKQoYoPaxS+ZV4Gc9c8ehhzffGDt0V/wthsJCHlr28JtUPZAc5g+Z0k1LooQKs8zaf7WF3Xw3FZI6MaHaAASvUli/biNIlJDQoaRAaVHPjs3nWArWUFxylKu9p0EWwZBzGEf7zB0RKRsOgOiqVJZNdX+/nR8sAXn7BVwfADoFpw5wDh4DJwORHsRyfTTF19/+XIg5LQJ5GJZOsHzGcYDIvcj4e3iuL2g0E4WG4Y5VBJG4W+yuzPUQB7tLqBQbmLjwrcCgi9bTxNtUIKxqN+wgjL0j6FDYoGJVUtYeV8xsJMXJEdA+veZfPDzTk1DV+Q0N7LP5tMJzNavXxJxqivSZQSUsAMV9xe0nAbzbBkwW9Xw7uZve7TsuKFOOdN68l8QJlE6nup+brS78OG/j0e8xP8TNFuNnIKIYCOT/BxH/grHApFX9DpQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB3640.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(39860400002)(396003)(136003)(376002)(366004)(110136005)(6506007)(26005)(71200400001)(86362001)(53546011)(186003)(8936002)(52536014)(5660300002)(83380400001)(7696005)(55016002)(38100700002)(122000001)(478600001)(2906002)(9686003)(4326008)(64756008)(66446008)(76116006)(66476007)(316002)(66946007)(8676002)(66556008)(33656002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?uvchqNt6nLOsr/4wsSp9zGjsOXo9QW8muWg3FqwVdmDPnQ890NBrFnowN7eQ?=
 =?us-ascii?Q?09VC4CmyewGdK9J70yXDd6bbMbPCC9DtZL16+CPcaYV/9BQhJ+e2mFS4HPsd?=
 =?us-ascii?Q?7HJqzI+43eF8UMz9IK95AbOi9DOBgnHT4L94Pu6goiQMaBJ7wgjHQzsIMLLD?=
 =?us-ascii?Q?K5BzCOOeJaAuk9VrFlNrxCfXy2CpFq6n/fAqJgTELntIBh7KrMzbp7gyX8p8?=
 =?us-ascii?Q?MRUUlK0Yp05u6NM+ChXRLYomOSlL5J9wgMkAiHff4kG9hTJRRGQXeUnYf83d?=
 =?us-ascii?Q?zTefKEXds/dVgu2RQBYlkQin3p0FbRTyHkY/Wcvtkul/HjgtRF0sHUpQcAmY?=
 =?us-ascii?Q?tniYpAHb8PwRFtyUiivZUA5RufKGqeAGV5SPwSkRcvoDO2mCjqgQmLbXWKLf?=
 =?us-ascii?Q?K8Ja5iq+7UEejfrhhwH0141CFOBA2RB3vPbSmSaJDXFWq1IXXH0McBKx3TuV?=
 =?us-ascii?Q?TGxf2ylCwF2+1/4XSOia2BhW9ppNbTGlJbG/ouo23rujj6Rt1qGmUPvTPhTy?=
 =?us-ascii?Q?OL2qvbcHhu4Rqs9TnwQdeRHQkarQldviLtcNQL/luLXnpa/f3CI3DYV6fJN9?=
 =?us-ascii?Q?3ZiXi/SGqkOg1snH9kbYUSzEK8eWC1bxo34QTUnRtRfoyVXIfZVIptJBaWhv?=
 =?us-ascii?Q?DwadUKZgPWAV+Yd4Bk44Lmz7OEJiUI1dHJy3Btv93V+JeQ4vxgy0pnk5gumw?=
 =?us-ascii?Q?jvSndlOFEDMtlMfVFxyyQ7XHgkeYll6Kt8Xf4I49fhIflOTEI7Owv1rmMBx5?=
 =?us-ascii?Q?jsjbQAJWdJCowWQ4wTZ8ml857MnO1xo9v7xZ92BW6FtkDdh5W9O9syW7UaOG?=
 =?us-ascii?Q?3/A6JjfGfjK5XAKKhxOu8z5OHzk6EdzN6xGSHcrqSKxYioubXIwWXSM26GZp?=
 =?us-ascii?Q?RyZ1e5iF9PpkhbHMLMPR+VomfWIDxyH+L6Uf+75ULiHwO/xV1ENmRZxSHEDL?=
 =?us-ascii?Q?xezD70X5wKbsaKf3subJtri/0NJOXCUbebX3UwzxemPQJDaP8rMFz/LBNuAd?=
 =?us-ascii?Q?hy5xnE+6clxccJAEsxNVfmlaq1lijugQ78cuMP9v/YBPU6xozZu/bQRFXOx6?=
 =?us-ascii?Q?ESvkKaCV+hp6mknLrFutajeI9TURQ7cmEbRqhd9IvPIqPpxTJFawUFsZrR+a?=
 =?us-ascii?Q?rPO6DKnUa04sG9tnRx439gy71ciwrULY9o+Hokw528SPVC0TXSSmxJsCFuQq?=
 =?us-ascii?Q?HLCa8jFcmc4faV+1+Q+HIcZHbqbwYaIUKLeWtg8DEe18zFiEgsu8jH0pAMrT?=
 =?us-ascii?Q?/8Z6i6g4eVhMR7GtRBjJVEf6lPjxnn4keOMyQfXSMr21wvDFh0qYl4gZBeiT?=
 =?us-ascii?Q?mOSCLgmUVSG0mhZ/Vn/915JB?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3640.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd0d78af-d628-47ad-b26e-08d919a901b8
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 May 2021 02:59:51.7145 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WVSwaCGrY5CT7RQeJwsW3/y3d5hBYRnE8kCTJyzw81gJTTjtscPiTmnxwSkp+7/k
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3684
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only]

Reviewed-by: Kenneth Feng <kenneth.feng@amd.com>

-----Original Message-----
From: Quan, Evan <Evan.Quan@amd.com> 
Sent: Tuesday, May 18, 2021 10:05 AM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Feng, Kenneth <Kenneth.Feng@amd.com>; Quan, Evan <Evan.Quan@amd.com>
Subject: [PATCH] drm/amd/pm: correct MGpuFanBoost setting

No MGpuFanBoost setting for those ASICs which do not support it.
Otherwise, it may breaks their fan control feature.

Change-Id: Ifa9c87ac537a07937a0f0f6a670f21368eb29218
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c        |  9 +++++++++
 .../gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c    | 10 ++++++++++
 2 files changed, 19 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
index d2063b1e7936..f16c76038f13 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
@@ -2936,6 +2936,8 @@ static ssize_t navi1x_get_gpu_metrics(struct smu_context *smu,
 
 static int navi10_enable_mgpu_fan_boost(struct smu_context *smu)  {
+	struct smu_table_context *table_context = &smu->smu_table;
+	PPTable_t *smc_pptable = table_context->driver_pptable;
 	struct amdgpu_device *adev = smu->adev;
 	uint32_t param = 0;
 
@@ -2943,6 +2945,13 @@ static int navi10_enable_mgpu_fan_boost(struct smu_context *smu)
 	if (adev->asic_type == CHIP_NAVI12)
 		return 0;
 
+	/*
+	 * Skip the MGpuFanBoost setting for those ASICs
+	 * which do not support it
+	 */
+	if (!smc_pptable->MGpuFanBoostLimitRpm)
+		return 0;
+
 	/* Workaround for WS SKU */
 	if (adev->pdev->device == 0x7312 &&
 	    adev->pdev->revision == 0)
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index 3c3a7f9233e0..159cd698323e 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -3201,6 +3201,16 @@ static ssize_t sienna_cichlid_get_gpu_metrics(struct smu_context *smu,
 
 static int sienna_cichlid_enable_mgpu_fan_boost(struct smu_context *smu)  {
+	struct smu_table_context *table_context = &smu->smu_table;
+	PPTable_t *smc_pptable = table_context->driver_pptable;
+
+	/*
+	 * Skip the MGpuFanBoost setting for those ASICs
+	 * which do not support it
+	 */
+	if (!smc_pptable->MGpuFanBoostLimitRpm)
+		return 0;
+
 	return smu_cmn_send_smc_msg_with_param(smu,
 					       SMU_MSG_SetMGpuFanBoostLimitRpm,
 					       0,
--
2.29.0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
