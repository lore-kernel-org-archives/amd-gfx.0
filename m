Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7C16C369AB
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Apr 2025 11:40:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5290210E7D8;
	Thu, 24 Apr 2025 11:40:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mwwkMQLw";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2054.outbound.protection.outlook.com [40.107.93.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 011FF10E7D7
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Apr 2025 11:40:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UR9HMHgIGa3qeLOCrmFSAhBWcaiQau71TZgknLiyOg4r1RlUldhA0scaXuqysUBW85SpxBy44AXzsuQl0x0iCfhmTk9zzisAVnNCvHWQrNZkC0XCKH9yJ0xWmE5CASI8Mbrpm24fTiNuQ30YuOYj+br7SnqTjQaGF3ikQLBP+H8a08LTXXU5zAmCeZcMtyrVgwd0pLWpfguGY7M53NpyKd3GRxBuxTFQCo5etzmiEjE78O2MyvPgzW45LSrmP5pZUNr8MkMMwL/OqtQLi5ZBBiTzGfZC7MsoStKslC9pEK8gQgsCtbb8vS5mBjwosSrbnwhW7IeVzjBKl5CkFtgrSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2RGKE4vbklTm80v8HWv/pcbKUW+kALLSv8Ds5OBCp8Q=;
 b=IoyPlNCIFLyYj4G9ourTjYyevO59ACTEHrpxe2RyoWb0koaq3zh6o6RpoPhtBDrh67DUOzwFfYLh/kBI8uugM00qgHdzVrl09lIQmOW1ZmBJ6+kDOCLtxPEJhWLmKTsxd99ZAjgizA5q+ysKWpZPlmn7P08uRiFWM9nOsOrgx3v/2t8gPwn9/cqjJtY+fF7I8/uaVuFaUflryzo5ZzTAnH+Ezl52miE8cXlAYa0yYqRw54FbEfi+DA5w4YkwfR47/rC1mGgP26bpM2xr6HYSVWeerp3kMIuQK1LnY/5lA6LdXnPWtgnUHGb4tshLAIhux7mTn0kO/GUJPB584OLoNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2RGKE4vbklTm80v8HWv/pcbKUW+kALLSv8Ds5OBCp8Q=;
 b=mwwkMQLwDVXGpjbUpSWt1Poy9KCaVCm0xl+zbG+nhuUQBUUeyUt2jamtzdsxObbn93nc+p2QrNnRcW4lCpCIxaipoPnWwxG/EDTWWr8PDSCQiUNQE7IIQTS73WU3zrxALwgIg6gL7P/b8NcBxWpqcf+Tt1HEWY2wE30lBuP58GY=
Received: from MN2PR15CA0052.namprd15.prod.outlook.com (2603:10b6:208:237::21)
 by MN0PR12MB6197.namprd12.prod.outlook.com (2603:10b6:208:3c6::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.23; Thu, 24 Apr
 2025 11:40:01 +0000
Received: from BL6PEPF0001AB75.namprd02.prod.outlook.com
 (2603:10b6:208:237:cafe::a4) by MN2PR15CA0052.outlook.office365.com
 (2603:10b6:208:237::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.36 via Frontend Transport; Thu,
 24 Apr 2025 11:40:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB75.mail.protection.outlook.com (10.167.242.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Thu, 24 Apr 2025 11:40:01 +0000
Received: from asad-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 24 Apr
 2025 06:39:58 -0500
From: Asad Kamal <asad.kamal@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <lijo.lazar@amd.com>
CC: <hawking.zhang@amd.com>, <le.ma@amd.com>, <shiwu.zhang@amd.com>,
 <asad.kamal@amd.com>, <alexander.deucher@amd.co>
Subject: [PATCH v3 6/7] drm/amd/pm: Add voltage caps for smu_v13_0_6
Date: Thu, 24 Apr 2025 19:39:29 +0800
Message-ID: <20250424113930.464303-6-asad.kamal@amd.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20250424113930.464303-1-asad.kamal@amd.com>
References: <20250424113930.464303-1-asad.kamal@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB75:EE_|MN0PR12MB6197:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ae64264-2750-403a-c274-08dd8324bfc3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?5taT01wYeZyttJYVlRwT7BE6ubF+QReVbhjYV5TiDpXs+1tuM1c2ubXfqZid?=
 =?us-ascii?Q?Zmd2PjuqWzNVXC0ZcUHpXGo8aKjmtdwPz8isue/SguE8LFYx/SjFyyuAel1F?=
 =?us-ascii?Q?5tDiMl9vUAfPpN7DtmCidbMdPulw1pe5mWfxxAZ+Eua//WX/e/rCihZfPa22?=
 =?us-ascii?Q?j6KmZcoCI1xe6hWztu9eJ7qM1Juof1/wvLzN3QgoUR6ZWyiaE1N1PuF9Ii98?=
 =?us-ascii?Q?fpWSaiqPg2bWqIFGFKIW1wdbi6bqz+9D8VQKUDX+4X9+DjGxBV6Rqa2xmbbM?=
 =?us-ascii?Q?CRPsLvnohZ86PwA0YlozNf53TgFoRoAXZRxMJoeHBpmxe25TxnTEblsJXBz9?=
 =?us-ascii?Q?M7n1TXMTBYeqjavkYp9ALIkNcaCh/d8P8LNB4C/MhB8Umh0K0CSg+98cK54c?=
 =?us-ascii?Q?haLY/0wIs9Z+L6vIFKbvJN1fASIhqCt16LAB9upPjcHpYul8BGFFdD0Ml3QA?=
 =?us-ascii?Q?qeykZyoY0ZOScJd4YCk090KQobVv0xspg3PuNwE25B5wjIsQ+UfiV88VUkj3?=
 =?us-ascii?Q?FZtmMjWh7VUWAnK3HgsGgIVSFohDBrWifrEnLqfjjhHKhuzSsmBkrC2MzPec?=
 =?us-ascii?Q?EmeGhStaX7jyU3ADZpz7eekzFW7LmryrUMu8ut0mWgxeDrbjPiMCqrMJx0c1?=
 =?us-ascii?Q?KFMESXXDgq+ciWJfy+fmR7W3bpXuWy5ebs6a9Z14A0eyFtdVfGBHuCWQ8yqZ?=
 =?us-ascii?Q?doHYSdrkgy4N9yCOqm0Mfn+eiZ1ozO6wqcB7w6U7aKMA505ZvT9PDsvKOEpB?=
 =?us-ascii?Q?zbdQ9Pi/1AauhfGZZvF3grN1vSlrcjU6IsfqfZqdWXZAzDobZHp0nlVl3mlw?=
 =?us-ascii?Q?WA8YbUClMpnGuvkUXPIrzJ4adKqugeH8EFo/KTIp89j2Z7LYqmHX0dLyAL/l?=
 =?us-ascii?Q?Vpx0jirLSBAmH2Qa++e5TNbt5VGStTY3yFeiheqYSbxvn0ifj/UjtuZArPDH?=
 =?us-ascii?Q?Brdvgb09SEugAKf4WpzNoP4p5HjuhvNT3DRvRMp16xXffkJ+mdkBmjdsybJ5?=
 =?us-ascii?Q?GaItpebwclEmgD7twobEiWWr95QlnjDS+0YGGd8f0QmFUzqR5jfTIvrqkbDi?=
 =?us-ascii?Q?0+MPJjpzDmSp476T/RguGsWGLTFvwL5Pf9jQDLRoyHey5TKTL6hn+6jGceLU?=
 =?us-ascii?Q?DWQS9DYE/ShV0SZCADCC9O1wNBU0id61A3OgUHAfv3H0p0ePMFaOYteoErRL?=
 =?us-ascii?Q?h4qC+DS5x3Y3BTF1sxWYWFIZywX9j2Lks+DlTIKUsWzcdMEmLvYV8F5cNixk?=
 =?us-ascii?Q?qq4dCzgY9yOxU+F8s4sNHeKkXTnJbHercVgeuJZWdZ7M6uihor/z3NsLbstQ?=
 =?us-ascii?Q?qUACE1zEY45eLr6g5FLulRzClMXF7S49Ft1lV9DyHD2yL/BvMFc6gu+jFn8N?=
 =?us-ascii?Q?D6lotRiVEig5d79ditoQVcmnn9ALNSxaKE7C0rvjUZx6fXI3njTxkgwiShPC?=
 =?us-ascii?Q?JIgvTcWyG91ZU/+yT9wQC2RDsv3o0nRPgAEIL+vpLXouCXF1Y4LA7VyIbDIi?=
 =?us-ascii?Q?JK/Awmmo82W4CDnvifDFyf9KNJxsnuUc5ejs?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2025 11:40:01.5382 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ae64264-2750-403a-c274-08dd8324bfc3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB75.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6197
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

Add & enable board voltage caps for smu_v13_0_6

v3: Update version check for board voltage support

Signed-off-by: Asad Kamal <asad.kamal@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c | 4 +++-
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h | 1 +
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 41a9829215b8..f8e06913cd72 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -392,8 +392,10 @@ static void smu_v13_0_6_init_caps(struct smu_context *smu)
 		if ((pgm == 7 && fw_ver >= 0x7550E00) ||
 		    (pgm == 0 && fw_ver >= 0x00557E00))
 			smu_v13_0_6_cap_set(smu, SMU_CAP(HST_LIMIT_METRICS));
-		if (fw_ver >= 0x00557F01)
+		if (fw_ver >= 0x00557F01) {
 			smu_v13_0_6_cap_set(smu, SMU_CAP(STATIC_METRICS));
+			smu_v13_0_6_cap_set(smu, SMU_CAP(BOARD_VOLTAGE));
+		}
 	}
 	if (((pgm == 7) && (fw_ver >= 0x7550700)) ||
 	    ((pgm == 0) && (fw_ver >= 0x00557900)) ||
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h
index c7a07aa5ef14..5313206ae4bb 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h
@@ -66,6 +66,7 @@ enum smu_v13_0_6_caps {
 	SMU_CAP(SDMA_RESET),
 	SMU_CAP(STATIC_METRICS),
 	SMU_CAP(HST_LIMIT_METRICS),
+	SMU_CAP(BOARD_VOLTAGE),
 	SMU_CAP(ALL),
 };
 
-- 
2.46.0

