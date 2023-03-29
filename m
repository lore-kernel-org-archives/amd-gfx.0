Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 955CBC761A6
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Mar 2023 20:09:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 59AA010EC3D;
	Wed, 29 Mar 2023 20:09:56 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2046.outbound.protection.outlook.com [40.107.92.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9791510EC0B
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Mar 2023 20:09:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y/9WWvzIC6sNIefGCSrv2ca4rE0sYzHkYQL4ErC+lRTEhE3Sla2EBygXgYpuJkz3NtDB/bPT9LQso9dR7hn8iVWZm5RBw9mmpxA/KB5O57noKd/XUNXU4R0nGcVhkNbrDcPjtpQBSPrW54WeaPf9CRPVlZvCC9/pVAnPeSlw9awHPW47gVklh9ggqfs/psboJtkCT6OT3EDME5SUVIgnomQvWPT0CIqWZeBO3egxm/hQEDU+Vjj4gfna66ERcSqPmNc09OG2OOFPIMxX7CXBOQ3H3B/DyF/mNSgU3lQBAUGh0q80xMEDOIEsEEnF82ro70eodbBxi0wgxeXPksAHug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZZOip0voBQ3aebDT80rueny3KdG34+c8NoalOvws16Y=;
 b=R/WAe3Sv8xIE9ddTRsA0k7mu3qQt/wGm0gGgv0P3dvIuLV0zK/lNy7+WZ8gTlJgblsUGovWQhApk0B9afL9+wm70UITQF57PfQXGRhyC2vvtkA3w2Qlnkv+BP483S+/rU45p3TOCfDpqOHHWG9EDGY6hJGndgEkN3IDIE0e9VZ6l4Oj/26SqjfilQHxwq6fHzOuuiADgcEbk5oLbffKlf/5x4OenSB7a/+CbJkQKvB15nUzze8k0//fGWuuJpV+z18UyDiFeOwxpk432jujbZmu9eeHGaXUJVlpRCxc5aWwKYqtRg0O3gw8jpRulOa0BchAXjij7ZPSnYp6Ub4xOeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZZOip0voBQ3aebDT80rueny3KdG34+c8NoalOvws16Y=;
 b=fqcv/Y8SxncAM4F9k8O0NGJ1z5Mm8ET6Gr47GQPjDzhqdyj5Ep+2Q+mPvhO77Y6m0skRdDrBOo0Sxk8GyUqGT73hoxalPbvfGPLl/WShXCe0Lx8QNj/Lz3E8PNNUsN3MECkFPlQKF6PZRHXrQystPVvbOw62CiHeakjxcED9YoQ=
Received: from DS7PR06CA0022.namprd06.prod.outlook.com (2603:10b6:8:2a::10) by
 BN9PR12MB5161.namprd12.prod.outlook.com (2603:10b6:408:11a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.33; Wed, 29 Mar
 2023 20:09:52 +0000
Received: from DM6NAM11FT029.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2a:cafe::4) by DS7PR06CA0022.outlook.office365.com
 (2603:10b6:8:2a::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.20 via Frontend
 Transport; Wed, 29 Mar 2023 20:09:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT029.mail.protection.outlook.com (10.13.173.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6222.22 via Frontend Transport; Wed, 29 Mar 2023 20:09:51 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 29 Mar
 2023 15:09:50 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 01/12] drm/amdgpu: reflect psp xgmi topology info for gfx9.4.3
Date: Wed, 29 Mar 2023 16:09:19 -0400
Message-ID: <20230329200930.1982035-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT029:EE_|BN9PR12MB5161:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ee7c4ac-2ad6-4440-c6ae-08db30918e55
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: e8CxHwVQs5xnyEb3tUK9fuC1ejoDkwCo+S6X+mQk9Me3aKwvEDmGUesDsRqEqUe7Tqoz5nUZ/6z/qDJ7JoyKqXb+GKWSFWzhTH8GxRZ3BJeZafOZMuSTsdzQ46brV8L4N196FfK4WC3oXXCNVs8gJDZm0mKgX7XA8y6r64cOlHZ8n2/25pz/woh45g1ljPMuSwZhIqVhTwPBn6Uy1jHExtaNxXeMXvsu6iZH0nRHf1Wd/L03mvCcpfN9kJYa5TQr3Wp+zf7y9h1OWLEW1xyIBPmHR2EsgxsrWMgm1wPTaXXit4ZHbz74kGcZXVVhoLsc+PNXhu/1WERzlQ5/uc0A+p5Bq6D86sLChjo8zyA4zLe9UP7sXJ+jGcvy9QwsgnanXgWbIsuPObtU3BG1TBZm7f8B42+cULfdIa6mBN6ACbAVmlGb62p/WN1KRmUVZ9tI4OCLET9P1uwvQTLoooJepr1B7zwSPk7dh/7GQt6gWoPCH7gEDEiAPHr8QDyjdmWmsjR3lMgakKe7RFsVcUDVcTI7PCBViGjy3Tt/rMWTrdMY+jssp2NCTjUTkLnvQ1tVK8pcQ2ovJf79/pY5wBpDNwzVb0vteg4y+yi1q92Mdcdsw2LfLuqn7TkkBfEvfhQa9YswcTQcoMCk1duad7pafqdoUtQfstYvfR4MK10EOUCkPKJ9hfnlrFSzlqc2pvUJML5J2pbesMXHRnY0+OPYa/8nfJu4MXLERQTL2kBt99U=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(376002)(346002)(39860400002)(136003)(451199021)(36840700001)(46966006)(40470700004)(316002)(6666004)(40460700003)(82740400003)(86362001)(8936002)(5660300002)(82310400005)(356005)(2616005)(81166007)(54906003)(47076005)(6916009)(41300700001)(36756003)(8676002)(70206006)(4326008)(70586007)(16526019)(186003)(26005)(40480700001)(36860700001)(83380400001)(478600001)(2906002)(1076003)(7696005)(426003)(336012)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2023 20:09:51.8653 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ee7c4ac-2ad6-4440-c6ae-08db30918e55
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT029.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5161
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Jonathan Kim <jonathan.kim@amd.com>, Shiwu Zhang <shiwu.zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Jonathan Kim <jonathan.kim@amd.com>

Similar to GFX9.4.2 non-A+A devices, GFX9.4.3 psp xgmi topology info is
half duplex and requires the driver to fill in the bidirectional info.

Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
Reviewed-by: Shiwu Zhang <shiwu.zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 9d7e6e0e73ed..2dffbea1d72e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -1254,8 +1254,9 @@ int psp_xgmi_get_node_id(struct psp_context *psp, uint64_t *node_id)
 
 static bool psp_xgmi_peer_link_info_supported(struct psp_context *psp)
 {
-	return psp->adev->ip_versions[MP0_HWIP][0] == IP_VERSION(13, 0, 2) &&
-		psp->xgmi_context.context.bin_desc.fw_version >= 0x2000000b;
+	return (psp->adev->ip_versions[MP0_HWIP][0] == IP_VERSION(13, 0, 2) &&
+		psp->xgmi_context.context.bin_desc.fw_version >= 0x2000000b) ||
+		psp->adev->ip_versions[MP0_HWIP][0] >= IP_VERSION(13, 0, 6);
 }
 
 /*
@@ -1363,6 +1364,9 @@ int psp_xgmi_get_topology_info(struct psp_context *psp,
 	/* Invoke xgmi ta again to get the link information */
 	if (psp_xgmi_peer_link_info_supported(psp)) {
 		struct ta_xgmi_cmd_get_peer_link_info_output *link_info_output;
+		bool requires_reflection =
+			(psp->xgmi_context.supports_extended_data && get_extended_data) ||
+				psp->adev->ip_versions[MP0_HWIP][0] == IP_VERSION(13, 0, 6);
 
 		xgmi_cmd->cmd_id = TA_COMMAND_XGMI__GET_PEER_LINKS;
 
@@ -1380,8 +1384,7 @@ int psp_xgmi_get_topology_info(struct psp_context *psp,
 					link_info_output->nodes[i].num_links;
 
 			/* reflect the topology information for bi-directionality */
-			if (psp->xgmi_context.supports_extended_data &&
-					get_extended_data && topology->nodes[i].num_hops)
+			if (requires_reflection && topology->nodes[i].num_hops)
 				psp_xgmi_reflect_topology_info(psp, topology->nodes[i]);
 		}
 	}
-- 
2.39.2

