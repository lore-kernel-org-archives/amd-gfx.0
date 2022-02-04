Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60DE7C433EF
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Feb 2022 18:44:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3B25810E63D;
	Fri,  4 Feb 2022 18:44:17 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2053.outbound.protection.outlook.com [40.107.236.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7F6D110E638
 for <amd-gfx@lists.freedesktop.org>; Fri,  4 Feb 2022 18:44:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q72SaRA5+1mlIJZAooMw6BL/gb/l9fNxXUhauaSQUTS/YrudCIbxlJyCoFcuyx7YcE/nLKLl7QEcXalA7doZAY2k7/7CEv0xgnW/mPYwJm5Ni87EM/XQxUQiL1NVWzxKhd1DeH63fGAQ0XzDSggBHv8mYvKXITXKIjChuP+bmD+eGfjx1Sq6UH5FFrRWLIpvgfzOsxSqnmEoj08WHWqBs89yFpI5oE0bhPPSqlw/+aKBkJM1BbGPESM9b83BPszxKkdwINJ1DYw+GFDlLoz7QL5Ynezj/+hulOTdQx3w39HpBMu/JVE9GF9pLc61x4TKljBtuBkdmFpEmnBtcB2PfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+Fo6q/M9rvEgna8FPIKJVrGr5721DQ8dEzihaiJrFEI=;
 b=l8UDS4QTLvGzenfgCtVowUO9c8WX4G4WXdkoDLZFvVAVAUEMHzTjDbwUQCjAkzPZgJ4hyImoMnI+F7qA05Dode/Dq9Ihik16QXpHCi3e3F7DdWkfiDA6f0tq54IPhHXVZZhr6rIzqZqALxqNL7mMb0MS8gHkVEVnNLtNtTe3mRk4acA2oXlxJlNSeLaN38mBG+RsTHrMkvXJsfvGP8lIEK5ZUZ4RhMRYGxSfajwWzlSrjk0p2OmsBbLyuujZmLXy/Im7xWL3oHsLb8UA2TGThjf24+cN170Tb7arKmHH8ep2haIjccSFLYhz9ED6l01KX1aawmV3VYa4j8FLxHPKfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+Fo6q/M9rvEgna8FPIKJVrGr5721DQ8dEzihaiJrFEI=;
 b=2YtfyKojmbLS1rNghowVeWCGIF9yUPzQQ9vKhjCAYBSaFN+BwSKda1YrcUtljfZZX0RsNf4/UIcS6aOIXzHPE4/PmN7ja6OgG/RE86R/hXVME0U6gti9h98yZeCh4irlm8Bzr0H9PZdbpvbL7aR1volqHzI1exAIJi4Pw6e62u0=
Received: from MWHPR07CA0009.namprd07.prod.outlook.com (2603:10b6:300:116::19)
 by CH0PR12MB5299.namprd12.prod.outlook.com (2603:10b6:610:d6::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Fri, 4 Feb
 2022 18:44:13 +0000
Received: from CO1NAM11FT048.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:116:cafe::ce) by MWHPR07CA0009.outlook.office365.com
 (2603:10b6:300:116::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12 via Frontend
 Transport; Fri, 4 Feb 2022 18:44:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT048.mail.protection.outlook.com (10.13.175.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4951.12 via Frontend Transport; Fri, 4 Feb 2022 18:44:12 +0000
Received: from jasdeep-System-Product-Name.hitronhub.home (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.18; Fri, 4 Feb 2022 12:44:10 -0600
From: Jasdeep Dhillon <jdhillon@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 02/13] drm/amd/display: Fix stream->link_enc unassigned during
 stream removal
Date: Fri, 4 Feb 2022 13:43:44 -0500
Message-ID: <20220204184355.91198-3-jdhillon@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220204184355.91198-1-jdhillon@amd.com>
References: <20220204184355.91198-1-jdhillon@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4f482e65-4f18-408a-db25-08d9e80e56a3
X-MS-TrafficTypeDiagnostic: CH0PR12MB5299:EE_
X-Microsoft-Antispam-PRVS: <CH0PR12MB5299875EC023A9E08B9C137AFB299@CH0PR12MB5299.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3Er2J9xowLh6hRiT9fDYcxjetAB4rb4xC+695/YXAqGJnbHc5c38ysqmccuwd3HmN2sa1iZF3hcWMcEo/lGxkj7g2aVzME2p3hKE9+utzxOfAhL/bFg4Ps/u072pltLwWRbxDDMKww/SpFKwcA+SDDqtrFczgkrZ2VyvQJauTvW1O3VBeXdBCyLTuiO/QdNZWHZzhhi4U7No7Q+Efymeha0QMwNdeJR6L3lh7hyA0QcRuiezEAUyQimoLQuBCWvYykdaOgZmME7pbY7gv1HQvM77ZTaBerBlBv/ycHe374Hv45B4wkyy/yGe9ZyZveodEdWA1//Ka5Cc0oA7A5rooCehheEdLZqRu6JoXwBrH3qQauhFlS8RXRiaQcQ6oUNWpZIypHYE/bmjizuVh3wpq75ouwHYK7iN3x/HECzDfKSHvnB5dzemD83D7XEER7HZEFqShbSJZ0Ax3WAApuBl8ySwXe1gd5NbyOSSFq2m/eEPel/H//xdDU7VD8a5/rZ3ldCG3vmj/+MpsVOhFxaWVhr88g6usSGK8ENl+iExAd/XTnA5UpWirmmIQczlsCwBzhY/iqsYC1tOgiCjoEogQJXeL4wDq+HJDYbTqs75NCe8xTmnghcWoQUvv2sXoPcgijtQQYPhgntx+CWGa4Pqk+ba6mHx39FleZcBqaZdEPZMkZQEZrFNPY5IPU6Lu1g3MEFJKjidnC/9aRFBWzBW+Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(36756003)(8936002)(1076003)(186003)(82310400004)(36860700001)(47076005)(16526019)(40460700003)(508600001)(26005)(2616005)(54906003)(8676002)(70586007)(70206006)(316002)(81166007)(356005)(6666004)(6916009)(2906002)(83380400001)(5660300002)(336012)(4326008)(426003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2022 18:44:12.8526 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f482e65-4f18-408a-db25-08d9e80e56a3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT048.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5299
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

