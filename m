Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9410BC4332F
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Nov 2022 05:53:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D0FEB10E37D;
	Tue, 22 Nov 2022 05:53:04 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on20604.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eab::604])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E486C10E37E
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Nov 2022 05:53:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hujY1PNdJ4O36MyPLPiRNoLNpZ8n1tCniojhvUonUyHFZ45o0E15hGMi69+zhEf88GpsUXsq8Pdn7wzFV3RbuMGV/zIYmGsC7hW8MTCBE7jNd61f908X3DCmhA05HaJP1X1pOf5MmwGmsXAaw8sPSbJJDWvK+rt/ior0bCRfGfmHt6XJyQMz8FaWyJS/yaHwuGO0YbJi6QVenFBhkhP8l1OsHaynsI99lDmLr7F7udVxLFGyUICN70jXyhPP7mQM47xG2b2i1fQMzq2ZaqthJNSpDcr3/2XOfSH5Ff03u16+amiUJswr0+OflODGWqL3Ap3jmZbDf8Ec3ICTkoOVDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z7XZPPNTwVDTgUmYXdst7TnnX1D1u+KgbaldailPu7Y=;
 b=IWlCVwkcgf1JLoYH85SPAra/GmrDieVYGxmZ3RwQqnmVcL0KNYGCp6mq8KeJF1s0QfFjpjyGj6of66PlBr/Vc8kTI6dNxxi7q5APRidHC02JrGSooS2wE3CyGPzidwIxbIFkV7hZM4Tafl8vt8btsCGE7uW6SL8ABT78fboU87mBhUKnTTNRHHN8Rs455CU2iIqE1tIucJ/wxj7Oum1qJQr2iVI8hj1rHGaHsnnTZOBUsu/JPl40XwHUsQGBwtEr1RuPld5NCCz4g6EUxe1bqpBGdjqZZBzbe6e381kEoc0rYNnrcLzdIFoH8+DZR/xpnVxizahja6JtvPBvwjDPXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z7XZPPNTwVDTgUmYXdst7TnnX1D1u+KgbaldailPu7Y=;
 b=im8l9riEz86AUwNT/tZTdjTyy4jhz4n0aAnMKrf32Ck0S0Y9vf4CNJv+XOqsm/FXgMeZyw2cPbet3I0sVSfeUEN+IfEg1Gc7q5gxyM9p6GsC1zpMYYTxuzCcEA5+iaIzVlPybhaF0GDhweOA+BLz4JWR9nWQPm+d0HGkpkIrX18=
Received: from DM6PR03CA0074.namprd03.prod.outlook.com (2603:10b6:5:333::7) by
 BY5PR12MB4887.namprd12.prod.outlook.com (2603:10b6:a03:1c6::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15; Tue, 22 Nov
 2022 05:53:00 +0000
Received: from DM6NAM11FT029.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:333:cafe::9) by DM6PR03CA0074.outlook.office365.com
 (2603:10b6:5:333::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15 via Frontend
 Transport; Tue, 22 Nov 2022 05:53:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT029.mail.protection.outlook.com (10.13.173.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5834.8 via Frontend Transport; Tue, 22 Nov 2022 05:52:59 +0000
Received: from yifan.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 21 Nov
 2022 23:52:36 -0600
From: Yifan Zhang <yifan1.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 08/19] drm/amdgpu: add gfx support for GC 11.0.4
Date: Tue, 22 Nov 2022 13:50:14 +0800
Message-ID: <20221122055025.2104075-8-yifan1.zhang@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221122055025.2104075-1-yifan1.zhang@amd.com>
References: <20221122055025.2104075-1-yifan1.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT029:EE_|BY5PR12MB4887:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a5181f0-bbe5-480d-4d31-08dacc4dcff2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iPY39QUCiA+MqreEIPmQe74eZmnb0k3+iZs/J1fBWOo2PSZwC/HpBjUNA4JvJcjqWZmFKreoPJK+X3zGQy7Ej9sm+tdAXJsqwila8mQvqAqfi5NFS+Fa1DWwDyfc0PieFcXJ1sOQ4TP7A989QPPrZFIW/3aIN6dotQtYdqpBaiuqv4UGka/CvzncE/ZAMxM95bhLLfL2sOAQbWixWdEz+AMvx8MJzH2/KguNyVv84AMmxkRsejUYgE0ie+Pu+DVkKd7RI2kPsZNWUmD5JWDluDV38Jyh3BxHinppDddQZSuFTX27YesNN1stSlb1+Hb71Yk3+ekadWED5LlbnsHfDpa1RzGwFTyzmsvZyPV84+2LWZYVOYFE1n94LDZvlqPd2ZQtpBR+u+sXFbDwzMG4wh6eV4UZul4KXThg3fHCsNABjFcS3PdBypPKfmyzP0mVK40cZxnIeK0ndWMxmm7dTu2iJ5lfZ27VaMNTZ/xHKhr2aYj8B5TuR0p507ZYpxWyJpEZly8KneYENvPN9niPpTtMzrpbbH0tuc638xb1NGWgzsBaNMhaHHNOSkb47UR9tQBBhoqIzttrzA9y/lxtCzxZTwlpuoBJWwhCg66tqILwoQaQBykOwKM4NKCSG1wf7ei8YIHkm+gLZNa9lDcR2aV7Lzf5QZCi2J7LNIr1fdyW28jQp75I5ETZKsjwFrrnMdjVuyLR43xXLtBBBCrgXA/Irlaj8v3/nY+XUZRj3Xg=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(39860400002)(346002)(376002)(396003)(451199015)(46966006)(40470700004)(36840700001)(36860700001)(2906002)(40460700003)(1076003)(70586007)(2616005)(70206006)(41300700001)(40480700001)(36756003)(82310400005)(86362001)(4326008)(7696005)(6916009)(54906003)(356005)(83380400001)(81166007)(426003)(82740400003)(8936002)(47076005)(5660300002)(16526019)(8676002)(186003)(478600001)(316002)(6666004)(26005)(336012)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2022 05:52:59.8876 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a5181f0-bbe5-480d-4d31-08dacc4dcff2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT029.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4887
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
Cc: Alexander.Deucher@amd.com, Tim.Huang@amd.com, Xiaojian.Du@amd.com,
 Yifan Zhang <yifan1.zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

this patch to add GC 11.0.4 gfx support to gfx11 implementation.

Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 9d2c6523f546..bf78440e1e70 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -77,6 +77,10 @@ MODULE_FIRMWARE("amdgpu/gc_11_0_3_pfp.bin");
 MODULE_FIRMWARE("amdgpu/gc_11_0_3_me.bin");
 MODULE_FIRMWARE("amdgpu/gc_11_0_3_mec.bin");
 MODULE_FIRMWARE("amdgpu/gc_11_0_3_rlc.bin");
+MODULE_FIRMWARE("amdgpu/gc_11_0_4_pfp.bin");
+MODULE_FIRMWARE("amdgpu/gc_11_0_4_me.bin");
+MODULE_FIRMWARE("amdgpu/gc_11_0_4_mec.bin");
+MODULE_FIRMWARE("amdgpu/gc_11_0_4_rlc.bin");
 
 static const struct soc15_reg_golden golden_settings_gc_11_0_1[] =
 {
@@ -262,6 +266,7 @@ static void gfx_v11_0_init_golden_registers(struct amdgpu_device *adev)
 {
 	switch (adev->ip_versions[GC_HWIP][0]) {
 	case IP_VERSION(11, 0, 1):
+	case IP_VERSION(11, 0, 4):
 		soc15_program_register_sequence(adev,
 						golden_settings_gc_11_0_1,
 						(const u32)ARRAY_SIZE(golden_settings_gc_11_0_1));
@@ -855,6 +860,7 @@ static int gfx_v11_0_gpu_early_init(struct amdgpu_device *adev)
 		adev->gfx.config.sc_earlyz_tile_fifo_size = 0x4C0;
 		break;
 	case IP_VERSION(11, 0, 1):
+	case IP_VERSION(11, 0, 4):
 		adev->gfx.config.max_hw_contexts = 8;
 		adev->gfx.config.sc_prim_fifo_size_frontend = 0x20;
 		adev->gfx.config.sc_prim_fifo_size_backend = 0x100;
@@ -1284,6 +1290,7 @@ static int gfx_v11_0_sw_init(void *handle)
 	case IP_VERSION(11, 0, 1):
 	case IP_VERSION(11, 0, 2):
 	case IP_VERSION(11, 0, 3):
+	case IP_VERSION(11, 0, 4):
 		adev->gfx.me.num_me = 1;
 		adev->gfx.me.num_pipe_per_me = 1;
 		adev->gfx.me.num_queue_per_pipe = 1;
@@ -2486,7 +2493,8 @@ static int gfx_v11_0_wait_for_rlc_autoload_complete(struct amdgpu_device *adev)
 	for (i = 0; i < adev->usec_timeout; i++) {
 		cp_status = RREG32_SOC15(GC, 0, regCP_STAT);
 
-		if (adev->ip_versions[GC_HWIP][0] == IP_VERSION(11, 0, 1))
+		if (adev->ip_versions[GC_HWIP][0] == IP_VERSION(11, 0, 1) ||
+				adev->ip_versions[GC_HWIP][0] == IP_VERSION(11, 0, 4))
 			bootload_status = RREG32_SOC15(GC, 0,
 					regRLC_RLCS_BOOTLOAD_STATUS_gc_11_0_1);
 		else
-- 
2.37.3

