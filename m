Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53784C531CC
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Jul 2026 00:25:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DA19110F273;
	Fri, 24 Jul 2026 00:25:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QMzcYVBK";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011036.outbound.protection.outlook.com [52.101.62.36])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 261B710F273
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Jul 2026 00:25:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ymX/ok5leFe/MJQWaa31qmSlonqjcti11IkZXg1bZ0q2NJi6frYOuKEUphjcmoVZ3GD3z6ZNc9iHtg5aWs4q9m6PhYuuu/caWixmtqWTkr7XpVLkBcJfqhB29ok+KsAHg5J1LNzas7JQ26n9W047UNgHyVaf+goFDWSrkaQSHQ5zlHhNpr78Os2B1gu8RgxrYYVqvkaA9pAtA8osZcHFVxJt8o+OyC09IKIGvXQLJkjQsGGFn8BnC2gmufnEYeBnvtJ0NIaRYyiHpOV1HSOawLm0ACL7kXlWd5OAT1iaSL4tsgtRsI92ms8wTY5769emU0uTG3juTLpBIyiAukJHpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v2/LBfNBRqDJIk0cMS4+FwVnQPF6n9ziuKByMe7aYzg=;
 b=SufQvrOp58aESJNUrYoV0+2C9Tx0fts0qIF64l4NeMFP62sdP8fSiwLoerqEobHqyLRs9N1KfK/L4ceAtUDICgdpSItmlfL35RiNG5xt6M3yYqGRfyTY7OQK3UU0/G9dWL5qHbxbafG8XYATUOyUgx7XGUn0Hkc9A2UGBX0dnmiIhaexXEaUdufb8yFC4KnQ1vBD9b06oIEsw95J+SlwMfrIVzpti85hOaoNrIkTDWBCAu8t6aUi/MNsy/BoTU1UKENpAkITZGEwuo9d1uGstqay9boGNcFCRSjriv69wHmbbuW74DgmOGZ4WtDhjnXZtzk2PTetWfC1Cic96hKmTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v2/LBfNBRqDJIk0cMS4+FwVnQPF6n9ziuKByMe7aYzg=;
 b=QMzcYVBKBVmsUI7oXo0Qn/G4RZiz4CaGu85vMHIRdAHGc3lIFqvvBb6DwdV3F7F3EQaR2wSwKoyWTs15ttYxOGF/M97w/B28bc99PN4og+GiTSYxaxymzqVgnkk7pMfRbkv2MthKU8Fkok94Dl9qPegD+kPsDWHtOEBfCktMKMI=
Received: from SJ0PR03CA0134.namprd03.prod.outlook.com (2603:10b6:a03:33c::19)
 by CH3PR12MB7761.namprd12.prod.outlook.com (2603:10b6:610:153::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.11; Fri, 24 Jul
 2026 00:24:53 +0000
Received: from SJ5PEPF00000204.namprd05.prod.outlook.com
 (2603:10b6:a03:33c:cafe::66) by SJ0PR03CA0134.outlook.office365.com
 (2603:10b6:a03:33c::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.11 via Frontend Transport; Fri,
 24 Jul 2026 00:24:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF00000204.mail.protection.outlook.com (10.167.244.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Fri, 24 Jul 2026 00:24:53 +0000
Received: from sunce-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 23 Jul
 2026 19:24:50 -0500
From: Ce Sun <cesun102@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <YiPeng.Chai@amd.com>, <Tao.Zhou1@amd.com>,
 <Stanley.Yang@amd.com>, Ce Sun <cesun102@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: normalize error return of RAS command wrapper
 functions
Date: Fri, 24 Jul 2026 08:24:40 +0800
Message-ID: <20260724002440.1091132-1-cesun102@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000204:EE_|CH3PR12MB7761:EE_
X-MS-Office365-Filtering-Correlation-Id: 309dcfad-d971-4178-6a57-08dee919fb4b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|23010399003|36860700016|1800799024|18002099003|6133799003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: /ttyLINvAof867KwlstcMagb5DW43ctFRs9YUjSUvaQKCRQXDSgpS/1fZkzzKLovW+//1MWRmFAttPW/dKSYPlM3ycl1e2mjxncRGNk/1sZFN8PdrWAVp5aEALeYfpQystmxDjPvpTJLI9PpRPIlVMX81iMo/3AMvEfvc/aBmFbXabja8fPYMG5WIsLeAKC/zKW89SkU3bAUu/BqoSGJscMUvbna7RvHgulUGnxaAomjXDDm4EllAUYHRokN0CUQKQlbHcFaNIAo4jh3AUmkKiOm7KsJTyj1sddx+pYXwf8MdJ5ZzjhyaZ/Ju/PQ+Vdb5vBbd4NsGaBN/KvYTIgu0ijZrbIpzulCChGF7AaFg5hq7lhDhPmwQe5RihK/r06v3wdIcMflewHxAs3K+TjQwAOj+5SiMI570kJ50ITZz7LEM6kh9/mI/wDULyuNt/+gcELOgvIqemUtJUDK/IXBAM4HbhA8gkMXrROJLocBV8KP5Vlf9+jK8jjJ3Luj9zFIsF/3VqAUUEefr4Wmyb37Bv7VSnmcDK7TS7Mr3QBM9JYH6It82OBVkYAX5nZ9+PwNRWfPom1dYtOrGVBmMllbKFvPVHXO1gyGbFchqObLT5qnffBdu5ph8d+pWHeO//DayAJp8ApNS2XBSJ1SSwhV+bIpr+2vLlOBa2ASrUMkgsdkVrodjMuZNgxXpTRmYQnuc9RkCACi0Rzds+FTsyo44A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(23010399003)(36860700016)(1800799024)(18002099003)(6133799003)(56012099006)(11063799006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: qOu/J5WVPWscHtzmwbxVQTgDcrGYQOmSMyzC5aJWejz8odNIXVMDozCPqu0UOFBlREp/s76hHCvc/qlv82YtAtOeA9lzvCHcasPxQyl4rEThrr9FP/gbAkC1fQ2tCJa3pTN9pG/T1MGtOeGeOWIvgxEJQo4x1T62VCT9896BfW6ANg9u/osl4Ka96EbIFtX/clufr2+WAP/THrur0RT5vHi6CVA3sGiCIrkXcY3mt3sy6IbMB0k8WPWLa5CuTDoNvGkcoWJcrGpdgaxrNzkXKvRr6wpI/ayGqmfnuPATRqxfB+r+j5BBbby8iIwPBK5fJTQnC8qxR5m6cKdB/f1UUxMGU0V6/ZvqI93oY5jfcD72qhrAWBfpZ/UC1+wmcewp1IoMmKNqm938rO7xo+Pu5KfPBhh/w8I7hDuP9CrA1xqJ0Jsj9nq980OtbbaA5vhg
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2026 00:24:53.1392 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 309dcfad-d971-4178-6a57-08dee919fb4b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF00000204.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7761
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

normalize error return of RAS command wrapper functions

Signed-off-by: Ce Sun <cesun102@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c  | 8 ++++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c | 4 ++--
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 24fd24e8d874..600f9239306d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -1436,7 +1436,7 @@ static int amdgpu_uniras_clear_badpages_info(struct amdgpu_device *adev)
 				&req, sizeof(req), NULL, 0);
 	if (ret) {
 		dev_err(adev->dev, "Failed to clear bad pages info, ret: %d\n", ret);
-		return ret;
+		return -EINVAL;
 	}
 
 	return 0;
@@ -1457,6 +1457,10 @@ static int amdgpu_uniras_query_block_ecc(struct amdgpu_device *adev,
 
 	ret = amdgpu_ras_mgr_handle_ras_cmd(adev, RAS_CMD__GET_BLOCK_ECC_STATUS,
 				&req, sizeof(req), &rsp, sizeof(rsp));
+
+	if (ret)
+		return -EINVAL;
+
 	if (!ret) {
 		info->ce_count = rsp.ce_count;
 		info->ue_count = rsp.ue_count;
@@ -1536,7 +1540,7 @@ static int amdgpu_uniras_error_inject(struct amdgpu_device *adev,
 	inject_req.method = info->value;
 
 	return amdgpu_ras_mgr_handle_ras_cmd(adev, RAS_CMD__INJECT_ERROR,
-			&inject_req, sizeof(inject_req), &rsp, sizeof(rsp));
+	       &inject_req, sizeof(inject_req), &rsp, sizeof(rsp)) ? -EINVAL : 0;
 }
 
 /* wrapper of psp_ras_trigger_error */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
index 0d34f0eca991..686c92e96025 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
@@ -526,7 +526,7 @@ static ssize_t amdgpu_ras_cper_debugfs_read(struct file *f, char __user *buf,
 					  snapshot_req, sizeof(struct ras_cmd_cper_snapshot_req),
 					  snapshot_rsp, sizeof(struct ras_cmd_cper_snapshot_rsp));
 	if (r)
-		return r;
+		return -EINVAL;
 
 	if (!snapshot_rsp->total_cper_num) {
 		if (!read_header)
@@ -568,7 +568,7 @@ static ssize_t amdgpu_ras_cper_debugfs_read(struct file *f, char __user *buf,
 						  record_rsp,
 						  sizeof(struct ras_cmd_cper_record_rsp));
 		if (r)
-			return r;
+			return -EINVAL;
 
 		if (!record_rsp->real_data_size || !record_rsp->real_cper_num)
 			break;
-- 
2.34.1

