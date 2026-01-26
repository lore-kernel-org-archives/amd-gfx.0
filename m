Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DC7BC88E42
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Jan 2026 03:56:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2B73710E39C;
	Mon, 26 Jan 2026 03:56:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="aXTg03rN";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010052.outbound.protection.outlook.com [52.101.201.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EEFA010E395
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Jan 2026 03:56:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BZgz9BoRY9vmoMuFahDDtYKTWeuDV+KbI5a9HOmqtrg0YKaaT2/mO7IQXYzMs7ZzUvWgBMWDKTeELOpfsNcnlnCBKsRF7uDy+04GuktBKeMOQGxfz8N6EdSkVOiyTlXkeRnKDRseaflCHSY3YdEEAGRqmVE/qDyWPyVExwj3ryWLNUEMh3d2DYU/h+vNLXJvaFluBlZ4hHIoKFFDV2uPwSIpx6TD/apna3k0Y/QZDg4igERRjYy1QKySCVvw0HBnO35LSreJTwzD1d9N1BprRjXXG2RuwGkhXV96pwUOOj7HRIm/daaFuXjl06Op3kcnHON2eS4gRK9/iozEWrKZHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4Lb+W2rG+DcORtt0snLdwNJoYvrJpiOUTBJ6fvYvMwU=;
 b=nZNKXjo+uc8S3e+5voxhMvVefwvmVUf1aCBvjh4HdzGYZGqu/TI7vwSEfYcKpw0T+liUyMYMV3cfAcVBHHS3UDVW4z35MUKTVRqdnxCnLJMt5HTL0dZ/i309FS7GrSdqUGP3EpHooJWZ6gIdxgvnVpgK0eaRwvpLpnmAhhTj/9HDpwEWnkDRwmv2fkDGtWlpTQ55gMLuZCSoITkCARjBu7JKP09lNPgPLKiirN0olb8bD9GxqIOgz3jkOAUNEWrgCU/mmGS0rvopnx0VC/kiDsQcuXNzULVVpmslNRJmLukx+heOEDFJIAqnqJFoCLAWxPX4jscZ7x8yjeBdnNftnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Lb+W2rG+DcORtt0snLdwNJoYvrJpiOUTBJ6fvYvMwU=;
 b=aXTg03rNSalQ34tPtjAVnoRQTMOmuF5YdAKnbuI/0wbv539WVrm/erNDdeP/Xj2zNcnFieHFkURzHsT+2OD52762eY4FwBorPxSAN4prMW3nk+NMZVHFU6OjdljpSJLg8hjRnl81TyjCyGQGTiWByqVeZIMw8pIDp+kl6+xZhdc=
Received: from DS7PR03CA0207.namprd03.prod.outlook.com (2603:10b6:5:3b6::32)
 by SJ5PPFCB5E1B8F5.namprd12.prod.outlook.com (2603:10b6:a0f:fc02::9a1) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Mon, 26 Jan
 2026 03:56:10 +0000
Received: from DS3PEPF000099D7.namprd04.prod.outlook.com
 (2603:10b6:5:3b6:cafe::3e) by DS7PR03CA0207.outlook.office365.com
 (2603:10b6:5:3b6::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.7 via Frontend Transport; Mon,
 26 Jan 2026 03:56:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS3PEPF000099D7.mail.protection.outlook.com (10.167.17.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Mon, 26 Jan 2026 03:56:10 +0000
Received: from gangliang-mlse-vm.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Sun, 25 Jan 2026 21:56:08 -0600
From: Gangliang Xie <ganglxie@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <tao.zhou1@amd.com>, <YiPeng.Chai@amd.com>, Gangliang Xie
 <ganglxie@amd.com>
Subject: [PATCH 12/14] drm/amd/ras: add initialization func for pmfw eeprom
Date: Mon, 26 Jan 2026 11:55:25 +0800
Message-ID: <20260126035527.1108488-12-ganglxie@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D7:EE_|SJ5PPFCB5E1B8F5:EE_
X-MS-Office365-Filtering-Correlation-Id: 59eff290-d586-477b-a9d6-08de5c8ed765
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?DmVR2+kS2EB8jOfqeBKT/PCDL26hLNm1NbS9vmNO18iMdqJWr/pvMQ1hYlnx?=
 =?us-ascii?Q?s/pGVpahNRm36JaogfoLXA2hDKZeOgZFGk96UpUOy2PFJ5ZpI4d8ZcY3Q48W?=
 =?us-ascii?Q?6Oii1l3NsQutlpBI8lzitkXbWl7B5diivjMJTz2YgZo521sW38kIf5XUf/bC?=
 =?us-ascii?Q?qgIpNOlcTGCchKG3PWXFRzUzrcmIxhq3ftml4mpcMJARjgllEryOUZa1eJy2?=
 =?us-ascii?Q?y786PLeZL1WLflmkKa8QFsB3RWFyRuV0iCX2v9JP/1nh9bOOAvLFkdAi9Mr6?=
 =?us-ascii?Q?vJCvieMvr1Tdumwu16mpSC7BhXcYBFVAzkVn0wmEztbvotfvSRpTNSUdN/I0?=
 =?us-ascii?Q?8LcD/6AVkoJhBnGvyz16BQ2wFurzPUfoQFDXIBH2iHhPcAsafLR5Rp7A1HXx?=
 =?us-ascii?Q?63d7wPBXP/nRN7jWjwUpcJ5rJAiIWizVOPRlvcERG7Dt3G8xlXa4RkH0d7nE?=
 =?us-ascii?Q?gJFHckBd6ySG2LlLO+0fJyGmGjl/I9a5DitWEUrW5MjG/QsJNHZEDaJk2byj?=
 =?us-ascii?Q?Q2Gohm+5o293rtu6nQxcZ+RzyATO8u4XCHcrUu9+Pj6ym8oq9oLpPdxg/l6X?=
 =?us-ascii?Q?x8jAH6lOC6EvTi8eZEBrAlRgS/z1LhyYogLxcCYC02EQ6HROfJA9zi6NiJse?=
 =?us-ascii?Q?qmNupHJ4Jg7psptpveTLHLIUrhc4AlYlOThE2k4/gcVHGSihdGEueRnlZ+qf?=
 =?us-ascii?Q?kR5BiO3eqS3GFw7N0X7V1JJKFNlIwN8WecEy/O9NhBlg3L+vd8SamJgX+B2J?=
 =?us-ascii?Q?6Em6T7VqTr6OU+Nntw6BZwy+msHk5A52p15eP0oJD0oDPWjsbucjn4ZQATe+?=
 =?us-ascii?Q?Rx2q0Gi/ha3huK5n0xa1Il9kGaIGquaH9IVj1T/5E7Z6EujzFPCfEvfMXZ4J?=
 =?us-ascii?Q?k9SUm22TPZLsUR6Eig9q4CV4URzBUhsekpj41nJYOjgPpQtP3o4it3uuM+zE?=
 =?us-ascii?Q?gyqUMZPrHT2e6YfNyzOjpTzeVXn7pBdHn8dPaCiZd2MMPSp8YRz5LjKSd43S?=
 =?us-ascii?Q?KhahNbAsHRzZNh1Gdodq41Xd1YTepKIbYRizr2s//18GgJedxDBgjS0WIwLG?=
 =?us-ascii?Q?Tjws7sDA+EXjJpFFPPt2YtWsKMDPKMXYDX304h16vICd5NuJDBCEY5zfcNm2?=
 =?us-ascii?Q?lRu8ey6tIcYjWhCbIQGDQLpFroNWuPP8hxaUOzCP7y5TqZbOxH+Z42XXsn64?=
 =?us-ascii?Q?O/rsR6WPetRUn9M8J0ZmRbYiCc+fwX6lkp0UB3+D14vCtTTDjHeBjvqUht58?=
 =?us-ascii?Q?qN6+sTE6aGh/2Sy6pIMfQ3SK9fsGqufbUGsqO4g415h3Ut3qPIEeZ0noRZ3n?=
 =?us-ascii?Q?Nij2Yfuc8KyDl07Lhf6zCj8TjzeR+fgQZiCbopmMFlJuzmbz9FEo+cUGqdzY?=
 =?us-ascii?Q?b2DGijl1W3EhgFHHCI0UQv82UJAL3MWXU+HSGVjwpsbDREGidbSTX1QD7Tvw?=
 =?us-ascii?Q?3DNdqM7IRXdQnCTrVdUCFvFNZDoKW6pcxAxR4JfICXiaDa2kceFuAd4Xakjx?=
 =?us-ascii?Q?UhdgH+X1MMcJlfCuzC3LepPQDUSg5FYRoHdKJdyEgoBfjgdTTmxVQ/+B1Jud?=
 =?us-ascii?Q?JYmgAclZguQNGasFfFYHKmgfIJMgHRIvWOaxC+lpPk/lGtrfOQl/pyqCxfsJ?=
 =?us-ascii?Q?e3JPVufJPlN1MNBRyGwCip4jOdHbw0acNPzdUs04JJ+fKKcNkq9V6vWnS/pl?=
 =?us-ascii?Q?BLqHZg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2026 03:56:10.1649 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 59eff290-d586-477b-a9d6-08de5c8ed765
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099D7.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFCB5E1B8F5
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

add initialization func for pmfw eeprom

Signed-off-by: Gangliang Xie <ganglxie@amd.com>
---
 drivers/gpu/drm/amd/ras/rascore/ras_core.c    | 15 +++-
 .../gpu/drm/amd/ras/rascore/ras_eeprom_fw.c   | 84 +++++++++++++++++++
 .../gpu/drm/amd/ras/rascore/ras_eeprom_fw.h   |  2 +
 3 files changed, 98 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_core.c b/drivers/gpu/drm/amd/ras/rascore/ras_core.c
index fe188a5304d9..1eba279a020b 100644
--- a/drivers/gpu/drm/amd/ras/rascore/ras_core.c
+++ b/drivers/gpu/drm/amd/ras/rascore/ras_core.c
@@ -387,7 +387,10 @@ int ras_core_hw_init(struct ras_core_context *ras_core)
 
 	ras_fw_init_feature_flags(ras_core);
 
-	ret = ras_eeprom_hw_init(ras_core);
+	if (ras_fw_eeprom_supported(ras_core))
+		ret = ras_fw_eeprom_hw_init(ras_core);
+	else
+		ret = ras_eeprom_hw_init(ras_core);
 	if (ret)
 		goto init_err6;
 
@@ -411,7 +414,10 @@ int ras_core_hw_init(struct ras_core_context *ras_core)
 	return 0;
 
 init_err7:
-	ras_eeprom_hw_fini(ras_core);
+	if (ras_fw_eeprom_supported(ras_core))
+		ras_fw_eeprom_hw_fini(ras_core);
+	else
+		ras_eeprom_hw_fini(ras_core);
 init_err6:
 	ras_gfx_hw_fini(ras_core);
 init_err5:
@@ -432,7 +438,10 @@ int ras_core_hw_fini(struct ras_core_context *ras_core)
 	ras_core->is_initialized = false;
 
 	ras_process_fini(ras_core);
-	ras_eeprom_hw_fini(ras_core);
+	if (ras_fw_eeprom_supported(ras_core))
+		ras_fw_eeprom_hw_fini(ras_core);
+	else
+		ras_eeprom_hw_fini(ras_core);
 	ras_gfx_hw_fini(ras_core);
 	ras_nbio_hw_fini(ras_core);
 	ras_umc_hw_fini(ras_core);
diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_eeprom_fw.c b/drivers/gpu/drm/amd/ras/rascore/ras_eeprom_fw.c
index 7a2c14f276b5..138d223a1256 100644
--- a/drivers/gpu/drm/amd/ras/rascore/ras_eeprom_fw.c
+++ b/drivers/gpu/drm/amd/ras/rascore/ras_eeprom_fw.c
@@ -369,3 +369,87 @@ int ras_fw_eeprom_update_record(struct ras_core_context *ras_core,
 
 	return ret;
 }
+
+static int __check_ras_fw_table_status(struct ras_core_context *ras_core)
+{
+	struct ras_fw_eeprom_control *control = &ras_core->ras_fw_eeprom;
+	uint64_t local_time;
+	int res;
+
+	mutex_init(&control->ras_tbl_mutex);
+
+	res = ras_fw_get_table_version(ras_core, &(control->version));
+	if (res)
+		return res;
+
+	res = ras_fw_get_badpage_count(ras_core, &(control->ras_num_recs), 100);
+	if (res)
+		return res;
+
+	local_time = (uint64_t)ktime_get_real_seconds();
+	res = ras_fw_set_timestamp(ras_core, local_time);
+	if (res)
+		return res;
+
+	control->ras_max_record_count = 4000;
+
+
+	if (control->ras_num_recs > control->ras_max_record_count) {
+		RAS_DEV_ERR(ras_core->dev,
+			"RAS header invalid, records in header: %u max allowed :%u",
+			control->ras_num_recs, control->ras_max_record_count);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+int ras_fw_eeprom_hw_init(struct ras_core_context *ras_core)
+{
+	struct ras_fw_eeprom_control *control;
+	struct ras_eeprom_config *eeprom_cfg;
+	struct ras_mp1 *mp1;
+	const struct ras_mp1_sys_func *sys_func;
+
+	if (!ras_core)
+		return -EINVAL;
+
+	mp1 = &ras_core->ras_mp1;
+	sys_func = mp1->sys_func;
+
+	if (!sys_func || !sys_func->mp1_send_eeprom_msg)
+		return -EINVAL;
+
+	ras_core->is_rma = false;
+
+	control = &ras_core->ras_fw_eeprom;
+
+	memset(control, 0, sizeof(*control));
+
+	eeprom_cfg = &ras_core->config->eeprom_cfg;
+	control->record_threshold_config =
+		eeprom_cfg->eeprom_record_threshold_config;
+
+	control->record_threshold_count = 4000;
+	if (eeprom_cfg->eeprom_record_threshold_count <
+		control->record_threshold_count)
+		control->record_threshold_count =
+			eeprom_cfg->eeprom_record_threshold_count;
+
+	control->update_channel_flag = false;
+
+	return __check_ras_fw_table_status(ras_core);
+}
+
+int ras_fw_eeprom_hw_fini(struct ras_core_context *ras_core)
+{
+	struct ras_fw_eeprom_control *control;
+
+	if (!ras_core)
+		return -EINVAL;
+
+	control = &ras_core->ras_fw_eeprom;
+	mutex_destroy(&control->ras_tbl_mutex);
+
+	return 0;
+}
diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_eeprom_fw.h b/drivers/gpu/drm/amd/ras/rascore/ras_eeprom_fw.h
index ed8ebdf22156..5966955cd847 100644
--- a/drivers/gpu/drm/amd/ras/rascore/ras_eeprom_fw.h
+++ b/drivers/gpu/drm/amd/ras/rascore/ras_eeprom_fw.h
@@ -77,5 +77,7 @@ int ras_fw_eeprom_read_idx(struct ras_core_context *ras_core,
 uint32_t ras_fw_eeprom_get_record_count(struct ras_core_context *ras_core);
 int ras_fw_eeprom_update_record(struct ras_core_context *ras_core,
 				struct ras_bank_ecc *ras_ecc);
+int ras_fw_eeprom_hw_init(struct ras_core_context *ras_core);
+int ras_fw_eeprom_hw_fini(struct ras_core_context *ras_core);
 
 #endif
-- 
2.34.1

