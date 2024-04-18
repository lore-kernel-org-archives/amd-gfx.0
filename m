Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4B91C4345F
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Apr 2024 13:58:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2BFF9113CA7;
	Thu, 18 Apr 2024 13:58:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Epjwne/k";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2074.outbound.protection.outlook.com [40.107.237.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CF66E10FC8D
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Apr 2024 13:58:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eiK3Ksk1PWVzpSXTQDFsa6Sxo/fu2ItQfII/yHHt/hOd2WGq9uicZuEmfsFN8FSBCpaMJj0LzBIbQbQG8VwbLppviR0SzjWrGi6+4eXvdg3UQJ8AJIkraVYUfInBFQ2y5+eqfoErJ7Nd9CIMcM8tWvblUKKXjzWj9Tx/N0sI7xg9srUZYfsPzElgDpIHjfCWB6uVi10OGrn+noK7+52KLCOlLKipjK+5XUTqjci6Z0xZUstQnsYcAiZ4MgtNAtYO2R5X/v5U+k0fo4aMCayq+8a3xooHuKsnsrVhE1+Q4xjO+m4WmNGv7uTHjIEJ4LPd7Wv2W7jq5Pm98PJxdK1MsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ihOHjrIX6J7gtqiEtbuyb+wURe+2oQhDrzT/T9fjFkg=;
 b=YgGZS53x5v1OnuJsmE2bwrfCen+XFTnRGY+fVPtBnXAX34lVoWwWr7fP0FK/++yq00FZfeY9d9iVsx/oOq7J5IkzA2K/MJbGAOOI/ZCfUyf1nByT8zkR3kBtnVYLtHi3pfEc9UoDF9tWbaWZM0RGWgRmgm5IYa1HZebeeaezS2xgsXj1Zd7OlF0vRCLHkmU860QDJkaU85l5zaEx3db3m0tnKaU8Pewe1DV/wPUkl6agvXEfKjPT/CieGCVMTOVb7M+dJKyWwmK5c1QxL6RV0yB5CfDLJ/XD4yMSES4CMvQLVXw2/qNTiZPxFc8DtYxuld0PgqTiMFRzoh9aRQV/Rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ihOHjrIX6J7gtqiEtbuyb+wURe+2oQhDrzT/T9fjFkg=;
 b=Epjwne/kMWsjjZvgm8aRBkeLbToWbA3vmZlEB+2LK0Ak3lVRqBZPH0g2P78FF/iEKxOHii5THAeuS77PCURLH3n9UySxBdFxzhSkaRRZ3kMzPKOQmVaewLOfLej0Hm1RuBqXzvyAJ9cp29J/29rDqqxIE8jd0KdKBsB9Q72ghvE=
Received: from MN2PR03CA0020.namprd03.prod.outlook.com (2603:10b6:208:23a::25)
 by MW4PR12MB6876.namprd12.prod.outlook.com (2603:10b6:303:208::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.37; Thu, 18 Apr
 2024 13:58:41 +0000
Received: from BL6PEPF00020E64.namprd04.prod.outlook.com
 (2603:10b6:208:23a:cafe::94) by MN2PR03CA0020.outlook.office365.com
 (2603:10b6:208:23a::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7495.29 via Frontend
 Transport; Thu, 18 Apr 2024 13:58:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00020E64.mail.protection.outlook.com (10.167.249.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Thu, 18 Apr 2024 13:58:40 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 18 Apr
 2024 08:58:36 -0500
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.Kuehling@amd.com>, <christian.koenig@amd.com>,
 <Arunpravin.PaneerSelvam@amd.com>, Philip Yang <Philip.Yang@amd.com>
Subject: [PATCH v2 4/6] drm/amdkfd: Increase KFD bo restore wait time
Date: Thu, 18 Apr 2024 09:58:01 -0400
Message-ID: <20240418135803.17365-5-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240418135803.17365-1-Philip.Yang@amd.com>
References: <20240418135803.17365-1-Philip.Yang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E64:EE_|MW4PR12MB6876:EE_
X-MS-Office365-Filtering-Correlation-Id: 55064865-76de-41c0-cd0f-08dc5fafa732
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4JaljSopKqeBLYy7Vt1gWETIrothFkAYHCfRPwiIlP5lqlVr+7sXY+63pWKAkmQoJRmDrrn2EoglKUgn5Jm6vi4w1x2lkZvQrnI5xbd8WYxnv/yKp046GdzujEsUb6SGBCeUYbglkCsTV8CIilMnfuwmepm8zA9SXgJ0xfDsvdVyHLvNFt6C/jj+fFhLQ6UvAVGg3Oqi9ZVrtobaNSkfwGrCqHbPItK4+yfjVN69F99xNm4jIohxoY+24wZdey95026Iew41gBuETavZ8XLNJQP/dUAha6qAtlYl+dHFh67Ag1J1MB8v3TYiqJWiQHC31i8eV6RgOHbb4PF4LIuJ9OKaysxZ9GVPHjmS0BhBcNUFGxj3XFzZGA2LmMnITtgd6HrPqHake933D7nVussif86F7bTHbyHQz9xuKeTU6iWqq/eFNqYBSdCtbCdMYxpPExlL+UFRmnOeccKCZMnm9cWEbLFkanSFviJT9ZgKvIsQf4gHJ3aS23E2SmK6Qy4J84UpeHf+b4LV2Cp9ggvRfnSi+WndtEO0UrXTXpv4gsLdMQ+31JkWHuipexNICzOupjjPictVQBh0xJ2ll8RG9shFpCZeP0vq2t+uDB1MYSEtkNV75LSQ21qZ6hmbYh+mxFDQxieMTDrQLmsGAe00+x1b9Hp1BKC0pCPu5QnZ2LwsRrQejrgfFLed2Z0Nsn5V0Vu3b8N4aWWYjZzqXd+om4Rex/wHh5vaLsqx0r7VSy6wzoTJQzJiX96WpbHr+907
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400014)(36860700004)(376005)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2024 13:58:40.7245 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 55064865-76de-41c0-cd0f-08dc5fafa732
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E64.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6876
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

TTM allocate contiguous VRAM may takes more than 1 second to evict BOs
for larger size RDMA buffer. Because KFD restore bo worker reserves all
KFD BOs, then TTM cannot hold the remainning KFD BOs lock to evict them,
this causes TTM failed to alloc contiguous VRAM.

Increase the KFD restore BO wait time to 2 seconds, long enough for RDMA
pin BO to alloc the contiguous VRAM.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index a81ef232fdef..c205e2d3acf9 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -698,7 +698,7 @@ struct qcm_process_device {
 /* KFD Memory Eviction */
 
 /* Approx. wait time before attempting to restore evicted BOs */
-#define PROCESS_RESTORE_TIME_MS 100
+#define PROCESS_RESTORE_TIME_MS 2000
 /* Approx. back off time if restore fails due to lack of memory */
 #define PROCESS_BACK_OFF_TIME_MS 100
 /* Approx. time before evicting the process again */
-- 
2.43.2

