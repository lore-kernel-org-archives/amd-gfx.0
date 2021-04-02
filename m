Return-Path: <SRS0=/zhQ=I7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD782C433B4
	for <amd-gfx@archiver.kernel.org>; Fri,  2 Apr 2021 06:44:12 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 84CDA610CB
	for <amd-gfx@archiver.kernel.org>; Fri,  2 Apr 2021 06:44:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84CDA610CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 460426EE0E;
	Fri,  2 Apr 2021 06:44:12 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2067.outbound.protection.outlook.com [40.107.93.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BF11A6EE0E
 for <amd-gfx@lists.freedesktop.org>; Fri,  2 Apr 2021 06:44:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PzjEJfBhI2nVZd8+4gXq9o/8nVPINJYp3/mhRgblFlKza/IYvb84KTgY0Vl5R6iehOG2bAWudC13aOtHMpYBHHy0aP9Ef1Ct2NrNtHoOczPRuGNRZlS6LppMA/eJjlc8O2vwzuSnj7rQd4CTflXPVPuWuzvmNCGU2qjQCm+U1UvykSDei7YI4tHS4Nbe1u1oGLIe38e5lhQXaVoohUqXnc4X63ZENMxkm3yIB6t4lseE+xDQzyOARFAi8taY7aWYPjaSQp7jrON+IOThWuZZKnhaGAkd/Kz1ctacPvtXWcTHjBtyCQHBOXmaFBGlvN749xuG9jaUrPYs4rJuOvn6LA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=527dDLGwaj/xXbTp7z4tiW3THdP/qHmcqkHTruIS/uY=;
 b=oYDSj+zDVF7Sqeu2m1dRE2PfGRoNw1vYCR2dP6QPVGcSg49CDLZ8DkEAhbegCokKAUllOjqKwXs6aGR41mCMBoKycir1APh9dWyAzLPTBpnw1GLmIdu4L5/+LSHuwqLQsvvovGP+sjgZbFH7Xm0Q0QHjEziqW3Se4aOQh6I3XNypbTDEty8YB/47Qqb6tFOzG0IH3iLruX+Rz5laIpCcXRmA5HnagqFFA1hU5tIGI4L6U8neDoYZNAisL4CeBfBPWkIqnhg8RjRkpkRlkhdidwgtP44BDI6b3fVLQTMH1vOnfVYGEygjqSuY9b1MB+ueLdsOJ923ci/v4HmJy2j0BA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=527dDLGwaj/xXbTp7z4tiW3THdP/qHmcqkHTruIS/uY=;
 b=pYtAA5fNUeFSIIuYnhvrfJoK2il+g/qGA9vxOs59zR57UCJ5tp3F6w26kgaUqStcdiz9S1m1eG7iqp7T9Iq3Ipjgz6PhrdAisT2tchmbVRfsTJBMKBz6euejE4hlPTWEm6z4G536+6Rb3OIqXoQeryY60PCJ7i4A4YWNllEWK4A=
Received: from DM6PR04CA0005.namprd04.prod.outlook.com (2603:10b6:5:334::10)
 by CH2PR12MB4038.namprd12.prod.outlook.com (2603:10b6:610:7b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.27; Fri, 2 Apr
 2021 06:44:06 +0000
Received: from DM6NAM11FT055.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:334:cafe::ce) by DM6PR04CA0005.outlook.office365.com
 (2603:10b6:5:334::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.26 via Frontend
 Transport; Fri, 2 Apr 2021 06:44:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT055.mail.protection.outlook.com (10.13.173.103) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3999.28 via Frontend Transport; Fri, 2 Apr 2021 06:44:05 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Fri, 2 Apr 2021
 01:44:05 -0500
Received: from hawzhang-System-Product-Dev.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2106.2
 via Frontend Transport; Fri, 2 Apr 2021 01:44:03 -0500
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, John Clements <John.Clements@amd.com>,
 Dennis Li <Dennis.Li@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 06/11] drm/amdgpu: split nbio callbacks into ras and non-ras
 ones
Date: Fri, 2 Apr 2021 14:43:40 +0800
Message-ID: <20210402064345.14093-6-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210402064345.14093-1-Hawking.Zhang@amd.com>
References: <20210402064345.14093-1-Hawking.Zhang@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 934a759a-804f-46cb-99ac-08d8f5a2b5f8
X-MS-TrafficTypeDiagnostic: CH2PR12MB4038:
X-Microsoft-Antispam-PRVS: <CH2PR12MB4038B7A9443924BB97DAA07DFC7A9@CH2PR12MB4038.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:462;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yG0/lt+KGxPNOIHAcDR+VUUxVv4Wg/6VF2W/ASvbNH/Nz9cT37ApxDdMoOv74BHt6k1odnC2VUgtgqKhta5FzipV7VWGaHMZgnb5P0viCr1wMFp3uGh21XeoQk0BquUSXnP6p5zi99+l304sfzW5T6CLP9PWcwKHtc/O64VTyD2AocsgOiWH9Q5OSznV0IK2bJMSlawwqdIi2OYoqdhcTNEl0h1cO7vs1Okrx4yC+eJl2cJ37k0u7QkGL8shMV8zyVI2L6/hfJ5LOvOcymiCi9EYW/TB+aGkS03I7eHBNLWsVBamBD3Ofbr83NPIG0uy1/3izJlQqeIIf5Cm93P6lo5QsrwgrcGrC2xWZfnhiiLtWub2M0SDIb6NGEB7XPh5gjL0LherqwrwuCaUEGXDoZYFcnzIAyUxATgStt74QmP/HMsMwzHVTET1nzBonjw0DmYnlcXVrQP76YE14unZrwDhUQXg3vwI9v85yEBgJK6PbmODl5wjymsdkhvc99cfxpJ/Z6kVRWQof5dt3sIJbGBynpwHMnvg0PCGxx1ZiH7ImxKgTNozC5N9YagrSv666IWs9P1ByXihk2IJQC2U1j7cpwzwNM7LIN/77YiDIRlYL51PROBz7RsdkXh331tyUhvwPTttv2HZrhngWVt6l3ZCD9xgsYNxsYAIK7bVSlDoE1MQoh7WeQceb2oRrOOC
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(376002)(346002)(136003)(39860400002)(396003)(46966006)(36840700001)(4326008)(6636002)(6666004)(82310400003)(478600001)(5660300002)(426003)(2906002)(356005)(82740400003)(83380400001)(70586007)(316002)(186003)(7696005)(2616005)(336012)(110136005)(47076005)(70206006)(26005)(86362001)(8676002)(81166007)(36860700001)(1076003)(8936002)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2021 06:44:05.8431 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 934a759a-804f-46cb-99ac-08d8f5a2b5f8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT055.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4038
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

nbio ras is not managed by gpu driver when gpu is
connected to cpu through xgmi. split nbio callbacks
into ras and non-ras ones so gpu driver only
initializes nbio ras callbacks when it manages
nbio ras.

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reivewed-by: Dennis Li <Dennis.Li@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c  | 12 +++++-----
 drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h | 19 +++++++++------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c  | 30 +++++++++++++++++++-----
 drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c   | 16 ++++++++-----
 drivers/gpu/drm/amd/amdgpu/nbio_v7_4.h   |  1 +
 drivers/gpu/drm/amd/amdgpu/soc15.c       | 15 ++++++++----
 6 files changed, 63 insertions(+), 30 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
index 03412543427a..90f50561b43a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
@@ -199,13 +199,13 @@ irqreturn_t amdgpu_irq_handler(int irq, void *arg)
 	 * ack the interrupt if it is there
 	 */
 	if (amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__PCIE_BIF)) {
-		if (adev->nbio.funcs &&
-		    adev->nbio.funcs->handle_ras_controller_intr_no_bifring)
-			adev->nbio.funcs->handle_ras_controller_intr_no_bifring(adev);
+		if (adev->nbio.ras_funcs &&
+		    adev->nbio.ras_funcs->handle_ras_controller_intr_no_bifring)
+			adev->nbio.ras_funcs->handle_ras_controller_intr_no_bifring(adev);
 
-		if (adev->nbio.funcs &&
-		    adev->nbio.funcs->handle_ras_err_event_athub_intr_no_bifring)
-			adev->nbio.funcs->handle_ras_err_event_athub_intr_no_bifring(adev);
+		if (adev->nbio.ras_funcs &&
+		    adev->nbio.ras_funcs->handle_ras_err_event_athub_intr_no_bifring)
+			adev->nbio.ras_funcs->handle_ras_err_event_athub_intr_no_bifring(adev);
 	}
 
 	return ret;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h
index 7c11bce4514b..25ee53545837 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h
@@ -47,6 +47,17 @@ struct nbio_hdp_flush_reg {
 	u32 ref_and_mask_sdma7;
 };
 
+struct amdgpu_nbio_ras_funcs {
+	void (*handle_ras_controller_intr_no_bifring)(struct amdgpu_device *adev);
+	void (*handle_ras_err_event_athub_intr_no_bifring)(struct amdgpu_device *adev);
+	int (*init_ras_controller_interrupt)(struct amdgpu_device *adev);
+	int (*init_ras_err_event_athub_interrupt)(struct amdgpu_device *adev);
+	void (*query_ras_error_count)(struct amdgpu_device *adev,
+				      void *ras_error_status);
+	int (*ras_late_init)(struct amdgpu_device *adev);
+	void (*ras_fini)(struct amdgpu_device *adev);
+};
+
 struct amdgpu_nbio_funcs {
 	const struct nbio_hdp_flush_reg *hdp_flush_reg;
 	u32 (*get_hdp_flush_req_offset)(struct amdgpu_device *adev);
@@ -79,13 +90,6 @@ struct amdgpu_nbio_funcs {
 	void (*ih_control)(struct amdgpu_device *adev);
 	void (*init_registers)(struct amdgpu_device *adev);
 	void (*remap_hdp_registers)(struct amdgpu_device *adev);
-	void (*handle_ras_controller_intr_no_bifring)(struct amdgpu_device *adev);
-	void (*handle_ras_err_event_athub_intr_no_bifring)(struct amdgpu_device *adev);
-	int (*init_ras_controller_interrupt)(struct amdgpu_device *adev);
-	int (*init_ras_err_event_athub_interrupt)(struct amdgpu_device *adev);
-	void (*query_ras_error_count)(struct amdgpu_device *adev,
-					void *ras_error_status);
-	int (*ras_late_init)(struct amdgpu_device *adev);
 	void (*enable_aspm)(struct amdgpu_device *adev,
 			    bool enable);
 	void (*program_aspm)(struct amdgpu_device *adev);
@@ -97,6 +101,7 @@ struct amdgpu_nbio {
 	struct amdgpu_irq_src ras_err_event_athub_irq;
 	struct ras_common_if *ras_if;
 	const struct amdgpu_nbio_funcs *funcs;
+	const struct amdgpu_nbio_ras_funcs *ras_funcs;
 };
 
 int amdgpu_nbio_ras_late_init(struct amdgpu_device *adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 1708045e2a0d..ac3f4c3266bc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -804,8 +804,9 @@ int amdgpu_ras_query_error_status(struct amdgpu_device *adev,
 			adev->mmhub.funcs->query_ras_error_status(adev);
 		break;
 	case AMDGPU_RAS_BLOCK__PCIE_BIF:
-		if (adev->nbio.funcs->query_ras_error_count)
-			adev->nbio.funcs->query_ras_error_count(adev, &err_data);
+		if (adev->nbio.ras_funcs &&
+		    adev->nbio.ras_funcs->query_ras_error_count)
+			adev->nbio.ras_funcs->query_ras_error_count(adev, &err_data);
 		break;
 	case AMDGPU_RAS_BLOCK__XGMI_WAFL:
 		amdgpu_xgmi_query_ras_error_count(adev, &err_data);
@@ -2030,14 +2031,31 @@ int amdgpu_ras_init(struct amdgpu_device *adev)
 	/* Might need get this flag from vbios. */
 	con->flags = RAS_DEFAULT_FLAGS;
 
-	if (adev->nbio.funcs->init_ras_controller_interrupt) {
-		r = adev->nbio.funcs->init_ras_controller_interrupt(adev);
+	/* initialize nbio ras function ahead of any other
+	 * ras functions so hardware fatal error interrupt
+	 * can be enabled as early as possible */
+	switch (adev->asic_type) {
+	case CHIP_VEGA20:
+	case CHIP_ARCTURUS:
+	case CHIP_ALDEBARAN:
+		if (!adev->gmc.xgmi.connected_to_cpu)
+			adev->nbio.ras_funcs = &nbio_v7_4_ras_funcs;
+		break;
+	default:
+		/* nbio ras is not available */
+		break;
+	}
+
+	if (adev->nbio.ras_funcs &&
+	    adev->nbio.ras_funcs->init_ras_controller_interrupt) {
+		r = adev->nbio.ras_funcs->init_ras_controller_interrupt(adev);
 		if (r)
 			goto release_con;
 	}
 
-	if (adev->nbio.funcs->init_ras_err_event_athub_interrupt) {
-		r = adev->nbio.funcs->init_ras_err_event_athub_interrupt(adev);
+	if (adev->nbio.ras_funcs &&
+	    adev->nbio.ras_funcs->init_ras_err_event_athub_interrupt) {
+		r = adev->nbio.ras_funcs->init_ras_err_event_athub_interrupt(adev);
 		if (r)
 			goto release_con;
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c b/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
index c477f8972d5d..af44aad78171 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
@@ -557,6 +557,16 @@ static void nbio_v7_4_enable_doorbell_interrupt(struct amdgpu_device *adev,
 		       DOORBELL_INTERRUPT_DISABLE, enable ? 0 : 1);
 }
 
+const struct amdgpu_nbio_ras_funcs nbio_v7_4_ras_funcs = {
+	.handle_ras_controller_intr_no_bifring = nbio_v7_4_handle_ras_controller_intr_no_bifring,
+	.handle_ras_err_event_athub_intr_no_bifring = nbio_v7_4_handle_ras_err_event_athub_intr_no_bifring,
+	.init_ras_controller_interrupt = nbio_v7_4_init_ras_controller_interrupt,
+	.init_ras_err_event_athub_interrupt = nbio_v7_4_init_ras_err_event_athub_interrupt,
+	.query_ras_error_count = nbio_v7_4_query_ras_error_count,
+	.ras_late_init = amdgpu_nbio_ras_late_init,
+	.ras_fini = amdgpu_nbio_ras_fini,
+};
+
 const struct amdgpu_nbio_funcs nbio_v7_4_funcs = {
 	.get_hdp_flush_req_offset = nbio_v7_4_get_hdp_flush_req_offset,
 	.get_hdp_flush_done_offset = nbio_v7_4_get_hdp_flush_done_offset,
@@ -577,10 +587,4 @@ const struct amdgpu_nbio_funcs nbio_v7_4_funcs = {
 	.ih_control = nbio_v7_4_ih_control,
 	.init_registers = nbio_v7_4_init_registers,
 	.remap_hdp_registers = nbio_v7_4_remap_hdp_registers,
-	.handle_ras_controller_intr_no_bifring = nbio_v7_4_handle_ras_controller_intr_no_bifring,
-	.handle_ras_err_event_athub_intr_no_bifring = nbio_v7_4_handle_ras_err_event_athub_intr_no_bifring,
-	.init_ras_controller_interrupt = nbio_v7_4_init_ras_controller_interrupt,
-	.init_ras_err_event_athub_interrupt = nbio_v7_4_init_ras_err_event_athub_interrupt,
-	.query_ras_error_count = nbio_v7_4_query_ras_error_count,
-	.ras_late_init = amdgpu_nbio_ras_late_init,
 };
diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.h b/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.h
index b1ac82872752..b8216581ec8d 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.h
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.h
@@ -28,5 +28,6 @@
 
 extern const struct nbio_hdp_flush_reg nbio_v7_4_hdp_flush_reg;
 extern const struct amdgpu_nbio_funcs nbio_v7_4_funcs;
+extern const struct amdgpu_nbio_ras_funcs nbio_v7_4_ras_funcs;
 
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
index 64c98b9c7fe8..5c5eb3aed1b3 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -1523,8 +1523,9 @@ static int soc15_common_late_init(void *handle)
 	if (adev->hdp.funcs->reset_ras_error_count)
 		adev->hdp.funcs->reset_ras_error_count(adev);
 
-	if (adev->nbio.funcs->ras_late_init)
-		r = adev->nbio.funcs->ras_late_init(adev);
+	if (adev->nbio.ras_funcs &&
+	    adev->nbio.ras_funcs->ras_late_init)
+		r = adev->nbio.ras_funcs->ras_late_init(adev);
 
 	return r;
 }
@@ -1545,7 +1546,9 @@ static int soc15_common_sw_fini(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
-	amdgpu_nbio_ras_fini(adev);
+	if (adev->nbio.ras_funcs &&
+	    adev->nbio.ras_funcs->ras_fini)
+		adev->nbio.ras_funcs->ras_fini(adev);
 	adev->df.funcs->sw_fini(adev);
 	return 0;
 }
@@ -1609,9 +1612,11 @@ static int soc15_common_hw_fini(void *handle)
 
 	if (adev->nbio.ras_if &&
 	    amdgpu_ras_is_supported(adev, adev->nbio.ras_if->block)) {
-		if (adev->nbio.funcs->init_ras_controller_interrupt)
+		if (adev->nbio.ras_funcs &&
+		    adev->nbio.ras_funcs->init_ras_controller_interrupt)
 			amdgpu_irq_put(adev, &adev->nbio.ras_controller_irq, 0);
-		if (adev->nbio.funcs->init_ras_err_event_athub_interrupt)
+		if (adev->nbio.ras_funcs &&
+		    adev->nbio.ras_funcs->init_ras_err_event_athub_interrupt)
 			amdgpu_irq_put(adev, &adev->nbio.ras_err_event_athub_irq, 0);
 	}
 
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
