Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20BDFC46467
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Jan 2023 03:23:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6E76510E62F;
	Thu,  5 Jan 2023 03:23:34 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2050.outbound.protection.outlook.com [40.107.237.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4892010E62B
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Jan 2023 03:23:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ja7qP3tNXnS2/FMvLWQo1QeTVHSnIo6cmHkjro3QVlfgCF+o2HmlaGr0bFpG9zWcz4GiQ/bzH+6HR86PWSweiICmvwT1sTidfbP5LVTZD+t0eq9YhoAtBFfmxLjViU3Wme6C+2dnCTJgrB+2JA7WZExrRd9fIDJta5p0oCCliVXfsxn87dGDGta5QNJD7tO5J65LTl19s69Hw8uDlfXYhJQQAJsnyPDa79iUBK8klHt8z7Puiora6vp74oTi1iyiABzIdnGXZ8Jsqvx6FY8mDC2KcYljisBdE7XY0k00Cj3GKklLVQuaP2D7ruVUUeXJwFHnstaCtuNwZ9iFtmVMSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t4Wu9dBVl0JqjIOp09TWnjjBCCVc3SevWsafqO2fhiQ=;
 b=fenlLM7uJ1SGBZJK2b68/FKPbnJhr97C+GMClP6rNjYc2xSyHGjGLkyPwxtAjbKy27YySA3zMZ1DX3cBXE19A/wb5wGifK188524yuJnTTypQ0O4R+MutErJFSdje5V3nqtnoxJqz+vWIurfxV9gRxyiK0BkGVFe864O4n1FryynF/6j8/ldwVq4BaVtpU1NVj/f0CYEzoWpJwttpc/sDL3ZCEEeIFwILbkghpyH6AqFo1jo/f95M97ymB3R9I82/45ORVqT74Tlg/ffjlFQcju/ni/kj9K+sHOHWT2NH3vwTf/YqMGet27NEnVm3cceoRVh7yAzH2fw3tT2qm7wzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t4Wu9dBVl0JqjIOp09TWnjjBCCVc3SevWsafqO2fhiQ=;
 b=kTCvHiicU3v0jHQ9iOAt491QxFKyQbdWhiu/ob1GHwSLN0jKszkYK7mkvrgkwfsV4IzCThL77NLogYrK+oenXn0Ss4wVER70gcpaumvM1ZdqNIOEbAmFyOokdWtsKcPVPvoE40kjgZvdcaRmhveMcYi+EvOVhYSIwKsiqHqh4Do=
Received: from BN9P223CA0023.NAMP223.PROD.OUTLOOK.COM (2603:10b6:408:10b::28)
 by MW3PR12MB4396.namprd12.prod.outlook.com (2603:10b6:303:59::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Thu, 5 Jan
 2023 03:23:28 +0000
Received: from BN8NAM11FT084.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10b:cafe::89) by BN9P223CA0023.outlook.office365.com
 (2603:10b6:408:10b::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.14 via Frontend
 Transport; Thu, 5 Jan 2023 03:23:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT084.mail.protection.outlook.com (10.13.176.169) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5944.17 via Frontend Transport; Thu, 5 Jan 2023 03:23:28 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 4 Jan
 2023 21:23:26 -0600
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 7/8] drm/amd/pm: drop the support for manual fan speed setting
 on SMU13.0.0
Date: Thu, 5 Jan 2023 11:22:58 +0800
Message-ID: <20230105032259.2032789-7-evan.quan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230105032259.2032789-1-evan.quan@amd.com>
References: <20230105032259.2032789-1-evan.quan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT084:EE_|MW3PR12MB4396:EE_
X-MS-Office365-Filtering-Correlation-Id: 84c27032-55b1-4845-7967-08daeecc3674
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hAH3gFy7l1z17eCsZi30u80USA0xsr+g9EXVLgpEuUWuv+e2WiG57gXUWo3xOdlwDtIyKiUzL/8lVd+yUWawV5qlVbHSSRkMViO11id7sri4PYQKeP8R6/fHKYXOLIeP0tT6VB8wDvn6o090rM9/2IPRyOp5lsU0P06oK5igRHdDavziwWnwNC/OiD70sdB0pRs1aHovgxKiMBXxzMNM1hTOmU6DGC5WNULtebX+1WMrqDnzrpjSe/9ctzXJzszzbuDN7tlEagdE/smyO5iLnJ5yX4+udr2Aq7MlB4VMhFUsg6o/vDvVPmSiFfjsRXOpojowY4ofkw4slRoa7a/nY9M7LZcJcWPgPxoIzMfB/zsW33IBDyHf5LSNWZPTIymB5Cqf1ZseK4HC3xjqhxf9f11tT6Cx8JHpmh59uAeFwrado0AXFvPfx+9NO3fUjvw9Tf8WOwDps9FJX4pEGEIXLFiCOBU2K7ivj4yjZSYDWG3ah0+m08SH8xO1l/Oy0FloGskiYykRQ4rk6VCd0fmtDgS8MYTn6iwiBX0H8CWBfIjXU0RN12Ss6jWG9MmsCZBYwcVI8DXK7a/pn9phphGpYheN9PL2CUuuWx1R6D4oKh2CyHXjqIuKiaE+Iy17qmL7vLRuV9sPF+NuwZnwvWN0Uw7qsrdvP+z3/FhuzuS4elPm2ncd3SJ1yb44JX1VjTQodqufU31LwMPacpiqUWR3l8twIQUFZiD50qx4B1lbQu8=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(136003)(396003)(39860400002)(376002)(451199015)(40470700004)(46966006)(36840700001)(336012)(47076005)(426003)(6666004)(82310400005)(26005)(16526019)(2616005)(186003)(7696005)(40480700001)(40460700003)(86362001)(36756003)(36860700001)(356005)(81166007)(82740400003)(1076003)(8676002)(4326008)(41300700001)(2906002)(8936002)(44832011)(5660300002)(478600001)(70586007)(316002)(70206006)(54906003)(6916009)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2023 03:23:28.0219 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 84c27032-55b1-4845-7967-08daeecc3674
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT084.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4396
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Due to lack of support from PMFW.

Signed-off-by: Evan Quan <evan.quan@amd.com>
Change-Id: I5d466d3d521b26a484bd837e173b9b289d4020ec
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
index 75c9f510e713..59cd68862973 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
@@ -2061,4 +2061,9 @@ void smu_v13_0_0_set_ppt_funcs(struct smu_context *smu)
 					      BIT_ULL(AMD_SYSFS_IF_PP_DPM_DCEFCLK_BIT) |
 					      BIT_ULL(AMD_SYSFS_IF_PP_SCLK_OD_BIT) |
 					      BIT_ULL(AMD_SYSFS_IF_PP_MCLK_OD_BIT));
+	/* Drop the support for manual fan speed(RPM and PWM) setting */
+	smu->adev->pm.hwmon_if_attr_mode[AMD_HWMON_IF_PWM1_ENABLE_BIT] &= ~S_IWUSR;
+	smu->adev->pm.hwmon_if_attr_mode[AMD_HWMON_IF_PWM1_BIT] &= ~S_IWUSR;
+	smu->adev->pm.hwmon_if_attr_mode[AMD_HWMON_IF_FAN1_ENABLE_BIT] &= ~S_IWUSR;
+	smu->adev->pm.hwmon_if_attr_mode[AMD_HWMON_IF_FAN1_TARGET_BIT] &= ~S_IWUSR;
 }
-- 
2.34.1

