Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E839D591C4
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Nov 2024 06:36:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AE05F10E5C9;
	Tue, 19 Nov 2024 06:36:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="lFdQaOIY";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2084.outbound.protection.outlook.com [40.107.244.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4DE5610E5C9
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Nov 2024 06:36:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HpC7vm7JMsDrN080jiScjNcXZmXJ+eT8UQbe1pWyEdK9x3p3Zczh675CPeDFhcpbGB/QSTyyWEAoNXEZg8PN9NB+bkIvS23NrB+62HyIEZPQDUeQ1UZeXf5me0UJmbJDwghxTp+2vIl7lapJfTi+nAZm0GuRQjWWLn3NvkTGr4W/h2Gx2AIMV6AurrW60BD1I9cLzDfLWxB02S4AmaPGDh9Q/ubyWlYR/GiZnyqL6T66FDC5WZ84ttCaJfXaZDV+ZQHQkuDOx+4Jly13r+JmomxBzDxPH44VwY2BhHFULRoPS66qfgsU7o3vx9e7uLrQ7qyv7i3Euod/eWEqC+7p6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vv7xJA/sf0SU16KRFaA9/KlsBK5JhjbFXna3UlOZPb0=;
 b=tNdt34wxonZm5j+iSZEDyqXBkV5LuFb/IT7K1nMP+yIYKYIRZelcjXjy1Pwx1U7/5QlEFTLfdvcXWG1UB0OjIol4uf0Ve5rxZL5pJG1TGEz4pYw+Pb35tA0uJ7uz+GByj0FMRw3EPMytvRG6zlIQ8ydYxdfgPwzDAnZaIsLQIcLmzZjcI8sFkbXH+rCeqeGH0BI8867EOzcslxHYThzQG/SEU30DPnOn1AhsYFpAWP6Zr1yOAbbxvyeM3vciO0F+adrm2ExJxD8VJFl/YtYWSPM0tHa5r9tzGWEGkZCWEf9hV7YuHQjf7qHcrIBc8z6eurjvfIcT6zr0ql+4WPn+pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.12) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vv7xJA/sf0SU16KRFaA9/KlsBK5JhjbFXna3UlOZPb0=;
 b=lFdQaOIYUDWMdC0zv4MKMLH7O/HC3LSgmaWhuQahAD5Zhk00q9xuWUE3t3+RLHAS9BPgG/unf9Rh7X4C/FJkJ0575lQXK9I1HnE3qPF+KDfmi882XTOcyDC5e+o7CQMz9v37BkfebcpYWfgFso0Eri82P/jqMZMFxcWiMeuaFMY=
Received: from MW4PR03CA0052.namprd03.prod.outlook.com (2603:10b6:303:8e::27)
 by SJ2PR12MB9006.namprd12.prod.outlook.com (2603:10b6:a03:540::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.22; Tue, 19 Nov
 2024 06:36:34 +0000
Received: from CO1PEPF000075F3.namprd03.prod.outlook.com
 (2603:10b6:303:8e:cafe::a3) by MW4PR03CA0052.outlook.office365.com
 (2603:10b6:303:8e::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.24 via Frontend
 Transport; Tue, 19 Nov 2024 06:36:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.12)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.12 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.12; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.12) by
 CO1PEPF000075F3.mail.protection.outlook.com (10.167.249.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Tue, 19 Nov 2024 06:36:34 +0000
Received: from tao-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 19 Nov
 2024 00:36:29 -0600
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Tao Zhou <tao.zhou1@amd.com>
Subject: [PATCH 07/21] drm/amdgpu: add TA_RAS_INV_NODE value
Date: Tue, 19 Nov 2024 14:35:50 +0800
Message-ID: <20241119063604.81461-7-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241119063604.81461-1-tao.zhou1@amd.com>
References: <20241119063604.81461-1-tao.zhou1@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075F3:EE_|SJ2PR12MB9006:EE_
X-MS-Office365-Filtering-Correlation-Id: b9624899-9b2c-4ab5-f7fc-08dd08648314
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013|3613699012; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?lc+hJCU5DYHIvBNmNsWNlI6859MIlE7vnfCmveC5zz6/XyAXaMaLHCHSNujB?=
 =?us-ascii?Q?uN68Ox3zqJ6svUKyxnLxtI1hm2wH9uyNOD9VZD+uaBwLOKdObv4qlZBaD5H5?=
 =?us-ascii?Q?JkAPLXe3KwMCoPEO9FK87SQcVL1QOltovPHayTmHzSKATQtJyr0FfIy/bDjE?=
 =?us-ascii?Q?rhcZr+igY7pPmYuzyF0RHzX5ilv/ycGDO56slU+2gXc/rXrnj+Piwl+SYgVi?=
 =?us-ascii?Q?3UmTlLM2xPrFKafYaYPWwHaHJPhA7sn6ggCpC2Cltd8v6UzTTlk/wkuiUIBv?=
 =?us-ascii?Q?otLqUtHzmqApVneYG0vJHlDiTvSU+7SvUpoh448rJLWP53ziRo3MrvMh8FPq?=
 =?us-ascii?Q?Cuob7ir2jFCOxH7cC+KWwothr4xPmQctVzLCHMq5Kwpig3D8R0thftSk1ul0?=
 =?us-ascii?Q?mK87Rl9H+q50NYuIuLdAGRlLJDtMgdUtGOSF/mFaWidb7Nbr4ngznjf18D10?=
 =?us-ascii?Q?pCRI9LWE/itNi8oEAD/+O5u7s8KG9y+9qrWXdOKe7IveDLIktN8Xqdah5l+m?=
 =?us-ascii?Q?Z9TDydxv3GxKROzjFNB2BP3MQ1utaRmtp9PVgnihpmbvltopwUDhzQ63B6M0?=
 =?us-ascii?Q?XHRjVZ2NjO8SCEOIG1GaV4TmHXFylEiQII9vZeLJ2IoCutg0MR7LaF8fWpdP?=
 =?us-ascii?Q?LXUa/679j6lKW1YunmhcBgNoYoz+yc50i6etK78Lgr1xfprR7wW1pxomzA9i?=
 =?us-ascii?Q?pRN3u6jQ0nN0wiDqNENvfAwKqHiW+ZBO0vf6BhnMB30a5b1T3o5WkAZbKp3l?=
 =?us-ascii?Q?CQjsmOHOnlM0dowgfqbSVwsQggBKxZeqoYvPj7v18gV15W7NJkWQqjvfFw40?=
 =?us-ascii?Q?zZTblgiQO3BSPsaEnVRymjBNx2COL2SfoUpg2lAjzLZr523qI/o5C19XIgdR?=
 =?us-ascii?Q?MEfIvgC69GK+kkhPsVkHO+x2QXSiKSkN3E25htxbXU+UYI8BHjKhcgPuB/PU?=
 =?us-ascii?Q?6V80gYxUNWGjCIvu9Dk6+YdDhf6rFSlVyiEnc3SeHFxYifVoXJwem8SJnY8B?=
 =?us-ascii?Q?vxvVIAgLILtMSvdVGkFZhFvrjhklp7AUV1R28QJB8YHnPlhxG/z4xYZOrfM8?=
 =?us-ascii?Q?ewOHe/VQWgA4m0crhbJ56SUDkmXCOMCrCSYQQjnxtYzCJeVkZhJFvZRQyRlS?=
 =?us-ascii?Q?No6NndUiAH8DqwFPHxX81gZM3bXmX4P59WQAAMfxeuFdMS+2LmIPJZexYQ14?=
 =?us-ascii?Q?BOJU/hpmT6H507mGWHMuOigLPpMNsNJjsXXu6x958JAoyXLQFfxfSXEo5Vzz?=
 =?us-ascii?Q?li9gBhZ2kLm+NRAaGqqVd4XF8DTQkPcx3Z9bKO/MtVvQ4eKMFFHLa4A2UHCj?=
 =?us-ascii?Q?qt0BLTUVciyuWZapLRT1hIFT7xfPwLgEeP7v8FvctFfrGAyi+l/90xvob2vm?=
 =?us-ascii?Q?+vbvgl8/rbNOfgh3HbzFX0IoJHglhmtRp8iUu5zZgZZaTDldsmYfcbwsP9Ss?=
 =?us-ascii?Q?n2hcaOqVt4BgaSzlRzk6MNLCmWfsde9m?=
X-Forefront-Antispam-Report: CIP:165.204.84.12; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:atlvpn-bp.amd.com; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013)(3613699012);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2024 06:36:34.3544 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b9624899-9b2c-4ab5-f7fc-08dd08648314
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.12];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000075F3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9006
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

We can set UMC node instance to invalid state if we use global channel index,
and RAS TA can choose UMC address conversion approach by checking node_inst
value.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/ta_ras_if.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/ta_ras_if.h b/drivers/gpu/drm/amd/amdgpu/ta_ras_if.h
index 21b71a427b1f..64891f099366 100644
--- a/drivers/gpu/drm/amd/amdgpu/ta_ras_if.h
+++ b/drivers/gpu/drm/amd/amdgpu/ta_ras_if.h
@@ -30,6 +30,9 @@
 #define RSP_ID_MASK (1U << 31)
 #define RSP_ID(cmdId) (((uint32_t)(cmdId)) | RSP_ID_MASK)
 
+/* invalid node instance value */
+#define TA_RAS_INV_NODE 0xffff
+
 /* RAS related enumerations */
 /**********************************************************/
 enum ras_command {
-- 
2.34.1

