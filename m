Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B297CFD65E
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Jan 2026 15:58:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 598AA10E62B;
	Wed,  7 Jan 2026 15:58:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="DbZ0m1rg";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010025.outbound.protection.outlook.com [52.101.56.25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BDC8410E636
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Jan 2026 15:58:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dtHrxcvdmzzoetd7dpQCM+A0gpAS4St4KY/jJx0nkdqcoZEQuXciY79Kb+y6G5l3Xh5NTp85YUb7NIK9xsJvVCfuJDe7xCPRKqVCUMmo7joJoVVsd3TRxDdat00AW6BWeqfjNNEALF+4uluE11kOPMEoZTR0zuEHwPrwgu+/rjL5AsghGioiUIb1f2AtSRmWN/Waq9xBxztgOiP0vKc9fKmCFz+W6BY1ePjfb4VqXNHnuf4r4zJoYyAQfmg5h8U5JIN80WjClCkkzv4HvKhF3JOXVcZjdNT01zmcy7cV8kkNVAdH4d8f9eFipx8HlBqhd6ey01ZDzMb6sR7TLYgbRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FPJRfDsXrvqkIOeN2b33/ogZ2K+JMfskoWESbCb2xPk=;
 b=c+RNtTqpA7GzJZBED+Ror4LUGaRHZfu8LwC7H9UQle3mJ/qhN8j+D5snbgs613zVK8a3CR2fIYfzbqedpGx2excOnFBxhE3z6ohxinQOWYPytsoALy+YD2w5dPhMkIE8czyDbVIs/328+dyYE+n6oIKGKQZDwYNzw+6zhMEy9vAK77RPfUKxCENkoN7KOaFGbLvXP7mFLbtRm8Ek7vsbPr+uA1uvw7vO4s6GxoRcTTqqFA1/tKkvqTJb39710A7afYZX7CVIuxcwFsQtUUfgc33YXeA38ZZx8uV6kK9LJwi4Wzt4+9I2aT9/SzH+Dk28kiJkT0zOWIXk2Z6NreDOzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FPJRfDsXrvqkIOeN2b33/ogZ2K+JMfskoWESbCb2xPk=;
 b=DbZ0m1rgH0OqjOCfafDl4wG1Qkn0+LzVAjrz6woHfyREESc6JmodfvFzgrEQomShlv8HRAvuKeFTgtCV5HIADiWCk/nhBGnL7tvYJM97+2Nv5Zd5pR/Qnqzk2C53BfaArAax/HKQEfImhM9YAfwU+iCikPq4nDv5IUKV1ajgf5E=
Received: from CH0P221CA0044.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:11d::27)
 by PH7PR12MB6980.namprd12.prod.outlook.com (2603:10b6:510:1ba::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Wed, 7 Jan
 2026 15:58:09 +0000
Received: from CH2PEPF0000009F.namprd02.prod.outlook.com
 (2603:10b6:610:11d:cafe::ca) by CH0P221CA0044.outlook.office365.com
 (2603:10b6:610:11d::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9478.4 via Frontend Transport; Wed, 7
 Jan 2026 15:58:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF0000009F.mail.protection.outlook.com (10.167.244.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9499.1 via Frontend Transport; Wed, 7 Jan 2026 15:58:09 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 7 Jan
 2026 09:57:59 -0600
Received: from mkmmattstew-dt.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 7 Jan 2026 09:57:58 -0600
From: Matthew Stewart <Matthew.Stewart2@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Leo Chen <leo.chen@amd.com>, Charlene Liu
 <charlene.liu@amd.com>, Matthew Stewart <matthew.stewart2@amd.com>
Subject: [PATCH 09/21] drm/amd/display: Add global fgcg function prototype to
 DCCG
Date: Wed, 7 Jan 2026 10:48:01 -0500
Message-ID: <20260107155421.1999951-10-Matthew.Stewart2@amd.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260107155421.1999951-1-Matthew.Stewart2@amd.com>
References: <20260107155421.1999951-1-Matthew.Stewart2@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009F:EE_|PH7PR12MB6980:EE_
X-MS-Office365-Filtering-Correlation-Id: 9850e86e-7952-42dd-df59-08de4e058da5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?MDAUVxVQ3SugyYM6G8GpcpSQVHdnTew29WOC0Gf3eGo+S1sJawHy0w8jyEMQ?=
 =?us-ascii?Q?T1hwyKtIutzhmCzx1hpLL/Sy2Qwy1mrNu6o11sppKVlRRN4+BmYndpj/LiIO?=
 =?us-ascii?Q?64pG8qWYRuIrYbksxKX8RubIjdS+SxJM7fLwCgJiUykbdyCdiZxVx+2VfCBK?=
 =?us-ascii?Q?eg9cO6CQbWWtIw9y5QAFc98PMxv53rlt72oYQhAUqcoutARi5ftR6Rn4/Odo?=
 =?us-ascii?Q?OhxIcw6v6B2J1aUoxqKfr7xtZVmhwqbxtaSFDUqT0RjLK/FeJAwi1FtR+FI1?=
 =?us-ascii?Q?QXsVg7JQTolzh1vZJ0O43DKOdD8R9sf6V1mzvfZTOt6pbmTz0eLdWax5dyVS?=
 =?us-ascii?Q?hH0M3abYkE3fgei3TVe4o9eLA9n04OOwzoz9RqPToLDAEeZnMSuYbM1B6Dns?=
 =?us-ascii?Q?EvPEUDGN3XeL1HmNjGfl0OalkEOAMARngYiQXJnlRmKdU7oS8ZpnMoBgCvW4?=
 =?us-ascii?Q?UcnIYDe/YyTTxuDqaPsZjfAH4eWE0zecmzj3vkrdKPOInGqr8PYViVQ4Rsfg?=
 =?us-ascii?Q?5zllOsmIcGTsZ1UPjrGmjDoX/zUsR58MrtHSTu6yaGjPbMQ00HuaruQ2V9og?=
 =?us-ascii?Q?Yu2/gjc0kLX+kwOg7Ac6EYabZamLMdEguB9heZd8sptvzTLkn7aF902QkJ0b?=
 =?us-ascii?Q?TwOLLFDa+loeGY/0+VZg4/h8rLBNob9HMxL9j6WldhADjKUwO49un9sk/PyE?=
 =?us-ascii?Q?3McIc1FMFNs3iP55ECPyLPBZl+riGV8PRyPLQHRk4g8CBZ1/sYKCBScJ0mrr?=
 =?us-ascii?Q?fGdtnrrG4TCwKubqiPlk0vo0mv//E3A5+KiQPp9mCB25bCeGsZsU2KdOAcff?=
 =?us-ascii?Q?AVGrH66tdZQGk8hhJrfc4TUUXrRYFL4nqmLUZCDmzhm8zQZo5MDglqe6wM5i?=
 =?us-ascii?Q?sYV99zRi9wiaKkXSWfrL72Skejp97NIgBQuMqx0WJNSW++SdJ/OLe1TgVhQf?=
 =?us-ascii?Q?fZfo1zarflqP+NhNOvA7qs0rxN1n00hWMekfdeTT4vlKQHANs3zynoGUtQbV?=
 =?us-ascii?Q?YRuFu4dhfIq/uuJ6/IP3ba14P8sUTEXzB4bzWvSoFrizn5O4ojQMgyC10dQt?=
 =?us-ascii?Q?emXo9xEfJdJWP/39IRtIdLLsaNUvOkXY1VN2r4rJVckWA/QzEvHQJYKrtCQh?=
 =?us-ascii?Q?R4eNReNK35qn59xAD518Yk3b2i/c6f60NVLRTEkutcZIw6/wXmp8xC3dN164?=
 =?us-ascii?Q?58pkY+Wxd3gWlvTcR0bfIwfZZUck8TRazs5T8a1E4QVu/z+pdrAwUn86MTn0?=
 =?us-ascii?Q?W5odTygTgKGN1rgspkX1qwLEo3w2y3vedB3K/aKoRz69r1g1YzM8XuDB5+n/?=
 =?us-ascii?Q?sERkTVKy9C/GKZN1IfRjP71uwOGcjoSh7uJsgDlpEV9jsUyDCoRFK5xGk713?=
 =?us-ascii?Q?62qPmVGdGZu+0pQT/tjh9EUmnXtIns4BUQzYSNTfrhWdRHZPo3XQuk6EDPvR?=
 =?us-ascii?Q?q4Moum9V1/h9jYucOwnMJLssY7Ea70QPEh0bbnknf3zFdKOnkRmGah6uQWu7?=
 =?us-ascii?Q?vBN5nhwLIZuiNOTH862vPFe7MPb8yFbaKuRlou9D0fUk/ynst2eAEuRSOPzE?=
 =?us-ascii?Q?ZvArpH74r7W3HnkI+KY=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2026 15:58:09.0923 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9850e86e-7952-42dd-df59-08de4e058da5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000009F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6980
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

From: Leo Chen <leo.chen@amd.com>

[Why & How]
Add the ability to enable/disable global fine grain clock gating within DCCG.

Reviewed-by: Charlene Liu <charlene.liu@amd.com>
Signed-off-by: Leo Chen <leo.chen@amd.com>
Signed-off-by: Matthew Stewart <matthew.stewart2@amd.com>
---
 drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h b/drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h
index 500a601e99b5..1e6ffd86a4c0 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h
@@ -333,6 +333,7 @@ struct dccg_funcs {
 	void (*set_ref_dscclk)(struct dccg *dccg, uint32_t dsc_inst);
 	void (*dccg_root_gate_disable_control)(struct dccg *dccg, uint32_t pipe_idx, uint32_t disable_clock_gating);
 	void (*dccg_read_reg_state)(struct dccg *dccg, struct dcn_dccg_reg_state *dccg_reg_state);
+	void (*dccg_enable_global_fgcg)(struct dccg *dccg, bool enable);
 };
 
 #endif //__DAL_DCCG_H__
-- 
2.52.0

