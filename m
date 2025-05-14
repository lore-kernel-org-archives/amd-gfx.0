Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14E43C3ABD8
	for <amd-gfx@archiver.kernel.org>; Wed, 14 May 2025 17:11:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 493FE10E6B9;
	Wed, 14 May 2025 17:11:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rMWgVW4v";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2052.outbound.protection.outlook.com [40.107.220.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 84F0110E6AE
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 May 2025 17:11:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lWN3a1z2fZ4J9DgYCzv1bdroOeujqEzJm+WCsOdLd9kKXk/gkxx4+2LRo4VKwOq9JORbMTJeBEzMwqfrJCJzUExZ8PClndPkifvDyC3dxh1k4nyVXNHO6+sqf3YE5XbsS+D/cCRvfQVewSs2aZ+m01rstLGl2fgHxAKcN8U3os8xwZgfyLboXZigOtBfuOaHYuSsqUifK8EgY/hO4zMWuSDrHuBnrB1VgBjkLqq8bqH8qFzm+TjEenU0v5/1IcxDu06kgXk9SOSmgKV7FEvPz67pR05d4KQwb1k1ZtHq/yTSdpQAOCbexj61kS/ZNeKx6kiYbyLcB1h1tsjWQ5gHVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ewjvuDCT/23/1tVziz8hO+3VN4CM/1nk/P2buck68Vc=;
 b=auXA40uH9hYD4sxV6lXoyb5ZtWE+/9H4F0wz8CwXgmHNsz4PjS0Ceci/Jf8u3A3HCKTvgZFscxEQ+fJuo7kjOwAllmvaFWVIH+J5fS4BsefnGNCcrIVe4GHZFXXvdvJIwk4+WpY43zHnysPxBEWzy38nBULU2KXac+pjVpoAPPKQ8vcfzD0/NKvM8R9atE3QV+2pulgPsS6qCmr8klIjtoVRRXJ6/4AGNOR5za8O8I2nblxcI1VP3Vhdazbq8l7/d1PoGtUkmQ89UdE/PnXXFgIClEN2VBoCqWTzxP2Pyq5A49ZDF/y6lSi7IX77TMrQ/HqhZiIkUeoC+uEhjVDRuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ewjvuDCT/23/1tVziz8hO+3VN4CM/1nk/P2buck68Vc=;
 b=rMWgVW4v0DGVWesJq1U/zRJQDPNxxSeeFDHupbCryTcXyyBMfrc6iMMJLDy+AW1/uqqkLxZXatxXTuCSfd3R58gpmxrWpaDECFiycucfzknXZFmcK/XYkn7q7kukq8jY3sxSPZqdopw9ltU7wp733rbihYf+I4s5/jNPZiZ9Zms=
Received: from MW4PR03CA0249.namprd03.prod.outlook.com (2603:10b6:303:b4::14)
 by PH8PR12MB7112.namprd12.prod.outlook.com (2603:10b6:510:22c::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.21; Wed, 14 May
 2025 17:11:14 +0000
Received: from SJ5PEPF000001D5.namprd05.prod.outlook.com
 (2603:10b6:303:b4:cafe::cf) by MW4PR03CA0249.outlook.office365.com
 (2603:10b6:303:b4::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8699.30 via Frontend Transport; Wed,
 14 May 2025 17:11:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001D5.mail.protection.outlook.com (10.167.242.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.18 via Frontend Transport; Wed, 14 May 2025 17:11:13 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 14 May
 2025 12:11:09 -0500
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.Kuehling@amd.com>, <christian.koenig@amd.com>, Philip Yang
 <Philip.Yang@amd.com>
Subject: [PATCH 3/3] drm/amdkfd: destroy_pdds release pdd->drm_file at end
Date: Wed, 14 May 2025 13:10:04 -0400
Message-ID: <20250514171004.4259-4-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250514171004.4259-1-Philip.Yang@amd.com>
References: <20250514171004.4259-1-Philip.Yang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D5:EE_|PH8PR12MB7112:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f142b09-4011-4c29-bf26-08dd930a54c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?TRJwCNLT8WR7tIhIHBHXT/8A+gGNTzV8LwhIQqUjY52YaXK7RP6GPSvJ2AB4?=
 =?us-ascii?Q?JQqciJm1Fk0y6xg+hPM4WUCyrSX3vYRwyRbhGgQSK1DZ8tEi+7BumNVFgcEY?=
 =?us-ascii?Q?ecugxIuW3VjO0TmYtavh48ByfbHvphOEize4nNGro4R4yvAX3upFkk4ZuwZw?=
 =?us-ascii?Q?+XxhzITTXIk3SVm3r6ysFc3dUSdi45rEekfQgw6TS0fzhwHUqe66ndFk8X3J?=
 =?us-ascii?Q?v2S0+JllkhWKIkohT7xEFYRe4KBD2z575xCxmsew1ZRce/Eusv/LtjQ7iNtS?=
 =?us-ascii?Q?PMN2cBgXLgs08/VE8siRu5/4dAmLF0WfgKesvlHiPYOmzb8pNUu8r1BEXQ2q?=
 =?us-ascii?Q?3SOAjotuUqGWQ2Xk3bRyiSSXEAVQPgdb9/3Mo3q2U/ospPqPgmctXEcDFiLO?=
 =?us-ascii?Q?xw0nU+bDa1l/WeZmMH5csPSEzehWntcIoi5iBbMQPJ3IvoX4smF3AaMA5SK2?=
 =?us-ascii?Q?bXddDBippk6kn7dqfkaOMCLlyxIYemW1CyzSUk300UfHh5y9O7OJ+x7O4Idt?=
 =?us-ascii?Q?HlgM18EiNFfzWZeduFvlRfItsYbbsdo6mUw6mMxFl1UKccAW6U2PxDyPS9Aq?=
 =?us-ascii?Q?SG9PnqCxxRtWm1a68TWMGMYot8E+v6OMkNUxnGlCi1rPtQQM/1R9/68RZOck?=
 =?us-ascii?Q?EXA4zGqtg58AM/+vOPRUQVEFbUT8nxNIuJNaRZxQgIydF0R5taslQNvqXLsG?=
 =?us-ascii?Q?DZSpRDQ9Ek+o4u6nrjwcghnOAZ9rLG0V5yvzd8cysy4H9rMi9wwKqhoacTyj?=
 =?us-ascii?Q?OJzR72J5jjX9VwtE83qyGpEMPG2vVHSSqKWrh9CtOvB+dSJ6mPdnK9VxSLAY?=
 =?us-ascii?Q?KbjGN79q++T23woj5KVHjl5bGSg+zHbtHUwJ1XXvIe7wKyo8h5NNbcxiVw77?=
 =?us-ascii?Q?grlbp5/ZXwJofrTEjkveNSiH0KmPFWxN+UW1uaKVXPLkhcIsDvto3674a2kt?=
 =?us-ascii?Q?RiXOh3ufE7SVdorgE/9/lW6FZSZa30R5OnbRlvs31ESlp7qmny+0BYFNWQ/s?=
 =?us-ascii?Q?KE+YTkfyd14UhZxYNw21piHxEt9cxFWoIDi2xPNBbjx5zqhtzetbwPnc/0wu?=
 =?us-ascii?Q?1Ut9dyFeuMZI5E40aBVzZInh1EDHemx488wRlFfgSq6FAMLy8VpdqX1xOHoC?=
 =?us-ascii?Q?gO71mk6UmiDRrjr1FawewIlHAar6GutzsLwRs+FPETtDJepHHpAUpXpQhjyd?=
 =?us-ascii?Q?2Cekt/7cy04+GI2UDROym2i9nVT60EOleWLTny4trYKzFXWE4D7JkeArJ6a6?=
 =?us-ascii?Q?+MBwPMEuj63uubyiRKBBnenzBVbHsX8v/NZ/Oz7pHNszIUA1JFPuvOGq098i?=
 =?us-ascii?Q?WxUQql/ojdqa5RXzFUX7PAtOym4p5yjQRQGnrEEnr3KRioRuytM4AVB8gqjA?=
 =?us-ascii?Q?IypRDZbdaq8MxL/buKFar/uUGr3kYpNIse3+em7+6CFnRTYbQTQHVMnSTSL9?=
 =?us-ascii?Q?MSobsf/sUVCmp0OJiWVEewUWVaKVDGPaTymxfzMaz95TtAnwZ9FoWpJF02V3?=
 =?us-ascii?Q?/x8Ptcm95dPL5DKlsyXq+n/oRwlbb/Vufrmc?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2025 17:11:13.6300 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f142b09-4011-4c29-bf26-08dd930a54c6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001D5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7112
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

Release pdd->drm_file may free the vm if this is the last reference,
move it to the last step after memory is unmapped.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_process.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index e868cc8da46f..b009c852180d 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -1063,9 +1063,6 @@ static void kfd_process_destroy_pdds(struct kfd_process *p)
 		kfd_process_device_destroy_cwsr_dgpu(pdd);
 		kfd_process_device_destroy_ib_mem(pdd);
 
-		if (pdd->drm_file)
-			fput(pdd->drm_file);
-
 		if (pdd->qpd.cwsr_kaddr && !pdd->qpd.cwsr_base)
 			free_pages((unsigned long)pdd->qpd.cwsr_kaddr,
 				get_order(KFD_CWSR_TBA_TMA_SIZE));
@@ -1088,6 +1085,13 @@ static void kfd_process_destroy_pdds(struct kfd_process *p)
 			pdd->runtime_inuse = false;
 		}
 
+		/*
+		 * This may release the vm if application already close the drm node,
+		 * do it as last step after memory unmapped.
+		 */
+		if (pdd->drm_file)
+			fput(pdd->drm_file);
+
 		kfree(pdd);
 		p->pdds[i] = NULL;
 	}
-- 
2.49.0

