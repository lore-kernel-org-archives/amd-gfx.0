Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71006C54755
	for <amd-gfx@archiver.kernel.org>; Wed, 14 May 2025 17:23:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E460810E6BE;
	Wed, 14 May 2025 17:23:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vTBsQ3gy";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2054.outbound.protection.outlook.com [40.107.94.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C9D8710E6BE
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 May 2025 17:23:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ffv7r99YW+6fS4DerJREFEIISrpipKl3uiQvRMYxL/FwcdCXSPvRWSYGMJhpDfNjpDWohhpJY/lTqtWE/GPSAooEA80HrswKvRZWTP54qWzlrPmi8IduJbk9uyBfwyZQcMX4LqroCSl8GDNDiGluXCvFFFeTwJIJiVo1zjak96IYRYE/DQzAQDdULVJp9LnojhTGgOdIbqvGP8i+nHzkaMLfhxOiQ+0yBBZOzh7UbPMjjMQHIYWaN5IiPQCHgXMIq1zrR3C2ZHNSfm7f2dj4gaioJALv8R/dkeGPwUfWViAsDGZcXA/FkJOS2CM0FOftolprdc0h3ZHKA5snorsefA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lbQ2zDpgQXG7vCAXqmW9+6vBWp6O9Z8QgZ6p6gbreCk=;
 b=ud0ipoFtKAoYueKQqXGlGKY9y+RdztzR80gjaD0eAatrHGANnD6NNhI2rdXhSprrO2ReiXpHD32P0bBYAey6qAI0+zgfctLgSW/QYu1kUQMRLHzsh6vfHm1lnJDgTP2D2f4xjJmX0Pmrw9uaeInl+XjCezCuSW/E7mDylao96N+4tw2wAJz5B7eGDCtL3BQKFrdfu80hf2zSyjhlWqcrtukiaeTORFCY/jLY1ZGi6ASqrfOTfaS0II9kmhKfdHg4HJgVzgVumjKORRlRGqVJBOIR6b0jerajH5MyAscvojqyYFnN4Bgfre9VlSNdaiALB8J1neY4cSTClu4ykVXbZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lbQ2zDpgQXG7vCAXqmW9+6vBWp6O9Z8QgZ6p6gbreCk=;
 b=vTBsQ3gyPnZExJX5MHuHiuUrrFadpH/EnfofIuoyoOGJUYehR0n7pY8QyG6xSOHd3ca+Zwaq4S7hvRH3tJB/EG17bNCQFVthvlvqhx0NhMtzlrTCkK7iFvMXi0QDzNby42xkjUFomWC5vI++a0OdIc9DxQDrMJAkvuHvnUVERkA=
Received: from SJ0PR03CA0278.namprd03.prod.outlook.com (2603:10b6:a03:39e::13)
 by SJ2PR12MB8927.namprd12.prod.outlook.com (2603:10b6:a03:547::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.30; Wed, 14 May
 2025 17:23:10 +0000
Received: from SJ1PEPF00001CDC.namprd05.prod.outlook.com
 (2603:10b6:a03:39e:cafe::f5) by SJ0PR03CA0278.outlook.office365.com
 (2603:10b6:a03:39e::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8722.25 via Frontend Transport; Wed,
 14 May 2025 17:23:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CDC.mail.protection.outlook.com (10.167.242.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.18 via Frontend Transport; Wed, 14 May 2025 17:23:10 +0000
Received: from david-B650-PG-Lightning.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 14 May 2025 12:23:05 -0500
From: "David (Ming Qiang) Wu" <David.Wu3@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <alexander.deucher@amd.com>
CC: <Christian.Koenig@amd.com>, <leo.liu@amd.com>, <sonny.jiang@amd.com>,
 <ruijing.dong@amd.com>
Subject: [PATCH v1 6/8] drm/amdgpu: read back register after written
Date: Wed, 14 May 2025 13:22:49 -0400
Message-ID: <20250514172251.726484-7-David.Wu3@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250514172251.726484-1-David.Wu3@amd.com>
References: <20250514172251.726484-1-David.Wu3@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDC:EE_|SJ2PR12MB8927:EE_
X-MS-Office365-Filtering-Correlation-Id: cf8ab931-ac7e-4f04-fbcb-08dd930c0039
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?1R+23l41NjC3Zmj3vrLXToA9dK5zG2/aFBInJ9DyAtdjaSsCiW9Aurbm+Rhr?=
 =?us-ascii?Q?90L+faILXaddN97dBQYjLCpYJf43+/44T1Z2g0nVziooQ0qvEpRuyhf8Hioa?=
 =?us-ascii?Q?sC9p4UQuoA5PhYaCn7rHf7qZb69mrVMUlzDbPbs1XXwgSEXlPFC54rOFwE24?=
 =?us-ascii?Q?tt44rO6XEVFDr/oih1i1Am97TA/5vQbNxhsekdWtOPHUPeO4TrV/t4FkjZ41?=
 =?us-ascii?Q?7snP4XEzBbn3ksBQmdbf2Slt2JCPyytRUhC0n9FLXsV1kIZwguZLIch3xd/Y?=
 =?us-ascii?Q?0/9bmK7nd1Zbx4TsoryBxXUJqtJkDq6aQhp4cFRh9UBgviPD5tVAVIeF+MXM?=
 =?us-ascii?Q?teG1knPULEcLKdmDqV3wC+WSV6tf3Ri+0xHo3PyRZvzgHdnyrlY4pLnY42n8?=
 =?us-ascii?Q?NbIRmCJsjD26Si3wy0yFQLhKQpF0dmNDv3wxvcp2NQxeOqQkLj3kcFY+E4hu?=
 =?us-ascii?Q?fRfid0jYyxWIOK2+LRTSrbZRo25J9R/5DjRqT5IjArpQOxTyhyWHc/GSeKUz?=
 =?us-ascii?Q?Rt2Ee8TvyFiUpjGr+U4h31lnmdV5aF64x9cUXh69qTSE+TtElNElxsqkIRZI?=
 =?us-ascii?Q?w8K9be/IP0Bq1sW9w9RcW3hI5iZIjwo1/CSpVR7vAd6eeje+7UJAigvioOB5?=
 =?us-ascii?Q?Bie2Ia9wXZPfyl1EmPCeYXtCU19byCkvu3bt8Y/bPwLIiDWCvP7Q0xqmm3Rj?=
 =?us-ascii?Q?5YXfqW6Xc9OkAkgT7imOsEXJxywsxIXfJ4sSc5zH97bsHIcTsJaEg70KvN91?=
 =?us-ascii?Q?4GptW+MnXEAuea3Wb6gmAxwV7bdpiarh0tEhqEqaKtZub79HIjCCFE3tMzkx?=
 =?us-ascii?Q?3MlEbNv1/d1e/F+/Qr5UbGLMxSZXj669+NFHfPZE34zLJbEFNl+zLkJRHUau?=
 =?us-ascii?Q?7X8eCyVc4Nq6gZKtsbHUTgmFo3cb2qR3kksqSgvzE8mp4aT2h6HqgzuETkFL?=
 =?us-ascii?Q?nPdVpVLmuiERtJRztmr4glvrpeoQxsPHyYgb+VGJ6yIsuVy63aEr5b+Uo0J0?=
 =?us-ascii?Q?Blh+jq3mc8NRzoRbRP9ty3CoO+Htv+Pk/X2uSbNL8ZEnu3KTEnGYB9a+7okk?=
 =?us-ascii?Q?KdwmTt3dCTgn6XWvjuN+i2JYP49U7k5eBeYHD/B6A2xdutO++iqCYhqaQmnQ?=
 =?us-ascii?Q?U2psv0km9chDoQo3XOE/o8+A7mdhBwXzcXF6q802gaolYDB+pA707l7Cmrwr?=
 =?us-ascii?Q?LYwv8mOPfQB74JNJz+69x3rNUdOa8ts+yM7kFOKXT5oc6GORB/7YybnkFe62?=
 =?us-ascii?Q?PPCvxeHndBPyASoTW/s0KRr3BKaUVEIjlieC5HRTSPcwsk1avIn/RIO7xX90?=
 =?us-ascii?Q?e4qeuCNbP/pAJYL7KRCh4soSJBasnG80zGTGGI02adfDoHvfQ6W8pRM9LE/N?=
 =?us-ascii?Q?k3wXEbRNXiIHEkB4PNnVxLcUr7Ka7o5QVO/bJFh3NwDRnSR3iiosOxGEOMxy?=
 =?us-ascii?Q?M17pC6Jx/2lgOzYDEGW+ZZEwxm81BebVOx1UG/Ldyiwn35fuFdsKIckwmCYK?=
 =?us-ascii?Q?eWdcCcy9bu0wSvnEoPMGld27V4aIGxJvGCna?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2025 17:23:10.7909 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cf8ab931-ac7e-4f04-fbcb-08dd930c0039
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CDC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8927
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

The addition of register read-back in VCN v4.0.3 is intended to prevent
potential race conditions.

Signed-off-by: David (Ming Qiang) Wu <David.Wu3@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
index 712e1fba33ce..9729eb1fbc6c 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
@@ -970,6 +970,10 @@ static int vcn_v4_0_3_start_dpg_mode(struct amdgpu_vcn_inst *vinst,
 	/*resetting done, fw can check RB ring */
 	fw_shared->sq.queue_mode &= cpu_to_le32(~FW_QUEUE_RING_RESET);
 
+	/* Keeping one read-back to ensure all register writes are done, otherwise
+	 * it may introduce race conditions.
+	 */
+	RREG32_SOC15(VCN, vcn_inst, regVCN_RB_ENABLE);
 	return 0;
 }
 
-- 
2.49.0

