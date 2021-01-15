Return-Path: <SRS0=jp5v=GS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D13BC433E0
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Jan 2021 17:30:42 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E224320643
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Jan 2021 17:30:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E224320643
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9E77189450;
	Fri, 15 Jan 2021 17:30:41 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2070.outbound.protection.outlook.com [40.107.244.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 80FC189450
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Jan 2021 17:30:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dSUN6/NoSDo5z1yHPcrZ2gKOyzcWoh1ZNbSpGG668hoCuKtk4nasIBTCJBX0vK2oErWBuVIG1ZD3BPLQ9lcuubfWP3rAbUieI8c6I32pPLEwEssM3Y5fA8kKKBbgpG8jejva4GzgrB+bZDtvCSqLfKoGhBJUNiOzQa5lSplj13JvJ6hTd9JcaVEt1iEvn/RJLMb5ayIauHyST8XGQPbv3LujPoUQg8dG7hfokgFOqClA8W6YhBzAJaILbY9/rKYuRCFeEX0KPrvg2/XecmI9kGYRFdb0h8xaDOyvW4HBLeUSL+VIrr79zIP+XwFlUCX6ySeQ6PKgb36aJcmYR0phyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=951C0qkzBgCFBYI3WlDXiSxij7YI2vVEV5T6qGUkyX8=;
 b=iFAIXW4s3Pk2/P0dLZOtl+xku4ak9+5yfcukiGKlSRbx+MKq4euDwmq5fbWQil3mrgIt42+YGS6CVtp1mC4rcmjrzOcnoNTstIwk/vYU73ybF/s0yCV73Xr2guvTZsYzDw7PhKWVXrFG35Qdd6bLfmbcYt2uBRvVVmT/UdAmHdgOhqiGz8j9FqBbpjQAw8meT1Fs4ofqphI3cPWEVkIadu1SgNu+qy3JMrnlUkVViWpFx5xGpGtrZRW8GPpLYhbwr9i5hEYCJ1b7KGHdVMJRkeBEXTmyCuOt+lOVpJYIjGOaT2LGtuq4TFH5YanS3cpwisvPV8i4BQAjcg3cqNsTIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=951C0qkzBgCFBYI3WlDXiSxij7YI2vVEV5T6qGUkyX8=;
 b=pnMq8wD+uK3obrNT8P7jCh5xtVkKmAe5USeZ55NRaZ9LRJ+mSBADWXjk/gRB+oYHHQhmRU2Ce5Fg8kksrn2Qz2UXdEpP8qUQaEwq0QLEDisCBc2Dmi+PGPHeGMQOBOW61juwBlsfog2lbqJee2dvR51lG8uix5wrNYucgP8X3Bs=
Received: from BN8PR04CA0062.namprd04.prod.outlook.com (2603:10b6:408:d4::36)
 by MN2PR12MB3360.namprd12.prod.outlook.com (2603:10b6:208:c7::30)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.10; Fri, 15 Jan
 2021 17:30:36 +0000
Received: from BN8NAM11FT007.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:d4:cafe::13) by BN8PR04CA0062.outlook.office365.com
 (2603:10b6:408:d4::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.9 via Frontend
 Transport; Fri, 15 Jan 2021 17:30:36 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none
 (message not signed) header.d=none;lists.freedesktop.org; dmarc=fail
 action=none header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 165.204.84.17 as permitted sender)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 BN8NAM11FT007.mail.protection.outlook.com (10.13.177.109) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3763.12 via Frontend Transport; Fri, 15 Jan 2021 17:30:35 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 15 Jan
 2021 11:30:34 -0600
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 15 Jan
 2021 11:30:34 -0600
Received: from ajacob-ThinkPad-X250.amd.com (10.180.168.240) by
 SATLEXMB02.amd.com (10.181.40.143) with Microsoft SMTP Server id 15.1.1979.3
 via Frontend Transport; Fri, 15 Jan 2021 11:30:28 -0600
From: Anson Jacob <Anson.Jacob@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 03/16] drm/amd/display: DCN2X Find Secondary Pipe properly in
 MPO + ODM Case
Date: Fri, 15 Jan 2021 12:27:05 -0500
Message-ID: <20210115172714.126866-4-Anson.Jacob@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210115172714.126866-1-Anson.Jacob@amd.com>
References: <20210115172714.126866-1-Anson.Jacob@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 69fb6abc-3c8b-4dc0-c1e6-08d8b97b444d
X-MS-TrafficTypeDiagnostic: MN2PR12MB3360:
X-Microsoft-Antispam-PRVS: <MN2PR12MB3360F56ABE20DABE8509619DEBA70@MN2PR12MB3360.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FqWdoO7DxAMGwoZRRvnezj5dU9PbfNFROOIrBc54Az70VmlQuZRsX+7HK9FVoSQceEqcY+a9WkMqTYubGNpZnOYSTCu4f+T2ZPwrviRcASoKdOtcdiQFN3aMMaX7pbrtzjF+fwR4Lh6xGngwOe8EjVyyXyA2kTNTT3DW4RDV958GR0M2ULaUqLcF4rvOv5044QIbVU2duxOiTunzaVgZ/SGeDAC8kYybB65HGUuvWrvcOeD7hQPgZNzwW8RvRcFS34fWveyaJ3DqmRdJSSPzl0JrSbKYSx/o8J1xgSsBMvIJj8seeOWUjdWWkfpImft+Yw6slJl4nI1MoaWUou2/riV076XpfT9fHIf4OD7fDEHNnpM0kTLZUIcmnnSXDAuI/Cyh9BtTYsZnq4F9AWAn+Zt2sUmsPhO6yksUyw4gjL3MU1d/dAgd8egtA3F7e3C8fhXenzwF6385pT1Jh1mdwWFOwCl+Si/A+xjHvUVC/5rSy5gIAykpbLQLiKNwxmHQtZ74WkfZGObW/1wDx81KIv+gSsWAIz1ALpMOEnbtdb5TlkBAaOjqPcC8edgtTG0NYmN8rijLcnqwYkWSCqXiOwB5FoMG1g+VWDnd6bTZdamEs9BNsWyc3NqDwIOxGCMI
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(4636009)(136003)(376002)(346002)(39860400002)(396003)(46966006)(7696005)(82310400003)(34020700004)(336012)(2616005)(47076005)(4326008)(70206006)(8936002)(70586007)(478600001)(26005)(36756003)(426003)(6666004)(316002)(5660300002)(83380400001)(2906002)(356005)(1076003)(82740400003)(8676002)(81166007)(86362001)(6916009)(54906003)(186003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2021 17:30:35.0548 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 69fb6abc-3c8b-4dc0-c1e6-08d8b97b444d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT007.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3360
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
Cc: Sung Lee <sung.lee@amd.com>,
 Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>, Eryk.Brol@amd.com,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, Anson Jacob <anson.jacob@amd.com>,
 Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Sung Lee <sung.lee@amd.com>

[WHY]
Previously as MPO + ODM Combine was not supported, finding secondary pipes
for each case was mutually exclusive. Now that both are supported at the same
time, both cases should be taken into account when finding a secondary pipe.

[HOW]
If a secondary pipe cannot be found based on previous bottom pipe,
search for a second pipe using next_odm_pipe instead.

Signed-off-by: Sung Lee <sung.lee@amd.com>
Reviewed-by: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>
Acked-by: Anson Jacob <anson.jacob@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
index e04ecf0fc0db..5ed18cac57e8 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
@@ -2517,8 +2517,7 @@ struct pipe_ctx *dcn20_find_secondary_pipe(struct dc *dc,
 		 * if this primary pipe has a bottom pipe in prev. state
 		 * and if the bottom pipe is still available (which it should be),
 		 * pick that pipe as secondary
-		 * Same logic applies for ODM pipes. Since mpo is not allowed with odm
-		 * check in else case.
+		 * Same logic applies for ODM pipes
 		 */
 		if (dc->current_state->res_ctx.pipe_ctx[primary_pipe->pipe_idx].bottom_pipe) {
 			preferred_pipe_idx = dc->current_state->res_ctx.pipe_ctx[primary_pipe->pipe_idx].bottom_pipe->pipe_idx;
@@ -2526,7 +2525,9 @@ struct pipe_ctx *dcn20_find_secondary_pipe(struct dc *dc,
 				secondary_pipe = &res_ctx->pipe_ctx[preferred_pipe_idx];
 				secondary_pipe->pipe_idx = preferred_pipe_idx;
 			}
-		} else if (dc->current_state->res_ctx.pipe_ctx[primary_pipe->pipe_idx].next_odm_pipe) {
+		}
+		if (secondary_pipe == NULL &&
+				dc->current_state->res_ctx.pipe_ctx[primary_pipe->pipe_idx].next_odm_pipe) {
 			preferred_pipe_idx = dc->current_state->res_ctx.pipe_ctx[primary_pipe->pipe_idx].next_odm_pipe->pipe_idx;
 			if (res_ctx->pipe_ctx[preferred_pipe_idx].stream == NULL) {
 				secondary_pipe = &res_ctx->pipe_ctx[preferred_pipe_idx];
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
