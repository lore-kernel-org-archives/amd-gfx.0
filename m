Return-Path: <SRS0=iwxs=L6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB5D2C07E96
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Jul 2021 06:46:08 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6DADF61964
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Jul 2021 06:46:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DADF61964
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 08DE4897F9;
	Tue,  6 Jul 2021 06:46:08 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2052.outbound.protection.outlook.com [40.107.92.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 62C73897F9
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 Jul 2021 06:46:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GBOXsoElAR2H4fWrtp8ffhwxvo1EnKNI6502d299S1ef7PhQq9Xz/nA2UDrFqHT/v7IlwdP0IvkyLX7a/W0U/Ygn413tog7OGjNm/BqJQ/OUltI0jh8u49djSqcH1G9kK95VGo65NDK/xtBUlUSOLylQZWdPQ6b98TFk/ORVGSHUgZ+4zK0DEx9BSHomsE/LOBnrRyd5R1nYlQQZj3FMUhKYz4jhCZYz8N1wjxsQIto2Eox/KXxkpk/ciuYbJMIxVh77lpCR9NbIICqF2JqoJ6U1PvWeDZ8wp1SGUGj9+O75ueNjqQKXkLvSA3zDwgiIbSpCzhG+fHBUAq0ajCfpEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=di0YQHixAAu8o7vGPOPAI9N5ySm4xmWiXeB95+6qqZE=;
 b=ayOHagdTTjRNsD1wjItoQlWyeKHk3q3dBAlrd0EXVomEHh7B3Ua5A5bIA0yty0V54BOYQx9wAMlguYtsfT62w4bsT01TDPSMtBtOMJODEDNm3g+heM4cTCUJoGjtLATi1WRPrQPf7/rkcJZiC//PF6D2gL9qNOm1B9Cg3xGfmDUAKLQULpPBeFqdqzDTzVnKb1iRVrdnhXZb/idCpIKndCY0t0VUPhIiDNI1nmMsdwCOG/PKiAMzWy8iWYwP4ykCNioNQSLYQVeP9iFtR4hOxYWeKC1uu4VbaXDNMDnuVMOyaEk6uWhGfd0O9W8AchUuJdlL27E4kbuh005/jyQTKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=di0YQHixAAu8o7vGPOPAI9N5ySm4xmWiXeB95+6qqZE=;
 b=3b10nY+16DhK7J3oBRjhtKLuAlBQON8v4lajrsH1mswX0h1kXBrWBkpdnuCT/ZMETEo/tVDitMbF38xnxbaNikOWIAELYL54kVw+e8aacTbiRO2wQa14kX8n22zPuidv9jvwZpTugObqkWxKBwwyvfegoREOGIfnj3Bnu/WHLFQ=
Received: from DM5PR19CA0049.namprd19.prod.outlook.com (2603:10b6:3:116::11)
 by MW2PR12MB2457.namprd12.prod.outlook.com (2603:10b6:907:10::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.23; Tue, 6 Jul
 2021 06:46:03 +0000
Received: from DM6NAM11FT048.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:116:cafe::83) by DM5PR19CA0049.outlook.office365.com
 (2603:10b6:3:116::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.22 via Frontend
 Transport; Tue, 6 Jul 2021 06:46:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT048.mail.protection.outlook.com (10.13.173.114) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4287.22 via Frontend Transport; Tue, 6 Jul 2021 06:46:03 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Tue, 6 Jul 2021
 01:46:01 -0500
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH V2 3/3] drm/amd/pm: bump DRIVER_IF_VERSION for Sienna Cichlid
Date: Tue, 6 Jul 2021 14:45:36 +0800
Message-ID: <20210706064536.123524-3-evan.quan@amd.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20210706064536.123524-1-evan.quan@amd.com>
References: <20210706064536.123524-1-evan.quan@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c125f63d-5adc-4b4a-d24c-08d94049b955
X-MS-TrafficTypeDiagnostic: MW2PR12MB2457:
X-Microsoft-Antispam-PRVS: <MW2PR12MB24576D04C9909621212EB925E41B9@MW2PR12MB2457.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:227;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1zPV5Hq4JpJJAB1M2iXHYYMziSjBWZRGYcxsYIaQE32l7zo2Dom1PtMObyBxMplEY62yTeJU/v1G5fLiJdA/P6ZoHW7a1/BMOZxlFw/kUyxWhPnnUEEXJsz6BmggG3QT9Sjb94qu5PgfBGxFAR7XLK0DlgQ4d5VYIpez7Ebx/vW3aasxYSrcbDW5EI/LjXCZD3/voEI9xPq535KRFpbpBawtLNLzsL8SivR1wuLtD2Xpv3X8+wZDC/WMtjmb9eeEKy3ktKLrc888hKBRRAQZ8GJOOQl7hboI5XmS4d7HJgjQ6aD/FIzUnN4dgPfdiobVt71AWuIssb3vAw9AS3mV2TK0xlhWQnlhG3QNNDn73Ryc+ez6H3svMQ0n65HSb1+ioTT/Ztv917hCXOnyjgturlxHVsnJXUrq4ju3x/V205VQXybyN6uM2F4IErvVqYNkW0+8XHNZh8al7/eQWNnpFbwQyLR0MifZ5l0SNpFS28mllExyvTgCEx2zUS7ZThURIcR4/wX0J2VYC2HUmQChEkmdp56V1PN7Uxh62tN8sat6GGFA95uXOIK2o1BFv4uZeXqJJl887pGOB6ZBWO2ODZbUbbTJ52OoDIsV2N69ApDOAXg5VgwxCwQOruiOYKJ52SLXfzrLuDZcMCLPM35bN79HmXJ726DqGF6MTdrtqlOW3FIqdfODzovgggNaGKha6EUC1AJKMbxlq6hBI9ObsuSkoCTp0AHkvo3/hdBxfwI=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(396003)(376002)(346002)(39860400002)(136003)(36840700001)(46966006)(2616005)(2906002)(86362001)(83380400001)(6916009)(478600001)(5660300002)(81166007)(356005)(44832011)(336012)(8936002)(426003)(1076003)(316002)(8676002)(186003)(16526019)(70206006)(70586007)(36756003)(54906003)(6666004)(26005)(82310400003)(7696005)(4326008)(47076005)(82740400003)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2021 06:46:03.4826 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c125f63d-5adc-4b4a-d24c-08d94049b955
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT048.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2457
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
Cc: Alexander.Deucher@amd.com, Lijo.Lazar@amd.com,
 Evan Quan <evan.quan@amd.com>
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
