Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFFECC7EE22
	for <amd-gfx@archiver.kernel.org>; Tue,  9 May 2023 08:02:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5E98B10E349;
	Tue,  9 May 2023 08:02:21 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2073.outbound.protection.outlook.com [40.107.93.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4F09B10E349
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 May 2023 08:02:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qtzalh8YhBpRXylw0226FAtpZI+c97l+dfP+ZWPG3Z5EnYe619PgJ+vgAongcj5D3NivMU/ZBBr2TwF397d+YyQod5SCQZ4Xn7nsWbx2Cjnk1CtjZMTeGkzoSZpIGj9MdZx3FxWYn2LgH3ptM1Zu8cxV6ZR9AZcYGjNPSm2w7vAUg2sOgvVu0zEJetmFLfUCdyi0OEANCs6XU+C3adnf6HxSgGPQ9COs5wtnS5uigntef0f0jVZhG3y3da35CbfVbxYJ7dayJNRDSsfT/KAPTb7bAoRLoBum9L8zK/TvY5LzczUDTmrS6E0xQtz2QswbBG6Casran99fmBDXMquWbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3yGzoxHnmt4ZaMBpIlyNyOzDXH5JlgV0cH3T7OQVXYs=;
 b=ivnb3cB1ZsEvicQqQsEfxvuj/fPYW069FcMIJeXstZbZf5BPVLWnfeGlvLco2ifbYuIs/kgL8fAuPWxq4J8ErsOlTH7QEUulTBigr7jEOS2lTQb+brFE02MyHUklddGNxQ1kPohmPv+cvOEy6WDLc4WEm88+upTU54ab4MmdLArcEZR/iQ77EdeYmqXC7Lf2D9uGYNEmW73gYo7KL22Oopi4k/PUFNmc5exXhz3ANfdDqDwV4U8s/aWjW0fUJJV3G++C0XZKS//IE8S+K670FhsxAdpxgStXtc6BKL0L0mJlSxSyMxZzJyF1ORY17Qi73doylUylX7MdtBOciwUphQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3yGzoxHnmt4ZaMBpIlyNyOzDXH5JlgV0cH3T7OQVXYs=;
 b=bZWUZjjJkqHlkQL6tJjOjuuU2gYd8EZY7vRHdrX/smi1FB5LBSX7dMsJUBCUB5LPPyFSo+YymkNgvRqpOXm+FmT3nn779D4qa0p0jUPVjGcCa00455jhFHZzLJLVSPHpYfy6y9ZXthp3L//om30+saoARBWcxl5V110vAQp1qB8=
Received: from BN7PR02CA0032.namprd02.prod.outlook.com (2603:10b6:408:20::45)
 by SN7PR12MB7811.namprd12.prod.outlook.com (2603:10b6:806:34f::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.32; Tue, 9 May
 2023 08:02:15 +0000
Received: from BN8NAM11FT092.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:20:cafe::fe) by BN7PR02CA0032.outlook.office365.com
 (2603:10b6:408:20::45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.33 via Frontend
 Transport; Tue, 9 May 2023 08:02:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT092.mail.protection.outlook.com (10.13.176.180) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6387.18 via Frontend Transport; Tue, 9 May 2023 08:02:15 +0000
Received: from guchchen-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Tue, 9 May 2023 03:02:09 -0500
From: Guchun Chen <guchun.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <alexander.deucher@amd.com>,
 <hawking.zhang@amd.com>, <lijo.lazar@amd.com>, <evan.quan@amd.com>
Subject: [PATCH v3] drm/amd/pm: avoid potential UBSAN issue on legacy asics
Date: Tue, 9 May 2023 16:01:53 +0800
Message-ID: <20230509080153.2169783-1-guchun.chen@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT092:EE_|SN7PR12MB7811:EE_
X-MS-Office365-Filtering-Correlation-Id: e8f22c81-c26c-4a06-c1f4-08db5063b3d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CyMwoLIeop8AEY6eUEnpvI9kfYhCkS8Ot9SDnT3BBxU5KUdQhsABnBOMgj29BUAWvEK2TdNRcx5AegCTab0AxyDVfhZHzDdrAD98BfYeqrrrahGREvXdxX9IW461oKQcpdQrklwUcRZa32iHI4p5GX5bSyfeCbSkKaK/Gp8sO/9Vh5c/RrVvqxlUhmhEL0fi8K+o3EnnKIIVP293ow3C7hN+Lof9d6PEGjFZs2LVdNpyHE6ecvAwIgiorHd1jJ5PF2pyoTjTtJuBuS5IwoJIHFyxtEmfKJ+Nzy61cCwauVWLtRry91O8AlyavKQxqFiOwfmUPmrBcqh9ZOIQKQvd1y+XacJSoQp7CZR5ZuCap7FRBA2JdK9SccwiCCDqPgGiKrvOCHIwJSwbRyUp4wAkSV4jHGs1JmnIcqO1icwmufJMY1J93cpXrpDh3tklR6NKwJqFdaw0W86YydzaKIy825PYnnBT8wdsME0VV7ht8NjuqFuoYJ8QtCK8q+KD1ZydlvmXk7mgStnHGMNlKuZmEfoDHKNzJBkttCnrk/9VaTAhchtp8N8FqhSq1IWYoA41eFGdTIN5VXfO6KaRUGihZup1a/HZ5Ccqk+BpdkD5DwCLP/2nrlcvv1+31MP4SrpPAfrqdliTZf6OLufHwGtWM8JtdiPtmkph8rgTtzEFJwr7t6S3HcNQjyK/Azl+vMOtTk6Z3fqI5eyBxx6YzZz0P+KwOmsLfYWopnFlASlV2Hj/ZSWARSYpUrlkOL00Yz4x
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(346002)(376002)(396003)(39860400002)(451199021)(36840700001)(46966006)(40470700004)(2906002)(316002)(110136005)(478600001)(41300700001)(8676002)(8936002)(16526019)(44832011)(6666004)(4326008)(70206006)(5660300002)(6636002)(70586007)(47076005)(26005)(1076003)(82740400003)(186003)(40460700003)(7696005)(356005)(36756003)(2616005)(36860700001)(426003)(336012)(83380400001)(40480700001)(82310400005)(86362001)(81166007)(2101003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2023 08:02:15.2121 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e8f22c81-c26c-4a06-c1f4-08db5063b3d9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT092.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7811
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
Cc: Guchun Chen <guchun.chen@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Prevent further dpm casting on legacy asics without od_enabled in
amdgpu_dpm_is_overdrive_supported. This can avoid UBSAN complain
in init sequence.

v2: add a macro to check legacy dpm instead of checking asic family/type
v3: refine macro name for naming consistency

Suggested-by: Evan Quan <evan.quan@amd.com>
Signed-off-by: Guchun Chen <guchun.chen@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_dpm.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
index 86246f69dbe1..078aaaa53162 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
@@ -36,6 +36,8 @@
 #define amdgpu_dpm_enable_bapm(adev, e) \
 		((adev)->powerplay.pp_funcs->enable_bapm((adev)->powerplay.pp_handle, (e)))
 
+#define amdgpu_dpm_is_legacy_dpm(adev) ((adev)->powerplay.pp_handle == (adev))
+
 int amdgpu_dpm_get_sclk(struct amdgpu_device *adev, bool low)
 {
 	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
@@ -1467,8 +1469,11 @@ int amdgpu_dpm_is_overdrive_supported(struct amdgpu_device *adev)
 	} else {
 		struct pp_hwmgr *hwmgr;
 
-		/* SI asic does not carry od_enabled */
-		if (adev->family == AMDGPU_FAMILY_SI)
+		/*
+		 * dpm on some legacy asics don't carry od_enabled member
+		 * as its pp_handle is casted directly from adev.
+		 */
+		if (amdgpu_dpm_is_legacy_dpm(adev))
 			return false;
 
 		hwmgr = (struct pp_hwmgr *)adev->powerplay.pp_handle;
-- 
2.25.1

