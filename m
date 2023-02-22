Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F27B5C61DA4
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Feb 2023 06:43:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A11FC10E41B;
	Wed, 22 Feb 2023 06:43:32 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2050.outbound.protection.outlook.com [40.107.93.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EE11A10E41B
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Feb 2023 06:43:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iQlKj+8dl9o2+qoDBKSu1pk0qGdA29jYtX+eN6MIkGSq7KD5jMvdP+rzx7DQrfzT2NqRkJ3QjX6sUXy+uLIy/dDXsfwnJ9JtU+CtI7kGysGtVc2bT6dlP/VcVyR1b1iqCkgrrxbiKVBKd4BwutWMmvME+4zeMZOvs3t6gewDh7rBedUqYYkl/V6vUUK1J6LwzGXbjO6t4UCy8jGjEK7KygO5Uc/XKJzfDIHcauDZscRUMNU2VPg7kNj8TKDW6v4ZXAZ5Dtld8QCqMgGBh+/zD+o/3QOEJaSG2bk7hWVd7LQCTafF6qpowR7KeNmzRvBQZIx51s4xD2x/IaUt6zQ7gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h6Q3KhuGTru35nNBijnckFYUyk4J+lI0VdzOPxhq50g=;
 b=d+cL70+Ig9kO6vAEd+PXa0JYJfxAmLQ9RxxJe+gFzNbzCXCXMzxi7i9Ulk+KhWDCZxYNDf662zKf+iSFIt5LQD+X5UrXhM0UZfSspMtaXd/WTPrjt+cdJqsaWNIr5sUAAkFURElsfrYPr6Eh9CebRFAclxJnuuxjUxgtLShyWjiCVTeeOiibCsuOm5UIHUuBrPs7UpNf26TB+QACoPbwQkRyYe6P/Nyh3pBJWJfWa86r2ODJ6vTE7L5G/vObN986X0+PUgcSISss2KduybOGQ4SceRUyL+8ZMfCfx+Iy1B96jBOUb73J59W8ZrxtZVIkVKBFxjtSn7SYpPsz/NG+ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h6Q3KhuGTru35nNBijnckFYUyk4J+lI0VdzOPxhq50g=;
 b=CARTTT92Z/OeEjWNBwhoPIhSLb7OJ6a37VWSYgQalkmGvkwAf8r60eADxiHfo8laFXB/h0lNbQfKpcCMnSE8/coB3h2nCWSqBF7G4uNK0Exv7WJ1/vgAIsRp2dEnbfp/9p918PTU4Q3uuFlUQHd92ksKeSCROZKpyp15YWkPPFY=
Received: from DS7PR03CA0073.namprd03.prod.outlook.com (2603:10b6:5:3bb::18)
 by BL1PR12MB5755.namprd12.prod.outlook.com (2603:10b6:208:392::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.20; Wed, 22 Feb
 2023 06:43:26 +0000
Received: from DM6NAM11FT071.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3bb:cafe::69) by DS7PR03CA0073.outlook.office365.com
 (2603:10b6:5:3bb::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.19 via Frontend
 Transport; Wed, 22 Feb 2023 06:43:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT071.mail.protection.outlook.com (10.13.173.48) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6134.19 via Frontend Transport; Wed, 22 Feb 2023 06:43:26 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 22 Feb
 2023 00:43:19 -0600
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 19/20] drm/amd/display: Only wait for blank completion if OTG
 active
Date: Wed, 22 Feb 2023 01:40:40 -0500
Message-ID: <20230222064041.2824-20-qingqing.zhuo@amd.com>
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
X-MS-TrafficTypeDiagnostic: DM6NAM11FT071:EE_|BL1PR12MB5755:EE_
X-MS-Office365-Filtering-Correlation-Id: 095fd31f-6395-4618-a0fb-08db14a01a18
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: u3AXpZqQb54DoUGm7HoLippIZSKz+RPCSmvME1dgks8nS8HT4UXMtxdffnnwnMIEF2VHkUgnLBCSZXWdZGKc8Y+bBHYnwnt08vLdGM1dIfd+ddJmYZZGlYSzjkgf6R8eZjdybBXelZwlMcJs3O0HHy6y3T9VwZmKZk7XCFqhHYULzLeq3YY3jsqr4SgWVaAWaC8z88phCPqptqPljJm2enuxrOoYlgmWtBmeveAvGg+aTIcSRrUJ2f2yTNC/8WAIJjymBCU8HIS4PV87YuMcljTUIeQ8RAIwtkYQmeQyMDbYNxqTJac02nRCvg1eiU+C3k0NlDArtAixgmtXc79614tp1KYtsSCDU7dSTw5uxyDjCWmQ+kL8Qcmu94/ZPzUPCl+uw6FY1wwIJzQ5CW424OSXxIqcADQo1R7g8CiVhrJPIPxu5OKZIafT0GNhwIET9afy4ccDESMM7S0ViXskD4f0oUVYsgRoiaM0I0b94Q29RsnMILKolG5nEPz5GXerzdnj0G6gnmz8WiY0PPrMpEEEmoEuOEWpBbDCD1mid/NQpEvQLHECV7wEUlM7NR9VzVOJNFs0JMkf5vVwlm89sKS+S2dSOCBd7Ng+NvedR+9XZUIqPFcFUd6gr1DhMqO6Tj1vx0kisexngDEwh1TfnuJ+gXdb5ikbvxVqI6TkY7GvdnMD7O2WpojGxKRTLVfKWMAxextadCDjBX0JvViIMSm3U1yoLOt2fdpLtVpPRYM=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(376002)(396003)(39860400002)(136003)(346002)(451199018)(36840700001)(46966006)(40470700004)(5660300002)(44832011)(36756003)(40460700003)(40480700001)(83380400001)(426003)(82310400005)(47076005)(336012)(478600001)(6666004)(16526019)(186003)(2616005)(70586007)(70206006)(8676002)(8936002)(356005)(4326008)(6916009)(41300700001)(36860700001)(1076003)(54906003)(86362001)(26005)(81166007)(82740400003)(2906002)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2023 06:43:26.7420 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 095fd31f-6395-4618-a0fb-08db14a01a18
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT071.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5755
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
Cc: stylon.wang@amd.com, Aric Cyr <aric.cyr@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 Alvin Lee <Alvin.Lee2@amd.com>, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aric Cyr <aric.cyr@amd.com>

[why]
If OTG is not active, waiting for blank completion will always fail and
timeout resulting in unnecessary driver delays.

[how]
Check that OTG is enabled before waiting for blank.

Reviewed-by: Alvin Lee <Alvin.Lee2@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Signed-off-by: Aric Cyr <aric.cyr@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 8d7b2e5516b0..65b3c3052628 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -1100,7 +1100,8 @@ static void phantom_pipe_blank(
 			otg_active_height,
 			0);
 
-	hws->funcs.wait_for_blank_complete(opp);
+	if (tg->funcs->is_tg_enabled(tg))
+		hws->funcs.wait_for_blank_complete(opp);
 }
 
 static void disable_dangling_plane(struct dc *dc, struct dc_state *context)
@@ -1163,6 +1164,7 @@ static void disable_dangling_plane(struct dc *dc, struct dc_state *context)
 			if (old_stream->mall_stream_config.type == SUBVP_PHANTOM) {
 				if (tg->funcs->enable_crtc) {
 					int main_pipe_width, main_pipe_height;
+
 					main_pipe_width = old_stream->mall_stream_config.paired_stream->dst.width;
 					main_pipe_height = old_stream->mall_stream_config.paired_stream->dst.height;
 					phantom_pipe_blank(dc, tg, main_pipe_width, main_pipe_height);
-- 
2.34.1

