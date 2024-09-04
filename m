Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F635CA0ED3
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Sep 2024 09:52:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 20D3310E726;
	Wed,  4 Sep 2024 09:52:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pxo6Wv9L";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2056.outbound.protection.outlook.com [40.107.94.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6E39A10E726
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Sep 2024 09:52:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Cs7BegQleznEfGhZfBJ7/hgZwlhVPZPlpBv/lASH3g6QDr6Srr9REJQSQweWzRUj/xf36m2qGXNt5LdLkPsfXHL9JMIy2p3x21SxfJmzV4Yz0W1o7+VP3g3RYatt+flzJ79u0xLFI5nNU8Y6gUUijXqhW+WIpTDbHVOYLsqdIQAZcWgIUziOZPyFZ84BjUpy8tyThM/VuauJb4dzNxmlo9PUffyA4xms6A+vC6czjxA9VsJM0RbZB5gYonXCRxN2/qBTRLxffk+sgt/Uh3ww1UyYRYleWI/kSs1E9dlvcYPsFjAH8A0PuCq3ZtWP0HEI3VVPJJTQD4nC4+S+c+pzFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/ec8erJylpY4k7XE+LdQSh3UaGVKp00F14jpzKKGCLY=;
 b=DaCDGANoP1TwaqeFbQgz/IrVzGc5eAHzaqvKnsd7siShJ0pZVamhjKJjN6d+yYoPaphNQZPlnEMPOfMqqzkyHASYHCSjLaz8iO6nfr5GvvH4GAun5JtVQorrG1sXj5xiOMOPDCFC37Oi2mTgytZSMVMYP0Ualm9PlB5Y36c65Lp2UmkwlUggU1y8StgEjIn1ZJqR6IWty5+isMDpdmz7cHWZYtJYq3KiVryr798RjTh2jEIKNUsG+ywxVUSPljz+Ag7MYWDv1jNfgKI5ITjsFGgbp2gCfVscZzqgxlSliqnQPT2YMYIpIA7IF0M9883tdhXfbklV1/M07uFRqkBh1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/ec8erJylpY4k7XE+LdQSh3UaGVKp00F14jpzKKGCLY=;
 b=pxo6Wv9LnnAiD18yyYpsF+eOi426PIAZOXKq0fTwdfFX9T7gln0P48cuRWRiV+uKxjo0j09p5hZPLP9Q/FWcprRxjw/1vLn1MHLGtQcMZT6lunLpxE2FQRkhGKdaHxkLGxA3bryWmPUcQc+hvw2qojantuvml9DvJ/iXoJcI1c0=
Received: from BN0PR04CA0059.namprd04.prod.outlook.com (2603:10b6:408:e8::34)
 by SJ0PR12MB8168.namprd12.prod.outlook.com (2603:10b6:a03:4e7::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.24; Wed, 4 Sep
 2024 09:52:30 +0000
Received: from BN2PEPF000055DC.namprd21.prod.outlook.com
 (2603:10b6:408:e8:cafe::85) by BN0PR04CA0059.outlook.office365.com
 (2603:10b6:408:e8::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27 via Frontend
 Transport; Wed, 4 Sep 2024 09:52:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN2PEPF000055DC.mail.protection.outlook.com (10.167.245.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7962.2 via Frontend Transport; Wed, 4 Sep 2024 09:52:29 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 4 Sep
 2024 04:52:28 -0500
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Wed, 4 Sep 2024 04:52:26 -0500
From: "Jesse.zhang@amd.com" <jesse.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <Tim.Huang@amd.com>, <jiadong.zhu@amd.com>, "Jesse.zhang@amd.com"
 <jesse.zhang@amd.com>
Subject: [PATCH] drm/amdgpu: fix queue reset issue by mmio
Date: Wed, 4 Sep 2024 17:52:26 +0800
Message-ID: <20240904095226.991344-1-jesse.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: jesse.zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DC:EE_|SJ0PR12MB8168:EE_
X-MS-Office365-Filtering-Correlation-Id: 79065cdf-ca1a-4d74-9dc1-08dcccc74a46
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?1kwx478nkR/5f+YWo4X7zauRWYEk/v33BEIj4XDOxquwUkPdm4IMSYrpajhu?=
 =?us-ascii?Q?NgAe5VS2hxfVIhYBsPQq4D1Ev7BQkJkqas8Uuz909X4+TFSfZ9qgmYjZCni+?=
 =?us-ascii?Q?rLWSrFfeLC7yPG7+QXrtpHWWB/rTT+w0jB55ekX6TocpZEFUK8cNQpRZ5dg0?=
 =?us-ascii?Q?Ky4kNUKL/xbGsCUdv+x2k2PY3/sQTClvq+qxTC6ApQ6ZQedF/KnOaWXtEXpx?=
 =?us-ascii?Q?vanR5RrcVXBQykrTh398rclIq115nSQNxvlG6qWPhOqEJySu2rk+gMzhMckH?=
 =?us-ascii?Q?aAjXHiFzd2gN92jwyepWSWko+pUBgKR7OGZcXGEJsQm3n31np2ekzd9b1cht?=
 =?us-ascii?Q?e2bGtzPQw5fSlLQ/GvlhZrecGGTQ+F9faRFNwRFnhsBTa7E92QVnj/w0s2sj?=
 =?us-ascii?Q?KuSNDM+Pep9q3Hz8DGoPIrcoxF8TDVGthQLMzlvNyRuopspi6911i8iC2iyR?=
 =?us-ascii?Q?lUUM0sqPNoBkx0onCtnatDdPNyM2V02+fGucCYPVm97x8/uRnbfeQULQdBPW?=
 =?us-ascii?Q?UptYR6q68/7KmMc3m/dzz9SH4ryYLg6WDMfXZIy2tVX/V+/k/afRBtI8Tb+E?=
 =?us-ascii?Q?7yxcO4909+aKjo8wmCDZHjnk3hVxe8InzlIgJZuKYNK6FVe8ygP6STtZuCyT?=
 =?us-ascii?Q?L/+A0iOsUwtpVolU9C6leOXr8xDP+uq/bNL8MqYpP7lS7l0PwNoNLmdjKFEP?=
 =?us-ascii?Q?wFdw2EU9QRsp75UyRjo+wNxkMpi9+Y6cHm56eFPgxaILa1QHmaNKnAujPvql?=
 =?us-ascii?Q?wZOjEU0I6NGGJGEqk9Dbg9iCxgm4wiCHMh3OBJmdazSowdt/vXRfZR0SGVOj?=
 =?us-ascii?Q?Xo4HP6XBQjvo1rTDDpvSCxcxouTfAim5aOFxJi+EHzpUD9bB8bWiEGVp5LeU?=
 =?us-ascii?Q?v/xzZXq73iKmgGcTIxyjhDqzqzgL/yCcItgBwclLp1HFlr8W3eYq0RktT9gW?=
 =?us-ascii?Q?od87cebiaSX2RCrxxRTj+TrHb2jT6CHnKJR8UieLD+zOxAFdx3NKIKi0y+IK?=
 =?us-ascii?Q?W9Hj79xDgzisZcj99N+TepHF93ESU9q4Q1r0VHG4itfmZPUaPPeuTa0aIm3+?=
 =?us-ascii?Q?xzbpmcJEHqmg+rtgRiZ98sG2JP+Fid9hka5t/aa3LV/zfIMEa9Ouc4+LrJGP?=
 =?us-ascii?Q?kyEUos1iGW277vgoAHu72UisKOC8bmCiGCSUCCirrQ6AmrcZhou5fv8a8tAc?=
 =?us-ascii?Q?Vbayqb7CZW05BKJaPmeStKIF/RXqzB9uED4t9SBvubDa7ZTniVMQVr/89wCC?=
 =?us-ascii?Q?x4PVah71KYV4lFss1llY9XDJRRltLUSCDhOKIdPa1u4GeAArnMXp58z+yvjh?=
 =?us-ascii?Q?f7f1mtstyKnlzXCrvuerR4sPhXNHyUr/614CCk04Dbz3GJvv5UJ8Oa3kiXFd?=
 =?us-ascii?Q?RawdjKtki4CzSHOvMFPgGIIq/glULV4BDVo0ZGy1aH+4N3bZ3A=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2024 09:52:29.5785 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 79065cdf-ca1a-4d74-9dc1-08dcccc74a46
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000055DC.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8168
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

Initialize the queue type before resetting the queue using mmio.

Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
index f7d5d4f08a53..10b61ff63802 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -832,6 +832,7 @@ int amdgpu_mes_reset_hw_queue_mmio(struct amdgpu_device *adev, int queue_type,
 	struct mes_reset_queue_input queue_input;
 	int r;
 
+	queue_input.queue_type = queue_type;
 	queue_input.use_mmio = true;
 	queue_input.me_id = me_id;
 	queue_input.pipe_id = pipe_id;
-- 
2.25.1

