Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F125EC433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Feb 2022 15:29:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8539F10E5AD;
	Tue, 15 Feb 2022 15:29:11 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2072.outbound.protection.outlook.com [40.107.102.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4F7E510E5AD
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Feb 2022 15:29:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C+/mW3SdQsbdIR3CiowpnbJA0Y88TToxb2ylXz90XTFp3fyJell0VsYc9hnMZg+BHzwLRlfUlgMBCaM/MDrfFjEChfpvD22z9EAd6qEtEHWBxHu9lBy5x3vxr060wLlPnvRjmhb+RiNDUedpA65/YT33I1OCRttiPQpDM4P43oflD4yzKwPQJcEyaARdoQ71Im34lp5MqwlsS3dX96yYCMOEixZJmgkJ164cYB8XWrN+K43v4tB6s++yc+RI4ePu/U6kkP+u8nFZl6tUusD5FM1/GJT/N0UZA1x32dNpNS8KwGJAuZzU0zOlJcm0APiXBrcQBjOsnv+ydi2D5jLPjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kf6NHZ2WxwZena8aWLC+K8KbluHAzYpEdO9l7Del5nc=;
 b=TshH5o0dEUsBbwQZYoy9sVcUugk9WkKVNbP2LkQNSWOYdAjkaM95bDE7/C+peY268fQe6iJ4svHsEyg+KmL/a5FZK8HDNbL4shd+SnpHcqQO9DU4us8G3k8ti4+kmho69KY4iDAOUDChKTQmy3ZtzVxYYOD/xJEftbXIugS6OSO712szEdaOtAaPhRoxmb7J3d4FJ2/wKW4Rf1sjATT34yBQDAXZtqoC0ibCBIVeylxj1MxryJJ8qMh5Qw5vxvoX2xb0J4HDRMtP7re/zRvxuv9xJVziD08MiD8Gj8V28NSsvBZ3gkS2CF3BXAJEeUNFHuIBBD1HamU4MhWd7kSycw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kf6NHZ2WxwZena8aWLC+K8KbluHAzYpEdO9l7Del5nc=;
 b=ROrqokFEldLN7bymh0qR4MVK8h6aQjlcfbgprATvqu1W210pMdIKJ2inaaLRTvVf8xBOZBXwwJnIKbz5V4qnrZ0GF1sxeQcf6seWA3Gt9MjnqGRVj0lyhJG4P4mJae3WefwYhxDPhUrqFv3wgdsaTcSdBuynLB+Yw+KJ+S2cl3A=
Received: from CO1PR15CA0049.namprd15.prod.outlook.com (2603:10b6:101:1f::17)
 by CH0PR12MB5203.namprd12.prod.outlook.com (2603:10b6:610:ba::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.15; Tue, 15 Feb
 2022 15:29:07 +0000
Received: from CO1NAM11FT052.eop-nam11.prod.protection.outlook.com
 (2603:10b6:101:1f:cafe::55) by CO1PR15CA0049.outlook.office365.com
 (2603:10b6:101:1f::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.19 via Frontend
 Transport; Tue, 15 Feb 2022 15:29:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT052.mail.protection.outlook.com (10.13.174.225) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4975.11 via Frontend Transport; Tue, 15 Feb 2022 15:29:07 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Tue, 15 Feb
 2022 09:29:06 -0600
From: Tom St Denis <tom.stdenis@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/amdgpu: Add APU flag and asic_type to gca_config
 debugfs data
Date: Tue, 15 Feb 2022 10:28:59 -0500
Message-ID: <20220215152859.1519226-1-tom.stdenis@amd.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f06ecea6-73ea-4a07-1b59-08d9f097e7f5
X-MS-TrafficTypeDiagnostic: CH0PR12MB5203:EE_
X-Microsoft-Antispam-PRVS: <CH0PR12MB5203EECD0257C23B47CBE84EF7349@CH0PR12MB5203.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:510;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OFClrmj+jULomFiSXOAopHLQs6PNcZmR64HHshVuG/Du5VeEJrMIBqhtTnrVNdIL7J1/DtuIutieLqOPANDt5Wq9Qrey7vPTtSBHVy9TJ2CYKNEG97uGsPmFMM3kiH0WXAuIPCgXp7C+oFC5yO7bjWvzZkX3YcdN+VDaPucNerCr9CHqlinGVW/nDwtzH0X3N+eZHU5kocRvrg3vdORoLYPRS16yqwZEq6sOEZDdl4vHQAaQhCZ9sN5MQ7WKFJgGyH3j5dzEQrZuK1nvPKmBDVacoxlU4i60MnqpLfH1mpMQWWI2f70Y7WEmDuTSgzqLOGCXFS3n+z/gbUrYegkpPoudPB5N0HETUOm3uAmY14LtunuivWYO3tB7HwSpD0SuSOtJ0fQSf9NZVZvn/cOglpZ4BAjOYTABel3kEWyskuaZcQ88jjErDx3eNHDZ1Ffm+x/2qu/kI2fL6UqdHh49d747B+RUabHEXmFQc8jNdGY2RqzagI8ZzXozTQmrCan1Bgh2TZx/rV1zTSVZ1PG1wuvZK5N8n9PRQOdvqELnxPO1/OMVIs6rFFi5zmOO6zTbNbQrMXjRFd6fU0bp8283SD9nMTx2b25dVQdyLF9zEVOo4AVM8tluQnCHVZ8CLrwUen/F+zZYkjjm+oISF6oAN8t3OFo32IWbVieE6sB9U8cFOU7HSSVKPr2458Zfgdi3Bq7uh1O7C/50OTvZAlVb/g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(316002)(86362001)(6666004)(336012)(26005)(1076003)(186003)(40460700003)(508600001)(6916009)(82310400004)(16526019)(2616005)(426003)(2906002)(8676002)(83380400001)(47076005)(36860700001)(4326008)(70206006)(70586007)(36756003)(356005)(81166007)(8936002)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2022 15:29:07.0557 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f06ecea6-73ea-4a07-1b59-08d9f097e7f5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT052.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5203
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

Signed-off-by: Tom St Denis <tom.stdenis@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
index 4b950de9bf66..3b2341610c16 100644
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
@@ -768,6 +768,11 @@ static ssize_t amdgpu_debugfs_gca_config_read(struct file *f, char __user *buf,
 	config[no_regs++] = adev->pdev->subsystem_device;
 	config[no_regs++] = adev->pdev->subsystem_vendor;
 
+	/* rev==4 asic_type and APU flag */
+	config[no_regs++] = adev->flags & 0xFF;
+	config[no_regs++] = (adev->flags >> 8) & 0xFF;
+	config[no_regs++] = adev->flags & AMD_IS_APU ? 1 : 0;
+
 	while (size && (*pos < no_regs * 4)) {
 		uint32_t value;
 
-- 
2.32.0

