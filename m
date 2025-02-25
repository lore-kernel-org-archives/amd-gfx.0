Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43789C021B2
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Feb 2025 11:26:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DFD1A10E63B;
	Tue, 25 Feb 2025 11:26:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="JiG5JYSD";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2041.outbound.protection.outlook.com [40.107.220.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 748FA10E63B
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Feb 2025 11:26:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gumbW8t1OB23hljycaF7s04uxn2obYK+SLQDgIyXMwx9X9I8prABZdxx6QOcxnvJf5rZRoXEK0e7DNGMmEGjutS5z7oHUm7904fue5OlnyoSTkYz/Wo5uIJzTGkFmGdAqv61KRuMmqUIKKfRmUVefCykUQDvDvkv1Aq3vO20wZDqSOCJydNv8oOUIPIkjaGWPt1OpvXhaeIJ/bsim7wUvJt4BkwyX/cslc4FR8neZntDlX2WIZIuaE+I6OrG7jtqaPBqz3ld5Xg0zhGSuMy9fr4P3snZC7zP+tVkfJepMZmVdYx0FYIt7XqrZFsZkuxrN3p5HeDo9PHTklKVhZ/e5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8C7LQ+EBymjuQQELfOfj1PDkNO6F8Ca1KUp0BPykzl8=;
 b=q5YRAiP9jqepIhwxkxA8BI2vTQ4xxLVOKzCQO9snY26SRtGPayZxU8C2cT7QpfkdnYmtYXHNXyiTkTjBQdYOm8c8ZKM2Ti6WCcir01KQGs71KynFyjr4XZw0waJy2mrTpVztwRU3/Kj5ARRNhMe27T82wKrUJZ/qiCw5GMR1z8e6yHGP0jTEFsTaqRE3tx/sLHK7V6faf4IBuCMloMgHqbIhY7xx4J7TA4Jw0IMDRv9O1QiguuQFoqgUw2P3QCx/h+mJM7POPvfLG1VlH3fZBvSE15UTojF9l4g2uambyLcAhykpTkiTcNokR1gmu/aP6Q3f/Kgf6BJLHUGenEmJ+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8C7LQ+EBymjuQQELfOfj1PDkNO6F8Ca1KUp0BPykzl8=;
 b=JiG5JYSDi/6VOayaWzVH3KxpkKwigCJWvti6t3tddr5CaBhOX6z1JpJ0Xm26xBYGrIi29aRqz2laWro9DsT7mPxxiR9Twf/jTPecQdKb902ZoFKXpcISKn5Azu1KejQo8OCLncjBvsrUTNL4wAF8DRDnFu7U6SDtD4iSeqiQXL8=
Received: from MN2PR04CA0007.namprd04.prod.outlook.com (2603:10b6:208:d4::20)
 by DS7PR12MB6189.namprd12.prod.outlook.com (2603:10b6:8:9a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Tue, 25 Feb
 2025 11:26:35 +0000
Received: from BN3PEPF0000B075.namprd04.prod.outlook.com
 (2603:10b6:208:d4:cafe::2b) by MN2PR04CA0007.outlook.office365.com
 (2603:10b6:208:d4::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.19 via Frontend Transport; Tue,
 25 Feb 2025 11:26:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B075.mail.protection.outlook.com (10.167.243.120) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8489.16 via Frontend Transport; Tue, 25 Feb 2025 11:26:34 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 25 Feb
 2025 05:26:32 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Asad.Kamal@amd.com>, <Le.Ma@amd.com>, <shiwu.zhang@amd.com>
Subject: [PATCH] drm/amdgpu: Use wafl version for xgmi
Date: Tue, 25 Feb 2025 16:56:17 +0530
Message-ID: <20250225112617.120865-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B075:EE_|DS7PR12MB6189:EE_
X-MS-Office365-Filtering-Correlation-Id: a9e34e9c-54c9-4e7f-cfb1-08dd558f42dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?l+h1SzOA1RYRmDG1DtgU4fLsyUtVUIIxtRB+Gh7OqP+mtOgynCPHgDQYxPhz?=
 =?us-ascii?Q?htYMHRaSEiuyHRitmaB1kgMha69M++xMW/GfVnh3NThZbdvctTz2APSdmLGy?=
 =?us-ascii?Q?VDPawLZF8guMx5XK2+u/tUI2G00ViFSGmN2nBbCK2mWQCpMaLnaOnodpoxUi?=
 =?us-ascii?Q?kwmG1ayH616C/+ELsHBgSb3bTqSdZwM5ssSwa/GP4hRNl2DY0KT7pN8rcz3Y?=
 =?us-ascii?Q?ywzOkeKkGt+7KXnpRSFCXTLbjI+TOzFKElLWkHC7qAC4jQ27790+JxR6rd0I?=
 =?us-ascii?Q?3HC99HGGGlk1M1Tai3It/ZKLRavsrKOtPMx5Hyb0ZrY/vdJrCwYit/sioslK?=
 =?us-ascii?Q?OFtS5UhljG5GvpYxDzFqvG2lPClGaTf4yOA+B4/QUESZc6lKqCaVgv3TmnZo?=
 =?us-ascii?Q?Z333om6mUwDgfqifQQUsB4rlqLNPg77nrWzgsON6M+6AkuxecBYrgC4pXgva?=
 =?us-ascii?Q?AioOUGzKrA5q/Su+I92HrgfDMgwgLJcXJm7+M8MmDOmOU/sSYLuJOqH1re5s?=
 =?us-ascii?Q?ogSNu8wNDuCApy9WTUM6eFfA87eH63C8eUpFEpOwAVs9jTuqSFiUS8O1gv8i?=
 =?us-ascii?Q?8eSg7IkoBCHzaur2OnWVacq8HdRC9mWmGeRPg2WEYzEaZf+AAd2iO5M5xAQv?=
 =?us-ascii?Q?DWrDhFr+P6NVOUxERnKsxfULVaTVr5fnIrTpzFYKQi8oIQJ/O7/2Jwydxu1H?=
 =?us-ascii?Q?tG5LA9+6DxzWdklkQ8FdqOloYW9EW5qA4JPyKAxuOsbI7C3FreCk60SErrdE?=
 =?us-ascii?Q?JY33cUPSQXrNhH3pCPp2ireQW3ZsiYMfa3oDSIPUHomoVHYqwGSjYGl4Brkj?=
 =?us-ascii?Q?vRS97fBblTEql7+5qWDFiuVu0sIUpyP7H2rz5yqcIVHdPm/RYyD8hCRyzb/A?=
 =?us-ascii?Q?zD3LQsQXEC0vCea+sD70Z3zdxTk5bg62jsuDFsJEqeXg2WlX5SYmtU3o5Mec?=
 =?us-ascii?Q?KS9eXK3HG2hhIStbgEb9NI2HU9W9CR3ebHNvuy/Se2TX9PMGK9POWPL/0HoD?=
 =?us-ascii?Q?VT6j9C+riUYa0sqKNqWxStOCp4Tad6V3brpzrpgbs/hcwAVnkMXiMT3YlcCa?=
 =?us-ascii?Q?ieuzAM1pgIiS8V1jDlRn4L2GMf1LbYPDe88RnyFWDqidBJTP2fqMxNfQLO+g?=
 =?us-ascii?Q?4xzM6zv2QJa+VKkRg37s4gqO9w7ERJW5ctce3wlHbmB8NISEvfR1TVoNmj1m?=
 =?us-ascii?Q?0yCOjbGL+zgLlKPx7cqlQPsLDGhcVfpjQdPM1ngMBlFVhA1G48Bf81UqQ+Yh?=
 =?us-ascii?Q?mKAWMngLNZtiuFx9SOWDljBjf6kuowYvvld6XVJzsHYrpwIKKupH9Z2k/V7S?=
 =?us-ascii?Q?Hq8QiGONTPE6/nfs+uWNbHYtX0X8n2uGahpCFwvxKCeqjTCSiJ//QK9LUs8F?=
 =?us-ascii?Q?WDapqKbrQFFlLO92rVuouZOwwikWBwD71R4klfy4SOM2QaK4K++Js85cSSc3?=
 =?us-ascii?Q?QtkmBy+c0HkTTyv/lUZa/6tXE4Ym9s4GYwplr9XpDpVcM4oQhEQFkIJt5MEb?=
 =?us-ascii?Q?V9w7knnvcAm6vUk=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2025 11:26:34.6370 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a9e34e9c-54c9-4e7f-cfb1-08dd558f42dd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B075.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6189
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

XGMI and WAFL share the same versions. Use WAFL version if XGMI version
is not present in discovery.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 967a992829bd..8425e5dbf80e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -1290,6 +1290,7 @@ static int amdgpu_discovery_reg_base_init(struct amdgpu_device *adev)
 	uint16_t die_offset;
 	uint16_t ip_offset;
 	uint16_t num_dies;
+	uint32_t wafl_ver;
 	uint16_t num_ips;
 	uint16_t hw_id;
 	uint8_t inst;
@@ -1303,6 +1304,7 @@ static int amdgpu_discovery_reg_base_init(struct amdgpu_device *adev)
 		return r;
 	}
 
+	wafl_ver = 0;
 	adev->gfx.xcc_mask = 0;
 	adev->sdma.sdma_mask = 0;
 	adev->vcn.inst_mask = 0;
@@ -1403,6 +1405,10 @@ static int amdgpu_discovery_reg_base_init(struct amdgpu_device *adev)
 				adev->gfx.xcc_mask |=
 					(1U << ip->instance_number);
 
+			if (!wafl_ver && le16_to_cpu(ip->hw_id) == WAFLC_HWID)
+				wafl_ver = IP_VERSION_FULL(ip->major, ip->minor,
+							   ip->revision, 0, 0);
+
 			for (k = 0; k < num_base_address; k++) {
 				/*
 				 * convert the endianness of base addresses in place,
@@ -1468,6 +1474,9 @@ static int amdgpu_discovery_reg_base_init(struct amdgpu_device *adev)
 		}
 	}
 
+	if (wafl_ver && !adev->ip_versions[XGMI_HWIP][0])
+		adev->ip_versions[XGMI_HWIP][0] = wafl_ver;
+
 	return 0;
 }
 
@@ -2772,10 +2781,6 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
 		break;
 	}
 
-	if (amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 3) ||
-	    amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 4))
-		adev->ip_versions[XGMI_HWIP][0] = IP_VERSION(6, 4, 0);
-
 	/* set NBIO version */
 	switch (amdgpu_ip_version(adev, NBIO_HWIP, 0)) {
 	case IP_VERSION(6, 1, 0):
-- 
2.25.1

