Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B797CC7619A
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Mar 2023 19:46:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1E59C10EFD4;
	Thu, 30 Mar 2023 19:46:05 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on20612.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e89::612])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3128510EFD4
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Mar 2023 19:46:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S2nxLJg39npTFgQCS/VEHcRqi81KUvNVwDY9vFS8clz34p4R0Om3OFeQ69PjW+7pIMt/BxhOQiyw3UUhzVGaesUBhr1X552jvn2mRAYoaQJU2sbfL9qZTSn/3D9QQ30q0li7qXcxVmOdwSI5sp4sCazXK/PijLcB5QSfwd1l1V2mmr37VCNa+2h034fmcO/VFlPanqhZMaDy7vDuxYutBC77GzQrAPy76ZZ7SftiLIyoTrjANSvYvqnLdlTj2rxuSqnCm1B8p7vjiJogWAbkFGpX2NZt/ite0+YkfDhFYR0RNjSuOf+ADmN+AIGKlrigBDPtqN9gy19Pb5xatOtoGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hHaEfLYbFCsbOQmxEwYbaNATuIxA72AOXP3o3I2Yvow=;
 b=gOnOU9G4znI/FZ+fW8mjLpv+BqzkPkXwVmsz20UKeyGWgJxcU3XfVuZTAn8D6PLkUkkrTQ5DInDooTIDiOWfvRahhxVaxCyvrr3uxwNLTEMwKTMqnDOf3qpFxZbr1y4AY8aHJpFMwPMJyg2lQyDMRTZuzJGXvVamcxC6zR4+mFFmsdDZlk7LlfdCv08L67DznOel1oK+tn9wRW/PYVycMYwJmapnC/jlPIjchBE0SsuSBULqcyZYSpvsJM9DgsIPMZ/CQqz7s5mT7uvHQZ23zpGdY/IEHBEnwKCxqlKS11naR5LVY+xdK0JW83rksekVLMPXR7jX/breCdJ/4ow/2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hHaEfLYbFCsbOQmxEwYbaNATuIxA72AOXP3o3I2Yvow=;
 b=r4jflc0zGlNEXHuHLH/vWGR665BhoCl6jQuKyfbebdE1UoUHEuXVlHGLtQ/cxYhEdus7CBx2wEW53igCQ4DucMKoNZa1Kt8Of4xMNQ/Kl3WcqeCgtezTKPHdt3/qUfxd1ly8Ke5c+JJlrlmRAJJvaE6E3Pzxqi458mg85GSmWeU=
Received: from DM6PR13CA0016.namprd13.prod.outlook.com (2603:10b6:5:bc::29) by
 CH0PR12MB8580.namprd12.prod.outlook.com (2603:10b6:610:192::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6222.37; Thu, 30 Mar 2023 19:46:00 +0000
Received: from DS1PEPF0000E636.namprd02.prod.outlook.com
 (2603:10b6:5:bc:cafe::b6) by DM6PR13CA0016.outlook.office365.com
 (2603:10b6:5:bc::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.20 via Frontend
 Transport; Thu, 30 Mar 2023 19:46:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0000E636.mail.protection.outlook.com (10.167.17.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.30 via Frontend Transport; Thu, 30 Mar 2023 19:46:00 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 30 Mar
 2023 14:45:59 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/8] drm/amdgpu: add fwlog support on vcn_v4_0_3
Date: Thu, 30 Mar 2023 15:45:40 -0400
Message-ID: <20230330194547.1135862-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000E636:EE_|CH0PR12MB8580:EE_
X-MS-Office365-Filtering-Correlation-Id: b25a56cc-f030-4c49-14a5-08db31576380
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mPx1uItjw4F5sycWZM/piRhDY63C1/v1WEFLevJY0SE2+3/tR5hApCIr8JScx4tg65zYFnMulgU383W02g6HbEX/HwYJ40qQP7YiC1KZ9Gkf3ukPj/Stil45O72uO8nddnZRsl3a9hVDuiqCeIX20HEgC5Embsn+Sv+cph+hbbJUqxIStQpl0qHwtpyDVyI4mJrqeXCZPU2a3nzgLi9jTwSt1bYIjoOJJot/tr7L8zV9KLG6/QooTH8ywWkFEutr+OLoMuiGcwmle79MlkRiHTJ7V7gPDQovIpB2HHVaWSLlDNY0HYI6vLxJfYX1tLG0cikht7tk7Lz7T7rejkiLADwOMe0Vz2TixhPvDPyy1mNmypocNT20r6kE4JUOuUUECgz3liy1rsYgzHNs/O8vtubjOCHtJv9sa66AMRP39lE+T6XydAVu34TMl2PfdIZDBUI3zeeJPavfjbZC6zC6c/VdRJejUCkn2fKeJnxAGWc0tU5ibTQ6OVbA1isyzPJCwgzuTQ7pe7h/TrYwQZDF03thY9J3kUypaFPa5zjQIa/UofZhIjLTshgqzqxYLnBLy2A2GGg2YHvbAqqMdFWKR6p4kF9R2LZ/r3TtctXoRosWDt/B39dfmuqxy4rynHGS1zwn7vafOYa508qkAtsDdaSjZCf6LogXGL4/ZUOIReV12Z1bisVeb03bUwjimGwPCPVl1A/U8Do2NUFk5nmaYdRTyaNhA4vaqYdGNlk6tNo=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(39860400002)(346002)(396003)(136003)(451199021)(40470700004)(46966006)(36840700001)(336012)(47076005)(2616005)(426003)(36860700001)(54906003)(478600001)(7696005)(16526019)(186003)(316002)(6666004)(1076003)(26005)(2906002)(4744005)(82310400005)(82740400003)(8936002)(40460700003)(36756003)(4326008)(81166007)(70586007)(356005)(5660300002)(40480700001)(86362001)(8676002)(41300700001)(6916009)(70206006)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2023 19:46:00.3529 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b25a56cc-f030-4c49-14a5-08db31576380
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000E636.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8580
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
Cc: Alex Deucher <alexander.deucher@amd.com>, James Zhu <James.Zhu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: James Zhu <James.Zhu@amd.com>

Add fwlog support on vcn_v4_0_3.

Signed-off-by: James Zhu <James.Zhu@amd.com>
Acked-by Leo Liu <leo.liu@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
index 8db50a50b868..40de2852c5ca 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
@@ -118,6 +118,9 @@ static int vcn_v4_0_3_sw_init(void *handle)
 		fw_shared = adev->vcn.inst[i].fw_shared.cpu_addr;
 		fw_shared->present_flag_0 = 0;
 		fw_shared->sq.is_enabled = cpu_to_le32(true);
+
+		if (amdgpu_vcnfw_log)
+			amdgpu_vcn_fwlog_init(&adev->vcn.inst[i]);
 	}
 
 	if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG)
-- 
2.39.2

