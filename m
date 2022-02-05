Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB7C2C433EF
	for <amd-gfx@archiver.kernel.org>; Sat,  5 Feb 2022 04:33:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 89AE110E67A;
	Sat,  5 Feb 2022 04:33:30 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2047.outbound.protection.outlook.com [40.107.101.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 888CE10E67A
 for <amd-gfx@lists.freedesktop.org>; Sat,  5 Feb 2022 04:33:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i0m5mQMq3RV2GUjqrdsZof0MPasPDviwrAZlswTaKWHAfjkkeHHPQZwPQW1FK5J5dE/XpddHkD3H58/Ddxm+DXTy6AZrlv1cGe0bSovHSEpVt5wPG66dTLgnCNUBdtzHkkLNHVQeuMXCTUu8N4RW9fHstDvdoIcWZSwKQbgNlXWI8iNr6mqXSmu3Rh98XR7J5D9RZ7JamK3aewuEvxPLqeTHXIX0T44dtyPXqpRvMEX66L/fd4DFbxcjQXp++cESSvR67xfZFMu2foW1FW3n739ED2qVzkHJ/zzQ1TnJQfXbjCuZu1Afvt1kaVHDYArMBjtQ8/uU3BijgnpeZ3SN1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+Fo6q/M9rvEgna8FPIKJVrGr5721DQ8dEzihaiJrFEI=;
 b=ES9CVTKOg1LNNoWAsdfXHw62/VMckkDRZQFaiy4FUDpDyCsawdVCvpfayyLLUgEd7K60q0Le+dvF0SgynBV2647m7PS+F2CJ25to1iezotZuaxM+3jjIxGt7X0UjQnboALrjRCfHvRghP/5qAfRxPZS5cJ6/fisUPpk19RJNemprcGrPrLxjYhszdEaZh2vQLIugsrEfH0gNKjzLxqz7xjA57skM/NV2zO7g3pzHkX9Zr7FhrnOvOmXcaoywmNE01yy6gYwqULFAg+4O1o55Y9CaOjtnGchoyJFBzDZ5PL4SvisTryV3fJNSpa3d1mDuqC/v+yw5CrpzxWeJXyt2AA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+Fo6q/M9rvEgna8FPIKJVrGr5721DQ8dEzihaiJrFEI=;
 b=gEmjbhMMf0KBuAJeZ9pVaDmDZesT32ydimbs17otsxKxB5cOMAfXBxrBcP4Rvjz1Vaij4zud/vpqERkJ1rOujgRADDxZ+pxXSh4IqFFwuqczUnWhuqr9VlkwJsIuZTXnHtHXlcrRhIytJdGgmZRyXqcOGiNPszlfb5mcfrQMDfE=
Received: from MW2PR2101CA0011.namprd21.prod.outlook.com (2603:10b6:302:1::24)
 by BN6PR12MB1618.namprd12.prod.outlook.com (2603:10b6:405:b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Sat, 5 Feb
 2022 04:33:25 +0000
Received: from CO1NAM11FT061.eop-nam11.prod.protection.outlook.com
 (2603:10b6:302:1:cafe::f3) by MW2PR2101CA0011.outlook.office365.com
 (2603:10b6:302:1::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.9 via Frontend
 Transport; Sat, 5 Feb 2022 04:33:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT061.mail.protection.outlook.com (10.13.175.200) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4951.12 via Frontend Transport; Sat, 5 Feb 2022 04:33:24 +0000
Received: from jasdeep-System-Product-Name.hitronhub.home (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.18; Fri, 4 Feb 2022 22:33:23 -0600
From: Jasdeep Dhillon <jdhillon@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 02/13] drm/amd/display: Fix stream->link_enc unassigned during
 stream removal
Date: Fri, 4 Feb 2022 23:32:59 -0500
Message-ID: <20220205043310.165991-3-jdhillon@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220205043310.165991-1-jdhillon@amd.com>
References: <20220205043310.165991-1-jdhillon@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 09ada53b-c150-40c4-51af-08d9e860a618
X-MS-TrafficTypeDiagnostic: BN6PR12MB1618:EE_
X-Microsoft-Antispam-PRVS: <BN6PR12MB161876DCC299F4508A6BB7EBFB2A9@BN6PR12MB1618.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RRKSR2C6SmRQN4LJXjzgl61ashnQeY7bIHc/jdmtqUuU48p9V5v9J1a/nqYnLBCCHoaVtr/5CEWzdvKhSYy03tJ8mOKadPqQK7rZNfj81n7JudzvfQtOegNZxpkXp2nhq5SLbgPhAnGb/t94HLGGCYZ9YbQLNN6MfMcvK03ExKu5gmJup+NvBz6v7YJRT971wKuC0hNeOuRzay3nZjffT7CvKljEC8hZDi7F4ciIDloPD0Uy2SmwPDSZCktEe8D09cnlvJI7XPFMA76sQSR1E+QPsS/uGJ+3BJpsarjjfMIf8CuqoWepoYXGYOdCpsnopiStcTDjQsa1p9btIRt/Knd6ohj2JKUXEXbk1JKUfXfRhDSS3mX8QXiP1d614nL/UMSiyv60PS/UrPS+v+QOg+a0p1GTFTUs2j8z+DH6FhfdMMm81aLV7hhITvMSmSQ8l7KAZkiHSUl0OySHZR5K8IktbDaohPv8u2ctIcW1VqGyxmx/JYlCKjFduUxisi9aaXhY9NMCtfJKTwU+ocOuE0MU3AegafqcXvlUAPrKNO/OHkhRt/AQWT/UGRIr+n8dEan2VUrvr8gOVLt2cdg3HtxXoWkxVGYH0Ko2qbwbDuuS3uKXnOHzRPNS7B/VJphJwxdaBYcDK6P4fdx0HHYbfYV1JUemfWAaULKfr18WkpjxJhDeDvRzC85Lgf3y53VvQ1Lc5BndXwaoSNjIlt4PMw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(82310400004)(83380400001)(8936002)(8676002)(4326008)(356005)(5660300002)(70586007)(81166007)(70206006)(36860700001)(40460700003)(54906003)(6916009)(316002)(2906002)(47076005)(16526019)(1076003)(186003)(508600001)(26005)(6666004)(2616005)(426003)(336012)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2022 04:33:24.8877 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 09ada53b-c150-40c4-51af-08d9e860a618
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT061.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1618
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
Cc: stylon.wang@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Jasdeep
 Dhillon <jdhillon@amd.com>, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, wayne.lin@amd.com,
 Jimmy Kizito <Jimmy.Kizito@amd.com>, Bhawanpreet.Lakha@amd.com,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

[Why]
Found when running igt@kms_atomic.

Userspace attempts to do a TEST_COMMIT when 0 streams which calls
dc_remove_stream_from_ctx. This in turn calls link_enc_unassign
which ends up modifying stream->link = NULL directly, causing the
global link_enc to be removed preventing further link activity
and future link validation from passing.

[How]
We take care of link_enc unassignment at the start of
link_enc_cfg_link_encs_assign so this call is no longer necessary.

Fixes global state from being modified while unlocked.

Reviewed-by: Jimmy Kizito <Jimmy.Kizito@amd.com>
Acked-by: Jasdeep Dhillon <jdhillon@amd.com>
Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_resource.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index e82aa0559bdf..9df66501a453 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -1965,10 +1965,6 @@ enum dc_status dc_remove_stream_from_ctx(
 				dc->res_pool,
 			del_pipe->stream_res.stream_enc,
 			false);
-	/* Release link encoder from stream in new dc_state. */
-	if (dc->res_pool->funcs->link_enc_unassign)
-		dc->res_pool->funcs->link_enc_unassign(new_ctx, del_pipe->stream);
-
 	if (is_dp_128b_132b_signal(del_pipe)) {
 		update_hpo_dp_stream_engine_usage(
 			&new_ctx->res_ctx, dc->res_pool,
-- 
2.25.1

