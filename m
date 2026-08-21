Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D94AC5DF8E
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Aug 2026 19:53:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AB9B310F490;
	Fri, 21 Aug 2026 19:53:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="S2NVTzQR";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012011.outbound.protection.outlook.com
 [40.93.195.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2F27610F483
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Aug 2026 19:53:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J+rFfHFFRoC73JjbQY6JcOSS49kmVCyQwziQbijwGhsHdpHL5jvZCnn8sa+SYnONyxUeKajbEJ0z9cfRXovrbpOweIfBolTSeAy7FxU8oyM84hpGiekTj9WG9oRlcCPQYbuhIo2GmcWRpH+reVZJ02aq7nCpVnh2Y2sJQjjiXlcRxgWR2hw7C2Sw8d3iwlZQ9hTYzD0WWc5BHwDWWYRcvMWIZwhpccNvGW3/fb4Vo9NOysNY5xNr9mrsp+0e9R3dCjmUzaYYRlwyN0TnnNj2FO1uGhoPqybkRc6E75xYetuQPBUujDxUVyt4O/CGVgZoRv/2ZRMuFSa4TrC/rZ/ffg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NJr3d/5w+CFdWlQ6PZxuWh8V1gXcKUFIhOALuSYdsUg=;
 b=nAyON6nZdN5jM04cRIEM1p/2IAZDtlK03Elsl0RyKf4T3Hsv71uUuY3Ph4Z8u3IGLuGmqxbTCN4HcrnYWVxl6WQG4NXp3I3fG3tLNMDCnfTW7TnbImTLFsgeLM92AvOQuGSP9Q4tMKsKFjDqH3U1646PWWLLoXay76uqpt1HPj4VPXSAtlJ+wcR1CAOwGpXBYhpiNMegF5rOxo0alNRODZPmFlSB8+SUrA30Ho3IBYC3Rin4zDpOubSb4cVrmTdmBLRBgKfJ4FVQ6RODeyaUdSWjAF1/DhWSJ9E+N06yrvCBdRwNP7jNJxRuJpHALuJjNS5S0ufQ0YO+et4Nn8Y3gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NJr3d/5w+CFdWlQ6PZxuWh8V1gXcKUFIhOALuSYdsUg=;
 b=S2NVTzQRBsah1eIpB5qELKCyRyuRBb3X/op9dsv7l0G8jdVK26fhPdmnqwSvgsCQRB+kx4VZENKDjYWY+C8zfqE+aH92SITaDyBwvWfVzsY/NIBIuPWmtbqO2sTYAuf7GfjeROcqB5y1Cssodk6xw94Ts15utQbQSLdCvQE6sW4=
Received: from CY5PR19CA0069.namprd19.prod.outlook.com (2603:10b6:930:69::15)
 by DS7PR12MB8291.namprd12.prod.outlook.com (2603:10b6:8:e6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.10; Fri, 21 Aug
 2026 19:35:53 +0000
Received: from CY4PEPF0000EDD6.namprd03.prod.outlook.com
 (2603:10b6:930:69:cafe::75) by CY5PR19CA0069.outlook.office365.com
 (2603:10b6:930:69::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.11 via Frontend Transport; Fri,
 21 Aug 2026 19:35:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CY4PEPF0000EDD6.mail.protection.outlook.com (10.167.241.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Fri, 21 Aug 2026 19:35:53 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 14:35:46 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 14:35:45 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 21 Aug 2026 14:35:45 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Mukul Joshi <mukul.joshi@amd.com>, Felix Kuehling
 <felix.kuehling@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 56/95] drm/amdgpu: Add handling for remote interrupts
Date: Fri, 21 Aug 2026 15:34:19 -0400
Message-ID: <20260821193458.808626-57-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260821193458.808626-1-alexander.deucher@amd.com>
References: <20260821193458.808626-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD6:EE_|DS7PR12MB8291:EE_
X-MS-Office365-Filtering-Correlation-Id: c2e8ce86-0851-497e-4695-08deffbb6a02
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|82310400026|36860700016|376014|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: TJLKkSEETefGAuH3OfTqK5lxRWGc5rMYAFFILuIcah0+XKchjUXORVdo5cCaTxk7ZNtkQYlULCASZWzXMbumkS+PULOlaeNAuyOVJfzG8OtQeYT8bhrbYIef0WDhEqwj7FaliKE6R13Ta9cvW/Kevn58x68qj+Iq9z6tGv/hrDiidHrAXDikwYAp23y0cPEHjCPeRKHAZAFPEqB/Pgd7VfbIIg3fLYjK2CkZWz7JytpxzlauK0gl+pWM775AFsJLUUyW5hMcp4Y+ZvLEzsLHoxP6B3b6k0rh9BdpGp0eiEfOmzzJ4Mdg7l5CTqVgNWXDU6hP6fsjHhbnuJhxVhJ7yLDrnnU3wYp//+kPSCBd7KO+a+69gCsTqBMm0NEDAZRZDhdPLeVzXPHDM1GyJ3+aUMuyjzzI1JT2vFxMu+9dam422BYNvfoCE+IPnoQ5NMfdR/a2YKcayp/tf/x7aCJVEIemf/HrQUEd95Z0D3CZby6S8gvXcY15plX3bFHlfPwOaDeDHuWUrqRCQxu6YDvdQEsAVGnsZabU2hYmsMf+4VpxZKYdDMdEzccAqH7yeqnupTJSIWY+t+Qw+08NNX6EkpmdiBAVa5btCviNGYF+Lp3wpVFf9Oa1J3cMEwots7opHWEX+AAO6qNcnrIcydMsHA+zkGbPkflEcNI4tzgftxK9ht+YmOQE4vvgZfblZbgcIaF2SJ9XUpahBaRJUWNvJQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(82310400026)(36860700016)(376014)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 93bYogxFfc5JVJs2juMSMqy09Z5831HCWut4mjIuLZUIHIg9ndkWwxOJzo2jm9JFV5PnbEtYZeZOsOjHPR1pksgI00iAqbD/xsO68+/X6bTOROIcwl3cU5aw80kMlHIX17CXdYsT/wu7qA+78hxGxpyBHQvUHh+j9m1LfpQZZcFZVTctDd2BX7SKOs0oB4ek6gtVYeW++5VSCZXlY/sy8yQcgFbLXJKYbcx/dPT2lyumShEMgVj+fvMVDXzkrRwJ5VYtL/bGFhuWgZtP6i3hVV8B5ljLZGSVdqjKweTSFzE75S28ZRuRbaGOu4EgXu7/KShSf81+U9DHmNYBR3iiCqTUGA5tkY+jyNzw8J5vcdj7DxvcWktLaqdSrOKjTQeCMvD+OWomOfxSkn/52eZxXCQ5vbrNgiosZ2ZmrCRvGNxYEwWzhZPYFVgPoiTzmSAP
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 19:35:53.4851 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c2e8ce86-0851-497e-4695-08deffbb6a02
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8291
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

From: Mukul Joshi <mukul.joshi@amd.com>

Add interrupt handling to process the NPA remote interrupts.

Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c | 114 ++++++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h |   3 +
 2 files changed, 113 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
index c393633e69443..2f7df10f39423 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
@@ -5189,10 +5189,31 @@ void amdgpu_ualink_sw_fini(struct amdgpu_device *adev)
 	adev->ualink.remote = NULL;
 }
 
+int ualink_send_hello(struct amdgpu_device *adev, u32 remote_accel_id)
+{
+	return amdgpu_ualink_send_hello_msg(adev, remote_accel_id);
+}
+
+/*
+ * The low bits of handle_lo carry the message-header field on the wire.
+ * Strip those bits and splice in @acc_id to recover the
+ * fully-qualified handle_lo value.
+ */
+static inline u64 amdgpu_ualink_reassemble_handle(u64 handle_lo, u32 acc_id)
+{
+	return (handle_lo & ~AMDGPU_UALINK_MESSAGE_HEADER_MASK) |
+	       (acc_id & AMDGPU_UALINK_HANDLE_ACCID_MASK);
+}
+
 static int amdgpu_ualink_process_irq(struct amdgpu_device *adev,
 				     struct amdgpu_irq_src *source,
 				     struct amdgpu_iv_entry *entry)
 {
+	u32 sender_acc_id, receiver_acc_id, msg_type, src_acc_id;
+	struct amdgpu_ualink_handle handle;
+	u32 size, npa_addr, fail_reason;
+	u32 dw0, dw1, dw2, dw3;
+	u32 local_acc_id;
 	int handled = 1;
 
 	dev_dbg(adev->dev, "%s client_id 0x%x src_id 0x%x ih\n",
@@ -5206,10 +5227,95 @@ static int amdgpu_ualink_process_irq(struct amdgpu_device *adev,
 		return handled;
 	}
 
-	/*
-	 * Call amdgpu_ualink_interrupt handler
-	 * amdgpu_ualink_interrupt(adev, entry);
-	 */
+	/* ContextID 4 dwords */
+	src_acc_id = entry->pasid;
+	dw0 = entry->src_data[0];
+	dw1 = entry->src_data[1];
+	dw2 = entry->src_data[2];
+	dw3 = entry->src_data[3];
+
+	dev_dbg(adev->dev, "src accel_id %u context id 0x%x 0x%x 0x%x 0x%x\n",
+		src_acc_id, dw0, dw1, dw2, dw3);
+
+	msg_type = dw0 & AMDGPU_UALINK_MESSAGE_HEADER_MASK;
+	local_acc_id = adev->ualink.info->ppod.accel_id;
+	dev_dbg(adev->dev, "Got MSG: remote acc_id %u msg_type %u\n",
+		src_acc_id, msg_type);
+
+	switch (msg_type) {
+	case AMDGPU_UALINK_HELLO_MSG:
+		receiver_acc_id = (dw0 >> AMDGPU_UALINK_HELLO_MSG_RECV_ACCID_SHIFT) &
+					AMDGPU_UALINK_HELLO_MSG_ACCID_MASK;
+		sender_acc_id = (dw0 >> AMDGPU_UALINK_HELLO_MSG_SENDER_ACCID_SHIFT) &
+					AMDGPU_UALINK_HELLO_MSG_ACCID_MASK;
+		dev_dbg(adev->dev,
+			"Got HELLO MSG: src acc_id %u receiver_acc_id %u sender_acc_id %u\n",
+			src_acc_id, receiver_acc_id, sender_acc_id);
+		amdgpu_ualink_process_hello_msg(adev, receiver_acc_id, sender_acc_id,
+						src_acc_id);
+		break;
+	case AMDGPU_UALINK_HELLO_ACK_MSG:
+		dev_dbg(adev->dev,
+			"Got HELLO-ACK MSG: remote acc_id %u\n", src_acc_id);
+		amdgpu_ualink_process_hello_ack_msg(adev, src_acc_id);
+		break;
+	case AMDGPU_UALINK_NPA_REQ_MSG:
+		memcpy(&handle, entry->src_data, sizeof(struct amdgpu_ualink_handle));
+		handle.handle_lo = amdgpu_ualink_reassemble_handle(handle.handle_lo,
+								   local_acc_id);
+		dev_dbg(adev->dev,
+			"Got NPA-REQ MSG: remote acc_id %u handle %llx:%llx\n",
+			src_acc_id, handle.handle_hi, handle.handle_lo);
+		amdgpu_ualink_process_npa_req_msg(adev, src_acc_id, handle);
+		break;
+	case AMDGPU_UALINK_NPA_RSP_MSG:
+		memcpy(&handle.handle_lo, entry->src_data, sizeof(handle.handle_lo));
+		handle.handle_lo = amdgpu_ualink_reassemble_handle(handle.handle_lo,
+								   src_acc_id);
+		size = entry->src_data[2];
+		npa_addr = entry->src_data[3];
+		dev_dbg(adev->dev,
+			"Got NPA-RSP MSG: remote acc_id %u handle_lo %llx size 0x%x npa_addr 0x%x\n",
+			src_acc_id, handle.handle_lo, size, npa_addr);
+		amdgpu_ualink_process_npa_rsp_msg(adev, src_acc_id,
+						  handle.handle_lo,
+						  npa_addr, size);
+		break;
+	case AMDGPU_UALINK_NPA_FAIL_MSG:
+		memcpy(&handle.handle_lo, entry->src_data, sizeof(handle.handle_lo));
+		handle.handle_lo = amdgpu_ualink_reassemble_handle(handle.handle_lo,
+								   src_acc_id);
+		fail_reason = entry->src_data[2] &
+				AMDGPU_UALINK_NPA_FAIL_MSG_FAIL_REASON_MASK;
+		dev_dbg(adev->dev,
+			"Got NPA-FAIL MSG: remote acc_id %u handle_lo %llx fail_reason %u\n",
+			src_acc_id, handle.handle_lo, fail_reason);
+		amdgpu_ualink_process_npa_fail_msg(adev, src_acc_id,
+						   handle.handle_lo,
+						   fail_reason);
+		break;
+	case AMDGPU_UALINK_NPA_REVOKE_MSG:
+		memcpy(&handle, entry->src_data, sizeof(struct amdgpu_ualink_handle));
+		handle.handle_lo = amdgpu_ualink_reassemble_handle(handle.handle_lo,
+								   src_acc_id);
+		dev_dbg(adev->dev,
+			"Got NPA-REVOKE MSG: remote acc_id %u handle %llx:%llx\n",
+			src_acc_id, handle.handle_hi, handle.handle_lo);
+		amdgpu_ualink_process_npa_revoke_msg(adev, src_acc_id, handle);
+		break;
+	case AMDGPU_UALINK_NPA_RELEASE_MSG:
+		memcpy(&handle, entry->src_data, sizeof(struct amdgpu_ualink_handle));
+		handle.handle_lo = amdgpu_ualink_reassemble_handle(handle.handle_lo,
+								   local_acc_id);
+		dev_dbg(adev->dev,
+			"Got NPA-RELEASE MSG: remote acc_id %u handle %llx:%llx\n",
+			src_acc_id, handle.handle_hi, handle.handle_lo);
+		amdgpu_ualink_process_npa_release_msg(adev, src_acc_id, handle);
+		break;
+	default:
+		dev_err(adev->dev, "Unknown message type (%u)\n", msg_type);
+		break;
+	}
 
 	return handled;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h
index 0c2c5fad867af..bd8af7596a6ef 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h
@@ -35,6 +35,7 @@
 
 #define AMDGPU_UALINK_HANDLE_ACCID_MASK			GENMASK_ULL(9, 0)
 #define AMDGPU_UALINK_MESSAGE_HEADER_MASK		GENMASK_ULL(9, 0)
+#define AMDGPU_UALINK_HELLO_MSG_ACCID_MASK		GENMASK_U32(9, 0)
 #define AMDGPU_UALINK_HELLO_MSG_RECV_ACCID_SHIFT	10
 #define AMDGPU_UALINK_HELLO_MSG_SENDER_ACCID_SHIFT	20
 #define AMDGPU_UALINK_NPA_FAIL_MSG_FAIL_REASON_MASK	GENMASK_U32(7, 0)
@@ -340,6 +341,8 @@ int amdgpu_ualink_init_interrupt(struct amdgpu_device *adev);
 int amdgpu_ualink_sw_init(struct amdgpu_device *adev);
 void amdgpu_ualink_sw_fini(struct amdgpu_device *adev);
 
+int ualink_send_hello(struct amdgpu_device *adev, u32 remote_accel_id);
+
 int amdgpu_ualink_sysfs_init(struct amdgpu_device *adev);
 void amdgpu_ualink_sysfs_fini(struct amdgpu_device *adev);
 int amdgpu_ualink_init(struct amdgpu_device *adev);
-- 
2.55.0

