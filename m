Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD90AC4332F
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Nov 2022 09:30:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 44A1010E719;
	Fri,  4 Nov 2022 09:30:46 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2080.outbound.protection.outlook.com [40.107.244.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6082810E719
 for <amd-gfx@lists.freedesktop.org>; Fri,  4 Nov 2022 09:30:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BBbrubGDBY2dUcXN+8Jrkd4vqg3QzEM0ybgMSVbieRlGwEkNXstByTvNErcrFVU4wU1b3eUzPNCI96ctDAYcxJY6HzmneJ+h9Eu1ANdGpMfNnM2QCjIWFiTM/PqNAMh7MmH+g7tR6mDBo9yBc45Tk7ox29mmgzwr6qpXohsu5L65dETIRZhvp55TS/BX6c0AP4S0knWG1ibP708TxxL8+h4WorxeAt0nyqPVFhL66lE0QNRdc1JI00zxgIwaCi+71WPhei+CXmZ+sRPOLV7vtfdqjjeHo0mIeULPNdJg8bVGL9K6VjY2pwSOXTk6FYBDiLQSSGV/X+fSVCP80PBK5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HbESVXjVMb17SoIIeIvhyNO+nN/aATTNvn+SfW+MlJQ=;
 b=NJfM1SBkNi9yTa/QUkwsBy+Eg1eNp85c2FSvQUcuu5aBZB8cLDnGy4PeP2EExilqliBJE6LMmkALRrf8LB3AOhahqaX4+9ouEn8xUqj+92IV+tC/bbXpxRb1Xogp1PSsQwChUsG0k3RXl/3FdGWApPbV4wrdbTCXU04Z7rmbvNCPy0KhXRS4P/OThAg3bJ5Wcb+gM7ufGP658Kn49EoQRfd3zlGbhG38YtepukjuIzbpBDXjpkWProyBSC5h4nfi4KDCt4NmQ8VcJfQm48bqPRp+LfFjctqgvdgwAewaHIZetXrPwi5rIdFxQv4aSQ4zrn8EnMfr+0/fjsUQ4861rA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HbESVXjVMb17SoIIeIvhyNO+nN/aATTNvn+SfW+MlJQ=;
 b=fz+2KCU7zILgfVHqZq1DaExtaZnXKlU1coeV63QiXi7CB8mNt7rui9j96RqKcF0s6NqRynzmS3T86lxdSudceHYEZni/UmimZrGCtlIXNesTUd3kHgMlBHdbMd4nj5ZHhmu0KVR0+nQciwNQwxuqzkV7EnLCGrrPvVXeOJctSag=
Received: from DS7PR03CA0019.namprd03.prod.outlook.com (2603:10b6:5:3b8::24)
 by BL1PR12MB5350.namprd12.prod.outlook.com (2603:10b6:208:31d::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.22; Fri, 4 Nov
 2022 09:30:40 +0000
Received: from DM6NAM11FT042.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b8:cafe::84) by DS7PR03CA0019.outlook.office365.com
 (2603:10b6:5:3b8::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.23 via Frontend
 Transport; Fri, 4 Nov 2022 09:30:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT042.mail.protection.outlook.com (10.13.173.165) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5791.20 via Frontend Transport; Fri, 4 Nov 2022 09:30:39 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Fri, 4 Nov
 2022 04:30:37 -0500
From: Asher Song <Asher.Song@amd.com>
To: <stalkerg@gmail.com>, <Guchun.Chen@amd.com>, <alexander.deucher@amd.com>, 
 <evan.quan@amd.com>, <ernstp@gmail.com>, <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] Revert "drm/amdgpu: Revert "drm/amdgpu: getting fan speed pwm
 for vega10 properly""
Date: Fri, 4 Nov 2022 17:30:22 +0800
Message-ID: <20221104093022.446357-1-Asher.Song@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT042:EE_|BL1PR12MB5350:EE_
X-MS-Office365-Filtering-Correlation-Id: 57cd3bbc-3e51-425f-c4ed-08dabe473cd1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WaDN362xobFLGLB1fXPbM4QhXCojH6qN2/6b8y0ikOmPJmi+v73W0XOp+X3wEIS7ImXTWwsmjO17y2+sK3m634d37nWmvtT+ekL87N03+yo8lG1BIjgZarcUr5El0Y19Y0Kuatogwf/LVpG/H8hs2QRJ+6BroIv777iTUALfDkB5KhCOfCLIspxhcGnkBrMYjz6yoyr3d5POZXCokK0wciAueXG5O8Gb3YEL+LF2v1wYz3qgYPOfrIbLk06CDmZn1lZkrzsRjVt3e6pRwE0xgKhIje8b1Svwt3L6hlbBEu01YOMlc0vUPCloO1Z3Dhk17iIoTr0LBSOkA1TrY0rWdLVYUgab2IfS1alvUl4kUFG42TSMRbQ6yHuOREcJtN9or/HLyaamsdmDx7Do3pTSRYO4+FiVuPmxfhRAXlNkDupx7D5Z5Gj/xwIHOH4efHVfYkVuVzBDThDIJZpBPOdmq2r2icUCqdl4Hy0Zs/tCarzoy7CSejixq4KgMDlDiiLHBsSwwNuzNbnS8qX+454jBNj6xcc8qnhhMwcSAiuisRxLmfE8OQaTIP3E8aimshT1/vK+XNqUQoDDtvqhyhFu0kjAqWKcYyT2fy/KWgfath7pLT1+87jzKR2y36z7h4R4il2Yqr8WbyOPovMRhe8ptS9sY0mU+cQpXNr5OKEY0oDBwP1g562Dsy9mt08sb8Aqrpp2LIzQB57L+RKtE+RCfvD4ydU2iTquxSSHx/wKpyXHvf9aBdexqp0gW5/cteB1jPe6yDebFV7qn47S/soLnt1C/wRK1SGtYZwNYTIPRmY0yppYCTw0p8wky322QQw/L96mGIBNmHvyTmuEzu3rGg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(376002)(396003)(346002)(39860400002)(451199015)(40470700004)(46966006)(36840700001)(336012)(186003)(1076003)(47076005)(2616005)(5660300002)(16526019)(478600001)(40460700003)(316002)(70206006)(70586007)(86362001)(110136005)(6666004)(8676002)(426003)(36756003)(4326008)(40480700001)(26005)(8936002)(2906002)(82310400005)(41300700001)(356005)(36860700001)(82740400003)(83380400001)(81166007)(36900700001)(2101003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2022 09:30:39.7901 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 57cd3bbc-3e51-425f-c4ed-08dabe473cd1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT042.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5350
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
Cc: Asher Song <Asher.Song@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This reverts commit 97370f1826eb7ee6880e09ee1eaafe28232cabc6.

The origin patch "drm/amdgpu: getting fan speed pwm for vega10 properly" works fine. Test failure is caused by test case self.

Signed-off-by: Asher Song <Asher.Song@amd.com>
---
 .../amd/pm/powerplay/hwmgr/vega10_thermal.c   | 25 +++++++++----------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_thermal.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_thermal.c
index dad3e3741a4e..190af79f3236 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_thermal.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_thermal.c
@@ -67,22 +67,21 @@ int vega10_fan_ctrl_get_fan_speed_info(struct pp_hwmgr *hwmgr,
 int vega10_fan_ctrl_get_fan_speed_pwm(struct pp_hwmgr *hwmgr,
 		uint32_t *speed)
 {
-	uint32_t current_rpm;
-	uint32_t percent = 0;
-
-	if (hwmgr->thermal_controller.fanInfo.bNoFan)
-		return 0;
+	struct amdgpu_device *adev = hwmgr->adev;
+	uint32_t duty100, duty;
+	uint64_t tmp64;
 
-	if (vega10_get_current_rpm(hwmgr, &current_rpm))
-		return -1;
+	duty100 = REG_GET_FIELD(RREG32_SOC15(THM, 0, mmCG_FDO_CTRL1),
+				CG_FDO_CTRL1, FMAX_DUTY100);
+	duty = REG_GET_FIELD(RREG32_SOC15(THM, 0, mmCG_THERMAL_STATUS),
+				CG_THERMAL_STATUS, FDO_PWM_DUTY);
 
-	if (hwmgr->thermal_controller.
-			advanceFanControlParameters.usMaxFanRPM != 0)
-		percent = current_rpm * 255 /
-			hwmgr->thermal_controller.
-			advanceFanControlParameters.usMaxFanRPM;
+	if (!duty100)
+		return -EINVAL;
 
-	*speed = MIN(percent, 255);
+	tmp64 = (uint64_t)duty * 255;
+	do_div(tmp64, duty100);
+	*speed = MIN((uint32_t)tmp64, 255);
 
 	return 0;
 }
-- 
2.25.1

