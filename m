Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AEC7606A328
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Oct 2026 23:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=mwk9zwlk
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A5AA110E280;
	Mon, 26 Oct 2026 23:03:16 +0000 (UTC)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012042.outbound.protection.outlook.com [52.101.43.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DF96210E280
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Oct 2026 23:03:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CPKMWnlLakQ/S9kLTtjufBYNdA4HJNqt9G/KWo1eK9v4YBeTHp7farh/QIsGLDyKC9A2HYMVYl+lY26CHf7rGYaX/r9A5G0MN4eVtZOrOG238gfhvXaulAThwc0RhbaFGjjz4969cHhegg1+WSXPwGRrXgVcXaaTXnXFOlyF4bIeoehHnd6VoHXCm5QthWrh/Vd82066QmyJnsjIiYQhLwDoAb70KOHBcnSy7IcyL+DZLCid2kEpqUOBBdhq22Gu0kdaQE2H4wwi5G153wSPxo05KKsUT6prACKRt7XXb8FLKpu38+gYRqt0r1/3yUFHcC6HrOXrFxELrEL0YB2hoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kn5BxGjm5x/cA4dKRaE5sRmOe0qs8qy3pdz6Si8NfXY=;
 b=YqY1cM+mIiUFoNAvyEvtwfD9/fQLy0BUGllbQdyaOhjxiKTH/dTDZ+uNLFtnaJ8wb42K1LCEw6rfFPrjxJfrfl7SQh0LIQ3YUoqSz+2CHKqdOf4nK/nskT95La51sw2QWCF4vR/rynOc1KyyVgtNQbTRtqryschv1qsi420OXJHXl9epqGIyca/e3hPH3XTNMmCe0r+JyPcMaukU5w3E5hiw1GdKLTnLKATKpoJLjxazlsfFQZptS1GIFjWjk0bQtN7UXYprVO47XQHo9pNsd0KlGJ8/1VSXHbWownJnVzugNJRSqLm6jEwsIzJacIiBEnk/qkuGJlxvti3FUulTkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kn5BxGjm5x/cA4dKRaE5sRmOe0qs8qy3pdz6Si8NfXY=;
 b=mwk9zwlk4CKIRWtrpvJjzDzCbipU2MUjMNArg4PZJZLO3rIVBgDL7+FNPiDXRX1TByCGxjvpVIi1p+BiIwwouY2Cr5XOTYHE2SRshWTyezNRdfRx25Mob6hr+xadN9Brd/570McK9OcSUxNrntfBlZplQHtvUdlvJowMCfkpPSE=
Received: from BN0PR07CA0004.namprd07.prod.outlook.com (2603:10b6:408:141::22)
 by CYYPR12MB8923.namprd12.prod.outlook.com (2603:10b6:930:bc::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Mon, 26 Oct
 2026 23:03:04 +0000
Received: from BN3PEPF00022BBB.namprd04.prod.outlook.com
 (2603:10b6:408:141:cafe::75) by BN0PR07CA0004.outlook.office365.com
 (2603:10b6:408:141::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.22 via Frontend Transport; Mon,
 26 Oct 2026 23:03:04 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF00022BBB.mail.protection.outlook.com (10.167.248.122) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Mon, 26 Oct 2026 23:03:04 +0000
Received: from mukjoshi-dev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Mon, 26 Oct
 2026 18:03:03 -0500
From: Mukul Joshi <mukul.joshi@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.Kuehling@amd.com>, <Harish.Kasiviswanathan@amd.com>,
 <philip.yang@amd.com>, Mukul Joshi <mukul.joshi@amd.com>
Subject: [PATCH 4/8] drm/amdgpu: Attribute UALink loopback messages to the
 correct sender
Date: Mon, 26 Oct 2026 18:59:26 -0400
Message-ID: <20261026230248.1597606-5-mukul.joshi@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261026230248.1597606-1-mukul.joshi@amd.com>
References: <20261026230248.1597606-1-mukul.joshi@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF00022BBB:EE_|CYYPR12MB8923:EE_
X-MS-Office365-Filtering-Correlation-Id: 33ff5e30-1a46-4f73-47fc-08df33b54aab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700016|1800799024|23010399003|18002099003|22082099003|56012099006|11063799006|261021121427099003|261021123027099003|10067099003|261009223027099003|261026121527099003;
X-Microsoft-Antispam-Message-Info: i6H96Z113F14C8NmcNvPV/80u/+rh06riIRSI3dtn9z2wiKVHXHtgJsJHvapes8Kxd9xM104yedg5jsKuDfz/LxOHXdDOfF6CYz4QpryqaeqPYixX/flp9ZkscczFNhyrUYQ379fNCsdhW65zORZCE4nI81m7dyhmylgXk+rGeVJDnxmAVSqIoS83dPtnMNl05TUzH0imfMSDjeT7Y2/HYDz7IJ8IZr+9gsQ8hGXZD7ic723BR9WAqdT/M/HWbGRuu/Gl23oBeHVnU1g3PjU7fOn7T4+F6OIV62Dxs/ZuDtIBGvhkhhaFmaFSUTHtxCSHjBNAr11jyWUb5o/nN2GZtdLR8fPM77w2kv0+0vNANu2g4EB84zZ1b41M19SjZ6ujgc1sGfU2C1pvIWNW26nFSBOZS8OkKxKZGtydVctzaMlmrFOShA/7ig+aG8ndS8k9X+1AE5kmS2luYZKHGm7apCkqcCZuxsHFZCz9z7E1Dfi0Y4uPR5+JlXPji7lxHxjzCkQL1vNBwxPJgk4ifpYTAPIzY0cTqrY5Jxcmd6K8YvJeI+Hp1835Q/zmqnUcLFNXWxu4PWxh27nQdDALIJZbZi/gZQuzqovqOutekAJc6rT9TZsr9ScUeyXb8GpOS9j66RUWzMMo7NBfd0uDZ4AE2B92hZ+U51LO28vtJrYCEvJ+ieARjRaCRemowzGB6If
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700016)(1800799024)(23010399003)(18002099003)(22082099003)(56012099006)(11063799006)(261021121427099003)(261021123027099003)(10067099003)(261009223027099003)(261026121527099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: kTflKqPZY53aEqh6yjuqYWFKyplM5KsWosql5iocxF8QSa66L4GFa/nP6iDFoko3n05gAvtJLkS9Hx7Tv/JeyfIKngu+qnookqxD0UcTIqmbsRle3co1o/VbfCnNaqTVHLz+1o4ktfSqRW4hcdX2/H/OWqHa5KIfJtGUK6ZKutT8p1kQ4NEIPUmy2L/Ph1jFBCWHkFi9d3KzltNJa9zJxzeAj3q4yoVRMEBuqjKk2LR+/jIV+CZhdOs731gcD6tVU3S0xTbUp9BCknWp0pxFsjAuJXBiyCn613Rz3NAd42rYvXsZ5MONafhEPTlknAAsF14GN9d7qQnt7wo5PDPDYLlKxXZux7BQHeGMVThl3PfdgvfXrnlH0pNfoNJDdDjP39NLRsrRQ8GKEV1RdcV4aUmDSDCrCA7D1bSVH0oN+b0IDQWFjnr0qI1umY6v4h8u
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2026 23:03:04.4312 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 33ff5e30-1a46-4f73-47fc-08df33b54aab
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF00022BBB.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8923
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

In UALink loopback mode a single GPU acts as both the exporter and the
importer, so the sender accel ID of a message depends on its direction.

- Send HELLO as the opposite role of the destination: a message to the
  exporter is sent as the importer and vice versa. Outside loopback
  this is still the GPU's own accel ID.

- The MPNHT FW stamps the IH cookie of every HW-delivered message with
  the GPU ID of the single physical station, the exporter. The only HW
  path is importer -> exporter, so attribute these messages to the
  importer. SW-emulated exporter -> importer messages carry no IH ring
  and already name the exporter as the sender.

Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c | 32 +++++++++++++++++++++-
 1 file changed, 31 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
index e40433bd79df..233ca804c4cf 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
@@ -1133,6 +1133,23 @@ static inline u32 ualink_imp_accel_id(struct amdgpu_device *adev)
 	return adev->ualink.info->ppod.accel_id;
 }
 
+/*
+ * amdgpu_ualink_local_sender_accel_id - sender accel_id for an outgoing message
+ *
+ * Normally a GPU sends messages as its own (single) accelerator. In loopback
+ * mode the same GPU plays both roles, so the sender identity depends on the
+ * destination: a message to the exporter is sent as the importer and vice
+ * versa. Outside loopback both roles collapse to the GPU's own accel_id.
+ */
+static u32 amdgpu_ualink_local_sender_accel_id(struct amdgpu_device *adev,
+					       u32 remote_acc_id)
+{
+	if (remote_acc_id == ualink_exp_accel_id(adev))
+		return ualink_imp_accel_id(adev);
+
+	return ualink_exp_accel_id(adev);
+}
+
 static bool amdgpu_ualink_is_local_accel(struct amdgpu_device *adev,
 					 u32 accel_id)
 {
@@ -2250,7 +2267,10 @@ static int amdgpu_ualink_send_hello_msg(struct amdgpu_device *adev,
 
 	dw0 = AMDGPU_UALINK_HELLO_MSG;
 	dw0 |= (remote_acc_id << AMDGPU_UALINK_HELLO_MSG_RECV_ACCID_SHIFT);
-	dw0 |= (adev->ualink.info->ppod.accel_id <<
+	/* In loopback the sender is the opposite role of the destination, so
+	 * the exporter side tracks the connection under the importer accel_id.
+	 */
+	dw0 |= (amdgpu_ualink_local_sender_accel_id(adev, remote_acc_id) <<
 		AMDGPU_UALINK_HELLO_MSG_SENDER_ACCID_SHIFT);
 
 	dev_dbg(adev->dev, "SEND HELLO: HELLO message to remote AccId:%u\n",
@@ -6557,6 +6577,16 @@ static int amdgpu_ualink_process_irq(struct amdgpu_device *adev,
 		return handled;
 	}
 
+	/* UALink loopback: the MP nHT stamps every HW-delivered message with
+	 * the GPU ID of the single physical station, the exporter. The only
+	 * HW path is importer -> exporter, so the real sender is the importer.
+	 * SW-emulated exporter -> importer messages carry no IH ring and
+	 * already name the exporter as sender.
+	 */
+	if (adev->ualink.loopback.enabled && entry->ih &&
+	    src_acc_id == adev->ualink.loopback.exporter_accel_id)
+		src_acc_id = adev->ualink.loopback.importer_accel_id;
+
 	msg_type = dw0 & AMDGPU_UALINK_MESSAGE_HEADER_MASK;
 	local_acc_id = adev->ualink.info->ppod.accel_id;
 	dev_dbg(adev->dev, "Got MSG: remote acc_id %u msg_type %u\n",
-- 
2.55.0

