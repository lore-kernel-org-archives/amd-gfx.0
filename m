Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BE96D73EB5
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Jan 2026 02:30:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 028CA10E360;
	Fri, 30 Jan 2026 02:30:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="FPHp1CEm";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012010.outbound.protection.outlook.com [52.101.48.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ED74D10E8D3
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Jan 2026 02:30:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q+HPll0NXSwTyn7LDoSbz9Y7eIMGd6kqTfR5VNYa4jumBZYg3vJlIh0CQqmg2nKKbZSvEtllJtQVL6JlhMyL5C5MU/D9Yy8yQtLlMkt3B3XYNkZesISiUj2bcWWQb4zmeKZ5CfiwFrfGI6uXiCfOSWuAzPqKVBQEdTdHxX8ad8McJSbY4/mFqPpbxTMKrbIOS8ccxuzecm3FbOvVssVN/I1cBnupR6p48jEXcAy0SCA+csyb12Tz8i0sStonrr+LVt0xKvrCcyn7XkuodV16tUxQsjDi84WyFFDsrCalw6i2M+yGuFFEoemablBuuk8P+aXRR76P24mnaMjr6xAtYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dm4/s86X0bcXzIK9mQevrswq3NRXDN49etmqrUTs9+c=;
 b=MUYXQFrE0RA5SxcMk1NIIJh7xXBV6q74edeAb/LO7Z7gIvh0/HlajZESX1WLCwmjmgZ/ntwwwNGb3CDdtd/mOKINdEQVq5Rs4YghYE7878TLsMc86lLLueUofN+jx6Z+T710vdiU6yvgd1ZWTUR3AZX4IE7LxCbEl36eCcCyms84JaSJ3mG5DVTgYcEc6try3RF6gH3LXXQWp6H8B7rJiVEr9KlZl3EArlneMS++rx0KhO/VEduf0XVkBC2iM0QiK+F3rzNgc4LPY16IrzFRrbEaCddEYl83/phppyfhVwnypiIdgCALbMHghoYbNIuXWXTFupAFNPswrDRiWaAnig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dm4/s86X0bcXzIK9mQevrswq3NRXDN49etmqrUTs9+c=;
 b=FPHp1CEmgv7grBGNSujBET9mGRdHRJzaNRi+jBrPZ1KgSKtUMqFe0Ng2DjO9PW3M/n8ePYbF7W84W61hSPcimnoET8bWcU1efwFx0hJKOuEOIHcMFp9PDombN4+0DyA7pDzTMEwnRuTNUKmqpudmJWb5HPxm2VoCgBDgVKtrrGc=
Received: from SJ0PR03CA0177.namprd03.prod.outlook.com (2603:10b6:a03:338::32)
 by DM3PR12MB9351.namprd12.prod.outlook.com (2603:10b6:8:1ac::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.8; Fri, 30 Jan
 2026 02:30:38 +0000
Received: from SJ1PEPF00001CE0.namprd05.prod.outlook.com
 (2603:10b6:a03:338:cafe::4b) by SJ0PR03CA0177.outlook.office365.com
 (2603:10b6:a03:338::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.16 via Frontend Transport; Fri,
 30 Jan 2026 02:30:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00001CE0.mail.protection.outlook.com (10.167.242.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Fri, 30 Jan 2026 02:30:38 +0000
Received: from gangliang-mlse-vm.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 29 Jan 2026 20:30:36 -0600
From: Gangliang Xie <ganglxie@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <tao.zhou1@amd.com>, <YiPeng.Chai@amd.com>, <KevinYang.Wang@amd.com>,
 Gangliang Xie <ganglxie@amd.com>
Subject: [PATCH 10/14] drm/amd/ras: add read func for pmfw eeprom
Date: Fri, 30 Jan 2026 10:29:46 +0800
Message-ID: <20260130022950.1160058-10-ganglxie@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE0:EE_|DM3PR12MB9351:EE_
X-MS-Office365-Filtering-Correlation-Id: 5388d5a4-2c9c-45bb-0032-08de5fa78e62
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?SHURCoaVGnlMWZiyCvEM6hEuq4nAmKROljU3iDHj2slWVan9nmmU116pn8AG?=
 =?us-ascii?Q?10NLfwk8k0ZfEg73C0EBbrhdFJAcBh3EvHysfLD21gvBc8NJijc9KRZ0uBCr?=
 =?us-ascii?Q?XUJRl+nTTBnqLUnRLa/2btcGuSYNzozpjqI7pIQLPdvr0jX/A7ZXARJ744ET?=
 =?us-ascii?Q?VMIhwNI8+csUJ+beRDBgpcsVR4MOa2pJDdvIhEbTDjMzCxWmDm0O6sVTuat+?=
 =?us-ascii?Q?5g4X5qs8eKnZu/UUTNJK/JbjqJrQ4ykh+fMhO4PVyhuBbcgYSJHMQsOK8gVH?=
 =?us-ascii?Q?izinrTwNO6jMKf/AL+HrffjHcITqzhcEQVUyztxEGL0X7dJea3aIyofA/CrV?=
 =?us-ascii?Q?yh1FwfMTpryE4wxo7MDc9Y9uZBz1WCVjuVPo93GxrTBVxdHtnxQEM4UKnoed?=
 =?us-ascii?Q?P1qnqFwVrvnN5qO64o90VyTuihC1bjjofz9QeuVHoUXbTjTUCP647YASYU5G?=
 =?us-ascii?Q?pHBYglYZwkHckXad1tlqkksf7WORwnbrLCkRygr3GB9CNDnIDoMxUt1FEcQ8?=
 =?us-ascii?Q?jVSgqbCIiG1xyWyZsokNpjn/qOFIIxibNz4cj0F5wCroXJoShJDInbJAR6Oe?=
 =?us-ascii?Q?cJVasYfvsihRQQwKdEZLd7gLrEBrzxexsZp9rd3Try/8fbBmHu4Mp6eRPgjh?=
 =?us-ascii?Q?ZZ/uB/YYiywoU9qdRt4gvEvNrJZn25iRrmTj1eCwtAJEqJKjBItD+Qgsdo1S?=
 =?us-ascii?Q?r81FP5311nnhBA+53bWl83b3FQqlMQ0qwm/pNaaGAK/siqzHwLEOzpztG2NX?=
 =?us-ascii?Q?6+9O02z5htfV0BbziES9iourjD/EY3hPSr5C+RiV1iZkN/E6LU050sDPQn4Z?=
 =?us-ascii?Q?aYWfgWOINdPVNoe14Zl0apsE9YF0i+afQsmssoI5zX+Jo+Va+vvr0xzrHUQV?=
 =?us-ascii?Q?AxGpoO1wIxATNKVmMazbMV5ys3DBl+FwnqQ52JFlP4LM9E3Q/UDT47Fr9tFb?=
 =?us-ascii?Q?72baFE7r7gL7/5bI4qhUK+7iViMpZZ4laFVy+XZkr81pXHT6t4koWBsVuDdg?=
 =?us-ascii?Q?UJGxWQblR9u4pbOvI/VoCPpl6RjMh+5IYxeeYY6cvPusLJn0sQlkujIMItvP?=
 =?us-ascii?Q?oS8LjvjemC2zT4UfkqbWtYoyLSR9ZNNSoT0eaFXUM3dkwxUWZAqHzXgBST6j?=
 =?us-ascii?Q?BZntRV8RjCVmkrMudNhI6p8FQV4qRu4+Ep2WocN1tqBQbFdqjLUkfRaEfDM7?=
 =?us-ascii?Q?GGC9KasS0Lvfsd9L7EHOKSDEQvUn51neRLIF3TlRjowIQTXEBvJhbH2Cg3qz?=
 =?us-ascii?Q?j4dD/+S0B2gHQReZQthkfu1Q4eLHjRwb8HvElmIMME63lofAneosW423AfLl?=
 =?us-ascii?Q?+NgzeUg97DnppqQM8PBuMmMrrTVHcKjpJxlnhiQ8uu3PL8hZ2cTybwd3mIKF?=
 =?us-ascii?Q?GEAiTxRyuYiixz8+XTOYFoy44EPrC7ci4MjNr8zoBaHUI255B4vWOMOJQK+c?=
 =?us-ascii?Q?S/DJ3WEIr9zAFXXB2oNGq3QKS8m/aIzJJEzE9njwbMcE5KnVNSq+LEvWlTR1?=
 =?us-ascii?Q?Cgst2S7BcoiRwKdjMr6EiI2Ug9IIKrV8se32TgIq21GGX+fdtzJOwn7I4CEJ?=
 =?us-ascii?Q?JjYmprJvvwkKRwlu8fKrSetcKXsJqudYniIAqsn18JgWYPVScECaaqBIj3y5?=
 =?us-ascii?Q?q9a+f5mVHJAmAVf50QzbChdTp8NVwhwlR4fXwKMuDh0sUcenLSXvBWe739Kl?=
 =?us-ascii?Q?merQUg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Elb8gUjCKUKUHUjaFI7TxvhjxFrvPKH+hm17BTNtW4xrC0Pg/3eQLj6JKbQMkYYAH+E5ZAGAmxzj1s2i4sALhgtIme9n9W+HogZbn5VZkMg2/qH3yaD0CbxLmXdK+W1XSZOvRZ5SqCCmOO0KoZt0DNAilXbzzU4eCwou3ioiT2VR+ZyCK5SyxlpXEfdg3jwGY16FWDPGhA/lOyBb2OVhT04K65T49Gpigoa4IzBfPPBMfWn3fhevpphDkHyIPGpVqbc/n8a42SelEWt3vD+6VR57eA559dhZ5m0MdusaWhcqK6It1DnXmH73eiLZQENw5fxq5RtHnN2/arAYH5uSeS2yMxKgHV1j/BIPaaX314S9uFi37mUuQ7zD8HlwqFRriV6dmnohs7ejX3fDk4m5gTtWW9/VcoHZTcGmWu3mfb8EI7/gzM5DtJJpVrZB02MP
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2026 02:30:38.5361 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5388d5a4-2c9c-45bb-0032-08de5fa78e62
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9351
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

add read func for pmfw eeprom, and adapt address converting
for bad pages loaded from pmfw eeprom

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
Signed-off-by: Gangliang Xie <ganglxie@amd.com>
---
 drivers/gpu/drm/amd/ras/rascore/ras.h         |  1 +
 drivers/gpu/drm/amd/ras/rascore/ras_core.c    |  5 +-
 .../gpu/drm/amd/ras/rascore/ras_eeprom_fw.c   | 70 +++++++++++++++++++
 .../gpu/drm/amd/ras/rascore/ras_eeprom_fw.h   |  5 ++
 drivers/gpu/drm/amd/ras/rascore/ras_umc.c     | 27 +++++--
 .../gpu/drm/amd/ras/rascore/ras_umc_v12_0.c   |  2 +-
 6 files changed, 101 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/ras/rascore/ras.h b/drivers/gpu/drm/amd/ras/rascore/ras.h
index ae10d853c565..05c7923e8f0f 100644
--- a/drivers/gpu/drm/amd/ras/rascore/ras.h
+++ b/drivers/gpu/drm/amd/ras/rascore/ras.h
@@ -241,6 +241,7 @@ struct ras_bank_ecc {
 	uint64_t status;
 	uint64_t ipid;
 	uint64_t addr;
+	uint64_t ts;
 };
 
 struct ras_bank_ecc_node {
diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_core.c b/drivers/gpu/drm/amd/ras/rascore/ras_core.c
index 1f2ce3749d43..fe188a5304d9 100644
--- a/drivers/gpu/drm/amd/ras/rascore/ras_core.c
+++ b/drivers/gpu/drm/amd/ras/rascore/ras_core.c
@@ -239,7 +239,10 @@ static int ras_core_eeprom_recovery(struct ras_core_context *ras_core)
 	int count;
 	int ret;
 
-	count = ras_eeprom_get_record_count(ras_core);
+	if (ras_fw_eeprom_supported(ras_core))
+		count = ras_fw_eeprom_get_record_count(ras_core);
+	else
+		count = ras_eeprom_get_record_count(ras_core);
 	if (!count)
 		return 0;
 
diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_eeprom_fw.c b/drivers/gpu/drm/amd/ras/rascore/ras_eeprom_fw.c
index 580dd7b09d00..79494ad16ee5 100644
--- a/drivers/gpu/drm/amd/ras/rascore/ras_eeprom_fw.c
+++ b/drivers/gpu/drm/amd/ras/rascore/ras_eeprom_fw.c
@@ -259,3 +259,73 @@ int ras_fw_eeprom_append(struct ras_core_context *ras_core,
 	mutex_unlock(&control->ras_tbl_mutex);
 	return 0;
 }
+
+int ras_fw_eeprom_read_idx(struct ras_core_context *ras_core,
+			 struct eeprom_umc_record *record_umc,
+			 struct ras_bank_ecc *ras_ecc,
+			 u32 rec_idx, const u32 num)
+{
+	struct ras_fw_eeprom_control *control = &ras_core->ras_fw_eeprom;
+	int i, ret, end_idx;
+	u64 mca, ipid, ts;
+
+	if (!ras_core->ras_umc.ip_func ||
+	    !ras_core->ras_umc.ip_func->mca_ipid_parse)
+		return -EOPNOTSUPP;
+
+	mutex_lock(&control->ras_tbl_mutex);
+
+	end_idx = rec_idx + num;
+	for (i = rec_idx; i < end_idx; i++) {
+		ret = ras_fw_get_badpage_mca_addr(ras_core, i, &mca);
+		if (ret)
+			goto out;
+
+		ret = ras_fw_get_badpage_ipid(ras_core, i, &ipid);
+		if (ret)
+			goto out;
+
+		ret = ras_fw_get_timestamp(ras_core, i, &ts);
+		if (ret)
+			goto out;
+
+		if (record_umc) {
+			record_umc[i - rec_idx].address = mca;
+			/* retired_page (pa) is unused now */
+			record_umc[i - rec_idx].retired_row_pfn = 0x1ULL;
+			record_umc[i - rec_idx].ts = ts;
+			record_umc[i - rec_idx].err_type = RAS_EEPROM_ERR_NON_RECOVERABLE;
+
+			ras_core->ras_umc.ip_func->mca_ipid_parse(ras_core, ipid,
+				(uint32_t *)&(record_umc[i - rec_idx].cu),
+				(uint32_t *)&(record_umc[i - rec_idx].mem_channel),
+				(uint32_t *)&(record_umc[i - rec_idx].mcumc_id), NULL);
+
+			/* update bad channel bitmap */
+			if ((record_umc[i - rec_idx].mem_channel < BITS_PER_TYPE(control->bad_channel_bitmap)) &&
+				!(control->bad_channel_bitmap & (1 << record_umc[i - rec_idx].mem_channel))) {
+				control->bad_channel_bitmap |= 1 << record_umc[i - rec_idx].mem_channel;
+				control->update_channel_flag = true;
+			}
+		}
+
+		if (ras_ecc) {
+			ras_ecc[i - rec_idx].addr = mca;
+			ras_ecc[i - rec_idx].ipid = ipid;
+			ras_ecc[i - rec_idx].ts = ts;
+		}
+
+	}
+
+out:
+	mutex_unlock(&control->ras_tbl_mutex);
+	return ret;
+}
+
+uint32_t ras_fw_eeprom_get_record_count(struct ras_core_context *ras_core)
+{
+	if (!ras_core)
+		return 0;
+
+	return ras_core->ras_fw_eeprom.ras_num_recs;
+}
diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_eeprom_fw.h b/drivers/gpu/drm/amd/ras/rascore/ras_eeprom_fw.h
index b94d3c9703e3..353977a2371e 100644
--- a/drivers/gpu/drm/amd/ras/rascore/ras_eeprom_fw.h
+++ b/drivers/gpu/drm/amd/ras/rascore/ras_eeprom_fw.h
@@ -70,5 +70,10 @@ int ras_fw_eeprom_reset_table(struct ras_core_context *ras_core);
 bool ras_fw_eeprom_check_safety_watermark(struct ras_core_context *ras_core);
 int ras_fw_eeprom_append(struct ras_core_context *ras_core,
 			   struct eeprom_umc_record *record, const u32 num);
+int ras_fw_eeprom_read_idx(struct ras_core_context *ras_core,
+			 struct eeprom_umc_record *record_umc,
+			 struct ras_bank_ecc *ras_ecc,
+			 u32 rec_idx, const u32 num);
+uint32_t ras_fw_eeprom_get_record_count(struct ras_core_context *ras_core);
 
 #endif
diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_umc.c b/drivers/gpu/drm/amd/ras/rascore/ras_umc.c
index fd427fd59ecf..eb5bb6df18f5 100644
--- a/drivers/gpu/drm/amd/ras/rascore/ras_umc.c
+++ b/drivers/gpu/drm/amd/ras/rascore/ras_umc.c
@@ -436,17 +436,27 @@ int ras_umc_load_bad_pages(struct ras_core_context *ras_core)
 	uint32_t ras_num_recs;
 	int ret;
 
-	ras_num_recs = ras_eeprom_get_record_count(ras_core);
-	/* no bad page record, skip eeprom access */
-	if (!ras_num_recs ||
-	    ras_core->ras_eeprom.record_threshold_config == DISABLE_RETIRE_PAGE)
-		return 0;
+	if (ras_fw_eeprom_supported(ras_core)) {
+		ras_num_recs = ras_fw_eeprom_get_record_count(ras_core);
+		/* no bad page record, skip eeprom access */
+		if (!ras_num_recs ||
+		    ras_core->ras_fw_eeprom.record_threshold_config == DISABLE_RETIRE_PAGE)
+			return 0;
+	} else {
+		ras_num_recs = ras_eeprom_get_record_count(ras_core);
+		if (!ras_num_recs ||
+		    ras_core->ras_eeprom.record_threshold_config == DISABLE_RETIRE_PAGE)
+			return 0;
+	}
 
 	bps = kcalloc(ras_num_recs, sizeof(*bps), GFP_KERNEL);
 	if (!bps)
 		return -ENOMEM;
 
-	ret = ras_eeprom_read(ras_core, bps, ras_num_recs);
+	if (ras_fw_eeprom_supported(ras_core))
+		ret = ras_fw_eeprom_read_idx(ras_core, bps, 0, 0, ras_num_recs);
+	else
+		ret = ras_eeprom_read(ras_core, bps, ras_num_recs);
 	if (ret) {
 		RAS_DEV_ERR(ras_core->dev, "Failed to load EEPROM table records!");
 	} else {
@@ -474,7 +484,10 @@ static int ras_umc_save_bad_pages(struct ras_core_context *ras_core)
 	if (!data->bps)
 		return 0;
 
-	eeprom_record_num = ras_eeprom_get_record_count(ras_core);
+	if (ras_fw_eeprom_supported(ras_core))
+		eeprom_record_num = ras_fw_eeprom_get_record_count(ras_core);
+	else
+		eeprom_record_num = ras_eeprom_get_record_count(ras_core);
 	mutex_lock(&ras_umc->umc_lock);
 	save_count = data->count - eeprom_record_num;
 	/* only new entries are saved */
diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_umc_v12_0.c b/drivers/gpu/drm/amd/ras/rascore/ras_umc_v12_0.c
index e2792b239bea..53dc59e4de0c 100644
--- a/drivers/gpu/drm/amd/ras/rascore/ras_umc_v12_0.c
+++ b/drivers/gpu/drm/amd/ras/rascore/ras_umc_v12_0.c
@@ -413,7 +413,7 @@ static int umc_v12_0_eeprom_record_to_nps_record(struct ras_core_context *ras_co
 	uint64_t pa = 0;
 	int ret = 0;
 
-	if (nps == EEPROM_RECORD_UMC_NPS_MODE(record)) {
+	if (nps == EEPROM_RECORD_UMC_NPS_MODE(record) && !ras_fw_eeprom_supported(ras_core)) {
 		record->cur_nps_retired_row_pfn = EEPROM_RECORD_UMC_ADDR_PFN(record);
 	} else {
 		ret = convert_eeprom_record_to_nps_addr(ras_core,
-- 
2.34.1

