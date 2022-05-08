Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E9A4C433EF
	for <amd-gfx@archiver.kernel.org>; Sun,  8 May 2022 17:30:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8683A10F236;
	Sun,  8 May 2022 17:30:35 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2049.outbound.protection.outlook.com [40.107.212.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 82A1610F236
 for <amd-gfx@lists.freedesktop.org>; Sun,  8 May 2022 17:30:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VbUQEaJSx5YAjxTS3E7F44xsM4bIFuzxUtcCcQbu2G+x13x9txs0S1aZdIZnGvVk09CwrOYk0i/BGGdeJqMZ23/TYWZ5ZoglPJ2w27nKlEOexVCJ5Ll8VJlAavf7n8BVPid1EkhviL81k427v0mf2LAJncBi2m5wYlajuYOk1FHcZ17XR5ixHopTue4B2GRqrmNFNGvfQzErUjMj1fGzcMhgRfDHJ6mXhEVJxgGSh8p0EdGI6b954AAHil4xDtaPfRAOeyoZ/R48wwroNTZLjZ/wRIWKWndigXVYfpbZitu0qLTeWgP2Zx219CuVqmVJT59sqesVUO7dF/rxYW3BwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Phdftzj4qeYt6IoxUL4lu2uvUO7X19Cd6rW/TI8vQLI=;
 b=amv4FSVylljnBZpDLtVDi74ea3Fc4bDP/g5dNigjj86Ek5J83lJVCOTaR/nZ+MW+j13k1shnVrnxcLUjLY4yhqhtXxS//2CBuHamAMzG+W4+da/tne8aCdcUmYdzpI3nNuK18WaizmTsPKb+RglmzOgS+RwIxxYLN9oFpUOY/Kp68838V1NCwMdsLZyfZbSo7gsqKx1zM6+OFxrsDrR5+XrMscDhkhCe2HfS+CdmVCyGWonlvnxIkaCymWyoMivKSlhldlZO+ULWn3yWXmHpcBl+RNV1f5GKTzCm7d+zE0XLZAu8RMr2cRLemazgHFB1UFtvcWnEsI0w59zD/n2wOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Phdftzj4qeYt6IoxUL4lu2uvUO7X19Cd6rW/TI8vQLI=;
 b=r6mCg8gnG0hVryYQkJ5hYHdX8nfiveuSaEFLT5IXOVmt41BYFRazeDkWDKARs3bGXa5n+tjoDsURHxMzbWlY5+sB7QYU05esW36gnLRfAD5pTBXFqKwkNBOrMb9SYUm+Mr5vV4wUuLsTnR5eYCJUbPUCyUghMxaSmFrIlDcyKUA=
Received: from DS7P222CA0005.NAMP222.PROD.OUTLOOK.COM (2603:10b6:8:2e::17) by
 MN2PR12MB4256.namprd12.prod.outlook.com (2603:10b6:208:1d2::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.20; Sun, 8 May
 2022 17:30:30 +0000
Received: from DM6NAM11FT030.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2e:cafe::9c) by DS7P222CA0005.outlook.office365.com
 (2603:10b6:8:2e::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.22 via Frontend
 Transport; Sun, 8 May 2022 17:30:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT030.mail.protection.outlook.com (10.13.172.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5227.15 via Frontend Transport; Sun, 8 May 2022 17:30:28 +0000
Received: from jz-tester.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Sun, 8 May
 2022 12:30:28 -0500
From: James Zhu <James.Zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu/vcn: fixed no previous prototype warning.
Date: Sun, 8 May 2022 13:30:08 -0400
Message-ID: <20220508173008.281673-1-James.Zhu@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a5f13d23-8f7b-4001-2b8e-08da3118722d
X-MS-TrafficTypeDiagnostic: MN2PR12MB4256:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB4256D7C2A4B3F27AF63FA93DE4C79@MN2PR12MB4256.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LVG2jiSLDOA4JVCwykYw9iKp4FncINgf5mIkONgzbnYAfIVKMURuHRB5A/Z0j5Iwnrep53q+4FknKR7lYVDr+04yOeW3sDCcIHA4mGqM4Mn2SS+dSHlKTi2E2l6WFa1FlrPDv8OIOWOEQ9TTexpFcT4ygVkVZgZwPWqYTiqxdH1BSZEcfqZNNpnx8IePUI9bnqjJvNiSP6A13MsMaeWeF3tEOZZsNeb01jQsG1V03ssv4kCcef+O18zdi9CSuGLiWINPr/gl+Q/h0ZH9XhEHPv9JohBYuCl5q6/FUv3JKP0ZOazWpJi93PNkxZ+50SjT0MN5TUg+bvlUKsjWE6u8z26DPVeVnG2JGvM2QzJYmafA1W9t5p13N+ReWhiBUSZz2fxG595Xw712zB8eBkGjyv/Yi4EQtygiFEEdiADVF33NtDlKlQg8D21/nVAuiKXojjndtiVtO18GNddH3Kc0FDf6gNZ7KkpGetRlIz5qwpriGET1eQQNpUog9IDHShyErHV5sXdZFSJF8+KL9IcCqpblFoHoWNOjUdDTWQzJ2h2SUlK/WMlzqLsSYyidGyL0DXIoywmxHGqCJW8rqTY/yYsWCKaRtz70tMFSNBFF+887e3b4JFyUFnjwVoz2HCb61TrE4NJTYsNHwyVdGDYZgs/mdT9SVMrtgztbjbHVFdavj/ujkw52E8SzoycMIsmn2WnBIvvn+3pc4paW15r/tg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(508600001)(36860700001)(8676002)(40460700003)(356005)(81166007)(70586007)(86362001)(4326008)(70206006)(316002)(2616005)(6916009)(26005)(6666004)(5660300002)(7696005)(16526019)(426003)(186003)(47076005)(336012)(2906002)(1076003)(83380400001)(4744005)(82310400005)(36756003)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2022 17:30:28.9948 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a5f13d23-8f7b-4001-2b8e-08da3118722d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT030.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4256
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
Cc: kernel test robot <lkp@intel.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fixed warning: no previous prototype for 'vcn_dec_sw_ring_emit_fence'

Signed-off-by: James Zhu <James.Zhu@amd.com>
Reported-by: kernel test robot <lkp@intel.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_sw_ring.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_sw_ring.c b/drivers/gpu/drm/amd/amdgpu/vcn_sw_ring.c
index 08fd61622f95..1ceda3d0cd5b 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_sw_ring.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_sw_ring.c
@@ -21,7 +21,8 @@
  *
  */
 
-#include "amdgpu_vcn.h"
+#include "amdgpu.h"
+#include "vcn_sw_ring.h"
 
 void vcn_dec_sw_ring_emit_fence(struct amdgpu_ring *ring, u64 addr,
 	u64 seq, uint32_t flags)
-- 
2.25.1

