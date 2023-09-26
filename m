Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E97F6E7E64B
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Sep 2023 16:39:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 78D2410E012;
	Tue, 26 Sep 2023 16:39:57 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0DA5610E012
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Sep 2023 16:39:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BWQQik1s6kX4ds3cvdMEV6n0ji8zQj56v1exVDJlZx36b6BdCy2uPtUahu+3Iy6oMsP1QLx2XjhrI8N0AQ/8NN26TsKRslNbmj/X2TEpQdASJKJEtbmrsJkOE1qcOJzQt+PY+7MefzRjeCqBkzcfrPIUkVz0kD3e//tcbIyo4yjtcmhalT+WfB/Dw/z10o8nGRZcARNXUkelcJxCdxIoRAPTt/CJmfXxAuNFrIvkiAHZ+VLTjv0x8iHQU57uahRPrd8ZyrzOORSue90Eua5H5sDeOgxUANh5dLcC2M6XwJw3gO7T5rDGAXQZ4eMLAhJQwLlVpgFUzS9/IzazvoMUUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O8s+bfkR4oPX5XnWYTr5Apnwf1wbi5qnMo7UCw91mms=;
 b=VHLQOTUfIGzW5VCQv+wolnwHphBb/kNy64jm3J8NKybcTCc7p5zowRCRsV6OL7CU7+lf2DuBpoeC658pgCh98W/WIxVre/gzHLuYxNz20EmhBu+rrRIr4ByWX8gEoJt4Nkd5snJ6R+EjgGlfYtenKkioTeOoB5GwZSFaxwSg1v5omwXon3gDbRWFwgy7sCn2dCtCGdJs3ndq1q1GwEH5jmkQu4fy91uVIEXAt/G2vP2/OOpixEEOePy6vXgZjlmnD1vzcRop7LzKRiblLLhpsadTYFg8sjaXcAg4jyhS4gOb/Fj5tcoGLq2cZ0XwECmMeXtkYuWRhBZR1KFRzXGYyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O8s+bfkR4oPX5XnWYTr5Apnwf1wbi5qnMo7UCw91mms=;
 b=nPvRtACkiU3YBj7f15HOogj8kwM38wW+yck32f8t4NeqOGta362tTnTAR1t8+JUiBZ1tazxWl6a7wBcYJtCBDWf3G8NK4CnSYogoaObOEijRuiIcg9+5OhZUU7lHvuM73XalTlM6HlBZ/gmabTtsDUXFybO2nvw9tt73Cy31jUc=
Received: from MN2PR11CA0030.namprd11.prod.outlook.com (2603:10b6:208:23b::35)
 by CY8PR12MB7316.namprd12.prod.outlook.com (2603:10b6:930:50::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.21; Tue, 26 Sep
 2023 16:39:53 +0000
Received: from BL6PEPF0001AB74.namprd02.prod.outlook.com
 (2603:10b6:208:23b:cafe::61) by MN2PR11CA0030.outlook.office365.com
 (2603:10b6:208:23b::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.35 via Frontend
 Transport; Tue, 26 Sep 2023 16:39:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB74.mail.protection.outlook.com (10.167.242.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Tue, 26 Sep 2023 16:39:53 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 26 Sep
 2023 11:39:52 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] drm/amdkfd: reduce stack size in kfd_topology_add_device()
Date: Tue, 26 Sep 2023 12:39:37 -0400
Message-ID: <20230926163938.1013775-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB74:EE_|CY8PR12MB7316:EE_
X-MS-Office365-Filtering-Correlation-Id: fa827e2c-a351-44c7-d716-08dbbeaf35d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XXdj11o1r9Gd27FE7s+ABT72pZDnCKYwMTI/FdMpoIz+0eEdAFZ1hsSuVYS6t6m3BkRHOUge7KRBghkPaE5wwwEJWWmgCObO8mVhebjmFLgkN3rgBPC9/7/8QJOHz1qCuANZS13olynOEDCIjZ5FvHd8kRMnae3ZGvuONoM4U0uTyFxeWlB6c9r+WpkB39wnaWhvdZnjcyh4AE7Tj/XmxYlllmHE25JuYhXnDFA5YL9pC86wrXW5NOfvxdVpjCdj8ITT0bJ+xa133imm/HmOh/9aU5JATgmDISPjtyFi6j/PcFKdRSPmEdG6yH9MpED4mCq86SO2C4uE48gA1eS9esEdPVNQhF0Gz2NKnQ0HuitMTfWUN6GjNU2q7bVMyPNignfsTw+U3smaw4hyj8vJjfVO4upH/G1QpGp06QBwBQE1TOSAK2/c3ZDhUpXbYi+q7lX+rHdj8UIw/V0XTEGlWnnSOfev4pmiyHPeuDmWLuQkLhw6K0CG2dXpHMvjBLCGJdY8OPZqwkL57FqOZ+3puV2oSRihF3h+7ArnefHwEM8xT4i1J7WUsEw14WNQzL9ZBevZg6p/5iLCK0GWkoANJeBbOWrtQTmyBB/QQxBbKnSCEe/FJ7sXIotszK5Q2RiVKYPwcFCHBG03bt9WqxsQADTr8t+qen3L8hMcu8AWTYNUqPo/dOLkmDsY3Bsvdc5RMse5xmz8A30B56e3WiAVCgP0onr/UQmazelNrN1szH2EC3UdwNYRZtf6lW92Hrl3
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(346002)(396003)(136003)(39860400002)(230922051799003)(82310400011)(186009)(1800799009)(451199024)(46966006)(36840700001)(40470700004)(478600001)(356005)(16526019)(54906003)(2616005)(81166007)(41300700001)(426003)(336012)(26005)(40480700001)(6916009)(316002)(6666004)(966005)(82740400003)(8936002)(7696005)(8676002)(40460700003)(1076003)(36860700001)(4326008)(2906002)(47076005)(86362001)(36756003)(83380400001)(70206006)(5660300002)(70586007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2023 16:39:53.4611 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fa827e2c-a351-44c7-d716-08dbbeaf35d9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB74.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7316
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Arnd Bergmann <arnd@kernel.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

kfd_topology.c:2082:1: warning: the frame size of 1440 bytes is larger than 1024 bytes

Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2866
Cc: Arnd Bergmann <arnd@kernel.org>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
index c8c75ff7cea8..3f9f882d3f5c 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
@@ -1918,7 +1918,7 @@ int kfd_topology_add_device(struct kfd_node *gpu)
 {
 	uint32_t gpu_id;
 	struct kfd_topology_device *dev;
-	struct kfd_cu_info cu_info;
+	struct kfd_cu_info *cu_info;
 	int res = 0;
 	int i;
 	const char *asic_name = amdgpu_asic_name[gpu->adev->asic_type];
@@ -1959,8 +1959,11 @@ int kfd_topology_add_device(struct kfd_node *gpu)
 	/* Fill-in additional information that is not available in CRAT but
 	 * needed for the topology
 	 */
+	cu_info = kzalloc(sizeof(struct kfd_cu_info), GFP_KERNEL);
+	if (!cu_info)
+		return -ENOMEM;
 
-	amdgpu_amdkfd_get_cu_info(dev->gpu->adev, &cu_info);
+	amdgpu_amdkfd_get_cu_info(dev->gpu->adev, cu_info);
 
 	for (i = 0; i < KFD_TOPOLOGY_PUBLIC_NAME_SIZE-1; i++) {
 		dev->node_props.name[i] = __tolower(asic_name[i]);
@@ -1970,7 +1973,7 @@ int kfd_topology_add_device(struct kfd_node *gpu)
 	dev->node_props.name[i] = '\0';
 
 	dev->node_props.simd_arrays_per_engine =
-		cu_info.num_shader_arrays_per_engine;
+		cu_info->num_shader_arrays_per_engine;
 
 	dev->node_props.gfx_target_version =
 				gpu->kfd->device_info.gfx_target_version;
@@ -2051,7 +2054,7 @@ int kfd_topology_add_device(struct kfd_node *gpu)
 	 */
 	if (dev->gpu->adev->asic_type == CHIP_CARRIZO) {
 		dev->node_props.simd_count =
-			cu_info.simd_per_cu * cu_info.cu_active_number;
+			cu_info->simd_per_cu * cu_info->cu_active_number;
 		dev->node_props.max_waves_per_simd = 10;
 	}
 
@@ -2078,6 +2081,8 @@ int kfd_topology_add_device(struct kfd_node *gpu)
 
 	kfd_notify_gpu_change(gpu_id, 1);
 
+	kfree(cu_info);
+
 	return 0;
 }
 
-- 
2.41.0

