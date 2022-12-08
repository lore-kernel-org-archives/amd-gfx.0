Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 356EBC3A5A7
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Dec 2022 07:52:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C5A9810E467;
	Thu,  8 Dec 2022 07:52:01 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2072.outbound.protection.outlook.com [40.107.102.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 49A5110E467
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Dec 2022 07:51:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bgi28tvAMBfwLOxjJqocsN6QPAKiYIBor9wesIs/2Qmb29mK01qX/2AZzn+BkepFTdqX7ARECXsAzaYjloAvRPAUtHgxUWxBv4uYw6hCN78jXeJH0mv3DoK9VDvBLSBTAMU5ZA6j+DHl6TnB3Cf818QxXM7ZulPrBD1Izc8ssmVdiweohBpOosAXylGvKEqufsPIFawY6EwkjJYcoWZ9kSp8ifpojjUTIbDiCGrqPMHvHVsKpnXecEFLatnCDhNNIro8sVo3rxNR8sqxZEh1uYxf8Ou2QR1zCwrlQsk5HEyaZafxJsHpsn96DC7WSJSsZ+/tU7QXb+kkxjPmS3LRsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E4beVY9mIKK6oJezFPUkfqIvw5MXdXoDQxgCflZfKqc=;
 b=BF5l8pZAMn4b0HDW/KBzInTlZnxL1yhMtwHNozBEmVaO8SPnkAnk1Hgupvz9ANw2ybtUADWgddj5xcP4tmRz/Rr8gmzy5qSlF+tbl5ZEO1zq+ocnWZEz3IetN6ZZUpDkXQio12OdPtkZLzxWT+z9nvrRK5wkTX5cX4wjAIOK9SEsXywKpxw6hGneMQHmfsQv7e4R3JJejRna2j01Npp2O2FPkJUNLpU7nEQ3jOOn+J2xSeTXqU2iO4NNsSJJWc53ToYxDmRzet2PT/Db/AKZKzrLrdP+aTag5KLE4xWTfn3hm9bQ8r+9E18HvuEv4X2QUAMObhq1u5Mhf9SArGcXWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E4beVY9mIKK6oJezFPUkfqIvw5MXdXoDQxgCflZfKqc=;
 b=fN7AXag95VxH+O2IcWXtcvXM3ud2cMukUskpOotveHCIjzwHo6rf97Ycaw1NBKhxBV10bzjacIY244rlpEBhXrEjo6toxlpM1c2Bh0DRWrSVqejxlMpSFAuVLzpLMka8042ZQSUKM8z6tTCRcSy3imhtPqdnzNnGNeZkwAJUWoE=
Received: from MW4PR04CA0375.namprd04.prod.outlook.com (2603:10b6:303:81::20)
 by BL3PR12MB6524.namprd12.prod.outlook.com (2603:10b6:208:38c::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Thu, 8 Dec
 2022 07:51:56 +0000
Received: from CO1NAM11FT061.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:81:cafe::fe) by MW4PR04CA0375.outlook.office365.com
 (2603:10b6:303:81::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14 via Frontend
 Transport; Thu, 8 Dec 2022 07:51:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT061.mail.protection.outlook.com (10.13.175.200) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5901.15 via Frontend Transport; Thu, 8 Dec 2022 07:51:55 +0000
Received: from taozhou1u2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 8 Dec
 2022 01:51:51 -0600
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <hawking.zhang@amd.com>,
 <stanley.yang@amd.com>, <Gavin.Wan@amd.com>, <Vignesh.Chander@amd.com>,
 <david.yu@amd.com>
Subject: [PATCH 5/7] drm/amdgpu: skip RAS error injection in SRIOV
Date: Thu, 8 Dec 2022 15:51:20 +0800
Message-ID: <20221208075122.28702-5-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221208075122.28702-1-tao.zhou1@amd.com>
References: <20221208075122.28702-1-tao.zhou1@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT061:EE_|BL3PR12MB6524:EE_
X-MS-Office365-Filtering-Correlation-Id: 2becbfbd-73e5-455b-31ba-08dad8f113bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TYIzvNsKI/hxiluYBozoc0SOdUzO3ZvrXv7TNAhmtY8xIIBn+PXJ9eWGSP/3/kbwTdPIQUOZhraX7L5fjn99CasrdAXNeTccVpefKNnz583ZKBjDkPXzwsn1AlDc4hPl+cmV0COFD9oyZK4F+hTvUXEPs+am1CeWbPcp0VKKjVmRO1Ex503re8G/9RYwhMJHiY6svGQpMYcySD58A+vF3vCUJcK+pNRLcTje08m+pjk0LnLt/2zAnncESObRri+gbGEzvOfAUg06HBRYSjRhtViVoQBvxsffJDTKR8I7r/4gV2jNRIVIkDfZffygtasUPpuhSdv0TGB4cAWwgzW08OFTcnIy4qDWcUY+4MpvfNH0MRG4uPIdVCFN6IYSBySTjQfWV22Fqn9ajKzCcmo7dFUGvffDI+rK7lsOdw5FVeHi6LgObl0dJdZ3AbZRxxzMKUs3sAV7CkWXNzhM5Ez6qpYtO4lkJDWLePEFU2RNRpwOB4KSMTyDxymQaWyJyTHdQ59XBo79WKN8ieSBwT96A4UX9wGIbsEcXstzVfrAaDFcaDne9d9CqjctrpuMysEhLerHb89jc3VNK9FLno3INheBgabJzttCtHRb1z2gipl+3e8poPf5UMZRF7rB0hPdvB76RHcppHlvW//brEyD/p4sI4a7rNCCTC4jan5MYu0ERuU4GcBWS/xZUdZVh5H03a8o6q7LRUSOG1UjpShu2EaGBwl8g4tr0gJKVeR8Y04=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(396003)(376002)(136003)(346002)(451199015)(46966006)(40470700004)(36840700001)(36756003)(81166007)(8936002)(86362001)(356005)(41300700001)(4744005)(40460700003)(82740400003)(4326008)(2906002)(5660300002)(36860700001)(83380400001)(316002)(110136005)(70586007)(6636002)(2616005)(8676002)(82310400005)(40480700001)(16526019)(70206006)(6666004)(186003)(47076005)(26005)(478600001)(7696005)(336012)(1076003)(426003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2022 07:51:55.4824 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2becbfbd-73e5-455b-31ba-08dad8f113bd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT061.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6524
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
Cc: Tao Zhou <tao.zhou1@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Injection on guest is not allowed.

v2: return directly in SRIOV environment.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index ad490c1e2f57..4e450e0b14fa 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -1087,6 +1087,10 @@ int amdgpu_ras_error_inject(struct amdgpu_device *adev,
 							info->head.block,
 							info->head.sub_block_index);
 
+	/* inject on guest isn't allowed, return success directly */
+	if (amdgpu_sriov_vf(adev))
+		return 0;
+
 	if (!obj)
 		return -EINVAL;
 
-- 
2.35.1

