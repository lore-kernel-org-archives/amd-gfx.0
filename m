Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB924E7717F
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Dec 2024 15:54:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6B18410F06D;
	Fri, 13 Dec 2024 15:54:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="UvydRQL0";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2081.outbound.protection.outlook.com [40.107.243.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E05EF10F06D
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Dec 2024 15:54:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L2OC2vvQvWbWeF/s3tmrR+wPhqBXZErboYgWsX9jVgLJpOO0tm1Zt/olSG3RghQdH5WIk4fQmRXGZXYYlc2KEVGi0AZQy0i5ld0r5WZkU8J6dxZNLFnsFaQO9u3YK+Uj5DP4nXCuB8O+8eVm4HEl5ivGLFTPSmbLoachZ5mLt3HV33aSroG4ScHRAQmHDGRwLRAILCYUL+KBK8ah6bo+otdNCe9lMsts8urrWuBl+9Xt4OCjij5NhVweEjNNquh8OfGDIf13d7ID7X2GbECmjkbqsba+UHLetxfPl7gOb+PIoWXpBgTqhzsHo4bbNGE2cVptQU919Nql+92bbtGhDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7VH6GIFrPIEyZe+CZJ290pI50voQUkI7YTAzkserGPU=;
 b=R+KSpDNDcdndYN//DU0GPlEbF0Bv5lFbtF9s/LV0OTuGhAc3SA9dYieeM9HP2aHesHxIDSRJYWdfhvF/rnACVacVYT8Mg7lb3cWFc14UjZhDyMHxM/ZnoDedRN6rHNg9TjnfkWYTk2Cq1m9kLbtDMLHsN4IBoznGqR/sIXzDAEahO5raQweaBrzYjln4JN4Y9rjqSjSY4DEgbe1hHAhhdc8K9tlxIyEnXmfacznaDN9b7SML1IyZyR7E9EIAv3q+mAoF5fta50mfodqt87mn5Q1Qv9FL2cn+O15W4aCNSD5BkVZwhc7Kkd6cK8bFI2g1qP5zAjlpMnXKfinxygHRAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7VH6GIFrPIEyZe+CZJ290pI50voQUkI7YTAzkserGPU=;
 b=UvydRQL0LHQc31cSE+jw4WQHLoFFYDY1RZ5g+FcMjgaX1wg1np/y/RbEuRWqyjt+6UeIdyXj6trSFJLL55nd/TBzSwOdCv+PpYDLuYHCgCVZJMFTudLa+BeF+2r39CeUsPYn3y3pRUtsB1Sz1RswvjatsLx+pShMLe0YXQxabHI=
Received: from DM6PR03CA0087.namprd03.prod.outlook.com (2603:10b6:5:333::20)
 by MN2PR12MB4272.namprd12.prod.outlook.com (2603:10b6:208:1de::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.17; Fri, 13 Dec
 2024 15:54:45 +0000
Received: from DS1PEPF00017095.namprd03.prod.outlook.com
 (2603:10b6:5:333:cafe::97) by DM6PR03CA0087.outlook.office365.com
 (2603:10b6:5:333::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.17 via Frontend Transport; Fri,
 13 Dec 2024 15:54:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017095.mail.protection.outlook.com (10.167.17.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8251.15 via Frontend Transport; Fri, 13 Dec 2024 15:54:45 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 13 Dec
 2024 09:54:42 -0600
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>, Wayne Lin
 <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, Fangzhi Zuo
 <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu
 <solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Charlene Liu
 <Charlene.Liu@amd.com>, Chris Park <chris.park@amd.com>
Subject: [PATCH 04/17] drm/amd/display: init dc_power_state
Date: Fri, 13 Dec 2024 08:52:36 -0700
Message-ID: <20241213155405.393252-5-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241213155405.393252-1-Rodrigo.Siqueira@amd.com>
References: <20241213155405.393252-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017095:EE_|MN2PR12MB4272:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d2f3d29-7516-42f4-e9ba-08dd1b8e7715
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?MxtXlgTEdNLpOi3Dd5akWRoyOBJizl+c5Uhihwy//0SDWVL3BW44MY9ajCVC?=
 =?us-ascii?Q?fB36EQg8EatxmBvmzNUngPedYKP6VmbyWgs5iPrf8pdjF5A0kDLnNCWlHz+J?=
 =?us-ascii?Q?VIlC/o+h+0oxafDAabo5GxfvwfH6AmRO+mnlyhmkvC5mvBmrfpXSti0fBOwn?=
 =?us-ascii?Q?Qqa3Y8mcSPBmvTJpl/lVYbPgIpGc1YZWkpsnIrLe1O1Zl4j0rSr8gT5bed6q?=
 =?us-ascii?Q?bHqV2CKXgXULBnpuH7o+BKqTuC84RCsBLl7zfnGf53SA5jdj5+Q7VreMXNQn?=
 =?us-ascii?Q?nw9CSxRQEEV3CWrvqsz0i+zLFfTBfOnrjiiw3ES3CYulJWI/gLSSgzoqqvhE?=
 =?us-ascii?Q?qAQm7zFVp6fxjFf6/TLhWK7I6GxzXjAoYCaqPYu55g/b96obZ24PDl9kKDsM?=
 =?us-ascii?Q?e40dxhdEu1+kdjBXb+SnJR5DvsdMCUX/cphxLMVEQFm26nhQ+s8ZL4Zy/Qed?=
 =?us-ascii?Q?JYDzXmF7PBmh63FAqaIVgBI4TxYXKfchqacnMW8qGLBc0dJEWoLp0tRC3MN3?=
 =?us-ascii?Q?JGU3cX0eFZBkM+f6Cqdz5WJYrUJtm6S+1a9gK+hSgKGepsiTTGxfub/rkrwf?=
 =?us-ascii?Q?VhI3YczakXN+/gFQOsgm0RooK1cSNtDaJHY8eEeRrlbhVme/hcxbocMEfl0c?=
 =?us-ascii?Q?HUGMDFCYMmU33asL2HINHBsgyYt2fLzugQX5Ix7L6s5XTxMnjJsSdo+1vUT8?=
 =?us-ascii?Q?WbS1C4HTo390i5aQrrmSS4IQwj2t6VLv1JZe752hxtcc/fcNmPRDoxnjuOno?=
 =?us-ascii?Q?3bWO7BMA7aqv0TIrwWIIXe6e16LUlM78EsbiF+4hryPK9wismJ5O+LIkfakV?=
 =?us-ascii?Q?oFfzEhCSHC5khE01ED5Cx0bWRieU7VzW6bkCLOy0lxgRLuwuMAZd1OJnpc9S?=
 =?us-ascii?Q?ii8sK8tTyzY9qCRTN2MmK9Z0VJbgJGAeiKjqiYIada5ytp7wcROcDuWSIXHM?=
 =?us-ascii?Q?cNBd2rZEsbpze9rbXiltdZLtSKyueXRhk4EWMl29LNR1yOxXcSBlvQjBcTBM?=
 =?us-ascii?Q?GK4ct9b6URO2hKRHC04L/E8wxIzbstLZJvs4JlLIAQPIFtn7E2K6ynaapY9e?=
 =?us-ascii?Q?38iIrYq0ktLXBkzTziQ7SjXnxzwwRaMm0stJt8iqwsl/WPmFw/ONRktpeUhp?=
 =?us-ascii?Q?JRP4txbISn4NtwqZgC9N6WuM0Wq61L+49nD7fVuwatgDsG7ykgp+ubuHdFjL?=
 =?us-ascii?Q?GXCxIJ5jC9yoqT+bGkU2DYnx8HdRUSI2UfEw/NvtTcMHxjciwwacDRrXaOoX?=
 =?us-ascii?Q?Uy3fQO+PuH4Ub3sKRzbCXSLltt3P+54o1CMHoYf2PsZ/M4IKOjuxgRTkMQYE?=
 =?us-ascii?Q?YF84p18t4MgN5g52Nz2JGt3y24zoLbC41x3IFdcgpXbgCe8pn4q/2dzXW9Hp?=
 =?us-ascii?Q?Giq1VmNg48XAdHF88nipjsKWLzvL6EKGjPyEEGXDgY/YgYcQfGS53ZwI2zBw?=
 =?us-ascii?Q?EF9RoJNuM/dgtPqG1Jj5z8n/Rvrd4kJP?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2024 15:54:45.2615 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d2f3d29-7516-42f4-e9ba-08dd1b8e7715
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017095.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4272
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

From: Charlene Liu <Charlene.Liu@amd.com>

Initialize the power state for dc use

Reviewed-by: Chris Park <chris.park@amd.com>
Signed-off-by: Charlene Liu <Charlene.Liu@amd.com>
Signed-off-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 4afab745b044..81f5996f2edb 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -5311,11 +5311,13 @@ void dc_set_power_state(struct dc *dc, enum dc_acpi_cm_power_state power_state)
 			dc->vm_pa_config.valid) {
 			dc->hwss.init_sys_ctx(dc->hwseq, dc, &dc->vm_pa_config);
 		}
-
+		/*mark d0 last*/
+		dc->power_state = power_state;
 		break;
 	default:
 		ASSERT(dc->current_state->stream_count == 0);
-
+		/*mark d3 first*/
+		dc->power_state = power_state;
 		dc_dmub_srv_notify_fw_dc_power_state(dc->ctx->dmub_srv, power_state);
 
 		dc_state_destruct(dc->current_state);
-- 
2.45.2

