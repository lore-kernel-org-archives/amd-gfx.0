Return-Path: <SRS0=UpsA=OS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16925C433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Sep 2021 16:45:15 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CFF2C61262
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Sep 2021 16:45:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org CFF2C61262
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 894826E8D3;
	Tue, 28 Sep 2021 16:45:14 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2089.outbound.protection.outlook.com [40.107.236.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A0D4C6E8D3
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Sep 2021 16:45:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WrvEsk/O9f3b2OFUK3lKDEOpCEP7dJFCOi8o6EqpcJzK8u7M5V+k1zU2BlVwzvuAGarQtdY5vH1el+jrZZMpyc1KdTPQAek0BUwf+ig65BfvX8fOrmiVPH8gP3uiWUO4jj5MP0YvnyuPyQhFtQNKASSqvyqzNeywqk7cMz9rA5Womp/m2raYJ1j61HnxTotMfIYp9Hzj/G26M1xVYlfq69Si1pRDrc0jHS4aN9x2agq5CyxXiCoiGfw4UmKkjWkVbBUlFyU/edguJDkYatLaR+sD9fAj8nDFdE+zKcKfqsYS1Yc8u5DpwTE2rfcffFS8Al5GceFfAk2vyoNA0akdAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=+WCxn5kkWTKF6rLuxfs5X0LlNLngTnJ3alAD+OcGoxM=;
 b=WfUCzqhnkUT54KXkzTF49zlJmvm5wzS9W/o0aU6foStMPZEyzWjd2ZaltpvexA10qgYL76qaBR6AqIXCbjaxZQw4+AWgbo8Qykig4BVawYiG2tms+CAU38LMKS2f+4YBE3MnXB7VxLDNJaUwssK7dvO5jkM9rjNdzQtuBdDgsC4yrjAxCs3HgZ8rSB2bddNp0By/Q5XFirpGLdx/3wUc+0leGtRnv+U9e8KqU1I2o8hukWhV7HpWGB9OWPoIfDStbT9AYEtyRsRXcVFMOJUwBoYDyOpJzd+bJ+mvY/0Ms/Ze5Ek+Sdz5Sh5wFjEr3fZVi1KG2jVrCw3lV1EOag+UIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+WCxn5kkWTKF6rLuxfs5X0LlNLngTnJ3alAD+OcGoxM=;
 b=BKJ62a49pM4jTyNQk2FWB9VNc6K2blpm7MRz/D0aaaGA8P4NdlfOOM1bjmvECQbf4P/O3l45cMZW6MFaA8gSENTf55zZxd7o+7sBjxZe6cCyHivqrGwCYBcT+6EgG7i26bvF+dUVuuWUHy0V+MmiKNobZ7eeEkz1YWSO4AQFpgM=
Received: from DM5PR22CA0018.namprd22.prod.outlook.com (2603:10b6:3:101::28)
 by MWHPR1201MB0192.namprd12.prod.outlook.com (2603:10b6:301:5a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13; Tue, 28 Sep
 2021 16:45:11 +0000
Received: from DM6NAM11FT021.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:101:cafe::46) by DM5PR22CA0018.outlook.office365.com
 (2603:10b6:3:101::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.14 via Frontend
 Transport; Tue, 28 Sep 2021 16:45:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT021.mail.protection.outlook.com (10.13.173.76) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4544.13 via Frontend Transport; Tue, 28 Sep 2021 16:45:11 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Tue, 28 Sep
 2021 11:45:06 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Subject: [PATCH 36/64] drm/amdgpu/display/dm: convert RAVEN to IP version
 checking
Date: Tue, 28 Sep 2021 12:42:09 -0400
Message-ID: <20210928164237.833132-37-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210928164237.833132-1-alexander.deucher@amd.com>
References: <20210928164237.833132-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 577515e0-2cd6-4741-b9a2-08d9829f5677
X-MS-TrafficTypeDiagnostic: MWHPR1201MB0192:
X-Microsoft-Antispam-PRVS: <MWHPR1201MB0192CF709FF9A1CA0F6481EFF7A89@MWHPR1201MB0192.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:323;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: R0KK7zdRjBtmHtquk/Xr3jtyJWpq5ZsN3I509nOT2LjfqOs2vdVsBy0tiAAl3lrtvAh6n9Zn/1+pa4W6Q0p5/cCoDpdk5e/b4Qh/tY+S/ST/q8B85VduSjX9Afn8MwjukZIbwiSbR39bMc37utZCmaybTZHwKiPpjJegdaHUDceDC5EvqVIqJMIpl+BhUiTI0v1OpELta5YUrY7GzVYP5zTOGQniuCM3QNvXb6elwM7QpEovpkOSifPwF+7DEfqHskIPXtMzxhuw3XAdJKT1Yiqx/iUGxezwgOy5goZbyAboGGqhwXk8JJGc36BgmigavHOi7k2CBvIGrBcaqRnRHvMxgh2LS3zLIE5bc7gWQzw+zdDUpFtKElx65EC0ZteNWU/6hCzWzoDBbjvdxx4GpdMawKHc6oEuH+WTG3a8vC5O6gof0/cECbG/gm+QyNM6txhpoBHMUp1h3CVcnXtvOstGTJtceh5Fkqf73DqxnH9Nt26mSkjkUsoSUWqduArUmahOZDoDyMA52tFzVjbZff+H1ECJakoFgT3gl25HX7RVjy56ETMY1W4oxEhqAMtXrNsWm2uZZm3TRThIbL1nBkeqe0KNDtQr5euuwShoDexlDx2IBahypXO0qJ9ueTuC32+wQIcjJqto29/Htg7Bb/349fYDybHpwybbqL1BnM+RnhKNxPLqODmTLpNG2ucdfknfUEf1Zx1RDhuVrmosiN+uaL6eqZAXvzj3sbxftKE=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(6916009)(2616005)(356005)(1076003)(316002)(4326008)(508600001)(7696005)(2906002)(426003)(8676002)(82310400003)(83380400001)(81166007)(5660300002)(54906003)(70206006)(336012)(26005)(86362001)(8936002)(186003)(36756003)(36860700001)(47076005)(16526019)(70586007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2021 16:45:11.0944 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 577515e0-2cd6-4741-b9a2-08d9829f5677
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT021.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0192
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

Use IP versions rather than asic_type to differentiate
IP version specific features.

Acked-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 22 +++++--------------
 1 file changed, 6 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 2c4c5905fdcd..4cada9df5f9e 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -1342,7 +1342,6 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
 	switch (adev->asic_type) {
 	case CHIP_CARRIZO:
 	case CHIP_STONEY:
-	case CHIP_RAVEN:
 		init_data.flags.gpu_vm_support = true;
 		break;
 	default:
@@ -1352,6 +1351,8 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
 			if (ASICREV_IS_GREEN_SARDINE(adev->external_rev_id))
 				init_data.flags.disable_dmcu = true;
 			break;
+		case IP_VERSION(1, 0, 0):
+		case IP_VERSION(1, 0, 1):
 		case IP_VERSION(3, 0, 1):
 		case IP_VERSION(3, 1, 2):
 		case IP_VERSION(3, 1, 3):
@@ -4185,17 +4186,11 @@ static int amdgpu_dm_initialize_drm_device(struct amdgpu_device *adev)
 			goto fail;
 		}
 		break;
-#if defined(CONFIG_DRM_AMD_DC_DCN)
-	case CHIP_RAVEN:
-		if (dcn10_register_irq_handlers(dm->adev)) {
-			DRM_ERROR("DM: Failed to initialize IRQ\n");
-			goto fail;
-		}
-		break;
-#endif
 	default:
 #if defined(CONFIG_DRM_AMD_DC_DCN)
 		switch (adev->ip_versions[DCE_HWIP]) {
+		case IP_VERSION(1, 0, 0):
+		case IP_VERSION(1, 0, 1):
 		case IP_VERSION(2, 0, 2):
 		case IP_VERSION(2, 0, 0):
 		case IP_VERSION(2, 1, 0):
@@ -4362,13 +4357,6 @@ static int dm_early_init(void *handle)
 		adev->mode_info.num_hpd = 6;
 		adev->mode_info.num_dig = 6;
 		break;
-#if defined(CONFIG_DRM_AMD_DC_DCN)
-	case CHIP_RAVEN:
-		adev->mode_info.num_crtc = 4;
-		adev->mode_info.num_hpd = 4;
-		adev->mode_info.num_dig = 4;
-		break;
-#endif
 	default:
 #if defined(CONFIG_DRM_AMD_DC_DCN)
 		switch (adev->ip_versions[DCE_HWIP]) {
@@ -4389,6 +4377,8 @@ static int dm_early_init(void *handle)
 			adev->mode_info.num_hpd = 2;
 			adev->mode_info.num_dig = 2;
 			break;
+		case IP_VERSION(1, 0, 0):
+		case IP_VERSION(1, 0, 1):
 		case IP_VERSION(3, 0, 1):
 		case IP_VERSION(2, 1, 0):
 		case IP_VERSION(3, 1, 2):
-- 
2.31.1

