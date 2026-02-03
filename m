Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 703B0E8304D
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Feb 2026 04:12:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 148BF10E1DD;
	Tue,  3 Feb 2026 04:12:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ju/DID02";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013055.outbound.protection.outlook.com
 [40.93.196.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4373A10E1DD
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Feb 2026 04:12:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DwM28FOCY94uHHTOKLtroMHaVatRXnnzLy5vY37l/eVrzP3sUYAUhes9hBLyxLNvQ05P4Pq8p+G4y2cIOwIFmNqrPqXYBwLeingYUbHKRSfjEZH34ktovzfuxCSpUxhC3WQBweCVpcLZhgNPFSSyCfGpGj4tlq007PHbT9a++bxl1S6oVgZMRGkgLAmGoLIXIJvy7KaAtdXDseEjAwg3QB0tlJSUz+nwselyym8/PgOs6CX4Kthdyg5HNDjGaPd3AHUqxlZAAwAEihsZjYvKon2Wzjr9Mv5sO+4m/NZykNFLkCf9cRLuqahXYNKSUWGZhzAo2QZjOFSqRQEyvUEhhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AJ2RHVgAtPxOQ4tcMHeoJrx8fsq01LX/TWWNyyowkc4=;
 b=d8VgDv4GOz0UV+7VnHIIU7pPuMGoVb3r9JsA4Aygna5K5tqoSKbNrVoR0dRMHA9pCBGWH5khGjfpT7Xix7Rwjs6VArt/qUvwBdaw9W11smI1wJA5Dw5SowRfVK0zfAMNA8GR4WImJoI6Ectyfo6nqSi77azoNqpxewCxnmVzgvj1qNf6moZM9i/JcudtleQV60Oy0z7xP/3wmYduIJZH+VbmzNEmCs0TWbtnOVYjw74xQJ8BGahZfQu+Pv0mOl238Q8H8oq3eIcO/LWxAZv6E119MNtvOJTQXEXRywHKvk7byrwfsc0nJPaSpl9yRZ85efevdPNCJf5scPxWcR5evQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AJ2RHVgAtPxOQ4tcMHeoJrx8fsq01LX/TWWNyyowkc4=;
 b=ju/DID02mXgsmJzZAMlBhEHuzmjnpqs35u/TAZ8qM2XF8dzoDh2H8mMa+TWQeNHiHzRTRKgt74xVjhlH/Ycoq9dP6lJ8GFgHKJozYDidYImBqJLsXu/VFvGMXpEeYD1i5iD1a9KrjxJpSP5bjkqaSPXuqZhMBiniBxyPdP+CmdQ=
Received: from BN1PR12CA0021.namprd12.prod.outlook.com (2603:10b6:408:e1::26)
 by PH7PR12MB7967.namprd12.prod.outlook.com (2603:10b6:510:273::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Tue, 3 Feb
 2026 04:12:36 +0000
Received: from BN1PEPF00006002.namprd05.prod.outlook.com
 (2603:10b6:408:e1:cafe::68) by BN1PR12CA0021.outlook.office365.com
 (2603:10b6:408:e1::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.16 via Frontend Transport; Tue,
 3 Feb 2026 04:12:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF00006002.mail.protection.outlook.com (10.167.243.234) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Tue, 3 Feb 2026 04:12:36 +0000
Received: from gangliang-mlse-vm.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 2 Feb 2026 22:12:34 -0600
From: Gangliang Xie <ganglxie@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <tao.zhou1@amd.com>, <YiPeng.Chai@amd.com>, <KevinYang.Wang@amd.com>,
 Gangliang Xie <ganglxie@amd.com>
Subject: [PATCH V2 01/14] drm/amd/pm: add pmfw eeprom messages into uniras
 interface
Date: Tue, 3 Feb 2026 12:11:53 +0800
Message-ID: <20260203041206.1299104-1-ganglxie@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00006002:EE_|PH7PR12MB7967:EE_
X-MS-Office365-Filtering-Correlation-Id: ce2a7d44-4b8e-4eeb-645f-08de62da7695
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?pCoHX6iqGybPuV55YKKq6L7jFhYWnslcOYSDIIyfTsM6mR1RZfbVM/ifmZd3?=
 =?us-ascii?Q?/SKnO0/t/u1HeMh2I1NKiwlt/cldVF+aIcKUA8mTySQCKGdYkwVYlH+wk+QE?=
 =?us-ascii?Q?Uy7uDnuYSPCQASMksxmcsa5WbvUQ00OW3I87JGio+I8/pgGw84Be93nJN3hW?=
 =?us-ascii?Q?fd43VtKpLMeFDT1aJJT2uMNlzAJcA90w5aKz4P/sVlGAAZCrg00jzIovzPQ+?=
 =?us-ascii?Q?hlAMZ+NCy5f9jWVcwq8R3cDSVm5uI/9sQjdNtCpdNH1Fux6xIP4Tg19C9d7L?=
 =?us-ascii?Q?6AaxfgzpzDrQZTg1gTTjxElS9hiQYdep+VQpFSfuykhb6PDplx3UIHMrj6G4?=
 =?us-ascii?Q?8i/7aNirYRwlCmnT+g1LPM8w8mRLRrXRE8YNvPLsKnH3vBxI3SBwtRYEP+Me?=
 =?us-ascii?Q?zM2ais2BAAGIfmnardtXMj+20KRhLH8Wb3MUAHGsVkC5WdtyYzgnmnAWDpWr?=
 =?us-ascii?Q?P9qtOOdhyMMspoVJn0lYkJrdGcnL6RRlsbLYtvyrYCHvTzLkJXsG3sDNtbBG?=
 =?us-ascii?Q?oqJnYSEaRwP8ybGkd/yJiL6gh0y18iukuMGtPk7Df77fZPlBxtz/dPS5imVj?=
 =?us-ascii?Q?ylIiRTwCKQQWQ+yms6i0xVWE723ocv7KsmBBVwIfN3kq75/H1HfqocNppdFb?=
 =?us-ascii?Q?m+DRy+btST8t6uU/4bAxUohJGr5Ox42IpavmKjlnI9zTgLytVJM5fczL51M9?=
 =?us-ascii?Q?PzFzlZ4WfgQOF1kn2HgRnitYUU0TpW71/eFFQgfMHpJlXpKO81Bw1r/iCXkC?=
 =?us-ascii?Q?uV/z5OCsPAhMV/MCuZ7aqB2qfsiv81DlxJ+k4xFsW7E1HiRq117r7a5awtqi?=
 =?us-ascii?Q?pXIYJQMg7mlU7ysWyLOVVBKWnp4EPICiXaADx5cYN9Sa7OTq8oDi4h+t837F?=
 =?us-ascii?Q?kLCzVDhhUT5bFbZFkunXl6RSVAR3T0E3KqCkymO5RNhtMKYGpOs9tSJTg1Gk?=
 =?us-ascii?Q?lTNgaqVOYf4cVqwH2boWk1HqnxFQV3Yw5CrwFr5OT+z21tPywGHY1GW/7IgV?=
 =?us-ascii?Q?0nihErhQ5EovFQInkPccBj9dohFf7ozViTP0dgPm57hJWKl5xIimFkpptJ98?=
 =?us-ascii?Q?vTfW+mez0BR1ivuRcHR2Bm1HG9kbSwZoqySYqpmGrN4cqal8X5BJE9hz6dlQ?=
 =?us-ascii?Q?e1RN0oYZWfLwrIwzNPzbk4UzIY6kDCEvyaj4PYxUPXdVTqysZ+W+SJkVg1MK?=
 =?us-ascii?Q?Q47vJzmf4nRbBxH3Ss8u0F6sl8LLtMMxBC2Dk/LeOUWgWraNkeSLp5z+dgty?=
 =?us-ascii?Q?2VasDnUEWx2ccfJsKwlDA4NcP0zSuRegEw7dS2+kGeio2f3OZlDU3PtRxNDU?=
 =?us-ascii?Q?VA+nGhdYdHvtDdoaUMDCdg/R/IZ0eL1wQffsZOC5i34DKjFPXOOSygbmw7QP?=
 =?us-ascii?Q?50mMVvHtGTvBTn+JImDgsCQvZ0gy3XdKWkE2+A150qdLZwl7xMQoufMVFWie?=
 =?us-ascii?Q?AdwqdByZzy/fDFzw8p+/ke04iBtdHyVU4iYcfas9D2P+pINoCkzz5x7Ez57Z?=
 =?us-ascii?Q?KmTnNbEyoL6RL37Qan/Xz0wjwddQSw3j2DERCft0l3Ba+14DtIXIHDePGaH/?=
 =?us-ascii?Q?TyIAI8ox6ERhNUnS3Nkb+E9JWejGfGbNnS/OgZ5PlAYA3zebGKpf1dsYvcSW?=
 =?us-ascii?Q?oQohg9OjwY+la2ee/tHZFW/u4WZU93/yD9R+drRlG2EYh6Bo8ZmNXMjDcxPe?=
 =?us-ascii?Q?csNvrA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: OoTzjiHMWr8etO34gPjFfGXG+oKKTGjH7ewUXUPawRgunmi5/gGaK/S8ut0vkITMvzVn2wECg544/54oZSKb2CiJ86YWs5hyywu9kuHF96PkxRDi3WLbVo6I8hKyHbK4jXnsLkV9trq63BS2adhPm4MAFMahlgMCzBVj3Q1CyJ7W/KrL3QBh5RpmcYI9hFAw60B9iy1lYFFLo749spUExPpJ/GkPbJzlk69H9Ye9r71gpjECWP8z+9tGr09w4bGk1O0fGGLFDaJdpIyfGNzFvxuwT35UHAcWq9Sar4osQ8QMbhBkc1sRPPV7LgHAX2apOJQJ1ShgcsU6yv5e5bnhgd/+ataohZF+hy2q5U0ZHkgObvZ8HahyrN9ysPk83vOfLKP5e7iAyexRaknN52EPJh37rgRI6btVspZz4pAAdhEugOLklj0S1RpXd2JX4BxV
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 04:12:36.4652 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ce2a7d44-4b8e-4eeb-645f-08de62da7695
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00006002.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7967
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

add pmfw eeprom related messages into smu_v13_0_6_ras_send_msg

v2: add sriov check before sending smu commands

Signed-off-by: Gangliang Xie <ganglxie@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 57f4069bc827..ec29906b82b5 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -3497,14 +3497,25 @@ static int smu_v13_0_6_reset_vcn(struct smu_context *smu, uint32_t inst_mask)
 
 static int smu_v13_0_6_ras_send_msg(struct smu_context *smu, enum smu_message_type msg, uint32_t param, uint32_t *read_arg)
 {
+	struct amdgpu_device *adev = smu->adev;
 	int ret;
 
+	if (amdgpu_sriov_vf(adev))
+		return -EOPNOTSUPP;
+
 	switch (msg) {
 	case SMU_MSG_QueryValidMcaCount:
 	case SMU_MSG_QueryValidMcaCeCount:
 	case SMU_MSG_McaBankDumpDW:
 	case SMU_MSG_McaBankCeDumpDW:
 	case SMU_MSG_ClearMcaOnRead:
+	case SMU_MSG_GetRASTableVersion:
+	case SMU_MSG_GetBadPageCount:
+	case SMU_MSG_GetBadPageMcaAddr:
+	case SMU_MSG_SetTimestamp:
+	case SMU_MSG_GetTimestamp:
+	case SMU_MSG_GetBadPageIpid:
+	case SMU_MSG_EraseRasTable:
 		ret = smu_cmn_send_smc_msg_with_param(smu, msg, param, read_arg);
 		break;
 	default:
-- 
2.34.1

