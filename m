Return-Path: <SRS0=vXfK=NL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2596DC432BE
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Aug 2021 19:12:06 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D90FD61102
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Aug 2021 19:12:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D90FD61102
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5EA496EB07;
	Fri, 20 Aug 2021 19:12:05 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2042.outbound.protection.outlook.com [40.107.95.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C15CE6EB07
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Aug 2021 19:12:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KRB9LrErJDTcKmI62o4sOEXAZeRg59L/bCEdM+0I4fy2bRWTdl/n4EfMsRY5p0IXxp19xO+XFt9LXb280mhgNub02ZHLMgM1tk90fo2aiw5cyc5KP677IKmMffwjQhqBvFzOQ4f4lorPEICqlYa4zHJqSmlwv6pHWCI9+mTJu0QfZdBRn6EJ7BHdc757+lkeWQPFZOF0foG+UKxncDRG9deMGY/QiMNdGXrVp/5BWmahlCVMsb55CFWbuc8vikPHypsfuTKmX55rDaatfSKJArX2zu2y/wsjar6muUpWfVKooj6kvj8TVGhrM/MAjUN1rPpk62zvupGcy6v0bickCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fQ8W1pNd7PozpnMIK96RYfbqC4+KxMvXrILsxjDY8nI=;
 b=S/G1rHHQLyLmzYzBtRhvevVVOb5Bpb5e40lMfVwYZaZ1TJRL5QSHo6pIvnzis9h+GPAonSE17IdBm2Ha66mLrrwbTAb6ZDNsWmErTjGYff9vEY+tCxXqBk/DUpmqqkez+iRPVn5Z3AxqEOPtjXoM/vgSCGfzpVGjbg+Xs27fcm8LpUbkNaH5xAVCaOWQGeJXDZ54A99yL+ahAnTwPC9m8/uL1T6k0/b58u6mAZ9Z3PPHpKQgI7KGg8CaBvnO2xi2ymecRCfreObfg/0Q8uTd6az3uVT5He2YCe/wej8ZAisXyRrciYu86wQ0bpWKb1yyCOEjlRLEd3a8bTIVWoe17w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fQ8W1pNd7PozpnMIK96RYfbqC4+KxMvXrILsxjDY8nI=;
 b=VJvo/pqJK9V1QrIG1jBihp8SXzAtHPMCB+Erufecz5nac7SIgqsVhbFOGLlFa1Dx05EftF5vGARZ/b6rbsu/jBNf7JjAABNtWqiYRYkToA7MB9ruQS2HjFUe9zcwddyh7MOer+GoMGjO/3nv120yTWSw9PuA9HgUflLUs4AbVkM=
Received: from BN9P221CA0012.NAMP221.PROD.OUTLOOK.COM (2603:10b6:408:10a::7)
 by BYAPR12MB2917.namprd12.prod.outlook.com (2603:10b6:a03:130::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.19; Fri, 20 Aug
 2021 19:12:01 +0000
Received: from BN8NAM11FT046.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10a:cafe::47) by BN9P221CA0012.outlook.office365.com
 (2603:10b6:408:10a::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend
 Transport; Fri, 20 Aug 2021 19:12:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT046.mail.protection.outlook.com (10.13.177.127) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4436.19 via Frontend Transport; Fri, 20 Aug 2021 19:12:01 +0000
Received: from mukjoshi-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Fri, 20 Aug
 2021 14:12:00 -0500
From: Mukul Joshi <mukul.joshi@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Amber.Lin@amd.com>, Mukul Joshi <mukul.joshi@amd.com>
Subject: [PATCH] drm/amdkfd: CWSR with sw scheduler on Aldebaran and Arcturus
Date: Fri, 20 Aug 2021 15:11:47 -0400
Message-ID: <20210820191147.18644-1-mukul.joshi@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d318fbe2-37dd-4422-cbb4-08d9640e63d3
X-MS-TrafficTypeDiagnostic: BYAPR12MB2917:
X-Microsoft-Antispam-PRVS: <BYAPR12MB2917C9A265C333D4F898FDE3EEC19@BYAPR12MB2917.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:404;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mvvENCqfpSM+z2EIdvdY2c7I5dLp+1ySCp9NJH8qku7Cx4J3j6Ine3s97WVQL1zlVcxPPXxOeaVfePawHSwt7rXY2ewZAz212K2bf6r8JDcxGGIOkGjP05Z2YgAVXgJ/f8BAS+rBivXiQItzO2XNzH8JkHz+6VNc+Uyu4FPETojd+mfhLL6h49qb1ScCS3hh78xjh1nhs6tHRA2c+ABp8B18Zd+XzNb09QaFEjcguujNlG5LjucF13Zhh4mwMv5D+/3dwQTwLChZueyu2+MdR6rba/q9kMZbzWTzPobMiBIq8VYCc1pPZrN2vKgNbYBEoidz9UG6mg1OroufCnlG2o2abkN5lVJIEriQjFNA2001vkJ22qdbNMaowyYQcjGe62OftvRribGK26U77zsqYG9pUGT5xoY04wln/6V5D/IxytEvALr8vhhP4bYhpNGxoanRRFiHQUVbagsLz4zg2Snbv2snVNfYFwN/PEMU3h3yKDyOft4WfnJDtXoNx4hjc6sLTGFFYNuT3Dx/fujSUNSfVAylfl/QuW0IqOMeAE/VECQ0KOgiK5tizVDUQsAIt+FaVtTNqRARROyAA0Eh/jGpKnQvYlD/9R5Te2NpFQiihyv08pj3PnQ8DDGuyhQoUAIFSOmeOw0pawxx8lNqJZiskQ9bgXJLU53qsJ6tEldGJKW+a+p7V7ZGk19gT4uTia1u9Yps1ord03eRtBWx8afLHu0kN590sjq08rKDjOL14SF8fvn3EcuMRcgMmHsumgp4g+l0TQIfl81odKQgVA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(34020700004)(82310400003)(186003)(44832011)(426003)(86362001)(16526019)(4326008)(316002)(1076003)(54906003)(356005)(6666004)(36860700001)(8676002)(83380400001)(70206006)(2906002)(336012)(26005)(6916009)(47076005)(70586007)(8936002)(508600001)(2616005)(5660300002)(7696005)(36756003)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2021 19:12:01.6340 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d318fbe2-37dd-4422-cbb4-08d9640e63d3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT046.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2917
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Program trap handler settings to enable CWSR with software scheduler
on Aldebaran and Arcturus.

Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c | 1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c  | 3 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c    | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h    | 2 ++
 4 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c
index a5434b713856..46cd4ee6bafb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c
@@ -44,4 +44,5 @@ const struct kfd2kgd_calls aldebaran_kfd2kgd = {
 	.get_atc_vmid_pasid_mapping_info =
 				kgd_gfx_v9_get_atc_vmid_pasid_mapping_info,
 	.set_vm_context_page_table_base = kgd_gfx_v9_set_vm_context_page_table_base,
+	.program_trap_handler_settings = kgd_gfx_v9_program_trap_handler_settings
 };
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c
index 6409d6b1b2df..5a7f680bcb3f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c
@@ -305,5 +305,6 @@ const struct kfd2kgd_calls arcturus_kfd2kgd = {
 				kgd_gfx_v9_get_atc_vmid_pasid_mapping_info,
 	.set_vm_context_page_table_base =
 				kgd_gfx_v9_set_vm_context_page_table_base,
-	.get_cu_occupancy = kgd_gfx_v9_get_cu_occupancy
+	.get_cu_occupancy = kgd_gfx_v9_get_cu_occupancy,
+	.program_trap_handler_settings = kgd_gfx_v9_program_trap_handler_settings
 };
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
index 154244916727..bcc1cbeb8799 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
@@ -882,7 +882,7 @@ void kgd_gfx_v9_get_cu_occupancy(struct kgd_dev *kgd, int pasid,
 				adev->gfx.cu_info.max_waves_per_simd;
 }
 
-static void kgd_gfx_v9_program_trap_handler_settings(struct kgd_dev *kgd,
+void kgd_gfx_v9_program_trap_handler_settings(struct kgd_dev *kgd,
                         uint32_t vmid, uint64_t tba_addr, uint64_t tma_addr)
 {
 	struct amdgpu_device *adev = get_amdgpu_device(kgd);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h
index e64deba8900f..c63591106879 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h
@@ -65,3 +65,5 @@ void kgd_gfx_v9_set_vm_context_page_table_base(struct kgd_dev *kgd,
 			uint32_t vmid, uint64_t page_table_base);
 void kgd_gfx_v9_get_cu_occupancy(struct kgd_dev *kgd, int pasid,
 		int *pasid_wave_cnt, int *max_waves_per_cu);
+void kgd_gfx_v9_program_trap_handler_settings(struct kgd_dev *kgd,
+		uint32_t vmid, uint64_t tba_addr, uint64_t tma_addr);
-- 
2.17.1

