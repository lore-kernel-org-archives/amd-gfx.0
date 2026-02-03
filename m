Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE288E8304E
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Feb 2026 04:13:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6F05710E4EA;
	Tue,  3 Feb 2026 04:13:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="LIK81WyR";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012017.outbound.protection.outlook.com [52.101.48.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3E84E10E4F5
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Feb 2026 04:12:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ip9541oKW/Pxq1d52HtoiM5MrflQ1SYYjVxFqZwzWqWyuj4tCMOeem5q+GNZ9FQETE/w255c23i4+Jn8OgHRiJqrTrC4uOh2kY754JOT9p7tMrmRunNjdsu/ijbvAM7cTs0/UAKuEQgI7GmgDfY2FaZRi8pywvMQ/RFhKobHFr2x0kTHGc6DoPmgtoUdfHNFCDuo1j4r/NFAaSJEG5sddjShrCVYSmKWt3F0bsUQYI8wZbdh4bJXBsD2gq80V62j6F9x2AzyTLRvfgpNJVGORplanNIMLRggXeTXKegk0rjgHACfNMxYRDn1qK0B8V38cQL+jGHiiarCwsOOp9oxqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LO4Z25MuqUxjpsJhmSGvHvbNgUFWfqEKF3yHXVF7JEU=;
 b=yTiQzq0ShX0muEPzkvtgH9CjVHA4nPZeMEySLlLxiXZESh/lFhFHW1iEwdPSXyKOodQ7r2oH8hsIoRkgy7SfCkGsKBbO3Cc59TwGs6nMWsFObBx3uPl5OXlD7+ECOwGz0T5I/pZBL41CsV+QXrAQEqiAXy79O6iFXpZB146EdDneJOZrclfQobiv3WfmLPHYaiXAKDFrukXUnM2mSOqn1RrqHS0v2KbjC+uwPpN5isBhOIPanMh2u7Uyqs5ulOa+VT1q3NUUvFz+GP90EgTPkZhOO7eG2YuN9ZOi0ayXDWsdpw3maVdxQ/07d7c1i3sHizDZVdnFRJTfmGFA7AtEkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LO4Z25MuqUxjpsJhmSGvHvbNgUFWfqEKF3yHXVF7JEU=;
 b=LIK81WyRgvleKhNkmQ5XNbo6FZk0S2M3aLwLP0k11t0DuRG8DXUTkGdFaI4J50VIhfJd6QcPM2DpF3gqrAqd/JuBejM69aMmg3E3g3YdeUzCk224eOuOhGU/hP9XsO65q9XH1B/XFpH+StNr/OjyxlpZOPz/dzgEiai5kZqQn8Q=
Received: from BN0PR04CA0072.namprd04.prod.outlook.com (2603:10b6:408:ea::17)
 by IA1PR12MB8263.namprd12.prod.outlook.com (2603:10b6:208:3f8::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Tue, 3 Feb
 2026 04:12:55 +0000
Received: from BN1PEPF00005FFE.namprd05.prod.outlook.com
 (2603:10b6:408:ea:cafe::b9) by BN0PR04CA0072.outlook.office365.com
 (2603:10b6:408:ea::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.16 via Frontend Transport; Tue,
 3 Feb 2026 04:12:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF00005FFE.mail.protection.outlook.com (10.167.243.230) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Tue, 3 Feb 2026 04:12:54 +0000
Received: from gangliang-mlse-vm.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 2 Feb 2026 22:12:53 -0600
From: Gangliang Xie <ganglxie@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <tao.zhou1@amd.com>, <YiPeng.Chai@amd.com>, <KevinYang.Wang@amd.com>,
 Gangliang Xie <ganglxie@amd.com>
Subject: [PATCH V2 07/14] drm/amd/ras: add check safety watermark func for
 pmfw eeprom
Date: Tue, 3 Feb 2026 12:11:59 +0800
Message-ID: <20260203041206.1299104-7-ganglxie@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00005FFE:EE_|IA1PR12MB8263:EE_
X-MS-Office365-Filtering-Correlation-Id: 515c7883-ea5a-467a-4858-08de62da8197
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Mzino1528i3Cjn08IE+0oAYUN3QIukWANIYYlrlRADuVHH5lo/FpBQmxSS7y?=
 =?us-ascii?Q?n/1JYKdRwdHlgwBa9b2eD0/PzqpPoG99bMT0xORGW8tw85xXJndeEfPKeeN3?=
 =?us-ascii?Q?BPHttfVmZqN4LXK8YqcZqiuIwYb0RIr0o9LTIuTzi/wbGRRGqp5wNli7Zldp?=
 =?us-ascii?Q?YgY3p8cJ+AfxYK91eZ7aVcrO/lUJd5geMtc+3/NCwmbTWsH+vmTO/A+61f8v?=
 =?us-ascii?Q?kmGO/WN9Q9ADm73oqW252y8qewn3VBSYpAaREpFfbq1Dt7F3//8cHG3f1sPF?=
 =?us-ascii?Q?Uow6ip6VyPqUgq8bvb763HvgKdlZoFNmuRPKbXcpm66RsyVR2p3FydJRCufq?=
 =?us-ascii?Q?EA1V2u1YjSAVvcXlmOq+UumQ5IB1uanJRUqb6lMrp+uaW21F+cdw3f1D3Iwd?=
 =?us-ascii?Q?Y4pdScajPbBHM2z3zXLowpx3FHtcP6RHCWR+wyiCt8AdgBbBK//HglJ27aBr?=
 =?us-ascii?Q?4zPyVvN5GyFPQu7LyxZsgWgMSM+oUyrWxgr4MNwT5msEo/sPTSn95RX/Up1t?=
 =?us-ascii?Q?sJc9JswpniTLND0NIgrcD1Iy8cvBv6G4kElgDzLwF8UA4acUhGM8yc1x5avT?=
 =?us-ascii?Q?R/KovLRMuS6twn+OZQgfMDazKQlgfTJyXmwNPTDDVsiFipkQM0DvOvtXHsAs?=
 =?us-ascii?Q?kiLfPlG5v/EaX3jQtLu1a01en3XHLUExHazIq57fjZj+JA5QXjuVYFgniZZd?=
 =?us-ascii?Q?StDCqMoObuTY6ZHG3pumkyKV4KUQ5ryuPFIjbjiV3KtfxoKWXVlFVWQQxmQ9?=
 =?us-ascii?Q?ArK6nuBgkW5bHKBBx/cMsI7aXZtnIp44RMx/dPsbz7w6B28aqDHBwQpPBPFy?=
 =?us-ascii?Q?GViT2D4y81+RoYUEyV/FSU8kb+81V1A/YFUwTP/H9zgADKparhRye+66VLc1?=
 =?us-ascii?Q?JnaVySJkT2bSdXBcvlaPOztAF1uTo7GvpEsIUcAD25CcFaJpPtWaVe/qAcWM?=
 =?us-ascii?Q?FEZGdM8Sbd3RiQyvZvtaFTW52wMcZysInYBY67f/o8HPP6uwbp1QMMHg/uCe?=
 =?us-ascii?Q?I5IKLygu6ViDz3IedC2Y5nqY6PCetNYKxlmum3Xhg993AF6wq3j+3jB6dpKs?=
 =?us-ascii?Q?Rcmnd46xxMI/GHizZjkTY3IKkLOWMKTU0DAYgRXyfWSf6ZCa5aNkx4h+NEUD?=
 =?us-ascii?Q?tLxkSGeo08HamyALaEEAKtS7H/apaOhjevP7jnbDyoFBYVSeT0AhBzXnhvKa?=
 =?us-ascii?Q?Z/zGzODwqJxql/7acsOzrLbjszypHshoh+U1kqznEsuEuWEbCq26TIKaV8uv?=
 =?us-ascii?Q?ZEnsGwkhBuwngnCRWMOB8d6IKxtq6cWL2LM2W+obt8JHUIZWVdap0QgKZjIr?=
 =?us-ascii?Q?9wGmq+zUlJfpU0eVP9YOmBGsIqL4ecjOL/ks84M0vwZ7yH7CNV60HKkkZsCX?=
 =?us-ascii?Q?bIxnN3reCHHeQarQA2WTpentnx+4SSsvjjWOAllySXlmkCkBDuaIkktIbcG5?=
 =?us-ascii?Q?2mIiqTHhDLZQOb/HUk/DTZOdnZMKEZ5COLYUtNJE8YAXou+MiaJApnF4MOIX?=
 =?us-ascii?Q?foKHttGrooho36L20q88lfQVV3KXtO+jq+VictEhrcdMf8+aQQUiUgvj99Zk?=
 =?us-ascii?Q?1svKpiK1rTKbDsk3gVi+1lXJ0iqGznjpddM3WvziLCQZr3LPPQKH7ajsppoM?=
 =?us-ascii?Q?OjvpWBsQxZByrSen+lsSLCdT2qOWiB/QlQfxD3+SnXw30kBf1rPIxFeq9WYg?=
 =?us-ascii?Q?XfVm+Q=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Rji57dBx/4hzl5C/F+5rhTrrQFB5iN96tf7QwAoRZG8TTDjDNIOk9VauN4pgPc3y5N7McZM3GnASdra/2ueMW82j/YVwlK3SKrZSiRs86IIHjy4c/Xxf7it1nIQCyRWCtAu4o1maWNBCsmJw6kCnl2D8+Puvd/ktNdUeFbkfndadbBPpXZ/krrL/KIHQNZzCb9nWrxRSJyJBhMD3eVcQsPV5M4agX5YzMEsJunTAmzypbhtyoo8OxifES2FvfZww7y26BHLvuhWVJsHkxQSltZNkaCliYY1SHF4761Q9AOxvPQMjlWxthVdR6VluAo+dNqftjXunJCqYW6HNnW7emIXzOR8qxdXvYos5yiR1jqdrAdCgLVnNNm2MpK0TPV2w4sAUbaoOx5YRmFygysNkbNeN8aDH3jUTlLtD4UPSYfNEJ+j5x3nhhuebeDAi5FaC
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 04:12:54.9351 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 515c7883-ea5a-467a-4858-08de62da8197
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00005FFE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8263
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

add check safety watermark func for pmfw eeprom

Signed-off-by: Gangliang Xie <ganglxie@amd.com>
---
 .../gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c  |  3 ++
 drivers/gpu/drm/amd/ras/rascore/ras_core.c    |  3 ++
 .../gpu/drm/amd/ras/rascore/ras_eeprom_fw.c   | 30 +++++++++++++++++++
 .../gpu/drm/amd/ras/rascore/ras_eeprom_fw.h   |  1 +
 4 files changed, 37 insertions(+)

diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
index 923bddd0af3a..36c264ab889c 100644
--- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
+++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
@@ -570,6 +570,9 @@ bool amdgpu_ras_mgr_check_eeprom_safety_watermark(struct amdgpu_device *adev)
 	if (!amdgpu_ras_mgr_is_ready(adev))
 		return false;
 
+	if (ras_fw_eeprom_supported(ras_mgr->ras_core))
+		return ras_fw_eeprom_check_safety_watermark(ras_mgr->ras_core);
+
 	return ras_eeprom_check_safety_watermark(ras_mgr->ras_core);
 }
 
diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_core.c b/drivers/gpu/drm/amd/ras/rascore/ras_core.c
index 91c883f16ae5..1f2ce3749d43 100644
--- a/drivers/gpu/drm/amd/ras/rascore/ras_core.c
+++ b/drivers/gpu/drm/amd/ras/rascore/ras_core.c
@@ -561,6 +561,9 @@ bool ras_core_is_ready(struct ras_core_context *ras_core)
 
 bool ras_core_check_safety_watermark(struct ras_core_context *ras_core)
 {
+	if (ras_fw_eeprom_supported(ras_core))
+		return ras_fw_eeprom_check_safety_watermark(ras_core);
+
 	return ras_eeprom_check_safety_watermark(ras_core);
 }
 
diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_eeprom_fw.c b/drivers/gpu/drm/amd/ras/rascore/ras_eeprom_fw.c
index ae63e7394829..34a4161251b3 100644
--- a/drivers/gpu/drm/amd/ras/rascore/ras_eeprom_fw.c
+++ b/drivers/gpu/drm/amd/ras/rascore/ras_eeprom_fw.c
@@ -190,3 +190,33 @@ int ras_fw_eeprom_reset_table(struct ras_core_context *ras_core)
 
 	return res;
 }
+
+bool ras_fw_eeprom_check_safety_watermark(struct ras_core_context *ras_core)
+{
+	struct ras_fw_eeprom_control *control = &ras_core->ras_fw_eeprom;
+	bool ret = false;
+	int bad_page_count;
+
+	if (!control->record_threshold_config)
+		return false;
+
+	bad_page_count = ras_umc_get_badpage_count(ras_core);
+
+	if (bad_page_count > control->record_threshold_count)
+		RAS_DEV_WARN(ras_core->dev, "RAS records:%d exceed threshold:%d",
+			bad_page_count, control->record_threshold_count);
+
+	if ((control->record_threshold_config == WARN_NONSTOP_OVER_THRESHOLD) ||
+		(control->record_threshold_config == NONSTOP_OVER_THRESHOLD)) {
+		RAS_DEV_WARN(ras_core->dev,
+			"Please consult AMD Service Action Guide (SAG) for appropriate service procedures.\n");
+		ret = false;
+	} else {
+		ras_core->is_rma = true;
+		RAS_DEV_WARN(ras_core->dev,
+			"Please consider adjusting the customized threshold.\n");
+		ret = true;
+	}
+
+	return ret;
+}
diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_eeprom_fw.h b/drivers/gpu/drm/amd/ras/rascore/ras_eeprom_fw.h
index a1003db3c33b..b0d3eade4377 100644
--- a/drivers/gpu/drm/amd/ras/rascore/ras_eeprom_fw.h
+++ b/drivers/gpu/drm/amd/ras/rascore/ras_eeprom_fw.h
@@ -67,5 +67,6 @@ int ras_fw_get_badpage_ipid(struct ras_core_context *ras_core,
 int ras_fw_erase_ras_table(struct ras_core_context *ras_core,
 				   uint32_t *result);
 int ras_fw_eeprom_reset_table(struct ras_core_context *ras_core);
+bool ras_fw_eeprom_check_safety_watermark(struct ras_core_context *ras_core);
 
 #endif
-- 
2.34.1

