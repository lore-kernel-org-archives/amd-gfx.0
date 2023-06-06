Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DE4BC7EE37
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Jun 2023 19:57:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 91EAF10E19E;
	Tue,  6 Jun 2023 19:57:58 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on20621.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e89::621])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7BF5D10E19E
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 Jun 2023 19:57:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aYjSn/z0ZBwIdLdJ6GY6TrdyUUczO9B6Xm/F3CAzOtUWz0YGjLuNmgivckq6VNmokfTZueE+Z8LRsn3tB2QKPUBgipthYvxeBodirn4xDGY4cOp1NrixP87JdklmQbLmUg2f4dzWovJG1Mbvic0/DfiU2tw0dLj8bKdtV1ev7z2AAOOhZG88Pltz/G9GqsjB0XrbCjJ4Muv1qMr6FMRT/DJPtXHmz0tRg43YA8jDups0gutQrageK8G2choqqSAFs+NBCERS/pUppBPZn6WWtm3k49MfZ893jd3j1t4ocBji/pp2G98ABBdpB7A3fVLCHakk9OtOTtNelSp2vOzIMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qiWnrGTZGZOP5OHEweH8oSQ4ZY7F71AHHk+vuEgIuLA=;
 b=LhZziDzbyH20SvffVKI5g42pmfyBGhVyD3W5fuiJ9E1EW5CAa+mVu3992Kxqjq6Urf8YbPeb9yOwjGwrF3H9HXB4lkY7KVO0N5bHxqnBbIroxntpB0J8Tid1isLH+OnWFaimKubk/IwlAGWy3r0JTHMhJ3CU/hlsHxpTZMgViAugWML982B3jMsYE1u67Y5VM22Xhl/SX0KUZE37oTbwKx2CqH/+ClOBTa0+T2k/fUlnaxkXqBW85CJ4wewTPlVT/czBCo8NyQAVVMGLCkpta8P5+tm47LXBvMyRrG1x59sdQnpx9H7ZhbisQb5rd0k4OHrgF/liSB0igm1QMC9OdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qiWnrGTZGZOP5OHEweH8oSQ4ZY7F71AHHk+vuEgIuLA=;
 b=yA8dvbmLxkxt7H0oRntIW9f+ll6kbe2RqcMm14sZCjAeZPdB1/4XhRRtR8qqMK7uivw+MwtctWRY2+frIvPAxMYj+WAVGXuqjGuR9kDyFQDGcP8mVKDZQ7XDXSHogwoiJ0KfceY7jdbKh+n65ZMX4ydGZG5FknOM6d5t1qyENiU=
Received: from SA1P222CA0073.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:2c1::23)
 by MW3PR12MB4508.namprd12.prod.outlook.com (2603:10b6:303:5b::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Tue, 6 Jun
 2023 19:57:52 +0000
Received: from SA2PEPF0000150A.namprd04.prod.outlook.com
 (2603:10b6:806:2c1:cafe::3c) by SA1P222CA0073.outlook.office365.com
 (2603:10b6:806:2c1::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.19 via Frontend
 Transport; Tue, 6 Jun 2023 19:57:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF0000150A.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6477.13 via Frontend Transport; Tue, 6 Jun 2023 19:57:52 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 6 Jun
 2023 14:57:51 -0500
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Increase hmm range get pages timeout
Date: Tue, 6 Jun 2023 15:57:17 -0400
Message-ID: <20230606195717.32605-1-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF0000150A:EE_|MW3PR12MB4508:EE_
X-MS-Office365-Filtering-Correlation-Id: f6c3a85e-95db-43c8-cd66-08db66c84fe5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: m0QZLArALfPHXwa24q6ZeCrPFanHv9Lj7kgvHe7sTl68M3WDbbMxkc7sMlVD4/0o6VIMS10rwvE4o3sEEimToPeXcxsbFkDmc9111UHgslOjBDo400PkM8xy/1PF8wGGZQHgxvH1cCb1PlX2UHhOS/THMXU99pYsP1aLDyArBVEwyaKUbuoytysPB2hZU5VwDjUXOB32UQDovfFKyDME/Ivqt25bq+u8LDM2Fe2NK1DcqyeYYGFtCL2agi0kABpxP+u+W30sLnWqDIo1m+5TLsIgBeoMmGvSEazPy3aBag/0JyB76Klkql9QM7wSg+LG4rU5vVevgkDLEEr0Er2h/WhE3ZWjNzernz9xxL4mVHht9m3s4m88DU3lJdpSlD/xE3KpHCqPA6H6bc7pmXpJC5wwr7F+T1fg5OBjUnL4BaDs96oKrECpLl0jzL6OndKja7jHl3/bV69s+VH+szCe2oA2E3ay7Wv3d/L8g1A9w8yA2aSbkBop+/0BXoizyAY5PTSZ5nyhKTfBMSYBKq6uLFBeUPCYvn+fkU5+F9CPhwT2xoPgfRYBHzLCQsjyXPTj8jCqXo7GKU023ZgsypMxbaJhQgxlyT58+6hiZ3AFa7Wa5YjYvxoEcxGaYNXouxVQzMzcNsIpsqHhnG4omc42WJzyYrOkfRLUV7CdLHBsM3dsN+ffV60cPrJZav+HbE5J9Vk1Wrlr6C2w2NCm2kcC+Vkz5RgnryflTRwKhOZ50ON0oKB/CStvWZuj92q0+uCEmO1+gJIhqpkdwyLYefj2nA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(396003)(376002)(136003)(346002)(451199021)(40470700004)(46966006)(36840700001)(41300700001)(316002)(478600001)(8676002)(40480700001)(40460700003)(47076005)(2906002)(36756003)(82740400003)(356005)(70586007)(8936002)(5660300002)(86362001)(6916009)(81166007)(4326008)(70206006)(7696005)(54906003)(6666004)(82310400005)(36860700001)(426003)(186003)(336012)(83380400001)(2616005)(16526019)(26005)(1076003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2023 19:57:52.2384 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f6c3a85e-95db-43c8-cd66-08db66c84fe5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF0000150A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4508
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
Cc: Philip Yang <Philip.Yang@amd.com>, Felix.Kuehling@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

If hmm_range_fault returns -EBUSY, we should call hmm_range_fault again
to validate the remaining pages. On one system with NUMA auto balancing
enabled, hmm_range_fault takes 6 seconds for 1GB range because CPU
migrate the range one page at a time. To be safe, increase timeout value
to 1 second for 128MB range.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
index 2dadcfe43d03..f7efa582f3ed 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
@@ -190,8 +190,8 @@ int amdgpu_hmm_range_get_pages(struct mmu_interval_notifier *notifier,
 		pr_debug("hmm range: start = 0x%lx, end = 0x%lx",
 			hmm_range->start, hmm_range->end);
 
-		/* Assuming 512MB takes maxmium 1 second to fault page address */
-		timeout = max((hmm_range->end - hmm_range->start) >> 29, 1UL);
+		/* Assuming 128MB takes maxmium 1 second to fault page address */
+		timeout = max((hmm_range->end - hmm_range->start) >> 27, 1UL);
 		timeout *= HMM_RANGE_DEFAULT_TIMEOUT;
 		timeout = jiffies + msecs_to_jiffies(timeout);
 
-- 
2.35.1

