Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAA85FCA191
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Mar 2026 23:08:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8ED0810E5EE;
	Mon,  9 Mar 2026 23:08:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="oHlJrsBu";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010057.outbound.protection.outlook.com [52.101.56.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 16D1D10E5EE
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Mar 2026 23:08:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oHv3I7nOZSPwySWqPrLyN4AbQ78Matxc679ZD/0MyoOYtPLoCXoFPab5Y1SxJ4URUFCE6TVT0oUTXoTa0nqax3f7nVtZR2zuji90iazbCTkvb5sh0j+aN4P6rDUeqWJCu3AZqgRPg6dvvsaD+P8nizjKOXF2k+rttZdh+jQM725fXQFTxw5c1XFbqkmtI4zUuXfENc7u1Mk4qyf54djL+X7XVRzBu1QJ1AYoFspx23XxH2lyZiXJnLRLiZLzH3W0/phyZY11rNF4XVv37M47nqxNDppPaxJv3nQm0AD9qVBQIrPxGxTZCv+oZxSHAyjCMTyGq8P5d6gvuUl+k85yMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hpO0J16n3JCyD8ervwEAYQNfigJWHBAK2jq2ZJTpqDM=;
 b=TMd16njKj1Z2jgZ/O6pyVTW140cQPkO6qm4iw4ZXoeIh7wFXJKf439ai0BAahzofGp7oCs8wnx38JJRj0b/UCl9xq9+v3J+L03Tt2/TXRE6tEGFwJ+ReE7CrZej+5O63fDXmOBWzEc6N7kELoTGoRzVxdyCPh+EygPsfIrwrOFNmoWFJTnGmx/OrB7E18K3+pDPDmDtZSdU3HteT94VR84JBdJ/w5UJb/jk07XFzshH7yak7Li9ZYRhQsATp/wRN/glTpBQznd9tMe0SU9PSlripAqklTXrRpfp4MEODAbPtzqId2Ht8nR2fA4gxHbF+I8iOPu4CjKZMGfY0Cg8BHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hpO0J16n3JCyD8ervwEAYQNfigJWHBAK2jq2ZJTpqDM=;
 b=oHlJrsBuTTE7rnmqb9hOTN/Rn/NtTS16pGUp1UEQua6/0MESxbjnLPQrF+Xkw8ukO1xFqYt9CvikDRfB6SEdkRw+0bKouL/pxXt+Anrn6l8sinkGDBIrEvQJPOjQ86cAsmstAhIH3hHa3tK0aTYRYVAnY7evPkElwaX2mc8LbPI=
Received: from BL1PR13CA0338.namprd13.prod.outlook.com (2603:10b6:208:2c6::13)
 by CY5PR12MB6454.namprd12.prod.outlook.com (2603:10b6:930:36::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Mon, 9 Mar
 2026 23:08:39 +0000
Received: from BL6PEPF00022571.namprd02.prod.outlook.com
 (2603:10b6:208:2c6:cafe::9a) by BL1PR13CA0338.outlook.office365.com
 (2603:10b6:208:2c6::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.25 via Frontend Transport; Mon,
 9 Mar 2026 23:08:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF00022571.mail.protection.outlook.com (10.167.249.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Mon, 9 Mar 2026 23:08:39 +0000
Received: from david-B650-PG-Lightning.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 9 Mar 2026 18:08:27 -0500
From: "David (Ming Qiang) Wu" <David.Wu3@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <alexander.deucher@amd.com>
CC: <leo.liu@amd.com>
Subject: [PATCH] amdgpu/jpeg: fix deepsleep register for jpeg 5_0_0
Date: Mon, 9 Mar 2026 19:08:13 -0400
Message-ID: <20260309230814.485193-1-David.Wu3@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00022571:EE_|CY5PR12MB6454:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f68fa0f-43df-4be7-a88d-08de7e30ccc2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700016|1800799024; 
X-Microsoft-Antispam-Message-Info: XLnT0oLZR2oUtSJ/SWkO61GPhYT6ioQC+qAxHamFU5RWz6FJuM3BCtHb4NIbnnGjnvCTtIaC9TQqDp95FqAPma/BnxmzsnqQnbF/Mi8iAEKU4KpFwvm3UGrzxFHJoW1cx1ysEeY4yzTs3EOVvZz9rYLFl4qQczekMuyA4GN+PTFAYNTiOz+0pS99P0IMhIda/Gd5TuzWnCYy/ekIAan36fsmuucrUpxEFh15P6NZo5Jux2vdjCd/9O5SyP1tK+QsGq4sWPUEpPqInJLoLPTJ1a1Mj/tlyfob/CpLsauvj8No+/ozJ7h1QW5Ts/hSkaFPHHTL/D1w41Y2tpmPg5/BR/GLd43EtnChLpH/KXQUFfeqV6lBqy9wOBVY8cEN9di002S7n9J1dbGoCdh2FmihrpGd9+5Etmn0m8A0gfd6tPLORthI1jjkUC4E1LcnW665J0SxyeyDaUkb6JyX7CrY0xeh3X/MSEJA1004gqd69UNf5sAjkmy4Qnhrjr6QIZ+IKvB04ZamW2hjhFz9ATuseHk969+i7FO7c668/yoSNSI8Rvhvujk++8q07ArQhIs0J1ME0UkNMyROmNdBnIZiJO6hAq//2mhcTLuWxq179NU1VaHo2K6MoJkRgCAyLtFYH+iClvKKw2J0E8fB55a4cDaHuGUugCDtoW4ee1J+541r5td4O3NnEX6K5BWTmI++hl0nZjwO8FAET7FidNSZLvs2z4tYirWrh8OdHxoNJbJOIhWK+3KP71UlHbDK8qJ3oMy/mWFNSzF+MIFWGMMwKQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700016)(1800799024); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: WumOM+M+Ueo4GseHxOgYupGcNAQuIE+7y4zxb7T0AKzfPjMCF5AYWMPGJqbDvQeZznafNJIEJVRu+ymNAJDlzu8goUjDcEhmVL6hmHrBwmwX3/7+VyfeDP1ouPFawgQX2Rl52mwcQgIwyEPbIDREIOUo5lqF3/VMJVb/aXJDHj2Oa8xo4XWIMkXKcsp7ksvWfMi2YLVr35QMOy6oD5JL0zSTsX84D7fRRQA7n9qn5s9+YPhkq/myfWIPtAJ+Amuyq0FQUEGN5txsnGB0Hwo1YFa2djdnBFLRsr/qMQd758Saeb6Z0oaaOEzQyZJEgv2RAVA/YOCWBiG5F+TAFGzG8GMGu3D4rJLW87w2U7hP5blSnyjJFm5KoAiIcJj5SUHB3Ga05QuO8XgGbPjsr/VFPskBVJ9LeH8BnrgOg+WW2PY2yxINh6SvHctgF1ZA1dSh
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2026 23:08:39.1665 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f68fa0f-43df-4be7-a88d-08de7e30ccc2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00022571.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6454
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

PCTL0__MMHUB_DEEPSLEEP_IB on MMHUB 4,1,0 is 0x69004.

If deepsleep is working then the MMHUB clock will run slower
while idle but speed up once anything happens, so some operations
might take a little longer to get started.

Based on the logic above and tested on RX9070.
1 with 0x69004 set 0x80004000 at start, 0x4000 at end
2 with 0x69004 set 0x4000 always at start and end
3 with 0x62a04 in case 1

results:
 - case 1 shows the best startup performance. speed=9.8x
 - case 2 shows the worst startup performance. speed=7.5x
 - case 3 is a little bit better than case 2 at startup. speed=7.7x
This clearly indicates the case 1 is correct.

Signed-off-by: David (Ming Qiang) Wu <David.Wu3@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
index 4b4aa9553624..62eb98450426 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
@@ -739,7 +739,16 @@ void jpeg_v4_0_3_dec_ring_insert_start(struct amdgpu_ring *ring)
 	if (!amdgpu_sriov_vf(ring->adev)) {
 		amdgpu_ring_write(ring, PACKETJ(regUVD_JRBC_EXTERNAL_REG_INTERNAL_OFFSET,
 			0, 0, PACKETJ_TYPE0));
-		amdgpu_ring_write(ring, 0x62a04); /* PCTL0_MMHUB_DEEPSLEEP_IB */
+
+		/* PCTL0__MMHUB_DEEPSLEEP_IB could be different on different mmhub version */
+		switch (amdgpu_ip_version(ring->adev, MMHUB_HWIP, 0)) {
+		case IP_VERSION(4, 1, 0):
+			amdgpu_ring_write(ring, 0x69004);
+			break;
+		default:
+			amdgpu_ring_write(ring, 0x62a04);
+			break;
+		}
 
 		amdgpu_ring_write(ring,
 				  PACKETJ(JRBC_DEC_EXTERNAL_REG_WRITE_ADDR, 0,
@@ -760,7 +769,16 @@ void jpeg_v4_0_3_dec_ring_insert_end(struct amdgpu_ring *ring)
 	if (!amdgpu_sriov_vf(ring->adev)) {
 		amdgpu_ring_write(ring, PACKETJ(regUVD_JRBC_EXTERNAL_REG_INTERNAL_OFFSET,
 			0, 0, PACKETJ_TYPE0));
-		amdgpu_ring_write(ring, 0x62a04);
+
+		/* PCTL0__MMHUB_DEEPSLEEP_IB could be different on different mmhub version */
+		switch (amdgpu_ip_version(ring->adev, MMHUB_HWIP, 0)) {
+		case IP_VERSION(4, 1, 0):
+			amdgpu_ring_write(ring, 0x69004);
+			break;
+		default:
+			amdgpu_ring_write(ring, 0x62a04);
+			break;
+		}
 
 		amdgpu_ring_write(ring,
 				  PACKETJ(JRBC_DEC_EXTERNAL_REG_WRITE_ADDR, 0,
-- 
2.43.0

