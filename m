Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1ADFC433F5
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Dec 2021 16:58:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7DDADEBEDB;
	Tue,  7 Dec 2021 16:58:25 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2087.outbound.protection.outlook.com [40.107.244.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8AAB2EBEDB
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Dec 2021 16:58:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jDBeegmCtn0mJ9A0QrM1JkjHR/rjkjbLQfP9eSaEs5xX0jIGoIWBHrqk1P2KZ30GdHe+GkAtgUdhHNbKhnCNPDwA9yz8Zl8oEDNNMYY5QkLmtWguIX4sKl4gZXOXcQp6qAcEFbQL1fbhbyzcYPkFbUTZlCeUMOiyZpslJ7RqlDSN/CSqYWYLJstU2Y7VYfDP4vHqFTgub427xTxpef/HODNJGcgKs6Zkt0wEiplABKCG4/QkEh94RewkTIJHX6ak+AcF71NiEfQ6N3JQt/qxU8I29RSlvQZqrxuVQwicjxp+TBlCTRbsKkxH27C1b1ttMsrKnzUQoVxobCGXXAWmcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7noTIKmkhjy5rCGtbjj5CXpkN8vIDxq8kBzCJwBP5jg=;
 b=IZjdVQrQ2dyvSAI359MJOmi9h919lNsP139fr5+I+SblPRBVp1y9z1XzoZSd16hc8IwWbr0PsFlEn+a9LVbvCK8YzYH5T8+C+A+b2D0WHPTcZD2BVfBnaeYClmFchw2kM5PuweXuYW1eKLKpqVzfpFx1Ou1g0rKrCM6Pba4fLcj9Lvq6wYF0BPRqz1apnU/sEWRwUokaZhQBLBLxlnxVHAu5EfasN18+ez+KMyIIS7caIQvfwbVNB1UqbziGDTtFenN6v0TDfGCyim/qPpqTgZVRV3xXe9HyM1VjY5tIP3ywNHJ+zlaPdOp3kkaRlVYcoHbgxUKQmQVlSpR290mgUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7noTIKmkhjy5rCGtbjj5CXpkN8vIDxq8kBzCJwBP5jg=;
 b=RKMxJ7zc7qulHEPZP2irScS9rKHzIrnNtACKCVWftxee1ep1EP19BIWBIvN/oWKMh0ZG6O+uVCsUR4NlQ2W38F42aId7CG3sd2Jkq/9G02Fc8dbxlapwFovnPIYJd1GxI4effX0/167nhh7qY/jisOr5Qp3o9+F6Wj6INHICY4M=
Received: from DM5PR19CA0053.namprd19.prod.outlook.com (2603:10b6:3:116::15)
 by DM6PR12MB4927.namprd12.prod.outlook.com (2603:10b6:5:20a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.11; Tue, 7 Dec
 2021 16:58:23 +0000
Received: from DM6NAM11FT006.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:116:cafe::7) by DM5PR19CA0053.outlook.office365.com
 (2603:10b6:3:116::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.22 via Frontend
 Transport; Tue, 7 Dec 2021 16:58:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT006.mail.protection.outlook.com (10.13.173.104) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4755.13 via Frontend Transport; Tue, 7 Dec 2021 16:58:23 +0000
Received: from Zhigang-WS.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Tue, 7 Dec
 2021 10:58:21 -0600
From: Zhigang Luo <zhigang.luo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/4] drm/amdgpu: recover XGMI topology for SRIOV VF after reset
Date: Tue, 7 Dec 2021 11:57:26 -0500
Message-ID: <20211207165727.25109-3-zhigang.luo@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211207165727.25109-1-zhigang.luo@amd.com>
References: <20211207165727.25109-1-zhigang.luo@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 590e8808-4d6a-4d3d-d1e8-08d9b9a2c771
X-MS-TrafficTypeDiagnostic: DM6PR12MB4927:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB49270A1AEAB49BE4A9DE3F00F16E9@DM6PR12MB4927.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iMVQwMty4T5KE+GvNQEoj6MZc2Grz/Btrh5CG+qrsL3Wl3pAOM7pURmpOg1eI3xJVHelz0yEMx1//3gbartRlo7ZLHoQbfZ8WtDQ8UNbWbX3GG+s8W+bBGdLNLEfoSJv1OcjGlvv4O79EArJlQXt+0MpMadieK5x6wz2Ed6d/6bdXLHFAy8HDwqK5HjBOMeCrObv+wc/U6/9z1jG1AgPa6ziitzeCokJSl8npM1e3Qn375qlTxEtTIVH/lcbZtCBbnHKkI2pehi8TrKlNl5kPLtXbniu16NFwazAzP3B3hWanjuyBqZmq1wD85uf9qWbc9eYAtaKNfpkRYXnJ3Ebu9WA+7zyeNAbsVCN90+WcVpUE0Or43W153VgY/4ClAK/IuOju1MssyELCSJzdVHPodMiFKGxa/EX3CxHfSDta4v9W1fzTiplYM5wzAEfaD32YY64RHpW7zn2h0F4BKCCsNJGroylEqObWHCYMiySHEz60AmK8XV1iyq1oWQNEKXq+S05QdemYXFeR68x086LVQtPynbJ4ewDJpTjOoxDhW1GZ8vqvcu49ICW7nZ56R6GBbo/NIMvRgEiLmuH74VlM7R0WP7p/2UbnyV+P5O45JKklRvlTdoZ7/oT+qlvMcACMxYl6CmVeemdCAHLHrvsfYAqfkbM0DA4g+e4eHO+DY/dzY+iy5BlPa0gMz1OFyRnc4R1OsUAR6HivSYEfFWCzURXWapgHxELPxloP7v7KwHWHWvmAvI+nROBLnHS/yoFSqppPch26QjUK91h+3dZ7Bu+33lT9AfkEV8mSVTZ4t8=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(40470700001)(81166007)(426003)(8936002)(8676002)(2616005)(44832011)(356005)(336012)(7696005)(186003)(16526019)(26005)(2906002)(47076005)(508600001)(1076003)(86362001)(83380400001)(316002)(36756003)(4326008)(6916009)(5660300002)(36860700001)(70586007)(70206006)(82310400004)(40460700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2021 16:58:23.0664 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 590e8808-4d6a-4d3d-d1e8-08d9b9a2c771
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT006.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4927
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
Cc: Zhigang Luo <zhigang.luo@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

For SRIOV VF, the XGMI topology was not recovered after reset. This
change added code to SRIOV VF reset function to update XGMI topology
for SRIOV VF after reset.

Signed-off-by: Zhigang Luo <zhigang.luo@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 474f8ea58aa5..7b07af1873bd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4284,6 +4284,7 @@ static int amdgpu_device_reset_sriov(struct amdgpu_device *adev,
 				     bool from_hypervisor)
 {
 	int r;
+	struct amdgpu_hive_info *hive = NULL;
 
 	amdgpu_amdkfd_pre_reset(adev);
 
@@ -4312,9 +4313,19 @@ static int amdgpu_device_reset_sriov(struct amdgpu_device *adev,
 	if (r)
 		goto error;
 
-	amdgpu_irq_gpu_reset_resume_helper(adev);
-	r = amdgpu_ib_ring_tests(adev);
-	amdgpu_amdkfd_post_reset(adev);
+	hive = amdgpu_get_xgmi_hive(adev);
+	/* Update PSP FW topology after reset */
+	if (hive && adev->gmc.xgmi.num_physical_nodes > 1)
+		r = amdgpu_xgmi_update_topology(hive, adev);
+
+	if (hive)
+		amdgpu_put_xgmi_hive(hive);
+
+	if (!r) {
+		amdgpu_irq_gpu_reset_resume_helper(adev);
+		r = amdgpu_ib_ring_tests(adev);
+		amdgpu_amdkfd_post_reset(adev);
+	}
 
 error:
 	if (!r && adev->virt.gim_feature & AMDGIM_FEATURE_GIM_FLR_VRAMLOST) {
-- 
2.17.1

