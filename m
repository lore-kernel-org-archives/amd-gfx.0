Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3A8DC433EF
	for <amd-gfx@archiver.kernel.org>; Tue,  3 May 2022 20:37:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D552E10EB2F;
	Tue,  3 May 2022 20:37:46 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2060.outbound.protection.outlook.com [40.107.244.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E1D4C10F441
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 May 2022 20:37:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R6MNfsx4ukCB6Zbvd8SUQ/ARjELyJE5lxjYaEpJoSn5+2leos0zRMOhlEjXQWQ1NICaboaeIC/N9iz4pggfnfcBIgPL8oi2ylmKjUAl/YVSBSvOp82B5l2jNBCaYTRGWXQ3tvI3IvVQKCNfr1VM12F4XKIlgj+T25VC5LnpCZq+fwpUR69m8/XG4qv2DF8/Qj6mfGVzmpmJAAAzGYmOlO9k0HMtp2sywnQpREws/HeZ2/ApJKWsE2EFoHhJwBpG1CAyD8qsYKuvcUZMLPunjnFMtrFQlQacPZkYmOwugMi4t3lXog80SwpC2mFHgFVPTdmq4eZHPQ6BeJgvTgSUsBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=leVRTH/ssyvYdNmf5FszOY2OcXbyvmqCsgX5qyz4JJU=;
 b=jpD/d1kj/j3sd6ex8MxSnyXWvhdDwenLU8O9DSJP92Y/Fi0b6A+y7yawsVaIDzrjLR1nS8fOPRHbJ7Z5365/BcGA0q2yfgSYWZkvsjN2imexA4Uqjv0UQ27oywF/wltmlJP9t22AsDBkwPvkD0Jq7uGl/OQYpkoTcSvC3qtiLulYqv7Yq/sgYdOfW511gaNR9dT3+sRgvA31XhFoNpPMBtTILRedgpnEPeAIUqpIL0yj+MhKHm5zbkpC0LqKcvQ1fbVlbBJBpEY0Pj7mq1btJgxlIrIPfPmAgT1vKkKsK7yvTTNfNpoZVp0nDT4Mhxqeu6w+4eT0PHvimNcpzEftew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=leVRTH/ssyvYdNmf5FszOY2OcXbyvmqCsgX5qyz4JJU=;
 b=g+8OBS8FjAHG+wplWsWoalFXURns0JSVR2sQivHXTG03FplV1Si0hmNoS3PQC3bSqXZ1MzxujNYHeVRJSFD4J0m9H8Fd+EnShk7yApg/jV2QE7r0ek9E3FaGBdoUIf1zDReIldC8omfDc6p7WOD+NivBeEx5TIyMUisdFSwMGso=
Received: from MW4PR04CA0125.namprd04.prod.outlook.com (2603:10b6:303:84::10)
 by CH2PR12MB4213.namprd12.prod.outlook.com (2603:10b6:610:a4::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.12; Tue, 3 May
 2022 20:37:42 +0000
Received: from CO1NAM11FT067.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:84:cafe::c8) by MW4PR04CA0125.outlook.office365.com
 (2603:10b6:303:84::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.12 via Frontend
 Transport; Tue, 3 May 2022 20:37:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT067.mail.protection.outlook.com (10.13.174.212) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5206.12 via Frontend Transport; Tue, 3 May 2022 20:37:42 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 3 May
 2022 15:37:38 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 20/26] drm/amd/pm: enable gfx ds for smu_v13_0_7
Date: Tue, 3 May 2022 16:37:10 -0400
Message-ID: <20220503203716.1230313-20-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220503203716.1230313-1-alexander.deucher@amd.com>
References: <20220503203716.1230313-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3dcca64f-d17b-4fa6-affe-08da2d44c5a5
X-MS-TrafficTypeDiagnostic: CH2PR12MB4213:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB4213A204446EAFA60BACA83AF7C09@CH2PR12MB4213.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: w7DjG6444zctsx3a2+VZ04eZyjHP1jLwZ51M4gQ8DQNTE3SyvVfBu5RDX+lkT9dxmlbuE4t1akBUk6JD52j2G4Lb1rWYqcQM4zZlU5geb1wWewK0Vultx7hiXUNMYtkOdA0dHDq+pyued2tiN7hRdA2EYYkYSUH3B65IEZhpaa2KvUx/dughimWIIfTheV8aV2cNMDg/OR0OLQ7Zt8iS0IpjEQU7bHX9uTBOP6HDYfpMZi4vQAItfTnJFisvZcfOdHFcaFBPtvy6RpxNrgZ4OXUdk+fO1nTOorcrimBqkgOKKkDEc/4icHWwSX6WHw5vJsRkGN0m9p/wwyu74nhqTX84Rc8bInQSsOL5kKd+NhlPAaY+VjqHhUh+AjBVcsDnSQjR8KTXhohe2dGIEkPiHAHZ3YfDlpcnh2F5JbFALx1pZaWL47+LjoJ6SMiTGUodYOd0bCeE4UdouWKNZNph7B1gcdCvFGUJZCZJ8MUnR5oP+DGHm8SyjNtDk1ItQgbkinG3EsLCR22uz4I+WojNdEcP+yjU5WxWeoRYFLObs5IWanJfx6y1SBQwLOA7p3xgdJpOTQUf9W9M8e1zmyvcLhoe9bPsCMkKIa4tdWJultQcStOwI75eQ1BU5OL+TXn+OxbVKwSrESUhXj+y8NSB8SRBgQybRYUNV+Fb8Wsm0SeX9FWlROrKRQGfLvMWHdOQBknSi/d5fhsONT/ewcdlYw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(40460700003)(36756003)(47076005)(336012)(426003)(36860700001)(356005)(54906003)(508600001)(81166007)(6916009)(4326008)(186003)(2616005)(86362001)(1076003)(70206006)(70586007)(16526019)(5660300002)(8676002)(7696005)(6666004)(316002)(26005)(2906002)(82310400005)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2022 20:37:42.1467 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3dcca64f-d17b-4fa6-affe-08da2d44c5a5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT067.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4213
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
 Kenneth Feng <kenneth.feng@amd.com>, Yang Wang <kevinyang.wang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Kenneth Feng <kenneth.feng@amd.com>

enable gfx ds for smu_v13_0_7

Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
Reviewed-by: Yang Wang <kevinyang.wang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
index ed7500a292d8..45c0ba4a30e3 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
@@ -215,6 +215,9 @@ smu_v13_0_7_get_allowed_feature_mask(struct smu_context *smu,
 	if (adev->pm.pp_feature & PP_PCIE_DPM_MASK)
 		*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_DPM_LINK_BIT);
 
+	if (adev->pm.pp_feature & PP_SCLK_DEEP_SLEEP_MASK)
+		*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_DS_GFXCLK_BIT);
+
 	*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_DS_LCLK_BIT);
 	*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_DPM_MP0CLK_BIT);
 	*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_MM_DPM_BIT);
-- 
2.35.1

