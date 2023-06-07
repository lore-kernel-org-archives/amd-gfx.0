Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D0D0C7EE2F
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Jun 2023 00:55:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9A6A810E407;
	Wed,  7 Jun 2023 00:55:51 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2042.outbound.protection.outlook.com [40.107.244.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C0FC510E408
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Jun 2023 00:55:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VLbRv8GvPp/q9ZZ8AUYsCvp6OyQHE1lEUeBZc4xtNyc0QUbBeglNrOIjuZyxePyn7uvGPECf3rVJ8fSgJMUGmMVRCDe1NmrhjOBVeegloGyYL1GUQHoGSq5x5o24Qm4qJEVdfzgby0iRXiXTpMqsR+8IMKsKAy7E8f7uIae5A1fOmVKr5j5zU2x8uKURHza6G18aiZ9lf90UMEY6GCCFFy2JZWI+YLslu4WvyzPUKztFVe0rFt4wD+u8vNWwY/qE2yufuHObjLWHwRR+G38H+hftnr3o37PGM/BM2CSsohLzPKw49iE3JZdy1MvbUoG04a08Sm4Bzi2yBGgWhGx0vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LeEO+K8ZRJaTboAq2fyqf0u1XWZAuVh9f0mTNqO/Xb4=;
 b=GoABHymxXfMVolhsOMvhXYMsXdmf5cs5LDU9aPgl9ISBPD7YECwS+KPRlBPhE7a6yQhom2PBbhGQJtUp9DqONIK0ztu1TNfX9zNMqPgL35iPCUBfIn28UIgEE5YXuYnFhWVklcyqnsE124T4kqWiKFbddjSBLx8tnsKfCOk++gU9DGlCtXIiV9zmGCM/6z2H6gxcjZvjLkVOMSk0yl8HrSpRbJGZZuwN+lzrHNdL6Sx5COxYy6HsfKFhLrg1eTbURuxHwGVsjvClVaI+ZvfP2J+Lkeuy+hOJ8BWDNcjkVNiu2bkwvwNMaqBgtSGsMvi6F+0Lrz3jBSkIdrZjWGd+Jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LeEO+K8ZRJaTboAq2fyqf0u1XWZAuVh9f0mTNqO/Xb4=;
 b=fE1JoOLx0g2BBmwJ4ynxcEYldUPbmVHcz3QSdWrZiRcITn/W7pjeJIiN/7OOGHSCRYrB1DKd9uhQVK6RykuONB9AIVDcsUKot+6eD8pYUh4UzEkZ7CRhkiNwrCZwIPiDYrjaXZgmxdqzWiLq4kDU7OaUD0mIgMJ10FvEpyHDE6M=
Received: from DM6PR11CA0010.namprd11.prod.outlook.com (2603:10b6:5:190::23)
 by PH7PR12MB7332.namprd12.prod.outlook.com (2603:10b6:510:20f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.24; Wed, 7 Jun
 2023 00:55:47 +0000
Received: from DM6NAM11FT082.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:190:cafe::68) by DM6PR11CA0010.outlook.office365.com
 (2603:10b6:5:190::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33 via Frontend
 Transport; Wed, 7 Jun 2023 00:55:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT082.mail.protection.outlook.com (10.13.173.107) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6455.23 via Frontend Transport; Wed, 7 Jun 2023 00:55:46 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 6 Jun
 2023 19:55:45 -0500
From: Yang Wang <kevinyang.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: skip to resume rlcg for gc 9.4.3 in vf side
Date: Wed, 7 Jun 2023 08:55:33 +0800
Message-ID: <20230607005533.2551926-1-kevinyang.wang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT082:EE_|PH7PR12MB7332:EE_
X-MS-Office365-Filtering-Correlation-Id: 35dfc52c-d70b-48ac-8b03-08db66f1edde
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rxlo9EZcXH8HeW6IXND8nHx4xUJV8+aHGQb4xKEfYFiNWzKqR3NHe2hfhn7Er9sQ9mG2eGvw86Ovmuc3uEx1msY5e4aKVcgL1bTqlVYb4xSiK27kkZ9XLmBxjW0e4FmQyS9/E4pYKYML0ygdqwQt+ZVULyInSi3wvtesu4813yAPLFUv0cIB9HwU/YYFejKFNygFYcgh8mj1HnvKCtqpqOQKdGQPijHGP/Nk0Y71FcJ3um4+7yl8xygVzB+Xv3eqA9E5BCCw1ky7yUPEg2EFokRCBqq+T/7EZ+iKwytWjc7ojrSFSbyD4X/zDWW/ku3QfrDjzb77hE037Z0IAauVURHYjBvAdq2k7CH3PSrNK5UnSckEQSCfZPG4MpjSg+SmP2IZRrexhypW1W+dnSRkVirx80CQGmlVpNxgBRLY2ICBf95LfefeYyyaxZXp/v4kIL0dXOSKcolF38hLMCOmZhGI4B3HS0VYKNT880kt8wMngQV811c9PX/zXj9Z4jjfw9aYLNU54ZGCzmajaI6fKrekz/xII7MMpyEHuFURUePU0sGepmSYNb/QcN+MmpdM111VC4hUeq8DpegO8Y8mkNGD8o5UhvmgVGIvLKdRwUxhZAZBGqCjUxgWR23e508tap5IIhqMMNVREYBxBwOdbMK1piJdkn39d+U5MF+Gh3zfhGIuaoXIr+9awS47Hh8CSjtHDJTAwS03cUKAp76FKeL0BnI8RYWMmUSs/2jczG9xuENMp1kH6txA+j5vISlIvR4VDSxKIGdEEAsa9n49tQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(376002)(136003)(39860400002)(396003)(451199021)(36840700001)(40470700004)(46966006)(70586007)(4326008)(8676002)(70206006)(6666004)(316002)(6916009)(2906002)(54906003)(8936002)(47076005)(426003)(336012)(83380400001)(2616005)(41300700001)(186003)(16526019)(5660300002)(36860700001)(478600001)(81166007)(82740400003)(356005)(86362001)(40480700001)(36756003)(82310400005)(7696005)(1076003)(26005)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2023 00:55:46.6055 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 35dfc52c-d70b-48ac-8b03-08db66f1edde
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT082.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7332
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
Cc: Lijo Lazar <lijo.lazar@amd.com>, Yang Wang <kevinyang.wang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

skip to resume rlcg, because rlcg is already enabled in pf side.

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index ebdd7fa985d6..f5b8d3f388ff 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -1293,6 +1293,9 @@ static int gfx_v9_4_3_rlc_resume(struct amdgpu_device *adev)
 {
 	int r, i, num_xcc;
 
+	if (amdgpu_sriov_vf(adev))
+		return 0;
+
 	num_xcc = NUM_XCC(adev->gfx.xcc_mask);
 	for (i = 0; i < num_xcc; i++) {
 		r = gfx_v9_4_3_xcc_rlc_resume(adev, i);
@@ -4321,11 +4324,13 @@ static int gfx_v9_4_3_xcp_resume(void *handle, uint32_t inst_mask)
 	for_each_inst(i, tmp_mask)
 		gfx_v9_4_3_xcc_constants_init(adev, i);
 
-	tmp_mask = inst_mask;
-	for_each_inst(i, tmp_mask) {
-		r = gfx_v9_4_3_xcc_rlc_resume(adev, i);
-		if (r)
-			return r;
+	if (!amdgpu_sriov_vf(adev)) {
+		tmp_mask = inst_mask;
+		for_each_inst(i, tmp_mask) {
+			r = gfx_v9_4_3_xcc_rlc_resume(adev, i);
+			if (r)
+				return r;
+		}
 	}
 
 	tmp_mask = inst_mask;
-- 
2.34.1

