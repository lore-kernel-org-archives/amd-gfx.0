Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2714BC433FE
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Nov 2022 16:59:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C144510E50C;
	Wed,  2 Nov 2022 16:59:38 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2086.outbound.protection.outlook.com [40.107.220.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 848F310E1F7
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Nov 2022 16:59:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aBklwQv+a+iR+ZOYdApi27KnNJXQpcu5KqtfzQSsf3AGihIOFen0JKQ10PsMqBPk9V8id1gM9nSCxbozp5rka5FKJR1FDdm8HWCtvGriGmmRXFk0plvmzx12Hndzk1xztQQrLavnL28mjlSORoGDPjbvJap47QbnXIQo4HyONbx6V/WXsNLXzv7FiNdMRy8r+cFom14mIM/WTfhmISdBNFXdnLUMfMElm/cxOb2s5iDdKAXysNvmuJui+nuXU/9hK9IZhhApRBk8QhQhoG5/x5Yw1mVtagmmh2nhntmKuBD3AqzCBn1byd9N294GYM8XK/xgAt2wWMPhh6AeFTXmgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=50LcMarcKZFEN7aX8YZAjf38JJhYlqKBNTn+RdmdIt4=;
 b=U4J//fFO2RmUesRbzyUyF9yBrSY+ecgyq5TYeM3V4SS8IKJUE/7WkrJi3U+IjzN3J9xGPVuyBVjKIIRLZrQA+NcpG57lCvF/TjC9/F0x0e0D4bGIrxIGTawYdg3o1FOsVMiSvqSL6uFfsXAX09bBpG3BD2cqWUNdqaXSmDqqFte8FqCw8i/Ba9Z9thPL6528JPo3DFthSJlHdC1k9N0aVi/4VFibQEUfLpAj9wvZEOki57RgfLEhq42l3XQ5xasyJySiQx75OGsEa8Ju2ZhbNlyhJaodrndXQKIsI9xVEPYChwRe7AVS4eJ7LKG1+joPF9p0r6YUTWowSeK2WRFwDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=50LcMarcKZFEN7aX8YZAjf38JJhYlqKBNTn+RdmdIt4=;
 b=woEVBlS8puvjJPITmiIib2QCDFJG6xDqMpdZor0iAzsRyrIJH9+TVXKf90Ht6nozR9c5qiAe9Zp84P4LhQAHjwFckDNuGbycRpaK6nzmQ6qHDCBvHMnj7HtQRv7DuZj/bL5A4u1ktXTHdoW+bnjsLxTGlFC6xLtetYfGemj4ovI=
Received: from MW4PR03CA0197.namprd03.prod.outlook.com (2603:10b6:303:b8::22)
 by PH8PR12MB6796.namprd12.prod.outlook.com (2603:10b6:510:1c7::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.21; Wed, 2 Nov
 2022 16:59:31 +0000
Received: from CO1NAM11FT049.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b8:cafe::63) by MW4PR03CA0197.outlook.office365.com
 (2603:10b6:303:b8::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.21 via Frontend
 Transport; Wed, 2 Nov 2022 16:59:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT049.mail.protection.outlook.com (10.13.175.50) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5791.20 via Frontend Transport; Wed, 2 Nov 2022 16:59:31 +0000
Received: from aerithdevpyuan.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Wed, 2 Nov
 2022 11:59:28 -0500
From: Perry Yuan <Perry.Yuan@amd.com>
To: <Alexander.Deucher@amd.com>
Subject: [PATCH v2 2/3] drm/amd/display: change GPU match with IP version for
 Vangogh
Date: Thu, 3 Nov 2022 00:59:13 +0800
Message-ID: <20221102165914.1995657-2-Perry.Yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221102165914.1995657-1-Perry.Yuan@amd.com>
References: <20221102165914.1995657-1-Perry.Yuan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT049:EE_|PH8PR12MB6796:EE_
X-MS-Office365-Filtering-Correlation-Id: a667064e-0852-4253-8977-08dabcf39c75
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9hx2LAw9BM0xVWJyu1Iwu6NlpWO9OMTqB6MidkM0Zh9I2UNd1tWI71rrqsNAZQrl0af3iaT8I/h0/OB+GuaS5/5etkEFodIf4KUc/KDRbkAwhmcph4gmRuxQSmv1uLl4zqK2ZVpY0AEc7YOowDrFn5bPJ/0kTKkkJB+bouyEyAjwseFMzC7JrHkv4NmQsFsipWSZbo22E4sucw11k6pLilVc9TkoquvYx5sSk+MOZCWMDzvnHttN8hpfCnR2fvFObNvUH95TNmpMABHHFJLz8WedvHoOVlAMOnWSHgf9/C6FcrtVKnWe3S6oVkzEYqtsYYI9tborOxPDgt0QSQRxkAlk0I7QKQTDdDqjoe1+MNAGjF7eVoxodbNRiXtnbB7XLuycKogvzD+ArD9A6I/Zj4sq966MvwzIX8pNGjNzSDFx8R6BT1fZDQlfaopunqB4BbiLYf8snjrO9i/MBLO5TkgespxzADWUd/WF3VZ5QRwHKz4pk2eT3qtjTxrFLnwC4GgDVk9V196MDe5So9VBCrZsW9/pbO2+vvXd8aIYqXuYPwIqGxDsfnGiZmmI42KJZ6Lvl27Mc1fp0B1Zfs/sz8f8Q49KDVHf5jjzcvzLjHUmz54O0x+pvdK77NUamzwjTwFP6vGT7bJ+f5AwxviuBJoOEXe0hDqD4HyrtgkAhnLCNLBj4wofu62/HK7aBYjfHElUR/WeMUElBJHo5Lz59THactH+SdJoN9szv8+CbYiBl9xnwLobmEfGHdplHWFvofIeGe5df5tAbkqw5nozSq790xf6/WjwzhMXirdRaOjwQdddlzJuDVhX3gucMcJj
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(396003)(376002)(346002)(136003)(451199015)(36840700001)(40470700004)(46966006)(6862004)(2906002)(6636002)(4744005)(8936002)(37006003)(478600001)(70586007)(54906003)(41300700001)(7696005)(40460700003)(6666004)(5660300002)(83380400001)(1076003)(16526019)(186003)(426003)(336012)(47076005)(316002)(2616005)(36860700001)(70206006)(82740400003)(36756003)(82310400005)(356005)(26005)(81166007)(40480700001)(8676002)(86362001)(4326008)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2022 16:59:31.2495 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a667064e-0852-4253-8977-08dabcf39c75
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT049.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6796
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
Cc: richardqi.liang@amd.com, Shimmer.Huang@amd.com,
 amd-gfx@lists.freedesktop.org, kun.liu2@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Use ip versions (10,3,1) to match the GPU after Vangogh switched to use IP
discovery path.

Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 1efe7fa5bc58..90636b88d6bf 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -10202,8 +10202,8 @@ int amdgpu_dm_process_dmub_aux_transfer_sync(bool is_cmd_aux, struct dc_context
  */
 bool check_seamless_boot_capability(struct amdgpu_device *adev)
 {
-	switch (adev->asic_type) {
-	case CHIP_VANGOGH:
+	switch (adev->ip_versions[GC_HWIP][0]) {
+	case IP_VERSION(10, 3, 1):
 		if (!adev->mman.keep_stolen_vga_memory)
 			return true;
 		break;
-- 
2.34.1

