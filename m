Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B9DAC07E8E
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Apr 2024 08:51:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B0E7F113957;
	Wed, 24 Apr 2024 08:51:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="NoZJ/VQl";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2078.outbound.protection.outlook.com [40.107.92.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6C53B113957
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Apr 2024 08:51:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hqbwVKpoO7Q3nyEt1E443nbMYQd0hF3vuD414eg+W03bQzbN9k/1QYaay2o8I/LsEc5bAROqfzvgpM3PcPeSoCY6QKTROB+hfgz7YiNXSPL3DGjavxkgnkp9K7Qzbp4pweZBipyVw1ZBC2oIQc34PH+FxE/oHOauy6SilYTY87NdjxAEbwDnNGf0bfGTC+qC4Y89LqDW2GZlEoSvCscAsq2mEpWqSrKtX9klV/sfV5kpHKzYn+08nJYMxElShe/zIAcNYIYMzt0ZhN9W5Q7KB46IW8Wnw105wLEMjW5C7JcDm30cMgv3EypzIAjzfAFAnbq2gpEcrHTsTFcnYbbBGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IxV4RNOxgqcpfLpUG222sy+wQ2V8w+ZlqDCt30ErywI=;
 b=lmIV9KD8e8pd+4BheHonimGlHuW/RPBx8NQanPU/uY/HzVODK40LN6iSC0/SgmrzuSqeDUbsbKoHveR69jGXeM03DYyOjxjwqzK4+cb9s+BF/7fvneym9tMk/TS3i62LTk16cekCi9j2RzE4Bx4wWELfuuY3n4nEngXU1FB8a+XsTcuizlDnQ8MBNnQKDwT8HaPU+sCQycHi9X5Pyf8TR2khganPhekubY2znewjnbU10tHWU2xjaH0bmu50BvPyIBD+orLKJIMB2yG6vaBLXGoiWnm6pyGDkT3SgnyNNawc4Z2B+YmrOkNoYPi0MWItTib0CVAFvP0ni62QaNZCmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IxV4RNOxgqcpfLpUG222sy+wQ2V8w+ZlqDCt30ErywI=;
 b=NoZJ/VQlos/cWvPqC6zXyS9bUNo6wBFCuJVtFprfMC9eCLxArH22lrTcDokqoheoEA28BPrtf9T/1hCn9RCUt3nXn5hHZRGfYaUk/v/ilrVkB0IJaAqLnTZQ8oXnIKRtv9tzNYrIf5Y1aK7gkur3mYhWE+125M0eD1cGgsxMULE=
Received: from BN0PR03CA0040.namprd03.prod.outlook.com (2603:10b6:408:e7::15)
 by LV8PR12MB9081.namprd12.prod.outlook.com (2603:10b6:408:188::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Wed, 24 Apr
 2024 08:51:08 +0000
Received: from BN2PEPF000044A1.namprd02.prod.outlook.com
 (2603:10b6:408:e7:cafe::66) by BN0PR03CA0040.outlook.office365.com
 (2603:10b6:408:e7::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.22 via Frontend
 Transport; Wed, 24 Apr 2024 08:51:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044A1.mail.protection.outlook.com (10.167.243.152) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.19 via Frontend Transport; Wed, 24 Apr 2024 08:51:08 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 24 Apr
 2024 03:51:08 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 24 Apr
 2024 01:51:07 -0700
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Wed, 24 Apr 2024 03:50:58 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>, Alex Hung <alex.hung@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Subject: [PATCH 08/46] drm/amd/display: Do not return negative stream id for
 array
Date: Wed, 24 Apr 2024 16:48:53 +0800
Message-ID: <20240424084931.2656128-9-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20240424084931.2656128-1-Wayne.Lin@amd.com>
References: <20240424084931.2656128-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A1:EE_|LV8PR12MB9081:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e8105bb-d0d4-499a-9712-08dc643baf2a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?K/GapPYhSHFhimgcTzfjqT0KoAAdC5gNcLxuCc32CF4guE2lOx/FGABjFkGY?=
 =?us-ascii?Q?8sLYpEJtTBezChMmyzJ0DhVhyhoP5NtGAIJC7Ns3/5eITSmAURTe7Y7D4Dik?=
 =?us-ascii?Q?B0JCiJg1dxhls5Ekaz54jYMPgmbOct5j78BOmqVeDsD53NxrHOMvvmJgYm3F?=
 =?us-ascii?Q?/iozEU7mlBr+W6me65qv8aClkD2GmtZ/M2Vyp2lLKpAj/c59jnQdob/+uFA9?=
 =?us-ascii?Q?liezPbSEyYoAetB3wrmIExOzvlBucLjzO+TpmFYcFeUsz+aTG9n+uLW/e39k?=
 =?us-ascii?Q?kW+Uk8oay7QjPRDvxH5F6xjyfqa0K32i/MyBCPRxs8393+TJH2EI3b3ItAls?=
 =?us-ascii?Q?19ANWIeoc9VvmLz1RkW7XOnGBY6i5EvUamncK5EgG5JGZPJiZjfgFijn0viy?=
 =?us-ascii?Q?GpgUk0sqeY60nMgtDNectwXknhF30taolTd958k0xAWbwThPmBrZzlLLBylP?=
 =?us-ascii?Q?u5IuVkyy1dGM9SHfICWJZnuPJopQOy3X2jFDTKh9wmnYhvRCZ8/O+Zkqq+NY?=
 =?us-ascii?Q?p/SfWCycMDZaw9zJLP+ptXq/Cj6R/ieDmra4mRvRzfWOCBL/u8Dc0Yqz7WRZ?=
 =?us-ascii?Q?FbY6iwBxB5LkkAYRRSXxHpO8EZlRB/V+17AGk2d+CC1KFW6HcCIUNSVdtbup?=
 =?us-ascii?Q?8Ja320RfHUYSa8KIKWv93eOkID6MZo6IE1/zqOjEdzk+qjZaJ8UtXUry0+yi?=
 =?us-ascii?Q?Ii0rt+h8a4OumJ8tmhDs/5CjJXzv8hNtpWRXD2yjsr+34cv4OqVMCSzJajUS?=
 =?us-ascii?Q?FMTtQUC27GAXYTv2rMznZLr5P8fAA5vO8i9VwEGprg0h1URR8HMYn+bxCTWl?=
 =?us-ascii?Q?S/imMgsMZKsu/4rAqiE5b0+hz0bzPnAzl9fiL3dBbTgKSweK3jO9KNOIcYK+?=
 =?us-ascii?Q?DqmxG3zW9Kshs1u/sZIeAVgBSruPoJR9+cZH4f9Sm92BCRfWZTUODVlJ73/1?=
 =?us-ascii?Q?W6SCbiTNtSJGpCZ4ojGW5pAE7bT1JFGeYuDAu2AqzswHa7NkSIUloAkcT92w?=
 =?us-ascii?Q?A1rMmEA504hS5QDMZfu0bTcVOw5WD/qWCoT7q314iv7ZiLE272Fv/I5DxrkD?=
 =?us-ascii?Q?4er9ZuYvp8rFbm4Mv5vCOHlql0B0Ob65ZbjzwfcFUhPmAo/uzF6jHoij/Flo?=
 =?us-ascii?Q?9KY0E9NPRoR0uluG8b+RuAORXWoZfCHSNplKXn/KD+EfLNy4M9CI9e9e+dTb?=
 =?us-ascii?Q?BLm1zAzCGzF7eAV1WJ0eU+dvIcMJVJsO5i/8L7QN7SVQf1u9XzAWsmhrd0Qx?=
 =?us-ascii?Q?r8E9Plk5aBjrZ9mCiMy4sHEg2xYrvXqwlCR3ePR+k4DaZ+1A2O70VUWhtxJu?=
 =?us-ascii?Q?HFXj2rueHHDpIqOBrkKfVX74eGSwT27cy8lUGCLcAdpZ2vrGk+8qv3ennTjq?=
 =?us-ascii?Q?Gql+lOA=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(82310400014)(36860700004)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2024 08:51:08.3951 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e8105bb-d0d4-499a-9712-08dc643baf2a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A1.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9081
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

From: Alex Hung <alex.hung@amd.com>

[WHY]
resource_stream_to_stream_idx returns an array index and it return -1
when not found; however, -1 is not a valid array index number.

[HOW]
When this happens, call ASSERT(), and return a zero instead.

This fixes an OVERRUN and an NEGATIVE_RETURNS issues reported by Coverity.

Reviewed-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_resource.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index 93f05e2080f4..25c64fdcfa44 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -2282,6 +2282,13 @@ static int resource_stream_to_stream_idx(struct dc_state *state,
 			stream_idx = i;
 			break;
 		}
+
+	/* never return negative array index */
+	if (stream_idx == -1) {
+		ASSERT(0);
+		return 0;
+	}
+
 	return stream_idx;
 }
 
-- 
2.37.3

