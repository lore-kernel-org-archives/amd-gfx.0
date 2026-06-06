Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03547CD8C8C
	for <amd-gfx@archiver.kernel.org>; Sat,  6 Jun 2026 13:33:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 61141112E2F;
	Sat,  6 Jun 2026 13:33:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="p5vRKLcf";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012001.outbound.protection.outlook.com [52.101.43.1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 23ABB112E2F
 for <amd-gfx@lists.freedesktop.org>; Sat,  6 Jun 2026 13:33:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tFA1E49HlKWUhZ7H9Hvzc8yUL/P/UzAphMPwoCznaChZ+du8Alk50RUkbSFIR7FetzJQiPS9uR/U7+EAxi7e4OMihUiYJCdd50WySOX5sLuYwQoz6k4S5g+9GozqWPgeH0zI9hugpAEeNBjP6Ss4JmjLaOzxsBojGkP5pF0wna0Ba1OgGBayBk2L/TBW3SkNX/o1DiY/KMPtVI0Pti7C1mjFpQItynU7MFVvSKD4qpRmBwi+x9maGwUeKoidzB5sbtFp3AEv+s0I2l9OTXeX17Gd5OhTgUd5TdOWaraRcX3C6Vka2rB4YRpWs0yZHORulw1sY+AGm1raTq6WFdBW5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QYK6qLiA85XQ21fdKH0wqmBp6EPzya41uXvs6n7nY4M=;
 b=qQOP395S8ZBOpZ+nPQ8TFR+6r2lcJVR8YK3aN2HXqE6Ej1KzyCBRORVwFZthW5fsI6ND0aoGARieXnZDSMrUkzomVNRcN/YLRdCblVZcL5aKjzJn2PjkGPPyhp6nwND25kg1oO8z2SYTvJRnffb/feX3Das96/VZ7TF7Ltn7JMGnfw+SNd4VEsSiSQlINw6GDK/MGDBxw+vY0TWcqu/6jUP0pnBqXzBSZ+7eXHN3td0mBi2ID/DSbm20bXx+YvuaMYwFMj5NmNh0qDO4lwYGsrj6m4nj179ZYCKYkucdBo30NaO3JE5Hm+itUCRApZ8/31sip7kuDDVk/twXbBOsUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QYK6qLiA85XQ21fdKH0wqmBp6EPzya41uXvs6n7nY4M=;
 b=p5vRKLcffpstGEvknKdAJBiJGVqhVkpjpKlHyGbvjJkdd7cimIJukqoYTTj4TgQaTcsGFPGm1MNkRVfmowPxW9zJ2WWZBRzpmHMFhZMHf4KO0AXilpXceG/4wvzqsGcuzpw+GF9t5mhcuAP6rLT8sCkZ9jF4yBzbtYv6bJ679fY=
Received: from BL1PR13CA0233.namprd13.prod.outlook.com (2603:10b6:208:2bf::28)
 by DS5PPFDB3A23D1A.namprd12.prod.outlook.com (2603:10b6:f:fc00::663)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Sat, 6 Jun 2026
 13:33:27 +0000
Received: from BN3PEPF0000B073.namprd04.prod.outlook.com
 (2603:10b6:208:2bf:cafe::7e) by BL1PR13CA0233.outlook.office365.com
 (2603:10b6:208:2bf::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.7 via Frontend Transport; Sat, 6
 Jun 2026 13:33:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B073.mail.protection.outlook.com (10.167.243.118) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Sat, 6 Jun 2026 13:33:27 +0000
Received: from sunce-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Sat, 6 Jun
 2026 08:33:23 -0500
From: Ce Sun <cesun102@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <YiPeng.Chai@amd.com>, <Tao.Zhou1@amd.com>,
 <Candice.Li@amd.com>, <lijo.lazar@amd.com>, Ce Sun <cesun102@amd.com>
Subject: [PATCH v1 2/2] drm/amdgpu/ras: Add flag to make VBIOS read optional
Date: Sat, 6 Jun 2026 21:33:14 +0800
Message-ID: <2947e43d752f7a77d99621b29a396fb620ecccf8.1780752510.git.cesun102@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1780752510.git.cesun102@amd.com>
References: <cover.1780752510.git.cesun102@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B073:EE_|DS5PPFDB3A23D1A:EE_
X-MS-Office365-Filtering-Correlation-Id: 015e837a-4173-496f-828d-08dec3d030b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700016|1800799024|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: GFAdifIFMFqXp+qH5VcD2r7R3XEzceOo/6nNTkcBiIGrvJf9WaDqIZojhb/NjxbF4VAOSvVQIx5AEO74hE6fVTIQzgZ4Y9/00tZ/wkpQrPG7Ch8/QEQta5/efP2rjV6Kx/z2QymzwMEsEZWdj18KY4hae858Fx2G77CU0g/VkkeXIfUaNspmHeQRICCB9alUocSSf5SktVlS18VJafzMG6vTA/RxZMlkd+neFcMPHGZWYE4Px6wzPq1y1zUdyPW7KAK4W6kGhbOIYfBcXdlHVktOdc0icX4N9V9YWIJe84sAVRYsONWIys227qfDKEmIoXA9JMPzkD1UleCzwdG+ZDqAxYjRsfdipR2E9w2sUR4rOCmhPQskRLhUdHlsrhZbJF2thS067AD4hDDO1C8lwqLqy9YPM23q4tpw3E94BzRwMVMaqONjOAR+Xtg1mgmTntJGg+rHL/6v9IOxhNYoYk6b9gSA/ieR4Hfzupj4KusPs25IBRXik7jvmxwgPFiT9Nk/lZUxnFCGQVony/aEdU/bRu4SL/deNYm6Fr3OPcUrQ5m3LOSTlCsTZk/FNXni7twhHXeWQqKC5eeznF3R9rOxv4cq0qfxM5AwYMzxrr4ZHFnXzd+MZmUzNgt+OWxw+5ddqpI6ElQwWvbWxZ+TEllgW/rKsJFgVG8K7dWwripN5mrhDr3bTP0YfeF2a9qwqnx8JQMs+Pticq5Vc2uDrZCav+qjaTz65DZu9NUA8ZQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700016)(1800799024)(18002099003)(22082099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Li9+47WjkJAqK6nYK5suC9QlBVIn2dIt67fkKISm8aC/0nbiPduX98Ta1J6ccW3h5LHAXZ/wSujt7bcD6dqeJMf3QF7W7PnLHZndgc4G1wW8v3hCuVB3PqG/Lr6QygBGFDyF8L44bW6X/+Gh+b++w+7yV0b98ShsQIZ58QsxgV0FYWYcd+wRlgdASD9JYLFka7oiiH7RaAE36uXHNjpYA0rHA3sfkgCHBms6rQCzm4M2Y1Qz0aOFktzu0sNKDWpFnSBCgiG+nZybkJEdhmh0/Ey61PYQKKhuAfOwVd/dDF73AAXspW9a8EpTF7qaiRegpjJd5AFaArIYRuyQUjqMMJFahy/8ShFcEdDjajs8zBT27lElVGVAbv9FAr1fhyLtOOMH0TJxdH3GCYjQFbb4dYsaeWw/fFrQxuLv3HsbFJaBt9ujP0iLYDcNXN7ML5mn
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2026 13:33:27.0599 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 015e837a-4173-496f-828d-08dec3d030b5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B073.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPFDB3A23D1A
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

Add flag to make VBIOS read optional

Signed-off-by: Ce Sun <cesun102@amd.com>
---
 drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_eeprom_i2c.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_eeprom_i2c.c b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_eeprom_i2c.c
index 3ed3ff42b7e1..9c6d0024210d 100644
--- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_eeprom_i2c.c
+++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_eeprom_i2c.c
@@ -67,7 +67,7 @@ static int ras_eeprom_i2c_config(struct ras_core_context *ras_core)
 	struct ras_eeprom_control *control = &ras_core->ras_eeprom;
 	u8 i2c_addr;
 
-	if (amdgpu_atomfirmware_ras_rom_addr(adev, &i2c_addr)) {
+	if (adev->bios && amdgpu_atomfirmware_ras_rom_addr(adev, &i2c_addr)) {
 		/* The address given by VBIOS is an 8-bit, wire-format
 		 * address, i.e. the most significant byte.
 		 *
-- 
2.34.1

