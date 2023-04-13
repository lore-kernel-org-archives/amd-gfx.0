Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C94DC77B6C
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Apr 2023 02:35:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1485F10EA15;
	Thu, 13 Apr 2023 02:35:17 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2074.outbound.protection.outlook.com [40.107.100.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5DECD10EA0C
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Apr 2023 02:35:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UAui0VWGvlk5Tm9vm9ohGtH++E3fTp96dkCf/dBGlMSd7zYG44gxP82F2QUSYRbwqdGBqBaOkrP4QoWPBJBiTJqz4miKXJqCo37pKE+PJhhGB2s2mG2t+xhu19NXgOHjpojjOZIowLqHtpqqFqUqmZMutHP9ToPixMXYnKXIZHQIla7WCSGZAiX1NIBLwgkSLoSQ0O7z9gVoS2c8I6PNQXuk63LyHhvHrv5gKhn+ABSv1UBDF8utw8G31tyLbtAxdl3/cmzpBAVV5/kLSl5ewZV7wA2Z6sjH1HAP4IvGtM0qAvwYZOg8oUzqyNSEdA/F/VidtnNXpS/3mpJ2dpOUfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FfOLD7IheCJBbwq9IIngM0BHygP9gcxqi7a8JCcx7I0=;
 b=CrGiWEtS0r5+8HhAPBNjgHgG726PSgBFXrxtvG1ZSBaA+yiTcQWi9QJbahdbPS5hiO+A/IxUmKWR27GufNbdMo6Q8aCSrc7W7YazIkHLHlD8gr6AU5a/H23fQrXwce2vm1YqmUzpIuH80CuJUQSQyyVrwvU6o42mPFVlOW8141qAq7lp4CKJjuXbw2IqI7cUzmnGpgtONKYoJ3FKFSuPlpuuI30jzj4yrYGn0vET0Wv9espIFeUHeouYRSWSvNfux1dlImWsh7RGZYjVZA5o2mf63KczgMrMhsiPNwkAi6yOOqx+y9uUeSWW05ykpKlzyo+O5lwMVqt3xpilLwjmoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FfOLD7IheCJBbwq9IIngM0BHygP9gcxqi7a8JCcx7I0=;
 b=v4WbjaUSE7u0gi9nKlVVvXuizQkRC9HITKM40H9/roxNhfZxZmzptUSd/0hcDd9kpYjTcVkEi/lamzrmkw39tQ2lHo5EzVS+7A55GjoDCfZhB8KzbdpJRtASyDjbzn1ccFNvxdSAun3buDw8dz5gVEVB5BnsjRXkC+9tIXB6c2c=
Received: from DM6PR17CA0028.namprd17.prod.outlook.com (2603:10b6:5:1b3::41)
 by BL1PR12MB5971.namprd12.prod.outlook.com (2603:10b6:208:39a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.30; Thu, 13 Apr
 2023 02:35:11 +0000
Received: from DM6NAM11FT097.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1b3:cafe::5f) by DM6PR17CA0028.outlook.office365.com
 (2603:10b6:5:1b3::41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.30 via Frontend
 Transport; Thu, 13 Apr 2023 02:35:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT097.mail.protection.outlook.com (10.13.172.72) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6298.31 via Frontend Transport; Thu, 13 Apr 2023 02:35:11 +0000
Received: from jenkins-mali-1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 12 Apr
 2023 21:35:07 -0500
From: Li Ma <li.ma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: reserve the old gc_11_0_*_mes.bin
Date: Thu, 13 Apr 2023 10:34:07 +0800
Message-ID: <20230413023406.3111352-1-li.ma@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT097:EE_|BL1PR12MB5971:EE_
X-MS-Office365-Filtering-Correlation-Id: 59f5de4f-f5cf-44c2-450e-08db3bc7b492
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0hCjxKFgLKWXuVee/3QHGshAnPubxjx6gFZ+dY2FllwHVCHF81TMBLjJDGAUiRDMsEx2C2RYADbAa1b+3kDhiU8KCbBSCWzOCHJ2BqM4wTulOzxhg8dpeRRESL6RDnRGj6C2XBaEROwuMgXvSpNOFPrspDjhPY6Q35D/1TLtUHv++2HmXuTXgbC7MIiaAXfpkW9eeSKRGaDoXZLiE/LZFHffZjJ6ppthxdKn+S7L4a2tMfZCrn7/C4Wr+6YMVKcGeGk7gPZMnd4s22GTfwZMBVqqF4HOk+6HP/ce8Ply343SIKntpqm95rU1hj0vIA3E8BEJZ2LKuojdwFgxZ0OgAggN3v9advcK3FY1tOavUV/oD7rGRexqchA/7rYuZsRk0GPsPWxrEgQnHdH+C9ce0pJvwnO2oWVe/5u485uTMx9YandDktMS25Vpmjbnwvfkk4pmG1C6ML3rWdCZFnYl34VsTCdBwehjrFdGdEdk4wZS4p7kMuwzRtlwi823QtKSAZAwa21uw6Z8Le0xKHXgmuMTHzGWupeZIknaPtSEdBKG1I5cN+PEcJjVeOM5TwmUJY9z9bbYrg9MUgcy+LP4o/G4VFas0Y8azAlVsjvRDRsHzLl7rfyw0z5j3WHPZm3y7kxArIg2Uab2nNWM2SSE1k82R3UAvqAUu3aaOroCdhyHhYXenNKBe/NFs1AOyaCd+79W0PfNZ3E25tzAJEkldgmzF4Vqw+7VRTcyj47aIqg=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(39860400002)(396003)(346002)(376002)(451199021)(46966006)(40470700004)(36840700001)(36860700001)(426003)(83380400001)(70206006)(336012)(70586007)(47076005)(2616005)(186003)(54906003)(16526019)(478600001)(26005)(1076003)(7696005)(2906002)(44832011)(5660300002)(36756003)(6916009)(81166007)(356005)(82740400003)(4326008)(82310400005)(41300700001)(86362001)(316002)(8936002)(8676002)(40480700001)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2023 02:35:11.6291 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 59f5de4f-f5cf-44c2-450e-08db3bc7b492
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT097.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5971
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
Cc: Alexander.Deucher@amd.com, yifan1.zhang@amd.com, Li Ma <li.ma@amd.com>,
 xiaojian.du@amd.com, tim.huang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fixes: 0f486b64b8d4 ("drm/amd/amdgpu: introduce gc_*_mes_2.bin v2")
Reserve the MOUDLE_FIRMWARE declaration of gc_11_0_*_mes.bin
to avoid falling back to old mes bin failure via autoload.

Signed-off-by: Li Ma <li.ma@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
index 7e8c15cd8dc2..45280f047180 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -32,14 +32,19 @@
 #include "v11_structs.h"
 #include "mes_v11_api_def.h"
 
+MODULE_FIRMWARE("amdgpu/gc_11_0_0_mes.bin");
 MODULE_FIRMWARE("amdgpu/gc_11_0_0_mes_2.bin");
 MODULE_FIRMWARE("amdgpu/gc_11_0_0_mes1.bin");
+MODULE_FIRMWARE("amdgpu/gc_11_0_1_mes.bin");
 MODULE_FIRMWARE("amdgpu/gc_11_0_1_mes_2.bin");
 MODULE_FIRMWARE("amdgpu/gc_11_0_1_mes1.bin");
+MODULE_FIRMWARE("amdgpu/gc_11_0_2_mes.bin");
 MODULE_FIRMWARE("amdgpu/gc_11_0_2_mes_2.bin");
 MODULE_FIRMWARE("amdgpu/gc_11_0_2_mes1.bin");
+MODULE_FIRMWARE("amdgpu/gc_11_0_3_mes.bin");
 MODULE_FIRMWARE("amdgpu/gc_11_0_3_mes_2.bin");
 MODULE_FIRMWARE("amdgpu/gc_11_0_3_mes1.bin");
+MODULE_FIRMWARE("amdgpu/gc_11_0_4_mes.bin");
 MODULE_FIRMWARE("amdgpu/gc_11_0_4_mes_2.bin");
 MODULE_FIRMWARE("amdgpu/gc_11_0_4_mes1.bin");
 
-- 
2.25.1

