Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 655F3C43217
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Nov 2022 14:46:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B074010E3DF;
	Tue,  1 Nov 2022 14:46:45 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2073.outbound.protection.outlook.com [40.107.96.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9148410E3DA
 for <amd-gfx@lists.freedesktop.org>; Tue,  1 Nov 2022 14:46:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WqUx9LeRFCovWOtrVQhQnu6Td7/w25G6ld3b+1efi4uMsHmQ63yRohEj7daAYgl1qQ22kOx9gcTyhVUHhKDt/oP5WRglfQLu0cAaX8MTto6R2fhOrRKhT5UwoOL4fQiadE84FoPiWPe422E8opqPiG+toXjh9S6AKmpVGE4p3canvYMsk6DtntomX/ZnwaqTxuXi35gpogUoa15mSp4H5ZxG9vl9SwdbxWu03HbH7eWNzvr07Edr4faNw5i13nsfi4G4MWWBzrlkm9Ob3tuDgUcTpDwVdu56gi3hx61ZQ4IjupOjKbqYKueUnXz+TmLbhgASyAGMykOjYMdp+Eujzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bNT9BLHn/ZYaxOnNjckjGuhSV6A4R9aVU9MYOPRGseY=;
 b=azFzCDc34MiPI2Bmmkzh0yvpw9k1Xnh06xVG8Hvhs6pKCJMV3ESgyIVJofFkY3rj0VON1EzaCNMVSDOlk21TAxXNBh7Kg0MPYvRTJq18jAkdUxf3xCxZtOSFvmku3bY5SG62j/TRpghJ0ZM4JFo6hE5Bh5bWr+u6FM9gx8Y81P9dJ52USamUPRLPSqb6PnjYroqK8U6xWhnQCOzGqH2UosVjYuaqDQW22mVr9zeQGx/SAn9h7fVGJb+UFdrvazOnfzxe/Oq2LnRsTNVAPCGmZgIYBZydSW9Ri38x7h8pGKfWWfxotqqRMNOKZunqiu0/uj+0wE4TgZbzYoILKjHibA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bNT9BLHn/ZYaxOnNjckjGuhSV6A4R9aVU9MYOPRGseY=;
 b=hY8jD0EDDBzBMOgU9DN/Ufc21NVqJPJtXZHQI7l6s/mVdCvYEvG4xNMm3IdKjoGGWLJ8o41eH0gx3GwqcTIbRnjehpZeuQbSuYb4IniPO3eOPJB0I0sYXHhqHYtMo8COkol88PIyWmdX7R0a2Kp4njHepDpnNv9OuAw4Tl+9oHA=
Received: from MW4PR04CA0145.namprd04.prod.outlook.com (2603:10b6:303:84::30)
 by BL1PR12MB5270.namprd12.prod.outlook.com (2603:10b6:208:31e::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.21; Tue, 1 Nov
 2022 14:46:38 +0000
Received: from CO1NAM11FT087.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:84:cafe::a1) by MW4PR04CA0145.outlook.office365.com
 (2603:10b6:303:84::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.16 via Frontend
 Transport; Tue, 1 Nov 2022 14:46:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT087.mail.protection.outlook.com (10.13.174.68) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5769.14 via Frontend Transport; Tue, 1 Nov 2022 14:46:37 +0000
Received: from mkgs-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 1 Nov
 2022 09:46:35 -0500
From: Graham Sider <Graham.Sider@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2] drm/amdgpu: extend halt_if_hws_hang to MES
Date: Tue, 1 Nov 2022 10:46:21 -0400
Message-ID: <20221101144621.375662-1-Graham.Sider@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT087:EE_|BL1PR12MB5270:EE_
X-MS-Office365-Filtering-Correlation-Id: 249f0c54-24c5-45ce-0779-08dabc17e17f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XaQj6oPyOZ3H9MFGqMb2uCcjDZVL9S4UIfH2s+/JneNPYQA7zaTi/F0zWV2Rpvz5cT8CE6wcJi/9SCv/ByJLtBHmsQ/YV8PoSbQgwNYT/JJarnQaNyKx5SwWBtoZbA6BS9bORXXSJiVku6WXVQmhjq3xbg+lKvWl9UDdjb6jfrTeof+IMZdtwjQPCfTf9KHxOFpP7XUlKExWCt/PZ2SAD5BRFCHFs0ih7kwG+K+mwe4moImsSgCwxEnzMojWlM7oWVBwOqRzLXzoyNlRVl3l8YaI2xBaI3umi4Fdp9T5r+42gq3Ze405lPj/7mhVd4usSzJbQMtuXCZQPL+9qd9ebtAFeCJl0UHWe9v5ZGFbQML9F1a1BVjCCtoAphiTzR7yx4AP+qrquh2GC6CbhYy1EdS2u8iFZP9fBsMDEegdokBUCP3HfbWIOnRqZRBLYhF6q43HhN9J4oHEkYbQp0t2jv+bHs5pAv+JsOzYKCKTOVjVewSuSmLh9pUTvJdB3Cf7rJjzZG+L05hN1ygyFj5DN9jyEOFbhJYWi3h/9GU+FI9nv6I2aMN9ySj0wR0t1c1NnTYXG3XbbLwsmjAr9npDpF7lNIi1gX05QVnsbSw7gJ9+FXtgxE7KIJH6X/orrga/Q8vXOZL2cfEtW2f7V+SH3fe3isJELGdACDTa8VilLat3AGVSTuhOTSkxAdluYYJppNi7WeW3ujrwHgWBUyP5BJDWOpdoklSGY8IIP1Q5Ht6dHca04DK9KObRAh0FSErwoKd9HEOEGvURrRK3xdkNh45MN+9gvv0FC1AdITpOxKSFjS/QzqiHyZjyazVD11tV
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(346002)(136003)(376002)(39860400002)(451199015)(46966006)(36840700001)(40470700004)(2616005)(186003)(8936002)(16526019)(5660300002)(47076005)(336012)(82740400003)(2906002)(1076003)(426003)(26005)(40480700001)(41300700001)(40460700003)(81166007)(82310400005)(356005)(36756003)(83380400001)(36860700001)(86362001)(54906003)(6916009)(316002)(7696005)(4326008)(8676002)(6666004)(478600001)(70586007)(70206006)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2022 14:46:37.8408 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 249f0c54-24c5-45ce-0779-08dabc17e17f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT087.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5270
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
Cc: Felix.Kuehling@amd.com, Graham Sider <Graham.Sider@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hang on MES timeout if halt_if_hws_hang is set to 1.

Signed-off-by: Graham Sider <Graham.Sider@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h    | 2 ++
 drivers/gpu/drm/amd/amdgpu/mes_v10_1.c | 4 ++++
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c | 4 ++++
 3 files changed, 10 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 0e6ddf05c23c..9999c18e7d8e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -219,10 +219,12 @@ extern int amdgpu_use_xgmi_p2p;
 extern int sched_policy;
 extern bool debug_evictions;
 extern bool no_system_mem_limit;
+extern int halt_if_hws_hang;
 #else
 static const int __maybe_unused sched_policy = KFD_SCHED_POLICY_HWS;
 static const bool __maybe_unused debug_evictions; /* = false */
 static const bool __maybe_unused no_system_mem_limit;
+static const int __maybe_unused halt_if_hws_hang;
 #endif
 #ifdef CONFIG_HSA_AMD_P2P
 extern bool pcie_p2p;
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c b/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c
index 1abdf8b7ab50..614394118a53 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c
@@ -121,6 +121,10 @@ static int mes_v10_1_submit_pkt_and_poll_completion(struct amdgpu_mes *mes,
 	if (r < 1) {
 		DRM_ERROR("MES failed to response msg=%d\n",
 			  x_pkt->header.opcode);
+
+		while (halt_if_hws_hang)
+			schedule();
+
 		return -ETIMEDOUT;
 	}
 
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
index 27a330f51c7d..7bfe862aa83e 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -129,6 +129,10 @@ static int mes_v11_0_submit_pkt_and_poll_completion(struct amdgpu_mes *mes,
 	if (r < 1) {
 		DRM_ERROR("MES failed to response msg=%d\n",
 			  x_pkt->header.opcode);
+
+		while (halt_if_hws_hang)
+			schedule();
+
 		return -ETIMEDOUT;
 	}
 
-- 
2.25.1

