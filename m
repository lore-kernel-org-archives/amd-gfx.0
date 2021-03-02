Return-Path: <SRS0=vakm=IA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C3ECC433DB
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Mar 2021 10:53:14 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CAA4A64F04
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Mar 2021 10:53:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAA4A64F04
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 49E6089DFA;
	Tue,  2 Mar 2021 10:53:13 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2049.outbound.protection.outlook.com [40.107.223.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 928B389DFA
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Mar 2021 10:53:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mjgHL/0v3YJu2vrojo0PU70MYegaPs8fUIZrRh0g7HMW3mZyzkVbtwUuvBAzfSEx4PPGdilJLFrTbKkbu+eZlXopR3yLA2yKOoXZBkQ1xngDCSdt7La0RzEAaUFHEeRYdBzoX25shqP+Ko/t8QokDqcpts8z6Jbz89GKsOm+wCw8pkTKGfI74Zr4x/Na7Va+5CP725ik+35vc341I8wlvxixmbKDxPhyKjj2sdnaKY7HLsuov/AiMxn2/vS5iLAjz0GelZPWp1HQkSvoo56chnoTqVo5cw0RWykBn2MLz/mI31RacBAb6it+aIzZfbC7kXgF32MoFYIvhRcSD+uVMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=REHIicGVPEL8VP40AzqoiH0Yzl8djrbA4hguUBazmrY=;
 b=m8VucpvaWfhflvo5gM58KqHAeVXN+mlfDBuQf9TB2QKwGuaCb9mg0MhEOIylkHqktrzsduVmZbj2Ukh0hW/LtDolwgSL8N2y0pKmfcuirytSwB/dltdfDYoNIRpBr8IOv+YIO/ehU9PgjkPc+Zm1T/AE0g1ZgwjEFGlIelmVNLv46rAhfmrIXht3Jl4hxBK19P5aTP8dRHTGyPs3FdfOLLVaITuhyGXM7U61j7xjlizPmVjr14TwtSv5wx+GntMycX+gXVmpXqi/RqMVULLBHXqBhi/ah0r09U4nPMopczME/AOAGaAXRMa5s5CwBU1pPccPX1Oj6iTIz230zudFUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=REHIicGVPEL8VP40AzqoiH0Yzl8djrbA4hguUBazmrY=;
 b=37Pvu5rxSd0UFBnmLu1ibJbV2wN+UDDfdOSyTaWKCFvAHrUv2dhZagn6KcwovqbQ2Q7fvhfsmh87W8sXzCPURhGKe7haAHNFv3GUP+YmgVF4GnKNQ4osc4xb772W8AkQNR/HypDbIYDPrIWCiCDNxtWTuarKsMfOZClDxD297xI=
Received: from MN2PR12MB4549.namprd12.prod.outlook.com (2603:10b6:208:268::15)
 by BL0PR12MB4899.namprd12.prod.outlook.com (2603:10b6:208:1cf::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.26; Tue, 2 Mar
 2021 10:53:09 +0000
Received: from MN2PR12MB4549.namprd12.prod.outlook.com
 ([fe80::c1a6:7b2b:9494:776a]) by MN2PR12MB4549.namprd12.prod.outlook.com
 ([fe80::c1a6:7b2b:9494:776a%4]) with mapi id 15.20.3890.029; Tue, 2 Mar 2021
 10:53:09 +0000
From: "Lazar, Lijo" <Lijo.Lazar@amd.com>
To: "Quan, Evan" <Evan.Quan@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/2] drm/amd/pm: update existing gpu_metrics interfaces V2
Thread-Topic: [PATCH 2/2] drm/amd/pm: update existing gpu_metrics interfaces V2
Thread-Index: AQHXDxK/LG0cdfToMkCCL7Y00L5KYqpwgaJg
Date: Tue, 2 Mar 2021 10:53:09 +0000
Message-ID: <MN2PR12MB4549D8D19129793F83AA4A2697999@MN2PR12MB4549.namprd12.prod.outlook.com>
References: <20210302031816.490689-1-evan.quan@amd.com>
 <20210302031816.490689-2-evan.quan@amd.com>
In-Reply-To: <20210302031816.490689-2-evan.quan@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-03-02T10:53:06Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=bb4f8c24-6f22-4b70-865d-075f54f23642;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [49.207.205.214]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d9c8350e-9949-4ace-4d6e-08d8dd695e13
x-ms-traffictypediagnostic: BL0PR12MB4899:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL0PR12MB48995CDA1B5BFE2D0B3BF04B97999@BL0PR12MB4899.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1284;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Oiq/w7yqWaH2IwCdWR9ZutBWeHdk0wQ8YxPp6gwrKihv7xPhaYEQ84NQcmKqpDnYnT+8uyq4a09lzYQpfXwL877q22DY4D6iUBSsPEdj+wLr0Hj+U0nRVPXARB2Qg4sChye6ZceG8+UGlAKd+fyJIrWN7MbPe++JpSdMKNGyaxPgbJMS0W8+n9amEbNPWQ6JS6Z1Dvi15OMurlJNeptWOKeUBalx+ClIRdwysJuSDGGruNDrtXtxg76T6CdlLf+ExcbGtCIdU0EZHgY1jhG8hZjp3SN1bmZrQWQbkVJX80CgSmwgqOpp8lhogr7U+AqL1NfXIPEhycnIyl4QnnVBRNjNpo3QOqYgFMJNUIogQGG1Q14c8e/4zeEY73geZ4tdQ9XN4RezC3dbZLQoa/E9oO2+PnrdN81rzTV83I6iH0ty0LRdiQM7qC7pBiW901o920pQoA+Mct7fRVHpAdWRv2qqqVOxMs81x3q2Fc5EyxM7s8LamtuD/3IuqYSWWSq/smUJyBg11+mNrQN3dSmi8Q==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4549.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(376002)(39860400002)(396003)(366004)(346002)(71200400001)(8936002)(5660300002)(478600001)(316002)(7696005)(186003)(52536014)(83380400001)(30864003)(8676002)(55016002)(15650500001)(19627235002)(76116006)(55236004)(86362001)(110136005)(6506007)(26005)(64756008)(66476007)(53546011)(66556008)(9686003)(33656002)(4326008)(2906002)(66946007)(66446008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?/gWpbtjxPpxBLWfKJS+T9efELZYMjHGzVicoxlRq60jKt+9tD00IBFyOxtoz?=
 =?us-ascii?Q?u9sNrZ4AIGHRFfEfEFKMlSJRAg4azbJHe09Gpa5AUrhhDvmUHsicbv9gieg1?=
 =?us-ascii?Q?Rbrj7+pNLT9SP1+eX7RlQSMcBgEREwT/qiuohWIzzdGaNl8l/GA6sOkvnx1F?=
 =?us-ascii?Q?LEqlfuPAJeAx0wvoqd52DJmHo5eVdKfCGmDKgqA4WwnBlcYiNK+v3P4VYjAj?=
 =?us-ascii?Q?yzOrxQnQ+FN3ZM7t6tE6+apxv/A/fr90qRPwJ/CDIAE1TT3codm7GWc6oT5B?=
 =?us-ascii?Q?Ahy7rCgOxz1z9viT6iJQYQd/VESRM1fM91/wekGLSDaXRk+skh2giFQa65t0?=
 =?us-ascii?Q?86yb7M00lJ9h3yuzpNjvcr61afFY7Edxch6No/e1MdqH2+FZNGFnRFjFoqR7?=
 =?us-ascii?Q?1bzwUUO4ZtqQ9vtnkJHGotNdny3JKWngHRUTIoC3bUEvnHVI3p9I94tcDGE/?=
 =?us-ascii?Q?wshDloA3wx6x7JgghSciKFKUnKnQd/3VqLt+2vmgh2Hkzy5zlXoRjBBSaDsw?=
 =?us-ascii?Q?NX1Zx1hgoPH4+WQLhdaWFy+RGpsi6NO0s5uVgies8GTNj3OeqoIgFpqT5elz?=
 =?us-ascii?Q?8FVHMUxXGpkdqlf28uzQLJ9OTg6tO8CRkHzKtb6vLmguEpakGG41p+WwgKhC?=
 =?us-ascii?Q?LP0thdcQZh+8j0JIkeP5NJK8f/5f9i16p6Yjrnk3G68QJS0ZfENX8spqidOx?=
 =?us-ascii?Q?5S3pN3mRd5r27WFhRvzTLqz+vdHE2b3W6EhWmYmjgIXVgkAQRr7wIy5418CF?=
 =?us-ascii?Q?iUsutG4kWP73fBQ8v6/oQXEbBPkIoyIOWb334Vmv8pSaQJ7bFaNJJRaTf2j7?=
 =?us-ascii?Q?H4rOeHIvfgVCivhNTqRcmaKm3gXlQMUOLb4R8qiKChG85LcPpzY+7lJgfmAm?=
 =?us-ascii?Q?CnDwyIurIYAYkF68D7EZAX85BAIOSLoNI6duRZJ9Yl3ybpWVPyB/aKks/h4e?=
 =?us-ascii?Q?MiB48N0OGft1sfBrZMj34GzIKkDWj4MooPdrFg6OBgwECJVUfOt0z9Qmiu04?=
 =?us-ascii?Q?47qMh/t1XM2Mr2Bbm8f3S5yOFZr0z+drChHZ3WZWzqXC4UqlWqd7mGAbW4aa?=
 =?us-ascii?Q?EKGzgllGCKbbOc0WeMFcIvvCo6xZS86xn2jhuq9Z+QYawdAZLLJ0Bn0hmdph?=
 =?us-ascii?Q?TVj3uXmBIqoX4NjDaGSNfs7WJToZ1mBt4uBmF8vlpb+vX2jugT2zy7DjfBXl?=
 =?us-ascii?Q?B4M0TticqSIocR2Fs4RkHkdEE9T93AaOd95cW8j/2cdW6bu9ToR+qHYZkJtq?=
 =?us-ascii?Q?FZxgcBSmpakux/76LonJpdP7LYSO7G0Tct4vYnUk8smXcvfrelbms4GEgo9/?=
 =?us-ascii?Q?hrKSCdBcB3WkDANQ+c3GqD/g?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4549.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9c8350e-9949-4ace-4d6e-08d8dd695e13
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2021 10:53:09.1019 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zmFAfL9y3rVBpouHSMOjfLmmxIO4jWR9RKU2UdDoMRHvbeNVTp05xMi2Fx50zae5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4899
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

[AMD Public Use]

>> gpu_metrics->energy_accumulator = (uint64_t)metrics.EnergyAccumulator
>> gpu_metrics->pcie_link_width = (uint16_t)metrics->PcieWidth

The casts seem not necessary. 

Series is Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

-----Original Message-----
From: Quan, Evan <Evan.Quan@amd.com> 
Sent: Tuesday, March 2, 2021 8:48 AM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Lazar, Lijo <Lijo.Lazar@amd.com>; Quan, Evan <Evan.Quan@amd.com>
Subject: [PATCH 2/2] drm/amd/pm: update existing gpu_metrics interfaces V2

Update the gpu_metrics interface implementations to use the latest upgraded data structures.

V2: fit the data type change of energy_accumulator

Change-Id: Ibdbb1c3386de12c53bea3b8c68bbeebd14787287
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/pm/inc/smu_v11_0.h        |  8 ++--
 .../gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c | 16 ++++----
 .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   | 40 +++++++++----------
 .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   | 14 +++----
 .../gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c    |  4 +-
 .../gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c  | 10 ++---
 .../gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c   | 10 ++---
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c        |  6 +++
 8 files changed, 57 insertions(+), 51 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h b/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
index d400f75e9202..b5c4aff501ee 100644
--- a/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
+++ b/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
@@ -61,8 +61,8 @@
 #define LINK_WIDTH_MAX			6
 #define LINK_SPEED_MAX			3
 
-static __maybe_unused uint8_t link_width[] = {0, 1, 2, 4, 8, 12, 16}; -static __maybe_unused uint8_t link_speed[] = {25, 50, 80, 160};
+static __maybe_unused uint16_t link_width[] = {0, 1, 2, 4, 8, 12, 16}; 
+static __maybe_unused uint16_t link_speed[] = {25, 50, 80, 160};

 static const
 struct smu_temperature_range __maybe_unused smu11_thermal_policy[] = @@ -290,11 +290,11 @@ int smu_v11_0_get_dpm_level_range(struct smu_context *smu,
 
 int smu_v11_0_get_current_pcie_link_width_level(struct smu_context *smu);
 
-uint8_t smu_v11_0_get_current_pcie_link_width(struct smu_context *smu);
+uint16_t smu_v11_0_get_current_pcie_link_width(struct smu_context 
+*smu);
 
 int smu_v11_0_get_current_pcie_link_speed_level(struct smu_context *smu);
 
-uint8_t smu_v11_0_get_current_pcie_link_speed(struct smu_context *smu);
+uint16_t smu_v11_0_get_current_pcie_link_speed(struct smu_context 
+*smu);
 
 int smu_v11_0_gfx_ulv_control(struct smu_context *smu,
 			      bool enablement);
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
index 50d5f2256480..5bedf0315d14 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
@@ -236,7 +236,7 @@ static int arcturus_tables_init(struct smu_context *smu)
 		return -ENOMEM;
 	smu_table->metrics_time = 0;
 
-	smu_table->gpu_metrics_table_size = sizeof(struct gpu_metrics_v1_0);
+	smu_table->gpu_metrics_table_size = sizeof(struct gpu_metrics_v1_1);
 	smu_table->gpu_metrics_table = kzalloc(smu_table->gpu_metrics_table_size, GFP_KERNEL);
 	if (!smu_table->gpu_metrics_table) {
 		kfree(smu_table->metrics_table);
@@ -2211,7 +2211,7 @@ static void arcturus_log_thermal_throttling_event(struct smu_context *smu)
 	kgd2kfd_smi_event_throttle(smu->adev->kfd.dev, throttler_status);  }
 
-static int arcturus_get_current_pcie_link_speed(struct smu_context *smu)
+static uint16_t arcturus_get_current_pcie_link_speed(struct smu_context 
+*smu)
 {
 	struct amdgpu_device *adev = smu->adev;
 	uint32_t esm_ctrl;
@@ -2219,7 +2219,7 @@ static int arcturus_get_current_pcie_link_speed(struct smu_context *smu)
 	/* TODO: confirm this on real target */
 	esm_ctrl = RREG32_PCIE(smnPCIE_ESM_CTRL);
 	if ((esm_ctrl >> 15) & 0x1FFFF)
-		return (((esm_ctrl >> 8) & 0x3F) + 128);
+		return (uint16_t)(((esm_ctrl >> 8) & 0x3F) + 128);
 
 	return smu_v11_0_get_current_pcie_link_speed(smu);
 }
@@ -2228,8 +2228,8 @@ static ssize_t arcturus_get_gpu_metrics(struct smu_context *smu,
 					void **table)
 {
 	struct smu_table_context *smu_table = &smu->smu_table;
-	struct gpu_metrics_v1_0 *gpu_metrics =
-		(struct gpu_metrics_v1_0 *)smu_table->gpu_metrics_table;
+	struct gpu_metrics_v1_1 *gpu_metrics =
+		(struct gpu_metrics_v1_1 *)smu_table->gpu_metrics_table;
 	SmuMetrics_t metrics;
 	int ret = 0;
 
@@ -2239,7 +2239,7 @@ static ssize_t arcturus_get_gpu_metrics(struct smu_context *smu,
 	if (ret)
 		return ret;
 
-	smu_cmn_init_soft_gpu_metrics(gpu_metrics, 1, 0);
+	smu_cmn_init_soft_gpu_metrics(gpu_metrics, 1, 1);
 
 	gpu_metrics->temperature_edge = metrics.TemperatureEdge;
 	gpu_metrics->temperature_hotspot = metrics.TemperatureHotspot; @@ -2253,7 +2253,7 @@ static ssize_t arcturus_get_gpu_metrics(struct smu_context *smu,
 	gpu_metrics->average_mm_activity = metrics.VcnActivityPercentage;
 
 	gpu_metrics->average_socket_power = metrics.AverageSocketPower;
-	gpu_metrics->energy_accumulator = metrics.EnergyAccumulator;
+	gpu_metrics->energy_accumulator = (uint64_t)metrics.EnergyAccumulator;

 	gpu_metrics->average_gfxclk_frequency = metrics.AverageGfxclkFrequency;
 	gpu_metrics->average_socclk_frequency = metrics.AverageSocclkFrequency; @@ -2280,7 +2280,7 @@ static ssize_t arcturus_get_gpu_metrics(struct smu_context *smu,
 
 	*table = (void *)gpu_metrics;
 
-	return sizeof(struct gpu_metrics_v1_0);
+	return sizeof(struct gpu_metrics_v1_1);
 }
 
 static const struct pptable_funcs arcturus_ppt_funcs = { diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
index 97038e027b39..4a3962fa364f 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
@@ -481,7 +481,7 @@ static int navi10_tables_init(struct smu_context *smu)
 		goto err0_out;
 	smu_table->metrics_time = 0;
 
-	smu_table->gpu_metrics_table_size = sizeof(struct gpu_metrics_v1_0);
+	smu_table->gpu_metrics_table_size = sizeof(struct gpu_metrics_v1_1);
 	smu_table->gpu_metrics_table = kzalloc(smu_table->gpu_metrics_table_size, GFP_KERNEL);
 	if (!smu_table->gpu_metrics_table)
 		goto err1_out;
@@ -2602,8 +2602,8 @@ static ssize_t navi10_get_legacy_gpu_metrics(struct smu_context *smu,
 					     void **table)
 {
 	struct smu_table_context *smu_table = &smu->smu_table;
-	struct gpu_metrics_v1_0 *gpu_metrics =
-		(struct gpu_metrics_v1_0 *)smu_table->gpu_metrics_table;
+	struct gpu_metrics_v1_1 *gpu_metrics =
+		(struct gpu_metrics_v1_1 *)smu_table->gpu_metrics_table;
 	SmuMetrics_legacy_t metrics;
 	int ret = 0;
 
@@ -2621,7 +2621,7 @@ static ssize_t navi10_get_legacy_gpu_metrics(struct smu_context *smu,
 
 	mutex_unlock(&smu->metrics_lock);
 
-	smu_cmn_init_soft_gpu_metrics(gpu_metrics, 1, 0);
+	smu_cmn_init_soft_gpu_metrics(gpu_metrics, 1, 1);
 
 	gpu_metrics->temperature_edge = metrics.TemperatureEdge;
 	gpu_metrics->temperature_hotspot = metrics.TemperatureHotspot; @@ -2658,15 +2658,15 @@ static ssize_t navi10_get_legacy_gpu_metrics(struct smu_context *smu,
 
 	*table = (void *)gpu_metrics;
 
-	return sizeof(struct gpu_metrics_v1_0);
+	return sizeof(struct gpu_metrics_v1_1);
 }
 
 static ssize_t navi10_get_gpu_metrics(struct smu_context *smu,
 				      void **table)
 {
 	struct smu_table_context *smu_table = &smu->smu_table;
-	struct gpu_metrics_v1_0 *gpu_metrics =
-		(struct gpu_metrics_v1_0 *)smu_table->gpu_metrics_table;
+	struct gpu_metrics_v1_1 *gpu_metrics =
+		(struct gpu_metrics_v1_1 *)smu_table->gpu_metrics_table;
 	SmuMetrics_t metrics;
 	int ret = 0;
 
@@ -2684,7 +2684,7 @@ static ssize_t navi10_get_gpu_metrics(struct smu_context *smu,
 
 	mutex_unlock(&smu->metrics_lock);
 
-	smu_cmn_init_soft_gpu_metrics(gpu_metrics, 1, 0);
+	smu_cmn_init_soft_gpu_metrics(gpu_metrics, 1, 1);
 
 	gpu_metrics->temperature_edge = metrics.TemperatureEdge;
 	gpu_metrics->temperature_hotspot = metrics.TemperatureHotspot; @@ -2716,22 +2716,22 @@ static ssize_t navi10_get_gpu_metrics(struct smu_context *smu,
 
 	gpu_metrics->current_fan_speed = metrics.CurrFanSpeed;
 
-	gpu_metrics->pcie_link_width = metrics.PcieWidth;
+	gpu_metrics->pcie_link_width = (uint16_t)metrics.PcieWidth;
 	gpu_metrics->pcie_link_speed = link_speed[metrics.PcieRate];
 
 	gpu_metrics->system_clock_counter = ktime_get_boottime_ns();
 
 	*table = (void *)gpu_metrics;
 
-	return sizeof(struct gpu_metrics_v1_0);
+	return sizeof(struct gpu_metrics_v1_1);
 }
 
 static ssize_t navi12_get_legacy_gpu_metrics(struct smu_context *smu,
 					     void **table)
 {
 	struct smu_table_context *smu_table = &smu->smu_table;
-	struct gpu_metrics_v1_0 *gpu_metrics =
-		(struct gpu_metrics_v1_0 *)smu_table->gpu_metrics_table;
+	struct gpu_metrics_v1_1 *gpu_metrics =
+		(struct gpu_metrics_v1_1 *)smu_table->gpu_metrics_table;
 	SmuMetrics_NV12_legacy_t metrics;
 	int ret = 0;
 
@@ -2749,7 +2749,7 @@ static ssize_t navi12_get_legacy_gpu_metrics(struct smu_context *smu,
 
 	mutex_unlock(&smu->metrics_lock);
 
-	smu_cmn_init_soft_gpu_metrics(gpu_metrics, 1, 0);
+	smu_cmn_init_soft_gpu_metrics(gpu_metrics, 1, 1);
 
 	gpu_metrics->temperature_edge = metrics.TemperatureEdge;
 	gpu_metrics->temperature_hotspot = metrics.TemperatureHotspot; @@ -2767,7 +2767,7 @@ static ssize_t navi12_get_legacy_gpu_metrics(struct smu_context *smu,
 	gpu_metrics->average_socclk_frequency = metrics.AverageSocclkFrequency;
 	gpu_metrics->average_uclk_frequency = metrics.AverageUclkFrequency;
 
-	gpu_metrics->energy_accumulator = metrics.EnergyAccumulator;
+	gpu_metrics->energy_accumulator = (uint64_t)metrics.EnergyAccumulator;
 	gpu_metrics->average_vclk0_frequency = metrics.AverageVclkFrequency;
 	gpu_metrics->average_dclk0_frequency = metrics.AverageDclkFrequency;
 	gpu_metrics->average_mm_activity = metrics.VcnActivityPercentage; @@ -2791,15 +2791,15 @@ static ssize_t navi12_get_legacy_gpu_metrics(struct smu_context *smu,
 
 	*table = (void *)gpu_metrics;
 
-	return sizeof(struct gpu_metrics_v1_0);
+	return sizeof(struct gpu_metrics_v1_1);
 }
 
 static ssize_t navi12_get_gpu_metrics(struct smu_context *smu,
 				      void **table)
 {
 	struct smu_table_context *smu_table = &smu->smu_table;
-	struct gpu_metrics_v1_0 *gpu_metrics =
-		(struct gpu_metrics_v1_0 *)smu_table->gpu_metrics_table;
+	struct gpu_metrics_v1_1 *gpu_metrics =
+		(struct gpu_metrics_v1_1 *)smu_table->gpu_metrics_table;
 	SmuMetrics_NV12_t metrics;
 	int ret = 0;
 
@@ -2817,7 +2817,7 @@ static ssize_t navi12_get_gpu_metrics(struct smu_context *smu,
 
 	mutex_unlock(&smu->metrics_lock);
 
-	smu_cmn_init_soft_gpu_metrics(gpu_metrics, 1, 0);
+	smu_cmn_init_soft_gpu_metrics(gpu_metrics, 1, 1);
 
 	gpu_metrics->temperature_edge = metrics.TemperatureEdge;
 	gpu_metrics->temperature_hotspot = metrics.TemperatureHotspot; @@ -2854,14 +2854,14 @@ static ssize_t navi12_get_gpu_metrics(struct smu_context *smu,
 
 	gpu_metrics->current_fan_speed = metrics.CurrFanSpeed;
 
-	gpu_metrics->pcie_link_width = metrics.PcieWidth;
+	gpu_metrics->pcie_link_width = (uint16_t)metrics.PcieWidth;
 	gpu_metrics->pcie_link_speed = link_speed[metrics.PcieRate];
 
 	gpu_metrics->system_clock_counter = ktime_get_boottime_ns();
 
 	*table = (void *)gpu_metrics;
 
-	return sizeof(struct gpu_metrics_v1_0);
+	return sizeof(struct gpu_metrics_v1_1);
 }
 
 static ssize_t navi1x_get_gpu_metrics(struct smu_context *smu, diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index fba741060000..5e533748449c 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -543,7 +543,7 @@ static int sienna_cichlid_tables_init(struct smu_context *smu)
 		goto err0_out;
 	smu_table->metrics_time = 0;
 
-	smu_table->gpu_metrics_table_size = sizeof(struct gpu_metrics_v1_0);
+	smu_table->gpu_metrics_table_size = sizeof(struct gpu_metrics_v1_1);
 	smu_table->gpu_metrics_table = kzalloc(smu_table->gpu_metrics_table_size, GFP_KERNEL);
 	if (!smu_table->gpu_metrics_table)
 		goto err1_out;
@@ -3119,8 +3119,8 @@ static ssize_t sienna_cichlid_get_gpu_metrics(struct smu_context *smu,
 					      void **table)
 {
 	struct smu_table_context *smu_table = &smu->smu_table;
-	struct gpu_metrics_v1_0 *gpu_metrics =
-		(struct gpu_metrics_v1_0 *)smu_table->gpu_metrics_table;
+	struct gpu_metrics_v1_1 *gpu_metrics =
+		(struct gpu_metrics_v1_1 *)smu_table->gpu_metrics_table;
 	SmuMetricsExternal_t metrics_external;
 	SmuMetrics_t *metrics =
 		&(metrics_external.SmuMetrics);
@@ -3134,7 +3134,7 @@ static ssize_t sienna_cichlid_get_gpu_metrics(struct smu_context *smu,
 	if (ret)
 		return ret;
 
-	smu_cmn_init_soft_gpu_metrics(gpu_metrics, 1, 0);
+	smu_cmn_init_soft_gpu_metrics(gpu_metrics, 1, 1);
 
 	gpu_metrics->temperature_edge = metrics->TemperatureEdge;
 	gpu_metrics->temperature_hotspot = metrics->TemperatureHotspot; @@ -3148,7 +3148,7 @@ static ssize_t sienna_cichlid_get_gpu_metrics(struct smu_context *smu,
 	gpu_metrics->average_mm_activity = metrics->VcnActivityPercentage;
 
 	gpu_metrics->average_socket_power = metrics->AverageSocketPower;
-	gpu_metrics->energy_accumulator = metrics->EnergyAccumulator;
+	gpu_metrics->energy_accumulator = 
+(uint64_t)metrics->EnergyAccumulator;
 
 	if (metrics->AverageGfxActivity <= SMU_11_0_7_GFX_BUSY_THRESHOLD)
 		gpu_metrics->average_gfxclk_frequency = metrics->AverageGfxclkFrequencyPostDs;
@@ -3178,7 +3178,7 @@ static ssize_t sienna_cichlid_get_gpu_metrics(struct smu_context *smu,
 
 	if (((adev->asic_type == CHIP_SIENNA_CICHLID) && smu_version > 0x003A1E00) ||
 	      ((adev->asic_type == CHIP_NAVY_FLOUNDER) && smu_version > 0x00410400)) {
-		gpu_metrics->pcie_link_width = metrics->PcieWidth;
+		gpu_metrics->pcie_link_width = (uint16_t)metrics->PcieWidth;
 		gpu_metrics->pcie_link_speed = link_speed[metrics->PcieRate];
 	} else {
 		gpu_metrics->pcie_link_width =
@@ -3191,7 +3191,7 @@ static ssize_t sienna_cichlid_get_gpu_metrics(struct smu_context *smu,
 
 	*table = (void *)gpu_metrics;
 
-	return sizeof(struct gpu_metrics_v1_0);
+	return sizeof(struct gpu_metrics_v1_1);
 }
 
 static int sienna_cichlid_enable_mgpu_fan_boost(struct smu_context *smu) diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
index 7efb7af51013..9ba4e5980cb0 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
@@ -2128,7 +2128,7 @@ int smu_v11_0_get_current_pcie_link_width_level(struct smu_context *smu)
 		>> PCIE_LC_LINK_WIDTH_CNTL__LC_LINK_WIDTH_RD__SHIFT;
 }
 
-uint8_t smu_v11_0_get_current_pcie_link_width(struct smu_context *smu)
+uint16_t smu_v11_0_get_current_pcie_link_width(struct smu_context *smu)
 {
 	uint32_t width_level;
 
@@ -2148,7 +2148,7 @@ int smu_v11_0_get_current_pcie_link_speed_level(struct smu_context *smu)
 		>> PCIE_LC_SPEED_CNTL__LC_CURRENT_DATA_RATE__SHIFT;
 }
 
-uint8_t smu_v11_0_get_current_pcie_link_speed(struct smu_context *smu)
+uint16_t smu_v11_0_get_current_pcie_link_speed(struct smu_context *smu)
 {
 	uint32_t speed_level;
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
index 3f815430e67f..95167ff59388 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
@@ -210,7 +210,7 @@ static int vangogh_tables_init(struct smu_context *smu)
 		goto err0_out;
 	smu_table->metrics_time = 0;
 
-	smu_table->gpu_metrics_table_size = sizeof(struct gpu_metrics_v2_0);
+	smu_table->gpu_metrics_table_size = sizeof(struct gpu_metrics_v2_1);
 	smu_table->gpu_metrics_table = kzalloc(smu_table->gpu_metrics_table_size, GFP_KERNEL);
 	if (!smu_table->gpu_metrics_table)
 		goto err1_out;
@@ -1401,8 +1401,8 @@ static ssize_t vangogh_get_gpu_metrics(struct smu_context *smu,
 				      void **table)
 {
 	struct smu_table_context *smu_table = &smu->smu_table;
-	struct gpu_metrics_v2_0 *gpu_metrics =
-		(struct gpu_metrics_v2_0 *)smu_table->gpu_metrics_table;
+	struct gpu_metrics_v2_1 *gpu_metrics =
+		(struct gpu_metrics_v2_1 *)smu_table->gpu_metrics_table;
 	SmuMetrics_t metrics;
 	int ret = 0;
 
@@ -1410,7 +1410,7 @@ static ssize_t vangogh_get_gpu_metrics(struct smu_context *smu,
 	if (ret)
 		return ret;
 
-	smu_cmn_init_soft_gpu_metrics(gpu_metrics, 2, 0);
+	smu_cmn_init_soft_gpu_metrics(gpu_metrics, 2, 1);
 
 	gpu_metrics->temperature_gfx = metrics.GfxTemperature;
 	gpu_metrics->temperature_soc = metrics.SocTemperature; @@ -1450,7 +1450,7 @@ static ssize_t vangogh_get_gpu_metrics(struct smu_context *smu,
 
 	*table = (void *)gpu_metrics;
 
-	return sizeof(struct gpu_metrics_v2_0);
+	return sizeof(struct gpu_metrics_v2_1);
 }
 
 static int vangogh_od_edit_dpm_table(struct smu_context *smu, enum PP_OD_DPM_TABLE_COMMAND type, diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
index c9f766cbe227..e3232295f2bf 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
@@ -151,7 +151,7 @@ static int renoir_init_smc_tables(struct smu_context *smu)
 	if (!smu_table->watermarks_table)
 		goto err2_out;
 
-	smu_table->gpu_metrics_table_size = sizeof(struct gpu_metrics_v2_0);
+	smu_table->gpu_metrics_table_size = sizeof(struct gpu_metrics_v2_1);
 	smu_table->gpu_metrics_table = kzalloc(smu_table->gpu_metrics_table_size, GFP_KERNEL);
 	if (!smu_table->gpu_metrics_table)
 		goto err3_out;
@@ -1231,8 +1231,8 @@ static ssize_t renoir_get_gpu_metrics(struct smu_context *smu,
 				      void **table)
 {
 	struct smu_table_context *smu_table = &smu->smu_table;
-	struct gpu_metrics_v2_0 *gpu_metrics =
-		(struct gpu_metrics_v2_0 *)smu_table->gpu_metrics_table;
+	struct gpu_metrics_v2_1 *gpu_metrics =
+		(struct gpu_metrics_v2_1 *)smu_table->gpu_metrics_table;
 	SmuMetrics_t metrics;
 	int ret = 0;
 
@@ -1240,7 +1240,7 @@ static ssize_t renoir_get_gpu_metrics(struct smu_context *smu,
 	if (ret)
 		return ret;
 
-	smu_cmn_init_soft_gpu_metrics(gpu_metrics, 2, 0);
+	smu_cmn_init_soft_gpu_metrics(gpu_metrics, 2, 1);
 
 	gpu_metrics->temperature_gfx = metrics.GfxTemperature;
 	gpu_metrics->temperature_soc = metrics.SocTemperature; @@ -1285,7 +1285,7 @@ static ssize_t renoir_get_gpu_metrics(struct smu_context *smu,
 
 	*table = (void *)gpu_metrics;
 
-	return sizeof(struct gpu_metrics_v2_0);
+	return sizeof(struct gpu_metrics_v2_1);
 }
 
 static int renoir_gfx_state_change_set(struct smu_context *smu, uint32_t state) diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
index aaaf9588d921..80555013ccbb 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
@@ -760,9 +760,15 @@ void smu_cmn_init_soft_gpu_metrics(void *table, uint8_t frev, uint8_t crev)
 	case METRICS_VERSION(1, 0):
 		structure_size = sizeof(struct gpu_metrics_v1_0);
 		break;
+	case METRICS_VERSION(1, 1):
+		structure_size = sizeof(struct gpu_metrics_v1_1);
+		break;
 	case METRICS_VERSION(2, 0):
 		structure_size = sizeof(struct gpu_metrics_v2_0);
 		break;
+	case METRICS_VERSION(2, 1):
+		structure_size = sizeof(struct gpu_metrics_v2_1);
+		break;
 	default:
 		return;
 	}
--
2.29.0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
