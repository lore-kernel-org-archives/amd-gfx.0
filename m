Return-Path: <SRS0=JNIh=LB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EE1AC47082
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Jun 2021 16:49:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F13C60FE5
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Jun 2021 16:49:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F13C60FE5
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 33FEA6E944;
	Mon,  7 Jun 2021 16:49:18 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2063.outbound.protection.outlook.com [40.107.96.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 847FC6E941
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Jun 2021 16:49:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TQlupj9Yj+wWplEG7gnLoMXdr913JK0Xy+Dsjsr26Nvq+sxRlOT58HY/4Dg60oZfM8Y7lhgiYG2OmqSz5yw+LQO4F7HhMMEjV8iz+tZDyMdEKPh5+JSwLXQe39ol1GSmEL+0Dz6j4ei1S49PhyvWkHJCCILsyT8hMvnUEgtUVE++KsHpyv5NKohPL1YtvrhZ4UTrlTw9zIVaQdcEDdD90UQ4+3Lwabzw/8X0Vmq454QsVyd3tpPDSczeFbSutJhDh7gYkWgwz5kPEgXleSNjR66PAN7i70u3u1uYZ8sxxc6UlUVf0hJ864AfKF/6xdFQh49lBBvko6IkL4IQd1jFJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fLtegldO0NQro0PdpAWshGUOAVw4tXye+d6QORZIa+8=;
 b=DURg4D//1US1ealIDhkuVYFtyOVROOgWHHb66zyMh4H+0yHqHhG5vkoNft+gF/r86Go/bEAyxAc/RjMkXNTHdYptOWnzzFIZaSnBuHIbdVKmcTNPPHAzhsaMauGVzG9+I/UBUUK3CIqfo8BShUWFlSZp/VAwkStIk4y3L07oTq2nT4fN4sr8zfZWEcsUPRTN9GCcznXadp+wr1J/RhZRkauADr0adSXhfhRlHiVR7v5PZRTTjATt3O3iOkO6Mbri/HX1mbt3sidi2flAlirngKvV3skUFcWKuzxt9rVqW3ySOT9ejmRjUxrUOhJOXCZ5btHsdI7BabcCSr1akR23Hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fLtegldO0NQro0PdpAWshGUOAVw4tXye+d6QORZIa+8=;
 b=Jr9igfnxcoNPnBsaCgZIG7v3z0WlbcjoRB2u44Ttc0feo1TGGX497qul/Nk/OQdFaLB8kvLBbc0JVMukGzLLjYQs7Rm0leppT+velDS72WLmBr5AfoFxElf3iOOYQkn1uCx3VHCR5MDwZY8KOKaNdZm5X23fUrLWZw0syjGUv4Q=
Received: from BN0PR02CA0024.namprd02.prod.outlook.com (2603:10b6:408:e4::29)
 by CH2PR12MB4166.namprd12.prod.outlook.com (2603:10b6:610:78::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.24; Mon, 7 Jun
 2021 16:49:13 +0000
Received: from BN8NAM11FT065.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e4:cafe::e1) by BN0PR02CA0024.outlook.office365.com
 (2603:10b6:408:e4::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.23 via Frontend
 Transport; Mon, 7 Jun 2021 16:49:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT065.mail.protection.outlook.com (10.13.177.63) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4195.22 via Frontend Transport; Mon, 7 Jun 2021 16:49:13 +0000
Received: from stylon-rog.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Mon, 7 Jun 2021
 11:49:10 -0500
From: Stylon Wang <stylon.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 26/30] drm/amd/display: Updates for ODM Transition Test
Date: Tue, 8 Jun 2021 00:47:10 +0800
Message-ID: <20210607164714.311325-27-stylon.wang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210607164714.311325-1-stylon.wang@amd.com>
References: <20210607164714.311325-1-stylon.wang@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: af3f0b00-e434-4c97-45c7-08d929d42e68
X-MS-TrafficTypeDiagnostic: CH2PR12MB4166:
X-Microsoft-Antispam-PRVS: <CH2PR12MB41665CEB23288208EE3EF3DBFF389@CH2PR12MB4166.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1751;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dY2OCGmonTEXceW18USpNSceEDRGEH3TulBCnQ+rWJCtBfMiFbwA2CGi+kyTQ4Z2719ljNqbEaU2b636SZZtzY90FFE0cRVLKpeh3lFNqpyn9p0r5DG8VK3D50H8eoYv5idRnc5tsh868cRFzyNdbmW3uXqX1nwhMjr732LBNHtd+US+epuSBjoOs0w5A+sSjTkN+iLy/13pQewnAXbmf5BH0N1mdcZixpgnugxlM4BumhzE6E8RgfZ3gPQ1yNwowiweJ7XfoUqDeI69VRf9TWVfPA4q44tMxOiBR1+1HfcFd7wE7sqOvfJX6WQi4ho9sJrc4R8ZSV4qC7nKymizQKXiI/njBS9O9qGiKiXLMKdL9Rz19YhKXC1UT6aBH/5A168or5yBImtke3gXHWAlCn/c/jgHpqtdiWIHGvy17jUaktutWREVybGe/1FniUzcPSdwV/JkW23TzNEwa4GAHFLn/cZFlrLu1X/lp+9nvrcPl8zfzOlOQNpMJinG6jmRWeLJz/le2TMfaFjh/tYlOWwdz047iIAgePexEdMB+YG9DUkrZZhTPh6OUyIWweaqzx8+HS8QZ23i2w6Qf5L9xVK4jfVXeLtCuqpuHS1JIHw9z0y3cwQUvHZuLahtm9ZYz8cCk+Kp4AqzxxAavpxGTHUThBDMAEZznM/U4d2zX4yaNsMLbQjnN5EE9BKU8AqU
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(376002)(396003)(39860400002)(346002)(136003)(36840700001)(46966006)(36860700001)(426003)(8676002)(1076003)(186003)(36756003)(44832011)(26005)(336012)(16526019)(86362001)(478600001)(2616005)(8936002)(70586007)(81166007)(70206006)(82740400003)(54906003)(6916009)(316002)(7696005)(5660300002)(4326008)(47076005)(83380400001)(356005)(2906002)(15650500001)(82310400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2021 16:49:13.7358 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: af3f0b00-e434-4c97-45c7-08d929d42e68
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT065.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4166
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
Cc: Stylon Wang <stylon.wang@amd.com>,
 Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>, Eryk.Brol@amd.com,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com,
 Eric Bernstein <eric.bernstein@amd.com>, Bhawanpreet.Lakha@amd.com,
 bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Eric Bernstein <eric.bernstein@amd.com>

[Why]
There is an assert in cases where transition from ODM 2:1
to ODM 1:1 (bypass)

[How]
Remove assert since this case is now valid.
Update diags tests for ODM transitions.

Signed-off-by: Eric Bernstein <eric.bernstein@amd.com>
Reviewed-by: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>
Acked-by: Stylon Wang <stylon.wang@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
index 43a6b6cf201e..7d26f51ec427 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
@@ -2789,7 +2789,6 @@ int dcn20_validate_apply_pipe_split_flags(
 				split[i] = 0;
 			} else if (get_num_odm_splits(pipe)) {
 				/* ODM -> MPC transition */
-				ASSERT(0); /* NOT expected yet */
 				if (pipe->prev_odm_pipe) {
 					split[i] = 0;
 					merge[i] = true;
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
