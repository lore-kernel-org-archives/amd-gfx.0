Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B75A6C433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Feb 2022 08:23:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0DFC910E614;
	Thu, 10 Feb 2022 08:23:20 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2082.outbound.protection.outlook.com [40.107.92.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A5FF110E614
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Feb 2022 08:23:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bk1Qj/JkTCNwf6UwdX4EXfwi90tAyhsZ990+DYMUH9BEThNE3SFfSCgMx5oQncLzMafS8eD3FbEOGjaH+Re1Ys+9yqZGgGN1+WtknDwUWYuHsf84BfUaxBq3Id1ZhePws77gu8X0XcZ/e4BhoxqtvGfm4yckABMznXdObWp6H8Fqi/oPVBV0lcZyVVxsgBPLuK/G3Q4+X7yR7OVcVCqCGaO+d4BmLnr0lFZfoaPgG7IUv1OZWOhwSDPXC3alp5Cc6F5xFJJmXewDz6mKYBw18QtumXEGafP4fyP0jhEVSneyIFK6puSd8bUenHn4v+ydaT432V0/HTbPkzyT08Hzvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r8MzE0BJ4awIdVjXjX1a1n/aZvl1PTaSnUrc2Kcsurk=;
 b=FU7gJMwOOaxiuthwgBketN4vO4lo9Kg4jmXJ4i346LbOzWb7cUfwILJ5d/h2t/t7IdDt8QpR2BFaOON151sbTHDW+t3AVSg12yFg9t3pRhsbEbETQBX86sz+5wZQWR9T0Nj+yywyd/m+AA+ZGcqlhxHxmkEhgq7EUK+hLexu6tuAEGHzBwM3Kmm8vUx4wZP0nc6ouoa6ugQapZNRDo20XhsFbq4KmUxQQ/LuxhyJ+m6vm5CZYy8P93ptbdhrFoMc4fijwmdUIgqRSUM+0cOg3VzLiO/y+MrE72r/jlIoRsMI0Jn6SsXdAXhQ+5fyok1/Ddq8ExMkVg/zBxWjuGV6JQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r8MzE0BJ4awIdVjXjX1a1n/aZvl1PTaSnUrc2Kcsurk=;
 b=DOvKx0xF2RVVfE3V5DfcOsYD1QCzDfhdSyQ99J4yy+bK7beqq4YBkcmalhUtuug3FRsn8/9CUwnkw5tsaqGq2+2KRs38M1t1FfBLSoiesAz3yDacsE6DFUYzeqbr2b5LNBafqTIZUhVosUdP7EFTfRnDKuzhYUaNuPCXoPAW05E=
Received: from DS7PR03CA0300.namprd03.prod.outlook.com (2603:10b6:5:3ad::35)
 by MN2PR12MB2974.namprd12.prod.outlook.com (2603:10b6:208:c1::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.12; Thu, 10 Feb
 2022 08:23:12 +0000
Received: from DM6NAM11FT006.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3ad:cafe::54) by DS7PR03CA0300.outlook.office365.com
 (2603:10b6:5:3ad::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11 via Frontend
 Transport; Thu, 10 Feb 2022 08:23:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT006.mail.protection.outlook.com (10.13.173.104) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4975.11 via Frontend Transport; Thu, 10 Feb 2022 08:23:12 +0000
Received: from taozhou1u2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Thu, 10 Feb
 2022 02:23:08 -0600
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <hawking.zhang@amd.com>,
 <stanley.yang@amd.com>, <yipeng.chai@amd.com>, <john.clements@amd.com>
Subject: [PATCH] drm/amdgpu: loose check for umc poison mode
Date: Thu, 10 Feb 2022 16:22:56 +0800
Message-ID: <20220210082256.31081-1-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0a75533a-5a52-4273-6fb6-08d9ec6e940f
X-MS-TrafficTypeDiagnostic: MN2PR12MB2974:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB297493BAC9B6693CB58AAA0DB02F9@MN2PR12MB2974.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:747;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: STuQPh58V/QrK5FB5zHEseQ0DfDE4agOjACqF0yN4SASslOwGT4adt30CSys/Usy8zPZcO/MSV44OuHclUzZcXNubVLLl+jKCQL+5CuyEiC19UavWJ5Hr2pKoOFzI+4LaIciYC4SMkA1EsoZUKJa7p93E4VvWhLhvxP6sN1GCyvqhIHcxYluAAoHafFHZ/aPZ4qBrVlCrApXJMYjgBOqKgBYhr0hnblQdsgnJbxzTVksivIs4ewGJ6GquoACiWTANX2djhNKnyl7xLmFKrZAMczcbBX1p73HHl9S0XWU2bQBawj+vBlf3hECCo7Qs/EjeeTXi6idFFM7zvAjw6cPPnWVp+vxelDPSp6oZJ7D2nM8ytOGDD373CZolJzLfW7Ei+hDWcfPdDWOlJbSR7ekF2qNas4AiobrIJWmauEtqU2BbNRy/rRVo9cTFcczpTi1LQStq1ytLKhTSf2wtlpaic+80jc0G0Y71s43YHMpvvI8OnFH4fB47JHPa0mfIZtdCcQQ+p42kg4EgAHJ8KxYwCq0lNzmHc+kvjKm1o2LCAQElVKdL9SKodYSdlBShQrpfmfme1nWDLvVA1qKKBrjGS4fA5Q4qCNItCjgf/SW3+xYTWrbG53Ht31HhGdMKmHGyXqYe9kH+DZRH8zXQL34u6gZTZZTnhLDK1rwZvkRzk2/BHOx6ZxG20Oj6jnfWvPqyqNN5l6BK8Gwrgl5Ll1rQA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(36756003)(40460700003)(16526019)(1076003)(186003)(508600001)(36860700001)(26005)(2616005)(336012)(426003)(7696005)(83380400001)(47076005)(316002)(81166007)(110136005)(6636002)(82310400004)(2906002)(6666004)(86362001)(5660300002)(70586007)(70206006)(356005)(4326008)(8676002)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2022 08:23:12.3139 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a75533a-5a52-4273-6fb6-08d9ec6e940f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT006.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB2974
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
Cc: Tao Zhou <tao.zhou1@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

No need to check poison setting for each channel, check for umc0
channel0 is enough.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/umc_v6_7.c | 18 +++++-------------
 1 file changed, 5 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c b/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c
index 47452b61b615..e613511e07e1 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c
@@ -451,21 +451,13 @@ static uint32_t umc_v6_7_query_ras_poison_mode_per_channel(
 
 static bool umc_v6_7_query_ras_poison_mode(struct amdgpu_device *adev)
 {
-	uint32_t umc_inst        = 0;
-	uint32_t ch_inst         = 0;
 	uint32_t umc_reg_offset  = 0;
 
-	LOOP_UMC_INST_AND_CH(umc_inst, ch_inst) {
-		umc_reg_offset = get_umc_v6_7_reg_offset(adev,
-							umc_inst,
-							ch_inst);
-		/* Enabling fatal error in one channel will be considered
-		   as fatal error mode */
-		if (umc_v6_7_query_ras_poison_mode_per_channel(adev, umc_reg_offset))
-			return false;
-	}
-
-	return true;
+	/* Enabling fatal error in umc instance0 channel0 will be
+	 * considered as fatal error mode
+	 */
+	umc_reg_offset = get_umc_v6_7_reg_offset(adev, 0, 0);
+	return !umc_v6_7_query_ras_poison_mode_per_channel(adev, umc_reg_offset);
 }
 
 const struct amdgpu_ras_block_hw_ops umc_v6_7_ras_hw_ops = {
-- 
2.17.1

