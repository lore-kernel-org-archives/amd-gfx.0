Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2A8ECA0EF5
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Aug 2025 02:08:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 12CF310E0CA;
	Tue, 19 Aug 2025 02:08:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xUmGGBYG";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2047.outbound.protection.outlook.com [40.107.237.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 247E710E087
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Aug 2025 02:08:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YedwkROVIDUES28D6yTprgzL01ozjlFu1D4xcKjXmHSmw89tf9SbDjZXdnOg78ngm36mETSjASggx2CSWcY5Xfyc9RgHVSloDUZrpD+UQ16ifCsFjmQr7IECiy2bMzK2JyrPtoG6bFmkcvZYu0ZlhEBlB/qTccWhCsn26KV+TML8s+VDuNlMDLVaQwFvveG1Lv3kAknqEKRN41AbB7jgLZDG2a0Ewiss/Lt1C2mankz9Qhdp8J/Y9jmIlrGmt1RJuK5h0h2OpcHtikfjOpbPcR5mwerbJHRbU09SAc7fDVE22799M5ET1nlY2roTz1MXNplp4CC5GElkBk35Qebjzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ORLYP3rgBWz9vGnSMEP65cKnb2buxPhE8Dk03DEqOBU=;
 b=dMFdG66jpUgpd8H8yOsqQFpHZ5m4PRrBGxxt+Ko8VFeQgJJBzIKU550Xj0Yg4Odtn53KoqqP+gSss8WFPa1wF3F5+PSEQvK3YiXMyrXyyIXG3CtkeHzCtw7kKqDsLdSmLJAw3/Jxd6qed/I9LZ8+wXl161CVzN4dVJxqQdR5duW5B1pj3oRdlY5HDwglKe6+g8rJHg4zpo/ektGYXGZJNiMK7B3meZhESG8GxhRhKQKPLKP/my9JoGdMyag4jDAcGoFfLhvzP5tRl/4tGm29K0dyl0eN0wtk4tCUsXT1/h+ANGtBd3VzAPFJ4ofM7hTXcF/4PBpVh8yp3rA2Mn4cUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ORLYP3rgBWz9vGnSMEP65cKnb2buxPhE8Dk03DEqOBU=;
 b=xUmGGBYGraEm807AjtC42KnpKN2N6IivEhN5dHe/F1MiLz6fA7mvAYWv2gI9vK8cIk26zvS02Xtv6bF/53pAL0AXtzYnp1cA6XWWRY2Qtg+obx1y2rj77xDXfw6tfGReqx/AD/KV5Zlkvp5Je1Y/gaOH05BmR9ECXyI2geL/g3w=
Received: from CH2PR20CA0004.namprd20.prod.outlook.com (2603:10b6:610:58::14)
 by DS0PR12MB7851.namprd12.prod.outlook.com (2603:10b6:8:14a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Tue, 19 Aug
 2025 02:08:16 +0000
Received: from CH2PEPF0000009E.namprd02.prod.outlook.com
 (2603:10b6:610:58:cafe::b8) by CH2PR20CA0004.outlook.office365.com
 (2603:10b6:610:58::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.22 via Frontend Transport; Tue,
 19 Aug 2025 02:08:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF0000009E.mail.protection.outlook.com (10.167.244.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Tue, 19 Aug 2025 02:08:16 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 18 Aug
 2025 21:08:16 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Mon, 18 Aug
 2025 19:08:15 -0700
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Mon, 18 Aug 2025 21:08:13 -0500
From: Jesse.Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <lijo.lazar@amd.com>, <leo.liu@amd.com>, <sonny.jiang@amd.com>, Jesse.Zhang
 <Jesse.Zhang@amd.com>
Subject: [PATCH] drm/amd/pm: Update SMU v13.0.6 caps initialization
Date: Tue, 19 Aug 2025 10:08:05 +0800
Message-ID: <20250819020813.3998652-1-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009E:EE_|DS0PR12MB7851:EE_
X-MS-Office365-Filtering-Correlation-Id: c8aeef80-1f28-4391-b7de-08dddec542a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?GR0J43lnmF8Wn5H9cS6eo1SVixdmn+Mr3MH2+88ME7oVHg0ZvLVfDivw8CGV?=
 =?us-ascii?Q?9VwGMB09GnUYL+yfgMWTocf5aKWsqXasbVBnhHMWbS4jgrtyRUei9vn8xT+m?=
 =?us-ascii?Q?bn3imqKNMH/5PGT6zmFUUTWYWIkZ1KQs6Jr91LLVa1p07N91g+M2t7whSiLn?=
 =?us-ascii?Q?qofaR3EiEcPhBtkDH9EhESHj6+60M63nxn9UbG+RLvLpKmBKKcprkfpainhy?=
 =?us-ascii?Q?HZTpMTHh+NdoN8+TOkEoioNnJ5SpOxssCfNiDctM8j7D1RHEivhYX2pjMoqr?=
 =?us-ascii?Q?FhpU4N3VgVXcs9MrCwQ1EfNMEN/YfRFd55Ae7ALt906d4+HhRBYreaZuRSM3?=
 =?us-ascii?Q?SjjXnia5c7a3xDKFVMN8SMACV4NOUA1blrkU/bZUrhrQl7y1lkAFLmjTasqy?=
 =?us-ascii?Q?/5hhQOAgLg5hlbwj65ExgRSJd7uZMC/GONZEiFx6T/Ruv4pwPAbyGRA42+fH?=
 =?us-ascii?Q?jO3xpOu/aMHZT4FvL9Z6qlkKNnTE/Ea1DVfoJGc0F31/S3bSLpFGaTuKC2hv?=
 =?us-ascii?Q?4eu7adLvctodXE1RTyyLvAl3ZmCT1vIsrOlAz9/Z6VRKYxqSs758G9pd2CWc?=
 =?us-ascii?Q?bcVfPhhgpTzNVdLXRfrT+IkkwjLqGVDrH2XFmIFS7xH7XEGq05AACh5u6IwO?=
 =?us-ascii?Q?YP+HgFo9xnbmZZRgp3r0SqPE5dagsneDHIbTlQ9wertbKsFUYdRGOd/131dx?=
 =?us-ascii?Q?czKCkJu291hmRn9ldswoxnOrsgGS+dSaoTVYck091LFEx/tlxf3yMFyucf3Z?=
 =?us-ascii?Q?GAUd9KABSqjs8KajZTIed9Sz/Xk7/4pkgr8T+53mN/EQvr72AEaEzewankAp?=
 =?us-ascii?Q?uJlDGhSsfBrFPl4MNe7QNG68BbFlDcj1QrqsiEXY75LT9+6fh+cWBhiYxxrA?=
 =?us-ascii?Q?69CsWoQi5atpG9StQurxAxmuUxKhCJXjwND8n22rhPnobpt6ovRA3OjB7Ere?=
 =?us-ascii?Q?IjboQiZs2KYbO1wlBuPxornNIXXgakdsr7/+sxU32tIi3/0c2SFZ8DnrHcNi?=
 =?us-ascii?Q?x4AdEC7IHbWxTE6M5Uoo/Usyn8CPfwRS1IpQ1kaafb+lp6AuQLxeENaP/I1I?=
 =?us-ascii?Q?Hv7v6lGltiedumCGsCAIzmqQM2ZViZ241BgOBUsab/Uf4tSauUpi1WKLIdTZ?=
 =?us-ascii?Q?4Y5lJxUKkrDWCJ/c5PJfdNrcdBINFw/BKCstcgYkqrQb89V88pDz0d2TrHyw?=
 =?us-ascii?Q?TkeD44VKSN5s3fZ2BL7ukLWkXAggF0OyKtHHFagMSykPy5lN3gmF+dlTGPxp?=
 =?us-ascii?Q?oC5mFyESzcyvQuFO5kkHYhPQvo2/KG5qWa3y4fy1UZAz5Oye1/T825yHNGQG?=
 =?us-ascii?Q?G8bm0ia/vcPk1Cdr9bxMmclJffEloVSeAkGvUWUUHzRnXx5J58VKVGOcjlPc?=
 =?us-ascii?Q?MPhx3eii5BYa/vokapwHlWGmBX533CE4sJA+CoHjav19N90ij9tEQW1h4L2B?=
 =?us-ascii?Q?AuBNaR6Batw5NKO5uiDm5j1AeYIkUU7WoefLVE/IbT+wRRn1WT2abUCy2GLq?=
 =?us-ascii?Q?zt035AiU23K8LYwvsRs+sMYiDam38IryVh9J?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2025 02:08:16.3893 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c8aeef80-1f28-4391-b7de-08dddec542a3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000009E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7851
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

Update the conditions for setting the SMU vcn reset caps in the SMU v13.0.6 initialization function. Specifically:

- Add support for VCN reset capability for firmware versions 0x00558200 and
  above when the program version is 0.
- Add support for VCN reset capability for firmware versions 0x05551800 and
  above when the program version is 5.

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 3484fce0d41a..c502e19bcc97 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -440,7 +440,9 @@ static void smu_v13_0_6_init_caps(struct smu_context *smu)
 	    ((pgm == 4) && (fw_ver >= 0x4557000)))
 		smu_v13_0_6_cap_set(smu, SMU_CAP(SDMA_RESET));
 
-	if ((pgm == 4) && (fw_ver >= 0x04557100))
+	if (((pgm == 0) && (fw_ver >= 0x00558200)) ||
+	    ((pgm == 4) && (fw_ver >= 0x04557100)) ||
+	    ((pgm == 5) && (fw_ver >= 0x05551800)))
 		smu_v13_0_6_cap_set(smu, SMU_CAP(VCN_RESET));
 }
 
-- 
2.49.0

