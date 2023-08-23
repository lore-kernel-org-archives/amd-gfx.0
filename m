Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FABCEE49B2
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Aug 2023 15:51:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7A81310E43B;
	Wed, 23 Aug 2023 15:51:32 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2059.outbound.protection.outlook.com [40.107.102.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A4B3F10E43D
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Aug 2023 15:51:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bozhx9h7Re1cKQJmn0YfTOHoZwOI/VXCiSr1axfwiDLJqjbdDCAkNAQ1CMxo3tKeBtZoTUHsebANF8l2FHhJKH6pNBkKD1zBdxW/di7fHlAfQEx+wFW539RluimJtKba1Lox2Vz4MJs2CM1aFPapj/9nTRwUY1i547FzD9Y+vQnhLheyc74yKrAtU6h4HPf3c7hnyt0RFGkDliSgwbet1sKOig7QlZTE1VKnxXQZ9bCdqOwxxU+bMNLxLKHg5ladT1i9C4GWprUXc9KQZ22DBZ8vGnE8nn4TiAHRNa/QRtavM1k5r7osyK+dsaAUo1Koeqa9sCCJOuLF9jBmT5b9Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hI9ZtY5hJBsKsrKkveja+MBSTrpvCMJaHERNV3iSuY4=;
 b=TkJb1yJKdAOBbGACd/0Re4gUylcFgffd3RB4RPPmCND9XhGdrWaTGR+hjRtsVG1ebIJIGNG6rFN9lz5xzi4js3HdUYlQi5HOYpJ1UBa2SrQbCKEp9Bm6eMqIJv2bxHAyStLeiFGWohW+S0mpS3aE/YwzTqH6Px+piGDLmi1ce5PYYKyR1YTWWJQ3Yitf8k25m+b2gHrLYpliZIVUAleFLgf0sGfXL/xedCGIBSHIJ0aTIQ8UScJxBtDN75r4iXAfmxaMPcSHaB2h8+fa92jFOUQ9SDZE3tnuXHLujbVb9w94/hektJNibSG2IOYCYPxDy32r0TIZuEMeTJDvrKSRdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hI9ZtY5hJBsKsrKkveja+MBSTrpvCMJaHERNV3iSuY4=;
 b=ODCrwDS7DufC9xaLd3Mlb5SqXkJUqNDSXduUbbb3pj5V24HgtMYkRufnkbM918ZyhM7xEMvywIT9Vy1kdaN6CfIQ2oJbZqs1wJZw3poCIHHoe2PhYVLDAlEkjJ9K8kPQy1EVo4KMlge9NwLcuM7kDI7ccPa6LzHsGgsdppuRm9k=
Received: from DM6PR21CA0017.namprd21.prod.outlook.com (2603:10b6:5:174::27)
 by BY5PR12MB4853.namprd12.prod.outlook.com (2603:10b6:a03:1da::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.26; Wed, 23 Aug
 2023 15:51:14 +0000
Received: from CY4PEPF0000EE37.namprd05.prod.outlook.com
 (2603:10b6:5:174:cafe::13) by DM6PR21CA0017.outlook.office365.com
 (2603:10b6:5:174::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.9 via Frontend
 Transport; Wed, 23 Aug 2023 15:51:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE37.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.15 via Frontend Transport; Wed, 23 Aug 2023 15:51:14 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 23 Aug
 2023 10:51:11 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 12/35] drm/amd/display: Add DCN35 BIOS command table support
Date: Wed, 23 Aug 2023 11:50:25 -0400
Message-ID: <20230823155048.2526343-12-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230823155048.2526343-1-alexander.deucher@amd.com>
References: <20230823155048.2526343-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE37:EE_|BY5PR12MB4853:EE_
X-MS-Office365-Filtering-Correlation-Id: b00e01f9-c6f9-4fc1-e1cd-08dba3f0c7ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iX1nvJbx8l+St7aPvKdbJdwk7JMg9Y7JrXMc+7M+zvchdNNrzPjXnZxKjidGU4ElL6oUr0T6uWVhCKB8XTb18yhTJ132b2P91ao3i7ANeUIY7H9rxjJdx16+1rOS83FQQKjuIT74ChnDskONDj8Vo6l+YNZIQ8UFaBqiZCotYUSqwSL/yBaQmOLD5OnqT8RFM5sYLCUF4cMMJbABFv4ZHcIyYvrQwMZuDUBy8CsJ4/bEiSeUDU4UUzhFtcORMlT5LD9tsEX1X82oo6JYpiQNjs56uig4ZzTIjXCkj9wSWrU/VZkjTyo9sGHwOh2QH3zsNmM1Mviy0T591lpBKoKxFy7CxfCS3kIvnA+opch9DRqbe80E1N30txLY9iHzMnkT2po+4BwMWo3+5Nk5Bn4qpBmda+pacipVpuEZWM0imvg/FoXvru1YHiwTrC/OD46lnnsbTZwq28f/mT3LqnfbRbXOO4Sw4/fIFgq4eP/BMMJbxstFyDCWcz97VnkpX5byf8K7CqIp20YLvkfqaGdj1cI4ppahTz0jkIPFdH+thxN0ZzAHGLWdLx3OpXq/v0PPy2vvY+5txXNE2ZEmmwmyAO4C2gCHrHZblUASHWNIVmVvMoo9HrEQsNFpJk2K00ope5u9Xzx/PFP7Xna7qxS1KaD+X/VKkC7Sg7v9rHXEdZVxyhgdC5Q5wOq03ATIh8RzxWfIJDMm20KBsJG3NzYHlQBxphpvqP9Wrwh5KznSIfh8Iard65IPZ2QHZZ+ExNnta0ExHG0QJ9bBpNrQ6PjEFw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(136003)(396003)(376002)(346002)(186009)(451199024)(1800799009)(82310400011)(40470700004)(46966006)(36840700001)(2616005)(7696005)(316002)(6916009)(4326008)(8936002)(8676002)(40480700001)(70586007)(54906003)(70206006)(41300700001)(336012)(426003)(16526019)(26005)(1076003)(5660300002)(6666004)(478600001)(4744005)(40460700003)(47076005)(36860700001)(36756003)(86362001)(2906002)(82740400003)(356005)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2023 15:51:14.1560 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b00e01f9-c6f9-4fc1-e1cd-08dba3f0c7ca
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE37.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4853
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Qingqing Zhuo <Qingqing.Zhuo@amd.com>, Harry Wentland <Harry.Wentland@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Qingqing Zhuo <Qingqing.Zhuo@amd.com>

[Why & How]
Add case for DCN35 in command_table_helper2.c.

Signed-off-by: Qingqing Zhuo <Qingqing.Zhuo@amd.com>
Acked-by: Harry Wentland <Harry.Wentland@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/display/dc/bios/command_table_helper2.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/dc/bios/command_table_helper2.c b/drivers/gpu/drm/amd/display/dc/bios/command_table_helper2.c
index 8538f13e01bf..9d347960e2b0 100644
--- a/drivers/gpu/drm/amd/display/dc/bios/command_table_helper2.c
+++ b/drivers/gpu/drm/amd/display/dc/bios/command_table_helper2.c
@@ -80,6 +80,7 @@ bool dal_bios_parser_init_cmd_tbl_helper2(
 	case DCN_VERSION_3_16:
 	case DCN_VERSION_3_2:
 	case DCN_VERSION_3_21:
+	case DCN_VERSION_3_5:
 		*h = dal_cmd_tbl_helper_dce112_get_table2();
 		return true;
 
-- 
2.41.0

