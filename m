Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94BE3C10DC1
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Dec 2023 19:52:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 90C2F10E5F2;
	Wed,  6 Dec 2023 19:52:48 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2061c.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe59::61c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0528C10E5F2
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 Dec 2023 19:52:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hkDjs9ejYfRGE/EAE+WAfngJy+OxrHzAqCruDHNke/qlZPorBtupgGAEvlxXoVgr3uYuEQljFhgNNKfc0GuSlACP7gZhc9rtoQAa7cpMypW3kTi6txt/d6Sht4dzU81Vir5Otz4QErXgRGUSe9YB8ot5OKq6lkBVmcIZ7ndQ7LORIvCWydAnTidzLiSwPzQzxO0+u5ze0Ju68wTg93CmAnyJPV5fbgZSTYWFDjoNyBAVkKv6uEn1zhmgL/4SNrSVU6bSUUzP+J/z7ZuFMkRpVbBgo7sJOnzD2bpNB72jrKz6d/gbGIVi8DD/eu2pla+pq2x22xA9Mt4VkxSEkr6AAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/w6IGVP8gd4YmrM6SvTpwss3O06mcaA/0th7s5f8tZM=;
 b=lWNI93ewdCMpSgwpJmKV68bAjmqNm1SJmLh2+haZeYv1YNcmqgNqUT4k5QhCknE1RMtNOfZxrpW1rDSWRbWH/gLARczZLOe3I2T44CFUk+TQtQQ9sBkrCgnJdwnzJJqlqSagbIsGHzQCJkqXGL7zeZScLMwPAdAvpJKV4CMMY91DiqbLe/z8QEOS8+n1kDkq8jqcyEXNb5LOdVoPzNnpTEn1wteHM4SYgh0bwBP4oBGtWZDIUu5NuLOq7GuaJsatRDGyQ56zA6siuqxq4vAj8upwJ6pcnadCInf72YX0InR92FDE2WZ26ht5ZWUvDcDrzA6wUC01l1QvicmzhrmZVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/w6IGVP8gd4YmrM6SvTpwss3O06mcaA/0th7s5f8tZM=;
 b=M7JjeH5Zeb/GQqPyYRFAN8piwVv+ZVBQeZYk8i3edq+xgM1HvA4dgBTatdPl8PSmZoco/uFmrFSyPc6t4gJRJocuFlm4QzDQ+MsyCLmfEyMBPX0ChzR3ZI0DEPRstXDeOhunXEak8NnIEwzsvvPf17tI6qhrHNfvvTLfyDHwpSw=
Received: from CH0P223CA0015.NAMP223.PROD.OUTLOOK.COM (2603:10b6:610:116::33)
 by BL1PR12MB5732.namprd12.prod.outlook.com (2603:10b6:208:387::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.25; Wed, 6 Dec
 2023 19:52:41 +0000
Received: from DS3PEPF000099E0.namprd04.prod.outlook.com
 (2603:10b6:610:116:cafe::af) by CH0P223CA0015.outlook.office365.com
 (2603:10b6:610:116::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34 via Frontend
 Transport; Wed, 6 Dec 2023 19:52:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099E0.mail.protection.outlook.com (10.167.17.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7068.20 via Frontend Transport; Wed, 6 Dec 2023 19:52:41 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 6 Dec
 2023 13:52:40 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Wed, 6 Dec
 2023 11:52:40 -0800
Received: from debaura-ryzen.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.34 via Frontend
 Transport; Wed, 6 Dec 2023 13:52:39 -0600
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 06/13] drm/amd/display: Revert DP2 MST hub triple display fix
Date: Wed, 6 Dec 2023 14:52:27 -0500
Message-ID: <20231206195234.182989-7-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231206195234.182989-1-aurabindo.pillai@amd.com>
References: <20231206195234.182989-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099E0:EE_|BL1PR12MB5732:EE_
X-MS-Office365-Filtering-Correlation-Id: cd95915e-4f92-47fb-40cc-08dbf694e843
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: idvb6We3qSh/5ImIspuz8B5Qq8S0s3lN0yG9Cgqwv2dEg8ZIj6uqvxvqxFqoGEA38C2EaBJx/ucBIfZV8SXw+9BSFr8vUH5AH+ReI2/YjSXIzwoiRP2560/LidII3wCTSd3y6vqzBO9nY52nU+6UnTqSHRQS/O00WqM7HARfOHUVtJek/BKNv2ay6AWEEqfhVklGoPFx8SKNK4kC7KiUpSOCv0h84vptQsvVjqBeZHhXDWfXzWvn6LcnRRartg9Y48eOFsiJOef7R+SscQPbvzHm/mLlXoG6kvFJEfcfiOfllbCbBXo09kXRkCZrc3ACXpoaBo6VslXVegvIpyX2pyWD+wh6R302s/VJ08LBrxQ2oaBM7uhu7WKPw6TdPlT3dan5zD6CmqIgLUwzljqBLDiHzRbRuhpidK28Ajr0/sUHvd6kXOJi7K645lBwyyk45t74iDYu9coNSJ/3eGKPttWRqPxJQNZZEVCpE/NZPLUqFnxmMzW5tH4Iwdi4uRWHKxDzkXhBEKeZvU8a0lU+fTFhGoV9Iu0U1UFyev2sQjQLGTg2aiW1QRZ3fDGvnzUKBudQeA10HpJQbAfo/UAuaInbThRQFNQt8wUqdbLodl/9fSsJyg8Lzn/g5ernzCJmHSZzI8wdjrh+YBSMMie5Rs7LxLqeTtR3LkDtSoElgahYWwpuishuUSoQ3Mes2q42UF0mLY4XIoRNNaiCS/Q6QqsTI1BmqXkobXnF3UiO+Ty7Wh/9YXKro/wvAO4vOe0atLS6NScMoeJ2vgmp0e8XDw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(396003)(136003)(376002)(39860400002)(230922051799003)(451199024)(64100799003)(82310400011)(186009)(1800799012)(46966006)(40470700004)(36840700001)(83380400001)(7696005)(426003)(40460700003)(6666004)(1076003)(2616005)(26005)(336012)(316002)(70206006)(70586007)(54906003)(6916009)(40480700001)(5660300002)(2906002)(4326008)(86362001)(8676002)(8936002)(36756003)(44832011)(41300700001)(478600001)(81166007)(356005)(82740400003)(36860700001)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2023 19:52:41.4746 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cd95915e-4f92-47fb-40cc-08dbf694e843
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099E0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5732
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
Cc: stylon.wang@amd.com, Charlene Liu <charlene.liu@amd.com>,
 chiahsuan.chung@amd.com, Sunpeng.Li@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, jerry.zuo@amd.com, Aurabindo.Pillai@amd.com,
 hersenxs.wu@amd.com, wayne.lin@amd.com,
 Michael Strauss <michael.strauss@amd.com>, Harry.Wentland@amd.com,
 agustin.gutierrez@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Michael Strauss <michael.strauss@amd.com>

[WHY]
Introduces regression with DP2 native displays

[HOW]
Revert commit 311ba210d

Reviewed-by: Charlene Liu <charlene.liu@amd.com>
Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Michael Strauss <michael.strauss@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dml2/dml2_utils.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml2_utils.c b/drivers/gpu/drm/amd/display/dc/dml2/dml2_utils.c
index 38fa7441df51..814dbdcf9a78 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml2_utils.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml2_utils.c
@@ -160,13 +160,6 @@ bool is_dp2p0_output_encoder(const struct pipe_ctx *pipe_ctx)
 
 	if (pipe_ctx->stream == NULL)
 		return false;
-	/* Count MST hubs once by treating only 1st remote sink in topology as an encoder */
-	if (pipe_ctx->stream->link && pipe_ctx->stream->link->remote_sinks[0]) {
-			return (pipe_ctx->stream_res.hpo_dp_stream_enc &&
-				pipe_ctx->link_res.hpo_dp_link_enc &&
-				dc_is_dp_signal(pipe_ctx->stream->signal) &&
-				(pipe_ctx->stream->link->remote_sinks[0] == pipe_ctx->stream->sink));
-	}
 
 	return (pipe_ctx->stream_res.hpo_dp_stream_enc &&
 		pipe_ctx->link_res.hpo_dp_link_enc &&
-- 
2.39.2

