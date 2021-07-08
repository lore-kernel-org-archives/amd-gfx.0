Return-Path: <SRS0=sNMb=MA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57A5DC07E95
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Jul 2021 03:38:04 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E8B861CDA
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Jul 2021 03:38:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E8B861CDA
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A6CD36E20F;
	Thu,  8 Jul 2021 03:38:03 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2057.outbound.protection.outlook.com [40.107.220.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A3B306E20F
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Jul 2021 03:38:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PqTq2s4Liee7HIVZ0Y29IuPnuw1ti0CU67+Vha1R2tHjbC2kGBYNuE30O0nNNv0xyfTtVIt/oohvsgU0wyYktNAl4/XK7W+l/GfHOmLmlpmZ38mpMGPd1ESHx5aGEnnjDZZ/48BIXPhHAv/oSZiaZD6thyq22pTV1RYXPLnYzOItqqg4RZ+NdKvwM3Hpitj2QTgLGws1+NcYqDLwdg1EK2PmbEi1y97+AqQwD1hVqfEyjF8KInvY5hTI5zTRcCaTe4nv6WY7CCXCkz3pq4hODt73UjjU7EQD03Wny0GUetafiG07RZFo1rV+1u7kL9AinVAdWv/+d+E8//kja3RmbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bA3QxKl/F6t+ftCgyRl1qa6exKjmtUEMcHRCv9lNv5Q=;
 b=bLpJvL+LHzPlKeQeae7cYYruzdGtP8hKMN4yUOyr/465YLowYg5W7P0TITZjWpHuC7x8ZjOgbookTmtacjfKZdbinzMoN7KK4140HCs2M10e1naI8cmyAHVmL5PcYc/AWRFEviE5KFQD+p2dn0IfVIUcYUAVg/h7zM908o35CnUE1WPSY7jqHNFA7nfyA82f/8VoMN1OQo3Ejm7+ujXjegDBGs6+Fj6qrX1OZPHlhOj77yQ4/Jc3Xc6uXbvtV+ILL59gqcv+lcIAycujbFJ4kywQivIRD1TwTzGzIkrUb4bJcOBHvKyQ280oFR88pPXTA2pwmA1aDrxJtHznfLHdQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bA3QxKl/F6t+ftCgyRl1qa6exKjmtUEMcHRCv9lNv5Q=;
 b=00DifbWdTnUNfAspSKN372+36+A8KZrEF6ss2Z/SuXzs6Bw8zn0/VB2w4Jb1R+s7Fz8wwN0siA1mS10sK/ftfB0T/9metseJXjXgFZP6fWtZ9hbRoLRrlPVdtcX7jWonyEwKjJOGl6ETkpxssMe6eBrTXi+rO2KjZIPgWCeit3I=
Received: from CY4PR12MB1287.namprd12.prod.outlook.com (10.168.168.136) by
 CY4PR12MB1333.namprd12.prod.outlook.com (10.168.169.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4287.32; Thu, 8 Jul 2021 03:37:53 +0000
Received: from CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::2cb6:690b:e6a0:d008]) by CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::2cb6:690b:e6a0:d008%3]) with mapi id 15.20.4308.021; Thu, 8 Jul 2021
 03:37:53 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Yang, Stanley" <Stanley.Yang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH Review 1/1] drm/amdgpu: initialize umc ras function
Thread-Topic: [PATCH Review 1/1] drm/amdgpu: initialize umc ras function
Thread-Index: AQHXc6lZt8XlnSkKm0uQlucw6o0mtKs4bYeA
Date: Thu, 8 Jul 2021 03:37:52 +0000
Message-ID: <CY4PR12MB12870EBB6A75EFB4FD0D1A9DF1199@CY4PR12MB1287.namprd12.prod.outlook.com>
References: <20210708032821.23553-1-Stanley.Yang@amd.com>
In-Reply-To: <20210708032821.23553-1-Stanley.Yang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2021-07-08T03:37:49Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=290c1343-e086-4845-aef6-855ec32eecea;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0419d1d5-0d06-4c81-84f8-08d941c1c47f
x-ms-traffictypediagnostic: CY4PR12MB1333:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR12MB13335ECAA66C45D0F8F7EA07F1199@CY4PR12MB1333.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1923;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sYwaA89J1TPlk2TXAUvytf9FUWTHfVhP/S/WcTCt1FfIEVki+do78SxXGmSiWOCnz11k92vJvAc/oFNO4eaGOvioRpvOeFWYAwAImTdUX5cpN2zoYvk//9vmGuk5v7nhuGxCWJcK6jiKvuvvB0XtccieI2OF8998Dhw8yDGRZ5M8V1dz9D6jYSpeecesE1A/S97mvJULSTatgrp7UsIQEGvfbNV/+ZTG/X9F/XK2hMRFjpF2FyHUf4FiYEy1w2f9Thpo7Kma5JlIYD5WxbD1I7QAYV8DpNrtkSms+QmqGOOrzSpxMSd+QaJh6qqfI+3eGetdLHB+1O4+HRrjerGanMrjl6H6TNowdzOUTFQQLemLdEkNdpCCnVRJBgD7GsTwts0vq9KSjburFRQl4i3WfjTfQeTDgFOKvQSSA+d20fwuJDV/Lm79rB0uOB6m43x4wMERXXJ5A5pRTLz+U32pc2o4XPrsCqfF/lkWCNqy2Pxfw/YGzmJkGBu6mAAvaC2irIBsEtRU48JNroMhr8tqNb2Nmnbol3zKyE4M7jvVd3rdjkXEpUR7riKe6UnsikSHOjU/684uLu04Ul5qP742YzX73+qT9BlOOnw1rvHhl+B2MQZGr4kAozStrGOBnc5ILrpTJLHxTojW0Wb39Fn+Ig==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1287.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(39860400002)(376002)(396003)(136003)(346002)(5660300002)(38100700002)(86362001)(8936002)(66446008)(64756008)(122000001)(45080400002)(76116006)(26005)(4326008)(966005)(53546011)(110136005)(33656002)(478600001)(8676002)(316002)(71200400001)(2906002)(66946007)(6506007)(83380400001)(54906003)(52536014)(55016002)(66556008)(7696005)(186003)(66476007)(9686003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?/LyUv9xv1+KgVMNg4iG9QooxYkB8dchCa39y7gd22pQvL63FLl9/KqkXR7nV?=
 =?us-ascii?Q?9mu+d1HJLfZSAf8re7rTg/zpE4KnYd4eoDbfL/8bNRzRzAkmA8qBF7VzQLYC?=
 =?us-ascii?Q?REqc/y5CQo3KX4JsMD8nGlTxmyqoO/q1eV0suIlpx3hwsKnsPOsDN9llELuW?=
 =?us-ascii?Q?zl6CXAbLkMbqmZvihlL6oTafUXGyXSU5aNuQ73QFUFwjGLZuceq+1hK+707x?=
 =?us-ascii?Q?xLRDdYxS1oIW3RkWeF5/P6XtSkGtTd8Pi7d7Gb1WTJASdam3SbGe3JUKS0gc?=
 =?us-ascii?Q?DT015M8E4EPC/YQ0Zib1bFihyWeN4dVxTNPx1bs/CYZhgcQ9e/DK8z3ZSbF2?=
 =?us-ascii?Q?n+CcG8rlLh4lLxNwO2IHkWA/b2/qD+Ol4cQMn57GTbweGYcZhbwUZZ0/e6hI?=
 =?us-ascii?Q?24Hp+BHmcWCBqFHlgRcC12OwAzb3L/ixVb1fDbhHIHSx9f9aU5AWGkpBWVdr?=
 =?us-ascii?Q?KBbjz/aNH0VzyB+rJ94JSSrgFeBxFlmsZ0j3Ap5QZkwGLIZiXEbE/5/sqNNO?=
 =?us-ascii?Q?39bssIOSjnm15IYEoBbOhFs1+f5Bo7JmpmT+j/RsRZKQ2BVMiQbxqUjGn56N?=
 =?us-ascii?Q?hg1HNnG1K4WstEuF0tV2bPGP2P5+TNmL+gbUqaQEPr3yxaOEkbRSjUZ5MJaA?=
 =?us-ascii?Q?VDxizgzYhN6Itk6LHtROY+hxi+Jr4QOfRfvHi1HVdFZJBfTDZa08ngDlanM6?=
 =?us-ascii?Q?ZjUIloOpsqL7RA7+uvpoDohoegrfv3AK5RvIOwL5BTeza1KFMZU+gZIYQV+m?=
 =?us-ascii?Q?jQSRWyj6+ocHWUUjoKqJ/hTmy6Qzsckv8k3QPtzbF/LfzlhPuENvvlzKeq+I?=
 =?us-ascii?Q?Amt/PymlJnRD4ITCQobVPDFf0QIk3CwR7a2lqXVyNCosdu/DrIrjdcwKOCFk?=
 =?us-ascii?Q?FUerMJUuLtGhYU5hnPDH6u/upmBszh2KUXvHULGlJL4Xeav8ooV9DqgJz5hV?=
 =?us-ascii?Q?1K0katrUVXjQvWUN660FpBPnKNY1ylG2/SzxMcUFFbKkmCtT/rLkAB8pWvdO?=
 =?us-ascii?Q?+rzHd98bXQQtUfGLwIC6aupi8m4qzNBmNLDKGRVWRbu7kmYHn+8XR1EJ+U8w?=
 =?us-ascii?Q?K5p9AVVadY4fBqUtXnYNJcR75/I6/QPDfeUcR8wsY/IjA0uBvUKH7D7a4UKH?=
 =?us-ascii?Q?7lnTCB3csvXg7pMk6YW8RcmQD7/qaImpOctd/4q+lPUPzCDHdOwhsb14FF9j?=
 =?us-ascii?Q?2kbxoESLLVootxiDQOAVMqa7uNY6rsjVIL5kOSt3v3g1g7x5uDY8hVBP2JJQ?=
 =?us-ascii?Q?OD2FJatA53PArms4lJiwxDYZtz33vp4AWDUkIXm8DRzenLseGSy661DtPBQX?=
 =?us-ascii?Q?LELiAVFnjZTiG1+DRFhSJuon?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1287.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0419d1d5-0d06-4c81-84f8-08d941c1c47f
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2021 03:37:52.8451 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: U0B+ZG0fopaYI0mm3PUxBgh5OF/SflqhMurx3aaKbMoqLKvYQM3OH4ACswatsMh5Fftdh7VoNEZTdx80bzvF5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1333
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Clements,
 John" <John.Clements@amd.com>, "Yang, Stanley" <Stanley.Yang@amd.com>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Public]

+		{24, 8, 2, 18},		{15, 31, 5, 21},
+		{19, 3, 9, 25},		{28, 12, 6, 22},

The coding style should be corrected. With this fixed, the patch is:
Reviewed-by: Guchun Chen <guchun.chen@amd.com>

Regards,
Guchun

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Stanley.Yang
Sent: Thursday, July 8, 2021 11:28 AM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Yang, Stanley <Stanley.Yang@amd.com>; Clements, John <John.Clements@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>
Subject: [PATCH Review 1/1] drm/amdgpu: initialize umc ras function

From: John Clements <john.clements@amd.com>

support umc ras function initialization for aldebaran

Change-Id: I84155d4d3eaae86a8c1bd2331b1964946c47f6da
Signed-off-by: John Clements <john.clements@amd.com>
Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c | 13 +++++++++++++  drivers/gpu/drm/amd/amdgpu/umc_v6_7.c | 15 +++++++++++++++  drivers/gpu/drm/amd/amdgpu/umc_v6_7.h | 12 ++++++++++++
 3 files changed, 40 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 3332c9e0a4e2..42d7244573b5 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -53,6 +53,7 @@
 #include "mmhub_v1_7.h"
 #include "umc_v6_1.h"
 #include "umc_v6_0.h"
+#include "umc_v6_7.h"
 #include "hdp_v4_0.h"
 
 #include "ivsrcid/vmc/irqsrcs_vmc_1_0.h"
@@ -1163,6 +1164,18 @@ static void gmc_v9_0_set_umc_funcs(struct amdgpu_device *adev)
 		adev->umc.channel_idx_tbl = &umc_v6_1_channel_idx_tbl[0][0];
 		adev->umc.ras_funcs = &umc_v6_1_ras_funcs;
 		break;
+	case CHIP_ALDEBARAN:
+		adev->umc.max_ras_err_cnt_per_query = UMC_V6_7_TOTAL_CHANNEL_NUM;
+		adev->umc.channel_inst_num = UMC_V6_7_CHANNEL_INSTANCE_NUM;
+		adev->umc.umc_inst_num = UMC_V6_7_UMC_INSTANCE_NUM;
+		adev->umc.channel_offs = UMC_V6_7_PER_CHANNEL_OFFSET;
+		if (!adev->gmc.xgmi.connected_to_cpu)
+			adev->umc.ras_funcs = &umc_v6_7_ras_funcs;
+		if (1 & adev->smuio.funcs->get_die_id(adev))
+			adev->umc.channel_idx_tbl = &umc_v6_7_channel_idx_tbl_first[0][0];
+		else
+			adev->umc.channel_idx_tbl = &umc_v6_7_channel_idx_tbl_second[0][0];
+		break;
 	default:
 		break;
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c b/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c
index 3a8f787374c0..7da12110425c 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c
@@ -28,6 +28,21 @@
 #include "umc/umc_6_7_0_offset.h"
 #include "umc/umc_6_7_0_sh_mask.h"
 
+const uint32_t
+	umc_v6_7_channel_idx_tbl_second[UMC_V6_7_UMC_INSTANCE_NUM][UMC_V6_7_CHANNEL_INSTANCE_NUM] = {
+		{28, 12, 6, 22},	{19, 3, 9, 25},
+		{20, 4, 30, 14},	{11, 27, 1, 17},
+		{24, 8, 2, 18},		{15, 31, 5, 21},
+		{16, 0, 26, 10},	{7, 23, 29, 13}
+};
+const uint32_t
+	umc_v6_7_channel_idx_tbl_first[UMC_V6_7_UMC_INSTANCE_NUM][UMC_V6_7_CHANNEL_INSTANCE_NUM] = {
+		{19, 3, 9, 25},		{28, 12, 6, 22},
+		{11, 27, 1, 17},	{20, 4, 30, 14},
+		{15, 31, 5, 21},	{24, 8, 2, 18},
+		{7, 23, 29, 13},	{16, 0, 26, 10}
+};
+
 static inline uint32_t get_umc_v6_7_reg_offset(struct amdgpu_device *adev,
 					      uint32_t umc_inst,
 					      uint32_t ch_inst)
diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v6_7.h b/drivers/gpu/drm/amd/amdgpu/umc_v6_7.h
index 4eb85f247e96..aa282687e0e4 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v6_7.h
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v6_7.h
@@ -32,6 +32,18 @@
 
 #define UMC_V6_7_INST_DIST	0x40000
 
+/* number of umc channel instance with memory map register access */
+#define UMC_V6_7_CHANNEL_INSTANCE_NUM		4
+/* number of umc instance with memory map register access */
+#define UMC_V6_7_UMC_INSTANCE_NUM		8
+/* total channel instances in one umc block */
+#define UMC_V6_7_TOTAL_CHANNEL_NUM	(UMC_V6_7_CHANNEL_INSTANCE_NUM * UMC_V6_7_UMC_INSTANCE_NUM)
+/* UMC regiser per channel offset */
+#define UMC_V6_7_PER_CHANNEL_OFFSET		0x400
 extern const struct amdgpu_umc_ras_funcs umc_v6_7_ras_funcs;
+extern const uint32_t
+	
+umc_v6_7_channel_idx_tbl_second[UMC_V6_7_UMC_INSTANCE_NUM][UMC_V6_7_CHA
+NNEL_INSTANCE_NUM];
+extern const uint32_t
+	
+umc_v6_7_channel_idx_tbl_first[UMC_V6_7_UMC_INSTANCE_NUM][UMC_V6_7_CHAN
+NEL_INSTANCE_NUM];
 
 #endif
--
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7Cguchun.chen%40amd.com%7Ce8096b1d4d444569123808d941c07a33%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637613117226702014%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=5UII5U8c3Yqr5X89XRGe7uSLThqrRqnyovL3gWSL0vg%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
