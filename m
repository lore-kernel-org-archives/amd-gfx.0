Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C44EBC001DF
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Aug 2023 06:53:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 477FF10E4B7;
	Wed,  2 Aug 2023 06:53:28 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2040.outbound.protection.outlook.com [40.107.93.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CDC0E10E4B6
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Aug 2023 06:53:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EAx4s8CaeIUBdLgXpkcqtRjmtyDfEW2zuDhnJVP7heqgziCyFLH8FXySRoiY7rSa1ZpaiaYOY0pMJQsrrnM6tVf+FC9F1reidJR5tX8oAiBA/lsckP6GfiHwZ2BhXmFWMCDtyxxUxYSWPF1i+F7zzFmej3qNFuWUmCtNx0lJvlWYP6Jz61T8V8b3GRRNV9ypSVg1Fus3+MJCR0G9jVrDJ1y+i1ZKeaoMXJWoKb5vD81XRfqi3MGO7WXPbt+VSdLOCnrGJoCEPgIhF6vpOmEs0Egr2dQPsRSZQoLJorfZw+qcafiZBkJ1AEvY4KaxshiGONQxzepyWg3zjOmv3+yUiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W36CHywXS/cpEARVP9HuLZUkTAEsdUoTnFTPo81zKXY=;
 b=BjeLz8flouxyPQWzAVXmQLDQc4gor+CbltGw6ZPA9Lf91tQgDkbLaTsbdlF4hsErdawH7Fvp+5PjcuO9CqksVxkYzVZ85y8JPDft3gxXdint/4VtXFKNHUAFf6Ix+sbUBc76aCCIX38OnpsgjJd6WwrE2nHpe6YF2K+W5sgZ+mMxet3Dnld/LFbHYszRbc3WdNYx8OZygWSgWLOLCKMmphC2g0WSfFds2r72kw5+0AoRud/QBm/S1/5ZikHpsZo30Yf0o76QZ7dGnM7Z/cy0dUJ9TLAj6vKUePbuhmeLljDkfnQH/Ay8vGoVgiJLvlXJqC7k3/GJrFxVPLZKExi4cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W36CHywXS/cpEARVP9HuLZUkTAEsdUoTnFTPo81zKXY=;
 b=ZhXSh7+lz4jAMZEPFA3TAJLu1jBah8XGooDL01wPi5cbAmpGp1FTeIDioe1sUJwKOIKPul1Of1A5a2tyN6LMWVaVrUH3o2WqfretUqRGLontCbfQp0nLE45PPWFtsMMpN9OpCuJshNe0v/dcb55fELH7UM93T+k6RzGodXYdJ7g=
Received: from DM6PR08CA0010.namprd08.prod.outlook.com (2603:10b6:5:80::23) by
 LV8PR12MB9357.namprd12.prod.outlook.com (2603:10b6:408:1ff::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.45; Wed, 2 Aug
 2023 06:53:21 +0000
Received: from CY4PEPF0000EE3D.namprd03.prod.outlook.com
 (2603:10b6:5:80:cafe::5e) by DM6PR08CA0010.outlook.office365.com
 (2603:10b6:5:80::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.19 via Frontend
 Transport; Wed, 2 Aug 2023 06:53:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000EE3D.mail.protection.outlook.com (10.167.242.17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6652.19 via Frontend Transport; Wed, 2 Aug 2023 06:53:21 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 2 Aug
 2023 01:53:20 -0500
Received: from tom-HP.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Wed, 2 Aug 2023 01:53:16 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 16/22] drm/amd/display: Add vendor Id for reference
Date: Wed, 2 Aug 2023 14:51:26 +0800
Message-ID: <20230802065132.3129932-17-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230802065132.3129932-1-chiahsuan.chung@amd.com>
References: <20230802065132.3129932-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3D:EE_|LV8PR12MB9357:EE_
X-MS-Office365-Filtering-Correlation-Id: 17c22c54-9421-4ba6-2c54-08db932528ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sVWo1y7phrAhuvxh41C0iCScCpwKzlhZmj3n7rqrAZHxmHwfLEyYjFHi7cwcnAnRJg6egDZHr0ImXvlieD5XDZuDSwh3bREI/CWUb7+6emPpiBxR7Lul839sTD6CaqD5SFx60hk9qFB1Q9ZzA3Sigs+dGn4e/OCu+E9hH0MM+6CxRYi2qI3x9imiSGzU5DWn0e4FcOVEhzULtONqC5qvQuZcWZNT+dLIKxwGZ9x+YBaP13ijI/+3DfnX/TZx9sxJK4/e0MeLMl8c3UjZa7rhZAgDTUG/6BlKOpIXckBvPVIrT6LW6AbNynPI7DTC3a8w/jCqoSQBML/Pap/mY4Mdaw9JE/gUpAh5xF0oNxFVC+XiVjOV4z4oGQcpkiWu2e1n0461SJeBJxNKQ6/IyucZbD+irAj4ML9yJK7MWiSKwOVLtpZhA1Uef/9fsCCyMM1AeYQT0A4jCEBKQKLBWAVi8v+jAhYy7QREbtCm7psj04ZaJCjcq2alOxDceQDTgAOiZhf+MCciQ8k+iYdh6yD94w+ZF9bDISXSYftV9wPCxjYLPfiLeiYw0mcPaR4hv0XVcM23zFgz6hIrkgrqX/W5FLEuPs9mvJnbMpAKdZTCoTyEEY37deeoFjQp57tpZLvIHfvUrFLnyytsKrlbWQyICiCgnAajt+SncGsHxz76VrQ5EtsF0yyNGO6+5d1DFTcJkW09hDdmsIyxRVXs3eUtTGjG/qlNPZya0Kei9s1WlWjrtWgDgNIkmZn/GMVnFt32Nf7jF3XfXBIGugmH3VKLlw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(136003)(346002)(39860400002)(376002)(82310400008)(451199021)(46966006)(36840700001)(40470700004)(6916009)(4326008)(40460700003)(70586007)(70206006)(2906002)(426003)(2616005)(81166007)(82740400003)(356005)(336012)(186003)(1076003)(26005)(47076005)(36860700001)(54906003)(40480700001)(86362001)(36756003)(478600001)(6666004)(7696005)(4744005)(41300700001)(8936002)(8676002)(5660300002)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2023 06:53:21.1487 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 17c22c54-9421-4ba6-2c54-08db932528ef
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3D.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9357
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
Cc: stylon.wang@amd.com, Mike Hsieh <mike.hsieh@amd.com>,
 Tom Chung <chiahsuan.chung@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, Wenjing Liu <wenjing.liu@amd.com>, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Mike Hsieh <mike.hsieh@amd.com>

Add a new vendor ID code for reference

Reviewed-by: Wenjing Liu <wenjing.liu@amd.com>
Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Mike Hsieh <mike.hsieh@amd.com>
---
 drivers/gpu/drm/amd/display/include/ddc_service_types.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/include/ddc_service_types.h b/drivers/gpu/drm/amd/display/include/ddc_service_types.h
index f843fc497855..68dfc7968017 100644
--- a/drivers/gpu/drm/amd/display/include/ddc_service_types.h
+++ b/drivers/gpu/drm/amd/display/include/ddc_service_types.h
@@ -40,6 +40,7 @@
 #define DP_BRANCH_HW_REV_20 0x20
 
 #define DP_DEVICE_ID_38EC11 0x38EC11
+#define DP_DEVICE_ID_BA4159 0xBA4159
 #define DP_FORCE_PSRSU_CAPABILITY 0x40F
 
 #define DP_SINK_PSR_ACTIVE_VTOTAL		0x373
-- 
2.25.1

