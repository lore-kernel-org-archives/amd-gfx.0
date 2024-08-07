Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1D60C49EA1
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Aug 2024 01:21:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7C07910E0B6;
	Wed,  7 Aug 2024 01:21:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="h2Ppv5mI";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2043.outbound.protection.outlook.com [40.107.101.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1887110E0B6
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Aug 2024 01:21:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ePeOniQEu50qhqTJOh0IONdovca7ycW0fxPxhgVs4KbBa2Ltx4hZAH8qtoy0SrtqZvPd0pOwFB+gQh7x38OZVW8IFE0svaynaDeSqrhjeTVMw9ON2Ud+BIfAYQvfKciSxGoLtqJBbXwzJz7KozfUbYwvagQ1lhOWfewr/gFq+Uon6BxpdOzzZxjVypVt0Y+SiPWwq2VIgvh8F477mKKzobMRJj7aYgQJ8sS9vwLasTKoAlclkX1uHYSLmT5tPy04nBRLUS9S7OKw5WGo544oCVOCePVJy1ulu5vVe1VEqGqvaamqK3omYN/WmYOeJ1BajgrQWe5P5mnhaq4LIRqCdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n4FsuuHnRCwvuxOcYczac32MsYyH19zueAxCCLULEl8=;
 b=qBD72gdJHZT0/FAqQYnCgsB1byvdwVGQxCnkfvzzk7bErEZJwfSrBaOyYmANWVhTpgXxAQT6JAUeAmvz6YNJRBN5vfZrBeLh4ad94L1SsDdjzQvQdBtpZZ7M7cLtTf1we1A/Qo2nHoI2s8pLK3PnNrmZ/ES9VqC9ci1HZMKNM+20UfsObLTudZ6NU3Kj19xNsSXD4e3oFIIfigblgmPZ74osjMJxyG+yGf9vOqnF0xBm7KLoZyEFLQIZAP4bmwF03kDzRA8CXPFghvjg81x29TPIjy/liJk48C+3VgXjuDNB3pbUcnEieN/fkU5TK0deH+WJPca5BV6TWnCd/ImLmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n4FsuuHnRCwvuxOcYczac32MsYyH19zueAxCCLULEl8=;
 b=h2Ppv5mIy99EVVC+/kcagb+w5tBbxzWU5+YJfaPdLs/FdsL3iJY8us6gl1pB/D4EFiKih9NiKAJkNIy21iEUKYsXUwTkLd4ujrBroLKIOuH0UGKqtrahhLqPy4wyDW4nECh2uKQNPh0ZYjgqJCDWQnfjt5UT3jHYmImWtYO7ts4=
Received: from PH7PR03CA0010.namprd03.prod.outlook.com (2603:10b6:510:339::27)
 by DS0PR12MB8501.namprd12.prod.outlook.com (2603:10b6:8:15d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.27; Wed, 7 Aug
 2024 01:21:37 +0000
Received: from SN1PEPF0002529E.namprd05.prod.outlook.com
 (2603:10b6:510:339:cafe::8e) by PH7PR03CA0010.outlook.office365.com
 (2603:10b6:510:339::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.28 via Frontend
 Transport; Wed, 7 Aug 2024 01:21:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002529E.mail.protection.outlook.com (10.167.242.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7828.19 via Frontend Transport; Wed, 7 Aug 2024 01:21:36 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 6 Aug 2024 20:21:12 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, Roman Li
 <roman.li@amd.com>, Alex Hung <alex.hung@amd.com>, Harry Wentland
 <harry.wentland@amd.com>
Subject: [PATCH v2 1/2] drm/amd/display: Add null check for 'afb' in
 amdgpu_dm_update_cursor (v2)
Date: Wed, 7 Aug 2024 06:50:56 +0530
Message-ID: <20240807012057.1192380-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529E:EE_|DS0PR12MB8501:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b7feee0-4394-41a8-409a-08dcb67f481f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?uZaZsrdbMxyO4PAjPvPAvHY9cpkozDEQC3GHk/a0yEtm7xAFlJIU7Dt62LhU?=
 =?us-ascii?Q?dvYU7lqxN0wLZga9185L6B1JJgRa/Da28jF54sqIvTZHscB4kxNkpeIYCnaE?=
 =?us-ascii?Q?UOjYWPG3WEIBCGGI7jxI/EvIQa7ltQ35QnXIRT4NgbMLkQs1PpgpgJbtB2kj?=
 =?us-ascii?Q?Xjl5JVJmUekKduf8BE+aEefX0hkNPv5RllYMImAxIrn2/rFYYZUUG/F2bUjs?=
 =?us-ascii?Q?HeXlVgTIxU3uU7OhYERsQo9vUm1oeKZ9Y1AZmXgMI2iuYb66JCDgu0lqG3ZL?=
 =?us-ascii?Q?/mogCUDYb+RRXfyzyYT3WRXaWCARexZBnMAKkI0AYfn7PAY7bsiLAsOM4ADg?=
 =?us-ascii?Q?K7ShuFeVx8l5pZYyhBlb9D4RZP4Al2DN7nPe2oWB+m0oOj+jfA5GaL1F3H0/?=
 =?us-ascii?Q?ghl6jkh8n2stEozdDWrT+1YdG5zscRQqb2sM6tdtiXpJjtC8+M4ucs4wgVoz?=
 =?us-ascii?Q?KAIqU6t8vlhBlmQy87y9v6PTPn8dyHeuw08Wo+netaz3ewm5mWcSdH8F9Z8d?=
 =?us-ascii?Q?e+XKjT5xznq7ZnGuSd98dDZvhFq4wJRFza+7HhU7hXfYSvckRtJww9rVR5XP?=
 =?us-ascii?Q?NsqRAAsi8yHEJqezu2S77VYszZV3i5QizH2Qh8vK82IeLv2cLlHX+BHxTQn0?=
 =?us-ascii?Q?DKzf44YiUH8nh1Rk6O97ue2XDo8v6I/WcYAFO0lnO54SvfqtUG+K3aCP3YGL?=
 =?us-ascii?Q?LPhztQQk4gOpA39AI8c3gdfzALMtsNNF75/T8QBZpNpd+elBEw48rmfLy4rB?=
 =?us-ascii?Q?0Ri6KLvud2UJBL4JH5NIhg4qOq2SjoP9/6fAd9lnZdMWXQqI+EKaQsDEz2VE?=
 =?us-ascii?Q?IyXqme98Q/hoSOOoKoHiHPb/U3TzPAEDBjbkS1ccDg2wbh6p5HIiGRUYDTLX?=
 =?us-ascii?Q?9xTxRdwo5762i+umowQhh6TQszkz2l0XsDx/Ez/i3F+0BGxn8Mg0rTdh+q5p?=
 =?us-ascii?Q?fX/agzj5eL57mRjAXByKbKGw9A0zFLkoFvq+zOZTz51yscyec5ynANLaX4yO?=
 =?us-ascii?Q?5uCHwYUjjF0YdbgMm3oVMaZ71z+xqRlfPnmPu9RCwtx/ksYDfxN4WxF7IPzE?=
 =?us-ascii?Q?GBopM5jUPYFNd7XwXGCyTFElfl5Qot+2VZEwmmd64UyA9WGriDptQK0kH8h2?=
 =?us-ascii?Q?DzbJh4oRbqfLTmH/srISO9UOjKOm+jwDs0s/01F1kn/PcyWT91/iaYk7TXXw?=
 =?us-ascii?Q?tm9XAdPSjewEDySfmjdkMdR6RABx0cRnqLu7bUsM9MB1y/hziZH1/bZ6j9hr?=
 =?us-ascii?Q?MwjM3LMtjmFVasw9rm43VorJ/+nEROlCtUeDZnNo6QnB+l8V2y8eXefJilWe?=
 =?us-ascii?Q?wKD5wiaDgizMHXoFyjX+0+UM8uGLh2DNZAQoOJb5PMbNGvI66vaGln4oMX4r?=
 =?us-ascii?Q?Oaljeif0pC26K0o3PLh5XUqHGlKVsfKaoC2KuWvVcVuRD2GLZUGPBbtfSkNF?=
 =?us-ascii?Q?7X2heyQdzrSR4lrwYswj+aiB74J4O1bE?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2024 01:21:36.6096 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b7feee0-4394-41a8-409a-08dcb67f481f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002529E.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8501
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

This commit adds a null check for the 'afb' variable in the
amdgpu_dm_update_cursor function. Previously, 'afb' was assumed to be
null at line 8388, but was used later in the code without a null check.
This could potentially lead to a null pointer dereference.

Changes since v1:
- Moved the null check for 'afb' to the line where 'afb' is used. (Alex)

Fixes the below:
drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:8433 amdgpu_dm_update_cursor()
	error: we previously assumed 'afb' could be null (see line 8388)

Cc: Tom Chung <chiahsuan.chung@amd.com>
Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Cc: Roman Li <roman.li@amd.com>
Cc: Alex Hung <alex.hung@amd.com>
Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc: Harry Wentland <harry.wentland@amd.com>
Co-developed-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 293f93d1976c..0fe043df643d 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -8697,7 +8697,8 @@ static void amdgpu_dm_update_cursor(struct drm_plane *plane,
 	    adev->dm.dc->caps.color.dpp.gamma_corr)
 		attributes.attribute_flags.bits.ENABLE_CURSOR_DEGAMMA = 1;
 
-	attributes.pitch = afb->base.pitches[0] / afb->base.format->cpp[0];
+	if (afb)
+		attributes.pitch = afb->base.pitches[0] / afb->base.format->cpp[0];
 
 	if (crtc_state->stream) {
 		if (!dc_stream_set_cursor_attributes(crtc_state->stream,
-- 
2.34.1

