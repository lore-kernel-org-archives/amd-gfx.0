Return-Path: <SRS0=EPaF=PD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 019EFC433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Oct 2021 18:44:22 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C43F460C4A
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Oct 2021 18:44:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C43F460C4A
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C1D3B6EDEE;
	Fri, 15 Oct 2021 18:44:19 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2059.outbound.protection.outlook.com [40.107.244.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E9EC46EDEB
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Oct 2021 18:44:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZiTC+miuuaTww43onSKFs0kmtVxLaGkCtlyZmJCvLx/oXzeexvsR9Y8t9sPuClQhzqtJNd5fmzfQR4uZh1vgH3wlraKsiWBlgKLYYIkRkK+zFkif++430GYIYrNItHV9ThqgWs/q0R5hEu5NiwYtwkwQ2ZA5DqbIIoqDUPB/wR0CdiuH46PaQhK6wC00apzNXrjxfN5LZcBaRYdlFosF0ZoLfnlZL43bnKu63tDwsBRHKkPFKtifQf6E5j1yTn/LRG6r0VYvceNlXrnU8sAr1JSeOdHHJUvnX9DRVLFCPprYcHe21+9L3NO4t0XYD4+apZhS6bUcr+zm1+FhNBaMVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JeGD+sdxwTc/pqxjArr8t/Q95fsi1YhyAIZSBkwadsg=;
 b=kroHwLVRrxJKXfDHrOgpJ1P5SQ1hXXZLa3UN96KsZHEl3X6nRS8dHc1rbhtLQIxSx9vlf9r64KJ9l2+cSGfW3VNOLD7rQ+Z8x11d68XeFSNubN0y/caMlHlObR66ItTtGENQgYS+6OlYIHPEuWo+I6KRvVdeKc+1EH6T9h/bTpFeC7nFxUI97LlWUB0r/J70BRcin8tPjmR1I6imOHuQQEWl9ldgae9lJAUoq5ZtUtbAsZDiKd3G8/Qw03g7kM+2Ux2qgFQpDmx/epWKpGkRlB50Losdc/s4YhzufGaBi2pn4lxNzyjZ3bz5rZBPtBONOMtNESOQFly7onGqctzqhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JeGD+sdxwTc/pqxjArr8t/Q95fsi1YhyAIZSBkwadsg=;
 b=e/iUNdTQMrgqW9/hNsldo0Zdz7tY+OVugw79QOa/Nbkrt/F9mNZX9VWxLL4upojcSA7zaFA01KPi5USk+xV03YLD7qOD2WxPywk/92IPPa3uUh58iqrEfByQTn4zOi1i8R0qVjniGyYj6TH1XxnNIGNR+K7X74ckLMePlTcC//c=
Received: from DS7PR06CA0029.namprd06.prod.outlook.com (2603:10b6:8:54::29) by
 DM8PR12MB5399.namprd12.prod.outlook.com (2603:10b6:8:34::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4608.16; Fri, 15 Oct 2021 18:44:15 +0000
Received: from DM6NAM11FT037.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:54:cafe::16) by DS7PR06CA0029.outlook.office365.com
 (2603:10b6:8:54::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.14 via Frontend
 Transport; Fri, 15 Oct 2021 18:44:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT037.mail.protection.outlook.com (10.13.172.122) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4608.15 via Frontend Transport; Fri, 15 Oct 2021 18:44:14 +0000
Received: from ubuntu.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Fri, 15 Oct
 2021 13:44:12 -0500
From: Agustin Gutierrez <agustin.gutierrez@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Bhawanpreet.Lakha@amd.com>, <Rodrigo.Siqueira@amd.com>,
 <Aurabindo.Pillai@amd.com>, <qingqing.zhuo@amd.com>, <mikita.lipski@amd.com>, 
 <roman.li@amd.com>, <Anson.Jacob@amd.com>, <wayne.lin@amd.com>,
 <stylon.wang@amd.com>, <solomon.chiu@amd.com>, <pavle.kotarac@amd.com>,
 <agustin.gutierrez@amd.com>
Subject: [PATCH 26/27] Revert "drm/amd/display: Fix error in dmesg at boot"
Date: Fri, 15 Oct 2021 14:43:31 -0400
Message-ID: <20211015184332.221091-27-agustin.gutierrez@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211015184332.221091-1-agustin.gutierrez@amd.com>
References: <20211015184332.221091-1-agustin.gutierrez@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a504070a-17ff-4506-5a5f-08d9900bc954
X-MS-TrafficTypeDiagnostic: DM8PR12MB5399:
X-Microsoft-Antispam-PRVS: <DM8PR12MB5399E3FF952A1D17F0A4D536F5B99@DM8PR12MB5399.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:126;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UvOitQWeYBFTNCbF6Fx4mtvIYQCNlmDMCrAJfg8gWgi4HIqwONV3SaxlAuh0PMa2AZPbKm94RfsjYi1CzpSxdKi/DMJkw+OqXP/xljge+pdBGmE5ic6mP4mRNvt1HySRGsLjSqruqcrQdcyG/x+bu4TtWq3MpCRXwiwG7ItWFIDWKp2pSqSqOXCP1rFvVNnvIEH7yAnDXKlqyojupKpaZ6rPGDhYvMdMh8qeJTS2FRiHDZHk46KB/rC7jwd/rCUYZX5IIopBQFbU8rS7nda/zfNZ4L0AWHllDwZnOg+EXQqxSMclyiWWH/kLwTvUkRwQcOKaILYWWqWOr6vYMzt/cgIcfYwdgelg8NyBc6kKgfYcIOfaj3FGOPgHLDqSL9FhJywac9rODrwmu+lBtyE+8TsqKTjJ64loLlEp5H7ACtxzIMnLqIEzdoleb3hZxFDmP+95tzCBwLiESlKNAoH7w0JycRefVZo/0AMExED8MMZv26BD44yBnf3usaMbBLI6aQuNZv4bAzG1hIDHvcq78PIpPc/0WwUih0Bk0bQ12HU7XnuFqRqa525ODvzR3v3tsXU1apUv0I1/WQPqPYAfRdSXlMe+nf7NNhpnJUvoZBxJI2+nPdppuXxE9bQQjO0EWOzxWgrs7bILml5FB25KPFd+DJ9NgTLWnlEYTIDSqy5ox+JoW46ZZG48f28tLwEy1EiOZG09hFYYBK20L3Hn82n443+pWMUuoPqN9ZqHDhw=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(5660300002)(186003)(36860700001)(81166007)(70586007)(8676002)(316002)(356005)(16526019)(70206006)(54906003)(6916009)(44832011)(36756003)(336012)(508600001)(426003)(47076005)(86362001)(2906002)(6666004)(1076003)(2616005)(8936002)(83380400001)(82310400003)(26005)(4326008)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2021 18:44:14.5624 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a504070a-17ff-4506-5a5f-08d9900bc954
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT037.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5399
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This reverts commit 4e605d4b6a510f751b22df4d13829aefb8a0ccec.
---
 drivers/gpu/drm/amd/display/dc/core/dc_link.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index 6db611f9f554..c01309a1cbf2 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -1999,7 +1999,7 @@ void blank_all_dp_displays(struct dc *dc, bool hw_init)
 
 		if ((signal == SIGNAL_TYPE_EDP) ||
 			(signal == SIGNAL_TYPE_DISPLAY_PORT)) {
-			if (hw_init && signal != SIGNAL_TYPE_EDP && dc->links[i]->priv != NULL) {
+			if (hw_init && signal != SIGNAL_TYPE_EDP) {
 				/* DP 2.0 spec requires that we read LTTPR caps first */
 				dp_retrieve_lttpr_cap(dc->links[i]);
 				/* if any of the displays are lit up turn them off */
@@ -2025,7 +2025,7 @@ void blank_all_dp_displays(struct dc *dc, bool hw_init)
 				}
 
 				if (!dc->links[i]->wa_flags.dp_keep_receiver_powered ||
-					(hw_init && signal != SIGNAL_TYPE_EDP && dc->links[i]->priv != NULL))
+					(hw_init && signal != SIGNAL_TYPE_EDP))
 					dp_receiver_power_ctrl(dc->links[i], false);
 			}
 		}
-- 
2.25.1

