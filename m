Return-Path: <SRS0=b4Qt=JW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A792C433ED
	for <amd-gfx@archiver.kernel.org>; Sun, 25 Apr 2021 07:31:02 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5FF3861245
	for <amd-gfx@archiver.kernel.org>; Sun, 25 Apr 2021 07:31:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FF3861245
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1569E6ECDA;
	Sun, 25 Apr 2021 07:31:01 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2044.outbound.protection.outlook.com [40.107.223.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 192106E4F4
 for <amd-gfx@lists.freedesktop.org>; Sun, 25 Apr 2021 07:31:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z7Kf7lgDJYo39G8eARI+Qi1gCpFL4NBaiBDEIjEGBllpeIKHe2SPPKaPIrlADubCEUICdzJUexRhkCThnF5vksJJ1lHGlr7Tp3oPoVQblf1UX26lacXfV3+rWGP0/ou/X1GmMwpnc1WL3hX+7Iz/nBZsWES78XgItbJVQq8nba814HuaMTiQmn44RjioJ6D/wLTwz6NaqJhLXhcsNY4Vk89x7jS9yEEor96YLGeRcZ2hmuR+mTOVvZ0wbxiNT9A57jYSfy1bHVPCmzmc8a2V6hF0W/McSIQXSaXsC2ZBfP7F5RF+FBL4n9b3l5zpAK9xd++rU2JGze6VnP0pFTSFmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WWn5ZcIy+IlkKDKz/hYbUHDpLkFtmuC0xSFvTgB80Dw=;
 b=llJCJRjLi9bHPMecAkCtKyy5QnkEEcZ+0lBwF/7lASKnMD/c+kEI4O1fCuOKmDieXZCXVCybf0MtGUrewdu5Vti/bXh25kuQAs1Kf2I1HKuJ6eJjr2lmIDyvSjBOtHQ+/XEXrNxI1Wc4YhmfGlkzb5Omhr7tEFdTPWBVm9yUZpVj31czqUyMm4jW/iTJAkV21s5s9+TOCbtfHfF71WM/LtE4DlXMvBHR0T4A6S2LinSXzPzs1iJIPmq4WWIdFQQ6Reu6XR2we4EClds9n+jPpGy9d9wTw+a5y6qk6I5nIjsyb0qfXwa4d6K0lH87qsdqb7uSpmCjiGngMtnHCH0dHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WWn5ZcIy+IlkKDKz/hYbUHDpLkFtmuC0xSFvTgB80Dw=;
 b=RlKQJBHvRasg02QWeI9wC2DqWI1+7sLiYFWWw3GElcwQr6bx2Uru90UxlyQETOgElRU6tAjC/y9WFJB+R2FseGGU5kCk7VeTfvD+f/LpLlsFRFMZsY9elGk/umGz9o6+5uIoz/hqCq4utZTg3kAhNElRT6WNinJXX3FQtQLOVDk=
Received: from DM6PR18CA0004.namprd18.prod.outlook.com (2603:10b6:5:15b::17)
 by BN6PR1201MB0050.namprd12.prod.outlook.com (2603:10b6:405:4e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.23; Sun, 25 Apr
 2021 07:30:58 +0000
Received: from DM6NAM11FT037.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:15b:cafe::f9) by DM6PR18CA0004.outlook.office365.com
 (2603:10b6:5:15b::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.21 via Frontend
 Transport; Sun, 25 Apr 2021 07:30:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT037.mail.protection.outlook.com (10.13.172.122) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4065.21 via Frontend Transport; Sun, 25 Apr 2021 07:30:57 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Sun, 25 Apr
 2021 02:30:57 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Sun, 25 Apr
 2021 02:30:56 -0500
Received: from fiona-codemachine.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2242.4
 via Frontend Transport; Sun, 25 Apr 2021 02:30:55 -0500
From: Feifei Xu <Feifei.Xu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] drm/amdgpu: Correct sdma 4.x irq.num_types
Date: Sun, 25 Apr 2021 15:30:47 +0800
Message-ID: <20210425073047.45484-1-Feifei.Xu@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 971169cf-43a4-4ace-53f5-08d907bc1175
X-MS-TrafficTypeDiagnostic: BN6PR1201MB0050:
X-Microsoft-Antispam-PRVS: <BN6PR1201MB005091DE75CDF73568B16C0FFE439@BN6PR1201MB0050.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:626;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JolWPfbVW+enCCX3ks7I0tHbzO0zSNT63TqC8C8qDRfeju5Cpz9T1uaxLJ1Bxb+Ysdqf89GPR3BmYaQ9up1h5RuTO5B+SxhU4t8dxQ4yrQqh3U/gjSONLvUM23mpXLM2VcX2F0hVzxolqVYzkU9rNzDk9cTDlvsCBLjl+nXe7RDK4pJn+Aue4/O8HtqxrDs58JoHrI9krkNpEqyybSrLNP1p/dVvcXX/XKAQEogPVsctCc7p/ABPr0zmNHwhuQurF0miZoQ4IaK7c9vHr78KJKStvTWzaP21z6en1JyeLn63Pmmy4RTZudQjGhFSxYYO0WXd+1iSTo2wimmu8xLLNiGnBLzcm7M21DJR+66rnP/jwdioI9emjnNOux8Q2JYUPIqX8nd9GGj7vqJmyq/dyM381U56SfHYsxiBYYHhdy2dZ8dgkRKBsf9YGY+Wh5orRUyBGyO9ci+IwXpuhXEGyvKhmWAvFfddw528/meyv1LqDgZh76TONMDDRVALH/xJf0iUp5ythRT8qzas1u+Gdv+Z/gmXFZZAHVCw9YKIm22nK0zRyXNT27CsBYNphvb6aVwxo2mJ1H5joODScNQvAYK7a5LCJyLJEXitep3wS2kqS3Z1EPPjcR2uTUreI5LZIdSyfnTE9JnaIF3/i8PT0tYv548jVdZcok1Ma8R3Slr3ZzkvhVC4h2ZUkpaVuAxN
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(346002)(396003)(376002)(136003)(39860400002)(46966006)(36840700001)(47076005)(478600001)(316002)(36756003)(36860700001)(8676002)(86362001)(70586007)(4326008)(70206006)(54906003)(8936002)(2616005)(2906002)(83380400001)(7696005)(336012)(81166007)(426003)(356005)(82310400003)(186003)(82740400003)(26005)(6666004)(6916009)(5660300002)(1076003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2021 07:30:57.6824 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 971169cf-43a4-4ace-53f5-08d907bc1175
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT037.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB0050
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
Cc: Feifei Xu <Feifei.Xu@amd.com>, Hawking.Zhang@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

correct and init the sdma4.x irq.num_types.

Signed-off-by: Feifei Xu <Feifei.Xu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
index fbb701560ced..2800b1b1f2ff 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
@@ -2609,14 +2609,18 @@ static void sdma_v4_0_set_irq_funcs(struct amdgpu_device *adev)
 	case 5:
 		adev->sdma.trap_irq.num_types = AMDGPU_SDMA_IRQ_INSTANCE5;
 		adev->sdma.ecc_irq.num_types = AMDGPU_SDMA_IRQ_INSTANCE5;
+		adev->sdma.vm_hole_irq.num_types = AMDGPU_SDMA_IRQ_INSTANCE5;
+		adev->sdma.doorbell_invalid_irq.num_types = AMDGPU_SDMA_IRQ_INSTANCE5;
+		adev->sdma.pool_timeout_irq.num_types = AMDGPU_SDMA_IRQ_INSTANCE5;
+		adev->sdma.srbm_write_irq.num_types = AMDGPU_SDMA_IRQ_INSTANCE5;
 		break;
 	case 8:
-		adev->sdma.trap_irq.num_types = AMDGPU_SDMA_IRQ_LAST;
-		adev->sdma.ecc_irq.num_types = AMDGPU_SDMA_IRQ_LAST;
-		adev->sdma.vm_hole_irq.num_types = AMDGPU_SDMA_IRQ_INSTANCE5;
-		adev->sdma.doorbell_invalid_irq.num_types = AMDGPU_SDMA_IRQ_LAST;
-		adev->sdma.pool_timeout_irq.num_types = AMDGPU_SDMA_IRQ_LAST;
-		adev->sdma.srbm_write_irq.num_types = AMDGPU_SDMA_IRQ_LAST;
+		adev->sdma.trap_irq.num_types = AMDGPU_SDMA_IRQ_INSTANCE7;
+		adev->sdma.ecc_irq.num_types = AMDGPU_SDMA_IRQ_INSTANCE7;
+		adev->sdma.vm_hole_irq.num_types = AMDGPU_SDMA_IRQ_INSTANCE7;
+		adev->sdma.doorbell_invalid_irq.num_types = AMDGPU_SDMA_IRQ_INSTANCE7;
+		adev->sdma.pool_timeout_irq.num_types = AMDGPU_SDMA_IRQ_INSTANCE7;
+		adev->sdma.srbm_write_irq.num_types = AMDGPU_SDMA_IRQ_INSTANCE7;
 		break;
 	case 2:
 	default:
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
