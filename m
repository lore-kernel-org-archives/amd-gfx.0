Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 427AAC433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Feb 2022 01:43:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DC81F10E5E3;
	Wed, 16 Feb 2022 01:43:21 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2060.outbound.protection.outlook.com [40.107.236.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E38CA10E5E3
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Feb 2022 01:43:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bLP0r8A1sI71HXgnIQfBmUF12Jflw6sjyKRFM9PGJ22+k4AcDV3zDxz4PIf/Rp1qZeGoI2s94Rd2SFCokm2PGFJkpZsTc4LVLBK+gwH25pUGBCxykWNpG2nyfp4GZ5YpOq+682Xs6pxQN1TDow71Gh7v7EtC4XgGrIdvT7t9zGzql88+YMRxc3SV7psJRQPugJNihibrwJvgAGpL24fh8PkI5Tj4ZGC6MlHSJ8ZazX/UklRP6496+PUTiWi//5VsvLAIzFi/4dBiQTIpIwivXKvTE26McRATfNOC8yGB89vGD1mMtAyRuqzkwHIG7Zq+Rt4dAwfYzVdRENr1DJAPcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t3SI3cDD9DSrmAy0xpvOza/PPJJ/10wu9Dy79C9icOI=;
 b=GfRGV3jvQlNeo/jCCcrE0UWssmAEBpuIQnFQtdg8QJ8vutuyKqDYvOcfY5XbvaF0/krS1lX7oVhC19VjXlk8AhtN356cfKDn/AY4OzHXDvAFKcyVEQJw3O08knbsT8D+mvli5z5VCxS9BrF3iqFIKUI42muW0qxaPZwNZgyGPqRMzUyHqDUD8u55JN0yMrIKi38VJb0COGMEUyG3NuWNa/IRCgLQBOI8BSqk0Fnoc9bDwRBLm4LM0QC/TWfPqwHh3DD8JpnTKvtLAn9UyWORd5QW+3BYLYy1yM3Qva3M8pZOkPCXAOjJVfRcOa/i1octEGTbOyFSzgc2Ky8oosibgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t3SI3cDD9DSrmAy0xpvOza/PPJJ/10wu9Dy79C9icOI=;
 b=Sw29vt7RxirNeDzE+IbfCp5lFrAkewFb+nkcmfk66knvP5MrlaOU2zW8Dkpz5ZoKk9T8GcDSFWS4EzvU8ig10/62oTD+u7Ip4WBtDbqmI6hMM5YLkkAVKFnNbiVIiDWUrAP7u3IrCcQyPdwDRMbyyQDJV4uK9GKkxhnw+4qrguw=
Received: from BN8PR04CA0004.namprd04.prod.outlook.com (2603:10b6:408:70::17)
 by DS7PR12MB5717.namprd12.prod.outlook.com (2603:10b6:8:70::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.15; Wed, 16 Feb
 2022 01:43:18 +0000
Received: from BN8NAM11FT040.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:70:cafe::26) by BN8PR04CA0004.outlook.office365.com
 (2603:10b6:408:70::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.15 via Frontend
 Transport; Wed, 16 Feb 2022 01:43:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT040.mail.protection.outlook.com (10.13.177.166) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4975.11 via Frontend Transport; Wed, 16 Feb 2022 01:43:18 +0000
Received: from harish-base-compute.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.18; Tue, 15 Feb 2022 19:43:14 -0600
From: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Print node id in peer map failure message
Date: Tue, 15 Feb 2022 20:42:52 -0500
Message-ID: <20220216014252.182719-1-Harish.Kasiviswanathan@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2ae8df62-6ade-47de-cbd6-08d9f0edb512
X-MS-TrafficTypeDiagnostic: DS7PR12MB5717:EE_
X-Microsoft-Antispam-PRVS: <DS7PR12MB57170BDEF7ADDEA0A625D3EC8C359@DS7PR12MB5717.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:352;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: t4ZIW4P8SMdrN/loX4Sx9kbPzQebXAWYmq4KSU1VAHwN09F4IHoYXY8lTN0gfpbqfXv1RJ+AibU/hECWQEL8o6mv0vagBzoY/yfMR4ZeUvcTDuB1dTIzthC4SBpZ9JYmjqpoYReFCHb92yO+FqdmHW6Nzc/yATDKR8b6g17zHb0h1QzTXZ9hxANq8hkbf5o765kNh68/rONG74NAyKRv/xINLZHNf3bN/oTKKTTRU3DxkFczU4XGu1kO88qmY2EZjGmFWZtXxs2qbD6tF1XPnQMrdYl1tXrcRjf4l/wZiOfGHqQ82Fm2X7mdAj64pbE6yQ3Yb8a/6GMTNP4X0Le74cpYqAkUKAvxH6R/8umlClccjgNLnwcLOgU9hBXXoUPLax6Jjhwg9ongjgXeCoY1GRVj5gMHeKqEExuQyPP0+JaY2w83CmJ4HUGYxz9ADbuBp9pIkDxq+As3snohY9ka3gQaRqKZLH4jKQvNUKa7dhfACMRfrfhqsfzkthPAyyRXGqaH8G6KYYW/mG7QJY4SRJriaCkXsGD5/IwHvDYx+Yc2IG9+K3RimlQcAGlZOjATEN658q25AwzJ2YZ80l6tb1CRZOADah8WvOluwCfveTnTODC2424++3mZMgE/N1BXbhLIuiwvJJz9Q2QhOvm8Hwc0VkA0SJdQY8wp3pE+I+PKpjnT1ty9tfD5Idk3jlwWnC7r7/iY4wX0So9L0VR3CQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(86362001)(8676002)(2906002)(82310400004)(4326008)(36860700001)(40460700003)(16526019)(70586007)(70206006)(186003)(47076005)(2616005)(316002)(81166007)(5660300002)(7696005)(83380400001)(6916009)(4744005)(26005)(356005)(8936002)(36756003)(1076003)(336012)(6666004)(508600001)(426003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2022 01:43:18.4990 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ae8df62-6ade-47de-cbd6-08d9f0edb512
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT040.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5717
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
Cc: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Print alloc node, peer node and memory domain when peer map fails. This
is more useful

Signed-off-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index 965af2a08bc0..4d62784c7cc3 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -1215,8 +1215,9 @@ static int kfd_ioctl_map_memory_to_gpu(struct file *filep,
 			peer_pdd->dev->adev, (struct kgd_mem *)mem,
 			peer_pdd->drm_priv, &table_freed);
 		if (err) {
-			pr_err("Failed to map to gpu %d/%d\n",
-			       i, args->n_devices);
+			pr_err("Failed to map peer:%d alloc:%d domain:%d\n",
+			       peer_pdd->dev->id, dev->id,
+			       ((struct kgd_mem *)mem)->domain);
 			goto map_memory_to_gpu_failed;
 		}
 		args->n_success = i+1;
-- 
2.25.1

