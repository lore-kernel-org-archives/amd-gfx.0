Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77629EF070A
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Feb 2026 04:57:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 174D910E26D;
	Mon,  9 Feb 2026 04:57:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0M8Bf3G+";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013056.outbound.protection.outlook.com
 [40.107.201.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 69A4A10E26D
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Feb 2026 04:57:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P69ZY4uIfuakgZiUQsu3k1WYhtJOqJUnZDVlJkijiyY++wntVAzDMoQze5Bc8CISqooP3xUPRbnvNvejRdYswNiHNfPr90gflKyK4c+m4TlVUfVXXk9DLyEiSDyIwiQj3jfXQhNpiTAB1AQ26wAkPx7D8FPaYnSH6EZWuAreXm3JYK/+VWIroy1Q7RIrnr6fgrg/kmvg5e9gyChYlBUCOHXYT0u5L97h6e/YXxZEjjUi/5ECj8c24hXuvNW2nTSJbmvuHfLgkX4O2+mFSlCB9jqKE1xHsA/e5Cw1ANb1ZOvR/TOf++XUFbdd8KLW+BK1cFHK7U0Qdz8jRLn+tRcpAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=flfV8ZK38wPR+9Tuxjni5A8VkQP5YehN/ODa4+ylEYU=;
 b=cg471MjeF5r5uGF3qeMHFLN+je8AqVJy4wLTPYro7AP2YiUuM0mg3mwZohZEbBmN2vzn9tJtbJYcYJ01OMK7x2a/EqFU1nh7LPRY9uZyDZjqjs+hyjKnGPKJAcOhrUkReOfo1UiQvbsNeoeanLur945o0ITfOc0F4adg0lS8SQFivtplDKVXgdnqKoxhKs0iS81M7vVgJUm0pctGGrRoJKrpOOc2kFX7R3XbrUwB/Yrjhc8eEHu9+HU45LzKdU5ihQzVfXHFtJ0UFh/Rve7Zutn81CMEyShRKYYe6HiKys6t4iCiKmWcIneRefJ8sqd9fXq2dU+StcWOKdXbKa9NUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=flfV8ZK38wPR+9Tuxjni5A8VkQP5YehN/ODa4+ylEYU=;
 b=0M8Bf3G+F1zJh3CI6PcEB6I7jUxDiKCWPuCiltQY2/Ct1qV67y5zS2f39cx8G5leNXZMjVydmxSCPe9xLlC5ng9Ajt/ZJxdnES83j5xjkKAn4c95XtXX8wreq2vDJC5+7jZGHnC1sQAxhizzPYWAYGmSooGB3wJtseliQzxuIhE=
Received: from CH0P221CA0016.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:11c::18)
 by IA0PR12MB7773.namprd12.prod.outlook.com (2603:10b6:208:431::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.18; Mon, 9 Feb
 2026 04:57:12 +0000
Received: from CH2PEPF0000009D.namprd02.prod.outlook.com
 (2603:10b6:610:11c:cafe::1c) by CH0P221CA0016.outlook.office365.com
 (2603:10b6:610:11c::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.18 via Frontend
 Transport; Mon, 9 Feb 2026 04:57:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF0000009D.mail.protection.outlook.com (10.167.244.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Mon, 9 Feb 2026 04:57:11 +0000
Received: from BLRPVISHWAK.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Sun, 8 Feb
 2026 22:57:09 -0600
From: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
To: <Alexander.Deucher@amd.com>, <amd-gfx@lists.freedesktop.org>
CC: <Lijo.Lazar@amd.com>, Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
Subject: [PATCH v6 03/11] drm/amdgpu: Add support for update_table for SMU15
Date: Mon, 9 Feb 2026 04:56:41 +0000
Message-ID: <20260209045649.59979-3-Pratik.Vishwakarma@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260209045649.59979-1-Pratik.Vishwakarma@amd.com>
References: <20260209045649.59979-1-Pratik.Vishwakarma@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009D:EE_|IA0PR12MB7773:EE_
X-MS-Office365-Filtering-Correlation-Id: 79b2688d-9edc-427b-128a-08de6797afc3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?g6DCzKEVwPe91n8WJ6F9ytEq1RAdHiGP6zE6vT4DRJA28En/vRXyS50syjtR?=
 =?us-ascii?Q?4DcXU3qkU2v9wj6Touk5MAJqwFHPBQuF0cEpG9NVVBO46/ubStwfiT/xmp9o?=
 =?us-ascii?Q?AUy+mIyPZUBicsU5B0DbRpnpT2ue4B6Vup2lbSvbno1vFA2SULNdrPX6jxWs?=
 =?us-ascii?Q?WHTA53nbtB6xSSUSv/QfURzT4H7MG1YdT/Ne2b0isGvsy5HUvxbs3fWAJMTe?=
 =?us-ascii?Q?A3HeLhy1FlEPKAH806YVbiIPdawskaorYzSIhMXtxm10Ma+DUkAiamPf5yzf?=
 =?us-ascii?Q?olIQKcDflQgtKqgjnOAJ97pnR8zMds8mGXbsgqRqYwXOFwlTf7Z5uHfc5DdD?=
 =?us-ascii?Q?wW99kljZaocTVypRg4SEDc3p05WJAO6fDNjIB0zyTmvN44f0PhTMykmJXbo4?=
 =?us-ascii?Q?8p1B6pdVF00+B0ejEEi43+sFzOkiwMQUjZKLpcD3i6h3bWZdqjX9pRhdhZUB?=
 =?us-ascii?Q?ZoJ3HH8bQpbY46tzMYwN+MXn+PD1rE0tFgk/TzoURWUw/aF0pQUw0indDzJK?=
 =?us-ascii?Q?nwmAzR/SrYqIzEke5b4OTMkSE52tAk0Td9x39cwiTKC4Vmoy5AiMp7hzceLK?=
 =?us-ascii?Q?eYpoNNMOcBjI4qcD/PWYlJGc3Xz+kXU8AkREJliMs1ncBNkwllessJNBzrTD?=
 =?us-ascii?Q?sbkCVH6fbMYxrU5TxViKlWzKZokU4vKA76cpp8vkh17IRMMnA3FPWzs6Fr/o?=
 =?us-ascii?Q?SbKMXqYkUtt80Rda9bJXp2spo2IF31hqFSc0JkLOk2gXlzwveJJOIgysuoAv?=
 =?us-ascii?Q?JI4+sVmfeTxBE/KTyTvulTaf3G1PVwhH7i5xLSMSfP2rummgLfsRv/hVPm+k?=
 =?us-ascii?Q?oa5tqTjdSb2XyFJkIBWZwrreAUS/QjO+y7H8GHpro+gCpvyxZA+Qg6icjejd?=
 =?us-ascii?Q?6lHf7C/LF0iCkSpWFJR08rzAB3m0Z1lQc5z/Mepylg/LoOZShNto1+UQcrCk?=
 =?us-ascii?Q?8ZdKrU9FTLzYum7PuDPRY04NRImN+Nd7iDh03pEzbD29TzN7w6IdCGdgxgGO?=
 =?us-ascii?Q?MLD1wgpTAEdxARtLkxV+A0g5V+4jf26Ic32jFtzr1pU3+w14YLnScp1TE2ga?=
 =?us-ascii?Q?UCUsUzIiwhA+ctySvg3E9sPfApS0pljYZOhtwevnMRcla1Tfqy5Cmd4UAZuq?=
 =?us-ascii?Q?ZC+rPDtMHcwZtOnlLzRXpLHUlC6ZE29lhXMopDk5Prgo6CUOcZ9SrUc13JwM?=
 =?us-ascii?Q?Qa86qOZ4zcf0CKRnbdJG0slYR/hr67ky4SHV6k6ILhsVk+O+zi80Ls3q9ka+?=
 =?us-ascii?Q?0b1lt8GIMI3HLNq7Ty4HQRuDPfVOUlHCTlIFW7Op7TSrDhYYfAkAbyANflp2?=
 =?us-ascii?Q?HbVHjRMJQkob2aNRCQQWi0LB5uwukG2aR9TtuYsxb2WTQOrIqPyGkgAEP3oa?=
 =?us-ascii?Q?ZQrjIGWXKrxGK173JNmM6BOuYzqK+E91KpcYDg+k1C18xMD6z9xWxxHI/HaR?=
 =?us-ascii?Q?Qn1Gzt4Dmb9cORKQodud7dpqhF8/t/6aUMTYd6BY04xjW/SqRgdykN9Dr1vD?=
 =?us-ascii?Q?aNWT6YRRh4CLqm3m3mqF6XeZtijEHdmW+s1dB28ZFeEXy2MDGepdzaez7eRm?=
 =?us-ascii?Q?1aSr0nSMFFPXlojYr1+7ZLgRV8T9iIqV6OVZgN8pDCM3iivFRJWUdhJi7SEN?=
 =?us-ascii?Q?p4VJqEZCWcQUQc93OLVvcFbvOo59OGG94f6VrhOll/OFTxveDLlaTCyf8Q0K?=
 =?us-ascii?Q?b9aV8w=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: LEtzm+cIQvjIog5HZgeqHFjOpal5djvnxI8kDeGiXXrkAiWfwTKNSRrwZrWtVf3cxsGyYQ1BL/BbZc7F3jsxkUW0oeMjnAIm5wUz4hQSkGrkveQNj41GzcVuNsWaDWr6RI5CK+pMXPEPZmvAv+Vd02Mv7nLc+twW8+IP/wbK80T46zFOLsV35Rf1FdI+hJjqcSbYAEkZJNT0ZGbHUwYfkT29RYsA3FSWR3Lwqq/oUHG1Hq8cHteDl8fwBb5dBH6XJM27IMCi+mCP0V6vM8vNBM/QtEeplYsiz84fABJe6gEyhcpcR9ONTqlMI9docycE9bbYgFtIQ38G96DzTzo+2qZYF9xtBY7JwBAlC9/SzpS2f5CiFlIjlytNek1649/8uxM5rbU+qPDAgwXwUwCNDxUz5UyYljmCZ7RLJ2VW87uwFP2moWrTmh59432W680w
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2026 04:57:11.9401 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 79b2688d-9edc-427b-128a-08de6797afc3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000009D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7773
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

Add update_table for SMU 15_0_0

Signed-off-by: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_v15_0.h  |  5 ++
 .../gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c    | 60 +++++++++++++++++++
 2 files changed, 65 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v15_0.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v15_0.h
index 14e8d8c7a80a..af87c31ca9a4 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v15_0.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v15_0.h
@@ -241,5 +241,10 @@ int smu_v15_0_enable_thermal_alert(struct smu_context *smu);
 
 int smu_v15_0_disable_thermal_alert(struct smu_context *smu);
 
+int smu_v15_0_0_update_table(struct smu_context *smu,
+			 enum smu_table_id table_index,
+			 int argument, void *table_data,
+			 bool drv2smu);
+
 #endif
 #endif
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c
index a2854d528bab..fe18af12aaf1 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c
@@ -1726,6 +1726,66 @@ int smu_v15_0_set_gfx_power_up_by_imu(struct smu_context *smu)
 	return ret;
 }
 
+int smu_v15_0_0_update_table(struct smu_context *smu,
+			 enum smu_table_id table_index,
+			 int argument,
+			 void *table_data,
+			 bool drv2smu)
+{
+	struct smu_table_context *smu_table = &smu->smu_table;
+	struct amdgpu_device *adev = smu->adev;
+	struct smu_table *table = &smu_table->driver_table;
+	int table_id = smu_cmn_to_asic_specific_index(smu,
+						      CMN2ASIC_MAPPING_TABLE,
+						      table_index);
+	uint64_t address;
+	uint32_t table_size;
+	int ret;
+	struct smu_msg_ctl *ctl = &smu->msg_ctl;
+
+	if (!table_data || table_index >= SMU_TABLE_COUNT || table_id < 0)
+		return -EINVAL;
+
+	table_size = smu_table->tables[table_index].size;
+
+	if (drv2smu) {
+		memcpy(table->cpu_addr, table_data, table_size);
+		/*
+		 * Flush hdp cache: to guard the content seen by
+		 * GPU is consitent with CPU.
+		 */
+		amdgpu_hdp_flush(adev, NULL);
+	}
+
+	address = table->mc_address;
+
+	struct smu_msg_args args = {
+		.msg = drv2smu ?
+				SMU_MSG_TransferTableDram2Smu :
+				SMU_MSG_TransferTableSmu2Dram,
+		.num_args = 3,
+		.num_out_args = 0,
+		.flags = SMU_MSG_FLAG_ASYNC | SMU_MSG_FLAG_LOCK_HELD,
+		.timeout = 0,
+	};
+
+	args.args[0] = table_id;
+	args.args[1] = (uint32_t)lower_32_bits(address);
+	args.args[2] = (uint32_t)upper_32_bits(address);
+
+	ret = ctl->ops->send_msg(ctl, &args);
+
+	if (ret)
+		return ret;
+
+	if (!drv2smu) {
+		amdgpu_hdp_invalidate(adev, NULL);
+		memcpy(table_data, table->cpu_addr, table_size);
+	}
+
+	return 0;
+}
+
 int smu_v15_0_set_default_dpm_tables(struct smu_context *smu)
 {
 	struct smu_table_context *smu_table = &smu->smu_table;
-- 
2.43.0

