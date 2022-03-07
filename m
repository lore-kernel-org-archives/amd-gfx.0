Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 368AFC433F5
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Mar 2022 05:50:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A7BE610E570;
	Mon,  7 Mar 2022 05:50:00 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2082.outbound.protection.outlook.com [40.107.243.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 89D5710EA68
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Mar 2022 05:49:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MfzQqM0gQAjtla9Kd1YqSe7xMw7DobIjDgy7sgUpXLMn2U3koILru2fdS7tT+qaiktXrdSqbw9cnkyB3I3QD8CuBWNPsXPHu8w6qugyQMSpj1Gm0nDZndQy7OCFrwaqFpiuSWImTPDVltbCF7Sgjg6D7ntwNgxV4hxWgFDVwlAg7blwEQEv7qpQrsVXH2UGeIHG5jb4N22tBUpDT5rBEVkf0jaJDmOBlEzgt6F/WoRoKltX1AJCcQvtTnRj2ICjy7drStjLKCrj5rekWiC/3+8yEx+zV7Q1zcoLxSa5JxPBbhv9zI/Gthdco+5cUUd79Sozj8iyT+5JKzHLFw6uM0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5MGvWPaipztdnm3CKyx4LNCGFjmOJqP7RlqWMGLaP/Y=;
 b=BC+pyC9X3c21L0jfiHLGlvZm0ho+KOHPruPnkxlPsfaypnGo9A/s3iCy2d1eM17scT4nbEcbyosT0oGJf8sJmGLlnYf3M6/2zVhNC+Kd/ZE6OdWe2qe0O/8LA/UuM5Xp1HfgtswUyqm2aHbHMUe/2bxgLPLvswalKP3Fr9SW9Yz9xTJ7Ke5ixbMa7BOWsWUUc8r9SLNDYFKAC1uTUuGlSDUxv7M0DmDlQuVC3ujiSSqFZCmeCILFBTidE+MD8h1mtBnVV6SVh/pw/J3lQd/BQF0GZUlDN3u52q0sEA1dizvqOT9zBIaW3oxHn/TF++hE0OhVaVVWFvvWg+ab+Lr+6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5MGvWPaipztdnm3CKyx4LNCGFjmOJqP7RlqWMGLaP/Y=;
 b=XQcolTD6v/lIIhbtdkNab1ahocq6dDMkzSSboe1VmaPFUNpB/4TdSNTA298sDcfcpcVCi4KsZjtkQ+iK/rn+9xpi8w+ZD8XMRvDTXEkQ3eRE9G52qqUeh4EYU04s4HrYhRvMhrqDReHhuJry34ublZBdWxCvw2SN+cbewAJ1kJc=
Received: from BN9P223CA0018.NAMP223.PROD.OUTLOOK.COM (2603:10b6:408:10b::23)
 by LV2PR12MB5775.namprd12.prod.outlook.com (2603:10b6:408:179::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Mon, 7 Mar
 2022 05:49:57 +0000
Received: from BN8NAM11FT021.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10b:cafe::8f) by BN9P223CA0018.outlook.office365.com
 (2603:10b6:408:10b::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14 via Frontend
 Transport; Mon, 7 Mar 2022 05:49:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT021.mail.protection.outlook.com (10.13.177.114) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5038.14 via Frontend Transport; Mon, 7 Mar 2022 05:49:56 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Sun, 6 Mar
 2022 23:49:55 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Sun, 6 Mar
 2022 21:49:54 -0800
Received: from alan-new-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.18 via Frontend
 Transport; Sun, 6 Mar 2022 23:49:50 -0600
From: Alan Liu <HaoPing.Liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 05/21] drm/amd/display: Add minimal pipe split transition state
Date: Tue, 8 Mar 2022 05:09:28 +0800
Message-ID: <20220307210942.444808-6-HaoPing.Liu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220307210942.444808-4-HaoPing.Liu@amd.com>
References: <20220307210942.444808-4-HaoPing.Liu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b217fdb1-0eff-4ef7-ca77-08d9fffe4f6c
X-MS-TrafficTypeDiagnostic: LV2PR12MB5775:EE_
X-Microsoft-Antispam-PRVS: <LV2PR12MB5775276E5C92774C139A1AF8F5089@LV2PR12MB5775.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: x09/BWys5z/BPNB+qBK1is+/rbpWF/M3y6Z2iWbRlz4hB9SdByqep/vSucoSZ4dHMKXuaKO6T1W7ylhk6g+diJoSEcUjrG8GcIcpaqgVm6aZSPOtj5S9jqJCej60hzTE5p3rVnHMUNIhB4Iyjaz1thBXAjdK0KL26qYqb3tD5bXaAzX0mSjjn84Ju96a4wHmwiJ6u2m2v1jKplMdMOJxoJdPCSm9VbsVjNR1AoB31HqwYht9W404Fb+O54bHmB44Q7QipMiJTKCh1HUw808eN08+i0ZvbGiR7OdkYnRrSJvnezDRJsuWW4f+BQOnjTQeKXlu5/uIdDmbkisAI2buCI8x2YCKwcW5oq0kgSsYW6F3kEO0yMg1FiYOF3QIq0mbHp87J/MJ4mA/FO5y8dUImGwwqC9V++iAeTFD2sQUhIN51vyqaypUBNg2KS5u2nPsRebU8sy65b1ss8bLRQ3+Px7lmkkWmA+JKeonUD2/H0jlO1Yo9C1+9jzI7qGbwlERxkFJbZ6mj1ZJmiPTsp4DETlDMjlqzfS6Il6uazPKKyHunSPZ2j+QXc9tOv6LRZBWKgZSIncEytgI8NT1vsYt3hB4L8Ry+PrCVIfsXadqmskcSuubIn1+mWlw5i41sW0N5FzED93hyhVHN6NzH9YjJkZLfIbi6u22IhB/o3VrItdBJihf2VbZs/VltLBvvZDu9FzjmGejh7yp+UGq58EWM6IU6VKwEDWxR0IFjFRBj/qq6SBRTuIxfcK/EqCcBF1a
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(82310400004)(47076005)(316002)(8676002)(70206006)(70586007)(4326008)(356005)(7696005)(336012)(5660300002)(40460700003)(1076003)(2616005)(2906002)(426003)(26005)(186003)(83380400001)(8936002)(6666004)(36860700001)(86362001)(508600001)(36756003)(81166007)(54906003)(6916009)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2022 05:49:56.8160 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b217fdb1-0eff-4ef7-ca77-08d9fffe4f6c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT021.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5775
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
Cc: stylon.wang@amd.com, Alan Liu <HaoPing.Liu@amd.com>,
 Aric Cyr <Aric.Cyr@amd.com>, Dillon Varone <dillon.varone@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Dillon Varone <dillon.varone@amd.com>

[WHY?] When adding/removng a plane to some configurations,
unsupported pipe programming can occur when moving to a new plane.

[HOW?]
Add a safe transistion state before programming new configuration.

Reviewed-by: Aric Cyr <Aric.Cyr@amd.com>
Acked-by: Alan Liu <HaoPing.Liu@amd.com>
Signed-off-by: Dillon Varone <dillon.varone@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 61e3bb99375f..01b5996fa3aa 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -1082,7 +1082,8 @@ static void disable_dangling_plane(struct dc *dc, struct dc_state *context)
 				break;
 			}
 		}
-		if (!should_disable && pipe_split_change)
+		if (!should_disable && pipe_split_change &&
+				dc->current_state->stream_count != context->stream_count)
 			should_disable = true;
 
 		if (should_disable && old_stream) {
@@ -1690,6 +1691,7 @@ static enum dc_status dc_commit_state_no_check(struct dc *dc, struct dc_state *c
 	struct pipe_ctx *pipe;
 	int i, k, l;
 	struct dc_stream_state *dc_streams[MAX_STREAMS] = {0};
+	struct dc_state *old_state;
 
 #if defined(CONFIG_DRM_AMD_DC_DCN)
 	dc_z10_restore(dc);
@@ -1808,10 +1810,11 @@ static enum dc_status dc_commit_state_no_check(struct dc *dc, struct dc_state *c
 	for (i = 0; i < context->stream_count; i++)
 		context->streams[i]->mode_changed = false;
 
-	dc_release_state(dc->current_state);
-
+	old_state = dc->current_state;
 	dc->current_state = context;
 
+	dc_release_state(old_state);
+
 	dc_retain_state(dc->current_state);
 
 	return result;
-- 
2.25.1

