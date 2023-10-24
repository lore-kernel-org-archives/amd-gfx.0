Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7382DC00A8F
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Oct 2023 11:09:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 00E8010E34A;
	Tue, 24 Oct 2023 11:09:28 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2083.outbound.protection.outlook.com [40.107.220.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3DAF210E349
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Oct 2023 11:09:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WTc8EcC6ZRPMxrQydZNqb3FR/XwoyhNPxWsADt/xfW29MYKCjmovd4QJYW9stC6cyCRidr42bF7l7uV+2XpAYHBCjqtTDr66YzpHUozGIhEiJR3FKPi8sWuyJ/dY9tK0VTWBibPGvj9m2a0+NeEdStvGruiZze/cX2B8GqCPtD0dDRcMW7PGLvwmzIUt8/4VfksPxt422qMhGPtN/TSMsPZmJLcmfO7JXpfE19rcqd2SUo5zCJhmHIg6eq1SbFtJUTCECmzwUneih+LNebiJ47Qs5t4h4FrViD4ciGRWwkYKztIbruI8kUw1byvHI3Z83kraJs9T6hz0QEw6BDU2LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kel40MkuPbPFZO6q5sTmxUmijOLJQRAy2WpNTR+h8rU=;
 b=TMUKu7ORAu6pSpbtUvjPb1NGvtqqik3/sxmtwpeXEz0IlhT81IBiL/pvQh75xyzCcV2Qwr9ykF1UieEgkZJUwU2/F+WnOIKxkN8UvCrt3k+ddFkCrsoKlAP2rVilmXG51CuKxJlrkF+4kVCjNk+tfEfC6BwaJww/jC9Qn2AQr5y0lGR5huFe0w9ZFzptv4KZTZGW33UWyooYXWOJCvMO4bg1yQreP8sXBzU12iqYHvysvUrnnkH6xta9KNInoiK4X9jGFvWXxhishuV56Ic9n00lrhbgXllAegmgs1N+74bZXDTB+jWVmkpZz4RhWmeWKq6vtf359Qe3+tUzV0hAlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kel40MkuPbPFZO6q5sTmxUmijOLJQRAy2WpNTR+h8rU=;
 b=jltuQApQnD795WnKroRquNgX42dRFeQJMEY+l6AcuMhAxzeSNqjKJGaTT/VfYTsfuYBGcYV36Ce5p27f9UzcbYBYOJajwe4DaFg4wq0miI1/r3FTd16YcT/d0OECj6RahWbaN0EOI0/j5l4QS3M6d51zhzJVw3mmz3Oa3tjDwRc=
Received: from CH0P223CA0004.NAMP223.PROD.OUTLOOK.COM (2603:10b6:610:116::14)
 by PH7PR12MB6737.namprd12.prod.outlook.com (2603:10b6:510:1a8::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26; Tue, 24 Oct
 2023 11:09:24 +0000
Received: from DS2PEPF00003442.namprd04.prod.outlook.com
 (2603:10b6:610:116:cafe::fb) by CH0P223CA0004.outlook.office365.com
 (2603:10b6:610:116::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33 via Frontend
 Transport; Tue, 24 Oct 2023 11:09:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003442.mail.protection.outlook.com (10.167.17.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6933.18 via Frontend Transport; Tue, 24 Oct 2023 11:09:23 +0000
Received: from jenkins-mali-1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 24 Oct
 2023 06:09:21 -0500
From: Li Ma <li.ma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/amdgpu: fix the GPU power print error in pm info
Date: Tue, 24 Oct 2023 19:09:04 +0800
Message-ID: <20231024110904.281991-1-li.ma@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003442:EE_|PH7PR12MB6737:EE_
X-MS-Office365-Filtering-Correlation-Id: 980705b6-56da-415e-b7f6-08dbd481adc6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tdMJa4fmFTe8zkMWlSWWPQdd+6L4Pf5vkBKt5YMOqAS3tW4DUx+sRVFuWR6aCqu6xVgZ+ESeVtX8YvPvfeV/mC4RT+Ywd7lRgzw0GvSAIXtmYwdJqW5V8cdu0CF7Iqaydh/Z66+FiJIwBh+7bxR0lzF0VnC7bREtilOC0HaVlF4mQiO0nL71Ev0srNniAbjxxO1+EY1dpBoDcktYVzbfarPNWNE5I2r+5QRGsWYGQQ2z/UAtg46Ys7WSGIgK57vPUfUgyVgC9ZwUWfQhAH541wbcWPNZCaKd5gsihrnKPv+kQN6c64j9vwnvKCeRCwQHLnSl2M0/k6iAlp5Co2BdCHz+CJDqKXpkgjJhjg+A4QMQYFhE7gHw2wp7j/saZ2FCEgF68lIgglSqhZqC4gTw7X2KMsRCMJR4vZgIDc24yqDSRT2wZgWUYtDM/yk6lwv/jL8qKY6C7SHpa3rjc/vFyo6kZA4pktcZpz9iCwz/oCeWJc9AiCnVg/XrsDWAp8pAIxr0TIpCMcxL2XQ8WyoixNz7MkGr+cuD6pan8uGVfIMG+9ZrgQ777io5YVeTDAA6rNi9y2PAuA/47R655vt4Hgpb2KR8I337gqvJeLZ1o26ErvQ7HsgEn5ib7VIwJTr4Fi3zeL6qX5oKqhxMBizETotbYzMa+hXYavrHabaGzAW6uANXl5xXCh4R1/Z/1iAhkJklP5PIeli8Q09tyhLqkGKQ1qvaIRLC1eGshgbdTZUdGbXlP3bO0WutlnFDlmc1NwnVyYXQZKlBV0zQGTt2/w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(39860400002)(396003)(376002)(136003)(230922051799003)(82310400011)(186009)(1800799009)(64100799003)(451199024)(46966006)(36840700001)(40470700004)(16526019)(40480700001)(36756003)(86362001)(40460700003)(1076003)(54906003)(70586007)(70206006)(316002)(26005)(81166007)(426003)(356005)(82740400003)(6666004)(2616005)(83380400001)(336012)(7696005)(2906002)(478600001)(47076005)(6916009)(36860700001)(44832011)(8936002)(8676002)(41300700001)(4326008)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2023 11:09:23.3627 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 980705b6-56da-415e-b7f6-08dbd481adc6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003442.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6737
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
Cc: alexander.deucher@amd.com, yifan1.zhang@amd.com, tom.stdenis@amd.com,
 kenneth.feng@amd.com, Li Ma <li.ma@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Print the digit of the fractional part individually to avoid carrying
during display.

Signed-off-by: Li Ma <li.ma@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index 358bb5e485f2..cc853559cf0f 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -4290,10 +4290,10 @@ static int amdgpu_debugfs_pm_info_pp(struct seq_file *m, struct amdgpu_device *a
 		seq_printf(m, "\t%u mV (VDDNB)\n", value);
 	size = sizeof(uint32_t);
 	if (!amdgpu_dpm_read_sensor(adev, AMDGPU_PP_SENSOR_GPU_AVG_POWER, (void *)&query, &size))
-		seq_printf(m, "\t%u.%u W (average GPU)\n", query >> 8, query & 0xff);
+		seq_printf(m, "\t%u.%u%u W (average GPU)\n", query >> 8, (query & 0xff) / 10, (query & 0xff) % 10);
 	size = sizeof(uint32_t);
 	if (!amdgpu_dpm_read_sensor(adev, AMDGPU_PP_SENSOR_GPU_INPUT_POWER, (void *)&query, &size))
-		seq_printf(m, "\t%u.%u W (current GPU)\n", query >> 8, query & 0xff);
+		seq_printf(m, "\t%u.%u%u W (current GPU)\n", query >> 8, (query & 0xff) / 10, (query & 0xff) % 10);
 	size = sizeof(value);
 	seq_printf(m, "\n");
 
-- 
2.25.1

