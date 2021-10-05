Return-Path: <SRS0=e3IM=OZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60F65C433EF
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Oct 2021 07:53:12 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 30FCB61350
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Oct 2021 07:53:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 30FCB61350
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C5A616EDA2;
	Tue,  5 Oct 2021 07:53:11 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2071.outbound.protection.outlook.com [40.107.244.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 84ADE6ED8E
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 Oct 2021 07:53:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G8z3wsnNvPJAByaxiIIZv90eobcsVOBAzbrKRu2b43UxBdosun2lcobeI2DsqGBViSDT7W4XGcqEyiKuUP0Upi3W3w0P6U2RhdNGNJVPog2nnMOUI4R2F8htK6AxaSjUkOSGL89XPz3EsfApuyze4urKw0JgGaivmvJ0z8WzgyDhLOWDpK6PHmHtz00/KLaDXYOmhNPi67A+/L7xVeTkYmaAUnnUcqrezymDfuPLkpHK3yZPOd3wSyAXIPAJ7DcGC9bg0fyO04stD9LLnlncUyx4B1iI5+bTELpzftIVwSH8EYCUb68P3nMQ01Pp8ZOBZS8Q4YnLQnzKXVUU6RsTAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gRTLcB1UEfULRsMT4huKC0nkKbDoLekwlc9wnNxc1jE=;
 b=lVRNpyt5u0P5c/lObTwqTUGtqMgn1UrodkKtzIY+Sr7hOT4FzA6UPx/dWK0c6DCMZKgncjyGmp9EqPVs8YQ/pVNUBJqtynwTXZQA2ZEUfQ57cn7OOqYovfMi2AiqwNQQuF3DHuEiD58pfo3DvDAKl/W4N2pml4BBHXmTN/tKHhGZv9oD664VFnlpTUJTDiGLj9fmrlKYYIdiYW/8XaGSj5FdFh8wMB5yix/AekrMU6tJlzsmm73bVw7z855KmeJgWzEynCnpx6U5dyUcwujhni26LiZZdpNaDwGn7hZIi8Yhis1bj7gILqkTjpPfp0dJX+WmXsCOKLGn5FBZMiLT8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gRTLcB1UEfULRsMT4huKC0nkKbDoLekwlc9wnNxc1jE=;
 b=HPJsgqkmNZVNnVQEw5BjjnL1Qh/2LzGHib8gsgCDFsgMM7dEo/XZ+ktn6tw1/IGxczJ5mn1YRnlAzweLqkS+niFkufVeI7EvxHTpxcbs8QxIhfAaRlt+lG2fmcmsgBqIxuZAbzcQsxcI+nnMUCJ2DVYM7yNzpCoCVi6wDLE4B08=
Received: from MWHPR07CA0003.namprd07.prod.outlook.com (2603:10b6:300:116::13)
 by BYAPR12MB2919.namprd12.prod.outlook.com (2603:10b6:a03:12c::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.14; Tue, 5 Oct
 2021 07:53:07 +0000
Received: from CO1NAM11FT038.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:116:cafe::3) by MWHPR07CA0003.outlook.office365.com
 (2603:10b6:300:116::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.22 via Frontend
 Transport; Tue, 5 Oct 2021 07:53:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT038.mail.protection.outlook.com (10.13.174.231) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4566.14 via Frontend Transport; Tue, 5 Oct 2021 07:53:07 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Tue, 5 Oct 2021
 02:53:06 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Tue, 5 Oct 2021
 00:53:05 -0700
Received: from wayne-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2308.8
 via Frontend Transport; Tue, 5 Oct 2021 02:52:57 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <Harry.Wentland@amd.com>,
 <nicholas.kazlauskas@amd.com>, <Rodrigo.Siqueira@amd.com>,
 <wayne.lin@amd.com>, <stylon.wang@amd.com>, <jude.shih@amd.com>,
 <jimmy.kizito@amd.com>, <meenakshikumar.somasundaram@amd.com>, Jun Lei
 <Jun.Lei@amd.com>, Wayne Lin <Wayne.Lin@amd.com>
Subject: [PATCH v2 03/23] drm/amd/display: Support for DMUB HPD and HPD RX
 interrupt handling
Date: Tue, 5 Oct 2021 15:51:45 +0800
Message-ID: <20211005075205.3467938-4-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211005075205.3467938-1-Wayne.Lin@amd.com>
References: <20211005075205.3467938-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5549e810-fb1a-4b1d-39cf-08d987d52b48
X-MS-TrafficTypeDiagnostic: BYAPR12MB2919:
X-Microsoft-Antispam-PRVS: <BYAPR12MB291958F55CE3EB477BB53168FCAF9@BYAPR12MB2919.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:651;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: e0IoUS/avjAecmm8aQJXZZIjBcZt8hDR8seRa8VnOsL1NmmnXqTf7ZLi8svRqiaEdNP+goIFCXaa8dnzZKmxNZmhiUpZ/D5blJRagOjxRiJ95LfxY2mW5uVa7/9mGYr6M5DJCdEr+4OeG3fnYB81TteXUNCxgdmgMxiTntwHDEBsddTtyqfUUE+FIQUY5h6FgBphXr5j73sRlGQQk2M9vmykTsXBZnzNsj67Xqqx+k5X4CEdixWm8/Kcbfna+BigAusB/1p2h3kA52/EJln3Am5MihFkrVMUC1KYWlF2LdK4Jgigp/hHg/glz6kSZivD1MxW9r7cjICExQ2AuQfFiqtwIGalffsIBLOJqyLNykQgNyn/cAWd3SPbf7Iv50iUXkl4kBGci/wWpO6Ds5nTD8TUkJAuA7HosaMLVfsWfVU5KWEY6vCiU1gh6mRjuH9yJkPwxFLXLX5/riFvRingCxuLTB7xLdwweDtu6vTchWeriPea5gUIa6gh8ZL65R4thXxIvTZOCx/ACVVYe/YetaL4z2BnMHwhoyf/yYfKQmmDWqjKhyH/gC0KkDWLDy1zNSvA2Sm7eHz5pSrJldQjWNMH+ncMI4MfGZNmtOoAys+8krm/MnoM/T7Veg/1OT+sCwednzBq2qFE+/kZWU532Tr5KDSqhqLkXJY+LYlDmYfJNdoGJDAYSgeTNEm30sXyQSM0+8oPNGFKDwTg5c17Cq+5nM3hn1NZFUnLG3cer08=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(8936002)(2616005)(5660300002)(36756003)(6666004)(47076005)(6916009)(4326008)(70586007)(86362001)(1076003)(82310400003)(81166007)(356005)(83380400001)(426003)(8676002)(70206006)(36860700001)(2906002)(508600001)(186003)(316002)(26005)(54906003)(336012)(7696005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2021 07:53:07.2081 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5549e810-fb1a-4b1d-39cf-08d987d52b48
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT038.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2919
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

From: Meenakshikumar Somasundaram <meenakshikumar.somasundaram@amd.com>

[WHY]
To add support for HPD & HPD RX interrupt handling for USB4 DPIA in
YELLOW_CARP_B0. USB4 DPIA HPD & HPD RX interrupts are issued from DMUB to
driver as a outbox1 message.

[HOW]
1) Created get_link_index_from_dpia_port_index() to retrieve link index
   from dpia port index for HPD & HPD RX dmub notifications.
2) Added DMUB HPD & HPD RX handling in dmub_srv_stat_get_notification().

Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Wayne Lin <Wayne.Lin@amd.com>
Acked-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Signed-off-by: Meenakshikumar Somasundaram <meenakshikumar.somasundaram@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c      | 20 +++++++++++++++++++
 drivers/gpu/drm/amd/display/dc/core/dc_stat.c |  7 +++++++
 drivers/gpu/drm/amd/display/dc/dc.h           |  3 +++
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |  4 ++++
 .../drm/amd/display/dmub/src/dmub_srv_stat.c  | 11 ++++++++++
 5 files changed, 45 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index f4bb8ea4e83a..6cdf68ca9048 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -3658,6 +3658,26 @@ bool dc_process_dmub_aux_transfer_async(struct dc *dc,
 	return true;
 }
 
+uint8_t get_link_index_from_dpia_port_index(const struct dc *dc,
+					    uint8_t dpia_port_index)
+{
+	uint8_t index, link_index = 0xFF;
+
+	for (index = 0; index < dc->link_count; index++) {
+		/* ddc_hw_inst has dpia port index for dpia links
+		 * and ddc instance for legacy links
+		 */
+		if (!dc->links[index]->ddc->ddc_pin) {
+			if (dc->links[index]->ddc_hw_inst == dpia_port_index) {
+				link_index = index;
+				break;
+			}
+		}
+	}
+	ASSERT(link_index != 0xFF);
+	return link_index;
+}
+
 /**
  * dc_disable_accelerated_mode - disable accelerated mode
  * @dc: dc structure
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_stat.c b/drivers/gpu/drm/amd/display/dc/core/dc_stat.c
index 28ef9760fa34..7d4a5dc8fc91 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_stat.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_stat.c
@@ -61,6 +61,13 @@ void dc_stat_get_dmub_notification(const struct dc *dc, struct dmub_notification
 
 	status = dmub_srv_stat_get_notification(dmub, notify);
 	ASSERT(status == DMUB_STATUS_OK);
+
+	/* For HPD/HPD RX, convert dpia port index into link index */
+	if (notify->type == DMUB_NOTIFICATION_HPD ||
+	    notify->type == DMUB_NOTIFICATION_HPD_IRQ) {
+		notify->link_index =
+			get_link_index_from_dpia_port_index(dc, notify->link_index);
+	}
 }
 
 /**
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 204bab6f82ef..d51c7b000eb9 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -1395,6 +1395,9 @@ bool dc_process_dmub_aux_transfer_async(struct dc *dc,
 				uint32_t link_index,
 				struct aux_payload *payload);
 
+/* Get dc link index from dpia port index */
+uint8_t get_link_index_from_dpia_port_index(const struct dc *dc,
+				uint8_t dpia_port_index);
 /*******************************************************************************
  * DSC Interfaces
  ******************************************************************************/
diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index 42956dd398f3..a693b743f0d4 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -676,6 +676,10 @@ enum dmub_out_cmd_type {
 	 * Command type used for DP AUX Reply data notification
 	 */
 	DMUB_OUT_CMD__DP_AUX_REPLY = 1,
+	/**
+	 * Command type used for DP HPD event notification
+	 */
+	DMUB_OUT_CMD__DP_HPD_NOTIFY = 2,
 };
 
 #pragma pack(push, 1)
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_srv_stat.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_srv_stat.c
index 70766d534c9c..d7f66e5285c0 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_srv_stat.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_srv_stat.c
@@ -76,6 +76,17 @@ enum dmub_status dmub_srv_stat_get_notification(struct dmub_srv *dmub,
 		dmub_memcpy((void *)&notify->aux_reply,
 			(void *)&cmd.dp_aux_reply.reply_data, sizeof(struct aux_reply_data));
 		break;
+	case DMUB_OUT_CMD__DP_HPD_NOTIFY:
+		if (cmd.dp_hpd_notify.hpd_data.hpd_type == DP_HPD) {
+			notify->type = DMUB_NOTIFICATION_HPD;
+			notify->hpd_status = cmd.dp_hpd_notify.hpd_data.hpd_status;
+		} else {
+			notify->type = DMUB_NOTIFICATION_HPD_IRQ;
+		}
+
+		notify->link_index = cmd.dp_hpd_notify.hpd_data.instance;
+		notify->result = AUX_RET_SUCCESS;
+		break;
 	default:
 		notify->type = DMUB_NOTIFICATION_NO_DATA;
 		break;
-- 
2.25.1

