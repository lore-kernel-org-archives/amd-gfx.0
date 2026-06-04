Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43F64CD6E4A
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Jun 2026 14:15:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D7D9B11A11F;
	Thu,  4 Jun 2026 14:15:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0fLWTrTy";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010004.outbound.protection.outlook.com [52.101.85.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5572111A11F
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 Jun 2026 14:15:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nh9lyEoh9JBGwHkNyFH8T/6cui2WQi5Tz/t3VJg5TEetgeO9Y9k6khTzYcjlorx5iYEzrRxbJLcJ4rM0ZcwiVvpMWMy+yk2SB06ePPK6vp6oQdHRyH9/5VzryvMkCDkGYxRtb4kDGga9ZvOqqiJYtL+SGFL15ppN3prWUPLjeM8Q4YRIWQrngwmafe0hE6r2oqAK5n7D8KxzyGMMNi9dEmedxbXf22EOeHYCH78CA8b0X5AxzUkLPFIsEcKfcBhmZYE/LNy6nHHm/94BXGt9YqmQx9jLhB6Qdao4af+U7zELEz2/6NffW3X9FyZBkwm5geKJs37bEPkw0FWNjNjeNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dDIEbX0qFjfzEWdjWkf+IH9wGQ/io4jtbcREDB4nEOc=;
 b=oLZdZds6Yq/v+ruG7EAzOw3lSPhqir4i8AI3uG5kDPD8G33QlagQpyETcFlpsYZGlyfEwhoHdGsACwcjnLmTieGRUFt3C+dcBooEDS4bWkhmlVrrkdFsDjss0RJYSQ+Lo6V7kkKtC9h5tmtsWEGhzgUzHJDGKzM9c2MRiqtiKT35/D37lCj8AVHQrK4/YWOdEfaZDlEGF4/L9W/HY6inQSUeZ6Q2mReAoHWNdux/3R3JUNsUFsFvq2QbPMZpKgyOUoJZC1t3BMN7AqWKEFl1cpB00T8tYUkbJGhBlWDaQUi02aXbM/ABxDgo0fSbZgxVwsgeZpJwWNaLYjawV7iIkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dDIEbX0qFjfzEWdjWkf+IH9wGQ/io4jtbcREDB4nEOc=;
 b=0fLWTrTygt472o+XzIHYDI8CEady+qg0KDpU+zOAWPOZf8XtIf6A7oNo+gzvspdqtBVkCUBDULTw7gf55ZNQhGR+/7CZIk1JN5Z7G5+H52Z3Uk87zfoxz//mZEfCaZb0XmGAfJLdjqlUreI7c6t1YLidzDWoIM0PuRACBXux1h0=
Received: from SA1P222CA0159.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c3::7)
 by SA1PR12MB6995.namprd12.prod.outlook.com (2603:10b6:806:24e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.16; Thu, 4 Jun 2026
 14:15:24 +0000
Received: from SN1PEPF000397B4.namprd05.prod.outlook.com
 (2603:10b6:806:3c3:cafe::8e) by SA1P222CA0159.outlook.office365.com
 (2603:10b6:806:3c3::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.8 via Frontend Transport; Thu, 4
 Jun 2026 14:15:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF000397B4.mail.protection.outlook.com (10.167.248.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Thu, 4 Jun 2026 14:15:24 +0000
Received: from mkmvskvorts01.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 4 Jun
 2026 09:15:23 -0500
From: Victor Skvortsov <victor.skvortsov@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Tao.Zhou1@amd.com>,
 <Jeffrey.Chan@amd.com>
CC: Victor Skvortsov <victor.skvortsov@amd.com>
Subject: [PATCH] drm/amdgpu: Disable ras_check_bad_page_status on VFs
Date: Thu, 4 Jun 2026 10:14:49 -0400
Message-ID: <20260604141450.372045-1-victor.skvortsov@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B4:EE_|SA1PR12MB6995:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f7c1d96-0539-4369-eca8-08dec243b853
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|1800799024|376014|5023799004|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: dfJV/powG1Wx02IgGvgjCWlVotGdCmO1FaerGMXnfihGOa77z3Irue2JcU8ay+91KL8YcW05Auk9/sWvSCZs6vQgfTC7SXddczoT/Yi3bt/UW10vfZQpbBZ6MlLijp7Yboo91VJNvfwxvrKEN3IicuY1mH84lQ8AGJ9C/BsWEEkJa8cJDElE6igpNJ1/Nu3dGB4PWtWcllVptKfpPDHHtoaEqrfVEeZ81AlXLiS6tFxIe41pH7hGudD0RvbFgBzqk2kuOiJXnxsxXYR+vfSoOCSANz0MWH5uhSwZZyfNgj283xyd6z7SSe77UIs7098qPeO4nCpbmTBM3QVhDKEHsWZviyLDC6HvIbcmBmPWMemL0NlzKmSO1RrqTtxo0/FCESwrxVDfWmIIfhetGM5SwPz1njVyKyaMqIxdCQ+m9XrEnxhVV6uFUmrIxtnGDMjYxe40BPy32Pp0MZ8yEGF7zE6Fo/ImiGGEesk/uxhywZvoYvdZnGAy41Wcl0+9goN0RMro6USBSGYtt0QehookwpC9W6AmPe1gvbQ/f6Xv+0k8048f2SzKB5zVI82AZBtUzhnv1Em7fw1GXMaYh0I1e5FLSZFY8uePHKMPesHkTQCVFJYZ4FbBfVJpAyfUDwdj+FOBuqm0mBjlfO3LR/etonfw6MnnBgxv1SXXvgICeLGu/WbSSD8sIP4flRKDdV6cCW5cdTXz7zC9kmKqABqvDXNaOd2DLzLb57xlJo5f97U=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(1800799024)(376014)(5023799004)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: FLmTBTQtjUFA4fE5Z85OpLOlETUTHucbo0Z47dRV26fKi9hhM/MmYk0Xv5GcM5r4CroDTjZMoDCfNHkP+hFg2TGm8GnKeqOrvTXqW1ObLEQbeEQ7M/EI5aWKQ7P7MwRuBqBpqX24E9bdsTQscktQE/zbyOVmRzCtiJEEukEWEYuqrzW8zAU7NaIPYreYoSL2bugkLycOVQz7J6R3GhJq6VCcLtsK7Hdk3G5VJwyruUZ97zmrKU5qw2AKssWNJhv+TeLuLzZe7wFOU41PK/9xyRsSKtwKoZ3ah1aC4o4FVHNAcggYyYKI7L6I1GSySzuKGJH6tIij3ohXJfrT9KnT4q2b48ep12lbhKY3rS2SWBHRYYE4+DnE+8x4cBQQ5W55nt9uKOBn3AkOFtqoUu8WmDXy9LoNLEprkIya4G5ztV5eQcv9laBdNPMPuORSJzcp
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2026 14:15:24.3655 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f7c1d96-0539-4369-eca8-08dec243b853
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000397B4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6995
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

Host driver determines the bad_page_status, not VF.
VFs do not have access to the EEPROM, and eeprom_init
is skipped. However, check_bad_page_status is called
outside of the eeprom_init sequence without any is_vf checks.

Add a return false in __is_ras_eeprom_supported for VFs, and use
that guard in amdgpu_ras_check_bad_page_status to prevent
incorrect access to un-initialized eeprom_control object.

Signed-off-by: Victor Skvortsov <victor.skvortsov@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
index b265b4d9053f..fca2b49bc13b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
@@ -159,6 +159,9 @@
 
 static bool __is_ras_eeprom_supported(struct amdgpu_device *adev)
 {
+	if (amdgpu_sriov_vf(adev))
+		return false;
+
 	switch (amdgpu_ip_version(adev, MP1_HWIP, 0)) {
 	case IP_VERSION(11, 0, 2): /* VEGA20 and ARCTURUS */
 	case IP_VERSION(11, 0, 7): /* Sienna cichlid */
@@ -1973,7 +1976,7 @@ void amdgpu_ras_check_bad_page_status(struct amdgpu_device *adev)
 	struct amdgpu_ras *ras = amdgpu_ras_get_context(adev);
 	struct amdgpu_ras_eeprom_control *control = ras ? &ras->eeprom_control : NULL;
 
-	if (!control || amdgpu_bad_page_threshold == 0)
+	if (!__is_ras_eeprom_supported(adev) || !control || amdgpu_bad_page_threshold == 0)
 		return;
 
 	if (control->ras_num_bad_pages > ras->bad_page_cnt_threshold) {
-- 
2.34.1

