Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93B60C433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Feb 2022 21:55:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1B80710E30A;
	Mon, 14 Feb 2022 21:55:30 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2083.outbound.protection.outlook.com [40.107.237.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7462D10E30A
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Feb 2022 21:55:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d/8yc1MRJM4aFUGByBYnBB3iD201MwKIlh2eKaiMMu/FCBAYotbRmYrvCr0BA3nHAg/+53WGrEKLXjVh3FOM0crulhhXfnEe8cnxVsHuNesD/GDYTaqzhBv4YUQ0vtF0gvOMVdMSs3N0YGIaD0DPUykISak8RLCZQuuN8uBWPKiyyqAqhBFuH98qLb4MxoxWcNlhGUizAF2cHgLLn7341Rqlp1MsqMrOwLkYsY9vvV+oAkcqP3XvxCQFmboWgKhsgutOT/RoG7v1AQIY0oe7z0EbOw66CK+LtNCNpG0VOhby1OTOOPH8BUO/AYlfcopdp1WFu4JrFR9liwBGO2rxzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rtry13JbSOY9QlJAzjx1XkpE+O16+vYNfqpvzJsaA6M=;
 b=akjC3784a7ThnwgNsztUP+DB9V+VmffoxMywA6vqLVCb0FqlQyr6t6yZ1VcIel6WDb2GzKRobjSlxFpwa3Y3galjVA3vdINpwwctP339/V/fzHIp8Kql8V3+dH1tbkbVdurH6UfUL6YArdk2evczqSe5uxEhruxoDA5y/Hsb6aEd+3151j0rAtJ71d8lfF8IN1tfCBsjVFplUOe+H6AJzt2rC1ZNFQDliZlk6ngvlsHKQ2zE7c+/3j1LdDJCOSzBekl6RanmWwQiXz9qvzMxbIKZ/1I7ZLlPjIRT+yuzf6mIPxbekVolWusEELitxumbZ8+5zDV18HfcWBcL6W9Img==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rtry13JbSOY9QlJAzjx1XkpE+O16+vYNfqpvzJsaA6M=;
 b=TFNHR2F0SHtzqEB+8p0eqsczV8OUgvTP7wk25EsuO7dvf63d8ON5GQkNt2lI7m4LNhZhfJ99gDq+WCKGBZB9k4mNvEPvduU7avb6X2QNz8mBx5fBm1rU8JxKxpqfQRHz4F1RFQhCzPAAEPw/MzcRNgPXFzefCa8yzV8Ns3cyTqE=
Received: from DM5PR04CA0061.namprd04.prod.outlook.com (2603:10b6:3:ef::23) by
 CH2PR12MB3896.namprd12.prod.outlook.com (2603:10b6:610:25::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4975.15; Mon, 14 Feb 2022 21:55:26 +0000
Received: from DM6NAM11FT004.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:ef:cafe::2f) by DM5PR04CA0061.outlook.office365.com
 (2603:10b6:3:ef::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11 via Frontend
 Transport; Mon, 14 Feb 2022 21:55:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT004.mail.protection.outlook.com (10.13.172.217) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4975.11 via Frontend Transport; Mon, 14 Feb 2022 21:55:25 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Mon, 14 Feb
 2022 15:55:24 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu/discovery: add nbio sw func for 7.5.1 nbio
Date: Mon, 14 Feb 2022 16:55:12 -0500
Message-ID: <20220214215512.2116676-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2e1303ac-3e0b-403e-c96c-08d9f004b514
X-MS-TrafficTypeDiagnostic: CH2PR12MB3896:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB3896FE6A2B20F103E64180F0F7339@CH2PR12MB3896.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1751;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cNCtWPkKBe1NcqeH7rkuPPSqvMjVuFgM7OYPLaU90yg2z8hKvFwVOBZlvmof5sJpqWPXaJk5VlrWbg14d8NDfEey0CfVUP2aSHx3BHgVJEeZh/j4MWIy/TuTak0PBnSTpKF6KzTfakJFVC59EC7WhZoFuWwWc+mfGcyd3fdN1tDool1uldeLWO1VJhxBQOfZDfaZl70w/YZXRR8KGfLS4qv9FKVch4egMpz/fXuFl0QZraklcR3OjCNNVzE8XhuCQGGOGk23gGAQwJWb09NHhttyn8QDKYC/OwXvUGfn7M/j7/huu8zteJHP8GGMc/5sJZ4cK/9MU6zb1v0eikZqFXQYC01NmlRg2pd5uJMi5cR8QAAaQMNZpMezXAFK65iRW4qmWGe/eKgjUIiQvPhHLRjwePlu2nJKmFGKf5C+nYZbRHanX3qMASB9j3Uj7crgri1fI8xOmvbyb1KGK2R+cr4lxHf3tsrwYVarOPDo0HhM1mzLXEP4lnoU3eR6BX+/n5QR7su6Y9I+geRxdvfG311K+bT3T9z/7ssrH75zX1LvC+D5dKgdkbbyzrPmvAiLiq546OBrsCuqV3s8Gy7WBXiSSrFnfb4Uvc8chViO3LYpR3Bt6W9Waf+w5TAPDBPc1Ca4sg2xgU0BOMO0vJXIlDR4FPR8tvT13/M+uBRvhzAChKVHowkuk1Ji3gHU47p81D6fpLMkxdkYRLnzGHntlA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(40460700003)(356005)(86362001)(26005)(426003)(81166007)(47076005)(82310400004)(186003)(336012)(2616005)(1076003)(83380400001)(508600001)(16526019)(36756003)(6666004)(7696005)(8936002)(316002)(70586007)(70206006)(6916009)(5660300002)(2906002)(4744005)(4326008)(54906003)(36860700001)(8676002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2022 21:55:25.7272 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e1303ac-3e0b-403e-c96c-08d9f004b514
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT004.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3896
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Prike Liang <Prike.Liang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Prike Liang <Prike.Liang@amd.com>

add nbio sw func for the new 7.5.1 nbio block.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index c8dbdb78988c..7b4f8e89a1a2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -1798,6 +1798,7 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
 	case IP_VERSION(7, 2, 0):
 	case IP_VERSION(7, 2, 1):
 	case IP_VERSION(7, 5, 0):
+	case IP_VERSION(7, 5, 1):
 		adev->nbio.funcs = &nbio_v7_2_funcs;
 		adev->nbio.hdp_flush_reg = &nbio_v7_2_hdp_flush_reg;
 		break;
-- 
2.34.1

