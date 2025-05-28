Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07820C5B554
	for <amd-gfx@archiver.kernel.org>; Wed, 28 May 2025 04:19:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4A40810E54F;
	Wed, 28 May 2025 04:19:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mhfyplNp";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2083.outbound.protection.outlook.com [40.107.92.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B82B310E548
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 May 2025 04:19:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wue2KBRRoWig1inLkKT1sbX2uXideZ73nC/8oqgCXISbn2z3MWSVF2DcRy4y7NmXeq3wxvJsyFUjYl+rQp/OvCDHHdvS/BnSoy6bhG1f79yz86gcKq6XP2BavU0oOFSnRSMLNV3xHu8PDUiDNj8zwfhqcwEnO1OJvHTTZMC/R2/jQXlmTqoKuMHHgNY2pzVmbM3jgqY+p5bAaXSGEuCMApxMN3J7HypBrG6DeYJBygpnnIfHQdnDwVLM8qjTmnIxvQxToV9TzF8wF8nkYsVDR3Bjwu05gYf8MLzwAClut7IbEIqoXGa/PSAo+ha9KJh6KCe3JTcbHPiwFq/sYHy2oA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8F1NUq5kbbjmVOcP5bMYv+43Db2/AkN2VOnSlRaqTfQ=;
 b=zAL+3G+MwJK3vJaHTg3vPw07ldE2SN+f5idDfXy50dLcilOvfh+li8iq3DF6O5HZbfdM3NQesS8HqFZPQ6jDzEHvAaUmWylYF6WqlejCYIIKxd/tHIEmsU6idhhdgar12jWLTKYXXOI89cJXjPu5/qFmMpryOSZ8p5AQ2ZticpxxWkSD8KNOpxYTq7LnomBvQTjm0FLQR9A5JNLScE8EwGfPcDo+9Ips9FvqNibp6j5f27osAY6zSI5sMZSHj8V1+nWyhvCzElep9stSN4QoshWo3MkFyC7CjsYj/OZdrX0F91XTu4JuaLBNE/1cMTst4T6sI2Havlne46HvQT0M0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8F1NUq5kbbjmVOcP5bMYv+43Db2/AkN2VOnSlRaqTfQ=;
 b=mhfyplNp+dOntQx/+F4QWhQCSv2+HY+rO0Nbl2y7Fq2JROZ7tyjB02UWqaXtmJ2VlfX5MWy8aN4tCxXYROycbAGBLDm4MnDa3pKBWB1Q3wMTXm6BXe2LHZKyc6r/1D6DXWIChvSIVlTY4uS9erKODWJGRcVyEPVUAj3ncBS45Ic=
Received: from DS7PR05CA0048.namprd05.prod.outlook.com (2603:10b6:8:2f::19) by
 SA1PR12MB7151.namprd12.prod.outlook.com (2603:10b6:806:2b1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.25; Wed, 28 May
 2025 04:19:31 +0000
Received: from DS3PEPF000099E0.namprd04.prod.outlook.com
 (2603:10b6:8:2f:cafe::16) by DS7PR05CA0048.outlook.office365.com
 (2603:10b6:8:2f::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.16 via Frontend Transport; Wed,
 28 May 2025 04:19:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099E0.mail.protection.outlook.com (10.167.17.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8769.18 via Frontend Transport; Wed, 28 May 2025 04:19:31 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 27 May
 2025 23:19:29 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 02/19] drm/amdgpu/gfx11: enable legacy enforce isolation
Date: Wed, 28 May 2025 00:18:57 -0400
Message-ID: <20250528041914.5844-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250528041914.5844-1-alexander.deucher@amd.com>
References: <20250528041914.5844-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099E0:EE_|SA1PR12MB7151:EE_
X-MS-Office365-Filtering-Correlation-Id: 32a0e357-53cc-47af-1233-08dd9d9ed829
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?YrH1395BNa5ZRaWFeG4OhAcp2XIahtbYB6rgv0nk58T5OePjjH/Obr1V1QAE?=
 =?us-ascii?Q?5FvegT1ZsehfIOxzbjT4eu7n/2573RvxeGD+Q84G4QDiHHhda0BI61XKxaIh?=
 =?us-ascii?Q?WRbGMWCQCvLYcs0Q4Bx0OnTd70Wqw6L9oZwLaN6OAcEG12Z/o9509XIvY+Rf?=
 =?us-ascii?Q?DdICWDQZwU2pVtHq9F2zAc7xSs/0S3g+ESDwvNu8jT3PXGLyvJXpJI/3g2L8?=
 =?us-ascii?Q?pTfI+89aH/yZcb8inS5keu5Er0MDQG8nFF4b4m+GYGoKqPvKVMfp6Wi5Q4CP?=
 =?us-ascii?Q?E7LfmfBlCGEjR7k1qX8KlxHCva1nzUFUBK3rtepqCZN7SWavO4LwXbORk8KH?=
 =?us-ascii?Q?WO/dgcQG089h1y8IF+TYI0mAVmDWzrMnumuKRktnsavz1PNnrUHC7IOhqVaW?=
 =?us-ascii?Q?NKhWOkqziJVU+XR0JSO5S36//MiJUJ5pBY95b4DvUz2Zgg8hMdA66ivCy54q?=
 =?us-ascii?Q?Iis9OFQzP4dcZnpmR61IqL2mZMj4WrTJGzVYi35XkUqtmYmVk84gi5GOe/IJ?=
 =?us-ascii?Q?SIB0hfeWDcChJetmiHOlrqRc5IJT9a+f0DUol8JI5vyld2go56kuOACE+xPV?=
 =?us-ascii?Q?I7bguMYh0p281/DBi6/54JWzBPrvQfkIlNCLOyBwgf+WhbbhFgykWN1gVUQv?=
 =?us-ascii?Q?S1gCX0TFrWomfjUE0LMebsNrLiFbI8wjpE2OzFRVLAB+1mtjMge+RNFZYqVc?=
 =?us-ascii?Q?ldit3bMBkuc+KCQg0yzjzovCZ6jwLvUZad9nVhe03lHLeHX4C5yLINOsit1R?=
 =?us-ascii?Q?EGubyBYdorM5aANDBf5RQsJxpa1YSSLg0LLf4nvwOmGuvbMSDpFDMx4HCGYQ?=
 =?us-ascii?Q?Vcp8q+Fx9+RkiLXX8wh62Awl6vYm/O7w8QlVfuiNJvad0lJR9qjI/S7znQkB?=
 =?us-ascii?Q?/ACZwYRH78rkvL4sK+1HYZznUOJXNhjIOzhwbIADGU09icYGbYTWmrjyg3y8?=
 =?us-ascii?Q?eaYHUaQIbroLT3wWNRKhodKMpZ5eA15f7fYeJrnwiK0P4FvFY3mff+2qfxlI?=
 =?us-ascii?Q?oRmfxEHhVrj7AcVFQASWU/ccJlWLLsljZW2d9ii+o2um7GmpHbQUu9+SoWQL?=
 =?us-ascii?Q?UOpMpMYBNDaYfXpNhtoRXdPqTZNF8LSuuBK+aBg7lw1mBWWRfDiofhBaTJbG?=
 =?us-ascii?Q?OOgI8h9hkk7clTJ0IsznV3WxWcvxLCAlGe/BYlXzz2m1+0MfebzxBzI9ouNC?=
 =?us-ascii?Q?mdhq9Oevs1WJtd8n4iuHB98XKZaUkUkO2cGwJ5puSxx4eYx5vyvHN+GpGZ6T?=
 =?us-ascii?Q?sXyoDQLq1qaFwTqfJ9Dk/fJnEoHs8tTzIqMXG7SdZEcTGmWBkMNE2XjO/gQe?=
 =?us-ascii?Q?j74+WDGhi7XuT7Zau5QiI9dZRB4dLrKXBpZvUXX2KpVRnyEr4yD4s9PG8/5i?=
 =?us-ascii?Q?2wZRSO2pKOnQBr2+TKYr1ehqWmCx6HH/KbWyh50hwxOfpGdqNL9PYpdQpEtd?=
 =?us-ascii?Q?ta27Iwp81/fbHT3uuBdQIWtCy0iVUSaJ9QoMWTBN2W065IubMfKkEB0lbr+b?=
 =?us-ascii?Q?401oBcHCtCWQG1zt2nNdJ8ZDTbBPI0sq5eae?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2025 04:19:31.2641 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 32a0e357-53cc-47af-1233-08dd9d9ed829
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099E0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7151
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

Enable legacy enforce isolation (just serialize kernel
GC submissions).  This way we can reset a ring and
only affect the the process currently using that ring.
This mirrors what windows does.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index afd6d59164bfa..39374c87738b3 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -5189,6 +5189,15 @@ static void gfx_v11_0_ring_emit_gds_switch(struct amdgpu_ring *ring,
 static int gfx_v11_0_early_init(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
+	int i;
+
+	if (amdgpu_enforce_isolation == -1) {
+		for (i = 0; i < MAX_XCP; i++) {
+			/* enable legacy mode by default */
+                        adev->enforce_isolation[i] =
+                                AMDGPU_ENFORCE_ISOLATION_ENABLE_LEGACY;
+		}
+	}
 
 	switch (amdgpu_user_queue) {
 	case -1:
-- 
2.49.0

