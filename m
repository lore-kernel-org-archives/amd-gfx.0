Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 210A5ECAAD8
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Sep 2022 18:47:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3164010E723;
	Wed, 21 Sep 2022 18:47:51 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 28AD610E4F9
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Sep 2022 18:47:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rhkj+9kqpPMPE8kM00G0Ue2OaMYJRczS4tNyKxpn8l7hz9YNDm+hkILEYsiv4T5ZIeVmgNE3bBwTLmN4uYJZAN2SX/iO3XLTRU7QtC1keLOsy8yYJStJ5rF2hHkG3TOBtrEltM5iCc6UAwe6LMPg3Vw4QeW6YfDR+rSK86/KKi6WUWFamv/rd7MDv/5EciFuhHQXh1ZcUt5KjMyW57GCq/mMl86Uj2DKE4/hMM2LTul1v1TXf6HN65iwiOG1ll3VdEjbXV2e2QjAc4AdXMrW4f8slcleTKyMQi4sOCpjJe6lc7dzLifca//j/OKSgAdFTTPILz3nIkjcuvfIonb4oA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zz4sRBjo/kLyxN+K6c3jAgbeK6ngoCgWKdzQ3MRJiE4=;
 b=beKxACmJ6MN3EMgH6hjfwCQLx1SDPHThYBUJoYfq6fsifwTvbEpumAvbZn7dje/vTjDazsUJprJ6HcoWhQLHynQRoQUyd40avWBmVEI+ZBd4YLCOfKIQD6kvhGImXSnEIHs51KOrDZaEJ3aehixhc+nh0pMEMOYwdS2wX1SiHxte2zkj8wPzGasaHU3XXseobdIbYGIOsOktvPo6PRAWa4vDEr0RDiH2sXg5om/HQ61TlvcTwZwizc2reNkQfYLCaTZwe0wbtimg0CzkEy8NFwkVa+J/HQ6N+i0p8sK1xn75lhfGhhiiG//G4itO2KWfbOzQYxG5KPn0vw/pV6PzQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zz4sRBjo/kLyxN+K6c3jAgbeK6ngoCgWKdzQ3MRJiE4=;
 b=hznyS4MhWYX7+RL9Rhmis4wyiPV7TPqpi7/nXvUXsL6ljgf3PFQm633UeceSVOZrTmUbIzALnd05ARksBAFSKliCf21TwZ1H4sUw1OiA+ec3g1wVCnD3jwx/LDdlv9MQYFHRljRRypU5D0zhKHm5Fm8nWVp0RwQ0kbOkiPJZ8zo=
Received: from BN9P220CA0007.NAMP220.PROD.OUTLOOK.COM (2603:10b6:408:13e::12)
 by DM4PR12MB6038.namprd12.prod.outlook.com (2603:10b6:8:ab::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.19; Wed, 21 Sep
 2022 18:47:38 +0000
Received: from BN8NAM11FT020.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13e:cafe::55) by BN9P220CA0007.outlook.office365.com
 (2603:10b6:408:13e::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.14 via Frontend
 Transport; Wed, 21 Sep 2022 18:47:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT020.mail.protection.outlook.com (10.13.176.223) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5654.14 via Frontend Transport; Wed, 21 Sep 2022 18:47:37 +0000
Received: from mkgs-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 21 Sep
 2022 13:47:37 -0500
From: Graham Sider <Graham.Sider@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdkfd: fix MQD init for GFX11 in init_mqd
Date: Wed, 21 Sep 2022 14:47:00 -0400
Message-ID: <20220921184700.617748-1-Graham.Sider@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT020:EE_|DM4PR12MB6038:EE_
X-MS-Office365-Filtering-Correlation-Id: fb6bebb6-6aa8-4e06-3268-08da9c01c14b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: x3i+fg5moDf/I+44bbOujQ1373jOCG1FXHJgHzDr1Y1PltrGstlmNAFiR2CrgRoK7Iba/yuyAB4iuCU7Vb8poreXT+CRwwJMZ8apnLrW4eVHGPfXS8XyrEuWUqway59n5s6adZ2zzXQIW9+VJ1eeCzgw/ZgRqJCkouiSSlrVyOXUx8FFs0lkakhFj3Bk5DA9yn8jtki4Akc6nmG4D0HQIXEW06uUdvdyxsaF29qGOPmIqzFZ9OQ4B9MkYGXx7lkiZW+TooyqAhsbHI5OY07vHKWT7XoKcCDm7VjlHNjvAgKCJg0l0qJQno9cbu2Q13rCU1V5sXErKyHpzwrNvB6Q9+OHt5UR7DtyNaVP+FQVCrjOaAT9GrJlCF001QxGD5nnyq18FSfZcB7xzlPNOqzhDHeudtGOcSv85bIHJH+QXgpZeM3E1yrPH4f1MzuZnEsDgHac2RNzI3Y8uLQ5dznjrDkZ+C+SNRf5SN+y5B4P51V75eoTN2T+90VRoTJsPxm76s3YW1uyMkg4Uw7hhivgDW2tv32yYac58IA0D9aPPJ23/8wZQXN9yHHcD20QLibqqsHzUsBsF3Svmo98aV0KRPiikQJuYehR/p8zkRrcSSev3lxQDhE467y5NdxfMXV47FxMErBW3w1wk/wW4SOZaUwFuP6Fr7F2EIed6k/ehiZeoUoNzLDgzY8rD8ioXKsiX4CkeNEpY2QcNscWalOUFejaXjVlm/v0V8LZbZf7tBuMI3HelTFbTmcArPXseg8e2gV3iUX5BroWw7nxPxd35U36Mpt7TKvSoeOc2TqyMC0=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(396003)(346002)(376002)(39860400002)(451199015)(40470700004)(36840700001)(46966006)(36860700001)(82310400005)(82740400003)(36756003)(40460700003)(1076003)(5660300002)(81166007)(2906002)(356005)(478600001)(4326008)(336012)(70206006)(70586007)(8936002)(316002)(6916009)(54906003)(47076005)(40480700001)(16526019)(186003)(6666004)(41300700001)(426003)(86362001)(2616005)(26005)(7696005)(8676002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2022 18:47:37.7552 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fb6bebb6-6aa8-4e06-3268-08da9c01c14b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT020.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6038
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
Cc: Felix.Kuehling@amd.com, Graham Sider <Graham.Sider@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Set remaining compute_static_thread_mgmt_se* accordingly.

Signed-off-by: Graham Sider <Graham.Sider@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c
index d982c154537e..26b53b6d673e 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c
@@ -126,6 +126,10 @@ static void init_mqd(struct mqd_manager *mm, void **mqd,
 	m->compute_static_thread_mgmt_se1 = 0xFFFFFFFF;
 	m->compute_static_thread_mgmt_se2 = 0xFFFFFFFF;
 	m->compute_static_thread_mgmt_se3 = 0xFFFFFFFF;
+	m->compute_static_thread_mgmt_se4 = 0xFFFFFFFF;
+	m->compute_static_thread_mgmt_se5 = 0xFFFFFFFF;
+	m->compute_static_thread_mgmt_se6 = 0xFFFFFFFF;
+	m->compute_static_thread_mgmt_se7 = 0xFFFFFFFF;
 
 	m->cp_hqd_persistent_state = CP_HQD_PERSISTENT_STATE__PRELOAD_REQ_MASK |
 			0x55 << CP_HQD_PERSISTENT_STATE__PRELOAD_SIZE__SHIFT;
-- 
2.25.1

