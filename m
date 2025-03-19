Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82239C35FF1
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Mar 2025 06:35:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 264B210E1C5;
	Wed, 19 Mar 2025 06:35:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XO6XedH3";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2078.outbound.protection.outlook.com [40.107.212.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 463CB10E1C5
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Mar 2025 06:35:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o+f3lRKArP5gvDvG9Pn3qFwrT6P0A93xUEsMHTYUap/2tBR2nFfVT0BG6xKx0dMK4m/1AoTC7Kxff8L8A7BRWNA999GhxL66Ve+S1ZPnuT5Kk7lIBoyLN6+gWNq8wB/vZDuG4F1oIUGKB5hgivEZ4p0qS0zBNXABH6Dix2v4Nh72mJjVu/qekjYiMuQKA/b0GV2wFIkaNuNmvWtRajaIv9uFA5L0JycQ8upp4sB3yVKULy+JKoy2CGaBLX+HTHt0Tpr0G0NyUI7d1Gp5gpsjQM8jz64CLALK7LCVpw3AI9tdau4nsaCLGYwK53sxDGj235RU3TE+pPXlyuCrleMwpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O+dklCj7ro3wjOyu2xFaViN+tz99qvKBA7GB9xHfUBU=;
 b=b0NtEjfjSDbOfsqjHgpj+J9+My75YQ9zvuX/FSNm8nhimwReuHZqO5RR7Es0OnLruh2Ryk9x+fOGEIF03e/USgTmnfdV5D/J9YA4ulfit7rinimceiWML8Hp20svFAwv76RvHdVLDB602PDVFidGAzTtHWbVRRs4yTWl7cU7CwtbLF+BH6U4gzdRBnsYcEtVyRSMYs3XNFtRjq0fGRDGdsLecXoBLXAF2KKfJyzo/QyMkss++2e+vSJafqiE00OdS5lZNqkhK4dNVPt0myTBjWvH5h9KjEhaSIoQsJGarJEnTzo+Pfj1YNn0EsGYGOCJUVWN2UyzMXqoNMyWnIMQUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O+dklCj7ro3wjOyu2xFaViN+tz99qvKBA7GB9xHfUBU=;
 b=XO6XedH3ceDyUWJwsYfFbnae2qYAumeVhW/d8r2P/lnnK4OLQHvP79srMuqUjawu2IepqKyIw8YX3pQD69NlFdriswh9RbqGua5zVGSb2nYaMEiHPVWmZWgJgKFUpEXH1WMI0TcrXWIxa8bgnwsEdLxb58ipzDdjkb3SeGLiIok=
Received: from SN4PR0501CA0112.namprd05.prod.outlook.com
 (2603:10b6:803:42::29) by PH7PR12MB7915.namprd12.prod.outlook.com
 (2603:10b6:510:27c::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Wed, 19 Mar
 2025 06:35:16 +0000
Received: from SN1PEPF00036F40.namprd05.prod.outlook.com
 (2603:10b6:803:42:cafe::d3) by SN4PR0501CA0112.outlook.office365.com
 (2603:10b6:803:42::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.34 via Frontend Transport; Wed,
 19 Mar 2025 06:35:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF00036F40.mail.protection.outlook.com (10.167.248.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Wed, 19 Mar 2025 06:35:15 +0000
Received: from liuxiang-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 19 Mar
 2025 01:35:12 -0500
From: Xiang Liu <xiang.liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <KevinYang.Wang@amd.com>, <Tao.Zhou1@amd.com>,
 <YiPeng.Chai@amd.com>, Xiang Liu <xiang.liu@amd.com>
Subject: [PATCH] drm/amdgpu: Double check UC/PCC when parsing GFX UE
Date: Wed, 19 Mar 2025 14:34:57 +0800
Message-ID: <20250319063457.556379-1-xiang.liu@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F40:EE_|PH7PR12MB7915:EE_
X-MS-Office365-Filtering-Correlation-Id: 11cf36e6-1d5c-42cb-1f1f-08dd66b0358a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?N5OFtZJItsZRK6AdjnJuzY9Drs0XG2ueTYnSeZdrsvZNeHrmi83P0XlVi8h8?=
 =?us-ascii?Q?+DPSLilh/FNTGClV5eppwjgNPWSTTJHEtGMaM0Ef+NCZsK0s74DA8jFRJPXQ?=
 =?us-ascii?Q?J5HqcF4Dxpq8tKOHfqdAtmXgIUbVJCYReeh5NExphe4P2zqJ0u9Nas2bj4Mp?=
 =?us-ascii?Q?eRRMi1p3KlNd/bqEg0tWz+ZwyM6yyRBLD9kLgZZYgBev9hmESiA3wYZHYosz?=
 =?us-ascii?Q?mUeZfxBFLU4iWzSYgfeUnVSK5LZhfpi7hXIAY5hxaz2Kh/31Vv6pr8yI/z5/?=
 =?us-ascii?Q?BLiFLvUMNBUq9umI4GkXDrjvex9SXvTwMOZgG2IaYmeommsQ2Mo5pdYvdxWF?=
 =?us-ascii?Q?F3SFkXKtqU4GEmrAtkkvsCgw2xL71MCYceXquDyFygU3ngZimu8bgdYVCplP?=
 =?us-ascii?Q?QiNLzomXEMppFL7pwPcWEpBC/22f5+ZWsuZDZ0wSCwJBtbwW7ZAsSCYWbcFz?=
 =?us-ascii?Q?3TcrOxYgv8RjvtHXfGl012EKwKhYyH5nqn0JoY68StQ3tcwK5Bvf4hmLL/GO?=
 =?us-ascii?Q?6TDtRYtnx6PWRVuQe6R8LnBKmbdkXB4ugknsHCa1NzNVaHFyZstwZ873ROIn?=
 =?us-ascii?Q?rdx7Yx6egspR3eSu7AaNUptLLNHC6rs0upK4krX4qakcgE8I/PzSc0lKkGD4?=
 =?us-ascii?Q?3r3aafwi7nDv46cPPfQl2EP23kN/pbsKp+nXzOoCAY6QzBWiJmuajYWCqdEf?=
 =?us-ascii?Q?r3QYKnjB5bBTEtLF0sncpB5x21Tup6ueJ72LW/HQulzzp/o8e1atXfmm6e3E?=
 =?us-ascii?Q?LVy+W5ttAXL//sBw1Wa96LtJ0USNpt7DzybmDnmvWVgAN6A1vNWQmYJpTLwV?=
 =?us-ascii?Q?aWCxlnC1m8UZsN+FBMCMnkoff70lKKRU0go2WEIYazBCtT2NwuspSUrkfHT8?=
 =?us-ascii?Q?Xn2TEnR1Nzm+W6crZ4EMc422cCpLmhQYn5zk2FLUeH68lmIsQhQdWUcxk9oW?=
 =?us-ascii?Q?HNErZXiSE6wETF3NGcj9RzsIEYCUfgK79mBoG00AV0kVhukPANPL5Htk8V2/?=
 =?us-ascii?Q?JRkJEd7geIssLrmA9O9lICt2QaqWoaQ1DjKa4x8l4KjKLRNQY8CaNvDhiJW5?=
 =?us-ascii?Q?BScjKr7g+ydgVkUyAKj0uzcSii7s/ysgm9nVbol25Tlil3T34vD62zhc4s4t?=
 =?us-ascii?Q?79lorrjK6L+8gpHfJfefEL0dBLSiAviNkn87WwYHVADuAR0qi5MfJ9bEbG6t?=
 =?us-ascii?Q?x7gDkR3YKuyubhcXz1SuzRF0wdwWVvXKbHCk/aziQ2oEvQv4YmhJFQr2RIGx?=
 =?us-ascii?Q?jDeAt+VUrz04jMpCI0wAYiQcHXkoNh7SeOghhR1zj2DssW2EUvQGQE9EhJKW?=
 =?us-ascii?Q?85pVtSC9XBXGL9hiN2Y32vf585ttd5m+16M7SB2ZiLW3x6tnOpayrSl3UyZc?=
 =?us-ascii?Q?L4TNazA721OqAb6VVnFWbACMc5GcnzG7GbKwGfjiL7wYwJnz/uuQ/GrbJik9?=
 =?us-ascii?Q?HdJqPm/7wp9LTZ19p0hAjj3ZHyfsMItZLZ1JlWUXRiJV51Q2XVllqlQRvXik?=
 =?us-ascii?Q?LczbR0ZukDd+BxI=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2025 06:35:15.4687 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 11cf36e6-1d5c-42cb-1f1f-08dd66b0358a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00036F40.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7915
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

Double checking UC and PCC bits of status register for GFX UE to
avoid unexcepted GFX UE report.

Signed-off-by: Xiang Liu <xiang.liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index c0de682b7774..a4038e92c59e 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -876,10 +876,14 @@ static int gfx_v9_4_3_aca_bank_parser(struct aca_handle *handle,
 				      void *data)
 {
 	struct aca_bank_info info;
-	u64 misc0;
+	u64 misc0, status;
 	u32 instlo;
 	int ret;
 
+	status = bank->regs[ACA_REG_IDX_STATUS];
+	if (!ACA_REG__STATUS__VAL(status))
+		return 0;
+
 	ret = aca_bank_info_decode(bank, &info);
 	if (ret)
 		return ret;
@@ -894,8 +898,8 @@ static int gfx_v9_4_3_aca_bank_parser(struct aca_handle *handle,
 	switch (type) {
 	case ACA_SMU_TYPE_UE:
 		bank->aca_err_type = ACA_ERROR_TYPE_UE;
-		ret = aca_error_cache_log_bank_error(handle, &info,
-						     ACA_ERROR_TYPE_UE, 1ULL);
+		if (ACA_REG__STATUS__UC(status) && ACA_REG__STATUS__PCC(status))
+			ret = aca_error_cache_log_bank_error(handle, &info, ACA_ERROR_TYPE_UE, 1);
 		break;
 	case ACA_SMU_TYPE_CE:
 		bank->aca_err_type = ACA_BANK_ERR_CE_DE_DECODE(bank);
-- 
2.34.1

