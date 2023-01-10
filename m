Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E5F3C54EBE
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Jan 2023 03:37:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B8D2110E0DC;
	Tue, 10 Jan 2023 03:37:57 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2043.outbound.protection.outlook.com [40.107.220.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1F4FA10E0DC
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Jan 2023 03:37:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L64tVFMMM1zXsGuVa+hjp4bny1ivgmuYKjyS1nehNi218RBSO6hWF8PZIPRglQO/s6uOfCmqDuvNpZtgnNd9rzj0nNo77JxEVU8ibnN/KWg2zRLhNeTJpLysoDQfUwsmUiFf50drMWimLcRYHEtVruCKVtyKD6MsCz8UVAazLHY6N37AV9eNVCDNSAwZsKkBtI33nxWSw3dvXcVKZ69EmbNkk+h3zpWIfWtsdaokNoloXYflvSARLjOlSnZxNuayQL+lAqR6S+faovUhwzg93AjNUDp776RDsrjXSjYnwfaf+ckOCQzQ6PKiRPokovkPi3FTBJsVcu7ZCWcLhINTlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vtP3q8Wz0H0aQU/Jb8gkz+R6DFFPvcfXz//fUw9onLk=;
 b=lWMi3z/xl/iBFWxwT8OOrkALkSUUIFeQGp2P33KLkUR2FsGLgSUVtjQGe4dp0sPtMcj4qWYHvggcGLnXDL9Bj/bWRPPadIyIkwk9JCLT3VXTdnGA/vXz5fb66az4b4ziK4Y4G6fSfL1k5TR+orEqud+Dt80sne/nNb8oFg6kfbSlS0cuSJs0Bo2KukUKzvxW74A0+QTJ+PuvGk2RTqrnHBH55lp2xd3BU/eVKt6I0YYzM24/T71uVZ5VayEyB03JVLdviniCWtaeh7HGNvVsbCupTnfENycL4yEihIaH8/AWmSL5WptPf6eE/tMtCur823+fN01/isjaDNJMIrDfMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vtP3q8Wz0H0aQU/Jb8gkz+R6DFFPvcfXz//fUw9onLk=;
 b=0iTZkO7m9zWr+pfKO+btKqxB1ZFiw+lErabfpsPEK1edsRofSta1zPlUd7y1PbgXUc6P5Yyroz0u94F3q0VWTV0xyks7UlBICxbIIsb1RC9YrRc8G5mtQRj73/iD25JN4zthErnHPjaxRvVIPgfZTmiZKbOzt07WmKXdpZwwVjI=
Received: from DM6PR04CA0028.namprd04.prod.outlook.com (2603:10b6:5:334::33)
 by BN9PR12MB5148.namprd12.prod.outlook.com (2603:10b6:408:119::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Tue, 10 Jan
 2023 03:37:53 +0000
Received: from DS1PEPF0000E651.namprd02.prod.outlook.com
 (2603:10b6:5:334:cafe::21) by DM6PR04CA0028.outlook.office365.com
 (2603:10b6:5:334::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18 via Frontend
 Transport; Tue, 10 Jan 2023 03:37:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0000E651.mail.protection.outlook.com (10.167.18.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6002.11 via Frontend Transport; Tue, 10 Jan 2023 03:37:52 +0000
Received: from guchchen-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Mon, 9 Jan 2023 21:37:50 -0600
From: Guchun Chen <guchun.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <alexander.deucher@amd.com>,
 <hawking.zhang@amd.com>, <lijo.lazar@amd.com>, <evan.quan@amd.com>
Subject: [PATCH] drm/amd/pm/smu13: BACO is supported when it's in BACO state
Date: Tue, 10 Jan 2023 11:37:33 +0800
Message-ID: <20230110033733.127420-1-guchun.chen@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000E651:EE_|BN9PR12MB5148:EE_
X-MS-Office365-Filtering-Correlation-Id: 470bb318-b45b-4957-714f-08daf2bc0df6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SX0M5D7/o8zBX9T7KYfcbXSy2Y6ydUT1S65Aofhy0JqClXkR/p6iZ1nq7eS4OT0XmIWQjoMuaTClVn3di7K2XrG00tBZ+ktuIRYueTQIIaT5JyYYaMB/U8Zb0uu8QXkx24PGDWqWpzgEoRr/LyzNdGzg7aFJ1Lm5PQRJEGmLll2SVvDRyolhxDIpyNgWaSI08JpSbfhLoJ+cvB8n1STfMOG3f2pSDXlPoujgy8s+5WrhEHjNXaCcGKmEzNq9IEinA/0GG2TeNZtEZSUyQp05slUeb2NDNEuTQ5UvwgH7w+KvKyT3XAN7SdsmoaE4VXLsQFdyd+AeYN8uHASNlS3PggrbntZdEin3FXEe3CnOhXXpl/t2WxGT65esoU2x111ZqJCNO87koWSekDsHs8L64oOhC4DQl5NfLljZpas4lW/gyvZaRl1q7avyVJS98+ig6ukuTIRW7BNOtqovkU8+atQlu83j8s3CNXKvYn3i5XeyF+Qrjm7YzQ7DMMLV+vnvhsjwzfo/KX51JB9Sy+SfJqtOz6cQANIb8y5TgI0YQ4qJVY2IOLMcuWz0O0gX5H7scnECo++PI4nDm8rnro0ScdVxdABNMNFqtcgGvjoC481VuVVXFIsoMuyae7r1YOrfEyaYy4PvisT0JjCCG2XbyHQPOvm+qsLoRAkpTStwjLVnzm2du3nHxCTYthII1swuXvNA6BkwYH+XHKQKCzWacOuiuUwEYV+RKdNEF681lt+kc583o6ckLr2MwPnHhTN6
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(346002)(39860400002)(136003)(396003)(451199015)(40470700004)(36840700001)(46966006)(44832011)(2906002)(82310400005)(47076005)(336012)(36860700001)(426003)(81166007)(16526019)(2616005)(1076003)(5660300002)(40480700001)(7696005)(6666004)(26005)(6636002)(186003)(36756003)(8936002)(4744005)(478600001)(70586007)(110136005)(70206006)(8676002)(41300700001)(356005)(86362001)(4326008)(40460700003)(316002)(82740400003)(2101003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2023 03:37:52.7593 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 470bb318-b45b-4957-714f-08daf2bc0df6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000E651.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5148
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
Cc: Guchun Chen <guchun.chen@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This leverages the logc in smu11. No need to talk to SMU to
check BACO enablement as it's in BACO state already.

Signed-off-by: Guchun Chen <guchun.chen@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
index ccaedfcf977e..78945e79dbee 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
@@ -2243,6 +2243,10 @@ bool smu_v13_0_baco_is_support(struct smu_context *smu)
 	    !smu_baco->platform_support)
 		return false;
 
+	/* return true if ASIC is in BACO state already */
+	if (smu_v13_0_baco_get_state(smu) == SMU_BACO_STATE_ENTER)
+		return true;
+
 	if (smu_cmn_feature_is_supported(smu, SMU_FEATURE_BACO_BIT) &&
 	    !smu_cmn_feature_is_enabled(smu, SMU_FEATURE_BACO_BIT))
 		return false;
-- 
2.25.1

