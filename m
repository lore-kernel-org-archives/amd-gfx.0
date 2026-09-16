Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00050C88E5C
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Sep 2026 08:28:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 64BC510E14A;
	Wed, 16 Sep 2026 08:28:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="n5UKbwOG";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013064.outbound.protection.outlook.com
 [40.93.201.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DE81310E14A
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Sep 2026 08:28:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qIkgQiHRHr1wFB/kqndGm1CWdP3CTJQ/rV1tOhfVcI8Ry8jvGXVV/qA+p5PeRkJUCTwWgBJSnOSadtFiJQcUEbTdmANyk8rcNSTFK/geQ7jSGF7oPG/by1PhL3qfKUGFduaJj0XqBfZrNr896UgkV1YRU8ldZ4SPwKGlZIQiXMbnWkiEk1IciTDua6jBqa+Ubsa8NdtPV2yLpy2ZiTwztyp6BbkdjSYNOnY+zFN30ZtYkIMTWOldqLrlcEUs1fcAluZYV2InJfJ4H7Lhrg3oModORR/11nyXFlXiG0KYmtnGGbe89KMpImF1kZZNCqpP/giX2qFDCaiArUST47QYPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AkpF9hnOLrhTe8gGy1bqAWrxZswW/XsoLhUvumreyOQ=;
 b=YmZ9Mlm/o5ZmwZybzSgEZfP/LSexgoGwAaOWbyt+S8EFUhgvzH182uwoUsmsQ2glUyfhhf18ZW5LaAMHbhddy7eXXIVqJjNc1M8Ch+t6gSXAfcy9rINzrtX5FcBoFoODXVYuSZJyKUGqk2j7KsWq58sY8HE7wlWC2LjFFQ2qqBWs+RnUfffPm+LTk6BPloU9unO7lkspHNsC4ckbp3bzmPVqfwzA0DWYhnTCt7hSB2ztVXKdbdrECLxKovfnarOHKTg1dYW6xoi9LMHTEDTPKp11wKsj6plL0mpfXX4mL9Oma7/1o5XmYSY/uExRGq5T3dqdNAtZorScb6CBatZ2aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AkpF9hnOLrhTe8gGy1bqAWrxZswW/XsoLhUvumreyOQ=;
 b=n5UKbwOG0zt2cwXeVNnYuEmPcoM7fkiuir9mI7ZBjw7kFCIe+NlZZCh0psVSNpnpZDZe2FN/F/nP47WB3wrIyw/qy0O+5Er/NT8xtCTg8MiD5h3fhffTavCDdPRqERTCm8fcG6BTVQJIbuTRt+W05Faeuv4YX7b8QoOtoAXx6OU=
Received: from BN9P222CA0013.NAMP222.PROD.OUTLOOK.COM (2603:10b6:408:10c::18)
 by DS0PR12MB8343.namprd12.prod.outlook.com (2603:10b6:8:fd::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.9; Wed, 16 Sep 2026 08:27:54 +0000
Received: from LV8PEPF0000006B.namprd03.prod.outlook.com
 (2603:10b6:408:10c:cafe::ac) by BN9P222CA0013.outlook.office365.com
 (2603:10b6:408:10c::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.9 via Frontend Transport; Wed, 16
 Sep 2026 08:27:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 LV8PEPF0000006B.mail.protection.outlook.com (10.167.248.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.7 via Frontend Transport; Wed, 16 Sep 2026 08:27:54 +0000
Received: from sunce-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 16 Sep
 2026 03:27:52 -0500
From: Ce Sun <cesun102@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <YiPeng.Chai@amd.com>, <Tao.Zhou1@amd.com>,
 <Stanley.Yang@amd.com>, Ce Sun <cesun102@amd.com>
Subject: [PATCH] drm/amdgpu: skip ras error reset in gpu reset only when
 uniras is enabled
Date: Wed, 16 Sep 2026 16:27:41 +0800
Message-ID: <20260916082741.112057-1-cesun102@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PEPF0000006B:EE_|DS0PR12MB8343:EE_
X-MS-Office365-Filtering-Correlation-Id: c53fcc6f-37d7-4875-a9bb-08df13cc67aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|376014|23010399003|1800799024|18002099003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: QdPrl7uDHDk33jvgV1WLF1GT2LmCaAwBSym4ilPCAQJ9tCX73V25x2Owj0g/79EGuVNI1vczZbL1BpnE6Rua1wVXQM2hSYx359bVitkhhVg0RV27oCc6NYTkymA1ZVL6/6ZYzLmraj/EsD4jSFJMCplhLLpnXN4gd4Sj4MnbQS/DFhcFp+G8zL2YiOhSe6hRYsDWeb7CegE3/a1ogCu+aoOfJ1CmtNKD4/IWUL3IAC8ZlYL0fUAaYkB09aUt+sHzh8om9hc8xn+ALtfdvzDo3C4yKzvQ6X8HGlguhmCqAp28egGsvNgTqojQZDOMgJ05HUA+vg2uK2lZ7QeMyn2u/6vjGt8Mv55U1OAbbM51jrcnPlUgSuAuW/jqktNRMy9iUQzTr9t9YO9GdTU0+ImH2GqTsxn32dvpY0PWg4IZr5bXlRvksER5RSft1WBs5T+DvgBDUZhB5ifKovTgD+oeg/jM3U0Ckyedtg87KddnCtF3doHfy8sV+LgG9+EslqRkxeSiRg1pR99+TJU1Q0biJJ3ElC/uTWOzVmZ6Bs0aLQjvG8nlcZFUey9Z5cR9A78yIVCOi2XTed4y4mFVmPwGhjkr0pl+BZpXXsc9gU/nf/XoGnJ7Mly+Q7W3fDjBzk8TmhtO0PnGBTDu2kp5BjMZlvQ026cdeJLyOCB9ZztLwT2moTSoJ3xeNdcdvPiX+fNdxHTGA/mnW9ub9hrYQCvMmg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(376014)(23010399003)(1800799024)(18002099003)(56012099006)(11063799006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: iKrVPm+hWmI9oGir1p9/+cUPSKjSr9sBki/fYdug3smTu2f+c1QruwujJK7p6MG0nD3KmpB9xDj2VM7h3GzTcP7ABk54BP48ZHJLwQR0MbApCZTZ7AfIeBGY9XlNXq76AGpU/tvp2kMTFRckP2gUMS8X9zQM+mxcFZ86Mo2iKzZ0toJaX3N1kF3WzBwW7jihLWUe2k0HmJOIuRrDrUFGzh+qFFYoCZVrQ9v0N2awuG512uQYofeTqPPNqfjSedNemFh6VMM9MCueelrSfEF6EBJiDlpoqLHGZP368GWm35zrfzBtbVUjyCrXGT3HqrjNPnCzXdeYtFVin41gX01BsrP49Eub4P5DY7Lx6YY+Lsgx+vOSCsVSRCklsfmOFgmF8zJx+SsrQiiSabXqpMUUWI01qFn8oJckJfFSGas1Ak3BdVm6NW6TMMqvXjhy8Nh6
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 08:27:54.2969 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c53fcc6f-37d7-4875-a9bb-08df13cc67aa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: LV8PEPF0000006B.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8343
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

Original logic skips RAS error reset whenever GPU reset/RAS recovery.
Add amdgpu_uniras_enabled() check: skip reset only for uniras enabled;
non-uniras ASICs still run RAS error reset during GPU reset.

Commit "drm/amdgpu: retire MCA support" caused old ASICs UE test failure:
multiple CE/UE events across blocks. Legacy RAS relied on set_debug_mode
to decide skip RAS reset, while set_debug_mode is now only for uniras.
Use amdgpu_uniras_enabled() instead for this condition.

Fixes: b5b6231598dd ("drm/amdgpu: retire MCA support")
Signed-off-by: Ce Sun <cesun102@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 6b2b8acdbf9b..c65916d84683 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -1513,7 +1513,8 @@ int amdgpu_ras_reset_error_count(struct amdgpu_device *adev,
 		return -EOPNOTSUPP;
 
 	/* skip ras error reset in gpu reset */
-	if (amdgpu_in_reset(adev) || amdgpu_ras_in_recovery(adev))
+	if ((amdgpu_in_reset(adev) || amdgpu_ras_in_recovery(adev)) &&
+	     amdgpu_uniras_enabled(adev))
 		return -EOPNOTSUPP;
 
 	if (block_obj->hw_ops->reset_ras_error_count)
-- 
2.34.1

