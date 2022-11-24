Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F989C433FE
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Nov 2022 21:14:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8C15510E270;
	Thu, 24 Nov 2022 21:14:15 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2062f.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaa::62f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B6ED510E26E
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Nov 2022 21:14:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MhHvAHouZ6aqB+N8PruYas/cdDzXTlMUt03nCZ3F+nZRD1S/uSLT3YE+00RXtO/On2TV3jLG013Otax+1Bzj8SYEtX9IXK94kyFwscV7p9eOfn9JEn1MvrpKaUrTk559w/MfGnXP6LIEn8YHOOtlce2B+hZWtZRMQTQOMe5RDTwADkP0CqIuFFldm0TwGDdfqMNOiUtGBxcBNXeWvq9ec4LyC64+HkNtmNEiEkMp1lhw13ziMcF+LUM86RFDjlDG2w8rfpXNRIzpNhLqXg3nFYSzwzsUcWk59wWlhggnzAcIydBLlBUNm0y05oX4ZJKPnQc0hOcbQ+Pg5tXQlAVbyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=icbNYre2ZJVU4z2G+W5zUH4SOGoWwRsKW6hwOz9YTtY=;
 b=Aa4M5wzYN1rkT6/Ns+57lQQKHykXreid8ZCZJZJE3Sn8iUli+c3hKaOBr5PAXi/QBUQKObQ7+q7PBNAKs6LZ45QvHPAMvGtzt0xVy2U2/e7coaqMUmdl7YWD2PsXfc2Vca+ywBa4kcPIAxXy3pR9ttiKbuxRMcjqOC4mA1I2skPvQcBxmcUe2UrBybuWFjMbg1GeWq8bl7llzZURlYM6ZTGXG35hf6S2OinCESI4ozgeM0Pr4qSZa/VnUfbMW20GgDkfTw92K450WBuu79vS8EBhzsAqq3ycSWSHKf5Su1Q8Uqrg2VEQNyTmdTggn0ZoU/wkyseJbBvu6Q9T6ttvVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=icbNYre2ZJVU4z2G+W5zUH4SOGoWwRsKW6hwOz9YTtY=;
 b=48bUnBexRXMb87p2KkXTlT1WMCujjEY0m0zPMcbeJEu2SC/sGbf/mVq4ABwfOAEvBDYcghm+iu/nofEfYfpbGykRGYw05ha9FuzhGN9mtDFxeVhJOFW6vr4ooaCay1ozerFac3/ybYmp3LdSfMbVdzs2gBKEwXcmJCw4/z0tfiE=
Received: from BN9PR03CA0396.namprd03.prod.outlook.com (2603:10b6:408:111::11)
 by BL0PR12MB4900.namprd12.prod.outlook.com (2603:10b6:208:1c1::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.19; Thu, 24 Nov
 2022 21:14:05 +0000
Received: from BN8NAM11FT083.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:111:cafe::bc) by BN9PR03CA0396.outlook.office365.com
 (2603:10b6:408:111::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.19 via Frontend
 Transport; Thu, 24 Nov 2022 21:14:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT083.mail.protection.outlook.com (10.13.177.75) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5857.18 via Frontend Transport; Thu, 24 Nov 2022 21:14:05 +0000
Received: from jasdeep-System-Product-Name.phub.net.cable.rogers.com
 (10.180.168.240) by SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Thu, 24 Nov 2022 15:14:03 -0600
From: jdhillon <jdhillon@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 04/12] drm/amd/display: MALL SS calculations should iterate
 over all pipes for cursor
Date: Thu, 24 Nov 2022 16:13:40 -0500
Message-ID: <20221124211348.214136-5-jdhillon@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221124211348.214136-1-jdhillon@amd.com>
References: <20221124211348.214136-1-jdhillon@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT083:EE_|BL0PR12MB4900:EE_
X-MS-Office365-Filtering-Correlation-Id: 7bd378b5-b14e-4780-db2f-08dace60d162
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xhwRY3jOPkN+PQAZ8foNiV9NaoYkF9L+tI8t7T0vw9xC9K8ytsdC0iQUmk2XK94Cxea1IbmaKuvt6tA0wsIu+0eqqf8Sa5R1vdfQBUvQercsDovOtKcmrb2N6YbU7AZX1XKR+Y68PPAnyZuJCsKnxvzsd3MQVpKcmX2h9vvZXPS1HeeDUB46VjL1OGMBRolFicM/pi/qqk7dr3BDOyxQQK1JrY9I8VyUDBfNm5waKvHzv/TS7aWtPKnUgh1bd2qzye7fHLFg5ECxGo+SiDq91ymrTzoBBI5f0ajX9N5ovdbC2/vC8i68PZHhtKsXtDNs4zYdX683DAFd3RSxmR8qjXKIYRebqYjOLSY3Bda3YgEBE/J4BOo3o67c7IWwQ5fXIIncoYE3H63QRI1yqEzXJTankN47LXPBoAOPwtoIgfvQL3aV3HqssQsA9NJCXw3W5yLrpp8Of1rtXwdXMhSpaoNb6o4hODlY2hDMSlizxjGXttLN15srpV3DpxN0e1E+kHoMdIxS3w0+4eCrT1mAswgRJlmK/09oStuEcxtEMy42GyopYUP2d9HNx/eCZGV8qp1FA9htId7FdYOmlFL/Ckvgb+wMDePms54FTGzb8BTce6I2hBds/zQBRzo5QxAgH2ucK9TFfOt1X/3FAhkTPUmwFB211OiBkC3iBl85L2EKxQl/R6JvzX0gmOMtLPAV9J2bPD1XkzdCpd9uE5Gshr/X7S5D5dWGoUHYsvaDdYg=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(376002)(396003)(39860400002)(346002)(451199015)(40470700004)(46966006)(36840700001)(426003)(336012)(47076005)(83380400001)(1076003)(40460700003)(6916009)(54906003)(6666004)(26005)(186003)(356005)(81166007)(40480700001)(36756003)(16526019)(36860700001)(82310400005)(2616005)(82740400003)(4744005)(478600001)(5660300002)(8936002)(70206006)(4326008)(70586007)(8676002)(316002)(41300700001)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2022 21:14:05.1133 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bd378b5-b14e-4780-db2f-08dace60d162
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT083.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4900
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
Cc: stylon.wang@amd.com, Dillon Varone <Dillon.Varone@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Jasdeep Dhillon <jdhillon@amd.com>, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, Alvin Lee <Alvin.Lee2@amd.com>,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Dillon Varone <Dillon.Varone@amd.com>

[Description]
MALL SS allocation calculations should iterate over all pipes to determine the
the allocation size required for HW cursor.

Reviewed-by: Alvin Lee <Alvin.Lee2@amd.com>
Acked-by: Jasdeep Dhillon <jdhillon@amd.com>
Signed-off-by: Dillon Varone <Dillon.Varone@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
index 2f19f711d8be..76548b4b822c 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
@@ -316,8 +316,8 @@ static uint32_t dcn32_calculate_cab_allocation(struct dc *dc, struct dc_state *c
 					cache_lines_used += (((cursor_size + DCN3_2_MALL_MBLK_SIZE_BYTES - 1) /
 							DCN3_2_MALL_MBLK_SIZE_BYTES) * DCN3_2_MALL_MBLK_SIZE_BYTES) /
 							dc->caps.cache_line_size + 2;
+					break;
 				}
-				break;
 			}
 	}
 
-- 
2.34.1

