Return-Path: <SRS0=WI/b=QF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70EF6C433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Nov 2021 22:12:08 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E23A61458
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Nov 2021 22:12:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2E23A61458
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CA5276E096;
	Thu, 18 Nov 2021 22:12:07 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2057.outbound.protection.outlook.com [40.107.223.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C1FA56E0CD
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Nov 2021 22:12:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eflD71cndU4EnFcyQZYANHRA2Lem8W7jIHygT+yhb50LiLxRZ9XIypvMHHgjZ3yfcl4sBUh9rJPV3fNXXjDR62AO7INBPltzUnC3lxsvfc0JXbjpbCVKUP37KHCKiCSStp2K+t8JdlpogfsFsF3Wl5I1XYwxYbGzYgscLNu5GnSmjdH1qH8d2eAzX0a3Cjk44Qn2zOFdoDFCX9xV+XgiOSu9OGsZ9e1K78pJhyzLlEo88zvtUqxGXdbeE3LBNErR8NaEfOK+XPCD0DQqd2btx3eVvJehWpWwA0gOzNusj3VNF+rhCNNapuZYpUGnOSgjAiLhN4w6Qra1ipUYMbb3lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B0y+6rTbj/PGRloUkSPt8tL0lKcT68UhmgEjfPew7jk=;
 b=FGQNjiia9hJD//HLyDN+bP20ODdMU8do3RijJy0RECZ61fJe9uiKCox3PB+QksOabnF8uQg0Mi8HJEr5MTy10SQEgEub1/1SXy4jTb1K5Vk6Kztxkt6quhr23cfska0BWpXLHGtPrvI9dkMrW+PCuUCtSGPpr+tdIy/+SZnRgr8D91xnEYFGRmoRE4WZXdJSVoHGu20AGO6Yv5b1YcAYe22XNH4PNT5+7UdPDmSyAZys51tZidO1n7pDsyut/FpXw919FsoVVl3qmkfRlXq/kEjGanrEHXpKNpZeRTRQPEsqdDhr0DBAU/x1wCMM3KUGUN8V3jeHTTAX9eG4G9HXyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B0y+6rTbj/PGRloUkSPt8tL0lKcT68UhmgEjfPew7jk=;
 b=CmHShlkjB2JnoNgenIbz8P/SFnJ6pB14XI3oqLK3kIddl9klNE5EM7ZyQLmXONzdPky6O7J8f9VmOjIkyUkKMlVRoIETQJujEetB49SQfp3JWkqMjYfAgW3gCJEcl0R1bir6QXtI/n01U+VMf5tfZRce9oHm6K29rwCmFf9c6IY=
Received: from DM6PR07CA0076.namprd07.prod.outlook.com (2603:10b6:5:337::9) by
 BL1PR12MB5031.namprd12.prod.outlook.com (2603:10b6:208:31a::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4713.19; Thu, 18 Nov 2021 22:12:03 +0000
Received: from DM6NAM11FT005.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:337:cafe::67) by DM6PR07CA0076.outlook.office365.com
 (2603:10b6:5:337::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19 via Frontend
 Transport; Thu, 18 Nov 2021 22:12:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT005.mail.protection.outlook.com (10.13.172.238) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4713.20 via Frontend Transport; Thu, 18 Nov 2021 22:12:03 +0000
Received: from RErrabolDevMach.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Thu, 18 Nov
 2021 16:12:02 -0600
From: Ramesh Errabolu <Ramesh.Errabolu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Declare Unpin BO api as static
Date: Thu, 18 Nov 2021 16:11:54 -0600
Message-ID: <20211118221154.31176-1-Ramesh.Errabolu@amd.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 60a80e0a-b967-4fe8-1840-08d9aae07360
X-MS-TrafficTypeDiagnostic: BL1PR12MB5031:
X-Microsoft-Antispam-PRVS: <BL1PR12MB50319182112DE641F4AF017DE39B9@BL1PR12MB5031.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:497;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JoW3Jd/mmvpij7zSQ31v6rGt/3zPrcglHLJWZkQ4djXUhZzbb+Q4+FrLkb4rK7a6i9odsxqlWLn8Io6djmDCovyKzQxT2VbV3tRqLd7HFua+f2M/2ZnNNv1fLmFGKaSJ3WLrjc0Q9y5sEcvJCdaBR5WI9hIo1XUVaCK08r/STaL8OVAFZIz59IuhLnInOWoScu0l+IxMINMvdAicxIKIYtoF/6aOVqTJZry6ffPR0KeTxKgVqbBsPkm/44Maa5wdpOiV4O6HUzNu+r+4XldfJQtD+6eNceuuGTGQsO/Jb6m4pADU0mfi4P9wcW10cOm08f3CgF3y3jAKtEynppmvQXgRxY92yaFJWTrlwKGcBTAc7IXhsvSUwpXKGvNZvJth2RdY5RutBUz4gUQ35pjCRtbuSYW5+HQM30+QFRQTDGix7Sfk20SBwhdwdovcpVqdAWC2tOD/kmo2MOsajykOAInl6hi2P2owfmExZxkr4WHSomlDY/yAO7XfiqlHhTuXznXsqKOzn0Was/ZU2oLUTyJ8GoylNVjf7N2FJAfE1kx8XwQtceiBLANyUeVrkYBThRE7WubHwLUqYO23MXvCnoCeRbI/BmfgQqNm3wBfCJPsb+GbhdprSX2c87aBlPjQfnu/kYbAVVrTU2MzzecPGO8l6EPDlvS/XV95aIOTfTdwdn7Ty5uHGAe+jbVvsSG/9SIO5DDQnHw5B8am3Cqh+0R8WPXFRmeXn7yFcfxD7Ko=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(47076005)(70586007)(336012)(356005)(426003)(6666004)(70206006)(186003)(81166007)(36860700001)(54906003)(82310400003)(8676002)(83380400001)(508600001)(5660300002)(16526019)(26005)(8936002)(2616005)(6916009)(36756003)(86362001)(7696005)(1076003)(4326008)(2906002)(4744005)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2021 22:12:03.3900 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 60a80e0a-b967-4fe8-1840-08d9aae07360
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT005.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5031
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
Cc: Ramesh Errabolu <Ramesh.Errabolu@amd.com>,
 kernel test robot <lkp@intel.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fixes warning report from kernel test robot

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Ramesh Errabolu <Ramesh.Errabolu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index 90b985436878..3463e0d4e5ca 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -1332,7 +1332,7 @@ static int amdgpu_amdkfd_gpuvm_pin_bo(struct amdgpu_bo *bo, u32 domain)
  *   - All other BO types (GTT, VRAM, MMIO and DOORBELL) will have their
  *     PIN count decremented. Calls to UNPIN must balance calls to PIN
  */
-void amdgpu_amdkfd_gpuvm_unpin_bo(struct amdgpu_bo *bo)
+static void amdgpu_amdkfd_gpuvm_unpin_bo(struct amdgpu_bo *bo)
 {
 	int ret = 0;
 
-- 
2.31.1

