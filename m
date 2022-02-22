Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2221DC433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Feb 2022 07:07:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8BE8E10E874;
	Tue, 22 Feb 2022 07:07:33 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2075.outbound.protection.outlook.com [40.107.236.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 940FC10E874
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Feb 2022 07:07:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=clz7XX74BTtTppxeRyJnXwYDwrJhr7WgHepJ9E0fJs4hW83kVfQ/vc4shUB5tQ61LESDiC8xXqPJ26cH5h7o0nRG+5mzKOzhgej5cebUf3vK+oCkJ+5J3QslSKg80UNxTqzsrPXgnw0o0td46YvTeChTpMCQEfz+EFI/3FlpKHKjv9r15D2yOJSBqsC8widNRlHkg6JV+RNRopRAr4tEUuil5E/E6U6Mh1GN9dRE4/FIpZDy2pJcy703V1Kh4A5xLDo6N3ljFi7U2MUF/J1ZTbRp/usWuhsL8n33ip991sMQjxl4E8kf1wfjwrTwbBV/d7neN0oYnEx9Mdt0qxqVMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=01RRf6O21bMB/1Hj1kbbCmhKz3FtTJi8xp+lm2poyhs=;
 b=HRkXqa+9TX3tdvEO1GLWZsj4Z8IS8krMD6wYV4v1D1a5mttUC8DDjcj+b/n9s+PDrWj+EKTZk1zlkTVH4zJe4sFqCyKGTMKrhpH+MEPC8sGxyIt483sdhjGl6C2bOpcvu+sZS9W0ayqJNP0TgVCdQhBlUKIj1UtMEII5gamaSYMreT73AER38jFBalro05ga/XKkWEKTzpoaokr9S5kA9NIGrlO1G6dXhJrOBlkUVTKE9eIvtR0Oh1PrKUtrQUO4ledDwxkQ5D57WBO5qOtImVMYxZVt0n64igFm7438lSfMFAguDH1n4x3R7y8GAdtaEMrB3apdPfvy7qG5D4+sOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=01RRf6O21bMB/1Hj1kbbCmhKz3FtTJi8xp+lm2poyhs=;
 b=Mb3po1fDipAZQIdrdPL9s43dtEMHX9DVhNB57G4ljBKyAZBQzIdFuf9TgN5vkOkrXkEWYcUTOjpH+kLgf0WWKtnUHGfqYd40R0PWGZdljjNMQUx8GJSes3ughjgxStLUdAAjqT6PiJ//1Kad+W27Faxk57e+vodnjgZSKTLU30k=
Received: from DM6PR06CA0095.namprd06.prod.outlook.com (2603:10b6:5:336::28)
 by SJ0PR12MB5611.namprd12.prod.outlook.com (2603:10b6:a03:426::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.21; Tue, 22 Feb
 2022 07:07:23 +0000
Received: from DM6NAM11FT035.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:336:cafe::3c) by DM6PR06CA0095.outlook.office365.com
 (2603:10b6:5:336::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.21 via Frontend
 Transport; Tue, 22 Feb 2022 07:07:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT035.mail.protection.outlook.com (10.13.172.100) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4995.15 via Frontend Transport; Tue, 22 Feb 2022 07:07:23 +0000
Received: from thomas-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Tue, 22 Feb
 2022 01:07:20 -0600
From: yipechai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Fixed warning reported by kernel test robot
Date: Tue, 22 Feb 2022 15:06:52 +0800
Message-ID: <20220222070652.3373218-1-YiPeng.Chai@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8e045a37-96b6-4784-60a8-08d9f5d1f9b8
X-MS-TrafficTypeDiagnostic: SJ0PR12MB5611:EE_
X-Microsoft-Antispam-PRVS: <SJ0PR12MB5611561395108378038DB31DFC3B9@SJ0PR12MB5611.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: c9d2BcluOobIu08UFJClcqk7+tZkHyeRaXN4g+Z0v7j6JFLAsMvt58cI1MwdqXN9oZyByyJ0E7XmLnMTilrHMXR0ttJsdbBjUVV0ZUAAY0xHNJ2pClPcCEhj0HxHm+0i9YWDQp19lKXk1TsgO3nwXkCU5ULCI76J2IhMI5XEJ9iPzg7WISzkDVf10D9hZXvHxDZ3flEfjYvhkMYuRe5lvc+/mFOewDqEtOseTGT4l7Ot/I/eXUUeWCVK0BxTvqV4mISZF9Cmgl83p0DjqME/lkpp6b7jym8fGDhOZpFKf3MhqtBitl6QjJBJutp0KsshLrGW6gKD9/2UFxLY/yUZmE07MzF61gzy2Kk2GNjqSgGiDGzTT8mVo6r5kxngljBPIJj0G3N876fwBxvrU3T0qrrdWL9o5eNz5qaCXgsu+VrnxyeAGQwgRl11gkWdc6qJs0nonTllJTTmEhFpEAkTwCrJ+jWur3GjnklJSMQoblZBoJvAFui2jH4B41XuAcjGxGoEct2WnSINEsnHXuuSk9uZE1JPN7tWUgeSL8Tx+ZDHpVBCNZcggAggPw6KeUsR//Z34XSrMMcKfHTtG5iVhGRxoy1IOn5xJket1FnSPUdTd3sxJ7wz8WXqRUuEYt00ipT0B5H/cc7nXxUfgx0PVoBfqdR9pLuE4A8LBMTpHsu/nrXn3tcZYlPQr7VI1wXQqPlZjOQ2pfVFIDRptADdb4yZABJh6L3ETR3HbhzWh1Q=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(81166007)(5660300002)(16526019)(356005)(186003)(26005)(8936002)(7696005)(6666004)(2616005)(2906002)(1076003)(82310400004)(86362001)(36860700001)(70206006)(70586007)(6916009)(36756003)(83380400001)(508600001)(47076005)(316002)(40460700003)(8676002)(54906003)(336012)(426003)(4326008)(43062005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2022 07:07:23.5122 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e045a37-96b6-4784-60a8-08d9f5d1f9b8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT035.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5611
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

Fixed warning reported by kernel test robot:
1.warning: no previous prototype for function 'amdgpu_ras_block_late_init_default'.
2.warning: variable 'ras_obj' is used uninitialized whenever '||' condition is true.

Signed-off-by: yipechai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index e5874df3c9ca..a73567ea03d5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -2400,7 +2400,7 @@ bool amdgpu_ras_is_poison_mode_supported(struct amdgpu_device *adev)
 int amdgpu_ras_block_late_init(struct amdgpu_device *adev,
 			 struct ras_common_if *ras_block)
 {
-	struct amdgpu_ras_block_object *ras_obj;
+	struct amdgpu_ras_block_object *ras_obj = NULL;
 	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
 	unsigned long ue_count, ce_count;
 	int r;
@@ -2456,7 +2456,7 @@ int amdgpu_ras_block_late_init(struct amdgpu_device *adev,
 	return r;
 }
 
-int amdgpu_ras_block_late_init_default(struct amdgpu_device *adev,
+static int amdgpu_ras_block_late_init_default(struct amdgpu_device *adev,
 			 struct ras_common_if *ras_block)
 {
 	return amdgpu_ras_block_late_init(adev, ras_block);
-- 
2.25.1

