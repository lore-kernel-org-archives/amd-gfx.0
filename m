Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EB78606A31A
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Oct 2026 19:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=iiLgz5Kg
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CB3A510E47A;
	Tue, 27 Oct 2026 19:59:42 +0000 (UTC)
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010062.outbound.protection.outlook.com [52.101.85.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BE7B710E47A
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Oct 2026 19:59:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tNhP92u4sW25bmguRxyYC7rGSHliiL/APfEstYQQk9hn//HWx1BgKLxAnT4xyjq98yDbLEf6qc8fo/gwL6zhEHvUJXZxoOodRvaDc0CM2f9AX2tFKhqTrHSJUij50XW+BLWYFa8E5MrYmdR/OO8w6V8a+dw7UNNpMTdomm2KxZJEn5eCUuIHmAPW/k7Mhm+CyU5WRAmsgsSpw3Y0zN6vcb0PhmSPkza/YTEa8YrJldZWZ3xrhx+HfRw4FSwlYVGuK4bnyVcMfg7AJP73EIA/iWcJURDzDh25SN7Sq3VZHeTKpoKyytyxnORYz4ccMT85ixpaDrscLxM/4+AQ8qyKQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rYTSZmiw0G1Zw7GBSqC3e5VG7JZ0Tqs+/RXH8shoxxo=;
 b=SoylGb3WDYv0pgG8fWCODdFjt/R8HCd2sWij1pwm66yxWju14nLwagnh+jzueGZ8sTA7/h1h5N16j+EwTl3J0lvWEtRpQslBlY6QXNs493pnojz3LtXlx8VQxgQAzvnJ3H7Hua2cGapWUGtR2EG4PisKMNJ1qLwjy+6B+MTIv7jAeO52/PvKw42zNRFX9HZzIWmMsuceJH7mDLbvmIyBruIf4doeaZP39waPiJVVnYfHjbGE6AxG3DpWjfhLL6j7rRbrg3umOaNUMj7MGCAGUSWQLbItteiDUIGKcMbALtPEVQZDmylFk/ykd6WlLFntovxgeLpyiS52MTrMkDCFXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rYTSZmiw0G1Zw7GBSqC3e5VG7JZ0Tqs+/RXH8shoxxo=;
 b=iiLgz5KgU6BnKuV7QPZiBCS1mFeeffHh9uf+pJnIZ+jTvBdd2I6SheeGRloFfEx/sybtJyJryHEa3OUMjs2fMKpPO3lVboVJKKDjUcAepU0tf8IJHm5xdUYmD9VFZTPtYafrB07CLkBoYMjAg9F66skefEyUOh28yKhNWcP0iKw=
Received: from SJ0PR05CA0069.namprd05.prod.outlook.com (2603:10b6:a03:332::14)
 by CYXPR12MB9340.namprd12.prod.outlook.com (2603:10b6:930:e4::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Tue, 27 Oct
 2026 19:59:33 +0000
Received: from PH5PEPF0000002E.namprd04.prod.outlook.com
 (2603:10b6:a03:332:cafe::4d) by SJ0PR05CA0069.outlook.office365.com
 (2603:10b6:a03:332::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.569.7 via Frontend Transport; Tue, 27
 Oct 2026 19:59:33 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 PH5PEPF0000002E.mail.protection.outlook.com (10.167.243.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Tue, 27 Oct 2026 19:59:33 +0000
Received: from mukjoshi-dev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 27 Oct
 2026 14:59:30 -0500
From: Mukul Joshi <mukul.joshi@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.Kuehling@amd.com>, <Harish.Kasiviswanathan@amd.com>,
 <philip.yang@amd.com>, Mukul Joshi <mukul.joshi@amd.com>
Subject: [PATCHv2 4/8] drm/amdgpu: Attribute UALink loopback messages to the
 correct sender
Date: Tue, 27 Oct 2026 15:54:17 -0400
Message-ID: <20261027195913.1794477-5-mukul.joshi@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261027195913.1794477-1-mukul.joshi@amd.com>
References: <20261027195913.1794477-1-mukul.joshi@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH5PEPF0000002E:EE_|CYXPR12MB9340:EE_
X-MS-Office365-Filtering-Correlation-Id: e5c60710-0a5c-436a-9ee3-08df3464d223
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|23010399003|1800799024|376014|261026121527099003|18002099003|22082099003|10067099003|56012099006|11063799006|261009223027099003|261021121427099003|261021123027099003;
X-Microsoft-Antispam-Message-Info: E7MpHGYmKvnhJyv4qDSIregB0n9Fib7iBheW/LUiaFcnFkJT4a/OYjsJbGeuuzs5vll14bmDwhVjenO6pgVSAe63KlOFHLr01wt/RrJ+0JxNtZoyBTQU+4YwM8w2gdBJfCGv1F/YqJDcb1Q7ADIBiTON6VvATHwB7JlloqA06q3d4L5qmY+nSqkSazSRaibSZv2BSWFr0gU/27Tz7l+IyG9Z2MfgkKUHhRoCZxBywMlgva2KzTKUBkXybQJ5wLXr0Sfbf+MVUTjYLjuruOXcyssQTZ7Q2ApxNaQNXZvyRmQOqTHad5hdyWakrhaW4XJIirW0/U9mwscJ63zdp2mbuL/WeFcXrMczbcs4ZCRaOBlGZ+oeSxPQGwIEQGBbtewsiqp8AqjrjaJZSIgFUwXRiQiwT3Vgmstd5vGPY0F5PTSeHlXNs33bzK3N9aRcR5XIox/wEndMsyyhiOMXFVMChUIV3kCIKEoJrdI/zsB/1LoeMshtn6ERxwZTAtlNniCbZPIM0n0E+YO5xjQvmtMsomM/AuHV2K8Aq1mtqBGWW/RNnWpemIEiUla1QBSBgSYg+eEHLyE6fJKqwRZLPs4X08fSpOliiTGd8mRS2hkW89vFIrtvqiAJD0but7Ynlk8YvnNTYlPvXptnlTWyvbHC9dBzZOSmzhXVcjUbljvVdmcas1m7Hya7d+gc6OtiAOXb+6MuHWbd5m6OqctwX1ioFA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(23010399003)(1800799024)(376014)(261026121527099003)(18002099003)(22082099003)(10067099003)(56012099006)(11063799006)(261009223027099003)(261021121427099003)(261021123027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 3ax/fHEN5+wuZSBG+s4C0RS5mPCcdVN3LVKroJ/MqGQSlRlGK3QkYQPrvNcC1Fq/rnAYBbp4VkjfvVG5e1pDTA40YTlJG19WHY2NBxCcKT+k1k2MQNnTr+yD1bMx7FVyyCFlI4xrakh9HxbsYWVSwxZPBRp2bVYIF7xKsB9YmnP07dniRTgeT2a5U+LZMiAqWHV/bTOcaGoQBC0D9MvWdo3Lr7EDEBGKOkLl8RuHWM0IPXSJZMuPHPf01PfMgB402qmR92dK42OaRf6uSeZA7yqUzRQ5m13jzaZKgOmbuqO+RtPaliZKE+rG2kk537HRub8D2maMG3tuZXDlhxfXKTYW1HkwRcJG7O2OxqUC9ax5Jyq82/YYmT8VFxk6NS/J0GNd7rRxXs3Ji1FbIzgUK/7J+v6DOdaJFLLzOAM1fKZsi8gZWYfBAMEj+b0xrEiC
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2026 19:59:33.6093 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e5c60710-0a5c-436a-9ee3-08df3464d223
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: PH5PEPF0000002E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9340
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

- The MP nHT stamps the IH cookie of every HW-delivered message with
  the GPU ID of the single physical station, the exporter. The only HW
  path is importer -> exporter, so attribute these messages to the
  importer. SW-emulated exporter -> importer messages carry no IH ring
  and already name the exporter as the sender.

Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
---
v1->v2:
- Use ualink_exp_accel_id/ualink_imp_accel_id() wrappers in
  amdgpu_ualink_process_irq(). (Lijo)

 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c | 32 +++++++++++++++++++++-
 1 file changed, 31 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
index 6c70be7badec..96a6023f51c5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
@@ -1090,6 +1090,23 @@ static inline u32 ualink_imp_accel_id(struct amdgpu_device *adev)
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
@@ -2238,7 +2255,10 @@ static int amdgpu_ualink_send_hello_msg(struct amdgpu_device *adev,
 
 	dw0 = AMDGPU_UALINK_HELLO_MSG;
 	dw0 |= (remote_acc_id << AMDGPU_UALINK_HELLO_MSG_RECV_ACCID_SHIFT);
-	dw0 |= (adev->ualink.info->ppod.accel_id <<
+	/* In loopback the sender is the opposite role of the destination, so
+	 * the exporter side tracks the connection under the importer accel_id.
+	 */
+	dw0 |= (amdgpu_ualink_local_sender_accel_id(adev, remote_acc_id) <<
 		AMDGPU_UALINK_HELLO_MSG_SENDER_ACCID_SHIFT);
 
 	dev_dbg(adev->dev, "SEND HELLO: HELLO message to remote AccId:%u\n",
@@ -6548,6 +6568,16 @@ static int amdgpu_ualink_process_irq(struct amdgpu_device *adev,
 		return handled;
 	}
 
+	/* UALink loopback: the MP nHT stamps every HW-delivered message with
+	 * the GPU ID of the single physical station, the exporter. The only
+	 * HW path is importer -> exporter, so the real sender is the importer.
+	 * SW-emulated exporter -> importer messages carry no IH ring and
+	 * already name the exporter as sender.
+	 */
+	if (adev->ualink.loopback.enabled && entry->ih &&
+	    src_acc_id == ualink_exp_accel_id(adev))
+		src_acc_id = ualink_imp_accel_id(adev);
+
 	msg_type = dw0 & AMDGPU_UALINK_MESSAGE_HEADER_MASK;
 	local_acc_id = adev->ualink.info->ppod.accel_id;
 	dev_dbg(adev->dev, "Got MSG: remote acc_id %u msg_type %u\n",
-- 
2.55.0

