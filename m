Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CCEBECAAD8
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Sep 2022 12:57:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A0C4E10E527;
	Fri, 23 Sep 2022 12:57:12 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2059.outbound.protection.outlook.com [40.107.101.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BBC6B10E527
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Sep 2022 12:57:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H8BmSRuaHrHEQJ8fQcsIcmvmpFdlTWYrNVjANUNLlgsg6k7IFUjAZ9bv2lgcODH2qCHcnoU4tRYu286EM1Gn6UQ450I6IQZU2gY8fyBqH4fpzi4AMQ7nji9/eeWs11QssauqQC5jEvhXykh2Q+jB4m0c6tWCD40qTCTIhgl95n6RQ3eVqsK4L6YLf0XNmTvMICWhPhKjdhZpd6EIBSjuA+TiKqQmdNajZNQG9okttySxmDmgDUrVNHH2o62kYJx/dBkbXQ53ucwyDfNEavB2ilJjjCCGc8seOv2eeMskfg47IRzhr4pM/6FuN6yrU3WAIEDiO4YnNlUUJiWRVFRD/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cGUVjH6Jr6BNgfeSxoN52f2lnwi0tSCJqjS/roqzNLE=;
 b=Bmdi0K/Fdv6bzuV4f9AFue23vyGXxRAH+rkSQUZuqQKbBFPM/D2fhBnFnq+wNSabhncoW+pxKIV+LKXYBaYg+BwYo30u7bmYKDz1A3F7FszhNQcqWtfMgUFIVzQscV4MGj2OwJUv56gfA612HNUad63iXKlo4kuZlzz6O9tw45saHORTVSlgq6kkDlE58mKGDFRZpsfmrEQr1Sfx+tqWLBeeH/UNuR50WvZ7O2TMDR4bEbym79CpwLlAIFRpbZqsob6ZCOCjaUsPhA9iinwBlDLYy8+UN9i1xL8vPmDfr6ex08+mJIWajmIIebe4hxGeh1s7R91mhtSD6u76BhkopQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cGUVjH6Jr6BNgfeSxoN52f2lnwi0tSCJqjS/roqzNLE=;
 b=n+pQ144ijo3rYUFR5a4ZiXifhyFRmlfdBI4Fi9i8j2x46Imgxz6n/byC715YYbs2J8cybzO2Gv0QEjJnmzx+eOnQK5XbxryJ6OAePYFVDZP7Ncoc/ZMkw5x0Bt1ND3ohZAmbVgeed6IKbWfyXAEm0BDfbDQl3RXZsXR88ssfV4Y=
Received: from DS7PR03CA0172.namprd03.prod.outlook.com (2603:10b6:5:3b2::27)
 by MW4PR12MB7029.namprd12.prod.outlook.com (2603:10b6:303:1ef::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.21; Fri, 23 Sep
 2022 12:57:07 +0000
Received: from DM6NAM11FT052.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b2:cafe::e9) by DS7PR03CA0172.outlook.office365.com
 (2603:10b6:5:3b2::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.20 via Frontend
 Transport; Fri, 23 Sep 2022 12:57:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT052.mail.protection.outlook.com (10.13.172.111) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5654.14 via Frontend Transport; Fri, 23 Sep 2022 12:57:07 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 23 Sep
 2022 07:57:06 -0500
From: Tom St Denis <tom.stdenis@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/amdgpu: Add missing XGMI hive registers for mmhub
 9.4.1
Date: Fri, 23 Sep 2022 08:56:58 -0400
Message-ID: <20220923125658.431117-1-tom.stdenis@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT052:EE_|MW4PR12MB7029:EE_
X-MS-Office365-Filtering-Correlation-Id: f1682ec0-0c3c-46d9-c38a-08da9d631ef5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: awaqAxKUt31IQRW/VjnhpSC++TNCoN9jhHtw8LMKv7DJBmtQT3ukCIyV6y2VR9BPuLH+BNQriqKnI8p1bQtMWJCR3XbK+uxuurek9KxAyNmA2KcsAIqtnulo9VYVG30ZHU8kIyU4PU380k9g3/iT4bgoxEkIK5Jbf+yhxe7ry/gy3H+2aZl7+tsbEjayuY20R+agadv9ha5FUGWPFU4vuAKivEkSHw7kJz2Qnmlip067Ub6t9prcjpOO4EXv3EDvPImQj+VwSwDxgmgpJ0MfNXHsHY6AtUPNVISVgygRUug6rGieNHg3Vl2dE0I8qsYoqgg5bbXIRtrzp0hV/qkIR89pGIgexsRgIW0G7NVdjDAl4lK6q3lCMp3me7A2lli8Fsf3R43IRj4CAXdjpOY6JHvmGLBzZmYg+EGcA5gkkjcGTVQ622bMCdYDwQN5w5AT+fx5M0GVmCsuOV5im1L1CsFtKy7ohBH+hCL+YF0C9E1NL83vMhQAIiZ+gqulENa8TlKKleRM9LpIB6RYfGcF0AP9aM+gprYyg/kHOiRUJvxgfTtkGy0H2uJDbPSw7+YuNpMeTbrZQboNz7L81ttaQrOnG20anGt2B3cJtijFXa+cpbjCLcmYnX/g5vAdmpVZLJSVFpQwmCMRYkP5gOIJuhfdd2wS+98EOVLpZsENu0D/JN09aV6OqPmcEkUeqLazVNBbOyu+J9T4TgtFOmtJT9GHuZeCOkqcaMTA5kUejw3ACroqeCTQe3NOU7AsIxVU9tycoqdggtOTwG0HK2AX8h3yNgmnULQBAAPH2KXQxU4=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(346002)(396003)(39860400002)(376002)(451199015)(46966006)(40470700004)(36840700001)(26005)(36756003)(356005)(86362001)(2616005)(5660300002)(1076003)(2906002)(81166007)(40480700001)(186003)(426003)(16526019)(8676002)(70586007)(4326008)(70206006)(40460700003)(83380400001)(336012)(47076005)(478600001)(6916009)(8936002)(82740400003)(316002)(6666004)(36860700001)(41300700001)(82310400005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2022 12:57:07.2155 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f1682ec0-0c3c-46d9-c38a-08da9d631ef5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT052.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7029
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
Cc: Tom St Denis <tom.stdenis@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

These are used by umr to sort the hive nodes since the kernel
initializes the nodes in order of bus enumeration not XGMI hive
enumeration.

Signed-off-by: Tom St Denis <tom.stdenis@amd.com>
---
 .../drm/amd/include/asic_reg/mmhub/mmhub_9_4_1_offset.h   | 4 ++++
 .../drm/amd/include/asic_reg/mmhub/mmhub_9_4_1_sh_mask.h  | 8 ++++++++
 2 files changed, 12 insertions(+)

diff --git a/drivers/gpu/drm/amd/include/asic_reg/mmhub/mmhub_9_4_1_offset.h b/drivers/gpu/drm/amd/include/asic_reg/mmhub/mmhub_9_4_1_offset.h
index d8632ccf3494..c488d4a50cf4 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/mmhub/mmhub_9_4_1_offset.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/mmhub/mmhub_9_4_1_offset.h
@@ -4409,6 +4409,10 @@
 #define mmVMSHAREDPF0_MC_VM_XGMI_LFB_SIZE_BASE_IDX                                                     1
 #define mmVMSHAREDPF0_MC_VM_CACHEABLE_DRAM_CNTL                                                        0x0af9
 #define mmVMSHAREDPF0_MC_VM_CACHEABLE_DRAM_CNTL_BASE_IDX                                               1
+#define mmMC_VM_XGMI_LFB_CNTL                                                                          0x0823
+#define mmMC_VM_XGMI_LFB_CNTL_BASE_IDX                                                                 0
+#define mmMC_VM_XGMI_LFB_SIZE                                                                          0x0824
+#define mmMC_VM_XGMI_LFB_SIZE_BASE_IDX                                                                 0
 
 
 // addressBlock: mmhub_utcl2_vmsharedvcdec
diff --git a/drivers/gpu/drm/amd/include/asic_reg/mmhub/mmhub_9_4_1_sh_mask.h b/drivers/gpu/drm/amd/include/asic_reg/mmhub/mmhub_9_4_1_sh_mask.h
index 111a71b434e2..2969fbf282b7 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/mmhub/mmhub_9_4_1_sh_mask.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/mmhub/mmhub_9_4_1_sh_mask.h
@@ -26728,6 +26728,14 @@
 //VMSHAREDPF0_MC_VM_CACHEABLE_DRAM_CNTL
 #define VMSHAREDPF0_MC_VM_CACHEABLE_DRAM_CNTL__ENABLE_CACHEABLE_DRAM_ADDRESS_APERTURE__SHIFT                  0x0
 #define VMSHAREDPF0_MC_VM_CACHEABLE_DRAM_CNTL__ENABLE_CACHEABLE_DRAM_ADDRESS_APERTURE_MASK                    0x00000001L
+//MC_VM_XGMI_LFB_CNTL
+#define MC_VM_XGMI_LFB_CNTL__PF_LFB_REGION__SHIFT                                                             0x0
+#define MC_VM_XGMI_LFB_CNTL__PF_MAX_REGION__SHIFT                                                             0x3
+#define MC_VM_XGMI_LFB_CNTL__PF_LFB_REGION_MASK                                                               0x00000007L
+#define MC_VM_XGMI_LFB_CNTL__PF_MAX_REGION_MASK                                                               0x00000038L
+//MC_VM_XGMI_LFB_SIZE
+#define MC_VM_XGMI_LFB_SIZE__PF_LFB_SIZE__SHIFT                                                               0x0
+#define MC_VM_XGMI_LFB_SIZE__PF_LFB_SIZE_MASK                                                                 0x0000FFFFL
 
 
 // addressBlock: mmhub_utcl2_vmsharedvcdec
-- 
2.34.1

