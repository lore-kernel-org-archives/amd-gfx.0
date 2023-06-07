Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5372FC7EE23
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Jun 2023 06:48:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6268D10E43C;
	Wed,  7 Jun 2023 06:48:33 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eae::601])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7B03B10E43C
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Jun 2023 06:48:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Utu1RHG83v9WMdC9TTsU8AbJ+cijsIjn8FsrM4BgVApa98q1DORljVRDguJjYUYHuSij00jfWK4JHNpHZUQrWCb/ZVElK2DJqlezWVG6zg9tIVyl0uSkyBKiGsetJScg2ylWvvVDaaQ9BEGjOwPzzqp1NC9XydjPHAT6sV2z6rHzdU9K2RLJiKqn3KvcV8hoRtFNOGgTOkeeyJtR4cg43CezVQp/F6Wx+dnp20bdrP6N2IfzkPJGnwpLhifj/UlJf8RclUC/74cIra+UuV0scJJNI1LR2GmGcFALB1sOPW9mVq7IyZQqyx0zoIMjuWhrb++xqiiOudaUT050qmekZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=anrq4Yp86+3PLeDx39OY9VHVqNdqzZA4hJ9HNRRQOjA=;
 b=dUDRJdS6jzdzTjG2bbHyYiWn/XcRgSX/uqPb6j9wqT6UOYrhWEgSav+dVpey0Uw75HtvCKU6B59VGH8ZvS4l4TZY2Va8qSAKfT/RbqeZmeRxwcWS/2fve95/Lyp4GI3M8CQBcvu0mnQXC82xcNxcdsC2waOGvzbE94CELE/3fi2BRvM7wlNEQ+Dt0k9ZYHDzhAZKY61ufzQU5702UeHTeIr7/J7VXr0r2MTXVRuKOwDYboWc4spiIWKtZHla25Iw/Jctay9fUzhRtLr1tid7Pl9syZsmljL6V4DXZBNT7Ll/PLGXE6vofDYVYG0Qg0/4OCv2iPc92YDvA9D6NrbIog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=anrq4Yp86+3PLeDx39OY9VHVqNdqzZA4hJ9HNRRQOjA=;
 b=zW2YdbyojAb79PDc4AuecATTtWsWXMmUEZyI3zW34b2CkKaZw9swU1a2B6xgWjXfKnbW3fjbdW7duykl7d7rWSYSkYpTBHWJPsohtUlPeXwozicXW8DdNTOWFaLbnk1LcM/YRctVJNMPw5/oyIkGBBZfa5C0KVzRIHt1mOHXTQE=
Received: from DM5PR07CA0103.namprd07.prod.outlook.com (2603:10b6:4:ae::32) by
 IA0PR12MB7652.namprd12.prod.outlook.com (2603:10b6:208:434::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6455.32; Wed, 7 Jun 2023 06:48:26 +0000
Received: from CY4PEPF0000EDD1.namprd03.prod.outlook.com
 (2603:10b6:4:ae:cafe::d5) by DM5PR07CA0103.outlook.office365.com
 (2603:10b6:4:ae::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33 via Frontend
 Transport; Wed, 7 Jun 2023 06:48:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000EDD1.mail.protection.outlook.com (10.167.241.205) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6477.13 via Frontend Transport; Wed, 7 Jun 2023 06:48:26 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 7 Jun
 2023 01:48:25 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 6 Jun
 2023 23:48:25 -0700
Received: from stanley-test.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Wed, 7 Jun 2023 01:48:23 -0500
From: Stanley.Yang <Stanley.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Hawking.Zhang@amd.com>,
 <Tao.Zhou1@amd.com>, <YiPeng.Chai@amd.com>, <Candice.Li@amd.com>
Subject: [PATCH Review 2/6] drm/amdgpu: Add RAS table v2.1 macro definition
Date: Wed, 7 Jun 2023 14:48:10 +0800
Message-ID: <20230607064814.27226-2-Stanley.Yang@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230607064814.27226-1-Stanley.Yang@amd.com>
References: <20230607064814.27226-1-Stanley.Yang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD1:EE_|IA0PR12MB7652:EE_
X-MS-Office365-Filtering-Correlation-Id: 09d258e9-761f-4ee6-e4eb-08db672331db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: K2XioCf5Nwo7x3GAgXnivdiQ5LYQtezoBWe7Mm+ZCaUDmNjtwRZ8NgxXBMNFR7Xt/IPVawpcOBYf9ZPUHzIbCTn9XRs3PF9a8yUPW+fm4IFHS4kEJm2xmQjoRJsR8w1p9qDA7/T2VicaaPf/ytUCtn3BNujiXGFIIpAqOaUIV9+x9IiqOHv+3mqrKGW7Ukwv8qywh8BE1lsyk7vvN1fP4jYL6TVD8L8zXrzsFW3yrDyYzAbjq8bZ0+g1pNS7xM0USHq0SeLSzJXnfqp6sZfTmguW+RKRdE1MKE5hOlSEuJ8EHiKRAWySm9DDiFZkHmeR5gqwy+zoPtUnrj486nSZ5lxAFcRNFxoR1C9vY7h4wM/oR/LpzjpU1V68TPamWv/z/SoGDg8lLm/qpZIiaMDfnCkQBihPX0AwWIsfM6I613lY5/mrduZdRP/HxnpTV/Ml52inLta3XnjieoBVFA/LCDQ1DpSN21XSPUBVjoMjmXW9Nd+IV2IjtjUAbryfLKY5n16cQpvjFi2POsIrLjSHfxjq2bNZ+SuNT+94Ip7sCHWFJ8mBXVGWOlxaurQeVCNrkp4QN8S71t63pc/vKd5l/znMk0mt3u9JWMg7EzpEPf8KrA0YAeaNxdeekUtEMb2E2zU7dwe9X6HDKfDufPUwWr6XHUykFiQaaf3dOqQkKpXeGksijFH7Puurgo7Q+Je5jJxB2I5NDFsm7saSNXUx7oE3AgaXdhFHtQRuRKCgyN3GKBANbG1Fu+hh+a/Wl0JqnJakKpk4MgoOnoOrrbwlS0SYTAV7A+a2yqBkW8IV+CDWKEGveHDfMaZdJBiNxIWX
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(396003)(39860400002)(136003)(346002)(451199021)(36840700001)(46966006)(40470700004)(47076005)(82310400005)(336012)(426003)(478600001)(110136005)(82740400003)(40480700001)(8936002)(8676002)(81166007)(356005)(316002)(70586007)(70206006)(4326008)(5660300002)(6636002)(40460700003)(41300700001)(86362001)(6666004)(7696005)(2906002)(36756003)(36860700001)(186003)(1076003)(26005)(2616005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2023 06:48:26.0130 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 09d258e9-761f-4ee6-e4eb-08db672331db
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7652
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
Cc: "Stanley.Yang" <Stanley.Yang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add RAS EEPROM table version 2.1 macro definition.

Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c | 13 +++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h |  1 +
 2 files changed, 14 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
index e9a848db3ff2..e835f68d1ebb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
@@ -80,6 +80,15 @@
 #define RAS_MAX_RECORD_COUNT    ((RAS_TBL_SIZE_BYTES - RAS_TABLE_HEADER_SIZE) \
 				 / RAS_TABLE_RECORD_SIZE)
 
+/* EEPROM Table V2_1 */
+#define RAS_TABLE_V2_1_INFO_SIZE       256
+#define RAS_TABLE_V2_1_INFO_START      RAS_TABLE_HEADER_SIZE
+#define RAS_RECORD_START_V2_1          (RAS_HDR_START + RAS_TABLE_HEADER_SIZE + \
+					RAS_TABLE_V2_1_INFO_SIZE)
+#define RAS_MAX_RECORD_COUNT_V2_1      ((RAS_TBL_SIZE_BYTES - RAS_TABLE_HEADER_SIZE - \
+					RAS_TABLE_V2_1_INFO_SIZE) \
+					/ RAS_TABLE_RECORD_SIZE)
+
 /* Given a zero-based index of an EEPROM RAS record, yields the EEPROM
  * offset off of RAS_TABLE_START.  That is, this is something you can
  * add to control->i2c_address, and then tell I2C layer to read
@@ -102,6 +111,10 @@
 #define RAS_NUM_RECS(_tbl_hdr)  (((_tbl_hdr)->tbl_size - \
 				  RAS_TABLE_HEADER_SIZE) / RAS_TABLE_RECORD_SIZE)
 
+#define RAS_NUM_RECS_V2_1(_tbl_hdr)  (((_tbl_hdr)->tbl_size - \
+				       RAS_TABLE_HEADER_SIZE - \
+				       RAS_TABLE_V2_1_INFO_SIZE) / RAS_TABLE_RECORD_SIZE)
+
 #define to_amdgpu_device(x) (container_of(x, struct amdgpu_ras, eeprom_control))->adev
 
 static bool __is_ras_eeprom_supported(struct amdgpu_device *adev)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
index 6d21cfdeffa5..069249249c76 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
@@ -27,6 +27,7 @@
 #include <linux/i2c.h>
 
 #define RAS_TABLE_VER_V1           0x00010000
+#define RAS_TABLE_VER_V2_1         0x00021000
 
 struct amdgpu_device;
 
-- 
2.17.1

