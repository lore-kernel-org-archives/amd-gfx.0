Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4B4CC4332F
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Oct 2022 09:15:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2E39E10E629;
	Thu, 20 Oct 2022 09:15:33 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2071.outbound.protection.outlook.com [40.107.94.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CA43510E5C6
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Oct 2022 09:15:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KLoO7hxr6ikRotB7aUx4kWG/C0v70SkoEGKxaJQ6ppShqNRAhzUr2uQtpRdoe8yJxVPh7avkdCsn6yscL5f86gkYu0S5IfO7yCsDalYF9vWWavscwyIzRB+zR2DM6e/yAbFbFTujhgG7tG2W9aTVPQaoDJq0wf/vlSFziwcQPxxPMuHI76Ey+2LdPfaGs6q5/DrlBuNQMOhTJr97rpOepMvKIen5qXYamlZGj66I00C+fAVH/hEGgifUXRLIN0lKESFMaeoF2XNzzneDfU2bhzeJWj8jbaKZw3R/nDLuyXHQyoPI90LWWQaYAC4f3hqtPKjeX81chCK6+FVji/r93Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/g/OnjG2NaqmemTXLcLvLqp0y2uvGKN8/QrmAhOoBfQ=;
 b=X+KJFIoejnjgX9e4CtmIuL7WGD3pQLqQVaLHnOX1rzmjL0I7+ZFKXVScPyJulPWJYw/hyd9/lBB9ilAXL4pd5Hd5GdWhoHkKI8AG/wRdGffeuRaSl/BOKEzVWsvNqlbGF2iyAOFMnzltkfCuAnQzmQqWtWltP5DEb0gv90W6yp8LANvqTaGGyUBjdVMgzTsgb2wAwyc9W+MFxyI3p7RQj8jWyatEwq9QA+3/XX46jAUkUqi6iwcRO//iA9GuJQOWY8R69k6qs4lWb4JM09RYvO1ClgDK1Du1kRlg3g2sakXiSNccJ0tsACTMn8zeIvf5bmiJIQqpG8aTznJAzI2OQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/g/OnjG2NaqmemTXLcLvLqp0y2uvGKN8/QrmAhOoBfQ=;
 b=FIEAcTUwnHuV0kHBTQpmMpKTuthrQ5JORj8LMYkVj/h/Fgx56fp2KRvETkFKLTtcVxCjnYoARZb2ljETEc7BimOo60OXq3uhf6pw1zL/HIUQE4IgngtnlG0WRK3hb2UWcKPzy5tRqvT201yuCNPmEtVzgOIz3et2q6uuayvDoOY=
Received: from DS7PR03CA0049.namprd03.prod.outlook.com (2603:10b6:5:3b5::24)
 by PH7PR12MB6666.namprd12.prod.outlook.com (2603:10b6:510:1a8::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.29; Thu, 20 Oct
 2022 09:15:21 +0000
Received: from DM6NAM11FT057.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b5:cafe::d0) by DS7PR03CA0049.outlook.office365.com
 (2603:10b6:5:3b5::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.35 via Frontend
 Transport; Thu, 20 Oct 2022 09:15:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT057.mail.protection.outlook.com (10.13.172.252) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5746.16 via Frontend Transport; Thu, 20 Oct 2022 09:15:21 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Thu, 20 Oct
 2022 04:15:20 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Thu, 20 Oct
 2022 04:15:20 -0500
Received: from prike-code-pc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.31 via Frontend
 Transport; Thu, 20 Oct 2022 04:15:18 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] drm/amdkfd: update gfx1037 Lx cache setting
Date: Thu, 20 Oct 2022 17:15:15 +0800
Message-ID: <20221020091515.2758445-2-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221020091515.2758445-1-Prike.Liang@amd.com>
References: <20221020091515.2758445-1-Prike.Liang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT057:EE_|PH7PR12MB6666:EE_
X-MS-Office365-Filtering-Correlation-Id: 03252559-6b7f-4d5d-f94b-08dab27b9d04
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fyFLUFIdOCHZBaSl4cectKWHJtMekOKVprINIR1oatjX8EWJn6GsxNh1qvhZRBOEL54nUfWBNxoDc165YHnajj09Njo54elE1RZx9aFGMg08B/6oEcfev3vslYIE4j+xBReT00lrXq9jrcZatEkPAgSC2gYFAeUPqPpyKxqe1k0PYne01/lGWmj5HMq8y4BecXH6PCO/RgYYyxWMnGgXVtqEbtA9wp3c843REbVFFUTrz2MO5vuu04A4+Aom2iNCHWeCMoRIKKdXqnWqubJZyhiSpH2fHlg/ZU0T8yW3jnE9Z936LfzuMxAObWFoq0tMs+OW26UFy+gyXKXuO0L/dFJeI+HBVCBsv4qXoySLfPayfYLspXtvrbfSOa1Do2v/kcRMXU4benB9hAeAWIFD9M1E+Lu1BOFdyXfsUNv1b5c9lLsWVTHW3MQ5f8UoxLy0b4pSkm5csYW5oahVgCYAWkRmP0Nklm1jv8KSuNOlb1V/PmO2s2vh3XyHLugNIr55A3v/y4xgfgvee7uXDHAg9613sS6CTqK0FIkW5MtD+SDD01LjuowJ6F4IIfrkCF36NRpqRnrGzSzkeMRrkka4ftxPnNcIQS70SKMXH4jU9WgoZYGjOT/VMpB8OCT1jkynO4z3vXAJIqCXCrMcvpPkbawloBb/6jKuU7rRaNSzWnR8OfSRkjaQVp1acJRFjxIIfHKgNq56iHXDG3KQOADtx9MevZZe/AdjxBT0pI6AJisFNZ0G184C35yKLneE3Cf9SkLwXHSZFAKMTBV6VZ8yz5ulagD+oU0AIs3Vw99jEyY=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(136003)(346002)(396003)(39860400002)(451199015)(46966006)(40470700004)(36840700001)(186003)(47076005)(1076003)(336012)(36860700001)(426003)(2906002)(2616005)(8676002)(15650500001)(82310400005)(5660300002)(7696005)(26005)(54906003)(316002)(6916009)(86362001)(6666004)(41300700001)(8936002)(82740400003)(70206006)(70586007)(83380400001)(81166007)(4326008)(356005)(40460700003)(40480700001)(478600001)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2022 09:15:21.0635 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 03252559-6b7f-4d5d-f94b-08dab27b9d04
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT057.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6666
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
Cc: Alexander.Deucher@amd.com, Yifan1.Zhang@amd.com,
 Prike Liang <Prike.Liang@amd.com>, ray.huang@amd.com, aaron.liu@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Update the gfx1037 L1/L2/L3 cache setting.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_crat.c | 53 +++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
index 960046e43b7a..6e699cb9971f 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
@@ -795,6 +795,55 @@ static struct kfd_gpu_cache_info yellow_carp_cache_info[] = {
 	},
 };
 
+static struct kfd_gpu_cache_info gfx1037_cache_info[] = {
+	{
+		/* TCP L1 Cache per CU */
+		.cache_size = 16,
+		.cache_level = 1,
+		.flags = (CRAT_CACHE_FLAGS_ENABLED |
+				CRAT_CACHE_FLAGS_DATA_CACHE |
+				CRAT_CACHE_FLAGS_SIMD_CACHE),
+		.num_cu_shared = 1,
+	},
+	{
+		/* Scalar L1 Instruction Cache per SQC */
+		.cache_size = 32,
+		.cache_level = 1,
+		.flags = (CRAT_CACHE_FLAGS_ENABLED |
+				CRAT_CACHE_FLAGS_INST_CACHE |
+				CRAT_CACHE_FLAGS_SIMD_CACHE),
+		.num_cu_shared = 2,
+	},
+	{
+		/* Scalar L1 Data Cache per SQC */
+		.cache_size = 16,
+		.cache_level = 1,
+		.flags = (CRAT_CACHE_FLAGS_ENABLED |
+				CRAT_CACHE_FLAGS_DATA_CACHE |
+				CRAT_CACHE_FLAGS_SIMD_CACHE),
+		.num_cu_shared = 2,
+	},
+	{
+		/* GL1 Data Cache per SA */
+		.cache_size = 128,
+		.cache_level = 1,
+		.flags = (CRAT_CACHE_FLAGS_ENABLED |
+				CRAT_CACHE_FLAGS_DATA_CACHE |
+				CRAT_CACHE_FLAGS_SIMD_CACHE),
+		.num_cu_shared = 2,
+	},
+	{
+		/* L2 Data Cache per GPU (Total Tex Cache) */
+		.cache_size = 256,
+		.cache_level = 2,
+		.flags = (CRAT_CACHE_FLAGS_ENABLED |
+				CRAT_CACHE_FLAGS_DATA_CACHE |
+				CRAT_CACHE_FLAGS_SIMD_CACHE),
+		.num_cu_shared = 2,
+	},
+};
+
+
 static struct kfd_gpu_cache_info dummy_cache_info[] = {
 	{
 		/* TCP L1 Cache per CU */
@@ -1565,6 +1614,10 @@ static int kfd_fill_gpu_cache_info(struct kfd_dev *kdev,
 			pcache_info = yellow_carp_cache_info;
 			num_of_cache_types = ARRAY_SIZE(yellow_carp_cache_info);
 			break;
+		case IP_VERSION(10, 3, 7):
+			pcache_info = gfx1037_cache_info;
+			num_of_cache_types = ARRAY_SIZE(gfx1037_cache_info);
+			break;
 		case IP_VERSION(11, 0, 0):
 		case IP_VERSION(11, 0, 1):
 		case IP_VERSION(11, 0, 2):
-- 
2.25.1

