Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E454CA0FF0
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Aug 2025 21:01:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 50CE110E571;
	Mon, 25 Aug 2025 21:01:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xii4thfo";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2054.outbound.protection.outlook.com [40.107.92.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C4D6C10E56C
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Aug 2025 21:01:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gj76JTDHVtiSBrr1AtRfR2HEWLAOdfKcHTlE5YdFz9ghB7wDinQkCCflZvVNaXdom0WYesBlicxSovwnfQhmE3h2cJg6ifPc2xEEKBdPObmylDp0mhHgYCEiKf5TCxhZTPL6XQ4rBZNE6ULu0ZkReQqbLbpTqq6yN2OS9yZ1I5vPaHbB0z4J7X1vQKG+S7/PozC8Xtydf4Fn4oOs37OJlM5qssHHydrt1X9K9LZMuPPfw6x3HCl2FxuotO4v/wwbEeMvwIq6yaLbnBrWJAtGAtfPfn6pX+ierEHFteGBxYcyScNdr9FUH5HpimkvriG2FwaIhPfBv64lFz2iAKFwFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=THoTVYwPDeB4q9gDU7B/B4CfVClt5h/L7U9lmGu6r1U=;
 b=YH1/hB3RBBq1jOryYfQkl2LRQ9VSVneZ2j/EZHfzjAYQaFkBDsf/8OoQp83vOixNMBe42ZSZBDzgrjS3oVTAww5oAEQCSb0Q9TTso+S96mTLXr+Hf/WO1Tz+b3/bbr71X2QkxduTrbMM8ucnqaK3Oa65mC9o5XBPtc9IId5EMBbXr/6oMGKRtF+nCeMlfJ4MmngL4mIY3mBFgzbyhOcFlecs63EfSBwHohFxT6tps3C7zQ+LgRTpVEjuBFy9Yuesq/lNYCwo9xID1BkMIJbQMNEE2AETLbT3FQGZwj+x+EoiwHBjRYZFEsZtOa0bEh+LR0JD/KuEXa9qorY0G8xSvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=THoTVYwPDeB4q9gDU7B/B4CfVClt5h/L7U9lmGu6r1U=;
 b=xii4thfoL9+dDXtCuawkr2wkpVEyMv29ZtZkAqE56uL5/dtgOBsuQBSyyCua3FGso+XL9+1YMi6Lj2QAJIw5gEEEuP20f/VXapX1c00KZzH96Rj4mKBlMHyH7vwPYIIWcCkCpRopvpALQsLLI6X94FS+RJckvCYwOzHZI6Urfog=
Received: from BN9PR03CA0235.namprd03.prod.outlook.com (2603:10b6:408:f8::30)
 by DS4PR12MB9681.namprd12.prod.outlook.com (2603:10b6:8:281::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Mon, 25 Aug
 2025 21:01:25 +0000
Received: from BL02EPF0001A107.namprd05.prod.outlook.com
 (2603:10b6:408:f8:cafe::d8) by BN9PR03CA0235.outlook.office365.com
 (2603:10b6:408:f8::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.21 via Frontend Transport; Mon,
 25 Aug 2025 21:01:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A107.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9073.11 via Frontend Transport; Mon, 25 Aug 2025 21:01:25 +0000
Received: from david-B650-PG-Lightning.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 25 Aug 2025 16:01:24 -0500
From: "David (Ming Qiang) Wu" <David.Wu3@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/3] drm/amdgpu/vcn: add instance number to VCN version message
Date: Mon, 25 Aug 2025 17:01:13 -0400
Message-ID: <20250825210113.182727-4-David.Wu3@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250825210113.182727-1-David.Wu3@amd.com>
References: <20250825210113.182727-1-David.Wu3@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A107:EE_|DS4PR12MB9681:EE_
X-MS-Office365-Filtering-Correlation-Id: 91123ec4-cddf-4df0-d206-08dde41a8d89
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?9ZBh3aG7AhOBjQglG5qr8uDrJ1QNmOfQ/+I+6iXcqLXwExsYx0jRDECUGP7p?=
 =?us-ascii?Q?CxfUDNtxQkq/f3RuJtHj9nugZ1N6z55m47nwWVUA0YWX9SISjTs5kXN6gXi9?=
 =?us-ascii?Q?EPSqxPL09O/TXZ6kY7obzsV5hqMu1IMB84IyxtPvIY1aN9kulb/cdjTFtlur?=
 =?us-ascii?Q?P3lUYOL4nm5SF0oUbpvLVbEWaGUEe/OcqEIhToTBui83fFyXx9MpgQSgOoYj?=
 =?us-ascii?Q?mYKII3fYDnB1UD19rcMuxQJOF6MolIu2czTtZfWQZRWF1EI423A5q/aKmRFa?=
 =?us-ascii?Q?DxpDP4F1qurR7yCDnYOoOKeNJHHs2NymitCjBGqoGEFRTQMbMJwpjx9zD0RC?=
 =?us-ascii?Q?JY8JK6JUSj+vivHqDbHIN7gn1hjwx0tFa4Wp5auVir70RLzqH6GvmkKQE0Xg?=
 =?us-ascii?Q?dLp4IYNmvTyAlz4HfAE8pT3a6Jfydb5uZkdEleDySxKsZTOG/hNnuiFBaZK+?=
 =?us-ascii?Q?dSOVSKLIr8uf+1UwISqa5su7MsxpBfuUEPwcIj0T4nE6lolVbM9MAFH7+mhu?=
 =?us-ascii?Q?IdXuPNeHpBnroJEB0UUKQRGW3x5Jo0bjPAVkzOmKKRAlgSrLgpnfkcxlXPBV?=
 =?us-ascii?Q?OLmW5oL7nXL4Tg33JeM2kErHK5BoYRw0gFDxkzYM3fl97qUEiLNZ8VEE6mxA?=
 =?us-ascii?Q?zk3wWb09g1M0DDh8ZV6QUjX5pOMQBZTWMiU2e9HfbNb8ndbkYLy0PlZ76rZp?=
 =?us-ascii?Q?V9StBGaMSE4k54kBbyx680y7rfg5iOh+2fvBFRw1tkgYZiUMcpv+5pCHI2Ey?=
 =?us-ascii?Q?JWT+SVpQ/nZu5Z5J6d04Qk08SKK6qd2dpPel2YOJ4NmD2d0fcBNC1DgyjnH8?=
 =?us-ascii?Q?QWxQooEVveNfRsusGL0urCZpH6ip3chMXkjrDGSQUU//Sob+yGpRgdrdtNPU?=
 =?us-ascii?Q?Y7F66YzIAd4mRdi/SjhkcfgdhsZSZ8PNjUsCogp6iqT2Uq/R4X6IGNIGMZbU?=
 =?us-ascii?Q?ZtVhq2SiUzN/DIEzWcH4fwPNeWH69JylaylMlCUfF3ow31zJ5jHOtF6FBnCq?=
 =?us-ascii?Q?kD44vgAXCedcTrMVDhddYWKVfUA34qFSP0ilgYXw7vsiOKCExMT52u0DVF1x?=
 =?us-ascii?Q?XXBxd+S6YhSPDYnnBNmD9+/EhgvjKLRt+N4paYmDcPpXIj4acE2hs+5iWq1M?=
 =?us-ascii?Q?YhPAEur5wxF5l2o2r8rt7dATBsOf2YpB9vrVRBk+NZRLtQgyBgxJKuz7AfFv?=
 =?us-ascii?Q?KkpXCHc7mJ+1j84vTszajGxiBO5R9WhjZrkzfWTxljExsCB47VObiXimB4H9?=
 =?us-ascii?Q?qhmMkwC5nGJFuN6DOXjFNIC49k9h8bzb10gl+gvRMjYcxDyaktR8ohxin4FV?=
 =?us-ascii?Q?MzjV61GAdVlyPLyKRSXUvmgXYiBt3cqw1luia93+66xDMzbCVx1axflUti5K?=
 =?us-ascii?Q?Rb6Cszz70CQKAW7PiNTxECmEby8Hj6qw1X1PQSQRACAHRZ1w4ZWNt6J7WJJA?=
 =?us-ascii?Q?eF2cpU0xWvIgq81eAHkzpKtqa/+95GDGSrvuA9BuCyLU0yLCryf2hyQA7tZN?=
 =?us-ascii?Q?f4rVZa5LGn5eDnERew1Fp/5lhAB3cdWkWWNY?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2025 21:01:25.0944 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 91123ec4-cddf-4df0-d206-08dde41a8d89
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A107.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9681
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

For multiple VCN instances case we get multiple lines of the same
message like below:

  amdgpu 0000:43:00.0: amdgpu: Found VCN firmware Version ENC: 1.24 DEC: 9 VEP: 0 Revision: 11
  amdgpu 0000:43:00.0: amdgpu: Found VCN firmware Version ENC: 1.24 DEC: 9 VEP: 0 Revision: 11

By adding instance number to the log message for multiple VCN instances,
each line will clearly indicate which VCN instance it refers to.

Signed-off-by: David (Ming Qiang) Wu <David.Wu3@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index fd8ebf4b5a824..5a90abcea0ac1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -185,16 +185,16 @@ int amdgpu_vcn_sw_init(struct amdgpu_device *adev, int i)
 		dec_ver = (le32_to_cpu(hdr->ucode_version) >> 24) & 0xf;
 		vep = (le32_to_cpu(hdr->ucode_version) >> 28) & 0xf;
 		dev_info(adev->dev,
-			 "Found VCN firmware Version ENC: %u.%u DEC: %u VEP: %u Revision: %u\n",
-			 enc_major, enc_minor, dec_ver, vep, fw_rev);
+			 "[VCN instance %d] Found VCN firmware Version ENC: %u.%u DEC: %u VEP: %u Revision: %u\n",
+			 i, enc_major, enc_minor, dec_ver, vep, fw_rev);
 	} else {
 		unsigned int version_major, version_minor, family_id;
 
 		family_id = le32_to_cpu(hdr->ucode_version) & 0xff;
 		version_major = (le32_to_cpu(hdr->ucode_version) >> 24) & 0xff;
 		version_minor = (le32_to_cpu(hdr->ucode_version) >> 8) & 0xff;
-		dev_info(adev->dev, "Found VCN firmware Version: %u.%u Family ID: %u\n",
-			 version_major, version_minor, family_id);
+		dev_info(adev->dev, "[VCN instance %d] Found VCN firmware Version: %u.%u Family ID: %u\n",
+			 i, version_major, version_minor, family_id);
 	}
 
 	bo_size = AMDGPU_VCN_STACK_SIZE + AMDGPU_VCN_CONTEXT_SIZE;
-- 
2.43.0

