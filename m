Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46DECC433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Feb 2022 14:42:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DB1E010E9A4;
	Thu, 17 Feb 2022 14:42:07 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2064.outbound.protection.outlook.com [40.107.92.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7215310E89B
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Feb 2022 14:42:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y9LFqLgKuI7zq3k6SVjkpLSm0uLVob0zCTujeRF0lr3Lpp46bs/jNQEyLwKedPpwZ2zCwWvdyLXV8kS87XDYxVnu38gXywwGDnZLFldnlF16B6NebrMoQvmRQKdL+KOUCGcGSTEqDP2G3alU40fV+BYO5uXOp3V8oi5mXz+CMTF4yePp9SzrjxJdSavas+Mzp3l0UJMggsTOixMfbfyX4F/Dr6ANv0rQfvq7U5gAMXekGjJkRLZz21UKS/8Xi4QHTDgX1FMB168aiHDNRoIY3NXhh4AClpWdp4BUpSc4KJueVAIVxWfMYG23HHqoXT9VXdEa5KmjYt8x4in6lPcFHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RonV3UZKMYyljLCy78EntlZmCv8WakRRXH8WQlPzDJk=;
 b=VccYuWQtiRF+AVew4qbpas2rFraxUomY/cuPBZ9RE3MGcdMiMIaZI4w/JkqosA6oW+hGFepw63HE7Z9MFkOyW1dOIIlpYBPP3hPJOI8eBUsHXrzub79+sfakymD5X6YGeWBVpJ3YKNqAHmokv/G6O7aLwF2fkNf7V7x3MHBwYCrTd2yUC9PbDYgKzq23BBp9IhbGCPfrxxzfb2Sfjwm1SkQKQJFDccpyD39Gk9VG5iBGYrCDJx4+jKDQdRlpBUehlnd3n/s1bgJUZNNOJNGXt4N9waEuY1mi9kJ+3meQC6HljLglkbR5cm8BRfN7e4KIRoAaCR8z2zxMxMK5YsUF7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RonV3UZKMYyljLCy78EntlZmCv8WakRRXH8WQlPzDJk=;
 b=zJGd70UGVEHvIJ3/8OxtmFOGsnXSQbsZy/cTEIDldPwY6yqtn8p4mhAuZScY97MghoxARCafxEf6OPCWVLLQ0bgQsJPEgFTr5IiVMyszkpTPRcThO7UU9wlk2Lqu945a4mRbbqPDpLq2EKHGtDnlBMFrQmtGWmfzTjIeQiVPaLc=
Received: from CO2PR04CA0130.namprd04.prod.outlook.com (2603:10b6:104:7::32)
 by MWHPR12MB1328.namprd12.prod.outlook.com (2603:10b6:300:c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.16; Thu, 17 Feb
 2022 14:42:02 +0000
Received: from CO1NAM11FT047.eop-nam11.prod.protection.outlook.com
 (2603:10b6:104:7:cafe::3e) by CO2PR04CA0130.outlook.office365.com
 (2603:10b6:104:7::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.15 via Frontend
 Transport; Thu, 17 Feb 2022 14:42:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT047.mail.protection.outlook.com (10.13.174.132) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4995.15 via Frontend Transport; Thu, 17 Feb 2022 14:42:02 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Thu, 17 Feb
 2022 08:42:01 -0600
From: Tom St Denis <tom.stdenis@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/amdgpu: Add APU flag to gca_config debugfs data (v3)
Date: Thu, 17 Feb 2022 09:41:48 -0500
Message-ID: <20220217144148.1735978-1-tom.stdenis@amd.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ab3cdaf4-611c-4bd7-f171-08d9f223a95d
X-MS-TrafficTypeDiagnostic: MWHPR12MB1328:EE_
X-Microsoft-Antispam-PRVS: <MWHPR12MB13284A012857CD5F24FBB482F7369@MWHPR12MB1328.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:590;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jSFZ+brvA92qL8U0QOQJy8/oeuhgUlTHlQZL7bu5vEfoQVVzCxogG0unQ6lUCUdHR+4mnmjAzDJ0KgCaHHaQwypGzyMeGBrp6gpvF/hdvdQ/fAWwOnbKbzljNM7Zb1pdrzc2vu/EjF/7et1wZSmlSHUr26jwkHMpcWtsDDjgn93Fq8FRZOsec59i/34Ra3qR9bv6OJtjT9LJ5BBAO/p8ciuJika9dcYMzgLenxSy2hffVeFQdtOJsmNb02GVla4lVcDGsxYRAWSjTEXdpf01r7iqTzmMWh07aJ0N/y1FFiGvDGFlmWR6eDY9YyV1LcXE62hBCXCsNhRX6tz2ec09lxYY3x4NvZqg6sK1HiVlg7H6iEXXLCixDEJzjiMraQxRxaBcnkfLlaOQWpE/6UzHtgfyNLrXS2TQIk9AutX4M4jjHpjabV2ddat0P5aTk6hTxJJNOKWSe0gIHfAAOH4u+QvLnb1utXZFN9qsHM0ctpnhvg+hyeT+479025voPr+Wepb+wnEKv1IE5ejexdwQSIsrCbbbU3o4n8AgYGlIqrldS51gUvWm5W1rO+zoRV9eMKTHLieQfPa+w5/V1cRlj3glWTetxXNpUrrgXfvvnJtWj8tJr5YwKDvteAHsIkT5xz0/S5Iceh15P8FVeB+VaySGe1KYcuQKsheyPuPAS4iSeC+3R0cJqSMzq/5zHOOyuH4j8cJnI6dCwR0P+ioupQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(426003)(16526019)(82310400004)(2616005)(336012)(186003)(26005)(1076003)(40460700003)(36756003)(70586007)(36860700001)(6666004)(81166007)(508600001)(316002)(6916009)(356005)(70206006)(8936002)(2906002)(83380400001)(47076005)(86362001)(8676002)(5660300002)(4326008)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2022 14:42:02.7044 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ab3cdaf4-611c-4bd7-f171-08d9f223a95d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT047.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1328
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

Needed by umr to detect if ip discovered ASIC is an APU or not.

(v2): Remove asic type from packet it's not strictly needed
(v3): Correct comment

Signed-off-by: Tom St Denis <tom.stdenis@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
index 4b950de9bf66..db8a8710333e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
@@ -728,7 +728,7 @@ static ssize_t amdgpu_debugfs_gca_config_read(struct file *f, char __user *buf,
 		return -ENOMEM;
 
 	/* version, increment each time something is added */
-	config[no_regs++] = 3;
+	config[no_regs++] = 4;
 	config[no_regs++] = adev->gfx.config.max_shader_engines;
 	config[no_regs++] = adev->gfx.config.max_tile_pipes;
 	config[no_regs++] = adev->gfx.config.max_cu_per_sh;
@@ -768,6 +768,9 @@ static ssize_t amdgpu_debugfs_gca_config_read(struct file *f, char __user *buf,
 	config[no_regs++] = adev->pdev->subsystem_device;
 	config[no_regs++] = adev->pdev->subsystem_vendor;
 
+	/* rev==4 APU flag */
+	config[no_regs++] = adev->flags & AMD_IS_APU ? 1 : 0;
+
 	while (size && (*pos < no_regs * 4)) {
 		uint32_t value;
 
-- 
2.32.0

