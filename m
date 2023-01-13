Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72B11C54EBD
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Jan 2023 06:55:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 72D9B10E995;
	Fri, 13 Jan 2023 06:55:22 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2058.outbound.protection.outlook.com [40.107.243.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0529210E995
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Jan 2023 06:55:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LrumNIYumu9nATcWE4bp3Bo3/SLE+fbyhF0TIYZkEKVlTvZGui3oWrM07GtfFWju0an2rIM5KkXT8xNL/VPRXeNBGnIzcBlpbvqw7QKSLDy1DUnzRRm4YOMmOOLOQ/mXPN1A8je7riwmp0LuodN3UaajuVF2mUHswPhDiH2rLE3Y0UQtMHg86bhKgMQJrYWBIinniSnQdrhUnwfMzNN67llNqqUM1rcyGh3kRKKaMTLLAl9ToqhrH+R38WmBITAX1QeiuWdhZdYh7nxooinCnGNxBfEFy6YkdhqL5lhmO5KaNPP/zX/m1GHkJ1JYHLcawCq1CSIO//DDsYW8jBaByg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iriHeDT47YguiTwtstDbCO6V2+TmQGPeduNQKrlyvwk=;
 b=OyZsT5FrDNi/kN0kczIGvK7KwWksJ7VH8gAvhZ+hOx4STQILJcwW5DiZghfiG+7mHw50RJT/fc/uuBdBwq7jcthpQxEWgSqy4qlhAcgXGBbRTjiS6gYZNvIz+zCt2VpKXabRiee+ZvfO7t+Qm1PPvC6E6Et4OaKPdvcyZoxZkqUUEXRY7mk3e6xFpms7gAP4DD0Dypwh9cfNUid7mtGldBbAwfFqlXZYNtf7JhtL3xXXyNqq+0S7c0LapPTDicc0Yc2Dg3E76NqdXkArpCRvxDF7q0Yt/tFZF0sm4x+opvHKRBgo+XA8MzUW+sarXD+htxpt5nJghJUVtltlU8AS5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iriHeDT47YguiTwtstDbCO6V2+TmQGPeduNQKrlyvwk=;
 b=AZCgGoTDoQZIxTT1wSmiGiH4bKYDeKk4I7GdlKjpgRdtjHNUy0+SZGuL5CAlYGM3xWE0g/FraCMVPDYkyrcz4unrfINcm/730PQLCSbPkHp9XO8TRA8ZOKdmrGzJi4TZ2VfjDERZ4zmjswxfpPorlVBcb6wpC0C1+0CSEeRat4Q=
Received: from DM6PR06CA0072.namprd06.prod.outlook.com (2603:10b6:5:54::49) by
 CH0PR12MB5090.namprd12.prod.outlook.com (2603:10b6:610:bd::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5986.18; Fri, 13 Jan 2023 06:55:17 +0000
Received: from DS1PEPF0000E646.namprd02.prod.outlook.com
 (2603:10b6:5:54:cafe::9f) by DM6PR06CA0072.outlook.office365.com
 (2603:10b6:5:54::49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.13 via Frontend
 Transport; Fri, 13 Jan 2023 06:55:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0000E646.mail.protection.outlook.com (10.167.18.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6002.11 via Frontend Transport; Fri, 13 Jan 2023 06:55:17 +0000
Received: from thomas-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 13 Jan
 2023 00:55:14 -0600
From: YiPeng Chai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] drm/amdgpu: Remove unnecessary ras block support check
Date: Fri, 13 Jan 2023 14:54:14 +0800
Message-ID: <20230113065415.1727983-1-YiPeng.Chai@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000E646:EE_|CH0PR12MB5090:EE_
X-MS-Office365-Filtering-Correlation-Id: f12cac7b-944e-4aa5-709d-08daf5332111
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GAnOtWIUurnGuJTEABhRtqm3zTkWekgy3cf40v40fq4tJcxuozk5cAto8KWaVnnLkEmNbRFO8PcD0Ttb1uC3AjP+JJdUa/5OuOS44QIeCGEGWPrD0Ao++WJBkBOyC7lpviVTJ/U+RcX5zdavW7w/NXVO781jGE7FszqnLqpFhBNe+jDs9QXucfK3OcTF+ergkM/LldOzo8pDuYzaSsaGStXdO56IS7HKYjZkK3oY6Qp5KvsetP+BcM9KooIR/isBMFdgc063eFEgSPvpW8VelwqKuanKN3kw9+QEl6CoBgj+/HGD/ueCNpKp54yf3YMgL+3pOU0qWJ3J0NHuOw8fSoiqm6Tl0P5PA1f8li57lpXtKWKl3n1igDFH6Ox7Qm/84lXAXy2bkmgPv2dTCbcpcH1z9agQt1DDWK6KcYVHI0vC3ptM09Bn3yCVdhb88sP/kD5uztpTfWhV6TePPIY3GcUmarX1bq1kL6gHnPhzhMAzUkX2o8VHFKTcHxoqRz0Hi1nkGC1awyTiNwa5tf1th45PURlNzfP3PyQiewDrxuSY3BaGYHUmxk6KpREhavQIXd/ymPzEUzGgpG08rv4oXCAmMxxF6AoRoBlw3dEqwrECYaede0oaYfzgDtXyhvAjCoL0hXmxOrwmRgBUcMb/PNljmPb9bFFpqhuVAMLWlqWjwhDUqUUcaRMx4FfmhF3cnimCrbC+SaKafArHN/YU0rexziEH2WzFnfSE6qWL+J8=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(39860400002)(136003)(346002)(376002)(451199015)(40470700004)(36840700001)(46966006)(70206006)(8936002)(5660300002)(54906003)(41300700001)(316002)(70586007)(4326008)(2906002)(6916009)(8676002)(478600001)(7696005)(81166007)(356005)(82740400003)(186003)(82310400005)(26005)(16526019)(36756003)(36860700001)(1076003)(47076005)(336012)(426003)(40480700001)(86362001)(40460700003)(2616005)(83380400001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2023 06:55:17.2493 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f12cac7b-944e-4aa5-709d-08daf5332111
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000E646.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5090
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
Cc: Tao Zhou <tao.zhou1@amd.com>, Hawking.Zhang@amd.com,
 YiPeng Chai <YiPeng.Chai@amd.com>, Candice.Li@amd.com, yipechai@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Why]:
   For special asic with mem ecc enabled but sram ecc
not enabled, some ras blocks can register their ras
configuration to ras list, but these ras blocks are not
enabled on .ras_enabled, so it can not get ras block
object using amdgpu_ras_get_ras_block.

[How]:
   Remove ras block support check. Even if the ras block
checked is not in the ras list, it will return a null
pointer and will have no effect.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
Reviewed-by: Tao Zhou <tao.zhou1@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 0a95d1c1e7ab..3f1e987bdf83 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -920,9 +920,6 @@ static struct amdgpu_ras_block_object *amdgpu_ras_get_ras_block(struct amdgpu_de
 	if (block >= AMDGPU_RAS_BLOCK__LAST)
 		return NULL;
 
-	if (!amdgpu_ras_is_supported(adev, block))
-		return NULL;
-
 	list_for_each_entry_safe(node, tmp, &adev->ras_list, node) {
 		if (!node->ras_obj) {
 			dev_warn(adev->dev, "Warning: abnormal ras list node.\n");
-- 
2.25.1

