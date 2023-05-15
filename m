Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67486C7EE22
	for <amd-gfx@archiver.kernel.org>; Mon, 15 May 2023 06:14:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DE26010E0A3;
	Mon, 15 May 2023 06:14:36 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2045.outbound.protection.outlook.com [40.107.101.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 030C210E0A3
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 May 2023 06:14:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yvb+ZEyO/fKe8qhQCxyw9TTpkMyRad/Ae8jeE4BtAj9LLKjf5ai1K4jXDftAnik8bW4W5B0nULqVU3F4Wr2ljB4qlQGqJp6sDPASifBesZIE73+PhsqxDKD5xvFxth+yYqKmkg8N0GH9xJQxZVlkW/XmNQXuJofNviNSFTRVkP8vuRHi8jk6dNf8ZAhmu2VxIUbCPmU5nqy3CiBxeIG9ISNOwmD9dax1pkMQqbd7Ggn4to+6Oes3q6Ho5GRio5UusjehItmTaOTgM83siy8mYDJtRmbGhoYEgtf4YNp2Ipq+q8i8eMReeaXIRolG0UXaLsKqTL27YVWkS33QKfJa6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M1kehrrS2HiLx4QdOi5Mw28z+Pg/akcUow2Mv1bjop0=;
 b=lPGIde9s0qphXcGIKZ2VluZXS62JXm9UaP6OYmXBx5aEA424vsMIW+OIIiuoj3RVswFkm9F/8+NqS6ZdKIlpl1WMJs2c0FVBXDBOFN67grttMnzU2Wq1yrhUOPDgR0xKIhGs5nlc/+dryw0IGXFJj8kS/SgcJmZcOc3IxEejt4QDkv7JahUp9w7LKsqDDFkoF1Fko3ItSlBMJbYqDQV3ia2WKn3c3z52yvE7gsASB6Nl/WK7gIfSk9Bs9nNLR0y8/vv9zGI/SLccW2KUKKKE8wXf51dGS2thLOCyJCR5E4jBEOzB/GmcaNGl3iTuvrRt8l1wLzmsBri761bHjWMjPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M1kehrrS2HiLx4QdOi5Mw28z+Pg/akcUow2Mv1bjop0=;
 b=MPrsaDh2TZ8G58XmdRzgYVVkxBihAwzyNMlz5/e0RZmjCyaKaKzUIclHDwP9zV+9avG8WACFgogKFQrNbHAmKPMfVZEVL7AzBp+5eJY79BsAd+D8Ud2goa8r5z1Ou2Xh2OuabOWoBGcZt07OTHTMOztCHaQELJw5uVqgwX4YjUg=
Received: from MW4PR04CA0201.namprd04.prod.outlook.com (2603:10b6:303:86::26)
 by MW3PR12MB4572.namprd12.prod.outlook.com (2603:10b6:303:5e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.29; Mon, 15 May
 2023 06:14:33 +0000
Received: from CO1NAM11FT020.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:86:cafe::89) by MW4PR04CA0201.outlook.office365.com
 (2603:10b6:303:86::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30 via Frontend
 Transport; Mon, 15 May 2023 06:14:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT020.mail.protection.outlook.com (10.13.174.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6411.14 via Frontend Transport; Mon, 15 May 2023 06:14:33 +0000
Received: from majun-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 15 May
 2023 01:14:00 -0500
From: Ma Jun <Jun.Ma2@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Fix the EPERM error when get user pages
Date: Mon, 15 May 2023 14:13:42 +0800
Message-ID: <20230515061342.3328610-1-Jun.Ma2@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT020:EE_|MW3PR12MB4572:EE_
X-MS-Office365-Filtering-Correlation-Id: 271ccac4-6364-439c-59cb-08db550ba6ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gnsccLMxFn1vC+yqLCNk2XrmCBfKGr7sKG5m/WxdSMxhYMNK/lFsogH5pp11O1XgwwPj8UawuY7pQgE9AMjdTkCVtiCsCBXMne+LYTLUFnV3V7hZCoia7wAgGZKkJ/Bml77QLXz6IGSKEZ9p8B13P+QajOPiwbF6IJS/O0zXy0MnbLVlvw8ODoepYTK0qKiU5S6aUfAC5AV2N4iuf3c42dlHw5aUrf/aFDC0xyahARN7N1b98Cpaxw2gQjm4Ly/6gzwW/k+CIIzUJjF31iBJknk0h4iJN7NP1x8+uVEsgXSrEJcotzt9vHcUx2RIsgUFHHW/BXfVvtXhL0WFGfYuL+wW4lkTAJVhJimmhDDQTR84uv0SimUZTYwtbzfYZN4CD/V7zon/0mjQlddqouT7HWuF4pPifahfaXQb62L4ZwMbLvXzkTja1nHSw8UGl4I+EQAiE1RqyGb4WfQo+Rcvwd2iGGsi8mzvZQ0T/R1y2T8wmokqMEEPrIoF+cYAt1zH1SL8SJrwFwXmUisztuTrWbakUPuk3RNjs1JmcKctIos/PJB7sRO3fLI67OmZwO//WO481vH26++HcQaNV/oozK4YQ9XEOIgQCgQE2vmhGxhuqWdOZtX3u6/LcBT56rJCMZZsC6HBowS7oxXajoFGRbLsqZqUz6lNvWHNPJB11utCzMa2OGKz7Dl2WhKel/WGWHKxwx9NHUaxq5Yo7aXibb1zLly5x0iM4IMvi6kokf/NM24//Lv6Ksgr2B93JDTST60GeIKoxjSO7DWIQRiqpw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(39860400002)(346002)(396003)(136003)(451199021)(40470700004)(46966006)(36840700001)(6916009)(4326008)(70206006)(478600001)(70586007)(54906003)(186003)(16526019)(83380400001)(40460700003)(426003)(336012)(2616005)(36860700001)(47076005)(36756003)(82310400005)(8936002)(8676002)(40480700001)(2906002)(6666004)(7696005)(316002)(356005)(81166007)(86362001)(5660300002)(41300700001)(26005)(1076003)(82740400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2023 06:14:33.5159 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 271ccac4-6364-439c-59cb-08db550ba6ec
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT020.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4572
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
Cc: alex.sierra@amd.com, Ma Jun <Jun.Ma2@amd.com>, felix.kuehling@amd.com,
 christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Check and pass the readonly flags when set amdgpu_ttm_tt flags

for readonly ptr pages. Otherwise, there is EPERM error returned

during the KFDExceptionTest.PermissionFaultUserPointer test on

ploaris10.

Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index d426333e865a..85d1087439c0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -1036,10 +1036,17 @@ static int init_user_pages(struct kgd_mem *mem, uint64_t user_addr,
 	struct ttm_operation_ctx ctx = { true, false };
 	struct hmm_range *range;
 	int ret = 0;
+	uint32_t tt_flags = 0;
 
 	mutex_lock(&process_info->lock);
 
-	ret = amdgpu_ttm_tt_set_userptr(&bo->tbo, user_addr, 0);
+	if(!(mem->alloc_flags & KFD_IOC_ALLOC_MEM_FLAGS_WRITABLE))
+		tt_flags |= AMDGPU_GEM_USERPTR_READONLY;
+	else
+		tt_flags = 0;
+
+
+	ret = amdgpu_ttm_tt_set_userptr(&bo->tbo, user_addr, tt_flags);
 	if (ret) {
 		pr_err("%s: Failed to set userptr: %d\n", __func__, ret);
 		goto out;
-- 
2.34.1

