Return-Path: <SRS0=EvCx=NS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFD1CC432BE
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Aug 2021 10:00:00 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 696A360F14
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Aug 2021 10:00:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 696A360F14
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 069356E90E;
	Fri, 27 Aug 2021 10:00:00 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2042.outbound.protection.outlook.com [40.107.236.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 035436E90E
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Aug 2021 09:59:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JdIlL8jZKysWah5Ql2ZIiwNPwYgUOXhIn/SNDg3teD10WA7nVvgAfVop8UuSKBeDQGFPVS4uG1icJjvvInY8uGGRIztnTjBd6l8D2nrOzKeRAb1sKH/eByI1d0C5LMLE8UfQ7nhgps8wkk+Xu+wVLBiFd8lGuSpWKIze+Ei2/7cplTO1jgslU8u59LRKKa2wMgXXpNHb6Gvtn91L4LKDFs3dv+/V+1QQ2zZI8kqW9THmfkmsHACVE8FP8hxc9qAT/9XjAON9woAdZSx86wLd6hAr181RoHa2xmU3tQCvXROsuZtKjLTi1Zmd+muj8ZbApk99jpowgxCU9iwOeFulaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MXpn4UCpzmzc0Ec4SrTETGU97M3XPdGiwHUtFl83jWc=;
 b=VaPoDtR3tXpktBC3HRJ+z2sQyq1lAVHTxR1uIQo/jZ7DerguU+tYc2EmHXjXGPf2tDK73au4C4TO0sxginalPBOasw5IwWFC49fcPee6aY3vdtZDlsBnwoWMa6d/MXAcc12sbVlBGEgCK9uPK8qfPGovhdVk5qhu6pDlZIlBd5U2ZLCpB14KSNcBuC9W469+hSLWbaP20AeaqNpRwVrP25W8jjZKpj0zZoJ50JT/IdvHsQoIHNQ+R3yL/OoD9s7BHE8g/znFe8iKd3xds+urSP6xJIZhaV2hFHv5wJj2rfQejVRV3FQFcoMZAlP7RocjiPmr9IEPrk6KwwsV4wof+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MXpn4UCpzmzc0Ec4SrTETGU97M3XPdGiwHUtFl83jWc=;
 b=LRuwlepFs1Ab0SyGpB1uJL9Fl9b8n2p7VGNNZhr6KgD45dh9FnzHsumqNs1GCmk9vV5Lqoporgne0U1cve3SgZVzCLPGT2il2S4ZDuzanjYPMVjAoNIdBgnNti43UuU5ObzeQRIoaORvG/Aab33TaN11iRJKmjrweur8cNl21Tg=
Received: from DM6PR13CA0051.namprd13.prod.outlook.com (2603:10b6:5:134::28)
 by DM6PR12MB4864.namprd12.prod.outlook.com (2603:10b6:5:209::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19; Fri, 27 Aug
 2021 09:44:21 +0000
Received: from DM6NAM11FT062.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:134:cafe::50) by DM6PR13CA0051.outlook.office365.com
 (2603:10b6:5:134::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.6 via Frontend
 Transport; Fri, 27 Aug 2021 09:44:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT062.mail.protection.outlook.com (10.13.173.40) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4457.17 via Frontend Transport; Fri, 27 Aug 2021 09:44:20 +0000
Received: from canli.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Fri, 27 Aug
 2021 04:44:18 -0500
From: Candice Li <candice.li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: John Clements <john.clements@amd.com>, Candice Li <candice.li@amd.com>
Subject: [PATCH] drm/amd/amdgpu: consolidate PSP TA unload function
Date: Fri, 27 Aug 2021 17:43:43 +0800
Message-ID: <20210827094343.889-1-candice.li@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a0e8938e-b2e9-41a0-18f1-08d9693f3ecf
X-MS-TrafficTypeDiagnostic: DM6PR12MB4864:
X-Microsoft-Antispam-PRVS: <DM6PR12MB4864969AFBD88B971BA506C591C89@DM6PR12MB4864.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3044;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: beHlRqLGdiAepE2Dn/1D1RKEWHiZYOrdKTlk6I3BUTTjaRxOejlEa7Gg9wMZ1W3tUV1NYQgdfjOFDZxnZIQcJBaOfBJdu5Z5lYIOj7BHxd44LXjac5sKp0OwsTbMWgrR7Srd9bXB/WyUfvMd2ECddjSKlsyavZov4DvfHvcxA6wwgs1kSOLIn7K1Sbj2E1oVt2CAgM5gicfFGIOFhX9u59uoB5wnb2rzVGDofchcBdxdp+UjRMbgSKJVbMDn9IS3WG7sypZ6TEAuwy1VI32QtGmq8Ji0LyqB/gL4uq2zIw9dlhHsLTXEK1lGCGVP3MBDuN28IWXKL7vBtmuJDYNbMAlaR59N8mOkKkpE3UQrh/ioH7agvb9KEXG1RfDc8oseHcjM8Ydg2gvsDAXxeGyfgnmnAVu0KwzHNI+XsVcIUSZ7c14aRHooyj1aTlPwt42sYR5Ad1R4TKYSMy5tQIhTPsJ0QXWRjFcamBRFOtA8El4I/5s2TEkQBwNF2jwNRAeqVeSNzgCAI36bt4Qelh5WqlfJJNERs/p4vtSraZJecoc48xVXZWfqIks/3iIBzxpsgtp0izYtxrH90FLCK1kqkjNXuBSlS/KHbAt8SHh6NDO1CURirt5AXOTgrz/wcFtiQyw5Ci7QxF4mafHaJaG5YsrhQ7ZRFl3C3Fw+Y22ppt9mzNxNoutdWEaZiySJ1deAXR+hioV2muX1qwfQDp+fv0mg9/SPbElTOQssDt9zugc=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(396003)(136003)(346002)(376002)(39860400002)(36840700001)(46966006)(47076005)(4326008)(7696005)(426003)(81166007)(70586007)(356005)(70206006)(478600001)(6666004)(336012)(1076003)(316002)(16526019)(54906003)(8936002)(44832011)(8676002)(83380400001)(6916009)(5660300002)(186003)(36756003)(86362001)(82740400003)(36860700001)(2906002)(26005)(2616005)(82310400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2021 09:44:20.6292 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a0e8938e-b2e9-41a0-18f1-08d9693f3ecf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT062.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4864
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

Create common PSP TA unload function and replace all common TA unloading
sequences.

Signed-off-by: Candice Li <candice.li@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 160 ++++++------------------
 1 file changed, 40 insertions(+), 120 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 23efdc67250272..243adce6de3654 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -46,6 +46,9 @@ static int psp_sysfs_init(struct amdgpu_device *adev);
 static void psp_sysfs_fini(struct amdgpu_device *adev);
 
 static int psp_load_smu_fw(struct psp_context *psp);
+static int psp_ta_unload(struct psp_context *psp, uint32_t session_id);
+static int psp_rap_terminate(struct psp_context *psp);
+static int psp_securedisplay_terminate(struct psp_context *psp);
 
 /*
  * Due to DF Cstate management centralized to PMFW, the firmware
@@ -829,10 +832,28 @@ static void psp_prep_ta_unload_cmd_buf(struct psp_gfx_cmd_resp *cmd,
 	cmd->cmd.cmd_unload_ta.session_id = session_id;
 }
 
+static int psp_ta_unload(struct psp_context *psp, uint32_t session_id)
+{
+	int ret;
+	struct psp_gfx_cmd_resp *cmd = acquire_psp_cmd_buf(psp);
+
+	psp_prep_ta_unload_cmd_buf(cmd, session_id);
+
+	ret = psp_cmd_submit_buf(psp, NULL, cmd, psp->fence_buf_mc_addr);
+
+	release_psp_cmd_buf(psp);
+
+	return ret;
+}
+
 static int psp_asd_unload(struct psp_context *psp)
+{
+	return psp_ta_unload(psp, psp->asd_context.session_id);
+}
+
+static int psp_asd_terminate(struct psp_context *psp)
 {
 	int ret;
-	struct psp_gfx_cmd_resp *cmd;
 
 	if (amdgpu_sriov_vf(psp->adev))
 		return 0;
@@ -840,17 +861,11 @@ static int psp_asd_unload(struct psp_context *psp)
 	if (!psp->asd_context.asd_initialized)
 		return 0;
 
-	cmd = acquire_psp_cmd_buf(psp);
-
-	psp_prep_ta_unload_cmd_buf(cmd, psp->asd_context.session_id);
+	ret = psp_asd_unload(psp);
 
-	ret = psp_cmd_submit_buf(psp, NULL, cmd,
-				 psp->fence_buf_mc_addr);
 	if (!ret)
 		psp->asd_context.asd_initialized = false;
 
-	release_psp_cmd_buf(psp);
-
 	return ret;
 }
 
@@ -990,29 +1005,7 @@ static int psp_xgmi_load(struct psp_context *psp)
 
 static int psp_xgmi_unload(struct psp_context *psp)
 {
-	int ret;
-	struct psp_gfx_cmd_resp *cmd;
-	struct amdgpu_device *adev = psp->adev;
-
-	/* XGMI TA unload currently is not supported on Arcturus/Aldebaran A+A */
-	if (adev->asic_type == CHIP_ARCTURUS ||
-		(adev->asic_type == CHIP_ALDEBARAN && adev->gmc.xgmi.connected_to_cpu))
-		return 0;
-
-	/*
-	 * TODO: bypass the unloading in sriov for now
-	 */
-
-	cmd = acquire_psp_cmd_buf(psp);
-
-	psp_prep_ta_unload_cmd_buf(cmd, psp->xgmi_context.context.session_id);
-
-	ret = psp_cmd_submit_buf(psp, NULL, cmd,
-				 psp->fence_buf_mc_addr);
-
-	release_psp_cmd_buf(psp);
-
-	return ret;
+	return psp_ta_unload(psp, psp->xgmi_context.context.session_id);
 }
 
 int psp_xgmi_invoke(struct psp_context *psp, uint32_t ta_cmd_id)
@@ -1023,6 +1016,12 @@ int psp_xgmi_invoke(struct psp_context *psp, uint32_t ta_cmd_id)
 int psp_xgmi_terminate(struct psp_context *psp)
 {
 	int ret;
+	struct amdgpu_device *adev = psp->adev;
+
+	/* XGMI TA unload currently is not supported on Arcturus/Aldebaran A+A */
+	if (adev->asic_type == CHIP_ARCTURUS ||
+		(adev->asic_type == CHIP_ALDEBARAN && adev->gmc.xgmi.connected_to_cpu))
+		return 0;
 
 	if (!psp->xgmi_context.context.initialized)
 		return 0;
@@ -1337,25 +1336,7 @@ static int psp_ras_load(struct psp_context *psp)
 
 static int psp_ras_unload(struct psp_context *psp)
 {
-	int ret;
-	struct psp_gfx_cmd_resp *cmd;
-
-	/*
-	 * TODO: bypass the unloading in sriov for now
-	 */
-	if (amdgpu_sriov_vf(psp->adev))
-		return 0;
-
-	cmd = acquire_psp_cmd_buf(psp);
-
-	psp_prep_ta_unload_cmd_buf(cmd, psp->ras_context.context.session_id);
-
-	ret = psp_cmd_submit_buf(psp, NULL, cmd,
-			psp->fence_buf_mc_addr);
-
-	release_psp_cmd_buf(psp);
-
-	return ret;
+	return psp_ta_unload(psp, psp->ras_context.context.session_id);
 }
 
 int psp_ras_invoke(struct psp_context *psp, uint32_t ta_cmd_id)
@@ -1644,24 +1625,7 @@ static int psp_hdcp_initialize(struct psp_context *psp)
 
 static int psp_hdcp_unload(struct psp_context *psp)
 {
-	int ret;
-	struct psp_gfx_cmd_resp *cmd;
-
-	/*
-	 * TODO: bypass the unloading in sriov for now
-	 */
-	if (amdgpu_sriov_vf(psp->adev))
-		return 0;
-
-	cmd = acquire_psp_cmd_buf(psp);
-
-	psp_prep_ta_unload_cmd_buf(cmd, psp->hdcp_context.context.session_id);
-
-	ret = psp_cmd_submit_buf(psp, NULL, cmd, psp->fence_buf_mc_addr);
-
-	release_psp_cmd_buf(psp);
-
-	return ret;
+	return psp_ta_unload(psp, psp->hdcp_context.context.session_id);
 }
 
 int psp_hdcp_invoke(struct psp_context *psp, uint32_t ta_cmd_id)
@@ -1778,24 +1742,7 @@ static int psp_dtm_initialize(struct psp_context *psp)
 
 static int psp_dtm_unload(struct psp_context *psp)
 {
-	int ret;
-	struct psp_gfx_cmd_resp *cmd;
-
-	/*
-	 * TODO: bypass the unloading in sriov for now
-	 */
-	if (amdgpu_sriov_vf(psp->adev))
-		return 0;
-
-	cmd = acquire_psp_cmd_buf(psp);
-
-	psp_prep_ta_unload_cmd_buf(cmd, psp->dtm_context.context.session_id);
-
-	ret = psp_cmd_submit_buf(psp, NULL, cmd, psp->fence_buf_mc_addr);
-
-	release_psp_cmd_buf(psp);
-
-	return ret;
+	return psp_ta_unload(psp, psp->dtm_context.context.session_id);
 }
 
 int psp_dtm_invoke(struct psp_context *psp, uint32_t ta_cmd_id)
@@ -1877,16 +1824,7 @@ static int psp_rap_load(struct psp_context *psp)
 
 static int psp_rap_unload(struct psp_context *psp)
 {
-	int ret;
-	struct psp_gfx_cmd_resp *cmd = acquire_psp_cmd_buf(psp);
-
-	psp_prep_ta_unload_cmd_buf(cmd, psp->rap_context.context.session_id);
-
-	ret = psp_cmd_submit_buf(psp, NULL, cmd, psp->fence_buf_mc_addr);
-
-	release_psp_cmd_buf(psp);
-
-	return ret;
+	return psp_ta_unload(psp, psp->rap_context.context.session_id);
 }
 
 static int psp_rap_initialize(struct psp_context *psp)
@@ -1918,11 +1856,7 @@ static int psp_rap_initialize(struct psp_context *psp)
 
 	ret = psp_rap_invoke(psp, TA_CMD_RAP__INITIALIZE, &status);
 	if (ret || status != TA_RAP_STATUS__SUCCESS) {
-		psp_rap_unload(psp);
-
-		psp_ta_free_shared_buf(&psp->rap_context.context.mem_context);
-
-		psp->rap_context.context.initialized = false;
+		psp_rap_terminate(psp);
 
 		dev_warn(psp->adev->dev, "RAP TA initialize fail (%d) status %d.\n",
 			 ret, status);
@@ -2022,16 +1956,7 @@ static int psp_securedisplay_load(struct psp_context *psp)
 
 static int psp_securedisplay_unload(struct psp_context *psp)
 {
-	int ret;
-	struct psp_gfx_cmd_resp *cmd = acquire_psp_cmd_buf(psp);
-
-	psp_prep_ta_unload_cmd_buf(cmd, psp->securedisplay_context.context.session_id);
-
-	ret = psp_cmd_submit_buf(psp, NULL, cmd, psp->fence_buf_mc_addr);
-
-	release_psp_cmd_buf(psp);
-
-	return ret;
+	return psp_ta_unload(psp, psp->securedisplay_context.context.session_id);
 }
 
 static int psp_securedisplay_initialize(struct psp_context *psp)
@@ -2066,12 +1991,7 @@ static int psp_securedisplay_initialize(struct psp_context *psp)
 
 	ret = psp_securedisplay_invoke(psp, TA_SECUREDISPLAY_COMMAND__QUERY_TA);
 	if (ret) {
-		psp_securedisplay_unload(psp);
-
-		psp_ta_free_shared_buf(&psp->securedisplay_context.context.mem_context);
-
-		psp->securedisplay_context.context.initialized = false;
-
+		psp_securedisplay_terminate(psp);
 		dev_err(psp->adev->dev, "SECUREDISPLAY TA initialize fail.\n");
 		return -EINVAL;
 	}
@@ -2721,7 +2641,7 @@ static int psp_hw_fini(void *handle)
 		psp_hdcp_terminate(psp);
 	}
 
-	psp_asd_unload(psp);
+	psp_asd_terminate(psp);
 
 	psp_tmr_terminate(psp);
 	psp_ring_destroy(psp, PSP_RING_TYPE__KM);
@@ -2779,9 +2699,9 @@ static int psp_suspend(void *handle)
 		}
 	}
 
-	ret = psp_asd_unload(psp);
+	ret = psp_asd_terminate(psp);
 	if (ret) {
-		DRM_ERROR("Failed to unload asd\n");
+		DRM_ERROR("Failed to terminate asd\n");
 		return ret;
 	}
 
-- 
2.17.1

