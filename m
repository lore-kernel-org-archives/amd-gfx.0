Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BA08C4829C
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Feb 2024 04:55:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 31F9611310D;
	Wed,  7 Feb 2024 04:55:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="cGvt+9cX";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2053.outbound.protection.outlook.com [40.107.92.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 98F5511310C
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Feb 2024 04:55:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JqkH3sLAchq+BTCJJeW6O2tyHGpO+kgEMnw1LUxymSv0F1pHc+sX3ZDnYG0hYZDZygrpm8vBddB6+iZQGhuoWUCzKxrL8frimbSaJqexD9/vSeyzKu4Xc/ap+uFOfbUb3v4BAK833ESnqIReN8rCRlLAsfzJ7/m1QeLdMYmvPYRjISB4OOHtygHBuz1A4pgJm4jz4aSt6AbAFd92a1z67kIPsG6h0lruFYkjT+I9nfy7KrZ0V5AYfeuk9PQxfQa52mqeuao0rtahuvKYW+iZRiEtYNGbMyQHnoXLqhw7jsdaFJNGFVEws80EPrKaTME+/CE3BW8w/wxAs7Vx0fwLIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PZEvVxWLQ+JxDu9FGuTi8ypTKk8oCa+wc6KeRwVMDbc=;
 b=cC7YRg67pYN0Q14/mizdQ30Fa+GrZJzGRWZTOc4ewFLRkKiuUsBZnqiFyrstQ7z4Qdx59wGqBOC9bB8/fadbR2Xb5mY1JdfIGjnV69Oc/aeuNqGhLU+j60XNIiREnsYcZEV/5ddKx6Nl24DrIdUzKmkCmwVszzvGguZxbt5GMBf0gW5gP7H7dLktLm2vM00puh+ZRi5TLi4fDc/iQcGKbdQcCT8pBVehjjuRJgqFd9SR/UTQXy0/lBmESofKw6UVpczuTXx9carmyUp/66UY6LafyEWoA+NF8yR2/4ACABxPLhrH4jH+1l2v1mCNWhIunvB3qq0i26UHmOriQW09jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PZEvVxWLQ+JxDu9FGuTi8ypTKk8oCa+wc6KeRwVMDbc=;
 b=cGvt+9cXvpYF1EfNrCWbhVVokA6rLRlpoXif4QuJdsYtfFKOZLOsOOVZ+bSJiklveLl8F9HFpkwYyddG4nWISdMurQX01zhxULeudltC0d7bIsWMxwGnLudggrcL5baJlhi++MRePa7eu/2QTUOMLvvtUxUL5/bU9BbKh8NDmEE=
Received: from SJ0PR03CA0223.namprd03.prod.outlook.com (2603:10b6:a03:39f::18)
 by CH2PR12MB4293.namprd12.prod.outlook.com (2603:10b6:610:7e::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.17; Wed, 7 Feb
 2024 04:55:29 +0000
Received: from CO1PEPF000042A7.namprd03.prod.outlook.com
 (2603:10b6:a03:39f:cafe::47) by SJ0PR03CA0223.outlook.office365.com
 (2603:10b6:a03:39f::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36 via Frontend
 Transport; Wed, 7 Feb 2024 04:55:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042A7.mail.protection.outlook.com (10.167.243.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Wed, 7 Feb 2024 04:55:28 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 6 Feb 2024 22:55:21 -0600
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, Roman Li <Roman.Li@amd.com>
Subject: [PATCH] drm/amd/display: Fix possible buffer overflow in
 'find_dcfclk_for_voltage()'
Date: Wed, 7 Feb 2024 10:24:58 +0530
Message-ID: <20240207045501.3344729-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042A7:EE_|CH2PR12MB4293:EE_
X-MS-Office365-Filtering-Correlation-Id: a132f2a5-d1d6-408b-1d8e-08dc27990184
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Y7LpVISmd+2QHWJemUW1tUat4LAq31DgVnq89ETM94Vo7g8LmqaMvENmgGXFVufaloePWycYZxYe2tzbUUKZr1zXNAZctr2OvFwaNEpSNcer222JfH2qGMwh5+7N4yWMcWH3CXOEj8OThs/dabFDhqha1GJjmhRsjDbu+1RB91UdmG7DhLGLquAi7TE89COr8uTsCG3X9De6PHlmSKO8tNnV34Hps3ujzV82u6/yY/WCHSuwB1L8xjU/9oxiwYIsdDaGo5treWlZIUaFwMRyzaABWZ/URIV+lZ8QZeA1HCWlaWWZeuYirO9H5PW8rTctqtjKR7y6mJVs/hw0dHmIPqc1u/7LFBaCiiGRHe/iLfwLPwlrVsf3xJTcimlFwiWxzLXYBPko5VjGZdZGlTNpiFZQf9mVZhJmApMD2zaw6DKRxbbex0UJjhRuj0gpLzvw+Qm7aKlSPsna6YOe9OSEWeLR29qD0j447gd39twVLsFBRxJOUeBQAYNbwFDEfdh9u1Vk0K/AR8KSqFxr9ON5EB7IswK5u99i3hHSXeM+jA4DHEdIB8dKn3vJbSoO/gqPeNA9OpG2ZVmVFG5BGDQxPlGUrjwPiafI03+w1qABneOfJFi/53qMVAnf+nkuC5pmwgPFVfTuMVjTazevCD2UJy8N9UNta+u14gJLxU9NtFjUiQOB3mJ0KR70y83T5m7gcxbZVSJWgPaf+kbyZ53FcltgXzijrgLLbXi8OJMZMdSPAflHb8DqkV4tqzfHVzPELGfpyaymhyxs+eFlE0SBkA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(39860400002)(376002)(136003)(346002)(230922051799003)(1800799012)(451199024)(82310400011)(64100799003)(186009)(40470700004)(46966006)(36840700001)(316002)(41300700001)(8676002)(8936002)(36756003)(4326008)(54906003)(70586007)(86362001)(2906002)(44832011)(6636002)(70206006)(7696005)(5660300002)(356005)(110136005)(478600001)(36860700001)(2616005)(82740400003)(81166007)(47076005)(6666004)(83380400001)(426003)(16526019)(336012)(1076003)(26005)(40460700003)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2024 04:55:28.7276 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a132f2a5-d1d6-408b-1d8e-08dc27990184
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042A7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4293
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

when 'find_dcfclk_for_voltage()' function is looping over
VG_NUM_SOC_VOLTAGE_LEVELS (which is 8), but the size of the DcfClocks
array is VG_NUM_DCFCLK_DPM_LEVELS (which is 7).

When the loop variable i reaches 7, the function tries to access
clock_table->DcfClocks[7]. However, since the size of the DcfClocks
array is 7, the valid indices are 0 to 6. Index 7 is beyond the size of
the array, leading to a buffer overflow.

Fixes the below:
drivers/gpu/drm/amd/amdgpu/../display/dc/clk_mgr/dcn301/vg_clk_mgr.c:550 find_dcfclk_for_voltage() error: buffer overflow 'clock_table->DcfClocks' 7 <= 7

Fixes: 3a83e4e64bb1 ("drm/amd/display: Add dcn3.01 support to DC (v2)")
Cc: Roman Li <Roman.Li@amd.com>
Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn301/vg_clk_mgr.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn301/vg_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn301/vg_clk_mgr.c
index a5489fe6875f..aa9fd1dc550a 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn301/vg_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn301/vg_clk_mgr.c
@@ -546,6 +546,8 @@ static unsigned int find_dcfclk_for_voltage(const struct vg_dpm_clocks *clock_ta
 	int i;
 
 	for (i = 0; i < VG_NUM_SOC_VOLTAGE_LEVELS; i++) {
+		if (i >= VG_NUM_DCFCLK_DPM_LEVELS)
+			break;
 		if (clock_table->SocVoltage[i] == voltage)
 			return clock_table->DcfClocks[i];
 	}
-- 
2.34.1

