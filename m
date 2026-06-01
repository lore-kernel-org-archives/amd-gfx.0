Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE0ACCD5BD1
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2026 20:30:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 74D5D10E255;
	Mon,  1 Jun 2026 20:30:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pZy8NwYX";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010048.outbound.protection.outlook.com [52.101.56.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D514B10E958
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Jun 2026 20:30:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vRfSVxt6goOYgfr6Bn1FHwWhd42BX94S+6DLsUNuJE6ximIxTYZFkYl8tZ4m8ngKWDozAEWlJDC98wL99kuCQxxerHmQlrp4c8lgI4pY+z5d00ZRpGRf0fCKgMqNoz3YU/wv+5yJwJPi9rKnwt34SMZkly02lZDbfJvvssKg3Yj3riozNS3KUsz1vDn26ot/xVi2AzvluvEQiZSkESlcV5/tTuF4d6gs6hQKIG/GfG22zR/GHM8oFB61XVcIXwYip/N5QwFW2tsADlUX+7N6cKaC9CyqeYydLG1xp0tkrKadVW99aSqbVGNleG5V3MILVxX3upL99d1CD0mHuaI3Iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hJwra7L2lDr6VPMyTJW4QhIbafPoX9ywSdh30Iqk8WQ=;
 b=Hh3xw6jmWumVDmhEPXMGLDRMyjvsf0P6054bHaVhbGgha7klh9M49u23P0wD5Jo2DF/i8vIveXbZ4YNn6rPbwkdrYZO8oeDbyHxNRDxJ9lGa8grXptOdsyDt2qb4hjG1ev32WqNbshAntgVAxYr4XVu4zjF3mt3bXuqxiTK2qSdim3Vew4sDfkL8WQ9n2XC4Gfw011GqnPZnPf6WbzvNNta5mlkTcP7JLSax82Yk7leiYQ0gztpsVN2WmedeVk0dGW2b76OvIIm5oJGGGION57TwJOeCbiv6lsQeEkQS8Dd9LdwQeJTFd0Ael59MqiNOyQRqHlveivql3XZqs+W4dQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hJwra7L2lDr6VPMyTJW4QhIbafPoX9ywSdh30Iqk8WQ=;
 b=pZy8NwYXWbWTxP5UIOq6Szeznn8amew4OKA8T1j7sA3stKIWurA/621D3ZGyYPWxxVOMxY1B5l9qvtlyhWYEsPNIDrJ7qIDsRisev0Ecc41EX1xBYU2MDlGo6T4T5hOmTkq+GCSWq/zkzc2Obvl/MqJmqtvBhXT771fTuNh91dU=
Received: from PH8PR22CA0012.namprd22.prod.outlook.com (2603:10b6:510:2d1::8)
 by BY5PR12MB4321.namprd12.prod.outlook.com (2603:10b6:a03:204::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.17; Mon, 1 Jun 2026
 20:30:50 +0000
Received: from CY4PEPF0000EDD3.namprd03.prod.outlook.com
 (2603:10b6:510:2d1:cafe::d) by PH8PR22CA0012.outlook.office365.com
 (2603:10b6:510:2d1::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.16 via Frontend Transport; Mon, 1
 Jun 2026 20:30:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EDD3.mail.protection.outlook.com (10.167.241.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Mon, 1 Jun 2026 20:30:49 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 1 Jun
 2026 15:30:49 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 1 Jun
 2026 15:30:49 -0500
Received: from box-0.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Mon, 1 Jun 2026 15:30:48 -0500
From: <IVAN.LIPSKI@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Alex Hung <alex.hung@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Fangzhi Zuo <Jerry.Zuo@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>, Ivan Lipski <ivan.lipski@amd.com>
Subject: [PATCH] drm/amd/display: Rename hdmi_frl_borrow_mode
Date: Mon, 1 Jun 2026 16:30:41 -0400
Message-ID: <20260601203041.3557768-1-IVAN.LIPSKI@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD3:EE_|BY5PR12MB4321:EE_
X-MS-Office365-Filtering-Correlation-Id: 67dc8da5-2164-44f6-fa98-08dec01cab3e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|1800799024|376014|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: 5PXVbs5dm52FfWCyDwA7DFCZz6gDz1OSMkY2xMhPR4duTt4DlSEWUkklUmY02P0+s/VhKh2tnm2Uvvg5O9Ux+0FBYHKnRtRIctibELYHYC4niQ9qizr1uvsusLnXRw3dhYqUJePn+ixokJZJ+FMNi/ZUNe2VQxNbiA3AZ0q/VXitUxAWqdE4BVmfxkEHVHFF4MTpU54DwGxJx9jy737P4KQqsDvCxc00BO3L1plmSPiKfz6cxPpvDVxpUwdzNMWFwluv0ul23EPiweG/d3G8maDcN82raaiaqBv549bRM9xlSOFGg1GHr7/HHNHQ44wTJp0aYahmsohHYJmsE+qvXvj0G5rZtpWn5YeX5Q2ssUYLJefpBL3YL1vPNBDSuoQbdRQjCSBYd2wBRJ7qwQO+ziOfQxM4crIccbAZRyTnq2N9XAIyNd+rvcXdTImbidFD3f/8Pi+2eKMfMoYd/raFKY9Fkr7CBFYmOllILgoenr7EBG9a/+2jbIED+NgerHh1UcM7m3NTegTsd8PuJdAqdUME+L/A0F3L4jw9oO6Lh6UhQ/QgudMhWeTfYdB/SHDGc02TqiglgS/y95rwyQs/horHoU6jK37LX8xF6W46k63Y9djQdtwUlKzcf0CyurIRLWJl3zib6XIHwkUQ9DYTPTSOHZ4RbAn1Y7zu8OXFNTsQXIM9KzsIsOR92HJhMvzLcNIF5nDNybVDvzcTqMxpSIO+qZR7h/yUVXoqjJKOz0Q=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(1800799024)(376014)(18002099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: hdHg8Lyw/8YcT1kcK9OCRUD0jW88YjJzV16zhEW3KpW6s3UEhHC5sLUuh4DQKGLqPuxDtHQNar9AWTXk5PBS2GkFdeP0YEQ9nvXZ/bewf4Xo0iW3r49jOHI8rN8ckxapCMsjLafWJANP2CXoG86pYw2V0gIA5JvNd6bUpcTLcPymg8GDaUbHCXHwW9uj8qr8HHR7fNPmvKzsog0KViIfwiBH0UudJKQ62Co2ujoezU6obPNVH4OaG8F82JhcQ6EnFO4Dn2zoTRr9knpH0kjfAkSOCmhn/LdPXPBVCgoEMP8QhQXC4n8nd2LkjOaDSbh7u1kU1Y9Qyu5SIATpHRd5Ca2yVHrNXAcIqcyNlM/Ib7qVNG4up9gHWKi5Tln6MyndmnakAO9MNZOTtvT0SIC2zipuA941hUdPTaFhk7Y0YUwiFjG8I2vl9LcRT5gV+vLI
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2026 20:30:49.6953 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 67dc8da5-2164-44f6-fa98-08dec01cab3e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4321
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

From: Ivan Lipski <ivan.lipski@amd.com>

[Why&How]
Remame enum hdmi_frl_borrow_mode to HDMI_FRL_BORROW_MODE_* since the same
enum is already defined and used by dml2.

This resolves DKMS compilation fail.

Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc_hdmi_types.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc_hdmi_types.h b/drivers/gpu/drm/amd/display/dc/dc_hdmi_types.h
index 5923a5f112a9..0da03eb794aa 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_hdmi_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_hdmi_types.h
@@ -225,9 +225,9 @@ union hdmi_scdc_test_config_Data {
 };
 
 enum hdmi_frl_borrow_mode {
-	BORROW_MODE_NONE,
-	BORROW_MODE_FROM_ACTIVE,
-	BORROW_MODE_FROM_BLANK
+	HDMI_FRL_BORROW_MODE_NONE,
+	HDMI_FRL_BORROW_MODE_FROM_ACTIVE,
+	HDMI_FRL_BORROW_MODE_FROM_BLANK
 };
 
 enum link_result {
-- 
2.43.0

