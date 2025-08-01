Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21A0BC87FD2
	for <amd-gfx@archiver.kernel.org>; Fri,  1 Aug 2025 08:56:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3002910E3D5;
	Fri,  1 Aug 2025 08:56:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="g4j19RNr";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2054.outbound.protection.outlook.com [40.107.220.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E401910E3D5
 for <amd-gfx@lists.freedesktop.org>; Fri,  1 Aug 2025 08:56:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=koQ+/yhfAqMBgEMMCX29IZdsGl6zKlUxeGNMgKtrUkExlLNa4n5nGmJUBCyNGf+tzYSSAdYQd9YOXIEn3wztMyS/gQxQUh+PRc3iFpbF9aN/DEIVA/oatbsGfKD8GEFiWtvjHjWHRdIG94DKeZFYBar3keQymThyfJZwm7gdqzjn1fV2lEZvAoa0yCYaviLiaEMKCc01SAxrhQG51JsJ9572bK+ced7Dtep5vCJirp5hIcUb8JMx2sL1AamsZ/9rkhdZ88i0wHaflvYdGAhsMHVfIi++dmCqQyabnNT5J6yx9DUcO8Hrd1BiQU8NNqosdnsoQHnJdo+qQRgO7s7k+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AiLxKjiF/rIO7/YCnws2MCwXSvQJdNmg7WUIoWBX3L8=;
 b=X7KLUJWE0UqIB7pe1nw1QA/2oqbKDRh1e2ehiPYKzBGsf3dg5Yq6wvfHDML43b+gK6pPCBQHXOTZYW9BEdwt69LNalb4Dp54OsvseEkuWSQW2zR8YC8DOHgyqBs0eX/VzshL/kwu63Gb64tucPlm0+r4I8hn9yB5bNpnANkvXJ/hnAACBAlHmWj/P3SGA0mP3xaIvUF6TkwQGOjcyXljTKsNPMUb4UfqG6kmPFojT9yRWb8foW7e0n8fE2nC2sVnttD7AfJJMrTrE+yMiDqf/CvD2znRv4toczB1L9Zew6EzyK14bRpF5MDEj0JYPj4AjX1BrsRTQp848LyhIZLI2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AiLxKjiF/rIO7/YCnws2MCwXSvQJdNmg7WUIoWBX3L8=;
 b=g4j19RNrBjN4O4Ns2xJzrtpKLglHeI6I29RNbRblluULE7SN3+tJGr3GaSnz2yvWkdVQ5V2zYKnAPmpQuVTQVOtT+kytCbzsaa6LZSb42lSssYVmBHR2RVw/5NZ0RXiYIfXcNAFFKLSExwNpWwklLXssYm1DUkBH+DkU6FaxwkM=
Received: from SJ0PR13CA0064.namprd13.prod.outlook.com (2603:10b6:a03:2c4::9)
 by CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.12; Fri, 1 Aug
 2025 08:56:21 +0000
Received: from SJ1PEPF00002319.namprd03.prod.outlook.com
 (2603:10b6:a03:2c4:cafe::95) by SJ0PR13CA0064.outlook.office365.com
 (2603:10b6:a03:2c4::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8989.11 via Frontend Transport; Fri,
 1 Aug 2025 08:56:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00002319.mail.protection.outlook.com (10.167.242.229) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9009.8 via Frontend Transport; Fri, 1 Aug 2025 08:56:21 +0000
Received: from localhost.localdomain.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 1 Aug 2025 03:56:18 -0500
From: Zhu Lingshan <lingshan.zhu@amd.com>
To: <alexander.deucher@amd.com>, <felix.kuehling@amd.com>
CC: <ray.huang@amd.com>, <amd-gfx@lists.freedesktop.org>, Zhu Lingshan
 <lingshan.zhu@amd.com>
Subject: [PATCH V2 01/10] amdkfd: enlarge the hashtable of kfd_process
Date: Fri, 1 Aug 2025 16:55:47 +0800
Message-ID: <20250801085556.8504-2-lingshan.zhu@amd.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250801085556.8504-1-lingshan.zhu@amd.com>
References: <20250801085556.8504-1-lingshan.zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002319:EE_|CH3PR12MB8659:EE_
X-MS-Office365-Filtering-Correlation-Id: 6bef4ebe-d751-41dc-9054-08ddd0d9495f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?npEUMfnjwxMqmCv3oVaLkJ6coYenPd1436EV1G+5Q3xkcJOjFvUr+vTSYe+X?=
 =?us-ascii?Q?W2NY55oMrfAw8MgAnCFOgkdEELx8zUOPp9D7HdEuSJBm+2k7S4jTesADJAEs?=
 =?us-ascii?Q?bx9eF0A6uF+SBsMPIo8hdovAomzBynoL5W6dxaPRwmvClJjF3H3t9cUnhICK?=
 =?us-ascii?Q?VoYniM+yai1dzgVkUb5xfZDqWheQxNqezm0SbVm9+5Hu35jqACd0rOaZBwPv?=
 =?us-ascii?Q?c4YWWq0+ryBs8eJP8WRE3QHR8TcUGwYYBjw9KhGJrlmK86W59vUVUC/g3BMo?=
 =?us-ascii?Q?xuudMGB9QhZdWxg0UJQbUwH3wCmeaUe8U6S+HF+hprF24QCcAllWmPxai2jg?=
 =?us-ascii?Q?E9h2CPMkUfUK5Yej8JvbkDu7lab+f0jEostDWDqjTYjjIsxjs9NZ5RSO453X?=
 =?us-ascii?Q?LFV4nvfwQKdL5kfosn4niL6tWQ03n4OF7MP1wb/3thEMe5Dhfq9d5i/foXFA?=
 =?us-ascii?Q?XDBxePyrjEliRdxo1PrKi1xb/v2mrC9UxReS03FZwRL5P3dKPyk6bwDwZ0S5?=
 =?us-ascii?Q?gLOgPtJnBTKBo3/7yGADGMjK1crkn93lxQ+30wyc58IYXZs518YpUGcCHt1A?=
 =?us-ascii?Q?OvbwmP9kMuSnirqkv8Ofwir3AXgfU0jYXSCEwqqr5sm5La/duVZiPi7AV25/?=
 =?us-ascii?Q?j303V9z2Q5youIgkyUUi9R5ghzlOF/PZ4HmzJKfKErRHxwQ5Qas56gClY5t0?=
 =?us-ascii?Q?W3zMlLjtZw0Ofeey3GEz4cuZO/7h0tK+VIQajpZmNJkkPaXwZr/HAiKZN0tT?=
 =?us-ascii?Q?MRQvZ6Yu9BPxuSYPnTEvELHIbhtTljY89eSjFJnAxto/whmM0eRq6EOOnem9?=
 =?us-ascii?Q?zXh/IeQuUqpHbwraGW7M9cz7Oh3ri6TwmF2ZH4iAhfuAhaATWOHIjF/LqlB0?=
 =?us-ascii?Q?whWXSV0k/VnSSORVOxxtvYHFZj5kS89yKHwDmW+/b4mj7yqXm6A6dbu5m7TI?=
 =?us-ascii?Q?trIbbBHhsjwFBfNZcraFrSs8voulb0luUhcZPNSrtcyEg3arN4xq8jJp/Pq5?=
 =?us-ascii?Q?GT85HHaqcs2K84QjNWcz0vVxD+NwyfbVlUvVyo8AyaE/YQPKxwj7K/2irUFR?=
 =?us-ascii?Q?VlxfGaed/o+FapWZkHdavcuoOsllYMSKkhPQYQdsnAcQWv9aC6y+vbnMwOOJ?=
 =?us-ascii?Q?+ICouEb/m7K82ZR8ZTHCZKzGjrqzpWs9jDRW2cfgc302JWgdX0lYGtPF+4PH?=
 =?us-ascii?Q?JoOyJ13OjNp2pY2pE3LmiqwKq+EJjCRmYcCCOqZ5KbgJtedDLnnYU7sgiCe1?=
 =?us-ascii?Q?8E3iWXEWiNgOerDB0Ks/sVxEHxCW8Am+Ngqfmq4AOfcWM423hQtCWPUd+CEB?=
 =?us-ascii?Q?wstS2FihR7Mq/trW5jCnAhOhQr50jNDNitmgdVFQVLJa2W/q/UBPq1OhJ0YB?=
 =?us-ascii?Q?yjLzd8BLkj9ACETWtX7Fr7jO7v49tZVPVecWdy2KKiOXp5nLfpr7fS7xzavF?=
 =?us-ascii?Q?pI/dHXdZNZmw/M4oQRDMKX+fv3tXlKdlXaVSGDQCjEc44jKaAgdp5WBI20US?=
 =?us-ascii?Q?ImGys9dlEcN+rIWtRG6c33OLWXyggq2/Q4s6?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2025 08:56:21.2616 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bef4ebe-d751-41dc-9054-08ddd0d9495f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002319.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8659
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
index d221c58dccc3..38a20ba61e24 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -1008,7 +1008,7 @@ struct kfd_process {
 	bool gpu_page_fault;
 };
 
-#define KFD_PROCESS_TABLE_SIZE 5 /* bits: 32 entries */
+#define KFD_PROCESS_TABLE_SIZE 8 /* bits: 256 entries */
 extern DECLARE_HASHTABLE(kfd_processes_table, KFD_PROCESS_TABLE_SIZE);
 extern struct srcu_struct kfd_processes_srcu;
 
-- 
2.47.1

