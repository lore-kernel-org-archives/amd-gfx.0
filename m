Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7EA2C10F1A
	for <amd-gfx@archiver.kernel.org>; Wed,  1 May 2024 07:19:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1FB461130C0;
	Wed,  1 May 2024 07:19:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5J2AaMr1";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2070.outbound.protection.outlook.com [40.107.243.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DFA521130C0
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 May 2024 07:19:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OFJ+Aam7Hlca1jApvAghqMoh5Z/u3GQDIcO6pOy7LxUVhydYsvL6+EbXUc0wPO29Gdrhuz7Ixquj1DRQOKM7wB8Xho0xYVlPpCSCSxnTmLgf3gWQKst8d6cMb0OK/ULMEGTm8kUhZwgo37FkmjARoe3xdbtYl1EdRSAPcjKedjWR239T8gELhRhMvupvRCnE3Rmi7nUlQauhyfmGPXuFkxtKMPIPpmTdBBzxMHeaHbbie19a30hd5llbeUStdZBK+FYqowaj9RTYHjCAm4jotadeLyepxtx91SsNHHIAP3EL2IQKJNjQnNsB+MEtRyPWm/VUaMQVzKSXtlzfHMxvAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=es8kSa3s9gphR5FbriNlERcyAOXlsVJNJZ1cKDaWL68=;
 b=odEqdoO29FIs7OWEKuveh5ZIlUA1YS8g0A4VKoy3gE58C4Kw870ZQIL24Lww6uwwdB6TPMURecNdlhvaV2Im7epFCBSO3XRZkC6re33FwDlrySsHJJ4Jez9QrVo/qz5J6Dkw+X6oKrBMBupveD3lPCFTVwgGkdd3348j5qqB4npYhwzs0ntWUkCmMdfjZQKGES4v30vLHNXAtc3kZ0M+t4n5JFkezqJD+HrGsG+ycP/GY2RsvtFqq7Ti3ba/BX6xAhcwMdvri3YHROyNb1dhfcr8BPirrFXH0szaP8FBO5zeGe4PmojpsQn2ENuly8SCrOAt2SNB42H2dtSCbJ4NNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=es8kSa3s9gphR5FbriNlERcyAOXlsVJNJZ1cKDaWL68=;
 b=5J2AaMr1+Tu67nCJpVsbJwN6ujv0fU+nzJtzSx17zjt67sQsE99AswDdtCpsqdvMSEA9Lpbx/yYgJu2mZJS+AlkEX6FrOEMvnNz6Mc/E3FshWgvgn/eNmd6HQfWwl6cbx61vfMwCkFtHdNSdhOp6GCP1wwn+3eRKbYCYAI+MaSQ=
Received: from CH2PR07CA0021.namprd07.prod.outlook.com (2603:10b6:610:20::34)
 by PH7PR12MB9203.namprd12.prod.outlook.com (2603:10b6:510:2f2::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Wed, 1 May
 2024 07:18:59 +0000
Received: from CH1PEPF0000AD7D.namprd04.prod.outlook.com
 (2603:10b6:610:20:cafe::4c) by CH2PR07CA0021.outlook.office365.com
 (2603:10b6:610:20::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.24 via Frontend
 Transport; Wed, 1 May 2024 07:18:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD7D.mail.protection.outlook.com (10.167.244.86) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Wed, 1 May 2024 07:18:59 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 1 May
 2024 02:18:58 -0500
Received: from tom-r5.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Wed, 1 May 2024 02:18:55 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>, Bhuvana Chandra Pinninti
 <bhuvanachandra.pinninti@amd.com>, Martin Leung <martin.leung@amd.com>
Subject: [PATCH 21/45] drm/amd/display: Refactor HUBP into component folder.
Date: Wed, 1 May 2024 15:16:27 +0800
Message-ID: <20240501071651.3541919-22-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240501071651.3541919-1-chiahsuan.chung@amd.com>
References: <20240501071651.3541919-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Received-SPF: None (SATLEXMB04.amd.com: chiahsuan.chung@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7D:EE_|PH7PR12MB9203:EE_
X-MS-Office365-Filtering-Correlation-Id: ec9ef3bc-2613-4f6b-8e28-08dc69aef85d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|376005|1800799015|82310400014|36860700004; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NTRNTWQ3V29tK2FhNlNzUDJRTXEzVXFqV0dkb0lWRzhRbk9KaFBHVkZ4UERp?=
 =?utf-8?B?K1huaVhQMWlZYnBUS3NGS0lFMDlxQnMrVVlWUE9ESXJJS1ZjMWZSZ3M1ZVhh?=
 =?utf-8?B?TlZPakZTUzBxeFdJK3ZPWlRFWklwQ1NiNHNnRHUzeDExdVg5UEF1L2pEQUln?=
 =?utf-8?B?MjU5ajJGaGQ4RlpFM2hPWGpBdHdUOENLT1VqTTd1YllzVlBZcXZlVjRWS2cz?=
 =?utf-8?B?OHg3emdiLzFuZmlXTkVpTkNRd0FBalVjVStpc0h4ZkQ4eWpBN2Nra1A4c2Y0?=
 =?utf-8?B?TWtzdkJpSWRoZkhENFdpalpLTUQrNWpjVlhpUi9yVXlvWDNtM1gvNTk1RDUv?=
 =?utf-8?B?U25QLzVOK01iVVdVTzRBaks5VWMraE1tM2F2cXdjQUVlZ2ZCNGNzV1R0Wjls?=
 =?utf-8?B?dXV2ejZFb3hSL1RZNkVMWWJZZmx6TWRYWm5UcnBORHBQSXlqd25LeXFOajJL?=
 =?utf-8?B?YlhWbE5nVlhId0NHYkcvbmkva1k0R1dqMFk3V0NBdTdHdDB0ckV6bUVjZk5D?=
 =?utf-8?B?YkY5TktjdWZMSzB2LzVRQjhaSk8zemNETGtGb3VZOUZKQWd5N1B6K1Fib3d3?=
 =?utf-8?B?NU1wNnVMdDhBNk5rVVphbzZ1c3R0eHc4LzJkcnhEVmduYXJKdGdacEprWHNs?=
 =?utf-8?B?NEYzcFF4dmZZRkJsQ2VCWVQzYXBNK3pkS0lNWW1qS25sc3N2cmdMNmxhU2dn?=
 =?utf-8?B?NTVKalJSVmJpUGVTRWVqcFZ1TEEyNWw3Q1RhemZGQ095dnhqQWczVEpYMks2?=
 =?utf-8?B?alNaYisvcklPRjNMQ0pLdjc3RTQ4R21xdmJFUU9ITkdmNUNVd3hlajBJZUU4?=
 =?utf-8?B?U3pEZXVBRlRBMG1WNHJqVmJyZXBWZzIvcXRYRUhFeFpCWk94NzQvSFlDcmVP?=
 =?utf-8?B?amtyQmdCaFd5VmlVSjhreHpUYVhUNkE2eUVmSURTZW5iYTl1UG5MRkRKZGkv?=
 =?utf-8?B?OGtHRTFwVzBzUlkvSHNvL2ZhWEs2TC92d2ZyKzY3SVk2cytCcEhVdDVKd2Nv?=
 =?utf-8?B?ZGU3YWxiQmdoNHRrNWhrZm9YOEl0V21Na2FHTWlpTXZEQ1RiTm13ZElHTGJF?=
 =?utf-8?B?b2w4Z29tZjdFNEZHeE5PYmxIaG52clppenBMSGM1Rkl2d2N3SDVBMVlzMy9l?=
 =?utf-8?B?eDVMclJxcmtNMTE4OUxVQmRESWJCMXlkOEdnZHZnWmM1dmpBaThZK0ZzdGgz?=
 =?utf-8?B?L2JRL2pET0MzUlRBVDRzYjR3MXlNSVhQWUlyVWd0dmY3aDgwaE1BTC8vclhL?=
 =?utf-8?B?YWZsdjVIRVM5N01RU1lFanAzek9rVmViaER6Q1dwb3B2MVk4MHprOFBHVEwz?=
 =?utf-8?B?bkhpV1lWT0V3SzBWV0VucWFFZEJjL0dBalQxWjdBN0Job09qbFl6RDdyR2NF?=
 =?utf-8?B?NFVHOUt1OHlncmZpTnI3M1FEcFFXUVhoWFFoYjR3dTl4MVlueWlJb0tBMVZV?=
 =?utf-8?B?bHA1N3V4MGlBUHpQSHdhQTZuT3k0a2RIaWN5TDVCL0YzeXF5YVhRY1ExRFM3?=
 =?utf-8?B?aHN6UVI1ZG95V3dqam9acVdFZDdnTFoxMTFRckJ3a2Zydnh6TnFRRnpZcmF2?=
 =?utf-8?B?VzMyOTM2QjJ3UFJmV0hrd2FDSjVVNzVkNUJ1cEZYbTNDSlZzaWJyU3I0ZW9j?=
 =?utf-8?B?aE0rQndwZktmT0JMeHA0QVd5S0RxaTZNYldYUHBCT3NzVENQVU9tL09LUUJM?=
 =?utf-8?B?dmtOWVEyeFhzQVc1MU1jZXdkb3JQQXA0SnJLRWNMaVJ6UkVSZTcxQ2xUalRH?=
 =?utf-8?B?V2tqZEtSeEFJdnRlZHJmaDVqN0Z2bHpHOEsvSm5oR1lyVHFMdkNWdHRhQm53?=
 =?utf-8?B?LzJmcmpMQnB0TU5TREhvQ0RnYXIzYjB0ODJDeEIzYWlES1hTdmdhNUtBbTJW?=
 =?utf-8?Q?dOq/H89o0rm2Y?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(82310400014)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2024 07:18:59.1249 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ec9ef3bc-2613-4f6b-8e28-08dc69aef85d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD7D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9203
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

From: Bhuvana Chandra Pinninti <bhuvanachandra.pinninti@amd.com>

[why]
cleaning up the code refactor requires hubp to be in its own component.

[how]
move all files under newly created hubp folder and fixing the makefiles.

Reviewed-by: Martin Leung <martin.leung@amd.com>
Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Bhuvana Chandra Pinninti <bhuvanachandra.pinninti@amd.com>
---
 drivers/gpu/drm/amd/display/Makefile          |  1 +
 drivers/gpu/drm/amd/display/dc/Makefile       |  2 +-
 drivers/gpu/drm/amd/display/dc/dcn10/Makefile |  2 +-
 .../dc/dcn10/dcn10_hw_sequencer_debug.c       |  2 +-
 drivers/gpu/drm/amd/display/dc/dcn20/Makefile |  3 +-
 .../gpu/drm/amd/display/dc/dcn201/Makefile    |  2 +-
 drivers/gpu/drm/amd/display/dc/dcn21/Makefile |  3 +-
 drivers/gpu/drm/amd/display/dc/dcn30/Makefile |  3 +-
 drivers/gpu/drm/amd/display/dc/dcn31/Makefile |  3 +-
 drivers/gpu/drm/amd/display/dc/dcn32/Makefile |  2 +-
 drivers/gpu/drm/amd/display/dc/dcn35/Makefile |  1 -
 drivers/gpu/drm/amd/display/dc/hubp/Makefile  | 92 +++++++++++++++++++
 .../display/dc/{ => hubp}/dcn10/dcn10_hubp.c  |  0
 .../display/dc/{ => hubp}/dcn10/dcn10_hubp.h  |  0
 .../display/dc/{ => hubp}/dcn20/dcn20_hubp.c  |  0
 .../display/dc/{ => hubp}/dcn20/dcn20_hubp.h  |  0
 .../dc/{ => hubp}/dcn201/dcn201_hubp.c        |  0
 .../dc/{ => hubp}/dcn201/dcn201_hubp.h        |  0
 .../display/dc/{ => hubp}/dcn21/dcn21_hubp.c  |  0
 .../display/dc/{ => hubp}/dcn21/dcn21_hubp.h  |  0
 .../display/dc/{ => hubp}/dcn30/dcn30_hubp.c  |  0
 .../display/dc/{ => hubp}/dcn30/dcn30_hubp.h  |  0
 .../display/dc/{ => hubp}/dcn31/dcn31_hubp.c  |  0
 .../display/dc/{ => hubp}/dcn31/dcn31_hubp.h  |  0
 .../display/dc/{ => hubp}/dcn32/dcn32_hubp.c  |  0
 .../display/dc/{ => hubp}/dcn32/dcn32_hubp.h  |  0
 .../display/dc/{ => hubp}/dcn35/dcn35_hubp.c  |  0
 .../display/dc/{ => hubp}/dcn35/dcn35_hubp.h  |  0
 28 files changed, 102 insertions(+), 14 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/display/dc/hubp/Makefile
 rename drivers/gpu/drm/amd/display/dc/{ => hubp}/dcn10/dcn10_hubp.c (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => hubp}/dcn10/dcn10_hubp.h (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => hubp}/dcn20/dcn20_hubp.c (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => hubp}/dcn20/dcn20_hubp.h (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => hubp}/dcn201/dcn201_hubp.c (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => hubp}/dcn201/dcn201_hubp.h (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => hubp}/dcn21/dcn21_hubp.c (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => hubp}/dcn21/dcn21_hubp.h (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => hubp}/dcn30/dcn30_hubp.c (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => hubp}/dcn30/dcn30_hubp.h (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => hubp}/dcn31/dcn31_hubp.c (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => hubp}/dcn31/dcn31_hubp.h (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => hubp}/dcn32/dcn32_hubp.c (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => hubp}/dcn32/dcn32_hubp.h (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => hubp}/dcn35/dcn35_hubp.c (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => hubp}/dcn35/dcn35_hubp.h (100%)

diff --git a/drivers/gpu/drm/amd/display/Makefile b/drivers/gpu/drm/amd/display/Makefile
index 641073fd7e33..8297fbce7749 100644
--- a/drivers/gpu/drm/amd/display/Makefile
+++ b/drivers/gpu/drm/amd/display/Makefile
@@ -36,6 +36,7 @@ subdir-ccflags-y += -I$(FULL_AMD_DISPLAY_PATH)/dc/optc
 subdir-ccflags-y += -I$(FULL_AMD_DISPLAY_PATH)/dc/dpp
 subdir-ccflags-y += -I$(FULL_AMD_DISPLAY_PATH)/dc/hubbub
 subdir-ccflags-y += -I$(FULL_AMD_DISPLAY_PATH)/dc/dccg
+subdir-ccflags-y += -I$(FULL_AMD_DISPLAY_PATH)/dc/hubp
 subdir-ccflags-y += -I$(FULL_AMD_DISPLAY_PATH)/modules/inc
 subdir-ccflags-y += -I$(FULL_AMD_DISPLAY_PATH)/modules/freesync
 subdir-ccflags-y += -I$(FULL_AMD_DISPLAY_PATH)/modules/color
diff --git a/drivers/gpu/drm/amd/display/dc/Makefile b/drivers/gpu/drm/amd/display/dc/Makefile
index e0c67f4b9063..9c2f932217e4 100644
--- a/drivers/gpu/drm/amd/display/dc/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/Makefile
@@ -22,7 +22,7 @@
 #
 # Makefile for Display Core (dc) component.
 
-DC_LIBS = basics bios dml clk_mgr dce gpio hwss irq link virtual dsc resource optc dpp hubbub dccg
+DC_LIBS = basics bios dml clk_mgr dce gpio hwss irq link virtual dsc resource optc dpp hubbub dccg hubp
 
 ifdef CONFIG_DRM_AMD_DC_FP
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/Makefile b/drivers/gpu/drm/amd/display/dc/dcn10/Makefile
index 508306baa65a..68484264831b 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/Makefile
@@ -25,7 +25,7 @@
 DCN10 = dcn10_ipp.o \
 		dcn10_hw_sequencer_debug.o \
 		dcn10_opp.o \
-		dcn10_hubp.o dcn10_mpc.o \
+		dcn10_mpc.o \
 		dcn10_cm_common.o \
 		dcn10_stream_encoder.o dcn10_link_encoder.o
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer_debug.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer_debug.c
index 3adef474ed26..05df502a54f2 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer_debug.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer_debug.c
@@ -40,7 +40,7 @@
 #include "ipp.h"
 #include "mpc.h"
 #include "reg_helper.h"
-#include "dcn10_hubp.h"
+#include "dcn10/dcn10_hubp.h"
 #include "dcn10/dcn10_hubbub.h"
 #include "dcn10_cm_common.h"
 #include "clk_mgr.h"
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/Makefile b/drivers/gpu/drm/amd/display/dc/dcn20/Makefile
index 33cbd871eb3a..1ca1cbeabbca 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/Makefile
@@ -1,8 +1,7 @@
 # SPDX-License-Identifier: MIT
 # Copyright © 2019-2024 Advanced Micro Devices, Inc. All rights reserved.
 
-DCN20 = dcn20_hubp.o \
-		dcn20_mpc.o dcn20_opp.o dcn20_mmhubbub.o \
+DCN20 = dcn20_mpc.o dcn20_opp.o dcn20_mmhubbub.o \
 		dcn20_stream_encoder.o dcn20_link_encoder.o \
 		dcn20_vmid.o dcn20_dwb.o dcn20_dwb_scl.o
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn201/Makefile b/drivers/gpu/drm/amd/display/dc/dcn201/Makefile
index 7b7acadfccf7..c9f4a5a9f522 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn201/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dcn201/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: MIT
 # Copyright © 2021-2024 Advanced Micro Devices, Inc. All rights reserved.
 
-DCN201 = dcn201_mpc.o dcn201_hubp.o dcn201_opp.o \
+DCN201 = dcn201_mpc.o dcn201_opp.o \
 	dcn201_link_encoder.o
 
 AMD_DAL_DCN201 = $(addprefix $(AMDDALPATH)/dc/dcn201/,$(DCN201))
diff --git a/drivers/gpu/drm/amd/display/dc/dcn21/Makefile b/drivers/gpu/drm/amd/display/dc/dcn21/Makefile
index 720f1a463b89..c215f3cc6e44 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn21/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dcn21/Makefile
@@ -1,8 +1,7 @@
 # SPDX-License-Identifier: MIT
 # Copyright © 2019-2024 Advanced Micro Devices, Inc. All rights reserved.
 
-DCN21 = dcn21_hubp.o \
-	 dcn21_link_encoder.o
+DCN21 = dcn21_link_encoder.o
 
 AMD_DAL_DCN21 = $(addprefix $(AMDDALPATH)/dc/dcn21/,$(DCN21))
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/Makefile b/drivers/gpu/drm/amd/display/dc/dcn30/Makefile
index fb7471435c69..2131d228f6fb 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/Makefile
@@ -23,8 +23,7 @@
 #
 #
 
-DCN30 := dcn30_hubp.o \
-	dcn30_mpc.o dcn30_vpg.o \
+DCN30 := dcn30_mpc.o dcn30_vpg.o \
 	dcn30_afmt.o \
 	dcn30_dio_stream_encoder.o \
 	dcn30_dwb.o \
diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/Makefile b/drivers/gpu/drm/amd/display/dc/dcn31/Makefile
index 7daa2f038c97..62c8ab0e45aa 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/Makefile
@@ -10,8 +10,7 @@
 #
 # Makefile for dcn31.
 
-DCN31 = dcn31_hubp.o \
-	dcn31_dio_link_encoder.o dcn31_panel_cntl.o \
+DCN31 = dcn31_dio_link_encoder.o dcn31_panel_cntl.o \
 	dcn31_apg.o dcn31_hpo_dp_stream_encoder.o dcn31_hpo_dp_link_encoder.o \
 	dcn31_afmt.o dcn31_vpg.o
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/Makefile b/drivers/gpu/drm/amd/display/dc/dcn32/Makefile
index dd3c4e70bce6..2d0eb203ab69 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/Makefile
@@ -10,7 +10,7 @@
 #
 # Makefile for dcn32.
 
-DCN32 = dcn32_mmhubbub.o dcn32_hubp.o dcn32_mpc.o \
+DCN32 = dcn32_mmhubbub.o dcn32_mpc.o \
 		dcn32_dio_stream_encoder.o dcn32_dio_link_encoder.o dcn32_resource_helpers.o \
 		dcn32_hpo_dp_link_encoder.o
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn35/Makefile b/drivers/gpu/drm/amd/display/dc/dcn35/Makefile
index eb70d5f4e90e..d0fab60e7cd9 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn35/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dcn35/Makefile
@@ -12,7 +12,6 @@
 
 DCN35 = dcn35_dio_stream_encoder.o \
 	dcn35_dio_link_encoder.o \
-	dcn35_hubp.o \
 	dcn35_mmhubbub.o dcn35_opp.o dcn35_pg_cntl.o dcn35_dwb.o
 
 AMD_DAL_DCN35 = $(addprefix $(AMDDALPATH)/dc/dcn35/,$(DCN35))
diff --git a/drivers/gpu/drm/amd/display/dc/hubp/Makefile b/drivers/gpu/drm/amd/display/dc/hubp/Makefile
new file mode 100644
index 000000000000..a25a8b216e15
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/hubp/Makefile
@@ -0,0 +1,92 @@
+
+# Copyright 2022 Advanced Micro Devices, Inc.
+#
+# Permission is hereby granted, free of charge, to any person obtaining a
+# copy of this software and associated documentation files (the "Software"),
+# to deal in the Software without restriction, including without limitation
+# the rights to use, copy, modify, merge, publish, distribute, sublicense,
+# and/or sell copies of the Software, and to permit persons to whom the
+# Software is furnished to do so, subject to the following conditions:
+#
+# The above copyright notice and this permission notice shall be included in
+# all copies or substantial portions of the Software.
+#
+# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+# THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+# OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+# ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+# OTHER DEALINGS IN THE SOFTWARE.
+#
+# Makefile for the 'hubp' sub-component of DAL.
+#
+ifdef CONFIG_DRM_AMD_DC_FP
+###############################################################################
+# DCN
+###############################################################################
+
+HUBP_DCN10 = dcn10_hubp.o
+
+AMD_DAL_HUBP_DCN10 = $(addprefix $(AMDDALPATH)/dc/hubp/dcn10/,$(HUBP_DCN10))
+
+AMD_DISPLAY_FILES += $(AMD_DAL_HUBP_DCN10)
+###############################################################################
+
+HUBP_DCN20 = dcn20_hubp.o
+
+AMD_DAL_HUBP_DCN20 = $(addprefix $(AMDDALPATH)/dc/hubp/dcn20/,$(HUBP_DCN20))
+
+AMD_DISPLAY_FILES += $(AMD_DAL_HUBP_DCN20)
+
+###############################################################################
+
+HUBP_DCN201 = dcn201_hubp.o
+
+AMD_DAL_HUBP_DCN201 = $(addprefix $(AMDDALPATH)/dc/hubp/dcn201/,$(HUBP_DCN201))
+
+AMD_DISPLAY_FILES += $(AMD_DAL_HUBP_DCN201)
+
+###############################################################################
+
+HUBP_DCN21 = dcn21_hubp.o
+
+AMD_DAL_HUBP_DCN21 = $(addprefix $(AMDDALPATH)/dc/hubp/dcn21/,$(HUBP_DCN21))
+
+AMD_DISPLAY_FILES += $(AMD_DAL_HUBP_DCN21)
+
+###############################################################################
+HUBP_DCN30 = dcn30_hubp.o
+
+AMD_DAL_HUBP_DCN30 = $(addprefix $(AMDDALPATH)/dc/hubp/dcn30/,$(HUBP_DCN30))
+
+AMD_DISPLAY_FILES += $(AMD_DAL_HUBP_DCN30)
+
+###############################################################################
+
+HUBP_DCN31 = dcn31_hubp.o
+
+AMD_DAL_HUBP_DCN31 = $(addprefix $(AMDDALPATH)/dc/hubp/dcn31/,$(HUBP_DCN31))
+
+AMD_DISPLAY_FILES += $(AMD_DAL_HUBP_DCN31)
+
+###############################################################################
+
+HUBP_DCN32 = dcn32_hubp.o
+
+AMD_DAL_HUBP_DCN32 = $(addprefix $(AMDDALPATH)/dc/hubp/dcn32/,$(HUBP_DCN32))
+
+AMD_DISPLAY_FILES += $(AMD_DAL_HUBP_DCN32)
+
+###############################################################################
+
+HUBP_DCN35 = dcn35_hubp.o
+
+AMD_DAL_HUBP_DCN35 = $(addprefix $(AMDDALPATH)/dc/hubp/dcn35/,$(HUBP_DCN35))
+
+AMD_DISPLAY_FILES += $(AMD_DAL_HUBP_DCN35)
+
+###############################################################################
+
+###############################################################################
+endif
\ No newline at end of file
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hubp.c b/drivers/gpu/drm/amd/display/dc/hubp/dcn10/dcn10_hubp.c
similarity index 100%
rename from drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hubp.c
rename to drivers/gpu/drm/amd/display/dc/hubp/dcn10/dcn10_hubp.c
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hubp.h b/drivers/gpu/drm/amd/display/dc/hubp/dcn10/dcn10_hubp.h
similarity index 100%
rename from drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hubp.h
rename to drivers/gpu/drm/amd/display/dc/hubp/dcn10/dcn10_hubp.h
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hubp.c b/drivers/gpu/drm/amd/display/dc/hubp/dcn20/dcn20_hubp.c
similarity index 100%
rename from drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hubp.c
rename to drivers/gpu/drm/amd/display/dc/hubp/dcn20/dcn20_hubp.c
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hubp.h b/drivers/gpu/drm/amd/display/dc/hubp/dcn20/dcn20_hubp.h
similarity index 100%
rename from drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hubp.h
rename to drivers/gpu/drm/amd/display/dc/hubp/dcn20/dcn20_hubp.h
diff --git a/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_hubp.c b/drivers/gpu/drm/amd/display/dc/hubp/dcn201/dcn201_hubp.c
similarity index 100%
rename from drivers/gpu/drm/amd/display/dc/dcn201/dcn201_hubp.c
rename to drivers/gpu/drm/amd/display/dc/hubp/dcn201/dcn201_hubp.c
diff --git a/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_hubp.h b/drivers/gpu/drm/amd/display/dc/hubp/dcn201/dcn201_hubp.h
similarity index 100%
rename from drivers/gpu/drm/amd/display/dc/dcn201/dcn201_hubp.h
rename to drivers/gpu/drm/amd/display/dc/hubp/dcn201/dcn201_hubp.h
diff --git a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_hubp.c b/drivers/gpu/drm/amd/display/dc/hubp/dcn21/dcn21_hubp.c
similarity index 100%
rename from drivers/gpu/drm/amd/display/dc/dcn21/dcn21_hubp.c
rename to drivers/gpu/drm/amd/display/dc/hubp/dcn21/dcn21_hubp.c
diff --git a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_hubp.h b/drivers/gpu/drm/amd/display/dc/hubp/dcn21/dcn21_hubp.h
similarity index 100%
rename from drivers/gpu/drm/amd/display/dc/dcn21/dcn21_hubp.h
rename to drivers/gpu/drm/amd/display/dc/hubp/dcn21/dcn21_hubp.h
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hubp.c b/drivers/gpu/drm/amd/display/dc/hubp/dcn30/dcn30_hubp.c
similarity index 100%
rename from drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hubp.c
rename to drivers/gpu/drm/amd/display/dc/hubp/dcn30/dcn30_hubp.c
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hubp.h b/drivers/gpu/drm/amd/display/dc/hubp/dcn30/dcn30_hubp.h
similarity index 100%
rename from drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hubp.h
rename to drivers/gpu/drm/amd/display/dc/hubp/dcn30/dcn30_hubp.h
diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hubp.c b/drivers/gpu/drm/amd/display/dc/hubp/dcn31/dcn31_hubp.c
similarity index 100%
rename from drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hubp.c
rename to drivers/gpu/drm/amd/display/dc/hubp/dcn31/dcn31_hubp.c
diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hubp.h b/drivers/gpu/drm/amd/display/dc/hubp/dcn31/dcn31_hubp.h
similarity index 100%
rename from drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hubp.h
rename to drivers/gpu/drm/amd/display/dc/hubp/dcn31/dcn31_hubp.h
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hubp.c b/drivers/gpu/drm/amd/display/dc/hubp/dcn32/dcn32_hubp.c
similarity index 100%
rename from drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hubp.c
rename to drivers/gpu/drm/amd/display/dc/hubp/dcn32/dcn32_hubp.c
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hubp.h b/drivers/gpu/drm/amd/display/dc/hubp/dcn32/dcn32_hubp.h
similarity index 100%
rename from drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hubp.h
rename to drivers/gpu/drm/amd/display/dc/hubp/dcn32/dcn32_hubp.h
diff --git a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_hubp.c b/drivers/gpu/drm/amd/display/dc/hubp/dcn35/dcn35_hubp.c
similarity index 100%
rename from drivers/gpu/drm/amd/display/dc/dcn35/dcn35_hubp.c
rename to drivers/gpu/drm/amd/display/dc/hubp/dcn35/dcn35_hubp.c
diff --git a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_hubp.h b/drivers/gpu/drm/amd/display/dc/hubp/dcn35/dcn35_hubp.h
similarity index 100%
rename from drivers/gpu/drm/amd/display/dc/dcn35/dcn35_hubp.h
rename to drivers/gpu/drm/amd/display/dc/hubp/dcn35/dcn35_hubp.h
-- 
2.34.1

