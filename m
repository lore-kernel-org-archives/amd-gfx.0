Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5894C7115B
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Jun 2025 18:40:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3381310E07C;
	Thu, 19 Jun 2025 18:40:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="RKAtmlLg";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2069.outbound.protection.outlook.com [40.107.236.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2D24510E07C
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Jun 2025 18:40:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qAqW7utFWnoaF7xbxtzR9KbSU5ZBL/IQMrDwHUGco+D9XTUfXl451lyPNn0R4+hufH4YbEC+wwG6q8Pd5cNOykFkFDkMdXjRqrvMOzWc+/i8tlh051GmhX2rNqh4XUUc8H2CNwu793CUEyeuargj89A3zYNZOEp1NTyNDqYPH6LI+Dyyceh8+cBTsydxyiKE36Lh0G+LwN2UJI71Eq0UueHDIPzp7aysTJ0EVk/bWtU9eQRBnRRMuqfVlRW93MtL6GJhwI7tPJwJIY9bKT+gQk816kCjtq15SkLsOdeRzYctttHnm3G/lVHuGgmZoUqpm1r2wvYIoVSidmCrtUIReQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gGXBrvU/P9ovdsu+mYIsGsIh5Qs35cp0mbb48yY/RY4=;
 b=ndFLfa0pYsD4334G08i1R6NKPd2dNtUboKyf6yTN3sfkw+hNdYF+19Wirergya0Snqvp1EuDSL8MGmcmIGuzwoBxi79r6ahFgEWpicWRL82J71mXhSkdlAxM71iTjSbrAhcZv/pJsfzUhEUdLdxzWGaT8TRdehrs8fNyaUnTasu6OP0RNcgx19NjTdGZg4xEKuC2UzgQWYvCFBUUY7HvCdoXoi7UJ3ND/kTbDVaYVIepG+/V/XhACBtPOy31UQymowaWKbMXzFbLJnKf2TRic2jUxzVgC0Hi9Y+XLXWrb8UADmeD+Ev/DivVcQ8wcJD+WDauLaSupTc+VXObmN9XQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gGXBrvU/P9ovdsu+mYIsGsIh5Qs35cp0mbb48yY/RY4=;
 b=RKAtmlLgMPmn+xhf5kcqTezBZPR8mYQG1H+vOZDaBbBb5wm5Yd7PXqE+BqgCxv55vRIsS8+NjOjitENr4cBRFifFHtOf9j0ix9wpPB62XrC1bZKfkVgr7627jqrdvHf3z9if86c8w2m7pE7fWpVymsXlXSLCUY9F4D2YQou0vy0=
Received: from PH7PR13CA0019.namprd13.prod.outlook.com (2603:10b6:510:174::16)
 by DM6PR12MB4281.namprd12.prod.outlook.com (2603:10b6:5:21e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.25; Thu, 19 Jun
 2025 18:40:52 +0000
Received: from SN1PEPF0002529E.namprd05.prod.outlook.com
 (2603:10b6:510:174:cafe::b4) by PH7PR13CA0019.outlook.office365.com
 (2603:10b6:510:174::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.12 via Frontend Transport; Thu,
 19 Jun 2025 18:40:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002529E.mail.protection.outlook.com (10.167.242.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8857.21 via Frontend Transport; Thu, 19 Jun 2025 18:40:51 +0000
Received: from dayatsin-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 19 Jun
 2025 13:40:50 -0500
From: David Yat Sin <David.YatSin@amd.com>
To: <Amber.Lin@amd.com>, <amd-gfx@lists.freedesktop.org>
CC: <david.yatsin@amd.com>, David Yat Sin <David.YatSin@amd.com>
Subject: [PATCH] amdkfd: MTYPE_UC for ext-coherent system memory
Date: Thu, 19 Jun 2025 14:40:35 -0400
Message-ID: <20250619184035.1283782-1-David.YatSin@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529E:EE_|DM6PR12MB4281:EE_
X-MS-Office365-Filtering-Correlation-Id: f7b6ce02-0ad2-4598-25fe-08ddaf60d0e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?n2DpBMfJKZYlHkBmZ3BHmjnPxCDtUbMQljOLieExdJr/aa0fLeghgKGizXuT?=
 =?us-ascii?Q?6UKfjx9+Lx9zskY860coIGAUAVoeiIrTIapLC8wG2zHk1hRBvFYsIl3Db2mG?=
 =?us-ascii?Q?b4ehrPCUI8LxjpBDFhRN5bfOf1x2iwLFxe2WNcOozyQFbDEPTzWcjBtL33dZ?=
 =?us-ascii?Q?BO0BnfoPPHOIx/PcoBV8mo787FmP3ErArzRbF3sWTbslggnt+muZ15tUDwH9?=
 =?us-ascii?Q?aDRoCwIbDGtzMf7Yhj1BUByZ3p6Z5hcU1Hd1roQ59d7ZMHDNjNXfV+6JEArN?=
 =?us-ascii?Q?oASe3epXReGBHrJj3MW4Td/ArhqdTTyDkld7K1fZ8myVbIh1zs6MFIaTOBoU?=
 =?us-ascii?Q?7SLmYyuzypkPa8VDAAtKGRoZKgqUKLL4WOk7AlYQ83hGO8Gh6NhPfE6uQ1/B?=
 =?us-ascii?Q?33o+MMTYW15Eo8Yc1tNmQ/zeGxK9Zxw2S+l+KVomRBVzuypNmcGOpl7f9voe?=
 =?us-ascii?Q?0gPfOWHtKlj0zq4y7RVR+UYPVD5T6g3PUNCq/gVaMGRxB6xEgmjo7r1m6wvo?=
 =?us-ascii?Q?phpokG2Jz/rs6qcZiRZwYjiHF7YdzwDs+fS6dKqFH3IKZv5Du7ly0Kv9Rl5h?=
 =?us-ascii?Q?cmsyvF4zDjaXaK2q3680UF9mcO/S07RZrBt8mlpXDeO/zXOFtAEKfzTECGoV?=
 =?us-ascii?Q?w3++1fQ+5HnOIktxHzS54kMLT4tvKpb2qalxFS60KigVCe249mOu/kiVVkZ3?=
 =?us-ascii?Q?bmAeJSqwe8yn3DlPe6hWeW09MG1ImQ+/IMQQncDIzoWsYwcMiweqgCoA76S1?=
 =?us-ascii?Q?Fm/ruaNNZUXjH9jKTOQjsk2MsnMFDfLx3MMfeCQRn0VjvMuJMyawq70XgsyB?=
 =?us-ascii?Q?Ht3Y3XXwMxwVWpqffLQH8KwvzXVDXKwk0hg9IZbl/JoARkKszkHJLJmtsyFd?=
 =?us-ascii?Q?OxsZ2Qi5aOd1KIKTBEY6wMaS1MUa8pm4zUShOWTFUQxa5Ijem8DatITyFHxV?=
 =?us-ascii?Q?bN75YmprP+evBO+rFjX+TITwcYUStrYue703CbcUeG6dLM+sFvT0gbYki77+?=
 =?us-ascii?Q?VXKopiONolBUhMrK7rf2VGNWbpGjoT+2U+jAvXmN93rFXZ4/emT8cOdIqpS5?=
 =?us-ascii?Q?EHhI0wZFbtmuKTCxBY1Bpsvu5vAmnC4OTQj2ShyX9LMAM9chDMx7cq4GNHzu?=
 =?us-ascii?Q?8/7m1/E+h62CxjaGt7JNVfbnUwJrCMBbWEHvTbO3v3vp9/NlSMIucAoE9CcA?=
 =?us-ascii?Q?VjPGExTM26GDyCi46YzsH5qtYlewdL9nnra7sxgyKB6WJaf9io27w8BxQkxB?=
 =?us-ascii?Q?JYayA8B8rvCbtSJRXFtkMYmj5QWZm5pURjuu+r3fz/Of/SUTmEAdpBaahDVZ?=
 =?us-ascii?Q?JAmHMhSxYgi+fzv98m8JzUwZ6mkmzuOQ0JAOxaO7wXIxtgn9yLCSh2cZX4tF?=
 =?us-ascii?Q?J6CX6XOZxQNclYASFLVMm1nGN+X29x0dzzsC4IOK+58lJYEfcpzJZaAS2uLv?=
 =?us-ascii?Q?vc2m04vy6/OGIezjPdKot24jhEmbgulRe+bFYUL9GuDHOqJ6DvDWvepr83sg?=
 =?us-ascii?Q?M9pX2C/5ZrgNIFqjlcqeGOLfHhZrVUTNnptq?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2025 18:40:51.2159 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f7b6ce02-0ad2-4598-25fe-08ddaf60d0e5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002529E.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4281
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

Set memory mtype to UC host memory when ext-coherent
flag is set and memory is registered as a SVM allocation.

Signed-off-by: David Yat Sin <David.YatSin@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 16fb19800f9e..9dba0e4ae4b3 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -1282,7 +1282,7 @@ svm_range_get_pte_flags(struct kfd_node *node,
 				mapping_flags |= ext_coherent ? AMDGPU_VM_MTYPE_UC : AMDGPU_VM_MTYPE_NC;
 		/* system memory accessed by the dGPU */
 		} else {
-			if (gc_ip_version < IP_VERSION(9, 5, 0))
+			if (gc_ip_version < IP_VERSION(9, 5, 0) || ext_coherent)
 				mapping_flags |= AMDGPU_VM_MTYPE_UC;
 			else
 				mapping_flags |= AMDGPU_VM_MTYPE_NC;
-- 
2.34.1

