Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0071BC433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Apr 2022 18:26:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9FA0D10EEA6;
	Tue, 26 Apr 2022 18:26:16 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2085.outbound.protection.outlook.com [40.107.244.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DC4D010EEA6
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Apr 2022 18:26:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WkHqy7Q93h+BAMNrNEhUz+2RNXU1qx9byTwtsQdh8hQiqMT0Bb1ZsgGAIGJahQYb0U1HhE0bAdlJpSxNWnHDqyXkNtBtcvyJjo0S8ovRCT9jc1hU7pkaeV/bvTxCcCA8uQdwmqoxp1yFWju+ESSbPJVTFZ9OV4xxD+A2/omTHKgTJ9aum18EMUupQjeboWvFAFIIBBcGMgplIGq5/krHBBpq43fW5LMDRKT0WwDxPOF2z3zFwgNg+5sVIAxab2hX7jILvmcU6wSdlgu+qGilXKXG7Fp9lXdOn4DiQhY7mZbBKz+TXSlK4pITTstuGRBV7LB0z4jJ6clB/D4+AJ2cOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WMqH+9iZ9hh6FV3z3fXDPL5K9TRaua06IuAuGfsJ+TE=;
 b=fUstBIbY8Wzdo24vscr2D+/xvPwty0qmu3oIYkLfyulI5fJzyeUfz+ZYKlj/HdnUHs/IgZK1kF4r43Voj7ZcIm96UmWQIUBYEW5gvdJrDtVyoPvy3x6uowqFb56VbP805FJzQWPLAcJnGjTyOo3rVWJGbecwS4fetw05BPvMF0cb52h3rCButQXEI1Jy/bFFXjJ3pymexa7lW6remwCOecdBSd3Pgeu4Emd/4ZOfplxEvLg9GAQIVjcmy9lhQDIrtB+hUW0czQeYDFl7aHpZGXhw+X3GNtmS+dLWSAY1txxE5kFDmPvXbRxYKax+oXP1cSx6gh4P99JeBnSNh34SIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WMqH+9iZ9hh6FV3z3fXDPL5K9TRaua06IuAuGfsJ+TE=;
 b=26s5Ae/B6dXY22aw02giD6WjkQvdzte5jGxrD43mUK78tZoc+FyMsi4TR0mThG0tWMreFOcdTVE+RwT/XK9j5syB7K18SfzoNvt8vD4UP3oKEMSu4i1IFX2chxXQwNx3C+WllSXdmmB8tzOcSoCln24q5Fy3kx7CiK1YR3OFvrs=
Received: from BN0PR08CA0018.namprd08.prod.outlook.com (2603:10b6:408:142::29)
 by DM5PR12MB2391.namprd12.prod.outlook.com (2603:10b6:4:b3::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.13; Tue, 26 Apr
 2022 18:26:00 +0000
Received: from BN8NAM11FT017.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:142:cafe::7c) by BN0PR08CA0018.outlook.office365.com
 (2603:10b6:408:142::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.13 via Frontend
 Transport; Tue, 26 Apr 2022 18:26:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT017.mail.protection.outlook.com (10.13.177.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5186.14 via Frontend Transport; Tue, 26 Apr 2022 18:26:00 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 26 Apr
 2022 13:25:59 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: increase HWIP MAX INSTANCE
Date: Tue, 26 Apr 2022 14:25:44 -0400
Message-ID: <20220426182545.3006431-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 04252f07-c9f6-4ae1-c053-08da27b236ac
X-MS-TrafficTypeDiagnostic: DM5PR12MB2391:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB239138F3544D9BE1F3D68633F7FB9@DM5PR12MB2391.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kLlDE6vemvfMwF+0oGNL2wL62t2ASebsCuGPeFWNSNV5xqmi42oEFaBcpd1+ba5f85j25+8LhE0Udx3GBwP9c3J1Ml61Q+WaAOmyMBBeMdJIV669y9fwbBVosjBKz00CYaD4+ZJGmBvX5Xj1oL3rnIpl2uX9KMYKJpiul/b14QuY0bISSC2e+2GgN6kuERQrIyOCm9Uko+bpi2W1Pqc5zJIfW+n0oCeGxGexiCpfVE6ZPCtvIpxrZ1BS4Qm9bK1G3ewboXsTsATTM7orlJVMlRWcaIaajX+qaywxLufmedrIZW1ao7OpIeT8wkh8oaVce2oXMt3ajyEUHtN1YASrSHDdJVjGez37mrXKkC7TqlCNmXSZFo3x499PStGWqqntkfRGCq9DRTRU248PvrWwl5hfqRdu7orElHhDypiFP+mDZD/q6XnkhLNQv1LJHZLLuHfiJm2I9d5Us5PeoXI2wJ9ezX0sB3OSEVahh+zS/G8aH+6cqqizqtxGncMRXfzHF8fyGluVKK6u0jbiFBZnmPBB39FMXOeLGKMb0iefLGLNRDM/TMdBdzmaMHbQy30BWnVlVd+raTDQIThersCxqbKjfF7AecPUNc81hWTsaRR0ALTiqSLTcWQGrTIP2XQeqoeYZHxo8p3hTkskoMNK0iVplGSr1IeELxZYhdEjyBt+cIaF7Qa1+fMwHIpS9GdnU3Xptca1l4dBrExqNzQKBw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(508600001)(82310400005)(316002)(8936002)(8676002)(70206006)(2616005)(83380400001)(81166007)(426003)(70586007)(336012)(1076003)(16526019)(54906003)(47076005)(6916009)(36756003)(4326008)(26005)(86362001)(4744005)(186003)(40460700003)(6666004)(2906002)(36860700001)(356005)(7696005)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2022 18:26:00.0674 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 04252f07-c9f6-4ae1-c053-08da27b236ac
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT017.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2391
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Likun Gao <Likun.Gao@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Likun Gao <Likun.Gao@amd.com>

Extend HWIP MAX INSTANCE to 11.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index dfc5b46c6a11..62e295fadc6c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -666,7 +666,7 @@ enum amd_hw_ip_block_type {
 	MAX_HWIP
 };
 
-#define HWIP_MAX_INSTANCE	10
+#define HWIP_MAX_INSTANCE	11
 
 #define HW_ID_MAX		300
 #define IP_VERSION(mj, mn, rv) (((mj) << 16) | ((mn) << 8) | (rv))
-- 
2.35.1

