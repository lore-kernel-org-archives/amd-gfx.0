Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83763C021B3
	for <amd-gfx@archiver.kernel.org>; Sat, 22 Feb 2025 02:05:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 13A8210E066;
	Sat, 22 Feb 2025 02:05:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1dHH4hRC";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2081.outbound.protection.outlook.com [40.107.243.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C6D5F10E066
 for <amd-gfx@lists.freedesktop.org>; Sat, 22 Feb 2025 02:05:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QAmb3wBgBPvaoD9DMqqEbeft8mli70wGC/epXWO6du9e1mYXgnhmbz9jS7fKQvJ7nnL+XIOIX7/aXt8iGyRKlOUrlx1nsF7TPljMn27/5vTEPmwkqrWvjzgMOlQwX7exgCou5P/ZPaTYb7SUgxyZwT4e1hkjBP+s85AACQhADdoGaXUWjZOFw15CSWcLK3xR53LrUjHJrvY5eba8Lx1gcjs1uahZ8xfAJ7wrD/uy28XCkWIMLPuMc5QzqO4DgO/rKwXeOYuGSzo011KolfZW4BdMCUAMetAQIUg7P+lnpHw+FhnBpFl8K50XXpKr2neWGhqGE5qrJim5oYf8OyNVKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y1BzDATjtOszq3vl76NkZIYidxkx23jawBPGrtdn8a4=;
 b=jYi3hFBZpYDGj72R6Ql1leMd62J9HfJyA7dTU+5AoyKU0D2vfyZ1M22rLuWo9JUyGFnn6PUN2Vd2KiBkYWMI9izDP2g8+iZ46Nd8QFM8xAJJqsQwq3jC1ofOpdinGoEwSCG6U+He1HmTPMWyWYSmhFtM+LQ/lqtK4k3mgmQHaJUlsfe8kMD5A1geX5wf9UiGrH/Y5KIBfKlPscV2Ejk122EilQ2wDA4nPOUKz24RaQ9lUAPbziIKEdxX1xsi2NOVERCFKg0DlBCiIudxl7qQNK3XhRXZNpwJ85cem2+qQP5B8nIkNY6t/8KIJhFrroONf711HPnqFdRx0Yl28UZo8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y1BzDATjtOszq3vl76NkZIYidxkx23jawBPGrtdn8a4=;
 b=1dHH4hRCCin64Xne9C0wwt1+c1qOCTJvx1WnYEkQKpyxt3312GenqyVfTyjmPac5CB1/h/etJ/eoaE2q1pCGiGa1wfuZdj8yO+0rNydgizfXdEQcLy3hJmJqpcoQGt48P9zLb2CxHfga8h8YoCuvkpAOG41SB8Clv08p0ZOplJc=
Received: from CH5PR02CA0016.namprd02.prod.outlook.com (2603:10b6:610:1ed::13)
 by PH7PR12MB6787.namprd12.prod.outlook.com (2603:10b6:510:1ad::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.14; Sat, 22 Feb
 2025 02:05:46 +0000
Received: from CH3PEPF00000012.namprd21.prod.outlook.com
 (2603:10b6:610:1ed:cafe::55) by CH5PR02CA0016.outlook.office365.com
 (2603:10b6:610:1ed::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.16 via Frontend Transport; Sat,
 22 Feb 2025 02:05:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH3PEPF00000012.mail.protection.outlook.com (10.167.244.117) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8511.0 via Frontend Transport; Sat, 22 Feb 2025 02:05:45 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 21 Feb
 2025 20:05:44 -0600
From: <boyuan.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Boyuan Zhang <boyuan.zhang@amd.com>, Yinjie Yao <yinjie.yao@amd.com>
Subject: [PATCH 1/2] drm/amdgpu/vcn: add session ctx buffer and flag
Date: Fri, 21 Feb 2025 21:05:29 -0500
Message-ID: <20250222020530.8194-1-boyuan.zhang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000012:EE_|PH7PR12MB6787:EE_
X-MS-Office365-Filtering-Correlation-Id: 432bda72-2930-44f8-b145-08dd52e56b3b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?wPPsOPYXuYRUPqy5W0Ur56q0Sp7QuJQ0hNk17wj7GR/LH8ZiS+TB54D0JLfH?=
 =?us-ascii?Q?j+QkIhF1TO9ICn0xdFfs23vO97+HMdg6XnH9J14bQVmvWq7wTWbiSh9FjQ6g?=
 =?us-ascii?Q?QRDwagKXt7oS80Dii/urjJX6SJS6UOixvuSnZ/LyrDgN5KSYt8+VcqBdeiM2?=
 =?us-ascii?Q?AAy/rh5NGC+qyz4JgGTqcd+YBNEP/JJANSdUlBwe9dX4QVlGU5obt+7QZVFV?=
 =?us-ascii?Q?g5V3dJZR9Nc1kryDHytzKPXeJqv1P5dMDfmBzGVPF5SrIfDGFcu3qJ3DmaeY?=
 =?us-ascii?Q?qCPQfHrOLq3/4brdtrs5q6QEouQuu7I6WZw74LnEqtwj3/5Po/jGKshOcefq?=
 =?us-ascii?Q?6V7xsh4dEIx8RbdldILe/vcrpO1lZ+PNc9a5M4c6/vtlVugLSAnw5TRfnQXI?=
 =?us-ascii?Q?P8lsOqFH2ir6/QKo1KkzZoHfg4GfLx20kcyDZi7dG4iWXiafYKm4t9pigqRU?=
 =?us-ascii?Q?UBG1ECkcnmBqRZU2CYVZ3+f3UP+rrW2UViSWnCMxQyuCb2hzuYvW0PhqWrTf?=
 =?us-ascii?Q?LxawzjwRei828vRUHZyhVnOmpo9MPiuZ67avI0VjLySqZStYnPdC4GZ7kEiP?=
 =?us-ascii?Q?MpU3+X5oPhY02+nhTwQGXKHnN+oo/CK3W/mmCPy5KV6kOQwIRmTLO+c5uJnP?=
 =?us-ascii?Q?vheXXnjd4Ff5+iGIkEYqNZCv9wNVpm0cDXNKvMvqWO46hyh89s58bAx9dV4R?=
 =?us-ascii?Q?gas3n8oPw8qI1NARknda1lq5dO3Kee+yMyNXijGkcnZkvxjG3RyT5ZXxpwSb?=
 =?us-ascii?Q?FZqSsAdicdr4GQp9VDpNu4xlTK5285qqYI1TdBl2CPf+EC0rlgfSP6Zr2Scy?=
 =?us-ascii?Q?lRasutkfDdJAYIhegDWieHcIelfYG11u5bVkUpnqN+mNzzdzPk7fJQEXwOlt?=
 =?us-ascii?Q?jfNtuHi0o+M+7gZ78dDcdtCtvw2shy0m1t1I3VtjRPIHLDmhFRGazLaNHFvs?=
 =?us-ascii?Q?/tWMQ+6QsAfESTg/S+i8py3+plnx1MBeRFPm28v0eoU/w8IiU687UBLSWvjv?=
 =?us-ascii?Q?e6sauoizNidO+t5PZSnt/yRovT69zEwxL1/4qPp+Rg3SjX11o4MZHi05uJpP?=
 =?us-ascii?Q?vfN7vnsWxe5NrNus8aW7mDLn0KpmzS+nsxEVvSR2KfdwtI9lCLNd6P3mJKAw?=
 =?us-ascii?Q?u21a4uvEcbIH/4ERFe16QmrOCdDZOCnvm7an7AQE/zV0gCh5sorA9DUtmvgd?=
 =?us-ascii?Q?mt0Wm7BMTQH7R7UPrs5cZUU56dmB8sb0FLRc5FHApHAVxDbJUKdQjj9ZfZiA?=
 =?us-ascii?Q?kgVqG07vkKBERDcB56o9ttapPjpmcvygzj0v35M3wcxoLkLsnG4904fU8k1V?=
 =?us-ascii?Q?4TFByCeo2kFUuvFJCG2/n/Q2AGzIHA498t1qjDbpCKFfPtDv93vudphgkgAm?=
 =?us-ascii?Q?+25Prw0Mi5KYa5/uG/ytKUnauCnVg3dV0X+8kf+HmD1nRHbs++gAonNW1vze?=
 =?us-ascii?Q?sc9dn4TbQQCPLqdp3+PJc7UIu010G/Bf/6sKbzj6SPPFdiHiuey9yZ31QKS0?=
 =?us-ascii?Q?zjIkTcUEgidwWf0=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2025 02:05:45.5915 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 432bda72-2930-44f8-b145-08dd52e56b3b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000012.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6787
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

From: Boyuan Zhang <boyuan.zhang@amd.com>

Define session context buffer addresses and corresponding flag

Signed-off-by: Boyuan Zhang <boyuan.zhang@amd.com>
Tested-by: Yinjie Yao <yinjie.yao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
index c92f683ee595..44f259b2a320 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
@@ -227,6 +227,7 @@
 
 #define AMDGPU_VCN_IB_FLAG_DECODE_BUFFER	0x00000001
 #define AMDGPU_VCN_CMD_FLAG_MSG_BUFFER		0x00000001
+#define AMDGPU_VCN_CMD_FLAG_SESSION_CONTEXT_BUFFER 0x00100000
 
 #define VCN_CODEC_DISABLE_MASK_AV1  (1 << 0)
 #define VCN_CODEC_DISABLE_MASK_VP9  (1 << 1)
@@ -465,7 +466,10 @@ struct amdgpu_vcn_decode_buffer {
 	uint32_t valid_buf_flag;
 	uint32_t msg_buffer_address_hi;
 	uint32_t msg_buffer_address_lo;
-	uint32_t pad[30];
+	uint32_t pad1[4];
+	uint32_t session_ctx_buffer_address_hi;
+	uint32_t session_ctx_buffer_address_lo;
+	uint32_t pad2[24];
 };
 
 struct amdgpu_vcn_rb_metadata {
-- 
2.34.1

