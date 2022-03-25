Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2358BC433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Mar 2022 22:57:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B6BAF10E267;
	Fri, 25 Mar 2022 22:57:34 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2082.outbound.protection.outlook.com [40.107.220.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A507610E267
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Mar 2022 22:57:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gRGvtSAD1lUS/mtvoXAkpL8+GiC2GReSdwjdZv10U4nkZfIyf6MTnz6C5eM3ozEBZ4zp6t3ObWxADx2JvEXRJ+NcSnuxK1lK0JnicuJJw0sojI6U4Oi7tbopcHYyM/LY+ySmmTw1rrwSZg3F1xGDVKPY+Tur6nOe/5osiJ+oUuHInx6XRh5kAp76ltvrR9tczsXbjhfk64qXAT2aQVFlGeQDYSiPLrJ9ZjI7UNgZu2wz4WXaNhbZVbdbkmKjraUhVzfN1slhJmDVJxmBj3WJq9u4BKa0UZVMC1dZL7oQ916VtriL2HgCFaadsS6zJCjLAAUvSnRam2lAn9P9Cm+rYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TUm80DU1pV2E++Q9i4eyTpvwoDZ4GeaTIqPH5pfITJg=;
 b=oIfRLuyxbFv887kaR8A2pJlHlAt40qHZOaFHiyB6gIUjINNOM6g1QYv4NlvfF2/OWCrg8FZQhg6FUM9gKrAtTV5/thaW2qfqrtfWCsmteu69K2uuzwZexGhaLbXtiAGHHj45TJZCXBnwa09jsRYPp/LeUoHzVaILetISrOYV5e3L6oXLlL7cLG3xqs2W2oaTxOqbpSX4bIfOXTw/N1b4siGOIM7E0eaZi0FVBolHqaR8gvFL0+3BguD1NIiWTkYtOJx33ptcevoTiGBkwvykgut2owNzqQNtY2/mg50ftzQtRN7nTT4+TVzpTAGHzMp/qE4riY/03BhhXj9MRIHbrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TUm80DU1pV2E++Q9i4eyTpvwoDZ4GeaTIqPH5pfITJg=;
 b=YpbikWklBv1kJpMXvyHNoHXrxsWcqPGPpAQ30jQxa7SJZLcl7naMWzV+mro78d3SBbPVMctbuBl8Gd3sNLwaXcIBFNCyRkDKE5AL6Ys7Go4jshCsgurfI+9NMhIVsl2RY6sUFt1uON3YwFI6n+eWXfmnOePmcbmtrHBWDrKm31Y=
Received: from MW4PR03CA0251.namprd03.prod.outlook.com (2603:10b6:303:b4::16)
 by DM5PR12MB2583.namprd12.prod.outlook.com (2603:10b6:4:b3::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.19; Fri, 25 Mar
 2022 22:57:29 +0000
Received: from CO1NAM11FT056.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b4:cafe::6f) by MW4PR03CA0251.outlook.office365.com
 (2603:10b6:303:b4::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.17 via Frontend
 Transport; Fri, 25 Mar 2022 22:57:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT056.mail.protection.outlook.com (10.13.175.107) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5102.17 via Frontend Transport; Fri, 25 Mar 2022 22:57:29 +0000
Received: from dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 25 Mar
 2022 17:57:25 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 12/16] drm/amd/display: Update LTTPR UHBR link rate support
 struct
Date: Fri, 25 Mar 2022 16:53:58 -0600
Message-ID: <20220325225402.469841-13-alex.hung@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220325225402.469841-1-alex.hung@amd.com>
References: <20220325225402.469841-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a7ef6a03-64ee-4c03-df01-08da0eb2d689
X-MS-TrafficTypeDiagnostic: DM5PR12MB2583:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB2583F4B521DA282070BA5190F71A9@DM5PR12MB2583.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IJxJiykaR/9Rl7unxa33uME8JzwIeGKHRWB2HTHUlP8COOLQBguXfyHyzsVPloGpWbaOr7Q6HMJdKiK3hsQYmk7h3RgZoFHdeE7IH9LC1QgAyVnxRJst7AN5xJ1SLsSZqeTSiiPs6eMftsB6Fdr/f3+SqC2QqqYvhPzeHFuiTaml0uOlLNpBbRmR5j122l4WgQxEEx01HzShColtd2NDzt97hVQNCWtGbZGq8nc5wuOiqU7G0o4q5kxxBSr/yN7FUJib/sJQBH5ZYOYJiZZRhJsinysxn8d6A4aV1MtRR02k4ljV9crTI1XKOp/KGwj5ks+e1Eoriv5wKPbM804PwU0g78WI+qag8kRIPPAs0TmQDcSeaHlciatjGvv+UaF9MnlW4ahcfwD0ZcbvJNMDDp45sTXglyhvUKjS6nkUTtAWHXS9w2nS/WLs3pUegnifoZHltvcFettu6eiyXiCRJS81x21HbGfxu/b5nQ2QnopWtxcbzktIQGbD1EuFrD5ijophayeG0PHn0zf4NDxnJbUi8DlAorPVrmeLCnBtCIu2BC7cexekdWa9182CkvTHeRSn1QvM1CUv7KiC70lS1RUE0DC7mg5bXsFoJDoghdWJBWbDYmu/1WA22kPLf6Bk6iCgsulJ2fQt0szJAcfxW9Ky6EmxFHkdbSuqp0rPCqf2TPkCqxz8GLL6/8ITY/fsFkiXONDAlS3k9RN6F4+X1g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(2616005)(8676002)(316002)(47076005)(36756003)(15650500001)(336012)(1076003)(4744005)(426003)(40460700003)(7696005)(44832011)(81166007)(356005)(2906002)(4326008)(70206006)(70586007)(5660300002)(82310400004)(36860700001)(6916009)(54906003)(186003)(83380400001)(86362001)(508600001)(16526019)(8936002)(6666004)(26005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2022 22:57:29.0798 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a7ef6a03-64ee-4c03-df01-08da0eb2d689
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT056.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2583
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
Cc: stylon.wang@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, George Shen <George.Shen@amd.com>,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, Michael Strauss <michael.strauss@amd.com>,
 wayne.lin@amd.com, Alex Hung <alex.hung@amd.com>, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Michael Strauss <michael.strauss@amd.com>

[WHY]
Update field order to match DP2.0 spec SCR

Reviewed-by: George Shen <George.Shen@amd.com>
Acked-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Michael Strauss <michael.strauss@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc_dp_types.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc_dp_types.h b/drivers/gpu/drm/amd/display/dc/dc_dp_types.h
index 36ac2a8746bd..7d4aa99525da 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dp_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_dp_types.h
@@ -993,8 +993,8 @@ union dp_128b_132b_supported_link_rates {
 union dp_128b_132b_supported_lttpr_link_rates {
 	struct {
 		uint8_t UHBR10	:1;
-		uint8_t UHBR13_5:1;
 		uint8_t UHBR20	:1;
+		uint8_t UHBR13_5:1;
 		uint8_t RESERVED:5;
 	} bits;
 	uint8_t raw;
-- 
2.35.1

