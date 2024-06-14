Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9143C27C6E
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Jun 2024 18:34:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6311510EDDF;
	Fri, 14 Jun 2024 18:34:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="TFJjmyyY";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2048.outbound.protection.outlook.com [40.107.236.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 084EF10EE22
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Jun 2024 18:34:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g3wg1fA6sQ1R2Q1YAgyQn3zIORang98VG0J4jnhuN/0eYK3rNg/0SOy8hMDslcD5ADVhZ9cvMtMH0hIsi3Yt5S+e8iDjuVnNwcVtn2av8GxMz5RTI+LALh5mVRZYXvlcZJWumUdM1o+VCl0thChSTD65gp54Li7hFAoKV9vUgzG+tCMAzO/KdP4Rlkx740rFWgvlu49bDiv+xUpsXzdSLNnlCy85dYC808UF12pCQ3v48T5Ef70fWP5eTNOntZyBnz8kyHfePRho3Tp7715KK4R45QoLaDs1qt1+aOy1SrrmmUCT4SjEmZGgr84sh2FPbnpidybLGVOvw7XZDlBjlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RS2aibyWRKzg3Z2FlCr56k+CxroRxN5lS+ayPp0efT4=;
 b=Vdt8ZRbBGkNroTyRimAI4/pkfemRiEB/aOyvpiDNm5dfKr8FMthgONbrJf2J4K2sj1yTnvwCM3mAbFWPNxDYJWGY5FM42wdQwxQTCw5H+bVvh5NY4PZ5gtIxaE+W8URUr7MGwpJSnCF9+JkYKEgt0r5xCvCAZmg5f9rWLQ9pefpuPS7hA6u+GkIaIVJdrFP0FhMQOqnmdDk+rdgLUJ35pzY84iBmkJZl7Tm8U+qxZhBKmXwAuNEL77jPR4t+qs5ZCz3bmrFD9ztpGHBdEZJevssNyyXUPQoakGvsogv9cwhq/FbZzwMTm+2UuDi91gBRGzHu+vGUPa4n9spfS4haow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RS2aibyWRKzg3Z2FlCr56k+CxroRxN5lS+ayPp0efT4=;
 b=TFJjmyyYX8v6g0zupsT2+bL5oJsHJgST1XpQxLbr2nw7zq3TDo0hEGu02A76s8eL8ZAhW44Qsow5Al1iWOlBbneI9p+bC2of1hpam5proHMuQ22Xp4AJYsK+kkZCsE6pOfkhzmbExBgkIIaAEqkrpkynETChYQJHgZa/wqhWi30=
Received: from BL1PR13CA0442.namprd13.prod.outlook.com (2603:10b6:208:2c3::27)
 by SJ0PR12MB6832.namprd12.prod.outlook.com (2603:10b6:a03:47e::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.37; Fri, 14 Jun
 2024 18:33:57 +0000
Received: from MN1PEPF0000ECD6.namprd02.prod.outlook.com
 (2603:10b6:208:2c3:cafe::b) by BL1PR13CA0442.outlook.office365.com
 (2603:10b6:208:2c3::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.25 via Frontend
 Transport; Fri, 14 Jun 2024 18:33:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECD6.mail.protection.outlook.com (10.167.242.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Fri, 14 Jun 2024 18:33:56 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 14 Jun
 2024 13:33:54 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 1/2] drm/amdgpu: fix UBSAN warning in kv_dpm.c
Date: Fri, 14 Jun 2024 14:33:36 -0400
Message-ID: <20240614183337.483183-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.45.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD6:EE_|SJ0PR12MB6832:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f832f09-95e2-4a77-b711-08dc8ca08cb2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230037|36860700010|376011|1800799021|82310400023; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?uMgkNY8KPZBgkoQBk8qubNj4AaZ4mp5kkc3VV3yc0cWHmmp9Rq80fqKDZ3B8?=
 =?us-ascii?Q?urUv+GWeq3TPmM6nr2NmLi1XwblHP69YZWXGdwNllEUM7qQuEBRoKOTCDirb?=
 =?us-ascii?Q?D+3lHMUwSGADN4WzT7+eEO6BThVRon/6omhb522MCn7oYvSpX3cEgYQImLiZ?=
 =?us-ascii?Q?TzBH0Gvhlw047XKJXEqz3+l6PZwdgtqSXwkMSv1vBg8HrwwUKI0s2jPWyd2N?=
 =?us-ascii?Q?zen2u4Mop4/VNfReNzWifq93NwBAuOsQXWyPPURnbcPxHuDV64EVtowDiWQ6?=
 =?us-ascii?Q?fDIpDWmJtmcTeDdspEe+e3kDp9DRZ0ep8u0QT37T4wm+9vHdxzHrUMd9dT+p?=
 =?us-ascii?Q?u2A39QHad40UAko511hr74v0T6jZGvOlW5/P27iEBsgfaFv3ckrvhMyPbzNB?=
 =?us-ascii?Q?nuP8vP98nHe4wbdYsJFb2gz8ux06KJss0hNHQi4DovQqKy3co0t4kXbeVuuR?=
 =?us-ascii?Q?IkczbLu4O+alad7F1VTaYd77M+Ze888yPGU+AzoBbVJITjMYEaeO8DdGeo/B?=
 =?us-ascii?Q?gKCHOm5fGCanhGXG4TP1Yz1CIVA12K37ELgbE7fi3/KfU7r32nyAlzUGZcul?=
 =?us-ascii?Q?4JtC2pw+g9/lS1gv+2oI9rxQ8Ut+EP7korIabVtKPZ0vbUiqgQLi6dQnyyBx?=
 =?us-ascii?Q?Rw+d/wbGoUwZDihiuGN6I2EpYWjo+ji4LDb50W/IrUvA9Q7ZEcJCEJlLk22/?=
 =?us-ascii?Q?nC2q2lg4IVb3EzHM14qAmhyCxkV2xXZeX3U5L8/281YB0j8BUyfksrwR2sdn?=
 =?us-ascii?Q?KYCAVU/c7Hw7kNe5G394Ce42Y31L+0uI62OLhYAGuxNtneo8jzFl9szpMqTw?=
 =?us-ascii?Q?6ySEsuJ+wBo5OYH/40hGxEQw7nhawPWzAzEGj5hfxj5LWpB5W5t9X8/w0vBK?=
 =?us-ascii?Q?JCjKhtRjaZhliWeK6httpybFtiaF9BQMcNCtRzysmR6TVE08HgaFLaCJvwck?=
 =?us-ascii?Q?4ZkkbqUaJB1D+B8C+ou8GvaOecms8R/nD2PCRqG7RsdClUK5ih8LIxGLoaew?=
 =?us-ascii?Q?0ORxUUJuAmIto6/lGDse81UzhWAe9T5/hxelJXjsVUtrXhYlvuEfpY9NYqjO?=
 =?us-ascii?Q?f/AP+2obJ97XDf0hlbv7FJ8UaNvuFaSsW9G0C8vhNbn58XOwxevKBW19XOVG?=
 =?us-ascii?Q?NsVl/voBEBV4too+4BcmQZcJh2dSR6pLw2vLDvaQsjpgC7j5JTzc8NAY1gb9?=
 =?us-ascii?Q?nkNp0qcvPTuYvej80nLSpbzwZ+uEfjqbo0VhBvOn/yxzbqn/F7NWUPSrJnGk?=
 =?us-ascii?Q?tPElg0PskH34MnHe8e93/IxoMgGZT+b0Vjc8HctBpCOx3rZ5i1WWdLDtE7VB?=
 =?us-ascii?Q?Le6QVJTzehWYB0w/IUYvlHXZVE9GUdrnJfup1qXplCf+jg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230037)(36860700010)(376011)(1800799021)(82310400023); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2024 18:33:56.0758 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f832f09-95e2-4a77-b711-08dc8ca08cb2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6832
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

Adds bounds check for sumo_vid_mapping_entry.

Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3392
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c b/drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c
index 6bb42d04b247..e8b6989a40f3 100644
--- a/drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c
+++ b/drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c
@@ -164,6 +164,8 @@ static void sumo_construct_vid_mapping_table(struct amdgpu_device *adev,
 
 	for (i = 0; i < SUMO_MAX_HARDWARE_POWERLEVELS; i++) {
 		if (table[i].ulSupportedSCLK != 0) {
+			if (table[i].usVoltageIndex >= SUMO_MAX_NUMBER_VOLTAGES)
+				continue;
 			vid_mapping_table->entries[table[i].usVoltageIndex].vid_7bit =
 				table[i].usVoltageID;
 			vid_mapping_table->entries[table[i].usVoltageIndex].vid_2bit =
-- 
2.45.1

