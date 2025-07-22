Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C2AEC83F1A
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Jul 2025 22:46:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1436110E732;
	Tue, 22 Jul 2025 22:46:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3thpBOPQ";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2075.outbound.protection.outlook.com [40.107.223.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9547910E733
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Jul 2025 22:46:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NjT/ga0y0LE5lz/kML2Nf+3DB9uuhmdibV0s9jKOiwjBpT1aKzeRSVk/vAdY3eYQfsMxTcmVQGwMzmqAmeciIZI9PIqy2pwlq40IbfPxiGLsWMqRBh2ePRL56KI2lYtjd7U//+KFVyhLAtwIxJILfAVt7Ji1wCFpuMSEY2h0RlY8+7yBcTar+tW2MUXmbVLFK3ueDCLew7wK9kjuQQ306KaQheGkQvQGfQbKyQ4vIV+wDaIbE5Hi0+3CMVsmL3T6oelT9DNPvOtuIRFa0e7YsVFj7fvF8i5YEO8u8wdl50RgUEIHKNtzmkwBEKU0yQRbMtLHpTC5FG0qNdP7oPZSUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EYYIzoOWCpyQjcSpJ6H8njrKUw7NSsVBhxbWQ7aY0lU=;
 b=ED0vUxAXuwNbAsKTfn0o1ujPpcSllM6KKyTLGFzFAclBayDUR6h++XWf7HfeWXKa/Tk9HBmKtMjZF3wiKLrFDZ2LIveW4+wWvA2JhEN0FqxgPd+Ak6zz5ZhigkGZjcD5nkXalicrb11HymycxAfPyvu+8oYyMZiUY8GhPVzMNrpekct4sgDRJo6/ToEq+klkhRK8cp7FGBGlW+YI8iX78tmMDEnbTqHQOvqc+sT2DFEjWSiofgT12cg1VxGdKI/yRvecWLkyiv8Qv6L/t5ule8VB+V3pZMxx/SVc43qXp/ROh8CtmtaRFOLAm5BhjyHdG3FZ7S25q/cuFg3GojdaTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EYYIzoOWCpyQjcSpJ6H8njrKUw7NSsVBhxbWQ7aY0lU=;
 b=3thpBOPQ4S354Y5oJ45w64zg3beAoKp3xDBkNKflx5iyFTRcl7231b8C5Y2qA81Mk2YFPaFd3trO30A3x04loWdKFUKazOapChBN8MEaDPnVkOuF0wcnvHwcoUhRjWHBxsw51n2pvCa87KzXFQCn+r9WcYxbmeu51AWyInbKVGs=
Received: from SJ0PR03CA0364.namprd03.prod.outlook.com (2603:10b6:a03:3a1::9)
 by DS0PR12MB7655.namprd12.prod.outlook.com (2603:10b6:8:11e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Tue, 22 Jul
 2025 22:45:58 +0000
Received: from SJ5PEPF000001ED.namprd05.prod.outlook.com
 (2603:10b6:a03:3a1:cafe::31) by SJ0PR03CA0364.outlook.office365.com
 (2603:10b6:a03:3a1::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.29 via Frontend Transport; Tue,
 22 Jul 2025 22:45:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SJ5PEPF000001ED.mail.protection.outlook.com (10.167.242.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8964.20 via Frontend Transport; Tue, 22 Jul 2025 22:45:58 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 22 Jul
 2025 17:45:56 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 22 Jul
 2025 17:45:56 -0500
Received: from box-0.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 22 Jul 2025 17:45:56 -0500
From: <IVAN.LIPSKI@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Alex Hung <alex.hung@amd.com>, Mario Limonciello
 <mario.limonciello@amd.com>, Ivan Lipski <ivan.lipski@amd.com>
Subject: [PATCH 18/25] drm/amd/display: Pass up errors for reset GPU that
 fails to init HW
Date: Tue, 22 Jul 2025 18:44:27 -0400
Message-ID: <20250722224514.2655899-18-IVAN.LIPSKI@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250722224514.2655899-15-IVAN.LIPSKI@amd.com>
References: <20250722224514.2655899-15-IVAN.LIPSKI@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001ED:EE_|DS0PR12MB7655:EE_
X-MS-Office365-Filtering-Correlation-Id: 22733398-8e6e-4b94-90db-08ddc9718689
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?/A0QXzg6VSm96Xf/ZeAHLD6IY9gi5HUe67i/VPub7mpcXxC5m9XUsu/IYzDf?=
 =?us-ascii?Q?JovpXfTd46vv9T8KtfATkd+bbB9t4KZ0fD8x/VN37RmsCm9eAvkI2aQYEdBM?=
 =?us-ascii?Q?VmNeQRKONWKldoPseVl5pLp1o4GBpczpi15yMsn5CABl+foSPlQhO+tCQS9P?=
 =?us-ascii?Q?dzt42wKOKWjK3twLq1Z7pa+vLFCgKh+LHZaIOz1vBOrLgGxJ/hSBN4NV5ZJW?=
 =?us-ascii?Q?alDAJBvzMGPRmNQMJmvCQllb9qxiNK+7b7VSmYBWtLq6aTf5nSIUXG6yj5qF?=
 =?us-ascii?Q?IuYrxCsi6GdFu2EFk+chdwwmHm+PoiQ6PfyYHaAEZj6pAkP/xmP+DHZHqd0t?=
 =?us-ascii?Q?VCf9U6EP+/FBDGmHAWfHOD+icRfL4Um3Kotc5DfP7nZsjcLla1BXsq6c6r2O?=
 =?us-ascii?Q?Vfz+CN3xcTsDSP1I7VDowr+V487alI82pgql5AOB+Kwht0633oDrbeD7ZZI2?=
 =?us-ascii?Q?MJQVYuHCOPZrzWCvHj48KAW32BYd47veo9PUpSRdXKccM3jb5CRa2qdAEgOS?=
 =?us-ascii?Q?tlX4KfSriiq1Su5x8kUJPRAL2ehI0iK6/Leoosv1vimkgv/Gu7vWlamgytkZ?=
 =?us-ascii?Q?+XVks1lr0CJsNeF6sB3JwX0XIiJ5iZgrb2zwCPxEsX3uxK98IAOKr410E03d?=
 =?us-ascii?Q?D0M16vOeJ5acdQD8m+ZiAtPo9250h8shvj7aiRlP/7fqJcuI5yc1h+4qcncq?=
 =?us-ascii?Q?mwjkNn5lDa0k+a040uUEngzAEDZmgkeWQp8XBMAjiWsJnbhHc8i9xNkkeJRM?=
 =?us-ascii?Q?Bu5EMbN/iD0AkBVT06vQBeHWMPfRFNJZvkgNxfPDm8adZY8cEXLcl3zJVUf3?=
 =?us-ascii?Q?/JP45aX22mcQXFy7uad8WBAYLMkR3hYxBwkhRJ6oQqBNcXACYEiCHhtIxfwY?=
 =?us-ascii?Q?VdHOUTpxsfSmhoMbjS/HPMvfP1dby953ulaj2NBce+KwzJ305y+qz0jiUoR6?=
 =?us-ascii?Q?SNcTaMaBdfW1RZbKpdL0RBL2koj1stvp326Ldqoyb0E7CpamDdrc0D0jWLiC?=
 =?us-ascii?Q?EVAH5URTFrsOGR8Es+0RZfWEvBxJziMgYuxH5yoGa5ORZY/ptxoHfnhDQ1G4?=
 =?us-ascii?Q?ptIEN4p3/2umu2NE7nJHn+dHaGbpBC8MMcokfnb8l78Nzh3MILufiZ5m61pT?=
 =?us-ascii?Q?szcYv7Z6BxyZukv6vR+edJl93ucrJ507vL9YgEqkr8SDepsH8N1c6tcvoJ2Q?=
 =?us-ascii?Q?MHJIfvKdv9xhWJJ34fWqXTfZM2BHO/hruq+HYIPUA1TiBnrwO+FtuYjhRyYe?=
 =?us-ascii?Q?heubctPl23y5HI0uQjOikb7NZILxNqBoglUO7iQNbP8dwr1quHnZHHfEq4Wg?=
 =?us-ascii?Q?610S/QZfUg0GQeSOBLlQ5EUuNFekugh51jJ40Es/g9UelSLIn+AZ+c1k34ty?=
 =?us-ascii?Q?uEiYFconM8lfaTQ0FzQUFOeZFAnY8X6VxT8GyL2Ib1vqesxKgV2BqVuuu3/m?=
 =?us-ascii?Q?QI1PibOHoIQJkb9yBp3/INpi9YsNRLV3cZLEFUV30EQ/4ZvW+l/L4fAGOPmx?=
 =?us-ascii?Q?EnLD97dxILQ5LdoJQBGbeOn8KZ/6x7h61mPk?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2025 22:45:58.0788 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 22733398-8e6e-4b94-90db-08ddc9718689
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001ED.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7655
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

From: Mario Limonciello <mario.limonciello@amd.com>

[Why]
If a GPU is in reset and the hardware fails to initialize the rest of the
resume sequence shouldn't be run.

[How]
Pass error code up to caller of dm_resume().

Reviewed-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 2113732cc97b..986db004d30d 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -3387,8 +3387,10 @@ static int dm_resume(struct amdgpu_ip_block *ip_block)
 		link_enc_cfg_copy(adev->dm.dc->current_state, dc_state);
 
 		r = dm_dmub_hw_init(adev);
-		if (r)
+		if (r) {
 			drm_err(adev_to_drm(adev), "DMUB interface failed to initialize: status=%d\n", r);
+			return r;
+		}
 
 		dc_dmub_srv_set_power_state(dm->dc->ctx->dmub_srv, DC_ACPI_CM_POWER_STATE_D0);
 		dc_set_power_state(dm->dc, DC_ACPI_CM_POWER_STATE_D0);
-- 
2.43.0

