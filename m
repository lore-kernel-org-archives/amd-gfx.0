Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E823C3DA7F
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Aug 2024 20:34:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3B7AF10E5E3;
	Wed,  7 Aug 2024 20:34:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="P0+HyFiJ";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2068.outbound.protection.outlook.com [40.107.94.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 24B8510E5E3
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Aug 2024 20:34:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bO66vUzWaJNlpyRovG9iTmyEertUxJJTrdhvYA/bKqYC9nHmfUK4nnR4doebMwtLUwCWCOnSMl78b1PILDL6tCNnHaqfmVvUc1rj+H5ltxcYxsmgijcahjRN7BByWac6YrElFT5jNFE4PZgFKxzbs8uFYn6OIOsngnA78O7Tkhj0Qkb9Df4nqPVz0mwbzb7sia7eVW3GNP1uLdVM/4ANqMiKf4NRQonJ/jppsGOmj4I4gFAh5HO8Y70/Ex3ckWZSAq+xlkmpp71ZsJSx0SlQ0u5XJxDTAMmZQwquy9/b+l7o4FQ+gEmW+FyaifV5eFPCxvoqNQy4G0BBhH1EDCUIQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CnfqhyxyxmNLRpx8Mi7CFhqmMYNmgPI5BEgOJRjz6jQ=;
 b=ci8ieL7q2Rd1LHnK8PnOw3CucWlr3q3JbJxot+MOTz82h5wtXagInU/Hb0qYR4sw5GXA2qLlpmDBWPZuMiGK2BX5vWBKQ+YJ4Q37BbTaaw1Fhl58vAivpvt2SoNt5JeWAGx3GYgG6Vm97LGQzWMXthRqHADupW00D591RS1eCq5ZdkBp8DLx12ILXlvTa8j5tRozR7dSowbMYAc5kaTjK+pfsSe9H+6RXPOdLh0qO/ebRN0w65KyFh1fkInbp3PsTl+wyMlGUxSLPOirOWOXs2cXxn/0MjDakDv3WIdnRM6edQs+8Pwt04apj/S8H8lQecEpmOVF71fhBYb+EZUmxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CnfqhyxyxmNLRpx8Mi7CFhqmMYNmgPI5BEgOJRjz6jQ=;
 b=P0+HyFiJnRuvgXUepxz79qdfieCxhU3VPtI9YeNSqrDyX4wUOkExiAqKIpjkca71BcVOetqNPXQRMelxcwhOhRljiBN2SZ6XNLvtkeIfStD3mXl8mN7pR59sGS1VvdeKGA6yJ2wEEe9ZbkNiSxUKC6Lz5tHGWmRrfNk4gTQQulM=
Received: from MW4PR03CA0199.namprd03.prod.outlook.com (2603:10b6:303:b8::24)
 by SA3PR12MB7831.namprd12.prod.outlook.com (2603:10b6:806:311::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.28; Wed, 7 Aug
 2024 20:34:49 +0000
Received: from MWH0EPF000989EA.namprd02.prod.outlook.com
 (2603:10b6:303:b8:cafe::72) by MW4PR03CA0199.outlook.office365.com
 (2603:10b6:303:b8::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.30 via Frontend
 Transport; Wed, 7 Aug 2024 20:34:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989EA.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7849.8 via Frontend Transport; Wed, 7 Aug 2024 20:34:48 +0000
Received: from jonathan-KFD.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 7 Aug
 2024 15:34:47 -0500
From: Jonathan Kim <Jonathan.Kim@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.Kuehling@amd.com>, Jonathan Kim <Jonathan.Kim@amd.com>, "Jonathan
 Kim" <jonathan.kim@amd.com>
Subject: [PATCH] drm/amdkfd: fix partition query when setting up recommended
 sdma engines
Date: Wed, 7 Aug 2024 16:34:40 -0400
Message-ID: <20240807203440.1875832-1-Jonathan.Kim@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989EA:EE_|SA3PR12MB7831:EE_
X-MS-Office365-Filtering-Correlation-Id: 85f843c3-9725-4dc7-7857-08dcb72061bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?gfX7vSgKFzZhE9PGzQ99Nc/Cuq40JmkSsFk37G6rgn7p9N5pbey8r3yvJLhy?=
 =?us-ascii?Q?kzHQ4wAlHeIk6OHRRZ8OFocN7WA5g3VdclMjf/VQGHKkUwPJUNu+wDevLN8W?=
 =?us-ascii?Q?efw24TO6CH5mLGfHrKmSsqSGg17cNgtKhbhU6DFCeeBMb/kL1CoGH8t3pSn0?=
 =?us-ascii?Q?JyHD3V2Br8S19ViOdT2/+6CUy6+KS5htoKbvgm+FSrgEXIKO3Xpii9EEvokK?=
 =?us-ascii?Q?H9WH/Q5kQTbIYteCl1kPehdvEOzTxheVRIEaBGUkstefQ1Aa8rnCVl/Do+cC?=
 =?us-ascii?Q?gfH2tSUW65n/ZyvnQW5SZRkKvYvEgHKTw57o9vC0c8gFE4mtbUu0ekx7H55x?=
 =?us-ascii?Q?n2Pkg5aA4K7SO3iTbrzyks3kT5x0kdXqIEQw6eieYXLwmEHN7QpRDZoiE7Jt?=
 =?us-ascii?Q?XBOr8y0nAX7sKO1MsMW5AsHbLH90GPGFKMMsfEBKOMQgOJ3UM0LVtDNHklHS?=
 =?us-ascii?Q?DXStV8eIxQIVBTYl3TU5fMqNOWv98RdE3Tb0YO5OpwQkvQuAzyNDdRjGdjjq?=
 =?us-ascii?Q?0OC1OtlrAyT+tKVcIhF5Hp6vNB/Ef9UBZSohjfx3Y694liH9KXWB9dtQCg8d?=
 =?us-ascii?Q?daD7F9DXrCZ01CgnIwaKlfgIOzFqvSelYydQVJ2jNsLaGlFJ4VEUhRS2J68H?=
 =?us-ascii?Q?V8qnS5Xbyv0U2kZmcOBwTprQGqKpu4nrRCmT34CAZP/kW1M3G4j6YbIEfb00?=
 =?us-ascii?Q?59+GT30QpBLhGyqeJyy15qR3wRcOiomNTVpq4zT9P1DrQWscZRWL/9z2+Fop?=
 =?us-ascii?Q?OaLdCUE26ofJtzvRIMtsofoqBNJaX9VJRK6c4yrc0g3IMSxnusDnyWaNPBIy?=
 =?us-ascii?Q?D63imt9DeFNLv2x2BDFRJnqC440Nwc7swINxSeow5YvnRU1qrN/Jo4AQtCxC?=
 =?us-ascii?Q?gvo6m64mxgDFuxIuZE9RJfZ261XjqQQJd2seDBzalJGDn5cObEWJkE0qpG1X?=
 =?us-ascii?Q?sDOR5ZuOKM5+mZipRCVZ/Vg9m7d2HOiEnJds5asB5kkZJhLEGTX8CZb6ROIW?=
 =?us-ascii?Q?SAH/WzWMfoGAL0lVqp7oRQxDjSiwGQ5de3wHwxEW13Vb5mXpl8q+aCSAycAh?=
 =?us-ascii?Q?IUCXfiLxaOcKZ1093IzHsH2pKPm3nh3JIFzgJ1A0Nkg0q5np2vPkChdLL5aj?=
 =?us-ascii?Q?kxYBYyCyR//ORdZnBF+uXRTmdv+LCD0f68h8pRXFkeIPvTOSEnTqBRii8qQ0?=
 =?us-ascii?Q?T/AUgygKnssLCw72dpyMht6YsEUvrdrirnAquPEHdLF+CliqYgjlshAvkZwR?=
 =?us-ascii?Q?tHbqe+VoS5wZN/GXZ4jNX28kW0fZBQg1jCRDbtyp2VgnGZN6uL8fzJ7Ofk3h?=
 =?us-ascii?Q?dcQKO5p3Vhk1OXhbxcx/vka3P2S2e+89c1G8xIIjFsNb74AILbPRsaqiv7JA?=
 =?us-ascii?Q?yMsYbGz66/LlOaSw2pnXnycmDeNw80QN1ZdKR9fACTc7TcHJ8heXrlro4A2f?=
 =?us-ascii?Q?HnYMlOHJxFenyKkSGyapsUVeKExwSiGi?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2024 20:34:48.4848 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 85f843c3-9725-4dc7-7857-08dcb72061bd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989EA.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7831
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

When users dynamically set the partition mode through sysfs writes,
this can lead to a double lock situation where the KFD is trying to take
the partition lock when updating the recommended SDMA engines.
Have the KFD do a lockless query instead to avoid this.
This should work since the KFD always initializes synchronously after
the KGD partition mode is set regardless of user or system setup.

Fixes: a0f548d7871e ("drm/amdkfd: allow users to target recommended SDMA engines")
Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
index 40771f8752cb..8fee89b8dd67 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
@@ -1287,7 +1287,7 @@ static void kfd_set_recommended_sdma_engines(struct kfd_topology_device *to_dev,
 	int num_xgmi_nodes = adev->gmc.xgmi.num_physical_nodes;
 	bool support_rec_eng = !amdgpu_sriov_vf(adev) && to_dev->gpu &&
 		adev->aid_mask && num_xgmi_nodes &&
-		(amdgpu_xcp_query_partition_mode(adev->xcp_mgr, AMDGPU_XCP_FL_NONE) ==
+		(amdgpu_xcp_query_partition_mode(adev->xcp_mgr, AMDGPU_XCP_FL_LOCKED) ==
 		      AMDGPU_SPX_PARTITION_MODE) &&
 		(!(adev->flags & AMD_IS_APU) && num_xgmi_nodes == 8);
 
-- 
2.34.1

