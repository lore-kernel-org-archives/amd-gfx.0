Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7287C19F2B
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Jul 2022 04:52:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C7F2811A168;
	Wed, 27 Jul 2022 04:52:14 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2043.outbound.protection.outlook.com [40.107.93.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4F52111B3A7
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Jul 2022 04:52:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H7RwS07aC7NO7ZgRPMDZDQ2PuWXQMeBGBZxYuOdZrDVlXCD/u7T2iCxib63IC7dlaiQ/pa7iTwFLDCXQVaF2jXkVR9XMUxXRExCYcMgbCNx77FBmDXAG8rAIw+5JyGlT7d8sx6Gah/5Qt6PKJP627f/krVE16r38+HKZ7WXrhJCE9tmDTKEP6+cXnsplMBms2FMfkjmpVTDapmUvdPoy6UfwORjBUw48FetoJpAdUGLKtul7Oe4tpmZ80F/gJyHwA8rC0GpA1dyYFfOW38v4yunfeBYlXHnqGL9urtCjU9vd05VSCEDViSIooVTrvhjAMElmymKNbc1kbAxLG57J/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bo3M8WzUzYyxcZwH65xhw5DmyjDZGOdCfKDvcXkeH5s=;
 b=TCdNI+mZbwYT2c9Ip9PXiDsRJW2LzUr2AWwLTKbZ2+h2w9Nr1/hnSiz8J7ETR4/2qUIZYy9zLMN8VFZXsJUCmaFQjTQTGb2aK0a5Ph16LqduZiRtK2WqsM1sN+AO4epQwfSYTwGUi8CtSFwIauomTnqzQOGOymll04PBOcAW6IPq+D1lEB2pDwNsDEmBveROkRDBv9PF2k0kcJ7vg0+gmRGBFQPWxyWziI7EmfwoHnAfRhSgrESulonB5K0zeBqCb3odWsTrs/zq1pJifyefHzTKAFpVDTLqCp8r/60G8c6vmwzByqQh2AWLp/1z8H1jNkXJOVlw0yQkttq6PZNr3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bo3M8WzUzYyxcZwH65xhw5DmyjDZGOdCfKDvcXkeH5s=;
 b=biQUBoDgudx41Zj5gAxRlItYZ7z0qlbx6MwFl5uHdBTXbmAELpXeNFi2D/eUCi8PT/KudXMz6fMNQ0ylA4NUwZF5DNfwR4veg3UFe5XYC5GJABJJSssWXYyrEg23WhlMN+yk8mSSCm1cJRbTHu2lPF3JFrwudSkJncL9vec9v5s=
Received: from DS7PR03CA0189.namprd03.prod.outlook.com (2603:10b6:5:3b6::14)
 by BY5PR12MB3889.namprd12.prod.outlook.com (2603:10b6:a03:1ad::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.20; Wed, 27 Jul
 2022 04:51:59 +0000
Received: from DM6NAM11FT008.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b6:cafe::b3) by DS7PR03CA0189.outlook.office365.com
 (2603:10b6:5:3b6::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.7 via Frontend
 Transport; Wed, 27 Jul 2022 04:51:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT008.mail.protection.outlook.com (10.13.172.85) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5482.10 via Frontend Transport; Wed, 27 Jul 2022 04:51:59 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 26 Jul
 2022 23:51:57 -0500
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] drm/amd/pm: enable GFX ULV feature support for SMU13.0.0
Date: Wed, 27 Jul 2022 12:51:34 +0800
Message-ID: <20220727045134.499712-2-evan.quan@amd.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20220727045134.499712-1-evan.quan@amd.com>
References: <20220727045134.499712-1-evan.quan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4500e0df-f191-475f-cc41-08da6f8bbd5a
X-MS-TrafficTypeDiagnostic: BY5PR12MB3889:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4cibc1k5uamXI+RXCSn99fU7u4UohWT2nbeBIpAxWLs9oENeAH+3+wz8o7rVfmdSPQG/CjyyU+ugE/W8KUbymEWFzjSi3LxCcoflbUbucPON9euh/dpmhF57FL3XukyXwmmL/DSk7lvRd18Wsu6E/rixq1C7eUO1fR7n7DDVQguTMVyTGpkUqjtoCWfYX1z4y0EeAUmQOEqryNOQlqZyUC3HZS4DFDi283OYkdX8Ib3Cu0eZvk8dqIXu1nFDXluscCDGw2xpNgzR2jMJUjy9zEl5b/6zSlk2+L6RTEqhYwqQBv0qzcUOn6EphbhA6LOcbfQXQ7JdFYwcdrMLJn4EFynIwUTObvph3Q33oDAR11Wvb8KhUjt7jKvMR3BdwpM/df83aRZ7pEvKkEWeL+TqIBKKZInHiEExlR/Cw4JbOhUc1icVUshWwajnsgjxEs+4loQ/6mxudBDTyNUksjDBd0UPzzkgnHEwRjFqakVADGnk55LBdtKfKE32/CpQ8iBJcpmTyLQ6rF+k8bDb6reOaeh+l4ldRcpnrBmEUU5bT6ekdBb7Z6kxokfJ3AMXWcn7XoMImBjjWHekoA6YzEHoTu0WQwBgKoIZzIDx5YXnst2zx3zEVk3xWuo5D7fcJwBwxWHM/9cI6UbjPW4TuFG3FtpGZskEpL4TuNNLE2InST5qmbCr87b5FiSKT96ti1D3G+aghC/f5lg/853fP3tJOvraYmQWQGbeXcPqKsyf1viIfsY3BshpG1kjHudpWQc4zvdCXls3IqNtZvtb+hrsoMuwYotpgFC3oHYKXrzFhd4Hngcghf1vRqt5nyriulQpAP9T8k97weYkcvyJN+sdkw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(136003)(346002)(39860400002)(376002)(396003)(40470700004)(36840700001)(46966006)(8936002)(186003)(1076003)(6916009)(81166007)(54906003)(36756003)(40480700001)(316002)(2616005)(82310400005)(36860700001)(336012)(26005)(82740400003)(7696005)(47076005)(8676002)(6666004)(70586007)(16526019)(44832011)(4326008)(356005)(41300700001)(2906002)(40460700003)(4744005)(426003)(86362001)(70206006)(478600001)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2022 04:51:59.3234 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4500e0df-f191-475f-cc41-08da6f8bbd5a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT008.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3889
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
Cc: alexander.deucher@amd.com, Evan Quan <evan.quan@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The feature is ready with latest firmwares.

Signed-off-by: Evan Quan <evan.quan@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Change-Id: I4907ef8c96eb8933db01818d7431afb3778d1afd
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
index 931c775fe27e..1bbeceeb9e3c 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
@@ -313,6 +313,9 @@ smu_v13_0_0_get_allowed_feature_mask(struct smu_context *smu,
 
 	*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_DPM_GFX_POWER_OPTIMIZER_BIT);
 
+	if (adev->pm.pp_feature & PP_ULV_MASK)
+		*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_GFX_ULV_BIT);
+
 	return 0;
 }
 
-- 
2.29.0

