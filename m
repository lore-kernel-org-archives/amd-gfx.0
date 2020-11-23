Return-Path: <SRS0=UmUD=E5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F195DC5519F
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Nov 2020 03:27:10 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64E4A20721
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Nov 2020 03:27:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="JzOztZPb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64E4A20721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A6C7489617;
	Mon, 23 Nov 2020 03:27:09 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2042.outbound.protection.outlook.com [40.107.237.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0C9C089617
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Nov 2020 03:27:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NZtJQSpmPSpsAiFL0feSIBpxD2zuajSOOpZbS02D0LqEdNN81V/YUAWkHc8s9yOoT/tw0rDnoW9/DsGhOGi8UcLVmwkqWIFZI2Y3lEGgrAHQFhJM0Qt5oswr29cOCLFeUiSUVVP19S04RXMsyFoULaT/eY1YeLHmODu5EFXrYzVVxHcvIogNUCZKwkIQG3Ku1u1uG/qpRgmeF2es/XGCdG9Z+ZjZaC9ZlplqwM/Xq6i4/TXwCgNlXDkpl3FXyiFAjyxs7sAaeTNyzGQ37ZxP72ONyPtLZOSkPr6ym0wl5KeRQ7g8KbwDRi1J1W7BWcMeYDPplt1kC1k1mxRLCZjHRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qAvW1jBJdL3Pnf1rUdy4SXgmdX0ZvHC3gSWAvGBnHR8=;
 b=REo7lab+rvsCH/dWjVxVKDxRAir9XH8u4sT6+Pvh2rM1MXXCxpc5MdJumfDM7YIpGaI5yWoRmXPThHcYZK0XXH0aR8p3q/uwR8mpnB6p5yPOabOj/z96CYodWgFC2Zrfugtu64r1FmnvScmBIOcj9+xdf5+NoL2QvpMg31BLJJ2btk0p2hu76QGwZX/3T5LLB1MrSCIb+FyD0mDFaxC+jWKeODDCUfE2XY1LJ07JKNkdezEQBWUNGrDf/oL05creNDkKVUjjU7aiHrwDDC1zBgFGnIPPcoMCVQH/xMBahvS3LCxPGqu5vTt92QUw0dXPmh+M6/pbYKMNDRMRbiNyBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qAvW1jBJdL3Pnf1rUdy4SXgmdX0ZvHC3gSWAvGBnHR8=;
 b=JzOztZPb2wtEvRcUXOfhDkgV5pmWOCjPAPx09zygd/qxOLOAP0eIoOe96IewQRgHIGI16FJeBmPuDa9T/cPc8KHwDZLcwOsu7BlYv+VQ9/7vEoJWhZjzRZ06W+XhcXcZeFh4ljEtcE4JszzQ41FAG1B3goXOFJiQw7XYzJtOFtk=
Received: from BN6PR2001CA0037.namprd20.prod.outlook.com
 (2603:10b6:405:16::23) by BN6PR1201MB2528.namprd12.prod.outlook.com
 (2603:10b6:404:ae::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.21; Mon, 23 Nov
 2020 03:27:05 +0000
Received: from BN8NAM11FT060.eop-nam11.prod.protection.outlook.com
 (2603:10b6:405:16:cafe::3f) by BN6PR2001CA0037.outlook.office365.com
 (2603:10b6:405:16::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.21 via Frontend
 Transport; Mon, 23 Nov 2020 03:27:05 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none
 (message not signed) header.d=none;lists.freedesktop.org; dmarc=fail
 action=none header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 165.204.84.17 as permitted sender)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 BN8NAM11FT060.mail.protection.outlook.com (10.13.177.211) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3589.22 via Frontend Transport; Mon, 23 Nov 2020 03:27:05 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Sun, 22 Nov
 2020 21:27:05 -0600
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Sun, 22 Nov
 2020 21:27:04 -0600
Received: from navi10-sut.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3 via Frontend
 Transport; Sun, 22 Nov 2020 21:27:03 -0600
From: Jiansong Chen <Jiansong.Chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: update GC golden setting for navy_flounder
Date: Mon, 23 Nov 2020 11:26:52 +0800
Message-ID: <20201123032652.185547-1-Jiansong.Chen@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 38681f29-1ba7-4030-cf63-08d88f5fa6ba
X-MS-TrafficTypeDiagnostic: BN6PR1201MB2528:
X-Microsoft-Antispam-PRVS: <BN6PR1201MB2528DDCB245D2757385DA856EAFC0@BN6PR1201MB2528.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1079;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LUMVKJghYOyvqX1FhVAyOZCLH8uBOBK32A2fJdCydRMLJboyClXYW/11FNiR278IoeAVr+NImXnBioaB1VhFyZE6gjKFPL0a3bcOwetGi63hmMRPSiC8U12feQ25NtF9LQI1bPPR1kxnUnLRXqkdl0rhCPFfGjo6cvM5+AJzqkBnSlZyJPMnbJiA+S9TCxWP9mPqEmqvoywsYI/6h6j0FLqb5jDSTXvHTPlrTZoacwdTqOqYYcaSLv/L5HkBcBpuyDECJI+Hp5wH77zBIA95f1J8a8oUAEGW3WImxAT4nOAjWCUTFAe2OUkVNbvCjsLnKr2CHZ+ybmNrz+hyuR1c8rfQEZ4ntiAmKU7TgYURbFGPLJeh1zOadDSjTj5eR8VVmUuxgZHnQr8ceJCrDQJ1aw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(396003)(346002)(136003)(376002)(39860400002)(46966005)(1076003)(81166007)(26005)(6916009)(54906003)(82310400003)(336012)(2906002)(316002)(426003)(70206006)(8936002)(70586007)(7696005)(2616005)(186003)(83380400001)(5660300002)(36756003)(8676002)(82740400003)(15650500001)(47076004)(86362001)(6666004)(4326008)(356005)(478600001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2020 03:27:05.4411 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 38681f29-1ba7-4030-cf63-08d88f5fa6ba
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT060.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB2528
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
Cc: tao.zhou1@amd.com, Jiansong Chen <Jiansong.Chen@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Update GC golden setting for navy_flounder.

Signed-off-by: Jiansong Chen <Jiansong.Chen@amd.com>
Change-Id: I25d5afb46ef9667a65bc897dcddf54390891e90f
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index eb05d1bc194e..841d39eb62d9 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -3191,6 +3191,7 @@ static const struct soc15_reg_golden golden_settings_gc_10_3_sienna_cichlid[] =
 
 static const struct soc15_reg_golden golden_settings_gc_10_3_2[] =
 {
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmCGTT_SPI_CS_CLK_CTRL, 0xff7f0fff, 0x78000100),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmCGTT_SPI_PS_CLK_CTRL, 0xff7f0fff, 0x78000100),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmCGTT_SPI_RA0_CLK_CTRL, 0xff7f0fff, 0x30000100),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmCGTT_SPI_RA1_CLK_CTRL, 0xff7f0fff, 0x7e000100),
@@ -3199,6 +3200,8 @@ static const struct soc15_reg_golden golden_settings_gc_10_3_2[] =
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmDB_DEBUG4, 0xffffffff, 0x00800000),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmDB_EXCEPTION_CONTROL, 0x7fff0f1f, 0x00b80000),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmGCR_GENERAL_CNTL_Sienna_Cichlid, 0x1ff1ffff, 0x00000500),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmGCUTCL2_CGTT_CLK_CTRL_Sienna_Cichlid, 0xffffffff, 0xff008080),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmGCVM_L2_CGTT_CLK_CTRL_Sienna_Cichlid, 0xffff8fff, 0xff008080),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmGE_PC_CNTL, 0x003fffff, 0x00280400),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmGL2A_ADDR_MATCH_MASK, 0xffffffff, 0xffffffcf),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmGL2C_ADDR_MATCH_MASK, 0xffffffff, 0xffffffcf),
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
