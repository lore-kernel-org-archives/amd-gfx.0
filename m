Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC0A1C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Jan 2022 03:36:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4415710E98A;
	Fri, 14 Jan 2022 03:36:44 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2068.outbound.protection.outlook.com [40.107.95.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7045410E98A
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Jan 2022 03:36:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b5y9qakdZsdcrUp9qhSQdEQWfZumHxfeV/7nEjObwdaS2W7kx7ju42DFMzfivvKs642GSV0roGtHx7Ium2Zd3o3xvcXKwyGelZxBvZ6I1ukxqjk8mIf+/jnvgiMfwvKTl3OZodZycDLyNQ0dZpY4dAOdy/gT+F7RrjyI+O4QiWIpVS6sjBVIrQTi/jG19KU4hCAPso/oJzX5UaS2fbNd7/8uOfONmX/ENy3vmebgHfJMPKpC5yqOJ4jUCkyKJHSK33LD9GIK+mBSGuuFC0nUeQctlIwrTbVY8U4tlZEyt2M+3GRQmWUPGNPE1AIlM2AWofH5i52jC4ZtEqZWW0sWFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gKSF0UwUHyJFtXBOSAjooA8JoR1kV2cIum0Pruk9L8Q=;
 b=oM1AJYRPFYUg6FvOTlvpRR2rD4fdNIHYa5cBHw/9pAjYLf/77HVkGLSUeV/UvufWc3+IfzkfWApjaXwnZ5KuHYcp71YaPKfbtT+wRicXvDVe7Dvmn9AefxkcyvRDZlhRRcTGet2Wo8G/pGIDh/dJXDaCXypMQMOnPWc5QmsWnI2fQkq7cGl3Ln8eg5fjYRYLaPwesopGQG4YTTXnYIJW630uWN9ZKnWgbMJ1snPWitFjtm4joDnrjl4oDG6OCqsLaWSCCT/ZQTkqbMWJmnA3uUrVQ05bQXIea8e2ifftM9cFUhHHIYdCW83DxSgwYJFGkYrXSImKeLWwK0fvtsFHgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gKSF0UwUHyJFtXBOSAjooA8JoR1kV2cIum0Pruk9L8Q=;
 b=QVWINXrNlF3W51XZLw3BItRz+nYm30wnFI4BBaRGz0uRNAovF4mhaSK1c2EVm8DRCOjsNQlAMaUxTKnDodCQmZNYgAekJw/bxCsLTKouJc4ILRDpvyqxzzUfbUAKOa6UOhLpnXUTAc874bxIrtw4Q39WWUiNV1EFmUUldxU+43g=
Received: from BN0PR10CA0015.namprd10.prod.outlook.com (2603:10b6:408:143::33)
 by DM5PR12MB1931.namprd12.prod.outlook.com (2603:10b6:3:109::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.11; Fri, 14 Jan
 2022 03:36:38 +0000
Received: from BN8NAM11FT017.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:143:cafe::e5) by BN0PR10CA0015.outlook.office365.com
 (2603:10b6:408:143::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.10 via Frontend
 Transport; Fri, 14 Jan 2022 03:36:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT017.mail.protection.outlook.com (10.13.177.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4888.9 via Frontend Transport; Fri, 14 Jan 2022 03:36:38 +0000
Received: from thomas-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Thu, 13 Jan
 2022 21:36:35 -0600
From: yipechai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/5] drm/amdgpu: Fix the code style warnings in gfx
Date: Fri, 14 Jan 2022 11:35:56 +0800
Message-ID: <20220114033559.4009592-2-YiPeng.Chai@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220114033559.4009592-1-YiPeng.Chai@amd.com>
References: <20220114033559.4009592-1-YiPeng.Chai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e7d8a27c-355b-4799-fd07-08d9d70f1253
X-MS-TrafficTypeDiagnostic: DM5PR12MB1931:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB1931A9BE58717FE0A9F87C86FC549@DM5PR12MB1931.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3383;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: c0vXAGU8RsSV80448k27Gmce7EL5O+6CNIIe4C1ptPBMlFy+c69K0mubhZU9tA3BFDgXE6vlBN6k1W+s1FiZ3Mn5RsJx7YTFThxJJ3s4Ie84lemJqfFWXagt3RDrjm8hPx+Mhx6Auth5skSMnpJz0eCzwsEGF1fMQmq3pzQQOaxyaNCmanbuLaLaRITiTRfF0VpR2gDO/vNV9Shtq1UrdK1ujasTd0JCVWnVl+6Ui/GTuOgbildPHwKEHkACVSLbVzhN5Dr7c6ueWOqCg7PJUfSgFBNk8SdiK72Cv1yu3ilO4VJSbV/4+fj9JYt4YaIqG7sxeOV44utHdm1UZA7Y0HQN0LtqTt49iOFVNR7KzpGRIZoL9nR7O6aBCSxpnL/f7GDds3okWz2ZRiXdWDSTE80Ixh0DNfIKdjwvjkbkrDjtY+TDWKYdPuyxHgBHx023E7nP8uvzHjihtWFvbJCV4DNaklhoKXIfRlB/llHPgELhNc9dyhteuFTIxpygllEJNPdnCLjWUzBEnVt3jajMuKjSWBj5U7CE3DZHg0ztWJPzheVLH7SO7UqJ7MFcKF3GrzRYRKn+ExA3xprAEqTZHt04gGUKQ0R/X7utX8E2a7GpX5YNfoS8pF6kb45vmApuH8cZOTZB9BLlQA3TfkWIwzOOZOSXTJbRElkTwgBJKKFC/99u+GOA0n3sI1IJCH06i53mQ0JfUrL0hJIdI4l+0NYINm+RmQJfPNuhwH5lanSXoxwY2Km27ct5Woj2Fzxt6IIk671wnIhj48l8UiRQVmBzUj3jxu5Mc1zlDFZIxiCBPwPrj/h1v16gebT++ii4
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(40470700002)(86362001)(336012)(508600001)(81166007)(2616005)(4326008)(426003)(47076005)(40460700001)(8936002)(1076003)(7696005)(82310400004)(6666004)(36860700001)(6916009)(8676002)(70586007)(5660300002)(83380400001)(16526019)(186003)(26005)(54906003)(316002)(2906002)(70206006)(36756003)(356005)(43062005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2022 03:36:38.1298 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e7d8a27c-355b-4799-fd07-08d9d70f1253
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT017.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1931
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
Cc: Tao.Zhou1@amd.com, Hawking.Zhang@amd.com, John.Clements@amd.com,
 yipechai <YiPeng.Chai@amd.com>, yipechai@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fix the code style warnings in gfx.

Signed-off-by: yipechai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c   | 4 ++--
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index d36a6bc62560..e12f9f5c3beb 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -2314,11 +2314,11 @@ static int gfx_v9_0_gpu_early_init(struct amdgpu_device *adev)
 
 		/* If not define special ras_late_init function, use gfx default ras_late_init */
 		if (!adev->gfx.ras->ras_block.ras_late_init)
-				adev->gfx.ras->ras_block.ras_late_init = amdgpu_gfx_ras_late_init;
+			adev->gfx.ras->ras_block.ras_late_init = amdgpu_gfx_ras_late_init;
 
 		/* If not define special ras_fini function, use gfx default ras_fini */
 		if (!adev->gfx.ras->ras_block.ras_fini)
-				adev->gfx.ras->ras_block.ras_fini = amdgpu_gfx_ras_fini;
+			adev->gfx.ras->ras_block.ras_fini = amdgpu_gfx_ras_fini;
 	}
 
 	adev->gfx.config.gb_addr_config = gb_addr_config;
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c
index 7ec6243e015e..7653ebd0e67b 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c
@@ -1930,7 +1930,7 @@ static void gfx_v9_4_2_reset_sq_timeout_status(struct amdgpu_device *adev)
 	mutex_unlock(&adev->grbm_idx_mutex);
 }
 
-struct amdgpu_ras_block_hw_ops  gfx_v9_4_2_ras_ops ={
+struct amdgpu_ras_block_hw_ops  gfx_v9_4_2_ras_ops = {
 		.ras_error_inject = &gfx_v9_4_2_ras_error_inject,
 		.query_ras_error_count = &gfx_v9_4_2_query_ras_error_count,
 		.reset_ras_error_count = &gfx_v9_4_2_reset_ras_error_count,
-- 
2.25.1

