Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A574C4332F
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Nov 2022 05:52:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 669D310E37A;
	Tue, 22 Nov 2022 05:52:45 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2060c.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8a::60c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 77B0610E37A
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Nov 2022 05:52:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fkSKsX8jUE3fQciJ7SrDm8ciiZo07l67kk2ARIbp9+/PVFLTo61Lay06JsvtEB+herSe1B7kqRDo5IPYpMDmbHSSWYQ870apTUPdmh8Jy7eelAFJy0dd8xUClBBY8nSh0dBt5k8pt+LyKjW+lNFUeA3RHSfJhap87BRxCikoxIuAFH4Y3dUe2jMHX5npdiDbHlna8ZjA6RVAaEG4/Ip8CofNHr0jMu7OPtjjjTScvNCHea1Z6wJ/KA1Kr7Gfm+trhErqEEY4uRhXD9VITANEigznCzJtdpJ8bnpoqZb52stZ6xxErr3ZzQQKlXPnYCCHLO/qH7vId9IhjYTUuoy+Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Maps9qM/tQ8huca5rOG+NOqx1RphGBjVlM4+GbodD1U=;
 b=hkPdB3ZHGPfPZgKcDCYs8UrDQoCTiW2JcSyXtzG+DDgwOvek6U+C18UjoRwDM9QvXqL1aGMHZCKNKpD1v7D7P1IJNX+Fp/ajVyDRp7BbrTiFr23XBOBXCwrBB228MEVijEMleX+g9aUOuQRX2zqbml0iH0Vs3oCCs4dA2jakN4DhNiccmAehy/WctAJdR3UhmVRbzHPH8C77olm0oWpWFVseHHY/7pm1HhsehmKgzUr0t3hZsiGHykWB8KlBdFYeCBUsSDG7bqIxDhx3V6QHzUEzWj2dMlabHETrNIR13s97aGlDCQPnKUGtNNJetFQaX9LQfNAcGTmPC2UeR/htSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Maps9qM/tQ8huca5rOG+NOqx1RphGBjVlM4+GbodD1U=;
 b=bxooul4PcN8bw593s5u9cgSa124pejTU9B/jFCQGuFOrIVI+U7RFnzSv6fBlzOGHV0rz0VDsgOk7MZNMANmBwRKOB/yb3DVHHZDv13EZ+9rHYnlZa9Gm1yXx80VVEqq2yUdKOYau3o266AcerrEbCMirCt7L1gNfqXAdHUmrVFA=
Received: from DS7PR03CA0016.namprd03.prod.outlook.com (2603:10b6:5:3b8::21)
 by SN7PR12MB7450.namprd12.prod.outlook.com (2603:10b6:806:29a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15; Tue, 22 Nov
 2022 05:52:36 +0000
Received: from DM6NAM11FT023.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b8:cafe::11) by DS7PR03CA0016.outlook.office365.com
 (2603:10b6:5:3b8::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15 via Frontend
 Transport; Tue, 22 Nov 2022 05:52:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT023.mail.protection.outlook.com (10.13.173.96) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5834.8 via Frontend Transport; Tue, 22 Nov 2022 05:52:35 +0000
Received: from yifan.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 21 Nov
 2022 23:51:51 -0600
From: Yifan Zhang <yifan1.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 05/19] drm/amdgpu/discovery: add PSP IP v13.0.11 support
Date: Tue, 22 Nov 2022 13:50:11 +0800
Message-ID: <20221122055025.2104075-5-yifan1.zhang@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221122055025.2104075-1-yifan1.zhang@amd.com>
References: <20221122055025.2104075-1-yifan1.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT023:EE_|SN7PR12MB7450:EE_
X-MS-Office365-Filtering-Correlation-Id: 24661964-d876-4623-4027-08dacc4dc1a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pnkuPYy7z4qh7QaRjgK/fkX94N6Y6BT1jNRmfq22mfmdekUswuoRglmxL8541xACFkx4DPSqc9DGjb3fx3uzDwEzkyR7pk11earnwjs/RF9/DPbR761ZECTkRPS8+h4d5KDdukZLzXnn39CNrgzzQIirqPUVGO7CCnQYcE9z78ObREEQnpAyuP02eQa4/VQaayZs5fRKs7CdjOVc+vRz1nf7zH70DpZ9x4XIwfqs29tbziFgOzCIRp1Hs8XGuv+snyz8KOIVXBcwXqRZnD3OR1ANsNSIVR/1/5gyGA5muJACFeVhvEMEO0M2b+WGQoZ3IvwEVlyDM6QTSdLXMMp1eUEhyRk+JzqBFcEAWZQySR3oLdXYBpAs1oc3fqXq/DI+UjXYgm+Wut7gEKbzVw0HbdXGoJ3MMb+56YomspccB11+xyQ16I0VBAgpBss2oiU4AJ4K5Wky2AhbsEc85RkZ5Vtd0WaamAQofKEqRz4u5D0LbewwuZ8XM5BYE2lAaLhC7C7xDJ8GtwmoRz2n+Ii4+7cygk1xPdvV6a3ORmMs1qZL/OThsScC60XALeOYxYylFp5Hsw+9X59vIrX4nvpeMhf9Gb/poLXgV9hN9aKR/jKqHPGrz5qAgUWzGXyqrNnm2el+8JbiO2uzXUIfbboj/6fyzutNPptrN9k7mK3EvikbZ4IRzxZM/S6OlztYmFSmcuRd6LVz1rS7pM3exvge6+n0GEHpzmpjFlaGVx/n7m0=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(39860400002)(346002)(396003)(376002)(451199015)(46966006)(40470700004)(36840700001)(8936002)(7696005)(70586007)(6666004)(26005)(4744005)(40480700001)(54906003)(8676002)(6916009)(316002)(4326008)(36756003)(478600001)(5660300002)(36860700001)(41300700001)(356005)(70206006)(40460700003)(81166007)(2616005)(16526019)(426003)(82740400003)(1076003)(186003)(336012)(47076005)(86362001)(83380400001)(82310400005)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2022 05:52:35.9011 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 24661964-d876-4623-4027-08dacc4dc1a6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT023.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7450
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
Cc: Alexander.Deucher@amd.com, Tim Huang <tim.huang@amd.com>,
 Xiaojian.Du@amd.com, Yifan Zhang <yifan1.zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Tim Huang <tim.huang@amd.com>

Add PSP IP v13.0.11 ip discovery support.

Signed-off-by: Tim Huang <tim.huang@amd.com>
Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 45fe805b5f5c..49ed3c826088 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -1643,6 +1643,7 @@ static int amdgpu_discovery_set_psp_ip_blocks(struct amdgpu_device *adev)
 	case IP_VERSION(13, 0, 7):
 	case IP_VERSION(13, 0, 8):
 	case IP_VERSION(13, 0, 10):
+	case IP_VERSION(13, 0, 11):
 		amdgpu_device_ip_block_add(adev, &psp_v13_0_ip_block);
 		break;
 	case IP_VERSION(13, 0, 4):
-- 
2.37.3

