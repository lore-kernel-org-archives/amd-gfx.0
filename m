Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1ED9E7716B
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Dec 2024 04:22:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6743610E0CE;
	Wed,  4 Dec 2024 04:22:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gRWUa8Rr";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2087.outbound.protection.outlook.com [40.107.244.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 002DE10E0CE
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Dec 2024 04:22:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Iw+Ww/RNr6r7mSU8E/0KnGREUa5wD+yiRZiDIhRH2fhpkMfw2v6DWxv96eiONU1g9p3wHuqbK8UVjzvZAhVf39P7/C1aPUOu6L3y6BAdhzaYZwSQexFVDN6jpiwfIFcMc0NA0s71xHCJ58uYQhGgOEAXH0jnU6LP4OYcT09C4bWPRz2zlS5WDYxSg26fMM/G8DIllEy34SWM/ETUftm2GTIbtwsA2TTg0As2cqeJ5EZYkYWX8U1cw7gWqd2zWc0kZ+2gUYaSa29A1L0gQFrJMu0t+wcDDRMMyF0i8sYvhqSqkiFHRSG7yRVwXVf3D1Qr2zTdaQXOn0/g+g/zcWCtdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/yJggp5EpleW4QzMvkhCk920itSgXQZPVnf5mg7DnlY=;
 b=c8hD/BELo6iRqCTW4iPq+Z02Gq2376Gt9MFQRJpZGms767C5Q8oxniyLqsLe9ayTzMEIqzMHdU+qefS8C5ZrWuMBh1MmigfPMAC6oJfEsvAIvN6rsKe4G4luMbDNIFdGF94/8rdJBCaXUxU6CbEsVdBcAM7pQzxLvxrZ1++kbgNoChuD9MzezE9lNavPn+vfqyFA0HwPOtjVW5vagJ/GggLUvKfd2v/2Ezf3P6h8u7XyKLTWs5u5fF/bag7ILF3gwVctZbxFH291dpJWPh4b3LygV6yvPRQryg0jEsAFt/BecNkDuN8pSucQJ42V9p/n0cSGh/jqLnJImwpgu9v3xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/yJggp5EpleW4QzMvkhCk920itSgXQZPVnf5mg7DnlY=;
 b=gRWUa8RrFzPcJHaOW7DGwOSsgmyISwTC1g3GvY3rt0xwAOkJKrRgOgNNJnKgiraHosk+CZDFm4A1ZHd9LTvluXxmt20BXrPJggVh3IwZ5cEYQMSGt39ZysaFVLOAEGorTCJyDifXkFir8obJtTTI2OR9FlgpBaSm/w3qtvzx6J8=
Received: from BYAPR21CA0014.namprd21.prod.outlook.com (2603:10b6:a03:114::24)
 by MW4PR12MB6708.namprd12.prod.outlook.com (2603:10b6:303:1ed::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.18; Wed, 4 Dec
 2024 04:22:18 +0000
Received: from CO1PEPF000044FA.namprd21.prod.outlook.com
 (2603:10b6:a03:114:cafe::e7) by BYAPR21CA0014.outlook.office365.com
 (2603:10b6:a03:114::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.7 via Frontend Transport; Wed, 4
 Dec 2024 04:22:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044FA.mail.protection.outlook.com (10.167.241.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8251.1 via Frontend Transport; Wed, 4 Dec 2024 04:22:17 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 3 Dec
 2024 22:22:11 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>, <Asad.Kamal@amd.com>
Subject: [PATCH] drm/amdgpu: Increase FRU File Id buffer size
Date: Wed, 4 Dec 2024 09:51:55 +0530
Message-ID: <20241204042155.3494660-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FA:EE_|MW4PR12MB6708:EE_
X-MS-Office365-Filtering-Correlation-Id: 14bc1e10-fde9-4fe0-d50a-08dd141b3cef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?TZBmZmy6b7pN6f21q1iHR5+uAP5vB3/VGOip7V78wV/r6C9jw8iOawjJLekX?=
 =?us-ascii?Q?mK+v55n3TX7Xj+l4YpnK2DpXBc8l18WheYG+sVJZt9JGDmGrxXr8UGuPJ1Pj?=
 =?us-ascii?Q?9tkhIW4wJc3aIqREENBvk5J92mVH394pwg9hirj+swGrhAUeLhpMejQ1yOI1?=
 =?us-ascii?Q?HW9ZBotF5II735SKixtGJbKlUfF4eUKKeAn3fhla3NMvSMFznQVHMREqL/mo?=
 =?us-ascii?Q?4041q2ahz9k+PWY2AQHwyvk4NGucpHSsOX/FFiGbrDC02+s6Wll5G9lTa1WL?=
 =?us-ascii?Q?/NYiWOUn6kUM7vAMSSBPqpVwNAl6OYgXsGDymZR950Vvcfutay3ZAe/qRFNP?=
 =?us-ascii?Q?N+FAYRtPf9rqHA+qwZNBMHSXgI2E9lPepK5MUnDTDBDbb+sLOmUs3IWyLcXU?=
 =?us-ascii?Q?Mp0kG7nyEnEBWYbTUGDFDaydt2mazMWG/Qs0IobPXmfy0wTeFWSOcmodOjDl?=
 =?us-ascii?Q?rpC6iTVXFRXxOZq7AAbfxAH/laHj2WWiF+tT4jdwhZBEKMYDTZFE/QGZFaLL?=
 =?us-ascii?Q?qMkOzzBP/lnHdp5ZCIXvM88c+WYgg9TfXQkkpFAgvhsF4LIFzk1df33bU5Lb?=
 =?us-ascii?Q?KBE3F6DoRRr2AqtW8YSA1cHImiiyWcsXhXQMTEMdi15JpINr+9Qi8o+ZAl3w?=
 =?us-ascii?Q?BpiDFyy4LU/JNBVn9My/meScamyxI1lWdM4PHkKvjOKjSsHJfKq9zX/aNgBi?=
 =?us-ascii?Q?9H3kSILUkdjPeebjFBtwD8zTKr1GWjLHz3NPrzAWUo5qxw5iOzV8r0HgHG2W?=
 =?us-ascii?Q?MiGRgz6Ra/6vEeTG2YQxhcCvCvHFne+aTPQrY9+uF/2NTcbLit/7n+/hWS7V?=
 =?us-ascii?Q?pUYrmVyqYmnDfUkjNRN7bx4w5YpdBSRLg6kvM77xmnM85Se9+KlP3K9DKLEY?=
 =?us-ascii?Q?2cXMRs1yf+rebs0E9vmosx/Z0vGYkRfxR0H9iLTqIfazgVT/V6NVPWJvaIJF?=
 =?us-ascii?Q?7S81mVzP8GQQCpEzGkaIwLNFMoMJKjkq1si5csth8dEk/qdqjZX33QeqpKYT?=
 =?us-ascii?Q?V2QqWAnesrgoeU9Qwu1edYZH2+O5wAqH3SNb4L5DXmHKWFXHwdNuxi8iwxR4?=
 =?us-ascii?Q?ZC04FsWqP+WNbka0U7T4dqjt2/wCFIrgz/Hgz+qu+mGFZyl+uTmvdNk2zB+Z?=
 =?us-ascii?Q?PahoWDvK3uFjvCwxuE2M9t5Y4DSa5jTzxyFRXqMahjVgt9e0JMgCqaQvp5Ig?=
 =?us-ascii?Q?MYmLfLVIJttf0fecplX2TJT1u7Fq1X/BuU37wUkBzP3OJ9q6czqDIqr6yKkg?=
 =?us-ascii?Q?tiOw1Je+eVjqT+pc6ac8P0C5DOVKK1tuBtSXsKvz7L7PvnVmjk9K2FGLm6PP?=
 =?us-ascii?Q?BoRBFawLvD9Otq3n/g7bWOuD8FNIpRQB1c9An47483dRiWfwmNb2SUSBN0P2?=
 =?us-ascii?Q?lz2GRVp9O64LDa4Gwt9/oEeOEI6BGE4EbBggneq3Ej+AuU7mmAt9hnNIJHqb?=
 =?us-ascii?Q?rlAKehTT1YOBEGjeAxAiLA4KHYHzPwi0?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2024 04:22:17.3939 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 14bc1e10-fde9-4fe0-d50a-08dd141b3cef
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044FA.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6708
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

Some boards use longer File Ids.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.h
index bc58dca18035..98f3196599ef 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.h
@@ -32,7 +32,7 @@ struct amdgpu_fru_info {
 	char				product_name[AMDGPU_PRODUCT_NAME_LEN];
 	char				serial[20];
 	char				manufacturer_name[32];
-	char				fru_id[32];
+	char				fru_id[50];
 };
 
 int amdgpu_fru_get_product_info(struct amdgpu_device *adev);
-- 
2.25.1

