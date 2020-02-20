Return-Path: <SRS0=opbO=4I=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A12E9C11D00
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Feb 2020 08:36:19 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6273B24654
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Feb 2020 08:36:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="zFTgZ1oV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6273B24654
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 171696ECEF;
	Thu, 20 Feb 2020 08:36:19 +0000 (UTC)
Received: from NAM04-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr700071.outbound.protection.outlook.com [40.107.70.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 161466ECEF
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Feb 2020 08:36:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cdgfsEoQE/88ez0xS7h8wAjdC+ystRMg2/PdUU54/EuKorooqw9dXXJuyvPm8ulRKLGktUwkBAKTHPrE3xtur80JPnP0DWLFpkspM8GZ7lhIbgjbEGN2zzpkdMNDlmP8PeS0BqdTJfYbJyUmCH32oLCjnuJFW3os7Spro7pbMC1rTI1D2Ui54GAyWy9Iz2PYu7k0OKcj1koSkNZdqEd/MSJr8hrLGC9CDSbGhWnOZfgHdWz2UbY/Yw1KHklZPwcwPq9BXUIS2cVn7X4QFOGyK7uo1kEphAXNXBFJwl/ektWpWwlNfjmukblfnQR57YCGpxTDEHfXoeDvWR0HQp8V6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O54L9JEBcX/IGx3LZAaMdimzMjILGeKOms4L7yK+Xrs=;
 b=LldWTfV12q7kU6vCP1t0vXn6GpTwifdCs40xR5wL7S8gb1ygFBGBGgCHOCFUtUWRZBwDAypS8HiRoTiQ6FJkIftTvdiFA+5JdyK+ttk8d8RK6eSdTQT7ZT1b4tW4rzuxxK0DvToumODTRztzlv58YiCSN67LJOTbleMZZixcCXbVmg3X03kF6drP5ihZicqi6FqGofLZRPazDd+r05VFZPXqYbecfPOwKkhn3JVJqs0RDWi/wNfhuhfJ5WeaF9GO4/7Gkdt66/INejxMNnpHbx3V+KeK7OMBpY3X5AKT4IqpS5Jv/EAEoJ/wh6y7LER3LWLe4QfsllswPDsuS5aG1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O54L9JEBcX/IGx3LZAaMdimzMjILGeKOms4L7yK+Xrs=;
 b=zFTgZ1oVqUGRBbyPDsmG/y/DnuJtfBTyZMH3Vy+Nkk9i/T8eb17yR1K2fSXtytDl24/ylGM/3bkQf0ioSDxuBWk40bhRL8eKRBuHniT66k5lVQonQoa9ke0va/4ygcGujBr8788fE9x/X34ELQsLNpDq6lVzdPIbTFwJMPiQKC8=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Shirish.S@amd.com; 
Received: from CH2PR12MB3654.namprd12.prod.outlook.com (10.255.155.212) by
 CH2PR12MB3704.namprd12.prod.outlook.com (52.132.231.218) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.23; Thu, 20 Feb 2020 08:36:16 +0000
Received: from CH2PR12MB3654.namprd12.prod.outlook.com
 ([fe80::5d7f:984a:5134:c469]) by CH2PR12MB3654.namprd12.prod.outlook.com
 ([fe80::5d7f:984a:5134:c469%4]) with mapi id 15.20.2750.016; Thu, 20 Feb 2020
 08:36:16 +0000
From: Shirish S <shirish.s@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] amdgpu/gmc_v9: save/restore sdpif regs during S3
Date: Thu, 20 Feb 2020 14:05:49 +0530
Message-Id: <20200220083549.98097-1-shirish.s@amd.com>
X-Mailer: git-send-email 2.17.1
X-ClientProxiedBy: MA1PR01CA0143.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:71::13) To CH2PR12MB3654.namprd12.prod.outlook.com
 (2603:10b6:610:22::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from amd-WhiteHaven.amd.com (165.204.156.251) by
 MA1PR01CA0143.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:71::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.17 via Frontend Transport; Thu, 20 Feb 2020 08:36:15 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.156.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 62ac205a-a7b5-49de-c889-08d7b5dff383
X-MS-TrafficTypeDiagnostic: CH2PR12MB3704:|CH2PR12MB3704:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR12MB3704B7A3E90791F0AC0F35FDF2130@CH2PR12MB3704.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:107;
X-Forefront-PRVS: 031996B7EF
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(136003)(346002)(396003)(366004)(376002)(199004)(189003)(54906003)(4326008)(2906002)(478600001)(66946007)(1076003)(7696005)(66476007)(956004)(6666004)(66556008)(36756003)(81166006)(81156014)(186003)(6486002)(6916009)(8936002)(2616005)(5660300002)(86362001)(26005)(8676002)(52116002)(316002)(16526019);
 DIR:OUT; SFP:1101; SCL:1; SRVR:CH2PR12MB3704;
 H:CH2PR12MB3654.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: suiF8Ul+FBrdqmLB71G/dHylY4FStgkGrpVywVisRy0r2w0pAR/DoM4E4ak20VMI+oXod5ddufPxcQ2RFbgC0ToGeK3DHXGs+5iWZJDFOsUcEA/Z+NuTzaWq6CfMvJ2BIaVzPyamIk+FvcOQShJgzNXkXymCHHnwQI41f+wLW66RFCT65G+7sjEo4SUWQKY07J0AvnHZq24gEgQvqN8j5zkLHx2FKzXle23ksJMvkA6b7kXm1zS5jg7VIC1CmyiYIPHxkveTmr/iJZS6HABnhA/S64TJjnulvJfJdps0XaFKMTeTyQm6d9m19jPptZn/oduC32nLXcuu2AHYFpZ8KLks840DA7Y8aV92dWuM2nyMsf5h80TRQAblneATqWkVZecySwtKcmxESovShBPfzgxMbxG4K+sIewe3EmQHsPdkXHPGDpvHaHMwRvPqTqPF
X-MS-Exchange-AntiSpam-MessageData: scZcnFzbRoN/84PHsMf/Ps6A7OQjepHfI/4TDlh0eb90zOw1Sh3af+EV7jpo2sxfgJfLieoVXe6H3nPnSlpzdJmxjYWsUZVzNP78dsxqAnkbTfVZeCSUhUdDEQjCrTj8mICpTeOxTnKn561aEKVDHw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62ac205a-a7b5-49de-c889-08d7b5dff383
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2020 08:36:16.6627 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0RgFBHgVsUDf34tNNp4WvKQn3npYmSiNqXc826QWqwS0vh+pug2+vp6ZB5Bv43MRyGkNaVRgMgNjFqZB5JiMsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3704
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Shirish S <shirish.s@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

fixes S3 issue with IOMMU + S/G  enabled @ 64M VRAM.

Suggested-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Shirish S <shirish.s@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h       |  1 +
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c         | 37 ++++++++++++++++++-
 .../include/asic_reg/dce/dce_12_0_offset.h    |  2 +
 3 files changed, 39 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
index d03beb204091..2bd9423c1dab 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
@@ -195,6 +195,7 @@ struct amdgpu_gmc {
 	uint32_t                srbm_soft_reset;
 	bool			prt_warning;
 	uint64_t		stolen_size;
+	uint32_t		sdpif_register;
 	/* apertures */
 	u64			shared_aperture_start;
 	u64			shared_aperture_end;
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 90216abf14a4..cc0c273a86f9 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -1271,6 +1271,19 @@ static void gmc_v9_0_init_golden_registers(struct amdgpu_device *adev)
 	}
 }
 
+/**
+ * gmc_v9_0_restore_registers - restores regs
+ *
+ * @adev: amdgpu_device pointer
+ *
+ * This restores register values, saved at suspend.
+ */
+static void gmc_v9_0_restore_registers(struct amdgpu_device *adev)
+{
+	if (adev->asic_type == CHIP_RAVEN)
+		WREG32(mmDCHUBBUB_SDPIF_MMIO_CNTRL_0, adev->gmc.sdpif_register);
+}
+
 /**
  * gmc_v9_0_gart_enable - gart enable
  *
@@ -1376,6 +1389,20 @@ static int gmc_v9_0_hw_init(void *handle)
 	return r;
 }
 
+/**
+ * gmc_v9_0_save_registers - saves regs
+ *
+ * @adev: amdgpu_device pointer
+ *
+ * This saves potential register values that should be
+ * restored upon resume
+ */
+static void gmc_v9_0_save_registers(struct amdgpu_device *adev)
+{
+	if (adev->asic_type == CHIP_RAVEN)
+		adev->gmc.sdpif_register = RREG32(mmDCHUBBUB_SDPIF_MMIO_CNTRL_0);
+}
+
 /**
  * gmc_v9_0_gart_disable - gart disable
  *
@@ -1412,9 +1439,16 @@ static int gmc_v9_0_hw_fini(void *handle)
 
 static int gmc_v9_0_suspend(void *handle)
 {
+	int r;
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
-	return gmc_v9_0_hw_fini(adev);
+	r = gmc_v9_0_hw_fini(adev);
+	if (r)
+		return r;
+
+	gmc_v9_0_save_registers(adev);
+
+	return 0;
 }
 
 static int gmc_v9_0_resume(void *handle)
@@ -1422,6 +1456,7 @@ static int gmc_v9_0_resume(void *handle)
 	int r;
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
+	gmc_v9_0_restore_registers(adev);
 	r = gmc_v9_0_hw_init(adev);
 	if (r)
 		return r;
diff --git a/drivers/gpu/drm/amd/include/asic_reg/dce/dce_12_0_offset.h b/drivers/gpu/drm/amd/include/asic_reg/dce/dce_12_0_offset.h
index b6f74bf4af02..27bb8c1ab858 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/dce/dce_12_0_offset.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/dce/dce_12_0_offset.h
@@ -7376,6 +7376,8 @@
 #define mmCRTC4_CRTC_DRR_CONTROL                                                                       0x0f3e
 #define mmCRTC4_CRTC_DRR_CONTROL_BASE_IDX                                                              2
 
+#define mmDCHUBBUB_SDPIF_MMIO_CNTRL_0                                                                  0x395d
+#define mmDCHUBBUB_SDPIF_MMIO_CNTRL_0_BASE_IDX                                                         2
 
 // addressBlock: dce_dc_fmt4_dispdec
 // base address: 0x2000
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
