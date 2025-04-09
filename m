Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77C20C36002
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Apr 2025 17:06:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DF5C510E040;
	Wed,  9 Apr 2025 17:06:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xecBTx3m";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2089.outbound.protection.outlook.com [40.107.243.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7ECE110E22A
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Apr 2025 17:06:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FADd/6gFNWCMGD8lQN+ehOqOit9N3+WtBuSr9wyM+gPJfB3hYURC0IepF7nglEzRHepklVMTAUr542UzV6a0HFwITo4tivMioVae7VIzh+TZHb33E7SdmILnag9PqD9m/am5dAm6srQtCZBqCyLmr2mG3ok+keEySfVxUZET9liOxwtmc5gi08ZjBClHO9mIMStgHEsuptYk7eipYNfx3ordRDD5TPEI9l8fxCsIkn1kAdicBRG9SGoVcFTKuZSHEmLP6ruE/pliQ1pad2SEMZjsdWH8XRb+V3XsbE5L7vmgfN5V7PeAtKgkGZEFI2km6gn9utmL7k6YsLQyyefHtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=md1TtA3J7hY+WhoU9Cxc0oCBhTl/bnq930m8ckWw9Vw=;
 b=oNq+9c6fmTgosAeWamAq9QsQB+Um1JeHCpEkoPD5itHmNlef7oSfrj72kL3XIVye4BvG8BTsl12Cj7xemrgHfCyvXZASSItbvOgxqjiYaxNhDkJ0SGjyYWoMgdJbkTiida3P14r76oDz59GTsHDbMoT+5RRwiwXJ4nb+KKjyAHteBwHJc3YK1jkbLahmM9pNOHW7hRXUSDfcb9aAP7s+WVzqlNIpPG60WcTfl5NZHfV26CIr8uy92lOXwd2EQJND+wH1WNHjaGBEEx0hDGx8vfnaw0BwrBZv8ZkzNGedilTY0O2AdoQCVETwp8C137vWym6uzsNVr/1aDlqDUdoqQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=md1TtA3J7hY+WhoU9Cxc0oCBhTl/bnq930m8ckWw9Vw=;
 b=xecBTx3m9/f439f6xSAIrbNSzH6BeR3xVagl7fgJNNsJHVRCh3Bje1I/fjbKEwpPPxTKeX1yy5r15D9Yu8E9Fo0TJVI9nt/uD0CrNR/gvN50deka0NuEnIeRIII179cXI7ivHFxSW3KhOp8kBHeRujq2EexOyyWgyC8H1f02BuU=
Received: from CH2PR17CA0021.namprd17.prod.outlook.com (2603:10b6:610:53::31)
 by DS7PR12MB6310.namprd12.prod.outlook.com (2603:10b6:8:95::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.32; Wed, 9 Apr
 2025 17:06:04 +0000
Received: from CH3PEPF0000000D.namprd04.prod.outlook.com
 (2603:10b6:610:53:cafe::98) by CH2PR17CA0021.outlook.office365.com
 (2603:10b6:610:53::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8606.37 via Frontend Transport; Wed,
 9 Apr 2025 17:06:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH3PEPF0000000D.mail.protection.outlook.com (10.167.244.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8606.22 via Frontend Transport; Wed, 9 Apr 2025 17:06:03 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 9 Apr
 2025 12:06:03 -0500
Received: from roman-vdev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 9 Apr 2025 12:06:03 -0500
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Alexander.Deucher@amd.com>,
 <Dominik.Kaszewski@amd.com>, Stephen Rothwell <sfr@canb.auug.org.au>
CC: <Harry.Wentland@amd.com>, <Zaeem.Mohamed@amd.com>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>, Roman Li <Roman.Li@amd.com>
Subject: [PATCH] drm/amd/display: Add htmldocs description for fused_io
 interface
Date: Wed, 9 Apr 2025 13:05:45 -0400
Message-ID: <20250409170545.658494-1-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: Roman.Li@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000D:EE_|DS7PR12MB6310:EE_
X-MS-Office365-Filtering-Correlation-Id: b1ae1b36-8596-4414-b9ad-08dd7788cfa9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?oMjAjWKtoRWeEuii7SeaS1D4qDdH7VsuxaBYSOW64iESGD8PELCgQGPrFr4V?=
 =?us-ascii?Q?ufxJjCR2CZEzpy/LlnlxLHcLouYxDN2Q+uT7nyfyG+t++Sl5q0QqdXRFSNX4?=
 =?us-ascii?Q?+ygPy/49FX/WipV6a6NR8PTRFNScUrZZCBYUAwq4LZi2i8/n0e9m+st0V+tf?=
 =?us-ascii?Q?ICiG0JgJk9x9SbQ1C5o80iNnVgEJDtgv702AdgjCgtEBu6zJcxx6Lg+eDR5/?=
 =?us-ascii?Q?KyOpGgp3T36LAtSQyNCIOgTITThLLacVxjrW0i/hjFsR+X04VVHVvNyVA7NG?=
 =?us-ascii?Q?4M3SJRjjlXucKhYKEyzptl6RfqQUM53ZXU14nP8gB2e97eipAI3Og4Uk5EPd?=
 =?us-ascii?Q?IVyvmmabKcUlzYlXlTrrpXQ0dQz+1qLp3FiCpq7qb/2zafVNs/kjz3SgzIFj?=
 =?us-ascii?Q?fNkysCaS8PNV1wm9QhF0mMUa62FPj4QiPCMOBuz8FwYkCsOPkFfJzyxPRDxm?=
 =?us-ascii?Q?tBv6HMPUpEZqVMLlLo9oV15RRthNENcLL3xMxcdYoiqmK8EqPUBWEqCS/nAv?=
 =?us-ascii?Q?TLsj7krctrTDmgrZ70GqfjwXqAPiGiyrJdCGVM51dnd3YWhB9tRe1fTubMrP?=
 =?us-ascii?Q?SzDfj1siz2tZJcCFWSWFJlrUAADPZjw/lKl2b99KnEWFQxR0R1qYEOu/D3Rf?=
 =?us-ascii?Q?PAk4tbZVrjIETNPAJ6Q5F4QpuEYi1GfSGO4nAqidy2JPT6Gyt37gnEZNovL6?=
 =?us-ascii?Q?/88u9MQBBcGhDhy+85dA+HZpALaB5nAkhDdsU1DR/fJMnDJAYZXapSJbwwVW?=
 =?us-ascii?Q?soTvAkZAsWqBptmkd2chz1J9xP9wVdsYWf5ZV6sbWLkHoR3HQLlNvcAXGCLz?=
 =?us-ascii?Q?fuk/+s79xU1bwPtXgcE1ypoFoRBmi2y7ixR4w2GgICHW6sAuDkXbz/0S4MUX?=
 =?us-ascii?Q?JxanhdiRCwZOVOcmQDh715xQXVBNwEeYWgay4YcMelvTQfkY0VEhO+qK/dEF?=
 =?us-ascii?Q?gY2FA9MR2ehIOg91MB0X0Be9JXQYj5rvOewzlmvkkcQzfac54XNb/8fKgk7D?=
 =?us-ascii?Q?SSBQCcnqzZ1npOpL1m6cTiizkuNajIkngW9Er6u6dEIHJbaKFqpiNCrwGWz3?=
 =?us-ascii?Q?Do4aCRI7Y1K4UsLekjP1KZ1l+K4HAKglbMftKz7QgPgq7hjxZwaYnQafCbRB?=
 =?us-ascii?Q?rBVPPttzS0Gn9tec1XqBcPx0FgkvtuAVHg2nMSPbQszkmeOh3wRRz6eYAFRJ?=
 =?us-ascii?Q?TGz11Et4dZOgqA9pZ/j4AZuho+9kK3Se0pgMMGaBE0qxiA6rx5oNts/7oHLf?=
 =?us-ascii?Q?dD8TbGVuD0NWv/JQROWvEUciZSsQZQrLECDyXyIqLLAA6ZU/WZmSiorafceZ?=
 =?us-ascii?Q?Fhdr1wcLhKyvjqwtNeLw8BeHNTVhI6Ztv+X21rc/Qj8RSv9JbatvJgFBXTZ/?=
 =?us-ascii?Q?icoigb+GHaVMw07YW+lzylXmjAeFMJhNgqexFmp2E0SSpwNaf36NgE1uwvax?=
 =?us-ascii?Q?Qxxx7IV8wvD+4io4kaAXwL4gcbhHHF9Eg4x4F23USNmuoX2I8XXDiRkQiS2N?=
 =?us-ascii?Q?jaNVNRGS16Qo1S1IwONu6HvRp1+FEk5KRdlI?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2025 17:06:03.9117 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b1ae1b36-8596-4414-b9ad-08dd7788cfa9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF0000000D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6310
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

From: Roman Li <Roman.Li@amd.com>

[Why]
htmldocs build warning: "Function parameter or struct member 'fused_io'
not described in 'amdgpu_display_manager'".

[How]
Add missing description.

Fixes: af632d3f59e6 ("drm/amd/display: HDCP Locality check using DMUB Fused IO")

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Roman Li <Roman.Li@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
index f84d6cd4f733..bf2839bb80db 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
@@ -639,6 +639,11 @@ struct amdgpu_display_manager {
 	 */
 	struct amdgpu_i2c_adapter *oem_i2c;
 
+	/**
+	 * @fused_io:
+	 *
+	 * dmub fused io interface
+	 */
 	struct fused_io_sync {
 		struct completion replied;
 		char reply_data[0x40];  // Cannot include dmub_cmd here
-- 
2.34.1

