Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56A5EC47422
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Jan 2024 07:04:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C052610F65E;
	Wed, 24 Jan 2024 07:04:42 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2086.outbound.protection.outlook.com [40.107.220.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CC5EE10F659
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Jan 2024 07:04:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FwEtmTlm9n2lO+7Nekpv/gM3N+vQNHG1t6hVdn2TXJkVp3xV3ojFEvj7rNRg31yq78YILjdCPhMLeJylEgPchNwwb1VLAwQRgSQG4FjmCn9gZM6VtU07a98AitJEvSmoHFvmZyP9c9Kz7SkO99g/4adpN/55mT4uUL4vbOkdOzdgt3mAkay9h4EO6MucQ8/14gNFuueC+yepE8jVE8aV2wzXWOjvVBxI4498pEO9eGIVdhPgkqEDrgNQROV1D+azIA9YPbUqG+N2yqlRpU4mhewAVQf0/2A1ZGhsrwpYRDVAMcpnMif9ILiXYulpBGXNuiebV7y/tGBveE2/ZxOfYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WZ9oLhM/FFwiTkMy+4guAtqnmUzMGMvNIgXfYrND9Z0=;
 b=J4trDOppfQD8F5CmCreQWBQK/UKtrRHN2tWjpPlce16NdwcOgpCEuW+NlqYvgeWAjegU4XvR4wOKzoVR64xmho3IDrCA0VbpA4jR8I9mW7lJBE6NpDjEDMI2P89EtsOnvlBxNJEf0sm9YrWPSuXMg1nSvmuIbp8PyVTAoKxUj9YmzY0tg/AllouPAYfozYaQ0Qegr0HhrCcu147nYmhIKUMw0swQdNQsMT1uE3OYCEGImUPwCgVX4PVFwgidAx2ozlUobshFQf1zzPMUL9kFJp5rt/OhdbYm1nBJQzRGzRG6/P4rCJlZ1G+P7o4lXAIUTWCPhEHzyaroLEB7CfLsig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WZ9oLhM/FFwiTkMy+4guAtqnmUzMGMvNIgXfYrND9Z0=;
 b=JkC+KEr+VeclJyyrb8ejsQz1NiA8nolW6GHA4dq4+u05VRf98m9tiA3aF8qKJMSrNvWsHmh/l0/mPOYtUceX7e3CBOwYV4/kV3bTmByfF53wBS7ESKUzGPVu1SYvy+wmgHVdHSItPfSJKuvW0D+qccwmyy8SYl/nYKvuP8ulX7s=
Received: from MW4PR03CA0179.namprd03.prod.outlook.com (2603:10b6:303:8d::34)
 by SA0PR12MB7004.namprd12.prod.outlook.com (2603:10b6:806:2c0::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22; Wed, 24 Jan
 2024 07:04:38 +0000
Received: from CO1PEPF000044F6.namprd21.prod.outlook.com
 (2603:10b6:303:8d:cafe::bd) by MW4PR03CA0179.outlook.office365.com
 (2603:10b6:303:8d::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22 via Frontend
 Transport; Wed, 24 Jan 2024 07:04:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F6.mail.protection.outlook.com (10.167.241.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7228.0 via Frontend Transport; Wed, 24 Jan 2024 07:04:37 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 24 Jan
 2024 01:03:56 -0600
Received: from tom-HP.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.34 via Frontend
 Transport; Wed, 24 Jan 2024 01:03:53 -0600
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 21/22] drm/amd/display: [FW Promotion] Release 0.0.202.0
Date: Wed, 24 Jan 2024 15:01:58 +0800
Message-ID: <20240124070159.1900622-22-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240124070159.1900622-1-chiahsuan.chung@amd.com>
References: <20240124070159.1900622-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F6:EE_|SA0PR12MB7004:EE_
X-MS-Office365-Filtering-Correlation-Id: 36acc281-d6d4-4448-b706-08dc1caaba94
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bt31NPiclBQDrQ+DU+zimeGNSqKf/nOBq1maISJzyq2yf+XxPe9uDkQEriGnBJqMOgr+XIFOw0ecPLsGVrWjSHoEOJQ/fiM1c2LLv82T4ohdAhMFrSSXL8r6J5N64/BLAcL6ZpC2Y+r8UVJwYEHFnsYjQz4IscST0r2JaG60S3+YDMdMB+1mqYUyC15CNFiR5NjskfdM9KVwS5pxJ+QvynAdo503OWEQPXP8MbK0e1NUtHq028iqJ7jHCNDzLe0n+ux/yZ68sLKJi7ChvsNV9dG1z128HaDDOAk81wh8HknNOtEl+XfpywggXdZlDJCHPZV1TZWMy7wZk+86MqDfg/kh2pmkgSkflp4vVM0VEIzD0OCMNEZIATAfDb1tnBF3L16GCX46AoJF9IbNBTQz7DJZp6zblOrXMKEvHa++I/SLOlniO8YYD5lZFKRQCp5oUCbl4wOsuzeJJwEJHQu4/KVmeaXcH4GFKoEM4ks9Smz8biMyw/k0N6zNWLz8VHJQzQE8XLq8vK4Mh/mRk2uX23voZcIthifqV3yCc+OPzfqjAt57hIjgt6tE9EAV5vNzv5tWB8KsGqz3PEtX31qBbMoqx5ZfieO+IV/YYyP1B81h5r4MAgoZFMQrfTBtzGLLHPq1rnxJjcWI0UCJ+Dv1IIkoz4/Fp4z7fKTgO9UQdj6DXocAgG5B+cfjyOJZ6k1NRZfYiUVqk+Gu+pvhIzQUCypZ5RZcp6uyrwYBmqgPyg9Ls29UMvrNvLQn3cGQAdwSFS/qMpI/pmqvoZhQMYTqQw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(376002)(136003)(396003)(39860400002)(230922051799003)(451199024)(64100799003)(82310400011)(186009)(1800799012)(36840700001)(46966006)(40470700004)(8936002)(8676002)(4326008)(4744005)(2906002)(5660300002)(86362001)(316002)(70586007)(70206006)(54906003)(6916009)(36756003)(36860700001)(47076005)(82740400003)(81166007)(356005)(7696005)(478600001)(83380400001)(2616005)(26005)(1076003)(426003)(336012)(41300700001)(40480700001)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2024 07:04:37.8531 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 36acc281-d6d4-4448-b706-08dc1caaba94
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F6.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7004
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
Cc: chiahsuan.chung@amd.com, Sunpeng.Li@amd.com,
 Anthony Koo <anthony.koo@amd.com>, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 jerry.zuo@amd.com, Aurabindo.Pillai@amd.com, hersenxs.wu@amd.com,
 wayne.lin@amd.com, Harry.Wentland@amd.com, agustin.gutierrez@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Anthony Koo <anthony.koo@amd.com>

 - Add control flag for IPS residency profiling

Reviewed-by: Tom Chung <chiahsuan.chung@amd.com>
Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Anthony Koo <anthony.koo@amd.com>
---
 drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index 49bc1e41ac67..aaa211c828ed 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -408,7 +408,13 @@ union replay_debug_flags {
 		 */
 		uint32_t enable_ips_visual_confirm : 1;
 
-		uint32_t reserved : 21;
+		/**
+		 * 0x800 (bit 11)
+		 * @enable_ips_residency_profiling: Enable IPS residency profiling
+		 */
+		uint32_t enable_ips_residency_profiling : 1;
+
+		uint32_t reserved : 20;
 	} bitfields;
 
 	uint32_t u32All;
-- 
2.34.1

