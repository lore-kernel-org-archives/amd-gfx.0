Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA9C3CCD184
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Oct 2025 07:07:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5ACEB10E54E;
	Tue, 14 Oct 2025 07:07:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="riIcWcaF";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013019.outbound.protection.outlook.com
 [40.107.201.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6324A10E54E
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Oct 2025 07:07:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uYoTGErcWsY7qPUFlvvS4EwwinyQuF2FwvvwvcYtjCDVzzygfiuGsxMSqPL6xKQ4Y6LAgZTgXK4ka6JHIqfQcrNo5bG9dTp+7jOzRmImj9Iq6gWO1TvYMdICPF6RzGFd2haJLClwfYJWi4nAYA94RkbQDQjun7SkWv3lxN6sdlr5Ukl4kK5VG6aVdj0eZk2U90Ytn6wPUFlz2Ad6HUGcu7dpCvJ8KNuGyql8HG8uMNkeqRK9CRMzR+ovWwS4dtzGBj0v6glhIDk1NZDqVovgXOWtuQkUpoqUkzy4KhRzNtcHX4ipQ+wDlUk6SreVeek0WYfdrC8npp1lmKEhcsralw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t9mkdPqGw+E1Q7LSRkOJIqoQA3Iyd3NRXYQtas/p4j8=;
 b=yMAsaGQ0XcFQ27Anz27oXL7HWIDO8OoKy6oB9h3CLise/PvA7SPPE8vRJGETk0elqaSwh5eDYbF8f5OIMvzRj7BRzB6IfYInH2NUxo3c254/Qeuc1XFE7f0O/vHoWSAl3ARUmoi+9RLul9O+wvRQqy0xY9780+WiF8stDsyyibG/QXhb+sSYbpe3Oq4TGGCoPzS7TzGrFIIIzcPwF5k0PZ/fB27cJj9R33hSmrfDDXs9p8oxTR/YAb43ajyDSskbLzdB4NVLZb+kGsjlqi2ajDVG7gjuny1FPbz/wD/j76OYzrWETIGP7ida9+rmg7epHHb23J/2/NKqtFYFseWHZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t9mkdPqGw+E1Q7LSRkOJIqoQA3Iyd3NRXYQtas/p4j8=;
 b=riIcWcaFPm7hFML89pa3SarlJFVRnR+M4RUF/mn0dwN3uzH3RaD8nrPzqZu0VI02Rag2Vst7lZRkR2yKZIbYTfIU9ny7APoKMEy0qppQ+kygTEGjygMVEEcKKjH7mzecmqlrtBCBgqHMaukwQMRdfGj8DaCs888gLnV/ceVHsIY=
Received: from BLAPR05CA0008.namprd05.prod.outlook.com (2603:10b6:208:36e::11)
 by MW4PR12MB7467.namprd12.prod.outlook.com (2603:10b6:303:212::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.13; Tue, 14 Oct
 2025 07:07:38 +0000
Received: from BL6PEPF00020E63.namprd04.prod.outlook.com
 (2603:10b6:208:36e:cafe::8d) by BLAPR05CA0008.outlook.office365.com
 (2603:10b6:208:36e::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.9 via Frontend Transport; Tue,
 14 Oct 2025 07:07:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF00020E63.mail.protection.outlook.com (10.167.249.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.7 via Frontend Transport; Tue, 14 Oct 2025 07:07:36 +0000
Received: from amd-02.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 14 Oct
 2025 00:07:34 -0700
From: YiPeng Chai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Tao.Zhou1@amd.com>, <Candice.Li@amd.com>,
 <KevinYang.Wang@amd.com>, <Stanley.Yang@amd.com>, <Jinzhou.Su@amd.com>,
 YiPeng Chai <YiPeng.Chai@amd.com>, Tao Zhou <tao.zhou1@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: Enable ras module
Date: Tue, 14 Oct 2025 15:06:17 +0800
Message-ID: <20251014070617.698199-2-YiPeng.Chai@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251014070617.698199-1-YiPeng.Chai@amd.com>
References: <20251014070617.698199-1-YiPeng.Chai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E63:EE_|MW4PR12MB7467:EE_
X-MS-Office365-Filtering-Correlation-Id: 313cc63c-f5d5-4e70-ce5c-08de0af05af6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Oq+DiYGKsoJMKeQbUvQzTtIo68UqpYrhbQr57foRReU/RaCd5Y3S6SBlNOOg?=
 =?us-ascii?Q?FRYGEC7R6qlsHNgC45dqVARC3XY7RZKeGxRQZ3vvmCotExRHfLQnhjdjDCrm?=
 =?us-ascii?Q?qgb3+cIz3W+DPWeCivOz1esUbqryRVhqGZR6V+QfgHpWXrx8R7anDH48OP74?=
 =?us-ascii?Q?dCJeteTKOy2KBmniLyouOVZrX0UL+11wGVL5IbyOOUts38fB5QIFy//6gvoN?=
 =?us-ascii?Q?EZBdRAuUO4ysCiGWaerJM+AAjniM9MBxefMAUMsLGBoaUiCK+qPCePqhGOUd?=
 =?us-ascii?Q?qsGfhWvOWzOjBAGhwumKWRwqix8HomW0RKNdkAuS0tc0EM3Ey0eeolZ9/iWZ?=
 =?us-ascii?Q?xUu8Zj7nUSsKtW59uhb4u1VjhAQjKQTBzyk3lkNWYxZYZLpewPf/7/yVhNRc?=
 =?us-ascii?Q?JhZQompNuy02kV44l21fAHJua9WOJbpPgQXr0qtgOMhtPKYz0ZxO7I5on6We?=
 =?us-ascii?Q?SOlQs1t0Yr+5F/bHGDUIN/vYr9b7EcRXkbq5a/Gz7/A7ffzkBmhcouhimCwM?=
 =?us-ascii?Q?9dWK3uEw4OmH8PoKdcIPWKnS3Qy3maSbZrkoyoydzeL61tnMrT/Go4WzFjHU?=
 =?us-ascii?Q?HiiNC9ZuldZteLedGT2SQxWhxPWyEcARotbdJKr2A1ZTl68+/h+Yu1vYwbTl?=
 =?us-ascii?Q?ikFv57x1WH2Z+hj4VvSv9emQAGCaZcheUUfke8uCTJIMk2xIyZbgRvLQ/K+c?=
 =?us-ascii?Q?NmV1ywHy+O4FQmwAn14oVzCPYNcKsDckqxKkkiU1jHurEqYzH9X3GYti3G/C?=
 =?us-ascii?Q?dt6/kz4hjIKSq8krU79q24JZCpL+KQTWhbH4L+gwCZqZZRVnFKqC+GCFCPXB?=
 =?us-ascii?Q?CRkNZCC+Up9LNQIuiT2wX5AqFJGjwAd50gBFigIkw/31MaUqeiNRQkSvBpd1?=
 =?us-ascii?Q?zscL03X2uZPjK3RIh8s1nvE+oWLvX7UDSfqO0fwQMU9FEu/AwlLDSKjwzRVB?=
 =?us-ascii?Q?td1RvDUI9Aqz0JR1Z4zXz+9glLuPM0aK+muuF1zEpmvNrVrydvnOvz4wqEp1?=
 =?us-ascii?Q?tQg2JlcK1T77x7kd8MxXsRnCwKiWiskc0ctSNpgLf1MhcnlyA07ta6o3DXb6?=
 =?us-ascii?Q?PpgoOS/jFUGxRfijbRM39bZUed7QfQKTPXPS1zVZrazRbWFgoyZl1KGBtZjH?=
 =?us-ascii?Q?hZXE2qoxyX31FI/KF3sNSr70EMkvK6kIvZy/8Iy3Ctohbqu0162PAgloPTTS?=
 =?us-ascii?Q?ei2wkpNiau7Lilop9lCECXCSw7Cp318XCbz6aMjW7JnCzOIAYICB3GVkODVS?=
 =?us-ascii?Q?BLu4xdfUYwKBLdO9wx4ewdclfrG96E89NfbiS0w8rWEWLw/xQDMMTuPRmx2J?=
 =?us-ascii?Q?PHBoBUQ1bIAma7epmAfW81lHOEz9ROk/NTMrpvLFc69Op4qjGaPjb9lJnOl0?=
 =?us-ascii?Q?IRir6O6K2pQ+XCQ8lDU01fSpz6/2SQlPfCxRsyqlyBVJuaeFYL0k3y/g0Q9r?=
 =?us-ascii?Q?MVlF9xpNzUN4ZxygkntNbFpbZdDK1vOWnBU0mAxS46PsyNwn0QbxSsMKG/kK?=
 =?us-ascii?Q?CRN1ixhzb5c4BZn5c+L8sG1w0sGvhCgi7B3xi8t5OR2/rjoeVTlJsRTh8ros?=
 =?us-ascii?Q?A5lxWpLu+wBV0d3c/MQ=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2025 07:07:36.7311 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 313cc63c-f5d5-4e70-ce5c-08de0af05af6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E63.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7467
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

Enable ras module, disabled by default.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
Reviewed-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
index 3ae843d078d8..a59617126ac7 100644
--- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
+++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
@@ -346,6 +346,11 @@ static int amdgpu_ras_mgr_hw_init(struct amdgpu_ip_block *ip_block)
 
 	ras_mgr->ras_is_ready = true;
 
+	/* Currently only debug mode can enable the ras module
+	 */
+	if (adev->debug_enable_ras_aca)
+		amdgpu_enable_uniras(adev, true);
+
 	RAS_DEV_INFO(adev, "AMDGPU RAS Is Ready.\n");
 	return 0;
 }
-- 
2.34.1

