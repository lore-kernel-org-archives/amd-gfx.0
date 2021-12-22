Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB689C433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Dec 2021 22:05:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5B5AD10E339;
	Wed, 22 Dec 2021 22:05:52 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2072.outbound.protection.outlook.com [40.107.237.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CDBB810E339
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Dec 2021 22:05:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TfYyEekxtO6bHIfG5oFjpK96Rj+zF0yRMZoBpBHnJgiCJy6fh4XM/VMNbAUxi/ECbjF2psQGE8mwVOmU9I54xfDTNXMmQ803+5GZuy8JVM7A2ymb4awE1VxoGIiAo36gkZs6K7q7ycnbE1ApzIbDS5T31AgrilZT0KbkDdmuzSN38OSKrKSzpNbvn0p3VWR2ST6sIUdjnaiN2D6ZG4Wby9VCB2TLQJ0YP/FTGfAehms7joUE1ZZFms684BynoyeGmu3usyTnVi8IQamxlRD1S5Ed8XzKwJsevzVdXeOiZijXngnFuIKkcGsVezNT9m/O1jDRBIx5kGhIz+zY07tGfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D3w4w+ESfqXV4XoMfhav5Z1N+hMsALJpFLK5faPLDqY=;
 b=HH3fjZYreTjOf8gMCo18BNmrupRVX0iDFey+5zzi/2U5zX5FLdsIfombFfs1ZyDyPYxSF0qr5lPHQ0AKcp9ElRabt53Jv0TYnJxD7FnxM54NgOXYKGBqvynqeqfNHevMW84SZuEk1bsE8IQ9ZFU5+BIthj1LVBGWHp7XBYzVJ5OhOJAxOb2iszKgh8/UR5fsS/kK8AQqvo+vX83ORj4pYgLZwvraWIaDpdr86QygpLqULqfC5SlOPE7/cQYIFFIeeej13jabnyDb+JyV+YF2o0WZUVVLWjZm9PibSFVoqyzd8ciA8u45rSGzHsn0hz9nl4aKeTI0JjZj0NX0S4pnVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D3w4w+ESfqXV4XoMfhav5Z1N+hMsALJpFLK5faPLDqY=;
 b=u30Gf3O2yEU6EpfIuvW8BF/3NoknyTVgvUTcGDKZu5eGvq7JRiZsoyiHPdazGtNbMar0dW/DKxPTuBGkr011vPzHWa5H9wxKYUykUHCIiS9dqavUyMZmJBZXsC2qd7xsg4A6FMxk3qnoctmcSbhyUN3yopTqqX1DUYJnqtwt2ho=
Received: from MWHPR13CA0002.namprd13.prod.outlook.com (2603:10b6:300:16::12)
 by BY5PR12MB3665.namprd12.prod.outlook.com (2603:10b6:a03:1a6::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.14; Wed, 22 Dec
 2021 22:05:47 +0000
Received: from CO1NAM11FT036.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:16:cafe::7f) by MWHPR13CA0002.outlook.office365.com
 (2603:10b6:300:16::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4823.8 via Frontend
 Transport; Wed, 22 Dec 2021 22:05:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT036.mail.protection.outlook.com (10.13.174.124) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4823.18 via Frontend Transport; Wed, 22 Dec 2021 22:05:47 +0000
Received: from atma2.hitronhub.home (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Wed, 22 Dec
 2021 16:05:45 -0600
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/6] drm/amd/display: Don't reinitialize DMCUB on s0ix resume
Date: Wed, 22 Dec 2021 17:05:16 -0500
Message-ID: <20211222220519.1682537-4-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211222220519.1682537-1-Rodrigo.Siqueira@amd.com>
References: <20211222220519.1682537-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 78b85187-ae0a-493d-e820-08d9c5973564
X-MS-TrafficTypeDiagnostic: BY5PR12MB3665:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB3665C053D35D59984035AE5F987D9@BY5PR12MB3665.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jbATcOF48c8fZbFfefk7BT5eQblaLlhxzMwEaaBw6+U2J6hL8fxlVp33n8T9DniIQ7y+uhMbeUYLkndGP77V7sSvjzM1Xnb6v9eURt/sIjHOO7qPlqfgC9IfTp5PfJyhU5blSoQiqddn5GDXd/JKRg+3/Crola3kSHUd2EG19nABdtGU6roTVoLkdq1QNgJ2pcbZszfu08FHSsm5RGLtlBOPUPoO1qshg3+laosXbFf946cjK0zzNNOn/KTjqz1oNnROof/6aFwFOYvg9VLoFypd69iJz0j7WCHJ9pa1EJ/i2D1NNzmVuAKWH3ImZwahC98xG1fOpptw6ghnee6BECdGi1oo8fA6njVA87maNe00mQsg5boA0MnDwU1eqN2nCCs3MDzNokdNdlxlWbHCGFAixwLQorV+MWHcj1ZaEvntzIKaUdm8TfLzPKlAMvjNXZLRjUdRkBITtXpVJnky92upx8wbvqGtZnYrP8FvmA+H5+ADdwq8zMzd91GcAQuJRvbfl/sH9M2/MfgXBm5px4nARDmzm4vyNbJOlXZLEWyNDXWdm1EOUzLbp4zNhTtyZ0DKMjSwbaPUoeQO7mceVijVxaUs9XrxO93amMRgKcBkXZKJkVEKF4T76aWSJ5XhleY/dlLkhPEbUQXxtaaOs/KgFRZmBn3enT5dm5nGE49pygfkhAKtF/v5G4nyJPv9RZPOWJPlAbaOSIkYN+eyt1xWQmK2z4tMxmi1VkL3yS+pSs5W5FhxHYhzaQp7gAk2yUXE+5yiX9eqQlrAMQcE/9wGB0rPEtrl/WfvYLZnLb4mTU0crc/pp9OM57MjtLxply5fzqiD15JSQxMxG72wlA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(40470700002)(36840700001)(316002)(186003)(5660300002)(8936002)(1076003)(81166007)(6666004)(336012)(4326008)(8676002)(54906003)(508600001)(16526019)(83380400001)(86362001)(426003)(2616005)(26005)(36860700001)(2906002)(47076005)(40460700001)(356005)(6916009)(82310400004)(70206006)(70586007)(36756003)(32563001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Dec 2021 22:05:47.4612 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 78b85187-ae0a-493d-e820-08d9c5973564
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT036.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3665
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
Cc: stylon.wang@amd.com, solomon.chiu@amd.com, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com,
 wayne.lin@amd.com, Mikita Lipski <Mikita.Lipski@amd.com>,
 Bhawanpreet.Lakha@amd.com, Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

[Why]
PSP will suspend and resume DMCUB. Driver should just wait for DMCUB to
finish the auto load before continuining instead of placing it into
reset, wiping its firmware state and reinitializing.

If we don't let DMCUB fully finish initializing for S0ix then some state
will be lost and screen corruption can occur due to incorrect address
translation.

[How]
Use dmub_srv callbacks to determine in DMCUB is running and wait for
auto-load to complete before continuining.

In S0ix DMCUB will be running and DAL fw so initialize will skip.

In S3 DMCUB will not be running and we will do a full hardware init.

In S3 DMCUB will be running but will not be DAL fw so we will also do
a full hardware init.

Reviewed-by: Mikita Lipski <Mikita.Lipski@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 30 +++++++++++++++++--
 1 file changed, 27 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index bfeb84d2d1a0..2432b0c0be69 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -1161,6 +1161,32 @@ static int dm_dmub_hw_init(struct amdgpu_device *adev)
 	return 0;
 }
 
+static void dm_dmub_hw_resume(struct amdgpu_device *adev)
+{
+	struct dmub_srv *dmub_srv = adev->dm.dmub_srv;
+	enum dmub_status status;
+	bool init;
+
+	if (!dmub_srv) {
+		/* DMUB isn't supported on the ASIC. */
+		return;
+	}
+
+	status = dmub_srv_is_hw_init(dmub_srv, &init);
+	if (status != DMUB_STATUS_OK)
+		DRM_WARN("DMUB hardware init check failed: %d\n", status);
+
+	if (status == DMUB_STATUS_OK && init) {
+		/* Wait for firmware load to finish. */
+		status = dmub_srv_wait_for_auto_load(dmub_srv, 100000);
+		if (status != DMUB_STATUS_OK)
+			DRM_WARN("Wait for DMUB auto-load failed: %d\n", status);
+	} else {
+		/* Perform the full hardware initialization. */
+		dm_dmub_hw_init(adev);
+	}
+}
+
 #if defined(CONFIG_DRM_AMD_DC_DCN)
 static void mmhub_read_system_context(struct amdgpu_device *adev, struct dc_phy_addr_space_config *pa_config)
 {
@@ -2637,9 +2663,7 @@ static int dm_resume(void *handle)
 		amdgpu_dm_outbox_init(adev);
 
 	/* Before powering on DC we need to re-initialize DMUB. */
-	r = dm_dmub_hw_init(adev);
-	if (r)
-		DRM_ERROR("DMUB interface failed to initialize: status=%d\n", r);
+	dm_dmub_hw_resume(adev);
 
 	/* power on hardware */
 	dc_set_power_state(dm->dc, DC_ACPI_CM_POWER_STATE_D0);
-- 
2.25.1

