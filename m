Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22649C54EBD
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Jan 2023 16:25:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 986DC10E2F0;
	Thu, 12 Jan 2023 16:25:04 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2042.outbound.protection.outlook.com [40.107.94.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8424F10E2F0
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Jan 2023 16:25:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m7USy0RX7g2cjnul3V0awwcjNUBeEigtaQhoAAaSQQ46ELwDhesk1TweYwCF1BxGCfsQnCfel46PSbAg1JvxTeL57vl9O/GAmDyD5i9+hq7iMxUB5LZvPKiO+ZCyDQxkM9UhIyTOmpaoTKJVK+uzdxMpkbzRTC8k21rJlnl+j1ilyTUBXPX8aVdnEaTY4na3/9KhZG9jgETF0vgR5MTNC7i5J30R4+pv4d8f82yeE1K4rZSQUPWOihmYaFLdj89wLiBlt0iDlsfKcIx9B5HkRFFcVvSAg+4RPqPGW40WAKHS5ZrqQwSrPvlG13vReBewEm8codEgR9d47zOqxw67WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lON4fTRhrpsWtNqhywPsLrWmTnutQ8ZTwV9iLwp69BY=;
 b=Xo5oVz53ksxdNi/GOAyjl0DYtCH4TGBxsGH8nVTtLSXZMvTGI1N0R46z/KXp2u0EP9+uYTQq6HCOUNg6S/tE+b/oPnc1L9BLL30u0j8JFCK1xI5tbtyL3/Og2j0JyueOQjn+GyhsG7hb1H506wc4+vOD1jdCtYmlTIYcA+yzOyECE3kF4PFA86HTJRFFfuzdjt8nhUuKv+9/mn2kINfWCZCW+Y2Zyor7YzRxcx/rPjn5iGX11y2GlEyxL38M4JoSZKF/KSroUk/ylPYvKuNeshXQd6nCFrgVJTf6ULoucxJEQIlQLh6L2DW3L+Rcg+2DeNkgfhj9wLAy2+EKzpIwsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lON4fTRhrpsWtNqhywPsLrWmTnutQ8ZTwV9iLwp69BY=;
 b=NBYI9U+luIfNpfZKYEr33wNmrnb8mHjl49lUv3rX6n4/CNprP7y/qNh0lU0l6CBlMamW7Kyswe7R5PeREE5A3LcZgLTCVq9F+B9VUA2ehEU1Q81rgl+fdVPuxOPT0jceWsh11Ok4A9E14otr1D8xBMSkyvSihDIniHvlUXrlZoA=
Received: from MW4P221CA0005.NAMP221.PROD.OUTLOOK.COM (2603:10b6:303:8b::10)
 by MW4PR12MB7381.namprd12.prod.outlook.com (2603:10b6:303:219::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Thu, 12 Jan
 2023 16:25:01 +0000
Received: from CO1NAM11FT111.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8b:cafe::28) by MW4P221CA0005.outlook.office365.com
 (2603:10b6:303:8b::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.13 via Frontend
 Transport; Thu, 12 Jan 2023 16:25:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT111.mail.protection.outlook.com (10.13.174.61) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6002.13 via Frontend Transport; Thu, 12 Jan 2023 16:25:00 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 12 Jan
 2023 10:24:59 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] drm/amdgpu/pm: update hwmon power documentation
Date: Thu, 12 Jan 2023 11:24:43 -0500
Message-ID: <20230112162443.603552-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230112162443.603552-1-alexander.deucher@amd.com>
References: <20230112162443.603552-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT111:EE_|MW4PR12MB7381:EE_
X-MS-Office365-Filtering-Correlation-Id: 8831310a-5f39-4e97-4f24-08daf4b98db2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: whNVclqXoNIRiuDVhgA+vkzcp/GTQYsm28z2w27FxNXGJWv/6knX+zJKGaJJDTjrc1JgXo4XB6ZRFE94DBUt/yXa1Inkd1ajfXa9sUEE+vILsdBZRLHZuyuPWJw6XSmODocPYcrLqEEdAp+9bjAgCNWZcSa0EulJRgBuO35O2KNfEUGQcztEBqY2of9uDhYnN4vqIVbnNyItFOSZbr4kBiE3VIQHSfMpwTLzBz0YFgUx0A9pAc4qU1/RoCy02Xf7+P8iCOw1gGWfQe9OpKMZZJmvaMcZZIj5qRrEkZbvRmVKp7C8gsV2rzzr+T0gMgXkt1P9lFwluj52cubvgAK+lLHlL+/NHa4afsORVvxgoJRMLkGK5RrOosxU1GoHfn9RrmhyIt218kbwVsFMaZziFOz/kbmVBHDUjE1qf9QyGy7owJOR+w2YXLOemduvAarSrb/6MsD4Tf9fjl84mo1Mj1HPo3MnfLQBucgDe5oP5zwc7hrRYAot74cVgd1s2bjWMNvzNw2lLv2JkPDf3Tb9dM1vKLYqVmxonQHBYyqHaRWAfFXMZVlSXQ4liIIlkp41/c8uTGOHfdCaSrQ2B5XFX9HrOwtDDbsspHlmWZ3sab7k9OhFm+dgBOOWTxfS2SK+uXWGdCsiGaXikyjRYamg37tRVE6+v4jxUx+BI63fNgUKBIUZ0vYPI2MnI7kd54achoGDiLOlhwIvf6Q1qxNUOZlTGYRC9FK+hWOeP/piWUU=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(136003)(396003)(39860400002)(346002)(451199015)(40470700004)(36840700001)(46966006)(47076005)(6666004)(36756003)(86362001)(426003)(41300700001)(36860700001)(83380400001)(15650500001)(478600001)(8676002)(82310400005)(82740400003)(5660300002)(8936002)(7696005)(186003)(16526019)(26005)(356005)(70206006)(81166007)(70586007)(336012)(6916009)(4744005)(4326008)(40460700003)(2616005)(2906002)(40480700001)(316002)(1076003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2023 16:25:00.8340 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8831310a-5f39-4e97-4f24-08daf4b98db2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT111.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7381
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

Power reporting is socket power.  On APUs this includes
the CPU.  Update the documentation to clarify this.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index 236657eece47..76b9ec64ca50 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -3059,7 +3059,7 @@ static ssize_t amdgpu_hwmon_show_mclk_label(struct device *dev,
  *
  * hwmon interfaces for GPU power:
  *
- * - power1_average: average power used by the GPU in microWatts
+ * - power1_average: average power used by the SoC in microWatts.  On APUs this includes the CPU.
  *
  * - power1_cap_min: minimum cap supported in microWatts
  *
-- 
2.39.0

