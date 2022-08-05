Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 856A4C25B07
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Aug 2022 18:01:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F119AB19A5;
	Fri,  5 Aug 2022 18:01:22 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2077.outbound.protection.outlook.com [40.107.237.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 36C63B9367
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Aug 2022 18:01:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i6Zgol00VZ9v0HStp3H7Dhd8vXoA49Tzovq5FkTYEh1ho7sM5XHFofQrem8j08sjP6uB/5vSwBGa3XOkYYJPsBeb11iygaZFseQBMhSs+RHcydmOOe1o/79wuBjkzW0tRXg/0WtZx8IXqZmFcml1dvc/G3gMCVt42NpeZr9WB3WQoKINN5bdKPXATc0+6x8bccfp/0e537oqJzHYw0QdiM77afGbUtpSstRH65oVTquUxjO0Ok4FYCWFu7kWA5aJDNlNu7QgciWbrYyIjcSTdnsQZ2KvqHOaYMVOHOfChutnUzt7fd54dmENX0nD/EqIJ/1K50V+GXOVgc2aqbw2ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EP8oStqf6MoUyU0UyrinTDjXd88kVQ42wK2Gtt5JnB8=;
 b=XJUaN1AE+stp9ID8KxHLFDKQcHDE1UfWEdF1/RpWivIHaHb9Sv8fYvEjro29CbZZ/ZEIJmaxSY3mt1xuOphDhXzgraPlUFh3Vzs8o3tMOEHAriJe7uphR5vqFW0R7J2KZzniD6V8o4fcjkTVVKi4zEVfZDlX2iGkARnu/Y6O88XxE7jfkfGgDRphFvzkWs1g9ksIeYGtOAIJj1lo6hMzI9ilSVwTCctp7RcNJVuOC0RrxQpEVyL2ZxzXWz9TlaD55YWDHaf564bJ52+EpgIsHyeHnDYD89CHrXmOAfmnEaQXUHqyQKvX8ilaDgIGm4fDERqBkWbFwlA2/IqqVfiJIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EP8oStqf6MoUyU0UyrinTDjXd88kVQ42wK2Gtt5JnB8=;
 b=J2jgOXWu0fFHx9Wig3GKtol2GSzzyXvGp1slRE/KIcA+EvCoTS/r4u2pAior84MwZxxKUj1yr4AqPCZSeN1PQDNzhaips0OhuiEKDSIznjNpJ9WfCK5uQpdZX5gd7wrjKS3Fh+lyYFYNf+hGDOsm1DDznwNxVZ4S2MVqz+e4tS8=
Received: from DM6PR07CA0074.namprd07.prod.outlook.com (2603:10b6:5:337::7) by
 MN2PR12MB4424.namprd12.prod.outlook.com (2603:10b6:208:26a::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5504.14; Fri, 5 Aug 2022 18:01:09 +0000
Received: from DM6NAM11FT062.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:337:cafe::11) by DM6PR07CA0074.outlook.office365.com
 (2603:10b6:5:337::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.15 via Frontend
 Transport; Fri, 5 Aug 2022 18:01:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT062.mail.protection.outlook.com (10.13.173.40) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5504.14 via Frontend Transport; Fri, 5 Aug 2022 18:01:09 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 5 Aug
 2022 13:00:56 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 5 Aug
 2022 11:00:56 -0700
Received: from tom-HP.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Fri, 5 Aug 2022 13:00:50 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 23/32] drm/amd/display: Fix VPG instancing for dcn314 HPO
Date: Sat, 6 Aug 2022 01:58:17 +0800
Message-ID: <20220805175826.2992171-24-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220805175826.2992171-1-chiahsuan.chung@amd.com>
References: <20220805175826.2992171-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cf7796a4-4c60-4d9b-0e65-08da770c79f6
X-MS-TrafficTypeDiagnostic: MN2PR12MB4424:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: swxKa3TOwQUQVD9pWd3R18kFNQyoMw3VaYQOIE4WU9Zm0iK3N3EZC60i49zBIItlCc8lSqUvEE8paEmj1rTrmKhjqsK9R5pQHWOW4DVDXKT+r5J8EXKZuz2CfCcuMvpyxcxqSOzXrPPHMRe0r1P8vx8G1DULCCHhb208n0SJRu9bgOM5OYWuSphnDTGTf64A/w2QEdusZpRi2aHBgDCLgFfSnFKoyQxfL345g4wyEwLwiT3zS3xH13Zr2rfUSxQR4HzBa+TMW3voHfnUXaV2XyalKZPGZh+HplcTYyrZQFm7uDMgu6i521u0JLtZ1nHBhsnIbd2fmzuDaY2yJ/IdDDvpOgWdXoZKTpQPPxOb68cgGXNWhag+oKH5NbifX901xijbJnYPGw9+pXPuVwPMxAkTjHt0uT+8rGtrfE9RTpwzGPtTpWZfcJY0uk2iBVxnK3Hju+64BhHLvunanKb4v2SqdWxDEqpwGfQqOd1003gVXCzbf3DL5NEf1VMJ/DmklacE0DTVfL6GTAlwYjNCvZZfFmpFKHRRFd8s+sFN9fH4oYIHdT15egB0n4m5AAEr42zkT47TZunMCKi/UO/cbZ7VcI/6i6NlXz0gxLl78Hebkwf9NFYV0BjDwv3w0fIv8hqgql6LFyv/XE8LOkObViMRDftF/TufJ8VaKDBn4DI7lk92AvMNL64h3HkkgvWfurItiQkssOlLkIhHUn07baAgbTCyFiKPQkwl5Ot7TLV67G4wk4U4THr/XZ9PW1ZeqZx+GrXbd1kX8bN8ymp/dvTLjY1YDAy5vK2TuVC4AD26iq8eNsHztrjdYqurdP1MvKr8XY4CVROqhXfEVpDMoA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(396003)(346002)(136003)(39860400002)(376002)(46966006)(36840700001)(40470700004)(26005)(54906003)(6666004)(7696005)(41300700001)(82310400005)(478600001)(426003)(336012)(40460700003)(2906002)(36756003)(47076005)(5660300002)(8936002)(70206006)(70586007)(8676002)(4326008)(316002)(186003)(40480700001)(81166007)(82740400003)(86362001)(356005)(83380400001)(1076003)(6916009)(36860700001)(2616005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2022 18:01:09.4890 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cf7796a4-4c60-4d9b-0e65-08da770c79f6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT062.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4424
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
Cc: stylon.wang@amd.com, Charlene Liu <Charlene.Liu@amd.com>,
 Tom Chung <chiahsuan.chung@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, Duncan Ma <duncan.ma@amd.com>, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Duncan Ma <duncan.ma@amd.com>

[Why]
An issue during VPG indexing offset generation causing
to use the incorrect VPG. HW team placed VPG instances
5 at end of list, making it VPG 9 in register headers.

[How]
Correct VPG instance for HPO encoders.

Reviewed-by: Charlene Liu <Charlene.Liu@amd.com>
Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Duncan Ma <duncan.ma@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c
index 1f095f05d986..85f32206a766 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c
@@ -1254,7 +1254,7 @@ static struct stream_encoder *dcn314_stream_encoder_create(
 	int afmt_inst;
 
 	/* Mapping of VPG, AFMT, DME register blocks to DIO block instance */
-	if (eng_id <= ENGINE_ID_DIGF) {
+	if (eng_id < ENGINE_ID_DIGF) {
 		vpg_inst = eng_id;
 		afmt_inst = eng_id;
 	} else
@@ -1299,7 +1299,8 @@ static struct hpo_dp_stream_encoder *dcn31_hpo_dp_stream_encoder_create(
 	 * VPG[8] -> HPO_DP[2]
 	 * VPG[9] -> HPO_DP[3]
 	 */
-	vpg_inst = hpo_dp_inst + 6;
+	//Uses offset index 5-8, but actually maps to vpg_inst 6-9
+	vpg_inst = hpo_dp_inst + 5;
 
 	/* Mapping of APG register blocks to HPO DP block instance:
 	 * APG[0] -> HPO_DP[0]
-- 
2.25.1

