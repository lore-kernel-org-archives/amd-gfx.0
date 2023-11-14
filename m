Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 275BCC4332F
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Nov 2023 08:56:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BC97E10E1DE;
	Tue, 14 Nov 2023 08:56:21 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2060c.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e89::60c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1D77510E1DA
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Nov 2023 08:56:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XixEPBPZpVrPU4PrJ7aJkdRfq3jKJgpJPu9Q/WObqx7ldesY8fqEz4//fWyb9VoqfA8Ovum7UD/bArHwY7yk+ink9dRRPfdBTvLw4QwuKNTxDUXSCTgzWf2+4vG8RgK2N3OTE4IzrjJI8SRNYhy4osUMuxExcq4XME5A8GiVhGROBU2wYwLm/efOdzCNfLyDI9s9v4+ZFgcOloOdrD4EqGbJA5HP/HNzObp6eVZPSPQ8YayWn0KNpn2eY9OqnxTu8Hvkn4AlDnZhayJPuKLRSU3No75m0BktOU2dIkeQcIRWIaEK5rwHQSO7b1fQJ8N0olGETVsz6iyvnB4wC10kOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aQuG+E0s2B2lAnJLqu27j9G6AUo6tVxGY7Az1OFQjC4=;
 b=DebpeGDdhab8acvo2cSZJzCRnVpe1Dcj9kkE8jK3DLCi0V1Oku1lJL9ED6vueHp7ZaSEEA3kKl7RSvhk181njz0WLjMDoAs0wgZ0Dby+eZCkepXcJ526+mct0tet7g6KINCfJn37W5zJqGPYr6KCYDWPZ6pjBQZcnkiGOBqCtd+VyJt+pcPpnfAugYR6++CBoWBNNloD4Q5A72+3M6vm/8SfT1cSGaiucEVUOKvEeGoRgZhuxSOnJm7IVxAGz+HdaZI8qNEIyMtP6lVzyCfZBoKFas/FYqDL/OACH673pHJ8fXMPNqJ48ZUFbes9838klfCbLE34AI2Z5FZAPn/i7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aQuG+E0s2B2lAnJLqu27j9G6AUo6tVxGY7Az1OFQjC4=;
 b=tOycYj7ICL4hI7okaM1pYuK2c8OtiLWLScMGwYzoFpJC3uvZiAqb38eQEs2tdf6uWDTmWK1a4FtZq987UaVOeZULm7jB8w4jp2ojh8drix14y0LC8cjJtYGPOhLb/xcvHWLFK7qBhH07kfYsI8p6RJje4aLrJMQ3s+KuExxFElY=
Received: from CH2PR15CA0008.namprd15.prod.outlook.com (2603:10b6:610:51::18)
 by PH7PR12MB5952.namprd12.prod.outlook.com (2603:10b6:510:1db::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.31; Tue, 14 Nov
 2023 08:56:15 +0000
Received: from DS2PEPF0000343D.namprd02.prod.outlook.com
 (2603:10b6:610:51:cafe::d9) by CH2PR15CA0008.outlook.office365.com
 (2603:10b6:610:51::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.31 via Frontend
 Transport; Tue, 14 Nov 2023 08:56:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF0000343D.mail.protection.outlook.com (10.167.18.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7002.14 via Frontend Transport; Tue, 14 Nov 2023 08:56:15 +0000
Received: from asad-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Tue, 14 Nov
 2023 02:56:06 -0600
From: Asad Kamal <asad.kamal@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] drm/amd/pm: Update metric table for smu v13_0_6
Date: Tue, 14 Nov 2023 16:55:34 +0800
Message-ID: <20231114085535.151807-1-asad.kamal@amd.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343D:EE_|PH7PR12MB5952:EE_
X-MS-Office365-Filtering-Correlation-Id: 4af91e38-6110-4aee-add4-08dbe4ef8f1b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Yp6huJu8olRgAZzPGmAfi2NpAd/NeYrtxRFG+d+S9JB4PAnxzznqVqr46T7FbqxpoDCfyFybmyGXnJ6XazjiChuk7PVNpme3EkZoGIp3GEJBOHjYAvAFCLvsMiTQYYxF/AKzwgSwn1Y+b0nY6BYrB7dcMQ+VT9p28r9621BvqyIOUVF09YteUATMyKczl/JtCoZImz24yjWJFZ1OKG3Ppu4liaBG4K8fiemuTlDkBlXw7yETJ0ONEk/wrL+YmayC5d9DrTtWus9YCF2hynD8qb/SaQTYIZQu9YGI6FkzP3CGvMz1sDTtOuQpfThXzXdsPiV3NKVQSvhN0xJGwYoc1vLZdwL0j11niXqq13gWNzHfn7lhAvSwMW9MMRhSTzaUYpWOKuUmMWdzXFMfd1LwjmdDkcZhzq44ZCJloTFk7Ixjq2XUCcQSl/fdJdHsBdNZk2BM9qokVOJsLGHrXd2H/N9U/0K4c72/UulUubvEx7xdoXWj+pjTV0CMvcHr865UcenQRc52kGsxKbx0+UV1grctjr0vieD334xeEyfaaz7Uwy9B1qKordVKulCy80PhfWNTY3smz5M44H1EIS8hFvSyBwQd+SuAbXqkz82/xLh+oMocRzEkFj79d3UW7TlFpEEJFK6zzB6SnWGQTdJYyw6csGaeuiojrYn71v3TShacL0E6mBkpYzNYHG5aUAbfKi2yNmPsyh0FJQgwcbV1qt1vN9U3qx+P7qRBPRG5gc09u9Y9FQ1RAQ1VsY1ZMKXWRxKqn3CGhQJOQg7JD84nVQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(376002)(39860400002)(136003)(346002)(230922051799003)(82310400011)(64100799003)(451199024)(1800799009)(186009)(46966006)(40470700004)(36840700001)(41300700001)(36756003)(36860700001)(2906002)(47076005)(81166007)(356005)(15650500001)(83380400001)(336012)(5660300002)(426003)(86362001)(82740400003)(40480700001)(16526019)(26005)(2616005)(1076003)(44832011)(7696005)(478600001)(6666004)(4326008)(8676002)(8936002)(40460700003)(70206006)(70586007)(54906003)(316002)(6916009)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2023 08:56:15.1548 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4af91e38-6110-4aee-add4-08dbe4ef8f1b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF0000343D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5952
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
Cc: le.ma@amd.com, Lijo.Lazar@amd.com, asad.kamal@amd.com, shiwu.zhang@amd.com,
 hawking.zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Update pmfw metric table to include pcie
instantaneous bandwidth & pcie error counters

Signed-off-by: Asad Kamal <asad.kamal@amd.com>
Reviewed-by: Le Ma <le.ma@amd.com>
---
 .../drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_pmfw.h    | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_pmfw.h b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_pmfw.h
index dab35d878a90..fef2d290f3f2 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_pmfw.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_pmfw.h
@@ -123,7 +123,7 @@ typedef enum {
   VOLTAGE_GUARDBAND_COUNT
 } GFX_GUARDBAND_e;
 
-#define SMU_METRICS_TABLE_VERSION 0x8
+#define SMU_METRICS_TABLE_VERSION 0x9
 
 typedef struct __attribute__((packed, aligned(4))) {
   uint32_t AccumulationCounter;
@@ -211,6 +211,14 @@ typedef struct __attribute__((packed, aligned(4))) {
   //XGMI Data tranfser size
   uint64_t XgmiReadDataSizeAcc[8];//in KByte
   uint64_t XgmiWriteDataSizeAcc[8];//in KByte
+
+  //PCIE BW Data and error count
+  uint32_t PcieBandwidth[4];
+  uint32_t PCIeL0ToRecoveryCountAcc;      // The Pcie counter itself is accumulated
+  uint32_t PCIenReplayAAcc;               // The Pcie counter itself is accumulated
+  uint32_t PCIenReplayARolloverCountAcc;  // The Pcie counter itself is accumulated
+  uint32_t PCIeNAKSentCountAcc;           // The Pcie counter itself is accumulated
+  uint32_t PCIeNAKReceivedCountAcc;       // The Pcie counter itself is accumulated
 } MetricsTable_t;
 
 #define SMU_VF_METRICS_TABLE_VERSION 0x3
-- 
2.42.0

