Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1541EE4993
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Aug 2023 16:04:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7533310E470;
	Wed, 23 Aug 2023 16:04:57 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2073.outbound.protection.outlook.com [40.107.100.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8D69F10E470
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Aug 2023 16:04:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UVZ98RQ0Pdi7TbFGgg7CR5f1xCGbbL6GXA+4EGCSs6qWZ/wx9TkhUiPX3ikmfnp2vf4JIVdULvTx3HwqKYhsJJlSNCjIWaahS/fv1raQRW56lqe2Zy0IcStGLaJdL0U49+ocT+eRgPj07kVcmqajLKdI9He8XwkWzZRnMs3brj2AF9uuxTiPz1apeW+GpSAYGwsnDXuihWoNdzGY0EXie2SB6S1X9tKnHUdaNvm89L+1WUmXsstHXcD8xgP1uea7rVFh7ssI0pmQNo8FxwIssC94KJSlVNdwEZ1kPZGHtp0KulnPeeBMso4f/5WviPUxzJ/mVJiBnfB8VvtysSv5Ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DfmPQS3poVRjww8Le2F7alw1fgItKLvhpSXK/CZmD4o=;
 b=Tkxd+XkBCIIpHO4LOBCo0tebhipdMcPuinAa8MTiAVoVAF7QjXWPZIQaLRIKZDDYrkgVYTMqr3VoClZ8aAwH77FrSF1hpKgZ/VQK4Ib+qVarAbSvlLpeiMM2ij0wbuy5KXPGcgUefn/mJRzrAWHZ8wBjRpae5BHoy1p54J6NKsM2xIvfRbnLfjbZKUWe5bErRE8JN86dIx9GgHBWRrNfPV97bQo40OKqk9qikVI4srFiQHPHZ3husm7pCkhBnpb/iRSpCVCCfEai9rJIR5vKOyw0+Y5WtSe2HsLB6E46vXWBiwLr9Sb1OhxOspl7Za+dh2cn9iqgXz6jme1qhRchDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DfmPQS3poVRjww8Le2F7alw1fgItKLvhpSXK/CZmD4o=;
 b=XddinQMqie9vH+JtYY5lLbhGJ0f6CJFqygJyJlg92f0wrSzXtLhYL181+NzGbRZM5tOG9j6eSpAqV4vZVLZ1dcGoisqIT2V59Kca1PZXgmvneM8sLbma3/Hi1YVjSO0okmrr0wXR13+Lu2sYoCr/0PaCY1z+cJylicFEw4UglJM=
Received: from PA7P264CA0119.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:34c::12)
 by SJ1PR12MB6074.namprd12.prod.outlook.com (2603:10b6:a03:45f::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.26; Wed, 23 Aug
 2023 16:04:49 +0000
Received: from SN1PEPF0002529E.namprd05.prod.outlook.com
 (2603:10a6:102:34c:cafe::99) by PA7P264CA0119.outlook.office365.com
 (2603:10a6:102:34c::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20 via Frontend
 Transport; Wed, 23 Aug 2023 16:04:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002529E.mail.protection.outlook.com (10.167.242.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.14 via Frontend Transport; Wed, 23 Aug 2023 16:04:48 +0000
Received: from hamza-pc.localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 23 Aug
 2023 11:04:37 -0500
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 16/21] drm/amd/display: Skip dmub memory flush when not needed
Date: Wed, 23 Aug 2023 11:58:18 -0400
Message-ID: <20230823160347.176991-17-hamza.mahfooz@amd.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230823160347.176991-1-hamza.mahfooz@amd.com>
References: <20230823160347.176991-1-hamza.mahfooz@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529E:EE_|SJ1PR12MB6074:EE_
X-MS-Office365-Filtering-Correlation-Id: 52d75958-3eb6-43fe-5919-08dba3f2acfa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1btcFIK7PCC1E4Bkvnub04bEs8yKKkfqqP3rMiPdSDPOQQB8UtHB0cfDYK0rRWtiwlqCToThMpOA15ukLQBn4oMK9SfJ2AyAghGKJH7mPH+QtR0y0eovjabDpiwKeCXGKW2qW3PJDSRx7tDXjH+GEVGHB22X2rOjKHhwhKxgcG20Q8w6jLNIxW0uvhip0TVHvbmBO3zk+ogMDRpjbCKIDxZi5Kbh0NbkCMsRzaGMLzfPmSqxEvY511TTt6c8wDqToO1nEDj4Rfa8k+2T7rbQZ5KoVtmo8SGPBAyDk2DJeF/YwLWHXIKlOasdiLWaSlbvgSBOi7E8mwYDWmAX1pgS1GQyY7rpymtYvoHkRMMoWKSwCLNyFBtuNRADx6VF8+iGu3tULpTSgKY0Z2fvVdtDgZtPXua7xvgcd8Qo8STjD8mb6+BzvlXMkr51qYmlFJtT7+xo5NAFF9zjrvrEZxvFaeEMu6+uPisNRJGIbTgGiZ9XrmHvIMyxy0PqG7X5D1uCFfyqIjm7pKJ22TTSOOw6H2njWPw/q1a92lr0oh7sq/irEG71V5qEtFs4toTa/CTx9Uvpwp6hX4PiLrOGpsbsMY5R3iwKY2ZuS5pMakhynkJSBjwOkDPbWd65S8mkII5gaHA3e2LBh1797osbObRvHrpdjgdaUxTnush+LpFlw9wYJz1rVt3l/Ogs2ZFK5CLd+Lo6jAXDFbHskX+QCw8mJL44rEKBeVt7hPrBYijhA6+m5lB7WpeJYBLqp9mfuPYeJoCb7X3OnKgvB6utCJzxu1Pe6b8cKdMC9tgrOX9myBOJw5iIXkIcHwRgoaDH3AbJ
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(136003)(396003)(376002)(346002)(186009)(451199024)(1800799009)(82310400011)(40470700004)(46966006)(36840700001)(2616005)(316002)(6916009)(4326008)(8936002)(8676002)(40480700001)(70586007)(54906003)(70206006)(41300700001)(336012)(426003)(16526019)(26005)(1076003)(5660300002)(44832011)(6666004)(478600001)(83380400001)(40460700003)(47076005)(36860700001)(36756003)(86362001)(2906002)(82740400003)(356005)(81166007)(36900700001)(16060500005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2023 16:04:48.2089 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 52d75958-3eb6-43fe-5919-08dba3f2acfa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002529E.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6074
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
Cc: stylon.wang@amd.com, Dillon
 Varone <dillon.varone@amd.com>, Chris Park <chris.park@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 Daniel Wheeler <daniel.wheeler@amd.com>, solomon.chiu@amd.com,
 jerry.zuo@amd.com, Aurabindo.Pillai@amd.com, hamza.mahfooz@amd.com,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Dillon Varone <dillon.varone@amd.com>

[WHY&HOW]
Readback is only necessary when loaded via CPU.

Reviewed-by: Chris Park <chris.park@amd.com>
Acked-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Dillon Varone <dillon.varone@amd.com>
---
 drivers/gpu/drm/amd/display/dmub/dmub_srv.h     | 8 ++++++++
 drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c | 3 ++-
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dmub/dmub_srv.h b/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
index e7a50cbf2540..7a892f7bc7b0 100644
--- a/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
+++ b/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
@@ -142,6 +142,13 @@ enum dpia_notify_bw_alloc_status {
 	DPIA_BW_ALLOC_CAPS_CHANGED
 };
 
+/* enum dmub_memory_access_type - memory access method */
+enum dmub_memory_access_type {
+	DMUB_MEMORY_ACCESS_DEFAULT,
+	DMUB_MEMORY_ACCESS_CPU = DMUB_MEMORY_ACCESS_DEFAULT,
+	DMUB_MEMORY_ACCESS_DMA
+};
+
 /**
  * struct dmub_region - dmub hw memory region
  * @base: base address for region, must be 256 byte aligned
@@ -264,6 +271,7 @@ struct dmub_srv_hw_params {
 	bool dpia_hpd_int_enable_supported;
 	bool disable_clock_gate;
 	bool disallow_dispclk_dppclk_ds;
+	enum dmub_memory_access_type mem_access_type;
 };
 
 /**
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
index 53464c3e49c1..d7d142c5b06a 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
@@ -564,7 +564,8 @@ enum dmub_status dmub_srv_hw_init(struct dmub_srv *dmub,
 		 * DMCUB when backdoor loading if the write from x86 hasn't been
 		 * flushed yet. This only occurs in backdoor loading.
 		 */
-		dmub_flush_buffer_mem(inst_fb);
+		if (params->mem_access_type == DMUB_MEMORY_ACCESS_CPU)
+			dmub_flush_buffer_mem(inst_fb);
 
 		if (params->fw_in_system_memory && dmub->hw_funcs.backdoor_load_zfb_mode)
 			dmub->hw_funcs.backdoor_load_zfb_mode(dmub, &cw0, &cw1);
-- 
2.41.0

