Return-Path: <SRS0=nuNM=HA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C70BC433E6
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Jan 2021 21:28:33 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E416A64E00
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Jan 2021 21:28:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E416A64E00
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7B9CF6EC2E;
	Fri, 29 Jan 2021 21:28:32 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2047.outbound.protection.outlook.com [40.107.92.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 80C986EC2A
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Jan 2021 21:28:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D6pYDgq/HothV7EUtGIYrosK0hzK3nYVQk3NJS83/RRdZwnAH15zQdUEFe+kx4edRY8fcj1qaBYGZDEFUrxuJb6xed1zJeThNAtfRALgVLyYloux/H3kfrsb/m8lkeF/efytsb+r/4UjABSAHaIObQ/ISmlPYSSCRzOIdWI8wCW5/6qUXOrPwTxSvqUFQwbwGJJvmOwAP1eOkOIQ8g64YujfllnS3ovXszoxRgiQVrZztDnJSKY06d3iQr+hh2uO5LjgbCMPpyOlEP6z7SHF//btIwQ9y3JoSJ2Vq7psz9B23U6pgBY6mHE+Zthkc9m2qwm9TwQg4cD7y9vMZlm3Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SUjqPfKubyyOujtb2odQWNdv8yFWwJjcNz5iZiIlHMQ=;
 b=l4LG2R+sXIWR5dsNB1R1PGE9M7NbvtiO9P/flBJCaQTlq955ONqtAMTO87L4HEkzMqwJZBqYU1NzNGTygBFhoEj3lO5TN+UluFblVt/YKhOdKgCuCK91kS5hSRIy4jCRPPk6t3EP5F+MpUlggo9AUsJLNzhwUjh5smomBp26D+SRtlbwSWiK56HG4a3YV2aRKKw24UxwnDXAHuv47CoZDB1NlBrHC2AIIuCxQHUsd8eMrQlM90Cx87bwMgCDlp03OHx0pmj6cw4SwPqrnzSLkxkt8esK3UgWU50E9eB7tpSheYdSsOfI9tKQPEdfOrm788v4lHjAIoY93WHANzlfHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SUjqPfKubyyOujtb2odQWNdv8yFWwJjcNz5iZiIlHMQ=;
 b=sTSF+iGQbJmToQxN9lZPUckKO/bLM/MJrPnZ2XVLTzL1Ocglp+vATykbhsznWHn+ouhGjCcpV7pzbzJk05Zi1+p2ZE5vDroFK56TQmrBv3Yu+DBpunMdd6dGJu7bj9fr8pWwewLPO10R8Rk2Yq2FWaMqtLfGSCzaaBBOoGtIIEI=
Received: from MW4PR03CA0243.namprd03.prod.outlook.com (2603:10b6:303:b4::8)
 by BN7PR12MB2706.namprd12.prod.outlook.com (2603:10b6:408:2a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.14; Fri, 29 Jan
 2021 21:28:26 +0000
Received: from CO1NAM11FT005.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b4:cafe::b6) by MW4PR03CA0243.outlook.office365.com
 (2603:10b6:303:b4::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.16 via Frontend
 Transport; Fri, 29 Jan 2021 21:28:26 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none
 (message not signed) header.d=none;lists.freedesktop.org; dmarc=fail
 action=none header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 165.204.84.17 as permitted sender)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 CO1NAM11FT005.mail.protection.outlook.com (10.13.174.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3784.12 via Frontend Transport; Fri, 29 Jan 2021 21:28:25 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 29 Jan
 2021 15:28:24 -0600
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 29 Jan
 2021 15:28:24 -0600
Received: from Bumblebee.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Fri, 29 Jan 2021 15:28:23 -0600
From: Anson Jacob <Anson.Jacob@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 21/27] drm/amd/display: Free atomic state after
 drm_atomic_commit
Date: Fri, 29 Jan 2021 16:27:46 -0500
Message-ID: <20210129212752.38865-22-Anson.Jacob@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210129212752.38865-1-Anson.Jacob@amd.com>
References: <20210129212752.38865-1-Anson.Jacob@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 409207a6-888d-4644-e975-08d8c49ccfd7
X-MS-TrafficTypeDiagnostic: BN7PR12MB2706:
X-Microsoft-Antispam-PRVS: <BN7PR12MB270647DFE290D029E8A7B293EBB99@BN7PR12MB2706.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:321;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PogCD6bHTdVmDZ3+e1Gfh7LX/asrqIEavFWsJa7SN9NPpBJeIbljAWKyt8J+8bo6IwV7y5y1RQKkqFMF7gVNODZZKfgOPsMw12xJyRU3Hi1Dtsqa/X1sB/7dwA+020/vGd6brmyBYcIYzlKDJJN/dbm0IPS+xWvKgoHF3sdk77KHxKBPdJmKljSfMcPPqzR6r/Of7j95bXo9LRhcQucx1ZCFagP83XYdq0gek/rU5RkdsToNPxLGaB6xkxRfKR26QOv5AfQbjtVFqt3i8P7JonWldID0Tkxc6nf9xDxLZ7VSeJiFxnq2YxR3S9SCV2eGZEbqDuzEIPgk1Lz99LrhsxyyxP7f/YY8Q0oXyt1B32yPEAA8fqE2LYrw2j2srAR4v8oz/HNfIE4sjf5Ne7l8jMdSeKaMDMTaVntRtCYTJvcNHfDI82uHApug78iINprjIeCTTIEiiTqANDTr/QfuWUnneDYLWf9VLzzT3edcHusFZ8zQvg4yUnDpFIsPqlfKjZQJwtSou9OE2HWhuXuYXpEyxh51IjPhEFK9akU0rKfa9V5RmccgjQuTwdsJpX7662fWOoeKoacKy85Riq/3PJ15mP92AmgjEdYxQqt94Ys=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(4636009)(46966006)(8936002)(8676002)(2906002)(70206006)(5660300002)(86362001)(6666004)(36756003)(47076005)(7696005)(70586007)(1076003)(81166007)(426003)(26005)(82310400003)(498600001)(4326008)(54906003)(83380400001)(336012)(2616005)(356005)(6916009)(186003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2021 21:28:25.2282 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 409207a6-888d-4644-e975-08d8c49ccfd7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT005.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2706
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
Cc: Eryk.Brol@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com, Roman Li <Roman.Li@amd.com>,
 Victor Lu <victorchengchi.lu@amd.com>, Anson.Jacob@amd.com,
 Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Victor Lu <victorchengchi.lu@amd.com>

[why]
drm_atomic_commit was changed so that the caller must free their
drm_atomic_state reference on successes.

[how]
Add drm_atomic_commit_put after drm_atomic_commit call in
dm_force_atomic_commit.

Signed-off-by: Victor Lu <victorchengchi.lu@amd.com>
Reviewed-by: Roman Li <Roman.Li@amd.com>
Acked-by: Anson Jacob <Anson.Jacob@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index f9d48ce1420a..3a44a86f870a 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -8535,14 +8535,14 @@ static int dm_force_atomic_commit(struct drm_connector *connector)
 
 	ret = PTR_ERR_OR_ZERO(conn_state);
 	if (ret)
-		goto err;
+		goto out;
 
 	/* Attach crtc to drm_atomic_state*/
 	crtc_state = drm_atomic_get_crtc_state(state, &disconnected_acrtc->base);
 
 	ret = PTR_ERR_OR_ZERO(crtc_state);
 	if (ret)
-		goto err;
+		goto out;
 
 	/* force a restore */
 	crtc_state->mode_changed = true;
@@ -8552,17 +8552,15 @@ static int dm_force_atomic_commit(struct drm_connector *connector)
 
 	ret = PTR_ERR_OR_ZERO(plane_state);
 	if (ret)
-		goto err;
-
+		goto out;
 
 	/* Call commit internally with the state we just constructed */
 	ret = drm_atomic_commit(state);
-	if (!ret)
-		return 0;
 
-err:
-	DRM_ERROR("Restoring old state failed with %i\n", ret);
+out:
 	drm_atomic_state_put(state);
+	if (ret)
+		DRM_ERROR("Restoring old state failed with %i\n", ret);
 
 	return ret;
 }
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
