Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C110AC54E65
	for <amd-gfx@archiver.kernel.org>; Wed, 21 May 2025 20:24:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1E12910E73B;
	Wed, 21 May 2025 20:24:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="AP0MHI4g";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2073.outbound.protection.outlook.com [40.107.223.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8866B10E71C
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 May 2025 20:24:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Kc/QOxkltonD7ElQd9OCaQ0BKiacKtae5yavPKGY8CtMqCS0pXBEOjK3HUbbLq1HzbpYwuhADE3fy2RgxC3ketpQWneiyIaQddU/IfODdgQ6HgdwEbHvqq5nysZpxPV//JhTNmct0kaLdOpeF2ogsEjc3GWsMB0/1b0dHMGDUiYcHqHC+3nUvVj+YvfLH4TGlBBWTmZ8DSDTP+OpkbWRDQjEJTG8uMc71j+GGRU0uWJlOgmMesBJlTGlcIYM1e7piO6f2BbvY1pQp0PcL/e1mli0BPuqK0BAJHev3LIuVgu6lEbxs+7I3qroYG5pCGBQFiO6vzfof0eVgBkba/bYnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NIlRkYMawmoW5XOdt+zi/WPzQeY1LThz7u4FaBJitU8=;
 b=hmxIS+15/+urMcgnQ20Z/ZA7tpak6cW8KuUc+Akdxl7zXepnHKGwY6KJoAkPEklsg5/fCzwK5KeoxxRXz8Ae4/3HW8vJjTXfX8+oP3vI6V7+gwPaDEYkyPGZnjmgk+htPG3pRVW3gsr9tSNGkiYh9w5i9xq4Yz2Ktfkom8epx9QZ9WBcX7rjaiMWfbc+z3PAogXaZ2N2bPOmDfUEhzTggs7qw13xDjksP29p79dIVq9SeClcWavL7Jcr7WF99QviLS9jSoYg7LR5hq66ptpViSOegrlDXSCuCdrE0jqkTJR65ZRd5RTipZ6UMyxieynxI4UDVk2SfYoQqK4UbQ56KQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NIlRkYMawmoW5XOdt+zi/WPzQeY1LThz7u4FaBJitU8=;
 b=AP0MHI4g0v8W5pLqaOT5nMjF22GH4qWbBTgapJHCZXMLY13BpCS/7iwM7c4EbuRYSIKxfl++WkmtPayyhpBtKUdajvfZfauC8wwVSRq3XEOrvpfujIQ6CClub9vU0PNVGxIQ58eCeCRJnHzC/DcNAF5B4NsrE1f9dEoxRvxyXn8=
Received: from SA9PR03CA0028.namprd03.prod.outlook.com (2603:10b6:806:20::33)
 by DM3PR12MB9389.namprd12.prod.outlook.com (2603:10b6:0:46::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8699.35; Wed, 21 May 2025 20:24:29 +0000
Received: from SA2PEPF00003AEB.namprd02.prod.outlook.com
 (2603:10b6:806:20:cafe::b3) by SA9PR03CA0028.outlook.office365.com
 (2603:10b6:806:20::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.19 via Frontend Transport; Wed,
 21 May 2025 20:24:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00003AEB.mail.protection.outlook.com (10.167.248.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8769.18 via Frontend Transport; Wed, 21 May 2025 20:24:29 +0000
Received: from david-B650-PG-Lightning.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 21 May 2025 15:24:27 -0500
From: "David (Ming Qiang) Wu" <David.Wu3@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Christian.Koenig@amd.com>
CC: <alexander.deucher@amd.com>, <leo.liu@amd.com>, <sonny.jiang@amd.com>,
 <ruijing.dong@amd.com>
Subject: [PATCH v3 2/9] drm/amdgpu: read back register after written
Date: Wed, 21 May 2025 16:24:07 -0400
Message-ID: <20250521202414.18251-2-David.Wu3@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250521202414.18251-1-David.Wu3@amd.com>
References: <20250521202414.18251-1-David.Wu3@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AEB:EE_|DM3PR12MB9389:EE_
X-MS-Office365-Filtering-Correlation-Id: 519894bc-eefc-4252-9969-08dd98a57d02
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?VspciuvbQpGNQK28wEvo7xJ6VOUj2kHRg+54eTqzzzBIVfNDI7Z9wvodwdLb?=
 =?us-ascii?Q?Su5Nre0jtGVxT2E++XCb7VOJYWkziWPpEkKPg9mhdmZc1pr+D8d8zaInVSTY?=
 =?us-ascii?Q?Rdmy/bJiubZbRpoC//nQhzC7ugyl1xaIOvOsm04qGfJpFKppcV9eKewodJk/?=
 =?us-ascii?Q?S6Nqb0UfIyltr9PQEAQ+EWRfqejmxN3kBFDUuJ0U7Ftnqb29vRh3+E8LsbRS?=
 =?us-ascii?Q?sBH9o8aNETH1sWXAfJruS7HEoWJrzNE+7BXi9/RhKELFskKnWVut6I/itSn5?=
 =?us-ascii?Q?SVX4sbLW0tofkDhh4qP8CgXFLa7oyS/Xa1WsEEoSH5Wv1OGqDj5Oj4XM28sR?=
 =?us-ascii?Q?mx9F/pOD0aWnUWNQbtjtRLRB6IW4VJ3cghWMDz7+W3EOKF1BBUdb4m3LTqpT?=
 =?us-ascii?Q?h9KwplAl7eY+9biAR9DOMo6izftpwyT/V4kcdbQ4zAj7RPBO/a3RqL0KNktz?=
 =?us-ascii?Q?8EIWdfRPgZYzo2+8sHgepnwIIhymMpP0QVHlc21VRAnVs/UKPkpWAz5rkvts?=
 =?us-ascii?Q?jqdOuAKjX4Km8Nez1B59Embk0gABJPE7q0P4wtBu98MCJa/2QLKc75LnF9Ob?=
 =?us-ascii?Q?H5K+z01+A7+R8luWT3QPFYNptM6g4thG6ne8xhDYdKNeAo6GB1aC7SQkLALn?=
 =?us-ascii?Q?s+WzoL50iMaF6glVduYTzXL4QjOZWnmK0PTEe7QNMagaNvJT+Sm287sfOhOu?=
 =?us-ascii?Q?3sv0znW/rt1Xfqvu3t4uM+z865MXQ7sSW+KwjbDElxgUFCrvVwfylnERwENv?=
 =?us-ascii?Q?0o5IpfkSnohHn/qPbUzaRxrAS+MIT77DRsa8xAYmbxV4BLjF7yJ3kfkBYn2i?=
 =?us-ascii?Q?hsIB1Ot907q2oEHcnwbr+TxrfU/1KWBi/U/phATCWcMLkToOxefP0RbK8AAD?=
 =?us-ascii?Q?HHpSMU9JQ7tqWMdLNelQLPH1AzfJpiYivPTvpRbLSmYPhuUbVy+Z6QwOTxSG?=
 =?us-ascii?Q?wVnd/qrQa322IQbf2sH5xk14w0w/prejcMZRfOyxcJdnGC4XfOBwAzxjigtm?=
 =?us-ascii?Q?HF2N/gowaZOQqSyAnJruGsvaoPK8F0tifSpTD9Lm6CgeOmVRxqdiZ2c7Zbot?=
 =?us-ascii?Q?PU69waCTLipCVIJf6pAPJ/8qqAX0DtiZsnl9ePxjuw9R3oAhCqdeg97rvsxl?=
 =?us-ascii?Q?HK7VvEd2o5+r2ucbvUepKTgDuS9cZaCyFIB9znOOiYG1Mw2MpkuHfGfuvTu3?=
 =?us-ascii?Q?ANLQZ/CCJVQWmjJJWkN3PuMdckvDIBlNjrRR3UFHMQELuJWL0pzQdyB6MzjM?=
 =?us-ascii?Q?6fnBrymOloqQ3cqOgLDs2BvwESLCn/w4R6F3BWUQKJpjC3oezxmXcKnqoCMM?=
 =?us-ascii?Q?LlQSw7JskciZolM79aK/DwZyaUFDWBqEFyqu0fqQjweZwDrj5QgRzZEqSawz?=
 =?us-ascii?Q?4gDeAT+i44VRl+JL1l+AKCVKBEUwQTn2WTnlVJfh0aYJHLb6ylKOkDxVH3o3?=
 =?us-ascii?Q?uDHa5ymaASAGuEAFJDNfeNe8+R3Y9LfVc5898k++d7WHOj/Ojduj8wUvSDF4?=
 =?us-ascii?Q?TCjC0wKWG64aZl9wCfvtBeYf4ZAWcg+jwOny?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2025 20:24:29.0097 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 519894bc-eefc-4252-9969-08dd98a57d02
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003AEB.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9389
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

The addition of register read-back in VCN v2.0 is intended to prevent
potential race conditions.

Signed-off-by: David (Ming Qiang) Wu <David.Wu3@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
index b8d835c9e17ed..148b651be7ca7 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
@@ -978,6 +978,12 @@ static int vcn_v2_0_start_dpg_mode(struct amdgpu_vcn_inst *vinst, bool indirect)
 	/* Unstall DPG */
 	WREG32_P(SOC15_REG_OFFSET(UVD, 0, mmUVD_POWER_STATUS),
 		0, ~UVD_POWER_STATUS__STALL_DPG_POWER_UP_MASK);
+
+	/* Keeping one read-back to ensure all register writes are done,
+	 * otherwise it may introduce race conditions.
+	 */
+	RREG32_SOC15(UVD, 0, mmUVD_STATUS);
+
 	return 0;
 }
 
@@ -1152,6 +1158,11 @@ static int vcn_v2_0_start(struct amdgpu_vcn_inst *vinst)
 	WREG32_SOC15(UVD, 0, mmUVD_RB_SIZE2, ring->ring_size / 4);
 	fw_shared->multi_queue.encode_lowlatency_queue_mode &= ~FW_QUEUE_RING_RESET;
 
+	/* Keeping one read-back to ensure all register writes are done,
+	 * otherwise it may introduce race conditions.
+	 */
+	RREG32_SOC15(UVD, 0, mmUVD_STATUS);
+
 	return 0;
 }
 
@@ -1183,6 +1194,11 @@ static int vcn_v2_0_stop_dpg_mode(struct amdgpu_vcn_inst *vinst)
 	WREG32_P(SOC15_REG_OFFSET(UVD, 0, mmUVD_POWER_STATUS), 0,
 			~UVD_POWER_STATUS__UVD_PG_MODE_MASK);
 
+	/* Keeping one read-back to ensure all register writes are done,
+	 * otherwise it may introduce race conditions.
+	 */
+	RREG32_SOC15(UVD, 0, mmUVD_STATUS);
+
 	return 0;
 }
 
@@ -1248,6 +1264,11 @@ static int vcn_v2_0_stop(struct amdgpu_vcn_inst *vinst)
 	vcn_v2_0_enable_clock_gating(vinst);
 	vcn_v2_0_enable_static_power_gating(vinst);
 
+	/* Keeping one read-back to ensure all register writes are done,
+	 * otherwise it may introduce race conditions.
+	 */
+	RREG32_SOC15(VCN, 0, mmUVD_STATUS);
+
 power_off:
 	if (adev->pm.dpm_enabled)
 		amdgpu_dpm_enable_vcn(adev, false, 0);
-- 
2.34.1

