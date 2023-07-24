Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9045DEB64DD
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Jul 2023 19:42:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 18DBC10E116;
	Mon, 24 Jul 2023 19:42:12 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on20604.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5a::604])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3D75210E116
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Jul 2023 19:42:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fkh19mWANkK8+LEXPd5awpoB3liq2djHWm0If/fsWhM787hAzpG1SQ4b+3pnoukjTcwHKfukw1nNQoRuJx5OHFKqtW2VyPVoRilv/UJebxtwwGuhrBRfg3hwqeDC7jCpBszocVK6PJpVxFbDGFAj3DPtlkkR9H9reY9sBs4kAMgMNbrj9kMNMsIPKFsnQ7lm/uAWNOiTRuv+EPQbXKokpf+r7OZVgeKnGbsPniTMQxr6qsS0dpN5h6xNa8v7/G+gTU8vIv6L3fxXb6XCIqLLcmBaStQHmn5wAhMV+URo0cSJuZWRB37DOcdt2uH1129IgAj90snuIxDvUyGJ1jxltA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8bDvvzHzqVjKmtlZRPKFx3PMNyehsjy8TZPrZhKfBp4=;
 b=Fx+RtryyckOhZlN9mhSVL1l6isQnpMH3FFSY7sCBwgD0aYLWIx5IAWg4ZzhPxeZ7GSICmqy6eHVUQcPEJeGfjs17F5BJkvSN2+IOSsI73BlW+63HfKFNDuq10iqdbwllLWKmYReo+PTeo3G7JcGnwHBaifCKwQ+wNTT+HUnjhz9k8llQ7upX0iXcJvehdg4PqkIBqCz1Q4wexNW2YRgXmcrHmcW8VeAHLALrdYHhLr/TAEC2H6Te2oDtyxg+O5agrodko7dBB7E/RZ/nUo+av9u6hrVifkEiYviUP5iJRqwZf2WefXU9gOh7FXsQinvGC2W3q238QL2N/XXwppawcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8bDvvzHzqVjKmtlZRPKFx3PMNyehsjy8TZPrZhKfBp4=;
 b=r1TgmfLolulbAe4WptmyOnyzXvkUHEUlzM6fldI6phhAWaEflgIzoTa7dF+ZXDJ0Kedau9nZ55sSYiei8C6Dx6fddPUSFTgsZlUV0whHO/7YkzN7v4gHP7FT+ur00abMxLeKWWlSutCx8kr4BbmyTZlSUKd2SkHXJERl+11QPng=
Received: from BN9PR03CA0368.namprd03.prod.outlook.com (2603:10b6:408:f7::13)
 by BY5PR12MB4321.namprd12.prod.outlook.com (2603:10b6:a03:204::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.32; Mon, 24 Jul
 2023 19:42:06 +0000
Received: from BN8NAM11FT073.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f7:cafe::b2) by BN9PR03CA0368.outlook.office365.com
 (2603:10b6:408:f7::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.28 via Frontend
 Transport; Mon, 24 Jul 2023 19:42:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT073.mail.protection.outlook.com (10.13.177.231) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6631.24 via Frontend Transport; Mon, 24 Jul 2023 19:42:04 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 24 Jul
 2023 14:42:03 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] drm/amdgpu: add PSP 14.0.0 support
Date: Mon, 24 Jul 2023 15:41:45 -0400
Message-ID: <20230724194146.763713-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT073:EE_|BY5PR12MB4321:EE_
X-MS-Office365-Filtering-Correlation-Id: 43204571-4fee-4689-0ccc-08db8c7e0f1b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: v9U2TitzSK4VYIQF0K7xBFeeoogbjXJ/L++CaADG6tYcRxdfm9TTtKwx9UMSu2phaATHhg59SevB0782OPAovwSM8OFHB/p73EDf10rMauTshB2gkfnCv6BgQZnv29OhXW0gcztplYgGerZfkujneTOS5BujykIgYck1TKN4o5g+j7Mwl1co4vh7xYKxxMSawvctGlGyGi1i4VrCWnCKD9C7kQAV7DDdBYgsipZ2uvYIydtx21u0RvRos8lmjtKIjWqKlj3/l2QOUiUh6nWfqh/NYXRf9GmuV4m02ebx2/sstPb5mE88hC/YdvKNXF8x7OJBdpnKfB0ouI1LZzizhWPmjaIP8WOIS4EXvYaj+KAkR0jF9OA6N7MqfszREA4LbCI8Xp+N+ZF+cnh1+HtgFga9yiAMij2QrFc7koVCgnDrXdN4S8TpC6jS1T1ZHyhtZXyjT9B51uOBNkWBoCzCCSFTvLhpXDw4aF0O65CbE+ZNeH4ZOmrHXreBBKsTrEoke0Pp3Nwl1vtVaNaLJCM/L4KRSRjDnjpWYrY1NQ8qqR81EiNlbDDkEYTgV03w+udlo9CgDdJDqVygmOPAp7lItQ8/84w7LjCi7le180of7QC95Za1kCUWA2iND8/aUyCsWEy6TiTmclMIdNJFIW/hwU+FwVzdFQXyCTtinUvAZ5sIY1Q5SOUWPM5umDzCBNhJG2iIYLsCI//H1klQxU0b9lKXtdGFWv8srGF0ABhpxl0u0ljeBlZGFGDeXWrN3rV/XkWTW1TSFqdYZeQwtZvlIQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(39860400002)(396003)(136003)(376002)(82310400008)(451199021)(40470700004)(46966006)(36840700001)(70206006)(6916009)(70586007)(316002)(4326008)(54906003)(8936002)(8676002)(82740400003)(41300700001)(2906002)(6666004)(7696005)(36860700001)(16526019)(47076005)(426003)(26005)(5660300002)(2616005)(336012)(186003)(1076003)(478600001)(83380400001)(40460700003)(36756003)(40480700001)(356005)(81166007)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2023 19:42:04.9943 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 43204571-4fee-4689-0ccc-08db8c7e0f1b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT073.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4321
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Li Ma <li.ma@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Li Ma <li.ma@amd.com>

Uses same driver interface as 13.0.

Signed-off-by: Li Ma <li.ma@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 1 +
 drivers/gpu/drm/amd/amdgpu/psp_v13_0.c  | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 6ffc1a640d2dc..4e428060a1fa2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -202,6 +202,7 @@ static int psp_early_init(void *handle)
 	case IP_VERSION(13, 0, 5):
 	case IP_VERSION(13, 0, 8):
 	case IP_VERSION(13, 0, 11):
+	case IP_VERSION(14, 0, 0):
 		psp_v13_0_set_psp_funcs(psp);
 		psp->autoload_supported = true;
 		break;
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
index e1a392bcea70d..d23827d3d8cca 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
@@ -50,6 +50,8 @@ MODULE_FIRMWARE("amdgpu/psp_13_0_11_toc.bin");
 MODULE_FIRMWARE("amdgpu/psp_13_0_11_ta.bin");
 MODULE_FIRMWARE("amdgpu/psp_13_0_6_sos.bin");
 MODULE_FIRMWARE("amdgpu/psp_13_0_6_ta.bin");
+MODULE_FIRMWARE("amdgpu/psp_14_0_0_toc.bin");
+MODULE_FIRMWARE("amdgpu/psp_14_0_0_ta.bin");
 
 /* For large FW files the time to complete can be very long */
 #define USBC_PD_POLLING_LIMIT_S 240
@@ -94,6 +96,7 @@ static int psp_v13_0_init_microcode(struct psp_context *psp)
 	case IP_VERSION(13, 0, 5):
 	case IP_VERSION(13, 0, 8):
 	case IP_VERSION(13, 0, 11):
+	case IP_VERSION(14, 0, 0):
 		err = psp_init_toc_microcode(psp, ucode_prefix);
 		if (err)
 			return err;
-- 
2.41.0

