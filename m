Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1D21C6FD1D
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Mar 2023 19:43:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AAEBB10EFF1;
	Thu, 30 Mar 2023 19:43:01 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on20625.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e89::625])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F355010EFED
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Mar 2023 19:42:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lY77qX9huSoqlI6zjj/0PVmRHXP21rU2vbVjHn77BpK2d2tjUoWc4A4E44hKSOpvk33iOpzyCc4PbLZLSiObN3dE0Hp4o4EPgr0vpOhW2LbIcBILGDVhl6zqM0lrDkmfJIgiIL8P1Xwv4Y3E0vFIGBq52E1idvusryCQPuteyDEWh5qimFQysyNW5DMrX5jhRrMwFwGwmlar77MHDWGnwzImF87LLxjmg41DHVVqOFLmqGtqJOxQpZwIfBXyy5iW5bG3+pgeykGoRnBWmLE3BXG7N0VW4rMHXwMNng/31FIMQAj49Vp/YYDvKIRIPLg4iV5rb9griB9uc6JX/3Q9UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RY3vLWDqIgfXBpkkwT9Vb42wgB5KOzssDWWSK5HGyns=;
 b=ZEMOofy6VcGh063pycM8z0Oq32LB1ljeBCNtVq+5uFkN8wTs8L9W0X/u+EBpXZ1JlRmmhRt3dPgP2NvHh/PHA4Bg469xeZ3Xlb+87KuumO+8TISbMfrW1qcMYb9Kgi9/C3dfKZWGteC8LI3gMkUvLKggsEzqZp5ZUS+ogZI8jVws+ogoATMmuoAtW4Q9vHMCswZ0hWhq87FSTI5G1YQIBJKYwCwwKLGV/Ehdas7E0clEdNHi+WfvOT018O+pr2cKwcIQBuuTVVy+6SJfgmRgic7m70Guq2UNwpsZ/ux8N6+on6FOlH73nDmbnv2Df2F3Oc8vZn+OdtpqSuP0qv0/Tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RY3vLWDqIgfXBpkkwT9Vb42wgB5KOzssDWWSK5HGyns=;
 b=5YSX3iWeZfgG3pGrUDdMIoLk9vw4t1BWzVtiIbvwyIOu/EHO7T8F3t0undCxN2ZvuaAoCCS8C3hOXEOqr76osPZDiMDPL5AcF9YCtdmRd8ovVG03ju4DjvvIhOPyxGfQrYsWfQ9hJeQ9CdTmD3jWD4H79QHktoO1zfs3VUS0V+s=
Received: from DM6PR03CA0088.namprd03.prod.outlook.com (2603:10b6:5:333::21)
 by MN2PR12MB4406.namprd12.prod.outlook.com (2603:10b6:208:268::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.20; Thu, 30 Mar
 2023 19:42:54 +0000
Received: from DS1PEPF0000E63C.namprd02.prod.outlook.com
 (2603:10b6:5:333:cafe::6e) by DM6PR03CA0088.outlook.office365.com
 (2603:10b6:5:333::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.20 via Frontend
 Transport; Thu, 30 Mar 2023 19:42:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0000E63C.mail.protection.outlook.com (10.167.17.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.30 via Frontend Transport; Thu, 30 Mar 2023 19:42:53 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 30 Mar
 2023 14:42:51 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 10/23] drm/amdgpu: correct the vmhub index when page fault
 occurs
Date: Thu, 30 Mar 2023 15:42:21 -0400
Message-ID: <20230330194234.1135527-10-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230330194234.1135527-1-alexander.deucher@amd.com>
References: <20230330194234.1135527-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000E63C:EE_|MN2PR12MB4406:EE_
X-MS-Office365-Filtering-Correlation-Id: 15df3458-9c52-4c03-fea3-08db3156f459
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2Ywf66keb7l4q+OUjvXbFihNlgwKNwFeVzFHXwUVmV88nsbWBp58/uPfzTSqZx6IJcJpIfLrgHZD963h3lDqSgOcnFns7ZvPWOXO6NotL1bkB7e/ERb81f5+OXP+3+1ryXRWKxX1d4smhjlaNTTzyaULcTfgWA/NciiuOxHsNaYoay7eJXNM2CNXyQvhispnMaTCUx2rIHE1WrS+puKL2MV/tccAUzfYHNQViO8vjmjOpDO7EmCEyS9V2LWUv/z16Iw5kN0FFJvxBprDxAGsncFSplnV79FObWjAsMS0yPUGtybsE5X4kkYGcrGHw7iBm+cjoWebau1oRNcalRRu6wHNr9JvA6aKQ7blKjzK9VBovhV4qht63B4oiBGA4OguTps6MZ3RKgrl7+2/JNro1AOd6oTE1SJvcM/mNlB1z9y262wk0+/IFir9J0BQ9kJvG14shBQ8ZiEssk7wawHYP4WlCr9yQJpLqT8XGTP+ICk4da8E1tODispuw1wpzZrYfVCvQq+i6BwY6vPAhADMSq3HQDvf9VEfklETGGucc24yr6HFp6Gh7WJCpDDprkWsvYbZ71Jdroc3jMZj1MLqjVA6Z9cTGAncudgWAgH5ABbi+cJKK0OhIyPxsNm4Nu0MkGnpNE1y0PnwA0kf42SdXUpoQ/7okF8/bu9V5vpUmTX+DDRKib5F7TTQNqKx08/mVW9JfBtPs6is8X4ole82xbIzh0qIJfHjrP7yZHp3/Lw=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(346002)(376002)(39860400002)(396003)(451199021)(40470700004)(36840700001)(46966006)(86362001)(47076005)(83380400001)(336012)(70206006)(4326008)(356005)(6916009)(81166007)(5660300002)(40460700003)(36756003)(426003)(82310400005)(70586007)(8676002)(41300700001)(8936002)(82740400003)(40480700001)(2616005)(478600001)(2906002)(26005)(54906003)(6666004)(36860700001)(1076003)(316002)(7696005)(16526019)(186003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2023 19:42:53.8763 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 15df3458-9c52-4c03-fea3-08db3156f459
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000E63C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4406
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Le Ma <le.ma@amd.com>,
 Asad kamal <asad.kamal@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Le Ma <le.ma@amd.com>

The AMDGPU_GFXHUB was bind to each xcc in the logical order.
Thus convert the node_id to logical xcc_id to index the
correct AMDGPU_GFXHUB. And "node_id / 4" can get the correct
AMDGPU_MMHUB0 index.

Signed-off-by: Le Ma <le.ma@amd.com>
Tested-by: Asad kamal <asad.kamal@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h |  1 +
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 27 +++++++++++++------------
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c   | 14 +++++++++----
 3 files changed, 25 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
index 674777b03663..f1c17f2e0532 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
@@ -271,6 +271,7 @@ struct amdgpu_gfx_funcs {
 			(*query_mem_partition_mode)(struct amdgpu_device *adev);
 	int (*switch_partition_mode)(struct amdgpu_device *adev,
 				     int num_xccs_per_xcp);
+	int (*ih_node_to_logical_xcc)(struct amdgpu_device *adev, int ih_node);
 };
 
 struct sq_work {
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index d652464e5ade..9ea8d4f268c7 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -642,6 +642,19 @@ static int gfx_v9_4_3_switch_compute_partition(struct amdgpu_device *adev,
 	return 0;
 }
 
+static int gfx_v9_4_3_ih_to_xcc_inst(struct amdgpu_device *adev, int ih_node)
+{
+	int xcc;
+
+	xcc = hweight8(adev->gfx.xcc_mask & GENMASK(ih_node / 2, 0));
+	if (!xcc) {
+		dev_err(adev->dev, "Couldn't find xcc mapping from IH node");
+		return -EINVAL;
+	}
+
+	return xcc - 1;
+}
+
 static const struct amdgpu_gfx_funcs gfx_v9_4_3_gfx_funcs = {
         .get_gpu_clock_counter = &gfx_v9_4_3_get_gpu_clock_counter,
 	.select_se_sh = &gfx_v9_4_3_xcc_select_se_sh,
@@ -651,6 +664,7 @@ static const struct amdgpu_gfx_funcs gfx_v9_4_3_gfx_funcs = {
         .select_me_pipe_q = &gfx_v9_4_3_select_me_pipe_q,
 	.switch_partition_mode = &gfx_v9_4_3_switch_compute_partition,
 	.query_mem_partition_mode = &gfx_v9_4_3_query_memory_partition,
+	.ih_node_to_logical_xcc = &gfx_v9_4_3_ih_to_xcc_inst,
 };
 
 static int gfx_v9_4_3_gpu_early_init(struct amdgpu_device *adev)
@@ -2760,19 +2774,6 @@ static int gfx_v9_4_3_set_eop_interrupt_state(struct amdgpu_device *adev,
 	return 0;
 }
 
-static int gfx_v9_4_3_ih_to_xcc_inst(struct amdgpu_device *adev, int ih_node)
-{
-	int xcc;
-
-	xcc = hweight8(adev->gfx.xcc_mask & GENMASK(ih_node / 2, 0));
-	if (!xcc) {
-		dev_err(adev->dev, "Couldn't find xcc mapping from IH node");
-		return -EINVAL;
-	}
-
-	return xcc - 1;
-}
-
 static int gfx_v9_4_3_eop_irq(struct amdgpu_device *adev,
 			    struct amdgpu_irq_src *source,
 			    struct amdgpu_iv_entry *entry)
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index da1c7ec3f0a8..5050735cba5f 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -555,22 +555,28 @@ static int gmc_v9_0_process_interrupt(struct amdgpu_device *adev,
 	const char *mmhub_cid;
 	const char *hub_name;
 	u64 addr;
-	uint32_t node_id;
+	uint32_t node_id, xcc_id = 0;
 
-	node_id = (adev->ip_versions[GC_HWIP][0] == IP_VERSION(9, 4, 3)) ? entry->node_id : 0;
+	node_id = entry->node_id;
 
 	addr = (u64)entry->src_data[0] << 12;
 	addr |= ((u64)entry->src_data[1] & 0xf) << 44;
 
 	if (entry->client_id == SOC15_IH_CLIENTID_VMC) {
 		hub_name = "mmhub0";
-		hub = &adev->vmhub[AMDGPU_MMHUB0(0)];
+		hub = &adev->vmhub[AMDGPU_MMHUB0(node_id / 4)];
 	} else if (entry->client_id == SOC15_IH_CLIENTID_VMC1) {
 		hub_name = "mmhub1";
 		hub = &adev->vmhub[AMDGPU_MMHUB1(0)];
 	} else {
 		hub_name = "gfxhub0";
-		hub = &adev->vmhub[node_id/2];
+		if (adev->gfx.funcs->ih_node_to_logical_xcc) {
+			xcc_id = adev->gfx.funcs->ih_node_to_logical_xcc(adev,
+				node_id);
+			if (xcc_id < 0)
+				xcc_id = 0;
+		}
+		hub = &adev->vmhub[xcc_id];
 	}
 
 	if (retry_fault) {
-- 
2.39.2

