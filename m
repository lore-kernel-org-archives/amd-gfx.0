Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BC67C48BC1
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Feb 2024 21:33:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A69BF10E467;
	Wed, 14 Feb 2024 21:33:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wq/wQcaA";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2060.outbound.protection.outlook.com [40.107.101.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EA92710E467
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Feb 2024 21:33:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jqNvBOEAl45ItZY1KKQpYjCutDdtoO4wuxGIM9jk2hgTh1YNzQbKsbZKVAHDUfb5RUoF1T8oWXqsrqcbiF3t8Ug3j7tMVY6eNYzOxwLzxUFV6XE7ncNSaC9swJAUsTh9947q2hyYKxyY7i6wCWj6jgY5S99QVS/PRZ3+/gzQ3E4mQH5ptZWeMt5WB7xtqmhWQjNVveNM5HmJ2+mG9HMR8xCuyK63wsiXhmgAj45GHrz4hj2tS9lsy9r1h5j6hszG9VekTzvYwmmhL6RbcTtv2kSmlyThZfhZsc/9ahjBAPoO6o0VkGlIfkFNbNMfgn4uq0437zS4memqtIV+nr4Ivw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fsitz6NQTVFsV6ihCQKn73TwXLZ+EP2/8NqaBBmsA9c=;
 b=dZDgzsOJxwBaOZ078wc2hKGdPhE0n6rBwKfyaEyr2r2m0w8QETwTZovJRS58AhDk4YcTI8yyjOCM/v0A3RMShEtDo75xtoefpP/UOFpxsmLBJK7g5yvi1sMsR8u/x+BmeZH6kXYqYTk7RppD+B2RRIlx3GUJUhR5CBCYMq0OpUcRpSAr4jOFD0Kym0BOK1FUijMv+6t+jSNgI8iLfljQKwvlccg3Dns8AXFkHbiXLF2IHrd1OV6uqioStd/IgKOYdsRv4ABU3QTmpg4RgNKgj7js7kCQc9SSSjnH1kNxkXX1e43OuvV/abSy8YY/NewcfywdpZmtp1EU44v6HjlDmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fsitz6NQTVFsV6ihCQKn73TwXLZ+EP2/8NqaBBmsA9c=;
 b=wq/wQcaAvxxDCwlBpCzLGq61Quz7sLYWmxN5ArgcxJWYPQGvrsHSVvoohI9DOCTN4IIbUTy1uT3AyJg7+L3cnl9kdJSLPJKZjSY5bf+Cq3DcfJ3sygI3QoE+4PAmUNSMyRmVrE1B9D9ZinZ4S6lTJY4f5iwYpzCz+1NKF9+c7MQ=
Received: from CYXPR03CA0053.namprd03.prod.outlook.com (2603:10b6:930:d1::21)
 by CH2PR12MB5004.namprd12.prod.outlook.com (2603:10b6:610:62::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.12; Wed, 14 Feb
 2024 21:33:10 +0000
Received: from CY4PEPF0000EE33.namprd05.prod.outlook.com
 (2603:10b6:930:d1:cafe::76) by CYXPR03CA0053.outlook.office365.com
 (2603:10b6:930:d1::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.41 via Frontend
 Transport; Wed, 14 Feb 2024 21:33:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE33.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Wed, 14 Feb 2024 21:33:09 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 14 Feb
 2024 15:33:08 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Yifan Zhang <yifan1.zhang@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: add smuio 14.0.1 support
Date: Wed, 14 Feb 2024 16:32:53 -0500
Message-ID: <20240214213253.2592038-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE33:EE_|CH2PR12MB5004:EE_
X-MS-Office365-Filtering-Correlation-Id: f2ee7cb1-4079-42b3-d7fa-08dc2da48a4f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0wKQcH8WJzd1FdecRkKDT3qwpUPddY4SQkOGRhGYfzUVowtXD5hhpD+ZStxD1ywE56agMVR+RTURhgBQ+BEWzCtU1T5ZuQCff9ds51VNkD2xKubF5AnosAXLqGt4tMQzzBLe6Q/JDGX55FrzLVa7Qf/cf51QJ8M4GTL03qEFagPklX4RMoTRSFYGTIc7uV6tDJ5/2k1lQ8QJvujckD/nVlb+BCpAPLZdIHXUKp8hnb/iVtTuvODnO46RMNV+tR8JEL/3JMeSqLJ0D8fe0R0yJsdUz1NMkZaug0p1Pi1u7hkujiO2rwIDy69Yk7jJW2b+D1Ik5ijpye3uxDjHPAMXKnnSepHp4QfLT6FCXPKdZuJjkzsB5nwcnVnWE36YAJ/dkknCbWvorxD4/a83yRmMqbp5pCqfPbWQsZyP8BcMbX/jswT4zOd1dbEBr5cap3F9qWtF94lWmGX2ZOBUngxnP45co1UNnk4njsUW//IBKd5DTZsrCeIG+w/ZTUG6/ybzTXGQLlEnKfe/+DNEFERF3RspGDLn5bOR8JXjM9F/U5FgyDYGclVCvpsXaFrecCNuy3zrVbGV6Jl7jP2M3+eXVK8pdNFNIL+lUJ2VqUAkDhzMYR8rYqZLD27U4kLY+malJKWVNTfeRgmQ+ybsy2LcoStoNi3pKozAmc46tCD2PPI=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(39860400002)(376002)(346002)(136003)(230922051799003)(64100799003)(1800799012)(36860700004)(451199024)(186009)(82310400011)(46966006)(40470700004)(4744005)(6916009)(5660300002)(70586007)(4326008)(70206006)(2906002)(8676002)(8936002)(83380400001)(26005)(1076003)(16526019)(316002)(426003)(81166007)(336012)(82740400003)(356005)(36756003)(86362001)(54906003)(6666004)(41300700001)(478600001)(7696005)(2616005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2024 21:33:09.7048 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f2ee7cb1-4079-42b3-d7fa-08dc2da48a4f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE33.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB5004
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

From: Yifan Zhang <yifan1.zhang@amd.com>

This patch to add smuio 14.0.1 support.

Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index f6bd8a57f1cb..196446ca7275 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -2648,6 +2648,7 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
 	case IP_VERSION(13, 0, 6):
 	case IP_VERSION(13, 0, 8):
 	case IP_VERSION(14, 0, 0):
+	case IP_VERSION(14, 0, 1):
 		adev->smuio.funcs = &smuio_v13_0_6_funcs;
 		break;
 	default:
-- 
2.42.0

