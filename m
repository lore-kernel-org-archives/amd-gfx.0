Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CE7EC88E42
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Jan 2026 03:56:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4103B10E38B;
	Mon, 26 Jan 2026 03:56:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="r02/8mKq";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010062.outbound.protection.outlook.com [52.101.56.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0C7F910E38B
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Jan 2026 03:56:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KFNEESTEALT+2mqCQbA1l9sW6KbAQvXdWp+OFFp16X06y5fzyKGTeVyOr+NwMwF9E96J8zE6IZjVyR9SolLQt+b6Wqjj+5gIS84GaLM5CL/Jj7KsItzjuHcna8sfzAPUlov85zMA1hnd/sG4hNJYBPzlTz3xM7xRxZm7uChGoMLGr7Pg9JXwgaSLQI93Lfv+T6q0bCrUbXeBh8ptqd3J2P+D7P5AK3Zf+I9xkL8V/FQ31EnfmMW1JXQ2E3l14xV1hEgRi2im5GtVKN/m3/rw008OkrTwqBt0fWHb6W1qRHlHX/0utZZ+W2frPkPkOKj7kR+kTwmxPtM1LWfcSCTh4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t9Ka1u8+xoRmvPizUnUOhdHEN7bAYb2O/GjIsrweETk=;
 b=pIReY2BBPGlXYy+pTYo2hJpiLOy34X6c8GyisZG/G9x6qaias8t+G/S2QVd8D2wQ6CWYb3XMKKaz/9TKXpJUaLY7W382S61oTu5GB4nVx/7w58AxhIk3VQPMJesPyEZx6zc1HJRJ23bksLK9cuiBQ9exT5ywpU0PCzKMQ+o8mO9YB7wzaL2jUuT7hxcmNSQxYmcJLs6B9dPJBaXO92fFlFqWpkY00pQ9DolHtfjhHNVaKK/D5xG4Fff4X1UOtIy06rh0571V1m3yLsyJdkhwlGi1lFyLrzvqr3aQ3DEzodwsCobkyITMYjNhWcnGxgJEh9XOzz7kp6YAOM5jeDrrmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t9Ka1u8+xoRmvPizUnUOhdHEN7bAYb2O/GjIsrweETk=;
 b=r02/8mKqxXMYjCmuyIx6rvQdDde6G5duiLIOSgxOsh/RwmUkk9q7zg2fzuOLsxGVoMstyO7/kW29kF50TpXD2K0e87/pbQEDVKH5BJfURXh/Tl6o5lC5CC47/E0VP4ddUBYBnTirwoJBvVs68ohxLxcvQG+az44ElDHH4CL4st8=
Received: from DS7PR03CA0218.namprd03.prod.outlook.com (2603:10b6:5:3ba::13)
 by MN2PR12MB4063.namprd12.prod.outlook.com (2603:10b6:208:1dc::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Mon, 26 Jan
 2026 03:56:05 +0000
Received: from DS3PEPF000099D6.namprd04.prod.outlook.com
 (2603:10b6:5:3ba:cafe::c3) by DS7PR03CA0218.outlook.office365.com
 (2603:10b6:5:3ba::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.15 via Frontend Transport; Mon,
 26 Jan 2026 03:55:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS3PEPF000099D6.mail.protection.outlook.com (10.167.17.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Mon, 26 Jan 2026 03:56:05 +0000
Received: from gangliang-mlse-vm.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Sun, 25 Jan 2026 21:56:01 -0600
From: Gangliang Xie <ganglxie@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <tao.zhou1@amd.com>, <YiPeng.Chai@amd.com>, Gangliang Xie
 <ganglxie@amd.com>
Subject: [PATCH 09/14] drm/amd/ras: make MCA IPID parse global
Date: Mon, 26 Jan 2026 11:55:22 +0800
Message-ID: <20260126035527.1108488-9-ganglxie@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260126035527.1108488-1-ganglxie@amd.com>
References: <20260126035527.1108488-1-ganglxie@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D6:EE_|MN2PR12MB4063:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d03515e-165b-4b00-96b8-08de5c8ed49e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?bV5aCfj+lGw0vvFZKNrxRgw27WyB24Y1pdRW+JjZqkOEOGpdAQ09mTK1Vf+n?=
 =?us-ascii?Q?ytLYcaiCYHjZIGiAqv+Y40wJwzXyCYD4+ajW9je0DZ+JkhbOmiJpO+TaxQ9R?=
 =?us-ascii?Q?p2X29Bfv7RDBje8mB4p4xeHbwhy/SQYQVUP18qtFnl45Xt3TZicdaE8aAsCb?=
 =?us-ascii?Q?06OMsST1CqY5Ec5mz+w70IOhwyIscvWM4e7VeXESWOaBEoIWqUIqoIaBTFA+?=
 =?us-ascii?Q?2v/XUhuYMs9xrZpMcXMWZW8Xvx7Nzyti4KxTsSjNib7yx6m/wLwgtSRDrKWJ?=
 =?us-ascii?Q?JRotketxxyfwklRPlRh7H7zrMQHNS8/xISqB9zC/xVJ3IlxYoAOg1cS6bfQA?=
 =?us-ascii?Q?RPbO1BImPbAhx6FglMbRpILD9Nqx+rDqE4sjBpGqdzKP5/XLMplijTKVw3W7?=
 =?us-ascii?Q?u+59BaFO1fHxsrxwcoAeCYlCKvoLqvWSEUGdyVFgRoKoW3y/jWk6jT20jx8m?=
 =?us-ascii?Q?c68BDqg7juPe+XREY4s7CakMZWdMkz882bLHPdI+w7VhTlQAwZV5NRhfpNHH?=
 =?us-ascii?Q?N7HZnuBxkF8WfyKpxV4BhbiKiB9zgCclp4CciRVGUv8o+wpNsfVDubLvdImM?=
 =?us-ascii?Q?JkVOV/nofHCSrJI0P49BS29GC3w7N97VBiNfZQazlDhZeVawpGMe5SPQDkYx?=
 =?us-ascii?Q?m3uuAVuyzdg2/5NKsU7RPbuI4aWCse2j9y1NYmpM4iJhY8PHKs/1D9hk1KQM?=
 =?us-ascii?Q?+xZuxUI++KmkwjwLwL/HWzVYF+onVi6+KY+2lGTjCEDTAJzPLq8eS4cxr+z/?=
 =?us-ascii?Q?RXCUvV1RtGZ3TAi89ndzTvWY5ZgGer2oIYIsW/BGewOyk/oU9/D3hAg/ZeCE?=
 =?us-ascii?Q?6A1Tp0U4XlRKmiVQ0sQE3Tqv4HerD0S1VIsO5pYQBWWP+36T8+7B5HFOtxUW?=
 =?us-ascii?Q?V4529/NvdIx9kWjITisSXpuUHx5d4XIRMI0R9ljc/jCttFI4zjMmwS50hvuc?=
 =?us-ascii?Q?BH2vCsWeRLUle9brzVOTqnYUXIyGr4yqQsmbrh1tpFxzXGOeS15rY5+WZgkH?=
 =?us-ascii?Q?h5Lo1gWNVyZhf0rWyVXqBYtL6+ftgpVISFfWWO+NGNAgp6GtQZNg6wn3FMzh?=
 =?us-ascii?Q?YtEG8RI9gtDT3f/6fw5pUJx/R9cqcipQ8dIDH/QkynCa3K5wUOWczADmFpMJ?=
 =?us-ascii?Q?LqNYXkL05dlsR6d/V4LKMyF1F92LQ4pCaA8IIVMLCVviOz/q1MbkytUQudcy?=
 =?us-ascii?Q?oewmV/LeVEMK6BpUBA3popgkuc9KimPtXQWVOgyUE8vPFj1rDLmifsAj54zg?=
 =?us-ascii?Q?6Ut1iKyDJcejQxMk3scYeF6UvEWZUl7sKVy09bVZ73OlLZjZiQaiMYs5UY9t?=
 =?us-ascii?Q?SGF0XxlhfdGQKuGlXhCZQExAXbEswHoI1OsORcwVGSDJRaLmRHB8yDTrfSXh?=
 =?us-ascii?Q?qBsiatdgIo7kk1MnN16rR/DpkVAHvE7WaoV8RLvOzgvquaOUIK6ILkD76+/O?=
 =?us-ascii?Q?d9Inj9DAQNMpu5qkpI4nqH5hDGvYFHaQTblqHot8nFHPl5UlCyQjZZL8BHGt?=
 =?us-ascii?Q?1kp5lyR/DxfuqyEIq3wWxmIWNN3SKVyIoxgBbPIJEecHwyG6DQTZWr7SFfdh?=
 =?us-ascii?Q?0oQ2uMRKHPw8+uIV0yAQfWeXQJ3u/Fg5B+xrMbRWonQ3Sotx9/OxmzU4HloW?=
 =?us-ascii?Q?vYN6Wk/aclphSkAnWVS0II3jyOYHAlYO6ymePCmsW4NXtL9gKTwPttslhjha?=
 =?us-ascii?Q?Ve25Hw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2026 03:56:05.4955 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d03515e-165b-4b00-96b8-08de5c8ed49e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099D6.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4063
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

