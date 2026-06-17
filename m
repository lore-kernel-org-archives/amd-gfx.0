Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AD48CD98E4
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Jun 2026 10:01:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C895D10E9BC;
	Wed, 17 Jun 2026 10:01:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QFnfsP86";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010025.outbound.protection.outlook.com [52.101.46.25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 10BA310E9BC
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Jun 2026 10:01:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QZq4YxV20h8rCHD+koKobiAvPaKFV3JvdEXq3au/i6iAhbqjYBFrvOqzvVHXrZ5nYOEVcOkS5/kwpa+jDj/zJ8WzDr+lKM1Qa6iNczLi38oj3jwAI1wt5yMwUoccgwD/fWivwo2o+5FRenrBcJ1XITSrVJMoWwelGbuR1Y3DdY/aFzCcFK+fvqsbO7VVrRDGcEjXMp0EnzWt6Um29f67a789tqcjk7Rk65Hs/RR0b5GRqIGhqZOZvcyyH7Z7jVILoabx9ExlgFaf+5Oq6myuhPmyfBaIhSD+bIGBFjiEE09dYMXreFBkNugOavT9rw8EJRymQ+fILb2swnwLaSw+MQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gZHO/hqIjO/4YQI5KaRdwIgiXEROPjaruhPJT9uBUXE=;
 b=PG1RGgDAGcEXwJYUwBvL+MKNIMLEivB6tqH6pKgnrStjzF1gE4w6CFdhp+b3grEZrz4ATFBbl6GdNmavQqgOdd7zZrD+tjF6Ci3rQoHL0cz7ho03PiwB0PcbnhQO8+so6vovijYTPDQAr7oeTzCk/Z3KAF4UQcVTFU8VR2xdOfYOqCkv6e7hd54JwDaDzSkZzMp7PEoOWCEwc01PS+2dm4Icw/xfPEq0MO6VpkHWw11kQnlrLN5vhdkOgKL9Xu3ieh5XQJ0upuMH0bSdEhwCf3KJMfxb35qE8WuM5ZtQQAyOwlqgwTrxMhsUHCjtGiM6wcEZNOZlJiNCum/6RUOdcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gZHO/hqIjO/4YQI5KaRdwIgiXEROPjaruhPJT9uBUXE=;
 b=QFnfsP86+2q63MU691VSl2k6n1DwT2EK4LY46dDrwp8cr6bDahAiR0ryH+iTIuCUmbLPAQerhximoqp0bsK+3xJVkQG0lAGWWlQwAfhpzw4yTiFBK7sdKoByVgDyL9lfYhpKEhztTz5KCB+v1wqrcexloAAD4+lD+xzWyaW33Oc=
Received: from BL1PR13CA0325.namprd13.prod.outlook.com (2603:10b6:208:2c1::30)
 by DM4PR12MB5724.namprd12.prod.outlook.com (2603:10b6:8:5f::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.11; Wed, 17 Jun 2026 10:00:57 +0000
Received: from BL6PEPF0002256F.namprd02.prod.outlook.com
 (2603:10b6:208:2c1:cafe::90) by BL1PR13CA0325.outlook.office365.com
 (2603:10b6:208:2c1::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.11 via Frontend Transport; Wed,
 17 Jun 2026 10:00:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0002256F.mail.protection.outlook.com (10.167.249.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Wed, 17 Jun 2026 10:00:55 +0000
Received: from liuxiang-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 17 Jun
 2026 05:00:53 -0500
From: Xiang Liu <xiang.liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Tao.Zhou1@amd.com>, <Stanley.Yang@amd.com>,
 <YiPeng.Chai@amd.com>, Xiang Liu <xiang.liu@amd.com>
Subject: [PATCH] drm/amdgpu: dump RAS EEPROM table via debugfs
Date: Wed, 17 Jun 2026 18:00:34 +0800
Message-ID: <20260617100034.1811588-1-xiang.liu@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0002256F:EE_|DM4PR12MB5724:EE_
X-MS-Office365-Filtering-Correlation-Id: f76a10e8-ab57-4710-35de-08decc575300
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|23010399003|1800799024|82310400026|18002099003|11063799006|3023799007|56012099006;
X-Microsoft-Antispam-Message-Info: 6J0Iv7YsunH+FssxwWZGpFQxaXkG8YpaCG/eoDRyujnQQf2I4A9X923/Y60XTLe9coBIdUzT+qnWRwv6HB+DB4Fz/+MES+KJYXTEC9VEG2RiCkzNGIYWBPZZZqodCYa5osLcOrB9bc8DBEG0DKnoSz46HpMIOoAP3z1ntNMnCqhLN8DrcOGpwhcg7qF0QC8pUv19iv5GmZ1emotMYzEa0R1xL0MMYIaCYQb8IJWDkSy7AFAGJqEOuovPL699liL4wxbO7U++Fn0gX7lEGX2mQYCuxL/6Kb8nP4L8bCnVenXUlkXq9KFjb0pJmM7WIZGpLJkIqVq3fUkgrmFpTSVRRYk1jiaQt78pBEK0lNZppuWhQ2gGkI2km77K5v7WCbxRZFlmQkNdH8ovYOdgmZ0BtheHYD4q0xVLP2U6HNPaJGw1ljbN4LcJqdXW2l1rsi8ph96yKiIRmO3seumltCor+sWbAzUSKsTWyWsBzFFnK+t4lz7iEqviDc2OArNevd68ySAN/N3X/GP+5ZHSDwE9C+4sfFU9nlBGWYDalPVk/ygCuOFP1Yt3vUhfWfkL+eWgqvd2X5srgygr2bRyo/li3ODe0BvKLhQ1OOMfBsRCcNFfS9RzsCMtxWASNUB0ApIjQEC9usG4lSIo843cxREi3mc1GJO/sP4hUUA7ZdhNv9d7ihsfVs+kWdAhauWbSHPd4sS/8Jsnv/HRrCNqTin0fQjXMIDJaHdkCwbhuSTzxIg=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(23010399003)(1800799024)(82310400026)(18002099003)(11063799006)(3023799007)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: MOj4+r9s3zn8Korcs7g+FSPkhsulrADilsO4EOLM8ldPPp7T3OjF3Zo7F9KK5yIRZmlr17NS46kEmuaxb5uVzmZ1F/gq09vOBvAoYEiEN+6nBVRFmeyxuG+CNyWtxZxx+H67gHnRGmg+xqJlAg8i5xnSbpvb+6IIvxojPskb7uNmo1+MwKs7FPuCxAI6KvD5FwEA+gBIIjaV3YcDm4EgZup0d05uAKOXqZEYdH4uqiNWtdEpsogM0paab8CtFSlG3+EFJuWO0JXgpM/hYdX8wa6PuxwcimXBO7pyq/2mUWleOmc0bUYpJxIO44hALNvOra2ItzTB+4ecoKX/n2qSkJlkZ3DvvDElfn53D6rimhXT32Ap3fL8uW9wk5N4Wc8eDGB/rb2OAk0Al8eSEAozCxNZW6WKZTKw5Z7+qCkEUtgdXDG8txX83ntddz2+BP1w
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2026 10:00:55.9479 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f76a10e8-ab57-4710-35de-08decc575300
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0002256F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5724
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

When the RAS core manages the EEPROM, the eeprom_control is never
initialized (amdgpu_ras_init_badpage_info() returns early), so reading
ras/ras_eeprom_table in debugfs printed only a zeroed header and no
records, even though bad-page records exist in the RAS core EEPROM.

Source the table header and records from the RAS core EEPROM
(ras_core->ras_eeprom) in that case, reusing the existing output layout
so the debugfs node keeps the same format.

Signed-off-by: Xiang Liu <xiang.liu@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c    | 80 +++++++++++++++++++
 1 file changed, 80 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
index fca2b49bc13b..cc8e13084063 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
@@ -1398,6 +1398,82 @@ static ssize_t amdgpu_ras_debugfs_table_read(struct file *f, char __user *buf,
 	return res < 0 ? res : orig_size - size;
 }
 
+static ssize_t
+amdgpu_ras_debugfs_table_read_uniras(struct amdgpu_device *adev,
+				     char __user *buf,
+				     size_t size, loff_t *pos)
+{
+	struct amdgpu_ras_mgr *ras_mgr = amdgpu_ras_mgr_get_context(adev);
+	struct ras_core_context *ras_core = ras_mgr ? ras_mgr->ras_core : NULL;
+	struct eeprom_umc_record *records = NULL;
+	struct ras_eeprom_control *control;
+	size_t bufsz, len = 0;
+	u32 num_recs;
+	char *kbuf;
+	ssize_t res;
+	int i;
+
+	if (!ras_core)
+		return 0;
+
+	control = &ras_core->ras_eeprom;
+	num_recs = ras_eeprom_get_record_count(ras_core);
+
+	bufsz = strlen(tbl_hdr_str) + tbl_hdr_fmt_size +
+		strlen(rec_hdr_str) + (size_t)rec_hdr_fmt_size * num_recs + 1;
+
+	kbuf = kvmalloc(bufsz, GFP_KERNEL);
+	if (!kbuf)
+		return -ENOMEM;
+
+	if (num_recs) {
+		records = kvcalloc(num_recs, sizeof(*records), GFP_KERNEL);
+		if (!records) {
+			res = -ENOMEM;
+			goto out;
+		}
+
+		res = ras_eeprom_read(ras_core, records, num_recs);
+		if (res)
+			goto out;
+	}
+
+	len += scnprintf(kbuf + len, bufsz - len, "%s", tbl_hdr_str);
+	len += scnprintf(kbuf + len, bufsz - len, tbl_hdr_fmt,
+				 control->tbl_hdr.header,
+				 control->tbl_hdr.version,
+				 control->tbl_hdr.first_rec_offset,
+				 control->tbl_hdr.tbl_size,
+				 control->tbl_hdr.checksum);
+	len += scnprintf(kbuf + len, bufsz - len, "%s", rec_hdr_str);
+
+	for (i = 0; i < num_recs; i++) {
+		u32 ai = RAS_RI_TO_AI(control, i);
+		int et = records[i].err_type;
+		const char *ets = (et >= 0 && et < AMDGPU_RAS_EEPROM_ERR_COUNT) ?
+				  record_err_type_str[et] : "na";
+
+		len += scnprintf(kbuf + len, bufsz - len, rec_hdr_fmt,
+				 i,
+				 RAS_INDEX_TO_OFFSET(control, ai),
+				 ets,
+				 records[i].bank,
+				 records[i].ts,
+				 records[i].offset,
+				 records[i].mem_channel,
+				 records[i].mcumc_id,
+				 records[i].retired_row_pfn);
+	}
+
+	res = simple_read_from_buffer(buf, size, pos, kbuf, len);
+
+out:
+	kvfree(records);
+	kvfree(kbuf);
+
+	return res;
+}
+
 static ssize_t
 amdgpu_ras_debugfs_eeprom_table_read(struct file *f, char __user *buf,
 				     size_t size, loff_t *pos)
@@ -1411,6 +1487,10 @@ amdgpu_ras_debugfs_eeprom_table_read(struct file *f, char __user *buf,
 	if (!size)
 		return size;
 
+	if (amdgpu_uniras_enabled(adev))
+		return amdgpu_ras_debugfs_table_read_uniras(adev, buf,
+						    size, pos);
+
 	if (!ras || !control) {
 		res = snprintf(data, sizeof(data), "Not supported\n");
 		if (*pos >= res)
-- 
2.34.1

