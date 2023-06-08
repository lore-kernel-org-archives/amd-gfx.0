Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A180C7EE29
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Jun 2023 17:07:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1E12910E5F4;
	Thu,  8 Jun 2023 17:07:43 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2062.outbound.protection.outlook.com [40.107.220.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E8A3B10E0DA
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Jun 2023 17:07:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=apgAjHVP56IrtYvDCYGLT4GojOEyuwDcoadVWy/hqxZGk1FHzzEM/9S9/PiI9VvK1h/8ikpqzGfb6/djraNorZThbjtOEsxJcCB+UHjfcGh5LvA78KlJ/MHgXbt9gxzzOiyCakdlX2d6ncYiawKV7M/a6FFGlUPQWHK/eiV03S1MUvvHqnDmz+/fViEXDq7tUWfht+OVfajz0PzClswUS5BH4hMJe9TwtTWXOrCqpDf2MOyidPEJGl7siol5JfKqABOOOxvIwPesWE8fqFonIGNG4FzjO0vDzUsZPk9IRH/cmfZxkOinyVaimd0/GeE/4x6F/6GzlHqgUAaKI2lRMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fLiuxBdGPsWrylcshYbAXl8vUR7RxnFEFkS32ME+5Ds=;
 b=W9O1ZMaA9KxoxE5LRIsuk4qgo1VkgbN85/5eSPA2ZGIe+a3WvGo0JvZ58WYLtp7waBRup3PBvl+DqDbZ5Rsa1knG6n3Bvek9iULu2/xrLvulb1cDk1lEF53Uqc1ltfWBCplHjN4dAMc67Pbj//+XE7rTPmf4FmZtnsQDa0kxANzerUbZCU1JsbnCSMDuYeWFaGIGW0WFTE24pT1lBCKr4VoTz903yGRkeDBMma4/LzBQRvOSfGuX3hq3wZHH8BubP8S04JzMyx7lBPquPQTkPp5PcVHqtpb+RRq/HW4lgiky7w6qpz50fr4kbj3q43tNNiIQU6bZWGcnRjAbXruVig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fLiuxBdGPsWrylcshYbAXl8vUR7RxnFEFkS32ME+5Ds=;
 b=FEZbsNJFkJuq57xOy8ccZCDVKLUElzxfnNHqlTJnTkR/yOQfziiWNj14DFtcneo4g6i9LHGuwXhrgeO2d9YfvL281+2bBn4Hg+jRE56nwTefqGbjI/ctWKmr0rKAW5WR8M3eFPFme5/JDSOtQ2arUPBHHrScAySDBBXDlhzc0gQ=
Received: from MW4PR04CA0202.namprd04.prod.outlook.com (2603:10b6:303:86::27)
 by MW4PR12MB6999.namprd12.prod.outlook.com (2603:10b6:303:20a::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Thu, 8 Jun
 2023 17:07:38 +0000
Received: from CO1PEPF000044FA.namprd21.prod.outlook.com
 (2603:10b6:303:86:cafe::c1) by MW4PR04CA0202.outlook.office365.com
 (2603:10b6:303:86::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.19 via Frontend
 Transport; Thu, 8 Jun 2023 17:07:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044FA.mail.protection.outlook.com (10.167.241.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.0 via Frontend Transport; Thu, 8 Jun 2023 17:07:38 +0000
Received: from work-495456.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 8 Jun
 2023 12:07:32 -0500
From: James Zhu <James.Zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v3 1/5] drm/amdkfd: add event age tracking
Date: Thu, 8 Jun 2023 13:07:01 -0400
Message-ID: <20230608170705.2271276-2-James.Zhu@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230608170705.2271276-1-James.Zhu@amd.com>
References: <20230608170705.2271276-1-James.Zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FA:EE_|MW4PR12MB6999:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e39ef22-bba1-462b-5fd0-08db6842dca0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9HT7UldlThL9BkqYAjLpO1d5mc5JiImxl+z28/84z//gXHO5lmu55lwciGT3+TXpbbq/g8b6lvbXR74fk8yBC2Ug2YmR24ae7vMD+P6sktieoI9GENRjah34gK+v3ewPajaz6ysa3CU0HerBCZ7WKCXsuitvbVLe1HH7C55O2tCiz9HMfOG1BzwK4cbF+ptGbW5LqrnMY+CtS68cjjbQL9Ix3N6jabhVQgLAcvtTKDh7eLNHDTtm6vX7cfuEc6lBhJaREz8PFZOX0LErA88DKhHFsSPllyY7ao5yU/n/fIkBanoLCs7XJ5YMbVb7t37fCeaZ6LA4ASqDRi2EKsAeYwyDm171FuD3sXeMHkgIliwuzsMwtzFv3ktPvSntN2Nm3j6SQXMV14rIu10FezqiXo4WRXph3GDYVmyCNiF2w2kUrOB0MtJVan5PyAIPDvfcwUf/pm7sq5/bhJM4qrXjmXPdKuCdObYmfPNJgj06heyy/4hgNS7d469XyUVoMWJ9TiubzUrwsBMbAIVdNV3CNWauJzLhidacLRgi4gnLCSvbXJGCNt+pRPIy2ONBcFr6oCvkaA2eoG0XMkik24DzHdLkRDpdiFsyV++DMt7X0GTreKL+A7A75GjomIDyG04md9/YCF0EYfCeiWxeaGeCi62+QlklV783386FaN91AJRGZNsZ0oBEU4mC8U2jJae1dHjPHLcK670LnaXn/TBnP1TZTD7YiTCZjR6G3UEFBAgXTJ74tXqwse8Lx286ewOn10bPz4sfgh+JNX70mcKcuQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(346002)(396003)(136003)(39860400002)(451199021)(46966006)(40470700004)(36840700001)(1076003)(26005)(186003)(16526019)(2616005)(336012)(426003)(47076005)(83380400001)(6666004)(36756003)(82740400003)(36860700001)(4744005)(2906002)(82310400005)(7696005)(8936002)(316002)(54906003)(40480700001)(8676002)(478600001)(6916009)(41300700001)(81166007)(40460700003)(4326008)(5660300002)(86362001)(356005)(70206006)(70586007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2023 17:07:38.0278 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e39ef22-bba1-462b-5fd0-08db6842dca0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044FA.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6999
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
Cc: Felix.kuehling@amd.com, jamesz@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add event age tracking

Signed-off-by: James Zhu <James.Zhu@amd.com>
---
 include/uapi/linux/kfd_ioctl.h | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/kfd_ioctl.h b/include/uapi/linux/kfd_ioctl.h
index 1781e7669982..93f1c0bc5caf 100644
--- a/include/uapi/linux/kfd_ioctl.h
+++ b/include/uapi/linux/kfd_ioctl.h
@@ -320,12 +320,20 @@ struct kfd_hsa_hw_exception_data {
 	__u32 gpu_id;
 };
 
+/* hsa signal event data */
+struct kfd_hsa_signal_event_data {
+	__u64 last_event_age;	/* to and from KFD */
+};
+
 /* Event data */
 struct kfd_event_data {
 	union {
+		/* From KFD */
 		struct kfd_hsa_memory_exception_data memory_exception_data;
 		struct kfd_hsa_hw_exception_data hw_exception_data;
-	};				/* From KFD */
+		/* To and From KFD */
+		struct kfd_hsa_signal_event_data signal_event_data;
+	};
 	__u64 kfd_event_data_ext;	/* pointer to an extension structure
 					   for future exception types */
 	__u32 event_id;		/* to KFD */
-- 
2.34.1

