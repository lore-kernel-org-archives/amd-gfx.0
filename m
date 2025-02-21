Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACCAEC021B3
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Feb 2025 15:23:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6108310E2A4;
	Fri, 21 Feb 2025 15:23:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pSPgrMet";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2063.outbound.protection.outlook.com [40.107.223.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DD58710E2A4
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Feb 2025 15:23:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n/2cj6p097p2v1IzR1IntY0zz2qXX+AU7i5EK7HPZV5NaYadMM/oJqxICgxsiSKuCl+wtO21ePS65hsD3Qg4DLz6YNnGqFNqXFq0uYZIuXeP4HyNZ4z+noxDhPXvuqKZCjcFbXvFlxqYeec51fuBn705exERnRcZfekOnMIjP9uBNDqZeOS7ySeW4VyRcXkszNPhFXfZLcxLXVgfh2iSQBPOoKkSfJ5tq9/PnJqR9TEafkD5tS4jT0Dx4xzWio4bNbZBVJIpGBVXKX1Ia3VWQKoh/KK56n8iH/rP7d5umBd8OUQYQ1f+cazTW/+iJbRSyTCZkBONQaWKgG/V5A0acw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1C+0Vrj1XXGonPLg7dR4wP/cCObrhqihqU+/1knkkh0=;
 b=aTtVMv72LmwVua2z7rq63dK34NCYTgwzA2Z01tmqyUFQ87AByqN9QwHq8MmUT2xlDlNGDmVKm1FXNWQol1Q6fm3AEkA0J7ppEzqqME+hGAOFHtKTppOffcpeVgCwnthzTjUU18R1JlqZY24wUx8xPff27WIHv+8HqdINxZMhJNHsZOk+KN4A55ZmA0zhIR8diXySy7dvBamOIwadkJ2paI8iyluVFw0RZS0Vv16nx+CbGfIU1AZBqzNAEdEVMO7A9CXrFq+7mIcAlm1eAj+HfoePWSpPdbHX5FMhP6USRuY05OU9v2E/VmBWpmG15H68o9s/IoPRb41SMBuQEPDRHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1C+0Vrj1XXGonPLg7dR4wP/cCObrhqihqU+/1knkkh0=;
 b=pSPgrMetimz1SfKzYwKtjkGqWL7ranCP4BCQkMEsVvzGpNvEh8cfAnJcCazPM+d4AZl+qeZD+xPHgk2u1mjh9ghIrYvJM8eHhFdlA+KCiP6Uf6CXjLJgdeS+Ncog8RH0oSpfGvwxk1HmR/auUGMQxBUBa67A3143gxqHsHP356o=
Received: from PH8PR02CA0005.namprd02.prod.outlook.com (2603:10b6:510:2d0::13)
 by MW4PR12MB7191.namprd12.prod.outlook.com (2603:10b6:303:22d::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.14; Fri, 21 Feb
 2025 15:23:48 +0000
Received: from SN1PEPF000397B0.namprd05.prod.outlook.com
 (2603:10b6:510:2d0:cafe::19) by PH8PR02CA0005.outlook.office365.com
 (2603:10b6:510:2d0::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.12 via Frontend Transport; Fri,
 21 Feb 2025 15:23:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000397B0.mail.protection.outlook.com (10.167.248.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8466.11 via Frontend Transport; Fri, 21 Feb 2025 15:23:47 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 21 Feb
 2025 09:23:44 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>, <leo.liu@amd.com>,
 <sonny.jiang@amd.com>
Subject: [PATCH 1/2] drm/amdgpu: Initialize RRMT status on VCN v5.0.1
Date: Fri, 21 Feb 2025 20:53:29 +0530
Message-ID: <20250221152330.67373-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B0:EE_|MW4PR12MB7191:EE_
X-MS-Office365-Filtering-Correlation-Id: bae32672-44ef-4339-379b-08dd528bbc80
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?poAmODIWvhD51TCQTkYrWkF++f53aljg6EW9x+FZhD5fLcsdcd2+MYg3ctpq?=
 =?us-ascii?Q?MQh8mq/lkPu1LfJ7QzBZYjycsQTPD3+RFrxjzqnIVRzX1zrIKuFmYIOGilic?=
 =?us-ascii?Q?34K6OQQeYyjAsXdl01S66MHWu5jCIkhoxMqrAQMAtIcl1xV1c7T2vCHzs9x7?=
 =?us-ascii?Q?oX6SfzfFNM3Vw4cChA8sR2UHYROyC/rPGjxfqVO9UxMESvhQYx8es4cAdb+J?=
 =?us-ascii?Q?gXU8o5PhPcvyQ0zx4NCrK639VbZXdUqLiswnGEaAHj7Xg28gz4kIHNsoXuUY?=
 =?us-ascii?Q?euQYryEsGGmquNHecWHlneGJBd1In+IQvD440pNwT+hdJ45p31MWZ5oVVxnS?=
 =?us-ascii?Q?LE0OIe9lUTBW1XpN4FmhfmzaJun/SDzi8+sQcIaL6ODIf4mvT6hR0GWf7JPo?=
 =?us-ascii?Q?qEo974sHm9D1LnGfw6F0btbGB7CMGJoBcWE77rlRU5eK9mv6GXUphQ1bMwBb?=
 =?us-ascii?Q?xta1ZpkxHPpibQQgXMKLVdVcJewO9+wFxa/b03LypVMMsmoXktCszcgvAwLt?=
 =?us-ascii?Q?v0ZxvbNN6mbMVvvdzCvxYrIplTdZN5coMS0ppWBlYLqUrGhxLJngSvRlFAUs?=
 =?us-ascii?Q?ZHq6czcIwkR+Q5om0HfmbgftIQ65VUexKycFdUqDxFuy+fOzY6/ITESXByUl?=
 =?us-ascii?Q?Zy173EYIGZkjEkuD/MrfWbc7jyrIMa1ios6makxQFWAsOsQwQQpQVrc6oKX2?=
 =?us-ascii?Q?SV/kioBKh3ogqnDNNjOL5Qf6+Bw9tR0RD0S1rZgyIZ1MpRPK9vtn71LPIHr9?=
 =?us-ascii?Q?8AP+mjYhqNRT0O1b54HChR4/2C2YCFH18B/b9GW/gU3VBQ2Km4KoSKD/ugvM?=
 =?us-ascii?Q?Byjmux4+uzwyOYYvtWAhVzQUv9HAdJ4gHk7U1yQERu2QtWIwOSS83wkCbwEL?=
 =?us-ascii?Q?TcmZlcmStUi0nQwXjHOmzJM09G26N/QrrUtrC/MRHZfgKWxiUJo9GWsQb9Yd?=
 =?us-ascii?Q?n7mz5SEc/NU9e4nHY3+JOzjv/gsQd16tc+7IFWlvtz0s2WToy1iPhqu3jO64?=
 =?us-ascii?Q?Lqgv2H51we9EAYJVEqe3fiSgJ1h0MFN76DY84fdD1QMjNYteqIcc7cC8VTId?=
 =?us-ascii?Q?4as6W9fgsXqSFQLaQCWXjP/gd1odngyq7ge1mrPDYVn8lbddIpXcPd7Obbrx?=
 =?us-ascii?Q?xpZvuM04jOlzH+NoXtS/ZUQ4wgVOoyvuKfvND6GJz2pdwgbgmczMye4au8p6?=
 =?us-ascii?Q?Wb5qWLBqaWS4t2PEwfHRYCVBe3/hgvxaO1hQlp8058lBmBDi0pilxusiZVf/?=
 =?us-ascii?Q?0cI7nrQ8LoRcffIZg+wI8MXY24qOgca4lmsbKGQnnfH5+HOFnuD0zmVggjTM?=
 =?us-ascii?Q?u/5ftB6qrKRTGvzoxPJJPFD0plL8UEj2yBzLzXQ55ei0c1BnZuYTQim5eAro?=
 =?us-ascii?Q?+IW5NDHkxNB9v3uY1DgJEjwUkx6h+ZP5hy2agbLqLFDgCnvaZgezPf7OzdJJ?=
 =?us-ascii?Q?Mp4/VhnH/VTVOE/gdYJBSM5/a/wC3+7MdQO0F+zm65/5F8IyFoBOd2Epqs/R?=
 =?us-ascii?Q?Wt3PWLBb2It6Qns=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2025 15:23:47.1992 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bae32672-44ef-4339-379b-08dd528bbc80
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000397B0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7191
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

Initialize RRMT status from register.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c | 2 ++
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.h | 3 +++
 2 files changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
index 721c29f52451..5472b4ff6578 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
@@ -178,6 +178,8 @@ static int vcn_v5_0_1_hw_init(struct amdgpu_ip_block *ip_block)
 	struct amdgpu_ring *ring;
 	int i, r, vcn_inst;
 
+	if (RREG32_SOC15(VCN, GET_INST(VCN, 0), regVCN_RRMT_CNTL) & 0x100)
+		adev->vcn.caps |= AMDGPU_VCN_CAPS(RRMT_ENABLED);
 	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
 		vcn_inst = GET_INST(VCN, i);
 		ring = &adev->vcn.inst[i].ring_enc[0];
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.h b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.h
index 82ac709f44bf..8fd90bd10807 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.h
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.h
@@ -24,6 +24,9 @@
 #ifndef __VCN_v5_0_1_H__
 #define __VCN_v5_0_1_H__
 
+#define regVCN_RRMT_CNTL                          0x0940
+#define regVCN_RRMT_CNTL_BASE_IDX                 1
+
 extern const struct amdgpu_ip_block_version vcn_v5_0_1_ip_block;
 
 #endif /* __VCN_v5_0_1_H__ */
-- 
2.25.1

