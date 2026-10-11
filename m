Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8C58CA9EC5
	for <amd-gfx@archiver.kernel.org>; Sun, 11 Oct 2026 02:50:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3752D10E262;
	Sun, 11 Oct 2026 02:50:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rOs/4Ril";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011036.outbound.protection.outlook.com [40.107.208.36])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CD76810E262
 for <amd-gfx@lists.freedesktop.org>; Sun, 11 Oct 2026 02:50:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=njDfyWlRwz6YNyfBDurdtBianimaXW/w5YViyzit0oyzAKL+2nWn/8dYQHkCLhrY7qhTux4mySJoEipiJdkiuVc6Kmg204Won3iqu8d4MoU/q3VqkjT6Z9QHKMPiRQjCeNNzKaVU7qBVMUTJUl0ceUG6w3C40spee2jE+rmj6KJG/+wcLWFeitB9/Qq/nLTVYSiYBW9n7RXjo7sy3FoPbIAuKjzhNxD6dLkS3hfsU+d4vv+x4jYOTpg8ljNhDWOOVkSDM8vGnivx/vJAPypPsnf32eHMMIrNedhlNHkJ8w6dgLbY1wEF8+qSvg48V+1GS3dx5lJejn4KNf/K15dAQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6I7P4tG8x/pr6jCouKXKQUFiZwmjTGavwpze1xRLdsQ=;
 b=tvpUk+3y+GW56FVQFaBoRClDYmrA105ereD4JXIKZHpwPvanksTTaeFXZP+PyzEIHYY61UCvR/nRtOF4bDEKnOf0GiX7NQyv0vTAt+J344q4ajSmvYdy3IQcpAzq48SEJHuPWHSRxocPAzDCoxARKvUTyFFdxcqkzTMapFbb3OWby06cOHX5ZQTwd/fZ8dhfo9bmatO66k9ch2Iolz6AWp1A9v4RYquWWQqEJpwnAB+JrcZHTOIn7htAG0g2YdfCOq6fNDmcH1WfcZFTcvh3KveGQ2oaT0SdaXl6F1nyFxxZO1+H4U7KIp+3UePKoDqlsHA2CBVqTxlqq2IZ8n7k+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6I7P4tG8x/pr6jCouKXKQUFiZwmjTGavwpze1xRLdsQ=;
 b=rOs/4Ril78R6Xj2K+/pIYwAYKnf8tH3334OSbqhos0bLR0P1NVScjDRO+tlLkOjg9zvOLsDAG4npRL5mApQD4OMTtUygTTOLlSgMLKImsdYYs1D53p0r8xSyI7SSU3CaYX9spVEGF2nOpgK7/7y90YUsnsainhQWgN/saJFOwk0=
Received: from DM6PR05CA0046.namprd05.prod.outlook.com (2603:10b6:5:335::15)
 by DS2PR12MB9566.namprd12.prod.outlook.com (2603:10b6:8:279::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.20; Sun, 11 Oct
 2026 02:50:43 +0000
Received: from CY6PEPF0000004A.namprd03.prod.outlook.com
 (2603:10b6:5:335:cafe::95) by DM6PR05CA0046.outlook.office365.com
 (2603:10b6:5:335::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.4 via Frontend Transport; Sun, 11
 Oct 2026 02:50:43 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY6PEPF0000004A.mail.protection.outlook.com (10.167.247.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Sun, 11 Oct 2026 02:50:43 +0000
Received: from sunce-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Sat, 10 Oct
 2026 21:50:35 -0500
From: Ce Sun <cesun102@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <YiPeng.Chai@amd.com>, <Tao.Zhou1@amd.com>,
 <Stanley.Yang@amd.com>, Ce Sun <cesun102@amd.com>
Subject: [PATCH v2 2/2] drm/amd/pm: move smu_feature_init to smu_early_init
Date: Sun, 11 Oct 2026 10:50:32 +0800
Message-ID: <ca5dad38aae9c016226a52d0d0ac0a0569a42b81.1791686882.git.cesun102@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1791686882.git.cesun102@amd.com>
References: <cover.1791686882.git.cesun102@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY6PEPF0000004A:EE_|DS2PR12MB9566:EE_
X-MS-Office365-Filtering-Correlation-Id: 462afec0-299c-47d3-1dcd-08df27427199
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700016|1800799024|23010399003|11063799006|22082099003|56012099006|18002099003|6133799003|261009223027099003|10067099003;
X-Microsoft-Antispam-Message-Info: n5JLUatZ2BdVSkWUGVB6fgIJmy/0c96m+zcFtritayWcPaMSyq2PKRr64sLZL9eCmFVj14SHspFrP5aesC4h6sphAvnxGRu1xSaE51f6naiuAI1z1D7ult4ZTLBGxBJnRx4NPR6mrtow1Jlj6DZbsA7ZMg3gmKIt8ye0KxFcljVsGPkDKtcmZtCogXhJOQ/b6I3RM/ABA0Op7f7A2O3P8b6RNngfD9TxDQ3N1R53WotOGmYNPwYcfk/VbGY+lHRIYwnP3KHJZUX/F1xaUKCqziuMdLgtWISxETa3OIsbb5UphlURmokL8MBte+pexvFwAHdeF3MVNk+ev9SVs5A2QqTbfdB3dVRwaIbdKqlu//3rBfR28EwJwydcQBEvGoCjwmSPe/C7X3K4asih8AHN5XKLso/RSW33dEkmv+cilmK05q+ppWMXoPkmmy2Z+3As5Rx4rG+3OQ3ZXJnjeUhdeD4MtWHCHAaVIfOxvs5qvx5P8H1osIW9BY8gbsC8mrpYLAhQJqvePHJFxnnb7Qk8irzISKKMmTXhKWY7b9MmxdZPpPFcYtEAyLOpSkNdtH7GRn2OFGzZbsYL9LABR2z7tw6W47ofAEPGbcPJH03T1yDv3U7AWZ+NvC/3JFPiUnhaMdJexRmeLjeQtpfhDqUd4cG8P1RbSVadk6flKAYM9EkjmAm57/45h8G4HzGkNe3K13aX3B4ul0ORbrUxDeaGRw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700016)(1800799024)(23010399003)(11063799006)(22082099003)(56012099006)(18002099003)(6133799003)(261009223027099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: CJ8Mn9tYAtDMcdU0TsF2e0GznuxsdNn3/BmQGOrdjJE0n4Ez56Fuoe5d6q7lWk38FkfVcZY/uD+ADAvDckyaKxPacZuHNzuWahWMgmpAtd7sy+02yDCiZ/wP6Qqi+x3TfLIBAIZ0/AK3ViVk93ztoS5tjgdHwDGL7gDUSZDcsSPOi9SN0g63tRn5WeR3ZAA1ZqTq4zNzarpYb9qCsF7BA3bM02wW22nl52/LeJiTFgt9iYj2a4vrpjedZJUvaHGXHUBtThozy/UoHwzF+e2xWrYmXhqBvwcVw4UWh5LAZHC1xW3ix8be6OGa7poty3jP6XIcBqCYpTYSqiYprw2iHOBxPYWQaIc48LLnz2foxQa4j/B2EIfpnJmkD77qHIQafOIa2NALjNMS6IQexkXKK1VrrRybcAB8CGIBAlOxhSQKnbIC9h1RMHHWMkJa/YNw
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2026 02:50:43.6105 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 462afec0-299c-47d3-1dcd-08df27427199
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY6PEPF0000004A.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9566
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

RAS early init executes prior to smu_sw_init, leaving feature_num as 0
and triggering invalid bitmap operations.

Signed-off-by: Ce Sun <cesun102@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 44b2e8d8b956..9e9c1621b21e 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -884,6 +884,9 @@ static int smu_early_init(struct amdgpu_ip_block *ip_block)
 	r = smu_set_funcs(adev);
 	if (r)
 		return r;
+
+	smu_feature_init(smu, SMU_FEATURE_NUM_DEFAULT);
+
 	return smu_init_microcode(smu);
 }
 
@@ -1417,7 +1420,6 @@ static int smu_sw_init(struct amdgpu_ip_block *ip_block)
 	int i, ret;
 
 	smu->pool_size = adev->pm.smu_prv_buffer_size;
-	smu_feature_init(smu, SMU_FEATURE_NUM_DEFAULT);
 
 	INIT_WORK(&smu->throttling_logging_work, smu_throttling_logging_work_fn);
 	INIT_WORK(&smu->interrupt_work, smu_interrupt_work_fn);
-- 
2.34.1

