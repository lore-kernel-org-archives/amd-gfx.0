Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D865CC6B0E
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Oct 2026 08:25:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6A57C10E751;
	Tue, 13 Oct 2026 08:25:26 +0000 (UTC)
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013027.outbound.protection.outlook.com
 [40.93.196.27])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 99E6310E751
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Oct 2026 08:25:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NNhvebr7Lu9PJGTfRtPrMqNo8znqWekwAwAbSeqDPfjXfj+DxWDzEx2BXhpxDvKTe0/rgyJ1T8ul/Odrxis3vBmEtiT1zRcYLARQVwB4xa/Txy7GbiG0zHfF4l5q48sW2DsUavKqKhkgGik/5Vtez2WbafhMz/DUYMQiUeLlET0gMDRcVOqf3Tvy0lYv7r+EN+33gppDWUZFdM/lY/LbOfLGNd0sYh6l0YAQ1r3xnAFI9oEblzepstRkZaS6wJfzUsJ8bWNmZKfhEIV0I8SFZwOJQIcA4vWQdl8ymGyItQyBZqXAUJGrp0CfrPsSFTNt9VytdjPLTG3McEFEwGWDGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GMQqcNMzRSiY7dK0iYcXqE86pUuyofyL196Ad63BIPg=;
 b=qYl9clxN3r4xtzH2QGazDwC+IQsh0jiY0RkGWRa0BFOgX/hnUgvLyulI+TXThUOJylFcLfhn0Y4KHZ6/3mLYL2J5HVvi81wnnydzANprt+Mr1T7Ydb6q0vYKm/NjF2sDU8cM1tejDPfQwSiQ79uoVZKlztYsYTW75vCxJIei7Y9i+yP8vKWirO67qsqiDQ65Oi3ZoqOFKRhacJOeZ9sZhYn+DiIjZ+3AVY2WebP0MMN3jZ74MwxzSj7H26hxxSLiLLdknnR7s6k7X5tM1zZC9LgcTdpj7is2lhmQrY41vLERoiElRlZW+Lp6xNWaJNqwgf82bWnCcUigehqfEn6Lqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GMQqcNMzRSiY7dK0iYcXqE86pUuyofyL196Ad63BIPg=;
 b=Eh0kEQxUP8c02M06fPgdAC0UcDct9sczbdv0+ZLpAVRdeMpI64kmjHDtD5jFkTxl7YnC2lVKkK6WP7L7sm8asUF+IJ/Ho4qZVj/q3zJtRfN6D1sHRWvvV25SDMc4Pievw4b7qEHjMKYMA7WfARJ/7TJsKXyWWAyqr9zkKaNyn68=
Received: from DS7PR03CA0212.namprd03.prod.outlook.com (2603:10b6:5:3ba::7) by
 CY8PR12MB7265.namprd12.prod.outlook.com (2603:10b6:930:57::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.23; Tue, 13 Oct 2026 08:25:14 +0000
Received: from DS1PEPF00053450.namprd04.prod.outlook.com
 (2603:10b6:5:3ba:cafe::6d) by DS7PR03CA0212.outlook.office365.com
 (2603:10b6:5:3ba::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Tue, 13
 Oct 2026 08:25:14 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS1PEPF00053450.mail.protection.outlook.com (10.167.23.232) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Tue, 13 Oct 2026 08:25:14 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 13 Oct
 2026 03:25:04 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>,
 <Lijo.Lazar@amd.com>, <Vitaly.Prosyak@amd.com>, Prike Liang
 <Prike.Liang@amd.com>
Subject: [PATCH 2/9] drm/amdgpu: skip VKMS mode-config helpers during GPU reset
Date: Tue, 13 Oct 2026 16:24:50 +0800
Message-ID: <20261013082457.2492273-2-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261013082457.2492273-1-Prike.Liang@amd.com>
References: <20261013082457.2492273-1-Prike.Liang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00053450:EE_|CY8PR12MB7265:EE_
X-MS-Office365-Filtering-Correlation-Id: 14e2361b-7f11-4c63-a061-08df29038154
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|36860700016|82310400026|56012099006|11063799006|261009223027099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: AGhXKeUzQDz/vORDmz52hPGLzfhEm/Wd5opDLGAq9wGe1LrukPgrXzpjHJi0URPT37ocagim5DIvfgYfAGtvfmaqI59Hj45x3gZep4ekL+KFYudKNYoaeKNRdGaiy13XSMOvzlE7BbBP6oPEr7wrvsirg7E+p4KJldK7Fcipf/aXv45udoCGAPcV/THl73tWqKVzFaCMiCnKAYQ9sxzSHhPC1nw8+s80r1K7BxCs0zcRq67e6BdZh11VvACODOlEFyrg2xfRLn3gOAjodvWBd0+3IaFwBizzmH4qUtrd7vojXaphp2XoVFl8/0v+KuxjdAhGtfWFNl7EignhYsoYHoOKW94RA0TCV6ag3MQShlGLGjk4YWCeoKg+bDu3lKATjPqBnY4oSSehEqFpHrs+0w3lXy3+/umwgTVCNMmvZA4YxEaDV0PRG/g5YbH+AUUt6+F3Ip89+QkLvAGcEDGWs+o9u4D3F0QUU0eY8ERPUKDPZZrFLQPGyODbe6ppEePr1bJdtuijw6flVkbP8xp/XRvl4v9PmHhEYyjINTSgUDlPiIcmQXeKOTs+BaW93IEnBWEUria109mUHd0H4Sdv8/9/Ufp76qXCKEOOl1wT/EqH6uJJ/dOcCrejXHI7TW7g+/fImCLzSHWIj9hpDntyma8deGYok5bM9lj3w/pExHMxdUQtmeKRo8WsKR1jioPmTYDnBVGxIjSnTFfVYTMu6g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(36860700016)(82310400026)(56012099006)(11063799006)(261009223027099003)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: YDi9FwgiAAo5vQPuqX3XSIROBgvGtPjmqbMjbuJVdlf37Nws0sgtyvWmSntWcEmK1fxVhZLjLlQHxoA9Dp1FVU5rci4rcGzXEGf/8hLR/A2/PR6gXmHwT16Q9ytQRjlYPunVz9hO8tO8cWVa+rYtz+V0aslPlH0HOv171gfqvZRA/BSuCaxWODboKjqsBy8w2I6GBc8zS1xU2q8DqbyJc0r9qOZBHI9gpcWpelguVCmaUCEXXOjpwWkKaMuGK1YSxKwWiJQBQdF23F/RCbYluEWPbzP/nwK7eqdmI3AzKPL5f9kZ//ucCyaYV0oI1IuM0xVvAIRrRgYCFRZ7frKCOAny8qKVey2ls04ALWZbaULA4RCl3Tu9PmQbRxtJMv39hybTaoTg6Nab5Z3298QE3CwUxjHuoa56w7QqyyX4f/uhBHtVro2l2PlGjeOR9Xoh
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2026 08:25:14.0531 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 14e2361b-7f11-4c63-a061-08df29038154
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00053450.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7265
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

GPU recovery already notifies DRM clients. Skip the VKMS mode-config
suspend/resume helpers during that internal reset to avoid duplicate
client notification and atomic-state handling under the reset lock.
Keep ordinary system suspend and resume unchanged.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
index d6b51b3f216b..a49c7dda4c4e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
@@ -491,6 +491,9 @@ static int amdgpu_vkms_suspend(struct amdgpu_ip_block *ip_block)
 	struct amdgpu_device *adev = ip_block->adev;
 	int r;
 
+	if (amdgpu_in_reset(adev))
+		return 0;
+
 	r = drm_mode_config_helper_suspend(adev_to_drm(adev));
 	if (r)
 		return r;
@@ -505,6 +508,9 @@ static int amdgpu_vkms_resume(struct amdgpu_ip_block *ip_block)
 	r = amdgpu_vkms_hw_init(ip_block);
 	if (r)
 		return r;
+	if (amdgpu_in_reset(ip_block->adev))
+		return 0;
+
 	return drm_mode_config_helper_resume(adev_to_drm(ip_block->adev));
 }
 
-- 
2.34.1

