Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E61DECAC592
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Sep 2025 22:41:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6712A10E817;
	Tue, 16 Sep 2025 22:41:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4yD72564";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013069.outbound.protection.outlook.com
 [40.93.201.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 16D9610E817
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Sep 2025 22:41:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Yfbg3e6StHv5e86T5OE9lvvOM7tmtYRE/68Sx1zRqy9efqgBrenOutrKXLx6vJ0qQUuLlDSdNanHu05utxj+RSukzK567ZBnIj/SYFgIpB6Vo0cSxApr9zeMLOOds85uMTW+lQBLrMlu7KUCnN7S+FmBeEHeXxBDabMeSm6BEGrl1B12+9/4cgfsusSQvbqNcJum8zWPd89a/V0o2+41mJ6ich2gQ/0oI/pv+tfZ9e3z+G8WmhSWyfBDglb2OgM1MSlBZ3eND0oJb8yCcuojloXt+GMl0wI8NwE1POdRGcr8hkZFCO0OO/96GFA1LF3kVM+zCBJcvgg2tdr5bYUfYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wnYD0KY5fw5nFLiqLQBfwM78kzkZMS9KtQ8vSIgnPkw=;
 b=GcNwQPrVffmjd6/QHmT61CfC3o0bLG6gYSOXhCZ0z0lbsi/8DQa7l2kZC2dI724f74Eqt1oGoevSfrF90HXKkuB+yY2nO0aNse70nF5lbBgcJTd+W5u5MbsV6sjuzQoIlydsAKbkrJ/2EAq835G9cp3hwkhf6lOwzMYe3bP9iZE59TuXfAZbCZa+KeYkfbagp3ganGmx+4olyZKgbEcqwDePnAYlV96cFpUnQv8HJ5sTvyXF2S+vnjnn0gNQddAovM1hKFMjQy6WozNyW+zdlMEwvoHncfg3k8n3l4huXge5TIveWcA/4gxh3EXVxBaZbKGRKD6EvwjVYxPQdmT2Rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wnYD0KY5fw5nFLiqLQBfwM78kzkZMS9KtQ8vSIgnPkw=;
 b=4yD72564tmsmXKziVN7ypzUd69+G9y3Np6pT0CIYKapnkWj+g61ATStWv6zAJ39fuTIlWfiznRJRWRVKHWUyHgWrAc4nxA6QXMTdTnvwrBr86weVScDZKjsPSQmBQPGZWuimp1Jcd/n2VRf+IGMztIBQt9Liwt8lkbYahJIyzkc=
Received: from DS7PR03CA0101.namprd03.prod.outlook.com (2603:10b6:5:3b7::16)
 by DM6PR12MB4121.namprd12.prod.outlook.com (2603:10b6:5:220::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.23; Tue, 16 Sep
 2025 22:41:47 +0000
Received: from DS1PEPF0001708F.namprd03.prod.outlook.com
 (2603:10b6:5:3b7:cafe::cc) by DS7PR03CA0101.outlook.office365.com
 (2603:10b6:5:3b7::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.21 via Frontend Transport; Tue,
 16 Sep 2025 22:41:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS1PEPF0001708F.mail.protection.outlook.com (10.167.17.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Tue, 16 Sep 2025 22:41:47 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 16 Sep
 2025 15:41:46 -0700
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.Kuehling@amd.com>, Philip Yang <Philip.Yang@amd.com>
Subject: [PATCH] drm/amdkfd: Fix mmap write lock not release
Date: Tue, 16 Sep 2025 18:41:24 -0400
Message-ID: <20250916224125.29338-1-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001708F:EE_|DM6PR12MB4121:EE_
X-MS-Office365-Filtering-Correlation-Id: cb2bf4db-0a10-4906-d4a2-08ddf5723816
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Gv2biMNwRFrxHL9N/ZfGGU0ii5YPpPZXl6MLv1h2aoJxbWZg3Ynk9J/7Bpoz?=
 =?us-ascii?Q?44eq6KuKT1t66GRBbs6LAil9jdJgJ7cbL1b4rT3OSAIWdDBAyXbqxOnccwdT?=
 =?us-ascii?Q?hCIePpQzWEOEXWJkBnwxntuCI8H+Zq6gtEdDgZltVnP09yuP5u3tYKfCy7v9?=
 =?us-ascii?Q?HeB6uQPnLhEtObKE4qrTTVnK1/jO2W1Fr/TKUcp4sYI3/Y+ldncKm9CbPykT?=
 =?us-ascii?Q?gFG5pzN/mHd5esrsAnF8v4ORuA4r/fDPyYVTfNi73IOpSqYBmqim7fhhk8QO?=
 =?us-ascii?Q?L3+Va/6ul5eBil16bozDPdhdqmXWHSekShvvXX9NlrFfqkZ5r8gVhp9caw3S?=
 =?us-ascii?Q?d/RceloC56ffxKw2EkpZ8AmgaUVyTnS8+9/TGJVz26bAQ8QT5YwgPzseCZOj?=
 =?us-ascii?Q?rJLDpyDVQnzb+esBCBia6nC+FdXI+lbm0Amqsimtoy6ExTY4qgx0nQVVpDvA?=
 =?us-ascii?Q?Ee1nrtzflsowSCzYvpP2za7Izha/10bBnppTB0OeBKiZEE42g0k3qxwwwgNX?=
 =?us-ascii?Q?RzQlEUIqqHnS+8yhgatXwoG8ez1+hOweXL7tQSjMTS0NT9G+bjyXPNRx5gdk?=
 =?us-ascii?Q?ANZqQzmNqhwF97LTHcHEvQRwvWymnEzl7mqj8YqLkjh6TEbxiM21ttdOtcrw?=
 =?us-ascii?Q?IWphTtV0osuIiGPdZqUJfybOP/8txcgGp2d9tUTspx9olBBlAXOzgYugEJ0V?=
 =?us-ascii?Q?NrOV0VGqEHHunHkHBKt4FNZ/pbPYtvN7DlX68X8qa9DAqJVTN56t5eTLisG1?=
 =?us-ascii?Q?Dk6C/NOHR3VEi52FTI6W/JnqQ5ky9nsirmvhH6Og+rttxCvegfv49eCQSJce?=
 =?us-ascii?Q?dU+d5kV1DGti663MAOHjgDrR8My3FsrqsYlsEuibD5t37KcJKmqDSkxF4xY5?=
 =?us-ascii?Q?X4KJsLb9IXyo23dq7zELUwhtxqOKz04eHPzUxD8SEYIrBC3rQECc5RTDlu07?=
 =?us-ascii?Q?qIkEIt+r5B04tknACey4nkk49JjdoPHF7WDH+dmWbZZrZ6CO+R6VxpfOxecA?=
 =?us-ascii?Q?AADBXQGew+4E02r0vOBPd+Zymznwd/ImU2C4VL9F0wmRL1ZkqOnuf5GuH/lK?=
 =?us-ascii?Q?wcr3KKFjENmoHGIPlfWMLRStLmk41+hcArb5Tme7EzH/7fxgD6YozGAJU1hK?=
 =?us-ascii?Q?P4MUQdHls1Rl+hHtegaMH+8q8atAtmRSi68nAgK6Bcg3tb0RTTVbt7TtZgr2?=
 =?us-ascii?Q?hi8jAqxobucdzXcB3Hh8yD5F0YYGG7d+ztX9HFc2wLlMFEOiijnk9pi7yYiY?=
 =?us-ascii?Q?5oLWStgf/s3ThwBJv1Pb87GmG4qP8PoVTlTkQSM+4O89ZMNttZ78c5zHR6w4?=
 =?us-ascii?Q?rU0s5T55cfGA20dl/rJlxYGrc01StFmfXrctvOJNqlHmpnXEmsue1B9yV98r?=
 =?us-ascii?Q?TgDJqaBA8nrS/D8fi75Hise/fkVKmQ/42T4oXmjVW1rLqV4mb1NBvqCADqHw?=
 =?us-ascii?Q?v+0t/tSmmlS1ZAzIkiRNWhPwiZKqWlkP4Q5rC943Mh7zmUG8wSGr/ijzg+WY?=
 =?us-ascii?Q?5vgIC46tzzSIHp8ypDliTbcNXMKTjN2ZxYAk?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2025 22:41:47.1772 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cb2bf4db-0a10-4906-d4a2-08ddf5723816
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0001708F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4121
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

If mmap write lock is taken while draining retry fault, mmap write lock
is not released because svm_range_restore_pages calls mmap_read_unlock
then returns. This causes deadlock and systen hang later because mmap
read or write lock cannot be taken.

Downgrade mmap write lock to read lock if draining retry fault fix this
bug.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 6604a37b304f..fb02ff9ae62a 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -3043,6 +3043,8 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
 	if (svms->checkpoint_ts[gpuidx] != 0) {
 		if (amdgpu_ih_ts_after_or_equal(ts,  svms->checkpoint_ts[gpuidx])) {
 			pr_debug("draining retry fault, drop fault 0x%llx\n", addr);
+			if (write_locked)
+				mmap_write_downgrade(mm);
 			r = -EAGAIN;
 			goto out_unlock_svms;
 		} else {
-- 
2.49.0

