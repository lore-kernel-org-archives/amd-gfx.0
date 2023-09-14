Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C636CA553C
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Sep 2023 13:06:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0C22710E124;
	Thu, 14 Sep 2023 13:06:11 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2055.outbound.protection.outlook.com [40.107.94.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B3B2710E124
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Sep 2023 13:06:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KXf8D5YBt4nbVgiLb9Olafj/6/llkwgjAcbOz+V7kn3DxcfH7WBcfRoJHfU4AfIxyMZ1KUyXncpzR9aV6xqO121/pXTS5fpEQvYyT5tw/i7N2SHk2QSs+DxXoN4Py5FTL7mZ5gnKHQN8+aIeGwSnlMcVAOtj3LZD3agCE81plWYgfWyrgW0Tc43njfP55dT9vryfhNAMxzYNgI3U4CewCIqkCo5AijV62GnD/Igf0hhK2mtxE0oHi4Vl+KUpgk1TpTPyRK5SprWVfjcctLcRGHq+3CIfdyHdbQPQckRzJaDTEAg8UPv0/TmJ/aL39cddb6bGA+yOn6XR2j5FC72Bbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k/zWsTrKvm8Ej9KgLh3zK4g4Ta9TwA/hhEDNAXthMSw=;
 b=kCP13qfc/z5H91eNUcw2kXyKOmuj0mWcvPTwRc4U+K75p3A8Aj1643VybV6KEMSDGr6x2D32ym3fb0WLB/JmdXYXoaE1wGs86lzktIPwpCDxsZfL47ae08S0etGSdK0Q+aeijK1K/793cUjN3ZNaG3XQRqgJGq80VYIwcMHKh8s+i5hwlyctTeZhSwjkJ7keBvTKzgTdWiMLEWlKbgKntghxHBZg3mnKCPLNoE4vmKtLqCvZALZGP4aCE9qpfwXvYaRGJ7j5JFtSzMNOsHroritURqvJBQiNQGaQFiPUcQup0n5yd+rMgDmtvO8l8Te2iD+qTT6g2z7UFnqdLBA0Aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k/zWsTrKvm8Ej9KgLh3zK4g4Ta9TwA/hhEDNAXthMSw=;
 b=sk/2HcK1r3UF7a793J23EaK231g4uQQcBgLmUxdZt/2C35C6MDmEBF8qZqOVhDQ9g5TvkUnGo2hCAyiZSolW7sZzFC4xK3F+PfLkNGCRdNa3nQ8RNwzSG9SAefQHI4Q3H74uUfPn08rB4mQRhfJVQhWj6KsIib5t5eCDpkngsck=
Received: from MN2PR16CA0022.namprd16.prod.outlook.com (2603:10b6:208:134::35)
 by CH0PR12MB5268.namprd12.prod.outlook.com (2603:10b6:610:d3::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.20; Thu, 14 Sep
 2023 13:06:07 +0000
Received: from BL6PEPF0001AB78.namprd02.prod.outlook.com
 (2603:10b6:208:134:cafe::44) by MN2PR16CA0022.outlook.office365.com
 (2603:10b6:208:134::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.31 via Frontend
 Transport; Thu, 14 Sep 2023 13:06:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB78.mail.protection.outlook.com (10.167.242.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.20 via Frontend Transport; Thu, 14 Sep 2023 13:06:07 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 14 Sep
 2023 08:06:04 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/pm: Remove SMUv13.0.6 unsupported feature
Date: Thu, 14 Sep 2023 18:35:41 +0530
Message-ID: <20230914130541.1235831-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB78:EE_|CH0PR12MB5268:EE_
X-MS-Office365-Filtering-Correlation-Id: 47c87504-6f8c-4eeb-566a-08dbb5235bf6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tkGrNoiOkdkuaV1HTTWW4BXkxIGYmWv8MTIQl/jwSiok4oa1i5xVjGnd6/L4A6JbLGBhzWncVhViVdzZzXDA/huaGJosCedMUuq5s2b0J6Wp5peFxNQzYnQ3QEWS0sFHbAt93w+UEVOh4RtRyr10M4Sgqw34UCeDUwZw+RTx9C9qkHpkgqisictaBW6EKiQvmBKh3nhxB/4bRn65yQV9lbwhwk2TyQk3opDeTf5nvu3TeiIiTVvMvnPVKQxTlp0fREBwzFcDRxKSUmOKH3fk0+Jn70HJWKmKjOSQ2PBrbDI1LIV7E4KeGvu7Fy9jAwV4dgnBZbpmZd4EtgPpfwpLhfiDF8XpS/Gl++EapURW8h0jwbaUTmLvc9ct2rCmcXkOSAgNfbBw81S2MBiW22rcaUenT1QXqNqoOMaH8ZL5UUwvYDQ3ftd8hFuqYr0xNmZotVoWYphLdW1iB1o6qJUORbcxt5uonxoCBRSGNWHDzfzd3h40ZsF46SoOpWSLfO/hQbYXDN3fW9krV+LNzJFUe8ldMW5b0jTk+RogM1Y+g8+NpC+/rPuc3EyV4IF7lk7SP/J2a9lK5QT1+Zze7f81Lt6DDRNwYj5nwaQgU1jIWV8NZ3cXexKtL1Wk9IyxsDpxsPIfGb7GYUFcT/WnybWPNqQly2v41gIzIuiTIitZQGvhPLY1THfK4BxoFKxml/qfgiZJVgQg1EpcB/exG0JToIfAQze0zh3Z9jqZdha8oNLVgYurR5WYV70sO0krJWFZp2xOqTSzeuDgb02H/srjuA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(346002)(136003)(396003)(39860400002)(186009)(82310400011)(1800799009)(451199024)(46966006)(40470700004)(36840700001)(356005)(81166007)(7696005)(8936002)(4326008)(8676002)(82740400003)(6666004)(70586007)(70206006)(54906003)(6916009)(316002)(40480700001)(41300700001)(478600001)(40460700003)(83380400001)(36756003)(36860700001)(86362001)(2906002)(47076005)(44832011)(1076003)(2616005)(5660300002)(426003)(336012)(16526019)(26005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2023 13:06:07.4098 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 47c87504-6f8c-4eeb-566a-08dbb5235bf6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB78.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5268
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
Cc: Alexander.Deucher@amd.com, kevinyang.wang@amd.com, Asad.Kamal@amd.com,
 Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Selectively updating feature mask is not supported in SMU v13.0.6.
Remove the callback corresponding to that.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 94b0a7226ba4..4ba6790cac5a 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -2222,7 +2222,6 @@ static const struct pptable_funcs smu_v13_0_6_ppt_funcs = {
 	.allow_xgmi_power_down = smu_v13_0_6_allow_xgmi_power_down,
 	.log_thermal_throttling_event = smu_v13_0_6_log_thermal_throttling_event,
 	.get_pp_feature_mask = smu_cmn_get_pp_feature_mask,
-	.set_pp_feature_mask = smu_cmn_set_pp_feature_mask,
 	.get_gpu_metrics = smu_v13_0_6_get_gpu_metrics,
 	.get_thermal_temperature_range = smu_v13_0_6_get_thermal_temperature_range,
 	.mode1_reset_is_support = smu_v13_0_6_is_mode1_reset_supported,
-- 
2.25.1

