Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B3CAC48BC4
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Feb 2024 06:39:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A8A0310EB29;
	Fri, 23 Feb 2024 06:39:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="f8pH08Ru";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2070.outbound.protection.outlook.com [40.107.100.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EA65410EB29
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Feb 2024 06:39:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YqnKu1Sj98P8LmNWermeuLujVO2xMGCrMayn9SdqC+XG3PO4TyRJssoPXZ9KSXRXKPTDgU6gZ+CpAa4KBN+VJH7hDq6iH85EGqyEKAotdQvOtGJs6LUUahFGNiI86dBfnVX7Xu/KoclR2HIJUM3D5Pabp0NuJ/KJ0WoDmtRDeizMBJ38iqcAoFji5F8uP5SAGDSpL/Ua4NRr2AmDhkC3ufGs3edYqlMXl33Hppirpm/2JBbEqm9nepT6+BeTVkn3AUMdDn9fwgDIiv3n0V2ieZfSmu0FJy3Qchy4KYHD+7zrhfhrRt9w3nMvdrIX5W21DSz9eJs7Vv2eqi/IHT4vuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sYkQrhlZcmRTpm57moVwt5dF957d8Fk18JE/qMMlX3c=;
 b=n74/lYawA63Kb4SnNAIn09glAR+iQIUhO7saiDc35vlirRtO2vKeDQ4gBPlSoDhA9jUEfgME4kRonICSiGuvMN/pXxJtBzGmGOPNQIqazcJVam3luRKYZP4Ivi7AvctdgZor+dmanCT8WWVTxLeYd8NTTnzSU5aDcbg8EuIQllkeTL6T/vnGFQJXVPLJswbZK7HugG7ty+u3PMGl/qdBWCeP0KT9HOfdj0uPztHc7J4f5gEegDUE2TFpnOcQJQFwzhr6tZ5ElQlc7nGAiGkeubTE1BB1wSAxKosqIA537C93e4rMKxUFHjmLkMSY+Rvu6VGWaSHoG0qjzg0yZBzOWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sYkQrhlZcmRTpm57moVwt5dF957d8Fk18JE/qMMlX3c=;
 b=f8pH08RulEsqEL3xSGHm0Fwd9U6beFACoeITMy2q8gBaBNfw2b1iMzu2ypahK7WgtBYafkyBoMLZofoHij9dA/jJdiC70zsOYx74oeq/B+gCUlAs3lcZiHXJ25QIKkEDfYt8iyvrRrpDKnbbU10SqzI0qi4GQt14Z4WUcj9SoO0=
Received: from BYAPR08CA0026.namprd08.prod.outlook.com (2603:10b6:a03:100::39)
 by SJ1PR12MB6123.namprd12.prod.outlook.com (2603:10b6:a03:45a::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.21; Fri, 23 Feb
 2024 06:39:42 +0000
Received: from SJ5PEPF000001D7.namprd05.prod.outlook.com
 (2603:10b6:a03:100:cafe::b0) by BYAPR08CA0026.outlook.office365.com
 (2603:10b6:a03:100::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.43 via Frontend
 Transport; Fri, 23 Feb 2024 06:39:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001D7.mail.protection.outlook.com (10.167.242.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Fri, 23 Feb 2024 06:39:42 +0000
Received: from ldev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 23 Feb
 2024 00:39:39 -0600
From: Tim Huang <Tim.Huang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Yifan1.zhang@amd.com>, Tim Huang
 <Tim.Huang@amd.com>
Subject: [PATCH] drm/amdgpu: reserve more memory for MES runtime DRAM
Date: Fri, 23 Feb 2024 14:38:01 +0800
Message-ID: <20240223063801.1940129-1-Tim.Huang@amd.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D7:EE_|SJ1PR12MB6123:EE_
X-MS-Office365-Filtering-Correlation-Id: 6bcd2b10-320c-44f4-35af-08dc343a3774
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0Z9K8JQMKUA6GekK6hKEOmeCsB+7bMVTdcB1tnSOkhoEPJeQtjvJGcJdinwWy+B6RToIoENFD3PHwOEZFPdDzsow28RXZ/j8T/ysabi3XHkAnf+yjkUYrdu5luWRzGu0vRZ05RBD342UG4Pv75puymNC+wLhYxbZzbaTnJ93aA9briRcdnr8E2D3iy8zM2bkEzKuTwIAUcMf1LO2zWTBKEhmA4s4HkoRbmqmTiVfM1ay+lbA2zK6X/yc6Tq3sxSc+Wrzl7KfXQG1K1mtoiUGM93J1k4quHoOVwC7+FpHDqTFB71M0MSUjWROLuu3GPRL2vrDg6c1NG2SEYFt0TMJ9g8RhbGJgGOOhGICWpaaHNTgByqC8Ciaxly1JMmTbQN5XxOD5ZDMbQVBwdYuiIzmR5swKQmULQfqS+s4AeZwInAQVghvSEWmCUNPGiV1HcxiT90YRd+gt6TjnQzhdMf4uWLyZbbnotBtXiFsEkOZ5WRk1bKfI4uoVEVa0mntVBfwhLXYUdAJrHhGWP5DJjqbFrGlxuH3XrtcLuQOV6Z1cBtUsPXuQcN3dGvo0oWGyKKYmgPGz+BVDQO3Xq93yfC79Vjj44WTJDjiie56c8V70i4uzRsOeET4mLmPyPWSW3jZbDWorTZkVSvv426KkyKeuNwW/G013acztKaPMMQ7o8s=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(46966006)(40470700004); DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2024 06:39:42.1471 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bcd2b10-320c-44f4-35af-08dc343a3774
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001D7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6123
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

This patch fixes a MES firmware boot failure issue
when backdoor loading the MES firmware.

MES firmware runtime DRAM size is changed to 512k,
the driver needs to reserve this amount of memory in
FB, otherwise adjacent memory will be overwritten by
the MES firmware startup code.

Signed-off-by: Tim Huang <Tim.Huang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
index 26d71a22395d..36127e204dfe 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -56,6 +56,7 @@ static int mes_v11_0_kiq_hw_init(struct amdgpu_device *adev);
 static int mes_v11_0_kiq_hw_fini(struct amdgpu_device *adev);
 
 #define MES_EOP_SIZE   2048
+#define GFX_MES_DRAM_SIZE	0x80000
 
 static void mes_v11_0_ring_set_wptr(struct amdgpu_ring *ring)
 {
@@ -475,7 +476,13 @@ static int mes_v11_0_allocate_ucode_data_buffer(struct amdgpu_device *adev,
 		   le32_to_cpu(mes_hdr->mes_ucode_data_offset_bytes));
 	fw_size = le32_to_cpu(mes_hdr->mes_ucode_data_size_bytes);
 
-	r = amdgpu_bo_create_reserved(adev, fw_size,
+	if (fw_size > GFX_MES_DRAM_SIZE) {
+		dev_err(adev->dev, "PIPE%d ucode data fw size (%d) is greater than dram size (%d)\n",
+			pipe, fw_size, GFX_MES_DRAM_SIZE);
+		return -EINVAL;
+	}
+
+	r = amdgpu_bo_create_reserved(adev, GFX_MES_DRAM_SIZE,
 				      64 * 1024,
 				      AMDGPU_GEM_DOMAIN_VRAM |
 				      AMDGPU_GEM_DOMAIN_GTT,
@@ -611,8 +618,8 @@ static int mes_v11_0_load_microcode(struct amdgpu_device *adev,
 	WREG32_SOC15(GC, 0, regCP_MES_MDBASE_HI,
 		     upper_32_bits(adev->mes.data_fw_gpu_addr[pipe]));
 
-	/* Set 0x3FFFF (256K-1) to CP_MES_MDBOUND_LO */
-	WREG32_SOC15(GC, 0, regCP_MES_MDBOUND_LO, 0x3FFFF);
+	/* Set 0x7FFFF (512K-1) to CP_MES_MDBOUND_LO */
+	WREG32_SOC15(GC, 0, regCP_MES_MDBOUND_LO, 0x7FFFF);
 
 	if (prime_icache) {
 		/* invalidate ICACHE */
-- 
2.39.2

