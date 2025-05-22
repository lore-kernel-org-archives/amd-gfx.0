Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 869FBC54E65
	for <amd-gfx@archiver.kernel.org>; Thu, 22 May 2025 14:13:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A9F8910EB04;
	Thu, 22 May 2025 14:13:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="G6YishS0";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2066.outbound.protection.outlook.com [40.107.223.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7E85B10E972
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 May 2025 14:13:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oF9KEMvQ03ILbADq1BA0vEtC9enoeDJAafFecpkGbqu3t16qc5OgrNTN4ai3o3wf0oIB4dkDLcoxxoFWQzypv+g87k0GKzhZ47Oz82wXqZRa2Ygok1k1TPuYFSqxRvV0KDJbHR6y+x5iujFAUBnBV0je/zDxjoWnnIiaIu/344pTepr6f/8dVNo9uczapHuWCvzhUNsG/ACt++sq2WYd0WUPaqZyU7GrpPBQf/M9I7GYefYzRGNbcBwXNKjf16nW1CY1C0wQu2ST9mONqAKiXn968Znp9tQdRtiFUM1feNhax0d4offxBd7d5PUNs8zcwnIyhqFA+UpBvZH3lWICCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3IZbFHFL6y08pnuruUd0NGhfzR8xJHH0vMX1f9xJzr4=;
 b=YtbdqyzMXuhNu+XymCNCY61voXvfMjfvJvAst6dZ0oVdZaHL/IoMBho3VehqyVFx1y1vuFHuQ7duFx6bqmMMi9aW9iCLJs3RJWxFonMjje6tk3sKh+0FuhqX7E9ZpDYiFNJdkCHMKP6zHLrmQ7sqPGfFatPLEsv6KYcjubgBpjMkYSmg/ca3iyrxdduWJio3IQbrEGU2mvwr1BZ9VIe8JuIBayJNFThfcXLO4Bcm/aHWKt5LspUoEFSPHGn2czj3+sfYYXEiiIAr+cfpBkSjRhKY5kskgTC/2gO0qqmVjHH8ZFwxXmNIOl67GJPNS1KQBGbPmR+gV65NSt/a0Cz/fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3IZbFHFL6y08pnuruUd0NGhfzR8xJHH0vMX1f9xJzr4=;
 b=G6YishS0CMXiJ8T/cnNpTq7w9QJC6IKXeaMX+DrpSE+0Wi4xAxnMfqoxiTdHHpXRgJTdAHLETghg4JPn6d00ClDcmSUXUWzVMDPP6+ZODQkCTxUb7DJyTu4LbAoR+Rpvy6yMjbTWHyvHgWOrD9XGsKuD+6dD47yUWc8/Grzpijc=
Received: from BY5PR13CA0030.namprd13.prod.outlook.com (2603:10b6:a03:180::43)
 by MW4PR12MB7288.namprd12.prod.outlook.com (2603:10b6:303:223::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.30; Thu, 22 May
 2025 14:13:42 +0000
Received: from CO1PEPF000042AD.namprd03.prod.outlook.com
 (2603:10b6:a03:180:cafe::bf) by BY5PR13CA0030.outlook.office365.com
 (2603:10b6:a03:180::43) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.15 via Frontend Transport; Thu,
 22 May 2025 14:13:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042AD.mail.protection.outlook.com (10.167.243.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8769.18 via Frontend Transport; Thu, 22 May 2025 14:13:42 +0000
Received: from dogwood-dvt-marlim.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 22 May 2025 09:13:41 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: <mario.limonciello@amd.com>, <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] Revert "drm/amd: Keep display off while going into S4"
Date: Thu, 22 May 2025 09:13:28 -0500
Message-ID: <20250522141328.115095-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AD:EE_|MW4PR12MB7288:EE_
X-MS-Office365-Filtering-Correlation-Id: 8278424b-594f-4fed-77bd-08dd993adb3c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?qAinj4PVJwGoWcLZCPatzq42n7du78hYK4aL1/SWE71lLNphC030JOlgZLbP?=
 =?us-ascii?Q?w03i7tpY0jIjvY/ov4RHYRr5s/v96c/W2dzYzu8pTOzhjMMHNwz/4bTiriwz?=
 =?us-ascii?Q?WTNcFvkuV0+gUZeX6XGBYVy9CP2BgN2O2iqqB3o4gb0nY5NqXDLdgWi9/ybo?=
 =?us-ascii?Q?iTpPXINjtppD+7MvG29Xgt/HvhlWmPuqen8iucf/VuAunmP3hkq3CqG6Fb2w?=
 =?us-ascii?Q?wpAvnv7GjB1fNFq1IYxLpKK35HZOlZXwOncco2HvBQhMO5wFf0pZ0UtZ5Quf?=
 =?us-ascii?Q?nhSxBKCOo+PD8A6DskLG7wQg1TxPDjSdwzwsi3jBmR4mZaoO/4G48E9EzueI?=
 =?us-ascii?Q?y8AslETT5nOyvnzZVhHgbLndukMEnrkFws5hCYR26EMGAHvHLy6gemWH5g3G?=
 =?us-ascii?Q?HURkm74VEMHtvzki6Hef1dCzUCY+LTA9XnxY4zSMsFHnunMBtqW/dlKEFDi9?=
 =?us-ascii?Q?5OFAnwI4T+TaAf4q+208qx8wjjr2APxIyCyoHck57KbpOo/rsAGb6mAC1iSR?=
 =?us-ascii?Q?DA9DgHm2kwX2EtfzKuuBgs63e6OMkEJivJm4/URi6RDMN9gDlo/bkkOTeau8?=
 =?us-ascii?Q?HJ0/GD/pjHQ8VKgg8upZ99T2noFGGDiyHd2gjVYzTLBJFF8NtHf3eY5+8Z1I?=
 =?us-ascii?Q?VmH97miIZ9qcI58tg2XZFgIDzE95ict9ockpK9RgKDJAwuAKsFw2Wyu9tkwS?=
 =?us-ascii?Q?aZTXY0gVyQJTPqUSTG9ISgwR20N+nP2gIodHB3Q4Hxd0XPA3NMR5/TvW4t1v?=
 =?us-ascii?Q?Ex6HO1blzCWQwXD7CDm7oDjckrl03A9Rx0HqjPZt8+s8vnsmAOkYykiKuYkW?=
 =?us-ascii?Q?Hkrvz2Xi0111zGacMWMB9NFAb6mHJ1qT/Tn4/OJjrUaXcW/u1eWLt9/ZDw/d?=
 =?us-ascii?Q?5hesMyN/vZSmGW1ANGNv58CYcoYvA3O5MFBcy8HLo24YJ0N84NvsCxajR+WQ?=
 =?us-ascii?Q?SFfW5Mkb8X9lxPiZCZ/LSy4SKLdTS3CBXr63ZSBbBwlfS0irH8b+D8vZcZ99?=
 =?us-ascii?Q?S0594QbyOOQat3Ev6hDdyIRanOPVxz9rGWoyqrLOBfHmOtCCV+Cu15S/QL3Q?=
 =?us-ascii?Q?4zNfceDvT5LMQfkqD8HBUQttsI+hBk8FXz4g6v+9ffCN6WieFKtDP4VoYkbq?=
 =?us-ascii?Q?/LTinLK1GhQhqNdApWxaW1Cjj698cyFjQ95iHMFnH0IGQWGLzS5JG8jC2LVt?=
 =?us-ascii?Q?odXzamhLmzYKuAJMf+oovJEBby/iMuGVxETUCsHckAxiqM+qIH61NQKZhioH?=
 =?us-ascii?Q?IGXrunfy93iDuwyHujta0rcWoW6iVW17f73NrDnFFHlVujY4dUrRBnBljhd+?=
 =?us-ascii?Q?78gBoJIphjiV/jTHPsWpo1GmuRHjklC27rKeYmRWJZW8DhwZrHofHXTHpgly?=
 =?us-ascii?Q?aPq7q2aj39omiUb8Hxx5pkVvhAcIrk4l6D2ZA/RgATxTsio0gLsKAfqth42f?=
 =?us-ascii?Q?DJBPHHVvXwTVzxvHh8q7sVwoyLqjzzyEBSJRKNzavL7Jy3K/WXT1KQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2025 14:13:42.0359 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8278424b-594f-4fed-77bd-08dd993adb3c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042AD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7288
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

commit 68bfdc8dc0a1a ("drm/amd: Keep display off while going into S4")
attempted to keep displays off during the S4 sequence by not resuming
display IP.  This however leads to hangs because DRM clients such as the
console can try to access registers and cause a hang.

Cc: stable@vger.kernel.org
Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4155
Fixes: 68bfdc8dc0a1a ("drm/amd: Keep display off while going into S4")
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 7d0687695645..c876f78618cf 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -3469,11 +3469,6 @@ static int dm_resume(struct amdgpu_ip_block *ip_block)
 
 		return 0;
 	}
-
-	/* leave display off for S4 sequence */
-	if (adev->in_s4)
-		return 0;
-
 	/* Recreate dc_state - DC invalidates it when setting power state to S3. */
 	dc_state_release(dm_state->context);
 	dm_state->context = dc_state_create(dm->dc, NULL);
-- 
2.49.0

