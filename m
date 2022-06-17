Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7C3AC433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Jun 2022 19:35:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 78D4710F385;
	Fri, 17 Jun 2022 19:35:56 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2089.outbound.protection.outlook.com [40.107.223.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 906DF10F2A4
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Jun 2022 19:35:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cJ3G3un5NiWcYcQMhjLRGfYf5XjXViY87UtVTe55bZjStI06N0uddo1dOfPcDpozT/nLvpaRhA6xyo20cKDT1a6pPs+t+2gR5kA+Z13o2l3Ss0rLYiYz01EfKtck5PEqR+74bDETNfP8rlBQV7Klk/DdecB56c6cxRAlF4yKgWDbimBEdSAMyiHnDbLLVa8al9mr0NmNwPtH9Nh7Y8GTOmrq5ssHXnhSJQmA3TWh4SU1142wXppdLpAQ8wwKVo36N8w5Mq+3kd7qpoYjpEHL9532hNuyOs4ywhjX+pJ72RBy88nC45tK4ZBOSmdEjvTHMqgRFd+/lwhIp0QL2jQHLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TEK2Wwqno6j7Qrjk70wSaf9uV+f8Xa/4SgJd9dGJ5M4=;
 b=elAT6+1itqsxqqH0oPGDbu/5EuVk9aLNAqYwVnU7rZEKBg9Q0OysOuZpIrblZKsgczQsITps6ROU9ecX3qjyHoWbXW300QNnQXiEQmzqB3jM6nA9vJoWKWZ3RAhkuz/EU77M/sAuFN/L45hQsZAXFVxp9o1Xsqr9OeMfBzovG6fKK2NvXyv5tteMsdpwspPjNWGSZzPUcnvmAiJum43ASARBxbZQX8Qgz+miDpd/Hly8DIbwEsfZjFXfkElo64i4MoU7dSY6bUWb8LO5I1qCLtoxoKlR+79+CLXuqPaalKIQq/z/XVqTseatICOUUTcuZNnHTAY0XSHzgmT1J6c93g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TEK2Wwqno6j7Qrjk70wSaf9uV+f8Xa/4SgJd9dGJ5M4=;
 b=RRynwhf3+YJ9FmCgfZN7DIVnuTCF7D9l4zuOF4B4bQDuwSdG7hUwb1OsWWH0Xyt5HL7gTiGbgqyYOXc2FwYnr8vFs8G7TOpjog0zAMTKlJZvIphv2M4mhbCNUqjw+4tpoJOgAZwQa4U17Eg3tWG6Vk6Ntj06hsHhF44d0RnlUx0=
Received: from BN9P222CA0014.NAMP222.PROD.OUTLOOK.COM (2603:10b6:408:10c::19)
 by DM6PR12MB4579.namprd12.prod.outlook.com (2603:10b6:5:2ac::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.14; Fri, 17 Jun
 2022 19:35:52 +0000
Received: from BN8NAM11FT064.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10c:cafe::5f) by BN9P222CA0014.outlook.office365.com
 (2603:10b6:408:10c::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.17 via Frontend
 Transport; Fri, 17 Jun 2022 19:35:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT064.mail.protection.outlook.com (10.13.176.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5353.14 via Frontend Transport; Fri, 17 Jun 2022 19:35:51 +0000
Received: from atma2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 17 Jun
 2022 14:35:41 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 06/31] drm/amd/display: Drop unnecessary detect link code
Date: Fri, 17 Jun 2022 15:34:47 -0400
Message-ID: <20220617193512.3471076-7-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220617193512.3471076-1-Rodrigo.Siqueira@amd.com>
References: <20220617193512.3471076-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 912fb20c-0faf-4b9b-c0ed-08da50989637
X-MS-TrafficTypeDiagnostic: DM6PR12MB4579:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB4579D02B6BD68D93F0ABFA2E98AF9@DM6PR12MB4579.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YheOM4eI1COQZUPxRZcbdYNpw5NCvuefplWqiI/iBECQ5US7CE86lcd7UuDlfMs6Yq8G3YDIBADKJMONBsgiFo2XHQ0muTP1QPSU6bjGO8AnbgL6OPItpsLGP7PVhh1RVANZP3+XKY/tVpRWBdHfupRi2X5YJqNcOb9uCB/5ngShjq8puRvKz0yDvPbSWIlkteKNiS82LlJP+z+fiD3stKSCcdeyTliHrpUQfVK0yL6/SWMMVUGGcVBTJ5ZWZFvfd48wWD3SoYCUwDrw3B2VK6y8ufj7fSNNcfcRhZGtOGUO4z1BGLbSK84FyZ3wRqRhpby4Nw/7uBINt2KeKeeaLpAzM3B4q2LgkFnoqD6TklsPXilsoxvvm59uhzq98iEke7G4AlEzJhI0sUSFykdvs5RAJAxQF9toTM2k+IvCo7rfGAz/bmfnk8UOV6A4ZRQAFDgRuEFLx3Vtnl/UaBSckpYm7LrKXgi0erGR0cem3FZbfo4bKh8lILq4BWZ+HJhghW4HZGbN7DXIP9O9/x7sbRjm1n8aCNr3oF3EcDsmx+7wYBwuQzYR1V8xQFXD6qtnMmwbpR1Gn1r63hDL8BAJUvaa9PfEck/RSXSGjwqLEUdzut6V4yOxku9XicLbciNE86RKofdIwd7MRpnL/qaDCmoQnjvtgmfj6TG/84G842vYhj7K7T65PpmvkLk9Vn2urZkr9L4tLXVJv/zEdOaSPQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(46966006)(36840700001)(40470700004)(336012)(2616005)(426003)(86362001)(7696005)(2906002)(4326008)(82310400005)(8676002)(70206006)(70586007)(54906003)(6916009)(316002)(26005)(47076005)(8936002)(36756003)(36860700001)(1076003)(81166007)(40460700003)(5660300002)(83380400001)(356005)(186003)(16526019)(498600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2022 19:35:51.1052 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 912fb20c-0faf-4b9b-c0ed-08da50989637
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT064.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4579
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
Cc: stylon.wang@amd.com, Ian Chen <ian.chen@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, Wenjing Liu <Wenjing.Liu@amd.com>, solomon.chiu@amd.com,
 jerry.zuo@amd.com, Aurabindo.Pillai@amd.com, hamza.mahfooz@amd.com,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Ian Chen <ian.chen@amd.com>

Delete unnecessary codes in detect_link_and_local_sink. We already have
correct stop logic in dc_link_detect.

Reviewed-by: Wenjing Liu <Wenjing.Liu@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Ian Chen <ian.chen@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index 199868925fe4..fac27b45230f 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -1142,11 +1142,6 @@ static bool detect_link_and_local_sink(struct dc_link *link,
 					(link->dpcd_caps.dongle_type !=
 							DISPLAY_DONGLE_DP_HDMI_CONVERTER))
 				converter_disable_audio = true;
-
-			// link switch from MST to non-MST stop topology manager
-			if (pre_connection_type == dc_connection_mst_branch &&
-					link->type != dc_connection_mst_branch)
-				dm_helpers_dp_mst_stop_top_mgr(link->ctx, link);
 			break;
 		}
 
-- 
2.25.1

