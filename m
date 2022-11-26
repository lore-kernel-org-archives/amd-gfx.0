Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A332C4332F
	for <amd-gfx@archiver.kernel.org>; Sat, 26 Nov 2022 05:25:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 48EB110E105;
	Sat, 26 Nov 2022 05:25:47 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2047.outbound.protection.outlook.com [40.107.92.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6542410E105
 for <amd-gfx@lists.freedesktop.org>; Sat, 26 Nov 2022 05:25:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bz8zsk+4wqObjqkp6h3AaLRVGXhVGJedBrFFJqLvygf9QKCvNqTRuepMdsghOn6qln6tMBeaeZ04SCnOkHfHABYlSPAxlua5IWT2bLEj6TYaECAMZOXu/OHJDeyh1OVevvsyWE16j35if+RXdaW10NpFm//+iTlvUnNjUWnM2fQUJ54ibUWbwLc5b220PIlXdpXUIidT4Wc4Ju+rj82/233CmDOvN3QFhsUAzfe/FjW2dG8N+PWxa/Ft/sNQrFXqj0qK0bT1uJxVq78+KWKlcvOx0gb58Cf/3q6CoaoDC5WU0B5q7mWx7XC6d0KClxUWK0pqBaMCwFxvfGGz8GDhtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dQ2nnmCFEkMa0Sk5/9d8fcxgEwbqRZl/OHaYwAceHpQ=;
 b=e/5EupFdrs8LAXL8r8rl9cuMkkNG/KBDFY/IWBAsLDK4v+HY4c8d7Er8qujCLg6r8CbEm0oCXohO8cvbL5QPgSG1h3Mn93w/j9QKvVszjmotVWREiVJobXoFlpY+uihyiRk1SykG/Z8iijvZ0xOV1N/fp8fIqxctfVMUV4JcKmUEFW8S5CLiTcp0ToZTwG03tw8388RbKLiW4Zqq1Y9vKlTxSsaOyzzYSuIaCLfSODdxlpcYx8c4bRnfbn+eiHx8Jdxq8MZDsgTmsUl5rETRdK39fCWYsVFHqD1fuCbZkn2tcAkk4ZLn+Xxzbc2ceG6PFNEOk3/7bgwFam90xjID/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dQ2nnmCFEkMa0Sk5/9d8fcxgEwbqRZl/OHaYwAceHpQ=;
 b=RgHt/1KxNc9XbKVi1Dd8zKGJiFmom3xQYMMDV8im6oGBp1e1Hyi3CFuQVCqSJVnI43b5H3CnroJQNXMdNoK273HkaqPjuCnU47WlcgABnwQRHZJJsAo9AmnZzawxFyL6CKW3TzKHgADC4Ov0o4ng+lFxyNCS9G9vvz91Wzd/Hi4=
Received: from DM6PR08CA0009.namprd08.prod.outlook.com (2603:10b6:5:80::22) by
 SJ0PR12MB5661.namprd12.prod.outlook.com (2603:10b6:a03:422::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15; Sat, 26 Nov
 2022 05:25:41 +0000
Received: from DS1PEPF0000E640.namprd02.prod.outlook.com
 (2603:10b6:5:80:cafe::79) by DM6PR08CA0009.outlook.office365.com
 (2603:10b6:5:80::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.20 via Frontend
 Transport; Sat, 26 Nov 2022 05:25:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0000E640.mail.protection.outlook.com (10.167.17.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5857.17 via Frontend Transport; Sat, 26 Nov 2022 05:25:39 +0000
Received: from localhost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 25 Nov
 2022 23:25:36 -0600
From: Luben Tuikov <luben.tuikov@amd.com>
To: AMD Graphics <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Fix minmax error
Date: Sat, 26 Nov 2022 00:25:05 -0500
Message-ID: <20221126052505.61384-1-luben.tuikov@amd.com>
X-Mailer: git-send-email 2.39.0.rc0
MIME-Version: 1.0
X-check-string-leak: v1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000E640:EE_|SJ0PR12MB5661:EE_
X-MS-Office365-Filtering-Correlation-Id: 29ecc559-2156-42cd-ed23-08dacf6ea7de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vRhYVsdUZO466sGRSep7EptlPCyPlb5TZk57OEep5rMN8dJgf0vZQtG/dlH5Oayu8eRCAfNwhlf71Ms2yDWhK9Q7R/52f0OQ8i4HVb5+q02Rn/n4fFgmjg/LlzWcWWg8LFThAKp355XeNE9a1aciP1Zh8bDvuRKUbuJloa/Lbpg3NqAs+G+uhlWdElXjwzJkROOGeF90pwl6KSI8sTMY5gnxeM7AeoGgpcSMqdT+emf3O6nZLJ3AIImYZZOHunovH0/SoXbF7myb5GzTZEuTdkQw1qUPbscPxpsltUPpt8ZHe5G0Va+DmE3M8QLeq9s0mmE7d1ZMlDTuzF9Su9xPxQCU8cM3hWanKXDl+2v34JuivIbM9AcUk7gzteZROuJ3kdGSHUg5jAtKWBCueg2Wscul91py/WbEZfToMV8EAynwjwuXagPqi1+73dsq+Z/SKlhH7q709p407s56Ou6p/K2L0LwivlscIcwGv3OSxJhU4qda6l97KfEwQ3/EDZCnJ65USFbeheHQVHVZXRxS8unyMD2NUBKJ/4ChtDHLxtqvKCbjL92KvKc5vTQTTW2E5v+CV/88SyhxiuMsgkXSqaR0dLSKdhWoNQtuTC3DW0TpMZc1uAIATK3g3rkmRExgO0vAeSwe3nY9WSIK5eunIuy7f6fEEX3KlzDEsB+ej4CL420vg6t2TzUDjlI8GWBzkIJ4cwMIUhYi45yMK8mQ0GyHD7MCYsctuhwt74Ly9Rw=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(376002)(136003)(346002)(396003)(451199015)(40470700004)(46966006)(36840700001)(36860700001)(41300700001)(2906002)(4326008)(36756003)(83380400001)(47076005)(8936002)(8676002)(186003)(16526019)(336012)(44832011)(2616005)(5660300002)(1076003)(86362001)(82310400005)(40480700001)(82740400003)(356005)(40460700003)(81166007)(7696005)(316002)(54906003)(6916009)(6666004)(426003)(70206006)(26005)(70586007)(478600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2022 05:25:39.5478 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 29ecc559-2156-42cd-ed23-08dacf6ea7de
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000E640.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5661
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
Cc: Felix
 Kuehling <Felix.Kuehling@amd.com>, Luben Tuikov <luben.tuikov@amd.com>,
 James Zhu <James.Zhu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fix minmax compilation error by using the correct constant and correct integer
suffix.

Cc: James Zhu <James.Zhu@amd.com>
Cc: Felix Kuehling <Felix.Kuehling@amd.com>
Fixes: 58170a7a002ad6 ("drm/amdgpu: fix stall on CPU when allocate large system memory")
Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
index 8a2e5716d8dba2..65715cb395d838 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
@@ -51,7 +51,7 @@
 #include "amdgpu_amdkfd.h"
 #include "amdgpu_hmm.h"
 
-#define MAX_WALK_BYTE	(64ULL<<30)
+#define MAX_WALK_BYTE	(2UL << 30)
 
 /**
  * amdgpu_hmm_invalidate_gfx - callback to notify about mm change
@@ -197,8 +197,8 @@ int amdgpu_hmm_range_get_pages(struct mmu_interval_notifier *notifier,
 			hmm_range->start, hmm_range->end);
 
 		/* Assuming 512MB takes maxmium 1 second to fault page address */
-		timeout = max((hmm_range->end - hmm_range->start) >> 29, 1ULL) *
-			HMM_RANGE_DEFAULT_TIMEOUT;
+		timeout = max((hmm_range->end - hmm_range->start) >> 29, 1UL);
+		timeout *= HMM_RANGE_DEFAULT_TIMEOUT;
 		timeout = jiffies + msecs_to_jiffies(timeout);
 
 retry:

base-commit: 9e95ce4c60631c1339204f8723008a715391f410
-- 
2.39.0.rc0

