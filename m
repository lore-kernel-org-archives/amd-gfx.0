Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D43ACA5FF0
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Oct 2026 13:57:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EDE5310E203;
	Tue,  6 Oct 2026 13:57:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="h/apyy/T";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013023.outbound.protection.outlook.com
 [40.93.196.23])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7370710E203
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 Oct 2026 13:57:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SKG5GBf4hwsI4XOaaOLgVTkpYEpipDY0jDnwf/55PMHB1x6mhKJ/dZoPdKGFybL27/zVBIP2CgS0ul83hK0mDIZ+IOi8gjpb0jyNAt5yprw4vwmZW7+QUoeVNazSapBXVOHYz9x1w2VKSCdW5OUU9SYc3AvfpVKZf6HNmwJyOwKzJl6fC7AGiYU2TyOBxazSABdOunxt4cLWjTKdvYtUJoE6/85OhTxwxfIKf0ezVLqIQ9WNqkZNvUu+qRx7KR8Az60Jn2QjIaaWhViSF+FXrP40zbT6cxbZehL17cjmWTcoyLCHPrZKwMNd0l80RlBGJrL7G0Wbt3FvPHUZd3tNkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DPpwGUbMR0b0SorT4bNsqrK2j0eJgc+KMl4XqOdUgPw=;
 b=PvFfmE2ZNaIJwlh98smBQxd03xkteyKm2TORMmjk/jaz4RmnxseZEmJD8+UpPPjcbJllHyvt6ZjS4ceDfJGs5LMg/Z1WHd68OLnYB4NLFiZxyilhK+cJrsxNjstSulCnkxBRa74gsI7kFpAW5OcYsdda0Fw7PyXYcUF2rhvsAKyAXjomkTAkZT+NHe9yvtjJURYN2hcYyVe4jb1gyJ9jlWr5EP/uxV+s0gJmyC26SzPPIVDj/3LqqXPKyhNbEgST0DRrWp+uRq//Je8D4A16poZGs2qECK36WqZ3S73C4rpsK88/NbIJNcrHccj9cGTbGiXl3ymwuu2TyLR5imSqKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DPpwGUbMR0b0SorT4bNsqrK2j0eJgc+KMl4XqOdUgPw=;
 b=h/apyy/T6u3YOfxa4Fe2LqkDpkGMIeuuo6P/STDOgFXEBpUypk/jby10g9LvCtpl9MQjikolJToax92G5CiAYoYjKEN1hL1fUqMYZ1gJoVaqcl00jUSPaHC6PG6iuPFgscHc4J5mCPnp/rKRPFxrKfk6CUe6uZounT2OpOLT26Y=
Received: from CY5PR16CA0015.namprd16.prod.outlook.com (2603:10b6:930:10::28)
 by PH8PR12MB8432.namprd12.prod.outlook.com (2603:10b6:510:25b::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.18; Tue, 6 Oct
 2026 13:57:10 +0000
Received: from CY4PEPF000392D9.namprd03.prod.outlook.com
 (2603:10b6:930:10:cafe::37) by CY5PR16CA0015.outlook.office365.com
 (2603:10b6:930:10::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Tue, 6
 Oct 2026 13:57:09 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF000392D9.mail.protection.outlook.com (10.167.247.119) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.14 via Frontend Transport; Tue, 6 Oct 2026 13:57:09 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 6 Oct
 2026 08:57:02 -0500
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Felix.Kuehling@amd.com>,
 <Harish.Kasiviswanathan@amd.com>, <Mukul.Joshi@amd.com>
CC: Philip Yang <Philip.Yang@amd.com>, Mukul Joshi <mukul.joshi@amd.com>
Subject: [PATCH v3] drm/amdkfd: Fix svm_bo use after free in svm_range_clone
Date: Tue, 6 Oct 2026 09:56:40 -0400
Message-ID: <20261006135641.312419-1-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF000392D9:EE_|PH8PR12MB8432:EE_
X-MS-Office365-Filtering-Correlation-Id: 8aaacc98-a403-4180-8fbe-08df23b1b6dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|23010399003|376014|36860700016|11063799006|18002099003|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info: s+1QMaZnlasKD0lxpDXXKpQFo86lAr2URz3G1WI1PpXrJe7fcBGrflcELblFNbb2BpjkoHLJ9Kjbk5MVfqswVBIXirZe1VwVTh/4WjdbMk+SMrLFCuqLbeYWkq9r0LlcCDXyvKSvr1sqsoNDNBo7AnQTeTK5sgvXLVFxKAwCLZ9u7MM06lc3pQT3wmOMQRuPWXMMITSVmg70lcvorlUBQGSEtyOdkRyz+KCWz2KBkwDOisewMmRGfKlQXJZaqJwJML+Dp9spWkGCRErBLNUdTID9zAJd4ip4zodjAVxS7KwBkEcFBxY9sk96udLGHmMyRgqwFPc5Ae8hpNnsY35TGecs/SBw9XQjh5Wghwla1aAEol2ek6fzSUEkx3Obl1HeJL3afACnlE/XppVNIX373KsjlNN8VBgg1alKTKqUdnonjlbe83AZk6KeJuILqTJAud2pco7jEN1Y5Xdguf/bicy1RR34WEjXKVf5j9aCpXG0bMfvPO5xOLgfJIkbdyNfhbxoQZIky2/IC2pSYdrLvbTUSJGRI8NSUaaTsUSK51tCtXq7anfRu2raPag8/5ltobvtIfxCxfG+oeSm6DQ8W2CncxgsbLvQjIOk+gtHwYqTgF7yBAL2wi4cp/1F9qp9bPQV3k4pszcxLQjKbgDrNMr77OZGZG464DYMd5HWJGVbuY4WNSLxcLTLsA8W7NbDRy4aKQZlP0JjQkIvpyw3og==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(23010399003)(376014)(36860700016)(11063799006)(18002099003)(10067099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: /1gLXmfKcGo1OeKiSYx5quXpdEwq03STvD/COq/q5gDLReytLnayc3u7ua/Gb1R5qxCWMrsfnlvU8UnZBY5GEutC5BnkhgFQWG39G72jPRVGgzAHs8BkrS8LK/nW4K7kvKHihnHRTZxmHJdw3KrPo4A4Z0meSQV9lxtPiNNm+CwbW2FeegUi/uRs/zwH5bfRcszhGmKjP45WyDIo7i7I9graMhSlLQoXxK7yOg6wQskF7+1hsKNz5d/b+lnBf0VxaIhVxTgst5/inm4JvKMEPucyhFU5Z/YfqDxBVEoE9k/DdBH1i/f5iWCBbptivY1WSIHMxEPL9TEfPkmfNHOse9QCw9rdn0NOcYj6iQ+p4EjT6JBGSHnFzJtSiR9hiM40lBD/h0Fm7hTNAp2ioogh0342vS78yrV+kPM9a8Hc2mi3Ba0eMkyxvsUvNbqDQ1UG
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2026 13:57:09.3367 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8aaacc98-a403-4180-8fbe-08df23b1b6dc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF000392D9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB8432
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

prange->svm_bo stays set after the range drops its reference in
svm_range_vram_node_free(), it is only cleared later by
svm_range_bo_release(). Taking a new reference based on old->svm_bo can
therefore hit a svm_bo with refcount 0 and svm_range_bo_release_async()
pending, leaving the clone with a freed svm_bo.

Use svm_bo_ref_unless_zero() under old->lock to only share the svm_bo if
it is still alive, same as svm_range_validate_svm_bo() does.

A range only holds a svm_bo reference while ttm_res is set, so drop the
reference again if old had already dropped its own. The clone keeps the
svm_bo pointer and stays on svm_bo->range_list, so svm_range_bo_release()
clears the pointer when the svm_bo goes away. The unref must be done
outside old->lock because svm_range_bo_release() takes the lock of every
range on the list, including old.

v3: drop the reference if ttm_res is not set, don't leak it.
v2: use svm_bo_ref_unless_zero instead of checking old->ttm_res, to keep
    sharing the svm_bo when the range dropped its own reference (Felix).

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index cfb428c72686..5dda163cf4ae 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -2158,14 +2158,23 @@ static struct svm_range *svm_range_clone(struct svm_range *old)
 		svm_range_free(new, false);
 		return NULL;
 	}
-	if (old->svm_bo) {
+
+	/* old->lock keeps old->svm_bo alive while taking the reference */
+	mutex_lock(&old->lock);
+	if (svm_bo_ref_unless_zero(old->svm_bo)) {
 		new->ttm_res = old->ttm_res;
 		new->offset = old->offset;
-		new->svm_bo = svm_range_bo_ref(old->svm_bo);
+		new->svm_bo = old->svm_bo;
 		spin_lock(&new->svm_bo->list_lock);
 		list_add(&new->svm_bo_list, &new->svm_bo->range_list);
 		spin_unlock(&new->svm_bo->list_lock);
 	}
+	mutex_unlock(&old->lock);
+
+	/* prange only holds an svm_bo reference while ttm_res is set */
+	if (new->svm_bo && !new->ttm_res)
+		svm_range_bo_unref(new->svm_bo);
+
 	new->flags = old->flags;
 	new->preferred_loc = old->preferred_loc;
 	new->prefetch_loc = old->prefetch_loc;
-- 
2.50.1

