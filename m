Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36011C982E1
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Sep 2026 07:53:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A7B0010E364;
	Mon, 21 Sep 2026 07:53:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="le18Iz7J";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012003.outbound.protection.outlook.com [40.107.209.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AD2C310E364
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Sep 2026 07:53:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pN5+BEAJVKAuTZJ1DKiPguZa8ZPpcu2iFZifbijNZ+mKmOLqIVCRy3l+peBdNGnfpE9D4+12wkppWU1Wnyw/XwjdfZlX0CjmBagxxG8ZQTaIqjZXP6QeuYgYH+75opB6S2tqZAA1hswgtNkw4XGbdMX/QGQH4QcM9E7jhkI77YHzPeDEuuB7/W0ilJCRQ97y7ThMrH/j4TOcFz3WPeCgHa6m3lRVSQ2wAyag1WPxYHepw3dD1TWiocOCp/AjG1wOC7CUffdAWpq/HpWTwyb26+jnLe2Sh927qQvK4XCMMkGqeqzHo1t8TNgPBXaLsBRpSj055UbDIhJRbhDqtkX4Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w6VBbPQCTIynQD1Ufdh4zRkpzeZpk4FGA68Cvj/Zg2w=;
 b=p70okWke8zvxB8aSHQCIlMqeTc8vcF3ZHvHOLEStcqUAczTrDFPOSG0TvTog+reg0zzFH7FlyTRutmBujYqFYnn8aGW53OR0xamexTBfzyXshvX77i5smZRMyfhAB3nu8G+dfsqP72yxuAzNNJw2DlHg0TNON+f5emjMGqosgMYU4hoPUk41RERz7QcPBAr70T6EhP8B+1uJ+rzyxjDT+lfBpzrj/1vaa3kRU7lET1I89c8WeyGrKPsWhmGNwXHIn2Pbos63OlWRaeApQiz75bj3BNEfb7qK+R5Dg4VLokKxLFIJrn98tqfFXTMaED8KQuRZJyH4y5XRvl2sKoHGPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w6VBbPQCTIynQD1Ufdh4zRkpzeZpk4FGA68Cvj/Zg2w=;
 b=le18Iz7JoeLhg5ldap0jz5sfvlQxyI73ZojmZEow7tdS0OQTdETROqmWRORvAj88PoFMK619gSx193VTvi9ETGtOP1FdzBXVjnjE4aYhte1s7i5f7pkvWPicYXcoS9VjE2nBPAmjpc3prG5PSmBAn7MJ6wHukKi11l/rrlrElRk=
Received: from SJ0PR03CA0270.namprd03.prod.outlook.com (2603:10b6:a03:3a0::35)
 by DS6PR12MB626099.namprd12.prod.outlook.com (2603:10b6:8:4c8::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Mon, 21 Sep
 2026 07:53:51 +0000
Received: from BY1PEPF00026957.namprd05.prod.outlook.com
 (2603:10b6:a03:3a0:cafe::5f) by SJ0PR03CA0270.outlook.office365.com
 (2603:10b6:a03:3a0::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.16 via Frontend Transport; Mon,
 21 Sep 2026 07:53:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BY1PEPF00026957.mail.protection.outlook.com (10.167.244.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Mon, 21 Sep 2026 07:53:50 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 21 Sep
 2026 02:53:49 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 21 Sep
 2026 02:53:49 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Mon, 21 Sep 2026 02:53:47 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <Lijo.Lazar@amd.com>, <Prike.Liang@amd.com>, <mnovales@amd.com>,
 <Jiongyu.Zhu@amd.com>, Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH 10/21] drm/amdgpu/gfx11: set KMD_QUEUE for kernel gfx queues
Date: Mon, 21 Sep 2026 15:51:17 +0800
Message-ID: <20260921075326.2409021-10-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260921075326.2409021-1-Jesse.Zhang@amd.com>
References: <20260921075326.2409021-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF00026957:EE_|DS6PR12MB626099:EE_
X-MS-Office365-Filtering-Correlation-Id: e2fea310-8c44-44ea-ed7c-08df17b579bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|23010399003|1800799024|376014|10067099003|56012099006|22082099003|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info: QJqeoPx+ANs+i/POELfQX75gk3aRncGlRguGt+3XDlyh7t+GgVtmHOmS5Wj+jPquV7C8uOaRRQQhiZrELH9wdkhZNb9dC/A3mi9q4tbeY61lg47VrI8/bIYu/QvlZjVQ/IDBQ6BV5JC8GkFtPsn3wzesDocb9Q5655SS1JG6KqeKgTelCnugWHm3EHBcvdOTPhx7mduMlhktVo4+npi8u6YTHhpu1svuu9Hm8hLOWBUfhGY9e1YlNyJUf+fv+jC16AnfXWPygv5RmBlJRtpNpiqK+ACT0neBAThqUAj3FKnDK7bAscyqa1dIo5lYK4ZEcpcIeS1kg54dnKtyqIUjsbkibY/wUc3tLCp6gWT1vrcaMAG+Wh0YSzrs0pqBTXecIuC2CDt/OTVi0xLHwm/zOxHDLtAhZDVDPKQso4OfYodEf4Lpt5AeAdrM68g/lGbhDgklKGv/DMhmpKD364m5jOWwit30EzZIcgzD+cBrcnO0GPZaAwb2AmWOLkDW+1QC2tz84FEMd7rtrfLcOrj4DX6xSrHkKaTOZVgnsZ6o4yisim+X0f8lR/+xhtKV16Xj+aL+O4l/DuQOURs7goK9MgcLGbSZeAMf9gq7FLss8NMHque1rQbPaGqrLv8nYvjdlycFqpg+0RFGHOMsmYom+gCmCZJRKhguxRYxaMOnjxcag5lZyghKGO5Zq7E5gfYR8d18BJPe2mAXjSz60uIzKQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(23010399003)(1800799024)(376014)(10067099003)(56012099006)(22082099003)(18002099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: hrFjTxh4VHiSj44+31toKn8ymGZSiMsDvY5G7C4F94CqlcaS15p64b8H0y//yZIp1pi2GrJYNtONCrLjqGBTpLUxBtYvZ9/++CCHwJlsszvtiKeCKHr2bIB1sWeEvGku6SAWXa8DwEWpbk2yQK34V78398bSbWuS57CRB5tJ5b1HvM46UGVZljhhkwFl1sJs/ooJMFScKF137lTrGT3FUccbVGPX9coTmf9OGAalRuC3Xbh38ZP/L81qwsOc3qrAQoa3YvGV3Cdc+uWF92blwGU2qa3A9UONkjfwLuBAPiUglYrKYFg7jHL0Uip/2Vbj266+nP51QK3RXEUUZlyX+HayTLTikftroe/eP7MJsD7+pSoELyfYWpsHBoLuLbrFyUgxWtriYMiOayhJdcX66qHHIO82SttsXbMcHyeMn/zst6tUzecLWNLJrMfBNyKe
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2026 07:53:50.7496 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e2fea310-8c44-44ea-ed7c-08df17b579bb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BY1PEPF00026957.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS6PR12MB626099
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

Set KMD_QUEUE in the GFX MQD and kernel ring control registers so CP
preserves kernel IB VMIDs instead of replacing them with the queue VMID.
Use prop->kernel_queue to distinguish kernel and user MQDs.

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 76e133d283a9..5ed70bbf5313 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -3850,6 +3850,7 @@ static int gfx_v11_0_cp_gfx_resume(struct amdgpu_device *adev)
 	rb_bufsz = order_base_2(ring->ring_size / 8);
 	tmp = REG_SET_FIELD(0, CP_RB0_CNTL, RB_BUFSZ, rb_bufsz);
 	tmp = REG_SET_FIELD(tmp, CP_RB0_CNTL, RB_BLKSZ, rb_bufsz - 2);
+	tmp = REG_SET_FIELD(tmp, CP_RB0_CNTL, KMD_QUEUE, 1);
 	WREG32_SOC15(GC, 0, regCP_RB0_CNTL, tmp);
 
 	/* Initialize the ring buffer's write pointers */
@@ -4258,6 +4259,7 @@ static int gfx_v11_0_gfx_mqd_init(struct amdgpu_device *adev, void *m,
 	tmp = regCP_GFX_HQD_CNTL_DEFAULT;
 	tmp = REG_SET_FIELD(tmp, CP_GFX_HQD_CNTL, RB_BUFSZ, rb_bufsz);
 	tmp = REG_SET_FIELD(tmp, CP_GFX_HQD_CNTL, RB_BLKSZ, rb_bufsz - 2);
+	tmp = REG_SET_FIELD(tmp, CP_GFX_HQD_CNTL, KMD_QUEUE, prop->kernel_queue);
 #ifdef __BIG_ENDIAN
 	tmp = REG_SET_FIELD(tmp, CP_GFX_HQD_CNTL, BUF_SWAP, 1);
 #endif
-- 
2.49.0

