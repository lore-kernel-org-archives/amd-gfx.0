Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A139EC0218B
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Jan 2025 19:40:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5233610E636;
	Tue, 21 Jan 2025 19:40:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2pUo8z+3";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2076.outbound.protection.outlook.com [40.107.244.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6DCDD10E636
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Jan 2025 19:40:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wV+0ulH5H0sPy5T9IbFtU6WV2z1a/xfZH2ztm+1Jb9nNw7vmgMmquGnoxo4nP9nX94rsC8G3DpIro2fOERAsohxNa4RnfBadAjJ6njW9h1F85e0yZlG0QmCU3t9szD+e4YR7qwP0cdtjpoLSMzNBu6ckiyW350ftbpG5Ld1YEdMyqj9rYwQgRF/uRqx1jTBfszJs4+It+Uon8QABS6xg7hxXVKnvXLMPJtBOrao2PDVD4OUNtSGXy5FIfocW/5jCYRj9UOwQvNbd/wIMxBriSh9iXfVCJGQotvrhJ07XsCZEm+EhmvRxaVcuEy5aXDh/yPMDyxKavBneeT8boxUJ8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EnL6weNQJ34Y0LLTjGGm6HhwXpk7MSwwC4cKH4UV5Fs=;
 b=Ig6JyYOY/O2M/g+I+Cq1kmrr5f20HDy9K3BvIlq+JGyGFl1kRoP9OBqjuDbMQ9aDk6a59zIojI0Hn/2UDbGvorf9zygM+2CMgdkBh+W83q+yUAzNlP9tXGd3ww1e4w+V+GNjSUInIhBqwicAwfsXYO77mbuo//14MZTW+JmvpmUr+xNaV9gi7B2NSSuZ41NXKzJazuUT2BdbW6NMU4pV5lB8PO8RfLnlhUnOZ+z4afEMBdTJNBouH0PVBXqotUOpoo/WQLpmBpJiLBiSgsERMR/Q7w3OhaIND2f2AzUwn/I1C3qv0m1ZfyUeCu0pkbGs6bcp0qike1b7FT5WcrJ+Cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EnL6weNQJ34Y0LLTjGGm6HhwXpk7MSwwC4cKH4UV5Fs=;
 b=2pUo8z+3E1B0YQxFi1C66tRXYjIunAKdTAsw2BbOJIDaX9z3dtQU/ueffF31aNblzhOSM41PPSPiZ85akygh2ZHojmlxHl3khw0omaGyavLWHyMyTbsdvIKBKPxuRzYFo60g44s9F4nr5iDahuSseWoBEj63seARDftv5rkDm2o=
Received: from BL6PEPF0001640E.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:22e:400:0:1004:0:15) by SJ0PR12MB5673.namprd12.prod.outlook.com
 (2603:10b6:a03:42b::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.21; Tue, 21 Jan
 2025 19:40:20 +0000
Received: from BL02EPF0002992E.namprd02.prod.outlook.com
 (2a01:111:f403:f901::7) by BL6PEPF0001640E.outlook.office365.com
 (2603:1036:903:4::a) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8377.14 via Frontend Transport; Tue,
 21 Jan 2025 19:40:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0002992E.mail.protection.outlook.com (10.167.249.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8377.8 via Frontend Transport; Tue, 21 Jan 2025 19:40:19 +0000
Received: from mkmmarleung05.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 21 Jan
 2025 13:40:16 -0600
From: Zaeem Mohamed <zaeem.mohamed@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>, Wayne Lin
 <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, Fangzhi Zuo
 <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu
 <solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Alex Hung
 <alex.hung@amd.com>
Subject: [PATCH 13/14] drm/amd/display: Fix possible NULL dereferencing
Date: Tue, 21 Jan 2025 14:39:18 -0500
Message-ID: <20250121193919.3342348-14-zaeem.mohamed@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250121193919.3342348-1-zaeem.mohamed@amd.com>
References: <20250121193919.3342348-1-zaeem.mohamed@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0002992E:EE_|SJ0PR12MB5673:EE_
X-MS-Office365-Filtering-Correlation-Id: a28d1459-05c8-4df0-8a0f-08dd3a53704c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?CcnKrFZZC20yjrttWaIb8wTXXyOUOL2mh+u+nNbg6brxKU4o6kO5xL2oMU9B?=
 =?us-ascii?Q?KpTuW0cTV0qT37YFviDqX/yDPfgpR3Kb6b873+H+FoCWDu+LCj+Ty05U53mV?=
 =?us-ascii?Q?h1A41gc8N7laULGZS7LCNBTJSTGbFAWUNpk98aLmxXbCBVUTdTVLARRtZzvH?=
 =?us-ascii?Q?NxizLeGglgDSxuI9USd5zKLou0bz/6exzAC3PH862QYtKIs1mP9muzAmseP0?=
 =?us-ascii?Q?wFJeHmAv2Yl2FY2Xx7nUTCy0kaD122gXpeCqOumxuysoNVkCW8GjMM/i2GCY?=
 =?us-ascii?Q?74K8eLKgH44f0M0B4ujOFQZtF0gN0Pl81fFzDonQZy6mZopmPUwIjuaVVhyg?=
 =?us-ascii?Q?hcxPlIkwyyeGfvYvZuu525U9wVUVrNimLULKoUdBjQTBx+bnzjk7oTm5WXri?=
 =?us-ascii?Q?Czm6TOWjTuwmgcD6AfytN2h1NngTzacg25wgXmVj1QNuqtkWfhrSp/Uy4mar?=
 =?us-ascii?Q?4LuzOQzAiQE9GyMXVUr+ELcDAeznWf37mrQFwXyjkL73w5e6wO4UhhLQZBz3?=
 =?us-ascii?Q?wgMU5m+iA6j/Ut3PcPZiv+Kq++ov+QqMIR51fEqh8Fy6nUmxIh8M6CyoOhhm?=
 =?us-ascii?Q?2LA/XEmdDmeKniCAeE74mY4NxKZEhe09B33eFS/WC2uOrIpgRKH0n5muVP7W?=
 =?us-ascii?Q?WwAljTeiy+yQY7/xoSabRWGTY/YjQt9C33et7aFDmqVEBV73R+/ey7qoGutt?=
 =?us-ascii?Q?JQgwBakMgWfMf0ngvhejc/vUZJEpeptsDYohUKiIhQ0qUNaK+XUnuYsGJd54?=
 =?us-ascii?Q?XCjPzmK3emssZSb91xen0qfV3f99vr2EKTuceq9jvDsf0n8tDFa4Dumfscv6?=
 =?us-ascii?Q?Ol3dsopRLJ+Hhd9Q+E4tI6+S3d8fx1jDTjLf9sqwm4Ned/xb57ow/rJWkJYD?=
 =?us-ascii?Q?5rNqSG4grOUw3ht2hI58vd/3KywDu0GoGU7g4edUViqPu7cowKKeQyHesvBY?=
 =?us-ascii?Q?AiX7fIh6rhQRYvG1fj038W17Y3mPbG7JOZbFvulOj9QLsCPvhM8Qp22R4HBw?=
 =?us-ascii?Q?PGLG2jcX0KLd6AaZSOVMFWf6RAc7LmA7K42XmkiJ+MLJK4NgHgtlYrcusa48?=
 =?us-ascii?Q?jyhJW2KDgMwGiy7PZpyQKS5EoFNVMzvQHBbYrUMfxfzcHTJiNolZe93q2xCi?=
 =?us-ascii?Q?aBO4glPJDH/JRZPpNrqCgV+c8D6w6DiBsxGCKt5faAxlZ0D4p+cffKT+4whE?=
 =?us-ascii?Q?atImyHOFkCpocctD8LLOPO+hyBMAagehD+n/rcy/JovaU6QXaswnbt64/DTa?=
 =?us-ascii?Q?+pUPy4+OZDESdc4YJmtY4/3VgHKAX8GsVrSXWAsKoDllEn3UhXQJfO/e246c?=
 =?us-ascii?Q?cZBXzayrEbe8P/+fY6fME7/Hbf6NWNBgZPPhiM1MRyKXeo4QmIo+yGVRGUrW?=
 =?us-ascii?Q?OqvZFo5CGGBSmJjXtXtRAqI1eItXSjTCf02GdHa1OWP/Day0Uqb48FH0deFf?=
 =?us-ascii?Q?aIeDLBZmBLCl8+kqNC8eRDPTzVXL0RG87AeJf9AOdBLqC70AH7WZXudmuKCe?=
 =?us-ascii?Q?s1fKisA4UyGvql0=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2025 19:40:19.6614 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a28d1459-05c8-4df0-8a0f-08dd3a53704c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0002992E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5673
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

From: Alex Hung <alex.hung@amd.com>

[WHAT & HOW]
GET_IMAGE can return null, and checking firmware_info32 before
dereferencing it is necessary.

This fixes 1 NULL_RETURNS issue reported by Coverity.

Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Zaeem Mohamed <zaeem.mohamed@amd.com>
---
 drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c b/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
index d967065eea47..04eb647acc4e 100644
--- a/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
+++ b/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
@@ -1823,7 +1823,7 @@ static enum bp_result get_firmware_info_v3_1(
 	/* These fields are marked as reserved in v3_1, but they appear to be populated
 	 * properly.
 	 */
-	if (firmware_info32->board_i2c_feature_id == 0x2) {
+	if (firmware_info32 && firmware_info32->board_i2c_feature_id == 0x2) {
 		info->oem_i2c_present = true;
 		info->oem_i2c_obj_id = firmware_info32->board_i2c_feature_gpio_id;
 	} else {
-- 
2.34.1

