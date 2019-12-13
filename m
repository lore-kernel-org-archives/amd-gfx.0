Return-Path: <SRS0=wwPX=2D=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42573C2D0CA
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Dec 2019 21:24:58 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A4B7E24671
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Dec 2019 21:24:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="NxbkRHK2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4B7E24671
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D67D6E092;
	Fri, 13 Dec 2019 16:38:22 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760089.outbound.protection.outlook.com [40.107.76.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1BFDD6E092
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Dec 2019 16:38:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bj1R3YKJNrAK8/nWfDLWewmLmIn2TOrfeRay33zC+qLqOWgOVA1GK0l4x4EHlrdGxCrH7izwnbZUXs5GC7VEKNvqE7YkBAWa/v872xsjULE0VFKNjjYr6yIay9Iv84YX5eoQM1SvFl8vNJ7mQiBtMnfkDoplrfSF/c4K+JSCBpdas4If5azIRXAA0WSGFW5iZckExbhKuiJgvTWGN+oNhM842tEEdw+lleNwdJoRY3/RLl/OEL6ZWI4KIp90DXgcRH/L7unj0ENPzRjh/Z8y7W7rBqDVqG9J3dUzR1Ousl29yGQLyd57RdfdV5uCUr7uk5frkZV0Qjt4RfdhGrGy+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2LkjLlpcKiTsOnc6FXsWfKMuWYj7vsS6G5GcaAf6Ch8=;
 b=bKngxeBTMfhIVHp/lFX70BZkie0eJTpcLzOvRSsQeldrj/EMKNKSzU/kAUykSOTOnnNXTnf0hP5Q9de6rHbZ0nYMGX5scy8RJkl321BgoFpmMH4Gn6b2dSvbwgNjtrdsjg4dpxbErTobOHSkA/tNMRifk24rKg0vzCCnC9wD1eLZSBRDOoeYc3EqVg6Lq6k6k8BLz8z6UDp0lRzgUU+UT/ISQK5iWrgnOuXhZeTuhW3Ka99FClehdUK1UgxAnGlXG7/FPD2XfcSZhJzXeS2/AcJRkJv5XQ2lKgCy5L6DpH/6aVTrsw5Qpm9GKKq+fA6NHqn+waaxIpwNyHT7H2sUWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2LkjLlpcKiTsOnc6FXsWfKMuWYj7vsS6G5GcaAf6Ch8=;
 b=NxbkRHK2Q0CCOlz72nS0lX6qwuzWfkmw+bC446/vgCXalJi56c2lhi05uKc20caN1/sYwSLlUEhxj15ib/X+AU2ndWemBQH/rLzoYXHFUpFuxT5BTyhyW5uzyBvoQcFvgmOdxoPN0w5aPSJdq7Wxq5NRsKL6XeFhw1lLH7yqupA=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Yong.Zhao@amd.com; 
Received: from DM5PR1201MB0137.namprd12.prod.outlook.com (10.174.106.18) by
 DM5PR1201MB0058.namprd12.prod.outlook.com (10.174.104.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.15; Fri, 13 Dec 2019 16:38:19 +0000
Received: from DM5PR1201MB0137.namprd12.prod.outlook.com
 ([fe80::5878:940a:dd61:4d22]) by DM5PR1201MB0137.namprd12.prod.outlook.com
 ([fe80::5878:940a:dd61:4d22%9]) with mapi id 15.20.2516.018; Fri, 13 Dec 2019
 16:38:19 +0000
From: Yong Zhao <Yong.Zhao@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdkfd: Improve function get_sdma_rlc_reg_offset()
Date: Fri, 13 Dec 2019 11:38:07 -0500
Message-Id: <20191213163807.27139-1-Yong.Zhao@amd.com>
X-Mailer: git-send-email 2.17.1
X-ClientProxiedBy: YT1PR01CA0023.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::36)
 To DM5PR1201MB0137.namprd12.prod.outlook.com
 (2603:10b6:4:54::18)
MIME-Version: 1.0
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: e8c54e87-3e69-41b7-cec8-08d77feadc43
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0058:|DM5PR1201MB0058:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR1201MB00584439A5D41660721155DDF0540@DM5PR1201MB0058.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1775;
X-Forefront-PRVS: 0250B840C1
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(136003)(346002)(396003)(366004)(39860400002)(189003)(199004)(4326008)(66556008)(86362001)(478600001)(6512007)(6666004)(6486002)(66946007)(66476007)(81166006)(316002)(2906002)(36756003)(81156014)(26005)(1076003)(8676002)(6916009)(52116002)(186003)(8936002)(6506007)(5660300002)(2616005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR1201MB0058;
 H:DM5PR1201MB0137.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NtVEDyLI1s8kJwXV3/ADuC/n6r4Dn15Qwj1D03Lh5L2ckCFZDOCeFJoZb2sVaipnXA/wh66+9fY/EARyomaxozSgXLJbLO4P1SkgJGwffO3PKYz9Zv5Fv2qIlefSG+IKH2mKqJFmbAYKCL9bM4nymBAAKbECftgVXc3IK9R9bZOWPusO5SeZ3xdm+N2r56mVBtP7Z1OhMb2aYa8MT+5DLhZFSfvs4A+NeEGaFzJ2lbDu4q5QsiXwYAdgu5nylNEg2xSGZZAdUL0XqOTtfCsPi6aJB+45FT6zIFI63ctunLIibqZOVpD/JEo26KPqE44qti9+LPM0DggzAMGzvejoVljZxH1UHMlkshPh8OS+lO2HNZJhEdwGi5KCXBGVmLKKK7KOiHqNL5hdV5LYk40JCXU8U0lTIHBrUb2JXW7cpMrOW07BgDaU6Lk/Y78YKiF9
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8c54e87-3e69-41b7-cec8-08d77feadc43
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2019 16:38:19.3388 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OFPna2lL/X0tpYQcfRU6FYF96tABbtsjNMKLvTurg59UWRIGcORXW9SMbyc2eVtp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0058
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
Cc: Yong Zhao <Yong.Zhao@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This prevents the NULL pointer access when there are fewer than 8 sdma
engines.

Change-Id: Iabae9bff7546b344720905d5d4a5cfc066a79d25
Signed-off-by: Yong Zhao <Yong.Zhao@amd.com>
---
 .../drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c   | 64 ++++++++++++-------
 1 file changed, 42 insertions(+), 22 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c
index 3c119407dc34..2ad088f10493 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c
@@ -71,32 +71,52 @@ static uint32_t get_sdma_rlc_reg_offset(struct amdgpu_device *adev,
 				unsigned int engine_id,
 				unsigned int queue_id)
 {
-	uint32_t sdma_engine_reg_base[8] = {
-		SOC15_REG_OFFSET(SDMA0, 0,
-				 mmSDMA0_RLC0_RB_CNTL) - mmSDMA0_RLC0_RB_CNTL,
-		SOC15_REG_OFFSET(SDMA1, 0,
-				 mmSDMA1_RLC0_RB_CNTL) - mmSDMA1_RLC0_RB_CNTL,
-		SOC15_REG_OFFSET(SDMA2, 0,
-				 mmSDMA2_RLC0_RB_CNTL) - mmSDMA2_RLC0_RB_CNTL,
-		SOC15_REG_OFFSET(SDMA3, 0,
-				 mmSDMA3_RLC0_RB_CNTL) - mmSDMA3_RLC0_RB_CNTL,
-		SOC15_REG_OFFSET(SDMA4, 0,
-				 mmSDMA4_RLC0_RB_CNTL) - mmSDMA4_RLC0_RB_CNTL,
-		SOC15_REG_OFFSET(SDMA5, 0,
-				 mmSDMA5_RLC0_RB_CNTL) - mmSDMA5_RLC0_RB_CNTL,
-		SOC15_REG_OFFSET(SDMA6, 0,
-				 mmSDMA6_RLC0_RB_CNTL) - mmSDMA6_RLC0_RB_CNTL,
-		SOC15_REG_OFFSET(SDMA7, 0,
-				 mmSDMA7_RLC0_RB_CNTL) - mmSDMA7_RLC0_RB_CNTL
-	};
-
-	uint32_t retval = sdma_engine_reg_base[engine_id]
+	uint32_t sdma_engine_reg_base;
+	uint32_t sdma_rlc_reg_offset;
+
+	switch (engine_id) {
+	case 0:
+		sdma_engine_reg_base = SOC15_REG_OFFSET(SDMA0, 0,
+				mmSDMA0_RLC0_RB_CNTL) - mmSDMA0_RLC0_RB_CNTL;
+		break;
+	case 1:
+		sdma_engine_reg_base = SOC15_REG_OFFSET(SDMA1, 0,
+				mmSDMA1_RLC0_RB_CNTL) - mmSDMA1_RLC0_RB_CNTL;
+		break;
+	case 2:
+		sdma_engine_reg_base = SOC15_REG_OFFSET(SDMA2, 0,
+				mmSDMA2_RLC0_RB_CNTL) - mmSDMA2_RLC0_RB_CNTL;
+		break;
+	case 3:
+		sdma_engine_reg_base = SOC15_REG_OFFSET(SDMA3, 0,
+				mmSDMA3_RLC0_RB_CNTL) - mmSDMA3_RLC0_RB_CNTL;
+		break;
+	case 4:
+		sdma_engine_reg_base = SOC15_REG_OFFSET(SDMA4, 0,
+				mmSDMA4_RLC0_RB_CNTL) - mmSDMA4_RLC0_RB_CNTL;
+		break;
+	case 5:
+		sdma_engine_reg_base = SOC15_REG_OFFSET(SDMA5, 0,
+				mmSDMA5_RLC0_RB_CNTL) - mmSDMA5_RLC0_RB_CNTL;
+		break;
+	case 6:
+		sdma_engine_reg_base = SOC15_REG_OFFSET(SDMA6, 0,
+				mmSDMA6_RLC0_RB_CNTL) - mmSDMA6_RLC0_RB_CNTL;
+		break;
+	case 7:
+		sdma_engine_reg_base = SOC15_REG_OFFSET(SDMA7, 0,
+				mmSDMA7_RLC0_RB_CNTL) - mmSDMA7_RLC0_RB_CNTL;
+		break;
+
+	}
+
+	sdma_rlc_reg_offset = sdma_engine_reg_base
 		+ queue_id * (mmSDMA0_RLC1_RB_CNTL - mmSDMA0_RLC0_RB_CNTL);
 
 	pr_debug("RLC register offset for SDMA%d RLC%d: 0x%x\n", engine_id,
-			queue_id, retval);
+			queue_id, sdma_rlc_reg_offset);
 
-	return retval;
+	return sdma_rlc_reg_offset;
 }
 
 static int kgd_hqd_sdma_load(struct kgd_dev *kgd, void *mqd,
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
