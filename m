Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6A74C47422
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Jan 2024 14:35:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 47E4D10E82F;
	Thu, 18 Jan 2024 14:35:02 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2071.outbound.protection.outlook.com [40.107.212.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 319F510E81B
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Jan 2024 14:34:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FPfHyHlKG9xlW4+WEPa+14laA59HB+h2BtyjT2w2+unt+SPxkSQBRR1zEEQTabPFM7bkyxuqFf+gNSCptLmajyA0WtxPysPnyLj6SAspvvCNb9B8eDyVGzLmB17cQbdX4wOlXnUMQOAQQ+GViWqshor5PmngUquNMuFFmIV9CHJtk/EBBZuyS+t0dhEBz9NX1+ckQwIOwLciCDTR+esHC4laJ3pZoSqOlPYXrD/d23fKTZX+bqiR/zmD7oBVdMIVS/0w2sr7F+jzTtr2+kq8Z5b9OEgjCWnUTaXyWsCwrTxnKwrleUqsMYHAi5Zx4C6gJNa8F5PIhi3Ikdy1q49Z4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xsPZ62yr9y3u6lbqjsT1R9RpkQp6qD9uuATFdO9T8ug=;
 b=PQJNbYE/3lENGkMO5YNqXx62JCqHtdYGhQYesqqm4GaacjnZ3wpOZlTw0EFG04qjezxZZx1N0pwSiErdcF55CHkOHoZJYh5YswIXWNYqnOkAYCQY2ZgfpIZ6KTOdK0z727WuL/HgGs2BN+gdoiBPIcI20W83BUd6V6wvj8E8/Mynm/LkCABXTv98WuoO9BcuSKwxuYthUYuh0LCejo/hNiWnmMrQx5Zwn9EWoh8ts+gOkssLyECVx3IWi1NDRJ5ra1MZzKLuLJ/mdI4yxlPLJ1K84G9x7fEquGHIXS5sy3jGYVXju5sKTh0aCB0Xcdj2BQsTFL7xtkqbfi89czh5OA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xsPZ62yr9y3u6lbqjsT1R9RpkQp6qD9uuATFdO9T8ug=;
 b=aBeWnYLXxkThbFAkFthHX0ePeuIDAciRJFY+UlfmuAI5lxaoiZ+PmaZZcdM7OVJoiB8ejOgc6sdX0pZRg5w99tTraLJi911LwRrhCdiV9AtORWQ/Xz/DEo47zSvV58PTJaKwNb5s9hSDCJptNeXBUqbe4gpvBWhse5seFTQGerw=
Received: from PH0PR07CA0114.namprd07.prod.outlook.com (2603:10b6:510:4::29)
 by BL0PR12MB4914.namprd12.prod.outlook.com (2603:10b6:208:1c4::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.24; Thu, 18 Jan
 2024 14:34:50 +0000
Received: from SN1PEPF0002529F.namprd05.prod.outlook.com
 (2603:10b6:510:4:cafe::63) by PH0PR07CA0114.outlook.office365.com
 (2603:10b6:510:4::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.24 via Frontend
 Transport; Thu, 18 Jan 2024 14:34:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SN1PEPF0002529F.mail.protection.outlook.com (10.167.242.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7202.16 via Frontend Transport; Thu, 18 Jan 2024 14:34:49 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 18 Jan
 2024 08:34:45 -0600
Received: from roman-vdev.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.34 via Frontend
 Transport; Thu, 18 Jan 2024 08:34:45 -0600
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 12/12] drm/amd/display: Promote DAL to 3.2.269
Date: Thu, 18 Jan 2024 09:34:00 -0500
Message-ID: <20240118143400.1001088-13-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240118143400.1001088-1-Roman.Li@amd.com>
References: <20240118143400.1001088-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529F:EE_|BL0PR12MB4914:EE_
X-MS-Office365-Filtering-Correlation-Id: faab8b11-d4f1-459d-6adb-08dc1832a083
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dcjb2TjOJTJ0ORejt1Ht3Q47jiI6cEBGjC3l5fNAHzDerePnuIPjyanK9b9l8iZsW9YKtj5QieayPru6nybkdidc5YKyqiyRcT02hYaSXuHPFLpzvYtj3FJsCKIeBymqqoPDcNcVxncvY4vGnMQ4hHQeaKJdvwPdYhugEkmO8GPUId0g2oG+g3hSgtqyQLVKw7f9BF3uiK9b+O1v3jsZPMh18b44bK6QbKh82V20dWOnZfnXhxi87Y3T8RyTJsXGcOdQGDMtYgX4Cugbh/ks7laQkt0x2WO/EBygz88kwV4ApFDEdv3Y8RPN4hu26RWeEgkYYKYjatzc0jb82a3Iuq9jdHKkZYWXP0BqRNdrVESQdSqH5GdiWu9ip0VgQOno/n7T8JhB3SXRyCjRXYEw6pqdXtsbViDXMCQ9O2BPuJvSaynwoD7RrRAyvAnIopHdTMCerjD7IfPkIEZ69Fv9H75CyqxSGyPAstKBojf6ZgSlnsQfd5o99Aa9gFHN9HhWkqBAdWhTgig/Eg0mh+gnbSSon3i9qYFoZf8xRkv4m+nZK7VrwjWgQ8DmakDm0ZEtYuuohQJAn1L1X9XiWHCBAxgn3y355LSeyo3n7ARspvPqmPqLPbJg0XvaQU+R5hRNoyKXAyZgdYgZw2G9oT5h85Hge3qiygTQBUvWcO4QeM/Myp1UY3jL1YJq9iDEfvAPjL3H/89gQ+Z/p7cuFe9PpOJ7nhZcVtF2oBvoiz/S2RVPhsKF8qqgm2SKfElzinfstw5Hvk0CgMvLMglfIFVTLw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(376002)(396003)(346002)(39860400002)(230922051799003)(186009)(451199024)(64100799003)(82310400011)(1800799012)(40470700004)(46966006)(36840700001)(40480700001)(40460700003)(7696005)(8936002)(83380400001)(1076003)(426003)(336012)(4326008)(8676002)(5660300002)(47076005)(6916009)(316002)(54906003)(70206006)(70586007)(6666004)(478600001)(26005)(2616005)(356005)(81166007)(82740400003)(2876002)(2906002)(4744005)(36756003)(41300700001)(86362001)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2024 14:34:49.9541 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: faab8b11-d4f1-459d-6adb-08dc1832a083
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002529F.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4914
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
Cc: Aric Cyr <aric.cyr@amd.com>, chiahsuan.chung@amd.com, Sunpeng.Li@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, jerry.zuo@amd.com,
 Aurabindo.Pillai@amd.com, hersenxs.wu@amd.com, wayne.lin@amd.com,
 Harry.Wentland@amd.com, agustin.gutierrez@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aric Cyr <aric.cyr@amd.com>

- FW Release 0.0.201.0
- Fix resizing video window for dcn321
- Fix timing bandwidth calculation for HDMI
- Fix null-deref in dml2 assigned pipe search
- Add GART memory support for dmcub
- Add power_state and pme_pending flag
- Add usb4_bw_alloc_support flag
- Revert "Rework DC Z10 restore

Acked-by: Roman Li <roman.li@amd.com>
Signed-off-by: Aric Cyr <aric.cyr@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index cb1899772426..8ef322b6c724 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -51,7 +51,7 @@ struct aux_payload;
 struct set_config_cmd_payload;
 struct dmub_notification;
 
-#define DC_VER "3.2.268"
+#define DC_VER "3.2.269"
 
 #define MAX_SURFACES 3
 #define MAX_PLANES 6
-- 
2.34.1

