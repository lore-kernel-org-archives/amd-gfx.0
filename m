Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFDFFC02183
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Jan 2025 08:59:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9DD2410E5B6;
	Fri, 17 Jan 2025 08:59:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nLg1eZc1";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2057.outbound.protection.outlook.com [40.107.95.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C61D110E5B6
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Jan 2025 08:59:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JzldH5NxyiNDiKOjXG1pPDBH2hxYZak0DCFeZ3Cv4C5rrhPEvj57w9Oem/0TdB58xAVqBubAjWzGYSTh/qQNjBRElpwHEdq5+UIBL1soOrAjiTGlyse32ZTKU5fDwgoDM5YQWvk1zprzN1z1R3R235pK4d1Z/D9mfUBcv2xK8H//nvNSW0OSrJdAneUVpduLUTxxsiwLQZSUFuVJTxoqSpYfVojuZNkx8IUIstPYyxD/ldnzg72KOBHRV2wjl2mpkKYsyiMRVt4Mrd4B73NKVfaD+e8O3OvIzj60VdGaI/qXtzaHC4nz1F9KIKpTlPFEPOOOFk/ZXbKHyw8CHQOPAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3ibdFkIDNTWlfXsy4uRBoqqrKlmLX0ZUSHxQCgsWoVQ=;
 b=c1nkfIVpjH6uYcxM0diykdbEhnZROMIbAOpCtdmXbQsUr97G8+ZnUUS6m4ncTycd3p49Vo/qO5ntupv8TbW+tCh69urOcCXaIUWIKEE8dUgga6ueOG/EpRb2Tt44eMm2ykqynGdsoqH4wSXdHpmilFlROXAjo4YbfLCjt8co4jtw9q9R7QxwijGPfmH/9vI1IvB2TxUM5VOJZHm9NKfK6YObiMe3scXF+WcfqstI3Z1GZ/mJHHgKCvlKaX2XpuYFitXu0jl9m+zyOaWBh1+4Ex1lvrzHIanx2FJouGLnVhPTZRJagz58vuCjJVqoRffnZVB4PKMuwYrAnfXNZlRpkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3ibdFkIDNTWlfXsy4uRBoqqrKlmLX0ZUSHxQCgsWoVQ=;
 b=nLg1eZc1Jt+qhAXQsIUmEJo+ja8yfsWIYcnhyU+DDB1NFc+E1Bb8C/gaqb/r/rvVaJO8vA8eoa3r3S/qgknxeTD+4ZPQuggddE5UWlMnpDg89a+Ei/WzDPS3chIUixMH0tl0GigpcLkM0jlytWbvVz9zJamuWXAErPLjVboMHX4=
Received: from MN2PR02CA0014.namprd02.prod.outlook.com (2603:10b6:208:fc::27)
 by MN2PR12MB4303.namprd12.prod.outlook.com (2603:10b6:208:198::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.16; Fri, 17 Jan
 2025 08:59:38 +0000
Received: from BN1PEPF00004686.namprd03.prod.outlook.com
 (2603:10b6:208:fc:cafe::f1) by MN2PR02CA0014.outlook.office365.com
 (2603:10b6:208:fc::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8356.16 via Frontend Transport; Fri,
 17 Jan 2025 08:59:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF00004686.mail.protection.outlook.com (10.167.243.91) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8356.11 via Frontend Transport; Fri, 17 Jan 2025 08:59:38 +0000
Received: from jackfedora30.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 17 Jan
 2025 02:59:36 -0600
From: Jack Xiao <Jack.Xiao@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Hawking.Zhang@amd.com>,
 <kenneth.feng@amd.com>
CC: Jack Xiao <Jack.Xiao@amd.com>
Subject: [PATCH] drm/amdgpu/mes12: enable mes pipe wptr polling
Date: Fri, 17 Jan 2025 16:59:18 +0800
Message-ID: <20250117085918.1748711-1-Jack.Xiao@amd.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004686:EE_|MN2PR12MB4303:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f971687-5c66-4a82-e0e4-08dd36d545dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?VnH0ZJOWfkb9jWKJC46Bdqtff/3XC5kdJZ8i1LP7Mcp/SANUD6fxZmDMZ1x+?=
 =?us-ascii?Q?OaM0/oO1atwGrIW485ujs8Y+TblnFOSvlWhjaptAlHB43KtQ+bd+uUWBdMIi?=
 =?us-ascii?Q?lECuQbmCzM7aXhuAPAcoGjuLBNcgpwm2JNsJcyAijCFkCU4IQT1FIqsMljoO?=
 =?us-ascii?Q?zdLlIxuPtLmlsjOrpcAKJfzFFVlEbYQl1Tlf0V4XgdkgncVbMQ4eO7mBAuRg?=
 =?us-ascii?Q?Q/1ieG49gp+AJY0DfwcyjpkU0P/7Kjd83ZKMVj/3fp5owNhM0PLa9/KvQvfI?=
 =?us-ascii?Q?QXCExAxhmWQDfbw6i8TPqQKw+/ock3vCstPiYdFrnq8KzJoGgai3li/9qBrj?=
 =?us-ascii?Q?vvPqCW2wiW570/NjPbZiAzvk+0Gd6iEaBeb7rbmbSB8MuGe9oVdSHeNAAvQ1?=
 =?us-ascii?Q?bbidWbGmSBkDCCS/YzC1rkWYMRdp7QG11UUmwCvCgpGObaS1oNoPfJxCax8M?=
 =?us-ascii?Q?e14H+FeECp+V0AcAOmwnmf0J/vCYjMqn3nx0gm+efyyme9oJ5CCG+gp7QsFn?=
 =?us-ascii?Q?bOheNxB9SKEWh4Q9b13Kg4UbMW5iTfzsjwlJIaKGmXOrUaQLtaZfQS7DQoNY?=
 =?us-ascii?Q?Wsz+HxnCRzFPhgwSG9HNbe0NdmCaPgxwHckiw2qVU0MuauLT6DZQf7Y8K6TT?=
 =?us-ascii?Q?iaTMPsfZKc1edyUpPYVbyvfU8fc6SVK9BwFMUGk9VlENMXrpw83sGqz0IkC7?=
 =?us-ascii?Q?92zdLZ5Jnxk+ieiKCnmsCGDrHiFa8Fq9SDPl1L/nyCAroCXGXwOzOIAzz/Sr?=
 =?us-ascii?Q?rmDa69tMLATIBhF6J/MlZbUP3PmJRktBhjtmbdIEGA5RG2dWVRvod6CCBbP6?=
 =?us-ascii?Q?Xq2CHzn+NSs7R5bThAD2x9/prHmQD7mBLXyoSzvytpJCsG7tH6luWZH6hRTm?=
 =?us-ascii?Q?//TI+EGR+iNlhPaTguFIonXFE65cQYVYUn88+Ep17jbb/EiQDj+MtupxbNKE?=
 =?us-ascii?Q?4WizJBYLLqcIdaazCT0RlYAeeJyOZ7FDM09k6n6TTsCJxtt2qL+rl+V3Q9lH?=
 =?us-ascii?Q?QZKb8qtiqtDvXhESxsXIjPv/xqlLAJTrr215A5mN9scdU0XZ5LQR3BTwaQXY?=
 =?us-ascii?Q?3DiWB796h4vsuTQpQSJz1d+v7Civ1Hg38ypm1mThPbeaBZfNd2ubnGWTdlec?=
 =?us-ascii?Q?fn+Kg8t0LX3stBTaxCZ2mgOmyDq3tfe3LMg76WLH/i/1+0haUMLNEaF6FIQA?=
 =?us-ascii?Q?PrPOtTO7Z+Br60fimmE6UIPFxWXPBKW1q7dEbd1FwTaUufShm535LQrntbax?=
 =?us-ascii?Q?ebifHlmeVRsFNlJSyADBpbabRZ8sk1Z5/14+GJ9+JD1c3Xa+vrhugGHalsZR?=
 =?us-ascii?Q?yNcyOMSyvhwv42mAylD9vl2Fr0U7R8YgoaIqcp/R0lSId0Jx2rIQXdep0An1?=
 =?us-ascii?Q?rAzS0ImFLfK5UP6WYjAHB2hXkG52l/eqE0qfRLNEFX43IPUVEaxd5npQfkzl?=
 =?us-ascii?Q?YVdLYF/C6Y6s0dypWSho+P5Oc1NMqqTLYAAVsHYbTrD90tPkYZKxUg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2025 08:59:38.3890 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f971687-5c66-4a82-e0e4-08dd36d545dc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00004686.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4303
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

Enable mes pipe wptr polling for gfxoff might result
in mes pipe wptr missing.

Signed-off-by: Jack Xiao <Jack.Xiao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v12_0.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
index 185f4b55dcca..e516e4598017 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
@@ -1256,6 +1256,9 @@ static int mes_v12_0_queue_init(struct amdgpu_device *adev,
 	else if (pipe == AMDGPU_MES_KIQ_PIPE && adev->enable_mes_kiq)
 		adev->mes.kiq_version = RREG32_SOC15(GC, 0, regCP_MES_GP3_LO);
 
+	/* enable wptr polling */
+	WREG32_FIELD15_PREREG(GC, 0, CP_PQ_WPTR_POLL_CNTL, EN, 1);
+
 	soc21_grbm_select(adev, 0, 0, 0, 0);
 	mutex_unlock(&adev->srbm_mutex);
 
-- 
2.41.0

