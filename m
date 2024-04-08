Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5CFACD1292
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Apr 2024 17:38:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F0E6E10E1B7;
	Mon,  8 Apr 2024 17:38:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="lGcjIihZ";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2050.outbound.protection.outlook.com [40.107.236.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1646110E1B7
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Apr 2024 17:38:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lwNmuyJmEIMD1Su7BdwiBxG3LHPmUz+Mv+DG1zg/CNKszj2nP8JNAFEEWEpZWs1pKuDwyV85peWiuSd5XlDZsmuX6wMVNNnJBv3BfganJQgV3w6asZjdlmkPjFj6pKgvZS1BA3esrzsvNZ/G/pfjVN1j+kvHldTu+D4iRBTuz7w6APzR+dUfct7qlEgcsSEbwrGFE5oJu442xWQQWbhMcSBJMCqN5qk+qxxlOMptB3Krzp1i9S0C4q+1oMIsTNq1nweW3i+NpnTIhmmzE08WZU/sqdMmjBWuDpIsQWrB/raoJl4+xEutYRYaNP4gWLAepGaCMBCADx/QNg1rD5AXYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+b8lUt7F4oZs3L9ABEUg9Xbr/pc7FrUiJ5wZdSqBpg0=;
 b=U54k/bH2629hc8Zf3VrmbPVCgrIzgHHbCCXKNJEC47/uq7knpi+uzkN8NeKZ7xp5HI+zniSyTMNMIsXIVzi//d9Y7ZaPb2cRnq9L1eEnHgUL4HHAu9vxl0hOXTS38DcGlAMyUc1QHuGOhE0Z3c/Z09g7yU1Ha8YdbiQMwGHJJsat344tZNnCUn7cPp+AOOsVHxMh8X75OgyahfUoAFIq7X5fmdRWjTe4YneeWWqSmMFPaovs3+0tSLvl/rg5kNdnmlF8N5hLeY+kXAWiRRY8v5NmyBBlV2lW0G2rH7pvMtDB53rOfgRLtT4Oj2SmuDiVVDNbX97LSjhvF6UQk5mpEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+b8lUt7F4oZs3L9ABEUg9Xbr/pc7FrUiJ5wZdSqBpg0=;
 b=lGcjIihZCh55n5MvwAYlMCtahBj8SzSYIeKAkVRU0DAytYWUWwTcquJCuUivdE+OtVxfeoH9OAuXcNWVQQYq0kOZkNkQIpWevNryjFSO9Fl0kTS260Rhg4Jp3O57P5LNnHt75BqN/Aii3pwzXf59LmY+6Bj0asnqMk444pRfIwk=
Received: from MW4PR03CA0223.namprd03.prod.outlook.com (2603:10b6:303:b9::18)
 by DS0PR12MB8319.namprd12.prod.outlook.com (2603:10b6:8:f7::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Mon, 8 Apr
 2024 17:38:16 +0000
Received: from CO1PEPF000042A7.namprd03.prod.outlook.com
 (2603:10b6:303:b9:cafe::49) by MW4PR03CA0223.outlook.office365.com
 (2603:10b6:303:b9::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.35 via Frontend
 Transport; Mon, 8 Apr 2024 17:38:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042A7.mail.protection.outlook.com (10.167.243.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Mon, 8 Apr 2024 17:38:15 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 8 Apr
 2024 12:38:06 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Subject: [PATCH] drm/radeon: silence UBSAN warning (v2)
Date: Mon, 8 Apr 2024 13:37:48 -0400
Message-ID: <20240408173748.6598-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.44.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042A7:EE_|DS0PR12MB8319:EE_
X-MS-Office365-Filtering-Correlation-Id: e8c4a3c4-6133-4007-2f99-08dc57f2ac06
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1cOfhkr72L38QHZYvbDjBmBbMmG9FU+fqXzUsrsXcijrZnpDecBCgI0P4CbkVBRo3kpIpf1Mn3LA0n3nQL9mxEN+j5CR/s99YWaqsBrPFRiIFhj4hSFhV/dbcaoX9OwAH6Jh5LSJWRpMCGr2V9NwFFeTt06oqVx4gsKgy7t2Ayq3No+3jarHeCpCcEfvNiZoEtC9U7toap3yCgGc+y5AlS1K41gplSCStWd28WrAJEnwjz/Jfwc2fRNPbs5I7exCfxKDUNZ5Rh2Of/LBIYbAMl6h+5DIykEeyClnOJhgAzYHOUJ0TIHyXf+S+q17zg3G8FTNCzrb28J/WnPwWruEbPCudwykHFXGf0rh5/U4MseoGAM2ISi8Uj9PENXTApRguvcFvVXSnpFHic4eM5rf+D8NN1VTdk/aaaWJDT9RluWpzmhaUVVo8dopCfO943UuG+NzA89qWgTZrJaHah0AnMoRmsTpIuv0C9KVl0FBxzubRLVQJsj3c75tGv40j4LdKYUC+lFzdZuLs7TZuN9nk6G3tOE7j97RAs4Z5j5ehRWhWuEcLQGwydITdkmuIpb1Hnl3Q4w+g8KKAi9bVb+xOAII+7kYUsY6tZz9s/HD5H7i9lM+A4SacTU+9w4uquFfnshzpfaHGKnVs32T24PyFESkH12yZM9qShA+Si1flg9t6AtfejEK5Rv3jJSktNsQPvRB4oPktwv/KK5ZQJvrUvXFTKXpQijiAdlPlLa2o366dTmPV2PaEYl4QHvrttwR
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400014)(1800799015)(376005)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2024 17:38:15.6587 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e8c4a3c4-6133-4007-2f99-08dc57f2ac06
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042A7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8319
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

Acked-by: Christian König <christian.koenig@amd.com> (v1)
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/radeon/pptable.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/radeon/pptable.h b/drivers/gpu/drm/radeon/pptable.h
index 94947229888ba..3493b1f979fed 100644
--- a/drivers/gpu/drm/radeon/pptable.h
+++ b/drivers/gpu/drm/radeon/pptable.h
@@ -432,7 +432,7 @@ typedef struct _ATOM_PPLIB_STATE_V2
       /**
       * Driver will read the first ucNumDPMLevels in this array
       */
-      UCHAR clockInfoIndex[1];
+      UCHAR clockInfoIndex[];
 } ATOM_PPLIB_STATE_V2;
 
 typedef struct _StateArray{
@@ -450,7 +450,7 @@ typedef struct _ClockInfoArray{
     //sizeof(ATOM_PPLIB_CLOCK_INFO)
     UCHAR ucEntrySize;
     
-    UCHAR clockInfo[1];
+    UCHAR clockInfo[];
 }ClockInfoArray;
 
 typedef struct _NonClockInfoArray{
@@ -460,7 +460,7 @@ typedef struct _NonClockInfoArray{
     //sizeof(ATOM_PPLIB_NONCLOCK_INFO)
     UCHAR ucEntrySize;
     
-    ATOM_PPLIB_NONCLOCK_INFO nonClockInfo[1];
+    ATOM_PPLIB_NONCLOCK_INFO nonClockInfo[];
 }NonClockInfoArray;
 
 typedef struct _ATOM_PPLIB_Clock_Voltage_Dependency_Record
-- 
2.44.0

