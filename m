Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA697EB8FC7
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Sep 2023 12:49:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 75D0D10E62E;
	Wed,  6 Sep 2023 12:49:25 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2082.outbound.protection.outlook.com [40.107.243.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0E2A110E62E
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 Sep 2023 12:49:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QOBp/4UttblvAZ6TyEwSsiOrhE4XS8jIOib0BPH5Enfow+bLMcBzxYaE8cS0sp0j60woZAsjkvmNU4MJ6G1VDxuXckHARX8enSvoLBlb3EnD1SeiyV2yihbsRBiuQ+njNquROgA50SMXOmCnKi6kWkttQNd4CFJCI14uS9IEMvHdDtScW9+4txuPxhIHE6Bjsf7ge0lCNlOxRxxVQsCfp7cjnjgA1HZ7FanPswbUr5/kEnTaIgIdgW9EDRgc+0aZypksAGfIx/Di2E98qtsYXIRe71pL4aJQUUT9B8emrcGcKzG6v0vQTJQ3hgfip8ujd5ACWur2Mz4QSRvN+q82eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WAw0AVY1x/TP7OxKzorKu8jKX4jAHRvuwl3A2e3NNO4=;
 b=QXaDnppUQne7Y5hZe2pPxSzuHHyGLKXgr7hYSOBLdeujF6x3W/fS2IfZXd7csCWyc8Wm+e+8O0yp59nsmKNS/zT3h04EpPu6Xn9DnVVg5hrELSmMSL18Ukd5TtQpoPxwMnY0WE2AtnW1NAUsNdJ0mOkREr8qZH5pbpGZ+mlJQIKQIio0qKYdt/AiAm1++q64NVJNNv8wAqDbnoYsL13QjLr3zrxVbG3WQoqgQcmZhUikLQ9wcvcOiPamU0GnXR8WZ+nA2rUCtVtO8puL/UK2VR7U6h/ED5ui5scazQY+MCIWQyRl+sfOtr7SFkyzWV+JjZGGBmgkhwD91eCyanLXgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WAw0AVY1x/TP7OxKzorKu8jKX4jAHRvuwl3A2e3NNO4=;
 b=yybVg56jUU13n5tstdh3H4f9LVqB5/DSaQAtM4upWL4C+ICGrPX2yeE6v5FzjdOhV30CMRKFnRlCZTyBnJ/YWm5jmYaLZw5RH7hqfYExskvO2LlJUfC3v566VRU+KtwMYan56njfMIDy7oaPTZ028sAYPHO9nCfq7FvV/oBPxBM=
Received: from CYZPR14CA0031.namprd14.prod.outlook.com (2603:10b6:930:a0::21)
 by DS7PR12MB5719.namprd12.prod.outlook.com (2603:10b6:8:72::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Wed, 6 Sep
 2023 12:49:19 +0000
Received: from CY4PEPF0000EDD4.namprd03.prod.outlook.com
 (2603:10b6:930:a0:cafe::de) by CYZPR14CA0031.outlook.office365.com
 (2603:10b6:930:a0::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.36 via Frontend
 Transport; Wed, 6 Sep 2023 12:49:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD4.mail.protection.outlook.com (10.167.241.208) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6768.25 via Frontend Transport; Wed, 6 Sep 2023 12:49:19 +0000
Received: from stylon-EliteDesk.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 6 Sep
 2023 07:49:14 -0500
From: Stylon Wang <stylon.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 04/28] drm/amd/display: Add dirty rect support for Replay
Date: Wed, 6 Sep 2023 20:28:09 +0800
Message-ID: <20230906124915.586250-5-stylon.wang@amd.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230906124915.586250-1-stylon.wang@amd.com>
References: <20230906124915.586250-1-stylon.wang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD4:EE_|DS7PR12MB5719:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a5b7ad1-b29e-44a6-9c60-08dbaed7afb2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NplM8Z9ra5sAMMzL4LSlcFiYDWmEa8VLG1y8DqNm8btEQaQGrDXwl93u5aDMj7sPaEmylYWipWhi5oOlYzBLQt1CMYwLLT7w4XkMT3ZB9XcztNhagJSQ92Gt+tKFFAyPEPobO3qeAUh3Fb/H3yltaRjDiIVdune8klTyyHNZH3AfJawxQvrT0UUqskPDoRQdc3UlOnGR4G/5lmWUlRdxT3SK2KhByF3xDpjEruCcNLVc+u6kSdLamzXfXiuGXFMMMzZMl43Qk0Z1EMbjWhdVCp2/CMGEavoVA6DIXWdj3Nlcu0lu79amYcUL/T5MYk2Nx7XpV9zZaD33qU/pOCXAJlwqP1GCLtM/FSZ8TvmFNUS88dp2PSNd0ZwJnOfdBNZgjTQs6lcAnhdXmdjdyliGq82nGdRYzuUx4mmjdEnkuGOli2YO8NyBPiC3FlXsUEB1tLzaV+qkUSPHA4TVV82PhrB3EDBw5/1zOqYei+HIaDbQxsYFRGf9gYgBqmcR0WhMEQ+zka0QlXPX+GN9/yIfMSxGjsfuuF1jS/OnqCuAi5ZfQBafs8wLEXIK4uzfb6Bof9qX4ZJrbHKW57BCkTdDOcM9vU4l9CF9VuFTJqnoT3qtZgBDT//Mr76BMBtWf2eNgFAFBMgwGM1AT+2XwB24X8AmwpY646c1VF4vz6pi7Nwl5C4ctDq9yoECydgECZCAlp+gJ9MvA212QewgUhK1MMPzFjveXOwWB6zMfKNaqEOG0Q7GtfWB35/X7bXRrYpO04PdX5/radqeqoelPEadXpGdW/WjaTC+tRiCEyq7PFE=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(39860400002)(376002)(346002)(136003)(186009)(451199024)(1800799009)(82310400011)(46966006)(36840700001)(40470700004)(36756003)(316002)(2906002)(41300700001)(40460700003)(82740400003)(40480700001)(86362001)(356005)(81166007)(44832011)(5660300002)(36860700001)(426003)(47076005)(4326008)(8936002)(8676002)(83380400001)(2616005)(1076003)(26005)(16526019)(336012)(7696005)(6666004)(478600001)(54906003)(70586007)(70206006)(6916009)(14143004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2023 12:49:19.1039 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a5b7ad1-b29e-44a6-9c60-08dbaed7afb2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5719
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
Cc: stylon.wang@amd.com, Sun peng Li <sunpeng.li@amd.com>,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 wayne.lin@amd.com, Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>

Dirty rect can be used with replay, so enable them to allow for more
powersaving.

Reviewed-by: Sun peng Li <sunpeng.li@amd.com>
Acked-by: Stylon Wang <stylon.wang@amd.com>
Signed-off-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 1bb1a394f55f..93f8ec2acb4a 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -8103,7 +8103,8 @@ static void amdgpu_dm_commit_planes(struct drm_atomic_state *state,
 		bundle->surface_updates[planes_count].plane_info =
 			&bundle->plane_infos[planes_count];
 
-		if (acrtc_state->stream->link->psr_settings.psr_feature_enabled) {
+		if (acrtc_state->stream->link->psr_settings.psr_feature_enabled ||
+		    acrtc_state->stream->link->replay_settings.replay_feature_enabled) {
 			fill_dc_dirty_rects(plane, old_plane_state,
 					    new_plane_state, new_crtc_state,
 					    &bundle->flip_addrs[planes_count],
-- 
2.42.0

