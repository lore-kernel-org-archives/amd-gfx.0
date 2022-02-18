Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B84B1C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Feb 2022 22:01:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5467410EC39;
	Fri, 18 Feb 2022 22:01:49 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 56E9810EC39
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Feb 2022 22:01:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jMBdqLxWu7QoY9Jv5MLxFrugLXrMk3uX4O8iMI5mwZPZK4Yjx5ATpDMOaXkn7T8RjrvtQUVtng4TRGdFfdAwBN2XFl03iUQDxMwvl872VZIFYjb1Th4x0C+1fOLBqrizfeQE5RxmEuoiusIrWZ+DgQJ1ZkLSEpRx8s38XOqRKVFM2UpEhbwhY0eAX4JNmG351KvL3ADktvqR7qaNAbu9q8QLTVia4LW2428jP5zRalr6XYR61m0UgA+aI7CDAg+GbJcKKnLT5bgf2DbN3tAzqvXZrGTACcshj222SNRoTpwSnibhac3BMjo5OhtCdUJaRO/DIAmwu/2VQgDiPe/iog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xdj0dZFM6wjqeZSywY9nXyD78f1En/CbpXMQOQGPHZk=;
 b=Rla4DITsrWwK7fQnKyjWkoX6k3vqGE0JvrbDuj09+RklUKzmUiP0hyREUQCbiuboseLk7Gma3ylF4V9NF67Ba9NChoLYcDWuhcLYCJgESYx5/WYkpgi5qiHtwHYm2xUWaDzk0O2tuA57MaeovQTK0aVcEY+Rs/s1h82hJYQmwQM/wwaS7DZYxGTFmJSzOm02Koo5rF8Gyude3T1AbJQFpKUhIUahNoIBdb50UOWhZ76e7jOpPELVBQpPY8dq+2eerPVT2VYU7dB9k8qorDFfA14wyxGgfuSFrw0fsRp8+sM8FDl8kQEa4qGJqcNFz49u7YkHabqXHE4cBHBcJrYQDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xdj0dZFM6wjqeZSywY9nXyD78f1En/CbpXMQOQGPHZk=;
 b=L4apEtrXXe2DK1w9Ut1OSFijWJj5Icv2vxBlKsXyIRLn73+Lgcgr3jr/9tFB3NRrXCZKtEe41sp+a4q4OS2nbqzXQN1rBxCgXFnU9SE93/6tVfKHgdR84j3rSI/Ifgptp2GLxuvIvvtK/n1UBTOi+TnobbMEPvFPlCDUw4C9u+Y=
Received: from BN9PR03CA0644.namprd03.prod.outlook.com (2603:10b6:408:13b::19)
 by MN0PR12MB5835.namprd12.prod.outlook.com (2603:10b6:208:37a::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.16; Fri, 18 Feb
 2022 22:01:44 +0000
Received: from BN8NAM11FT038.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13b:cafe::b5) by BN9PR03CA0644.outlook.office365.com
 (2603:10b6:408:13b::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.14 via Frontend
 Transport; Fri, 18 Feb 2022 22:01:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT038.mail.protection.outlook.com (10.13.176.246) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4995.15 via Frontend Transport; Fri, 18 Feb 2022 22:01:44 +0000
Received: from krussell.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Fri, 18 Feb
 2022 16:01:43 -0600
From: Kent Russell <kent.russell@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdkfd: Drop IH ring overflow message to dbg
Date: Fri, 18 Feb 2022 17:01:34 -0500
Message-ID: <20220218220134.806815-1-kent.russell@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9b6a8f46-8862-43cb-0cf4-08d9f32a4053
X-MS-TrafficTypeDiagnostic: MN0PR12MB5835:EE_
X-Microsoft-Antispam-PRVS: <MN0PR12MB5835B34A10F252E21421ACA885379@MN0PR12MB5835.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WG2x92wZiDFmyXvm4BVRCxbsD0xQH/ksBcowLF1yXpeLN0fn6RwWLrchAU2l1mPyj+sH6gU6LfxUzMXTS/0n5z8blPBuJjk5obXL8bQD0so6tnDNq0pRxIU7BdGWTpn2JdPgbKwxcanIrbCVjhh1ZDq0/NVdyrTD446x0Eakju7GCkfqIEPpWt/I8Z6TlfdDzRQWH+Z1itNrH2ZO4bUllO0JMQquIjoYRarkLZghhzXq7KOI3ZF8CmWl6KDCCD6fNdWNmUlezKqnd8yWFuBr6eWQ3dTDE5wvycmtedHN3oewqTLieJYcg4smjAdjgXdFzEE3gId9TfDDpHLLVtwGZGjzurx1VUCOKQSuUKax9rsjZ9U0+Ur3q4GS7KSzkFrfYblo2wTI6Fq4ThKo+d90fXzfqTIh5qb1pzbjuRBCcc3pFqdbhSH24yMj30zxdvi/1wZcBEmotvmVQ30dTtaRnPWe5fU4WhrIwY+7CxyT9EQJ2D8VGBkAD8dlASD9m0qXNrslQ5/95Pt17NNxV/OzD1RqqYqL0uQt8YUts3j5dbwcBQC+8sxtb5al0nL+8ipeYg1/gfq8WA+Q6INfAj2vZdW4oq/uzpsqrl6hhd0kib4rnXLqOqkCImoOjCMWU2a2Xn2P5R4GP0i3dsKUSlF0AO2NVpfhKcRbXCJdaPhoUaX8uh/L0LZkwB+tEZQGTLbpKRg40KrkHXdme4kXvpdS1g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(1076003)(8936002)(2616005)(508600001)(426003)(16526019)(26005)(186003)(15650500001)(356005)(81166007)(44832011)(5660300002)(82310400004)(336012)(47076005)(6916009)(316002)(36860700001)(83380400001)(36756003)(70586007)(40460700003)(8676002)(4326008)(70206006)(6666004)(7696005)(86362001)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2022 22:01:44.2371 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b6a8f46-8862-43cb-0cf4-08d9f32a4053
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT038.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5835
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

When this was first implemented, overflows weren't expected in regular
operations, and tests weren't in place to cause said overflow. Now there
are cases where overflows occur with real workloads, but we know that
the kernel can handle this robustly, so move the message to a debug
message.

Signed-off-by: Kent Russell <kent.russell@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_interrupt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_interrupt.c b/drivers/gpu/drm/amd/amdkfd/kfd_interrupt.c
index 9defdbbb4ff8..7041a6714baa 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_interrupt.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_interrupt.c
@@ -117,7 +117,7 @@ bool enqueue_ih_ring_entry(struct kfd_dev *kfd,	const void *ih_ring_entry)
 	count = kfifo_in(&kfd->ih_fifo, ih_ring_entry,
 				kfd->device_info.ih_ring_entry_size);
 	if (count != kfd->device_info.ih_ring_entry_size) {
-		dev_err_ratelimited(kfd_chardev(),
+		dev_dbg_ratelimited(kfd_chardev(),
 			"Interrupt ring overflow, dropping interrupt %d\n",
 			count);
 		return false;
-- 
2.25.1

