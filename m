Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1B0FC43334
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Jul 2022 08:42:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7181AA3802;
	Thu, 14 Jul 2022 08:42:13 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2077.outbound.protection.outlook.com [40.107.96.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 66B6EA3802
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Jul 2022 08:42:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZzebO2Fs6Mqaf2WuO/9Li9S6DoScBk8BbE3FnRxkQ7JyV6zuP2sKysjSbVjSq90ejrcA3amTz1uBtLgC8MFPoBZHebzyipUStR7ndx6YJbB3kISWnWLZgoRbXaGlJ909V6qUFqYJQ2zQoKEvagkLVKYbVXYRAuVdbeMAdASbSpH6QGTVnXsGQlZc7ze/rrH1m/OznITzsofqsespGwailoiUhREjcXyngrKzJQylSc0gTNLJ0fsXLPbg9R5PzC5dQK3RtjEwjHUogfBTuB64x81aSvTUJZptGP26HrSSY0K7qyajMmV6ZpZMG0E1sdvLWdek6p+wU9NzMH4iySX5rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZMRZzoZXeVH+eoUAMGaTMYMV563CQ8UKA6YCcY3bAEM=;
 b=Q/f/6jcMObXPIFenPfdt8EWHPFfbH8jg7XveY6odp98xYo1N66FAlV6w7nvOw0qcgjW4WN0nufwn5U1bOy1sxWUmCFKyYF89gHK3wpP6ZF99zQZjcOfqSBTylEKfqENsZ8arSiKLyFxIRqB1ZqD6QiMkTtaLLvh5xpAioDjKoqZb0OGwmqxvXdHbbHGqTeF0f40VsmJ0TdjYK1WXnrKlVWgG+wpwQ/OHibWEISczyuXPc3jyIq6g8bEwTTpgJfOJSHm4HwH7Jg3FsixMe3glddEmxb767NezIDcN1Fy8XsfgMZLQWoJqKxJsfikW7yk5ERacNgXR0a3X9YZaHIkdFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZMRZzoZXeVH+eoUAMGaTMYMV563CQ8UKA6YCcY3bAEM=;
 b=0/DFzvri+FA+a0XSYQfQ4xAfnFJ83GizlyHy71T/54PEyUihGfco917BgFSgtnGLn9aWmWvf4KSIz9uLsxrEYpRyZedM2gkPDRvMyn0KnBUt2ZAsV1b9tYz7fXMDKdWoIDWlZwo7cLJatsKZOTOPXyasfun7rc+oYuepFgmmT/k=
Received: from BN9PR03CA0780.namprd03.prod.outlook.com (2603:10b6:408:13a::35)
 by CH0PR12MB5385.namprd12.prod.outlook.com (2603:10b6:610:d4::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.16; Thu, 14 Jul
 2022 08:42:10 +0000
Received: from BN8NAM11FT025.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13a:cafe::90) by BN9PR03CA0780.outlook.office365.com
 (2603:10b6:408:13a::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.16 via Frontend
 Transport; Thu, 14 Jul 2022 08:42:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT025.mail.protection.outlook.com (10.13.177.136) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5438.12 via Frontend Transport; Thu, 14 Jul 2022 08:42:10 +0000
Received: from guchchen-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Thu, 14 Jul 2022 03:42:07 -0500
From: Guchun Chen <guchun.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <alexander.deucher@amd.com>,
 <hawking.zhang@amd.com>, <lijo.lazar@amd.com>, <evan.quan@amd.com>,
 <kenneth.feng@amd.com>
Subject: [PATCH 1/4] drm/amdgpu: introduce runtime pm mode
Date: Thu, 14 Jul 2022 16:41:46 +0800
Message-ID: <20220714084146.2583-1-guchun.chen@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 143e7572-2349-4e49-b6b0-08da6574bdc9
X-MS-TrafficTypeDiagnostic: CH0PR12MB5385:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QW/X0azJt2wYJQ01K8ubsKtUowg4ueN459Brmj5kv0VviYhjVIOGqds4D63dPzjp7A8GrBoLGo5gN7wpuqsfgvotWJHFeWdClOdQCAE6nUYp6LJemWHZKHobWdyfGoYpg/jZwzD2mb2EQWCN36JrpP1p3s362u1k27ubM1P26BKvQgy7E2SJA0Uk0XOA91DnkDk7lTlmxkj8DYFMEAAaG4Rf6duowz3Palk+gLS3EN1mhRR4ruhoDZszbPektp2w/LibeqPGl9SlE0EGU2DlNZtf5v+kvIHMPJ4QK+Rs+hFDifykyh5RjgRzJi9N+V3tGXChpPYLBE0qdjkj7k9ZJ/lhKkWNz0VyO/Af1xH6OFTE9T5ZgGLXHNL9u6Gmh9TeAYTn+ssbfCs3z2dgp8CDzgLPLFQnV11lu5807oRMC5paUkHkzAsIwwYolkzLN+poUAOIFEM/VYasneb4rZ7H+8F0MZK2BgAZMLiT61FqQHrPa4+QBMosoXyHsZy9Nz4ubcjm4L+wsDBslC4k6TqyVu/hisy114rT28P5KpDcUyGt5TbvL/fyBRDllS/REvGuPOuIWL0D9UzoIm9G4V+rmot3WVNYTx2G21fYbq87Df3gSsLoJDevHahPWpn6Q/e1tXv4S9F0dwCjwyJh+fySZwzNE+jg8jxOWrwnCWZTcJtm0F1D24rwNulNqtCyu+T8uqqXr7Q71c8zysiafffwJjqMl8jEAMSs0AXhrR5zDR9V/bkUAA38hL5h753mUz08VBqHLhQDCcXGx/3/X2aGTmaLRankibZxmJcVr0PbVsc0c5g9ED/1fd5hzxtZGElOK0mDvTLF7Eg59hXYy0epetM50wUUjwqQFZK1d3C3VUsv/AC20gkds5gmMcRv2P+V
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(136003)(396003)(376002)(39860400002)(346002)(40470700004)(36840700001)(46966006)(110136005)(1076003)(44832011)(2906002)(2616005)(47076005)(316002)(336012)(426003)(478600001)(86362001)(40480700001)(5660300002)(36756003)(82310400005)(36860700001)(6666004)(40460700003)(8936002)(356005)(4326008)(8676002)(16526019)(82740400003)(81166007)(70206006)(41300700001)(7696005)(83380400001)(26005)(70586007)(186003)(6636002)(36900700001)(2101003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2022 08:42:10.0446 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 143e7572-2349-4e49-b6b0-08da6574bdc9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT025.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5385
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
Cc: Guchun Chen <guchun.chen@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

It can benefit code consistency in future.

Suggested-by: Lijo Lazar <lijo.lazar@amd.com>
Signed-off-by: Guchun Chen <guchun.chen@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 6 +++++-
 drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h | 9 +++++++++
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index 4b663866d33a..ceecb74842de 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -161,10 +161,12 @@ int amdgpu_driver_load_kms(struct amdgpu_device *adev, unsigned long flags)
 	if (amdgpu_device_supports_px(dev) &&
 	    (amdgpu_runtime_pm != 0)) { /* enable runpm by default for atpx */
 		adev->runpm = true;
+		adev->pm.rpm_mode = AMDGPU_RUNPM_PX;
 		dev_info(adev->dev, "Using ATPX for runtime pm\n");
 	} else if (amdgpu_device_supports_boco(dev) &&
 		   (amdgpu_runtime_pm != 0)) { /* enable runpm by default for boco */
 		adev->runpm = true;
+		adev->pm.rpm_mode = AMDGPU_RUNPM_BOCO;
 		dev_info(adev->dev, "Using BOCO for runtime pm\n");
 	} else if (amdgpu_device_supports_baco(dev) &&
 		   (amdgpu_runtime_pm != 0)) {
@@ -188,8 +190,10 @@ int amdgpu_driver_load_kms(struct amdgpu_device *adev, unsigned long flags)
 
 		amdgpu_runtime_pm_quirk(adev);
 
-		if (adev->runpm)
+		if (adev->runpm) {
+			adev->pm.rpm_mode = AMDGPU_RUNPM_BACO;
 			dev_info(adev->dev, "Using BACO for runtime pm\n");
+		}
 	}
 
 	/* Call ACPI methods: require modeset init
diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
index 524fb09437e5..65624d091ed2 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
@@ -45,6 +45,13 @@ enum amdgpu_int_thermal_type {
 	THERMAL_TYPE_KV,
 };
 
+enum amdgpu_runpm_mode {
+	AMDGPU_RUNPM_NONE,
+	AMDGPU_RUNPM_PX,
+	AMDGPU_RUNPM_BOCO,
+	AMDGPU_RUNPM_BACO,
+};
+
 struct amdgpu_ps {
 	u32 caps; /* vbios flags */
 	u32 class; /* vbios flags */
@@ -355,6 +362,8 @@ struct amdgpu_pm {
 	struct amdgpu_ctx       *stable_pstate_ctx;
 
 	struct config_table_setting config_table;
+	/* runtime mode */
+	enum amdgpu_runpm_mode rpm_mode;
 };
 
 int amdgpu_dpm_read_sensor(struct amdgpu_device *adev, enum amd_pp_sensors sensor,
-- 
2.17.1

