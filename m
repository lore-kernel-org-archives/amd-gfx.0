Return-Path: <SRS0=EvCx=NS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B06CC432BE
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Aug 2021 20:44:44 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 399E260EE9
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Aug 2021 20:44:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 399E260EE9
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CFB136E9D0;
	Fri, 27 Aug 2021 20:44:43 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2088.outbound.protection.outlook.com [40.107.101.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7FA1D6E9D0
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Aug 2021 20:44:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hlh65POSCEj7FvnSSXPQuuepzKMOeaquueEcYLdrYrKSCyDk1QodaG6336+sUDuGR0KFbeFYnmtB5JR5RBFBE6LFxjAPcrq1ScotK36asPUa11hgCGrIxWTJAr9wj/vbp5Ruf/9MGRfM/U/2KC85CtxSFMtxjmvUG5I+8/0ef2NudDHnk3HNbQ+9lXvKB00KOlrRvETVwaRmNykwHb8GDbcFvNyaPSxfgZaK0tL8iQBEgJ2qAi4O3LA3ldYxxUmkN5t0yRuJP6b4MdTgYSL09x+tqc7ZLYiow4XUBc1zpxhscy5UOX6jGYmOZSEKa9sgms4YnPEqFrT82OQx+vdjCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dLyPBzDC6NfE/NcicgIT6oeb/0r7NCfMp9JwgzuIs9M=;
 b=b5JoJ/uzwsWSo4H4/qzddnwrg0N03DFDK2rcTlI1gPeZ1rmsLWMoVLpnZrYB6R6bCC3FNkLH9NO5OYjhCCYxHM6l3KpXfZHN4TGTdY8b9a2Gj9YErquS83Ml+BX/xgMhvwJTimUriI8lrQuA1vie7Gyb1W94vsNe5EWGUiFowYVbmIx9zRiNCVuZ/OR5XdczZdGYgL2RzRZgW6jrunoT87TbN0Zb39VpHKMJeqDbedAESLp8Ynhjj14WgaDxk2IS4AQS15jvPSON7V7+94FmdNgGxxt0pAT/86wDtIGyjGDqKXniU/rhoo4GrBoHWBK276tiThO2uKdwHuFzrc3Cbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dLyPBzDC6NfE/NcicgIT6oeb/0r7NCfMp9JwgzuIs9M=;
 b=t5P6RY5+2QTCGWDTGfw7+FvrajDqPsy30pMfkJLTC0p2iKUrJVAww/i/2uJADrYW/8r5jqZf3wKUCHfhwecpTq7CAAeCahOgRAW+kvQRaksrr7LJTjCPtDOMIphZwgWC/QiSIC4hNSiM292wRLEZWVhaO3goLwbKitxl/kDUXsM=
Received: from MW4PR04CA0252.namprd04.prod.outlook.com (2603:10b6:303:88::17)
 by DM6PR12MB4926.namprd12.prod.outlook.com (2603:10b6:5:1bb::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19; Fri, 27 Aug
 2021 20:29:35 +0000
Received: from CO1NAM11FT034.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:88:cafe::2b) by MW4PR04CA0252.outlook.office365.com
 (2603:10b6:303:88::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.20 via Frontend
 Transport; Fri, 27 Aug 2021 20:29:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT034.mail.protection.outlook.com (10.13.174.248) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4457.17 via Frontend Transport; Fri, 27 Aug 2021 20:29:34 +0000
Received: from DESKTOP-9DR2N9S.localdomain (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Fri, 27 Aug 2021 15:29:32 -0500
From: Mikita Lipski <mikita.lipski@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Bhawanpreet.Lakha@amd.com>, <Rodrigo.Siqueira@amd.com>,
 <Aurabindo.Pillai@amd.com>, <Qingqing.Zhuo@amd.com>, <mikita.lipski@amd.com>, 
 <Anson.Jacob@amd.com>, Wayne Lin <Wayne.Lin@amd.com>, Nicholas Kazlauskas
 <Nicholas.Kazlauskas@amd.com>
Subject: [PATCH 09/19] drm/amd/display: Fork thread to offload work of
 hpd_rx_irq
Date: Fri, 27 Aug 2021 16:29:00 -0400
Message-ID: <20210827202910.20864-10-mikita.lipski@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210827202910.20864-1-mikita.lipski@amd.com>
References: <20210827202910.20864-1-mikita.lipski@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b82dd023-04e9-4af3-b553-08d96999623b
X-MS-TrafficTypeDiagnostic: DM6PR12MB4926:
X-Microsoft-Antispam-PRVS: <DM6PR12MB4926446474105CB538793098E4C89@DM6PR12MB4926.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:475;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7lyN5bu0wLrfZQtzM83h7r4AY0wHIDUA5rU7DsJR8NXMv1KX8+E1SJDkI3fSksAPDSym7trvldAG3haQR5pNr/6Dsh5J1FrBQBNaQ6RfacoxdaGS7tuz0wnNPzw07wOQ7cHJCjX9JIUl6sEZ40sQjcQc9caqp/ISljKOAR3ULT7pODDtpr/LjWrrbUY6u2YFCcT2MH1/q/MkJfupCmFPt1oQPdExENSlU5WXwHQCVhWP37OcMVBzxMMtIrSXfTJzRsVHbiY7uQRmdxLAlXpMBk+6VoRMWq7P6wmIOS1yrLJfMsvQ0TbF1oGQ3c6nVzmHYNC9WGfqp8eruG5xxOx2c+m18sEBV9Ui2x6yDIinX567sfmOB5z2RxaBIxNzUmsBChtYBATg85JwUOjEJB8aO9Qn4woE/Ha/4yIbR8R/o8LxXt+M5/tbLlDxljjE8PQf6ZJg8xfX3sYDY/DqlsWSoR8dztzF9xSGEKVC/hi5vU/lLwQOopTlhW0IpqzEs98vzKRgX9197UXBwcoN+/9xTPJOEqouJHcstC4xrp3ZlwnPkgxqChnGi69D1eWTpkHsiwXII7t1aPR43Jxc6HoB0AJkDvdD3l9/NaBdkW8HZ3bJNIsZIQKaLQ9o1eI2tBz3RIbO25hLLPKky/xMM17zKDpqTevZI7HzkcQaWg/z+gWVrCgBAEQ6AqlWt8cvupmW520luXRP1iN/KOcQt9CkjEZTaEFOiWKkF/33YZWr2I4=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(39860400002)(346002)(396003)(376002)(136003)(46966006)(36840700001)(6666004)(44832011)(2906002)(36860700001)(1076003)(83380400001)(70206006)(478600001)(4326008)(8936002)(36756003)(316002)(47076005)(5660300002)(54906003)(30864003)(6916009)(2616005)(81166007)(26005)(86362001)(16526019)(426003)(186003)(70586007)(356005)(336012)(82740400003)(82310400003)(8676002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2021 20:29:34.7069 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b82dd023-04e9-4af3-b553-08d96999623b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT034.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4926
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

From: Wayne Lin <Wayne.Lin@amd.com>

[Why]
Currently, we will try to get dm.dc_lock in handle_hpd_rx_irq() when
link lost happened, which is risky and could cause deadlock.
e.g. If we are under procedure to enable MST streams and then monitor
happens to toggle short hpd to notify link lost, then
handle_hpd_rx_irq() will get blocked due to stream enabling flow has
dc_lock. However, under MST, enabling streams involves communication
with remote sinks which need to use handle_hpd_rx_irq() to handle
sideband messages. Thus, we have deadlock here.

[How]
Target is to have handle_hpd_rx_irq() finished as soon as possilble.
Hence we can react to interrupt quickly. Besides, we should avoid to
grabe dm.dc_lock within handle_hpd_rx_irq() to avoid deadlock situation.

Firstly, revert patches which introduced to use dm.dc_lock in
handle_hpd_rx_irq():

* ("drm/amd/display: NULL pointer error during ")

* ("drm/amd/display: Only one display lights up while using MST")

* ("drm/amd/display: take dc_lock in short pulse handler only")

Instead, create work to handle irq events which needs dm.dc_lock.
Besides:

* Create struct hpd_rx_irq_offload_work_queue for each link to handle
  its short hpd events

* Avoid to handle link lost/ automated test if the link is disconnected

* Defer dc_lock needed works in dc_link_handle_hpd_rx_irq(). This
  function should just handle simple stuff for us (e.g. DPCD R/W).
  However, deferred works should still be handled by the order that
  dc_link_handle_hpd_rx_irq() used to be.

* Change function name dm_handle_hpd_rx_irq() to
  dm_handle_mst_sideband_msg() to be more specific

Reviewed-by: Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Acked-by: Mikita Lipski <mikita.lipski@amd.com>
Signed-off-by: Wayne Lin <Wayne.Lin@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 202 +++++++++++++++---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |  49 ++++-
 .../gpu/drm/amd/display/dc/core/dc_link_dp.c  |   9 +-
 drivers/gpu/drm/amd/display/dc/dc_link.h      |   6 +-
 4 files changed, 219 insertions(+), 47 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 0a1dd25e567d..54745ed5898c 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -1083,6 +1083,83 @@ static struct vblank_workqueue *vblank_create_workqueue(struct amdgpu_device *ad
 	return vblank_work;
 }
 #endif
+
+static void dm_handle_hpd_rx_offload_work(struct work_struct *work)
+{
+	struct hpd_rx_irq_offload_work *offload_work;
+	struct amdgpu_dm_connector *aconnector;
+	struct dc_link *dc_link;
+	struct amdgpu_device *adev;
+	enum dc_connection_type new_connection_type = dc_connection_none;
+	unsigned long flags;
+
+	offload_work = container_of(work, struct hpd_rx_irq_offload_work, work);
+	aconnector = offload_work->offload_wq->aconnector;
+
+	if (!aconnector) {
+		DRM_ERROR("Can't retrieve aconnector in hpd_rx_irq_offload_work");
+		goto skip;
+	}
+
+	adev = drm_to_adev(aconnector->base.dev);
+	dc_link = aconnector->dc_link;
+
+	mutex_lock(&aconnector->hpd_lock);
+	if (!dc_link_detect_sink(dc_link, &new_connection_type))
+		DRM_ERROR("KMS: Failed to detect connector\n");
+	mutex_unlock(&aconnector->hpd_lock);
+
+	if (new_connection_type == dc_connection_none)
+		goto skip;
+
+	if (amdgpu_in_reset(adev))
+		goto skip;
+
+	mutex_lock(&adev->dm.dc_lock);
+	if (offload_work->data.bytes.device_service_irq.bits.AUTOMATED_TEST)
+		dc_link_dp_handle_automated_test(dc_link);
+	else if ((dc_link->connector_signal != SIGNAL_TYPE_EDP) &&
+			hpd_rx_irq_check_link_loss_status(dc_link, &offload_work->data) &&
+			dc_link_dp_allow_hpd_rx_irq(dc_link)) {
+		dc_link_dp_handle_link_loss(dc_link);
+		spin_lock_irqsave(&offload_work->offload_wq->offload_lock, flags);
+		offload_work->offload_wq->is_handling_link_loss = false;
+		spin_unlock_irqrestore(&offload_work->offload_wq->offload_lock, flags);
+	}
+	mutex_unlock(&adev->dm.dc_lock);
+
+skip:
+	kfree(offload_work);
+
+}
+
+static struct hpd_rx_irq_offload_work_queue *hpd_rx_irq_create_workqueue(struct dc *dc)
+{
+	int max_caps = dc->caps.max_links;
+	int i = 0;
+	struct hpd_rx_irq_offload_work_queue *hpd_rx_offload_wq = NULL;
+
+	hpd_rx_offload_wq = kcalloc(max_caps, sizeof(*hpd_rx_offload_wq), GFP_KERNEL);
+
+	if (!hpd_rx_offload_wq)
+		return NULL;
+
+
+	for (i = 0; i < max_caps; i++) {
+		hpd_rx_offload_wq[i].wq =
+				    create_singlethread_workqueue("amdgpu_dm_hpd_rx_offload_wq");
+
+		if (hpd_rx_offload_wq[i].wq == NULL) {
+			DRM_ERROR("create amdgpu_dm_hpd_rx_offload_wq fail!");
+			return NULL;
+		}
+
+		spin_lock_init(&hpd_rx_offload_wq[i].offload_lock);
+	}
+
+	return hpd_rx_offload_wq;
+}
+
 static int amdgpu_dm_init(struct amdgpu_device *adev)
 {
 	struct dc_init_data init_data;
@@ -1201,6 +1278,12 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
 
 	dc_hardware_init(adev->dm.dc);
 
+	adev->dm.hpd_rx_offload_wq = hpd_rx_irq_create_workqueue(adev->dm.dc);
+	if (!adev->dm.hpd_rx_offload_wq) {
+		DRM_ERROR("amdgpu: failed to create hpd rx offload workqueue.\n");
+		goto error;
+	}
+
 #if defined(CONFIG_DRM_AMD_DC_DCN)
 	if (adev->apu_flags) {
 		struct dc_phy_addr_space_config pa_config;
@@ -1363,6 +1446,18 @@ static void amdgpu_dm_fini(struct amdgpu_device *adev)
 		adev->dm.freesync_module = NULL;
 	}
 
+	if (adev->dm.hpd_rx_offload_wq) {
+		for (i = 0; i < adev->dm.dc->caps.max_links; i++) {
+			if (adev->dm.hpd_rx_offload_wq[i].wq) {
+				destroy_workqueue(adev->dm.hpd_rx_offload_wq[i].wq);
+				adev->dm.hpd_rx_offload_wq[i].wq = NULL;
+			}
+		}
+
+		kfree(adev->dm.hpd_rx_offload_wq);
+		adev->dm.hpd_rx_offload_wq = NULL;
+	}
+
 	mutex_destroy(&adev->dm.audio_lock);
 	mutex_destroy(&adev->dm.dc_lock);
 
@@ -1981,6 +2076,16 @@ static enum dc_status amdgpu_dm_commit_zero_streams(struct dc *dc)
 	return res;
 }
 
+static void hpd_rx_irq_work_suspend(struct amdgpu_display_manager *dm)
+{
+	int i;
+
+	if (dm->hpd_rx_offload_wq) {
+		for (i = 0; i < dm->dc->caps.max_links; i++)
+			flush_workqueue(dm->hpd_rx_offload_wq[i].wq);
+	}
+}
+
 static int dm_suspend(void *handle)
 {
 	struct amdgpu_device *adev = handle;
@@ -2002,6 +2107,8 @@ static int dm_suspend(void *handle)
 
 		amdgpu_dm_irq_suspend(adev);
 
+		hpd_rx_irq_work_suspend(dm);
+
 		return ret;
 	}
 
@@ -2012,6 +2119,8 @@ static int dm_suspend(void *handle)
 
 	amdgpu_dm_irq_suspend(adev);
 
+	hpd_rx_irq_work_suspend(dm);
+
 	dc_set_power_state(dm->dc, DC_ACPI_CM_POWER_STATE_D3);
 
 	return 0;
@@ -2670,7 +2779,7 @@ static void handle_hpd_irq(void *param)
 
 }
 
-static void dm_handle_hpd_rx_irq(struct amdgpu_dm_connector *aconnector)
+static void dm_handle_mst_sideband_msg(struct amdgpu_dm_connector *aconnector)
 {
 	uint8_t esi[DP_PSR_ERROR_STATUS - DP_SINK_COUNT_ESI] = { 0 };
 	uint8_t dret;
@@ -2748,6 +2857,25 @@ static void dm_handle_hpd_rx_irq(struct amdgpu_dm_connector *aconnector)
 		DRM_DEBUG_DRIVER("Loop exceeded max iterations\n");
 }
 
+static void schedule_hpd_rx_offload_work(struct hpd_rx_irq_offload_work_queue *offload_wq,
+							union hpd_irq_data hpd_irq_data)
+{
+	struct hpd_rx_irq_offload_work *offload_work =
+				kzalloc(sizeof(*offload_work), GFP_KERNEL);
+
+	if (!offload_work) {
+		DRM_ERROR("Failed to allocate hpd_rx_irq_offload_work.\n");
+		return;
+	}
+
+	INIT_WORK(&offload_work->work, dm_handle_hpd_rx_offload_work);
+	offload_work->data = hpd_irq_data;
+	offload_work->offload_wq = offload_wq;
+
+	queue_work(offload_wq->wq, &offload_work->work);
+	DRM_DEBUG_KMS("queue work to handle hpd_rx offload work");
+}
+
 static void handle_hpd_rx_irq(void *param)
 {
 	struct amdgpu_dm_connector *aconnector = (struct amdgpu_dm_connector *)param;
@@ -2759,14 +2887,16 @@ static void handle_hpd_rx_irq(void *param)
 	enum dc_connection_type new_connection_type = dc_connection_none;
 	struct amdgpu_device *adev = drm_to_adev(dev);
 	union hpd_irq_data hpd_irq_data;
-	bool lock_flag = 0;
+	bool link_loss = false;
+	bool has_left_work = false;
+	int idx = aconnector->base.index;
+	struct hpd_rx_irq_offload_work_queue *offload_wq = &adev->dm.hpd_rx_offload_wq[idx];
 
 	memset(&hpd_irq_data, 0, sizeof(hpd_irq_data));
 
 	if (adev->dm.disable_hpd_irq)
 		return;
 
-
 	/*
 	 * TODO:Temporary add mutex to protect hpd interrupt not have a gpio
 	 * conflict, after implement i2c helper, this mutex should be
@@ -2774,43 +2904,41 @@ static void handle_hpd_rx_irq(void *param)
 	 */
 	mutex_lock(&aconnector->hpd_lock);
 
-	read_hpd_rx_irq_data(dc_link, &hpd_irq_data);
+	result = dc_link_handle_hpd_rx_irq(dc_link, &hpd_irq_data,
+						&link_loss, true, &has_left_work);
 
-	if ((dc_link->cur_link_settings.lane_count != LANE_COUNT_UNKNOWN) ||
-		(dc_link->type == dc_connection_mst_branch)) {
-		if (hpd_irq_data.bytes.device_service_irq.bits.UP_REQ_MSG_RDY) {
-			result = true;
-			dm_handle_hpd_rx_irq(aconnector);
-			goto out;
-		} else if (hpd_irq_data.bytes.device_service_irq.bits.DOWN_REP_MSG_RDY) {
-			result = false;
-			dm_handle_hpd_rx_irq(aconnector);
+	if (!has_left_work)
+		goto out;
+
+	if (hpd_irq_data.bytes.device_service_irq.bits.AUTOMATED_TEST) {
+		schedule_hpd_rx_offload_work(offload_wq, hpd_irq_data);
+		goto out;
+	}
+
+	if (dc_link_dp_allow_hpd_rx_irq(dc_link)) {
+		if (hpd_irq_data.bytes.device_service_irq.bits.UP_REQ_MSG_RDY ||
+			hpd_irq_data.bytes.device_service_irq.bits.DOWN_REP_MSG_RDY) {
+			dm_handle_mst_sideband_msg(aconnector);
 			goto out;
 		}
-	}
 
-	/*
-	 * TODO: We need the lock to avoid touching DC state while it's being
-	 * modified during automated compliance testing, or when link loss
-	 * happens. While this should be split into subhandlers and proper
-	 * interfaces to avoid having to conditionally lock like this in the
-	 * outer layer, we need this workaround temporarily to allow MST
-	 * lightup in some scenarios to avoid timeout.
-	 */
-	if (!amdgpu_in_reset(adev) &&
-	    (hpd_rx_irq_check_link_loss_status(dc_link, &hpd_irq_data) ||
-	     hpd_irq_data.bytes.device_service_irq.bits.AUTOMATED_TEST)) {
-		mutex_lock(&adev->dm.dc_lock);
-		lock_flag = 1;
-	}
+		if (link_loss) {
+			bool skip = false;
 
-#ifdef CONFIG_DRM_AMD_DC_HDCP
-	result = dc_link_handle_hpd_rx_irq(dc_link, &hpd_irq_data, NULL);
-#else
-	result = dc_link_handle_hpd_rx_irq(dc_link, NULL, NULL);
-#endif
-	if (!amdgpu_in_reset(adev) && lock_flag)
-		mutex_unlock(&adev->dm.dc_lock);
+			spin_lock(&offload_wq->offload_lock);
+			skip = offload_wq->is_handling_link_loss;
+
+			if (!skip)
+				offload_wq->is_handling_link_loss = true;
+
+			spin_unlock(&offload_wq->offload_lock);
+
+			if (!skip)
+				schedule_hpd_rx_offload_work(offload_wq, hpd_irq_data);
+
+			goto out;
+		}
+	}
 
 out:
 	if (result && !is_mst_root_connector) {
@@ -2895,6 +3023,10 @@ static void register_hpd_handlers(struct amdgpu_device *adev)
 			amdgpu_dm_irq_register_interrupt(adev, &int_params,
 					handle_hpd_rx_irq,
 					(void *) aconnector);
+
+			if (adev->dm.hpd_rx_offload_wq)
+				adev->dm.hpd_rx_offload_wq[connector->index].aconnector =
+					aconnector;
 		}
 	}
 }
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
index 9522d4ca299e..9ac932677c55 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
@@ -151,6 +151,48 @@ struct dal_allocation {
 	u64 gpu_addr;
 };
 
+/**
+ * struct hpd_rx_irq_offload_work_queue - Work queue to handle hpd_rx_irq
+ * offload work
+ */
+struct hpd_rx_irq_offload_work_queue {
+	/**
+	 * @wq: workqueue structure to queue offload work.
+	 */
+	struct workqueue_struct *wq;
+	/**
+	 * @offload_lock: To protect fields of offload work queue.
+	 */
+	spinlock_t offload_lock;
+	/**
+	 * @is_handling_link_loss: Used to prevent inserting link loss event when
+	 * we're handling link loss
+	 */
+	bool is_handling_link_loss;
+	/**
+	 * @aconnector: The aconnector that this work queue is attached to
+	 */
+	struct amdgpu_dm_connector *aconnector;
+};
+
+/**
+ * struct hpd_rx_irq_offload_work - hpd_rx_irq offload work structure
+ */
+struct hpd_rx_irq_offload_work {
+	/**
+	 * @work: offload work
+	 */
+	struct work_struct work;
+	/**
+	 * @data: reference irq data which is used while handling offload work
+	 */
+	union hpd_irq_data data;
+	/**
+	 * @offload_wq: offload work queue that this work is queued to
+	 */
+	struct hpd_rx_irq_offload_work_queue *offload_wq;
+};
+
 /**
  * struct amdgpu_display_manager - Central amdgpu display manager device
  *
@@ -419,7 +461,12 @@ struct amdgpu_display_manager {
 	 */
 	struct crc_rd_work *crc_rd_wrk;
 #endif
-
+	/**
+	 * @hpd_rx_offload_wq:
+	 *
+	 * Work queue to offload works of hpd_rx_irq
+	 */
+	struct hpd_rx_irq_offload_work_queue *hpd_rx_offload_wq;
 	/**
 	 * @mst_encoders:
 	 *
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index f6589dc7a370..4a031db141c2 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -2078,7 +2078,7 @@ static struct dc_link_settings get_max_link_cap(struct dc_link *link)
 	return max_link_cap;
 }
 
-enum dc_status read_hpd_rx_irq_data(
+static enum dc_status read_hpd_rx_irq_data(
 	struct dc_link *link,
 	union hpd_irq_data *irq_data)
 {
@@ -3260,7 +3260,7 @@ void dc_link_dp_handle_link_loss(struct dc_link *link)
 	}
 }
 
-static bool handle_hpd_rx_irq(struct dc_link *link, union hpd_irq_data *out_hpd_irq_dpcd_data, bool *out_link_loss,
+bool dc_link_handle_hpd_rx_irq(struct dc_link *link, union hpd_irq_data *out_hpd_irq_dpcd_data, bool *out_link_loss,
 							bool defer_handling, bool *has_left_work)
 {
 	union hpd_irq_data hpd_irq_dpcd_data = { { { {0} } } };
@@ -3382,11 +3382,6 @@ static bool handle_hpd_rx_irq(struct dc_link *link, union hpd_irq_data *out_hpd_
 	return status;
 }
 
-bool dc_link_handle_hpd_rx_irq(struct dc_link *link, union hpd_irq_data *out_hpd_irq_dpcd_data, bool *out_link_loss)
-{
-	return handle_hpd_rx_irq(link, out_hpd_irq_dpcd_data, out_link_loss, false, NULL);
-}
-
 /*query dpcd for version and mst cap addresses*/
 bool is_mst_supported(struct dc_link *link)
 {
diff --git a/drivers/gpu/drm/amd/display/dc/dc_link.h b/drivers/gpu/drm/amd/display/dc/dc_link.h
index 0efa2bc8639b..9b7c32f7fd86 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_link.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_link.h
@@ -296,7 +296,8 @@ enum dc_status dc_link_allocate_mst_payload(struct pipe_ctx *pipe_ctx);
  * false - no change in Downstream port status. No further action required
  * from DM. */
 bool dc_link_handle_hpd_rx_irq(struct dc_link *dc_link,
-		union hpd_irq_data *hpd_irq_dpcd_data, bool *out_link_loss);
+		union hpd_irq_data *hpd_irq_dpcd_data, bool *out_link_loss,
+		bool defer_handling, bool *has_left_work);
 
 /*
  * On eDP links this function call will stall until T12 has elapsed.
@@ -305,9 +306,6 @@ bool dc_link_handle_hpd_rx_irq(struct dc_link *dc_link,
  */
 bool dc_link_wait_for_t12(struct dc_link *link);
 
-enum dc_status read_hpd_rx_irq_data(
-	struct dc_link *link,
-	union hpd_irq_data *irq_data);
 void dc_link_dp_handle_automated_test(struct dc_link *link);
 void dc_link_dp_handle_link_loss(struct dc_link *link);
 bool dc_link_dp_allow_hpd_rx_irq(const struct dc_link *link);
-- 
2.25.1

