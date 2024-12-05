Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4A3CE77170
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Dec 2024 22:45:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 81B9510E5D2;
	Thu,  5 Dec 2024 22:45:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QlosQHL7";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2045.outbound.protection.outlook.com [40.107.223.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5BDE810E5D2
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Dec 2024 22:45:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oNt6yQV1NqGt2HFEBE+AsN36zLklIGo4OVNYXm0AR/64u+CACcFS+Qbgx5y/UcdsGr6211d2C7F7Yumkr0YVHYTS4V5GDjsawr/FW8WbjplGKBg/1IMs+tQqCHXmWzjTkUmZentEmuu+hlbSZiFowPX8mfH30QDEx0YpSX2ZLe+k3U19YO5nuGjc/JEhUW7vXbPX+JbcFot2zQSF4aJmsp8mfCoJIScaXsUBJzNkG+FW1yAe03io7A5EfPCP2pMB3t/KVqH302+BInR52TGcEShTWaSY/vKl++nm5hoBLcZqRFADjTJy2RlYZqx8osx7rs+tM8fhWBbrY3i+f2k5ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L1DaaArKpP87OzOE1ieztkKSwp+/eNAYGRrft35X/ME=;
 b=pwxLoHFBM/ZVsJA3zBqz5a9lEOAretwnKMRHcPsjqF3hoQ5dJ3qxqONoeU3c8Ipq34EbMFgzvSZKc6A3E6GUpZlbD1PZPdxHvvTbiILRVU45GqnaKLTWhZBNvk7Ih56cj8Zy7Q6XDvAaAkGu7C/r47OMFcADeWXNYPnRcIrXH2A5gEGYq9Bvhjcf6yUZNfT7lBtWHpnDL9eZ3/tWnvjzW/k9BPsCe5w9cSvfOo0OMwWvGHAAiHFlLfosC5xwJe6p7RV69h/HwOjOy1YQ8rafkrvFByVY7prOqtSWRvCSVsrrx6XJDW9WGKt8/l9oKo4mst8UgBF4KFAZbMPiOmIHwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L1DaaArKpP87OzOE1ieztkKSwp+/eNAYGRrft35X/ME=;
 b=QlosQHL7mb94bTWCPYSQ6E5Nz4walPWdPj9sQBQopvwQaAP9l3han8NBBmd8jOOOipji7h0C77hmDqx3FzbUhemXUnsMJLmJlCpzoXsoEY1ht6DH1fmzKFY82W3qxu+F3Reh3rSViPcnp7Xow2Sr/uKYn4FisfqaxiGOeBlLAIk=
Received: from BY5PR04CA0015.namprd04.prod.outlook.com (2603:10b6:a03:1d0::25)
 by SA0PR12MB4432.namprd12.prod.outlook.com (2603:10b6:806:98::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.12; Thu, 5 Dec
 2024 22:45:21 +0000
Received: from MWH0EPF000989E9.namprd02.prod.outlook.com
 (2603:10b6:a03:1d0:cafe::d5) by BY5PR04CA0015.outlook.office365.com
 (2603:10b6:a03:1d0::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.11 via Frontend Transport; Thu,
 5 Dec 2024 22:45:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989E9.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Thu, 5 Dec 2024 22:45:20 +0000
Received: from mkm-d10-yfeng11.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 5 Dec
 2024 16:45:18 -0600
From: Yuan Feng <yfeng1@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Yuan Feng <yfeng1@amd.com>
Subject: [PATCH] drm/amdgpu: Use MEC FW with SJT on gfx_v9_4_3
Date: Thu, 5 Dec 2024 17:45:07 -0500
Message-ID: <20241205224507.2272-1-yfeng1@amd.com>
X-Mailer: git-send-email 2.39.1.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E9:EE_|SA0PR12MB4432:EE_
X-MS-Office365-Filtering-Correlation-Id: ed137ae1-2e5e-4f30-c56e-08dd157e7f86
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Cl8T1lqIAcyyC/NMrwo8JX96ue8h8Olz3rO0YJzYfE2vG5CS6nCuitO2QoZv?=
 =?us-ascii?Q?y5eTAG8jQFrXmJfmbYUa1zyltUxUvgNyiph/J8l6soh7KpvsyIBDf3N16kTB?=
 =?us-ascii?Q?KcSDZ66oNkaaqRD8IzjXgjxsCn6GRhWSIrGrivH32GVw3AIF6wiKeMM2d+lC?=
 =?us-ascii?Q?Fde0HTb8/vpZ7cpTLYHd8LLb3JQqp+AvNZc5TRwMiRQJvq/n8xPF2Sc2SI2B?=
 =?us-ascii?Q?ZDFbeFiDh84Af1NNl0oTIBlj/MYUYtVt+Hg0HlghFZ+MQ9yrgV8xI2weC2+j?=
 =?us-ascii?Q?iDb1R1QGRr2fcmBFo4MbtbBrFm7foEy7K5R4xiWWW7feaTN2wLvl16wNcH6k?=
 =?us-ascii?Q?xi6Lb5TY4Yt+6zSJvqybAp/TeutDWorq9Un3yv6z6VSK0K/D6Gj/KN3c2RWX?=
 =?us-ascii?Q?FM8cyylus/Iuq2ehM2aHe1TOXBPd5fcc17S+XL34GN8u2t7X4gDVVmAaIO42?=
 =?us-ascii?Q?M8NSGdLKGEP7TQlevc03jXKM8fdpFWw3z41aXQqsjtTiA7LQJ5qWCWpFeNro?=
 =?us-ascii?Q?AOipwzqOb/pjmirWPe2FxINNjEn1nx9k4DFBN8D4ECi/LL0OtlIV4/VPCeKy?=
 =?us-ascii?Q?R28zd6Dt9Dp7t2iCAoncLa/5Q1eLfN1ypHCMPfVZNXm1fSQLe0rtFENxEt/4?=
 =?us-ascii?Q?YEQNtQkICfKUowRY4iMZ88p+NLaLR0LLfyWupJT/Jnl2/voC8vetyK2PEwIA?=
 =?us-ascii?Q?6MxTfNRYyiut5K5qaOHgsU2dJBOM4w8H5dt9tg2USfmLNHk9ENPkdEaB6OHf?=
 =?us-ascii?Q?7+ymp5Uqu595T57n9oZPWQqjFqdus/QCtVmTHP3povkZgZYUa8wV+atKeAH7?=
 =?us-ascii?Q?E8lgAQu5+gLIQE5vFsA3Cf+w1yGs5b5ucQo0AVXla5Sotixu5eGwD29uvoW9?=
 =?us-ascii?Q?l0TNaQxHGEMmsYKC1vl8ZfBEP4wBz77PopyKTtEj74tv1q1mo/h9YoZpQRAG?=
 =?us-ascii?Q?y1xVO0Indye0KlCIFbTAYoXT2+E3995o7O96F+s2NQ1SkBH/IBatCM05AJPb?=
 =?us-ascii?Q?stm4iCwZyJi9cyJ1BTKPcuEA+t2VzQqJxEvwTWVvgkw69lzpToUaOPWIH/yA?=
 =?us-ascii?Q?VCPd2pUCVr0mYAwwRwsF+RhBSDzwWOgbeiJE3b2qnDpFbW25ni6rjK3Ianz8?=
 =?us-ascii?Q?H3ZMqfDiE2UfcjktD9ywLeLCEHGhem92CutNKmzoBg18XVJtxAAFQCvrv2hG?=
 =?us-ascii?Q?bx7Ii/DinBa+xz5ekwjoeSupgEMyQyWhCDDOMskF6M6BO4K+p72zH17PlPKB?=
 =?us-ascii?Q?kTgUr6aeZMtuOiCuKa4eilwMFxRTJXVqqC0FjornwS0ScVYXNNbtIUq8ATwy?=
 =?us-ascii?Q?St2+aVL4Bza5d2ny2AmLUqhGuMN9zxTz2rxXzDC9a+FfIiUsuhVxInUOTIpt?=
 =?us-ascii?Q?Yijlb5MEANFv6dHD3dQqhkEzOe2fdL1P+sCXw2dEa4OWUsHtk6Sexkd6lA5l?=
 =?us-ascii?Q?zGU/JcjoypGefgkI2Qn0MRsocZVQXCDg?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2024 22:45:20.4517 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ed137ae1-2e5e-4f30-c56e-08dd157e7f86
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989E9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4432
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

On SRIOV, guest driver and host driver might deploy different versions of MEC firmware binaries that
lead to potential compability issues cause system hang. To solve this, host and guest deploy MEC fw copies
with two level jump table.

Signed-off-by: Yuan Feng <yfeng1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index 03654bfda58a..f248449e93a7 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -45,6 +45,7 @@ MODULE_FIRMWARE("amdgpu/gc_9_4_3_mec.bin");
 MODULE_FIRMWARE("amdgpu/gc_9_4_4_mec.bin");
 MODULE_FIRMWARE("amdgpu/gc_9_4_3_rlc.bin");
 MODULE_FIRMWARE("amdgpu/gc_9_4_4_rlc.bin");
+MODULE_FIRMWARE("amdgpu/gc_9_4_3_sjt_mec.bin");
 
 #define GFX9_MEC_HPD_SIZE 4096
 #define RLCG_UCODE_LOADING_START_ADDRESS 0x00002000L
@@ -574,7 +575,16 @@ static int gfx_v9_4_3_init_cp_compute_microcode(struct amdgpu_device *adev,
 {
 	int err;
 
-	err = amdgpu_ucode_request(adev, &adev->gfx.mec_fw,
+	if (amdgpu_sriov_vf(adev)) {
+		err = amdgpu_ucode_request(adev, &adev->gfx.mec_fw,
+				   "amdgpu/%s_sjt_mec.bin", chip_name);
+
+		if (err)
+			err = amdgpu_ucode_request(adev, &adev->gfx.mec_fw,
+				   		"amdgpu/%s_mec.bin", chip_name);
+	}
+	else
+		err = amdgpu_ucode_request(adev, &adev->gfx.mec_fw,
 				   "amdgpu/%s_mec.bin", chip_name);
 	if (err)
 		goto out;
-- 
2.39.1.windows.1

