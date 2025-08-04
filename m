Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C433C87FCB
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Aug 2025 11:06:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DB68D10E1C0;
	Mon,  4 Aug 2025 11:06:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="u/Og0qLc";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2074.outbound.protection.outlook.com [40.107.237.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 68AD110E1C0
 for <amd-gfx@lists.freedesktop.org>; Mon,  4 Aug 2025 11:06:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iMFbc/kzBtICQz5LBIAvBC3qYO8P0fb2yJWowdbKa6EddjDgHI8SiCwgN1RkXvzu3t6R2o7Jkb/0iHaPxLn4d842Pgj9BvhMIHBMUNTIGJDeJwol49Wz5SfwaUbqz8rnyEBp9O7sSBck3zdU2vHJcFyxZ90yP3OO2a4zIzIX+0c1CnzTxv6QLfESaZJb6OcFGuzLlMTge56R32FgxnP5XlIVoh3EUJ8RPm+zGjJS14odX4BvAR5BE1rvFBYdGxMo2Ko8uqt1mrjosIk9b6MZBfdYpThU5SJP5aaiaOVF80XASeNLts+FgWm+Rd2k8Af5IjQntsi5epzgIlOn6gnv2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sQhh2JqPWxsoNmZKtcF/IOUozhFzWR7hWAKLwCjsMMI=;
 b=svEPxX/UjQhjNZ9pOxU0qSZfVHG+zzsrphMNJaSDUePQAz9iB7pSwwv7o8ydE0Hy5X/u0Oh5JqQ9Zi9eLe6jg8YH9qyEEZF1QpmU50Lk276NY3ZIABRX0tn52w9Pl+MeHW+a0mysFY6MlKbcwnBCMRil3qzVzCmj9cqQ8Z0dZcL/8/4qwc156234aV5j+nSFq4jQJycbAQDkgrdTRxge6J6lVzPdodgvF1YM7h6BJARQPseMTcWq6cWCBQMqFZ3kXtM6l85uvStTDkdbBUKKIvElFrxNxchouqfHX41BfT1HhhuNlK0oVk3EjnHjMEYc6WZbU+pomdg0DF7l89I6eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sQhh2JqPWxsoNmZKtcF/IOUozhFzWR7hWAKLwCjsMMI=;
 b=u/Og0qLclsNcF6XwH25pqeWxDRWNB11G82N+JLTAz2K6mQLrgmDdv2nQpajKRq+bRmEWKcdArrpegIuKulQBQRF12C0Iprjbs7YTIxZVf1jBWWD/NEK18+It8mZz+yb6hMEoBkEr4CbRP65gW6DqYV7qq4N3lpeOnOWIaHildJw=
Received: from BL1PR13CA0314.namprd13.prod.outlook.com (2603:10b6:208:2c1::19)
 by MW4PR12MB6827.namprd12.prod.outlook.com (2603:10b6:303:20b::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.19; Mon, 4 Aug
 2025 11:06:07 +0000
Received: from MN1PEPF0000ECDA.namprd02.prod.outlook.com
 (2603:10b6:208:2c1:cafe::a6) by BL1PR13CA0314.outlook.office365.com
 (2603:10b6:208:2c1::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9009.12 via Frontend Transport; Mon,
 4 Aug 2025 11:06:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECDA.mail.protection.outlook.com (10.167.242.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9009.8 via Frontend Transport; Mon, 4 Aug 2025 11:06:06 +0000
Received: from asad-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 4 Aug
 2025 06:06:04 -0500
From: Asad Kamal <asad.kamal@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <lijo.lazar@amd.com>
CC: <hawking.zhang@amd.com>, <le.ma@amd.com>, <shiwu.zhang@amd.com>,
 <alexander.deucher@amd.com>, <asad.kamal@amd.com>
Subject: [PATCH v2 6/6] drm/amd/pm: Enable temperature metrics caps
Date: Mon, 4 Aug 2025 19:05:39 +0800
Message-ID: <20250804110539.637463-6-asad.kamal@amd.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20250804110539.637463-1-asad.kamal@amd.com>
References: <20250804110539.637463-1-asad.kamal@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECDA:EE_|MW4PR12MB6827:EE_
X-MS-Office365-Filtering-Correlation-Id: 50c0cd5c-f0f6-405c-4365-08ddd346e8f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?2nf4/uBnvcW3ba/5O5JvXmt11NQ6KID8LGqO4dBKcNmL9ziCOpiRVNf4ILQY?=
 =?us-ascii?Q?HwldlDYpwIpmOpS9PxbaXfg/5GBP9GAJ9eVpwORGVIEe52TaT7XtunWsThz8?=
 =?us-ascii?Q?faN5GKJzUZpbWewTmZ7/Mc3Vtd7MtGJ8l55PMcZw2h7cXIpS7PZKtYZ8C5Go?=
 =?us-ascii?Q?wMh84U70eGZ6aNifIf6ZnOMzIdLxpwsXlc1MH2VBQduDrTXOoTk0OaV2AXVm?=
 =?us-ascii?Q?MfQOjWjofvoYEUlC2TliQCEGUaUs/1tp4BlVCS9T/nI51aqE9ANwxqFobTno?=
 =?us-ascii?Q?ELL1RY/QYqbc197VXGjUtpCZ7f3bG2yOpBL7Q2Y03rIew0C9+joMtpAtt9gq?=
 =?us-ascii?Q?/oNQSxOvWxmtWfjLtkFbE3XfY6YpIGPkUa0lNOxqg+DhmnwBbWZGrOh9Na2D?=
 =?us-ascii?Q?UnN88lNywM59hZUFNwY88c6U9N3BGlWVxVXpWk9pXwVKByI0rR7442d3srQG?=
 =?us-ascii?Q?9LTtvzOazPrZi3Tx48BsE/XXbebboVWEGHaFzAlm4WKNjZejUKdcrgq+G+IC?=
 =?us-ascii?Q?aPXX49RZs7a5g3Hv1HIAYa7yEzl1llCEC6ARkwQnIXKPMojWWkIWy6YObX4h?=
 =?us-ascii?Q?NOiW7Q2nJ7hhK7lr8NZKN+NbpZ7YQj5xb6se423gNurUu5dhJP5qTW176d4p?=
 =?us-ascii?Q?IgtCv0UBNobk4O0lHYxSe524Qm34WKkjfznqOWZXLY12SO0mTC+Q3HqbLc6Q?=
 =?us-ascii?Q?CpzAYOngLe86b2jQU3aP56+wP8OanS35YNykGOOa4lIcnDwSCL00K2b3Q0p8?=
 =?us-ascii?Q?5iiWQkwxZX3M7oKU2PrHG0gUtkz0+kPCTcZI1jzZ8lR55bTlDNUV6lNGmNaw?=
 =?us-ascii?Q?4xpybfYjpSJ7Q3Z0I5YumGG3JllvoVf6M+2kylXQ6cmB8cgILbEVpGUdj4jP?=
 =?us-ascii?Q?9VaOB8i7f/A/i00W2dAECwLCANCxyYzKI6ds5LKAB5KaLGeG66s85KscH94k?=
 =?us-ascii?Q?QkRlUyesuf0ZzpruySfomTnj4tcaVtrN583yDN3SeN3Sup/Eq+qFwl5pQoHK?=
 =?us-ascii?Q?QNJMxj/5VEFLO6MDfzpchGxo+FjLjKB7K6GaW2xeLReF9N+eGDBLk5FGvezk?=
 =?us-ascii?Q?6++b2NlX9/ff1ZlEDYNw4E7Z3DZ+2GhQsk1p5w2rxUEblhsV5khv7FLevK3q?=
 =?us-ascii?Q?aqx+ReotWmLNOTtxpQdoBbhmZoya6qNNI+X5VQedeNdmwhsQca02aOBSNvRK?=
 =?us-ascii?Q?hecs8aGa774sB6s1kaL+w7SSjFofN5Qj1h08f2FMsQdsFJ4qty6zbZv6Al4F?=
 =?us-ascii?Q?D9HhIhjOYSW8xSxDgOGFB7SlPZyarkaZg+Px3qFhfuDD65u7ORCJqo/Cpv0D?=
 =?us-ascii?Q?xpDWCRL8Zsf+TtYfYv9+IBWLX4ItjNUDmIya+Jq6S9+FdUA+2GxJe36u8Lpq?=
 =?us-ascii?Q?eMfPajnImPyHonnySYVjKYKkL27I2+z6R8X6zKVVwdpCsKbijBu7PW67Cwba?=
 =?us-ascii?Q?bbE6pSRnw+ehLxrZs9uzX52n7g09KNpjledR3laOxFQ/tL0jXdVTNp++EDeI?=
 =?us-ascii?Q?F0QypH3pZKKwLuTvQaTAC2kTzrts1U+6z29o?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2025 11:06:06.5859 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 50c0cd5c-f0f6-405c-4365-08ddd346e8f9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECDA.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6827
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

Enable temperature metrics caps for smu_v13_0_12

Signed-off-by: Asad Kamal <asad.kamal@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index c777c0e4ea11..d6b49d958938 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -350,6 +350,11 @@ static void smu_v13_0_12_init_caps(struct smu_context *smu)
 		smu_v13_0_6_cap_set(smu, SMU_CAP(BOARD_VOLTAGE));
 		smu_v13_0_6_cap_set(smu, SMU_CAP(PLDM_VERSION));
 	}
+
+	if (fw_ver >= 0x04560700) {
+		if (!amdgpu_sriov_vf(smu->adev))
+			smu_v13_0_6_cap_set(smu, SMU_CAP(TEMP_METRICS));
+	}
 }
 
 static void smu_v13_0_6_init_caps(struct smu_context *smu)
-- 
2.46.0

