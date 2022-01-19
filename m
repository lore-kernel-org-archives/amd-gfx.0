Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DD4EC433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Jan 2022 08:41:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AF20010E8AD;
	Wed, 19 Jan 2022 08:41:00 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2060.outbound.protection.outlook.com [40.107.237.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9ECEB10E89E
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Jan 2022 08:40:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hpDRs3tG4jQYKw7Yvwy0+6WgbKJryBjP//qpAE4FM8Wl1SiysxVccgXwm1ESq6C3lHgBDoGIsJGuU6EslA6acwRhR3aTDP2815lA0R/aQkanJ+cLxZYLKfaSUA6zGrs3892a5YV+FySlfHVgcWHOkUwvwEsgoaqRnXy0z7KpMhkI3iVTo54pj7Qysaw3MHnObvqzILh7FZhqa4ReNPXxEAuu5k2oTD6jrtJHMLIPH1v92CC8lKXnZCFh7e1nSib7k2SJ632G6VstOCXn+xvGXrNALXPf48RJ26iqjQNFRqIYasTH5CgenMq34pWgZjxLDS+YzgBTqkC1A3J/GANUew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q60q6wMd4jVmDftOfSPYMyaAYaWU7UKaGALaiauz6lc=;
 b=ejYRAHl8gEUlz7L5+m/nWvLLoVNizeCLuzeNAK3+brZYnpqxZD9LUOlgHv4sYAqw/oT4Dbd35oGNXFtGFjqhedNYfTqogYJtM/lazWG41vNqZ9VE1S04q4c6ZoB7ouzIglkUT+2nIbj1lxUmky5aMl+HaIzU9Q2HPf9TbvTvakIuujnt7EBaE4mpftHfZgzecghYajDKxxxStwvfwAitrJ1vgNOKnO2CnB9fd2zUrT+j9JnrNcjj5pVttDN/jhi1CU4aEeGKd5BFCHWutw38Ohx+rrumMR5X/7R7ILtQ9ypUF3y/xtOUc+N8JdbaaGIlb4YW0xPPFp8SfaNhRRo+1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q60q6wMd4jVmDftOfSPYMyaAYaWU7UKaGALaiauz6lc=;
 b=kr8dBX44TKvHi00pu3rKhZP0t60Lf5CsDfxfd/vLalK/ftejfdG/SiDQGAFKA+1m8hj/l0hNgpsZsVXyP3WEe2QpfEh39PszDGuyMLZ4v7qK3xhVK6EAbyCdfEtoiKtU8UA5HiD/ZXGqnXBsn5eICElU9h4vIY3gIcwE/EybLUE=
Received: from MW4PR03CA0222.namprd03.prod.outlook.com (2603:10b6:303:b9::17)
 by MN2PR12MB2928.namprd12.prod.outlook.com (2603:10b6:208:105::27)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.11; Wed, 19 Jan
 2022 08:25:37 +0000
Received: from CO1NAM11FT039.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b9:cafe::85) by MW4PR03CA0222.outlook.office365.com
 (2603:10b6:303:b9::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.8 via Frontend
 Transport; Wed, 19 Jan 2022 08:25:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT039.mail.protection.outlook.com (10.13.174.110) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4909.7 via Frontend Transport; Wed, 19 Jan 2022 08:25:36 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Wed, 19 Jan
 2022 02:25:35 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Wed, 19 Jan
 2022 02:25:35 -0600
Received: from wayne-Celadon-CZN.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.18
 via Frontend Transport; Wed, 19 Jan 2022 02:25:31 -0600
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 7/8] drm/amd/display: fix a coding error causing set throttled
 vcp size skipped for dpia
Date: Wed, 19 Jan 2022 16:24:42 +0800
Message-ID: <20220119082443.1046810-8-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220119082443.1046810-1-Wayne.Lin@amd.com>
References: <20220119082443.1046810-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a4840f92-1d4d-4ae5-9dd8-08d9db2544e0
X-MS-TrafficTypeDiagnostic: MN2PR12MB2928:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB2928ED7A90B6E6CC67A4DCAFFC599@MN2PR12MB2928.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uCfnqkvJDVVfKVc/qjx3NUU9z9ZFGQHzypKCXreS0p/hOXPKnHsK272GCKyfnNRT/JKvQgD9KqJRQXRVIyBeaJqe/wuyP12ULReG7lqt9MHffWjCr8wjXXzkb+Qye5WPZhyTDgAiVYU87C+LG8G//K6NaUMV5jyp2wkkVJfYthwtSV2N3mbPXZqBE3zGC5fx6ESP4KQIEwEa6Alai10uIsKtuDWercRHKVCIbgi9klR+pOouLv9Tbx5ZxNAHzp7s2HRhwT/m9JUaOaZCxYv9fIU0o1ns+zPPG2XKHdngD9Aa5ZWawbcPewm61/TNqn98RnUGDrJNLQPN0LZz1KNapj5tfqtUvmVKDar+kGq/agNL6hWy53qz5JsfNbUAa+4VY7sCJRmYeKMxuQgPRU1gUkaqmt81VDQRnFDeT3Mp+pr7GboBXmjT8Km6xuVFzsPdS44kqq5FoEmE+CM/HFO8SVpUpophVRp9xKuv5vOw3atu2Kor3nlzh3qOCfpQIDNsightZjDFYgSUkkxkRGZJhfRTAOOakOlR86VSySLLYWfhDGTRK/rKMSgagnGGDUFazTDJQfc2WK+VKyBRgLU8nhTrFZ6tZFCeJy26T4GGpa9XSOsmIgc4k24wBpX/cFGYP5iUZsk7Pi4qZD/u3zK1wqw/2wWAhIVBt0hDXFqzRTYIDj/i5frq+yQBLHLCMiQW7crR5gnnerIKwkXUlpZiz6lxtwqC9Ga3w4OHlXE8B7DlPFjOc2GXfI1YkGysVHqPYrRwF023ZJEOeCf+z18s6udcUmm1gsv2YPyViaxOK9Q=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(40470700002)(46966006)(36840700001)(70206006)(36860700001)(8676002)(40460700001)(6916009)(356005)(336012)(26005)(36756003)(6666004)(186003)(1076003)(81166007)(316002)(47076005)(2906002)(54906003)(83380400001)(8936002)(86362001)(508600001)(4326008)(82310400004)(7696005)(70586007)(5660300002)(426003)(2616005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2022 08:25:36.3605 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a4840f92-1d4d-4ae5-9dd8-08d9db2544e0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT039.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB2928
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
Cc: stylon.wang@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 Wenjing Liu <wenjing.liu@amd.com>, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, Jun Lei <Jun.Lei@amd.com>,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Wenjing Liu <wenjing.liu@amd.com>

[why]
There is a recent refactor that contains a typo to cause set throttled
vcp size skipped for dpia link. The change is to fix this typo so it won't cause
black screen

Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Wenjing Liu <wenjing.liu@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link_hwss.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_hwss.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_hwss.c
index 01254b4e7ac6..c5146263f93c 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_hwss.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_hwss.c
@@ -926,7 +926,7 @@ static bool can_use_dpia_link_hwss(const struct dc_link *link,
 }
 
 static const struct link_hwss dpia_link_hwss = {
-	.set_throttled_vcp_size = set_dummy_throttled_vcp_size,
+	.set_throttled_vcp_size = set_dio_throttled_vcp_size,
 };
 
 /*********************** below goes to link_hwss ******************************/
-- 
2.25.1

