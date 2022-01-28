Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4321C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Jan 2022 14:05:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3C87010EC14;
	Fri, 28 Jan 2022 14:05:08 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2084.outbound.protection.outlook.com [40.107.212.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 105CD10EE77
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Jan 2022 14:05:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X4z4taqYBu2NHMREi0rQEX3tXDP1PeMgFuUK+96qe2JlX2YipJgd+XEK+GeXKoJL/TswYv1d7cBChg8Et6sFyZJ8RIJmbtGlC5a01Djgvkb8UFv3ANLVITugmsSK2vxksHd+qId3RYXQa0zj9/nNAJG+7WhhGDOkG5so0rtRRGRLQPiwwQps72f7Y5FyN8Ha6DYFT0lQ5rRaHqTdmSI79KhYChM+uzKs0ZmhhBMnPehxEoyNOyAiSBA7cw/WNiSs9QjL2mgsbcgtLoDnS0jOOtTi4IetGYYVYr59uMKNxIgEknmp80fHpuF5VUNxUmsVqWEsVY20YF2O/rmlodv+kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nSXaNsTklCgP0p60K0KAFpVCkYg5ylREXZ8OM+hNi7k=;
 b=JwfVEcpuabs/695X6zLZd1+2tIFhKpAmSsCVHm2cEWeSJq/PgKMUekoRjM1Qmi5FjrDnrYN0o31IlVZsIaU/oXn/WMJYk/ShiMLpJX3b8esDdH14A5fyN45OgNkBQi/eAhq3Pjh8c5Ih3xH/jFnW9eLDgSu3DLYS4I/2+PWmMHuHHQPRcZWM3Xi1opzi2BN1GHROkMu4/5eNgoTJl9L7BRl38Wx/jDa/xK8KArdFr+gvYSxX32EJttJHA3tw4OHHTH15IB4JjAvTtkemGW1e4APkjdCvYustNobB+qyXzNXZRCG+nijqnkmcRKF4VrILPZImUp0Sg9axGemaC2IawQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nSXaNsTklCgP0p60K0KAFpVCkYg5ylREXZ8OM+hNi7k=;
 b=jRy/84TYaO9YQXp1sZA57U7GKSnFzo6NE9qHip3ICrNW6l35n+KTdIRtxrD/VXZj8Jmr9NoxCCpjDbZiNTYsGJZtKCxOEI6cbhrJMXSL7lkeVENljOz47T4Y0BT8vd36rIJtg5De2NpY0pqRr0jm4Hxjdzaa9S6vAz/7Dhe/KAw=
Received: from DM5PR19CA0018.namprd19.prod.outlook.com (2603:10b6:3:151::28)
 by BN7PR12MB2673.namprd12.prod.outlook.com (2603:10b6:408:27::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15; Fri, 28 Jan
 2022 14:05:03 +0000
Received: from DM6NAM11FT054.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:151:cafe::34) by DM5PR19CA0018.outlook.office365.com
 (2603:10b6:3:151::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.18 via Frontend
 Transport; Fri, 28 Jan 2022 14:05:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT054.mail.protection.outlook.com (10.13.173.95) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4930.15 via Frontend Transport; Fri, 28 Jan 2022 14:05:03 +0000
Received: from stylon-T495.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Fri, 28 Jan
 2022 08:04:58 -0600
From: Stylon Wang <stylon.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 02/17] drm/amd/display: Improve dce_aux_transfer_with_retries
 logging
Date: Fri, 28 Jan 2022 22:03:56 +0800
Message-ID: <20220128140411.3683309-3-stylon.wang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220128140411.3683309-1-stylon.wang@amd.com>
References: <20220128140411.3683309-1-stylon.wang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 364609b8-f91b-4c9e-1848-08d9e2672e2f
X-MS-TrafficTypeDiagnostic: BN7PR12MB2673:EE_
X-Microsoft-Antispam-PRVS: <BN7PR12MB2673F492FCB2B50825C5C1BFFF229@BN7PR12MB2673.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2043;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hOO7SqFiyS6A/v/k/9tfu8mVYXeTFpF4vbhDjEwn8+qyKCh69jPLtuzG0X+pWCtCfcv1xeNGYBpAKiaauiEaFwS5qtfvwbeC+OLxI/H0ohGep3r8GtaXfKTb+dfwHc81AStWjEwtsI0vTONlW30YLYVYe7PxkpRWdsnRs5JqOkcendbB7LiccMK/+xi2hEVck3eS1yHqKOCtJMymE6fFpRHKCDKO2+EbSCcunO7EoJrIbxra/pySQQEGd5J3WGlObpRLg32P6Ah/H8zkaxovG/bh/eVevRsdZPFBI6+mu9HXcW1JCdmeTHlmgIZVOhKc31ZuNsb3NstwejRMbwmH4yI+BoexILEMZ2NL/v7+JFMPw4vk7+fcjADD7gcz3cZiEFkzaPBI6fNKhnctwaLFlIDCvPTWxh29pzkqT9CfRrVHPQUn9dSF8nIKx9k88CNChq8v4Zc30xJtJXJa1TPbQVokIvDJUg9SBWnUti6mPaAQlF8tN8GidAP/IcD0dnMoMtIoVFO0cfUBVSibO54pPKmeYoFR2pBqmSdblgHS5X1dCRufjKimd9/EU5zJEsbysB/WCetvxBrvvNyvz76PRzu/pFm9vsAuLN73LejYFZYI78riacSp27SEUzGRvS9/NAWxwHy25rQAkZ7POoyXfE2EJVDClyvqub1sEOx64V+QSrr+q8p3MmDJiDJYwEfp2UbeTxcFbF4pt4FcA9Ybew==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(5660300002)(54906003)(44832011)(82310400004)(316002)(7696005)(6916009)(8936002)(8676002)(86362001)(40460700003)(4326008)(81166007)(508600001)(356005)(70586007)(2906002)(36756003)(70206006)(16526019)(47076005)(186003)(26005)(336012)(426003)(1076003)(83380400001)(2616005)(36860700001)(36900700001)(20210929001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2022 14:05:03.2889 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 364609b8-f91b-4c9e-1848-08d9e2672e2f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT054.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2673
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
Cc: stylon.wang@amd.com, Anthony Koo <Anthony.Koo@amd.com>,
 solomon.chiu@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Wyatt Wood <wyatt.wood@amd.com>,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, Anson.Jacob@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Wyatt Wood <wyatt.wood@amd.com>

[Why + How]
Payload reply is unknown and not handled in switch statement.

Reviewed-by: Anthony Koo <Anthony.Koo@amd.com>
Acked-by: Stylon Wang <stylon.wang@amd.com>
Signed-off-by: Wyatt Wood <wyatt.wood@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dce/dce_aux.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_aux.c b/drivers/gpu/drm/amd/display/dc/dce/dce_aux.c
index 6d42a9cc9916..74b05b3aef08 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_aux.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_aux.c
@@ -878,7 +878,7 @@ bool dce_aux_transfer_with_retries(struct ddc_service *ddc,
 			default:
 				DC_TRACE_LEVEL_MESSAGE(DAL_TRACE_LEVEL_ERROR,
 							LOG_FLAG_Error_I2cAux,
-							"dce_aux_transfer_with_retries: AUX_RET_SUCCESS: FAILURE: AUX_TRANSACTION_REPLY_* unknown, default case.");
+							"dce_aux_transfer_with_retries: AUX_RET_SUCCESS: FAILURE: AUX_TRANSACTION_REPLY_* unknown, default case. Reply: %d", *payload->reply);
 				goto fail;
 			}
 			break;
-- 
2.34.1

