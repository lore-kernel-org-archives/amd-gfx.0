Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBAC4C433FE
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Oct 2022 09:15:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6E9EB10E5C6;
	Thu, 20 Oct 2022 09:15:27 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2060.outbound.protection.outlook.com [40.107.93.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2312310E5C6
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Oct 2022 09:15:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PMQ9GX0ZsEogZnwQfKl7qkGT7Gopfdf6U6rsndExKFsv6AGcfcNgzMzMx6Qji7hFiG8dwgL7j9jASOzV7zACkA/R2hfW8PpNYLQTQ9VVqCxa/Poq9MGDysX/Ip7Q5cSyBOwbGQVovcIRy9RXfe5a4yekedAuXbpV5TVOHj1O2juiiQuyzT3TUjVkcauYVt8cfcmZSDtD/caMp3JKRKFN2RSyxXkr8QRbqdxxjkeBzAYqBOkeymR1q1AhQrwTEko48xKbSVqCPHYVxezw+EwFdDcI0vQ1jcV/5aotUhXdGbltB+egw7rKtX3WCct8Py9jWRop1Myaq52IxEh3Gqa7hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4quNwYpjkUVpu06mhfWH6MNOMIy5dVaOkfx4NfENi9U=;
 b=T1Dmv5qtrfnq1GrUaa9usAHXG2JIFKhU2mO6LosHKXgIyomxiUB4JBkIY84DJi90kf60zEqA56h4C2MP6i3bld7y1SM/kHe6jcQhwu2cwst3qjsi9o8hK8N4ZQrGogSpsloIB+FZFaHfjUBpeMFA2v5Mo4069FNdOufdHb3Af1yjMLM8UM1kQZ+bQqGmdeKeMiCAD2Yn0aBUnSC8J3/BUdjenbn5ZDXdM9LFcc5S1hfMCbtrAX+Txz6KYLMT48hshRBmCkyg4INyyYGFkdMU0zdOoy7HMffCDXr9GX7szZ2boEW5KwN8vuKRbgmSy9gHHacmAtioxdcXIbED4QrRyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4quNwYpjkUVpu06mhfWH6MNOMIy5dVaOkfx4NfENi9U=;
 b=oA0VHkjyq1DAxg4M0QjBhu6EvTslTCA+SYdZCK8WI1BboQrlvG4T3It0FAGKfEFZKxrzTPXKMFX6m2ER35+EcYWskFgtBOD7ZuhoQXjzArKwLAhvUV6mjbZafTF0UPSxHgosL/vHlW49BC77/T9UaIIzggt6Sgl65sXz5TFJZ0Y=
Received: from DM6PR21CA0015.namprd21.prod.outlook.com (2603:10b6:5:174::25)
 by SJ0PR12MB5636.namprd12.prod.outlook.com (2603:10b6:a03:42b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.26; Thu, 20 Oct
 2022 09:15:19 +0000
Received: from DM6NAM11FT012.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:174:cafe::36) by DM6PR21CA0015.outlook.office365.com
 (2603:10b6:5:174::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.6 via Frontend
 Transport; Thu, 20 Oct 2022 09:15:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT012.mail.protection.outlook.com (10.13.173.109) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5746.16 via Frontend Transport; Thu, 20 Oct 2022 09:15:18 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Thu, 20 Oct
 2022 04:15:18 -0500
Received: from prike-code-pc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.31 via Frontend
 Transport; Thu, 20 Oct 2022 04:15:16 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] drm/amdkfd: introduce dummy cache info for property asic
Date: Thu, 20 Oct 2022 17:15:14 +0800
Message-ID: <20221020091515.2758445-1-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT012:EE_|SJ0PR12MB5636:EE_
X-MS-Office365-Filtering-Correlation-Id: faa1b549-94fd-491f-3d3f-08dab27b9bba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: goLaXzBs2KMeswAz7PXKiO49UyqKwrltYwIorIjJwYBoAkorSYw4RSNbqgttkD+xvbTNoXUj2gZ/xOUcplZiKD4Llby+AfXoSmEsCaKkAr+ZwW5jd99+G1DMmACB75vlIcguMyzYGVGcqR87GkYBCD5h5UIVvehGsFW2Izp124xauKO227PST1S7GLgdMSqT/r05+aMBiXaTVVPf7whkUdltm6CFDTB5xUXQ2YExGCrNnd370jTj4Jen961qvGzaxjCKlwKMSkcHSh36O2+jvSQxqi82J6kRuy0GTsuwi7kJpZ0g/mTEOoKJiBlpCkhcjzgKeqpSRhP0ZGwG1mvrhheZ6vGaHxZCMmTRCqzWcAp+tojO17a5eR9GhDqJAMedznmrp2PA6qyiZ9iovCD7DYcKfYHi44p3u8q2hjxmNmJ7D0kXZ2Jlfird8uTlqM9xMrbKYb3HM+BKomIE3/ObskICBJvPN/DSOGYHz/xf2uD5YnFP7ZJ7GnhnccMOSrwwUq038xYOwEGFhP8oDIN9TEaV2Ms4k2WsAkIpwZ8CamW1PEE7tWmtzLUFhAmlXZvy2tZ/M/t3jjcl6f1Tr2eu1rci5roRco7CieKip/FRbL42RAjS9MoqzdPhA8c2L0Y0j8nLDr005fBemK/h/E6Po88e0n7Z+rP72r4vy+KL0/aJ9fDrG8wyjWB58ld7ifWME+EJggF9I3QEppfpTxDHGCmGAdMZN58yM6kpxDu4w2o7pEq4jqoVhgdlqFvthBjFVxzEorPOK2jkIKprOEi1A+lKxNOGg/x6Ki2tHv2JUW0=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(376002)(396003)(346002)(136003)(451199015)(46966006)(36840700001)(40470700004)(82740400003)(86362001)(36756003)(356005)(81166007)(1076003)(2906002)(336012)(40480700001)(40460700003)(5660300002)(36860700001)(7696005)(186003)(2616005)(47076005)(26005)(426003)(83380400001)(316002)(8936002)(70206006)(54906003)(41300700001)(82310400005)(6916009)(70586007)(478600001)(4326008)(8676002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2022 09:15:18.9116 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: faa1b549-94fd-491f-3d3f-08dab27b9bba
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT012.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5636
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
Cc: Alexander.Deucher@amd.com, Yifan1.Zhang@amd.com,
 Prike Liang <Prike.Liang@amd.com>, ray.huang@amd.com, aaron.liu@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This dummy cache info will enable kfd base function support.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_crat.c | 55 +++++++++++++++++++++++++--
 1 file changed, 52 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
index cd5f8b219bf9..960046e43b7a 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
@@ -795,6 +795,54 @@ static struct kfd_gpu_cache_info yellow_carp_cache_info[] = {
 	},
 };
 
+static struct kfd_gpu_cache_info dummy_cache_info[] = {
+	{
+		/* TCP L1 Cache per CU */
+		.cache_size = 16,
+		.cache_level = 1,
+		.flags = (CRAT_CACHE_FLAGS_ENABLED |
+				CRAT_CACHE_FLAGS_DATA_CACHE |
+				CRAT_CACHE_FLAGS_SIMD_CACHE),
+		.num_cu_shared = 1,
+	},
+	{
+		/* Scalar L1 Instruction Cache per SQC */
+		.cache_size = 32,
+		.cache_level = 1,
+		.flags = (CRAT_CACHE_FLAGS_ENABLED |
+				CRAT_CACHE_FLAGS_INST_CACHE |
+				CRAT_CACHE_FLAGS_SIMD_CACHE),
+		.num_cu_shared = 2,
+	},
+	{
+		/* Scalar L1 Data Cache per SQC */
+		.cache_size = 16,
+		.cache_level = 1,
+		.flags = (CRAT_CACHE_FLAGS_ENABLED |
+				CRAT_CACHE_FLAGS_DATA_CACHE |
+				CRAT_CACHE_FLAGS_SIMD_CACHE),
+		.num_cu_shared = 2,
+	},
+	{
+		/* GL1 Data Cache per SA */
+		.cache_size = 128,
+		.cache_level = 1,
+		.flags = (CRAT_CACHE_FLAGS_ENABLED |
+				CRAT_CACHE_FLAGS_DATA_CACHE |
+				CRAT_CACHE_FLAGS_SIMD_CACHE),
+		.num_cu_shared = 6,
+	},
+	{
+		/* L2 Data Cache per GPU (Total Tex Cache) */
+		.cache_size = 2048,
+		.cache_level = 2,
+		.flags = (CRAT_CACHE_FLAGS_ENABLED |
+				CRAT_CACHE_FLAGS_DATA_CACHE |
+				CRAT_CACHE_FLAGS_SIMD_CACHE),
+		.num_cu_shared = 6,
+	},
+};
+
 static void kfd_populated_cu_info_cpu(struct kfd_topology_device *dev,
 		struct crat_subtype_computeunit *cu)
 {
@@ -1514,8 +1562,6 @@ static int kfd_fill_gpu_cache_info(struct kfd_dev *kdev,
 			num_of_cache_types = ARRAY_SIZE(beige_goby_cache_info);
 			break;
 		case IP_VERSION(10, 3, 3):
-		case IP_VERSION(10, 3, 6): /* TODO: Double check these on production silicon */
-		case IP_VERSION(10, 3, 7): /* TODO: Double check these on production silicon */
 			pcache_info = yellow_carp_cache_info;
 			num_of_cache_types = ARRAY_SIZE(yellow_carp_cache_info);
 			break;
@@ -1528,7 +1574,10 @@ static int kfd_fill_gpu_cache_info(struct kfd_dev *kdev,
 				kfd_fill_gpu_cache_info_from_gfx_config(kdev, pcache_info);
 			break;
 		default:
-			return -EINVAL;
+			pcache_info = dummy_cache_info;
+			num_of_cache_types = ARRAY_SIZE(dummy_cache_info);
+			pr_warn("dummy cache info is used temporarily and real cache info need update later.\n");
+			break;
 		}
 	}
 
-- 
2.25.1

