Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2A95C77B7A
	for <amd-gfx@archiver.kernel.org>; Thu, 18 May 2023 16:48:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 60FC410E0F3;
	Thu, 18 May 2023 16:48:33 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on20611.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5a::611])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3175510E0F3
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 May 2023 16:48:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DJ39ff1x6h1dDxJOp43Abfjo1IT3PshSvmWEfTAURWoFvsOgVweTUL8vgXCKbUrTDczMYg8usXQbecwILQY43VHrfBM7e4lGVVcQRUygvZ9+G9IhEjPWELGyqR1fLDSFsWEeWfLTQwRf1R/7DdP7JZLeuyxKF298zALjnKntj4RhXVJUMFYfUZf+7+eLaul12Unj6wQKTAtS/4mneBsx0LUJjiGJeDx8mOWu6sRz6M4G67rTQjO9G8KkMCinNqI5z2CktzkgiAa8Ec385wKgEIQK7daxpuA+7VLMwTtuEicurAJSnbp4oMo9Wu0zTe1uelDuXz17zahD5aU2LQm2Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kq8DoigZ2CpW2O3uiDLgXrga5hQqLQeOlzwd4ZSZXOc=;
 b=WoLUqoxE+lSOInw16wB+liVq6ZwdqjVZiTcmhNnFSskN585RR6m37fm5Z7CrBmPyyYm14c0pSAS/9qGHB0ald7Q3NIqLQ+XeiDl84AUj60/f16txvNIbn8GeNQActB5DSR45I+Nc9u36p8wUZbQeNMdoIrNQnFop1iGbi6cwVbwKrAW618AvQrTGHEe+5ls7nVi3+VXc2AhKbZ/jd/xeHrmR2ZxVLnfKCvu937E8e/zrMgDcegn/GRTTbUqN9ja13ZPUOAKIngrGGL/RD5XmmXk6ng9XY+DK+Gzdh7v7ha89ifWuomzfyYrPLZ/Trlyqv2sP09lPsQ+/eCnO34sh0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kq8DoigZ2CpW2O3uiDLgXrga5hQqLQeOlzwd4ZSZXOc=;
 b=UTD1yPonKE862neK7gvl2oKMK5hq+S4MDjf63ac9JGxqrmWl54YftFVvp3rJcF7FJbstTITPH76TqaNqc1YA+xZoXer5FpX0aH4bdXmgxsQuOWwCikIAmdgxrdIqNwW+GPbTjUW64Cs8kpp+Vw3Ef1d8rv4/2cnT/JmZqBEgDwc=
Received: from BN0PR04CA0009.namprd04.prod.outlook.com (2603:10b6:408:ee::14)
 by SA1PR12MB8117.namprd12.prod.outlook.com (2603:10b6:806:334::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.19; Thu, 18 May
 2023 16:48:26 +0000
Received: from BN8NAM11FT067.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ee:cafe::3a) by BN0PR04CA0009.outlook.office365.com
 (2603:10b6:408:ee::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.19 via Frontend
 Transport; Thu, 18 May 2023 16:48:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT067.mail.protection.outlook.com (10.13.177.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6411.19 via Frontend Transport; Thu, 18 May 2023 16:48:26 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 18 May
 2023 11:48:25 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/radeon: reintroduce radeon_dp_work_func content
Date: Thu, 18 May 2023 12:48:11 -0400
Message-ID: <20230518164811.1956522-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT067:EE_|SA1PR12MB8117:EE_
X-MS-Office365-Filtering-Correlation-Id: 6eb10abd-ed3b-48b5-1ff1-08db57bfb345
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FfyGv1CtNhIraFqoosFpbCnF6zdhIXtBLpNjCyci/ILeZxIljnWLfsLI+nE/gfLxrLGIck4W2gTIfkJE8gn1i4+T86D+awjnfofFRbIYc6Ii9KGg/uiGcGUsDok5gfoXnXqph5f/WKpV213d+qVRDv+j0FsddArTj4obUYhzjJfucNNOqpVKN9dstYsyiIAMQr3Ax5kKsjmmrdGzD3Yq0MtPsVj2cJmrYxoJeGK4cXYtLFAqn823iY+4s4Q0CS0pp+9iFTp9xb1cglXMLZTCYWS5GDOheGW8cI7wslxufweEv6YQQw79T40U0vwA4hkPqpIuIv3iK2GTciZNT9S5Mg+Fy/t25v183Feq6s0UtmkOQTZn+muD8kD0QYA9HF9o26okMwFVhppLup8yjMzgFloDHiVgrgbUcQD5fNIBrm4JLeTts3VtDhTJt2tONScs4eGByzHYVV1JvtXwvHN+2eJixCSHSdquGdj4M+QLFBQ6IdJ0+xeUkWeCmkWUWsgNHK8Ix18mhMSqkQdiqupg6F/d8pkab4tOgBleS7b99rmKxfuBs60QZ6Di+SypxwrdAdv5UzxI5oBDMQxrEXwqeyVRKr4NesYvlmZYQkM09w6BibB0UN8ocv1rmUI/36d3h39kHt5hvOacOCK+Re8t7XPvXlwR8hfAzBWulWy2j3MEaRFSovFMQBmnhWlYR3AgAcSR3plMR0/8+hJT6E2xO33TNnAv8PC6kqJeWjwf1dA=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(396003)(376002)(39860400002)(136003)(451199021)(46966006)(36840700001)(40470700004)(26005)(40460700003)(1076003)(7696005)(966005)(36756003)(36860700001)(2616005)(47076005)(83380400001)(336012)(40480700001)(426003)(86362001)(82310400005)(356005)(82740400003)(16526019)(186003)(81166007)(54906003)(478600001)(2906002)(316002)(4326008)(8676002)(6916009)(8936002)(41300700001)(5660300002)(70586007)(70206006)(6666004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2023 16:48:26.0610 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6eb10abd-ed3b-48b5-1ff1-08db57bfb345
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT067.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8117
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Put back the radeon_dp_work_func logic.  It seems that
handling DP RX interrupts is necessary to make some
panels work.  This was removed with the MST support,
but it regresses some systems so add it back.  While
we are here, add the proper mutex locking.

Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2567
Fixes: 01ad1d9c2888 ("drm/radeon: Drop legacy MST support")
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: Lyude Paul <lyude@redhat.com>
---
 drivers/gpu/drm/radeon/radeon_irq_kms.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/gpu/drm/radeon/radeon_irq_kms.c b/drivers/gpu/drm/radeon/radeon_irq_kms.c
index 3377fbc71f65..c4dda908666c 100644
--- a/drivers/gpu/drm/radeon/radeon_irq_kms.c
+++ b/drivers/gpu/drm/radeon/radeon_irq_kms.c
@@ -99,6 +99,16 @@ static void radeon_hotplug_work_func(struct work_struct *work)
 
 static void radeon_dp_work_func(struct work_struct *work)
 {
+	struct radeon_device *rdev = container_of(work, struct radeon_device,
+						  dp_work);
+	struct drm_device *dev = rdev->ddev;
+	struct drm_mode_config *mode_config = &dev->mode_config;
+	struct drm_connector *connector;
+
+	mutex_lock(&mode_config->mutex);
+	list_for_each_entry(connector, &mode_config->connector_list, head)
+		radeon_connector_hotplug(connector);
+	mutex_unlock(&mode_config->mutex);
 }
 
 /**
-- 
2.40.1

