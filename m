Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77D9BC41535
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Dec 2023 14:12:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F306B10E08E;
	Tue, 19 Dec 2023 14:12:05 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2084.outbound.protection.outlook.com [40.107.220.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B829B10E08E
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Dec 2023 14:12:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g31d6AQMz4EsVpUlZwrU094FCUFBOqHBmP37HAs40Vjj8AeApwfw3BpBTKORVxSq9V2e9LaZ0XuTYiMA1fB5+q94sz+IQkIkV1//8xwDnedaHj5AdaH+Y6saKOWb/mrDTTrenMiaEqmpZSsJeEBwexaJlkFgtTavyr/TnFSAkTeHyGEDmecDkv5lbbM1+ntFYVGPbAcuNM3rCp5lj1JiQpqIScIG1Uiidb+phcABppUgnhPnjIppaEPu+Bo7lfg5G5F0grDfWTS/ymV01DMnJSfHfu2uuLZqq6Xdfk4GJiLGNxMLUgT3WHctmmaWgr2vzmSY9ry0iatFIjqbEZl1SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wLN41NWl8NfaSOYTKChzZtfEcPEoS4FREdqVxqDXR/Y=;
 b=k3W+4Igh8wt0/xr4aYmycvrNiKVSvmMQlGODzT1CKxg/48RaM/lfhSB6/6KkNPSV9Lm5XkiBsYHwQ14ghf9LAt9JanALxXSt8a1EzrwqkepuBO4JsPMNKTJ2CaQgIyXOU+LP4Tu6+DJIOqfwZQ5b6aT7/6iFUAcRevyAHDw0CHDQeIKppvZFGSKw0vDorEMiBDFGAv/mma7alrLf4kTOV6FhE/Ba+pWB2eqTskKL+FKbkyj4Wq1WFrLzgf0CKg+/lj46o1iXfgatln/x0d9SqozRGltDOIE8eN9/0mfK1S0HXUKMT+YEshp8YG2YxuwLPLNXfXg4b08cnCzdXJQQhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wLN41NWl8NfaSOYTKChzZtfEcPEoS4FREdqVxqDXR/Y=;
 b=Phcn8HX2qrKdG6GcWLq3gXlBRVgd571AKJthMdiKVvKZ89516N66WWZ+XFw74ooQbFs1T245vYNExvZw1Nuu9XYi4wXC+enrko9K9ggy4mVlAv5M1O+1CrwiqIDUpI7ZrfGbQLkW+KKZzgeLZriRYSoIS/ctmpId4OWsaya//TU=
Received: from MN2PR08CA0028.namprd08.prod.outlook.com (2603:10b6:208:239::33)
 by IA1PR12MB7662.namprd12.prod.outlook.com (2603:10b6:208:425::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.18; Tue, 19 Dec
 2023 14:12:01 +0000
Received: from BL02EPF0001A0FF.namprd03.prod.outlook.com
 (2603:10b6:208:239:cafe::ce) by MN2PR08CA0028.outlook.office365.com
 (2603:10b6:208:239::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.18 via Frontend
 Transport; Tue, 19 Dec 2023 14:12:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A0FF.mail.protection.outlook.com (10.167.242.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7113.14 via Frontend Transport; Tue, 19 Dec 2023 14:12:01 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 19 Dec 2023 08:11:59 -0600
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Subject: [PATCH] drm/amdgpu: Use kzalloc instead of kmalloc+__GFP_ZERO in
 amdgpu_ras.c
Date: Tue, 19 Dec 2023 19:41:41 +0530
Message-ID: <20231219141141.554794-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FF:EE_|IA1PR12MB7662:EE_
X-MS-Office365-Filtering-Correlation-Id: 42e5068b-69b1-47d3-38de-08dc009c7872
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wMC+cprwJf7iBP4b1kNRv0qj82arh1PjFAi4YhNct30DuljZYzzXvhwedIQZgy77i1Hq3u1nT605/4yBuTQjIy0q29aEF3JTgMUS9PrC/dw81yw6uKKu3hNb43DxiImT7wU1owTo690ADJE7VyDSMXq6Zbl2ITgx3Ut+GeQHTbFQ81btMLcWIT8xqD4nhCwfesbFOLE+J50w65T4HY1CrR9/4H/3zCIuMYSK2mikzBRuBVs/asDmyd/FEVgiEKkh6/EzRQvHLqE70KYeCwfRTZvAqS+hAcACpyOmCcn7CAYyTunD/SwxQ+EznKVnUyXClVhbXhtYepv+MGV+OH2SL0vDTO/RxmuZYJkdCdI7p0uuBRJzlXEYYSnVBQjDp8bNuJcaHJatldE2lq4sotgbj/hgsn7nDgIVPT56Kyg8fU2vm7sIcNJ6jc1rygyY+Chr4gYlLzOEt6iWiINc7w2yTxV6EOGADatpQ/68v3+2HpJx3q7F4dwCFqKIH3LYI28pwxPtoVkwUKWHIi4yChXAfNxpt0yJDinYyWKK7juqoaFXblNoBPT1Yadro0S7ntZ8CeYiGV34Hm2D7eKabtPuR67css70f2C+F4O0rZjuzV81VkUkBbdioY8Qc6b9go63vbxDyqsvtQXPCWrIAKA15GbPn/Xbww74YGzLzX0dpEvbIPWZk74ZghwpV/q3CKhy2SfgbejXU304HCZ0rb85oPPSqA6YnXEK8auV6ADaiK19eoViSLJXBe1wDJojucbOB2R+EcHh49JNcgeC9ExuMjpAy8xCj0gJ0zlbWke/14xt59umilgLuKkZJgFpz+i+
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(136003)(376002)(396003)(346002)(230922051799003)(230173577357003)(230273577357003)(186009)(64100799003)(82310400011)(1800799012)(451199024)(46966006)(40470700004)(36840700001)(426003)(16526019)(336012)(2616005)(478600001)(41300700001)(1076003)(40480700001)(26005)(36860700001)(81166007)(70206006)(54906003)(70586007)(40460700003)(83380400001)(110136005)(6636002)(6666004)(316002)(86362001)(7696005)(356005)(82740400003)(36756003)(8936002)(8676002)(47076005)(2906002)(5660300002)(4326008)(44832011)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2023 14:12:01.4948 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 42e5068b-69b1-47d3-38de-08dc009c7872
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7662
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
Cc: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fixes the below smatch warnings:

drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c:2543 amdgpu_ras_recovery_init() warn: Please consider using kzalloc instead of kmalloc
drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c:2830 amdgpu_ras_init() warn: Please consider using kzalloc instead of kmalloc

Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index bad62141f708..e541e6925918 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -2540,7 +2540,7 @@ int amdgpu_ras_recovery_init(struct amdgpu_device *adev)
 		return 0;
 
 	data = &con->eh_data;
-	*data = kmalloc(sizeof(**data), GFP_KERNEL | __GFP_ZERO);
+	*data = kzalloc(sizeof(**data), GFP_KERNEL);
 	if (!*data) {
 		ret = -ENOMEM;
 		goto out;
@@ -2827,10 +2827,10 @@ int amdgpu_ras_init(struct amdgpu_device *adev)
 	if (con)
 		return 0;
 
-	con = kmalloc(sizeof(struct amdgpu_ras) +
+	con = kzalloc(sizeof(*con) +
 			sizeof(struct ras_manager) * AMDGPU_RAS_BLOCK_COUNT +
 			sizeof(struct ras_manager) * AMDGPU_RAS_MCA_BLOCK_COUNT,
-			GFP_KERNEL|__GFP_ZERO);
+			GFP_KERNEL);
 	if (!con)
 		return -ENOMEM;
 
-- 
2.34.1

