Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8427DC433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jun 2022 19:14:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0C1A6113B52;
	Thu, 30 Jun 2022 19:14:18 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B709311AB70
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Jun 2022 19:14:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SLVklfasK8uxK7Qn5VMDPzQimB4ZL2RPFG2mFLKgcvEjqVF2coDFLs07htYgyMhML5Cud8ZzAprhhhHQMYn/fvvjx2XF4FJXuyAOPh5MiwYMrkcx2yUk2S8qR10wY7R7xu7+j2MJndyPEdserIqM1pZoNnyGz1pAaMU0VkqHiQCNghK5q50ackVEssnp9P71NZqs+keq7eGlchNgz3ZTKamTq0/xRXPFmxRJubicUP1WzJmKEA2WHIeaWxuClV3aU/1u6/kBy37hyVU2OFchwwkq/Xj+5x5C2BaVaXMO7l7quzMtpEs6NhKUtJECPkQJJxjeWilR0Yu8u7CQMNDWtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QAz+LE/SGxWQGzr3UPvtH04gLulu8gqJZwssPSRhdRc=;
 b=RrSIgZ3fDuHVuKt8SkJ3/Fcs9CI2Il9zNjuj6qgWdpPGofxrhUCAt9kSY3vJHpY25Y0Cem7wQ/aoFKNvf7bznNk9Gtv88Usy9hVy7u7PuaEdPDUDuHJzQ5GA0ylZkg7MKNMDqZPophIOD8BGOi8zADgwTyitwWiGAo2+m55DhRg1ZH0kr/Szvf0oyuJHvMbck3AicxljYzngrTskndogJBXiYG0R3m8QerL73Pn2NmEAmvNn8doeslmHEsy06L2W132Uej/UMPFVZQwaIVBieg7E7rclS8dpC048ZKCQA7gBxhruf97Z8eKE+LYIvgVDhXvGI00obQyUSYGAovmEXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QAz+LE/SGxWQGzr3UPvtH04gLulu8gqJZwssPSRhdRc=;
 b=zIuot4UJdSXBUyOfH00xWUsSeRfJ2CTV84Y6utkN2qpFMtZLADwz0/huFvUcbcBQL/SqydEHdTMf+jDzzOP1JYwl++YDr9pkEoXU4llIHNXfQnOGmxHSlSeYKVQbX6AnuOsxA0Zj4DB2+/k4v4JMj+rqNW0Bl21hBiIIKKc0Bf4=
Received: from BN9PR03CA0146.namprd03.prod.outlook.com (2603:10b6:408:fe::31)
 by DM6PR12MB2746.namprd12.prod.outlook.com (2603:10b6:5:41::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14; Thu, 30 Jun
 2022 19:14:05 +0000
Received: from BN8NAM11FT040.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fe:cafe::e8) by BN9PR03CA0146.outlook.office365.com
 (2603:10b6:408:fe::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14 via Frontend
 Transport; Thu, 30 Jun 2022 19:14:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT040.mail.protection.outlook.com (10.13.177.166) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5395.14 via Frontend Transport; Thu, 30 Jun 2022 19:14:05 +0000
Received: from atma2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 30 Jun
 2022 14:14:03 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 16/40] drm/amd/display: guard for virtual calling
 destroy_link_encoders
Date: Thu, 30 Jun 2022 15:12:58 -0400
Message-ID: <20220630191322.909650-17-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220630191322.909650-1-Rodrigo.Siqueira@amd.com>
References: <20220630191322.909650-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 28b84a4b-7a1c-4844-2aaa-08da5accb368
X-MS-TrafficTypeDiagnostic: DM6PR12MB2746:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +5Z2M9NQKJgbFEEpFs+fpPXbsUFHHunbYAUtW5WBWtugk0DlcH4broms3hjv4Yzzfth5WBLfmrwdTY5tEmgQVbJUmjSUeSIzqfbor3tYdMZvTwy+nmePlwH4YjYcIkqtAEbHCEa4OpYZ2GR5BHaV8Yu+L5Ack1B0DIzVckp9CaOHIWgRh+40oH8ot/sLpLb3I+yBZ8yzj9atxrAVmE4n3icr1SSuXXI4ILLo4mHl/pDQ8cMI5RhOu1GRyUVdLxx4xrQsmoDZycYgfZ3gTgwgQKLWCbAZgcgLfXGHtBRgzMYzTkMfQgKJiTB0WKLuEdaXmXCjo1u3VpbGen3A/q6kagd/9muwDEZ3A18IS+7O5VL5W+sGyOdDRhd3NJEuNQqgBSuHo/q7t0tA2eZlhQyQygk/AfJoWLns73oZfgFgIk7HVLhqRTaYyZMOs7FTn2lWBIYoExmRK5V1Kr4hS5jMTqaN0mtvbWwGUnzXb+XtNhb9pRpQhKB4xNwf9ACnmOc7rwRUQJWWSwjGrXz42fNZpaqKivBCVXE1HO9vC84POzXMkpxLe4fC2c9SPH4sV748x0PyE+DCeJ9qvtkMxtoWqqdi/EmnqshGthXKb0T0O9ZrU2mOQ+r3VQauyrSNjFPORU+Pvu9EdjYOeqN/V14CGLYfkzb3pBiTsPQET6gebEpYUVx1v0w6ZfA7kGDJeW0hbMSkcWlcFiPyHgbwQBNlRhVVQQctC1w5mtdwwQdMdaxP1b/0R5hMMq3J47mqKFsqO8AJA79g2AIYz/f9ShU+T7v72yyTiroLIUIq8+G6YO2b7r69Zp1fIOccB3Rz6llDYV4Zane3kWaEe/0Vh3HdS2xnwJUOp2kHBp7dV9gKEdk=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(39860400002)(376002)(396003)(346002)(136003)(46966006)(40470700004)(36840700001)(40480700001)(36756003)(316002)(4326008)(82310400005)(40460700003)(478600001)(86362001)(70586007)(5660300002)(8936002)(8676002)(54906003)(2906002)(6916009)(26005)(426003)(186003)(7696005)(47076005)(336012)(16526019)(81166007)(1076003)(356005)(83380400001)(41300700001)(82740400003)(6666004)(2616005)(36860700001)(70206006)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2022 19:14:05.5341 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 28b84a4b-7a1c-4844-2aaa-08da5accb368
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT040.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2746
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
 qingqing.zhuo@amd.com, Martin Leung <martin.leung@amd.com>,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 jerry.zuo@amd.com, Aurabindo.Pillai@amd.com, hamza.mahfooz@amd.com,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Martin Leung <martin.leung@amd.com>

[Why]:
On power down, virtual dal may try to delete link_encoders by
referencing uninitialized res_pool.

[How]:
Added guard against empty res_pool.

Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Martin Leung <martin.leung@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 795766cb27dd..34a3e1eeb5c4 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -347,10 +347,16 @@ static bool create_link_encoders(struct dc *dc)
  */
 static void destroy_link_encoders(struct dc *dc)
 {
-	unsigned int num_usb4_dpia = dc->res_pool->res_cap->num_usb4_dpia;
-	unsigned int num_dig_link_enc = dc->res_pool->res_cap->num_dig_link_enc;
+	unsigned int num_usb4_dpia;
+	unsigned int num_dig_link_enc;
 	int i;
 
+	if (!dc->res_pool)
+		return;
+
+	num_usb4_dpia = dc->res_pool->res_cap->num_usb4_dpia;
+	num_dig_link_enc = dc->res_pool->res_cap->num_dig_link_enc;
+
 	/* A platform without USB4 DPIA endpoints has a fixed mapping between DIG
 	 * link encoders and physical display endpoints and does not require
 	 * additional link encoder objects.
-- 
2.25.1

