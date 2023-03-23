Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D54F5C6FD1D
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Mar 2023 08:34:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6704210E2E5;
	Thu, 23 Mar 2023 08:34:55 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on20630.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7ea9::630])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DD37510E2E5
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Mar 2023 08:34:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jZKl5nE4ECZUYbv6dnBtYQGenksu4liOGtEJ7K8fAuM7M/7+3meFxSPKDcgk8Jnvzls/fikequ4IKpXIm5Y+kqsOMQjjXSQRDp2iK+lvZpd/fod0f2/PYGmVbLcOlZIr5Joaxh1T4i9znM0FhtVjESesN5DMACT4W/Xn4IDlpR32HrgB6TBUlK+i7kLw4Q2ncMehX6websuMrdiljgRMIaKxXM34ULy0SSMZwIJiPfQ3RjzjmE8XJ5ZgVRnRzqKKd24vI3LYoQmMBduRQNKKBbLK/3GhhDOAk5lAT3ebjXunLs9UB158AIQhSIDzkz5Hf3Py6t7iKH+8uJ/fTEfqFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dPnuxy3FiB/Xe+qeprdLp6+boxejNBllAQPxwzvMtqU=;
 b=Rzvs0AnUSBwSyYo5neORSCuHIf8G5J6Ozr6lcjYf8QlaoxDK5HuZoL88S9cYB50h+wiyWBe/pRDqN6hiFPOM6J4gowDNE3Qplkwh07OiCVZSZv/isqRwKU7w4aPb1k1sQU60G0KdLEIMlMNgNxloaSFJwjcx6b9nXtgb/INaaLTRAJy3F7A5At1aeB1vbW5w7Aw+bsy8uqfK6SQOBqkvh5Hvxepa08X27ghrTdWODGIg8kQpFaAlF5Wfa5T+O71lD1eWR5ZDVhTiq5bDWoG2thOvtnhFzYR1XfaUQKZTLzvGEb9vjpKUqXNmZe2pwMdlDLTlkkKv0YWwVoAm19HlSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dPnuxy3FiB/Xe+qeprdLp6+boxejNBllAQPxwzvMtqU=;
 b=LVVqZFsY5uVi3Is1dRX2aCJ3Pdytwco+lPgaf3LVUWIfNCYJiiQzSg45vpy0TUvjMLv6e76iSAF2aj4kDas9VjTFLrF7Tn4fbuG0ujXq6POcCoQeV4gCxXOxtG95/J5l+OmDWOZ8q+4QT1EdZMpx9RY+TrsMXx0/eVTCDymcb/I=
Received: from DM6PR14CA0062.namprd14.prod.outlook.com (2603:10b6:5:18f::39)
 by IA1PR12MB6186.namprd12.prod.outlook.com (2603:10b6:208:3e6::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Thu, 23 Mar
 2023 08:34:50 +0000
Received: from DS1PEPF0000E630.namprd02.prod.outlook.com
 (2603:10b6:5:18f:cafe::cb) by DM6PR14CA0062.outlook.office365.com
 (2603:10b6:5:18f::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38 via Frontend
 Transport; Thu, 23 Mar 2023 08:34:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0000E630.mail.protection.outlook.com (10.167.17.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.30 via Frontend Transport; Thu, 23 Mar 2023 08:34:50 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 23 Mar
 2023 03:34:49 -0500
Received: from bliu-X10DRi.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Thu, 23 Mar 2023 03:34:48 -0500
From: Bill Liu <Bill.Liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Alexander.Deucher@amd.com>,
 <Hawking.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu: Adding MES engine reset in SRIOV
Date: Thu, 23 Mar 2023 16:33:38 +0800
Message-ID: <20230323083338.249117-1-Bill.Liu@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000E630:EE_|IA1PR12MB6186:EE_
X-MS-Office365-Filtering-Correlation-Id: 08e33ff9-2d5e-415f-4980-08db2b7977b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UdDqYX/ap1OTYzPxRwPRpC5dpKTpMcEUe/YWep+yGmdNmjNxmMPwNklZ2KY5xj+ncmTgYUdEj7PLPFzq0oPM9O14WboDDXvLcm7+a7IOvtpkv2wM4wDgCK0NiFpVdBWpfYJone3zKHcaE8x+HduWJDU5A3a/CxGACt8sDd2+Szclh6J6yBJY4//lnVRTok5qVJMMYikERTvGC6aQR0qBi4S9HAw7fJBwPXxCoZJwY/4qTowheMDSnFn4vvVE106nfNfStbNwg+q+e5ZByYSRifraMSOGiAqrLxLRj49ebXSyuzShS+chooNs04GASfmkN3wpwVj6O61Bt2NevWGgG4zJq+FODhRS8eoOy5DjH7ysmmoXlvkuItkxbl64YTKT3uy16RzkQIdLKJ19gHqKlfwoS1Dd29yYZBIpha0YPkYfGcukfOX3gLQWUZPqNX7UF5WWO/bHjTcRCqvWG+dCqzkJGECahjPzEDzRPbwn5G4/Wav+HkOlD6CvkhK11yYqWrv8lHbvtQj8FaiXsVbj1n+0t5wEdlVVj3D0W2nJRQirZeV5eROtgH3GJQcXsGQ/UIzg7OO9CHHoekeOG3Mb6dyV+G0PJMBgSYYlCLBXxFSMC1eMxNF5pf+3g5k5gnzIH7gj154qbTrZk2QtSLUvW4syDM+mrpOFTmU75oZGLM+YfT61SYEzLcy5chDfH/CO6idGaIcp+D0hAUDaIqAO/sVozuVTURzn3UwsHwH5zMWug5TishqfmrOoxUd4NpiX
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(136003)(396003)(39860400002)(346002)(376002)(451199018)(46966006)(36840700001)(40470700004)(47076005)(426003)(186003)(6666004)(7696005)(336012)(478600001)(26005)(83380400001)(8676002)(6636002)(2616005)(110136005)(316002)(70586007)(70206006)(54906003)(8936002)(4744005)(5660300002)(40480700001)(41300700001)(82740400003)(81166007)(1076003)(36860700001)(4326008)(2906002)(40460700003)(356005)(86362001)(36756003)(82310400005)(2101003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2023 08:34:50.1879 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 08e33ff9-2d5e-415f-4980-08db2b7977b8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000E630.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6186
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
Cc: Horace.Chen@amd.com, Bill Liu <Bill.Liu@amd.com>, haijun.chang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Added AMD_IP_BLOCK_TYPE_MES to the list of engine
under amdgpu_device_ip_reinit_late_sriov, so that MES engine can be
correctly reset in SRIOV environment

Signed-off-by: Bill Liu <Bill.Liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 065f5396d0ce..0d9061151048 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3183,7 +3183,8 @@ static int amdgpu_device_ip_reinit_late_sriov(struct amdgpu_device *adev)
 		AMD_IP_BLOCK_TYPE_MES,
 		AMD_IP_BLOCK_TYPE_UVD,
 		AMD_IP_BLOCK_TYPE_VCE,
-		AMD_IP_BLOCK_TYPE_VCN
+		AMD_IP_BLOCK_TYPE_VCN,
+		AMD_IP_BLOCK_TYPE_MES
 	};
 
 	for (i = 0; i < ARRAY_SIZE(ip_order); i++) {
-- 
2.34.1

