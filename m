Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D096606C3E8
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Nov 2026 16:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=lRv9AVfY
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D85C110E65E;
	Mon,  2 Nov 2026 16:02:23 +0000 (UTC)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012064.outbound.protection.outlook.com [52.101.43.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2864A10E637
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Nov 2026 16:02:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MpWsTzddylZ5zHjMOwCyAtaaRzm5QiA9/elOn0L1Q8AfAgmSCBPMAcBZc4E6FId0DXTKXQ1jtvoCO2Q3c+Og91gB4rQZdMEmlOiGcdWMEIy+mhuztV2hTz5evFn+0f3rp3j4dZaMfEW89d4aLUs+FFKjrlLarMPyFluMQnUH598qwfM02/fv1Qt5Gw3OWsZamgfDWaB+Ji+1OACZNAEm9DNM91YDkcRgVsGUMNL/klVJiz4ObaapWbr9TzP85zhsl/JmN9XJnATyZ0sJBcmckNAQliMTEJi5EtvFJc+jSHnb19IMg+bvQnyNPuky9mIKW1DDIQSVIUVQKESQi3BsEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xEn3jRS6Fh1VpcpWNFhaGHZDivdMyOqhiDB1YkZhpR0=;
 b=MvHRILBl+BI/HuigSqIhbgRA4vrZ8LmlgqrtvSUM73g0Rwjgo2yBw1xZO0Op7dPZ5ea5s7SR2iDCNlG8o84n5OqsCUNEijRlj9JCvGvW5wRS3ai9kHax+3A5DeE/0+aQiR6Wsv203P8mxnksuOO+ucpkPzb9vNksyTDmspGiIrEQTj/qORiIArCLJRaCGyUNo6gFMUeSO+33NzCu4eWXDxCODlkotLo79QRg04ml3SzE8cSgYPOW5NuUjD8jlPxc9B3Wfy9lo4MR9xvp99e9ymQpgqbcVMhqx28LsqOS0miFKGkdky6vBB1WZ4J81iJmBbFw4i4+7iIwsJXoRh0QBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xEn3jRS6Fh1VpcpWNFhaGHZDivdMyOqhiDB1YkZhpR0=;
 b=lRv9AVfYXoyzZqeS8Rccu27B7hsEX2TpTyuFDvE5TeXhcHOiKs8Y7EK0miOoi7K/CRoMAJYXgY/5ykWgyRDjkSGk1ZG0TNS4bBG6tL/ng9ez42iXqkWT1SFbzZG1Qq5Kdh7Ke3d/FHWanxCOFZVaSf2m4hGHfgTTj9uAzSQGgzQ=
Received: from PH8PR02CA0031.namprd02.prod.outlook.com (2603:10b6:510:2da::7)
 by IA0PR12MB8895.namprd12.prod.outlook.com (2603:10b6:208:491::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Mon, 2 Nov
 2026 16:02:13 +0000
Received: from MWH0EPF000A6735.namprd04.prod.outlook.com
 (2603:10b6:510:2da:cafe::63) by PH8PR02CA0031.outlook.office365.com
 (2603:10b6:510:2da::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.569.12 via Frontend Transport; Mon, 2
 Nov 2026 16:02:12 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000A6735.mail.protection.outlook.com (10.167.249.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Mon, 2 Nov 2026 16:02:12 +0000
Received: from mukjoshi-dev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Mon, 2 Nov
 2026 10:02:11 -0600
From: Mukul Joshi <mukul.joshi@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.Kuehling@amd.com>, <Harish.Kasiviswanathan@amd.com>,
 <philip.yang@amd.com>, Mukul Joshi <mukul.joshi@amd.com>, Felix Kuehling
 <felix.kuehling@amd.com>
Subject: [PATCHv3 4/8] drm/amdgpu: Attribute UALink loopback messages to the
 correct sender
Date: Mon, 2 Nov 2026 10:47:50 -0500
Message-ID: <20261102160125.2743750-5-mukul.joshi@amd.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261102160125.2743750-1-mukul.joshi@amd.com>
References: <20261102160125.2743750-1-mukul.joshi@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6735:EE_|IA0PR12MB8895:EE_
X-MS-Office365-Filtering-Correlation-Id: c3ff047e-82f2-4ce5-a2ae-08df38faa7fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|376014|23010399003|1800799024|10067099003|22082099003|261102123227099003|18002099003|261102130727099003|56012099006|11063799006|261021123027099003|261021121427099003|261026121527099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: ceJ4SUKyP6WDq0n2QPAdc8VU3wihLiFvOnwHTyiO4TuQb1ZbYsq41QGsDilrwnh98J1CsO+x+xDyc58WPJ/+I0Kqdmax1nX8SfCGHJZDlF/QYtDLuyYgZr1zLcUifAxNrFVt4/SRHddpsh2UVFPJweQsTHB8W+LXJod/fV4co0PaYH1ndT4Mt2CSUw9ok0tG1UySiTQbpVOeJulj6Vb6mmAFl0zUE+cYJa1gCBfILAEueKukhx4ASOWFoqTADLKmu3DtzUF4cwZhGTD1FmND9l6/HGhfUBBNN3xd5d9apT40x43NtF0RC7VWyaci06Lnrpbd5wXklc8RV6KpuC6oDB7K53D9ueeuPkLXOYzGMVtd64r+PQu8rHpJpsQ1xHEfw5BY5GAm0j3qZnFInDDhtWE+Xp0YYqwVy4k4FxHqM+1QEeZOim45qHGzP6nALWXG5QXNzdiKy6HFGLPrdTixVJWdF96pWBtqYJ7bmtWixltuNTNsdsCOFxlbHI9ydCkw5hS4l7Y2pXUkol8svQQERsDEz9EcFz96v/qheKc3IAPXWVgyrOCtcr8KbegUhx1CAuEqQjHQZIERS4/eEdN9Zg7AwfAkMrFgTH/2NntKxOaZhukKyjSJCKBJ/sj5Y5H2WYMW0++8EQh3eY1RmvTbJxj6VvzA/Y/m05o5cb5ZtbQOtnfb3GzkL3mLF7TDIoy7
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(376014)(23010399003)(1800799024)(10067099003)(22082099003)(261102123227099003)(18002099003)(261102130727099003)(56012099006)(11063799006)(261021123027099003)(261021121427099003)(261026121527099003)(261009223027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: NfN01OR+ymwC2J2M1MRRSyEXNN/qo5vGanH28om5K0Ux78GnzacQ57OA/EebDSuY+v38JxGHEglv0rHPRB/zw7ET7WYNs20jEULhW/Leph6C+/lisyynrKRs57LFwCUgU4ymwmkJo3bSUu0YVYk4kxwf3tGY+lzXYyx4QgeQtJ420Zo+IqM75VhED/4k4q4ajINxnR95a+XG2g5pBWAnFxmiOIPj98QkS8qzdfDJHiB29em6n1W+17jR6FeghKRysffC1HwI0Ud03HesRVIHtJF5XWGXegeKu+X4JgFVYM3MnX/wDNI9stj6fD5vxhnWYpx+PJVQafN5Yd8vQsmNtM06GQVv3eu/U+ghgI7dX69rt9vUNjIac8hOxHNRfWaimuFACDO3rVN6M7GgJj1riH9JO1lwxGjHJBg6rx7fvmd6jinSW7iToSukJLCOCSnC
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2026 16:02:12.0207 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c3ff047e-82f2-4ce5-a2ae-08df38faa7fd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000A6735.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8895
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c | 32 +++++++++++++++++++++-
 1 file changed, 31 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
index ef133c60bb9a..8558dc1a9e84 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
@@ -1091,6 +1091,23 @@ static inline u32 ualink_imp_accel_id(struct amdgpu_device *adev)
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
@@ -2249,7 +2266,10 @@ static int amdgpu_ualink_send_hello_msg(struct amdgpu_device *adev,
 
 	dw0 = AMDGPU_UALINK_HELLO_MSG;
 	dw0 |= (remote_acc_id << AMDGPU_UALINK_HELLO_MSG_RECV_ACCID_SHIFT);
-	dw0 |= (adev->ualink.info->ppod.accel_id <<
+	/* In loopback the sender is the opposite role of the destination, so
+	 * the exporter side tracks the connection under the importer accel_id.
+	 */
+	dw0 |= (amdgpu_ualink_local_sender_accel_id(adev, remote_acc_id) <<
 		AMDGPU_UALINK_HELLO_MSG_SENDER_ACCID_SHIFT);
 
 	dev_dbg(adev->dev, "SEND HELLO: HELLO message to remote AccId:%u\n",
@@ -6567,6 +6587,16 @@ static int amdgpu_ualink_process_irq(struct amdgpu_device *adev,
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
2.56.0

