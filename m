Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65806C5475B
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Mar 2024 08:54:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D0CA2113821;
	Fri,  8 Mar 2024 08:54:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="dFOtqo5N";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2040.outbound.protection.outlook.com [40.107.244.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2321E113804
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Mar 2024 08:54:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S0uk4QpHAuChwwIK+HtvSflfb0elA7Bix7mrmkB7wE7BGrJ8wzFaCbCL7ZcDXIf2m8ZMoVGNWsw09mtyrjn/iwovBijnKEsA+eHh1K9Xx/D55s4VKo+ZAQSPP7upJyGRBcYqcdT9QNpNIxOsMgBOhMNDDkgPFnKumXSU4j6SYnNpGrOyvDY0hPw7m4W6vSSM1b0ILcK2Ghzv6GcFA1CbzIpXWuq6Ixy7dWF0ecKwHq1xlhPOT39MdBA+Rlu2gZwoKYDQZANOmvaZxyvYsCHZcPSdBJP5SuWRm+JNZsDvUX379uZXYdcvq9zHVzXX19BrWo74v6xdO9FUNRgZHCCGGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QnggYtW9Wr1I6vDPzzXnw2zO/bKXHvqKS27JgyC+wy8=;
 b=OyR7I89T07yV+lEcDah2ZQrQlpvv8Ia1caTB/Mkb2WyZs739ZLY1HKNmdZOv/e6b38IJY1ne8y17YDPGQwcqL1DjiTIp+1MbOsV8UI0SG//8FfikczpjHJCw4wEEHyyg7U5MTKGNhkDFNFSm3CKbJ8oiK316f+RqORN6uwikeI8X+7LSVCq33Dl1veeClXyyhoJYQ3jam17j06HRlDS6kvsDQtakmHYrdzpygZuC0OocHPyJiangKWGEMNTyd6Gwk6b0bPaWNcXboVI6wPauhd9P2/u0qEeT1cNZ+gSSsLLzWqjScniHNn1NutuyPXtSeqm+3sAgBxC1PVnI12DFKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QnggYtW9Wr1I6vDPzzXnw2zO/bKXHvqKS27JgyC+wy8=;
 b=dFOtqo5NtNfllw86L5ZysZ0PX/EA1up2onRCZAsmKM7Jm/3xTA1dM9m7LwcATMco5049OjG4ELFMluyCoTpwkRGwXCmTFsM1UDEfuanFFbAj+BaC404dtUx9x/UgD8Oa+pKRnwOA5xkfg2OViPe1IyuV59pxdZnklct5M+o53KM=
Received: from MW4P222CA0024.NAMP222.PROD.OUTLOOK.COM (2603:10b6:303:114::29)
 by SN7PR12MB7835.namprd12.prod.outlook.com (2603:10b6:806:328::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.24; Fri, 8 Mar
 2024 08:54:27 +0000
Received: from CO1PEPF000044EF.namprd05.prod.outlook.com
 (2603:10b6:303:114:cafe::5f) by MW4P222CA0024.outlook.office365.com
 (2603:10b6:303:114::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.27 via Frontend
 Transport; Fri, 8 Mar 2024 08:54:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044EF.mail.protection.outlook.com (10.167.241.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7362.11 via Frontend Transport; Fri, 8 Mar 2024 08:54:26 +0000
Received: from jenkins-amdgpu-2666v3.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 8 Mar 2024 02:54:24 -0600
From: Xiaojian Du <Xiaojian.Du@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Xiaojian Du <Xiaojian.Du@amd.com>
Subject: [PATCH v2 6/7] drm/amdgpu: add VCN sensor value for SMU 13.0.5
Date: Fri, 8 Mar 2024 16:53:59 +0800
Message-ID: <20240308085400.385793-6-Xiaojian.Du@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240308085400.385793-1-Xiaojian.Du@amd.com>
References: <20240308085400.385793-1-Xiaojian.Du@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044EF:EE_|SN7PR12MB7835:EE_
X-MS-Office365-Filtering-Correlation-Id: e779858f-dcc4-45a4-3b52-08dc3f4d5c0c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NFymYtqHgADHQZa//fEGav8deTskdy1i6BEjvW7zAj8ii9v99GQphjnb1iDqVldtG1yLqUtgspmh1gokGM9fIuEghlacUFhWm7RbpU0ReGsofOy85dcATTKmdFHac34qNvPYipdB1P4+Kx5hFfAIBnF9qpO17/sxq4YVANGMzZZgmbjTiQbiqFyfglFmzdL7gi7LGaqpbxnRltjIo2TLJa44rlrwuNh7NaYtxLBhE555Z2hRWXcJp0BWoRnByZyw9dyZtIm7pieVb9Uyz45G7I7IR6NJtJ5t2GYVW+a7ZpNorpVWE6Ho8iE7EBgtCdZjk5xsucsP5Kmgj38z5oIuAiG6RfwgpFYEXYNyQQqu7LYmY56liEwxdv7HMO2nGfUggAXE/9O3po0K7+TX81OHUidupaWO92/6C0FGKHecWYj5ajAibcqcucUaNzXlnzJo19VqBQV8gM3VFHWP7B1fsi+7bUsQwtdxn0MBE4GGAWyyGNhYhE9CFgEBhDpoauWHwawUYdGWcjb2OCHxDzQisP8ct9WXQ/W2110bS55Xk7lqpEV7uiQQ6+x9aK3j8uAMBw++AQuNG4cWyARUhse+kxOk+l7eClliU33rrfR44McEGIrHO17g9HGTHesdlPY+DstZ3zmB7LGwK4cp10X/nova+Kb5rk7rmXCkusGaJjJIZC35GoQrO/WD3P1MB2gC/tE51+Fuxmvov+XBccOl4ErmLeFmiaHGOxZiZ97hZWze/cub+fvnfCbUND5v6j0t
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(376005)(82310400014)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2024 08:54:26.7698 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e779858f-dcc4-45a4-3b52-08dc3f4d5c0c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044EF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7835
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

This will add VCN sensor value for SMU 13.0.5.

Signed-off-by: Xiaojian Du <Xiaojian.Du@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c
index 0dce672ac1b9..218f209c3775 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c
@@ -286,7 +286,7 @@ static int smu_v13_0_5_get_smu_metrics_data(struct smu_context *smu,
 		*value = metrics->GfxActivity / 100;
 		break;
 	case METRICS_AVERAGE_VCNACTIVITY:
-		*value = metrics->UvdActivity;
+		*value = metrics->UvdActivity / 100;
 		break;
 	case METRICS_CURR_SOCKETPOWER:
 		*value = (metrics->CurrentSocketPower << 8) / 1000;
@@ -332,6 +332,12 @@ static int smu_v13_0_5_read_sensor(struct smu_context *smu,
 								(uint32_t *)data);
 		*size = 4;
 		break;
+	case AMDGPU_PP_SENSOR_VCN_LOAD:
+		ret = smu_v13_0_5_get_smu_metrics_data(smu,
+							METRICS_AVERAGE_VCNACTIVITY,
+							(uint32_t *)data);
+		*size = 4;
+		break;
 	case AMDGPU_PP_SENSOR_GPU_INPUT_POWER:
 		ret = smu_v13_0_5_get_smu_metrics_data(smu,
 								METRICS_CURR_SOCKETPOWER,
-- 
2.34.1

