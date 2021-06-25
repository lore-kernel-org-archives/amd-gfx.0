Return-Path: <SRS0=nR5r=LT=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF45AC2B9F4
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Jun 2021 08:13:11 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 860DE61425
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Jun 2021 08:13:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 860DE61425
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4960C6ECEB;
	Fri, 25 Jun 2021 08:13:11 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2060.outbound.protection.outlook.com [40.107.92.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EB58C6ECEB
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Jun 2021 08:13:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KrVfihqmXls8NGg8MuLwyeAhnlETx0zL3C+VC6zkGSbRDPcYqm9uT0R7tdQk6R+wEYaugblimwHmLdDTGiZrVkmrk8em2vEnfOTIQM8LnzoSc+9jZg39rNZRrHz1xQHevWf0bpaZxxNRYnyBNoD8Tv2POZ1STonyxgLj4Vg6r8CfGzsnuX1RV1Kr3ooaA6Z7xxc6+Bcg42TCdnwv5KAx7eL1iJcBzyO7zjq4Ima4lttqn+tsb0Khhpn9QxLJLREO/5pGH4FjPkKbq/Ha/zSgOEEjhtae8LrnYJg4FDaSqFb9Fny4/2IlskWOnIuTUgI9ImUvWXJ8YWlHkNsrfWAd3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=di0YQHixAAu8o7vGPOPAI9N5ySm4xmWiXeB95+6qqZE=;
 b=em2k+w+0mfqW/9qgJq9sMmC/60g8z9FnDuXUYVSplmZhPF4Teg8uEFXeeMqrrIkvQlv7HAhQPnXns7QOXUt3RCrSVuA5c/frItYBaxk6R3FJHNj7iu3c3MPvK/mmRtsLIH3YspymmDCTK4PSU9IY8X8MV8I71uQzsoB++poEfyJGifDaiJ14snKVEFeQmbqWmfIC+7K4Ts1ZvqwSe6qWSueXJeGTi9dSncLvxTpQHb8MXWvpM5pp8yrQgh6h1vq0Pi2HG70IrwONSC3SQKdLlaNbI3vq8jMIOm+XVw3+pkNIQqF9b5n/kMo8Vg1ree5nq5ICLal+3knfKjP5KR6Sug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=di0YQHixAAu8o7vGPOPAI9N5ySm4xmWiXeB95+6qqZE=;
 b=orBXNH7Q7ML+Kgh4rcn78K6LOkFnvDIoGOi5w2V3o1lkWO6egTiWPiHBEEMf4fWH92oxaPnIbaimkWeXYIV8kvOcspa4ZPjXlgwEYKV6ZbqjmNVMgAsZZRO512tQSgv8wsS7tjIpxjJICxExCBTWdOqt1uLWwhTFPAXSa/mR4rI=
Received: from DM5PR13CA0005.namprd13.prod.outlook.com (2603:10b6:3:23::15) by
 BN9PR12MB5308.namprd12.prod.outlook.com (2603:10b6:408:105::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.20; Fri, 25 Jun
 2021 08:13:04 +0000
Received: from DM6NAM11FT004.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:23:cafe::76) by DM5PR13CA0005.outlook.office365.com
 (2603:10b6:3:23::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.8 via Frontend
 Transport; Fri, 25 Jun 2021 08:13:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT004.mail.protection.outlook.com (10.13.172.217) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4264.18 via Frontend Transport; Fri, 25 Jun 2021 08:13:03 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Fri, 25 Jun
 2021 03:13:02 -0500
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] drm/amd/pm: bump DRIVER_IF_VERSION for Sienna Cichlid
Date: Fri, 25 Jun 2021 16:12:43 +0800
Message-ID: <20210625081243.978059-2-evan.quan@amd.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3da83a5d-cfac-4504-7ff0-08d937b10e4c
X-MS-TrafficTypeDiagnostic: BN9PR12MB5308:
X-Microsoft-Antispam-PRVS: <BN9PR12MB53087C09FACC03C5A50CBD0AE4069@BN9PR12MB5308.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:227;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DFtTSf1bv6WgEzA+g+CgRcxq/nG9uw/VszYP/+7H9B8V5w9Lq4jFy7ZpOX/GvuL8t8ZuAv2AEMWh5arFu0480ng/RWxrY7513JmF5ObzvKcEY/fljRzDUe/oW9TjPP0wUyjvBNwcJla1p5hxfWt+P9W/EkgxjGITeXUFYLpmgU4+GBfyWLfLI9M77QUwV5NoF+lh5PAxY2ZBYzBcNNMIIJ3k8Ly79COiEWwsNhYOQIF+I6HX3jvdS8zIHQ8FqRhWQ0C3WgjFTkqqwSIC6j2j0h7/3GNs7jSHr8JotXFOEECovxcSC94Bb+Gm5GVRi/iVN1KV95ByBOZMri5zw92AcWKwKzaSEycLFKk+TkBZPIC1gClbWmKg25Z4k/UKMACTwnXQgUXIJLbskUcmlnn/nRQa3bPx1DSYGyTPKKTcZZy45dOdigagT+jVSVKKp4KOQSi01CxYWceM0ESGieXU+OBgGeopFCFaKo/eR4onZjVl3Ph3nM42HIDaz9vRDim8fIgE0SAWdHkTuk1xcMMQuFRIcd6wrDQnLy9/dlKdE4J4IYNwaI3TwEUPdXW+VLdronW5XP7YwH125PVhywTtuqrQK04VBmoMOt6u2y3i2XTiL3xhU9K74Id0sJgP/AW6FHzbVN0zqx0Q1RY9NSKkrdNz8LmZQYEb/bvnnfhoz+I64TWK6GN0GalR18CZM/rWrKlY0QahNGosacWk3nzpLqHL8nZptfIh6VkesR3Ta+c=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(39860400002)(376002)(396003)(136003)(346002)(36840700001)(46966006)(86362001)(6916009)(478600001)(81166007)(2906002)(54906003)(4326008)(8676002)(356005)(83380400001)(336012)(47076005)(5660300002)(2616005)(6666004)(16526019)(82740400003)(36860700001)(426003)(186003)(316002)(70206006)(70586007)(36756003)(1076003)(7696005)(8936002)(82310400003)(26005)(44832011)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2021 08:13:03.7130 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3da83a5d-cfac-4504-7ff0-08d937b10e4c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT004.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5308
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
Cc: Alexander.Deucher@amd.com, Evan Quan <evan.quan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

To suppress the annoying warning about version mismatch.

Change-Id: I7dae1ef90ea3b09e1b378f96136b6ae61cc90696
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/pm/inc/smu11_driver_if_sienna_cichlid.h | 2 +-
 drivers/gpu/drm/amd/pm/inc/smu_v11_0.h                      | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/inc/smu11_driver_if_sienna_cichlid.h b/drivers/gpu/drm/amd/pm/inc/smu11_driver_if_sienna_cichlid.h
index 0b916a1933df..63b8701fd466 100644
--- a/drivers/gpu/drm/amd/pm/inc/smu11_driver_if_sienna_cichlid.h
+++ b/drivers/gpu/drm/amd/pm/inc/smu11_driver_if_sienna_cichlid.h
@@ -131,7 +131,7 @@
 #define FEATURE_GFX_EDC_BIT             49
 #define FEATURE_GFX_PER_PART_VMIN_BIT   50
 #define FEATURE_SMART_SHIFT_BIT         51
-#define FEATURE_SPARE_52_BIT            52
+#define FEATURE_APT_BIT                 52
 #define FEATURE_SPARE_53_BIT            53
 #define FEATURE_SPARE_54_BIT            54
 #define FEATURE_SPARE_55_BIT            55
diff --git a/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h b/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
index 1962a5877191..b89e7dca8906 100644
--- a/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
+++ b/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
@@ -30,7 +30,7 @@
 #define SMU11_DRIVER_IF_VERSION_NV10 0x37
 #define SMU11_DRIVER_IF_VERSION_NV12 0x38
 #define SMU11_DRIVER_IF_VERSION_NV14 0x38
-#define SMU11_DRIVER_IF_VERSION_Sienna_Cichlid 0x3D
+#define SMU11_DRIVER_IF_VERSION_Sienna_Cichlid 0x40
 #define SMU11_DRIVER_IF_VERSION_Navy_Flounder 0xE
 #define SMU11_DRIVER_IF_VERSION_VANGOGH 0x03
 #define SMU11_DRIVER_IF_VERSION_Dimgrey_Cavefish 0xF
-- 
2.29.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
