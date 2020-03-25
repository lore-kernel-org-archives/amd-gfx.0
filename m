Return-Path: <SRS0=Seja=5K=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF97BC1975A
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Mar 2020 03:58:54 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 96C5F206F6
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Mar 2020 03:58:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="cyNfpFZF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96C5F206F6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 54DA86E05F;
	Wed, 25 Mar 2020 03:58:54 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2069.outbound.protection.outlook.com [40.107.93.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C349A6E05F
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Mar 2020 03:58:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CGGjrtQjEobuc9Pwl3sEfVrJW/D9I91WNz6gT0weTdX9a/r1io5xWMGC9GvWsqIangvDgOIzicvVWzZF92aXSjY6u0Fsy7NI76IlHVHWMuelaY/aqUxKqk34WQmwm9tMjJBpcTXi7lk2G/yNjCHCZYEpcNLcz7tTZyFcO2+506uWqrF1WowPOVQCSir3h8Fr5vwsBgfDrOHRCekREH/XI4pTaE3VjX8sCNs7divE+83z0zCn6NMEQaT8agUzfopRk5hxkFW8hbc4lwVYqThxkjURln5BvX7/KYZffCwfC0eTbW4S89tKqQOGL4nzN54wiY5Vu4t2mPkZHPGHe+sXRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M1URJ4DrsV0POIaYXDOgB5Qw/SNRCdYwcb0p9PPChf8=;
 b=bm9Wryq6fx4hZVbR1WM1fZpQS0oViTiRSKevbWVvgQbZJSoV/ao6LNKkdceRv17AidSRejiU3MbiqxIuOy+uykBQuV9rxu1f7QwpSvyD7pwdiUSat5gnIyl6dvApXIGxfQ8A8B32SRTxQjG/rsGabXQn0NJO5XEiXIJ45Y8a1HO/I2oHCCDweOQh1fHHKuzW1uNcs/ddTL/pFzjsHQ1FRaHMKtK6kU8sBcQzidM1lJOnbe6QkQQ+rTkGgf5QmrwpZgL+/iZvIPM3lzkIxSS3Inlub823bnphatRlDXlB5N3+9ml0XXRJQcA/Mrzp9eGPqM138MynB8q7nSx1G6g8EQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M1URJ4DrsV0POIaYXDOgB5Qw/SNRCdYwcb0p9PPChf8=;
 b=cyNfpFZFhorcAH8rGtcSD6udgmJb0HuhXfUIoURpMxHs10moQFsg3fpxc2e4duRODS8tcbDJ+ne8e7OYbB9kyxrcdbrJogTyEUAk64gcdO2Fjk+c598aFryIozMag+IJdsUoIzuZdVJBEzbyOnjnZ4ncJ5YRzXVVjruk3F8e7tg=
Received: from BN6PR08CA0086.namprd08.prod.outlook.com (2603:10b6:404:b6::24)
 by DM5PR12MB1722.namprd12.prod.outlook.com (2603:10b6:3:107::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.18; Wed, 25 Mar
 2020 03:58:50 +0000
Received: from BN8NAM11FT040.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:b6:cafe::a4) by BN6PR08CA0086.outlook.office365.com
 (2603:10b6:404:b6::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.18 via Frontend
 Transport; Wed, 25 Mar 2020 03:58:50 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 BN8NAM11FT040.mail.protection.outlook.com (10.13.177.166) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2814.13 via Frontend Transport; Wed, 25 Mar 2020 03:58:49 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Tue, 24 Mar
 2020 22:58:49 -0500
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Tue, 24 Mar
 2020 22:58:49 -0500
Received: from monk-build.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Tue, 24 Mar 2020 22:58:48 -0500
From: Monk Liu <Monk.Liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/7] drm/amdgpu: introduce new request and its function
Date: Wed, 25 Mar 2020 11:58:38 +0800
Message-ID: <1585108722-19098-3-git-send-email-Monk.Liu@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1585108722-19098-1-git-send-email-Monk.Liu@amd.com>
References: <1585108722-19098-1-git-send-email-Monk.Liu@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(136003)(39860400002)(376002)(346002)(428003)(46966005)(186003)(7696005)(26005)(81166006)(8936002)(36756003)(8676002)(86362001)(81156014)(426003)(70586007)(70206006)(5660300002)(478600001)(316002)(2906002)(336012)(82740400003)(6916009)(47076004)(4326008)(6666004)(356004)(2616005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1722; H:SATLEXMB01.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 72738fcb-7c2d-42b7-144d-08d7d070d386
X-MS-TrafficTypeDiagnostic: DM5PR12MB1722:
X-Microsoft-Antispam-PRVS: <DM5PR12MB17221348403B9E8EB9E0408F84CE0@DM5PR12MB1722.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 0353563E2B
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CQ2oY+Gcmvy45/+JLSz0Mdvu3jFWfSS6fLmXQgHxe/bPMPo/2wLQfkPxvgg3KXNdgs3FDqFh6Q11IrZqrluQtyxePykoV4IYDKvKbNcMkg7MfFu49aYGJnR7ANLaD2Sj4+X9T6h72/w7pj8fy4xvX6MSPjR9SpwU1QMy7rgpbyT+w0cHQoDoEz0hZ7tqgkFhqOLhijL52/0kHRQH6an4lnvREFKCwaORs/4H+C8ZaWztNeS0dDWje9Qq2+SZJKLakgywgi2EaNeUEs36Otw4a2q2P0LfKd2DFehymTQiIcxaNlPagkV9F8k4JCHVAvn0/gcjaq8cweqaRqCHlTO8ums3y6WZN3UrCXlIYhp0OYgtNPPkZFfpDUMo5A2zAlbA+V9YFyLSMVj6pCuHjQd5E5nRbO1KtRHUETMedTYr3g8P3012+POT8brOeR8+Qwi1ZMlpjACSB/MMNhEuH60IdpHs7f/cOqRHW8zbdB3JwFr30Pjf2s40IDEUCyqt+l0UYTrZm3GSisjnM1zKjXSYOA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2020 03:58:49.9478 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 72738fcb-7c2d-42b7-144d-08d7d070d386
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1722
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
Cc: Monk Liu <Monk.Liu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

1) modify xgpu_nv_send_access_requests to support
new idh request

2) introduce new function: req_gpu_init_data() which
is used to notify host to prepare vbios/ip-discovery/pfvf exchange

Signed-off-by: Monk Liu <Monk.Liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c | 13 +++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h |  3 ++
 drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c    | 48 ++++++++++++++++++++++++++------
 drivers/gpu/drm/amd/amdgpu/mxgpu_nv.h    |  2 +-
 4 files changed, 57 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
index 43a1ee3..135a16c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -152,6 +152,19 @@ int amdgpu_virt_reset_gpu(struct amdgpu_device *adev)
 	return 0;
 }
 
+void amdgpu_virt_request_init_data(struct amdgpu_device *adev)
+{
+	struct amdgpu_virt *virt = &adev->virt;
+
+	if (virt->ops && virt->ops->req_init_data)
+		virt->ops->req_init_data(adev);
+
+	if (adev->virt.req_init_data_ver > 0)
+		DRM_INFO("host supports REQ_INIT_DATA handshake\n");
+	else
+		DRM_WARN("host doesn't support REQ_INIT_DATA handshake\n");
+}
+
 /**
  * amdgpu_virt_wait_reset() - wait for reset gpu completed
  * @amdgpu:	amdgpu device.
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
index 74f9843..f6ae3c6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
@@ -59,6 +59,7 @@ struct amdgpu_vf_error_buffer {
 struct amdgpu_virt_ops {
 	int (*req_full_gpu)(struct amdgpu_device *adev, bool init);
 	int (*rel_full_gpu)(struct amdgpu_device *adev, bool init);
+	int (*req_init_data)(struct amdgpu_device *adev);
 	int (*reset_gpu)(struct amdgpu_device *adev);
 	int (*wait_reset)(struct amdgpu_device *adev);
 	void (*trans_msg)(struct amdgpu_device *adev, u32 req, u32 data1, u32 data2, u32 data3);
@@ -263,6 +264,7 @@ struct amdgpu_virt {
 	struct amdgpu_virt_fw_reserve	fw_reserve;
 	uint32_t gim_feature;
 	uint32_t reg_access_mode;
+	int req_init_data_ver;
 };
 
 #define amdgpu_sriov_enabled(adev) \
@@ -303,6 +305,7 @@ void amdgpu_virt_kiq_reg_write_reg_wait(struct amdgpu_device *adev,
 int amdgpu_virt_request_full_gpu(struct amdgpu_device *adev, bool init);
 int amdgpu_virt_release_full_gpu(struct amdgpu_device *adev, bool init);
 int amdgpu_virt_reset_gpu(struct amdgpu_device *adev);
+void amdgpu_virt_request_init_data(struct amdgpu_device *adev);
 int amdgpu_virt_wait_reset(struct amdgpu_device *adev);
 int amdgpu_virt_alloc_mm_table(struct amdgpu_device *adev);
 void amdgpu_virt_free_mm_table(struct amdgpu_device *adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
index d9ce12c..6b9e390 100644
--- a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
@@ -109,7 +109,6 @@ static int xgpu_nv_poll_msg(struct amdgpu_device *adev, enum idh_event event)
 		timeout -= 10;
 	} while (timeout > 1);
 
-	pr_err("Doesn't get msg:%d from pf, error=%d\n", event, r);
 
 	return -ETIME;
 }
@@ -163,18 +162,45 @@ static int xgpu_nv_send_access_requests(struct amdgpu_device *adev,
 					enum idh_request req)
 {
 	int r;
+	enum idh_event event = -1;
 
 	xgpu_nv_mailbox_trans_msg(adev, req, 0, 0, 0);
 
-	/* start to check msg if request is idh_req_gpu_init_access */
-	if (req == IDH_REQ_GPU_INIT_ACCESS ||
-		req == IDH_REQ_GPU_FINI_ACCESS ||
-		req == IDH_REQ_GPU_RESET_ACCESS) {
-		r = xgpu_nv_poll_msg(adev, IDH_READY_TO_ACCESS_GPU);
+	switch (req) {
+	case IDH_REQ_GPU_INIT_ACCESS:
+	case IDH_REQ_GPU_FINI_ACCESS:
+	case IDH_REQ_GPU_RESET_ACCESS:
+		event = IDH_READY_TO_ACCESS_GPU;
+		break;
+	case IDH_REQ_GPU_INIT_DATA:
+		event = IDH_REQ_GPU_INIT_DATA_READY;
+		break;
+	default:
+		break;
+	}
+
+	if (event != -1) {
+		r = xgpu_nv_poll_msg(adev, event);
 		if (r) {
-			pr_err("Doesn't get READY_TO_ACCESS_GPU from pf, give up\n");
-			return r;
+			if (req != IDH_REQ_GPU_INIT_DATA) {
+				pr_err("Doesn't get msg:%d from pf, error=%d\n", event, r);
+				return r;
+			}
+			else /* host doesn't support REQ_GPU_INIT_DATA handshake */
+				adev->virt.req_init_data_ver = 0;
+		} else {
+			if (req == IDH_REQ_GPU_INIT_DATA)
+			{
+				adev->virt.req_init_data_ver =
+					RREG32_NO_KIQ(SOC15_REG_OFFSET(NBIO, 0,
+						mmBIF_BX_PF_MAILBOX_MSGBUF_RCV_DW1));
+
+				/* assume V1 in case host doesn't set version number */
+				if (adev->virt.req_init_data_ver < 1)
+					adev->virt.req_init_data_ver = 1;
+			}
 		}
+
 		/* Retrieve checksum from mailbox2 */
 		if (req == IDH_REQ_GPU_INIT_ACCESS || req == IDH_REQ_GPU_RESET_ACCESS) {
 			adev->virt.fw_reserve.checksum_key =
@@ -212,6 +238,11 @@ static int xgpu_nv_release_full_gpu_access(struct amdgpu_device *adev,
 	return r;
 }
 
+static int xgpu_nv_request_init_data(struct amdgpu_device *adev)
+{
+	return xgpu_nv_send_access_requests(adev, IDH_REQ_GPU_INIT_DATA);
+}
+
 static int xgpu_nv_mailbox_ack_irq(struct amdgpu_device *adev,
 					struct amdgpu_irq_src *source,
 					struct amdgpu_iv_entry *entry)
@@ -377,6 +408,7 @@ void xgpu_nv_mailbox_put_irq(struct amdgpu_device *adev)
 const struct amdgpu_virt_ops xgpu_nv_virt_ops = {
 	.req_full_gpu	= xgpu_nv_request_full_gpu_access,
 	.rel_full_gpu	= xgpu_nv_release_full_gpu_access,
+	.req_init_data  = xgpu_nv_request_init_data,
 	.reset_gpu = xgpu_nv_request_reset,
 	.wait_reset = NULL,
 	.trans_msg = xgpu_nv_mailbox_trans_msg,
diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.h b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.h
index 598ed2c..b9eed0f 100644
--- a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.h
+++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.h
@@ -25,7 +25,7 @@
 #define __MXGPU_NV_H__
 
 #define NV_MAILBOX_POLL_ACK_TIMEDOUT	500
-#define NV_MAILBOX_POLL_MSG_TIMEDOUT	12000
+#define NV_MAILBOX_POLL_MSG_TIMEDOUT	6000
 #define NV_MAILBOX_POLL_FLR_TIMEDOUT	500
 
 enum idh_request {
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
