Return-Path: <SRS0=2AtA=PH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A113C433FE
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Oct 2021 20:11:07 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AEB17611AE
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Oct 2021 20:11:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org AEB17611AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 05EDF6E1CF;
	Tue, 19 Oct 2021 20:11:04 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2041.outbound.protection.outlook.com [40.107.212.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DE30E6E1CF
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Oct 2021 20:11:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tje/eBGRVfK1YoxF/0Ciysuj41o/XJyuA65jxbHcX9AJvKip1GDzPWzC05gdRfsuIZLh2lqOIg2QyPmsY4YqwJzaIloCQJyK6h9HN2CyCGzwG9HJpVM/lSTiwI+ThSzjcldtt/uA8ApgsT/jkFB/LQnJya4J/cxn9B1S2JVBjOKBrxplZV3TEboyh9YoANa5N2U3lhVYIUfsOzwTM5RD2Fz33Nr1argdQUHK03Efaw0G1zvNap0X/l1WR9r1O2KWQgbMOkFpRfgTydKCAs6H5+rQpx4koIBUlWovAoKh9d1aZ0vzzQ2qwb1UeD0+O2UvX6T/8SGqcRd3O51jNencag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=htyl/Y4f3JWn0C6U5ahXd7oZmLrl6m2gbG+yqdnr7FE=;
 b=FTEpVa6Q52YuLJwvGijloxX1mvMNA4diKSdstkZvd4JeccvYUuzyuFYEgvKrJvhPNrdzoOttZBlvfMXUxPGRzivKgUNiXAQyOoyjhzI5dZ6fOYTm9PEwXUsxAnWqnCPvnWBaNcj+KFrRUQVlS7OjdSBdSQmsC+yxGaQHDDsJryhZAlTAoQ2odpsSsHGThd9tmtWdDrLA/QNfSYbGG7mABvBdkBm7qJVT26fKyOBi6RK6mKg4cHl3c5X+HjsVC+trqzDFOGjVV1tLu1qWVedCaj+PU9p4CLJh69EnnQMp7oueBeM2/frHOcYS26e3/0GEE/EWVZYR5sO+RrajetKpkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=htyl/Y4f3JWn0C6U5ahXd7oZmLrl6m2gbG+yqdnr7FE=;
 b=d9sntQ+/sjd1AUNh4oKYk/t4mN6Nat7P0bjof72OH/aJDbyTfrtx/xqlEK5dlMegQxLMU6Akvsk6itjW8jnpPzuMqYH3JPbowDoN3+2cm/rPOHwPjMm3PZWqcbJMXg3cQ+ENhQaStQPJ7TOXtJ3OOvAjc9e3SrcLIniY3LItAuc=
Received: from BN9PR03CA0031.namprd03.prod.outlook.com (2603:10b6:408:fb::6)
 by CH2PR12MB5546.namprd12.prod.outlook.com (2603:10b6:610:63::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16; Tue, 19 Oct
 2021 20:11:00 +0000
Received: from BN8NAM11FT044.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fb:cafe::eb) by BN9PR03CA0031.outlook.office365.com
 (2603:10b6:408:fb::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.15 via Frontend
 Transport; Tue, 19 Oct 2021 20:11:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT044.mail.protection.outlook.com (10.13.177.219) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4608.15 via Frontend Transport; Tue, 19 Oct 2021 20:11:00 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Tue, 19 Oct
 2021 15:10:59 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 3/4] drm/amdgpu/vcn2.0: remove intermediate variable
Date: Tue, 19 Oct 2021 16:10:43 -0400
Message-ID: <20211019201044.426871-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211019201044.426871-1-alexander.deucher@amd.com>
References: <20211019201044.426871-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dd8c21a9-b197-433b-e92c-08d9933c9207
X-MS-TrafficTypeDiagnostic: CH2PR12MB5546:
X-Microsoft-Antispam-PRVS: <CH2PR12MB554629D73C5B7564F0C139F4F7BD9@CH2PR12MB5546.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:913;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bGRM8uIqOIVq4x3W4+e5uKbWxiIUzhI03ljlc7YlxHZECE/hfP6u3Jwir4Hg5ayl0zvQxsOzHrj+v05N3gCJWjhmL22SA1ghPI6gLUuJyqdhOazBdSopdmVX5COgd6t/pGM8kezOojcY9RjfZPkvle3U9YaDMwVSKkmuP4isLuXi0TGGDnf6np9yDiXi3dEaklCqgSPZ2jteyqDfbPdHGzC8kE4oIuyE+MRcL3Q6PJstR49ypgMonqW7gPZPHlAoLIy8RcAfmfK9ARZ9Fu/0fI7XSNtmb+ja1bp/7e7HJYTpnBeIDkY9rRwt3xC6vkaijlqh4DKcJr718kv82zhV+NWqHmU8ro0+kNLzCWKXD753WHLxKtgQ9GR5Q4FWE577JULs9l9KUwIkhCXyvP4HK4MNUKmkGgQsba6jkdFVsGbhwnF1bJeubNefHpKXHhznuznMzhAJ4yJvxVt2qBNrClQnL/7NvVFjm6yjq6uKapKijSe11AtZZquqghELupjWXYmwjIS0fJArDeWL7sknzTmTs0u2g3XCM+HtRXQ08wPDo8GhNSB15nUVzId1s3bb/OUZLOZa47tKMYSc2vHGxr7nTZHMj9d84Gf6lU1I3jVfD6s7YtJZaTkpSDUttgW91rYgUpSP15c+AdSc9sGxOWTV1VlkYItwX5SL5zpIfuK1lmsjhwSR5aixIdP8Ev2NJYiB7Fx9kgEyQFuLGndMRbz7I911WnBYNcTdIVQzqc0=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(186003)(2906002)(426003)(8936002)(7696005)(81166007)(26005)(86362001)(36756003)(356005)(6666004)(8676002)(16526019)(2616005)(70206006)(70586007)(1076003)(47076005)(82310400003)(83380400001)(336012)(316002)(508600001)(36860700001)(5660300002)(6916009)(4326008)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2021 20:11:00.6518 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dd8c21a9-b197-433b-e92c-08d9933c9207
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT044.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB5546
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

No need to use the tmp variable, just use the constant
directly.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
index 3883df5b31ab..313fc1b53999 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
@@ -1876,15 +1876,14 @@ static int vcn_v2_0_start_sriov(struct amdgpu_device *adev)
 
 		/* mc resume*/
 		if (adev->firmware.load_type == AMDGPU_FW_LOAD_PSP) {
-			tmp = AMDGPU_UCODE_ID_VCN;
 			MMSCH_V2_0_INSERT_DIRECT_WT(
 				SOC15_REG_OFFSET(UVD, i,
 					mmUVD_LMI_VCPU_CACHE_64BIT_BAR_LOW),
-				adev->firmware.ucode[tmp].tmr_mc_addr_lo);
+				adev->firmware.ucode[AMDGPU_UCODE_ID_VCN].tmr_mc_addr_lo);
 			MMSCH_V2_0_INSERT_DIRECT_WT(
 				SOC15_REG_OFFSET(UVD, i,
 					mmUVD_LMI_VCPU_CACHE_64BIT_BAR_HIGH),
-				adev->firmware.ucode[tmp].tmr_mc_addr_hi);
+				adev->firmware.ucode[AMDGPU_UCODE_ID_VCN].tmr_mc_addr_hi);
 			offset = 0;
 		} else {
 			MMSCH_V2_0_INSERT_DIRECT_WT(
-- 
2.31.1

