Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E32C3C54FB3
	for <amd-gfx@archiver.kernel.org>; Mon, 26 May 2025 15:12:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 64EDB10E320;
	Mon, 26 May 2025 15:12:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="e7eQXGVI";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2041.outbound.protection.outlook.com [40.107.95.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E356210E3C9
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 May 2025 15:12:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C/aWRLgfyoEhI/RsNxjm0ktIjRbqAQ/aqcxRyq4YLftx/b+HxNH35y6H7PJ3zZfkCulBzN0EGx3SoP9Vz/xxtrj5O+Z9IpAbwoW8Njtfeo1y7MtRuPDDRcOYa5M6ijfK+0r17CzzxSMMRDvV3TVim1j2vBVn/ETlPSHGtCj1AYU1+i1iAMijb3IpioDjaK9+jyQ7huDvgg+L9oIlWnAAXIoCJZe5HB3LZgJOx4JQdrwx5r+jKTJtSdyMdQvcpoP8L3ykYAOhrb+Zu/VRt37jZVYEvSuQbW3+5ECunwT9SRT5rKii/QWDT/LM3u4OusJSSY8JW0qwhNffJGfW6CzO8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sEOYtdxWE6VmNIY5zifYwbKgJE3hZRJdXH7p1qjnvOs=;
 b=fw8kgF9/17pVRYuWq+oyo2bymF1W9EonTDJ7H3eqIWkI365qaXmCZqLIEdqWXcdeqSE/fXOPKPW+K3F50pox6pCSIFVI4nNGjF0IHmVzLsPGQu6mWrPm37eVIbY35U1PBXuHf3KL6GGx1J4OhfYD1/Emn1XRDpJFLrB2vmErkmHS7dfMjSba+RBlECadXQLF+HZeY63WeCzAaVtXpU/uHY9Dgqf98SwlrXivc+6OjdQnU6alT0SAp970Bqar0Ry5E0dzei0RDhTXZXbmzK7qitAUOn5oHr+0xeeqoDUzo4nYShVXig4EIaMPGG9ylIKI/I94pUzGrn/tp7NE9XFUAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sEOYtdxWE6VmNIY5zifYwbKgJE3hZRJdXH7p1qjnvOs=;
 b=e7eQXGVIA26tuHCdOMiBTs5eAMUql8TE6/WB4L5+t9wyTG4gVVAhkw1k79HSJ0N9yB7z5eCvxDy/cD94KSmH3v/2Uzuz8Le3WnwVNsAURUsVmr7D5OMxawxvVZCdB/ppXCDHnRdxN7iP8YZwGFrN87zYyhIjde0ysE8hbqfG/I0=
Received: from DM6PR02CA0053.namprd02.prod.outlook.com (2603:10b6:5:177::30)
 by IA1PR12MB7662.namprd12.prod.outlook.com (2603:10b6:208:425::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.21; Mon, 26 May
 2025 15:12:46 +0000
Received: from DS3PEPF000099E2.namprd04.prod.outlook.com
 (2603:10b6:5:177:cafe::a6) by DM6PR02CA0053.outlook.office365.com
 (2603:10b6:5:177::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.18 via Frontend Transport; Mon,
 26 May 2025 15:12:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099E2.mail.protection.outlook.com (10.167.17.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8769.18 via Frontend Transport; Mon, 26 May 2025 15:12:45 +0000
Received: from asad-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 26 May
 2025 10:12:43 -0500
From: Asad Kamal <asad.kamal@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <lijo.lazar@amd.com>
CC: <hawking.zhang@amd.com>, <le.ma@amd.com>, <shiwu.zhang@amd.com>,
 <asad.kamal@amd.com>, <alexander.deucher@amd.com>
Subject: [PATCH 1/2] drm/amd/pm: Enable static metrics table support
Date: Mon, 26 May 2025 23:12:29 +0800
Message-ID: <20250526151230.732802-1-asad.kamal@amd.com>
X-Mailer: git-send-email 2.46.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099E2:EE_|IA1PR12MB7662:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ba1282a-866b-45e2-61ed-08dd9c67c533
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?9A0CGXRrT3tEnKhZDdLGIfnH5pZmbgnlTobC4GgnCLw+vLyTd8EmB8vQdU2i?=
 =?us-ascii?Q?HVIaJmIqMaB7vF6D0THS0/zLTyI0SNKC0poa8ZOu2cQhhAy6DYFUUlX5839s?=
 =?us-ascii?Q?8bvTHrYQDJ+MBAxcY2191wm2MCzE97ddJKTdvceQYVCYZvsvWdWEpbIYgWuH?=
 =?us-ascii?Q?sbb7jvBm1lchNzSQD4gI5BgSM8UDg3yLH4d/ByqOjr7H6xvldRPkH0Qp4irr?=
 =?us-ascii?Q?IvtEWqwx54jah1N8QqOuQ+XqQYtAp6D+wXKbvKtZc/8ak3rAvtXbBqWMhYbX?=
 =?us-ascii?Q?WVh1jkG6h/+7Jtv6Y1OqDCbcksiRyUHw9XFz4rcls3/1X+3wpez9+CoVMzFM?=
 =?us-ascii?Q?FLQRIZuRjPK8lEIcql7CX40Xi84zKmTSvXAK3EZsJsgxQ2MGrJOTpL8bpzvk?=
 =?us-ascii?Q?vzAupcVqwDyh7Lv3ROrFf39P3bRClfFok96+2jR6F53j5LTjlKwZMkC6Lh1a?=
 =?us-ascii?Q?DBHSDWoiu9IDVPZ1FE7qdcTZ+m+XB9Ytv7Axz5Wf6qTDVHH2RTPJylvCIAhV?=
 =?us-ascii?Q?lE0nXCSeTphOKiRuEwMp168v6ztd0s3F1kMabofmyOvHZdgM200V5bjuRBx/?=
 =?us-ascii?Q?FswXNkDHo6MQX6Q5ymwL4iZRCx5UYKalPLMAhqrwavlXYTzpdA9gQ5vZ6Xbd?=
 =?us-ascii?Q?Eg+q+nB93GL46H+J9CLpoKnYy/CQwvVI7Hjh/ZVMOEjKsOVOuobYhzqtrOfx?=
 =?us-ascii?Q?XUnPMaAl21fQTzgWd0HYcZu9Ly8EmXqBMRsQwykYRUKCu95Lr4+2+1V+xCdU?=
 =?us-ascii?Q?yMqdh5rxfwGYqNYqFVuJllF5bWeEfD44k0CdvBxBbmzrHprUQRIALmghHy7R?=
 =?us-ascii?Q?rjxPnIrxlCUfP5kKN17twQsCW4OvDT2k7tlXgZQnenIouvbPQ/KaJGwWP1kA?=
 =?us-ascii?Q?VJPp28MAMvYT/aI7QnMgubX/7ud8LFkqEJ3CzyVMSUy8QVyMHvXPEzqrF87i?=
 =?us-ascii?Q?9ZyPHZr6RfVPZw/tn21VZZ9tQMMWuwdPxEirrO6sEDGI3dHLTeS66rY2KXsF?=
 =?us-ascii?Q?+OuW4aAsP/qqJbaTM6fvKYwokX1zT4KRr9MBhsBI2j5FlwPfS4hgFoxxfay7?=
 =?us-ascii?Q?HP0YJXdPBBXqRcB8wohurfkpit4ube7/7eK0ixODUS8RcVzRiOyomBN/I8Wm?=
 =?us-ascii?Q?l5tvLZAB9N0BsMwVGPs866qkSzGcWt+eWjjvrKKgwx0zQSrNIlVOvfBP1fKy?=
 =?us-ascii?Q?cYFvPiiQZF5VPIhtOfj9QnVV+RsnTF+Khx6z+lDCOyCae3LMKaiZbrSrbqDr?=
 =?us-ascii?Q?DkXN+vrwDp+ZFNHKDBBAITVGA7ufpYNYlUOiTGf17wK5PvOIcIwVJn4QlzU0?=
 =?us-ascii?Q?BjXnU4B7M4Pk61l49pkbNeb4Sx/866JrIuRGp2F6qz7Likqa2MQGyAYsFNEc?=
 =?us-ascii?Q?/rVTWljGJ5SQAgTqlOHCYh90MlXOsZl0niQoSOlprTUQJ1/3UG+V00IY8056?=
 =?us-ascii?Q?xK++uzO9qBqWH+8pnDXxH8u0TKRoBrKHQ0bYKq2tuhxlAdXyUSD8IsW6mip1?=
 =?us-ascii?Q?yZ6nG7ReIEQPPx6/mSgNmJOdh+5wJg7q8CM7?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2025 15:12:45.9720 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ba1282a-866b-45e2-61ed-08dd9c67c533
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099E2.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7662
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

Enable static metrics support to fetch board voltage and pldm version
for other smu_v13_0_6 program

Signed-off-by: Asad Kamal <asad.kamal@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 271458b74f2d..2651c8c41ad7 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -392,11 +392,13 @@ static void smu_v13_0_6_init_caps(struct smu_context *smu)
 		if ((pgm == 7 && fw_ver >= 0x7550E00) ||
 		    (pgm == 0 && fw_ver >= 0x00557E00))
 			smu_v13_0_6_cap_set(smu, SMU_CAP(HST_LIMIT_METRICS));
-		if (fw_ver >= 0x00557F01) {
+		if ((pgm == 0 && fw_ver >= 0x00557F01) ||
+		    (pgm == 7 && fw_ver >= 0x7551000)) {
 			smu_v13_0_6_cap_set(smu, SMU_CAP(STATIC_METRICS));
 			smu_v13_0_6_cap_set(smu, SMU_CAP(BOARD_VOLTAGE));
 		}
-		if (fw_ver >= 0x00558000)
+		if ((pgm == 0 && fw_ver >= 0x00558000) ||
+		    (pgm == 7 && fw_ver >= 0x7551000))
 			smu_v13_0_6_cap_set(smu, SMU_CAP(PLDM_VERSION));
 	}
 	if (((pgm == 7) && (fw_ver >= 0x7550700)) ||
-- 
2.46.0

