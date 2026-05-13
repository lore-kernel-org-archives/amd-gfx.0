Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAB47CD4F3E
	for <amd-gfx@archiver.kernel.org>; Wed, 13 May 2026 14:34:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3FC0F10EEE2;
	Wed, 13 May 2026 14:34:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mE4ub+6Q";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012006.outbound.protection.outlook.com
 [40.93.195.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 15F1610EEEC
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 May 2026 14:33:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rr7c/tD/A8YdMPcf2MkpvQWpfISenD4jKQm+p4nxDZld98z0XQTqpAQb94sYlqIZjr6RnPOoZDZhBJdvhlU+WdAFcpLNJX9tCW/G2VWwbzywmsU5M71cjtF0n2ALo22QCbyEeOXH2gjp3sHgsShlrdGcJb1N7dG/KyO5zTDf+R5H6XSeoj/KkbEt98sfZ+67RCl25cAYdk+sMtWFDfWDO7fyqWa+AVuka5RSQxfDXd5nFzbgy6x0HsbVQfEGp0AzVzZHJsuHt3vIOYh2GUSFgALIWo31WvdZk9geqQ7vPj56QGj02RmZKEEZ8R4vbYsWC0C4iPMe0kMcDgslLIYWAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J24UCdCVyh/Z0Gpp1biExQL5Zyde6aFhv3+WfWc8Tb0=;
 b=QLz4SzExd/4m+wUqsStzHFGni83vj7WNBs3ftZ6ggeLY5DOueWu/QsIJJ9QLdKakWjUX992W3VCpj9mAEUMTWmVgmFDXHvaZTJwy0M1QA50D/QnefbE1g96fAedVm/3b6/Y5yKzjY2COjJCw8i1pvr2oL57T+zbhboo8UPVa+IkFbdlL/Nk2rA8rmahHrq58KA8VZRmSyOxdsCm38AMP0d9Gk1a+ZxbOyJZNyO1nswrpVTL6foEMuHLuUCMpc064mqg4zQGuhzZDF2JivL+p3iXKjAHZUB/QnQKkvlxN5MqI/s6dfB7NPJrCqxEAHP4uXcrSVF7Nj+KwU89+n+B1kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J24UCdCVyh/Z0Gpp1biExQL5Zyde6aFhv3+WfWc8Tb0=;
 b=mE4ub+6QthQg6ac4pH7KKAY0W6Ezw1vwlFDf4OAxf9uapm6EOSDOxMKXqPVXfrNSlkqwApdzF+vqVFUYhJ1YNCpQl06TerlHsB4wX8gvtGElW8Lv0IGeCDeWko4onCbKDMbsyUdxyENp2mUN4ijcmNo0LvjIfjTXR5rTKXMXhGg=
Received: from MW4P220CA0011.NAMP220.PROD.OUTLOOK.COM (2603:10b6:303:115::16)
 by BY5PR12MB4308.namprd12.prod.outlook.com (2603:10b6:a03:20a::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Wed, 13 May
 2026 14:33:52 +0000
Received: from MWH0EPF000C6191.namprd02.prod.outlook.com
 (2603:10b6:303:115:cafe::f0) by MW4P220CA0011.outlook.office365.com
 (2603:10b6:303:115::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.23 via Frontend Transport; Wed,
 13 May 2026 14:33:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000C6191.mail.protection.outlook.com (10.167.249.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Wed, 13 May 2026 14:33:51 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.41; Wed, 13 May
 2026 09:33:43 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 13 May
 2026 09:33:43 -0500
Received: from box-0.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 13 May 2026 09:33:42 -0500
From: <IVAN.LIPSKI@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Taimur Hassan <Syed.Hassan@amd.com>
Subject: [PATCH 28/28] drm/amd/display: Promote DC to 3.2.383
Date: Wed, 13 May 2026 10:29:50 -0400
Message-ID: <20260513143213.1852892-30-IVAN.LIPSKI@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260513143213.1852892-2-IVAN.LIPSKI@amd.com>
References: <20260513143213.1852892-2-IVAN.LIPSKI@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: IVAN.LIPSKI@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000C6191:EE_|BY5PR12MB4308:EE_
X-MS-Office365-Filtering-Correlation-Id: 55b0859f-c176-48e1-f040-08deb0fca768
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700016|18002099003|22082099003|56012099003|3023799003|11063799003;
X-Microsoft-Antispam-Message-Info: T+53fGGiPu5yj96IIwbN3EhdgRIKqMVG5+f+Ui5YplMhNkr/HA8e3zjo40ONpR4EldNUDflHHGwzsV+E7nhQ8aC13sl2lOr5VMxHe9BvyJg7+Q1vc+AuY1/XtgtIP7byZEQTMgtYgmoY48csKTvQN1CYXtZg+B+ewUBZppCLULODlQjjzkb0JfvtZPWel4a4sVvVFWKcES93cqOluGpHLkBh76Gl2BwNNgyYQalp0A2UJ+5vl47c0CRoSjhdN8R6ojp6Zo+hJDvpuBehH30vkm8FUBmGVY7WJw0scq8YsPQ9zBy09qgP3OA3g3eGhbYlxxSVq6+xn0lFOhYMo+Y/U1xB49ZzJgihY2px/78S/05aRho9T76WdhOL+DQMFvR1AmUxYWDyoZznfDvkCv+HQAMz/YYEXDnRsOgT0VxCmgEibsdBLUSy81QKXe5EzqTz8meuLgwNs5BKOyLBYayJPPI/QvvgVBvIv1E8GGCK0jIg8sp6d6K+rP0FSgL+jy+fyEJ6wxqY8ch9wyT0HvdQ4o9XjYMB656lAEinIKZXfKmpelCsW7Zd+A7Mcp099CcAu6fpzUr1AyQxRKf9TWt8O0S7hQGlAoW7eMpJyRODVu3LBK2Mu/h0zNcrAcfT7GY2apdmGl0Cz3QdfSIHXiFISh8Y0TvtXEsIWsdWbuAg3DaNDtUsDZU2EQxIy5Hrto6oRUB3I7pWrXGvUEBxoeKfPhIf0MxwDkozadWwhk+jeZU=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700016)(18002099003)(22082099003)(56012099003)(3023799003)(11063799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: aZoevFD2MZNX0rayzbIXF1uc+76Bs2Jh/pfK11sNb6Fdnoo8FO7b4IiVgWx2Nga28ZM144pW6lV1+A/iuIPxHYqbYPrMfYN7f5Raz3rNuiHHOLl+bvSpg3ZgLTdv4+ZqALtlZD8Q21OhcYpL30F8nql+FNzROrk/bbT0P2h4T1AtngYW3TwEZg+rB4DQzWKdLZ+Kni6HoFDnl4gfUaU85BnPL0td6GLUqf84Di91hOheiW2ho3AmRVKbfzen0O8asXzqMD9pQdSHgROfLLG2J0vfucdEAKrBz2TGJzfma3cCQwW/RCkgpO1oeHUZBfqay4IF85h4o3UNlorKhsSU0m3JYHHesQ1l3NhJEbEo1kGoPgzJn5YRX3Q1jNkQV5s2ZjV48vmh8ul5no43KKn+JktDqWpXkk9etgmSFq2tfMutoKmG39OEgje1BNCKSs2m
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 14:33:51.8799 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 55b0859f-c176-48e1-f040-08deb0fca768
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000C6191.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4308
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

From: Taimur Hassan <Syed.Hassan@amd.com>

This version brings along the following updates:

 - Add amdgpu_dm KUnit test for:
   * CRC function
   * HDCP process_output
   * colorop TF bitmasks
   * color helpers
   * PSR and Replay functions
   * ISM functions
 - Fix eDP receiver ready status check in T7 sequence
 - Enable dcn42 pstate pmo
 - Refactor PSR. Replay and ABM functionality into dedicated power modules
 - Fix assertion due to disable/enable CM blocks
 - Enable additional wait for pipe pending checks
 - Fix ISM dc_lock deadlock during suspend
 - Use lockdep_assert_held() for dc_lock check
 - Fix clear PSR config flow
 - Exclude the MST overhead from BW deallocation
 - Allow power up even w/ powergating disabled on DCN42
 - Fix integer overflow in bios_get_image()
 - Validate GPIO pin LUT table size before iterating
 - Add Auxless-ALPM support in VESA Panel Replay
 - Add debug option for replay ESD recovery.
 - Validate payload length and link_index in dc_process_dmub_aux_transfer_async.
 - Add ADDR3 swizzle modes.

Reviewed-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Taimur Hassan <Syed.Hassan@amd.com>
Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index a356cf4faa1d..75f59ca927ff 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -63,7 +63,7 @@ struct dcn_dsc_reg_state;
 struct dcn_optc_reg_state;
 struct dcn_dccg_reg_state;
 
-#define DC_VER "3.2.382"
+#define DC_VER "3.2.383"
 
 /**
  * MAX_SURFACES - representative of the upper bound of surfaces that can be piped to a single CRTC
-- 
2.43.0

