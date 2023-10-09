Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA1CFE95A91
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Oct 2023 15:55:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 456F010E065;
	Mon,  9 Oct 2023 15:55:03 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on20603.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e89::603])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B254710E065
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Oct 2023 15:55:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RP5kg5m2AopapbVQl/VMLlH62HSHir8khL7nqcj1x/cprh4svnAsk5B9Erb035IxkNFgMgEUAJJ/RvyA7B13eUZ8oHEoq05gk3Wr3DtXtiVELNyo2KwiHqIjYRF2ZKvNac2VPzQFDfaZg5+Gzc+0mzdiq7C4mOxZac7ZLkZNdilZhxtV0Ath0N8fY+YtEpPTGuXLSCzfeX98euxqzshZHIUVVyzpTosQNiKIFFzDrUCl+9qOwYSVNi2Yf2XT38KCgRP8gLR3UyH+S07DfN4sXNv+8rqLoSV4X+zL+bORHRr89KKG8BhWBPWor20RM9aoKc9qlo6MsYtfYGUU+0zLOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xiHmicltfDMjvmRysOwXfoaQlDAZvF3NLN2IewwXY7o=;
 b=C2v4JPthXe7MMhEZaj9mYLel/OrbUGD/UrzAGcNsu+LnWmyg+LtxbVXtcndFZKyt/0X70fmZJfyCdf3m+MoQDUBR1NH5rSEtf6jDhju6hAY7rdz6ISkmK6zN6QbiXSs3163YB29aIRI98Mwc6ZFLxauKTM5GnZI5OEOV5/uafEdqLuoYQTCG9igFqKeVQ+49RldSK1raPi9mWETADkTFM6GAimA/gUHEYPDCciFVd8C6J3OMs6n/aCUWVwIHJScn9bzJN55QgBy8u33oCyGoGn/uAQEP6rPmKGU37RujTss7tzYl2de6vK6FF2fBMRFLWihypxzJ6kz+9Yg6ru+bSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xiHmicltfDMjvmRysOwXfoaQlDAZvF3NLN2IewwXY7o=;
 b=5M+8oXwcjKCQSEPTPKVLsN5yQyijQsv0vTnVwmaKxN+Y/g3gn3O14GmoQGWnizs2xSMNM03RpCe+fYEEeko1IS/vW+0yfBuB45hqwJxUvaMnnWhl28fcp3M99KmMe1vmJkqp2ecOE6usO7oF1V0lt0hV0woiNpLjO65sAqgnhqc=
Received: from CH2PR16CA0027.namprd16.prod.outlook.com (2603:10b6:610:50::37)
 by SA1PR12MB5640.namprd12.prod.outlook.com (2603:10b6:806:23e::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.41; Mon, 9 Oct
 2023 15:54:58 +0000
Received: from MWH0EPF000971E8.namprd02.prod.outlook.com
 (2603:10b6:610:50:cafe::31) by CH2PR16CA0027.outlook.office365.com
 (2603:10b6:610:50::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.36 via Frontend
 Transport; Mon, 9 Oct 2023 15:54:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000971E8.mail.protection.outlook.com (10.167.243.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Mon, 9 Oct 2023 15:54:57 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 9 Oct
 2023 10:54:43 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v6 2/7] drm/amd: Add concept of running prepare_suspend()
 sequence for IP blocks
Date: Mon, 9 Oct 2023 10:54:21 -0500
Message-ID: <20231009155426.96232-3-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231009155426.96232-1-mario.limonciello@amd.com>
References: <20231009155426.96232-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E8:EE_|SA1PR12MB5640:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b480bf6-79ac-4972-b46a-08dbc8e0168d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /pJ9v1Fw3FTCYMk2KxG0srunGQbU7aNvMewxHSeUz6iy70xqvLdzrt8auwTBIw+nUw4WZI1P7q8vjT+iNWuN5dlH6JFsWuZ1/L/IwKARRp4qXyKRNW++quy6Ah+P+gYZhCVv5d7P5DEusMmJ4Z2RRLJ7FiWpCJtUrgteHW2oxLLtAr8bjX9cKGuYTvY0m+hTk08rBoyGgSw+kRMCBRWeY8m7hvtx50S1Wt9iz8ZWJJO/dJfCBR//z2VnvNWdxup1OlRIz2D0jURS8kYM+Xo3LeSrirJrBw7Yb8m1aPCW00g7pX9RWghP8Y4ozrZKJaMneFO8bZ156Oka72I+/qD7xmqB51bzbqZYaBWrRj8E/Pac9JaldhJ2Ez6n7mCND/yx6EhgLA2uCukMYjJABRa8vflTgm1taX/Ut/VtXoU6q+J775h9SO3wUo3tGjNeU1wVMyAGtIuCvkO2S3SOks/Mvt319cIO45ZUYBB2wV3frL+NMEneeleMRUQy/vnuWGeJkiKOXVqbZUjEJ2SEwGATok9vQhVz3NkZlmRDepfOgJDo85iDjBU+Mtm51NT3XV4FMjtIIJhXovmPKcxVRTc2Y52d0DbH/1IFipizInpJmrOtGshCc3kxy7jOf8CGFU0eZ1SuNG4LMxT51+5ZXxrpQ74HqhklSFi/AQLQN7F11So3oqfESiutr5hJUFzJdqQKHztg7+uunS3bXJ62BJc4KIXSVZ+LNxbxNYhgumu+ofivPpnIu6MR7rbbwEXChiFw3lGObuhuGnbv+p07IcyMzg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(346002)(376002)(396003)(39860400002)(230922051799003)(82310400011)(451199024)(64100799003)(1800799009)(186009)(40470700004)(36840700001)(46966006)(2616005)(1076003)(336012)(26005)(426003)(16526019)(6666004)(478600001)(8676002)(66574015)(47076005)(36860700001)(83380400001)(4326008)(2906002)(41300700001)(54906003)(70586007)(70206006)(8936002)(44832011)(5660300002)(316002)(6916009)(40460700003)(81166007)(36756003)(86362001)(82740400003)(40480700001)(356005)(7696005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2023 15:54:57.8265 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b480bf6-79ac-4972-b46a-08dbc8e0168d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5640
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
Cc: Mario Limonciello <mario.limonciello@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

If any IP blocks allocate memory during their hw_fini() sequence
this can cause the suspend to fail under memory pressure.  Introduce
a new phase that IP blocks can use to allocate memory before suspend
starts so that it can potentially be evicted into swap instead.

Reviewed-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 12 +++++++++++-
 drivers/gpu/drm/amd/include/amd_shared.h   |  1 +
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 0a7cc9107f07..0f98f720d9ca 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4348,7 +4348,7 @@ static int amdgpu_device_evict_resources(struct amdgpu_device *adev)
 int amdgpu_device_prepare(struct drm_device *dev)
 {
 	struct amdgpu_device *adev = drm_to_adev(dev);
-	int r;
+	int i, r;
 
 	if (dev->switch_power_state == DRM_SWITCH_POWER_OFF)
 		return 0;
@@ -4358,6 +4358,16 @@ int amdgpu_device_prepare(struct drm_device *dev)
 	if (r)
 		return r;
 
+	for (i = 0; i < adev->num_ip_blocks; i++) {
+		if (!adev->ip_blocks[i].status.valid)
+			continue;
+		if (!adev->ip_blocks[i].version->funcs->prepare_suspend)
+			continue;
+		r = adev->ip_blocks[i].version->funcs->prepare_suspend((void *)adev);
+		if (r)
+			return r;
+	}
+
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/include/amd_shared.h b/drivers/gpu/drm/amd/include/amd_shared.h
index ce75351204bb..98e60bc868dd 100644
--- a/drivers/gpu/drm/amd/include/amd_shared.h
+++ b/drivers/gpu/drm/amd/include/amd_shared.h
@@ -299,6 +299,7 @@ struct amd_ip_funcs {
 	int (*hw_init)(void *handle);
 	int (*hw_fini)(void *handle);
 	void (*late_fini)(void *handle);
+	int (*prepare_suspend)(void *handle);
 	int (*suspend)(void *handle);
 	int (*resume)(void *handle);
 	bool (*is_idle)(void *handle);
-- 
2.34.1

