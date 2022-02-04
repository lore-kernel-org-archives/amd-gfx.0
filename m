Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B82E8C433F5
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Feb 2022 19:04:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3213010E4EF;
	Fri,  4 Feb 2022 19:04:25 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2046.outbound.protection.outlook.com [40.107.95.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B312610E4F3
 for <amd-gfx@lists.freedesktop.org>; Fri,  4 Feb 2022 19:04:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mgDizsI/5mJwDGCewAf2tpWIhtCnr/2qX0l2Opm4IaciB2CFMTUeFdZGbK6r2kGZVE+bB6SdI4rw7s58roOsGS2ysaJ0rM/vTW1BneHZ8NrBeYZSpqINx9Bdg/KxRVl67tybsrhSIAxcMBygbvxzmb3pBXOM+5nIZ4z9SQ+GgiURBG7e9t9a6tn0l7/dc0tnmsAa2MDURWxG6XrDaDfDEt866wrLyw6JjpHQhw5zQXxQGWcrx2t/R+HfwHcTO7g2TpxCL8+eTRfbrj6p5OgekauU8VX0QUAyjAyo1q+0RMs2yqHRnimzAk/ls5hmtZ2F4Qb62BTdLGyEy5yjzLj1UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+Fo6q/M9rvEgna8FPIKJVrGr5721DQ8dEzihaiJrFEI=;
 b=QaCOlrx9kY/EiMuvfn7/gBfMJxinj8cGrXqNW99D3ACPBUFqKz1q9x1T20YpEc7H3YM1DvYq+e7nuHyjGZvb/aztAAO6jV18qUaHZAOx+9mTiD+gfQ2P3vArPyauPvS12QolhdZnG/HJwWnBT1D+y7hGOyUY5Q6vht+31nvN6KqzH+5o8HV908uVZ97jn0aFnHKC9+EHI1bG8SLfHjJho4xkqO3GVjZjaoMHoWkzDRundDViE45kzcvx53sSMA4zZFtOi8REMXMeu1Pf7GHDQAbEWjHXqcm8NdtMOUyjtaDa+A61iWfCtMPu2ERC7MGgpxeueMFuoHgMaf5k3+zBiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+Fo6q/M9rvEgna8FPIKJVrGr5721DQ8dEzihaiJrFEI=;
 b=Xg5LgDJIOGTgBytLZ8TqcuVhf0YNeur9yFQEBi4eEn8j+HhnJx6tpfEYgT7lek9yBVyv8bnRZMtSWH8f+X+Xsx7cEqeZnXQLSXmoauqiSHRvFWkx8r2Bs4rxNl0ObfSSmQ9myRMEnTEeVOmq6/3Kr1Y4//FjDywvTd7pOEXk9Gg=
Received: from MWHPR11CA0047.namprd11.prod.outlook.com (2603:10b6:300:115::33)
 by MN2PR12MB4032.namprd12.prod.outlook.com (2603:10b6:208:16d::32)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Fri, 4 Feb
 2022 19:04:20 +0000
Received: from CO1NAM11FT049.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:115:cafe::b) by MWHPR11CA0047.outlook.office365.com
 (2603:10b6:300:115::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12 via Frontend
 Transport; Fri, 4 Feb 2022 19:04:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT049.mail.protection.outlook.com (10.13.175.50) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4951.12 via Frontend Transport; Fri, 4 Feb 2022 19:04:19 +0000
Received: from jasdeep-System-Product-Name.hitronhub.home (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.18; Fri, 4 Feb 2022 13:04:16 -0600
From: Jasdeep Dhillon <jdhillon@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 02/13] drm/amd/display: Fix stream->link_enc unassigned during
 stream removal
Date: Fri, 4 Feb 2022 14:03:46 -0500
Message-ID: <20220204190357.94538-3-jdhillon@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220204190357.94538-1-jdhillon@amd.com>
References: <20220204190357.94538-1-jdhillon@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dd1f9f14-adbe-4627-a676-08d9e81125e9
X-MS-TrafficTypeDiagnostic: MN2PR12MB4032:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB4032C23C976A52D1B2278F31FB299@MN2PR12MB4032.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: L8fm3aG1BLgnyEgCqUjn59NISxnuN9svfomtprClNk8u2+VbqK5ZBtFsdZ/tEQiQoHVxHjqhEuPHUzFaegUQEkns3YupyD7TArc9KAMZUCYkCf2t3QjhNl9MSuSkUVyGOgWJvxeWz7+g7DUQNlnwyK5iEr/2AtXH7KXBgqcodKnLl6oFpcyhsVMgJVKXdDd477chlPm+LqVR0TLFS3CD/0H58aUa9YJVyVrwcizGH3i4yq9AJuG9RtfhBCCEPHNp+tHxUjlYcWkiXi6ZtngIgjvK4Hu/JHKTZm20jd55W7LHAe1Avi20R6//EzUG0dg6pv082kD4KcWHy6umXNmjwnt8nJpDNub9MtULIGWKxm1cLBCuYPy6vJKigA1mPd0/JeBiWZJIEOrC1+sDpyuZVIbCrGryngYUTZ2V9B4bw/lcIfieeglMefa5tC3n/pJvB8CP9Pu8W3QO/Ctj8NsXqSgT4P9eDc4kRuCzZAxemlRgJYX/uKjtuVmp1MqcbrgWr+U37VEz3vI7dvpZBSwOfobKHskfNCOYcl6ZDutIgrZMTSmGLqi0ChfGWsEuR3FmPflClKnh6/dSjO/GRTOnhSRxSGjsZxlTZaoRO3qeAjlbjpqV7feGxDU0pz423Dltf3vobKR2YyYq0PMzyqnUt6UWwbVXn5wHEXRpwsiaeOh30//jEedLhxrih10wlR9mKsaHq+oMyxM98rrTD7WYRg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(1076003)(186003)(16526019)(36756003)(83380400001)(26005)(508600001)(6916009)(82310400004)(2616005)(40460700003)(47076005)(5660300002)(316002)(426003)(336012)(70206006)(54906003)(81166007)(8676002)(8936002)(4326008)(6666004)(70586007)(356005)(36860700001)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2022 19:04:19.6074 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dd1f9f14-adbe-4627-a676-08d9e81125e9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT049.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4032
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

