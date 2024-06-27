Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B359C2BD09
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Jun 2024 21:14:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AB8E710EB5F;
	Thu, 27 Jun 2024 21:14:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0sm2oy2+";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2040.outbound.protection.outlook.com [40.107.237.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4CB0410EB64
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Jun 2024 21:14:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GwGtYpvagYZTSxk7g886YiIUSXUuOS/+nFYpRXIDI9mg1RWnB3AskBMP7duslV/RZg7F/xVmxyl6JWAgEwmcD27TqFVNilCYo8JBAE8EazBeJDVgkx6POGouFFqaimMPSjabh33+2L+ny4HG0dNyBEKRGu2Ma8PNY4vJ9yoKf1hkEHRg91PPJlvnlisHUYH6is+hJobMVEqHp1nFz4zwiHX4tZesBj9bJnuQW2ow2o23nRp1fTRGhVGJ9kbMgtbePd6QImHjo27moc39Rl0mPnlentg/hQnXoF2aY9FfffZMHgTg9SHrEVbXFf+7Bk0AV/MXhAtISAtnmyRETSquyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7nyZD4pB6mi72qhobIYlokYvfqmU+gWUatKEXxb/7ss=;
 b=oXLK1yDktgp90kFzblWoTAPDG36fXDjNw44ZUPNRZtbNiVQcQI8pmUtR/CV3YeWT8D7xif/tJIjL3t4lTzK0FzOI/XhlTjLLT6M52TgISsN+FJEu/9vKlRuKpvJV3IOKferVJXoGhUpMwT/SI5x1MHm5BwBGX5FNwghSBl6WL6R3uCNe0Wm7kbZrMybylVO91Gq1Dpz6kJqDL0yqBxo4yafOt1SQaJUHCOR1oFYsolhTWUMZRu0u6Rv7+Jk4as91/q/kd071YmkCO8muiJSQHxrBUIX0he8aJDIEirgeTosZVaXRKClyuTAlL/lZz5wgOZNM5wThYVIa25PODr6iFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7nyZD4pB6mi72qhobIYlokYvfqmU+gWUatKEXxb/7ss=;
 b=0sm2oy2+BFuIVLJiVNuoMR7BoEGyKfSWv41EW10tL8FW+afsbD434CtySvpWvuOY8nNJR7bxRonYgl0O52cSQVM5netbJ2HXPLLXzDDqsgkh8yoaJk7xhG5kivBKEow6oF+VHXhuIwhEoJ+fSdcNV/cw5MJrE6N3TrZJKlzIMHY=
Received: from PH8PR05CA0023.namprd05.prod.outlook.com (2603:10b6:510:2cc::8)
 by IA0PR12MB7774.namprd12.prod.outlook.com (2603:10b6:208:430::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.32; Thu, 27 Jun
 2024 21:14:45 +0000
Received: from CY4PEPF0000E9CF.namprd03.prod.outlook.com
 (2603:10b6:510:2cc:cafe::e1) by PH8PR05CA0023.outlook.office365.com
 (2603:10b6:510:2cc::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.15 via Frontend
 Transport; Thu, 27 Jun 2024 21:14:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9CF.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Thu, 27 Jun 2024 21:14:44 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 27 Jun
 2024 16:14:44 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 27 Jun
 2024 16:14:43 -0500
Received: from jzuo-linux.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Thu, 27 Jun 2024 16:14:43 -0500
From: Fangzhi Zuo <Jerry.Zuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, Bhuvanachandra Pinninti <bpinnint@amd.com>
Subject: [PATCH 21/26] drm/amd/display: Move dio files into dio folder
Date: Thu, 27 Jun 2024 17:13:24 -0400
Message-ID: <20240627211329.26386-22-Jerry.Zuo@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240627211329.26386-1-Jerry.Zuo@amd.com>
References: <20240627211329.26386-1-Jerry.Zuo@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Received-SPF: None (SATLEXMB05.amd.com: Jerry.Zuo@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9CF:EE_|IA0PR12MB7774:EE_
X-MS-Office365-Filtering-Correlation-Id: 6aeddc7a-1310-4cba-9395-08dc96ee2b43
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bmxwSDZyWHpRRjlqY1U0dHBnZ2czUTVEZmg3YVppNER3aVg3UDYrL3FsSVdu?=
 =?utf-8?B?MWtSQzdrc1ZKcGtRYVc1UzVWWS9qVitYK09adXJVaGRrbEV2RzZqWHBEYUdO?=
 =?utf-8?B?QnZNdUZ1SXBPMmtpT01BY1JybzhkT0pVK0wrOGN2OEZLQ052TG1Bd1dsNXVx?=
 =?utf-8?B?Z2g0OFBybmE2dkJPbDZTY1pIUU9jQ245ZzNaQUZzZUpUWW5HOU10enNtOHI2?=
 =?utf-8?B?akZ0b2g5TkNuUFdQWkxLc1Q2ZlJRYjZKV3Jib3d3MmxpTHlZT3UzMFVIVmht?=
 =?utf-8?B?U2N6Sllsc01iTEpzMFlKNHhZWEZaMmszMUtscGhlYjV2QUdTeDZkQXBuZk9O?=
 =?utf-8?B?VHVnNnRsOW9NTlAvNis5M09RWUVkVU9TUHdoWVF5QmVXZTZqekNKcmdtRUF6?=
 =?utf-8?B?MjZhV2lhTERyRXRTemdzdW0wQTNiWVF4ZFRGNFZVZjd3WmJPbkFUM0RLTzJW?=
 =?utf-8?B?RjJBWFdDTE1rZnZ1ajN0ZzJ0UXBuKzY4UC9WR0VXREVQcjRrMWt4VTh2bU5J?=
 =?utf-8?B?RzJSZE56N2RLTnpVcWwwMEMwTVc1VjNGUkdXQk83UFhJRGRPZS8zcklZSmZJ?=
 =?utf-8?B?MjBFeWw2a2NOekx0Q2k3b20vODdpemJMcFVBOEhvSVhiRHQzcm1rR0lNam01?=
 =?utf-8?B?dG13Q1ZqOFdlTFd0SS90VnNycklnNkE3QjFReTVzaytmazZTdzhpRFg3U2Y4?=
 =?utf-8?B?Q1AyQ2lEaUlvYTR5ZmoxbDNhUDNRYUNtdXFpcklGbGlPME4ybm1xQTBOTXlG?=
 =?utf-8?B?Vk9Yc2t1Uk9EWll5Wjd2QXFLbkJFSjErZXdFbE91Z21RTDhodGZkc0d2Tzg5?=
 =?utf-8?B?LzRyK1JqQjJqajlIcTcyd3Uxdnp6MFJBdWU2U0VpRmlUMjVPR1BPRFUzRzhD?=
 =?utf-8?B?UDZrYXZTQkVKTHl2Tzl5dzlQRDVMZWY2RUZ2VXJoeVZBcHV0UHpTdTk3N0Fp?=
 =?utf-8?B?VnppM1pQRjAxNDlaU0xvU0hTWVJSOXBUUU9tYVM1VGxGMTRHeVJTVzFGTTdQ?=
 =?utf-8?B?SUdRUmJuYnNRM1pOMUN3anN0R3Nkc1BLYldFY3J2am0zUTZSY3o1WHpiNFZK?=
 =?utf-8?B?WlY1U0dYMXpoNkRCQ1I0eGxtQVZpendxRUlsSE5RaWRQRW1hdE5CdGtUTFlD?=
 =?utf-8?B?S2lzSnh1TkxQaHFBR0hjazNKZVA3WVprSlZvMmtPSDNxMHlJVXJtd2dueGNm?=
 =?utf-8?B?V242S24wZWNLVFlaeTE4a25ZcEJrR2JHUmx5NDBqeDVzSGMxZ2JFUFBRYkRa?=
 =?utf-8?B?M0tlem4xR2NHNWpQUHFJN09HaHFuTnZOMFJHT0NSOGxKSEpFeTR2VnNHOHM2?=
 =?utf-8?B?eUpMV2hPbXRLMXZ6d3lqRHBTdDRpd3JGVDhoK1NNdzArRit1aEV4bHBTVXox?=
 =?utf-8?B?SCtBVE93L3NPZDZRZzJiaGt3aG1WREorUTFBNlJUWnZ2MmNzOEUva0loaWdC?=
 =?utf-8?B?RnlHYU02STJ5M3N6UldLTDdkay9MWHNCS3pWM0NJTGNyOXhETldlYnBvUHJn?=
 =?utf-8?B?aG45REZBVGczWTVGUWtlL25IT0c5Sjgwb3pIcTJ6WnhwUGVhUXBpM0RtUldN?=
 =?utf-8?B?UVRYbVlISHRyVmtRWVNJUFhydUx5eng2dlpsSDg4VzlxL3RpVGlBcjlpeHZB?=
 =?utf-8?B?aEVQWDlSL1V3ZnR3NCtvVlhrN0ZFQUlnUzg5OUMwSkp5bXlyV0ZOeXFseFgy?=
 =?utf-8?B?aEM0R250Skptc1NYNHp0cCtjVHdOajk4SDVQZ3BjbzdoNWZrcFdjbDdTWldD?=
 =?utf-8?B?Yzk3elFPZFBhNFFVUzFyVHo3UTZiVzBWUlNPaGx0VnJSM1lObTUzSlNMYVha?=
 =?utf-8?B?Mk5nYUZWRlM3Zy9YWitEQk1DTUdURWVJWk5QZklvNGFHYlhBQ3dkUmhsdXha?=
 =?utf-8?B?ckNmWmRobS9ZenNYbGVUQWZtMUl3UzJuWDE2djhKV2ZNcDM2SUlOUWRSSDBU?=
 =?utf-8?Q?fwB9n3sFZT94OhNZebIX3fOQmhWzQp6i?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2024 21:14:44.9343 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6aeddc7a-1310-4cba-9395-08dc96ee2b43
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9CF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7774
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

From: Bhuvanachandra Pinninti <bpinnint@amd.com>

[why]
Refactor the code of dio to unit test.

[how]
Moved files to respective folders and changed cMakeLists and makefiles.

Signed-off-by: Jerry Zuo <jerry.zuo@amd.com>
Signed-off-by: Bhuvanachandra Pinninti <bpinnint@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn10/Makefile |  1 -
 drivers/gpu/drm/amd/display/dc/dcn20/Makefile |  1 -
 drivers/gpu/drm/amd/display/dc/dcn30/Makefile |  2 --
 drivers/gpu/drm/amd/display/dc/dcn31/Makefile |  2 +-
 drivers/gpu/drm/amd/display/dc/dio/Makefile   | 36 +++++++++++++++++++
 .../dc/{ => dio}/dcn10/dcn10_link_encoder.c   |  0
 .../dc/{ => dio}/dcn10/dcn10_link_encoder.h   |  0
 .../dc/{ => dio}/dcn10/dcn10_stream_encoder.c |  0
 .../dc/{ => dio}/dcn10/dcn10_stream_encoder.h |  0
 .../dc/{ => dio}/dcn20/dcn20_link_encoder.c   |  0
 .../dc/{ => dio}/dcn20/dcn20_link_encoder.h   |  0
 .../dc/{ => dio}/dcn20/dcn20_stream_encoder.c |  0
 .../dc/{ => dio}/dcn20/dcn20_stream_encoder.h |  0
 .../{ => dio}/dcn30/dcn30_dio_link_encoder.c  |  0
 .../{ => dio}/dcn30/dcn30_dio_link_encoder.h  |  0
 .../dcn30/dcn30_dio_stream_encoder.c          |  0
 .../dcn30/dcn30_dio_stream_encoder.h          |  0
 .../{ => dio}/dcn31/dcn31_dio_link_encoder.c  |  0
 .../{ => dio}/dcn31/dcn31_dio_link_encoder.h  |  0
 19 files changed, 37 insertions(+), 5 deletions(-)
 rename drivers/gpu/drm/amd/display/dc/{ => dio}/dcn10/dcn10_link_encoder.c (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => dio}/dcn10/dcn10_link_encoder.h (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => dio}/dcn10/dcn10_stream_encoder.c (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => dio}/dcn10/dcn10_stream_encoder.h (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => dio}/dcn20/dcn20_link_encoder.c (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => dio}/dcn20/dcn20_link_encoder.h (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => dio}/dcn20/dcn20_stream_encoder.c (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => dio}/dcn20/dcn20_stream_encoder.h (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => dio}/dcn30/dcn30_dio_link_encoder.c (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => dio}/dcn30/dcn30_dio_link_encoder.h (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => dio}/dcn30/dcn30_dio_stream_encoder.c (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => dio}/dcn30/dcn30_dio_stream_encoder.h (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => dio}/dcn31/dcn31_dio_link_encoder.c (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => dio}/dcn31/dcn31_dio_link_encoder.h (100%)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/Makefile b/drivers/gpu/drm/amd/display/dc/dcn10/Makefile
index 68484264831b..9923d0d620d4 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/Makefile
@@ -27,7 +27,6 @@ DCN10 = dcn10_ipp.o \
 		dcn10_opp.o \
 		dcn10_mpc.o \
 		dcn10_cm_common.o \
-		dcn10_stream_encoder.o dcn10_link_encoder.o
 
 AMD_DAL_DCN10 = $(addprefix $(AMDDALPATH)/dc/dcn10/,$(DCN10))
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/Makefile b/drivers/gpu/drm/amd/display/dc/dcn20/Makefile
index 1ca1cbeabbca..b3aeabc4d605 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/Makefile
@@ -2,7 +2,6 @@
 # Copyright © 2019-2024 Advanced Micro Devices, Inc. All rights reserved.
 
 DCN20 = dcn20_mpc.o dcn20_opp.o dcn20_mmhubbub.o \
-		dcn20_stream_encoder.o dcn20_link_encoder.o \
 		dcn20_vmid.o dcn20_dwb.o dcn20_dwb_scl.o
 
 AMD_DAL_DCN20 = $(addprefix $(AMDDALPATH)/dc/dcn20/,$(DCN20))
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/Makefile b/drivers/gpu/drm/amd/display/dc/dcn30/Makefile
index 2131d228f6fb..4c43af867d86 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/Makefile
@@ -25,12 +25,10 @@
 
 DCN30 := dcn30_mpc.o dcn30_vpg.o \
 	dcn30_afmt.o \
-	dcn30_dio_stream_encoder.o \
 	dcn30_dwb.o \
 	dcn30_dwb_cm.o \
 	dcn30_cm_common.o \
 	dcn30_mmhubbub.o \
-	dcn30_dio_link_encoder.o
 
 
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/Makefile b/drivers/gpu/drm/amd/display/dc/dcn31/Makefile
index 62c8ab0e45aa..5e07e56830a2 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/Makefile
@@ -10,7 +10,7 @@
 #
 # Makefile for dcn31.
 
-DCN31 = dcn31_dio_link_encoder.o dcn31_panel_cntl.o \
+DCN31 = dcn31_panel_cntl.o \
 	dcn31_apg.o dcn31_hpo_dp_stream_encoder.o dcn31_hpo_dp_link_encoder.o \
 	dcn31_afmt.o dcn31_vpg.o
 
diff --git a/drivers/gpu/drm/amd/display/dc/dio/Makefile b/drivers/gpu/drm/amd/display/dc/dio/Makefile
index 5fa905c2fe55..67840e474d7a 100644
--- a/drivers/gpu/drm/amd/display/dc/dio/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dio/Makefile
@@ -24,6 +24,42 @@
 #
 
 ifdef CONFIG_DRM_AMD_DC_FP
+###############################################################################
+# DCN10
+###############################################################################
+DIO_DCN10 = dcn10_link_encoder.o dcn10_stream_encoder.o
+
+AMD_DAL_DIO_DCN10 = $(addprefix $(AMDDALPATH)/dc/dio/dcn10/,$(DIO_DCN10))
+
+AMD_DISPLAY_FILES += $(AMD_DAL_DIO_DCN10)
+
+###############################################################################
+# DCN20
+###############################################################################
+DIO_DCN20 = dcn20_link_encoder.o dcn20_stream_encoder.o
+
+AMD_DAL_DIO_DCN20 = $(addprefix $(AMDDALPATH)/dc/dio/dcn20/,$(DIO_DCN20))
+
+AMD_DISPLAY_FILES += $(AMD_DAL_DIO_DCN20)
+
+###############################################################################
+# DCN30
+###############################################################################
+DIO_DCN30 = dcn30_dio_link_encoder.o dcn30_dio_stream_encoder.o
+
+AMD_DAL_DIO_DCN30 = $(addprefix $(AMDDALPATH)/dc/dio/dcn30/,$(DIO_DCN30))
+
+AMD_DISPLAY_FILES += $(AMD_DAL_DIO_DCN30)
+
+###############################################################################
+# DCN31
+###############################################################################
+DIO_DCN31 = dcn31_dio_link_encoder.o
+
+AMD_DAL_DIO_DCN31 = $(addprefix $(AMDDALPATH)/dc/dio/dcn31/,$(DIO_DCN31))
+
+AMD_DISPLAY_FILES += $(AMD_DAL_DIO_DCN31)
+
 ###############################################################################
 # DCN32
 ###############################################################################
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_link_encoder.c b/drivers/gpu/drm/amd/display/dc/dio/dcn10/dcn10_link_encoder.c
similarity index 100%
rename from drivers/gpu/drm/amd/display/dc/dcn10/dcn10_link_encoder.c
rename to drivers/gpu/drm/amd/display/dc/dio/dcn10/dcn10_link_encoder.c
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_link_encoder.h b/drivers/gpu/drm/amd/display/dc/dio/dcn10/dcn10_link_encoder.h
similarity index 100%
rename from drivers/gpu/drm/amd/display/dc/dcn10/dcn10_link_encoder.h
rename to drivers/gpu/drm/amd/display/dc/dio/dcn10/dcn10_link_encoder.h
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_stream_encoder.c b/drivers/gpu/drm/amd/display/dc/dio/dcn10/dcn10_stream_encoder.c
similarity index 100%
rename from drivers/gpu/drm/amd/display/dc/dcn10/dcn10_stream_encoder.c
rename to drivers/gpu/drm/amd/display/dc/dio/dcn10/dcn10_stream_encoder.c
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_stream_encoder.h b/drivers/gpu/drm/amd/display/dc/dio/dcn10/dcn10_stream_encoder.h
similarity index 100%
rename from drivers/gpu/drm/amd/display/dc/dcn10/dcn10_stream_encoder.h
rename to drivers/gpu/drm/amd/display/dc/dio/dcn10/dcn10_stream_encoder.h
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_link_encoder.c b/drivers/gpu/drm/amd/display/dc/dio/dcn20/dcn20_link_encoder.c
similarity index 100%
rename from drivers/gpu/drm/amd/display/dc/dcn20/dcn20_link_encoder.c
rename to drivers/gpu/drm/amd/display/dc/dio/dcn20/dcn20_link_encoder.c
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_link_encoder.h b/drivers/gpu/drm/amd/display/dc/dio/dcn20/dcn20_link_encoder.h
similarity index 100%
rename from drivers/gpu/drm/amd/display/dc/dcn20/dcn20_link_encoder.h
rename to drivers/gpu/drm/amd/display/dc/dio/dcn20/dcn20_link_encoder.h
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_stream_encoder.c b/drivers/gpu/drm/amd/display/dc/dio/dcn20/dcn20_stream_encoder.c
similarity index 100%
rename from drivers/gpu/drm/amd/display/dc/dcn20/dcn20_stream_encoder.c
rename to drivers/gpu/drm/amd/display/dc/dio/dcn20/dcn20_stream_encoder.c
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_stream_encoder.h b/drivers/gpu/drm/amd/display/dc/dio/dcn20/dcn20_stream_encoder.h
similarity index 100%
rename from drivers/gpu/drm/amd/display/dc/dcn20/dcn20_stream_encoder.h
rename to drivers/gpu/drm/amd/display/dc/dio/dcn20/dcn20_stream_encoder.h
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dio_link_encoder.c b/drivers/gpu/drm/amd/display/dc/dio/dcn30/dcn30_dio_link_encoder.c
similarity index 100%
rename from drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dio_link_encoder.c
rename to drivers/gpu/drm/amd/display/dc/dio/dcn30/dcn30_dio_link_encoder.c
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dio_link_encoder.h b/drivers/gpu/drm/amd/display/dc/dio/dcn30/dcn30_dio_link_encoder.h
similarity index 100%
rename from drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dio_link_encoder.h
rename to drivers/gpu/drm/amd/display/dc/dio/dcn30/dcn30_dio_link_encoder.h
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dio_stream_encoder.c b/drivers/gpu/drm/amd/display/dc/dio/dcn30/dcn30_dio_stream_encoder.c
similarity index 100%
rename from drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dio_stream_encoder.c
rename to drivers/gpu/drm/amd/display/dc/dio/dcn30/dcn30_dio_stream_encoder.c
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dio_stream_encoder.h b/drivers/gpu/drm/amd/display/dc/dio/dcn30/dcn30_dio_stream_encoder.h
similarity index 100%
rename from drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dio_stream_encoder.h
rename to drivers/gpu/drm/amd/display/dc/dio/dcn30/dcn30_dio_stream_encoder.h
diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dio_link_encoder.c b/drivers/gpu/drm/amd/display/dc/dio/dcn31/dcn31_dio_link_encoder.c
similarity index 100%
rename from drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dio_link_encoder.c
rename to drivers/gpu/drm/amd/display/dc/dio/dcn31/dcn31_dio_link_encoder.c
diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dio_link_encoder.h b/drivers/gpu/drm/amd/display/dc/dio/dcn31/dcn31_dio_link_encoder.h
similarity index 100%
rename from drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dio_link_encoder.h
rename to drivers/gpu/drm/amd/display/dc/dio/dcn31/dcn31_dio_link_encoder.h
-- 
2.34.1

