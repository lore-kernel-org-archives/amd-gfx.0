Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F951E8304E
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Feb 2026 04:13:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3D9D010E4F9;
	Tue,  3 Feb 2026 04:13:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="UayuSKHr";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013004.outbound.protection.outlook.com
 [40.93.201.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CB7C710E4FA
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Feb 2026 04:13:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fTQz+7UB4cgABBPapsLP5IYKa8lV14UFkzyp/71bJuAoRR6xeCghprr2eJHa+cMjeBt3H+k3zT/mb02L2AXutn8KN/kscvQaeQmVJss6loZfG5vMIkA1bbr10n7o8J2Lahh8tdJH2to4B/dY/hwi00NWxB2xG+hCr2KpR/tVaymIScnpgrNXxnXphy6TLks4nN/6WP2KUQyWShGSu+5+AM+1xVdDUanKAlhCvxFXAOSyeMwoCXsaOMGlmQfYhKvgiJAs/keF//WO24lOiUVPasAz6a7FNwxd9zgn1aSSLaRJB7fyWzr9ZyrYd29ynR7a+ly3ATQ2pQPstn8VKoEkpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8Kd7DyfyLbtrDH0PHi53wgGkuRKkBIOfVpypQe+2q4A=;
 b=D7AXzayfuWMuwOeZMP8+zsMBscWZ5jG/S4MnB0W/8sVrxauqDI7YmKSzIN5yMDW5MxPygjuHlbtg47hB8/ei26SAESp9lGJY8ZQTcR20l6v7PrZ1xuZPV4FqqlTRl9vXKd44G+f8/uqlbUaBjZRgT1OB9MeZuaQmLFgCukljh9gFKHTzXfUqlOwfVf8nbg04BmrFu2kSIsncIwUZncI8IAsHtZTnLFZYFHobxbP0ldkn5X60Vz/lre5z5QVm4RZfWL5rrTts5KcvTlT/nB2lFisZ9zwBVc3d5Fb+Q1ek/mQFfNdOer9jrbty3ytY22PCORxFgQw003byKthPzIpd6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Kd7DyfyLbtrDH0PHi53wgGkuRKkBIOfVpypQe+2q4A=;
 b=UayuSKHraMbw+dIMfVBYRZ8Os4ZcZoUfo1ZK4M20r/n+6E9FH6r67VxLnPnARe3T1Zi+6MbPcyXgaBl7wuBwqvih6QCZD1yf49P/0JqB8lrDkq5p6p0mPP+Md/f88bJbMumaquxjCy79IhGoYl5uRZqlMnefDv+MldgDD+Hm3CA=
Received: from BN9PR03CA0655.namprd03.prod.outlook.com (2603:10b6:408:13b::30)
 by IA1PR12MB6137.namprd12.prod.outlook.com (2603:10b6:208:3eb::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Tue, 3 Feb
 2026 04:13:02 +0000
Received: from BN1PEPF00006001.namprd05.prod.outlook.com
 (2603:10b6:408:13b:cafe::45) by BN9PR03CA0655.outlook.office365.com
 (2603:10b6:408:13b::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.16 via Frontend Transport; Tue,
 3 Feb 2026 04:12:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF00006001.mail.protection.outlook.com (10.167.243.233) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Tue, 3 Feb 2026 04:13:02 +0000
Received: from gangliang-mlse-vm.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 2 Feb 2026 22:12:59 -0600
From: Gangliang Xie <ganglxie@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <tao.zhou1@amd.com>, <YiPeng.Chai@amd.com>, <KevinYang.Wang@amd.com>,
 Gangliang Xie <ganglxie@amd.com>
Subject: [PATCH V2 10/14] drm/amd/ras: add read func for pmfw eeprom
Date: Tue, 3 Feb 2026 12:12:02 +0800
Message-ID: <20260203041206.1299104-10-ganglxie@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260203041206.1299104-1-ganglxie@amd.com>
References: <20260203041206.1299104-1-ganglxie@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00006001:EE_|IA1PR12MB6137:EE_
X-MS-Office365-Filtering-Correlation-Id: b781c0a6-e56f-4fe2-da06-08de62da85fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?l1EJEtrxqcW7poaIZ7Ji4yWpiUAP3DZvOIDSCdWErXNFJvLeW641QGc2haPH?=
 =?us-ascii?Q?WZyNlyCqk0qST9bZVWuut19hop1Ot63D+zrOt+Qw4rAhmitF1jnteb+oMSKZ?=
 =?us-ascii?Q?LvpabChMleNsxYB/8GOD6gGSyNrtnOnoPHLplFGR5zamDm/Caqg2QaOOk1VG?=
 =?us-ascii?Q?mPLNyI2o+/Cp0ahvQc30QLjpH/trdBPkd870niR96gTSwbsFT7/YkUglzYno?=
 =?us-ascii?Q?J4VpjmQWf3cu9t7fOHXJBGZMSJXgwO+IzLHg/gqn6E7VLX+HTog1npymGPL2?=
 =?us-ascii?Q?nvIPPqlQq8YqHMtXZ56HBsyAd1826Lvp9hzTkRLBjaBEOD/kdEj6kNN21LiS?=
 =?us-ascii?Q?vxXDhSEpQSjlT8BUPPVLf2s00buFndtVjC7Wl6JySEqj0jhXKvcLsZnDm9xD?=
 =?us-ascii?Q?6M0H/+3JlhaC7WyHvjWb6ihuirNufkAKzFviya2cGeMmLOKhHveBmSALwm7m?=
 =?us-ascii?Q?6O49QMBTASDUnm1ROZyCgRcnode49jalvkrlZVUzLtsSyMBZudDHVW0Tcigb?=
 =?us-ascii?Q?302I8wa/MMm1W37nLOhCD4nKLntq6gNFnmlK4uGaQ0L7pjfsXX18U3TEmZre?=
 =?us-ascii?Q?HVTgslRQC0dC8u/AUZev3mF70SfGxGje8rAObQaomrOiBCJakxUz3qxU7/7K?=
 =?us-ascii?Q?ljKGLG0Z+d3cEHrpY/ZWtmOoId89NYY6P3ZFbnA0r4PR8BjBU9WEt13LguRs?=
 =?us-ascii?Q?IopXqgDfDGgyHKByztyJRuPdlYingHy2vPbYPMu6RSK0KpHD9AoLV5n+Smcl?=
 =?us-ascii?Q?xuNmZ7Hhz8XzEotX0DCpqnzL48PoSgR/Lya98BWHaY2nY5+8MtabQSRAda6/?=
 =?us-ascii?Q?5nvzYEPh+enDOZmlc56RL6Wjk0pTl6jBpsNM55GZiU/wKKAFZ9d1Nt3/eUq4?=
 =?us-ascii?Q?Xc2cCKZzULp/qMuDNmyookbG32Ml+Hk6vdBOztABYNRbSUhe3NCk4rcK2GVG?=
 =?us-ascii?Q?lpyH+bSV505kC7spHoJBeQwZTmhqbfgcLI7YsmqxZxtRPWNV93ApKvLmZjr6?=
 =?us-ascii?Q?3S3LuHdITe5pAscbrEnRKJltJJWjFb8lekQMH043HHvm5+kaNCbjRfmQXofD?=
 =?us-ascii?Q?YCJ+Z6LYSk5NvyOWa5o/TcuDjt2f49rOuCXFcn54xJffqOUYxhwXN0FGikAC?=
 =?us-ascii?Q?4e/DbI1zP06gEZtW72LFcV9g94YhbZkmDbxBULpXy5UEUVCULUygYOB4QxlR?=
 =?us-ascii?Q?6TvDACTEfvJdVEDICB8yZ4MynFNN7L9SO6B9BNnxzg/CWO5Xgq/4RbcC499X?=
 =?us-ascii?Q?8yk09e8tntuNAx/AKKSKEsMY50cE4j+ytfzkiEag+KuYWo1f18IHbOleBonA?=
 =?us-ascii?Q?aOBF7tXp2++omuce+OLv0EWmMxYa6/qxfBRrECJfmm4QNnzc89QdJP63eGFn?=
 =?us-ascii?Q?V8rcRUpByaaXW4yI0Db1XNtAQhguHYdOm14a5VLVXpM1ZKR0iVyDn3BL2sPu?=
 =?us-ascii?Q?HW3UIxHf7pZkgvFOf1tztCL/1ww/uoTK+XZU2F7SMhBv8v7Bg54r777qvFl3?=
 =?us-ascii?Q?ijmY8vuPRfRaRzRwuHJSdF5fn4/Ajc4sAfhCOvULHOOq7cYUDiNbsSDjzPl1?=
 =?us-ascii?Q?0MPvb23n/hSVefSKE1dTo7LsftR+4KuoDe32WIYdNizpXQd/hrRgTXhw1a8C?=
 =?us-ascii?Q?whmBFb95XQATZbkrW6OjRTFOgmdrseeYM+vKcufE0Revocjd5ggwrP+UaIAD?=
 =?us-ascii?Q?DXhszw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: /JfUPGqr7vEz3Bngt4Am+zoJVvciWzRwGqfHvIXGzqzI4D2FMxXRFmx7n31K0EQPqsHN5VTPPUFX+twHDjY5DvIOB/8JkDLqh0i/WUHP3h1IlnZEnHpSea9ZD1KojtWeQER94n1f/MtNoYkRZ5nSUEDcY+i+ty6eZAg0hHaPalfs8NRyPb48Nv0cWDP6aAf84J90lFvIiq/J+WOl4+pHVN1IHqDsvmwDO/Hieb6Tw5pWxs/Rxo7cxcJFrVULYl3YzdKtitvg0bmyn9bQ54xQtBs0a7BVcShBXpc7mmW87Bk0A0mgW6efjcoX30lnhKAlfyQPhUsashnqqjtay+FtM6CzvkGNf3QtcB8AooYFtaH6ErEr4e2KtPn5XFdCx2tMjOB1574P2cyJbInRtde2a72W7pjUVGZZLm/M9jWRmNfQTG1+uEKkgGlIxxJE0F6p
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 04:13:02.3024 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b781c0a6-e56f-4fe2-da06-08de62da85fb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00006001.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6137
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

v2: change lable 'Out' to 'out'

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

