Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E897CD73E86
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Jan 2026 02:30:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8C24010E35E;
	Fri, 30 Jan 2026 02:30:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1S4xiy1W";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013049.outbound.protection.outlook.com
 [40.93.196.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 012D510E352
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Jan 2026 02:30:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SdxJN0h/aURsrL4AHAvdJ1cj7v2CIhx0XLYoXId1uaybYc78TCNgXhVEqfGGPbfhpqRyLzQyF1GoqRXLixvtzGpXM74roGE5DmyhDrbUOZye5EGRU/eNnjxhpKPOlWnBhpdYW/ia79kb9WiWjR75YFz6YTC//BTwS8ABFm8pSPtA8HHMt9RQgA4GSxVTKcUZyRQN6I1qJOAi04Q2X6XIcgIgWxy5n/8QKQuGYJukd9m/KYBD5Qfw9cOfeoiO+7+OVnTX2ingP4JRCHOyj6NZBI7WdrVBXqp+XMiyWiwhFa5CWhkPM0DSPVIaZglISSOhL8Z4dszI3usyIagdcETueQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t9Ka1u8+xoRmvPizUnUOhdHEN7bAYb2O/GjIsrweETk=;
 b=F9NYPgE+8/l9ZXoXa9guLEZrqXrHj6QNyajB6vvG5usYXBBkyesQfkZXvlXWW/6TulQwbevI89UuNvEw9ejivH05VlNzVu1YQzBwK7nN9RV3gjkbC1S7YjpO1mqRvCV6+HYNxRi/plC98EGPi3Eh0LS1rqq2R7iL2eG6piquh89A5abrwVk2kdz+5TbL43uDjS/+w3b5WfgK1GH3t6cLaRZDrsVAIC5WRT1+egivGBg6AGobPaZw4whpWytAFj9KYLcbL6EKmam9B0YZ+pDDwsNTlQqAQMAVMXhtESkbPHDoU1GCUKWvDcoDrg48uDPXT65CqHj4YMpZuKRnYBCebA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t9Ka1u8+xoRmvPizUnUOhdHEN7bAYb2O/GjIsrweETk=;
 b=1S4xiy1WBQYrlQQRTRfvHZwjlRem3Q8m71S3hkXFPffhXg4vANz6TmWiE0nCihyWmE77c6ibsYX5iCSv66oTy3jCC3Aywbv3RRtncmvP/Rs/P4EYtvCm72JeZvdhLuDVY3WH+BOLMcA+RLkS4KPaveJGVeJ85QvbzCXuEbjZeFs=
Received: from SJ0PR03CA0158.namprd03.prod.outlook.com (2603:10b6:a03:338::13)
 by DM4PR12MB6040.namprd12.prod.outlook.com (2603:10b6:8:af::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.8; Fri, 30 Jan
 2026 02:30:36 +0000
Received: from SJ1PEPF00001CE0.namprd05.prod.outlook.com
 (2603:10b6:a03:338:cafe::c0) by SJ0PR03CA0158.outlook.office365.com
 (2603:10b6:a03:338::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.16 via Frontend Transport; Fri,
 30 Jan 2026 02:30:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00001CE0.mail.protection.outlook.com (10.167.242.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Fri, 30 Jan 2026 02:30:36 +0000
Received: from gangliang-mlse-vm.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 29 Jan 2026 20:30:34 -0600
From: Gangliang Xie <ganglxie@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <tao.zhou1@amd.com>, <YiPeng.Chai@amd.com>, <KevinYang.Wang@amd.com>,
 Gangliang Xie <ganglxie@amd.com>
Subject: [PATCH 09/14] drm/amd/ras: make MCA IPID parse global
Date: Fri, 30 Jan 2026 10:29:45 +0800
Message-ID: <20260130022950.1160058-9-ganglxie@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260130022950.1160058-1-ganglxie@amd.com>
References: <20260130022950.1160058-1-ganglxie@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE0:EE_|DM4PR12MB6040:EE_
X-MS-Office365-Filtering-Correlation-Id: 69c068e7-6198-4378-502a-08de5fa78d26
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?C661ULrV+thTHJlDhG/3wF9EnFV2eD7fAwOr4yYf/KB59xueMszTnR0f3A68?=
 =?us-ascii?Q?rVAwjgaDtY1jcyv9y3wkNKMQiVXzfoIR4BmG99N+yTEk/AMEVKSEy5+tr1Q3?=
 =?us-ascii?Q?Ab2mkZLrUuCUa0kf6fwTW+FrJ4RPfU4u2ZdjKISqByCl1n8L2UIdm9OZhx5Q?=
 =?us-ascii?Q?DGLZxw5umKPtr5GKRr06lQHBlbxpJTTk1guphEbv6sMuNdSAVhfYlrSjuERr?=
 =?us-ascii?Q?2cUt5UXaJW2SPAg8KeuyJ5/w16z2HgBermEbWIVAYwEN5wuikOT+Y3VNWRgd?=
 =?us-ascii?Q?7XNDK52UcxZ2CTEo4L2W2Of9CLddVx92N7+glNESCtWyEFxydcmUt7kPGQhU?=
 =?us-ascii?Q?41GN73RtFw845ZkWkbICGs/AohslZwxoxCD3uDYXz8zNyPWUDp1Xl0LnFKug?=
 =?us-ascii?Q?gcQ7XIGNM5BsIHxQrw/C3CZ52e+0OnF9pDJVG7huHcgXKoYMbht0r4nJ2Zj+?=
 =?us-ascii?Q?wAUsyt4dDvQsr89NtwiGH3rufC1NKS0jT8bL1mbnG+RNayhuPdGDqXdW/Zhd?=
 =?us-ascii?Q?F33PuxSWVJ81XcVkmqrh2mvpaa7e7QAga4pgChdpP9yFdutNPPWOEPqilKJQ?=
 =?us-ascii?Q?S82FDvffGQFe9FB40P6Y/btTpCrrSrdNN76hqm3jWLdmHrCrPtIscGqYkS3d?=
 =?us-ascii?Q?U1KFIqsFoLmCH1TjjuafAu/wPeEgnFhGxeKY/wRrjWtyYrLtTIBK8O9pi5OK?=
 =?us-ascii?Q?ALdaDQVk+M5yJ2Oq3eDSP1BYrhBdXDaSX2eGQ3trNpP7rq/CHUJHAGwJ4e6V?=
 =?us-ascii?Q?+JEzB8/A3gBl6nWLEEU9rjMzHBtZ7T4zWn1CpowVZ8jHG4Xuq+Z9xZMk8p0d?=
 =?us-ascii?Q?ln2joGcLDT4r8HEX0Yp0zxTjRgVYJqC3bwGtddF0Sg+Q2frKbYNV8aqVy/fP?=
 =?us-ascii?Q?xznPV6cvu46798aHxxmF6CNAmsXk5YbyKix6X4S7n5ZOYEu1cVjafosedCfV?=
 =?us-ascii?Q?BswB6lsLz30NcutHitPm1jDcGT8ghZM3/ynA7MdoMcAoQg+rWDFj0w7NcXVt?=
 =?us-ascii?Q?mJucrM6ot0dEwnjSPgUBxcgk4lwmaj0P8DM7/wiCFv4MeM1AXqRZETTq+ISD?=
 =?us-ascii?Q?2CMh6toWNVBNkOIvQnM8UuQTWV/xosDaLLuup7+JFL5IYcrj9MQ1XseFr1N5?=
 =?us-ascii?Q?4pKDsnjXnl30QysVcMKU4wehFupc/KkyXa56geTAfHkcoQ95fCQIW6CpMeCp?=
 =?us-ascii?Q?+brHFJkRHWBKZ8uUdNSB9LB6c1WQVsnaneiamFOAk0tpuq64iNBIlfd/BIA8?=
 =?us-ascii?Q?EecfRhtuZwyvmSscPYpfGDfkHBChZw6dArluDiVvQTiRUvbSWAPhzs7NSrhy?=
 =?us-ascii?Q?+Hg0r7Fce73llPQRmyuygqESyUnNFPp2fDvE6oICduRmcfQ5NHqlQh7CRQ0k?=
 =?us-ascii?Q?DNdwPAeP/09aT9aF9gDglKblZpox4h6lxDAeCZ/hUljjcNPklL82zHA2LYzV?=
 =?us-ascii?Q?/gkOwz+2/xCy8JHV43c7xNL1Dpb9NvlZT5HEdIzEuWRK0hMtE7khqW7fnYLk?=
 =?us-ascii?Q?LEzFFHsajCQNn4VBkAAwLGpr7YqjXiD+yoDSHxhKDqbVIoP+LQonY8CaIX60?=
 =?us-ascii?Q?GQaH0YYLV9bdKbYjw+W/+icjNTV5rDJYQM+f98O4/7ki1BlpKSWo4mCzctZr?=
 =?us-ascii?Q?esMogrco0l97cZKFbSE1Sj/nIFqQnpjC/Yerkal1YCwEyYXDq6jpFzMc6Zja?=
 =?us-ascii?Q?f5gXrg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: E4XiS7wLz838go+h3iQLev9mtS9hxXzLh6x4lif/3PLCX28Vryxlh/+w7q9u4uywb0pSpydNn6QXj05f+VJ3axR336PRn9fghN8GfPL3Hgjc8/QnPsT8jnOkKf3z2+FBk2kNcsvIr1KcyfxtRONt113yCZLb0vYZDYyGLKn5RsOz4MT2WgS021sea3/JjTtrkvtsStaDmF71vvzEW+CxmsChQoGlz3qQPiBHVCNkNQ5lMOH+GCy41jMNDWFgn1iEXPfkkVHL5cLojYgg0LeXsDszY8KL+qw+ZOS8/DotMIx6R9j21MTqH2Pahqx08qEkcDM0311j+/LaWDE2t1EreSD/gvcX9/swadbPLP0AtxXAPVDjOymJZpK1/iUZL9el/339YAVlpX7mWvWN6a/rrGLda8n/pqMpaxL4gfSz3B1ar+NUOVrrYj4cwlLwqAAI
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2026 02:30:36.4111 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 69c068e7-6198-4378-502a-08de5fa78d26
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6040
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

From: Tao Zhou <tao.zhou1@amd.com>

add a new IPID parse interface for umc, so we can
implement it for each ASIC, and so we can call it
in other blocks

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
Signed-off-by: Gangliang Xie <ganglxie@amd.com>
---
 drivers/gpu/drm/amd/ras/rascore/ras_umc.h       |  2 ++
 drivers/gpu/drm/amd/ras/rascore/ras_umc_v12_0.c | 14 ++++++++++++++
 2 files changed, 16 insertions(+)

diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_umc.h b/drivers/gpu/drm/amd/ras/rascore/ras_umc.h
index 7d9e779d8c4c..795fa351258e 100644
--- a/drivers/gpu/drm/amd/ras/rascore/ras_umc.h
+++ b/drivers/gpu/drm/amd/ras/rascore/ras_umc.h
@@ -108,6 +108,8 @@ struct ras_umc_ip_func {
 			struct umc_bank_addr bank_addr, uint64_t *soc_pa);
 	int (*soc_pa_to_bank)(struct ras_core_context *ras_core,
 			uint64_t soc_pa, struct umc_bank_addr *bank_addr);
+	void (*mca_ipid_parse)(struct ras_core_context *ras_core, uint64_t ipid,
+			uint32_t *did, uint32_t *ch, uint32_t *umc_inst, uint32_t *sid);
 };
 
 struct eeprom_store_record {
diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_umc_v12_0.c b/drivers/gpu/drm/amd/ras/rascore/ras_umc_v12_0.c
index 5d9a11c17a86..e2792b239bea 100644
--- a/drivers/gpu/drm/amd/ras/rascore/ras_umc_v12_0.c
+++ b/drivers/gpu/drm/amd/ras/rascore/ras_umc_v12_0.c
@@ -501,11 +501,25 @@ static int umc_12_0_bank_to_soc_pa(struct ras_core_context *ras_core,
 	return 0;
 }
 
+static void umc_v12_0_mca_ipid_parse(struct ras_core_context *ras_core, uint64_t ipid,
+		uint32_t *did, uint32_t *ch, uint32_t *umc_inst, uint32_t *sid)
+{
+	if (did)
+		*did = ACA_IPID_2_DIE_ID(ipid);
+	if (ch)
+		*ch = ACA_IPID_2_UMC_CH(ipid);
+	if (umc_inst)
+		*umc_inst = ACA_IPID_2_UMC_INST(ipid);
+	if (sid)
+		*sid = ACA_IPID_2_SOCKET_ID(ipid);
+}
+
 const struct ras_umc_ip_func ras_umc_func_v12_0 = {
 	.bank_to_eeprom_record = umc_v12_0_bank_to_eeprom_record,
 	.eeprom_record_to_nps_record = umc_v12_0_eeprom_record_to_nps_record,
 	.eeprom_record_to_nps_pages = umc_v12_0_eeprom_record_to_nps_pages,
 	.bank_to_soc_pa = umc_12_0_bank_to_soc_pa,
 	.soc_pa_to_bank = umc_12_0_soc_pa_to_bank,
+	.mca_ipid_parse = umc_v12_0_mca_ipid_parse,
 };
 
-- 
2.34.1

