Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D27C5C43334
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Jul 2022 08:43:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 069BB8B36A;
	Thu, 14 Jul 2022 08:42:58 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2076.outbound.protection.outlook.com [40.107.96.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 07D3C18AED9
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Jul 2022 08:42:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IRC/g2qyVjh4ngbmVZCnPXt0VaaY95WxRwtcxd1Mt6ERjWIXmNLNYGpDNQlWH2f00RudWWJeUPcvxiFgug2SMdGBSwoVjv5ThsMCXaoJolW/ZvOcAQyHQLX4kPfjE01wtSKcNmXq2p/loN0Kdktiji7mnUzE0iNdZiQtR1IS4OP4/7ZJV2RFCsvNU21bV0qn9Vni1d+WdoPMtF2OAAXxDs6erdbg79TeU1cpXjmdqvkjhJmxwiluCantx5Fw+2PR40ctFU5HJa/vhX+Vigh/INdx3RMWiDyAh9Evo3vW0+HgYlOfUIgqjvUZc+mCthU30btO0T4CWK2a7GEZ1Ln3pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LR5a2ovnFlu9cECiFx3hhXXTwU9hZtE7PewBjqrGVq4=;
 b=flNpC22mjMhI4xBRYGCOLS0U8XOksb1LXivketE7t/CXyRCaXKv6AqTWrXyHm1KHn2g7/y/2CuA9QadJ26U85Nbnlm2ONnGtwqsb9bIgiAA8U9h50aOds9qohWUKV7tJ/KzMw80HZSBRHJww7OChYZYKQxo3sliPMuF9YN606oBhx+GE4B8+haJOAkBLzPr9keXDfPMrZmKu7bje90YHxUDCEgRDHw3NUa0WHDtj3vva9z9bV4KZX2hwrvcFjcEL9pXm0TaQqWuPvgPtBPe5h7y4dPjupNBG5A9V9uacoywcYkwsQxjfg75yWTw9vBAGjtNetueLmkeQdZSQY7lc7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LR5a2ovnFlu9cECiFx3hhXXTwU9hZtE7PewBjqrGVq4=;
 b=d1nRkla7W8SejpFyAMsvPcFBNT4P5RZeysDsawhomHkyDSK9xUGqj7DrnO67alZ3pPCcWXqESfQfzGqV7XtOzZnLSq/6pnmnVlenGvJxpXVE2jqpfNNh5r95Hnb2KiT6PRdlcMRSsKgUKk2vJn5yFP2emWzDvuEw+BqwX/SPnUQ=
Received: from BN0PR04CA0150.namprd04.prod.outlook.com (2603:10b6:408:ed::35)
 by SJ1PR12MB6268.namprd12.prod.outlook.com (2603:10b6:a03:455::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.26; Thu, 14 Jul
 2022 08:42:54 +0000
Received: from BN8NAM11FT016.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ed:cafe::35) by BN0PR04CA0150.outlook.office365.com
 (2603:10b6:408:ed::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.17 via Frontend
 Transport; Thu, 14 Jul 2022 08:42:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT016.mail.protection.outlook.com (10.13.176.97) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5438.12 via Frontend Transport; Thu, 14 Jul 2022 08:42:53 +0000
Received: from guchchen-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Thu, 14 Jul 2022 03:42:51 -0500
From: Guchun Chen <guchun.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <alexander.deucher@amd.com>,
 <hawking.zhang@amd.com>, <lijo.lazar@amd.com>, <evan.quan@amd.com>,
 <kenneth.feng@amd.com>
Subject: [PATCH 3/4] drm/amdgpu: drop runtime pm disablement quirk on several
 sienna cichlid cards
Date: Thu, 14 Jul 2022 16:42:38 +0800
Message-ID: <20220714084238.2981-1-guchun.chen@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d87153b9-f6f0-4688-2d0f-08da6574d7f1
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6268:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mbXDdiKssW+b5vs9ZtZMqDRknSPrYlLC0l+NlOyBB91j7Ddq7NEprYdWRvGoe+1Szvj3eBT4fLuJ09MAXrCfgu4yojuacbCAvVVzvDN9DRzDdGabAoAC6SOJVYlxV5PFDiWuceBT+nFcAvWaRQJ6+zRU0KUaRnaBo4vZ7MKrthhGYJ+f0ANzVCJSRx7i91qD0ehmZSLW7rXl6SuXdrACMrUGXOuD4zchJ/nE+ra2eeTZkReae3ugNl0/0gmYSmTbRz0eROXeqhjlTZQgqRC+K+i9seOTLGYMYcM0G95xGIGxeXza+IZdnUjFyhq6kUMYwBXmlCBilTRXzsOYLs64xTs8I89Hlld1Z8KWcp9w3esRVk5fWt5ha6iz7mZtsK4+d7TquHL0xvMFCRdVFgE5DePMao9tHic+kzKs8kbPpmsVXD9o5pLzx6AjDeISt7HZ4iAb0uqrfPVmww8szpqwFiwqh9X+ZV9whnVtp0tOvB4loieIKKf+NrLq3ajhuM6G/2I+gufujAut1XBKnGkA86DOcGUlkjheCXqHT1qeVfkPmqQz99mbZWwgiPXZXew5b92gLrNqPZZUD2r87r2c3/sxCsOvvW90MaPmhgouAKm4DiRxIw/2C/X2OKsNRHlqu7MGLwGTJ5bzFQrp2O+eF3KTyz+ThY1l0wu6SbAaJA8ki+9jeWBB8piD67ozcRAL937csL6soEkM5WzGxl2KggC683wJil4I6eU6McZ+H/AdaPqoNA5bd+6k/SrxgdkoUAxgMEmq3qzrle811CUZtLNqtG9bJ5oX+mJY24fId1sFgQNgSfRGSTPR/lEVR9SaVFUq+BdkvBfh6qVYK68U6PWmYjAHRjzNmi/xEodLnZZ6ZPxbs1Y1niuhtbzQFZ6q
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(396003)(136003)(39860400002)(346002)(376002)(46966006)(36840700001)(40470700004)(70206006)(478600001)(6636002)(86362001)(81166007)(336012)(110136005)(426003)(47076005)(1076003)(186003)(26005)(6666004)(4326008)(2616005)(8676002)(316002)(36756003)(16526019)(70586007)(40480700001)(44832011)(36860700001)(2906002)(7696005)(83380400001)(5660300002)(82310400005)(41300700001)(40460700003)(82740400003)(356005)(8936002)(36900700001)(2101003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2022 08:42:53.9084 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d87153b9-f6f0-4688-2d0f-08da6574d7f1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT016.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6268
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
Cc: Guchun Chen <guchun.chen@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This quirk is not needed any more as it's fixed by bypassing
SMU FW reloading in runtime resume.

Signed-off-by: Guchun Chen <guchun.chen@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index ceecb74842de..9182e81e3135 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -43,17 +43,6 @@
 #include "amdgpu_display.h"
 #include "amdgpu_ras.h"
 
-static void amdgpu_runtime_pm_quirk(struct amdgpu_device *adev)
-{
-	/*
-	 * Add below quirk on several sienna_cichlid cards to disable
-	 * runtime pm to fix EMI failures.
-	 */
-	if (((adev->pdev->device == 0x73A1) && (adev->pdev->revision == 0x00)) ||
-	    ((adev->pdev->device == 0x73BF) && (adev->pdev->revision == 0xCF)))
-		adev->runpm = false;
-}
-
 void amdgpu_unregister_gpu_instance(struct amdgpu_device *adev)
 {
 	struct amdgpu_gpu_instance *gpu_instance;
@@ -188,8 +177,6 @@ int amdgpu_driver_load_kms(struct amdgpu_device *adev, unsigned long flags)
 			break;
 		}
 
-		amdgpu_runtime_pm_quirk(adev);
-
 		if (adev->runpm) {
 			adev->pm.rpm_mode = AMDGPU_RUNPM_BACO;
 			dev_info(adev->dev, "Using BACO for runtime pm\n");
-- 
2.17.1

