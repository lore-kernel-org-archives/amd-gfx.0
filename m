Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F59AC433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Jan 2022 03:34:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 55ED810EA73;
	Thu, 27 Jan 2022 03:34:46 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2073.outbound.protection.outlook.com [40.107.244.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C2C0710EA73
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Jan 2022 03:34:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eGFoGlIjwHasxkGZCRY8eeLqOjcfyzUBL8yoWl5hQs7axxmik7RSnE1VjDW9vUyXZbJVNBOK4gQuJM5QmIdDABWGTY1D9oBioAHSEqfouvAjJWqsa7tGVYG2QCBmrsMBx3oGDu8NVXxa4ePOfAEU2dfUkdQhF56FhvL1a/ehMQS3Hz0hSH2mC1h9gHcf8NjTmSs9letJwRQ+rljQSh1RpHyv2H8mtP9njrMedywzcEcANIHobTUj8pTBpi9dJZEVw7FPGIYfZ6qjXbRJ52FNRkWsa1Ovz2HET0QcwPjLbVGXmNBIUo9xXNfTcWYCDG4nHpBefiFYRIwMd9p7STqUOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mn62g0O9CSfiMmuvE9ZxiQhI6IyhmQ80uxeH80p07oc=;
 b=UYriGu6iGV6MVCzxjfk9yWqUCZVFfZzcuZACplY/UFSsdxYOFEiqXfcMcP2j4uLnzmgZlD9CMNKCNPZZIp/KEx6N5VA0HAL3zlUplDEJUC5PjetvsRlHmjsHwXqlLL++Isjq8buQ8IaWfxcZYWVfXB3F8NuGR6ILBUgr9aIq0QRx8cVR1ymDnSDn6WnIh6bChFoIll+PWtu0F3Jwhwy7Nb16i5WHbFeKPlNAo04fOu7Q32jmvsS9LBhY0Qo1Nxxz3eDf4ri+qP/BkNKXfnjv7YMFAqkmp4SMVLIH5n+A0GP3Dufp5bppPS3Nd0hymFUhHmSHCLPaz97OXuW6dfIzfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mn62g0O9CSfiMmuvE9ZxiQhI6IyhmQ80uxeH80p07oc=;
 b=qlbYutbtzL2BhYxA2FJ7aV0ao2ft2OjWOBaABMl0OAb7WYpQvC4ykv7U4bhb9BE2MR97nAKVAZ4laBqGRQ+kWax4vHvwcc9gPD3KFEVnmA9SQEHXzzygrCrxPhFo5utR5WFORjyGT/gj9SJ7tjZdJBz4R5v1MmsFK0CzxckpNJI=
Received: from MW4PR03CA0220.namprd03.prod.outlook.com (2603:10b6:303:b9::15)
 by BY5PR12MB5015.namprd12.prod.outlook.com (2603:10b6:a03:1db::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.8; Thu, 27 Jan
 2022 03:34:43 +0000
Received: from CO1NAM11FT056.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b9:cafe::84) by MW4PR03CA0220.outlook.office365.com
 (2603:10b6:303:b9::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.12 via Frontend
 Transport; Thu, 27 Jan 2022 03:34:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT056.mail.protection.outlook.com (10.13.175.107) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4930.15 via Frontend Transport; Thu, 27 Jan 2022 03:34:43 +0000
Received: from ldev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Wed, 26 Jan
 2022 21:34:40 -0600
From: Tim Huang <tim.huang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/display: Fix unused variable warning
Date: Thu, 27 Jan 2022 11:33:50 +0800
Message-ID: <20220127033350.2550086-1-tim.huang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 31aaf334-c5c9-420b-65c4-08d9e145f548
X-MS-TrafficTypeDiagnostic: BY5PR12MB5015:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB50156DCBABB7EDA7271D6537F6219@BY5PR12MB5015.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3383;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: O9OCpXItMDJv+k822Vhu1Or36JP1Kqd66fdD9gSaFst9HGfzeTe8xKALKZ3hFcihrHzMdq7AjuW9Nvj8TkPO/DVTG1QNWXwd1s4G6fUCkYtsSE+SiM2bdLzwCBamtH7bQrYZKNnj7DErCY+nHXf9i14XTXxjrarwHpu4GhZcLEs7rh3YPXAOmLhgGwSBwIHg7UOBFZKZPyFzRf94q3wrkSgiF9MYbtXEk7eUdPlCV6ttldpGc5OMj9H1/UztD0gskBjThkkC5Hvnyde6Xi6erQFbdgPo2f/w/CRdPO+0QkVMMssdLpNJN7q/YAn7zKH8HsX7EtMuv6YlI7Uo5WxJAMDMKzqlxcibuVC3NYxWvfkCU57JPkEC8W8Kj/f1BihEDnuOva8WYDRGryVtjc9C7+cNie5KS8VVgSTrLdV0benyQ4pT4+xAEIKE8cBY10yxhAwd8PJaQZtT1XVMAosZFHWbwt0DShGfa3snm174XGYRyTSnXpiwmdVhejiOnDwPCQZnG8txMvDNk1EwHni8jCSBvGurFRmgTa8R/g8SlT+8/5YxJYxy78fmZmH5zJQCd0C9CtjXD1bGRII6JGqcUTFejmkl+MaXnZYU/JUOTLqawkESPv3hu6UedBZh9jMmty/lSsXbMAAKSH2WlbjybW+RidvkK0HvrKWEV0TjJKZUm2ByUEzUxF6bDPPfz4zm219etA3HzXRdvtKlbAISI4pWsBU8Z+uPODpAZMznm8ah7uRwmt+ME+cu5XloHLkyhL9bjujlduJ+L5UwtL9QR4la1wbIcmBiPixwlj4nXBM=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(40470700004)(46966006)(6666004)(47076005)(508600001)(186003)(26005)(2906002)(2616005)(336012)(36860700001)(70206006)(83380400001)(36756003)(6916009)(16526019)(7696005)(356005)(5660300002)(40460700003)(44832011)(4326008)(8936002)(54906003)(8676002)(81166007)(316002)(82310400004)(86362001)(426003)(70586007)(1076003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2022 03:34:43.1760 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 31aaf334-c5c9-420b-65c4-08d9e145f548
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT056.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB5015
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
Cc: Alexander.Deucher@amd.com, Tim Huang <tim.huang@amd.com>, Ray.Huang@amd.com,
 Aaron.Liu@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Why]
It will build failed with unused variable 'dc' with
'-Werror=unused-variable'enabled when CONFIG_DRM_AMD_DC_DCN
is not defined.

Signed-off-by: Tim Huang <tim.huang@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 1057f976bec7..8f53c9f6b267 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -1027,7 +1027,6 @@ static int dm_dmub_hw_init(struct amdgpu_device *adev)
 	const unsigned char *fw_inst_const, *fw_bss_data;
 	uint32_t i, fw_inst_const_size, fw_bss_data_size;
 	bool has_hw_support;
-	struct dc *dc = adev->dm.dc;
 
 	if (!dmub_srv)
 		/* DMUB isn't supported on the ASIC. */
@@ -1123,7 +1122,7 @@ static int dm_dmub_hw_init(struct amdgpu_device *adev)
 	case IP_VERSION(3, 1, 3): /* Only for this asic hw internal rev B0 */
 		hw_params.dpia_supported = true;
 #if defined(CONFIG_DRM_AMD_DC_DCN)
-		hw_params.disable_dpia = dc->debug.dpia_debug.bits.disable_dpia;
+		hw_params.disable_dpia = adev->dm.dc->debug.dpia_debug.bits.disable_dpia;
 #endif
 		break;
 	default:
-- 
2.25.1

