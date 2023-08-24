Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADF11C71145
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Aug 2023 21:53:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2BBDC10E5D1;
	Thu, 24 Aug 2023 21:53:23 +0000 (UTC)
Received: from outbound.mail.protection.outlook.com
 (mail-co1nam11on2040.outbound.protection.outlook.com [40.107.220.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BDBC810E5CA
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Aug 2023 21:53:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VGMvAfKZiKzw3J/96qMGWagnWApNp/uC/pVD4rdykSuG6+y7kbhXZsQG6JT4ArY5Eo9eo0mJjv4JZsWDyN5rjE/mDRYko+pKzgSjhJE22pulHJQ6PXFiSqKCfVQSVsPaPmzXPfH1CLnzCuYp4101hZ20MIiEB/fQrz7FJPo23FrvzmSZzou1S6y7EiXvLQA7Vf6/jue/Hch/W0rCghInK7TVNvBuZ01UGbjnbqg9+qm6KeGC5xqiTvSi2Ci6a6DTbzSOkjyw+VMy9AJLvKBk1Mi9kM/w21WLvb2JfwSvQfkkwuHQWdI7MYddt0DzGH67dAOtI4FzcUTXPsVY8m9sgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pq5nE62W+u7ehypwTmAcjQWrprx75fCGJYQAH/Uw8co=;
 b=Uj4fmog+YXSta+ODQbFVkRn2sRDzHZXacXHBQ6ghx8fcJ2H90YmizepSVErgto2ER926ZcHXuvpFxhhhTODQTToAbPZAtCcFXub9aud9N01pV6Wbcmj+8vYb6UB2mLIgiV4AsnanGwxbVF8TQKeK2++IZg0O+oBcPc8+WbBFHaKSPwzXiUXiMSyTgvkmisj36/eCz2m95+KQ8Ni7TYXnahkmsMOMFU1wuWgMXtIU46SG9dcU6YjV5XJXubf/3DtmYNlqpK5TX8GiPgdphkbLoIes+ESw/anA2gG6lJw+OnzwIO/LXrgDq//2YKMRCfGc8oGUqZ2La2+zvAsoaLfdBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pq5nE62W+u7ehypwTmAcjQWrprx75fCGJYQAH/Uw8co=;
 b=e+k1Y0EklG6a2K58eDiJGsOak9yKaHeqIA2+Hh67PKdkmDJKYt5mXQ/7Lg+5MKQwtuJkD54EqIgKM2Vmo3g2bopvHfIQoE9McojYvz8zEB9WeBmJeVTJIz9kIipLoqFahOLvDFe1PUoeIa4Qqqe4ipvep3KAZnd5YvU0ey1sLco=
Received: from CYXPR02CA0039.namprd02.prod.outlook.com (2603:10b6:930:cc::16)
 by BL1PR12MB5780.namprd12.prod.outlook.com (2603:10b6:208:393::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27; Thu, 24 Aug
 2023 21:53:16 +0000
Received: from CY4PEPF0000E9D4.namprd03.prod.outlook.com
 (2603:10b6:930:cc:cafe::ef) by CYXPR02CA0039.outlook.office365.com
 (2603:10b6:930:cc::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27 via Frontend
 Transport; Thu, 24 Aug 2023 21:53:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D4.mail.protection.outlook.com (10.167.241.147) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.15 via Frontend Transport; Thu, 24 Aug 2023 21:53:16 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 24 Aug
 2023 16:53:15 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 4/9] drm/amdgpu: add VCN_4_0_5 firmware support
Date: Thu, 24 Aug 2023 17:52:56 -0400
Message-ID: <20230824215301.2739707-4-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230824215301.2739707-1-alexander.deucher@amd.com>
References: <20230824215301.2739707-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D4:EE_|BL1PR12MB5780:EE_
X-MS-Office365-Filtering-Correlation-Id: c3b30abb-880b-49d5-5550-08dba4ec8597
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: U7f/tGjwv8HJsSZJSKYHRGnUFir1am7dWz61mrXLikjLct53lBsms/5vC32q98MoLw9F+pEhZP+pkmmSAV+kB9swWu4dMgiHJMjdI2P5KDtLeQRvj4HbxeXFw/1lHYox8wXkQKId/bxG5REMKRPkOkWD2UcWWxeqsx/W8uimBBHnvjqVkbizpwUBNxgtbS1iETw/nyOuKXtRYak/Lod0dLMZ3c5kjEWbIdnHE3Mu1O7PYdydnkxbI618ejTTTRNsCS/L3jmpr46I6vdA9aJm5Fu6VDTiG4sD85oF1SUrlIM//Nn8JFzhbdh8BDXAR5m8eyT2U6uWVcY6gFgy+r6yGOGn6bFla2RIoCRP02ehwvrXeZAhoVDrw7ZuJzDS8bjqslpA+4/eqPt1JUdKP08AHs3iZxa2hmKf4wkTwDUkXX5/W44/7Ujc55V38my0PvO00eTiaTQE5Q2SI9kd5heYm8rNFJk1TZ4/ZS73JatPDF2dvAB9xQmPKzqMH4ziAIge8dR5hOVw5U32U3GD8v8GFi/n2HakrA4IvQShNoyT/8tv6oh9O9SKHQ/LLMYg8qaxoZJL/Fy0w/uUkMq4ZsRUblHu749l3Y09eux8kl+H1CVcvCzfVX4h6oR4/aS1UZ5jk5rS4yqY9AD6CeFYn3FbIIUGIfSyhrRpbN2vYGuoCvErFO4RU6X+6FSADAMn+56D5v8y0K/A9/pMqnJxN5YGKOTmFbhpXZWxfn6JX/qKRzwryXKSt8DKbz9A/yZdRmhbmMFiQbojRwVH/yNpFPeKXw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(136003)(396003)(39860400002)(376002)(451199024)(82310400011)(186009)(1800799009)(40470700004)(36840700001)(46966006)(54906003)(70206006)(70586007)(316002)(6916009)(478600001)(26005)(36860700001)(356005)(6666004)(16526019)(40480700001)(82740400003)(81166007)(41300700001)(7696005)(86362001)(2906002)(8936002)(8676002)(4326008)(1076003)(40460700003)(2616005)(5660300002)(36756003)(336012)(47076005)(426003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2023 21:53:16.2487 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c3b30abb-880b-49d5-5550-08dba4ec8597
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5780
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Leo Liu <leo.liu@amd.com>,
 Saleemkhan Jamadar <saleemkhan.jamadar@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Saleemkhan Jamadar <saleemkhan.jamadar@amd.com>

Add VCN_4_0_5 firmware support

Signed-off-by: Saleemkhan Jamadar <saleemkhan.jamadar@amd.com>
Acked-by: Leo Liu <leo.liu@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index 36b55d2bd51a..f5793ec4b7c4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -58,6 +58,7 @@
 #define FIRMWARE_VCN4_0_2		"amdgpu/vcn_4_0_2.bin"
 #define FIRMWARE_VCN4_0_3		"amdgpu/vcn_4_0_3.bin"
 #define FIRMWARE_VCN4_0_4		"amdgpu/vcn_4_0_4.bin"
+#define FIRMWARE_VCN4_0_5		"amdgpu/vcn_4_0_5.bin"
 
 MODULE_FIRMWARE(FIRMWARE_RAVEN);
 MODULE_FIRMWARE(FIRMWARE_PICASSO);
@@ -80,6 +81,7 @@ MODULE_FIRMWARE(FIRMWARE_VCN4_0_0);
 MODULE_FIRMWARE(FIRMWARE_VCN4_0_2);
 MODULE_FIRMWARE(FIRMWARE_VCN4_0_3);
 MODULE_FIRMWARE(FIRMWARE_VCN4_0_4);
+MODULE_FIRMWARE(FIRMWARE_VCN4_0_5);
 
 static void amdgpu_vcn_idle_work_handler(struct work_struct *work);
 
-- 
2.41.0

