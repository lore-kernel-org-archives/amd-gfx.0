Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 472CFC54E67
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Mar 2024 08:45:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E124510F0F2;
	Wed, 20 Mar 2024 08:45:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xpTDS8id";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2087.outbound.protection.outlook.com [40.107.243.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AAD6310F0F2
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Mar 2024 08:45:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JWFYr10xfvo0pL9rMM0+c3UBRsWfTD8Fn+QstiiCSiFNqhd40ls7Hy+rKGu+FJqqEYrIUNrXfRu3lrLmtM3UJkm56+EHMLpB0cmB6/A6EdVclT38gocRowihN12x04wCxq2KHASIjRaK+QltlgOJgUEptcr/sY65a//CYTWMWLUAEbzUpZdb8eK4RbSM00Uq/vHHG6s1BTdwCW82lpB8BTH6uOwXTdQSW4FHMeBYbxxgd20zWKcmhsP1TY2cm5l2wajwgJGen5Epc0A4Q5EX5NOFZfbqkEQdOHgIWAwfavN/7RiuTpzk2jw9v/7JBWTMlv4ufbpXqfOkD8uWuliZ/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p3d64/VPllsRIbLXOBSDmPc5MXc7gctbjgUSj1XrL5w=;
 b=Zhl/4yzPq4KwPH0bdlRcvO9fTOAoiZzBiUOEwhGTQqktvlegcvM7VAe8LojHeqA3Ab05/FbQbbySS12rx5GKeoV2NsTGnO1LRM82HOp/jjtYeOR/AaNfIyB4TeGzB8tXlCHT5LFl0FvoSzNudjP+rW7a2OYcD3xLGG8/chSV4TsCa+oHp04SMDPEW1PZDtMy1hEQsLrXUXl5LPzL1oIK4XdavAH5RvhC95ZERHVa0CEiXp5BDY/WgItpeDsZunWk1QakJbLk/i4FFOI5iSBarHmLB0TELgOG2olw5GMyGhsUL0YuIDRBC+XvAB8JBJQyG7w2PEP9iSSh03UWlTillw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p3d64/VPllsRIbLXOBSDmPc5MXc7gctbjgUSj1XrL5w=;
 b=xpTDS8idUAuT8ShEPrU2o2zXgK5UVd/VIh3JJ96D3PDPvdPXDIXnk1/48l2EbPW6ugcx6YFwZHLGvPVsH5Pr6A6tqMItc+vfXeodq3tuwQhTLdhgBB2KPTXNO9SJkhi9UxUu/MKReVstumAIhRtB91411jLDEsxjYR7M7O/K72s=
Received: from MW4PR04CA0047.namprd04.prod.outlook.com (2603:10b6:303:6a::22)
 by PH7PR12MB7380.namprd12.prod.outlook.com (2603:10b6:510:20f::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.28; Wed, 20 Mar
 2024 08:45:39 +0000
Received: from MWH0EPF000A672E.namprd04.prod.outlook.com
 (2603:10b6:303:6a:cafe::66) by MW4PR04CA0047.outlook.office365.com
 (2603:10b6:303:6a::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.26 via Frontend
 Transport; Wed, 20 Mar 2024 08:45:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000A672E.mail.protection.outlook.com (10.167.249.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Wed, 20 Mar 2024 08:45:38 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 20 Mar 2024 03:45:36 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, Lijo Lazar <lijo.lazar@amd.com>
Subject: [PATCH] drm/amdgpu: Fix format character cut-off issues in
 amdgpu_vcn_early_init()
Date: Wed, 20 Mar 2024 14:15:13 +0530
Message-ID: <20240320084513.3026222-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A672E:EE_|PH7PR12MB7380:EE_
X-MS-Office365-Filtering-Correlation-Id: b251c997-7309-4bdd-dcd6-08dc48ba1e6c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JM9EiBPargJvstaEqmAvRcn81kq/+rJCcOz5d/30YhLR4TuzvKNHAH4apnR1KVzcJskQVPrygFz4TLgpu1FAsix9vwJ3QERcMsd7sLMWXevU54sL+AZRO210Iq5ETHnZHntNtcGsDRvrU59Y/u92v8E0gGC8nQbWgLR4G8I5Dups/Hq2GvwN7GZJch0/lql7cIr5i0u1Z4r6KretbSb1nogQafFP5NyHYUkRmx1yBP8bX6RAGKCOVwY5U9Loe0F5MKKCqwg4WAP+62GdNZ8jqqshp0yyAUkjQCVkB6LL7DX+N86lAtaiCPkDWocKslNxQttzM4afBGa4OEIk4BjJ/mN4S8SE8VSD2ENEPKkVSg4asT6cltbwX8jCkLXFIjaT6vltRU57nQHYebPSWVG4LG1gXGqDUAgYCtM6pZPsM+PATTM6Wot99Ytg3EBK/IP+IDjbCE4DR0rJFhPfbHYUiD/K0roWZe0hSwpkwspROC8Gh9mOMmy2nfZzITScAqTmlxPmnfIpiM9dy6dghQm3XX34Tk3oVKA6A93NK/fsqqlUttofQMUdRpI7oyUfrEAto+BEBkaQZ8mxKvHN+/XngxBEHN0NmaekEt52HRXSRGRKkr/Tt03PZjv2R/+HH5fx/ByoYtmFioJSTx5kwbbf6f0ukh8G+UCoBfiljIJ0TZaw5IVHUF7/CwQb53DuPqdZJ0Mm/oA/sicM1Bu4Ogi6V/cQvLVmuLgJMHNbZnwk7MJG1AFHcvqWMH+DFgQ/rfbO
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(36860700004)(82310400014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2024 08:45:38.9616 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b251c997-7309-4bdd-dcd6-08dc48ba1e6c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000A672E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7380
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

The issue was present in the lines where 'fw_name' was being formatted.
This fix ensures that the output is not truncated

Fixes the below with gcc W=1:
drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c: In function ‘amdgpu_vcn_early_init’:
drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c:102:66: warning: ‘snprintf’ output may be truncated before the last format character [-Wformat-truncation=]
  102 |                 snprintf(fw_name, sizeof(fw_name), "amdgpu/%s.bin", ucode_prefix);
      |                                                                  ^
drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c:102:17: note: ‘snprintf’ output between 12 and 41 bytes into a destination of size 40
  102 |                 snprintf(fw_name, sizeof(fw_name), "amdgpu/%s.bin", ucode_prefix);
      |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c:102:66: warning: ‘snprintf’ output may be truncated before the last format character [-Wformat-truncation=]
  102 |                 snprintf(fw_name, sizeof(fw_name), "amdgpu/%s.bin", ucode_prefix);
      |                                                                  ^
drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c:102:17: note: ‘snprintf’ output between 12 and 41 bytes into a destination of size 40
  102 |                 snprintf(fw_name, sizeof(fw_name), "amdgpu/%s.bin", ucode_prefix);
      |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c:105:73: warning: ‘.bin’ directive output may be truncated writing 4 bytes into a region of size between 2 and 31 [-Wformat-truncation=]
  105 |                         snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_%d.bin", ucode_prefix, i);
      |                                                                         ^~~~
drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c:105:25: note: ‘snprintf’ output between 14 and 43 bytes into a destination of size 40
  105 |                         snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_%d.bin", ucode_prefix, i);
      |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Suggested-by: Lijo Lazar <lijo.lazar@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index 9c514a606a2f..f994ee6c548d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -94,7 +94,7 @@ static void amdgpu_vcn_idle_work_handler(struct work_struct *work);
 int amdgpu_vcn_early_init(struct amdgpu_device *adev)
 {
 	char ucode_prefix[30];
-	char fw_name[40];
+	char fw_name[42];
 	int r, i;
 
 	for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
-- 
2.34.1

