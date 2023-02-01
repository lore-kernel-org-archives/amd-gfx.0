Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEAC4C38142
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Feb 2023 05:15:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4100510E10F;
	Wed,  1 Feb 2023 05:15:44 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on20619.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e88::619])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D8BB110E10F
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 Feb 2023 05:15:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iCSmqAfZGBCN8Um+6jbmwjR3x7XrAtE+6Nn4xRmpCTr41z8W6nx4kqnsLeirbXjqDhs7OSrjFHRzD8h2swkB1C4nmnbONeW1Z/k8RTksSea5KUDyZplZVhtqO4ro9L2C1iLnfsmJpE0zYnQehmJ7knbU4dy6mwDwXuY4JttKhY6qwJ/5BOIYe41d8+hamGoWQhspUKkRh8IYBfVl5wryH+rrGty4zCrOjcSdMYa4zGW+Tbms1zQDqNGEUryxSLZJiY8k4tKYUE0CiiwF/0MdkCwtAq6gPYSbFDVwLJZBTl8XYdzkqiV9MrBww9/jc5bDxyZC5usFwP3ew2ImWlMdlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0aWzdK1wkGxNV17tETwocKMZX4QQKgJLS5DpTI1IVAI=;
 b=buqH23VeXUBSDSXttUd6SktQu3pWh7xmkdJHyfGE8h0knUpkBut3eBAza71mW1ab4WmySfrrkNopchibcm12eLa8bmZ3VylXSuIfcovucDZXC0bukiqASeBcjvZVAuZASh62bUFTfnMZHnK9AbEbuL/85O2vWu4AfRfegQj/bUP+rW6ekW2Z6SWcFc7m7tHcOX1Z4Th8ETMy3L4DpttXaxdlCDJzCF++jOH7SwSqbxkcICzLnU5REy8baSvn9FkL4XTzAyS6HVTUSLiSXlh8DmzMvFrJ1siXxoyPgbswWqP+03F1jfcELFZ67pW+U73hiW2xzoqQLhM9Z8Enn769Hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0aWzdK1wkGxNV17tETwocKMZX4QQKgJLS5DpTI1IVAI=;
 b=ERVqKoFe7ndBQlspwb26eyPdCzP/ShKJFzPtcH4hW3nxa9aUUxao/5+JXzco5Y8qxs6gFOQ6bzFE3Pi2kVQJKBjI6MyZqzX+yAOzXXLeqNOOINAJ5oPW+gXa3FIi/GEoWzUH45sa9gGJnDJvzzp2cbxk6Qu0n56Ke2xVUs2lWtA=
Received: from MW4PR04CA0274.namprd04.prod.outlook.com (2603:10b6:303:89::9)
 by CY5PR12MB6622.namprd12.prod.outlook.com (2603:10b6:930:42::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.24; Wed, 1 Feb
 2023 05:15:37 +0000
Received: from CO1NAM11FT004.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:89:cafe::e6) by MW4PR04CA0274.outlook.office365.com
 (2603:10b6:303:89::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.38 via Frontend
 Transport; Wed, 1 Feb 2023 05:15:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT004.mail.protection.outlook.com (10.13.175.89) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6064.22 via Frontend Transport; Wed, 1 Feb 2023 05:15:37 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 31 Jan
 2023 23:15:32 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 31 Jan
 2023 21:15:20 -0800
Received: from yzha-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.34
 via Frontend Transport; Tue, 31 Jan 2023 23:15:18 -0600
From: Yifan Zha <Yifan.Zha@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Alexander.Deucher@amd.com>,
 <Hawking.Zhang@amd.com>
Subject: [PATCH v2] drm/amdgpu: Remove writing GRBM_GFX_CNTL in RLCG interface
 under SRIOV
Date: Wed, 1 Feb 2023 13:13:58 +0800
Message-ID: <20230201051356.823546-1-Yifan.Zha@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT004:EE_|CY5PR12MB6622:EE_
X-MS-Office365-Filtering-Correlation-Id: 925fb823-401d-473d-ccc8-08db04135acd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: t1Ahv25ABSyNknjwTpPg2xMPQN1KFnbN0CJaS1HiIv3jQLXNfyiluMr4fYY95diG8tUuNOCZUx7o2vOJsTvijDR8yo+lb4silrKOWNPfWF5y0icdEBRcbiIlU/Rc5ZmgYqNjPs/HPEFRaD5Ph5W3dJQniJqyBKaiua/ibIsB7r5JGzeWhYfZ7sG/dKyw7jQ6TiQAD6ihquUn9RfQ0KE7Gy0YpiCTI67TMl4UrUpjz+dtzIuzyoimNQ4ZY44Ck6At/LQuvomerP9NNv2RdhUThxlQz4lQ7SdhKoCNoWv37ofDVgfCtB+CT1UmTYYLjIy0IgJh61ys5k1B9Tn75YeP111LUVf87Aq7xDOlfldPK9MGEbxc3og07ZiscEToD40r4ejdjiZut5eW7OZ9HCjaLvJ2zsSHbku1Azwh1dQUh3yzayPqe2wYjzl9fEv9kiZp9eZtOkdP6k4eo3ZNKsIYvNxIf/vQMHR399YAMWiQ0cdd+Gos2xszCdRxZWsPFPFT81eKfn1jxTEOHFJpR7OKo2oSbr14dZGcCx9485p0UYc2AGXLH3D5TTe7l4O95VZWAvZaWVqCoOBBpeeAgYjaFbHpHAAm+8ng4N8EhUmLvQ0+oUfP8Ws4ws8kwOvqsRkGuWzB2U3Be1POa5bXxMWR9uvxTI58aafW/nwNB3B5S58CDQRJs65Ay+IaFVaSZl4HPqhBfnNQQSIT8ixrnlChi0k7ITkmZ6O+k/IIP+obM6mD7LEYsVleCEvNJ5yYc50w
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(136003)(39860400002)(376002)(396003)(346002)(451199018)(46966006)(36840700001)(40470700004)(316002)(2616005)(82740400003)(82310400005)(81166007)(186003)(356005)(26005)(47076005)(336012)(426003)(83380400001)(40480700001)(36860700001)(40460700003)(6636002)(36756003)(2906002)(54906003)(110136005)(5660300002)(6666004)(1076003)(7696005)(478600001)(86362001)(70206006)(70586007)(8676002)(8936002)(41300700001)(4326008)(36900700001)(2101003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2023 05:15:37.5352 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 925fb823-401d-473d-ccc8-08db04135acd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT004.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6622
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
Accessing GRBM_GFX_CNTL in full access time has risk when VF is doing MMIO attacking.
Therefore, VF writing GRBM_GFX_CNTL are blocked by L1 Policy.
For RLCG interface, RLCG use SCRATCH_REG2 which is copied from GRBM_GFX_CNTL.

[How]
Remove writing GRBM_GFX_CNTL in amdgpu_virt_rlcg_reg_rw.

v2:
Remove directly writing GRBM_GFX_INDEX in amdgpu_virt_rlcg_reg_rw
as RLCG interface no need to use it.

Signed-off-by: Yifan Zha <Yifan.Zha@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
index f39391e03d46..ca5a1d026f5a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -983,11 +983,9 @@ static u32 amdgpu_virt_rlcg_reg_rw(struct amdgpu_device *adev, u32 offset, u32 v
 	if (offset == reg_access_ctrl->grbm_cntl) {
 		/* if the target reg offset is grbm_cntl, write to scratch_reg2 */
 		writel(v, scratch_reg2);
-		writel(v, ((void __iomem *)adev->rmmio) + (offset * 4));
 	} else if (offset == reg_access_ctrl->grbm_idx) {
 		/* if the target reg offset is grbm_idx, write to scratch_reg3 */
 		writel(v, scratch_reg3);
-		writel(v, ((void __iomem *)adev->rmmio) + (offset * 4));
 	} else {
 		/*
 		 * SCRATCH_REG0 	= read/write value
-- 
2.25.1

