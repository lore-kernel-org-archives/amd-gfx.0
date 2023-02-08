Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F591C636D3
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Feb 2023 09:55:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B802710E728;
	Wed,  8 Feb 2023 09:55:23 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2070.outbound.protection.outlook.com [40.107.102.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2961E10E728
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Feb 2023 09:55:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KdEWzEGjHuplIYH/Tk2XcBcO1HDA03sxznAS4P2hAoQkNSxiUkrDD3hb61L8AuicFkjLCEfOUcROZOJv6PS4BABVvHoO3uKliu1SKFziTkMHaJTYUvRQ0MGsxAASydfVp53NjXYAJRn6aCUGimtQuYtARNDNJdLS7eQzAzqfEQOCUEtUvcntmyAMlh3PYRbPgZgkVuOUn1dLh8KbJFNWDWMEf7cDTeqh8g/+IKvcrjh05+8OTAGSNKQwwFZf5ZV7cMwvNl6LvLafMX6Y0fG436GHAM3H4PClkpZxQZig2jsAg/Uoa+PnTCFeFSsS+6ZnbKOg6sPznSKmJOuRs13OVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B3jqGAItsgBYbICWCGlJjWeU3+gn1fL6OYO/KFtIJcQ=;
 b=lPT7Pt17Dn2ZEX3f+YHTgLvPmupJU/ENI5qrdKO4KNupCJGT7hOJgQ38jUpkevmXfZNz8qvM93NM/L/DAPmJPuD1+dSWswbCQA2QesA8nWgWIVNQbqp40uR1aGb6cjRpdtp9+nrZOXN3Ijm37XStbVFptSy2cMw+0AQFgLZUt5HoWiv/4KVY9f3oa+0njYziv6i0Gu6DxpCBX/KDvgXEywjRa2YQupc/KmbCd/ymgdWJ5cS5g4DWFzt9R3PFSTNsL5mB4ZcAR1lIFGwocFxgYUFtYi3Fo+18JFNf6k8WmOTWRZpgmEqmb34gisU53slxqHBs3THclD6DgnSL+ViZ1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B3jqGAItsgBYbICWCGlJjWeU3+gn1fL6OYO/KFtIJcQ=;
 b=3aoMMwELERc7T3ets8KMlrSirSnOFCY0mJSE8EgWqNesklr8Kw/k5tXxGBHj3I0ZbeuBNkr9aAVW3Y04r3Crk/nbfNKEs/IhXUouGUFV9v5zrvhJjVtPJfgcusD4LJJsFNNfpkShyKF2Qfs+JOiu7e8N+wht6cGx0HqtsC24q38=
Received: from DS7PR05CA0084.namprd05.prod.outlook.com (2603:10b6:8:57::25) by
 SN7PR12MB7023.namprd12.prod.outlook.com (2603:10b6:806:260::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.17; Wed, 8 Feb
 2023 09:55:20 +0000
Received: from DM6NAM11FT005.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:57:cafe::36) by DS7PR05CA0084.outlook.office365.com
 (2603:10b6:8:57::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.17 via Frontend
 Transport; Wed, 8 Feb 2023 09:55:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT005.mail.protection.outlook.com (10.13.172.238) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6086.17 via Frontend Transport; Wed, 8 Feb 2023 09:55:19 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 8 Feb
 2023 03:55:19 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 8 Feb
 2023 03:55:19 -0600
Received: from yzha-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.34
 via Frontend Transport; Wed, 8 Feb 2023 03:55:17 -0600
From: Yifan Zha <Yifan.Zha@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Alexander.Deucher@amd.com>,
 <Hawking.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu: Revert programming GRBM_GFX_* in RLCG interface
 to support GFX9
Date: Wed, 8 Feb 2023 17:54:51 +0800
Message-ID: <20230208095450.1000441-1-Yifan.Zha@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT005:EE_|SN7PR12MB7023:EE_
X-MS-Office365-Filtering-Correlation-Id: bcc28f9d-ff9a-4517-dea0-08db09ba96b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HFwNHvzSfkchGpCnbiCdqEaPxnUlutjeblzLoI3YIoyHmR8tF5jV9f0lIk1tNNxInXQUtzvYaxKSUa3k9Jxk6P4t3C/shQQGmuqleL2LUvxKd1QIKLIp5C4z7s4+lC4xQyMBDCHvEWCCkn1bTKQs1/X8nKLcUsJy8/m4FDwhqnP+6PFtPvQmbh6VZFdDiejXbMdtbcKiAteBvWbdxruFXV96JGiYfNJfL8fSlWXYlbItU68O5ZO0i6LVJNKQmiL0GvcOWBB9DeARfmnlKLV6S5teyEmYCHObQowhdi4PAzk3yPiu6cJnKSgCfC01Z62I9B2De1D9w2ednWGc/hgUt9Zd/4y7VBowfnvtAeGG2Be1acNFhtC8ZTxaVb4ZafRobTgOmp+VY9bN0vhmki4raJmF/ihp1IsdBilzo8zKl6YxQ/5znNEr1YeMLINTC1Hp0oriblNtV4viyVFhB+4Xbkhg86NWGtNv4dgznjQlmnXItTxP3wiLw/NsQSBFdJDoPDT3RmY6Fm0clcxdQs5Jv2WlIChKDY+7FU8BfUMqVTN9mReEM7+70GRJ1aQcdbn4q6168jK3TjQeZzTaHi+0dT7NurKaQX+eZhof41cFuC22hg6zU57l7r35vthSNBHhRKRYJfcJ8lkjLU/vNThVOBl0gzARkYKoU5+50hOQeuJJqYGKv13zqKu81yWcDJt+dZAMSfAT1ucHJxZw8gjr5ylXF+WMQiqXqi4gtgHHE89QiiIjNQKXwCbnd7iH79F3
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(39860400002)(376002)(136003)(396003)(346002)(451199018)(40470700004)(46966006)(36840700001)(26005)(186003)(1076003)(2906002)(6666004)(36756003)(5660300002)(478600001)(356005)(81166007)(8936002)(41300700001)(82740400003)(40480700001)(7696005)(2616005)(82310400005)(47076005)(8676002)(36860700001)(336012)(4326008)(70586007)(70206006)(83380400001)(6636002)(426003)(86362001)(54906003)(110136005)(40460700003)(316002)(2101003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2023 09:55:19.9384 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bcc28f9d-ff9a-4517-dea0-08db09ba96b8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT005.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7023
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
Cc: Horace.Chen@amd.com, Yifan Zha <Yifan.Zha@amd.com>, haijun.chang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Why]
Regression of commit a291321cce8e("drm/amdgpu: Remove writing GRBM_GFX_CNTL in RLCG interface under SRIOV") on GFX9.
According to GFX9 VF using different method to access GC registers including MMIO(direct) and RLCG(indirect),
removing GRBM_GFX_* writing would make PIPE/ME/VM/QUEUE selection chaos leading to some OCL benchmark failure.

For example,
using RLCG interface to program GRBM_GFX_CNTL/INDEX for selecting MEC(actually the value is only in scratch2/3),
then using MMIO directly program a MEC register in VF driver.
The register programming are invalid due to GC switched to incorrect ME.

[How]
With checking RLCG accessing flag, keep writing GRBM_GFX_* as a legacy way.
But it is still skipped on GFX10+ to avoid violation occurrence.

Signed-off-by: Yifan Zha <Yifan.Zha@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
index ca5a1d026f5a..f2e2cbaa7fde 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -983,9 +983,13 @@ static u32 amdgpu_virt_rlcg_reg_rw(struct amdgpu_device *adev, u32 offset, u32 v
 	if (offset == reg_access_ctrl->grbm_cntl) {
 		/* if the target reg offset is grbm_cntl, write to scratch_reg2 */
 		writel(v, scratch_reg2);
+		if (flag == AMDGPU_RLCG_GC_WRITE_LEGACY)
+			writel(v, ((void __iomem *)adev->rmmio) + (offset * 4));
 	} else if (offset == reg_access_ctrl->grbm_idx) {
 		/* if the target reg offset is grbm_idx, write to scratch_reg3 */
 		writel(v, scratch_reg3);
+		if (flag == AMDGPU_RLCG_GC_WRITE_LEGACY)
+			writel(v, ((void __iomem *)adev->rmmio) + (offset * 4));
 	} else {
 		/*
 		 * SCRATCH_REG0 	= read/write value
-- 
2.25.1

