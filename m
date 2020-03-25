Return-Path: <SRS0=Seja=5K=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28EDEC54FD4
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Mar 2020 03:58:59 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F33B9206F6
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Mar 2020 03:58:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="JNelByjG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F33B9206F6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D36536E0FE;
	Wed, 25 Mar 2020 03:58:57 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2078.outbound.protection.outlook.com [40.107.243.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 21D876E0E9
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Mar 2020 03:58:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ji6Qf6LnuLUrLotMHSoffN7yWAmxfVwzNObMgcZKBQr7GvE5HKbBwj+l/mgjg6FVlVQ4oWOMnz6ij7Phv8CaMkdcQQKNnlV/bxpXgWbqi8PIsPdwaAJhCek7qwXUAds0bGASU9wsQGglWQM5Y7dvT4AmArpX6acDKgtxRtSMXEckx0YBtzaTl38Lt4K+sJWkHoRnfMYsjvTWAUTHxphdn8yidJenfnhrs9aDj6z/oJA3+pph+joIXkpMR7Kt1ZjxbA46iPuAiT3Po7vTsHnUWKAiFAfKRMNDQ9Ml9JXJ9lh1XP/jPe2VyEpjwsZx6ReRB1vbwPPFbR3qMk5HCXzXbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U7RQs7hXV+etq9dJSo1+0I9GtDyL29rD+fZdVB1B+Z0=;
 b=UWYIpOJkv25etldllB9koNv4FBmUJO96H9CUHdX7FB/CD01IMxdAw/RDbylfvOcZ9epfgQQxvDdO5dH1Q3uZIoDafJWrRIGdHuVSnWDmREo9YXfKwzWIqIg8Ek5lQmp6kgSNMPyIim03Gwdz+/AmZ0Nj5rldIUp+IUbKpS0gaJYWbVkcFCLRP6YDMMZ/6CgnnlwWqe1oe4vxu6z327j6oJe6Dk1nA6B4KHaOk5qKxlw9LSyDzgSOjM5Y58zIKMVmBrbiBMEgyLdQiIeYdf+6wl187fomCw8mQtB9COJN4yMb+EN9dDFLv/GUX35vcSBYb/RqJ6bX71b0uzh0ToTeTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U7RQs7hXV+etq9dJSo1+0I9GtDyL29rD+fZdVB1B+Z0=;
 b=JNelByjG7G+WTz7ZBMMOEj/q51jgliKI3LkNTb3Y4o9FEBajbGzPH9SBSeiLdbh4aGOOJkbVW48sS2RKcCy7MYTA59EL2CG0PEMNPBITUUQoza6rleMleZzmHg277AC3SntcxcRKs2CRBERyZmXB10JF9bSRxJJX29Eaxw91yPE=
Received: from MW2PR16CA0068.namprd16.prod.outlook.com (2603:10b6:907:1::45)
 by SA0PR12MB4478.namprd12.prod.outlook.com (2603:10b6:806:9c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.22; Wed, 25 Mar
 2020 03:58:52 +0000
Received: from CO1NAM11FT016.eop-nam11.prod.protection.outlook.com
 (2603:10b6:907:1:cafe::47) by MW2PR16CA0068.outlook.office365.com
 (2603:10b6:907:1::45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.19 via Frontend
 Transport; Wed, 25 Mar 2020 03:58:52 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 CO1NAM11FT016.mail.protection.outlook.com (10.13.175.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2814.13 via Frontend Transport; Wed, 25 Mar 2020 03:58:51 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Tue, 24 Mar
 2020 22:58:50 -0500
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Tue, 24 Mar
 2020 22:58:50 -0500
Received: from monk-build.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Tue, 24 Mar 2020 22:58:49 -0500
From: Monk Liu <Monk.Liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 4/7] drm/amdgpu: use static mmio offset for NV mailbox
Date: Wed, 25 Mar 2020 11:58:39 +0800
Message-ID: <1585108722-19098-4-git-send-email-Monk.Liu@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1585108722-19098-1-git-send-email-Monk.Liu@amd.com>
References: <1585108722-19098-1-git-send-email-Monk.Liu@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(39860400002)(136003)(346002)(396003)(428003)(46966005)(36756003)(6916009)(316002)(86362001)(356004)(6666004)(2616005)(70206006)(70586007)(426003)(15650500001)(81166006)(8676002)(26005)(82740400003)(2906002)(4326008)(8936002)(81156014)(47076004)(7696005)(5660300002)(186003)(336012)(478600001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:SA0PR12MB4478; H:SATLEXMB02.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 795338c4-b3b4-40ff-c7cf-08d7d070d4a1
X-MS-TrafficTypeDiagnostic: SA0PR12MB4478:
X-Microsoft-Antispam-PRVS: <SA0PR12MB447889DDC9ED5E7C0972C42C84CE0@SA0PR12MB4478.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 0353563E2B
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2Y9F3VxPt9GCu23hfEbogQDc4kQlZOl9utePS09SF67SfHtJ/L07acBYaIcd+FIPjSGfUxfqngtj+no3CoI3Taic+HjEtiSC8u8YcZpu9rCbtK6WZ+WQS45+ceMoSRpuHdsXZwPNc77+ZM3NATQbCGhHus4qH14aV4wW7TGd/gKZc2xYPymQXe0vpkZ32maHUS3gG36EoUejrU+3VyDSg0D9Xv9Q8kRJb/megh1vij8VC4RTk5oOpaPbE6nCRPAHdU1+mTPwBH/DEHXoR0QVKbLdRTW5cMKAfldt7grgZwutrsQmjGSb0yvNaZmajDR+yE00krMcaDyoYM1eXc1wAubahVHH/g4NM07xw6k9cIhaq02AFd0hmewckMokDLYyMwIhfRGFwBIevona2SZYCuPgI5J1+XnG7c8MlLZ7NJQP7bxAeMzAbWDHx/R8RPFE2nqI4gGx4cjVcm+xEXLP00QGn4VXBCUFyBORIrdtJ6n1goIZkOYEob+N/9D4mk7OudupFaMjwnTwifpeQoPHRQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2020 03:58:51.6862 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 795338c4-b3b4-40ff-c7cf-08d7d070d4a1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4478
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

what:
with the new "req_init_data" handshake we need to use mailbox
before do IP discovery, so in mxgpu_nv.c file the original
SOC15_REG method won'twork because that depends on IP discovery
complete first.

how:
so the solution is to always use static MMIO offset for NV+ mailbox
registers.
HW team confirm us all MAILBOX registers will be at the same
offset for all ASICs, no IP discovery needed for those registers

Signed-off-by: Monk Liu <Monk.Liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c | 52 +++++++++++++++--------------------
 drivers/gpu/drm/amd/amdgpu/mxgpu_nv.h | 18 ++++++++++--
 2 files changed, 38 insertions(+), 32 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
index 6b9e390..ce2bf1f 100644
--- a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
@@ -52,8 +52,7 @@ static void xgpu_nv_mailbox_set_valid(struct amdgpu_device *adev, bool val)
  */
 static enum idh_event xgpu_nv_mailbox_peek_msg(struct amdgpu_device *adev)
 {
-	return RREG32_NO_KIQ(SOC15_REG_OFFSET(NBIO, 0,
-				mmBIF_BX_PF_MAILBOX_MSGBUF_RCV_DW0));
+	return RREG32_NO_KIQ(mmMAILBOX_MSGBUF_RCV_DW0);
 }
 
 
@@ -62,8 +61,7 @@ static int xgpu_nv_mailbox_rcv_msg(struct amdgpu_device *adev,
 {
 	u32 reg;
 
-	reg = RREG32_NO_KIQ(SOC15_REG_OFFSET(NBIO, 0,
-					     mmBIF_BX_PF_MAILBOX_MSGBUF_RCV_DW0));
+	reg = RREG32_NO_KIQ(mmMAILBOX_MSGBUF_RCV_DW0);
 	if (reg != event)
 		return -ENOENT;
 
@@ -116,7 +114,6 @@ static int xgpu_nv_poll_msg(struct amdgpu_device *adev, enum idh_event event)
 static void xgpu_nv_mailbox_trans_msg (struct amdgpu_device *adev,
 	      enum idh_request req, u32 data1, u32 data2, u32 data3)
 {
-	u32 reg;
 	int r;
 	uint8_t trn;
 
@@ -135,19 +132,10 @@ static void xgpu_nv_mailbox_trans_msg (struct amdgpu_device *adev,
 		}
 	} while (trn);
 
-	reg = RREG32_NO_KIQ(SOC15_REG_OFFSET(NBIO, 0,
-					     mmBIF_BX_PF_MAILBOX_MSGBUF_TRN_DW0));
-	reg = REG_SET_FIELD(reg, BIF_BX_PF_MAILBOX_MSGBUF_TRN_DW0,
-			    MSGBUF_DATA, req);
-	WREG32_NO_KIQ(SOC15_REG_OFFSET(NBIO, 0, mmBIF_BX_PF_MAILBOX_MSGBUF_TRN_DW0),
-		      reg);
-	WREG32_NO_KIQ(SOC15_REG_OFFSET(NBIO, 0, mmBIF_BX_PF_MAILBOX_MSGBUF_TRN_DW1),
-				data1);
-	WREG32_NO_KIQ(SOC15_REG_OFFSET(NBIO, 0, mmBIF_BX_PF_MAILBOX_MSGBUF_TRN_DW2),
-				data2);
-	WREG32_NO_KIQ(SOC15_REG_OFFSET(NBIO, 0, mmBIF_BX_PF_MAILBOX_MSGBUF_TRN_DW3),
-				data3);
-
+	WREG32_NO_KIQ(mmMAILBOX_MSGBUF_TRN_DW0, req);
+	WREG32_NO_KIQ(mmMAILBOX_MSGBUF_TRN_DW1, data1);
+	WREG32_NO_KIQ(mmMAILBOX_MSGBUF_TRN_DW2, data2);
+	WREG32_NO_KIQ(mmMAILBOX_MSGBUF_TRN_DW3, data3);
 	xgpu_nv_mailbox_set_valid(adev, true);
 
 	/* start to poll ack */
@@ -192,8 +180,7 @@ static int xgpu_nv_send_access_requests(struct amdgpu_device *adev,
 			if (req == IDH_REQ_GPU_INIT_DATA)
 			{
 				adev->virt.req_init_data_ver =
-					RREG32_NO_KIQ(SOC15_REG_OFFSET(NBIO, 0,
-						mmBIF_BX_PF_MAILBOX_MSGBUF_RCV_DW1));
+					RREG32_NO_KIQ(mmMAILBOX_MSGBUF_RCV_DW1);
 
 				/* assume V1 in case host doesn't set version number */
 				if (adev->virt.req_init_data_ver < 1)
@@ -204,8 +191,7 @@ static int xgpu_nv_send_access_requests(struct amdgpu_device *adev,
 		/* Retrieve checksum from mailbox2 */
 		if (req == IDH_REQ_GPU_INIT_ACCESS || req == IDH_REQ_GPU_RESET_ACCESS) {
 			adev->virt.fw_reserve.checksum_key =
-				RREG32_NO_KIQ(SOC15_REG_OFFSET(NBIO, 0,
-					mmBIF_BX_PF_MAILBOX_MSGBUF_RCV_DW2));
+				RREG32_NO_KIQ(mmMAILBOX_MSGBUF_RCV_DW2);
 		}
 	}
 
@@ -256,11 +242,14 @@ static int xgpu_nv_set_mailbox_ack_irq(struct amdgpu_device *adev,
 					unsigned type,
 					enum amdgpu_interrupt_state state)
 {
-	u32 tmp = RREG32_NO_KIQ(SOC15_REG_OFFSET(NBIO, 0, mmBIF_BX_PF_MAILBOX_INT_CNTL));
+	u32 tmp = RREG32_NO_KIQ(mmMAILBOX_INT_CNTL);
 
-	tmp = REG_SET_FIELD(tmp, BIF_BX_PF_MAILBOX_INT_CNTL, ACK_INT_EN,
-				(state == AMDGPU_IRQ_STATE_ENABLE) ? 1 : 0);
-	WREG32_NO_KIQ(SOC15_REG_OFFSET(NBIO, 0, mmBIF_BX_PF_MAILBOX_INT_CNTL), tmp);
+	if (state == AMDGPU_IRQ_STATE_ENABLE)
+		tmp |= 2;
+	else
+		tmp &= ~2;
+
+	WREG32_NO_KIQ(mmMAILBOX_INT_CNTL, tmp);
 
 	return 0;
 }
@@ -312,11 +301,14 @@ static int xgpu_nv_set_mailbox_rcv_irq(struct amdgpu_device *adev,
 				       unsigned type,
 				       enum amdgpu_interrupt_state state)
 {
-	u32 tmp = RREG32_NO_KIQ(SOC15_REG_OFFSET(NBIO, 0, mmBIF_BX_PF_MAILBOX_INT_CNTL));
+	u32 tmp = RREG32_NO_KIQ(mmMAILBOX_INT_CNTL);
+
+	if (state == AMDGPU_IRQ_STATE_ENABLE)
+		tmp |= 1;
+	else
+		tmp &= ~1;
 
-	tmp = REG_SET_FIELD(tmp, BIF_BX_PF_MAILBOX_INT_CNTL, VALID_INT_EN,
-			    (state == AMDGPU_IRQ_STATE_ENABLE) ? 1 : 0);
-	WREG32_NO_KIQ(SOC15_REG_OFFSET(NBIO, 0, mmBIF_BX_PF_MAILBOX_INT_CNTL), tmp);
+	WREG32_NO_KIQ(mmMAILBOX_INT_CNTL, tmp);
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.h b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.h
index b9eed0f..45bcf43 100644
--- a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.h
+++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.h
@@ -59,7 +59,21 @@ int xgpu_nv_mailbox_add_irq_id(struct amdgpu_device *adev);
 int xgpu_nv_mailbox_get_irq(struct amdgpu_device *adev);
 void xgpu_nv_mailbox_put_irq(struct amdgpu_device *adev);
 
-#define NV_MAIBOX_CONTROL_TRN_OFFSET_BYTE (SOC15_REG_OFFSET(NBIO, 0, mmBIF_BX_PF_MAILBOX_CONTROL) * 4)
-#define NV_MAIBOX_CONTROL_RCV_OFFSET_BYTE (SOC15_REG_OFFSET(NBIO, 0, mmBIF_BX_PF_MAILBOX_CONTROL) * 4 + 1)
+#define mmMAILBOX_CONTROL 0xE5E
+
+#define NV_MAIBOX_CONTROL_TRN_OFFSET_BYTE (mmMAILBOX_CONTROL * 4)
+#define NV_MAIBOX_CONTROL_RCV_OFFSET_BYTE (NV_MAIBOX_CONTROL_TRN_OFFSET_BYTE + 1)
+
+#define mmMAILBOX_MSGBUF_TRN_DW0 0xE56
+#define mmMAILBOX_MSGBUF_TRN_DW1 0xE57
+#define mmMAILBOX_MSGBUF_TRN_DW2 0xE58
+#define mmMAILBOX_MSGBUF_TRN_DW3 0xE59
+
+#define mmMAILBOX_MSGBUF_RCV_DW0 0xE5A
+#define mmMAILBOX_MSGBUF_RCV_DW1 0xE5B
+#define mmMAILBOX_MSGBUF_RCV_DW2 0xE5C
+#define mmMAILBOX_MSGBUF_RCV_DW3 0xE5D
+
+#define mmMAILBOX_INT_CNTL 0xE5F
 
 #endif
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
