Return-Path: <SRS0=1d99=JN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72681C433ED
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Apr 2021 06:53:58 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 063A0610FC
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Apr 2021 06:53:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 063A0610FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7EE516E133;
	Fri, 16 Apr 2021 06:53:57 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2064.outbound.protection.outlook.com [40.107.92.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E5ED26E133
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Apr 2021 06:53:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZQMO+7ngCj4I7jSQFVHu6aAJMAujCkL3PXAPA9YhfjIZjVFDGSIH9k/7KYd2rp1LllTNv38R1I9lcKzWwBMaUvXyIIJBvv3FTTyWEqb1O1ESTGwPnNjkzF3eRDp9g9obpP4s8Mf+gZVDzfy/erdZpZZtN1jZUKmPVb8COnKSnkBV2ukFqFSo/qV86vdACVpkcnhBCM0naTu4RHVom7NoPy7RnoIkJvVcwzK4JZtbIoyrFhn9x5RjNQy8F+J+B6LMmc61u5wlQ1glxtlRFSJB4c/bMyNuTrfj42VvJuk/Dm3EZwaBDE/XGf2Gwi5PpAh9/V2IuceJ5kXtexFHAD3HXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OUzZofCXAdg9BDLCAoNUogzj2gGF7Jw0KaFPbRUEzGY=;
 b=GEWxkIB90TZqCBgdksegKzlkQB2lVd6cAQV38cYyBD8hZIPOtVKfzSsnOW9vqM7Kj90d+TrLSnN3GCEoTF8jzgsCaFQ88MKandcYXwmjIRwdmWzLZLhzW55pmf8eHTet821gBW/NKqafYzsFdlgTl8OyM2vk68uruCslPJVSNTb/m8RwgC1dJ+tucjaQ1vsiMx5/DPHulFByzK6fh6IXSJI3jrjqy4e0Hj3o0uNiBzbC0F4qLxugBtBMmvxH47Mr78HPTnMyI2RsSucnJSDqJL4OhvH/1b6lfKV1llyesAgvtE/mxHVGec37xl9Hn1ODBC4UZ2FLw5mSyCyR/t3jIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OUzZofCXAdg9BDLCAoNUogzj2gGF7Jw0KaFPbRUEzGY=;
 b=D5Xzsv5Kywj6MU5R8D70Yo6i7b6KkS3v2gAimtGv176cgqqjndDW6Jb5ntBXkmuPDgnMByQqgBVu8Tid+VSteWK1pj9ML/fiSV5jnSGux5Z/QRLmOmmbZF21Z7+N5JUCqCuuOEcnGq4R0/qPn3xnIxseBa9ucheAGi1sXVIlnso=
Received: from BN9PR12MB5368.namprd12.prod.outlook.com (2603:10b6:408:105::24)
 by BN9PR12MB5337.namprd12.prod.outlook.com (2603:10b6:408:102::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16; Fri, 16 Apr
 2021 06:53:55 +0000
Received: from BN9PR12MB5368.namprd12.prod.outlook.com
 ([fe80::1ef:6c3d:170c:8328]) by BN9PR12MB5368.namprd12.prod.outlook.com
 ([fe80::1ef:6c3d:170c:8328%6]) with mapi id 15.20.4042.019; Fri, 16 Apr 2021
 06:53:55 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Li, Dennis" <Dennis.Li@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>
Subject: RE: [PATCH] drm/amdkfd: add edc error interrupt handle for poison
 propogate mode
Thread-Topic: [PATCH] drm/amdkfd: add edc error interrupt handle for poison
 propogate mode
Thread-Index: AQHXMm8fSu7NFCJaIk+kaPZdLvf3UKq2tY8A
Date: Fri, 16 Apr 2021 06:53:55 +0000
Message-ID: <BN9PR12MB536858583141A0AA0F032023FC4C9@BN9PR12MB5368.namprd12.prod.outlook.com>
References: <20210416031750.32391-1-Dennis.Li@amd.com>
In-Reply-To: <20210416031750.32391-1-Dennis.Li@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-04-16T06:53:53Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=7cbc232f-55eb-4ed3-afd7-c6c46ebed727;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 30ef7d7d-588d-4bd9-1bb5-08d900a46701
x-ms-traffictypediagnostic: BN9PR12MB5337:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN9PR12MB53371686FD234BCF8312C27FFC4C9@BN9PR12MB5337.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:513;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sU10nQ59m68lLfNGzeoa4+JzQYRPb+RaLKA6Wn2lsBX4znZs2nEl33R5UKABnJ5nn4AQngq85wRzFsTTcMP6anHLYMyJ5s3xkD1x1qKey9w/cSoLVzBSvQPia4xHvj59IAY9zn0TlllNZXrgSj7mlgYoz1B54LaYCUOXNRYAb8ZbbBvErDskCAAiEqMIuILlscsAfPUAWyn5GxJuH5YeduGob/n2DfWPtzSJ2sR/xK9iMd8Ug0UglTAam8eERa+HezthmrJWmtlFkIORmaBuMEx5llodtRhPOwN1XcPGbbV0nuNEYL6zGN9ZrX+6OT05bD8ICcNIzuN10XZpYhcDr0bjlmQ7g3Mivb7HYIdXThtN/Ew8d+wXylMVZWzjNBBLKfPvVT4ceywFYesZb77K5SyA+lWM+KVTTfMoe1BOTGCyTg4r6fy7lsbyGdLGZff/ogr+0QuQ2QYmIuQHMl6ip4uTaV+D4oCv0olJDHGJB4sZrX3fIwBwyldMtKEZFZXdJDYZMp8ZjBEjlOKGHkO02tvCZv9Ke4kfhY9g00wtX52d0sX10FqMucnomOuR08wuT9ppNwe9JzTJ1eisj0lLvcC1kPfZEVBEboEp7bnzvPY=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5368.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(346002)(396003)(376002)(366004)(39860400002)(7696005)(9686003)(122000001)(53546011)(2906002)(55016002)(8676002)(66946007)(26005)(71200400001)(6506007)(66476007)(52536014)(86362001)(66446008)(83380400001)(478600001)(316002)(64756008)(8936002)(33656002)(5660300002)(186003)(6636002)(4326008)(76116006)(38100700002)(110136005)(66556008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?uSHrbn19+l0+S1D7mdcsNy/nRLJD/9RhKrqHCLRE0MpoD8LV5Kmd3Nt2ZoKu?=
 =?us-ascii?Q?A7nfpba+a3+T+rCr7qKivmNQlrks6axK9E+qm1ncmFrFUIgBrMtplmQrpXE0?=
 =?us-ascii?Q?Ou7+Xb2S4RsRfuOZ5660yuqZ9NcmGwWRnHqTi0HD6mR1KY5fJo/TfYfabU1M?=
 =?us-ascii?Q?un86tR9ctNgjqZF0q3NrUBCpww8BiCTN3EHjq57prqrDi/OAgk9Qwb5fajWM?=
 =?us-ascii?Q?7ICiC61xXVco8vVvPtyUZaq6sw2KNHZ/aYLXftqcsXMN176rstKqYpbSCCIo?=
 =?us-ascii?Q?KS8iGSI1ec0CBQflrABQtWFg7sgS0usflMFiK3tGhpdl/5n6gHmj7ycsu0eC?=
 =?us-ascii?Q?SItnaeNTOorBjYQvxJiMhdeB4vvhppR7pIhT1wWDbNy/ma27JiDlbSnuRm+W?=
 =?us-ascii?Q?I5dBDFfI7Xah0HZWSkbuoQOA+j/ezVmRdoBVT7G0AMnExoN7645hlrdVRLM4?=
 =?us-ascii?Q?kmvBzALv7vROS1dXIYFuSrpglXKvfmgM2oPkfCmNy6Szw/RByArXrv5b8WCH?=
 =?us-ascii?Q?0nZNYJH/rLOvRoORTYw6ox/hmVHRxVS/QNNFOfjvr4384jTU9+D2EgQ6ATmi?=
 =?us-ascii?Q?qYm4RmZ7a6x/JZFjCOWfDfa9/RdnAX1aM1u8SNHv2nQiNukB90gv5RUxa7aP?=
 =?us-ascii?Q?lofq+MJCqfEu/GGk2bygavGEOKGMWNmUqi1S2LoecOhbAItd7lKcRQdyyQCG?=
 =?us-ascii?Q?09ICXE35hHFXNNkOaSzE1bOEMV9/YpKnppprQti1r24tgiGTu+53TjblKweV?=
 =?us-ascii?Q?6EHJqbR0hPg/tZPlflgE+VI4D6dARfbX0uQsorERyX2qthJBcwcxJcUtacVX?=
 =?us-ascii?Q?V6pSLqIMNferzYhjDxwWK/Rrngvn8u6aEW71KhD0mBaSiQnTw3uqRl4gRacJ?=
 =?us-ascii?Q?14xoQI8ZZtjTfO/Xdt2Sd6Jizs+kY2cRpN/Dg7T3AU0BJSAkLwZKfADwvmod?=
 =?us-ascii?Q?b4smO9WQT8kGXewegJ/Dmt9sS3FEeTx3Ps8EiJM7XkLR2MJYJylrEnn7Y7Tv?=
 =?us-ascii?Q?sRUBoD56LRVVzpKWXtJHOfWf1d4aJ4PZ2fzkaHqvR7KzpYuOJ9PX/xB5A/zJ?=
 =?us-ascii?Q?VgXPQC8EMxlK1/QOx+ka1sZqsyjVSyhbfQ8zPyPwDhCd7adfjByfW5GqEvSh?=
 =?us-ascii?Q?OCj/gihlUGB3x9h37Vaz9L6/pjM4jA0+KLqCPyqLz22Ygwe9+fzP8tyW+5B0?=
 =?us-ascii?Q?v7eZLFnRFpdyCZH1OV7LcC1FQJ/+Fo+9vRE08KpFih6/Yz0rXs4bs4QY5Anp?=
 =?us-ascii?Q?Y8fT2Wto+lCox5T+ar/L7Nw04O+7OGnfOU3PuSGnJJiM9MY61wAi3RI8vxcc?=
 =?us-ascii?Q?VHlm5zsxVUtncxESO5kFXCNN?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5368.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30ef7d7d-588d-4bd9-1bb5-08d900a46701
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2021 06:53:55.0596 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LT2IdctfUexPcWSotVLxrFdBUqn8cWFLsc7AJorkj4hKksMQQBAK7FhLdekFz0qqZuWBEjYOwKIcSjAFVYu5Yw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5337
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
Cc: "Li, Dennis" <Dennis.Li@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking

-----Original Message-----
From: Dennis Li <Dennis.Li@amd.com> 
Sent: Friday, April 16, 2021 11:18
To: amd-gfx@lists.freedesktop.org; Deucher, Alexander <Alexander.Deucher@amd.com>; Kuehling, Felix <Felix.Kuehling@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>
Cc: Li, Dennis <Dennis.Li@amd.com>
Subject: [PATCH] drm/amdkfd: add edc error interrupt handle for poison propogate mode

In poison progogate mode, when driver receive the edc error interrupt from SQ, driver should kill the process by pasid which is using the poison data, and then trigger GPU reset.

Signed-off-by: Dennis Li <Dennis.Li@amd.com>

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
index 1c20458f3962..696944fa0177 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
@@ -25,6 +25,70 @@
 #include "soc15_int.h"
 #include "kfd_device_queue_manager.h"
 #include "kfd_smi_events.h"
+#include "amdgpu.h"
+
+enum SQ_INTERRUPT_WORD_ENCODING {
+	SQ_INTERRUPT_WORD_ENCODING_AUTO = 0x0,
+	SQ_INTERRUPT_WORD_ENCODING_INST,
+	SQ_INTERRUPT_WORD_ENCODING_ERROR,
+};
+
+enum SQ_INTERRUPT_ERROR_TYPE {
+	SQ_INTERRUPT_ERROR_TYPE_EDC_FUE = 0x0,
+	SQ_INTERRUPT_ERROR_TYPE_ILLEGAL_INST,
+	SQ_INTERRUPT_ERROR_TYPE_MEMVIOL,
+	SQ_INTERRUPT_ERROR_TYPE_EDC_FED,
+};
+
+/* SQ_INTERRUPT_WORD_AUTO_CTXID */
+#define SQ_INTERRUPT_WORD_AUTO_CTXID__THREAD_TRACE__SHIFT 0 #define 
+SQ_INTERRUPT_WORD_AUTO_CTXID__WLT__SHIFT 1 #define 
+SQ_INTERRUPT_WORD_AUTO_CTXID__THREAD_TRACE_BUF_FULL__SHIFT 2 #define 
+SQ_INTERRUPT_WORD_AUTO_CTXID__REG_TIMESTAMP__SHIFT 3 #define 
+SQ_INTERRUPT_WORD_AUTO_CTXID__CMD_TIMESTAMP__SHIFT 4 #define 
+SQ_INTERRUPT_WORD_AUTO_CTXID__HOST_CMD_OVERFLOW__SHIFT 5 #define 
+SQ_INTERRUPT_WORD_AUTO_CTXID__HOST_REG_OVERFLOW__SHIFT 6 #define 
+SQ_INTERRUPT_WORD_AUTO_CTXID__IMMED_OVERFLOW__SHIFT 7 #define 
+SQ_INTERRUPT_WORD_AUTO_CTXID__THREAD_TRACE_UTC_ERROR__SHIFT 8 #define 
+SQ_INTERRUPT_WORD_AUTO_CTXID__SE_ID__SHIFT 24 #define 
+SQ_INTERRUPT_WORD_AUTO_CTXID__ENCODING__SHIFT 26
+
+#define SQ_INTERRUPT_WORD_AUTO_CTXID__THREAD_TRACE_MASK 0x00000001 
+#define SQ_INTERRUPT_WORD_AUTO_CTXID__WLT_MASK 0x00000002 #define 
+SQ_INTERRUPT_WORD_AUTO_CTXID__THREAD_TRACE_BUF_FULL_MASK 0x00000004 
+#define SQ_INTERRUPT_WORD_AUTO_CTXID__REG_TIMESTAMP_MASK 0x00000008 
+#define SQ_INTERRUPT_WORD_AUTO_CTXID__CMD_TIMESTAMP_MASK 0x00000010 
+#define SQ_INTERRUPT_WORD_AUTO_CTXID__HOST_CMD_OVERFLOW_MASK 0x00000020 
+#define SQ_INTERRUPT_WORD_AUTO_CTXID__HOST_REG_OVERFLOW_MASK 0x00000040 
+#define SQ_INTERRUPT_WORD_AUTO_CTXID__IMMED_OVERFLOW_MASK 0x00000080 
+#define SQ_INTERRUPT_WORD_AUTO_CTXID__THREAD_TRACE_UTC_ERROR_MASK 
+0x00000100 #define SQ_INTERRUPT_WORD_AUTO_CTXID__SE_ID_MASK 0x03000000 
+#define SQ_INTERRUPT_WORD_AUTO_CTXID__ENCODING_MASK 0x0c000000
+
+/* SQ_INTERRUPT_WORD_WAVE_CTXID */
+#define SQ_INTERRUPT_WORD_WAVE_CTXID__DATA__SHIFT 0 #define 
+SQ_INTERRUPT_WORD_WAVE_CTXID__SH_ID__SHIFT 12 #define 
+SQ_INTERRUPT_WORD_WAVE_CTXID__PRIV__SHIFT 13 #define 
+SQ_INTERRUPT_WORD_WAVE_CTXID__WAVE_ID__SHIFT 14 #define 
+SQ_INTERRUPT_WORD_WAVE_CTXID__SIMD_ID__SHIFT 18 #define 
+SQ_INTERRUPT_WORD_WAVE_CTXID__CU_ID__SHIFT 20 #define 
+SQ_INTERRUPT_WORD_WAVE_CTXID__SE_ID__SHIFT 24 #define 
+SQ_INTERRUPT_WORD_WAVE_CTXID__ENCODING__SHIFT 26
+
+#define SQ_INTERRUPT_WORD_WAVE_CTXID__DATA_MASK 0x00000fff #define 
+SQ_INTERRUPT_WORD_WAVE_CTXID__SH_ID_MASK 0x00001000 #define 
+SQ_INTERRUPT_WORD_WAVE_CTXID__PRIV_MASK 0x00002000 #define 
+SQ_INTERRUPT_WORD_WAVE_CTXID__WAVE_ID_MASK 0x0003c000 #define 
+SQ_INTERRUPT_WORD_WAVE_CTXID__SIMD_ID_MASK 0x000c0000 #define 
+SQ_INTERRUPT_WORD_WAVE_CTXID__CU_ID_MASK 0x00f00000 #define 
+SQ_INTERRUPT_WORD_WAVE_CTXID__SE_ID_MASK 0x03000000 #define 
+SQ_INTERRUPT_WORD_WAVE_CTXID__ENCODING_MASK 0x0c000000
+
+#define KFD_CONTEXT_ID_GET_SQ_INT_DATA(ctx0, ctx1)                             \
+	((ctx0 & 0xfff) | ((ctx0 >> 16) & 0xf000) | ((ctx1 << 16) & 0xff0000))
+
+#define KFD_SQ_INT_DATA__ERR_TYPE_MASK 0xF00000 #define 
+KFD_SQ_INT_DATA__ERR_TYPE__SHIFT 20
 
 static bool event_interrupt_isr_v9(struct kfd_dev *dev,
 					const uint32_t *ih_ring_entry,
@@ -108,13 +172,15 @@ static void event_interrupt_wq_v9(struct kfd_dev *dev,
 					const uint32_t *ih_ring_entry)
 {
 	uint16_t source_id, client_id, pasid, vmid;
-	uint32_t context_id;
+	uint32_t context_id0, context_id1;
+	uint32_t sq_intr_err, sq_int_data, encoding;
 
 	source_id = SOC15_SOURCE_ID_FROM_IH_ENTRY(ih_ring_entry);
 	client_id = SOC15_CLIENT_ID_FROM_IH_ENTRY(ih_ring_entry);
 	pasid = SOC15_PASID_FROM_IH_ENTRY(ih_ring_entry);
 	vmid = SOC15_VMID_FROM_IH_ENTRY(ih_ring_entry);
-	context_id = SOC15_CONTEXT_ID0_FROM_IH_ENTRY(ih_ring_entry);
+	context_id0 = SOC15_CONTEXT_ID0_FROM_IH_ENTRY(ih_ring_entry);
+	context_id1 = SOC15_CONTEXT_ID1_FROM_IH_ENTRY(ih_ring_entry);
 
 	if (client_id == SOC15_IH_CLIENTID_GRBM_CP ||
 	    client_id == SOC15_IH_CLIENTID_SE0SH || @@ -122,10 +188,59 @@ static void event_interrupt_wq_v9(struct kfd_dev *dev,
 	    client_id == SOC15_IH_CLIENTID_SE2SH ||
 	    client_id == SOC15_IH_CLIENTID_SE3SH) {
 		if (source_id == SOC15_INTSRC_CP_END_OF_PIPE)
-			kfd_signal_event_interrupt(pasid, context_id, 32);
-		else if (source_id == SOC15_INTSRC_SQ_INTERRUPT_MSG)
-			kfd_signal_event_interrupt(pasid, context_id & 0xffffff, 24);
-		else if (source_id == SOC15_INTSRC_CP_BAD_OPCODE)
+			kfd_signal_event_interrupt(pasid, context_id0, 32);
+		else if (source_id == SOC15_INTSRC_SQ_INTERRUPT_MSG) {
+			sq_int_data = KFD_CONTEXT_ID_GET_SQ_INT_DATA(context_id0, context_id1);
+			encoding = REG_GET_FIELD(context_id0, SQ_INTERRUPT_WORD_WAVE_CTXID, ENCODING);
+			switch (encoding) {
+			case SQ_INTERRUPT_WORD_ENCODING_AUTO:
+				pr_debug(
+					"sq_intr: auto, se %d, ttrace %d, wlt %d, ttrac_buf_full %d, reg_tms %d, cmd_tms %d, host_cmd_ovf %d, host_reg_ovf %d, immed_ovf %d, ttrace_utc_err %d\n",
+					REG_GET_FIELD(context_id0, SQ_INTERRUPT_WORD_AUTO_CTXID, SE_ID),
+					REG_GET_FIELD(context_id0, SQ_INTERRUPT_WORD_AUTO_CTXID, THREAD_TRACE),
+					REG_GET_FIELD(context_id0, SQ_INTERRUPT_WORD_AUTO_CTXID, WLT),
+					REG_GET_FIELD(context_id0, SQ_INTERRUPT_WORD_AUTO_CTXID, THREAD_TRACE_BUF_FULL),
+					REG_GET_FIELD(context_id0, SQ_INTERRUPT_WORD_AUTO_CTXID, REG_TIMESTAMP),
+					REG_GET_FIELD(context_id0, SQ_INTERRUPT_WORD_AUTO_CTXID, CMD_TIMESTAMP),
+					REG_GET_FIELD(context_id0, SQ_INTERRUPT_WORD_AUTO_CTXID, HOST_CMD_OVERFLOW),
+					REG_GET_FIELD(context_id0, SQ_INTERRUPT_WORD_AUTO_CTXID, HOST_REG_OVERFLOW),
+					REG_GET_FIELD(context_id0, SQ_INTERRUPT_WORD_AUTO_CTXID, IMMED_OVERFLOW),
+					REG_GET_FIELD(context_id0, SQ_INTERRUPT_WORD_AUTO_CTXID, THREAD_TRACE_UTC_ERROR));
+				break;
+			case SQ_INTERRUPT_WORD_ENCODING_INST:
+				pr_debug("sq_intr: inst, se %d, data 0x%x, sh %d, priv %d, wave_id %d, simd_id %d, cu_id %d, intr_data 0x%x\n",
+					REG_GET_FIELD(context_id0, SQ_INTERRUPT_WORD_WAVE_CTXID, SE_ID),
+					REG_GET_FIELD(context_id0, SQ_INTERRUPT_WORD_WAVE_CTXID, DATA),
+					REG_GET_FIELD(context_id0, SQ_INTERRUPT_WORD_WAVE_CTXID, SH_ID),
+					REG_GET_FIELD(context_id0, SQ_INTERRUPT_WORD_WAVE_CTXID, PRIV),
+					REG_GET_FIELD(context_id0, SQ_INTERRUPT_WORD_WAVE_CTXID, WAVE_ID),
+					REG_GET_FIELD(context_id0, SQ_INTERRUPT_WORD_WAVE_CTXID, SIMD_ID),
+					REG_GET_FIELD(context_id0, SQ_INTERRUPT_WORD_WAVE_CTXID, CU_ID),
+					sq_int_data);
+				break;
+			case SQ_INTERRUPT_WORD_ENCODING_ERROR:
+				sq_intr_err = REG_GET_FIELD(sq_int_data, KFD_SQ_INT_DATA, ERR_TYPE);
+				pr_warn("sq_intr: error, se %d, data 0x%x, sh %d, priv %d, wave_id %d, simd_id %d, cu_id %d, err_type %d\n",
+					REG_GET_FIELD(context_id0, SQ_INTERRUPT_WORD_WAVE_CTXID, SE_ID),
+					REG_GET_FIELD(context_id0, SQ_INTERRUPT_WORD_WAVE_CTXID, DATA),
+					REG_GET_FIELD(context_id0, SQ_INTERRUPT_WORD_WAVE_CTXID, SH_ID),
+					REG_GET_FIELD(context_id0, SQ_INTERRUPT_WORD_WAVE_CTXID, PRIV),
+					REG_GET_FIELD(context_id0, SQ_INTERRUPT_WORD_WAVE_CTXID, WAVE_ID),
+					REG_GET_FIELD(context_id0, SQ_INTERRUPT_WORD_WAVE_CTXID, SIMD_ID),
+					REG_GET_FIELD(context_id0, SQ_INTERRUPT_WORD_WAVE_CTXID, CU_ID),
+					sq_intr_err);
+				if (sq_intr_err != SQ_INTERRUPT_ERROR_TYPE_ILLEGAL_INST &&
+					sq_intr_err != SQ_INTERRUPT_ERROR_TYPE_MEMVIOL) {
+					kfd_signal_hw_exception_event(pasid);
+					amdgpu_amdkfd_gpu_reset(dev->kgd);
+					return;
+				}
+				break;
+			default:
+				break;
+			}
+			kfd_signal_event_interrupt(pasid, context_id0 & 0xffffff, 24);
+		} else if (source_id == SOC15_INTSRC_CP_BAD_OPCODE)
 			kfd_signal_hw_exception_event(pasid);
 	} else if (client_id == SOC15_IH_CLIENTID_SDMA0 ||
 		   client_id == SOC15_IH_CLIENTID_SDMA1 || @@ -136,7 +251,7 @@ static void event_interrupt_wq_v9(struct kfd_dev *dev,
 		   client_id == SOC15_IH_CLIENTID_SDMA6 ||
 		   client_id == SOC15_IH_CLIENTID_SDMA7) {
 		if (source_id == SOC15_INTSRC_SDMA_TRAP)
-			kfd_signal_event_interrupt(pasid, context_id & 0xfffffff, 28);
+			kfd_signal_event_interrupt(pasid, context_id0 & 0xfffffff, 28);
 	} else if (client_id == SOC15_IH_CLIENTID_VMC ||
 		   client_id == SOC15_IH_CLIENTID_VMC1 ||
 		   client_id == SOC15_IH_CLIENTID_UTCL2) {
--
2.17.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
