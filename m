Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C240ACCF9EE
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Oct 2025 10:38:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 64CB910E787;
	Wed, 29 Oct 2025 10:38:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4yoVCpe1";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011041.outbound.protection.outlook.com [40.107.208.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CC6D610E787
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Oct 2025 10:38:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h0H6nI08czC8u9Jnpz63Mnxt49kItD5XH9IvbFWMmV8rdYJK8K1TVL0JnxNdsV9b9Px8FbXtavH4ee4qrkFcUvpatEVh5yw9kvYzMwfw3CXPsJUy6N8vuNX5pGxjioLeZQwjJhtyluk3yfezeo9zU7yMxfuGQk8v7DTrBfPkZPednkzDLYdRzit6e+6isQKrMK8SddBjiwRzAKYgLwY9H9D+AuQc6ST4xfe/r1MdhpzL5S2Pi01WUAQR0p12OgVUqmQOgbyC2I1Is3cPaDqTkX8eTgBumz0jEj+Q5JMjUkUEuKBMjFbJeYSlltQRM0nloPBgG5bNugBDM08LLLWjwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x09Jzus32Xbndt/RAwl56L5dw8eeE8uBQj8Gm1hvWjI=;
 b=KvptE7DblellwC/vHjC7jEC4FVRSFjr8kauPPtYfXZtEHtO1xvBvlxZeS401mo97MWuUCno3fBjV04Q2gdtTIvE0RIkK2x34iH2k+wNVDE9slL27JLlZq1FVnI0ePRtJ6Tvft+qWc8rDrtK9rF+BSOCy+g82x0kSy9tPOqVQBk07rqy40UTSpHke83T0v194BsrIn8nNQYM8QgoGplBxoXtwEnSyET1J447neWWTWlJT3eb6Hcy/v9MlGlrNIQsgq4CNxDL7FAtbJ/btfO97UhvQ4HnDNQASafZLH9dpMStcjjCH3ykl7pi3t8O8HSrMahdLFpcySo8+j/Wf7GAOtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x09Jzus32Xbndt/RAwl56L5dw8eeE8uBQj8Gm1hvWjI=;
 b=4yoVCpe1omVjrPKRijsfPopLF4Ir5UTZ/0gny4gdJN+9W3XSqysas2d0j4nD35cO6FaU28V6SKlxogSZgMJmkb6z6jf5yFvvHZF9bJd66zZ1NOD4CTb8jLLKWzs8NG3+CPrR5yB61nfzspkOe3glB4Kl2l4kHwy16HfQCnmhKio=
Received: from MN2PR15CA0048.namprd15.prod.outlook.com (2603:10b6:208:237::17)
 by DM6PR12MB4154.namprd12.prod.outlook.com (2603:10b6:5:21d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.19; Wed, 29 Oct
 2025 10:38:13 +0000
Received: from BN3PEPF0000B370.namprd21.prod.outlook.com
 (2603:10b6:208:237:cafe::ec) by MN2PR15CA0048.outlook.office365.com
 (2603:10b6:208:237::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.13 via Frontend Transport; Wed,
 29 Oct 2025 10:38:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B370.mail.protection.outlook.com (10.167.243.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.0 via Frontend Transport; Wed, 29 Oct 2025 10:38:13 +0000
Received: from tao-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 29 Oct
 2025 03:38:11 -0700
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Tao Zhou <tao.zhou1@amd.com>
Subject: [PATCH 2/8] drm/amdgpu: add ras_eeprom_read_idx interface
Date: Wed, 29 Oct 2025 18:37:56 +0800
Message-ID: <20251029103802.1402199-2-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251029103802.1402199-1-tao.zhou1@amd.com>
References: <20251029103802.1402199-1-tao.zhou1@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B370:EE_|DM6PR12MB4154:EE_
X-MS-Office365-Filtering-Correlation-Id: 16ae4579-a5d6-45c0-7c14-08de16d74325
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?NDsXIXc5tVE8eqr/4dh40Rpw1RuDRM8pox+zsSkkMZPmalV+5wwT4oDX5/hm?=
 =?us-ascii?Q?6RuPMY5am5hFF2lp6CUOyPCoDkbWr9rS9AAydmwJdR6rWEk5a5t/hK++ZjyW?=
 =?us-ascii?Q?9dzewdojUh5Lo8SXApxBQae+IWwIF+n7i9nEzLISK+WQQAgaYVFBblQO0/3B?=
 =?us-ascii?Q?1tgPdfqDz2PpIG2vIhDXcrmuT4igwOSkQXEqogdgqZAzXxzwDsEW5KbrR1wq?=
 =?us-ascii?Q?ieyxSI1wHqk54B27IHp+2LZRJD2IkbpdzXA6fR1qCh3+f68cEyNalMVkD9jR?=
 =?us-ascii?Q?l/WdH5HqRQl0MDvo3ENftg/0VLAwbwPuyIhy+Pzx/sr7EBVRfbYu9OpMwb1u?=
 =?us-ascii?Q?NfUHkRTdGaiNkvRNPr3fdBPPmSc7pCV+b8ka3SDjhAUMI6PC6+lzH5f/YfSA?=
 =?us-ascii?Q?tJcYtbbYTBFgoWi3+JdILDI1vQ1X7gn+fFO9aZSh+Yv8ONh9W4HoolysCRad?=
 =?us-ascii?Q?BgfPZLvxwDvQByOgnTlDJvueRQp5D0LS59DM/wBC3YoDUtVOhr6QQR8J7nbo?=
 =?us-ascii?Q?bqsT0HiJYpox5M06MOQpGtXGPI2H6A1yP8jfeCLEGtgd3xhzFEeGnKplaYsh?=
 =?us-ascii?Q?WkqZJAZC253MqBGFdmlYUPOe1yP62LL9TopM07/gNCJ0cHFQ4pqz4x0iV+Rz?=
 =?us-ascii?Q?Pv5ZAkUbayotXfyxYXkTtQkf/6PmwU8BHLhYFaQ3kOXq2Bqlo7r3aVjTIq+i?=
 =?us-ascii?Q?eYFIRZXkyJmj2uDKbjmBZulKqrl3Nov7Udn9LFeT4fdTojMeSp+/6ozTH9F4?=
 =?us-ascii?Q?Y9YKy7J4cIyy50CxXRaDbXjo8iqlQXhiuwkdgpPOj37LeOp417bXih9pHbE1?=
 =?us-ascii?Q?foxuOL1sZi3vb2ozWhDPrSJyTs7KdhSDM9ScJyTxiDtecl3rcapNXlH47Xlg?=
 =?us-ascii?Q?cAM/MkHjn/rO+5JaoUDiUPvBZJY43dycun9D9IEvh4yeqD9JahsjHZ6+jXen?=
 =?us-ascii?Q?9e1KqMYwUFUqXX7JDGc1uUfKYpSA0JpoVmPrrl6LZvpiyFvyYMcY7srsN0K1?=
 =?us-ascii?Q?8QKGUjtL8WIYqk3i0PH0FzNXRvYdlhLsAikMU8s9uIuX+3Y1dReD1RkTFxdD?=
 =?us-ascii?Q?0bx622FY3nAO9J9zjzv3oKsjxQBWX+OfOVMSfjTur+7iVWAgZVrZYs5Dreox?=
 =?us-ascii?Q?+dafxS+gkcxkODhz7A/eTtbWh1j0y5/ntK8RzWadmZhl0Sb1edfgMCbuG6Fw?=
 =?us-ascii?Q?u2zJsAvpKx3+1HqHRluGm/yV/x4W086yqakNQ5rGoiJz9TMohSCVNTNdvVvy?=
 =?us-ascii?Q?7io9DYsn8U5F8HhOlnwlN8QEwW8ez9h4ZvLii6CiyIujJVU7RoJncYz6hA49?=
 =?us-ascii?Q?5FPaL/GbID6ifR9Vq05iwvtOXXEhb/qkw5JuCV0rPoNmzJ/gRqBSkvS1Mi3o?=
 =?us-ascii?Q?ML3FT9TZSV2DN7htN3uIKqkDwPkF0A7Uu8Lkpx07MAFE5JBt3XDy5mVups/7?=
 =?us-ascii?Q?TKI9rf69CHUbP30Hx1Yl7oyNAt0D5GpEmWF0bcVjcx8mXDAJ3kO8YMeCAHEG?=
 =?us-ascii?Q?cwL5qDBaM2cxythg0xvUNLsPV3cSvYn6G/QPN1z41PCcAMTiQEBUjY0Z/hRH?=
 =?us-ascii?Q?M2NxbTvcMXGJ49k/Uas=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 10:38:13.3083 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 16ae4579-a5d6-45c0-7c14-08de16d74325
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B370.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4154
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

PMFW will manage RAS eeprom data by itself, add new interface to read
eeprom data via PMFW, we can read part of records by setting index.

v2: use IPID parse interface.
    pa is not used and set it to a fixed value.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c    | 51 +++++++++++++++++++
 .../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h    |  4 ++
 2 files changed, 55 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
index 25471d286566..20d296a68934 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
@@ -963,6 +963,50 @@ static int __amdgpu_ras_eeprom_read(struct amdgpu_ras_eeprom_control *control,
 	return res;
 }
 
+int amdgpu_ras_eeprom_read_idx(struct amdgpu_ras_eeprom_control *control,
+			struct eeprom_table_record *record, u32 rec_idx,
+			const u32 num)
+{
+	struct amdgpu_device *adev = to_amdgpu_device(control);
+	uint64_t ts, end_idx;
+	int i, ret;
+	u64 mca, ipid;
+
+	if (!amdgpu_ras_smu_eeprom_supported(adev))
+		return 0;
+
+	end_idx = rec_idx + num;
+	for (i = rec_idx; i < end_idx; i++) {
+		ret = amdgpu_ras_smu_get_badpage_mca_addr(adev, i, &mca);
+		if (ret)
+			return ret;
+
+		ret = amdgpu_ras_smu_get_badpage_ipid(adev, i, &ipid);
+		if (ret)
+			return ret;
+
+		ret = amdgpu_ras_smu_get_timestamp(adev, i, &ts);
+		if (ret)
+			return ret;
+
+		record[i - rec_idx].address = mca;
+		/* retired_page (pa) is unused now */
+		record[i - rec_idx].retired_page = 0x1ULL;
+		record[i - rec_idx].ts = ts;
+		record[i - rec_idx].err_type = AMDGPU_RAS_EEPROM_ERR_NON_RECOVERABLE;
+		record[i - rec_idx].cu = 0;
+
+		if (adev->umc.ras->mca_ipid_parse)
+			adev->umc.ras->mca_ipid_parse(adev, ipid, NULL,
+				(uint32_t *)&(record[i - rec_idx].mem_channel),
+				(uint32_t *)&(record[i - rec_idx].mcumc_id), NULL);
+		else
+			return -EOPNOTSUPP;
+	}
+
+	return 0;
+}
+
 /**
  * amdgpu_ras_eeprom_read -- read EEPROM
  * @control: pointer to control structure
@@ -984,6 +1028,9 @@ int amdgpu_ras_eeprom_read(struct amdgpu_ras_eeprom_control *control,
 	u8 *buf, *pp;
 	u32 g0, g1;
 
+	if (amdgpu_ras_smu_eeprom_supported(adev))
+		return amdgpu_ras_eeprom_read_idx(control, record, 0, num);
+
 	if (!__is_ras_eeprom_supported(adev))
 		return 0;
 
@@ -1155,6 +1202,10 @@ static ssize_t amdgpu_ras_debugfs_table_read(struct file *f, char __user *buf,
 	int res = -EFAULT;
 	size_t data_len;
 
+	/* pmfw manages eeprom data by itself */
+	if (amdgpu_ras_smu_eeprom_supported(adev))
+		return 0;
+
 	mutex_lock(&control->ras_tbl_mutex);
 
 	/* We want *pos - data_len > 0, which means there's
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
index cfbd402ddea2..e881007f715b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
@@ -186,6 +186,10 @@ int amdgpu_ras_smu_get_badpage_ipid(struct amdgpu_device *adev,
 int amdgpu_ras_smu_erase_ras_table(struct amdgpu_device *adev,
 									uint32_t *result);
 
+int amdgpu_ras_eeprom_read_idx(struct amdgpu_ras_eeprom_control *control,
+			struct eeprom_table_record *record, u32 rec_idx,
+			const u32 num);
+
 extern const struct file_operations amdgpu_ras_debugfs_eeprom_size_ops;
 extern const struct file_operations amdgpu_ras_debugfs_eeprom_table_ops;
 
-- 
2.34.1

