Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4EC3C25B74
	for <amd-gfx@archiver.kernel.org>; Fri, 10 May 2024 02:54:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B957F10E1A3;
	Fri, 10 May 2024 02:53:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="TxGT6gZg";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2041.outbound.protection.outlook.com [40.107.220.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E5F5610E187
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 May 2024 02:53:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EoTtGIYajmdxhFqImECAFA9F41QMQXFJ1BQDrvzOzwOeBxiA4H/hgr+32wym089V0NR4cSDacbpDT1uJk0ePvrE8ycoNPzX3+GqWLhIyAxEiAR10Ii0GbT114EWYnPXHg/6KxmMPtPTKCTlVvNcisvqDDZCrKHttSFxaqDgUqLeSXAgublE6Ag0q9+O0y3zK3Qe6dbZdGUZjVYW4AhT2KSw5Glz5Yt5xSJZ/oJQtUem9ylBwUtPzknFmYgYW0bVFx0Ci5kUYNkE5vhWzOsJW6Bp0a6/U4ei83jPkkDKQVDjAu7uwSm13ARu6p7lKZCsiNst3GKQ2UhQDPfAd5a8J/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2BQpGxh7SsDamutSvEXg2Vi5fMeUwH65QGo4Ahpnb9A=;
 b=gvJLorcMwp3FrlZYUc3tg9vu9w0QaX+FhmOeVFV6scs62u4T6KiASrPgw7eIdU3ODF9Do9CMA3M8ghTtfuAjaTUQRv4IyFTdA+w3yxUmTC9flOAYRnD7EyzBNbG71jk+j22jWj6/LBQJRsC94WE7Ui6a9zaDfVmFuzApe7SREcmR5Eu+EhhHeM3iVihtwq/oASOqPzWDUMr1XAR0mc+hFyoMPw72Tbgbk3a/BddYe6h9rDsTNV1zOjyad0g57+abfJ3J8xlg8YZYx6vARHg8XcxayPYqLeaY7tOJGm3Tm9MJXHx47LbKHFA9gQ5pY/r4e5tzrLc2hloX4e7ev7yTsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2BQpGxh7SsDamutSvEXg2Vi5fMeUwH65QGo4Ahpnb9A=;
 b=TxGT6gZgCaEDbaa+bKFOCKEEVL0vBauAvanbNSiyzrFMZ6N0NERJqjVrIcDalBl16dX+rPBsEbQqocwI9gkF861woYSzk0CrCTVeXi4NgSTHE+FNKZDlWC1rFc4pL2m4wD7bloqDJZh0WROxidQ3cr4n4xxuC8EU8H6wg7Laz0U=
Received: from CH0PR03CA0432.namprd03.prod.outlook.com (2603:10b6:610:10e::20)
 by MW4PR12MB7240.namprd12.prod.outlook.com (2603:10b6:303:226::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.45; Fri, 10 May
 2024 02:53:54 +0000
Received: from DS3PEPF0000C381.namprd04.prod.outlook.com
 (2603:10b6:610:10e:cafe::af) by CH0PR03CA0432.outlook.office365.com
 (2603:10b6:610:10e::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.36 via Frontend
 Transport; Fri, 10 May 2024 02:53:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS3PEPF0000C381.mail.protection.outlook.com (10.167.23.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Fri, 10 May 2024 02:53:53 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 9 May
 2024 21:53:43 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 9 May
 2024 21:53:33 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Thu, 9 May 2024 21:53:27 -0500
From: Jesse Zhang <jesse.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <Tim.Huang@amd.com>, Jesse Zhang <jesse.zhang@amd.com>, Jesse Zhang
 <Jesse.Zhang@amd.com>
Subject: [PATCH 14/22] drm/amdgu: remove unused code
Date: Fri, 10 May 2024 10:50:30 +0800
Message-ID: <20240510025038.3488381-14-jesse.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240510025038.3488381-1-jesse.zhang@amd.com>
References: <20240510025038.3488381-1-jesse.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C381:EE_|MW4PR12MB7240:EE_
X-MS-Office365-Filtering-Correlation-Id: 54b1d36f-1825-4343-31a9-08dc709c6d98
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|36860700004|1800799015|376005|82310400017; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?K6EzyvXGCWw8/bYCRcsrLo/2l6N7JKajBJY9UEQz0dHDoz1RxiHrUY8ADAPr?=
 =?us-ascii?Q?WG39BjRf6AOCEAf6P80qV5P/luh0SUx8ssN7XOwWosyYIRJL3u31s8LVaECW?=
 =?us-ascii?Q?4f0O76F+ldEkNcWiqqg21KvG0ylQf+BLI/Q59C3Py8J54SI6LOEnn6n1qNxg?=
 =?us-ascii?Q?xLxdGcoT5AvbM2h7yr5ZHzFIw0eqxjFAVdxheF+OW9AUGR6B/epzaSg5U1Fr?=
 =?us-ascii?Q?UsW5Z+04FxtdYleCZiJl8Lg87936X4HcKGPz4xQMIcs97UJHhzYJyq36n6ZT?=
 =?us-ascii?Q?H0z6mLTee7QFLGBvnPRjp77J+F6Mdz2ECZt0sJGFRWY+Pv7PjpSKGa4Lp2D6?=
 =?us-ascii?Q?rsb4cLNgsuukO6/KGfYytj9oOdxJXwyBf8HB0ozWofy7AcBXMPBDECQFM6Ys?=
 =?us-ascii?Q?wPaqIzm5UPyY3JV//H0YAimZkW3nWLF7iOT84qpYxZeyxc08YGq9o95wc9vN?=
 =?us-ascii?Q?yIZE4+hY1JAJ6nKY7ANlfIecTDhI3LMgpEjBpIJLcWADLD9OcZrK+QaJf/Ho?=
 =?us-ascii?Q?3N3sqewVEV+RkYEaPYrhuhxoAOTdCxEus01TZwjl39mvaTdZqWgrvL8+MAzH?=
 =?us-ascii?Q?q+XsTdOJTxZaBLXbYPQANy9fpb1KavUsuGFphL/3yYXjFypC/b7/t1PoS+HT?=
 =?us-ascii?Q?knlYarGvd+KJb7Kdr0hkeMrXphiSSw4asntVVcjkrHUAVO7lGLeyxaKVFNPe?=
 =?us-ascii?Q?ejQe2sNKjpQi7q0byaEP9m8EAdOXbUX8h1nT7tbzWzKpECxpWf8ql9m7lpxo?=
 =?us-ascii?Q?+TQoihlZ2mILyaj8nwYLNnL1LI4jmf3Ye6Qbjomu1f+1NdDjXj+k3WaB2Tk+?=
 =?us-ascii?Q?on2W1pvfgVYo15oAFSPvrnNuDZhaKnGbvkb8i2iV5sffr17x4HRhZwIMLgbC?=
 =?us-ascii?Q?FlF5BsbvKcNHRgFGSXVzixmedemb3KhU3VZnv+hFJKeO/Ze55W0CUSPVA+pG?=
 =?us-ascii?Q?oZ0X6uu/Ufzcyj54baOjibOJ12rRJ/t0a/tbkbgQuAEGKTzQgW1Z5Eidipwr?=
 =?us-ascii?Q?semypQTkcgRA+p/zpqBFIBFbqvYjpaRPPppgVWhdm3yXs+bZkTPrVOSUp6ME?=
 =?us-ascii?Q?kR6+fYy6hk2lGfJeOsD1NDa7k52CQESzr7/CpU+OoVa5ALgIvohqw63bVFRQ?=
 =?us-ascii?Q?Vw34MWOo7vxYsYvef5PZDnb7aRg7LFcSCc5lJiS/ockXPvtuf4oZsHq9ORg2?=
 =?us-ascii?Q?4jfzolpjHZkgcGVmgR5BLBGuS5sPz984VpkSP5DMiMFA0h3wheGBQAP4fYmg?=
 =?us-ascii?Q?BLPCQFPnx8O9tiXd+3Im8+iuhhv7h6pnmHxcQPJXSAhbtH9r0aHuZp6Pe1Gm?=
 =?us-ascii?Q?CyYx45tO6n/a1zYILV2QYAp9CCLmHtEhXm6TQHJx5YGNu98pjlVYR3gxCxi8?=
 =?us-ascii?Q?Daxm1AThcC2PMRQbzEEUNNncNhDm?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(1800799015)(376005)(82310400017); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2024 02:53:53.4886 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 54b1d36f-1825-4343-31a9-08dc709c6d98
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF0000C381.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7240
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

The same code is executed when the condition err is true or false,
because the code in the if-then branch and after the if statement is identical

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
index 541dbd70d8c7..16d3deac375d 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
@@ -963,8 +963,6 @@ static int gfx_v7_0_init_microcode(struct amdgpu_device *adev)
 
 	snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_rlc.bin", chip_name);
 	err = amdgpu_ucode_request(adev, &adev->gfx.rlc_fw, fw_name);
-	if (err)
-		goto out;
 out:
 	if (err) {
 		pr_err("gfx7: Failed to load firmware \"%s\"\n", fw_name);
-- 
2.25.1

