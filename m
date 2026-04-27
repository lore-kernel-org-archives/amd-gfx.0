Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22C59FF8862
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Apr 2026 07:34:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 71B6A10E5C9;
	Mon, 27 Apr 2026 07:34:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="SC+4/rl5";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013008.outbound.protection.outlook.com
 [40.93.201.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0098B10E5C9
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Apr 2026 07:34:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZBmdUWShwwcCx/Vl4K0y0Pxx7OAiaDPUI1bEwf9AKVNjO/SqW8HYn8SFQld1TG6kJK/i6Wta2NYxmtV+roxJWb1+fPzlrYe7iJFcL9bufQ/BdRAfNB4HlKbX/E9pdjWCQNCRFbyCNkvPhQcLHNd/j8mHQe6fnH5elJpbq0LfVR5AE8sDO0mo9WhZ3ju6/ARRxxSF0ML1Kg+AP7FStItByFIEKrx1hs61z9GSesr8bHYU0D4MGNmKb5qKXqebMRnLcczVSCOiy9AMgYyZL+2jcV00C3t/TvP0YCZav/fliNVsUSXKWhJgBSOY4lEkj52azUqhihigsuVOtm1wJe7Q+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m0ykvZc5QdDR1wM/N9jwy5UuRHue1NS4BDfRgHwmb5I=;
 b=gUxHR2HC8IzZn0owjA+r7ogq8xl2wd6N2NwA+HOUvNz2kcsbUD7EgkRtHNgBIso+VTznx5PXknHVmYBUHVmJR3raXMFxlI1bbNkbwkE0r4NbenbKh+yvZ8mgy1ePLOG/M8HJPkIkcwFEik0LLMpm2lUzmevhXZIX6kzTnmckOd4HWRghAHw5uY2V5W5t14NcJRZe1KwBj5EdD92kW6GOVTJYuCSjwzYhFF36sDwTPE5sWGyXZJiX9gO4hCFNDe/jsnyFbjEir6Njip4nhlVuu75csyURg5jrlRmilfI84Yk6a/u8ye+Cb3/OAkC83gWrM4QiFlF2R61pboPYPDlZ3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m0ykvZc5QdDR1wM/N9jwy5UuRHue1NS4BDfRgHwmb5I=;
 b=SC+4/rl5hDgZS0QDN1ckn8vo6sZp0SJn+yz8pTOd8H5YUGPtGFGFHdYXJDkBXcuNF4Vm1l/gk0yBLc9d6SHKab7YK7ZfYfzf9wunqN4QSFWpQVhALgHWZawebWvB+/zmCaD6dthj7sRiADxWyDa/Kk804Cfrj6OB4+JeZdBAwBE=
Received: from PH7PR03CA0024.namprd03.prod.outlook.com (2603:10b6:510:339::7)
 by MN0PR12MB6318.namprd12.prod.outlook.com (2603:10b6:208:3c1::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.16; Mon, 27 Apr
 2026 07:34:17 +0000
Received: from CY4PEPF0000FCC5.namprd03.prod.outlook.com
 (2603:10b6:510:339:cafe::bc) by PH7PR03CA0024.outlook.office365.com
 (2603:10b6:510:339::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.26 via Frontend Transport; Mon,
 27 Apr 2026 07:34:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000FCC5.mail.protection.outlook.com (10.167.242.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Mon, 27 Apr 2026 07:34:16 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 27 Apr
 2026 02:34:14 -0500
From: Yang Wang <kevinyang.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <hawking.zhang@amd.com>,
 <kenneth.feng@amd.com>
Subject: [PATCH 0/4] drm/amd/pm: add and use the SMU multi-msgs helper
Date: Mon, 27 Apr 2026 15:33:51 +0800
Message-ID: <20260427073355.3363500-1-kevinyang.wang@amd.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC5:EE_|MN0PR12MB6318:EE_
X-MS-Office365-Filtering-Correlation-Id: 14dd4942-5d1f-4f91-e5f4-08dea42f62fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|376014|1800799024|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: 8nJF5x9yPE1ZY0laXX/Dg5gQ8/G84XngE3ShzdOyidLb+8ozIHUcof/VP7oDBqENiVMMNhBf9g97jgaBCWnBXxwEZb/YjeHsCAg9U1IiBolwRHRle5Q+SZDtpZUoxLHpie7zSJYFYledx9zLAcL/Anbld+rxmk3klfIclIS/ok7zEi3JhpoP+NvDCwvJR4Vpd4NQxQ0/I4/U/kIJK/n1+jZJStyaEQJ8OiL6W+4eD/+RyOtZ/h3DP24A+4/ZC5MOAPX3ZhSLGacaOe6m/gb6Mwmx87JEhqbrm0GNX6QR8d8lkT7P36Jm6w2HGr6yHDdbjS6aI005MhUP2BTr4C/F/kUfs3TAk0xklTc/FGWkDa0BiyrC+dwazzOPrdLBmwjn04s+WDZAF+bO0hXotZCsB4NwovxkyhiwHCxj0HPZo3z0Av7UPSqYd2lUFL7MxoxkXjaIxH80pbaN53adGlWbVecoOcCMCA0lCIUGiLSIPrm5kkMcCuyLrbxTsso11rF7zFG62F5JGWTP9JpxoVLQXEPQe+midvRVkSBpxT21Lmn71IzAD8ul1xy/Cb2voqvbl3RvADPqt8ng9RwLXYwO0D8LMWyPlQUEcO+7TjwfcbljZbGONboUFAfrkRG32QM5uesE3nHNpovqdwv2vdujmxI+7cNxvbpqvOQ0ePbJaBGxD7ZsajZz2tc+tX+YG9pWb5oKwNWOsKTiQVsuGt9WinR6k4M5E8czl7GKlk1wHce0+LZ6Kx99QAjTRmwRTndpFRJgGLMTa6YshL6hFeY0jg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(376014)(1800799024)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: H+HXlAGzH+E6Y6FALjG37EspD3sXBhQ0DxHqyRialLGW8yjra4zZIkD0G7dQVTCHLJVGjOVgrUzBXFxEHu50tY6S5oES+Mfy64hRWWVruvC4eb3uPsMn+jscogbJzbz6LAhuBA+HjnBNK72nvjrfJxYLMLTkXNr03gGJujBa90BaioxF0IJUZErehrPIciRrIGfmtj2lyo2LM7Y9+c28MD/eaNOzHmKKPSC78dzlxa6YVy4WQvpdhEB7CRKj4pEykorGybHnnzwA3jhFQLdniuSjEJGjbIfqqr3NLQALhEb1lBriLTgHg2Ig85MVU15PMNlb7fsVq8YxZzZCDtox7M6AAjleuaWGUy6qHgEtCAC9mGG3xgydc5ZZfi6/vA/MMTW1imsuyraetPlTSfGLCxFDyRf2KlF7hKftiYCYLTQ9gbmIWnYTw1KzNj6gUICf
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2026 07:34:16.3371 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 14dd4942-5d1f-4f91-e5f4-08dea42f62fa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCC5.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6318
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

SMU15 introduced driver messages that can carry multiple input
parameters and return values, but callers still have to build
struct smu_msg_args directly.

Add common SMU multi-msgs helpers in smu_cmn and switch the first SMU15
users over to them. This keeps multi-parameter messages and multi-return
queries on one helper path while leaving the older single-parameter
interface unchanged.

Patch 1 adds the common helpers and updates the shared path.
Patch 2 converts the SMU15 base table address messages.
Patch 3 converts the SMU15.0.0 table transfer and enabled-feature
query.
Patch 4 converts the SMU15.0.8 enabled-feature query.

No functional change intended.

Yang Wang (4):
  drm/amd/pm: add SMU multi-msgs helpers
  drm/amd/pm: use the SMU multi-msgs helper in smu_v15_0
  drm/amd/pm: use the SMU multi-msgs helper in smu_v15_0_0
  drm/amd/pm: use the SMU multi-msgs helper in smu_v15_0_8

 .../gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c    | 47 ++++-----
 .../drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c  | 38 +++-----
 .../drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c  | 14 ++-
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c        | 96 +++++++++++++------
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h        | 22 +++++
 5 files changed, 130 insertions(+), 87 deletions(-)

-- 
2.47.3

