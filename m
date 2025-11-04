Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93739CCFA04
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Nov 2025 12:14:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 38D3310E244;
	Tue,  4 Nov 2025 12:14:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mfrg48Fr";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010051.outbound.protection.outlook.com [52.101.201.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D2AF710E244
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Nov 2025 12:14:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nIsdlgvUVz6avdcBoueD/F04XdxKFFX9xPOdgXJ4798TcsaHDnhs035v/BrZd+W9O67f2RXzm6wmhU3gnA+Mxa5sg+Wq18wLixPDXAP3V2PsR3ByYCyZKvfP9UDKBNYJNMaKeS1py0nHFxl2Ufbk+jOpPSvrA5Cubvm+qlBY939YTAJGfRm0vzJCuuEnF1cE9RmcOAbXlYjOg6VgyibZCEe1bMPDEvfOa1O5TvynWkqIoWzbLdSBJTiJXAof5UB2JagVPUZ3ZZ6VL1iGXmDnhf9fZjpIU7PS+IDi7bnzFU0G/GY46ZnDAEMDbbwv8heoQ8rFyMfbYaA6ET7FCYNlEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HRywy/St6+GFtm1fWXnLJGKLMVgaHvvTMTmGwjv2CwE=;
 b=rA6L+lrNnhKE2xvbLMInW6tdGgTPiARLbB5mrUBkCXA9O4HcKaEI5xASOFhP35pOTJf63QsB5tPxnK/clkA2p6gfWgPXrMUf/iNNcTCPXhhgU+eRYSnd/pkWdpGQHvMh4CGywAyUFsJgf8eNBYKmoOwCd2W8SpbIiWouxlQcwhbOOEeGlPd0mUY8rfKATy3CKOZOWxkKvqMDrySqTN3rwp7ozcsf6fuUmeYdn/rT3ejpo4UTha8ZkyboEUnNkwSIvz5eefrTBJSX9CktZG/ZBDN3AUQg4i5XMAl6B/sI5hX5+PYdYwIzU70bkzlGB0Y/MlFBu0d9xEwHdhKr1AY+mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HRywy/St6+GFtm1fWXnLJGKLMVgaHvvTMTmGwjv2CwE=;
 b=mfrg48FrEESSkmhwCYvmJSD9dGNYq14EkCJAbX5F71Gsw4m4IBwaLLo1QVkWXmGrZvvcxHoHzALcROmXvWxHk+/LuaHNkJuxoUjo8t8ZD3D5twcDUX6v+DuKsD4LBZRngo8cTSI3qPq/Dg2RtoqQYwiFXlQUcOqXH41e+5s3C+c=
Received: from BLAPR03CA0059.namprd03.prod.outlook.com (2603:10b6:208:32d::34)
 by SN7PR12MB7154.namprd12.prod.outlook.com (2603:10b6:806:2a5::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Tue, 4 Nov
 2025 12:14:19 +0000
Received: from BN2PEPF000044AA.namprd04.prod.outlook.com
 (2603:10b6:208:32d:cafe::8a) by BLAPR03CA0059.outlook.office365.com
 (2603:10b6:208:32d::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.16 via Frontend Transport; Tue,
 4 Nov 2025 12:14:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF000044AA.mail.protection.outlook.com (10.167.243.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Tue, 4 Nov 2025 12:14:19 +0000
Received: from amd-02.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 4 Nov
 2025 04:14:16 -0800
From: YiPeng Chai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Tao.Zhou1@amd.com>, <Candice.Li@amd.com>,
 <Stanley.Yang@amd.com>, <Jinzhou.Su@amd.com>, YiPeng Chai
 <YiPeng.Chai@amd.com>
Subject: [PATCH] drm/amd/ras: ras supports i2c eeprom for mp1 v13_0_12
Date: Tue, 4 Nov 2025 20:13:33 +0800
Message-ID: <20251104121333.3655721-1-YiPeng.Chai@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044AA:EE_|SN7PR12MB7154:EE_
X-MS-Office365-Filtering-Correlation-Id: b48ac8e0-3272-40ed-3136-08de1b9bae5b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?CzenOsYdOnpepvIIC0LYt5Ma4LqTKYzTPXKK3A+ZwFGp6b6kYt7T39TerWpT?=
 =?us-ascii?Q?qw2o2D8pwI3XN9bATsQeKioQo/zzXIaqoL3uCISf+imD9yW9upfHKyHS8AWq?=
 =?us-ascii?Q?amfXQEnK7KzCVs0PnY4X61j4uxdXgjUwIdY/7t1kOv1AdQzWlGyEaPnFQEeB?=
 =?us-ascii?Q?Sa33EkMVbEe9NkdQLLQxjOtJUPmhSQwOdz0oOHGDWHrwndP80OoWx1MdUiye?=
 =?us-ascii?Q?yPto5JXvDOhHkxzjtD2rGHBGr//OMX1prgxgx+PVn29uqZyPcO/nRFC6KAp/?=
 =?us-ascii?Q?OisHmSQayaJS/XbKS9zRPHk299OvDz10YL/OH1RSXXIMa43PA8tNx6vSAtDR?=
 =?us-ascii?Q?wIUXp1ij6ByH6649XocT8vtbN0eQv8v6azoFV0iGxbqZFNiclk+LCuXChNRW?=
 =?us-ascii?Q?STCkzbpqafOa4dzEU4hpHLQVmGnBtiEqG2hSUPjVqFq5lyspmRur01o8eqEI?=
 =?us-ascii?Q?DhHXaqe3oOadA+bGOrPX2+8g+L8qoMgXgA3cldFyU1ibi6Rmb9CMEE3u491O?=
 =?us-ascii?Q?ueQngL70MxV/4oOEB0g9ASo+l0V7cBKv0htZhfiz8yG3L5WNeLhw5vaojYve?=
 =?us-ascii?Q?uYmqKFNrIRDFAzAbbuZV041TkSKODm6AXuA68YxD3sYpmI2jZKWE3X+sQ6UF?=
 =?us-ascii?Q?eRy02/s7tE+A0RkonRz4Z7vemECl5NhJ+Mr6xXIQ1bQH7z5VHBXLNrYSjRjq?=
 =?us-ascii?Q?H9kw7Cs/JHLGMfPb1U9Rlm1p5YLnLLDnAJZeM6aUKlE8qSmLAT+sRf5T2FuZ?=
 =?us-ascii?Q?RE7WyxD9S/m2nTuyeBqsovOfmE0EfHS8nDmFcgY1CHCBVNklDa9T42OJIfGC?=
 =?us-ascii?Q?JnN8+gVIqNst6KpRmKtHfDAbVSdx7hrknW1SG+ZUiIMb5Py/S+xkNEc2+f4i?=
 =?us-ascii?Q?EZJj8EXZsl/7Evc9vMzqUFWKyNs3oY7PiKMZtxnNXDtJv68XtxVm7lV2Ewup?=
 =?us-ascii?Q?5swOgCyllzYIVZEWiVT9bka1uEhEHEsOYvmeHQq98i3YDhVt2dPJx/KCtIEx?=
 =?us-ascii?Q?ju/jU2vPu3JAmj+qsZI54RIReANwrKmk+ZjSBsk6Hrb/CI/jK/56MiWVdbuU?=
 =?us-ascii?Q?6WTJrNixt/6oItcqUjqGQWBNfoZc5sVY+HnXCzFqMK+nnsAx2wmkMoB3Nbo6?=
 =?us-ascii?Q?KlQQJgCHi/zYktcYIV+uXhaf6c+9Y/30XavhXwFIZ30e2vvFsBVcZZi4GYZR?=
 =?us-ascii?Q?g/Qx63Nx0WAmFCulJgEzHo39Uv06wl/J/1YKKMXu9+sOoaCMGFAaLrqDHHc0?=
 =?us-ascii?Q?kOw9HiVZaOj3/1iIJJbKot5e+iLtPM+gTTJE9oYGR3ibbIOs+xevm/O6XmWa?=
 =?us-ascii?Q?7GepjXrSanrefD1YXsacGCfID5eW23wPhWzylcgW2r53lw5Ntj6X+LnckAEP?=
 =?us-ascii?Q?I+Oq/hlUFH9+UaJ1ek84zsFEqgbTn1UgJPNssjBhGK0X7ZnE+FdA3CtqBe/R?=
 =?us-ascii?Q?2owHZVkcxQOfqP/a7LHoGQhLSNVmC3it4jEMi1hDOtw57D1GevICckMdeVfH?=
 =?us-ascii?Q?YArt42n89U0dZAOzSHPv/MiykLqPmTKbDoWIQTYPu0DO9zZWxAh44GNJm7xQ?=
 =?us-ascii?Q?h19ydYx0mLbFaDXAG9o=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2025 12:14:19.1859 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b48ac8e0-3272-40ed-3136-08de1b9bae5b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044AA.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7154
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

ras supports i2c eeprom for mp1 v13_0_12.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_eeprom_i2c.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_eeprom_i2c.c b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_eeprom_i2c.c
index 1bb7b7001ec7..3ed3ff42b7e1 100644
--- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_eeprom_i2c.c
+++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_eeprom_i2c.c
@@ -85,6 +85,7 @@ static int ras_eeprom_i2c_config(struct ras_core_context *ras_core)
 	case IP_VERSION(13, 0, 5):
 	case IP_VERSION(13, 0, 6):
 	case IP_VERSION(13, 0, 10):
+	case IP_VERSION(13, 0, 12):
 	case IP_VERSION(13, 0, 14):
 		control->i2c_address = EEPROM_I2C_MADDR_4;
 		return 0;
-- 
2.34.1

