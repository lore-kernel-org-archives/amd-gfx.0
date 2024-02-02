Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AF10C4828F
	for <amd-gfx@archiver.kernel.org>; Fri,  2 Feb 2024 15:46:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D9ED610EC47;
	Fri,  2 Feb 2024 15:46:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Y7R6Nxkj";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2045.outbound.protection.outlook.com [40.107.92.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2432210F070
 for <amd-gfx@lists.freedesktop.org>; Fri,  2 Feb 2024 15:46:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mVVn1TMBcuP8ie2CNZsMyKQTSZlzYG0z122egUMltxMvqVRuiGITSbtRPEkw3uPsK1vl4ntxX0WFwROPWVTuOu22XeGTtctr4RHEO0b3aksGpf/S71hAhDE+Kt1bpNPBgQewchMle8nfZy/StmlhL+5Joxl9O2Z/4HqlSJTyzcSANVMHOpujswfqsTPjRQEHXhEpl6aCgCvlVBn2WZb3ELsbjbY7HFteBDwyH9sLFMNVb8HW6e3cgTofVRBQSp1LgTjwLu7c425yvgeG2XfxWtqjcnut6ymVQtTlJmuoC1AREblx+OmTtWBmPFvF7ghts6LHI0grCGDpjLsVTQm53w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O0dxbLOD46ErP79MD2n/opqw6kIpTiBpJjMzax+d8tI=;
 b=mS5M0YdKLB0LG7UhVyhGlLU5yC5lvNcUW/OF3By8ZZj5dYJAbVdgXS7016qzCuGJCIamqFkgsUoX5YbuiG37yqDPiz9wraLbfEZdFGOMofmSkenQiSv2UGbMeWJXqDOULxee7wpB1zcN0Z2yzEjo/mvMz/z3VnfVjekjYZQU7lXGuG22Rld2ru5dbNYjIvt13/sM4nJBpFu+BsDMgwYpjqsLA8vGHtPE5tUEC7xMtmPN4FuW/yBP8QMu1kETcIzBZqXzFI14AetFgt97gGRLyfn+baYVz2spqH/Jm8JRk9t+QSJVnMUK7F3VLj1U0gym/ALIUewzbX/WVSv6tr2fYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O0dxbLOD46ErP79MD2n/opqw6kIpTiBpJjMzax+d8tI=;
 b=Y7R6NxkjLFaZTBQWM/5ifwEdVNQ/9P6eqmmRFJXTCtLJV8gpLKe6MDevwyvjJH8X9wXMinheZSKYlNdloc1RSZtDNjNEmd37UBdF5/lSLPRaRd6jekSWfOE0zz8R9wWb3rRnzVITeoWHGtIQ+STtJGy/UbF9ia8Hv6Nqlw4NB+k=
Received: from BL0PR01CA0006.prod.exchangelabs.com (2603:10b6:208:71::19) by
 MW4PR12MB5604.namprd12.prod.outlook.com (2603:10b6:303:18d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.11; Fri, 2 Feb
 2024 15:46:50 +0000
Received: from BL6PEPF0001AB74.namprd02.prod.outlook.com
 (2603:10b6:208:71:cafe::45) by BL0PR01CA0006.outlook.office365.com
 (2603:10b6:208:71::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.22 via Frontend
 Transport; Fri, 2 Feb 2024 15:46:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB74.mail.protection.outlook.com (10.167.242.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7228.16 via Frontend Transport; Fri, 2 Feb 2024 15:46:50 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Fri, 2 Feb 2024 09:46:48 -0600
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH v3] drm/amdgpu: Fix potential out-of-bounds access in
 'amdgpu_discovery_reg_base_init()'
Date: Fri, 2 Feb 2024 21:16:35 +0530
Message-ID: <20240202154635.1643762-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB74:EE_|MW4PR12MB5604:EE_
X-MS-Office365-Filtering-Correlation-Id: dc10ed0f-7931-48a6-f93b-08dc24062bd8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: u7ehmyjmU83+CBD8eKxrP+X8sTfTyySg62dVT1QqaJYElAbmIcJV+bJLSJ3oZIAdhpF+xPXvg0AVtO/YRg66ibHFcva/RN0rTNXGxQ7lh+IDV8Fo6bb8ktZLBS2zfk0DC5nW7B8s5IkoKfDsWR00yhVE3fe0cSHYhf8QKjU5AmRFvgdbGUBAr6rZwk64IHvNDcqcnsHDia6ldnnNn75YIwEj+59pT2JQqtRSpSOyIzyTDGj+PGRQDYkyBkoVjMqEwEiE9ESpAjuJwerlz1zdNmUvNZBDz9/gIl7foditNYmY2SbGFlLhHbZsvb/wwqcxxCbU8q4qhQJQ5m9S8XhG1rkcfi0q5sjUV9mxt0IG3LcSIzDriQJ2d0aQJyKroonSs5ZaoOpv27aTAEwxryPibX4RGbcay9rXqBI6LlFSigQywmkl748EAMmqwRskHMLze2gWmpuVeJReQUVw6+BS0eaKGTEFDKZGO9xMUhCPimcYmINfFNO9yQBhZvI1XCba3Sy1Pc3aebXe+Vf3RDnq4jxRhugS00c9ZQfMn2w6NMnK+0o1VshfenwjAuQwItKoVg+M0RtcGEzJkyxoqJsUvTa+lP91vXJ9GB4Mkmg0zwV7GVVPZzzqaaAm5T0WQDtit7PKmQUGsSjJHmcjn847Swszdw5Bkt+6dZyTKCZyxHGAMUKK5V1HOySgw8sSpMhWo6bf6DaMysJz8mxy41JWkIvBI/2OY6GIRpxcci7Re0SNhEFRfkXnVPUUpQCyInS3nlw2/4PPwpb6hz4nrDGroQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(376002)(396003)(346002)(136003)(230922051799003)(64100799003)(82310400011)(186009)(451199024)(1800799012)(40470700004)(36840700001)(46966006)(40460700003)(40480700001)(478600001)(86362001)(36756003)(426003)(356005)(47076005)(81166007)(54906003)(2616005)(66574015)(82740400003)(16526019)(6636002)(1076003)(26005)(83380400001)(5660300002)(2906002)(316002)(4326008)(6666004)(36860700001)(70586007)(7696005)(44832011)(8936002)(336012)(70206006)(110136005)(8676002)(41300700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2024 15:46:50.3342 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dc10ed0f-7931-48a6-f93b-08dc24062bd8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB74.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5604
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The issue arises when the array 'adev->vcn.vcn_config' is accessed
before checking if the index 'adev->vcn.num_vcn_inst' is within the
bounds of the array.

The fix involves moving the bounds check before the array access. This
ensures that 'adev->vcn.num_vcn_inst' is within the bounds of the array
before it is used as an index.

Fixes the below:
drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c:1289 amdgpu_discovery_reg_base_init() error: testing array offset 'adev->vcn.num_vcn_inst' after use.

Fixes: aaf1090a6cb6 ("drm/amdgpu: Add instance mask for VCN and JPEG")
Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
v3:
 - Added fixes tag. 

 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index ef800590c1ab..93c84a1c1d3e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -1282,11 +1282,10 @@ static int amdgpu_discovery_reg_base_init(struct amdgpu_device *adev)
 				 *     0b10 : encode is disabled
 				 *     0b01 : decode is disabled
 				 */
-				adev->vcn.vcn_config[adev->vcn.num_vcn_inst] =
-					ip->revision & 0xc0;
-				ip->revision &= ~0xc0;
 				if (adev->vcn.num_vcn_inst <
 				    AMDGPU_MAX_VCN_INSTANCES) {
+					adev->vcn.vcn_config[adev->vcn.num_vcn_inst] =
+						ip->revision & 0xc0;
 					adev->vcn.num_vcn_inst++;
 					adev->vcn.inst_mask |=
 						(1U << ip->instance_number);
@@ -1297,6 +1296,7 @@ static int amdgpu_discovery_reg_base_init(struct amdgpu_device *adev)
 						adev->vcn.num_vcn_inst + 1,
 						AMDGPU_MAX_VCN_INSTANCES);
 				}
+				ip->revision &= ~0xc0;
 			}
 			if (le16_to_cpu(ip->hw_id) == SDMA0_HWID ||
 			    le16_to_cpu(ip->hw_id) == SDMA1_HWID ||
-- 
2.34.1

