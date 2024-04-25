Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 050F1C4345F
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Apr 2024 07:11:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8879510FB81;
	Thu, 25 Apr 2024 07:11:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="avAhHedo";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2063.outbound.protection.outlook.com [40.107.223.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2EE7810FB81
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Apr 2024 07:11:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ftk+MMmZU6vjkQiIjKVDqTNWh3GznobeoelWNnd8mMxlDZhruHh2StA3mTqSRM7z2W9wtpHn6thQUrDDOY+2SJYMsN1tZ2k50h70e4BSwtiwgVqd5+gtHBB8UDnQDP5gOUmCdgiVs2lVlgegO9mg6CmWtFvOMmr6Wy2mcV0g83YEUGxb2Mv7f3JTE7E6oiB/d/zFe0/US7G3BHP4+ZnzgBFMmj3q3ugu9pCnKhVY/XzDgyYkXiOsjzhHnefb3qHtWEmtCHmthtPEZXYIOsb9Yt5bGNfbjmGLFb/zJgfyOGW5Ne2nYmrfqZi0KT0Iv3ybnfGVHbqZoYGf7u96DL7img==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eORi/xcL3oLgy5c2VqyrNlFuVYXJGwjIgcYqd8pgRzc=;
 b=k2i6kLRTHB/JomMge9rMhpJUNkvTRqICLvYUjxuRt3pTbvfru3yH5TT0y3ZvI52yu1ThxmI3gg5jrUYeM5GRsgbNHnrhsn+Nv2Wz95HuP6reHBSSTljLW6ez0ehluHB/UPVv2y1Z/VLqn9Gc5t9YbN8A0NmEUUHOTY0PHzhYhntYJQRpeGiFLbWq/ySpAP1rriHABHv4D2LvDwFIAi+so5Qo3rREB1y1uukA8269KrexSYdf0NAAzRmQVyTm6YHtCmvd5+QVAIjfvvHc0WMNvSKfk5dp4v32WH8N5gHPd/hd8rdTywugY3Q9v15X3rbIll2foTz8a/cNp7000v6l2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eORi/xcL3oLgy5c2VqyrNlFuVYXJGwjIgcYqd8pgRzc=;
 b=avAhHedoGxgALWFY0fueiFH+efyVcgMJBs3ZHV7L665kVtc+iLGcTd6fNBlJK3+OJiJaQxwhuunWz7UJCFabIuqiPpnaYDeDfgEcKL36M6R+W4sDpfWsMIj6gru/jLyJ0tZF8QYjq39Ew0FW+pqUmb4iYCg0yAC8uHF4RaBjY0g=
Received: from SN4PR0501CA0112.namprd05.prod.outlook.com
 (2603:10b6:803:42::29) by SJ0PR12MB6760.namprd12.prod.outlook.com
 (2603:10b6:a03:44c::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.23; Thu, 25 Apr
 2024 07:11:46 +0000
Received: from SN1PEPF00036F42.namprd05.prod.outlook.com
 (2603:10b6:803:42:cafe::2b) by SN4PR0501CA0112.outlook.office365.com
 (2603:10b6:803:42::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.11 via Frontend
 Transport; Thu, 25 Apr 2024 07:11:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF00036F42.mail.protection.outlook.com (10.167.248.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.19 via Frontend Transport; Thu, 25 Apr 2024 07:11:45 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 25 Apr
 2024 02:11:44 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Thu, 25 Apr 2024 02:11:38 -0500
From: Jesse Zhang <jesse.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <Tim.Huang@amd.com>, Jesse Zhang <jesse.zhang@amd.com>, Jesse Zhang
 <Jesse.Zhang@amd.com>
Subject: [PATCH V2] drm/amdgpu: fix the warning about the expression (int)size
 - len
Date: Thu, 25 Apr 2024 15:11:37 +0800
Message-ID: <20240425071137.906773-1-jesse.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: jesse.zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F42:EE_|SJ0PR12MB6760:EE_
X-MS-Office365-Filtering-Correlation-Id: a64c8cb7-33bd-47b7-aea6-08dc64f6f76a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|1800799015|36860700004|376005|82310400014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?7swla/8mGgVKufI9GDpsezGwmRe3sEDQYPeMnDsJ9mti3edG++wSN59qXA0r?=
 =?us-ascii?Q?5siu3W4QFbCtJv58yJwqRF+mTdQyPBMkVRECtrfnIuFM8DbwksyLTha+NIVg?=
 =?us-ascii?Q?kshZ4pGSoyxd1YmIc4930SZlXLzbGeIOb+P9xdu3tKyuv/QPmtacvtOpnYNh?=
 =?us-ascii?Q?s8lkUl2yZbZGbJKC+fQwNn5+8s9nt2DU8M6pkYbAolcWqA36qmvZfu08qa/b?=
 =?us-ascii?Q?4vLj9w/Rsthkk8M7YZZY+muvcO9ulUFDPyGSbTlsFN7MQkwfMpIWik6GHK9c?=
 =?us-ascii?Q?9JcdJKvixXAqG7mKw/O/tDQ7oBpr5QzpFY3EjzyFivqyJDIfQFkA63zueeTm?=
 =?us-ascii?Q?9e3zgbz0E5WLT7lvq3niXsd3yIh2JdjeuiJAoVv5yy4dO2WRKxLsAsQeRPvQ?=
 =?us-ascii?Q?7o2SKQUTZOltFSZO0IFngtSdOwBlCXoQCw0mSWyP1v3r3NyepsvkzU6/Rx76?=
 =?us-ascii?Q?IgGUHrb5hmWKo/DB26ZW/Zw0g7O5kX8ZsjGoBzPJEbLR/1dtUlu38pP2P3kq?=
 =?us-ascii?Q?A5hVowdi9zXoBbs0ZN7kHKZKfzzr9aYquNxBPE5TB97gnY6xU7Avr0H2PFfE?=
 =?us-ascii?Q?PfOqDHuEmpxxAFHfASQaGTbLv8WXWSjQvoiAE0+YZUW3JxR9h4QmA3TRLEYD?=
 =?us-ascii?Q?VSrBSxv4lxpTeyoaxFN5G4OrEsaCyTVXrNPvqF7X7BfHqqFE4V9lSK8/Db4K?=
 =?us-ascii?Q?3G6uaCMt7LF4AL0VurvcjRyWa/gzGlw6ki/ECa8btxf4I+BH338929QVd4QU?=
 =?us-ascii?Q?VIp0Xh6b4OBWrDIA5fupYzabJgsRZzf2it8Xn4o38sElDsfZEFkswTG11JpV?=
 =?us-ascii?Q?B6qC9+BWxf2wB3oRf8BBU6IG1+c118tuaN6003/bmTlIibgg49KEeh0GxoOd?=
 =?us-ascii?Q?q52BqNP32fgOpO9G099IYFMSVaGKAykDxhsi3ypk8JPE/IwTV3foQh4TOyqd?=
 =?us-ascii?Q?1dAUZyFiKcz4kFIh57c6q4C+ovQoyhpc+PTux0DlvUSd71mSy897n7NoYfHb?=
 =?us-ascii?Q?39N49f5VU2OsPkWVYCQNOS2kVI0bkZ/7b3WcMHMAX/cQfp4l2WivfYI3gK60?=
 =?us-ascii?Q?09x4vEqLoy+ltXL1iMxGgQQh4JRA5/vk7Z+TZBOePeK876OlioovjwwCfBko?=
 =?us-ascii?Q?LAlTRMZXuOFj/+eXQnTTiskHbCsoiC4AGcjlxzYkosFr7jZsuKAMRnUhmkkL?=
 =?us-ascii?Q?0vcj4FfjRg2orLWuUEa9inIZXY+HYvLaA8Wm8p3rjxG8Nzy9iUMqiciTdQMm?=
 =?us-ascii?Q?ScpmBupYxzX/UpixBmEg2zoGF4nPRi2jh/bL0MSfmGlEmbUuAe3i2Bep1aMe?=
 =?us-ascii?Q?b5AqFnyMg3TA9mDcn+Wm/dk4ylPfROgRebuv/7eO3viowG6OHUTKjZVgXAcd?=
 =?us-ascii?Q?JpZ7oPaqRlr4BuBra9aYWjDRb1Yz?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(36860700004)(376005)(82310400014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2024 07:11:45.4839 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a64c8cb7-33bd-47b7-aea6-08dc64f6f76a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00036F42.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6760
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

Converting size from size_t to int may overflow.
v2: keep reverse xmas tree order (Christian)

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>

---
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
index f5d0fa207a88..eed60d4b3390 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
@@ -2065,12 +2065,13 @@ static ssize_t amdgpu_reset_dump_register_list_write(struct file *f,
 	struct amdgpu_device *adev = (struct amdgpu_device *)file_inode(f)->i_private;
 	char reg_offset[11];
 	uint32_t *new = NULL, *tmp = NULL;
+	unsigned int len = 0;
 	int ret, i = 0, len = 0;
 
 	do {
 		memset(reg_offset, 0, 11);
 		if (copy_from_user(reg_offset, buf + len,
-					min(10, ((int)size-len)))) {
+					min(10, (size-len)))) {
 			ret = -EFAULT;
 			goto error_free;
 		}
-- 
2.25.1

