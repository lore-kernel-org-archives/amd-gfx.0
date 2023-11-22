Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 754D9C27C40
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Nov 2023 20:29:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0FBD510E314;
	Wed, 22 Nov 2023 20:29:24 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2040.outbound.protection.outlook.com [40.107.223.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CB59310E314
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Nov 2023 20:29:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M7Z1SVHl+hMhz6HpwN/nLuRRJpJcl/b5fyRT3zTLH45vfcEGXpuvnhSPNknJ1TvFn2KKCsQu61WzSGYm7m3TT8LZDW690Lkw5K6ZJ1gRMFE4TVCsdozr73OgcLCjAEqfJh//swRH8OnFjhvbhs9Edea7lWwRaHe3Ueb+PqNaOwc5/Xq+su918ewQrTKWo+Yd/Xpyzbs9WFZtEmd4xTgQR1mrS8BCeY5i6J6fc0euXieDcShHQ78B2PTAs0g5nhZ5bwnjWIVyxnpskYa+5757Ux99fd7iTdqVJIXs55z9VPDrudxPyfDAz0QmkrPkMkw4oMlCmyhZifE9wnOtAx0Agw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oxWBP8VyJ1S3GNgfLnzwqRlVD1sCMMsIihRgQl8nrV8=;
 b=EI5sx1zJvn9u4OaovpZs2lw/stCHL0he/1OC3EH3HJczKBH4+IpgNID2DS8lwijv6PudMZmCnQIwuEmFEkfxKdyNR8MVmwo+xWjI1hySrMlNFaoiYX+XdVu4pJOnEf1Q695MkmaiuPWBtKduCpBL5ofuYEenJdTrGzk/5HLx6MV5iJ7TjaBN1z9PbnfYq7dta3MAU6aQ5XQsL160oS1+uGIyKgPTIejulqnsa9dCs08FcIldKKGxUkG/tYy+Ps0HzoBr+gHh6m+rEcMMvl+LAuS796TQahprZvnKmUkPCfeWcPS+KInTcmBOqSHd3CZuecWw8GKyq3Txvp3gvtC4MA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oxWBP8VyJ1S3GNgfLnzwqRlVD1sCMMsIihRgQl8nrV8=;
 b=pEbVP3VPXVtLVeLUsFUVZKYOYec2gLoErgGJzytxX4BKvnujMydvIrUCRijFryktKpN7l7M7HU2Up5QiSbHwciU5KB8A91vbuim0xpbJeGkr4yLOThWFC2EXRFegk/oILcjb7HXGWYtDWzvZ4h9WE+wVDfl0UV5xPl4MmayhUHY=
Received: from BLAPR03CA0073.namprd03.prod.outlook.com (2603:10b6:208:329::18)
 by MN0PR12MB6032.namprd12.prod.outlook.com (2603:10b6:208:3cc::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.19; Wed, 22 Nov
 2023 20:29:20 +0000
Received: from BL6PEPF0001AB73.namprd02.prod.outlook.com
 (2603:10b6:208:329:cafe::37) by BLAPR03CA0073.outlook.office365.com
 (2603:10b6:208:329::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.19 via Frontend
 Transport; Wed, 22 Nov 2023 20:29:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB73.mail.protection.outlook.com (10.167.242.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7025.12 via Frontend Transport; Wed, 22 Nov 2023 20:29:20 +0000
Received: from mukjoshi-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 22 Nov
 2023 14:29:19 -0600
From: Mukul Joshi <mukul.joshi@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdkfd: Use common function for IP version check
Date: Wed, 22 Nov 2023 15:28:51 -0500
Message-ID: <20231122202851.1177584-1-mukul.joshi@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB73:EE_|MN0PR12MB6032:EE_
X-MS-Office365-Filtering-Correlation-Id: a3ebeecc-4030-4e18-fdb5-08dbeb99b54a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sLumMV52tVD98Z7AM5FzwDFzXZlklPXOXpjNGCTqf1vgWKpUaimlzWhu6p3cyivacwSHnhThw0KH9eljB2oSqPcVS+XifnltMwFFiftbbS1hZIcZ4hp5y8YcJZX25d4dg7BVmUhcUSvyKnmmyBXB48B94CtjvXPMUhseZygItlkV0Ay74mkXiEOVR5E9+ZfRCaiAxF3d+0CKejqNEzOUt5IjbkG0+8pIkUdtI94QQsVwWLemmVgU3L5mezxmofDOzjRVnfJd2Bywer1dASZD0kZyu67XrTcSZrfb6pSYq85PfEYgbLuflnUbI9jUvsYX+d56mCf0Sv7qP/BA5GuRxdOysTPF9ZnuunZ//4g4ltwfMzWLsEY/daVZvq8H1LqITrrmn/t/vTomnKxbkEIQA2C7Z9ZMIP/PxKRA5gKWifIk65TlMlTxJxBD5T8kbEJOCISJvHqGUkWfxC0DcOwViE8kuFTHVEgDk5erLMu6/wKTaME5pAV4jsvSIl/khFdGbAxUrF41BO3XzpTGL0QNzMC2h5QzoMECmLW3DaSBLtVBSyhcOukgiUxBc87sejjS5xCW+8APUV6qmPk2dyde34gXBSw7HyZULvQaHLkqs3t462FNrI60kYAZiOQIj7h7mfW/6pXbYNmKxz81wwGqxungrOPJiNvCYYfftoGIDfMAMpPdUX5KaGUZAHp6Fo3MlNbSTSM+4YmgkeTmcv+BwCbiTl4RtsOmwk8FBD6/on3FEFO4qhl9BoBwb4kGQJvLOoIu/Wbs1ZDHGqnqm1uTNA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(376002)(346002)(136003)(39860400002)(230922051799003)(451199024)(64100799003)(1800799012)(82310400011)(186009)(36840700001)(40470700004)(46966006)(40460700003)(356005)(26005)(2906002)(83380400001)(1076003)(16526019)(336012)(426003)(2616005)(6666004)(7696005)(36860700001)(47076005)(44832011)(8936002)(5660300002)(4326008)(8676002)(41300700001)(4744005)(478600001)(316002)(6916009)(70206006)(70586007)(54906003)(86362001)(36756003)(82740400003)(81166007)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2023 20:29:20.5921 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a3ebeecc-4030-4e18-fdb5-08dbeb99b54a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB73.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6032
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
Cc: Mukul Joshi <mukul.joshi@amd.com>, Felix.Kuehling@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

KFD_GC_VERSION was recently updated to use a new function
for IP version checks. As a result, use KFD_GC_VERSION as
the common function for all IP version checks in KFD.

Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index a40f8cfc6aa5..45366b4ca976 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -1127,7 +1127,7 @@ static inline struct kfd_node *kfd_node_by_irq_ids(struct amdgpu_device *adev,
 	struct kfd_dev *dev = adev->kfd.dev;
 	uint32_t i;
 
-	if (adev->ip_versions[GC_HWIP][0] != IP_VERSION(9, 4, 3))
+	if (KFD_GC_VERSION(dev) != IP_VERSION(9, 4, 3))
 		return dev->nodes[0];
 
 	for (i = 0; i < dev->num_nodes; i++)
-- 
2.35.1

