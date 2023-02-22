Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFE81C64EC4
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Feb 2023 06:42:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 73A5210E3FC;
	Wed, 22 Feb 2023 06:42:09 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2061.outbound.protection.outlook.com [40.107.243.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 607EA10E3FC
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Feb 2023 06:42:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EYemoLk39sqM43LwqiyEf/EMMmvXnMy+c43T5lz7AEzl7mBkaxIlsOl0272f0PkePZXsvAEmSIb6yuEuJMDr0DSlo2qmnJQNAruvDblt3NiaCPWFYCGE94oDkfvy9psrRqeUJQTlK4Ypu+VpTtARXXQT3+MFhm/QifggMOuO76z3d5apFOJztUQtR4LfFVAJW8gsyLNlwwbzSwgg3dS7gTppaJFnUG98ohNg1ykAI5MSW30ciTOLjUXUHey19FuI0QNqPXd7foMz8g2bB+g7whA3MwHy2oCB5mmMmfELr83/ASPUeGGvUc6zpgTZhqJ2iF8OMZhsSQlbfq/w8nFxyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CTu2dZa4/4W1As3mTfeAsmzFAKztSN7NOOI22CJrk4Y=;
 b=L1+02YC5Y38ldlm3zpPNNW8VzZErSs6aos8386oeMRB2SoTwwvlWk1Vp7ffikcbXmvHLk3ho/AvbmFbz9pqxPYXrSyzqoIufjjz0DBehse5iXAEVEaHP0X9dSKJwnphh1i2Fpwf+5EMrOPWtcw2iMKjCWiC/ZZipB4FIWtNniOgfzhhy/ztLcmbhScEqYbp99W5eLl1nLl3eVE337q4ihUWvM5fljr50vkFakQZfKBI9lX5nKiHXEiLb7RuZszalP+Exwu/6XPTQ7GNT+sWFzQhHB73r8GKEY+MGDha05G5w3C2F4Wf9AfE++aeY6TgHNdSkqPxo57jUqFpAgSxr3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CTu2dZa4/4W1As3mTfeAsmzFAKztSN7NOOI22CJrk4Y=;
 b=LPHRHHE0g13qS2Um7S55c9r9ONB4xRSnPpyRDnJQZRFSKJ4nxWvcdlqT56vhPo1azMAv43wplLGbbPPPChCTUcxVorCCbvF7X722xodkNg0hHbXdlmYWbLaeIrAmkeif+Bsj5igpC4jpF69rHMCGGGjKMtYPoVrEJlHDqYgEltU=
Received: from DM6PR03CA0075.namprd03.prod.outlook.com (2603:10b6:5:333::8) by
 SN7PR12MB7226.namprd12.prod.outlook.com (2603:10b6:806:2a9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.21; Wed, 22 Feb
 2023 06:42:04 +0000
Received: from DM6NAM11FT056.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:333:cafe::1f) by DM6PR03CA0075.outlook.office365.com
 (2603:10b6:5:333::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.18 via Frontend
 Transport; Wed, 22 Feb 2023 06:42:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT056.mail.protection.outlook.com (10.13.173.99) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6134.19 via Frontend Transport; Wed, 22 Feb 2023 06:42:03 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 22 Feb
 2023 00:41:56 -0600
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 08/20] drm/amd/display: populate subvp cmd info only for the
 top pipe
Date: Wed, 22 Feb 2023 01:40:29 -0500
Message-ID: <20230222064041.2824-9-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230222064041.2824-1-qingqing.zhuo@amd.com>
References: <20230222064041.2824-1-qingqing.zhuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT056:EE_|SN7PR12MB7226:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e91accb-b76f-40b9-ca1d-08db149fe8a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: q7hTeH3FDpQdcC8gOD1kYZsR3c5klm/lvMB9J1ven4qPddgPv3E+Te7tkt+vz5WYR+DCTJeg+V5VCL+oXzl1+1Z73PVmm8ulWP2t72GocGiugAcLUH4if1b8VOOmaKOT/LUZzTlvesxjbye5Z5eeDk9mcLi+PYwu1e8KJF1RTkFZGsFpy55QRe+OdcRVq5IqCeTQEwGj0IgUEemHdyXSIJuqAh15fr9k7xSUftotbVYOJJ+A3tg1oUFPQ7ejxUdbGeYzbO/xwXp+/CQI2sSrDYJGmc9AfZGYbbrPjOwDASvPztZVJXcNuJgUDmTIH267ZGHAJ9TVmXdiYE7ehC9YJleYB32tLDqJD7teA5jmJJVR6B6+LVlaTRfK/J4Um+I6SryQ/QbUWchLO3hk2xOlkAdBevQWRW8SQG34GJGaWpvTarJ4Y2B6w1gh94lTmlMJm36Mje8Pbuw1RQxobTpqlmZ9ai3T1sNp5lau2WhMDOLWq3wo3UkW2Y4bWDadCURUTObOEXpGoLpt9jOr2DzExiwB6SnPhtSwIN9T2drtGzPHI7tcyjUtRwytq1eVtgVgOgpykEjqs6Am34HJodQuxXaWIvG3BzrBL7hJcKcf4/FWlsXLjwVr0mfWIH1Ipfq/Od2U/Boi4Z5fyLaJd0ZgSWLDaAVD0aIpWthWVD5eIuVm7k3WsEzI64jI4eANx2wjicQfbxdvj3sl2Y+3LcFf1lJY/PqDmiJzibyRh/U8xak=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(376002)(396003)(346002)(136003)(39860400002)(451199018)(46966006)(36840700001)(40470700004)(82740400003)(81166007)(2616005)(54906003)(82310400005)(356005)(86362001)(478600001)(36860700001)(83380400001)(70206006)(6916009)(70586007)(5660300002)(2906002)(8676002)(41300700001)(8936002)(1076003)(40480700001)(186003)(40460700003)(26005)(6666004)(426003)(316002)(4326008)(16526019)(47076005)(336012)(36756003)(44832011)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2023 06:42:03.7483 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e91accb-b76f-40b9-ca1d-08db149fe8a0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT056.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7226
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
Cc: stylon.wang@amd.com, Ayush Gupta <ayush.gupta@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 Alvin Lee <Alvin.Lee2@amd.com>, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Ayush Gupta <ayush.gupta@amd.com>

[Why]
System restart observed while changing the display resolution
to 8k with extended mode. Sytem restart was caused by a page fault.

[How]
When the driver populates subvp info it did it for both the pipes using
vblank which caused an outof bounds array access causing the page fault.
added checks to allow the top pipe only to fix this issue.

Co-authored-by: Ayush Gupta <ayush.gupta@amd.com>
Reviewed-by: Alvin Lee <Alvin.Lee2@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Signed-off-by: Ayush Gupta <ayush.gupta@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
index c2092775ca88..7f27e29fae11 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
@@ -750,7 +750,8 @@ void dc_dmub_setup_subvp_dmub_command(struct dc *dc,
 					!pipe->top_pipe && !pipe->prev_odm_pipe &&
 					pipe->stream->mall_stream_config.type == SUBVP_MAIN) {
 				populate_subvp_cmd_pipe_info(dc, context, &cmd, pipe, cmd_pipe_index++);
-			} else if (pipe->plane_state && pipe->stream->mall_stream_config.type == SUBVP_NONE) {
+			} else if (pipe->plane_state && pipe->stream->mall_stream_config.type == SUBVP_NONE &&
+				    !pipe->top_pipe && !pipe->prev_odm_pipe) {
 				// Don't need to check for ActiveDRAMClockChangeMargin < 0, not valid in cases where
 				// we run through DML without calculating "natural" P-state support
 				populate_subvp_cmd_vblank_pipe_info(dc, context, &cmd, pipe, cmd_pipe_index++);
-- 
2.34.1

