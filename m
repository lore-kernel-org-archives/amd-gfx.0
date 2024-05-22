Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE167C25B79
	for <amd-gfx@archiver.kernel.org>; Wed, 22 May 2024 06:31:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D84C910E774;
	Wed, 22 May 2024 06:31:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="v4nDfGVU";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2078.outbound.protection.outlook.com [40.107.101.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1F0F110E622
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 May 2024 06:31:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YNOpMwJz3C0OB5SM8anQMhc1kOVW6mvp3EQlpPxNpO9PqX1Ooj29Utpxl5tRXem/JxnOSYv3WiKNulg7cqFruXS/6LgdoYiwMd2J4pYpnUiy8Qix4aB1Fk9fRumXbhrSCUtCeDszaxyKszZowzbzExr6ulgUDQs9OpSZlDYmOUlkkIBM2nqCfsDv3b1RAhnTjkxWYDsPDsg2a56YkX90Acmf/73cB0A4IP6GPkhz906wYIadIU1/mt9yvnc9KV4ABknWF/F8tanWQvNQLPkGHoAs8pUT35D18XLEP9D5oYhvqy13Bmv1jogv0oi9S6eMsPK9P4TwOHPU6yd3deBC0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pwLwP6XCNIhGwwmCpSekO2DChKs95Zyg59xPLy20i8g=;
 b=MC2l4PQff3KghuXeJYitF/wi7jGZyOdY792wWLtbRzzr3OANpPfd6UTlJGtv64Q1Ncmez5Nm3tS2UDxAhDl5HOX0+TIDgPMf0jTUII/TuIxJNeMEVexQlL3Gm8nOmTBTQWnBMaMKvx90Swg0DWplgfqlxegNzeWeFBfKjyAYa6nqAtyaccKMvyHvuMLRYgfy8cIeaH8wlu1fuuCWt0xiavPw/rlAJNJj6RHa3y+FqPc7BbOyqH4uqp9D3XibEtL9vaiezveMptnjCSM6NTLCsBbVpGiejbLCNM0IPbb0GynYvuWJoEoKUsg9T3PMDl34EtcXp9rcujS9a8VIgsXqxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pwLwP6XCNIhGwwmCpSekO2DChKs95Zyg59xPLy20i8g=;
 b=v4nDfGVUUoPci1MnOP4xcIc6Opz0ukx0pOmy4uWeVej5FommVdsgNfTlLHF0j66xoc0F5iih9Y1DuFK+Gvc4/as7wl/QfBXMbKrp4ouZd0WX0rJ1GCDn5ER7pHqiZ5ONhkOeLBVOXB4JO37m9cvW66CkrBIGN6edlMr95xnGymY=
Received: from BL1PR13CA0223.namprd13.prod.outlook.com (2603:10b6:208:2bf::18)
 by DM4PR12MB6256.namprd12.prod.outlook.com (2603:10b6:8:a3::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7611.19; Wed, 22 May 2024 06:31:02 +0000
Received: from BL6PEPF00020E64.namprd04.prod.outlook.com
 (2603:10b6:208:2bf:cafe::de) by BL1PR13CA0223.outlook.office365.com
 (2603:10b6:208:2bf::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.19 via Frontend
 Transport; Wed, 22 May 2024 06:31:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00020E64.mail.protection.outlook.com (10.167.249.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7611.14 via Frontend Transport; Wed, 22 May 2024 06:31:02 +0000
Received: from jenkins-mali-1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 22 May
 2024 01:30:58 -0500
From: Li Ma <li.ma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <yifan1.zhang@amd.com>, Basavaraj Natikar
 <Basavaraj.Natikar@amd.com>, Akshata MukundShetty
 <akshata.mukundshetty@amd.com>, Jiri Kosina <jkosina@suse.com>
Subject: [PATCH 2/6] HID: amd_sfh: Update HPD sensor structure elements
Date: Wed, 22 May 2024 14:29:13 +0800
Message-ID: <20240522062916.705147-2-li.ma@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240522062916.705147-1-li.ma@amd.com>
References: <20240522062916.705147-1-li.ma@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E64:EE_|DM4PR12MB6256:EE_
X-MS-Office365-Filtering-Correlation-Id: aa3657a3-4a8d-4873-9c97-08dc7a28c074
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|1800799015|82310400017|376005|36860700004; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?K+LOVWa2Hvw3UAB7FD6FKpvqnDtWvg9yhjuV+Du16i7WWLwPsOhq8wmozgQT?=
 =?us-ascii?Q?6skmGZXIersbPh5qF9h/YiTP/cAPEtSpXL9p8ABrtjmNUmy4bMuMenmJx4S8?=
 =?us-ascii?Q?FGvNooYahfi9up53oAdVbg7ie+8LAWxp/S75fJVIOvU4DBci+73h3TQxwUGa?=
 =?us-ascii?Q?X+vp38ZWTGa8JpGtM+EgBEPLTnikH++f8f5qjTfEo98d9ZUj1YDbPQhbeioG?=
 =?us-ascii?Q?l7EKNsu2uB1RfLM8ijVzVo12ipShv1A64QMSD3pYOFEGOnwtKbvxFU38smmX?=
 =?us-ascii?Q?2N6qqLoEeDS/yJemhdopW7wxscg286i1ZiYqEMW4Vz9WZZeeUYSa5eGYT3tA?=
 =?us-ascii?Q?yGtfZiVniUkKR/uGJBuuJw7gr31VRrylU3r6EkJi9o/Y3PRQkh5ovzgXnMjt?=
 =?us-ascii?Q?IbYiZ7gMsYq/AiOiBayTzVEtNvKtwCrlslTXACMBQ81/50kJlJ/rdQHWFYHy?=
 =?us-ascii?Q?NfJd603XgiRvyazeS134RPZLD5tdAmooCLZyjl1WJMWk8SNaoTC08qKd6lLQ?=
 =?us-ascii?Q?r+uyxeODL1bYcO7UgpgjyD7/mVtg92+8gnVjGitf+PkyB66G/BUulV7pCI3U?=
 =?us-ascii?Q?6zNbNW34KOxl1vdaF9M7epxpiMOUSr85B8tkQPShG7/ZtLb3FkHPX4byYgR5?=
 =?us-ascii?Q?5Rd7sx6FKR1VROhLm9xlyhAl52Q7S1b5Ajqx0h65+haTvsufmU4AaYJkFp9Z?=
 =?us-ascii?Q?Nop+tOos/jO/xvMm0OjqpMR6Y0rrelqEziOw5uwJ9w213wDB/WZHZc+a4WXS?=
 =?us-ascii?Q?NniuMPvtTIcNc2eU2YVBBvB9/TpqwLmAyntTdpCmC20zILTWtGRhds6v+sTZ?=
 =?us-ascii?Q?iFf8Z7GoO4yWhw/lyBPhWWZ3Qqge/D1r8fKQwKzRPDvbMzp6qLbsTGf/WZpM?=
 =?us-ascii?Q?5rH/GtKikmq1/7EFCMTA/BKk/4yFIeJPrRQXXEMmJK+tFnLit5jpOgJF+jbY?=
 =?us-ascii?Q?taWDcoa/UAhOuxP6d1zKxI/K741ttUrohM3n8A5dpTC9QvJu53TjBmL2kSmc?=
 =?us-ascii?Q?3pMzTH+UelR33r/xnO/1Lvpq5u+oY6nbROXIUjvfxyvZbNTKfpOUKemFXRfj?=
 =?us-ascii?Q?JztCAGgtWu0lEzjeeVHJctDBqerT1UcsMLVERBT1y6tGkNbFuFW9+L28YShi?=
 =?us-ascii?Q?dF4t/XOP4S/NT37QbsQncjQfPb4xo7Dt28mpQagYJaBQprRk5+wa275L0C+c?=
 =?us-ascii?Q?lZCe/4LlVu1qaZ8lLjt+ocrYxxzoMuRyorcjJd6N6MxwcBZ+RpH+vCNBavSM?=
 =?us-ascii?Q?GzwlpNSVLJUmGI+9ctCHm3yIpjfgENO2/LZu6fU6tEJpas2dpQmDDdYd6p36?=
 =?us-ascii?Q?Zq+g6bsa/R1uOnciHDdkdQ5UlsMSgiiiiDOLU3F/c7KnOlpzvdiyhIN5Wh4x?=
 =?us-ascii?Q?0ODMqoX68WJ2uZV67bpz4OX57kdx?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(82310400017)(376005)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2024 06:31:02.5134 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aa3657a3-4a8d-4873-9c97-08dc7a28c074
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E64.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6256
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

From: Basavaraj Natikar <Basavaraj.Natikar@amd.com>

HPD sensor data is not populating properly because of wrong order of HPD
sensor structure elements. So update the order of structure elements to
match the HPD sensor data received from the firmware.

Fixes: 24a31ea94922 ("HID: amd_sfh: Add initial support for HPD sensor")
Co-developed-by: Akshata MukundShetty <akshata.mukundshetty@amd.com>
Signed-off-by: Akshata MukundShetty <akshata.mukundshetty@amd.com>
Signed-off-by: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
Signed-off-by: Jiri Kosina <jkosina@suse.com>
(cherry picked from commit bbf0dec30696638b8bdc28cb2f5bf23f8d760b52)
---
 drivers/hid/amd-sfh-hid/amd_sfh_pcie.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/hid/amd-sfh-hid/amd_sfh_pcie.h b/drivers/hid/amd-sfh-hid/amd_sfh_pcie.h
index 70add75fc506..05e400a4a83e 100644
--- a/drivers/hid/amd-sfh-hid/amd_sfh_pcie.h
+++ b/drivers/hid/amd-sfh-hid/amd_sfh_pcie.h
@@ -90,10 +90,10 @@ enum mem_use_type {
 struct hpd_status {
 	union {
 		struct {
-			u32 human_presence_report : 4;
-			u32 human_presence_actual : 4;
-			u32 probablity		  : 8;
 			u32 object_distance       : 16;
+			u32 probablity		  : 8;
+			u32 human_presence_actual : 4;
+			u32 human_presence_report : 4;
 		} shpd;
 		u32 val;
 	};
-- 
2.25.1

