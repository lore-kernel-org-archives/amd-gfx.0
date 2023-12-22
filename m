Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46DCCC46CD4
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Dec 2023 15:27:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9F84A10E7DF;
	Fri, 22 Dec 2023 15:27:51 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2087.outbound.protection.outlook.com [40.107.94.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DC51F10E7DA
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 Dec 2023 15:27:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f5A80nvQ16xmRwTG+MJLag3SvTqe25xw2/TFaWO7e2+goqaYoJ1Z2HY9AO2Phxpf1DvpN1RWLYw1VDMgEz8qr00TJJR6cExvc/qeM8QVqEeOFy3q1PoDzc+KYQ2iKhHokTHuls/cjqvv3eW/muU949xvw8pujI7OQcG+iiykHoMB+LR2pn10b6QSZgtEDGiWiN1vCfECT5zm+bTscXrbRo0gOMzGz9daqJg3/cIKXDjqxi1On/mXY0aWyFr6FlPT6v1T76X1XOfPOzB+rugaQTyI0uTWL2ZfE+jgtSSDB9J3iZ4vvobGulVlrME9mMeOAhXH1Z/y2y36Zj2SRnPaXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DGN4EMxsjy14RJjalKAlVA0PkgcLK8B7SOAr/Zb93jI=;
 b=njattzTuN6CGuhhdg4aqV3ubYkNTpnWm8JvVzn41bZnOE9XezNV0W22XfQi3zMunfew55OiSWvKJbDAQVy/3JpoFw1+8Ja12YkA1EpANNHCEaVEnF5zlP5IzfxfGtlZf01Q1GIjKE0Zhl7oJl4AdkGdrIWo3qsKSDgcc5rUYOPUydCGcIEsdaaY8EgAYTm3KowuGfu9xjFwVV3j3a3xoPFnpm7K98Q6du1unXrmXmCyjM1HDdgDlszQi/BRanKA1s2TN42nKEeIM4evi4ksWJirG5p1nWRSCM059+lt2BSc33PTs6FyySZ5pDJtcqPctBrS37Of370MtjjbQi2Mmxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DGN4EMxsjy14RJjalKAlVA0PkgcLK8B7SOAr/Zb93jI=;
 b=gypvZCuAAXqb1bs9FN1EPm7FvdZWQzIZSblUvz/vw1N0jbDwriUxzDlbuW4yR9VP3Ba+vhuBMXUsXePIu8w/AaxzxnrpjuJxIbqHZg/sYi2NlUqSC4NCr6tY1+QWPxTWooMCncgFgRl3oW5H99hBUPAYSXE2Xa8PeZcLnMTyUq8=
Received: from SJ2PR07CA0008.namprd07.prod.outlook.com (2603:10b6:a03:505::8)
 by PH0PR12MB8151.namprd12.prod.outlook.com (2603:10b6:510:299::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.21; Fri, 22 Dec
 2023 15:27:46 +0000
Received: from MWH0EPF000971E2.namprd02.prod.outlook.com
 (2603:10b6:a03:505:cafe::fd) by SJ2PR07CA0008.outlook.office365.com
 (2603:10b6:a03:505::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.21 via Frontend
 Transport; Fri, 22 Dec 2023 15:27:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000971E2.mail.protection.outlook.com (10.167.243.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7113.14 via Frontend Transport; Fri, 22 Dec 2023 15:27:45 +0000
Received: from asad-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Fri, 22 Dec
 2023 09:27:42 -0600
From: Asad Kamal <asad.kamal@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <lijo.lazar@amd.com>
Subject: [PATCH 2/4] drm/amd/pm: Update metric table for jpeg/vcn data
Date: Fri, 22 Dec 2023 23:27:25 +0800
Message-ID: <20231222152727.411440-2-asad.kamal@amd.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231222152727.411440-1-asad.kamal@amd.com>
References: <20231222152727.411440-1-asad.kamal@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E2:EE_|PH0PR12MB8151:EE_
X-MS-Office365-Filtering-Correlation-Id: ec336571-ab37-4af1-6c93-08dc03028c3d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: k/tmYWdgkcGhUwrT8sNcwVpYlMnctHEAqYI+mOu8JOQZLReXWPbU5u1tHfFhINZ4ym10fRdblElBARL5qyjgMkgsqk3fikp6EKZFIuRsX3aTqrN44tnT+ECvRMb0PzGceGHCZNReDQIv211iJrwZ1lnqmShgPkXNj4NEieqLa5Tuqb0fGdi0JL/1CHL7TUFOic85hR01Tfu7juRRWAjpL7MOPWu3XUe52MTis7xITYykXX1yiE2+YNzRpeQBe87vVgc3oohpwA5exPg+jk6iYiEk9WTGrt5pRfVkxyrrGoC82rv6RwpoywdRZAB5/NJ89YhiwIXPDamSpCSlEDXvHRFWRoktZl0M8SC6W1g1I4/PikgaBW7T2kQoDdhqlFF4HeTLwNVBaU2k9cwFxmRLlHkf8yUfCrLLQQ1UThYoPmPf+5vuma0k1Br1pNyWw6zILls92GWc/gIBmKX+WemEjb0uUK+S2jcNai8OSjkSAQs4Rr3jwWfvDhnqUoxSYUleRjyZNZSbGfJ0jBiv4KE8jCN4TcvXZ0nQW7rM0eLU2FXGvsvEM5kMIlXZOtMXr3cgYwmkZS1fLMdKBk8lX4Aw5aTZjsAEjmlWSW6LKS2T+YuWAA+UlcnizBVb7k4o7DJZ9X9Vgh7ZZkvCJ1e+oyicrjVWbgRK8V1dW41vZjOrN8Sz2K4dzN/1kNHzR2YMVh9lzJBLMCEX+WHP48kb0DYfxvIVOe4CVzgSXZDQpy7yzl69lxCvsM303ZJHfsp9hP/TeKpCiy6ls6fTdXY043tF4Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(376002)(346002)(39860400002)(136003)(230922051799003)(186009)(82310400011)(1800799012)(451199024)(64100799003)(40470700004)(46966006)(36840700001)(47076005)(5660300002)(44832011)(7696005)(40480700001)(6666004)(478600001)(15650500001)(40460700003)(426003)(336012)(16526019)(26005)(1076003)(2616005)(83380400001)(36860700001)(8676002)(4326008)(8936002)(81166007)(41300700001)(2906002)(86362001)(70586007)(70206006)(6636002)(316002)(110136005)(54906003)(36756003)(356005)(82740400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Dec 2023 15:27:45.6015 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ec336571-ab37-4af1-6c93-08dc03028c3d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E2.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8151
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
Cc: sepehr.khatir@amd.com, shiwu.zhang@amd.com, daniel.oliveira@amd.com,
 le.ma@amd.com, donald.cheung@amd.com, asad.kamal@amd.com,
 hawking.zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Update pmfw metric table to include vcn & jpeg
activity for smu_v_13_0_6

Signed-off-by: Asad Kamal <asad.kamal@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
---
 .../drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_pmfw.h    | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_pmfw.h b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_pmfw.h
index 8f166aa3043c..7b812b9994d7 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_pmfw.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_pmfw.h
@@ -123,7 +123,7 @@ typedef enum {
   VOLTAGE_GUARDBAND_COUNT
 } GFX_GUARDBAND_e;
 
-#define SMU_METRICS_TABLE_VERSION 0x9
+#define SMU_METRICS_TABLE_VERSION 0xB
 
 typedef struct __attribute__((packed, aligned(4))) {
   uint32_t AccumulationCounter;
@@ -219,6 +219,10 @@ typedef struct __attribute__((packed, aligned(4))) {
   uint32_t PCIenReplayARolloverCountAcc;  // The Pcie counter itself is accumulated
   uint32_t PCIeNAKSentCountAcc;           // The Pcie counter itself is accumulated
   uint32_t PCIeNAKReceivedCountAcc;       // The Pcie counter itself is accumulated
+
+  // VCN/JPEG ACTIVITY
+  uint32_t VcnBusy[4];
+  uint32_t JpegBusy[32];
 } MetricsTableX_t;
 
 typedef struct __attribute__((packed, aligned(4))) {
@@ -307,6 +311,10 @@ typedef struct __attribute__((packed, aligned(4))) {
   //XGMI Data tranfser size
   uint64_t XgmiReadDataSizeAcc[8];//in KByte
   uint64_t XgmiWriteDataSizeAcc[8];//in KByte
+
+  // VCN/JPEG ACTIVITY
+  uint32_t VcnBusy[4];
+  uint32_t JpegBusy[32];
 } MetricsTableA_t;
 
 #define SMU_VF_METRICS_TABLE_VERSION 0x3
-- 
2.42.0

