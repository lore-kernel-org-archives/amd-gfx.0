Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 093B0C25B74
	for <amd-gfx@archiver.kernel.org>; Mon, 13 May 2024 08:06:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5685110E0F7;
	Mon, 13 May 2024 08:06:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fWaYiCy5";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2052.outbound.protection.outlook.com [40.107.223.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7034D10E0F7
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 May 2024 08:06:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cfi+j1AoQD9tbY8FOzJ6/kzdUcG4jTAeh1rRabztGVKrFrzhpe4oYZ9zxpXju4I5PE64K+lQN8JBP6T063hY9d4d/aVe64CFfW0X03ELqXODBp6NWgdGKCIFCUL9wiqjzecwAFPM4jOFaDliPm0JJ6eDPnifGaGdiFUeSg+LN2PcTLklxkJtg52mt6rTHRzwlA2S1Gbk1sQ7BhRA8oKWE37zWZCDDJ2ySzGNXqxiypP7AC+NS7k34NCTRGGL6FIF0H+/opDxiLMHnogoUubznTsR6kr7do3I8UgG0iyGQ8r0BXRJT5wpVasVOlD6LvFL6yL9vJnV+OwoHFWoLhDkdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aeARddh673SI3+z3DOkAr30+3BYywqtp69Yx141wazQ=;
 b=hqSTzFBLWoqVjtPbxUXAXUBgiJ6A2v42S0uljBNYyu3fEexng/PZElDPpYeOQTxk2dQ7mq/b84JiE5UdtqFqzgQ7QSDG9mDNSlL8KCumdr7hRnLpDF+IAiCRAgOMCP2MaWFQviMAJzyOYD6YXDig/CFXG89L2tPgYZOqpuupjdC9HtsdMVJCljG+oOnE8hZBPIuLKGsXN/YGpta1oeeKeUg6GFIKyHuKoPcAobBSWJP7rOU2nnDgHWgZXnaNOhlH2EsKtci31vKRcdsHZdVYCC0oGYAX3acaBYOnyRzlxI4GUtbTsxY8irDqpFlVHC1y0ibjOi/DwDW39qgMpHn9Pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aeARddh673SI3+z3DOkAr30+3BYywqtp69Yx141wazQ=;
 b=fWaYiCy5O3k4zuIzDgt+zEX77UrEWxm9t0MbiEj8N4vREQsgrhu+y/oINqsypkSR2OxbJbgfVQTQuhvk4j7bc7+2+4xmN6zyOEmjQUmPviHOUUKLnhjJltd5TMv29OBV+AICaMqbQTO10QtuBwUK9j02N2rxQuLzrg0uegr2Pl4=
Received: from DS7PR05CA0074.namprd05.prod.outlook.com (2603:10b6:8:57::22) by
 PH8PR12MB7136.namprd12.prod.outlook.com (2603:10b6:510:22b::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7544.42; Mon, 13 May 2024 08:06:04 +0000
Received: from DS3PEPF000099DC.namprd04.prod.outlook.com
 (2603:10b6:8:57:cafe::11) by DS7PR05CA0074.outlook.office365.com
 (2603:10b6:8:57::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.46 via Frontend
 Transport; Mon, 13 May 2024 08:06:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099DC.mail.protection.outlook.com (10.167.17.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7587.21 via Frontend Transport; Mon, 13 May 2024 08:06:03 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 13 May
 2024 03:06:02 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Mon, 13 May 2024 03:05:56 -0500
From: Jesse Zhang <jesse.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <Tim.Huang@amd.com>, Jesse Zhang <jesse.zhang@amd.com>, Jesse Zhang
 <Jesse.Zhang@amd.com>
Subject: [PATCH 18/22 V3] drm/amd/pm: check negtive return for table entries
Date: Mon, 13 May 2024 16:05:55 +0800
Message-ID: <20240513080555.3614502-1-jesse.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: jesse.zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DC:EE_|PH8PR12MB7136:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f1c6173-ff6b-45c2-6bdf-08dc732388de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|376005|36860700004|1800799015|82310400017; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?6RqKu53KnHAstcAuliWmvHfj546BpQwS9q5J5ap6qQp+HjIocX7t3jHl2ljq?=
 =?us-ascii?Q?gZbymCRzGozoQR+FO8F2zCN3xz2BVxdZ4e5MdNKVWaTkU2TUaIMsM1Ov3mgu?=
 =?us-ascii?Q?J6eNqHMgmSMsmniRtCOqqaJz31Udf5/GOMbV8YzarwAiDJxTICpggzoDyRin?=
 =?us-ascii?Q?nPJ+mnNQNta+2wUoXVOcxiNvSDY2/vpl0x4/vMwil0Lu3bZgkxSL66MrBwZ8?=
 =?us-ascii?Q?RQ/7547s7HqTDsF+ObnRhXWb3UeFeB37R57qEB0SlcwA9IfuFAZqNquTDcPa?=
 =?us-ascii?Q?bycn8zf0E/G+j64iT27jnFY3UmJm6N3JKkE5sKL26XevrIdFGz4ypRua/hqY?=
 =?us-ascii?Q?IJNIDAswHaETmeoOJcE3jux83iOIvVCCAiDlBXt+QbUhX5aljX6mFFLU4ltK?=
 =?us-ascii?Q?bDBie2jBRJyAgs5bWS1xhDo+W3fXVu6A2u8kBLMU4C2YBfaRq0lvAFe3NM8g?=
 =?us-ascii?Q?KKyJicLUgGOaVprJlxS9ukoaoaC86BR+T6a8YzZ1enCiFCf6fQHBnbvewOHy?=
 =?us-ascii?Q?NvEhuDsyqnY56/7zD6Sukxf/3E/dvndjY+mPjJDCwu99854Q9F7GDr2UblyV?=
 =?us-ascii?Q?97hA5LwJ04KoTIR6u+S4Qax88FGtVX2QQjVJffgFWLye+59BT/Z2wnmOaJl9?=
 =?us-ascii?Q?OLJrBE3E5sMCLPUvc6rEF+l/ob8a247i+l7HbB5YtzUeYThqQ3yv/3RBqzsJ?=
 =?us-ascii?Q?54Q1XftScxMlaZZv5aKu8vJZNhvMxJdetVu9YboSt1l8Sn4pwsEyOd4rldQv?=
 =?us-ascii?Q?akcjKbmlBj3XTQ5AmvBAb3u52j/lgNzB/evahwSM+G0OB2Ayit3i3Sv7VfaE?=
 =?us-ascii?Q?qyfyH2qiKBvOgnEvl4gRn4OKnRZKLELc84PFNBcvluKCuNPblu4Ogwkpn6Hf?=
 =?us-ascii?Q?wWkgVlFSUjiXUG+zlYXu83c0cseUV76deRNyJMMqCOJw+zYXURTfc5tD5xXw?=
 =?us-ascii?Q?bjc4nvFqLSjkV64ZswUoxw08E+UpyFI+mTCiRryFVhwym4cf1a5FCW5QtlpU?=
 =?us-ascii?Q?n435gC0VFMyDebASEOv5EjAwQ7M0dmzx1PMbF4XXFy4UNWcTZq+074CDi5pP?=
 =?us-ascii?Q?d5S3tFC57XzBOC3M70qO/EXQ4/ic5TICO/8q0Jl/y3NhIdgaOMKCNFYMd5vQ?=
 =?us-ascii?Q?yXzXB5qXV3MzZupDm1sk0Slg913IUPD9PcRzSODavEvf8fXH0+VLbIXB0W5d?=
 =?us-ascii?Q?jqTFtBsXIsMLATfs6roJnO4TfiF7SjU7QmCf2YtbJxsX05hJ4YrF54cb6rUa?=
 =?us-ascii?Q?KT4+OvajTouBHRtbeyL6MElJNhg7K31V5kSSHenNxg++cll6+cNgoC8j3HPt?=
 =?us-ascii?Q?1wVaDJIUlzrw97w1qHZ5KRgfn9F8FXcF/o8SWCShMoI1BeOBdkq55BOJR0Kc?=
 =?us-ascii?Q?kAWth8o=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(36860700004)(1800799015)(82310400017); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2024 08:06:03.6314 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f1c6173-ff6b-45c2-6bdf-08dc732388de
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099DC.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7136
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

Function hwmgr->hwmgr_func->get_num_of_pp_table_entries(hwmgr) returns a negative number

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
Suggested-by: Tim Huang <Tim.Huang@amd.com>
---
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/pp_psm.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/pp_psm.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/pp_psm.c
index f4bd8e9357e2..18f00038d844 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/pp_psm.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/pp_psm.c
@@ -30,9 +30,8 @@ int psm_init_power_state_table(struct pp_hwmgr *hwmgr)
 {
 	int result;
 	unsigned int i;
-	unsigned int table_entries;
 	struct pp_power_state *state;
-	int size;
+	int size, table_entries;
 
 	if (hwmgr->hwmgr_func->get_num_of_pp_table_entries == NULL)
 		return 0;
@@ -40,15 +39,19 @@ int psm_init_power_state_table(struct pp_hwmgr *hwmgr)
 	if (hwmgr->hwmgr_func->get_power_state_size == NULL)
 		return 0;
 
-	hwmgr->num_ps = table_entries = hwmgr->hwmgr_func->get_num_of_pp_table_entries(hwmgr);
+	table_entries = hwmgr->hwmgr_func->get_num_of_pp_table_entries(hwmgr);
 
-	hwmgr->ps_size = size = hwmgr->hwmgr_func->get_power_state_size(hwmgr) +
+	size = hwmgr->hwmgr_func->get_power_state_size(hwmgr) +
 					  sizeof(struct pp_power_state);
 
-	if (table_entries == 0 || size == 0) {
+	if (table_entries <= 0 || size == 0) {
 		pr_warn("Please check whether power state management is supported on this asic\n");
+		hwmgr->num_ps = 0;
+		hwmgr->ps_size = 0;
 		return 0;
 	}
+	hwmgr->num_ps = table_entries;
+	hwmgr->ps_size = size;
 
 	hwmgr->ps = kcalloc(table_entries, size, GFP_KERNEL);
 	if (hwmgr->ps == NULL)
-- 
2.25.1

