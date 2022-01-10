Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6C5EC433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Jan 2022 20:19:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1AB2F10E4C2;
	Mon, 10 Jan 2022 20:19:46 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2040.outbound.protection.outlook.com [40.107.94.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AE2FD10E3B5
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Jan 2022 20:19:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W7MpmEICpa4UN3yUuCTZOu+MivUxIiRbtygTEPFs/mXJCss3oNvidQiy+SDHiGbKiNXgCijbBzIRxXu/kFGrEaJFXO2E/p3dkRc6/66ySLBDzfmKIKNQPgyLbW1pzCwymPPLeW3lDArQ2zhiYNA5yu4xX2UGcrI5hCOkYTdIw1jMpS3cgzRb7Y/leMLC+DO/I2dUzYVXoGjFAUAeEGHlUcV7z+HrcUiPHOQcmllcwR8wwt2vC1cpYY0SGd4hhufH7PIkAsEbkHfBbh9Eo539K7s3+zmFBxKnFYWNxm9qcyBmpWjEG3I8qYZmAGCKEHj1wqpIXFj5pbuKN9rFQHn25Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zp92aSwprCy1I1Y9+1UWFOQsG6+3wFUPpV+YldNgPYI=;
 b=cRgSFxD/QkQERdKvubrX1cyeWKdZ65J+EKEC7Td5yCXXtVbprLzVOsT5EsOJ5wvr6CcPaTUyWOHliKGqG8NZnbc8U9z5Kp2+gIvTrUMJplNnwul0/MDXXql1rwKNvXsU5sDpDc7g37aJoMHM/Flz2hANc7rjmXmeypES7heIM+Nqzzd7e/ghphBiu3JfAV4sC6NTg3WueNbWovLUkWicJ3UOqUPhJ0J4ri8Q9RTR90e+I/ls/gxc2E+2w05ao1d1mjDZS3F5l+wMlaqp4St5qreJwlV/JpsGfVDQNt25cPpm3LJJA9qCC/1SdUE+QpAtiD0RO/NNe15p4EMPbxTrNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zp92aSwprCy1I1Y9+1UWFOQsG6+3wFUPpV+YldNgPYI=;
 b=Vm/gme2qSFWoQdotmjkwd9dH3E3MkENSxxmkexGFXxVflJnHfpd8FmeyPYUXJh9x0pB58dgwWEgiwj8XATxPRlduWCFTJpHuIguKegoxM65pVzSMwLLLEN4iFuUBgSK4Wu026vOPmJ+jWvnpCBVWQkBURIqqO1SixWNwvku8Mco=
Received: from MW2PR16CA0033.namprd16.prod.outlook.com (2603:10b6:907::46) by
 BY5PR12MB3652.namprd12.prod.outlook.com (2603:10b6:a03:1a7::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.7; Mon, 10 Jan
 2022 20:19:42 +0000
Received: from CO1NAM11FT063.eop-nam11.prod.protection.outlook.com
 (2603:10b6:907:0:cafe::15) by MW2PR16CA0033.outlook.office365.com
 (2603:10b6:907::46) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.7 via Frontend
 Transport; Mon, 10 Jan 2022 20:19:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT063.mail.protection.outlook.com (10.13.175.37) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4867.7 via Frontend Transport; Mon, 10 Jan 2022 20:19:42 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Mon, 10 Jan
 2022 14:19:40 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/3] drm/amdgpu: fix warning
Date: Mon, 10 Jan 2022 15:19:27 -0500
Message-ID: <20220110201929.1949571-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 77e2ee74-ab0c-4195-aaec-08d9d476892d
X-MS-TrafficTypeDiagnostic: BY5PR12MB3652:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB3652FA95999548E67AC55CD0F7509@BY5PR12MB3652.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:758;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xCXjD7aFwBTRipAhLOjTOilWT0v8pKBlVMkpA/PNEvhuZqSEyLIFB6YdjyvlNJolWJZVY2tBWU4+MBCllhJ0FQTLbPr9qW4ZjQxbiNJwOhh4ip8EGJ6HmSDoaQa6hR6VpXh0trTJiGTYOzTNHHOeFuz/MNweMiTocGRt/uQsq2YonBjVhfzT3wzQKoKbdXI5GIpudg3BXu/ckG9X/mfgrwxcLtJAEXihTA8d5/Rh+/i/qB0j6tYzWXJO9mLaDdE4281x5ak2CsZ7upl0bJpp1p5b3ID8FVbBZr7wCGV7d+FKKjBpnVmBnZpJJGXyGatCnKysCnwJ0n+Zu9wRGHJRGlqpw2QvM8zbEczvk1Hog21+PERGD0lfVX7FIE96etgq2Wu4CbxC5Uj+ajxrEC4lPaQiKF3+nqKXSkeFUXHeuBR+QdPA6h7NJcLYnt/Syygzu6i3uXgIaPcsnrv2ddZ67N5IwOREJEaRfi4p0pSzhgp7xj358seEEczEnvfNGgDFLbYalHutb86YZ5L2u5X89TKBut5Va2EoSgeb5TL+V+VK5faIG3/BNiE5Q0rJ6Oiddssm9MSxm8GeUc0JY4qxl1wZRmbs7I5rQrTJv4S0g/myRYxrVk7qWOrFuBFVeND5CLd8fr6WOzpyXlDutw+WaQuWvRGGPChgrdkYWYfqfpP6i6H2/q8r5KLPTE6IxBBCxJJUGNokA24sUA6HnWUmBWJg5QUiWmQFo3ZtB33qE7SAAfaYNmqwiEzlr8od2/FoYgTD/LnR4F5lk/WJI30NqR/r4tetMXTSYWUeDF/ctA8=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(40470700002)(46966006)(36840700001)(36860700001)(5660300002)(6916009)(6666004)(336012)(2906002)(70206006)(186003)(8936002)(356005)(316002)(70586007)(81166007)(40460700001)(47076005)(54906003)(4744005)(82310400004)(26005)(1076003)(508600001)(7696005)(4326008)(2616005)(36756003)(83380400001)(426003)(86362001)(16526019)(8676002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2022 20:19:42.0774 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 77e2ee74-ab0c-4195-aaec-08d9d476892d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT063.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3652
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
Cc: Alex Deucher <alexander.deucher@amd.com>, yipechai <YiPeng.Chai@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

warning: ISO C90 forbids mixed declarations and code [-Wdeclaration-after-statement]

Fixes: 8c50db2f64ee ("drm/amdgpu: Adjust error inject function code style in amdgpu_ras.c")
Cc: yipechai <YiPeng.Chai@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
index aa8d614009d4..478457637d29 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
@@ -949,7 +949,7 @@ static void amdgpu_xgmi_query_ras_error_count(struct amdgpu_device *adev,
 /* Trigger XGMI/WAFL error */
 static int amdgpu_ras_error_inject_xgmi(struct amdgpu_device *adev,  void *inject_if)
 {
-	int ret = 0;;
+	int ret = 0;
 	struct ta_ras_trigger_error_input *block_info =  (struct ta_ras_trigger_error_input *)inject_if;
 
 	if (amdgpu_dpm_set_df_cstate(adev, DF_CSTATE_DISALLOW))
-- 
2.33.1

