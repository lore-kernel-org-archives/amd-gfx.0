Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CADCBCD6E55
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Jun 2026 13:28:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4E3F610FE29;
	Wed,  3 Jun 2026 13:28:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="CvTZOcVW";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012050.outbound.protection.outlook.com
 [40.93.195.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9ED3910FE29
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Jun 2026 13:28:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ee9SCsoD2mcNcl8yu+utuXO8wArBRU6bLENlAnD3POutMJbebelixP4Ap14ufKn4vKtr0OEcHX67SAocrEpBvFqF5ht3xSBH9W5k9nGF7/tMJ397sQGAXp7uW4sWtHqKSM0aevLGFlTz4lzJqrQtU0woq91tACiHrgqVmO80eJlXrkaCOt4McpBwu46nfY/RzhZHQJYHM/16KD8GvslJKUjCt3Nd5GKeOiiNfvv8eQ0wHf4ayLadqoXA5eW1Q8GnAepVsAMPbBkb5eD+visPqbqTYmJPu7yC8oUVy332CxBluzF2GQikGcNian/7smR/RQtVKIR51AI4UkpKSX9DqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9MxjZ2/9EPBkf2ERrh0EekUhKZcWjniGhnwzYrQpt4E=;
 b=txb8mOi1AhuG8vfe/+XaupTGsan2ftp8eScdTrmwKDrLf9W2TcjsaJRSFSIzZltgvBkGTt+RavEiGexR1Q9cKyf8nsxr/iyY4zVhBgsy3ZcypxEiLJWciEFggdumYxHPHzdfCUqnbcrcRurbFMUg3lap1AkwLJxkn8V0f6shXns4FaERxBwPPtO9m1juPaOM0Pw6RQRfSxRbJXJEQ2sxMIbmLg5/2oMknpZsK+McrL25TLKBmHqERz8cv+XW8Zb2RPbeT2p+HN0x+nVgtp+u47gZH/d3PZ+cET//G9wPm5F7M003ZNHLD40IBbTq3FRRvFBFNY63GtVCGRFESexRDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9MxjZ2/9EPBkf2ERrh0EekUhKZcWjniGhnwzYrQpt4E=;
 b=CvTZOcVW0OCseCA2WRfS8oivRE6/x9ET+TDPW9mqLymO7wsukYlkor0hCtmtk9Um006Fq5SkK+h1SifKUFykoI3rIMjZSNPpYFKeK4lneXk6GtwrAWYA75luNF+eugUeM6xGtlumuw2PFiu/HHvnq+7FjhR+y5A8TTFoeorqaPw=
Received: from PH0PR07CA0085.namprd07.prod.outlook.com (2603:10b6:510:f::30)
 by DS7PR12MB8322.namprd12.prod.outlook.com (2603:10b6:8:ed::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.16; Wed, 3 Jun 2026
 13:27:57 +0000
Received: from CY4PEPF0000EE30.namprd05.prod.outlook.com
 (2603:10b6:510:f:cafe::c) by PH0PR07CA0085.outlook.office365.com
 (2603:10b6:510:f::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.7 via Frontend Transport; Wed, 3
 Jun 2026 13:27:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EE30.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Wed, 3 Jun 2026 13:27:57 +0000
Received: from krussell.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 3 Jun
 2026 08:27:55 -0500
From: Kent Russell <kent.russell@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Kent Russell <kent.russell@amd.com>
Subject: [PATCH 3/3] drm/amdkfd: Extend MQDs in HBM to gfx944
Date: Wed, 3 Jun 2026 09:27:40 -0400
Message-ID: <20260603132740.180346-3-kent.russell@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260603132740.180346-1-kent.russell@amd.com>
References: <20260603132740.180346-1-kent.russell@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE30:EE_|DS7PR12MB8322:EE_
X-MS-Office365-Filtering-Correlation-Id: b94bd80c-b879-40ca-2bef-08dec173ecd1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700016|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: Ziy87Tv9IjxEOI9zCXKMzDO+x6i/9dZu+nZCLxeV3d1wS3z9NqR9xr3PLi0wSOBvIjTqF8JYB9QMAEdomMfxOSssgzcJ0C34zniPt1YVbMUtv6Ysy+E4NajupTKaiTNdN7myLlrXLkdfVm0qxzXPCHh9uOhLKH1p0foloygpqx5k+G1PmFA5VnaHK60fgokQA1BNitwiPrwxeeAhcRRZH0XYvLZiZbNC3Y2jkU3dsifthnY9hX2o6VG4+yGtBgRPlWY+Sh1wzEHBFN45959aNDxSaoTHMoMEp7PBDWa2k4xnKAxUMHVUjFcM+RJnvIsKe/SjXCED/WTJnw7j2p4//YTB/tE2dX/Nu4S1JkCm7N2No5lh/ojt2hwKEdGe3AyncespsP3ge7dfEQkvH2KBUnEXc0E4UeTzq9uELA3HUwaIR7s4XQTh7bnakziIVQJ4NwmmA/mBO8vMwr/GIewpRsURlS+d/fNfn53to4TjG6IjHb6sJn3y+E12uKEFj1xiFHaY6CPxMSbaxMbSqWNlJIDl76LN9b3J9yc0YmY1K5uOEl/9M3bVHn0f0nPU5o+xEfBHF6TRYsbNkfctvMAVh+Ss1SWow8t/sXF1ID/tMuvXyXGW5+pk98cgHtLTRlVpBp0lAjhgG8YEKQDzR7dpKr+KGoHPDq58hSCdYQMuBx9+2q8Vc+ChRboAIH3GWrUjV489cZsi2ytkUMlds9CLgsPulpGTTpBm8IRxy/4FHKk=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700016)(22082099003)(18002099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: J6y3TiUebyoKtjSxa4cYUJ8UEoaWzdizntg5xC1j0S9CUVPPOom3vOqrbGshfRfVXJhOlk1/jIl35ymJJuCVusxpNTfSTsTdFvqB5C3ErnyqEILCbufFjqJ5Cj0BT1msYstA9a83bwD/BgsJvxWFqIn7D+DE/cSoYoNkCUqKFrrfN22rG1VpyiqmGyYPZ+A3L2Y3o2phSlpF5vMkhO4M8mXqWHo0STV77lIjYtrpw36/6PRnGkz12yZnSypEanTqHMnIoBaXdahK3e95jGR83g49pUhIVguizc7jUItLz4rvKtGih570dQhcjQD22QqZsfvF6y2vp4OivDhCRGr5vDx3EvueVrTd6x/LXUxtBZAsIeMKXaN5zpV3in1uQWWE092SjP4ThGM2pI0UcH6xJq81oDqYMztG2mWffoJCwvj08vuOmdimmnKV8P2w4IyP
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2026 13:27:57.0834 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b94bd80c-b879-40ca-2bef-08dec173ecd1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE30.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8322
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

This has proven stable and performant on gfx943 and gfx950, so extend
it to gfx944 as well

Signed-off-by: Kent Russell <kent.russell@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c
index 5970a1694286..b0f83f63e010 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c
@@ -324,6 +324,7 @@ bool mqd_on_vram(struct amdgpu_device *adev)
 	switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
 	case IP_VERSION(9, 4, 2):
 	case IP_VERSION(9, 4, 3):
+	case IP_VERSION(9, 4, 4):
 	case IP_VERSION(9, 5, 0):
 		return true;
 	default:
-- 
2.43.0

