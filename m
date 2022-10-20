Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BE68C4332F
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Oct 2022 15:48:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5667C10E4C1;
	Thu, 20 Oct 2022 15:48:01 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2082.outbound.protection.outlook.com [40.107.244.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A187110E160
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Oct 2022 15:47:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ha3xmczPx2kyigO65mk3AjTXRIz0FJIcwVH06dBQpFJMcEHZ3gBU9vtZOQ8U/O032FS24bWnlEYucdcY5IkmYXmaMpuKqS6h+nHRNHMRpaxIQs3vuffzkTEa3/yI7cJeDZ3qLBHGTLdL4xijN/WmY0SADPiAP2ZhJNrmQZUlL53mSCSYS20D/oi0XmVCt3b45IvnTkhzcxYBtSCAb1R4PQalzHesOQBTJ8yRmNcLYxKmYsw5QOn/qu5SjtZmt/E0q89fC2f6U3kofA1npnz8NDnRXik6dzItkc6LQaOuIWKmpNetq6VOw7ay/nD5GxTAyIsIMYoYipzvjSDbvj2HpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OG9bw/jwHRz19++OIQZmk5hzytZjkonqoS1/Fw55u1s=;
 b=Ya5ZJwzA0+lAsYRi0KDC4Po1FB/R8whqE5utvlwvinNy2yHhpgGF2kzYPPqRbhLzXhTADb2CEQkwobZlRpP0/bKP8ThTxTYRnM0UFR3Trn1niYdSV9Vkee1rltK+thXLRO5BMI3VW5HU2tjVUAIjDtCnGmkCKQCxMCktMBb5TJ6lh1pQOHOYS/KrvnepUVUYoY8kcd2dNpcU+N3gBGWnN2Dco0GXCvPu1n/N0vGnO50k3qWOUBPSLq6fnreluwf6Enxg9rrPTcJAJI9o3m5o3UtBw1BvvJjiakOa2g6704ljsM4ieQj0D/Ih63Apee2JLr5+jP2649fmA6ygI/JPvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OG9bw/jwHRz19++OIQZmk5hzytZjkonqoS1/Fw55u1s=;
 b=SmoqLyk/deBVGm1ITD6BcbOUn5cGCV0G0nJ36aweBTDkFzzxok/Yegsnh4naqRvw11jyqlIYj0q3Nf65yQPt8sTP/sNq7BrKvoLrg85QaCqhbwN8WajOOg7H1xdNW5IwcGtOKkFcBrDh1cnJPcckiqVOJHi44GWaSgmnfWY++wU=
Received: from DM6PR02CA0136.namprd02.prod.outlook.com (2603:10b6:5:1b4::38)
 by SN7PR12MB7953.namprd12.prod.outlook.com (2603:10b6:806:345::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.35; Thu, 20 Oct
 2022 15:47:48 +0000
Received: from DM6NAM11FT047.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1b4::4) by DM6PR02CA0136.outlook.office365.com
 (2603:10b6:5:1b4::38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.32 via Frontend
 Transport; Thu, 20 Oct 2022 15:47:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT047.mail.protection.outlook.com (10.13.172.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5746.16 via Frontend Transport; Thu, 20 Oct 2022 15:47:48 +0000
Received: from atma3.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Thu, 20 Oct
 2022 10:47:46 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 11/33] drm/amd/display: Update DSC capabilitie for DCN314
Date: Thu, 20 Oct 2022 11:46:40 -0400
Message-ID: <20221020154702.503934-12-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221020154702.503934-1-Rodrigo.Siqueira@amd.com>
References: <20221020154702.503934-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT047:EE_|SN7PR12MB7953:EE_
X-MS-Office365-Filtering-Correlation-Id: ed96f164-8555-48e3-d8d6-08dab2b27050
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JC/6vEfo+4QA/4YbpY1QS6AUU8M1JlTurSydVV97oDHypap/FYVsNCI7w1ZdEQd51g8wxKjAnTCj7TYpmov1vs1WUtAut12tg2tC4879cD0PEG6qsvAldwot+O/jVqMA9POEPjuamMPj1+uQRcGjwhaMVOs2XSC3FigsrkP+FJUWezGD8X/MZONLQu+8ch62jquY+0rIZt5SSCy8JBQvqxBGRajqFbozwY85ZcUt6XLfvuP3LsPE+jx75Oz5Y1Slf+RXbmjQuIX7T4Hn2a5YKbaQo7tvuco+Hy0uzI1akAWnVTuUpr9kJxHazfNsUHFLhfsIlD6GlijJpm8kJC7DP8GDQwtY7jietP1bzYXLiQduLGRaC/SrKF8hqWKSe0+gCR1QPMnwC4BIUp+MbYD1tKO4bIE1dMo3goNScclDbyW2ctGXAvTw6S5xbWG5gOcChYgdjvcMpsP5qxQsfIXcuM0zEn6LGzxsrm2zHJDjGXfTWbf6mJrthbGd5E0/JROxRKf+MYimDVJgA4HB4nvi/qqWgIqzi+5Ap5K95OxGesHUneqQnAYzFHv93PUB06VtGMMbco3Qy/+K5jPxoNS0wyr9vId3tvR6VCJY5dO5Gyu0rcIQpHLIpWFSM7lAkNrgnJeS6AHPSFgzCH3z4w92T24TRX7mkug+SFjbz/xB9sYbV4aqzRPqHV4cPK+B3RyUkIOY3N8pjSIfcV8tsbUGqIbvjV1gKzLQqS/uPHBUAh0djqa4cSr5fvyH71HzIR4lpToovUus5IOOYeOthApLyhenP2/B5CB34KKcwuIz3pBrtsoAg2NJB2F173L+1RNH
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(136003)(376002)(346002)(396003)(451199015)(36840700001)(46966006)(40470700004)(186003)(478600001)(86362001)(70206006)(4326008)(8676002)(70586007)(8936002)(41300700001)(316002)(6916009)(54906003)(40480700001)(356005)(81166007)(40460700003)(36860700001)(82740400003)(1076003)(6666004)(2616005)(16526019)(7696005)(83380400001)(26005)(336012)(426003)(47076005)(82310400005)(15650500001)(36756003)(2906002)(5660300002)(4744005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2022 15:47:48.3834 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ed96f164-8555-48e3-d8d6-08dab2b27050
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT047.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7953
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
Cc: stylon.wang@amd.com, Charlene Liu <Charlene.Liu@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 Leo Chen <sancchen@amd.com>, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Leo Chen <sancchen@amd.com>

dcn314 has 4 DSC - conflicted hardware document updated and confirmed.

Reviewed-by: Charlene Liu <Charlene.Liu@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Leo Chen <sancchen@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c
index 92eb56873eee..85e2d87a8e44 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c
@@ -847,7 +847,7 @@ static const struct resource_caps res_cap_dcn314 = {
 	.num_ddc = 5,
 	.num_vmid = 16,
 	.num_mpc_3dlut = 2,
-	.num_dsc = 3,
+	.num_dsc = 4,
 };
 
 static const struct dc_plane_cap plane_cap = {
-- 
2.35.1

