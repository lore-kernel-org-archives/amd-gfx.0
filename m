Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 092C1C4452B
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Jul 2026 04:00:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 904FB10E51F;
	Thu, 23 Jul 2026 04:00:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="RofMY5NL";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010050.outbound.protection.outlook.com
 [52.101.193.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EA5ED10E51F
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Jul 2026 04:00:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=epnhJjJwii56g4O60cBAvJkCckz5HWjXE6M2v99VRM33+8B9F8UDfEvp930UCbTIAAjqQzUvqwOSM2Ldx9GxjlsXusPJ4UY2fmkbYe13V2qCarnhVN/e6n8ECXanNv0q1ibZZej8Izz4e4SJb+JD4z9cAdCPbzAVwRrZ+lgYI5CKEtgcPor38VfjN7Z/QjXmgI2CWiYsOFEATz4SgMDVtOTHyaq3NbNB4PxBLYjYX+znci1zHjPHmIx0vtKxZRkL8RNzLJyaYXG7Cd4iO4NmxBqwl4HtGNzItn+QXfzXy7ykwOnclkTB+hKPEODePiVNvDWcWpefQ4h1bfHGqtuGuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2mWZ5JRFiGVZDm5yz2axAsMF25GhWj6oBX0diPdMGTY=;
 b=JMKUHTOniUJNiO8+UAAKwBuF+y4op5DdBTT9Fbo7EQe0W25TBdUoz4k8xwe//SmDBIv+k+00pZXFzrCgZ6QYcunlBq6hjB1wCRdI4/vYZwXUWiZg11rfKhPE/Am0GB0i++7R4uBctB2gW8etQnqgl9vsNZ+T+q4nRmylD6Mpl2Ljr1XE2O0vYLyMUXsg5fr6IQndbJ0Ea6lV6OXBb4fozI0qtaw8SvanSpjY9eAAyUP/oaz7ct6cBz+2RDWkhrN341NouhR5vxZB6STDXwCWxQBBaLsBiUPOU63tHfW6mJA6SYTPSpe1IIsAk0XaONlTUsEZmGe1ipKbDkDB/289Ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2mWZ5JRFiGVZDm5yz2axAsMF25GhWj6oBX0diPdMGTY=;
 b=RofMY5NLh+U1EVK3082H/oOZA6O/7hJQQkzhwMgHyEDOADVwY+33mAIrSnXbWaB+RD6+jOcwQjoV77ypQfL3TOEgxNfhwEUN0yMwYH2KrAhe+NoNVMxuzfmHw/Xuors70pEc1DhdDgZYuFw6Gv/fmU5tXqmgxC7gOD8BGRZI8Lk=
Received: from SJ0PR13CA0141.namprd13.prod.outlook.com (2603:10b6:a03:2c6::26)
 by PH7PR12MB5879.namprd12.prod.outlook.com (2603:10b6:510:1d7::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Thu, 23 Jul
 2026 04:00:15 +0000
Received: from CO1PEPF00012E83.namprd03.prod.outlook.com
 (2603:10b6:a03:2c6:cafe::3a) by SJ0PR13CA0141.outlook.office365.com
 (2603:10b6:a03:2c6::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.10 via Frontend Transport; Thu,
 23 Jul 2026 04:00:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF00012E83.mail.protection.outlook.com (10.167.249.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.5 via Frontend Transport; Thu, 23 Jul 2026 04:00:15 +0000
Received: from ram-Splinter.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 22 Jul
 2026 23:00:09 -0500
From: Kanala Ramalingeswara Reddy <Kanala.RamalingeswaraReddy@amd.com>
To: <Alexander.Deucher@amd.com>, <Mario.Limonciello@amd.com>,
 <amd-gfx@lists.freedesktop.org>, <Pratik.Vishwakarma@amd.com>
CC: <Kanala.RamalingeswaraReddy@amd.com>, <Veerabadhran.Gopalakrishnan@amd.com>
Subject: [PATCH] drm/amdgpu: enable mode2 reset for SMU IP v15.0.5
Date: Thu, 23 Jul 2026 09:29:51 +0530
Message-ID: <20260723035951.3793144-1-Kanala.RamalingeswaraReddy@amd.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E83:EE_|PH7PR12MB5879:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c9bc9ab-9bb0-4c50-e73c-08dee86ee71a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|376014|82310400026|1800799024|11063799006|10067099003|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: Jy4S8R8c5++vC8AEgL69YXcOiJJw04cd5f07lsaoVFkcGg9OJcWHRC8N1ZDaTAXj5dJen25B26ktmOIfE/Lm64MEvc5Q3ky6azNfTS0Zj3FbqJmdWE2eaLuJ1Cdi0aN6AbXUtrVCal6Tq6DkD0PIDZ6d2S0L3nQ44t7kKEWDdpocjNijukSKw91CtR5oXgHrdnMUamb/wI7czcwR69v27sl0S81JsHpbH/zfWB0Ix/wrXmyIzvdZTuWDbkkuwuQKhLPCT+5vnMDgMdSdtgujtPwTMubOP/j8PlgrU3gvcq9O167E2AzFd7k4Gmk4doUn3etnLTG/Sj7/SINsvhV4DnM/qlavkm/3Hc19wnGe1ahRRmP++T8uzusNaqVnXAgaVY4YgaYxhyV36fE/7LHTla4WUd1h3rtH1+fBKpc3noh7Cp8iP14hZaynJ1OvQQeO2BSmXFnieiwzpF5xj8Cbz9bMm4RwKOIc6PAaOiiqYMqPvaTYpI5cNX94m4DDoiOWtXNEnXnuP3bIQXCWeiSRowPalGscK2bgNZXRzzj9NB+OAYTfoU5GVvrPYx6Xog5kEmXbQs8zXHX4C9cp6CgNRpGGp5Ub6Z4Mb2C0Yui/zcsyumTdtfo36P2NLJhYGhRBBmJBM0Mqmv8iCmyJGsDWF1+GkOxEm9xMHVijmkB7E2wwF+wSfrY6LMULzIbRZvxsGZao1LKZ/Is7MkA7LsumUQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(376014)(82310400026)(1800799024)(11063799006)(10067099003)(56012099006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: oyFIJPYU2RiWnC8bjFT9BeLLKAUtg0n9dGcIIGKpLfo4T9NtguUDxO6kysX804XkW0kj38I64FuUTzqlRh9LgnQpSd+VYQEwq98LLbgoHYLDX5F0zlNExdotXXH/sjtVT4XT3TeOyHqpsVbUtUWBL3NDRvq0b4V5AnQQu1NMYtb8D6+8TPK0S0g8vZOt7h0IaIG0YhjHRuEZEUoMvnh0nlYAlkbZABEfZCc39xK+bTqGraW9bItQAvFMKtkril6B7+BOcQCzUwyFgR3PlCz6QHhZ1Y+6znHlD47MqVyGTjQK6NX2Tg/V5L1LweQivdNuA5xaMaoTkhzESvoqFa5Zr/1MOAo4g/VJSElPHpyIssjLLgwqcIf+fa1bN2PoZdlAQZ38iCc4Hu2EaQmeiO7xFyHwknavbyXXNsK72ok8T8qC0UF43x5A/iqVDUV+kUN4
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 04:00:15.3195 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c9bc9ab-9bb0-4c50-e73c-08dee86ee71a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF00012E83.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5879
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

Set the default reset method to mode2 for SMU 15.0.5.

Signed-off-by: Kanala Ramalingeswara Reddy <Kanala.RamalingeswaraReddy@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/soc21.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/amdgpu/soc21.c
index 713746a75d1f..1f9a9c46377a 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc21.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
@@ -407,6 +407,7 @@ soc21_asic_reset_method(struct amdgpu_device *adev)
 	case IP_VERSION(14, 0, 4):
 	case IP_VERSION(14, 0, 5):
 	case IP_VERSION(15, 0, 0):
+	case IP_VERSION(15, 0, 5):
 	case IP_VERSION(15, 0, 9):
 		return AMD_RESET_METHOD_MODE2;
 	default:
-- 
2.53.0

