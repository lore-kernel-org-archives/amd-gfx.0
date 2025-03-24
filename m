Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7BFCC3600C
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Mar 2025 17:26:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 571AA10E4A5;
	Mon, 24 Mar 2025 17:26:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mDZt1qir";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2073.outbound.protection.outlook.com [40.107.96.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 691E010E4A5
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Mar 2025 17:26:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o0BRNqvmNiQkVnzwoYqIyodRutUQnURqKMIK0xvHYc6TRbj/6VLVaArOE/Rh91SuLTZ8aciOUcfkAdJ4iGyg5k5vj+lRoXSgj/NZHfTHKlSLmSh1HS9obSKxsPSsGbVq5GAQBY7EbTXDjxgFhDquyj81/sm8aUii+yrCunkqBCLrEG2senzj2n/vhL+UTBccxfeLN48S0pSD84i6/oX/IG/ge0kcjwxew+CclzpM9e6Jl3fFjYV0WUFYfx5SD1jdTdrS4oZ32Vw4oNo4Htf5LOWUA8yt3sa6SwOp3oMm3nQRcI1VesVvbZxHV8XZNTmRWmP8EKit1GZU1/HJ9QX4Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OWbSK93XisDeRPn6j8UiaJpEnThJihLO/nLqFQ1sokE=;
 b=jDEilbFMs4eTXgyDrJA5AzPeWjIwoNkRaiFk4auMK5hWRANN6FecQthko+6cmZisreBl6fW9EEidieQpgP2+egUbh1Ct5GRse8IAnrNAMyi3Rs5cW0ql2FyTMR0S9fHyhhpk0sow63qGc64ddngi4yHnU3ITUx5stwXHicPTFMCUGhdYWXuJKA21GKfkljvruluZ+4KEm2xWJR6JtIZXN3iG20z9a8UN6q1TqClMmyKPdg7Xh31iA0m0Wd4KeRC0ci5yGXB/rn/yu6dyAvYip08iIKTRQVH81J/i7kGPlmUR8ka7g/v9qMAgjrAoBFSLb0H32a4mVVKKvENKZa7khA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OWbSK93XisDeRPn6j8UiaJpEnThJihLO/nLqFQ1sokE=;
 b=mDZt1qirhXTVYTHl1tV8zbqfSPhSGJHgtPMHpkwAG8IotKwzBMs/Jf+2lpgqrYKyAg8T3lLNF9rzuSP6fmbgBUPDcPF3Wk1RrrTxAPAXjliRz1amptwcj6DReMobkLPcEzuj9m/7ERPEBnZCOMDYnCowhNk3xQHqdpsndQwe3+Y=
Received: from MW4PR04CA0297.namprd04.prod.outlook.com (2603:10b6:303:89::32)
 by DS0PR12MB7948.namprd12.prod.outlook.com (2603:10b6:8:152::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Mon, 24 Mar
 2025 17:25:59 +0000
Received: from CY4PEPF0000EDD1.namprd03.prod.outlook.com
 (2603:10b6:303:89:cafe::da) by MW4PR04CA0297.outlook.office365.com
 (2603:10b6:303:89::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.42 via Frontend Transport; Mon,
 24 Mar 2025 17:25:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD1.mail.protection.outlook.com (10.167.241.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Mon, 24 Mar 2025 17:25:58 +0000
Received: from eric-hp-elitebook-845-g7.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 24 Mar 2025 12:25:57 -0500
From: Eric Huang <jinhuieric.huang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <xiaogang.chen@amd.com>, Eric Huang <jinhuieric.huang@amd.com>
Subject: [PATCH] drm/amdkfd: increase max number of queues per process
Date: Mon, 24 Mar 2025 13:25:40 -0400
Message-ID: <20250324172540.128507-1-jinhuieric.huang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD1:EE_|DS0PR12MB7948:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f014b68-79b9-425a-d422-08dd6af8f11e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?aZZbijj6hdsEHaE+MvPQTBjmvden3XiMNCiG9HKi8L45F781RS/DexOYfsbL?=
 =?us-ascii?Q?GWkU4ioHhxANl/hp9Dpn2meVT6ibycAAoxj0Pqr3bkbL29Ax6T0FrOXLua+V?=
 =?us-ascii?Q?uNsMnpARZkOCzsK9Zao3u7n4UM8bJe38j7EWn9orORP02gYYgsKY1uYuTZ1N?=
 =?us-ascii?Q?N2EgeyjcSnAqO/U4cw0pi5qUj913rWbRqYxdXs+pxzF47Dln6/muT1Rj6dk6?=
 =?us-ascii?Q?si9Gb0uJdGwKHRn5LDtt+fyKmEuoCqxwqmJo2fQsdiOPCNabjL2S1Y9iAf2O?=
 =?us-ascii?Q?v2tHP9nXLI8VQZlkeptdLh1ObEtyMZa2sumlyA5GDzFDyBBCSA0VqTmM+yJ4?=
 =?us-ascii?Q?ffz6lv14CaPTGSPJ1RZoS+27l5tnr8rC1MsOmwxWhjYo/c61t7TBqASPSOsl?=
 =?us-ascii?Q?AugJR43jVi4DWYQFrb1gfjtIUesCIZKdK13+AsU1z1Z8Iep/2tl8dn5a2kUk?=
 =?us-ascii?Q?Fg5uACx2AOuiACSK5+DxlzFeXOe/VJUdMXlJScsVtmU0XQiiJYgCas6xsaIm?=
 =?us-ascii?Q?hanz8lV5FVupSUc6i5t1e+AS8VpXqM8Z/8q8sCQKCXLzYik7ypOZO7f2Hy8d?=
 =?us-ascii?Q?r/xG7vJZ80Kd4TheKeyNXD+4THvQBJFMhv0Kq7zzaMeSsP65kIdmGj+OjR+4?=
 =?us-ascii?Q?THHIGrFlN0ksu62JgBo+OS3zxagX/lWvHueUw8t9aYA5SKVN1JDHOtSYoQmf?=
 =?us-ascii?Q?VcxhAaN/lTnYr77wQ3jwmlXG1fet2o9r0qEMcjZZUWs3fnRan3w5PjTojFYD?=
 =?us-ascii?Q?E8SF8jwPdzHFvejlPdZlLwFqM/J9kgnJkLNY8CRue1dB713hhVo1szsAtWGc?=
 =?us-ascii?Q?aEFHSAgpPIeEIh4Kmn76ELKixsWW7hJ7bXyX0EJt9W+VYSYg/3cWrqP2w6Fo?=
 =?us-ascii?Q?vARTOm5hUJUcFlKUTsE4USQLuPOC95aD0lJzR4JWTzk0VUk5IciZDj1l+l5L?=
 =?us-ascii?Q?8gSUts1rN1RS0SAIM71AzpjAWYjmfX+fJeYIzvU2KVff4rqcguxTiVbS7I8h?=
 =?us-ascii?Q?0QmzNDCDZUaatHIipmaVGAfnJ887QhfEoDVHsi6+Sq9Zgi6rrD6Tx4QOZ4e4?=
 =?us-ascii?Q?Vgf1vvAPdL3vczD4F1kvjYpsQlEEFoiv1CPQdkeIswkwbRyrusz0x8AeM6UD?=
 =?us-ascii?Q?hog8ozQ8MWJnUnjAX/QfoT1I+0+ApwB6nP5QJHkvRDL63fcp6gqmw3Tfa+QG?=
 =?us-ascii?Q?mDRiMkWepCVMdcSVPbd0u1XBJCecrCQaFSK69UrVPl/4x1Ze1jMJoMB/olGs?=
 =?us-ascii?Q?qdt7d9PZQ36vWNnaO9I4qBCmwHoO/UUfYm7E6a3Y7aoiMTw2OUHpNy+6rgo4?=
 =?us-ascii?Q?CBjqtcJtiRn0tQOo74ta9ZjDd4KS1YhFeTxOD42MhoVA0sps7Ua33W8r1s2+?=
 =?us-ascii?Q?wLipio4z11PJ27Of57d2qJKq21AXvAQQKICDdgKChahhCIKx9wN747IBzwTt?=
 =?us-ascii?Q?CV4grciga46S/UtM9o6XHole8P5TYbFazabau60vtrtMtKm2Zc/VGQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2025 17:25:58.4522 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f014b68-79b9-425a-d422-08dd6af8f11e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7948
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

kfdtest KFDQMTest.OverSubscribeCpQueues with multiple
gpu mode fails on gfx v9.4.3+NPS4+CPX which has 64 gpu
nodes, the queues created are 65x64=4160, but the number
1024 0f KFD_MAX_NUM_OF_QUEUES_PER_PROCESS is not enough
and test fails at function find_available_queue_slot().
So increasing the nubmer will make the test passed.

Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index f6aedf69c644..054a78207ffe 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -94,7 +94,7 @@
 	((typeof(ptr_to_struct)) kzalloc(sizeof(*ptr_to_struct), GFP_KERNEL))
 
 #define KFD_MAX_NUM_OF_PROCESSES 512
-#define KFD_MAX_NUM_OF_QUEUES_PER_PROCESS 1024
+#define KFD_MAX_NUM_OF_QUEUES_PER_PROCESS 4160
 
 /*
  * Size of the per-process TBA+TMA buffer: 2 pages
-- 
2.34.1

