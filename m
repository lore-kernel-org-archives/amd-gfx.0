Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A30C3C4332F
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Nov 2022 17:23:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1749E10E314;
	Mon, 21 Nov 2022 17:23:26 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2076.outbound.protection.outlook.com [40.107.243.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BA5EC10E314
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Nov 2022 17:23:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=la/hs2lN1iK8F7Xor6YvxjOLFwxiecmAixI0l54ibw3Mn8ity+wC2ifMZaFGasPpz3zl0us9kLzOM1X4QuwCR+qUAGOr4axLMyWb/tdrVHTlIIYxtSJm0Ktd+DFnouFbvVmztpS7Lipu3DUgHN2r3SiMG1Xak3poxqnP75uaVfhlIvX/MzT+1q8t/CYRcpjkpQEWCzEqH7C20VytmhAhZ7DuLsg6vpwWFPDDg6U/M7fy/P/+vhbT2W6d6jmnKPpw1l9hOxnpS/uupptE0COX030Du52AYIg5ig+DIXPgPAEwJvm0NHx4p/fLd2TxBtbBGjfo8cxZ3rJ12sBgdyMCQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v/WAJrXwSWKy2mgDnbGL6bLjwHtoS9LRm1rsrRl2iJs=;
 b=EpahEkCnqrQG2xE1oCwsbknRdTmP/36y4yn9yRSnY324F8IZRgFkLmh8/D5mLOeZMBGkrFB1K3dyRM3TI46K2eUb856xNODecc3uQsl4EZxb4+AZkdeTXi8PfHpekPSL9wXtO0Xssqh+h72uIu/hR8LS6CLi4VIzWZgTX533xiB5ucdSDGYJlUerYZlTpxYnp9ta5/QySOBljxzB4anKCc+gLC4Em7Mbj/6eVHZYxatQ4sI/yXu8g420iitazFq6mKXJx3caQnXLtd0dwABZZK8EC6urjcCI/hhw4MXkVF0VepXQaKSphTyUsiQZ0cRF5TR71QQgPti2vbF7kBaD8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v/WAJrXwSWKy2mgDnbGL6bLjwHtoS9LRm1rsrRl2iJs=;
 b=T/bMjKrkg4WzO14UG6zMiDWuY+wOYMn5ixqy4ud28CMTaRzHCHI8beewy2CIMTWhEmEd8Fsgwu0PQt9Dl+fPhS3tAcmAlicKkW5LXFPXgfA5TpYMkdEWkwYummJmtJ/x1CtFf5uDS4oZKcYaltay/pOTBumBnvrDr29YiAwSSXo=
Received: from MW4PR04CA0161.namprd04.prod.outlook.com (2603:10b6:303:85::16)
 by PH7PR12MB8153.namprd12.prod.outlook.com (2603:10b6:510:2b0::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.20; Mon, 21 Nov
 2022 17:23:21 +0000
Received: from CO1NAM11FT096.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:85:cafe::81) by MW4PR04CA0161.outlook.office365.com
 (2603:10b6:303:85::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15 via Frontend
 Transport; Mon, 21 Nov 2022 17:23:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT096.mail.protection.outlook.com (10.13.175.84) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5834.8 via Frontend Transport; Mon, 21 Nov 2022 17:23:21 +0000
Received: from localhost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 21 Nov
 2022 11:23:20 -0600
From: Luben Tuikov <luben.tuikov@amd.com>
To: AMD Graphics <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Fix minmax warning
Date: Mon, 21 Nov 2022 12:22:42 -0500
Message-ID: <20221121172242.57717-1-luben.tuikov@amd.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
X-check-string-leak: v1.0
X-check-string-leak: v1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT096:EE_|PH7PR12MB8153:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e64e26c-3fcd-46c8-0041-08dacbe516d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UX/cYgIbxY9sgtlx46YuQKW3czlj6XrrfFUiuglgSr67BfWVqM++SK1y0kYcnrEFWlDYP1N2YdJgc/IsDOH9H1lO/9TcSlRlzDE1/QOApzVNyzfcVDB0LJDN/1C0oRKVaR8SyZlXYLuDlbyz+wUxAmzTd2V6SbrTfUJe1kI+1l7CNVdOxyNittSsfGKvpXqwOqvSBW4cp8SkMbiU9DvQdZ9heKDbwzgvaRIZ04ECkU9IG/YgsWUGK1RI9F5ypID0uXBmo/yavMJpKVh/oOd8IAAIP9CW7qG8UVQ5riA/AZL1NfOog03djeroiCBIPldJA1xnlpo0YlyEGSmSX33GnrlRN+c6HLMJCuScpBaZVWT2UajBX4J6AfRmUq1mCD6vZyW+RrV08hW7ngi2PoZTENi+qxhmcZtbbT1v+V9nanHuuYN+LBRbg3BX1qNeVFZtgSZDx/eJExZQPIoQC7r7wDBK/XVZKFtERrBtH97i3XeTLx/U02XdcVum6sIxMsW544GmiKJ7JbDB6q4+yjjWlA1Ex0BTMDBO5dmEtQhT7uspKbKl/CFT4O4CubMmVsTBXafG9LVdogbWeVJSjnY3LfniPLwKWDnVo9LGS1JPC7swMYl1x1NKAVkGVsO+eD87Lpr0rI/no+0dxvCVUkcsMuKSRi70M239YSlcAodneDLSRMNHBpjavaRN8LwESrWzZZfOstab6QlReVRxuu6TNKCPl8uFu3ergzZ9cU/jn1I=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(396003)(376002)(346002)(39860400002)(451199015)(36840700001)(40470700004)(46966006)(81166007)(356005)(70586007)(82740400003)(8936002)(2906002)(4326008)(40480700001)(86362001)(36860700001)(83380400001)(40460700003)(426003)(336012)(44832011)(41300700001)(2616005)(36756003)(316002)(8676002)(186003)(1076003)(47076005)(5660300002)(478600001)(16526019)(6916009)(82310400005)(26005)(7696005)(70206006)(6666004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2022 17:23:21.5594 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e64e26c-3fcd-46c8-0041-08dacbe516d2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT096.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8153
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
Cc: Luben Tuikov <luben.tuikov@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fix minmax warning by using min_t() macro and
explicitly specifying the assignment type.

Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
index 5a905002252d7d..53abd770924229 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
@@ -1436,7 +1436,9 @@ static int smu_v13_0_irq_process(struct amdgpu_device *adev,
 			case 0x8:
 				high = smu->thermal_range.software_shutdown_temp +
 					smu->thermal_range.software_shutdown_temp_offset;
-				high = min(SMU_THERMAL_MAXIMUM_ALERT_TEMP, high);
+				high = min_t(typeof(high),
+					     SMU_THERMAL_MAXIMUM_ALERT_TEMP,
+					     high);
 				dev_emerg(adev->dev, "Reduce soft CTF limit to %d (by an offset %d)\n",
 							high,
 							smu->thermal_range.software_shutdown_temp_offset);
@@ -1449,8 +1451,9 @@ static int smu_v13_0_irq_process(struct amdgpu_device *adev,
 				WREG32_SOC15(THM, 0, regTHM_THERMAL_INT_CTRL, data);
 				break;
 			case 0x9:
-				high = min(SMU_THERMAL_MAXIMUM_ALERT_TEMP,
-					smu->thermal_range.software_shutdown_temp);
+				high = min_t(typeof(high),
+					     SMU_THERMAL_MAXIMUM_ALERT_TEMP,
+					     smu->thermal_range.software_shutdown_temp);
 				dev_emerg(adev->dev, "Recover soft CTF limit to %d\n", high);
 
 				data = RREG32_SOC15(THM, 0, regTHM_THERMAL_INT_CTRL);

base-commit: 51005ef41b7e91d1e24e2defec22bc4f1eeb7040
-- 
2.38.1

