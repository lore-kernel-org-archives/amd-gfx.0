Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41721D591DE
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Nov 2024 06:36:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 35A3C10E5D3;
	Tue, 19 Nov 2024 06:36:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="RwHsTcqT";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2068.outbound.protection.outlook.com [40.107.223.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 726C810E5D0
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Nov 2024 06:36:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BCjTkI0McBfNU9VSMNzanrIdyR/9HpXeh2XAD3TpW7pY7n/GXlnEeABC2sCvfaN51GOOdjMmxbIW7CPypIwDQ3szDXgmB4lIgze8aI+UjZiO7zrdG0OmKXoAmZTyJM+CZoEqm3rBcgmlmtuaVQs/z89GY7AqCKGELiBJljH2VSvdZ0Rv4dGN7uSBgu+EddgtErlmK/xIiJco5mZ8Cw/wu4xcDeDFVeeGNMeZJgWuYXwuTLH1O2i3J6NINdv1HqinWChf8mY8r3hIPRUYzPVjs6z+iButnJ+QCYHLqS4u5GC9bN/tiTusS0w0mtVG5pU/dhyi81nZZ1h9VygDzQW5wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b7U8vpHl6rhKwELoKg/qanVNwFDRKKIv+2N8PsRZrXs=;
 b=VOmiR41ZrhpSLeEiu0aOhs7T1DZtQ0bbar22epPD3G5Mhc8fdQr37vSkH6pIZaymdcIqTk61nHj52yy14OJ2sHtK9/rPYBviPloHWYkidvtGNw5vu8+Qvaolu7t/7tpqvgZCJ/CW4lmL3FEoOK2465/d+bq+7l1aaa/LCuaGQ3GLGIjjrLf7RQdviY/JTW73xZZyg019rKvYWtqUorii0M5z8PsDpAaiwDUf4JlX6ErUv00MexLgsWzTcmUGz/atzYIcl6Wd4PsrLPKeYUurt7CQjSV2plfbP1jPpzctu5JHAasrI2ES7own7nHeet5Oa/cMgGWTZWrnFbrRqmSjww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.12) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b7U8vpHl6rhKwELoKg/qanVNwFDRKKIv+2N8PsRZrXs=;
 b=RwHsTcqTA5IToszusvgNGTLKYV5fg+J6B3NeSwVuseb5cjzKGnM7ZrUKdrm3HB2aBFsqYYaZOo9NtMZgRRAa3rz+JrNTyMuLol9EQC4eSIANbaBi2MpajlCO8XWH2UrWBt40H5zqn62VHctusqWsY9YSFnxTK6JpntUzMvTgcVU=
Received: from MW4PR03CA0045.namprd03.prod.outlook.com (2603:10b6:303:8e::20)
 by DM4PR12MB6616.namprd12.prod.outlook.com (2603:10b6:8:8e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.24; Tue, 19 Nov
 2024 06:36:42 +0000
Received: from CO1PEPF000075F3.namprd03.prod.outlook.com
 (2603:10b6:303:8e:cafe::8c) by MW4PR03CA0045.outlook.office365.com
 (2603:10b6:303:8e::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.20 via Frontend
 Transport; Tue, 19 Nov 2024 06:36:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.12)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.12 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.12; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.12) by
 CO1PEPF000075F3.mail.protection.outlook.com (10.167.249.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Tue, 19 Nov 2024 06:36:42 +0000
Received: from tao-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 19 Nov
 2024 00:36:40 -0600
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Tao Zhou <tao.zhou1@amd.com>
Subject: [PATCH 15/21] drm/amdgpu: add a flag to indicate UMC channel index
 version
Date: Tue, 19 Nov 2024 14:35:58 +0800
Message-ID: <20241119063604.81461-15-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241119063604.81461-1-tao.zhou1@amd.com>
References: <20241119063604.81461-1-tao.zhou1@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075F3:EE_|DM4PR12MB6616:EE_
X-MS-Office365-Filtering-Correlation-Id: 47857bd3-58e8-4ebf-d76c-08dd086487c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?UQj78iwxlLXPg/5kvNtbqp6USJvjOXAbC8kkIqd3GRTPTKuq6qupS2q10zwm?=
 =?us-ascii?Q?XZ0KQf49UHD+CevtigxzmIRI0d96G79NOf5g+i4qv5U3V5uTF7RkRYrotYL3?=
 =?us-ascii?Q?UmleenwriI/e9ZYpIhoJv/k3QoGnf8DeupleUjqrAvdYPhX+nsE5hhE9eW7L?=
 =?us-ascii?Q?T+aGKEzlUrvMGCh//Dbqtys/XpH0W4vQHCAYAxpRovzDDcdY12Z357gIsqLB?=
 =?us-ascii?Q?STvwP1qOrwT+LUPgPi/aBUfVYYXjq1fze/hZHh0O0IEMQhmHF3sWDb486ZFL?=
 =?us-ascii?Q?olANDnNheGSOB+hOGaDRfoxaa2vWzdd1LSILS1zIyJIdPpGiPZhIu5FM0hC+?=
 =?us-ascii?Q?i2wfYnVoQkMpzVShy2mbvI6WHAqL8QEIC8fXs/I+VsPd2fuOZQj1kRqpNIa5?=
 =?us-ascii?Q?qRj4nJ9DDh0yY9hnwwVns2jQDAeHkwskaM2FuhOtSO25XMS30lZ5cNvYJ8+m?=
 =?us-ascii?Q?PcH++wuoVveNBGzeQqmTPZrGps1bJnKJdbGeVO9Eb65IoNUxnSf4DuDTmwDW?=
 =?us-ascii?Q?OOsaDEJ2EmjSbBwaUBbjERKYzN5DdLSdHA4pJLmFIv3ekuBT4CRyrzST/oOF?=
 =?us-ascii?Q?Rb2DZYdIT5UsIJfo/RvhJafbKc26SirSHflBdlwuNnPeYX9PjTM5FGBK6tE8?=
 =?us-ascii?Q?SbLuZ/nCfCw4Ec1chfX/VCHdY/kuoJoxOANOMsC6ghgzR0UxbW9MvIwu5b2a?=
 =?us-ascii?Q?AFikc13BeMl3Z2RxHKS+94Uod2j+iuNSmZpULSrs4IVHlWyIBLYZRZlsGFpY?=
 =?us-ascii?Q?UrjDedxlaNgbiVBwERtYpw0gDvYJp13bpXA/dqToVMkIffyx/oLVs34TQVap?=
 =?us-ascii?Q?IRAhRE6TwUyYRtJv3O/WXRNQaAjdPX/knFmdfhZWcGPPk0VpD6jQ8rzKaEVt?=
 =?us-ascii?Q?lnHz8hJbBzUlBMpx7nhuyiAB5vr5yRv2Jl7Tqp5CM9n1PGZMit5gnRM7UOcT?=
 =?us-ascii?Q?rT/yAwfn1+TDWQlYRK8DkOAdwnf20uXEU89kOvKsETFmUZyydLTrgilVlHiD?=
 =?us-ascii?Q?a83459rVjiMHcCke2EvaHp1cMTTIOfuFwtyx0Q2tuRbnju5PFas2ZoqegAoD?=
 =?us-ascii?Q?376ikqXV8aCPAJoGYqMthHPwxHeaWxVPKJaWfp95TIvG5OPOFZr1zzdXaxQt?=
 =?us-ascii?Q?n3QJGcRq8tnvsefR3VSYS5bQ4CsBV43od4ulEmOiweVnPJdC0Uszt+S/bX0E?=
 =?us-ascii?Q?FLs2D/kJPybZCA/dY3SCckbwQTvnCMJWhpgw95yNG43OVnl9Xct4Bb2zxsCx?=
 =?us-ascii?Q?a6wDAE0jxwEcAdydvgZ2juomBHPMgNejf20BTKdhIMi77V/2pCSWg6B6Fl4y?=
 =?us-ascii?Q?3LhHT3d4nz22mpRAmR8GO/PZ2YADbJahJ9oq+2miyPR+QqR3HRT7UsDSBmDU?=
 =?us-ascii?Q?C18G8DOyAVBeGDBXVTXTLFYu9Rp4QE5e3NRFiJKkTb8JqEFraQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.12; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:atlvpn-bp.amd.com; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2024 06:36:42.1983 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 47857bd3-58e8-4ebf-d76c-08dd086487c1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.12];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000075F3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6616
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

v1 (legacy way): store channel index within a UMC instance in eeprom
v2: store global channel index in eeprom

V2: only save the flag on eeprom, clear it after saving.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c | 11 ++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h        | 16 ++++++++++++++++
 2 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
index f28f6b4ba765..f4a9e15389ae 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
@@ -841,7 +841,7 @@ int amdgpu_ras_eeprom_append(struct amdgpu_ras_eeprom_control *control,
 			     const u32 num)
 {
 	struct amdgpu_device *adev = to_amdgpu_device(control);
-	int res;
+	int res, i;
 
 	if (!__is_ras_eeprom_supported(adev))
 		return 0;
@@ -855,6 +855,10 @@ int amdgpu_ras_eeprom_append(struct amdgpu_ras_eeprom_control *control,
 		return -EINVAL;
 	}
 
+	/* set the new channel index flag */
+	for (i = 0; i < num; i++)
+		record[i].retired_page |= UMC_CHANNEL_IDX_V2;
+
 	mutex_lock(&control->ras_tbl_mutex);
 
 	res = amdgpu_ras_eeprom_append_table(control, record, num);
@@ -864,6 +868,11 @@ int amdgpu_ras_eeprom_append(struct amdgpu_ras_eeprom_control *control,
 		amdgpu_ras_debugfs_set_ret_size(control);
 
 	mutex_unlock(&control->ras_tbl_mutex);
+
+	/* clear channel index flag, the flag is only saved on eeprom */
+	for (i = 0; i < num; i++)
+		record[i].retired_page &= ~UMC_CHANNEL_IDX_V2;
+
 	return res;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
index 2f71194d5da8..f97c45b4eeb8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
@@ -54,6 +54,22 @@
 
 /* Page retirement tag */
 #define UMC_ECC_NEW_DETECTED_TAG       0x1
+/*
+ * a flag to indicate v2 of channel index stored in eeprom
+ *
+ * v1 (legacy way): store channel index within a umc instance in eeprom
+ *    range in UMC v12: 0 ~ 7
+ * v2: store global channel index in eeprom
+ *    range in UMC v12: 0 ~ 127
+ *
+ * NOTE: it's better to store it in eeprom_table_record.mem_channel,
+ * but there is only 8 bits in mem_channel, and the channel number may
+ * increase in the future, we decide to save it in
+ * eeprom_table_record.retired_page. retired_page is useless in v2,
+ * we depend on eeprom_table_record.address instead of retired_page in v2.
+ * Only 48 bits are saved on eeprom, use bit 47 here.
+ */
+#define UMC_CHANNEL_IDX_V2	BIT_ULL(47)
 
 typedef int (*umc_func)(struct amdgpu_device *adev, uint32_t node_inst,
 			uint32_t umc_inst, uint32_t ch_inst, void *data);
-- 
2.34.1

