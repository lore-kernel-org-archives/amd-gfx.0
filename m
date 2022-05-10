Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9CCEC433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 10 May 2022 20:46:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 76E0E10E866;
	Tue, 10 May 2022 20:46:04 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2085.outbound.protection.outlook.com [40.107.237.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 54AB810E89E
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 May 2022 20:46:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mZF78em8e5/IqfPEov9K6PCNcUZcGE94LF1pPQlvC1s+kE0kQEMZc6BLn6DZlbIe9lvtF/z3un6kk8qekXmQvVgI7J4GUYs0qxgRpC98jgeeg8DoByZSSBYRIseRlls3uzOGsxTjdAoTDIueffH5sDmVBSz5D5gIUbbXPFSvLrjOJut9QMOV44NEB3u/H18qRrh9KkMexcG59DYEPtJOs8ac8AynCJsxx4F/EWOnJpcFXAnGqw9c8fOAUXYsw0Wf3kQZ7oOQoMFxQ/z+ey9OdGdCaqTHni6JldZmvcX5AFATu2p1IeN1X38/xTnl4ahssmzavb1Cc90TvbfTWlR0EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vr4sVRH+iQ6fgOZyONe4GEtAdhtwDCYkq5Z6cF60FC4=;
 b=BdcnkkBeJHOgujLi2AYXmkEei17M03OMyxT4BIpi59dqywPcMnxusAeq8N4vF+v+ROvfxu2LU3u3g+oipS83M4gJu6Nab69qQzFw2peZkhmHsAfn0r3hOxW6sFB2CbaFOu93pCnhRMoCQWkP3DODfUOvV+bS0VMcP8/mJi6AeaPuIdlaKB8wJ4BaTUn3NPdzOZFUmq3QxqcNU2AJhcqQKjSlQmVdzReUc8Z7XfF/tT32fBrrTB1SLmjbrqpmMGxYFvNwTA489kSeL8PUSLaqeSKJ2aAnPLtCK4RlvP9iPGwgUmaYXv1uJ59GSM0F976O+3rbM3DbX+MdqY61uzypYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vr4sVRH+iQ6fgOZyONe4GEtAdhtwDCYkq5Z6cF60FC4=;
 b=TgANNO8kA0Cmkuo3ff6FglYZOyh0O2sxysMN/p7idak13rdivWQaCmNW16zvzzFqkk0Ew6B5xqBVZaUIclfBaG15/dZdo3vPV1ZSIsS2Fi7RqLUQvps93/3Qlipj4LqKk93Yyiq6xbkajEGhKVSUn4KsPoUytAP4+Gvuge3KGPQ=
Received: from MW4PR03CA0220.namprd03.prod.outlook.com (2603:10b6:303:b9::15)
 by CY4PR1201MB0005.namprd12.prod.outlook.com (2603:10b6:903:d1::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.18; Tue, 10 May
 2022 20:46:01 +0000
Received: from CO1NAM11FT056.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b9:cafe::1e) by MW4PR03CA0220.outlook.office365.com
 (2603:10b6:303:b9::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.23 via Frontend
 Transport; Tue, 10 May 2022 20:46:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT056.mail.protection.outlook.com (10.13.175.107) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5250.13 via Frontend Transport; Tue, 10 May 2022 20:46:00 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 10 May
 2022 15:46:00 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 10 May
 2022 13:45:59 -0700
Received: from xiaoT.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.24 via Frontend
 Transport; Tue, 10 May 2022 15:45:54 -0500
From: David Zhang <dingchen.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 08/19] drm/amd/display: Set default value of
 line_capture_indication
Date: Tue, 10 May 2022 16:44:57 -0400
Message-ID: <20220510204508.506089-9-dingchen.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220510204508.506089-1-dingchen.zhang@amd.com>
References: <20220510204508.506089-1-dingchen.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0626258f-c99a-451b-8d85-08da32c617b4
X-MS-TrafficTypeDiagnostic: CY4PR1201MB0005:EE_
X-Microsoft-Antispam-PRVS: <CY4PR1201MB0005AA2F5FDC9A489898F5148DC99@CY4PR1201MB0005.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DK8xmOKA05B+qAXmS1C3s7qV5lzI65/n6soTjLnMpPVg/Pe0mZLpBUlyDXDnNL6sLG/4PqOaDiBCYWNK/BeOL6PdQPYX5A4i7h8af2sjROkYa2GX61Gbh2g8D5BYv/IOBCLWUmqary4bNOaop/EcwWNVUtBaoHyhUW1HadwY7IfuqDLRrhUfNv1CB2cXfr+BsCTwNnp6MSSf/sKTKQGs/eYLM+PaCdaE/MrGRc1JLvi+oAky8V4rs3tgYnZIQkicC6eZDKMfNo8TeWb/rwOmv+aQAjabTGg7DH61PN3Rd6lMGfGr/Sk6D5FRPtIvWc1mc2vdPpEmGIcpQBhg3U3muTIT9mmAdJA36sMNAS+Qbf+Wg2D3wN1aDYO2eb2XPwekO+RXcXPsJcfsOuJD9Cjc+Q/QFtbUytOKOmgGSKIJZueEJ+QFZeuxDjxWdq89Okh4m8JIQ3WxD6KsWGOq7UAUJYKIKGt+5DBM64RjlkatAHF+z25GIIP+Pz89fuXy9JEKrp9f0rII+tJlXEPwNH5/qW6RFBmP6hQsawWBJDtNPs/Z0lvKp3y8zDUncOgZh2YGzJBn4E1HunxgakDPKqsqqu1geVYxEmA7zd94Y9F/JRIFEk6DmEcIycj8B5qU1rNbfLmKeoMiLurLrj4QtVerFEB1RcZogA/xPzb29q76o6YowhIKeRmDYvjyWceRaRSHV5qlzHRGGHkwmkgMAcdDhw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(7696005)(54906003)(6916009)(81166007)(508600001)(1076003)(4744005)(8936002)(36756003)(2906002)(186003)(316002)(47076005)(426003)(2616005)(5660300002)(336012)(70206006)(70586007)(8676002)(82310400005)(86362001)(4326008)(40460700003)(356005)(36860700001)(26005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2022 20:46:00.7093 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0626258f-c99a-451b-8d85-08da32c617b4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT056.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0005
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
Cc: stylon.wang@amd.com, David Zhang <dingchen.zhang@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 jerry.zuo@amd.com, Aurabindo.Pillai@amd.com, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Why & how]
We only support line capture indication as 0 for PSRSU

Signed-off-by: David Zhang <dingchen.zhang@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c b/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c
index 6883dd5b80d6..bc4943205bce 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c
@@ -339,6 +339,7 @@ static bool dmub_psr_copy_settings(struct dmub_psr *dmub,
 	else
 		copy_settings_data->su_y_granularity = psr_context->su_y_granularity;
 
+	copy_settings_data->line_capture_indication = 0;
 	copy_settings_data->fec_enable_status = (link->fec_state == dc_link_fec_enabled);
 	copy_settings_data->fec_enable_delay_in100us = link->dc->debug.fec_enable_delay_in100us;
 	copy_settings_data->cmd_version =  DMUB_CMD_PSR_CONTROL_VERSION_1;
-- 
2.25.1

