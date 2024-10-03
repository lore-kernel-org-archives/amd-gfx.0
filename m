Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFDDFCF34D5
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Oct 2024 23:36:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4DFB910E9B1;
	Thu,  3 Oct 2024 23:36:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="cEDphgBK";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2066.outbound.protection.outlook.com [40.107.93.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4CCEA10E9B1
 for <amd-gfx@lists.freedesktop.org>; Thu,  3 Oct 2024 23:36:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=chWceTy3/J4tvqc6son2c59rypz0fnflDm94lmH6xLxhvhRb8CQUf0ZdxuLQjrEZDsyoer0UmfLK0rXbY7DSEIheuAnMjoG4nEBsRmYMvlUw70xpAeiR+cwcnELTkcUHbHwRgv8ZBpMl5O0BkET1GJAPzrwDE+ugQ/8BVjjeNlahkL6brMeuJYqgatuC9ZKKg/K5VVEkCI+vPse4HItXg4pMrVzHnEhG3kuaOzEROM680BhGiEhcLTb0nZ5UzymwZO9YE+cumr7P35Gtw0OTEHblm4HMsaAEQnSyaRc476WYFC24viU1CvpOmozgdtg8+VnOJzefw39I3M3Q+RZRKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8HXPbNzMXMDUzR2H01j5vpPj4QaTKPpETJz/ll9ouko=;
 b=zCgr7/fPYB1/OUNsnzGDWpLW+Viw+qhIiKHWsFKykrdTOQFTQGlu4ShTIOeaM6MY2gpVe3rAIEkoqehkZCwwRnIQJuTlNSDsof9bsxVa2srDrGwcTCRQkr/4o0TXBQ5FXlXW/EbdYY1X507tia39Sk6G4DJ54UUXvWR30aMAI5ji8jBxq6aXlreJosAtoAGQizNueNHFdEqZNJcR4/XxLgmpDq4jw8r22vMgGixW8Nze0OFYWjYhG6ZeVnPfcU/SELNmqkdj2I+iiTG4jLHr9oGofcYKtDYR5PDEK22xPLtKzYAJ6okAE0sm2WELXsmwDs0+phCb7Aolqm4rLW36TA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8HXPbNzMXMDUzR2H01j5vpPj4QaTKPpETJz/ll9ouko=;
 b=cEDphgBK3CjUAvO/XdbZPmFm3hT7CAfVSICZMSog1Ygzt3YJonup02eNh2sg2aNTqpLVaa7CJqUcTJSsLbrpgUd/zBG0bVgLoMiwqpXoBMx95gaq50Dgw8sXkZ2AnxnM/KzDJL5Qa7jPy5qpSIffhhsxWFE8MBqISX/DLXddsJg=
Received: from CYXPR02CA0009.namprd02.prod.outlook.com (2603:10b6:930:cf::17)
 by DM4PR12MB5772.namprd12.prod.outlook.com (2603:10b6:8:63::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.15; Thu, 3 Oct
 2024 23:36:05 +0000
Received: from CY4PEPF0000EE37.namprd05.prod.outlook.com
 (2603:10b6:930:cf:cafe::93) by CYXPR02CA0009.outlook.office365.com
 (2603:10b6:930:cf::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.18 via Frontend
 Transport; Thu, 3 Oct 2024 23:36:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000EE37.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8026.11 via Frontend Transport; Thu, 3 Oct 2024 23:36:05 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 3 Oct
 2024 18:36:03 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Hamza Mahfooz
 <hamza.mahfooz@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>, "Roman
 Li" <roman.li@amd.com>, Wayne Lin <wayne.lin@amd.com>, Tom Chung
 <chiahsuan.chung@amd.com>, Fangzhi Zuo <jerry.zuo@amd.com>, Zaeem Mohamed
 <zaeem.mohamed@amd.com>, Solomon Chiu <solomon.chiu@amd.com>, Daniel Wheeler
 <daniel.wheeler@amd.com>, Fangzhi Zuo <Jerry.Zuo@amd.com>
Subject: [PATCH 17/26] drm/amd/display: Skip Invalid Streams from DSC Policy
Date: Thu, 3 Oct 2024 17:33:35 -0600
Message-ID: <20241003233509.210919-18-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241003233509.210919-1-Rodrigo.Siqueira@amd.com>
References: <20241003233509.210919-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE37:EE_|DM4PR12MB5772:EE_
X-MS-Office365-Filtering-Correlation-Id: 60d9d9ec-27b4-4aae-9c68-08dce404266f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?t2b3rPFohfK9v4QYkHdKsfWtBWtksNJmNS7akL3s/HHXfBnQ1kESynA5QYT7?=
 =?us-ascii?Q?p00wZYXujNAhEJS3Lgg0AO+rSTU5nManN5His4YSnIqIEE/7M86xH0YfJVn+?=
 =?us-ascii?Q?Er77JZtFqy2aF3qV1WCfgZiNO9tTFlSS6qWgxw9N4Wj9BNJVPnsO+7DkH9Dw?=
 =?us-ascii?Q?TlOFWxKT1dwRhxc2BeP8XsjMf8Y0ZJ7/UcpfIB6eiT7GQk1Blzdw1gtxxNaw?=
 =?us-ascii?Q?KU1pSd851AaK6nC5s54LA5gRlyLALj82YMoiBJgIOnPUqx0SR8b9xPmj5EXn?=
 =?us-ascii?Q?l3lDjTOwpPDQ/hAYNSQmZXao/FCyMib1zYqGeKXi9Hj1fsK7qRl4GV0pg5Mp?=
 =?us-ascii?Q?PUvnnerx8TAMfQGdN1os1rgprAub1tfohFnNITKKZ5xocVgG23EerkHmt0Ld?=
 =?us-ascii?Q?oiCjie8JACj/LzIoV2EfrkmMyCus2wduQ3mxBNvFx5sAEyTefXpzHRE9mclF?=
 =?us-ascii?Q?p07zUi75icA+WxOAbi1ZVQT85umtdo0auH+d9NAbuA7hveuyqWjMl7Slit5i?=
 =?us-ascii?Q?oCGaDhRoZKoTuSSml0/LQBCcCk4dfdzP4xPAyYu+nCOtL2kAt1Ym7l5zQDPO?=
 =?us-ascii?Q?eEShqLlSlkhwyLq6YJwLMY38/TMfai0HMz4nNSIkaoakCuJxFrDEF6ieywQM?=
 =?us-ascii?Q?YLuP+EPbwDadolZOW+HDRaysKhXLnZnTJULeJv29TZkOU+Eh1bCMU1+VO1Zk?=
 =?us-ascii?Q?cKp16gT0IcqV2x9njPoS+c27tn2ruHNFgI4GNxvn0SqnJPDK94AIGfWEWJFf?=
 =?us-ascii?Q?AFJRn+UFgGgfYNNJxWwvrnfWd75ihlxecgF3DKGW5uA11LamaNUXmZ0BHRkq?=
 =?us-ascii?Q?bTgxwM+IALZVejPHOEU+RYoPYPghN7oEh8UItATHNc0NEhcqN7LLS8UtNdf+?=
 =?us-ascii?Q?OgU83+TsN42c90Nh3AZVCGQfVT2HebOo1MKA3zxQp5rgPVCzkYDCgunYE2l2?=
 =?us-ascii?Q?aEQsrOuNj/DsxwpIgR/Nlbr385WMkvGtQOZtUGKdOQ8+bNHTp+MvNApD0pw8?=
 =?us-ascii?Q?+8mvwEvCxhLZgGc3KLLvKlFnH7usV71K11lUkLW9XR3Oh9g2ctAU+tqdbrka?=
 =?us-ascii?Q?GBr9l7c+JjmGHh4Mw61qwXUXouKFO6jg3CW5ye3NMsupgl+H6ShPCewdLDIG?=
 =?us-ascii?Q?I13+gPytht/jKpXSHPR9c7m+tkMMpgmNb+A/w7HMHG9L7OdWxDECxJONwHe4?=
 =?us-ascii?Q?4HC4IOaBWUTfgoeH57JUcjX6lQs1lHQYQG9lhmrdsYPAj1PqUI36GLTZC124?=
 =?us-ascii?Q?ukOY3tfm26tDCqTQa4QuQa6Wdm5R2flSHt/1xZ991RBzkDkFQLobF4LahBst?=
 =?us-ascii?Q?Em+a2M6o+BAMhMeX0pXh2sGcl0liWFJF837dNrxCkK1wxscIg3mNQqxBc3fS?=
 =?us-ascii?Q?2/uUdE0+ML4BH5TkG9Hktc4bC3bh?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2024 23:36:05.4212 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 60d9d9ec-27b4-4aae-9c68-08dce404266f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE37.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5772
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

From: Fangzhi Zuo <Jerry.Zuo@amd.com>

Streams with invalid new connector state should be elimiated from
dsc policy.

Reviewed-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Fangzhi Zuo <Jerry.Zuo@amd.com>
Signed-off-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
---
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
index 68bd8e6b948d..32b025c92c63 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
@@ -1120,6 +1120,7 @@ static int compute_mst_dsc_configs_for_link(struct drm_atomic_state *state,
 	int i, k, ret;
 	bool debugfs_overwrite = false;
 	uint16_t fec_overhead_multiplier_x1000 = get_fec_overhead_multiplier(dc_link);
+	struct drm_connector_state *new_conn_state;
 
 	memset(params, 0, sizeof(params));
 
@@ -1127,7 +1128,7 @@ static int compute_mst_dsc_configs_for_link(struct drm_atomic_state *state,
 		return PTR_ERR(mst_state);
 
 	/* Set up params */
-	DRM_DEBUG_DRIVER("%s: MST_DSC Set up params for %d streams\n", __func__, dc_state->stream_count);
+	DRM_DEBUG_DRIVER("%s: MST_DSC Try to set up params from %d streams\n", __func__, dc_state->stream_count);
 	for (i = 0; i < dc_state->stream_count; i++) {
 		struct dc_dsc_policy dsc_policy = {0};
 
@@ -1143,6 +1144,14 @@ static int compute_mst_dsc_configs_for_link(struct drm_atomic_state *state,
 		if (!aconnector->mst_output_port)
 			continue;
 
+		new_conn_state = drm_atomic_get_new_connector_state(state, &aconnector->base);
+
+		if (!new_conn_state) {
+			DRM_DEBUG_DRIVER("%s:%d MST_DSC Skip the stream 0x%p with invalid new_conn_state\n",
+					__func__, __LINE__, stream);
+			continue;
+		}
+
 		stream->timing.flags.DSC = 0;
 
 		params[count].timing = &stream->timing;
@@ -1175,6 +1184,8 @@ static int compute_mst_dsc_configs_for_link(struct drm_atomic_state *state,
 		count++;
 	}
 
+	DRM_DEBUG_DRIVER("%s: MST_DSC Params set up for %d streams\n", __func__, count);
+
 	if (count == 0) {
 		ASSERT(0);
 		return 0;
-- 
2.45.2

