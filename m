Return-Path: <SRS0=EvZE=24=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34D49C33C9B
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Jan 2020 21:22:28 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 07499206F0
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Jan 2020 21:22:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="HRCUqU6J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07499206F0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B67346E13B;
	Tue,  7 Jan 2020 21:22:27 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2088.outbound.protection.outlook.com [40.107.243.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 43F3B6E13B
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Jan 2020 21:22:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MXtdCVRc4+STiNob2u4LvT3VMUJHwETpjL6/hSjLLIPvhvpgj9BZdLCNm2YynSFz/Fln7mTi+fzLBkM43OxPNnd8e0CduH/PSGmCJopN3Li+PElxIcEkbh4IaxXgRfN4tZ9/hGrNmv8pAJ85PzqXFOQDZl72GfZVcd5mXP5A9OwMu9flwP3ZWHj/WuAOUb3XODNqWqO962Tpd4utSXTpofL3u8OEWzjeI/cJaovvo+sK5WD2fBHGB5fHu++rTjfajFOpUIs52Y6XI8cZS4ughqX2u5nB7Ha5oY9MpymBNSoEkrXDmHTMVjr7+AUamgiNRQQACskmRF0KRwO7vsmCyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mt7zSAM0rwWc8hhdz/eogO4ukoAVcQhpH5P8y4XtO0I=;
 b=QtZE2zJIoOcBHSF2iB2T1njCPxbynjeZkGCReD8JiRlIIN5FjePWciWnuzm+VEtSmNZg5PkmJSALGFNR35dTQZ2fMtGu/BjHmLdZ0xXtj6D0hHnsxsXvG0zYVJFiCCAInYEmCM0EFZG1WdS8iv2m9HohIY2pfR+TOIhYY5uCvG7n/S6RWOvVXX+8hmkL8S4+tnkvhAioGGgbPghaUUvXDYRzyA/W46gBEg6WBVyVOC3S1UYZsaIbgjwv6ogAHZUttSPEkcp5ngkrl7k/m+f3FmLzYiMgUrnnKQXNRHIk+MfqD4qT2Z4f8v0IdFQlzoc5ZscSQBrytfqbwwlFW2E8Ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mt7zSAM0rwWc8hhdz/eogO4ukoAVcQhpH5P8y4XtO0I=;
 b=HRCUqU6JRN1JGzHxke4Jq/xiRzTrDBR8rxtJiwb7BR7wD/mNN0qNPLNnmbs9k3YkeLA0+kKE+iZpUC/JM5XVCXJ+rMGAkzBeB4xzzHUnbb0//s6QgeZbYIEiyHBIN8H9I5pLV29J2OlXLvWyl6eCrLmiheEYsraUsUxLDtNh+0g=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Yong.Zhao@amd.com; 
Received: from DM5PR1201MB0137.namprd12.prod.outlook.com (10.174.106.18) by
 DM5PR1201MB0234.namprd12.prod.outlook.com (10.174.107.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2602.15; Tue, 7 Jan 2020 21:22:21 +0000
Received: from DM5PR1201MB0137.namprd12.prod.outlook.com
 ([fe80::b54c:16d9:d613:6877]) by DM5PR1201MB0137.namprd12.prod.outlook.com
 ([fe80::b54c:16d9:d613:6877%9]) with mapi id 15.20.2602.015; Tue, 7 Jan 2020
 21:22:21 +0000
From: Yong Zhao <Yong.Zhao@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdkfd: Improve function get_sdma_rlc_reg_offset()
Date: Tue,  7 Jan 2020 16:22:09 -0500
Message-Id: <20200107212209.20688-1-Yong.Zhao@amd.com>
X-Mailer: git-send-email 2.17.1
X-ClientProxiedBy: YTOPR0101CA0047.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:14::24) To DM5PR1201MB0137.namprd12.prod.outlook.com
 (2603:10b6:4:54::18)
MIME-Version: 1.0
Received: from yong-dev.amd.com (165.204.55.251) by
 YTOPR0101CA0047.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:14::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2623.9 via Frontend
 Transport; Tue, 7 Jan 2020 21:22:21 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: a34e58b4-2b7c-422c-b6b4-08d793b7aeb8
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0234:|DM5PR1201MB0234:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR1201MB023411467C7D0977FD939D47F03F0@DM5PR1201MB0234.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-Forefront-PRVS: 027578BB13
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(376002)(346002)(396003)(136003)(366004)(199004)(189003)(186003)(26005)(6486002)(4326008)(16526019)(6916009)(2616005)(956004)(52116002)(7696005)(478600001)(316002)(8936002)(8676002)(81156014)(1076003)(81166006)(5660300002)(2906002)(66556008)(66476007)(66946007)(86362001)(6666004)(36756003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR1201MB0234;
 H:DM5PR1201MB0137.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: P1vB9O6/ElCFSxOrrz+AiiRF25miwgObuSbhkjW6AZTbPQDvhYM0aoEkqZf41UqiOMOeqsQKGESBI1ZlMsriaurkqpiNIXo2+SfuhmJmzyGr/bDCJCIrqsRsvNadkC99kpQCnAmWmhF9KaxvgNRW8Q2HtfIok0zo2lsKwGcneymeB7d/VQiMPn9+8r1Jqv/Y35Y4/AYmmqVBsgAp7CA1Olf11aCF0mjGVqmxmxIYlybRp96/u7vPr/0Bvc1D0rhotN6yQzCWT1q3Y19sT1I05MvDspkEHQtvs+ZvbPRF0nz/T25q4hOKY5F9WCbK54SkW9848AUFXmDw847md23pdPgoR+u8E/nVL2LeBPQUtB9xmt48F+OecaDE3xZIGJ7MrCqw8T/xrvP1Xz2elrju2UPjAirO3XJgy3JgYqCeSPNkrOsqKGSM6k3nEYgAmqLr
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a34e58b4-2b7c-422c-b6b4-08d793b7aeb8
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2020 21:22:21.7642 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TWvcw0z0dUmnaQoN34nszNoP8tue2tbPWzPAr5vu3xRu5bAs/vIYj20KBnc+9Wcu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0234
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

The SOC15_REG_OFFSET() macro needs to dereference adev->reg_offset[IP]
pointer, which is NULL when there are fewer than 8 sdma engines. Avoid
that by not initializing the array regardless.

Change-Id: Iabae9bff7546b344720905d5d4a5cfc066a79d25
Signed-off-by: Yong Zhao <Yong.Zhao@amd.com>
---
 .../drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c   | 65 ++++++++++++-------
 1 file changed, 43 insertions(+), 22 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c
index 3c119407dc34..2b26925623eb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c
@@ -71,32 +71,53 @@ static uint32_t get_sdma_rlc_reg_offset(struct amdgpu_device *adev,
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
+	default:
+		break;
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
