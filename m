Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98EA3C636CC
	for <amd-gfx@archiver.kernel.org>; Tue, 31 Jan 2023 08:33:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2113710E04A;
	Tue, 31 Jan 2023 08:33:15 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2086.outbound.protection.outlook.com [40.107.243.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C257410E04A
 for <amd-gfx@lists.freedesktop.org>; Tue, 31 Jan 2023 08:33:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U//8k+YcY8caex6wItltfAGj3+XTvx+kDeg+FWI3svAdhLPf458XJiumjIjkDCUJYNpLyEqbsINLg70JMChcWnvXaMLMRZk+LTKA4u99EyJP2tP3r/PMbab3j6lTKKrqRIZyNys7gEg5s5wsyj9I5GZvFBTK0SZY2HI+xwtkMtbA7YiYhQvFBY3++8DtQMmFAjlLKyZL/5vE7zbctiZZqeQQ2Nk2PAsfPgXDZ4/vFHlDowuGKvmT6B7kY5/M/2WOUNjmtAyiEL9s1VrhM7hNX3NgdwSYUHbrrKDQ3kyTr738BKYb+cgn+/0rAeR8q1zEkKXt5492uH5LVUuG7q9LDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f1bD39bCAvwbt1MyJnACbZmyjT8C8qgWTXGjSgwY6W4=;
 b=CXCh/ay1M7rhL0sZxkp95MKME4x/mvyhVuejcgUoUUipOCGaqL3Qi0aZuMPvbZQOP+rIqUxrNJ8tsgpf9vnHbd1dqAPE4ZIKZ4s/tcnBDuxq25UMlackPoXS+Kuvh4swBD+lS9rwd6Db9+oT/zRyGEEJn6GIiqnKTr8lJv4ZVNOBcUCf8Gq7PxnmnJnKOqWN40KD67jrgaBXY02yoFqKRoxGXvlRZHjTO0/9WdpxYzo1gKWH/r0KryHPYzEwhtm9bTMF2Y9E6+i5PNdje8JulTFAhd9u+yFSlhj7F23xWuJ8cRKGOiSI2wCQEWkn+E/zGrh9urpf5HZWAXXlWXz34A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f1bD39bCAvwbt1MyJnACbZmyjT8C8qgWTXGjSgwY6W4=;
 b=XYvEuANY2a1soCUdEnQBnRvxjYGw/3+w4F1eo69EriNsVl0j8Ha1xFwwSgYR2gTjUE1KXvk4QzUG5GQ3LP4nK2ZaOKpWmZ/ESdoB8Q80QCg4MUztAYEIZyK4Ps6I6gUuwpMre9YTyJ4SQmvaKDbBU7FT8QpH5czC8kkM/GOpu+Y=
Received: from BN9PR03CA0227.namprd03.prod.outlook.com (2603:10b6:408:f8::22)
 by CY8PR12MB7434.namprd12.prod.outlook.com (2603:10b6:930:52::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.36; Tue, 31 Jan
 2023 08:33:11 +0000
Received: from BL02EPF0000EE3E.namprd05.prod.outlook.com
 (2603:10b6:408:f8:cafe::52) by BN9PR03CA0227.outlook.office365.com
 (2603:10b6:408:f8::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.38 via Frontend
 Transport; Tue, 31 Jan 2023 08:33:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0000EE3E.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6064.17 via Frontend Transport; Tue, 31 Jan 2023 08:33:11 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 31 Jan
 2023 02:33:06 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 31 Jan
 2023 02:32:59 -0600
Received: from yiqinyao-Pro-E800-G4-WS950T.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.34
 via Frontend Transport; Tue, 31 Jan 2023 02:32:57 -0600
From: Yiqing Yao <yiqing.yao@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2] drm/amdgpu: Enable vclk dclk node for gc11.0.3
Date: Tue, 31 Jan 2023 16:32:50 +0800
Message-ID: <20230131083250.3323885-1-yiqing.yao@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0000EE3E:EE_|CY8PR12MB7434:EE_
X-MS-Office365-Filtering-Correlation-Id: d2020faa-c890-464a-177b-08db0365c99a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: g0Nf0HH229W8zq/43SCmr9C04Yv+a+OKwmTtiAArFVJPjjWL1aA3YC3xLN4+EmRHDJO2BAaNX+eODH1lyey/iedsmi8C2B3KsIF0c7qIiP8QH37OKIpT3oEiTv9r8bKO1xcmVaeaeF444tzat0gyR2Azk/ySvxza1Z8ulqOu4lLQd40KKTq+08RO1tESC3EfcSe4gb1ZokWWtEWdRI6r0tUrs7v3qpBS8kvCgvK5haVYFw1+wCB3lKUNPdkCrIcfZj2ahqENzrzHQAh5uvTwwOzAAclh+4xi2LznwdKmHwX3d4qEvICctV8RTqJnb/xlMunXnK/sagENZrWqXDsXBy1S3gKPUBZiefYrC+nRZHlPo5YBeM6JlHmBQFTCuMXoQ6kObGzj3d+XkLtSwekqdyleOpTJNeUT7NgZFzuc+j3IFGk4Id4MGaASGOMM0+adiWPfHDr/WekjBzaDkAOeKUraQ+VoUSV3IoJSNxDdXtSbTTomT6ZjQjKOgR99XAFZu52QmYiLFAl5jstTIm4u8azjAdSxZfSmwUVNlt2k5V4u/hB8j8RmT9fGz7MGpDzmEcweWgB82MU363/Uu/QnCagNXX9dsv6PPy7UvRTuLdNg3eDlmBtLvZx4IP9y1E1SIOpwr3OWcjTfbXRWkUbYL747ge9GKgjsICAJdozYXwe0XHk82LCWg7XF1kZltu2GUTXFrhD/Cu5wGWDtlGNwsxERFnD5196AGnx6sVnYk24=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(376002)(346002)(136003)(39860400002)(396003)(451199018)(40470700004)(46966006)(36840700001)(4326008)(70206006)(70586007)(41300700001)(6916009)(8676002)(8936002)(6666004)(316002)(40480700001)(5660300002)(54906003)(44832011)(83380400001)(36756003)(36860700001)(2906002)(186003)(81166007)(7696005)(40460700003)(26005)(478600001)(1076003)(47076005)(2616005)(426003)(86362001)(82310400005)(356005)(82740400003)(336012)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2023 08:33:11.1643 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d2020faa-c890-464a-177b-08db0365c99a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0000EE3E.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7434
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
Cc: alexander.deucher@amd.com, Yiqing Yao <yiqing.yao@amd.com>,
 hawking.zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

These sysfs nodes are tested supported, so enable them.

Signed-off-by: Yiqing Yao <yiqing.yao@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index 76b9ec64ca50..bd060697d982 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -2007,14 +2007,16 @@ static int default_attr_update(struct amdgpu_device *adev, struct amdgpu_device_
 		      gc_ver == IP_VERSION(10, 3, 0) ||
 		      gc_ver == IP_VERSION(10, 1, 2) ||
 		      gc_ver == IP_VERSION(11, 0, 0) ||
-		      gc_ver == IP_VERSION(11, 0, 2)))
+		      gc_ver == IP_VERSION(11, 0, 2) ||
+		      gc_ver == IP_VERSION(11, 0, 3)))
 			*states = ATTR_STATE_UNSUPPORTED;
 	} else if (DEVICE_ATTR_IS(pp_dpm_dclk)) {
 		if (!(gc_ver == IP_VERSION(10, 3, 1) ||
 		      gc_ver == IP_VERSION(10, 3, 0) ||
 		      gc_ver == IP_VERSION(10, 1, 2) ||
 		      gc_ver == IP_VERSION(11, 0, 0) ||
-		      gc_ver == IP_VERSION(11, 0, 2)))
+		      gc_ver == IP_VERSION(11, 0, 2) ||
+		      gc_ver == IP_VERSION(11, 0, 3)))
 			*states = ATTR_STATE_UNSUPPORTED;
 	} else if (DEVICE_ATTR_IS(pp_power_profile_mode)) {
 		if (amdgpu_dpm_get_power_profile_mode(adev, NULL) == -EOPNOTSUPP)
-- 
2.34.1

