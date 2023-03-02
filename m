Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4042C6FA8E
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Mar 2023 19:47:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E5EBB10E2BF;
	Thu,  2 Mar 2023 19:47:21 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2088.outbound.protection.outlook.com [40.107.244.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 328C210E2BF
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 Mar 2023 19:47:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OZ39/Hn4PXBIh/+lga3lULgw58WEGJZCcalkuNggoiRvJX6gDkBdQWNGpyj1kj2GLnFZeqydrQ6lnhmW5KqyPyjEVdI4zeRIPbq5VDMGHg80hkLcNZpQcvB+hW/z4+Eh7Np99SIKXz0xiESAEV35/+AQ59+4eqa1ifSqYMps/2haDfeUsZwKquHHlQDQtjf550n6j9oxixU/eoIKVdk5W+YF4QPoIMAwo63vDjikVd4rlrjupasUjmXL+naKqYOmSWH7mLkfa+aJsVGabS2FPzAw2GTEnXzoA0Zj2a4kvbF5M+/iZpcKsmtpco0ESVTwFTgtJI8j/Z/KY+ufBRZ0Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9qEX9tsj1lBFMT5KsjMmlpxhX4jP+q7x+Ovp9XRk/RU=;
 b=kI9DRetD+z5KzCzBxTuvNRB7W8Kb9IMyOJonkblcsLEKqWSwEbh0VVelI0rhuFSHIne9jZwTp9dd+tadIPfPMmzunxs0lf+PaDoiP800tA6fFU6dakvjEvvXaQl/mVzdtbRhPOoMc2NooPaFKX4BBYBI2XuueaXxvG9bGYMOVYKNDsst3wT4+R+Hn+9r3mAwm+cN9qjFCwhkB762ux8qxlC8i0HILDc5puaanPyu2GXuEg0Sh/8uGkSjHp52a9o+GVrow7hov2Ghs7XJ9Lb7anF3siqgopEowYN6UMypzeqtoNSC5MlT8kyvYNY13L6XVGyDwXoZWWEDOZHsqy34bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9qEX9tsj1lBFMT5KsjMmlpxhX4jP+q7x+Ovp9XRk/RU=;
 b=QnyxrOBt5nIVoft+mat/rDZWqvKsh6yIjrFqOE/5uFLQhbZw6YCNtSlrsbvOPZwQa9UdC24B47OC/hsgRDo2+wJDrRs4XJWy8h/U+eRNHGYtxaBj8f/1VR9wdJS4TN82NmqzRMWPLvFjS6VCLtoOYIXl+oUccjkeOBa6g1QsFqU=
Received: from BN9PR03CA0262.namprd03.prod.outlook.com (2603:10b6:408:ff::27)
 by PH7PR12MB7872.namprd12.prod.outlook.com (2603:10b6:510:27c::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.17; Thu, 2 Mar
 2023 19:47:18 +0000
Received: from BN8NAM11FT105.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ff:cafe::e5) by BN9PR03CA0262.outlook.office365.com
 (2603:10b6:408:ff::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.19 via Frontend
 Transport; Thu, 2 Mar 2023 19:47:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT105.mail.protection.outlook.com (10.13.176.183) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6156.19 via Frontend Transport; Thu, 2 Mar 2023 19:47:18 +0000
Received: from krussell.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 2 Mar
 2023 13:47:14 -0600
From: Kent Russell <kent.russell@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdkfd: Ratelimit oversubscription message
Date: Thu, 2 Mar 2023 14:46:13 -0500
Message-ID: <20230302194613.2659027-1-kent.russell@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT105:EE_|PH7PR12MB7872:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ca9581c-4f7d-4f4a-c999-08db1b56ee3a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: S3buo6iGElEfFl6WLre5ZoZ8w2jc8HOU+iydq4c+1QbAZXLZRck2drzP7jCeI2zAgeNjnkzs4lWdHt22rGc9hDpRY3SVyJk7ekrAEXBPjuOgov//FKNykdCfBUsW4XyH+cE01F7d6bRQhBGuZlB+BtbTGl099h7xvr6bCLkDQ1NyKzbbkLazAeUFph3A4/m6g3mH3Jtk0OQNEy/9I9CWWTQrFQ3uXFXvWwI3CG61BpdFH2mkIhgjGVSquqjsoLxIoxAvCd6bvQeVUpNv2By7piJLkMeYJeDQIpa2YnFxatqnf5GkxLg+c18rLkOeEclFlQLodmvhDjvPW9qcWKIfz2Mf7y7yNPGjzogA2e4a6VCUCfIzCC1FL9YT/olYb7qxm9iaBU538bFu6IQ9QAZ8Pm1ddBN5Ke8HMxsQ85VXPo6RJaofBzoSQAyHX/iOTlbRgdbP7zqeqfKdpw6ER4TcPDHGOEwkKgWYrYtmgRkUCNYZxxuqhD+Y9AmtZwcUg6ocUQ23ZlueeQlhNYeniDk472cWAnKOOxGZMuvM4qqm3zL1/dBJBNSOG2Ms2VFQy4ATmFncPIkhnqOjWRJhppjbL8zCKERMrGlnGQch8z3s17NLLt5oOGEUQUbPqXDbSZnuB9UK7IssiyS0tyYnWsCRLI05l+M3VI1nc94M4svkBMA3rR0Mtz7HbaSN/w8PLGRJ/5yOEZExJetJfHTkWi5x4E1LhYcr/tpjUDda70bFHUk=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(376002)(396003)(136003)(39860400002)(346002)(451199018)(46966006)(36840700001)(40470700004)(36860700001)(5660300002)(2616005)(41300700001)(36756003)(47076005)(426003)(86362001)(7696005)(82310400005)(316002)(83380400001)(8676002)(70206006)(478600001)(4326008)(6916009)(70586007)(336012)(40460700003)(40480700001)(15650500001)(8936002)(44832011)(356005)(82740400003)(16526019)(81166007)(26005)(186003)(4744005)(2906002)(1076003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2023 19:47:18.0555 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ca9581c-4f7d-4f4a-c999-08db1b56ee3a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT105.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7872
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
Cc: Kent Russell <kent.russell@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On certain applications, this message could end up flooding dmesg.
Ratelimit it so that the warning is still available, but doesn't take
over the entire log

Signed-off-by: Kent Russell <kent.russell@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c
index ed02b6d8bf63..9eb3b5feff56 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c
@@ -207,7 +207,7 @@ static int pm_create_runlist_ib(struct packet_manager *pm,
 
 	if (is_over_subscription) {
 		if (!pm->is_over_subscription)
-			pr_warn("Runlist is getting oversubscribed. Expect reduced ROCm performance.\n");
+			pr_warn_ratelimited("Runlist is getting oversubscribed. Expect reduced ROCm performance.\n");
 		retval = pm->pmf->runlist(pm, &rl_buffer[rl_wptr],
 					*rl_gpu_addr,
 					alloc_size_bytes / sizeof(uint32_t),
-- 
2.34.1

