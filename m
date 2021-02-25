Return-Path: <SRS0=Rd3N=H3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C7E0C433DB
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Feb 2021 20:16:32 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 218AA64F2B
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Feb 2021 20:16:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 218AA64F2B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ACFE06E111;
	Thu, 25 Feb 2021 20:16:31 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760081.outbound.protection.outlook.com [40.107.76.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0DAE56E111
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Feb 2021 20:16:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EGvnN+eXcseekvy4/u6+uEjkikkPULcpOuGdbFx/LWc7c4WXm5jjPeEuyhiYbMZierHGQhJKzwI933YEscpKBUufZ6BN/3560hbiuM/Bemon16igLv9/XBM9ew3VYpvt5BJ6zDV1o8Q/erjPMnTzxnkcsy3O4wryKkMSlaG0RUmvAq5T0e0o8RZTTtdHwonsrVDHeR0rTq89zX3bMAhVeWvLp5/mTkMsGo+6ApNeyETYrU5tcpjjRNWr8IWCUc9ucmHZbefIvHKS5QGepV0dI+7tYiWHEmOG6CWD/cpDqZwSTMBMf5C45yaRBucf6Evmun557Q30CYkY6OhDDLtv5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lQIvnmVlwkyOl0hqCJD2UolvcGo28cMoEPONSE96ePc=;
 b=Nl1Thbk4OrJvgfeIpq1OTFCRAClJWu708Czo+V3qnImXl3Gy6b9NL8Xt1hkoxTqBEToDe7HAn1jFvi7uCfih8S104c3eXpn/QtA8NfKIHOiA4pceSnKtosNJGinWLdrAEWII3P3bFPLRPYjCUyz8C1VtAh1RzfyjKuXn2sSe9Gfjl9eaeMHJsIOJvUeWM/C0Ag6ORNKrWQXdb3JBMZpsff1pgYGo2N52/WbwnF0NehZqBPdZ/pJhG4OqandDImo33VMuA4I1+7mL4aTIN83lJtwJKQTI8CZoETjPWBnQ76Mk2SY3eSAR/xwBEPjvJj8ojY9pEe4Oyy1tGVb5Bxce6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lQIvnmVlwkyOl0hqCJD2UolvcGo28cMoEPONSE96ePc=;
 b=IyAXedP2E91AlBus4BcNBJNj1Wfs9MfmQyZA1kCCGstOSkzUlKcay6VBOd6eTWMQQTsYrFXFvRPviD2FP31lhqwyEqhlkeyRqYEiq5HscA1/bVTR21/Rq+hLj/Hxiq/Dn3nvsxr1UC7Yzx+x9Vr8AE80MZjdbKmwR4ir2GaS/kE=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB3872.namprd12.prod.outlook.com (2603:10b6:208:168::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19; Thu, 25 Feb
 2021 20:16:29 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af%7]) with mapi id 15.20.3890.020; Thu, 25 Feb 2021
 20:16:29 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/5] drm/amdgpu: add asic callback for querying video codec
 info (v3)
Date: Thu, 25 Feb 2021 15:16:10 -0500
Message-Id: <20210225201614.896990-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.29.2
X-Originating-IP: [165.204.84.11]
X-ClientProxiedBy: BL0PR05CA0023.namprd05.prod.outlook.com
 (2603:10b6:208:91::33) To MN2PR12MB4488.namprd12.prod.outlook.com
 (2603:10b6:208:24e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from tr4.amd.com (165.204.84.11) by
 BL0PR05CA0023.namprd05.prod.outlook.com (2603:10b6:208:91::33) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3912.9 via Frontend Transport; Thu, 25 Feb 2021 20:16:28 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 8ef7607c-ebf3-4168-c71e-08d8d9ca3c2a
X-MS-TrafficTypeDiagnostic: MN2PR12MB3872:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB38726AE41D376067A575179AF79E9@MN2PR12MB3872.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HLv5ue1C4VT4twriODXXAxctB/KGFjG1QP+NHzLXF0mC+XRQALiDwgPksJuZHplQHYpqz1FyP9nP1T2Fwl9s1gHWuHSgR7VGBZ4uIynymCrn+MxVfCPozoVOmogGyV005HRHZ5jnpt+FjcgvRbRg9zcYNX05tFWXhUnleDw3fV4MTnD+GEqmARAQbfbTSSCRjhjtT2sDnSTyKQbctUXTay7XEPYw22FvbkAElJQwJmykJv0KqMwLHxK3KTTOYz7Tp3+mrHTsEqkRebgVv4937XiCr0EkBiRtb04XLvpZjGyEwIOr3/DfN8T5Ww5C2MQnbJGEvJr1pCBtghSOS/00rEBfzk1r+7jKuYP0TkjK3/lDyJsE1Cbr97/KLmBiTPH078Tj+hLM+/O97PAaY9c+62739jmfF92DAThIJ2sg4tTCJ7+Zzqiu9E+WdVaqEc8qf5WgX9ddAfyg9GMmcTtFhUAxlZr3qhkKU6luDenEz0cFrMCmbMxEgy5GsFQ64U2vLlLPLNdB4kl5AApkkWcvWQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(39860400002)(376002)(136003)(366004)(346002)(66556008)(316002)(66476007)(26005)(54906003)(8676002)(1076003)(2616005)(7696005)(52116002)(956004)(4326008)(186003)(86362001)(6916009)(8936002)(36756003)(16526019)(6666004)(83380400001)(5660300002)(6486002)(478600001)(66946007)(2906002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?k/eDZOUC7biXAsE808G3TCaP5hNKDfRGTRDyvO5ndokELG00MEN1JA24oCyE?=
 =?us-ascii?Q?PTbGaxiEkBCYj+uEcCfINo41nylWjtEHCQkEDHwJXlv4Aoy5ixTkoG4fwfPj?=
 =?us-ascii?Q?SqTFpESyryGKp+tq4ZYpNIKTgDX1lYBPcyPRH9k6wg0ojRqfmYzp+GjXiTR1?=
 =?us-ascii?Q?HkXIeyIgcEmYfxJ43dglMqJMprJXOGVZCXQirY8A6uHWtccFiezOT4PKWLY7?=
 =?us-ascii?Q?MP6Nwg4feaZHccOjw2GI/Ex7QMhxqvCL3ceuuIzT/3oxMvRWs5qAN4eeu0mB?=
 =?us-ascii?Q?RJzYSCEkH2N++x7eB00kHdYMeoxpCF8TGps2DHrYgPmM2cgAmZCeJX9QpzEQ?=
 =?us-ascii?Q?xYMYHihyukc0lJ12lV3lXIiS5AwtqGLT0TTPGwLqPO0eg/jjpKW6cBAY7cpH?=
 =?us-ascii?Q?++GadGR5Q3uS4EbtAahp924qnEnWDdNKZ3/ySCrbZemA+9NOPEnqwC+De2MO?=
 =?us-ascii?Q?d4Iwc2FgMe2HlYusQghp5TNp0WqfyjYtSd4QUfjDubNJjPjCQOulddy3x517?=
 =?us-ascii?Q?pJr+5OauvGtYQUanNa0YxL92bFUVwdSPXEjkkVF+HfWlwAa225+qPtrVYULh?=
 =?us-ascii?Q?QMZwodxKgcinAbVXNEfw+pkkI0KEOtvII7wyEYDZdX+dndEOO3d3EmFTBxtM?=
 =?us-ascii?Q?AumycsIaRe26mnD8RXS2vxJ40SGZrXjK+g55OFprttAypJ6atqbtLou0JQF1?=
 =?us-ascii?Q?Q7EnfclYtkrc32j4t1E4uAc52v/dCnXS+c2O+cQzZ3iYUfRiIKiswW8phe/s?=
 =?us-ascii?Q?qM0KPXuSp3607hGGWUYHErKJ7pNV6r+03PPJ0p3jyVSFMiCb1SV78a7PkDUT?=
 =?us-ascii?Q?cQo/DeHDol1vWCqSEUmS8f91gLpQWzcIW4LVBwSeIAtQLCC6O5Zd8Vy59boU?=
 =?us-ascii?Q?YglWc5lQFsN0ua+9uCcDv2ZIX+sa1daVJvoKlaSaH5/m5+Z9f14ZukM9Wq0j?=
 =?us-ascii?Q?TsQQZS8zPF+epzsZwa6WeUh8ouFYtLKdDqayRqbyvFOOcaYCf5D5RDjaZNDc?=
 =?us-ascii?Q?QzUIQe+FD3KdNg+2sUILa7OGDY0oQxTh8WTL2fglWgPMCKaKPKxqbZbj5FMz?=
 =?us-ascii?Q?QAE+zTL/WOtXUwqxHAjYnzFN2JiKysgU6K4aYGyt5pdKUgCxAYGY5degEQ94?=
 =?us-ascii?Q?YGd2KyGQ+Len/CEWCuWLxRgQyN9v2hCyNoZzDIqFrQjdsjQdNw2mC7WjxgSH?=
 =?us-ascii?Q?idDQZELh7LGdkxRjXYLEiCkhncNv220hDkXSlXuXseiYvOqSv1Zn4ci/66LW?=
 =?us-ascii?Q?tJcDcqft8KZmLnfUqD7qKeeD/03cZpF3WAtC+2sVmPeFE+WbxpEdBE+g2VNk?=
 =?us-ascii?Q?bnLSrajxFv8nlZJMKSK/RcQA?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ef7607c-ebf3-4168-c71e-08d8d9ca3c2a
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2021 20:16:29.1740 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d8H4LYKLEcq5DqvXIJZ1YVMbbPOV9RNmIraKQrqMlKJ0LsTQIUdx6pMyeWH+N/9DoSDfhldGZJg5c8gLW259DQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3872
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Leo Liu <leo.liu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This will be used by a new INFO ioctl query to fetch the decode
and encode capabilities from the kernel driver rather than
hardcoding them in mesa.  This gives us more fine grained control
of capabilities using information that is only availabl in the
kernel (e.g., platform limitations or bandwidth restrictions).

v2: reorder the codecs to better align with mesa
v3: add max_pixels_per_frame to handle the portrait case

Reviewed-by: Leo Liu <leo.liu@amd.com> (v2)
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 22e5d9f284c3..09aec16c8feb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -583,6 +583,28 @@ enum amd_reset_method {
 	AMD_RESET_METHOD_PCI,
 };
 
+#define AMDGPU_VIDEO_CODEC_TYPE_MPEG2			0
+#define AMDGPU_VIDEO_CODEC_TYPE_MPEG4			1
+#define AMDGPU_VIDEO_CODEC_TYPE_VC1			2
+#define AMDGPU_VIDEO_CODEC_TYPE_MPEG4_AVC		3
+#define AMDGPU_VIDEO_CODEC_TYPE_HEVC			4
+#define AMDGPU_VIDEO_CODEC_TYPE_JPEG			5
+#define AMDGPU_VIDEO_CODEC_TYPE_VP9			6
+#define AMDGPU_VIDEO_CODEC_TYPE_AV1			7
+
+struct amdgpu_video_codec_info {
+	u32 codec_type;
+	u32 max_width;
+	u32 max_height;
+	u32 max_pixels_per_frame;
+	u32 max_level;
+};
+
+struct amdgpu_video_codecs {
+	const u32 codec_count;
+	const struct amdgpu_video_codec_info *codec_array;
+};
+
 /*
  * ASIC specific functions.
  */
@@ -627,6 +649,9 @@ struct amdgpu_asic_funcs {
 	void (*pre_asic_init)(struct amdgpu_device *adev);
 	/* enter/exit umd stable pstate */
 	int (*update_umd_stable_pstate)(struct amdgpu_device *adev, bool enter);
+	/* query video codecs */
+	int (*query_video_codecs)(struct amdgpu_device *adev, bool encode,
+				  const struct amdgpu_video_codecs **codecs);
 };
 
 /*
@@ -1221,6 +1246,7 @@ int emu_soc_asic_init(struct amdgpu_device *adev);
 #define amdgpu_asic_pre_asic_init(adev) (adev)->asic_funcs->pre_asic_init((adev))
 #define amdgpu_asic_update_umd_stable_pstate(adev, enter) \
 	((adev)->asic_funcs->update_umd_stable_pstate ? (adev)->asic_funcs->update_umd_stable_pstate((adev), (enter)) : 0)
+#define amdgpu_asic_query_video_codecs(adev, e, c) (adev)->asic_funcs->query_video_codecs((adev), (e), (c))
 
 #define amdgpu_inc_vram_lost(adev) atomic_inc(&((adev)->vram_lost_counter));
 
-- 
2.29.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
