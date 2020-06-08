Return-Path: <SRS0=JmOw=7V=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14CC6C433DF
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Jun 2020 04:59:44 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DBDFF20801
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Jun 2020 04:59:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="xni24mMQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBDFF20801
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8792E6E488;
	Mon,  8 Jun 2020 04:59:43 +0000 (UTC)
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-eopbgr750077.outbound.protection.outlook.com [40.107.75.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 288DC6E487
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Jun 2020 04:59:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BEIl3DKsICEfx/hH2dK/lWy/JL095iPSVEF+fMJNBU/Yn5fFGvtnMU3faxLdgk/3XJRE/adzO71dmyE5K2m37SsLKZDIDEPggl8Tfe0AQ0spith/gzPwW45JEskenW50EuJ5ryg4ayVTdNRROVLRz6lhEOpNNioAHmMQyY+scXIaPNjv3V3qYz4Zcqf/99Gd7WVYL0unQZxeikzZCISqcOMBqNgA49dOZw5CrhrWauD31s3jpZoRsIY+NORPH+rHuQ96+/NB1DBL/NSB/6T83lJfTkv0CH6/oJ4Ypr/Is7oAwIoAff+0O74owtokkJA5y4UB2XO4/H4Qa/DpV7HY9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ncQf/CGOgNlq5qVQk1RO9o/gjYWZdaoLaLifoVdOL3g=;
 b=YJ4HYTTshGP2+tVFruL6L4ePJp8Yo2+C/laJzwDrkyYspikD0CK9kf20lWkpDAWk+ygfixcjG1LNOj2mHxOsXc1xF2FCrX14dVk5vXblUVLMEKItwSjgvZJcdSKMdWl2ZhTHGrvaTJ7vzVyEm8WCuk7P7je7qlV+X03pEY/1M87JH6soXm+Ghxnd0ZPt9+yCatA6cCXKyT1pzF8yAwtC5Ribvab1lqop/+GTojpt/QjFXgXK7JoTj+zEl7v75DLCvGe5+6J8ldbz6IDghvZM2ssWAeEvYizF7h6GY6Wq0SH6hf2CFF4AiURKrVPyTEWu9sFjt5YpglN5MssbCGelQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ncQf/CGOgNlq5qVQk1RO9o/gjYWZdaoLaLifoVdOL3g=;
 b=xni24mMQ5YxqOw8GGO6BUADzSQn6JBUrqzibAG/TkZW3pbfBoBIW1Gfy6/93Yxlk7BNOieoS7dioaYDJKbvyytR6EGbj9oSNPY/GW/OujY5y/X58DT+xlAfE80Fi+QAftAcM4CCVsz/GZYFd0n9Cv08hygxZD0LVcspEHLGZNhs=
Received: from MWHPR22CA0011.namprd22.prod.outlook.com (2603:10b6:300:ef::21)
 by BY5PR12MB3764.namprd12.prod.outlook.com (2603:10b6:a03:1ac::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18; Mon, 8 Jun
 2020 04:59:39 +0000
Received: from CO1NAM11FT055.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:ef::4) by MWHPR22CA0011.outlook.office365.com
 (2603:10b6:300:ef::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18 via Frontend
 Transport; Mon, 8 Jun 2020 04:59:39 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 CO1NAM11FT055.mail.protection.outlook.com (10.13.175.129) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3066.18 via Frontend Transport; Mon, 8 Jun 2020 04:59:39 +0000
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Sun, 7 Jun 2020
 23:59:33 -0500
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Sun, 7 Jun 2020 23:59:32 -0500
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 08/28] drm/amd/display: Revert "enable plane if plane_status
 changed"
Date: Mon, 8 Jun 2020 00:59:06 -0400
Message-ID: <20200608045926.17197-9-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200608045926.17197-1-qingqing.zhuo@amd.com>
References: <20200608045926.17197-1-qingqing.zhuo@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(39860400002)(346002)(376002)(136003)(46966005)(2906002)(316002)(186003)(54906003)(26005)(5660300002)(36756003)(6916009)(70586007)(70206006)(6666004)(336012)(8676002)(82740400003)(82310400002)(81166007)(356005)(4326008)(47076004)(478600001)(86362001)(44832011)(83380400001)(1076003)(8936002)(2616005)(426003);
 DIR:OUT; SFP:1101; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b7ea71da-adf0-48ef-c6f2-08d80b68bf96
X-MS-TrafficTypeDiagnostic: BY5PR12MB3764:
X-Microsoft-Antispam-PRVS: <BY5PR12MB3764C041E271A9B76A75B51AFB850@BY5PR12MB3764.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:74;
X-Forefront-PRVS: 042857DBB5
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: D6vRvGj1lhxe8KoZFQCI38oJJuUhBYkcdnhF0npAHhF2O/TjHEiz4Nkq26MsOFh66fY5H1j4Vq3FhnyaU6u0n0XpuMX4Rwgq3dXp1jk950A9VB8hJcy+csN0+j2GbisM6OMs72YXT2ymNmxEoOVcmJzeJw7rwEGA0TPXZMJqfJgmN86c3gYd3fL+pGUnp7D9g/2Rq2P/O4PsG0BLAWjLSUGoPpyz3hljHReFOAKyTgGLOugqperbsCf3NJ+BaPtWZbRfX97R4ewPZ+sFNsWetgxAhy0pb+3V6SSk1BUUT3P3K+w7zNuWGuJP7qCrzHVGkkKzayd2eV2HyyqFchJZvt9RMopCNdtDZdoz0tll+fdDd/A10bXjvcLUalhZnQsZXI1lstfG7hpJJ7YNfwVEfQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2020 04:59:39.0020 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b7ea71da-adf0-48ef-c6f2-08d80b68bf96
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3764
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
Cc: Sunpeng.Li@amd.com, Harry.Wentland@amd.com, Hugo Hu <hugo.hu@amd.com>,
 Rodrigo.Siqueira@amd.com, Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Hugo Hu <hugo.hu@amd.com>

revert commit 77dcea7a0b133b362b2ebbf494eb13ee3e946836.

Signed-off-by: Hugo Hu <hugo.hu@amd.com>
Reviewed-by: Tony Cheng <Tony.Cheng@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
index 0b318f799db3..65e83fdd7b44 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
@@ -1209,20 +1209,13 @@ void dcn20_pipe_control_lock(
 
 static void dcn20_detect_pipe_changes(struct pipe_ctx *old_pipe, struct pipe_ctx *new_pipe)
 {
-	bool plane_state_update = false;
 	new_pipe->update_flags.raw = 0;
 
 	/* Exit on unchanged, unused pipe */
 	if (!old_pipe->plane_state && !new_pipe->plane_state)
 		return;
-
-	/* Detect plane state update */
-	if (old_pipe->plane_state && new_pipe->plane_state
-			&& (old_pipe->plane_state != new_pipe->plane_state)) {
-		plane_state_update = true;
-	}
 	/* Detect pipe enable/disable */
-	if ((!old_pipe->plane_state && new_pipe->plane_state) || plane_state_update) {
+	if (!old_pipe->plane_state && new_pipe->plane_state) {
 		new_pipe->update_flags.bits.enable = 1;
 		new_pipe->update_flags.bits.mpcc = 1;
 		new_pipe->update_flags.bits.dppclk = 1;
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
