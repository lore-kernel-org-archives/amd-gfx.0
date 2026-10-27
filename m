Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A28CB606A31F
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Oct 2026 08:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=ivQ9VsRY
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 23F1210E23D;
	Tue, 27 Oct 2026 08:30:46 +0000 (UTC)
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012035.outbound.protection.outlook.com [52.101.53.35])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 73C3F10E23D
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Oct 2026 08:30:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ScECKJvK+6Te61fTafgAh++ye5QsHGFTfGHrKt281PBu4r4jNxXKmI0T3VFDW0N+TNaXknrlBDF4QeS98oGBNyzrrdv0JIfNnVpEPvAcZ5+vX0tWFBHiujKh6Qp1INVTCWcL3IJncws94qJcjSfdr3f9rzXfBWeYRE7QbqdojGxtzOJeYb8eO5QX9yFvm3uR98hXo6VMSamP8WvlN71iOF7b+ZB2Yv9kect7YNbNnxjclg6RzyltH5ihXxNyM2tJZwabo6fnUElLrVQ6aorvW6jgLpLGi9ceDcIotMblpMCIINai2yTufuC6JjH5juWNOEDejaaBGFfOAAJSXZqw3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3ex0/eN5ymKeliYj9zw8tBYfNfX9Ohi7buvw1fNqyoo=;
 b=ysMtxSyn0HX3tAMD1LahZZoHXEW4sZfAqPjmFkhHBMWq5GkvXelotpLu4ybSpuYFwfoiTXHBrkrzE3kB2mNK13DCoTPl1tI1NLz+Cb3ZdtG9ZUVMqxF1jN9xz/oNaKl6F9CuijgqSppnAcebzjTxkYcs2JhTdpfeu/6OMK9+IB5XVzx83ONGbBlr8qoRhDEw/YBVHklundSUZfHMIN/L7xzYv9HTrsTBWuP6fpm+NLzapr0sYg/HU2idqFMCmJFkWSa7QCiANGmN7nQGHnFuK7hICBGb66d7nae2VVNIsqujdoGVtGDrPDTl+aVPZXkQTL6b4WaSoVwCBj0xpH3uPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3ex0/eN5ymKeliYj9zw8tBYfNfX9Ohi7buvw1fNqyoo=;
 b=ivQ9VsRYzIUb1qsCVirbWv21iLP6huG1q4Tswrd8b0Fy7Uk2mFsl5/PAuzW1/zchuDmUqnFBQ/HRi2BfM0YZ6+FDTMliQzGUoyktuEAX5V+jm375q7WAd9GORH0rQxIyn7eoH/HP7kPpb2teTJ6hx8AaGiku29AUcSKcstqVs+c=
Received: from PH8PR07CA0009.namprd07.prod.outlook.com (2603:10b6:510:2cd::27)
 by LV5PR12MB9804.namprd12.prod.outlook.com (2603:10b6:408:303::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Tue, 27 Oct
 2026 08:30:36 +0000
Received: from SJ1PEPF000037A7.namprd04.prod.outlook.com
 (2603:10b6:510:2cd:cafe::2b) by PH8PR07CA0009.outlook.office365.com
 (2603:10b6:510:2cd::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.22 via Frontend Transport; Tue,
 27 Oct 2026 08:30:36 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000037A7.mail.protection.outlook.com (10.167.244.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Tue, 27 Oct 2026 08:30:35 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 27 Oct
 2026 03:30:35 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 27 Oct
 2026 03:30:35 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Tue, 27 Oct 2026 03:30:33 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Prike Liang <prike.liang@amd.com>, Sunil Khatri <sunil.khatri@amd.com>,
 Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH 1/3] drm/amdgpu/mes: set the MQD size of the MES rings
Date: Tue, 27 Oct 2026 16:28:41 +0800
Message-ID: <20261027083027.2776591-1-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.50.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000037A7:EE_|LV5PR12MB9804:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a53f812-7159-4ab1-1c57-08df340492ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|82310400026|1800799024|36860700016|261009223027099003|261021121427099003|10067099003|56012099006|261026121527099003|6133799003|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info: J/krUkvGVd+yeIX0T4uYuZ/GeHJW6iTamdUF4asxEdtyRibLK+W9r2BG4KwWZIcW4yL5ttfgQU2Y4O2DlPTNjXaP24nekK0XriVduZAHoWSXgdUP4Q9HE/C++25zqo/Jq1rpODBkA9XgNGizIIo068W9bNJP1BAw8Y3NDE8QJg2CfsE1of/Li0eVBcO0B1h7ON6IJB8ry79vnPQxSj/DTKR+DQnpjte/oVJA1/nff6qOdSCast6lOIecLvTw4gQEGP2tIN28aIt+yJz6ZQTbfrB0iM90ROxdUQGowVFk5/nmoc1iI3bDeWA0Q3jVsiWfYFkOccz0wvWCqVYoo/HFRtwKiV2jurHB2ckbdzVhdsgNQzIk3SyPKE8sK4tERIzLY77qFGe+CYIt+KngtOCaVzDb9T/8xlxk/+nDCB+g1NnfO0JtbHKHbK+F8/ac47ipnLS9XCpsjSGgXohMFdoeAGFlRtUMDbEGFlWwMv20JDLHdX/hr+2uuIzNmo0c46MjnTMOxs+5o4y9oZkQEJYB/CHklwwE9GqOWbPyZXOtzA8mJ0sCeTxKQE85dRloQh57mG1kPcN3qIE7XvTwamW8cUgBgcFjMfnSoy4jB0/5q6hWvZyUeVJTr3GBoao648bSIm/i6v8hW0d3s7Mh5jTouTHt9NKpBqkpQpo5sYySwbE+xrbLHltDdndjJmDBjTTQDkYb38WrnBzjxUe028Eo9Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(82310400026)(1800799024)(36860700016)(261009223027099003)(261021121427099003)(10067099003)(56012099006)(261026121527099003)(6133799003)(18002099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: pmgKhM2dpSlkBE/bNbTp90E9lcJN3FNw/MPU0YzmCsjrO49I7o+gtsGG3ogyk1ECaMprL2KEWQgf6bDaDvU1yyqgluq/Tl4kdCN9rqmy3J4mO95itpeCCfN3OfMQAUDDfat3oaKZ05ldIoY6TXLba6tIDUWgXIIkBr1jPlnxM6BIFus0xeUlt3MrTvC4d0FQ6zi+INFT1PgzG5s2TKCGuuJD8OHtohanCNOqKo/RfZkoQRkmNNRThTnEzQI2rzUzMgwLPbFCr3DjmCr8Xx1xeCkJQ70XMh7EpF44ScwLCfOCuz12fv3Lolb7HvniBmVw3e9XVMng7UP+cXT2EgdRcOxUFfuQtbFY6/XxjyfXTK2UqN/0rPCAwwd1ALQhVg0/Z+JwRrts3iV4E3FmuGA2Skgos6142ng1iGw52OD0nq9OpiWXVfp5oQ3Ry+x2IySx
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2026 08:30:35.8295 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a53f812-7159-4ab1-1c57-08df340492ef
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000037A7.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV5PR12MB9804
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

mes_v11_0_mqd_sw_init() and mes_v12_0_mqd_sw_init() allocate the MQDs
of the MES and MES KIQ rings but don't set ring->mqd_size, which the
amdgpu_mqd_<ring> debugfs files use as their size. Those of the MES
rings are empty, so tools can't read the MES and KIQ queue state.

On navi31, amdgpu_mqd_mes_3.0.0 and amdgpu_mqd_mes_kiq_3.1.0 have size
0 and read 0 bytes, while the gfx and compute ones read 2048. With the
fix, both read their 2048 byte MQD.

Set the MQD size.

Fixes: 445d85e3c1df ("drm/amdgpu: add debugfs interface for reading MQDs")
Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c | 1 +
 drivers/gpu/drm/amd/amdgpu/mes_v12_0.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
index fa5810209f37..0ec2c6cfd723 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -1858,6 +1858,7 @@ static int mes_v11_0_mqd_sw_init(struct amdgpu_device *adev,
 	}
 
 	memset(ring->mqd_ptr, 0, mqd_size);
+	ring->mqd_size = mqd_size;
 
 	/* prepare MQD backup */
 	adev->mes.mqd_backup[pipe] = kmalloc(mqd_size, GFP_KERNEL);
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
index 496ac632c3e5..6cb287e07a42 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
@@ -1963,6 +1963,7 @@ static int mes_v12_0_mqd_sw_init(struct amdgpu_device *adev,
 	}
 
 	memset(ring->mqd_ptr, 0, mqd_size);
+	ring->mqd_size = mqd_size;
 
 	/* prepare MQD backup */
 	adev->mes.mqd_backup[pipe] = kmalloc(mqd_size, GFP_KERNEL);
-- 
2.50.1

