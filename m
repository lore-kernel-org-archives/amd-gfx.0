Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AF0BC4167B
	for <amd-gfx@archiver.kernel.org>; Fri,  1 Dec 2023 13:31:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9A64D10E8AA;
	Fri,  1 Dec 2023 13:31:04 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2078.outbound.protection.outlook.com [40.107.94.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3D96F10E89F
 for <amd-gfx@lists.freedesktop.org>; Fri,  1 Dec 2023 13:29:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fjiGZVwIRgJ/zWTwAcsdsgCo3RMj9bShcK7vTwvVyVFXQbXgEd0RIt8gIZoQVelYiUMC9fobgnuWmVptEmbnWVyxtU3UkPcjc+u3p47FX1PI0zhd3s7tMDV+KSr8to0WkqwQ36vVhklyVIYlWyjbJbhOpDev9Ip2UMO0GE/jfYIuWhRWbyzfyfdtJPOctbJ0NnLA1CM2bijSJe3wJevXwxxCr3QGrstxwmlUvLsFS4hY6dQ3mtlRbDUZk4Y/B3K2tGpIYruf6jXBSalu/gc1XpKCc6AlEWrkSS5ZRU/58UfrAvjn0KPA6CJvtFINXx8eMGP4VAAgGqrrNZGLiOQQJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o/yvYZtp5KNMdXxruEsf12rrnQI/N3TdIXRTCp4ZvTI=;
 b=QqeMKxwPbFiemDwPxxM+mnU+hs7q57Lsy+T1f4MoAjVZVS5j/x1epM1+MxRRa8WeJAMVLB+VWayrfRMwjhIdO95ZYmSYvQ8tUz15Zad8JlpirIuLDkRjRd8g84Cy91mfY5y39Ea6UbVtYny1ns53tJCdHZ9zNY5nRqX2OnLmXBKwkILaMoTYeesU4JA2+FLql/ISXQPQeetLGq1j9scViaPIawFkmwHgbsXPJZhIGOP6vFBOgEOKc7yOexcWh82hFINvW4Xj74OH+Vr0wYvKKNvOZAYOFo8EJ7w4T1SHXSIM9ztWOmYBVTy7dGnIIlRKtzajTtyuJuqlzv0U/NGc3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o/yvYZtp5KNMdXxruEsf12rrnQI/N3TdIXRTCp4ZvTI=;
 b=cogPrz9E60pRI2lQZZdFtp3bJsX9eo/k2xG6o8M7dfM+woHwPtTevK9WSZh9foTTQZ7f29hnrLMTJd/8zaryw10dLB/cW8k/FpYHs8/+L0NlKOIu66RZjajJYXw2bkPAKABs0HS+5FSmCd0fAF02RAAW3bt/EG9uzhldpMNK6ZY=
Received: from CY5PR15CA0166.namprd15.prod.outlook.com (2603:10b6:930:81::14)
 by IA1PR12MB6554.namprd12.prod.outlook.com (2603:10b6:208:3a2::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.27; Fri, 1 Dec
 2023 13:29:44 +0000
Received: from CY4PEPF0000E9D9.namprd05.prod.outlook.com
 (2603:10b6:930:81:cafe::15) by CY5PR15CA0166.outlook.office365.com
 (2603:10b6:930:81::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.27 via Frontend
 Transport; Fri, 1 Dec 2023 13:29:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D9.mail.protection.outlook.com (10.167.241.77) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7046.17 via Frontend Transport; Fri, 1 Dec 2023 13:29:43 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Fri, 1 Dec
 2023 07:29:41 -0600
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 47/47] drm/amd/display: 3.2.263
Date: Fri, 1 Dec 2023 06:25:43 -0700
Message-ID: <20231201132731.2354141-48-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231201132731.2354141-1-Rodrigo.Siqueira@amd.com>
References: <20231201132731.2354141-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D9:EE_|IA1PR12MB6554:EE_
X-MS-Office365-Filtering-Correlation-Id: a302e959-c05e-4723-4bf7-08dbf2719479
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yveX4usjQN8tT7B4dKXd7LHbuWzTvsdDciNoCCy+90cmd1iApSkankvks2OpjLJpKHVlg9SksRFvPmvh7zv9kBa0R6Ek3M1EdDfMhh2aemByJoIXgR6owpPIp4ceriDm/1MX7WfOF6bXm3mDx3/hnYg+cw8jpl9bEyS0Cy8fT8rCFC7rWd5fBxGoq2Qd2NfRz9dzXNJXJfZjzBGaAzhP+sC7qqOE4bl6F2OdQAcq7SKq1TM7cmIK/DkYReJ9832kiqWB4v8lsiUAHaKkN9HBHKzJfK1xmnnYDBxbrWy1VU/2cO/PtqndZ/YxDeqm4z09iZYNtx6bDDm/g/IY5KPJS/+Jq3prkeg8qU6oa64XGMfeLK9K4q9tfUB6bDE2KQ/zEg0i0YQKOh/sJZ4DrJFae0NMcFrUkb4hBvDYSpGpird56BACl0JxwKW6iILGHRKKj8qCvKAoRvUvFkfcJW4DL7DlAkQTVp/STrYaqrTfBdf3MW9l/aZe6tT11B/4ekC0VY3oR7Nmpr/R6706iA0zFdeBbxwBsJy7XxS+qLIXRgI4RQ9Jb3/z3gDi3qBYbahbiUr0leVeRXREoJo0pt+AevzSkhjeyn2xA4YewKFIeEjXkL+bWCX+YL2MprlcQUpAER2Lrlo3eZL5CpVkya7TJ7sxmdDg1UhxFUUexl6jz/bvztXJtIoSHO22rFdx/KonkfTL6qkB9L/Li72ni9MyBsxIoYkmQGl7qiJdX4G16elBQjA9zh7IJw7Wo3BfV7oZzz0HIU+2/6ISltw/jI2ngQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(136003)(396003)(346002)(376002)(230922051799003)(1800799012)(451199024)(64100799003)(82310400011)(186009)(36840700001)(40470700004)(46966006)(40460700003)(426003)(336012)(83380400001)(82740400003)(36756003)(86362001)(81166007)(356005)(47076005)(36860700001)(70586007)(70206006)(8936002)(4326008)(8676002)(54906003)(6916009)(316002)(40480700001)(5660300002)(4744005)(2906002)(2616005)(1076003)(16526019)(478600001)(26005)(41300700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2023 13:29:43.8166 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a302e959-c05e-4723-4bf7-08dbf2719479
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6554
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
Cc: stylon.wang@amd.com, Aric Cyr <aric.cyr@amd.com>, jerry.zuo@amd.com,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, roman.li@amd.com,
 solomon.chiu@amd.com, Daniel Wheeler <daniel.wheeler@amd.com>,
 Aurabindo.Pillai@amd.com, hamza.mahfooz@amd.com, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aric Cyr <aric.cyr@amd.com>

This version brings along following fixes:

* Enable writeback.
* Add multiple fixes for DML2 and DCN35.
* Introduce small code style adjustments.

Acked-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Signed-off-by: Aric Cyr <aric.cyr@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 35a654fa97ee..5f87fc12bb8a 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -49,7 +49,7 @@ struct aux_payload;
 struct set_config_cmd_payload;
 struct dmub_notification;
 
-#define DC_VER "3.2.262"
+#define DC_VER "3.2.263"
 
 #define MAX_SURFACES 3
 #define MAX_PLANES 6
-- 
2.42.0

