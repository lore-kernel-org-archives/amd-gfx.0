Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80763C4345F
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Apr 2024 14:28:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BF50C10E26E;
	Fri, 12 Apr 2024 14:28:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rZge3p5W";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2068.outbound.protection.outlook.com [40.107.93.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9D0CC10E26E
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Apr 2024 14:28:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IIGJfNyq8v2YCSopuaHBtCWNoDF2zh1yIuy3lSTLGOYRuDg9+rUYDomZGejBHsDneNsGv1ktcFQ4xEKTNzG9yR02D65lfLRia4O7v/U73LtpJkCh1eRam2MhBjmVjGDs7CUl9YNFgNKC9AoLlKwRY+I7HhlKhAkq2XAAIN1GKLxqeyvoV+jN8RMc6Yjhnx5NF/nS5z2IUY/4gi1cDTJLWrBUJmrSHMj8Ra9YWebPXqCgJAHO5mDoB8WZG6kRYTW/YRIrapiMi5lmE5PmyMorUHkUY8whnr75rObfUcxUnU+ZcMlKZMDdIB/Y4kQwkNYbla1CQ91zBNsR1S4jOX3Dkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yfnYxcPWZZlzcGeVdPFjHQDpCTud9S8akUOYRd/TxgE=;
 b=GqPLeZez8b6SseKdDOsEe/OGUc4lCuM+zObxymEJnztGKRaaZTkZEAIMnLV5XLWZjkO+SjumP/TqfPrY+f2b8pMoBmRh9mGoavidJ+d/gkYmZOvzCqYcYmqMLZ42pQB3EW13ACKg2j3m5v/XHiI6bd7uDir48B8HO1wJ600i1fUf/RazKjPalbjzc/wQ0wGEPfg/1pqP8c5xb9RfULx2kOr3jH5HnuynTlUwiy7QUg5q+3WVQVEdzxPC54UMXqFqUFvrZxwJ5z5CmbBZuOQJdecdIgAturgBYIUPKGCozXwF3+mDNDWF68BEmi43jvlaGGI4BugVcxn0Sd9mw0pjQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yfnYxcPWZZlzcGeVdPFjHQDpCTud9S8akUOYRd/TxgE=;
 b=rZge3p5W31oQ6SqrUbPgyzVDUjPfXDk9VFcBGw2PjCsCXgHBnwjio9/zzqnjYS1obuCNMIngS/XGoUPT+3OVO6OBn+wSpbkiF2y5jzj73xjvfDmgymY66qU4nwWqvcy9W5LhMoMR9F2WL/l5iNbjk4AAh87qkBk7KNGTTy02ruw=
Received: from SA0PR11CA0154.namprd11.prod.outlook.com (2603:10b6:806:1bb::9)
 by MW4PR12MB7383.namprd12.prod.outlook.com (2603:10b6:303:219::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Fri, 12 Apr
 2024 14:28:35 +0000
Received: from SN1PEPF00036F42.namprd05.prod.outlook.com
 (2603:10b6:806:1bb:cafe::1d) by SA0PR11CA0154.outlook.office365.com
 (2603:10b6:806:1bb::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.28 via Frontend
 Transport; Fri, 12 Apr 2024 14:28:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF00036F42.mail.protection.outlook.com (10.167.248.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Fri, 12 Apr 2024 14:28:34 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 12 Apr
 2024 09:28:33 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, Jeff Johnson
 <quic_jjohnson@quicinc.com>, =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>, <keescook@chromium.org>
Subject: [PATCH] drm/radeon: silence UBSAN warning (v3)
Date: Fri, 12 Apr 2024 10:28:19 -0400
Message-ID: <20240412142819.2379934-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.44.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F42:EE_|MW4PR12MB7383:EE_
X-MS-Office365-Filtering-Correlation-Id: 453b168e-322f-49bc-1a40-08dc5afcd59a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6S3kMC+0Cgrz9cJpN/I+EjQgVQ4gc34fGhuKu91EwN2bp52p9oTQQLl0j0jnfURNaMBUBqCtZzvZ0EXpSatvR70ByUqQ1BDjkv4aCTsRdkuBOejwEBsoGR3/CoeLnAGTWCbKeSog47qVrztL94lKZ/+QkNxiCVntXYR++qihR70iZbjBlrPiHYeGMA6L8cRQP9I+d43ZvIDI1M9GbFgTjyobU28Chh4BIgbhaMIi5c3agOvHk0pBSlFWC53+W6q59FLMSkMsxFO9YiYCp8mNi2iyBIV7zQy2v5UKAFECc4PdnxQV339wkUakzOKLGuYS/Fg5V0LAUYVYmYAdX0mJgyQVsuOn4yZYSN//k6FT4JrjgjZKCtbtfLocTEuhIDf+6myARA3BCsFV8tScw9mroQfzyxfmJ7Iwj7v5mGrZy7ofCRWEthL7J8yBdY5uR8Klvou+jeWW2Zg82bqIoisBKqkZg8ELr9tUnzl7EhHsj6LCfLu3yubzghld6IBgVn+HFgosW20dSlFKVBNUKdZdTPAQeiVRITG04ummEaQ5MiEjVtk49o25r3a4v60PWKPGBZ9ueQrVvCn7yMR/v2Nbz7sFlNmrgCR+/kY910yg2A55X5Lw4lf11NJnh+QakcNDJ7n19bMdmW+VetGnmamMJggvG21mLJzE0HoPXglFVsOJLAopZhvY1ibkVTOuGQFTF8PbqqWvTfgdPJ/sWpIfl04xUujaoUxPfR/3EaN7JOMNS4jHMECMTGqc4R3wree9
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400014)(36860700004)(1800799015)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2024 14:28:34.1203 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 453b168e-322f-49bc-1a40-08dc5afcd59a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00036F42.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7383
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

Convert a variable sized array from [1] to [].

v2: fix up a few more.
v3: integrate comments from Kees.

Tested-by: Jeff Johnson <quic_jjohnson@quicinc.com>
Acked-by: Christian König <christian.koenig@amd.com> (v1)
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: keescook@chromium.org
---
 drivers/gpu/drm/radeon/pptable.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/radeon/pptable.h b/drivers/gpu/drm/radeon/pptable.h
index 94947229888ba..b7f22597ee95e 100644
--- a/drivers/gpu/drm/radeon/pptable.h
+++ b/drivers/gpu/drm/radeon/pptable.h
@@ -424,7 +424,7 @@ typedef struct _ATOM_PPLIB_SUMO_CLOCK_INFO{
 typedef struct _ATOM_PPLIB_STATE_V2
 {
       //number of valid dpm levels in this state; Driver uses it to calculate the whole 
-      //size of the state: sizeof(ATOM_PPLIB_STATE_V2) + (ucNumDPMLevels - 1) * sizeof(UCHAR)
+      //size of the state: struct_size(ATOM_PPLIB_STATE_V2, clockInfoIndex, ucNumDPMLevels)
       UCHAR ucNumDPMLevels;
       
       //a index to the array of nonClockInfos
@@ -432,14 +432,14 @@ typedef struct _ATOM_PPLIB_STATE_V2
       /**
       * Driver will read the first ucNumDPMLevels in this array
       */
-      UCHAR clockInfoIndex[1];
+      UCHAR clockInfoIndex[] __counted_by(ucNumDPMLevels);
 } ATOM_PPLIB_STATE_V2;
 
 typedef struct _StateArray{
     //how many states we have 
     UCHAR ucNumEntries;
     
-    ATOM_PPLIB_STATE_V2 states[1];
+    ATOM_PPLIB_STATE_V2 states[] __counted_by(ucNumEntries);
 }StateArray;
 
 
@@ -450,7 +450,7 @@ typedef struct _ClockInfoArray{
     //sizeof(ATOM_PPLIB_CLOCK_INFO)
     UCHAR ucEntrySize;
     
-    UCHAR clockInfo[1];
+    UCHAR clockInfo[] __counted_by(ucNumEntries);
 }ClockInfoArray;
 
 typedef struct _NonClockInfoArray{
@@ -460,7 +460,7 @@ typedef struct _NonClockInfoArray{
     //sizeof(ATOM_PPLIB_NONCLOCK_INFO)
     UCHAR ucEntrySize;
     
-    ATOM_PPLIB_NONCLOCK_INFO nonClockInfo[1];
+    ATOM_PPLIB_NONCLOCK_INFO nonClockInfo[] __counted_by(ucNumEntries);
 }NonClockInfoArray;
 
 typedef struct _ATOM_PPLIB_Clock_Voltage_Dependency_Record
-- 
2.44.0

