Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8D19C433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Mar 2022 22:21:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4A9BC10E463;
	Thu, 10 Mar 2022 22:21:43 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2049.outbound.protection.outlook.com [40.107.236.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2B50F10E463
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Mar 2022 22:21:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dJW8XVlfjZjdCvlQ3OsaeIIOutaGm2x8bXw3OTOsv8JqAXUSg0xES6R4XvD0+N+NXIaamkGxnhHXDlouA9IcJbSeTEcDizsaiJvrt6ZPIbyrFr4jvOUdAJgo7gIm9Ft1wGFawiNYRBtfRW5+MXJSjxy8PfgsiSQiNZG0Amp2jyQHBMwX+CNwISE83xOI5jaBm+a6RNP5Y23W58db0KJbEqVhDOJ4WrAISjhyz6Hf+6m9d8hzRWSqBkVSgteuZ3gOuJyzvyQGT0hnx0mQYzynffI8nLDy/8x2DzoOPVqQpfCRkDIkwyiSqmOAM8zK8wk7usF7Neac4VRbjiNXtiBOnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FbpBrTO5tEN5Sp1WnOXLh6IBpd0s47kRDGeke+dOaFY=;
 b=gpKgsBTK8A1u638f7BxwyZQS3WJDNIgg+vEjidBpDNauAd7pjx926gLUN42Wm3W23+3gFyXwRslzG5POfQKgJZV9QqOnzxr4A9xM2yXsqhT4/B01XYV79sxgmeM9/WKLpDCYZdHxXzdNbPTAxFGGepVtB1mPLu5lsE8vtBYbF3kuTsu0JPC3RbxZP9eaVNzGfr5vlqSQfvyuUyATMwKJ8VfKl3/K7JWLzWVu9D5vXgGut5HefS7fWfaOBJVIuw2C6MvKxx9cf7DXqg5CDmUywgUbPv8je153iQ7TZtHuy2evZUuTdi05DSu/pbKq/MQAeGYUo1+jP/E1jMLrxTpuTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FbpBrTO5tEN5Sp1WnOXLh6IBpd0s47kRDGeke+dOaFY=;
 b=3pWEApdqEETugLm30mtLLJjJTXoubH1M0TYDFvomLFB9xY9Z3MCemW4fxnEbR+yenocHXwp8faHveI9ugmJdN87BsIOdntCcNKba2rrLN5aQvUEL3V2v+r2FT8w+jS9hsTCQf8O4CAvjsZtchr5im2YDikmDRzglqhV7c0Ea5oY=
Received: from DM3PR11CA0003.namprd11.prod.outlook.com (2603:10b6:0:54::13) by
 SA0PR12MB4511.namprd12.prod.outlook.com (2603:10b6:806:95::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5038.15; Thu, 10 Mar 2022 22:21:37 +0000
Received: from DM6NAM11FT067.eop-nam11.prod.protection.outlook.com
 (2603:10b6:0:54:cafe::4c) by DM3PR11CA0003.outlook.office365.com
 (2603:10b6:0:54::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.20 via Frontend
 Transport; Thu, 10 Mar 2022 22:21:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT067.mail.protection.outlook.com (10.13.172.76) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5061.22 via Frontend Transport; Thu, 10 Mar 2022 22:21:37 +0000
Received: from Linux-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 10 Mar
 2022 16:21:33 -0600
From: Agustin Gutierrez <agustin.gutierrez@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 05/12] drm/amd/display: Block zstate when more than one plane
 enabled
Date: Thu, 10 Mar 2022 17:20:38 -0500
Message-ID: <20220310222045.664867-6-agustin.gutierrez@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220310222045.664867-1-agustin.gutierrez@amd.com>
References: <20220310222045.664867-1-agustin.gutierrez@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2c4d80d2-6637-4f6b-2b1a-08da02e45792
X-MS-TrafficTypeDiagnostic: SA0PR12MB4511:EE_
X-Microsoft-Antispam-PRVS: <SA0PR12MB45111588CE4A6023453606D6F50B9@SA0PR12MB4511.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HrSHPUdtfi1vI44q5/s2o9BVIxU0siKxd6vzdUsxdqOuXOVugCWuXSUh3i5PazSvu85oU7a2f2Khn9XZAx2cDxVsrhnJ5f51qZ8HP+qOCZbNDYezXdxxWPHIMzbSX8FmVy7XW2/uxze7sRrIHAJYXw8Lr9PkUE1oUbvoPWK6tcesOqD9091OpUbPVWJRfrOQzsaG21/dLpqpK3DFBqkOt0dR+Sv7NTk8l4LYQGUPd5gZJpdDik8A7Yl0YtNFM+r+kIS6MKmSMG90eZmevurAsokurtgVjshXGZcc+ECsrv4qWCKbAr7ZfqN4tQPVR0gOY+iG3Ry1DGc2npcppsj7PLe6M3LaXG7/lAvSZ+uSlkHxx9bLDzGXbR1gL9NLa2TV/tM9KFxzX1xd2ORDCbkkfvNtVEg9BdSBZKCEkw8ajlFSNO3KcMlDsX/JXLyNw2gMegzPRUAKDs3PQ32H1hoz3vqkjIlIv59gpnTjXHigE1VDTA+/ahpYqCUhCxe5SfRINM/gITtDsTAi+UgwB2BCyB1ydhyypYlldAQbXgHXMNJUofolYx56DMSktI3ZlBOh5D82F6HPIw/YVNYCgcjeYbb3aZD+/MHsh8aMEjd+AMtcrDlw/SRmgk+VQo7eMill6PMh1IuOAQzk/fKjVec8fIc+XrjqmNXHDESf+8MX0eepFzFV9sIGFsq7k/kyjuzaqHmcTPmpK4yD4KVOwhQcVw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(26005)(1076003)(4326008)(8676002)(82310400004)(70586007)(16526019)(70206006)(336012)(426003)(83380400001)(86362001)(356005)(2906002)(81166007)(44832011)(36860700001)(5660300002)(40460700003)(47076005)(8936002)(6916009)(36756003)(54906003)(508600001)(2616005)(7696005)(316002)(186003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2022 22:21:37.0248 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c4d80d2-6637-4f6b-2b1a-08da02e45792
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT067.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4511
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
Cc: stylon.wang@amd.com, Eric Yang <Eric.Yang2@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 Nevenko Stupar <Nevenko.Stupar@amd.com>, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Eric Yang <Eric.Yang2@amd.com>

[Why]
Currently Z10 save/restore only covers 1 plane case. If we enter
Z10 with 2 planes enabled, 1 of the 2 planes will not be restored.
causing black screen.

[How]
Disable Zstate when more than 1 plane is enabled. Right now Z9 enable
but Z10 disable is not a supported config, so we disable both.

Reviewed-by: Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Reviewed-by: Nevenko Stupar <Nevenko.Stupar@amd.com>
Acked-by: Agustin Gutierrez <agustin.gutierrez@amd.com>
Signed-off-by: Eric Yang <Eric.Yang2@amd.com>
---
 .../gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c
index 7cc8c78cb163..2f6122153bdb 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c
@@ -730,18 +730,22 @@ static enum dcn_zstate_support_state  decide_zstate_support(struct dc *dc, struc
 	}
 
 	/*
-	 * Zstate is allowed in following scenarios:
-	 * 	1. Single eDP with PSR enabled
-	 * 	2. 0 planes (No memory requests)
-	 * 	3. Single eDP without PSR but > 5ms stutter period
+	 * Z9 and Z10 allowed cases:
+	 * 	1. 0 Planes enabled
+	 * 	2. single eDP, on link 0, 1 plane and stutter period > 5ms
+	 * Z10 only cases:
+	 * 	1. single eDP, on link 0, 1 plane and stutter period >= 5ms
+	 * Zstate not allowed cases:
+	 * 	1. Everything else
 	 */
 	if (plane_count == 0)
 		return DCN_ZSTATE_SUPPORT_ALLOW;
 	else if (context->stream_count == 1 &&  context->streams[0]->signal == SIGNAL_TYPE_EDP) {
 		struct dc_link *link = context->streams[0]->sink->link;
+		struct dc_stream_status *stream_status = &context->stream_status[0];
 
-		/* zstate only supported on PWRSEQ0 */
-		if (link->link_index != 0)
+		/* zstate only supported on PWRSEQ0  and when there's <2 planes*/
+		if (link->link_index != 0 || stream_status->plane_count > 1)
 			return DCN_ZSTATE_SUPPORT_DISALLOW;
 
 		if (context->bw_ctx.dml.vba.StutterPeriod > 5000.0)
-- 
2.35.1

