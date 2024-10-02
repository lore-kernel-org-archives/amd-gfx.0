Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92047CF3194
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Oct 2024 04:38:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 396FC10E682;
	Wed,  2 Oct 2024 04:38:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XBYdmr4p";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2041.outbound.protection.outlook.com [40.107.94.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 46AEC10E682
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Oct 2024 04:38:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I7C9ZCStonvimR1mBF1XO8zb1ANI9+8RF1O4EPYnJ/Saenl/aeP6Pccd7nVJ1/2sCxRwWRA0oyUSC+gvGAj7V3MYMwpV8wVJQ+jQ2MVK6fLUAaWxczerQD9iI3JihVIYvjq8WWQFQycsiXdzXo2oc1uxrOMa3fqQGyjtkwElX8bBsDmcfD++t5dAdjoL5e9tHzX5xKlvcH5atCXricXKKXyqqDRBHY+W1wINSrUcBTM1cNhJqAcj+e8jfemFwSKU+svORHhVyyBrteAoMaUjnp06wsbEHks7ibHHwl+Sbj4NdVrpZhB96cHnWEGc/spa3sHAXFYLDLyt3yOOP2sg4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vMHDUXO5xlrLrreHPa8kjApR5O/J4C/rHt4jsDvcCvE=;
 b=c86IA9fHAraED5qM0zb7Re/QtXMrEqV11tSvVWqRDegV2PtH9XlBWmjdxv/vsIyWFE6YbRtxujhANeOVcwLmIuVMcFxPhv3QqEYWuzM8UkR+fXObi7RCmZydUSxWSzF5hoRTdFLy/iXyE2nvBzSZ1ssnZuOK4jjUaDUIvV9+3rXbHLK5b0bgxim3H0vtXQ/eI6mRQwhMKrYmSxoJy+gpXy62aG+YzOywNwI+L2kyhn7rO2vsLaDtPxowSGIvXDaDNBF493YJPlgMSOteRN5CFagmkrP6Fn8VTAwmDCxWNQhAdfMSjhws5Eaw5LxoB30yCnQkE8Wf6dS5hRKvDJpTsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vMHDUXO5xlrLrreHPa8kjApR5O/J4C/rHt4jsDvcCvE=;
 b=XBYdmr4pWZyl84qHeMsxdUT30kImVh95qTG+Dv6RtymCOs+zWQS2FsJMOVVElGH2SWsU1cgj6nqULlgLuN7Hrn7KX6ZRI/YUEJsQ4UxkdL/nE7SM8QsBOw286yRg8olP/gmg1oDQnPYlqJjgkIAMvPO4hxnn3fqZjuPGk7U8MD8=
Received: from MW4P222CA0003.NAMP222.PROD.OUTLOOK.COM (2603:10b6:303:114::8)
 by DM6PR12MB4484.namprd12.prod.outlook.com (2603:10b6:5:28f::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.27; Wed, 2 Oct
 2024 04:38:47 +0000
Received: from SJ5PEPF00000205.namprd05.prod.outlook.com
 (2603:10b6:303:114:cafe::b9) by MW4P222CA0003.outlook.office365.com
 (2603:10b6:303:114::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.27 via Frontend
 Transport; Wed, 2 Oct 2024 04:38:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF00000205.mail.protection.outlook.com (10.167.244.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8026.11 via Frontend Transport; Wed, 2 Oct 2024 04:38:46 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 1 Oct
 2024 23:38:35 -0500
From: <boyuan.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <leo.liu@amd.com>,
 <christian.koenig@amd.com>, <alexander.deucher@amd.com>,
 <sunil.khatri@amd.com>
CC: Boyuan Zhang <boyuan.zhang@amd.com>
Subject: [PATCH 01/18] drm/amd/pm: add new vcn enable function pointer
Date: Wed, 2 Oct 2024 00:36:10 -0400
Message-ID: <20241002043627.102414-2-boyuan.zhang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241002043627.102414-1-boyuan.zhang@amd.com>
References: <20241002043627.102414-1-boyuan.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000205:EE_|DM6PR12MB4484:EE_
X-MS-Office365-Filtering-Correlation-Id: c2fd5057-946a-4707-8b6a-08dce29c1a8e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?G8eWhCgczEAGVS5xUBNqmzELJlBS9lXA7cSEyG7gBjNTHpCZpb3lzOPH+Tym?=
 =?us-ascii?Q?UWwPFHDxixFTPpIAeWuAkuqkvWNj0PI4/K7sTwBGKIicA2aXNiKgvyaQXv7P?=
 =?us-ascii?Q?lMzcCoBYagLSMjDi6NmVTme4qKiI9zMKYTfaGMW4LvPXm+Q/vq2MfAsFljBq?=
 =?us-ascii?Q?RfqxKcBtVamAGnJYwzte1I9CAZ2y/zXKpR1bJ2eGid1MsVVijC29I72MfzcS?=
 =?us-ascii?Q?tSJ8eth0PdmLbcEfcTYERSqcMXGnUep2FgGPllwHcn5K2boOdBQYdSriABmO?=
 =?us-ascii?Q?sCvKXZh6qEeqT1pwjbarFKpyODVK3YukDGk+PSURwc0UO4fcEb5GONnwOzE/?=
 =?us-ascii?Q?OslJGAtNw08HH3qSvYF1u6dySfMkmuczSM1k1R5tmmu7gCbSggeIVN5pt09u?=
 =?us-ascii?Q?sw8o6YgO8iuHlH/Z+395qgEeWAR9NBtdJNkgzyGJDcZRAFfcEus3ExJEVMVS?=
 =?us-ascii?Q?Dv/TdbkxTjj1XA+3pQMfkXEkq3xTkwEyHOS0Rb57G2t9pXGpfATygHQk00zi?=
 =?us-ascii?Q?K3Z8jySN9kwCMpHrYo6QEckjRG915sb+urv5Mtt07B2WA6LRMj1E8tqT8drt?=
 =?us-ascii?Q?uPGl2kCExvmN2AYVUNjekdU7sInAnvVUw3FZx4ivKv1IqxUWoGY+MOG/js28?=
 =?us-ascii?Q?579X+d8F+s4Qe6bUn/hajKvPmenvL+RbiM/mPPXnyquHs1yXxQ3Ovgc9cGk2?=
 =?us-ascii?Q?cDZxDXWNvyUB5PvRpNI0gB652XUT+6GTMX1/T/r7kFgx0IO0CjdJJs8iJ98Y?=
 =?us-ascii?Q?6I/sXkkFzkLkyWC2i6M8PbEV6nLUIndsMD5XSdLJkR9zRZLUAaDXLd5yVc7J?=
 =?us-ascii?Q?9C6BmFomD8tFhMLVFn/uGDuUMuP3Qb4B0ihMqE/kcc8fy08xniwt+hAWsCgQ?=
 =?us-ascii?Q?S4VyvNPt7V8FoTb4/v7hLykbBDS/z+Jl7mOUTGW49Uo8NaGMec/p/qeuYYel?=
 =?us-ascii?Q?YyakMraCYihTI3t5agUZmvsHrTzO+sbUpKXHgQuGirOqTnv0aACgtZF2IexV?=
 =?us-ascii?Q?DCbLNyOImgf2GG2f5m/hjETHDnVufbbVATUq/S95HZFfvlFcLh6jbACKUF2i?=
 =?us-ascii?Q?pvFk6Y0UGDNJEnTHIP8Sy/owfSqO+/jNOASVdqBYBrp470lsF02wERI/+QMw?=
 =?us-ascii?Q?7o2jdQbzGwv1SKBNFiVTzSJa6oTDIc7PKJddkvpq7B4+EadAUVE/Yz1/nwxf?=
 =?us-ascii?Q?9g9PFMiCZcnRhZZS9PXNnVuKLSc2lGVdP1CTDp/4yXE95noR1FvUW4TUIV+7?=
 =?us-ascii?Q?reD3BDp41gMFifMglXDoRSM1jwganAqt4/kVjlKM8NdBhw13c6I1msgYmi7R?=
 =?us-ascii?Q?uWDWkQQkWDQ4CW6cxELF2axSm7AC91sALnh2PkBoaGG4l+QSsZ21Xmd6FPc4?=
 =?us-ascii?Q?JG3oK54xgjkQtT9gXKEtSkf83AE+?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2024 04:38:46.6686 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c2fd5057-946a-4707-8b6a-08dce29c1a8e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF00000205.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4484
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

From: Boyuan Zhang <boyuan.zhang@amd.com>

The new function dpm_set_vcn_enable_instance() will be used to enable
or disable vcn engine dynamic power for the given vcn instance.

The original function dpm_set_vcn_enable() will still be used to enable
or disable vcn engine dynamic power for all vcn instances as before.

Signed-off-by: Boyuan Zhang <boyuan.zhang@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
index 727da0c37e06..f88241cdf9b9 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
@@ -737,10 +737,16 @@ struct pptable_funcs {
 
 	/**
 	 * @dpm_set_vcn_enable: Enable/disable VCN engine dynamic power
-	 *                      management.
+	 *                      management for all instance.
 	 */
 	int (*dpm_set_vcn_enable)(struct smu_context *smu, bool enable);
 
+	/**
+	* @dpm_set_vcn_enable_instance: Enable/disable VCN engine dynamic power
+	*                      management for given instance.
+	*/
+	int (*dpm_set_vcn_enable_instance)(struct smu_context *smu, bool enable, int inst);
+
 	/**
 	 * @dpm_set_jpeg_enable: Enable/disable JPEG engine dynamic power
 	 *                       management.
-- 
2.34.1

