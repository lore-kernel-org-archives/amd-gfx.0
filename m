Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3C72C87FC9
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Jul 2025 07:43:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 607F110E0A2;
	Wed, 30 Jul 2025 07:43:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="odl6B6A0";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2040.outbound.protection.outlook.com [40.107.244.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3CBFB10E0A2
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Jul 2025 07:43:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w7M/LhC4GPCx8NVtHEgubuh4VBv/CmQWsk4JOMyrOOBYAny9FY7LWI4VNv+yOwUltkA8md+vkYmOksdWIZLpUYzjjoBe7W6vn4ZEc/9n4z6wEuvuengix4jIuGjFEHaY8t0bayROEmCuXUTWIvc75S++eSz3uwi12whkXm/2dY0gT5GIk+C/fkCwlD9DtQvVh+9hv+uqLrNfDsR7mhgP8YGyM5+vrt5wN0xNtuzaha6gtIwfUxBzdn7jbh6ZVtc9nd2yKrY9HGAu76a7tKi1YxOL5485qEIWwC0r1ZQiP6rWC8+lFB346QsAZ3EqAbPl+/gfENHMggXUHYalOik3Uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PEiNVmAGsC6CmRVx/mhkeEprNm+4mZYM580onq6WGJ4=;
 b=P7ZXKOIxvHh6n+zf8wZ0EMr2uobYiafU/RqPyrRGP+WCc9mpcKC8H/6xQm9RgqA/qB8PqJFSkA5zWJX9zxNFbtpJJEHPR+YH41PPp1Vz6pLZ3e202t361g8z9RZDsrDsS2xovhYhXfdqLY83D/2GoYWBt9LqYTOK6+nvDMe8nsk4kT8OC8O2zykYq1CtKx/7iT8IhBIZZOW/ghqAq5Ean2/NFp0pc8qgwaLVwdgTTetHHBKYZKcAfOmi1F70K0x1i0FlD0gQh8cEZxZiyTC/IvqsOAB/aiyENVbMYgT2DvgTQyvT+wsyX6Ty5YImZC/99q9jTw/ggG4szkGaYfpt6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PEiNVmAGsC6CmRVx/mhkeEprNm+4mZYM580onq6WGJ4=;
 b=odl6B6A0pLxOXsdPWIzQipmrLvF6hTtGOMkxzKbk29/iVX7kNSj1vD51TSV41eWrckskbjUdEwYkGfbDqk0jWvaCgmcie/oIEU3NaBQZ7qFz6Wdt58bGc+UfNocdM0c6sExApNpcp5M1/Rh9aMpR4TG2tmUL0NjAacJa5ROzpuU=
Received: from MN2PR22CA0011.namprd22.prod.outlook.com (2603:10b6:208:238::16)
 by MW4PR12MB6732.namprd12.prod.outlook.com (2603:10b6:303:1ea::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.11; Wed, 30 Jul
 2025 07:43:53 +0000
Received: from BN2PEPF000044A1.namprd02.prod.outlook.com
 (2603:10b6:208:238:cafe::42) by MN2PR22CA0011.outlook.office365.com
 (2603:10b6:208:238::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8989.11 via Frontend Transport; Wed,
 30 Jul 2025 07:43:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044A1.mail.protection.outlook.com (10.167.243.152) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8989.10 via Frontend Transport; Wed, 30 Jul 2025 07:43:52 +0000
Received: from liuxiang-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 30 Jul
 2025 02:43:50 -0500
From: Xiang Liu <xiang.liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, Xiang Liu <xiang.liu@amd.com>
Subject: [PATCH] drm/amdgpu: Skip poison aca bank from UE channel
Date: Wed, 30 Jul 2025 15:43:13 +0800
Message-ID: <20250730074313.55516-1-xiang.liu@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A1:EE_|MW4PR12MB6732:EE_
X-MS-Office365-Filtering-Correlation-Id: 79ae5f56-762c-45b5-b6b2-08ddcf3cd477
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ww0uInP2Gbe5v6/fs4a6LK01fKrkrd7wpEryxnVNRYx7vLBeoIOhHztXT/GF?=
 =?us-ascii?Q?arCkrqLymIxMYrmx8/2YAORkjL7ru3yU2S6ZbdJ5OtTBF+OcaxsxMWrMI0XB?=
 =?us-ascii?Q?aEkA09OGLiwP1uTtoSYnduDYc2xI5FxhikRojCFyTFojC+PkIiBHTn7Wp6iC?=
 =?us-ascii?Q?tU9z7bMGtp4hVJ1vhey8tNc/ibGguL5FHLGYqsO2oLz3CnxR8FJlWAHTdE/O?=
 =?us-ascii?Q?zCxxF00xrrN1+yiCpADub//BLtPF/kqrSxsALaEOFmxQ/wE7ewDRcto+UsLh?=
 =?us-ascii?Q?ktNRx4OWWitrIex2q1V3wLFyIJexYHQZdwVgm7IwwaJmYlj32Q8fX2G49agf?=
 =?us-ascii?Q?gNLj7+YWYbTm/fwebnMs1c9HNjP7Ys/luBI3kvj7yoweAnnlN6RB/yYSXO00?=
 =?us-ascii?Q?1QMJ/vl7FBkq9F8NEcel+7G1CDPiVe8Ifsbva26O1uRsXKW5tG09EBARiLd9?=
 =?us-ascii?Q?vjVYCPmFTX12Yd9/NQn5HdrQqtSteT69J7gLu1sYkmTOhFL8/U8YgyVi9hD4?=
 =?us-ascii?Q?12W9iKbozOiPX4VXqTIFT/Bz7h+JgbIR7crdbb0UeZHdaqE662LlIm0C/Nsh?=
 =?us-ascii?Q?fXcqDtYy7sXdCGQbaEkcf4C/+oc6DrNw26nU59+ogDzduwWq2qI37y+3T2Ai?=
 =?us-ascii?Q?bZWT2zch1lfa/lFhlKgPuxm8INpVIjeGrmGhIcdX1/uC6fgA01PigKFFbZOs?=
 =?us-ascii?Q?EGuyx1qmiA6AmO1au2pC1yG32dBDR4k/M9lN6WfxGDUaoJgvO5l6IZzauIhN?=
 =?us-ascii?Q?hVLoVT+1YbyLc/2U0dFX7DiP1NLBm/+5qzR3QrPLKxreAUUO/DzG8dV0udAq?=
 =?us-ascii?Q?54yStDbaSjn9DvvKFttmfxJluJYMwwSjVnOrNrLy43+8LWYzMRr+czsCH+d9?=
 =?us-ascii?Q?mVoNkeRjCDj4YzAlEBgbkS5ZYVlBR0l3X/3bwwccI2530O4hYUOSxiV/JtqC?=
 =?us-ascii?Q?Yc2hzUMfsz/Io6GrHmFwQpJPcOD2H2az71iR4AwOJjBdusU3rFY489dZcxfQ?=
 =?us-ascii?Q?FRSyiwWWA5pEIL8qtR19lw94WvLZTW8AvNuXXeq20pK9oDVpbVssC4C2aQik?=
 =?us-ascii?Q?zQzha/E1Lhi0hNPospuptDL+GrmtxJZApNs9BSm6iKBn0VcTKG2arFuL4shX?=
 =?us-ascii?Q?HesdggfeFixuaIeXyxIs6uNgQ7JJ+KPvaJHdJpxWf+1GfIT+NqBR8AsXzu9h?=
 =?us-ascii?Q?TSa0MUTCnPuhy/Q+k6QXya4sqIJoItTA4CiDaxrv9TRKXu1SpkdPPDKncskQ?=
 =?us-ascii?Q?30HUJbJ9NoOF7HC4ydTWM+fJ+4LSrIh1Mh6zLcrHEodyua1hS1FimgXFBURl?=
 =?us-ascii?Q?XP03Fr26FrLcP7tO8JoicUZlGD/FrwiV0FKJtb2OPyWpAvLl4t6svp45BzEx?=
 =?us-ascii?Q?2boi8obJvr49sEv6QoIRRziwWcKBMSn98NdGPIDh+fHsdu2BoKlNnZOO1BUM?=
 =?us-ascii?Q?AhsaBwWMJ0bgpfYH3BzKOPNghbXlYXQF3xgz5wryjUv6SpA8habRdWkzrLAL?=
 =?us-ascii?Q?C5US5sqyWOPT0WdgQegQAzr5e8JTa/mgZUSV?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2025 07:43:52.5655 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 79ae5f56-762c-45b5-b6b2-08ddcf3cd477
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A1.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6732
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

Avoid GFX poison consumption errors logged when fatal error occurs.

Signed-off-by: Xiang Liu <xiang.liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
index 3835f2592914..e9ba546c36ae 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
@@ -163,6 +163,10 @@ static int aca_smu_get_valid_aca_banks(struct amdgpu_device *adev, enum aca_smu_
 
 		bank.smu_err_type = type;
 
+		if (type == ACA_SMU_TYPE_UE &&
+		    ACA_REG__STATUS__POISON(bank.regs[ACA_REG_IDX_STATUS]))
+			continue;
+
 		aca_smu_bank_dump(adev, i, count, &bank, qctx);
 
 		ret = aca_banks_add_bank(banks, &bank);
-- 
2.34.1

