Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D89BC4332F
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Nov 2022 07:26:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4303110E05B;
	Tue, 15 Nov 2022 07:26:22 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2078.outbound.protection.outlook.com [40.107.223.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0D64510E05B
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Nov 2022 07:26:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fLv2G4A2xemEQa42q9GdvwvYuufGRelWXYati7uCd32CDJsckM+rrHkqsBG/ZSLAngj42tc1+1GY5PgN4Q5EjMnKOxlxqBjIpET7pj2iLly+dtd1lhDaZfaMqVMHzlJ2VS4h/1LHBfu6lMcd5PZCLvNmIs5CuxAiJ55BmZCvbtRvCWrO/s16x2ST6Yz6d8KUBwfr8GWPhz4jvwXMa8fvRmx6U5huKJbjHf4yJ4RdbrI0v7glA2IKfZjPzmTWU4lnTSenyYcQHsSCL1gYXKI+7m3KDBjIL5fGXJ8163ipVJa6spmgXSBVt7xFWG5LOxnVpoHz3uwLbfHc59YGbDCimA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3/ciu4wF4oxC14uZ5ZE0lm6jPAm/wz3I06m02BWymCw=;
 b=nyh1zOP/FYoWN2G1GD++rqwLF2EgIF371n8fkdXgTZSZslkxsLtkoOHDbQ9DiIOtQ6xlQmZ8Ws+wT72VpdHq5iXpLMK4uwxX3fbLR1qsFRVKEvTniUvycilNo8tRgpr3IFibs8R73p5cyKGfTlKh9Ng9ZQ3cbPCpoD8XFMITbqDNQP750cgGfnk63qr9u+NYMGp4ft6dSPRFyIh8iDFCxPXf1CaTXZEa9zN5pjSVxe0Fh08dNsgUnnXXVCKaH2rtUpPFu2IZUE/cdwjF33b7AhtfcIGie/nPU23qZnniWUOlYAhMIyh0vxxzUkIo5o3xFeinGjbEaW3YrC4gUlrTrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3/ciu4wF4oxC14uZ5ZE0lm6jPAm/wz3I06m02BWymCw=;
 b=JtO8vcvKvnlfvZogGzKAEBwaeGoiVrW6p52VB6ypKf7gWfKKW6VAJ73b3UDjSJt+uxJeax5Qu9RYACGmnAhYrsCkBkSMUI3RdX6vL3ehbao1jTV3ztqlsg4KxeVXoOF9rmSZM7g4w9NnouZIeRsEGQ3YoQsBTOM/t1wkVk86ksw=
Received: from MW4P220CA0030.NAMP220.PROD.OUTLOOK.COM (2603:10b6:303:115::35)
 by BL0PR12MB4913.namprd12.prod.outlook.com (2603:10b6:208:1c7::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.18; Tue, 15 Nov
 2022 07:26:15 +0000
Received: from CO1NAM11FT007.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:115:cafe::a0) by MW4P220CA0030.outlook.office365.com
 (2603:10b6:303:115::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17 via Frontend
 Transport; Tue, 15 Nov 2022 07:26:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT007.mail.protection.outlook.com (10.13.174.131) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5813.12 via Frontend Transport; Tue, 15 Nov 2022 07:26:14 +0000
Received: from thomas-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 15 Nov
 2022 01:26:08 -0600
From: YiPeng Chai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Enable mode-1 reset for RAS recovery in fatal
 error mode
Date: Tue, 15 Nov 2022 15:25:41 +0800
Message-ID: <20221115072541.4154199-1-YiPeng.Chai@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT007:EE_|BL0PR12MB4913:EE_
X-MS-Office365-Filtering-Correlation-Id: 109f81da-fc9b-41f3-0685-08dac6daae01
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lCKZ8ZEIo6N4NqGwPT8Q6L8YkrFZjQ7Tbv+PlR5sJ97WiGnK0hOZl/1HjiJApgxJQQipnXvqy1mHDCQejHySKK1chuL5aGzM2TVvmDo5WDftps6Pzb4y31DtKMcwrhfpLqre7FqVElEOSRK8D7T1DG/HHLzjm0gNMyk6FImSON5TCQli77ntEIqAWk2d3a32u1Khn+s88Zp6T8rOGUvvCFyNA0fSIDoKddFf9+gr3JSQmbyuW1izRGYaa18dxMhAVRbB2F3uKzPAeyoCWnvq/ttDNTueBQz9Tjvb4FBJFajhMCJ9Tz+dmWZVNCDeysFnxoqCDTf6gC4nfTyWgGtQ1As9yqBm88Bw1vNh3hDoJ5Aq4Sm/nVcK/CT/1u5DmHp39rn2e0Sx5DXR9FG1JSBjbvUpTe7BSSjQTsTKXykbp/t5OzA+M/a5aqtHNlu5u75L335NwIHex6IwpUdPllzzsOEZO6MblmEr5o50R5lETZShORYx0SEIImPFkG/WrJjRBVuG10if5P+zcorvgTyXpb2dSU+nl/k6Appo9dV/UpRaQcRq80Rw+aoMVsjli4Cnyp33m/IwAtzjk1L0yZuMkDSm0NB3lp+H/+oj0uSedg3J4wiO9kiOb8If/tGZp2Q+lA5YVoQJl//CI89jMOT7pya2N7omC6U/muU3QYFpwP7yjSOgq4Eu4JQodk1cEKNgd8UZ6YhhfH0OeUvL4uVZmcR3jSsPkwKeVDqya6uSQSbvrlx2uIww6rtKu7fyVQ6bPGiYAF514UJThcLsdaFRCOqENoKxOCOrwy5/uCCTnfZMvEwS6M8SesEFzfPEs7q4
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(39860400002)(376002)(346002)(396003)(451199015)(40470700004)(46966006)(36840700001)(83380400001)(478600001)(26005)(1076003)(186003)(16526019)(2616005)(82310400005)(6666004)(336012)(47076005)(7696005)(426003)(86362001)(40460700003)(82740400003)(36860700001)(36756003)(40480700001)(356005)(81166007)(8936002)(41300700001)(2906002)(5660300002)(6916009)(54906003)(4326008)(8676002)(316002)(70586007)(70206006)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2022 07:26:14.9413 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 109f81da-fc9b-41f3-0685-08dac6daae01
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT007.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4913
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
Cc: Tao Zhou <tao.zhou1@amd.com>, Hawking.Zhang@amd.com,
 YiPeng Chai <YiPeng.Chai@amd.com>, Candice.Li@amd.com, yipechai@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The patch is enabling mode-1 reset for RAS recovery in fatal error mode.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 4 ++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c    | 7 ++++++-
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 5b9f992e4607..ac824eb93285 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4582,6 +4582,10 @@ bool amdgpu_device_should_recover_gpu(struct amdgpu_device *adev)
 	if (amdgpu_gpu_recovery == 0)
 		goto disabled;
 
+	/* Skip soft reset check in fatal error mode */
+	if (!amdgpu_ras_is_poison_mode_supported(adev))
+		return true;
+
 	if (!amdgpu_device_ip_check_soft_reset(adev)) {
 		dev_info(adev->dev,"Timeout, but no hardware hang detected.\n");
 		return false;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 693bce07eb46..8fca3cc273e8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -1948,7 +1948,12 @@ static void amdgpu_ras_do_recovery(struct work_struct *work)
 
 		reset_context.method = AMD_RESET_METHOD_NONE;
 		reset_context.reset_req_dev = adev;
-		clear_bit(AMDGPU_NEED_FULL_RESET, &reset_context.flags);
+
+		/* Perform full reset in fatal error mode */
+		if (!amdgpu_ras_is_poison_mode_supported(ras->adev))
+			set_bit(AMDGPU_NEED_FULL_RESET, &reset_context.flags);
+		else
+			clear_bit(AMDGPU_NEED_FULL_RESET, &reset_context.flags);
 
 		amdgpu_device_gpu_recover(ras->adev, NULL, &reset_context);
 	}
-- 
2.25.1

