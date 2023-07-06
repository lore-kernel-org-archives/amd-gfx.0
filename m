Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA75EEB64D9
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Jul 2023 18:19:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A483B10E48D;
	Thu,  6 Jul 2023 18:19:47 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on20605.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5a::605])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C617910E499
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Jul 2023 18:19:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LXOIFpLa6mN9OFWUfPMXUz91E6S9QtcQz4XUuuPKYLBCem9+yGS3973IFjWj+wCLkoPPj41l0mMR4qlFVGo7IFEJHbZStYhZHUiU+Un0r4GZYXViMWEWpJ/5/FFhzDyHcVcjjok09HFFSeilOd0xm/mcAdTQngVXQylk5tvU55M5j4dRpBmlx4hklnqJOoj33BkBgO5JHPtez+49m0l5N9tIdmsrsYUoagL6ET4sVAYmni9vOQiGdIb8eMVQqrzmBmsKn4BiIjljR8NUpd67ZGzhHG51oF8KGDnW7iCVU2OKzHOg4XTj85vgKHfvMxxW7i069WWrZoLACmhpU8DsuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vlCr3LHrYh6RPldIvI7x7vL68rAt8Jq+W16p7rBM61A=;
 b=TgSTXNaM/9kEapCaJTaS9IXStNQl3QL7f+OuW15ZrVFANIHo6eXJQHbuawHc/MT031pNOwJNDpEcoXc8KHuXeR7NNwTZBpg6B1RHtKqbDNGTsoVUXlbBl8l8/FtgmjTsvpY2Nf++nOc05CtJ6c6JF9+uA2ZHybf1gVDqMnn2PMxgfd63eaNIWuD2yX9aHm0fTQkpAMrsUXYOhiEruOxI2D8UPsuG4Q1arv6qBvZwYSGnhjWjlv9HsjLaLEuUJQbNF+wptHKjT7nfMCjV/otvLe66STQuDo54g6esoJTRwRKfw1eHdnpCrKdsch87lFnurbm9pG95qvH605HnaxOJjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vlCr3LHrYh6RPldIvI7x7vL68rAt8Jq+W16p7rBM61A=;
 b=Vhqf+hzy6+cZj9hh//7xgMZ6643s/fq+ATiJikEK6IzqAdQeCpCXlbngoouqi2Mpw+IwlTJxqiiR9K2ViRQHyYEW/yMCINta4+o4Gf4nmFQUtYIcvN3K8IkXoEaofWXpWbwaOK+cSw125X5qIeJMxN2zPToc+wF7D6BOlGsHWQE=
Received: from MW4PR04CA0046.namprd04.prod.outlook.com (2603:10b6:303:6a::21)
 by IA1PR12MB7710.namprd12.prod.outlook.com (2603:10b6:208:422::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Thu, 6 Jul
 2023 18:19:38 +0000
Received: from CO1NAM11FT049.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:6a:cafe::40) by MW4PR04CA0046.outlook.office365.com
 (2603:10b6:303:6a::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.18 via Frontend
 Transport; Thu, 6 Jul 2023 18:19:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT049.mail.protection.outlook.com (10.13.175.50) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6521.45 via Frontend Transport; Thu, 6 Jul 2023 18:19:37 +0000
Received: from eric-hp-elitebook-845-g7.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 6 Jul 2023 13:19:36 -0500
From: Eric Huang <jinhuieric.huang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/6] drm/amdkfd: enable watch points globally for gfx943
Date: Thu, 6 Jul 2023 14:19:15 -0400
Message-ID: <20230706181918.189722-4-jinhuieric.huang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230706181918.189722-1-jinhuieric.huang@amd.com>
References: <20230706181918.189722-1-jinhuieric.huang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT049:EE_|IA1PR12MB7710:EE_
X-MS-Office365-Filtering-Correlation-Id: 050cb2f3-3527-4db7-5a10-08db7e4d8ece
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: U7h2K2OZoOMwQ4siFY1ucXU2y5A3+0nZghndXdGglk2uvtNDKvnzFuc9xXUd3kuoXsOi0O5DUE1GAL8GQsIsnJwiGMGR1MQnSA2qEwmp1h5e+aLBk0KR7ZK9JdU+wmOV1yjZUrb8J5Jipq1+qwPsiLmkEbg+srQc6yTZmXmRETfhCL74g62zOMZCDUt2SuUGXEBXptOJheyD4kqEz8KSPJJ8rAmcE1mEHAaPX573H5diL61NZZDkazIQ6IS0+pcr7xG0lknuRP2XiGFWMoMGeXlsM2OIs4IQ1prHFKWyRoNwb6l88FB/T+u2sB24/FtL1EYNddcu9u0lETbBjqz3P796Hs+eY/YQBNzNIyaVn4/ylpy7DCEjZICL2DnEpQA60NiAgGydWSgkRcVCwziTAOEf/RwG2d1nyrnlHPTKV2SouNH/pYRSPLv9wrjPlI8Anp4pBHuhYN4I8fXdbE4RuZgrulTWn6O0gGTTzd731I1HNhba2bzUwgged6Q71G84+a7Vio6jMlyI+6Cjkuk/F1MYRSoSkyMqXk0Wm/RMjh8yIpajJTwCDjcomU7HbpNkYY3M094BJqLm9NZw8N2b7jsRRve8DrvQ5r0O4+pVNC0VjBqqmyWXfm91JtSytRdpcoHuUiF4yvmxxCRoOx4+F93rbVfGjjYN8jcTrjpdWq9vWFIss0d2uxyjR3tE7agYO6UnjUnTVJI3aWUf5c1XtB6Gx6fRr22OEZ/4pmYg90usQlRfp/+7UIOvjSmaVTMlF+Uy6nYyeKT5E5WlKQyT6w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(396003)(376002)(136003)(346002)(451199021)(40470700004)(46966006)(36840700001)(7696005)(478600001)(6666004)(54906003)(36860700001)(47076005)(336012)(426003)(2616005)(83380400001)(36756003)(86362001)(40460700003)(40480700001)(70206006)(2906002)(82310400005)(1076003)(26005)(186003)(70586007)(16526019)(356005)(81166007)(82740400003)(4326008)(6916009)(41300700001)(316002)(5660300002)(8936002)(8676002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2023 18:19:37.5120 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 050cb2f3-3527-4db7-5a10-08db7e4d8ece
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT049.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7710
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
Cc: Eric Huang <jinhuieric.huang@amd.com>, Felix
 Kuehling <felix.kuehling@amd.com>, Jonathan Kim <jonathan.kim@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Jonathan Kim <jonathan.kim@amd.com>

Set watch points for all xcc instances on GFX943.

Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_debug.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
index 24083db44724..190b03efe5ff 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
@@ -446,7 +446,8 @@ int kfd_dbg_trap_set_dev_address_watch(struct kfd_process_device *pdd,
 					uint32_t *watch_id,
 					uint32_t watch_mode)
 {
-	int r = kfd_dbg_get_dev_watch_id(pdd, watch_id);
+	int xcc_id, r = kfd_dbg_get_dev_watch_id(pdd, watch_id);
+	uint32_t xcc_mask = pdd->dev->xcc_mask;
 
 	if (r)
 		return r;
@@ -460,14 +461,15 @@ int kfd_dbg_trap_set_dev_address_watch(struct kfd_process_device *pdd,
 	}
 
 	amdgpu_gfx_off_ctrl(pdd->dev->adev, false);
-	pdd->watch_points[*watch_id] = pdd->dev->kfd2kgd->set_address_watch(
+	for_each_inst(xcc_id, xcc_mask)
+		pdd->watch_points[*watch_id] = pdd->dev->kfd2kgd->set_address_watch(
 				pdd->dev->adev,
 				watch_address,
 				watch_address_mask,
 				*watch_id,
 				watch_mode,
 				pdd->dev->vm_info.last_vmid_kfd,
-				0);
+				xcc_id);
 	amdgpu_gfx_off_ctrl(pdd->dev->adev, true);
 
 	if (!pdd->dev->kfd->shared_resources.enable_mes)
-- 
2.34.1

