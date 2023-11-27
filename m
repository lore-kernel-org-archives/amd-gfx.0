Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D362BC4167B
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Nov 2023 22:32:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A894A10E317;
	Mon, 27 Nov 2023 22:32:54 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2064.outbound.protection.outlook.com [40.107.93.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 54A3F10E13D
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Nov 2023 22:32:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X000wl9wA1F9sNpSMlsqxAhgLF0eETG34rk/NLGKa3aQnkqTcnfuEobri6EF5jKcaU0LkCVz8HMhRwpUG5YEbmP+7RLZo425CHOgr6dUtl0LhgnL1vyhXx/dXwujWDzf1HF8g74cjnhOV32PQ+ZU0zlJxP7/MmJnWsLYoIW+ySSWJGIhSxJaSHiquQEylROl6VcnW4EPWZrUjMYrKUS/4rTUp6YGmVA0uFQQLrX88lUWI1BWvQmiIFpjVpdICc5Dj2aq81jwZBBvisMrLNq+pMHm5gBc8AeVPuOKewT6qrY/v+LAXRZZl5nBSCgi9CzAZpEd8Laf1Ys2OI2tOJplqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WKyW6eVntq59ymbw4OPvnQbXo7izQAF167wIeALoguE=;
 b=lV1IKOWCWzdp7UwglCF9+QtTVAAEbNbRFhZBoWg0QWo0eUsbj8v7Rp2uOq9iLyfzMb/3d8xdtLioH0Na+eUh9hl5/8usR+Nczod8Wp8AYssaBIWWkiBqVfNzKQAWRf0WBjLjI7wvsNECIiD6UW33yU5q23Ph2m2Humn9DA0F1fWkU+HFhmIUEtZmV0MzralJrdBuT4kg/MGbI8QILoYoWltkDKqH49w3yca2tiaTsm3aN+BSYji1gpd7aBiUkAtF02yCr80YNzRJoMa2+TCxJfnWhee0lvGuvbT6MvrwOAtGLQ96hwwdchCxvuAmjKbJus2L3ULZ485HJypqxOO1EQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WKyW6eVntq59ymbw4OPvnQbXo7izQAF167wIeALoguE=;
 b=pUDn/b9PTFEuALPyW0FpCkds6fEXRCLbEJxw5Mgny3aeJBF3uNC3LZ866h5q2nmDe+v7LtSV0CK6dmRf8cbXA1afpaOr+XGWx3y5ZEpEloZ+1Vm0RnD312gn+lo8zPRCcyGPd2vBD6qmlgiMMR06DZgikLXJBlg8AXDtRpc7BRw=
Received: from BL1PR13CA0002.namprd13.prod.outlook.com (2603:10b6:208:256::7)
 by MN0PR12MB6056.namprd12.prod.outlook.com (2603:10b6:208:3cc::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.27; Mon, 27 Nov
 2023 22:32:49 +0000
Received: from BL02EPF0001A105.namprd05.prod.outlook.com
 (2603:10b6:208:256:cafe::e6) by BL1PR13CA0002.outlook.office365.com
 (2603:10b6:208:256::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.19 via Frontend
 Transport; Mon, 27 Nov 2023 22:32:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A105.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7046.17 via Frontend Transport; Mon, 27 Nov 2023 22:32:48 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 27 Nov
 2023 16:32:48 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] drm/amdgpu/debugfs: fix error code when smc register
 accessors are NULL
Date: Mon, 27 Nov 2023 17:32:33 -0500
Message-ID: <20231127223234.891204-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A105:EE_|MN0PR12MB6056:EE_
X-MS-Office365-Filtering-Correlation-Id: 13db7713-76e0-44d6-6f1e-08dbef98c8f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 553XlzEeUUZfhOAlNPw/zpV+y4vd5O5FVsCE1hCEkzuIfP+dQ3U9KIHxz/69r/vJ4G4BUjqIJfTuX6MXzSif/tjEKEdqGIjbeXGYQiXe/yJrU4ILJeMP852ARqXykb5C5dahIlYAAvVqgW0zcLSv40ogHNZWdt1LHdddWK7TBbQ2y3WvknkLrICAkvKjL8hhA3UxQA9nBCYcaeKXrqOLGegfoEifoes4juW30dU7Ua0+HTk0L1RSKyrJe3jmrMBIR+SY8cqlv96WTam0HJze/xmIp2yGnbS03BgmXSoXaoLlg8jSvqFtM2q2/aod4h+GXc5n0wL9PuPjQwsSrjXfXdunE/aAszy5qZhIFaVYO9zeEc27QFeUO8XyZ9V95BLsw15pSYAaFmxkuBV9JRm4g1kQACz/QQ7jNh95zpTrchNxC3/Fpsijll3Iq/xd+yIE5IhtNWTCXDgDfcNNbLQfE36ACm8GGrfzYcMLReaz8HUmQWlgvDtR8IfFMHuYFur6EmFdRcpRumB4zRIY6lhPwULq59J/7wByTP6FtKH9udZkXpTwguyk0G0nTBVm4iErHpQLGNKXBoEmgX+oOkgGwMDvFlXJ8xsUvQP1F+ryRTDlHzAcKpxu/qMOzeZwueTDla+jRPT3kxrpvWYs2uFUqYHEznDUGXMST3p94OLPrJiMnwcJ9J5LZJr7QppC204Hk5C14rin4IhUhHI062NgUrphroTkBlcUYtpzAa3aUHPGo88qIoOZoh9RQZYTy4J0/1sgYQss21aJpXZr1gIZUw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(396003)(376002)(346002)(136003)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(82310400011)(46966006)(36840700001)(40470700004)(6666004)(8936002)(8676002)(4326008)(7696005)(70586007)(70206006)(6916009)(316002)(40460700003)(478600001)(81166007)(4744005)(356005)(47076005)(36756003)(41300700001)(1076003)(86362001)(16526019)(26005)(36860700001)(40480700001)(2906002)(2616005)(83380400001)(426003)(336012)(5660300002)(82740400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2023 22:32:48.8405 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 13db7713-76e0-44d6-6f1e-08dbef98c8f6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A105.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6056
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Should be -EOPNOTSUPP.

Fixes: 5104fdf50d32 ("drm/amdgpu: Fix a null pointer access when the smc_rreg pointer is NULL")
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
index 0e61ebdb3f3e..8d4a3ff65c18 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
@@ -755,7 +755,7 @@ static ssize_t amdgpu_debugfs_regs_smc_read(struct file *f, char __user *buf,
 	int r;
 
 	if (!adev->smc_rreg)
-		return -EPERM;
+		return -EOPNOTSUPP;
 
 	if (size & 0x3 || *pos & 0x3)
 		return -EINVAL;
@@ -814,7 +814,7 @@ static ssize_t amdgpu_debugfs_regs_smc_write(struct file *f, const char __user *
 	int r;
 
 	if (!adev->smc_wreg)
-		return -EPERM;
+		return -EOPNOTSUPP;
 
 	if (size & 0x3 || *pos & 0x3)
 		return -EINVAL;
-- 
2.42.0

