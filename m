Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D0ABC433FE
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Apr 2022 15:20:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7EDBB10F588;
	Wed, 27 Apr 2022 15:20:55 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2049.outbound.protection.outlook.com [40.107.220.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6F03F10F57F
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Apr 2022 15:20:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LdLvZZA01LDRlLRYkD4TREoCgbrpCgvime8N/ZeuP2kH7fQna1uClGfe7hrrljggLYOoTXuhoCozQlnZqoTxHmJ1Rs4eMkHK2g2sboFK4fhThEKzOCpmjS4yD5GFfSaBdLDZVbIWNt05hRv9+hRlXPuG3gdW4Tlf+idzi++yVysXdL0iQM7smqQz7cWwEH2R222YlB0lvMT+b1IR92U+UwxWkGwtnkiFdLnSYv4vLK1txpPun9/YbtnRpfVmX88ctB4ZXPRBE8pUpJUd1cehmiSlbiSkZ6P+trZEtd+E1/6+7u+zQo7NU8v+6denKvmTe3x43tpaWArtBpjt+SO6aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PbDoByI+1IZlx5OIGmHSA/jwlsx+Bm3nVuu3yVIsGUU=;
 b=jZDlWNYZyoaoKCAwCYwE4Yxvoqx2SPF7SA4bGryi17rQp1jiqWHKoNznalFkgYRWrvLT+fz9/6lgNLa1TiQSYJvNe8mr+Fal5plAS53dXwfBKxL4RCKMMVEfZIcvAw1hfdyVhKo8nE3iwIxD2219EORIwMXkDSr6EJfKSXQWXqyIkGTsxA++IkAXIEQ+R8Dc5ugEQIXlE15XL0GnUZSTae+tw0iXCb+GhLaMVI2XliiXqtBl+r38yztjG1bh8T5YXelBMoBWYEneuO4kj31GHpfzvEWB6bpMI1OlTa7U+tZMUALWbPdhhvigU0mdky7RL6qxvFcQR8HQ38PwPKnsbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PbDoByI+1IZlx5OIGmHSA/jwlsx+Bm3nVuu3yVIsGUU=;
 b=PmPyXMMIciGPXPw0jgA1pbbWPduktGJ4mYluuFOtdsnsYWuUU1Bniv+ijF5RyjKyeGZNltuqeALX5l72wvYdspsXWaQKCIr/4xjZ68lkxKAUky+kCSe9n7WZN0Vzz3o9L/NNYWVQFJGmjg2x8SyiJdOPlEE96A3bPcc7r+FVRBQ=
Received: from BN9PR03CA0623.namprd03.prod.outlook.com (2603:10b6:408:106::28)
 by BY5PR12MB3969.namprd12.prod.outlook.com (2603:10b6:a03:195::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Wed, 27 Apr
 2022 15:20:45 +0000
Received: from BN8NAM11FT029.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:106:cafe::90) by BN9PR03CA0623.outlook.office365.com
 (2603:10b6:408:106::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.14 via Frontend
 Transport; Wed, 27 Apr 2022 15:20:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT029.mail.protection.outlook.com (10.13.177.68) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5206.12 via Frontend Transport; Wed, 27 Apr 2022 15:20:45 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 27 Apr
 2022 10:20:42 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/4] drm/amdgpu: add soc21 ih clientid definition
Date: Wed, 27 Apr 2022 11:20:27 -0400
Message-ID: <20220427152029.3105101-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220427152029.3105101-1-alexander.deucher@amd.com>
References: <20220427152029.3105101-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3eca9465-781b-4d31-0491-08da2861801e
X-MS-TrafficTypeDiagnostic: BY5PR12MB3969:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB396995C26BCE0942E3145BB8F7FA9@BY5PR12MB3969.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: swEA3bLhqzCW8pqj8RwGJNEw4WX9YNMAWKYM2NMM60OkKqV3FL0m0+17LBJDBL8RHj5ThKQrQzYQEHv5Ynb3L8L4L1ewxvbfQ6RowtmSwdoW6yBNGGQzE+koyNILErLbavaWvz3UJ91rLZnQBXM01iGHWryrHZfTukL7++8mxq3Rd64zHPo27o1b+tInij8IZciz1ZFlIKS/EGFUa+tmul0X7iIlxEOWg5k9rGyGPKzOEXH+MW2mYb3pePHNTdoCQkrbLqZ1IeZwXNDDUyg25Y8xvrc9KGt0pNJhbyoixXq1K45FdIQ3LkURQwXPzml0MHuYeBHGkeWomtbwdXJy3lDOwfVWNn6HIDYUyguiBFwp/FjSmZTLfnxbZDjaCeGESzgrUtZO+SF/rJPkivJ09GxrS9BU5qgd4P9unbGV6D61oRcdrO7OkV+ToswHAwH5/bPjKDZt4ehVzmt4eo/tRP68w05HuPYZfM7stf8lhDQNRj9jmMKJRTOa5MMzbweJOQrHDIHAejaF9PbqtDgRAwq8sWSeSySalKyDt1kx9TjF9aJ4VmlvdD0dL1lTQcU1mgDI86g2xK4RsNG78dwJfoTlDwWZk7XhoPPxExj8xBoq6A7SW1oeiisRs7HIcbj3/9rbfHgbhA6SWmfNbv92BcDW4eAbBcNkMcK2slA0eGcGYgBbbGZ+FQhsy9EAj634S1NReXAwRb9XjV3yvwamwg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(6916009)(426003)(186003)(81166007)(356005)(86362001)(47076005)(1076003)(508600001)(6666004)(7696005)(16526019)(2616005)(336012)(8936002)(82310400005)(8676002)(36756003)(4326008)(5660300002)(2906002)(316002)(70586007)(26005)(70206006)(36860700001)(54906003)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2022 15:20:45.1330 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3eca9465-781b-4d31-0491-08da2861801e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT029.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3969
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Stanley Yang <Stanley.Yang@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Stanley Yang <Stanley.Yang@amd.com>

Define soc21 ih clientid

Signed-off-by: Stanley Yang <Stanley.Yang@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../gpu/drm/amd/include/soc15_ih_clientid.h   | 27 +++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/gpu/drm/amd/include/soc15_ih_clientid.h b/drivers/gpu/drm/amd/include/soc15_ih_clientid.h
index 1ace2cff0883..21af181a802c 100644
--- a/drivers/gpu/drm/amd/include/soc15_ih_clientid.h
+++ b/drivers/gpu/drm/amd/include/soc15_ih_clientid.h
@@ -79,6 +79,33 @@ enum soc15_ih_clientid {
 
 extern const char *soc15_ih_clientid_name[];
 
+/*
+ * soc21 IH clients
+ */
+enum soc21_ih_clientid {
+	SOC21_IH_CLIENTID_IH		= 0x00,
+	SOC21_IH_CLIENTID_ATHUB		= 0x02,
+	SOC21_IH_CLIENTID_BIF		= 0x03,
+	SOC21_IH_CLIENTID_DCN		= 0x04,
+	SOC21_IH_CLIENTID_ISP		= 0x05,
+	SOC21_IH_CLIENTID_MP3		= 0x06,
+	SOC21_IH_CLIENTID_RLC		= 0x07,
+	SOC21_IH_CLIENTID_GFX		= 0x0a,
+	SOC21_IH_CLIENTID_IMU		= 0x0b,
+	SOC21_IH_CLIENTID_VCN1		= 0x0e,
+	SOC21_IH_CLIENTID_THM		= 0x0f,
+	SOC21_IH_CLIENTID_VCN		= 0x10,
+	SOC21_IH_CLIENTID_VMC		= 0x12,
+	SOC21_IH_CLIENTID_GRBM_CP	= 0x14,
+	SOC21_IH_CLIENTID_ROM_SMUIO	= 0x16,
+	SOC21_IH_CLIENTID_DF		= 0x17,
+	SOC21_IH_CLIENTID_PWR		= 0x19,
+	SOC21_IH_CLIENTID_LSDMA		= 0x1a,
+	SOC21_IH_CLIENTID_MP0		= 0x1e,
+	SOC21_IH_CLIENTID_MP1		= 0x1f,
+	SOC21_IH_CLIENTID_MAX,
+};
+
 #endif
 
 
-- 
2.35.1

