Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34A22CAC5A5
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Sep 2025 07:26:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C928610E4EE;
	Tue, 23 Sep 2025 07:26:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vmiOC5gt";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010046.outbound.protection.outlook.com
 [52.101.193.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C1D1610E0E4
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Sep 2025 07:26:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=llNfMMQEKBxOyt6YIpk/m5z+j01znynHFYeUPpc2Y1WuHZw1Us16oda7yWm0xgll4WwViM0+IfAAndDl5DYGg+SZQnc/WwFUPitH7bUq5fHpJv5yYBL+RnIWrdisECcCgM+v0vylY0U6k7i8Mmf3HHFt5IWM2dvwDgmcsNPhoZO1igddnjy8ONybEuNMPhJKUc8LGOA3kezaeVjiowQGizprMf4S+5mb4Buo6OMSOKtzphWmdNr+/Gz/WLARwTG3K6m79b83N358uRLELEOKbP5MoUgBrIkct0TIHH8uQtAm7iUOB9uiMbFuQ5fj/zf8xwQRimzC8qJ+swrx1bnbcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VNLVExYqhgZS4Na0WEPONvnVdogP3Tw9I5D9jS7mevw=;
 b=SGaH98NhyQ604cajkOto2DdK5JLXA3tfjNfaJTqI2hLU1qkc7MMte7iIts/A1VKProTPtaZfKwarEqAIMLW9KPCQ7b4CGurdZwPvhs5Lsctfcr8wpI7LbFCAqM6I1M+dQbQMPR0QXkz6BAubAFM9t9qniyd9SJ52cJWDMhQCYdHKedU/A7m9yh6JIR+u1y6EiR2hIpFfL1f6QmLnw/8cLYFvDFBz7iit60C6TYWIIa5pOYQjWCt6UsAK2cf7jRzHafZN6KygAtCPHTWbNKTbO7aIfFPuIL6JZQbTuUZXgNmFpiJpRdbYnwRNJTBOPh6lbZA2jb56yZMU8H1preo3SQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VNLVExYqhgZS4Na0WEPONvnVdogP3Tw9I5D9jS7mevw=;
 b=vmiOC5gtSVB1ICLmZ8HsL9H/9LTnK0jFPmo+CouQSFGni9xKOUNg0VMuc9bAsTVB95LdELC06SKvNMkoP9iCWjKH3imzygXAlomLqHxEfjnNa4TWdRCTr+KbgG9MgjmzE83mOhaUuiktqS2nvfy6UGd9rhw1xunGynxlEG5k71g=
Received: from SJ0PR05CA0042.namprd05.prod.outlook.com (2603:10b6:a03:33f::17)
 by DS0PR12MB7533.namprd12.prod.outlook.com (2603:10b6:8:132::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.16; Tue, 23 Sep
 2025 07:26:37 +0000
Received: from SJ5PEPF000001EA.namprd05.prod.outlook.com
 (2603:10b6:a03:33f:cafe::40) by SJ0PR05CA0042.outlook.office365.com
 (2603:10b6:a03:33f::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.19 via Frontend Transport; Tue,
 23 Sep 2025 07:26:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001EA.mail.protection.outlook.com (10.167.242.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Tue, 23 Sep 2025 07:26:36 +0000
Received: from fedora.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 23 Sep
 2025 00:26:31 -0700
From: Zhu Lingshan <lingshan.zhu@amd.com>
To: <felix.kuehling@amd.com>, <alexander.deucher@amd.com>
CC: <ray.huang@amd.com>, <amd-gfx@lists.freedesktop.org>, Zhu Lingshan
 <lingshan.zhu@amd.com>
Subject: [PATCH V4 01/18] amdkfd: enlarge the hashtable of kfd_process
Date: Tue, 23 Sep 2025 15:25:51 +0800
Message-ID: <20250923072608.252345-2-lingshan.zhu@amd.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250923072608.252345-1-lingshan.zhu@amd.com>
References: <20250923072608.252345-1-lingshan.zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EA:EE_|DS0PR12MB7533:EE_
X-MS-Office365-Filtering-Correlation-Id: aaa67640-ae4a-4442-9549-08ddfa7287f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?M2hN/SXOSQJ/QQVfRGQUUeJBHrRPjrdxK9zUAiRx8GDUtA0C4gObgPZeHEOV?=
 =?us-ascii?Q?KtETtptGodhsT6Lef//g7fKtJdn5fpq1Ii9Q+rXLY6mieGB89BDhvhQOp2Qq?=
 =?us-ascii?Q?ZHQPNH647BXkFgyupoxLStcM6N/WoKEDnI+vjvqvkpHo40crc2ZfoTWuDLDJ?=
 =?us-ascii?Q?k11cAqTfS79Qj6XxTEuMVKhsxPRPR+O2vagaM6+FyV7Ap8rt8/SKMlWWVLlx?=
 =?us-ascii?Q?j8dsbJ/1CbX+bsQA7pMBsWVJROATua1Oz2Ca7UoeNIUmj91jn5nP4UH8BJOn?=
 =?us-ascii?Q?ojKi3wSJm30j2MZpNVDzxIm99O8ON2AW4U4ZgleKHA30slqqW4DNoxPcGH1e?=
 =?us-ascii?Q?o+fub0jl2mO9nb/dpw53ohmjo7X54uiW5Vr+IlS3aiwpaY2/Pv+6KlS2k2Aj?=
 =?us-ascii?Q?mfpPYglhKeH4epEseOQAOZSYbFvx6D5QiJfGpzG9IMjTcJfoXDoTZ1vlyjcN?=
 =?us-ascii?Q?vPjlMRtisGNSuBc5NDYhgcvxeZjDlgM4ip4KZJgCVdufyjXpQyffCPDEVKnY?=
 =?us-ascii?Q?h1+/ymqLWvWMneAFWUqRMpiVzWj0USv+7OwCA+Vckyp2W+OePTuTXG44EHF1?=
 =?us-ascii?Q?0lTu/Iqe8Lx5LU3c+VAGx/oTS4BLwzgKMIRDJQ+UmMGlyiE3ZMVczUio5joX?=
 =?us-ascii?Q?kYEyJSCZ3aq9AIjgMseWhDGG4Kc1G5MwgG3+N+p0NB5OXu6v4ZpacZu5tkwy?=
 =?us-ascii?Q?CHoc2FF+7DVKen5T1pC5eM8bvU+ucAHTyuoJxcO2arisMfpp6N37KJXs6qJn?=
 =?us-ascii?Q?3xd4JugMwvIuiwLtLL3jXxN6LLcT6y631KDVtZEu1eggDTUBSWYVr/QWZo0g?=
 =?us-ascii?Q?FwKawDRUDEmVGpvBf/aMFZclNkyXg0yPzXnRJtWFXIyp88ncV8tJ4Kuh6PJW?=
 =?us-ascii?Q?7TgPPRYh2JEeeHPT9m/U7GsJhx36ntSi8K3vvLsLDZCeP8qY1EQkf9QG4oE4?=
 =?us-ascii?Q?VcbNgGQjd5ugh8BsJdC/A/uPtwTaR4Dm59jM9GQtJZyjEYbwOccmF5Jf1Fuo?=
 =?us-ascii?Q?s7xAEgvOR3Z05W+ooNfylx8Nl7/eEy71AInrnKOfCdHOl2aE3/9TemAZzkq0?=
 =?us-ascii?Q?fAVfJrAVlUDRnUaiH1GWKC/8Flop8e0c0O77QaQYU6KFJqR4G6OgFrsAKj1V?=
 =?us-ascii?Q?M7mVqdONZ7pbVCAYQvSD77jFMLUKxH0hE6kD+rnCtqzTZjT3AubJUzo0F4x1?=
 =?us-ascii?Q?/o8U4cyouq7/V5xbawr1tkkpi9xyMtYQCG+vbJ4t/7HJD1b52cVRZF242tME?=
 =?us-ascii?Q?Y6PuLhTHzA3MHGlfHfQYTzGXckj/rLyn6Q5bPvVQoF26VxdRohBuz+/e/L0t?=
 =?us-ascii?Q?DjbL5devMEyt/RGR9RibLX8xQtO7RIj5Qu1wrb9EkN7+smsj5BgvV80Fennp?=
 =?us-ascii?Q?QOCQdej4Y97gAEBlnaesN16oWZg3raXzRKJLZIYlQ6kR9EOOU9W58v5hzbbU?=
 =?us-ascii?Q?bZ5pHe5760yiUXafaPaPRXg5GERcx4fsb9JT0IIXuqmoK+w1uBmBP+jmCjxL?=
 =?us-ascii?Q?f/fUzPJlsyUD/pBQUl6GGGsuClqThVmV8sU7?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2025 07:26:36.9434 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aaa67640-ae4a-4442-9549-08ddfa7287f6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001EA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7533
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

This commit enlarges the hashtable size of
kfd_process to 256, because of the multiple
contexts feature allowing each application
create multiple kfd_processes

Signed-off-by: Zhu Lingshan <lingshan.zhu@amd.com>
Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index 67694bcd9464..8a33e6ee6369 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -1011,7 +1011,7 @@ struct kfd_process {
 	bool gpu_page_fault;
 };
 
-#define KFD_PROCESS_TABLE_SIZE 5 /* bits: 32 entries */
+#define KFD_PROCESS_TABLE_SIZE 8 /* bits: 256 entries */
 extern DECLARE_HASHTABLE(kfd_processes_table, KFD_PROCESS_TABLE_SIZE);
 extern struct srcu_struct kfd_processes_srcu;
 
-- 
2.51.0

