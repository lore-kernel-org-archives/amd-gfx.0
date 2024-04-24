Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87E23C4345F
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Apr 2024 08:41:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 28220113931;
	Wed, 24 Apr 2024 08:41:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="TO/+wDBL";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2066.outbound.protection.outlook.com [40.107.236.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D842211392E
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Apr 2024 08:41:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KU84OJIrTF9khibCpPzwfiDQs+Q95vursEXFgMP9HW+D7hvz8QP+zYgvJslg1qlTg1faUjWpCv5xUkAARtNjR+092vB/KfPEbj8AJWfRRP5iI58JBo7gI2BSjqRlmc9QAj6z1PIBUSh4jNkExHHxAhOqOk9MyQpUet/Bb2AcLu4r4HBarStPXWcfYcAqG4ltUl2Vgh2aKO6ZANxAQFN8IZeD8ySZnILDNzUeCwuCop3AVOTfqfO+7mSVt2X0LbuaV0t1n1Kl6s6ljRSrrDOuU6scbsV0y3ZRyMXW1E8A9HF8I9dxE2ZN9knXAys37er499Vt9EYywlDYSxG+Z8qmtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R9clcYwajXF+9admqAdcGOHbvlNtS+ZBsMiJ++65zIY=;
 b=YFM7R5MBxBx6ssCKwfXgYBOnrZyGRLlMiCC2LxvxMx+UMyEFPtHFJf4EdIExyjjszPs3Cd0W+I47h1FFa/aYRvv/VKcBobMeBe4eMwLF7GIFKz2E4LogCeEK4pXtjmLsp7DwDhgMHU6Sz41mvSGEmokT8s5PqdKK52754s7AXdeBZfwHXyWdmwaGCPUfqCBHFyCK91oR1j/eASRNtJVuWCd5uJeyUrpkCyV+neDJhLbp/HTT9xQ+741pestQ8qrJQzCWXGT78O7XpkNnTFEkHqSKvaAvWdudTXjYEEsHKQDCXw8x61WJOt3EVnU4g7jZRos4H9Ir6YGbVZDqujArVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R9clcYwajXF+9admqAdcGOHbvlNtS+ZBsMiJ++65zIY=;
 b=TO/+wDBL8SkJPtGyTJ6N/LG1iZmpqkVaSs9m6GP3/cbcJOfc0SPPDiW29UnF645kMwr4qP3zcNykOCIz5WBQv7rymlU6339e2QnmbfRFOW3j9InG30SwIeBbIibyRp0Fdo1HgntJU+Wp//jziQHAWGCIy9+eJ2P+XsoRRGdhfIA=
Received: from BLAP220CA0028.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:32c::33)
 by MN0PR12MB6223.namprd12.prod.outlook.com (2603:10b6:208:3c1::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.23; Wed, 24 Apr
 2024 08:41:31 +0000
Received: from BL6PEPF0001AB4D.namprd04.prod.outlook.com
 (2603:10b6:208:32c:cafe::d2) by BLAP220CA0028.outlook.office365.com
 (2603:10b6:208:32c::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7495.34 via Frontend
 Transport; Wed, 24 Apr 2024 08:41:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL6PEPF0001AB4D.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.19 via Frontend Transport; Wed, 24 Apr 2024 08:41:31 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 24 Apr
 2024 03:41:31 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 24 Apr
 2024 01:41:30 -0700
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Wed, 24 Apr 2024 03:41:26 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>
Subject: [PATCH 12/46] drm/amd/display: Add missing SMU version
Date: Wed, 24 Apr 2024 16:31:28 +0800
Message-ID: <20240424083202.2647227-13-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20240424083202.2647227-1-Wayne.Lin@amd.com>
References: <20240424083202.2647227-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4D:EE_|MN0PR12MB6223:EE_
X-MS-Office365-Filtering-Correlation-Id: ddfadfce-b5b4-4d25-1f63-08dc643a573d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|82310400014|376005|1800799015|36860700004; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?hOv3o0uq+uOWfR7aec7gxmFwT0vbCrL5PZ6mzlCVsUrwwSZ4a+0dS3VzStUL?=
 =?us-ascii?Q?FcdBJd91OAPse2WAVEd/ststEQ0IcixGdjL4Zr428mehpc8JFD8CHy1/xOv9?=
 =?us-ascii?Q?9XurNhf/hgi3DTrTGkkRUbq8aeqT4na5+u8cQLZOu/Sg1JOT8EeikGl5FZ1m?=
 =?us-ascii?Q?vZwzX8INbmlBG3WQ17JBJUDu01Gk7negauWGUMeHjJ0HHqIgCCo2v4uP/mB3?=
 =?us-ascii?Q?ax1pdsLUlMSSCaQ2EWIolAVomhFvCprUzJR74zOC7KjB/hEQUhCBhBwaB1mL?=
 =?us-ascii?Q?zQPN9rCh3n8WLkH4OIFcc72NumaM8UqzMtlrStgswhyql0j+ERo32Y2Rlg4P?=
 =?us-ascii?Q?nyfKyrF801HbR5UCSf/lTM9+nWzfL2eMJngLSsDVw47dl2UOJk/deKgTA+Dg?=
 =?us-ascii?Q?pMfxC6R0ULGp8MjhNQkAcByJn72zwZcz9eWgO1CBqbT6TM2sPxZzliXC7B14?=
 =?us-ascii?Q?q3TSg6mej4GlEC8HSTakqwVSiBMjI8dPZTJFhDDSxapbEt/jPqJ+WHmM3TJx?=
 =?us-ascii?Q?2cfsIqesAbnYfUpwokwakLPZkzjqV3Pkx6zlt0QnEoZyNPmVS54KYKhPOqkq?=
 =?us-ascii?Q?q5KUiPYA53yj4P5M8ZdnQ0JewPfyDbH0gdE1SLLEE4ySsuRJniTtwoBVmiyp?=
 =?us-ascii?Q?/L68j2qDXkySQvOYiRQNDuxXS8LrI3DkZJ4ZP6tMBXIec3DeDQIJmhvJiGvH?=
 =?us-ascii?Q?zPksEU+wqkzkKuMw8hRSQCSjEQTatfvckkETifRIbCJh258J60zkg8SRQbTm?=
 =?us-ascii?Q?/b0eiTI9txISBSmRITZ5HzNvGF7QfgQvi1XYo2HzsNj/TGPdb2jxTalT+EvE?=
 =?us-ascii?Q?VYB3Aw3Yxz6lmi6dFj15h8nkZqOvY+uJrpT0WvDvuWlcE1aK5F3TLV0Rm8dA?=
 =?us-ascii?Q?jl5eFgTLV5qmMUWGj1QPYX0c9K2fkFAlphT3qmo2qtSuBtFu9WJv9ywCKfTC?=
 =?us-ascii?Q?78tTxPNmJjULxBEKXb7+rGD5TTLtWcVCWNtErJ40O2A3j+WIynnJGshSjNKO?=
 =?us-ascii?Q?zlkDqNlVUkjMsKW1s0wqMKnVXSx0KHL8lIaCy/LITtcqV04jM7WmXKjYZP/u?=
 =?us-ascii?Q?NLJ+wL+8H79D49A620gdQ+abBGVygPX/+S2fffqFPt4aBegOlgEN94glt6m0?=
 =?us-ascii?Q?fWtEgr76ZaPK+BfKZB/iD5nuaV6go+GI/KgY+6xvZMD29Kn5TMbQGJxqr+tP?=
 =?us-ascii?Q?Wgwwdn+7MOOYQRp97MEJ+g8DdvmxjvKS71HrvCc5ktRAzDWqdKwnL+Gg2b+q?=
 =?us-ascii?Q?dxoVm+HSP6pbpibVOZz3inDIcCbFwX/zh4mQfowPZ655son8D1BLvrDN+Jt4?=
 =?us-ascii?Q?tmYPKdBVLaSVl8ukKNmstC5LmI1Zqx9PNAWmKtb40iHFiOFZ5RSkR6iA2mCP?=
 =?us-ascii?Q?ALaPwb34vfe06eM+UL7ecXOjYENY?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400014)(376005)(1800799015)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2024 08:41:31.3803 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ddfadfce-b5b4-4d25-1f63-08dc643a573d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB4D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6223
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

From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>

This commit add PP_SMU_VER_VG to the pp_smu_ver list.

Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dm_pp_smu.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dm_pp_smu.h b/drivers/gpu/drm/amd/display/dc/dm_pp_smu.h
index bd7ba0a25198..b0e17a594ec3 100644
--- a/drivers/gpu/drm/amd/display/dc/dm_pp_smu.h
+++ b/drivers/gpu/drm/amd/display/dc/dm_pp_smu.h
@@ -40,8 +40,9 @@ enum pp_smu_ver {
 	PP_SMU_UNSUPPORTED,
 	PP_SMU_VER_RV,
 	PP_SMU_VER_NV,
-	PP_SMU_VER_RN,
 
+	PP_SMU_VER_RN,
+	PP_SMU_VER_VG,
 	PP_SMU_VER_MAX
 };
 
-- 
2.37.3

