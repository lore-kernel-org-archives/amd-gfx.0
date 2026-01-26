Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B901EC88E43
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Jan 2026 03:56:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1DB5810E397;
	Mon, 26 Jan 2026 03:56:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2JdzjKYV";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011006.outbound.protection.outlook.com [52.101.52.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6F1B410E395
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Jan 2026 03:56:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p4nJ+yyXY81HIdJ+YuFI3pcz8B++mf1nQ+KaNiUUjvyzYfkCKdYwPC0N8PQoy+Te01SOSdDhkcq+5FMAfE4Y0iXwtIPDVaFpVPJ4yas/+4g5puPAxX6tFS5r02PvCpmxJfcvaDg012tRFG+ebaZAj8nwKSU3qN2wgopEAjaexqpxFNyZzjmZ0iQ62OW41Mzm7SQejipok+0lzqrpzqrYrD0bNDmnpWeJ/TWLiO/W4zzMNTbUTd0ivZD53mrKHDQMoJk+eNiuAVSAOoyn3Xro4eRHRtUbWNcyHONfUaVMiGnc6NY4bXBopMO707nccYugh6Dm/eQKU04t+U2TbsAeDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pcZ+lvv794BX1/DOf0DY+Dk+8ccOVsVQk4ZfeRXtWF4=;
 b=qsFDUbA49b9/yqmbEGt5pKvHL+5wQ3wrZsAocIntadFrH/piUZxBuRKYwpgSN+ZAvPamPsUX0ztiE6zalHPO11BvPFNb+0e0Bky2DbXtcC5aVTtC4oM9547AfOj0rFFcaTd5ZKjezlPYgGHQbhL1evBJDi+Bl/XAjzpoLe0Bh6+4l5KGYR/xLZR2NnfQe5zXTpqhXIpovBQqmqCKDKjbZ42gJCRvi4vEsgNRuB0PVYsIx0DfXR2ve0pzVK+3+4RBnThSWH1W5j50PSXA082DFAN+3/nYlN2y7LpmS4JWduUgO1jI8A/M6jzcRQX9tZvVb9GKFWcHIkFOO4WlQR45ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pcZ+lvv794BX1/DOf0DY+Dk+8ccOVsVQk4ZfeRXtWF4=;
 b=2JdzjKYVqVFnhHW5oDAJ5FOhLJnnjxc+iKB07ben9CUd9seZQS34Fr/IN/wEFoclSqhQgQexbeOuCMowb/V6oxOPY0fe/FJqRB/F4Wpgercx6wV9ITD38bBPvIu6aGZRqa+meMZMD00/UdVUITch0NHe/xqXLpU4msZlpngDcwY=
Received: from DS7PR03CA0183.namprd03.prod.outlook.com (2603:10b6:5:3b6::8) by
 IA1PR12MB7567.namprd12.prod.outlook.com (2603:10b6:208:42d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Mon, 26 Jan
 2026 03:56:08 +0000
Received: from DS3PEPF000099D7.namprd04.prod.outlook.com
 (2603:10b6:5:3b6:cafe::1a) by DS7PR03CA0183.outlook.office365.com
 (2603:10b6:5:3b6::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.7 via Frontend Transport; Mon,
 26 Jan 2026 03:56:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS3PEPF000099D7.mail.protection.outlook.com (10.167.17.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Mon, 26 Jan 2026 03:56:08 +0000
Received: from gangliang-mlse-vm.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Sun, 25 Jan 2026 21:56:06 -0600
From: Gangliang Xie <ganglxie@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <tao.zhou1@amd.com>, <YiPeng.Chai@amd.com>, Gangliang Xie
 <ganglxie@amd.com>
Subject: [PATCH 11/14] drm/amd/ras: adapt page retirement process for pmfw
 eeprom
Date: Mon, 26 Jan 2026 11:55:24 +0800
Message-ID: <20260126035527.1108488-11-ganglxie@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D7:EE_|IA1PR12MB7567:EE_
X-MS-Office365-Filtering-Correlation-Id: b752dd15-9e79-48f4-9705-08de5c8ed61d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?D7X9/LaMUJDIGnRYJZmbCQ5MqGHtI8qi59BRth/oGvJpIyGVthwju0tZ32uP?=
 =?us-ascii?Q?7pRt4NuSoNmFOcd9pe5GqebysPvVKVm7NNnDY37+sKna4JPo0pgVO+9DMLVd?=
 =?us-ascii?Q?6cFgz2bi1DCDpwR42VrBBsRI3dSGXrbxN48UNtwiZWjOjRYEoOecYvIQcZ1t?=
 =?us-ascii?Q?q5v+SGPCKFsnRL56LvbF0ZtuYw+OkPdsZ2dbS+7MLWrYYo8B7AGZgMgdzoqK?=
 =?us-ascii?Q?uajBb91PZlTZVb/0e4jQona0MgVSg9mBD2D1bfwpVZSNK/YRpDmHYZl4AGn9?=
 =?us-ascii?Q?pncuNw9ugzvSrP0yn52uMfr+fOwYpa6nx6Z55wGbFYGqpFKowR0SVdYw16zV?=
 =?us-ascii?Q?aNk52hAwhoFlH9TGujngfiC+MJqaIKW5+yHm6/5bKRP4BEh4FKpQvQ5BvKW2?=
 =?us-ascii?Q?fvuypZY8gJ48bs2MIc/1+WrQx/V6PT0+kNiBUDmZEKd4hc3Gx6IwQcxym1/k?=
 =?us-ascii?Q?Q12imRkxrMkEatZYwd4t7NrGNZTqo7Pb3Yqm1DLrYVcGMazbg+GXAcpx4y5v?=
 =?us-ascii?Q?zaakQhIdduOInPy2O2jnbDNcwTGd8DyeBEC11QtI972XKl+m6De7RYjwn+gz?=
 =?us-ascii?Q?mhMPjnVtZyTBJZLggJPGv3lsL9HBNpTQuSSJ/21DuIwqFSdBjbBCifuY5pOU?=
 =?us-ascii?Q?B+ozT4lJFKcnyTdDG68Es7ABJXb4aUHprxwGFecMS8DayVWj9tlZ76cPY3gI?=
 =?us-ascii?Q?jap9u/DPU9XSe4LjKgVtwBxJ8FjVWNwzHqFhpqBPZklRA8ajTXNhcMUSzvsf?=
 =?us-ascii?Q?Yw9u7Uq5XwxZe0If0SaeE1SFGNgl4pRmG1jR8of9gBdlPAvEuXI1tKFbyuEM?=
 =?us-ascii?Q?Ak0ItuqKoHDcSozHD4bpVYKU0nTETKnleuH5mb4uYQjKwDO6kZwwEpQDQ7Tx?=
 =?us-ascii?Q?Oml5WNuI+B7Q0pl0xcEh1BP7WkgFyw36U2QI00OGXGFSyqfT4pXjVi47CISa?=
 =?us-ascii?Q?af+J+i3NQe8joe9uF/Ucw7oTwij3vm6nPugV8ZRWbZyvbKlUfvwUJLylIECK?=
 =?us-ascii?Q?5LvY0v5KRutDfWFfXsnQKtce6uIwhMpXfD9KutckYt+tscsxrNmiAxgkrG/n?=
 =?us-ascii?Q?EfAHycKHcZ70mDHy7Dp6ixrGMN71Yvumj5gv+ZHH9FEtTYwuXrgIirJ0m9cT?=
 =?us-ascii?Q?AXLK2wbtEUubKlzkQWSIFqPVZ8Hp4bMgGl/w8t9d2/f1zsGAo7M0H4ERRtHF?=
 =?us-ascii?Q?zDaf+tuInx8JH+ntBFEp7TRZYqvEso++qoWm0wCWEBBx4Y7/hGU7jcG9amWy?=
 =?us-ascii?Q?516pCpuMMxnztyEs/6hltNrgFDZ4757XInRaJzkP9Z2B+6FRaSiKGQUMMcOd?=
 =?us-ascii?Q?sFs755Qw6v85eW7k6wmAsl7wD8BR5/QgYJajF6QQCF64NvjCaYXWl7Gy4uaW?=
 =?us-ascii?Q?beOll4LciroCM22mE7gHpE86EPs8oLaJXsYHvf9ur2JTLxFbRvZF2lXKSH/c?=
 =?us-ascii?Q?W9tiIOZg6E6J6n1L0KiVm48O1WCBdgERhz8gb8sz+n8MtuTmRHmUnC9raiQb?=
 =?us-ascii?Q?WlLfhlmVgeFR9k5Gj7RIV1zpBDK5I5vZ11/r+n8pzXC7GOQsexYiM4KF4RuF?=
 =?us-ascii?Q?oXQA1SjTVqT8LOr8ti4XuO9f9mRosHN2uhVSErgUKE2K1dnDpXoiCBTb2Ov1?=
 =?us-ascii?Q?AlZgQljrVsMFk3T8IQuJMAU5g/tQEJO3/lSW8zGDD1OFzvx85nV3nGDbMbi7?=
 =?us-ascii?Q?eqceeQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2026 03:56:08.0151 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b752dd15-9e79-48f4-9705-08de5c8ed61d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099D7.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7567
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

read bad page data from pmfw eeprom when retirement
is triggered, use timestamp read from eeprom

Signed-off-by: Gangliang Xie <ganglxie@amd.com>
---
 drivers/gpu/drm/amd/ras/rascore/ras_aca.c     | 31 +++++++++-----
 .../gpu/drm/amd/ras/rascore/ras_eeprom_fw.c   | 40 +++++++++++++++++++
 .../gpu/drm/amd/ras/rascore/ras_eeprom_fw.h   |  2 +
 .../gpu/drm/amd/ras/rascore/ras_umc_v12_0.c   |  3 ++
 4 files changed, 66 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_aca.c b/drivers/gpu/drm/amd/ras/rascore/ras_aca.c
index e433c70d2989..67a35409ff0e 100644
--- a/drivers/gpu/drm/amd/ras/rascore/ras_aca.c
+++ b/drivers/gpu/drm/amd/ras/rascore/ras_aca.c
@@ -234,16 +234,27 @@ static int aca_log_bad_bank(struct ras_core_context *ras_core,
 	    bank_ecc->de_count) {
 		struct ras_bank_ecc  ras_ecc = {0};
 
-		ras_ecc.nps = ras_core_get_curr_nps_mode(ras_core);
-		ras_ecc.addr = bank_ecc->bank_info.addr;
-		ras_ecc.ipid = bank_ecc->bank_info.ipid;
-		ras_ecc.status = bank_ecc->bank_info.status;
-		ras_ecc.seq_no = bank->seq_no;
-
-		if (ras_core_gpu_in_reset(ras_core))
-			ras_umc_log_bad_bank_pending(ras_core, &ras_ecc);
-		else
-			ras_umc_log_bad_bank(ras_core, &ras_ecc);
+		if (ras_fw_eeprom_supported(ras_core)) {
+			ret = ras_fw_eeprom_update_record(ras_core, &ras_ecc);
+			if (!ret) {
+				ras_ecc.nps = ras_core_get_curr_nps_mode(ras_core);
+				ras_ecc.status = bank_ecc->bank_info.status;
+				ras_ecc.seq_no = bank->seq_no;
+			}
+		} else {
+			ras_ecc.nps = ras_core_get_curr_nps_mode(ras_core);
+			ras_ecc.addr = bank_ecc->bank_info.addr;
+			ras_ecc.ipid = bank_ecc->bank_info.ipid;
+			ras_ecc.status = bank_ecc->bank_info.status;
+			ras_ecc.seq_no = bank->seq_no;
+		}
+
+		if (!ret) {
+			if (ras_core_gpu_in_reset(ras_core))
+				ras_umc_log_bad_bank_pending(ras_core, &ras_ecc);
+			else
+				ras_umc_log_bad_bank(ras_core, &ras_ecc);
+		}
 	}
 
 	aca_report_ecc_info(ras_core,
diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_eeprom_fw.c b/drivers/gpu/drm/amd/ras/rascore/ras_eeprom_fw.c
index 69e1aef67ab9..7a2c14f276b5 100644
--- a/drivers/gpu/drm/amd/ras/rascore/ras_eeprom_fw.c
+++ b/drivers/gpu/drm/amd/ras/rascore/ras_eeprom_fw.c
@@ -24,6 +24,8 @@
 
 #include "ras.h"
 
+#define RAS_SMU_MESSAGE_TIMEOUT_MS 1000 /* 1s */
+
 void ras_fw_init_feature_flags(struct ras_core_context *ras_core)
 {
 	struct ras_mp1 *mp1 = &ras_core->ras_mp1;
@@ -329,3 +331,41 @@ uint32_t ras_fw_eeprom_get_record_count(struct ras_core_context *ras_core)
 
 	return ras_core->ras_fw_eeprom.ras_num_recs;
 }
+
+int ras_fw_eeprom_update_record(struct ras_core_context *ras_core,
+				struct ras_bank_ecc *ras_ecc)
+{
+	struct ras_fw_eeprom_control *control = &ras_core->ras_fw_eeprom;
+	int ret, retry = 20;
+	u32 recs_num_new = control->ras_num_recs;
+
+	do {
+		/* 1000ms timeout is long enough, smu_get_badpage_count won't
+		 * return -EBUSY before timeout.
+		 */
+		ret = ras_fw_get_badpage_count(ras_core,
+			&recs_num_new, RAS_SMU_MESSAGE_TIMEOUT_MS);
+		if (!ret &&
+		    (recs_num_new == control->ras_num_recs)) {
+			/* record number update in PMFW needs some time,
+			 * smu_get_badpage_count may return immediately without
+			 * count update, sleep for a while and retry again.
+			 */
+			msleep(50);
+			retry--;
+		} else {
+			break;
+		}
+	} while (retry);
+
+	if (ret)
+		return ret;
+
+	if (recs_num_new > control->ras_num_recs)
+		ret = ras_fw_eeprom_read_idx(ras_core, 0,
+					ras_ecc, control->ras_num_recs, 1);
+	else
+		ret = -EINVAL;
+
+	return ret;
+}
diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_eeprom_fw.h b/drivers/gpu/drm/amd/ras/rascore/ras_eeprom_fw.h
index 7daf903ad5aa..ed8ebdf22156 100644
--- a/drivers/gpu/drm/amd/ras/rascore/ras_eeprom_fw.h
+++ b/drivers/gpu/drm/amd/ras/rascore/ras_eeprom_fw.h
@@ -75,5 +75,7 @@ int ras_fw_eeprom_read_idx(struct ras_core_context *ras_core,
 			 struct ras_bank_ecc *ras_ecc,
 			 u32 rec_idx, const u32 num);
 uint32_t ras_fw_eeprom_get_record_count(struct ras_core_context *ras_core);
+int ras_fw_eeprom_update_record(struct ras_core_context *ras_core,
+				struct ras_bank_ecc *ras_ecc);
 
 #endif
diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_umc_v12_0.c b/drivers/gpu/drm/amd/ras/rascore/ras_umc_v12_0.c
index 53dc59e4de0c..b809a2f21d73 100644
--- a/drivers/gpu/drm/amd/ras/rascore/ras_umc_v12_0.c
+++ b/drivers/gpu/drm/amd/ras/rascore/ras_umc_v12_0.c
@@ -373,6 +373,9 @@ static int umc_v12_0_bank_to_eeprom_record(struct ras_core_context *ras_core,
 		ACA_ADDR_2_ERR_ADDR(bank->addr), ACA_IPID_2_UMC_INST(bank->ipid),
 		&nps_addr, bank->nps, record);
 
+	if (ras_fw_eeprom_supported(ras_core) && bank->ts)
+		record->ts = bank->ts;
+
 	lookup_bad_pages_in_a_row(ras_core, record,
 		bank->nps, NULL, 0, bank->seq_no, true);
 
-- 
2.34.1

