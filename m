Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81054C77B6E
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Apr 2023 15:54:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DF00310EDCE;
	Fri, 14 Apr 2023 15:54:23 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2056.outbound.protection.outlook.com [40.107.244.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C3CEF10EDCE
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Apr 2023 15:54:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ezRileaDfuEay7/i9o2uEDobr+Y5Pahnp/0uxCKy6w2Dbpa0Xj0T6EwKQHkeAkX7YfP06XC+x8Pbs+XyZ2jnhFY2ISBf+DGamXFg+M8tehgVkyqZzySg6ttjNyZNPH9PZanlBkXAZWsQeskLkkB29CmiOzIyW4dgRcMs8LG9IvQxFK/XxE2BsoyT5OijnxrhqUq64zqSEV3p2X4B7VnXkcw+gL+jST0ekOp9O1T5+Q6rrRfpIBPLJD9ffkynQG8WqS9g2RI/uOZZdM3vJX9H387L2J2fsh20g75ADVGTx1/KeeFC9W5DkqoCx5GYOQw+reEOd1G3ph6ITrgDdnUFRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aTb3TCbRPzBXyaYWoHLcrYoWfxAGjI+CqFLYDXRYnMw=;
 b=Ukc146g09wFFD2jcfds1H5B0KXkGzyTlf28UQGNfBCh/p4OyD1NmjNTvEp4baBhA5kbdIN9NtikF/KDOWI/rYAnVGvFkaAU2ieYO+x94BUa+w0O70u/YQGHvSzXRrOokc+yIStpEErKgMVIxGyuUFmZSHaINLmDyHj7v3DoP1e8McWIWqrN3r2oeGBNJUt+wiYI54ZSs9s/LOvcFPiMZeivuMJ1+3UcxFX+mRP2q5IsNCyWnpKGQCXqbZG5cn5SKNX2nrDiF9VWlrx5bI7z9LQx+aoy0MN5SbEWKSlN/LDdPdOFCTGkupxgPLp0Z/ZdSOGt2++fHbJPl4M62j/YzYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aTb3TCbRPzBXyaYWoHLcrYoWfxAGjI+CqFLYDXRYnMw=;
 b=LVN2CgSHa7EWGu0vqG39DTs/NEZBTE3SAkFSwKa0A1wemuPjRuYohkxNTnbxxt38ha/vC+lNI4b/AAthAOKfyt+bkDpMaUdCIM/40s2zMIpYjVtdKzZpmPMtL4W9sGqBZ4zjiyn6vYSA2P7fmQsK34nnfQZnRb7RV0GKQf9G/8c=
Received: from BN9PR03CA0126.namprd03.prod.outlook.com (2603:10b6:408:fe::11)
 by DM4PR12MB7720.namprd12.prod.outlook.com (2603:10b6:8:100::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.30; Fri, 14 Apr
 2023 15:54:20 +0000
Received: from BN8NAM11FT025.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fe:cafe::fc) by BN9PR03CA0126.outlook.office365.com
 (2603:10b6:408:fe::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.36 via Frontend
 Transport; Fri, 14 Apr 2023 15:54:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT025.mail.protection.outlook.com (10.13.177.136) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6298.31 via Frontend Transport; Fri, 14 Apr 2023 15:54:20 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 14 Apr
 2023 10:54:18 -0500
From: Qingqing Zhuo <Qingqing.Zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 22/66] drm/amd/display: drain dmub inbox if queue is full
Date: Fri, 14 Apr 2023 11:52:46 -0400
Message-ID: <20230414155330.5215-23-Qingqing.Zhuo@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230414155330.5215-1-Qingqing.Zhuo@amd.com>
References: <20230414155330.5215-1-Qingqing.Zhuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT025:EE_|DM4PR12MB7720:EE_
X-MS-Office365-Filtering-Correlation-Id: f7f4d3d5-20ae-466f-ac96-08db3d008276
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: src5NE/UcW2kv6mjS9Seehs0KMiPwlPaVbsjVDcSLWtYjgQQbzQfvaCjHurt0Usl8qUa51J8l4Vj2k92mP27YY9CTPcpw2I/om37JdrcjiHMLBMKGUfvIokAwB82G9Sh+AqyL0vQrGFk5NOlpnDLuFa/RdS7AZxIeCzlxCW2509sPntyGrO4BFcUAe6OjHj9K25dApsplbZ4eaiqD6fNJtk9JCfAjIOQLsFJMUXxWz2gwu3wQPnoe/XactdbIFW1FDJTXRBk4WtU79VVC3CFhuOPI7XMIbRjehcPuW+Cnwb/YCyqwXDAFyhjSmke2n8gLwWeGIGTeLtwnrFQhTtJ5hxB9Qy9i+rI2vqsfO7BXXvlvEH+JfdH1V6XtkLPaPk4rRBfG2+nRANMeviapjo7RKcRCFU7mYyDl32WmuFDFhwvy9BNp0j9uvujQ0miAVwj/S7+uk33YZxJVmF5dDwJZ0fHSf8ZE3+zS/vRrfbxjbIwJkvkNB/jBiWx0Ok0N0CpXb1LavWNpLrPaJJT4mYJxsblO1g40jjgu1nYi5ZWn4zU9f+djQ1G2yd2rDo3dTIlBFzaN8B+lFEAMV5eFojIW5ZE+85TJha48/0KfS15IL0s7DMMIJZvw8Ke20/+thzuyJeYh/n6IUukEcOw9DPiYHoecPgVpRDdLFh7iaDWAtWxY4maZAPmngSpb0Eh53Bt14AFMAmlZkvvW25T95H7+GTqJyf+w0g6pKGxb0/271M=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(396003)(376002)(346002)(136003)(451199021)(40470700004)(46966006)(36840700001)(83380400001)(336012)(47076005)(2616005)(426003)(1076003)(16526019)(186003)(36756003)(26005)(36860700001)(6666004)(54906003)(478600001)(356005)(81166007)(316002)(5660300002)(70206006)(70586007)(6916009)(41300700001)(4326008)(82310400005)(82740400003)(2906002)(8936002)(8676002)(40460700003)(86362001)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2023 15:54:20.0854 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f7f4d3d5-20ae-466f-ac96-08db3d008276
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT025.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7720
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
Cc: stylon.wang@amd.com, Josip Pavic <Josip.Pavic@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Josip Pavic <Josip.Pavic@amd.com>

[Why & How]
If dmub command queuing fails due to the inbox being full, flush the
inbox and resubmit the comamnd. This was previously the default behavior
but was lost in a refactor.

Reviewed-by: Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Signed-off-by: Josip Pavic <Josip.Pavic@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
index 954cbfdbc3b6..eef43577508c 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
@@ -139,6 +139,15 @@ bool dc_dmub_srv_cmd_run_list(struct dc_dmub_srv *dc_dmub_srv, unsigned int coun
 		// Queue command
 		status = dmub_srv_cmd_queue(dmub, &cmd_list[i]);
 
+		if (status == DMUB_STATUS_QUEUE_FULL) {
+			/* Execute and wait for queue to become empty again. */
+			dmub_srv_cmd_execute(dmub);
+			dmub_srv_wait_for_idle(dmub, 100000);
+
+			/* Requeue the command. */
+			status = dmub_srv_cmd_queue(dmub, &cmd_list[i]);
+		}
+
 		if (status != DMUB_STATUS_OK) {
 			DC_ERROR("Error queueing DMUB command: status=%d\n", status);
 			dc_dmub_srv_log_diagnostic_data(dc_dmub_srv);
-- 
2.34.1

