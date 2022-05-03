Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD0DEC433EF
	for <amd-gfx@archiver.kernel.org>; Tue,  3 May 2022 20:09:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3B8DE10EA09;
	Tue,  3 May 2022 20:09:16 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2059.outbound.protection.outlook.com [40.107.212.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3181510E9DF
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 May 2022 20:09:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K2auxAWTQHqI0yV6qczoYh/t1x5KRgsQFkIBYDWawl/vcbpeSM/YxULMTXyGt4nI9MSIYPBLJBSwrPA8coKTRyk8t9yJl9z/2+RHzd7BWVw/01sjGFynj0EzZ6hkpk7X8v5fS1qGGmcW3aYO4fHx0/aioqU06ePyO8ntYLxqmTzpt32dFR32RKPc3j5riHrJabMk/tku1dkXRswnnN+/A1x70fbHnLVIly/8nDZtSF+iOZS1Whs7KRovjAV29cIeDsvPff8D91M5ZhnlALxI5rBvjGxXHuzAMNiiJY4hsjCAbWDFDSRdWouTNaogYx1Yy+0H7tRhgzSdOLa1Yr1VgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uIUgF4+K+YehoeuXUVmqGO3bww8TRUed5ZvxzpF+3mc=;
 b=EiFUZp66gnwlt0iftaqRnzEUzc4tEz6/xjJyS8wFSuU6RN+I/8trvXHKGYIj6D0DkkWYDHOBnGdIy/jOXX0EX6iJd80/rCXTsDUgxXvktfZIONo9Of+EIv4FZoCvBOaK8LSr2ErnLHuC7+U3KgmeGEEjD9Dkw4x8VEh3AQ+sf5e9FFmYHP9b7y5OMSjucTM/059ZUT0nbYqX495Ekh3D0rUQa7bQEluGVgr5Q27N087qFYUBDZV3iUHVmTFW+tLJr1b2pIHhYLPU/XUoLHg17Kuo/iHXpp+4mGiWm4vFl01CXXi6/tElM0l+E3Lr8FJen3/WZeN4lMI4c06KwZTMSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uIUgF4+K+YehoeuXUVmqGO3bww8TRUed5ZvxzpF+3mc=;
 b=Fi+0trsD/4rLFClJJrisF+ePcxT+HjfATqzonqS6ZeWwcrFL7TCtD+JrSm42NIZbIWhXDkPfEv98ShD/0JREAVnVhp6GI5eglrneV2fDU2zvo52FVFbx/4EZBxBYCg+PPHhWFJgemTW0PON8ZVs9SFuLaOsFmyqTxs+T3dPMxEc=
Received: from DM6PR07CA0063.namprd07.prod.outlook.com (2603:10b6:5:74::40) by
 MN2PR12MB3728.namprd12.prod.outlook.com (2603:10b6:208:167::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Tue, 3 May
 2022 20:09:11 +0000
Received: from DM6NAM11FT066.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:74:cafe::bb) by DM6PR07CA0063.outlook.office365.com
 (2603:10b6:5:74::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.12 via Frontend
 Transport; Tue, 3 May 2022 20:09:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT066.mail.protection.outlook.com (10.13.173.179) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5227.15 via Frontend Transport; Tue, 3 May 2022 20:09:11 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 3 May
 2022 15:09:08 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/pm: enable RunDcBtc support for SMU 13.0.0
Date: Tue, 3 May 2022 16:08:34 -0400
Message-ID: <20220503200855.1163186-4-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220503200855.1163186-1-alexander.deucher@amd.com>
References: <20220503200855.1163186-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 80676577-22b7-4238-9858-08da2d40ca0f
X-MS-TrafficTypeDiagnostic: MN2PR12MB3728:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB37283D5ACEB9A63295783FC3F7C09@MN2PR12MB3728.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ifYYH07ZsD5i9RLk9+LhP5zHlmfGOppNfO6E7DvNVsJKjh3MUNshiVy1XetWYad7nT5o/B8hVjBVT4Y0fDVcOwhBz56+WwDUDWRaY2W/SdbBt68fM2JZj4+Cq7EFSUq4vMLunr4nd2v+/H7i2ENr5JNsOu3cgxt0FEQbRKGmf93DWHbeUa900iJ0iLg35jjqg/h6KE6CtHxkDG24zoaLehdUX2Hc5cO8O2N/5jMUeb8U1Kf/H3bQZAzxXihFA7eMtbatYxfuyDZvRxl5IIZEMGOw5rxBilb1CqIwAv4QYC7nF+yuwX2F8t8Q21Z6GXXTv6YLdCeq54n048877xwIlEDX5DFONWjyJde+qdjiTN6BWmagu1nGcDXYAelyyuCS+uiS/cYzSv15itP5eSE7MJlQ9V+O1gjNnT3S3CjYONlPs07EH23JZ9OBdTQ9/CVC9XIRIGvpshX3TRrCjuPBG5IDnGlR0pMaEtHMgbXqHLxcDeXYSmwZhimfnIBmGWQ8BhBr9j2nPmxFDlfEweDxRwvrVJRvtQuq02zab0SQ+n1AnVuLaFqq7r+Xqhc0Qlb5m0sJEcL1b0MWqtJwahYcvIgODBmLTryU3nYr/jPJ2tvs8mk0ZBYyewXcmM25mo/IwCRpnli7Ui6GROu8qf2YqrblKY0Q6i6ugqFDzj1PZfBSpmWV2VaXRDQCDx7WQtTBc+N5JyidU4R2Eqe4EolyWQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(6029001)(4636009)(40470700004)(46966006)(36840700001)(36756003)(508600001)(36860700001)(8676002)(6916009)(4326008)(54906003)(70206006)(70586007)(316002)(5660300002)(8936002)(66574015)(2616005)(6666004)(1076003)(16526019)(426003)(186003)(336012)(26005)(2906002)(47076005)(40460700003)(86362001)(356005)(82310400005)(81166007)(7696005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2022 20:09:11.6585 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 80676577-22b7-4238-9858-08da2d40ca0f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT066.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3728
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
Cc: Lijo Lazar <lijo.lazar@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
 Evan Quan <evan.quan@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Evan Quan <evan.quan@amd.com>

Fulfill the RunDcBtc for SMU 13.0.0.

Signed-off-by: Evan Quan <evan.quan@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h         |  2 ++
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c       | 11 +++++++++++
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c |  1 +
 3 files changed, 14 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
index f55f701e4681..f05ae0fe86e8 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
@@ -273,5 +273,7 @@ int smu_v13_0_set_jpeg_enable(struct smu_context *smu,
 
 int smu_v13_0_init_pptable_microcode(struct smu_context *smu);
 
+int smu_v13_0_run_btc(struct smu_context *smu);
+
 #endif
 #endif
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
index 8651f275bc68..eea7aee06af4 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
@@ -2100,3 +2100,14 @@ int smu_v13_0_set_jpeg_enable(struct smu_context *smu,
 					       SMU_MSG_PowerUpJpeg : SMU_MSG_PowerDownJpeg,
 					       0, NULL);
 }
+
+int smu_v13_0_run_btc(struct smu_context *smu)
+{
+	int res;
+
+	res = smu_cmn_send_smc_msg(smu, SMU_MSG_RunDcBtc, NULL);
+	if (res)
+		dev_err(smu->adev->dev, "RunDcBtc failed!\n");
+
+	return res;
+}
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
index ea549b9b01f4..b4c693d322a0 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
@@ -1549,6 +1549,7 @@ static const struct pptable_funcs smu_v13_0_0_ppt_funcs = {
 	.set_power_source = smu_v13_0_set_power_source,
 	.get_power_profile_mode = smu_v13_0_0_get_power_profile_mode,
 	.set_power_profile_mode = smu_v13_0_0_set_power_profile_mode,
+	.run_btc = smu_v13_0_run_btc,
 };
 
 void smu_v13_0_0_set_ppt_funcs(struct smu_context *smu)
-- 
2.35.1

