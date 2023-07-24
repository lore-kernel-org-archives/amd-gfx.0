Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58BC3EB64DD
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Jul 2023 19:56:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B092B10E037;
	Mon, 24 Jul 2023 19:56:51 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on20614.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaa::614])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 38FFC10E037
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Jul 2023 19:56:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LmFlyPmAlgE9atdDnAWB+xW5A4Yhf4jPJi7ubLCXxcAYr8HCw0qQ7PGY8OBIh8jecSqno57CpBAW/NiMZDZYGWhVXEGGnf0U9yn1vEiUP5lXE7o8toddLuNIi7o4ldd2oLBmqgqZNFCils1yusF1nbVg9ydr2FVL4Ot7gGbDt7xx1EXmAs+xsvZk6lBXDT8PwETy8blNTihnMUPEbKV5fqmrA1ij58mHJWVilDnz1u2rECLpmZa496CvIF6TyDIRtwukbDZM1X6wCY6gneCyIPPgUR+IEQ3fIXgZ+PsNLjJZusAahL+srJqI6IGQkGPXdOAU8bzYyu4846K48A8dFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SEIxfrV4jIOaFUdmMz1+k8vRxMZCS3DITMaIvGkuGcg=;
 b=QRU7SNJ4DQGpupVTn2d6HQZp0ZYfJOoYIHfaPPnLJPQa8Rf8MZBfE5wztcSf7nL8Ku+eQVIittsfqrnFdX66+hIteR+QY5PJeupx9yIPA4xrbsjZtagKXeHiMTfmmK8Xd4y7eRecNzJzZ1fhqccYCLa0GrefVixhnyT9vWNiHCUrwmuM4wQ+STqDcLMmh7HDcProBwzxjCt3KcXiQoQ3RmWXaDfGIPj8ClGhsKuIbYpvpRe6PTu1HKZ4nC8EL40G0wzSgvfpJ2+HtnjbhG4fPXgSRgDXAQwi9xrIYjiqZ0M10yCPVHdO6EOQVkZziIjWzbxMn4u2Y9qRe+DBD2WkWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SEIxfrV4jIOaFUdmMz1+k8vRxMZCS3DITMaIvGkuGcg=;
 b=ES45XKOX1VnTwwjxwJ+7y9aiREE50h+z7jPZfAe+Unlx0nkk73IxcJ5nrPAC+tuqXRaxph1EBBHaNd3UxCB3dQu6+X6PXoMFSTMRTVaYc3LBiobWFuIFIETVRBHV79tNQ8dgKBVL/iP1a7y/qlhgtVbzQlvaeJH+ODPgQ7zCXWE=
Received: from MW4PR04CA0275.namprd04.prod.outlook.com (2603:10b6:303:89::10)
 by BN9PR12MB5163.namprd12.prod.outlook.com (2603:10b6:408:11c::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.32; Mon, 24 Jul
 2023 19:56:48 +0000
Received: from CO1NAM11FT021.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:89:cafe::43) by MW4PR04CA0275.outlook.office365.com
 (2603:10b6:303:89::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.33 via Frontend
 Transport; Mon, 24 Jul 2023 19:56:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT021.mail.protection.outlook.com (10.13.175.51) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6631.25 via Frontend Transport; Mon, 24 Jul 2023 19:56:47 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 24 Jul
 2023 14:56:46 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu/discovery: add hdp 6.1.0 support
Date: Mon, 24 Jul 2023 15:56:28 -0400
Message-ID: <20230724195628.764079-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT021:EE_|BN9PR12MB5163:EE_
X-MS-Office365-Filtering-Correlation-Id: 61ec200c-60da-4396-912c-08db8c801d58
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ygHGH5h4fjCpIRPclTWI49vWwsbfy9p5plbJRNbHoLJFdoxvkQCwLdfsppB2J+gDwgb7pr6GCLaS/avt1cR4y10Klw10x+orG8ySgXYOc58px1N+uc/pUx+tbbOBaxObEobtYkRTl58MaTQHIJs5/Z50ecTNp//MZWj7o23AlJJXkWQk+zg/BENmOHUdOFvFklIuTrRNdaMD/hxYKrXVZQ8RVCeSKQtWHCBNlWyzInXsmC3z0sWb5GTeF0KDpHXJUSGzHJaobeO5EajHZMKKDVJsR1wd+Y37b+A24uQytF/QbUpYzrCNymN6VnADTxfu/kuCw0DVkqF9/sPQFpV+hw46bpoH3a8ExSdw/fdBi9iMEnKy8qFxEN9NSqGYmEopx8alYTlkTW4yDaiR00/dduQGqi+928KFphMtQUNpeuUyZEYtR/E40o0BmKUfLrpDaKthl9wcMFSUeyb7UfHwB1wlNOXxaMit0qxPUVUSAHZIO8g8iJ8M1dV7EGj/pkn3F6uS2xPPTZ9cqcJLohOp3cw/6CJaFIZKt7TUZ9I7n4onIcN9r/lk+ePWGZhpFsldZd9GWDiNM0Kw3mkP+4MzwZLEnl5aRd64He7NNB4IsjJXrJP8AHHm17qGQBoZ7TSs+fpCH2/a1W9ajfXaXjuN43O+/sK6717DGQ+u9dBGH+MMK36k7usUK3poEt9hF8IaLwdCXhecSbYNFBwA2AvgWIg+nISXjckg9bFwrfliaBZeIMHH6Sulwa9KnLYIdl4B3q3y2Z/wReSuK3vZmdm9Tg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(39860400002)(376002)(136003)(396003)(451199021)(82310400008)(40470700004)(46966006)(36840700001)(40460700003)(82740400003)(86362001)(356005)(40480700001)(81166007)(4744005)(2906002)(6666004)(7696005)(47076005)(2616005)(426003)(16526019)(186003)(26005)(336012)(1076003)(36756003)(5660300002)(41300700001)(70206006)(70586007)(316002)(4326008)(6916009)(478600001)(8676002)(8936002)(54906003)(83380400001)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2023 19:56:47.6915 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 61ec200c-60da-4396-912c-08db8c801d58
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT021.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5163
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Prike Liang <Prike.Liang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Prike Liang <Prike.Liang@amd.com>

Add to IP discovery table.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 910eb9ffb802d..59ed6d4ebfed0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -2447,6 +2447,7 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
 		break;
 	case IP_VERSION(6, 0, 0):
 	case IP_VERSION(6, 0, 1):
+	case IP_VERSION(6, 1, 0):
 		adev->hdp.funcs = &hdp_v6_0_funcs;
 		break;
 	default:
-- 
2.41.0

