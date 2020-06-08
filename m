Return-Path: <SRS0=JmOw=7V=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7F04C433E0
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Jun 2020 04:59:50 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E8CD20801
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Jun 2020 04:59:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="oxN7ggdC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E8CD20801
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 22E576E499;
	Mon,  8 Jun 2020 04:59:49 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2052.outbound.protection.outlook.com [40.107.223.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2D5BB6E48B
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Jun 2020 04:59:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JWtgXzjtMr4O7fu6i7/zHz1u/k8Xg/Yyv+MX8CgckVtUGS2vxNeVG2o/zVKC144PIrJlrdIlBHJ+yXkoeCsKnLSmAcz588nc5e1i8BpgUwobdA8SLiQQY8rIdldkGtA9s7pgX60VH76W8AP3qSzKdUm8MdutNQ2IcUWAv5n7yvV2VJDTnqCgqo6H2MTOqcyNBo6UIBw4eu855zBIf24NA677HGbYjlN+0y6k8MaaFQSkLdinbEZz7bqdwxAeeAgfz8ud5X/aiL/ey0zRQGJMTdQN6W3J8oZhTOSSMpYyAHQVKiEyRnIhQ1trce3mJP5KnMUVLZxC0H2NCTfmGNRucw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=USwaT7ZQVAfXAKxjz8hIE2njKf/yp2tctYUjP9aFpsc=;
 b=euNL279encArIu+N/0HrzWw+rbpgXb/VnKxvOpIlZ4GveTDCEwf1NLB7n6Smn+q4edM+fPBCgyaO3WWCPRoTBuCnLrve64sLx2x8jIoPdC9JW5bRSbUT0nHJKKX54lbpMiDOghuHzN/KtjU74Qj3aGruVTPAPdV4ADed2B/AnmvhCfWiXBUsZTeqbHcsgidongvZbiF+CkyWTobgYQKOjqm7mL6LOrIIdsohLZetnFwaCcqRJ7rUWHdLhxPWK7dWNAT5pwpncEeAKYtdj4LOAHyBAtukYM4ewHSE+oF2FTO9CMky18UKNtilEx20yINjXs0w/6gXuoORvOfbwVZ1/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=USwaT7ZQVAfXAKxjz8hIE2njKf/yp2tctYUjP9aFpsc=;
 b=oxN7ggdC1Ecod4njugi5hkOOegJ/xfEQupPmNmDnJwR3iAKTgmApDNIF3zORGBf6Qo7QCfjb9cOqYXjrgY7FGXKpi7LYnXlF5QWe1R7aC2p+0XlZJbr6Xis3ZtiLPPWA1AmQ99l8+ECFQ65cWHlaVXZS01s1cYAtD+XTFn0OqJY=
Received: from DM6PR11CA0019.namprd11.prod.outlook.com (2603:10b6:5:190::32)
 by DM5PR12MB2342.namprd12.prod.outlook.com (2603:10b6:4:ba::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.20; Mon, 8 Jun
 2020 04:59:41 +0000
Received: from DM6NAM11FT040.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:190:cafe::c2) by DM6PR11CA0019.outlook.office365.com
 (2603:10b6:5:190::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18 via Frontend
 Transport; Mon, 8 Jun 2020 04:59:41 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 DM6NAM11FT040.mail.protection.outlook.com (10.13.173.133) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3066.18 via Frontend Transport; Mon, 8 Jun 2020 04:59:41 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Sun, 7 Jun 2020
 23:59:36 -0500
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Sun, 7 Jun 2020
 23:59:36 -0500
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Sun, 7 Jun 2020 23:59:36 -0500
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 14/28] drm/amd/display: Passing initial SDP deadline to dmub
Date: Mon, 8 Jun 2020 00:59:12 -0400
Message-ID: <20200608045926.17197-15-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200608045926.17197-1-qingqing.zhuo@amd.com>
References: <20200608045926.17197-1-qingqing.zhuo@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(376002)(39860400002)(136003)(396003)(46966005)(5660300002)(54906003)(82740400003)(356005)(44832011)(2906002)(2616005)(81166007)(8936002)(86362001)(478600001)(6666004)(186003)(4326008)(8676002)(426003)(83380400001)(36756003)(1076003)(70586007)(82310400002)(70206006)(316002)(47076004)(336012)(26005)(6916009);
 DIR:OUT; SFP:1101; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 532a33c8-4bc6-45d6-362f-08d80b68c127
X-MS-TrafficTypeDiagnostic: DM5PR12MB2342:
X-Microsoft-Antispam-PRVS: <DM5PR12MB234252EC0D3B627AD1E4829AFB850@DM5PR12MB2342.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-Forefront-PRVS: 042857DBB5
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: I6h8q7yyNco08HxNkp4I1rPsCD+xDo72vkmaRLv+PubHVCEAy1fszxlpslcVMaSXvwYvvUrV3zn5djDWKFaCEY7Pm9bKJdUknYCzteRz5NdhqDNn3hBYEzAzsn6pE1vpPUdvKnl69pIFrIqmQhfVwPOk8m7SJimWsPLu3Jz0T+H6HOUTnqxrYB2M1AqXlsfChwV3vhh7Neq2mwUhET7Mng1xM9iunFMySrMigvdj18glu1LcJZacb+1DEt4SNVunr9YQdGOuNLOB/ZMJzkfKNam/3UfjWAS6eZ/Za2G+BG9veiCnwJ6X3cDaZjSx5OS4dzwxbAqUEFxF8dS0yE0Hyp0jcBR5sAOqHOCBNgnl2pg0eVe2H8G1JMYGfKrgGqPaDVQf9oUrG3CvQmrhjsUGhQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2020 04:59:41.7162 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 532a33c8-4bc6-45d6-362f-08d80b68c127
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2342
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
Cc: Sunpeng.Li@amd.com, Harry.Wentland@amd.com, Rodrigo.Siqueira@amd.com,
 Aurabindo.Pillai@amd.com, po-tchen <po-ting.chen@amd.com>,
 Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: po-tchen <po-ting.chen@amd.com>

[Why]
The SDP deadline indicate the vertical time to send CRC
infopacket in PSR.

Signed-off-by: po-tchen <po-ting.chen@amd.com>
Reviewed-by: Anthony Koo <Anthony.Koo@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c b/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c
index fd4e1021903a..916d305d3022 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c
@@ -233,6 +233,7 @@ static bool dmub_psr_copy_settings(struct dmub_psr *dmub,
 	copy_settings_data->frame_cap_ind			= psr_context->psrFrameCaptureIndicationReq;
 	copy_settings_data->debug.bitfields.visual_confirm	= dc->dc->debug.visual_confirm == VISUAL_CONFIRM_PSR ?
 									true : false;
+	copy_settings_data->init_sdp_deadline			= psr_context->sdpTransmitLineNumDeadline;
 
 	dc_dmub_srv_cmd_queue(dc->dmub_srv, &cmd);
 	dc_dmub_srv_cmd_execute(dc->dmub_srv);
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
