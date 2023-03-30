Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DD90C77B62
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Mar 2023 19:46:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5141410F003;
	Thu, 30 Mar 2023 19:46:09 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2084.outbound.protection.outlook.com [40.107.94.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5B3EB10EFDC
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Mar 2023 19:46:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z2l9rcisbSDz99gRLTLaqte+rqdXGWZl7EDNqZAktiYPScWxx2b8j2zGVw0IXif66IKjdLgm0uMCAjA0rHxtedgZyX5ekkUF1oUBpWpzGiVEQ1O2T1SOKSdcHoFNuYffVNYCGEaljoOSI1tXY89iBwgG8OkaEOMHQgpDIdbbmeQtGLGq56zhtgbiiza1dCYeHaZDA3UGH9KKHYwUIDT0Vr9JhyVV0y60XOGrjf7m4bzIqauuW03eU21/oG18eK8DflGymMf0DfuHY6bJ7/65VQiS+W4rQfy1t5IcKyFlJ6SqgDn5TTBs1+CaMXuZV4opDx4reWDnpjpY2Ar1Ea2D2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=svCDSCXoVSXQknv9vNKFni/qENCbgOsc8XQ7vPM2miU=;
 b=PG2FlmUAGSSDZzEArnwCfNOJhYanKZ9qx3jlAQqpV1XppH+boUMCj1XvR33pIkq5o3h2o4TsGc8LW8ncrh+GQbAimcVb8Rn5tTr5840HcoETH0AVPe76as7NTkaobV2YR9GujuttQARmqtjJhaOEu/6tXbDQmBLaFtZI8c1aDYqUOKX+vpO1dLiWiHOyfl+Sy99lhFSDuRl7im63SK1kGAWRF6cybAlyodOUO+2zQTXHnVBlGvUWCMHC/+jAv7tAW/m44es6vr/BYNKQo8BIH9Fpta43d7xGKNTBLyGqp8ZFggBbFE1CzWXNMC/9aNJCDzHKVFC2T2P+j8lB+Fstfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=svCDSCXoVSXQknv9vNKFni/qENCbgOsc8XQ7vPM2miU=;
 b=Wzyo1wXfvjge0328/zbJGXb3LQ9oPoPL4SFWk9tzlmAVxghhKdjgfX6TL4h8ljVYlDBKwVEGTQhuD2fJKbPtql0wtl7KEmIORaHhgnqItDDhxaFKxllFPJ0AIkxj+6umonhRY7NDqTyO0vJtoG7n5NJUYhPnpRwO3LHfgy1sVEs=
Received: from DM6PR13CA0016.namprd13.prod.outlook.com (2603:10b6:5:bc::29) by
 SA1PR12MB6917.namprd12.prod.outlook.com (2603:10b6:806:24c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.33; Thu, 30 Mar
 2023 19:46:04 +0000
Received: from DS1PEPF0000E636.namprd02.prod.outlook.com
 (2603:10b6:5:bc:cafe::b6) by DM6PR13CA0016.outlook.office365.com
 (2603:10b6:5:bc::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.20 via Frontend
 Transport; Thu, 30 Mar 2023 19:46:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0000E636.mail.protection.outlook.com (10.167.17.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.30 via Frontend Transport; Thu, 30 Mar 2023 19:46:04 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 30 Mar
 2023 14:46:03 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 8/8] drm/amdgpu: vcn_v4_0_3 load vcn fw once for all AIDs
Date: Thu, 30 Mar 2023 15:45:47 -0400
Message-ID: <20230330194547.1135862-8-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230330194547.1135862-1-alexander.deucher@amd.com>
References: <20230330194547.1135862-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000E636:EE_|SA1PR12MB6917:EE_
X-MS-Office365-Filtering-Correlation-Id: bc35c00f-b050-4021-cdc0-08db31576622
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aHVSPeYeGXkU6wWQ3L8DwPRZLUkywlSFEWa4glMhzMafx8J20QQm2q9gDzivsXVx8ltUkCxhKI6jvcRay288j2IoZyuks0iSJD9U18532fDZbXMYcJBFW3uCopgEMJrCGnNKf3OOAVBjmu0T3W9Ezn8OzxKHoiaD1NaGoS/cPqzwEDB3Vpb/qTBoi5nyM4R3avD4x5w6DMYEAYC687pclxGQIUJjq0ZUNwTlwfAmzQmqNuyPuwU0A9544y7pBVgTpw6wANfjJVdoo8H3X8Jf6yAHoB5zakma0LCjCQP1jgBkCDDcmiVPRsQX4iup7xMav5O26OiuYC4zuITqoBqQrHsyA35cAwE+CaQk3tCNoyDQTVMzCrIO9r7V/AER5rSIZqEBvPhxfN4IWtUIUUWkN3XenTXgCIVj82UGPPADJMfQPRu3+ONvYEN9SbvuwrkBukksHmXs26A1XK41C7U7sSvCpzEFmtYZwR7zOvn4w87462elm07fq5B2vmO2bvmPJNxnWg5vVwDI4XAUkeabapDjltU81w6Wbn3z7vcVAPvMCGN555X0XqtVCrnSAZS/c4nBzhF70l8bhBZC/I8h2bXD7M1GDiSvRoQ+NGCWxX3KqKV9Doa/UvjvzvmDyB7+sC4RrNq0l72MxYr+hIbKRZX8W6f4YFNh5AUJf156jD4zGRDn1l7nWxl1aLKhCqywEvE87z/GPLgurkBBkMINAu+8rwlzovL8m3y6m3mOqPw=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(376002)(136003)(346002)(39860400002)(451199021)(40470700004)(46966006)(36840700001)(26005)(8676002)(40460700003)(7696005)(82740400003)(4326008)(41300700001)(2906002)(70586007)(70206006)(6916009)(356005)(36860700001)(36756003)(8936002)(478600001)(82310400005)(5660300002)(81166007)(86362001)(316002)(54906003)(40480700001)(2616005)(6666004)(47076005)(16526019)(186003)(1076003)(426003)(83380400001)(336012)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2023 19:46:04.7748 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bc35c00f-b050-4021-cdc0-08db31576622
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000E636.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6917
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
Cc: Alex Deucher <alexander.deucher@amd.com>, James Zhu <James.Zhu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: James Zhu <James.Zhu@amd.com>

Signed-off-by: James Zhu <James.Zhu@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 3 +++
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c | 2 +-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index daa69ae766d3..57dabfe1a1be 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -1046,6 +1046,9 @@ void amdgpu_vcn_setup_ucode(struct amdgpu_device *adev)
 			adev->firmware.ucode[idx].fw = adev->vcn.fw;
 			adev->firmware.fw_size +=
 				ALIGN(le32_to_cpu(hdr->ucode_size_bytes), PAGE_SIZE);
+
+			if (adev->ip_versions[UVD_HWIP][0] == IP_VERSION(4, 0, 3))
+				break;
 		}
 		dev_info(adev->dev, "Will use PSP to load VCN firmware\n");
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
index 18320eebdb4c..746df23b2eaa 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
@@ -730,7 +730,7 @@ static int vcn_v4_0_3_start_dpg_mode(struct amdgpu_device *adev, int inst_idx, b
 		UVD_MASTINT_EN__VCPU_EN_MASK, 0, indirect);
 
 	if (indirect)
-		psp_update_vcn_sram(adev, inst_idx, adev->vcn.inst[inst_idx].dpg_sram_gpu_addr,
+		psp_update_vcn_sram(adev, 0, adev->vcn.inst[inst_idx].dpg_sram_gpu_addr,
 			(uint32_t)((uintptr_t)adev->vcn.inst[inst_idx].dpg_sram_curr_addr -
 				(uintptr_t)adev->vcn.inst[inst_idx].dpg_sram_cpu_addr));
 
-- 
2.39.2

