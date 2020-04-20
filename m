Return-Path: <SRS0=ehRF=6E=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F634C3A5A0
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Apr 2020 10:17:11 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E9B6C2145D
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Apr 2020 10:17:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ZUyatZuU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9B6C2145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AF2496E16F;
	Mon, 20 Apr 2020 10:17:10 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2082.outbound.protection.outlook.com [40.107.92.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 73D0A6E16F
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Apr 2020 10:17:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YfzXoPd+p9PhEis+ElbocvY/6mdFR3DJbREYq9AYJ3rkEw7LnAym92+m3VfBKbiXJlk4tnDXsmtvfOM9/qUBcKbxcTOm9F+7KOjxuz/iUBuZhEsk/GHkY2Gy9yy58tIgIopxOuoFpNrVbi2sm1R9plsILlp4cX+N3337CvTsM/yNlZL1cF49jiuhzzHkkTMZnjL3uvvh3+eqifwts2rG8x8J4IphNvw+QsjtO24XtlfwcxLrDYgOvljVAsElmW9boexcn9bTXPBP5IeS3ZGSNUj/Mq3PFcY78zq/C4HdDYNLNpgi9FLWMvjDW/mXT7ZcGbWoAc4OOLmW/7+2ONfjkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2mcvAmbS6uR7gQW39fLD/bvpEZWxdR+X5iogecHB9Nw=;
 b=Itth/IHGE7IvTEpEZ/Rr0U2ejXT2jzgh3YFXAktYgmRoJFK2XA0XybMjW4S7uwfp/wn+kPmfIWYuHlUSXbmpIC7Y1SfLPzcSvL1GeXf5982rx5xN+DWcsJpXk5QlAqle6YnwrZ7MIS0rsfeDEUhwI6pB54ZIiCb4eBjAIJpQJM6YOLbI7ILqLxAmXzoqeET03tPPeO7sdsd9i6MBGAlKynERRP7+QCaFxgRDSEDZFKWVFtJXvaWsvvEEvDIOB65v3IuP3TsdaM7ozXLdrW2vxdoZa7dhb9nwl648xcBbFpH2wHmqxoTENoEiemDLhTzKBE/d3NIYcHcIRAYnntIsmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2mcvAmbS6uR7gQW39fLD/bvpEZWxdR+X5iogecHB9Nw=;
 b=ZUyatZuUWqeZgT5SmTuQxbBAfSyCPUymXuVxhBY3jV/v+aNxJUgIAv1ERrKXttiPA0Q8RQhfMgXq/UoJxRnElBvlnG89HKZiuBnXFBnT2B1QxU303VDLAl9JsCtjScsThMfWeLg2W/GGex/uhV6JUkAxbOdQtucwrIDN4n4Mu64=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Hawking.Zhang@amd.com; 
Received: from DM6PR12MB4075.namprd12.prod.outlook.com (2603:10b6:5:21d::8) by
 DM6PR12MB3225.namprd12.prod.outlook.com (2603:10b6:5:188::19) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2921.25; Mon, 20 Apr 2020 10:17:07 +0000
Received: from DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::50d1:ecd6:255c:fbcd]) by DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::50d1:ecd6:255c:fbcd%3]) with mapi id 15.20.2921.030; Mon, 20 Apr 2020
 10:17:07 +0000
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 John Clements <john.clements@amd.com>, Guchun Chen <Guchun.Chen@amd.com>
Subject: [PATCH 1/8] drm/amdgpu: retire support_vmr_ring interface
Date: Mon, 20 Apr 2020 18:16:37 +0800
Message-Id: <1587377804-3836-2-git-send-email-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1587377804-3836-1-git-send-email-Hawking.Zhang@amd.com>
References: <1587377804-3836-1-git-send-email-Hawking.Zhang@amd.com>
X-ClientProxiedBy: HK2PR0302CA0007.apcprd03.prod.outlook.com
 (2603:1096:202::17) To DM6PR12MB4075.namprd12.prod.outlook.com
 (2603:10b6:5:21d::8)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from hawzhang-All-Series.amd.com (180.167.199.189) by
 HK2PR0302CA0007.apcprd03.prod.outlook.com (2603:1096:202::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.2937.6 via Frontend Transport; Mon, 20 Apr 2020 10:17:05 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [180.167.199.189]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 006eaefd-a74d-4a77-1403-08d7e513fafa
X-MS-TrafficTypeDiagnostic: DM6PR12MB3225:|DM6PR12MB3225:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB32256583678D890119D269B1FCD40@DM6PR12MB3225.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-Forefront-PRVS: 03793408BA
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4075.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(376002)(346002)(396003)(39860400002)(366004)(136003)(26005)(2616005)(16526019)(956004)(316002)(186003)(6486002)(6636002)(2906002)(30864003)(86362001)(478600001)(6666004)(8676002)(36756003)(4326008)(5660300002)(66556008)(66946007)(66476007)(7696005)(52116002)(110136005)(81156014)(8936002);
 DIR:OUT; SFP:1101; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +312Q0LI3mhw5LsbvnfJGLsZXQSP49EmEHIqhKwSHNSd2gPmseqA8U7tdXC67CZjA4t3WZqyaaEUBnzBMgCyVaO1A5jy6F4mckTtE2abd3dOafwTarlDMbjCnOtlgrANM00ayDsFsBTLJqkLjIA9VWEqdiRy6zSA4unO1P5da1rfNsZPODdVoqxkbdpmwBTTGtkUZAMldqyEwHa6NuKYKxQM8Mo3udjrD7FFrAw3WMh/JUTlcv+FMB2QUgljqBti4OIlj13Qk/0jFZ86k1H79sUr2atJk7/+vsngI/5VguHDhx1Z6NOhktdUedP3Je9plYymSsQQP9V97fLGw9RIDhK5HtSOgD+PU5S/lYwvDDm6UngbgJ5zIbKzxMS+RlDB54dji8EXRVTNJhUvcDnDkY6BXd9O3M7XshSh6B+aXa/Ikt5hdrW4lYCpOUaelBNm
X-MS-Exchange-AntiSpam-MessageData: 0ytdFMygHheJ4afJRrs9NMdfEni+aCyxRBT9/PwfXa57VhxM7i7nfAUnWzTn86wj9tWLNuFKP7x79uWNBSkFszjbTtWvRJOTsiqzqJlW6E9lZoy5MAYjdiFFZoC4cgt1IEhwFxuz4yLM4k8+L6sTjg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 006eaefd-a74d-4a77-1403-08d7e513fafa
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2020 10:17:07.7382 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1CSgB8ZeV8lCWNXRtGOui+5UKvp7ylE94/CGqsaHlNPSUU7UzD+MegmjHvIsGWkpKxX6PzIgfHRN9RjyOU/QrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3225
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
Cc: Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

vmr ring is dedicated for sriov vf (i.e.guest driver
in sriov), which is general communication interface
between driver and psp fw accross all ip version.
it is not correct to make it as ip specific callback.
it is even worse to check specific tOS version per IP
version (like psp_v11/v12).

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h |  3 --
 drivers/gpu/drm/amd/amdgpu/psp_v11_0.c  | 18 +++--------
 drivers/gpu/drm/amd/amdgpu/psp_v12_0.c  | 17 +++-------
 drivers/gpu/drm/amd/amdgpu/psp_v3_1.c   | 56 +++++++++++----------------------
 5 files changed, 30 insertions(+), 66 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 8020f18..901ee79 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -274,7 +274,7 @@ static void psp_prep_tmr_cmd_buf(struct psp_context *psp,
 				 struct psp_gfx_cmd_resp *cmd,
 				 uint64_t tmr_mc, uint32_t size)
 {
-	if (psp_support_vmr_ring(psp))
+	if (amdgpu_sriov_vf(psp->adev))
 		cmd->cmd_id = GFX_CMD_ID_SETUP_VMR;
 	else
 		cmd->cmd_id = GFX_CMD_ID_SETUP_TMR;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
index 6a717fd..65a7d0a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
@@ -104,7 +104,6 @@ struct psp_funcs
 				      struct psp_xgmi_topology_info *topology);
 	int (*xgmi_set_topology_info)(struct psp_context *psp, int number_devices,
 				      struct psp_xgmi_topology_info *topology);
-	bool (*support_vmr_ring)(struct psp_context *psp);
 	int (*ras_trigger_error)(struct psp_context *psp,
 			struct ta_ras_trigger_error_input *info);
 	int (*ras_cure_posion)(struct psp_context *psp, uint64_t *mode_ptr);
@@ -320,8 +319,6 @@ struct amdgpu_psp_funcs {
 		((psp)->funcs->bootloader_load_sos ? (psp)->funcs->bootloader_load_sos((psp)) : 0)
 #define psp_smu_reload_quirk(psp) \
 		((psp)->funcs->smu_reload_quirk ? (psp)->funcs->smu_reload_quirk((psp)) : false)
-#define psp_support_vmr_ring(psp) \
-		((psp)->funcs->support_vmr_ring ? (psp)->funcs->support_vmr_ring((psp)) : false)
 #define psp_mode1_reset(psp) \
 		((psp)->funcs->mode1_reset ? (psp)->funcs->mode1_reset((psp)) : false)
 #define psp_xgmi_get_node_id(psp, node_id) \
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
index 0afd610..46ef008 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
@@ -446,13 +446,6 @@ static int psp_v11_0_ring_init(struct psp_context *psp,
 	return 0;
 }
 
-static bool psp_v11_0_support_vmr_ring(struct psp_context *psp)
-{
-	if (amdgpu_sriov_vf(psp->adev) && psp->sos_fw_version > 0x80045)
-		return true;
-	return false;
-}
-
 static int psp_v11_0_ring_stop(struct psp_context *psp,
 			      enum psp_ring_type ring_type)
 {
@@ -460,7 +453,7 @@ static int psp_v11_0_ring_stop(struct psp_context *psp,
 	struct amdgpu_device *adev = psp->adev;
 
 	/* Write the ring destroy command*/
-	if (psp_v11_0_support_vmr_ring(psp))
+	if (amdgpu_sriov_vf(adev))
 		WREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_101,
 				     GFX_CTRL_CMD_ID_DESTROY_GPCOM_RING);
 	else
@@ -471,7 +464,7 @@ static int psp_v11_0_ring_stop(struct psp_context *psp,
 	mdelay(20);
 
 	/* Wait for response flag (bit 31) */
-	if (psp_v11_0_support_vmr_ring(psp))
+	if (amdgpu_sriov_vf(adev))
 		ret = psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, mmMP0_SMN_C2PMSG_101),
 				   0x80000000, 0x80000000, false);
 	else
@@ -489,7 +482,7 @@ static int psp_v11_0_ring_create(struct psp_context *psp,
 	struct psp_ring *ring = &psp->km_ring;
 	struct amdgpu_device *adev = psp->adev;
 
-	if (psp_v11_0_support_vmr_ring(psp)) {
+	if (amdgpu_sriov_vf(adev)) {
 		ret = psp_v11_0_ring_stop(psp, ring_type);
 		if (ret) {
 			DRM_ERROR("psp_v11_0_ring_stop_sriov failed!\n");
@@ -1099,7 +1092,7 @@ static uint32_t psp_v11_0_ring_get_wptr(struct psp_context *psp)
 	uint32_t data;
 	struct amdgpu_device *adev = psp->adev;
 
-	if (psp_v11_0_support_vmr_ring(psp))
+	if (amdgpu_sriov_vf(adev))
 		data = RREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_102);
 	else
 		data = RREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_67);
@@ -1111,7 +1104,7 @@ static void psp_v11_0_ring_set_wptr(struct psp_context *psp, uint32_t value)
 {
 	struct amdgpu_device *adev = psp->adev;
 
-	if (psp_v11_0_support_vmr_ring(psp)) {
+	if (amdgpu_sriov_vf(adev)) {
 		WREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_102, value);
 		WREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_101, GFX_CTRL_CMD_ID_CONSUME_CMD);
 	} else
@@ -1209,7 +1202,6 @@ static const struct psp_funcs psp_v11_0_funcs = {
 	.xgmi_set_topology_info = psp_v11_0_xgmi_set_topology_info,
 	.xgmi_get_hive_id = psp_v11_0_xgmi_get_hive_id,
 	.xgmi_get_node_id = psp_v11_0_xgmi_get_node_id,
-	.support_vmr_ring = psp_v11_0_support_vmr_ring,
 	.ras_trigger_error = psp_v11_0_ras_trigger_error,
 	.ras_cure_posion = psp_v11_0_ras_cure_posion,
 	.rlc_autoload_start = psp_v11_0_rlc_autoload_start,
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v12_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v12_0.c
index 58d8b6d..17e4475 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v12_0.c
@@ -228,13 +228,6 @@ static int psp_v12_0_ring_init(struct psp_context *psp,
 	return 0;
 }
 
-static bool psp_v12_0_support_vmr_ring(struct psp_context *psp)
-{
-	if (amdgpu_sriov_vf(psp->adev) && psp->sos_fw_version > 0x80045)
-		return true;
-	return false;
-}
-
 static int psp_v12_0_ring_create(struct psp_context *psp,
 				enum psp_ring_type ring_type)
 {
@@ -243,7 +236,7 @@ static int psp_v12_0_ring_create(struct psp_context *psp,
 	struct psp_ring *ring = &psp->km_ring;
 	struct amdgpu_device *adev = psp->adev;
 
-	if (psp_v12_0_support_vmr_ring(psp)) {
+	if (amdgpu_sriov_vf(psp->adev)) {
 		/* Write low address of the ring to C2PMSG_102 */
 		psp_ring_reg = lower_32_bits(ring->ring_mem_mc_addr);
 		WREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_102, psp_ring_reg);
@@ -295,7 +288,7 @@ static int psp_v12_0_ring_stop(struct psp_context *psp,
 	struct amdgpu_device *adev = psp->adev;
 
 	/* Write the ring destroy command*/
-	if (psp_v12_0_support_vmr_ring(psp))
+	if (amdgpu_sriov_vf(adev))
 		WREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_101,
 				     GFX_CTRL_CMD_ID_DESTROY_GPCOM_RING);
 	else
@@ -306,7 +299,7 @@ static int psp_v12_0_ring_stop(struct psp_context *psp,
 	mdelay(20);
 
 	/* Wait for response flag (bit 31) */
-	if (psp_v12_0_support_vmr_ring(psp))
+	if (amdgpu_sriov_vf(adev))
 		ret = psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, mmMP0_SMN_C2PMSG_101),
 				   0x80000000, 0x80000000, false);
 	else
@@ -495,7 +488,7 @@ static uint32_t psp_v12_0_ring_get_wptr(struct psp_context *psp)
 	uint32_t data;
 	struct amdgpu_device *adev = psp->adev;
 
-	if (psp_v12_0_support_vmr_ring(psp))
+	if (amdgpu_sriov_vf(adev))
 		data = RREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_102);
 	else
 		data = RREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_67);
@@ -507,7 +500,7 @@ static void psp_v12_0_ring_set_wptr(struct psp_context *psp, uint32_t value)
 {
 	struct amdgpu_device *adev = psp->adev;
 
-	if (psp_v12_0_support_vmr_ring(psp)) {
+	if (amdgpu_sriov_vf(adev)) {
 		WREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_102, value);
 		WREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_101, GFX_CTRL_CMD_ID_CONSUME_CMD);
 	} else
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v3_1.c b/drivers/gpu/drm/amd/amdgpu/psp_v3_1.c
index 735c43c..bd13625 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v3_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v3_1.c
@@ -52,7 +52,6 @@ MODULE_FIRMWARE("amdgpu/vega12_asd.bin");
 
 static uint32_t sos_old_versions[] = {1517616, 1510592, 1448594, 1446554};
 
-static bool psp_v3_1_support_vmr_ring(struct psp_context *psp);
 static int psp_v3_1_ring_stop(struct psp_context *psp,
 			      enum psp_ring_type ring_type);
 
@@ -302,7 +301,7 @@ static int psp_v3_1_ring_create(struct psp_context *psp,
 
 	psp_v3_1_reroute_ih(psp);
 
-	if (psp_v3_1_support_vmr_ring(psp)) {
+	if (amdgpu_sriov_vf(adev)) {
 		ret = psp_v3_1_ring_stop(psp, ring_type);
 		if (ret) {
 			DRM_ERROR("psp_v3_1_ring_stop_sriov failed!\n");
@@ -360,34 +359,26 @@ static int psp_v3_1_ring_stop(struct psp_context *psp,
 			      enum psp_ring_type ring_type)
 {
 	int ret = 0;
-	unsigned int psp_ring_reg = 0;
 	struct amdgpu_device *adev = psp->adev;
 
-	if (psp_v3_1_support_vmr_ring(psp)) {
-		/* Write the Destroy GPCOM ring command to C2PMSG_101 */
-		psp_ring_reg = GFX_CTRL_CMD_ID_DESTROY_GPCOM_RING;
-		WREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_101, psp_ring_reg);
-
-		/* there might be handshake issue which needs delay */
-		mdelay(20);
-
-		/* Wait for response flag (bit 31) in C2PMSG_101 */
-		ret = psp_wait_for(psp,
-				SOC15_REG_OFFSET(MP0, 0, mmMP0_SMN_C2PMSG_101),
-				0x80000000, 0x80000000, false);
-	} else {
-		/* Write the ring destroy command to C2PMSG_64 */
-		psp_ring_reg = 3 << 16;
-		WREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_64, psp_ring_reg);
+	/* Write the ring destroy command*/
+	if (amdgpu_sriov_vf(adev))
+		WREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_101,
+				     GFX_CTRL_CMD_ID_DESTROY_GPCOM_RING);
+	else
+		WREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_64,
+				     GFX_CTRL_CMD_ID_DESTROY_RINGS);
 
-		/* there might be handshake issue which needs delay */
-		mdelay(20);
+	/* there might be handshake issue with hardware which needs delay */
+	mdelay(20);
 
-		/* Wait for response flag (bit 31) in C2PMSG_64 */
-		ret = psp_wait_for(psp,
-				SOC15_REG_OFFSET(MP0, 0, mmMP0_SMN_C2PMSG_64),
-				0x80000000, 0x80000000, false);
-	}
+	/* Wait for response flag (bit 31) */
+	if (amdgpu_sriov_vf(adev))
+		ret = psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, mmMP0_SMN_C2PMSG_101),
+				   0x80000000, 0x80000000, false);
+	else
+		ret = psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, mmMP0_SMN_C2PMSG_64),
+				   0x80000000, 0x80000000, false);
 
 	return ret;
 }
@@ -575,20 +566,12 @@ static int psp_v3_1_mode1_reset(struct psp_context *psp)
 	return 0;
 }
 
-static bool psp_v3_1_support_vmr_ring(struct psp_context *psp)
-{
-	if (amdgpu_sriov_vf(psp->adev))
-		return true;
-
-	return false;
-}
-
 static uint32_t psp_v3_1_ring_get_wptr(struct psp_context *psp)
 {
 	uint32_t data;
 	struct amdgpu_device *adev = psp->adev;
 
-	if (psp_v3_1_support_vmr_ring(psp))
+	if (amdgpu_sriov_vf(adev))
 		data = RREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_102);
 	else
 		data = RREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_67);
@@ -599,7 +582,7 @@ static void psp_v3_1_ring_set_wptr(struct psp_context *psp, uint32_t value)
 {
 	struct amdgpu_device *adev = psp->adev;
 
-	if (psp_v3_1_support_vmr_ring(psp)) {
+	if (amdgpu_sriov_vf(adev)) {
 		WREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_102, value);
 		/* send interrupt to PSP for SRIOV ring write pointer update */
 		WREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_101,
@@ -619,7 +602,6 @@ static const struct psp_funcs psp_v3_1_funcs = {
 	.compare_sram_data = psp_v3_1_compare_sram_data,
 	.smu_reload_quirk = psp_v3_1_smu_reload_quirk,
 	.mode1_reset = psp_v3_1_mode1_reset,
-	.support_vmr_ring = psp_v3_1_support_vmr_ring,
 	.ring_get_wptr = psp_v3_1_ring_get_wptr,
 	.ring_set_wptr = psp_v3_1_ring_set_wptr,
 };
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
