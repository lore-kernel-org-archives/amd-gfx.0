Return-Path: <SRS0=Ip3g=OV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D4C6C433F5
	for <amd-gfx@archiver.kernel.org>; Fri,  1 Oct 2021 10:16:35 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46467610E6
	for <amd-gfx@archiver.kernel.org>; Fri,  1 Oct 2021 10:16:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 46467610E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C0E856EDE7;
	Fri,  1 Oct 2021 10:16:34 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2089.outbound.protection.outlook.com [40.107.94.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BE7EC89395
 for <amd-gfx@lists.freedesktop.org>; Fri,  1 Oct 2021 10:16:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c4kK48hmvxM0kY4hiyVwb38RjYQdPfr6aQ5ojKN6q9kLvm52vXfYaYttw6pOAYWGfRDF0zXZjZqnxY83RveWg3JSXSc/ygSdxynt3iIfWnyKjTR4cEFYDBlWSPbm1qn2I55RJ8Ba9RuXSY3Ojnm7mBvHhpe5hen/IgPvWb1AL/d9vVXoaO69uiBhyI9cH9e8/OLOTJuK9SeFfSbiJfTwzqyjmQfZfNBKFktxhZtCgx+EQMQAbZ7q9A7iNeBQhNLoPkfpWHu2+3iu7R+wXMp3r33UtDLS47MyIm2PRxSuBMw7tw9GQfyppEILO/W3U+vg5enBO1RLfqqyOtS+ssQNKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0IJZ9oEWLlDZm94NF11AGTS/dLbwuapfcA7GYddHl68=;
 b=BbtTGQqdXXa9uv+kEH+Usgx78pMtp9U8U25ojIydhIdv5DnXHOzw80mxe2oyEicRTFtt7Y7dOyFZbxeW9DYKAJcMOOmhsaW/AYsAFEijyf1hwlUPUZiSBTYXWhs8I6RRjgnH33vBJotF3e3NLM0v4aJf6Qf6kaLUGpM1IZ77olKYiC801v5eZ5qe//cIaa+T6Z59Amps4V193aef+m9XbLvueUbDbatL2naf6lfaQXgBaBTh9rBczKh2b+1MXOuHdGa9iZpOh088KgY+YgBhaUvSdDuA0xNfXqB+GvoQn4FZdfuzSU9qT4DYEJytxQ1tUf40q7UggsaadGYr+aMdjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0IJZ9oEWLlDZm94NF11AGTS/dLbwuapfcA7GYddHl68=;
 b=sEDrf1duxmeMvFwHX1RsnUGiMDsnwTuhRHcuRT0+bVsT3tx/y9VncGxrP5YjTd7Bpu4HIBZQU12b1TNRUzx8hZSJdCiUcWJRWROycHaECozQlOFEe9+1b1lr57vz+nBrGwvO/EoR53/pOpWIDZaFJIUesVqPRwNJ91Q1JDJ73Z4=
Received: from DM5PR07CA0047.namprd07.prod.outlook.com (2603:10b6:3:16::33) by
 DM6PR12MB3610.namprd12.prod.outlook.com (2603:10b6:5:3a::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4544.14; Fri, 1 Oct 2021 10:16:31 +0000
Received: from DM6NAM11FT064.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:16:cafe::7d) by DM5PR07CA0047.outlook.office365.com
 (2603:10b6:3:16::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.17 via Frontend
 Transport; Fri, 1 Oct 2021 10:16:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT064.mail.protection.outlook.com (10.13.172.234) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4566.14 via Frontend Transport; Fri, 1 Oct 2021 10:16:30 +0000
Received: from lijo-u1804-kvm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Fri, 1 Oct 2021
 05:16:28 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Mario.Limonciello@amd.com>,
 <Hawking.Zhang@amd.com>, <Kevin1.Wang@amd.com>, <Evan.Quan@amd.com>
Subject: [PATCH] drm/amdgpu: During s0ix don't wait to signal GFXOFF
Date: Fri, 1 Oct 2021 18:16:25 +0800
Message-ID: <20211001101625.15575-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 291ec247-dd60-4fd1-57df-08d984c489b8
X-MS-TrafficTypeDiagnostic: DM6PR12MB3610:
X-Microsoft-Antispam-PRVS: <DM6PR12MB36105D6AA3705DED52F1184B97AB9@DM6PR12MB3610.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1091;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: T+q3mRLqAtMBSx653wspYHttdQgTcnoSCpOYz0hxEP5jq+hlE0HGOC6paAeqWVYFnVYD2uDtVRewUbGNRjqp30STluvUqUi+XPY2v3xp3zS9K4M7mMtYX6/xm2S+bgGPbNlE5qSRY5IZNo4iRrY84bJBjs2uk4V+MHN9XMtgSFSQOv7PVqdcYl7RC+hiOkMT7b2k39TNPTYp2nKW0qcmK89+xMzgAgYyqUY3Go3akqs3Nb/L4SqrkiCgleBI6o7BopxDlcPwT7UgbcY8cQnyHj+V22255Mw7L1P4bI05jdZZoQi/AKluzaPpTZcYqpmOe5eyNcZ0AOUtBlZVNbT86lolhiy4G9wWV37bs9cil9adYO48PomRBlB+JrHe2geAP4iDRqfOrdeJboCV6cdn18BDQOYqeNADT6D1xPxIKKzOFbJ4Hi2P2BUlHQxl3+Fv/0AoKPD+F0wAbuwymprorYsz4mr9/lNqGAwC4T3mENDA7D6BmqaOcEiNFcdEti8YrcHGvM3UNQ7Ge8hKrH22jtMXXHglipfoPzyOtP7P2A/yLZZw1cQSf2SZcsnIeFVIIc+Yxwvf90S0mSSCfTRMnjuyldaH0LnS3xp24b+FY+6K8h73wlalRtxCmHpc+h0NuRM82Osa9Cg8nug+K/S/XHCL7v3cSwKxFCiOpMAqzjlZvV7STTp6ZlZT+HUY2we4Wk9DP8zBayIOpQPISpSncmAEupbOEmai6JfqJOaT8a3zB4Blbntz+Vn6nGRG3ZzO
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(2906002)(336012)(26005)(8676002)(4326008)(1076003)(47076005)(2616005)(7696005)(6666004)(508600001)(5660300002)(356005)(426003)(82310400003)(81166007)(83380400001)(6916009)(316002)(36756003)(70206006)(54906003)(70586007)(44832011)(86362001)(186003)(966005)(36860700001)(16526019)(8936002)(32563001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2021 10:16:30.7853 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 291ec247-dd60-4fd1-57df-08d984c489b8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT064.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3610
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

In the rare event when GFX IP suspend coincides with a s0ix entry, don't
schedule a delayed work, instead signal PMFW immediately to allow GFXOFF
entry. GFXOFF is a prerequisite for s0ix entry. PMFW needs to be
signaled about GFXOFF status before amd-pmc module passes OS HINT
to PMFW telling that everything is ready for a safe s0ix entry.

Bug: https://gitlab.freedesktop.org/drm/amd/-/issues/1712

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index e7f06bd0f0cd..1916ec84dd71 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -31,6 +31,8 @@
 /* delay 0.1 second to enable gfx off feature */
 #define GFX_OFF_DELAY_ENABLE         msecs_to_jiffies(100)
 
+#define GFX_OFF_NO_DELAY 0
+
 /*
  * GPU GFX IP block helpers function.
  */
@@ -558,6 +560,8 @@ int amdgpu_gfx_enable_kcq(struct amdgpu_device *adev)
 
 void amdgpu_gfx_off_ctrl(struct amdgpu_device *adev, bool enable)
 {
+	unsigned long delay = GFX_OFF_DELAY_ENABLE;
+
 	if (!(adev->pm.pp_feature & PP_GFXOFF_MASK))
 		return;
 
@@ -573,8 +577,14 @@ void amdgpu_gfx_off_ctrl(struct amdgpu_device *adev, bool enable)
 
 		adev->gfx.gfx_off_req_count--;
 
-		if (adev->gfx.gfx_off_req_count == 0 && !adev->gfx.gfx_off_state)
-			schedule_delayed_work(&adev->gfx.gfx_off_delay_work, GFX_OFF_DELAY_ENABLE);
+		if (adev->gfx.gfx_off_req_count == 0 &&
+		    !adev->gfx.gfx_off_state) {
+			/* If going to s2idle, no need to wait */
+			if (adev->in_s0ix)
+				delay = GFX_OFF_NO_DELAY;
+			schedule_delayed_work(&adev->gfx.gfx_off_delay_work,
+					      delay);
+		}
 	} else {
 		if (adev->gfx.gfx_off_req_count == 0) {
 			cancel_delayed_work_sync(&adev->gfx.gfx_off_delay_work);
-- 
2.17.1

