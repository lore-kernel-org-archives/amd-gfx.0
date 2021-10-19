Return-Path: <SRS0=2AtA=PH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3783AC433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Oct 2021 15:31:11 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 03E6361074
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Oct 2021 15:31:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 03E6361074
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 904216EC11;
	Tue, 19 Oct 2021 15:31:10 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2069.outbound.protection.outlook.com [40.107.95.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 958B06EC11
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Oct 2021 15:31:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JotLb2GwMmXFaji1w9O4bjuqoqdriD8n2OqMChAadWvDY4iBJPE8/lph5ST8/gh4PDoj4h5g4rl1fuQDRHyGXj7fiwNNe/jPI2rvLyPgxWphOTEZruSbaC6e94oUE2c7OoNEY+AupPjZW+lQpT2j1eUK+rVNu5OeMU7sC2atjIn6RonGKyTKDhrFjMNTV/PgM7DPxTXICgHKYoPGQ+6ziqqUhnFSxGKgZJpu7ntCzL0fp9GJ5BFnG/3h4qxumo9YlYG2wA7l1uaRkg1xK1warsFIMI3Vrrx9fambne6o5u7KaTA8EC177PMKwc0vMX7UqpQeFDriOxtiWfT2ty3p6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/8nXN41Oa3gNMqOV4QjweZk2BsbvSWqY+TccR2YcO6c=;
 b=ZEVGp78+gzyhA6zPmAyoWZwGmfLFao0tsLdT4QtiGggQa8R6hHrX4a/nA+DR5kePOJ+tHyce2WmNC2+/1MRcJTjQWqaehvFEURiOzoHexs8gK67Ca/FfW4By1DQOkik+WTxKstpR/HDbodernMSS6DwwuPfVS5rL/ll5FZwIzOnNo2XIXz+70U5D2/xxtCeQImzaUi/0JamfopFsITxr+2xN58Uy7JKk/naRd4807lllo3ImPc7eOtfmiSYLRfkGiwudcVaNSDqQuTlnwMBL2Jrnxs9d3577mbRyDfCUHMxZtD1DRv8Vtmmk9ycudfichsL2+ejNs/HbcDkMZiwIog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/8nXN41Oa3gNMqOV4QjweZk2BsbvSWqY+TccR2YcO6c=;
 b=2pvVe7qmxW/rx13mbWiUGYGyRximWal9zyGEsh8kb+YKL6iT5p91HJ4Bu/3xcFQpxaZs/iNY+P0P2THy3bk729ur+eaOjmUMmk7RyUjgFOPr5qH/1dHh1o/7+B9RixjwbHpHqMOQjBZFJ3Ixd4pESoQSE6dJp7TSDmR99zjq6fs=
Received: from DM3PR12CA0047.namprd12.prod.outlook.com (2603:10b6:0:56::15) by
 DM6PR12MB4027.namprd12.prod.outlook.com (2603:10b6:5:148::19) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4608.18; Tue, 19 Oct 2021 15:31:07 +0000
Received: from DM6NAM11FT004.eop-nam11.prod.protection.outlook.com
 (2603:10b6:0:56:cafe::ce) by DM3PR12CA0047.outlook.office365.com
 (2603:10b6:0:56::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.15 via Frontend
 Transport; Tue, 19 Oct 2021 15:31:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT004.mail.protection.outlook.com (10.13.172.217) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4608.15 via Frontend Transport; Tue, 19 Oct 2021 15:31:06 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Tue, 19 Oct
 2021 10:31:05 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu/smu11.0: add missing IP version check
Date: Tue, 19 Oct 2021 11:30:51 -0400
Message-ID: <20211019153051.306142-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 873ed1ce-623e-456b-54a1-08d993157837
X-MS-TrafficTypeDiagnostic: DM6PR12MB4027:
X-Microsoft-Antispam-PRVS: <DM6PR12MB402754184F5BAB879592A5C1F7BD9@DM6PR12MB4027.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1360;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xXU/HabrZ5m5+bnaKThHXuOQwt2wkOI/HFWsB7sbeU8bdPJ+ph680shEqolSnEIdIoNvZIj6DgLRbCqjC8xMTJuc1V02ysr4OklIdg9XTFGdkiFz1bbYT+qsIuG1Dc8hLUfUeqhGyIv6cjgNIoLu+1504R5FSHU1mskQomhYXPXe4y4Adj7U8m9mMgg5d1d0jeOyvkfuiaRKH5X3CCHUxEtFaIvy7HVsvkCoDxKVd7ngxK5YVklx+qenePK8y1ROdIocxtdAGhExleZ/tDJNZX2/hMR3/sXjhwIy/SJ5Rqj6C2Mh8R1nFyq4/SCGymvlTqG8pU+mIANJ7yyW7TDMv56u2jNPHxXZqCoAtv47Wt0j1wmu54AYp+rrfJ6VFckwCKk2tcxeSLQPb/8AXnBmStSuEgFIRhvJxbWrHDNN8xNTxNfgUALc4v4dWCW4uv/Z/ryW22+fzYCpQeWTALfUl5JyzXHa1/HG0rU3o7Ew+2j3v9Az16uHpdK0wD26geEMbxFXqn5B0ING/QnT0EeyQU1SaM8CeIABgh8iYsUbVPuX/HmG1KdorDSM3W6UO0oN5Gj9fFhSYHuyZ8pw4793mNdcArHfnaYDkAf8s1ylXjUVJSYsRdZnic6J3h6Tm5QN6e8NEJA7BO1ND2ipsNGbm6r2O9ss9WLxilZIpPNIePrCZ36F99pdEtnN06EQpyqyLFn1cGCae7nkb4VYaPHlRdo49EY7q19zc+ZrIawWrIY=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(5660300002)(70206006)(4744005)(2906002)(6666004)(316002)(186003)(4326008)(1076003)(6916009)(336012)(2616005)(508600001)(81166007)(70586007)(7696005)(356005)(16526019)(82310400003)(426003)(8676002)(26005)(36860700001)(47076005)(8936002)(86362001)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2021 15:31:06.9294 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 873ed1ce-623e-456b-54a1-08d993157837
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT004.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4027
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

Add missing check in smu_v11_0_init_display_count(),

Fixes: af3b89d3a639d5 ("drm/amdgpu/smu11.0: convert to IP version checking")
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
index 5c1703cc25fd..28b7c0562b99 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
@@ -755,6 +755,7 @@ int smu_v11_0_init_display_count(struct smu_context *smu, uint32_t count)
 	 */
 	if (adev->ip_versions[MP1_HWIP][0] == IP_VERSION(11, 0, 11) ||
 	    adev->ip_versions[MP1_HWIP][0] == IP_VERSION(11, 5, 0) ||
+	    adev->ip_versions[MP1_HWIP][0] == IP_VERSION(11, 0, 12) ||
 	    adev->ip_versions[MP1_HWIP][0] == IP_VERSION(11, 0, 13))
 		return 0;
 
-- 
2.31.1

