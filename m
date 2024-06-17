Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65693C2BA15
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Jun 2024 14:55:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C43E910E403;
	Mon, 17 Jun 2024 14:55:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gt1aXb7k";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2072.outbound.protection.outlook.com [40.107.237.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 54A5210E402
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 Jun 2024 14:55:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OYdfQcp8CVqcNX/nzMelz8EDRy5KGvXl4zXRRFpqXJQF0UG+nq1GLJxxtvQo+7p9ZFOLSuT583RXicMvvUvi9Vmh7vwtJI0ydBj3SdRrHqeP50S8A3uKvJnb1DhtXGBtm44X/jeF1cTXF6mkpiiWEK+4ZcwktMHYsScNcHdGaRUVidcVyrsn7yFzGX9383vVqP8VtpNnMcMezJkik+jmM0VKsqY3/T50eivLhWMqAdbzaZu8p8c8g7O6TU8aWiMyYZ4zsrKdyAPOGdV74JHCZGCQYihsBTV18zWFmBbXtw1TMYEf7DFKmnSV3Tl+NPvCIM7ZsOMRVkutJ+Xnr2aryw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X6sb7KZZ/MPUXJBYfW9nQkStMKsBLe7ESupowpwX82Q=;
 b=k6mXMqCzINS8niNdhckpNKbmLbImmS1QVJHqYLtGJcXLCfZrgv+oNyi4CnfRGl7CXyUTCDSFyInABUPc+ZYGJhELUMsWjE6P7bKl2Q/tqXCWQD4uqCvPWZuI99HPYPVxVdom1Iw2fkTHyhS11ZzHXroA6+Q0pLs3DG1PQxnrb39WJ/CKkzalze5CIe4gPAYmrw2ONlgGdBkktXRto0fq1vQcfH9m+/cY8Ji+7aPt/p1jqUbHyVYv0D9nJY3Rd5mulLsWz25OY4pG/R5AopcEvNHxEE7MZNYSRxsLMAJEons42BP+LoHDtRjNZHnOKlkaDNvuNQvcCywbapw9MINePw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X6sb7KZZ/MPUXJBYfW9nQkStMKsBLe7ESupowpwX82Q=;
 b=gt1aXb7kWXFzCINGJ0QQ10bfuIKWg0tHz+HCU+Ju1MF7cmZVTnB+MSHPVYGIH2o76Tk9zThaerfBQeuTmMtybjqo8AkT6KAPf+VsKfuOXtDVkJ6lttlVjUlm4izcLaGe++JGOUkiuWbJE38A3PQq83aKnNDLuQHJ8BQP0IIqBp4=
Received: from SJ0PR13CA0211.namprd13.prod.outlook.com (2603:10b6:a03:2c1::6)
 by CY8PR12MB7315.namprd12.prod.outlook.com (2603:10b6:930:51::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31; Mon, 17 Jun
 2024 14:55:02 +0000
Received: from MWH0EPF000989EA.namprd02.prod.outlook.com
 (2603:10b6:a03:2c1:cafe::ae) by SJ0PR13CA0211.outlook.office365.com
 (2603:10b6:a03:2c1::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30 via Frontend
 Transport; Mon, 17 Jun 2024 14:55:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989EA.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Mon, 17 Jun 2024 14:55:01 +0000
Received: from H-4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 17 Jun
 2024 09:54:59 -0500
From: Vignesh Chander <Vignesh.Chander@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <jeffrey.chan@amd.com>, <zhigang.luo@amd.com>, <vignesh.chander@amd.com>, 
 Vignesh Chander <Vignesh.Chander@amd.com>
Subject: [PATCH 1/2] drm/amdgpu: Use dev_ prints for virtualization as it
 supports multi adapter
Date: Mon, 17 Jun 2024 09:54:45 -0500
Message-ID: <20240617145446.593279-1-Vignesh.Chander@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989EA:EE_|CY8PR12MB7315:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d50bd75-ff77-4307-0d93-08dc8edd7759
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230037|376011|1800799021|82310400023|36860700010; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?GPbcIQl6wLN9Ybc5UImLOuCQkR1DDZpnoow4R1YV7+AogfXIBFtuVqLnelJS?=
 =?us-ascii?Q?lWkkwYd14gu6HfA8UqEuhk+6rOZB+9g8CfPB0NWsdJWLv+zKb+PaHx9yDSUH?=
 =?us-ascii?Q?8iqJb5zIr/vgYF3E+VgTb6fAiIAMyFwDW+4RYFd/yPRaGBshcybFghgKywh1?=
 =?us-ascii?Q?l/QWPilanCD1b0VV8US2ARY9jU1/R674nmi5MzpFhb8HdJdZUW1zrz2CDtJC?=
 =?us-ascii?Q?IHVQyjW6fDerAiXU4jbF/9yxETxu2z/H/ZI+y1YndcOJ9YeWddjPSZmQZ/o8?=
 =?us-ascii?Q?4Ni5lLzrFZBmt01DkY9ixEnY1ZWUaKj5x3L/WjeRdR3uOkTB9csKbtUBOtHp?=
 =?us-ascii?Q?Axo76P28rJek8RBpu1Ihim7hXd3wIaVjfOYyxnweAPz2FXmmAvjdpqrBlnWU?=
 =?us-ascii?Q?othqVICh0XozpxBQf7Rkdf+dhz36qX45eNI6sTytOuYosFO/uu106o/RdhQS?=
 =?us-ascii?Q?qdQiMXPgwAuWRAbbFlo7vp0QaEClhKQ9iIO5Wp1Vn7/0lIP211VpDxXIerkJ?=
 =?us-ascii?Q?fQD0CdiIQ+LSNRJtZ9HFoS6D8RyM17Z4IN48EEebIFZYMwcFzRPQ991VnQfK?=
 =?us-ascii?Q?bLw9u4rrBK4t+l9pfxLVK8SNrtft6OBMxktasteLRNrH57o4slOUJ4dtrB38?=
 =?us-ascii?Q?Rojc7lKvK/IEkI74cB3u71Aev7uPISpfqVnDUgPJAf1GpTgSZHElD4EhOG8a?=
 =?us-ascii?Q?3f5E8GQTQwQ7onSluiz3Ld34JxD2zslDFb50YjzVdNLgvwNDW8UkdHbXuK0B?=
 =?us-ascii?Q?EMRkCzbdXX68bNJ/GMTreLY97l+X/dGiv3ZvmBvODWI0qNBJQYbq0I6wNkzK?=
 =?us-ascii?Q?EYJaRRGehQdm3BJMfiiRFmf4gwTs93kbm/ATvDQhEcEgO8zNZtYTtP3orpIo?=
 =?us-ascii?Q?QYmxhvpqHp2d6YRVjpYHBI/0FBqVzzbXsghYoybRQVOX16IrMeJXfOvxiqpa?=
 =?us-ascii?Q?ZmBIhPhW4XKQ0qycUpFmxD1iYJQeFqixBMncde9p8PbK4V1/dkQbdmHwj8kZ?=
 =?us-ascii?Q?R9msRWs+U45TPfHRyHxCT9Oruka90fPe+/Q0k+GUzsojHweyUYaMlE2hPlBb?=
 =?us-ascii?Q?zdoxERMXqdcAIzPQw+xcVDmWIwKpDs01ISIOh3LR44CgNaUa8yV+T05Tt2c1?=
 =?us-ascii?Q?LNRSDdQOj6XJWfKorjECxwkjDksdzFAHW64gG5u77o9My2dimC0jkZbuhKoY?=
 =?us-ascii?Q?5fo5JiWRiny/4Shg/EK3zxmPJdTQ5qYxTFDgvEhkN/2RlJtUo10MYwVYcvVr?=
 =?us-ascii?Q?aqtGWcDd6/RCYgnkqIxQCx9J4Rnc1YcoGW7OLMxF2erWuADj5vU9/7v7eAWI?=
 =?us-ascii?Q?l9XUtjm86XFWgQGCzWMhwC1JI6BUWV/eBGnqIIp4RmMItbBee+rgdSVtex4P?=
 =?us-ascii?Q?r9ILBBSpDnehznhWxFS58jhw/nxeNShz8qsIXzksXwB4F4WLdA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230037)(376011)(1800799021)(82310400023)(36860700010); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2024 14:55:01.9134 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d50bd75-ff77-4307-0d93-08dc8edd7759
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989EA.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7315
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

Signed-off-by: Vignesh Chander <Vignesh.Chander@amd.com>
Change-Id: Ifead637951c00e5b4e97c766d172323dcac4da08
---
 drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c | 19 +++++++++++--------
 drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c | 23 +++++++++++++++--------
 2 files changed, 26 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
index 6b71ee85ee6556..65656afc6ed1c2 100644
--- a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
+++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
@@ -93,7 +93,7 @@ static int xgpu_ai_poll_ack(struct amdgpu_device *adev)
 		timeout -= 5;
 	} while (timeout > 1);
 
-	pr_err("Doesn't get TRN_MSG_ACK from pf in %d msec\n", AI_MAILBOX_POLL_ACK_TIMEDOUT);
+	dev_err(adev->dev, "Doesn't get TRN_MSG_ACK from pf in %d msec\n", AI_MAILBOX_POLL_ACK_TIMEDOUT);
 
 	return -ETIME;
 }
@@ -111,7 +111,7 @@ static int xgpu_ai_poll_msg(struct amdgpu_device *adev, enum idh_event event)
 		timeout -= 10;
 	} while (timeout > 1);
 
-	pr_err("Doesn't get msg:%d from pf, error=%d\n", event, r);
+	dev_err(adev->dev, "Doesn't get msg:%d from pf, error=%d\n", event, r);
 
 	return -ETIME;
 }
@@ -132,7 +132,7 @@ static void xgpu_ai_mailbox_trans_msg (struct amdgpu_device *adev,
 		xgpu_ai_mailbox_set_valid(adev, false);
 		trn = xgpu_ai_peek_ack(adev);
 		if (trn) {
-			pr_err("trn=%x ACK should not assert! wait again !\n", trn);
+			dev_err_ratelimited(adev->dev, "trn=%x ACK should not assert! wait again !\n", trn);
 			msleep(1);
 		}
 	} while(trn);
@@ -155,7 +155,7 @@ static void xgpu_ai_mailbox_trans_msg (struct amdgpu_device *adev,
 	/* start to poll ack */
 	r = xgpu_ai_poll_ack(adev);
 	if (r)
-		pr_err("Doesn't get ack from pf, continue\n");
+		dev_err(adev->dev, "Doesn't get ack from pf, continue\n");
 
 	xgpu_ai_mailbox_set_valid(adev, false);
 }
@@ -173,7 +173,7 @@ static int xgpu_ai_send_access_requests(struct amdgpu_device *adev,
 		req == IDH_REQ_GPU_RESET_ACCESS) {
 		r = xgpu_ai_poll_msg(adev, IDH_READY_TO_ACCESS_GPU);
 		if (r) {
-			pr_err("Doesn't get READY_TO_ACCESS_GPU from pf, give up\n");
+			dev_err(adev->dev, "Doesn't get READY_TO_ACCESS_GPU from pf, give up\n");
 			return r;
 		}
 		/* Retrieve checksum from mailbox2 */
@@ -231,7 +231,7 @@ static int xgpu_ai_mailbox_ack_irq(struct amdgpu_device *adev,
 					struct amdgpu_irq_src *source,
 					struct amdgpu_iv_entry *entry)
 {
-	DRM_DEBUG("get ack intr and do nothing.\n");
+	dev_dbg(adev->dev, "get ack intr and do nothing.\n");
 	return 0;
 }
 
@@ -258,12 +258,15 @@ static int xgpu_ai_wait_reset(struct amdgpu_device *adev)
 {
 	int timeout = AI_MAILBOX_POLL_FLR_TIMEDOUT;
 	do {
-		if (xgpu_ai_mailbox_peek_msg(adev) == IDH_FLR_NOTIFICATION_CMPL)
+		if (xgpu_ai_mailbox_peek_msg(adev) == IDH_FLR_NOTIFICATION_CMPL) {
+			dev_dbg(adev->dev, "Got AI IDH_FLR_NOTIFICATION_CMPL after %d ms\n", AI_MAILBOX_POLL_FLR_TIMEDOUT - timeout);
 			return 0;
+		}
 		msleep(10);
 		timeout -= 10;
 	} while (timeout > 1);
-	dev_warn(adev->dev, "waiting IDH_FLR_NOTIFICATION_CMPL timeout\n");
+
+	dev_dbg(adev->dev, "waiting AI IDH_FLR_NOTIFICATION_CMPL timeout\n");
 	return -ETIME;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
index 22af30a15a5fd7..17e1e8cc243752 100644
--- a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
@@ -91,7 +91,7 @@ static int xgpu_nv_poll_ack(struct amdgpu_device *adev)
 		timeout -= 5;
 	} while (timeout > 1);
 
-	pr_err("Doesn't get TRN_MSG_ACK from pf in %d msec\n", NV_MAILBOX_POLL_ACK_TIMEDOUT);
+	dev_err(adev->dev, "Doesn't get TRN_MSG_ACK from pf in %d msec \n", NV_MAILBOX_POLL_ACK_TIMEDOUT);
 
 	return -ETIME;
 }
@@ -106,13 +106,16 @@ static int xgpu_nv_poll_msg(struct amdgpu_device *adev, enum idh_event event)
 
 	do {
 		r = xgpu_nv_mailbox_rcv_msg(adev, event);
-		if (!r)
+		if (!r) {
+			dev_dbg(adev->dev, "rcv_msg 0x%x after %llu ms\n", event, NV_MAILBOX_POLL_MSG_TIMEDOUT - timeout + now);
 			return 0;
+		}
 
 		msleep(10);
 		now = (uint64_t)ktime_to_ms(ktime_get());
 	} while (timeout > now);
 
+	dev_dbg(adev->dev, "nv_poll_msg timed out\n");
 
 	return -ETIME;
 }
@@ -133,11 +136,12 @@ static void xgpu_nv_mailbox_trans_msg (struct amdgpu_device *adev,
 		xgpu_nv_mailbox_set_valid(adev, false);
 		trn = xgpu_nv_peek_ack(adev);
 		if (trn) {
-			pr_err("trn=%x ACK should not assert! wait again !\n", trn);
+			dev_err_ratelimited(adev->dev, "trn=%x ACK should not assert! wait again !\n", trn);
 			msleep(1);
 		}
 	} while (trn);
 
+	dev_dbg(adev->dev, "trans_msg req = 0x%x, data1 = 0x%x\n", req, data1);
 	WREG32_NO_KIQ(mmMAILBOX_MSGBUF_TRN_DW0, req);
 	WREG32_NO_KIQ(mmMAILBOX_MSGBUF_TRN_DW1, data1);
 	WREG32_NO_KIQ(mmMAILBOX_MSGBUF_TRN_DW2, data2);
@@ -147,7 +151,7 @@ static void xgpu_nv_mailbox_trans_msg (struct amdgpu_device *adev,
 	/* start to poll ack */
 	r = xgpu_nv_poll_ack(adev);
 	if (r)
-		pr_err("Doesn't get ack from pf, continue\n");
+		dev_err(adev->dev, "Doesn't get ack from pf, continue\n");
 
 	xgpu_nv_mailbox_set_valid(adev, false);
 }
@@ -185,7 +189,7 @@ static int xgpu_nv_send_access_requests_with_param(struct amdgpu_device *adev,
 				goto send_request;
 
 			if (req != IDH_REQ_GPU_INIT_DATA) {
-				pr_err("Doesn't get msg:%d from pf, error=%d\n", event, r);
+				dev_err(adev->dev, "Doesn't get msg:%d from pf, error=%d\n", event, r);
 				return r;
 			} else /* host doesn't support REQ_GPU_INIT_DATA handshake */
 				adev->virt.req_init_data_ver = 0;
@@ -261,7 +265,7 @@ static int xgpu_nv_mailbox_ack_irq(struct amdgpu_device *adev,
 					struct amdgpu_irq_src *source,
 					struct amdgpu_iv_entry *entry)
 {
-	DRM_DEBUG("get ack intr and do nothing.\n");
+	dev_dbg(adev->dev, "get ack intr and do nothing.\n");
 	return 0;
 }
 
@@ -291,12 +295,15 @@ static int xgpu_nv_wait_reset(struct amdgpu_device *adev)
 {
 	int timeout = NV_MAILBOX_POLL_FLR_TIMEDOUT;
 	do {
-		if (xgpu_nv_mailbox_peek_msg(adev) == IDH_FLR_NOTIFICATION_CMPL)
+		if (xgpu_nv_mailbox_peek_msg(adev) == IDH_FLR_NOTIFICATION_CMPL) {
+			dev_dbg(adev->dev, "Got NV IDH_FLR_NOTIFICATION_CMPL after %d ms\n", NV_MAILBOX_POLL_FLR_TIMEDOUT - timeout);
 			return 0;
+		}
 		msleep(10);
 		timeout -= 10;
 	} while (timeout > 1);
-	dev_warn(adev->dev, "waiting IDH_FLR_NOTIFICATION_CMPL timeout\n");
+
+	dev_dbg(adev->dev, "waiting NV IDH_FLR_NOTIFICATION_CMPL timeout\n");
 	return -ETIME;
 }
 
-- 
2.25.1

