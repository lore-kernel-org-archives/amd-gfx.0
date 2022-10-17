Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CC0FC433FE
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Oct 2022 16:47:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BF19810E674;
	Mon, 17 Oct 2022 16:47:55 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 92B8410E674
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 Oct 2022 16:47:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q956SZrCx96OExSu3w2SnyHHGntb4SGQOA8bzzmdleGm+J76AICFSTEqpEWf38FiY2j+8ffmOW2f2wI6+w56EiwLEEtt+tPyIJvZeZ+yqtqkP1OIoMPrwlmH2jHUmy2sEofKk78TL32fZkWGu1MJ17nxkewkjIoyqiWQzgc6dyK2sndewHDTlb2W5ooZXt1XReOsusVblqj5WUiEaTTL+zLBYAkgkc5MI6wFHEIdgWkPxmAz0nyiNfovssrQkCxDZ3cnDTReRfVW/2XIliLBDnxV9+86w4rCrNrSzmJCZHCtC3fLJ14HAoN2RGSnpator4QTTg0ElvTFAEefhiSnCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yOnF5+yw+aowJDZtRw5q9SbJti++OwVtQxfgZEThxes=;
 b=mXI7LxRDYkFvxyR/h17OF2HH06tGu/YuMyKgz3Gyo9lCQYtVH82tgksBr94G2FVRaFr80F7LIz4VOA2RbNfWQAucPhKcmT/E7DA0oEy7+5+O0+lc95/8trXBDEN25AcAuV6CvdsvWALsXjq+MYa6f3VdFQ6HFSHqBwKt4LySxi2gbh4HJbdxs4l5TkcvUD6V6JDP9aSPdv8OT/JdRL5A2wWKATLXvbQK34b0wN3JIn64rYmotJDjM3J9Z6XXvsXbjfimMuDM+jqczmaA0AIF2ItQRtHqjCT7gMrXFSZ4OOzWw/ubO1vcH7yUEaIpSXUYuKN9n2VeQwVZ2GCXOmxEig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yOnF5+yw+aowJDZtRw5q9SbJti++OwVtQxfgZEThxes=;
 b=KGaHEby3PxtfY5uh01nBH5bFSXz1jk2NlX5mUrWJao1H80zipae737AWDw4Xaxc/IN58VhSohh2BC8TehZTXHq82EP1mPdRJj0yRkjI70bnbIvkzAm0U1bPPNm0H0fbftFEKRVsgLjYOK+FahPW/gS5v98dKR+LsoxTmVPej5K8=
Received: from DS7PR03CA0092.namprd03.prod.outlook.com (2603:10b6:5:3b7::7) by
 BY5PR12MB4949.namprd12.prod.outlook.com (2603:10b6:a03:1df::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5723.30; Mon, 17 Oct 2022 16:47:45 +0000
Received: from DM6NAM11FT070.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b7:cafe::1b) by DS7PR03CA0092.outlook.office365.com
 (2603:10b6:5:3b7::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.32 via Frontend
 Transport; Mon, 17 Oct 2022 16:47:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT070.mail.protection.outlook.com (10.13.173.51) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5723.20 via Frontend Transport; Mon, 17 Oct 2022 16:47:44 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Mon, 17 Oct
 2022 11:47:43 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu/sienna_cichlid: drop unused variables
Date: Mon, 17 Oct 2022 12:47:31 -0400
Message-ID: <20221017164731.1277472-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT070:EE_|BY5PR12MB4949:EE_
X-MS-Office365-Filtering-Correlation-Id: 503fec68-0217-483a-f9c9-08dab05f50aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OTzpkzeS9R9h9GyihOWXJjQQ/qgxyMPbu6LQma1jMo5KiHJJpihH9a4GuUI5sgkhbD+a8W4gPcH6tYYKS2rlsKTNdcmqKQa62AbCip/LrrMy7Hi3X93ymGfoMpjWXk0KTpycP/ZsJhD9Y9BjqQtHVWWsvT7paRX+kHDw3wtiNTWmZopnzqnD7/QtjVe535C609SdLs7l+uwvpCJZBlEXsg5ad6cJPH79CuRI3UQakb1bGafKWl4NilIP/Pcc9ZHcjn2o+Ya+GTJkauVQYjBtsfz30PQ5LtvM8VGQ9bHNixxQ0CQYKJr7atuiGj0822AVICfyTG5feC3AAz/w7HGrP8IBxwVvUDwmWBCYaOVddVmXNwtGCDjP351wiN3Ngp2IAF1zryey3SOFAJYAbxVVco2+yh7I3TeKwAZ3FUXvrNntrjwX4vbKl7tN2stmPoPXXkzUwiG6N3iNa2sfDlqot0/eqnIX1qPWPOy8405BttqWAaAuKaPPc360k4v16NLpif8VLeKgoOmVKE6fyaSnmQy9vfKpNnbfgmvBJQS7CPPrZHLZCAnzE6l7R5+q6MULv0Yqs6NCUUo69/V1WGBjGmH1Ur7petzqWfcXyTJR5tjzzIEyt6TD0KBcaoNlw8+tDHr6c0MyKsMer/ajcZEVikMGCsvWgOb22rhwZa+qwjDF9IkJfzFyNclSoPcqqFlHy1kiVoSahhVC9n9lGbjGGLs0DHn8oDMqHNcxk0dkLaBJpZ+bGoNXe/XPiZTNtaUcQqp2lVjwE+3qOwB4267/1KnwNpl0cVeQAWLCSTdebpqApF+cai7De2cCdFB9e7hK
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(136003)(376002)(39860400002)(346002)(451199015)(46966006)(36840700001)(40470700004)(54906003)(36756003)(36860700001)(86362001)(2906002)(5660300002)(82740400003)(336012)(2616005)(47076005)(426003)(1076003)(16526019)(186003)(6916009)(356005)(81166007)(83380400001)(26005)(7696005)(316002)(478600001)(8936002)(70206006)(70586007)(82310400005)(40480700001)(41300700001)(4326008)(6666004)(40460700003)(8676002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2022 16:47:44.7329 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 503fec68-0217-483a-f9c9-08dab05f50aa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT070.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4949
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Victor Zhao <Victor.Zhao@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

They are no longer used so drop them.

Fixes: 498acd86a942ae ("drm/amdgpu: Refactor mode2 reset logic for v11.0.7")
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: Victor Zhao <Victor.Zhao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sienna_cichlid.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sienna_cichlid.c b/drivers/gpu/drm/amd/amdgpu/sienna_cichlid.c
index a096f0b740ce..81a6d5b94987 100644
--- a/drivers/gpu/drm/amd/amdgpu/sienna_cichlid.c
+++ b/drivers/gpu/drm/amd/amdgpu/sienna_cichlid.c
@@ -33,8 +33,9 @@
 
 static bool sienna_cichlid_is_mode2_default(struct amdgpu_reset_control *reset_ctl)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)reset_ctl->handle;
 #if 0
+	struct amdgpu_device *adev = (struct amdgpu_device *)reset_ctl->handle;
+
 	if (adev->ip_versions[MP1_HWIP][0] == IP_VERSION(11, 0, 7) &&
 	    adev->pm.fw_version >= 0x3a5500 && !amdgpu_sriov_vf(adev))
 		return true;
@@ -47,7 +48,6 @@ sienna_cichlid_get_reset_handler(struct amdgpu_reset_control *reset_ctl,
 			    struct amdgpu_reset_context *reset_context)
 {
 	struct amdgpu_reset_handler *handler;
-	struct amdgpu_device *adev = (struct amdgpu_device *)reset_ctl->handle;
 
 	if (reset_context->method != AMD_RESET_METHOD_NONE) {
 		list_for_each_entry(handler, &reset_ctl->reset_handlers,
-- 
2.37.3

