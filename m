Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C881BC433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Jan 2022 18:04:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6402110E218;
	Thu, 20 Jan 2022 18:04:47 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2052.outbound.protection.outlook.com [40.107.92.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ABA3A10E218
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Jan 2022 18:04:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZwCH/iQtldwAzghHfyFeAOU7cq9rWBW+Wkhwc6Qg7546AhY7ZI4NgooTPSzi9mzQRrR8k1KiJcuKfzG+rpyUYwwEOK1RlsAACSR4nJ8QST+grgYq6BFU4ZqSIXj6lByhkRVoC6GdjI4ULoz6JJv/+Mxp2u18OuA5bGHIbWXI8aV5vcLM8EmChG1uyFp0dWtuBMjQJsUHC67b0kGSpElMFvxHpxMy4rOXU4sMw7zzcw7XhzkUvYDL5Uy9ANtTTIvWx1Y+EZxFdXSUs1NQJ+ONscJ63iue1PRsSO612ycDFvDcypqmA7jFKkEycCqMOUxK1YzGUhph2z2DlULDvgZUEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XcGDUAUXPmt/Nwrv7YHPaAT8OHq7mTZub/Ba+XeEo54=;
 b=h4X4zXilOEzhB4lqXtdmnbyf+cMepdpb2X5USgwJ/HfOERgijBfEG4HtE8kHDFB8/26Fb0GAyYViyIbkMJifrZu+jJAO0xZQq5E8dHa4tEPCTNmnUTFgNZHHdIheoM1IUw6GxSeSDas9+cjrYWn5H/wzWAHffO+6SUAMJHW0ADH1Llj2Xr/wgi3DzUN8Pj006wp2A9nd5chE4Sox8VOdaJFgudSGSjznCnNaJeiEl4rRgO3H5Vdp2Dq1AXDokPGPa9eFhsNnnSAj2vMBlE3rugCtAuUIr2mPE7ca40SEkJ5UUgJpbn6YGiM8iEUbRftUeJNjbPIrUFEky/ZHtRvKww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XcGDUAUXPmt/Nwrv7YHPaAT8OHq7mTZub/Ba+XeEo54=;
 b=SaTaUNGXdwEH6GxXoEhQSlyySKFsZfSxnIWWNIt7O5Hb3WJs9u0Y+VSkO8bBH1E2VSqX+fq1y/7v55SumpcIUsSjCqni5U8oBINEdhMc6VjSxp+WK8fjgMmfpN+gwkAh6/71WKssBBUhGK1i0B2sgKm/u0r2+nDHFLj4ABgQP5U=
Received: from MWHPR13CA0028.namprd13.prod.outlook.com (2603:10b6:300:95::14)
 by MWHPR12MB1661.namprd12.prod.outlook.com (2603:10b6:301:3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.12; Thu, 20 Jan
 2022 18:04:43 +0000
Received: from CO1NAM11FT054.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:95:cafe::b6) by MWHPR13CA0028.outlook.office365.com
 (2603:10b6:300:95::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.4 via Frontend
 Transport; Thu, 20 Jan 2022 18:04:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT054.mail.protection.outlook.com (10.13.174.70) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4909.7 via Frontend Transport; Thu, 20 Jan 2022 18:04:43 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Thu, 20 Jan
 2022 12:04:42 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] drm/amdgpu/display: adjust msleep limit in
 dp_wait_for_training_aux_rd_interval
Date: Thu, 20 Jan 2022 13:04:28 -0500
Message-ID: <20220120180429.616236-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dd6c7e98-fb2a-4cd3-856f-08d9dc3f5644
X-MS-TrafficTypeDiagnostic: MWHPR12MB1661:EE_
X-Microsoft-Antispam-PRVS: <MWHPR12MB1661F12A7B0308C428166EBAF75A9@MWHPR12MB1661.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dZsLZM/2znP0jy5E8S1td3Bjej73vLb0w+TBWIutX4v+0Ja67Vsfn9WXRJ4fpkyOYEzMnlUQ2ZQxncW9tZNbqSj60hYiL2HnP2akSWYFAsarIBdhZqIMWCeBBjq9nvveXJ7CKuGFRAtdpL/EcYaIjRRZVIz7XFNSPVL1Or+WWPNqyyguLJrG3YDc5BzsRr9D+L3dWNxtI53XGkoaR/Br29xOc531Ox5dqbCSL+hcctvfBFjYL6YaJRxtZblpLmCtt6KG5m3vy1gEY7Fn/OwceWWR+2NVLo300SzKBCvkNy1sryy6TuIwfGCNAVoRfJp9r7oxxk2Egi3cRdDZKKfI1C5Fuets/JH5W4Wx57KgmZg06Kr3DZdnIpeHi5dgzLxLS9TLAPkOu5Xbx7zLl5KlAQBoDoEgfx61Vt6ChDhQh9CK6TJ4ebDBpGhjKhiYvZh9TV2ThcL/j2sOo3t/3fHlLwMre4NGmcUqgVfMbO9ouuW6H2OHeqZ5lWPTsA7EV96SKe0ceGKbGo/5DVgzbc9P2N5LdMluZsDAPe7iopZ+x1HQ8EeEYa5Sm8MpmKMaMFx1XP2NfHXnt56ZEk4tBawqYLHQRhR820At5FYlEWbs6Ir3/xiAS7p4FSoKO3B/9yw7LlPG1MxDfdRyiKsS3xAxcx5qbKB0iSpMr7yeUmy5D1NS83QvZffq68OSzwbTVqXJYaLh/tdn4BFnZCQ4Ih84UulCJc7w64iWJBv1SQcoJPygs6v9AuIFiFXaCv3R6WNt9DM5lVI4FZ3SJpdLeNF2VlSP6rplramXXaHHAARykFg=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(40470700002)(36840700001)(36860700001)(6666004)(4326008)(2616005)(36756003)(1076003)(8936002)(81166007)(16526019)(26005)(508600001)(86362001)(7696005)(83380400001)(186003)(6916009)(40460700001)(47076005)(356005)(426003)(336012)(5660300002)(70586007)(82310400004)(4744005)(70206006)(316002)(8676002)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2022 18:04:43.6455 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dd6c7e98-fb2a-4cd3-856f-08d9dc3f5644
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT054.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1661
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

Some architectures (e.g., ARM) have relatively low udelay limits.
On most architectures, anything longer than 2000us is not recommended.
Change the check to align with other similar checks in DC.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index 1f8831156bc4..aa1c67c3c386 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -202,7 +202,7 @@ void dp_wait_for_training_aux_rd_interval(
 	uint32_t wait_in_micro_secs)
 {
 #if defined(CONFIG_DRM_AMD_DC_DCN)
-	if (wait_in_micro_secs > 16000)
+	if (wait_in_micro_secs > 1000)
 		msleep(wait_in_micro_secs/1000);
 	else
 		udelay(wait_in_micro_secs);
-- 
2.34.1

