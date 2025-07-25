Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13157C87FCE
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Jul 2025 16:08:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 90AC610E227;
	Fri, 25 Jul 2025 16:08:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="so1EuhVc";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2072.outbound.protection.outlook.com [40.107.244.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0B36710E227
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Jul 2025 16:08:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nJFRNmYu2R+zwVugI4tUBegMydO6qdp+L7pA/z3Ml1AwM5zQIFatVueCCdRek3CJSQFQrMqDCmP6XpAjIb6ix/W1JziSmdXDuQIiK0oVdqgK6Q6useasFzV/8lp3ZmmHzBOniADetFFOoDvqZhoJ+2PnJjBpsW5wXu4KtdAJErs/S0ugkhDC9N3r+slKvKWKUaSJq5NXWXmPAqbIfgkl6Zr410LK7HL8Qa8Yy7cwQ1ZjlK27URJZBR/frKlKzjhI3LumPx6LvOiA/xQszjK3K2BfLWjJBBNC3CjeVS49TID8HduhQZGKlwqxH9XpTVTDDfEJiySW5XdkZIOpOQgEXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uNwtEsxj6l/tgLpVAYjhf8yRSWDgsrpZCAh9++qajCE=;
 b=M0rVnw8rf5yFVwmnKkZCmNhT0a76fjnDzLZQ9brC2rya05bZ+j6T8mQmqPXBHUtY8YaXEVaMsH5QZsW+BpXDXAs3vBYavev8pNnt2P9monlerKh9Vo6+3iT8EzaiM3Yw41XlpWw8OTn1oqaCeY3SY5kwe6nE7DjontirQm+O1WUY9iJxnVRhmW+9Hx69KvQAqZON9VULuT3yzog4bDqKXgejIWoqcDpOEJDHhWqlBmcbw8DwC713SD+Bjn2HD5gIaRAadqyz/58wVWJylcE7FjoFjbvGWzuIc0HcEYHSH0xCAllALdDSOULs8AHYM3a/k83XPUXRO2emw/EGxllSMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uNwtEsxj6l/tgLpVAYjhf8yRSWDgsrpZCAh9++qajCE=;
 b=so1EuhVc73xaPs2EsKqAUyDYy+4nRWuxG6IElJ5nxosybG5b5pyCjhE52RnFUEdMZK2/xaAaHv54RoXTo1LZRuix8B735L2Px7VHvYBU0VFiDXiFC+tV3QFvqENQNrwdhDt0J+SuUr4UZ3xLfa5aqQ2kBJ115Iu+AiI8XVP7+sM=
Received: from CH5PR03CA0012.namprd03.prod.outlook.com (2603:10b6:610:1f1::9)
 by PH7PR12MB6955.namprd12.prod.outlook.com (2603:10b6:510:1b8::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Fri, 25 Jul
 2025 16:08:19 +0000
Received: from CH3PEPF00000014.namprd21.prod.outlook.com
 (2603:10b6:610:1f1:cafe::98) by CH5PR03CA0012.outlook.office365.com
 (2603:10b6:610:1f1::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8964.23 via Frontend Transport; Fri,
 25 Jul 2025 16:08:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH3PEPF00000014.mail.protection.outlook.com (10.167.244.119) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9009.0 via Frontend Transport; Fri, 25 Jul 2025 16:08:18 +0000
Received: from fdavid-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 25 Jul
 2025 11:08:15 -0500
From: David Francis <David.Francis@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <tvrtko.ursulin@igalia.com>, <Felix.Kuehling@amd.com>,
 <David.YatSin@amd.com>, <Chris.Freehill@amd.com>, <Christian.Koenig@amd.com>, 
 <dcostantino@meta.com>, <sruffell@meta.com>, <simona@ffwll.ch>,
 <mripard@kernel.org>, <tzimmermann@suse.de>, <Alexander.Deucher@amd.com>,
 David Francis <David.Francis@amd.com>, Felix Kuehling
 <felix.kuehling@amd.com>
Subject: [PATCH v9 3/3] drm/amdgpu: Allow kfd CRIU with no buffer objects
Date: Fri, 25 Jul 2025 12:07:57 -0400
Message-ID: <20250725160757.231780-4-David.Francis@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250725160757.231780-1-David.Francis@amd.com>
References: <20250725160757.231780-1-David.Francis@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000014:EE_|PH7PR12MB6955:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e680d2b-bc22-4af7-a671-08ddcb957868
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?PyO9e8ZPrYzjRdLPWc0wE+NCvOK2s6awg2q2N95kjYiEdgRih7mJxfqyPr7F?=
 =?us-ascii?Q?VhL1qVEh2l6Zs+qynHKxxFL6rZpnKQxMpK9eV0qLWqsaYP5FXDHJAKEIZfRu?=
 =?us-ascii?Q?2UJKMk0RJLSdeDYh+hwI1n4xBsRSeSbfo1voTPBzAwRmbu320n9tASwLQgtj?=
 =?us-ascii?Q?+97O0Ea1Q5wSc52WsxF6pH1FWyBHv4Uqh8sAkQWIjsvWBQYiz9Efn/EtzIX8?=
 =?us-ascii?Q?jrYC4wAL4l4ChaA9oqYWXahU2vD4juwrv8NDanRjilkGnC7WxP8HtsXwAslg?=
 =?us-ascii?Q?eXapBoWMeM1vxh/0lg/L2hgSoQbd0KBqd4Eb+ncInG2/ANKmxvtBqHkkvC8S?=
 =?us-ascii?Q?rdq2zZygWLUubyGAy4pgtP4JyLNDviexelAnSFpkIYg7EgVBIkkOw3iycnCY?=
 =?us-ascii?Q?Lr1ZudZ6uSaX0J580vJDhBTIoAIUFZH2SMwPhzUs7+hjSu+NL/OL88n561BK?=
 =?us-ascii?Q?4My/rhcKcudnNDU5SrUCSCBfORtfPzuPpZFYRgaZa2e9dxTSk6aq9lnyBzUg?=
 =?us-ascii?Q?Nm8NtdycFsgrNFBKwhJc3+wjg352BYOXmSkrs6uxhgWprTSdy8GVm7NIrvxp?=
 =?us-ascii?Q?u8QtJxbwV4vDXS50xM7W71lSKO7+v7ulZ3Nr51z52R/G/w7ToTZQBeTCGPq7?=
 =?us-ascii?Q?H4Y82JekIpkgjzKSFvuae3eFlWHgtl/lv2Wi51jZKm4eak4xKw8wyh77mclR?=
 =?us-ascii?Q?GCvZ4z/VwkVgbC6oLNrH4wuD6qBc0Wt+92rYHaFU1t68wxvCqJJEQhyFDUZM?=
 =?us-ascii?Q?bXqH9fkcRgFDhVRf8RU3DkYoVZYc15gMPMDefu/pCV0K/cXGtE1PKtjG7jXe?=
 =?us-ascii?Q?TJ+tcN1Fjjme/arAmiR2t4R8x7vNwbOhNqmTP+RTcAFbM7+jK3uYODlU0ymN?=
 =?us-ascii?Q?AOYuVTtHsNAWaFmITvGkiQK5Ezo8F4foofHx+2zQbRWpppX9LQX9Z4iTS5wV?=
 =?us-ascii?Q?8P32QtTHMbb3/wx1QT2NDNY1V0atFBl6HLF3MkSO0x7pI7B+vV7u0SDMwcVS?=
 =?us-ascii?Q?vWtRKod25elLabBcd49iHanxX+Pl/+0Xg1Z7VvCFJZnldVHx/XQPvAT0kiPq?=
 =?us-ascii?Q?YHW/htKCgTc8qjsD3QvHzAwHvPhbgVgTYzVXrUhy7ZlzY4rIFSgGCy4IB3LP?=
 =?us-ascii?Q?pk1VcW1LD+/Pw4Sb+NsynqnxXvoqNgNY1isrVP6mzSDA1Fs8NRaiRAMCk5Sj?=
 =?us-ascii?Q?HPUGf5b7HCdTTLi9hJ8jTiZzvvUqcnKBW0RikSXexWJ/luYNjdkM8bWsFmaz?=
 =?us-ascii?Q?YXnAWfsU8ZMJiY0K3BYj4qAsPfqm3RwnfrJvnRHrbwmlWeYpQ8G7SHNEdEdj?=
 =?us-ascii?Q?D2wwfJtPvXWkq0mVSTM3OiPsP31iqU+2lb87F3RpqFD8m2L5VKi7jNDqd+wG?=
 =?us-ascii?Q?g5UsdFS0+ttTO706+Us96H3DrTCE3RVfbIlqiMk1A1jJAwevVzi1GUGjbhkX?=
 =?us-ascii?Q?yOL92YovQZy3/DaN2laNy9KN9UN/fGd+3qTGqX7577aDgUE/h1xF5+TONnwX?=
 =?us-ascii?Q?VcmqwLU9kHdz5ipt4drqZSmpbuynnJj06aGV?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2025 16:08:18.6629 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e680d2b-bc22-4af7-a671-08ddcb957868
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000014.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6955
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

The kfd CRIU checkpoint ioctl would return an error if trying
to checkpoint a process with no kfd buffer objects.

This is a normal case and should not be an error.

Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
Signed-off-by: David Francis <David.Francis@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index 828a9ceef1e7..f7f34b710d3e 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -2566,8 +2566,8 @@ static int criu_restore(struct file *filep,
 	pr_debug("CRIU restore (num_devices:%u num_bos:%u num_objects:%u priv_data_size:%llu)\n",
 		 args->num_devices, args->num_bos, args->num_objects, args->priv_data_size);
 
-	if (!args->bos || !args->devices || !args->priv_data || !args->priv_data_size ||
-	    !args->num_devices || !args->num_bos)
+	if ((args->num_bos > 0 && !args->bos) || !args->devices || !args->priv_data ||
+	    !args->priv_data_size || !args->num_devices)
 		return -EINVAL;
 
 	mutex_lock(&p->mutex);
-- 
2.34.1

