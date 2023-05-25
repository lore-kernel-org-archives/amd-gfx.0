Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6487DC7EE2F
	for <amd-gfx@archiver.kernel.org>; Thu, 25 May 2023 09:28:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D004810E141;
	Thu, 25 May 2023 09:28:43 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2072.outbound.protection.outlook.com [40.107.243.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7C08110E141
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 May 2023 09:28:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O6piTZzrJirQq2I78o/AmpIvu+j9uFCQ0qBO7i+TbdVRf7OB/PVm9XfeL2exo016z2vwxa4qcqDpPpmYRsYjcGNyqFNNfXA41GRokxLr8k3fuSPyGd594yon3HcFPtcuNDLCjJ+oFsSuGe8HXfppRcrqsRecaXbhELe0Mg1CZWOO91VCjxE7a3FStTI45G5Exu2OND4Cz8kYxncjmIZg2J2XBMCQGAMYn5IzqnRRK1LtalrdbIysMO+bCPTnnsH3i085Udw4z5S66NNKXXfTHbVtWm3YeGunsWNGMP8Btr1ZSE6oUKhA/bhNVnnOpPOmR4yJVol5OPuxXXxItEgPQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q668iZWviCmd0LNiSDfNuA7eZqNEm7zdbHGvW1Ee8+M=;
 b=gPIJNr5Mj/M2e2WPH2P4XJihImv6JPIAgw0iQrqlaR6z7GicCmHYvGBMZgCFEa4TOZtu8yomZLSnbuGhuAbLSw4ISExLZbcTNS8zNDeVGPRKj1GO+CpmXkKLigM+WYyQK/MAyOGXMX/Dr53232hFxBazGSLkOmuujqc8d1j8W8q+be5aLR3enSZxZntRiV20l2Qq8KW0H1Ty7pW8cC05Gc9ha+UvxPTftfesfsGRd5bcEquEeO3zQ2WkmTYGD8JphY/B0ZaXyLU/EwoAQNjvwQw/+shuBCv0kly8KEX7RdWn8FeF/9zbeDQIH8disG/4CHZX2uGxBhP72W3SFsN9PA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q668iZWviCmd0LNiSDfNuA7eZqNEm7zdbHGvW1Ee8+M=;
 b=B4c0bMWNw3TGxLVu/XyJdcQ1/VSmEf814vBZZbNqNJ4I4Yl4/xKtmKW0+i37H6YfovdGeJpFSQS7uVHGfSZ4icIOyMM1LyBzih6OuYtgQbgFHt7hHjgMTm+zZTsBxTMfo7dnECOTCmHRauKwSu40gDBOO0Dcb2Xg8zoAcLszzqQ=
Received: from MW4PR04CA0159.namprd04.prod.outlook.com (2603:10b6:303:85::14)
 by DM6PR12MB4434.namprd12.prod.outlook.com (2603:10b6:5:2ad::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.16; Thu, 25 May
 2023 09:28:36 +0000
Received: from CO1NAM11FT111.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:85:cafe::6f) by MW4PR04CA0159.outlook.office365.com
 (2603:10b6:303:85::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.17 via Frontend
 Transport; Thu, 25 May 2023 09:28:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT111.mail.protection.outlook.com (10.13.174.61) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6411.30 via Frontend Transport; Thu, 25 May 2023 09:28:36 +0000
Received: from guchchen-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Thu, 25 May 2023 04:28:34 -0500
From: Guchun Chen <guchun.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <alexander.deucher@amd.com>,
 <hawking.zhang@amd.com>, <christian.koenig@amd.com>, <bob.zhou@amd.com>
Subject: [PATCH] drm/amdgpu: keep irq count in amdgpu_irq_disable_all
Date: Thu, 25 May 2023 17:28:19 +0800
Message-ID: <20230525092819.2471715-1-guchun.chen@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT111:EE_|DM6PR12MB4434:EE_
X-MS-Office365-Filtering-Correlation-Id: a17e7d09-3480-41c1-b329-08db5d026ac8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: G3OtCDbwHRIBItS2VqYhlXRCVEyE9qPMqiGQVfrN+Inzb18jlYv8dycMxam5QN4UnN4ls5xJhxXNEi/Mw5eGA5hGeHYEt1WwAUtNjYRV3tChI5Ag9xM2e/7ELn4wfB5QA470aUiq+tPVTlbEyxbX6RbvgKBnzKmFpuD4fPAZlsd3KQdaWdKRI7oQmm7JAyrls8fNJnEpsH8e8iuWM8diLu4jOuxF0J6MvFVeSucTkiECqcE00o/ou280bbq8w7OOoMqRDuYOUcI2Jig4HA4APkBOGpVH3G29PZqIKBTDgmOzYyN2im9vu4Fr+eeihNK3AYMdpJFHkVCbgLII1oVjT2dQfF7M+ZRVT4bnxAjCzEpW3sRlph8x9ksE1f6OzXEAafHC+H3TmxMwiKAuOarwRwOm6gvuYJsDzzczHRhVquqw9qGW84BqLkAHAnPDGOkxCpFraWWSNSqnUrSP+yU1QbQknrkm2RtunUGbi6OChgu131IqfgHyAI7IgoJdCoYJ3wtOeXTXu9CAbKp66myUMmmQGeOG9C1AJIet5ut76NxB4tigetay+56N7XcUHrZQSqXqeARLQoXfCWfEyZzeet2AJ3C8dtQJCO/1JEsJmqVCp73TDO/LQfsS69+ge0xCypeov6nK2ESaLtV5CJEV3Fd68g2FygVtVKtTjUcfIY4P82jD2BR4kgFyL7v9Y/T4GyzvQlumiiXvGQtcmbLmWtjrlKy2mQh4+3BbUfHn0yJ/tzP312h2KlA4mASMfjNjWrSxdq1Mw0mfRvz7mgMi/w8Hm5cEfZmrraLPoaIh3ao=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(39860400002)(396003)(376002)(136003)(451199021)(40470700004)(36840700001)(46966006)(40460700003)(70206006)(70586007)(478600001)(6636002)(4326008)(110136005)(316002)(36756003)(86362001)(83380400001)(47076005)(1076003)(26005)(426003)(2616005)(336012)(36860700001)(16526019)(186003)(5660300002)(41300700001)(8936002)(8676002)(44832011)(4744005)(2906002)(7696005)(6666004)(82310400005)(40480700001)(82740400003)(81166007)(356005)(36900700001)(2101003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2023 09:28:36.4506 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a17e7d09-3480-41c1-b329-08db5d026ac8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT111.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4434
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

This can clean up all irq warnings because of unbalanced
amdgpu_irq_get/put when unplugging/unbind device, and leave
irq count decrease in each ip fini function.

Signed-off-by: Guchun Chen <guchun.chen@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
index 00f2106c17b9..f90920fbd340 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
@@ -140,7 +140,6 @@ void amdgpu_irq_disable_all(struct amdgpu_device *adev)
 				continue;
 
 			for (k = 0; k < src->num_types; ++k) {
-				atomic_set(&src->enabled_types[k], 0);
 				r = src->funcs->set(adev, src, k,
 						    AMDGPU_IRQ_STATE_DISABLE);
 				if (r)
-- 
2.25.1

