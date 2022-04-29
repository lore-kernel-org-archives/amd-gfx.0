Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 147F9C433FE
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Apr 2022 18:03:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6005D10F8A6;
	Fri, 29 Apr 2022 18:02:57 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2044.outbound.protection.outlook.com [40.107.92.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5389610F892
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Apr 2022 18:02:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q800vyBhkvm1XRF4JFKuxlsKApWNaKh2EsRCSBFVFmVTBOH3bUF+Uz/YDukjOb8fuA8wRH2TJ3GH0h52qbZO+aKzWpUW2ltZac+l5R77KW0VaPSyh4xdh6z7u91uTdx7flqHo+oLvSURVYsWGlfrzH4bTnfon2uwjZe54LPraGfAQw3V9hrfAS5xl6B770xqKb+iuu36AQ8XB1Tb+IN6LIqIsZIuirlRxa3ZNf5yLFNwerQCOeltdcAf50WQ3JZjpvQBAIVZdFZRc5yR0oGJ4cfJE3b2ZX004NDjVlBTNzq3LoLtCCy074/4MPLqAfUIJRnwCrtLX/jQTMis23siXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q44krZVmMhWgjHKiTHZSJ45AYmvO/ov3NxYDQ0K+0Kg=;
 b=VKjXGKknV8sg3/dCRWKiMJv1b9Ftc4mDHX78E8+EOf+KdL8nfD9uk42RrhAK12YzvxooF6aDBas0eT+I5jEb+oA3CdWK92QkV0oxAkgjRZvvSWp7z6uj96gbIyPnt8wZTFM1u+biTwiqc5+tdW6zZNTg/GQ9wfOzuu6P63QPbIcbUns6qJrimaEtJ4x6sejaq6CTO+VkTPg8OEgcCj+fUIeCJcNQHalGMl99Uon4R6Omgo3gP5kQEqEvNc/LDRuRZJpdoZSqc3hDY2qRA8OM+AQJBimLPTPARXFQGzzOxoG56dVKxwhfI1Y6PrPnyM9C3b9bqnKwzQwO78aPe0OXdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q44krZVmMhWgjHKiTHZSJ45AYmvO/ov3NxYDQ0K+0Kg=;
 b=kg/IwFziByHyHpHrLZq9QYBMAXn/HobPJ3k7NXKhMou4btJ3tbfq21rnvwCD//AhHl9JiOYVdZ/ooTvxpNLzNrtpv06XLGaq8I0L0AJbu2Hk/ofeIJaWN3JtIgEF8g5FkCisMVcARpoqtPYe5BWuidbDHJkUGo5rxVLY0/IRkFo=
Received: from MW2PR16CA0067.namprd16.prod.outlook.com (2603:10b6:907:1::44)
 by SA1PR12MB5659.namprd12.prod.outlook.com (2603:10b6:806:236::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Fri, 29 Apr
 2022 18:02:46 +0000
Received: from CO1NAM11FT038.eop-nam11.prod.protection.outlook.com
 (2603:10b6:907:1:cafe::57) by MW2PR16CA0067.outlook.office365.com
 (2603:10b6:907:1::44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.26 via Frontend
 Transport; Fri, 29 Apr 2022 18:02:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT038.mail.protection.outlook.com (10.13.174.231) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5206.12 via Frontend Transport; Fri, 29 Apr 2022 18:02:46 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 29 Apr
 2022 13:02:42 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 08/29] drm/amdgpu: extend the show ucode name function
Date: Fri, 29 Apr 2022 14:02:05 -0400
Message-ID: <20220429180226.536084-9-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220429180226.536084-1-alexander.deucher@amd.com>
References: <20220429180226.536084-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 49756147-30f3-4de7-270b-08da2a0a771d
X-MS-TrafficTypeDiagnostic: SA1PR12MB5659:EE_
X-Microsoft-Antispam-PRVS: <SA1PR12MB5659EACB0CFC20A8467C3F75F7FC9@SA1PR12MB5659.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PZNld1NbYvnWr2RCWdfXU/k6vgr9aQgZcAA1/OLiX+ge+ePcNEAS53TGBZ4taxah+HjxEWAspulIlSPUY+L+7A6YMryNId3/LPv7HBdrCWwWXTGJUmkVb3aStAWYH3vc+GczYpiFOc9QAVNBzOXLCPXEPxxJSC9a0fwUUjunXpdYUxPj1FRB7tXUqHVtWd9ONNs4wlX3+Pi3UPTN1GzqRENa3JpZyqz1neXT4y62XRyQZdIGQu20dCWHzx3i/KAog/KGc1iYDbFgzKXA5Eq/bypUvujVH7zuOfCwns68TF+LEFIhroZnBDRu9OqrI2prI1PLoZelr9Fhl2XVOUTCH5e9B7FNxfwo2wxEvENMXQq3gD2DMz5EobkTngb+BdR0mXEY0FKlpfigONxDN/D3ivL+UUy7y1Toy1P3vVO4MVjzlg0r2pMHhyNB5otQWkHZmj+NeBRnrUyUd6TBCBIA8xNB9WSaFKlLUrZ1x3gtAv9WcnwqobbrsO6hqwUY17Su98zkH73yUKCHtddEir6MmsAYTEwXjse2O5MyH1XB691wVG7l/xA4KKrLHwSmb5B16PF4Jcus5RJPP7zNnxIq8MjgxAkXNVHvq5TgqsZVWsfZIeh/okFb0/V9i970MeEg2IXY7Vv1Y0wFFAwZlpsoLBhs7Xzi5igxT/gZtT1MXX/M6Uwo8sagX/5WYZOzqfM2yH1IXDjJo8s6LEhiZURKRQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(36860700001)(8936002)(5660300002)(2906002)(54906003)(40460700003)(508600001)(82310400005)(36756003)(47076005)(83380400001)(336012)(426003)(6916009)(316002)(8676002)(4326008)(2616005)(6666004)(186003)(1076003)(70586007)(16526019)(70206006)(86362001)(7696005)(356005)(26005)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2022 18:02:46.1066 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 49756147-30f3-4de7-270b-08da2a0a771d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT038.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5659
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Likun Gao <Likun.Gao@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Likun Gao <Likun.Gao@amd.com>

Extend amdgpu_ucode_name function to show SDMA TH0, TH1, IMU, RLCP, RLCV
and MES related ucode name via ucode id.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
index 67619090a548..89bf746fe96a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
@@ -515,6 +515,10 @@ const char *amdgpu_ucode_name(enum AMDGPU_UCODE_ID ucode_id)
 		return "SDMA6";
 	case AMDGPU_UCODE_ID_SDMA7:
 		return "SDMA7";
+	case AMDGPU_UCODE_ID_SDMA_UCODE_TH0:
+		return "SDMA_CTX";
+	case AMDGPU_UCODE_ID_SDMA_UCODE_TH1:
+		return "SDMA_CTL";
 	case AMDGPU_UCODE_ID_CP_CE:
 		return "CP_CE";
 	case AMDGPU_UCODE_ID_CP_PFP:
@@ -533,6 +537,10 @@ const char *amdgpu_ucode_name(enum AMDGPU_UCODE_ID ucode_id)
 		return "CP_MES";
 	case AMDGPU_UCODE_ID_CP_MES_DATA:
 		return "CP_MES_DATA";
+	case AMDGPU_UCODE_ID_CP_MES1:
+		return "CP_MES_KIQ";
+	case AMDGPU_UCODE_ID_CP_MES1_DATA:
+		return "CP_MES_KIQ_DATA";
 	case AMDGPU_UCODE_ID_RLC_RESTORE_LIST_CNTL:
 		return "RLC_RESTORE_LIST_CNTL";
 	case AMDGPU_UCODE_ID_RLC_RESTORE_LIST_GPM_MEM:
@@ -545,6 +553,14 @@ const char *amdgpu_ucode_name(enum AMDGPU_UCODE_ID ucode_id)
 		return "RLC_DRAM";
 	case AMDGPU_UCODE_ID_RLC_G:
 		return "RLC_G";
+	case AMDGPU_UCODE_ID_RLC_P:
+		return "RLC_P";
+	case AMDGPU_UCODE_ID_RLC_V:
+		return "RLC_V";
+	case AMDGPU_UCODE_ID_IMU_I:
+		return "IMU_I";
+	case AMDGPU_UCODE_ID_IMU_D:
+		return "IMU_D";
 	case AMDGPU_UCODE_ID_STORAGE:
 		return "STORAGE";
 	case AMDGPU_UCODE_ID_SMC:
-- 
2.35.1

